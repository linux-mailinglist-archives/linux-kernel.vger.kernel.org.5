Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4115F77DB8C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242636AbjHPIAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242627AbjHPIAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:00:37 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2085.outbound.protection.outlook.com [40.107.215.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDCDAB;
        Wed, 16 Aug 2023 01:00:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBqA0LXoNF0T0nVYDnkUtnvK7EYtSuqXlD9K6uVzOVpRNCr03lzlp2QVnv+blkL/015AQsqATnVeTnwXU+deGVQ3cbNcl6gCTnJj2K4qM37Peow81hny+KoE3SSbWmsY8bmU+BMWAoIqsnKMvJ8YJKpskM76DdIj+J7W3JT/SF6lu2r/QhnXgYdZkDRombx2GN/RsjpqRGo9JTCgsTjNev3j6Vm2taA+tB4YGfw3rmfKpMcqurf9Cp6odMLBaEUFfty/As6YjWFcHJsicKLQvjos/b/xyzTzrTtoXlIGFIrplQr0WBcfXTWDEF4tS0uPj6/PdwTI8VpmmxVlRS7Ffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ky8vZ9Dq5uGtZY9/IWPW4NKvoVq2mfuN3kCzkbLZno=;
 b=MXcPjcFisZLusbGbWc41tbedhHtAz40BXhSFJMTjVfpZ0YJaoFpTYkM1dxKX5KuOqKiyaQW+wyb1DUzstqcU0ebp/g54zgBmLPl831RIW5zi4Ufsxj0nZXm+UMjwYnrpJV15xs/LWk29tloFBH++Ox4418ymWcSwQhWj1uEjyuMvhXawvOKQ7bxllPehxBa2qO3Lb4sMze6/irXcjXbQ8bTH1Msgfdpjx/djoHnOe3xum30eNiUUbmcZsOXv8lBzp0vm/qMYUjbpaVbY9s81O5q/tJkCX38tnpZQ9tTGzpFQnopLmzzwHaFUjJyPMwN4+8TLQOPGx21iY2OFqXTdzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ky8vZ9Dq5uGtZY9/IWPW4NKvoVq2mfuN3kCzkbLZno=;
 b=daoaonJGrb1Jg6411ZbWzoVaJc/Do9+FLbqb59EVYzjLTN2+bhrqBMoKmyM+E+7BL3zBL/14JwzvMlvqxppfY7NOim2tao0Sio6IppcIFm2HsOJVyvyjCmONgq3a7+cp9z7EgZq/onJmLkgdsiSXCCQYl084GIABCADiMpqlnvo=
Received: from KL1P15301CA0052.APCP153.PROD.OUTLOOK.COM (2603:1096:820:3d::10)
 by SEYPR03MB7433.apcprd03.prod.outlook.com (2603:1096:101:138::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 08:00:29 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:820:3d:cafe::37) by KL1P15301CA0052.outlook.office365.com
 (2603:1096:820:3d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.5 via Frontend
 Transport; Wed, 16 Aug 2023 08:00:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 08:00:29 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Wed, 16
 Aug 2023 16:00:10 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 16 Aug 2023 16:00:10 +0800
From:   Seven Lee <wtli@nuvoton.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <YHCHuang@nuvoton.com>, <KCHSU0@nuvoton.com>, <CTLIN0@nuvoton.com>,
        <WTLI@nuvoton.com>, <SJLIN0@nuvoton.com>, <scott6986@gmail.com>,
        <supercraig0719@gmail.com>, <dardar923@gmail.com>,
        Seven Lee <wtli@nuvoton.com>
Subject: [PATCH 2/2] ASoC: nau8821: Improve AMIC recording performance.
Date:   Wed, 16 Aug 2023 16:00:06 +0800
Message-ID: <20230816080006.1624342-2-wtli@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816080006.1624342-1-wtli@nuvoton.com>
References: <20230816080006.1624342-1-wtli@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|SEYPR03MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b149ee-8363-4113-3947-08db9e2edb9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvnuXrX/if2QHzwclNkcd27PAO/FE6ZUvt9njXAMSMS9W3ttIKb2OOGhfpHRKY6l1HKoeO+HuGQ+or7pt6DASY40jHJscYkxnvu9XtfcA9kExEywdeX7UM2kP26dWAyXTQFJEWMLYdfe4BwSl91EIrzKsSleh/vO7b4bZn6LlSASX0xXbDQWWrOh7hgkrUqlGSbGw91ZQm0ZC/ffnTRZadwOJJUSmOYvHAzwI5DTGLYJC4JZ8rHqOyikRyRgUCEWzyydOpKwD2B8S1j9hIhavmp4HJrfHriYSuI0zQ9eK5AINsV+XKc9TrkiT6hChSrWs78tZpv9Ltxtfx6YvXFV8seVkcrf5xn7PrHHB//L7z8MzHs4S1thdFqHpf4Hj2xCnRZ02hcAfnRw7E25skEx3GeqX7RYp0zI/Pufv4jLhnsToZHLQdk1da265/ntmugaIj7cftN+xVf2AYcZ971+ZsorQ+OlvolPLG2FUSCKhra4wqDp2i6Fw5KzJat4kUaxAHZoDwCltUaM4xvT02vBZs6JK6k4wVlT5/NXbxoAFl9ETgjj1+XBrVcv/osCXC7MVq+z8Dk5WoQTOWWT1ifqAh6WrjQ2af3Y28ZsWW5/8qd9rYGfYx4ejh99QNYnCvIMak6lW+bZzFL4kMYjrao0SZ5rLOKlQqvCLk/YMysuTcVOFswuQcl4c0yK5CNPjvs0QQRiqNat6ovBvQgJZm/gtnJyWaO7lboPDFD845bmmu+OLjh44EBPs6vMVVl1Z/bXij9sSrEwOV9WYnP51EVCy2pcZfJ2zk62GfGU6Zf/sv2hRFhQSCe6GQXUrt/q6JrH
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(1800799009)(82310400011)(451199024)(186009)(36840700001)(46966006)(40470700004)(316002)(356005)(82740400003)(70586007)(70206006)(81166007)(54906003)(6916009)(12101799020)(36860700001)(41300700001)(5660300002)(47076005)(8936002)(8676002)(4326008)(7416002)(2906002)(83380400001)(40460700003)(26005)(40480700001)(336012)(478600001)(426003)(86362001)(107886003)(6666004)(1076003)(36756003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 08:00:29.2761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b149ee-8363-4113-3947-08db9e2edb9f
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7433
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
 sound/soc/codecs/nau8821.c | 41 +++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/nau8821.h | 25 +++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index ca6beb2d2649..dfc2683a0083 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -624,6 +624,35 @@ static int system_clock_control(struct snd_soc_dapm_widget *w,
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
@@ -635,8 +664,10 @@ static const struct snd_soc_dapm_widget nau8821_dapm_widgets[] = {
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
@@ -1677,6 +1708,8 @@ static int nau8821_read_device_properties(struct device *dev,
 		"nuvoton,jkdet-pull-up");
 	nau8821->key_enable = device_property_read_bool(dev,
 		"nuvoton,key-enable");
+	nau8821->left_input_single_end = device_property_read_bool(dev,
+		"nuvoton,left-input-single-end");
 	ret = device_property_read_u32(dev, "nuvoton,jkdet-polarity",
 		&nau8821->jkdet_polarity);
 	if (ret)
@@ -1760,6 +1793,12 @@ static void nau8821_init_regs(struct nau8821 *nau8821)
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

