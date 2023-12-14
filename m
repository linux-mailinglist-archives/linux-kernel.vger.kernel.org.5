Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A95B8134A9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573806AbjLNPYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573783AbjLNPYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:24:37 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2074.outbound.protection.outlook.com [40.92.21.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15751129;
        Thu, 14 Dec 2023 07:24:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShTUr1L2QRE99cmoivTLgRtjm++lAEQUOId6k/Q5frFCke2uW/MvTZBPZ/FVlQoYbUhpU6g6QFISeC89Wx6HY2sx9UGHfydvLK8pBWa/8JXkPAnUCgt/jASkcAsL89y6ydJqSuAlzYmcDNTZdcuLj1alvuGXsPMOwhBElQ4A49GwUMgNE5h3gFb4KpDvPHPxd/9PB/+UxspL5nep43ldqF3jSAmh9AcVHMNQVnI1mBX7LDQVjt+eSnNV0r9HI8rGlIYQSTtOUNtzUQTZvnCFBp29K2tu3p/ckRhSiSBVPUceCpBGMBpbv+rXhV6+ZP6xZpFdx3IahzAU8zXvjJnFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoNEDh+iFq7lzKBU9CENiMetKrSdJTglln2bu+84U0E=;
 b=B6jivsS13K+3TPiFLhXxZ8U6tNAFRySR40OLIMzJLMmazjqC03xEVhY79YKFGG9qvSXRcv2yhtbFILgapQMb0IJnA57xW8bVl9lXAoXHDIVlfovfSHpVB2kpRMWBW/swM3G8qWb4AEI6OMXZbHWSgszRv1xpiO7zlMIYu2thqaN9LOMX/vfuzX06XsBAuPwTWYfenngdoplDI8JGSiy/2nb/NmzZy63pqzL35pxJXMCqVPvfAUd61RrDXwpv09eJCjQoWB1W5NTtLDKYWBJksJ+ZrmaVWC6BUtZSL9aq6B2IHaeXmbIY/2CE+jxsx06Jw1H7LUROlAh2WzTYvs27QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoNEDh+iFq7lzKBU9CENiMetKrSdJTglln2bu+84U0E=;
 b=CQ0Exy9vN1TZiJVg9ahVZT6kuaFROc0bpAKjJexsM2/BrdMimoocjfg+3ttj9GvaKh1FpbATQcYBMEx1/NMqcJIRKymv378x1LLABOg2gE3uV6eBG59DpsidKg+LA6eRW807R87DXqyrgLDhvimpy100LGPYs64nJROhpR75QtiOBL3LM2Xq9oMl8MywD6XbkHBYJJ/bFKb37mG6oO/CHRft6ONIlqZPVTyO5GC1QmtyAFv23KMs11nz36Z/OQL59S6wViN8AS5trB0HxTUMHkM1bvDHokd9rDjL83P3zSagXh4f+HWo8I+VJQpEUm4XAIZlafiMqnOr/YyAU8YXtQ==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by PH0PR03MB6252.namprd03.prod.outlook.com (2603:10b6:510:e6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 15:24:38 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 15:24:38 +0000
From:   Min Li <lnimi@hotmail.com>
To:     richardcochran@gmail.com, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 4/5] ptp: clockmatrix: Fix caps.max_adj to reflect DPLL_MAX_FREQ_OFFSET[MAX_FFO]
Date:   Thu, 14 Dec 2023 10:24:14 -0500
Message-ID: <PH7PR03MB70644491F202E3DD1B5AEFD2A08CA@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214152415.14785-1-lnimi@hotmail.com>
References: <20231214152415.14785-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Zmgh8/LrAfv3pRunp4/7BqZVFRCV2xZaqNIjZ+FdtDk=]
X-ClientProxiedBy: YQBPR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::26) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20231214152415.14785-4-lnimi@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|PH0PR03MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 55baa87e-8796-4ba7-2935-08dbfcb8c8c1
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TXOoQ+pjPDIk5RZzV0uR20bz2AcA2n9+dedBIoQPdsBlFtdcVOno3WjbDWbU6XRwkBzE4LQ89iao8aqEDUyaJdN6qQrChPQKSxm2IsbQYfQ7HzWyJVaiFtKTIKl24WqYfLPy8J8itEgfvNBLnthc5pBgyOvW0Meao7pHDGILFDnhsO4FVO5tMvavhA4hRgfEleiAePq2qK0PxnxG0LkzhmEBw6vU4Rc1W41BX2ZyTAtBU+Lz9FrSuwI1WWsz6Ns9PMAgjEf7Oz5JU01fUqRayQI0KMWiVO4cmIyFpFsgusMHna+DKOg4aBk0CMEef8ksXROH7sPhUS/aTMtsr/OHDwl9h9n3B+G/EdQIN8AA5kUoUd1ztwRBEkiSzy9izVg5x7lld5UbusUEpKbKRrXw11kV1eculiwPM8r6zx0/6E0/3fAq8mijHUxZsYwaj0gAjmWMsqHfQCyCSWU5ew7v8Yeh3B09KZ2sba1jBSUWDaxG3FhSa6swcH7LnEjVjtUNlNuUIseOu7tAJRGxGM29W8CB8J3oQJd0shpMkpnGlghFDZaIn1DQQUyC54mjPV4Zb/77XJgMFs8uhup7fFzGySsCH+05rcR6s8mZVWdT2+dHK1mE7ko6CNk8mH/g2VHzWD/neuUS4O5JOmw66InjibmADJVEib1AeiodT52fJ9FPpzZ3Knq/qldUesAWsTCK21ikpGL1pFhjEt4foxt52mEgoCD4JpVFltVZHM2qspyNssmzMqVsJxfF05Tqsi9N8xhT0595aN/zH6/60onCtXd93sEiztTkyk=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7rAlQkTMQBE6kEsn7hzc9Hb4YeYaH2hrNuyqBC50JZXZoRpPmktEqHb7wEcB/0xGSX0eEfyH2f4FbtGHGZwbGougS5/8HQlQLxKxgpZhBhwxIbynosHv3YUpnLLDTYYfOAr43gTeThjSvEJEYCCSeA/xGZEQ/OJP1q2b/gd+rI2WcMfkNX4JoHNDjsfU55FJGI3bLqC1VG54H02KmOIaXSvibCKU+RsWa+KW5yo6kO/kVkWcjlRDYTOf1F1JsDhRZwcvWInTbV8qFqj5m3zHMpDZrhvwWkLpn39WQrQdUOLeYYlNquEXoDLeGNKUyNv/H/TbucJ14RC47FUC/IM5lCF7BfB0Ui7BGJz2lfSDjabpD0UgHszSzp/SKA2LUhAyUrvdkwbyU207OMfPhG/eSKibjzMY+2AryKxrWd5wzxNbhLJhgSFpb+UJ8+6in2uLiM7ata2sESE+RN/67K18POxhprodNkoLcWWeIlk/+1kolJKnSVvBzauaV9xURIfObHBQs3+kwLIEiMfVjXKzrYB8cqF1JmPFFq6dqFrhVJWB/xoTcl0FwTvc8SGLZwO
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RMGRqHa9bxnLay59SrF7+itF965OcHRVqWQHeN2cr1EtVgWORkN7HvY2H4qK?=
 =?us-ascii?Q?b5XjMoLMJNTds/1445zoWxq9bIzRV6eNIX7Xnvyqx0VeRbiRpK/M4rf3RRvx?=
 =?us-ascii?Q?fzkBHGrRhSY5AroH/m4tjq3FVuUJrMPk3CQd1ve/vF6Ao7dEyBoFxuhVa8WV?=
 =?us-ascii?Q?AHOc5BFxugY2wn9thJNsBVxxOaR3fz/z7rgMV2zOcHhHsr5jKeZaCOcDfedv?=
 =?us-ascii?Q?DyvxN4iIqhtQTntYSqz7V/A4OsAuTfX3HIYMdSh8rGAbXmFr3UnSWrbNxGyv?=
 =?us-ascii?Q?bOBzjCgWqXRA0W5RbzHMeYZN8UWlK3JHJ4tz4diJ4zs2YthnaXlGgHDEsu/U?=
 =?us-ascii?Q?iaCM6Xh1PQPC7akw/yydCwT8YgST53dIqEIPHWoCQ/Dmh5NX76KP9Oc86MyY?=
 =?us-ascii?Q?72PDK4oWguSHizF1yExwk3t4qRIRG+f7F+FQvbleKjv3s9i3tdB2zGbOCyMo?=
 =?us-ascii?Q?21uzyxAOR1hNS98kyQbaIwxoH2XVYlNpqU/vjH594Zx7xy3Tfwl2o+ZJ/kXI?=
 =?us-ascii?Q?GXkyC3WS0d3Psm+Wkk5FWLQXhKiKdAAsca4jb0N2V49NnTnjjm5II7MVXxQQ?=
 =?us-ascii?Q?rSIFV8PRd4UsYnZFjMssrYIl85Y1cqilAYLhp3rtq6TX+6ubiQxUotCCfWk7?=
 =?us-ascii?Q?GQ7UgnEU3Ic7mNdUv2Rb5nrp9pkQ2uiMEi9tudUTrlgZ7PgYSINh+BXPb/6c?=
 =?us-ascii?Q?v3/sbsccDRCS4xkS/Wmovn7ZHlpcL9h8FKX4JbMkOzp1EiWePi1Mz9b1BJK1?=
 =?us-ascii?Q?PH8McnPlb8w3PdYn2Jwz4BOMNEv/8i+h3TjVeQPryB7xg8w5Lg8DoKbq/Jw7?=
 =?us-ascii?Q?K2bp1A2ihRLKAHoorHNJFHTFQPEL75k9cOl5Anc3VtVvluJ42kTUNV786aHn?=
 =?us-ascii?Q?tUOz1XnIPkAGOT3rKTtMJJgRFFF0Q7g9QqLgt05EMA9hlF/ntgNgD4DUkUt/?=
 =?us-ascii?Q?QQVIXRvm7J6gb4F1pTlNhHwNkrdOrUwKX1leYvPe4RqDx4pT98EYHsLgVOMw?=
 =?us-ascii?Q?g1U85BP8gbvWspeJr2185D77jvZMJzqouu+oAJ6RAVyGNHG/34mB5e62oZAS?=
 =?us-ascii?Q?p03JZxTXQWhce3aqAAmLUhB5sc9IrIw30F0/8amjeeuuLY8tWVoApWxDBoqC?=
 =?us-ascii?Q?VlKNTVwDXs49DOhKMj98O+em2Hc0wSJq/6I9mfTXIo4okpcrGoYMNGabfzsQ?=
 =?us-ascii?Q?A3rts3ia+K5Gl23tVGgE2A8Z2ujemG9Mt/ANqg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-839f4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 55baa87e-8796-4ba7-2935-08dbfcb8c8c1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 15:24:38.1248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6252
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

