Return-Path: <linux-kernel+bounces-64734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC6785421C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601EE1C26658
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1C6C126;
	Wed, 14 Feb 2024 04:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ES6AY3cI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3B3D72;
	Wed, 14 Feb 2024 04:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707885793; cv=none; b=el95PVpbDQLXDpDQwqlctaNlQPWh6zIB9MC/ljrAqMSMGZ7NhAoLMSSP2piLz8SH3bn2wqXIxhEazzrJraXZd2wIJywnCQnuxss89JoqBzHP00MnCY5EPN8v8NwrGCS4eGbEgHD7zDpLjw2Nl7bcERqpiCC6nlG4qHjvHZu0jv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707885793; c=relaxed/simple;
	bh=RdhqHGC3OuB7dWbMuYy8MMrSYo1ZehDKl3DCLHtGNo8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mKBibWfPKM0T+isVEIHzDSpUOLm5S+P4jAdLdye/Z6lr5JF2lEJD4HX2l11dFxa6aH0gD5S+ADZNsWh4hBYE/IWp1dvDg/jCrm/s/bC5L2AVxRrpssjauozvxmqTKCTRRrRVPYLpYGvvQDdfe2Ab5QiQ84dK3AiKyj1dJYANIrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ES6AY3cI; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41E45LfS014253;
	Wed, 14 Feb 2024 04:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=2o2TN/WjoUkcBabvDoZhXwABCTSWpYGTGQprEg4COwc=;
 b=ES6AY3cIlKeogGzLtJ+D8X97LKqNOGVClOkzW8FE1pCviqzCLgLhV5VZLOwTaOpVi1zI
 YkcEVQpPp4qOvv6qoKns/c9QtXjppGCozZGcVNCqM11I0YQBY7aUV8gu46VeTwrVG4q4
 C+vM1xH8pF/+r/eRILhcQ6/Z/VPRl5lSjFJnu0KOsK894XIAoUX36W+s0afLiKM7T5Bq
 tHFhUu4nDIe/zrjwKlZEzoW7zMb5FheN3Pfh7E46PmcSoFifNFVVwUQY3b0Q0sW46kXa
 9aps8VQw5GkorSclgJnkRr6AURXf8A/b5lGOYSqKCzeMjJ8vpQ0bVmpxJIlJNa1rvajY +A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8p64r1kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 04:42:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41E3oeKN013874;
	Wed, 14 Feb 2024 04:42:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6apb4pbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 04:42:58 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41E4gv3P002968;
	Wed, 14 Feb 2024 04:42:58 GMT
Received: from pkannoju-vm.us.oracle.com (dhcp-10-166-169-72.vpn.oracle.com [10.166.169.72])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3w6apb4p92-1;
	Wed, 14 Feb 2024 04:42:57 +0000
From: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
To: j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
        manjunath.b.patil@oracle.com,
        Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Subject: [PATCH RFC] bonding: rate-limit bonding driver inspect messages
Date: Wed, 14 Feb 2024 10:12:45 +0530
Message-Id: <20240214044245.33170-1-praveen.kannoju@oracle.com>
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
 definitions=2024-02-13_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140034
X-Proofpoint-ORIG-GUID: t9v5Z0uoXaaXemWmQ2pSpt_TZEQRN0Oj
X-Proofpoint-GUID: t9v5Z0uoXaaXemWmQ2pSpt_TZEQRN0Oj

Rate limit bond driver log messages, to prevent a log flood in a run-away
situation, e.g couldn't get rtnl lock. Message flood leads to instability
of system and loss of other crucial messages.

Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
---
 drivers/net/bonding/bond_main.c | 34 +++++++++++++++++++---------------
 include/net/bonding.h           | 11 +++++++++++
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4e0600c..32098dd 100644
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
+				bond_info_rl(bond->dev, slave->dev,
+					     "link status down for %sinterface, disabling it in %d ms\n",
+					     (BOND_MODE(bond) ==
+					     BOND_MODE_ACTIVEBACKUP) ?
+					     (bond_is_active_slave(slave) ?
 					     "active " : "backup ") : "",
-					   bond->params.downdelay * bond->params.miimon);
+					     bond->params.downdelay * bond->params.miimon);
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
+				bond_info_rl(bond->dev, slave->dev,
+					     "link status up again after %d ms\n",
+					     (bond->params.downdelay - slave->delay) *
+					     bond->params.miimon);
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
+				bond_info_rl(bond->dev, slave->dev,
+					     "link status up, enabling it in %d ms\n",
+					     ignore_updelay ? 0 :
+					     bond->params.updelay *
+					     bond->params.miimon);
 			}
 			fallthrough;
 		case BOND_LINK_BACK:
 			if (!link_state) {
 				bond_propose_link_state(slave, BOND_LINK_DOWN);
-				slave_info(bond->dev, slave->dev, "link status down again after %d ms\n",
-					   (bond->params.updelay - slave->delay) *
-					   bond->params.miimon);
+				bond_info_rl(bond->dev, slave->dev,
+					     "link status down again after %d ms\n",
+					     (bond->params.updelay - slave->delay) *
+					     bond->params.miimon);
 				commit++;
 				continue;
 			}
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 5b8b1b6..ebdfaf0 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -39,8 +39,19 @@
 #define __long_aligned __attribute__((aligned((sizeof(long)))))
 #endif
 
+DEFINE_RATELIMIT_STATE(bond_rs, DEFAULT_RATELIMIT_INTERVAL,
+		       DEFAULT_RATELIMIT_BURST);
+
+#define bond_ratelimited_function(function, ...)	\
+do {							\
+	if (__ratelimit(&bond_rs))		\
+		function(__VA_ARGS__);			\
+} while (0)
+
 #define slave_info(bond_dev, slave_dev, fmt, ...) \
 	netdev_info(bond_dev, "(slave %s): " fmt, (slave_dev)->name, ##__VA_ARGS__)
+#define bond_info_rl(bond_dev, slave_dev, fmt, ...) \
+	bond_ratelimited_function(slave_info, fmt, ##__VA_ARGS__)
 #define slave_warn(bond_dev, slave_dev, fmt, ...) \
 	netdev_warn(bond_dev, "(slave %s): " fmt, (slave_dev)->name, ##__VA_ARGS__)
 #define slave_dbg(bond_dev, slave_dev, fmt, ...) \
-- 
1.8.3.1


