Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9670E77F77B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351353AbjHQNPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351478AbjHQNOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:14:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BF38E;
        Thu, 17 Aug 2023 06:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692278058; x=1723814058;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=30q+Q4Um9L5LYtARJVGVzaivXlgJ0vn19HCGKwIG6GM=;
  b=TfzipzhIgGkyfQNbmM61z2HNqjHVgu2eFExC4vICxM2RqVDpJRx9PNH4
   vKJIxKwgFg3JunsG+kzy6BElTru+6Yu2EX56ZXaWsltwRkXEgr9Eaw1Qx
   75UagZrG6GjWerxlccLnFDCS7pwV+e1W+i7dKs8hqfT3Q5yJM9+2PbouC
   sL1OI6XsBuvD/TcRDuKloYsUqdMsJkoeLcokQUzoSXX7fvtcwitDgyz8L
   M+D8cdTp/uxziAidY3KF/B0lnCXr5Ml03iedCOp8psvFkMo7OKHaoBup9
   JJ26v/fpOA9OqMc/VlmSNob3tjlpLSebey0i6aZ+lNj2DmNMUxua1iS0b
   w==;
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="229444005"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Aug 2023 06:14:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 17 Aug 2023 06:14:18 -0700
Received: from virtualbox.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 17 Aug 2023 06:14:14 -0700
From:   Mihai Sain <mihai.sain@microchip.com>
To:     <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <cristian.birsan@microchip.com>,
        <alexandre.belloni@bootlin.com>, <andre.przywara@arm.com>,
        <jerry.ray@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <andrei.simion@microchip.com>,
        Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v3] ARM: dts: at91: sama5d29_curiosity: Add device tree for sama5d29_curiosity board
Date:   Thu, 17 Aug 2023 16:13:51 +0300
Message-ID: <20230817131352.17631-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial device tree file for sama5d29_curiosity board.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
Changes in v3:
* remove i2s0 node and its pinctrl

