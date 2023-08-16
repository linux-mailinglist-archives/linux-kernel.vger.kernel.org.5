Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9C577D91E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 05:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241656AbjHPDgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 23:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241687AbjHPDdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:33:08 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2058.outbound.protection.outlook.com [40.107.117.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F8130DA;
        Tue, 15 Aug 2023 20:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gX+tqxIac5U3Qwa/jsqncVqoX+bU1raieUmTAny3ZY6JzjCK7NDclRZkzRjStdmQCsf/Kia8WT0qt93FAYFK/ymFXKIoU581eOmOIRsPUfVeEjQLtoh6yoJFvi8lB8SOIJCfdEwip8/U1IvrONsbO6DdX7oHUDR1O6hpLNqXa3WQXXqK3vWt6aCs2ljNtUxooNpJ2SsUrE6ED64IlFsgG64TEJ+SQqE5E7M5lLuXKXWcP/yo+nF/ucap58W5T+QJ44m0EQYsJpPqfQ7xBem+pBvmSdE3DFKHWuoqsEm9sP2wxL/NIkLrulrtqDRxfJ3Tr+HqAPIcyG5bzv6KLFEl1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tK9PmkOhnHwuSkODX7um5Kdd2+ekrhXvuoaVdvTZpEw=;
 b=YlF4MiMNJVqU0R7DnvI+4VYhGAyom1loWn/PRC778MLLpTeevrJ9E1hqBuxwBkprQ2u1cMN3fNgo1V4iiLGqQyHMrw/wbBUmwmTs8oDfuVp83FYPrfReAgVJDGDe5JXs0oFLial1hAdAqU7wuzQCVdS0rX3Fciem1FTvL1rRDdkMe5u4+GB7k4KZ7PdUMx/FFgryPYlqxZF/NtVlqBl1GqEpJEPo7g2SsLm4W8rGNnygT7M6VS71UkkUUz4NBoQcimm2Zui1/Ux+Fh2QZm6gJ70iry4CSYhWX4vapgr1n7FoaD7LhAVFYpTG3hNr+EiTDaCnRkcv1/Uyg5BxW2qduA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tK9PmkOhnHwuSkODX7um5Kdd2+ekrhXvuoaVdvTZpEw=;
 b=4WQkZVMdN5NKrg9Y3pI2FwGg7aPLq05r3QnEpsFhvZxFU/JfR/pl2MSOXQpfPGzjj54S4Wa23k18NJec7Q7xy66JHjwWsxlAmQmQjV7cy7AkLjgdK9Hel2zalxiB+IX7YyxsX1/kf/yptREakZ9qTHtBvv58JrW/Kly1ZhJ5fd/n/JKn7+QPsI33L6kxuErcAI4RUnAA8r3RAFIWJ8UC4jDWNTa4T5XrwFNKRnUSSp96chH6egOVGo3s7bpRDWfsdUGOUAz+ipm6UNdTu0aMxX7iA2B+7BawcXTUN5kyDAGtWjzOYXBVZ0vCWv5Yh2jr5+xpXB0jgREaT+2xJtq7CA==
Received: from PU1PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:803:16::28) by TYZPR04MB4175.apcprd04.prod.outlook.com
 (2603:1096:400:23::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 03:31:48 +0000
Received: from PSAAPC01FT064.eop-APC01.prod.protection.outlook.com
 (2603:1096:803:16:cafe::a) by PU1PR01CA0040.outlook.office365.com
 (2603:1096:803:16::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Wed, 16 Aug 2023 03:31:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 PSAAPC01FT064.mail.protection.outlook.com (10.13.38.172) with Microsoft SMTP
 Server id 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 03:31:47
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/2] ARM: dts: aspeed: yosemite4: add Facebook Yosemite 4 BMC
Date:   Wed, 16 Aug 2023 11:31:32 +0800
Message-Id: <20230816033134.3750232-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816033134.3750232-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230816033134.3750232-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAAPC01FT064:EE_|TYZPR04MB4175:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1790ba10-d6a5-40c1-9105-08db9e0952ed
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCtrwEHjado3GiN5h76Rhj9COsD4PF7rri45AXv2dn1ZH1owvr4lcd9Cfh32TOkaXwftOjurg31O0yX8wVVxZon4cMzP1whqtWSg0vPtDVrfvXjKsieOrvcJOtvQeIpV2F2rJYqu1yssrsI7WgLmJW/Cuy1Dzq5juWaL0RIzSZXfdLzwfv9RoAKPnm+IQzQVZ5zI5M4Frtt/V5s/uP2PliCrf1b64FAZucr8M8zQYWaWMe1Ck4aO0w1ttdWb4f3CS8+lzRNLXqM5Y2du5Qo0n8kscA1tzdllWro6/trTtFgbunp5IxYlnJLNg5xb6n1gUQxgrTL0pzdkQcqTE+GTggkA3QW7hgPvf/KObOrjJeqpchfOf/UB2/cwYXI9UHR5B43xvrW+e3BkQLod6ZsZGkgEJeekF0fPCi6/FvK6UEXELvMB3Eg2qS6r0DeuR9umcRtOgqpye2uA0SiAiOfhZRUIXCj8PkcK5sdMTQsWEyNXc5XkB+4jkSUcK5/9G5hA4F/8iTTjJsk+NljRQeVDpU22tTrKKVs0NJ8qL0Gz5FiwZ219R/rvl0hfBo7qxOJlowPFzukoXvZIUp+GFodQ8dJtJMcTtKNsVClirIcDXxkKw06aHkU7ydsCC2rXLLSMICHi9mgF+9CDsGOYI3S6WxnvxxHFmVVyx0JeXgSOQxSUiFfWZYtie6SyKuot1IEEti3HNa3jNQ0WRHN02oC+yw==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(376002)(396003)(39850400004)(346002)(136003)(47680400002)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(6666004)(36736006)(54906003)(70586007)(70206006)(6512007)(6486002)(6506007)(30864003)(2906002)(478600001)(1076003)(336012)(26005)(9316004)(110136005)(7416002)(5660300002)(2616005)(956004)(83380400001)(41300700001)(316002)(47076005)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(36756003)(86362001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 03:31:47.9377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1790ba10-d6a5-40c1-9105-08db9e0952ed
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT064.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4175
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add linux device tree entry for Yosemite 4 devices connected to BMC.
The Yosemite 4 is a Meta multi-node server platform, based on AST2600 SoC.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
Changelog:
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
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 624 ++++++++++++++++++
 2 files changed, 625 insertions(+)
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
index 000000000000..1ef3ff849ec1
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -0,0 +1,624 @@
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
+	};
+};
+
+&i2c10 {
+	status = "okay";
+	bus-frequency = <400000>;
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
+	temperature-sensor@4a {
+		compatible = "ti,tmp75";
+		reg = <0x4a>;
+	};
+
+	temperature-sensor@4b {
+		compatible = "ti,tmp75";
+		reg = <0x4b>;
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
+	rtc@6f {
+		compatible = "nuvoton,nct3018y";
+		reg = <0x6f>;
+	};
+};
+
+&i2c13 {
+	status = "okay";
+	bus-frequency = <400000>;
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
+		compatible = "ti,ina230";
+		reg = <0x40>;
+	};
+
+	power-sensor@41 {
+		compatible = "ti,ina230";
+		reg = <0x41>;
+	};
+
+	power-sensor@42 {
+		compatible = "ti,ina230";
+		reg = <0x42>;
+	};
+
+	power-sensor@43 {
+		compatible = "ti,ina230";
+		reg = <0x43>;
+	};
+
+	power-sensor@44 {
+		compatible = "ti,ina230";
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
+		i2c@0 {
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
+		i2c@1 {
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
+		i2c@0 {
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
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
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

