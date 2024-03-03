Return-Path: <linux-kernel+bounces-89726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC7C86F4C7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2D31F21D9E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC3CBE5D;
	Sun,  3 Mar 2024 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MuGHtgFO"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEA3BE5A
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468372; cv=none; b=hjt20JYw8U2Nkcc/+Kfsx/GS6cK1A39q6B4pt8tN2dTu44TwugOC9luAeAecwdu60lpq7v/s0t/PgC96TFNlEE51HZhUIP+xlFhU+U8r9/dsGDwYOdwoSgkHjHJHgDsWx/coZY2ctFP0bBZXTD4v6IE16Dxg8JPw8mzoCJLidak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468372; c=relaxed/simple;
	bh=+cDj9jDNP5HtD69tQtvBlX0YxvDmWc/3iFao+F3d3iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YDlmDegaBzTxbE3fKUVwilgDp5CJFO9eVEU4RyQFtmQZockDExW0K3jH8JX6SpNHWGMyvqxMzD/BjMVV01+Yu8mC2soeDLLMBZk7MgdD8CSLYQqrDYoLPxFD5bOlNqfw5ggIYDEPdZr2ywVFiebhu/pP4RKNKmm+YA0VGXFUIV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MuGHtgFO; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33e162b1b71so2564249f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 04:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1709468368; x=1710073168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=61loYWp2oxp+yoBoKT1ZsTxMVVn57Gc8DSrSZbWgMN0=;
        b=MuGHtgFO/3kwJnhP94sP+3HoAKjAZr7PM1NjirwvCYOUkvWOYE8iXh6b/shZwpd49p
         iFw8ZQXNYXGUqcD4qnN32Dy3ozLij/n4PNUuwFBpK1lU2rTLK/8fd9SC/e9TTme+sx2A
         JXw14wuaOGG2w9y1Ei1ZzvNNty7kqXq3g668Bs5dHQH+RBRTPOOTzdWuhCzjoqrr+VWb
         Lbd2Qt3eqWSIjsg82JlubYzFxPbe4CxzBMq9tX05ozxGquo4Sa7UpzEumX9JvR27NCuE
         sDTmZFR1N9A3tyU+m3tNOCL4UhsirppKpbOjd+jN4r9bWPVMMHmQN/q+Kn+mTMlqrjP9
         o6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709468368; x=1710073168;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=61loYWp2oxp+yoBoKT1ZsTxMVVn57Gc8DSrSZbWgMN0=;
        b=oOLf6/08f8+x898PZJxBez3j1kACMZa12LUz7/F+pJNgnK5f3GNpmB2Amh1wzo3TA7
         jh+mdG9TwFPQIcJ2Gf0OlGoOxe9spb8zjTxpGq1VyLNQTHT5OAeNd5vs1t7OXZYJM3Ah
         2nypQgB0swPB3oNZ578khaAWRBbHFbVJfJxc8X1L8DfHthrsNGrdp2MWLnaQDxCcvj8k
         BoyCx8APZ9BPE/wCgGOnnvFFJnSGr6a2cJdAvA4ZZQY0BsF8L+9B4dOXDIFzXQ4rTQET
         J7LctmB0TCHQWw9o1FyGOzKRTUgaCVUi4zFbcNiiMg5Nlwx6ddr4AI7n00i6xdDnqP+N
         xFbA==
X-Forwarded-Encrypted: i=1; AJvYcCXDooPgoQaTLSBtitUAtT4Om+kmZXs/Hyiljc0WHooJyLufo7Gy0R2tQIv1hB2g1crd7kNPYAHMFDE1HsngEno9p48L0S9D8br+zENc
X-Gm-Message-State: AOJu0YxihPekifPNFfxN1c3oykpBaYaH6VdFGOWlOECmTG0jwTDGTLDl
	bV/GVbclRZOU3ZUwC03sDloV37j4GKXPj0T0P/hOqe5xAzP/GZ05/bJOjzQntFE=
