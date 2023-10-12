Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4CF7C7727
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442407AbjJLTqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442211AbjJLTqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:46:34 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447EEC9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:46:30 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53b8f8c6b1fso2433027a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697139989; x=1697744789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uHp2HyFyIACh9AUMdrCHbVsPMTR5JIc6soTa/K95gFo=;
        b=S/5RymodQMZvVQz/Q63pcalw2QT2aq3raPLfeDJTHlriAfemKZpeZpxMH/kCtPFfXk
         dRMWcTLqd18tNi/aVOW5NL9VCkjWuHpqwhGJF+I/OHumQWn8LgXsdye5/IDZMl4kOMTQ
         TDNEd6Smyb4bJPPBStUhFdD0QM+kqHMSExyteDSDkdDIIl5Im/Rdn0xYisi1psdfLl4T
         njPYaKjECJRbJ5G9W78xn18RnbWNNcwOUJZDe4yp0fUS/TbLPHwEfzqLvqn6ArvFC9x2
         kF40z3iomF9Hx69qDtGlY2Wnay8oi82fuO7Jz0Lwnwvf1VUk3muJb+nLRANK2Yexbme3
         5rOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697139989; x=1697744789;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHp2HyFyIACh9AUMdrCHbVsPMTR5JIc6soTa/K95gFo=;
        b=X66wt6Gwn2Vw/5MD/8Kfjvkg7bPievXFOPwL6c8hy7e8yYSEfVgUlK5+PRUQs5hCNe
         ECOAn0imv1miPpHbPuyaGyuSzr9x1gvL0k8lVXjQQSgWYjv2d4q95p9YkIXSFN5cWUEg
         4Jt0E6en3g5lzzaw+kPQcDyBTq/QDnJ764MOddBWGEZKzgnANS6yiuXXZGUh7zp9u3+T
         4MU1F+XcKyrpreB1X3LxAnIZCLpbza2HYZ7mir3/mHyf0mDYJiRcxYhCOczoC6CY6LFb
         CogHptCTmbYq7a/Sz2SvfX5JqEYPGoQptfNXCrSfYR40rNt2b9QZK8owxKzSLiQwDxUG
         C2pw==
X-Gm-Message-State: AOJu0YwrgstAB/xGd2RKYr005nXmFYxgMhUtk0tKT+zuNDooYEl6vmUb
        KoMGSbtEDHbH/jlnCnqW72FX9Q==
X-Google-Smtp-Source: AGHT+IGkrEBbAvIzP6NzEJJgG63/roPsaqq6/ep8CP9AIKGO/GgPquqUMDxQnj2j9ZSWCE3Iuh+uHA==
X-Received: by 2002:aa7:de16:0:b0:52c:9f89:4445 with SMTP id h22-20020aa7de16000000b0052c9f894445mr20243514edv.21.1697139989463;
        Thu, 12 Oct 2023 12:46:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id n10-20020aa7c78a000000b00535204ffdb4sm10559842eds.72.2023.10.12.12.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 12:46:28 -0700 (PDT)
Message-ID: <9a831a6e-ab5e-4911-8011-f6eb82dd3d6a@linaro.org>
Date:   Thu, 12 Oct 2023 21:46:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: nuvoton: Add pinctrl support for ma35d1
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20231011090510.114476-1-ychuang570808@gmail.com>
 <20231011090510.114476-4-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231011090510.114476-4-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2023 11:05, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add 'pinctrl' node and 'gpioa' ~ 'gpion' nodes to the dtsi of ma35d1
