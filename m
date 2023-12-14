Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0A38132FC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573448AbjLNOXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573468AbjLNOXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:23:31 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C54CB2;
        Thu, 14 Dec 2023 06:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1702563815; x=1734099815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ly6VDC39UW37scmECtpOW1sM6jcGuFqlkdAzqlPaqwM=;
  b=qTDKjqCTGfG5S/xDIXPm4kcN3TlPhbVAtwa2swEx00atgXb6NjrAWFUp
   IHGIOegev/FmoqW9BBBbZV9lr0Dkbp7+OBmxCmgf3PYJELchufQrs0OQL
   F9HksIh5DjWKhvLEX0tVfjT70hum09nKIOETEpn+wOxBaGuFVDP+JBCkW
   Z4+7CtaUOQNa0Ny3A7xsgbGafVkz/6J0nQJqRTX2af2J0M0NUYn8un0SM
   FvtPrt59SFCSmTCKpTvBQScQvynse00wl3TEqHQFadf93d6ZpiVjfPECH
   RZ5HFZ8SGP9SKKTWRVqib5deyt5d7chzfPwDVMu0vTR4B1SlWO/SNG/sY
   w==;
X-IronPort-AV: E=Sophos;i="6.04,275,1695679200"; 
   d="scan'208";a="34512089"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 14 Dec 2023 15:23:30 +0100
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 84BDC280084;
        Thu, 14 Dec 2023 15:23:30 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/4] arm64: dts: freescale: add initial device tree for TQMa8Xx
Date:   Thu, 14 Dec 2023 15:23:26 +0100
Message-Id: <20231214142327.1962914-4-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214142327.1962914-1-alexander.stein@ew.tq-group.com>
References: <20231214142327.1962914-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for TQMa8XQP and TQMa8XDP modules on MBa8Xx board.
As the only difference is the mounted SoC, both module and baseboard
files are shared.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../dts/freescale/imx8dxp-tqma8xdp-mba8xx.dts |  16 +
 .../boot/dts/freescale/imx8dxp-tqma8xdp.dtsi  |  24 +
 .../dts/freescale/imx8qxp-tqma8xqp-mba8xx.dts |  16 +
 .../boot/dts/freescale/imx8qxp-tqma8xqp.dtsi  |  14 +
 arch/arm64/boot/dts/freescale/mba8xx.dtsi     | 532 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/tqma8xx.dtsi    | 265 +++++++++
 7 files changed, 869 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp-mba8xx.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp-mba8xx.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/mba8xx.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/tqma8xx.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 85abcb00811a7..8016f92cf130f 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -54,6 +54,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds-899b.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds-9999.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8dxp-tqma8xdp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-data-modul-edm-sbc.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
