Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDA17BF1C2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442094AbjJJD7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442092AbjJJD7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:59:19 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A1B9D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 20:59:16 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39A3x5oU019758;
        Mon, 9 Oct 2023 22:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696910345;
        bh=0ld45nnq87k6I0z0mn8nBSyNRk3GHssowbuvED6PFzo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jiRDRSr3Qa//sN/yp2sRfEFgTPFhB7akL/alD+BIfvJzW3bq5ij8ONSp0uO26yl6N
         hzbkwn74paBACJsaxRXPY//ZA37SOBjxoyuxLT2gHBJc5+ZjXEY+M+i/zDk6jpUtpH
         DOSlVQ+2KfbRlusISMtWkYZYLYiewa+mXivr71EQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39A3x5o9074535
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Oct 2023 22:59:05 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Oct 2023 22:59:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Oct 2023 22:59:05 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39A3x5xs015634;
        Mon, 9 Oct 2023 22:59:05 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am62p5-sk: Updates for SK EVM
Date:   Mon, 9 Oct 2023 22:59:06 -0500
Message-ID: <20231010035903.520635-6-bb@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010035903.520635-4-bb@ti.com>
References: <20231010035903.520635-4-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17497; i=bb@ti.com; h=from:subject; bh=27bBZ3XHXBNao9cIobRmLU1LSR5V/KVAPm+X5lk3X+g=; b=owNCWmg5MUFZJlNZcfO4tgAAZn////fPO/X/PY/uahdY//W+ZvW//vaxvd/j4l3O/vZcn/8wA RswIekAADTQMgAaDEAaGRkDQDI0NGTRoHpBoGgA0ADTJoGRp6gGARmjTU8ogDRoYhiAyNNNNGmg AME0aMhkaAGgBk0Gh6hoaNpMhkZHlBpkAYEaNNAGmIHCeoaaAANBppkNGhoxNGEyGhpoBoYhkwR iYTIGgDQaaaAYI0ZMQNDINGgAAF3Im5Lwj8iNlfaTl6YfBhUoYNe+jNvBlM6WqREyC7ewFcBND7 HzZNMATb0aCFDqAwDGp6+Dd9LDAg9zu/QBxW6PbUXnwzo69Z9l4P6Dyq1BHzdLcIAaPRwlGHAyg 6BkfvfkJ9zMHopkq7W8lxLzH0wsBnXpBW0f4oQPgE7TH9sllm+eIFwOMpU/3t5uMBiTqbxSc/Ty MLheE+IjjhID5kkXzGitatEbLF54hSguZaMfJSp1lwMQmolHlba5EUMZDMlcdjU097WbQEX0ii2 WMLgpziZemAdzqS3YFEfu5dqmngrEr05mhEZOA1E0wNOmTcMsqqk68u1l0QsK2ft15fOrVIhsW7 0CfyXDtWAVIoQw+e93Brn1jV3ULqZ77+xn2wAbRqWJ7pHmB0WqlFOjBn1HKd7m6B/HCAIDjCBwK xaCO5lTH+LuSKcKEg4+dxbA
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vignesh Raghavendra <vigneshr@ti.com>

