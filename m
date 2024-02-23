Return-Path: <linux-kernel+bounces-78873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1028F8619F6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338841C24758
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3D51468F0;
	Fri, 23 Feb 2024 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Yyz/3AH9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8EB12D763;
	Fri, 23 Feb 2024 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709491; cv=none; b=PlNLKs/2TKoHbTGjPtpUMvG9fMMn0bvBoqGwpTWsOrdLx3Tl/yXTVdm8xm7MP4E5TdQG/w35BHBrUFM/V7JX+psa6LOf6ckMe8VWMDjvCIaaJ99RNhl8uyckM6EaGlC4R7M0XgdHCQORyi6ni7EpFbWfS51gE0INKxDklGXZwuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709491; c=relaxed/simple;
	bh=Z1LIIhp3DdCr6uVt0lYpOJ62r9L9VOMxLwm9s8WfSCM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAA2RT4GXIFoKykmtYb0iFHaSvEbMntbrp5g78ZpjgB71AnpdtiG0l8s/98ozN5TjfBdAKBroSrOtE7kA/2FQ6M0PbK62mw8Jv9pHfJ2s8y8I+szcO3SJp+CUyRVdme5zsBB0XVbbV/i2VhP1Zmhs/DZV20pkq6eu5cXwZ6kWNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Yyz/3AH9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709490; x=1740245490;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Z1LIIhp3DdCr6uVt0lYpOJ62r9L9VOMxLwm9s8WfSCM=;
  b=Yyz/3AH9DtaABAob1NiEBG8fx8mtzftTFaXd2QAlM5PT45xmRSsG+m1H
   bvwmKKRojyFqZZoff/AH1OkuMGUEjmiPsK4bknKzQOXqh5X/cigiWxJKo
   i95M9QeAsXlPOLx2V9VwiQgy+C0LxfJrEnGPCmCUda6frMPVDs7RuDnSF
   Yk107QcKWyijer3hUBJIWUfOo/IHMhTaJBHk8XO2pHNONC5oQpzc5sbZC
   vRUMKSY5l8FyNQfBthSnU6K6Y8eVg3df60NTLuzTk7k9EBNPUw/6E+jqY
   e0BQAm+gMarwHEVbg4uaoEtWSm1KfDNv1BiD0K9MgUPQSIzA/lNc1uHej
   w==;
X-CSE-ConnectionGUID: PANU8h+pSKGuucnF8SuIjA==
X-CSE-MsgGUID: mMuWETYZTSazwK3yGcOyIw==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="184009809"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:31:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:31:21 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:31:16 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<andre.przywara@arm.com>, <gregory.clement@bootlin.com>,
	<linus.walleij@linaro.org>, <baruch@tkos.co.il>,
	<varshini.rajendran@microchip.com>, <mihai.sain@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 39/39] ARM: dts: at91: sam9x75_curiosity: add sam9x75 curiosity board
Date: Fri, 23 Feb 2024 23:01:13 +0530
Message-ID: <20240223173113.673595-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240223171342.669133-1-varshini.rajendran@microchip.com>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add device tree file for sam9x75 curiosity board.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v4:
- Removed full node paths
- Renamed Leds with color names
- Corrected regulator node names
- Added support for classd and i2s nodes and their corresponding
  pinctrl nodes
- Dropped USB nodes owing to the discussion here
https://lore.kernel.org/linux-devicetree/CAL_JsqJ9PrX6fj-EbffeJce09MXs=B7t+KS_kOinxaRx38=WxA@mail.gmail.com/
(Explained elaborately in the cover letter)
- Updated the linux,code property with the necessary value
---
 arch/arm/boot/dts/microchip/Makefile          |   3 +
 .../dts/microchip/at91-sam9x75_curiosity.dts  | 309 ++++++++++++++++++
 2 files changed, 312 insertions(+)
 create mode 100644 arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts

diff --git a/arch/arm/boot/dts/microchip/Makefile b/arch/arm/boot/dts/microchip/Makefile
index efde9546c8f4..5b3d518da319 100644
--- a/arch/arm/boot/dts/microchip/Makefile
+++ b/arch/arm/boot/dts/microchip/Makefile
@@ -12,6 +12,7 @@ DTC_FLAGS_at91-sama5d3_eds := -@
 DTC_FLAGS_at91-sama5d3_xplained := -@
 DTC_FLAGS_at91-sama5d4_xplained := -@
 DTC_FLAGS_at91-sama7g5ek := -@
