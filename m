Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E226A811192
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378930AbjLMMt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378941AbjLMMtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:49:47 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75804EA;
        Wed, 13 Dec 2023 04:49:48 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BDCnaXS005865;
        Wed, 13 Dec 2023 06:49:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702471776;
        bh=F99hiyYRTqN0xEpFopcKYcZrXDpOJcGYI0JZNgw6I10=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=E9CzqppeRH090jtmVX8ZAjE4QkaxuWEDh9AxRPdKgzf+q9Y55iwZWctUnf+ooGIFs
         r5YP+8tSD4qK/RZ0zMuHO2uMGQFL+vxifWVkelvTSSF3vhcRKxucA7ml0tQk/qa9Ur
         +FNSaIv3hpXeDt0m4zEKtU5etuq2t8NyxIImymD8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BDCna59091795
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Dec 2023 06:49:36 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 06:49:35 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 06:49:35 -0600
Received: from localhost ([10.24.69.141])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BDCnZeX092413;
        Wed, 13 Dec 2023 06:49:35 -0600
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <j-choudhary@ti.com>,
        <u-kumar1@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH 3/3] arm64: dts: ti: Add support for TI J722S Evaluation Module
Date:   Wed, 13 Dec 2023 18:19:30 +0530
Message-ID: <20231213124930.3012-4-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231213124930.3012-1-vaishnav.a@ti.com>
References: <20231213124930.3012-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic support for the J722S EVM with UART console and
MMC SD as rootfs.

Schematics are available at:
	https://www.ti.com/lit/zip/sprr495

Co-developed-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile         |   3 +
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 253 ++++++++++++++++++++++++
 2 files changed, 256 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-evm.dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 1ac47876bc99..aa7cc33e239b 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -76,6 +76,9 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-gesi-exp-board.dtbo
 k3-j721s2-evm-dtbs := k3-j721s2-common-proc-board.dtb k3-j721s2-evm-gesi-exp-board.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm.dtb
 
+# Boards with J722s SoC
+dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm.dtb
+
 # Boards with J784s4 SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
