Return-Path: <linux-kernel+bounces-4099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C348177E9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2341C23DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F079B4FF71;
	Mon, 18 Dec 2023 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="u7T6scfS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2089.outbound.protection.outlook.com [40.92.41.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8AD1DFCC;
	Mon, 18 Dec 2023 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOutIYaW2ABg5gbhSV5CW/sHnCivO0pLrvsjQQqsgpW2ismgQHHiHQyvrSCBOJbvNymn5y4pgCu/getlPjizQMbkxpn33i/3lNyg/eoUEqlHG4YAEcpyBiDRQTofm6AphnCCA+Xm4fHtX9PNgWIkACzOwQM0l12172kLEeFX8uxgkCTCXkhnO4CShFpib2kL/ekZu/b3GysL47uRIcZgk1QQz9Wc8fHcBtyMyAfMAwnBZ6LQ54akyk1W+Q7v4vcNigzirBWX6DKhnfarU06FunVoRB5I/kKY25IxO/sHviD0XE1Qp0xARB6ZPprSK7s2y2rLiNnMEUXhTETu754K8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6PHe0F5LxV8uq3z3pimbtekyUzBsS+ZqRS6804+Uo8=;
 b=ABrE/twOjNHE84azAJ52OmjvxJjFlweg+fJ9OgkQ6oiX4BuNr/+13qFhNq8gI1KDvECif12zSXy+dziM18Yh5nvhh9ZEX2y9f+VfxejQkEjjgAw/hrQwvTpsa44McVyJC8p7hjSaAzJ367Uxf8gngc0hH1wO30LZa1LUMWrWY3fFziwi0LB7urdaShtKRJINNQpqIeP7D1CbDW0fSR1byVQ1mjZeBypWJsDllPvk7UBC3ahjB+S+/9qoT694MFnYMK8yt4qrSnsCdkHs5G5VL5mWt6kuMOHbpE3+3iWLY2sLWlyNSFGDJHfFLxwe4fiPs2sMiwDaoQd1rFZcIKrPGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6PHe0F5LxV8uq3z3pimbtekyUzBsS+ZqRS6804+Uo8=;
 b=u7T6scfSjs20XLrMpcAUlanuiemPcLFeMczsNqfzJWpTXyXqEomk070Ks4TJabxta5rM2EY9YlsjhpthmBb89B91BxOxKxsyJJ+DwXIn3pNhKEzZKPvlKr0OOuLAnPb/hx6GaTGV8D1wwRP8+e0CXq/qMWNbdnEOfGtGxXFYrwrvSmLpr7Hw8obNcfR/PwRE1S2lOm2suh+EKxV0C02Yz33Crt79GXw0eJpkqWIxKguRgogTZQeLj57SQ45/7Z+jCWEuUGyI+fjxoQAIHS57KX39uveggH6K+UEeZDxFEn2LveKTwtD45MogolNOwJhtc2+jd5ccN/ve0RKNCZOLiw==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by SA0PR03MB5594.namprd03.prod.outlook.com (2603:10b6:806:b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 16:51:03 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 16:51:03 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v4 1/2] ptp: introduce PTP_CLOCK_EXTOFF event for the measured external offset
Date: Mon, 18 Dec 2023 11:50:44 -0500
Message-ID:
 <PH7PR03MB7064ADDCABE34B67FA9C30E8A090A@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [5YIQ/VLBIATvFS5JF5x3D4rh3MNUFtlnt7cmqGSanGQ=]
