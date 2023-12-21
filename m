Return-Path: <linux-kernel+bounces-8708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 133E281BB4D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7B028424F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8963253A1B;
	Thu, 21 Dec 2023 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ut4Po0oq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B053A00
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso1205248a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703173794; x=1703778594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SoiMDU+0MarmCY6pLDeiLlpD4jrLOiR8oPDP6pvBqeU=;
        b=ut4Po0oq0o1amXJwrL+yCX49Criatm2nhyWs2BgIC4ZpKbhBBak1IHyfQtFm5gldCP
         ZSUoT6tY0eWdad4Ic6Qx9F8OD4elsZKZrwExLPh709D7IHjchwJOJW5XgJOudjBn4mTh
         mSXIOqiVJ1FeKWyG6ftsgY+puOObx2RLpU/dis0jAT1HHNltFPjavniBd4eulsIxM6tk
         1u0fu/5hbNmglVnvtSf/YeQNOZUFSW2N/R4eNs/mjBN9d/SwK5IM96BQ5C/48bSRG/a8
         +EpTfyYQBTBySd0Rslbuti0XuoVKISB5l9da6hKDH2tx2I9TcK3Pyi0vxq8juynvnrCt
         Wjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703173794; x=1703778594;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SoiMDU+0MarmCY6pLDeiLlpD4jrLOiR8oPDP6pvBqeU=;
        b=v66ltDYjiOqoXTqV+NXw7yzyoXTyxjlXrHQjDcrsu/J6qdeDx1k1PHvi0I4BNK/vBs
         GLzo2e/IvB2hORS4Twyyay99FFLopwd8K7z48YnkMuKHLuFwx9y9giUbJeoGzJ+hqJng
         MWSc8dtnc8nbFuHYaplwQK2uK4457Ya+9NJSZ+hSxQmhpARHbUIQtiOJrdLheFh0lqxv
         CbcKTImRfL6wfJKjim3dHLLv5kRlx7UvmTckwWOKF2FHs/MMeaJW93iMG3xpzCQIR2Ud
         kF9Aakb5BfJT8Bg24NtLwso+ywMubBN2H28vhGt5khJ9gmzRtVSnmzQg9V+q54PAIMB8
         zVCQ==
X-Gm-Message-State: AOJu0YxgRoWUzkjrtXTd0Z70uUS3mrjELxMrDWsQGIkZwtQvXDU9AE1K
	szeVGhlw6AK8SKZUqhxddx3hpg==
X-Google-Smtp-Source: AGHT+IHIk/tTPdzz0XgMG8R6Ho14M7KVyEcY4r/RZkhWT1E/yj+CkSvaogLDSUEi/0ldWZITxlEK+A==
X-Received: by 2002:a50:ccc8:0:b0:553:bf41:3411 with SMTP id b8-20020a50ccc8000000b00553bf413411mr1682320edj.57.1703173794481;
        Thu, 21 Dec 2023 07:49:54 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id u17-20020a05640207d100b005538d504793sm1307382edy.23.2023.12.21.07.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 07:49:54 -0800 (PST)
Message-ID: <3b9201e0-e1d9-463c-aa1a-cbbedd1f8907@linaro.org>
Date: Thu, 21 Dec 2023 16:49:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] dt-bindings: pinctrl: starfive: add JH8100
 pinctrl bindings
Content-Language: en-US
To: Alex Soo <yuklin.soo@starfivetech.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Hal Feng <hal.feng@starfivetech.com>,
 Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Jianlong Huang <jianlong.huang@starfivetech.com>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Drew Fustini <drew@beagleboard.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
 <20231221083622.3445726-2-yuklin.soo@starfivetech.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231221083622.3445726-2-yuklin.soo@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/12/2023 09:36, Alex Soo wrote:
> Add dt-binding documentation and header file for JH8100 pinctrl
> driver.
> 
> Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> ---


A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.

...
> +  i

nterrupt-controller: true
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +patternProperties:
> +  '-[0-9]+$':

This is a bit too wide pattern. Consider some suffix like -grp or
-group. Look at other bindings how they do it.