Changes in v2:
* drop dt-bindings patch
* remove vdd_1v8 regulator
* fix flx4 node to use 1 spi node and pinctrl
* add i2s0 node and pinctrl
* remove macb0 node and pinctrl
* remove unused pinctrl
* sort in alphabetical order all nodes and pinctrl
* replace "_" with "-" in node names
---
 arch/arm/boot/dts/microchip/Makefile          |   2 +
 .../dts/microchip/at91-sama5d29_curiosity.dts | 600 ++++++++++++++++++
 2 files changed, 602 insertions(+)
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
index 000000000000..267e1dbb417d
--- /dev/null
+++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
@@ -0,0 +1,600 @@
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
+			label = "USER BUTTON";
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
+&flx4 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_SPI>;
+	status = "okay";
+
+	spi6: spi@400 {
+		dmas = <0>, <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_rpi_spi>;
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
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	i2c-analog-filter;
+	i2c-digital-filter;
+	i2c-digital-filter-width-ns = <35>;
+	sda-gpios = <&pioA PIN_PD4 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&pioA PIN_PD5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+&pioA {
+	pinctrl_adc_default: adc-default {
+		pinmux = <PIN_PD25__GPIO>,
+			 <PIN_PD26__GPIO>;
+		bias-disable;
+	};
+
+	pinctrl_adtrg_default: adtrg-default {
+		pinmux = <PIN_PD31__ADTRG>;
+		bias-pull-up;
+	};
+
+	pinctrl_can0_default: can0-default {
+		pinmux = <PIN_PC10__CANTX0>,
+			 <PIN_PC11__CANRX0>;
+		bias-disable;
+	};
+
+	pinctrl_can1_default: can1-default {
+		pinmux = <PIN_PC26__CANTX1>,
+			 <PIN_PC27__CANRX1>;
+		bias-disable;
+	};
+
+	pinctrl_debug_uart: debug-uart {
+		pinmux = <PIN_PB26__URXD0>,
+			 <PIN_PB27__UTXD0>;
+		bias-disable;
+	};
+
+	pinctrl_flx1_default: flx1-default {
+		pinmux = <PIN_PA24__FLEXCOM1_IO0>,
+			 <PIN_PA23__FLEXCOM1_IO1>,
+			 <PIN_PA25__FLEXCOM1_IO3>,
+			 <PIN_PA26__FLEXCOM1_IO4>;
+		bias-disable;
+	};
+
+	pinctrl_i2c0_default: i2c0-default {
+		pinmux = <PIN_PB31__TWD0>,
+			 <PIN_PC0__TWCK0>;
+		bias-disable;
+	};
+
+	pinctrl_i2c0_gpio: i2c0-gpio {
+		pinmux = <PIN_PB31__GPIO>,
+			 <PIN_PC0__GPIO>;
+		bias-disable;
+	};
+
+	pinctrl_i2c1_default: i2c1-default {
+		pinmux = <PIN_PD4__TWD1>,
+			 <PIN_PD5__TWCK1>;
+		bias-disable;
+	};
+
+	pinctrl_i2c1_gpio: i2c1-gpio {
+		pinmux = <PIN_PD4__GPIO>,
+			 <PIN_PD5__GPIO>;
+		bias-disable;
+	};
+
+	pinctrl_key_gpio_default: key-gpio-default {
+		pinmux = <PIN_PA17__GPIO>;
+		bias-pull-up;
+	};
+
+	pinctrl_led_gpio_default: led-gpio-default {
+		pinmux = <PIN_PA7__GPIO>,
+			 <PIN_PA8__GPIO>,
+			 <PIN_PA9__GPIO>;
+		bias-pull-up;
+	};
+
+	pinctrl_mikrobus1_pwm: mikrobus1-pwm {
+		pinmux = <PIN_PA31__PWML0>;
+		bias-disable;
+	};
+
+	pinctrl_mikrobus2_pwm: mikrobus2-pwm {
+		pinmux = <PIN_PB0__PWMH1>;
+		bias-disable;
+	};
+
+	pinctrl_mikrobus1_uart: mikrobus1-uart {
+		pinmux = <PIN_PB3__URXD4>,
+			 <PIN_PB4__UTXD4>;
+		bias-disable;
+	};
+
+	pinctrl_mikrobus2_uart: mikrobus2-uart {
+		pinmux = <PIN_PB11__URXD3>,
+			 <PIN_PB12__UTXD3>;
+		bias-disable;
+	};
+
+	pinctrl_qspi1_default: qspi1-default {
+		pinmux = <PIN_PB5__QSPI1_SCK>,
+			 <PIN_PB6__QSPI1_CS>,
+			 <PIN_PB7__QSPI1_IO0>,
+			 <PIN_PB8__QSPI1_IO1>,
+			 <PIN_PB9__QSPI1_IO2>,
+			 <PIN_PB10__QSPI1_IO3>;
+		bias-disable;
+	};
+
+	pinctrl_rpi_spi: rpi-spi {
+		pinmux = <PIN_PD12__FLEXCOM4_IO0>,
+			 <PIN_PD13__FLEXCOM4_IO1>,
+			 <PIN_PD14__FLEXCOM4_IO2>,
+			 <PIN_PD15__FLEXCOM4_IO3>,
+			 <PIN_PD16__FLEXCOM4_IO4>;
+		bias-disable;
+	};
+
+	pinctrl_rpi_uart: rpi-uart {
+		pinmux = <PIN_PD2__URXD1>,
+			 <PIN_PD3__UTXD1>;
+		bias-disable;
+	};
+
+	pinctrl_sdmmc0_default: sdmmc0-default {
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
+	pinctrl_sdmmc1_default: sdmmc1-default {
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
+	pinctrl_spi1_default: spi1-default {
+		pinmux = <PIN_PC1__SPI1_SPCK>,
+			 <PIN_PC2__SPI1_MOSI>,
+			 <PIN_PC3__SPI1_MISO>,
+			 <PIN_PC4__SPI1_NPCS0>,
+			 <PIN_PC5__SPI1_NPCS1>,
+			 <PIN_PC6__SPI1_NPCS2>,
+			 <PIN_PC7__SPI1_NPCS3>;
+		bias-disable;
+	};
+
+	pinctrl_usb_default: usb-default {
+		pinmux = <PIN_PA6__GPIO>;
+		bias-disable;
+	};
+
+	pinctrl_usba_vbus: usba-vbus {
+		pinmux = <PIN_PB13__GPIO>;
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
+	disable-wp;
+	status = "okay";
+};
+
+&sdmmc1 {
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdmmc1_default>;
+	disable-wp;
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
+	pinctrl-0 = <&pinctrl_spi1_default>;
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
+	atmel,vbus-gpio = <0
+			   &pioA PIN_PA6 GPIO_ACTIVE_HIGH
+			   0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_default>;
+	status = "okay";
+};
+
+&usb2 {
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
+};
-- 
2.41.0

