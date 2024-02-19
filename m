Return-Path: <linux-kernel+bounces-70957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AE7859EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76D71C217E0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F0125611;
	Mon, 19 Feb 2024 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRfRc75U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E3425571;
	Mon, 19 Feb 2024 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332343; cv=none; b=ET3gEd+mMqGkLED3652o82d4e36CryEDue6DpHm/+ZTaT4wDUEP3/5D03uRCE36yFXZSVext/yEmpzcZTPKtGONssgUX5wFPF0ihsNIszuq+rPtOgwsVbbO2kOyVYXLXssCAaAkSjSUQbxG1BkxNb3Jz9vM2SJI7l9RjjLWH0hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332343; c=relaxed/simple;
	bh=nxfYJ05fduxv5KaPx43iXJzQm2ZNCd1Eh+3FJ0WvxD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GCzDxlQyW9YHCM/826DUm/HUjMr3nvFNuAT+C+RB7HlEaY5O1Jl06phYCPyHGe+3am7gtV44bZ9ztUnoQLZ3x7U/XxBQJidxxBTFtVQADaL/rnaJZEKHrtMyS6C+LugjoK8kv/PfJHcL+qjRZu1yTCx3Puz7n6u43x0O+Y7NbII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRfRc75U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560E5C43390;
	Mon, 19 Feb 2024 08:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708332342;
	bh=nxfYJ05fduxv5KaPx43iXJzQm2ZNCd1Eh+3FJ0WvxD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRfRc75UbzPNARJf7UQ797RjGhcCxx5hxeoDttSr6JW3VL6stf2184jZ66d3RTOF7
	 tpNXZ6An31/RDg/eIQrvckVkS+pSScPZyK8o+Ql10ZpIibJKLMbXk6KdsEJN2Vc3b1
	 SJEW2oq4VLeeOwf+p32rv91pcjcRBKRJtY5k5PnWzJd6cLMqqV+6ISCeBj1u1QBv3p
	 zVVVEOpe9VtKmbZ9lKNcS7Lq7bNWG/V7f6G0NkFHU5Fu7I4Xet3r9oLwtutLR8YQCZ
	 W0d9h5U/cTGZHHyyFZ8NHfcGBd/M3fqSg0725maxD+7mgks5Xjy/wNY661ChcXfFF3
	 U8nV+GKiAXHOQ==
From: Michael Walle <mwalle@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 2/2] arm64: dts: mediatek: add Kontron 3.5"-SBC-i1200
Date: Mon, 19 Feb 2024 09:44:56 +0100
Message-Id: <20240219084456.1075445-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219084456.1075445-1-mwalle@kernel.org>
References: <20240219084456.1075445-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic support for the Kontron 3.5" single board computer featuring a
Mediatek i1200 SoC (MT8395/MT8195).

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
v2:
 - none

 arch/arm64/boot/dts/mediatek/Makefile         |    1 +
 .../mediatek/mt8395-kontron-3-5-sbc-i1200.dts | 1091 +++++++++++++++++
 2 files changed, 1092 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 37b4ca3a87c9..697b6b5de3cb 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -76,5 +76,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-demo.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-kontron-3-5-sbc-i1200.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-radxa-nio-12l.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts b/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
