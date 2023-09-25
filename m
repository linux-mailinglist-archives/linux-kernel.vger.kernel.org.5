Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157CB7AD19E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjIYH0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjIYH0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:26:02 -0400
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C21DF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1695626746; x=1698218746;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fG2AQybBXK2ENtVdwom+lwIpTx8vTnpLywHfvV+bOXQ=;
        b=Rhd+dqQO7XuNKvO1tn2IWTJhyyvQi94/XTNRk3kDgXh6HqnVZ0aRnI528sM4PT5h
        rnrKbwTaHXDe6AcM6mUurjNbYd2B8YPqfBboYjLIU2LiavF2T9DSBGYhJD1kPXD7
        hC5z2LZEhW3+GYWk09lSsat4XoaUHFP3ORmMl04J2j8=;
X-AuditID: ac14000a-6d65670000001e37-50-651135fa24d3
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 42.5C.07735.AF531156; Mon, 25 Sep 2023 09:25:46 +0200 (CEST)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 25 Sep
 2023 09:25:46 +0200
From:   Yannic Moog <y.moog@phytec.de>
Date:   Mon, 25 Sep 2023 09:25:19 +0200
Subject: [PATCH v2 2/2] arm64: dts: freescale: add phyGATE-Tauri i.MX 8M
 Mini Support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230925-tauri_upstream_support-v2-2-62a6dfc48e31@phytec.de>
References: <20230925-tauri_upstream_support-v2-0-62a6dfc48e31@phytec.de>
In-Reply-To: <20230925-tauri_upstream_support-v2-0-62a6dfc48e31@phytec.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <upstream@lists.phytec.de>,
        Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42JZI8nAo/vLVDDVYNINYYs1e88xWcw/co7V
        4uFVf4tVU3eyWPS9eMhscaj5AJPFpsfXWC26fq1ktri8aw6bReveI+wWf7dvYrF4sUXcovud
        ugOvx85Zd9k9Nq3qZPO4c20Pm8fmJfUe/d0trB4b3+1g8uj/a+DxeZNcAEcUl01Kak5mWWqR
        vl0CV8bJd+eYCpZmVty62s7awHgjtIuRk0NCwESi8cJ8JhBbSGAJk8S0Pq4uRi4g+xGjxNfn
        m9lAEmwCKhKPX9xjBbFZBFQl3j5bygJiCwuESyz9uZERxOYVEJQ4OfMJUJyDg1lAU2L9Ln2Q
        MLOAvMT2t3OYIUo8JY6decYIsctTom/zb7C9nAJeEjf3djOC7BUReMEkcWzaD1YQh1lgBaPE
        psfP2CAuFZZoX3QL6lJZiRfne9kh4vIS0869ZoawQyWObFrNNIFRaBaSm2Yh3DQLyU0LGJlX
        MQrlZiZnpxZlZusVZFSWpCbrpaRuYgTFlwgD1w7GvjkehxiZOBgPMUpwMCuJ8P56xpcqxJuS
        WFmVWpQfX1Sak1p8iFGag0VJnPd+D1OikEB6YklqdmpqQWoRTJaJg1OqgbH57/d5UV8n2Cor
        LW6dv/z7tsXxW7Ul8vOOfkhf8VJOgn0CS/4fvhPqf03DEy+JxzScrJZ66WjlOGNx78L4Rexm
        bhwK8Ycdsu3F/x28MOGOom9a48MV/+vbN3VZr+ULvdp47VH/pOkxs/3eX5rSabIncNaUtMSP
        628uur9n9wef/kfmp17vfi+gxFKckWioxVxUnAgAku+rnZ0CAAA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

phyGATE-Tauri uses a phyCORE-i.MX8MM SoM. Add device tree for the board.

Signed-off-by: Yannic Moog <y.moog@phytec.de>

---
v2:
	- change license from GPL-2 to (GPL-2+ OR MIT)
	- reorder properties for can, reg_usdhc2_vmmc nodes
	- rename can-clock to clock-can
	- use linux-event-codes header for gpio key
