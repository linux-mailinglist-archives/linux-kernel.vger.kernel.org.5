Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12639793B9D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbjIFLor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjIFLoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:44:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5E4CF;
        Wed,  6 Sep 2023 04:44:35 -0700 (PDT)
X-UUID: bd305c924caa11eea33bb35ae8d461a2-20230906
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=H8uLD9NO2I4PrrzMRIRt3gjRb1D/CZYmGgJsfvlNz64=;
        b=nrsI6763YLUbLjTCUo7dBjmyQ3Cg76IE/MqIp31DQnSg3Cern60cdCx1kct3rjlEGTzl7sfynfFwxCwYsRcCzd+ubK6UK/5w5y9o7cUYrglz/VD/M+Y+WhMQn6YG60aXHIhuWtrlYw0nLTDO7SYXo11iQV3zgz3F8BICo0wnFXk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:bc60c298-df0f-4e31-ad02-75d63ccb9a17,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:0ad78a4,CLOUDID:2f8fa013-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bd305c924caa11eea33bb35ae8d461a2-20230906
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1401492415; Wed, 06 Sep 2023 19:44:29 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 6 Sep 2023 19:44:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 6 Sep 2023 19:44:28 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>, Ben Lok <ben.lok@mediatek.com>
Subject: [PATCH v3 2/2] arm64: dts: mediatek: add device-tree for Genio 1200 EVK board
Date:   Wed, 6 Sep 2023 19:44:25 +0800
Message-ID: <20230906114425.31187-2-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230906114425.31187-1-macpaul.lin@mediatek.com>
References: <20230906114425.31187-1-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic device-tree for the Genio 1200 EVK board. The
Demo board is made by MediaTek and has a MT8395 SoC (MT8195 family),
associated with the MT6359 and MT6360 PMICs, and
the MT7921 connectivity chip.

The IOs available on that board are:
* 1 USB Type-C connector with DP aux mode support
* 2 USB Type-A connector with a USB hub
* 1 micro-USB port for gadget or OTG support
* 1 full size HDMI RX and 1 full size HDMI TX connector
* 1 micro SD slot
* 40 pins header
* SPI interface header
* 1 M.2 slot
* 1 audio jack
* 1 micro-USB port for serial debug
* 2 connectors for DSI displays, 1 of the DSI panel is installed
* 3 connectors for CSI cameras
* 1 connector for a eDP panel
* 1 MMC storage
* 1 Touch Panel (installed DSI display)
* 1 M.2 slot for 5G dongle

This commit adds basic support in order to be able to boot.

Signed-off-by: Ben Lok <ben.lok@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../boot/dts/mediatek/genio-1200-evk.dts      | 916 ++++++++++++++++++
 2 files changed, 917 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/genio-1200-evk.dts

Changes for v2:
 - correct SOC binding to "mediatek,mt8395".
 - Fix a Linux coding style comments for optee node.
 - Fix wifi fixed 3.3v power's node with "wifi-3v3-regulator".
 - Fix node name of mt6360 and mt6517 to generic dts name as "pmic".
 - Remove unecessary blank line.
 - Reording usb node as the order of "phy" then "host".

