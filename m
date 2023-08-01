Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833C776B2E1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbjHALPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjHALPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:15:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486B22683;
        Tue,  1 Aug 2023 04:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690888349; x=1722424349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rdf4gkBtRVvIvAZDl2Y8arb/AvZuzdFImCfmNWhKGM8=;
  b=OOksp6l96Et6YCFIP30cVxEGhF6powjJWXUqTKIJVCz9I4IA7UnXwjmz
   VTlbtdX+fa+k6EdPHN4vtKZ/LEnvs9By4UChuvZjcnFI9Q4Sw19A2MlVK
   jpVfS2iwYxS9O0fvFJ0D7dV7wkx8244hP8ake3nIBANxIvjz+JWEpZzSd
   wsvmD37LecANave7poMnRGVpEIQfIdAM2WaJ7fEZrMthPb+xGyh/GiX1n
   T2PC6FNuLeUlw6NSQaZqGfd1rvnlaZ6avcFt1cfLWMEC080/1gZA8YWgA
   or26s5rksvXB7NV41D3A0Eo3kB5o4fmucS+S59WyW/ouZ7byyMEq7u6VJ
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="223288457"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Aug 2023 04:12:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 1 Aug 2023 04:12:26 -0700
Received: from virtualbox.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 1 Aug 2023 04:12:23 -0700
From:   Mihai Sain <mihai.sain@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <andre.przywara@arm.com>, <andrei.simion@microchip.com>,
        <jerry.ray@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <cristian.birsan@microchip.com>,
        Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 2/2] ARM: dts: at91: sama5d29_curiosity: Add device tree for sama5d29_curiosity board
Date:   Tue, 1 Aug 2023 14:11:51 +0300
Message-ID: <20230801111151.6546-2-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801111151.6546-1-mihai.sain@microchip.com>
References: <20230801111151.6546-1-mihai.sain@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial device tree file for sama5d29_curiosity board.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/Makefile          |   2 +
 .../dts/microchip/at91-sama5d29_curiosity.dts | 706 ++++++++++++++++++
 2 files changed, 708 insertions(+)
 create mode 100644 arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts

diff --git a/arch/arm/boot/dts/microchip/Makefile b/arch/arm/boot/dts/microchip/Makefile
index 31e03747cdf4..efde9546c8f4 100644
--- a/arch/arm/boot/dts/microchip/Makefile
+++ b/arch/arm/boot/dts/microchip/Makefile
@@ -4,6 +4,7 @@ DTC_FLAGS_at91-sam9x60_curiosity := -@
 DTC_FLAGS_at91-sam9x60ek := -@
 DTC_FLAGS_at91-sama5d27_som1_ek := -@
 DTC_FLAGS_at91-sama5d27_wlsom1_ek := -@
+DTC_FLAGS_at91-sama5d29_curiosity := -@
 DTC_FLAGS_at91-sama5d2_icp := -@
 DTC_FLAGS_at91-sama5d2_ptc_ek := -@
 DTC_FLAGS_at91-sama5d2_xplained := -@
@@ -64,6 +65,7 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
 	at91-nattis-2-natte-2.dtb \
 	at91-sama5d27_som1_ek.dtb \
 	at91-sama5d27_wlsom1_ek.dtb \
+	at91-sama5d29_curiosity.dtb \
 	at91-sama5d2_icp.dtb \
 	at91-sama5d2_ptc_ek.dtb \
 	at91-sama5d2_xplained.dtb \
