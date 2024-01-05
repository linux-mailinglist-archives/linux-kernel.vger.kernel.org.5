Return-Path: <linux-kernel+bounces-17993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B03825688
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF171C22FB1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF132E636;
	Fri,  5 Jan 2024 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="QlCmtZzv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D74A2E823;
	Fri,  5 Jan 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/0nPG/EgvVDGCQuEymTy0MQdH0bj3m15iW0Ejuu3OBsgl50y5G3pt6KCGSAt3H6CKgJtpnibGJrDJZQEpGHcGDj47QXjEb6/mGRxUGtC8PyJhWcQna4T3QuBdogBNTGYIJli+S0dsYiydMnCgdAeVM42Ve+uK66Ca9EaBLlfIbS86+S1cdqltZSeCInHit0pB4BOdAe36qsemyNHw65oyKPQ3jwrrohzuJcuxIpDMyxdS55tgd3HFuh4dcY5OoPBDHtMP3H/++bgtnekPmh70KKvtRDXF35GT1jvehou/vEpnH0jv0Vd53gCaDxZtBECYzZnKnDnxun5oqyn3duPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ut2NwWbUsH4E2So8uxB887yPn6RnlUxc0nzg3LwXlcM=;
 b=i6LppFNrq/exNeU+gDA40C/2cfBEv/YOCwygpbhWXR9IdEKzYMKTVWMFr8GflVmjgpmddDDbDDLRnlXLH6PBxvkb8xGh8mj+d0/jGB0s43Ra1YSmLvix43TmZI4/B/wO/BdFStwBM+lrLelwxEXASXr3Um9gN/mzp5b2/l1NANkOX0VADmb1waoCi5hNHxcMGzNEc9Dqld0P55wD+84lE31NQto0A+OE9dqWEWoz2CjB28HW7mvVJX099ewHT1Vb96aC4x/HbISOIi3munrSRShZ5iDbOPIN4WRYtLnAEsRKSGPhgTbAO1xFTDmeXbcFPi5yb4LrnJDFt2A4cuxp7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut2NwWbUsH4E2So8uxB887yPn6RnlUxc0nzg3LwXlcM=;
 b=QlCmtZzvLqWmvIAF3JB9NfXA/wgDzKvy/AtWNnpKuOFUNBVCg7Em1LQWwvvNCGxkRrVNBdZZLPdnIxw3v0mJJpkMYlC+FzN8dUj3a2RIQQBKjNqexusgorRxOAup6qtVTNRSWAya8H7vJ5Z4CsLaOkEb8c2LPWjeH2K3n7cF/ddNzmosGckllw0QHUrA/qo/5HD4fcbSWQt+qwkpu3YlJuYgqXMTZ2xFBNwFf69EyQfnYNEOfQp8CMJon/4QhMJKYimCyQAgtoWmrOup7/68Y6r/nNVrbMcnwvd9WzAEKSwM0pN4YJFzGnOoy1TFYZW6ksYxQOVylups+GcDCuygYw==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by BY5PR03MB5169.namprd03.prod.outlook.com (2603:10b6:a03:219::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 15:23:19 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 15:23:19 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 1/2] ptp: introduce PTP_CLOCK_EXTOFF event for the measured external offset
Date: Fri,  5 Jan 2024 10:23:12 -0500
Message-ID:
 <PH7PR03MB7064E904EEBAAF0992DF42A2A0662@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [wJQKw2oEeDqttmvemTU1qac/dNr5UBEQze92bqbrwh0=]
