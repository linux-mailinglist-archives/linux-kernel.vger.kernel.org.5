Return-Path: <linux-kernel+bounces-27516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1223B82F176
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85FF41F24795
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6971C2B2;
	Tue, 16 Jan 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O4KhRdfH"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72E51C29F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-559c1396ecfso310673a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705418729; x=1706023529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7QSzWK63tLNRt8LFQx6IahbXnqQlTkelL+ijPjuI+Bg=;
        b=O4KhRdfHQKT/B0FJoUSmuQU3vBBTpOCv89Q7OkSBIrxf5lQKdY5dSfC9LpxqMYxuFH
         cOPA2EmNH4vzZSM0WzhZdu3DCNY+/kwSeW+JPpVEaZ7gpINgptHUhLj9MmR6KNoT1W9v
         R39HCeJ0c7IMjxgCJHS824x0aC52yrfP7qMF5BmR0NgLg1binEAVh5ysmx4fxRGXq5LX
         pc62x0AZT0RKNZEz6d8LNY2tJQ/JmXrUHEBr3NTaFlD7e8iWD/XrwCip1yPPUmgtyvqn
         ZlwEvwW6FlCRHpOp+KIxsAX+nHWKW4I468mQSlchhaHH0qWokoJEe4u/nPLipymXLcAp
         vtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705418729; x=1706023529;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7QSzWK63tLNRt8LFQx6IahbXnqQlTkelL+ijPjuI+Bg=;
        b=Dnkj6HCkj/lFJ2MBUXRr/zgVVJ3cjPOr5qocLhYOL47sn2ix/DsCeKaEMEb5FVIAKb
         7uF1HldimmkyMwZr/qhTkDTF41I83Sy6TJOD9hxTz7QAQx441iTejHyyycRv40RB5yBE
         jb88ZVtrKCLO+Qlkm+AWj/4mXqyxhfrN/MMd7xzMLk64SfYnaedSPdMSK9oZth3d3eJP
         IGUUDSyzD+DAR5sqDcCN3UXj+YZwNQv2nbUlNgKoQOW8j/EdNO6RIj4WwxkBGX1LuDU8
         xbNQlg4/BceWh8MeuTABKhGZuBZIsgFOlDoxkZ9Hrh/6vrE/jn+dr+tmw/ZY1uTKwQYe
         ZywQ==
X-Gm-Message-State: AOJu0Yw7X/sDYoTLagdmb6IGb5no4G+0J8NmbPgEl+K7SrHgI4TEBmgx
	4rX6oOE4Jrppt9q+Knnbfu+rI2EwVrGdOA==
X-Google-Smtp-Source: AGHT+IFQHFWh/+TYudct0ZkWUhJD4RPQVbfAKPBWasfhWBy8tBrjVRj3ycAtrRQ9aIWteBdF2Xj+/Q==
X-Received: by 2002:a17:907:d30c:b0:a2c:ce00:1bfa with SMTP id vg12-20020a170907d30c00b00a2cce001bfamr4717772ejc.87.1705418729013;
        Tue, 16 Jan 2024 07:25:29 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id w4-20020a170906130400b00a26f1e3093asm6594677ejb.49.2024.01.16.07.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 07:25:28 -0800 (PST)
Message-ID: <007e8c14-13eb-4917-b9da-8d47d6c965c7@linaro.org>
Date: Tue, 16 Jan 2024 16:25:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] riscv: dts: sophgo: add rtc dt node for CV1800
Content-Language: en-US
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: alexandre.belloni@bootlin.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, chao.wei@sophgo.com,
 unicorn_wang@outlook.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, linux-rtc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, dlan@gentoo.org, inochiama@outlook.com
References: <20240115160600.5444-1-qiujingbao.dlmu@gmail.com>
 <20240115160600.5444-4-qiujingbao.dlmu@gmail.com>
 <f2b3dff2-ce0d-4ddb-ad61-74abf2c3022d@linaro.org>
 <CAJRtX8QFLoWnJBkepZrbneHX8qZdde=aw+zbdErVC91B=u==MA@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAJRtX8QFLoWnJBkepZrbneHX8qZdde=aw+zbdErVC91B=u==MA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/01/2024 15:41, Jingbao Qiu wrote:
> On Tue, Jan 16, 2024 at 3:44 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 15/01/2024 17:06, Jingbao Qiu wrote:
>>> Add the rtc device tree node to cv1800 SoC.
>>>
>>> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
>>> ---
>>>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>>> index df40e87ee063..66bb4a752b91 100644
>>> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>>> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>>> @@ -119,5 +119,17 @@ clint: timer@74000000 {
>>>                       reg = <0x74000000 0x10000>;
>>>                       interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
>>>               };
>>> +
>>> +             rtc: rtc@5025000 {
>>> +                     compatible = "sophgo,cv1800-rtc", "syscon";
>>> +                     reg = <0x5025000 0x2000>;
>>> +                     interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
>>> +                     clocks = <&osc>;
>>> +             };
>>> +
>>> +             por {
>>> +                     compatible = "sophgo,cv1800-por";
>>
>> What is this? Why is it here, how did it even appear? It misses unit
>> address and reg or is clearly placed in wrong place. It seems you
>> entirely ignored out previous discussion.
>>
>> NAK
>>
> 
> I'm very sorry for wasting your time. Furthermore, we would like to
> thank you for your patient response.
> Let me realize the rigor of Linux kernel code. I greatly admire
> this.Please allow me to briefly review
> our previous discussions.
> 
> CV1800 is a RISCV based SOC that includes an RTC module. The RTC
> module has an OSC oscillator


I am not going to read pages of description. Please write concise replies.

> and POR submodule inside.This OSC oscillator is only for RTC use, so
> it does not need to be described
> as a dt node. The POR submodule provides power off/on and restart
> functions for CV1800. So I need
> two drivers corresponding to RTC and POR respectively. RTC requires

This is DTS, not drivers. Please do not mix it.

> the use of irq and clk resources
> in addition to registers, while POR only requires Reg resources. The
> current problem is how to describe
> the relationship between RTC and POR, and how to make registers shared
> by these two drivers.
> 
> In v3, I thought RTC was an MFD device because it not only had RTC
> functionality but also restart and
> power on/off capabilities.So my example is shown below.
> 
> syscon@5025000 {
>   compatible = "sophgo,cv1800b-subsys", "syscon", "simple-mfd";
>   reg = <0x05025000 0x2000>;
>   rtc {
>     compatible = "sophgo,cv1800b-rtc";
>     interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
>     clocks = <&clk CLK_RTC_25M>;
>   };
> }
> 
> There were two suggestions you made at the time. Firstly, I only
> described RTC and did not describe
> the POR submodule. Secondly, regarding the name issue, system
> controllers should not be placed
> in the mfd file.Afterwards, I released the 4th version, in which I
> described the POR submodule, which
> is included side by side with RTC in the misc device. Then, by sharing
> the register, both RTC and
> POR drivers can access the registers.
> 
> misc@5025000 {
>   compatible = "sophgo,cv1800-misc", "syscon", "simple-mfd";
>   reg = <0x05025000 0x2000>;
>   rtc  {
>     compatible = "sophgo,cv1800-rtc";
>     interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
>     clocks = <&clk 15>;
>   };
>   por  {
>     compatible = "sophgo,cv1800-por";
>   };
> };
> 
> Your suggestion is, firstly, the por submodule does not have any
> resources, so it should be deleted.

So where did you delete it? I still see it in this patch.

> The second issue is still the name, misc is any device.
> Afterwards, I released the 5th edition. In this version, I removed the
> POR submodule in RTC.
> 
> rtc@5025000 {
>     compatible = "sophgo,cv1800-rtc", "syscon";
>     reg = <0x5025000 0x2000>;
>     interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
>     clocks = <&clk 15>;
> };
> 
> The question you raised is why syscon child nodes are used.
> In this version, I will try the following methods.

"Will" is the future tense, so about which patch are we talking?

> 
> rtc: rtc@5025000 {
>                     compatible = "sophgo,cv1800-rtc", "syscon";
>                     reg = <0x5025000 0x2000>;
>                     interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
>                     clocks = <&osc>;
> };
> por {
>                     compatible = "sophgo,cv1800-por";
>                     sophgo,rtc-sysreg = <&rtc>;
> };

NAK, because:

"so it should be deleted."


> 
> My idea is that this register can be accessed through the syscon tag,
> RTC driver, and reboot driver.

Again, what drivers have anything to do here?

> Then complete their functions.
> I'm sorry if it was due to language differences that caused my misunderstanding.
> Perhaps I can accomplish it through the following methods.
> rtc: rtc@5025000 {
>                     compatible = "sophgo,cv1800-rtc", "sophgo,cv1800-por";

Device is only one thing, not two.

>                     reg = <0x5025000 0x2000>;
>                     interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
>                     clocks = <&osc>;
> };
> However, in reality, the POR submodule does not use IRQ and CLK.
> Please do not hesitate to teach. Thanks.

I expect one device node. How many drivers you have does not matter: you
can instantiate 100 Linux devices in 100 Linux device drivers.

Best regards,
Krzysztof


