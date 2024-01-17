Return-Path: <linux-kernel+bounces-28597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CF0830084
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20CAE1F2505C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C90BBA4B;
	Wed, 17 Jan 2024 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gfo9rYzQ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994879473
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705476515; cv=none; b=enexvN28UY69A7fD/PNHmKopglVOlAqr3KHXE+z0kGiZTF2FQU2Ywods5i2qVP14BUvLidnaULrDDL8Z4vhF8jpcLggSXm5ugluR2JE3r3ukEa6/J+rpQzD276UAiu0stIteQxDbshwkrifFXQrI+c+5DwranUYtA/Op7tN++K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705476515; c=relaxed/simple;
	bh=L/4nwExbgQD2MCjwfzD0r2tSI3SEcqWZgrHU609CGnI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=O5gWK0DQLfu+jY9Tx0Ps33SpyKPMr0/emhCVioXqf00ffWRu7j55YGvNaZGkQK492LWIVlP5hz+V4xwa25NltTFMwudqrgeP9+aZMF0aEGjOWZ9tCWWmfUUgaeBFXXIeIguiAfltpFdKHfSov8e3+rNeOrc1/xf4cnjdPHMCdok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gfo9rYzQ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e78f1f41fso11357029e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 23:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705476511; x=1706081311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phJlqIJpEW8SqL09qKW+SfxMOx0V7LTY01BjUv6mizw=;
        b=gfo9rYzQ/WqMd4hz8zb5fjXVhJR99873gDASeDZ7+tK0qnUq0aYwcMPRpL3S0oDYGO
         c/Jrk0wHxyQDrLccgafmgD3HE7DpIDeH2u2kYwQHdg/o5kBe1qOPsHAHrgAMZRG3NNA1
         ANrJZeBZ3Bi5MTA97VfPvvQKDxwfISSnBLTzhRUKOUq0txq0Izu/vEBzno3gzblSQVFs
         DsrgN+G8acDklgChaHxFWND1eoTJy/j9tdnmB2mRbDihdM+kEINu1sGqCVfXFLdloDXd
         rOb2NZv86uVSjD6/8e46BAm1YMA4VuwQle5raujxWRjmSBuTA6Vy6scmRjFvmQrEbe/P
         Zt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705476511; x=1706081311;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phJlqIJpEW8SqL09qKW+SfxMOx0V7LTY01BjUv6mizw=;
        b=Mroogsos6uP1SIVkiasczph6XDZ7pGFCw1YWbLDnmIoXYS/owC57WpfotcfLSA002k
         eXdeqxhXoam4WWj1Ld9AVRmrPUvmv/BZPhoDmC3yLfGa15+HauxJrjFiPXfJ5+mfW91G
         h4K6h+xfI1uCfbqcTj5mg5IHsE6Im6BoNfqlg1wrL82pEFhD2Jdo2ffdheb7ab6DR4O4
         bonUMh4YxMXf4Ck3hBeoGz2hcDKy480yo4MYaKdP/pj7kb5YM8fMR28qCX3P16g0BL2p
         ZFonGQrBH+zCCKAidkU03PYKlFGRxvuejz0on4STAiD4krD4Xbcaac2MYxXh5kmAdbRz
         E33Q==
X-Gm-Message-State: AOJu0YygYQ03w3tPFtqEE9JlkAYmGgyM2Vnxo/Fb/udV5WxxnKOvfciW
	czfLDh5FpMImgm96NaQ/dd1i8HLFUWFkLg==
X-Google-Smtp-Source: AGHT+IH9hHciuhF5K41Lf06HGxi4+feqNSRkmGOauDu7lDWjSuC7ivZ8xszoHdTF7X88kNfD6edNfA==
X-Received: by 2002:a19:6915:0:b0:50e:e779:e6f7 with SMTP id e21-20020a196915000000b0050ee779e6f7mr3247493lfc.122.1705476511610;
        Tue, 16 Jan 2024 23:28:31 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id x25-20020a1709064bd900b00a28f54aacf1sm7458859ejv.185.2024.01.16.23.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 23:28:31 -0800 (PST)
Message-ID: <326dd12e-2d52-4d4c-8197-5d35a0c52cf5@linaro.org>
Date: Wed, 17 Jan 2024 08:28:28 +0100
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
 <007e8c14-13eb-4917-b9da-8d47d6c965c7@linaro.org>
 <CAJRtX8ROH4R_s1=ML5ka340PAE0SWJKK24yVWHw5gCd+7d9pkA@mail.gmail.com>
 <dfcf74a9-db76-43fe-9261-20bf7a993bc3@linaro.org>
 <CAJRtX8Tkie+ykLv8L2EgBQcy9tVP5Yz-_J_eHE-9N9hjt+6gkg@mail.gmail.com>
 <f99da95d-a6ab-4646-8ad8-8245e275639e@linaro.org>
 <CAJRtX8Qxvpf_CTJG41U6JC3_qLL9raFxX3LD0LoPNhve=MDyFA@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAJRtX8Qxvpf_CTJG41U6JC3_qLL9raFxX3LD0LoPNhve=MDyFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/01/2024 04:24, Jingbao Qiu wrote:
> On Wed, Jan 17, 2024 at 12:58 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 16/01/2024 17:29, Jingbao Qiu wrote:
>>> On Wed, Jan 17, 2024 at 12:03 AM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 16/01/2024 16:51, Jingbao Qiu wrote:
>>>>>>> CV1800 is a RISCV based SOC that includes an RTC module. The RTC
>>>>>>> module has an OSC oscillator
>>>>>>
>>>>>>
>>>>>> I am not going to read pages of description. Please write concise replies.
>>>>>
>>>>> Thanks, What I mean is that this hardware includes two functions, RTC
>>>>> and POR. How should I describe their relationship?
>>>>
>>>> Your POR does not need to take any resources, so no need to describe any
>>>> relationship.
>>>>
>>>> ...
>>>>
>>>>>>> Your suggestion is, firstly, the por submodule does not have any
>>>>>>> resources, so it should be deleted.
>>>>>>
>>>>>> So where did you delete it? I still see it in this patch.
>>>>>
>>>>> Should I completely delete him? How can a por driver obtain device information?
>>>>
>>>> Delete completely.
>>>>
>>>> Device information? What is this? We already agreed you don't have any
>>>> resources for POR.
>>>>
>>>> ....
>>>>
>>>>>> Device is only one thing, not two.
>>>>>>
>>>>>>>                     reg = <0x5025000 0x2000>;
>>>>>>>                     interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>>                     clocks = <&osc>;
>>>>>>> };
>>>>>>> However, in reality, the POR submodule does not use IRQ and CLK.
>>>>>>> Please do not hesitate to teach. Thanks.
>>>>>>
>>>>>> I expect one device node. How many drivers you have does not matter: you
>>>>>> can instantiate 100 Linux devices in 100 Linux device drivers.
>>>>>
>>>>> I understand what you mean. A device node corresponds to multiple drivers.
>>>>> Should I completely delete the POR device tree node and add it when
>>>>> submitting the POR driver?
>>>>
>>>> ? I wrote it in previous messages and twice in this thread. Completely
>>>> delete. You do not add it back! Because if you ever intended to add it
>>>> back, it should be added since beginning. I don't understand what
>>>> submitting later would solve.
>>>>
>>>>> If that's the case, how can I explain that the rtc device tree node
>>>>> uses the syscon tag?
>>>>> How can I describe a POR device in DTS? POR is a submodule of RTC, and
>>>>> it also has corresponding drivers.
>>>>
>>>> I said, there is no need for POR in DTS, because you have nothing there.
>>>> Why do you insist on putting it on DTS?
>>>>
>>>>> It's just that his resources are only shared with RTC's Reg.
>>>>
>>>> What resources? Reg? That's not a separate resource.
>>
>> I meant, separate from the RTC. I had impression that IO space is shared
>> or mixed with RTC? If it is separate, why it wasn't listed?
>>
>>>
>>> I'm very sorry about this.
>>> But I found a binding file that only contains Reg and Compatible.
>>>
>>> rtc@80920000 {
>>> compatible = "cirrus,ep9301-rtc";
>>> reg = <0x80920000 0x100>;
>>> };
>>>
>>> Link: Documentation/devicetree/bindings/rtc/cirrus,ep9301-rtc.yaml
>>
>> And?
>>
>>>
>>>>
>>>> To summarize: Drop POR from DTS and never bring it back, unless you come
>>>> with some different arguments, which you did not say already.
>>>>
>>>
>>> You are right, if there is no por device tree node, how can the por
>>> driver obtain the Reg?
>>
>> The same as currently. Does your POR node has reg? No, so according to
>> your logic it cannot obtain address space.
>>
>> Children Linux devices share regmap with parent device.
>>
> 
> Thanks, Power-On-Reset/POR driver requires Reg to complete its functions.
> The compatible of POR is required in DTS to load the corresponding driver.

No, it is not needed. I also wrote to in previous messages to keep
drivers out of this. They are not related to this topic and don't use
them as arguments.


> The POR driver was not submitted in the patch. However, this patch requires
> the addition of RTC in DTS. Considering the future addition of POR

No. Bindings *MUST BE COMPLETE*, not depend on some other drivers.
Submit *COMPLETE* bindings for entire hardware. Then submit complete
DTS. I don't care about the drivers and they do not have to be complete.


> driver, I added a POR node.
> I'm not sure why the POR node needs to be deleted, just because it
> only has the compatible attribute?

This is like a tenth message and I was explaining it multiple times. Go
back to previous emails.

> Or maybe it's because I didn't submit the POR driver, so I need to
> delete the POR node.

Please don't mention drivers anymore in this discussions. It only
confuses you.

> I found an example.
> 
> st: timer@fffffd00 {
>     compatible = "atmel,at91rm9200-st", "syscon", "simple-mfd";
>     reg = <0xfffffd00 0x100>;
>     interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
>     clocks = <&slow_xtal>;
>     watchdog {
>       compatible = "atmel,at91rm9200-wdt";
>     };
> };
> 
> Link:arch/arm/boot/dts/microchip/at91rm9200.dtsi:114
> 
> Like this, when the por driver insmod is activated, the por driver can
> obtain the regs of the parent device.

Example of what? What is the question? I found a bug in Linux, so can I
create such bug again?

This discussion is fruitless and tiresome. You are repeating the same
issues and asking the same questions.

Best regards,
Krzysztof