X-ClientProxiedBy: YQXPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::33) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20240105152313.24235-1-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|BY5PR03MB5169:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d35e81f-72e1-42ee-7cf7-08dc0e023ee5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SZYPq7pZeuQ8yin3fg7jpV6qFui9bj31yTo6zLb4WNlnLLXV+nJDu+JiuXQHSFItckLPDP0aj8ZzBrehhPVsk0UPYrFXMFRdNA0qUBwYloFAsfSU+YlLJQk+7hhZlN+QR47CYRWJmI9lPDpduoeQjwiC7J/4nE/dDHwRphf6fmAG9LMsCRB8JSYYiO4IyL6YrdeLAR9HtTbBc1EF8c6GEfS2bYQrbqEXdp7gtdzKO0Z80n6Ui7GOyJU5ckCrwn3FgDej7AAp0cnYf6DfZdWkAUFFOxMuoXZW0EtaeSh3KXITIS66cS4qboWuo3rFnc/dP875pd6LyE//hMnq2/gu/NCozOzFr5EsKwfGnrBtlwbLnS7fxGlXChnF9NpSw1ONMNA8Y+53YdXBAdkqsWCr7CPFzcj109Qf//3GA+F01rvzrADegFXHPp4F4bCgMdKPqmS61YUURAHS4gNxi73ME3/5R/b5ZenGVV9DOatiL0msXsxR/u/vDzlc2lnkFDp+1B2XHE5HxFvQVN/ejRBtTWuutBZ/qsgw0/XvLl2sHKyysQQBOcAv0BgMhejE23dh
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KajItIeKGQFtoNCy++iQBSSl48az0+qknyjyHWDR2673sFi97JDbvcRJxLZN?=
 =?us-ascii?Q?ZGq5aBZCJP226+f8u+GYYSsRd8/cFIzksV8AsJwrM2AZmEJ/MdoYWtF6wjqO?=
 =?us-ascii?Q?0Jkrdq3+YCjjWPU/sp3TU3R5f7rRavtp5g0rh8s6b6h34V4rniADNVtArUUI?=
 =?us-ascii?Q?iQtaBNXFSgCbs5K7gtSJ0er5HCQiM/wJSsNKESFbzuRh3xfowKNN7xdov2xc?=
 =?us-ascii?Q?5fSZZ30NNW488dtprBNfLKBRG32MKC1Xo2cH9dqSIl30GpCudddMfVFp+cNn?=
 =?us-ascii?Q?c2UsvoB2a5V/ov7+fUPEWorldFrti9JKlOkTta5Y7KIuybHvoZQelIWuM0S9?=
 =?us-ascii?Q?OwgVhvpvqbNh37/vEaV2v/I3iwMEQHIxDkQ220xlRGIWFlynHXNv7Z7ElDWk?=
 =?us-ascii?Q?AXP9tYsVArFgq0le3WF5nO7spU42M4lpfMadBu23D/xSeqLEEhX1eFQe7HMx?=
 =?us-ascii?Q?LEMsOb+6bRNYYg7NP/8twbWFbqdV7wpqngmCkZsQLdbz52TTJb57cVZiHhUZ?=
 =?us-ascii?Q?8JholaJ2+XmqrApwmpDZd5kTxsyZXW5OGnMVt+fRKQutGM9I7Kzgpd/3wCdF?=
 =?us-ascii?Q?B0ya0OMNWDsxo502SAtDO9v9k9w1b7e8wP0fPj839R8WiF1alBPuwF/0kjwc?=
 =?us-ascii?Q?IzktHrE+1dDntHHnV1CSel/1Wxkid+GdtYeBZ/eNnKj/iHW43Rv7beeQls3K?=
 =?us-ascii?Q?miuTCeK93SWMfyumLGDEEaYQEsXcUsF9C/dFONgxPH+sDv7h02QlL6bDiC14?=
 =?us-ascii?Q?0hhrYjsVB0/4wOdNQCdWS9zHzVeZHUNJ2B1BYjuhNZQselrMhgBp9oWnUOE9?=
 =?us-ascii?Q?XKHcfOZuHrajEbSJK4LjSIxALKLT2kFeTWYOGAJDG1+igVphdo+9sfaW6Rxz?=
 =?us-ascii?Q?pPsFaWvC3C/jAQ8/PaJVTebxbuBI3TmGHDONzeSBpf8kNkZOsu0g2mjWnuGd?=
 =?us-ascii?Q?JJs/4wSjPTdzkrIVFGd/a/Ri3IrSsNwiXpkaAg6IPpviD+ygRP0pzaoav7YB?=
 =?us-ascii?Q?UFiLovQ3mLNnciD+ZdyxZsV36OOs9akDpWaiP9Z6A9gGhx7Aj6CiGUz8Iq6U?=
 =?us-ascii?Q?IeNMdQMaOlT9SmMLGhT0hsfWJVogcqEVFvLjPsbYU1FNxgDOh7cOzFtTlaKK?=
 =?us-ascii?Q?w2DyPgrdOg8EMUlfmZkC1sCX22j1q6py8PJ7twYdr30CzxZmijKi4/B2jWb9?=
 =?us-ascii?Q?bAZL90zLqHYNrm6fVvvVYqaFc6JUGnUWy0N+2g=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-839f4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d35e81f-72e1-42ee-7cf7-08dc0e023ee5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 15:23:19.3562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5169

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
-Change some masks to GENMASK_ULL suggested by Jakub

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