> +    type: object
> +    additionalProperties: false
> +    patternProperties:
> +      '-pins$':
> +        type: object
> +        description: |
> +          A pinctrl node should contain at least one subnode representing the
> +          pinctrl groups available in the domain. Each subnode will list the
> +          pins it needs, and how they should be configured, with regard to
> +          muxer configuration, bias, input enable/disable, input schmitt
> +          trigger enable/disable, slew-rate and drive strength.
> +        allOf:
> +          - $ref: /schemas/pinctrl/pincfg-node.yaml
> +          - $ref: /schemas/pinctrl/pinmux-node.yaml
> +        additionalProperties: false

Why the rest of the properties is not applicable?

> +
> +        properties:
> +          pinmux:
> +            description: |
> +              The list of GPIOs and their mux settings or function select.
> +              The GPIOMUX and PINMUX macros are used to configure the
> +              I/O multiplexing and function selection respectively.
> +
> +          bias-disable: true
> +
> +          bias-pull-up:
> +            type: boolean
> +
> +          bias-pull-down:
> +            type: boolean
> +
> +          drive-strength:
> +            enum: [ 2, 4, 8, 12 ]
> +
> +          input-enable: true
> +
> +          input-disable: true
> +
> +          input-schmitt-enable: true
> +
> +          input-schmitt-disable: true
> +
> +          slew-rate:
> +            maximum: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - resets
> +  - interrupts
> +  - interrupt-controller
> +  - gpio-controller
> +  - '#gpio-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/starfive,jh8100.h>
> +    #include <dt-bindings/reset/starfive-jh8100.h>
> +    #include <dt-bindings/pinctrl/starfive,jh8100-pinctrl.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pinctrl_aon: pinctrl@1f300000 {
> +                compatible = "starfive,jh8100-aon-pinctrl",
> +                             "syscon", "simple-mfd";

You did not even bother to test it before sending.

> +                reg = <0x0 0x1f300000 0x0 0x10000>;
> +                resets = <&aoncrg 0>;

Use 4 spaces for example indentation.

> +                interrupts = <160>;
> +                interrupt-controller;
> +                gpio-controller;
> +                #gpio-cells = <2>;


Incomplete example.

I'll stop review, except one more comment, this was not tested and does
not work. Reviewing code which was never tested is a waste of reviewer's
time.


...

> diff --git a/include/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h b/include/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h
> new file mode 100644
> index 000000000000..c57b7ece37a2
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/starfive,jh8100-pinctrl.h
> @@ -0,0 +1,303 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
> +/*
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> + * Author: Alex Soo <yuklin.soo@starfivetech.com>
> + *
> + */
> +
> +#ifndef __DT_BINDINGS_PINCTRL_STARFIVE_JH8100_H__
> +#define __DT_BINDINGS_PINCTRL_STARFIVE_JH8100_H__
> +
> +/* sys_iomux_west pins */
> +#define PAD_GPIO0_W				0
> +#define PAD_GPIO1_W				1
> +#define PAD_GPIO2_W				2
> +#define PAD_GPIO3_W				3
> +#define PAD_GPIO4_W				4
> +#define PAD_GPIO5_W				5
> +#define PAD_GPIO6_W				6
> +#define PAD_GPIO7_W				7
> +#define PAD_GPIO8_W				8
> +#define PAD_GPIO9_W				9
> +#define PAD_GPIO10_W				10
> +#define PAD_GPIO11_W				11
> +#define PAD_GPIO12_W				12
> +#define PAD_GPIO13_W				13
> +#define PAD_GPIO14_W				14
> +#define PAD_GPIO15_W				15
> +
> +/* sys_iomux_west syscon */
> +#define SYS_W_VREF_GPIO_W_SYSCON_REG		0x6c
> +#define SYS_W_VREF_GPIO_W_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_W_VREF_GPIO_W_SYSCON_SHIFT		0
> +#define SYS_W_VREF_ATB_ISP_VOUT_SYSCON_REG	0x70
> +#define SYS_W_VREF_ATB_ISP_VOUT_SYSCON_MASK	GENMASK(1, 0)
> +#define SYS_W_VREF_ATB_ISP_VOUT_SYSCON_SHIFT	0

None of these are bindings, drop.