X-ClientProxiedBy: CH2PR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:610:5b::12) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20231218165045.27847-1-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|SA0PR03MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ce62af-13ee-4496-6418-08dbffe984ca
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YvzxZV3kI69P/a8s3ffOgP2DgSBQZlOcjrGGOydtCGzlDwEl159/00/u9RdIWzXGJ37ifD5g5jnQDi1PQzVBbDww5T/tVzXEItz7/WMgaZNfVBmDemH2odvqcEPkY9VmY2W1G10SJWO/GWLAqdIexVnv1e75zvwQ+VZyvMY1LtEFjiG8hNaaIQJQNLo1g+W5KxtfO6pZxtPpeZmLfAH4v53IjHDU7Qheso5EzEht7yuB2MLm0eSSmAZZZRrRO8DOEBNevigvqOnqA8V/ycuE8EL5nd+lhoKd3PkbM9SOD+Onw6SDXTIdGXG3jZbRIIon1dRVEyY6gkDd/dfg823qSa4nRCZz9zIWLn0uw6yI8yFSoF4PR+qCjX+CxpPk7CuvumBIKD5SmbI0TjiTogDLpZtASHsCYw9oy3EN/su8KSKpxsTCvG5R470IoQ24IQprI3UDwmB+gmtJyeGyLUKyvCWqLTDwB3PZLMhLNRpzfJOpPx3nk/6a6to5UdtfF+lSXTHCIJhTpm4EIJa67AtPNqBaq0H/UMfYPLbNmbZdQIvIlPuN8z9sF+PEiNhqUXWJ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wK+ZSr/3gfDLgonVO5L7fzRWk8ty/Beb/uP7DOjN8FxRvm1bbwsdWMEoKRsL?=
 =?us-ascii?Q?jKj8FLnQ+LOQdeVENk2bv1uIinbFcqpZEew3vMyY8XJl7eCZgDMWp+f+Y197?=
 =?us-ascii?Q?eyHHgqT1MHaofV0zKGdmV5y9dB5wFWnpspl9ExZcXhAPjNR81peg4+QcPLa7?=
 =?us-ascii?Q?7K53t7FB/IfTz7D/ulSyvbAl3KD3yPmezS1Q04ZMVS5C+KwAK20EYUhdi8Ii?=
 =?us-ascii?Q?1E+X4LGen1/pBMlCb7SHw73t37rh0T6PtQFWY0gip71I898Gt9gh1VssUisO?=
 =?us-ascii?Q?06ureB0ExLzgcpVyHhDAcEYR2W8ODZWntB9jZJ+8I81W4CRiQfl6vQIHawAl?=
 =?us-ascii?Q?6Ou3Rm+t82q0xyWXsjMUniWf2ePGNWI+skClEnZRWT9Ot06liAL7ZygoJR/K?=
 =?us-ascii?Q?41W84qXptFtmPYCAeUdMAiI/9IH6RZqJEw2AwRRBYt3nOBJmOW/STNqaDf1/?=
 =?us-ascii?Q?BM9/GuyibyrDWG4J4kHq/SBOzpHq8aRI/2jBtbT6dJ9yrKLwjXGWglX3pGkk?=
 =?us-ascii?Q?vqWOwo9p/5uKYxjIV0YmX5vM2e8HsO8AkIG3keAbx/DwhyvsOIASUK2/LKWP?=
 =?us-ascii?Q?LqBRiAGk2ctZVJtrhhED0IR4muqiIiH3zDfaJ/i+G+ZRd1h7+6Esk52fVTsU?=
 =?us-ascii?Q?OofLR006HiL1+C21/TwcKYicfGLsXlhgUsMWUX5Pe22cGkxqfxhoFzA9ZUov?=
 =?us-ascii?Q?jFsGadTgBo+HuD2gBabnlCQtU4Z10GOm/f4lG8kMAEMogh3cvMZ1j+qz3qpM?=
 =?us-ascii?Q?MJn05dHd+83v/vHVZdRizjcFurcrapsI90J3LcR6sJVI/DgQhO0pi/ksBq7o?=
 =?us-ascii?Q?ZGYclq1viPMuu0udn2nyj9iWZITE84A6Pl78n+aBTSWZrbOWZhqP5VJldTpK?=
 =?us-ascii?Q?ZY1WE/w+Ci8LtWBL9LCr7d4a6x8K97Hz4q0oGXQ48YmtGZNj1aehxt0fC4pG?=
 =?us-ascii?Q?T3y872PlNAuNtUusMipDoTZF1czsZXlJkX4bpXFq1i0FNslVyhe5IcpLEZn4?=
 =?us-ascii?Q?8Q4w4NokaxKIJormDlev0i6OeNJpGKgxHQL6rlsr/YTT7pgdCmqIINUwDCL0?=
 =?us-ascii?Q?ccBeCMKJdBmgcxMU9jz9Rxt/vLZmEg5mBJThwWZW134S+uOIJEKmG8P3nhwr?=
 =?us-ascii?Q?oW48x6e/DVeG51fCLEXXfZwSAj2z1GV1cgjyo9tslHtQ2x+j5uLqAfmaKlIN?=
 =?us-ascii?Q?FzCn3trbJUZt+Xr4LT9U7T7DYVJiCidJTX2m8g=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-839f4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ce62af-13ee-4496-6418-08dbffe984ca
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 16:51:02.9053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5594

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

 drivers/ptp/ptp_clock.c          | 16 +++++++++++++++-
 include/linux/ptp_clock_kernel.h |  3 +++
 include/uapi/linux/ptp_clock.h   | 11 +++++++++--
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 15b804ba4..d6959f458 100644
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
+	dst->flags = PTP_EXTTS_EVENT_VALID_FLAGS;
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
index da700999c..a299a0ae0 100644
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
+#define PTP_EXTTS_EVENT_VALID_FLAGS	(PTP_ENABLE_FEATURE)
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