Update the am62p5-sk board file to enable the new IPs introduced
in the SoC dtb.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 572 +++++++++++++++++++++++-
 1 file changed, 562 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 6fb17b17c95e8..17fe2eb2d7371 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -8,6 +8,9 @@
 
 /dts-v1/;
 
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/net/ti-dp83867.h>
 #include "k3-am62p5.dtsi"
 
 / {
@@ -18,6 +21,14 @@ aliases {
 		serial0 = &wkup_uart0;
 		serial2 = &main_uart0;
 		serial3 = &main_uart1;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+		mmc2 = &sdhci2;
+		spi0 = &ospi0;
+		ethernet0 = &cpsw_port1;
+		ethernet1 = &cpsw_port2;
+		usb0 = &usb0;
+		usb1 = &usb1;
 	};
 
 	chosen {
@@ -29,6 +40,7 @@ memory@80000000 {
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
 		      <0x00000008 0x80000000 0x00000001 0x80000000>;
 		device_type = "memory";
+		bootph-pre-ram;
 	};
 
 	reserved-memory {
@@ -52,28 +64,571 @@ wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
 			no-map;
 		};
 	};
+
+	vmain_pd: regulator-0 {
+		/* TPS65988 PD CONTROLLER OUTPUT */
+		bootph-all;
+		compatible = "regulator-fixed";
+		regulator-name = "vmain_pd";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc_5v0: regulator-1 {
+		/* Output of TPS630702RNMR */
+		bootph-all;
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vmain_pd>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_mmc1: regulator-2 {
+		/* TPS22918DBVR */
+		bootph-all;
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_mmc1";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
+	};
+
+	vddshv_sdio: regulator-3 {
+		bootph-all;
+		compatible = "regulator-gpio";
+		regulator-name = "vddshv_sdio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vddshv_sdio_pins_default>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		gpios = <&main_gpio0 31 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&usr_led_pins_default>;
+
+		led-0 {
+			label = "am62-sk:green:heartbeat";
+			gpios = <&main_gpio1 49 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			function = LED_FUNCTION_HEARTBEAT;
+			default-state = "off";
+		};
+	};
+
+	tlv320_mclk: clk-0 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <12288000>;
+	};
+
+	codec_audio: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "AM62x-SKEVM";
+		simple-audio-card,widgets =
+			"Headphone",	"Headphone Jack",
+			"Line",		"Line In",
+			"Microphone",	"Microphone Jack";
+		simple-audio-card,routing =
+			"Headphone Jack",	"HPLOUT",
+			"Headphone Jack",	"HPROUT",
+			"LINE1L",		"Line In",
+			"LINE1R",		"Line In",
+			"MIC3R",		"Microphone Jack",
+			"Microphone Jack",	"Mic Bias";
+		simple-audio-card,format = "dsp_b";
+		simple-audio-card,bitclock-master = <&sound_master>;
+		simple-audio-card,frame-master = <&sound_master>;
+		simple-audio-card,bitclock-inversion;
+
+		simple-audio-card,cpu {
+			sound-dai = <&mcasp1>;
+		};
+
+		sound_master: simple-audio-card,codec {
+			sound-dai = <&tlv320aic3106>;
+			clocks = <&tlv320_mclk>;
+		};
+	};
+};
+
+&main_gpio0 {
+	bootph-all;
+};
+
+&main_gpio1 {
+	bootph-all;
 };
 
 &main_pmx0 {
+	bootph-all;
+
+	main_i2c0_pins_default: main-i2c0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01e0, PIN_INPUT_PULLUP, 0) /* (B25) I2C0_SCL */
+			AM62PX_IOPAD(0x01e4, PIN_INPUT_PULLUP, 0) /* (A24) I2C0_SDA */
+		>;
+	};
+
+	main_i2c1_pins_default: main-i2c1-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01e8, PIN_INPUT_PULLUP, 0) /* (C24) I2C1_SCL */
+			AM62PX_IOPAD(0x01ec, PIN_INPUT_PULLUP, 0) /* (B24) I2C1_SDA */
+		>;
+	};
+
+	main_i2c2_pins_default: main-i2c2-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00b0, PIN_INPUT_PULLUP, 1) /* (T22) GPMC0_CSn2.I2C2_SCL */
+			AM62PX_IOPAD(0x00b4, PIN_INPUT_PULLUP, 1) /* (U25) GPMC0_CSn3.I2C2_SDA */
+		>;
+	};
+
+	main_gpio1_ioexp_intr_pins_default: main-gpio1-ioexp-intr-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01d4, PIN_INPUT, 7) /* (C22) UART0_RTSn.GPIO1_23 */
+		>;
+	};
+
+	main_mcasp1_pins_default: main-mcasp1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0090, PIN_INPUT, 2) /* (U24) GPMC0_BE0n_CLE.MCASP1_ACLKX */
+			AM62PX_IOPAD(0x0098, PIN_INPUT, 2) /* (AA24) GPMC0_WAIT0.MCASP1_AFSX */
+			AM62PX_IOPAD(0x008c, PIN_INPUT, 2) /* (T25) GPMC0_WEn.MCASP1_AXR0 */
+			AM62PX_IOPAD(0x0084, PIN_INPUT, 2) /* (R25) GPMC0_ADVn_ALE.MCASP1_AXR2 */
+		>;
+	};
+
+	main_mdio1_pins_default: main-mdio1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0160, PIN_OUTPUT, 0) /* (F17) MDIO0_MDC */
+			AM62PX_IOPAD(0x015c, PIN_INPUT, 0) /* (F16) MDIO0_MDIO */
+		>;
+	};
+
+	main_mmc1_pins_default: main-mmc1-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x023c, PIN_INPUT, 0) /* (H20) MMC1_CMD */
+			AM62PX_IOPAD(0x0234, PIN_OUTPUT, 0) /* (J24) MMC1_CLK */
+			AM62PX_IOPAD(0x0230, PIN_INPUT, 0) /* (H21) MMC1_DAT0 */
+			AM62PX_IOPAD(0x022c, PIN_INPUT_PULLUP, 0) /* (H23) MMC1_DAT1 */
+			AM62PX_IOPAD(0x0228, PIN_INPUT_PULLUP, 0) /* (H22) MMC1_DAT2 */
+			AM62PX_IOPAD(0x0224, PIN_INPUT_PULLUP, 0) /* (H25) MMC1_DAT3 */
+			AM62PX_IOPAD(0x0240, PIN_INPUT, 0) /* (D23) MMC1_SDCD */
+		>;
+	};
+
+	main_mmc2_pins_default: main-mmc2-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0120, PIN_INPUT, 0) /* (K24) MMC2_CMD */
+			AM62PX_IOPAD(0x0118, PIN_OUTPUT, 0) /* (K21) MMC2_CLK */
+			AM62PX_IOPAD(0x011C, PIN_INPUT, 0) /* () MMC2_CLKLB */
+			AM62PX_IOPAD(0x0114, PIN_INPUT, 0) /* (K23) MMC2_DAT0 */
+			AM62PX_IOPAD(0x0110, PIN_INPUT_PULLUP, 0) /* (K22) MMC2_DAT1 */
+			AM62PX_IOPAD(0x010c, PIN_INPUT_PULLUP, 0) /* (L20) MMC2_DAT2 */
+			AM62PX_IOPAD(0x0108, PIN_INPUT_PULLUP, 0) /* (L21) MMC2_DAT3 */
+		>;
+	};
+
+	main_rgmii1_pins_default: main-rgmii1-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x014c, PIN_INPUT, 0) /* (B15) RGMII1_RD0 */
+			AM62PX_IOPAD(0x0150, PIN_INPUT, 0) /* (B16) RGMII1_RD1 */
+			AM62PX_IOPAD(0x0154, PIN_INPUT, 0) /* (A14) RGMII1_RD2 */
+			AM62PX_IOPAD(0x0158, PIN_INPUT, 0) /* (B14) RGMII1_RD3 */
+			AM62PX_IOPAD(0x0148, PIN_INPUT, 0) /* (A16) RGMII1_RXC */
+			AM62PX_IOPAD(0x0144, PIN_INPUT, 0) /* (A15) RGMII1_RX_CTL */
+			AM62PX_IOPAD(0x0134, PIN_INPUT, 0) /* (A18) RGMII1_TD0 */
+			AM62PX_IOPAD(0x0138, PIN_INPUT, 0) /* (C17) RGMII1_TD1 */
+			AM62PX_IOPAD(0x013c, PIN_INPUT, 0) /* (A17) RGMII1_TD2 */
+			AM62PX_IOPAD(0x0140, PIN_INPUT, 0) /* (C16) RGMII1_TD3 */
+			AM62PX_IOPAD(0x0130, PIN_INPUT, 0) /* (B17) RGMII1_TXC */
+			AM62PX_IOPAD(0x012c, PIN_INPUT, 0) /* (B18) RGMII1_TX_CTL */
+		>;
+	};
+
+	main_rgmii2_pins_default: main-rgmii2-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0184, PIN_INPUT, 0) /* (E19) RGMII2_RD0 */
+			AM62PX_IOPAD(0x0188, PIN_INPUT, 0) /* (E16) RGMII2_RD1 */
+			AM62PX_IOPAD(0x018c, PIN_INPUT, 0) /* (E17) RGMII2_RD2 */
+			AM62PX_IOPAD(0x0190, PIN_INPUT, 0) /* (C19) RGMII2_RD3 */
+			AM62PX_IOPAD(0x0180, PIN_INPUT, 0) /* (D19) RGMII2_RXC */
+			AM62PX_IOPAD(0x017c, PIN_INPUT, 0) /* (F19) RGMII2_RX_CTL */
+			AM62PX_IOPAD(0x016c, PIN_INPUT, 0) /* (B19) RGMII2_TD0 */
+			AM62PX_IOPAD(0x0170, PIN_INPUT, 0) /* (A21) RGMII2_TD1 */
+			AM62PX_IOPAD(0x0174, PIN_INPUT, 0) /* (D17) RGMII2_TD2 */
+			AM62PX_IOPAD(0x0178, PIN_INPUT, 0) /* (A19) RGMII2_TD3 */
+			AM62PX_IOPAD(0x0168, PIN_INPUT, 0) /* (D16) RGMII2_TXC */
+			AM62PX_IOPAD(0x0164, PIN_INPUT, 0) /* (A20) RGMII2_TX_CTL */
+		>;
+	};
+
 	main_uart0_pins_default: main-uart0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
 			AM62PX_IOPAD(0x1c8, PIN_INPUT, 0)	/* (A22) UART0_RXD */
 			AM62PX_IOPAD(0x1cc, PIN_OUTPUT, 0)	/* (B22) UART0_TXD */