new file mode 100644
index 000000000000..0c634bc8776c
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
@@ -0,0 +1,1091 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2024 Kontron Europe GmbH
+ *
+ * Author: Michael Walle <mwalle@kernel.org>
+ */
+/dts-v1/;
+
+#include "mt8195.dtsi"
+#include "mt6359.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/mt8195-pinfunc.h>
+#include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	model = "Kontron 3.5\"-SBC-i1200";
+	compatible = "kontron,3-5-sbc-i1200", "mediatek,mt8395", "mediatek,mt8195";
+
+	aliases {
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys_pins>;
+
+		key-0 {
+			gpios = <&pio 106 GPIO_ACTIVE_LOW>;
+			label = "volume_up";
+			linux,code = <KEY_VOLUMEUP>;
+			wakeup-source;
+			debounce-interval = <15>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins>;
+
+		led-0 {
+			gpios = <&pio 107 GPIO_ACTIVE_HIGH>;
+			default-state = "keep";
+			function = LED_FUNCTION_POWER;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0x0 0x80000000>;
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
+	thermal_sensor0: thermal-sensor-0 {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		io-channels = <&auxadc 0>;
+		io-channel-names = "sensor-channel";
+		temperature-lookup-table = <(-25000) 1474
+					    (-20000) 1374
+					    (-15000) 1260
+					    (-10000) 1134
+					     (-5000) 1004
+						   0 874
+						5000 750
+					       10000 635
+					       15000 532
+					       20000 443
+					       25000 367
+					       30000 303
+					       35000 250
+					       40000 206
+					       45000 170
+					       50000 141
+					       55000 117
+					       60000 97
+					       65000 81
+					       70000 68
+					       75000 57
+					       80000 48
+					       85000 41
+					       90000 35
+					       95000 30
+					      100000 25
+					      105000 22
+					      110000 19
+					      115000 16
+					      120000 14
+					      125000 12
+					      130000 10
+					      135000 9
+					      140000 8
+					      145000 7
+					      150000 6>;
+	};
+
+	thermal_sensor1: thermal-sensor-1 {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		io-channels = <&auxadc 1>;
+		io-channel-names = "sensor-channel";
+		temperature-lookup-table = <(-25000) 1474
+					    (-20000) 1374
+					    (-15000) 1260
+					    (-10000) 1134
+					     (-5000) 1004
+						   0 874
+						5000 750
+					       10000 635
+					       15000 532
+					       20000 443
+					       25000 367
+					       30000 303
+					       35000 250
+					       40000 206
+					       45000 170
+					       50000 141
+					       55000 117
+					       60000 97
+					       65000 81
+					       70000 68
+					       75000 57
+					       80000 48
+					       85000 41
+					       90000 35
+					       95000 30
+					      100000 25
+					      105000 22
+					      110000 19
+					      115000 16
+					      120000 14
+					      125000 12
+					      130000 10
+					      135000 9
+					      140000 8
+					      145000 7
+					      150000 6>;
+	};
+
+	thermal_sensor2: thermal-sensor-2 {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		io-channels = <&auxadc 2>;
+		io-channel-names = "sensor-channel";
+		temperature-lookup-table = <(-25000) 1474
+					    (-20000) 1374
+					    (-15000) 1260
+					    (-10000) 1134
+					     (-5000) 1004
+						   0 874
+						5000 750
+					       10000 635
+					       15000 532
+					       20000 443
+					       25000 367
+					       30000 303
+					       35000 250
+					       40000 206
+					       45000 170
+					       50000 141
+					       55000 117
+					       60000 97
+					       65000 81
+					       70000 68
+					       75000 57
+					       80000 48
+					       85000 41
+					       90000 35
+					       95000 30
+					      100000 25
+					      105000 22
+					      110000 19
+					      115000 16
+					      120000 14
+					      125000 12
+					      130000 10
+					      135000 9
+					      140000 8
+					      145000 7
+					      150000 6>;
+	};
+};
+
+&auxadc {
+	status = "okay";
+};
+
+&eth {
+	phy-mode ="rgmii-id";
+	phy-handle = <&ethernet_phy0>;
+	snps,reset-gpio = <&pio 93 GPIO_ACTIVE_HIGH>;
+	snps,reset-delays-us = <0 10000 80000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&eth_default_pins>;
+	pinctrl-1 = <&eth_sleep_pins>;
+	status = "okay";
+
+	mdio {
+		ethernet_phy0: ethernet-phy@1 {
+			reg = <0x1>;
+			interrupts-extended = <&pio 94 IRQ_TYPE_LEVEL_LOW>;
+		};
+	};
+};
+
+&gpu {
+	status = "okay";
+	mali-supply = <&mt6315_7_vbuck1>;
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-0 = <&i2c4_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&i2c6 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&i2c6_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	mt6360: pmic@34 {
+		compatible = "mediatek,mt6360";
+		reg = <0x34>;
+		interrupt-controller;
+		interrupts-extended = <&pio 101 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-names = "IRQB";
+
+		charger {
+			compatible = "mediatek,mt6360-chg";
+			richtek,vinovp-microvolt = <14500000>;
+
+			otg_vbus_regulator: usb-otg-vbus-regulator {
+				regulator-compatible = "usb-otg-vbus";
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
+				regulator-compatible = "BUCK1";
+				regulator-name = "mt6360,buck1";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP
+							   MT6360_OPMODE_ULP>;
+				regulator-always-on;
+			};
+
+			mt6360_buck2: buck2 {
+				regulator-compatible = "BUCK2";
+				regulator-name = "mt6360,buck2";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP
+							   MT6360_OPMODE_ULP>;
+				regulator-always-on;
+			};
+
+			mt6360_ldo1: ldo1 {
+				regulator-compatible = "LDO1";
+				regulator-name = "mt6360,ldo1";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+			};
+
+			mt6360_ldo2: ldo2 {
+				regulator-compatible = "LDO2";
+				regulator-name = "mt6360,ldo2";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+			};
+
+			mt6360_ldo3: ldo3 {
+				regulator-compatible = "LDO3";
+				regulator-name = "mt6360,ldo3";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+			};
+
+			mt6360_ldo5: ldo5 {
+				regulator-compatible = "LDO5";
+				regulator-name = "mt6360,ldo5";
+				regulator-min-microvolt = <2700000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+			};
+
+			mt6360_ldo6: ldo6 {
+				regulator-compatible = "LDO6";
+				regulator-name = "mt6360,ldo6";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <2100000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+			};
+
+			mt6360_ldo7: ldo7 {
+				regulator-compatible = "LDO7";
+				regulator-name = "mt6360,ldo7";
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
+&mmc0 {
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
+	status = "okay";
+};
+
+&mmc1 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc1_default_pins>;
+	pinctrl-1 = <&mmc1_uhs_pins>;
+	cd-gpios = <&pio 129 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	max-frequency = <200000000>;
+	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	vmmc-supply = <&mt6360_ldo5>;
+	vqmmc-supply = <&mt6360_ldo3>;
+	status = "okay";
+};
+
+&mt6359_vbbck_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vcore_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vgpu11_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vproc1_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vproc2_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vpu_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vrf12_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vsram_md_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vsram_others_ldo_reg {
+	regulator-always-on;
+};
+
+&nor_flash {
+	pinctrl-names = "default";
+	pinctrl-0 = <&nor_pins_default>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <52000000>;
+		spi-rx-bus-width = <2>;
+		spi-tx-bus-width = <2>;
+	};
+};
+
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_pins_default>;
+	status = "okay";
+};
+
+&pcie1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_pins_default>;
+	status = "okay";
+};
+
+&pciephy {
+	status = "okay";
+};
+
+&pio {
+	eth_default_pins: eth-default-pins {
+		pins-txd {
+			pinmux = <PINMUX_GPIO77__FUNC_GBE_TXD3>,
+				 <PINMUX_GPIO78__FUNC_GBE_TXD2>,
+				 <PINMUX_GPIO79__FUNC_GBE_TXD1>,
+				 <PINMUX_GPIO80__FUNC_GBE_TXD0>;
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
+		pins-cc {
+			pinmux = <PINMUX_GPIO85__FUNC_GBE_TXC>,
+				 <PINMUX_GPIO86__FUNC_GBE_RXC>,
+				 <PINMUX_GPIO87__FUNC_GBE_RXDV>,
+				 <PINMUX_GPIO88__FUNC_GBE_TXEN>;
+			drive-strength = <MTK_DRIVE_8mA>;
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
+
+		pins-reset {
+			pinmux = <PINMUX_GPIO93__FUNC_GPIO93>;
+			output-high;
+		};
+
+		pins-interrupt {
+			pinmux = <PINMUX_GPIO94__FUNC_GPIO94>;
+			input-enable;
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
+		pins-cc {
+			pinmux = <PINMUX_GPIO85__FUNC_GPIO85>,
+				 <PINMUX_GPIO88__FUNC_GPIO88>,
+				 <PINMUX_GPIO87__FUNC_GPIO87>,
+				 <PINMUX_GPIO86__FUNC_GPIO86>;
+		};
+		pins-rxd {
+			pinmux = <PINMUX_GPIO81__FUNC_GPIO81>,
+				 <PINMUX_GPIO82__FUNC_GPIO82>,
+				 <PINMUX_GPIO83__FUNC_GPIO83>,
+				 <PINMUX_GPIO84__FUNC_GPIO84>;
+		};
+		pins-mdio {
+			pinmux = <PINMUX_GPIO89__FUNC_GPIO89>,
+				 <PINMUX_GPIO90__FUNC_GPIO90>;
+			input-disable;
+			bias-disable;
+		};
+	};
+
+	gpio_keys_pins: gpio-keys-pins {
+		pins {
+			pinmux = <PINMUX_GPIO106__FUNC_GPIO106>;
+			input-enable;
+		};
+	};
+
+	i2c2_pins: i2c2-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO12__FUNC_SDA2>,
+				 <PINMUX_GPIO13__FUNC_SCL2>;
+			bias-pull-up;
+		};
+	};
+
+	i2c3_pins: i2c3-pins {
+		pins {
+			pinmux = <PINMUX_GPIO14__FUNC_SDA3>,
+				 <PINMUX_GPIO15__FUNC_SCL3>;
+			bias-pull-up;
+		};
+	};
+
+	i2c4_pins: i2c4-pins {
+		pins {
+			pinmux = <PINMUX_GPIO16__FUNC_SDA4>,
+				 <PINMUX_GPIO17__FUNC_SCL4>;
+			bias-pull-up;
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
+
+		pins-insert {
+			pinmux = <PINMUX_GPIO129__FUNC_GPIO129>;
+			bias-pull-up;
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
+	nor_pins_default: nor-default-pins {
+		pins-ck-io {
+			pinmux = <PINMUX_GPIO142__FUNC_SPINOR_IO0>,
+				 <PINMUX_GPIO141__FUNC_SPINOR_CK>,
+				 <PINMUX_GPIO143__FUNC_SPINOR_IO1>;
+			drive-strength = <6>;
+			bias-pull-down;
+		};
+
+		pins-cs {
+			pinmux = <PINMUX_GPIO140__FUNC_SPINOR_CS>;
+			drive-strength = <6>;
+			bias-pull-up;
+		};
+	};
+
+	pcie0_pins_default: pcie0-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO19__FUNC_WAKEN>,
+				 <PINMUX_GPIO20__FUNC_PERSTN>,
+				 <PINMUX_GPIO21__FUNC_CLKREQN>;
+			bias-pull-up;
+		};
+	};
+
+	pcie1_pins_default: pcie1-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO0__FUNC_PERSTN_1>,
+				 <PINMUX_GPIO1__FUNC_CLKREQN_1>,
+				 <PINMUX_GPIO2__FUNC_WAKEN_1>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	led_pins: led-pins {
+		pins-power-en {
+			pinmux = <PINMUX_GPIO107__FUNC_GPIO107>;
+			output-high;
+		};
+	};
+
+	spi0_pins: spi0-default-pins {
+		pins-cs-mosi-clk {
+			pinmux = <PINMUX_GPIO132__FUNC_SPIM0_CSB>,
+				 <PINMUX_GPIO134__FUNC_SPIM0_MO>,
+				 <PINMUX_GPIO133__FUNC_SPIM0_CLK>;
+			bias-disable;
+		};
+
+		pins-miso {
+			pinmux = <PINMUX_GPIO135__FUNC_SPIM0_MI>;
+			bias-pull-down;
+		};
+	};
+
+	spi1_pins: spi1-default-pins {
+		pins-cs-mosi-clk {
+			pinmux = <PINMUX_GPIO136__FUNC_SPIM1_CSB>,
+				 <PINMUX_GPIO138__FUNC_SPIM1_MO>,
+				 <PINMUX_GPIO137__FUNC_SPIM1_CLK>;
+			bias-disable;
+		};
+
+		pins-miso {
+			pinmux = <PINMUX_GPIO139__FUNC_SPIM1_MI>;
+			bias-pull-down;
+		};
+	};
+
+	uart0_pins: uart0-pins {
+		pins_rx {
+			pinmux = <PINMUX_GPIO99__FUNC_URXD0>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins_tx {
+			pinmux = <PINMUX_GPIO98__FUNC_UTXD0>;
+		};
+	};
+
+	uart1_pins: uart1-pins {
+		pins_rx {
+			pinmux = <PINMUX_GPIO103__FUNC_URXD1>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins_tx {
+			pinmux = <PINMUX_GPIO102__FUNC_UTXD1>;
+		};
+
+		pins_rts {
+			pinmux = <PINMUX_GPIO100__FUNC_URTS1>;
+			output-enable;
+		};
+
+		pins_cts {
+			pinmux = <PINMUX_GPIO101__FUNC_UCTS1>;
+			input-enable;
+		};
+	};
+
+	uart2_pins: uart2-pins {
+		pins_rx {
+			pinmux = <PINMUX_GPIO68__FUNC_URXD2>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins_tx {
+			pinmux = <PINMUX_GPIO67__FUNC_UTXD2>;
+		};
+
+		pins_rts {
+			pinmux = <PINMUX_GPIO66__FUNC_URTS2>;
+			output-enable;
+		};
+
+		pins_cts {
+			pinmux = <PINMUX_GPIO65__FUNC_UCTS2>;
+			input-enable;
+		};
+	};
+
+	uart3_pins: uart3-pins {
+		pins_rx {
+			pinmux = <PINMUX_GPIO5__FUNC_URXD3>;
+			input-enable;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins_tx {
+			pinmux = <PINMUX_GPIO4__FUNC_UTXD3>;
+		};
+	};
+
+	uart4_pins: uart4-pins {
+		pins_rx {
+			pinmux = <PINMUX_GPIO7__FUNC_URXD4>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins_tx {
+			pinmux = <PINMUX_GPIO6__FUNC_UTXD4>;
+		};
+	};
+};
+
+&pmic {
+	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&scp {
+	memory-region = <&scp_mem>;
+	status = "okay";
+};
+
+&spmi {
+	#address-cells = <2>;
+	#size-cells = <0>;
+
+	mt6315@6 {
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
+				regulator-ramp-delay = <6250>;
+				regulator-allowed-modes = <0 1 2>;
+				regulator-always-on;
+			};
+		};
+	};
+
+	mt6315@7 {
+		compatible = "mediatek,mt6315-regulator";
+		reg = <0x7 SPMI_USID>;
+
+		regulators {
+			mt6315_7_vbuck1: vbuck1 {
+				regulator-compatible = "vbuck1";
+				regulator-name = "Vgpu";
+				regulator-min-microvolt = <625000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-enable-ramp-delay = <256>;
+				regulator-ramp-delay = <6250>;
+				regulator-allowed-modes = <0 1 2>;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>;
+	mediatek,pad-select = <0>;
+	status = "okay";
+
+	tpm: tpm@0 {
+		compatible = "infineon,slb9670";
+		reg = <0>;
+		spi-max-frequency = <18500000>;
+	};
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins>;
+	mediatek,pad-select = <0>;
+	status = "okay";
+};
+
+&thermal_zones {
+	board0-thermal {
+		polling-delay = <1000>; /* milliseconds */
+		polling-delay-passive = <0>; /* milliseconds */
+		thermal-sensors = <&thermal_sensor0>;
+
+		trips {
+			trip-alert {
+				temperature = <85000>;
+				hysteresis = <2000>;
+				type = "passive";
+			};
+
+			trip-crit {
+				temperature = <95000>;
+				hysteresis = <2000>;
+				type = "critical";
+			};
+		};
+	};
+
+	board1-thermal {
+		polling-delay = <1000>; /* milliseconds */
+		polling-delay-passive = <0>; /* milliseconds */
+		thermal-sensors = <&thermal_sensor1>;
+
+		trips {
+			trip-alert {
+				temperature = <75000>;
+				hysteresis = <2000>;
+				type = "passive";
+			};
+
+			trip-crit {
+				temperature = <85000>;
+				hysteresis = <2000>;
+				type = "critical";
+			};
+		};
+	};
+
+	board2-thermal {
+		polling-delay = <1000>; /* milliseconds */
+		polling-delay-passive = <0>; /* milliseconds */
+		thermal-sensors = <&thermal_sensor2>;
+
+		trips {
+			trip-alert {
+				temperature = <75000>;
+				hysteresis = <2000>;
+				type = "passive";
+			};
+
+			trip-crit {
+				temperature = <85000>;
+				hysteresis = <2000>;
+				type = "critical";
+			};
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart4_pins>;
+	status = "okay";
+};
+
+/* USB3 */
+&u3phy0 {
+	status = "okay";
+};
+
+/* PCIe1/USB2 */
+&u3phy1 {
+	status = "okay";
+};
+
+/* USB2 */
+&u3phy2 {
+	status = "okay";
+};
+
+/* USB2 */
+&u3phy3 {
+	status = "okay";
+};
+
+/* USB3 front port */
+&xhci0 {
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	vbus-supply = <&otg_vbus_regulator>;
+	status = "okay";
+};
+
+/* USB2 M.2 Key-B */
+&xhci1 {
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	mediatek,u3p-dis-msk = <0x01>;
+	status = "okay";
+};
+
+/* USB2 M.2 Key-E */
+&xhci2 {
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	status = "okay";
+};
+
+/* USB2 to on-board usb hub */
+&xhci3 {
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	status = "okay";
+};
-- 
2.39.2


