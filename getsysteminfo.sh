#!/bin/bash
####################################################################################################
#
# getsysteminfo.sh :: script use to fetch information (cpu, mem, RAM and other system information) from all group.
#                       This script facilitate bundle/zip the logs in monthly bases
#                       This script basically run once in EOD
# Revision History
# Dependancy      :     https://pypi.org/project/ansible-cmdb/            # Download tgz unzip it and use
# Date        Name              Reason
# ----        ----              ------
# 07-02-2020  Mohit Mehral     fetch system detail( cpu, mem, ip, lan, network) from ansible command. Ansible module required to use this.

###################################################################################################
#
#
BASE_PATH="/home/iansible/.ansible"
systemInfo="info_`date +%Y%m%d`"
if [ ! -d $systemInfo ];then
        echo " Base Directory not exists![$systemInfo]"
        mkdir $systemInfo
fi
#pass enviornment to below commend /etc/ansible/hosts

ansible test02 -m setup --tree $BASE_PATH/$systemInfo
ansible sit -m setup --tree $BASE_PATH/$systemInfo
# Ansible plugin which used to convert the json format to presentable html format

#HTML
/home/iansible/ansible-cmdb-1.30/ansible-cmdb -t html_fancy_split -p local_js=1 $BASE_PATH/$systemInfo/ $BASE_PATH/$systemInfo/

#CSV
/home/iansible/ansible-cmdb-1.30/ansible-cmdb -t csv $BASE_PATH/$systemInfo/  > $BASE_PATH/$systemInfo/overview.csv
mv $BASE_PATH/cmdb $BASE_PATH/$systemInfo/
#
#
#
#
echo " #################################################################################### "
echo ""
echo "open $BASE_PATH/$systemInfo/index.html and enjoy the day"
echo ""
echo " #################################################################################### "
#########################################################################################