new file mode 100644
index 000000000000..1cb29203a8ed
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree file for the J722S-EVM
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * Schematics: https://www.ti.com/lit/zip/sprr495
+ */
+
+/dts-v1/;
+
+#include "k3-j722s.dtsi"
+
+/ {
+	compatible = "ti,j722s-evm", "ti,j722s";
+	model = "Texas Instruments J722S EVM";
+
+	aliases {
+		serial0 = &wkup_uart0;
+		serial2 = &main_uart0;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+	};
+
+	chosen {
+		stdout-path = &main_uart0;
+	};
+
+	memory@80000000 {
+		/* 8G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000001 0x80000000>;
+		device_type = "memory";
+		bootph-pre-ram;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure_tfa_ddr: tfa@9e780000 {
+			reg = <0x00 0x9e780000 0x00 0x80000>;
+			no-map;
+		};
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_memory_region: r5f-memory@a0100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0100000 0x00 0xf00000>;
+			no-map;
+		};
+
+	};
+
+	vmain_pd: regulator-0 {
+		/* TPS65988 PD CONTROLLER OUTPUT */
+		compatible = "regulator-fixed";
+		regulator-name = "vmain_pd";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+		bootph-all;
+	};
+
+	vsys_5v0: regulator-vsys5v0 {
+		/* Output of LM5140 */
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vmain_pd>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_mmc1: regulator-mmc1 {
+		/* TPS22918DBVR */
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_mmc1";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&exp1 15 GPIO_ACTIVE_HIGH>;
+		bootph-all;
+	};
+
+	vdd_sd_dv: regulator-TLV71033 {
+		compatible = "regulator-gpio";
+		regulator-name = "tlv71033";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_sd_dv_pins_default>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		vin-supply = <&vsys_5v0>;
+		gpios = <&main_gpio0 70 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+	};
+
+	vsys_io_1v8: regulator-vsys-io-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_io_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vsys_io_1v2: regulator-vsys-io-1v2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_io_1v2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&main_pmx0 {
+	bootph-all;
+
+	main_i2c0_pins_default: main-i2c0-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x01e0, PIN_INPUT_PULLUP, 0) /* (D23) I2C0_SCL */
+			J722S_IOPAD(0x01e4, PIN_INPUT_PULLUP, 0) /* (B22) I2C0_SDA */
+		>;
+		bootph-all;
+	};
+
+	main_uart0_pins_default: main-uart0-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x1c8, PIN_INPUT, 0)	/* (A22) UART0_RXD */
+			J722S_IOPAD(0x1cc, PIN_OUTPUT, 0)	/* (B22) UART0_TXD */
+		>;
+		bootph-all;
+	};
+
+	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x0120, PIN_INPUT, 7) /* (F27) MMC2_CMD.GPIO0_70 */
+		>;
+		bootph-all;
+	};
+
+	main_mmc1_pins_default: main-mmc1-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x023c, PIN_INPUT, 0) /* (H22) MMC1_CMD */
+			J722S_IOPAD(0x0234, PIN_OUTPUT, 0) /* (H24) MMC1_CLK */
+			J722S_IOPAD(0x0230, PIN_INPUT, 0) /* (H23) MMC1_DAT0 */
+			J722S_IOPAD(0x022c, PIN_INPUT_PULLUP, 0) /* (H20) MMC1_DAT1 */
+			J722S_IOPAD(0x0228, PIN_INPUT_PULLUP, 0) /* (J23) MMC1_DAT2 */
+			J722S_IOPAD(0x0224, PIN_INPUT_PULLUP, 0) /* (H25) MMC1_DAT3 */
+			J722S_IOPAD(0x0240, PIN_INPUT, 0) /* (B24) MMC1_SDCD */
+		>;
+		bootph-all;
+	};
+};
+
+&main_gpio1 {
+	status = "okay";
+};
+
+&main_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins_default>;
+	status = "okay";
+	bootph-all;
+};
+
+&mcu_pmx0 {
+	bootph-all;
+
+	wkup_uart0_pins_default: wkup-uart0-default-pins {
+		pinctrl-single,pins = <
+			J722S_MCU_IOPAD(0x02c, PIN_INPUT, 0)	/* (C7) WKUP_UART0_CTSn */
+			J722S_MCU_IOPAD(0x030, PIN_OUTPUT, 0)	/* (C6) WKUP_UART0_RTSn */
+			J722S_MCU_IOPAD(0x024, PIN_INPUT, 0)	/* (D8) WKUP_UART0_RXD */
+			J722S_MCU_IOPAD(0x028, PIN_OUTPUT, 0)	/* (D7) WKUP_UART0_TXD */
+		>;
+		bootph-all;
+	};
+
+	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
+		pinctrl-single,pins = <
+			J722S_MCU_IOPAD(0x04c, PIN_INPUT_PULLUP, 0)	/* (C7) WKUP_I2C0_SCL */
+			J722S_MCU_IOPAD(0x050, PIN_INPUT_PULLUP, 0)	/* (C6) WKUP_I2C1_SDA */
+		>;
+		bootph-all;
+	};
+};
+
+&wkup_uart0 {
+	/* WKUP UART0 is used by DM firmware */
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_uart0_pins_default>;
+	status = "reserved";
+	bootph-all;
+};
+
+&wkup_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+	bootph-all;
+};
+
+&main_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+	bootph-all;
+
+	exp1: gpio@23 {
+		compatible = "ti,tca6424";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "TRC_MUX_SEL", "OSPI/ONAND_MUX_SEL",
+				  "MCASP1_FET_SEL", "CTRL_PM_I2C_OE#",
+				  "CSI_VIO_SEL", "USB2.0_MUX_SEL",
+				  "CSI01_MUX_SEL_2", "CSI23_MUX_SEL_2",
+				  "LMK1_OE1", "LMK1_OE0",
+				  "LMK2_OE0", "LMK2_OE1",
+				  "GPIO_RGMII1_RST#", "GPIO_AUD_RSTn",
+				  "GPIO_eMMC_RSTn", "GPIO_uSD_PWR_EN",
+				  "USER_LED2", "MCAN0_STB",
+				  "PCIe0_1L_RC_RSTz", "PCIe0_1L_PRSNT#",
+				  "ENET1_EXP_SPARE2", "ENET1_EXP_PWRDN",
+				  "PD_I2ENET1_I2CMUX_SELC_IRQ", "ENET1_EXP_RESETZ";
+	};
+};
+
+&sdhci1 {
+	/* SD/MMC */
+	status = "okay";
+	vmmc-supply = <&vdd_mmc1>;
+	vqmmc-supply = <&vdd_sd_dv>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc1_pins_default>;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+	no-1-8-v;
+	bootph-all;
+};
-- 
2.17.1

