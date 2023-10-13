Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE787C7E24
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjJMGwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjJMGwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:52:20 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044E091;
        Thu, 12 Oct 2023 23:52:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c5c91bec75so13851285ad.3;
        Thu, 12 Oct 2023 23:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697179937; x=1697784737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=khoBcCaNwITaZpOQpB7D85N+chp7AHYJYcUZPAYhZ1I=;
        b=FzbFC/mnUdiykOJhpBrw3HQLKLvPSW1yXVGMVo+t8TeF9Iom0Bn3b0a+RDs+80Bmcb
         BaGS2qY5HH5PPTaOV+EHDvlv6fxM8d1XC/iAhn/+zAlbd2mYzqgxZI8mj/vWU1H+S5i9
         zIo0x1Z8sA3PTmoEJzQMhZrFLAgx7FrYwII27ThnNIqWvLWzhb5G9WPZjgrETNTBHUWL
         R8t4WdqI4sn9sESGQTCfHN4nVV/FPKUc77TcU09WE2gtucGzt0TmSr4qPAElW/4JxY/f
         pNs63Pm5inWkbVCOting0GBnwLCzd+A4FZbcr7H7JZzlwUp/Psa5fsaslMIlExNqCKOx
         zh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697179937; x=1697784737;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=khoBcCaNwITaZpOQpB7D85N+chp7AHYJYcUZPAYhZ1I=;
        b=dbq33dEbCMbboY4FqxDVN42BP5F+lch/aj0PMY0OOegD2vPl9UnFU2jle/j2F+x+lV
         vlq44BPWThdHfx0mjXG9ubSHJf4H129QhlfcEdorBOghvwyyN/3piCmFoS3NJ0wkR78C
         Qh3W1yAhW1CVVORVN5Oz0gsdvQ/vwWuNUKBTarCc4joMCBBzxw+7QkdRmMY41IHdt+18
         ww1u4GSRANoiOJ7Sw7k51bgeUZPXYudnlrkYPpMhIzYsDV9ud6N3u8ZmkcdbZt7jM+KF
         zbrC05dODGKOL8FJNKimfKrvBr1WD6ax35PxXqFyeoDeeVVh3WYbTU8k3yVtQaTjS5bv
         1mEA==
X-Gm-Message-State: AOJu0YzmAkfhLtSnVVlp/iy60wk3/EZdBEfpxi8NmUF/tYWeiSo+Dl+G
        IUodXVWV0S46Z+hT+58nfC4=
X-Google-Smtp-Source: AGHT+IHzPkkB5jU4wBzbdTMpMiYP5Yb8C63JSgCPYhq4Xluyn+t6sIS/2+K9PRYAQkaPcTKjci3Ipg==
X-Received: by 2002:a17:902:fa8f:b0:1c9:d948:33d5 with SMTP id lc15-20020a170902fa8f00b001c9d94833d5mr4406141plb.64.1697179937299;
        Thu, 12 Oct 2023 23:52:17 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902ce8900b001c76fcccee8sm3070210plg.156.2023.10.12.23.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 23:52:16 -0700 (PDT)
Message-ID: <507e491a-e40f-47e2-8e11-5a7886a8c2ab@gmail.com>
Date:   Fri, 13 Oct 2023 14:52:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: nuvoton: Add pinctrl support for ma35d1
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20231011090510.114476-1-ychuang570808@gmail.com>
 <20231011090510.114476-4-ychuang570808@gmail.com>
 <9a831a6e-ab5e-4911-8011-f6eb82dd3d6a@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <9a831a6e-ab5e-4911-8011-f6eb82dd3d6a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Krzysztof,


Thank you for the review.


