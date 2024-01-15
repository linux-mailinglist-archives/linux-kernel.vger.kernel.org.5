Return-Path: <linux-kernel+bounces-26474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C7D82E19F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49880B21CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AB819BDD;
	Mon, 15 Jan 2024 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="AKVMQcUC"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2039.outbound.protection.outlook.com [40.92.22.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A113C19BAB;
	Mon, 15 Jan 2024 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbcvHqfXBShSGQwn8VJ49UWgRURNBSxFku8tS7mcsP/gO6sUrhmE2dna9h3mcTMsWNFYiHat1KQRStBiK0+QCHPCgI/Ep8ZiBLyLmjvafbdApvF5Qe6Km+zJ6ODmxXfZCzwCIcmD/gqjTbfoimDF0vvG7T/ZO9qIcKLnneTy8C+lkYnZmDrIr8UAFIC/Xc2oE6LJD0xSqD+6F690TkRI2+z3wton+hs865a1idUBFaN+jB2Oa9ritLTfpYcNfUJTLKTyqp5ZI+GTxoeE3GlaXFJR9yBBcGCLTJBaXvHKZUg+2wdCVZVFDgbckoduBfjm9V3P7iCI/bbGylbr+QcD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6mgO5luPo/BfDUTypkDWRZWnHU0pXEuKFb3flUcDgw=;
 b=LZWzezDVazF1AWF35TBG8KidCTWeLZrpJNQ8GFpvUeR/5GAV52k2D1L/pZuSeErqaA22tLV4gi78Cp83QKiiVpTnWMO2aA4ip3kxpSBDlPwrPytIjTWpOLJP1zYI5gFAYOxJ1a59Vf1JJsXb0VhDNQfTYC4IZAQDConKBNbwFvU5RAipoFmq+PcoRQ2yJBkObKsHXcAhPxO+RylhLUBfoxIm47p5pTkm4C3ygDE31nSLTxh+yYAEHlGhnP717YKJnLuQgF7lNDyCwhxs44HelTMNOT/DsAjW6NL0maCWRnkUnRC1oW/nKQNd02ViV50v+DJzUPMz5WvPudffcnIU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6mgO5luPo/BfDUTypkDWRZWnHU0pXEuKFb3flUcDgw=;
 b=AKVMQcUC4bK2g7jNQRqdNZ0s9DpaJbArB3T5khSvxFXyYffp+OasedlwwVPuOJzJ7Dov3r0uwkn6a42gWespcGemDTpc3uQvc9gZbrLThcd6AY8wLOszP23Ojfp45C8V4pzpWPmwazk080rman4Xr8L0gV/lx7RUf2eLuBCijmu4n+tAUUc4Sd9v1fQncGlLf7rEUBrTfTnoTYdEAGe2P+UV+KHumia4DQzIKkJKo4Ehk1grJwjh49ONjhwcxswz1smu+AQkoqlCrjrI+rO+jtzG8BNGxobsGPKw7jhfXrqLn4y0bBBvGde2D0tWWmZOdkrWPlDz2PVnrcI2tBDYcA==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by DM4PR03MB5981.namprd03.prod.outlook.com (2603:10b6:5:388::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 20:21:16 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::fac2:f91c:c55b:3f04]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::fac2:f91c:c55b:3f04%4]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 20:21:16 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v8 1/2] ptp: introduce PTP_CLOCK_EXTOFF event for the measured external offset
Date: Mon, 15 Jan 2024 15:21:03 -0500
Message-ID:
 <PH7PR03MB706459AD0927264AA9590626A06C2@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ng7gGKy2eZUVyEyXDW21MBvQJUfhu1uL0QV2qKaERCU=]
