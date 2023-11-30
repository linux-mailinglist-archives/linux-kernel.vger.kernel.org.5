Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8A27FF9E2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346779AbjK3SrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbjK3SrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:47:01 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2078.outbound.protection.outlook.com [40.92.18.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CDF170D;
        Thu, 30 Nov 2023 10:47:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKuJ9NoOjLw7X7ASF5jSmO31DtxKZS2Ou3M0YQ7FIGwCJqsLYQHmNkgdAahZOrfw0dD4dOsrj2XZvnScssrFhU90O5i0vR6flplA3p9BqLo5QsrgjiZoRFNx3NSmmiqpuHJwlEsIaVI6Z/9glMThnBMMIOnvDm0zAcYpG71domWxPO6zAm3oLf9tTfwFmJxzC+SaYts/jUGR1PZzZ6DC85y0Y9+NwDN9VnfqcPdN5YKukyJF+gD9q9/ZVtjcs+cDD+wY4zXfEKPqVXdbg3pwYekoVREP1AuqPXox2H7Q5rjAZSjkhSxkj60vGAinwp/qxqjMbVGlziaskQDkOcMqUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoNEDh+iFq7lzKBU9CENiMetKrSdJTglln2bu+84U0E=;
 b=hW0i0gQ0UoBY4EtRvoQ4yOnCJJ/KtxHasBVVDEO3wTznY4aC9Y+6H48wb4byQWXyquOeQJAJeBHNgJN1enCAu0GzH3LEpeSuvOgxBZpdLJa0yEATm6YyDIKsudT6Gs1v+2cy4QbNNYdM634NWn5I1JoqsZBuXe2H5nR6YP+dWcKMqUCTqkPmhQWE91+Z+E3Wqz6ecWNCCWob6QxYhLcyP5Xhmr23cxb5bvEwCFZ387I5ZtsZ2+q815WJ9AyPkePKJ+xheS1friXss1gdaMg5DKmBg0+B9XT3EDO69MmoBcVmlxQB7H4mqk+4pIiEIDQ14BAyvpdrN6/s8OnaM5FlVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoNEDh+iFq7lzKBU9CENiMetKrSdJTglln2bu+84U0E=;
 b=r96MYxaz7+cJQTHYBO1Lqk9ImJjP5vgldoyV1Y1nIOp2WbrO5vFR7tMWtkycr3eknA9sEjPRh12cbL0AOLvHJ+8SNjM/h9GwMxbUrscnQpXFYBNAuBAzR2hmPDr/SuOFSOJQQvd5oSztzuQ2BxbVhxQ+32fHo8nljsJnlSykjXiCrSepLzcYIO4v2krWMzatdzb7n7QhIyQECaPTU2w2y4LrSuC0aOm5UQSb11pziBqWHxJ2RL5G6LUiJLE4KyZouYuxc1j1MEnHOD6sZhvGB6f0ScoORX86mevCYhJhEKY+RI/GH7bRQz+/eMqKOmARnpdEq7+V7tA3bd/mUAg+Cw==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by SJ0PR03MB6779.namprd03.prod.outlook.com (2603:10b6:a03:40e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Thu, 30 Nov
 2023 18:47:00 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7068.012; Thu, 30 Nov 2023
 18:47:00 +0000
From:   Min Li <lnimi@hotmail.com>
To:     richardcochran@gmail.com, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v6 5/6] ptp: clockmatrix: Fix caps.max_adj to reflect DPLL_MAX_FREQ_OFFSET[MAX_FFO]
Date:   Thu, 30 Nov 2023 13:46:33 -0500
Message-ID: <PH7PR03MB706485400B3F74D383CC4DB2A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130184634.22577-1-lnimi@hotmail.com>
References: <20231130184634.22577-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [pgBF6m/n465qySNt0c7UOXsedwtjImSB]
X-ClientProxiedBy: YQBPR0101CA0262.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::24) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20231130184634.22577-5-lnimi@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|SJ0PR03MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ebcec75-243b-4754-f59f-08dbf1d4bc21
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tNDDSOBTznFAwxTtIgmlZv/mzJfwKycypbS/OBCspnjz7s0JRpuEuCriaOVDqds2ogljn8SSqogaV4SZOwh45ec6YaTtcBNvd+Sb2TvuAp1WWqzM7wJFY87VOBZgHgPeSRo0ylapi37hbjF9xlNWkAtx+D5Pd6rsYPHaxg4bdOJASmrIx+MO8wRhHRPvorVMCn8yjYe5Bp4/+Eo/PbY7xswvERFLIx55NwWhNCJJ1WzlsYkwe/nYec2mfERDfDnSBdySg/g6E6E9G0kQGiTdkZPvvzcnCOLiGRVweEN5h0sw/AkAsak0Gf6m9dmVP+Q59woBlimsIZnZFZGuvoECKbm9n5uQ1r5KaUxJKgjOrFfge0PhKTmYAyHVco69k+QZoHHx6PeNlqcMpc+eOgDnvMw2FZwHCcYmVO4ZrFWCTyuEhvivjPN9xCb90k9nkx3IS1IupMLsFbobINU4AAUGnbLRbyNtKUNJOUiYLC0XfmLfHnNsi4DkN83aiBWf470rxXmO548E+THJtEtD6smeDIkvzzm1PNZHRq0mfy1w9fsnqOfTKYucThnJ9/jt2EPl
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+2dL+7MSzUvpQwuDgD2JUY5ozyTLa/NiJAPGX58p/QQ6JP4gqd4mPxjdEfuf?=
 =?us-ascii?Q?Gp0ltymRWuiLoS6PYsibfZjIGWePNmjBCdGJm7zhjmHPi+FyL84OLJO7Xbjq?=
 =?us-ascii?Q?6BKvzQEtXkWUGDsyxWb9p62BuXn29M+KoOrsJZveVzSn3mEpnhJh6mpL3X68?=
 =?us-ascii?Q?CpqTFaXn9Z2tGCaiduehvGlizoUyV3jIal83+0N3vF0tIeBS9vXPITe9ETO3?=
 =?us-ascii?Q?ngTEvn+pHUS02Ht1M3j8le0sD805/HL4R4pHrV3XRp3r/1P7J6/ySdDoVE1t?=
 =?us-ascii?Q?Pbw2mjWPtLz5T3KjuM3cNCOUfCuRo3tzCbm6wtDmklq2zARxPzu4cxgyjOS6?=
 =?us-ascii?Q?f4E14IItPYHTsKeZjwWs/GOfyyCWJLflBbxSREbFVLiBamQoBaSVGHxd4Yrd?=
 =?us-ascii?Q?cYDgIXs9z2DI2q4F9zcJRBVit4erkX69JLQ8P83TiaB5AbIDqkpcpybOrpij?=
 =?us-ascii?Q?L75vGoGBUIannf/1E8N87b7i9dZMUUCShsvkqUMzkPNDm10Ggr18WlR+3QHc?=
 =?us-ascii?Q?ClcQCqRoyOlowBid5lUjZKdnTIpMHk1GQSViefO0yyExfYQ2SD4AZ46G+kLP?=
 =?us-ascii?Q?ipIpgjJtJB8ZkrimK4qX5mO4rFUux1UZWoWxLILN9oXj6/ysRcn7wijFuKvM?=
 =?us-ascii?Q?j7aVd4o1xF83GfARwlGBjd3o4riJ5JZOj3H9E9Sd2NX5j/aVffc1WAkHqowe?=
 =?us-ascii?Q?FEoPVgkhO48Z+q07evOQHHgLwcvY+JO3SLifGuZ9ApmYV3Y6xnG6IBeNwfhf?=
 =?us-ascii?Q?RG30rSU6XOHMeatPaVf04xyovD5414e+kScRmHfSakm65vb8zOKptgxomVXP?=
 =?us-ascii?Q?9blT4iee/cR1F4/FfIB0XOKL8SpJfBILfk2lU1hGUk6/IhieyVepwzbte7KU?=
 =?us-ascii?Q?boKM+m+9LdY9I3o+j8esAXnhDdj4imPTHk+d1Cm+CfA/ixeR6X4PpYvoVwpv?=
 =?us-ascii?Q?TADZkiMMCypKJ64pKLLkgb6l6vxY2OL+kMGK2lhMllcJGlvdRRfkQhmtbJhF?=
 =?us-ascii?Q?BIoPUPzNSiCHp08srGA/xxHVWX36NAP20qSE78AHBQ8c9yszDUF/5z+mJH32?=
 =?us-ascii?Q?Mzhhece3dCtNNE+gq6wr/lLKhfzyg16GtbHEfo7QqSpT8NiyI+tPpc12ildt?=
 =?us-ascii?Q?ipvy3q5dWLRJhIpUSL8ghVoZluDOmsRX9HrZmZD7fuGRBvJs7KzXV4tM83bo?=
 =?us-ascii?Q?ACJgCsJTyTP3PteA2kgG31hdfkr/FY/xkrXz5w=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-685f7.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ebcec75-243b-4754-f59f-08dbf1d4bc21
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 18:47:00.0779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6779
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