Changes for v3:
 - Add back bindings for "mediatek,mt8195".
 - Fix wifi fixed 3.3v power's node with "regulator-2"

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index c99c3372a4b5..5bf29581f08b 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_MEDIATEK) += genio-1200-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6779-evb.dtb
diff --git a/arch/arm64/boot/dts/mediatek/genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/genio-1200-evk.dts
new file mode 100644
index 000000000000..dd7518784aaf
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/genio-1200-evk.dts
@@ -0,0 +1,916 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2023 MediaTek Inc.
+ * Author: Ben Lok <ben.lok@mediatek.com>
+ *	   Macpaul Lin <macpaul.lin@mediatek.com>
+ */
+/dts-v1/;
+
+#include "mt8195.dtsi"
+#include "mt6359.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/mt8195-pinfunc.h>
+#include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
+#include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/usb/pd.h>
+
+/ {
+	model = "MediaTek Genio 1200 EVK-P1V2-EMMC";
+	compatible = "mediatek,mt8395-evk", "mediatek,mt8395",
+		     "mediatek,mt8195";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet0 = &eth;
+	};
+
+	chosen {
+		stdout-path = "serial0:921600n8";
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0x2 0x00000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * 12 MiB reserved for OP-TEE (BL32)
+		 * +-----------------------+ 0x43e0_0000
+		 * |      SHMEM 2MiB       |
+		 * +-----------------------+ 0x43c0_0000
+		 * |        | TA_RAM  8MiB |
+		 * + TZDRAM +--------------+ 0x4340_0000
+		 * |        | TEE_RAM 2MiB |
+		 * +-----------------------+ 0x4320_0000
+		 */
+		optee_reserved: optee@43200000 {
+			no-map;
+			reg = <0 0x43200000 0 0x00c00000>;
+		};
+
+		scp_mem: memory@50000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x50000000 0 0x2900000>;
+			no-map;
+		};
+
+		vpu_mem: memory@53000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x53000000 0 0x1400000>; /* 20 MB */
+		};
+
+		/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
+		bl31_secmon_mem: memory@54600000 {
+			no-map;
+			reg = <0 0x54600000 0x0 0x200000>;
+		};
+
+		snd_dma_mem: memory@60000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x60000000 0 0x1100000>;
+			no-map;
+		};
+
+		apu_mem: memory@62000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x62000000 0 0x1400000>; /* 20 MB */
+		};
+	};
+
+	edp_panel_fixed_3v3: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "edp_panel_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&pio 6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_panel_3v3_en_pins>;
+	};
+
+	edp_panel_fixed_12v: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "edp_backlight_12v";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		enable-active-high;
+		gpio = <&pio 96 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_panel_12v_en_pins>;
+	};
+
+	backlight_lcd0: backlight-lcd0 {
+		compatible = "pwm-backlight";
+		pwms = <&disp_pwm0 0 500000>;
+		enable-gpios = <&pio 47 GPIO_ACTIVE_HIGH>;
+		brightness-levels = <0 1023>;
+		num-interpolated-steps = <1023>;
+		default-brightness-level = <576>;
+	};
+
+	backlight_lcd1: backlight-lcd1 {
+		compatible = "pwm-backlight";
+		pwms = <&disp_pwm1 0 500000>;
+		enable-gpios = <&pio 46 GPIO_ACTIVE_HIGH>;
+		brightness-levels = <0 1023>;
+		num-interpolated-steps = <1023>;
+		default-brightness-level = <576>;
+	};
+
+	keys: gpio-keys {
+		compatible = "gpio-keys";
+
+		button-volume-up {
+			wakeup-source;
+			debounce-interval = <100>;
+			gpios = <&pio 106 GPIO_ACTIVE_LOW>;
+			label = "volume_up";
+			linux,code = <KEY_VOLUMEUP>;
+		};
+	};
+
+	can_clk: can-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <20000000>;
+		clock-output-names = "can-clk";
+	};
+
+	wifi_fixed_3v3: regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "wifi_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pio 135 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+};
+
+&eth {
+	phy-mode ="rgmii-rxid";
+	phy-handle = <&eth_phy0>;
+	snps,reset-gpio = <&pio 93 GPIO_ACTIVE_HIGH>;
+	snps,reset-delays-us = <0 10000 10000>;
+	mediatek,tx-delay-ps = <2030>;
+	mediatek,mac-wol;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&eth_default_pins>;
+	pinctrl-1 = <&eth_sleep_pins>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		eth_phy0: eth-phy0@1 {
+			compatible = "ethernet-phy-id001c.c916";
+			reg = <0x1>;
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-0 = <&uart1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&scp {
+	status = "okay";
+};
+
+&mmc0 {
+	status = "okay";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_default_pins>;
+	pinctrl-1 = <&mmc0_uhs_pins>;
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	cap-mmc-hw-reset;
+	no-sdio;
+	no-sd;
+	hs400-ds-delay = <0x14c11>;
+	vmmc-supply = <&mt6359_vemc_1_ldo_reg>;
+	vqmmc-supply = <&mt6359_vufs_ldo_reg>;
+	non-removable;
+};
+
+&mmc1 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc1_default_pins>;
+	pinctrl-1 = <&mmc1_uhs_pins>;
+	bus-width = <4>;
+	max-frequency = <200000000>;
+	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	no-mmc;
+	no-sdio;
+	vmmc-supply = <&mt6360_ldo5>;
+	vqmmc-supply = <&mt6360_ldo3>;
+	status = "okay";
+	non-removable;
+};
+
+
+&ufsphy {
+	status = "disabled";
+};
+
+&pmic {
+	interrupt-parent = <&pio>;
+	interrupts = <222 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&scp {
+	memory-region = <&scp_mem>;
+	status = "okay";
+};
+
+&i2c0 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	touchscreen@5d {
+		compatible = "goodix,gt9271";
+		reg = <0x5d>;
+		interrupt-parent = <&pio>;
+		interrupts = <132 IRQ_TYPE_EDGE_RISING>;
+		irq-gpios = <&pio 132 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&pio 133 GPIO_ACTIVE_HIGH>;
+		AVDD28-supply = <&mt6360_ldo1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_pins>;
+	};
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&i2c6 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&i2c6_pins>;
+	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	mt6360: pmic@34 {
+		compatible = "mediatek,mt6360";
+		reg = <0x34>;
+		interrupts = <128 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-names = "IRQB";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		pinctrl-0 = <&mt6360_pins>;
+
+		charger {
+			compatible = "mediatek,mt6360-chg";
+			richtek,vinovp-microvolt = <14500000>;
+
+			otg_vbus_regulator: usb-otg-vbus-regulator {
+				regulator-name = "usb-otg-vbus";
+				regulator-min-microvolt = <4425000>;
+				regulator-max-microvolt = <5825000>;
+			};
+		};
+
+		regulator {
+			compatible = "mediatek,mt6360-regulator";
+			LDO_VIN3-supply = <&mt6360_buck2>;
+
+			mt6360_buck1: buck1 {
+				regulator-name = "emi_vdd2";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP
+							   MT6360_OPMODE_ULP>;
+				regulator-always-on;
+			};
+
+			mt6360_buck2: buck2 {
+				regulator-name = "emi_vddq";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP
+							   MT6360_OPMODE_ULP>;
+				regulator-always-on;
+			};
+
+			mt6360_ldo1: ldo1 {
+				regulator-name = "tp1_p3v0";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+				regulator-always-on;
+			};
+
+			mt6360_ldo2: ldo2 {
+				regulator-name = "panel1_p1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+			};
+
+			mt6360_ldo3: ldo3 {
+				regulator-name = "vmc_pmu";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+			};
+
+			mt6360_ldo5: ldo5 {
+				regulator-name = "vmch_pmu";
+				regulator-min-microvolt = <2700000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+			};
+
+			/* This is a measure point, which name is mt6360_ldo1 on schematic */
+			mt6360_ldo6: ldo6 {
+				regulator-name = "mt6360_ldo1";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <2100000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+			};
+
+			mt6360_ldo7: ldo7 {
+				regulator-name = "emi_vmddr_en";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <2100000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&spi1 {
+	pinctrl-0 = <&spi1_pins>;
+	pinctrl-names = "default";
+	mediatek,pad-select = <0>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+	cs-gpios = <&pio 64 GPIO_ACTIVE_LOW>;
+
+	can0: can@0 {
+		compatible = "microchip,mcp2518fd";
+		reg = <0>;
+		clocks = <&can_clk>;
+		spi-max-frequency = <20000000>;
+		interrupts-extended = <&pio 16 IRQ_TYPE_LEVEL_LOW>;
+		vdd-supply = <&mt6359_vcn33_2_bt_ldo_reg>;
+		xceiver-supply = <&mt6359_vcn33_2_bt_ldo_reg>;
+	};
+};
+
+&spi2 {
+	pinctrl-0 = <&spi2_pins>;
+	pinctrl-names = "default";
+	mediatek,pad-select = <0>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+};
+
+&u3phy0 {
+	status = "okay";
+};
+
+&u3phy1 {
+	status = "okay";
+};
+
+&u3phy2 {
+	status = "okay";
+};
+
+&u3phy3 {
+	status = "okay";
+};
+
+&xhci0 {
+	status = "okay";
+};
+
+&xhci1 {
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	status = "okay";
+};
+
+&xhci2 {
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	status = "okay";
+};
+
+&xhci3 {
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	status = "okay";
+};
+
+&disp_pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_default_pins>;
+	status = "okay";
+};
+
+
+&pio {
+	mmc0_default_pins: mmc0-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO125__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO124__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO123__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO119__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO118__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO117__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO116__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO121__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO120__FUNC_MSDC0_RSTB>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc0_uhs_pins: mmc0-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO125__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO124__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO123__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO119__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO118__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO117__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO116__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO121__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-ds {
+			pinmux = <PINMUX_GPIO127__FUNC_MSDC0_DSL>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO120__FUNC_MSDC0_RSTB>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc1_default_pins: mmc1-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO111__FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO110__FUNC_MSDC1_CMD>,
+				 <PINMUX_GPIO112__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO113__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO114__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO115__FUNC_MSDC1_DAT3>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc1_uhs_pins: mmc1-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO111__FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO110__FUNC_MSDC1_CMD>,
+				 <PINMUX_GPIO112__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO113__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO114__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO115__FUNC_MSDC1_DAT3>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	pwm0_default_pins: pwm0-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO97__FUNC_DISP_PWM0>;
+		};
+	};
+
+	audio_default_pins: audio-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO69__FUNC_AUD_CLK_MOSI>,
+				 <PINMUX_GPIO70__FUNC_AUD_SYNC_MOSI>,
+				 <PINMUX_GPIO71__FUNC_AUD_DAT_MOSI0>,
+				 <PINMUX_GPIO72__FUNC_AUD_DAT_MOSI1>,
+				 <PINMUX_GPIO73__FUNC_AUD_DAT_MISO0>,
+				 <PINMUX_GPIO74__FUNC_AUD_DAT_MISO1>,
+				 <PINMUX_GPIO75__FUNC_AUD_DAT_MISO2>,
+				 <PINMUX_GPIO61__FUNC_DMIC1_CLK>,
+				 <PINMUX_GPIO62__FUNC_DMIC1_DAT>,
+				 <PINMUX_GPIO65__FUNC_PCM_DO>,
+				 <PINMUX_GPIO66__FUNC_PCM_CLK>,
+				 <PINMUX_GPIO67__FUNC_PCM_DI>,
+				 <PINMUX_GPIO68__FUNC_PCM_SYNC>;
+		};
+	};
+
+	i2c0_pins: i2c0-pins {
+		pins {
+			pinmux = <PINMUX_GPIO8__FUNC_SDA0>,
+				 <PINMUX_GPIO9__FUNC_SCL0>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c1_pins: i2c1-pins {
+		pins {
+			pinmux = <PINMUX_GPIO10__FUNC_SDA1>,
+				 <PINMUX_GPIO11__FUNC_SCL1>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c2_pins: i2c2-pins {
+		pins {
+			pinmux = <PINMUX_GPIO12__FUNC_SDA2>,
+				 <PINMUX_GPIO13__FUNC_SCL2>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+			drive-strength = <MTK_DRIVE_6mA>;
+		};
+	};
+
+	i2c6_pins: i2c6-pins {
+		pins {
+			pinmux = <PINMUX_GPIO25__FUNC_SDA6>,
+				 <PINMUX_GPIO26__FUNC_SCL6>;
+			bias-pull-up;
+		};
+	};
+
+	uart0_pins: uart0-pins {
+		pins {
+			pinmux = <PINMUX_GPIO98__FUNC_UTXD0>,
+				 <PINMUX_GPIO99__FUNC_URXD0>;
+		};
+	};
+
+	uart1_pins: uart1-pins {
+		pins {
+			pinmux = <PINMUX_GPIO102__FUNC_UTXD1>,
+				 <PINMUX_GPIO103__FUNC_URXD1>,
+				 <PINMUX_GPIO100__FUNC_URTS1>,
+				 <PINMUX_GPIO101__FUNC_UCTS1>;
+		};
+	};
+
+	spi1_pins: spi1-pins {
+		pins {
+			pinmux = <PINMUX_GPIO136__FUNC_SPIM1_CSB>,
+				 <PINMUX_GPIO137__FUNC_SPIM1_CLK>,
+				 <PINMUX_GPIO138__FUNC_SPIM1_MO>,
+				 <PINMUX_GPIO139__FUNC_SPIM1_MI>;
+			bias-disable;
+		};
+	};
+
+	spi2_pins: spi-pins {
+		pins {
+			pinmux = <PINMUX_GPIO140__FUNC_SPIM2_CSB>,
+				 <PINMUX_GPIO141__FUNC_SPIM2_CLK>,
+				 <PINMUX_GPIO142__FUNC_SPIM2_MO>,
+				 <PINMUX_GPIO143__FUNC_SPIM2_MI>;
+			bias-disable;
+		};
+	};
+
+	eth_default_pins: eth-default-pins {
+		pins-txd {
+			pinmux = <PINMUX_GPIO77__FUNC_GBE_TXD3>,
+				 <PINMUX_GPIO78__FUNC_GBE_TXD2>,
+				 <PINMUX_GPIO79__FUNC_GBE_TXD1>,
+				 <PINMUX_GPIO80__FUNC_GBE_TXD0>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+
+		pins-cc {
+			pinmux = <PINMUX_GPIO85__FUNC_GBE_TXC>,
+				 <PINMUX_GPIO88__FUNC_GBE_TXEN>,
+				 <PINMUX_GPIO87__FUNC_GBE_RXDV>,
+				 <PINMUX_GPIO86__FUNC_GBE_RXC>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+
+		pins-rxd {
+			pinmux = <PINMUX_GPIO81__FUNC_GBE_RXD3>,
+				 <PINMUX_GPIO82__FUNC_GBE_RXD2>,
+				 <PINMUX_GPIO83__FUNC_GBE_RXD1>,
+				 <PINMUX_GPIO84__FUNC_GBE_RXD0>;
+		};
+
+		pins-mdio {
+			pinmux = <PINMUX_GPIO89__FUNC_GBE_MDC>,
+				 <PINMUX_GPIO90__FUNC_GBE_MDIO>;
+			input-enable;
+		};
+
+		pins-power {
+			pinmux = <PINMUX_GPIO91__FUNC_GPIO91>,
+				 <PINMUX_GPIO92__FUNC_GPIO92>;
+			output-high;
+		};
+	};
+
+	eth_sleep_pins: eth-sleep-pins {
+		pins-txd {
+			pinmux = <PINMUX_GPIO77__FUNC_GPIO77>,
+				 <PINMUX_GPIO78__FUNC_GPIO78>,
+				 <PINMUX_GPIO79__FUNC_GPIO79>,
+				 <PINMUX_GPIO80__FUNC_GPIO80>;
+		};
+
+		pins-cc {
+			pinmux = <PINMUX_GPIO85__FUNC_GPIO85>,
+				 <PINMUX_GPIO88__FUNC_GPIO88>,
+				 <PINMUX_GPIO87__FUNC_GPIO87>,
+				 <PINMUX_GPIO86__FUNC_GPIO86>;
+		};
+
+		pins-rxd {
+			pinmux = <PINMUX_GPIO81__FUNC_GPIO81>,
+				 <PINMUX_GPIO82__FUNC_GPIO82>,
+				 <PINMUX_GPIO83__FUNC_GPIO83>,
+				 <PINMUX_GPIO84__FUNC_GPIO84>;
+		};
+
+		pins-mdio {
+			pinmux = <PINMUX_GPIO89__FUNC_GPIO89>,
+				 <PINMUX_GPIO90__FUNC_GPIO90>;
+			input-disable;
+			bias-disable;
+		};
+	};
+
+	pcie0_default_pins: pcie0-default-pins {
+		pins {
+			pinmux = <PINMUX_GPIO19__FUNC_WAKEN>,
+				 <PINMUX_GPIO20__FUNC_PERSTN>,
+				 <PINMUX_GPIO21__FUNC_CLKREQN>;
+			bias-pull-up;
+		};
+	};
+
+	pcie0_idle_pins: pcie0-idle-pins {
+		pins {
+			pinmux = <PINMUX_GPIO20__FUNC_GPIO20>;
+			bias-disable;
+			output-low;
+		};
+	};
+
+	pcie1_default_pins: pcie1-default-pins {
+		pins {
+			pinmux = <PINMUX_GPIO22__FUNC_PERSTN_1>,
+				 <PINMUX_GPIO23__FUNC_CLKREQN_1>,
+				 <PINMUX_GPIO24__FUNC_WAKEN_1>;
+			bias-pull-up;
+		};
+	};
+
+	edp_panel_12v_en_pins: edp-panel-12v-en-pins {
+		pins1 {
+			pinmux = <PINMUX_GPIO96__FUNC_GPIO96>;
+			output-high;
+		};
+	};
+
+	edp_panel_3v3_en_pins: edp-panel-3v3-en-pins {
+		pins1 {
+			pinmux = <PINMUX_GPIO6__FUNC_GPIO6>;
+			output-high;
+		};
+	};
+
+	disp_pwm1_default_pins: disp-pwm1-default-pins {
+		pins1 {
+			pinmux = <PINMUX_GPIO104__FUNC_DISP_PWM1>;
+		};
+	};
+
+	gpio_key_pins: gpio-keys-pins {
+		pins {
+			pinmux = <PINMUX_GPIO106__FUNC_GPIO106>;
+			bias-pull-up;
+			input-enable;
+		};
+	};
+
+	mt6360_pins: mt6360-pins {
+		pins {
+			pinmux = <PINMUX_GPIO17__FUNC_GPIO17>,
+				 <PINMUX_GPIO128__FUNC_GPIO128>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
+
+	touch_pins: touch-pins {
+		pins-irq {
+			pinmux = <PINMUX_GPIO132__FUNC_GPIO132>;
+			input-enable;
+			bias-disable;
+		};
+
+		pins-reset {
+			pinmux = <PINMUX_GPIO133__FUNC_GPIO133>;
+			output-high;
+		};
+	};
+};
+
+&mt6359_vgpu11_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vpu_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vcore_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vbbck_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vaud18_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vrf12_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vcn33_2_bt_ldo_reg {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+};
+
+/* DEBUG: to remove */
+&mt6359_vibr_ldo_reg {
+	regulator-always-on;
+};
+
+/* For USB Hub */
+&mt6359_vcamio_ldo_reg {
+	regulator-always-on;
+};
+
+&spmi {
+	#address-cells = <2>;
+	#size-cells = <0>;
+
+	mt6315_6: pmic@6 {
+		compatible = "mediatek,mt6315-regulator";
+		reg = <0x6 SPMI_USID>;
+
+		regulators {
+			mt6315_6_vbuck1: vbuck1 {
+				regulator-compatible = "vbuck1";
+				regulator-name = "Vbcpu";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-enable-ramp-delay = <256>;
+				regulator-allowed-modes = <0 1 2>;
+				regulator-always-on;
+			};
+		};
+	};
+
+	mt6315_7: pmic@7 {
+		compatible = "mediatek,mt6315-regulator";
+		reg = <0x7 SPMI_USID>;
+
+		regulators {
+			mt6315_7_vbuck1: vbuck1 {
+				regulator-compatible = "vbuck1";
+				regulator-name = "Vgpu";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-enable-ramp-delay = <256>;
+				regulator-allowed-modes = <0 1 2>;
+			};
+		};
+	};
+};
+
+&dmic_codec {
+	wakeup-delay-ms = <200>;
+};
+
+&mt6359codec {
+	mediatek,mic-type-0 = <1>; /* ACC */
+	mediatek,mic-type-1 = <3>; /* DCC */
+	mediatek,mic-type-2 = <1>; /* ACC */
+};
+
+&mfg0 {
+	domain-supply = <&mt6315_7_vbuck1>;
+};
+
+&pcie0 {
+	pinctrl-names = "default", "idle";
+	pinctrl-0 = <&pcie0_default_pins>;
+	pinctrl-1 = <&pcie0_idle_pins>;
+	status = "okay";
+};
+
+&pcie1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_default_pins>;
+	status = "disabled";
+};
+
+&u3phy1 {
+	status = "okay";
+};
+
+&pciephy {
+	status = "okay";
+};
-- 
2.18.0