X-Google-Smtp-Source: AGHT+IHTjlrHe1jJJvpBqb73j6cv1HKxHNu1LUXV0MmbTrlrCpnjl1nxZpRxjmqAuGftXtPum1jAPg==
X-Received: by 2002:adf:cc06:0:b0:33e:1e29:48fe with SMTP id x6-20020adfcc06000000b0033e1e2948femr6481613wrh.14.1709468368200;
        Sun, 03 Mar 2024 04:19:28 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id dw2-20020a0560000dc200b0033ddfba0c67sm9477927wrb.41.2024.03.03.04.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 04:19:27 -0800 (PST)
Message-ID: <b189dbc3-e875-45c9-b742-928a6a323d5c@tuxon.dev>
Date: Sun, 3 Mar 2024 14:19:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 39/39] ARM: dts: at91: sam9x75_curiosity: add sam9x75
 curiosity board
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 andre.przywara@arm.com, gregory.clement@bootlin.com,
 linus.walleij@linaro.org, baruch@tkos.co.il, mihai.sain@microchip.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223173113.673595-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240223173113.673595-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

s/ARM: dts: at91/ARM: dts: microchip

in title.

On 23.02.2024 19:31, Varshini Rajendran wrote:
> Add device tree file for sam9x75 curiosity board.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
> Changes in v4:
> - Removed full node paths
> - Renamed Leds with color names
> - Corrected regulator node names
> - Added support for classd and i2s nodes and their corresponding
>   pinctrl nodes
> - Dropped USB nodes owing to the discussion here
> https://lore.kernel.org/linux-devicetree/CAL_JsqJ9PrX6fj-EbffeJce09MXs=B7t+KS_kOinxaRx38=WxA@mail.gmail.com/
> (Explained elaborately in the cover letter)
> - Updated the linux,code property with the necessary value
> ---
>  arch/arm/boot/dts/microchip/Makefile          |   3 +
>  .../dts/microchip/at91-sam9x75_curiosity.dts  | 309 ++++++++++++++++++
>  2 files changed, 312 insertions(+)
>  create mode 100644 arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
> 
> diff --git a/arch/arm/boot/dts/microchip/Makefile b/arch/arm/boot/dts/microchip/Makefile
> index efde9546c8f4..5b3d518da319 100644
> --- a/arch/arm/boot/dts/microchip/Makefile
> +++ b/arch/arm/boot/dts/microchip/Makefile
> @@ -12,6 +12,7 @@ DTC_FLAGS_at91-sama5d3_eds := -@
>  DTC_FLAGS_at91-sama5d3_xplained := -@
>  DTC_FLAGS_at91-sama5d4_xplained := -@
>  DTC_FLAGS_at91-sama7g5ek := -@
> +DTC_FLAGS_at91-sam9x75_curiosity := -@

Keep it alphanumerically sorted, thus after sam9x60 entry.

