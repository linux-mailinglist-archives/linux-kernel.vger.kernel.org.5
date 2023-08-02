Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF7876C45F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjHBE6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjHBE6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:58:31 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240072115
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 21:58:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe24b794e5so21905935e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 21:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690952307; x=1691557107;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uP81KN3tQ8cedSyoxZUbQyzR0798MUJKD1PTC8kj42Q=;
        b=ZSOQR00oVlkinMvxdkLltiOUbOd3IULsHdEos4Aqc2gBLUmIYjXPeg569mZrsOWnBE
         UIRv6Jfpd+FrxUPGe6g+eln2Qq1rj7hnn6JGwfxzrq6wscOeTJvKmGaezbsqmcqoU7oj
         SMvMvgEdtiCleixV/oca8x+X5Ec5f6zhQMUEgOPZthS10/5HDM1NOoEsm6VqUMpDLBMg
         Sq3B5YFf92+/bJVE44Kr3Vfkvjulswyr3R51ER5ZzDa2jjKNpdiUnVi5FaJauJ4OZY2q
         ezOC5sbII5J8Z+BDcndMjbSOc/7wbM7duPpjySoq5p4gnVktLkh84dSz+ki4n7XnS58m
         HPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690952307; x=1691557107;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uP81KN3tQ8cedSyoxZUbQyzR0798MUJKD1PTC8kj42Q=;
        b=Z2Lu9NqCWcZzzZ8i10fe4Tiy7VSfc/9X9Qj/0GdT/tKgHQvZXHnGcqEccRAt1pOwGg
         uCxZdgas1/Hc1IArG8PeXo7Wa9IY5c5Ofh1h3Ab8e+SwXLWJGz8NO2mhvnxoUFiW7vwm
         gh43F4YoqxHyl4/9dtuJpdCS8Q1lvSw8Y7hAPev51b9j/6ihyGdD27zEf4aRl18bD+ko
         l/YKuXCfiKrucG/6gguDXTtMyK13iqgEPw8GUZcVBr4kPdLfjuhd/MKxIfskujWYf0WC
         91QoGbao6+qibCS77kRQp3avIM2rp3fwMGG4KbvDggVm8nIikUXkvvELTRTdjaPb3Nqn
         n89w==
X-Gm-Message-State: ABy/qLZTKqKEceMypOtqBcVL09TbaSnaz+R2FK8pNOF4eNGojR2STeu4
        VAa8nUCycijl3PjYChsxXhLx0Q==
X-Google-Smtp-Source: APBJJlGriELJO65hKA65iyJlfGqVWtftcTeyj0YcSvZb+qQ8uDgkK+hSLZLUxS+gPd3WC3edfz8zLw==
X-Received: by 2002:a05:600c:2353:b0:3fd:2f8e:2c69 with SMTP id 19-20020a05600c235300b003fd2f8e2c69mr3723241wmq.32.1690952307645;
        Tue, 01 Aug 2023 21:58:27 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c029900b003fba2734f1esm634740wmk.1.2023.08.01.21.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 21:58:27 -0700 (PDT)
Message-ID: <ea2b76bb-e3ae-eb10-7d9d-c17e7dbd2dc1@tuxon.dev>
Date:   Wed, 2 Aug 2023 07:58:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 50/50] ARM: dts: at91: sam9x75_curiosity: add sam9x75
 curiosity board
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        andre.przywara@arm.com, f.fainelli@gmail.com,
        romain.perier@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230728103114.267845-1-varshini.rajendran@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230728103114.267845-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.07.2023 13:31, Varshini Rajendran wrote:
> Add device tree file for sam9x75 curiosity board.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  arch/arm/boot/dts/microchip/Makefile          |   5 +
>  .../dts/microchip/at91-sam9x75_curiosity.dts  | 311 ++++++++++++++++++
>  2 files changed, 316 insertions(+)
>  create mode 100644 arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
> 
> diff --git a/arch/arm/boot/dts/microchip/Makefile b/arch/arm/boot/dts/microchip/Makefile
> index 0f5193d05a31..f3d604c30325 100644
> --- a/arch/arm/boot/dts/microchip/Makefile
> +++ b/arch/arm/boot/dts/microchip/Makefile
> @@ -10,6 +10,7 @@ DTC_FLAGS_at91-sama5d3_eds := -@
>  DTC_FLAGS_at91-sama5d3_xplained := -@
>  DTC_FLAGS_at91-sama5d4_xplained := -@
>  DTC_FLAGS_at91-sama7g5ek := -@
> +DTC_FLAGS_at91-sam9x75_curiosity := -@
>  dtb-$(CONFIG_SOC_AT91RM9200) += \
>  	at91rm9200ek.dtb \
>  	mpa1600.dtb
> @@ -61,6 +62,10 @@ dtb-$(CONFIG_SOC_SAM9X60) += \
>  	at91-sam9x60_curiosity.dtb \
>  	at91-sam9x60ek.dtb
>  # Enables support for device-tree overlays
> +DTC_FLAGS_at91-sam9x75_curiosity := -@
> +dtb-$(CONFIG_SOC_SAM9X7) += \
> +	at91-sam9x75_curiosity.dtb
> +# Enables support for device-tree overlays
>  DTC_FLAGS_at91-sama5d27_som1_ek := -@
>  DTC_FLAGS_at91-sama5d27_wlsom1_ek := -@
>  DTC_FLAGS_at91-sama5d2_icp := -@
> diff --git a/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
> new file mode 100644
> index 000000000000..a9ecb02a9f3c
> --- /dev/null
> +++ b/arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
> @@ -0,0 +1,311 @@
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
> +		i2c1 = &i2c7;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	clocks {
> +		clock-slowxtal {
> +			clock-frequency = <32768>;
> +		};
> +
> +		clock-mainxtal {
> +			clock-frequency = <24000000>;
> +		};
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
> +			linux,code = <KEY_PROG1>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_led_gpio_default>;
> +
> +		led-0 {
> +			label = "red";
> +			gpios = <&pioC 19 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-1 {
> +			label = "green";
> +			gpios = <&pioC 21 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-2 {
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
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&flx6 {
> +	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
> +	status = "okay";
> +
> +	i2c6 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_flx6_default>;
> +		i2c-analog-filter;
> +		i2c-digital-filter;
> +		i2c-digital-filter-width-ns = <35>;
> +		status = "okay";
> +
> +		pmic@5b {
> +			compatible = "microchip,mcp16502";
> +			reg = <0x5b>;
> +
> +			regulators {
> +				vdd_3v3: VDD-IO {
> +					regulator-name = "VDD_IO";
> +					regulator-min-microvolt = <3000000>;
> +					regulator-max-microvolt = <3600000>;

Please double check board + SoC supports this range of voltage. Same for
the other regulator entries.

> +					regulator-initial-mode = <2>;
> +					regulator-allowed-modes = <2>, <4>;
> +					regulator-always-on;
> +
> +					regulator-state-standby {
> +						regulator-on-in-suspend;
> +						regulator-mode = <4>;
> +					};
> +
> +					regulator-state-mem {
> +						regulator-mode = <4>;
> +					};
> +				};
> +
> +				vddioddr: VDD-DDR {
> +					regulator-name = "VDD_DDR";
> +					regulator-min-microvolt = <1283000>;
> +					regulator-max-microvolt = <1450000>;
> +					regulator-initial-mode = <2>;
> +					regulator-allowed-modes = <2>, <4>;
> +					regulator-always-on;
> +
> +					regulator-state-standby {
> +						regulator-on-in-suspend;
> +						regulator-mode = <4>;
> +					};
> +
> +					regulator-state-mem {
> +						regulator-on-in-suspend;
> +						regulator-mode = <4>;
> +					};
> +				};
> +
> +				vddcore: VDD-CORE {
> +					regulator-name = "VDD_CORE";
> +					regulator-min-microvolt = <500000>;
> +					regulator-max-microvolt = <1210000>;
> +					regulator-initial-mode = <2>;
> +					regulator-allowed-modes = <2>, <4>;
> +					regulator-always-on;
> +
> +					regulator-state-standby {
> +						regulator-on-in-suspend;
> +						regulator-mode = <4>;
> +					};
> +
> +					regulator-state-mem {
> +						regulator-mode = <4>;
> +					};
> +				};
> +
> +				vddcpu: VDD-OTHER {
> +					regulator-name = "VDD_OTHER";
> +					regulator-min-microvolt = <1700000>;
> +					regulator-max-microvolt = <3600000>;
> +					regulator-initial-mode = <2>;
> +					regulator-allowed-modes = <2>, <4>;
> +					regulator-ramp-delay = <3125>;
> +					regulator-always-on;
> +
> +					regulator-state-standby {
> +						regulator-on-in-suspend;
> +						regulator-mode = <4>;
> +					};
> +
> +					regulator-state-mem {
> +						regulator-mode = <4>;
> +					};
> +				};
> +
> +				vldo1: LDO1 {
> +					regulator-name = "LDO1";
> +					regulator-min-microvolt = <1200000>;
> +					regulator-max-microvolt = <3700000>;
> +					regulator-always-on;
> +
> +					regulator-state-standby {
> +						regulator-on-in-suspend;
> +					};
> +				};
> +
> +				vldo2: LDO2 {
> +					regulator-name = "LDO2";
> +					regulator-min-microvolt = <1200000>;
> +					regulator-max-microvolt = <3700000>;
> +
> +					regulator-state-standby {
> +						regulator-on-in-suspend;
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&ohci0 {
> +	num-ports = <3>;
> +	atmel,vbus-gpio = <0
> +			   &pioC 27 GPIO_ACTIVE_HIGH
> +			   &pioB 18 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usb_default>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +
> +	dbgu {
> +		pinctrl_dbgu: dbgu-0 {
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
> +	leds {
> +		pinctrl_led_gpio_default: led-gpio-default {
> +			atmel,pins = <AT91_PIOC 19 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> +				      AT91_PIOC 21 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> +				      AT91_PIOC 20 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +		};
> +	};
> +
> +	ohci0 {
> +		pinctrl_usb_default: usb-default {
> +			atmel,pins = <AT91_PIOC 27 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
> +				      AT91_PIOB 18 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
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
> +	usb0 {
> +		pinctrl_usba_vbus: usba-vbus {
> +			atmel,pins = <AT91_PIOC 8 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +		};
> +	};
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
> +&power_management {

Make sure this entry is in dtsi. I know this is shdwc usually. I don't have
the dtsi at hand (your threading is broken).

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
> +&usb0 {
> +	atmel,vbus-gpio = <&pioC 8 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usba_vbus>;
> +	status = "okay";
> +};
> +
> +&watchdog {
> +	status = "okay";
> +};