-			AM62PX_IOPAD(0x1d0, PIN_INPUT, 0)	/* (A23) UART0_CTSn */
-			AM62PX_IOPAD(0x1d4, PIN_OUTPUT, 0)	/* (C22) UART0_RTSn */
 		>;
 	};
 
 	main_uart1_pins_default: main-uart1-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
-			AM62PX_IOPAD(0x194, PIN_INPUT, 2)	/* (D25) MCASP0_AXR3 */
-			AM62PX_IOPAD(0x198, PIN_OUTPUT, 2)	/* (E25) MCASP0_AXR2 */
-			AM62PX_IOPAD(0x1ac, PIN_INPUT, 2)	/* (G23) MCASP0_AFSR */
-			AM62PX_IOPAD(0x1b0, PIN_OUTPUT, 2)	/* (G20) MCASP0_ACLKR */
+			AM62PX_IOPAD(0x0194, PIN_INPUT, 2) /* (D25) MCASP0_AXR3.UART1_CTSn */
+			AM62PX_IOPAD(0x0198, PIN_OUTPUT, 2) /* (E25) MCASP0_AXR2.UART1_RTSn */
+			AM62PX_IOPAD(0x01ac, PIN_INPUT, 2) /* (G23) MCASP0_AFSR.UART1_RXD */
+			AM62PX_IOPAD(0x01b0, PIN_OUTPUT, 2) /* (G20) MCASP0_ACLKR.UART1_TXD */
 		>;
 	};
