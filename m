Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5C6766ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbjG1KfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbjG1Kef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:34:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B696468B;
        Fri, 28 Jul 2023 03:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540337; x=1722076337;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EBzGP6WnxviijVISZi6yqDkJC+1RwHcRaalxK6q0ZDA=;
  b=c3xyDGq/ezcvZupbaqD08m2B9I7hEUw/XXr87pqh7+qTXqPuiMzg2jH2
   Oa9B6Zukhf/KWVGP0BtgXeCi7y7rnCHZPXIYo3BIvEk2EeT8441Abc0pG
   lGQiZ+cDcKGnXWKtxXehL8oScELST+rQuH/V74OE0hq5S4kyOExeLUOkH
   pIGxlrDOKm10HZ/6hm7spoNNEFTCmi9dfsvYpYfJnICyt4dfqx0OLUlv7
   ouxk/i4wEYjGXv7u84wPnKmednIHskOQa0CNQRqgjm5PPa55z87BjKND9
   gpu6Q6E5E6k5eux0Pf+FKVQ8JLKqN2v+f7RG1btTNzSGq9lpMcRi+FWHp
   w==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="238401992"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:31:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:31:21 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:31:17 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <andre.przywara@arm.com>, <f.fainelli@gmail.com>,
        <romain.perier@gmail.com>, <varshini.rajendran@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 50/50] ARM: dts: at91: sam9x75_curiosity: add sam9x75 curiosity board
Date:   Fri, 28 Jul 2023 16:01:14 +0530
Message-ID: <20230728103114.267845-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree file for sam9x75 curiosity board.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 arch/arm/boot/dts/microchip/Makefile          |   5 +
 .../dts/microchip/at91-sam9x75_curiosity.dts  | 311 ++++++++++++++++++
 2 files changed, 316 insertions(+)
 create mode 100644 arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts

diff --git a/arch/arm/boot/dts/microchip/Makefile b/arch/arm/boot/dts/microchip/Makefile
index 0f5193d05a31..f3d604c30325 100644
--- a/arch/arm/boot/dts/microchip/Makefile
+++ b/arch/arm/boot/dts/microchip/Makefile
@@ -10,6 +10,7 @@ DTC_FLAGS_at91-sama5d3_eds := -@
 DTC_FLAGS_at91-sama5d3_xplained := -@
 DTC_FLAGS_at91-sama5d4_xplained := -@
 DTC_FLAGS_at91-sama7g5ek := -@
+DTC_FLAGS_at91-sam9x75_curiosity := -@
 dtb-$(CONFIG_SOC_AT91RM9200) += \
 	at91rm9200ek.dtb \
 	mpa1600.dtb
@@ -61,6 +62,10 @@ dtb-$(CONFIG_SOC_SAM9X60) += \
 	at91-sam9x60_curiosity.dtb \
 	at91-sam9x60ek.dtb
 # Enables support for device-tree overlays
+DTC_FLAGS_at91-sam9x75_curiosity := -@
+dtb-$(CONFIG_SOC_SAM9X7) += \
+	at91-sam9x75_curiosity.dtb
+# Enables support for device-tree overlays
 DTC_FLAGS_at91-sama5d27_som1_ek := -@
 DTC_FLAGS_at91-sama5d27_wlsom1_ek := -@
 DTC_FLAGS_at91-sama5d2_icp := -@
