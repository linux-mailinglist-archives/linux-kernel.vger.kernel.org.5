Return-Path: <linux-kernel+bounces-27602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF92B82F2CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ABF3287491
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A952E1CABE;
	Tue, 16 Jan 2024 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7jY/vIK"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282091CF83
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705424336; cv=none; b=FuGM2jaAnIPYaPb0ybeAGaKVtbQVvZWYavdLVicIk8LFJ4TLw2MFgtYV469jpepQhSCWJXIzcYHRtNgBwfuXs0BVxW0BMDmmYTo+3A+n2FI+doiF4UBXI3R4kkBuj9TcDE474rgPAwK26B7dbxNl3JnlcXe9pMdXCx4aclU6naU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705424336; c=relaxed/simple;
	bh=gcXcjopMWR5DqoKpPfgcIHWzFHgpzOizG/IvJSBvb0c=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=XQqgvYo+PFp9IZvUiZdiDL4tIkHPL++i5QR/A62lkh3yI2+F1tsvpJFOQNDLCAx46k0CtyKtB2F0exDJ8siYkSbNs1cvME9d9eZTc1mxaazp17tONqFfMVe6pwg8KW+MO1STJCQzICYustxnt0fMAy/W6jfPod+py6xXf5W33gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h7jY/vIK
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2eac2aae6cso11418466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 08:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705424333; x=1706029133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3VGcJoUzgugAcMhoIstgiUVP/tM57SrNlpYbezL9TQU=;
        b=h7jY/vIK7rc+QJYw43Ps+aLXce/uzSRDxGYU4vDYScJu5TK0kPc8JBf6YmkebZGeU7
         GOg6T//EPQQOFozKR9jpck2Ra5XrApV/uF3+qp3B3VOuUW41fnj+KYpxMSQRrdoNsnRi
         Ty9n2MhIrpBNxLREWwl4lDFFUNodpfjvJ9SzhEUc+S5gwnnZ1Hh+cRo5IMMvbYAPbcwn
         4fyawZbulDEL5wbufWmA6CCNHVF5BjAT3JXBfpyfZ7HySgLgKdCrEmXdSKQ3yK2VtD/4
         5M9Q1de4/AqVACrsRarJL1cPMTvO6x72yDSL13+Y6x17nQqRQZWw82+iAmQ4BLAj2KTe
         EmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705424333; x=1706029133;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3VGcJoUzgugAcMhoIstgiUVP/tM57SrNlpYbezL9TQU=;
        b=e8oRJeXz2qxhAoAOeZC7v2crcLqqei7GDUr94aCRkD6ZmrZEuf3nV1vfhioOnA/MEq
         g4VipuWCaQhJMk7ElAQFstcJGVByEvT2CTnD9j2FYRaqxf3wNWszAKVkB/ibioatGEDT
         UuNNAughHPgGTNjKmQ3EnqZeggPgp4B1UL4JzjfgX4hqlaSA8525G62dz4wsW63t5J0Q
         K6hiw6T91HWSo8hYWksi4UUfHdbWirRszF84juqJgvydJ8foynp45EmhiGx2/zmrUEAS
         5VTh6ZMziXEjLx3bjgdW3KuYQB/TltbNUYQ7bZEZnvDilq7WiWbEjD3j5EPgnnn1qVed
         fehA==
X-Gm-Message-State: AOJu0Yz36hhigoAnEqpYu3RnmzyMxlqcmAOkW6n1mSaGcHSmVROoFuBB
	H4EdSFsrHbRCWggCieAMXn3iifE9MDlSxg==
X-Google-Smtp-Source: AGHT+IHDJAbuoMnXsElq0dBlX+uCvt4Z6cr9rlNAFNuN/+MrNZBVWDhbT+Xrf9hqTQbd5B3Bp8hk9g==
X-Received: by 2002:a17:906:18ea:b0:a28:da64:ac06 with SMTP id e10-20020a17090618ea00b00a28da64ac06mr3906828ejf.73.1705424333188;
        Tue, 16 Jan 2024 08:58:53 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id m23-20020a17090607d700b00a233efe6aa7sm6693928ejc.51.2024.01.16.08.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 08:58:52 -0800 (PST)
Message-ID: <f99da95d-a6ab-4646-8ad8-8245e275639e@linaro.org>
Date: Tue, 16 Jan 2024 17:58:49 +0100
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAJRtX8Tkie+ykLv8L2EgBQcy9tVP5Yz-_J_eHE-9N9hjt+6gkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/01/2024 17:29, Jingbao Qiu wrote:
> On Wed, Jan 17, 2024 at 12:03 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 16/01/2024 16:51, Jingbao Qiu wrote:
>>>>> CV1800 is a RISCV based SOC that includes an RTC module. The RTC
>>>>> module has an OSC oscillator
>>>>
>>>>
>>>> I am not going to read pages of description. Please write concise replies.
>>>
>>> Thanks, What I mean is that this hardware includes two functions, RTC
>>> and POR. How should I describe their relationship?
>>
>> Your POR does not need to take any resources, so no need to describe any
>> relationship.
>>
>> ...
>>
>>>>> Your suggestion is, firstly, the por submodule does not have any
>>>>> resources, so it should be deleted.
>>>>
>>>> So where did you delete it? I still see it in this patch.
>>>
>>> Should I completely delete him? How can a por driver obtain device information?
>>
>> Delete completely.
>>
>> Device information? What is this? We already agreed you don't have any
>> resources for POR.
>>
>> ....
>>
>>>> Device is only one thing, not two.
>>>>
>>>>>                     reg = <0x5025000 0x2000>;
>>>>>                     interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
>>>>>                     clocks = <&osc>;
>>>>> };
>>>>> However, in reality, the POR submodule does not use IRQ and CLK.
>>>>> Please do not hesitate to teach. Thanks.
>>>>
>>>> I expect one device node. How many drivers you have does not matter: you
>>>> can instantiate 100 Linux devices in 100 Linux device drivers.
>>>
>>> I understand what you mean. A device node corresponds to multiple drivers.
>>> Should I completely delete the POR device tree node and add it when
>>> submitting the POR driver?
>>
>> ? I wrote it in previous messages and twice in this thread. Completely
>> delete. You do not add it back! Because if you ever intended to add it
>> back, it should be added since beginning. I don't understand what
>> submitting later would solve.
>>
>>> If that's the case, how can I explain that the rtc device tree node
>>> uses the syscon tag?
>>> How can I describe a POR device in DTS? POR is a submodule of RTC, and
>>> it also has corresponding drivers.
>>
>> I said, there is no need for POR in DTS, because you have nothing there.
>> Why do you insist on putting it on DTS?
>>
>>> It's just that his resources are only shared with RTC's Reg.
>>
>> What resources? Reg? That's not a separate resource.

I meant, separate from the RTC. I had impression that IO space is shared
or mixed with RTC? If it is separate, why it wasn't listed?

> 
> I'm very sorry about this.
> But I found a binding file that only contains Reg and Compatible.
> 
> rtc@80920000 {
> compatible = "cirrus,ep9301-rtc";
> reg = <0x80920000 0x100>;
> };
> 
> Link: Documentation/devicetree/bindings/rtc/cirrus,ep9301-rtc.yaml

And?

> 
>>
>> To summarize: Drop POR from DTS and never bring it back, unless you come
>> with some different arguments, which you did not say already.
>>
> 
> You are right, if there is no por device tree node, how can the por
> driver obtain the Reg?

The same as currently. Does your POR node has reg? No, so according to
your logic it cannot obtain address space.

Children Linux devices share regmap with parent device.

Best regards,
Krzysztof


