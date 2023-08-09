Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B07775366
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjHIHCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjHIHCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:02:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A392C1BCF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:02:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-269304c135aso3230058a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 00:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1691564522; x=1692169322;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oA4Y4YVJk393hhh41gsTxcc/kNbbX/n08U98oNmh4/w=;
        b=hZ/72Sv75WYBkFU1n2H+ug8kvhWmdwucgKI4Hmadno8B5LfsJ7dn9ObXfcwz4Fkk+Q
         fYBDABKRxpSjcPE9PVLt8pJqP1OKPSE1050SpHdv/h2qLni7QWjnBCujCWS5/3wifvAx
         E0tISjHn5ijK3CCVy0QGAAHFbqAEfDsoDZ9Oz++vFCSS0MMMWxTJnJwz7TSadbBvwtCJ
         FCVvqcdNIonx8Anp+xXwZK5MnRb/eigUrrAjOEl0/1lTsITyd8QbsR6/agcCojI48z8F
         BcQNQJeCprAqD5TmGv7yHUV1zIs+sv74Z9NBxqm5JxdgBTRgHw3c6ALqlgFLokt4S+Po
         N2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691564522; x=1692169322;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oA4Y4YVJk393hhh41gsTxcc/kNbbX/n08U98oNmh4/w=;
        b=YW8p7vJ/Uy38keKZoI1QyrXv3xHBEQ3CEzZGY+fD0fkqdJM2DR21p3gM9sy7PTDT/c
         jBUFuZhzudVgj+J+LrOVxr6EMfJzURda6zj7wdEYMffoYltl6LGGp620bE2JdxfHEXqk
         /XZ5h0e4wH0K1mnzJBx+HRtBkLIsioEpMfHWnfP9fblaVVK6BVltUvQNbSAjDDLYut4f
         oH5k25bqQqbHlps1+Pg7v7GAUbJmzcacK6HoEFFFe1ZSIDmNJske4jJgq65qsqEMIpKu
         3t6PDE8mLnAm2nqEqpjSkmO3/B/aGd3KU3y3MLJVMFKz/jDbtXlk+Tfj3AEBDNpSj6RD
         4/3w==
X-Gm-Message-State: AOJu0YyFtBRfzeXXHT+8Cp/D8J5UNSd2tcaY+8HSNj5bPXp5hRFPnUIt
        pyE/A30c2jcCRFE3ix7+TuiqzUdPUfZKjQmXHQdVo9d7
X-Google-Smtp-Source: AGHT+IHDc6TJVpz+CoOm0i5o93QoNx0hWbKOeM6hYi2/LTLG2MvOxXdCzJdvcy51etkgA9aRu+Y9Ww==
X-Received: by 2002:a17:90a:ec0c:b0:268:1f0a:9f12 with SMTP id l12-20020a17090aec0c00b002681f0a9f12mr1436168pjy.29.1691564522040;
        Wed, 09 Aug 2023 00:02:02 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id gq9-20020a17090b104900b002694da8a9cdsm669814pjb.48.2023.08.09.00.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 00:02:01 -0700 (PDT)
Message-ID: <91a5c6e5-eff1-0fcd-32fe-71a081f4e1f6@tuxon.dev>
Date:   Wed, 9 Aug 2023 10:01:48 +0300
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mihai Sain - M19926 <Mihai.Sain@microchip.com>
References: <20230728103114.267845-1-varshini.rajendran@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230728103114.267845-1-varshini.rajendran@microchip.com>
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

Mihai reported that having '-' in node name for this PMIC driver leads to
failures on probe. Can you also check on your side?

> +					regulator-name = "VDD_IO";
> +					regulator-min-microvolt = <3000000>;
