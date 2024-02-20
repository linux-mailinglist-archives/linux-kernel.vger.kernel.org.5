Return-Path: <linux-kernel+bounces-72514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E96685B496
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9062820AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471205C5E5;
	Tue, 20 Feb 2024 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pRSoYMPC"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B81B5BAF8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416586; cv=none; b=ek4Nlh4ZKOE5l3Ir0nr2XK2y9AGNSgFoBdrVi5nTHu4P2CwSaR6IuL9csUl4Asop/r8zTH1x8TElnG7rXexmYo9rMmfFfmbzhAhWj8rUg3UOUkWoXtsQKkJTIYEco1MHD9I03gcDWfg76o0GiBwbsRpdIRcKqoOK5qSF6/QhC+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416586; c=relaxed/simple;
	bh=jJas3PCiWGP/uYbpXavg2JpY20Dps+eGD2+isVZhd5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZF60YDDJF8Zdrr8LHtCKWYu5FF9Ugc/EkgUBjRTu4ffB5BhWl92M6mtQZhRjkyCQS+0fFMurv93e18e+vPNaWVaIrAni8/cgL+S0APsGNerdkhgJn5dN0hL3PqcGbzOw5MrEP8eHpYqgp3uutbCChS+gMj46wXiJV66YEebBnAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pRSoYMPC; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33d6cc6d2fcso137426f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708416582; x=1709021382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=blZnKgRz8pLuO+3ejMorNGe2VPPA8JpGpC85cEbyxOg=;
        b=pRSoYMPCohUCsqk+tBmvUC2AVQ+baYo4epntqvk/H1kZSF1WgNCsnoqv2w8lCDeS/e
         NlWSZ5vLckMCw4WjiLBTpQVzrsBTL3hfSNky8XBw66l1uyvxEiFNVpZZjElKMlPbgrNP
         2MGz4vADH4d+aNP25VKzjXSpFdPqcWRVaMou6CofjJ6nLjd2l4Tb+9Sdi6hmAaLQyLMm
         CruouJQsA+pXXKYW5hTAZXWYnJaBo5i1pN+bByu3CYbqxLd63bLMPJBVSZev08Gh266I
         gju6o52TY5AwsICBl/aUn/UyInaE9Km+MxWngvrAFh+NraKKig1nGLUW4JXHPd2gl3zL
         Ys8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708416582; x=1709021382;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blZnKgRz8pLuO+3ejMorNGe2VPPA8JpGpC85cEbyxOg=;
        b=Hf6SkmrSP+4n7CHTs1fBhEiq5Ch9EVbSL3ekAuXqdfTOSqBTZkdBcoStGqJVWVgE2b
         PnVMAPYn/FbDDvzRGNxC5KBSvxtxN+Nd2byY+2YDhJ8+7o/69pmywhLP1zM8WNx89yOV
         nu7dCXeaascWfL5aVI3Dad0uVvKR56vy7+By2FzDzLXlj9KlHW0diQf8sAYWxNMiYr0C
         miEsoEAQsrOVFz71Sh6F85rPtT6QJcPCN91WuAdwMiseNqcVJIjLxPEoFF6M18zcEWpV
         /IO3oOvGzKA/dJAflC7FIESFzzI+DQIc1kiN6UnhNtFLiUAQx9wTRqloPWmJVVcRt/7m
         r/SA==
X-Forwarded-Encrypted: i=1; AJvYcCVfQx82XtMVyVlA1c2hpOVo9coujr78uBE7l3SwMfcV/7Dqroju8SMsKbgK86L4azNCK16c6VhuMb4N7DCVxhlLHAbvqI+kdP0LzVAS
X-Gm-Message-State: AOJu0YxZDF+hqdk8GJmL8wM6eilm1kAjCKwAtL8LFJtA6cHvra1+9g0E
	M4b+y3M8oC5JrGnWg6iu4L+OAJC7HusdmcZ3nO+ttKZVgGw1lh8D+c5PSdihy3A=
X-Google-Smtp-Source: AGHT+IFHCN1p31puPXkTHv9mBesZtljj8rz0F9yVpUS71FFKANBohvtIKLkcPC8z72uUj+KA2Eir6Q==
X-Received: by 2002:adf:ce87:0:b0:33d:277b:8bf6 with SMTP id r7-20020adfce87000000b0033d277b8bf6mr5890847wrn.26.1708416582326;
        Tue, 20 Feb 2024 00:09:42 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id c14-20020a5d4cce000000b0033d694f8c45sm1305708wrt.58.2024.02.20.00.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 00:09:41 -0800 (PST)