On 2023/10/13 上午 03:46, Krzysztof Kozlowski wrote:
> On 11/10/2023 11:05, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add 'pinctrl' node and 'gpioa' ~ 'gpion' nodes to the dtsi of ma35d1
>> SoC and describe default pin configurations.
>>
>> Enable all UART nodes presented on som and iot boards, and add pinctrl
>> function settings to these nodes.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  83 ++++++++-
>>   .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  86 ++++++++-
>>   arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 175 +++++++++++++++++-
>>   3 files changed, 335 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
>> index b89e2be6abae..ff0d2bf8f5bf 100644
>> --- a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
>> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
>> @@ -14,6 +14,10 @@ / {
>>   
>>   	aliases {
>>   		serial0 = &uart0;
>> +		serial10 = &uart10;
>> +		serial12 = &uart12;
>> +		serial13 = &uart13;
>> +		serial14 = &uart14;
>>   	};
>>   
>>   	chosen {
>> @@ -33,10 +37,6 @@ clk_hxt: clock-hxt {
>>   	};
>>   };
>>   
>> -&uart0 {
>> -	status = "okay";
>> -};
>> -
>>   &clk {
>>   	assigned-clocks = <&clk CAPLL>,
>>   			  <&clk DDRPLL>,
>> @@ -54,3 +54,78 @@ &clk {
>>   			   "integer",
>>   			   "integer";
>>   };
>> +
>> +&pinctrl {
>> +	uart0 {
>> +		pinctrl_uart0: uart0grp {
>> +			nuvoton,pins =
>> +				<MA35_SYS_REG_GPE_H 24 1 &pcfg_default>,
>> +				<MA35_SYS_REG_GPE_H 28 1 &pcfg_default>;
>> +		};
>> +	};
>> +
>> +	uart10 {
>> +		pinctrl_uart10: uart10grp {
>> +			nuvoton,pins =
>> +				<MA35_SYS_REG_GPH_L 16 2 &pcfg_default>,
>> +				<MA35_SYS_REG_GPH_L 20 2 &pcfg_default>,
>> +				<MA35_SYS_REG_GPH_L 24 2 &pcfg_default>,
>> +				<MA35_SYS_REG_GPH_L 28 2 &pcfg_default>;
>> +		};
>> +	};
>> +
>> +	uart12 {
>> +		pinctrl_uart12: uart12grp {
>> +			nuvoton,pins =
>> +				<MA35_SYS_REG_GPC_H 20 2 &pcfg_default>,
>> +				<MA35_SYS_REG_GPC_H 24 2 &pcfg_default>,
>> +				<MA35_SYS_REG_GPC_H 28 2 &pcfg_default>;
>> +		};
>> +	};
>> +
>> +	uart13 {
>> +		pinctrl_uart13: uart13grp {
>> +			nuvoton,pins =
>> +				<MA35_SYS_REG_GPH_H 16 3 &pcfg_default>,
>> +				<MA35_SYS_REG_GPH_H 20 3 &pcfg_default>;
>> +		};
>> +	};
>> +
>> +	uart14 {
>> +		pinctrl_uart14: uart14grp {
>> +			nuvoton,pins =
>> +				<MA35_SYS_REG_GPH_H 24 2 &pcfg_default>,
>> +				<MA35_SYS_REG_GPH_H 28 2 &pcfg_default>;
>> +		};
>> +	};
>> +};
>> +
>> +&uart0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart0>;
>> +	status = "okay";
>> +};
>> +
>> +&uart10 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart10>;
>> +	status = "okay";
>> +};
>> +
>> +&uart12 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart12>;
>> +	status = "okay";
>> +};
>> +
>> +&uart13 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart13>;
>> +	status = "okay";
>> +};
>> +
>> +&uart14 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart14>;
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
>> index a1ebddecb7f8..c8c26f37116b 100644
>> --- a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
>> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
>> @@ -14,6 +14,10 @@ / {
>>   
>>   	aliases {
>>   		serial0 = &uart0;
>> +		serial11 = &uart11;
>> +		serial12 = &uart12;
>> +		serial14 = &uart14;
>> +		serial16 = &uart16;
>>   	};
>>   
>>   	chosen {
>> @@ -33,10 +37,6 @@ clk_hxt: clock-hxt {
>>   	};
>>   };
>>   
>> -&uart0 {
>> -	status = "okay";
>> -};
>> -
>>   &clk {
>>   	assigned-clocks = <&clk CAPLL>,
>>   			  <&clk DDRPLL>,
>> @@ -54,3 +54,81 @@ &clk {
>>   			   "integer",
>>   			   "integer";
>>   };
>> +
>> +&pinctrl {
>> +	uart0 {
>> +		pinctrl_uart0: uart0grp {
>> +			nuvoton,pins =
>> +				<MA35_SYS_REG_GPE_H 24 1 &pcfg_default>,
>> +				<MA35_SYS_REG_GPE_H 28 1 &pcfg_default>;
> This does not look like generic pinctrl bindings. Looks
> over-complicated. From where did you get it? Which recent bindings and
> drivers where used as an example? Register addresses should be in the
> driver. Bit offsets as well. "multi-pin-function-value" confuses me. All
> this is not really suitable for DTS.

Okay, I will update the first and second items to 'pin bank' and 'pin 
bank index,
just as others have done, and leave the driver to handle the conversion into
registers and offsets.

The term "multi-pin-function-value" is used to specify the device function.
I will use the name "device function" instead of "multi-pin-function-value.

>> +		};
>> +	};
>> +
>> +	uart11 {
>> +		pinctrl_uart11: uart11grp {
>> +			nuvoton,pins =
>> +				<MA35_SYS_REG_GPL_L 0 2 &pcfg_default>,
>> +				<MA35_SYS_REG_GPL_L 4 2 &pcfg_default>,
>> +				<MA35_SYS_REG_GPL_L 8 2 &pcfg_default>,
>> +				<MA35_SYS_REG_GPL_L 12 2 &pcfg_default>;
>> +		};
>> +	};
>> +
>> +	uart12 {
>> +		pinctrl_uart12: uart12grp {
>> +			nuvoton,pins =
>> +				<MA35_SYS_REG_GPI_L 4 2 &pcfg_default>,
>> +				<MA35_SYS_REG_GPI_L 8 2 &pcfg_default>,
>> +				<MA35_SYS_REG_GPI_L 12 2 &pcfg_default>;
>> +		};
>> +	};
>> +
>> +	uart14 {
>> +		pinctrl_uart14: uart14grp {
>> +			nuvoton,pins =
>> +				<MA35_SYS_REG_GPI_L 20 2 &pcfg_default>,
>> +				<MA35_SYS_REG_GPI_L 24 2 &pcfg_default>,
>> +				<MA35_SYS_REG_GPI_L 28 2 &pcfg_default>;
>> +		};
>> +	};
>> +
>> +	uart16 {
>> +		pinctrl_uart16: uart16grp {
>> +			nuvoton,pins =
>> +				<MA35_SYS_REG_GPK_L 0 2 &pcfg_default>,
>> +				<MA35_SYS_REG_GPK_L 4 2 &pcfg_default>,
>> +				<MA35_SYS_REG_GPK_L 8 2 &pcfg_default>,
>> +				<MA35_SYS_REG_GPK_L 12 2 &pcfg_default>;
>> +		};
>> +	};
>> +};
>> +
>> +&uart0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart0>;
>> +	status = "okay";
>> +};
>> +
>> +&uart11 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart11>;
>> +	status = "okay";
>> +};
>> +
>> +&uart12 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart12>;
>> +	status = "okay";
>> +};
>> +
>> +&uart14 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart14>;
>> +	status = "okay";
>> +};
>> +
>> +&uart16 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart16>;
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
>> index 781cdae566a0..85431a074ab2 100644
>> --- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
>> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
>> @@ -10,6 +10,7 @@
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>>   #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
>> +#include <dt-bindings/pinctrl/ma35d1-pinfunc.h>
>>   
>>   / {
>>   	compatible = "nuvoton,ma35d1";
>> @@ -83,7 +84,7 @@ soc {
>>   		ranges;
>>   
>>   		sys: system-management@40460000 {
>> -			compatible = "nuvoton,ma35d1-reset";
>> +			compatible = "nuvoton,ma35d1-reset", "syscon";
>>   			reg = <0x0 0x40460000 0x0 0x200>;
>>   			#reset-cells = <1>;
>>   		};
>> @@ -95,6 +96,178 @@ clk: clock-controller@40460200 {
>>   			clocks = <&clk_hxt>;
>>   		};
>>   
>> +		pinctrl: pinctrl@40040000 {
>> +			compatible = "nuvoton,ma35d1-pinctrl";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			nuvoton,sys = <&sys>;
>> +			ranges = <0x0 0x0 0x40040000 0xc00>;
>> +
>> +			gpioa: gpioa@40040000 {
>> +				reg = <0x0 0x40>;
>> +				interrupts = <GIC_SPI  14 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&clk GPA_GATE>;
>> +				gpio-controller;
>> +				#gpio-cells = <2>;
>> +				interrupt-controller;
>> +				#interrupt-cells = <2>;
>> +			};
>> +
>> +			gpiob: gpiob@40040040 {
>> +				reg = <0x40 0x40>;
>> +				interrupts = <GIC_SPI  15 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&clk GPB_GATE>;
>> +				gpio-controller;
>> +				#gpio-cells = <2>;
>> +				interrupt-controller;
>> +				#interrupt-cells = <2>;
>> +			};
>> +
>> +			gpioc: gpioc@40040080 {
>> +				reg = <0x80 0x40>;
>> +				interrupts = <GIC_SPI  16 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&clk GPC_GATE>;
>> +				gpio-controller;
>> +				#gpio-cells = <2>;
>> +				interrupt-controller;
>> +				#interrupt-cells = <2>;
>> +			};
>> +
>> +			gpiod: gpiod@400400c0 {
>> +				reg = <0xc0 0x40>;
>> +				interrupts = <GIC_SPI  17 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&clk GPD_GATE>;
>> +				gpio-controller;
>> +				#gpio-cells = <2>;
>> +				interrupt-controller;
>> +				#interrupt-cells = <2>;
>> +			};
>> +
>> +			gpioe: gpioe@40040100 {
>> +				reg = <0x100 0x40>;
>> +				interrupts = <GIC_SPI  73 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&clk GPE_GATE>;
>> +				#gpio-cells = <2>;
>> +				gpio-controller;
>> +				interrupt-controller;
>> +				#interrupt-cells = <2>;
>> +			};
>> +
>> +			gpiof: gpiof@40040140 {
>> +				reg = <0x140 0x40>;
>> +				interrupts = <GIC_SPI  74 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&clk GPF_GATE>;
>> +				gpio-controller;
>> +				#gpio-cells = <2>;
>> +				interrupt-controller;
>> +				#interrupt-cells = <2>;
>> +			};
>> +
>> +			gpiog: gpiog@40040180 {
>> +				reg = <0x180 0x40>;
>> +				interrupts = <GIC_SPI  75 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&clk GPG_GATE>;
>> +				#gpio-cells = <2>;
>> +				gpio-controller;
>> +				interrupt-controller;
>> +				#interrupt-cells = <2>;
>> +			};
>> +
>> +			gpioh: gpioh@400401c0 {
>> +				reg = <0x1c0 0x40>;
>> +				interrupts = <GIC_SPI  76 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&clk GPH_GATE>;
>> +				gpio-controller;
>> +				#gpio-cells = <2>;
>> +				interrupt-controller;
>> +				#interrupt-cells = <2>;
>> +			};
>> +
>> +			gpioi: gpioi@40040200 {
>> +				reg = <0x200 0x40>;
>> +				interrupts = <GIC_SPI  77 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&clk GPI_GATE>;
>> +				gpio-controller;
>> +				#gpio-cells = <2>;
>> +				interrupt-controller;
>> +				#interrupt-cells = <2>;
>> +			};
>> +
>> +			gpioj: gpioj@40040240 {
>> +				reg = <0x240 0x40>;
>> +				interrupts = <GIC_SPI  78 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&clk GPJ_GATE>;
>> +				gpio-controller;
>> +				#gpio-cells = <2>;
>> +				interrupt-controller;
>> +				#interrupt-cells = <2>;
>> +			};
>> +
>> +			gpiok: gpiok@40040280 {
>> +				reg = <0x280 0x40>;
>> +				interrupts = <GIC_SPI  102 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&clk GPK_GATE>;
>> +				gpio-controller;
>> +				#gpio-cells = <2>;
>> +				interrupt-controller;
>> +				#interrupt-cells = <2>;
>> +			};
>> +
>> +			gpiol: gpiol@400402c0 {
>> +				reg = <0x2c0 0x40>;
>> +				interrupts = <GIC_SPI  103 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&clk GPL_GATE>;
>> +				gpio-controller;
>> +				#gpio-cells = <2>;
>> +				interrupt-controller;
>> +				#interrupt-cells = <2>;
>> +			};
>> +
>> +			gpiom: gpiom@40040300 {
>> +				reg = <0x300 0x40>;
>> +				interrupts = <GIC_SPI  104 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&clk GPM_GATE>;
>> +				gpio-controller;
>> +				#gpio-cells = <2>;
>> +				interrupt-controller;
>> +				#interrupt-cells = <2>;
>> +			};
>> +
>> +			gpion: gpion@40040340 {
>> +				reg = <0x340 0x40>;
>> +				interrupts = <GIC_SPI  105 IRQ_TYPE_LEVEL_HIGH>;
>> +				clocks = <&clk GPN_GATE>;
>> +				gpio-controller;
>> +				#gpio-cells = <2>;
>> +				interrupt-controller;
>> +				#interrupt-cells = <2>;
>> +			};
>> +
>> +			pcfg_default: pcfg-default {
>> +				slew-rate = <0>;
>> +				input-schmitt-disable;
>> +				bias-disable;
>> +				power-source = <3300>;
>> +				drive-strength = <0>;
>> +			};
>> +
>> +			pcfg_emac_3_3v: pcfg-emac-3.3v {
> Drop, unused.
>
>> +				slew-rate = <0>;
>> +				input-schmitt-enable;
>> +				bias-disable;
>> +				power-source = <3300>;
>> +				drive-strength = <1>;
>> +			};
>> +
>> +			pcfg_emac_1_8v: pcfg-emac-1.8v {
> Drop, unused.

Sure, I will drop these two nodes.

>> +				slew-rate = <0>;
>> +				input-schmitt-enable;
>> +				bias-disable;
>> +				power-source = <1800>;
>> +				drive-strength = <1>;
>> +			};
>> +		};
>> +
>>   		uart0: serial@40700000 {
>>   			compatible = "nuvoton,ma35d1-uart";
>>   			reg = <0x0 0x40700000 0x0 0x100>;
> Best regards,
> Krzysztof
>

Best Regards,
Jacky Huang

