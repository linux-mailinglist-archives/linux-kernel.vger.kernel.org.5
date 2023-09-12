Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4389979CFBD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjILLVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbjILLVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:21:07 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6B21718
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:20:56 -0700 (PDT)
Received: from [192.168.2.137] (bband-dyn191.178-41-225.t-com.sk [178.41.225.191])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 63A462032D;
        Tue, 12 Sep 2023 13:20:54 +0200 (CEST)
From:   Martin Botka <martin.botka@somainline.org>
Date:   Tue, 12 Sep 2023 13:20:49 +0200
Subject: [PATCH v6 3/4] arm64: dts: allwinner: h616: Add BigTreeTech CB1
 SoM & boards support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-b4-cb1-v6-3-bb11238f3a9c@somainline.org>
References: <20230912-b4-cb1-v6-0-bb11238f3a9c@somainline.org>
In-Reply-To: <20230912-b4-cb1-v6-0-bb11238f3a9c@somainline.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin@biqu3d.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rogerio Goncalves <rogerlz@gmail.com>,
        Martin Botka <martin.botka@somainline.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694517652; l=6310;
 i=martin.botka@somainline.org; s=20230811; h=from:subject:message-id;
 bh=hEBsQCNZB94vMroDTHe0Iyohpultft3Y8sTlwSSEmjA=;
 b=95ezKQTN5omCPan0KnyMSKpJIBpoavV6zNNhRUyNXxvOnwM3Gpn3YoJ4yTAbfVzIfoC2lG69T
 e1duxI+T63FBckS/O7FVnGOwdxC7rRVb5C6cFOFclMMpfCN588bV4Km
X-Developer-Key: i=martin.botka@somainline.org; a=ed25519;
 pk=aTCd3jmwU8GrJidWg3DSKLpdVMcpFzXzCSLXLR6NtWU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CB1 is Compute Module style board that plugs into Rpi board style adapter or
Manta 3D printer boards (M4P/M8P).

The SoM features:
  - H616 SoC
  - 1GiB of RAM
  - AXP313A PMIC
  - RTL8189FTV WiFi

Boards feature:
  - 4x USB via USB2 hub (usb1 on SoM).
  - SDcard slot for loading images.
  - Ethernet port wired to the internal PHY. (100M)
  - 2x HDMI 2.0. (Only 1 usable on CB1)
  - Power and Status LEDs. (Only Status LED usable on CB1)
  - 40 pin GPIO header

Currently working:
  - Booting
  - USB
  - UART
  - MMC
  - Status LED
  - WiFi (RTL8189FS via out of tree driver)

I didnt want to duplicate things so the manta DTS can also be used on BTT pi4b adapter.
CB1 SoM has its own DTSI file in case other boards shows up that accept this SoM.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../sun50i-h616-bigtreetech-cb1-manta.dts          |  35 ++++++
 .../dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi | 138 +++++++++++++++++++++
 3 files changed, 174 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 3b0ad5406238..42e525b9d4b9 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -38,6 +38,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-manta.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-orangepi-zero3.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
new file mode 100644
index 000000000000..dbce61b355d6
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (C) 2023 Martin Botka <martin.botka@somainline.org>.
+ */
+
+/dts-v1/;
+
+#include "sun50i-h616-bigtreetech-cb1.dtsi"
+
+/ {
+	model = "BigTreeTech CB1";
+	compatible = "bigtreetech,cb1-manta", "bigtreetech,cb1", "allwinner,sun50i-h616";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
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
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ph_pins>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
new file mode 100644
index 000000000000..1fed2b46cfe8
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (C) 2023 Martin Botka <martin.botka@somainline.org>.
+ */
+
+/dts-v1/;
+
+#include "sun50i-h616.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	aliases {
+		ethernet0 = &rtl8189ftv;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
+		};
+	};
+
+	reg_vcc5v: regulator-vcc5v {
+		/* board wide 5V supply from carrier boards */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	reg_vcc33_wifi: vcc33-wifi {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc33-wifi";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		vin-supply = <&reg_vcc5v>;
+	};
+
+	reg_vcc_wifi_io: vcc-wifi-io {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-wifi-io";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		vin-supply = <&reg_vcc33_wifi>;
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rtc 1>;
+		clock-names = "ext_clock";
+		reset-gpios = <&pio 6 18 GPIO_ACTIVE_LOW>; /* PG18 */
+		post-power-on-delay-ms = <200>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_dldo1>;
+	/* Card detection pin is not connected */
+	broken-cd;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&mmc1 {
+	vmmc-supply = <&reg_vcc33_wifi>;
+	vqmmc-supply = <&reg_vcc_wifi_io>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	mmc-ddr-1_8v;
+	status = "okay";
+
+	rtl8189ftv: wifi@1 {
+		reg = <1>;
+	};
+};
+
+&r_i2c {
+	status = "okay";
+
+	axp313a: pmic@36 {
+		compatible = "x-powers,axp313a";
+		reg = <0x36>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		regulators{
+			reg_dcdc1: dcdc1 {
+				regulator-name = "vdd-gpu-sys";
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <990000>;
+				regulator-always-on;
+			};
+
+			reg_dcdc2: dcdc2 {
+				regulator-name = "vdd-cpu";
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-ramp-delay = <200>;
+				regulator-always-on;
+			};
+
+			reg_dcdc3: dcdc3 {
+				regulator-name = "vcc-dram";
+				regulator-min-microvolt = <1350000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+			};
+
+			reg_aldo1: aldo1 {
+				regulator-name = "vcc-1v8-pll";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			reg_dldo1: dldo1 {
+				regulator-name = "vcc-3v3-io";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&usbphy {
+	status = "okay";
+};

-- 
2.42.0

