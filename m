Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3847E3460
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 04:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjKGDxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 22:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjKGDxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 22:53:06 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2055.outbound.protection.outlook.com [40.107.215.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAEA11A;
        Mon,  6 Nov 2023 19:53:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0MBR7kh75rLY7sxgg2/zevGKIAzglqFU/ISDOGv+bwuxqOsx/wayrNAi/7bZcRvqz8kWcvboUlcVPoMPbB0b442Z/7LZZEjUWO73ID4dEDOPuW4WulKxGpfkY8fSQXMe88lHfsNQfvVnsuBdIUw6KBglUbmaN/jbiDfX9SKa0eCRhxSwNPCoP/UDjsD8XWSt6LhBUqp/MGdB11ck/lD+9K4w/foyfkL6UDe08vH0xxM+erMS6CYKl5c0Ce+qNqU78yVLNv7yo80DkuiAcXJdyMieZxR8H7BKPUJzJx4X8PdqVriHJZ2ZPfFpwxabo3dRUoAMmFe01yDXE8Evo1W1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcaICetR5lyEKj6pIUQJ2asUqjV4ZwfHDhAFVDFV/yA=;
 b=fjTWWKc22+zc0zA0HEwGOD2YaYvVfOkl9d6zX6mvjATbJzIyQOSgxDZCiE2Jc11QBkNE4PlfvNSAQi6th2FYpP5ZvXJPMSMaWX++C0wd/p4ZvXOEkOpow52JJ1xu3Jxe5jEPrvXbpIs/w8QD2whRy2AAFLpovYct/CDj3iPb+6jmPcRgUbzwWCHJQtEu8U3EqzzFuouqGzUYMJ1xW2I4UsPnnioHrZDpuqoJ+eokmzTNJbNK7By7Nv2RLhkyGe+LfRqWTilW1mT/A4XBxrW++w//OhL82O/GU14v0B/l8woAPvRAb2NqUT7dTvqU+VEifRBxVxSzGt8fp0f0Z6i/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcaICetR5lyEKj6pIUQJ2asUqjV4ZwfHDhAFVDFV/yA=;
 b=ONsKZzrmKZPZuc1VyCTjvXrVN3J+om+58g4IAfXAcooVgQTApSNHVOYdZJ16SOPAvxzKPNRiUHxk3srMtuKrJk1NAHWjv66hojqpcZRL3LiEGEZDDlTPlqC9DsZCPy+EtFpb6Dvi8KX2MmQCb79aWjtVvzmBqLz7upiF5B7qSz0=
Received: from SG2PR04CA0215.apcprd04.prod.outlook.com (2603:1096:4:187::14)
 by SEZPR03MB6571.apcprd03.prod.outlook.com (2603:1096:101:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 03:52:56 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:4:187:cafe::b0) by SG2PR04CA0215.outlook.office365.com
 (2603:1096:4:187::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29 via Frontend
 Transport; Tue, 7 Nov 2023 03:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 03:52:56 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Nov
 2023 11:52:53 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 7 Nov
 2023 11:52:53 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 7 Nov 2023 11:52:53 +0800
From:   Seven Lee <wtli@nuvoton.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <YHCHuang@nuvoton.com>, <KCHSU0@nuvoton.com>, <CTLIN0@nuvoton.com>,
        <SJLIN0@nuvoton.com>, <wtli@nuvoton.com>, <scott6986@gmail.com>,
        <supercraig0719@gmail.com>, <dardar923@gmail.com>
Subject: [PATCH v4 2/2] ASoC: nau8821: Add slew rate controls.
Date:   Tue, 7 Nov 2023 11:52:30 +0800
Message-ID: <20231107035230.1241683-3-wtli@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231107035230.1241683-1-wtli@nuvoton.com>
References: <20231107035230.1241683-1-wtli@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[211.75.126.7];domain=NTHCCAS01.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|SEZPR03MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a7ac9a-c72a-4a98-3f8a-08dbdf4506be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ClVqKh9U1k3jQDPABPv1xTnSVhni6HpwcTmE6bu3Lt6zMlucmWURqV2QdrxyYSEsJLnIQRutI/tp1bVcYfZ81tkfhQGpnn5NqQLr29QUXa87EkWjezRwI+3EZhkWd7bbLSGHa8fEIgQ10KOj0vytOPVcioSr0LsxoZiYoYmF/G0QabFDC4fLXFcsNzytzmLLXVh+702h6zU4eMRGpRWvS0b2ef/4lEWENLN+3cLfWuM7OC08Vf83sV33KVGntMvO2MgOUldD3725wWAIshcR+/MbE1N4vx/AFgOFrOG2MoniqEat5tc1Jx0VOrNvhVfx8NOC57aimQddB48BTSLyV0wdkqmyCvtFVyC6pDBtxCnpagaphD72RsjRqvB9wvc63XLfOXxSmRn+Sx3PWi7IzJGHcbMZwt4WkY5em7JKU593aEyF/3+NP1l4FDvlwppNIPyaeCevAMMZ6P5O059aC5Jv5SBAP2VkB4HGWcVcRS1PRNZm3DVZCOtMQNia0a0bF53MX6I8JWbMA0MlBIrO9Z7ozJ+ccZPvJrSzmNSXLwGIDgEmF6rccsKAB+aUlClzCWQCLsGbWRqKvoIxFeWhKGEMwf1G0jcYvTPEia5zJEKMi0fuwJ/fljMo8GO0WnneNQanVMvOYYDwvQJxvp3xGtlZsDIkMUTl8vRaGHTK68ZVgw5Rv4+wyNu5IoJO1sVLSu8Ks7C1FgTUD5zktsy4oYN4Bvh5fWGdI7p7YeqwV8U6sLYjIrrKGTCJVNdVTg1rCYZRe9tA7FCpft48LwOijF3wEtoUMFthe6eX9R4aFFA=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(36756003)(54906003)(426003)(336012)(5660300002)(83380400001)(8676002)(8936002)(26005)(316002)(70586007)(70206006)(6916009)(1076003)(36860700001)(2906002)(7416002)(47076005)(41300700001)(478600001)(2616005)(6666004)(86362001)(4326008)(82740400003)(356005)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 03:52:56.0832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a7ac9a-c72a-4a98-3f8a-08dbdf4506be
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6571
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch supports DMIC clock slew rate controls.

Signed-off-by: Seven Lee <wtli@nuvoton.com>
---
 sound/soc/codecs/nau8821.c | 7 +++++++
 sound/soc/codecs/nau8821.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index 6e1b6b26298a..012e347e6391 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -1738,6 +1738,10 @@ static int nau8821_read_device_properties(struct device *dev,
 		&nau8821->dmic_clk_threshold);
 	if (ret)
 		nau8821->dmic_clk_threshold = 3072000;
+	ret = device_property_read_u32(dev, "nuvoton,dmic-slew-rate",
+		&nau8821->dmic_slew_rate);
+	if (ret)
+		nau8821->dmic_slew_rate = 0;
 
 	return 0;
 }
@@ -1797,6 +1801,9 @@ static void nau8821_init_regs(struct nau8821 *nau8821)
 		NAU8821_ADC_SYNC_DOWN_MASK, NAU8821_ADC_SYNC_DOWN_64);
 	regmap_update_bits(regmap, NAU8821_R2C_DAC_CTRL1,
 		NAU8821_DAC_OVERSAMPLE_MASK, NAU8821_DAC_OVERSAMPLE_64);
+	regmap_update_bits(regmap, NAU8821_R13_DMIC_CTRL,
+		NAU8821_DMIC_SLEW_MASK, nau8821->dmic_slew_rate <<
+		NAU8821_DMIC_SLEW_SFT);
 	if (nau8821->left_input_single_end) {
 		regmap_update_bits(regmap, NAU8821_R6B_PGA_MUTE,
 			NAU8821_MUTE_MICNL_EN, NAU8821_MUTE_MICNL_EN);
diff --git a/sound/soc/codecs/nau8821.h b/sound/soc/codecs/nau8821.h
index 00a888ed07ce..62eaad130b2e 100644
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
+	int dmic_slew_rate;
 	int key_enable;
 };
 
-- 
2.25.1

