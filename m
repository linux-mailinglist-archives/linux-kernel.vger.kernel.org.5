Return-Path: <linux-kernel+bounces-105860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C88ED87E5A2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DEA428128A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30B42C1A2;
	Mon, 18 Mar 2024 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="as5ctwoT"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D029C2C688
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753808; cv=none; b=p1M+m6GhjgXGrGHxVmQsQV7g85qH1hDWmKEXxzo6cmda+azwk/bZziBJUnV1EKHDTXL1n4hT9N9h22Wv9OyVOD7nQaCs/mm8T3nZMgp1VauGp5IngfvvlO9pJgThQ8HOsFXj9CqfFl3msbSzy+mbuI1ZhHGMSCEUB+zlCvlhkk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753808; c=relaxed/simple;
	bh=G2/dGPQHTsouT6SIKS6kEPyTyi7iG8TB8hc9yD1KxMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuBH1RKb1LWY6F85cIKTD4NwfvhDKZJOa4uNGA2FYRnGSCUYklRrT8rODBnSwNkIhXkdfAXSx0gH0x8hkOLhf0DtY3g+mye26YaOSjGL1eJ8F2yhzY3nSwAqCgswadPiAlaFtdWgz4XYmgYSDjzR7lrzOEG6ntqEHJv8hp8xtIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=as5ctwoT; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a46805cd977so391023666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 02:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710753805; x=1711358605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tB1Pb2tlLh6YNrZFH5WUvlCJhiEA56vnslfaevBVe4A=;
        b=as5ctwoTNdc1YA7l820QvGugIDhqgB5mr25YVU9UnbImh7ErwluPR2E5X0aQZeqBgP
         IdwyBOyqc/yJmOeZiF57VEMLG+EorDDyRk+u3NT/RuWB9YY//b4beymXM8Ir4J+ZUOSU
         LgGcVsFQ8+XCet/BG9bm9+QWqKDLQN20zqEt8LVQKh/8KyawNA95twMBx8SjcLhN3Y4w
         2pTHE4l26F4tihLqXMABSbkrBwtwWKVZ7zfno9NVZqdTym9uiGE9lGIk+7ArOeUYl9F1
         O66afoJ1eWTyJrXDn5HPYNbP8e9d/ddLrWubKNvf/Q5290fkMyyLdBtg5vkVZ4Xu3iop
         z3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710753805; x=1711358605;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tB1Pb2tlLh6YNrZFH5WUvlCJhiEA56vnslfaevBVe4A=;
        b=wjI1c7yZ0EbW4avw8AiZSITpECa4loLcro7p5tMVbde20pEOanWbceR0vUbPzCTzjx
         JBqkCVYM8gmYNCBSTtPTEZbHUPDj98zOzfDbn/lazxHvgHq2j5Jj4uN1jGFCZkNAxrC6
         h+uVHZF2l4j2m2qpA4QR7E2oY+IX9OueDF0doKdTaKbz5Jp8IdWXsDzCH3b2yrDcsRhq
         qrYS6DBypRiDQrVNQnxm/nuVEyVQBNdGEuikFCxP++Y2WCbYiqmZ+a7GOLpxg6am2jyC
         ufpbr7MQoYq29VTLuQoQD5B4Hcgrgvh81NGwjcoioSe+HBx5ufOKcqJ9sSpxtUqsePeQ
         iEbA==
X-Forwarded-Encrypted: i=1; AJvYcCV4AsHgbAXkvLeCwh7rYPyzpCm7zmrQ4lRh+Qwsn1gP1yDTv6QYItZEBCVhMbLfgOZx1UN1yBuhqqAAIp09zTVfFcr86JCeH+I2abTt
X-Gm-Message-State: AOJu0Yxu3eGkaH35/bP+yqH/A9/qfcZCqr1FrgdimurjOi61dxubpbNO
	j14HKDWxU+8vnlbDkJ4rS8Tn7K33+TZsdh9iL41dVHanqb1pViRVexb7/S+VHxY=
X-Google-Smtp-Source: AGHT+IFfKgN3fKN/toMx8ietVToFXwqCqDevicEP6FQmK+6HM9KS7j35zgkmTVEAg2/FjcDuOLtWBw==
X-Received: by 2002:a17:907:724a:b0:a46:8856:e6bf with SMTP id ds10-20020a170907724a00b00a468856e6bfmr7130014ejc.44.1710753805202;
        Mon, 18 Mar 2024 02:23:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id cu2-20020a170906e00200b00a4660b63502sm4696764ejb.12.2024.03.18.02.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 02:23:24 -0700 (PDT)