>  dtb-$(CONFIG_SOC_AT91RM9200) += \
>  	at91rm9200ek.dtb \
>  	mpa1600.dtb
> @@ -59,6 +60,8 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
>  dtb-$(CONFIG_SOC_SAM9X60) += \
>  	at91-sam9x60_curiosity.dtb \
>  	at91-sam9x60ek.dtb
> +dtb-$(CONFIG_SOC_SAM9X7) += \
> +	at91-sam9x75_curiosity.dtb
>  dtb-$(CONFIG_SOC_SAM_V7) += \
>  	at91-kizbox2-2.dtb \
>  	at91-kizbox3-hs.dtb \
> diff --git a/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
> new file mode 100644
> index 000000000000..be37022d3d05
> --- /dev/null
> +++ b/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
> @@ -0,0 +1,309 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * at91-sam9x75_curiosity.dts - Device Tree file for Microchip SAM9X75 Curiosity board
> + *
> + * Copyright (C) 2023 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Varshini Rajendran <varshini.rajendran@microchip.com>
> + */
> +/dts-v1/;
> +#include "sam9x7.dtsi"
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "Microchip SAM9X75 Curiosity";
> +	compatible = "microchip,sam9x75-curiosity", "microchip,sam9x7", "atmel,at91sam9";
> +
> +	aliases {
> +		i2c0 = &i2c6;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_key_gpio_default>;
> +
> +		button-user {
> +			label = "USER";
> +			gpios = <&pioC 9 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_0>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_led_gpio_default>;
> +
> +		led-red {
> +			label = "red";
> +			gpios = <&pioC 19 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-green {
> +			label = "green";
> +			gpios = <&pioC 21 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-blue {
> +			label = "blue";
> +			gpios = <&pioC 20 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	memory@20000000 {
> +		device_type = "memory";
> +		reg = <0x20000000 0x10000000>;
> +	};
> +};
> +
> +&classd {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_classd>;
> +	atmel,pwm-type = "diff";
> +	atmel,non-overlap-time = <10>;
> +	status = "okay";
> +};
> +
> +&dbgu {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_dbgu>;
> +	status = "okay";
> +};
> +
> +&dma0 {
> +	status = "okay";
> +};
> +
> +&flx6 {
> +	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
> +	status = "okay";
> +};
> +
> +&i2c6 {

I don't know if you got any review comments w/ regards to this in the
previous email but having flexcoms and inner node grouped together is
easier to follow (at least to me). e.g.:

> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flx6_default>;
> +	i2c-analog-filter;
> +	i2c-digital-filter;
> +	i2c-digital-filter-width-ns = <35>;
> +	status = "okay";
> +
> +	pmic@5b {
> +		compatible = "microchip,mcp16502";
> +		reg = <0x5b>;
> +
> +		regulators {
> +			vdd_3v3: VDD_IO {
> +				regulator-name = "VDD_IO";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3600000>;

I can't find the schematics for this but these values here should reflect
the voltage that the board support not the ones that the PMIC itself
supports. Valid for all the other regulators.


> +				regulator-initial-mode = <2>;
> +				regulator-allowed-modes = <2>, <4>;
> +				regulator-always-on;
> +
> +				regulator-state-standby {
> +					regulator-on-in-suspend;
> +					regulator-mode = <4>;
> +				};
> +
> +				regulator-state-mem {
> +					regulator-mode = <4>;
> +				};
> +			};
> +
> +			vddioddr: VDD_DDR {
> +				regulator-name = "VDD_DDR";
> +				regulator-min-microvolt = <1283000>;
> +				regulator-max-microvolt = <1450000>;
> +				regulator-initial-mode = <2>;
> +				regulator-allowed-modes = <2>, <4>;
> +				regulator-always-on;
> +
> +				regulator-state-standby {
> +					regulator-on-in-suspend;
> +					regulator-mode = <4>;
> +				};
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-mode = <4>;
> +				};
> +			};
> +
> +			vddcore: VDD_CORE {
> +				regulator-name = "VDD_CORE";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1210000>;
> +				regulator-initial-mode = <2>;
> +				regulator-allowed-modes = <2>, <4>;
> +				regulator-always-on;
> +
> +				regulator-state-standby {
> +					regulator-on-in-suspend;
> +					regulator-mode = <4>;
> +				};
> +
> +				regulator-state-mem {
> +					regulator-mode = <4>;
> +				};
> +			};
> +
> +			vddcpu: VDD_OTHER {
> +				regulator-name = "VDD_OTHER";
> +				regulator-min-microvolt = <1700000>;
> +				regulator-max-microvolt = <3600000>;
> +				regulator-initial-mode = <2>;
> +				regulator-allowed-modes = <2>, <4>;
> +				regulator-ramp-delay = <3125>;
> +				regulator-always-on;
> +
> +				regulator-state-standby {
> +					regulator-on-in-suspend;
> +					regulator-mode = <4>;
> +				};
> +
> +				regulator-state-mem {
> +					regulator-mode = <4>;
> +				};
> +			};
> +
> +			vldo1: LDO1 {
> +				regulator-name = "LDO1";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3700000>;
> +				regulator-always-on;
> +
> +				regulator-state-standby {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vldo2: LDO2 {
> +				regulator-name = "LDO2";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3700000>;
> +
> +				regulator-state-standby {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2s {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2s_default>;
> +	#sound-dai-cells = <0>;
> +	status = "disabled";

Any reason this is disabled?

> +};
> +
> +&main_xtal {
> +	clock-frequency = <24000000>;
> +};
> +
> +&pinctrl {
> +

This line could be removed.

> +	classd {
> +		pinctrl_classd: classd {
> +			atmel,pins =
> +				<AT91_PIOA 18 AT91_PERIPH_C AT91_PINCTRL_PULL_UP

Try to be compliant with coding style from here (valid everywhere):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n167

> +				 AT91_PIOA 19 AT91_PERIPH_C AT91_PINCTRL_PULL_DOWN>;
> +		};
> +	};
> +
> +	dbgu {
> +		pinctrl_dbgu: dbgu-0 {

usually pinctrl label is something like the following in Microchip AT91 DTSes:
pinctrl_<ip-name>_default and node name is <ip-name>-default.

Please use the same rule everywhere.

> +			atmel,pins = <AT91_PIOA 26 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
> +				      AT91_PIOA 27 AT91_PERIPH_A AT91_PINCTRL_NONE>;
> +		};
> +	};
> +
> +	flexcom {
> +		pinctrl_flx6_default: flx6-twi {
> +			atmel,pins =
> +				<AT91_PIOA 24 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
> +				 AT91_PIOA 25 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		pinctrl_key_gpio_default: key-gpio-default {
> +			atmel,pins = <AT91_PIOC 9 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +		};
> +	};
> +
> +	i2s {
> +		pinctrl_i2s_default: i2s {
> +			atmel,pins =
> +				<AT91_PIOB 26 AT91_PERIPH_D AT91_PINCTRL_NONE		/* I2SCK */
> +				 AT91_PIOB 15 AT91_PERIPH_D AT91_PINCTRL_NONE		/* I2SWS */
> +				 AT91_PIOB 16 AT91_PERIPH_D AT91_PINCTRL_NONE		/* I2SDIN */
> +				 AT91_PIOB 17 AT91_PERIPH_D AT91_PINCTRL_NONE		/* I2SDOUT */
> +				 AT91_PIOB 25 AT91_PERIPH_D AT91_PINCTRL_NONE>;		/* I2SMCK */
> +		};
> +	};
> +
> +	leds {
> +		pinctrl_led_gpio_default: led-gpio-default {
> +			atmel,pins = <AT91_PIOC 19 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> +				      AT91_PIOC 21 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> +				      AT91_PIOC 20 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +		};
> +	};
> +
> +	sdmmc0 {
> +		pinctrl_sdmmc0_default: sdmmc0 {
> +			atmel,pins =
> +				<AT91_PIOA 2 AT91_PERIPH_A (AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_DIS)					/* PA2 CK  periph A with pullup */
> +				 AT91_PIOA 1 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_DIS)		/* PA1 CMD periph A with pullup */
> +				 AT91_PIOA 0 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_DIS)		/* PA0 DAT0 periph A */
> +				 AT91_PIOA 3 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_DIS)		/* PA3 DAT1 periph A with pullup */
> +				 AT91_PIOA 4 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_DIS)		/* PA4 DAT2 periph A with pullup */
> +				 AT91_PIOA 5 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI | AT91_PINCTRL_SLEWRATE_DIS)>;	/* PA5 DAT3 periph A with pullup */
> +		};
> +	};
> +

You can remove this line

> +}; /* pinctrl */
> +
> +&rtt {
> +	atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
> +};
> +
> +&sdmmc0 {
> +	bus-width = <4>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sdmmc0_default>;
> +	cd-gpios = <&pioA 23 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	status = "okay";
> +};
> +
> +&slow_xtal {
> +	clock-frequency = <32768>;
> +};
> +
> +&power_management {
> +	debounce-delay-us = <976>;
> +	status = "okay";
> +
> +	input@0 {
> +		reg = <0>;
> +	};
> +};
> +
> +&trng {
> +	status = "okay";
> +};
> +
> +&watchdog {
> +	status = "okay";
> +};

