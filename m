Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291137DDEF9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjKAKHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjKAKHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:07:03 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2062.outbound.protection.outlook.com [40.107.117.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69B3D41;
        Wed,  1 Nov 2023 03:06:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKadG5mWRKeLCZLtnPSiKTYGOLGGH4HxIMwmgUUI5VnhxYyO1gjCq27oSmHmW1nNvupUBAfN5woswW3ELeKqVGnp2RI+J22DjvYuTD0kpTnYf/RVSz9Y7XKiEy/FDgJxPv24M5L+HGnUtv/2TNh5IboO4kAjRuneD+iZH9+w7aikD/IBSOZABcaHMzacLP5UW5JRZeofIq6me2pxH6sj0jKPppbNh1fnX4tf2oIS1cvEFmdMqrphJ8Tikz9jp3MYKV3njNxI5HmVMYyC9w2G6foW/LAgmfY51w36qB9kEmAtXug/7+8WAi1uKV+p7tal5R+qyON9M6EF18P4zjJpMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGx9q/7Lv43uTAIXe82yWeJ76GhBkqVjRlW6YIKJ2KI=;
 b=fGCT8tKb1VUR5eGFVBViJ1xCm4t+aqJxCKMZ8G+LKtwVVJJx6ap4eKDIbCyX0/o06u8H9GF4EwXs7AbL/9pNRpU5vshks109kFe0ojKf77CwxrtPb3dDpRSoQSlAULDtv54O2kjLm0czmgLlfOTlq3DhnXEU5fOQ8bJ11cfSLLMNLQHceKv4IPIJbPBeNjms7YieNZv3k8HrfPnSaUiUF5vjSWr4tDMRWAHdwrWM+DjaxMDW7TRCERnrqUmicVIq6NoBFNhuNvHVKeQRz27Lo6RFUdrmiZ1FX01VdZWugbs6olhFeLakFVgOGsvlt18UzVnKEnsOsbTRt31aqScOZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGx9q/7Lv43uTAIXe82yWeJ76GhBkqVjRlW6YIKJ2KI=;
 b=rFe/e0hC5SNQMoq35/ymyx48LQ/QeFXhz86XgiwDYxGXTHsShYrRg/uZkbQc63/lUHCjtuvq4iDOPH2gpfLCcoLYdPboxyzcE96QPA7g34zPrUPBqeUxKZXIPYZDIoFeRe6E8y8aOWU19uERPdCA8AavWty3LOlpDD0j+9MXdmEON09XDe5Cxr+4xmp1qLj2wHM5kXRCay6P9rXo6dgKcwl/TZICmTvQ/8i49HaYIeuz7C+40ewjQInTa16I6fxvft7pWztwII0C5sDeWO9Epg3svPcoe/2wuR0z4ykuNt3nM30vOiF+CBjX52rndWg8moX5tr19ny2tkc/l9ax73w==
Received: from PS2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::14) by KL1PR0401MB4227.apcprd04.prod.outlook.com
 (2603:1096:820:25::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Wed, 1 Nov
 2023 10:06:39 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:300:57:cafe::fb) by PS2PR01CA0050.outlook.office365.com
 (2603:1096:300:57::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 10:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server id 15.20.6838.22 via Frontend Transport; Wed, 1 Nov 2023 10:06:38
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 08/10] ARM: dts: aspeed: yosemite4: Revise i2c11 and i2c12 schematic change
Date:   Wed,  1 Nov 2023 18:06:05 +0800
Message-Id: <20231101100609.2516844-9-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101100609.2516844-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231101100609.2516844-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|KL1PR0401MB4227:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ec9007c6-3c8e-4a04-eae8-08dbdac23d65
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XjxkdkTJHXxpSHnm/h6Mf20shjot1l7EBr98JYC9JbUEnY6M2u39dbKMJzUtY5gTAUYuLUnv36FcZ2NCmCDIw6ecEdyF0oAz/jep1ckTxO25KHGlrRNEocllPwPsCVJKn1fZQwbFpT5Qg/6VAH6IuGE8ves0t0IF6cSlBcmJWbNDveyYA+rk7SMdtpexwkyYm2HtdGfjLpAEttdwyRC1K9HJ3MpsMb/mydIzJkKJOfH9GPqOmGYG7OqbxWMWrLOJ02JAmwftczDlS4s7y8XnfCfRLffpYH4ITM4dYo6RrmvBz5pNmj/hfYxL9dpdGplO5CBXiFBYX0RyTTO02cfXe05Bqmb2y2nYLbX5Aw4V59gRu8NyzxkVMS2+bXthhZMGG0rYfT50N3s4j+s1aY+2y30U2vrrwxgfnzF8MwnDpeBb2Y7xU0R5YW+hxSywtFN+T0we5SZIkH5XWu8uSkQKszHtDniYj1lD1ynpMYZOUGP5X8V/zxJIWdIwLqgS8mnF6PXkWcHT8OOlzsY2txV/G4ktwdGBmPMiklyfW2GIAUpoF+kOVJhPXSrcUzOH6YdSQChdWmuukyICM0sBeuMCyrP6YqV8pKVuqea78YV80PaeyETztfONpnN8AfCGssBWfoTSfs0XS5wqnb73Y8KCs/glgZNcx3B9qlrMXeFQ//luRBBN++tUcBGM/7QWA1APcYvC3n/FnX2A+EO34gU/LQ==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(136003)(376002)(396003)(39860400002)(346002)(82310400011)(1800799009)(64100799003)(186009)(451199024)(36840700001)(46966006)(6512007)(1076003)(26005)(40480700001)(86362001)(36756003)(956004)(356005)(82740400003)(81166007)(7416002)(2906002)(8676002)(83380400001)(9316004)(478600001)(2616005)(36860700001)(47076005)(6506007)(6666004)(316002)(6486002)(41300700001)(36736006)(8936002)(336012)(110136005)(5660300002)(70586007)(70206006)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 10:06:38.9469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9007c6-3c8e-4a04-eae8-08dbdac23d65
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4227
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,WEIRD_QUOTING autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revise i2c11 and i2c12 schematic change:
- remove space for adm1272 compatible
- enable interrupt setting for pca9555
- add eeprom for yosemite4 medusa board/BSM use
- remove temperature sensor for yosemite4 schematic change
- add power sensor for power module reading

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 118 ++++++++++++++----
 1 file changed, 93 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index e58d2ecf8ab5..d2b8091326ea 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -821,41 +821,94 @@ imux29: i2c@1 {
 &i2c11 {
 	status = "okay";
 	power-sensor@10 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x10>;
 	};
 
 	power-sensor@12 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x12>;
 	};
 
