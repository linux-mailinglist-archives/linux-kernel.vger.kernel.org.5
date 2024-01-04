Return-Path: <linux-kernel+bounces-16948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF18E824664
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929431C223A5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3EE2C1B6;
	Thu,  4 Jan 2024 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="FTVSsfA/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2066.outbound.protection.outlook.com [40.92.23.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B02528E2A;
	Thu,  4 Jan 2024 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAxwJSDmXNhDvYxxcR/jipB7DuerJ5TMWOdP/PwhpepoZG29zvHWuGez1nUx5HbxM04dE+6hsFdMhGqSXkEUv1x0CZRPxYf0BJtOI6JUfIHveCHdTm5Mt078vNny5dGue6wn6+fn4a4qUukDRs4D8dThaVPKxcqmSw2NVe6GVaWsSHifT1ZPMZ35SFujgfOSP9tHvQlsrq75pqZOrg2o0kS5UXy5PJ+TQVK36ybNhUxoz5xMN96KJfuBIlp5y1mY79dUG6FopKqBI1WFq5uB4+F7YJz0E2U+FwTnXeoi7BvtdPocm2zRgj6KfKfn1vBpbvJljn9ygxPo3mQXixguaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoNEDh+iFq7lzKBU9CENiMetKrSdJTglln2bu+84U0E=;
 b=Sqmyy1nbVKi9C0hAH4ffNUi1Bq8aLHn11jBB0IPXaJmXsME0Jc4GmaN2zssLvDtw5R3u5iATJDlkv/JAj8DN/0RE8NNPXvnNeZdMqV+LZd0WZuofftD3u7L+qHcMpJVUHClmbr5Gdu1LRuxw/Hl7xKt3jwXbsIj4O6mTcQgYpQYNFapWI6e/uEpMUXH43cPjEFp4g2I7r5xzVYMrNarpSOUUTwvdonY/a+d/u3QfGxmjeqvbLSzVQUHeLSOYLSBscgUiiIMSsyrKWIgLLhOK9pwAdt9AaXbZbRG3p+25rjcXT4JlUdWg/g9cDw1tdAsjA/Klr4JrtdvahPZWSfmYhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoNEDh+iFq7lzKBU9CENiMetKrSdJTglln2bu+84U0E=;
 b=FTVSsfA/qrcxD1RNAFjvbSTpcdQIeblgb5RxdHsUwILex/EL9ODHk24SGnbuqQiX2MKtqsb6zhCodLOwUHvbGKo3Hf91TeieeTKIOFBYQRCCcQt6e3lVfb5QS/8XhSUMbDlGeCC5sEFcvGzHeH9r8avbxyUSyWsX21i5LA06U//nDyvO+aqpflFbkkchZoQpHlLkUhhzWbCKjtcPjFfJt3NOKwYIAiTnWcmHNzOASex8XyTGtnXGgLFHSgnab76ORU3b8ht7C5IekioHGkFh0NqlSEwHgyv3bgCdbG8cRWdaH0gFUqp6OIeoeuFKORLeS1jesCO2BWIR2P/u8dTQoQ==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by CO1PR03MB5906.namprd03.prod.outlook.com (2603:10b6:303:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 16:37:03 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 16:37:03 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 4/5] ptp: clockmatrix: Fix caps.max_adj to reflect DPLL_MAX_FREQ_OFFSET[MAX_FFO]
Date: Thu,  4 Jan 2024 11:36:40 -0500
Message-ID:
 <PH7PR03MB7064A4963CF7B4253AA93066A0672@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240104163641.15893-1-lnimi@hotmail.com>
