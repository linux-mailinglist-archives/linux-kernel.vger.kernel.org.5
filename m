Return-Path: <linux-kernel+bounces-16991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EED78246EF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF9E287C0D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A962557B;
	Thu,  4 Jan 2024 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="XP0FDhjm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C297328DB5;
	Thu,  4 Jan 2024 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvWr5lTRx7KCZCR2qX5bTtQ0ZsYS8i5hT0pEfw62d174dCcTMYWcwinucD4Vk8xLKvf61t3zdpjQKbKJwUy7Xsr6ZUpB5vZqxDCQ2gw14XjIjDFnZJPHIo1jZywaH91HB2SeMcEG+w/QeCx43Yfn80KkneQ3g3axeplzW82YBqnFnheYY1r2mLpNvTVx+EDlnQK/ILpEoNkYs+xhWaGlAf4/VFea6I1xrWXGKOeQN317lGI7sgzllObv7v1dxASc5RcMwVtE+G9zD4JgBwcGPKYr884lN8ATQRBs5j8UFb9szXYXsp1XONboZQGP9Y/Z11F3DlHzQtl+R9IMUG/4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wY4XqwLw1d50Vop+iLB13lusoEoz/wpSedkxGLjUa8=;
 b=bQEM70ntITj5nFytoTYIFrZ7/HGznZUSjSNeYigrY7qNaGaRfeW3JFiXm7z9ujzKBSy2H4DY5AzSGctm/4wLDmn2+3hp15rhpTSAbgrx9SCG6hq6aqNjqcIaVtNSX9vZ9NdVPdulkWtO/TprwaCErYaTnnxz2X/EIduExTAnRkevfnFf3Mx5lbL6+ba/xSumameZA+KBScr6xubBWb6+xC1ZHfEY84vPaVzAI/FjWYS88mxTzqeWNmoSD+cD7lbJatM92rGcMo5YAvBB/CJJK4FcNOiIOUJtxxOWzGlrOFhY5OIXz4kHuQDZvzhhqcXE0mHdyRaRRpfrhyINcho8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wY4XqwLw1d50Vop+iLB13lusoEoz/wpSedkxGLjUa8=;
 b=XP0FDhjm3WKs4dPq1RWIjQJ/lqIi0FhCLD1aB+d0ep+4CdQKgn/dFNA1fduwP/jo16QLLsMKHu+3nogobDzD+yo2oVBxT8kbvNfiCdZtRdnIALxue9kWj1NZe4rdgK0M1rzNAGHVuS4fcdEQenR3x/JRWaLGaiNXdTOlAdeRAIDdA1FCdpG4BCkI4TpeeSsZo1qrLICJxzPie3FDiWIdWqJDOco8CK8SKUShqtd2ftJGgXgQifZLRZ2Q0QMBH0Z3i7EsmzFB5eSeNZrwyRmQHSFjtPXBeM+PhVMeaqy35HozdTGvOWw2sRDRXIDKTBMc8Gu8kgSjE0qoFvWtF6Gxkw==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by PH7PR03MB7414.namprd03.prod.outlook.com (2603:10b6:510:2ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 17:12:24 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 17:12:24 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v6 1/2] ptp: introduce PTP_CLOCK_EXTOFF event for the measured external offset
Date: Thu,  4 Jan 2024 12:12:11 -0500
Message-ID:
 <PH7PR03MB7064CD80AD7DA745B3F6790FA0672@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [MdXd8pnTMUNF30o8CE+94s4BkpAX8VPy4gZigsMbbc0=]
