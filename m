Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0198A7D2865
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjJWCPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjJWCPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:15:52 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2040.outbound.protection.outlook.com [40.107.117.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55219CF;
        Sun, 22 Oct 2023 19:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsIj9lW5656C1925alQV9T3EF6K8S/PC/oewYc3JBL6vWAO9ydA6KaOHdks80akLGTykKHHCuSLuNNjnjU4kw7fTBI5x9dXdA8zYxRB2QshoyNIeXEEF95/5kmvaaL1UXBYYMKlQ2lH5iyWQsuMGSs2OoH8FI9lktRCgEGoTp9RWSaDqwZEeShHv9u3clKVJV5hV1dAUROBhS7uQ7ANCLVHdlw8xJoydzNt/zXkHtIyBOBmmX+tXTJZyOGLwzPCifWIiwvOit8n/RygOIVJG8feNZUBjMa1k3gp5firOSqoz5W5xRBUtuRUhfyU6XyELy2UHz5Vhj5tCd/XeAH0PzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=787hQNn8Zrl4V34fsewfvHXZwHGyFnO7F/lZz3vYpDA=;
 b=OamKqWGrK7+regabRwN5QWny11b2gPK7EC6cGG5kllh3NcMwg+j2vUzv5ieEHZnIzpiN02PEICZa1lblsJjOZQAZS+jqqLfB4Jm++NVwgO2ksShhtKeK66CGqA+RQbyVNzQx9SZdJn6Zko7lo2S/BkUlWoTNcFPmgGsZfRgYxxnPMHKGv8Ya8IYAotnYQvHI902vXTqppWBPiTaeXL5wvKnz0YzbVJ9UmBP5m30zZp0wHiHDMilpCF3o1hZN2J0ac9tLq6i/EXAGazzvWZXG1UcpedFIArBDmbma/VxUKMKScs/e59CbvHA9b2tNZPmQxtmOb66FoFaJCGWBKmU4Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=787hQNn8Zrl4V34fsewfvHXZwHGyFnO7F/lZz3vYpDA=;
 b=JoIwp0qfkp8t0eK+Ld60jrm6CmZAnYsDLOxDKH/IUJssTLkurebtx5aQ+So1Mem1a87ii3hiC+xf0gNOCv4VR8oPPUVHGDKdZKm+X9SqXZtEOh/gFla2/B5GRGK2nP843Lax1bvtNZQbvk5+FyxiJyUBIjurDaMWpBk4DW3MUU8=
Received: from SGBP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::27) by
 KL1PR03MB7053.apcprd03.prod.outlook.com (2603:1096:820:c8::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Mon, 23 Oct 2023 02:15:45 +0000
Received: from SG2PEPF000B66CF.apcprd03.prod.outlook.com
 (2603:1096:4:b0:cafe::75) by SGBP274CA0015.outlook.office365.com
 (2603:1096:4:b0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 02:15:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG2PEPF000B66CF.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 02:15:45 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Mon, 23
 Oct 2023 10:15:43 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 23 Oct
 2023 10:15:43 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 23 Oct 2023 10:15:43 +0800
From:   Seven Lee <wtli@nuvoton.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <YHCHuang@nuvoton.com>, <KCHSU0@nuvoton.com>, <CTLIN0@nuvoton.com>,
        <SJLIN0@nuvoton.com>, <WTLI@nuvoton.com>, <scott6986@gmail.com>,
        <supercraig0719@gmail.com>, <dardar923@gmail.com>,
        Seven Lee <wtli@nuvoton.com>
Subject: [PATCH 2/2] ASoC: nau8821: Add slew rate controls.
Date:   Mon, 23 Oct 2023 10:15:37 +0800
Message-ID: <20231023021537.617980-2-wtli@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023021537.617980-1-wtli@nuvoton.com>
References: <20231023021537.617980-1-wtli@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CF:EE_|KL1PR03MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: f865a858-dd1a-40c6-7836-08dbd36df6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G4oRNuLUic2c2TYe89bqxOok1v79tJBFTRBYj5cp7JYP6EvTtXZrx6Z6sSVDZy63sUG54OPAe7Ehy4qoQXWIsihFxN4jk3VC6sejzcEFZNE2Kn/fzlOX/8qSxPM1gb87V3B1m2VIkFMgv30ETHJxv15pEL2AkP1NrqbIU4ysl01OVDraChPqQbrJFfHASXiaZVR/N0ZW2AjVfdhLjlpqws5aJtglzzumN17b1yDpEXLzKIfGO+lz6bAHLkc3aA1F+PQMyPmlQ40il7zLY+uw1LNXv2w2bOh+OTP7ktBPjjF7SfS4XqGx/d186YZyz47PnBtcw5IMExTXV/9GsAhc37mu/DqQehAScxTCWh9OoW8hvIGuRlJ0MtIoydazpYqXo4OyaB4hLKOgHi/ZCVEQF1WAa2gSrQc3Lw1l7kOTQTjd/1OyXz0533rhj7X2hVjhLvhtfCI8S1iEsI1Drdzd8cRy2C8hzBuTjM9CNlaN/lzRPQXSH1KScSBh3l+f7m3WyiHFcMsD54SRhgPrMbYT6SO3POPO1EDFGgTWcjIQ3rSG50SjzObDY0DjB9RX52VLOOvYKE0jSZpukkydtGu4ofJpukhzlR4WIOAytah9f7uIDLKGgyV9244XHAtsnhOsQ7cdwe+p+WswZZmwu4YX7NQfuPrfsfKkabwFf8tpl4psENVYE/K+at9KM+26ttEFMrf3TBQBXhFZFIeSJBEyr9Q5WSHRoGZVVP3HWrmxM8FOa32Dl5VmfPd6IzjiYNz0HmkjZDv6ol8/ZvME+NDJIi1Hw7LqKbZXA1lPKPFh8hM=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(336012)(426003)(36860700001)(5660300002)(4326008)(8676002)(7416002)(41300700001)(83380400001)(26005)(47076005)(107886003)(2616005)(1076003)(6666004)(2906002)(40480700001)(8936002)(86362001)(36756003)(70206006)(478600001)(6916009)(54906003)(81166007)(70586007)(316002)(356005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 02:15:45.0076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f865a858-dd1a-40c6-7836-08dbd36df6f4
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch supports DMIC clock slew rate selection.

Signed-off-by: Seven Lee <wtli@nuvoton.com>
---
 sound/soc/codecs/nau8821.c | 7 +++++++
 sound/soc/codecs/nau8821.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index 6e1b6b26298a..d8190e8a431f 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -1738,6 +1738,10 @@ static int nau8821_read_device_properties(struct device *dev,
 		&nau8821->dmic_clk_threshold);
 	if (ret)
 		nau8821->dmic_clk_threshold = 3072000;
+	ret = device_property_read_u32(dev, "nuvoton,dmic-slew-rate-selection",
+		&nau8821->dmic_slew_rate_sel);
+	if (ret)
+		nau8821->dmic_slew_rate_sel = 0;
 
 	return 0;
 }
@@ -1797,6 +1801,9 @@ static void nau8821_init_regs(struct nau8821 *nau8821)
 		NAU8821_ADC_SYNC_DOWN_MASK, NAU8821_ADC_SYNC_DOWN_64);
 	regmap_update_bits(regmap, NAU8821_R2C_DAC_CTRL1,
 		NAU8821_DAC_OVERSAMPLE_MASK, NAU8821_DAC_OVERSAMPLE_64);
+	regmap_update_bits(regmap, NAU8821_R13_DMIC_CTRL,
+		NAU8821_DMIC_SLEW_MASK, nau8821->dmic_slew_rate_sel <<
+		NAU8821_DMIC_SLEW_SFT);
 	if (nau8821->left_input_single_end) {
 		regmap_update_bits(regmap, NAU8821_R6B_PGA_MUTE,
 			NAU8821_MUTE_MICNL_EN, NAU8821_MUTE_MICNL_EN);
diff --git a/sound/soc/codecs/nau8821.h b/sound/soc/codecs/nau8821.h
index 00a888ed07ce..480f605d5d50 100644
--- a/sound/soc/codecs/nau8821.h
+++ b/sound/soc/codecs/nau8821.h
@@ -236,6 +236,8 @@
 #define NAU8821_DMIC_SRC_MASK	(0x3 << NAU8821_DMIC_SRC_SFT)
 #define NAU8821_CLK_DMIC_SRC	(0x2 << NAU8821_DMIC_SRC_SFT)
 #define NAU8821_DMIC_EN_SFT	0
+#define NAU8821_DMIC_SLEW_SFT  8
+#define NAU8821_DMIC_SLEW_MASK (0x7 << NAU8821_DMIC_SLEW_SFT)
 
 /* GPIO12_CTRL (0x1a) */
 #define NAU8821_JKDET_PULL_UP	(0x1 << 11) /* 0 - pull down, 1 - pull up */
@@ -573,6 +575,7 @@ struct nau8821 {
 	int jack_eject_debounce;
 	int fs;
 	int dmic_clk_threshold;
+	int dmic_slew_rate_sel;
 	int key_enable;
 };
 
-- 
2.25.1