@@ -196,6 +197,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-eval-v3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-iris.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-iris-v2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp-mba8xx.dts b/arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp-mba8xx.dts
new file mode 100644
index 0000000000000..f35514b7b3387
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp-mba8xx.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR X11)
+/*
+ * Copyright 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Alexander Stein
+ */
+
+/dts-v1/;
+
+#include "imx8dxp-tqma8xdp.dtsi"
+#include "mba8xx.dtsi"
+
+/ {
+	model = "TQ-Systems i.MX8DXP TQMa8XDP on MBa8Xx";
+	compatible = "tq,imx8dxp-tqma8xdp-mba8xx", "tq,imx8dxp-tqma8xdp", "fsl,imx8dxp";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp.dtsi b/arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp.dtsi
new file mode 100644
index 0000000000000..e2de8517aa0ef
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp.dtsi
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR X11)
+/*
+ * Copyright 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Alexander Stein
+ */
+
+#include "imx8dxp.dtsi"
+#include "tqma8xx.dtsi"
+
+/ {
+	model = "TQ-Systems i.MX8DXP TQMa8XDP";
+	compatible = "tq,imx8dxp-tqma8xdp", "fsl,imx8dxp";
+};
+
+&pmic_thermal {
+	cooling-maps {
+		map0 {
+			cooling-device =
+				<&A35_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+				<&A35_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp-mba8xx.dts b/arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp-mba8xx.dts
new file mode 100644
index 0000000000000..7d2e98bf8bc55
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp-mba8xx.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR X11)
+/*
+ * Copyright 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Alexander Stein
+ */
+
+/dts-v1/;
+
+#include "imx8qxp-tqma8xqp.dtsi"
+#include "mba8xx.dtsi"
+
+/ {
+	model = "TQ-Systems i.MX8QXP TQMa8XQP on MBa8Xx";
+	compatible = "tq,imx8qxp-tqma8xqp-mba8xx", "tq,imx8qxp-tqma8xqp", "fsl,imx8qxp";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp.dtsi
new file mode 100644
index 0000000000000..b14040bf4ddd5
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR X11)
+/*
+ * Copyright 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Alexander Stein
+ */
+
+#include "imx8qxp.dtsi"
+#include "tqma8xx.dtsi"
+
+/ {
+	model = "TQ-Systems i.MX8QXP TQMa8XQP";
+	compatible = "tq,imx8qxp-tqma8xqp", "fsl,imx8qxp";
+};
diff --git a/arch/arm64/boot/dts/freescale/mba8xx.dtsi b/arch/arm64/boot/dts/freescale/mba8xx.dtsi
new file mode 100644
index 0000000000000..a263c3d008023
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/mba8xx.dtsi
@@ -0,0 +1,532 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR X11)
+/*
+ * Copyright 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Alexander Stein
+ */
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/net/ti-dp83867.h>
+
+/ {
+	adc {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>;
+	};
+
+	aliases {
+		rtc0 = &pcf85063;
+		rtc1 = &rtc;
+	};
+
+	backlight_lvds: backlight-lvds {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_bl_lvds>;
+		pwms = <&adma_pwm 0 5000000 0>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+		power-supply = <&reg_12v0>;
+		enable-gpios = <&lsio_gpio1 30 GPIO_ACTIVE_HIGH>;
+		status = "disabled";
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpiobuttons>;
+		autorepeat;
+
+		switch-a {
+			label = "switcha";
+			linux,code = <BTN_0>;
+			gpios = <&lsio_gpio1 13 GPIO_ACTIVE_LOW>;
+		};
+
+		switch-b {
+			label = "switchb";
+			linux,code = <BTN_1>;
+			gpios = <&lsio_gpio1 14 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		led1 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&expander 1 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+
+		led2 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_HEARTBEAT;
+			gpios = <&expander 2 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	/* TODO LVDS panels */
+
+	reg_12v0: regulator-12v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "V_12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		gpio = <&expander 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_pcie_1v5: regulator-pcie-1v5 {
+		compatible = "regulator-fixed";
+		regulator-name = "MBA8XX_PCIE_1V5";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_pcie_1v5>;
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		gpio = <&lsio_gpio0 30 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <1000>;
+		enable-active-high;
+	};
+
+	reg_pcie_3v3: regulator-pcie-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "MBA8XX_PCIE_3V3";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_pcie_3v3>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&lsio_gpio0 31 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <1000>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	reg_3v3_mb: regulator-usdhc2-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "V_3V3_MB";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	/* TODO: Audio */
+};
+
+&adc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0>;
+	vref-supply = <&reg_1v8>;
+	#io-channel-cells = <1>;
+	status = "okay";
+};
+
+&adma_pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_admapwm>;
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_ethphy0>;
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+			ti,dp83867-rxctrl-strap-quirk;
+			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+			reset-gpios = <&lsio_gpio3 2 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <500000>;
+			reset-deassert-us = <50000>;
+			enet-phy-lane-no-swap;
+			interrupt-parent = <&lsio_gpio3>;
+			interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
+		};
+
+		ethphy3: ethernet-phy@3 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <3>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_ethphy3>;
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+			ti,dp83867-rxctrl-strap-quirk;
+			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+			reset-gpios = <&lsio_gpio3 3 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <500000>;
+			reset-deassert-us = <50000>;
+			enet-phy-lane-no-swap;
+			interrupt-parent = <&lsio_gpio3>;
+			interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		};
+	};
+};
+
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec2>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy3>;
+	status = "okay";
+};
+
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can0>;
+	xceiver-supply = <&reg_3v3>;
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1>;
+	xceiver-supply = <&reg_3v3>;
+	status = "okay";
+};
+
+&i2c1 {
+	/* TODO: Add Audio codec */
+
+	se97b_1c: temperature-sensor@1c {
+		compatible = "nxp,se97b", "jedec,jc-42.4-temp";
+		reg = <0x1c>;
+	};
+
+	at24c02_54: eeprom@54 {
+		compatible = "nxp,se97b", "atmel,24c02";
+		reg = <0x54>;
+		pagesize = <16>;
+		vcc-supply = <&reg_3v3>;
+	};
+
+	expander: gpio@70 {
+		compatible = "nxp,pca9538";
+		reg = <0x70>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pca9538>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&lsio_gpio4>;
+		interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		vcc-supply = <&reg_1v8>;
+
+		gpio-line-names = "", "LED_A",
+				  "LED_B", "",
+				  "DSI_EN", "USB_RESET#",
+				  "V_12V_EN", "PCIE_DIS#";
+	};
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-1 = <&pinctrl_lpi2c2gpio>;
+	scl-gpios = <&lsio_gpio1 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&lsio_gpio2 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+/* TODO LDB */
+
+&lpspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1>;
+	cs-gpios = <&lsio_gpio0 27 GPIO_ACTIVE_LOW>, <&lsio_gpio0 29 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&lpspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2>;
+	cs-gpios = <&lsio_gpio1 0 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&lpspi3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi3>;
+	num-cs = <2>;
+	cs-gpios = <&lsio_gpio0 16 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&lpuart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart1>;
+	status = "okay";
+};
+
+&lpuart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart3>;
+	status = "okay";
+};
+
+&lsio_gpio3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lsgpio3>;
+	gpio-line-names = "", "", "", "",
+			  "", "", "", "",
+			  "", "", "", "",
+			  "", "", "", "X4_15",
+			  "", "", "", "",
+			  "", "", "", "",
+			  "", "", "", "",
+			  "", "", "", "";
+};
+
+/* TODO: Mini-PCIe */
+
+/* TODO: SAI1 */
+
+&usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg1>;
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	power-active-high;
+	over-current-active-low;
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbotg3 {
+	status = "okay";
+};
+
+&usbotg3_cdns3 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy1 {
+	status = "okay";
+};
+
+&usb3_phy {
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	bus-width = <4>;
+	cd-gpios = <&lsio_gpio4 22 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&lsio_gpio4 21 GPIO_ACTIVE_HIGH>;
+	vmmc-supply = <&reg_3v3_mb>;
+	no-1-8-v;
+	no-sdio;
+	no-mmc;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_adc0: adc0grp {
+		fsl,pins = <IMX8QXP_ADC_IN0_ADMA_ADC_IN0	0x02000060>,
+			   <IMX8QXP_ADC_IN1_ADMA_ADC_IN1	0x02000060>,
+			   <IMX8QXP_ADC_IN2_ADMA_ADC_IN2	0x02000060>,
+			   <IMX8QXP_ADC_IN3_ADMA_ADC_IN3	0x02000060>;
+	};
+
+	pinctrl_admapwm: admapwmgrp {
+		fsl,pins = <IMX8QXP_SPI0_CS1_ADMA_LCD_PWM0_OUT	0x00000021>;
+	};
+
+	pinctrl_bl_lvds: bllvdsgrp {
+		fsl,pins = <IMX8QXP_MIPI_DSI1_I2C0_SDA_LSIO_GPIO1_IO30	0x00000021>;
+	};
+
+	pinctrl_can0: can0grp {
+		fsl,pins = <IMX8QXP_UART0_RX_ADMA_FLEXCAN0_RX		0x00000021>,
+			   <IMX8QXP_UART0_TX_ADMA_FLEXCAN0_TX		0x00000021>;
+	};
+
+	pinctrl_can1: can1grp {
+		fsl,pins = <IMX8QXP_UART2_RX_ADMA_FLEXCAN1_RX		0x00000021>,
+			   <IMX8QXP_UART2_TX_ADMA_FLEXCAN1_TX		0x00000021>;
+	};
+
+	pinctrl_ethphy0: ethphy0grp {
+		fsl,pins = <IMX8QXP_CSI_EN_LSIO_GPIO3_IO02		0x00000040>,
+			   <IMX8QXP_CSI_PCLK_LSIO_GPIO3_IO00		0x00000040>;
+	};
+
+	pinctrl_ethphy3: ethphy3grp {
+		fsl,pins = <IMX8QXP_CSI_RESET_LSIO_GPIO3_IO03		0x00000040>,
+			   <IMX8QXP_CSI_MCLK_LSIO_GPIO3_IO01		0x00000040>;
+	};
+
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <IMX8QXP_ENET0_MDC_CONN_ENET0_MDC			0x06000041>,
+			   <IMX8QXP_ENET0_MDIO_CONN_ENET0_MDIO			0x06000041>,
+			   <IMX8QXP_ENET0_RGMII_TX_CTL_CONN_ENET0_RGMII_TX_CTL	0x00000040>,
+			   <IMX8QXP_ENET0_RGMII_TXC_CONN_ENET0_RGMII_TXC	0x00000040>,
+			   <IMX8QXP_ENET0_RGMII_TXD0_CONN_ENET0_RGMII_TXD0	0x00000040>,
+			   <IMX8QXP_ENET0_RGMII_TXD1_CONN_ENET0_RGMII_TXD1	0x00000040>,
+			   <IMX8QXP_ENET0_RGMII_TXD2_CONN_ENET0_RGMII_TXD2	0x00000040>,
+			   <IMX8QXP_ENET0_RGMII_TXD3_CONN_ENET0_RGMII_TXD3	0x00000040>,
+			   <IMX8QXP_ENET0_RGMII_RX_CTL_CONN_ENET0_RGMII_RX_CTL	0x00000040>,
+			   <IMX8QXP_ENET0_RGMII_RXC_CONN_ENET0_RGMII_RXC	0x00000040>,
+			   <IMX8QXP_ENET0_RGMII_RXD0_CONN_ENET0_RGMII_RXD0	0x00000040>,
+			   <IMX8QXP_ENET0_RGMII_RXD1_CONN_ENET0_RGMII_RXD1	0x00000040>,
+			   <IMX8QXP_ENET0_RGMII_RXD2_CONN_ENET0_RGMII_RXD2	0x00000040>,
+			   <IMX8QXP_ENET0_RGMII_RXD3_CONN_ENET0_RGMII_RXD3	0x00000040>;
+	};
+
+	pinctrl_fec2: fec2grp {
+		fsl,pins = <IMX8QXP_ESAI0_SCKR_CONN_ENET1_RGMII_TX_CTL		0x00000040>,
+			   <IMX8QXP_ESAI0_FSR_CONN_ENET1_RGMII_TXC		0x00000040>,
+			   <IMX8QXP_ESAI0_TX4_RX1_CONN_ENET1_RGMII_TXD0		0x00000040>,
+			   <IMX8QXP_ESAI0_TX5_RX0_CONN_ENET1_RGMII_TXD1		0x00000040>,
+			   <IMX8QXP_ESAI0_FST_CONN_ENET1_RGMII_TXD2		0x00000040>,
+			   <IMX8QXP_ESAI0_SCKT_CONN_ENET1_RGMII_TXD3		0x00000040>,
+			   <IMX8QXP_ESAI0_TX0_CONN_ENET1_RGMII_RXC		0x00000040>,
+			   <IMX8QXP_SPDIF0_TX_CONN_ENET1_RGMII_RX_CTL		0x00000040>,
+			   <IMX8QXP_SPDIF0_RX_CONN_ENET1_RGMII_RXD0		0x00000040>,
+			   <IMX8QXP_ESAI0_TX3_RX2_CONN_ENET1_RGMII_RXD1		0x00000040>,
+			   <IMX8QXP_ESAI0_TX2_RX3_CONN_ENET1_RGMII_RXD2		0x00000040>,
+			   <IMX8QXP_ESAI0_TX1_CONN_ENET1_RGMII_RXD3		0x00000040>;
+	};
+
+	pinctrl_gpiobuttons: gpiobuttonsgrp {
+		fsl,pins = <IMX8QXP_ADC_IN5_LSIO_GPIO1_IO13	0x00000020>,
+			   <IMX8QXP_ADC_IN4_LSIO_GPIO1_IO14	0x00000020>;
+	};
+
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <IMX8QXP_MIPI_DSI1_GPIO0_00_ADMA_I2C2_SCL	0x06000021>,
+			   <IMX8QXP_MIPI_DSI1_GPIO0_01_ADMA_I2C2_SDA	0x06000021>;
+	};
+
+	pinctrl_lpi2c2gpio: lpi2c2gpiogrp {
+		fsl,pins = <IMX8QXP_MIPI_DSI1_GPIO0_00_LSIO_GPIO1_IO31	0x06000021>,
+			   <IMX8QXP_MIPI_DSI1_GPIO0_01_LSIO_GPIO2_IO00	0x06000021>;
+	};
+
+	pinctrl_lpuart1: lpuart1grp {
+		fsl,pins = <IMX8QXP_UART1_RX_ADMA_UART1_RX	0x06000020>,
+			   <IMX8QXP_UART1_TX_ADMA_UART1_TX	0x06000020>;
+	};
+
+	pinctrl_lpuart3: lpuart3grp {
+		fsl,pins = <IMX8QXP_FLEXCAN2_RX_ADMA_UART3_RX	0x06000020>,
+			   <IMX8QXP_FLEXCAN2_TX_ADMA_UART3_TX	0x06000020>;
+	};
+
+	pinctrl_lsgpio3: lsgpio3grp {
+		fsl,pins = <IMX8QXP_QSPI0A_SS1_B_LSIO_GPIO3_IO15	0x00000021>;
+	};
+
+	pinctrl_pca9538: pca9538grp {
+		fsl,pins = <IMX8QXP_USDHC1_RESET_B_LSIO_GPIO4_IO19	0x00000020>;
+	};
+
+	pinctrl_pcieb: pcieagrp{
+		fsl,pins = <IMX8QXP_PCIE_CTRL0_PERST_B_LSIO_GPIO4_IO00	0x06000041>,
+			   <IMX8QXP_PCIE_CTRL0_CLKREQ_B_LSIO_GPIO4_IO01	0x06000041>,
+			   <IMX8QXP_PCIE_CTRL0_WAKE_B_LSIO_GPIO4_IO02	0x04000041>;
+	};
+
+	pinctrl_reg_pcie_1v5: regpcie1v5grp {
+		fsl,pins = <IMX8QXP_SAI1_RXC_LSIO_GPIO0_IO30	0x00000021>;
+	};
+
+	pinctrl_reg_pcie_3v3: regpcie3v3grp {
+		fsl,pins = <IMX8QXP_SAI1_RXFS_LSIO_GPIO0_IO31	0x00000021>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <IMX8QXP_MCLK_OUT0_ADMA_ACM_MCLK_OUT0	0x06000041>,
+			   <IMX8QXP_FLEXCAN0_RX_ADMA_SAI1_TXC		0x06000041>,
+			   <IMX8QXP_FLEXCAN0_TX_ADMA_SAI1_TXFS		0x06000041>,
+			   <IMX8QXP_FLEXCAN1_RX_ADMA_SAI1_TXD		0x06000041>,
+			   <IMX8QXP_FLEXCAN1_TX_ADMA_SAI1_RXD		0x06000041>;
+	};
+
+	pinctrl_spi1: spi1grp {
+		fsl,pins = <IMX8QXP_SAI0_TXC_ADMA_SPI1_SDI	0x00000041>,
+			   <IMX8QXP_SAI0_TXD_ADMA_SPI1_SDO	0x00000041>,
+			   <IMX8QXP_SAI0_TXFS_ADMA_SPI1_SCK	0x00000041>,
+			   <IMX8QXP_SAI0_RXD_LSIO_GPIO0_IO27	0x00000021>,
+			   <IMX8QXP_SAI1_RXD_LSIO_GPIO0_IO29	0x00000021>;
+	};
+
+	pinctrl_spi2: spi2grp {
+		fsl,pins = <IMX8QXP_SPI2_SCK_ADMA_SPI2_SCK	0x00000041>,
+			   <IMX8QXP_SPI2_SDI_ADMA_SPI2_SDI	0x00000041>,
+			   <IMX8QXP_SPI2_SDO_ADMA_SPI2_SDO	0x00000041>,
+			   <IMX8QXP_SPI2_CS0_LSIO_GPIO1_IO00	0x00000021>;
+	};
+
+	pinctrl_spi3: spi3grp {
+		fsl,pins = <IMX8QXP_SPI3_SCK_ADMA_SPI3_SCK	0x00000041>,
+			   <IMX8QXP_SPI3_SDI_ADMA_SPI3_SDI	0x00000041>,
+			   <IMX8QXP_SPI3_SDO_ADMA_SPI3_SDO	0x00000041>,
+			   <IMX8QXP_SPI3_CS0_LSIO_GPIO0_IO16	0x00000021>,
+			   <IMX8QXP_SPI3_CS1_ADMA_SPI3_CS1	0x00000021>;
+	};
+
+	pinctrl_usbotg1: usbotg1grp {
+		fsl,pins = <IMX8QXP_USB_SS3_TC0_CONN_USB_OTG1_PWR	0x00000021>,
+			   <IMX8QXP_USB_SS3_TC2_CONN_USB_OTG1_OC	0x00000021>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <IMX8QXP_USDHC1_WP_LSIO_GPIO4_IO21		0x00000021>,
+			   <IMX8QXP_USDHC1_CD_B_LSIO_GPIO4_IO22		0x00000021>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <IMX8QXP_USDHC1_CLK_CONN_USDHC1_CLK		0x06000041>,
+			   <IMX8QXP_USDHC1_CMD_CONN_USDHC1_CMD		0x00000021>,
+			   <IMX8QXP_USDHC1_DATA0_CONN_USDHC1_DATA0	0x00000021>,
+			   <IMX8QXP_USDHC1_DATA1_CONN_USDHC1_DATA1	0x00000021>,
+			   <IMX8QXP_USDHC1_DATA2_CONN_USDHC1_DATA2	0x00000021>,
+			   <IMX8QXP_USDHC1_DATA3_CONN_USDHC1_DATA3	0x00000021>,
+			   <IMX8QXP_USDHC1_VSELECT_CONN_USDHC1_VSELECT	0x00000021>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <IMX8QXP_USDHC1_CLK_CONN_USDHC1_CLK		0x06000040>,
+			   <IMX8QXP_USDHC1_CMD_CONN_USDHC1_CMD		0x00000020>,
+			   <IMX8QXP_USDHC1_DATA0_CONN_USDHC1_DATA0	0x00000020>,
+			   <IMX8QXP_USDHC1_DATA1_CONN_USDHC1_DATA1	0x00000020>,
+			   <IMX8QXP_USDHC1_DATA2_CONN_USDHC1_DATA2	0x00000020>,
+			   <IMX8QXP_USDHC1_DATA3_CONN_USDHC1_DATA3	0x00000020>,
+			   <IMX8QXP_USDHC1_VSELECT_CONN_USDHC1_VSELECT	0x00000020>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <IMX8QXP_USDHC1_CLK_CONN_USDHC1_CLK		0x06000040>,
+			   <IMX8QXP_USDHC1_CMD_CONN_USDHC1_CMD		0x00000020>,
+			   <IMX8QXP_USDHC1_DATA0_CONN_USDHC1_DATA0	0x00000020>,
+			   <IMX8QXP_USDHC1_DATA1_CONN_USDHC1_DATA1	0x00000020>,
+			   <IMX8QXP_USDHC1_DATA2_CONN_USDHC1_DATA2	0x00000020>,
+			   <IMX8QXP_USDHC1_DATA3_CONN_USDHC1_DATA3	0x00000020>,
+			   <IMX8QXP_USDHC1_VSELECT_CONN_USDHC1_VSELECT	0x00000020>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/tqma8xx.dtsi b/arch/arm64/boot/dts/freescale/tqma8xx.dtsi
new file mode 100644
index 0000000000000..d98469a7c47cc
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/tqma8xx.dtsi
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR X11)
+/*
+ * Copyright 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Alexander Stein
+ */
+
+/ {
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0 0x40000000>;
+	};
+
+	reg_1v8: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "V_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "V_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * global autoconfigured region for contiguous allocations
+		 * must not exceed memory size and region
+		 */
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0 0x20000000>;
+			alloc-ranges = <0 0x96000000 0 0x30000000>;
+			linux,cma-default;
+		};
+	};
+};
+
+/* TQMa8Xx only uses industrial grade, reduce trip points accordingly */
+&cpu_alert0 {
+	temperature = <95000>;
+};
+
+&cpu_crit0 {
+	temperature = <100000>;
+};
+/* end of temperature grade adjustments */
+
+&flexspi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi0>;
+	status = "okay";
+
+	flash0: flash@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <66000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+/* TODO GPU */
+
+&i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c1>;
+	pinctrl-1 = <&pinctrl_lpi2c1gpio>;
+	scl-gpios = <&lsio_gpio1 27 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&lsio_gpio1 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	se97: temperature-sensor@1b {
+		compatible = "nxp,se97b", "jedec,jc-42.4-temp";
+		reg = <0x1b>;
+	};
+
+	pcf85063: rtc@51 {
+		compatible = "nxp,pcf85063a";
+		reg = <0x51>;
+		quartz-load-femtofarads = <7000>;
+	};
+
+	at24c02: eeprom@53 {
+		compatible = "nxp,se97b", "atmel,24c02";
+		reg = <0x53>;
+		pagesize = <16>;
+		read-only;
+		vcc-supply = <&reg_3v3>;
+	};
+
+	m24c64: eeprom@57 {
+		compatible = "atmel,24c64";
+		reg = <0x57>;
+		pagesize = <32>;
+		vcc-supply = <&reg_3v3>;
+	};
+};
+
+&mu_m0 {
+	status = "okay";
+};
+
+&mu1_m0 {
+	status = "okay";
+};
+
+&thermal_zones {
+	pmic_thermal: pmic-thermal {
+		polling-delay-passive = <250>;
+		polling-delay = <2000>;
+		thermal-sensors = <&tsens IMX_SC_R_PMIC_0>;
+
+		trips {
+			pmic_alert0: trip0 {
+				temperature = <110000>;
+				hysteresis = <2000>;
+				type = "passive";
+			};
+
+			pmic_crit0: trip1 {
+				temperature = <125000>;
+				hysteresis = <2000>;
+				type = "critical";
+			};
+		};
+
+		cooling-maps {
+			map0 {
+				trip = <&pmic_alert0>;
+				cooling-device =
+					<&A35_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&A35_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&A35_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&A35_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+		};
+	};
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	vqmmc-supply = <&reg_1v8>;
+	vmmc-supply = <&reg_3v3>;
+	bus-width = <8>;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&vpu {
+	compatible = "nxp,imx8qxp-vpu";
+	status = "okay";
+};
+
+&vpu_core0 {
+	memory-region = <&decoder_boot>, <&decoder_rpc>;
+	status = "okay";
+};
+
+&vpu_core1 {
+	memory-region = <&encoder_boot>, <&encoder_rpc>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_flexspi0: flexspi0grp {
+		fsl,pins = <
+			IMX8QXP_QSPI0A_DATA0_LSIO_QSPI0A_DATA0	0x0600004d
+			IMX8QXP_QSPI0A_DATA1_LSIO_QSPI0A_DATA1	0x0600004d
+			IMX8QXP_QSPI0A_DATA2_LSIO_QSPI0A_DATA2	0x0600004d
+			IMX8QXP_QSPI0A_DATA3_LSIO_QSPI0A_DATA3	0x0600004d
+			IMX8QXP_QSPI0A_DQS_LSIO_QSPI0A_DQS	0x0600004d
+			IMX8QXP_QSPI0A_SS0_B_LSIO_QSPI0A_SS0_B	0x0600004d
+			IMX8QXP_QSPI0A_SCLK_LSIO_QSPI0A_SCLK	0x0600004d
+			IMX8QXP_QSPI0B_SCLK_LSIO_QSPI0B_SCLK	0x0600004d
+			IMX8QXP_QSPI0B_DATA0_LSIO_QSPI0B_DATA0	0x0600004d
+			IMX8QXP_QSPI0B_DATA1_LSIO_QSPI0B_DATA1	0x0600004d
+			IMX8QXP_QSPI0B_DATA2_LSIO_QSPI0B_DATA2	0x0600004d
+			IMX8QXP_QSPI0B_DATA3_LSIO_QSPI0B_DATA3	0x0600004d
+			IMX8QXP_QSPI0B_DQS_LSIO_QSPI0B_DQS	0x0600004d
+			IMX8QXP_QSPI0B_SS0_B_LSIO_QSPI0B_SS0_B	0x0600004d
+			IMX8QXP_QSPI0B_SS1_B_LSIO_QSPI0B_SS1_B	0x0600004d
+		>;
+	};
+
+	pinctrl_lpi2c1: lpi2c1grp {
+		fsl,pins = <
+			IMX8QXP_MIPI_DSI0_GPIO0_00_ADMA_I2C1_SCL	0x06000021
+			IMX8QXP_MIPI_DSI0_GPIO0_01_ADMA_I2C1_SDA	0x06000021
+		>;
+	};
+
+	pinctrl_lpi2c1gpio: lpi2c1gpiogrp {
+		fsl,pins = <
+			IMX8QXP_MIPI_DSI0_GPIO0_00_LSIO_GPIO1_IO27	0x06000021
+			IMX8QXP_MIPI_DSI0_GPIO0_01_LSIO_GPIO1_IO28	0x06000021
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			IMX8QXP_EMMC0_CLK_CONN_EMMC0_CLK	0x06000041
+			IMX8QXP_EMMC0_CMD_CONN_EMMC0_CMD	0x00000021
+			IMX8QXP_EMMC0_DATA0_CONN_EMMC0_DATA0	0x00000021
+			IMX8QXP_EMMC0_DATA1_CONN_EMMC0_DATA1	0x00000021
+			IMX8QXP_EMMC0_DATA2_CONN_EMMC0_DATA2	0x00000021
+			IMX8QXP_EMMC0_DATA3_CONN_EMMC0_DATA3	0x00000021
+			IMX8QXP_EMMC0_DATA4_CONN_EMMC0_DATA4	0x00000021
+			IMX8QXP_EMMC0_DATA5_CONN_EMMC0_DATA5	0x00000021
+			IMX8QXP_EMMC0_DATA6_CONN_EMMC0_DATA6	0x00000021
+			IMX8QXP_EMMC0_DATA7_CONN_EMMC0_DATA7	0x00000021
+			IMX8QXP_EMMC0_STROBE_CONN_EMMC0_STROBE	0x00000041
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			IMX8QXP_EMMC0_CLK_CONN_EMMC0_CLK	0x06000040
+			IMX8QXP_EMMC0_CMD_CONN_EMMC0_CMD	0x00000020
+			IMX8QXP_EMMC0_DATA0_CONN_EMMC0_DATA0	0x00000020
+			IMX8QXP_EMMC0_DATA1_CONN_EMMC0_DATA1	0x00000020
+			IMX8QXP_EMMC0_DATA2_CONN_EMMC0_DATA2	0x00000020
+			IMX8QXP_EMMC0_DATA3_CONN_EMMC0_DATA3	0x00000020
+			IMX8QXP_EMMC0_DATA4_CONN_EMMC0_DATA4	0x00000020
+			IMX8QXP_EMMC0_DATA5_CONN_EMMC0_DATA5	0x00000020
+			IMX8QXP_EMMC0_DATA6_CONN_EMMC0_DATA6	0x00000020
+			IMX8QXP_EMMC0_DATA7_CONN_EMMC0_DATA7	0x00000020
+			IMX8QXP_EMMC0_STROBE_CONN_EMMC0_STROBE	0x00000040
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			IMX8QXP_EMMC0_CLK_CONN_EMMC0_CLK	0x06000040
+			IMX8QXP_EMMC0_CMD_CONN_EMMC0_CMD	0x00000020
+			IMX8QXP_EMMC0_DATA0_CONN_EMMC0_DATA0	0x00000020
+			IMX8QXP_EMMC0_DATA1_CONN_EMMC0_DATA1	0x00000020
+			IMX8QXP_EMMC0_DATA2_CONN_EMMC0_DATA2	0x00000020
+			IMX8QXP_EMMC0_DATA3_CONN_EMMC0_DATA3	0x00000020
+			IMX8QXP_EMMC0_DATA4_CONN_EMMC0_DATA4	0x00000020
+			IMX8QXP_EMMC0_DATA5_CONN_EMMC0_DATA5	0x00000020
+			IMX8QXP_EMMC0_DATA6_CONN_EMMC0_DATA6	0x00000020
+			IMX8QXP_EMMC0_DATA7_CONN_EMMC0_DATA7	0x00000020
+			IMX8QXP_EMMC0_STROBE_CONN_EMMC0_STROBE	0x00000040
+		>;
+	};
+};
-- 
2.34.1

