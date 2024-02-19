Return-Path: <linux-kernel+bounces-71209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AB785A1FD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4078928174F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1692C2C1BC;
	Mon, 19 Feb 2024 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YyF3YEdU"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D2F2C6AA;
	Mon, 19 Feb 2024 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342336; cv=none; b=b8lb/vNG1BYXK+1Ed1cLmYIZFP5bWx0Xy/Bue78LgXit0yhzR/vYfoWdoaM8cSBWA5HFYObYxslt+7b48UIMXyMYy5ptALQF6cB3F6ip3mB7ua9lb7T0hASBln6IiNxlHQJNp/JhYTE86eAdyEDNHHUwH1h0CjHRYrPFcFXiR30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342336; c=relaxed/simple;
	bh=GX1gehkvQcZqiJUoO8NQAFdj6CmJo/860fgT0JsK+xc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X50V2oBZpqFkF5vrXZap3wiBlFZdhUA88O2UMNNI/PCTa0ynmEzHqkEhM0gVG2jCiZ2F/bWMJn+CxWUVvWGim+DCP5ls+o7Bc6cx6xQdQx9arnD2BIgOewYghlOPEWPhv0gtuUey0LMkY1sxZFql+QYnQz0o2xfDyFToW6rqrig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YyF3YEdU; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41J8OEHj003549;
	Mon, 19 Feb 2024 11:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=v5j29fJ7l64OqdiJXkSFRWQ/MC7+s+gIo0U3PRJ4NMc=;
 b=YyF3YEdUJlI/zvbUNqlTqrMOBAcQXC9OGdlHX7e7yELOTHI937sRzZODYODPwZBoNRgx
 P2GKUZg5J1AUSxPPZTkaqnMWcMvec/zoFJotTipaOetUzE6baUbADzA//nQct/M2s76f
 oQ62N74MX6IN2Hs9x691XIKe16YavW+w0l/KcUqKbZERameaIK2Zij/FKiUJjloYAckJ
 rPii4UVjhgoAC2oGA5pg6NGCUmExLRC7xRySG/2Y6MGICH5aLxy/W0lGZ6LUSfDJCc+e
 XjR/2foeOITChbMYgaYcbA/EbVukkCiwYi0w75iIHb0yBEQYMHSWnOh2LMW5jG6FFgzP qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamucux4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 11:31:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JAgSXA026745;
	Mon, 19 Feb 2024 11:31:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8613a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 11:31:52 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JBVpdf035718;
	Mon, 19 Feb 2024 11:31:51 GMT
Received: from pkannoju-vm.us.oracle.com (dhcp-10-166-182-179.vpn.oracle.com [10.166.182.179])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wak86137v-1;
	Mon, 19 Feb 2024 11:31:51 +0000
From: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
To: j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
        manjunath.b.patil@oracle.com,
        Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Subject: [PATCH RFC] bonding: rate-limit bonding driver inspect messages
Date: Mon, 19 Feb 2024 17:01:40 +0530
Message-Id: <20240219113140.4308-1-praveen.kannoju@oracle.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_08,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190086
X-Proofpoint-GUID: gsMGlaCbH5kmokcPbzOv_nYPMMHiTG0b
X-Proofpoint-ORIG-GUID: gsMGlaCbH5kmokcPbzOv_nYPMMHiTG0b

Through the routine bond_mii_monitor(), bonding driver inspects and commits the
slave state changes. During the times when slave state change and failure in
aqcuiring rtnl lock happen at the same time, the routine bond_mii_monitor()
reschedules itself to come around after 1 msec to commit the new state.

During this, it executes the routine bond_miimon_inspect() to re-inspect the
state chane and prints the corresponding slave state on to the console. Hence
we do see a message at every 1 msec till the rtnl lock is acquired and state
chage is committed.

This patch doesn't change how bond functions. It only simply limits this kind
of log flood.

v2: Use exising net_ratelimit() instead of introducing new rate-limit
parameter.

v3: Commit message is modified to provide summary of the issue, because of
which rate-limiting the bonding driver messages is needed.

Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
---
 drivers/net/bonding/bond_main.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4e0600c..e92eba1 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2610,12 +2610,13 @@ static int bond_miimon_inspect(struct bonding *bond)
 			commit++;
 			slave->delay = bond->params.downdelay;
 			if (slave->delay) {
-				slave_info(bond->dev, slave->dev, "link status down for %sinterface, disabling it in %d ms\n",
-					   (BOND_MODE(bond) ==
-					    BOND_MODE_ACTIVEBACKUP) ?
-					    (bond_is_active_slave(slave) ?
-					     "active " : "backup ") : "",
-					   bond->params.downdelay * bond->params.miimon);
+				if (net_ratelimit())
+					slave_info(bond->dev, slave->dev, "link status down for %sinterface, disabling it in %d ms\n",
+						   (BOND_MODE(bond) ==
+						   BOND_MODE_ACTIVEBACKUP) ?
+						   (bond_is_active_slave(slave) ?
+						   "active " : "backup ") : "",
+						   bond->params.downdelay * bond->params.miimon);
 			}
 			fallthrough;
 		case BOND_LINK_FAIL:
@@ -2623,9 +2624,10 @@ static int bond_miimon_inspect(struct bonding *bond)
 				/* recovered before downdelay expired */
 				bond_propose_link_state(slave, BOND_LINK_UP);
 				slave->last_link_up = jiffies;
-				slave_info(bond->dev, slave->dev, "link status up again after %d ms\n",
-					   (bond->params.downdelay - slave->delay) *
-					   bond->params.miimon);
+				if (net_ratelimit())
+					slave_info(bond->dev, slave->dev, "link status up again after %d ms\n",
+						   (bond->params.downdelay - slave->delay) *
+						   bond->params.miimon);
 				commit++;
 				continue;
 			}
@@ -2648,18 +2650,20 @@ static int bond_miimon_inspect(struct bonding *bond)
 			slave->delay = bond->params.updelay;
 
 			if (slave->delay) {
-				slave_info(bond->dev, slave->dev, "link status up, enabling it in %d ms\n",
-					   ignore_updelay ? 0 :
-					   bond->params.updelay *
-					   bond->params.miimon);
+				if (net_ratelimit())
+					slave_info(bond->dev, slave->dev, "link status up, enabling it in %d ms\n",
+						   ignore_updelay ? 0 :
+						   bond->params.updelay *
+						   bond->params.miimon);
 			}
 			fallthrough;
 		case BOND_LINK_BACK:
 			if (!link_state) {
 				bond_propose_link_state(slave, BOND_LINK_DOWN);
-				slave_info(bond->dev, slave->dev, "link status down again after %d ms\n",
-					   (bond->params.updelay - slave->delay) *
-					   bond->params.miimon);
+				if (net_ratelimit())
+					slave_info(bond->dev, slave->dev, "link status down again after %d ms\n",
+						   (bond->params.updelay - slave->delay) *
+						   bond->params.miimon);
 				commit++;
 				continue;
 			}
-- 
1.8.3.1