> +
> +/* sys_iomux_east pins */
> +#define PAD_GPIO0_E				0
> +#define PAD_GPIO1_E				1
> +#define PAD_GPIO2_E				2
> +#define PAD_GPIO3_E				3
> +#define PAD_GPIO4_E				4
> +#define PAD_GPIO5_E				5
> +#define PAD_GPIO6_E				6
> +#define PAD_GPIO7_E				7
> +#define PAD_GPIO8_E				8
> +#define PAD_GPIO9_E				9
> +#define PAD_GPIO10_E				10
> +#define PAD_GPIO11_E				11
> +#define PAD_GPIO12_E				12
> +#define PAD_GPIO13_E				13
> +#define PAD_GPIO14_E				14
> +#define PAD_GPIO15_E				15
> +#define PAD_GPIO16_E				16
> +#define PAD_GPIO17_E				17
> +#define PAD_GPIO18_E				18
> +#define PAD_GPIO19_E				19
> +#define PAD_GPIO20_E				20
> +#define PAD_GPIO21_E				21
> +#define PAD_GPIO22_E				22
> +#define PAD_GPIO23_E				23
> +#define PAD_GPIO24_E				24
> +#define PAD_GPIO25_E				25
> +#define PAD_GPIO26_E				26
> +#define PAD_GPIO27_E				27
> +#define PAD_GPIO28_E				28
> +#define PAD_GPIO29_E				29
> +#define PAD_GPIO30_E				30
> +#define PAD_GPIO31_E				31
> +#define PAD_GPIO32_E				32
> +#define PAD_GPIO33_E				33
> +#define PAD_GPIO34_E				34
> +#define PAD_GPIO35_E				35
> +#define PAD_GPIO36_E				36
> +#define PAD_GPIO37_E				37
> +#define PAD_GPIO38_E				38
> +#define PAD_GPIO39_E				39
> +#define PAD_GPIO40_E				40
> +#define PAD_GPIO41_E				41
> +#define PAD_GPIO42_E				42
> +#define PAD_GPIO43_E				43
> +#define PAD_GPIO44_E				44
> +#define PAD_GPIO45_E				45
> +#define PAD_GPIO46_E				46
> +#define PAD_GPIO47_E				47

Please explain why do you think these are bindings?

> +
> +/* sys_iomux_east syscon */
> +#define SYS_E_VREF_GPIO_E0_SYSCON_REG		0x0fc
> +#define SYS_E_VREF_GPIO_E0_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_E_VREF_GPIO_E0_SYSCON_SHIFT		0
> +#define SYS_E_VREF_GPIO_E1_SYSCON_REG		0x100
> +#define SYS_E_VREF_GPIO_E1_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_E_VREF_GPIO_E1_SYSCON_SHIFT		0
> +#define SYS_E_VREF_GPIO_E2_SYSCON_REG		0x104
> +#define SYS_E_VREF_GPIO_E2_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_E_VREF_GPIO_E2_SYSCON_SHIFT		0
> +#define SYS_E_VREF_GPIO_E3_SYSCON_REG		0x108
> +#define SYS_E_VREF_GPIO_E3_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_E_VREF_GPIO_E3_SYSCON_SHIFT		0
> +#define SYS_E_VREF_ATB_STG1_SYSCON_REG		0x10c
> +#define SYS_E_VREF_ATB_STG1_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_E_VREF_ATB_STG1_SYSCON_SHIFT	0
> +#define SYS_E_VREF_ATB_USB_SYSCON_REG		0x110
> +#define SYS_E_VREF_ATB_USB_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_E_VREF_ATB_USB_SYSCON_SHIFT		0

Drop all of this, not bindings.

> +
> +/* sys_iomux_gmac pins */
> +#define PAD_GMAC1_MDC				0
> +#define PAD_GMAC1_MDIO				1
> +#define PAD_GMAC1_RXD0				2
> +#define PAD_GMAC1_RXD1				3
> +#define PAD_GMAC1_RXD2				4
> +#define PAD_GMAC1_RXD3				5
> +#define PAD_GMAC1_RXDV				6
> +#define PAD_GMAC1_RXC				7
> +#define PAD_GMAC1_TXD0				8
> +#define PAD_GMAC1_TXD1				9
> +#define PAD_GMAC1_TXD2				10
> +#define PAD_GMAC1_TXD3				11
> +#define PAD_GMAC1_TXEN				12
> +#define PAD_GMAC1_TXC				13
> +
> +/* sys_iomux_gmac vref syscon registers */
> +#define SYS_G_VREF_GMAC1_SYSCON_REG		0x08
> +#define SYS_G_VREF_GMAC1_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_G_VREF_GMAC1_SYSCON_SHIFT		0
> +#define SYS_G_VREF_SDIO1_SYSCON_REG		0x0c
> +#define SYS_G_VREF_SDIO1_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_G_VREF_SDIO1_SYSCON_SHIFT		0

