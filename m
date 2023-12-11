Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9303F80C0F4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 06:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjLKFsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 00:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjLKFsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 00:48:33 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2054.outbound.protection.outlook.com [40.107.215.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF35189;
        Sun, 10 Dec 2023 21:48:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7m6AlDCMymwVI14M0jjXNrFtHQvr9oNn0f7c6T6RXSazP/lac5W8aWLeTXxEmRa/aBrqIFbtDmx9kfrRcPG90ILx9akV9mwywLgaU3ATLmagS6Qy0VQo0BCMN98FT93ZXqrsUxF/2kGaVawUxYunh+xBlqZ1PDqfsVnhCrzSbJIO/+/eFnrFImVpSyHubVyogAxH7XcFJKBHe+prH42mBxmOVfECnLWm2RUlXagWMKGLl/RWX5r0mxEyY5hp2Cg97Vb1D4SxezMR4igqBGtu4t6l4L8Fe2x2C7vvU84GMckniEDglryahuD9p6vKKvtSuWzAvEPfdmOA1YXca9EIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HS46iyiX5VqcZeS2QC5nTFB8RgeTDUaf1C1vb3s+wjU=;
 b=Ht7UUk93ZCeeVLkBR9JM73ryX7kEKmh/dh9NRYE/mwdRnXos4z0eGRWExVp9hN4GsKBCC/O/iUB+FL9/vwqGIj5WoQsq1RhVT/W/a4Dykwx5stbIYGstRK6+YRT/7fZonvWwfOX5UtCbRUNWThRaCSQPjzWL7WUFOBOkyHow5+4gGWIFUXotAythcZ3vCPAYL1csedhBMHk1cxaCsorSGztbS2GrZ9yyCWQDti7Y4QRk1OhVA7TqqSh77aCY8MPn/AFzpuc6PmiTXPypXgxk5Vj4Nti0iQ3yI/fYJTSUQuRuMVi2ncSLmB9l5DDIoUW2hn8bYqMjUXloHMQMUuc55Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HS46iyiX5VqcZeS2QC5nTFB8RgeTDUaf1C1vb3s+wjU=;
 b=GF1+D6dX3ChoqWbTnTmms8m44yBWBfUT9as0IpwpwFZM3Ld1x/CVyS87fmrFNBGkC2+BYsvZwa9UeHr2syiwoV4Rn6dOs3tsK3k4zx5FJHHmuep4k8F5n7WEf4axIvBCs0YY6MC+jdEVfnzi1WmMxaHZuK5/MF5yBXOFTuqpDoBukqegaqX/MhW4Afq6gpidkPPheyrXAEyuAhw3jELY8aQszoEVTnre6mOi7ctynQ6omzNXP9mOoCjAZX91zzMCFPKYzsn1DTBCNl1dP9KcMDuKDFpGRppm4qeBqbW1razoB5HRF+fQeRs8LJqTV7MF4sHwgQQfisXHzCv2u/wXEw==
Received: from SG2PR02CA0071.apcprd02.prod.outlook.com (2603:1096:4:54::35) by
 KL1PR0401MB6361.apcprd04.prod.outlook.com (2603:1096:820:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 05:48:10 +0000
Received: from HK2PEPF00006FAF.apcprd02.prod.outlook.com
 (2603:1096:4:54:cafe::75) by SG2PR02CA0071.outlook.office365.com
 (2603:1096:4:54::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 05:48:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FAF.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server id 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 05:48:10
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
Subject: [PATCH v3 08/14] ARM: dts: aspeed: yosemite4: Revise i2c11 and i2c12 schematic change
Date:   Mon, 11 Dec 2023 13:47:23 +0800
Message-Id: <20231211054730.208588-9-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211054730.208588-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231211054730.208588-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAF:EE_|KL1PR0401MB6361:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ae57db67-23c7-4750-f353-08dbfa0cc1ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0GG6hYT1eqA7IyD7NNzYWid0p30hTHb6MYMTvsU4VcQoriC7TBvAvm48p73+KPfSBaeAwsVZjWEH1loEcdvTeNmER42Ku+g9z7Ln1km4bOJ1oSIw/KKxAOVUNGNoSODEmzQaYJ2yMOwSC9P657lbsd4Hubs4EVeTmx76jUDyH4nQIU8LoZ0mmnherjJjPRiaKH6dNYq10IxNfMihteuChh4A12EIdqdxcnB43f7PCE9dXDCeJR1a8fklLsLaY55R8c4KWMHlGqRhroBXTXn3UJdK8tGwf1bLlHOx/cN4zOoKoZz2VJKuCnSk27OO3DzMYFlkQQRgv8g13QPUNdOBjBIQJd3t3TsjmOypGNj/oETfucPX8ApCcUQ+e4t1ClF111TmiU8ZTdAMQSjLAcUKG3scYR/dJmeKW7pqs8USOsNGiw3040a4PbA7JXBCZ6DmKYGL7LWGYk7sT2kK2A6CfNz0HPYW68/ky9kvZdRXPBv8sz6oVxNZY6AWbayAS/9zwJ4mfDGyQeZVqbexKK+Cr8kwmvNNhiVqq7goPwCYRD8t6+leSA4gmKtdvZiJssNRIl5/5syNOKBUzRpUSTqGHWDZD3jzolibXaQ7dfnWdV0HidXFQsMfoEnd4PvavVMh2r6tVWl2NZno3PcDwXGmMuJeifkkGJp4nmRQvFtzCizy/OZV8qusaSp0afuIJi44ekHFwZJdd2z7TsfuO8trw==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39850400004)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(36840700001)(46966006)(1076003)(26005)(956004)(2616005)(336012)(6506007)(6666004)(6512007)(36860700001)(83380400001)(47076005)(5660300002)(7416002)(41300700001)(2906002)(4326008)(478600001)(9316004)(6486002)(8676002)(8936002)(70206006)(70586007)(110136005)(316002)(36736006)(82740400003)(81166007)(86362001)(356005)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 05:48:10.2197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae57db67-23c7-4750-f353-08dbfa0cc1ff
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FAF.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6361
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=no autolearn_force=no
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
index da413325ce30..ccb5ecd8d9a6 100644
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

