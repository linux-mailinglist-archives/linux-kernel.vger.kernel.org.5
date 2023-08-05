Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDD2770EDD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 10:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjHEIj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 04:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjHEIjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 04:39:23 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C5349FE
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 01:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biqu3d.com;
        s=tfld2305; t=1691224731;
        bh=OYlAYqyQDEk/9cm0cZir0GxwuOh4c/Vk4E3QDe4ncZU=;
        h=From:To:Subject:Date:Message-ID:MIME-Version;
        b=YBg7ZkXoPuNlx3dlet0A3/sofM3T6EMIEWlH23JY+OlN4QSQr2sbvGX2bUt7J4Af2
         LBOXbHeTm+AGezeOxnOehq1T1HGQ3g9aBL+mvH/hGwEJ1LgbWT2mOA0nSYP9k7CCIf
         oonWnPUhh25YniFg0+QLclw1RtCA2OTUD7tDCxDY=
X-QQ-mid: bizesmtp83t1691224685td205ul5
Received: from localhost.localdomain ( [178.41.211.221])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 05 Aug 2023 16:37:50 +0800 (CST)
X-QQ-SSF: 01400000000000505000000A0000000
X-QQ-FEAT: Js1xXDonPB5xjgtPoIQKPR26QaIENFdZYTFCChIWqNQlt3C0lbsyOXeXasEVs
        TG7p5YfxVS+P5iR5Gx8gny0kbgoQGPNuRjZezSrL0h/W/b8m8hLUnfN4CagcBcVEPxq/R5D
        juVpSH63DhPVjoxCETyc5lzJyAQMnwa7G/AaorrEMgj5hO02S5q2L+Z7wGXMv6CbOJMxLoH
        BgPxlVqHj1njY7eBPquBTMYbtBM/YmHVAZjZJ/W+rws2VVSMcpDBYVxr7P/2oIFutJqELeA
        8FiRPfggC6GW/t/y1aXdgYpdde3opYXazHs5Hiy/ea7sXIFmWSiJIv9RmcuWBI001vv+Xvg
        lceuqWH5HWCbQE4AFWaqowT3j9Govsic8PfkFhC7/3QTNNch/lvyEfngzVccw6WbwNJ/KxT
        inVd43XATxQ=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2455430870295959161
From:   Martin Botka <martin@biqu3d.com>
To:     martin.botka1@gmail.com
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Andrew Lunn <andrew@lunn.ch>, Icenowy Zheng <uwu@icenowy.me>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] arm64: dts: allwinner: h616: Add BigTreeTech CB1 SoM & boards support
Date:   Sat,  5 Aug 2023 10:36:06 +0200
Message-ID: <F7AE26E278753D75+20230805083636.788048-4-martin@biqu3d.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230805083636.788048-1-martin@biqu3d.com>
References: <20230805083636.788048-1-martin@biqu3d.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:biqu3d.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Botka <martin.botka@somainline.org>

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
---
Changes in V2:
    - Fixed whitespace errors
    - Move UART into carrier boards and BTT Pi
    - Remove usb1-vbus regulator
    - Fix ranges and naming of AXP313A rails
    - Add comment specifying why broken-cd in mmc0 is needed
    - Rename sdio_wifi to wifi
    - Specify in commit description that USB-OTG doesnt work
Changes in V3:
    - Add missed semicolons
    - Move model string from dtsi to board dts
    - Add cb1 compatible
    - Remove extra empty line

 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../sun50i-h616-bigtreetech-cb1-manta.dts     |  35 +++++
 .../sun50i-h616-bigtreetech-cb1.dtsi          | 140 ++++++++++++++++++
 3 files changed, 176 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 6a96494a2e0a..7b386428510b 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -38,5 +38,6 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-manta.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
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
index 000000000000..5f606fcce97c
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
@@ -0,0 +1,140 @@
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
+		/* Always on 3.3V regulator for WiFi */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc33-wifi";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		vin-supply = <&reg_vcc5v>;
+	};
+
+	reg_vcc_wifi_io: vcc-wifi-io {
+		/* Always on 1.8V/300mA regulator for WiFi */
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
+				regulator-max-microvolt = <1350000>;
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
2.41.0

