Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965277A33EE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 08:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbjIQGEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 02:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjIQGED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 02:04:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1D8185
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 23:03:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32001d16a14so778906f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 23:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694930635; x=1695535435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6kNd1On9Iu+U+6wDKZBy98BmzT+uqpRHNYsTIMU9dqo=;
        b=ZXdFapJcjgrSne1n3zpppUt2TTCIVXC/UeFdQcmhgbCwX1UqfCtxRnEfpMkG8/BQNQ
         CosleZ7Msp6+0gB4fRdMAKljnyYROShi/Mwhg1xP/SzFoFTJAcBG8vVa3MmN68aIKaJx
         rk5qU6oSaSlIz3QWJWlm8F5Yd2zuyki0oRMIZWO67LylWLBKDAv4xTl+xXlkpVFp1Gz6
         R1DdkB35iBWQWvor+azLo/ZnlU62WmdsCE/wmIMB401HD0WJxyuHMiG1P7zhVQ1JlUAw
         qJM531owYNOMBQPm/RKOcCrqQ0HpmZDZAxx6VOEoiwdNrWcGG6cbqZx3dZNmr9Y1uMFE
         eM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694930635; x=1695535435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kNd1On9Iu+U+6wDKZBy98BmzT+uqpRHNYsTIMU9dqo=;
        b=ZSkJoX6Te9E/9gSyoDDNYTxIDVn/fSso6AZpzSAzSiex1q42CFWEwPFQT5oejkunxb
         stv7EP1FgqFq92GSQ664XS2CvgT5FpTt1lNffUMGR+KXz3xaAkyzACLc/c8IPEahTPU5
         UQA11OwVDa5f9evtCJmkW3e5vTq/GpU/8oDzoemx1jLkSvlAhWf5Mwkd7osB7Pbmwnnx
         0NRcmRZPhwPpLwRfKsb7Gri9kCr2Cmw2zhDfRhwdk5aWw6D9MbEIai8iH/6QKK+UNg49
         /OXqKbvewjQkm/FRGwACO9StnQiiDT8nOYjCnxdiia5193IH4H+n957TWSdemSXxTZvz
         uuVQ==
X-Gm-Message-State: AOJu0Yx6FNGAhUzbAAIn7t672yWEnKlCw2vqLFyaovQtOSWy5svTAow+
        zg3XybGsBvPhOeLy9EhaMgkxOA==
X-Google-Smtp-Source: AGHT+IGgQCPDrEkd95eNwGWv1/ntTr/QvYlONlPNSyWw9veRdSU7GnER8u9uhg8zbKtCQwYPgnlxFg==
X-Received: by 2002:adf:f8c5:0:b0:31f:87f2:2155 with SMTP id f5-20020adff8c5000000b0031f87f22155mr4853991wrq.26.1694930635389;
        Sat, 16 Sep 2023 23:03:55 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id s17-20020a5d5111000000b0032148618cc4sm417842wrt.29.2023.09.16.23.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 23:03:54 -0700 (PDT)
Message-ID: <6c3c8585-8f6d-384a-9a27-c0f851016135@tuxon.dev>
Date:   Sun, 17 Sep 2023 09:03:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] ARM: dts: at91: sama5d29_curiosity: Add device tree
 for sama5d29_curiosity board
To:     Mihai Sain <mihai.sain@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, cristian.birsan@microchip.com,
        alexandre.belloni@bootlin.com, andre.przywara@arm.com,
        jerry.ray@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     andrei.simion@microchip.com
References: <20230817131352.17631-1-mihai.sain@microchip.com>
Content-Language: en-US
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230817131352.17631-1-mihai.sain@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mihai,

On 17.08.2023 16:13, Mihai Sain wrote:
> Add initial device tree file for sama5d29_curiosity board.
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> ---

I would apply this but there are some warnings like:

/home/claudiu/repos/linux-microchip/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dtb:
leds: 'blue', 'green', 'red' do not match any of the regexes:
'(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

/home/claudiu/repos/linux-microchip/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dtb:
pinctrl@fc038000: i2c0-gpio: {'pinmux': [[63, 64]], 'bias-disable': True,
'phandle': [[23]]} is not of type 'array'
        from schema $id:
http://devicetree.org/schemas/gpio/gpio-consumer.yaml#
/home/claudiu/repos/linux-microchip/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dtb:
pinctrl@fc038000: i2c1-gpio: {'pinmux': [[100, 101]], 'bias-disable': True,
'phandle': [[36]]} is not of type 'array'

Can you, please, run make dtbs_check arch/arm/boot/dts/microchip and fix
the warnings introduced by your dts (not the ones comming from dtsi at the
moment)?

Thank you,
Claudiu Beznea

> Changes in v3:
> * remove i2s0 node and its pinctrl
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
> ---
>  arch/arm/boot/dts/microchip/Makefile          |   2 +
>  .../dts/microchip/at91-sama5d29_curiosity.dts | 600 ++++++++++++++++++
>  2 files changed, 602 insertions(+)
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
> index 000000000000..267e1dbb417d
> --- /dev/null
> +++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
> @@ -0,0 +1,600 @@
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
> +	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> +	i2c-analog-filter;
> +	i2c-digital-filter;
> +	i2c-digital-filter-width-ns = <35>;
> +	sda-gpios = <&pioA PIN_PD4 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&pioA PIN_PD5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	status = "okay";
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
