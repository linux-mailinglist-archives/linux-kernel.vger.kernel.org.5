Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994C4785134
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjHWHNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjHWHND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:13:03 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2071.outbound.protection.outlook.com [40.107.255.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AECEDB;
        Wed, 23 Aug 2023 00:13:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQd2WwEmfYgu8nPV57dMm+9HKfPE2grX2ddBNVM9sACAvOCMjppN4n39y2tMvAz7rEvXjC5Uu3qDkNyfXS47OuZnUfBNM4JdPEPsJhutHeFxo/xH/pOAyB6C8+KNQ3ALcSfeqrbz10RFqacJPD2/d8J26qTgqbPZ8jf4gpGS9SaLhNIovKCC2ioE0uywXITWbsvGfSrxeq8SLgK8US38FiqoLcQE3M/BLHa8Lj/OZ2GEE1XShR5cTKfuqIpUlGvuDN+7xiWe6+qRrwYsW+C7sIDeysbgydRp9DYiyZXPGWxhgA0LeHMAgqtp8hJHXRIcBMQb6VQh4/E4dh3iBTDslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+WdT6PvAXSJtWxxcXHQ4ZfyxXUmTzY/gqn1iw59P5A=;
 b=cacZjHxHeAOg5qYQE3i7AN9KFB/n7jEJL5lqWmm21Q+MiLoTLZNMXSzdYyWa00uEmAlRjg22GKEO8rKPoYMuG6pHDj2lg/0trv4ZVoZQ8ohBw/+S/JETs1U657ao2p1vNe1TR5Wg4zP5z83+tqejkPAGIfXjSVYBzoCMFjc+PZ21HEab6n9SVHjMPc3P1FRUmpFesuYSApyOd6TnXLYYC9n/sSPpt6vrugGE8iTopE5OIkN6pdwgtBErgxjO+DfcxQbzLM3E5SDp4BgJPxcjR6nziXKCBVgARUYvoPrbkCrfdv8xiwdNIMLSQL9geHfL1Jlst5Hg5bSqvUV/acsE7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+WdT6PvAXSJtWxxcXHQ4ZfyxXUmTzY/gqn1iw59P5A=;
 b=hykD6RBUTd1mH7lCkyr6ONMditaoj7nvHvXXWf5Szw6TcPX8wywUfFq/dHGJOnqDnGNY8AhCzmu9TXpBk9e2yGTVp6MocsZyw+8MPqS6d8rt/ZJFmXnrxlHodClVNsyiUous0/GMurLKTW3w9LBI/ARFHArnf3CeMbUgayyLaNM=
Received: from SG2PR02CA0055.apcprd02.prod.outlook.com (2603:1096:4:54::19) by
 SEZPR03MB6811.apcprd03.prod.outlook.com (2603:1096:101:66::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.25; Wed, 23 Aug 2023 07:12:55 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:54:cafe::7e) by SG2PR02CA0055.outlook.office365.com
 (2603:1096:4:54::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Wed, 23 Aug 2023 07:12:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 07:12:54 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Wed, 23
 Aug 2023 15:12:52 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 23 Aug 2023 15:12:53 +0800
From:   Seven Lee <wtli@nuvoton.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <YHCHuang@nuvoton.com>, <KCHSU0@nuvoton.com>, <CTLIN0@nuvoton.com>,
        <SJLIN0@nuvoton.com>, <scott6986@gmail.com>,
        <supercraig0719@gmail.com>, <dardar923@gmail.com>,
        Seven Lee <wtli@nuvoton.com>
Subject: [PATCH 2/2] ASoC: nau8821: Improve AMIC recording performance.
Date:   Wed, 23 Aug 2023 15:12:44 +0800
Message-ID: <20230823071244.1861487-2-wtli@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823071244.1861487-1-wtli@nuvoton.com>
References: <20230823071244.1861487-1-wtli@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|SEZPR03MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a88e6c-efd2-40b5-967b-08dba3a85ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ChPSRMw5YIGJGbOlxxywEVzuxCC2f0waj0f5yMdXwRsyV5w2gxskMVFIHOIefLhG5iyMogDb0FIsNjbkWywtACWsoxp7KYRPn4PY8LM95K15ChVJVH1RJbkGU/vxqlfsWunZnsHkae3mxNcwFpb6PvbegFddBUWLT8FtvP2v01DQqUUxqrnl+eAYux6gZ3xBHV2H8AKh61YsL0MdWEFglmRE6DNA8OA/deAj4WmAy4tnUH4AqoWhSnlTI/866knMqqZl3rD6nWBZ9MSSb/TwnGRtbJlxtHeEz4CMOr/kYXREYKQJbkQeg90KsBC2NOLvRQgkQcty800/8cfsy8psRE4IrRXhjZGbTDvl+oZnRrrp8KViSFYH0wad2kBkYwmkU1HGF6+Hz4GAPW+rJDzmoc2OYnM5HRSRFMl1sW3uTJ+8MD5KbZsqULL1tMj1LYW1Ist9YZX5e2Xc7pOFeaChnOeuWG3RA0cmGZcwNZcFF986M/7Qo/YmJ08E7UP8MCSUQ7/NU8BmGsgI6nNLtYcTfpk7qK/brXkfGEVWzaj+FS3PO8qavXgrnEKeoIM8GAzDSoQk3x9tRHvJR7tnN5vg43aPVIBF3YIL81k6jobKJzRL+mMjhzchPvDn99vt+bPDrFN7Gz7MCKpyJxzrCnTIkq5awZEGXWYGHU/i57AIYskPuujAxCBTJyef0WoEuCg/vFkaY0oMZGJr1d6+O9L0INS1yY6JdBA/iLwQPtF/0kBNWdlKiAS3CUjGlEm2EvaK+A63LkfZKtrauqCMPsqLYY9VWV8ECw4UnCIRi+vQHaJdzhoxBj3FYy6UAh2BXP7o
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199024)(82310400011)(186009)(1800799009)(46966006)(40470700004)(36840700001)(47076005)(8676002)(8936002)(4326008)(6916009)(316002)(2906002)(54906003)(70206006)(36756003)(70586007)(40480700001)(7416002)(5660300002)(12101799020)(40460700003)(26005)(2616005)(36860700001)(107886003)(41300700001)(1076003)(81166007)(6666004)(356005)(82740400003)(426003)(83380400001)(86362001)(478600001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:12:54.2066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a88e6c-efd2-40b5-967b-08dba3a85ec9
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6811
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the hardware may be designed as a single-ended input, the headset mic
record only supports single-ended input on the left side. This patch
will enhance microphone recording performance for single-end.

Signed-off-by: Seven Lee <wtli@nuvoton.com>
---
 sound/soc/codecs/nau8821.c | 42 +++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/nau8821.h | 25 +++++++++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index ca6beb2d2649..f307374834b5 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -624,6 +624,36 @@ static int system_clock_control(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int nau8821_left_fepga_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct nau8821 *nau8821 = snd_soc_component_get_drvdata(component);
+
+	if (!nau8821->left_input_single_end)
+		return 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		regmap_update_bits(nau8821->regmap, NAU8821_R77_FEPGA,
+			NAU8821_ACDC_CTRL_MASK | NAU8821_FEPGA_MODEL_MASK,
+			NAU8821_ACDC_VREF_MICN | NAU8821_FEPGA_MODEL_AAF);
+		regmap_update_bits(nau8821->regmap, NAU8821_R76_BOOST,
+			NAU8821_HP_BOOST_DISCHRG_EN, NAU8821_HP_BOOST_DISCHRG_EN);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		regmap_update_bits(nau8821->regmap, NAU8821_R77_FEPGA,
+			NAU8821_ACDC_CTRL_MASK | NAU8821_FEPGA_MODEL_MASK, 0);
+		regmap_update_bits(nau8821->regmap, NAU8821_R76_BOOST,
+			NAU8821_HP_BOOST_DISCHRG_EN, 0);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget nau8821_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("System Clock", SND_SOC_NOPM, 0, 0,
 		system_clock_control, SND_SOC_DAPM_POST_PMD),
@@ -635,8 +665,10 @@ static const struct snd_soc_dapm_widget nau8821_dapm_widgets[] = {
 		NAU8821_POWERUP_ADCL_SFT, 0),
 	SND_SOC_DAPM_ADC("ADCR Power", NULL, NAU8821_R72_ANALOG_ADC_2,
 		NAU8821_POWERUP_ADCR_SFT, 0),
+	/* single-ended design only on the left */
 	SND_SOC_DAPM_PGA_S("Frontend PGA L", 1, NAU8821_R7F_POWER_UP_CONTROL,
-		NAU8821_PUP_PGA_L_SFT, 0, NULL, 0),
+		NAU8821_PUP_PGA_L_SFT, 0, nau8821_left_fepga_event,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_PGA_S("Frontend PGA R", 1, NAU8821_R7F_POWER_UP_CONTROL,
 		NAU8821_PUP_PGA_R_SFT, 0, NULL, 0),
 	SND_SOC_DAPM_PGA_S("ADCL Digital path", 0, NAU8821_R01_ENA_CTRL,
@@ -1677,6 +1709,8 @@ static int nau8821_read_device_properties(struct device *dev,
 		"nuvoton,jkdet-pull-up");
 	nau8821->key_enable = device_property_read_bool(dev,
 		"nuvoton,key-enable");
+	nau8821->left_input_single_end = device_property_read_bool(dev,
+		"nuvoton,left-input-single-end");
 	ret = device_property_read_u32(dev, "nuvoton,jkdet-polarity",
 		&nau8821->jkdet_polarity);
 	if (ret)
@@ -1760,6 +1794,12 @@ static void nau8821_init_regs(struct nau8821 *nau8821)
 		NAU8821_ADC_SYNC_DOWN_MASK, NAU8821_ADC_SYNC_DOWN_64);
 	regmap_update_bits(regmap, NAU8821_R2C_DAC_CTRL1,
 		NAU8821_DAC_OVERSAMPLE_MASK, NAU8821_DAC_OVERSAMPLE_64);
+	if (nau8821->left_input_single_end) {
+		regmap_update_bits(regmap, NAU8821_R6B_PGA_MUTE,
+			NAU8821_MUTE_MICNL_EN, NAU8821_MUTE_MICNL_EN);
+		regmap_update_bits(regmap, NAU8821_R74_MIC_BIAS,
+			NAU8821_MICBIAS_LOWNOISE_EN, NAU8821_MICBIAS_LOWNOISE_EN);
+	}
 }
 
 static int nau8821_setup_irq(struct nau8821 *nau8821)
diff --git a/sound/soc/codecs/nau8821.h b/sound/soc/codecs/nau8821.h
index d962293c218e..00a888ed07ce 100644
--- a/sound/soc/codecs/nau8821.h
+++ b/sound/soc/codecs/nau8821.h
@@ -433,6 +433,14 @@
 #define NAU8821_DAC_CAPACITOR_MSB		(0x1 << 1)
 #define NAU8821_DAC_CAPACITOR_LSB		0x1
 
+/* MUTE_MIC_L_N (0x6b) */
+#define NAU8821_MUTE_MICNL_SFT		5
+#define NAU8821_MUTE_MICNL_EN           (0x1 << NAU8821_MUTE_MICNL_SFT)
+#define NAU8821_MUTE_MICNR_SFT          4
+#define NAU8821_MUTE_MICNR_EN           (0x1 << NAU8821_MUTE_MICNR_SFT)
+#define NAU8821_MUTE_MICRP_SFT          2
+#define NAU8821_MUTE_MICRP_EN           (0x1 << NAU8821_MUTE_MICRP_SFT)
+
 /* ANALOG_ADC_1 (0x71) */
 #define NAU8821_MICDET_EN_SFT		0
 #define NAU8821_MICDET_MASK		0x1
@@ -463,23 +471,39 @@
 
 /* MIC_BIAS (0x74) */
 #define NAU8821_MICBIAS_JKR2		(0x1 << 12)
+#define NAU8821_MICBIAS_LOWNOISE_SFT	10
+#define NAU8821_MICBIAS_LOWNOISE_EN	(0x1 << NAU8821_MICBIAS_LOWNOISE_SFT)
 #define NAU8821_MICBIAS_POWERUP_SFT	8
+#define NAU8821_MICBIAS_POWERUP_EN	(0x1 << NAU8821_MICBIAS_POWERUP_SFT)
 #define NAU8821_MICBIAS_VOLTAGE_SFT	0
 #define NAU8821_MICBIAS_VOLTAGE_MASK	0x7
 
 /* BOOST (0x76) */
 #define NAU8821_PRECHARGE_DIS		(0x1 << 13)
 #define NAU8821_GLOBAL_BIAS_EN		(0x1 << 12)
+#define NAU8821_HP_BOOST_DISCHRG_SFT	11
+#define NAU8821_HP_BOOST_DISCHRG_EN	(0x1 << NAU8821_HP_BOOST_DISCHRG_SFT)
 #define NAU8821_HP_BOOST_DIS_SFT	9
 #define NAU8821_HP_BOOST_DIS		(0x1 << NAU8821_HP_BOOST_DIS_SFT)
 #define NAU8821_HP_BOOST_G_DIS		(0x1 << 8)
 #define NAU8821_SHORT_SHUTDOWN_EN	(0x1 << 6)
 
 /* FEPGA (0x77) */
+#define NAU8821_ACDC_CTRL_SFT		14
+#define NAU8821_ACDC_CTRL_MASK		(0x3 << NAU8821_ACDC_CTRL_SFT)
+#define NAU8821_ACDC_VREF_MICP		(0x1 << NAU8821_ACDC_CTRL_SFT)
+#define NAU8821_ACDC_VREF_MICN		(0x2 << NAU8821_ACDC_CTRL_SFT)
 #define NAU8821_FEPGA_MODEL_SFT		4
 #define NAU8821_FEPGA_MODEL_MASK	(0xf << NAU8821_FEPGA_MODEL_SFT)
+#define NAU8821_FEPGA_MODEL_AAF		(0x1 << NAU8821_FEPGA_MODEL_SFT)
+#define NAU8821_FEPGA_MODEL_DIS		(0x2 << NAU8821_FEPGA_MODEL_SFT)
+#define NAU8821_FEPGA_MODEL_IMP12K	(0x8 << NAU8821_FEPGA_MODEL_SFT)
 #define NAU8821_FEPGA_MODER_SFT		0
 #define NAU8821_FEPGA_MODER_MASK	0xf
+#define NAU8821_FEPGA_MODER_AAF		0x1
+#define NAU8821_FEPGA_MODER_DIS		0x2
+#define NAU8821_FEPGA_MODER_IMP12K	0x8
+
 
 /* PGA_GAIN (0x7e) */
 #define NAU8821_PGA_GAIN_L_SFT	        8
@@ -543,6 +567,7 @@ struct nau8821 {
 	bool jkdet_enable;
 	bool jkdet_pull_enable;
 	bool jkdet_pull_up;
+	bool left_input_single_end;
 	int jkdet_polarity;
 	int jack_insert_debounce;
 	int jack_eject_debounce;
-- 
2.25.1

