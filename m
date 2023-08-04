Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD7776FCDC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjHDJGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjHDJGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:06:13 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FD755A9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biqu3d.com;
        s=tfld2305; t=1691139804;
        bh=dJ3h4qLVIpu1qncR7l8Ehi3Br/d5WZX7tMOrAT26j14=;
        h=From:To:Subject:Date:Message-ID:MIME-Version;
        b=JFiWCpw0dbdC3Podt1gTCJGZZ98dIBaB483u2/9DOuuf9EjqDkyB6/PtonkYFlyF2
         Ni/JxPhYDeRYuIh5o9AsAEiTQjVgGv+9ieBj79y8IkvuMkXrBkvTpWmxjMxKDBm5ak
         DVpGMTEr2azvni3jups/SpxyRVWdd23X//BvQiCk=
X-QQ-mid: bizesmtp65t1691139748tzdhs3pm
Received: from localhost.localdomain ( [178.41.211.221])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 04 Aug 2023 17:02:13 +0800 (CST)
X-QQ-SSF: 01400000000000404000000A0000000
X-QQ-FEAT: LE7C6P2vL8S6FFIfVMvVB6s/vrbXnkeVEzZUihDw00jE+fATrT8Ggybxfz3kw
        zqVVrh3fXrNTmkSWDr0gAs2TCyfqL6plUQWb6AG72RC8qYfAehEYInlPxMrTqUr7peE50Sj
        3TVzMmne1vyx5EU0E4LvxSpLH/BXX9h9gl6ZMTsvwRmIdL8mvOPDkY/hn1DEkoUXzIPEKU5
        KA/gv9tPh79S39yrL+F3elCY7x0awN0hgqrteWVrOv7rNsNFBFctPp2GM+VHEnvzc9pBiFB
        ycwcNUkRvyHyb1ZxdCfQEomXuUCn7s05wdbDqerRVfnD5Jm2jr9VongIZ4SihGh3aunoQNx
        W+l5og7hFdI6FwWgYl66I5MHCyxZ1lsrce9ObtcqHDz5EZKyXoitVn28htgBtjiVGEiFNMc
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14703739668246563900
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
        Icenowy Zheng <uwu@icenowy.me>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: dts: allwinner: h616: Add BigTreeTech CB1 SoM & boards support
Date:   Fri,  4 Aug 2023 11:00:31 +0200
Message-ID: <3DE536B6217490F4+20230804090102.273029-4-martin@biqu3d.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804090102.273029-1-martin@biqu3d.com>
References: <20230804090102.273029-1-martin@biqu3d.com>
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
  - USB (USB-OTG doesnt work)
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

 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../sun50i-h616-bigtreetech-cb1-manta.dts     |  35 +++++
 .../sun50i-h616-bigtreetech-cb1.dtsi          | 142 ++++++++++++++++++
 3 files changed, 178 insertions(+)
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
index 000000000000..9a30d7d627d9
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
+	compatible = "bigtreetech,cb1-manta", "allwinner,sun50i-h616";
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
+
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
new file mode 100644
index 000000000000..669c05f642dd
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
@@ -0,0 +1,142 @@
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
+	model = "BigTreeTech CB1"
+
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

