Return-Path: <linux-kernel+bounces-126073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128368931BC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80729B21571
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9D7144D28;
	Sun, 31 Mar 2024 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mPReHE0s"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4465D1448E7;
	Sun, 31 Mar 2024 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711892600; cv=none; b=QfddTn5Y2+Gy7oxy9Eh6coONBuehuwpcKijcrWdXzjyw3IvzkdApygK4o9R9a6Ad2acORWn3E9bwSuF26cswHKhRv/lqhORfmP49EogJjk8d9Q4MR1yuPr72lYZrg7mAB0TBnftp2M5CB/g2EItPhpTzWe3z7ufMqAdJ7kVXhlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711892600; c=relaxed/simple;
	bh=MkdaKb4qHJkhS61XwadV5690O6wJn+JFemI2MEUTXA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ch/ziUUyrxgsf/BBZ8g8TlhOagzhX4UHuQLVfZkZ6gEjgwk6Gr8l2evcHveFbZJXQazwyU3L+6CKsQJ6DXykCSLeivqpKGMfXi6VXoWbOyyTQ1ow2Vkiew3j1s6Zg/io+/mGtRbfNm1Wc0+X7GcG6yW2ysBR3bbaJjNY1e7Qkno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mPReHE0s; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42VBU6le011285;
	Sun, 31 Mar 2024 13:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=VpDCM4kXBDfZ34ImDbRFr6GsrqscQ4YvD3isy+p8lVw=;
 b=mPReHE0sTu2y95dHjKfSZuOiB2phYDbbn/e6OjLYPdLTbetgR0LjAcF/yZpAhhvH5VKy
 2F+nL46mP8vXd9sDy3cPrvx9Il6soMmkvQpq6HEja/ZqaMYBs7X7pYst9s2G/wzsOT/M
 gyXD2YUjVXRt2FJUz+/MSSQwjcJ67C6jKWU+mcPbgP9zXEWF8PVkwHkYoR4GmXUYBYeU
 8/yxRiI2Z3BrMgB4x791/kissi8+sBzxXJNDaF1DQQZ1O6YgXsBdhuuFXr2Kzmvp/ufy
 /VOMZ1v2ddy3UWa9/XavGzD/NSr75Gcys4/LvGN2WVJqDL9disPKeKhNhOAqGFJBmGin vw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x6asd94sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Mar 2024 13:43:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42VAht50040758;
	Sun, 31 Mar 2024 13:43:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x6964hh0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Mar 2024 13:43:13 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42VDgxX5015876;
	Sun, 31 Mar 2024 13:43:12 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3x6964hgud-2;
	Sun, 31 Mar 2024 13:43:12 +0000
From: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
To: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maheshb@google.com, edumazet@google.com
Cc: gia-khanh.nguyen@oracle.com
Subject: [PATCH net-next] ipvlan: handle NETDEV_DOWN event
Date: Sun, 31 Mar 2024 06:41:29 -0700
Message-Id: <1711892489-27931-2-git-send-email-venkat.x.venkatsubra@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1711892489-27931-1-git-send-email-venkat.x.venkatsubra@oracle.com>
References: <1711892489-27931-1-git-send-email-venkat.x.venkatsubra@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-31_10,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403310104
X-Proofpoint-ORIG-GUID: KlfKMloctrHBp_joChrF6zp0YWtaFY-P
X-Proofpoint-GUID: KlfKMloctrHBp_joChrF6zp0YWtaFY-P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In case of stacked devices, to help propagate the down
link state from the parent/root device (to this leaf device),
handle NETDEV_DOWN event like it is done now for NETDEV_UP.

In the below example, ens5 is the host interface which is the
parent of the ipvlan interface eth0 in the container.

Host:

[root@gkn-podman-x64 ~]# ip link set ens5 down
[root@gkn-podman-x64 ~]# ip -d link show dev ens5
3: ens5: <BROADCAST,MULTICAST> mtu 9000 qdisc mq state DOWN
      ...
[root@gkn-podman-x64 ~]#

Container:

[root@testnode-ol8 /]# ip -d link show dev eth0
2: eth0@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9000 state UNKNOWN
        ...
    ipvlan mode l2 bridge
        ...
[root@testnode-ol8 /]#

eth0's state continues to show up as UP even though ens5 is now DOWN.

Reported-by: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Signed-off-by: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 5920f7e63352..724d660904a2 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -736,6 +736,7 @@ static int ipvlan_device_event(struct notifier_block *unused,
 	switch (event) {
 	case NETDEV_UP:
 	case NETDEV_CHANGE:
+	case NETDEV_DOWN:
 		list_for_each_entry(ipvlan, &port->ipvlans, pnode)
 			netif_stacked_transfer_operstate(ipvlan->phy_dev,
 							 ipvlan->dev);
-- 
1.8.3.1