+DTC_FLAGS_at91-sam9x75_curiosity := -@
 dtb-$(CONFIG_SOC_AT91RM9200) += \
 	at91rm9200ek.dtb \
 	mpa1600.dtb
@@ -59,6 +60,8 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
 dtb-$(CONFIG_SOC_SAM9X60) += \
 	at91-sam9x60_curiosity.dtb \
 	at91-sam9x60ek.dtb
+dtb-$(CONFIG_SOC_SAM9X7) += \
+	at91-sam9x75_curiosity.dtb
 dtb-$(CONFIG_SOC_SAM_V7) += \
 	at91-kizbox2-2.dtb \
 	at91-kizbox3-hs.dtb \
diff --git a/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
new file mode 100644
index 000000000000..be37022d3d05
--- /dev/null
+++ b/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
@@ -0,0 +1,309 @@
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
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
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
+			linux,code = <KEY_0>;
+			wakeup-source;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_led_gpio_default>;
+
+		led-red {
+			label = "red";
+			gpios = <&pioC 19 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-green {
+			label = "green";
+			gpios = <&pioC 21 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-blue {
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
+&classd {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_classd>;
+	atmel,pwm-type = "diff";
+	atmel,non-overlap-time = <10>;
+	status = "okay";
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
+&flx6 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
+	status = "okay";
+};
+
+&i2c6 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flx6_default>;
+	i2c-analog-filter;
+	i2c-digital-filter;
+	i2c-digital-filter-width-ns = <35>;
+	status = "okay";
+
+	pmic@5b {
+		compatible = "microchip,mcp16502";
+		reg = <0x5b>;
+
+		regulators {
+			vdd_3v3: VDD_IO {
+				regulator-name = "VDD_IO";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3600000>;
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
+					regulator-mode = <4>;
+				};
+			};
+
+			vddioddr: VDD_DDR {
+				regulator-name = "VDD_DDR";
+				regulator-min-microvolt = <1283000>;
+				regulator-max-microvolt = <1450000>;
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
+					regulator-on-in-suspend;
+					regulator-mode = <4>;
+				};
+			};
+
+			vddcore: VDD_CORE {
+				regulator-name = "VDD_CORE";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1210000>;
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
+					regulator-mode = <4>;
+				};
+			};
+
+			vddcpu: VDD_OTHER {
+				regulator-name = "VDD_OTHER";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-initial-mode = <2>;
+				regulator-allowed-modes = <2>, <4>;
+				regulator-ramp-delay = <3125>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+					regulator-mode = <4>;
+				};
+
+				regulator-state-mem {
+					regulator-mode = <4>;
+				};
+			};
+
+			vldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3700000>;
+				regulator-always-on;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vldo2: LDO2 {
+				regulator-name = "LDO2";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3700000>;
+
+				regulator-state-standby {
+					regulator-on-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&i2s {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2s_default>;
+	#sound-dai-cells = <0>;
+	status = "disabled";
+};
+
+&main_xtal {
+	clock-frequency = <24000000>;
+};
+
+&pinctrl {
+
+	classd {
+		pinctrl_classd: classd {
+			atmel,pins =
+				<AT91_PIOA 18 AT91_PERIPH_C AT91_PINCTRL_PULL_UP
+				 AT91_PIOA 19 AT91_PERIPH_C AT91_PINCTRL_PULL_DOWN>;
+		};
+	};
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
+	i2s {
+		pinctrl_i2s_default: i2s {
+			atmel,pins =
+				<AT91_PIOB 26 AT91_PERIPH_D AT91_PINCTRL_NONE		/* I2SCK */
+				 AT91_PIOB 15 AT91_PERIPH_D AT91_PINCTRL_NONE		/* I2SWS */
+				 AT91_PIOB 16 AT91_PERIPH_D AT91_PINCTRL_NONE		/* I2SDIN */
+				 AT91_PIOB 17 AT91_PERIPH_D AT91_PINCTRL_NONE		/* I2SDOUT */
+				 AT91_PIOB 25 AT91_PERIPH_D AT91_PINCTRL_NONE>;		/* I2SMCK */
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
+&slow_xtal {
+	clock-frequency = <32768>;
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
+&watchdog {
+	status = "okay";
+};
-- 
2.25.1


