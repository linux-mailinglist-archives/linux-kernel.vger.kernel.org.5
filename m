Return-Path: <linux-kernel+bounces-51083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EF6848642
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34B11F275A9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 12:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA525EE71;
	Sat,  3 Feb 2024 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZH1dwoNF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AC15DF37;
	Sat,  3 Feb 2024 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963887; cv=none; b=DZivfHzCLz8PUtaYZ16i9P62U73s5L5ZUnwNtqq7/jhGcq1FthmdWOb/TgWau1xjqLEF1aCqr+8JE1Kr0wvbajkIJUE+ZQOWtS+/sKvPFDIaPyM5zssRqNiyY3WNgm3n24LXg3vKhjuzoA4Wy848whruDKdjcNw/hL6vROt1Dpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963887; c=relaxed/simple;
	bh=YMh9c4cIpq0VJ/3C0/VF+2qLQSb+Y9f+U6jF6pNe5lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGFJbA0tAJfAUcdvriQ2pLAfqzOeNU25sdGSCI06xE2kM3Kp+eSsxWfKbcaR3aMRp2MxkEMQ4MQjRGSVJ6ZQMadg2WJrSXw9Rvxn38XYr0YTmiVyRDcpV2haeDnjIAwVrHEfgIblBHiJO96Es/W5WkN64EEwTTVSolI+InQ4I/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZH1dwoNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41656C433C7;
	Sat,  3 Feb 2024 12:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963886;
	bh=YMh9c4cIpq0VJ/3C0/VF+2qLQSb+Y9f+U6jF6pNe5lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZH1dwoNFXfMOmlCbwpwvKvfAOkuWe4QL2I4J4MVKZKdQwBf0p5IOJ9vCVH30HPip5
	 fK3ucehDS5jKML9QVMOci4pLQZrnD+aFHn4xE1auMofQqNS3bS1XtzJDyZWlhQ3jwQ
	 mme7cOOogHZYHcf7uTu04+Zkh6F9k9cWl8R9Vop7oHlwzHAzf9XnudMdETvI1QpLa8
	 nmUCMYJ8EJbAd7eb2Ze3eibJxxOGJNsM7H/Wn3OFnSsYhNLDyxb3g4QkKMWGR5hMTI
	 ZWcLtRLoOrgcCkKqInXsocM63GLwLG2Casss58+Co0Ha3hieE6jY2UqLx4v6Mr0NZb
	 wasYQ/Q+LNK8g==
From: Jisheng Zhang <jszhang@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: allwinner: h616: Add Sipeed Longan SoM 3H and Pi 3H board support
Date: Sat,  3 Feb 2024 20:25:01 +0800
Message-ID: <20240203122502.1259-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203122502.1259-1-jszhang@kernel.org>
References: <20240203122502.1259-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Sipeed Longan SoM 3H is a system on module based on the Allwinner
H618 SoC. The SoM features:

- Four ARM Cortex-A53 cores, Mali-G31 MP2 GPU
- 2/4 GiB LPDDR4 DRAM SoMs
- AXP313a PMIC
- eMMC

The Sipeed Longan PI 3H is a development board based on the above SoM.
The board features:
- Longan SoM 3H
- Raspberry-Pi-1 compatible GPIO header
- 2 USB 2.0 host port
- 1 USB 2.0 type C port (power supply + OTG)
- MicroSD slot
- 1Gbps Ethernet port (via RTL8211 PHY)
- HDMI port
- WiFi/BT chip

Add the devicetree file describing the currently supported features,
namely PMIC, LEDs, UART, SD card, eMMC, USB and Ethernet.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../sun50i-h618-longan-module-3h.dtsi         |  77 ++++++++++
 .../dts/allwinner/sun50i-h618-longanpi-3h.dts | 143 ++++++++++++++++++
 3 files changed, 221 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 91d505b385de..4b9173a16efe 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -42,5 +42,6 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-manta.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-pi.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-longanpi-3h.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-orangepi-zero3.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-transpeed-8k618-t.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