Message-ID: <18327bbe-10ad-4b39-ab70-2f74f0d4fb08@linaro.org>
Date: Mon, 18 Mar 2024 10:23:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] mips: dts: ralink: mt7621: improve DTS style
Content-Language: en-US
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
 <CAMhs-H9ZO-sitsrASuvsEd+ddwVyHH35gj7yAABTqFNfOCGYYw@mail.gmail.com>
 <60512ae2-dd73-4cb6-9514-145f946300fc@linaro.org>
 <5d6c36cb9dd9afda1efb69aa34058517@risingedge.co.za>
 <adefc3ff-86a5-4af7-8276-73d0e0108901@linaro.org>
 <26633d73360e43b2c548f49e544472ea@risingedge.co.za>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <26633d73360e43b2c548f49e544472ea@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/03/2024 16:43, Justin Swartz wrote:
> On 2024-03-17 17:29, Krzysztof Kozlowski wrote:
>> On 17/03/2024 16:22, Justin Swartz wrote:
>>> On 2024-03-17 17:10, Krzysztof Kozlowski wrote:
>>>> On 16/03/2024 16:49, Sergio Paracuellos wrote:
>>>>> On Sat, Mar 16, 2024 at 5:54 AM Justin Swartz
>>>>> <justin.swartz@risingedge.co.za> wrote:
>>>>>>
>>>>>> This set of patches was created with the intention of cleaning up
>>>>>> arch/mips/boot/dts/ralink/mt7621.dtsi so that it is aligned with
>>>>>> the Devicetree Sources (DTS) Coding Style [1] [2] guide.
>>>>>>
>>>>>> [1] Documentation/devicetree/bindings/dts-coding-style.rst
>>>>>>
>>>>>> [2] 
>>>>>> https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
>>>>>>
>>>>>> Justin Swartz (14):
>>>>>>   mips: dts: ralink: mt7621: reorder cpu node attributes
>>>>>>   mips: dts: ralink: mt7621: reorder cpuintc node attributes
>>>>>>   mips: dts: ralink: mt7621: reorder mmc regulator attributes
>>>>>>   mips: dts: ralink: mt7621: reorder sysc node attributes
>>>>>>   mips: dts: ralink: mt7621: reorder gpio node attributes
>>>>>>   mips: dts: ralink: mt7621: reorder i2c node attributes
>>>>>>   mips: dts: ralink: mt7621: reorder spi0 node attributes
>>>>>>   mips: dts: ralink: mt7621: move pinctrl and sort its children
>>>>>>   mips: dts: ralink: mt7621: reorder mmc node attributes
>>>>>>   mips: dts: ralink: mt7621: reorder gic node attributes
>>>>>>   mips: dts: ralink: mt7621: reorder ethernet node attributes and
>>>>>> kids
>>>>>>   mips: dts: ralink: mt7621: reorder pcie node attributes and
>>>>>> children
>>>>>>   mips: dts: ralink: mt7621: reorder pci?_phy attributes
>>>>
>>>> These are all simple cleanups for the same file. It's one patch, not
>>>> 15.
>>>
>>> I agree these are all simple cleanups.
>>>
>>> Even though the cleanup pattern was the same, or very similar,
>>> for each node affected, the intention was to isolate each change
>>> to a single node (or a grouping of nodes of that seemed logical
>>> to me) so that if anyone had any objections, the discussion would
>>> be easier to follow in subthreads identifiable by patch names (and
>>
>> Objections to what? Coding style? Coding style is defined so you either
>> implement it or not... and even if someone disagrees with one line 
>> swap,
>> why it cannot be done like for every contribution: inline?
> 
> I had been asked to include empty lines when I had left them out when
> I had contributed a patch regarding the serial nodes, which resulted in
> a second version of that patch.

I don't understand why would that matter. It's expected Linux
development process to receive comments inline in the patch.

> 
> 
>> Organize your patches how described in submitting patches: one per
>> logical change. Logical change is to reorder all properties in one 
>> file,
>> without functional impact.
> 
> If I had accidentally deleted or modified an attribute in the process
> of cleanup, this could have had a functional impact. It's easier to

How is it relevant? But you did not and splitting simple cleanup
one-line-per-patch is not affecting this. Just because you could make
mistake it does not affect patch readability at all.

Nothing improved with your patch split.


> notice this sort of omission when the wall of text you're confronted
> with is as small as possible, and not multiple pages long.

We are used to handle some length of patches. Multiple scrolls for
obvious cleanups are not problems. Why aren't you applying this approach
to everything? Add a new driver with one function per patch and then
finally Makefile? It would be bisectable and "easy to read" plus
absolutely unmanageable.

> 
> 
>>> But if there're no objections and it lessens the burden on
>>> maintainers upstream to have less patches to apply, then I have no
>>> problem combining them into a single patch.
>>>
>>
>> Yeah, one review response instead of 14 responses... One commit in the
>> history instead of 14.
> 
> I agree that 1 commit vs 14 is better.
> 
> But for future reference: is it not enough for the Reviewed-by: trailer
> to be sent in response to the cover letter of a patch set if a reviewer
> has looked at the entire set?

Sure, one can. I still need to open and download 14 patches.


Best regards,
Krzysztof


