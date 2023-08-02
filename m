Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7EC76C479
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 07:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjHBFCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 01:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjHBFCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 01:02:14 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9566B1BFA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 22:02:11 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so59634935e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 22:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690952530; x=1691557330;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tX30vyOJ0W3rAzT82pSiDmtOb5f4BZPkUXyirCKxrGA=;
        b=D1kv1KyHZsBbFGGEqQeZijbwGvmjRiEb3ahgG+p9rd06ZDKPYruvMSCbqfcmwfgqKI
         XW28c3/DTWAxAlinSNduFfi6k8CGx5ISMXa5nOg1QtcK05oA4Llv7rtzggCocL9ZSIaW
         EEv6bRHFuo5/8PJrH1saYf65ElKciB1pdoOlwc1j9yfObFDIbVKDkm8BAJbay8FKsLv8
         wrcfcKBejw3FUeUmWnb7NmAtCTCL1xAs9o1HMHojTh6NX1Lil4lO/HHCgGhwEFUi9EQZ
         NcBNhhs7/GDYnhSe0wj78r4bYRFevd4YUba39eOdpmfSwcqLtoQuUhF0wJ+RRfuXF44t
         Er2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690952530; x=1691557330;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tX30vyOJ0W3rAzT82pSiDmtOb5f4BZPkUXyirCKxrGA=;
        b=Vc7DDMzQuUO2heUXv0LIv8VjucWM+G1DxCoOifGs1K5BiaeiCrfiXo/PHGFqJPzPeu
         pOlfWPMTFa+tXMwvPNDNv1ZLNvwiU155z1CNvG11XUe5RFYKCDW5a2fQYr6sE4zpFKD8
         gO0+GTSq9/x8aDGD6tu1XXjFHRJH68XUmwTh0X3NtUO1xOn3u43N/yhwWV7ihaYrQ+O/
         FAs3ABmubNXOw/Xu3KPq5jX9kIACBCI9a/1aGlO9CqM4flk6eBe7UUyJqRm/IoHt4BoZ
         3/LYV6tAENE6w1OVk4JxBWQjT21EP3t7CQfSpVNc34MOKjXz7ujFPZfVyZjQQj31bFdv
         395A==
X-Gm-Message-State: ABy/qLYOku11bi0afbDipK9ULPEBN+hEZ3IoLyN3BEj1KgMx6ga7SMvB
        yjigsRiBh3NVzxzYyF+ZYnpA7Q==
X-Google-Smtp-Source: APBJJlFpqhkgVg2LVJcpgba2520wCFbUXfICuC1US90nuQuuh/vZphYi1EjKUyQ8wOT6sita3jyemA==
X-Received: by 2002:a1c:7c03:0:b0:3fe:2140:f504 with SMTP id x3-20020a1c7c03000000b003fe2140f504mr3905732wmc.20.1690952529829;
        Tue, 01 Aug 2023 22:02:09 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id p15-20020a056000018f00b0030ae53550f5sm17775490wrx.51.2023.08.01.22.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 22:02:09 -0700 (PDT)
Message-ID: <72738aa5-bbbc-db93-d23e-3bc5b3b12d71@tuxon.dev>
Date:   Wed, 2 Aug 2023 08:02:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] ARM: dts: at91: sama5d29_curiosity: Add device tree
 for sama5d29_curiosity board
Content-Language: en-US
To:     Mihai Sain <mihai.sain@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, andre.przywara@arm.com,
        andrei.simion@microchip.com, jerry.ray@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     cristian.birsan@microchip.com
References: <20230801111151.6546-1-mihai.sain@microchip.com>
 <20230801111151.6546-2-mihai.sain@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230801111151.6546-2-mihai.sain@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mihai,

Few other comments. See below.

