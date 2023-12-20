Return-Path: <linux-kernel+bounces-7105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A7681A1B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C241F237D1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6A440C1F;
	Wed, 20 Dec 2023 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="u5S1OPD2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2022.outbound.protection.outlook.com [40.92.19.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0070C41212;
	Wed, 20 Dec 2023 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SH6zQ4HXglFxk2uzOij4iA6X8vVaeUkLR30SBOueSnzMcL+8eky/QPQc3+ds3NPQfq0W+UYgAVTlpUFnzhB58bjdGPAqICP/09VLKjkoMSfULkMKR64moGep/kUL41nsiGLz5ln4N6wc8WkTvAinGOZ/yYSsK0o+NvXKkKMAAxRq3io5h6ePJVahPIHuOR38dBlVBhagLXxxjtfJOnxI/11CkOBZtAsBDQBUyNCPI5Ap4uHJ97xFoHDalOseqwR1RvZWuKy1Qk7IhaJxoqt1/ssxP9auary6KpC+awc3sTn5WSbaH1EcbSsUjbP84wwlC9mCWCTwinMvksrP8IB1ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZCXZUtRo8MGzXBZZdMyiHBxegVqZxsoBfvV85MxSlU=;
 b=jDCsmm0kpTBDEudIvbFiwmVrO+ngbuu7DPceINX5NUDVASpHBFx3pCQTL8yQPSVNAii3y9VUmvJC7c309RmB3BJNchGomhpGAt8g4og1zn2ZW9ffzNWztITyTq/JU0Z86BGre1YpPXrWhrjhc+X9xoYyv0M0m7J9jdzwlHKrmcduYQZLqpcm2NsvH/NLnFB22JcyXzGpA6XLGGfZe6B07JZYWLy1aasoFWQOVSsVwby/w6D/Q+P5ikOrSnI6PsQ9C5st2nFTW1ooBOm/d+xiqeSThcZH/1DhjllShKKJ3WbLFxysK19O+fx4XQ3ZCmiEsvn/jL3C2RMcBZjkqZf0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZCXZUtRo8MGzXBZZdMyiHBxegVqZxsoBfvV85MxSlU=;
 b=u5S1OPD22ffkljkC41vaYSzgfgfwwWT36+EGNqckaXzyGcTxNavRF3dM0F0UM3McNTm1ZxhqHKMxwNXzqn+rTyNGSK0ZsHwcnIt/MmjGw7508HlrFvZXDKiAVcKP7xkxZ9H1WjDwDFfgp/+9UU4+dBsAMuPSffnXQgnR17ltNiv03MW0pSL4YDgp4Mm7WS4ToPbgmpNkuqYCxqKYXG0qRx7y2EDETsiYer6pLZqIfM+lAMyQkleBwEKtB1uaCBdGgAqdr8Y6InimH60SAHRYYq4X1LLhYcp0vp3fgd9AqYwbRN46JaW6khUDY4p0l58K7K3S/XX6eRTTKyLo4yasgw==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by CO1PR03MB5812.namprd03.prod.outlook.com (2603:10b6:303:9a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19; Wed, 20 Dec
 2023 14:59:31 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 14:59:31 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v5 1/2] ptp: introduce PTP_CLOCK_EXTOFF event for the measured external offset
Date: Wed, 20 Dec 2023 09:59:16 -0500
Message-ID:
 <PH7PR03MB7064C20AF7AC49FFB76F8277A096A@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [W/E6sr60WkXPSL3NTOCFskRGcE6CsgCTssdjmALViCE=]