X-ClientProxiedBy: CH3P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::25) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20240115202104.14077-1-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|DM4PR03MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: b6335ee6-fa0a-4a8b-d05e-08dc16078664
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GrvjjiZYJuxdLMsvlLthCRUaCYETJw2HabGW9gAcckkxNRWHBnajsCWHpQWkDcy05Wm4hQTOFlXT/xFU6d71Y7ezylPts+gW8iGDOMBdI0rmBXW7XPr5HPd6mzokIYm8MgNqpwhSqPJYW4FRY3MbsWl9Z5sf3XSNjCG+zPj0mQyCl2B/2qfQXNa/9Z+beMEhF3zY9NfGTPEUy/2XevFCoAIgFYmUR5qfdOWUDEqv4rLTIR5BBYKvLEOKpe0wBQKIn4EIFpcWVn43sdzUh8RONA0Z9KxSHNP3HVLHTtWqhP3noyAgm+4cgZScLmZachkBV/55iOagGNvcTjpiE4XQv3+o+9kWLIuvHmmqijWQLe+ooT4FeH0GCbj+VOV9BtWM8dJz6tJB62sipS8s/69+uBDOdkT+QV3DY9+miEHltTJSuLHzje+Fsxjdtb9ocl8tID8ydW0hhcslDrvAnkzeJAPvQGWL3tDDOo3HuwMoUegjmCJEKBXRojJF/bTclzjq/7+0IjSoCcEZ3pV8XkHDFU/dKYETldUe6Lx9kuJ+giNAM0if3FdG6flGv7Z76bUz
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ui9N6blQfEU3Hbf+ENmB3/o7I97VhRvtbvEiWGNoIZX/TLO0v0ljHkBjK7sK?=
 =?us-ascii?Q?jwaSOuPeyTx/KKWUrMrjY6aeIN9UFH7CRLpqDmmacsdkV0lXZ7PNgXGE+8/W?=
 =?us-ascii?Q?xCEgE3RuzzT1kKCuZomQH75sNMAD4/4lI2QuITnTQYY37+Wl069ulexmIC4l?=
 =?us-ascii?Q?u9kutgBso8eGL5ExuDibmIBs85UFAxBScySJlePAF9etd5j+U4O14n7GqKwz?=
 =?us-ascii?Q?P3HwNjd2QMKHEdZEhyI7NODOj1hHXDdRM+/SA00TJPXdNbsBdWm8RQ3QwiEZ?=
 =?us-ascii?Q?72MeSCUbH8BBH1n/1/LEo7d6A2G1V69Ye+J3x0O5YBXjLgsykqeTwnTXjsds?=
 =?us-ascii?Q?+t2bCDjPoMmcnUMKHuYsvcPCgEaE06XZ7n5k4CyVlv5CdzxSsHB0YmJo6Ki+?=
 =?us-ascii?Q?D8u0ym9Me2WlsRLw2VGH1rhVa8NE30/szdUU+29meoredu5K/k8mkddfHXeh?=
 =?us-ascii?Q?RHTQeydN5SZIMxZ+H8EE9Xr73eZZFn9dweRVb0peq53/eklb5mNfzzW0+ISe?=
 =?us-ascii?Q?JYsgtx8a9uxATwHdK4j6Ic+x5OYRm7A7XKTTpiKACrz4hZQS116p5/SPpOGP?=
 =?us-ascii?Q?bQdxeYXF8zSezMna+E8sPHpbNQRBfJtMJ4zuKzSd3VunnVjvzQyUQpwspTya?=
 =?us-ascii?Q?EwWFHTzfpOcrNdNTDP0WR9/5EhF6d0PPSUCIDJ/43UX1tSv9XG81jcnJ6YDq?=
 =?us-ascii?Q?CjyT9SaNPE1vC4WHQFErt8Qf6bKBgsLIQyjgrCect8Sh2Vv4KWZCKF5rP4LJ?=
 =?us-ascii?Q?PgoUFSiy2UDrEx8Q2JkpqSqoF0zfuECOUfiqCqxxE12DW4KDw0GCXorOp6y+?=
 =?us-ascii?Q?eEEHv7LU83oN51zlqtthpAVCQ/wnwdOBMfLC362jQOaNRwsuQ8IsjI1S3/Rk?=
 =?us-ascii?Q?Yaw+rItDRA9DKv8RMpRtJ1CvR1Mi3U4XqWPh68YqazkgyYzCVA+1aqE5/X2X?=
 =?us-ascii?Q?AqGCGPE/EjP/U6p6rSRERE6SEWo4IVUAvL6TUZxyrXQDVdnffKGAU0gJP31L?=
 =?us-ascii?Q?6kJsKRXCFsKY1iVwpIOCHs23raP6//nPx91zq9QEogD4VsvyhYSB4UICJJEi?=
 =?us-ascii?Q?e3JMqAZostdq8oBcqtL7lPoJcoQz7Di5hXSN+l9SHx9bF9B62QntPwPnJsll?=
 =?us-ascii?Q?2ViLDt0EBUjVugQZTpamILyi5NTuAD0GU3bUOsqNBM8rKdL3/YnRs/cA+YTb?=
 =?us-ascii?Q?XuYCQnZ35UsV9iHL3v6+qpyXeV12/LruDCMwCg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-685f7.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b6335ee6-fa0a-4a8b-d05e-08dc16078664
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 20:21:16.0280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB5981

From: Min Li <min.li.xe@renesas.com>

This change is for the PHC devices that can measure the phase offset
between PHC signal and the external signal, such as the 1PPS signal of
GNSS. Reporting PTP_CLOCK_EXTOFF to user space will be piggy-backed to
the existing ptp_extts_event so that application such as ts2phc can
poll the external offset the same way as extts. Hence, ts2phc can use
the offset to achieve the alignment between PHC and the external signal
by the help of either SW or HW filters.

