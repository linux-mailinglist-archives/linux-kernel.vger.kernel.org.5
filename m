Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE686766C40
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjG1L6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjG1L6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:58:46 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF641EC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:58:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe0bd28090so4598865e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690545523; x=1691150323;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Cfxs3q4Jsb2k+V2yEhb2RPY8PN/EYtMoa8StDuPXsY=;
        b=oEb9hoG6YlRX0+AEgL9LG8ZsDo4ATPzKZCmmjll4m/ynaUvp0dmxoYrD4tFWln3xV6
         w718NbPkrAmqRlHe2Iy1nDMZwm6shmZrJtBDbu9Z4Mbqi/GKtkdbmepBOC5OxFASKfdf
         esoLo97NoNWOQsszmQXfQcLRQEoZFxSuWq3/F6kFDWtxbH90LLgR+3xqrRi6zw7s7FzE
         Vyi11Z4jcnJN1VV6IMpW+3YugYgDkO7YvRSe2h3fZBdmG742OAc/3n8TGiElTj5GQDaT
         1pbZ0AIfPPAUyqgW/zBIbxy0hnrLtbPjoU8ekddY/Fz1BC+iLE8uU9qr8dT1tRS8zhr/
         aQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690545523; x=1691150323;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Cfxs3q4Jsb2k+V2yEhb2RPY8PN/EYtMoa8StDuPXsY=;
        b=L+BOmqjbFtrkzGSOraSYQznOGtWrCwssz75y0LNQjnY7Hr1uzhf6YIXF0kDjovAn6y
         o4oyaGzfNWkgAROGEyY5A9wOoJkLA1bqW+7HotRlIYwXzZZJM1ySk6KtboxkUmEzNoL9
         HQ8kZ6lU8Zf+/g9X6gef4BPBONKLH6IYxIi3TfLqSZeC/hZt5H/JpMfosavzc8YqKU7d
         +iDDq6YYOD2uUFMS2XKJgIyX9tUghB8wKPRz4xznCYPqg8MHHNMgh9rmQNmakRnkAt10
         PMawQo+tblMUhk6YTmBVTl5yOXupGYYQ6+L25fiKEKBuAinvdFW+nb2MovURtTByErU9
         MjWw==
X-Gm-Message-State: ABy/qLYUAK3McVUAJzho/d9OZshDRD7N3M49ZQZYdy/5OCMH4V02e4m5
        3/qJ81U3Ge1sAYwhAiM7aZY4AQ==
X-Google-Smtp-Source: APBJJlH1YlQetl0fvclMMTFBCnaKl5V9RNnW0klov9R3IGbcYHc4yu+VblonwfVcKn/jMDBneyz+3g==
X-Received: by 2002:a05:600c:229a:b0:3fa:e92e:7a8b with SMTP id 26-20020a05600c229a00b003fae92e7a8bmr1490371wmf.13.1690545523264;
        Fri, 28 Jul 2023 04:58:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c240900b003fa98908014sm6850010wmp.8.2023.07.28.04.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 04:58:42 -0700 (PDT)
Message-ID: <c153c97c-b51f-3090-6746-e5db662625ea@linaro.org>
Date:   Fri, 28 Jul 2023 13:58:40 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728103114.267845-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 12:31, Varshini Rajendran wrote:
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

You should override/extend nodes by label/phandle. Doing by full node
path is error prone and make it more difficult to make changes to DTSI
later.

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

Use function and color instead.

> +			gpios = <&pioC 19 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-1 {
> +			label = "green";

Use function and color instead.

> +			gpios = <&pioC 21 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-2 {
> +			label = "blue";

Use function and color instead.

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

This is just broken. Not tested, either.


> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_flx6_default>;
> +		i2c-analog-filter;
> +		i2c-digital-filter;
> +		i2c-digital-filter-width-ns = <35>;
> +		status = "okay";
> +

Best regards,
Krzysztof