Drop all this.

> +
> +/* sys_iomux_gmac interface (rmii/rgmii) syscon registers */
> +#define SYS_G_GMAC1_MDC_SYSCON_REG		0x10
> +#define SYS_G_GMAC1_MDC_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_G_GMAC1_MDC_SYSCON_SHIFT		0
> +#define SYS_G_GMAC1_MDIO_SYSCON_REG		0x14
> +#define SYS_G_GMAC1_MDIO_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_G_GMAC1_MDIO_SYSCON_SHIFT		0
> +#define SYS_G_GMAC1_RXD0_SYSCON_REG		0x18
> +#define SYS_G_GMAC1_RXD0_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_G_GMAC1_RXD0_SYSCON_SHIFT		0
> +#define SYS_G_GMAC1_RXD1_SYSCON_REG		0x1c
> +#define SYS_G_GMAC1_RXD1_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_G_GMAC1_RXD1_SYSCON_SHIFT		0
> +#define SYS_G_GMAC1_RXD2_SYSCON_REG		0x20
> +#define SYS_G_GMAC1_RXD2_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_G_GMAC1_RXD2_SYSCON_SHIFT		0
> +#define SYS_G_GMAC1_RXD3_SYSCON_REG		0x24
> +#define SYS_G_GMAC1_RXD3_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_G_GMAC1_RXD3_SYSCON_SHIFT		0
> +#define SYS_G_GMAC1_RXDV_SYSCON_REG		0x28
> +#define SYS_G_GMAC1_RXDV_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_G_GMAC1_RXDV_SYSCON_SHIFT		0
> +#define SYS_G_GMAC1_RXC_SYSCON_REG		0x2c
> +#define SYS_G_GMAC1_RXC_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_G_GMAC1_RXC_SYSCON_SHIFT		0
> +#define SYS_G_GMAC1_TXD0_SYSCON_REG		0x30
> +#define SYS_G_GMAC1_TXD0_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_G_GMAC1_TXD0_SYSCON_SHIFT		0
> +#define SYS_G_GMAC1_TXD1_SYSCON_REG		0x34
> +#define SYS_G_GMAC1_TXD1_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_G_GMAC1_TXD1_SYSCON_SHIFT		0
> +#define SYS_G_GMAC1_TXD2_SYSCON_REG		0x38
> +#define SYS_G_GMAC1_TXD2_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_G_GMAC1_TXD2_SYSCON_SHIFT		0
> +#define SYS_G_GMAC1_TXD3_SYSCON_REG		0x3c
> +#define SYS_G_GMAC1_TXD3_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_G_GMAC1_TXD3_SYSCON_SHIFT		0
> +#define SYS_G_GMAC1_TXEN_SYSCON_REG		0x40
> +#define SYS_G_GMAC1_TXEN_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_G_GMAC1_TXEN_SYSCON_SHIFT		0
> +#define SYS_G_GMAC1_TXC_SYSCON_REG		0x44
> +#define SYS_G_GMAC1_TXC_SYSCON_MASK		GENMASK(1, 0)
> +#define SYS_G_GMAC1_TXC_SYSCON_SHIFT		0

Drop all this.


> +
> +/* sys_iomux_gmac timing (slew rate) registers */

Srsly, "registers", so not bindings.


> +
> +#define GPOUT_LOW				0
> +#define GPOUT_HIGH				1

That's it. Really. Please do not redefine existing bindings.

> +
> +#define GPOEN_ENABLE				0
> +#define GPOEN_DISABLE				1
> +
> +#define GPI_NONE				255
> +
> +/* vref syscon value  */
> +#define PAD_VREF_SYSCON_IO_3V3			0
> +#define PAD_VREF_SYSCON_IO_1V8			2
> +
> +/* gmac interface (rmii/rgmii) syscon value */
> +#define GMAC_RMII_MODE				0	/* RMII mode,  DVDD 2.5V/3.3V */
> +#define GMAC_RGMII_MODE				1	/* RGMII mode, DVDD 1.8V/2.5V */
> +
> +/* gmac timing syscon value */
> +#define GMAC_SLEW_RATE_FAST			0
> +#define GMAC_SLEW_RATE_SLOW			1

Drop all above.

> +
> +#endif

Best regards,
Krzysztof