Signed-off-by: Min Li <min.li.xe@renesas.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
---
-Rebase to net-next tree
-Fix the typo and ns2counters suggested by Simon
-Remove inline from ptp_fc3.c suggested by Simon
-Use flags field to identify extts and extoff event suggested by Richard
-Fix indentation suggested by Simon
-Rename PTP_EXTTS_EVENT_VALID flag suggested by Richard
-Update flags comment as event type suggested by Richard
-Change HAVE_IDTRC38XXX_REG to MFD suggested by Lee
-Change some masks to GENMASK_ULL suggested by Jakub
-Remove unnecessary logs and unused local variables suggested by Simon

 drivers/ptp/ptp_clock.c          | 16 +++++++++++++++-
 include/linux/ptp_clock_kernel.h |  3 +++
 include/uapi/linux/ptp_clock.h   | 13 ++++++++++---
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 15b804ba4..3aaf1a343 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -44,18 +44,31 @@ static void enqueue_external_timestamp(struct timestamp_event_queue *queue,
 				       struct ptp_clock_event *src)
 {
 	struct ptp_extts_event *dst;
+	struct timespec64 offset_ts;
 	unsigned long flags;
 	s64 seconds;
 	u32 remainder;
 
-	seconds = div_u64_rem(src->timestamp, 1000000000, &remainder);
+	if (src->type == PTP_CLOCK_EXTTS) {
+		seconds = div_u64_rem(src->timestamp, 1000000000, &remainder);
+	} else if (src->type == PTP_CLOCK_EXTOFF) {
+		offset_ts = ns_to_timespec64(src->offset);
+		seconds = offset_ts.tv_sec;
+		remainder = offset_ts.tv_nsec;
+	} else {
+		WARN(1, "%s: unknown type %d\n", __func__, src->type);
+		return;
+	}
 
 	spin_lock_irqsave(&queue->lock, flags);
 
 	dst = &queue->buf[queue->tail];
 	dst->index = src->index;
+	dst->flags = PTP_EXTTS_EVENT_VALID;
 	dst->t.sec = seconds;
 	dst->t.nsec = remainder;
+	if (src->type == PTP_CLOCK_EXTOFF)
+		dst->flags |= PTP_EXT_OFFSET;
 
 	/* Both WRITE_ONCE() are paired with READ_ONCE() in queue_cnt() */
 	if (!queue_free(queue))
@@ -417,6 +430,7 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
 		break;
 
 	case PTP_CLOCK_EXTTS:
+	case PTP_CLOCK_EXTOFF:
 		/* Enqueue timestamp on selected queues */
 		spin_lock_irqsave(&ptp->tsevqs_lock, flags);
 		list_for_each_entry(tsevq, &ptp->tsevqs, qlist) {
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 1ef4e0f9b..6e4b8206c 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -200,6 +200,7 @@ struct ptp_clock;
 enum ptp_clock_events {
 	PTP_CLOCK_ALARM,
 	PTP_CLOCK_EXTTS,
+	PTP_CLOCK_EXTOFF,
 	PTP_CLOCK_PPS,
 	PTP_CLOCK_PPSUSR,
 };
@@ -210,6 +211,7 @@ enum ptp_clock_events {
  * @type:  One of the ptp_clock_events enumeration values.
  * @index: Identifies the source of the event.
  * @timestamp: When the event occurred (%PTP_CLOCK_EXTTS only).
+ * @offset:    When the event occurred (%PTP_CLOCK_EXTOFF only).
  * @pps_times: When the event occurred (%PTP_CLOCK_PPSUSR only).
  */
 
@@ -218,6 +220,7 @@ struct ptp_clock_event {
 	int index;
 	union {
 		u64 timestamp;
+		s64 offset;
 		struct pps_event_time pps_times;
 	};
 };
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index da700999c..053b40d64 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -32,6 +32,7 @@
 #define PTP_RISING_EDGE    (1<<1)
 #define PTP_FALLING_EDGE   (1<<2)
 #define PTP_STRICT_FLAGS   (1<<3)
+#define PTP_EXT_OFFSET     (1<<4)
 #define PTP_EXTTS_EDGES    (PTP_RISING_EDGE | PTP_FALLING_EDGE)
 
 /*
@@ -40,7 +41,8 @@
 #define PTP_EXTTS_VALID_FLAGS	(PTP_ENABLE_FEATURE |	\
 				 PTP_RISING_EDGE |	\
 				 PTP_FALLING_EDGE |	\
-				 PTP_STRICT_FLAGS)
+				 PTP_STRICT_FLAGS |	\
+				 PTP_EXT_OFFSET)
 
 /*
  * flag fields valid for the original PTP_EXTTS_REQUEST ioctl.
@@ -50,6 +52,11 @@
 					 PTP_RISING_EDGE |	\
 					 PTP_FALLING_EDGE)
 
+/*
+ * flag fields valid for the ptp_extts_event report.
+ */
+#define PTP_EXTTS_EVENT_VALID	(PTP_ENABLE_FEATURE)
+
 /*
  * Bits of the ptp_perout_request.flags field:
  */
@@ -228,9 +235,9 @@ struct ptp_pin_desc {
 #define PTP_MASK_EN_SINGLE  _IOW(PTP_CLK_MAGIC, 20, unsigned int)
 
 struct ptp_extts_event {
-	struct ptp_clock_time t; /* Time event occured. */
+	struct ptp_clock_time t; /* Time event occurred. */
 	unsigned int index;      /* Which channel produced the event. */
-	unsigned int flags;      /* Reserved for future use. */
+	unsigned int flags;      /* Event type. */
 	unsigned int rsv[2];     /* Reserved for future use. */
 };
 
-- 
2.39.2


