Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948AE773FE7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjHHQzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjHHQyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:54:31 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2053.outbound.protection.outlook.com [40.107.215.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9005A8C1D;
        Tue,  8 Aug 2023 08:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdvqlWVn4rx6fdSChwSDS80SApKj8AnayLCdAneXgkO01PkJxPo+nXeojuQAbqUAueTIWeXSMfjQpsowmH2vbPEpF4qiUqmZacyDRCXusijHc+rLxck5pmB+b3l73RC2KTbY9a7wbmYaNcvNQFVGwkdq5Bj0Xz+4rLIayz2tDtIjjl5ZCfwcSAmveQfy3/C5wDA1ziHR/rvGXaG9/P35cDQCW+Yr5xUXdGA07yr98GNgQYm/lNrNnkSZANWCZYj8Q5w9l35P5RNqtCT6Xj89j29JrOz9FAQyE1ubyId9A4PF20ZKGyLM1z6sJkEnM6jOCdHLBurwrVhEpURcfXTwuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWr8jTfWsy6xSvWGJxkUGtIEPXRjjlOKDZ4q4guGqFs=;
 b=GFYH481nS6BC1CZdP9J6MWpfqVCg/mZbCUzqJoAMq85uN8TYdLgvvqsqXfa4vRwdE06/pY3gQQY55mL4SETxgO3lb/+o0e2C+yLqnsX7BlhQt+lNgB4CCOkaQX3nYoEEh+rziOq4BwwBM1QDCHBQtgon8LQju6oJtRaAyysewdJtY5wk/ZGBIN+dLMz7n9AGrkOU2ukoixAem7LuQXHheXMiokhfSj6aNw8vdOr6Ky98Onv/ojv8Zo13/VT4uaYzgtpiYV6REE7XYkQG7TZ2DVkOtxzUb5Bd2dtQqrzm3co5KsIUQMvmAuWmMCpx8Mqgr49Kuy5PL/WNcRtyidGkvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWr8jTfWsy6xSvWGJxkUGtIEPXRjjlOKDZ4q4guGqFs=;
 b=Czgp3BrHLI680SpamWiEXuVeMIiadsWRpkuWu7NHYZE2ocJgIk0pjDCSmQitHX/X8Ik/Xe4PeTStrSkeeD+bIBja0UaUqmR/1AEhVWX5kX72ukGSPvtXxpHXWq286GvtRSUnilbWsUVMIO2PnACSBSXviS79Fxo5hM4FjeQdX/NZEH+8zoAv8gHua6otY2wN5pM6pNPL6I35vEtuNXTe0x6SDJfqT4DVRcn9enUF7fAdXpCki2BgWESUDH1R4FzY9XJVpmmXFxlHUw+Ja1tPyOfgv2wb1oe4d+WYZ9QpTLHMcq7q2fzMiTkhWbRnlSwy4bKM8j8PZb4Fu1F2EwhqfQ==
Received: from SG2PR06CA0195.apcprd06.prod.outlook.com (2603:1096:4:1::27) by
 TYZPR04MB6810.apcprd04.prod.outlook.com (2603:1096:400:333::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.25; Tue, 8 Aug 2023 08:43:00 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:4:1:cafe::4b) by SG2PR06CA0195.outlook.office365.com
 (2603:1096:4:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 08:43:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 08:42:59
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/2] ARM: dts: aspeed: yosemitev4: add Facebook Yosemite 4 BMC
Date:   Tue,  8 Aug 2023 16:42:46 +0800
Message-Id: <20230808084248.1415678-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808084248.1415678-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230808084248.1415678-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|TYZPR04MB6810:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: efeed7ec-de3a-4d96-92e8-08db97eb7894
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7j9hYTJ+8nUPuwZtCTGa2XHokaVVuBsuyf+Tb6jcwSbhPsFdjsffPBeYLm0vRy8jDGpxyPnRVvhcarHYer4TIpnFBGy4rdrODt8ZhX4sGhUe56PwLlHF9pXLiSd8Idzyg3UyQMqyFYl7t2hucK2iEW9RuyJmopCvuAjN7AfLstzwa7Aw3fF9HX4ujtq1z250oBfNM7bwHFD8ONBzEgsZLjvhkvyYmREQ//PBQELM7xcHoMz+SKDIe9vD8NzKhWV44EPtEUaA/ykb2XEfE0qa4kx+3U0AGvO+OtisfTm6dfDq132Bsk6ZPWMuzRQs9D3mqf6Ahb9c6Wi4qq1NlAhGomquL/46VBLfHTsVMx+2Hd2HWZ2/3cDPGcOjoAadEnZd9V536aMsvpb1DLatR7xt+ab+hHmdI66QjUGsctZ/ftzPX96TvequtNVDgTe/P7mg9s7iGLcPXuyaaI7kabioaSxatKcrNWszUNsu2ikFEtGUBtJ0jr6swM/8YcTQ1y6tIfhF3G0oACLcxYXSn2r0LmgGEt0SbbUOB1ul5j6ZBINL2aYh/Vec9B0pTY7w1y2wStTKBrgStsSN15EVz9aoIoRWZsn7cVeHLKm7Yz8oGVkf1YCQaafLrchauTuxY4lWtlb9WI+oLNf2cZblYJHoe6UkOwMFmZmVXb9uaY3MZzbzzzCR3kobAKuKJ12z0RHPghQ7tS6poA/La62umDN+zw==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(6069001)(4636009)(376002)(39850400004)(136003)(346002)(396003)(47680400002)(186006)(1800799003)(451199021)(82310400008)(46966006)(36840700001)(4326008)(2906002)(47076005)(70206006)(70586007)(9316004)(6486002)(336012)(6666004)(36860700001)(7416002)(5660300002)(41300700001)(316002)(8936002)(36736006)(8676002)(30864003)(40480700001)(81166007)(356005)(956004)(2616005)(110136005)(478600001)(82740400003)(36756003)(26005)(6506007)(1076003)(86362001)(6512007);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 08:42:59.6824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efeed7ec-de3a-4d96-92e8-08db97eb7894
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6810
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add linux device tree entry related to
Yosemite 4 specific devices connected to BMC SoC.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
Changelog:
v7 - Revise changelog format
v6 - Change project name from yosemitev4 to yosemite4
v5 - Revise rtc setting
   - Remove duplicated multi-master setting
v3 - Revise the bootargs to stdout-path
   - Revise i2c devices
v2 - Revise the DTS node name
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 633 ++++++++++++++++++
 2 files changed, 634 insertions(+)
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
index 000000000000..0791dea588b2
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -0,0 +1,633 @@
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
+	no-hw-checksum;
+	use-ncsi;
+	mlx,multi-host;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-ctrl,no-channel-monitor;
+	ncsi-package = <1>;
+	ncsi-channel = <1>;
+	ncsi-rexmit = <1>;
+	ncsi-timeout = <2>;
+};
+
+&mac3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii4_default>;
+	no-hw-checksum;
+	use-ncsi;
+	mlx,multi-host;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-ctrl,no-channel-monitor;
+	ncsi-package = <1>;
+	ncsi-channel = <1>;
+	ncsi-rexmit = <1>;
+	ncsi-timeout = <2>;
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
+#include "openbmc-flash-layout-64.dtsi"
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
+	bus-frequency = <400000>;
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
+	power-sensor@41 {
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

