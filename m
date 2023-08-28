Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D761B78A61B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 08:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjH1Gwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 02:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjH1GwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 02:52:00 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2065.outbound.protection.outlook.com [40.107.255.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09A9126;
        Sun, 27 Aug 2023 23:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ma9KpkMRl81Y7frWKOStplA6EO4lpodZ61Zee+gmXN/FezTJY/wzeatnOlJ1Nhl56MBi2jP9/ipI9htc3qrkjYrvlMAUiNCS+JswZuAFt2GINMWpV1ccxW/ECe993N/7TE3ZQKC7OBO9YbBUByqKtWuCt1IlOtBi70wF/5tycU8x0qyzgAc1wilCXES+ZRKIe0AUSyCTbeOGe5Wz4jxC6zBe/dFn1iPmOizMjAciIgvIXUgKZ2Lia1RB0XhWKH6ydHDPzcWTp1iDg4cYrduErZr9MfOuikGjDHK/DYALxunVZX3nqWNzyVxSQSCGbXHMgMnle/nlU2OAJiIuwNdM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WShTBVaZ1CC1VXip2nPScAhD1Bf1RGa4n21H6ZLCIpc=;
 b=YO4HPhozWmhQP5GWPGGP1kkXYxD/sdDnpoSFlP4fRdI4c/bp0atzJfAJi8Qro3KhqwzWj0xNIyY2L4VHNNLNMZMSPxW0nUuzUZ7iXRfAHSPPqITlwFN13f2mWHNCgb7V3T/O6O/d6J+2B71iZLd57om/iG71bpFCbKBgE3zDpwuFAKBhGUsnO7NWfSSkc0Npwnx8GNheQaLrd4eD40152tYdj1ybjpo1Ijhq4DSevSvvG2sNVzxj8jvRlKPUPBWYzYT4aYnOpiiKHKJ/nX9ZJqIfRMvGWmWQ82ARM/+DrO5HFiXFt/hXhwouA1zWfuXJrWCZb5zGFuFD2ZM1aGLwgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WShTBVaZ1CC1VXip2nPScAhD1Bf1RGa4n21H6ZLCIpc=;
 b=hHQsfYaaEoBbywvT5hdqLN8Q7sQJh3GyfSTWTZdIYVcGuB2SB5V75sVN3WT5wqXN4xIJtXCYmp260C794NUzLdn5C2ZlYmHVjN81+9+CJarotBsyUVFwb45wnWv5WHtZxs6ERsLMBGfDA9Hikx4nLEyTkmF3Zn6nCEF1ws27s9f5f4lsRpGjiFVBZltoiG+wtboKg9Qe1Jp8bel+JdH0LWBrEFeV6DIsfd19uAyBkebYJYAInil9Qx465SDuTnrsVKLKKE1+HDhSguagXoho+dwb57Mk6F6tuSuECvxgWKHTup5enGCIy1j659xih1KivDEvjTq+YXAkSRnhOVUoxA==
Received: from SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10) by
 TY2PR04MB3982.apcprd04.prod.outlook.com (2603:1096:404:8001::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 06:51:50 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:4:c7:cafe::14) by SG2P153CA0023.outlook.office365.com
 (2603:1096:4:c7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.6 via Frontend
 Transport; Mon, 28 Aug 2023 06:51:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 06:51:50
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 2/2] ARM: dts: aspeed: yosemite4: add Facebook Yosemite 4 BMC
Date:   Mon, 28 Aug 2023 14:51:36 +0800
Message-Id: <20230828065137.2332953-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230828065137.2332953-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230828065137.2332953-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TY2PR04MB3982:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a102babe-1d0f-48ad-5c32-08dba7934197
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C97qRdZ0LodKOOIr7y6Gc8C+dgeaZxPe3R6a9KyzEQU233mKovclsdtWEdiW8Du7d8Y6QaP2o6fL+couQjSw54jF+JwTX9XbGzRz5edoDPAvqhDbN4vfqngZd4COHxKRGe8KP3gFaGJqIA+bXoDhZy/jscsSFO6NARquqFFuoD3+9PDetnjxeYe6VMA8JQ80LtgwVllObBc9+ae8Qkb3MbScwufIEGARJSMxYTaGu2FR03yiMX6VynAveaudixsCRe7wFuqKwo+V8s1XZXDqbSVnbbU0KqegOLcMGaOysZZ2ko9s0mNxlOfQUVRecICUDRmWeTxwbHw4U4XS98u7XvDTVWTFDmrebsV4LVFzHGDTUHVr2gZGmrSE8LL5IOoIQJQqbMUDxkUAZuC515SyjmJWkL0SWRuwzw7LjZst9kHs9qVOOVBeGUYD7EtDwP09/5fSjTiQllhISJeCdJrcNlTKKpf+5dJL6kgnMnG8f8i8yeUXyK7gr7E/9f8LUn7XMaZGrYslh35YXl5tgWDJSlOGloBt9aDpBrO389AjSnzYXmFHIse5ApU6wSkwl1HjB3PaRoyD91XEh1rC3mNiuDR8eYidCG0SPFFm7Vs+sGtnnWwO+7d80oMWx+veG6ovXqqyQ8cwmMcWiuhIgxTZVt6yLuRrWGhn8MfDEBFS83FZp3CGctC2XJt5CBsfhXTk5Vlt2aVZGXaTy2h2Y0b2dw==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(346002)(396003)(376002)(136003)(39850400004)(47680400002)(1800799009)(451199024)(82310400011)(186009)(36840700001)(46966006)(8676002)(8936002)(4326008)(2906002)(36736006)(36756003)(110136005)(316002)(70206006)(70586007)(5660300002)(7416002)(336012)(41300700001)(36860700001)(6486002)(6506007)(2616005)(26005)(1076003)(6512007)(40480700001)(30864003)(81166007)(82740400003)(356005)(83380400001)(478600001)(86362001)(6666004)(47076005)(9316004)(956004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 06:51:50.3495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a102babe-1d0f-48ad-5c32-08dba7934197
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR04MB3982
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add linux device tree entry for Yosemite 4 devices connected to BMC.
The Yosemite 4 is a Meta multi-node server platform, based on AST2600 SoC.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
Changelog:
v12 - Add spi gpio config
v11 - Add imux configs for i2c-mux
    - Add gpio and eeprom devices
    - Remove temperature-sensor 11-004a and 11-004b
    - Change power-sensor ina230 to ina233
v10 - Change to 128MB flash layout from 64MB
 v9 - Remove mac2/mac3 duplicated setting about no-hw-checksum
 v8 - Add description of Yosemite 4
    - Remove unsupported ncsi config
    - Revise i2c-mux config
    - Correct power sensor i2c address
    - Restore i2c 11 bus-frequency to default
 v7 - Revise changelog format
 v6 - Change project name from yosemitev4 to yosemite4
 v5 - Revise rtc setting
    - Remove duplicated multi-master setting
 v3 - Revise the bootargs to stdout-path
    - Revise i2c devices
 v2 - Revise the DTS node name
---
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 1102 +++++++++++++++++
 2 files changed, 1103 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index c68984322a86..5b9264b823f3 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -26,6 +26,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-wedge400.dtb \
 	aspeed-bmc-facebook-yamp.dtb \
 	aspeed-bmc-facebook-yosemitev2.dtb \
+	aspeed-bmc-facebook-yosemite4.dtb \
 	aspeed-bmc-ibm-bonnell.dtb \
 	aspeed-bmc-ibm-everest.dtb \
 	aspeed-bmc-ibm-rainier.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
new file mode 100644
index 000000000000..851091a512dd
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -0,0 +1,1102 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2022 Facebook Inc.
+
+/dts-v1/;
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/leds/leds-pca955x.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	model = "Facebook Yosemite 4 BMC";
+	compatible = "facebook,yosemite4-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial4 = &uart5;
+		serial5 = &uart6;
+		serial6 = &uart7;
+		serial7 = &uart8;
+		serial8 = &uart9;
+
+		i2c16 = &imux16;
+		i2c17 = &imux17;
+		i2c18 = &imux18;
+		i2c19 = &imux19;
+		i2c20 = &imux20;
+		i2c21 = &imux21;
+		i2c22 = &imux22;
+		i2c23 = &imux23;
+		i2c24 = &imux24;
+		i2c25 = &imux25;
+		i2c26 = &imux26;
+		i2c27 = &imux27;
+		i2c28 = &imux28;
+		i2c29 = &imux29;
+		i2c30 = &imux30;
+		i2c31 = &imux31;
+		i2c32 = &imux32;
+		i2c33 = &imux33;
+	};
+
+	chosen {
+		stdout-path = "serial4:57600n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+				<&adc1 0>, <&adc1 1>;
+	};
+
+	spi_gpio: spi-gpio {
+		status = "okay";
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
+
+		tpmdev@0 {
+			compatible = "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&uart6 {
+	status = "okay";
+};
+
+&uart7 {
+	status = "okay";
+};
+
+&uart8 {
+	status = "okay";
+};
+
+&uart9 {
+	status = "okay";
+};
+
+&wdt1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst1_default>;
+	aspeed,reset-type = "soc";
+	aspeed,external-signal;
+	aspeed,ext-push-pull;
+	aspeed,ext-active-high;
+	aspeed,ext-pulse-duration = <256>;
+};
+
+&mac2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii3_default>;
+	use-ncsi;
+	mlx,multi-host;
+};
+
+&mac3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii4_default>;
+	use-ncsi;
+	mlx,multi-host;
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-128.dtsi"
+	};
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc2";
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+	mctp-controller;
+	bus-frequency = <400000>;
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	power-sensor@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	mctp-controller;
+	bus-frequency = <400000>;
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	power-sensor@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+	mctp-controller;
+	bus-frequency = <400000>;
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	power-sensor@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c3 {
+	status = "okay";
+	mctp-controller;
+	bus-frequency = <400000>;
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	power-sensor@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+	mctp-controller;
+	bus-frequency = <400000>;
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	power-sensor@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c5 {
+	status = "okay";
+	mctp-controller;
+	bus-frequency = <400000>;
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	power-sensor@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c6 {
+	status = "okay";
+	mctp-controller;
+	bus-frequency = <400000>;
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	power-sensor@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+	mctp-controller;
+	bus-frequency = <400000>;
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	power-sensor@40 {
+		compatible = "adi,adm1278";
+		reg = <0x40>;
+	};
+};
+
+&i2c8 {
+	status = "okay";
+	bus-frequency = <400000>;
+	i2c-mux@70 {
+		compatible = "nxp,pca9544";
+		idle-state = <0>;
+		i2c-mux-idle-disconnect;
+		reg = <0x70>;
+
+		imux16: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			gpio@20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+			};
+
+			gpio@21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+			};
+
+			gpio@22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+			};
+
+			gpio@23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+			};
+
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux17: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			gpio@20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+			};
+
+			gpio@21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+			};
+
+			gpio@22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+			};
+
+			gpio@23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+			};
+
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux18: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			gpio@20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+			};
+
+			gpio@21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+			};
+
+			gpio@22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+			};
+
+			gpio@23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+			};
+
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux19: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			gpio@20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+			};
+
+			gpio@21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+			};
+
+			gpio@22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+			};
+
+			gpio@23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+			};
+
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+	};
+};
+
+&i2c9 {
+	status = "okay";
+	bus-frequency = <400000>;
+	i2c-mux@71 {
+		compatible = "nxp,pca9544";
+		idle-state = <0>;
+		i2c-mux-idle-disconnect;
+		reg = <0x71>;
+
+		imux20: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			gpio@20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+			};
+
+			gpio@21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+			};
+
+			gpio@22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+			};
+
+			gpio@23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+			};
+
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux21: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			gpio@20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+			};
+
+			gpio@21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+			};
+
+			gpio@22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+			};
+
+			gpio@23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+			};
+
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux22: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			gpio@20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+			};
+
+			gpio@21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+			};
+
+			gpio@22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+			};
+
+			gpio@23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+			};
+
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux23: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			gpio@20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+			};
+
+			gpio@21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+			};
+
+			gpio@22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+			};
+
+			gpio@23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+			};
+
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+	};
+};
+
+&i2c10 {
+	status = "okay";
+	bus-frequency = <400000>;
+	i2c-mux@74 {
+		compatible = "nxp,pca9544";
+		idle-state = <0>;
+		i2c-mux-idle-disconnect;
+		reg = <0x74>;
+
+		imux28: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux29: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			gpio@20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+			};
+
+			gpio@21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+			};
+
+			gpio@22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+			};
+
+			gpio@23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+			};
+
+			gpio@24 {
+				compatible = "nxp,pca9506";
+				reg = <0x24>;
+			};
+		};
+	};
+};
+
+&i2c11 {
+	status = "okay";
+	power-sensor@10 {
+		compatible = "adi, adm1272";
+		reg = <0x10>;
+	};
+
+	power-sensor@12 {
+		compatible = "adi, adm1272";
+		reg = <0x12>;
+	};
+
+	gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9555";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	temperature-sensor@48 {
+		compatible = "ti,tmp75";
+		reg = <0x48>;
+	};
+
+	temperature-sensor@49 {
+		compatible = "ti,tmp75";
+		reg = <0x49>;
+	};
+
+	eeprom@54 {
+		compatible = "atmel,24c256";
+		reg = <0x54>;
+	};
+};
+
+&i2c12 {
+	status = "okay";
+	bus-frequency = <400000>;
+
+	temperature-sensor@48 {
+		compatible = "ti,tmp75";
+		reg = <0x48>;
+	};
+
+	eeprom@50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+
+	eeprom@54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
+	};
+
+	rtc@6f {
+		compatible = "nuvoton,nct3018y";
+		reg = <0x6f>;
+	};
+};
+
+&i2c13 {
+	status = "okay";
+	bus-frequency = <400000>;
+	gpio@20 {
+		compatible = "nxp,pca9506";
+		reg = <0x20>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+	};
+};
+
+&i2c14 {
+	status = "okay";
+	bus-frequency = <400000>;
+	adc@1d {
+		compatible = "ti,adc128d818";
+		reg = <0x1d>;
+		ti,mode = /bits/ 8 <2>;
+	};
+
+	adc@35 {
+		compatible = "ti,adc128d818";
+		reg = <0x35>;
+		ti,mode = /bits/ 8 <2>;
+	};
+
+	adc@37 {
+		compatible = "ti,adc128d818";
+		reg = <0x37>;
+		ti,mode = /bits/ 8 <2>;
+	};
+
+	power-sensor@40 {
+		compatible = "ti,ina233";
+		reg = <0x40>;
+	};
+
+	power-sensor@41 {
+		compatible = "ti,ina233";
+		reg = <0x41>;
+	};
+
+	power-sensor@42 {
+		compatible = "ti,ina233";
+		reg = <0x42>;
+	};
+
+	power-sensor@43 {
+		compatible = "ti,ina233";
+		reg = <0x43>;
+	};
+
+	power-sensor@44 {
+		compatible = "ti,ina233";
+		reg = <0x44>;
+	};
+
+	temperature-sensor@4e {
+		compatible = "ti,tmp75";
+		reg = <0x4e>;
+	};
+
+	temperature-sensor@4f {
+		compatible = "ti,tmp75";
+		reg = <0x4f>;
+	};
+
+	eeprom@51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+	};
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9846";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		idle-state = <0>;
+		i2c-mux-idle-disconnect;
+		reg = <0x71>;
+
+		imux30: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			adc@1f {
+				compatible = "ti,adc128d818";
+				reg = <0x1f>;
+				ti,mode = /bits/ 8 <2>;
+			};
+
+			pwm@20{
+				compatible = "max31790";
+				reg = <0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			gpio@22{
+				compatible = "ti,tca6424";
+				reg = <0x22>;
+			};
+
+			pwm@23{
+				compatible = "max31790";
+				reg = <0x23>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			adc@33 {
+				compatible = "maxim,max11615";
+				reg = <0x33>;
+			};
+
+			eeprom@52 {
+				compatible = "atmel,24c128";
+				reg = <0x52>;
+			};
+
+			gpio@61 {
+				compatible = "nxp,pca9552";
+				reg = <0x61>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+		};
+
+		imux31: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			adc@1f {
+				compatible = "ti,adc128d818";
+				reg = <0x1f>;
+				ti,mode = /bits/ 8 <2>;
+			};
+
+			pwm@20{
+				compatible = "max31790";
+				reg = <0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			gpio@22{
+				compatible = "ti,tca6424";
+				reg = <0x22>;
+			};
+
+			pwm@23{
+				compatible = "max31790";
+				reg = <0x23>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			adc@33 {
+				compatible = "maxim,max11615";
+				reg = <0x33>;
+			};
+
+			eeprom@52 {
+				compatible = "atmel,24c128";
+				reg = <0x52>;
+			};
+
+			gpio@61 {
+				compatible = "nxp,pca9552";
+				reg = <0x61>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+		};
+	};
+
+	i2c-mux@73 {
+		compatible = "nxp,pca9544";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		idle-state = <0>;
+		i2c-mux-idle-disconnect;
+		reg = <0x73>;
+
+		imux32: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			adc@35 {
+				compatible = "maxim,max11617";
+				reg = <0x35>;
+			};
+		};
+
+		imux33: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			adc@35 {
+				compatible = "maxim,max11617";
+				reg = <0x35>;
+			};
+		};
+	};
+};
+
+&i2c15 {
+	status = "okay";
+	mctp-controller;
+	multi-master;
+	bus-frequency = <400000>;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	i2c-mux@72 {
+		compatible = "nxp,pca9544";
+		idle-state = <0>;
+		i2c-mux-idle-disconnect;
+		reg = <0x72>;
+
+		imux24: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux25: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux26: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux27: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&adc0 {
+	ref_voltage = <2500>;
+	status = "okay";
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+			&pinctrl_adc2_default &pinctrl_adc3_default
+			&pinctrl_adc4_default &pinctrl_adc5_default
+			&pinctrl_adc6_default &pinctrl_adc7_default>;
+};
+
+&adc1 {
+	ref_voltage = <2500>;
+	status = "okay";
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>;
+};
+
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&uhci {
+	status = "okay";
+};
-- 
2.25.1

