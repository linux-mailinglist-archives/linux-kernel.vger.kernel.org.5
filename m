Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39498775217
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 06:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjHIE4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 00:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjHIE4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 00:56:52 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A183172A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 21:56:50 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc73a2b0easo17175015ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 21:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1691557009; x=1692161809;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GVGDgLC2lV/D0stIFGOMXf34ndUw3d4Vg8hXGGH31SQ=;
        b=Xk07AoUVYXr0yqw4c25/iCyOYQji16ybsK7P/AbzdNI/EgL7KaUbgw2Y6NgRq3SvhN
         8/IHhSXwC0XEOkJvI0CqOmkAjFO92V3oTDJ8BqgwjjHvjP8r880dkXP5F48fSaloJyts
         Ozvh94OeNRDiIG9Yv7vDenxaE//CpGsAj7Hav3chCg3yZ0BvhJZthteOssDYI7vY0fmW
         uulYS3e2qOu6+cBT4BXaVM7IA2QddP1517KKUTrlSlGWC3ZYxvae+OlunyELc3LwKMLR
         qok12TYF8TljZ+ijZ1lWjp7gDHeX5bzvlMQ+7rNShMSZPjjoMM/Hi9p7H8nELsA2Z4wK
         9fJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691557009; x=1692161809;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVGDgLC2lV/D0stIFGOMXf34ndUw3d4Vg8hXGGH31SQ=;
        b=MB5cqiEVZUiv+JvE1y0UMepOXL+YJ8PZmQmDpUXHwZbJlyI4zTLERZXCNfxeRKJkyH
         J0wEIwtku94Wh+NEA8JGdexEnLU+fpIFJtJNGSdps4rTmGqOWxllV9c8ZFiT53vaZhRW
         ewkL/Ehg86z8QmRQ+eHvW7L1gtpMXLj00u2KI0sx6Tf1WgEN06xkxi+elsmfZkOaqFkN
         3/Z2/QYLda1iP6TIbGLPOVKg8P0WS6fcWr6nWRNsm3/E/FAsVtdWK0Popf/YPVMl4at2
         wvfw3WmQznNeype9lBqbDZwlyzzkY2nI8dWSnd4IcGZMQBatMO/eim6012SN5J6RecGy
         mARw==
X-Gm-Message-State: AOJu0Yw08VMehdwpmgSCy22Lo5qhArgPEv7anse1iREWON8ktNZ9x/27
        7huPnCuVi8oElhK9iH6MCiEV2w==
X-Google-Smtp-Source: AGHT+IH0WnHNLQZHGPMeYyUcIU4z0HP3ftQpSowYkROLKdzXZnzGUYlbXXutDNEYEe5AgZ8Ms5GMAA==
X-Received: by 2002:a17:903:2343:b0:1bb:b226:52b1 with SMTP id c3-20020a170903234300b001bbb22652b1mr1879112plh.17.1691557009425;
        Tue, 08 Aug 2023 21:56:49 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902c3d500b001bba1188c8esm9932343plj.271.2023.08.08.21.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 21:56:49 -0700 (PDT)
Message-ID: <127fc712-d924-f27f-5449-33385e89d6c3@tuxon.dev>
Date:   Wed, 9 Aug 2023 07:56:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH] ARM: dts: at91: sama5d29_curiosity: Add device tree for
 sama5d29_curiosity board
To:     Mihai Sain <mihai.sain@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, cristian.birsan@microchip.com,
        alexandre.belloni@bootlin.com, andre.przywara@arm.com,
        jerry.ray@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     andrei.simion@microchip.com
References: <20230804101043.4063-1-mihai.sain@microchip.com>
Content-Language: en-US
In-Reply-To: <20230804101043.4063-1-mihai.sain@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM28,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mihai,

