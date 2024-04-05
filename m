Return-Path: <linux-kernel+bounces-133457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B2F89A3F7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067081C22157
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953D9172761;
	Fri,  5 Apr 2024 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n8w0w+lx"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4D3171E54;
	Fri,  5 Apr 2024 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712340992; cv=none; b=kJofTFN4j0ehYtDoZ4ngLTshRhdYwK+hV86+BiIAlYZFBAnQBSRAZBlJNZp5YakCwbf20RSyYJ/QBw0PuorXpyksQnISc82q/B7mDBXEKnd/siFwpIKz3H/je4XoHGx8KMmufGYiQoisBz/GzgB9QGHOZrI6AuzQZMko60LY4RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712340992; c=relaxed/simple;
	bh=VtFKK/jfhCsVbtST+JldzZDI92XQgK1NCBu0q2Y5DdM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FST4V0SMRF4+Y5uepvU9XLKlxoAREYFydPvqgV9MBymfSBAMTEI8JnmPgEx99lbnrqgN04sxhvm8ZikfmgySoRAWEejLxqPz6Lt+VDsdUMlSYZCSo4/mvf6vOO+iv+Tw6rvqSJce458bK0jJi2jrCrKFgX1Evn62IaeBtTuJR/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n8w0w+lx; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 435F3kqk013276;
	Fri, 5 Apr 2024 18:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=EWs5UJY2oRvMOI8RouVDl15Ag8zcxUtHlmybtttZUqw=;
 b=n8w0w+lxlHPS98Ui55V0aJrMYq4QJr3PN5lu5GtEimFwTJSuMY3PHH6qoEZ83NWOA4rQ
 7vEFjzTJuvYIePtcTuLfSvrCTALHJZyNajpSbMnrSb8jN3KRtXHpDgMG49Ije9ttBhZV
 6JMndJNhhZpXCEHjdMAfPDFY+EJivRCXFP6uJmfeSpLLXUrUb6ArzgHrHB+YQPLilIvA
 5S9mUcSyqsm5xdHYwrxnXSljBXGmWsZdtWclx2qWPcdOAgiPdMTWaZnjKe8ATpjHk29f
 sVJ6aLPZoBy5TPByeTBXesFuHSXwn4fAR9eVrdpJbWOi1AB/9JGmEF+RXU41k18BM8LB 8w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9euy4332-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 18:16:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 435H24hc039368;
	Fri, 5 Apr 2024 18:16:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emsxhfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 18:16:24 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 435IEvBe036160;
	Fri, 5 Apr 2024 18:16:23 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x9emsxhf0-1;
	Fri, 05 Apr 2024 18:16:23 +0000
From: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
To: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maheshb@google.com, edumazet@google.com, kuba@kernel.org
Cc: gia-khanh.nguyen@oracle.com
Subject: [PATCH net-next v2] ipvlan: handle NETDEV_DOWN event
Date: Fri,  5 Apr 2024 11:16:12 -0700
Message-Id: <1712340972-13643-1-git-send-email-venkat.x.venkatsubra@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404050128
X-Proofpoint-ORIG-GUID: -OZSUsglpzX1hdjzRnptRf7Sp-d6cUGc
X-Proofpoint-GUID: -OZSUsglpzX1hdjzRnptRf7Sp-d6cUGc
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

For macvlan the handling of NETDEV_DOWN event was added in
commit 80fd2d6ca546 ("macvlan: Change status when lower device goes down").

Reported-by: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Signed-off-by: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 5920f7e63352..094f44dac5c8 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -735,6 +735,7 @@ static int ipvlan_device_event(struct notifier_block *unused,
 
 	switch (event) {
 	case NETDEV_UP:
+	case NETDEV_DOWN:
 	case NETDEV_CHANGE:
 		list_for_each_entry(ipvlan, &port->ipvlans, pnode)
 			netif_stacked_transfer_operstate(ipvlan->phy_dev,
-- 
1.8.3.1