diff --git a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
new file mode 100644
index 000000000000..17af10446dac
--- /dev/null
+++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
@@ -0,0 +1,706 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * at91-sama5d29_curiosity.dts - Device Tree file for SAMA5D29 Curiosity board
+ *
+ * Copyright (C) 2023 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Mihai Sain <mihai.sain@microchip.com>
+ *
+ */
+/dts-v1/;
+#include "sama5d29.dtsi"
+#include "sama5d2-pinfunc.h"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/mfd/atmel-flexcom.h>
+
+/ {
+	model = "Microchip SAMA5D29 Curiosity";
+	compatible = "microchip,sama5d29-curiosity", "atmel,sama5d29", "atmel,sama5d2", "atmel,sama5";
+
+	aliases {
+		serial0 = &uart0;	// debug
+		serial1 = &uart1;	// RPi
+		serial2 = &uart3;	// mikro BUS 2
+		serial3 = &uart4;	// mikro BUS 1
+		serial4 = &uart6;	// flx1 Bluetooth
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootwait";
+		stdout-path = "serial0:115200n8";
+	};
+
+	clocks {
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
+			clock-frequency = <24000000>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_key_gpio_default>;
+
+		button-1 {
+			label = "USER_PB";
+			gpios = <&pioA PIN_PA17 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_PROG1>;
+			wakeup-source;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_led_gpio_default>;
+		status = "okay";
+
+		red {
+			label = "red";
+			gpios = <&pioA PIN_PA7 GPIO_ACTIVE_HIGH>;
+		};
+
+		green {
+			label = "green";
+			gpios = <&pioA PIN_PA8 GPIO_ACTIVE_HIGH>;
+		};
+
+		blue {
+			label = "blue";
+			gpios = <&pioA PIN_PA9 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	memory@20000000 {
+		device_type = "memory";
+		reg = <0x20000000 0x20000000>;
+	};
+
+	vdd_1v8: regulator-vqmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		status = "okay";
+	};
+};
+
+&adc {
+	vddana-supply = <&vdd_3v3>;
+	vref-supply = <&vdd_3v3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc_default &pinctrl_adtrg_default>;
+	status = "okay";
+};
+
+&can0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can0_default>;
+	status = "okay";
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1_default>;
+	status = "okay";
+};
+
+&flx1 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
+	status = "okay";
+
+	uart6: serial@200 {
+		pinctrl-0 = <&pinctrl_flx1_default>;
+		pinctrl-names = "default";
+		atmel,use-dma-rx;
+		atmel,use-dma-tx;
+		status = "okay";
+	};
+};
+
+&flx4 { /* RPi spi */
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_SPI>;
+	status = "okay";
+
+	spi6: spi@400 {
+		dmas = <0>, <0>;
+		cs-gpios = <&pioA PIN_PD15 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_rpi_spi &pinctrl_rpi_spi_cs0>;
+		status = "okay";
+	};
+
+	spi7: spi@400 {
+		dmas = <0>, <0>;
+		cs-gpios = <&pioA PIN_PD16 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_rpi_spi &pinctrl_rpi_spi_cs1>;
+		status = "okay";
+	};
+};
+
+&i2c0 {
+	dmas = <0>, <0>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c0_default>;
+	pinctrl-1 = <&pinctrl_i2c0_gpio>;
+	sda-gpios = <&pioA PIN_PB31 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&pioA PIN_PC0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	i2c-sda-hold-time-ns = <350>;
+	status = "okay";
+
+	mcp16502@5b {
+		compatible = "microchip,mcp16502";
+		reg = <0x5b>;
+		status = "okay";
+		lpm-gpios = <&pioBU 0 GPIO_ACTIVE_LOW>;
+
+		regulators {
+			vdd_3v3: VDD_IO {
+				regulator-name = "VDD_IO";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-initial-mode = <2>;
+				regulator-allowed-modes = <2>, <4>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+					regulator-mode = <4>;
+				};
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-mode = <4>;
+				};
+			};
+
+			vddio_ddr: VDD_DDR {
+				regulator-name = "VDD_DDR";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-initial-mode = <2>;
+				regulator-allowed-modes = <2>, <4>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1200000>;
+					regulator-changeable-in-suspend;
+					regulator-mode = <4>;
+				};
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1200000>;
+					regulator-changeable-in-suspend;
+					regulator-mode = <4>;
+				};
+			};
+
+			vdd_core: VDD_CORE {
+				regulator-name = "VDD_CORE";
+				regulator-min-microvolt = <1250000>;
+				regulator-max-microvolt = <1250000>;
+				regulator-initial-mode = <2>;
+				regulator-allowed-modes = <2>, <4>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+					regulator-mode = <4>;
+				};
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-mode = <4>;
+				};
+			};
+
+			vdd_ddr: VDD_OTHER {
+				regulator-name = "VDD_OTHER";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-initial-mode = <2>;
+				regulator-allowed-modes = <2>, <4>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+					regulator-changeable-in-suspend;
+					regulator-mode = <4>;
+				};
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+					regulator-changeable-in-suspend;
+					regulator-mode = <4>;
+				};
+			};
+
+			LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+				};
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			LDO2 {
+				regulator-name = "LDO2";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+				};
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&i2c1 {
+	dmas = <0>, <0>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1_default>;
+	i2c-analog-filter;
+	i2c-digital-filter;
+	i2c-digital-filter-width-ns = <35>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	sda-gpios = <&pioA PIN_PD4 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&pioA PIN_PD5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+&macb0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_macb0_default &pinctrl_macb0_phy_irq>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	phy-mode = "rmii";
+	status = "disabled";
+};
+
+&pioA {
+	pinctrl_adc_default: adc_default {
+		pinmux = <PIN_PD25__GPIO>,
+			 <PIN_PD26__GPIO>;
+		bias-disable;
+	};
+
+	pinctrl_adtrg_default: adtrg_default {
+		pinmux = <PIN_PD31__ADTRG>;
+		bias-pull-up;
+	};
+
+	pinctrl_rpi_spi: rpi_spi {
+		pinmux = <PIN_PD12__FLEXCOM4_IO0>,
+			 <PIN_PD13__FLEXCOM4_IO1>,
+			 <PIN_PD14__FLEXCOM4_IO2>;
+		bias-disable;
+	};
+
+	pinctrl_rpi_spi_cs0: rpi_spi_cs0 {
+		pinmux = <PIN_PD15__FLEXCOM4_IO3>;
+		bias-disable;
+	};
+
+	pinctrl_rpi_spi_cs1: rpi_spi_cs1 {
+		pinmux = <PIN_PD16__FLEXCOM4_IO4>;
+		bias-disable;
+	};
+
+	pinctrl_spi1_default: spi1_default {
+		pinmux = <PIN_PC1__SPI1_SPCK>,
+			 <PIN_PC2__SPI1_MOSI>,
+			 <PIN_PC3__SPI1_MISO>;
+		bias-disable;
+	};
+
+	pinctrl_spi1_cs: spi1_cs {
+		pinmux = <PIN_PC4__SPI1_NPCS0>,
+			 <PIN_PC5__SPI1_NPCS1>,
+			 <PIN_PC6__SPI1_NPCS2>,
+			 <PIN_PC7__SPI1_NPCS3>;
+		bias-disable;
+	};
+
+	pinctrl_rpi_uart: rpi_uart {
+		pinmux = <PIN_PD2__URXD1>,
+			 <PIN_PD3__UTXD1>;
+		bias-disable;
+	};
+
+	pinctrl_debug_uart: debug_uart {
+		pinmux = <PIN_PB26__URXD0>,
+			 <PIN_PB27__UTXD0>;
+		bias-disable;
+	};
+
+	pinctrl_can0_default: can0_default {
+		pinmux = <PIN_PC10__CANTX0>,
+			 <PIN_PC11__CANRX0>;
+		bias-disable;
+	};
+
+	pinctrl_can1_default: can1_default {
+		pinmux = <PIN_PC26__CANTX1>,
+			 <PIN_PC27__CANRX1>;
+		bias-disable;
+	};
+
+	pinctrl_i2c0_default: i2c0_default {
+		pinmux = <PIN_PB31__TWD0>,
+			 <PIN_PC0__TWCK0>;
+		bias-disable;
+	};
+
+	pinctrl_i2c0_gpio: i2c0_gpio {
+		pinmux = <PIN_PB31__GPIO>,
+			 <PIN_PC0__GPIO>;
+		bias-disable;
+	};
+
+	pinctrl_i2c1_default: i2c1_default {
+		pinmux = <PIN_PD4__TWD1>,
+			 <PIN_PD5__TWCK1>;
+		bias-disable;
+	};
+
+	pinctrl_i2c1_gpio: i2c1_gpio {
+		pinmux = <PIN_PD4__GPIO>,
+			 <PIN_PD5__GPIO>;
+		bias-disable;
+	};
+
+	pinctrl_key_gpio_default: key_gpio_default {
+		pinmux = <PIN_PA17__GPIO>;
+		bias-pull-up;
+	};
+
+	pinctrl_led_gpio_default: led_gpio_default {
+		pinmux = <PIN_PA7__GPIO>,
+			 <PIN_PA8__GPIO>,
+			 <PIN_PA9__GPIO>;
+		bias-pull-up;
+	};
+
+	pinctrl_qspi1_default: qspi1_default {
+		pinmux = <PIN_PB5__QSPI1_SCK>,
+			 <PIN_PB6__QSPI1_CS>,
+			 <PIN_PB7__QSPI1_IO0>,
+			 <PIN_PB8__QSPI1_IO1>,
+			 <PIN_PB9__QSPI1_IO2>,
+			 <PIN_PB10__QSPI1_IO3>;
+		bias-disable;
+	};
+
+	pinctrl_sdmmc0_default: sdmmc0_default {
+		pinmux = <PIN_PA0__SDMMC0_CK>,
+			 <PIN_PA1__SDMMC0_CMD>,
+			 <PIN_PA2__SDMMC0_DAT0>,
+			 <PIN_PA3__SDMMC0_DAT1>,
+			 <PIN_PA4__SDMMC0_DAT2>,
+			 <PIN_PA5__SDMMC0_DAT3>,
+			 <PIN_PA11__SDMMC0_VDDSEL>,
+			 <PIN_PA13__SDMMC0_CD>;
+		bias-disable;
+	};
+
+	pinctrl_sdmmc1_default: sdmmc1_default {
+		pinmux = <PIN_PA18__SDMMC1_DAT0>,
+			 <PIN_PA19__SDMMC1_DAT1>,
+			 <PIN_PA20__SDMMC1_DAT2>,
+			 <PIN_PA21__SDMMC1_DAT3>,
+			 <PIN_PA22__SDMMC1_CK>,
+			 <PIN_PA28__SDMMC1_CMD>,
+			 <PIN_PA30__SDMMC1_CD>;
+		bias-disable;
+	};
+
+	pinctrl_mikrobus1_an: mikrobus1_an {
+		pinmux = <PIN_PD25__GPIO>;
+		bias-disable;
+	};
+
+	pinctrl_mikrobus1_rst: mikrobus1_rst {
+		pinmux = <PIN_PA16__GPIO>;
+		bias-disable;
+	};
+
+	pinctrl_mikrobus1_spi_cs: mikrobus1_spi_cs {
+		pinmux = <PIN_PC4__SPI1_NPCS0>;
+		bias-disable;
+	};
+
+	pinctrl_mikrobus1_spi: mikrobus1_spi {
+		pinmux = <PIN_PC1__SPI1_SPCK>,
+			 <PIN_PC2__SPI1_MOSI>,
+			 <PIN_PC3__SPI1_MISO>;
+		bias-disable;
+	};
+
+	pinctrl_mikrobus1_pwm: mikrobus1_pwm {
+		pinmux = <PIN_PA31__PWML0>;
+		bias-disable;
+	};
+
+	pinctrl_mikrobus1_int: mikrobus1_int {
+		pinmux = <PIN_PB2__GPIO>;
+		bias-disable;
+	};
+
+	pinctrl_mikrobus1_uart: mikrobus1_uart {
+		pinmux = <PIN_PB3__URXD4>,
+			 <PIN_PB4__UTXD4>;
+		bias-disable;
+	};
+
+	pinctrl_mikrobus2_an: mikrobus2_an {
+		pinmux = <PIN_PD26__GPIO>;
+		bias-disable;
+	};
+
+	pinctrl_mikrobus2_rst: mikrobus2_rst {
+		pinmux = <PIN_PA16__GPIO>;
+		bias-disable;
+	};
+
+	pinctrl_mikrobus2_spi_cs: mikrobus2_spi_cs {
+		pinmux = <PIN_PC5__SPI1_NPCS1>;
+		bias-disable;
+	};
+
+	pinctrl_mikrobus2_spi: mikrobus2_spi {
+		pinmux = <PIN_PC1__SPI1_SPCK>,
+			 <PIN_PC2__SPI1_MOSI>,
+			 <PIN_PC3__SPI1_MISO>;
+		bias-disable;
+	};
+
+	pinctrl_mikrobus2_pwm: mikrobus2_pwm {
+		pinmux = <PIN_PB0__PWMH1>;
+		bias-disable;
+	};
+
+	pinctrl_mikrobus2_int: mikrobus2_int {
+		pinmux = <PIN_PB1__GPIO>;
+		bias-disable;
+	};
+
+	pinctrl_mikrobus2_uart: mikrobus2_uart {
+		pinmux = <PIN_PB11__URXD3>,
+			 <PIN_PB12__UTXD3>;
+		bias-disable;
+	};
+
+	pinctrl_usb_default: usb_default {
+		pinmux = <PIN_PA6__GPIO>;
+		bias-disable;
+	};
+
+	pinctrl_usba_vbus: usba_vbus {
+		pinmux = <PIN_PB13__GPIO>;
+		bias-disable;
+	};
+
+	pinctrl_macb0_default: macb0_default {
+		pinmux = <PIN_PB14__GTXCK>,
+			 <PIN_PB15__GTXEN>,
+			 <PIN_PB16__GRXDV>,
+			 <PIN_PB17__GRXER>,
+			 <PIN_PB18__GRX0>,
+			 <PIN_PB19__GRX1>,
+			 <PIN_PB20__GTX0>,
+			 <PIN_PB21__GTX1>,
+			 <PIN_PB22__GMDC>,
+			 <PIN_PB23__GMDIO>;
+		bias-disable;
+	};
+
+	pinctrl_macb0_phy_irq: macb0_phy_irq {
+		pinmux = <PIN_PB24__GPIO>;
+		bias-disable;
+	};
+
+	pinctrl_flx1_default: flx1_default {
+		pinmux = <PIN_PA24__FLEXCOM1_IO0>,
+			 <PIN_PA23__FLEXCOM1_IO1>,
+			 <PIN_PA25__FLEXCOM1_IO3>,
+			 <PIN_PA26__FLEXCOM1_IO4>;
+		bias-disable;
+	};
+};
+
+&pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mikrobus1_pwm &pinctrl_mikrobus2_pwm>;
+	status = "okay";
+};
+
+&qspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi1_default>;
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <80000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		m25p,fast-read;
+		label = "atmel_qspi1";
+		status = "okay";
+
+		at91bootstrap@0 {
+			label = "at91bootstrap";
+			reg = <0x0 0x40000>;
+		};
+
+		bootloader@40000 {
+			label = "bootloader";
+			reg = <0x40000 0xc0000>;
+		};
+
+		bootloaderenvred@100000 {
+			label = "bootloader env redundant";
+			reg = <0x100000 0x40000>;
+		};
+
+		bootloaderenv@140000 {
+			label = "bootloader env";
+			reg = <0x140000 0x40000>;
+		};
+
+		dtb@180000 {
+			label = "device tree";
+			reg = <0x180000 0x80000>;
+		};
+
+		kernel@200000 {
+			label = "kernel";
+			reg = <0x200000 0x600000>;
+		};
+	};
+};
+
+&sdmmc0 {
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdmmc0_default>;
+	vmmc-supply = <&vdd_3v3>;
+	vqmmc-supply = <&vdd_1v8>;
+	status = "okay";
+};
+
+&sdmmc1 {
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdmmc1_default>;
+	vqmmc-supply = <&vdd_3v3>;
+	vmmc-supply = <&vdd_3v3>;
+	status = "okay";
+};
+
+&shutdown_controller {
+	debounce-delay-us = <976>;
+	atmel,wakeup-rtc-timer;
+
+	input@0 {
+		reg = <0>;
+	};
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default &pinctrl_spi1_cs>;
+	status = "okay";
+};
+
+&tcb0 {
+	timer0: timer@0 {
+		compatible = "atmel,tcb-timer";
+		reg = <0>;
+	};
+
+	timer1: timer@1 {
+		compatible = "atmel,tcb-timer";
+		reg = <1>;
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_debug_uart>;
+	atmel,use-dma-rx;
+	atmel,use-dma-tx;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rpi_uart>;
+	atmel,use-dma-rx;
+	atmel,use-dma-tx;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mikrobus2_uart>;
+	atmel,use-dma-rx;
+	atmel,use-dma-tx;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mikrobus1_uart>;
+	atmel,use-dma-rx;
+	atmel,use-dma-tx;
+	status = "okay";
+};
+
+&usb0 {
+	atmel,vbus-gpio = <&pioA PIN_PB13 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usba_vbus>;
+	status = "okay";
+};
+
+&usb1 {
+	num-ports = <3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_default>;
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
+};
-- 
2.41.0