References: <20240104163641.15893-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [kCjdPannwpGZwUlJY92rd/WczG3Ge6D/EX/0Aev2+5E=]
X-ClientProxiedBy: YQZPR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::7) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20240104163641.15893-4-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|CO1PR03MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e020d2b-a4d4-4371-3d54-08dc0d436195
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9oXelECY2lvfia3O8CKs7Ut4lFt/CYduzQg7jNfOJx/weCFVCnhHS+c2xQFVB7XcvsKEtQR5A2M7uSy1BcE3LFN+5XCrbGpT+AP3tbHeiW+p2QVBXBI0St40Vm413EgeUGKFupguvJhJR9jO2LjpQ8ZmOeP4P4yzKSRSdwWPBf+lTiPOVaq8+Xbc5WxdgKpdzOWp/NDiCWem7+LfHiP7ebtweoOMGrapM5oSTKdb7uT7E46WdgdhlVBK19lb/v/PPlWCZOt/GkM6HQZqxkQIvBlp71B6vHDoeqE0J54UyzIUzoK/4lUQyEhWh6o+1Pob4VrLgIGpTHm0nC/MN48/+S57Yi3raTCWholJl8XKsGsMvjhuxeRHJsYKd4yfN76r1J9K3zMe4HsFNgBX81hcpeY8a8NFLb9S10r3i90+dJPT8tlacjKXyoEO6SMwMKviN91W7K1tms0eeowcIUbudgIcdoF+lp64sBHo8zSNwjVROZhJhhOcFwmaY/L8b5aof/jlnbEfdIySbCVvOqDLzvdCXg51mE/CkEfSCuJzFHBi8cB43L6h1PbgI+4TlkzM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZSp5bTosJH9JU6ogzn8E2IiaiCBxwbEfjzhVU1v1OzpTNtl9N9pA0/JhwOEX?=
 =?us-ascii?Q?3bF5H/E+8rZs2oQyTSkSYTdjWQrdvcy6aIxFMT2XMOh12MdKCzeiRqRYEmOu?=
 =?us-ascii?Q?n4cvMOPSHVG/YlmBFAMg9AoJCPHvrM6cP+iGUDWUMcv9AMmRXK2IGi+tb0WA?=
 =?us-ascii?Q?lsFqTuCgJbeE1qQXEzJS99LQTwpHug47knf9mDSvKhD/1n9J1hg3+OPnRR6f?=
 =?us-ascii?Q?3apD+j2C1dkiH9EQQJbDGgmQMqMjQ2238G/1FIFkAd6O8ffo5qNDlj/jtElY?=
 =?us-ascii?Q?ldeHkz4co+abmNVpPX89Q+wKRw4TKrMh+h0A6BB3kFtJ+sjqbGf7w79N8vLR?=
 =?us-ascii?Q?+8ErSbY+RP29RyOMoD5npJtFi8eZaYv6JOPtqDIu6JN8QSdoIBOmpqqGIAsc?=
 =?us-ascii?Q?gpefOKRNf4SbN6f1KovVt4h4+3m7s22iastSoUeV1AIW8412x+ePiZNKAUIS?=
 =?us-ascii?Q?p3pa79Gfsus03mdYQdbGLDlh35e4RyeuXDd5bIF3E0OEp18FX5TdOR6Nyzl9?=
 =?us-ascii?Q?Mw8j4W3whmerlO5t5wjVdlGllfmAP3YXtVnJ1XSl0RdMLHKUaQl2KkUpx2kx?=
 =?us-ascii?Q?Jv5hWhTL9okXwMllyIwRgyTX/ix9m9+OvQzdGgPZHcPtN9K4oWEHhsEcpCLY?=
 =?us-ascii?Q?kx6rgpSRwZbkUQfxRbpwqFl89qwpSnI28oa8HAny3ChbX/SNhs2REk5x2MF4?=
 =?us-ascii?Q?bh9reYHEknkmnuVVThnW/LlQG9RogYyIq9txJIRplV+WeHubaHeGRi9yeuvw?=
 =?us-ascii?Q?gUc3c+hysG+RqqRAc5TtK3BNeVDjgL/TWFvRJiAKE7dx0QUliZspzZgrrk8Y?=
 =?us-ascii?Q?ypMlUi55LfsATXe0gh76MsnLJcp9l5EEEC+l0mf+9PFWNYF3+Yx2WJWBrtUR?=
 =?us-ascii?Q?XkX/zpwfmJFtq6lkdWUy0q8nhVgjfMuXbO0TQEvVP1c0JwFLg1OzaFcnzKj5?=
 =?us-ascii?Q?KIFUw+G2yolX6e+DHP+wp5/K8Oe0gjC0qFSusP4FVE2TuvHYJaXvRINcIs4G?=
 =?us-ascii?Q?5du+ANHrQw699oBlDwgiiB6PC9Y3t2cuuTKmd8MvYXI3+gtxFRYEsJWUln2w?=
 =?us-ascii?Q?eR+4IYxrJnTA38bvC8V05zggloLOn6FLRqa9McL4W+/HTzSUvaGMQWaGKpEI?=
 =?us-ascii?Q?etjfMMCN1QMRP8tYFbltOpG88pfGW2EyGEaedb6MHCF709IwMLPNHRGsPFD4?=
 =?us-ascii?Q?wfSeq1l10WKWs/D3qbJwo17fYA1Kk7x/S3WtgA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-839f4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e020d2b-a4d4-4371-3d54-08dc0d436195
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 16:37:03.6320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5906

