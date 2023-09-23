Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C3C7ABF25
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjIWJCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjIWJCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:02:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72071B5;
        Sat, 23 Sep 2023 02:01:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9BAC433C8;
        Sat, 23 Sep 2023 09:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695459702;
        bh=YrWP+GPMeevlH8szeS4otMcb33Kp4nSLx+RVEJDxGY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tykd7OVEUs1ztLVdQ2/rebZKMnfb3n5YboUWIx8OvyzFK3pyn3A/mAdpnyMViOjGj
         O8lnwkpTS++eCX5WBuSEKt9g/qQWuysbz+jtlwIQ5sln+wX4qKEb9kUMtacdfyaYPE
         A3r5CQV5RJiUH1c0JOOEq7aw4QoxjUrHeQzYPn0E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.295
Date:   Sat, 23 Sep 2023 11:01:30 +0200
Message-ID: <2023092330-anatomy-cornfield-e1c1@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023092329-relive-distort-435a@gregkh>
References: <2023092329-relive-distort-435a@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 4f8f98c7227a..6eb08388fa15 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 294
+SUBLEVEL = 295
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
index 74c83b0ca54e..bb7dc00a71e0 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
@@ -48,3 +48,16 @@
 		};
 	};
 };
+
+&gmac0 {
+	phy-mode = "rgmii";
+	phy-handle = <&bcm54210e>;
+
+	mdio {
+		/delete-node/ switch@1e;
+
+		bcm54210e: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
index 214df18f3a75..6561e3b81b60 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
@@ -85,3 +85,16 @@
 		};
 	};
 };
+
+&gmac0 {
+	phy-mode = "rgmii";
+	phy-handle = <&bcm54210e>;
+
+	mdio {
+		/delete-node/ switch@1e;
+
+		bcm54210e: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index a6406a347690..c331217ce21b 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -260,7 +260,7 @@
 
 			interrupt-parent = <&gic>;
 
-			ehci: ehci@21000 {
+			ehci: usb@21000 {
 				#usb-cells = <0>;
 
 				compatible = "generic-ehci";
@@ -282,7 +282,7 @@
 				};
 			};
 
-			ohci: ohci@22000 {
+			ohci: usb@22000 {
 				#usb-cells = <0>;
 
 				compatible = "generic-ohci";
diff --git a/arch/arm/boot/dts/bcm53573.dtsi b/arch/arm/boot/dts/bcm53573.dtsi
index 453a2a37dabd..e44694800052 100644
--- a/arch/arm/boot/dts/bcm53573.dtsi
+++ b/arch/arm/boot/dts/bcm53573.dtsi
@@ -127,6 +127,9 @@
 
 		pcie0: pcie@2000 {
 			reg = <0x00002000 0x1000>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
 		};
 
 		usb2: usb2@4000 {
@@ -135,7 +138,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			ehci: ehci@4000 {
+			ehci: usb@4000 {
 				compatible = "generic-ehci";
 				reg = <0x4000 0x1000>;
 				interrupt-parent = <&gic>;
@@ -155,9 +158,7 @@
 				};
 			};
 
-			ohci: ohci@d000 {
-				#usb-cells = <0>;
-
+			ohci: usb@d000 {
 				compatible = "generic-ohci";
 				reg = <0xd000 0x1000>;
 				interrupt-parent = <&gic>;
@@ -180,6 +181,24 @@
 
 		gmac0: ethernet@5000 {
 			reg = <0x5000 0x1000>;
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				switch: switch@1e {
+					compatible = "brcm,bcm53125";
+					reg = <0x1e>;
+
+					status = "disabled";
+
+					/* ports are defined in board DTS */
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+					};
+				};
+			};
 		};
 
 		gmac1: ethernet@b000 {
diff --git a/arch/arm/boot/dts/bcm947189acdbmr.dts b/arch/arm/boot/dts/bcm947189acdbmr.dts
index ef263412fea5..02c916bedd28 100644
--- a/arch/arm/boot/dts/bcm947189acdbmr.dts
+++ b/arch/arm/boot/dts/bcm947189acdbmr.dts
@@ -61,9 +61,9 @@
 	spi {
 		compatible = "spi-gpio";
 		num-chipselects = <1>;
-		gpio-sck = <&chipcommon 21 0>;
-		gpio-miso = <&chipcommon 22 0>;
-		gpio-mosi = <&chipcommon 23 0>;
+		sck-gpios = <&chipcommon 21 0>;
+		miso-gpios = <&chipcommon 22 0>;
+		mosi-gpios = <&chipcommon 23 0>;
 		cs-gpios = <&chipcommon 24 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/s3c6410-mini6410.dts b/arch/arm/boot/dts/s3c6410-mini6410.dts
index 1aeac33b0d34..0b07b3c31960 100644
--- a/arch/arm/boot/dts/s3c6410-mini6410.dts
+++ b/arch/arm/boot/dts/s3c6410-mini6410.dts
@@ -28,29 +28,21 @@
 		bootargs = "console=ttySAC0,115200n8 earlyprintk rootwait root=/dev/mmcblk0p1";
 	};
 
-	clocks {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		fin_pll: oscillator@0 {
-			compatible = "fixed-clock";
-			reg = <0>;
-			clock-frequency = <12000000>;
-			clock-output-names = "fin_pll";
-			#clock-cells = <0>;
-		};
+	fin_pll: oscillator-0 {
+		compatible = "fixed-clock";
+		clock-frequency = <12000000>;
+		clock-output-names = "fin_pll";
+		#clock-cells = <0>;
+	};
 
-		xusbxti: oscillator@1 {
-			compatible = "fixed-clock";
-			reg = <1>;
-			clock-output-names = "xusbxti";
-			clock-frequency = <48000000>;
-			#clock-cells = <0>;
-		};
+	xusbxti: oscillator-1 {
+		compatible = "fixed-clock";
+		clock-output-names = "xusbxti";
+		clock-frequency = <48000000>;
+		#clock-cells = <0>;
 	};
 
-	srom-cs1@18000000 {
+	srom-cs1-bus@18000000 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -59,7 +51,7 @@
 
 		ethernet@18000000 {
 			compatible = "davicom,dm9000";
-			reg = <0x18000000 0x2 0x18000004 0x2>;
+			reg = <0x18000000 0x2>, <0x18000004 0x2>;
 			interrupt-parent = <&gpn>;
 			interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
 			davicom,no-eeprom;
@@ -201,12 +193,12 @@
 };
 
 &pinctrl0 {
-	gpio_leds: gpio-leds {
+	gpio_leds: gpio-leds-pins {
 		samsung,pins = "gpk-4", "gpk-5", "gpk-6", "gpk-7";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	gpio_keys: gpio-keys {
+	gpio_keys: gpio-keys-pins {
 		samsung,pins = "gpn-0", "gpn-1", "gpn-2", "gpn-3",
 				"gpn-4", "gpn-5", "gpl-11", "gpl-12";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
diff --git a/arch/arm/boot/dts/s3c64xx-pinctrl.dtsi b/arch/arm/boot/dts/s3c64xx-pinctrl.dtsi
index 8e9594d64b57..0a3186d57cb5 100644
--- a/arch/arm/boot/dts/s3c64xx-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s3c64xx-pinctrl.dtsi
@@ -16,111 +16,111 @@
 	 * Pin banks
 	 */
 
-	gpa: gpa {
+	gpa: gpa-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpb: gpb {
+	gpb: gpb-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpc: gpc {
+	gpc: gpc-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpd: gpd {
+	gpd: gpd-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpe: gpe {
+	gpe: gpe-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpf: gpf {
+	gpf: gpf-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpg: gpg {
+	gpg: gpg-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gph: gph {
+	gph: gph-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpi: gpi {
+	gpi: gpi-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpj: gpj {
+	gpj: gpj-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpk: gpk {
+	gpk: gpk-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpl: gpl {
+	gpl: gpl-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpm: gpm {
+	gpm: gpm-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpn: gpn {
+	gpn: gpn-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpo: gpo {
+	gpo: gpo-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpp: gpp {
+	gpp: gpp-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpq: gpq {
+	gpq: gpq-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
@@ -131,225 +131,225 @@
 	 * Pin groups
 	 */
 
-	uart0_data: uart0-data {
+	uart0_data: uart0-data-pins {
 		samsung,pins = "gpa-0", "gpa-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	uart0_fctl: uart0-fctl {
+	uart0_fctl: uart0-fctl-pins {
 		samsung,pins = "gpa-2", "gpa-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	uart1_data: uart1-data {
+	uart1_data: uart1-data-pins {
 		samsung,pins = "gpa-4", "gpa-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	uart1_fctl: uart1-fctl {
+	uart1_fctl: uart1-fctl-pins {
 		samsung,pins = "gpa-6", "gpa-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	uart2_data: uart2-data {
+	uart2_data: uart2-data-pins {
 		samsung,pins = "gpb-0", "gpb-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	uart3_data: uart3-data {
+	uart3_data: uart3-data-pins {
 		samsung,pins = "gpb-2", "gpb-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	ext_dma_0: ext-dma-0 {
+	ext_dma_0: ext-dma-0-pins {
 		samsung,pins = "gpb-0", "gpb-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	ext_dma_1: ext-dma-1 {
+	ext_dma_1: ext-dma-1-pins {
 		samsung,pins = "gpb-2", "gpb-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	irda_data_0: irda-data-0 {
+	irda_data_0: irda-data-0-pins {
 		samsung,pins = "gpb-0", "gpb-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	irda_data_1: irda-data-1 {
+	irda_data_1: irda-data-1-pins {
 		samsung,pins = "gpb-2", "gpb-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	irda_sdbw: irda-sdbw {
+	irda_sdbw: irda-sdbw-pins {
 		samsung,pins = "gpb-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	i2c0_bus: i2c0-bus {
+	i2c0_bus: i2c0-bus-pins {
 		samsung,pins = "gpb-5", "gpb-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 	};
 
-	i2c1_bus: i2c1-bus {
+	i2c1_bus: i2c1-bus-pins {
 		/* S3C6410-only */
 		samsung,pins = "gpb-2", "gpb-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_6>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 	};
 
-	spi0_bus: spi0-bus {
+	spi0_bus: spi0-bus-pins {
 		samsung,pins = "gpc-0", "gpc-1", "gpc-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 	};
 
-	spi0_cs: spi0-cs {
+	spi0_cs: spi0-cs-pins {
 		samsung,pins = "gpc-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	spi1_bus: spi1-bus {
+	spi1_bus: spi1-bus-pins {
 		samsung,pins = "gpc-4", "gpc-5", "gpc-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 	};
 
-	spi1_cs: spi1-cs {
+	spi1_cs: spi1-cs-pins {
 		samsung,pins = "gpc-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd0_cmd: sd0-cmd {
+	sd0_cmd: sd0-cmd-pins {
 		samsung,pins = "gpg-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd0_clk: sd0-clk {
+	sd0_clk: sd0-clk-pins {
 		samsung,pins = "gpg-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd0_bus1: sd0-bus1 {
+	sd0_bus1: sd0-bus1-pins {
 		samsung,pins = "gpg-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd0_bus4: sd0-bus4 {
+	sd0_bus4: sd0-bus4-pins {
 		samsung,pins = "gpg-2", "gpg-3", "gpg-4", "gpg-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd0_cd: sd0-cd {
+	sd0_cd: sd0-cd-pins {
 		samsung,pins = "gpg-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 	};
 
-	sd1_cmd: sd1-cmd {
+	sd1_cmd: sd1-cmd-pins {
 		samsung,pins = "gph-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd1_clk: sd1-clk {
+	sd1_clk: sd1-clk-pins {
 		samsung,pins = "gph-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd1_bus1: sd1-bus1 {
+	sd1_bus1: sd1-bus1-pins {
 		samsung,pins = "gph-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd1_bus4: sd1-bus4 {
+	sd1_bus4: sd1-bus4-pins {
 		samsung,pins = "gph-2", "gph-3", "gph-4", "gph-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd1_bus8: sd1-bus8 {
+	sd1_bus8: sd1-bus8-pins {
 		samsung,pins = "gph-2", "gph-3", "gph-4", "gph-5",
 				"gph-6", "gph-7", "gph-8", "gph-9";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd1_cd: sd1-cd {
+	sd1_cd: sd1-cd-pins {
 		samsung,pins = "gpg-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 	};
 
-	sd2_cmd: sd2-cmd {
+	sd2_cmd: sd2-cmd-pins {
 		samsung,pins = "gpc-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd2_clk: sd2-clk {
+	sd2_clk: sd2-clk-pins {
 		samsung,pins = "gpc-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd2_bus1: sd2-bus1 {
+	sd2_bus1: sd2-bus1-pins {
 		samsung,pins = "gph-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd2_bus4: sd2-bus4 {
+	sd2_bus4: sd2-bus4-pins {
 		samsung,pins = "gph-6", "gph-7", "gph-8", "gph-9";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	i2s0_bus: i2s0-bus {
+	i2s0_bus: i2s0-bus-pins {
 		samsung,pins = "gpd-0", "gpd-2", "gpd-3", "gpd-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	i2s0_cdclk: i2s0-cdclk {
+	i2s0_cdclk: i2s0-cdclk-pins {
 		samsung,pins = "gpd-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	i2s1_bus: i2s1-bus {
+	i2s1_bus: i2s1-bus-pins {
 		samsung,pins = "gpe-0", "gpe-2", "gpe-3", "gpe-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	i2s1_cdclk: i2s1-cdclk {
+	i2s1_cdclk: i2s1-cdclk-pins {
 		samsung,pins = "gpe-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	i2s2_bus: i2s2-bus {
+	i2s2_bus: i2s2-bus-pins {
 		/* S3C6410-only */
 		samsung,pins = "gpc-4", "gpc-5", "gpc-6", "gph-6",
 				"gph-8", "gph-9";
@@ -357,50 +357,50 @@
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	i2s2_cdclk: i2s2-cdclk {
+	i2s2_cdclk: i2s2-cdclk-pins {
 		/* S3C6410-only */
 		samsung,pins = "gph-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_5>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	pcm0_bus: pcm0-bus {
+	pcm0_bus: pcm0-bus-pins {
 		samsung,pins = "gpd-0", "gpd-2", "gpd-3", "gpd-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	pcm0_extclk: pcm0-extclk {
+	pcm0_extclk: pcm0-extclk-pins {
 		samsung,pins = "gpd-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	pcm1_bus: pcm1-bus {
+	pcm1_bus: pcm1-bus-pins {
 		samsung,pins = "gpe-0", "gpe-2", "gpe-3", "gpe-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	pcm1_extclk: pcm1-extclk {
+	pcm1_extclk: pcm1-extclk-pins {
 		samsung,pins = "gpe-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	ac97_bus_0: ac97-bus-0 {
+	ac97_bus_0: ac97-bus-0-pins {
 		samsung,pins = "gpd-0", "gpd-1", "gpd-2", "gpd-3", "gpd-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	ac97_bus_1: ac97-bus-1 {
+	ac97_bus_1: ac97-bus-1-pins {
 		samsung,pins = "gpe-0", "gpe-1", "gpe-2", "gpe-3", "gpe-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	cam_port: cam-port {
+	cam_port: cam-port-pins {
 		samsung,pins = "gpf-0", "gpf-1", "gpf-2", "gpf-4",
 				"gpf-5", "gpf-6", "gpf-7", "gpf-8",
 				"gpf-9", "gpf-10", "gpf-11", "gpf-12";
@@ -408,242 +408,242 @@
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	cam_rst: cam-rst {
+	cam_rst: cam-rst-pins {
 		samsung,pins = "gpf-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	cam_field: cam-field {
+	cam_field: cam-field-pins {
 		/* S3C6410-only */
 		samsung,pins = "gpb-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	pwm_extclk: pwm-extclk {
+	pwm_extclk: pwm-extclk-pins {
 		samsung,pins = "gpf-13";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	pwm0_out: pwm0-out {
+	pwm0_out: pwm0-out-pins {
 		samsung,pins = "gpf-14";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	pwm1_out: pwm1-out {
+	pwm1_out: pwm1-out-pins {
 		samsung,pins = "gpf-15";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	clkout0: clkout-0 {
+	clkout0: clkout-0-pins {
 		samsung,pins = "gpf-14";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col0_0: keypad-col0-0 {
+	keypad_col0_0: keypad-col0-0-pins {
 		samsung,pins = "gph-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col1_0: keypad-col1-0 {
+	keypad_col1_0: keypad-col1-0-pins {
 		samsung,pins = "gph-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col2_0: keypad-col2-0 {
+	keypad_col2_0: keypad-col2-0-pins {
 		samsung,pins = "gph-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col3_0: keypad-col3-0 {
+	keypad_col3_0: keypad-col3-0-pins {
 		samsung,pins = "gph-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col4_0: keypad-col4-0 {
+	keypad_col4_0: keypad-col4-0-pins {
 		samsung,pins = "gph-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col5_0: keypad-col5-0 {
+	keypad_col5_0: keypad-col5-0-pins {
 		samsung,pins = "gph-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col6_0: keypad-col6-0 {
+	keypad_col6_0: keypad-col6-0-pins {
 		samsung,pins = "gph-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col7_0: keypad-col7-0 {
+	keypad_col7_0: keypad-col7-0-pins {
 		samsung,pins = "gph-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col0_1: keypad-col0-1 {
+	keypad_col0_1: keypad-col0-1-pins {
 		samsung,pins = "gpl-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col1_1: keypad-col1-1 {
+	keypad_col1_1: keypad-col1-1-pins {
 		samsung,pins = "gpl-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col2_1: keypad-col2-1 {
+	keypad_col2_1: keypad-col2-1-pins {
 		samsung,pins = "gpl-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col3_1: keypad-col3-1 {
+	keypad_col3_1: keypad-col3-1-pins {
 		samsung,pins = "gpl-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col4_1: keypad-col4-1 {
+	keypad_col4_1: keypad-col4-1-pins {
 		samsung,pins = "gpl-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col5_1: keypad-col5-1 {
+	keypad_col5_1: keypad-col5-1-pins {
 		samsung,pins = "gpl-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col6_1: keypad-col6-1 {
+	keypad_col6_1: keypad-col6-1-pins {
 		samsung,pins = "gpl-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col7_1: keypad-col7-1 {
+	keypad_col7_1: keypad-col7-1-pins {
 		samsung,pins = "gpl-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row0_0: keypad-row0-0 {
+	keypad_row0_0: keypad-row0-0-pins {
 		samsung,pins = "gpk-8";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row1_0: keypad-row1-0 {
+	keypad_row1_0: keypad-row1-0-pins {
 		samsung,pins = "gpk-9";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row2_0: keypad-row2-0 {
+	keypad_row2_0: keypad-row2-0-pins {
 		samsung,pins = "gpk-10";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row3_0: keypad-row3-0 {
+	keypad_row3_0: keypad-row3-0-pins {
 		samsung,pins = "gpk-11";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row4_0: keypad-row4-0 {
+	keypad_row4_0: keypad-row4-0-pins {
 		samsung,pins = "gpk-12";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row5_0: keypad-row5-0 {
+	keypad_row5_0: keypad-row5-0-pins {
 		samsung,pins = "gpk-13";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row6_0: keypad-row6-0 {
+	keypad_row6_0: keypad-row6-0-pins {
 		samsung,pins = "gpk-14";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row7_0: keypad-row7-0 {
+	keypad_row7_0: keypad-row7-0-pins {
 		samsung,pins = "gpk-15";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row0_1: keypad-row0-1 {
+	keypad_row0_1: keypad-row0-1-pins {
 		samsung,pins = "gpn-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row1_1: keypad-row1-1 {
+	keypad_row1_1: keypad-row1-1-pins {
 		samsung,pins = "gpn-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row2_1: keypad-row2-1 {
+	keypad_row2_1: keypad-row2-1-pins {
 		samsung,pins = "gpn-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row3_1: keypad-row3-1 {
+	keypad_row3_1: keypad-row3-1-pins {
 		samsung,pins = "gpn-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row4_1: keypad-row4-1 {
+	keypad_row4_1: keypad-row4-1-pins {
 		samsung,pins = "gpn-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row5_1: keypad-row5-1 {
+	keypad_row5_1: keypad-row5-1-pins {
 		samsung,pins = "gpn-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row6_1: keypad-row6-1 {
+	keypad_row6_1: keypad-row6-1-pins {
 		samsung,pins = "gpn-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row7_1: keypad-row7-1 {
+	keypad_row7_1: keypad-row7-1-pins {
 		samsung,pins = "gpn-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	lcd_ctrl: lcd-ctrl {
+	lcd_ctrl: lcd-ctrl-pins {
 		samsung,pins = "gpj-8", "gpj-9", "gpj-10", "gpj-11";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	lcd_data16: lcd-data-width16 {
+	lcd_data16: lcd-data-width16-pins {
 		samsung,pins = "gpi-3", "gpi-4", "gpi-5", "gpi-6",
 				"gpi-7", "gpi-10", "gpi-11", "gpi-12",
 				"gpi-13", "gpi-14", "gpi-15", "gpj-3",
@@ -652,7 +652,7 @@
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	lcd_data18: lcd-data-width18 {
+	lcd_data18: lcd-data-width18-pins {
 		samsung,pins = "gpi-2", "gpi-3", "gpi-4", "gpi-5",
 				"gpi-6", "gpi-7", "gpi-10", "gpi-11",
 				"gpi-12", "gpi-13", "gpi-14", "gpi-15",
@@ -662,7 +662,7 @@
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	lcd_data24: lcd-data-width24 {
+	lcd_data24: lcd-data-width24-pins {
 		samsung,pins = "gpi-0", "gpi-1", "gpi-2", "gpi-3",
 				"gpi-4", "gpi-5", "gpi-6", "gpi-7",
 				"gpi-8", "gpi-9", "gpi-10", "gpi-11",
@@ -673,7 +673,7 @@
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	hsi_bus: hsi-bus {
+	hsi_bus: hsi-bus-pins {
 		samsung,pins = "gpk-0", "gpk-1", "gpk-2", "gpk-3",
 				"gpk-4", "gpk-5", "gpk-6", "gpk-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
diff --git a/arch/arm/boot/dts/s5pv210-smdkv210.dts b/arch/arm/boot/dts/s5pv210-smdkv210.dts
index 84b38f185199..53a841ecf7a4 100644
--- a/arch/arm/boot/dts/s5pv210-smdkv210.dts
+++ b/arch/arm/boot/dts/s5pv210-smdkv210.dts
@@ -15,6 +15,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/input/input.h>
 #include "s5pv210.dtsi"
 
@@ -31,11 +32,18 @@
 		reg = <0x20000000 0x40000000>;
 	};
 
-	ethernet@18000000 {
+	pmic_ap_clk: clock-0 {
+		/* Workaround for missing PMIC and its clock */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
+
+	ethernet@a8000000 {
 		compatible = "davicom,dm9000";
-		reg = <0xA8000000 0x2 0xA8000002 0x2>;
+		reg = <0xa8000000 0x2>, <0xa8000002 0x2>;
 		interrupt-parent = <&gph1>;
-		interrupts = <1 4>;
+		interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
 		local-mac-address = [00 00 de ad be ef];
 		davicom,no-eeprom;
 	};
@@ -47,6 +55,14 @@
 		default-brightness-level = <6>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm3_out>;
+		power-supply = <&dc5v_reg>;
+	};
+
+	dc5v_reg: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "DC5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
 	};
 };
 
@@ -147,6 +163,8 @@
 
 &rtc {
 	status = "okay";
+	clocks = <&clocks CLK_RTC>, <&pmic_ap_clk>;
+	clock-names = "rtc", "rtc_src";
 };
 
 &sdhci0 {
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 2ee5b7f5e7ad..c71ecd06131c 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -631,7 +631,7 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 	hw->address &= ~alignment_mask;
 	hw->ctrl.len <<= offset;
 
-	if (is_default_overflow_handler(bp)) {
+	if (uses_default_overflow_handler(bp)) {
 		/*
 		 * Mismatch breakpoints are required for single-stepping
 		 * breakpoints.
@@ -803,7 +803,7 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
 		 * Otherwise, insert a temporary mismatch breakpoint so that
 		 * we can single-step over the watchpoint trigger.
 		 */
-		if (!is_default_overflow_handler(wp))
+		if (!uses_default_overflow_handler(wp))
 			continue;
 step:
 		enable_single_step(wp, instruction_pointer(regs));
@@ -816,7 +816,7 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
 		info->trigger = addr;
 		pr_debug("watchpoint fired: address = 0x%x\n", info->trigger);
 		perf_bp_event(wp, regs);
-		if (is_default_overflow_handler(wp))
+		if (uses_default_overflow_handler(wp))
 			enable_single_step(wp, instruction_pointer(regs));
 	}
 
@@ -891,7 +891,7 @@ static void breakpoint_handler(unsigned long unknown, struct pt_regs *regs)
 			info->trigger = addr;
 			pr_debug("breakpoint fired: address = 0x%x\n", addr);
 			perf_bp_event(bp, regs);
-			if (is_default_overflow_handler(bp))
+			if (uses_default_overflow_handler(bp))
 				enable_single_step(bp, addr);
 			goto unlock;
 		}
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 1a0f69c0a376..27c652eaa175 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -177,7 +177,7 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 		break;
 	case PWRDM_STATE_PREV:
 		prev = pwrdm_read_prev_pwrst(pwrdm);
-		if (pwrdm->state != prev)
+		if (prev >= 0 && pwrdm->state != prev)
 			pwrdm->state_counter[prev]++;
 		if (prev == PWRDM_POWER_RET)
 			_update_logic_membank_counters(pwrdm);
diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index ef9fd9b759cb..34dc87085724 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -224,8 +224,6 @@ void sharpsl_battery_kick(void)
 {
 	schedule_delayed_work(&sharpsl_bat, msecs_to_jiffies(125));
 }
-EXPORT_SYMBOL(sharpsl_battery_kick);
-
 
 static void sharpsl_battery_thread(struct work_struct *private_)
 {
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 5d50025492b7..af35a0ba2dca 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -13,7 +13,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>	/* symbol_get ; symbol_put */
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/gpio_keys.h>
@@ -517,17 +516,6 @@ static struct pxa2xx_spi_chip spitz_ads7846_chip = {
 	.gpio_cs		= SPITZ_GPIO_ADS7846_CS,
 };
 
-static void spitz_bl_kick_battery(void)
-{
-	void (*kick_batt)(void);
-
-	kick_batt = symbol_get(sharpsl_battery_kick);
-	if (kick_batt) {
-		kick_batt();
-		symbol_put(sharpsl_battery_kick);
-	}
-}
-
 static struct corgi_lcd_platform_data spitz_lcdcon_info = {
 	.init_mode		= CORGI_LCD_MODE_VGA,
 	.max_intensity		= 0x2f,
@@ -535,7 +523,7 @@ static struct corgi_lcd_platform_data spitz_lcdcon_info = {
 	.limit_mask		= 0x0b,
 	.gpio_backlight_cont	= SPITZ_GPIO_BACKLIGHT_CONT,
 	.gpio_backlight_on	= SPITZ_GPIO_BACKLIGHT_ON,
-	.kick_battery		= spitz_bl_kick_battery,
+	.kick_battery		= sharpsl_battery_kick,
 };
 
 static struct pxa2xx_spi_chip spitz_lcdcon_chip = {
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 3e7baabf6450..4ee32583dc7c 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -382,6 +382,8 @@
 			reg = <0x4a9000 0x1000>, /* TM */
 			      <0x4a8000 0x1000>; /* SROT */
 			#qcom,sensors = <13>;
+			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
@@ -390,6 +392,8 @@
 			reg = <0x4ad000 0x1000>, /* TM */
 			      <0x4ac000 0x1000>; /* SROT */
 			#qcom,sensors = <8>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
 			#thermal-sensor-cells = <1>;
 		};
 
@@ -899,6 +903,9 @@
 			#size-cells = <1>;
 			ranges;
 
+			interrupts = <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq";
+
 			clocks = <&gcc GCC_PERIPH_NOC_USB20_AHB_CLK>,
 				<&gcc GCC_USB20_MASTER_CLK>,
 				<&gcc GCC_USB20_MOCK_UTMI_CLK>,
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 9f105fe58595..5d120e39bf61 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -661,7 +661,7 @@ static int breakpoint_handler(unsigned long unused, unsigned int esr,
 		perf_bp_event(bp, regs);
 
 		/* Do we need to handle the stepping? */
-		if (is_default_overflow_handler(bp))
+		if (uses_default_overflow_handler(bp))
 			step = 1;
 unlock:
 		rcu_read_unlock();
@@ -740,7 +740,7 @@ static u64 get_distance_from_watchpoint(unsigned long addr, u64 val,
 static int watchpoint_report(struct perf_event *wp, unsigned long addr,
 			     struct pt_regs *regs)
 {
-	int step = is_default_overflow_handler(wp);
+	int step = uses_default_overflow_handler(wp);
 	struct arch_hw_breakpoint *info = counter_arch_bp(wp);
 
 	info->trigger = addr;
diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
index a8f41615d94a..31a9c634c81e 100644
--- a/arch/m68k/fpsp040/skeleton.S
+++ b/arch/m68k/fpsp040/skeleton.S
@@ -499,12 +499,12 @@ in_ea:
 	dbf	%d0,morein
 	rts
 
-	.section .fixup,#alloc,#execinstr
+	.section .fixup,"ax"
 	.even
 1:
 	jbra	fpsp040_die
 
-	.section __ex_table,#alloc
+	.section __ex_table,"a"
 	.align	4
 
 	.long	in_ea,1b
diff --git a/arch/m68k/ifpsp060/os.S b/arch/m68k/ifpsp060/os.S
index 7a0d6e428066..89e2ec224ab6 100644
--- a/arch/m68k/ifpsp060/os.S
+++ b/arch/m68k/ifpsp060/os.S
@@ -379,11 +379,11 @@ _060_real_access:
 
 
 | Execption handling for movs access to illegal memory
-	.section .fixup,#alloc,#execinstr
+	.section .fixup,"ax"
 	.even
 1:	moveq		#-1,%d1
 	rts
-.section __ex_table,#alloc
+.section __ex_table,"a"
 	.align 4
 	.long	dmrbuae,1b
 	.long	dmrwuae,1b
diff --git a/arch/m68k/kernel/relocate_kernel.S b/arch/m68k/kernel/relocate_kernel.S
index ab0f1e7d4653..f7667079e08e 100644
--- a/arch/m68k/kernel/relocate_kernel.S
+++ b/arch/m68k/kernel/relocate_kernel.S
@@ -26,7 +26,7 @@ ENTRY(relocate_new_kernel)
 	lea %pc@(.Lcopy),%a4
 2:	addl #0x00000000,%a4		/* virt_to_phys() */
 
-	.section ".m68k_fixup","aw"
+	.section .m68k_fixup,"aw"
 	.long M68K_FIXUP_MEMOFFSET, 2b+2
 	.previous
 
@@ -49,7 +49,7 @@ ENTRY(relocate_new_kernel)
 	lea %pc@(.Lcont040),%a4
 5:	addl #0x00000000,%a4		/* virt_to_phys() */
 
-	.section ".m68k_fixup","aw"
+	.section .m68k_fixup,"aw"
 	.long M68K_FIXUP_MEMOFFSET, 5b+2
 	.previous
 
diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index 13e3c84859fe..6fe0f0f95ed7 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -27,7 +27,6 @@
 #include <linux/interrupt.h>
 #include <linux/leds.h>
 #include <linux/mmc/host.h>
-#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/spi/spi.h>
@@ -176,12 +175,7 @@ static struct platform_device db1x00_audio_dev = {
 
 static irqreturn_t db1100_mmc_cd(int irq, void *ptr)
 {
-	void (*mmc_cd)(struct mmc_host *, unsigned long);
-	/* link against CONFIG_MMC=m */
-	mmc_cd = symbol_get(mmc_detect_change);
-	mmc_cd(ptr, msecs_to_jiffies(500));
-	symbol_put(mmc_detect_change);
-
+	mmc_detect_change(ptr, msecs_to_jiffies(500));
 	return IRQ_HANDLED;
 }
 
diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index da7663770425..ae81e05fcb2c 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -23,7 +23,6 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
-#include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/leds.h>
@@ -355,14 +354,7 @@ static irqreturn_t db1200_mmc_cd(int irq, void *ptr)
 
 static irqreturn_t db1200_mmc_cdfn(int irq, void *ptr)
 {
-	void (*mmc_cd)(struct mmc_host *, unsigned long);
-
-	/* link against CONFIG_MMC=m */
-	mmc_cd = symbol_get(mmc_detect_change);
-	if (mmc_cd) {
-		mmc_cd(ptr, msecs_to_jiffies(200));
-		symbol_put(mmc_detect_change);
-	}
+	mmc_detect_change(ptr, msecs_to_jiffies(200));
 
 	msleep(100);	/* debounce */
 	if (irq == DB1200_SD0_INSERT_INT)
@@ -446,14 +438,7 @@ static irqreturn_t pb1200_mmc1_cd(int irq, void *ptr)
 
 static irqreturn_t pb1200_mmc1_cdfn(int irq, void *ptr)
 {
-	void (*mmc_cd)(struct mmc_host *, unsigned long);
-
-	/* link against CONFIG_MMC=m */
-	mmc_cd = symbol_get(mmc_detect_change);
-	if (mmc_cd) {
-		mmc_cd(ptr, msecs_to_jiffies(200));
-		symbol_put(mmc_detect_change);
-	}
+	mmc_detect_change(ptr, msecs_to_jiffies(200));
 
 	msleep(100);	/* debounce */
 	if (irq == PB1200_SD1_INSERT_INT)
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index efb318e03e0a..0c12fbc07117 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -17,7 +17,6 @@
 #include <linux/interrupt.h>
 #include <linux/ata_platform.h>
 #include <linux/mmc/host.h>
-#include <linux/module.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
@@ -457,14 +456,7 @@ static irqreturn_t db1300_mmc_cd(int irq, void *ptr)
 
 static irqreturn_t db1300_mmc_cdfn(int irq, void *ptr)
 {
-	void (*mmc_cd)(struct mmc_host *, unsigned long);
-
-	/* link against CONFIG_MMC=m.  We can only be called once MMC core has
-	 * initialized the controller, so symbol_get() should always succeed.
-	 */
-	mmc_cd = symbol_get(mmc_detect_change);
-	mmc_cd(ptr, msecs_to_jiffies(200));
-	symbol_put(mmc_detect_change);
+	mmc_detect_change(ptr, msecs_to_jiffies(200));
 
 	msleep(100);	/* debounce */
 	if (irq == DB1300_SD1_INSERT_INT)
diff --git a/arch/parisc/include/asm/led.h b/arch/parisc/include/asm/led.h
index 6de13d08a388..b70b9094fb7c 100644
--- a/arch/parisc/include/asm/led.h
+++ b/arch/parisc/include/asm/led.h
@@ -11,8 +11,8 @@
 #define	LED1		0x02
 #define	LED0		0x01		/* bottom (or furthest left) LED */
 
-#define	LED_LAN_TX	LED0		/* for LAN transmit activity */
-#define	LED_LAN_RCV	LED1		/* for LAN receive activity */
+#define	LED_LAN_RCV	LED0		/* for LAN receive activity */
+#define	LED_LAN_TX	LED1		/* for LAN transmit activity */
 #define	LED_DISK_IO	LED2		/* for disk activity */
 #define	LED_HEARTBEAT	LED3		/* heartbeat */
 
diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
index 2bd5e695bdad..0e6cac0ece5c 100644
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -108,7 +108,6 @@ struct cpuinfo_parisc {
 	unsigned long cpu_loc;      /* CPU location from PAT firmware */
 	unsigned int state;
 	struct parisc_device *dev;
-	unsigned long loops_per_jiffy;
 };
 
 extern struct system_cpuinfo_parisc boot_cpu_data;
diff --git a/arch/parisc/kernel/processor.c b/arch/parisc/kernel/processor.c
index 0b0194150b68..be3618b2c67b 100644
--- a/arch/parisc/kernel/processor.c
+++ b/arch/parisc/kernel/processor.c
@@ -177,7 +177,6 @@ static int __init processor_probe(struct parisc_device *dev)
 	if (cpuid)
 		memset(p, 0, sizeof(struct cpuinfo_parisc));
 
-	p->loops_per_jiffy = loops_per_jiffy;
 	p->dev = dev;		/* Save IODC data in case we need it */
 	p->hpa = dev->hpa.start;	/* save CPU hpa */
 	p->cpuid = cpuid;	/* save CPU id */
@@ -377,10 +376,18 @@ int
 show_cpuinfo (struct seq_file *m, void *v)
 {
 	unsigned long cpu;
+	char cpu_name[60], *p;
+
+	/* strip PA path from CPU name to not confuse lscpu */
+	strlcpy(cpu_name, per_cpu(cpu_data, 0).dev->name, sizeof(cpu_name));
+	p = strrchr(cpu_name, '[');
+	if (p)
+		*(--p) = 0;
 
 	for_each_online_cpu(cpu) {
-		const struct cpuinfo_parisc *cpuinfo = &per_cpu(cpu_data, cpu);
 #ifdef CONFIG_SMP
+		const struct cpuinfo_parisc *cpuinfo = &per_cpu(cpu_data, cpu);
+
 		if (0 == cpuinfo->hpa)
 			continue;
 #endif
@@ -425,8 +432,7 @@ show_cpuinfo (struct seq_file *m, void *v)
 
 		seq_printf(m, "model\t\t: %s - %s\n",
 				 boot_cpu_data.pdc.sys_model_name,
-				 cpuinfo->dev ?
-				 cpuinfo->dev->name : "Unknown");
+				 cpu_name);
 
 		seq_printf(m, "hversion\t: 0x%08x\n"
 			        "sversion\t: 0x%08x\n",
@@ -437,8 +443,8 @@ show_cpuinfo (struct seq_file *m, void *v)
 		show_cache_info(m);
 
 		seq_printf(m, "bogomips\t: %lu.%02lu\n",
-			     cpuinfo->loops_per_jiffy / (500000 / HZ),
-			     (cpuinfo->loops_per_jiffy / (5000 / HZ)) % 100);
+			     loops_per_jiffy / (500000 / HZ),
+			     loops_per_jiffy / (5000 / HZ) % 100);
 
 		seq_printf(m, "software id\t: %ld\n\n",
 				boot_cpu_data.pdc.model.sw_id);
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 61ca27929355..53a379da17e9 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -987,7 +987,7 @@ start_here:
 	 */
 	lis	r5, abatron_pteptrs@h
 	ori	r5, r5, abatron_pteptrs@l
-	stw	r5, 0xf0(r0)	/* This much match your Abatron config */
+	stw	r5, 0xf0(0)	/* This much match your Abatron config */
 	lis	r6, swapper_pg_dir@h
 	ori	r6, r6, swapper_pg_dir@l
 	tophys(r5, r5)
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index c3d2d5cd7c10..af1a2bf758c5 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -145,17 +145,28 @@ static int fail_iommu_bus_notify(struct notifier_block *nb,
 	return 0;
 }
 
-static struct notifier_block fail_iommu_bus_notifier = {
+/*
+ * PCI and VIO buses need separate notifier_block structs, since they're linked
+ * list nodes.  Sharing a notifier_block would mean that any notifiers later
+ * registered for PCI buses would also get called by VIO buses and vice versa.
+ */
+static struct notifier_block fail_iommu_pci_bus_notifier = {
 	.notifier_call = fail_iommu_bus_notify
 };
 
+#ifdef CONFIG_IBMVIO
+static struct notifier_block fail_iommu_vio_bus_notifier = {
+	.notifier_call = fail_iommu_bus_notify
+};
+#endif
+
 static int __init fail_iommu_setup(void)
 {
 #ifdef CONFIG_PCI
-	bus_register_notifier(&pci_bus_type, &fail_iommu_bus_notifier);
+	bus_register_notifier(&pci_bus_type, &fail_iommu_pci_bus_notifier);
 #endif
 #ifdef CONFIG_IBMVIO
-	bus_register_notifier(&vio_bus_type, &fail_iommu_bus_notifier);
+	bus_register_notifier(&vio_bus_type, &fail_iommu_vio_bus_notifier);
 #endif
 
 	return 0;
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 9b346f3d2814..737a4698bd5e 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -328,6 +328,7 @@ SECTIONS
 		*(.sdata2)
 		*(.got.plt) *(.got)
 		*(.plt)
+		*(.branch_lt)
 	}
 #else
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index c7c1140c13b6..3fce7508a4fc 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -452,6 +452,7 @@ static int __init ibmebus_bus_init(void)
 	if (err) {
 		printk(KERN_WARNING "%s: device_register returned %i\n",
 		       __func__, err);
+		put_device(&ibmebus_bus_device);
 		bus_unregister(&ibmebus_bus_type);
 
 		return err;
diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
index 8f114e3b0a7a..8d06b799a0e4 100644
--- a/arch/um/configs/i386_defconfig
+++ b/arch/um/configs/i386_defconfig
@@ -35,6 +35,7 @@ CONFIG_TTY_CHAN=y
 CONFIG_XTERM_CHAN=y
 CONFIG_CON_CHAN="pts"
 CONFIG_SSL_CHAN="pts"
+CONFIG_SOUND=m
 CONFIG_UML_SOUND=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
index 5d0875fc0db2..446bdda4cbfb 100644
--- a/arch/um/configs/x86_64_defconfig
+++ b/arch/um/configs/x86_64_defconfig
@@ -33,6 +33,7 @@ CONFIG_TTY_CHAN=y
 CONFIG_XTERM_CHAN=y
 CONFIG_CON_CHAN="pts"
 CONFIG_SSL_CHAN="pts"
+CONFIG_SOUND=m
 CONFIG_UML_SOUND=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 2b1aaf7755aa..494f7c27056e 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -11,58 +11,58 @@ config STDERR_CONSOLE
 config SSL
 	bool "Virtual serial line"
 	help
-          The User-Mode Linux environment allows you to create virtual serial
-          lines on the UML that are usually made to show up on the host as
-          ttys or ptys.
+	  The User-Mode Linux environment allows you to create virtual serial
+	  lines on the UML that are usually made to show up on the host as
+	  ttys or ptys.
 
-          See <http://user-mode-linux.sourceforge.net/old/input.html> for more
-          information and command line examples of how to use this facility.
+	  See <http://user-mode-linux.sourceforge.net/old/input.html> for more
+	  information and command line examples of how to use this facility.
 
-          Unless you have a specific reason for disabling this, say Y.
+	  Unless you have a specific reason for disabling this, say Y.
 
 config NULL_CHAN
 	bool "null channel support"
 	help
-          This option enables support for attaching UML consoles and serial
-          lines to a device similar to /dev/null.  Data written to it disappears
-          and there is never any data to be read.
+	  This option enables support for attaching UML consoles and serial
+	  lines to a device similar to /dev/null.  Data written to it disappears
+	  and there is never any data to be read.
 
 config PORT_CHAN
 	bool "port channel support"
 	help
-          This option enables support for attaching UML consoles and serial
-          lines to host portals.  They may be accessed with 'telnet <host>
-          <port number>'.  Any number of consoles and serial lines may be
-          attached to a single portal, although what UML device you get when
-          you telnet to that portal will be unpredictable.
-          It is safe to say 'Y' here.
+	  This option enables support for attaching UML consoles and serial
+	  lines to host portals.  They may be accessed with 'telnet <host>
+	  <port number>'.  Any number of consoles and serial lines may be
+	  attached to a single portal, although what UML device you get when
+	  you telnet to that portal will be unpredictable.
+	  It is safe to say 'Y' here.
 
 config PTY_CHAN
 	bool "pty channel support"
 	help
-          This option enables support for attaching UML consoles and serial
-          lines to host pseudo-terminals.  Access to both traditional
-          pseudo-terminals (/dev/pty*) and pts pseudo-terminals are controlled
-          with this option.  The assignment of UML devices to host devices
-          will be announced in the kernel message log.
-          It is safe to say 'Y' here.
+	  This option enables support for attaching UML consoles and serial
+	  lines to host pseudo-terminals.  Access to both traditional
+	  pseudo-terminals (/dev/pty*) and pts pseudo-terminals are controlled
+	  with this option.  The assignment of UML devices to host devices
+	  will be announced in the kernel message log.
+	  It is safe to say 'Y' here.
 
 config TTY_CHAN
 	bool "tty channel support"
 	help
-          This option enables support for attaching UML consoles and serial
-          lines to host terminals.  Access to both virtual consoles
-          (/dev/tty*) and the slave side of pseudo-terminals (/dev/ttyp* and
-          /dev/pts/*) are controlled by this option.
-          It is safe to say 'Y' here.
+	  This option enables support for attaching UML consoles and serial
+	  lines to host terminals.  Access to both virtual consoles
+	  (/dev/tty*) and the slave side of pseudo-terminals (/dev/ttyp* and
+	  /dev/pts/*) are controlled by this option.
+	  It is safe to say 'Y' here.
 
 config XTERM_CHAN
 	bool "xterm channel support"
 	help
-          This option enables support for attaching UML consoles and serial
-          lines to xterms.  Each UML device so assigned will be brought up in
-          its own xterm.
-          It is safe to say 'Y' here.
+	  This option enables support for attaching UML consoles and serial
+	  lines to xterms.  Each UML device so assigned will be brought up in
+	  its own xterm.
+	  It is safe to say 'Y' here.
 
 config NOCONFIG_CHAN
 	bool
@@ -72,55 +72,45 @@ config CON_ZERO_CHAN
 	string "Default main console channel initialization"
 	default "fd:0,fd:1"
 	help
-          This is the string describing the channel to which the main console
-          will be attached by default.  This value can be overridden from the
-          command line.  The default value is "fd:0,fd:1", which attaches the
-          main console to stdin and stdout.
-          It is safe to leave this unchanged.
+	  This is the string describing the channel to which the main console
+	  will be attached by default.  This value can be overridden from the
+	  command line.  The default value is "fd:0,fd:1", which attaches the
+	  main console to stdin and stdout.
+	  It is safe to leave this unchanged.
 
 config CON_CHAN
 	string "Default console channel initialization"
 	default "xterm"
 	help
-          This is the string describing the channel to which all consoles
-          except the main console will be attached by default.  This value can
-          be overridden from the command line.  The default value is "xterm",
-          which brings them up in xterms.
-          It is safe to leave this unchanged, although you may wish to change
-          this if you expect the UML that you build to be run in environments
-          which don't have X or xterm available.
+	  This is the string describing the channel to which all consoles
+	  except the main console will be attached by default.  This value can
+	  be overridden from the command line.  The default value is "xterm",
+	  which brings them up in xterms.
+	  It is safe to leave this unchanged, although you may wish to change
+	  this if you expect the UML that you build to be run in environments
+	  which don't have X or xterm available.
 
 config SSL_CHAN
 	string "Default serial line channel initialization"
 	default "pty"
 	help
-          This is the string describing the channel to which the serial lines
-          will be attached by default.  This value can be overridden from the
-          command line.  The default value is "pty", which attaches them to
-          traditional pseudo-terminals.
-          It is safe to leave this unchanged, although you may wish to change
-          this if you expect the UML that you build to be run in environments
-          which don't have a set of /dev/pty* devices.
+	  This is the string describing the channel to which the serial lines
+	  will be attached by default.  This value can be overridden from the
+	  command line.  The default value is "pty", which attaches them to
+	  traditional pseudo-terminals.
+	  It is safe to leave this unchanged, although you may wish to change
+	  this if you expect the UML that you build to be run in environments
+	  which don't have a set of /dev/pty* devices.
 
 config UML_SOUND
 	tristate "Sound support"
+	depends on SOUND
+	select SOUND_OSS_CORE
 	help
-          This option enables UML sound support.  If enabled, it will pull in
-          soundcore and the UML hostaudio relay, which acts as a intermediary
-          between the host's dsp and mixer devices and the UML sound system.
-          It is safe to say 'Y' here.
-
-config SOUND
-	tristate
-	default UML_SOUND
-
-config SOUND_OSS_CORE
-	bool
-	default UML_SOUND
-
-config HOSTAUDIO
-	tristate
-	default UML_SOUND
+	  This option enables UML sound support.  If enabled, it will pull in
+	  the UML hostaudio relay, which acts as a intermediary
+	  between the host's dsp and mixer devices and the UML sound system.
+	  It is safe to say 'Y' here.
 
 endmenu
 
@@ -131,107 +121,107 @@ menu "UML Network Devices"
 config UML_NET
 	bool "Virtual network device"
 	help
-        While the User-Mode port cannot directly talk to any physical
-        hardware devices, this choice and the following transport options
-        provide one or more virtual network devices through which the UML
-        kernels can talk to each other, the host, and with the host's help,
-        machines on the outside world.
+	  While the User-Mode port cannot directly talk to any physical
+	  hardware devices, this choice and the following transport options
+	  provide one or more virtual network devices through which the UML
+	  kernels can talk to each other, the host, and with the host's help,
+	  machines on the outside world.
 
-        For more information, including explanations of the networking and
-        sample configurations, see
-        <http://user-mode-linux.sourceforge.net/old/networking.html>.
+	  For more information, including explanations of the networking and
+	  sample configurations, see
+	  <http://user-mode-linux.sourceforge.net/old/networking.html>.
 
-        If you'd like to be able to enable networking in the User-Mode
-        linux environment, say Y; otherwise say N.  Note that you must
-        enable at least one of the following transport options to actually
-        make use of UML networking.
+	  If you'd like to be able to enable networking in the User-Mode
+	  linux environment, say Y; otherwise say N.  Note that you must
+	  enable at least one of the following transport options to actually
+	  make use of UML networking.
 
 config UML_NET_ETHERTAP
 	bool "Ethertap transport"
 	depends on UML_NET
 	help
-        The Ethertap User-Mode Linux network transport allows a single
-        running UML to exchange packets with its host over one of the
-        host's Ethertap devices, such as /dev/tap0.  Additional running
-        UMLs can use additional Ethertap devices, one per running UML.
-        While the UML believes it's on a (multi-device, broadcast) virtual
-        Ethernet network, it's in fact communicating over a point-to-point
-        link with the host.
-
-        To use this, your host kernel must have support for Ethertap
-        devices.  Also, if your host kernel is 2.4.x, it must have
-        CONFIG_NETLINK_DEV configured as Y or M.
-
-        For more information, see
-        <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
-        has examples of the UML command line to use to enable Ethertap
-        networking.
-
-        If you'd like to set up an IP network with the host and/or the
-        outside world, say Y to this, the Daemon Transport and/or the
-        Slip Transport.  You'll need at least one of them, but may choose
-        more than one without conflict.  If you don't need UML networking,
-        say N.
+	  The Ethertap User-Mode Linux network transport allows a single
+	  running UML to exchange packets with its host over one of the
+	  host's Ethertap devices, such as /dev/tap0.  Additional running
+	  UMLs can use additional Ethertap devices, one per running UML.
+	  While the UML believes it's on a (multi-device, broadcast) virtual
+	  Ethernet network, it's in fact communicating over a point-to-point
+	  link with the host.
+
+	  To use this, your host kernel must have support for Ethertap
+	  devices.  Also, if your host kernel is 2.4.x, it must have
+	  CONFIG_NETLINK_DEV configured as Y or M.
+
+	  For more information, see
+	  <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
+	  has examples of the UML command line to use to enable Ethertap
+	  networking.
+
+	  If you'd like to set up an IP network with the host and/or the
+	  outside world, say Y to this, the Daemon Transport and/or the
+	  Slip Transport.  You'll need at least one of them, but may choose
+	  more than one without conflict.  If you don't need UML networking,
+	  say N.
 
 config UML_NET_TUNTAP
 	bool "TUN/TAP transport"
 	depends on UML_NET
 	help
-        The UML TUN/TAP network transport allows a UML instance to exchange
-        packets with the host over a TUN/TAP device.  This option will only
-        work with a 2.4 host, unless you've applied the TUN/TAP patch to
-        your 2.2 host kernel.
+	  The UML TUN/TAP network transport allows a UML instance to exchange
+	  packets with the host over a TUN/TAP device.  This option will only
+	  work with a 2.4 host, unless you've applied the TUN/TAP patch to
+	  your 2.2 host kernel.
 
-        To use this transport, your host kernel must have support for TUN/TAP
-        devices, either built-in or as a module.
+	  To use this transport, your host kernel must have support for TUN/TAP
+	  devices, either built-in or as a module.
 
 config UML_NET_SLIP
 	bool "SLIP transport"
 	depends on UML_NET
 	help
-        The slip User-Mode Linux network transport allows a running UML to
-        network with its host over a point-to-point link.  Unlike Ethertap,
-        which can carry any Ethernet frame (and hence even non-IP packets),
-        the slip transport can only carry IP packets.
-
-        To use this, your host must support slip devices.
-
-        For more information, see
-        <http://user-mode-linux.sourceforge.net/old/networking.html>.
-        has examples of the UML command line to use to enable slip
-        networking, and details of a few quirks with it.
-
-        The Ethertap Transport is preferred over slip because of its
-        limitations.  If you prefer slip, however, say Y here.  Otherwise
-        choose the Multicast transport (to network multiple UMLs on
-        multiple hosts), Ethertap (to network with the host and the
-        outside world), and/or the Daemon transport (to network multiple
-        UMLs on a single host).  You may choose more than one without
-        conflict.  If you don't need UML networking, say N.
+	  The slip User-Mode Linux network transport allows a running UML to
+	  network with its host over a point-to-point link.  Unlike Ethertap,
+	  which can carry any Ethernet frame (and hence even non-IP packets),
+	  the slip transport can only carry IP packets.
+
+	  To use this, your host must support slip devices.
+
+	  For more information, see
+	  <http://user-mode-linux.sourceforge.net/old/networking.html>.
+	  has examples of the UML command line to use to enable slip
+	  networking, and details of a few quirks with it.
+
+	  The Ethertap Transport is preferred over slip because of its
+	  limitations.  If you prefer slip, however, say Y here.  Otherwise
+	  choose the Multicast transport (to network multiple UMLs on
+	  multiple hosts), Ethertap (to network with the host and the
+	  outside world), and/or the Daemon transport (to network multiple
+	  UMLs on a single host).  You may choose more than one without
+	  conflict.  If you don't need UML networking, say N.
 
 config UML_NET_DAEMON
 	bool "Daemon transport"
 	depends on UML_NET
 	help
-        This User-Mode Linux network transport allows one or more running
-        UMLs on a single host to communicate with each other, but not to
-        the host.
-
-        To use this form of networking, you'll need to run the UML
-        networking daemon on the host.
-
-        For more information, see
-        <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
-        has examples of the UML command line to use to enable Daemon
-        networking.
-
-        If you'd like to set up a network with other UMLs on a single host,
-        say Y.  If you need a network between UMLs on multiple physical
-        hosts, choose the Multicast Transport.  To set up a network with
-        the host and/or other IP machines, say Y to the Ethertap or Slip
-        transports.  You'll need at least one of them, but may choose
-        more than one without conflict.  If you don't need UML networking,
-        say N.
+	  This User-Mode Linux network transport allows one or more running
+	  UMLs on a single host to communicate with each other, but not to
+	  the host.
+
+	  To use this form of networking, you'll need to run the UML
+	  networking daemon on the host.
+
+	  For more information, see
+	  <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
+	  has examples of the UML command line to use to enable Daemon
+	  networking.
+
+	  If you'd like to set up a network with other UMLs on a single host,
+	  say Y.  If you need a network between UMLs on multiple physical
+	  hosts, choose the Multicast Transport.  To set up a network with
+	  the host and/or other IP machines, say Y to the Ethertap or Slip
+	  transports.  You'll need at least one of them, but may choose
+	  more than one without conflict.  If you don't need UML networking,
+	  say N.
 
 config UML_NET_VECTOR
 	bool "Vector I/O high performance network devices"
@@ -270,26 +260,26 @@ config UML_NET_MCAST
 	bool "Multicast transport"
 	depends on UML_NET
 	help
-        This Multicast User-Mode Linux network transport allows multiple
-        UMLs (even ones running on different host machines!) to talk to
-        each other over a virtual ethernet network.  However, it requires
-        at least one UML with one of the other transports to act as a
-        bridge if any of them need to be able to talk to their hosts or any
-        other IP machines.
-
-        To use this, your host kernel(s) must support IP Multicasting.
-
-        For more information, see
-        <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
-        has examples of the UML command line to use to enable Multicast
-        networking, and notes about the security of this approach.
-
-        If you need UMLs on multiple physical hosts to communicate as if
-        they shared an Ethernet network, say Y.  If you need to communicate
-        with other IP machines, make sure you select one of the other
-        transports (possibly in addition to Multicast; they're not
-        exclusive).  If you don't need to network UMLs say N to each of
-        the transports.
+	  This Multicast User-Mode Linux network transport allows multiple
+	  UMLs (even ones running on different host machines!) to talk to
+	  each other over a virtual ethernet network.  However, it requires
+	  at least one UML with one of the other transports to act as a
+	  bridge if any of them need to be able to talk to their hosts or any
+	  other IP machines.
+
+	  To use this, your host kernel(s) must support IP Multicasting.
+
+	  For more information, see
+	  <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
+	  has examples of the UML command line to use to enable Multicast
+	  networking, and notes about the security of this approach.
+
+	  If you need UMLs on multiple physical hosts to communicate as if
+	  they shared an Ethernet network, say Y.  If you need to communicate
+	  with other IP machines, make sure you select one of the other
+	  transports (possibly in addition to Multicast; they're not
+	  exclusive).  If you don't need to network UMLs say N to each of
+	  the transports.
 
 config UML_NET_PCAP
 	bool "pcap transport"
@@ -300,9 +290,9 @@ config UML_NET_PCAP
 	UML act as a network monitor for the host.  You must have libcap
 	installed in order to build the pcap transport into UML.
 
-        For more information, see
-        <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
-        has examples of the UML command line to use to enable this option.
+	  For more information, see
+	  <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
+	  has examples of the UML command line to use to enable this option.
 
 	If you intend to use UML as a network monitor for the host, say
 	Y here.  Otherwise, say N.
@@ -311,27 +301,27 @@ config UML_NET_SLIRP
 	bool "SLiRP transport"
 	depends on UML_NET
 	help
-        The SLiRP User-Mode Linux network transport allows a running UML
-        to network by invoking a program that can handle SLIP encapsulated
-        packets.  This is commonly (but not limited to) the application
-        known as SLiRP, a program that can re-socket IP packets back onto
-        the host on which it is run.  Only IP packets are supported,
-        unlike other network transports that can handle all Ethernet
-        frames.  In general, slirp allows the UML the same IP connectivity
-        to the outside world that the host user is permitted, and unlike
-        other transports, SLiRP works without the need of root level
-        privleges, setuid binaries, or SLIP devices on the host.  This
-        also means not every type of connection is possible, but most
-        situations can be accommodated with carefully crafted slirp
-        commands that can be passed along as part of the network device's
-        setup string.  The effect of this transport on the UML is similar
-        that of a host behind a firewall that masquerades all network
-        connections passing through it (but is less secure).
-
-        To use this you should first have slirp compiled somewhere
-        accessible on the host, and have read its documentation.  If you
-        don't need UML networking, say N.
-
-        Startup example: "eth0=slirp,FE:FD:01:02:03:04,/usr/local/bin/slirp"
+	  The SLiRP User-Mode Linux network transport allows a running UML
+	  to network by invoking a program that can handle SLIP encapsulated
+	  packets.  This is commonly (but not limited to) the application
+	  known as SLiRP, a program that can re-socket IP packets back onto
+	  he host on which it is run.  Only IP packets are supported,
+	  unlike other network transports that can handle all Ethernet
+	  frames.  In general, slirp allows the UML the same IP connectivity
+	  to the outside world that the host user is permitted, and unlike
+	  other transports, SLiRP works without the need of root level
+	  privleges, setuid binaries, or SLIP devices on the host.  This
+	  also means not every type of connection is possible, but most
+	  situations can be accommodated with carefully crafted slirp
+	  commands that can be passed along as part of the network device's
+	  setup string.  The effect of this transport on the UML is similar
+	  that of a host behind a firewall that masquerades all network
+	  connections passing through it (but is less secure).
+
+	  To use this you should first have slirp compiled somewhere
+	  accessible on the host, and have read its documentation.  If you
+	  don't need UML networking, say N.
+
+	  Startup example: "eth0=slirp,FE:FD:01:02:03:04,/usr/local/bin/slirp"
 
 endmenu
diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index 693319839f69..d945abf90c31 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -52,7 +52,7 @@ obj-$(CONFIG_UML_NET) += net.o
 obj-$(CONFIG_MCONSOLE) += mconsole.o
 obj-$(CONFIG_MMAPPER) += mmapper_kern.o 
 obj-$(CONFIG_BLK_DEV_UBD) += ubd.o 
-obj-$(CONFIG_HOSTAUDIO) += hostaudio.o
+obj-$(CONFIG_UML_SOUND) += hostaudio.o
 obj-$(CONFIG_NULL_CHAN) += null.o 
 obj-$(CONFIG_PORT_CHAN) += port.o
 obj-$(CONFIG_PTY_CHAN) += pty.o
diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 4699acd602af..62810550024d 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -89,12 +89,6 @@ static inline int cpu_has_svm(const char **msg)
 		return 0;
 	}
 
-	if (boot_cpu_data.extended_cpuid_level < SVM_CPUID_FUNC) {
-		if (msg)
-			*msg = "can't execute cpuid_8000000a";
-		return 0;
-	}
-
 	if (!boot_cpu_has(X86_FEATURE_SVM)) {
 		if (msg)
 			*msg = "svm not available";
diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index f7151cd03cb0..3d7a8049f637 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -246,12 +246,6 @@
 extern int (*console_blank_hook)(int);
 #endif
 
-/*
- * The apm_bios device is one of the misc char devices.
- * This is its minor number.
- */
-#define	APM_MINOR_DEV	134
-
 /*
  * Various options can be changed at boot time as follows:
  * (We allow underscores for compatibility with the modules code)
diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 9338b4558cdc..1d25ba3775da 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -134,6 +134,11 @@ int x509_check_for_self_signed(struct x509_certificate *cert)
 	if (strcmp(cert->pub->pkey_algo, cert->sig->pkey_algo) != 0)
 		goto out;
 
+	if (cert->unsupported_sig) {
+		ret = 0;
+		goto out;
+	}
+
 	ret = public_key_verify_signature(cert->pub, cert->sig);
 	if (ret < 0) {
 		if (ret == -ENOPKG) {
diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
index 8d7dc98bad17..ca01e02af9cb 100644
--- a/drivers/acpi/acpica/psopcode.c
+++ b/drivers/acpi/acpica/psopcode.c
@@ -603,7 +603,7 @@ const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES] = {
 
 /* 7E */ ACPI_OP("Timer", ARGP_TIMER_OP, ARGI_TIMER_OP, ACPI_TYPE_ANY,
 			 AML_CLASS_EXECUTE, AML_TYPE_EXEC_0A_0T_1R,
-			 AML_FLAGS_EXEC_0A_0T_1R),
+			 AML_FLAGS_EXEC_0A_0T_1R | AML_NO_OPERAND_RESOLVE),
 
 /* ACPI 5.0 opcodes */
 
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index b4f16073ef43..866bc20c8239 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -294,6 +294,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_BOARD_NAME, "Lenovo IdeaPad S405"),
 		},
 	},
+	{
+	 /* https://bugzilla.suse.com/show_bug.cgi?id=1208724 */
+	 .callback = video_detect_force_native,
+	 /* Lenovo Ideapad Z470 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Z470"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1187004 */
 	 .callback = video_detect_force_native,
diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index e1992f361c9a..2aaec96f8384 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -349,6 +349,7 @@ static void amba_device_release(struct device *dev)
 {
 	struct amba_device *d = to_amba_device(dev);
 
+	of_node_put(d->dev.of_node);
 	if (d->res.parent)
 		release_resource(&d->res);
 	kfree(d);
diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
index 569a4a662dcd..9da2e14a0108 100644
--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -569,6 +569,7 @@ static struct platform_driver pata_ftide010_driver = {
 };
 module_platform_driver(pata_ftide010_driver);
 
+MODULE_DESCRIPTION("low level driver for Faraday Technology FTIDE010");
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index 46950e0267e0..64b43943f650 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -434,6 +434,7 @@ static struct platform_driver gemini_sata_driver = {
 };
 module_platform_driver(gemini_sata_driver);
 
+MODULE_DESCRIPTION("low level driver for Cortina Systems Gemini SATA bridge");
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index e9b7ce8c272c..7353c5527087 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -291,7 +291,7 @@ static int regcache_rbtree_insert_to_block(struct regmap *map,
 
 	blk = krealloc(rbnode->block,
 		       blklen * map->cache_word_size,
-		       GFP_KERNEL);
+		       map->alloc_flags);
 	if (!blk)
 		return -ENOMEM;
 
@@ -300,7 +300,7 @@ static int regcache_rbtree_insert_to_block(struct regmap *map,
 	if (BITS_TO_LONGS(blklen) > BITS_TO_LONGS(rbnode->blklen)) {
 		present = krealloc(rbnode->cache_present,
 				   BITS_TO_LONGS(blklen) * sizeof(*present),
-				   GFP_KERNEL);
+				   map->alloc_flags);
 		if (!present)
 			return -ENOMEM;
 
@@ -334,7 +334,7 @@ regcache_rbtree_node_alloc(struct regmap *map, unsigned int reg)
 	const struct regmap_range *range;
 	int i;
 
-	rbnode = kzalloc(sizeof(*rbnode), GFP_KERNEL);
+	rbnode = kzalloc(sizeof(*rbnode), map->alloc_flags);
 	if (!rbnode)
 		return NULL;
 
@@ -360,13 +360,13 @@ regcache_rbtree_node_alloc(struct regmap *map, unsigned int reg)
 	}
 
 	rbnode->block = kmalloc_array(rbnode->blklen, map->cache_word_size,
-				      GFP_KERNEL);
+				      map->alloc_flags);
 	if (!rbnode->block)
 		goto err_free;
 
 	rbnode->cache_present = kcalloc(BITS_TO_LONGS(rbnode->blklen),
 					sizeof(*rbnode->cache_present),
-					GFP_KERNEL);
+					map->alloc_flags);
 	if (!rbnode->cache_present)
 		goto err_free_block;
 
diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 20142bc77554..1325b1df4a8e 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -356,6 +356,7 @@ static void btsdio_remove(struct sdio_func *func)
 	if (!data)
 		return;
 
+	cancel_work_sync(&data->work);
 	hdev = data->hdev;
 
 	sdio_set_drvdata(func, NULL);
diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index 2dc33e65d2d0..5f6c6930b5bd 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -743,7 +743,11 @@ static int nokia_bluetooth_serdev_probe(struct serdev_device *serdev)
 		return err;
 	}
 
-	clk_prepare_enable(sysclk);
+	err = clk_prepare_enable(sysclk);
+	if (err) {
+		dev_err(dev, "could not enable sysclk: %d", err);
+		return err;
+	}
 	btdev->sysclk_speed = clk_get_rate(sysclk);
 	clk_disable_unprepare(sysclk);
 
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 8c7a1b8f9689..3eb226940948 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2119,6 +2119,11 @@ static int try_smi_init(struct smi_info *new_smi)
 		new_smi->io.io_cleanup = NULL;
 	}
 
+	if (rv && new_smi->si_sm) {
+		kfree(new_smi->si_sm);
+		new_smi->si_sm = NULL;
+	}
+
 	kfree(init_name);
 	return rv;
 }
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 430a9eac67e1..d1869b9a2ffd 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -425,10 +425,17 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 	int rc;
 	u32 ordinal;
 	unsigned long dur;
-
-	rc = tpm_tis_send_data(chip, buf, len);
-	if (rc < 0)
-		return rc;
+	unsigned int try;
+
+	for (try = 0; try < TPM_RETRY; try++) {
+		rc = tpm_tis_send_data(chip, buf, len);
+		if (rc >= 0)
+			/* Data transfer done successfully */
+			break;
+		else if (rc != -EIO)
+			/* Data transfer failed, not recoverable */
+			return rc;
+	}
 
 	/* go and do it */
 	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
diff --git a/drivers/clk/keystone/pll.c b/drivers/clk/keystone/pll.c
index e7e840fb74ea..526694c2a6c9 100644
--- a/drivers/clk/keystone/pll.c
+++ b/drivers/clk/keystone/pll.c
@@ -213,7 +213,7 @@ static void __init _of_pll_clk_init(struct device_node *node, bool pllctrl)
 	}
 
 	clk = clk_register_pll(NULL, node->name, parent_name, pll_data);
-	if (clk) {
+	if (!IS_ERR_OR_NULL(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		return;
 	}
diff --git a/drivers/clk/qcom/gcc-mdm9615.c b/drivers/clk/qcom/gcc-mdm9615.c
index 849046fbed6d..3df830cdfd01 100644
--- a/drivers/clk/qcom/gcc-mdm9615.c
+++ b/drivers/clk/qcom/gcc-mdm9615.c
@@ -66,7 +66,7 @@ static struct clk_regmap pll0_vote = {
 	.enable_mask = BIT(0),
 	.hw.init = &(struct clk_init_data){
 		.name = "pll0_vote",
-		.parent_names = (const char *[]){ "pll8" },
+		.parent_names = (const char *[]){ "pll0" },
 		.num_parents = 1,
 		.ops = &clk_pll_vote_ops,
 	},
diff --git a/drivers/clk/sunxi-ng/ccu_mmc_timing.c b/drivers/clk/sunxi-ng/ccu_mmc_timing.c
index f9869f7353c0..9356dc157156 100644
--- a/drivers/clk/sunxi-ng/ccu_mmc_timing.c
+++ b/drivers/clk/sunxi-ng/ccu_mmc_timing.c
@@ -50,7 +50,7 @@ int sunxi_ccu_set_mmc_timing_mode(struct clk *clk, bool new_mode)
 EXPORT_SYMBOL_GPL(sunxi_ccu_set_mmc_timing_mode);
 
 /**
- * sunxi_ccu_set_mmc_timing_mode: Get the current MMC clock timing mode
+ * sunxi_ccu_get_mmc_timing_mode: Get the current MMC clock timing mode
  * @clk: clock to query
  *
  * Returns 0 if the clock is in old timing mode, > 0 if it is in
diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index a3c82f530d60..541486217984 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -410,7 +410,11 @@ brcm_avs_get_freq_table(struct device *dev, struct private_data *priv)
 	if (ret)
 		return ERR_PTR(ret);
 
-	table = devm_kcalloc(dev, AVS_PSTATE_MAX + 1, sizeof(*table),
+	/*
+	 * We allocate space for the 5 different P-STATES AVS,
+	 * plus extra space for a terminating element.
+	 */
+	table = devm_kcalloc(dev, AVS_PSTATE_MAX + 1 + 1, sizeof(*table),
 			     GFP_KERNEL);
 	if (!table)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 818f92798fb9..55743d78016b 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -1104,7 +1104,8 @@ static int powernowk8_cpu_exit(struct cpufreq_policy *pol)
 
 	kfree(data->powernow_table);
 	kfree(data);
-	for_each_cpu(cpu, pol->cpus)
+	/* pol->cpus will be empty here, use related_cpus instead. */
+	for_each_cpu(cpu, pol->related_cpus)
 		per_cpu(powernow_data, cpu) = NULL;
 
 	return 0;
diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index f26d62e5533a..701e4ad8077b 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -194,7 +194,9 @@ static int caam_rsa_count_leading_zeros(struct scatterlist *sgl,
 		if (len && *buff)
 			break;
 
-		sg_miter_next(&miter);
+		if (!sg_miter_next(&miter))
+			break;
+
 		buff = miter.addr;
 		len = miter.length;
 
diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index 641b11077f47..015f349bf66b 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -578,9 +578,9 @@ static int stm32_hash_dma_send(struct stm32_hash_dev *hdev)
 	}
 
 	for_each_sg(rctx->sg, tsg, rctx->nents, i) {
+		sg[0] = *tsg;
 		len = sg->length;
 
-		sg[0] = *tsg;
 		if (sg_is_last(sg)) {
 			if (hdev->dma_mode == 1) {
 				len = (ALIGN(sg->length, 16) - 16);
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 06a981c72246..91e8b248e815 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -582,6 +582,7 @@ static void devfreq_dev_release(struct device *dev)
 		devfreq->profile->exit(devfreq->dev.parent);
 
 	mutex_destroy(&devfreq->lock);
+	srcu_cleanup_notifier_head(&devfreq->transition_notifier_list);
 	kfree(devfreq);
 }
 
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index e5f31af65aab..00e1ffa4fcf1 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -212,6 +212,7 @@ config FSL_DMA
 config FSL_EDMA
 	tristate "Freescale eDMA engine support"
 	depends on OF
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -258,6 +259,7 @@ config IMX_SDMA
 
 config INTEL_IDMA64
 	tristate "Intel integrated DMA 64-bit support"
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index e588dc5daaa8..e9d76113c9e9 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3584,6 +3584,10 @@ static int __init d40_probe(struct platform_device *pdev)
 	spin_lock_init(&base->lcla_pool.lock);
 
 	base->irq = platform_get_irq(pdev, 0);
+	if (base->irq < 0) {
+		ret = base->irq;
+		goto destroy_cache;
+	}
 
 	ret = request_irq(base->irq, d40_handle_interrupt, 0, D40_NAME, base);
 	if (ret) {
diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index 04d10ea8d343..a7fc04bf6550 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -1438,3 +1438,4 @@ static struct platform_driver fsi_master_acf = {
 
 module_platform_driver(fsi_master_acf);
 MODULE_LICENSE("GPL");
+MODULE_FIRMWARE(FW_FILE_NAME);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 787cbeea8dc5..c84f475d4f13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -735,6 +735,9 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	u16 cmd;
 	int r;
 
+	if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
+		return 0;
+
 	/* Bypass for VF */
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 78ab939ae5d8..7ff16edcda26 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1377,7 +1377,6 @@ static int cik_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
 static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 {
 	struct pci_dev *root = adev->pdev->bus->self;
-	int bridge_pos, gpu_pos;
 	u32 speed_cntl, current_data_rate;
 	int i;
 	u16 tmp16;
@@ -1412,12 +1411,7 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 		DRM_INFO("enabling PCIE gen 2 link speeds, disable with amdgpu.pcie_gen2=0\n");
 	}
 
-	bridge_pos = pci_pcie_cap(root);
-	if (!bridge_pos)
-		return;
-
-	gpu_pos = pci_pcie_cap(adev->pdev);
-	if (!gpu_pos)
+	if (!pci_is_pcie(root) || !pci_is_pcie(adev->pdev))
 		return;
 
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) {
@@ -1427,14 +1421,8 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 			u16 bridge_cfg2, gpu_cfg2;
 			u32 max_lw, current_lw, tmp;
 
-			pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
-			pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
-
-			tmp16 = bridge_cfg | PCI_EXP_LNKCTL_HAWD;
-			pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
-
-			tmp16 = gpu_cfg | PCI_EXP_LNKCTL_HAWD;
-			pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
+			pcie_capability_set_word(root, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
+			pcie_capability_set_word(adev->pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
 
 			tmp = RREG32_PCIE(ixPCIE_LC_STATUS1);
 			max_lw = (tmp & PCIE_LC_STATUS1__LC_DETECTED_LINK_WIDTH_MASK) >>
@@ -1458,15 +1446,23 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 
 			for (i = 0; i < 10; i++) {
 				/* check status */
-				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_DEVSTA, &tmp16);
+				pcie_capability_read_word(adev->pdev,
+							  PCI_EXP_DEVSTA,
+							  &tmp16);
 				if (tmp16 & PCI_EXP_DEVSTA_TRPND)
 					break;
 
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
-				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
+				pcie_capability_read_word(root, PCI_EXP_LNKCTL,
+							  &bridge_cfg);
+				pcie_capability_read_word(adev->pdev,
+							  PCI_EXP_LNKCTL,
+							  &gpu_cfg);
 
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &bridge_cfg2);
-				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &gpu_cfg2);
+				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
+							  &bridge_cfg2);
+				pcie_capability_read_word(adev->pdev,
+							  PCI_EXP_LNKCTL2,
+							  &gpu_cfg2);
 
 				tmp = RREG32_PCIE(ixPCIE_LC_CNTL4);
 				tmp |= PCIE_LC_CNTL4__LC_SET_QUIESCE_MASK;
@@ -1479,26 +1475,38 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 				msleep(100);
 
 				/* linkctl */
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (bridge_cfg & PCI_EXP_LNKCTL_HAWD);
-				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
-
-				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (gpu_cfg & PCI_EXP_LNKCTL_HAWD);
-				pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
+				pcie_capability_clear_and_set_word(root, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   bridge_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
+				pcie_capability_clear_and_set_word(adev->pdev, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   gpu_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
 
 				/* linkctl2 */
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 9));
-				tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 9)));
-				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, tmp16);
-
-				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 9));
-				tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 9)));
-				pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
+				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
+							  &tmp16);
+				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN);
+				tmp16 |= (bridge_cfg2 &
+					  (PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN));
+				pcie_capability_write_word(root,
+							   PCI_EXP_LNKCTL2,
+							   tmp16);
+
+				pcie_capability_read_word(adev->pdev,
+							  PCI_EXP_LNKCTL2,
+							  &tmp16);
+				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN);
+				tmp16 |= (gpu_cfg2 &
+					  (PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN));
+				pcie_capability_write_word(adev->pdev,
+							   PCI_EXP_LNKCTL2,
+							   tmp16);
 
 				tmp = RREG32_PCIE(ixPCIE_LC_CNTL4);
 				tmp &= ~PCIE_LC_CNTL4__LC_SET_QUIESCE_MASK;
@@ -1513,15 +1521,16 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 	speed_cntl &= ~PCIE_LC_SPEED_CNTL__LC_FORCE_DIS_SW_SPEED_CHANGE_MASK;
 	WREG32_PCIE(ixPCIE_LC_SPEED_CNTL, speed_cntl);
 
-	pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-	tmp16 &= ~0xf;
+	pcie_capability_read_word(adev->pdev, PCI_EXP_LNKCTL2, &tmp16);
+	tmp16 &= ~PCI_EXP_LNKCTL2_TLS;
+
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
-		tmp16 |= 3; /* gen3 */
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_8_0GT; /* gen3 */
 	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)
-		tmp16 |= 2; /* gen2 */
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_5_0GT; /* gen2 */
 	else
-		tmp16 |= 1; /* gen1 */
-	pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_2_5GT; /* gen1 */
+	pcie_capability_write_word(adev->pdev, PCI_EXP_LNKCTL2, tmp16);
 
 	speed_cntl = RREG32_PCIE(ixPCIE_LC_SPEED_CNTL);
 	speed_cntl |= PCIE_LC_SPEED_CNTL__LC_INITIATE_LINK_SPEED_CHANGE_MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 77c9f4d8668a..580d74f26b69 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1558,7 +1558,6 @@ static void si_init_golden_registers(struct amdgpu_device *adev)
 static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 {
 	struct pci_dev *root = adev->pdev->bus->self;
-	int bridge_pos, gpu_pos;
 	u32 speed_cntl, current_data_rate;
 	int i;
 	u16 tmp16;
@@ -1593,12 +1592,7 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 		DRM_INFO("enabling PCIE gen 2 link speeds, disable with amdgpu.pcie_gen2=0\n");
 	}
 
-	bridge_pos = pci_pcie_cap(root);
-	if (!bridge_pos)
-		return;
-
-	gpu_pos = pci_pcie_cap(adev->pdev);
-	if (!gpu_pos)
+	if (!pci_is_pcie(root) || !pci_is_pcie(adev->pdev))
 		return;
 
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) {
@@ -1607,14 +1601,8 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 			u16 bridge_cfg2, gpu_cfg2;
 			u32 max_lw, current_lw, tmp;
 
-			pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
-			pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
-
-			tmp16 = bridge_cfg | PCI_EXP_LNKCTL_HAWD;
-			pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
-
-			tmp16 = gpu_cfg | PCI_EXP_LNKCTL_HAWD;
-			pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
+			pcie_capability_set_word(root, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
+			pcie_capability_set_word(adev->pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
 
 			tmp = RREG32_PCIE(PCIE_LC_STATUS1);
 			max_lw = (tmp & LC_DETECTED_LINK_WIDTH_MASK) >> LC_DETECTED_LINK_WIDTH_SHIFT;
@@ -1631,15 +1619,23 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 			}
 
 			for (i = 0; i < 10; i++) {
-				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_DEVSTA, &tmp16);
+				pcie_capability_read_word(adev->pdev,
+							  PCI_EXP_DEVSTA,
+							  &tmp16);
 				if (tmp16 & PCI_EXP_DEVSTA_TRPND)
 					break;
 
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
-				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
+				pcie_capability_read_word(root, PCI_EXP_LNKCTL,
+							  &bridge_cfg);
+				pcie_capability_read_word(adev->pdev,
+							  PCI_EXP_LNKCTL,
+							  &gpu_cfg);
 
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &bridge_cfg2);
-				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &gpu_cfg2);
+				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
+							  &bridge_cfg2);
+				pcie_capability_read_word(adev->pdev,
+							  PCI_EXP_LNKCTL2,
+							  &gpu_cfg2);
 
 				tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
 				tmp |= LC_SET_QUIESCE;
@@ -1651,25 +1647,37 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 
 				mdelay(100);
 
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (bridge_cfg & PCI_EXP_LNKCTL_HAWD);
-				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
-
-				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (gpu_cfg & PCI_EXP_LNKCTL_HAWD);
-				pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
-
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 9));
-				tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 9)));
-				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, tmp16);
-
-				pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 9));
-				tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 9)));
-				pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
+				pcie_capability_clear_and_set_word(root, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   bridge_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
+				pcie_capability_clear_and_set_word(adev->pdev, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   gpu_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
+
+				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
+							  &tmp16);
+				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN);
+				tmp16 |= (bridge_cfg2 &
+					  (PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN));
+				pcie_capability_write_word(root,
+							   PCI_EXP_LNKCTL2,
+							   tmp16);
+
+				pcie_capability_read_word(adev->pdev,
+							  PCI_EXP_LNKCTL2,
+							  &tmp16);
+				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN);
+				tmp16 |= (gpu_cfg2 &
+					  (PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN));
+				pcie_capability_write_word(adev->pdev,
+							   PCI_EXP_LNKCTL2,
+							   tmp16);
 
 				tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
 				tmp &= ~LC_SET_QUIESCE;
@@ -1682,15 +1690,16 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 	speed_cntl &= ~LC_FORCE_DIS_SW_SPEED_CHANGE;
 	WREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL, speed_cntl);
 
-	pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-	tmp16 &= ~0xf;
+	pcie_capability_read_word(adev->pdev, PCI_EXP_LNKCTL2, &tmp16);
+	tmp16 &= ~PCI_EXP_LNKCTL2_TLS;
+
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
-		tmp16 |= 3;
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_8_0GT; /* gen3 */
 	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)
-		tmp16 |= 2;
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_5_0GT; /* gen2 */
 	else
-		tmp16 |= 1;
-	pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_2_5GT; /* gen1 */
+	pcie_capability_write_word(adev->pdev, PCI_EXP_LNKCTL2, tmp16);
 
 	speed_cntl = RREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL);
 	speed_cntl |= LC_INITIATE_LINK_SPEED_CHANGE;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
index 958994edf2c4..12d043521c07 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
@@ -193,8 +193,9 @@ struct mpcc *mpc1_insert_plane(
 		/* check insert_above_mpcc exist in tree->opp_list */
 		struct mpcc *temp_mpcc = tree->opp_list;
 
-		while (temp_mpcc && temp_mpcc->mpcc_bot != insert_above_mpcc)
-			temp_mpcc = temp_mpcc->mpcc_bot;
+		if (temp_mpcc != insert_above_mpcc)
+			while (temp_mpcc && temp_mpcc->mpcc_bot != insert_above_mpcc)
+				temp_mpcc = temp_mpcc->mpcc_bot;
 		if (temp_mpcc == NULL)
 			return NULL;
 	}
diff --git a/drivers/gpu/drm/ast/ast_post.c b/drivers/gpu/drm/ast/ast_post.c
index c1d1ac51d1c2..1f09cb9691f8 100644
--- a/drivers/gpu/drm/ast/ast_post.c
+++ b/drivers/gpu/drm/ast/ast_post.c
@@ -291,7 +291,7 @@ static void ast_init_dram_reg(struct drm_device *dev)
 				;
 			} while (ast_read32(ast, 0x10100) != 0xa8);
 		} else {/* AST2100/1100 */
-			if (ast->chip == AST2100 || ast->chip == 2200)
+			if (ast->chip == AST2100 || ast->chip == AST2200)
 				dram_reg_info = ast2100_dram_table_data;
 			else
 				dram_reg_info = ast1100_dram_table_data;
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 31b75d3ca6e9..85aba4c38dc0 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -756,8 +756,13 @@ static void adv7511_mode_set(struct adv7511 *adv7511,
 	else
 		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_NONE;
 
-	regmap_update_bits(adv7511->regmap, 0xfb,
-		0x6, low_refresh_rate << 1);
+	if (adv7511->type == ADV7511)
+		regmap_update_bits(adv7511->regmap, 0xfb,
+				   0x6, low_refresh_rate << 1);
+	else
+		regmap_update_bits(adv7511->regmap, 0x4a,
+				   0xc, low_refresh_rate << 2);
+
 	regmap_update_bits(adv7511->regmap, 0x17,
 		0x60, (vsync_polarity << 6) | (hsync_polarity << 5));
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_crtc.c b/drivers/gpu/drm/exynos/exynos_drm_crtc.c
index 2696289ecc78..b3e23ace5869 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_crtc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_crtc.c
@@ -43,13 +43,12 @@ static void exynos_drm_crtc_atomic_disable(struct drm_crtc *crtc,
 	if (exynos_crtc->ops->disable)
 		exynos_crtc->ops->disable(exynos_crtc);
 
+	spin_lock_irq(&crtc->dev->event_lock);
 	if (crtc->state->event && !crtc->state->active) {
-		spin_lock_irq(&crtc->dev->event_lock);
 		drm_crtc_send_vblank_event(crtc, crtc->state->event);
-		spin_unlock_irq(&crtc->dev->event_lock);
-
 		crtc->state->event = NULL;
 	}
+	spin_unlock_irq(&crtc->dev->event_lock);
 }
 
 static int exynos_crtc_atomic_check(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
index 501d7989b9a5..cd5b9ee22a5b 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
@@ -185,7 +185,7 @@ static void mdp5_plane_reset(struct drm_plane *plane)
 	struct mdp5_plane_state *mdp5_state;
 
 	if (plane->state && plane->state->fb)
-		drm_framebuffer_unreference(plane->state->fb);
+		drm_framebuffer_put(plane->state->fb);
 
 	kfree(to_mdp5_plane_state(plane->state));
 	plane->state = NULL;
@@ -230,8 +230,7 @@ static void mdp5_plane_destroy_state(struct drm_plane *plane,
 {
 	struct mdp5_plane_state *pstate = to_mdp5_plane_state(state);
 
-	if (state->fb)
-		drm_framebuffer_unreference(state->fb);
+	__drm_atomic_helper_plane_destroy_state(state);
 
 	kfree(pstate);
 }
diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 827d551962d9..643f74c231c5 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -9500,7 +9500,6 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
 {
 	struct pci_dev *root = rdev->pdev->bus->self;
 	enum pci_bus_speed speed_cap;
-	int bridge_pos, gpu_pos;
 	u32 speed_cntl, current_data_rate;
 	int i;
 	u16 tmp16;
@@ -9542,12 +9541,7 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
 		DRM_INFO("enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0\n");
 	}
 
-	bridge_pos = pci_pcie_cap(root);
-	if (!bridge_pos)
-		return;
-
-	gpu_pos = pci_pcie_cap(rdev->pdev);
-	if (!gpu_pos)
+	if (!pci_is_pcie(root) || !pci_is_pcie(rdev->pdev))
 		return;
 
 	if (speed_cap == PCIE_SPEED_8_0GT) {
@@ -9557,14 +9551,8 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
 			u16 bridge_cfg2, gpu_cfg2;
 			u32 max_lw, current_lw, tmp;
 
-			pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
-			pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
-
-			tmp16 = bridge_cfg | PCI_EXP_LNKCTL_HAWD;
-			pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
-
-			tmp16 = gpu_cfg | PCI_EXP_LNKCTL_HAWD;
-			pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
+			pcie_capability_set_word(root, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
+			pcie_capability_set_word(rdev->pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
 
 			tmp = RREG32_PCIE_PORT(PCIE_LC_STATUS1);
 			max_lw = (tmp & LC_DETECTED_LINK_WIDTH_MASK) >> LC_DETECTED_LINK_WIDTH_SHIFT;
@@ -9582,15 +9570,23 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
 
 			for (i = 0; i < 10; i++) {
 				/* check status */
-				pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_DEVSTA, &tmp16);
+				pcie_capability_read_word(rdev->pdev,
+							  PCI_EXP_DEVSTA,
+							  &tmp16);
 				if (tmp16 & PCI_EXP_DEVSTA_TRPND)
 					break;
 
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
-				pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
+				pcie_capability_read_word(root, PCI_EXP_LNKCTL,
+							  &bridge_cfg);
+				pcie_capability_read_word(rdev->pdev,
+							  PCI_EXP_LNKCTL,
+							  &gpu_cfg);
 
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &bridge_cfg2);
-				pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &gpu_cfg2);
+				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
+							  &bridge_cfg2);
+				pcie_capability_read_word(rdev->pdev,
+							  PCI_EXP_LNKCTL2,
+							  &gpu_cfg2);
 
 				tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
 				tmp |= LC_SET_QUIESCE;
@@ -9603,26 +9599,38 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
 				mdelay(100);
 
 				/* linkctl */
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (bridge_cfg & PCI_EXP_LNKCTL_HAWD);
-				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
-
-				pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (gpu_cfg & PCI_EXP_LNKCTL_HAWD);
-				pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
+				pcie_capability_clear_and_set_word(root, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   bridge_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
+				pcie_capability_clear_and_set_word(rdev->pdev, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   gpu_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
 
 				/* linkctl2 */
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 9));
-				tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 9)));
-				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, tmp16);
-
-				pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 9));
-				tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 9)));
-				pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
+				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
+							  &tmp16);
+				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN);
+				tmp16 |= (bridge_cfg2 &
+					  (PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN));
+				pcie_capability_write_word(root,
+							   PCI_EXP_LNKCTL2,
+							   tmp16);
+
+				pcie_capability_read_word(rdev->pdev,
+							  PCI_EXP_LNKCTL2,
+							  &tmp16);
+				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN);
+				tmp16 |= (gpu_cfg2 &
+					  (PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN));
+				pcie_capability_write_word(rdev->pdev,
+							   PCI_EXP_LNKCTL2,
+							   tmp16);
 
 				tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
 				tmp &= ~LC_SET_QUIESCE;
@@ -9636,15 +9644,15 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
 	speed_cntl &= ~LC_FORCE_DIS_SW_SPEED_CHANGE;
 	WREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL, speed_cntl);
 
-	pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-	tmp16 &= ~0xf;
+	pcie_capability_read_word(rdev->pdev, PCI_EXP_LNKCTL2, &tmp16);
+	tmp16 &= ~PCI_EXP_LNKCTL2_TLS;
 	if (speed_cap == PCIE_SPEED_8_0GT)
-		tmp16 |= 3; /* gen3 */
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_8_0GT; /* gen3 */
 	else if (speed_cap == PCIE_SPEED_5_0GT)
-		tmp16 |= 2; /* gen2 */
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_5_0GT; /* gen2 */
 	else
-		tmp16 |= 1; /* gen1 */
-	pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_2_5GT; /* gen1 */
+	pcie_capability_write_word(rdev->pdev, PCI_EXP_LNKCTL2, tmp16);
 
 	speed_cntl = RREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL);
 	speed_cntl |= LC_INITIATE_LINK_SPEED_CHANGE;
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 639f0698f961..644ddd8d65ad 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -3253,7 +3253,7 @@ static void si_gpu_init(struct radeon_device *rdev)
 		/* XXX what about 12? */
 		rdev->config.si.tile_config |= (3 << 0);
 		break;
-	}	
+	}
 	switch ((mc_arb_ramcfg & NOOFBANK_MASK) >> NOOFBANK_SHIFT) {
 	case 0: /* four banks */
 		rdev->config.si.tile_config |= 0 << 4;
@@ -7083,7 +7083,6 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
 {
 	struct pci_dev *root = rdev->pdev->bus->self;
 	enum pci_bus_speed speed_cap;
-	int bridge_pos, gpu_pos;
 	u32 speed_cntl, current_data_rate;
 	int i;
 	u16 tmp16;
@@ -7125,12 +7124,7 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
 		DRM_INFO("enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0\n");
 	}
 
-	bridge_pos = pci_pcie_cap(root);
-	if (!bridge_pos)
-		return;
-
-	gpu_pos = pci_pcie_cap(rdev->pdev);
-	if (!gpu_pos)
+	if (!pci_is_pcie(root) || !pci_is_pcie(rdev->pdev))
 		return;
 
 	if (speed_cap == PCIE_SPEED_8_0GT) {
@@ -7140,14 +7134,8 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
 			u16 bridge_cfg2, gpu_cfg2;
 			u32 max_lw, current_lw, tmp;
 
-			pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
-			pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
-
-			tmp16 = bridge_cfg | PCI_EXP_LNKCTL_HAWD;
-			pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
-
-			tmp16 = gpu_cfg | PCI_EXP_LNKCTL_HAWD;
-			pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
+			pcie_capability_set_word(root, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
+			pcie_capability_set_word(rdev->pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
 
 			tmp = RREG32_PCIE(PCIE_LC_STATUS1);
 			max_lw = (tmp & LC_DETECTED_LINK_WIDTH_MASK) >> LC_DETECTED_LINK_WIDTH_SHIFT;
@@ -7165,15 +7153,23 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
 
 			for (i = 0; i < 10; i++) {
 				/* check status */
-				pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_DEVSTA, &tmp16);
+				pcie_capability_read_word(rdev->pdev,
+							  PCI_EXP_DEVSTA,
+							  &tmp16);
 				if (tmp16 & PCI_EXP_DEVSTA_TRPND)
 					break;
 
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
-				pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
+				pcie_capability_read_word(root, PCI_EXP_LNKCTL,
+							  &bridge_cfg);
+				pcie_capability_read_word(rdev->pdev,
+							  PCI_EXP_LNKCTL,
+							  &gpu_cfg);
 
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &bridge_cfg2);
-				pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &gpu_cfg2);
+				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
+							  &bridge_cfg2);
+				pcie_capability_read_word(rdev->pdev,
+							  PCI_EXP_LNKCTL2,
+							  &gpu_cfg2);
 
 				tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
 				tmp |= LC_SET_QUIESCE;
@@ -7186,26 +7182,38 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
 				mdelay(100);
 
 				/* linkctl */
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (bridge_cfg & PCI_EXP_LNKCTL_HAWD);
-				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
-
-				pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (gpu_cfg & PCI_EXP_LNKCTL_HAWD);
-				pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
+				pcie_capability_clear_and_set_word(root, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   bridge_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
+				pcie_capability_clear_and_set_word(rdev->pdev, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   gpu_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
 
 				/* linkctl2 */
-				pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 9));
-				tmp16 |= (bridge_cfg2 & ((1 << 4) | (7 << 9)));
-				pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, tmp16);
-
-				pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-				tmp16 &= ~((1 << 4) | (7 << 9));
-				tmp16 |= (gpu_cfg2 & ((1 << 4) | (7 << 9)));
-				pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
+				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
+							  &tmp16);
+				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN);
+				tmp16 |= (bridge_cfg2 &
+					  (PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN));
+				pcie_capability_write_word(root,
+							   PCI_EXP_LNKCTL2,
+							   tmp16);
+
+				pcie_capability_read_word(rdev->pdev,
+							  PCI_EXP_LNKCTL2,
+							  &tmp16);
+				tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN);
+				tmp16 |= (gpu_cfg2 &
+					  (PCI_EXP_LNKCTL2_ENTER_COMP |
+					   PCI_EXP_LNKCTL2_TX_MARGIN));
+				pcie_capability_write_word(rdev->pdev,
+							   PCI_EXP_LNKCTL2,
+							   tmp16);
 
 				tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
 				tmp &= ~LC_SET_QUIESCE;
@@ -7219,15 +7227,15 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
 	speed_cntl &= ~LC_FORCE_DIS_SW_SPEED_CHANGE;
 	WREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL, speed_cntl);
 
-	pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
-	tmp16 &= ~0xf;
+	pcie_capability_read_word(rdev->pdev, PCI_EXP_LNKCTL2, &tmp16);
+	tmp16 &= ~PCI_EXP_LNKCTL2_TLS;
 	if (speed_cap == PCIE_SPEED_8_0GT)
-		tmp16 |= 3; /* gen3 */
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_8_0GT; /* gen3 */
 	else if (speed_cap == PCIE_SPEED_5_0GT)
-		tmp16 |= 2; /* gen2 */
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_5_0GT; /* gen2 */
 	else
-		tmp16 |= 1; /* gen1 */
-	pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
+		tmp16 |= PCI_EXP_LNKCTL2_TLS_2_5GT; /* gen1 */
+	pcie_capability_write_word(rdev->pdev, PCI_EXP_LNKCTL2, tmp16);
 
 	speed_cntl = RREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL);
 	speed_cntl |= LC_INITIATE_LINK_SPEED_CHANGE;
diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
index d84e81ff36ad..7d9be2f56ab1 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -449,10 +449,8 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 		return PTR_ERR(dpaux->regs);
 
 	dpaux->irq = platform_get_irq(pdev, 0);
-	if (dpaux->irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
-		return -ENXIO;
-	}
+	if (dpaux->irq < 0)
+		return dpaux->irq;
 
 	if (!pdev->dev.pm_domain) {
 		dpaux->rst = devm_reset_control_get(&pdev->dev, "dpaux");
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 4b1c223be993..6411ee12c7a3 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1540,7 +1540,6 @@ static void mt_post_parse(struct mt_device *td, struct mt_application *app)
 static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
-	char *name;
 	const char *suffix = NULL;
 	struct mt_report_data *rdata;
 	struct mt_application *mt_application = NULL;
@@ -1594,15 +1593,9 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		break;
 	}
 
-	if (suffix) {
-		name = devm_kzalloc(&hi->input->dev,
-				    strlen(hdev->name) + strlen(suffix) + 2,
-				    GFP_KERNEL);
-		if (name) {
-			sprintf(name, "%s %s", hdev->name, suffix);
-			hi->input->name = name;
-		}
-	}
+	if (suffix)
+		hi->input->name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
+						 "%s %s", hdev->name, suffix);
 
 	return 0;
 }
diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 45636d82ec30..0ee71ce94360 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -156,6 +156,7 @@ struct wacom_remote {
 		struct input_dev *input;
 		bool registered;
 		struct wacom_battery battery;
+		ktime_t active_time;
 	} remotes[WACOM_MAX_REMOTES];
 };
 
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index c50b26a9bc44..8255010b03d0 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2500,6 +2500,18 @@ static void wacom_wireless_work(struct work_struct *work)
 	return;
 }
 
+static void wacom_remote_destroy_battery(struct wacom *wacom, int index)
+{
+	struct wacom_remote *remote = wacom->remote;
+
+	if (remote->remotes[index].battery.battery) {
+		devres_release_group(&wacom->hdev->dev,
+				     &remote->remotes[index].battery.bat_desc);
+		remote->remotes[index].battery.battery = NULL;
+		remote->remotes[index].active_time = 0;
+	}
+}
+
 static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
 {
 	struct wacom_remote *remote = wacom->remote;
@@ -2514,9 +2526,7 @@ static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
 			remote->remotes[i].registered = false;
 			spin_unlock_irqrestore(&remote->remote_lock, flags);
 
-			if (remote->remotes[i].battery.battery)
-				devres_release_group(&wacom->hdev->dev,
-						     &remote->remotes[i].battery.bat_desc);
+			wacom_remote_destroy_battery(wacom, i);
 
 			if (remote->remotes[i].group.name)
 				devres_release_group(&wacom->hdev->dev,
@@ -2524,7 +2534,6 @@ static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
 
 			remote->remotes[i].serial = 0;
 			remote->remotes[i].group.name = NULL;
-			remote->remotes[i].battery.battery = NULL;
 			wacom->led.groups[i].select = WACOM_STATUS_UNKNOWN;
 		}
 	}
@@ -2609,6 +2618,9 @@ static int wacom_remote_attach_battery(struct wacom *wacom, int index)
 	if (remote->remotes[index].battery.battery)
 		return 0;
 
+	if (!remote->remotes[index].active_time)
+		return 0;
+
 	if (wacom->led.groups[index].select == WACOM_STATUS_UNKNOWN)
 		return 0;
 
@@ -2624,6 +2636,7 @@ static void wacom_remote_work(struct work_struct *work)
 {
 	struct wacom *wacom = container_of(work, struct wacom, remote_work);
 	struct wacom_remote *remote = wacom->remote;
+	ktime_t kt = ktime_get();
 	struct wacom_remote_data data;
 	unsigned long flags;
 	unsigned int count;
@@ -2650,6 +2663,10 @@ static void wacom_remote_work(struct work_struct *work)
 		serial = data.remote[i].serial;
 		if (data.remote[i].connected) {
 
+			if (kt - remote->remotes[i].active_time > WACOM_REMOTE_BATTERY_TIMEOUT
+			    && remote->remotes[i].active_time != 0)
+				wacom_remote_destroy_battery(wacom, i);
+
 			if (remote->remotes[i].serial == serial) {
 				wacom_remote_attach_battery(wacom, i);
 				continue;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 8f2de5cb2b6e..eb5f52e6f19d 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1077,6 +1077,7 @@ static int wacom_remote_irq(struct wacom_wac *wacom_wac, size_t len)
 	if (index < 0 || !remote->remotes[index].registered)
 		goto out;
 
+	remote->remotes[i].active_time = ktime_get();
 	input = remote->remotes[index].input;
 
 	input_report_key(input, BTN_0, (data[9] & 0x01));
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index fbdbb74f9f1f..8ff5e4de60f4 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -19,6 +19,7 @@
 #define WACOM_NAME_MAX		64
 #define WACOM_MAX_REMOTES	5
 #define WACOM_STATUS_UNKNOWN	255
+#define WACOM_REMOTE_BATTERY_TIMEOUT	21000000000ll
 
 /* packet length for individual models */
 #define WACOM_PKGLEN_BBFUN	 9
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 49d4b4f1a457..ad9bd2001fbd 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -323,7 +323,7 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
 	char buf[80];
 	int ret;
 
-	count = min_t(size_t, count, (sizeof(buf)-1));
+	count = min(count, sizeof(buf) - 1);
 	if (copy_from_user(buf, userbuf, count))
 		return -EFAULT;
 
diff --git a/drivers/infiniband/core/uverbs_std_types_counters.c b/drivers/infiniband/core/uverbs_std_types_counters.c
index a0ffdcf9a51c..bb3a03cdc974 100644
--- a/drivers/infiniband/core/uverbs_std_types_counters.c
+++ b/drivers/infiniband/core/uverbs_std_types_counters.c
@@ -103,6 +103,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_COUNTERS_READ)(
 		return ret;
 
 	uattr = uverbs_attr_get(attrs, UVERBS_ATTR_READ_COUNTERS_BUFF);
+	if (IS_ERR(uattr))
+		return PTR_ERR(uattr);
 	read_attr.ncounters = uattr->ptr_attr.len / sizeof(u64);
 	read_attr.counters_buff = uverbs_zalloc(
 		attrs, array_size(read_attr.ncounters, sizeof(u64)));
diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index de6fc8887c4a..60594dad5545 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2654,6 +2654,8 @@ static void isert_wait_conn(struct iscsi_conn *conn)
 	isert_put_unsol_pending_cmds(conn);
 	isert_wait4cmds(conn);
 	isert_wait4logout(isert_conn);
+
+	queue_work(isert_release_wq, &isert_conn->release_work);
 }
 
 static void isert_free_conn(struct iscsi_conn *conn)
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 0f8b1fb3d051..5ff06fbcfabf 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1785,6 +1785,9 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	int number = rdev->raid_disk;
 	struct raid1_info *p = conf->mirrors + number;
 
+	if (unlikely(number >= conf->raid_disks))
+		goto abort;
+
 	if (rdev != p->rdev)
 		p = conf->mirrors + conf->raid_disks + number;
 
diff --git a/drivers/media/dvb-frontends/ascot2e.c b/drivers/media/dvb-frontends/ascot2e.c
index 52ce0e6e2a15..7b0f6eeb383d 100644
--- a/drivers/media/dvb-frontends/ascot2e.c
+++ b/drivers/media/dvb-frontends/ascot2e.c
@@ -542,7 +542,7 @@ struct dvb_frontend *ascot2e_attach(struct dvb_frontend *fe,
 		priv->i2c_address, priv->i2c);
 	return fe;
 }
-EXPORT_SYMBOL(ascot2e_attach);
+EXPORT_SYMBOL_GPL(ascot2e_attach);
 
 MODULE_DESCRIPTION("Sony ASCOT2E terr/cab tuner driver");
 MODULE_AUTHOR("info@netup.ru");
diff --git a/drivers/media/dvb-frontends/atbm8830.c b/drivers/media/dvb-frontends/atbm8830.c
index cbcc65dc9d54..af5ada9f8f45 100644
--- a/drivers/media/dvb-frontends/atbm8830.c
+++ b/drivers/media/dvb-frontends/atbm8830.c
@@ -498,7 +498,7 @@ struct dvb_frontend *atbm8830_attach(const struct atbm8830_config *config,
 	return NULL;
 
 }
-EXPORT_SYMBOL(atbm8830_attach);
+EXPORT_SYMBOL_GPL(atbm8830_attach);
 
 MODULE_DESCRIPTION("AltoBeam ATBM8830/8831 GB20600 demodulator driver");
 MODULE_AUTHOR("David T. L. Wong <davidtlwong@gmail.com>");
diff --git a/drivers/media/dvb-frontends/au8522_dig.c b/drivers/media/dvb-frontends/au8522_dig.c
index 076f737aa8c0..ee9bacc48112 100644
--- a/drivers/media/dvb-frontends/au8522_dig.c
+++ b/drivers/media/dvb-frontends/au8522_dig.c
@@ -891,7 +891,7 @@ struct dvb_frontend *au8522_attach(const struct au8522_config *config,
 	au8522_release_state(state);
 	return NULL;
 }
-EXPORT_SYMBOL(au8522_attach);
+EXPORT_SYMBOL_GPL(au8522_attach);
 
 static const struct dvb_frontend_ops au8522_ops = {
 	.delsys = { SYS_ATSC, SYS_DVBC_ANNEX_B },
diff --git a/drivers/media/dvb-frontends/bcm3510.c b/drivers/media/dvb-frontends/bcm3510.c
index 6457b0912d14..bc4cc8c24e1a 100644
--- a/drivers/media/dvb-frontends/bcm3510.c
+++ b/drivers/media/dvb-frontends/bcm3510.c
@@ -835,7 +835,7 @@ struct dvb_frontend* bcm3510_attach(const struct bcm3510_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(bcm3510_attach);
+EXPORT_SYMBOL_GPL(bcm3510_attach);
 
 static const struct dvb_frontend_ops bcm3510_ops = {
 	.delsys = { SYS_ATSC, SYS_DVBC_ANNEX_B },
diff --git a/drivers/media/dvb-frontends/cx22700.c b/drivers/media/dvb-frontends/cx22700.c
index 961380162cdd..43968d02a664 100644
--- a/drivers/media/dvb-frontends/cx22700.c
+++ b/drivers/media/dvb-frontends/cx22700.c
@@ -444,4 +444,4 @@ MODULE_DESCRIPTION("Conexant CX22700 DVB-T Demodulator driver");
 MODULE_AUTHOR("Holger Waechtler");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(cx22700_attach);
+EXPORT_SYMBOL_GPL(cx22700_attach);
diff --git a/drivers/media/dvb-frontends/cx22702.c b/drivers/media/dvb-frontends/cx22702.c
index ab9b2924bcca..0954e646836c 100644
--- a/drivers/media/dvb-frontends/cx22702.c
+++ b/drivers/media/dvb-frontends/cx22702.c
@@ -616,7 +616,7 @@ struct dvb_frontend *cx22702_attach(const struct cx22702_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(cx22702_attach);
+EXPORT_SYMBOL_GPL(cx22702_attach);
 
 static const struct dvb_frontend_ops cx22702_ops = {
 	.delsys = { SYS_DVBT },
diff --git a/drivers/media/dvb-frontends/cx24110.c b/drivers/media/dvb-frontends/cx24110.c
index 9441bdc73097..ad3291d6aafb 100644
--- a/drivers/media/dvb-frontends/cx24110.c
+++ b/drivers/media/dvb-frontends/cx24110.c
@@ -666,4 +666,4 @@ MODULE_DESCRIPTION("Conexant CX24110 DVB-S Demodulator driver");
 MODULE_AUTHOR("Peter Hettkamp");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(cx24110_attach);
+EXPORT_SYMBOL_GPL(cx24110_attach);
diff --git a/drivers/media/dvb-frontends/cx24113.c b/drivers/media/dvb-frontends/cx24113.c
index 91a5033b6bd7..6e486a0d4d20 100644
--- a/drivers/media/dvb-frontends/cx24113.c
+++ b/drivers/media/dvb-frontends/cx24113.c
@@ -600,7 +600,7 @@ struct dvb_frontend *cx24113_attach(struct dvb_frontend *fe,
 
 	return NULL;
 }
-EXPORT_SYMBOL(cx24113_attach);
+EXPORT_SYMBOL_GPL(cx24113_attach);
 
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Activates frontend debugging (default:0)");
diff --git a/drivers/media/dvb-frontends/cx24116.c b/drivers/media/dvb-frontends/cx24116.c
index 220f26663647..cb82998619c8 100644
--- a/drivers/media/dvb-frontends/cx24116.c
+++ b/drivers/media/dvb-frontends/cx24116.c
@@ -1145,7 +1145,7 @@ struct dvb_frontend *cx24116_attach(const struct cx24116_config *config,
 	state->frontend.demodulator_priv = state;
 	return &state->frontend;
 }
-EXPORT_SYMBOL(cx24116_attach);
+EXPORT_SYMBOL_GPL(cx24116_attach);
 
 /*
  * Initialise or wake up device
diff --git a/drivers/media/dvb-frontends/cx24120.c b/drivers/media/dvb-frontends/cx24120.c
index dd3ec316e7c2..a6cf5a02ce5b 100644
--- a/drivers/media/dvb-frontends/cx24120.c
+++ b/drivers/media/dvb-frontends/cx24120.c
@@ -313,7 +313,7 @@ struct dvb_frontend *cx24120_attach(const struct cx24120_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(cx24120_attach);
+EXPORT_SYMBOL_GPL(cx24120_attach);
 
 static int cx24120_test_rom(struct cx24120_state *state)
 {
@@ -980,7 +980,9 @@ static void cx24120_set_clock_ratios(struct dvb_frontend *fe)
 	cmd.arg[8] = (clock_ratios_table[idx].rate >> 8) & 0xff;
 	cmd.arg[9] = (clock_ratios_table[idx].rate >> 0) & 0xff;
 
-	cx24120_message_send(state, &cmd);
+	ret = cx24120_message_send(state, &cmd);
+	if (ret != 0)
+		return;
 
 	/* Calculate ber window rates for stat work */
 	cx24120_calculate_ber_window(state, clock_ratios_table[idx].rate);
diff --git a/drivers/media/dvb-frontends/cx24123.c b/drivers/media/dvb-frontends/cx24123.c
index e49215020a93..faf1c7e5f2e8 100644
--- a/drivers/media/dvb-frontends/cx24123.c
+++ b/drivers/media/dvb-frontends/cx24123.c
@@ -1105,7 +1105,7 @@ struct dvb_frontend *cx24123_attach(const struct cx24123_config *config,
 
 	return NULL;
 }
-EXPORT_SYMBOL(cx24123_attach);
+EXPORT_SYMBOL_GPL(cx24123_attach);
 
 static const struct dvb_frontend_ops cx24123_ops = {
 	.delsys = { SYS_DVBS },
diff --git a/drivers/media/dvb-frontends/cxd2820r_core.c b/drivers/media/dvb-frontends/cxd2820r_core.c
index 3e0d8cbd76da..9b81f1651ad0 100644
--- a/drivers/media/dvb-frontends/cxd2820r_core.c
+++ b/drivers/media/dvb-frontends/cxd2820r_core.c
@@ -549,7 +549,7 @@ struct dvb_frontend *cxd2820r_attach(const struct cxd2820r_config *config,
 
 	return pdata.get_dvb_frontend(client);
 }
-EXPORT_SYMBOL(cxd2820r_attach);
+EXPORT_SYMBOL_GPL(cxd2820r_attach);
 
 static struct dvb_frontend *cxd2820r_get_dvb_frontend(struct i2c_client *client)
 {
diff --git a/drivers/media/dvb-frontends/cxd2841er.c b/drivers/media/dvb-frontends/cxd2841er.c
index c98093ed3dd7..f7cb00128810 100644
--- a/drivers/media/dvb-frontends/cxd2841er.c
+++ b/drivers/media/dvb-frontends/cxd2841er.c
@@ -3929,14 +3929,14 @@ struct dvb_frontend *cxd2841er_attach_s(struct cxd2841er_config *cfg,
 {
 	return cxd2841er_attach(cfg, i2c, SYS_DVBS);
 }
-EXPORT_SYMBOL(cxd2841er_attach_s);
+EXPORT_SYMBOL_GPL(cxd2841er_attach_s);
 
 struct dvb_frontend *cxd2841er_attach_t_c(struct cxd2841er_config *cfg,
 					struct i2c_adapter *i2c)
 {
 	return cxd2841er_attach(cfg, i2c, 0);
 }
-EXPORT_SYMBOL(cxd2841er_attach_t_c);
+EXPORT_SYMBOL_GPL(cxd2841er_attach_t_c);
 
 static const struct dvb_frontend_ops cxd2841er_dvbs_s2_ops = {
 	.delsys = { SYS_DVBS, SYS_DVBS2 },
diff --git a/drivers/media/dvb-frontends/cxd2880/cxd2880_top.c b/drivers/media/dvb-frontends/cxd2880/cxd2880_top.c
index f87e27481ea7..ea1bc9a35618 100644
--- a/drivers/media/dvb-frontends/cxd2880/cxd2880_top.c
+++ b/drivers/media/dvb-frontends/cxd2880/cxd2880_top.c
@@ -1950,7 +1950,7 @@ struct dvb_frontend *cxd2880_attach(struct dvb_frontend *fe,
 
 	return fe;
 }
-EXPORT_SYMBOL(cxd2880_attach);
+EXPORT_SYMBOL_GPL(cxd2880_attach);
 
 MODULE_DESCRIPTION("Sony CXD2880 DVB-T2/T tuner + demod driver");
 MODULE_AUTHOR("Sony Semiconductor Solutions Corporation");
diff --git a/drivers/media/dvb-frontends/dib0070.c b/drivers/media/dvb-frontends/dib0070.c
index 37ebd5af8fd4..81e041ff3dd5 100644
--- a/drivers/media/dvb-frontends/dib0070.c
+++ b/drivers/media/dvb-frontends/dib0070.c
@@ -767,7 +767,7 @@ struct dvb_frontend *dib0070_attach(struct dvb_frontend *fe, struct i2c_adapter
 	fe->tuner_priv = NULL;
 	return NULL;
 }
-EXPORT_SYMBOL(dib0070_attach);
+EXPORT_SYMBOL_GPL(dib0070_attach);
 
 MODULE_AUTHOR("Patrick Boettcher <patrick.boettcher@posteo.de>");
 MODULE_DESCRIPTION("Driver for the DiBcom 0070 base-band RF Tuner");
diff --git a/drivers/media/dvb-frontends/dib0090.c b/drivers/media/dvb-frontends/dib0090.c
index 44a074261e69..c1942d24e090 100644
--- a/drivers/media/dvb-frontends/dib0090.c
+++ b/drivers/media/dvb-frontends/dib0090.c
@@ -2643,7 +2643,7 @@ struct dvb_frontend *dib0090_register(struct dvb_frontend *fe, struct i2c_adapte
 	return NULL;
 }
 
-EXPORT_SYMBOL(dib0090_register);
+EXPORT_SYMBOL_GPL(dib0090_register);
 
 struct dvb_frontend *dib0090_fw_register(struct dvb_frontend *fe, struct i2c_adapter *i2c, const struct dib0090_config *config)
 {
@@ -2669,7 +2669,7 @@ struct dvb_frontend *dib0090_fw_register(struct dvb_frontend *fe, struct i2c_ada
 	fe->tuner_priv = NULL;
 	return NULL;
 }
-EXPORT_SYMBOL(dib0090_fw_register);
+EXPORT_SYMBOL_GPL(dib0090_fw_register);
 
 MODULE_AUTHOR("Patrick Boettcher <patrick.boettcher@posteo.de>");
 MODULE_AUTHOR("Olivier Grenie <olivier.grenie@parrot.com>");
diff --git a/drivers/media/dvb-frontends/dib3000mb.c b/drivers/media/dvb-frontends/dib3000mb.c
index bbbd53280477..8df51730d870 100644
--- a/drivers/media/dvb-frontends/dib3000mb.c
+++ b/drivers/media/dvb-frontends/dib3000mb.c
@@ -819,4 +819,4 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(dib3000mb_attach);
+EXPORT_SYMBOL_GPL(dib3000mb_attach);
diff --git a/drivers/media/dvb-frontends/dib3000mc.c b/drivers/media/dvb-frontends/dib3000mc.c
index c9e1db251723..040602e8ad74 100644
--- a/drivers/media/dvb-frontends/dib3000mc.c
+++ b/drivers/media/dvb-frontends/dib3000mc.c
@@ -938,7 +938,7 @@ struct dvb_frontend * dib3000mc_attach(struct i2c_adapter *i2c_adap, u8 i2c_addr
 	kfree(st);
 	return NULL;
 }
-EXPORT_SYMBOL(dib3000mc_attach);
+EXPORT_SYMBOL_GPL(dib3000mc_attach);
 
 static const struct dvb_frontend_ops dib3000mc_ops = {
 	.delsys = { SYS_DVBT },
diff --git a/drivers/media/dvb-frontends/dib7000m.c b/drivers/media/dvb-frontends/dib7000m.c
index b79358d09de6..9684559fc670 100644
--- a/drivers/media/dvb-frontends/dib7000m.c
+++ b/drivers/media/dvb-frontends/dib7000m.c
@@ -1437,7 +1437,7 @@ struct dvb_frontend * dib7000m_attach(struct i2c_adapter *i2c_adap, u8 i2c_addr,
 	kfree(st);
 	return NULL;
 }
-EXPORT_SYMBOL(dib7000m_attach);
+EXPORT_SYMBOL_GPL(dib7000m_attach);
 
 static const struct dvb_frontend_ops dib7000m_ops = {
 	.delsys = { SYS_DVBT },
diff --git a/drivers/media/dvb-frontends/dib7000p.c b/drivers/media/dvb-frontends/dib7000p.c
index 58387860b62d..6399cbc968c4 100644
--- a/drivers/media/dvb-frontends/dib7000p.c
+++ b/drivers/media/dvb-frontends/dib7000p.c
@@ -500,7 +500,7 @@ static int dib7000p_update_pll(struct dvb_frontend *fe, struct dibx000_bandwidth
 	prediv = reg_1856 & 0x3f;
 	loopdiv = (reg_1856 >> 6) & 0x3f;
 
-	if ((bw != NULL) && (bw->pll_prediv != prediv || bw->pll_ratio != loopdiv)) {
+	if (loopdiv && bw && (bw->pll_prediv != prediv || bw->pll_ratio != loopdiv)) {
 		dprintk("Updating pll (prediv: old =  %d new = %d ; loopdiv : old = %d new = %d)\n", prediv, bw->pll_prediv, loopdiv, bw->pll_ratio);
 		reg_1856 &= 0xf000;
 		reg_1857 = dib7000p_read_word(state, 1857);
@@ -2818,7 +2818,7 @@ void *dib7000p_attach(struct dib7000p_ops *ops)
 
 	return ops;
 }
-EXPORT_SYMBOL(dib7000p_attach);
+EXPORT_SYMBOL_GPL(dib7000p_attach);
 
 static const struct dvb_frontend_ops dib7000p_ops = {
 	.delsys = { SYS_DVBT },
diff --git a/drivers/media/dvb-frontends/dib8000.c b/drivers/media/dvb-frontends/dib8000.c
index 4b9e4afa4c61..ca3c219df3c5 100644
--- a/drivers/media/dvb-frontends/dib8000.c
+++ b/drivers/media/dvb-frontends/dib8000.c
@@ -4530,7 +4530,7 @@ void *dib8000_attach(struct dib8000_ops *ops)
 
 	return ops;
 }
-EXPORT_SYMBOL(dib8000_attach);
+EXPORT_SYMBOL_GPL(dib8000_attach);
 
 MODULE_AUTHOR("Olivier Grenie <Olivier.Grenie@parrot.com, Patrick Boettcher <patrick.boettcher@posteo.de>");
 MODULE_DESCRIPTION("Driver for the DiBcom 8000 ISDB-T demodulator");
diff --git a/drivers/media/dvb-frontends/dib9000.c b/drivers/media/dvb-frontends/dib9000.c
index 0183fb1346ef..ebe693bf9256 100644
--- a/drivers/media/dvb-frontends/dib9000.c
+++ b/drivers/media/dvb-frontends/dib9000.c
@@ -2547,7 +2547,7 @@ struct dvb_frontend *dib9000_attach(struct i2c_adapter *i2c_adap, u8 i2c_addr, c
 	kfree(st);
 	return NULL;
 }
-EXPORT_SYMBOL(dib9000_attach);
+EXPORT_SYMBOL_GPL(dib9000_attach);
 
 static const struct dvb_frontend_ops dib9000_ops = {
 	.delsys = { SYS_DVBT },
diff --git a/drivers/media/dvb-frontends/drx39xyj/drxj.c b/drivers/media/dvb-frontends/drx39xyj/drxj.c
index 9628d4067fe1..9670bc98b45a 100644
--- a/drivers/media/dvb-frontends/drx39xyj/drxj.c
+++ b/drivers/media/dvb-frontends/drx39xyj/drxj.c
@@ -12367,7 +12367,7 @@ struct dvb_frontend *drx39xxj_attach(struct i2c_adapter *i2c)
 
 	return NULL;
 }
-EXPORT_SYMBOL(drx39xxj_attach);
+EXPORT_SYMBOL_GPL(drx39xxj_attach);
 
 static const struct dvb_frontend_ops drx39xxj_ops = {
 	.delsys = { SYS_ATSC, SYS_DVBC_ANNEX_B },
diff --git a/drivers/media/dvb-frontends/drxd_hard.c b/drivers/media/dvb-frontends/drxd_hard.c
index 684d428efb0d..f9038c495ece 100644
--- a/drivers/media/dvb-frontends/drxd_hard.c
+++ b/drivers/media/dvb-frontends/drxd_hard.c
@@ -2972,7 +2972,7 @@ struct dvb_frontend *drxd_attach(const struct drxd_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(drxd_attach);
+EXPORT_SYMBOL_GPL(drxd_attach);
 
 MODULE_DESCRIPTION("DRXD driver");
 MODULE_AUTHOR("Micronas");
diff --git a/drivers/media/dvb-frontends/drxk_hard.c b/drivers/media/dvb-frontends/drxk_hard.c
index 100a3a0b2db3..ad18c8ba1da0 100644
--- a/drivers/media/dvb-frontends/drxk_hard.c
+++ b/drivers/media/dvb-frontends/drxk_hard.c
@@ -6867,7 +6867,7 @@ struct dvb_frontend *drxk_attach(const struct drxk_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(drxk_attach);
+EXPORT_SYMBOL_GPL(drxk_attach);
 
 MODULE_DESCRIPTION("DRX-K driver");
 MODULE_AUTHOR("Ralph Metzler");
diff --git a/drivers/media/dvb-frontends/ds3000.c b/drivers/media/dvb-frontends/ds3000.c
index 46a55146cb07..adc00f291921 100644
--- a/drivers/media/dvb-frontends/ds3000.c
+++ b/drivers/media/dvb-frontends/ds3000.c
@@ -871,7 +871,7 @@ struct dvb_frontend *ds3000_attach(const struct ds3000_config *config,
 	ds3000_set_voltage(&state->frontend, SEC_VOLTAGE_OFF);
 	return &state->frontend;
 }
-EXPORT_SYMBOL(ds3000_attach);
+EXPORT_SYMBOL_GPL(ds3000_attach);
 
 static int ds3000_set_carrier_offset(struct dvb_frontend *fe,
 					s32 carrier_offset_khz)
diff --git a/drivers/media/dvb-frontends/dvb-pll.c b/drivers/media/dvb-frontends/dvb-pll.c
index ee830c76e4b3..bd7576e63388 100644
--- a/drivers/media/dvb-frontends/dvb-pll.c
+++ b/drivers/media/dvb-frontends/dvb-pll.c
@@ -875,7 +875,7 @@ struct dvb_frontend *dvb_pll_attach(struct dvb_frontend *fe, int pll_addr,
 
 	return NULL;
 }
-EXPORT_SYMBOL(dvb_pll_attach);
+EXPORT_SYMBOL_GPL(dvb_pll_attach);
 
 
 static int
diff --git a/drivers/media/dvb-frontends/ec100.c b/drivers/media/dvb-frontends/ec100.c
index c2575fdcc811..121699e41475 100644
--- a/drivers/media/dvb-frontends/ec100.c
+++ b/drivers/media/dvb-frontends/ec100.c
@@ -309,7 +309,7 @@ struct dvb_frontend *ec100_attach(const struct ec100_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(ec100_attach);
+EXPORT_SYMBOL_GPL(ec100_attach);
 
 static const struct dvb_frontend_ops ec100_ops = {
 	.delsys = { SYS_DVBT },
diff --git a/drivers/media/dvb-frontends/helene.c b/drivers/media/dvb-frontends/helene.c
index d7790cb98a0c..2945124cb7ae 100644
--- a/drivers/media/dvb-frontends/helene.c
+++ b/drivers/media/dvb-frontends/helene.c
@@ -1034,7 +1034,7 @@ struct dvb_frontend *helene_attach_s(struct dvb_frontend *fe,
 			priv->i2c_address, priv->i2c);
 	return fe;
 }
-EXPORT_SYMBOL(helene_attach_s);
+EXPORT_SYMBOL_GPL(helene_attach_s);
 
 struct dvb_frontend *helene_attach(struct dvb_frontend *fe,
 		const struct helene_config *config,
@@ -1070,7 +1070,7 @@ struct dvb_frontend *helene_attach(struct dvb_frontend *fe,
 			priv->i2c_address, priv->i2c);
 	return fe;
 }
-EXPORT_SYMBOL(helene_attach);
+EXPORT_SYMBOL_GPL(helene_attach);
 
 static int helene_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
diff --git a/drivers/media/dvb-frontends/horus3a.c b/drivers/media/dvb-frontends/horus3a.c
index 02bc08081971..b748b351e161 100644
--- a/drivers/media/dvb-frontends/horus3a.c
+++ b/drivers/media/dvb-frontends/horus3a.c
@@ -404,7 +404,7 @@ struct dvb_frontend *horus3a_attach(struct dvb_frontend *fe,
 		priv->i2c_address, priv->i2c);
 	return fe;
 }
-EXPORT_SYMBOL(horus3a_attach);
+EXPORT_SYMBOL_GPL(horus3a_attach);
 
 MODULE_DESCRIPTION("Sony HORUS3A satellite tuner driver");
 MODULE_AUTHOR("Sergey Kozlov <serjk@netup.ru>");
diff --git a/drivers/media/dvb-frontends/isl6405.c b/drivers/media/dvb-frontends/isl6405.c
index 3bc78f8ffc00..9ca4a354a392 100644
--- a/drivers/media/dvb-frontends/isl6405.c
+++ b/drivers/media/dvb-frontends/isl6405.c
@@ -155,7 +155,7 @@ struct dvb_frontend *isl6405_attach(struct dvb_frontend *fe, struct i2c_adapter
 
 	return fe;
 }
-EXPORT_SYMBOL(isl6405_attach);
+EXPORT_SYMBOL_GPL(isl6405_attach);
 
 MODULE_DESCRIPTION("Driver for lnb supply and control ic isl6405");
 MODULE_AUTHOR("Hartmut Hackmann & Oliver Endriss");
diff --git a/drivers/media/dvb-frontends/isl6421.c b/drivers/media/dvb-frontends/isl6421.c
index ae8ec59b665c..a3515dbf1017 100644
--- a/drivers/media/dvb-frontends/isl6421.c
+++ b/drivers/media/dvb-frontends/isl6421.c
@@ -227,7 +227,7 @@ struct dvb_frontend *isl6421_attach(struct dvb_frontend *fe, struct i2c_adapter
 
 	return fe;
 }
-EXPORT_SYMBOL(isl6421_attach);
+EXPORT_SYMBOL_GPL(isl6421_attach);
 
 MODULE_DESCRIPTION("Driver for lnb supply and control ic isl6421");
 MODULE_AUTHOR("Andrew de Quincey & Oliver Endriss");
diff --git a/drivers/media/dvb-frontends/isl6423.c b/drivers/media/dvb-frontends/isl6423.c
index 3dd2465d17cf..ea029df731cc 100644
--- a/drivers/media/dvb-frontends/isl6423.c
+++ b/drivers/media/dvb-frontends/isl6423.c
@@ -301,7 +301,7 @@ struct dvb_frontend *isl6423_attach(struct dvb_frontend *fe,
 	fe->sec_priv = NULL;
 	return NULL;
 }
-EXPORT_SYMBOL(isl6423_attach);
+EXPORT_SYMBOL_GPL(isl6423_attach);
 
 MODULE_DESCRIPTION("ISL6423 SEC");
 MODULE_AUTHOR("Manu Abraham");
diff --git a/drivers/media/dvb-frontends/itd1000.c b/drivers/media/dvb-frontends/itd1000.c
index c3a6e81ae87f..9d87ef92f60a 100644
--- a/drivers/media/dvb-frontends/itd1000.c
+++ b/drivers/media/dvb-frontends/itd1000.c
@@ -399,7 +399,7 @@ struct dvb_frontend *itd1000_attach(struct dvb_frontend *fe, struct i2c_adapter
 
 	return fe;
 }
-EXPORT_SYMBOL(itd1000_attach);
+EXPORT_SYMBOL_GPL(itd1000_attach);
 
 MODULE_AUTHOR("Patrick Boettcher <pb@linuxtv.org>");
 MODULE_DESCRIPTION("Integrant ITD1000 driver");
diff --git a/drivers/media/dvb-frontends/ix2505v.c b/drivers/media/dvb-frontends/ix2505v.c
index a30707b61b1f..577491354c5f 100644
--- a/drivers/media/dvb-frontends/ix2505v.c
+++ b/drivers/media/dvb-frontends/ix2505v.c
@@ -311,7 +311,7 @@ struct dvb_frontend *ix2505v_attach(struct dvb_frontend *fe,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(ix2505v_attach);
+EXPORT_SYMBOL_GPL(ix2505v_attach);
 
 module_param_named(debug, ix2505v_debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
diff --git a/drivers/media/dvb-frontends/l64781.c b/drivers/media/dvb-frontends/l64781.c
index 9afb5bf6424b..6a19d4d0d4ad 100644
--- a/drivers/media/dvb-frontends/l64781.c
+++ b/drivers/media/dvb-frontends/l64781.c
@@ -605,4 +605,4 @@ MODULE_DESCRIPTION("LSI L64781 DVB-T Demodulator driver");
 MODULE_AUTHOR("Holger Waechtler, Marko Kohtala");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(l64781_attach);
+EXPORT_SYMBOL_GPL(l64781_attach);
diff --git a/drivers/media/dvb-frontends/lg2160.c b/drivers/media/dvb-frontends/lg2160.c
index 408151e33fa7..96b271a8247d 100644
--- a/drivers/media/dvb-frontends/lg2160.c
+++ b/drivers/media/dvb-frontends/lg2160.c
@@ -1436,7 +1436,7 @@ struct dvb_frontend *lg2160_attach(const struct lg2160_config *config,
 
 	return &state->frontend;
 }
-EXPORT_SYMBOL(lg2160_attach);
+EXPORT_SYMBOL_GPL(lg2160_attach);
 
 MODULE_DESCRIPTION("LG Electronics LG216x ATSC/MH Demodulator Driver");
 MODULE_AUTHOR("Michael Krufky <mkrufky@linuxtv.org>");
diff --git a/drivers/media/dvb-frontends/lgdt3305.c b/drivers/media/dvb-frontends/lgdt3305.c
index 857e9b4d69b4..7592e9e75bfb 100644
--- a/drivers/media/dvb-frontends/lgdt3305.c
+++ b/drivers/media/dvb-frontends/lgdt3305.c
@@ -1158,7 +1158,7 @@ struct dvb_frontend *lgdt3305_attach(const struct lgdt3305_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(lgdt3305_attach);
+EXPORT_SYMBOL_GPL(lgdt3305_attach);
 
 static const struct dvb_frontend_ops lgdt3304_ops = {
 	.delsys = { SYS_ATSC, SYS_DVBC_ANNEX_B },
diff --git a/drivers/media/dvb-frontends/lgdt3306a.c b/drivers/media/dvb-frontends/lgdt3306a.c
index 0e1f5daaf20c..567bf0dc9206 100644
--- a/drivers/media/dvb-frontends/lgdt3306a.c
+++ b/drivers/media/dvb-frontends/lgdt3306a.c
@@ -1887,7 +1887,7 @@ struct dvb_frontend *lgdt3306a_attach(const struct lgdt3306a_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(lgdt3306a_attach);
+EXPORT_SYMBOL_GPL(lgdt3306a_attach);
 
 #ifdef DBG_DUMP
 
diff --git a/drivers/media/dvb-frontends/lgdt330x.c b/drivers/media/dvb-frontends/lgdt330x.c
index 9ee1c1360ab8..b9ae8c838501 100644
--- a/drivers/media/dvb-frontends/lgdt330x.c
+++ b/drivers/media/dvb-frontends/lgdt330x.c
@@ -938,7 +938,7 @@ struct dvb_frontend *lgdt330x_attach(const struct lgdt330x_config *_config,
 
 	return lgdt330x_get_dvb_frontend(client);
 }
-EXPORT_SYMBOL(lgdt330x_attach);
+EXPORT_SYMBOL_GPL(lgdt330x_attach);
 
 static const struct dvb_frontend_ops lgdt3302_ops = {
 	.delsys = { SYS_ATSC, SYS_DVBC_ANNEX_B },
diff --git a/drivers/media/dvb-frontends/lgs8gxx.c b/drivers/media/dvb-frontends/lgs8gxx.c
index a6bcf1571d10..f9c1493e80e8 100644
--- a/drivers/media/dvb-frontends/lgs8gxx.c
+++ b/drivers/media/dvb-frontends/lgs8gxx.c
@@ -1053,7 +1053,7 @@ struct dvb_frontend *lgs8gxx_attach(const struct lgs8gxx_config *config,
 	return NULL;
 
 }
-EXPORT_SYMBOL(lgs8gxx_attach);
+EXPORT_SYMBOL_GPL(lgs8gxx_attach);
 
 MODULE_DESCRIPTION("Legend Silicon LGS8913/LGS8GXX DMB-TH demodulator driver");
 MODULE_AUTHOR("David T. L. Wong <davidtlwong@gmail.com>");
diff --git a/drivers/media/dvb-frontends/lnbh25.c b/drivers/media/dvb-frontends/lnbh25.c
index 0b388502c298..bf1c961a64d0 100644
--- a/drivers/media/dvb-frontends/lnbh25.c
+++ b/drivers/media/dvb-frontends/lnbh25.c
@@ -182,7 +182,7 @@ struct dvb_frontend *lnbh25_attach(struct dvb_frontend *fe,
 		__func__, priv->i2c_address);
 	return fe;
 }
-EXPORT_SYMBOL(lnbh25_attach);
+EXPORT_SYMBOL_GPL(lnbh25_attach);
 
 MODULE_DESCRIPTION("ST LNBH25 driver");
 MODULE_AUTHOR("info@netup.ru");
diff --git a/drivers/media/dvb-frontends/lnbp21.c b/drivers/media/dvb-frontends/lnbp21.c
index d9966a338a72..84067d27a871 100644
--- a/drivers/media/dvb-frontends/lnbp21.c
+++ b/drivers/media/dvb-frontends/lnbp21.c
@@ -169,7 +169,7 @@ struct dvb_frontend *lnbh24_attach(struct dvb_frontend *fe,
 	return lnbx2x_attach(fe, i2c, override_set, override_clear,
 							i2c_addr, LNBH24_TTX);
 }
-EXPORT_SYMBOL(lnbh24_attach);
+EXPORT_SYMBOL_GPL(lnbh24_attach);
 
 struct dvb_frontend *lnbp21_attach(struct dvb_frontend *fe,
 				struct i2c_adapter *i2c, u8 override_set,
@@ -178,7 +178,7 @@ struct dvb_frontend *lnbp21_attach(struct dvb_frontend *fe,
 	return lnbx2x_attach(fe, i2c, override_set, override_clear,
 							0x08, LNBP21_ISEL);
 }
-EXPORT_SYMBOL(lnbp21_attach);
+EXPORT_SYMBOL_GPL(lnbp21_attach);
 
 MODULE_DESCRIPTION("Driver for lnb supply and control ic lnbp21, lnbh24");
 MODULE_AUTHOR("Oliver Endriss, Igor M. Liplianin");
diff --git a/drivers/media/dvb-frontends/lnbp22.c b/drivers/media/dvb-frontends/lnbp22.c
index a62e82bf46f5..a4257e07eb7b 100644
--- a/drivers/media/dvb-frontends/lnbp22.c
+++ b/drivers/media/dvb-frontends/lnbp22.c
@@ -139,7 +139,7 @@ struct dvb_frontend *lnbp22_attach(struct dvb_frontend *fe,
 
 	return fe;
 }
-EXPORT_SYMBOL(lnbp22_attach);
+EXPORT_SYMBOL_GPL(lnbp22_attach);
 
 MODULE_DESCRIPTION("Driver for lnb supply and control ic lnbp22");
 MODULE_AUTHOR("Dominik Kuhlen");
diff --git a/drivers/media/dvb-frontends/m88ds3103.c b/drivers/media/dvb-frontends/m88ds3103.c
index c25c92797408..ed4076f1c6e0 100644
--- a/drivers/media/dvb-frontends/m88ds3103.c
+++ b/drivers/media/dvb-frontends/m88ds3103.c
@@ -1293,7 +1293,7 @@ struct dvb_frontend *m88ds3103_attach(const struct m88ds3103_config *cfg,
 	*tuner_i2c_adapter = pdata.get_i2c_adapter(client);
 	return pdata.get_dvb_frontend(client);
 }
-EXPORT_SYMBOL(m88ds3103_attach);
+EXPORT_SYMBOL_GPL(m88ds3103_attach);
 
 static const struct dvb_frontend_ops m88ds3103_ops = {
 	.delsys = {SYS_DVBS, SYS_DVBS2},
diff --git a/drivers/media/dvb-frontends/m88rs2000.c b/drivers/media/dvb-frontends/m88rs2000.c
index d5bc85501f9e..6338b64e6adb 100644
--- a/drivers/media/dvb-frontends/m88rs2000.c
+++ b/drivers/media/dvb-frontends/m88rs2000.c
@@ -819,7 +819,7 @@ struct dvb_frontend *m88rs2000_attach(const struct m88rs2000_config *config,
 
 	return NULL;
 }
-EXPORT_SYMBOL(m88rs2000_attach);
+EXPORT_SYMBOL_GPL(m88rs2000_attach);
 
 MODULE_DESCRIPTION("M88RS2000 DVB-S Demodulator driver");
 MODULE_AUTHOR("Malcolm Priestley tvboxspy@gmail.com");
diff --git a/drivers/media/dvb-frontends/mb86a16.c b/drivers/media/dvb-frontends/mb86a16.c
index da505a5d035f..ece2c1215576 100644
--- a/drivers/media/dvb-frontends/mb86a16.c
+++ b/drivers/media/dvb-frontends/mb86a16.c
@@ -1863,6 +1863,6 @@ struct dvb_frontend *mb86a16_attach(const struct mb86a16_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(mb86a16_attach);
+EXPORT_SYMBOL_GPL(mb86a16_attach);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Manu Abraham");
diff --git a/drivers/media/dvb-frontends/mb86a20s.c b/drivers/media/dvb-frontends/mb86a20s.c
index 66fc77db0e75..84f7e9d04398 100644
--- a/drivers/media/dvb-frontends/mb86a20s.c
+++ b/drivers/media/dvb-frontends/mb86a20s.c
@@ -2097,7 +2097,7 @@ struct dvb_frontend *mb86a20s_attach(const struct mb86a20s_config *config,
 	dev_info(&i2c->dev, "Detected a Fujitsu mb86a20s frontend\n");
 	return &state->frontend;
 }
-EXPORT_SYMBOL(mb86a20s_attach);
+EXPORT_SYMBOL_GPL(mb86a20s_attach);
 
 static const struct dvb_frontend_ops mb86a20s_ops = {
 	.delsys = { SYS_ISDBT },
diff --git a/drivers/media/dvb-frontends/mt312.c b/drivers/media/dvb-frontends/mt312.c
index aad07adda37d..208f5d0c083a 100644
--- a/drivers/media/dvb-frontends/mt312.c
+++ b/drivers/media/dvb-frontends/mt312.c
@@ -840,7 +840,7 @@ struct dvb_frontend *mt312_attach(const struct mt312_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(mt312_attach);
+EXPORT_SYMBOL_GPL(mt312_attach);
 
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
diff --git a/drivers/media/dvb-frontends/mt352.c b/drivers/media/dvb-frontends/mt352.c
index da3e466d50e2..2d3c6a5ef493 100644
--- a/drivers/media/dvb-frontends/mt352.c
+++ b/drivers/media/dvb-frontends/mt352.c
@@ -603,4 +603,4 @@ MODULE_DESCRIPTION("Zarlink MT352 DVB-T Demodulator driver");
 MODULE_AUTHOR("Holger Waechtler, Daniel Mack, Antonio Mancuso");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(mt352_attach);
+EXPORT_SYMBOL_GPL(mt352_attach);
diff --git a/drivers/media/dvb-frontends/nxt200x.c b/drivers/media/dvb-frontends/nxt200x.c
index 0961e686ff68..01d517922e7b 100644
--- a/drivers/media/dvb-frontends/nxt200x.c
+++ b/drivers/media/dvb-frontends/nxt200x.c
@@ -1242,5 +1242,5 @@ MODULE_DESCRIPTION("NXT200X (ATSC 8VSB & ITU-T J.83 AnnexB 64/256 QAM) Demodulat
 MODULE_AUTHOR("Kirk Lapray, Michael Krufky, Jean-Francois Thibert, and Taylor Jacob");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(nxt200x_attach);
+EXPORT_SYMBOL_GPL(nxt200x_attach);
 
diff --git a/drivers/media/dvb-frontends/nxt6000.c b/drivers/media/dvb-frontends/nxt6000.c
index 72e447e8ba64..4fc817f64be4 100644
--- a/drivers/media/dvb-frontends/nxt6000.c
+++ b/drivers/media/dvb-frontends/nxt6000.c
@@ -633,4 +633,4 @@ MODULE_DESCRIPTION("NxtWave NXT6000 DVB-T demodulator driver");
 MODULE_AUTHOR("Florian Schirmer");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(nxt6000_attach);
+EXPORT_SYMBOL_GPL(nxt6000_attach);
diff --git a/drivers/media/dvb-frontends/or51132.c b/drivers/media/dvb-frontends/or51132.c
index fc35f37eb3c0..fee54db95532 100644
--- a/drivers/media/dvb-frontends/or51132.c
+++ b/drivers/media/dvb-frontends/or51132.c
@@ -616,4 +616,4 @@ MODULE_AUTHOR("Kirk Lapray");
 MODULE_AUTHOR("Trent Piepho");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(or51132_attach);
+EXPORT_SYMBOL_GPL(or51132_attach);
diff --git a/drivers/media/dvb-frontends/or51211.c b/drivers/media/dvb-frontends/or51211.c
index a39bbd8ff1f0..fbf2ccf60de6 100644
--- a/drivers/media/dvb-frontends/or51211.c
+++ b/drivers/media/dvb-frontends/or51211.c
@@ -561,5 +561,5 @@ MODULE_DESCRIPTION("Oren OR51211 VSB [pcHDTV HD-2000] Demodulator Driver");
 MODULE_AUTHOR("Kirk Lapray");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(or51211_attach);
+EXPORT_SYMBOL_GPL(or51211_attach);
 
diff --git a/drivers/media/dvb-frontends/s5h1409.c b/drivers/media/dvb-frontends/s5h1409.c
index ceeb0c3551ce..47e388faac4a 100644
--- a/drivers/media/dvb-frontends/s5h1409.c
+++ b/drivers/media/dvb-frontends/s5h1409.c
@@ -993,7 +993,7 @@ struct dvb_frontend *s5h1409_attach(const struct s5h1409_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(s5h1409_attach);
+EXPORT_SYMBOL_GPL(s5h1409_attach);
 
 static const struct dvb_frontend_ops s5h1409_ops = {
 	.delsys = { SYS_ATSC, SYS_DVBC_ANNEX_B },
diff --git a/drivers/media/dvb-frontends/s5h1411.c b/drivers/media/dvb-frontends/s5h1411.c
index 98aeed1d2284..d900874044b2 100644
--- a/drivers/media/dvb-frontends/s5h1411.c
+++ b/drivers/media/dvb-frontends/s5h1411.c
@@ -912,7 +912,7 @@ struct dvb_frontend *s5h1411_attach(const struct s5h1411_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(s5h1411_attach);
+EXPORT_SYMBOL_GPL(s5h1411_attach);
 
 static const struct dvb_frontend_ops s5h1411_ops = {
 	.delsys = { SYS_ATSC, SYS_DVBC_ANNEX_B },
diff --git a/drivers/media/dvb-frontends/s5h1420.c b/drivers/media/dvb-frontends/s5h1420.c
index a65cdf8e8cd9..085f08427a6d 100644
--- a/drivers/media/dvb-frontends/s5h1420.c
+++ b/drivers/media/dvb-frontends/s5h1420.c
@@ -928,7 +928,7 @@ struct dvb_frontend *s5h1420_attach(const struct s5h1420_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(s5h1420_attach);
+EXPORT_SYMBOL_GPL(s5h1420_attach);
 
 static const struct dvb_frontend_ops s5h1420_ops = {
 	.delsys = { SYS_DVBS },
diff --git a/drivers/media/dvb-frontends/s5h1432.c b/drivers/media/dvb-frontends/s5h1432.c
index 4dc3febc0e12..f4d6304ed2ce 100644
--- a/drivers/media/dvb-frontends/s5h1432.c
+++ b/drivers/media/dvb-frontends/s5h1432.c
@@ -364,7 +364,7 @@ struct dvb_frontend *s5h1432_attach(const struct s5h1432_config *config,
 
 	return &state->frontend;
 }
-EXPORT_SYMBOL(s5h1432_attach);
+EXPORT_SYMBOL_GPL(s5h1432_attach);
 
 static const struct dvb_frontend_ops s5h1432_ops = {
 	.delsys = { SYS_DVBT },
diff --git a/drivers/media/dvb-frontends/s921.c b/drivers/media/dvb-frontends/s921.c
index 79276871112a..4a492445efd7 100644
--- a/drivers/media/dvb-frontends/s921.c
+++ b/drivers/media/dvb-frontends/s921.c
@@ -503,7 +503,7 @@ struct dvb_frontend *s921_attach(const struct s921_config *config,
 
 	return &state->frontend;
 }
-EXPORT_SYMBOL(s921_attach);
+EXPORT_SYMBOL_GPL(s921_attach);
 
 static const struct dvb_frontend_ops s921_ops = {
 	.delsys = { SYS_ISDBT },
diff --git a/drivers/media/dvb-frontends/si21xx.c b/drivers/media/dvb-frontends/si21xx.c
index 8546a236d452..fe0b94d3c8b1 100644
--- a/drivers/media/dvb-frontends/si21xx.c
+++ b/drivers/media/dvb-frontends/si21xx.c
@@ -943,7 +943,7 @@ struct dvb_frontend *si21xx_attach(const struct si21xx_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(si21xx_attach);
+EXPORT_SYMBOL_GPL(si21xx_attach);
 
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
diff --git a/drivers/media/dvb-frontends/sp887x.c b/drivers/media/dvb-frontends/sp887x.c
index c02f50995df4..070c74b67ec6 100644
--- a/drivers/media/dvb-frontends/sp887x.c
+++ b/drivers/media/dvb-frontends/sp887x.c
@@ -625,4 +625,4 @@ MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
 MODULE_DESCRIPTION("Spase sp887x DVB-T demodulator driver");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(sp887x_attach);
+EXPORT_SYMBOL_GPL(sp887x_attach);
diff --git a/drivers/media/dvb-frontends/stb0899_drv.c b/drivers/media/dvb-frontends/stb0899_drv.c
index 874e9c9125d6..6dbc9d890d9c 100644
--- a/drivers/media/dvb-frontends/stb0899_drv.c
+++ b/drivers/media/dvb-frontends/stb0899_drv.c
@@ -1650,7 +1650,7 @@ struct dvb_frontend *stb0899_attach(struct stb0899_config *config, struct i2c_ad
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(stb0899_attach);
+EXPORT_SYMBOL_GPL(stb0899_attach);
 MODULE_PARM_DESC(verbose, "Set Verbosity level");
 MODULE_AUTHOR("Manu Abraham");
 MODULE_DESCRIPTION("STB0899 Multi-Std frontend");
diff --git a/drivers/media/dvb-frontends/stb6000.c b/drivers/media/dvb-frontends/stb6000.c
index 786b9eccde00..c5e6ddb0ae88 100644
--- a/drivers/media/dvb-frontends/stb6000.c
+++ b/drivers/media/dvb-frontends/stb6000.c
@@ -245,7 +245,7 @@ struct dvb_frontend *stb6000_attach(struct dvb_frontend *fe, int addr,
 
 	return fe;
 }
-EXPORT_SYMBOL(stb6000_attach);
+EXPORT_SYMBOL_GPL(stb6000_attach);
 
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
diff --git a/drivers/media/dvb-frontends/stb6100.c b/drivers/media/dvb-frontends/stb6100.c
index 30ac584dfab3..3ea6da8d847d 100644
--- a/drivers/media/dvb-frontends/stb6100.c
+++ b/drivers/media/dvb-frontends/stb6100.c
@@ -569,7 +569,7 @@ static void stb6100_release(struct dvb_frontend *fe)
 	kfree(state);
 }
 
-EXPORT_SYMBOL(stb6100_attach);
+EXPORT_SYMBOL_GPL(stb6100_attach);
 MODULE_PARM_DESC(verbose, "Set Verbosity level");
 
 MODULE_AUTHOR("Manu Abraham");
diff --git a/drivers/media/dvb-frontends/stv0288.c b/drivers/media/dvb-frontends/stv0288.c
index ca5d8e41c114..b2b01fcbbfc8 100644
--- a/drivers/media/dvb-frontends/stv0288.c
+++ b/drivers/media/dvb-frontends/stv0288.c
@@ -602,7 +602,7 @@ struct dvb_frontend *stv0288_attach(const struct stv0288_config *config,
 
 	return NULL;
 }
-EXPORT_SYMBOL(stv0288_attach);
+EXPORT_SYMBOL_GPL(stv0288_attach);
 
 module_param(debug_legacy_dish_switch, int, 0444);
 MODULE_PARM_DESC(debug_legacy_dish_switch,
diff --git a/drivers/media/dvb-frontends/stv0297.c b/drivers/media/dvb-frontends/stv0297.c
index 3ef31a3a27ff..f90f97b9216f 100644
--- a/drivers/media/dvb-frontends/stv0297.c
+++ b/drivers/media/dvb-frontends/stv0297.c
@@ -722,4 +722,4 @@ MODULE_DESCRIPTION("ST STV0297 DVB-C Demodulator driver");
 MODULE_AUTHOR("Dennis Noermann and Andrew de Quincey");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(stv0297_attach);
+EXPORT_SYMBOL_GPL(stv0297_attach);
diff --git a/drivers/media/dvb-frontends/stv0299.c b/drivers/media/dvb-frontends/stv0299.c
index 4f466394a16c..822d9add1ecc 100644
--- a/drivers/media/dvb-frontends/stv0299.c
+++ b/drivers/media/dvb-frontends/stv0299.c
@@ -763,4 +763,4 @@ MODULE_DESCRIPTION("ST STV0299 DVB Demodulator driver");
 MODULE_AUTHOR("Ralph Metzler, Holger Waechtler, Peter Schildmann, Felix Domke, Andreas Oberritter, Andrew de Quincey, Kenneth Aafly");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(stv0299_attach);
+EXPORT_SYMBOL_GPL(stv0299_attach);
diff --git a/drivers/media/dvb-frontends/stv0367.c b/drivers/media/dvb-frontends/stv0367.c
index 5b91e740e135..49f4472f09fa 100644
--- a/drivers/media/dvb-frontends/stv0367.c
+++ b/drivers/media/dvb-frontends/stv0367.c
@@ -1760,7 +1760,7 @@ struct dvb_frontend *stv0367ter_attach(const struct stv0367_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(stv0367ter_attach);
+EXPORT_SYMBOL_GPL(stv0367ter_attach);
 
 static int stv0367cab_gate_ctrl(struct dvb_frontend *fe, int enable)
 {
@@ -2933,7 +2933,7 @@ struct dvb_frontend *stv0367cab_attach(const struct stv0367_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(stv0367cab_attach);
+EXPORT_SYMBOL_GPL(stv0367cab_attach);
 
 /*
  * Functions for operation on Digital Devices hardware
@@ -3354,7 +3354,7 @@ struct dvb_frontend *stv0367ddb_attach(const struct stv0367_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(stv0367ddb_attach);
+EXPORT_SYMBOL_GPL(stv0367ddb_attach);
 
 MODULE_PARM_DESC(debug, "Set debug");
 MODULE_PARM_DESC(i2c_debug, "Set i2c debug");
diff --git a/drivers/media/dvb-frontends/stv0900_core.c b/drivers/media/dvb-frontends/stv0900_core.c
index 254618a06140..272a408dadc6 100644
--- a/drivers/media/dvb-frontends/stv0900_core.c
+++ b/drivers/media/dvb-frontends/stv0900_core.c
@@ -1967,7 +1967,7 @@ struct dvb_frontend *stv0900_attach(const struct stv0900_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(stv0900_attach);
+EXPORT_SYMBOL_GPL(stv0900_attach);
 
 MODULE_PARM_DESC(debug, "Set debug");
 
diff --git a/drivers/media/dvb-frontends/stv6110.c b/drivers/media/dvb-frontends/stv6110.c
index 7db9a5bceccc..adb881c77acb 100644
--- a/drivers/media/dvb-frontends/stv6110.c
+++ b/drivers/media/dvb-frontends/stv6110.c
@@ -437,7 +437,7 @@ struct dvb_frontend *stv6110_attach(struct dvb_frontend *fe,
 
 	return fe;
 }
-EXPORT_SYMBOL(stv6110_attach);
+EXPORT_SYMBOL_GPL(stv6110_attach);
 
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
diff --git a/drivers/media/dvb-frontends/stv6110x.c b/drivers/media/dvb-frontends/stv6110x.c
index 82c002d3833a..6d87e271ff58 100644
--- a/drivers/media/dvb-frontends/stv6110x.c
+++ b/drivers/media/dvb-frontends/stv6110x.c
@@ -408,7 +408,7 @@ const struct stv6110x_devctl *stv6110x_attach(struct dvb_frontend *fe,
 	printk(KERN_INFO "%s: Attaching STV6110x\n", __func__);
 	return stv6110x->devctl;
 }
-EXPORT_SYMBOL(stv6110x_attach);
+EXPORT_SYMBOL_GPL(stv6110x_attach);
 
 MODULE_AUTHOR("Manu Abraham");
 MODULE_DESCRIPTION("STV6110x Silicon tuner");
diff --git a/drivers/media/dvb-frontends/tda10021.c b/drivers/media/dvb-frontends/tda10021.c
index 5cd885d4ea04..d765b72928ef 100644
--- a/drivers/media/dvb-frontends/tda10021.c
+++ b/drivers/media/dvb-frontends/tda10021.c
@@ -525,4 +525,4 @@ MODULE_DESCRIPTION("Philips TDA10021 DVB-C demodulator driver");
 MODULE_AUTHOR("Ralph Metzler, Holger Waechtler, Markus Schulz");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(tda10021_attach);
+EXPORT_SYMBOL_GPL(tda10021_attach);
diff --git a/drivers/media/dvb-frontends/tda10023.c b/drivers/media/dvb-frontends/tda10023.c
index 0a9a54563ebe..c3d0e5057336 100644
--- a/drivers/media/dvb-frontends/tda10023.c
+++ b/drivers/media/dvb-frontends/tda10023.c
@@ -606,4 +606,4 @@ MODULE_DESCRIPTION("Philips TDA10023 DVB-C demodulator driver");
 MODULE_AUTHOR("Georg Acher, Hartmut Birr");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(tda10023_attach);
+EXPORT_SYMBOL_GPL(tda10023_attach);
diff --git a/drivers/media/dvb-frontends/tda10048.c b/drivers/media/dvb-frontends/tda10048.c
index c01d60a88af2..6ca1b25542c5 100644
--- a/drivers/media/dvb-frontends/tda10048.c
+++ b/drivers/media/dvb-frontends/tda10048.c
@@ -1150,7 +1150,7 @@ struct dvb_frontend *tda10048_attach(const struct tda10048_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(tda10048_attach);
+EXPORT_SYMBOL_GPL(tda10048_attach);
 
 static const struct dvb_frontend_ops tda10048_ops = {
 	.delsys = { SYS_DVBT },
diff --git a/drivers/media/dvb-frontends/tda1004x.c b/drivers/media/dvb-frontends/tda1004x.c
index e506f66657bb..57bb83e4d4c7 100644
--- a/drivers/media/dvb-frontends/tda1004x.c
+++ b/drivers/media/dvb-frontends/tda1004x.c
@@ -1391,5 +1391,5 @@ MODULE_DESCRIPTION("Philips TDA10045H & TDA10046H DVB-T Demodulator");
 MODULE_AUTHOR("Andrew de Quincey & Robert Schlabbach");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(tda10045_attach);
-EXPORT_SYMBOL(tda10046_attach);
+EXPORT_SYMBOL_GPL(tda10045_attach);
+EXPORT_SYMBOL_GPL(tda10046_attach);
diff --git a/drivers/media/dvb-frontends/tda10086.c b/drivers/media/dvb-frontends/tda10086.c
index 8323e4e53d66..a3457a915dc8 100644
--- a/drivers/media/dvb-frontends/tda10086.c
+++ b/drivers/media/dvb-frontends/tda10086.c
@@ -777,4 +777,4 @@ MODULE_DESCRIPTION("Philips TDA10086 DVB-S Demodulator");
 MODULE_AUTHOR("Andrew de Quincey");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(tda10086_attach);
+EXPORT_SYMBOL_GPL(tda10086_attach);
diff --git a/drivers/media/dvb-frontends/tda665x.c b/drivers/media/dvb-frontends/tda665x.c
index 8766c9ff6680..d1ccdf19a146 100644
--- a/drivers/media/dvb-frontends/tda665x.c
+++ b/drivers/media/dvb-frontends/tda665x.c
@@ -239,7 +239,7 @@ struct dvb_frontend *tda665x_attach(struct dvb_frontend *fe,
 
 	return fe;
 }
-EXPORT_SYMBOL(tda665x_attach);
+EXPORT_SYMBOL_GPL(tda665x_attach);
 
 MODULE_DESCRIPTION("TDA665x driver");
 MODULE_AUTHOR("Manu Abraham");
diff --git a/drivers/media/dvb-frontends/tda8083.c b/drivers/media/dvb-frontends/tda8083.c
index 53b26060db7e..721513ecdbe8 100644
--- a/drivers/media/dvb-frontends/tda8083.c
+++ b/drivers/media/dvb-frontends/tda8083.c
@@ -493,4 +493,4 @@ MODULE_DESCRIPTION("Philips TDA8083 DVB-S Demodulator");
 MODULE_AUTHOR("Ralph Metzler, Holger Waechtler");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(tda8083_attach);
+EXPORT_SYMBOL_GPL(tda8083_attach);
diff --git a/drivers/media/dvb-frontends/tda8261.c b/drivers/media/dvb-frontends/tda8261.c
index 500f50b81b66..50e25ded3084 100644
--- a/drivers/media/dvb-frontends/tda8261.c
+++ b/drivers/media/dvb-frontends/tda8261.c
@@ -200,7 +200,7 @@ struct dvb_frontend *tda8261_attach(struct dvb_frontend *fe,
 	return NULL;
 }
 
-EXPORT_SYMBOL(tda8261_attach);
+EXPORT_SYMBOL_GPL(tda8261_attach);
 
 MODULE_AUTHOR("Manu Abraham");
 MODULE_DESCRIPTION("TDA8261 8PSK/QPSK Tuner");
diff --git a/drivers/media/dvb-frontends/tda826x.c b/drivers/media/dvb-frontends/tda826x.c
index 100da5d5fdc5..c5dd1e6a358d 100644
--- a/drivers/media/dvb-frontends/tda826x.c
+++ b/drivers/media/dvb-frontends/tda826x.c
@@ -177,7 +177,7 @@ struct dvb_frontend *tda826x_attach(struct dvb_frontend *fe, int addr, struct i2
 
 	return fe;
 }
-EXPORT_SYMBOL(tda826x_attach);
+EXPORT_SYMBOL_GPL(tda826x_attach);
 
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
diff --git a/drivers/media/dvb-frontends/ts2020.c b/drivers/media/dvb-frontends/ts2020.c
index 3e3e40878633..1bcf822078eb 100644
--- a/drivers/media/dvb-frontends/ts2020.c
+++ b/drivers/media/dvb-frontends/ts2020.c
@@ -534,7 +534,7 @@ struct dvb_frontend *ts2020_attach(struct dvb_frontend *fe,
 
 	return fe;
 }
-EXPORT_SYMBOL(ts2020_attach);
+EXPORT_SYMBOL_GPL(ts2020_attach);
 
 /*
  * We implement own regmap locking due to legacy DVB attach which uses frontend
diff --git a/drivers/media/dvb-frontends/tua6100.c b/drivers/media/dvb-frontends/tua6100.c
index e6aaf4973aef..647182eb5fa4 100644
--- a/drivers/media/dvb-frontends/tua6100.c
+++ b/drivers/media/dvb-frontends/tua6100.c
@@ -194,7 +194,7 @@ struct dvb_frontend *tua6100_attach(struct dvb_frontend *fe, int addr, struct i2
 	fe->tuner_priv = priv;
 	return fe;
 }
-EXPORT_SYMBOL(tua6100_attach);
+EXPORT_SYMBOL_GPL(tua6100_attach);
 
 MODULE_DESCRIPTION("DVB tua6100 driver");
 MODULE_AUTHOR("Andrew de Quincey");
diff --git a/drivers/media/dvb-frontends/ves1820.c b/drivers/media/dvb-frontends/ves1820.c
index eb1249d81310..56e71e780fdd 100644
--- a/drivers/media/dvb-frontends/ves1820.c
+++ b/drivers/media/dvb-frontends/ves1820.c
@@ -446,4 +446,4 @@ MODULE_DESCRIPTION("VLSI VES1820 DVB-C Demodulator driver");
 MODULE_AUTHOR("Ralph Metzler, Holger Waechtler");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(ves1820_attach);
+EXPORT_SYMBOL_GPL(ves1820_attach);
diff --git a/drivers/media/dvb-frontends/ves1x93.c b/drivers/media/dvb-frontends/ves1x93.c
index ddc5bfd84cd5..071c59057e6d 100644
--- a/drivers/media/dvb-frontends/ves1x93.c
+++ b/drivers/media/dvb-frontends/ves1x93.c
@@ -553,4 +553,4 @@ MODULE_DESCRIPTION("VLSI VES1x93 DVB-S Demodulator driver");
 MODULE_AUTHOR("Ralph Metzler");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(ves1x93_attach);
+EXPORT_SYMBOL_GPL(ves1x93_attach);
diff --git a/drivers/media/dvb-frontends/zl10036.c b/drivers/media/dvb-frontends/zl10036.c
index f1c92338015d..cd1156c18a8b 100644
--- a/drivers/media/dvb-frontends/zl10036.c
+++ b/drivers/media/dvb-frontends/zl10036.c
@@ -504,7 +504,7 @@ struct dvb_frontend *zl10036_attach(struct dvb_frontend *fe,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(zl10036_attach);
+EXPORT_SYMBOL_GPL(zl10036_attach);
 
 module_param_named(debug, zl10036_debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
diff --git a/drivers/media/dvb-frontends/zl10039.c b/drivers/media/dvb-frontends/zl10039.c
index 6293bd920fa6..b3a76c00fe88 100644
--- a/drivers/media/dvb-frontends/zl10039.c
+++ b/drivers/media/dvb-frontends/zl10039.c
@@ -304,7 +304,7 @@ struct dvb_frontend *zl10039_attach(struct dvb_frontend *fe,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(zl10039_attach);
+EXPORT_SYMBOL_GPL(zl10039_attach);
 
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
diff --git a/drivers/media/dvb-frontends/zl10353.c b/drivers/media/dvb-frontends/zl10353.c
index 42e63a3fa121..e2a5dfe93732 100644
--- a/drivers/media/dvb-frontends/zl10353.c
+++ b/drivers/media/dvb-frontends/zl10353.c
@@ -675,4 +675,4 @@ MODULE_DESCRIPTION("Zarlink ZL10353 DVB-T demodulator driver");
 MODULE_AUTHOR("Chris Pascoe");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(zl10353_attach);
+EXPORT_SYMBOL_GPL(zl10353_attach);
diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index d8798fb714ba..40d583a972a4 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -85,15 +85,8 @@ struct ov2680_mode_info {
 
 struct ov2680_ctrls {
 	struct v4l2_ctrl_handler handler;
-	struct {
-		struct v4l2_ctrl *auto_exp;
-		struct v4l2_ctrl *exposure;
-	};
-	struct {
-		struct v4l2_ctrl *auto_gain;
-		struct v4l2_ctrl *gain;
-	};
-
+	struct v4l2_ctrl *exposure;
+	struct v4l2_ctrl *gain;
 	struct v4l2_ctrl *hflip;
 	struct v4l2_ctrl *vflip;
 	struct v4l2_ctrl *test_pattern;
@@ -143,6 +136,7 @@ static const struct reg_value ov2680_setting_30fps_QUXGA_800_600[] = {
 	{0x380e, 0x02}, {0x380f, 0x84}, {0x3811, 0x04}, {0x3813, 0x04},
 	{0x3814, 0x31}, {0x3815, 0x31}, {0x3820, 0xc0}, {0x4008, 0x00},
 	{0x4009, 0x03}, {0x4837, 0x1e}, {0x3501, 0x4e}, {0x3502, 0xe0},
+	{0x3503, 0x03},
 };
 
 static const struct reg_value ov2680_setting_30fps_720P_1280_720[] = {
@@ -321,70 +315,49 @@ static void ov2680_power_down(struct ov2680_dev *sensor)
 	usleep_range(5000, 10000);
 }
 
-static int ov2680_bayer_order(struct ov2680_dev *sensor)
+static void ov2680_set_bayer_order(struct ov2680_dev *sensor)
 {
-	u32 format1;
-	u32 format2;
-	u32 hv_flip;
-	int ret;
-
-	ret = ov2680_read_reg(sensor, OV2680_REG_FORMAT1, &format1);
-	if (ret < 0)
-		return ret;
+	int hv_flip = 0;
 
-	ret = ov2680_read_reg(sensor, OV2680_REG_FORMAT2, &format2);
-	if (ret < 0)
-		return ret;
+	if (sensor->ctrls.vflip && sensor->ctrls.vflip->val)
+		hv_flip += 1;
 
-	hv_flip = (format2 & BIT(2)  << 1) | (format1 & BIT(2));
+	if (sensor->ctrls.hflip && sensor->ctrls.hflip->val)
+		hv_flip += 2;
 
 	sensor->fmt.code = ov2680_hv_flip_bayer_order[hv_flip];
-
-	return 0;
 }
 
-static int ov2680_vflip_enable(struct ov2680_dev *sensor)
+static int ov2680_set_vflip(struct ov2680_dev *sensor, s32 val)
 {
 	int ret;
 
-	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT1, BIT(2), BIT(2));
-	if (ret < 0)
-		return ret;
-
-	return ov2680_bayer_order(sensor);
-}
-
-static int ov2680_vflip_disable(struct ov2680_dev *sensor)
-{
-	int ret;
+	if (sensor->is_streaming)
+		return -EBUSY;
 
-	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT1, BIT(2), BIT(0));
+	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT1,
+			     BIT(2), val ? BIT(2) : 0);
 	if (ret < 0)
 		return ret;
 
-	return ov2680_bayer_order(sensor);
+	ov2680_set_bayer_order(sensor);
+	return 0;
 }
 
-static int ov2680_hflip_enable(struct ov2680_dev *sensor)
+static int ov2680_set_hflip(struct ov2680_dev *sensor, s32 val)
 {
 	int ret;
 
-	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT2, BIT(2), BIT(2));
-	if (ret < 0)
-		return ret;
-
-	return ov2680_bayer_order(sensor);
-}
-
-static int ov2680_hflip_disable(struct ov2680_dev *sensor)
-{
-	int ret;
+	if (sensor->is_streaming)
+		return -EBUSY;
 
-	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT2, BIT(2), BIT(0));
+	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT2,
+			     BIT(2), val ? BIT(2) : 0);
 	if (ret < 0)
 		return ret;
 
-	return ov2680_bayer_order(sensor);
+	ov2680_set_bayer_order(sensor);
+	return 0;
 }
 
 static int ov2680_test_pattern_set(struct ov2680_dev *sensor, int value)
@@ -405,69 +378,15 @@ static int ov2680_test_pattern_set(struct ov2680_dev *sensor, int value)
 	return 0;
 }
 
-static int ov2680_gain_set(struct ov2680_dev *sensor, bool auto_gain)
+static int ov2680_gain_set(struct ov2680_dev *sensor, u32 gain)
 {
-	struct ov2680_ctrls *ctrls = &sensor->ctrls;
-	u32 gain;
-	int ret;
-
-	ret = ov2680_mod_reg(sensor, OV2680_REG_R_MANUAL, BIT(1),
-			     auto_gain ? 0 : BIT(1));
-	if (ret < 0)
-		return ret;
-
-	if (auto_gain || !ctrls->gain->is_new)
-		return 0;
-
-	gain = ctrls->gain->val;
-
-	ret = ov2680_write_reg16(sensor, OV2680_REG_GAIN_PK, gain);
-
-	return 0;
+	return ov2680_write_reg16(sensor, OV2680_REG_GAIN_PK, gain);
 }
 
-static int ov2680_gain_get(struct ov2680_dev *sensor)
+static int ov2680_exposure_set(struct ov2680_dev *sensor, u32 exp)
 {
-	u32 gain;
-	int ret;
-
-	ret = ov2680_read_reg16(sensor, OV2680_REG_GAIN_PK, &gain);
-	if (ret)
-		return ret;
-
-	return gain;
-}
-
-static int ov2680_exposure_set(struct ov2680_dev *sensor, bool auto_exp)
-{
-	struct ov2680_ctrls *ctrls = &sensor->ctrls;
-	u32 exp;
-	int ret;
-
-	ret = ov2680_mod_reg(sensor, OV2680_REG_R_MANUAL, BIT(0),
-			     auto_exp ? 0 : BIT(0));
-	if (ret < 0)
-		return ret;
-
-	if (auto_exp || !ctrls->exposure->is_new)
-		return 0;
-
-	exp = (u32)ctrls->exposure->val;
-	exp <<= 4;
-
-	return ov2680_write_reg24(sensor, OV2680_REG_EXPOSURE_PK_HIGH, exp);
-}
-
-static int ov2680_exposure_get(struct ov2680_dev *sensor)
-{
-	int ret;
-	u32 exp;
-
-	ret = ov2680_read_reg24(sensor, OV2680_REG_EXPOSURE_PK_HIGH, &exp);
-	if (ret)
-		return ret;
-
-	return exp >> 4;
+	return ov2680_write_reg24(sensor, OV2680_REG_EXPOSURE_PK_HIGH,
+				  exp << 4);
 }
 
 static int ov2680_stream_enable(struct ov2680_dev *sensor)
@@ -482,33 +401,17 @@ static int ov2680_stream_disable(struct ov2680_dev *sensor)
 
 static int ov2680_mode_set(struct ov2680_dev *sensor)
 {
-	struct ov2680_ctrls *ctrls = &sensor->ctrls;
 	int ret;
 
-	ret = ov2680_gain_set(sensor, false);
+	ret = ov2680_load_regs(sensor, sensor->current_mode);
 	if (ret < 0)
 		return ret;
 
-	ret = ov2680_exposure_set(sensor, false);
+	/* Restore value of all ctrls */
+	ret = __v4l2_ctrl_handler_setup(&sensor->ctrls.handler);
 	if (ret < 0)
 		return ret;
 
-	ret = ov2680_load_regs(sensor, sensor->current_mode);
-	if (ret < 0)
-		return ret;
-
-	if (ctrls->auto_gain->val) {
-		ret = ov2680_gain_set(sensor, true);
-		if (ret < 0)
-			return ret;
-	}
-
-	if (ctrls->auto_exp->val == V4L2_EXPOSURE_AUTO) {
-		ret = ov2680_exposure_set(sensor, true);
-		if (ret < 0)
-			return ret;
-	}
-
 	sensor->mode_pending_changes = false;
 
 	return 0;
@@ -556,7 +459,7 @@ static int ov2680_power_on(struct ov2680_dev *sensor)
 		ret = ov2680_write_reg(sensor, OV2680_REG_SOFT_RESET, 0x01);
 		if (ret != 0) {
 			dev_err(dev, "sensor soft reset failed\n");
-			return ret;
+			goto err_disable_regulators;
 		}
 		usleep_range(1000, 2000);
 	} else {
@@ -566,7 +469,7 @@ static int ov2680_power_on(struct ov2680_dev *sensor)
 
 	ret = clk_prepare_enable(sensor->xvclk);
 	if (ret < 0)
-		return ret;
+		goto err_disable_regulators;
 
 	sensor->is_enabled = true;
 
@@ -576,6 +479,10 @@ static int ov2680_power_on(struct ov2680_dev *sensor)
 	ov2680_stream_disable(sensor);
 
 	return 0;
+
+err_disable_regulators:
+	regulator_bulk_disable(OV2680_NUM_SUPPLIES, sensor->supplies);
+	return ret;
 }
 
 static int ov2680_s_power(struct v4l2_subdev *sd, int on)
@@ -590,15 +497,10 @@ static int ov2680_s_power(struct v4l2_subdev *sd, int on)
 	else
 		ret = ov2680_power_off(sensor);
 
-	mutex_unlock(&sensor->lock);
-
-	if (on && ret == 0) {
-		ret = v4l2_ctrl_handler_setup(&sensor->ctrls.handler);
-		if (ret < 0)
-			return ret;
-
+	if (on && ret == 0)
 		ret = ov2680_mode_restore(sensor);
-	}
+
+	mutex_unlock(&sensor->lock);
 
 	return ret;
 }
@@ -796,66 +698,23 @@ static int ov2680_enum_frame_interval(struct v4l2_subdev *sd,
 	return 0;
 }
 
-static int ov2680_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
-{
-	struct v4l2_subdev *sd = ctrl_to_sd(ctrl);
-	struct ov2680_dev *sensor = to_ov2680_dev(sd);
-	struct ov2680_ctrls *ctrls = &sensor->ctrls;
-	int val;
-
-	if (!sensor->is_enabled)
-		return 0;
-
-	switch (ctrl->id) {
-	case V4L2_CID_GAIN:
-		val = ov2680_gain_get(sensor);
-		if (val < 0)
-			return val;
-		ctrls->gain->val = val;
-		break;
-	case V4L2_CID_EXPOSURE:
-		val = ov2680_exposure_get(sensor);
-		if (val < 0)
-			return val;
-		ctrls->exposure->val = val;
-		break;
-	}
-
-	return 0;
-}
-
 static int ov2680_s_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct v4l2_subdev *sd = ctrl_to_sd(ctrl);
 	struct ov2680_dev *sensor = to_ov2680_dev(sd);
-	struct ov2680_ctrls *ctrls = &sensor->ctrls;
 
 	if (!sensor->is_enabled)
 		return 0;
 
 	switch (ctrl->id) {
-	case V4L2_CID_AUTOGAIN:
-		return ov2680_gain_set(sensor, !!ctrl->val);
 	case V4L2_CID_GAIN:
-		return ov2680_gain_set(sensor, !!ctrls->auto_gain->val);
-	case V4L2_CID_EXPOSURE_AUTO:
-		return ov2680_exposure_set(sensor, !!ctrl->val);
+		return ov2680_gain_set(sensor, ctrl->val);
 	case V4L2_CID_EXPOSURE:
-		return ov2680_exposure_set(sensor, !!ctrls->auto_exp->val);
+		return ov2680_exposure_set(sensor, ctrl->val);
 	case V4L2_CID_VFLIP:
-		if (sensor->is_streaming)
-			return -EBUSY;
-		if (ctrl->val)
-			return ov2680_vflip_enable(sensor);
-		else
-			return ov2680_vflip_disable(sensor);
+		return ov2680_set_vflip(sensor, ctrl->val);
 	case V4L2_CID_HFLIP:
-		if (sensor->is_streaming)
-			return -EBUSY;
-		if (ctrl->val)
-			return ov2680_hflip_enable(sensor);
-		else
-			return ov2680_hflip_disable(sensor);
+		return ov2680_set_hflip(sensor, ctrl->val);
 	case V4L2_CID_TEST_PATTERN:
 		return ov2680_test_pattern_set(sensor, ctrl->val);
 	default:
@@ -866,7 +725,6 @@ static int ov2680_s_ctrl(struct v4l2_ctrl *ctrl)
 }
 
 static const struct v4l2_ctrl_ops ov2680_ctrl_ops = {
-	.g_volatile_ctrl = ov2680_g_volatile_ctrl,
 	.s_ctrl = ov2680_s_ctrl,
 };
 
@@ -938,7 +796,7 @@ static int ov2680_v4l2_init(struct ov2680_dev *sensor)
 	if (ret < 0)
 		return ret;
 
-	v4l2_ctrl_handler_init(hdl, 7);
+	v4l2_ctrl_handler_init(hdl, 5);
 
 	hdl->lock = &sensor->lock;
 
@@ -950,16 +808,9 @@ static int ov2680_v4l2_init(struct ov2680_dev *sensor)
 					ARRAY_SIZE(test_pattern_menu) - 1,
 					0, 0, test_pattern_menu);
 
-	ctrls->auto_exp = v4l2_ctrl_new_std_menu(hdl, ops,
-						 V4L2_CID_EXPOSURE_AUTO,
-						 V4L2_EXPOSURE_MANUAL, 0,
-						 V4L2_EXPOSURE_AUTO);
-
 	ctrls->exposure = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_EXPOSURE,
 					    0, 32767, 1, 0);
 
-	ctrls->auto_gain = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_AUTOGAIN,
-					     0, 1, 1, 1);
 	ctrls->gain = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_GAIN, 0, 2047, 1, 0);
 
 	if (hdl->error) {
@@ -967,11 +818,8 @@ static int ov2680_v4l2_init(struct ov2680_dev *sensor)
 		goto cleanup_entity;
 	}
 
-	ctrls->gain->flags |= V4L2_CTRL_FLAG_VOLATILE;
-	ctrls->exposure->flags |= V4L2_CTRL_FLAG_VOLATILE;
-
-	v4l2_ctrl_auto_cluster(2, &ctrls->auto_gain, 0, true);
-	v4l2_ctrl_auto_cluster(2, &ctrls->auto_exp, 1, true);
+	ctrls->vflip->flags |= V4L2_CTRL_FLAG_MODIFY_LAYOUT;
+	ctrls->hflip->flags |= V4L2_CTRL_FLAG_MODIFY_LAYOUT;
 
 	sensor->sd.ctrl_handler = hdl;
 
diff --git a/drivers/media/pci/bt8xx/dst.c b/drivers/media/pci/bt8xx/dst.c
index b98de2a22f78..0e52a8be03eb 100644
--- a/drivers/media/pci/bt8xx/dst.c
+++ b/drivers/media/pci/bt8xx/dst.c
@@ -1733,7 +1733,7 @@ struct dst_state *dst_attach(struct dst_state *state, struct dvb_adapter *dvb_ad
 	return state;				/*	Manu (DST is a card not a frontend)	*/
 }
 
-EXPORT_SYMBOL(dst_attach);
+EXPORT_SYMBOL_GPL(dst_attach);
 
 static const struct dvb_frontend_ops dst_dvbt_ops = {
 	.delsys = { SYS_DVBT },
diff --git a/drivers/media/pci/bt8xx/dst_ca.c b/drivers/media/pci/bt8xx/dst_ca.c
index 0a7623c0fc8e..d4c5fe2c186b 100644
--- a/drivers/media/pci/bt8xx/dst_ca.c
+++ b/drivers/media/pci/bt8xx/dst_ca.c
@@ -680,7 +680,7 @@ struct dvb_device *dst_ca_attach(struct dst_state *dst, struct dvb_adapter *dvb_
 	return NULL;
 }
 
-EXPORT_SYMBOL(dst_ca_attach);
+EXPORT_SYMBOL_GPL(dst_ca_attach);
 
 MODULE_DESCRIPTION("DST DVB-S/T/C Combo CA driver");
 MODULE_AUTHOR("Manu Abraham");
diff --git a/drivers/media/pci/cx23885/cx23885-video.c b/drivers/media/pci/cx23885/cx23885-video.c
index 2a20c7165e1e..16564899f114 100644
--- a/drivers/media/pci/cx23885/cx23885-video.c
+++ b/drivers/media/pci/cx23885/cx23885-video.c
@@ -420,7 +420,7 @@ static int buffer_prepare(struct vb2_buffer *vb)
 				dev->height >> 1);
 		break;
 	default:
-		BUG();
+		return -EINVAL; /* should not happen */
 	}
 	dprintk(2, "[%p/%d] buffer_init - %dx%d %dbpp \"%s\" - dma=0x%08lx\n",
 		buf, buf->vb.vb2_buf.index,
diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index 070ddb52c823..2c037538c7d8 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -361,7 +361,7 @@ static int cio2_hw_init(struct cio2_device *cio2, struct cio2_queue *q)
 	void __iomem *const base = cio2->base;
 	u8 lanes, csi2bus = q->csi2.port;
 	u8 sensor_vc = SENSOR_VIR_CH_DFLT;
-	struct cio2_csi2_timing timing;
+	struct cio2_csi2_timing timing = { 0 };
 	int i, r;
 
 	fmt = cio2_find_format(NULL, &q->subdev_fmt.code);
diff --git a/drivers/media/platform/exynos4-is/media-dev.c b/drivers/media/platform/exynos4-is/media-dev.c
index 03171f2cf296..5f50ea283a04 100644
--- a/drivers/media/platform/exynos4-is/media-dev.c
+++ b/drivers/media/platform/exynos4-is/media-dev.c
@@ -445,7 +445,7 @@ static int fimc_md_parse_port_node(struct fimc_md *fmd,
 	 */
 	np = of_get_parent(rem);
 
-	if (np && !of_node_cmp(np->name, "i2c-isp"))
+	if (of_node_name_eq(np, "i2c-isp"))
 		pd->fimc_bus_type = FIMC_BUS_TYPE_ISP_WRITEBACK;
 	else
 		pd->fimc_bus_type = pd->sensor_bus_type;
@@ -492,7 +492,7 @@ static int fimc_md_register_sensor_entities(struct fimc_md *fmd)
 	for_each_available_child_of_node(parent, node) {
 		struct device_node *port;
 
-		if (of_node_cmp(node->name, "csis"))
+		if (!of_node_name_eq(node, "csis"))
 			continue;
 		/* The csis node can have only port subnode. */
 		port = of_get_next_child(node, NULL);
@@ -713,13 +713,13 @@ static int fimc_md_register_platform_entities(struct fimc_md *fmd,
 			continue;
 
 		/* If driver of any entity isn't ready try all again later. */
-		if (!strcmp(node->name, CSIS_OF_NODE_NAME))
+		if (of_node_name_eq(node, CSIS_OF_NODE_NAME))
 			plat_entity = IDX_CSIS;
-		else if	(!strcmp(node->name, FIMC_IS_OF_NODE_NAME))
+		else if (of_node_name_eq(node, FIMC_IS_OF_NODE_NAME))
 			plat_entity = IDX_IS_ISP;
-		else if (!strcmp(node->name, FIMC_LITE_OF_NODE_NAME))
+		else if (of_node_name_eq(node, FIMC_LITE_OF_NODE_NAME))
 			plat_entity = IDX_FLITE;
-		else if	(!strcmp(node->name, FIMC_OF_NODE_NAME) &&
+		else if (of_node_name_eq(node, FIMC_OF_NODE_NAME) &&
 			 !of_property_read_bool(node, "samsung,lcd-wb"))
 			plat_entity = IDX_FIMC;
 
diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c b/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
index bc8349bc2e80..2c0d89a46410 100644
--- a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
+++ b/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
@@ -230,10 +230,11 @@ static struct vdec_fb *vp9_rm_from_fb_use_list(struct vdec_vp9_inst
 		if (fb->base_y.va == addr) {
 			list_move_tail(&node->list,
 				       &inst->available_fb_node_list);
-			break;
+			return fb;
 		}
 	}
-	return fb;
+
+	return NULL;
 }
 
 static void vp9_add_to_fb_free_list(struct vdec_vp9_inst *inst,
diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index d945323fc437..f9488e01a36f 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -1618,7 +1618,7 @@ of_get_next_port(const struct device_node *parent,
 				return NULL;
 			}
 			prev = port;
-		} while (of_node_cmp(port->name, "port") != 0);
+		} while (!of_node_name_eq(port, "port"));
 	}
 
 	return port;
@@ -1638,7 +1638,7 @@ of_get_next_endpoint(const struct device_node *parent,
 		if (!ep)
 			return NULL;
 		prev = ep;
-	} while (of_node_cmp(ep->name, "endpoint") != 0);
+	} while (!of_node_name_eq(ep, "endpoint"));
 
 	return ep;
 }
diff --git a/drivers/media/platform/xilinx/xilinx-tpg.c b/drivers/media/platform/xilinx/xilinx-tpg.c
index 9c49d1d10bee..06d25e5fafbf 100644
--- a/drivers/media/platform/xilinx/xilinx-tpg.c
+++ b/drivers/media/platform/xilinx/xilinx-tpg.c
@@ -725,7 +725,7 @@ static int xtpg_parse_of(struct xtpg_device *xtpg)
 		const struct xvip_video_format *format;
 		struct device_node *endpoint;
 
-		if (!port->name || of_node_cmp(port->name, "port"))
+		if (!of_node_name_eq(port, "port"))
 			continue;
 
 		format = xvip_of_get_format(port);
diff --git a/drivers/media/tuners/fc0011.c b/drivers/media/tuners/fc0011.c
index a983899c6b0b..b407e1965f8a 100644
--- a/drivers/media/tuners/fc0011.c
+++ b/drivers/media/tuners/fc0011.c
@@ -508,7 +508,7 @@ struct dvb_frontend *fc0011_attach(struct dvb_frontend *fe,
 
 	return fe;
 }
-EXPORT_SYMBOL(fc0011_attach);
+EXPORT_SYMBOL_GPL(fc0011_attach);
 
 MODULE_DESCRIPTION("Fitipower FC0011 silicon tuner driver");
 MODULE_AUTHOR("Michael Buesch <m@bues.ch>");
diff --git a/drivers/media/tuners/fc0012.c b/drivers/media/tuners/fc0012.c
index e992b98ae5bc..6789a85b618b 100644
--- a/drivers/media/tuners/fc0012.c
+++ b/drivers/media/tuners/fc0012.c
@@ -504,7 +504,7 @@ struct dvb_frontend *fc0012_attach(struct dvb_frontend *fe,
 
 	return fe;
 }
-EXPORT_SYMBOL(fc0012_attach);
+EXPORT_SYMBOL_GPL(fc0012_attach);
 
 MODULE_DESCRIPTION("Fitipower FC0012 silicon tuner driver");
 MODULE_AUTHOR("Hans-Frieder Vogt <hfvogt@gmx.net>");
diff --git a/drivers/media/tuners/fc0013.c b/drivers/media/tuners/fc0013.c
index fc62afb1450d..0b7ff74a7936 100644
--- a/drivers/media/tuners/fc0013.c
+++ b/drivers/media/tuners/fc0013.c
@@ -618,7 +618,7 @@ struct dvb_frontend *fc0013_attach(struct dvb_frontend *fe,
 
 	return fe;
 }
-EXPORT_SYMBOL(fc0013_attach);
+EXPORT_SYMBOL_GPL(fc0013_attach);
 
 MODULE_DESCRIPTION("Fitipower FC0013 silicon tuner driver");
 MODULE_AUTHOR("Hans-Frieder Vogt <hfvogt@gmx.net>");
diff --git a/drivers/media/tuners/max2165.c b/drivers/media/tuners/max2165.c
index 721d8f722efb..9600989eea5f 100644
--- a/drivers/media/tuners/max2165.c
+++ b/drivers/media/tuners/max2165.c
@@ -420,7 +420,7 @@ struct dvb_frontend *max2165_attach(struct dvb_frontend *fe,
 
 	return fe;
 }
-EXPORT_SYMBOL(max2165_attach);
+EXPORT_SYMBOL_GPL(max2165_attach);
 
 MODULE_AUTHOR("David T. L. Wong <davidtlwong@gmail.com>");
 MODULE_DESCRIPTION("Maxim MAX2165 silicon tuner driver");
diff --git a/drivers/media/tuners/mc44s803.c b/drivers/media/tuners/mc44s803.c
index 2023e081d9ad..7f6d54910f22 100644
--- a/drivers/media/tuners/mc44s803.c
+++ b/drivers/media/tuners/mc44s803.c
@@ -366,7 +366,7 @@ struct dvb_frontend *mc44s803_attach(struct dvb_frontend *fe,
 	kfree(priv);
 	return NULL;
 }
-EXPORT_SYMBOL(mc44s803_attach);
+EXPORT_SYMBOL_GPL(mc44s803_attach);
 
 MODULE_AUTHOR("Jochen Friedrich");
 MODULE_DESCRIPTION("Freescale MC44S803 silicon tuner driver");
diff --git a/drivers/media/tuners/mt2060.c b/drivers/media/tuners/mt2060.c
index 4ace77cfe285..a7fbd4ab2298 100644
--- a/drivers/media/tuners/mt2060.c
+++ b/drivers/media/tuners/mt2060.c
@@ -450,7 +450,7 @@ struct dvb_frontend * mt2060_attach(struct dvb_frontend *fe, struct i2c_adapter
 
 	return fe;
 }
-EXPORT_SYMBOL(mt2060_attach);
+EXPORT_SYMBOL_GPL(mt2060_attach);
 
 static int mt2060_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
diff --git a/drivers/media/tuners/mt2131.c b/drivers/media/tuners/mt2131.c
index 086a7b7cf634..8db33cf31c40 100644
--- a/drivers/media/tuners/mt2131.c
+++ b/drivers/media/tuners/mt2131.c
@@ -284,7 +284,7 @@ struct dvb_frontend * mt2131_attach(struct dvb_frontend *fe,
 	fe->tuner_priv = priv;
 	return fe;
 }
-EXPORT_SYMBOL(mt2131_attach);
+EXPORT_SYMBOL_GPL(mt2131_attach);
 
 MODULE_AUTHOR("Steven Toth");
 MODULE_DESCRIPTION("Microtune MT2131 silicon tuner driver");
diff --git a/drivers/media/tuners/mt2266.c b/drivers/media/tuners/mt2266.c
index e6cc78720de4..5300f71b8fe5 100644
--- a/drivers/media/tuners/mt2266.c
+++ b/drivers/media/tuners/mt2266.c
@@ -345,7 +345,7 @@ struct dvb_frontend * mt2266_attach(struct dvb_frontend *fe, struct i2c_adapter
 	mt2266_calibrate(priv);
 	return fe;
 }
-EXPORT_SYMBOL(mt2266_attach);
+EXPORT_SYMBOL_GPL(mt2266_attach);
 
 MODULE_AUTHOR("Olivier DANET");
 MODULE_DESCRIPTION("Microtune MT2266 silicon tuner driver");
diff --git a/drivers/media/tuners/mxl5005s.c b/drivers/media/tuners/mxl5005s.c
index ec584316c812..2c540653e12e 100644
--- a/drivers/media/tuners/mxl5005s.c
+++ b/drivers/media/tuners/mxl5005s.c
@@ -4114,7 +4114,7 @@ struct dvb_frontend *mxl5005s_attach(struct dvb_frontend *fe,
 	fe->tuner_priv = state;
 	return fe;
 }
-EXPORT_SYMBOL(mxl5005s_attach);
+EXPORT_SYMBOL_GPL(mxl5005s_attach);
 
 MODULE_DESCRIPTION("MaxLinear MXL5005S silicon tuner driver");
 MODULE_AUTHOR("Steven Toth");
diff --git a/drivers/media/tuners/qt1010.c b/drivers/media/tuners/qt1010.c
index 6d397cc85428..3236e2277ab3 100644
--- a/drivers/media/tuners/qt1010.c
+++ b/drivers/media/tuners/qt1010.c
@@ -351,11 +351,12 @@ static int qt1010_init(struct dvb_frontend *fe)
 			else
 				valptr = &tmpval;
 
-			BUG_ON(i >= ARRAY_SIZE(i2c_data) - 1);
-
-			err = qt1010_init_meas1(priv, i2c_data[i+1].reg,
-						i2c_data[i].reg,
-						i2c_data[i].val, valptr);
+			if (i >= ARRAY_SIZE(i2c_data) - 1)
+				err = -EIO;
+			else
+				err = qt1010_init_meas1(priv, i2c_data[i + 1].reg,
+							i2c_data[i].reg,
+							i2c_data[i].val, valptr);
 			i++;
 			break;
 		}
@@ -446,7 +447,7 @@ struct dvb_frontend * qt1010_attach(struct dvb_frontend *fe,
 	fe->tuner_priv = priv;
 	return fe;
 }
-EXPORT_SYMBOL(qt1010_attach);
+EXPORT_SYMBOL_GPL(qt1010_attach);
 
 MODULE_DESCRIPTION("Quantek QT1010 silicon tuner driver");
 MODULE_AUTHOR("Antti Palosaari <crope@iki.fi>");
diff --git a/drivers/media/tuners/tda18218.c b/drivers/media/tuners/tda18218.c
index cbbd4d5e15da..16716b557ade 100644
--- a/drivers/media/tuners/tda18218.c
+++ b/drivers/media/tuners/tda18218.c
@@ -345,7 +345,7 @@ struct dvb_frontend *tda18218_attach(struct dvb_frontend *fe,
 
 	return fe;
 }
-EXPORT_SYMBOL(tda18218_attach);
+EXPORT_SYMBOL_GPL(tda18218_attach);
 
 MODULE_DESCRIPTION("NXP TDA18218HN silicon tuner driver");
 MODULE_AUTHOR("Antti Palosaari <crope@iki.fi>");
diff --git a/drivers/media/tuners/xc4000.c b/drivers/media/tuners/xc4000.c
index eb6d65dae748..0ef8f054a795 100644
--- a/drivers/media/tuners/xc4000.c
+++ b/drivers/media/tuners/xc4000.c
@@ -1754,7 +1754,7 @@ struct dvb_frontend *xc4000_attach(struct dvb_frontend *fe,
 	xc4000_release(fe);
 	return NULL;
 }
-EXPORT_SYMBOL(xc4000_attach);
+EXPORT_SYMBOL_GPL(xc4000_attach);
 
 MODULE_AUTHOR("Steven Toth, Davide Ferri");
 MODULE_DESCRIPTION("Xceive xc4000 silicon tuner driver");
diff --git a/drivers/media/tuners/xc5000.c b/drivers/media/tuners/xc5000.c
index f6b65278e502..1175531a6b9b 100644
--- a/drivers/media/tuners/xc5000.c
+++ b/drivers/media/tuners/xc5000.c
@@ -1470,7 +1470,7 @@ struct dvb_frontend *xc5000_attach(struct dvb_frontend *fe,
 	xc5000_release(fe);
 	return NULL;
 }
-EXPORT_SYMBOL(xc5000_attach);
+EXPORT_SYMBOL_GPL(xc5000_attach);
 
 MODULE_AUTHOR("Steven Toth");
 MODULE_DESCRIPTION("Xceive xc5000 silicon tuner driver");
diff --git a/drivers/media/usb/dvb-usb-v2/af9035.c b/drivers/media/usb/dvb-usb-v2/af9035.c
index 1f6c1eefe389..8a83f27875ec 100644
--- a/drivers/media/usb/dvb-usb-v2/af9035.c
+++ b/drivers/media/usb/dvb-usb-v2/af9035.c
@@ -284,6 +284,7 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 	struct dvb_usb_device *d = i2c_get_adapdata(adap);
 	struct state *state = d_to_priv(d);
 	int ret;
+	u32 reg;
 
 	if (mutex_lock_interruptible(&d->i2c_mutex) < 0)
 		return -EAGAIN;
@@ -336,8 +337,10 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
+			if (msg[0].len < 3 || msg[1].len < 1)
+				return -EOPNOTSUPP;
 			/* demod access via firmware interface */
-			u32 reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
+			reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
 					msg[0].buf[2];
 
 			if (msg[0].addr == state->af9033_i2c_addr[1])
@@ -395,17 +398,16 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
+			if (msg[0].len < 3)
+				return -EOPNOTSUPP;
 			/* demod access via firmware interface */
-			u32 reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
+			reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
 					msg[0].buf[2];
 
 			if (msg[0].addr == state->af9033_i2c_addr[1])
 				reg |= 0x100000;
 
-			ret = (msg[0].len >= 3) ? af9035_wr_regs(d, reg,
-							         &msg[0].buf[3],
-							         msg[0].len - 3)
-					        : -EOPNOTSUPP;
+			ret = af9035_wr_regs(d, reg, &msg[0].buf[3], msg[0].len - 3);
 		} else {
 			/* I2C write */
 			u8 buf[MAX_XFER_SIZE];
diff --git a/drivers/media/usb/dvb-usb-v2/anysee.c b/drivers/media/usb/dvb-usb-v2/anysee.c
index 20ee7eea2a91..83af86505363 100644
--- a/drivers/media/usb/dvb-usb-v2/anysee.c
+++ b/drivers/media/usb/dvb-usb-v2/anysee.c
@@ -211,7 +211,7 @@ static int anysee_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msg,
 
 	while (i < num) {
 		if (num > i + 1 && (msg[i+1].flags & I2C_M_RD)) {
-			if (msg[i].len > 2 || msg[i+1].len > 60) {
+			if (msg[i].len != 2 || msg[i + 1].len > 60) {
 				ret = -EOPNOTSUPP;
 				break;
 			}
diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 8e914be5b7c5..2f40eb6bdbb8 100644
--- a/drivers/media/usb/dvb-usb-v2/az6007.c
+++ b/drivers/media/usb/dvb-usb-v2/az6007.c
@@ -796,6 +796,10 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			if (az6007_xfer_debug)
 				printk(KERN_DEBUG "az6007: I2C W addr=0x%x len=%d\n",
 				       addr, msgs[i].len);
+			if (msgs[i].len < 1) {
+				ret = -EIO;
+				goto err;
+			}
 			req = AZ6007_I2C_WR;
 			index = msgs[i].buf[0];
 			value = addr | (1 << 8);
@@ -810,6 +814,10 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			if (az6007_xfer_debug)
 				printk(KERN_DEBUG "az6007: I2C R addr=0x%x len=%d\n",
 				       addr, msgs[i].len);
+			if (msgs[i].len < 1) {
+				ret = -EIO;
+				goto err;
+			}
 			req = AZ6007_I2C_RD;
 			index = msgs[i].buf[0];
 			value = addr;
diff --git a/drivers/media/usb/dvb-usb/af9005.c b/drivers/media/usb/dvb-usb/af9005.c
index d2737460c9d3..60acaaf8b892 100644
--- a/drivers/media/usb/dvb-usb/af9005.c
+++ b/drivers/media/usb/dvb-usb/af9005.c
@@ -431,6 +431,10 @@ static int af9005_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 		if (ret == 0)
 			ret = 2;
 	} else {
+		if (msg[0].len < 2) {
+			ret = -EOPNOTSUPP;
+			goto unlock;
+		}
 		/* write one or more registers */
 		reg = msg[0].buf[0];
 		addr = msg[0].addr;
@@ -440,6 +444,7 @@ static int af9005_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			ret = 1;
 	}
 
+unlock:
 	mutex_unlock(&d->i2c_mutex);
 	return ret;
 }
diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index cd0566c0b3de..a3c5261f9aa4 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -131,6 +131,10 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 
 	switch (num) {
 	case 2:
+		if (msg[0].len < 1) {
+			num = -EOPNOTSUPP;
+			break;
+		}
 		/* read stv0299 register */
 		value = msg[0].buf[0];/* register */
 		for (i = 0; i < msg[1].len; i++) {
@@ -142,6 +146,10 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 	case 1:
 		switch (msg[0].addr) {
 		case 0x68:
+			if (msg[0].len < 2) {
+				num = -EOPNOTSUPP;
+				break;
+			}
 			/* write to stv0299 register */
 			buf6[0] = 0x2a;
 			buf6[1] = msg[0].buf[0];
@@ -151,6 +159,10 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			break;
 		case 0x60:
 			if (msg[0].flags == 0) {
+				if (msg[0].len < 4) {
+					num = -EOPNOTSUPP;
+					break;
+				}
 			/* write to tuner pll */
 				buf6[0] = 0x2c;
 				buf6[1] = 5;
@@ -162,6 +174,10 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				dw210x_op_rw(d->udev, 0xb2, 0, 0,
 						buf6, 7, DW210X_WRITE_MSG);
 			} else {
+				if (msg[0].len < 1) {
+					num = -EOPNOTSUPP;
+					break;
+				}
 			/* read from tuner */
 				dw210x_op_rw(d->udev, 0xb5, 0, 0,
 						buf6, 1, DW210X_READ_MSG);
@@ -169,12 +185,20 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			}
 			break;
 		case (DW2102_RC_QUERY):
+			if (msg[0].len < 2) {
+				num = -EOPNOTSUPP;
+				break;
+			}
 			dw210x_op_rw(d->udev, 0xb8, 0, 0,
 					buf6, 2, DW210X_READ_MSG);
 			msg[0].buf[0] = buf6[0];
 			msg[0].buf[1] = buf6[1];
 			break;
 		case (DW2102_VOLTAGE_CTRL):
+			if (msg[0].len < 1) {
+				num = -EOPNOTSUPP;
+				break;
+			}
 			buf6[0] = 0x30;
 			buf6[1] = msg[0].buf[0];
 			dw210x_op_rw(d->udev, 0xb2, 0, 0,
diff --git a/drivers/media/usb/dvb-usb/m920x.c b/drivers/media/usb/dvb-usb/m920x.c
index 3b2a0f36fc38..e5491b9b8825 100644
--- a/drivers/media/usb/dvb-usb/m920x.c
+++ b/drivers/media/usb/dvb-usb/m920x.c
@@ -280,7 +280,6 @@ static int m920x_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int nu
 			char *read = kmalloc(1, GFP_KERNEL);
 			if (!read) {
 				ret = -ENOMEM;
-				kfree(read);
 				goto unlock;
 			}
 
@@ -291,8 +290,10 @@ static int m920x_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int nu
 
 				if ((ret = m920x_read(d->udev, M9206_I2C, 0x0,
 						      0x20 | stop,
-						      read, 1)) != 0)
+						      read, 1)) != 0) {
+					kfree(read);
 					goto unlock;
+				}
 				msg[i].buf[j] = read[0];
 			}
 
diff --git a/drivers/media/usb/go7007/go7007-i2c.c b/drivers/media/usb/go7007/go7007-i2c.c
index c084bf794b56..64f25d4e52b2 100644
--- a/drivers/media/usb/go7007/go7007-i2c.c
+++ b/drivers/media/usb/go7007/go7007-i2c.c
@@ -173,8 +173,6 @@ static int go7007_i2c_master_xfer(struct i2c_adapter *adapter,
 		} else if (msgs[i].len == 3) {
 			if (msgs[i].flags & I2C_M_RD)
 				return -EIO;
-			if (msgs[i].len != 3)
-				return -EIO;
 			if (go7007_i2c_xfer(go, msgs[i].addr, 0,
 					(msgs[i].buf[0] << 8) | msgs[i].buf[1],
 					0x01, &msgs[i].buf[2]) < 0)
diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
index cd706874899c..62e4fecc57d9 100644
--- a/drivers/media/usb/siano/smsusb.c
+++ b/drivers/media/usb/siano/smsusb.c
@@ -467,12 +467,7 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
 	rc = smscore_register_device(&params, &dev->coredev, 0, mdev);
 	if (rc < 0) {
 		pr_err("smscore_register_device(...) failed, rc %d\n", rc);
-		smsusb_term_device(intf);
-#ifdef CONFIG_MEDIA_CONTROLLER_DVB
-		media_device_unregister(mdev);
-#endif
-		kfree(mdev);
-		return rc;
+		goto err_unregister_device;
 	}
 
 	smscore_set_board_id(dev->coredev, board_id);
@@ -489,8 +484,7 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
 	rc = smsusb_start_streaming(dev);
 	if (rc < 0) {
 		pr_err("smsusb_start_streaming(...) failed\n");
-		smsusb_term_device(intf);
-		return rc;
+		goto err_unregister_device;
 	}
 
 	dev->state = SMSUSB_ACTIVE;
@@ -498,13 +492,20 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
 	rc = smscore_start_device(dev->coredev);
 	if (rc < 0) {
 		pr_err("smscore_start_device(...) failed\n");
-		smsusb_term_device(intf);
-		return rc;
+		goto err_unregister_device;
 	}
 
 	pr_debug("device 0x%p created\n", dev);
 
 	return rc;
+
+err_unregister_device:
+	smsusb_term_device(intf);
+#ifdef CONFIG_MEDIA_CONTROLLER_DVB
+	media_device_unregister(mdev);
+#endif
+	kfree(mdev);
+	return rc;
 }
 
 static int smsusb_probe(struct usb_interface *intf,
diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 169bdbb1f61a..95079229a772 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -279,37 +279,38 @@ struct v4l2_fwnode_endpoint *v4l2_fwnode_endpoint_alloc_parse(
 }
 EXPORT_SYMBOL_GPL(v4l2_fwnode_endpoint_alloc_parse);
 
-int v4l2_fwnode_parse_link(struct fwnode_handle *__fwnode,
+int v4l2_fwnode_parse_link(struct fwnode_handle *fwnode,
 			   struct v4l2_fwnode_link *link)
 {
-	const char *port_prop = is_of_node(__fwnode) ? "reg" : "port";
-	struct fwnode_handle *fwnode;
+	struct fwnode_endpoint fwep;
 
 	memset(link, 0, sizeof(*link));
 
-	fwnode = fwnode_get_parent(__fwnode);
-	fwnode_property_read_u32(fwnode, port_prop, &link->local_port);
-	fwnode = fwnode_get_next_parent(fwnode);
-	if (is_of_node(fwnode) &&
-	    of_node_cmp(to_of_node(fwnode)->name, "ports") == 0)
-		fwnode = fwnode_get_next_parent(fwnode);
-	link->local_node = fwnode;
-
-	fwnode = fwnode_graph_get_remote_endpoint(__fwnode);
-	if (!fwnode) {
-		fwnode_handle_put(fwnode);
+	fwnode_graph_parse_endpoint(fwnode, &fwep);
+	link->local_port = fwep.port;
+	link->local_node = fwnode_graph_get_port_parent(fwnode);
+	if (!link->local_node)
 		return -ENOLINK;
-	}
 
-	fwnode = fwnode_get_parent(fwnode);
-	fwnode_property_read_u32(fwnode, port_prop, &link->remote_port);
-	fwnode = fwnode_get_next_parent(fwnode);
-	if (is_of_node(fwnode) &&
-	    of_node_cmp(to_of_node(fwnode)->name, "ports") == 0)
-		fwnode = fwnode_get_next_parent(fwnode);
-	link->remote_node = fwnode;
+	fwnode = fwnode_graph_get_remote_endpoint(fwnode);
+	if (!fwnode)
+		goto err_put_local_node;
+
+	fwnode_graph_parse_endpoint(fwnode, &fwep);
+	link->remote_port = fwep.port;
+	link->remote_node = fwnode_graph_get_port_parent(fwnode);
+	if (!link->remote_node)
+		goto err_put_remote_endpoint;
 
 	return 0;
+
+err_put_remote_endpoint:
+	fwnode_handle_put(fwnode);
+
+err_put_local_node:
+	fwnode_handle_put(link->local_node);
+
+	return -ENOLINK;
 }
 EXPORT_SYMBOL_GPL(v4l2_fwnode_parse_link);
 
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 2c11944686cf..d50c9079c036 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -431,11 +431,12 @@ config MMC_WBSD
 	  If unsure, say N.
 
 config MMC_AU1X
-	tristate "Alchemy AU1XX0 MMC Card Interface support"
+	bool "Alchemy AU1XX0 MMC Card Interface support"
 	depends on MIPS_ALCHEMY
+	depends on MMC=y
 	help
 	  This selects the AMD Alchemy(R) Multimedia card interface.
-	  If you have a Alchemy platform with a MMC slot, say Y or M here.
+	  If you have a Alchemy platform with a MMC slot, say Y here.
 
 	  If unsure, say N.
 
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 27bafb8fc35a..0e14892ff926 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -152,6 +152,7 @@ struct brcmnand_controller {
 	unsigned int		max_page_size;
 	const unsigned int	*page_sizes;
 	unsigned int		max_oob;
+	u32			ecc_level_shift;
 	u32			features;
 
 	/* for low-power standby/resume only */
@@ -441,6 +442,34 @@ enum {
 	INTFC_CTLR_READY		= BIT(31),
 };
 
+/***********************************************************************
+ * NAND ACC CONTROL bitfield
+ *
+ * Some bits have remained constant throughout hardware revision, while
+ * others have shifted around.
+ ***********************************************************************/
+
+/* Constant for all versions (where supported) */
+enum {
+	/* See BRCMNAND_HAS_CACHE_MODE */
+	ACC_CONTROL_CACHE_MODE				= BIT(22),
+
+	/* See BRCMNAND_HAS_PREFETCH */
+	ACC_CONTROL_PREFETCH				= BIT(23),
+
+	ACC_CONTROL_PAGE_HIT				= BIT(24),
+	ACC_CONTROL_WR_PREEMPT				= BIT(25),
+	ACC_CONTROL_PARTIAL_PAGE			= BIT(26),
+	ACC_CONTROL_RD_ERASED				= BIT(27),
+	ACC_CONTROL_FAST_PGM_RDIN			= BIT(28),
+	ACC_CONTROL_WR_ECC				= BIT(30),
+	ACC_CONTROL_RD_ECC				= BIT(31),
+};
+
+#define	ACC_CONTROL_ECC_SHIFT			16
+/* Only for v7.2 */
+#define	ACC_CONTROL_ECC_EXT_SHIFT		13
+
 static inline u32 nand_readreg(struct brcmnand_controller *ctrl, u32 offs)
 {
 	return brcmnand_readl(ctrl->nand_base + offs);
@@ -544,6 +573,12 @@ static int brcmnand_revision_init(struct brcmnand_controller *ctrl)
 	else if (of_property_read_bool(ctrl->dev->of_node, "brcm,nand-has-wp"))
 		ctrl->features |= BRCMNAND_HAS_WP;
 
+	/* v7.2 has different ecc level shift in the acc register */
+	if (ctrl->nand_version == 0x0702)
+		ctrl->ecc_level_shift = ACC_CONTROL_ECC_EXT_SHIFT;
+	else
+		ctrl->ecc_level_shift = ACC_CONTROL_ECC_SHIFT;
+
 	return 0;
 }
 
@@ -697,30 +732,6 @@ static inline int brcmnand_cmd_shift(struct brcmnand_controller *ctrl)
 	return 0;
 }
 
-/***********************************************************************
- * NAND ACC CONTROL bitfield
- *
- * Some bits have remained constant throughout hardware revision, while
- * others have shifted around.
- ***********************************************************************/
-
-/* Constant for all versions (where supported) */
-enum {
-	/* See BRCMNAND_HAS_CACHE_MODE */
-	ACC_CONTROL_CACHE_MODE				= BIT(22),
-
-	/* See BRCMNAND_HAS_PREFETCH */
-	ACC_CONTROL_PREFETCH				= BIT(23),
-
-	ACC_CONTROL_PAGE_HIT				= BIT(24),
-	ACC_CONTROL_WR_PREEMPT				= BIT(25),
-	ACC_CONTROL_PARTIAL_PAGE			= BIT(26),
-	ACC_CONTROL_RD_ERASED				= BIT(27),
-	ACC_CONTROL_FAST_PGM_RDIN			= BIT(28),
-	ACC_CONTROL_WR_ECC				= BIT(30),
-	ACC_CONTROL_RD_ECC				= BIT(31),
-};
-
 static inline u32 brcmnand_spare_area_mask(struct brcmnand_controller *ctrl)
 {
 	if (ctrl->nand_version >= 0x0702)
@@ -731,18 +742,15 @@ static inline u32 brcmnand_spare_area_mask(struct brcmnand_controller *ctrl)
 		return GENMASK(5, 0);
 }
 
-#define NAND_ACC_CONTROL_ECC_SHIFT	16
-#define NAND_ACC_CONTROL_ECC_EXT_SHIFT	13
-
 static inline u32 brcmnand_ecc_level_mask(struct brcmnand_controller *ctrl)
 {
 	u32 mask = (ctrl->nand_version >= 0x0600) ? 0x1f : 0x0f;
 
-	mask <<= NAND_ACC_CONTROL_ECC_SHIFT;
+	mask <<= ACC_CONTROL_ECC_SHIFT;
 
 	/* v7.2 includes additional ECC levels */
-	if (ctrl->nand_version >= 0x0702)
-		mask |= 0x7 << NAND_ACC_CONTROL_ECC_EXT_SHIFT;
+	if (ctrl->nand_version == 0x0702)
+		mask |= 0x7 << ACC_CONTROL_ECC_EXT_SHIFT;
 
 	return mask;
 }
@@ -756,8 +764,8 @@ static void brcmnand_set_ecc_enabled(struct brcmnand_host *host, int en)
 
 	if (en) {
 		acc_control |= ecc_flags; /* enable RD/WR ECC */
-		acc_control |= host->hwcfg.ecc_level
-			       << NAND_ACC_CONTROL_ECC_SHIFT;
+		acc_control &= ~brcmnand_ecc_level_mask(ctrl);
+		acc_control |= host->hwcfg.ecc_level << ctrl->ecc_level_shift;
 	} else {
 		acc_control &= ~ecc_flags; /* disable RD/WR ECC */
 		acc_control &= ~brcmnand_ecc_level_mask(ctrl);
@@ -836,6 +844,14 @@ static int bcmnand_ctrl_poll_status(struct brcmnand_controller *ctrl,
 		cpu_relax();
 	} while (time_after(limit, jiffies));
 
+	/*
+	 * do a final check after time out in case the CPU was busy and the driver
+	 * did not get enough time to perform the polling to avoid false alarms
+	 */
+	val = brcmnand_read_reg(ctrl, BRCMNAND_INTFC_STATUS);
+	if ((val & mask) == expected_val)
+		return 0;
+
 	dev_warn(ctrl->dev, "timeout on status poll (expected %x got %x)\n",
 		 expected_val, val & mask);
 
@@ -1213,19 +1229,33 @@ static int write_oob_to_regs(struct brcmnand_controller *ctrl, int i,
 			     const u8 *oob, int sas, int sector_1k)
 {
 	int tbytes = sas << sector_1k;
-	int j;
+	int j, k = 0;
+	u32 last = 0xffffffff;
+	u8 *plast = (u8 *)&last;
 
 	/* Adjust OOB values for 1K sector size */
 	if (sector_1k && (i & 0x01))
 		tbytes = max(0, tbytes - (int)ctrl->max_oob);
 	tbytes = min_t(int, tbytes, ctrl->max_oob);
 
-	for (j = 0; j < tbytes; j += 4)
+	/*
+	 * tbytes may not be multiple of words. Make sure we don't read out of
+	 * the boundary and stop at last word.
+	 */
+	for (j = 0; (j + 3) < tbytes; j += 4)
 		oob_reg_write(ctrl, j,
 				(oob[j + 0] << 24) |
 				(oob[j + 1] << 16) |
 				(oob[j + 2] <<  8) |
 				(oob[j + 3] <<  0));
+
+	/* handle the remaing bytes */
+	while (j < tbytes)
+		plast[k++] = oob[j++];
+
+	if (tbytes & 0x3)
+		oob_reg_write(ctrl, (tbytes & ~0x3), (__force u32)cpu_to_be32(last));
+
 	return tbytes;
 }
 
@@ -1271,7 +1301,17 @@ static void brcmnand_send_cmd(struct brcmnand_host *host, int cmd)
 
 	dev_dbg(ctrl->dev, "send native cmd %d addr 0x%llx\n", cmd, cmd_addr);
 
-	BUG_ON(ctrl->cmd_pending != 0);
+	/*
+	 * If we came here through _panic_write and there is a pending
+	 * command, try to wait for it. If it times out, rather than
+	 * hitting BUG_ON, just return so we don't crash while crashing.
+	 */
+	if (oops_in_progress) {
+		if (ctrl->cmd_pending &&
+			bcmnand_ctrl_poll_status(ctrl, NAND_CTRL_RDY, NAND_CTRL_RDY, 0))
+			return;
+	} else
+		BUG_ON(ctrl->cmd_pending != 0);
 	ctrl->cmd_pending = cmd;
 
 	ret = bcmnand_ctrl_poll_status(ctrl, NAND_CTRL_RDY, NAND_CTRL_RDY, 0);
@@ -2071,9 +2111,10 @@ static int brcmnand_set_cfg(struct brcmnand_host *host,
 
 	tmp = nand_readreg(ctrl, acc_control_offs);
 	tmp &= ~brcmnand_ecc_level_mask(ctrl);
-	tmp |= cfg->ecc_level << NAND_ACC_CONTROL_ECC_SHIFT;
+	tmp |= cfg->ecc_level << ctrl->ecc_level_shift;
 	tmp &= ~brcmnand_spare_area_mask(ctrl);
 	tmp |= cfg->spare_area_size;
+
 	nand_writereg(ctrl, acc_control_offs, tmp);
 
 	brcmnand_set_sector_size_1k(host, cfg->sector_size_1k);
diff --git a/drivers/net/arcnet/arcnet.c b/drivers/net/arcnet/arcnet.c
index 553776cc1d29..2b112d3d8540 100644
--- a/drivers/net/arcnet/arcnet.c
+++ b/drivers/net/arcnet/arcnet.c
@@ -434,7 +434,7 @@ static void arcnet_reply_tasklet(unsigned long data)
 
 	ret = sock_queue_err_skb(sk, ackskb);
 	if (ret)
-		kfree_skb(ackskb);
+		dev_kfree_skb_irq(ackskb);
 
 	local_irq_enable();
 };
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index b2e48c8595f0..fd80af775ec7 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -389,6 +389,9 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 
 	if (hf->flags & GS_CAN_FLAG_OVERFLOW) {
+		stats->rx_over_errors++;
+		stats->rx_errors++;
+
 		skb = alloc_can_err_skb(netdev, &cf);
 		if (!skb)
 			goto resubmit_urb;
@@ -396,8 +399,6 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->can_dlc = CAN_ERR_DLC;
 		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
-		stats->rx_over_errors++;
-		stats->rx_errors++;
 		netif_rx(skb);
 	}
 
diff --git a/drivers/net/ethernet/atheros/alx/ethtool.c b/drivers/net/ethernet/atheros/alx/ethtool.c
index 2f4eabf652e8..51e5aa2c74b3 100644
--- a/drivers/net/ethernet/atheros/alx/ethtool.c
+++ b/drivers/net/ethernet/atheros/alx/ethtool.c
@@ -281,9 +281,8 @@ static void alx_get_ethtool_stats(struct net_device *netdev,
 	spin_lock(&alx->stats_lock);
 
 	alx_update_hw_stats(hw);
-	BUILD_BUG_ON(sizeof(hw->stats) - offsetof(struct alx_hw_stats, rx_ok) <
-		     ALX_NUM_STATS * sizeof(u64));
-	memcpy(data, &hw->stats.rx_ok, ALX_NUM_STATS * sizeof(u64));
+	BUILD_BUG_ON(sizeof(hw->stats) != ALX_NUM_STATS * sizeof(u64));
+	memcpy(data, &hw->stats, sizeof(hw->stats));
 
 	spin_unlock(&alx->stats_lock);
 }
diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index 7087b88550db..98cc2bd5adc4 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -2002,8 +2002,11 @@ static int atl1c_tso_csum(struct atl1c_adapter *adapter,
 			real_len = (((unsigned char *)ip_hdr(skb) - skb->data)
 					+ ntohs(ip_hdr(skb)->tot_len));
 
-			if (real_len < skb->len)
-				pskb_trim(skb, real_len);
+			if (real_len < skb->len) {
+				err = pskb_trim(skb, real_len);
+				if (err)
+					return err;
+			}
 
 			hdr_len = (skb_transport_offset(skb) + tcp_hdrlen(skb));
 			if (unlikely(skb->len == hdr_len)) {
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 91ddde4d647c..d21b22ed0b60 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -14464,11 +14464,16 @@ static void bnx2x_io_resume(struct pci_dev *pdev)
 	bp->fw_seq = SHMEM_RD(bp, func_mb[BP_FW_MB_IDX(bp)].drv_mb_header) &
 							DRV_MSG_SEQ_NUMBER_MASK;
 
-	if (netif_running(dev))
-		bnx2x_nic_load(bp, LOAD_NORMAL);
+	if (netif_running(dev)) {
+		if (bnx2x_nic_load(bp, LOAD_NORMAL)) {
+			netdev_err(bp->dev, "Error during driver initialization, try unloading/reloading the driver\n");
+			goto done;
+		}
+	}
 
 	netif_device_attach(dev);
 
+done:
 	rtnl_unlock();
 }
 
diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 33cbe4f70d59..e6d99759d95a 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -32,11 +32,11 @@ struct igb_adapter;
 /* TX/RX descriptor defines */
 #define IGB_DEFAULT_TXD		256
 #define IGB_DEFAULT_TX_WORK	128
-#define IGB_MIN_TXD		80
+#define IGB_MIN_TXD		64
 #define IGB_MAX_TXD		4096
 
 #define IGB_DEFAULT_RXD		256
-#define IGB_MIN_RXD		80
+#define IGB_MIN_RXD		64
 #define IGB_MAX_RXD		4096
 
 #define IGB_DEFAULT_ITR		3 /* dynamic */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index be5117908985..00d8f1e8177e 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3736,8 +3736,9 @@ static void igb_probe_vfs(struct igb_adapter *adapter)
 	struct pci_dev *pdev = adapter->pdev;
 	struct e1000_hw *hw = &adapter->hw;
 
-	/* Virtualization features not supported on i210 family. */
-	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211))
+	/* Virtualization features not supported on i210 and 82580 family. */
+	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211) ||
+	    (hw->mac.type == e1000_82580))
 		return;
 
 	/* Of the below we really only want the effect of getting
@@ -4579,6 +4580,10 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
 static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
 				  struct igb_ring *rx_ring)
 {
+#if (PAGE_SIZE < 8192)
+	struct e1000_hw *hw = &adapter->hw;
+#endif
+
 	/* set build_skb and buffer size flags */
 	clear_ring_build_skb_enabled(rx_ring);
 	clear_ring_uses_large_buffer(rx_ring);
@@ -4589,10 +4594,9 @@ static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
 	set_ring_build_skb_enabled(rx_ring);
 
 #if (PAGE_SIZE < 8192)
-	if (adapter->max_frame_size <= IGB_MAX_FRAME_BUILD_SKB)
-		return;
-
-	set_ring_uses_large_buffer(rx_ring);
+	if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
+	    rd32(E1000_RCTL) & E1000_RCTL_SBP)
+		set_ring_uses_large_buffer(rx_ring);
 #endif
 }
 
diff --git a/drivers/net/ethernet/intel/igbvf/igbvf.h b/drivers/net/ethernet/intel/igbvf/igbvf.h
index eee26a3be90b..52545cb25d05 100644
--- a/drivers/net/ethernet/intel/igbvf/igbvf.h
+++ b/drivers/net/ethernet/intel/igbvf/igbvf.h
@@ -39,11 +39,11 @@ enum latency_range {
 /* Tx/Rx descriptor defines */
 #define IGBVF_DEFAULT_TXD	256
 #define IGBVF_MAX_TXD		4096
-#define IGBVF_MIN_TXD		80
+#define IGBVF_MIN_TXD		64
 
 #define IGBVF_DEFAULT_RXD	256
 #define IGBVF_MAX_RXD		4096
-#define IGBVF_MIN_RXD		80
+#define IGBVF_MIN_RXD		64
 
 #define IGBVF_MIN_ITR_USECS	10 /* 100000 irq/sec */
 #define IGBVF_MAX_ITR_USECS	10000 /* 100    irq/sec */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index eec68cc9288c..9c0e0ccbbe3c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -844,6 +844,7 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 	u32 tsync_tx_ctl = IXGBE_TSYNCTXCTL_ENABLED;
 	u32 tsync_rx_ctl = IXGBE_TSYNCRXCTL_ENABLED;
 	u32 tsync_rx_mtrl = PTP_EV_PORT << 16;
+	u32 aflags = adapter->flags;
 	bool is_l2 = false;
 	u32 regval;
 
@@ -864,20 +865,20 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 	case HWTSTAMP_FILTER_NONE:
 		tsync_rx_ctl = 0;
 		tsync_rx_mtrl = 0;
-		adapter->flags &= ~(IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
-				    IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
+		aflags &= ~(IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
+			    IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
 		tsync_rx_ctl |= IXGBE_TSYNCRXCTL_TYPE_L4_V1;
 		tsync_rx_mtrl |= IXGBE_RXMTRL_V1_SYNC_MSG;
-		adapter->flags |= (IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
-				   IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
+		aflags |= (IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
+			   IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
 		tsync_rx_ctl |= IXGBE_TSYNCRXCTL_TYPE_L4_V1;
 		tsync_rx_mtrl |= IXGBE_RXMTRL_V1_DELAY_REQ_MSG;
-		adapter->flags |= (IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
-				   IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
+		aflags |= (IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
+			   IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
 		break;
 	case HWTSTAMP_FILTER_PTP_V2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
@@ -891,8 +892,8 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 		tsync_rx_ctl |= IXGBE_TSYNCRXCTL_TYPE_EVENT_V2;
 		is_l2 = true;
 		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
-		adapter->flags |= (IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
-				   IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
+		aflags |= (IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
+			   IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 	case HWTSTAMP_FILTER_NTP_ALL:
@@ -903,7 +904,7 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 		if (hw->mac.type >= ixgbe_mac_X550) {
 			tsync_rx_ctl |= IXGBE_TSYNCRXCTL_TYPE_ALL;
 			config->rx_filter = HWTSTAMP_FILTER_ALL;
-			adapter->flags |= IXGBE_FLAG_RX_HWTSTAMP_ENABLED;
+			aflags |= IXGBE_FLAG_RX_HWTSTAMP_ENABLED;
 			break;
 		}
 		/* fall through */
@@ -914,8 +915,6 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 		 * Delay_Req messages and hardware does not support
 		 * timestamping all packets => return error
 		 */
-		adapter->flags &= ~(IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
-				    IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
 		config->rx_filter = HWTSTAMP_FILTER_NONE;
 		return -ERANGE;
 	}
@@ -947,8 +946,8 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 			       IXGBE_TSYNCRXCTL_TYPE_ALL |
 			       IXGBE_TSYNCRXCTL_TSIP_UT_EN;
 		config->rx_filter = HWTSTAMP_FILTER_ALL;
-		adapter->flags |= IXGBE_FLAG_RX_HWTSTAMP_ENABLED;
-		adapter->flags &= ~IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER;
+		aflags |= IXGBE_FLAG_RX_HWTSTAMP_ENABLED;
+		aflags &= ~IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER;
 		is_l2 = true;
 		break;
 	default:
@@ -981,6 +980,9 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 
 	IXGBE_WRITE_FLUSH(hw);
 
+	/* configure adapter flags only when HW is actually configured */
+	adapter->flags = aflags;
+
 	/* clear TX/RX time stamp registers, just to be sure */
 	ixgbe_ptp_clear_tx_timestamp(adapter);
 	IXGBE_READ_REG(hw, IXGBE_RXSTMPH);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 53cff913abf0..1a4f96894cd7 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1621,6 +1621,9 @@ static int mtk_hwlro_get_fdir_all(struct net_device *dev,
 	int i;
 
 	for (i = 0; i < MTK_MAX_LRO_IP_CNT; i++) {
+		if (cnt == cmd->rule_cnt)
+			return -EMSGSIZE;
+
 		if (mac->hwlro_ip[i]) {
 			rule_locs[cnt] = i;
 			cnt++;
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 6c0f80bea816..a913ba87209a 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1315,8 +1315,7 @@ static struct crypto_aead *macsec_alloc_tfm(char *key, int key_len, int icv_len)
 	struct crypto_aead *tfm;
 	int ret;
 
-	/* Pick a sync gcm(aes) cipher to ensure order is preserved. */
-	tfm = crypto_alloc_aead("gcm(aes)", 0, CRYPTO_ALG_ASYNC);
+	tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
 
 	if (IS_ERR(tfm))
 		return tfm;
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index c5781888f2f7..aefa57e72695 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1376,6 +1376,7 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0191, 4)},	/* Quectel EG91 */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0195, 4)},	/* Quectel EG95 */
 	{QMI_FIXED_INTF(0x2c7c, 0x0296, 4)},	/* Quectel BG96 */
+	{QMI_QUIRK_SET_DTR(0x2c7c, 0x030e, 4)},	/* Quectel EM05GV2 */
 	{QMI_QUIRK_SET_DTR(0x2cb7, 0x0104, 4)},	/* Fibocom NL678 series */
 	{QMI_FIXED_INTF(0x0489, 0xe0b4, 0)},	/* Foxconn T77W968 LTE */
 	{QMI_FIXED_INTF(0x0489, 0xe0b5, 0)},	/* Foxconn T77W968 LTE with eSIM support*/
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index ea999a663933..8006a7716168 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -181,6 +181,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
 	struct veth_rq *rq = NULL;
+	int ret = NETDEV_TX_OK;
 	struct net_device *rcv;
 	int length = skb->len;
 	bool rcv_xdp = false;
@@ -210,6 +211,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 	} else {
 drop:
 		atomic64_inc(&priv->dropped);
+		ret = NET_XMIT_DROP;
 	}
 
 	if (rcv_xdp)
@@ -217,7 +219,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	rcu_read_unlock();
 
-	return NETDEV_TX_OK;
+	return ret;
 }
 
 static u64 veth_stats_one(struct pcpu_vstats *result, struct net_device *dev)
diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 1b98a888a168..d5c8d0d54b33 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -542,6 +542,32 @@ static int vxlan_fdb_append(struct vxlan_fdb *f,
 	return 1;
 }
 
+static bool vxlan_parse_gpe_proto(struct vxlanhdr *hdr, __be16 *protocol)
+{
+	struct vxlanhdr_gpe *gpe = (struct vxlanhdr_gpe *)hdr;
+
+	/* Need to have Next Protocol set for interfaces in GPE mode. */
+	if (!gpe->np_applied)
+		return false;
+	/* "The initial version is 0. If a receiver does not support the
+	 * version indicated it MUST drop the packet.
+	 */
+	if (gpe->version != 0)
+		return false;
+	/* "When the O bit is set to 1, the packet is an OAM packet and OAM
+	 * processing MUST occur." However, we don't implement OAM
+	 * processing, thus drop the packet.
+	 */
+	if (gpe->oam_flag)
+		return false;
+
+	*protocol = tun_p_to_eth_p(gpe->next_protocol);
+	if (!*protocol)
+		return false;
+
+	return true;
+}
+
 static struct vxlanhdr *vxlan_gro_remcsum(struct sk_buff *skb,
 					  unsigned int off,
 					  struct vxlanhdr *vh, size_t hdrlen,
@@ -1279,35 +1305,6 @@ static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
 	unparsed->vx_flags &= ~VXLAN_GBP_USED_BITS;
 }
 
-static bool vxlan_parse_gpe_hdr(struct vxlanhdr *unparsed,
-				__be16 *protocol,
-				struct sk_buff *skb, u32 vxflags)
-{
-	struct vxlanhdr_gpe *gpe = (struct vxlanhdr_gpe *)unparsed;
-
-	/* Need to have Next Protocol set for interfaces in GPE mode. */
-	if (!gpe->np_applied)
-		return false;
-	/* "The initial version is 0. If a receiver does not support the
-	 * version indicated it MUST drop the packet.
-	 */
-	if (gpe->version != 0)
-		return false;
-	/* "When the O bit is set to 1, the packet is an OAM packet and OAM
-	 * processing MUST occur." However, we don't implement OAM
-	 * processing, thus drop the packet.
-	 */
-	if (gpe->oam_flag)
-		return false;
-
-	*protocol = tun_p_to_eth_p(gpe->next_protocol);
-	if (!*protocol)
-		return false;
-
-	unparsed->vx_flags &= ~VXLAN_GPE_USED_BITS;
-	return true;
-}
-
 static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 			  struct vxlan_sock *vs,
 			  struct sk_buff *skb, __be32 vni)
@@ -1409,8 +1406,9 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	 * used by VXLAN extensions if explicitly requested.
 	 */
 	if (vs->flags & VXLAN_F_GPE) {
-		if (!vxlan_parse_gpe_hdr(&unparsed, &protocol, skb, vs->flags))
+		if (!vxlan_parse_gpe_proto(&unparsed, &protocol))
 			goto drop;
+		unparsed.vx_flags &= ~VXLAN_GPE_USED_BITS;
 		raw_proto = true;
 	}
 
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 92757495c73b..c929a62c722a 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -1957,8 +1957,9 @@ static int ath10k_pci_hif_start(struct ath10k *ar)
 	ath10k_pci_irq_enable(ar);
 	ath10k_pci_rx_post(ar);
 
-	pcie_capability_write_word(ar_pci->pdev, PCI_EXP_LNKCTL,
-				   ar_pci->link_ctl);
+	pcie_capability_clear_and_set_word(ar_pci->pdev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC,
+					   ar_pci->link_ctl & PCI_EXP_LNKCTL_ASPMC);
 
 	return 0;
 }
@@ -2813,8 +2814,8 @@ static int ath10k_pci_hif_power_up(struct ath10k *ar)
 
 	pcie_capability_read_word(ar_pci->pdev, PCI_EXP_LNKCTL,
 				  &ar_pci->link_ctl);
-	pcie_capability_write_word(ar_pci->pdev, PCI_EXP_LNKCTL,
-				   ar_pci->link_ctl & ~PCI_EXP_LNKCTL_ASPMC);
+	pcie_capability_clear_word(ar_pci->pdev, PCI_EXP_LNKCTL,
+				   PCI_EXP_LNKCTL_ASPMC);
 
 	/*
 	 * Bring the target up cleanly.
diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index 63019c3de034..26023e3b4b9d 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -136,8 +136,8 @@ static int ath_ahb_probe(struct platform_device *pdev)
 
 	ah = sc->sc_ah;
 	ath9k_hw_name(ah, hw_name, sizeof(hw_name));
-	wiphy_info(hw->wiphy, "%s mem=0x%lx, irq=%d\n",
-		   hw_name, (unsigned long)mem, irq);
+	wiphy_info(hw->wiphy, "%s mem=0x%p, irq=%d\n",
+		   hw_name, mem, irq);
 
 	return 0;
 
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
index b3ed65e5c4da..c55aab01fff5 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
@@ -491,7 +491,7 @@ int ath9k_htc_init_debug(struct ath_hw *ah)
 
 	priv->debug.debugfs_phy = debugfs_create_dir(KBUILD_MODNAME,
 					     priv->hw->wiphy->debugfsdir);
-	if (!priv->debug.debugfs_phy)
+	if (IS_ERR(priv->debug.debugfs_phy))
 		return -ENOMEM;
 
 	ath9k_cmn_spectral_init_debug(&priv->spec_priv, priv->debug.debugfs_phy);
diff --git a/drivers/net/wireless/ath/ath9k/pci.c b/drivers/net/wireless/ath/ath9k/pci.c
index 92b2dd396436..cb3318bd3cad 100644
--- a/drivers/net/wireless/ath/ath9k/pci.c
+++ b/drivers/net/wireless/ath/ath9k/pci.c
@@ -993,8 +993,8 @@ static int ath_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	sc->sc_ah->msi_reg = 0;
 
 	ath9k_hw_name(sc->sc_ah, hw_name, sizeof(hw_name));
-	wiphy_info(hw->wiphy, "%s mem=0x%lx, irq=%d\n",
-		   hw_name, (unsigned long)sc->mem, pdev->irq);
+	wiphy_info(hw->wiphy, "%s mem=0x%p, irq=%d\n",
+		   hw_name, sc->mem, pdev->irq);
 
 	return 0;
 
diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index 5e2a610df61c..78ce349a48f7 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -239,10 +239,10 @@ static void ath9k_wmi_ctrl_rx(void *priv, struct sk_buff *skb,
 		spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 		goto free_skb;
 	}
-	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
 	/* WMI command response */
 	ath9k_wmi_rsp_callback(wmi, skb);
+	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
 free_skb:
 	kfree_skb(skb);
@@ -280,7 +280,8 @@ int ath9k_wmi_connect(struct htc_target *htc, struct wmi *wmi,
 
 static int ath9k_wmi_cmd_issue(struct wmi *wmi,
 			       struct sk_buff *skb,
-			       enum wmi_cmd_id cmd, u16 len)
+			       enum wmi_cmd_id cmd, u16 len,
+			       u8 *rsp_buf, u32 rsp_len)
 {
 	struct wmi_cmd_hdr *hdr;
 	unsigned long flags;
@@ -290,6 +291,11 @@ static int ath9k_wmi_cmd_issue(struct wmi *wmi,
 	hdr->seq_no = cpu_to_be16(++wmi->tx_seq_id);
 
 	spin_lock_irqsave(&wmi->wmi_lock, flags);
+
+	/* record the rsp buffer and length */
+	wmi->cmd_rsp_buf = rsp_buf;
+	wmi->cmd_rsp_len = rsp_len;
+
 	wmi->last_seq_id = wmi->tx_seq_id;
 	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
@@ -305,8 +311,8 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
 	struct ath_common *common = ath9k_hw_common(ah);
 	u16 headroom = sizeof(struct htc_frame_hdr) +
 		       sizeof(struct wmi_cmd_hdr);
+	unsigned long time_left, flags;
 	struct sk_buff *skb;
-	unsigned long time_left;
 	int ret = 0;
 
 	if (ah->ah_flags & AH_UNPLUGGED)
@@ -330,11 +336,7 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
 		goto out;
 	}
 
-	/* record the rsp buffer and length */
-	wmi->cmd_rsp_buf = rsp_buf;
-	wmi->cmd_rsp_len = rsp_len;
-
-	ret = ath9k_wmi_cmd_issue(wmi, skb, cmd_id, cmd_len);
+	ret = ath9k_wmi_cmd_issue(wmi, skb, cmd_id, cmd_len, rsp_buf, rsp_len);
 	if (ret)
 		goto out;
 
@@ -342,7 +344,9 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
 	if (!time_left) {
 		ath_dbg(common, WMI, "Timeout waiting for WMI command: %s\n",
 			wmi_cmd_to_name(cmd_id));
+		spin_lock_irqsave(&wmi->wmi_lock, flags);
 		wmi->last_seq_id = 0;
+		spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 		mutex_unlock(&wmi->op_mutex);
 		kfree_skb(skb);
 		return -ETIMEDOUT;
diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c b/drivers/net/wireless/marvell/mwifiex/debugfs.c
index cbe4493b3266..0f62da50e11a 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -265,8 +265,11 @@ mwifiex_histogram_read(struct file *file, char __user *ubuf,
 	if (!p)
 		return -ENOMEM;
 
-	if (!priv || !priv->hist_data)
-		return -EFAULT;
+	if (!priv || !priv->hist_data) {
+		ret = -EFAULT;
+		goto free_and_exit;
+	}
+
 	phist_data = priv->hist_data;
 
 	p += sprintf(p, "\n"
@@ -321,6 +324,8 @@ mwifiex_histogram_read(struct file *file, char __user *ubuf,
 	ret = simple_read_from_buffer(ubuf, count, ppos, (char *)page,
 				      (unsigned long)p - page);
 
+free_and_exit:
+	free_page(page);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index aea79fd54c31..7e9111965b23 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -50,6 +50,8 @@ static int mwifiex_pcie_probe_of(struct device *dev)
 }
 
 static void mwifiex_pcie_work(struct work_struct *work);
+static int mwifiex_pcie_delete_rxbd_ring(struct mwifiex_adapter *adapter);
+static int mwifiex_pcie_delete_evtbd_ring(struct mwifiex_adapter *adapter);
 
 static int
 mwifiex_map_pci_memory(struct mwifiex_adapter *adapter, struct sk_buff *skb,
@@ -58,8 +60,8 @@ mwifiex_map_pci_memory(struct mwifiex_adapter *adapter, struct sk_buff *skb,
 	struct pcie_service_card *card = adapter->card;
 	struct mwifiex_dma_mapping mapping;
 
-	mapping.addr = pci_map_single(card->dev, skb->data, size, flags);
-	if (pci_dma_mapping_error(card->dev, mapping.addr)) {
+	mapping.addr = dma_map_single(&card->dev->dev, skb->data, size, flags);
+	if (dma_mapping_error(&card->dev->dev, mapping.addr)) {
 		mwifiex_dbg(adapter, ERROR, "failed to map pci memory!\n");
 		return -1;
 	}
@@ -75,7 +77,7 @@ static void mwifiex_unmap_pci_memory(struct mwifiex_adapter *adapter,
 	struct mwifiex_dma_mapping mapping;
 
 	mwifiex_get_mapping(skb, &mapping);
-	pci_unmap_single(card->dev, mapping.addr, mapping.len, flags);
+	dma_unmap_single(&card->dev->dev, mapping.addr, mapping.len, flags);
 }
 
 /*
@@ -469,10 +471,9 @@ static void mwifiex_delay_for_sleep_cookie(struct mwifiex_adapter *adapter,
 	struct sk_buff *cmdrsp = card->cmdrsp_buf;
 
 	for (count = 0; count < max_delay_loop_cnt; count++) {
-		pci_dma_sync_single_for_cpu(card->dev,
-					    MWIFIEX_SKB_DMA_ADDR(cmdrsp),
-					    sizeof(sleep_cookie),
-					    PCI_DMA_FROMDEVICE);
+		dma_sync_single_for_cpu(&card->dev->dev,
+					MWIFIEX_SKB_DMA_ADDR(cmdrsp),
+					sizeof(sleep_cookie), DMA_FROM_DEVICE);
 		buffer = cmdrsp->data;
 		sleep_cookie = get_unaligned_le32(buffer);
 
@@ -481,10 +482,10 @@ static void mwifiex_delay_for_sleep_cookie(struct mwifiex_adapter *adapter,
 				    "sleep cookie found at count %d\n", count);
 			break;
 		}
-		pci_dma_sync_single_for_device(card->dev,
-					       MWIFIEX_SKB_DMA_ADDR(cmdrsp),
-					       sizeof(sleep_cookie),
-					       PCI_DMA_FROMDEVICE);
+		dma_sync_single_for_device(&card->dev->dev,
+					   MWIFIEX_SKB_DMA_ADDR(cmdrsp),
+					   sizeof(sleep_cookie),
+					   DMA_FROM_DEVICE);
 		usleep_range(20, 30);
 	}
 
@@ -632,14 +633,15 @@ static int mwifiex_init_rxq_ring(struct mwifiex_adapter *adapter)
 		if (!skb) {
 			mwifiex_dbg(adapter, ERROR,
 				    "Unable to allocate skb for RX ring.\n");
-			kfree(card->rxbd_ring_vbase);
 			return -ENOMEM;
 		}
 
 		if (mwifiex_map_pci_memory(adapter, skb,
 					   MWIFIEX_RX_DATA_BUF_SIZE,
-					   PCI_DMA_FROMDEVICE))
-			return -1;
+					   DMA_FROM_DEVICE)) {
+			kfree_skb(skb);
+			return -ENOMEM;
+		}
 
 		buf_pa = MWIFIEX_SKB_DMA_ADDR(skb);
 
@@ -689,16 +691,14 @@ static int mwifiex_pcie_init_evt_ring(struct mwifiex_adapter *adapter)
 		if (!skb) {
 			mwifiex_dbg(adapter, ERROR,
 				    "Unable to allocate skb for EVENT buf.\n");
-			kfree(card->evtbd_ring_vbase);
 			return -ENOMEM;
 		}
 		skb_put(skb, MAX_EVENT_SIZE);
 
 		if (mwifiex_map_pci_memory(adapter, skb, MAX_EVENT_SIZE,
-					   PCI_DMA_FROMDEVICE)) {
+					   DMA_FROM_DEVICE)) {
 			kfree_skb(skb);
-			kfree(card->evtbd_ring_vbase);
-			return -1;
+			return -ENOMEM;
 		}
 
 		buf_pa = MWIFIEX_SKB_DMA_ADDR(skb);
@@ -738,7 +738,7 @@ static void mwifiex_cleanup_txq_ring(struct mwifiex_adapter *adapter)
 			if (card->tx_buf_list[i]) {
 				skb = card->tx_buf_list[i];
 				mwifiex_unmap_pci_memory(adapter, skb,
-							 PCI_DMA_TODEVICE);
+							 DMA_TO_DEVICE);
 				dev_kfree_skb_any(skb);
 			}
 			memset(desc2, 0, sizeof(*desc2));
@@ -747,7 +747,7 @@ static void mwifiex_cleanup_txq_ring(struct mwifiex_adapter *adapter)
 			if (card->tx_buf_list[i]) {
 				skb = card->tx_buf_list[i];
 				mwifiex_unmap_pci_memory(adapter, skb,
-							 PCI_DMA_TODEVICE);
+							 DMA_TO_DEVICE);
 				dev_kfree_skb_any(skb);
 			}
 			memset(desc, 0, sizeof(*desc));
@@ -777,7 +777,7 @@ static void mwifiex_cleanup_rxq_ring(struct mwifiex_adapter *adapter)
 			if (card->rx_buf_list[i]) {
 				skb = card->rx_buf_list[i];
 				mwifiex_unmap_pci_memory(adapter, skb,
-							 PCI_DMA_FROMDEVICE);
+							 DMA_FROM_DEVICE);
 				dev_kfree_skb_any(skb);
 			}
 			memset(desc2, 0, sizeof(*desc2));
@@ -786,7 +786,7 @@ static void mwifiex_cleanup_rxq_ring(struct mwifiex_adapter *adapter)
 			if (card->rx_buf_list[i]) {
 				skb = card->rx_buf_list[i];
 				mwifiex_unmap_pci_memory(adapter, skb,
-							 PCI_DMA_FROMDEVICE);
+							 DMA_FROM_DEVICE);
 				dev_kfree_skb_any(skb);
 			}
 			memset(desc, 0, sizeof(*desc));
@@ -812,7 +812,7 @@ static void mwifiex_cleanup_evt_ring(struct mwifiex_adapter *adapter)
 		if (card->evt_buf_list[i]) {
 			skb = card->evt_buf_list[i];
 			mwifiex_unmap_pci_memory(adapter, skb,
-						 PCI_DMA_FROMDEVICE);
+						 DMA_FROM_DEVICE);
 			dev_kfree_skb_any(skb);
 		}
 		card->evt_buf_list[i] = NULL;
@@ -853,9 +853,10 @@ static int mwifiex_pcie_create_txbd_ring(struct mwifiex_adapter *adapter)
 	mwifiex_dbg(adapter, INFO,
 		    "info: txbd_ring: Allocating %d bytes\n",
 		    card->txbd_ring_size);
-	card->txbd_ring_vbase = pci_alloc_consistent(card->dev,
-						     card->txbd_ring_size,
-						     &card->txbd_ring_pbase);
+	card->txbd_ring_vbase = dma_alloc_coherent(&card->dev->dev,
+						   card->txbd_ring_size,
+						   &card->txbd_ring_pbase,
+						   GFP_KERNEL);
 	if (!card->txbd_ring_vbase) {
 		mwifiex_dbg(adapter, ERROR,
 			    "allocate consistent memory (%d bytes) failed!\n",
@@ -879,9 +880,9 @@ static int mwifiex_pcie_delete_txbd_ring(struct mwifiex_adapter *adapter)
 	mwifiex_cleanup_txq_ring(adapter);
 
 	if (card->txbd_ring_vbase)
-		pci_free_consistent(card->dev, card->txbd_ring_size,
-				    card->txbd_ring_vbase,
-				    card->txbd_ring_pbase);
+		dma_free_coherent(&card->dev->dev, card->txbd_ring_size,
+				  card->txbd_ring_vbase,
+				  card->txbd_ring_pbase);
 	card->txbd_ring_size = 0;
 	card->txbd_wrptr = 0;
 	card->txbd_rdptr = 0 | reg->tx_rollover_ind;
@@ -896,6 +897,7 @@ static int mwifiex_pcie_delete_txbd_ring(struct mwifiex_adapter *adapter)
  */
 static int mwifiex_pcie_create_rxbd_ring(struct mwifiex_adapter *adapter)
 {
+	int ret;
 	struct pcie_service_card *card = adapter->card;
 	const struct mwifiex_pcie_card_reg *reg = card->pcie.reg;
 
@@ -917,9 +919,10 @@ static int mwifiex_pcie_create_rxbd_ring(struct mwifiex_adapter *adapter)
 	mwifiex_dbg(adapter, INFO,
 		    "info: rxbd_ring: Allocating %d bytes\n",
 		    card->rxbd_ring_size);
-	card->rxbd_ring_vbase = pci_alloc_consistent(card->dev,
-						     card->rxbd_ring_size,
-						     &card->rxbd_ring_pbase);
+	card->rxbd_ring_vbase = dma_alloc_coherent(&card->dev->dev,
+						   card->rxbd_ring_size,
+						   &card->rxbd_ring_pbase,
+						   GFP_KERNEL);
 	if (!card->rxbd_ring_vbase) {
 		mwifiex_dbg(adapter, ERROR,
 			    "allocate consistent memory (%d bytes) failed!\n",
@@ -933,7 +936,10 @@ static int mwifiex_pcie_create_rxbd_ring(struct mwifiex_adapter *adapter)
 		    (u32)((u64)card->rxbd_ring_pbase >> 32),
 		    card->rxbd_ring_size);
 
-	return mwifiex_init_rxq_ring(adapter);
+	ret = mwifiex_init_rxq_ring(adapter);
+	if (ret)
+		mwifiex_pcie_delete_rxbd_ring(adapter);
+	return ret;
 }
 
 /*
@@ -947,9 +953,9 @@ static int mwifiex_pcie_delete_rxbd_ring(struct mwifiex_adapter *adapter)
 	mwifiex_cleanup_rxq_ring(adapter);
 
 	if (card->rxbd_ring_vbase)
-		pci_free_consistent(card->dev, card->rxbd_ring_size,
-				    card->rxbd_ring_vbase,
-				    card->rxbd_ring_pbase);
+		dma_free_coherent(&card->dev->dev, card->rxbd_ring_size,
+				  card->rxbd_ring_vbase,
+				  card->rxbd_ring_pbase);
 	card->rxbd_ring_size = 0;
 	card->rxbd_wrptr = 0;
 	card->rxbd_rdptr = 0 | reg->rx_rollover_ind;
@@ -964,6 +970,7 @@ static int mwifiex_pcie_delete_rxbd_ring(struct mwifiex_adapter *adapter)
  */
 static int mwifiex_pcie_create_evtbd_ring(struct mwifiex_adapter *adapter)
 {
+	int ret;
 	struct pcie_service_card *card = adapter->card;
 	const struct mwifiex_pcie_card_reg *reg = card->pcie.reg;
 
@@ -981,9 +988,10 @@ static int mwifiex_pcie_create_evtbd_ring(struct mwifiex_adapter *adapter)
 	mwifiex_dbg(adapter, INFO,
 		    "info: evtbd_ring: Allocating %d bytes\n",
 		card->evtbd_ring_size);
-	card->evtbd_ring_vbase = pci_alloc_consistent(card->dev,
-						      card->evtbd_ring_size,
-						      &card->evtbd_ring_pbase);
+	card->evtbd_ring_vbase = dma_alloc_coherent(&card->dev->dev,
+						    card->evtbd_ring_size,
+						    &card->evtbd_ring_pbase,
+						    GFP_KERNEL);
 	if (!card->evtbd_ring_vbase) {
 		mwifiex_dbg(adapter, ERROR,
 			    "allocate consistent memory (%d bytes) failed!\n",
@@ -997,7 +1005,10 @@ static int mwifiex_pcie_create_evtbd_ring(struct mwifiex_adapter *adapter)
 		    (u32)((u64)card->evtbd_ring_pbase >> 32),
 		    card->evtbd_ring_size);
 
-	return mwifiex_pcie_init_evt_ring(adapter);
+	ret = mwifiex_pcie_init_evt_ring(adapter);
+	if (ret)
+		mwifiex_pcie_delete_evtbd_ring(adapter);
+	return ret;
 }
 
 /*
@@ -1011,9 +1022,9 @@ static int mwifiex_pcie_delete_evtbd_ring(struct mwifiex_adapter *adapter)
 	mwifiex_cleanup_evt_ring(adapter);
 
 	if (card->evtbd_ring_vbase)
-		pci_free_consistent(card->dev, card->evtbd_ring_size,
-				    card->evtbd_ring_vbase,
-				    card->evtbd_ring_pbase);
+		dma_free_coherent(&card->dev->dev, card->evtbd_ring_size,
+				  card->evtbd_ring_vbase,
+				  card->evtbd_ring_pbase);
 	card->evtbd_wrptr = 0;
 	card->evtbd_rdptr = 0 | reg->evt_rollover_ind;
 	card->evtbd_ring_size = 0;
@@ -1040,7 +1051,7 @@ static int mwifiex_pcie_alloc_cmdrsp_buf(struct mwifiex_adapter *adapter)
 	}
 	skb_put(skb, MWIFIEX_UPLD_SIZE);
 	if (mwifiex_map_pci_memory(adapter, skb, MWIFIEX_UPLD_SIZE,
-				   PCI_DMA_FROMDEVICE)) {
+				   DMA_FROM_DEVICE)) {
 		kfree_skb(skb);
 		return -1;
 	}
@@ -1064,14 +1075,14 @@ static int mwifiex_pcie_delete_cmdrsp_buf(struct mwifiex_adapter *adapter)
 
 	if (card && card->cmdrsp_buf) {
 		mwifiex_unmap_pci_memory(adapter, card->cmdrsp_buf,
-					 PCI_DMA_FROMDEVICE);
+					 DMA_FROM_DEVICE);
 		dev_kfree_skb_any(card->cmdrsp_buf);
 		card->cmdrsp_buf = NULL;
 	}
 
 	if (card && card->cmd_buf) {
 		mwifiex_unmap_pci_memory(adapter, card->cmd_buf,
-					 PCI_DMA_TODEVICE);
+					 DMA_TO_DEVICE);
 		dev_kfree_skb_any(card->cmd_buf);
 		card->cmd_buf = NULL;
 	}
@@ -1086,8 +1097,10 @@ static int mwifiex_pcie_alloc_sleep_cookie_buf(struct mwifiex_adapter *adapter)
 	struct pcie_service_card *card = adapter->card;
 	u32 *cookie;
 
-	card->sleep_cookie_vbase = pci_alloc_consistent(card->dev, sizeof(u32),
-						     &card->sleep_cookie_pbase);
+	card->sleep_cookie_vbase = dma_alloc_coherent(&card->dev->dev,
+						      sizeof(u32),
+						      &card->sleep_cookie_pbase,
+						      GFP_KERNEL);
 	if (!card->sleep_cookie_vbase) {
 		mwifiex_dbg(adapter, ERROR,
 			    "pci_alloc_consistent failed!\n");
@@ -1115,9 +1128,9 @@ static int mwifiex_pcie_delete_sleep_cookie_buf(struct mwifiex_adapter *adapter)
 	card = adapter->card;
 
 	if (card && card->sleep_cookie_vbase) {
-		pci_free_consistent(card->dev, sizeof(u32),
-				    card->sleep_cookie_vbase,
-				    card->sleep_cookie_pbase);
+		dma_free_coherent(&card->dev->dev, sizeof(u32),
+				  card->sleep_cookie_vbase,
+				  card->sleep_cookie_pbase);
 		card->sleep_cookie_vbase = NULL;
 	}
 
@@ -1189,7 +1202,7 @@ static int mwifiex_pcie_send_data_complete(struct mwifiex_adapter *adapter)
 				    "SEND COMP: Detach skb %p at txbd_rdidx=%d\n",
 				    skb, wrdoneidx);
 			mwifiex_unmap_pci_memory(adapter, skb,
-						 PCI_DMA_TODEVICE);
+						 DMA_TO_DEVICE);
 
 			unmap_count++;
 
@@ -1282,7 +1295,7 @@ mwifiex_pcie_send_data(struct mwifiex_adapter *adapter, struct sk_buff *skb,
 		put_unaligned_le16(MWIFIEX_TYPE_DATA, payload + 2);
 
 		if (mwifiex_map_pci_memory(adapter, skb, skb->len,
-					   PCI_DMA_TODEVICE))
+					   DMA_TO_DEVICE))
 			return -1;
 
 		wrindx = (card->txbd_wrptr & reg->tx_mask) >> reg->tx_start_ptr;
@@ -1372,7 +1385,7 @@ mwifiex_pcie_send_data(struct mwifiex_adapter *adapter, struct sk_buff *skb,
 
 	return -EINPROGRESS;
 done_unmap:
-	mwifiex_unmap_pci_memory(adapter, skb, PCI_DMA_TODEVICE);
+	mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
 	card->tx_buf_list[wrindx] = NULL;
 	atomic_dec(&adapter->tx_hw_pending);
 	if (reg->pfu_enabled)
@@ -1426,7 +1439,7 @@ static int mwifiex_pcie_process_recv_data(struct mwifiex_adapter *adapter)
 		if (!skb_data)
 			return -ENOMEM;
 
-		mwifiex_unmap_pci_memory(adapter, skb_data, PCI_DMA_FROMDEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb_data, DMA_FROM_DEVICE);
 		card->rx_buf_list[rd_index] = NULL;
 
 		/* Get data length from interface header -
@@ -1464,7 +1477,7 @@ static int mwifiex_pcie_process_recv_data(struct mwifiex_adapter *adapter)
 
 		if (mwifiex_map_pci_memory(adapter, skb_tmp,
 					   MWIFIEX_RX_DATA_BUF_SIZE,
-					   PCI_DMA_FROMDEVICE))
+					   DMA_FROM_DEVICE))
 			return -1;
 
 		buf_pa = MWIFIEX_SKB_DMA_ADDR(skb_tmp);
@@ -1541,7 +1554,7 @@ mwifiex_pcie_send_boot_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 		return -1;
 	}
 
-	if (mwifiex_map_pci_memory(adapter, skb, skb->len, PCI_DMA_TODEVICE))
+	if (mwifiex_map_pci_memory(adapter, skb, skb->len, DMA_TO_DEVICE))
 		return -1;
 
 	buf_pa = MWIFIEX_SKB_DMA_ADDR(skb);
@@ -1553,7 +1566,7 @@ mwifiex_pcie_send_boot_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 		mwifiex_dbg(adapter, ERROR,
 			    "%s: failed to write download command to boot code.\n",
 			    __func__);
-		mwifiex_unmap_pci_memory(adapter, skb, PCI_DMA_TODEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
 		return -1;
 	}
 
@@ -1565,7 +1578,7 @@ mwifiex_pcie_send_boot_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 		mwifiex_dbg(adapter, ERROR,
 			    "%s: failed to write download command to boot code.\n",
 			    __func__);
-		mwifiex_unmap_pci_memory(adapter, skb, PCI_DMA_TODEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
 		return -1;
 	}
 
@@ -1574,7 +1587,7 @@ mwifiex_pcie_send_boot_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 		mwifiex_dbg(adapter, ERROR,
 			    "%s: failed to write command len to cmd_size scratch reg\n",
 			    __func__);
-		mwifiex_unmap_pci_memory(adapter, skb, PCI_DMA_TODEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
 		return -1;
 	}
 
@@ -1583,7 +1596,7 @@ mwifiex_pcie_send_boot_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 			      CPU_INTR_DOOR_BELL)) {
 		mwifiex_dbg(adapter, ERROR,
 			    "%s: failed to assert door-bell intr\n", __func__);
-		mwifiex_unmap_pci_memory(adapter, skb, PCI_DMA_TODEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
 		return -1;
 	}
 
@@ -1642,7 +1655,7 @@ mwifiex_pcie_send_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 	put_unaligned_le16((u16)skb->len, &payload[0]);
 	put_unaligned_le16(MWIFIEX_TYPE_CMD, &payload[2]);
 
-	if (mwifiex_map_pci_memory(adapter, skb, skb->len, PCI_DMA_TODEVICE))
+	if (mwifiex_map_pci_memory(adapter, skb, skb->len, DMA_TO_DEVICE))
 		return -1;
 
 	card->cmd_buf = skb;
@@ -1742,17 +1755,16 @@ static int mwifiex_pcie_process_cmd_complete(struct mwifiex_adapter *adapter)
 		    "info: Rx CMD Response\n");
 
 	if (adapter->curr_cmd)
-		mwifiex_unmap_pci_memory(adapter, skb, PCI_DMA_FROMDEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb, DMA_FROM_DEVICE);
 	else
-		pci_dma_sync_single_for_cpu(card->dev,
-					    MWIFIEX_SKB_DMA_ADDR(skb),
-					    MWIFIEX_UPLD_SIZE,
-					    PCI_DMA_FROMDEVICE);
+		dma_sync_single_for_cpu(&card->dev->dev,
+					MWIFIEX_SKB_DMA_ADDR(skb),
+					MWIFIEX_UPLD_SIZE, DMA_FROM_DEVICE);
 
 	/* Unmap the command as a response has been received. */
 	if (card->cmd_buf) {
 		mwifiex_unmap_pci_memory(adapter, card->cmd_buf,
-					 PCI_DMA_TODEVICE);
+					 DMA_TO_DEVICE);
 		dev_kfree_skb_any(card->cmd_buf);
 		card->cmd_buf = NULL;
 	}
@@ -1763,10 +1775,10 @@ static int mwifiex_pcie_process_cmd_complete(struct mwifiex_adapter *adapter)
 
 	if (!adapter->curr_cmd) {
 		if (adapter->ps_state == PS_STATE_SLEEP_CFM) {
-			pci_dma_sync_single_for_device(card->dev,
-						MWIFIEX_SKB_DMA_ADDR(skb),
-						MWIFIEX_SLEEP_COOKIE_SIZE,
-						PCI_DMA_FROMDEVICE);
+			dma_sync_single_for_device(&card->dev->dev,
+						   MWIFIEX_SKB_DMA_ADDR(skb),
+						   MWIFIEX_SLEEP_COOKIE_SIZE,
+						   DMA_FROM_DEVICE);
 			if (mwifiex_write_reg(adapter,
 					      PCIE_CPU_INT_EVENT,
 					      CPU_INTR_SLEEP_CFM_DONE)) {
@@ -1777,7 +1789,7 @@ static int mwifiex_pcie_process_cmd_complete(struct mwifiex_adapter *adapter)
 			mwifiex_delay_for_sleep_cookie(adapter,
 						       MWIFIEX_MAX_DELAY_COUNT);
 			mwifiex_unmap_pci_memory(adapter, skb,
-						 PCI_DMA_FROMDEVICE);
+						 DMA_FROM_DEVICE);
 			skb_pull(skb, adapter->intf_hdr_len);
 			while (reg->sleep_cookie && (count++ < 10) &&
 			       mwifiex_pcie_ok_to_access_hw(adapter))
@@ -1793,7 +1805,7 @@ static int mwifiex_pcie_process_cmd_complete(struct mwifiex_adapter *adapter)
 		       min_t(u32, MWIFIEX_SIZE_OF_CMD_BUFFER, skb->len));
 		skb_push(skb, adapter->intf_hdr_len);
 		if (mwifiex_map_pci_memory(adapter, skb, MWIFIEX_UPLD_SIZE,
-					   PCI_DMA_FROMDEVICE))
+					   DMA_FROM_DEVICE))
 			return -1;
 	} else if (mwifiex_pcie_ok_to_access_hw(adapter)) {
 		skb_pull(skb, adapter->intf_hdr_len);
@@ -1835,7 +1847,7 @@ static int mwifiex_pcie_cmdrsp_complete(struct mwifiex_adapter *adapter,
 		card->cmdrsp_buf = skb;
 		skb_push(card->cmdrsp_buf, adapter->intf_hdr_len);
 		if (mwifiex_map_pci_memory(adapter, skb, MWIFIEX_UPLD_SIZE,
-					   PCI_DMA_FROMDEVICE))
+					   DMA_FROM_DEVICE))
 			return -1;
 	}
 
@@ -1890,7 +1902,7 @@ static int mwifiex_pcie_process_event_ready(struct mwifiex_adapter *adapter)
 		mwifiex_dbg(adapter, INFO,
 			    "info: Read Index: %d\n", rdptr);
 		skb_cmd = card->evt_buf_list[rdptr];
-		mwifiex_unmap_pci_memory(adapter, skb_cmd, PCI_DMA_FROMDEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb_cmd, DMA_FROM_DEVICE);
 
 		/* Take the pointer and set it to event pointer in adapter
 		   and will return back after event handling callback */
@@ -1970,7 +1982,7 @@ static int mwifiex_pcie_event_complete(struct mwifiex_adapter *adapter,
 		skb_put(skb, MAX_EVENT_SIZE - skb->len);
 		if (mwifiex_map_pci_memory(adapter, skb,
 					   MAX_EVENT_SIZE,
-					   PCI_DMA_FROMDEVICE))
+					   DMA_FROM_DEVICE))
 			return -1;
 		card->evt_buf_list[rdptr] = skb;
 		desc = card->evtbd_ring[rdptr];
@@ -2252,7 +2264,7 @@ static int mwifiex_prog_fw_w_helper(struct mwifiex_adapter *adapter,
 					    "interrupt status during fw dnld.\n",
 					    __func__);
 				mwifiex_unmap_pci_memory(adapter, skb,
-							 PCI_DMA_TODEVICE);
+							 DMA_TO_DEVICE);
 				ret = -1;
 				goto done;
 			}
@@ -2264,12 +2276,12 @@ static int mwifiex_prog_fw_w_helper(struct mwifiex_adapter *adapter,
 			mwifiex_dbg(adapter, ERROR, "%s: Card failed to ACK download\n",
 				    __func__);
 			mwifiex_unmap_pci_memory(adapter, skb,
-						 PCI_DMA_TODEVICE);
+						 DMA_TO_DEVICE);
 			ret = -1;
 			goto done;
 		}
 
-		mwifiex_unmap_pci_memory(adapter, skb, PCI_DMA_TODEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
 
 		offset += txlen;
 	} while (true);
@@ -2939,14 +2951,13 @@ static int mwifiex_init_pcie(struct mwifiex_adapter *adapter)
 
 	pci_set_master(pdev);
 
-	pr_notice("try set_consistent_dma_mask(32)\n");
-	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret) {
-		pr_err("set_dma_mask(32) failed\n");
+		pr_err("set_dma_mask(32) failed: %d\n", ret);
 		goto err_set_dma_mask;
 	}
 
-	ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret) {
 		pr_err("set_consistent_dma_mask(64) failed\n");
 		goto err_set_dma_mask;
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_rx.c b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
index 00fcbda09349..f3c6daeba1b8 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
@@ -98,6 +98,15 @@ int mwifiex_process_rx_packet(struct mwifiex_private *priv,
 	rx_pkt_len = le16_to_cpu(local_rx_pd->rx_pkt_length);
 	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_off;
 
+	if (sizeof(*rx_pkt_hdr) + rx_pkt_off > skb->len) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "wrong rx packet offset: len=%d, rx_pkt_off=%d\n",
+			    skb->len, rx_pkt_off);
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return -1;
+	}
+
 	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
 		     sizeof(bridge_tunnel_header))) ||
 	    (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
@@ -203,7 +212,8 @@ int mwifiex_process_sta_rx_packet(struct mwifiex_private *priv,
 
 	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_offset;
 
-	if ((rx_pkt_offset + rx_pkt_length) > (u16) skb->len) {
+	if ((rx_pkt_offset + rx_pkt_length) > skb->len ||
+	    sizeof(rx_pkt_hdr->eth803_hdr) + rx_pkt_offset > skb->len) {
 		mwifiex_dbg(adapter, ERROR,
 			    "wrong rx packet: len=%d, rx_pkt_offset=%d, rx_pkt_length=%d\n",
 			    skb->len, rx_pkt_offset, rx_pkt_length);
diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wireless/marvell/mwifiex/tdls.c
index b6b7bbe168eb..12cfc95f0259 100644
--- a/drivers/net/wireless/marvell/mwifiex/tdls.c
+++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
@@ -737,6 +737,7 @@ mwifiex_construct_tdls_action_frame(struct mwifiex_private *priv,
 	int ret;
 	u16 capab;
 	struct ieee80211_ht_cap *ht_cap;
+	unsigned int extra;
 	u8 radio, *pos;
 
 	capab = priv->curr_bss_params.bss_descriptor.cap_info_bitmap;
@@ -755,7 +756,10 @@ mwifiex_construct_tdls_action_frame(struct mwifiex_private *priv,
 
 	switch (action_code) {
 	case WLAN_PUB_ACTION_TDLS_DISCOVER_RES:
-		skb_put(skb, sizeof(mgmt->u.action.u.tdls_discover_resp) + 1);
+		/* See the layout of 'struct ieee80211_mgmt'. */
+		extra = sizeof(mgmt->u.action.u.tdls_discover_resp) +
+			sizeof(mgmt->u.action.category);
+		skb_put(skb, extra);
 		mgmt->u.action.category = WLAN_CATEGORY_PUBLIC;
 		mgmt->u.action.u.tdls_discover_resp.action_code =
 					      WLAN_PUB_ACTION_TDLS_DISCOVER_RES;
@@ -764,8 +768,7 @@ mwifiex_construct_tdls_action_frame(struct mwifiex_private *priv,
 		mgmt->u.action.u.tdls_discover_resp.capability =
 							     cpu_to_le16(capab);
 		/* move back for addr4 */
-		memmove(pos + ETH_ALEN, &mgmt->u.action.category,
-			sizeof(mgmt->u.action.u.tdls_discover_resp));
+		memmove(pos + ETH_ALEN, &mgmt->u.action, extra);
 		/* init address 4 */
 		memcpy(pos, bc_addr, ETH_ALEN);
 
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
index 5ce85d5727e4..987057af00fb 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -116,6 +116,16 @@ static void mwifiex_uap_queue_bridged_pkt(struct mwifiex_private *priv,
 		return;
 	}
 
+	if (sizeof(*rx_pkt_hdr) +
+	    le16_to_cpu(uap_rx_pd->rx_pkt_offset) > skb->len) {
+		mwifiex_dbg(adapter, ERROR,
+			    "wrong rx packet offset: len=%d,rx_pkt_offset=%d\n",
+			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset));
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return;
+	}
+
 	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
 		     sizeof(bridge_tunnel_header))) ||
 	    (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
@@ -256,7 +266,15 @@ int mwifiex_handle_uap_rx_forward(struct mwifiex_private *priv,
 
 	if (is_multicast_ether_addr(ra)) {
 		skb_uap = skb_copy(skb, GFP_ATOMIC);
-		mwifiex_uap_queue_bridged_pkt(priv, skb_uap);
+		if (likely(skb_uap)) {
+			mwifiex_uap_queue_bridged_pkt(priv, skb_uap);
+		} else {
+			mwifiex_dbg(adapter, ERROR,
+				    "failed to copy skb for uAP\n");
+			priv->stats.rx_dropped++;
+			dev_kfree_skb_any(skb);
+			return -1;
+		}
 	} else {
 		if (mwifiex_get_sta_entry(priv, ra)) {
 			/* Requeue Intra-BSS packet */
@@ -385,6 +403,16 @@ int mwifiex_process_uap_rx_packet(struct mwifiex_private *priv,
 	rx_pkt_type = le16_to_cpu(uap_rx_pd->rx_pkt_type);
 	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
 
+	if (le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
+	    sizeof(rx_pkt_hdr->eth803_hdr) > skb->len) {
+		mwifiex_dbg(adapter, ERROR,
+			    "wrong rx packet for struct ethhdr: len=%d, offset=%d\n",
+			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset));
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
 	ether_addr_copy(ta, rx_pkt_hdr->eth803_hdr.h_source);
 
 	if ((le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index f9b71539d33e..c45f72779d08 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -405,11 +405,15 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 	}
 
 	rx_pd = (struct rxpd *)skb->data;
+	pkt_len = le16_to_cpu(rx_pd->rx_pkt_length);
+	if (pkt_len < sizeof(struct ieee80211_hdr) + sizeof(pkt_len)) {
+		mwifiex_dbg(priv->adapter, ERROR, "invalid rx_pkt_length");
+		return -1;
+	}
 
 	skb_pull(skb, le16_to_cpu(rx_pd->rx_pkt_offset));
 	skb_pull(skb, sizeof(pkt_len));
-
-	pkt_len = le16_to_cpu(rx_pd->rx_pkt_length);
+	pkt_len -= sizeof(pkt_len);
 
 	ieee_hdr = (void *)skb->data;
 	if (ieee80211_is_mgmt(ieee_hdr->frame_control)) {
@@ -422,7 +426,7 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 		skb->data + sizeof(struct ieee80211_hdr),
 		pkt_len - sizeof(struct ieee80211_hdr));
 
-	pkt_len -= ETH_ALEN + sizeof(pkt_len);
+	pkt_len -= ETH_ALEN;
 	rx_pd->rx_pkt_length = cpu_to_le16(pkt_len);
 
 	cfg80211_rx_mgmt(&priv->wdev, priv->roc_cfg.chan.center_freq,
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 2d647a1cd0ee..9ac97d560c1c 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -746,7 +746,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	return 0;
 }
 
-static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
+static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
 {
 	qp->link_is_up = false;
 	qp->active = false;
@@ -769,6 +769,13 @@ static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
 	qp->tx_async = 0;
 }
 
+static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
+{
+	ntb_qp_link_context_reset(qp);
+	if (qp->remote_rx_info)
+		qp->remote_rx_info->entry = qp->rx_max_entry - 1;
+}
+
 static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 {
 	struct ntb_transport_ctx *nt = qp->transport;
@@ -993,7 +1000,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->ndev = nt->ndev;
 	qp->client_ready = false;
 	qp->event_handler = NULL;
-	ntb_qp_link_down_reset(qp);
+	ntb_qp_link_context_reset(qp);
 
 	if (mw_num < qp_count % mw_count)
 		num_qps_mw = qp_count / mw_count + 1;
@@ -2046,9 +2053,13 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 	struct ntb_queue_entry *entry;
 	int rc;
 
-	if (!qp || !qp->link_is_up || !len)
+	if (!qp || !len)
 		return -EINVAL;
 
+	/* If the qp link is down already, just ignore. */
+	if (!qp->link_is_up)
+		return 0;
+
 	entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q);
 	if (!entry) {
 		qp->tx_err_no_buf++;
@@ -2188,7 +2199,7 @@ unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
 	unsigned int head = qp->tx_index;
 	unsigned int tail = qp->remote_rx_info->entry;
 
-	return tail > head ? tail - head : qp->tx_max_entry + tail - head;
+	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
 }
 EXPORT_SYMBOL_GPL(ntb_transport_tx_free_entry);
 
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 29f17c3449aa..2515ce393005 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -52,7 +52,7 @@ static void __init of_unittest_find_node_by_name(void)
 
 	np = of_find_node_by_path("/testcase-data");
 	name = kasprintf(GFP_KERNEL, "%pOF", np);
-	unittest(np && !strcmp("/testcase-data", name),
+	unittest(np && name && !strcmp("/testcase-data", name),
 		"find /testcase-data failed\n");
 	of_node_put(np);
 	kfree(name);
@@ -63,14 +63,14 @@ static void __init of_unittest_find_node_by_name(void)
 
 	np = of_find_node_by_path("/testcase-data/phandle-tests/consumer-a");
 	name = kasprintf(GFP_KERNEL, "%pOF", np);
-	unittest(np && !strcmp("/testcase-data/phandle-tests/consumer-a", name),
+	unittest(np && name && !strcmp("/testcase-data/phandle-tests/consumer-a", name),
 		"find /testcase-data/phandle-tests/consumer-a failed\n");
 	of_node_put(np);
 	kfree(name);
 
 	np = of_find_node_by_path("testcase-alias");
 	name = kasprintf(GFP_KERNEL, "%pOF", np);
-	unittest(np && !strcmp("/testcase-data", name),
+	unittest(np && name && !strcmp("/testcase-data", name),
 		"find testcase-alias failed\n");
 	of_node_put(np);
 	kfree(name);
@@ -81,7 +81,7 @@ static void __init of_unittest_find_node_by_name(void)
 
 	np = of_find_node_by_path("testcase-alias/phandle-tests/consumer-a");
 	name = kasprintf(GFP_KERNEL, "%pOF", np);
-	unittest(np && !strcmp("/testcase-data/phandle-tests/consumer-a", name),
+	unittest(np && name && !strcmp("/testcase-data/phandle-tests/consumer-a", name),
 		"find testcase-alias/phandle-tests/consumer-a failed\n");
 	of_node_put(np);
 	kfree(name);
@@ -1138,6 +1138,8 @@ static void attach_node_and_children(struct device_node *np)
 	const char *full_name;
 
 	full_name = kasprintf(GFP_KERNEL, "%pOF", np);
+	if (!full_name)
+		return;
 
 	if (!strcmp(full_name, "/__local_fixups__") ||
 	    !strcmp(full_name, "/__fixups__")) {
@@ -1571,7 +1573,7 @@ static int __init of_unittest_apply_revert_overlay_check(int overlay_nr,
 	}
 
 	/* unittest device must be again in before state */
-	if (of_unittest_device_exists(unittest_nr, PDEV_OVERLAY) != before) {
+	if (of_unittest_device_exists(unittest_nr, ovtype) != before) {
 		unittest(0, "%s with device @\"%s\" %s\n",
 				overlay_name_from_nr(overlay_nr),
 				unittest_path(unittest_nr, ovtype),
diff --git a/drivers/parisc/led.c b/drivers/parisc/led.c
index 6a0833f5923c..8a5a73d75400 100644
--- a/drivers/parisc/led.c
+++ b/drivers/parisc/led.c
@@ -60,8 +60,8 @@
 static int led_type __read_mostly = -1;
 static unsigned char lastleds;	/* LED state from most recent update */
 static unsigned int led_heartbeat __read_mostly = 1;
-static unsigned int led_diskio    __read_mostly = 1;
-static unsigned int led_lanrxtx   __read_mostly = 1;
+static unsigned int led_diskio    __read_mostly;
+static unsigned int led_lanrxtx   __read_mostly;
 static char lcd_text[32]          __read_mostly;
 static char lcd_text_default[32]  __read_mostly;
 static int  lcd_no_led_support    __read_mostly = 0; /* KittyHawk doesn't support LED on its LCD */
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 5b78f3b1b918..420cd0a578d0 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -368,6 +368,36 @@ int pci_pasid_features(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_pasid_features);
 
+/**
+ * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
+ *				 status.
+ * @pdev: PCI device structure
+ *
+ * Returns 1 if PASID is required in PRG Response Message, 0 otherwise.
+ *
+ * Even though the PRG response PASID status is read from PRI Status
+ * Register, since this API will mainly be used by PASID users, this
+ * function is defined within #ifdef CONFIG_PCI_PASID instead of
+ * CONFIG_PCI_PRI.
+ */
+int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+{
+	u16 status;
+	int pos;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
+	if (!pos)
+		return 0;
+
+	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
+
+	if (status & PCI_PRI_STATUS_PASID)
+		return 1;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
+
 #define PASID_NUMBER_SHIFT	8
 #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
 /**
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 7392b26e9f15..04630106269a 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -298,17 +298,11 @@ int pciehp_check_link_status(struct controller *ctrl)
 static int __pciehp_link_set(struct controller *ctrl, bool enable)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 lnk_ctrl;
 
-	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &lnk_ctrl);
+	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_LD,
+					   enable ? 0 : PCI_EXP_LNKCTL_LD);
 
-	if (enable)
-		lnk_ctrl &= ~PCI_EXP_LNKCTL_LD;
-	else
-		lnk_ctrl |= PCI_EXP_LNKCTL_LD;
-
-	pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, lnk_ctrl);
-	ctrl_dbg(ctrl, "%s: lnk_ctrl = %x\n", __func__, lnk_ctrl);
 	return 0;
 }
 
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 34a7b3c137bb..7d3fb70568e3 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -182,6 +182,9 @@ static ssize_t current_link_speed_show(struct device *dev,
 		return -EINVAL;
 
 	switch (linkstat & PCI_EXP_LNKSTA_CLS) {
+	case PCI_EXP_LNKSTA_CLS_32_0GB:
+		speed = "32 GT/s";
+		break;
 	case PCI_EXP_LNKSTA_CLS_16_0GB:
 		speed = "16 GT/s";
 		break;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c8326c7b468f..2ac400adaee1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5575,7 +5575,9 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
 	 */
 	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
 	if (lnkcap2) { /* PCIe r3.0-compliant */
-		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_16_0GB)
+		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_32_0GB)
+			return PCIE_SPEED_32_0GT;
+		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_16_0GB)
 			return PCIE_SPEED_16_0GT;
 		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
 			return PCIE_SPEED_8_0GT;
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index eec62f7377f4..118c91586798 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -260,7 +260,7 @@ static int pcie_retrain_link(struct pcie_link_state *link)
 static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 {
 	int same_clock = 1;
-	u16 reg16, parent_reg, child_reg[8];
+	u16 reg16, ccc, parent_old_ccc, child_old_ccc[8];
 	struct pci_dev *child, *parent = link->pdev;
 	struct pci_bus *linkbus = parent->subordinate;
 	/*
@@ -282,6 +282,7 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 
 	/* Port might be already in common clock mode */
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
+	parent_old_ccc = reg16 & PCI_EXP_LNKCTL_CCC;
 	if (same_clock && (reg16 & PCI_EXP_LNKCTL_CCC)) {
 		bool consistent = true;
 
@@ -298,34 +299,29 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 		pci_warn(parent, "ASPM: current common clock configuration is broken, reconfiguring\n");
 	}
 
+	ccc = same_clock ? PCI_EXP_LNKCTL_CCC : 0;
 	/* Configure downstream component, all functions */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
 		pcie_capability_read_word(child, PCI_EXP_LNKCTL, &reg16);
-		child_reg[PCI_FUNC(child->devfn)] = reg16;
-		if (same_clock)
-			reg16 |= PCI_EXP_LNKCTL_CCC;
-		else
-			reg16 &= ~PCI_EXP_LNKCTL_CCC;
-		pcie_capability_write_word(child, PCI_EXP_LNKCTL, reg16);
+		child_old_ccc[PCI_FUNC(child->devfn)] = reg16 & PCI_EXP_LNKCTL_CCC;
+		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_CCC, ccc);
 	}
 
 	/* Configure upstream component */
-	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
-	parent_reg = reg16;
-	if (same_clock)
-		reg16 |= PCI_EXP_LNKCTL_CCC;
-	else
-		reg16 &= ~PCI_EXP_LNKCTL_CCC;
-	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
+	pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_CCC, ccc);
 
 	if (pcie_retrain_link(link)) {
 
 		/* Training failed. Restore common clock configurations */
 		pci_err(parent, "ASPM: Could not configure common clock\n");
 		list_for_each_entry(child, &linkbus->devices, bus_list)
-			pcie_capability_write_word(child, PCI_EXP_LNKCTL,
-					   child_reg[PCI_FUNC(child->devfn)]);
-		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
+			pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
+							   PCI_EXP_LNKCTL_CCC,
+							   child_old_ccc[PCI_FUNC(child->devfn)]);
+		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_CCC, parent_old_ccc);
 	}
 }
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 113b7bdf86dd..5a609848452f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -667,7 +667,7 @@ const unsigned char pcie_link_speed[] = {
 	PCIE_SPEED_5_0GT,		/* 2 */
 	PCIE_SPEED_8_0GT,		/* 3 */
 	PCIE_SPEED_16_0GT,		/* 4 */
-	PCI_SPEED_UNKNOWN,		/* 5 */
+	PCIE_SPEED_32_0GT,		/* 5 */
 	PCI_SPEED_UNKNOWN,		/* 6 */
 	PCI_SPEED_UNKNOWN,		/* 7 */
 	PCI_SPEED_UNKNOWN,		/* 8 */
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index dfbe9cbf292c..d575583e49c2 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -75,6 +75,7 @@ static const char *pci_bus_speed_strings[] = {
 	"5.0 GT/s PCIe",	/* 0x15 */
 	"8.0 GT/s PCIe",	/* 0x16 */
 	"16.0 GT/s PCIe",	/* 0x17 */
+	"32.0 GT/s PCIe",	/* 0x18 */
 };
 
 static ssize_t bus_speed_read(enum pci_bus_speed speed, char *buf)
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index c140ee16fe7c..ee25edecc2e1 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -663,7 +663,7 @@ static int amd_pinconf_get(struct pinctrl_dev *pctldev,
 		break;
 
 	default:
-		dev_err(&gpio_dev->pdev->dev, "Invalid config param %04x\n",
+		dev_dbg(&gpio_dev->pdev->dev, "Invalid config param %04x\n",
 			param);
 		return -ENOTSUPP;
 	}
@@ -716,7 +716,7 @@ static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 
 		default:
-			dev_err(&gpio_dev->pdev->dev,
+			dev_dbg(&gpio_dev->pdev->dev,
 				"Invalid config param %04x\n", param);
 			ret = -ENOTSUPP;
 		}
diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index fa3cda69cec9..159284bfdd7f 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -449,7 +449,7 @@ static bool button_array_present(struct platform_device *device)
 static int intel_hid_probe(struct platform_device *device)
 {
 	acpi_handle handle = ACPI_HANDLE(&device->dev);
-	unsigned long long mode;
+	unsigned long long mode, dummy;
 	struct intel_hid_priv *priv;
 	acpi_status status;
 	int err;
@@ -501,18 +501,15 @@ static int intel_hid_probe(struct platform_device *device)
 	if (err)
 		goto err_remove_notify;
 
-	if (priv->array) {
-		unsigned long long dummy;
+	intel_button_array_enable(&device->dev, true);
 
-		intel_button_array_enable(&device->dev, true);
-
-		/* Call button load method to enable HID power button */
-		if (!intel_hid_evaluate_method(handle, INTEL_HID_DSM_BTNL_FN,
-					       &dummy)) {
-			dev_warn(&device->dev,
-				 "failed to enable HID power button\n");
-		}
-	}
+	/*
+	 * Call button load method to enable HID power button
+	 * Always do this since it activates events on some devices without
+	 * a button array too.
+	 */
+	if (!intel_hid_evaluate_method(handle, INTEL_HID_DSM_BTNL_FN, &dummy))
+		dev_warn(&device->dev, "failed to enable HID power button\n");
 
 	device_init_wakeup(&device->dev, true);
 	return 0;
diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index ed8e9406b4af..b5f8b86b328a 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -55,10 +55,10 @@ static int lpc32xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (duty_cycles > 255)
 		duty_cycles = 255;
 
-	val = readl(lpc32xx->base + (pwm->hwpwm << 2));
+	val = readl(lpc32xx->base);
 	val &= ~0xFFFF;
 	val |= (period_cycles << 8) | duty_cycles;
-	writel(val, lpc32xx->base + (pwm->hwpwm << 2));
+	writel(val, lpc32xx->base);
 
 	return 0;
 }
@@ -73,9 +73,9 @@ static int lpc32xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (ret)
 		return ret;
 
-	val = readl(lpc32xx->base + (pwm->hwpwm << 2));
+	val = readl(lpc32xx->base);
 	val |= PWM_ENABLE;
-	writel(val, lpc32xx->base + (pwm->hwpwm << 2));
+	writel(val, lpc32xx->base);
 
 	return 0;
 }
@@ -85,9 +85,9 @@ static void lpc32xx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct lpc32xx_pwm_chip *lpc32xx = to_lpc32xx_pwm_chip(chip);
 	u32 val;
 
-	val = readl(lpc32xx->base + (pwm->hwpwm << 2));
+	val = readl(lpc32xx->base);
 	val &= ~PWM_ENABLE;
-	writel(val, lpc32xx->base + (pwm->hwpwm << 2));
+	writel(val, lpc32xx->base);
 
 	clk_disable_unprepare(lpc32xx->clk);
 }
@@ -125,9 +125,9 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
 	lpc32xx->chip.base = -1;
 
 	/* If PWM is disabled, configure the output to the default value */
-	val = readl(lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
+	val = readl(lpc32xx->base);
 	val &= ~PWM_PIN_LEVEL;
-	writel(val, lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
+	writel(val, lpc32xx->base);
 
 	ret = pwmchip_add(&lpc32xx->chip);
 	if (ret < 0) {
diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 940f099c2092..02e39778d3c6 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -222,6 +222,10 @@ static struct glink_channel *qcom_glink_alloc_channel(struct qcom_glink *glink,
 
 	channel->glink = glink;
 	channel->name = kstrdup(name, GFP_KERNEL);
+	if (!channel->name) {
+		kfree(channel);
+		return ERR_PTR(-ENOMEM);
+	}
 
 	init_completion(&channel->open_req);
 	init_completion(&channel->open_ack);
diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 6f39f683a98c..83926cd4753b 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -1630,7 +1630,7 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
 		unreachable();
 	}
 }
-EXPORT_SYMBOL(ds1685_rtc_poweroff);
+EXPORT_SYMBOL_GPL(ds1685_rtc_poweroff);
 /* ----------------------------------------------------------------------- */
 
 
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index c1cf277d0d89..c0eee7b00442 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2826,41 +2826,32 @@ static void _dasd_wake_block_flush_cb(struct dasd_ccw_req *cqr, void *data)
  * Requeue a request back to the block request queue
  * only works for block requests
  */
-static int _dasd_requeue_request(struct dasd_ccw_req *cqr)
+static void _dasd_requeue_request(struct dasd_ccw_req *cqr)
 {
-	struct dasd_block *block = cqr->block;
 	struct request *req;
 
-	if (!block)
-		return -EINVAL;
 	/*
 	 * If the request is an ERP request there is nothing to requeue.
 	 * This will be done with the remaining original request.
 	 */
 	if (cqr->refers)
-		return 0;
+		return;
 	spin_lock_irq(&cqr->dq->lock);
 	req = (struct request *) cqr->callback_data;
 	blk_mq_requeue_request(req, true);
 	spin_unlock_irq(&cqr->dq->lock);
 
-	return 0;
+	return;
 }
 
-/*
- * Go through all request on the dasd_block request queue, cancel them
- * on the respective dasd_device, and return them to the generic
- * block layer.
- */
-static int dasd_flush_block_queue(struct dasd_block *block)
+static int _dasd_requests_to_flushqueue(struct dasd_block *block,
+					struct list_head *flush_queue)
 {
 	struct dasd_ccw_req *cqr, *n;
-	int rc, i;
-	struct list_head flush_queue;
 	unsigned long flags;
+	int rc, i;
 
-	INIT_LIST_HEAD(&flush_queue);
-	spin_lock_bh(&block->queue_lock);
+	spin_lock_irqsave(&block->queue_lock, flags);
 	rc = 0;
 restart:
 	list_for_each_entry_safe(cqr, n, &block->ccw_queue, blocklist) {
@@ -2875,13 +2866,32 @@ static int dasd_flush_block_queue(struct dasd_block *block)
 		 * is returned from the dasd_device layer.
 		 */
 		cqr->callback = _dasd_wake_block_flush_cb;
-		for (i = 0; cqr != NULL; cqr = cqr->refers, i++)
-			list_move_tail(&cqr->blocklist, &flush_queue);
+		for (i = 0; cqr; cqr = cqr->refers, i++)
+			list_move_tail(&cqr->blocklist, flush_queue);
 		if (i > 1)
 			/* moved more than one request - need to restart */
 			goto restart;
 	}
-	spin_unlock_bh(&block->queue_lock);
+	spin_unlock_irqrestore(&block->queue_lock, flags);
+
+	return rc;
+}
+
+/*
+ * Go through all request on the dasd_block request queue, cancel them
+ * on the respective dasd_device, and return them to the generic
+ * block layer.
+ */
+static int dasd_flush_block_queue(struct dasd_block *block)
+{
+	struct dasd_ccw_req *cqr, *n;
+	struct list_head flush_queue;
+	unsigned long flags;
+	int rc;
+
+	INIT_LIST_HEAD(&flush_queue);
+	rc = _dasd_requests_to_flushqueue(block, &flush_queue);
+
 	/* Now call the callback function of flushed requests */
 restart_cb:
 	list_for_each_entry_safe(cqr, n, &flush_queue, blocklist) {
@@ -3832,75 +3842,36 @@ EXPORT_SYMBOL_GPL(dasd_generic_verify_path);
  */
 static int dasd_generic_requeue_all_requests(struct dasd_device *device)
 {
+	struct dasd_block *block = device->block;
 	struct list_head requeue_queue;
 	struct dasd_ccw_req *cqr, *n;
-	struct dasd_ccw_req *refers;
 	int rc;
 
-	INIT_LIST_HEAD(&requeue_queue);
-	spin_lock_irq(get_ccwdev_lock(device->cdev));
-	rc = 0;
-	list_for_each_entry_safe(cqr, n, &device->ccw_queue, devlist) {
-		/* Check status and move request to flush_queue */
-		if (cqr->status == DASD_CQR_IN_IO) {
-			rc = device->discipline->term_IO(cqr);
-			if (rc) {
-				/* unable to terminate requeust */
-				dev_err(&device->cdev->dev,
-					"Unable to terminate request %p "
-					"on suspend\n", cqr);
-				spin_unlock_irq(get_ccwdev_lock(device->cdev));
-				dasd_put_device(device);
-				return rc;
-			}
-		}
-		list_move_tail(&cqr->devlist, &requeue_queue);
-	}
-	spin_unlock_irq(get_ccwdev_lock(device->cdev));
-
-	list_for_each_entry_safe(cqr, n, &requeue_queue, devlist) {
-		wait_event(dasd_flush_wq,
-			   (cqr->status != DASD_CQR_CLEAR_PENDING));
+	if (!block)
+		return 0;
 
-		/*
-		 * requeue requests to blocklayer will only work
-		 * for block device requests
-		 */
-		if (_dasd_requeue_request(cqr))
-			continue;
+	INIT_LIST_HEAD(&requeue_queue);
+	rc = _dasd_requests_to_flushqueue(block, &requeue_queue);
 
-		/* remove requests from device and block queue */
-		list_del_init(&cqr->devlist);
-		while (cqr->refers != NULL) {
-			refers = cqr->refers;
-			/* remove the request from the block queue */
-			list_del(&cqr->blocklist);
-			/* free the finished erp request */
-			dasd_free_erp_request(cqr, cqr->memdev);
-			cqr = refers;
+	/* Now call the callback function of flushed requests */
+restart_cb:
+	list_for_each_entry_safe(cqr, n, &requeue_queue, blocklist) {
+		wait_event(dasd_flush_wq, (cqr->status < DASD_CQR_QUEUED));
+		/* Process finished ERP request. */
+		if (cqr->refers) {
+			spin_lock_bh(&block->queue_lock);
+			__dasd_process_erp(block->base, cqr);
+			spin_unlock_bh(&block->queue_lock);
+			/* restart list_for_xx loop since dasd_process_erp
+			 * might remove multiple elements
+			 */
+			goto restart_cb;
 		}
-
-		/*
-		 * _dasd_requeue_request already checked for a valid
-		 * blockdevice, no need to check again
-		 * all erp requests (cqr->refers) have a cqr->block
-		 * pointer copy from the original cqr
-		 */
+		_dasd_requeue_request(cqr);
 		list_del_init(&cqr->blocklist);
 		cqr->block->base->discipline->free_cp(
 			cqr, (struct request *) cqr->callback_data);
 	}
-
-	/*
-	 * if requests remain then they are internal request
-	 * and go back to the device queue
-	 */
-	if (!list_empty(&requeue_queue)) {
-		/* move freeze_queue to start of the ccw_queue */
-		spin_lock_irq(get_ccwdev_lock(device->cdev));
-		list_splice_tail(&requeue_queue, &device->ccw_queue);
-		spin_unlock_irq(get_ccwdev_lock(device->cdev));
-	}
 	dasd_schedule_device_bh(device);
 	return rc;
 }
diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index ee73b0607e47..8598c792ded3 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -2436,7 +2436,7 @@ static struct dasd_ccw_req *dasd_3990_erp_add_erp(struct dasd_ccw_req *cqr)
 	erp->block    = cqr->block;
 	erp->magic    = cqr->magic;
 	erp->expires  = cqr->expires;
-	erp->retries  = 256;
+	erp->retries  = device->default_retries;
 	erp->buildclk = get_tod_clock();
 	erp->status = DASD_CQR_FILLED;
 
diff --git a/drivers/scsi/be2iscsi/be_iscsi.c b/drivers/scsi/be2iscsi/be_iscsi.c
index c8f0a2144b44..818a690771e0 100644
--- a/drivers/scsi/be2iscsi/be_iscsi.c
+++ b/drivers/scsi/be2iscsi/be_iscsi.c
@@ -445,6 +445,10 @@ int beiscsi_iface_set_param(struct Scsi_Host *shost,
 	}
 
 	nla_for_each_attr(attrib, data, dt_len, rm_len) {
+		/* ignore nla_type as it is never used */
+		if (nla_len(attrib) < sizeof(*iface_param))
+			return -EINVAL;
+
 		iface_param = nla_data(attrib);
 
 		if (iface_param->param_type != ISCSI_NET_PARAM)
diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 1e087a206f48..c49986eba47b 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -330,16 +330,17 @@ static void fcoe_ctlr_announce(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *sel;
 	struct fcoe_fcf *fcf;
+	unsigned long flags;
 
 	mutex_lock(&fip->ctlr_mutex);
-	spin_lock_bh(&fip->ctlr_lock);
+	spin_lock_irqsave(&fip->ctlr_lock, flags);
 
 	kfree_skb(fip->flogi_req);
 	fip->flogi_req = NULL;
 	list_for_each_entry(fcf, &fip->fcfs, list)
 		fcf->flogi_sent = 0;
 
-	spin_unlock_bh(&fip->ctlr_lock);
+	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
 	sel = fip->sel_fcf;
 
 	if (sel && ether_addr_equal(sel->fcf_mac, fip->dest_addr))
@@ -709,6 +710,7 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
 {
 	struct fc_frame *fp;
 	struct fc_frame_header *fh;
+	unsigned long flags;
 	u16 old_xid;
 	u8 op;
 	u8 mac[ETH_ALEN];
@@ -742,11 +744,11 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
 		op = FIP_DT_FLOGI;
 		if (fip->mode == FIP_MODE_VN2VN)
 			break;
-		spin_lock_bh(&fip->ctlr_lock);
+		spin_lock_irqsave(&fip->ctlr_lock, flags);
 		kfree_skb(fip->flogi_req);
 		fip->flogi_req = skb;
 		fip->flogi_req_send = 1;
-		spin_unlock_bh(&fip->ctlr_lock);
+		spin_unlock_irqrestore(&fip->ctlr_lock, flags);
 		schedule_work(&fip->timer_work);
 		return -EINPROGRESS;
 	case ELS_FDISC:
@@ -1723,10 +1725,11 @@ static int fcoe_ctlr_flogi_send_locked(struct fcoe_ctlr *fip)
 static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *fcf;
+	unsigned long flags;
 	int error;
 
 	mutex_lock(&fip->ctlr_mutex);
-	spin_lock_bh(&fip->ctlr_lock);
+	spin_lock_irqsave(&fip->ctlr_lock, flags);
 	LIBFCOE_FIP_DBG(fip, "re-sending FLOGI - reselect\n");
 	fcf = fcoe_ctlr_select(fip);
 	if (!fcf || fcf->flogi_sent) {
@@ -1737,7 +1740,7 @@ static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 		fcoe_ctlr_solicit(fip, NULL);
 		error = fcoe_ctlr_flogi_send_locked(fip);
 	}
-	spin_unlock_bh(&fip->ctlr_lock);
+	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
 	mutex_unlock(&fip->ctlr_mutex);
 	return error;
 }
@@ -1754,8 +1757,9 @@ static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *fcf;
+	unsigned long flags;
 
-	spin_lock_bh(&fip->ctlr_lock);
+	spin_lock_irqsave(&fip->ctlr_lock, flags);
 	fcf = fip->sel_fcf;
 	if (!fcf || !fip->flogi_req_send)
 		goto unlock;
@@ -1782,7 +1786,7 @@ static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 	} else /* XXX */
 		LIBFCOE_FIP_DBG(fip, "No FCF selected - defer send\n");
 unlock:
-	spin_unlock_bh(&fip->ctlr_lock);
+	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
 }
 
 /**
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 2ffc2e15d822..c5a0ef6f67c0 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -532,7 +532,7 @@ EXPORT_SYMBOL(scsi_host_alloc);
 static int __scsi_host_match(struct device *dev, const void *data)
 {
 	struct Scsi_Host *p;
-	const unsigned short *hostnum = data;
+	const unsigned int *hostnum = data;
 
 	p = class_to_shost(dev);
 	return p->host_no == *hostnum;
@@ -549,7 +549,7 @@ static int __scsi_host_match(struct device *dev, const void *data)
  *	that scsi_host_get() took. The put_device() below dropped
  *	the reference from class_find_device().
  **/
-struct Scsi_Host *scsi_host_lookup(unsigned short hostnum)
+struct Scsi_Host *scsi_host_lookup(unsigned int hostnum)
 {
 	struct device *cdev;
 	struct Scsi_Host *shost = NULL;
diff --git a/drivers/scsi/qedf/qedf_dbg.h b/drivers/scsi/qedf/qedf_dbg.h
index dd0109653aa3..9c7f7b444daa 100644
--- a/drivers/scsi/qedf/qedf_dbg.h
+++ b/drivers/scsi/qedf/qedf_dbg.h
@@ -63,6 +63,8 @@ extern uint qedf_debug;
 #define QEDF_LOG_NOTICE	0x40000000	/* Notice logs */
 #define QEDF_LOG_WARN		0x80000000	/* Warning logs */
 
+#define QEDF_DEBUGFS_LOG_LEN (2 * PAGE_SIZE)
+
 /* Debug context structure */
 struct qedf_dbg_ctx {
 	unsigned int host_no;
diff --git a/drivers/scsi/qedf/qedf_debugfs.c b/drivers/scsi/qedf/qedf_debugfs.c
index c29c162a494f..84f1ddcfbb21 100644
--- a/drivers/scsi/qedf/qedf_debugfs.c
+++ b/drivers/scsi/qedf/qedf_debugfs.c
@@ -11,6 +11,7 @@
 #include <linux/uaccess.h>
 #include <linux/debugfs.h>
 #include <linux/module.h>
+#include <linux/vmalloc.h>
 
 #include "qedf.h"
 #include "qedf_dbg.h"
@@ -117,7 +118,9 @@ static ssize_t
 qedf_dbg_fp_int_cmd_read(struct file *filp, char __user *buffer, size_t count,
 			 loff_t *ppos)
 {
+	ssize_t ret;
 	size_t cnt = 0;
+	char *cbuf;
 	int id;
 	struct qedf_fastpath *fp = NULL;
 	struct qedf_dbg_ctx *qedf_dbg =
@@ -127,19 +130,25 @@ qedf_dbg_fp_int_cmd_read(struct file *filp, char __user *buffer, size_t count,
 
 	QEDF_INFO(qedf_dbg, QEDF_LOG_DEBUGFS, "entered\n");
 
-	cnt = sprintf(buffer, "\nFastpath I/O completions\n\n");
+	cbuf = vmalloc(QEDF_DEBUGFS_LOG_LEN);
+	if (!cbuf)
+		return 0;
+
+	cnt += scnprintf(cbuf + cnt, QEDF_DEBUGFS_LOG_LEN - cnt, "\nFastpath I/O completions\n\n");
 
 	for (id = 0; id < qedf->num_queues; id++) {
 		fp = &(qedf->fp_array[id]);
 		if (fp->sb_id == QEDF_SB_ID_NULL)
 			continue;
-		cnt += sprintf((buffer + cnt), "#%d: %lu\n", id,
-			       fp->completions);
+		cnt += scnprintf(cbuf + cnt, QEDF_DEBUGFS_LOG_LEN - cnt,
+				 "#%d: %lu\n", id, fp->completions);
 	}
 
-	cnt = min_t(int, count, cnt - *ppos);
-	*ppos += cnt;
-	return cnt;
+	ret = simple_read_from_buffer(buffer, count, ppos, cbuf, cnt);
+
+	vfree(cbuf);
+
+	return ret;
 }
 
 static ssize_t
@@ -204,18 +213,17 @@ qedf_dbg_stop_io_on_error_cmd_read(struct file *filp, char __user *buffer,
 				   size_t count, loff_t *ppos)
 {
 	int cnt;
+	char cbuf[7];
 	struct qedf_dbg_ctx *qedf_dbg =
 				(struct qedf_dbg_ctx *)filp->private_data;
 	struct qedf_ctx *qedf = container_of(qedf_dbg,
 	    struct qedf_ctx, dbg_ctx);
 
 	QEDF_INFO(qedf_dbg, QEDF_LOG_DEBUGFS, "entered\n");
-	cnt = sprintf(buffer, "%s\n",
+	cnt = scnprintf(cbuf, sizeof(cbuf), "%s\n",
 	    qedf->stop_io_on_error ? "true" : "false");
 
-	cnt = min_t(int, count, cnt - *ppos);
-	*ppos += cnt;
-	return cnt;
+	return simple_read_from_buffer(buffer, count, ppos, cbuf, cnt);
 }
 
 static ssize_t
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index ab66e1f0fdfa..7a179cfc01ed 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1864,8 +1864,9 @@ static int qedi_cpu_offline(unsigned int cpu)
 	struct qedi_percpu_s *p = this_cpu_ptr(&qedi_percpu);
 	struct qedi_work *work, *tmp;
 	struct task_struct *thread;
+	unsigned long flags;
 
-	spin_lock_bh(&p->p_work_lock);
+	spin_lock_irqsave(&p->p_work_lock, flags);
 	thread = p->iothread;
 	p->iothread = NULL;
 
@@ -1876,7 +1877,7 @@ static int qedi_cpu_offline(unsigned int cpu)
 			kfree(work);
 	}
 
-	spin_unlock_bh(&p->p_work_lock);
+	spin_unlock_irqrestore(&p->p_work_lock, flags);
 	if (thread)
 		kthread_stop(thread);
 	return 0;
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 9c7af5e1dfb0..ca2bc3f36ff6 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -2673,7 +2673,6 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
 	case CS_PORT_BUSY:
 	case CS_INCOMPLETE:
 	case CS_PORT_UNAVAILABLE:
-	case CS_TIMEOUT:
 	case CS_RESET:
 
 		/*
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index dcd0f058f23e..35762d29b04b 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -518,7 +518,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 
 	rval = qla2x00_start_nvme_mq(sp);
 	if (rval != QLA_SUCCESS) {
-		ql_log(ql_log_warn, vha, 0x212d,
+		ql_dbg(ql_dbg_io + ql_dbg_verbose, vha, 0x212d,
 		    "qla2x00_start_nvme_mq failed = %d\n", rval);
 		atomic_dec(&sp->ref_count);
 		wake_up(&sp->nvme_ls_waitq);
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 4ba9f46fcf74..21cc9e2797a2 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -940,6 +940,11 @@ static int qla4xxx_set_chap_entry(struct Scsi_Host *shost, void *data, int len)
 	memset(&chap_rec, 0, sizeof(chap_rec));
 
 	nla_for_each_attr(attr, data, len, rem) {
+		if (nla_len(attr) < sizeof(*param_info)) {
+			rc = -EINVAL;
+			goto exit_set_chap;
+		}
+
 		param_info = nla_data(attr);
 
 		switch (param_info->param) {
@@ -2724,6 +2729,11 @@ qla4xxx_iface_set_param(struct Scsi_Host *shost, void *data, uint32_t len)
 	}
 
 	nla_for_each_attr(attr, data, len, rem) {
+		if (nla_len(attr) < sizeof(*iface_param)) {
+			rval = -EINVAL;
+			goto exit_init_fw_cb;
+		}
+
 		iface_param = nla_data(attr);
 
 		if (iface_param->param_type == ISCSI_NET_PARAM) {
@@ -8098,6 +8108,11 @@ qla4xxx_sysfs_ddb_set_param(struct iscsi_bus_flash_session *fnode_sess,
 
 	memset((void *)&chap_tbl, 0, sizeof(chap_tbl));
 	nla_for_each_attr(attr, data, len, rem) {
+		if (nla_len(attr) < sizeof(*fnode_param)) {
+			rc = -EINVAL;
+			goto exit_set_param;
+		}
+
 		fnode_param = nla_data(attr);
 
 		switch (fnode_param->param) {
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 79581771e6f6..b13d1be1b0f1 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -2765,6 +2765,10 @@ iscsi_set_param(struct iscsi_transport *transport, struct iscsi_uevent *ev)
 	if (!conn || !session)
 		return -EINVAL;
 
+	/* data will be regarded as NULL-ended string, do length check */
+	if (strlen(data) > ev->u.set_param.len)
+		return -EINVAL;
+
 	switch (ev->u.set_param.param) {
 	case ISCSI_PARAM_SESS_RECOVERY_TMO:
 		sscanf(data, "%d", &value);
@@ -2917,6 +2921,10 @@ iscsi_set_host_param(struct iscsi_transport *transport,
 		return -ENODEV;
 	}
 
+	/* see similar check in iscsi_if_set_param() */
+	if (strlen(data) > ev->u.set_host_param.len)
+		return -EINVAL;
+
 	err = transport->set_host_param(shost, ev->u.set_host_param.param,
 					data, ev->u.set_host_param.len);
 	scsi_host_put(shost);
diff --git a/drivers/soc/qcom/qmi_encdec.c b/drivers/soc/qcom/qmi_encdec.c
index 3aaab71d1b2c..dbc8b4c93190 100644
--- a/drivers/soc/qcom/qmi_encdec.c
+++ b/drivers/soc/qcom/qmi_encdec.c
@@ -534,8 +534,8 @@ static int qmi_decode_string_elem(struct qmi_elem_info *ei_array,
 		decoded_bytes += rc;
 	}
 
-	if (string_len > temp_ei->elem_len) {
-		pr_err("%s: String len %d > Max Len %d\n",
+	if (string_len >= temp_ei->elem_len) {
+		pr_err("%s: String len %d >= Max Len %d\n",
 		       __func__, string_len, temp_ei->elem_len);
 		return -ETOOSMALL;
 	} else if (string_len > tlv_len) {
diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 749288310c36..2989795272a1 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -469,7 +469,11 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 		goto exit_free_master;
 	}
 
-	tsd->irq = platform_get_irq(pdev, 0);
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		goto exit_free_master;
+	tsd->irq = ret;
+
 	ret = request_irq(tsd->irq, tegra_sflash_isr, 0,
 			dev_name(&pdev->dev), tsd);
 	if (ret < 0) {
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 83e4d9384bd2..7ccc4a18a900 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -675,6 +675,8 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 	cur = end - min_t(unsigned, offset + end - map->m_la, end);
 	if (unlikely(!(map->m_flags & EROFS_MAP_MAPPED))) {
 		zero_user_segment(page, cur, end);
+		++spiltted;
+		tight = false;
 		goto next_part;
 	}
 
diff --git a/drivers/target/iscsi/iscsi_target_configfs.c b/drivers/target/iscsi/iscsi_target_configfs.c
index d25cadc4f4f1..ac071abae7e9 100644
--- a/drivers/target/iscsi/iscsi_target_configfs.c
+++ b/drivers/target/iscsi/iscsi_target_configfs.c
@@ -516,102 +516,102 @@ static ssize_t lio_target_nacl_info_show(struct config_item *item, char *page)
 	spin_lock_bh(&se_nacl->nacl_sess_lock);
 	se_sess = se_nacl->nacl_sess;
 	if (!se_sess) {
-		rb += sprintf(page+rb, "No active iSCSI Session for Initiator"
+		rb += sysfs_emit_at(page, rb, "No active iSCSI Session for Initiator"
 			" Endpoint: %s\n", se_nacl->initiatorname);
 	} else {
 		sess = se_sess->fabric_sess_ptr;
 
-		rb += sprintf(page+rb, "InitiatorName: %s\n",
+		rb += sysfs_emit_at(page, rb, "InitiatorName: %s\n",
 			sess->sess_ops->InitiatorName);
-		rb += sprintf(page+rb, "InitiatorAlias: %s\n",
+		rb += sysfs_emit_at(page, rb, "InitiatorAlias: %s\n",
 			sess->sess_ops->InitiatorAlias);
 
-		rb += sprintf(page+rb,
+		rb += sysfs_emit_at(page, rb,
 			      "LIO Session ID: %u   ISID: 0x%6ph  TSIH: %hu  ",
 			      sess->sid, sess->isid, sess->tsih);
-		rb += sprintf(page+rb, "SessionType: %s\n",
+		rb += sysfs_emit_at(page, rb, "SessionType: %s\n",
 				(sess->sess_ops->SessionType) ?
 				"Discovery" : "Normal");
-		rb += sprintf(page+rb, "Session State: ");
+		rb += sysfs_emit_at(page, rb, "Session State: ");
 		switch (sess->session_state) {
 		case TARG_SESS_STATE_FREE:
-			rb += sprintf(page+rb, "TARG_SESS_FREE\n");
+			rb += sysfs_emit_at(page, rb, "TARG_SESS_FREE\n");
 			break;
 		case TARG_SESS_STATE_ACTIVE:
-			rb += sprintf(page+rb, "TARG_SESS_STATE_ACTIVE\n");
+			rb += sysfs_emit_at(page, rb, "TARG_SESS_STATE_ACTIVE\n");
 			break;
 		case TARG_SESS_STATE_LOGGED_IN:
-			rb += sprintf(page+rb, "TARG_SESS_STATE_LOGGED_IN\n");
+			rb += sysfs_emit_at(page, rb, "TARG_SESS_STATE_LOGGED_IN\n");
 			break;
 		case TARG_SESS_STATE_FAILED:
-			rb += sprintf(page+rb, "TARG_SESS_STATE_FAILED\n");
+			rb += sysfs_emit_at(page, rb, "TARG_SESS_STATE_FAILED\n");
 			break;
 		case TARG_SESS_STATE_IN_CONTINUE:
-			rb += sprintf(page+rb, "TARG_SESS_STATE_IN_CONTINUE\n");
+			rb += sysfs_emit_at(page, rb, "TARG_SESS_STATE_IN_CONTINUE\n");
 			break;
 		default:
-			rb += sprintf(page+rb, "ERROR: Unknown Session"
+			rb += sysfs_emit_at(page, rb, "ERROR: Unknown Session"
 					" State!\n");
 			break;
 		}
 
-		rb += sprintf(page+rb, "---------------------[iSCSI Session"
+		rb += sysfs_emit_at(page, rb, "---------------------[iSCSI Session"
 				" Values]-----------------------\n");
-		rb += sprintf(page+rb, "  CmdSN/WR  :  CmdSN/WC  :  ExpCmdSN"
+		rb += sysfs_emit_at(page, rb, "  CmdSN/WR  :  CmdSN/WC  :  ExpCmdSN"
 				"  :  MaxCmdSN  :     ITT    :     TTT\n");
 		max_cmd_sn = (u32) atomic_read(&sess->max_cmd_sn);
-		rb += sprintf(page+rb, " 0x%08x   0x%08x   0x%08x   0x%08x"
+		rb += sysfs_emit_at(page, rb, " 0x%08x   0x%08x   0x%08x   0x%08x"
 				"   0x%08x   0x%08x\n",
 			sess->cmdsn_window,
 			(max_cmd_sn - sess->exp_cmd_sn) + 1,
 			sess->exp_cmd_sn, max_cmd_sn,
 			sess->init_task_tag, sess->targ_xfer_tag);
-		rb += sprintf(page+rb, "----------------------[iSCSI"
+		rb += sysfs_emit_at(page, rb, "----------------------[iSCSI"
 				" Connections]-------------------------\n");
 
 		spin_lock(&sess->conn_lock);
 		list_for_each_entry(conn, &sess->sess_conn_list, conn_list) {
-			rb += sprintf(page+rb, "CID: %hu  Connection"
+			rb += sysfs_emit_at(page, rb, "CID: %hu  Connection"
 					" State: ", conn->cid);
 			switch (conn->conn_state) {
 			case TARG_CONN_STATE_FREE:
-				rb += sprintf(page+rb,
+				rb += sysfs_emit_at(page, rb,
 					"TARG_CONN_STATE_FREE\n");
 				break;
 			case TARG_CONN_STATE_XPT_UP:
-				rb += sprintf(page+rb,
+				rb += sysfs_emit_at(page, rb,
 					"TARG_CONN_STATE_XPT_UP\n");
 				break;
 			case TARG_CONN_STATE_IN_LOGIN:
-				rb += sprintf(page+rb,
+				rb += sysfs_emit_at(page, rb,
 					"TARG_CONN_STATE_IN_LOGIN\n");
 				break;
 			case TARG_CONN_STATE_LOGGED_IN:
-				rb += sprintf(page+rb,
+				rb += sysfs_emit_at(page, rb,
 					"TARG_CONN_STATE_LOGGED_IN\n");
 				break;
 			case TARG_CONN_STATE_IN_LOGOUT:
-				rb += sprintf(page+rb,
+				rb += sysfs_emit_at(page, rb,
 					"TARG_CONN_STATE_IN_LOGOUT\n");
 				break;
 			case TARG_CONN_STATE_LOGOUT_REQUESTED:
-				rb += sprintf(page+rb,
+				rb += sysfs_emit_at(page, rb,
 					"TARG_CONN_STATE_LOGOUT_REQUESTED\n");
 				break;
 			case TARG_CONN_STATE_CLEANUP_WAIT:
-				rb += sprintf(page+rb,
+				rb += sysfs_emit_at(page, rb,
 					"TARG_CONN_STATE_CLEANUP_WAIT\n");
 				break;
 			default:
-				rb += sprintf(page+rb,
+				rb += sysfs_emit_at(page, rb,
 					"ERROR: Unknown Connection State!\n");
 				break;
 			}
 
-			rb += sprintf(page+rb, "   Address %pISc %s", &conn->login_sockaddr,
+			rb += sysfs_emit_at(page, rb, "   Address %pISc %s", &conn->login_sockaddr,
 				(conn->network_transport == ISCSI_TCP) ?
 				"TCP" : "SCTP");
-			rb += sprintf(page+rb, "  StatSN: 0x%08x\n",
+			rb += sysfs_emit_at(page, rb, "  StatSN: 0x%08x\n",
 				conn->stat_sn);
 		}
 		spin_unlock(&sess->conn_lock);
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index ad40c75bb58f..375d4790e058 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1269,19 +1269,14 @@ static void cpm_uart_console_write(struct console *co, const char *s,
 {
 	struct uart_cpm_port *pinfo = &cpm_uart_ports[co->index];
 	unsigned long flags;
-	int nolock = oops_in_progress;
 
-	if (unlikely(nolock)) {
+	if (unlikely(oops_in_progress)) {
 		local_irq_save(flags);
-	} else {
-		spin_lock_irqsave(&pinfo->port.lock, flags);
-	}
-
-	cpm_uart_early_write(pinfo, s, count, true);
-
-	if (unlikely(nolock)) {
+		cpm_uart_early_write(pinfo, s, count, true);
 		local_irq_restore(flags);
 	} else {
+		spin_lock_irqsave(&pinfo->port.lock, flags);
+		cpm_uart_early_write(pinfo, s, count, true);
 		spin_unlock_irqrestore(&pinfo->port.lock, flags);
 	}
 }
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index ebea4a9d8e69..d4496a44abdf 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1166,9 +1166,18 @@ static int sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
 		state |= BIT(offset);
 	else
 		state &= ~BIT(offset);
-	sc16is7xx_port_write(port, SC16IS7XX_IOSTATE_REG, state);
+
+	/*
+	 * If we write IOSTATE first, and then IODIR, the output value is not
+	 * transferred to the corresponding I/O pin.
+	 * The datasheet states that each register bit will be transferred to
+	 * the corresponding I/O pin programmed as output when writing to
+	 * IOSTATE. Therefore, configure direction first with IODIR, and then
+	 * set value after with IOSTATE.
+	 */
 	sc16is7xx_port_update(port, SC16IS7XX_IODIR_REG, BIT(offset),
 			      BIT(offset));
+	sc16is7xx_port_write(port, SC16IS7XX_IOSTATE_REG, state);
 
 	return 0;
 }
@@ -1255,6 +1264,13 @@ static int sc16is7xx_probe(struct device *dev,
 		s->p[i].port.type	= PORT_SC16IS7XX;
 		s->p[i].port.fifosize	= SC16IS7XX_FIFO_SIZE;
 		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
+		s->p[i].port.iobase	= i;
+		/*
+		 * Use all ones as membase to make sure uart_configure_port() in
+		 * serial_core.c does not abort for SPI/I2C devices where the
+		 * membase address is not applicable.
+		 */
+		s->p[i].port.membase	= (void __iomem *)~0;
 		s->p[i].port.iotype	= UPIO_PORT;
 		s->p[i].port.uartclk	= freq;
 		s->p[i].port.rs485_config = sc16is7xx_config_rs485;
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 41fe45f2349e..a30f7ed12346 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -944,7 +944,11 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	tup->ier_shadow = 0;
 	tup->current_baud = 0;
 
-	clk_prepare_enable(tup->uart_clk);
+	ret = clk_prepare_enable(tup->uart_clk);
+	if (ret) {
+		dev_err(tup->uport.dev, "could not enable clk\n");
+		return ret;
+	}
 
 	/* Reset the UART controller to clear all previous status.*/
 	reset_control_assert(tup->rst);
diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 0b7b4d09785b..4f221ca7aad1 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -950,7 +950,7 @@ static void invalidate_sub(struct fsg_lun *curlun)
 {
 	struct file	*filp = curlun->filp;
 	struct inode	*inode = file_inode(filp);
-	unsigned long	rc;
+	unsigned long __maybe_unused	rc;
 
 	rc = invalidate_mapping_pages(inode->i_mapping, 0, -1);
 	VLDBG(curlun, "invalidate_mapping_pages -> %ld\n", rc);
diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index 2707be628298..cbd8d6c74c93 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -1950,9 +1950,13 @@ static void ch9getstatus(struct qe_udc *udc, u8 request_type, u16 value,
 	} else if ((request_type & USB_RECIP_MASK) == USB_RECIP_ENDPOINT) {
 		/* Get endpoint status */
 		int pipe = index & USB_ENDPOINT_NUMBER_MASK;
-		struct qe_ep *target_ep = &udc->eps[pipe];
+		struct qe_ep *target_ep;
 		u16 usep;
 
+		if (pipe >= USB_MAX_ENDPOINTS)
+			goto stall;
+		target_ep = &udc->eps[pipe];
+
 		/* stall if endpoint doesn't exist */
 		if (!target_ep->ep.desc)
 			goto stall;
diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index e5aa24c1e4fd..8af2ee3713b6 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -312,14 +312,8 @@ static void __mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool disconnect)
 
 static bool mxs_phy_is_otg_host(struct mxs_phy *mxs_phy)
 {
-	void __iomem *base = mxs_phy->phy.io_priv;
-	u32 phyctrl = readl(base + HW_USBPHY_CTRL);
-
-	if (IS_ENABLED(CONFIG_USB_OTG) &&
-			!(phyctrl & BM_USBPHY_CTRL_OTG_ID_VALUE))
-		return true;
-
-	return false;
+	return IS_ENABLED(CONFIG_USB_OTG) &&
+		mxs_phy->phy.last_event == USB_EVENT_ID;
 }
 
 static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index cf68a422e75e..a4787fcf6ba9 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -259,6 +259,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EM05G			0x030a
 #define QUECTEL_PRODUCT_EM060K			0x030b
 #define QUECTEL_PRODUCT_EM05G_CS		0x030c
+#define QUECTEL_PRODUCT_EM05GV2			0x030e
 #define QUECTEL_PRODUCT_EM05CN_SG		0x0310
 #define QUECTEL_PRODUCT_EM05G_SG		0x0311
 #define QUECTEL_PRODUCT_EM05CN			0x0312
@@ -1190,6 +1191,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(6) | ZLP },
 	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G_GR, 0xff),
 	  .driver_info = RSVD(6) | ZLP },
+	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05GV2, 0xff),
+	  .driver_info = RSVD(4) | ZLP },
 	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G_CS, 0xff),
 	  .driver_info = RSVD(6) | ZLP },
 	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G_RS, 0xff),
@@ -2232,6 +2235,10 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0db, 0xff),			/* Foxconn T99W265 MBIM */
 	  .driver_info = RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0ee, 0xff),			/* Foxconn T99W368 MBIM */
+	  .driver_info = RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0f0, 0xff),			/* Foxconn T99W373 MBIM */
+	  .driver_info = RSVD(3) },
 	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 (IOT version) */
 	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
 	{ USB_DEVICE(0x1782, 0x4d10) },						/* Fibocom L610 (AT mode) */
diff --git a/drivers/usb/typec/tcpci.c b/drivers/usb/typec/tcpci.c
index 9f98376d9bef..d1393371b6b0 100644
--- a/drivers/usb/typec/tcpci.c
+++ b/drivers/usb/typec/tcpci.c
@@ -379,6 +379,10 @@ static int tcpci_init(struct tcpc_dev *tcpc)
 	if (time_after(jiffies, timeout))
 		return -ETIMEDOUT;
 
+	ret = tcpci_write16(tcpci, TCPC_FAULT_STATUS, TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT);
+	if (ret < 0)
+		return ret;
+
 	/* Handle vendor init */
 	if (tcpci->data->init) {
 		ret = tcpci->data->init(tcpci, tcpci->data);
diff --git a/drivers/usb/typec/tcpci.h b/drivers/usb/typec/tcpci.h
index 303ebde26546..dcf60399f161 100644
--- a/drivers/usb/typec/tcpci.h
+++ b/drivers/usb/typec/tcpci.h
@@ -72,6 +72,7 @@
 #define TCPC_POWER_STATUS_VBUS_PRES	BIT(2)
 
 #define TCPC_FAULT_STATUS		0x1f
+#define TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT BIT(7)
 
 #define TCPC_COMMAND			0x23
 #define TCPC_CMD_WAKE_I2C		0x11
diff --git a/drivers/video/backlight/bd6107.c b/drivers/video/backlight/bd6107.c
index fdb2f7e2c6b5..3eaa250f10de 100644
--- a/drivers/video/backlight/bd6107.c
+++ b/drivers/video/backlight/bd6107.c
@@ -110,7 +110,7 @@ static int bd6107_backlight_check_fb(struct backlight_device *backlight,
 {
 	struct bd6107 *bd = bl_get_data(backlight);
 
-	return bd->pdata->fbdev == NULL || bd->pdata->fbdev == info->dev;
+	return bd->pdata->fbdev == NULL || bd->pdata->fbdev == info->device;
 }
 
 static const struct backlight_ops bd6107_backlight_ops = {
diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 51c49f03ed83..c2b8b6bf4fcb 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -48,7 +48,7 @@ static int gpio_backlight_check_fb(struct backlight_device *bl,
 {
 	struct gpio_backlight *gbl = bl_get_data(bl);
 
-	return gbl->fbdev == NULL || gbl->fbdev == info->dev;
+	return gbl->fbdev == NULL || gbl->fbdev == info->device;
 }
 
 static const struct backlight_ops gpio_backlight_ops = {
diff --git a/drivers/video/backlight/lv5207lp.c b/drivers/video/backlight/lv5207lp.c
index 8ab7297b118a..08aa615cb2a9 100644
--- a/drivers/video/backlight/lv5207lp.c
+++ b/drivers/video/backlight/lv5207lp.c
@@ -75,7 +75,7 @@ static int lv5207lp_backlight_check_fb(struct backlight_device *backlight,
 {
 	struct lv5207lp *lv = bl_get_data(backlight);
 
-	return lv->pdata->fbdev == NULL || lv->pdata->fbdev == info->dev;
+	return lv->pdata->fbdev == NULL || lv->pdata->fbdev == info->device;
 }
 
 static const struct backlight_ops lv5207lp_backlight_ops = {
diff --git a/drivers/video/fbdev/ep93xx-fb.c b/drivers/video/fbdev/ep93xx-fb.c
index 75f0db25d19f..e81593a93d23 100644
--- a/drivers/video/fbdev/ep93xx-fb.c
+++ b/drivers/video/fbdev/ep93xx-fb.c
@@ -478,7 +478,6 @@ static int ep93xxfb_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENOMEM;
 
-	info->dev = &pdev->dev;
 	platform_set_drvdata(pdev, info);
 	fbi = info->par;
 	fbi->mach_info = mach_info;
diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index 72c108a12c19..0dec3fba02b9 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -186,3 +186,4 @@ module_platform_driver(mid_wdt_driver);
 MODULE_AUTHOR("David Cohen <david.a.cohen@linux.intel.com>");
 MODULE_DESCRIPTION("Watchdog Driver for Intel MID platform");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:intel_mid_wdt");
diff --git a/fs/attr.c b/fs/attr.c
index 4d2541c1e68c..f064f08f5194 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -256,9 +256,25 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 	}
 
 	if ((ia_valid & ATTR_MODE)) {
-		umode_t amode = attr->ia_mode;
+		/*
+		 * Don't allow changing the mode of symlinks:
+		 *
+		 * (1) The vfs doesn't take the mode of symlinks into account
+		 *     during permission checking.
+		 * (2) This has never worked correctly. Most major filesystems
+		 *     did return EOPNOTSUPP due to interactions with POSIX ACLs
+		 *     but did still updated the mode of the symlink.
+		 *     This inconsistency led system call wrapper providers such
+		 *     as libc to block changing the mode of symlinks with
+		 *     EOPNOTSUPP already.
+		 * (3) To even do this in the first place one would have to use
+		 *     specific file descriptors and quite some effort.
+		 */
+		if (S_ISLNK(inode->i_mode))
+			return -EOPNOTSUPP;
+
 		/* Flag setting protected by i_mutex */
-		if (is_sxid(amode))
+		if (is_sxid(attr->ia_mode))
 			inode->i_flags &= ~S_NOSEC;
 	}
 
diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index f6385c6ef0a5..44ba0cd4ebc4 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -35,8 +35,9 @@ void autofs_catatonic_mode(struct autofs_sb_info *sbi)
 		wq->status = -ENOENT; /* Magic is gone - report failure */
 		kfree(wq->name.name);
 		wq->name.name = NULL;
-		wq->wait_ctr--;
 		wake_up_interruptible(&wq->queue);
+		if (!--wq->wait_ctr)
+			kfree(wq);
 		wq = nwq;
 	}
 	fput(sbi->pipe);	/* Close the pipe */
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 1fbe2dee1e70..469a90b07d3f 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1171,20 +1171,33 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 		ret = __btrfs_commit_inode_delayed_items(trans, path,
 							 curr_node);
 		if (ret) {
-			btrfs_release_delayed_node(curr_node);
-			curr_node = NULL;
 			btrfs_abort_transaction(trans, ret);
 			break;
 		}
 
 		prev_node = curr_node;
 		curr_node = btrfs_next_delayed_node(curr_node);
+		/*
+		 * See the comment below about releasing path before releasing
+		 * node. If the commit of delayed items was successful the path
+		 * should always be released, but in case of an error, it may
+		 * point to locked extent buffers (a leaf at the very least).
+		 */
+		ASSERT(path->nodes[0] == NULL);
 		btrfs_release_delayed_node(prev_node);
 	}
 
+	/*
+	 * Release the path to avoid a potential deadlock and lockdep splat when
+	 * releasing the delayed node, as that requires taking the delayed node's
+	 * mutex. If another task starts running delayed items before we take
+	 * the mutex, it will first lock the mutex and then it may try to lock
+	 * the same btree path (leaf).
+	 */
+	btrfs_free_path(path);
+
 	if (curr_node)
 		btrfs_release_delayed_node(curr_node);
-	btrfs_free_path(path);
 	trans->block_rsv = block_rsv;
 
 	return ret;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d71f800e8bf6..bb05b0a82c8b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1549,6 +1549,11 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
 		err = -ENOENT;
 		goto out;
 	} else if (WARN_ON(ret)) {
+		btrfs_print_leaf(path->nodes[0]);
+		btrfs_err(fs_info,
+"extent item not found for insert, bytenr %llu num_bytes %llu parent %llu root_objectid %llu owner %llu offset %llu",
+			  bytenr, num_bytes, parent, root_objectid, owner,
+			  offset);
 		err = -EIO;
 		goto out;
 	}
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 1f31861453d9..a34c0436ebb1 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -200,10 +200,11 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	spin_unlock(&fs_info->trans_lock);
 
 	/*
-	 * If we are ATTACH, we just want to catch the current transaction,
-	 * and commit it. If there is no transaction, just return ENOENT.
+	 * If we are ATTACH or TRANS_JOIN_NOSTART, we just want to catch the
+	 * current transaction, and commit it. If there is no transaction, just
+	 * return ENOENT.
 	 */
-	if (type == TRANS_ATTACH)
+	if (type == TRANS_ATTACH || type == TRANS_JOIN_NOSTART)
 		return -ENOENT;
 
 	/*
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 52b1524b40cd..ef1a43f4bd66 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -663,11 +663,6 @@ cifs_get_root(struct smb_vol *vol, struct super_block *sb)
 		struct inode *dir = d_inode(dentry);
 		struct dentry *child;
 
-		if (!dir) {
-			dput(dentry);
-			dentry = ERR_PTR(-ENOENT);
-			break;
-		}
 		if (!S_ISDIR(dir->i_mode)) {
 			dput(dentry);
 			dentry = ERR_PTR(-ENOTDIR);
@@ -684,7 +679,7 @@ cifs_get_root(struct smb_vol *vol, struct super_block *sb)
 		while (*s && *s != sep)
 			s++;
 
-		child = lookup_one_len_unlocked(p, dentry, s - p);
+		child = lookup_positive_unlocked(p, dentry, s - p);
 		dput(dentry);
 		dentry = child;
 	} while (!IS_ERR(dentry));
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index c07dcb2af2eb..01ab4496cb89 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -79,6 +79,7 @@ smb2_add_credits(struct TCP_Server_Info *server, const unsigned int add,
 		*val = 65000; /* Don't get near 64K credits, avoid srv bugs */
 		printk_once(KERN_WARNING "server overflowed SMB3 credits\n");
 	}
+	WARN_ON_ONCE(server->in_flight == 0);
 	server->in_flight--;
 	if (server->in_flight == 0 && (optype & CIFS_OP_MASK) != CIFS_NEG_OP)
 		rc = change_conf(server);
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 4661ecaf6741..1e4ae78f64a8 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -275,13 +275,9 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
 	if (!parent)
 		parent = debugfs_mount->mnt_root;
 
-	dentry = lookup_one_len_unlocked(name, parent, strlen(name));
+	dentry = lookup_positive_unlocked(name, parent, strlen(name));
 	if (IS_ERR(dentry))
 		return NULL;
-	if (!d_really_is_positive(dentry)) {
-		dput(dentry);
-		return NULL;
-	}
 	return dentry;
 }
 EXPORT_SYMBOL_GPL(debugfs_lookup);
diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 0501821182b1..c6079f6c6a79 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -469,7 +469,8 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 		}
 	} else {
 		list_for_each_entry(iter, &recv_list, list) {
-			if (!iter->info.wait) {
+			if (!iter->info.wait &&
+			    iter->info.fsid == info.fsid) {
 				op = iter;
 				break;
 			}
@@ -481,8 +482,7 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 		if (info.wait)
 			WARN_ON(op->info.optype != DLM_PLOCK_OP_LOCK);
 		else
-			WARN_ON(op->info.fsid != info.fsid ||
-				op->info.number != info.number ||
+			WARN_ON(op->info.number != info.number ||
 				op->info.owner != info.owner ||
 				op->info.optype != info.optype);
 
diff --git a/fs/eventfd.c b/fs/eventfd.c
index ce1d1711fbba..66864100b823 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -174,11 +174,14 @@ static __poll_t eventfd_poll(struct file *file, poll_table *wait)
 	return events;
 }
 
-static void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
+void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
 {
-	*cnt = (ctx->flags & EFD_SEMAPHORE) ? 1 : ctx->count;
+	lockdep_assert_held(&ctx->wqh.lock);
+
+	*cnt = ((ctx->flags & EFD_SEMAPHORE) && ctx->count) ? 1 : ctx->count;
 	ctx->count -= *cnt;
 }
+EXPORT_SYMBOL_GPL(eventfd_ctx_do_read);
 
 /**
  * eventfd_ctx_remove_wait_queue - Read the current counter and removes wait queue.
diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index bd1d68ff3a9f..437175bce22e 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -664,10 +664,10 @@ ext2_xattr_set2(struct inode *inode, struct buffer_head *old_bh,
 			/* We need to allocate a new block */
 			ext2_fsblk_t goal = ext2_group_first_block_no(sb,
 						EXT2_I(inode)->i_block_group);
-			int block = ext2_new_block(inode, goal, &error);
+			ext2_fsblk_t block = ext2_new_block(inode, goal, &error);
 			if (error)
 				goto cleanup;
-			ea_idebug(inode, "creating block %d", block);
+			ea_idebug(inode, "creating block %lu", block);
 
 			new_bh = sb_getblk(sb, block);
 			if (unlikely(!new_bh)) {
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 63ad6b1d575a..b20fffc8b4c1 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -282,6 +282,7 @@ int dbUnmount(struct inode *ipbmap, int mounterror)
 
 	/* free the memory for the in-memory bmap. */
 	kfree(bmp);
+	JFS_SBI(ipbmap->i_sb)->bmap = NULL;
 
 	return (0);
 }
diff --git a/fs/jfs/jfs_extent.c b/fs/jfs/jfs_extent.c
index 2ae7d59ab10a..c971e8a6525d 100644
--- a/fs/jfs/jfs_extent.c
+++ b/fs/jfs/jfs_extent.c
@@ -521,6 +521,11 @@ extBalloc(struct inode *ip, s64 hint, s64 * nblocks, s64 * blkno)
 	 * blocks in the map. in that case, we'll start off with the
 	 * maximum free.
 	 */
+
+	/* give up if no space left */
+	if (bmp->db_maxfreebud == -1)
+		return -ENOSPC;
+
 	max = (s64) 1 << bmp->db_maxfreebud;
 	if (*nblocks >= max && *nblocks > nbperpage)
 		nb = nblks = (max > nbperpage) ? max : nbperpage;
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 93e8c590ff5c..7565e00e8818 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -208,6 +208,7 @@ int diUnmount(struct inode *ipimap, int mounterror)
 	 * free in-memory control structure
 	 */
 	kfree(imap);
+	JFS_IP(ipimap)->i_imap = NULL;
 
 	return (0);
 }
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 0b22c39dad47..b2a126a947e3 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -212,7 +212,7 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 			dput(dentry);
 			return ERR_PTR(-EINVAL);
 		}
-		dtmp = lookup_one_len_unlocked(kntmp->name, dentry,
+		dtmp = lookup_positive_unlocked(kntmp->name, dentry,
 					       strlen(kntmp->name));
 		dput(dentry);
 		if (IS_ERR(dtmp))
diff --git a/fs/lockd/mon.c b/fs/lockd/mon.c
index 654594ef4f94..68a2eac548c3 100644
--- a/fs/lockd/mon.c
+++ b/fs/lockd/mon.c
@@ -275,6 +275,9 @@ static struct nsm_handle *nsm_create_handle(const struct sockaddr *sap,
 {
 	struct nsm_handle *new;
 
+	if (!hostname)
+		return NULL;
+
 	new = kzalloc(sizeof(*new) + hostname_len + 1, GFP_KERNEL);
 	if (unlikely(new == NULL))
 		return NULL;
diff --git a/fs/namei.c b/fs/namei.c
index 9e8fca598acc..60b57e0bc174 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2575,6 +2575,26 @@ struct dentry *lookup_one_len_unlocked(const char *name,
 }
 EXPORT_SYMBOL(lookup_one_len_unlocked);
 
+/*
+ * Like lookup_one_len_unlocked(), except that it yields ERR_PTR(-ENOENT)
+ * on negatives.  Returns known positive or ERR_PTR(); that's what
+ * most of the users want.  Note that pinned negative with unlocked parent
+ * _can_ become positive at any time, so callers of lookup_one_len_unlocked()
+ * need to be very careful; pinned positives have ->d_inode stable, so
+ * this one avoids such problems.
+ */
+struct dentry *lookup_positive_unlocked(const char *name,
+				       struct dentry *base, int len)
+{
+	struct dentry *ret = lookup_one_len_unlocked(name, base, len);
+	if (!IS_ERR(ret) && d_is_negative(ret)) {
+		dput(ret);
+		ret = ERR_PTR(-ENOENT);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(lookup_positive_unlocked);
+
 #ifdef CONFIG_UNIX98_PTYS
 int path_pts(struct path *path)
 {
@@ -2593,7 +2613,7 @@ int path_pts(struct path *path)
 	this.name = "pts";
 	this.len = 3;
 	child = d_hash_and_lookup(parent, &this);
-	if (!child)
+	if (IS_ERR_OR_NULL(child))
 		return -ENOENT;
 
 	path->dentry = child;
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index dec5880ac6de..6e3a14fdff9c 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -422,7 +422,7 @@ bl_parse_concat(struct nfs_server *server, struct pnfs_block_dev *d,
 	int ret, i;
 
 	d->children = kcalloc(v->concat.volumes_count,
-			sizeof(struct pnfs_block_dev), GFP_KERNEL);
+			sizeof(struct pnfs_block_dev), gfp_mask);
 	if (!d->children)
 		return -ENOMEM;
 
@@ -451,7 +451,7 @@ bl_parse_stripe(struct nfs_server *server, struct pnfs_block_dev *d,
 	int ret, i;
 
 	d->children = kcalloc(v->stripe.volumes_count,
-			sizeof(struct pnfs_block_dev), GFP_KERNEL);
+			sizeof(struct pnfs_block_dev), gfp_mask);
 	if (!d->children)
 		return -ENOMEM;
 
diff --git a/fs/nfs/pnfs_dev.c b/fs/nfs/pnfs_dev.c
index e8a07b3f9aaa..ba67906d6b2c 100644
--- a/fs/nfs/pnfs_dev.c
+++ b/fs/nfs/pnfs_dev.c
@@ -152,7 +152,7 @@ nfs4_get_device_info(struct nfs_server *server,
 		set_bit(NFS_DEVICEID_NOCACHE, &d->flags);
 
 out_free_pages:
-	for (i = 0; i < max_pages; i++)
+	while (--i >= 0)
 		__free_page(pages[i]);
 	kfree(pages);
 out_free_pdev:
diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index 442543304930..2455dc8be18a 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -82,6 +82,15 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
 	int len = sizeof(__be32), ret, i;
 	__be32 *p;
 
+	/*
+	 * See paragraph 5 of RFC 8881 S18.40.3.
+	 */
+	if (!gdp->gd_maxcount) {
+		if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
+			return nfserr_resource;
+		return nfs_ok;
+	}
+
 	p = xdr_reserve_space(xdr, len + sizeof(__be32));
 	if (!p)
 		return nfserr_resource;
diff --git a/fs/nfsd/flexfilelayoutxdr.c b/fs/nfsd/flexfilelayoutxdr.c
index e81d2a5cf381..bb205328e043 100644
--- a/fs/nfsd/flexfilelayoutxdr.c
+++ b/fs/nfsd/flexfilelayoutxdr.c
@@ -85,6 +85,15 @@ nfsd4_ff_encode_getdeviceinfo(struct xdr_stream *xdr,
 	int addr_len;
 	__be32 *p;
 
+	/*
+	 * See paragraph 5 of RFC 8881 S18.40.3.
+	 */
+	if (!gdp->gd_maxcount) {
+		if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
+			return nfserr_resource;
+		return nfs_ok;
+	}
+
 	/* len + padding for two strings */
 	addr_len = 16 + da->netaddr.netid_len + da->netaddr.addr_len;
 	ver_len = 20;
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index b90bea1c434e..9f537decdd9c 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -855,13 +855,11 @@ compose_entry_fh(struct nfsd3_readdirres *cd, struct svc_fh *fhp,
 		} else
 			dchild = dget(dparent);
 	} else
-		dchild = lookup_one_len_unlocked(name, dparent, namlen);
+		dchild = lookup_positive_unlocked(name, dparent, namlen);
 	if (IS_ERR(dchild))
 		return rv;
 	if (d_mountpoint(dchild))
 		goto out;
-	if (d_really_is_negative(dchild))
-		goto out;
 	if (dchild->d_inode->i_ino != ino)
 		goto out;
 	rv = fh_compose(fhp, exp, dchild, &cd->fh);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a696a9b90786..5ec90b252b6a 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -870,8 +870,8 @@ nfsd4_rename(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			     rename->rn_tname, rename->rn_tnamelen);
 	if (status)
 		return status;
-	set_change_info(&rename->rn_sinfo, &cstate->current_fh);
-	set_change_info(&rename->rn_tinfo, &cstate->save_fh);
+	set_change_info(&rename->rn_sinfo, &cstate->save_fh);
+	set_change_info(&rename->rn_tinfo, &cstate->current_fh);
 	return nfs_ok;
 }
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 74ab20c89e75..33827cdd8066 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2984,18 +2984,9 @@ nfsd4_encode_dirent_fattr(struct xdr_stream *xdr, struct nfsd4_readdir *cd,
 	__be32 nfserr;
 	int ignore_crossmnt = 0;
 
-	dentry = lookup_one_len_unlocked(name, cd->rd_fhp->fh_dentry, namlen);
+	dentry = lookup_positive_unlocked(name, cd->rd_fhp->fh_dentry, namlen);
 	if (IS_ERR(dentry))
 		return nfserrno(PTR_ERR(dentry));
-	if (d_really_is_negative(dentry)) {
-		/*
-		 * we're not holding the i_mutex here, so there's
-		 * a window where this directory entry could have gone
-		 * away.
-		 */
-		dput(dentry);
-		return nfserr_noent;
-	}
 
 	exp_get(exp);
 	/*
@@ -4135,20 +4126,17 @@ nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 	*p++ = cpu_to_be32(gdev->gd_layout_type);
 
-	/* If maxcount is 0 then just update notifications */
-	if (gdev->gd_maxcount != 0) {
-		ops = nfsd4_layout_ops[gdev->gd_layout_type];
-		nfserr = ops->encode_getdeviceinfo(xdr, gdev);
-		if (nfserr) {
-			/*
-			 * We don't bother to burden the layout drivers with
-			 * enforcing gd_maxcount, just tell the client to
-			 * come back with a bigger buffer if it's not enough.
-			 */
-			if (xdr->buf->len + 4 > gdev->gd_maxcount)
-				goto toosmall;
-			return nfserr;
-		}
+	ops = nfsd4_layout_ops[gdev->gd_layout_type];
+	nfserr = ops->encode_getdeviceinfo(xdr, gdev);
+	if (nfserr) {
+		/*
+		 * We don't bother to burden the layout drivers with
+		 * enforcing gd_maxcount, just tell the client to
+		 * come back with a bigger buffer if it's not enough.
+		 */
+		if (xdr->buf->len + 4 > gdev->gd_maxcount)
+			goto toosmall;
+		return nfserr;
 	}
 
 	if (gdev->gd_notify_types) {
diff --git a/fs/nilfs2/alloc.c b/fs/nilfs2/alloc.c
index 235b959fc2b3..bbd82f650e93 100644
--- a/fs/nilfs2/alloc.c
+++ b/fs/nilfs2/alloc.c
@@ -205,7 +205,8 @@ static int nilfs_palloc_get_block(struct inode *inode, unsigned long blkoff,
 	int ret;
 
 	spin_lock(lock);
-	if (prev->bh && blkoff == prev->blkoff) {
+	if (prev->bh && blkoff == prev->blkoff &&
+	    likely(buffer_uptodate(prev->bh))) {
 		get_bh(prev->bh);
 		*bhp = prev->bh;
 		spin_unlock(lock);
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 4eed9500f33a..ea94dc21af0c 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -1036,7 +1036,7 @@ int nilfs_load_inode_block(struct inode *inode, struct buffer_head **pbh)
 	int err;
 
 	spin_lock(&nilfs->ns_inode_lock);
-	if (ii->i_bh == NULL) {
+	if (ii->i_bh == NULL || unlikely(!buffer_uptodate(ii->i_bh))) {
 		spin_unlock(&nilfs->ns_inode_lock);
 		err = nilfs_ifile_get_inode_block(ii->i_root->ifile,
 						  inode->i_ino, pbh);
@@ -1045,7 +1045,10 @@ int nilfs_load_inode_block(struct inode *inode, struct buffer_head **pbh)
 		spin_lock(&nilfs->ns_inode_lock);
 		if (ii->i_bh == NULL)
 			ii->i_bh = *pbh;
-		else {
+		else if (unlikely(!buffer_uptodate(ii->i_bh))) {
+			__brelse(ii->i_bh);
+			ii->i_bh = *pbh;
+		} else {
 			brelse(*pbh);
 			*pbh = ii->i_bh;
 		}
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 04e1e671b613..fdcbed6ee832 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -730,6 +730,11 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 		struct page *page = pvec.pages[i];
 
 		lock_page(page);
+		if (unlikely(page->mapping != mapping)) {
+			/* Exclude pages removed from the address space */
+			unlock_page(page);
+			continue;
+		}
 		if (!page_has_buffers(page))
 			create_empty_buffers(page, i_blocksize(inode), 0);
 		unlock_page(page);
diff --git a/fs/nls/nls_base.c b/fs/nls/nls_base.c
index 52ccd34b1e79..a026dbd3593f 100644
--- a/fs/nls/nls_base.c
+++ b/fs/nls/nls_base.c
@@ -272,7 +272,7 @@ int unregister_nls(struct nls_table * nls)
 	return -EINVAL;
 }
 
-static struct nls_table *find_nls(char *charset)
+static struct nls_table *find_nls(const char *charset)
 {
 	struct nls_table *nls;
 	spin_lock(&nls_lock);
@@ -288,7 +288,7 @@ static struct nls_table *find_nls(char *charset)
 	return nls;
 }
 
-struct nls_table *load_nls(char *charset)
+struct nls_table *load_nls(const char *charset)
 {
 	return try_then_request_module(find_nls(charset), "nls_%s", charset);
 }
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index bd8d742adf65..bb8483510327 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -1538,6 +1538,10 @@ static int ocfs2_rename(struct inode *old_dir,
 		status = ocfs2_add_entry(handle, new_dentry, old_inode,
 					 OCFS2_I(old_inode)->ip_blkno,
 					 new_dir_bh, &target_insert);
+		if (status < 0) {
+			mlog_errno(status);
+			goto bail;
+		}
 	}
 
 	old_inode->i_ctime = current_time(old_inode);
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index badf039267a2..e51dc7f16596 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -203,7 +203,7 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 	int err;
 	bool last_element = !post[0];
 
-	this = lookup_one_len_unlocked(name, base, namelen);
+	this = lookup_positive_unlocked(name, base, namelen);
 	if (IS_ERR(this)) {
 		err = PTR_ERR(this);
 		this = NULL;
@@ -211,8 +211,6 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 			goto out;
 		goto out_err;
 	}
-	if (!this->d_inode)
-		goto put_and_out;
 
 	if (ovl_dentry_weird(this)) {
 		/* Don't support traversing automounts and other weirdness */
@@ -654,7 +652,7 @@ struct dentry *ovl_get_index_fh(struct ovl_fs *ofs, struct ovl_fh *fh)
 	if (err)
 		return ERR_PTR(err);
 
-	index = lookup_one_len_unlocked(name.name, ofs->indexdir, name.len);
+	index = lookup_positive_unlocked(name.name, ofs->indexdir, name.len);
 	kfree(name.name);
 	if (IS_ERR(index)) {
 		if (PTR_ERR(index) == -ENOENT)
@@ -662,9 +660,7 @@ struct dentry *ovl_get_index_fh(struct ovl_fs *ofs, struct ovl_fh *fh)
 		return index;
 	}
 
-	if (d_is_negative(index))
-		err = 0;
-	else if (ovl_is_whiteout(index))
+	if (ovl_is_whiteout(index))
 		err = -ESTALE;
 	else if (ovl_dentry_weird(index))
 		err = -EIO;
@@ -688,7 +684,7 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
 	if (err)
 		return ERR_PTR(err);
 
-	index = lookup_one_len_unlocked(name.name, ofs->indexdir, name.len);
+	index = lookup_positive_unlocked(name.name, ofs->indexdir, name.len);
 	if (IS_ERR(index)) {
 		err = PTR_ERR(index);
 		if (err == -ENOENT) {
@@ -703,9 +699,7 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
 	}
 
 	inode = d_inode(index);
-	if (d_is_negative(index)) {
-		goto out_dput;
-	} else if (ovl_is_whiteout(index) && !verify) {
+	if (ovl_is_whiteout(index) && !verify) {
 		/*
 		 * When index lookup is called with !verify for decoding an
 		 * overlay file handle, a whiteout index implies that decode
@@ -1134,7 +1128,7 @@ bool ovl_lower_positive(struct dentry *dentry)
 		struct dentry *this;
 		struct dentry *lowerdir = poe->lowerstack[i].dentry;
 
-		this = lookup_one_len_unlocked(name->name, lowerdir,
+		this = lookup_positive_unlocked(name->name, lowerdir,
 					       name->len);
 		if (IS_ERR(this)) {
 			switch (PTR_ERR(this)) {
@@ -1151,10 +1145,8 @@ bool ovl_lower_positive(struct dentry *dentry)
 				break;
 			}
 		} else {
-			if (this->d_inode) {
-				positive = !ovl_is_whiteout(this);
-				done = true;
-			}
+			positive = !ovl_is_whiteout(this);
+			done = true;
 			dput(this);
 		}
 	}
diff --git a/fs/proc/base.c b/fs/proc/base.c
index e3f10c110b74..69f48794b550 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3338,7 +3338,8 @@ static int proc_tid_comm_permission(struct inode *inode, int mask)
 }
 
 static const struct inode_operations proc_tid_comm_inode_operations = {
-		.permission = proc_tid_comm_permission,
+		.setattr	= proc_setattr,
+		.permission	= proc_tid_comm_permission,
 };
 
 /*
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 60dff7180412..efb765b8466f 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -500,7 +500,7 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
 	sig ^= PERSISTENT_RAM_SIG;
 
 	if (prz->buffer->sig == sig) {
-		if (buffer_size(prz) == 0) {
+		if (buffer_size(prz) == 0 && buffer_start(prz) == 0) {
 			pr_debug("found existing empty buffer\n");
 			return 0;
 		}
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 303987d29b9c..25bd1fdaebac 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -223,19 +223,33 @@ static void put_quota_format(struct quota_format_type *fmt)
 
 /*
  * Dquot List Management:
- * The quota code uses three lists for dquot management: the inuse_list,
- * free_dquots, and dquot_hash[] array. A single dquot structure may be
- * on all three lists, depending on its current state.
+ * The quota code uses five lists for dquot management: the inuse_list,
+ * releasing_dquots, free_dquots, dqi_dirty_list, and dquot_hash[] array.
+ * A single dquot structure may be on some of those lists, depending on
+ * its current state.
  *
  * All dquots are placed to the end of inuse_list when first created, and this
  * list is used for invalidate operation, which must look at every dquot.
  *
+ * When the last reference of a dquot will be dropped, the dquot will be
+ * added to releasing_dquots. We'd then queue work item which would call
+ * synchronize_srcu() and after that perform the final cleanup of all the
+ * dquots on the list. Both releasing_dquots and free_dquots use the
+ * dq_free list_head in the dquot struct. When a dquot is removed from
+ * releasing_dquots, a reference count is always subtracted, and if
+ * dq_count == 0 at that point, the dquot will be added to the free_dquots.
+ *
  * Unused dquots (dq_count == 0) are added to the free_dquots list when freed,
  * and this list is searched whenever we need an available dquot.  Dquots are
  * removed from the list as soon as they are used again, and
  * dqstats.free_dquots gives the number of dquots on the list. When
  * dquot is invalidated it's completely released from memory.
  *
+ * Dirty dquots are added to the dqi_dirty_list of quota_info when mark
+ * dirtied, and this list is searched when writing dirty dquots back to
+ * quota file. Note that some filesystems do dirty dquot tracking on their
+ * own (e.g. in a journal) and thus don't use dqi_dirty_list.
+ *
  * Dquots with a specific identity (device, type and id) are placed on
  * one of the dquot_hash[] hash chains. The provides an efficient search
  * mechanism to locate a specific dquot.
@@ -243,6 +257,7 @@ static void put_quota_format(struct quota_format_type *fmt)
 
 static LIST_HEAD(inuse_list);
 static LIST_HEAD(free_dquots);
+static LIST_HEAD(releasing_dquots);
 static unsigned int dq_hash_bits, dq_hash_mask;
 static struct hlist_head *dquot_hash;
 
@@ -253,6 +268,9 @@ static qsize_t inode_get_rsv_space(struct inode *inode);
 static qsize_t __inode_get_rsv_space(struct inode *inode);
 static int __dquot_initialize(struct inode *inode, int type);
 
+static void quota_release_workfn(struct work_struct *work);
+static DECLARE_DELAYED_WORK(quota_release_work, quota_release_workfn);
+
 static inline unsigned int
 hashfn(const struct super_block *sb, struct kqid qid)
 {
@@ -300,12 +318,18 @@ static inline void put_dquot_last(struct dquot *dquot)
 	dqstats_inc(DQST_FREE_DQUOTS);
 }
 
+static inline void put_releasing_dquots(struct dquot *dquot)
+{
+	list_add_tail(&dquot->dq_free, &releasing_dquots);
+}
+
 static inline void remove_free_dquot(struct dquot *dquot)
 {
 	if (list_empty(&dquot->dq_free))
 		return;
 	list_del_init(&dquot->dq_free);
-	dqstats_dec(DQST_FREE_DQUOTS);
+	if (!atomic_read(&dquot->dq_count))
+		dqstats_dec(DQST_FREE_DQUOTS);
 }
 
 static inline void put_inuse(struct dquot *dquot)
@@ -331,6 +355,11 @@ static void wait_on_dquot(struct dquot *dquot)
 	mutex_unlock(&dquot->dq_lock);
 }
 
+static inline int dquot_active(struct dquot *dquot)
+{
+	return test_bit(DQ_ACTIVE_B, &dquot->dq_flags);
+}
+
 static inline int dquot_dirty(struct dquot *dquot)
 {
 	return test_bit(DQ_MOD_B, &dquot->dq_flags);
@@ -346,14 +375,14 @@ int dquot_mark_dquot_dirty(struct dquot *dquot)
 {
 	int ret = 1;
 
-	if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
+	if (!dquot_active(dquot))
 		return 0;
 
 	if (sb_dqopt(dquot->dq_sb)->flags & DQUOT_NOLIST_DIRTY)
 		return test_and_set_bit(DQ_MOD_B, &dquot->dq_flags);
 
 	/* If quota is dirty already, we don't have to acquire dq_list_lock */
-	if (test_bit(DQ_MOD_B, &dquot->dq_flags))
+	if (dquot_dirty(dquot))
 		return 1;
 
 	spin_lock(&dq_list_lock);
@@ -432,7 +461,7 @@ int dquot_acquire(struct dquot *dquot)
 	smp_mb__before_atomic();
 	set_bit(DQ_READ_B, &dquot->dq_flags);
 	/* Instantiate dquot if needed */
-	if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags) && !dquot->dq_off) {
+	if (!dquot_active(dquot) && !dquot->dq_off) {
 		ret = dqopt->ops[dquot->dq_id.type]->commit_dqblk(dquot);
 		/* Write the info if needed */
 		if (info_dirty(&dqopt->info[dquot->dq_id.type])) {
@@ -471,7 +500,7 @@ int dquot_commit(struct dquot *dquot)
 		goto out_lock;
 	/* Inactive dquot can be only if there was error during read/init
 	 * => we have better not writing it */
-	if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
+	if (dquot_active(dquot))
 		ret = dqopt->ops[dquot->dq_id.type]->commit_dqblk(dquot);
 	else
 		ret = -EIO;
@@ -532,6 +561,8 @@ static void invalidate_dquots(struct super_block *sb, int type)
 	struct dquot *dquot, *tmp;
 
 restart:
+	flush_delayed_work(&quota_release_work);
+
 	spin_lock(&dq_list_lock);
 	list_for_each_entry_safe(dquot, tmp, &inuse_list, dq_inuse) {
 		if (dquot->dq_sb != sb)
@@ -540,6 +571,12 @@ static void invalidate_dquots(struct super_block *sb, int type)
 			continue;
 		/* Wait for dquot users */
 		if (atomic_read(&dquot->dq_count)) {
+			/* dquot in releasing_dquots, flush and retry */
+			if (!list_empty(&dquot->dq_free)) {
+				spin_unlock(&dq_list_lock);
+				goto restart;
+			}
+
 			atomic_inc(&dquot->dq_count);
 			spin_unlock(&dq_list_lock);
 			/*
@@ -582,14 +619,13 @@ int dquot_scan_active(struct super_block *sb,
 
 	spin_lock(&dq_list_lock);
 	list_for_each_entry(dquot, &inuse_list, dq_inuse) {
-		if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
+		if (!dquot_active(dquot))
 			continue;
 		if (dquot->dq_sb != sb)
 			continue;
 		/* Now we have active dquot so we can just increase use count */
 		atomic_inc(&dquot->dq_count);
 		spin_unlock(&dq_list_lock);
-		dqstats_inc(DQST_LOOKUPS);
 		dqput(old_dquot);
 		old_dquot = dquot;
 		/*
@@ -598,7 +634,7 @@ int dquot_scan_active(struct super_block *sb,
 		 * outstanding call and recheck the DQ_ACTIVE_B after that.
 		 */
 		wait_on_dquot(dquot);
-		if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
+		if (dquot_active(dquot)) {
 			ret = fn(dquot, priv);
 			if (ret < 0)
 				goto out;
@@ -614,6 +650,18 @@ int dquot_scan_active(struct super_block *sb,
 }
 EXPORT_SYMBOL(dquot_scan_active);
 
+static inline int dquot_write_dquot(struct dquot *dquot)
+{
+	int ret = dquot->dq_sb->dq_op->write_dquot(dquot);
+	if (ret < 0) {
+		quota_error(dquot->dq_sb, "Can't write quota structure "
+			    "(error %d). Quota may get out of sync!", ret);
+		/* Clear dirty bit anyway to avoid infinite loop. */
+		clear_dquot_dirty(dquot);
+	}
+	return ret;
+}
+
 /* Write all dquot structures to quota files */
 int dquot_writeback_dquots(struct super_block *sb, int type)
 {
@@ -637,24 +685,16 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
 			dquot = list_first_entry(&dirty, struct dquot,
 						 dq_dirty);
 
-			WARN_ON(!test_bit(DQ_ACTIVE_B, &dquot->dq_flags));
+			WARN_ON(!dquot_active(dquot));
 
 			/* Now we have active dquot from which someone is
  			 * holding reference so we can safely just increase
 			 * use count */
 			dqgrab(dquot);
 			spin_unlock(&dq_list_lock);
-			dqstats_inc(DQST_LOOKUPS);
-			err = sb->dq_op->write_dquot(dquot);
-			if (err) {
-				/*
-				 * Clear dirty bit anyway to avoid infinite
-				 * loop here.
-				 */
-				clear_dquot_dirty(dquot);
-				if (!ret)
-					ret = err;
-			}
+			err = dquot_write_dquot(dquot);
+			if (err && !ret)
+				ret = err;
 			dqput(dquot);
 			spin_lock(&dq_list_lock);
 		}
@@ -747,13 +787,54 @@ static struct shrinker dqcache_shrinker = {
 	.seeks = DEFAULT_SEEKS,
 };
 
+/*
+ * Safely release dquot and put reference to dquot.
+ */
+static void quota_release_workfn(struct work_struct *work)
+{
+	struct dquot *dquot;
+	struct list_head rls_head;
+
+	spin_lock(&dq_list_lock);
+	/* Exchange the list head to avoid livelock. */
+	list_replace_init(&releasing_dquots, &rls_head);
+	spin_unlock(&dq_list_lock);
+
+restart:
+	synchronize_srcu(&dquot_srcu);
+	spin_lock(&dq_list_lock);
+	while (!list_empty(&rls_head)) {
+		dquot = list_first_entry(&rls_head, struct dquot, dq_free);
+		/* Dquot got used again? */
+		if (atomic_read(&dquot->dq_count) > 1) {
+			remove_free_dquot(dquot);
+			atomic_dec(&dquot->dq_count);
+			continue;
+		}
+		if (dquot_dirty(dquot)) {
+			spin_unlock(&dq_list_lock);
+			/* Commit dquot before releasing */
+			dquot_write_dquot(dquot);
+			goto restart;
+		}
+		if (dquot_active(dquot)) {
+			spin_unlock(&dq_list_lock);
+			dquot->dq_sb->dq_op->release_dquot(dquot);
+			goto restart;
+		}
+		/* Dquot is inactive and clean, now move it to free list */
+		remove_free_dquot(dquot);
+		atomic_dec(&dquot->dq_count);
+		put_dquot_last(dquot);
+	}
+	spin_unlock(&dq_list_lock);
+}
+
 /*
  * Put reference to dquot
  */
 void dqput(struct dquot *dquot)
 {
-	int ret;
-
 	if (!dquot)
 		return;
 #ifdef CONFIG_QUOTA_DEBUG
@@ -765,7 +846,7 @@ void dqput(struct dquot *dquot)
 	}
 #endif
 	dqstats_inc(DQST_DROPS);
-we_slept:
+
 	spin_lock(&dq_list_lock);
 	if (atomic_read(&dquot->dq_count) > 1) {
 		/* We have more than one user... nothing to do */
@@ -777,35 +858,15 @@ void dqput(struct dquot *dquot)
 		spin_unlock(&dq_list_lock);
 		return;
 	}
+
 	/* Need to release dquot? */
-	if (dquot_dirty(dquot)) {
-		spin_unlock(&dq_list_lock);
-		/* Commit dquot before releasing */
-		ret = dquot->dq_sb->dq_op->write_dquot(dquot);
-		if (ret < 0) {
-			quota_error(dquot->dq_sb, "Can't write quota structure"
-				    " (error %d). Quota may get out of sync!",
-				    ret);
-			/*
-			 * We clear dirty bit anyway, so that we avoid
-			 * infinite loop here
-			 */
-			clear_dquot_dirty(dquot);
-		}
-		goto we_slept;
-	}
-	if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
-		spin_unlock(&dq_list_lock);
-		dquot->dq_sb->dq_op->release_dquot(dquot);
-		goto we_slept;
-	}
-	atomic_dec(&dquot->dq_count);
 #ifdef CONFIG_QUOTA_DEBUG
 	/* sanity check */
 	BUG_ON(!list_empty(&dquot->dq_free));
 #endif
-	put_dquot_last(dquot);
+	put_releasing_dquots(dquot);
 	spin_unlock(&dq_list_lock);
+	queue_delayed_work(system_unbound_wq, &quota_release_work, 1);
 }
 EXPORT_SYMBOL(dqput);
 
@@ -895,7 +956,7 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
 	 * already finished or it will be canceled due to dq_count > 1 test */
 	wait_on_dquot(dquot);
 	/* Read the dquot / allocate space in quota file */
-	if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
+	if (!dquot_active(dquot)) {
 		int err;
 
 		err = sb->dq_op->acquire_dquot(dquot);
@@ -1408,7 +1469,7 @@ static int info_bdq_free(struct dquot *dquot, qsize_t space)
 	return QUOTA_NL_NOWARN;
 }
 
-static int dquot_active(const struct inode *inode)
+static int inode_quota_active(const struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
@@ -1431,7 +1492,7 @@ static int __dquot_initialize(struct inode *inode, int type)
 	qsize_t rsv;
 	int ret = 0;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return 0;
 
 	dquots = i_dquot(inode);
@@ -1539,7 +1600,7 @@ bool dquot_initialize_needed(struct inode *inode)
 	struct dquot **dquots;
 	int i;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return false;
 
 	dquots = i_dquot(inode);
@@ -1650,7 +1711,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
 	int reserve = flags & DQUOT_SPACE_RESERVE;
 	struct dquot **dquots;
 
-	if (!dquot_active(inode)) {
+	if (!inode_quota_active(inode)) {
 		if (reserve) {
 			spin_lock(&inode->i_lock);
 			*inode_reserved_space(inode) += number;
@@ -1722,7 +1783,7 @@ int dquot_alloc_inode(struct inode *inode)
 	struct dquot_warn warn[MAXQUOTAS];
 	struct dquot * const *dquots;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return 0;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		warn[cnt].w_type = QUOTA_NL_NOWARN;
@@ -1765,7 +1826,7 @@ int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
 	struct dquot **dquots;
 	int cnt, index;
 
-	if (!dquot_active(inode)) {
+	if (!inode_quota_active(inode)) {
 		spin_lock(&inode->i_lock);
 		*inode_reserved_space(inode) -= number;
 		__inode_add_bytes(inode, number);
@@ -1807,7 +1868,7 @@ void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
 	struct dquot **dquots;
 	int cnt, index;
 
-	if (!dquot_active(inode)) {
+	if (!inode_quota_active(inode)) {
 		spin_lock(&inode->i_lock);
 		*inode_reserved_space(inode) += number;
 		__inode_sub_bytes(inode, number);
@@ -1851,7 +1912,7 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
 	struct dquot **dquots;
 	int reserve = flags & DQUOT_SPACE_RESERVE, index;
 
-	if (!dquot_active(inode)) {
+	if (!inode_quota_active(inode)) {
 		if (reserve) {
 			spin_lock(&inode->i_lock);
 			*inode_reserved_space(inode) -= number;
@@ -1906,7 +1967,7 @@ void dquot_free_inode(struct inode *inode)
 	struct dquot * const *dquots;
 	int index;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return;
 
 	dquots = i_dquot(inode);
@@ -2077,7 +2138,7 @@ int dquot_transfer(struct inode *inode, struct iattr *iattr)
 	struct super_block *sb = inode->i_sb;
 	int ret;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return 0;
 
 	if (iattr->ia_valid & ATTR_UID && !uid_eq(iattr->ia_uid, inode->i_uid)){
@@ -2535,21 +2596,15 @@ int dquot_quota_on_mount(struct super_block *sb, char *qf_name,
 	struct dentry *dentry;
 	int error;
 
-	dentry = lookup_one_len_unlocked(qf_name, sb->s_root, strlen(qf_name));
+	dentry = lookup_positive_unlocked(qf_name, sb->s_root, strlen(qf_name));
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
-	if (d_really_is_negative(dentry)) {
-		error = -ENOENT;
-		goto out;
-	}
-
 	error = security_quota_on(dentry);
 	if (!error)
 		error = vfs_load_quota_inode(d_inode(dentry), type, format_id,
 				DQUOT_USAGE_ENABLED | DQUOT_LIMITS_ENABLED);
 
-out:
 	dput(dentry);
 	return error;
 }
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 78be6dbcd762..3425a04bc8a0 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2336,7 +2336,7 @@ static struct buffer_head *reiserfs_breada(struct block_device *dev,
 	int i, j;
 
 	bh = __getblk(dev, block, bufsize);
-	if (buffer_uptodate(bh))
+	if (!bh || buffer_uptodate(bh))
 		return (bh);
 
 	if (block + BUFNR > max_block) {
@@ -2346,6 +2346,8 @@ static struct buffer_head *reiserfs_breada(struct block_device *dev,
 	j = 1;
 	for (i = 1; i < blocks; i++) {
 		bh = __getblk(dev, block + i, bufsize);
+		if (!bh)
+			break;
 		if (buffer_uptodate(bh)) {
 			brelse(bh);
 			break;
diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index 4c0307f378d7..0dc98bbad9c4 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -36,18 +36,41 @@ static int read_block_bitmap(struct super_block *sb,
 			     unsigned long bitmap_nr)
 {
 	struct buffer_head *bh = NULL;
-	int retval = 0;
+	int i;
+	int max_bits, off, count;
 	struct kernel_lb_addr loc;
 
 	loc.logicalBlockNum = bitmap->s_extPosition;
 	loc.partitionReferenceNum = UDF_SB(sb)->s_partition;
 
 	bh = udf_tread(sb, udf_get_lb_pblock(sb, &loc, block));
+	bitmap->s_block_bitmap[bitmap_nr] = bh;
 	if (!bh)
-		retval = -EIO;
+		return -EIO;
 
-	bitmap->s_block_bitmap[bitmap_nr] = bh;
-	return retval;
+	/* Check consistency of Space Bitmap buffer. */
+	max_bits = sb->s_blocksize * 8;
+	if (!bitmap_nr) {
+		off = sizeof(struct spaceBitmapDesc) << 3;
+		count = min(max_bits - off, bitmap->s_nr_groups);
+	} else {
+		/*
+		 * Rough check if bitmap number is too big to have any bitmap
+		 * blocks reserved.
+		 */
+		if (bitmap_nr >
+		    (bitmap->s_nr_groups >> (sb->s_blocksize_bits + 3)) + 2)
+			return 0;
+		off = 0;
+		count = bitmap->s_nr_groups - bitmap_nr * max_bits +
+				(sizeof(struct spaceBitmapDesc) << 3);
+		count = min(count, max_bits);
+	}
+
+	for (i = 0; i < count; i++)
+		if (udf_test_bit(i + off, bh->b_data))
+			return -EFSCORRUPTED;
+	return 0;
 }
 
 static int __load_block_bitmap(struct super_block *sb,
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 77421e65623a..08d7208eb7b7 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -50,15 +50,15 @@ static int udf_update_inode(struct inode *, int);
 static int udf_sync_inode(struct inode *inode);
 static int udf_alloc_i_data(struct inode *inode, size_t size);
 static sector_t inode_getblk(struct inode *, sector_t, int *, int *);
-static int8_t udf_insert_aext(struct inode *, struct extent_position,
-			      struct kernel_lb_addr, uint32_t);
+static int udf_insert_aext(struct inode *, struct extent_position,
+			   struct kernel_lb_addr, uint32_t);
 static void udf_split_extents(struct inode *, int *, int, udf_pblk_t,
 			      struct kernel_long_ad *, int *);
 static void udf_prealloc_extents(struct inode *, int, int,
 				 struct kernel_long_ad *, int *);
 static void udf_merge_extents(struct inode *, struct kernel_long_ad *, int *);
-static void udf_update_extents(struct inode *, struct kernel_long_ad *, int,
-			       int, struct extent_position *);
+static int udf_update_extents(struct inode *, struct kernel_long_ad *, int,
+			      int, struct extent_position *);
 static int udf_get_block(struct inode *, sector_t, struct buffer_head *, int);
 
 static void __udf_clear_extent_cache(struct inode *inode)
@@ -689,7 +689,7 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 	struct kernel_lb_addr eloc, tmpeloc;
 	int c = 1;
 	loff_t lbcount = 0, b_off = 0;
-	udf_pblk_t newblocknum, newblock;
+	udf_pblk_t newblocknum, newblock = 0;
 	sector_t offset = 0;
 	int8_t etype;
 	struct udf_inode_info *iinfo = UDF_I(inode);
@@ -792,7 +792,6 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 		ret = udf_do_extend_file(inode, &prev_epos, laarr, hole_len);
 		if (ret < 0) {
 			*err = ret;
-			newblock = 0;
 			goto out_free;
 		}
 		c = 0;
@@ -855,7 +854,6 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 				goal, err);
 		if (!newblocknum) {
 			*err = -ENOSPC;
-			newblock = 0;
 			goto out_free;
 		}
 		if (isBeyondEOF)
@@ -881,7 +879,9 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 	/* write back the new extents, inserting new extents if the new number
 	 * of extents is greater than the old number, and deleting extents if
 	 * the new number of extents is less than the old number */
-	udf_update_extents(inode, laarr, startnum, endnum, &prev_epos);
+	*err = udf_update_extents(inode, laarr, startnum, endnum, &prev_epos);
+	if (*err < 0)
+		goto out_free;
 
 	newblock = udf_get_pblock(inode->i_sb, newblocknum,
 				iinfo->i_location.partitionReferenceNum, 0);
@@ -1149,21 +1149,30 @@ static void udf_merge_extents(struct inode *inode, struct kernel_long_ad *laarr,
 	}
 }
 
-static void udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
-			       int startnum, int endnum,
-			       struct extent_position *epos)
+static int udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
+			      int startnum, int endnum,
+			      struct extent_position *epos)
 {
 	int start = 0, i;
 	struct kernel_lb_addr tmploc;
 	uint32_t tmplen;
+	int err;
 
 	if (startnum > endnum) {
 		for (i = 0; i < (startnum - endnum); i++)
 			udf_delete_aext(inode, *epos);
 	} else if (startnum < endnum) {
 		for (i = 0; i < (endnum - startnum); i++) {
-			udf_insert_aext(inode, *epos, laarr[i].extLocation,
-					laarr[i].extLength);
+			err = udf_insert_aext(inode, *epos,
+					      laarr[i].extLocation,
+					      laarr[i].extLength);
+			/*
+			 * If we fail here, we are likely corrupting the extent
+			 * list and leaking blocks. At least stop early to
+			 * limit the damage.
+			 */
+			if (err < 0)
+				return err;
 			udf_next_aext(inode, epos, &laarr[i].extLocation,
 				      &laarr[i].extLength, 1);
 			start++;
@@ -1175,6 +1184,7 @@ static void udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr
 		udf_write_aext(inode, epos, &laarr[i].extLocation,
 			       laarr[i].extLength, 1);
 	}
+	return 0;
 }
 
 struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
@@ -2191,12 +2201,13 @@ int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
 	return etype;
 }
 
-static int8_t udf_insert_aext(struct inode *inode, struct extent_position epos,
-			      struct kernel_lb_addr neloc, uint32_t nelen)
+static int udf_insert_aext(struct inode *inode, struct extent_position epos,
+			   struct kernel_lb_addr neloc, uint32_t nelen)
 {
 	struct kernel_lb_addr oeloc;
 	uint32_t oelen;
 	int8_t etype;
+	int err;
 
 	if (epos.bh)
 		get_bh(epos.bh);
@@ -2206,10 +2217,10 @@ static int8_t udf_insert_aext(struct inode *inode, struct extent_position epos,
 		neloc = oeloc;
 		nelen = (etype << 30) | oelen;
 	}
-	udf_add_aext(inode, &epos, &neloc, nelen, 1);
+	err = udf_add_aext(inode, &epos, &neloc, nelen, 1);
 	brelse(epos.bh);
 
-	return (nelen >> 30);
+	return err;
 }
 
 int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index 3482f9365a4d..de0ad39d4281 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -41,6 +41,7 @@ struct eventfd_ctx *eventfd_ctx_fileget(struct file *file);
 __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n);
 int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *wait,
 				  __u64 *cnt);
+void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
 
 DECLARE_PER_CPU(int, eventfd_wake_count);
 
@@ -82,6 +83,11 @@ static inline bool eventfd_signal_count(void)
 	return false;
 }
 
+static inline void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
+{
+
+}
+
 #endif
 
 #endif /* _LINUX_EVENTFD_H */
diff --git a/include/linux/if_arp.h b/include/linux/if_arp.h
index c697a0524273..a6f14d8e4e81 100644
--- a/include/linux/if_arp.h
+++ b/include/linux/if_arp.h
@@ -56,6 +56,10 @@ static inline bool dev_is_mac_header_xmit(const struct net_device *dev)
 	case ARPHRD_NONE:
 	case ARPHRD_RAWIP:
 	case ARPHRD_PIMREG:
+	/* PPP adds its l2 header automatically in ppp_start_xmit().
+	 * This makes it look like an l3 device to __bpf_redirect() and tcf_mirred_init().
+	 */
+	case ARPHRD_PPP:
 		return false;
 	default:
 		return true;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index a78606e8e3df..4632f4ca3342 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -84,6 +84,7 @@ extern int kern_path_mountpoint(int, const char *, struct path *, unsigned int);
 extern struct dentry *try_lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len_unlocked(const char *, struct dentry *, int);
+extern struct dentry *lookup_positive_unlocked(const char *, struct dentry *, int);
 
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *);
diff --git a/include/linux/nls.h b/include/linux/nls.h
index 499e486b3722..e0bf8367b274 100644
--- a/include/linux/nls.h
+++ b/include/linux/nls.h
@@ -47,7 +47,7 @@ enum utf16_endian {
 /* nls_base.c */
 extern int __register_nls(struct nls_table *, struct module *);
 extern int unregister_nls(struct nls_table *);
-extern struct nls_table *load_nls(char *);
+extern struct nls_table *load_nls(const char *charset);
 extern void unload_nls(struct nls_table *);
 extern struct nls_table *load_nls_default(void);
 #define register_nls(nls) __register_nls((nls), THIS_MODULE)
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 7c4b8e27268c..1ebb88e7c184 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -40,6 +40,7 @@ void pci_disable_pasid(struct pci_dev *pdev);
 void pci_restore_pasid_state(struct pci_dev *pdev);
 int pci_pasid_features(struct pci_dev *pdev);
 int pci_max_pasids(struct pci_dev *pdev);
+int pci_prg_resp_pasid_required(struct pci_dev *pdev);
 
 #else  /* CONFIG_PCI_PASID */
 
@@ -66,6 +67,10 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
 	return -EINVAL;
 }
 
+static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+{
+	return 0;
+}
 #endif /* CONFIG_PCI_PASID */
 
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1d1b0bfd5196..2636990e0ccc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -260,6 +260,7 @@ enum pci_bus_speed {
 	PCIE_SPEED_5_0GT		= 0x15,
 	PCIE_SPEED_8_0GT		= 0x16,
 	PCIE_SPEED_16_0GT		= 0x17,
+	PCIE_SPEED_32_0GT		= 0x18,
 	PCI_SPEED_UNKNOWN		= 0xff,
 };
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index efe30b9b1190..f17e08bd294c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -998,15 +998,31 @@ extern void perf_event_output(struct perf_event *event,
 			      struct pt_regs *regs);
 
 static inline bool
-is_default_overflow_handler(struct perf_event *event)
+__is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
 {
-	if (likely(event->overflow_handler == perf_event_output_forward))
+	if (likely(overflow_handler == perf_event_output_forward))
 		return true;
-	if (unlikely(event->overflow_handler == perf_event_output_backward))
+	if (unlikely(overflow_handler == perf_event_output_backward))
 		return true;
 	return false;
 }
 
+#define is_default_overflow_handler(event) \
+	__is_default_overflow_handler((event)->overflow_handler)
+
+#ifdef CONFIG_BPF_SYSCALL
+static inline bool uses_default_overflow_handler(struct perf_event *event)
+{
+	if (likely(is_default_overflow_handler(event)))
+		return true;
+
+	return __is_default_overflow_handler(event->orig_overflow_handler);
+}
+#else
+#define uses_default_overflow_handler(event) \
+	is_default_overflow_handler(event)
+#endif
+
 extern void
 perf_event_header__init_id(struct perf_event_header *header,
 			   struct perf_sample_data *data,
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 0643c083ed86..93a1b5497bdf 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -581,7 +581,8 @@ extern int  perf_uprobe_init(struct perf_event *event, bool is_retprobe);
 extern void perf_uprobe_destroy(struct perf_event *event);
 extern int bpf_get_uprobe_info(const struct perf_event *event,
 			       u32 *fd_type, const char **filename,
-			       u64 *probe_offset, bool perf_type_tracepoint);
+			       u64 *probe_offset, u64 *probe_addr,
+			       bool perf_type_tracepoint);
 #endif
 extern int  ftrace_profile_set_filter(struct perf_event *event, int event_id,
 				     char *filter_str);
diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
index 33fd9ba7e0e5..ec75c0a1c529 100644
--- a/include/net/lwtunnel.h
+++ b/include/net/lwtunnel.h
@@ -16,9 +16,12 @@
 #define LWTUNNEL_STATE_INPUT_REDIRECT	BIT(1)
 #define LWTUNNEL_STATE_XMIT_REDIRECT	BIT(2)
 
+/* LWTUNNEL_XMIT_CONTINUE should be distinguishable from dst_output return
+ * values (NET_XMIT_xxx and NETDEV_TX_xxx in linux/netdevice.h) for safety.
+ */
 enum {
 	LWTUNNEL_XMIT_DONE,
-	LWTUNNEL_XMIT_CONTINUE,
+	LWTUNNEL_XMIT_CONTINUE = 0x100,
 };
 
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index c6c48409e7b4..9c43299ff870 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -346,7 +346,6 @@ ssize_t tcp_splice_read(struct socket *sk, loff_t *ppos,
 			struct pipe_inode_info *pipe, size_t len,
 			unsigned int flags);
 
-void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks);
 static inline void tcp_dec_quickack_mode(struct sock *sk,
 					 const unsigned int pkts)
 {
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 5ea06d310a25..c4e38448507d 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -760,7 +760,7 @@ extern void scsi_remove_host(struct Scsi_Host *);
 extern struct Scsi_Host *scsi_host_get(struct Scsi_Host *);
 extern int scsi_host_busy(struct Scsi_Host *shost);
 extern void scsi_host_put(struct Scsi_Host *t);
-extern struct Scsi_Host *scsi_host_lookup(unsigned short);
+extern struct Scsi_Host *scsi_host_lookup(unsigned int hostnum);
 extern const char *scsi_host_state_name(enum scsi_host_state);
 extern void scsi_cmd_get_serial(struct Scsi_Host *, struct scsi_cmnd *);
 
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 8d2767140798..39c69235a384 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
- *	pci_regs.h
- *
  *	PCI standard defines
  *	Copyright 1994, Drew Eckhardt
  *	Copyright 1997--1999 Martin Mares <mj@ucw.cz>
@@ -15,7 +13,7 @@
  *	PCI System Design Guide
  *
  *	For HyperTransport information, please consult the following manuals
- *	from http://www.hypertransport.org
+ *	from http://www.hypertransport.org :
  *
  *	The HyperTransport I/O Link Specification
  */
@@ -300,7 +298,7 @@
 #define  PCI_SID_ESR_FIC	0x20	/* First In Chassis Flag */
 #define PCI_SID_CHASSIS_NR	3	/* Chassis Number */
 
-/* Message Signalled Interrupts registers */
+/* Message Signalled Interrupt registers */
 
 #define PCI_MSI_FLAGS		2	/* Message Control */
 #define  PCI_MSI_FLAGS_ENABLE	0x0001	/* MSI feature enabled */
@@ -318,7 +316,7 @@
 #define PCI_MSI_MASK_64		16	/* Mask bits register for 64-bit devices */
 #define PCI_MSI_PENDING_64	20	/* Pending intrs for 64-bit devices */
 
-/* MSI-X registers */
+/* MSI-X registers (in MSI-X capability) */
 #define PCI_MSIX_FLAGS		2	/* Message Control */
 #define  PCI_MSIX_FLAGS_QSIZE	0x07FF	/* Table size */
 #define  PCI_MSIX_FLAGS_MASKALL	0x4000	/* Mask all vectors for this function */
@@ -332,13 +330,13 @@
 #define PCI_MSIX_FLAGS_BIRMASK	PCI_MSIX_PBA_BIR /* deprecated */
 #define PCI_CAP_MSIX_SIZEOF	12	/* size of MSIX registers */
 
-/* MSI-X Table entry format */
+/* MSI-X Table entry format (in memory mapped by a BAR) */
 #define PCI_MSIX_ENTRY_SIZE		16
-#define  PCI_MSIX_ENTRY_LOWER_ADDR	0
-#define  PCI_MSIX_ENTRY_UPPER_ADDR	4
-#define  PCI_MSIX_ENTRY_DATA		8
-#define  PCI_MSIX_ENTRY_VECTOR_CTRL	12
-#define   PCI_MSIX_ENTRY_CTRL_MASKBIT	1
+#define PCI_MSIX_ENTRY_LOWER_ADDR	0  /* Message Address */
+#define PCI_MSIX_ENTRY_UPPER_ADDR	4  /* Message Upper Address */
+#define PCI_MSIX_ENTRY_DATA		8  /* Message Data */
+#define PCI_MSIX_ENTRY_VECTOR_CTRL	12 /* Vector Control */
+#define  PCI_MSIX_ENTRY_CTRL_MASKBIT	0x00000001
 
 /* CompactPCI Hotswap Register */
 
@@ -464,19 +462,19 @@
 /* PCI Express capability registers */
 
 #define PCI_EXP_FLAGS		2	/* Capabilities register */
-#define PCI_EXP_FLAGS_VERS	0x000f	/* Capability version */
-#define PCI_EXP_FLAGS_TYPE	0x00f0	/* Device/Port type */
-#define  PCI_EXP_TYPE_ENDPOINT	0x0	/* Express Endpoint */
-#define  PCI_EXP_TYPE_LEG_END	0x1	/* Legacy Endpoint */
-#define  PCI_EXP_TYPE_ROOT_PORT 0x4	/* Root Port */
-#define  PCI_EXP_TYPE_UPSTREAM	0x5	/* Upstream Port */
-#define  PCI_EXP_TYPE_DOWNSTREAM 0x6	/* Downstream Port */
-#define  PCI_EXP_TYPE_PCI_BRIDGE 0x7	/* PCIe to PCI/PCI-X Bridge */
-#define  PCI_EXP_TYPE_PCIE_BRIDGE 0x8	/* PCI/PCI-X to PCIe Bridge */
-#define  PCI_EXP_TYPE_RC_END	0x9	/* Root Complex Integrated Endpoint */
-#define  PCI_EXP_TYPE_RC_EC	0xa	/* Root Complex Event Collector */
-#define PCI_EXP_FLAGS_SLOT	0x0100	/* Slot implemented */
-#define PCI_EXP_FLAGS_IRQ	0x3e00	/* Interrupt message number */
+#define  PCI_EXP_FLAGS_VERS	0x000f	/* Capability version */
+#define  PCI_EXP_FLAGS_TYPE	0x00f0	/* Device/Port type */
+#define   PCI_EXP_TYPE_ENDPOINT	   0x0	/* Express Endpoint */
+#define   PCI_EXP_TYPE_LEG_END	   0x1	/* Legacy Endpoint */
+#define   PCI_EXP_TYPE_ROOT_PORT   0x4	/* Root Port */
+#define   PCI_EXP_TYPE_UPSTREAM	   0x5	/* Upstream Port */
+#define   PCI_EXP_TYPE_DOWNSTREAM  0x6	/* Downstream Port */
+#define   PCI_EXP_TYPE_PCI_BRIDGE  0x7	/* PCIe to PCI/PCI-X Bridge */
+#define   PCI_EXP_TYPE_PCIE_BRIDGE 0x8	/* PCI/PCI-X to PCIe Bridge */
+#define   PCI_EXP_TYPE_RC_END	   0x9	/* Root Complex Integrated Endpoint */
+#define   PCI_EXP_TYPE_RC_EC	   0xa	/* Root Complex Event Collector */
+#define  PCI_EXP_FLAGS_SLOT	0x0100	/* Slot implemented */
+#define  PCI_EXP_FLAGS_IRQ	0x3e00	/* Interrupt message number */
 #define PCI_EXP_DEVCAP		4	/* Device capabilities */
 #define  PCI_EXP_DEVCAP_PAYLOAD	0x00000007 /* Max_Payload_Size */
 #define  PCI_EXP_DEVCAP_PHANTOM	0x00000018 /* Phantom functions */
@@ -529,6 +527,7 @@
 #define  PCI_EXP_LNKCAP_SLS_5_0GB 0x00000002 /* LNKCAP2 SLS Vector bit 1 */
 #define  PCI_EXP_LNKCAP_SLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2 */
 #define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bit 3 */
+#define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vector bit 4 */
 #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
 #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
 #define  PCI_EXP_LNKCAP_L0SEL	0x00007000 /* L0s Exit Latency */
@@ -557,6 +556,7 @@
 #define  PCI_EXP_LNKSTA_CLS_5_0GB 0x0002 /* Current Link Speed 5.0GT/s */
 #define  PCI_EXP_LNKSTA_CLS_8_0GB 0x0003 /* Current Link Speed 8.0GT/s */
 #define  PCI_EXP_LNKSTA_CLS_16_0GB 0x0004 /* Current Link Speed 16.0GT/s */
+#define  PCI_EXP_LNKSTA_CLS_32_0GB 0x0005 /* Current Link Speed 32.0GT/s */
 #define  PCI_EXP_LNKSTA_NLW	0x03f0	/* Negotiated Link Width */
 #define  PCI_EXP_LNKSTA_NLW_X1	0x0010	/* Current Link Width x1 */
 #define  PCI_EXP_LNKSTA_NLW_X2	0x0020	/* Current Link Width x2 */
@@ -621,8 +621,8 @@
 #define PCI_EXP_RTCAP		30	/* Root Capabilities */
 #define  PCI_EXP_RTCAP_CRSVIS	0x0001	/* CRS Software Visibility capability */
 #define PCI_EXP_RTSTA		32	/* Root Status */
-#define PCI_EXP_RTSTA_PME	0x00010000 /* PME status */
-#define PCI_EXP_RTSTA_PENDING	0x00020000 /* PME pending */
+#define  PCI_EXP_RTSTA_PME	0x00010000 /* PME status */
+#define  PCI_EXP_RTSTA_PENDING	0x00020000 /* PME pending */
 /*
  * The Device Capabilities 2, Device Status 2, Device Control 2,
  * Link Capabilities 2, Link Status 2, Link Control 2,
@@ -642,13 +642,13 @@
 #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
-#define PCI_EXP_DEVCAP2_EE_PREFIX	0x00200000 /* End-End TLP Prefix */
+#define  PCI_EXP_DEVCAP2_EE_PREFIX	0x00200000 /* End-End TLP Prefix */
 #define PCI_EXP_DEVCTL2		40	/* Device Control 2 */
 #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
 #define  PCI_EXP_DEVCTL2_COMP_TMOUT_DIS	0x0010	/* Completion Timeout Disable */
 #define  PCI_EXP_DEVCTL2_ARI		0x0020	/* Alternative Routing-ID */
-#define PCI_EXP_DEVCTL2_ATOMIC_REQ	0x0040	/* Set Atomic requests */
-#define PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK 0x0080 /* Block atomic egress */
+#define  PCI_EXP_DEVCTL2_ATOMIC_REQ	0x0040	/* Set Atomic requests */
+#define  PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK 0x0080 /* Block atomic egress */
 #define  PCI_EXP_DEVCTL2_IDO_REQ_EN	0x0100	/* Allow IDO for requests */
 #define  PCI_EXP_DEVCTL2_IDO_CMP_EN	0x0200	/* Allow IDO for completions */
 #define  PCI_EXP_DEVCTL2_LTR_EN		0x0400	/* Enable LTR mechanism */
@@ -662,13 +662,17 @@
 #define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000004 /* Supported Speed 5GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000008 /* Supported Speed 8GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_16_0GB	0x00000010 /* Supported Speed 16GT/s */
+#define  PCI_EXP_LNKCAP2_SLS_32_0GB	0x00000020 /* Supported Speed 32GT/s */
 #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
 #define PCI_EXP_LNKCTL2		48	/* Link Control 2 */
-#define PCI_EXP_LNKCTL2_TLS		0x000f
-#define PCI_EXP_LNKCTL2_TLS_2_5GT	0x0001 /* Supported Speed 2.5GT/s */
-#define PCI_EXP_LNKCTL2_TLS_5_0GT	0x0002 /* Supported Speed 5GT/s */
-#define PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
-#define PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
+#define  PCI_EXP_LNKCTL2_TLS		0x000f
+#define  PCI_EXP_LNKCTL2_TLS_2_5GT	0x0001 /* Supported Speed 2.5GT/s */
+#define  PCI_EXP_LNKCTL2_TLS_5_0GT	0x0002 /* Supported Speed 5GT/s */
+#define  PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
+#define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
+#define  PCI_EXP_LNKCTL2_TLS_32_0GT	0x0005 /* Supported Speed 32GT/s */
+#define  PCI_EXP_LNKCTL2_ENTER_COMP	0x0010 /* Enter Compliance */
+#define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
 #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
@@ -757,18 +761,18 @@
 #define  PCI_ERR_CAP_ECRC_CHKE	0x00000100	/* ECRC Check Enable */
 #define PCI_ERR_HEADER_LOG	28	/* Header Log Register (16 bytes) */
 #define PCI_ERR_ROOT_COMMAND	44	/* Root Error Command */
-#define PCI_ERR_ROOT_CMD_COR_EN		0x00000001 /* Correctable Err Reporting Enable */
-#define PCI_ERR_ROOT_CMD_NONFATAL_EN	0x00000002 /* Non-Fatal Err Reporting Enable */
-#define PCI_ERR_ROOT_CMD_FATAL_EN	0x00000004 /* Fatal Err Reporting Enable */
+#define  PCI_ERR_ROOT_CMD_COR_EN	0x00000001 /* Correctable Err Reporting Enable */
+#define  PCI_ERR_ROOT_CMD_NONFATAL_EN	0x00000002 /* Non-Fatal Err Reporting Enable */
+#define  PCI_ERR_ROOT_CMD_FATAL_EN	0x00000004 /* Fatal Err Reporting Enable */
 #define PCI_ERR_ROOT_STATUS	48
-#define PCI_ERR_ROOT_COR_RCV		0x00000001 /* ERR_COR Received */
-#define PCI_ERR_ROOT_MULTI_COR_RCV	0x00000002 /* Multiple ERR_COR */
-#define PCI_ERR_ROOT_UNCOR_RCV		0x00000004 /* ERR_FATAL/NONFATAL */
-#define PCI_ERR_ROOT_MULTI_UNCOR_RCV	0x00000008 /* Multiple FATAL/NONFATAL */
-#define PCI_ERR_ROOT_FIRST_FATAL	0x00000010 /* First UNC is Fatal */
-#define PCI_ERR_ROOT_NONFATAL_RCV	0x00000020 /* Non-Fatal Received */
-#define PCI_ERR_ROOT_FATAL_RCV		0x00000040 /* Fatal Received */
-#define PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
+#define  PCI_ERR_ROOT_COR_RCV		0x00000001 /* ERR_COR Received */
+#define  PCI_ERR_ROOT_MULTI_COR_RCV	0x00000002 /* Multiple ERR_COR */
+#define  PCI_ERR_ROOT_UNCOR_RCV		0x00000004 /* ERR_FATAL/NONFATAL */
+#define  PCI_ERR_ROOT_MULTI_UNCOR_RCV	0x00000008 /* Multiple FATAL/NONFATAL */
+#define  PCI_ERR_ROOT_FIRST_FATAL	0x00000010 /* First UNC is Fatal */
+#define  PCI_ERR_ROOT_NONFATAL_RCV	0x00000020 /* Non-Fatal Received */
+#define  PCI_ERR_ROOT_FATAL_RCV		0x00000040 /* Fatal Received */
+#define  PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
 #define PCI_ERR_ROOT_ERR_SRC	52	/* Error Source Identification */
 
 /* Virtual Channel */
@@ -879,12 +883,13 @@
 
 /* Page Request Interface */
 #define PCI_PRI_CTRL		0x04	/* PRI control register */
-#define  PCI_PRI_CTRL_ENABLE	0x01	/* Enable */
-#define  PCI_PRI_CTRL_RESET	0x02	/* Reset */
+#define  PCI_PRI_CTRL_ENABLE	0x0001	/* Enable */
+#define  PCI_PRI_CTRL_RESET	0x0002	/* Reset */
 #define PCI_PRI_STATUS		0x06	/* PRI status register */
-#define  PCI_PRI_STATUS_RF	0x001	/* Response Failure */
-#define  PCI_PRI_STATUS_UPRGI	0x002	/* Unexpected PRG index */
-#define  PCI_PRI_STATUS_STOPPED	0x100	/* PRI Stopped */
+#define  PCI_PRI_STATUS_RF	0x0001	/* Response Failure */
+#define  PCI_PRI_STATUS_UPRGI	0x0002	/* Unexpected PRG index */
+#define  PCI_PRI_STATUS_STOPPED	0x0100	/* PRI Stopped */
+#define  PCI_PRI_STATUS_PASID	0x8000	/* PRG Response PASID Required */
 #define PCI_PRI_MAX_REQ		0x08	/* PRI max reqs supported */
 #define PCI_PRI_ALLOC_REQ	0x0c	/* PRI max reqs allowed */
 #define PCI_EXT_CAP_PRI_SIZEOF	16
@@ -901,16 +906,16 @@
 
 /* Single Root I/O Virtualization */
 #define PCI_SRIOV_CAP		0x04	/* SR-IOV Capabilities */
-#define  PCI_SRIOV_CAP_VFM	0x01	/* VF Migration Capable */
+#define  PCI_SRIOV_CAP_VFM	0x00000001  /* VF Migration Capable */
 #define  PCI_SRIOV_CAP_INTR(x)	((x) >> 21) /* Interrupt Message Number */
 #define PCI_SRIOV_CTRL		0x08	/* SR-IOV Control */
-#define  PCI_SRIOV_CTRL_VFE	0x01	/* VF Enable */
-#define  PCI_SRIOV_CTRL_VFM	0x02	/* VF Migration Enable */
-#define  PCI_SRIOV_CTRL_INTR	0x04	/* VF Migration Interrupt Enable */
-#define  PCI_SRIOV_CTRL_MSE	0x08	/* VF Memory Space Enable */
-#define  PCI_SRIOV_CTRL_ARI	0x10	/* ARI Capable Hierarchy */
+#define  PCI_SRIOV_CTRL_VFE	0x0001	/* VF Enable */
+#define  PCI_SRIOV_CTRL_VFM	0x0002	/* VF Migration Enable */
+#define  PCI_SRIOV_CTRL_INTR	0x0004	/* VF Migration Interrupt Enable */
+#define  PCI_SRIOV_CTRL_MSE	0x0008	/* VF Memory Space Enable */
+#define  PCI_SRIOV_CTRL_ARI	0x0010	/* ARI Capable Hierarchy */
 #define PCI_SRIOV_STATUS	0x0a	/* SR-IOV Status */
-#define  PCI_SRIOV_STATUS_VFM	0x01	/* VF Migration Status */
+#define  PCI_SRIOV_STATUS_VFM	0x0001	/* VF Migration Status */
 #define PCI_SRIOV_INITIAL_VF	0x0c	/* Initial VFs */
 #define PCI_SRIOV_TOTAL_VF	0x0e	/* Total VFs */
 #define PCI_SRIOV_NUM_VF	0x10	/* Number of VFs */
@@ -940,13 +945,13 @@
 
 /* Access Control Service */
 #define PCI_ACS_CAP		0x04	/* ACS Capability Register */
-#define  PCI_ACS_SV		0x01	/* Source Validation */
-#define  PCI_ACS_TB		0x02	/* Translation Blocking */
-#define  PCI_ACS_RR		0x04	/* P2P Request Redirect */
-#define  PCI_ACS_CR		0x08	/* P2P Completion Redirect */
-#define  PCI_ACS_UF		0x10	/* Upstream Forwarding */
-#define  PCI_ACS_EC		0x20	/* P2P Egress Control */
-#define  PCI_ACS_DT		0x40	/* Direct Translated P2P */
+#define  PCI_ACS_SV		0x0001	/* Source Validation */
+#define  PCI_ACS_TB		0x0002	/* Translation Blocking */
+#define  PCI_ACS_RR		0x0004	/* P2P Request Redirect */
+#define  PCI_ACS_CR		0x0008	/* P2P Completion Redirect */
+#define  PCI_ACS_UF		0x0010	/* Upstream Forwarding */
+#define  PCI_ACS_EC		0x0020	/* P2P Egress Control */
+#define  PCI_ACS_DT		0x0040	/* Direct Translated P2P */
 #define PCI_ACS_EGRESS_BITS	0x05	/* ACS Egress Control Vector Size */
 #define PCI_ACS_CTRL		0x06	/* ACS Control Register */
 #define PCI_ACS_EGRESS_CTL_V	0x08	/* ACS Egress Control Vector */
@@ -996,9 +1001,9 @@
 #define  PCI_EXP_DPC_CAP_DL_ACTIVE	0x1000	/* ERR_COR signal on DL_Active supported */
 
 #define PCI_EXP_DPC_CTL			6	/* DPC control */
-#define  PCI_EXP_DPC_CTL_EN_FATAL 	0x0001	/* Enable trigger on ERR_FATAL message */
-#define  PCI_EXP_DPC_CTL_EN_NONFATAL 	0x0002	/* Enable trigger on ERR_NONFATAL message */
-#define  PCI_EXP_DPC_CTL_INT_EN 	0x0008	/* DPC Interrupt Enable */
+#define  PCI_EXP_DPC_CTL_EN_FATAL	0x0001	/* Enable trigger on ERR_FATAL message */
+#define  PCI_EXP_DPC_CTL_EN_NONFATAL	0x0002	/* Enable trigger on ERR_NONFATAL message */
+#define  PCI_EXP_DPC_CTL_INT_EN		0x0008	/* DPC Interrupt Enable */
 
 #define PCI_EXP_DPC_STATUS		8	/* DPC Status */
 #define  PCI_EXP_DPC_STATUS_TRIGGER	    0x0001 /* Trigger Status */
diff --git a/include/uapi/linux/sync_file.h b/include/uapi/linux/sync_file.h
index ee2dcfb3d660..d7f7c04a6e0c 100644
--- a/include/uapi/linux/sync_file.h
+++ b/include/uapi/linux/sync_file.h
@@ -52,7 +52,7 @@ struct sync_fence_info {
  * @name:	name of fence
  * @status:	status of fence. 1: signaled 0:active <0:error
  * @flags:	sync_file_info flags
- * @num_fences	number of fences in the sync_file
+ * @num_fences:	number of fences in the sync_file
  * @pad:	padding for 64-bit alignment, should always be zero
  * @sync_fence_info: pointer to array of structs sync_fence_info with all
  *		 fences in the sync_file
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 1513873e23bd..e4de5b9d5d3f 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1923,6 +1923,8 @@ void __audit_inode_child(struct inode *parent,
 		}
 	}
 
+	cond_resched();
+
 	/* is there a matching child entry? */
 	list_for_each_entry(n, &context->names_list, list) {
 		/* can only match entries that have a name */
diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index b05f1dd58a62..313e66b8c662 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -148,9 +148,3 @@ const struct proc_ns_operations cgroupns_operations = {
 	.install	= cgroupns_install,
 	.owner		= cgroupns_owner,
 };
-
-static __init int cgroup_namespaces_init(void)
-{
-	return 0;
-}
-subsys_initcall(cgroup_namespaces_init);
diff --git a/kernel/module.c b/kernel/module.c
index 6ec0b2e0f01f..2ec961945fa8 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2261,15 +2261,26 @@ static void free_module(struct module *mod)
 void *__symbol_get(const char *symbol)
 {
 	struct module *owner;
+	enum mod_license license;
 	const struct kernel_symbol *sym;
 
 	preempt_disable();
-	sym = find_symbol(symbol, &owner, NULL, NULL, true, true);
-	if (sym && strong_try_module_get(owner))
+	sym = find_symbol(symbol, &owner, NULL, &license, true, true);
+	if (!sym)
+		goto fail;
+	if (license != GPL_ONLY) {
+		pr_warn("failing symbol_get of non-GPLONLY symbol %s.\n",
+			symbol);
+		goto fail;
+	}
+	if (strong_try_module_get(owner))
 		sym = NULL;
 	preempt_enable();
 
 	return sym ? (void *)kernel_symbol_value(sym) : NULL;
+fail:
+	preempt_enable();
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(__symbol_get);
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 1cb13d6368f3..b794470bb42e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1274,7 +1274,7 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 #ifdef CONFIG_UPROBE_EVENTS
 		if (flags & TRACE_EVENT_FL_UPROBE)
 			err = bpf_get_uprobe_info(event, fd_type, buf,
-						  probe_offset,
+						  probe_offset, probe_addr,
 						  event->attr.type == PERF_TYPE_TRACEPOINT);
 #endif
 	}
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 0da379b90249..0e3bdd69fa2d 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1159,7 +1159,7 @@ static void uretprobe_perf_func(struct trace_uprobe *tu, unsigned long func,
 
 int bpf_get_uprobe_info(const struct perf_event *event, u32 *fd_type,
 			const char **filename, u64 *probe_offset,
-			bool perf_type_tracepoint)
+			u64 *probe_addr, bool perf_type_tracepoint)
 {
 	const char *pevent = trace_event_name(event->tp_event);
 	const char *group = event->tp_event->class->system;
@@ -1176,6 +1176,7 @@ int bpf_get_uprobe_info(const struct perf_event *event, u32 *fd_type,
 				    : BPF_FD_TYPE_UPROBE;
 	*filename = tu->filename;
 	*probe_offset = tu->offset;
+	*probe_addr = 0;
 	return 0;
 }
 #endif	/* CONFIG_PERF_EVENTS */
diff --git a/lib/idr.c b/lib/idr.c
index 82c24a417dc6..432a985bf772 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -103,7 +103,7 @@ EXPORT_SYMBOL_GPL(idr_alloc);
  * @end: The maximum ID (exclusive).
  * @gfp: Memory allocation flags.
  *
- * Allocates an unused ID in the range specified by @nextid and @end.  If
+ * Allocates an unused ID in the range specified by @start and @end.  If
  * @end is <= 0, it is treated as one larger than %INT_MAX.  This allows
  * callers to use @start + N as @end as long as N is within integer range.
  * The search for an unused ID will start at the last ID allocated and will
diff --git a/lib/kobject.c b/lib/kobject.c
index 97d86dc17c42..2bab65232925 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -829,6 +829,11 @@ int kset_register(struct kset *k)
 	if (!k)
 		return -EINVAL;
 
+	if (!k->kobj.ktype) {
+		pr_err("must have a ktype to be initialized properly!\n");
+		return -EINVAL;
+	}
+
 	kset_init(k);
 	err = kobject_add_internal(&k->kobj);
 	if (err)
diff --git a/lib/mpi/mpi-cmp.c b/lib/mpi/mpi-cmp.c
index d25e9e96c310..ceaebe181cd7 100644
--- a/lib/mpi/mpi-cmp.c
+++ b/lib/mpi/mpi-cmp.c
@@ -25,8 +25,12 @@ int mpi_cmp_ui(MPI u, unsigned long v)
 	mpi_limb_t limb = v;
 
 	mpi_normalize(u);
-	if (!u->nlimbs && !limb)
-		return 0;
+	if (u->nlimbs == 0) {
+		if (v == 0)
+			return 0;
+		else
+			return -1;
+	}
 	if (u->sign)
 		return -1;
 	if (u->nlimbs > 1)
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index f7cd8e018bde..6b3357a77d99 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -409,7 +409,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	struct page **in_pages = NULL, **out_pages = NULL;
 	struct virtio_chan *chan = client->trans;
 	struct scatterlist *sgs[4];
-	size_t offs;
+	size_t offs = 0;
 	int need_drop = 0;
 	int kicked = 0;
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b7314a6cf8c2..e03cd719b86b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3546,21 +3546,20 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	struct sk_buff *segs = NULL;
 	struct sk_buff *tail = NULL;
 	struct sk_buff *list_skb = skb_shinfo(head_skb)->frag_list;
-	skb_frag_t *frag = skb_shinfo(head_skb)->frags;
 	unsigned int mss = skb_shinfo(head_skb)->gso_size;
 	unsigned int doffset = head_skb->data - skb_mac_header(head_skb);
-	struct sk_buff *frag_skb = head_skb;
 	unsigned int offset = doffset;
 	unsigned int tnl_hlen = skb_tnl_header_len(head_skb);
 	unsigned int partial_segs = 0;
 	unsigned int headroom;
 	unsigned int len = head_skb->len;
+	struct sk_buff *frag_skb;
+	skb_frag_t *frag;
 	__be16 proto;
 	bool csum, sg;
-	int nfrags = skb_shinfo(head_skb)->nr_frags;
 	int err = -ENOMEM;
 	int i = 0;
-	int pos;
+	int nfrags, pos;
 	int dummy;
 
 	if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
@@ -3638,6 +3637,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	headroom = skb_headroom(head_skb);
 	pos = skb_headlen(head_skb);
 
+	if (skb_orphan_frags(head_skb, GFP_ATOMIC))
+		return ERR_PTR(-ENOMEM);
+
+	nfrags = skb_shinfo(head_skb)->nr_frags;
+	frag = skb_shinfo(head_skb)->frags;
+	frag_skb = head_skb;
+
 	do {
 		struct sk_buff *nskb;
 		skb_frag_t *nskb_frag;
@@ -3662,6 +3668,10 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		    (skb_headlen(list_skb) == len || sg)) {
 			BUG_ON(skb_headlen(list_skb) > len);
 
+			nskb = skb_clone(list_skb, GFP_ATOMIC);
+			if (unlikely(!nskb))
+				goto err;
+
 			i = 0;
 			nfrags = skb_shinfo(list_skb)->nr_frags;
 			frag = skb_shinfo(list_skb)->frags;
@@ -3680,12 +3690,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 				frag++;
 			}
 
-			nskb = skb_clone(list_skb, GFP_ATOMIC);
 			list_skb = list_skb->next;
 
-			if (unlikely(!nskb))
-				goto err;
-
 			if (unlikely(pskb_trim(nskb, len))) {
 				kfree_skb(nskb);
 				goto err;
@@ -3750,12 +3756,16 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		skb_shinfo(nskb)->tx_flags |= skb_shinfo(head_skb)->tx_flags &
 					      SKBTX_SHARED_FRAG;
 
-		if (skb_orphan_frags(frag_skb, GFP_ATOMIC) ||
-		    skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
+		if (skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
 			goto err;
 
 		while (pos < offset + len) {
 			if (i >= nfrags) {
+				if (skb_orphan_frags(list_skb, GFP_ATOMIC) ||
+				    skb_zerocopy_clone(nskb, list_skb,
+						       GFP_ATOMIC))
+					goto err;
+
 				i = 0;
 				nfrags = skb_shinfo(list_skb)->nr_frags;
 				frag = skb_shinfo(list_skb)->frags;
@@ -3769,10 +3779,6 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 					i--;
 					frag--;
 				}
-				if (skb_orphan_frags(frag_skb, GFP_ATOMIC) ||
-				    skb_zerocopy_clone(nskb, frag_skb,
-						       GFP_ATOMIC))
-					goto err;
 
 				list_skb = list_skb->next;
 			}
diff --git a/net/core/sock.c b/net/core/sock.c
index 4e3ed80a68ce..e1d0c8c715b8 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -632,7 +632,8 @@ bool sk_mc_loop(struct sock *sk)
 		return false;
 	if (!sk)
 		return true;
-	switch (sk->sk_family) {
+	/* IPV6_ADDRFORM can change sk->sk_family under us. */
+	switch (READ_ONCE(sk->sk_family)) {
 	case AF_INET:
 		return inet_sk(sk)->mc_loop;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -2071,9 +2072,9 @@ static long sock_wait_for_wmem(struct sock *sk, long timeo)
 		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
 		if (refcount_read(&sk->sk_wmem_alloc) < sk->sk_sndbuf)
 			break;
-		if (sk->sk_shutdown & SEND_SHUTDOWN)
+		if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
 			break;
-		if (sk->sk_err)
+		if (READ_ONCE(sk->sk_err))
 			break;
 		timeo = schedule_timeout(timeo);
 	}
@@ -2101,7 +2102,7 @@ struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long header_len,
 			goto failure;
 
 		err = -EPIPE;
-		if (sk->sk_shutdown & SEND_SHUTDOWN)
+		if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
 			goto failure;
 
 		if (sk_wmem_alloc_get(sk) < sk->sk_sndbuf)
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index c021d5dde8f7..b2fc9ef7708f 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -247,12 +247,17 @@ static void dccp_v4_err(struct sk_buff *skb, u32 info)
 	int err;
 	struct net *net = dev_net(skb->dev);
 
-	/* Only need dccph_dport & dccph_sport which are the first
-	 * 4 bytes in dccp header.
+	/* For the first __dccp_basic_hdr_len() check, we only need dh->dccph_x,
+	 * which is in byte 7 of the dccp header.
 	 * Our caller (icmp_socket_deliver()) already pulled 8 bytes for us.
+	 *
+	 * Later on, we want to access the sequence number fields, which are
+	 * beyond 8 bytes, so we have to pskb_may_pull() ourselves.
 	 */
-	BUILD_BUG_ON(offsetofend(struct dccp_hdr, dccph_sport) > 8);
-	BUILD_BUG_ON(offsetofend(struct dccp_hdr, dccph_dport) > 8);
+	dh = (struct dccp_hdr *)(skb->data + offset);
+	if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
+		return;
+	iph = (struct iphdr *)skb->data;
 	dh = (struct dccp_hdr *)(skb->data + offset);
 
 	sk = __inet_lookup_established(net, &dccp_hashinfo,
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 88732ab4887c..f8d8caa967b1 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -71,7 +71,7 @@ static inline __u64 dccp_v6_init_sequence(struct sk_buff *skb)
 static void dccp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 			u8 type, u8 code, int offset, __be32 info)
 {
-	const struct ipv6hdr *hdr = (const struct ipv6hdr *)skb->data;
+	const struct ipv6hdr *hdr;
 	const struct dccp_hdr *dh;
 	struct dccp_sock *dp;
 	struct ipv6_pinfo *np;
@@ -80,12 +80,17 @@ static void dccp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	__u64 seq;
 	struct net *net = dev_net(skb->dev);
 
-	/* Only need dccph_dport & dccph_sport which are the first
-	 * 4 bytes in dccp header.
+	/* For the first __dccp_basic_hdr_len() check, we only need dh->dccph_x,
+	 * which is in byte 7 of the dccp header.
 	 * Our caller (icmpv6_notify()) already pulled 8 bytes for us.
+	 *
+	 * Later on, we want to access the sequence number fields, which are
+	 * beyond 8 bytes, so we have to pskb_may_pull() ourselves.
 	 */
-	BUILD_BUG_ON(offsetofend(struct dccp_hdr, dccph_sport) > 8);
-	BUILD_BUG_ON(offsetofend(struct dccp_hdr, dccph_dport) > 8);
+	dh = (struct dccp_hdr *)(skb->data + offset);
+	if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
+		return;
+	hdr = (const struct ipv6hdr *)skb->data;
 	dh = (struct dccp_hdr *)(skb->data + offset);
 
 	sk = __inet6_lookup_established(net, &dccp_hashinfo,
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index a08acb54b6b0..7d82818b711e 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -357,8 +357,9 @@ static struct sk_buff *igmpv3_newpack(struct net_device *dev, unsigned int mtu)
 	struct flowi4 fl4;
 	int hlen = LL_RESERVED_SPACE(dev);
 	int tlen = dev->needed_tailroom;
-	unsigned int size = mtu;
+	unsigned int size;
 
+	size = min(mtu, IP_MAX_MTU);
 	while (1) {
 		skb = alloc_skb(size + hlen + tlen,
 				GFP_ATOMIC | __GFP_NOWARN);
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 92fa11e75a4d..6936f703758b 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -221,7 +221,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
 		int res = lwtunnel_xmit(skb);
 
-		if (res < 0 || res == LWTUNNEL_XMIT_DONE)
+		if (res != LWTUNNEL_XMIT_CONTINUE)
 			return res;
 	}
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 281f7799aeaf..9e1ec69fe5b4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -216,7 +216,7 @@ static void tcp_incr_quickack(struct sock *sk, unsigned int max_quickacks)
 		icsk->icsk_ack.quick = quickacks;
 }
 
-void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks)
+static void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
@@ -224,7 +224,6 @@ void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks)
 	icsk->icsk_ack.pingpong = 0;
 	icsk->icsk_ack.ato = TCP_ATO_MIN;
 }
-EXPORT_SYMBOL(tcp_enter_quickack_mode);
 
 /* Send ACKs quickly, if "quick" count is not exhausted
  * and the session is not interactive.
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5c5c5736f689..5ffa8777ab09 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1321,7 +1321,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp,
 	 * idev->desync_factor if it's larger
 	 */
 	cnf_temp_preferred_lft = READ_ONCE(idev->cnf.temp_prefered_lft);
-	max_desync_factor = min_t(__u32,
+	max_desync_factor = min_t(long,
 				  idev->cnf.max_desync_factor,
 				  cnf_temp_preferred_lft - regen_advance);
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 4f31a781ab37..ff4d349e13f7 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -106,7 +106,7 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
 		int res = lwtunnel_xmit(skb);
 
-		if (res < 0 || res == LWTUNNEL_XMIT_DONE)
+		if (res != LWTUNNEL_XMIT_CONTINUE)
 			return res;
 	}
 
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index c0034546a9ed..a82892c28860 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1065,15 +1065,18 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 out_error:
 	kcm_push(kcm);
 
-	if (copied && sock->type == SOCK_SEQPACKET) {
+	if (sock->type == SOCK_SEQPACKET) {
 		/* Wrote some bytes before encountering an
 		 * error, return partial success.
 		 */
-		goto partial_message;
-	}
-
-	if (head != kcm->seq_skb)
+		if (copied)
+			goto partial_message;
+		if (head != kcm->seq_skb)
+			kfree_skb(head);
+	} else {
 		kfree_skb(head);
+		kcm->seq_skb = NULL;
+	}
 
 	err = sk_stream_error(sk, msg->msg_flags, err);
 
@@ -1983,6 +1986,8 @@ static __net_exit void kcm_exit_net(struct net *net)
 	 * that all multiplexors and psocks have been destroyed.
 	 */
 	WARN_ON(!list_empty(&knet->mux_list));
+
+	mutex_destroy(&knet->mutex);
 }
 
 static struct pernet_operations kcm_net_ops = {
diff --git a/net/netfilter/ipset/ip_set_hash_netportnet.c b/net/netfilter/ipset/ip_set_hash_netportnet.c
index 613e18e720a4..9290a4d7b862 100644
--- a/net/netfilter/ipset/ip_set_hash_netportnet.c
+++ b/net/netfilter/ipset/ip_set_hash_netportnet.c
@@ -39,6 +39,7 @@ MODULE_ALIAS("ip_set_hash:net,port,net");
 #define IP_SET_HASH_WITH_PROTO
 #define IP_SET_HASH_WITH_NETS
 #define IPSET_NET_COUNT 2
+#define IP_SET_HASH_WITH_NET0
 
 /* IPv4 variant */
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index eeadb638f448..0ff8f1006c6b 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5555,6 +5555,7 @@ void nf_tables_deactivate_flowtable(const struct nft_ctx *ctx,
 				    enum nft_trans_phase phase)
 {
 	switch (phase) {
+	case NFT_TRANS_PREPARE_ERROR:
 	case NFT_TRANS_PREPARE:
 	case NFT_TRANS_ABORT:
 	case NFT_TRANS_RELEASE:
diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index 21e4554c7695..f3676238e64f 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -318,6 +318,14 @@ static int nfnl_osf_add_callback(struct net *net, struct sock *ctnl,
 
 	f = nla_data(osf_attrs[OSF_ATTR_FINGER]);
 
+	if (f->opt_num > ARRAY_SIZE(f->opt))
+		return -EINVAL;
+
+	if (!memchr(f->genre, 0, MAXGENRELEN) ||
+	    !memchr(f->subtype, 0, MAXGENRELEN) ||
+	    !memchr(f->version, 0, MAXGENRELEN))
+		return -EINVAL;
+
 	kf = kmalloc(sizeof(struct nf_osf_finger), GFP_KERNEL);
 	if (!kf)
 		return -ENOMEM;
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 7055088e91c2..ec35a41c7262 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -197,9 +197,6 @@ static void nft_flow_offload_activate(const struct nft_ctx *ctx,
 static void nft_flow_offload_destroy(const struct nft_ctx *ctx,
 				     const struct nft_expr *expr)
 {
-	struct nft_flow_offload *priv = nft_expr_priv(expr);
-
-	priv->flowtable->use--;
 	nf_ct_netns_put(ctx->net, ctx->family);
 }
 
diff --git a/net/netfilter/xt_sctp.c b/net/netfilter/xt_sctp.c
index 2d2fa1d53ea6..05495d3f47b8 100644
--- a/net/netfilter/xt_sctp.c
+++ b/net/netfilter/xt_sctp.c
@@ -149,6 +149,8 @@ static int sctp_mt_check(const struct xt_mtchk_param *par)
 {
 	const struct xt_sctp_info *info = par->matchinfo;
 
+	if (info->flag_count > ARRAY_SIZE(info->flag_info))
+		return -EINVAL;
 	if (info->flags & ~XT_SCTP_VALID_FLAGS)
 		return -EINVAL;
 	if (info->invflags & ~XT_SCTP_VALID_FLAGS)
diff --git a/net/netfilter/xt_u32.c b/net/netfilter/xt_u32.c
index a95b50342dbb..58ba402bc0b0 100644
--- a/net/netfilter/xt_u32.c
+++ b/net/netfilter/xt_u32.c
@@ -95,11 +95,32 @@ static bool u32_mt(const struct sk_buff *skb, struct xt_action_param *par)
 	return ret ^ data->invert;
 }
 
+static int u32_mt_checkentry(const struct xt_mtchk_param *par)
+{
+	const struct xt_u32 *data = par->matchinfo;
+	const struct xt_u32_test *ct;
+	unsigned int i;
+
+	if (data->ntests > ARRAY_SIZE(data->tests))
+		return -EINVAL;
+
+	for (i = 0; i < data->ntests; ++i) {
+		ct = &data->tests[i];
+
+		if (ct->nnums > ARRAY_SIZE(ct->location) ||
+		    ct->nvalues > ARRAY_SIZE(ct->value))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static struct xt_match xt_u32_mt_reg __read_mostly = {
 	.name       = "u32",
 	.revision   = 0,
 	.family     = NFPROTO_UNSPEC,
 	.match      = u32_mt,
+	.checkentry = u32_mt_checkentry,
 	.matchsize  = sizeof(struct xt_u32),
 	.me         = THIS_MODULE,
 };
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 15fe2120b310..14c3d640f94b 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -871,7 +871,8 @@ int netlbl_catmap_setlong(struct netlbl_lsm_catmap **catmap,
 
 	offset -= iter->startbit;
 	idx = offset / NETLBL_CATMAP_MAPSIZE;
-	iter->bitmap[idx] |= bitmap << (offset % NETLBL_CATMAP_MAPSIZE);
+	iter->bitmap[idx] |= (NETLBL_CATMAP_MAPTYPE)bitmap
+			     << (offset % NETLBL_CATMAP_MAPSIZE);
 
 	return 0;
 }
diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index a5d819fa7c89..146550ce0ac6 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -663,6 +663,11 @@ static int nr_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out_release;
 	}
 
+	if (sock->state == SS_CONNECTING) {
+		err = -EALREADY;
+		goto out_release;
+	}
+
 	sk->sk_state   = TCP_CLOSE;
 	sock->state = SS_UNCONNECTED;
 
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 4547022ed7f4..7698a8974a47 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -503,34 +503,6 @@ config CLS_U32_MARK
 	---help---
 	  Say Y here to be able to use netfilter marks as u32 key.
 
-config NET_CLS_RSVP
-	tristate "IPv4 Resource Reservation Protocol (RSVP)"
-	select NET_CLS
-	---help---
-	  The Resource Reservation Protocol (RSVP) permits end systems to
-	  request a minimum and maximum data flow rate for a connection; this
-	  is important for real time data such as streaming sound or video.
-
-	  Say Y here if you want to be able to classify outgoing packets based
-	  on their RSVP requests.
-
-	  To compile this code as a module, choose M here: the
-	  module will be called cls_rsvp.
-
-config NET_CLS_RSVP6
-	tristate "IPv6 Resource Reservation Protocol (RSVP6)"
-	select NET_CLS
-	---help---
-	  The Resource Reservation Protocol (RSVP) permits end systems to
-	  request a minimum and maximum data flow rate for a connection; this
-	  is important for real time data such as streaming sound or video.
-
-	  Say Y here if you want to be able to classify outgoing packets based
-	  on their RSVP requests and you are using the IPv6 protocol.
-
-	  To compile this code as a module, choose M here: the
-	  module will be called cls_rsvp6.
-
 config NET_CLS_FLOW
 	tristate "Flow classifier"
 	select NET_CLS
diff --git a/net/sched/Makefile b/net/sched/Makefile
index 5eed580cdb42..3139c32e1947 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -61,8 +61,6 @@ obj-$(CONFIG_NET_SCH_ETF)	+= sch_etf.o
 obj-$(CONFIG_NET_CLS_U32)	+= cls_u32.o
 obj-$(CONFIG_NET_CLS_ROUTE4)	+= cls_route.o
 obj-$(CONFIG_NET_CLS_FW)	+= cls_fw.o
-obj-$(CONFIG_NET_CLS_RSVP)	+= cls_rsvp.o
-obj-$(CONFIG_NET_CLS_RSVP6)	+= cls_rsvp6.o
 obj-$(CONFIG_NET_CLS_BASIC)	+= cls_basic.o
 obj-$(CONFIG_NET_CLS_FLOW)	+= cls_flow.o
 obj-$(CONFIG_NET_CLS_CGROUP)	+= cls_cgroup.o
diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index 5284a473c697..f15089c24a32 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -277,7 +277,6 @@ static int fw_change(struct net *net, struct sk_buff *in_skb,
 			return -ENOBUFS;
 
 		fnew->id = f->id;
-		fnew->res = f->res;
 #ifdef CONFIG_NET_CLS_IND
 		fnew->ifindex = f->ifindex;
 #endif /* CONFIG_NET_CLS_IND */
diff --git a/net/sched/cls_rsvp.c b/net/sched/cls_rsvp.c
deleted file mode 100644
index cbb5e0d600f3..000000000000
--- a/net/sched/cls_rsvp.c
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * net/sched/cls_rsvp.c	Special RSVP packet classifier for IPv4.
- *
- *		This program is free software; you can redistribute it and/or
- *		modify it under the terms of the GNU General Public License
- *		as published by the Free Software Foundation; either version
- *		2 of the License, or (at your option) any later version.
- *
- * Authors:	Alexey Kuznetsov, <kuznet@ms2.inr.ac.ru>
- */
-
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/skbuff.h>
-#include <net/ip.h>
-#include <net/netlink.h>
-#include <net/act_api.h>
-#include <net/pkt_cls.h>
-
-#define RSVP_DST_LEN	1
-#define RSVP_ID		"rsvp"
-#define RSVP_OPS	cls_rsvp_ops
-
-#include "cls_rsvp.h"
-MODULE_LICENSE("GPL");
diff --git a/net/sched/cls_rsvp.h b/net/sched/cls_rsvp.h
deleted file mode 100644
index eb1dd2afc5a1..000000000000
--- a/net/sched/cls_rsvp.h
+++ /dev/null
@@ -1,775 +0,0 @@
-/*
- * net/sched/cls_rsvp.h	Template file for RSVPv[46] classifiers.
- *
- *		This program is free software; you can redistribute it and/or
- *		modify it under the terms of the GNU General Public License
- *		as published by the Free Software Foundation; either version
- *		2 of the License, or (at your option) any later version.
- *
- * Authors:	Alexey Kuznetsov, <kuznet@ms2.inr.ac.ru>
- */
-
-/*
-   Comparing to general packet classification problem,
-   RSVP needs only sevaral relatively simple rules:
-
-   * (dst, protocol) are always specified,
-     so that we are able to hash them.
-   * src may be exact, or may be wildcard, so that
-     we can keep a hash table plus one wildcard entry.
-   * source port (or flow label) is important only if src is given.
-
-   IMPLEMENTATION.
-
-   We use a two level hash table: The top level is keyed by
-   destination address and protocol ID, every bucket contains a list
-   of "rsvp sessions", identified by destination address, protocol and
-   DPI(="Destination Port ID"): triple (key, mask, offset).
-
-   Every bucket has a smaller hash table keyed by source address
-   (cf. RSVP flowspec) and one wildcard entry for wildcard reservations.
-   Every bucket is again a list of "RSVP flows", selected by
-   source address and SPI(="Source Port ID" here rather than
-   "security parameter index"): triple (key, mask, offset).
-
-
-   NOTE 1. All the packets with IPv6 extension headers (but AH and ESP)
-   and all fragmented packets go to the best-effort traffic class.
-
-
-   NOTE 2. Two "port id"'s seems to be redundant, rfc2207 requires
-   only one "Generalized Port Identifier". So that for classic
-   ah, esp (and udp,tcp) both *pi should coincide or one of them
-   should be wildcard.
-
-   At first sight, this redundancy is just a waste of CPU
-   resources. But DPI and SPI add the possibility to assign different
-   priorities to GPIs. Look also at note 4 about tunnels below.
-
-
-   NOTE 3. One complication is the case of tunneled packets.
-   We implement it as following: if the first lookup
-   matches a special session with "tunnelhdr" value not zero,
-   flowid doesn't contain the true flow ID, but the tunnel ID (1...255).
-   In this case, we pull tunnelhdr bytes and restart lookup
-   with tunnel ID added to the list of keys. Simple and stupid 8)8)
-   It's enough for PIMREG and IPIP.
-
-
-   NOTE 4. Two GPIs make it possible to parse even GRE packets.
-   F.e. DPI can select ETH_P_IP (and necessary flags to make
-   tunnelhdr correct) in GRE protocol field and SPI matches
-   GRE key. Is it not nice? 8)8)
-
-
-   Well, as result, despite its simplicity, we get a pretty
-   powerful classification engine.  */
-
-
-struct rsvp_head {
-	u32			tmap[256/32];
-	u32			hgenerator;
-	u8			tgenerator;
-	struct rsvp_session __rcu *ht[256];
-	struct rcu_head		rcu;
-};
-
-struct rsvp_session {
-	struct rsvp_session __rcu	*next;
-	__be32				dst[RSVP_DST_LEN];
-	struct tc_rsvp_gpi		dpi;
-	u8				protocol;
-	u8				tunnelid;
-	/* 16 (src,sport) hash slots, and one wildcard source slot */
-	struct rsvp_filter __rcu	*ht[16 + 1];
-	struct rcu_head			rcu;
-};
-
-
-struct rsvp_filter {
-	struct rsvp_filter __rcu	*next;
-	__be32				src[RSVP_DST_LEN];
-	struct tc_rsvp_gpi		spi;
-	u8				tunnelhdr;
-
-	struct tcf_result		res;
-	struct tcf_exts			exts;
-
-	u32				handle;
-	struct rsvp_session		*sess;
-	struct rcu_work			rwork;
-};
-
-static inline unsigned int hash_dst(__be32 *dst, u8 protocol, u8 tunnelid)
-{
-	unsigned int h = (__force __u32)dst[RSVP_DST_LEN - 1];
-
-	h ^= h>>16;
-	h ^= h>>8;
-	return (h ^ protocol ^ tunnelid) & 0xFF;
-}
-
-static inline unsigned int hash_src(__be32 *src)
-{
-	unsigned int h = (__force __u32)src[RSVP_DST_LEN-1];
-
-	h ^= h>>16;
-	h ^= h>>8;
-	h ^= h>>4;
-	return h & 0xF;
-}
-
-#define RSVP_APPLY_RESULT()				\
-{							\
-	int r = tcf_exts_exec(skb, &f->exts, res);	\
-	if (r < 0)					\
-		continue;				\
-	else if (r > 0)					\
-		return r;				\
-}
-
-static int rsvp_classify(struct sk_buff *skb, const struct tcf_proto *tp,
-			 struct tcf_result *res)
-{
-	struct rsvp_head *head = rcu_dereference_bh(tp->root);
-	struct rsvp_session *s;
-	struct rsvp_filter *f;
-	unsigned int h1, h2;
-	__be32 *dst, *src;
-	u8 protocol;
-	u8 tunnelid = 0;
-	u8 *xprt;
-#if RSVP_DST_LEN == 4
-	struct ipv6hdr *nhptr;
-
-	if (!pskb_network_may_pull(skb, sizeof(*nhptr)))
-		return -1;
-	nhptr = ipv6_hdr(skb);
-#else
-	struct iphdr *nhptr;
-
-	if (!pskb_network_may_pull(skb, sizeof(*nhptr)))
-		return -1;
-	nhptr = ip_hdr(skb);
-#endif
-restart:
-
-#if RSVP_DST_LEN == 4
-	src = &nhptr->saddr.s6_addr32[0];
-	dst = &nhptr->daddr.s6_addr32[0];
-	protocol = nhptr->nexthdr;
-	xprt = ((u8 *)nhptr) + sizeof(struct ipv6hdr);
-#else
-	src = &nhptr->saddr;
-	dst = &nhptr->daddr;
-	protocol = nhptr->protocol;
-	xprt = ((u8 *)nhptr) + (nhptr->ihl<<2);
-	if (ip_is_fragment(nhptr))
-		return -1;
-#endif
-
-	h1 = hash_dst(dst, protocol, tunnelid);
-	h2 = hash_src(src);
-
-	for (s = rcu_dereference_bh(head->ht[h1]); s;
-	     s = rcu_dereference_bh(s->next)) {
-		if (dst[RSVP_DST_LEN-1] == s->dst[RSVP_DST_LEN - 1] &&
-		    protocol == s->protocol &&
-		    !(s->dpi.mask &
-		      (*(u32 *)(xprt + s->dpi.offset) ^ s->dpi.key)) &&
-#if RSVP_DST_LEN == 4
-		    dst[0] == s->dst[0] &&
-		    dst[1] == s->dst[1] &&
-		    dst[2] == s->dst[2] &&
-#endif
-		    tunnelid == s->tunnelid) {
-
-			for (f = rcu_dereference_bh(s->ht[h2]); f;
-			     f = rcu_dereference_bh(f->next)) {
-				if (src[RSVP_DST_LEN-1] == f->src[RSVP_DST_LEN - 1] &&
-				    !(f->spi.mask & (*(u32 *)(xprt + f->spi.offset) ^ f->spi.key))
-#if RSVP_DST_LEN == 4
-				    &&
-				    src[0] == f->src[0] &&
-				    src[1] == f->src[1] &&
-				    src[2] == f->src[2]
-#endif
-				    ) {
-					*res = f->res;
-					RSVP_APPLY_RESULT();
-
-matched:
-					if (f->tunnelhdr == 0)
-						return 0;
-
-					tunnelid = f->res.classid;
-					nhptr = (void *)(xprt + f->tunnelhdr - sizeof(*nhptr));
-					goto restart;
-				}
-			}
-
-			/* And wildcard bucket... */
-			for (f = rcu_dereference_bh(s->ht[16]); f;
-			     f = rcu_dereference_bh(f->next)) {
-				*res = f->res;
-				RSVP_APPLY_RESULT();
-				goto matched;
-			}
-			return -1;
-		}
-	}
-	return -1;
-}
-
-static void rsvp_replace(struct tcf_proto *tp, struct rsvp_filter *n, u32 h)
-{
-	struct rsvp_head *head = rtnl_dereference(tp->root);
-	struct rsvp_session *s;
-	struct rsvp_filter __rcu **ins;
-	struct rsvp_filter *pins;
-	unsigned int h1 = h & 0xFF;
-	unsigned int h2 = (h >> 8) & 0xFF;
-
-	for (s = rtnl_dereference(head->ht[h1]); s;
-	     s = rtnl_dereference(s->next)) {
-		for (ins = &s->ht[h2], pins = rtnl_dereference(*ins); ;
-		     ins = &pins->next, pins = rtnl_dereference(*ins)) {
-			if (pins->handle == h) {
-				RCU_INIT_POINTER(n->next, pins->next);
-				rcu_assign_pointer(*ins, n);
-				return;
-			}
-		}
-	}
-
-	/* Something went wrong if we are trying to replace a non-existant
-	 * node. Mind as well halt instead of silently failing.
-	 */
-	BUG_ON(1);
-}
-
-static void *rsvp_get(struct tcf_proto *tp, u32 handle)
-{
-	struct rsvp_head *head = rtnl_dereference(tp->root);
-	struct rsvp_session *s;
-	struct rsvp_filter *f;
-	unsigned int h1 = handle & 0xFF;
-	unsigned int h2 = (handle >> 8) & 0xFF;
-
-	if (h2 > 16)
-		return NULL;
-
-	for (s = rtnl_dereference(head->ht[h1]); s;
-	     s = rtnl_dereference(s->next)) {
-		for (f = rtnl_dereference(s->ht[h2]); f;
-		     f = rtnl_dereference(f->next)) {
-			if (f->handle == handle)
-				return f;
-		}
-	}
-	return NULL;
-}
-
-static int rsvp_init(struct tcf_proto *tp)
-{
-	struct rsvp_head *data;
-
-	data = kzalloc(sizeof(struct rsvp_head), GFP_KERNEL);
-	if (data) {
-		rcu_assign_pointer(tp->root, data);
-		return 0;
-	}
-	return -ENOBUFS;
-}
-
-static void __rsvp_delete_filter(struct rsvp_filter *f)
-{
-	tcf_exts_destroy(&f->exts);
-	tcf_exts_put_net(&f->exts);
-	kfree(f);
-}
-
-static void rsvp_delete_filter_work(struct work_struct *work)
-{
-	struct rsvp_filter *f = container_of(to_rcu_work(work),
-					     struct rsvp_filter,
-					     rwork);
-	rtnl_lock();
-	__rsvp_delete_filter(f);
-	rtnl_unlock();
-}
-
-static void rsvp_delete_filter(struct tcf_proto *tp, struct rsvp_filter *f)
-{
-	tcf_unbind_filter(tp, &f->res);
-	/* all classifiers are required to call tcf_exts_destroy() after rcu
-	 * grace period, since converted-to-rcu actions are relying on that
-	 * in cleanup() callback
-	 */
-	if (tcf_exts_get_net(&f->exts))
-		tcf_queue_work(&f->rwork, rsvp_delete_filter_work);
-	else
-		__rsvp_delete_filter(f);
-}
-
-static void rsvp_destroy(struct tcf_proto *tp, struct netlink_ext_ack *extack)
-{
-	struct rsvp_head *data = rtnl_dereference(tp->root);
-	int h1, h2;
-
-	if (data == NULL)
-		return;
-
-	for (h1 = 0; h1 < 256; h1++) {
-		struct rsvp_session *s;
-
-		while ((s = rtnl_dereference(data->ht[h1])) != NULL) {
-			RCU_INIT_POINTER(data->ht[h1], s->next);
-
-			for (h2 = 0; h2 <= 16; h2++) {
-				struct rsvp_filter *f;
-
-				while ((f = rtnl_dereference(s->ht[h2])) != NULL) {
-					rcu_assign_pointer(s->ht[h2], f->next);
-					rsvp_delete_filter(tp, f);
-				}
-			}
-			kfree_rcu(s, rcu);
-		}
-	}
-	kfree_rcu(data, rcu);
-}
-
-static int rsvp_delete(struct tcf_proto *tp, void *arg, bool *last,
-		       struct netlink_ext_ack *extack)
-{
-	struct rsvp_head *head = rtnl_dereference(tp->root);
-	struct rsvp_filter *nfp, *f = arg;
-	struct rsvp_filter __rcu **fp;
-	unsigned int h = f->handle;
-	struct rsvp_session __rcu **sp;
-	struct rsvp_session *nsp, *s = f->sess;
-	int i, h1;
-
-	fp = &s->ht[(h >> 8) & 0xFF];
-	for (nfp = rtnl_dereference(*fp); nfp;
-	     fp = &nfp->next, nfp = rtnl_dereference(*fp)) {
-		if (nfp == f) {
-			RCU_INIT_POINTER(*fp, f->next);
-			rsvp_delete_filter(tp, f);
-
-			/* Strip tree */
-
-			for (i = 0; i <= 16; i++)
-				if (s->ht[i])
-					goto out;
-
-			/* OK, session has no flows */
-			sp = &head->ht[h & 0xFF];
-			for (nsp = rtnl_dereference(*sp); nsp;
-			     sp = &nsp->next, nsp = rtnl_dereference(*sp)) {
-				if (nsp == s) {
-					RCU_INIT_POINTER(*sp, s->next);
-					kfree_rcu(s, rcu);
-					goto out;
-				}
-			}
-
-			break;
-		}
-	}
-
-out:
-	*last = true;
-	for (h1 = 0; h1 < 256; h1++) {
-		if (rcu_access_pointer(head->ht[h1])) {
-			*last = false;
-			break;
-		}
-	}
-
-	return 0;
-}
-
-static unsigned int gen_handle(struct tcf_proto *tp, unsigned salt)
-{
-	struct rsvp_head *data = rtnl_dereference(tp->root);
-	int i = 0xFFFF;
-
-	while (i-- > 0) {
-		u32 h;
-
-		if ((data->hgenerator += 0x10000) == 0)
-			data->hgenerator = 0x10000;
-		h = data->hgenerator|salt;
-		if (!rsvp_get(tp, h))
-			return h;
-	}
-	return 0;
-}
-
-static int tunnel_bts(struct rsvp_head *data)
-{
-	int n = data->tgenerator >> 5;
-	u32 b = 1 << (data->tgenerator & 0x1F);
-
-	if (data->tmap[n] & b)
-		return 0;
-	data->tmap[n] |= b;
-	return 1;
-}
-
-static void tunnel_recycle(struct rsvp_head *data)
-{
-	struct rsvp_session __rcu **sht = data->ht;
-	u32 tmap[256/32];
-	int h1, h2;
-
-	memset(tmap, 0, sizeof(tmap));
-
-	for (h1 = 0; h1 < 256; h1++) {
-		struct rsvp_session *s;
-		for (s = rtnl_dereference(sht[h1]); s;
-		     s = rtnl_dereference(s->next)) {
-			for (h2 = 0; h2 <= 16; h2++) {
-				struct rsvp_filter *f;
-
-				for (f = rtnl_dereference(s->ht[h2]); f;
-				     f = rtnl_dereference(f->next)) {
-					if (f->tunnelhdr == 0)
-						continue;
-					data->tgenerator = f->res.classid;
-					tunnel_bts(data);
-				}
-			}
-		}
-	}
-
-	memcpy(data->tmap, tmap, sizeof(tmap));
-}
-
-static u32 gen_tunnel(struct rsvp_head *data)
-{
-	int i, k;
-
-	for (k = 0; k < 2; k++) {
-		for (i = 255; i > 0; i--) {
-			if (++data->tgenerator == 0)
-				data->tgenerator = 1;
-			if (tunnel_bts(data))
-				return data->tgenerator;
-		}
-		tunnel_recycle(data);
-	}
-	return 0;
-}
-
-static const struct nla_policy rsvp_policy[TCA_RSVP_MAX + 1] = {
-	[TCA_RSVP_CLASSID]	= { .type = NLA_U32 },
-	[TCA_RSVP_DST]		= { .len = RSVP_DST_LEN * sizeof(u32) },
-	[TCA_RSVP_SRC]		= { .len = RSVP_DST_LEN * sizeof(u32) },
-	[TCA_RSVP_PINFO]	= { .len = sizeof(struct tc_rsvp_pinfo) },
-};
-
-static int rsvp_change(struct net *net, struct sk_buff *in_skb,
-		       struct tcf_proto *tp, unsigned long base,
-		       u32 handle,
-		       struct nlattr **tca,
-		       void **arg, bool ovr, struct netlink_ext_ack *extack)
-{
-	struct rsvp_head *data = rtnl_dereference(tp->root);
-	struct rsvp_filter *f, *nfp;
-	struct rsvp_filter __rcu **fp;
-	struct rsvp_session *nsp, *s;
-	struct rsvp_session __rcu **sp;
-	struct tc_rsvp_pinfo *pinfo = NULL;
-	struct nlattr *opt = tca[TCA_OPTIONS];
-	struct nlattr *tb[TCA_RSVP_MAX + 1];
-	struct tcf_exts e;
-	unsigned int h1, h2;
-	__be32 *dst;
-	int err;
-
-	if (opt == NULL)
-		return handle ? -EINVAL : 0;
-
-	err = nla_parse_nested(tb, TCA_RSVP_MAX, opt, rsvp_policy, NULL);
-	if (err < 0)
-		return err;
-
-	err = tcf_exts_init(&e, TCA_RSVP_ACT, TCA_RSVP_POLICE);
-	if (err < 0)
-		return err;
-	err = tcf_exts_validate(net, tp, tb, tca[TCA_RATE], &e, ovr, extack);
-	if (err < 0)
-		goto errout2;
-
-	f = *arg;
-	if (f) {
-		/* Node exists: adjust only classid */
-		struct rsvp_filter *n;
-
-		if (f->handle != handle && handle)
-			goto errout2;
-
-		n = kmemdup(f, sizeof(*f), GFP_KERNEL);
-		if (!n) {
-			err = -ENOMEM;
-			goto errout2;
-		}
-
-		err = tcf_exts_init(&n->exts, TCA_RSVP_ACT, TCA_RSVP_POLICE);
-		if (err < 0) {
-			kfree(n);
-			goto errout2;
-		}
-
-		if (tb[TCA_RSVP_CLASSID]) {
-			n->res.classid = nla_get_u32(tb[TCA_RSVP_CLASSID]);
-			tcf_bind_filter(tp, &n->res, base);
-		}
-
-		tcf_exts_change(&n->exts, &e);
-		rsvp_replace(tp, n, handle);
-		return 0;
-	}
-
-	/* Now more serious part... */
-	err = -EINVAL;
-	if (handle)
-		goto errout2;
-	if (tb[TCA_RSVP_DST] == NULL)
-		goto errout2;
-
-	err = -ENOBUFS;
-	f = kzalloc(sizeof(struct rsvp_filter), GFP_KERNEL);
-	if (f == NULL)
-		goto errout2;
-
-	err = tcf_exts_init(&f->exts, TCA_RSVP_ACT, TCA_RSVP_POLICE);
-	if (err < 0)
-		goto errout;
-	h2 = 16;
-	if (tb[TCA_RSVP_SRC]) {
-		memcpy(f->src, nla_data(tb[TCA_RSVP_SRC]), sizeof(f->src));
-		h2 = hash_src(f->src);
-	}
-	if (tb[TCA_RSVP_PINFO]) {
-		pinfo = nla_data(tb[TCA_RSVP_PINFO]);
-		f->spi = pinfo->spi;
-		f->tunnelhdr = pinfo->tunnelhdr;
-	}
-	if (tb[TCA_RSVP_CLASSID])
-		f->res.classid = nla_get_u32(tb[TCA_RSVP_CLASSID]);
-
-	dst = nla_data(tb[TCA_RSVP_DST]);
-	h1 = hash_dst(dst, pinfo ? pinfo->protocol : 0, pinfo ? pinfo->tunnelid : 0);
-
-	err = -ENOMEM;
-	if ((f->handle = gen_handle(tp, h1 | (h2<<8))) == 0)
-		goto errout;
-
-	if (f->tunnelhdr) {
-		err = -EINVAL;
-		if (f->res.classid > 255)
-			goto errout;
-
-		err = -ENOMEM;
-		if (f->res.classid == 0 &&
-		    (f->res.classid = gen_tunnel(data)) == 0)
-			goto errout;
-	}
-
-	for (sp = &data->ht[h1];
-	     (s = rtnl_dereference(*sp)) != NULL;
-	     sp = &s->next) {
-		if (dst[RSVP_DST_LEN-1] == s->dst[RSVP_DST_LEN-1] &&
-		    pinfo && pinfo->protocol == s->protocol &&
-		    memcmp(&pinfo->dpi, &s->dpi, sizeof(s->dpi)) == 0 &&
-#if RSVP_DST_LEN == 4
-		    dst[0] == s->dst[0] &&
-		    dst[1] == s->dst[1] &&
-		    dst[2] == s->dst[2] &&
-#endif
-		    pinfo->tunnelid == s->tunnelid) {
-
-insert:
-			/* OK, we found appropriate session */
-
-			fp = &s->ht[h2];
-
-			f->sess = s;
-			if (f->tunnelhdr == 0)
-				tcf_bind_filter(tp, &f->res, base);
-
-			tcf_exts_change(&f->exts, &e);
-
-			fp = &s->ht[h2];
-			for (nfp = rtnl_dereference(*fp); nfp;
-			     fp = &nfp->next, nfp = rtnl_dereference(*fp)) {
-				__u32 mask = nfp->spi.mask & f->spi.mask;
-
-				if (mask != f->spi.mask)
-					break;
-			}
-			RCU_INIT_POINTER(f->next, nfp);
-			rcu_assign_pointer(*fp, f);
-
-			*arg = f;
-			return 0;
-		}
-	}
-
-	/* No session found. Create new one. */
-
-	err = -ENOBUFS;
-	s = kzalloc(sizeof(struct rsvp_session), GFP_KERNEL);
-	if (s == NULL)
-		goto errout;
-	memcpy(s->dst, dst, sizeof(s->dst));
-
-	if (pinfo) {
-		s->dpi = pinfo->dpi;
-		s->protocol = pinfo->protocol;
-		s->tunnelid = pinfo->tunnelid;
-	}
-	sp = &data->ht[h1];
-	for (nsp = rtnl_dereference(*sp); nsp;
-	     sp = &nsp->next, nsp = rtnl_dereference(*sp)) {
-		if ((nsp->dpi.mask & s->dpi.mask) != s->dpi.mask)
-			break;
-	}
-	RCU_INIT_POINTER(s->next, nsp);
-	rcu_assign_pointer(*sp, s);
-
-	goto insert;
-
-errout:
-	tcf_exts_destroy(&f->exts);
-	kfree(f);
-errout2:
-	tcf_exts_destroy(&e);
-	return err;
-}
-
-static void rsvp_walk(struct tcf_proto *tp, struct tcf_walker *arg)
-{
-	struct rsvp_head *head = rtnl_dereference(tp->root);
-	unsigned int h, h1;
-
-	if (arg->stop)
-		return;
-
-	for (h = 0; h < 256; h++) {
-		struct rsvp_session *s;
-
-		for (s = rtnl_dereference(head->ht[h]); s;
-		     s = rtnl_dereference(s->next)) {
-			for (h1 = 0; h1 <= 16; h1++) {
-				struct rsvp_filter *f;
-
-				for (f = rtnl_dereference(s->ht[h1]); f;
-				     f = rtnl_dereference(f->next)) {
-					if (arg->count < arg->skip) {
-						arg->count++;
-						continue;
-					}
-					if (arg->fn(tp, f, arg) < 0) {
-						arg->stop = 1;
-						return;
-					}
-					arg->count++;
-				}
-			}
-		}
-	}
-}
-
-static int rsvp_dump(struct net *net, struct tcf_proto *tp, void *fh,
-		     struct sk_buff *skb, struct tcmsg *t)
-{
-	struct rsvp_filter *f = fh;
-	struct rsvp_session *s;
-	struct nlattr *nest;
-	struct tc_rsvp_pinfo pinfo;
-
-	if (f == NULL)
-		return skb->len;
-	s = f->sess;
-
-	t->tcm_handle = f->handle;
-
-	nest = nla_nest_start(skb, TCA_OPTIONS);
-	if (nest == NULL)
-		goto nla_put_failure;
-
-	if (nla_put(skb, TCA_RSVP_DST, sizeof(s->dst), &s->dst))
-		goto nla_put_failure;
-	pinfo.dpi = s->dpi;
-	pinfo.spi = f->spi;
-	pinfo.protocol = s->protocol;
-	pinfo.tunnelid = s->tunnelid;
-	pinfo.tunnelhdr = f->tunnelhdr;
-	pinfo.pad = 0;
-	if (nla_put(skb, TCA_RSVP_PINFO, sizeof(pinfo), &pinfo))
-		goto nla_put_failure;
-	if (f->res.classid &&
-	    nla_put_u32(skb, TCA_RSVP_CLASSID, f->res.classid))
-		goto nla_put_failure;
-	if (((f->handle >> 8) & 0xFF) != 16 &&
-	    nla_put(skb, TCA_RSVP_SRC, sizeof(f->src), f->src))
-		goto nla_put_failure;
-
-	if (tcf_exts_dump(skb, &f->exts) < 0)
-		goto nla_put_failure;
-
-	nla_nest_end(skb, nest);
-
-	if (tcf_exts_dump_stats(skb, &f->exts) < 0)
-		goto nla_put_failure;
-	return skb->len;
-
-nla_put_failure:
-	nla_nest_cancel(skb, nest);
-	return -1;
-}
-
-static void rsvp_bind_class(void *fh, u32 classid, unsigned long cl, void *q,
-			    unsigned long base)
-{
-	struct rsvp_filter *f = fh;
-
-	if (f && f->res.classid == classid) {
-		if (cl)
-			__tcf_bind_filter(q, &f->res, base);
-		else
-			__tcf_unbind_filter(q, &f->res);
-	}
-}
-
-static struct tcf_proto_ops RSVP_OPS __read_mostly = {
-	.kind		=	RSVP_ID,
-	.classify	=	rsvp_classify,
-	.init		=	rsvp_init,
-	.destroy	=	rsvp_destroy,
-	.get		=	rsvp_get,
-	.change		=	rsvp_change,
-	.delete		=	rsvp_delete,
-	.walk		=	rsvp_walk,
-	.dump		=	rsvp_dump,
-	.bind_class	=	rsvp_bind_class,
-	.owner		=	THIS_MODULE,
-};
-
-static int __init init_rsvp(void)
-{
-	return register_tcf_proto_ops(&RSVP_OPS);
-}
-
-static void __exit exit_rsvp(void)
-{
-	unregister_tcf_proto_ops(&RSVP_OPS);
-}
-
-module_init(init_rsvp)
-module_exit(exit_rsvp)
diff --git a/net/sched/cls_rsvp6.c b/net/sched/cls_rsvp6.c
deleted file mode 100644
index dd08aea2aee5..000000000000
--- a/net/sched/cls_rsvp6.c
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * net/sched/cls_rsvp6.c	Special RSVP packet classifier for IPv6.
- *
- *		This program is free software; you can redistribute it and/or
- *		modify it under the terms of the GNU General Public License
- *		as published by the Free Software Foundation; either version
- *		2 of the License, or (at your option) any later version.
- *
- * Authors:	Alexey Kuznetsov, <kuznet@ms2.inr.ac.ru>
- */
-
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/ipv6.h>
-#include <linux/skbuff.h>
-#include <net/act_api.h>
-#include <net/pkt_cls.h>
-#include <net/netlink.h>
-
-#define RSVP_DST_LEN	4
-#define RSVP_ID		"rsvp6"
-#define RSVP_OPS	cls_rsvp6_ops
-
-#include "cls_rsvp.h"
-MODULE_LICENSE("GPL");
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index b18ec1f6de60..fa3d2fd4990c 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1021,6 +1021,10 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		if (parent == NULL)
 			return -ENOENT;
 	}
+	if (!(parent->cl_flags & HFSC_FSC) && parent != &q->root) {
+		NL_SET_ERR_MSG(extack, "Invalid parent - parent class must have FSC");
+		return -EINVAL;
+	}
 
 	if (classid == 0 || TC_H_MAJ(classid ^ sch->handle) != 0)
 		return -EINVAL;
diff --git a/net/sched/sch_plug.c b/net/sched/sch_plug.c
index 5619d2eb17b6..4ddb4af61d10 100644
--- a/net/sched/sch_plug.c
+++ b/net/sched/sch_plug.c
@@ -214,7 +214,7 @@ static struct Qdisc_ops plug_qdisc_ops __read_mostly = {
 	.priv_size   =       sizeof(struct plug_sched_data),
 	.enqueue     =       plug_enqueue,
 	.dequeue     =       plug_dequeue,
-	.peek        =       qdisc_peek_head,
+	.peek        =       qdisc_peek_dequeued,
 	.init        =       plug_init,
 	.change      =       plug_change,
 	.reset       =	     qdisc_reset_queue,
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index e9420ca261d6..4f246599734e 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -988,10 +988,13 @@ static void qfq_update_eligible(struct qfq_sched *q)
 }
 
 /* Dequeue head packet of the head class in the DRR queue of the aggregate. */
-static void agg_dequeue(struct qfq_aggregate *agg,
-			struct qfq_class *cl, unsigned int len)
+static struct sk_buff *agg_dequeue(struct qfq_aggregate *agg,
+				   struct qfq_class *cl, unsigned int len)
 {
-	qdisc_dequeue_peeked(cl->qdisc);
+	struct sk_buff *skb = qdisc_dequeue_peeked(cl->qdisc);
+
+	if (!skb)
+		return NULL;
 
 	cl->deficit -= (int) len;
 
@@ -1001,6 +1004,8 @@ static void agg_dequeue(struct qfq_aggregate *agg,
 		cl->deficit += agg->lmax;
 		list_move_tail(&cl->alist, &agg->active);
 	}
+
+	return skb;
 }
 
 static inline struct sk_buff *qfq_peek_skb(struct qfq_aggregate *agg,
@@ -1146,11 +1151,18 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
 	if (!skb)
 		return NULL;
 
-	qdisc_qstats_backlog_dec(sch, skb);
 	sch->q.qlen--;
+
+	skb = agg_dequeue(in_serv_agg, cl, len);
+
+	if (!skb) {
+		sch->q.qlen++;
+		return NULL;
+	}
+
+	qdisc_qstats_backlog_dec(sch, skb);
 	qdisc_bstats_update(sch, skb);
 
-	agg_dequeue(in_serv_agg, cl, len);
 	/* If lmax is lowered, through qfq_change_class, for a class
 	 * owning pending packets with larger size than the new value
 	 * of lmax, then the following condition may hold.
diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
index 82d96441e64d..c4a2d647e6cc 100644
--- a/net/sctp/sm_sideeffect.c
+++ b/net/sctp/sm_sideeffect.c
@@ -1255,7 +1255,10 @@ static int sctp_side_effects(enum sctp_event event_type,
 	default:
 		pr_err("impossible disposition %d in state %d, event_type %d, event_id %d\n",
 		       status, state, event_type, subtype.chunk);
-		BUG();
+		error = status;
+		if (error >= 0)
+			error = -EINVAL;
+		WARN_ON_ONCE(1);
 		break;
 	}
 
diff --git a/net/socket.c b/net/socket.c
index ce70c01eb2f3..db9d908198f2 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3468,7 +3468,11 @@ EXPORT_SYMBOL(kernel_accept);
 int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
 		   int flags)
 {
-	return sock->ops->connect(sock, addr, addrlen, flags);
+	struct sockaddr_storage address;
+
+	memcpy(&address, addr, addrlen);
+
+	return sock->ops->connect(sock, (struct sockaddr *)&address, addrlen, flags);
 }
 EXPORT_SYMBOL(kernel_connect);
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 402060cf3198..0632b494d329 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -594,7 +594,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 	 *	  What the above comment does talk about? --ANK(980817)
 	 */
 
-	if (unix_tot_inflight)
+	if (READ_ONCE(unix_tot_inflight))
 		unix_gc();		/* Garbage collect fds */
 }
 
diff --git a/net/unix/scm.c b/net/unix/scm.c
index a07b2efbf8b5..ac206bfdbbe3 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -59,7 +59,7 @@ void unix_inflight(struct user_struct *user, struct file *fp)
 		/* Paired with READ_ONCE() in wait_for_unix_gc() */
 		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + 1);
 	}
-	user->unix_inflight++;
+	WRITE_ONCE(user->unix_inflight, user->unix_inflight + 1);
 	spin_unlock(&unix_gc_lock);
 }
 
@@ -80,7 +80,7 @@ void unix_notinflight(struct user_struct *user, struct file *fp)
 		/* Paired with READ_ONCE() in wait_for_unix_gc() */
 		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - 1);
 	}
-	user->unix_inflight--;
+	WRITE_ONCE(user->unix_inflight, user->unix_inflight - 1);
 	spin_unlock(&unix_gc_lock);
 }
 
@@ -94,7 +94,7 @@ static inline bool too_many_unix_fds(struct task_struct *p)
 {
 	struct user_struct *user = current_user();
 
-	if (unlikely(user->unix_inflight > task_rlimit(p, RLIMIT_NOFILE)))
+	if (unlikely(READ_ONCE(user->unix_inflight) > task_rlimit(p, RLIMIT_NOFILE)))
 		return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
 	return false;
 }
diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index 8c7e51a6273c..0b0d6ed3eeb9 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -393,6 +393,9 @@ static char *eval_clause(const char *str, size_t len, int argc, char *argv[])
 
 		p++;
 	}
+
+	if (new_argc >= FUNCTION_MAX_ARGS)
+		pperror("too many function arguments");
 	new_argv[new_argc++] = prev;
 
 	/*
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 9394d72a77e8..9e52a3e0fc67 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -922,14 +922,19 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 	ret = -EACCES;
 	down_write(&key->sem);
 
-	if (!capable(CAP_SYS_ADMIN)) {
+	{
+		bool is_privileged_op = false;
+
 		/* only the sysadmin can chown a key to some other UID */
 		if (user != (uid_t) -1 && !uid_eq(key->uid, uid))
-			goto error_put;
+			is_privileged_op = true;
 
 		/* only the sysadmin can set the key's GID to a group other
 		 * than one of those that the current process subscribes to */
 		if (group != (gid_t) -1 && !gid_eq(gid, key->gid) && !in_group_p(gid))
+			is_privileged_op = true;
+
+		if (is_privileged_op && !capable(CAP_SYS_ADMIN))
 			goto error_put;
 	}
 
@@ -1029,7 +1034,7 @@ long keyctl_setperm_key(key_serial_t id, key_perm_t perm)
 	down_write(&key->sem);
 
 	/* if we're not the sysadmin, we can only change a key that we own */
-	if (capable(CAP_SYS_ADMIN) || uid_eq(key->uid, current_fsuid())) {
+	if (uid_eq(key->uid, current_fsuid()) || capable(CAP_SYS_ADMIN)) {
 		key->perm = perm;
 		ret = 0;
 	}
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index a9c516362170..61e734baa332 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -923,7 +923,7 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 	}
 
 	ret = sscanf(rule, "%d", &catlen);
-	if (ret != 1 || catlen > SMACK_CIPSO_MAXCATNUM)
+	if (ret != 1 || catlen < 0 || catlen > SMACK_CIPSO_MAXCATNUM)
 		goto out;
 
 	if (format == SMK_FIXED24_FMT &&
diff --git a/sound/Kconfig b/sound/Kconfig
index 1140e9988fc5..76febc37862d 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -1,6 +1,6 @@
 menuconfig SOUND
 	tristate "Sound card support"
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM || UML
 	help
 	  If you have a sound card in your computer, i.e. if it can say more
 	  than an occasional beep, say Y.
diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index 946ab080ac00..7c5799fecfa1 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -329,10 +329,14 @@ static int snd_pcm_ioctl_hw_params_compat(struct snd_pcm_substream *substream,
 		goto error;
 	}
 
-	if (refine)
+	if (refine) {
 		err = snd_pcm_hw_refine(substream, data);
-	else
+		if (err < 0)
+			goto error;
+		err = fixup_unreferenced_params(substream, data);
+	} else {
 		err = snd_pcm_hw_params(substream, data);
+	}
 	if (err < 0)
 		goto error;
 	if (copy_to_user(data32, data, sizeof(*data32)) ||
diff --git a/sound/core/seq/oss/seq_oss_midi.c b/sound/core/seq/oss/seq_oss_midi.c
index 838c3c8b403c..2ddfd6fed122 100644
--- a/sound/core/seq/oss/seq_oss_midi.c
+++ b/sound/core/seq/oss/seq_oss_midi.c
@@ -50,6 +50,7 @@ struct seq_oss_midi {
 	struct snd_midi_event *coder;	/* MIDI event coder */
 	struct seq_oss_devinfo *devinfo;	/* assigned OSSseq device */
 	snd_use_lock_t use_lock;
+	struct mutex open_mutex;
 };
 
 
@@ -184,6 +185,7 @@ snd_seq_oss_midi_check_new_port(struct snd_seq_port_info *pinfo)
 	mdev->flags = pinfo->capability;
 	mdev->opened = 0;
 	snd_use_lock_init(&mdev->use_lock);
+	mutex_init(&mdev->open_mutex);
 
 	/* copy and truncate the name of synth device */
 	strlcpy(mdev->name, pinfo->name, sizeof(mdev->name));
@@ -332,14 +334,16 @@ snd_seq_oss_midi_open(struct seq_oss_devinfo *dp, int dev, int fmode)
 	int perm;
 	struct seq_oss_midi *mdev;
 	struct snd_seq_port_subscribe subs;
+	int err;
 
 	if ((mdev = get_mididev(dp, dev)) == NULL)
 		return -ENODEV;
 
+	mutex_lock(&mdev->open_mutex);
 	/* already used? */
 	if (mdev->opened && mdev->devinfo != dp) {
-		snd_use_lock_free(&mdev->use_lock);
-		return -EBUSY;
+		err = -EBUSY;
+		goto unlock;
 	}
 
 	perm = 0;
@@ -349,14 +353,14 @@ snd_seq_oss_midi_open(struct seq_oss_devinfo *dp, int dev, int fmode)
 		perm |= PERM_READ;
 	perm &= mdev->flags;
 	if (perm == 0) {
-		snd_use_lock_free(&mdev->use_lock);
-		return -ENXIO;
+		err = -ENXIO;
+		goto unlock;
 	}
 
 	/* already opened? */
 	if ((mdev->opened & perm) == perm) {
-		snd_use_lock_free(&mdev->use_lock);
-		return 0;
+		err = 0;
+		goto unlock;
 	}
 
 	perm &= ~mdev->opened;
@@ -381,13 +385,17 @@ snd_seq_oss_midi_open(struct seq_oss_devinfo *dp, int dev, int fmode)
 	}
 
 	if (! mdev->opened) {
-		snd_use_lock_free(&mdev->use_lock);
-		return -ENXIO;
+		err = -ENXIO;
+		goto unlock;
 	}
 
 	mdev->devinfo = dp;
+	err = 0;
+
+ unlock:
+	mutex_unlock(&mdev->open_mutex);
 	snd_use_lock_free(&mdev->use_lock);
-	return 0;
+	return err;
 }
 
 /*
@@ -401,10 +409,9 @@ snd_seq_oss_midi_close(struct seq_oss_devinfo *dp, int dev)
 
 	if ((mdev = get_mididev(dp, dev)) == NULL)
 		return -ENODEV;
-	if (! mdev->opened || mdev->devinfo != dp) {
-		snd_use_lock_free(&mdev->use_lock);
-		return 0;
-	}
+	mutex_lock(&mdev->open_mutex);
+	if (!mdev->opened || mdev->devinfo != dp)
+		goto unlock;
 
 	memset(&subs, 0, sizeof(subs));
 	if (mdev->opened & PERM_WRITE) {
@@ -423,6 +430,8 @@ snd_seq_oss_midi_close(struct seq_oss_devinfo *dp, int dev)
 	mdev->opened = 0;
 	mdev->devinfo = NULL;
 
+ unlock:
+	mutex_unlock(&mdev->open_mutex);
 	snd_use_lock_free(&mdev->use_lock);
 	return 0;
 }
diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 3f13666a0190..64a1bd420637 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -2026,10 +2026,9 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 		.dev_disconnect =	snd_ac97_dev_disconnect,
 	};
 
-	if (!rac97)
-		return -EINVAL;
-	if (snd_BUG_ON(!bus || !template))
+	if (snd_BUG_ON(!bus || !template || !rac97))
 		return -EINVAL;
+	*rac97 = NULL;
 	if (snd_BUG_ON(template->num >= 4))
 		return -EINVAL;
 	if (bus->codec[template->num])
diff --git a/sound/soc/atmel/atmel-i2s.c b/sound/soc/atmel/atmel-i2s.c
index 99cc73150576..ab7f76117474 100644
--- a/sound/soc/atmel/atmel-i2s.c
+++ b/sound/soc/atmel/atmel-i2s.c
@@ -174,11 +174,14 @@ struct atmel_i2s_gck_param {
 
 #define I2S_MCK_12M288		12288000UL
 #define I2S_MCK_11M2896		11289600UL
+#define I2S_MCK_6M144		6144000UL
 
 /* mck = (32 * (imckfs+1) / (imckdiv+1)) * fs */
 static const struct atmel_i2s_gck_param gck_params[] = {
+	/* mck = 6.144Mhz */
+	{  8000, I2S_MCK_6M144,  1, 47},	/* mck =  768 fs */
+
 	/* mck = 12.288MHz */
-	{  8000, I2S_MCK_12M288, 0, 47},	/* mck = 1536 fs */
 	{ 16000, I2S_MCK_12M288, 1, 47},	/* mck =  768 fs */
 	{ 24000, I2S_MCK_12M288, 3, 63},	/* mck =  512 fs */
 	{ 32000, I2S_MCK_12M288, 3, 47},	/* mck =  384 fs */
diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 2c7d5088e6f2..7e18e007a639 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -351,11 +351,15 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
 	u8 events[DA7219_AAD_IRQ_REG_MAX];
 	u8 statusa;
-	int i, report = 0, mask = 0;
+	int i, ret, report = 0, mask = 0;
 
 	/* Read current IRQ events */
-	regmap_bulk_read(da7219->regmap, DA7219_ACCDET_IRQ_EVENT_A,
-			 events, DA7219_AAD_IRQ_REG_MAX);
+	ret = regmap_bulk_read(da7219->regmap, DA7219_ACCDET_IRQ_EVENT_A,
+			       events, DA7219_AAD_IRQ_REG_MAX);
+	if (ret) {
+		dev_warn_ratelimited(component->dev, "Failed to read IRQ events: %d\n", ret);
+		return IRQ_NONE;
+	}
 
 	if (!events[DA7219_AAD_IRQ_REG_A] && !events[DA7219_AAD_IRQ_REG_B])
 		return IRQ_NONE;
@@ -859,6 +863,8 @@ void da7219_aad_suspend(struct snd_soc_component *component)
 			}
 		}
 	}
+
+	synchronize_irq(da7219_aad->irq);
 }
 
 void da7219_aad_resume(struct snd_soc_component *component)
diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 834e542021fe..0fc4755fd0d9 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -145,7 +145,7 @@ static const char * const es8316_dmic_txt[] = {
 		"dmic data at high level",
 		"dmic data at low level",
 };
-static const unsigned int es8316_dmic_values[] = { 0, 1, 2 };
+static const unsigned int es8316_dmic_values[] = { 0, 2, 3 };
 static const struct soc_enum es8316_dmic_src_enum =
 	SOC_VALUE_ENUM_SINGLE(ES8316_ADC_DMIC, 0, 3,
 			      ARRAY_SIZE(es8316_dmic_txt),
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index ed34902022c1..31e07e4b5411 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -1704,7 +1704,7 @@ static void hists_browser__hierarchy_headers(struct hist_browser *browser)
 	hists_browser__scnprintf_hierarchy_headers(browser, headers,
 						   sizeof(headers));
 
-	ui_browser__gotorc(&browser->b, 0, 0);
+	ui_browser__gotorc_title(&browser->b, 0, 0);
 	ui_browser__set_color(&browser->b, HE_COLORSET_ROOT);
 	ui_browser__write_nstring(&browser->b, headers, browser->b.width + 1);
 }
