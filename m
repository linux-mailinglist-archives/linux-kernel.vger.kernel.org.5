Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47381813660
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjLNQgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLNQge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:36:34 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB3010F;
        Thu, 14 Dec 2023 08:36:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyxg+4IwPwngjW9hScSdtWGJuq4GIEhb03rTjdSyew4Bacxvspu7OS8Nc6vi6QDZwFShJxU2nh/+fNysHffgh/ONsP5UY2JKv+gQYLfya9wJycNYmf9/ut9qqjEOji0SN6x39tFulhOmB0oWB/rV2MdRFrW/7yV9HxI534ue7XNpX/QUoeUAYgZl3DvhNumtZefXH16423sye7s+A2E6LW9eK78tKqjjM/j3EBXnNBh7Ta8vjdl2ixtLRrgANol2UwZKetUJszhpLlqFxgxek8/b7bp1nCz/iE+GsABzeu6jM7QfcMURhCekRLivrBn89Ky0OKCVQxF85g3ToAjneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9AjcKM/+IwWquA3N1E6VrYur+iXx9b0VAeSNKjoNoY=;
 b=lrmYXIv4WctQHaPFlwIMdYIqSQlsXyyZY37WfdzK9eJWlBRt8XltimVNSh8ir6lA/4nWZWirCH+6WTRHS8vRC1ERrX37dLNsI68a/5dH9IcmF095emZI9UMNTsiBezx4rcffCalEMytsfB1YLSNjlgXmlsZINB4z4UE2crrq0sNyQ9K7KYrVZGHsTYQVoDd5rMEf2hFVESvDZZ/u+d5EkMU0BQl0f9T+chsLTJLTEHgpf9tEM+1j57oOGKZxv3CwnRVt5dVBP2MTDJjk6Qebo5T/0pDxy+UQuDL+3D29YJXme/b1Nb2whZgG+9HOVUuOznC20DTObIpR7c0rhulZuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9AjcKM/+IwWquA3N1E6VrYur+iXx9b0VAeSNKjoNoY=;
 b=YCBg7cdFGInE8fh/DtyOHmY6c72nbNDRLjoHF+N5Nj501HaroxJMaE+POsEB+QsbcuDHTfDGowSVfAepnSEnuy++XDwrE2PUQQJulcH5gSG3eIwIzKn/PKLqfHm98q1IARfyLNlWaXFPkAQxwr5DBicOWzItu66geccvFm7b0VBJdgE8rHBZ7Wzs6OARYBRqSiqH617ToV/ckrIBgBhG7Ja9Z3zkIVZXTeK9kKGyUNq7pDDpgn12LDR2Q+sxyU9BBAFAdklnkWoFk8jX0L8505lvDgdxXcY5Qz1y6ct+Xfh5X8UjuZSMEnqSduPSnv+ThuVW2rVlqes7syKQQH8uwg==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by PH0PR03MB6770.namprd03.prod.outlook.com (2603:10b6:510:121::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 16:36:38 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 16:36:38 +0000
From:   Min Li <lnimi@hotmail.com>
To:     richardcochran@gmail.com, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v3 1/2] ptp: introduce PTP_CLOCK_EXTOFF event for the measured external offset
Date:   Thu, 14 Dec 2023 11:36:24 -0500
Message-ID: <PH7PR03MB706431C1C25954AD76134FD8A08CA@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [o3CvydYN5YRJpPgRJpH1l3l9faZiXgu+jQ+7vbX3tfI=]
X-ClientProxiedBy: BL1PR13CA0314.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::19) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20231214163625.17939-1-lnimi@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|PH0PR03MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 702ee067-4ad0-458e-2ead-08dbfcc2d80f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2drGr+chtIOo5ukyMztkWi/mHmRnL36C6GX1leTWQTwOZGucLergehaRPcvRMGuHT/7DqyRumRSuinWtIKZyGq7t3wmvlqQp30T6t2XpcU2QeQoQdLAxfIlGyv1mFztuVVthDpIL666V2BusJC9HXCbFxG/9lLoZPpN9Xd9HU7KfqwMCWajlC2mIC+jm/gU1MDXxJhwINxC2P2tijZzZyG13kupiqxYjTnXpzUYzvTlnsvaO4A+OhQ23AUjD1s49lsB335ZaAOtZFm/aHohUu5sEfFXpMxjMRYS98pZhzVv8KtjwTHI48ogoJv6Ksy96F85uUbZsqX7VHVqW5OVMh0qcf9R91xfO5tigyPRYRXxfabuuck6gPnpI5+i1UviJv5gD7d05Z1pwUysBCsdbfoUg767kEPIXU8IxKkyHzJ2BeXufJfeFRuCvhIBUsuw7Zkgsg59ViLmF60Wk4wRtFkm9Bz1H2dYuo7+yea5OLL2a3dTbR0PbS6PJidO7ZXUEFaAB/Ffq35D+jwA25j4pYKy5lFDDiRFNeq7whNwG4kMDNngbPR5chjsfGh4KHE7l
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LnRyBuBP0w3fnqLlP74Gs22H07t70Okhln+3evmjigmmI4OCliFEr2JA6yQu?=
 =?us-ascii?Q?T80G+fNbW5BKeKquwZ8f0E1FDk+cV1OCS0Lq/ZWi5XjzubfUobasSHcGbqJ4?=
 =?us-ascii?Q?yZCrx/kwLlDU//g3HJUsBN1/oQPF7tuRjzEs/FN1acUBC1wk5l0l33Cn8scP?=
 =?us-ascii?Q?1Uc5G1hbeo9leGwIXbvrFZANoq6I9h1Ztyw18F5K1z8zYjINZZbqD7GJbB//?=
 =?us-ascii?Q?WV23RzHfi2G+cI5AlV4pUWZFT+rQWbYv0WZs4sZqq/aNX6CrbNerDZoVuASt?=
 =?us-ascii?Q?weGY7nfTAJaaOxvM2cTXvzdsxU6a/r61CCEi0FPeMDAIDUTvjAWqDa/eaFNq?=
 =?us-ascii?Q?NA2/WCmu9zSOXtl2tYG8KeOpX/4LyMQVm6UYEjy109bunJ0tUnnLIQXItIxM?=
 =?us-ascii?Q?vi3BbsJ8p1HogQJAkYVszIbbBoHuieDFIALehehfszemX5/GFy9V7YSuwn3v?=
 =?us-ascii?Q?rpRJZyJ9HAVP4hCIoFf+FJ1sJgmWICjVZCnpT2j3zxRpZ66WOPmo+FrC+SZA?=
 =?us-ascii?Q?rMfDoPgo74a2Tc6b7QnsN3oPI7OEMNvCrCEohB6V4qsUkQqA4DTO3FuS/qF0?=
 =?us-ascii?Q?atAKN+uPC+4HR6ViDwUWZaPbmvA9KaiHXInSYhBU9VZXzksPJxz2eA380kBU?=
 =?us-ascii?Q?vTJet/sVxySDrghUE2vM22kZ53fFGSpHv5ElDcN+ghJSajMIJnx80C0dYcjC?=
 =?us-ascii?Q?sOW+Tgk74u8MePuuNuwFwm9uS09FAjagWVkLX1FTwlFqFPyKm78lIEtH2vNN?=
 =?us-ascii?Q?7+bgNUAVx4oI5lP49wQPukpfuH08lSdegRgNxkAGje8cbxB1dIOSJKr7a+jr?=
 =?us-ascii?Q?BmVbE3KhWdfGKAi8l3qMdke+SqSdsnlBlxBQHGtomx5YD6DJRrLzR6zjJ679?=
 =?us-ascii?Q?/w2RUf/ZyN8dk57fYs7MtWP18ydlQZHwi5AC4DqHBWNYtgwJ2YySHM2cCgTB?=
 =?us-ascii?Q?FLUVAiN57hK2TAE5DiODrbj+FjrNTDiqSJIatmPJqgtp/x4HLJ0Zyyv0u6Nh?=
 =?us-ascii?Q?ZzXKD7KQrzBT745kygZz+BkflBc2KqJVRrfB6ChKSv+2xEH05TKM3kNES0uG?=
 =?us-ascii?Q?XkoRPXyw2F5Et8p7bB4xXaJ3M2Zou3x3DpYdG1/foyoLxdb/xjEh+AeTtv3R?=
 =?us-ascii?Q?PNNjXUM+Nx/71jWteXrtcIOtii5AaNueK0WetFaAUZGBzb/nhKy5kZ0bd7UF?=
 =?us-ascii?Q?MgZAb5sIROrGIH5+6JRhJyydu6WQCQdibPSczw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-839f4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 702ee067-4ad0-458e-2ead-08dbfcc2d80f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 16:36:38.8014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6770
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 drivers/ptp/ptp_clock.c          | 12 +++++++++---
 include/linux/ptp_clock_kernel.h |  3 +++
 include/uapi/linux/ptp_clock.h   |  9 +++++++--
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 15b804ba4..01b55c1e2 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -48,14 +48,19 @@ static void enqueue_external_timestamp(struct timestamp_event_queue *queue,
 	s64 seconds;
 	u32 remainder;
 
-	seconds = div_u64_rem(src->timestamp, 1000000000, &remainder);
+	if (src->type != PTP_CLOCK_EXTOFF)
+		seconds = div_u64_rem(src->timestamp, 1000000000, &remainder);
 
 	spin_lock_irqsave(&queue->lock, flags);
 
 	dst = &queue->buf[queue->tail];
 	dst->index = src->index;
-	dst->t.sec = seconds;
-	dst->t.nsec = remainder;
+	if (src->type != PTP_CLOCK_EXTOFF) {
+		dst->t.sec = seconds;
+		dst->t.nsec = remainder;
+	} else {
+		dst->offset_ns = src->offset;
+	}
 
 	/* Both WRITE_ONCE() are paired with READ_ONCE() in queue_cnt() */
 	if (!queue_free(queue))
@@ -417,6 +422,7 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
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
index da700999c..66f4dd73a 100644
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
@@ -228,7 +230,10 @@ struct ptp_pin_desc {
 #define PTP_MASK_EN_SINGLE  _IOW(PTP_CLK_MAGIC, 20, unsigned int)
 
 struct ptp_extts_event {
-	struct ptp_clock_time t; /* Time event occured. */
+	union {
+		struct ptp_clock_time t; /* Time event occurred. */
+		__s64 offset_ns;         /* Offset event occurred. */
+	};
 	unsigned int index;      /* Which channel produced the event. */
 	unsigned int flags;      /* Reserved for future use. */
 	unsigned int rsv[2];     /* Reserved for future use. */
-- 
2.39.2

