Return-Path: <linux-kernel+bounces-72331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC8885B215
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D2F28274B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604B656B70;
	Tue, 20 Feb 2024 05:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E5BQ5Ip7"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99A21E484;
	Tue, 20 Feb 2024 05:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708405499; cv=none; b=RBfjw3D19HwvzbS10or4LGiCmdBhv8JsHELpYi5+nIrhzDUxgOzDy6KSz5TihXMxKkZFG3dTNblaHlJLXM9OWiTCf6rwk5rg8YNnDvPqrFJsU4NJN0Tvv5xUNRT7Rl25gXA1jyapwVSkXMGiVsdFAAz2LXU36Tex/emL8m0fe5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708405499; c=relaxed/simple;
	bh=fXxgjBeMehCHVmqIjXPL1DbttgIUptEZZ1Iy4U+8o5w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UYtU+5H/sR2mtk3r1rTat/LCbon+dXG4BmcTLAjC10yhggTZ+wNtc6BfmaJaLf7mZnHCFSKN8+HJaAMkg9z4AR5auJWn/1JlE/KiMOADtQWGsipjfwFYdRAo5FCoz76Ei5l55dBD4oU/WJERwd9H4Oqyazzww4VqZVjnSbDsX+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E5BQ5Ip7; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JMx8Vt027989;
	Tue, 20 Feb 2024 05:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=i29RdQt0ru/t4rJdnI7IzaMDbTWdBR2QUiUDt+zMPiM=;
 b=E5BQ5Ip7hFePuaHGkT0HghcwEHhF8nX4cGhptqrTIh9cL/m3m75jKbHsJzi3VtJ7cT4X
 Ci1zbQhZtOAtk9UfnuO4uRuiiSQsidX2jHVtWk12uoxk5c45H8lQiM/uaymrzagP0ary
 ziyVD8cM82qoKHY+1JtUrR6icCMeQFtqsATyCaN1JGiPW7NXpBRIKa4jd1jfDw4GfdbH
 WZeRj15pj64I+WdKd+hly/ys7d233gtmUDXzJdzwQa4mEuNnyuCTAX8qJsnYQul4p62P
 qLdl87dusp2yoF2V3rMUVUKequZMGA76SQOarO8UFMAfm2IAhLmJTvjUldvtTA2Av1/i 6g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk3wrh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 05:04:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41K3aUxK039804;
	Tue, 20 Feb 2024 05:04:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak86q9q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 05:04:46 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41K54jst035830;
	Tue, 20 Feb 2024 05:04:46 GMT
Received: from pkannoju-vm.us.oracle.com (dhcp-10-76-34-55.vpn.oracle.com [10.76.34.55])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wak86q9mh-1;
	Tue, 20 Feb 2024 05:04:45 +0000
From: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
To: j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
        manjunath.b.patil@oracle.com,
        Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Subject: [PATCH net-next v4] bonding: rate-limit bonding driver inspect messages
Date: Tue, 20 Feb 2024 10:34:37 +0530
Message-Id: <20240220050437.5623-1-praveen.kannoju@oracle.com>
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
 definitions=2024-02-20_04,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200034
X-Proofpoint-ORIG-GUID: TzsS8evtmGIZrMK21syrIm33RdAaKBgc
X-Proofpoint-GUID: TzsS8evtmGIZrMK21syrIm33RdAaKBgc

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
v4:
  - Rectification in the patch subject and versioning details.
v3: https://lore.kernel.org/lkml/20240219133721.4567-1-praveen.kannoju@oracle.com/
  - Commit message is modified to provide summary of the issue, because of
    which rate-limiting the bonding driver messages is needed.
v2: https://lore.kernel.org/lkml/20240215172554.4211-1-praveen.kannoju@oracle.com/
  - Use exising net_ratelimit() instead of introducing new rate-limit
    parameter.
v1: https://lore.kernel.org/lkml/20240214044245.33170-1-praveen.kannoju@oracle.com/
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


