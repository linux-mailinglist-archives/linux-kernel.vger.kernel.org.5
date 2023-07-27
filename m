Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30457654D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjG0NVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjG0NVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:21:43 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CE42D59;
        Thu, 27 Jul 2023 06:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1690464093; x=1722000093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pEsBEOfEwbC1uG/HrNcMjcNqZ6/Mqo4yANj5O8GcN0M=;
  b=mHATA+n711qHFCoHVBjS9Rk775O3C0R/zo2hlFHcCVhgQTGX3ZcUwKzV
   k/j5z9PJWJyN8VoII2UaEzKQw4SGqqQ8T5O8Wsl8Viyvvpr+Hpli6BWXE
   DMCw1Lpp44X7UT/jJ1oCfHTIBLMg+HC8kTPa26HpLjeL9L2DklLNGC426
   pH1J5utEWDhVTexiXbt16NHkQ/zXTAxVY2FXo1dzqfaEDxEEQqIgU0H7B
   91TyUQEtK5wgTsx4idlIRJ2M+PEouHcTUKW4qDhaW1Scno+zm0YbFgIDu
   ZD/8oVigxqZi/nO9L/dwjd3EkM4KMd6Z2uGnyfzCAhyf1zFbEC6yFKUyY
   w==;
X-IronPort-AV: E=Sophos;i="6.01,234,1684792800"; 
   d="scan'208";a="32156710"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 27 Jul 2023 15:21:28 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.20])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 56FB9280084;
        Thu, 27 Jul 2023 15:21:28 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v3 2/3] arm64: dts: ti: Add TQ-Systems TQMa64XxL SoM and MBaX4XxL carrier board Device Trees
Date:   Thu, 27 Jul 2023 15:21:19 +0200
Message-Id: <2a635428c73b5ab0fe793e558db6b5d88edccf8c.1690463382.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e4283d6af59c77d2f690e070eb948dd9142a2276.1690463382.git.matthias.schiffer@ew.tq-group.com>
References: <e4283d6af59c77d2f690e070eb948dd9142a2276.1690463382.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TQMa64XxL is an LGA SoM based on the TI AM64x SoC family. Add DTS(I)
for the AM642 (2x Cortex-A53) variant and its combination with our
MBaX4XxL carrier board.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v3: update pinmux node names as suggested by Nishanth Menon
v2: no changes

 arch/arm64/boot/dts/ti/Makefile               |   1 +
 .../dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts    | 870 ++++++++++++++++++
 .../arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi | 252 +++++
 3 files changed, 1123 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 3b4d49390b878..77f553f014cc8 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -28,6 +28,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
 
 # Boards with AM65x SoC
 k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb k3-am654-base-board-rocktech-rk101-panel.dtbo
diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
new file mode 100644
index 0000000000000..9105bb6881451
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
@@ -0,0 +1,870 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (c) 2022-2023 TQ-Systems GmbH <linux@ew.tq-group.com>, D-82229 Seefeld, Germany.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/mux/ti-serdes.h>
+#include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/pwm/pwm.h>
+#include "k3-am642-tqma64xxl.dtsi"
+
+/ {
+	compatible = "tq,am642-tqma6442l-mbax4xxl", "tq,am642-tqma6442l",
+		     "ti,am642";
+	model = "TQ-Systems TQMa64xxL SoM on MBax4xxL carrier board";
+
+	aliases {
+		ethernet0 = &cpsw_port1;
+		i2c1 = &mcu_i2c0;
+		mmc1 = &sdhci1;
+		serial0 = &mcu_uart0;
+		serial1 = &mcu_uart1;
+		serial2 = &main_uart0;
+		serial3 = &main_uart1;
+		serial4 = &main_uart2;
+		serial5 = &main_uart4;
+		serial6 = &main_uart5;
+		serial7 = &main_uart3;
+		spi1 = &main_spi0;
+		spi2 = &mcu_spi0;
+	};
+
+	chosen {
+		stdout-path = &main_uart0;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcu_gpio_keys_pins>;
+
+		user-button {
+			label = "USER_BUTTON";
+			linux,code = <BTN_0>;
+			gpios = <&mcu_gpio0 5 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcu_gpio_leds_pins>;
+
+		led-0 {
+			label = "led0";
+			gpios = <&mcu_gpio0 8 GPIO_ACTIVE_HIGH>;
+		};
+		led-1 {
+			label = "led1";
+			gpios = <&mcu_gpio0 9 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	fan0: pwm-fan {
+		compatible = "pwm-fan";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm_fan_pins>;
+		fan-supply = <&reg_pwm_fan>;
+		#cooling-cells = <2>;
+		/* typical 25 kHz -> 40.000 nsec */
+		pwms = <&epwm5 0 40000 PWM_POLARITY_INVERTED>;
+		cooling-levels = <0 32 64 128 196 240>;
+		pulses-per-revolution = <2>;
+		interrupt-parent = <&main_gpio1>;
+		interrupts = <49 IRQ_TYPE_EDGE_FALLING>;
+		status = "disabled";
+	};
+
+	wifi_pwrseq: pwrseq-wifi {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&main_mmc1_wifi_pwrseq_pins>;
+		reset-gpios = <&main_gpio0 23 GPIO_ACTIVE_LOW>;
+	};
+
+	reg_pwm_fan: regulator-pwm-fan {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm_fan_reg_pins>;
+		regulator-name = "FAN_PWR";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		gpio = <&main_gpio1 48 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_sd: regulator-sd {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&main_mmc1_reg_pins>;
+		regulator-name = "V_3V3_SD";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&main_gpio1 43 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&cpsw3g {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cpsw_pins>;
+};
+
+&cpsw_port1 {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&cpsw3g_phy0>;
+};
+
+&cpsw_port2 {
+	status = "disabled";
+};
+
+&cpsw3g_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cpsw_mdio_pins>;
+	status = "okay";
+
+	cpsw3g_phy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+		reset-gpios = <&main_gpio0 44 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <1000>;
+		reset-deassert-us = <1000>;
+		ti,rx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,tx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+	};
+};
+
+&epwm5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&epwm5_pins>;
+	status = "okay";
+};
+
+&main_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_gpio0_digital_pins>,
+		    <&main_gpio0_hog_pins>;
+	gpio-line-names =
+		"", "", "", "", /* 0-3 */
+		"", "", "", "", /* 4-7 */
+		"", "", "", "", /* 8-11 */
+		"", "", "", "", /* 12-15 */
+		"", "", "", "", /* 16-19 */
+		"", "", "", "", /* 20-23 */
+		"", "", "EN_DIG_OUT_1", "STATUS_OUT_1", /* 24-27 */
+		"EN_DIG_OUT_2", "STATUS_OUT_2", "EN_SIG_OUT_3", "", /* 28-31 */
+		"", "", "STATUS_OUT_3", "EN_DIG_OUT_4", /* 32-35 */
+		"", "", "STATUS_OUT_4", "DIG_IN_1", /* 36-39 */
+		"DIG_IN_2", "DIG_IN_3", "DIG_IN_4"; /* 40- */
+};
+
+&main_gpio1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_gpio1_hog_pins>;
+	gpio-line-names =
+		"", "", "", "", /* 0-3 */
+		"", "", "", "", /* 4-7 */
+		"", "", "", "", /* 8-11 */
+		"", "", "", "", /* 12-15 */
+		"", "", "", "", /* 16-19 */
+		"", "", "", "", /* 20-23 */
+		"", "", "", "", /* 24-27 */
+		"", "", "", "", /* 28-31 */
+		"", "", "", "", /* 32-35 */
+		"", "", "", "", /* 36-39 */
+		"", "", "", "", /* 40-43 */
+		"", "", "", "", /* 44-47 */
+		"", "", "", "", /* 48-51 */
+		"", "", "", "ADC_SYNC", /* 52-55 */
+		"", "", "ADC_RST#", "ADC_DATA_RDY", /* 56-59 */
+		"", "", "", "", /* 60-63 */
+		"", "", "", "ADC_INT#", /* 64-67 */
+		"BG95_PWRKEY", "BG95_RESET"; /* 68- */
+
+	line50-hog {
+		/* See also usb0 */
+		gpio-hog;
+		gpios = <50 0>;
+		line-name = "USB0_VBUS_OC#";
+		input;
+	};
+
+	line54-hog {
+		gpio-hog;
+		gpios = <54 0>;
+		line-name = "PRG0_MDIO_SWITCH";
+		output-low;
+	};
+
+	line70-hog {
+		gpio-hog;
+		gpios = <70 0>;
+		line-name = "PHY_INT#";
+		input;
+	};
+};
+
+&main_mcan0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan0_pins>;
+	status = "okay";
+};
+
+&main_mcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan1_pins>;
+	status = "okay";
+};
+
+&main_spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_spi0_pins>;
+	ti,pindir-d0-out-d1-in;
+	status = "okay";
+
+	/* adc@0: NXP NAFE13388 */
+};
+
+/* UART/USB adapter port 1 */
+&main_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins>;
+	status = "okay";
+};
+
+/*
+ * IOT Module - GNSS UART
+ *
+ * Note: We expect usage of a SYSFW that does not reserve UART1 for debug traces
+ */
+&main_uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart1_pins>;
+	status = "okay";
+};
+
+/* RS485 port */
+&main_uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart2_pins>;
+	linux,rs485-enabled-at-boot-time;
+	rs485-rts-active-low;
+	status = "okay";
+};
+
+/* Bluetooth module */
+&main_uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart3_pins>;
+	/*
+	 * Left disabled for now, until a way to deal with drivers and firmware
+	 * for the combined WLAN/BT module has been figured out
+	 */
+};
+
+/* IOT module - Main UART */
+&main_uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart4_pins>;
+	status = "okay";
+};
+
+/* IOT module - DBG UART */
+&main_uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart5_pins>;
+	status = "okay";
+};
+
+&main0_thermal {
+	trips {
+		main0_active0: trip-active0 {
+			temperature = <40000>;
+			hysteresis = <5000>;
+			type = "active";
+		};
+
+		main0_active1: trip-active1 {
+			temperature = <48000>;
+			hysteresis = <3000>;
+			type = "active";
+		};
+
+		main0_active2: trip-active2 {
+			temperature = <60000>;
+			hysteresis = <10000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map1 {
+			trip = <&main0_active0>;
+			cooling-device = <&fan0 1 1>;
+		};
+
+		map2 {
+			trip = <&main0_active1>;
+			cooling-device = <&fan0 2 2>;
+		};
+
+		map3 {
+			trip = <&main0_active2>;
+			cooling-device = <&fan0 3 3>;
+		};
+	};
+};
+
+&main1_thermal {
+	trips {
+		main1_active0: trip-active0 {
+			temperature = <40000>;
+			hysteresis = <5000>;
+			type = "active";
+		};
+
+		main1_active1: trip-active1 {
+			temperature = <48000>;
+			hysteresis = <3000>;
+			type = "active";
+		};
+
+		main1_active2: trip-active2 {
+			temperature = <60000>;
+			hysteresis = <10000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map1 {
+			trip = <&main1_active0>;
+			cooling-device = <&fan0 1 1>;
+		};
+
+		map2 {
+			trip = <&main1_active1>;
+			cooling-device = <&fan0 2 2>;
+		};
+
+		map3 {
+			trip = <&main1_active2>;
+			cooling-device = <&fan0 3 3>;
+		};
+	};
+};
+
+&mcu_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_gpio0_pins>;
+};
+
+&mcu_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_i2c0_pins>;
+	/* Left disabled: not functional without external pullup */
+};
+
+&mcu_spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_spi0_pins>;
+	ti,pindir-d0-out-d1-in;
+	status = "okay";
+};
+
+/* UART/USB adapter port 2 */
+&mcu_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_uart0_pins>;
+	status = "okay";
+};
+
+/* Pin header */
+&mcu_uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_uart1_pins>;
+	status = "okay";
+};
+
+&serdes_ln_ctrl {
+	idle-states = <AM64_SERDES0_LANE0_USB>;
+};
+
+&serdes0 {
+	serdes0_usb_link: phy@0 {
+		reg = <0>;
+		#phy-cells = <0>;
+		resets = <&serdes_wiz0 1>;
+		cdns,num-lanes = <1>;
+		cdns,phy-type = <PHY_TYPE_USB3>;
+	};
+};
+
+&sdhci1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc1_pins>;
+	bus-width = <4>;
+	cd-gpios = <&main_gpio1 77 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	no-mmc;
+	ti,driver-strength-ohm = <50>;
+	ti,fails-without-test-cd;
+	/* Enabled by overlay */
+	status = "disabled";
+};
+
+&tscadc0 {
+	adc {
+		ti,adc-channels = <0 1 2 3 4 5 6 7>;
+	};
+};
+
+&usb0 {
+	/*
+	 * The CDNS USB driver currently doesn't support overcurrent GPIOs,
+	 * so there is no overcurrent detection. The OC pin is configured
+	 * as a GPIO hog instead.
+	 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_usb0_pins>;
+	dr_mode = "otg";
+	maximum-speed = "super-speed";
+	phys = <&serdes0_usb_link>;
+	phy-names = "cdns3,usb3-phy";
+};
+
+&usbss0 {
+	ti,vbus-divider;
+};
+
+&main_pmx0 {
+	cpsw_pins: cpsw-pins {
+		pinctrl-single,pins = <
+			/* (W5) PRG0_PRU1_GPO7.RGMII1_RD0 */
+			AM64X_IOPAD(0x01cc, PIN_INPUT, 4)
+			/* (Y5) PRG0_PRU1_GPO9.RGMII1_RD1 */
+			AM64X_IOPAD(0x01d4, PIN_INPUT, 4)
+			/* (V6) PRG0_PRU1_GPO10.RGMII1_RD2 */
+			AM64X_IOPAD(0x01d8, PIN_INPUT, 4)
+			/* (V5) PRG0_PRU1_GPO17.RGMII1_RD3 */
+			AM64X_IOPAD(0x01f4, PIN_INPUT, 4)
+			/* (AA5) PRG0_PRU0_GPO10.RGMII1_RXC */
+			AM64X_IOPAD(0x0188, PIN_INPUT, 4)
+			/* (W6) PRG0_PRU0_GPO9.RGMII1_RX_CTL */
+			AM64X_IOPAD(0x0184, PIN_INPUT, 4)
+			/* (V15) PRG1_PRU1_GPO7.RGMII1_TD0 */
+			AM64X_IOPAD(0x0124, PIN_OUTPUT, 4)
+			/* (V14) PRG1_PRU1_GPO9.RGMII1_TD1 */
+			AM64X_IOPAD(0x012c, PIN_OUTPUT, 4)
+			/* (W14) PRG1_PRU1_GPO10.RGMII1_TD2 */
+			AM64X_IOPAD(0x0130, PIN_OUTPUT, 4)
+			/* (AA14) PRG1_PRU1_GPO17.RGMII1_TD3 */
+			AM64X_IOPAD(0x014c, PIN_OUTPUT, 4)
+			/* (U14) PRG1_PRU0_GPO10.RGMII1_TXC */
+			AM64X_IOPAD(0x00e0, PIN_OUTPUT, 4)
+			/* (U15) PRG1_PRU0_GPO9.RGMII1_TX_CTL */
+			AM64X_IOPAD(0x00dc, PIN_OUTPUT, 4)
+		>;
+	};
+
+	cpsw_mdio_pins: cpsw-mdio-pins {
+		pinctrl-single,pins = <
+			/* (R21) GPMC0_CSn3.GPIO0_44 - RESET_RGMII1# */
+			AM64X_IOPAD(0x00b4, PIN_OUTPUT, 7)
+
+			/* (R2) PRG0_PRU1_GPO19.MDIO0_MDC */
+			AM64X_IOPAD(0x01fc, PIN_OUTPUT, 4)
+			/* (P5) PRG0_PRU1_GPO18.MDIO0_MDIO */
+			AM64X_IOPAD(0x01f8, PIN_INPUT, 4)
+		>;
+	};
+
+	epwm5_pins: epwm5-pins {
+		pinctrl-single,pins = <
+			/* (W19) GPMC0_WAIT0.EHRPWM5_B */
+			AM64X_IOPAD(0x0098, PIN_OUTPUT, 3)
+		>;
+	};
+
+	/* Digital IOs */
+	main_gpio0_digital_pins: main-gpio0-digital-pins {
+		pinctrl-single,pins = <
+			/* (W20) GPMC0_AD11.GPIO0_26 - EN_DIG_OUT_1 */
+			AM64X_IOPAD(0x0068, PIN_OUTPUT, 7)
+			/* (W21) GPMC0_AD12.GPIO0_27 - STATUS_OUT_1 */
+			AM64X_IOPAD(0x006c, PIN_INPUT, 7)
+			/* (V18) GPMC0_AD13.GPIO0_28 - EN_DIG_OUT_2 */
+			AM64X_IOPAD(0x0070, PIN_OUTPUT, 7)
+			/* (Y21) GPMC0_AD14.GPIO0_29 - STATUS_OUT_2 */
+			AM64X_IOPAD(0x0074, PIN_INPUT, 7)
+			/* (Y20) GPMC0_AD15.GPIO0_30 - EN_DIG_OUT_3 */
+			AM64X_IOPAD(0x0078, PIN_OUTPUT, 7)
+			/* (T21) GPMC0_WEn.GPIO0_34 - STATUS_OUT_3 */
+			AM64X_IOPAD(0x008c, PIN_INPUT, 7)
+			/* (P17) GPMC0_BE0n_CLE.GPIO0_35 - EN_DIG_OUT_4 */
+			AM64X_IOPAD(0x0090, PIN_OUTPUT, 7)
+			/* (Y18) GPMC0_WAIT1.GPIO0_38 - STATUS_OUT_4 */
+			AM64X_IOPAD(0x009c, PIN_INPUT, 7)
+			/* (N16) GPMC0_WPn.GPIO0_39 - DIG_IN_1 */
+			AM64X_IOPAD(0x00a0, PIN_INPUT, 7)
+			/* (N17) GPMC0_DIR.GPIO0_40 - DIG_IN_2 */
+			AM64X_IOPAD(0x00a4, PIN_INPUT, 7)
+			/* (R19) GPMC0_CSn0.GPIO0_41 - DIG_IN_3 */
+			AM64X_IOPAD(0x00a8, PIN_INPUT, 7)
+			/* (R20) GPMC0_CSn1.GPIO0_42 - DIG_IN_4 */
+			AM64X_IOPAD(0x00ac, PIN_INPUT, 7)
+		>;
+	};
+
+	main_gpio0_hog_pins: main-gpio0-hog-pins {
+		pinctrl-single,pins = <
+			/* (P19) GPMC0_CSn2.GPIO0_43 - MMC1_CTRL */
+			AM64X_IOPAD(0x00b0, PIN_OUTPUT, 7)
+		>;
+	};
+
+	main_gpio1_hog_pins: main-gpio1-hog-pins {
+		pinctrl-single,pins = <
+			/* (B15) SPI1_D0.GPIO1_50 - USB0_VBUS_OC# */
+			AM64X_IOPAD(0x0228, PIN_INPUT, 7)
+			/* (B16) UART0_CTSn.GPIO1_54 - PRG0_MDIO_SWITCH */
+			AM64X_IOPAD(0x0238, PIN_OUTPUT, 7)
+			/* (C19) EXTINTn.GPIO1_70 - PHY_INT# */
+			AM64X_IOPAD(0x0278, PIN_INPUT, 7)
+		>;
+	};
+
+	main_mcan0_pins: main-mcan0-pins {
+		pinctrl-single,pins = <
+			/* (B17) MCAN0_RX */
+			AM64X_IOPAD(0x0254, PIN_INPUT, 0)
+			/* (A17) MCAN0_TX */
+			AM64X_IOPAD(0x0250, PIN_OUTPUT, 0)
+		>;
+	};
+
+	main_mcan1_pins: main-mcan1-pins {
+		pinctrl-single,pins = <
+			/* (D17) MCAN1_RX */
+			AM64X_IOPAD(0x025c, PIN_INPUT, 0)
+			/* (C17) MCAN1_TX */
+			AM64X_IOPAD(0x0258, PIN_OUTPUT, 0)
+		>;
+	};
+
+	main_mmc1_pins: main-mmc1-pins {
+		pinctrl-single,pins = <
+			/* (J19) MMC1_CMD */
+			AM64X_IOPAD(0x0294, PIN_INPUT, 0)
+			/* (L20) MMC1_CLK */
+			AM64X_IOPAD(0x028c, PIN_INPUT, 0)
+			/* (K21) MMC1_DAT0 */
+			AM64X_IOPAD(0x0288, PIN_INPUT, 0)
+			/* (L21) MMC1_DAT1 */
+			AM64X_IOPAD(0x0284, PIN_INPUT, 0)
+			/* (K19) MMC1_DAT2 */
+			AM64X_IOPAD(0x0280, PIN_INPUT, 0)
+			/* (K18) MMC1_DAT3 */
+			AM64X_IOPAD(0x027c, PIN_INPUT, 0)
+			/* (D19) MMC1_SDCD.GPIO1_77 */
+			AM64X_IOPAD(0x0298, PIN_INPUT, 7)
+			/* (#N/A) MMC1_CLKLB */
+			AM64X_IOPAD(0x0290, PIN_INPUT, 0)
+		>;
+	};
+
+	main_mmc1_reg_pins: main-mmc1-reg-pins {
+		pinctrl-single,pins = <
+			/* (C13) SPI0_CS1.GPIO1_43 - MMC1_SD_EN */
+			AM64X_IOPAD(0x020c, PIN_OUTPUT, 7)
+		>;
+	};
+
+	main_mmc1_wifi_pwrseq_pins: main-mmc1-wifi-pwrseq-pins {
+		pinctrl-single,pins = <
+			/* (V19) GPMC0_AD8.GPIO0_23 - WIFI-BT_EN */
+			AM64X_IOPAD(0x005c, PIN_OUTPUT, 7)
+		>;
+	};
+
+	main_spi0_pins: main-spi0-pins {
+		pinctrl-single,pins = <
+			/* (D13) SPI0_CLK */
+			AM64X_IOPAD(0x0210, PIN_OUTPUT, 0)
+			/* (D12) SPI0_CS0 */
+			AM64X_IOPAD(0x0208, PIN_OUTPUT, 0)
+			/* (A13) SPI0_D0 */
+			AM64X_IOPAD(0x0214, PIN_OUTPUT, 0)
+			/* (A14) SPI0_D1 */
+			AM64X_IOPAD(0x0218, PIN_INPUT, 0)
+		>;
+	};
+
+	main_spi0_adc_pins: main-spi0-adc-pins {
+		pinctrl-single,pins = <
+			/* (A16) UART0_RTSn.GPIO1_55 - ADC_SYNC */
+			AM64X_IOPAD(0x023c, PIN_INPUT, 7)
+			/* (D16) UART1_CTSn.GPIO1_58 - ADC_RST# */
+			AM64X_IOPAD(0x0248, PIN_OUTPUT, 7)
+			/* (E16) UART1_RTSn.GPIO1_59 - ADC_DATA_RDY */
+			AM64X_IOPAD(0x024c, PIN_INPUT, 7)
+			/* (B19) I2C1_SDA.GPIO1_67 - ADC_INT# */
+			AM64X_IOPAD(0x026c, PIN_INPUT, 7)
+		>;
+	};
+
+	main_uart0_pins: main-uart0-pins {
+		pinctrl-single,pins = <
+			/* (D15) UART0_RXD */
+			AM64X_IOPAD(0x0230, PIN_INPUT, 0)
+			/* (C16) UART0_TXD */
+			AM64X_IOPAD(0x0234, PIN_OUTPUT, 0)
+		>;
+	};
+
+	main_uart1_pins: main-uart1-pins {
+		pinctrl-single,pins = <
+			/* (E15) UART1_RXD */
+			AM64X_IOPAD(0x0240, PIN_INPUT, 0)
+			/* (E14) UART1_TXD */
+			AM64X_IOPAD(0x0244, PIN_OUTPUT, 0)
+		>;
+	};
+
+	main_uart2_pins: main-uart2-pins {
+		pinctrl-single,pins = <
+			/* (T18) GPMC0_AD2.UART2_RTSn */
+			AM64X_IOPAD(0x0044, PIN_OUTPUT, 2)
+			/* (T20) GPMC0_AD0.UART2_RXD */
+			AM64X_IOPAD(0x003c, PIN_INPUT, 2)
+			/* (U21) GPMC0_AD1.UART2_TXD */
+			AM64X_IOPAD(0x0040, PIN_OUTPUT, 2)
+		>;
+	};
+
+	main_uart3_pins: main-uart3-pins {
+		pinctrl-single,pins = <
+			/* (T17) GPMC0_AD9.UART3_CTSn */
+			AM64X_IOPAD(0x0060, PIN_INPUT, 2)
+			/* (U19) GPMC0_AD5.UART3_RTSn */
+			AM64X_IOPAD(0x0050, PIN_OUTPUT, 2)
+			/* (U20) GPMC0_AD3.UART3_RXD */
+			AM64X_IOPAD(0x0048, PIN_INPUT, 2)
+			/* (U18) GPMC0_AD4.UART3_TXD */
+			AM64X_IOPAD(0x004c, PIN_OUTPUT, 2)
+		>;
+	};
+
+	main_uart4_pins: main-uart4-pins {
+		pinctrl-single,pins = <
+			/* (R16) GPMC0_AD10.UART4_CTSn */
+			AM64X_IOPAD(0x0064, PIN_INPUT, 2)
+			/* (R17) GPMC0_CLK.UART4_RTSn */
+			AM64X_IOPAD(0x007c, PIN_OUTPUT, 2)
+			/* (V20) GPMC0_AD6.UART4_RXD */
+			AM64X_IOPAD(0x0054, PIN_INPUT, 2)
+			/* (V21) GPMC0_AD7.UART4_TXD */
+			AM64X_IOPAD(0x0058, PIN_OUTPUT, 2)
+
+			/* Control GPIOs for IOT Module connected to UART4 */
+			/* (D18) ECAP0_IN_APWM_OUT.GPIO1_68 - BG95_PWRKEY */
+			AM64X_IOPAD(0x0270, PIN_OUTPUT, 7)
+			/* (A19) EXT_REFCLK1.GPIO1_69 - BG95_RESET */
+			AM64X_IOPAD(0x0274, PIN_OUTPUT, 7)
+		>;
+	};
+
+	main_uart5_pins: main-uart5-pins {
+		pinctrl-single,pins = <
+			/* (P16) GPMC0_ADVn_ALE.UART5_RXD */
+			AM64X_IOPAD(0x0084, PIN_INPUT, 2)
+			/* (R18) GPMC0_OEn_REn.UART5_TXD */
+			AM64X_IOPAD(0x0088, PIN_OUTPUT, 2)
+		>;
+	};
+
+	main_usb0_pins: main-usb0-pins {
+		pinctrl-single,pins = <
+			/* (E19) USB0_DRVVBUS */
+			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0)
+		>;
+	};
+
+	pru_icssg1_mdio_pins: pru-icssg1-mdio-pins {
+		pinctrl-single,pins = <
+			/* (A15) SPI1_D1.GPIO1_51 - RESET_PRG1_RGMII1# */
+			AM64X_IOPAD(0x022c, PIN_OUTPUT, 7)
+			/* (B14) SPI1_CS0.GPIO1_47 - RESET_PRG1_RGMII2# */
+			AM64X_IOPAD(0x021c, PIN_OUTPUT, 7)
+
+			/* (Y6) PRG1_MDIO0_MDC */
+			AM64X_IOPAD(0x015c, PIN_OUTPUT, 0)
+			/* (AA6) PRG1_MDIO0_MDIO */
+			AM64X_IOPAD(0x0158, PIN_INPUT, 0)
+		>;
+	};
+
+	pru_icssg1_rgmii1_pins: pru-icssg1-rgmii1-pins {
+		pinctrl-single,pins = <
+			/* (Y7) PRG1_PRU0_GPO0.PRG1_RGMII1_RD0 */
+			AM64X_IOPAD(0x00b8, PIN_INPUT, 2)
+			/* (U8) PRG1_PRU0_GPO1.PRG1_RGMII1_RD1 */
+			AM64X_IOPAD(0x00bc, PIN_INPUT, 2)
+			/* (W8) PRG1_PRU0_GPO2.PRG1_RGMII1_RD2 */
+			AM64X_IOPAD(0x00c0, PIN_INPUT, 2)
+			/* (V8) PRG1_PRU0_GPO3.PRG1_RGMII1_RD3 */
+			AM64X_IOPAD(0x00c4, PIN_INPUT, 2)
+			/* (AA7) PRG1_PRU0_GPO6.PRG1_RGMII1_RXC */
+			AM64X_IOPAD(0x00d0, PIN_INPUT, 2)
+			/* (Y8) PRG1_PRU0_GPO4.PRG1_RGMII1_RX_CTL */
+			AM64X_IOPAD(0x00c8, PIN_INPUT, 2)
+			/* (AA8) PRG1_PRU0_GPO11.PRG1_RGMII1_TD0 */
+			AM64X_IOPAD(0x00e4, PIN_OUTPUT, 2)
+			/* (U9) PRG1_PRU0_GPO12.PRG1_RGMII1_TD1 */
+			AM64X_IOPAD(0x00e8, PIN_OUTPUT, 2)
+			/* (W9) PRG1_PRU0_GPO13.PRG1_RGMII1_TD2 */
+			AM64X_IOPAD(0x00ec, PIN_OUTPUT, 2)
+			/* (AA9) PRG1_PRU0_GPO14.PRG1_RGMII1_TD3 */
+			AM64X_IOPAD(0x00f0, PIN_OUTPUT, 2)
+			/* (V9) PRG1_PRU0_GPO16.PRG1_RGMII1_TXC */
+			AM64X_IOPAD(0x00f8, PIN_OUTPUT, 2)
+			/* (Y9) PRG1_PRU0_GPO15.PRG1_RGMII1_TX_CTL */
+			AM64X_IOPAD(0x00f4, PIN_OUTPUT, 2)
+		>;
+	};
+
+	pru_icssg1_rgmii2_pins: pru-icssg1-rgmii2-pins {
+		pinctrl-single,pins = <
+			/* (W11) PRG1_PRU1_GPO0.PRG1_RGMII2_RD0 */
+			AM64X_IOPAD(0x0108, PIN_INPUT, 2)
+			/* (V11) PRG1_PRU1_GPO1.PRG1_RGMII2_RD1 */
+			AM64X_IOPAD(0x010c, PIN_INPUT, 2)
+			/* (AA12) PRG1_PRU1_GPO2.PRG1_RGMII2_RD2 */
+			AM64X_IOPAD(0x0110, PIN_INPUT, 2)
+			/* (Y12) PRG1_PRU1_GPO3.PRG1_RGMII2_RD3 */
+			AM64X_IOPAD(0x0114, PIN_INPUT, 2)
+			/* (U11) PRG1_PRU1_GPO6.PRG1_RGMII2_RXC */
+			AM64X_IOPAD(0x0120, PIN_INPUT, 2)
+			/* (W12) PRG1_PRU1_GPO4.PRG1_RGMII2_RX_CTL */
+			AM64X_IOPAD(0x0118, PIN_INPUT, 2)
+			/* (AA10) PRG1_PRU1_GPO11.PRG1_RGMII2_TD0 */
+			AM64X_IOPAD(0x0134, PIN_OUTPUT, 2)
+			/* (V10) PRG1_PRU1_GPO12.PRG1_RGMII2_TD1 */
+			AM64X_IOPAD(0x0138, PIN_OUTPUT, 2)
+			/* (U10) PRG1_PRU1_GPO13.PRG1_RGMII2_TD2 */
+			AM64X_IOPAD(0x013c, PIN_OUTPUT, 2)
+			/* (AA11) PRG1_PRU1_GPO14.PRG1_RGMII2_TD3 */
+			AM64X_IOPAD(0x0140, PIN_OUTPUT, 2)
+			/* (Y10) PRG1_PRU1_GPO16.PRG1_RGMII2_TXC */
+			AM64X_IOPAD(0x0148, PIN_OUTPUT, 2)
+			/* (Y11) PRG1_PRU1_GPO15.PRG1_RGMII2_TX_CTL */
+			AM64X_IOPAD(0x0144, PIN_OUTPUT, 2)
+		>;
+	};
+
+	pwm_fan_pins: pwm-fan-pins {
+		pinctrl-single,pins = <
+			/* (T19) GPMC0_BE1n.EHRPWM5_A */
+			AM64X_IOPAD(0x0094, PIN_OUTPUT, 3)
+			/* (C14) SPI1_CLK.GPIO1_49 - FAN_RPM */
+			AM64X_IOPAD(0x0224, PIN_INPUT, 7)
+		>;
+	};
+
+	pwm_fan_reg_pins: pwm-fan-reg-pins {
+		pinctrl-single,pins = <
+			/* (D14) SPI1_CS1.GPIO1_48 - FAN_PWR */
+			AM64X_IOPAD(0x0220, PIN_OUTPUT, 7)
+		>;
+	};
+};
+
+&mcu_pmx0 {
+	mcu_gpio_keys_pins: mcu-gpio-keys-pins {
+		pinctrl-single,pins = <
+			/* (A7) MCU_SPI1_CS0.MCU_GPIO0_5 */
+			AM64X_MCU_IOPAD(0x0014, PIN_INPUT, 7)
+		>;
+	};
+
+	mcu_gpio_leds_pins: mcu-gpio-leds-pins {
+		pinctrl-single,pins = <
+			/* (C7) MCU_SPI1_D0.MCU_GPIO0_8 */
+			AM64X_MCU_IOPAD(0x0020, PIN_OUTPUT, 7)
+			/* (C8) MCU_SPI1_D1.MCU_GPIO0_9 */
+			AM64X_MCU_IOPAD(0x0024, PIN_OUTPUT, 7)
+		>;
+	};
+
+	mcu_gpio0_pins: mcu-gpio0-pins {
+		pinctrl-single,pins = <
+			/* (E8) MCU_UART0_RTSn.MCU_GPIO0_0 */
+			AM64X_MCU_IOPAD(0x0034, PIN_INPUT, 7)
+			/* (D8) MCU_UART0_CTSn.MCU_GPIO0_1 */
+			AM64X_MCU_IOPAD(0x0030, PIN_INPUT, 7)
+			/* (B7) MCU_SPI1_CS1.MCU_GPIO0_6 */
+			AM64X_MCU_IOPAD(0x0018, PIN_INPUT, 7)
+			/* (D7) MCU_SPI1_CLK.MCU_GPIO0_7 */
+			AM64X_MCU_IOPAD(0x001c, PIN_INPUT, 7)
+			/* (A11) MCU_I2C1_SCL.MCU_GPIO0_20 */
+			AM64X_MCU_IOPAD(0x0050, PIN_INPUT, 7)
+			/* (B10) MCU_I2C1_SDA.MCU_GPIO0_21 */
+			AM64X_MCU_IOPAD(0x0054, PIN_INPUT, 7)
+		>;
+	};
+
+	mcu_i2c0_pins: mcu-i2c0-pins {
+		pinctrl-single,pins = <
+			/* (E9) MCU_I2C0_SCL */
+			AM64X_MCU_IOPAD(0x0048, PIN_INPUT, 0)
+			/* (A10) MCU_I2C0_SDA */
+			AM64X_MCU_IOPAD(0x004c, PIN_INPUT, 0)
+		>;
+	};
+
+	mcu_spi0_pins: mcu-spi0-pins {
+		pinctrl-single,pins = <
+			/* (E6) MCU_SPI0_CLK */
+			AM64X_MCU_IOPAD(0x0008, PIN_OUTPUT, 0)
+			/* (D6) MCU_SPI0_CS0 */
+			AM64X_MCU_IOPAD(0x0000, PIN_OUTPUT, 0)
+			/* (C6) MCU_SPI0_CS1 */
+			AM64X_MCU_IOPAD(0x0004, PIN_OUTPUT, 0)
+			/* (E7) MCU_SPI0_D0 */
+			AM64X_MCU_IOPAD(0x000c, PIN_OUTPUT, 0)
+			/* (B6) MCU_SPI0_D1 */
+			AM64X_MCU_IOPAD(0x0010, PIN_INPUT, 0)
+		>;
+	};
+
+	mcu_uart0_pins: mcu-uart0-pins {
+		pinctrl-single,pins = <
+			/* (A9) MCU_UART0_RXD */
+			AM64X_MCU_IOPAD(0x0028, PIN_INPUT, 0)
+			/* (A8) MCU_UART0_TXD */
+			AM64X_MCU_IOPAD(0x002c, PIN_OUTPUT, 0)
+		>;
+	};
+
+	mcu_uart1_pins: mcu-uart1-pins {
+		pinctrl-single,pins = <
+			/* (B8) MCU_UART1_CTSn */
+			AM64X_MCU_IOPAD(0x0040, PIN_INPUT, 0)
+			/* (B9) MCU_UART1_RTSn */
+			AM64X_MCU_IOPAD(0x0044, PIN_OUTPUT, 0)
+			/* (C9) MCU_UART1_RXD */
+			AM64X_MCU_IOPAD(0x0038, PIN_INPUT, 0)
+			/* (D9) MCU_UART1_TXD */
+			AM64X_MCU_IOPAD(0x003c, PIN_OUTPUT, 0)
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
new file mode 100644
index 0000000000000..5e9012107afab
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (c) 2022-2023 TQ-Systems GmbH <linux@ew.tq-group.com>, D-82229 Seefeld, Germany.
+ */
+
+#include "k3-am642.dtsi"
+
+/ {
+	aliases {
+		i2c0 = &main_i2c0;
+		mmc0 = &sdhci0;
+		spi0 = &ospi0;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* 1G RAM - default variant */
+		reg = <0x00000000 0x80000000 0x00000000 0x40000000>;
+
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+
+		main_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa1000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa1100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa2000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa2100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa3000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa3100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		rtos_ipc_memory_region: ipc-memories@a5000000 {
+			reg = <0x00 0xa5000000 0x00 0x00800000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+	};
+};
+
+&main_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	tmp1075: temperature-sensor@4a {
+		compatible = "ti,tmp1075";
+		reg = <0x4a>;
+	};
+
+	eeprom0: eeprom@50 {
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+		read-only;
+	};
+
+	pcf85063: rtc@51 {
+		compatible = "nxp,pcf85063a";
+		reg = <0x51>;
+		quartz-load-femtofarads = <12500>;
+	};
+
+	eeprom1: eeprom@54 {
+		compatible = "st,24c64", "atmel,24c64";
+		reg = <0x54>;
+		pagesize = <32>;
+	};
+};
+
+&mailbox0_cluster2 {
+	status = "okay";
+
+	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
+		ti,mbox-rx = <0 0 2>;
+		ti,mbox-tx = <1 0 2>;
+	};
+
+	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
+		ti,mbox-rx = <2 0 2>;
+		ti,mbox-tx = <3 0 2>;
+	};
+};
+
+&mailbox0_cluster4 {
+	status = "okay";
+
+	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
+		ti,mbox-rx = <0 0 2>;
+		ti,mbox-tx = <1 0 2>;
+	};
+
+	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
+		ti,mbox-rx = <2 0 2>;
+		ti,mbox-tx = <3 0 2>;
+	};
+};
+
+&mailbox0_cluster6 {
+	status = "okay";
+
+	mbox_m4_0: mbox-m4-0 {
+		ti,mbox-rx = <0 0 2>;
+		ti,mbox-tx = <1 0 2>;
+	};
+};
+
+&main_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
+	memory-region = <&main_r5fss0_core0_dma_memory_region>,
+			<&main_r5fss0_core0_memory_region>;
+};
+
+&main_r5fss0_core1 {
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
+	memory-region = <&main_r5fss0_core1_dma_memory_region>,
+			<&main_r5fss0_core1_memory_region>;
+};
+
+&main_r5fss1_core0 {
+	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
+	memory-region = <&main_r5fss1_core0_dma_memory_region>,
+			<&main_r5fss1_core0_memory_region>;
+};
+
+&main_r5fss1_core1 {
+	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
+	memory-region = <&main_r5fss1_core1_dma_memory_region>,
+			<&main_r5fss1_core1_memory_region>;
+};
+
+&ospi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ospi0_pins>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+		spi-max-frequency = <84000000>;
+		cdns,tshsl-ns = <60>;
+		cdns,tsd2d-ns = <60>;
+		cdns,tchsh-ns = <60>;
+		cdns,tslch-ns = <60>;
+		cdns,read-delay = <2>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			/* Filled by bootloader */
+		};
+	};
+};
+
+&sdhci0 {
+	non-removable;
+	disable-wp;
+	no-sdio;
+	no-sd;
+	ti,driver-strength-ohm = <50>;
+};
+
+&main_pmx0 {
+	main_i2c0_pins: main-i2c0-pins {
+		pinctrl-single,pins = <
+			/* (A18) I2C0_SCL */
+			AM64X_IOPAD(0x0260, PIN_INPUT_PULLUP, 0)
+			/* (B18) I2C0_SDA */
+			AM64X_IOPAD(0x0264, PIN_INPUT_PULLUP, 0)
+		>;
+	};
+
+	ospi0_pins: ospi0-pins {
+		pinctrl-single,pins = <
+			/* (N20) OSPI0_CLK */
+			AM64X_IOPAD(0x0000, PIN_OUTPUT, 0)
+			/* (L19) OSPI0_CSn0 */
+			AM64X_IOPAD(0x002c, PIN_OUTPUT, 0)
+			/* (M19) OSPI0_D0 */
+			AM64X_IOPAD(0x000c, PIN_INPUT, 0)
+			/* (M18) OSPI0_D1 */
+			AM64X_IOPAD(0x0010, PIN_INPUT, 0)
+			/* (M20) OSPI0_D2 */
+			AM64X_IOPAD(0x0014, PIN_INPUT, 0)
+			/* (M21) OSPI0_D3 */
+			AM64X_IOPAD(0x0018, PIN_INPUT, 0)
+			/* (P21) OSPI0_D4 */
+			AM64X_IOPAD(0x001c, PIN_INPUT, 0)
+			/* (P20) OSPI0_D5 */
+			AM64X_IOPAD(0x0020, PIN_INPUT, 0)
+			/* (N18) OSPI0_D6 */
+			AM64X_IOPAD(0x0024, PIN_INPUT, 0)
+			/* (M17) OSPI0_D7 */
+			AM64X_IOPAD(0x0028, PIN_INPUT, 0)
+			/* (N19) OSPI0_DQS */
+			AM64X_IOPAD(0x0008, PIN_INPUT, 0)
+		>;
+	};
+};
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