Message-ID: <2236948f-bd68-4476-bc2a-814c46c99334@linaro.org>
Date: Tue, 20 Feb 2024 09:09:39 +0100
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
To: Yuklin Soo <yuklin.soo@starfivetech.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Hal Feng <hal.feng@starfivetech.com>,
 Leyfoon Tan <leyfoon.tan@starfivetech.com>,
 Jianlong Huang <jianlong.huang@starfivetech.com>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Drew Fustini <drew@beagleboard.org>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
 <20231221083622.3445726-2-yuklin.soo@starfivetech.com>
 <3b9201e0-e1d9-463c-aa1a-cbbedd1f8907@linaro.org>
 <ZQ0PR01MB1302FD75082E80DFDDF81E82F645A@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZQ0PR01MB1302FD75082E80DFDDF81E82F645A@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/02/2024 03:42, Yuklin Soo wrote:
>>
>>> +    type: object
>>> +    additionalProperties: false
>>> +    patternProperties:
>>> +      '-pins$':
>>> +        type: object
>>> +        description: |
>>> +          A pinctrl node should contain at least one subnode representing the
>>> +          pinctrl groups available in the domain. Each subnode will list the
>>> +          pins it needs, and how they should be configured, with regard to
>>> +          muxer configuration, bias, input enable/disable, input schmitt
>>> +          trigger enable/disable, slew-rate and drive strength.
>>> +        allOf:
>>> +          - $ref: /schemas/pinctrl/pincfg-node.yaml
>>> +          - $ref: /schemas/pinctrl/pinmux-node.yaml
>>> +        additionalProperties: false
>>
>> Why the rest of the properties is not applicable?
> 
> The regex “-pins$” make sure all client subnode names end with suffix “-pins” (e.g, i2c0-scl-pins, i2c-sda-pins)

I did not talk about subnodes.

I asked why the rest of pincfg and pinmux schema properties are not allowed.


>>> +#define PAD_GPIO9_E				9
>>> +#define PAD_GPIO10_E				10
>>> +#define PAD_GPIO11_E				11
>>> +#define PAD_GPIO12_E				12
>>> +#define PAD_GPIO13_E				13
>>> +#define PAD_GPIO14_E				14
>>> +#define PAD_GPIO15_E				15
>>> +#define PAD_GPIO16_E				16
>>> +#define PAD_GPIO17_E				17
>>> +#define PAD_GPIO18_E				18
>>> +#define PAD_GPIO19_E				19
>>> +#define PAD_GPIO20_E				20
>>> +#define PAD_GPIO21_E				21
>>> +#define PAD_GPIO22_E				22
>>> +#define PAD_GPIO23_E				23
>>> +#define PAD_GPIO24_E				24
>>> +#define PAD_GPIO25_E				25
>>> +#define PAD_GPIO26_E				26
>>> +#define PAD_GPIO27_E				27
>>> +#define PAD_GPIO28_E				28
>>> +#define PAD_GPIO29_E				29
>>> +#define PAD_GPIO30_E				30
>>> +#define PAD_GPIO31_E				31
>>> +#define PAD_GPIO32_E				32
>>> +#define PAD_GPIO33_E				33
>>> +#define PAD_GPIO34_E				34
>>> +#define PAD_GPIO35_E				35
>>> +#define PAD_GPIO36_E				36
>>> +#define PAD_GPIO37_E				37
>>> +#define PAD_GPIO38_E				38
>>> +#define PAD_GPIO39_E				39
>>> +#define PAD_GPIO40_E				40
>>> +#define PAD_GPIO41_E				41
>>> +#define PAD_GPIO42_E				42
>>> +#define PAD_GPIO43_E				43
>>> +#define PAD_GPIO44_E				44
>>> +#define PAD_GPIO45_E				45
>>> +#define PAD_GPIO46_E				46
>>> +#define PAD_GPIO47_E				47
>>
>> Please explain why do you think these are bindings?
> 
> The “PAD_GPIO*_*” represent the pin numbers of the PAD_GPIO pins in each domain.

So not bindings.

> It is part of the pinmux value. The pinmux value is generated by macro GPIOMUX as follow:
> 
> pinmux = <GPIOMUX(Pin_Number, Output_Signal_Index,
>                    Output_Enable_Signal_Index,
>                    Input_Signal_Index)>;
> 
> Use I2C0 as example,
> pinmux = <GPIOMUX(PAD_GPIO9_E, GPOUT_SYS_I2C0_CLK,
>                     GPOEN_SYS_I2C0_CLK,
>                     GPI_SYS_I2C0_CLK)>;

So not bindings. Read my question - I did not ask what are these. I
asked why these are bindings. Your explanation suggests these are not. Drop.

You can always store some defines in DTS headers.