---
 arch/arm64/boot/dts/freescale/Makefile             |   1 +
 .../boot/dts/freescale/imx8mm-phygate-tauri-l.dts  | 489 +++++++++++++++++++++
 2 files changed, 490 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index a750be13ace8..68e5a878e359 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -66,6 +66,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-mx8menlo.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-nitrogen-r2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phg.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-phyboard-polis-rdk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-phygate-tauri-l.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-tqma8mqml-mba8mx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw71xx-0x.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts
new file mode 100644
index 000000000000..968f475b9a96
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts
@@ -0,0 +1,489 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023 PHYTEC Messtechnik GmbH
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/leds/common.h>
+#include "imx8mm-phycore-som.dtsi"
+
+/ {
+	model = "PHYTEC phyGATE-Tauri-L-iMX8MM";
+	compatible = "phytec,imx8mm-phygate-tauri-l",
+		     "phytec,imx8mm-phycore-som", "fsl,imx8mm";
+
+	chosen {
+		stdout-path = &uart3;
+	};
+
+	can_osc_40m: clock-can {
+		compatible = "fixed-clock";
+		clock-frequency = <40000000>;
+		clock-output-names = "can_osc_40m";
+		#clock-cells = <0>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpiokeys>;
+
+		key {
+			gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+			label = "KEY-A";
+			linux,code = <KEY_A>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds>;
+
+		led-1 {
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio5 5 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "none";
+		};
+
+		led-2 {
+			color = <LED_COLOR_ID_YELLOW>;
+			gpios = <&gpio4 30 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "none";
+		};
+	};
+
+	usdhc1_pwrseq: pwr-seq {
+		compatible = "mmc-pwrseq-simple";
+		post-power-on-delay-ms = <100>;
+		power-off-delay-us = <60>;
+		reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
+	};
+
+	reg_usb_hub_vbus: regulator-hub-otg1 {
+		compatible = "regulator-fixed";
+		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbhubpwr>;
+		regulator-name = "usb_hub_vbus";
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+	};
+
+	reg_usb_otg1_vbus: regulator-usb-otg1 {
+		compatible = "regulator-fixed";
+		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbotg1pwr>;
+		regulator-name = "usb_otg1_vbus";
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		off-on-delay-us = <20000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "VSD_3V3";
+	};
+};
+
+&ecspi1 {
+	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>,
+		   <&gpio5 13 GPIO_ACTIVE_LOW>,
+		   <&gpio5 2 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1_cs>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	/* CAN MCP251XFD */
+	can0: can@0 {
+		compatible = "microchip,mcp251xfd";
+		reg = <0>;
+		clocks = <&can_osc_40m>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_can_int>;
+		spi-max-frequency = <10000000>;
+	};
+
+	tpm: tpm@1 {
+		compatible = "tcg,tpm_tis-spi";
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tpm>;
+		reg = <1>;
+		spi-max-frequency = <38000000>;
+	};
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	temp_sense0: temperature-sensor@49 {
+		compatible = "ti,tmp102";
+		reg = <0x49>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tempsense>;
+		#thermal-sensor-cells = <1>;
+	};
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_gpio>;
+	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4_gpio>;
+	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+/* PCIe */
+&pcie0 {
+	assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
+			  <&clk IMX8MM_CLK_PCIE1_PHY>,
+			  <&clk IMX8MM_CLK_PCIE1_CTRL>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
+				 <&clk IMX8MM_SYS_PLL2_100M>,
+				 <&clk IMX8MM_SYS_PLL2_250M>;
+	assigned-clock-rates = <10000000>, <100000000>, <250000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio3 22 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+	status = "okay";
+};
+
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
+	status = "okay";
+};
+
+/* RTC */
+&rv3028 {
+	trickle-resistor-ohms = <3000>;
+};
+
+&uart1 {
+	assigned-clocks = <&clk IMX8MM_CLK_UART1>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_80M>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+/* UART2 - RS232 */
+&uart2 {
+	assigned-clocks = <&clk IMX8MM_CLK_UART2>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_80M>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+/* UART - console */
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+/* USB */
+&usbotg1 {
+	adp-disable;
+	dr_mode = "otg";
+	over-current-active-low;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg1>;
+	srp-disable;
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	status = "okay";
+};
+
+&usbotg2 {
+	disable-over-current;
+	dr_mode = "host";
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	vbus-supply = <&reg_usb_hub_vbus>;
+	status = "okay";
+};
+
+/* SD-Card */
+&usdhc2 {
+	assigned-clocks = <&clk IMX8MM_CLK_USDHC2>;
+	assigned-clock-rates = <200000000>;
+	bus-width = <4>;
+	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	vqmmc-supply = <&reg_nvcc_sd2>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_can_int: can-intgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8	0x00
+		>;
+	};
+
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO	0x82
+			MX8MM_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI	0x82
+			MX8MM_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK	0x82
+		>;
+	};
+
+	pinctrl_ecspi1_cs: ecspi1csgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9	0x00
+			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13	0x00
+			MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2	0x00
+		>;
+	};
+
+	pinctrl_gpiokeys: keygrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9	0x00
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL	0x400001c2
+			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA	0x400001c2
+		>;
+	};
+
+	pinctrl_i2c2_gpio: i2c2gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SDA_GPIO5_IO17		0x1e0
+			MX8MM_IOMUXC_I2C2_SCL_GPIO5_IO16		0x1e0
+		>;
+	};
+
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL	0x400001c2
+			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA	0x400001c2
+		>;
+	};
+
+	pinctrl_i2c3_gpio: i2c3gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SDA_GPIO5_IO19		0x1e0
+			MX8MM_IOMUXC_I2C3_SCL_GPIO5_IO18		0x1e0
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL	0x400001c2
+			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA	0x400001c2
+		>;
+	};
+
+	pinctrl_i2c4_gpio: i2c4gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C4_SDA_GPIO5_IO21		0x1e0
+			MX8MM_IOMUXC_I2C4_SCL_GPIO5_IO20		0x1e0
+		>;
+	};
+
+	pinctrl_leds: leds1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI3_RXD_GPIO4_IO30	0x00
+			MX8MM_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5	0x00
+		>;
+	};
+
+	pinctrl_pcie: pciegrp {
+		fsl,pins = <
+			/* COEX2 */
+			MX8MM_IOMUXC_SAI5_RXD1_GPIO3_IO22	0x00
+			/* COEX1 */
+			MX8MM_IOMUXC_SAI1_TXD0_GPIO4_IO12	0x12
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO01_PWM1_OUT	0x40
+		>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_TX_PWM3_OUT		0x40
+		>;
+	};
+
+	pinctrl_pwm4: pwm4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO15_PWM4_OUT	0x40
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19     0x40
+		>;
+	};
+
+	pinctrl_tempsense: tempsensegrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI3_TXFS_GPIO4_IO31	0x00
+		>;
+	};
+
+	pinctrl_tpm: tpmgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_STROBE_GPIO2_IO11	0x140
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX	0x00
+			MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX	0x00
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX	0x00
+			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x00
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX	0x140
+			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_usbhubpwr: usbhubpwrgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO14_GPIO1_IO14	0x00
+		>;
+	};
+
+	pinctrl_usbotg1pwr: usbotg1pwrgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO12_GPIO1_IO12	0x00
+		>;
+	};
+
+	pinctrl_usbotg1: usbotg1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO13_USB1_OTG_OC	0x80
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x182
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0xc6
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0xc6
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0xc6
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0xc6
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0xc6
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12	0x40
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x192
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d2
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d2
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d2
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d2
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d2
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2100mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x194
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2200mhzgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x196
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d6
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d6
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d6
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d6
+		>;
+	};
+};

-- 
2.34.1

