Return-Path: <linux-kernel+bounces-67401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB3E856AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D845B1F257D5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2AA1369A5;
	Thu, 15 Feb 2024 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d6gTYzrk"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6ED1339B2;
	Thu, 15 Feb 2024 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017979; cv=none; b=b0+bxxZnTuunq4fvxApQkCYPdhtOMMZSppDqWQ/Zgd6280154Sgf7hPXnb1ITPL7MFAw9of2M+K/xurun+TeD7d9VmTZef+sD38u+xshunq7NDSJlEdhJo0NkhlAlbaeRdNyTeI27NREoTD4UaURuaBameG1CsKBAadj6FQUjBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017979; c=relaxed/simple;
	bh=wpvYxSVLWfwRfU8XWrQQv24yac6bhrNor1LrbZespGw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RnCiFFsgJ4+d7Jqk6fR3QsSsjhp9E1idQdbDUYJdrdXQ4vs855vhisz9EUh9S/3371dE0FDBBNa060zyyKjN1WdQ+pvVq4xU34Bof8yLeQQhBRKLk60MxCNbXogWc5cMhcHm6a1dOTgO8CczdIES6ZM80mTwPSTmxDQLhmHvuXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d6gTYzrk; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFT5Rn022525;
	Thu, 15 Feb 2024 17:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=OtKQRNORPDYn0Y5hER7+bF1OLu9vZNSd/ghGX8H1WpQ=;
 b=d6gTYzrkG88iH0Ww62/qmwe6NI+eH6jvqbLPSk8yC+KuC6HAGUML/WuCCeJ0W+sDHLtk
 kq5XcQZ3vciaebNWOMcEYNbPcUSbGNc5hW/1cp2LrzVr4UYivxxmjj7pH5RlztArUd/f
 tuxzwhM2b1saIzpG7RpAt1CrFy/GVogpBqmIdlyhNM/giq8/Cv0bKENE/sKShhyHZYjA
 1YL/+OKpMXLVsXUR/54cWAuiiAcVf2eXgMk4b2evlvulneyW4Wsuwz+y/Sf71VmqjbsA
 4nRexLDZ5pbPbZFI3D8W6QNIBe7NI87ciUgIfpnCahp/42z2NnmrO5qXP8vPmCWLj7fX qw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92db2tm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 17:26:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FGZqiI013767;
	Thu, 15 Feb 2024 17:26:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6apdqrw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 17:26:07 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FHQ6j3025624;
	Thu, 15 Feb 2024 17:26:06 GMT
Received: from pkannoju-vm.us.oracle.com (dhcp-10-191-247-28.vpn.oracle.com [10.191.247.28])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3w6apdqrt0-1;
	Thu, 15 Feb 2024 17:26:06 +0000
From: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
To: j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
        manjunath.b.patil@oracle.com,
        Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Subject: [PATCH RFC] bonding: rate-limit bonding driver inspect messages
Date: Thu, 15 Feb 2024 22:55:54 +0530
Message-Id: <20240215172554.4211-1-praveen.kannoju@oracle.com>
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
 definitions=2024-02-15_16,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150140
X-Proofpoint-GUID: m58sarWKwedKz45Wfy4Y-ZiasB4wqALy
X-Proofpoint-ORIG-GUID: m58sarWKwedKz45Wfy4Y-ZiasB4wqALy

Rate limit bond driver log messages, to prevent a log flood in a run-away
situation, e.g couldn't get rtnl lock. Message flood leads to instability
of system and loss of other crucial messages.

v2: Use exising net_ratelimit() instead of introducing new rate-limit
parameter.

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


