Return-Path: <linux-kernel+bounces-74057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C67685CF69
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41087B22BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEC239ADD;
	Wed, 21 Feb 2024 05:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b6Ti8lA5"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F08829A1;
	Wed, 21 Feb 2024 05:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708492121; cv=none; b=Wu0DFLKF0C4O1RNqY7I/G2Pm68OoJV8gHFxCSNxt4QlrUfiE3HnDO5kwdrR4uMFMndzqZzsdOaWvq+4aRL8+OXwdObhvZhIKzu3rPYNG/zV5u91LN4kM9jznhauC2BHMmQnEVRhb/qIf8sJXby7bLZ0agSz1B3DWF4csysm8nGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708492121; c=relaxed/simple;
	bh=VKJ/Y4FNh1iyDSAXLsW/RzP2h2EOe4/G9T3wlsbJZOY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u5Jb/FFbw8veRRF2T5id/fp/YsszhqpkArLm2PgxE1vGTwfxZWp9xPVWd3512H3vRkEHe6hzDrSF306RNLL2YG4+U4M2Mq914QADjvIiXl166qhkx8OUPQ4aIE+hAe4kJ2G1qM1bcUrM2nLrcntcEBHyhPKhCOdvePYsC0SVDQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b6Ti8lA5; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KKT8AU006004;
	Wed, 21 Feb 2024 05:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=WulNQ77cw1AzM/OSoQ+njGNXHsFMEjxLNLfnhrUy/f4=;
 b=b6Ti8lA5DZ7j1En+/cAuM8jSRtXo0xf51/aPM/KFRM6/pPVLJzTEwH2N4Od0WWisE52q
 nUjS9vbJeDFqOEkH7Ln32d8Vaqg+yFceazixJF9+1eq2ZefPtBt1zxql3XtJTy4DdixG
 82nCD3TUVDIyI3W2JSsKnvEiTltCyHTFopMNHjmO1tAUB7H7tlpOsi9XG5F/Qz+MZnJ9
 fpJfRV/ITcFb56arpEPGTpwCr+1pxRmnTM5hZ1p8gd6ltEugWpM5ryeJ2Tl1hpjnhiBy
 7aZOC4pyf0NwsNk135upUEDIVOUVPeSMGNbq5YK/T2CRZh8ffE2iy2pGvB8H0i1O62GF Iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakd28tkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 05:08:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41L4ZPsb006609;
	Wed, 21 Feb 2024 05:08:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak88mym7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 05:08:26 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41L58Pvf007156;
	Wed, 21 Feb 2024 05:08:25 GMT
Received: from pkannoju-vm.us.oracle.com (dhcp-10-191-205-154.vpn.oracle.com [10.191.205.154])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wak88myj9-1;
	Wed, 21 Feb 2024 05:08:25 +0000
From: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
To: j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
        manjunath.b.patil@oracle.com,
        Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Subject: [PATCH net-next v5] bonding: rate-limit bonding driver inspect messages
Date: Wed, 21 Feb 2024 10:38:09 +0530
Message-Id: <20240221050809.4372-1-praveen.kannoju@oracle.com>
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
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210036
X-Proofpoint-GUID: 22x8LQVmlE1oHyN0t1rJYSA8NZNK_t7M
X-Proofpoint-ORIG-GUID: 22x8LQVmlE1oHyN0t1rJYSA8NZNK_t7M

Through the routine bond_mii_monitor(), bonding driver inspects and commits
the slave state changes. During the times when slave state change and
failure in aqcuiring rtnl lock happen at the same time, the routine
bond_mii_monitor() reschedules itself to come around after 1 msec to commit
the new state.

During this, it executes the routine bond_miimon_inspect() to re-inspect
the state chane and prints the corresponding slave state on to the console.
Hence we do see a message at every 1 msec till the rtnl lock is acquired
and state chage is committed.

This patch doesn't change how bond functions. It only simply limits this
kind of log flood.

Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
---
v5:
  - Redundant indentation addressed.
v4: https://lore.kernel.org/all/20240220050437.5623-1-praveen.kannoju@oracle.com/
  - Rectification in the patch subject and versioning details.
v3: https://lore.kernel.org/lkml/20240219133721.4567-1-praveen.kannoju@oracle.com/
  - Commit message is modified to provide summary of the issue, because of
    which rate-limiting the bonding driver messages is needed.
v2: https://lore.kernel.org/lkml/20240215172554.4211-1-praveen.kannoju@oracle.com/
  - Use exising net_ratelimit() instead of introducing new rate-limit
    parameter.
v1: https://lore.kernel.org/lkml/20240214044245.33170-1-praveen.kannoju@oracle.com/
---
 drivers/net/bonding/bond_main.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4e0600c..c8482cd 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2609,12 +2609,12 @@ static int bond_miimon_inspect(struct bonding *bond)
 			bond_propose_link_state(slave, BOND_LINK_FAIL);
 			commit++;
 			slave->delay = bond->params.downdelay;
-			if (slave->delay) {
+			if (slave->delay && net_ratelimit()) {
 				slave_info(bond->dev, slave->dev, "link status down for %sinterface, disabling it in %d ms\n",
 					   (BOND_MODE(bond) ==
-					    BOND_MODE_ACTIVEBACKUP) ?
-					    (bond_is_active_slave(slave) ?
-					     "active " : "backup ") : "",
+					   BOND_MODE_ACTIVEBACKUP) ?
+					   (bond_is_active_slave(slave) ?
+					   "active " : "backup ") : "",
 					   bond->params.downdelay * bond->params.miimon);
 			}
 			fallthrough;
@@ -2623,9 +2623,10 @@ static int bond_miimon_inspect(struct bonding *bond)
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
@@ -2647,7 +2648,7 @@ static int bond_miimon_inspect(struct bonding *bond)
 			commit++;
 			slave->delay = bond->params.updelay;
 
-			if (slave->delay) {
+			if (slave->delay && net_ratelimit()) {
 				slave_info(bond->dev, slave->dev, "link status up, enabling it in %d ms\n",
 					   ignore_updelay ? 0 :
 					   bond->params.updelay *
@@ -2657,9 +2658,10 @@ static int bond_miimon_inspect(struct bonding *bond)
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


