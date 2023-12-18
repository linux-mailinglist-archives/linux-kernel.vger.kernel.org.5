Return-Path: <linux-kernel+bounces-4073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B9F81779E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D4D284840
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823115A84B;
	Mon, 18 Dec 2023 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="ZZh6KIz5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D1342395
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2023121816360381fdf600070586cac1
        for <linux-kernel@vger.kernel.org>;
        Mon, 18 Dec 2023 17:36:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=QEPvUtK31LV+jAo+kM2ZtbylOl+eGbzSdGqDVd1scUE=;
 b=ZZh6KIz5YaO8hQ1W6cDsYbO2yFxZePwfvxJ32mcKHVTyvTu+znOkxCrj28n0fxyrTUgwsd
 0tbltDUCA00PMz/QiFuOTtksSk0nTPbyGXwBkQ+f+Oy3rq26MZFtvas0Jr3b58WmwoYEl/Dd
 CdyiPhVcspBvpRP2q8k0fqqaHjo+I=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Chao Zeng <chao.zeng@siemens.com>,
	Li Hua Qian <huaqian.li@siemens.com>
Subject: [PATCH 4/4] dts: iot2050: Support IOT2050-SM variant
Date: Mon, 18 Dec 2023 17:36:00 +0100
Message-Id: <11e0b0c8b828254567a8ff89820c067cacad2150.1702917360.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1702917360.git.jan.kiszka@siemens.com>
References: <cover.1702917360.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Baocheng Su <baocheng.su@siemens.com>

Main differences between the new variant and Advanced PG2:

1. Arduino interface is removed. Instead, an new ASIC is added for
   communicating with PLC 1200 signal modules.
2. USB 3.0 type A connector is removed, only USB 2.0 type A connector is
   avaiable.
3. DP interface is tailored down. Instead, to communicate with the
   PLC 1200 signal modules, a USB 3.0 type B connector is added but the
   signal is not USB.
4. DDR size is increased to 4 GB.
5. Two sensors are added, one tilt sensor and one light sensor.

The light sensor it not yet added to the DT at this stage as it depends
on to-be-added bindings.

Co-developed-by: Chao Zeng <chao.zeng@siemens.com>
Signed-off-by: Chao Zeng <chao.zeng@siemens.com>
Co-developed-by: Li Hua Qian <huaqian.li@siemens.com>
Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
[Jan: rebase over arduino refactoring, split-out light sensor]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/boot/dts/ti/Makefile               |   1 +
 .../dts/ti/k3-am6548-iot2050-advanced-sm.dts  | 210 ++++++++++++++++++
 2 files changed, 211 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 77a347f9f47d..9b15eaad284c 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -53,6 +53,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-pg2.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-sm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-gp-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-evm.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts
