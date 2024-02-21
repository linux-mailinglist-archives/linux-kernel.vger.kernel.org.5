Return-Path: <linux-kernel+bounces-74304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAFE85D28E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75763285CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CA33C469;
	Wed, 21 Feb 2024 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a9FIqdHH"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCB93A1A2;
	Wed, 21 Feb 2024 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504121; cv=none; b=uxumVDJ6mWTOkHPHuQxo4YuLJ/RXo9YoVGZQwVIaLPBaywJO/yu37yns17NFDiI6pQ+W/K3G4NwN0kPpNl9a6oMsNcxZd3YxZLsrGArmbgZD35aW7DiK0qj2tbTb6vZaGmCPLn1li0Yl2FA91yLj3OFoJ8IwZyISdRrPQcIhnBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504121; c=relaxed/simple;
	bh=wUDHkuJfww4QlzyksTXDUyMMbY5FhW80CHg6xtS3WPw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H5ouIuYutOwPDHpoLXjco0ffJuOzoJqXqAfpRsGWYchpgsawpayvnG7dDq+bNbccrGPbcDfF7VZB4FsZmgmza2RmFHv0Ph1Bh9iCleeRdkgmXjQY0hAxj5R2W9aHtMbFAzAMYqDACXUhu6AT8Q1VzzNHXsJcO7iFhuQz89/9Aiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a9FIqdHH; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41L6cr1L001177;
	Wed, 21 Feb 2024 08:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=U2p4I8IRsPvmbwBlC9Hezxy+xYl2NZX7KluCK3px9+8=;
 b=a9FIqdHHii4XJDv1uLZhymyXsTrvyZguqZejt0djNWZh/19UTgN0ZUTW2c2Aiu3Pa2P2
 bfx/c4ifVV3d50tyIMNi1rmhCDUvSlAKX8yY6NcGeUqOlqqZSNjimAIQ8kam1LEigdPA
 vHifxj5sGDMkofw3Dzh3kS1MHp29Qf63Ydv+hRtM4eU5eDAwKB84iMri7wz8hjisA0Or
 0pjRcWSyZ4B6fXFm2tlLJk53uaS7yCq2v+I2pcg1+PDlCZvATucCrHTKYSbetcj9fr8k
 ijC4W2HQJ8D18VsnCWfl6qXV44smoJrjw3A47txS3Xl23gDWIQCqrd4/MNESeGdF9qAl kw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk4172v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 08:28:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41L84YuA039689;
	Wed, 21 Feb 2024 08:28:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak88najp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 08:28:29 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41L8SSK6011353;
	Wed, 21 Feb 2024 08:28:28 GMT
Received: from pkannoju-vm.us.oracle.com (dhcp-10-191-205-154.vpn.oracle.com [10.191.205.154])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wak88na1s-1;
	Wed, 21 Feb 2024 08:28:28 +0000
From: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
To: j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
        manjunath.b.patil@oracle.com,
        Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Subject: [PATCH net-next v6] bonding: rate-limit bonding driver inspect messages
Date: Wed, 21 Feb 2024 13:57:52 +0530
Message-Id: <20240221082752.4660-1-praveen.kannoju@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210065
X-Proofpoint-ORIG-GUID: Boe4j8y2B2_1FevFli97TotK5z81it0C
X-Proofpoint-GUID: Boe4j8y2B2_1FevFli97TotK5z81it0C

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
v6: 
  - Minor space additions addressed. 
v5: https://lore.kernel.org/all/20240221050809.4372-1-praveen.kannoju@oracle.com/
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
 drivers/net/bonding/bond_main.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4e0600c..51fdb79 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2609,7 +2609,7 @@ static int bond_miimon_inspect(struct bonding *bond)
 			bond_propose_link_state(slave, BOND_LINK_FAIL);
 			commit++;
 			slave->delay = bond->params.downdelay;
-			if (slave->delay) {
+			if (slave->delay && net_ratelimit()) {
 				slave_info(bond->dev, slave->dev, "link status down for %sinterface, disabling it in %d ms\n",
 					   (BOND_MODE(bond) ==
 					    BOND_MODE_ACTIVEBACKUP) ?
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