On 04.08.2023 13:10, Mihai Sain wrote:
> Add initial device tree file for sama5d29_curiosity board.
> 
> Changes in v2:
> * drop dt-bindings patch
> * remove vdd_1v8 regulator
> * fix flx4 node to use 1 spi node and pinctrl
> * add i2s0 node and pinctrl
> * remove macb0 node and pinctrl
> * remove unused pinctrl
> * sort in alphabetical order all nodes and pinctrl
> * replace "_" with "-" in node names
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> ---
>  arch/arm/boot/dts/microchip/Makefile          |   2 +
>  .../dts/microchip/at91-sama5d29_curiosity.dts | 615 ++++++++++++++++++
>  2 files changed, 617 insertions(+)
>  create mode 100644 arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
> 
> diff --git a/arch/arm/boot/dts/microchip/Makefile b/arch/arm/boot/dts/microchip/Makefile
> index 31e03747cdf4..efde9546c8f4 100644
> --- a/arch/arm/boot/dts/microchip/Makefile
> +++ b/arch/arm/boot/dts/microchip/Makefile
> @@ -4,6 +4,7 @@ DTC_FLAGS_at91-sam9x60_curiosity := -@
>  DTC_FLAGS_at91-sam9x60ek := -@
>  DTC_FLAGS_at91-sama5d27_som1_ek := -@
>  DTC_FLAGS_at91-sama5d27_wlsom1_ek := -@
> +DTC_FLAGS_at91-sama5d29_curiosity := -@
>  DTC_FLAGS_at91-sama5d2_icp := -@
>  DTC_FLAGS_at91-sama5d2_ptc_ek := -@
>  DTC_FLAGS_at91-sama5d2_xplained := -@
> @@ -64,6 +65,7 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
>  	at91-nattis-2-natte-2.dtb \
>  	at91-sama5d27_som1_ek.dtb \
>  	at91-sama5d27_wlsom1_ek.dtb \
> +	at91-sama5d29_curiosity.dtb \
>  	at91-sama5d2_icp.dtb \
>  	at91-sama5d2_ptc_ek.dtb \
>  	at91-sama5d2_xplained.dtb \
> diff --git a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
> new file mode 100644
> index 000000000000..06818962e1f9
> --- /dev/null
> +++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
> @@ -0,0 +1,615 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * at91-sama5d29_curiosity.dts - Device Tree file for SAMA5D29 Curiosity board
> + *
> + * Copyright (C) 2023 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Mihai Sain <mihai.sain@microchip.com>
> + *
> + */
> +/dts-v1/;
> +#include "sama5d29.dtsi"
> +#include "sama5d2-pinfunc.h"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/mfd/atmel-flexcom.h>
> +
> +/ {
> +	model = "Microchip SAMA5D29 Curiosity";
> +	compatible = "microchip,sama5d29-curiosity", "atmel,sama5d29", "atmel,sama5d2", "atmel,sama5";
> +
> +	aliases {
> +		serial0 = &uart0;	// debug
> +		serial1 = &uart1;	// RPi
> +		serial2 = &uart3;	// mikro BUS 2
> +		serial3 = &uart4;	// mikro BUS 1
> +		serial4 = &uart6;	// flx1 Bluetooth
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootwait";
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	clocks {
> +		slow_xtal {
> +			clock-frequency = <32768>;
> +		};
> +
> +		main_xtal {
> +			clock-frequency = <24000000>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_key_gpio_default>;
> +
> +		button-1 {
> +			label = "USER BUTTON";
> +			gpios = <&pioA PIN_PA17 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_PROG1>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_led_gpio_default>;
> +		status = "okay";
> +
> +		red {
> +			label = "red";
> +			gpios = <&pioA PIN_PA7 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		green {
> +			label = "green";
> +			gpios = <&pioA PIN_PA8 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		blue {
> +			label = "blue";
> +			gpios = <&pioA PIN_PA9 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	memory@20000000 {
> +		device_type = "memory";
> +		reg = <0x20000000 0x20000000>;
> +	};
> +};
> +
> +&adc {
> +	vddana-supply = <&vdd_3v3>;
> +	vref-supply = <&vdd_3v3>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc_default &pinctrl_adtrg_default>;
> +	status = "okay";
> +};
> +
> +&can0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_can0_default>;
> +	status = "okay";
> +};
> +
> +&can1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_can1_default>;
> +	status = "okay";
> +};
> +
> +&flx1 {
> +	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
> +	status = "okay";
> +
> +	uart6: serial@200 {
> +		pinctrl-0 = <&pinctrl_flx1_default>;
> +		pinctrl-names = "default";
> +		atmel,use-dma-rx;
> +		atmel,use-dma-tx;
> +		status = "okay";
> +	};
> +};
> +
> +&flx4 {
> +	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_SPI>;
> +	status = "okay";
> +
> +	spi6: spi@400 {
> +		dmas = <0>, <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_rpi_spi>;
> +		status = "okay";
> +	};
> +};
> +
> +&i2c0 {
> +	dmas = <0>, <0>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&pinctrl_i2c0_default>;
> +	pinctrl-1 = <&pinctrl_i2c0_gpio>;
> +	sda-gpios = <&pioA PIN_PB31 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&pioA PIN_PC0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	i2c-sda-hold-time-ns = <350>;
> +	status = "okay";
> +
> +	mcp16502@5b {
> +		compatible = "microchip,mcp16502";
> +		reg = <0x5b>;
> +		status = "okay";
> +		lpm-gpios = <&pioBU 0 GPIO_ACTIVE_LOW>;
> +
> +		regulators {
> +			vdd_3v3: VDD_IO {
> +				regulator-name = "VDD_IO";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
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
> +					regulator-off-in-suspend;
> +					regulator-mode = <4>;
> +				};
> +			};
> +
> +			vddio_ddr: VDD_DDR {
> +				regulator-name = "VDD_DDR";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-initial-mode = <2>;
> +				regulator-allowed-modes = <2>, <4>;
> +				regulator-always-on;
> +
> +				regulator-state-standby {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1200000>;
> +					regulator-changeable-in-suspend;
> +					regulator-mode = <4>;
> +				};
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1200000>;
> +					regulator-changeable-in-suspend;
> +					regulator-mode = <4>;
> +				};
> +			};
> +
> +			vdd_core: VDD_CORE {
> +				regulator-name = "VDD_CORE";
> +				regulator-min-microvolt = <1250000>;
> +				regulator-max-microvolt = <1250000>;
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
> +					regulator-off-in-suspend;
> +					regulator-mode = <4>;
> +				};
> +			};
> +
> +			vdd_ddr: VDD_OTHER {
> +				regulator-name = "VDD_OTHER";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-initial-mode = <2>;
> +				regulator-allowed-modes = <2>, <4>;
> +				regulator-always-on;
> +
> +				regulator-state-standby {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +					regulator-changeable-in-suspend;
> +					regulator-mode = <4>;
> +				};
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +					regulator-changeable-in-suspend;
> +					regulator-mode = <4>;
> +				};
> +			};
> +
> +			LDO1 {
> +				regulator-name = "LDO1";
> +				regulator-min-microvolt = <2500000>;
> +				regulator-max-microvolt = <2500000>;
> +				regulator-always-on;

Does this feeds something important on the board? Otherwise can you remove
regulator-always-on?

> +
> +				regulator-state-standby {
> +					regulator-on-in-suspend;

Same here. Is it necessary to have it enabled on standby?

> +				};
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			LDO2 {
> +				regulator-name = "LDO2";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;

same here.

> +
> +				regulator-state-standby {
> +					regulator-on-in-suspend;

same here.

> +				};
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	dmas = <0>, <0>;
> +	pinctrl-names = "default", "gpio";
> +	pinctrl-0 = <&pinctrl_i2c1_default>;
> +	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> +	i2c-analog-filter;
> +	i2c-digital-filter;
> +	i2c-digital-filter-width-ns = <35>;
> +	sda-gpios = <&pioA PIN_PD4 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&pioA PIN_PD5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	status = "okay";
> +};
> +
> +&i2s0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2s0_default>;
> +	status = "okay";

I see no sound bindings on DT. Is there any reason for having this here?

> +};
> +
> +&pioA {
> +	pinctrl_adc_default: adc-default {
> +		pinmux = <PIN_PD25__GPIO>,
> +			 <PIN_PD26__GPIO>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_adtrg_default: adtrg-default {
> +		pinmux = <PIN_PD31__ADTRG>;
> +		bias-pull-up;
> +	};
> +
> +	pinctrl_can0_default: can0-default {
> +		pinmux = <PIN_PC10__CANTX0>,
> +			 <PIN_PC11__CANRX0>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_can1_default: can1-default {
> +		pinmux = <PIN_PC26__CANTX1>,
> +			 <PIN_PC27__CANRX1>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_debug_uart: debug-uart {
> +		pinmux = <PIN_PB26__URXD0>,
> +			 <PIN_PB27__UTXD0>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_flx1_default: flx1-default {
> +		pinmux = <PIN_PA24__FLEXCOM1_IO0>,
> +			 <PIN_PA23__FLEXCOM1_IO1>,
> +			 <PIN_PA25__FLEXCOM1_IO3>,
> +			 <PIN_PA26__FLEXCOM1_IO4>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_i2c0_default: i2c0-default {
> +		pinmux = <PIN_PB31__TWD0>,
> +			 <PIN_PC0__TWCK0>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_i2c0_gpio: i2c0-gpio {
> +		pinmux = <PIN_PB31__GPIO>,
> +			 <PIN_PC0__GPIO>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_i2c1_default: i2c1-default {
> +		pinmux = <PIN_PD4__TWD1>,
> +			 <PIN_PD5__TWCK1>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_i2c1_gpio: i2c1-gpio {
> +		pinmux = <PIN_PD4__GPIO>,
> +			 <PIN_PD5__GPIO>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_i2s0_default: i2s0-default {
> +		pinmux = <PIN_PD19__I2SC0_CK>,
> +			 <PIN_PD20__I2SC0_MCK>,
> +			 <PIN_PD21__I2SC0_WS>,
> +			 <PIN_PD22__I2SC0_DI0>,
> +			 <PIN_PD23__I2SC0_DO0>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_key_gpio_default: key-gpio-default {
> +		pinmux = <PIN_PA17__GPIO>;
> +		bias-pull-up;
> +	};
> +
> +	pinctrl_led_gpio_default: led-gpio-default {
> +		pinmux = <PIN_PA7__GPIO>,
> +			 <PIN_PA8__GPIO>,
> +			 <PIN_PA9__GPIO>;
> +		bias-pull-up;
> +	};
> +
> +	pinctrl_mikrobus1_pwm: mikrobus1-pwm {
> +		pinmux = <PIN_PA31__PWML0>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_mikrobus2_pwm: mikrobus2-pwm {
> +		pinmux = <PIN_PB0__PWMH1>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_mikrobus1_uart: mikrobus1-uart {
> +		pinmux = <PIN_PB3__URXD4>,
> +			 <PIN_PB4__UTXD4>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_mikrobus2_uart: mikrobus2-uart {
> +		pinmux = <PIN_PB11__URXD3>,
> +			 <PIN_PB12__UTXD3>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_qspi1_default: qspi1-default {
> +		pinmux = <PIN_PB5__QSPI1_SCK>,
> +			 <PIN_PB6__QSPI1_CS>,
> +			 <PIN_PB7__QSPI1_IO0>,
> +			 <PIN_PB8__QSPI1_IO1>,
> +			 <PIN_PB9__QSPI1_IO2>,
> +			 <PIN_PB10__QSPI1_IO3>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_rpi_spi: rpi-spi {
> +		pinmux = <PIN_PD12__FLEXCOM4_IO0>,
> +			 <PIN_PD13__FLEXCOM4_IO1>,
> +			 <PIN_PD14__FLEXCOM4_IO2>,
> +			 <PIN_PD15__FLEXCOM4_IO3>,
> +			 <PIN_PD16__FLEXCOM4_IO4>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_rpi_uart: rpi-uart {
> +		pinmux = <PIN_PD2__URXD1>,
> +			 <PIN_PD3__UTXD1>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_sdmmc0_default: sdmmc0-default {
> +		pinmux = <PIN_PA0__SDMMC0_CK>,
> +			 <PIN_PA1__SDMMC0_CMD>,
> +			 <PIN_PA2__SDMMC0_DAT0>,
> +			 <PIN_PA3__SDMMC0_DAT1>,
> +			 <PIN_PA4__SDMMC0_DAT2>,
> +			 <PIN_PA5__SDMMC0_DAT3>,
> +			 <PIN_PA11__SDMMC0_VDDSEL>,
> +			 <PIN_PA13__SDMMC0_CD>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_sdmmc1_default: sdmmc1-default {
> +		pinmux = <PIN_PA18__SDMMC1_DAT0>,
> +			 <PIN_PA19__SDMMC1_DAT1>,
> +			 <PIN_PA20__SDMMC1_DAT2>,
> +			 <PIN_PA21__SDMMC1_DAT3>,
> +			 <PIN_PA22__SDMMC1_CK>,
> +			 <PIN_PA28__SDMMC1_CMD>,
> +			 <PIN_PA30__SDMMC1_CD>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_spi1_default: spi1-default {
> +		pinmux = <PIN_PC1__SPI1_SPCK>,
> +			 <PIN_PC2__SPI1_MOSI>,
> +			 <PIN_PC3__SPI1_MISO>,
> +			 <PIN_PC4__SPI1_NPCS0>,
> +			 <PIN_PC5__SPI1_NPCS1>,
> +			 <PIN_PC6__SPI1_NPCS2>,
> +			 <PIN_PC7__SPI1_NPCS3>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_usb_default: usb-default {
> +		pinmux = <PIN_PA6__GPIO>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_usba_vbus: usba-vbus {
> +		pinmux = <PIN_PB13__GPIO>;
> +		bias-disable;
> +	};
> +};
> +
> +&pwm0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_mikrobus1_pwm &pinctrl_mikrobus2_pwm>;
> +	status = "okay";
> +};
> +
> +&qspi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_qspi1_default>;
> +	status = "okay";
> +
> +	flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <80000000>;
> +		spi-tx-bus-width = <4>;
> +		spi-rx-bus-width = <4>;
> +		m25p,fast-read;
> +		label = "atmel_qspi1";
> +		status = "okay";
> +
> +		at91bootstrap@0 {
> +			label = "at91bootstrap";
> +			reg = <0x0 0x40000>;
> +		};
> +
> +		bootloader@40000 {
> +			label = "bootloader";
> +			reg = <0x40000 0xc0000>;
> +		};
> +
> +		bootloaderenvred@100000 {
> +			label = "bootloader env redundant";
> +			reg = <0x100000 0x40000>;
> +		};
> +
> +		bootloaderenv@140000 {
> +			label = "bootloader env";
> +			reg = <0x140000 0x40000>;
> +		};
> +
> +		dtb@180000 {
> +			label = "device tree";
> +			reg = <0x180000 0x80000>;
> +		};
> +
> +		kernel@200000 {
> +			label = "kernel";
> +			reg = <0x200000 0x600000>;
> +		};
> +	};
> +};
> +
> +&sdmmc0 {
> +	bus-width = <4>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sdmmc0_default>;
> +	disable-wp;
> +	status = "okay";
> +};
> +
> +&sdmmc1 {
> +	bus-width = <4>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sdmmc1_default>;
> +	disable-wp;
> +	status = "okay";
> +};
> +
> +&shutdown_controller {
> +	debounce-delay-us = <976>;
> +	atmel,wakeup-rtc-timer;
> +
> +	input@0 {
> +		reg = <0>;
> +	};
> +};
> +
> +&spi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi1_default>;
> +	status = "okay";
> +};
> +
> +&tcb0 {
> +	timer0: timer@0 {
> +		compatible = "atmel,tcb-timer";
> +		reg = <0>;
> +	};
> +
> +	timer1: timer@1 {
> +		compatible = "atmel,tcb-timer";
> +		reg = <1>;
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_debug_uart>;
> +	atmel,use-dma-rx;
> +	atmel,use-dma-tx;
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rpi_uart>;
> +	atmel,use-dma-rx;
> +	atmel,use-dma-tx;
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_mikrobus2_uart>;
> +	atmel,use-dma-rx;
> +	atmel,use-dma-tx;
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_mikrobus1_uart>;
> +	atmel,use-dma-rx;
> +	atmel,use-dma-tx;
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	atmel,vbus-gpio = <&pioA PIN_PB13 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usba_vbus>;
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	num-ports = <3>;
> +	atmel,vbus-gpio = <0
> +			   &pioA PIN_PA6 GPIO_ACTIVE_HIGH
> +			   0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usb_default>;
> +	status = "okay";
> +};
> +
> +&usb2 {
> +	status = "okay";
> +};
> +
> +&watchdog {
> +	status = "okay";
> +};