> 
>>
>>> +
>>> +/* sys_iomux_east syscon */
>>> +#define SYS_E_VREF_GPIO_E0_SYSCON_REG		0x0fc
>>> +#define SYS_E_VREF_GPIO_E0_SYSCON_MASK		GENMASK(1,
>> 0)
>>> +#define SYS_E_VREF_GPIO_E0_SYSCON_SHIFT		0
>>> +#define SYS_E_VREF_GPIO_E1_SYSCON_REG		0x100
>>> +#define SYS_E_VREF_GPIO_E1_SYSCON_MASK		GENMASK(1,
>> 0)
>>> +#define SYS_E_VREF_GPIO_E1_SYSCON_SHIFT		0
>>> +#define SYS_E_VREF_GPIO_E2_SYSCON_REG		0x104
>>> +#define SYS_E_VREF_GPIO_E2_SYSCON_MASK		GENMASK(1,
>> 0)
>>> +#define SYS_E_VREF_GPIO_E2_SYSCON_SHIFT		0
>>> +#define SYS_E_VREF_GPIO_E3_SYSCON_REG		0x108
>>> +#define SYS_E_VREF_GPIO_E3_SYSCON_MASK		GENMASK(1,
>> 0)
>>> +#define SYS_E_VREF_GPIO_E3_SYSCON_SHIFT		0
>>> +#define SYS_E_VREF_ATB_STG1_SYSCON_REG		0x10c
>>> +#define SYS_E_VREF_ATB_STG1_SYSCON_MASK		GENMASK(1,
>> 0)
>>> +#define SYS_E_VREF_ATB_STG1_SYSCON_SHIFT	0
>>> +#define SYS_E_VREF_ATB_USB_SYSCON_REG		0x110
>>> +#define SYS_E_VREF_ATB_USB_SYSCON_MASK		GENMASK(1,
>> 0)
>>> +#define SYS_E_VREF_ATB_USB_SYSCON_SHIFT		0
>>
>> Drop all of this, not bindings.
> 
> All the SYSCON macros will be removed.
> 
>>
>>> +
>>> +/* sys_iomux_gmac pins */
>>> +#define PAD_GMAC1_MDC				0
>>> +#define PAD_GMAC1_MDIO				1
>>> +#define PAD_GMAC1_RXD0				2
>>> +#define PAD_GMAC1_RXD1				3
>>> +#define PAD_GMAC1_RXD2				4
>>> +#define PAD_GMAC1_RXD3				5
>>> +#define PAD_GMAC1_RXDV				6
>>> +#define PAD_GMAC1_RXC				7
>>> +#define PAD_GMAC1_TXD0				8
>>> +#define PAD_GMAC1_TXD1				9
>>> +#define PAD_GMAC1_TXD2				10
>>> +#define PAD_GMAC1_TXD3				11
>>> +#define PAD_GMAC1_TXEN				12
>>> +#define PAD_GMAC1_TXC				13
>>> +
>>> +/* sys_iomux_gmac vref syscon registers */
>>> +#define SYS_G_VREF_GMAC1_SYSCON_REG		0x08
>>> +#define SYS_G_VREF_GMAC1_SYSCON_MASK		GENMASK(1,
>> 0)
>>> +#define SYS_G_VREF_GMAC1_SYSCON_SHIFT		0
>>> +#define SYS_G_VREF_SDIO1_SYSCON_REG		0x0c
>>> +#define SYS_G_VREF_SDIO1_SYSCON_MASK		GENMASK(1, 0)
>>> +#define SYS_G_VREF_SDIO1_SYSCON_SHIFT		0
>>
>> Drop all this.
> 
> All the GMAC and SYSCON macros will be removed.
> 
>>
>>> +
>>> +/* sys_iomux_gmac interface (rmii/rgmii) syscon registers */
>>> +#define SYS_G_GMAC1_MDC_SYSCON_REG		0x10
>>> +#define SYS_G_GMAC1_MDC_SYSCON_MASK		GENMASK(1,
>> 0)
>>> +#define SYS_G_GMAC1_MDC_SYSCON_SHIFT		0
>>> +#define SYS_G_GMAC1_MDIO_SYSCON_REG		0x14
>>> +#define SYS_G_GMAC1_MDIO_SYSCON_MASK		GENMASK(1,
>> 0)
>>> +#define SYS_G_GMAC1_MDIO_SYSCON_SHIFT		0
>>> +#define SYS_G_GMAC1_RXD0_SYSCON_REG		0x18
>>> +#define SYS_G_GMAC1_RXD0_SYSCON_MASK		GENMASK(1,
>> 0)
>>> +#define SYS_G_GMAC1_RXD0_SYSCON_SHIFT		0
>>> +#define SYS_G_GMAC1_RXD1_SYSCON_REG		0x1c
>>> +#define SYS_G_GMAC1_RXD1_SYSCON_MASK		GENMASK(1,
>> 0)
>>> +#define SYS_G_GMAC1_RXD1_SYSCON_SHIFT		0
>>> +#define SYS_G_GMAC1_RXD2_SYSCON_REG		0x20
>>> +#define SYS_G_GMAC1_RXD2_SYSCON_MASK		GENMASK(1,
>> 0)
>>> +#define SYS_G_GMAC1_RXD2_SYSCON_SHIFT		0
>>> +#define SYS_G_GMAC1_RXD3_SYSCON_REG		0x24
>>> +#define SYS_G_GMAC1_RXD3_SYSCON_MASK		GENMASK(1,
>> 0)
>>> +#define SYS_G_GMAC1_RXD3_SYSCON_SHIFT		0
>>> +#define SYS_G_GMAC1_RXDV_SYSCON_REG		0x28
>>> +#define SYS_G_GMAC1_RXDV_SYSCON_MASK		GENMASK(1,
>> 0)
>>> +#define SYS_G_GMAC1_RXDV_SYSCON_SHIFT		0
>>> +#define SYS_G_GMAC1_RXC_SYSCON_REG		0x2c
>>> +#define SYS_G_GMAC1_RXC_SYSCON_MASK		GENMASK(1, 0)
>>> +#define SYS_G_GMAC1_RXC_SYSCON_SHIFT		0
>>> +#define SYS_G_GMAC1_TXD0_SYSCON_REG		0x30
>>> +#define SYS_G_GMAC1_TXD0_SYSCON_MASK		GENMASK(1,
>> 0)
>>> +#define SYS_G_GMAC1_TXD0_SYSCON_SHIFT		0
>>> +#define SYS_G_GMAC1_TXD1_SYSCON_REG		0x34
>>> +#define SYS_G_GMAC1_TXD1_SYSCON_MASK		GENMASK(1,
>> 0)
>>> +#define SYS_G_GMAC1_TXD1_SYSCON_SHIFT		0
>>> +#define SYS_G_GMAC1_TXD2_SYSCON_REG		0x38
>>> +#define SYS_G_GMAC1_TXD2_SYSCON_MASK		GENMASK(1,
>> 0)
>>> +#define SYS_G_GMAC1_TXD2_SYSCON_SHIFT		0
>>> +#define SYS_G_GMAC1_TXD3_SYSCON_REG		0x3c
>>> +#define SYS_G_GMAC1_TXD3_SYSCON_MASK		GENMASK(1,
>> 0)
>>> +#define SYS_G_GMAC1_TXD3_SYSCON_SHIFT		0
>>> +#define SYS_G_GMAC1_TXEN_SYSCON_REG		0x40
>>> +#define SYS_G_GMAC1_TXEN_SYSCON_MASK		GENMASK(1,
>> 0)
>>> +#define SYS_G_GMAC1_TXEN_SYSCON_SHIFT		0
>>> +#define SYS_G_GMAC1_TXC_SYSCON_REG		0x44
>>> +#define SYS_G_GMAC1_TXC_SYSCON_MASK		GENMASK(1, 0)
>>> +#define SYS_G_GMAC1_TXC_SYSCON_SHIFT		0
>>
>> Drop all this.
> 
> All the SYSCON macros will be removed.
> 
>>
>>
>>> +
>>> +/* sys_iomux_gmac timing (slew rate) registers */
>>
>> Srsly, "registers", so not bindings.
> 
> All these will be removed.
> 
>>
>>
>>> +
>>> +#define GPOUT_LOW				0
>>> +#define GPOUT_HIGH				1
>>
>> That's it. Really. Please do not redefine existing bindings.
>>
>>> +
>>> +#define GPOEN_ENABLE				0
>>> +#define GPOEN_DISABLE				1
>>> +
>>> +#define GPI_NONE				255
>>> +
>>> +/* vref syscon value  */
>>> +#define PAD_VREF_SYSCON_IO_3V3			0
>>> +#define PAD_VREF_SYSCON_IO_1V8			2
>>> +
>>> +/* gmac interface (rmii/rgmii) syscon value */
>>> +#define GMAC_RMII_MODE				0	/* RMII
>> mode,  DVDD 2.5V/3.3V */
>>> +#define GMAC_RGMII_MODE				1	/*
>> RGMII mode, DVDD 1.8V/2.5V */
>>> +
>>> +/* gmac timing syscon value */
>>> +#define GMAC_SLEW_RATE_FAST			0
>>> +#define GMAC_SLEW_RATE_SLOW			1
>>
>> Drop all above.
> 
> All SYSCON macros will be dropped.
> However, the following will be kept in the header file,
> #define GPOUT_LOW                               0
> #define GPOUT_HIGH                              1
> 
> #define GPOEN_ENABLE                            0
> #define GPOEN_DISABLE                           1
> 
> #define GPI_NONE                                255

No, why?

I think I commented quite strongly about it.

Best regards,
Krzysztof


