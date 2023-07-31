Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59A77690CA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjGaIv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjGaIvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:51:00 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30DF2D52
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:48:03 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe12820bffso19104675e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690793279; x=1691398079;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hyd4ReqeWeU/rILMco8wFalj1QG9zWXdvj1Ok9YyiWc=;
        b=LDcImLish2bLuvYGLJWqNlRppWHw8f3XsBX+3BL+7I1FQH2sdrCJFJ9Bwe9KOCpNNP
         XtCmOl2iPgu+qqJpj2Nqh588Btzw7hVotiZtHWQiNKlZlm4s9OUBElrxbczxU4C5980n
         xV0+cHWc7B03AQdJMrrVukwkYxpQ6Ao2XMRjUw4lSReKdght9FI1wipl7ofS+9ctJ9tz
         bbjLekctPLEhOK87pfBV0QIfn39EytSLcl8DZ+76NgN5H9eAI4RENLn6Hq27i1CmQ4Db
         Y3EJVXtcR8jrikAsAUAZm4JVQOuCH36xE9qrwnydm6ztiBJDKLffKhUZAR7i0bUpMrxW
         YuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690793279; x=1691398079;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hyd4ReqeWeU/rILMco8wFalj1QG9zWXdvj1Ok9YyiWc=;
        b=Tm/jNilkVwl1Bnu8VlTEAmOHOwX/O1j8LeEACxsjvijZ8qNJ9WIAD35j0QQu8028k7
         fQ95eWyxpctMUO2rFjpw12E9Mhqk/IXhANWOijwASUnUKIXZ22J4knwQi4Us5bJL3V7N
         cKpYQaICekPeVC+9jUZe2CExupiS4QCkmxhIHyYzKA7mN87PKs1rdBvyQJaIYD9QEynU
         kqPKl/vPR+0Bv/5Dgd/VGZjL5prtqysACTpYx/PxExykOWwiTZY559TyNdxftwMRF1vZ
         aXD9YsAVAbdO5PmmsC+3mK7b25HC9vrcvfDQYDA+jwld7mJpsw7t97KBeDW0ZzMampHH
         98PA==
X-Gm-Message-State: ABy/qLY7ZYC1UA08KTS6DPiIQh0DweHh2O+o/1ZV+0D1z/fKYaThgFKm
        5enuKvRZinrs/IooZxG39W5T5w==
X-Google-Smtp-Source: APBJJlGiY8uI6mK248/4fXP+CJ8WI/2WVg1zhROG/gZhB2lmjqbumZSYmvnqjYSZCTzF7hJ86raB3w==
X-Received: by 2002:a7b:c7d9:0:b0:3fe:2186:e9ad with SMTP id z25-20020a7bc7d9000000b003fe2186e9admr1066752wmk.6.1690793279158;
        Mon, 31 Jul 2023 01:47:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d? ([2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d])
        by smtp.gmail.com with ESMTPSA id e5-20020a5d5005000000b00311d8c2561bsm12268111wrt.60.2023.07.31.01.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 01:47:58 -0700 (PDT)
Message-ID: <1cc36fa4-28b9-3bdc-e6b3-e78d3198f67b@linaro.org>
Date:   Mon, 31 Jul 2023 10:47:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V2 3/3] arm64: dts: Replace the IRQ number with the IRQID
 macro definition
Content-Language: en-US
To:     Huqiang Qin <huqiang.qin@amlogic.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20230724060108.1403662-1-huqiang.qin@amlogic.com>
 <20230724060108.1403662-4-huqiang.qin@amlogic.com>
