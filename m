Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4CE7FAACE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjK0UBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjK0UBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:01:43 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2055.outbound.protection.outlook.com [40.92.22.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF811B5;
        Mon, 27 Nov 2023 12:01:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvge2IdQoPC0HJneSL5gdjiTYFQQ1gYl4G/RH20dVKnXHMBIJxJ7ShRa6z88+GdVZzyLl2QVH4QRL4IFCqXknHZoJoXqrfKB/AhkyTwGD/8R8Di//dqVN2IscpF6rnK0+HnwctikxeTvR6U3FDzXbBfIFTz6piQxz8oG9cr5HASN/E7vkOM8TypQJipOlTp0mPDwGrJETJyivNf7DxJSC2eLxrQFv5c1JqJD5OxdrV3ht1w+G8wfR/YFWDbYqtTjK+DOl9q8EcLg9VxaNJfQXfoopSIO9vLrB9FSmtke/CwCJX0eXF2sK8LEHzFN6NxCdIoRtEdJ7R5q9gKRQp1a6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DS7SA2dzesZs+ZgRdGiou4fuD9fyrTboQgSAc/evv8=;
 b=OaJ9/hKaflBu7iaCGHwcB+ka3RyDCnYs0QZd56sXTmIdhTlCui5OSVwSlyBOTdSbs5dtEnIf7i7mPu5zyRFvvghhZ2LFA/OgwAF0MPzRXK7JZ8941YgcaYmGDUgfuOjJHv1gK3WZovkoILurgKdl7WLELUi+KHavluVdx8qSNxTI6WbY5kzk1Vbeg2yMXKJI7lRtT4Tv4tqlfmtlxdc3V1whtNGq/IM8we/Vw+4n6Xk2ayVu+IOjkoVZIbG1ptErlhBxN1KTCyoC4UKqzmRgjVxtuoo+5+n2XIxaNGZZol5Yk3NeGViGgJbt6K9d84UnxBtxOWAoabRtalbakqUY1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DS7SA2dzesZs+ZgRdGiou4fuD9fyrTboQgSAc/evv8=;
 b=RnR7cdl7XrF7Wun8Q0FWwJ/eeIBjELgxzMUey9nwDim280saPy+OoGs6KgD45lKzGTDgrM33xzMGoGG8Q1DrRVNETTuWnK2QvTZtUNQLU8G4xg8BcjjzeL4O63HDzwgQYw8EQ7lgu5vwpUlryy9v7AKKhGjDfONFVX547RkmbWSborYx3KEtLgJ7ryiPgg6kLD09wDwsxH7ESXtrV7jitf9/ue3naiGdn/QCvbASFadm6xWw50EB+yB/vbrENiJGrzQDPzm3htaauC7YPre8jh0zSiO1fliibw2EnXx+wRTPwWQHmMEXOepZ5Nxa/Sk7MZKOwS2iLpKEDspe0bvLUQ==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by MW4PR03MB6442.namprd03.prod.outlook.com (2603:10b6:303:121::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Mon, 27 Nov
 2023 20:01:46 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 20:01:46 +0000
From:   Min Li <lnimi@hotmail.com>
To:     richardcochran@gmail.com, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next 1/2] ptp: introduce PTP_CLOCK_EXTOFF event for the measured external offset
Date:   Mon, 27 Nov 2023 15:01:29 -0500
Message-ID: <PH7PR03MB706497752B942B2C33C45E58A0BDA@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [GxQEKU/rJfdO+ywWq22A99tg8I4ZOX8M]
X-ClientProxiedBy: YQBPR0101CA0220.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::17) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20231127200130.719-1-lnimi@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|MW4PR03MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: 60fd37d1-342e-49f0-da77-08dbef83af08
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EzbY219ZeovDxVIVFonw8+9FbtJ65/1r+r1NfF3pNZBkauZg8CSyyv2JatZVALVj/RYpWG6dGgP6cCe52RBvKMTkoYipsDdeAbMOV1tfnBDM1wGvuAyV01wWDnViFR2Iw9nG4Ry73Ap5YFhIhGigfLZ/XALc+vqdZ/8UjrltuG6EdXm0SHMVIxxMyjTND+r6WeR1edpo2RLtbm29JLWYpkYSibpg+BLNeVm92IogR5Ylxi4P0WIG9nWP+vUKXV6bcbkUni0X5pUs64oW8EGuXzTOYRvZzNNo5YMzc6BROph/VIiLr9CluzoKPqu+/ZdZP+GcomTBtV7k3Nd/DN+WgQ+gj9LYFfysc9AjtgC7/KflvVo46w/gdHJWiSMgg4uV0zmkmI15nxfivSLOF2kgaTi+RcyTpSzXzZvL5O6nYRWn8jCFQgiaDgoihRnq+6EBFyFEYToVylUTt4sGIjLSnfMV1H46moiVDXfj5Thj7OPlQApQT2K6ZNgF4CDwSkgndWIt6pKre2zGQJg09vZ4Uakkz+ZMAGqnqWiNRNJLnHYNSqXSPAk2SQ+n3P0RhOTx
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+tfQBSwGtlSwq8BAEVpRwzTwK7vSTWnO86dxtU4BQJ9Gsuddyh9kmqkjoYUz?=
 =?us-ascii?Q?/sXdGdLoGuGwg5vrhDaP6LLQhD6oepZaG5Kl+OEhPMLIrh8mSSVvgt/yLqoS?=
 =?us-ascii?Q?I2/QprsFBjmgMLhRv31oh3iLX/No0+Q9sPWuMe1ojdoUi1XfOslaeeDAybKP?=
 =?us-ascii?Q?/dMvypmoJtRKD7XiLm6FbzekR6mZLy5Kljvk4uEg4054aZPLpjvbud++arue?=
 =?us-ascii?Q?1QvgGpOmDuMP34AyhzAJj3aHboihgU63Mr5R0VKTeeHiKAUSYwlXU6fz5CUp?=
 =?us-ascii?Q?LYFvS8YDLeCto17jyEDImN0dWRBXyJx5Hj1qcZIVPL+aS0GHa0aHEWM6K6CR?=
 =?us-ascii?Q?ZhQBy6scPoeYPD7RV2mLDXK3zbCR2giIDS1FSKIRNXMbumEBGsdWIqcSak4k?=
 =?us-ascii?Q?Ea9owbvkiHiPrEkkos3EdoIFyHBlxwtoLZv//dVfhbsDp08+D7MctsgBcIVr?=
 =?us-ascii?Q?UVJ5yQpTIwavT2Gwqlilw+v3jHmUufKWfh87uUiJOTaKsZmg3b7m4b53WQjh?=
 =?us-ascii?Q?msBM7MpgzCINYXLlmp5i9rBFv1YLoCIWZScxAJK/GA0aHWucFj3Q6iz0khkb?=
 =?us-ascii?Q?KaUn54hY92wAi6JBJKJx8qfxhv5JXcA4EXeHqGn57xfPQtKF6N9XyQiK7UIu?=
 =?us-ascii?Q?I3j40ZPb76Z+eL6qKTrGcu/RAWcFgFrZp7sV+rGXIF8r5aFz25XhAvSYw7To?=
 =?us-ascii?Q?VCBnknBcJNBwfWmlpC1pKNSb8RbVJRQzzfq+NDwPxFfcn01GfpxIORYCSKBW?=
 =?us-ascii?Q?DEM5zlK0VswSEuHL9uwGbuOy4vFgyNaSW82x5qfOSs8SZ17/gNTziE4WHgL/?=
 =?us-ascii?Q?gsUPFDMomaoZmID+udxzGej5CRSWIVPN2of9WTUjtj2VwGCGWPV9HRx7BzVU?=
 =?us-ascii?Q?mxOd/r79Z5aXmKQ8hphGAHC9NZBnKL0YiT0srEZ2GY6zL4V9mqjyVWxfYkls?=
 =?us-ascii?Q?+kslIUvV80ElwYithEnG8qGEgQEf9tHcbN8z0NThD/J4+hW8/DE9WJt+fP1K?=
 =?us-ascii?Q?PXmpQQy7qxtp5rt5uA9kJZDkrzkw/vSUvETWaVplX34yweCPcV2XwKivjy3E?=
 =?us-ascii?Q?Uzy4dRy/4a1ScRZ+2snV/jReE6x37L77fd2SkkCKhtdmmvPheqwoKmn76jrr?=
 =?us-ascii?Q?cWt6NRQtGaVk0kFVn+Xiro80tWeeJS/1vwzY5Pl7FsI94x94ZvLL/yiF4Z5f?=
 =?us-ascii?Q?Jq3UMueb/XYlX4F2gLCmHAL32pHuEi1hJZ8NTw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-685f7.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fd37d1-342e-49f0-da77-08dbef83af08
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 20:01:46.5644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6442
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
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
 drivers/ptp/ptp_clock.c          | 12 +++++++++---
 include/linux/ptp_clock_kernel.h |  3 +++
 include/uapi/linux/ptp_clock.h   |  9 +++++++--
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 3134568af622..17aacdf37561 100644
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
 
 	if (!queue_free(queue))
 		queue->head = (queue->head + 1) % PTP_MAX_TIMESTAMPS;
@@ -416,6 +421,7 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
 		break;
 
 	case PTP_CLOCK_EXTTS:
+	case PTP_CLOCK_EXTOFF:
 		/* Enqueue timestamp on selected queues */
 		spin_lock_irqsave(&ptp->tsevqs_lock, flags);
 		list_for_each_entry(tsevq, &ptp->tsevqs, qlist) {
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 1ef4e0f9bd2a..6e4b8206c7d0 100644
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
index da700999cad4..17ecbe755f26 100644
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
+		struct ptp_clock_time t; /* Time event occured. */
+		__s64 offset_ns;         /* Offset event occured */
+	};
 	unsigned int index;      /* Which channel produced the event. */
 	unsigned int flags;      /* Reserved for future use. */
 	unsigned int rsv[2];     /* Reserved for future use. */
-- 
2.39.2

