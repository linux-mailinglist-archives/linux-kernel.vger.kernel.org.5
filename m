Return-Path: <linux-kernel+bounces-164095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD91B8B78EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7D21C229D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE9117F39B;
	Tue, 30 Apr 2024 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ds4a3IPd"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE33717335B;
	Tue, 30 Apr 2024 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485970; cv=none; b=o6VjQk92NOU/NqCvi8ld3hjFG+EgtA3V4+MxLs2kP1z6Yynnfv5+TB6/hOOLJxKhccFNRS/8LJn6qpM6uoBLTm126RbM49DZn8QeduK5ROD3M5vywrc+RMbkaVarfiHnYyYVt6AKdLTmwBMoUZpmexWN3aZSnjuFFT/GWsfW2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485970; c=relaxed/simple;
	bh=hXJ+CmY9WOhC5r1nSiai33aVPUbC7zG3i8L6aMAKREE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SkUlHaVBFQXawjLM6QWTrF6VV5A3kBQqNy3Gcl2cAok3nsGYtjAKMKUdIokhfDPb5R2txNTw9biioSZJpJ7nO3liqglkdQCcEEUl824O1IYO+VJ6m2q4xCRBWH5sVeE27cwdnfYAg7JfpsPeuPpVBTYJTthdoB1yHgX8zpl2fjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ds4a3IPd; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43UCf1Ok004930;
	Tue, 30 Apr 2024 14:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=FTooUWdMxYsTdwFl6p4psFfTba4y3HLxgYcct+zsEJ8=;
 b=ds4a3IPdoBy40+96ku7qJgk1g6eKaPaQuYl2d3ooycvIj7SildG+dvvuZWJuYEMRadVn
 0Pl/83wmyWMJF3neawE40fvKGpdQ/9ekomSHCxZqgtTR2lA7d2LoHGNWjhcbWkXC0knO
 NYIBYlJdASRAlP7vI/mim7yj/a1r8vDQbRuZfh9iGQsPicXsEj83d2WNEjkWP8+DsjW4
 npWWT2YSRQG2EzBfBk2Hr6N7GX5G7LL404vlX8cYAvhDM8q3nKiWrmcCaHfFj1YOJR97
 VHxweUbgB9tsJ+yv8ZRmijZASqGscRJWaszhrU7JUM9lJTD3LofSeZsk/yc+1c8l27Lj 1w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrs8cn4ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 14:06:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43UD7cUh016720;
	Tue, 30 Apr 2024 14:05:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtdy7w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 14:05:58 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43UE5vb5018206;
	Tue, 30 Apr 2024 14:05:57 GMT
Received: from pkannoju-vm.us.oracle.com (dhcp-10-166-190-140.vpn.oracle.com [10.166.190.140])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xrqtdy7s8-1;
	Tue, 30 Apr 2024 14:05:57 +0000
From: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
To: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
        manjunath.b.patil@oracle.com,
        Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Subject: [PATCH RFC] net/sched: adjust device watchdog timer to detect stopped queue at right time
Date: Tue, 30 Apr 2024 19:30:10 +0530
Message-Id: <20240430140010.5005-1-praveen.kannoju@oracle.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_07,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404300099
X-Proofpoint-GUID: JSEy053Jb7Xxdi2FU9_vC7uT181tWX2h
X-Proofpoint-ORIG-GUID: JSEy053Jb7Xxdi2FU9_vC7uT181tWX2h

Applications are sensitive to long network latency, particularly
heartbeat monitoring ones. Longer the tx timeout recovery higher the
risk with such applications on a production machines. This patch
remedies, yet honoring device set tx timeout.

Modify watchdog next timeout to be shorter than the device specified.
Compute the next timeout be equal to device watchdog timeout less the
how long ago queue stop had been done. At next watchdog timeout tx
timeout handler is called into if still in stopped state. Either called
or not called, restore the watchdog timeout back to device specified.

For example, mellanox driver with 15 sec watchdog timeout on its
interfaces will be called for handling timeout at random times as shown
below:

	mlx5_core 0000:af:00.0 enp175s0f0: TX timeout on queue: 40, SQ: 0x13106, CQ: 0x5b5, SQ Cons: 0x1 SQ Prod: 0x1, usecs since last trans: 28559000
	mlx5_core 0000:af:00.0 enp175s0f0: TX timeout on queue: 59, SQ: 0x132a4, CQ: 0x4f3, SQ Cons: 0x1 SQ Prod: 0x1, usecs since last trans: 21424000
	mlx5_core 0000:af:00.0 enp175s0f0: TX timeout on queue: 42, SQ: 0x12688, CQ: 0x5b5, SQ Cons: 0x1 SQ Prod: 0x1, usecs since last trans: 15919000

whereas with the proposed fix, timeout handler is always called at
appropriate time set into the watchdog by the driver as shown below:

	mlx5_core 0000:af:00.0 enp175s0f0: TX timeout on queue: 42, SQ: 0x122d6, CQ: 0x4af, SQ Cons: 0x4 SQ Prod: 0x4, usecs since last trans: 15137000
	mlx5_core 0000:af:00.0 enp175s0f0: TX timeout on queue: 33, SQ: 0x1410f, CQ: 0x48d, SQ Cons: 0xb SQ Prod: 0xb, usecs since last trans: 15568000
	mlx5_core 0000:af:00.0 enp175s0f0: TX timeout on queue: 33, SQ: 0x1424a, CQ: 0x599, SQ Cons: 0x8 SQ Prod: 0x8, usecs since last trans: 15539000

Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
---
 net/sched/sch_generic.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 4a2c763e2d11..64e31f8b4ac1 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -506,18 +506,25 @@ static void dev_watchdog(struct timer_list *t)
 			unsigned int timedout_ms = 0;
 			unsigned int i;
 			unsigned long trans_start;
+			unsigned long next_check = 0;
+			unsigned long current_jiffies;
 
 			for (i = 0; i < dev->num_tx_queues; i++) {
 				struct netdev_queue *txq;
+				current_jiffies = jiffies;
 
 				txq = netdev_get_tx_queue(dev, i);
 				trans_start = READ_ONCE(txq->trans_start);
-				if (netif_xmit_stopped(txq) &&
-				    time_after(jiffies, (trans_start +
-							 dev->watchdog_timeo))) {
-					timedout_ms = jiffies_to_msecs(jiffies - trans_start);
-					atomic_long_inc(&txq->trans_timeout);
-					break;
+				if (netif_xmit_stopped(txq)) {
+					if (time_after(current_jiffies, (trans_start +
+								   dev->watchdog_timeo))) {
+						timedout_ms = jiffies_to_msecs(current_jiffies -
+										trans_start);
+						atomic_long_inc(&txq->trans_timeout);
+						break;
+					}
+					next_check = trans_start + dev->watchdog_timeo -
+									current_jiffies;
 				}
 			}
 
@@ -530,9 +537,11 @@ static void dev_watchdog(struct timer_list *t)
 				dev->netdev_ops->ndo_tx_timeout(dev, i);
 				netif_unfreeze_queues(dev);
 			}
+			if (!next_check)
+				next_check = dev->watchdog_timeo;
 			if (!mod_timer(&dev->watchdog_timer,
 				       round_jiffies(jiffies +
-						     dev->watchdog_timeo)))
+						     next_check)))
 				release = false;
 		}
 	}
-- 
2.31.1