Organization: Linaro Developer Services
In-Reply-To: <20230724060108.1403662-4-huqiang.qin@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 08:01, Huqiang Qin wrote:
> Replacing IRQ numbers with IRQID macro definitions makes node properties
> easier to understand and also makes GPIO interrupts easier to use.
> 
> Associated platforms:
> - Amlogic Meson-G12A
> - Amlogic Meson-G12B
> - Amlogic Meson-SM1
> 
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
> ---
> 
> V1 -> V2: Include header file changed to amlogic,meson-g12a-gpio-intc.h
> 
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi    |  1 +
>   arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts   |  2 +-
>   .../boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi    |  2 +-
>   arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi |  2 +-
>   .../boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts  |  4 ++--
>   .../arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi |  2 +-
>   arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi     |  2 +-
>   .../boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts   |  2 +-
>   arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi  |  4 ++--
>   arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts    |  2 +-
>   arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi    |  2 +-
>   arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts     | 12 ++++++------
>   .../boot/dts/amlogic/meson-sm1-x96-air-gbit.dts      |  2 +-
>   13 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index 0c49655cc90c..d8b94a3167c3 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -9,6 +9,7 @@
>   #include <dt-bindings/clock/g12a-aoclkc.h>
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/amlogic,meson-g12a-gpio-intc.h>
>   #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
>   #include <dt-bindings/thermal/thermal.h>
>   
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> index b2bb94981838..c79f3e8d26b7 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> @@ -344,7 +344,7 @@ external_phy: ethernet-phy@0 {
>   
>   		interrupt-parent = <&gpio_intc>;
>   		/* MAC_INTR on GPIOZ_14 */
> -		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
>   	};
>   };
>   
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
> index 97e522921b06..428b35e1d79c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
> @@ -201,7 +201,7 @@ external_phy: ethernet-phy@0 {
>   
>   		interrupt-parent = <&gpio_intc>;
>   		/* MAC_INTR on GPIOZ_14 */
> -		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
>   	};
>   };
>   
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
> index 83709787eb91..c69b0f803916 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
> @@ -327,7 +327,7 @@ external_phy: ethernet-phy@0 {
>   
>   		interrupt-parent = <&gpio_intc>;
>   		/* MAC_INTR on GPIOZ_14 */
> -		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
>   	};
>   };
>   
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
> index 276e95b34022..eed2a23047ca 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
> @@ -380,7 +380,7 @@ rk818: pmic@1c {
>   		compatible = "rockchip,rk818";
>   		reg = <0x1c>;
>   		interrupt-parent = <&gpio_intc>;
> -		interrupts = <7 IRQ_TYPE_LEVEL_LOW>; /* GPIOAO_7 */
> +		interrupts = <IRQID_GPIOAO_7 IRQ_TYPE_LEVEL_LOW>; /* GPIOAO_7 */
>   		#clock-cells = <1>;
>   
>   		vcc1-supply = <&vdd_sys>;
> @@ -519,7 +519,7 @@ rk817: pmic@20 {
>   		reg = <0x20>;
>   		interrupt-parent = <&gpio_intc>;
>   
> -		interrupts = <5 IRQ_TYPE_LEVEL_LOW>; /* GPIOAO_5 */
> +		interrupts = <IRQID_GPIOAO_5 IRQ_TYPE_LEVEL_LOW>; /* GPIOAO_5 */
>   
>   		vcc1-supply = <&vdd_sys>;
>   		vcc2-supply = <&vdd_sys>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> index 24d0442dffb2..01aa970b2f8c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
> @@ -185,7 +185,7 @@ external_phy: ethernet-phy@0 {
>   
>   		interrupt-parent = <&gpio_intc>;
>   		/* MAC_INTR on GPIOZ_14 */
> -		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
>   	};
>   };
>   
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
> index b40d2c1002c9..ac8b7178257e 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
> @@ -269,7 +269,7 @@ external_phy: ethernet-phy@0 {
>   
>   		interrupt-parent = <&gpio_intc>;
>   		/* MAC_INTR on GPIOZ_14 */
> -		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
>   	};
>   };
>   
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts
> index d1debccdc1c2..95e03bb02af2 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts
> @@ -100,7 +100,7 @@ external_phy: ethernet-phy@0 {
>   
>   		interrupt-parent = <&gpio_intc>;
>   		/* MAC_INTR on GPIOZ_14 */
> -		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
>   	};
>   };
>   
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi
> index 17045ff81c69..62404743e62d 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi
> @@ -45,7 +45,7 @@ key {
>   			linux,code = <BTN_1>;
>   			gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_LOW>;
>   			interrupt-parent = <&gpio_intc>;
> -			interrupts = <3 IRQ_TYPE_EDGE_BOTH>;
> +			interrupts = <IRQID_GPIOAO_3 IRQ_TYPE_EDGE_BOTH>;
>   		};
>   	};
>   
> @@ -217,7 +217,7 @@ external_phy: ethernet-phy@0 {
>   
>   		interrupt-parent = <&gpio_intc>;
>   		/* MAC_INTR on GPIOZ_14 */
> -		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
>   	};
>   };
>   
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
> index 0f6660e68e72..ebda1dd30fa6 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
> @@ -100,7 +100,7 @@ external_phy: ethernet-phy@0 {
>   
>   		interrupt-parent = <&gpio_intc>;
>   		/* MAC_INTR on GPIOZ_14 */
> -		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
>   	};
>   };
>   
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> index 2fce44939f45..86b90f44a4b3 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> @@ -283,7 +283,7 @@ external_phy: ethernet-phy@0 {
>   
>   		interrupt-parent = <&gpio_intc>;
>   		/* MAC_INTR on GPIOZ_14 */
> -		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
>   	};
>   };
>   
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
> index 9068a334ea57..4f07d6387bb1 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
> @@ -53,7 +53,7 @@ key-1 {
>   			linux,code = <BTN_0>;
>   			gpios = <&gpio GPIOH_6 GPIO_ACTIVE_LOW>;
>   			interrupt-parent = <&gpio_intc>;
> -			interrupts = <34 IRQ_TYPE_EDGE_BOTH>;
> +			interrupts = <IRQID_GPIOH_6 IRQ_TYPE_EDGE_BOTH>;
>   		};
>   
>   		key-2 {
> @@ -61,7 +61,7 @@ key-2 {
>   			linux,code = <BTN_1>;
>   			gpios = <&gpio GPIOH_7 GPIO_ACTIVE_LOW>;
>   			interrupt-parent = <&gpio_intc>;
> -			interrupts = <35 IRQ_TYPE_EDGE_BOTH>;
> +			interrupts = <IRQID_GPIOH_7 IRQ_TYPE_EDGE_BOTH>;
>   		};
>   
>   		key-3 {
> @@ -69,7 +69,7 @@ key-3 {
>   			linux,code = <BTN_2>;
>   			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;
>   			interrupt-parent = <&gpio_intc>;
> -			interrupts = <2 IRQ_TYPE_EDGE_BOTH>;
> +			interrupts = <IRQID_GPIOAO_2 IRQ_TYPE_EDGE_BOTH>;
>   		};
>   
>   		key-mic-mute {
> @@ -78,7 +78,7 @@ key-mic-mute {
>   			linux,input-type = <EV_SW>;
>   			gpios = <&gpio_ao GPIOE_2 GPIO_ACTIVE_LOW>;
>   			interrupt-parent = <&gpio_intc>;
> -			interrupts = <99 IRQ_TYPE_EDGE_BOTH>;
> +			interrupts = <IRQID_GPIOE_2 IRQ_TYPE_EDGE_BOTH>;
>   		};
>   
>   		key-power {
> @@ -86,7 +86,7 @@ key-power {
>   			linux,code = <KEY_POWER>;
>   			gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_LOW>;
>   			interrupt-parent = <&gpio_intc>;
> -			interrupts = <3 IRQ_TYPE_EDGE_BOTH>;
> +			interrupts = <IRQID_GPIOAO_3 IRQ_TYPE_EDGE_BOTH>;
>   		};
>   	};
>   
> @@ -583,7 +583,7 @@ &uart_A {
>   	bluetooth {
>   		compatible = "brcm,bcm43438-bt";
>   		interrupt-parent = <&gpio_intc>;
> -		interrupts = <95 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupts = <IRQID_GPIOX_18 IRQ_TYPE_LEVEL_HIGH>;
>   		interrupt-names = "host-wakeup";
>   		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
>   		max-speed = <2000000>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
> index 7e1a74046ba5..6ee406066ee0 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
> @@ -100,7 +100,7 @@ external_phy: ethernet-phy@0 {
>   
>   		interrupt-parent = <&gpio_intc>;
>   		/* MAC_INTR on GPIOZ_14 */
> -		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts = <IRQID_GPIOZ_14 IRQ_TYPE_LEVEL_LOW>;
>   	};
>   };
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
