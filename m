Return-Path: <linux-kernel+bounces-71420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 173E785A4F9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1AF2876FD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464F1364CC;
	Mon, 19 Feb 2024 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GrfkitrD"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F62364A1;
	Mon, 19 Feb 2024 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349866; cv=none; b=hxYzBm4wzBVY3rU90qGBSqn7+BEwtTXdrcyePoR6M8dIaixLtMGx4JamtqCzrS7rXeZCbXXW/LrvXRM62qKJsxnhENeI0n0DQ1aTsIaNVlz+mt6gq3WAi4wXJ7HoBmfwgEo+GvTXsvHU6TU7ozZiDD7mrEc2BBGUmD2czpgVoGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349866; c=relaxed/simple;
	bh=GX1gehkvQcZqiJUoO8NQAFdj6CmJo/860fgT0JsK+xc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I4N6VEVGWoZJgj9Cb2R9suk+McdeZRAoQ0UEuj6yxLNARe0mQhzeW28nObIlTXdx+VemtLLOXc2SKt869x8Q4LqZ5pGw/DGOXimuYz7/9nF4UPc27jAE/8ACQH9Mtrz+6pYV41KsayUmcLxseUVGNYdqZt0mKqPCOGxneFhU2X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GrfkitrD; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41J8O74V029244;
	Mon, 19 Feb 2024 13:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=v5j29fJ7l64OqdiJXkSFRWQ/MC7+s+gIo0U3PRJ4NMc=;
 b=GrfkitrDIneElEPutV3vloudxTdwvvaUHYwtcZCQUIMZPnZxfag1LNfK18ILuaxFt+9t
 TVa8TKtqHV3hDsQXGXA+sF57YDJwEbNmF094KdkXQ+R0tzNDH/WZ1DQvOttH1xUxBft0
 f6aQ+db2vScSpZ+JLHNXKpZqLjofqHLgjCW0mLc0NJANTvnRgUmyuAcOhhUv9q5+dSwU
 eIQwmbIhORiDbIbeNicJzUiIPlSzTf4tyGfWvOxTh1V9vPhhoCqbHhcjFmHTtpx/DzGd
 PN9+r0M0vrnq8CTCzzWnD/tICtHzREnlBt/lfPA92zwQslS1xAdWQ+58zVkeFMAvtqyD Bw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakd246v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 13:37:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JCP7Cx039727;
	Mon, 19 Feb 2024 13:37:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak85xfrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 13:37:36 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JDWmtk016570;
	Mon, 19 Feb 2024 13:37:35 GMT
Received: from pkannoju-vm.us.oracle.com (dhcp-10-166-182-179.vpn.oracle.com [10.166.182.179])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wak85xfmt-1;
	Mon, 19 Feb 2024 13:37:35 +0000
From: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
To: j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
        manjunath.b.patil@oracle.com,
        Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Subject: [PATCH] bonding: rate-limit bonding driver inspect messages
Date: Mon, 19 Feb 2024 19:07:21 +0530
Message-Id: <20240219133721.4567-1-praveen.kannoju@oracle.com>
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
 definitions=2024-02-19_09,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190101
X-Proofpoint-GUID: E8SaMYBR-BetkhYxqamTVOZAfjPKF_Op
X-Proofpoint-ORIG-GUID: E8SaMYBR-BetkhYxqamTVOZAfjPKF_Op

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