new file mode 100644
index 000000000000..5f0f48cf4f01
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include "sun50i-h616.dtsi"
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+	vmmc-supply = <&reg_dldo1>;
+	vqmmc-supply = <&reg_aldo1>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	status = "okay";
+};
+
+&r_i2c {
+	status = "okay";
+
+	axp313: pmic@36 {
+		compatible = "x-powers,axp313a";
+		reg = <0x36>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		interrupt-parent = <&pio>;
+		interrupts = <3 11 IRQ_TYPE_LEVEL_LOW>;	/* PD11 */
+
+		regulators {
+			reg_aldo1: aldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-1v8-pll";
+			};
+
+			reg_dldo1: dldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-3v3-io";
+			};
+
+			reg_dcdc1: dcdc1 {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <990000>;
+				regulator-name = "vdd-gpu-sys";
+			};
+
+			reg_dcdc2: dcdc2 {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-cpu";
+			};
+
+			reg_dcdc3: dcdc3 {
+				regulator-always-on;
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-dram";
+			};
+		};
+	};
+};
+
+&pio {
+	vcc-pc-supply = <&reg_dldo1>;
+	vcc-pf-supply = <&reg_dldo1>;
+	vcc-pg-supply = <&reg_aldo1>;
+	vcc-ph-supply = <&reg_dldo1>;
+	vcc-pi-supply = <&reg_dldo1>;
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts
new file mode 100644
index 000000000000..08d3ad7114fb
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) Jisheng Zhang <jszhang@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "sun50i-h618-longan-module-3h.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "Sipeed Longan Pi 3H";
+	compatible = "sipeed,longan-pi-3h", "sipeed,longan-module-3h", "allwinner,sun50i-h618";
+
+	aliases {
+		ethernet0 = &emac0;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_ORANGE>;
+			function = LED_FUNCTION_INDICATOR;
+			function-enumerator = <0>;
+			gpios = <&pio 6 2 GPIO_ACTIVE_LOW>; /* PG2 */
+		};
+
+		led-1 {
+			color = <LED_COLOR_ID_ORANGE>;
+			function = LED_FUNCTION_INDICATOR;
+			function-enumerator = <1>;
+			gpios = <&pio 6 4 GPIO_ACTIVE_LOW>; /* PG4 */
+		};
+	};
+
+	reg_vcc5v: regulator-vcc5v {
+		/* board wide 5V supply directly from the USB-C socket */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	reg_vcc3v3: regulator-vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-3v3";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+};
+
+&axp313 {
+	vin1-supply = <&reg_vcc5v>;
+	vin2-supply = <&reg_vcc5v>;
+	vin3-supply = <&reg_vcc5v>;
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+/* WiFi & BT combo module is connected to this Host */
+&ehci3 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
+
+&emac0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ext_rgmii_pins>;
+	phy-mode = "rgmii";
+	phy-handle = <&ext_rgmii_phy>;
+	allwinner,rx-delay-ps = <3100>;
+	allwinner,tx-delay-ps = <700>;
+	phy-supply = <&reg_vcc3v3>;
+	status = "okay";
+};
+
+&mdio0 {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
+
+&mmc0 {
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;	/* PF6 */
+	vmmc-supply = <&reg_vcc3v3>;
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usbotg {
+	/*
+	 * PHY0 pins are connected to a USB-C socket, but a role switch
+	 * is not implemented: both CC pins are pulled to GND.
+	 * The VBUS pins power the device, so a fixed peripheral mode
+	 * is the best choice.
+	 * The board can be powered via GPIOs, in this case port0 *can*
+	 * act as a host (with a cable/adapter ignoring CC), as VBUS is
+	 * then provided by the GPIOs. Any user of this setup would
+	 * need to adjust the DT accordingly: dr_mode set to "host",
+	 * enabling OHCI0 and EHCI0.
+	 */
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_vcc5v>;
+	usb2_vbus-supply = <&reg_vcc5v>;
+	status = "okay";
+};
-- 
2.43.0