On 01.08.2023 14:11, Mihai Sain wrote:
> Add initial device tree file for sama5d29_curiosity board.
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> ---
>  arch/arm/boot/dts/microchip/Makefile          |   2 +
>  .../dts/microchip/at91-sama5d29_curiosity.dts | 706 ++++++++++++++++++
>  2 files changed, 708 insertions(+)
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
> index 000000000000..17af10446dac
> --- /dev/null
> +++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
> @@ -0,0 +1,706 @@
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
> +			label = "USER_PB";
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
> +
> +	vdd_1v8: regulator-vqmmc {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDD_1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		status = "okay";
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
> +&flx4 { /* RPi spi */
> +	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_SPI>;
> +	status = "okay";
> +
> +	spi6: spi@400 {
> +		dmas = <0>, <0>;
> +		cs-gpios = <&pioA PIN_PD15 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_rpi_spi &pinctrl_rpi_spi_cs0>;
> +		status = "okay";
> +	};
> +
> +	spi7: spi@400 {
> +		dmas = <0>, <0>;
> +		cs-gpios = <&pioA PIN_PD16 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_rpi_spi &pinctrl_rpi_spi_cs1>;
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

Dashes in node name, thus VDD-IO (same for the other entires).

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
> +
> +				regulator-state-standby {
> +					regulator-on-in-suspend;
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
> +
> +				regulator-state-standby {
> +					regulator-on-in-suspend;
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
> +	i2c-analog-filter;
> +	i2c-digital-filter;
> +	i2c-digital-filter-width-ns = <35>;
> +	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> +	sda-gpios = <&pioA PIN_PD4 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&pioA PIN_PD5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	status = "okay";
> +};
> +
> +&macb0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_macb0_default &pinctrl_macb0_phy_irq>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	phy-mode = "rmii";
> +	status = "disabled";
> +};
> +
> +&pioA {
> +	pinctrl_adc_default: adc_default {

Dashes in node name, thus adc-default (same for the other entries).

> +		pinmux = <PIN_PD25__GPIO>,
> +			 <PIN_PD26__GPIO>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_adtrg_default: adtrg_default {
> +		pinmux = <PIN_PD31__ADTRG>;
> +		bias-pull-up;
> +	};
> +
> +	pinctrl_rpi_spi: rpi_spi {
> +		pinmux = <PIN_PD12__FLEXCOM4_IO0>,
> +			 <PIN_PD13__FLEXCOM4_IO1>,
> +			 <PIN_PD14__FLEXCOM4_IO2>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_rpi_spi_cs0: rpi_spi_cs0 {
> +		pinmux = <PIN_PD15__FLEXCOM4_IO3>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_rpi_spi_cs1: rpi_spi_cs1 {
> +		pinmux = <PIN_PD16__FLEXCOM4_IO4>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_spi1_default: spi1_default {
> +		pinmux = <PIN_PC1__SPI1_SPCK>,
> +			 <PIN_PC2__SPI1_MOSI>,
> +			 <PIN_PC3__SPI1_MISO>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_spi1_cs: spi1_cs {
> +		pinmux = <PIN_PC4__SPI1_NPCS0>,
> +			 <PIN_PC5__SPI1_NPCS1>,
> +			 <PIN_PC6__SPI1_NPCS2>,
> +			 <PIN_PC7__SPI1_NPCS3>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_rpi_uart: rpi_uart {
> +		pinmux = <PIN_PD2__URXD1>,
> +			 <PIN_PD3__UTXD1>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_debug_uart: debug_uart {
> +		pinmux = <PIN_PB26__URXD0>,
> +			 <PIN_PB27__UTXD0>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_can0_default: can0_default {
> +		pinmux = <PIN_PC10__CANTX0>,
> +			 <PIN_PC11__CANRX0>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_can1_default: can1_default {
> +		pinmux = <PIN_PC26__CANTX1>,
> +			 <PIN_PC27__CANRX1>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_i2c0_default: i2c0_default {
> +		pinmux = <PIN_PB31__TWD0>,
> +			 <PIN_PC0__TWCK0>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_i2c0_gpio: i2c0_gpio {
> +		pinmux = <PIN_PB31__GPIO>,
> +			 <PIN_PC0__GPIO>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_i2c1_default: i2c1_default {
> +		pinmux = <PIN_PD4__TWD1>,
> +			 <PIN_PD5__TWCK1>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_i2c1_gpio: i2c1_gpio {
> +		pinmux = <PIN_PD4__GPIO>,
> +			 <PIN_PD5__GPIO>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_key_gpio_default: key_gpio_default {
> +		pinmux = <PIN_PA17__GPIO>;
> +		bias-pull-up;
> +	};
> +
> +	pinctrl_led_gpio_default: led_gpio_default {
> +		pinmux = <PIN_PA7__GPIO>,
> +			 <PIN_PA8__GPIO>,
> +			 <PIN_PA9__GPIO>;
> +		bias-pull-up;
> +	};
> +
> +	pinctrl_qspi1_default: qspi1_default {
> +		pinmux = <PIN_PB5__QSPI1_SCK>,
> +			 <PIN_PB6__QSPI1_CS>,
> +			 <PIN_PB7__QSPI1_IO0>,
> +			 <PIN_PB8__QSPI1_IO1>,
> +			 <PIN_PB9__QSPI1_IO2>,
> +			 <PIN_PB10__QSPI1_IO3>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_sdmmc0_default: sdmmc0_default {
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
> +	pinctrl_sdmmc1_default: sdmmc1_default {
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
> +	pinctrl_mikrobus1_an: mikrobus1_an {
> +		pinmux = <PIN_PD25__GPIO>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_mikrobus1_rst: mikrobus1_rst {
> +		pinmux = <PIN_PA16__GPIO>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_mikrobus1_spi_cs: mikrobus1_spi_cs {
> +		pinmux = <PIN_PC4__SPI1_NPCS0>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_mikrobus1_spi: mikrobus1_spi {
> +		pinmux = <PIN_PC1__SPI1_SPCK>,
> +			 <PIN_PC2__SPI1_MOSI>,
> +			 <PIN_PC3__SPI1_MISO>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_mikrobus1_pwm: mikrobus1_pwm {
> +		pinmux = <PIN_PA31__PWML0>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_mikrobus1_int: mikrobus1_int {
> +		pinmux = <PIN_PB2__GPIO>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_mikrobus1_uart: mikrobus1_uart {
> +		pinmux = <PIN_PB3__URXD4>,
> +			 <PIN_PB4__UTXD4>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_mikrobus2_an: mikrobus2_an {
> +		pinmux = <PIN_PD26__GPIO>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_mikrobus2_rst: mikrobus2_rst {
> +		pinmux = <PIN_PA16__GPIO>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_mikrobus2_spi_cs: mikrobus2_spi_cs {
> +		pinmux = <PIN_PC5__SPI1_NPCS1>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_mikrobus2_spi: mikrobus2_spi {
> +		pinmux = <PIN_PC1__SPI1_SPCK>,
> +			 <PIN_PC2__SPI1_MOSI>,
> +			 <PIN_PC3__SPI1_MISO>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_mikrobus2_pwm: mikrobus2_pwm {
> +		pinmux = <PIN_PB0__PWMH1>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_mikrobus2_int: mikrobus2_int {
> +		pinmux = <PIN_PB1__GPIO>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_mikrobus2_uart: mikrobus2_uart {
> +		pinmux = <PIN_PB11__URXD3>,
> +			 <PIN_PB12__UTXD3>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_usb_default: usb_default {
> +		pinmux = <PIN_PA6__GPIO>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_usba_vbus: usba_vbus {
> +		pinmux = <PIN_PB13__GPIO>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_macb0_default: macb0_default {
> +		pinmux = <PIN_PB14__GTXCK>,
> +			 <PIN_PB15__GTXEN>,
> +			 <PIN_PB16__GRXDV>,
> +			 <PIN_PB17__GRXER>,
> +			 <PIN_PB18__GRX0>,
> +			 <PIN_PB19__GRX1>,
> +			 <PIN_PB20__GTX0>,
> +			 <PIN_PB21__GTX1>,
> +			 <PIN_PB22__GMDC>,
> +			 <PIN_PB23__GMDIO>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_macb0_phy_irq: macb0_phy_irq {
> +		pinmux = <PIN_PB24__GPIO>;
> +		bias-disable;
> +	};
> +
> +	pinctrl_flx1_default: flx1_default {
> +		pinmux = <PIN_PA24__FLEXCOM1_IO0>,
> +			 <PIN_PA23__FLEXCOM1_IO1>,
> +			 <PIN_PA25__FLEXCOM1_IO3>,
> +			 <PIN_PA26__FLEXCOM1_IO4>;
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
> +	vmmc-supply = <&vdd_3v3>;
> +	vqmmc-supply = <&vdd_1v8>;
> +	status = "okay";
> +};
> +
> +&sdmmc1 {
> +	bus-width = <4>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sdmmc1_default>;
> +	vqmmc-supply = <&vdd_3v3>;
> +	vmmc-supply = <&vdd_3v3>;
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
> +	pinctrl-0 = <&pinctrl_spi1_default &pinctrl_spi1_cs>;
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
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usb_default>;
> +	status = "okay";
> +};
> +
> +&watchdog {
> +	status = "okay";
> +};