X-ClientProxiedBy: YQBPR0101CA0331.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::23) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20231220145917.7076-1-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|CO1PR03MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: 492cbc7e-f25b-4c32-cf97-08dc016c4548
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N5+17V7sMTZtRopwtFSHnkMQJc9GvTsLHOSbsyHe6ovLO6ZNsrj3MjK9J/u3EBF6a7DDAZQkMCDq7E+J7B3Goep+HWB3kiMhN+TcSMBiTA3ItzMG3zzeMd5F1lqx8AWTMmxS6CXlrvpZcnboYquAP0Bakr22hj8g5yEF28urLooxkFPfNsTEJjKew38Op/D+4Futb8xvsbs7odjU0xxYEdbPifg92R3/uLlF9/0BfnJ2lelN0Mh6B63WRkJNDSgpVCOkk631nT7RbakfArP5FlyzZ5qumTr+HfpBciGH+AJ9CWFCw93VuTc9NvIxbBvo7yGnHfEJ8VVce0R4rBzwRC/TUINxXOEB6vjCLMKKiq3CaEq68VsCk5wExDq4BDtAIbQWiwbJr07lJFF/CZL2P2BOELbOlcC6GCnUEJIKBI26iSgCPQl1nrYj0Od6a9JzR5ZVzVOaGiS6T/ADQYjKZRBB4GeY4PfAU45iOApHXNOIPhJ71xtfwRHR1ho4nbVHETh7edlws9m0d2b6sIAgrJ2n4UziSYDLHRlzlYcc4MKvgWxxVQQPe36MDXnLJsEC
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LZP5x7YLxY9L9qKfz+EduKhV9zNFgf1li0YQ7TkaVzw41AgeXCeQQP8pAY5V?=
 =?us-ascii?Q?ZXV5TBoXb/B9fPBs3d1ONMqNG70laAOzPtpDMtvQfALQ7rfRUr0/xN1TGGv3?=
 =?us-ascii?Q?4/+ru7NGByPIxbyiDDLGJeo2UIJ8ynX4DkpwGViCCz8tNAoaTqrCkTaowhCk?=
 =?us-ascii?Q?FyDEFXLzA6lM1xCJyeOILktCCraFD6IyuINeQNAxF2B1NljBUPdznRjBhmOD?=
 =?us-ascii?Q?EjARbINLE5XCBfjdv+/h1dRQuT8i/EXiWmdLie57ZvTeRXAlJECNQZp6ZyyI?=
 =?us-ascii?Q?4NLL/mDBe5z1SRcYWPWxE8RkjQse+I+zFm00ahroVX1C31/0mnowdziw6xC3?=
 =?us-ascii?Q?gIvhytrUtrHYAFxruaGYFvrL3Fq7wOXvruZeE1+uIvaREYKanSzoj80BmY79?=
 =?us-ascii?Q?sSz0Nad3zNqRH67rbR2wdRGu3ysixUoUDlfdd7RCKI3ZMRbTEi8Ddbhmxgkp?=
 =?us-ascii?Q?wubNqGPRQPu2annHehnMLr3dLFGD1SCTrPix03oV8cObEXr1yQoocpElxsCh?=
 =?us-ascii?Q?ruEqlh4YlLky+CUiADj9OosVBwviEBT9VPcd9v/XOM9i0fCio6bLf5l+dCoV?=
 =?us-ascii?Q?8VFBS/m2vunPij5OjOcqQX2TQK8OgONWwsB8sNeuYTKYROwYpia+dI1Zzv98?=
 =?us-ascii?Q?hvbzLHVi8wkoScGT9lhjEFn6xc13Qkjw8ugKNPm/2Y/rvgB5vdOAR5qkO8xw?=
 =?us-ascii?Q?e/BfxVKyBp2sux0x88mdqfQXcXBP0Rh2N8/TcvgbyZ1xxNPuGOoK82U2po3l?=
 =?us-ascii?Q?yya6daDXvundgjQJQFnlsx+Ih0UPObIlx896rGA+kUaLQB7zZ5JIjR46xCJM?=
 =?us-ascii?Q?4cOWkBVpiTU9BwFPJplE9XP9nQGhcbNa095wxrZM8Jp6xNxOHrI4dJGifOHw?=
 =?us-ascii?Q?E5IBIlW3VKO8DOscwMbsyN734TvtXuiJMAoUGp8w+Y5ovsc2RYSzx4OP8SIC?=
 =?us-ascii?Q?dN8EaSCDDAQe21sh5wDfLaKFFOLZNW4M0abbpsMBJ6vtqDKkiZdB9w5yPX+P?=
 =?us-ascii?Q?YtShxrMI1RXj7mwDUhOzB8MHs31rRkawAwNA1G/SSlVUvLGwqqrOptD0XVaz?=
 =?us-ascii?Q?2szbrD7cCqY4O9pkaAi+KYjvZKXGAHymbVQ/pP9WfTk6xdXWitH8LEz36eB4?=
 =?us-ascii?Q?PYAvIb2Nt9sIZcgiKjhfHWGeiqt3xZKEUPHvkbcmuB0XQiFsG+kHhq9+lKPN?=
 =?us-ascii?Q?CS3Wqi4rNX3BafIkVBwbHOwKshRx4whIgHdTFQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-685f7.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 492cbc7e-f25b-4c32-cf97-08dc016c4548
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 14:59:31.6017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5812

From: Min Li <min.li.xe@renesas.com>

This change is for the PHC devices that can measure the phase offset
between PHC signal and the external signal, such as the 1PPS signal of
GNSS. Reporting PTP_CLOCK_EXTOFF to user space will be piggy-backed to
the existing ptp_extts_event so that application such as ts2phc can
poll the external offset the same way as extts. Hence, ts2phc can use
the offset to achieve the alignment between PHC and the external signal
by the help of either SW or HW filters.

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
-Rebase to net-next tree
-Fix the typo and ns2counters suggested by Simon
-Remove inline from ptp_fc3.c suggested by Simon
-Use flags field to identify extts and extoff event suggested by Richard
-Fix indentation suggested by Simon
-Rename PTP_EXTTS_EVENT_VALID flag suggested by Richard

 drivers/ptp/ptp_clock.c          | 16 +++++++++++++++-
 include/linux/ptp_clock_kernel.h |  3 +++
 include/uapi/linux/ptp_clock.h   | 11 +++++++++--
 3 files changed, 27 insertions(+), 3 deletions(-)

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
index da700999c..a8f0c9d2b 100644
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
@@ -228,7 +235,7 @@ struct ptp_pin_desc {
 #define PTP_MASK_EN_SINGLE  _IOW(PTP_CLK_MAGIC, 20, unsigned int)
 
 struct ptp_extts_event {
-	struct ptp_clock_time t; /* Time event occured. */
+	struct ptp_clock_time t; /* Time event occurred. */
 	unsigned int index;      /* Which channel produced the event. */
 	unsigned int flags;      /* Reserved for future use. */
 	unsigned int rsv[2];     /* Reserved for future use. */
-- 
2.39.2