+
+	main_usb1_pins_default: main-usb1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0258, PIN_INPUT, 0) /* (G21) USB1_DRVVBUS */
+		>;
+	};
+
+	main_wlirq_pins_default: main-wlirq-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0128, PIN_INPUT, 7) /* (K25) MMC2_SDWP.GPIO0_72 */
+		>;
+	};
+
+	ospi0_pins_default: ospi0-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0000, PIN_OUTPUT, 0) /* (P23) OSPI0_CLK */
+			AM62PX_IOPAD(0x002c, PIN_OUTPUT, 0) /* (M25) OSPI0_CSn0 */
+			AM62PX_IOPAD(0x000c, PIN_INPUT, 0) /* (L25) OSPI0_D0 */
+			AM62PX_IOPAD(0x0010, PIN_INPUT, 0) /* (N24) OSPI0_D1 */
+			AM62PX_IOPAD(0x0014, PIN_INPUT, 0) /* (N25) OSPI0_D2 */
+			AM62PX_IOPAD(0x0018, PIN_INPUT, 0) /* (M24) OSPI0_D3 */
+			AM62PX_IOPAD(0x001c, PIN_INPUT, 0) /* (N21) OSPI0_D4 */
+			AM62PX_IOPAD(0x0020, PIN_INPUT, 0) /* (N22) OSPI0_D5 */
+			AM62PX_IOPAD(0x0024, PIN_INPUT, 0) /* (P21) OSPI0_D6 */
+			AM62PX_IOPAD(0x0028, PIN_INPUT, 0) /* (N20) OSPI0_D7 */
+			AM62PX_IOPAD(0x0008, PIN_INPUT, 0) /* (P22) OSPI0_DQS */
+		>;
+	};
+
+	usr_led_pins_default: usr-led-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0244, PIN_INPUT, 7) /* (D24) MMC1_SDWP.GPIO1_49 */
+		>;
+	};
+
+	vddshv_sdio_pins_default: vddshvr-sdio-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x007c, PIN_INPUT, 7) /* (Y25) GPMC0_CLK.GPIO0_31 */
+		>;
+	};
+
+	wlan_en_pins_default: wlan-en-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0124, PIN_INPUT, 7) /* (J25) MMC2_SDCD.GPIO0_71 */
+		>;
+	};
+};
+
+&main_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	typec_pd0: tps6598x@3f {
+		compatible = "ti,tps6598x";
+		reg = <0x3f>;
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			self-powered;
+			data-role = "dual";
+			power-role = "sink";
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@0 {
+					reg = <0>;
+					usb_con_hs: endpoint {
+						remote-endpoint = <&usb0_hs_ep>;
+					};
+				};
+			};
+		};
+	};
+};
+
+&main_i2c1 {
+	bootph-all;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c1_pins_default>;
+	clock-frequency = <100000>;
+
+	tlv320aic3106: audio-codec@1b {
+		#sound-dai-cells = <0>;
+		compatible = "ti,tlv320aic3106";
+		reg = <0x1b>;
+		ai3x-micbias-vg = <1>;  /* 2.0V */
+	};
+
+	exp1: gpio@22 {
+		bootph-all;
+		compatible = "ti,tca6424";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "OLDI_INT#", "x8_NAND_DETECT",
+				   "UART1_FET_SEL", "MMC1_SD_EN",
+				   "VPP_EN", "EXP_PS_3V3_EN",
+				   "UART1_FET_BUF_EN", "EXP_HAT_DETECT",
+				   "DSI_GPIO0", "DSI_GPIO1",
+				   "OLDI_EDID", "BT_UART_WAKE_SOC_3V3",
+				   "USB_TYPEA_OC_INDICATION", "CSI_GPIO0",
+				   "CSI_GPIO1", "WLAN_ALERTn",
+				   "HDMI_INTn", "TEST_GPIO2",
+				   "MCASP1_FET_EN", "MCASP1_BUF_BT_EN",
+				   "MCASP1_FET_SEL", "DSI_EDID",
+				   "PD_I2C_IRQ", "IO_EXP_TEST_LED";
+
+		interrupt-parent = <&main_gpio1>;
+		interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&main_gpio1_ioexp_intr_pins_default>;
+	};
+
+	exp2: gpio@23 {
+		compatible = "ti,tca6424";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "BT_EN_SOC", "EXP_PS_5V0_EN",
+				   "", "",
+				   "", "",
+				   "", "",
+				   "WL_LT_EN", "",
+				   "TP3", "TP6",
+				   "TP4", "TP7",
+				   "TP5", "TP8",
+				   "SoC_I2C2_MCAN_SEL", "GPIO_HDMI_RSTn",
+				   "GPIO_CPSW2_RST", "GPIO_CPSW1_RST",
+				   "GPIO_OLDI_RSTn", "GPIO_AUD_RSTn",
+				   "GPIO_eMMC_RSTn", "SoC_WLAN_SDIO_RST";
+	};
+};
+
+&main_i2c2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c2_pins_default>;
+	clock-frequency = <400000>;
+};
+
+&sdhci0 {
+	status = "okay";
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+};
+
+&sdhci1 {
+	/* SD/MMC */
+	bootph-all;
+	status = "okay";
+	vmmc-supply = <&vdd_mmc1>;
+	vqmmc-supply = <&vddshv_sdio>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc1_pins_default>;
+	ti,driver-strength-ohm = <50>;
+	disable-wp;
+	no-1-8-v;
+};
+
+&cpsw3g {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_rgmii1_pins_default>,
+		    <&main_rgmii2_pins_default>;
+};
+
+&cpsw_port1 {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&cpsw3g_phy0>;
+};
+
+&cpsw_port2 {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&cpsw3g_phy1>;
+};
+
+&cpsw3g_mdio {
+	cpsw3g_phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+
+	cpsw3g_phy1: ethernet-phy@1 {
+		reg = <1>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+};
+
+&usbss0 {
+	bootph-all;
+	status = "okay";
+	ti,vbus-divider;
+};
+
+&usb0 {
+	bootph-all;
+	usb-role-switch;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	port@0 {
+		reg = <0>;
+		usb0_hs_ep: endpoint {
+		    remote-endpoint = <&usb_con_hs>;
+	       };
+	};
+};
+
+&usbss1 {
+	status = "okay";
+	ti,vbus-divider;
+};
+
+&usb1 {
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_usb1_pins_default>;
+};
+
+&mcasp1 {
+	status = "okay";
+	#sound-dai-cells = <0>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcasp1_pins_default>;
+
+	op-mode = <0>;          /* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+
+	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+	       1 0 2 0
+	       0 0 0 0
+	       0 0 0 0
+	       0 0 0 0
+	>;
+	tx-num-evt = <32>;
+	rx-num-evt = <32>;
+};
+
+&fss {
+	bootph-all;
+};
+
+&ospi0 {
+	bootph-all;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&ospi0_pins_default>;
+
+	flash@0{
+		bootph-all;
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+		spi-max-frequency = <25000000>;
+		cdns,tshsl-ns = <60>;
+		cdns,tsd2d-ns = <60>;
+		cdns,tchsh-ns = <60>;
+		cdns,tslch-ns = <60>;
+		cdns,read-delay = <4>;
+
+		partitions {
+			bootph-all;
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "ospi.tiboot3";
+				reg = <0x0 0x80000>;
+			};
+
+			partition@80000 {
+				label = "ospi.tispl";
+				reg = <0x80000 0x200000>;
+			};
+
+			partition@280000 {
+				label = "ospi.u-boot";
+				reg = <0x280000 0x400000>;
+			};
+
+			partition@680000 {
+				label = "ospi.env";
+				reg = <0x680000 0x40000>;
+			};
+
+			partition@6c0000 {
+				label = "ospi.env.backup";
+				reg = <0x6c0000 0x40000>;
+			};
+
+			partition@800000 {
+				label = "ospi.rootfs";
+				reg = <0x800000 0x37c0000>;
+			};
+
+			partition@3fc0000 {
+				bootph-all;
+				label = "ospi.phypattern";
+				reg = <0x3fc0000 0x40000>;
+			};
+		};
+	};
+};
+
+&mailbox0_cluster0 {
+	mbox_r5_0: mbox-r5-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&mailbox0_cluster1 {
+	mbox_mcu_r5_0: mbox-mcu-r5-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
 };
 
 &main_uart0 {
@@ -84,16 +639,13 @@ &main_uart0 {
 };
 
 &main_uart1 {
+	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart1_pins_default>;
 	/* Main UART1 is used by TIFS firmware */
 	status = "reserved";
 };
 
-&cbass_mcu {
-	bootph-all;
-};
-
 &mcu_pmx0 {
 	bootph-all;
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
-- 
2.42.0