-	gpio@20 {
+	gpio_ext1: pca9555@20 {
 		compatible = "nxp,pca9555";
-		reg = <0x20>;
+		pinctrl-names = "default";
 		gpio-controller;
 		#gpio-cells = <2>;
-	};
-
-	gpio@21 {
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <94 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+		"P48V_OCP_GPIO1","P48V_OCP_GPIO2",
+		"P48V_OCP_GPIO3","FAN_BOARD_0_REVISION_0_R",
+		"FAN_BOARD_0_REVISION_1_R","FAN_BOARD_1_REVISION_0_R",
+		"FAN_BOARD_1_REVISION_1_R","RST_MUX_R_N",
+		"RST_LED_CONTROL_FAN_BOARD_0_N","RST_LED_CONTROL_FAN_BOARD_1_N",
+		"RST_IOEXP_FAN_BOARD_0_N","RST_IOEXP_FAN_BOARD_1_N",
+		"PWRGD_LOAD_SWITCH_FAN_BOARD_0_R","PWRGD_LOAD_SWITCH_FAN_BOARD_1_R",
+		"","";
+	};
+
+	gpio_ext2: pca9555@21 {
 		compatible = "nxp,pca9555";
-		reg = <0x21>;
+		pinctrl-names = "default";
 		gpio-controller;
 		#gpio-cells = <2>;
-	};
-
-	gpio@22 {
+		reg = <0x21>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <94 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+		"DELTA_MODULE_TYPE","VSENSE_ERR_VDROP_R",
+		"EN_P48V_AUX_0","EN_P48V_AUX_1",
+		"MEDUSA_BOARD_REV_0","MEDUSA_BOARD_REV_1",
+		"MEDUSA_BOARD_REV_2","MEDUSA_BOARD_TYPE",
+		"HSC_OCP_SLOT_ODD_GPIO1","HSC_OCP_SLOT_ODD_GPIO2",
+		"HSC_OCP_SLOT_ODD_GPIO3","HSC_OCP_SLOT_EVEN_GPIO1",
+		"HSC_OCP_SLOT_EVEN_GPIO2","HSC_OCP_SLOT_EVEN_GPIO3",
+		"ADC_TYPE_0_R","ADC_TYPE_1_R";
+	};
+
+	gpio_ext3: pca9555@22 {
 		compatible = "nxp,pca9555";
-		reg = <0x22>;
+		pinctrl-names = "default";
 		gpio-controller;
 		#gpio-cells = <2>;
-	};
-
-	gpio@23 {
+		reg = <0x22>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <94 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+		"CARD_TYPE_SLOT1","CARD_TYPE_SLOT2",
+		"CARD_TYPE_SLOT3","CARD_TYPE_SLOT4",
+		"CARD_TYPE_SLOT5","CARD_TYPE_SLOT6",
+		"CARD_TYPE_SLOT7","CARD_TYPE_SLOT8",
+		"OC_P48V_HSC_0_N","FLT_P48V_HSC_0_N",
+		"PWRGD_P12V_AUX_1","OC_P48V_HSC_1_N",
+		"FLT_P48V_HSC_1_N","PWRGD_P12V_AUX_1",
+		"MEDUSA_ADC_EFUSE_TYPE_R","P12V_HSC_TYPE";
+	};
+
+	gpio_ext4: pca9555@23 {
 		compatible = "nxp,pca9555";
-		reg = <0x23>;
+		pinctrl-names = "default";
 		gpio-controller;
 		#gpio-cells = <2>;
+		reg = <0x23>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <94 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+		"HSC1_ALERT1_R_N","HSC2_ALERT1_R_N",
+		"HSC3_ALERT1_R_N","HSC4_ALERT1_R_N",
+		"HSC5_ALERT1_R_N","HSC6_ALERT1_R_N",
+		"HSC7_ALERT1_R_N","HSC8_ALERT1_R_N",
+		"HSC1_ALERT2_R_N","HSC2_ALERT2_R_N",
+		"HSC3_ALERT2_R_N","HSC4_ALERT2_R_N",
+		"HSC5_ALERT2_R_N","HSC6_ALERT2_R_N",
+		"HSC7_ALERT2_R_N","HSC8_ALERT2_R_N";
+	};
+
+	power-sensor@40 {
+			compatible = "mps,mp5023";
+			reg = <0x40>;
 	};
 
 	temperature-sensor@48 {
@@ -868,19 +921,29 @@ temperature-sensor@49 {
 		reg = <0x49>;
 	};
 
-	temperature-sensor@4a {
-		compatible = "ti,tmp75";
-		reg = <0x4a>;
+	eeprom@54 {
+		compatible = "atmel,24c128";
+		reg = <0x54>;
 	};
 
-	temperature-sensor@4b {
-		compatible = "ti,tmp75";
-		reg = <0x4b>;
+	power-sensor@62 {
+		compatible = "pmbus";
+		reg = <0x62>;
 	};
 
-	eeprom@54 {
-		compatible = "atmel,24c256";
-		reg = <0x54>;
+	power-sensor@64 {
+		compatible = "pmbus";
+		reg = <0x64>;
+	};
+
+	power-sensor@65 {
+		compatible = "pmbus";
+		reg = <0x65>;
+	};
+
+	power-sensor@68 {
+		compatible = "pmbus";
+		reg = <0x68>;
 	};
 };
 
@@ -898,6 +961,11 @@ eeprom@50 {
 		reg = <0x50>;
 	};
 
+	eeprom@54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
+	};
+
 	rtc@6f {
 		compatible = "nuvoton,nct3018y";
 		reg = <0x6f>;
-- 
2.25.1