new file mode 100644
index 000000000000..ab3eef683890
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Siemens AG, 2023
+ *
+ * Authors:
+ *   Baocheng Su <baocheng.su@siemens.com>
+ *   Chao Zeng <chao.zeng@siemens.com>
+ *   Huaqian Li <huaqian.li@siemens.com>
+ *
+ * AM6548-based (quad-core) IOT2050 SM variant, Product Generation 2
+ * 4 GB RAM, 16 GB eMMC, USB-serial converter on connector X30
+ *
+ * Product homepage:
+ * https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html
+ */
+
+/dts-v1/;
+
+#include "k3-am6548-iot2050-advanced-common.dtsi"
+#include "k3-am65-iot2050-common-pg2.dtsi"
+
+/ {
+	compatible = "siemens,iot2050-advanced-sm", "ti,am654";
+	model = "SIMATIC IOT2050 Advanced SM";
+
+	memory@80000000 {
+		device_type = "memory";
+		/* 4G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000000 0x80000000>;
+	};
+
+	aliases {
+		spi1 = &main_spi0;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&leds_pins_default>, <&user1_led_pins>;
+
+		user-led1-red {
+			gpios = <&wkup_gpio0 52 GPIO_ACTIVE_HIGH>;
+		};
+
+		user-led1-green {
+			gpios = <&wkup_gpio0 53 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&main_pmx0 {
+	main_pcie_enable_pins_default: main-pcie-enable-default-pins {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x01d8, PIN_OUTPUT, 7)  /* (AH12) GPIO1_22 */
+		>;
+	};
+
+	main_spi0_pins: main-spi0-default-pins  {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x01c4, PIN_INPUT, 0) /* (AH13) SPI0_CLK */
+			AM65X_IOPAD(0x01c8, PIN_INPUT, 0) /* (AE13) SPI0_D0 */
+			AM65X_IOPAD(0x01cc, PIN_INPUT, 0) /* (AD13) SPI0_D1 */
+			AM65X_IOPAD(0x01bc, PIN_OUTPUT, 0) /* (AG13) SPI0_CS0 */
+		>;
+	};
+};
+
+&main_pmx1 {
+	asic_spi_mux_ctrl_pin: asic-spi-mux-ctrl-default-pins {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x0010, PIN_OUTPUT, 7)  /* (D21) GPIO1_86 */
+		>;
+	};
+};
+
+&wkup_pmx0 {
+	user1_led_pins: user1-led-default-pins {
+		pinctrl-single,pins = <
+			/* (AB1) WKUP_UART0_RXD:WKUP_GPIO0_52, as USER 1 led red */
+			AM65X_WKUP_IOPAD(0x00a0, PIN_OUTPUT, 7)
+			/* (AB5) WKUP_UART0_TXD:WKUP_GPIO0_53, as USER 1 led green */
+			AM65X_WKUP_IOPAD(0x00a4, PIN_OUTPUT, 7)
+		>;
+	};
+
+	soc_asic_pins: soc-asic-default-pins {
+		pinctrl-single,pins = <
+			AM65X_WKUP_IOPAD(0x0044, PIN_INPUT, 7)  /* (P4) WKUP_GPIO0_29 */
+			AM65X_WKUP_IOPAD(0x0048, PIN_INPUT, 7)  /* (P5) WKUP_GPIO0_30 */
+			AM65X_WKUP_IOPAD(0x004c, PIN_INPUT, 7)  /* (P1) WKUP_GPIO0_31 */
+		>;
+	};
+};
+
+&main_gpio0 {
+	gpio-line-names = "main_gpio0-base";
+};
+
+&main_gpio1 {
+	pinctrl-names = "default";
+	pinctrl-0 =
+		<&cp2102n_reset_pin_default>,
+		<&main_pcie_enable_pins_default>,
+		<&asic_spi_mux_ctrl_pin>;
+	gpio-line-names =
+		/* 0..9 */
+		"", "", "", "", "", "", "", "", "", "",
+		/* 10..19 */
+		"", "", "", "", "", "", "", "", "", "",
+		/* 20..29 */
+		"", "", "", "", "CP2102N-RESET", "", "", "", "", "",
+		/* 30..39 */
+		"", "", "", "", "", "", "", "", "", "",
+		/* 40..49 */
+		"", "", "", "", "", "", "", "", "", "",
+		/* 50..59 */
+		"", "", "", "", "", "", "", "", "", "",
+		/* 60..69 */
+		"", "", "", "", "", "", "", "", "", "",
+		/* 70..79 */
+		"", "", "", "", "", "", "", "", "", "",
+		/* 80..86 */
+		"", "", "", "", "", "", "ASIC-spi-mux-ctrl";
+};
+
+&wkup_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 =
+		<&push_button_pins_default>,
+		<&db9_com_mode_pins_default>,
+		<&soc_asic_pins>;
+	gpio-line-names =
+		/* 0..9 */
+		"wkup_gpio0-base", "", "", "", "UART0-mode1", "UART0-mode0",
+		"UART0-enable", "UART0-terminate", "", "WIFI-disable",
+		/* 10..19 */
+		"", "", "", "", "", "", "", "", "", "",
+		/* 20..29 */
+		"", "", "", "", "", "USER-button", "", "", "","ASIC-gpio-0",
+		/* 30..31 */
+		"ASIC-gpio-1", "ASIC-gpio-2";
+};
+
+&main_spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_spi0_pins>;
+
+	#address-cells = <1>;
+	#size-cells= <0>;
+};
+
+&mcu_spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_spi0_pins_default>;
+};
+
+&main_i2c3 {
+	accelerometer: lsm6dso@6a {
+		compatible = "st,lsm6dso";
+		reg = <0x6a>;
+	};
+
+	/delete-node/ edp-bridge@f;
+};
+
+&dss {
+	status = "disabled";
+};
+
+&dss_ports {
+	/delete-node/ port@1;
+};
+
+&serdes0 {
+	assigned-clocks = <&k3_clks 153 4>, <&serdes0 AM654_SERDES_CMU_REFCLK>;
+	assigned-clock-parents = <&k3_clks 153 8>, <&k3_clks 153 4>;
+};
+
+&serdes1 {
+	status = "disabled";
+};
+
+&pcie0_rc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&minipcie_pins_default>;
+
+	num-lanes = <1>;
+	phys = <&serdes0 PHY_TYPE_PCIE 1>;
+	phy-names = "pcie-phy0";
+	reset-gpios = <&wkup_gpio0 27 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&pcie1_rc {
+	status = "disabled";
+};
+
+&dwc3_0 {
+	assigned-clock-parents = <&k3_clks 151 4>,  /* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
+				 <&k3_clks 151 9>;  /* set PIPE3_TXB_CLK to CLK_12M_RC/256 (for HS only) */
+	/delete-property/ phys;
+	/delete-property/ phy-names;
+};
+
+&usb0 {
+	maximum-speed = "high-speed";
+	/delete-property/ snps,dis-u1-entry-quirk;
+	/delete-property/ snps,dis-u2-entry-quirk;
+};
-- 
2.35.3