diff --git a/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
new file mode 100644
index 000000000000..a9ecb02a9f3c
--- /dev/null
+++ b/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * at91-sam9x75_curiosity.dts - Device Tree file for Microchip SAM9X75 Curiosity board
+ *
+ * Copyright (C) 2023 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Varshini Rajendran <varshini.rajendran@microchip.com>
+ */
+/dts-v1/;
+#include "sam9x7.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Microchip SAM9X75 Curiosity";
+	compatible = "microchip,sam9x75-curiosity", "microchip,sam9x7", "atmel,at91sam9";
+
+	aliases {
+		i2c0 = &i2c6;
+		i2c1 = &i2c7;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	clocks {
+		clock-slowxtal {
+			clock-frequency = <32768>;
+		};
+
+		clock-mainxtal {
+			clock-frequency = <24000000>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_key_gpio_default>;
+
+		button-user {
+			label = "USER";
+			gpios = <&pioC 9 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_PROG1>;
+			wakeup-source;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_led_gpio_default>;
+
+		led-0 {
+			label = "red";
+			gpios = <&pioC 19 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-1 {
+			label = "green";
+			gpios = <&pioC 21 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-2 {
+			label = "blue";
+			gpios = <&pioC 20 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	memory@20000000 {
+		device_type = "memory";
+		reg = <0x20000000 0x10000000>;
+	};
+};
+
+&dbgu {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_dbgu>;
+	status = "okay";
+};
+
+&dma0 {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&flx6 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
+	status = "okay";
+
+	i2c6 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flx6_default>;
+		i2c-analog-filter;
+		i2c-digital-filter;
+		i2c-digital-filter-width-ns = <35>;
+		status = "okay";
+
+		pmic@5b {
+			compatible = "microchip,mcp16502";
+			reg = <0x5b>;
+
+			regulators {
+				vdd_3v3: VDD-IO {
+					regulator-name = "VDD_IO";
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3600000>;
+					regulator-initial-mode = <2>;
+					regulator-allowed-modes = <2>, <4>;
+					regulator-always-on;
+
+					regulator-state-standby {
+						regulator-on-in-suspend;
+						regulator-mode = <4>;
+					};
+
+					regulator-state-mem {
+						regulator-mode = <4>;
+					};
+				};
+
+				vddioddr: VDD-DDR {
+					regulator-name = "VDD_DDR";
+					regulator-min-microvolt = <1283000>;
+					regulator-max-microvolt = <1450000>;
+					regulator-initial-mode = <2>;
+					regulator-allowed-modes = <2>, <4>;
+					regulator-always-on;
+
+					regulator-state-standby {
+						regulator-on-in-suspend;
+						regulator-mode = <4>;
+					};
+
+					regulator-state-mem {
+						regulator-on-in-suspend;
+						regulator-mode = <4>;
+					};
+				};
+
+				vddcore: VDD-CORE {
+					regulator-name = "VDD_CORE";
+					regulator-min-microvolt = <500000>;
+					regulator-max-microvolt = <1210000>;
+					regulator-initial-mode = <2>;
+					regulator-allowed-modes = <2>, <4>;
+					regulator-always-on;
+
+					regulator-state-standby {
+						regulator-on-in-suspend;
+						regulator-mode = <4>;
+					};
+
+					regulator-state-mem {
+						regulator-mode = <4>;
+					};
+				};
+
+				vddcpu: VDD-OTHER {
+					regulator-name = "VDD_OTHER";
+					regulator-min-microvolt = <1700000>;
+					regulator-max-microvolt = <3600000>;
+					regulator-initial-mode = <2>;
+					regulator-allowed-modes = <2>, <4>;
+					regulator-ramp-delay = <3125>;
+					regulator-always-on;
+
+					regulator-state-standby {
+						regulator-on-in-suspend;
+						regulator-mode = <4>;
+					};
+
+					regulator-state-mem {
+						regulator-mode = <4>;
+					};
+				};
+
+				vldo1: LDO1 {
+					regulator-name = "LDO1";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <3700000>;
+					regulator-always-on;
+
+					regulator-state-standby {
+						regulator-on-in-suspend;
+					};
+				};
+
+				vldo2: LDO2 {
+					regulator-name = "LDO2";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <3700000>;
+
+					regulator-state-standby {
+						regulator-on-in-suspend;
+					};
+				};
+			};
+		};
+	};
+};
+
+&ohci0 {
+	num-ports = <3>;
+	atmel,vbus-gpio = <0
+			   &pioC 27 GPIO_ACTIVE_HIGH
+			   &pioB 18 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_default>;
+	status = "okay";
+};
+
+&pinctrl {
+
+	dbgu {
+		pinctrl_dbgu: dbgu-0 {
+			atmel,pins = <AT91_PIOA 26 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+				      AT91_PIOA 27 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+		};
+	};
+
+	flexcom {
+		pinctrl_flx6_default: flx6-twi {
+			atmel,pins =
+				<AT91_PIOA 24 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+				 AT91_PIOA 25 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
+		};
+	};
+
+	gpio-keys {
+		pinctrl_key_gpio_default: key-gpio-default {
+			atmel,pins = <AT91_PIOC 9 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+
+	leds {
+		pinctrl_led_gpio_default: led-gpio-default {
+			atmel,pins = <AT91_PIOC 19 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				      AT91_PIOC 21 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				      AT91_PIOC 20 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+
+	ohci0 {
+		pinctrl_usb_default: usb-default {
+			atmel,pins = <AT91_PIOC 27 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				      AT91_PIOB 18 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+
+	sdmmc0 {
+		pinctrl_sdmmc0_default: sdmmc0 {
+			atmel,pins =
+				<AT91_PIOA 2 AT91_PERIPH_A (AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_DIS)					/* PA2 CK  periph A with pullup */
+				 AT91_PIOA 1 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_DIS)		/* PA1 CMD periph A with pullup */
+				 AT91_PIOA 0 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_DIS)		/* PA0 DAT0 periph A */
+				 AT91_PIOA 3 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_DIS)		/* PA3 DAT1 periph A with pullup */
+				 AT91_PIOA 4 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_DIS)		/* PA4 DAT2 periph A with pullup */
+				 AT91_PIOA 5 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_DIS)>;	/* PA5 DAT3 periph A with pullup */
+		};
+	};
+
+	usb0 {
+		pinctrl_usba_vbus: usba-vbus {
+			atmel,pins = <AT91_PIOC 8 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+}; /* pinctrl */
+
+&rtt {
+	atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
+};
+
+&sdmmc0 {
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdmmc0_default>;
+	cd-gpios = <&pioA 23 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	status = "okay";
+};
+
+&power_management {
+	debounce-delay-us = <976>;
+	status = "okay";
+
+	input@0 {
+		reg = <0>;
+	};
+};
+
+&trng {
+	status = "okay";
+};
+
+&usb0 {
+	atmel,vbus-gpio = <&pioC 8 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usba_vbus>;
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
+};
-- 
2.25.1