From: Min Li <min.li.xe@renesas.com>

Query MAX_FREQ_OFFSET register to set the proper limit.

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/ptp/ptp_clockmatrix.c    | 43 +++++++++++++++++++++++++-------
 drivers/ptp/ptp_clockmatrix.h    |  1 +
 include/linux/mfd/idt8a340_reg.h |  1 +
 3 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
index 21f3a2c179f5..cd7b3110f8e4 100644
--- a/drivers/ptp/ptp_clockmatrix.c
+++ b/drivers/ptp/ptp_clockmatrix.c
@@ -1038,7 +1038,7 @@ static int _idtcm_adjtime_deprecated(struct idtcm_channel *channel, s64 delta)
 	s64 now;
 
 	if (abs(delta) < PHASE_PULL_IN_THRESHOLD_NS_DEPRECATED) {
-		err = channel->do_phase_pull_in(channel, delta, 0);
+		err = channel->do_phase_pull_in(channel, delta, channel->caps.max_adj);
 	} else {
 		idtcm->calculate_overhead_flag = 1;
 
@@ -1594,7 +1594,7 @@ static int do_phase_pull_in_sw(struct idtcm_channel *channel,
 	if (abs(delta_ns) < PHASE_PULL_IN_MIN_THRESHOLD_NS)
 		return 0;
 
-	if (max_ffo_ppb == 0)
+	if (max_ffo_ppb == 0 || max_ffo_ppb > PHASE_PULL_IN_MAX_PPB)
 		max_ffo_ppb = PHASE_PULL_IN_MAX_PPB;
 
 	/* For most cases, keep phase pull-in duration 1 second */
@@ -1880,7 +1880,7 @@ static int idtcm_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	mutex_lock(idtcm->lock);
 
 	if (abs(delta) < PHASE_PULL_IN_THRESHOLD_NS) {
-		err = channel->do_phase_pull_in(channel, delta, 0);
+		err = channel->do_phase_pull_in(channel, delta, channel->caps.max_adj);
 	} else {
 		if (delta >= 0) {
 			ts = ns_to_timespec64(delta);
@@ -1927,9 +1927,6 @@ static int idtcm_adjfine(struct ptp_clock_info *ptp,  long scaled_ppm)
 	if (channel->phase_pull_in == true)
 		return 0;
 
-	if (scaled_ppm == channel->current_freq_scaled_ppm)
-		return 0;
-
 	mutex_lock(idtcm->lock);
 	err = _idtcm_adjfine(channel, scaled_ppm);
 	mutex_unlock(idtcm->lock);
@@ -2054,7 +2051,7 @@ static struct ptp_pin_desc pin_config[MAX_TOD][MAX_REF_CLK];
 
 static const struct ptp_clock_info idtcm_caps = {
 	.owner		= THIS_MODULE,
-	.max_adj	= 244000,
+	.max_adj	= MAX_FFO_PPB,
 	.n_per_out	= 12,
 	.n_ext_ts	= MAX_TOD,
 	.n_pins		= MAX_REF_CLK,
@@ -2071,7 +2068,7 @@ static const struct ptp_clock_info idtcm_caps = {
 
 static const struct ptp_clock_info idtcm_caps_deprecated = {
 	.owner		= THIS_MODULE,
-	.max_adj	= 244000,
+	.max_adj	= MAX_FFO_PPB,
 	.n_per_out	= 12,
 	.n_ext_ts	= MAX_TOD,
 	.n_pins		= MAX_REF_CLK,
@@ -2242,6 +2239,25 @@ static int configure_channel_tod(struct idtcm_channel *channel, u32 index)
 	return 0;
 }
 
+static int initialize_max_adj(struct idtcm_channel *channel)
+{
+	struct idtcm *idtcm = channel->idtcm;
+	u8 ffo_ppm;
+	int err;
+
+	err = idtcm_read(idtcm, channel->dpll_n, DPLL_MAX_FREQ_OFFSET,
+			 &ffo_ppm, sizeof(ffo_ppm));
+	if (err)
+		return err;
+
+	if (ffo_ppm && ffo_ppm <= (MAX_FFO_PPB / 1000))
+		channel->caps.max_adj = ffo_ppm * 1000;
+	else
+		channel->caps.max_adj = MAX_FFO_PPB;
+
+	return 0;
+}
+
 static int idtcm_enable_channel(struct idtcm *idtcm, u32 index)
 {
 	struct idtcm_channel *channel;
@@ -2285,6 +2301,10 @@ static int idtcm_enable_channel(struct idtcm *idtcm, u32 index)
 		ppd->chan = index;
 	}
 
+	err = initialize_max_adj(channel);
+	if (err)
+		return err;
+
 	err = initialize_dco_operating_mode(channel);
 	if (err)
 		return err;
@@ -2437,8 +2457,13 @@ static int idtcm_probe(struct platform_device *pdev)
 
 	err = idtcm_load_firmware(idtcm, &pdev->dev);
 
-	if (err)
+	if (err) {
+		if (err == -ENOENT) {
+			mutex_unlock(idtcm->lock);
+			return -EPROBE_DEFER;
+		}
 		dev_warn(idtcm->dev, "loading firmware failed with %d", err);
+	}
 
 	wait_for_chip_ready(idtcm);
 
diff --git a/drivers/ptp/ptp_clockmatrix.h b/drivers/ptp/ptp_clockmatrix.h
index ad39dc6decdf..31d90b1bf025 100644
--- a/drivers/ptp/ptp_clockmatrix.h
+++ b/drivers/ptp/ptp_clockmatrix.h
@@ -19,6 +19,7 @@
 #define MAX_REF_CLK	(16)
 
 #define MAX_ABS_WRITE_PHASE_NANOSECONDS (107374182L)
+#define MAX_FFO_PPB (244000)
 
 #define TOD_MASK_ADDR		(0xFFA5)
 #define DEFAULT_TOD_MASK	(0x04)
diff --git a/include/linux/mfd/idt8a340_reg.h b/include/linux/mfd/idt8a340_reg.h
index b680a0eb5f68..13b36f4858b3 100644
--- a/include/linux/mfd/idt8a340_reg.h
+++ b/include/linux/mfd/idt8a340_reg.h
@@ -192,6 +192,7 @@
 #define DPLL_CTRL_REG_0                   0x0002
 #define DPLL_CTRL_REG_1                   0x0003
 #define DPLL_CTRL_REG_2                   0x0004
+#define DPLL_MAX_FREQ_OFFSET              0x0025
 #define DPLL_WF_TIMER                     0x002c
 #define DPLL_WP_TIMER                     0x002e
 #define DPLL_TOD_SYNC_CFG                 0x0031
-- 
2.39.2