> SoC and describe default pin configurations.
> 
> Enable all UART nodes presented on som and iot boards, and add pinctrl
> function settings to these nodes.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  83 ++++++++-
>  .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  86 ++++++++-
>  arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 175 +++++++++++++++++-
>  3 files changed, 335 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
> index b89e2be6abae..ff0d2bf8f5bf 100644
> --- a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
> @@ -14,6 +14,10 @@ / {
>  
>  	aliases {
>  		serial0 = &uart0;
> +		serial10 = &uart10;
> +		serial12 = &uart12;
> +		serial13 = &uart13;
> +		serial14 = &uart14;
>  	};
>  
>  	chosen {
> @@ -33,10 +37,6 @@ clk_hxt: clock-hxt {
>  	};
>  };
>  
> -&uart0 {
> -	status = "okay";
> -};
> -
>  &clk {
>  	assigned-clocks = <&clk CAPLL>,
>  			  <&clk DDRPLL>,
> @@ -54,3 +54,78 @@ &clk {
>  			   "integer",
>  			   "integer";
>  };
> +
> +&pinctrl {
> +	uart0 {
> +		pinctrl_uart0: uart0grp {
> +			nuvoton,pins =
> +				<MA35_SYS_REG_GPE_H 24 1 &pcfg_default>,
> +				<MA35_SYS_REG_GPE_H 28 1 &pcfg_default>;
> +		};
> +	};
> +
> +	uart10 {
> +		pinctrl_uart10: uart10grp {
> +			nuvoton,pins =
> +				<MA35_SYS_REG_GPH_L 16 2 &pcfg_default>,
> +				<MA35_SYS_REG_GPH_L 20 2 &pcfg_default>,
> +				<MA35_SYS_REG_GPH_L 24 2 &pcfg_default>,
> +				<MA35_SYS_REG_GPH_L 28 2 &pcfg_default>;
> +		};
> +	};
> +
> +	uart12 {
> +		pinctrl_uart12: uart12grp {
> +			nuvoton,pins =
> +				<MA35_SYS_REG_GPC_H 20 2 &pcfg_default>,
> +				<MA35_SYS_REG_GPC_H 24 2 &pcfg_default>,
> +				<MA35_SYS_REG_GPC_H 28 2 &pcfg_default>;
> +		};
> +	};
> +
> +	uart13 {
> +		pinctrl_uart13: uart13grp {
> +			nuvoton,pins =
> +				<MA35_SYS_REG_GPH_H 16 3 &pcfg_default>,
> +				<MA35_SYS_REG_GPH_H 20 3 &pcfg_default>;
> +		};
> +	};
> +
> +	uart14 {
> +		pinctrl_uart14: uart14grp {
> +			nuvoton,pins =
> +				<MA35_SYS_REG_GPH_H 24 2 &pcfg_default>,
> +				<MA35_SYS_REG_GPH_H 28 2 &pcfg_default>;
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart0>;
> +	status = "okay";
> +};
> +
> +&uart10 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart10>;
> +	status = "okay";
> +};
> +
> +&uart12 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart12>;
> +	status = "okay";
> +};
> +
> +&uart13 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart13>;
> +	status = "okay";
> +};
> +
> +&uart14 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart14>;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
> index a1ebddecb7f8..c8c26f37116b 100644
> --- a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
> @@ -14,6 +14,10 @@ / {
>  
>  	aliases {
>  		serial0 = &uart0;
> +		serial11 = &uart11;
> +		serial12 = &uart12;
> +		serial14 = &uart14;
> +		serial16 = &uart16;
>  	};
>  
>  	chosen {
> @@ -33,10 +37,6 @@ clk_hxt: clock-hxt {
>  	};
>  };
>  
> -&uart0 {
> -	status = "okay";
> -};
> -
>  &clk {
>  	assigned-clocks = <&clk CAPLL>,
>  			  <&clk DDRPLL>,
> @@ -54,3 +54,81 @@ &clk {
>  			   "integer",
>  			   "integer";
>  };
> +
> +&pinctrl {
> +	uart0 {
> +		pinctrl_uart0: uart0grp {
> +			nuvoton,pins =
> +				<MA35_SYS_REG_GPE_H 24 1 &pcfg_default>,
> +				<MA35_SYS_REG_GPE_H 28 1 &pcfg_default>;

This does not look like generic pinctrl bindings. Looks
over-complicated. From where did you get it? Which recent bindings and
drivers where used as an example? Register addresses should be in the
driver. Bit offsets as well. "multi-pin-function-value" confuses me. All
this is not really suitable for DTS.

> +		};
> +	};
> +
> +	uart11 {
> +		pinctrl_uart11: uart11grp {
> +			nuvoton,pins =
> +				<MA35_SYS_REG_GPL_L 0 2 &pcfg_default>,
> +				<MA35_SYS_REG_GPL_L 4 2 &pcfg_default>,
> +				<MA35_SYS_REG_GPL_L 8 2 &pcfg_default>,
> +				<MA35_SYS_REG_GPL_L 12 2 &pcfg_default>;
> +		};
> +	};
> +
> +	uart12 {
> +		pinctrl_uart12: uart12grp {
> +			nuvoton,pins =
> +				<MA35_SYS_REG_GPI_L 4 2 &pcfg_default>,
> +				<MA35_SYS_REG_GPI_L 8 2 &pcfg_default>,
> +				<MA35_SYS_REG_GPI_L 12 2 &pcfg_default>;
> +		};
> +	};
> +
> +	uart14 {
> +		pinctrl_uart14: uart14grp {
> +			nuvoton,pins =
> +				<MA35_SYS_REG_GPI_L 20 2 &pcfg_default>,
> +				<MA35_SYS_REG_GPI_L 24 2 &pcfg_default>,
> +				<MA35_SYS_REG_GPI_L 28 2 &pcfg_default>;
> +		};
> +	};
> +
> +	uart16 {
> +		pinctrl_uart16: uart16grp {
> +			nuvoton,pins =
> +				<MA35_SYS_REG_GPK_L 0 2 &pcfg_default>,
> +				<MA35_SYS_REG_GPK_L 4 2 &pcfg_default>,
> +				<MA35_SYS_REG_GPK_L 8 2 &pcfg_default>,
> +				<MA35_SYS_REG_GPK_L 12 2 &pcfg_default>;
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart0>;
> +	status = "okay";
> +};
> +
> +&uart11 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart11>;
> +	status = "okay";
> +};
> +
> +&uart12 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart12>;
> +	status = "okay";
> +};
> +
> +&uart14 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart14>;
> +	status = "okay";
> +};
> +
> +&uart16 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart16>;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
> index 781cdae566a0..85431a074ab2 100644
> --- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>  #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
> +#include <dt-bindings/pinctrl/ma35d1-pinfunc.h>
>  
>  / {
>  	compatible = "nuvoton,ma35d1";
> @@ -83,7 +84,7 @@ soc {
>  		ranges;
>  
>  		sys: system-management@40460000 {
> -			compatible = "nuvoton,ma35d1-reset";
> +			compatible = "nuvoton,ma35d1-reset", "syscon";
>  			reg = <0x0 0x40460000 0x0 0x200>;
>  			#reset-cells = <1>;
>  		};
> @@ -95,6 +96,178 @@ clk: clock-controller@40460200 {
>  			clocks = <&clk_hxt>;
>  		};
>  
> +		pinctrl: pinctrl@40040000 {
> +			compatible = "nuvoton,ma35d1-pinctrl";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			nuvoton,sys = <&sys>;
> +			ranges = <0x0 0x0 0x40040000 0xc00>;
> +
> +			gpioa: gpioa@40040000 {
> +				reg = <0x0 0x40>;
> +				interrupts = <GIC_SPI  14 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk GPA_GATE>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpiob: gpiob@40040040 {
> +				reg = <0x40 0x40>;
> +				interrupts = <GIC_SPI  15 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk GPB_GATE>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpioc: gpioc@40040080 {
> +				reg = <0x80 0x40>;
> +				interrupts = <GIC_SPI  16 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk GPC_GATE>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpiod: gpiod@400400c0 {
> +				reg = <0xc0 0x40>;
> +				interrupts = <GIC_SPI  17 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk GPD_GATE>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpioe: gpioe@40040100 {
> +				reg = <0x100 0x40>;
> +				interrupts = <GIC_SPI  73 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk GPE_GATE>;
> +				#gpio-cells = <2>;
> +				gpio-controller;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpiof: gpiof@40040140 {
> +				reg = <0x140 0x40>;
> +				interrupts = <GIC_SPI  74 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk GPF_GATE>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpiog: gpiog@40040180 {
> +				reg = <0x180 0x40>;
> +				interrupts = <GIC_SPI  75 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk GPG_GATE>;
> +				#gpio-cells = <2>;
> +				gpio-controller;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpioh: gpioh@400401c0 {
> +				reg = <0x1c0 0x40>;
> +				interrupts = <GIC_SPI  76 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk GPH_GATE>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpioi: gpioi@40040200 {
> +				reg = <0x200 0x40>;
> +				interrupts = <GIC_SPI  77 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk GPI_GATE>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpioj: gpioj@40040240 {
> +				reg = <0x240 0x40>;
> +				interrupts = <GIC_SPI  78 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk GPJ_GATE>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpiok: gpiok@40040280 {
> +				reg = <0x280 0x40>;
> +				interrupts = <GIC_SPI  102 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk GPK_GATE>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpiol: gpiol@400402c0 {
> +				reg = <0x2c0 0x40>;
> +				interrupts = <GIC_SPI  103 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk GPL_GATE>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpiom: gpiom@40040300 {
> +				reg = <0x300 0x40>;
> +				interrupts = <GIC_SPI  104 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk GPM_GATE>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			gpion: gpion@40040340 {
> +				reg = <0x340 0x40>;
> +				interrupts = <GIC_SPI  105 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk GPN_GATE>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			pcfg_default: pcfg-default {
> +				slew-rate = <0>;
> +				input-schmitt-disable;
> +				bias-disable;
> +				power-source = <3300>;
> +				drive-strength = <0>;
> +			};
> +
> +			pcfg_emac_3_3v: pcfg-emac-3.3v {

Drop, unused.

> +				slew-rate = <0>;
> +				input-schmitt-enable;
> +				bias-disable;
> +				power-source = <3300>;
> +				drive-strength = <1>;
> +			};
> +
> +			pcfg_emac_1_8v: pcfg-emac-1.8v {

Drop, unused.

> +				slew-rate = <0>;
> +				input-schmitt-enable;
> +				bias-disable;
> +				power-source = <1800>;
> +				drive-strength = <1>;
> +			};
> +		};
> +
>  		uart0: serial@40700000 {
>  			compatible = "nuvoton,ma35d1-uart";
>  			reg = <0x0 0x40700000 0x0 0x100>;

Best regards,
Krzysztof

