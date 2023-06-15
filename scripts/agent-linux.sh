#!/bin/bash
ossecAgent() {
sudo yum install unzip
sudo yum install gcc-c++ make -y
sudo yum install wget
sudo yum install -y php-cli php-common sendmail inotify-tools
cd /opt
ossec_server_ip=”1.1.1.1"
export VER=”3.7.0"
sudo wget https://github.com/ossec/ossec-hids/archive/${VER}.tar.gz
sudo tar -xvzf /opt/${VER}.tar.gz
cd /opt/ossec-hids-${VER}
sudo sed -i ‘2 i USER_LANGUAGE=$1’ install.sh
sudo sed -i ‘2 i USER_INSTALL_TYPE=$2’ install.sh
sudo sed -i ‘2 i USER_DIR=$3’ install.sh
sudo sed -i ‘2 i USER_AGENT_SERVER_IP=$4’ install.sh
sudo sed -i ‘2 i USER_ENABLE_SYSCHECK=$5’ install.sh
sudo sed -i ‘2 i USER_ENABLE_ROOTCHECK=$6’ install.sh
sudo sed -i ‘2 i USER_ENABLE_ACTIVE_RESPONSE=$7’ install.sh
sudo sed -i ‘2 i USER_ENABLE_SYSLOG=$8’ install.sh
sudo echo -ne ‘\n’ | sudo sh install.sh en agent /var/ossec ${ossec_server_ip} y y y y
sudo sed -i ‘12d’ /var/ossec/etc/ossec.conf
sudo sed -i ‘12d’ /var/ossec/etc/ossec.conf
sudo sed -i ’12 i <directories report_changes=”yes” check_all=”yes” realtime=”yes”>/etc,/usr,/var/log/</directories>’ /var/ossec/etc/ossec.conf
sudo sed -i ’13 i <directories report_changes=”yes” check_all=”yes” realtime=”yes”>/bin,/sbin,/proc,/dev</directories>’ /var/ossec/etc/ossec.conf
}