X-ClientProxiedBy: YQBPR0101CA0171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::14) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20240104171212.16906-1-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|PH7PR03MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: d1da25db-ec34-4b53-3189-08dc0d485136
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ju68gbBFMaNO7Eb4IMZIdHDm/+P0egJeAVQpy9mbGm3Ghdg8lN4M9PIxV+/o9q46k+aUvraZaYvGq2OgksqamHRc7MXgDKQhcjX0fZKb8Kg534wqztrcRXBALdPSZLkK/3xw6BBBDXPaMciRH1vRFR953YxX8Zpz3U+Byy6uuyobk7Tec+EMT7JQgiA6TLemsTjqzZBJ0pkvwlUkXttlBVwn/UpD6dHdQ65RrT6TtTqrX9kThYWznPr4TrK0QiLnfvxgfy9SrNfQ916/3rzh0Aiq8RQ+JOo5V3h96NF9a4mo/1NcI+s+ErBDfxl/t9GraLiq2QYw8uBLTb2y/vN4i1bYeCGu0HlowZgwWX3Odenw6uaIaqhoWo3vlBA/YOBbdEIahUBgOzZuFHBrA4w/sFH+TFLrNF8JR8Rlk3/Rs6/KKwmlIFI6faftySEZsnzLuENJ615ZPFTPemI5XEMFFCV1Zo6i96dX7X33xqJieuFGPRyj++rOMoNFuyAXSjbqc9yfliAkF0bYYkSh1NFfgIUEJaFw6h+MG4OMYyW0RyrqYdB3rwjBEZ2/fPVfo9w7
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OzZCjiDJNTr0Yp9YlHfRlHSEs51MGxXprqpwglmP2OX10lQKY7yRHJ/oXgWI?=
 =?us-ascii?Q?5Sq98B+Zn2xLcAhlHAMUkYwBJO+onKxccNlGcsPB/KnCUMm4WqN/b6E9eVZF?=
 =?us-ascii?Q?mEZpiQsMnIawcPMPRM2Y5qcMdgMhHZA/nDFwuTDNEHBcG84jvf9Jc0mCfQ76?=
 =?us-ascii?Q?FW188yj/bINsnUlNDT/DaXPj/zf9gSvVpK9paTqFL4tmj1CqvJYc6YvzocQg?=
 =?us-ascii?Q?BTO84t3GUPS5IYQs3EIQN5aJCao4D4XwTRu6Ss6Qt5iuB7oYq8f0hRaX+LG0?=
 =?us-ascii?Q?Td0VDITnCuR5vqn4NkbPTzF0RjcVDNDEZVFn1ahk5W1oWUHYrhlkDnFJyMCY?=
 =?us-ascii?Q?4tkkjlsVAYIscGh3za4mqd98SfEGbLjgcZzLk/veSAVSiXeksDx6XdPlbr4I?=
 =?us-ascii?Q?89carGwurlrTkyMzizX7hwW+lXyXhALBtIABuxGQUFzpyNMWwvDjbJGCBv/i?=
 =?us-ascii?Q?L4MYG94zIIRtvkSzYYw/3Fv/sxklcj3RLCtjF4oQDkicuawlnRAjDrNqo9AU?=
 =?us-ascii?Q?SYr7QthJJnKVnoa2rugQGiWsumKN840+m607l7fw9G66tzUv3YBXcowkXf95?=
 =?us-ascii?Q?ljuIO1E8lDmptcRRUN91MJIWaxp6iJhf1NGnBhR7GnEbURSi8tux0rsuPeG4?=
 =?us-ascii?Q?NZB2lyvYouskJegGqbpLxWrsjQcMbnS7oO6JrjC2+uuyXDHM9P1Pc1dJFQ4t?=
 =?us-ascii?Q?AsCK1Ki+u99oqTX6WfTK0Ip1F3f7z2zaEuEgNSVn1ZXktgA0NG/6REwCBZE8?=
 =?us-ascii?Q?Gb0f2/TCZyfvdBa0PXyDVtVXWqa/nmBzeZmE392MusFVq61OiNVzYbGfLAYd?=
 =?us-ascii?Q?kU6R2o3PFk7XX3R+rgI1YhXrWE+jPDeeLKwlv2KeMkzydeLl2xmGBaeJ96px?=
 =?us-ascii?Q?hcUcistSfy2lVVYlCF9Mme3DTvAKOeOZkY0VIQTQPnFJhwqCvNprJSOzloyZ?=
 =?us-ascii?Q?iFDZXdYiVvufZF2FaVrc5im3X8uN9SE2Qm8Ho/EuZPRRiq0eIWsFDfnI7Lr2?=
 =?us-ascii?Q?pb97LfC2psdNCvnAKw4puFdYvnI4adxHpTXEq1yJanCc5ge+TiWciSy0Ax32?=
 =?us-ascii?Q?YvXAdXgZ6OeeYmiOsIBEijkGFaBJThfJM00cOIkoAkoAVirlk8mELBCjAzSl?=
 =?us-ascii?Q?5uOOf42ptz7aXSVWWpZR7D5xWiKem4jQW+nU3zRXqzXpH4grXIhdtmVbYYfN?=
 =?us-ascii?Q?AGDp9smy+Gpk4obvWFkbSWjJhKPvUEEze5WHDw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-839f4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d1da25db-ec34-4b53-3189-08dc0d485136
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:12:23.6699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7414

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
-Update flags comment as event type suggested by Richard
-Change HAVE_IDTRC38XXX_REG to MFD suggested by Lee

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


