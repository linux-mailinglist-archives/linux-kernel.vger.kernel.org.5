Return-Path: <linux-kernel+bounces-136413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D83CD89D3C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511101F22545
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5387E115;
	Tue,  9 Apr 2024 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPeOO70a"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A697E0E8;
	Tue,  9 Apr 2024 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650125; cv=none; b=mozWTxDXiQdI4uldIjfGoKcvoHhYY6GjcOZ+JcXoVQFxRGGnFid+mAXhQolLAYFJpWqEUUHJibsw68oUyR9eRZ7+o5IQ6cY95DEFZpY54kXsBiMPSaDtKgkNn95UeGd0A1A3NN7c8EtJuEVv5jMvFo4JE8K3ZxRCNyXHhp9AUms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650125; c=relaxed/simple;
	bh=5tZM0WszBwnTdBFSaSlC2zyGteF9bXHX900iR0xjfyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9OpxCYAm87wMtBgQET924ePKvrx2lE0X5Zvh/6GOhafX6sHISIAhJs88xZ9H8QLjSPoo5sgM4usQ4JjfvoV2JxyXDIh/uB6uiHXB/xZ0bwci0FVG1ar7SjaEP9y1LBgl1c9MqVshXGrrcQvsd9mSQeo3jGTJRhyclcQ3j5QniI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPeOO70a; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51ddc783e3so208316466b.0;
        Tue, 09 Apr 2024 01:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712650121; x=1713254921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zRVriRNVnSGwNMVRc04UUhD3izNHgR8wyJ94dp6Ab9g=;
        b=EPeOO70aJaacDFpCdYtAiuneKWODPL35nlQ7tj6I/q5e99VXsUEz+/EyuopuGfYNlE
         sV0VkE+7JPTelf3e3cKIwfOaJn25ZXSteNvdx+iuBFsvDrI/lwt2ezOvMc08yMtDxilr
         2Yi+md26baiVysgcm1pPSPGfFi3y7styhWvLVP6ZiNDuwolWdhBGwlid2uMwXY8mn65o
         vrN9zW2dYNXJlh5iZcqmNQL4NkRZoD+kjWVPg6Vxx4lrJX2Ez2GPF8FPgGbYlZ7ERN/W
         QwqUcln9d8WdGBfNYfDjMLP+j6WF64TcFiriVEZxLChdt0KIILFxTGqqQZCMBrkU+xKN
         lvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712650121; x=1713254921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRVriRNVnSGwNMVRc04UUhD3izNHgR8wyJ94dp6Ab9g=;
        b=N5p/wKUU5soYBz+gjHJ7kqcm0FEY4fbuRSceBAyfSiqyX7WGsQpEOuqGfANuKjSHGs
         iRXkavRI6zEzxifFcGPqfoVy7DMLDSVCT9k2kSo4Y28kvwi8rDihOmbYewAm98YkLNoF
         r4YTWzwcyL34DxCLnUi3alH/77yD4yqwzj+fCcnSYXowq2qfHZMTaMT/MGbff3lOi7o0
         5OWjsDSvjT4cVy0tgF3yTHFmAdy86DH09EfC2cI71FuDJYIOJ0t02wmdsK181tnbF+U9
         +oKvgooCxS9raGXedYgCGO7EnyhYo2PeCZwW2ms9WWaxqIN93L5zjnnuPBkc4B+US1Mw
         Nbqw==
X-Forwarded-Encrypted: i=1; AJvYcCXiSBlIqEQz7U2bnYYzb21zI/5Cy8Z3MG98pgfhM2LDlSELJM2hNSYHrAst8KgD5mLequWUy4RQJDFoxvQHsKqUhnIkk9K/YBOljnGQsgsLbEgjoXEtusZ8R/V95L723FVPjbEdpNaSb/Qo1A33ADJ/x8TShLkSJcchkuwPMpUhHVOHXA==
X-Gm-Message-State: AOJu0YwUfIGm19xtE4yekFaPEwZm+ZCLE6jI7Jif6pbyueIadxVw8E6w
	8lDe6Bb34f5geyExLJZPMeUq6a/MmRJpCCi5vC/rhdCJ2FwXUOWN
X-Google-Smtp-Source: AGHT+IHg/Qr8XIpQ+PqdSSvROL0KSEIAhr4x80iLG7ua7op8Ytac3PKsVfLddq7kFHvmvJe6vZmj3w==
X-Received: by 2002:a17:906:f0d6:b0:a4e:23b4:763a with SMTP id dk22-20020a170906f0d600b00a4e23b4763amr5909597ejb.58.1712650120997;
        Tue, 09 Apr 2024 01:08:40 -0700 (PDT)
Received: from [10.76.84.174] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id h5-20020a1709060f4500b00a473774b027sm5335749ejj.207.2024.04.09.01.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 01:08:40 -0700 (PDT)
Message-ID: <64b7fd83-f226-4b1f-a801-0fe1cf20f842@gmail.com>
Date: Tue, 9 Apr 2024 11:08:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
 <20240401-ad4111-v1-1-34618a9cc502@analog.com>
 <CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com>
 <25cb3514-1281-49a8-9e9b-40ead9b050dc@gmail.com>
 <CAMknhBHu8DveBgV3cor8RP2Up4Zs-+QRx7S2aoHZ_3iKiErVjg@mail.gmail.com>
 <20240406155328.447b594f@jic23-huawei>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <20240406155328.447b594f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/04/2024 17:53, Jonathan Cameron wrote:
> On Wed, 3 Apr 2024 10:40:39 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On Wed, Apr 3, 2024 at 2:43 AM Ceclan, Dumitru <mitrutzceclan@gmail.com> wrote:
>>>
>>> On 01/04/2024 22:37, David Lechner wrote:  
>>>> On Mon, Apr 1, 2024 at 10:10 AM Dumitru Ceclan via B4 Relay
>>>> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:  
>>>>>
>>>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>  
>>>
>>> ...
>>>  
>>>>>      properties:
>>>>>        reg:
>>>>> +        description:
>>>>> +          Reg values 16-19 are only permitted for ad4111/ad4112 current channels.
>>>>>          minimum: 0
>>>>> -        maximum: 15
>>>>> +        maximum: 19  
>>>>
>>>> This looks wrong. Isn't reg describing the number of logical channels
>>>> (# of channel config registers)?
>>>>
>>>> After reviewing the driver, I see that > 16 is used as a way of
>>>> flagging current inputs, but still seems like the wrong way to do it.
>>>> See suggestion below.
>>>>  
>>>
>>> This was a suggestion from Jonathan, maybe I implemented it wrong.
> 
> Maybe Jonathan was wrong!  I was younger then than now :)
> 
> However, reg values for child nodes are unique so can't just use a flag these
> need to be different values.
> 

I do not see where the restriction appears when using just the flag, when defining
the channels you would still define unique reg values.

>>> Other alternative that came to my mind: attribute "adi,current-channel".  
>>
>> Having a boolean flag like this would make more sense to me if we
>> don't agree that the suggestion below is simpler.
>>
>>>>>
>>>>>        diff-channels:
>>>>> +        description:
>>>>> +          For using current channels specify only the positive channel.
>>>>> +            (IIN2+, IIN2−) -> diff-channels = <2 0>  
>>>>
>>>> I find this a bit confusing since 2 is already VIN2 and 0 is already
>>>> VIN0. I think it would make more sense to assign unique channel
>>>> numbers individually to the negative and positive current inputs.
>>>> Also, I think it makes sense to use the same numbers that the
>>>> registers in the datasheet use (8 - 11 for negative and 12 to 15 for
>>>> positive).
>>>>
>>>> So: (IIN2+, IIN2−) -> diff-channels = <13 10>
>>>>
>>>>  
>>> It would mean for the user to look in the datasheet at the possible
>>> channel INPUT configurations values, decode the bit field into two
>>> integer values and place it here (0110101010) -> 13 10. This is
>>> cumbersome for just choosing current input 2.  
>>
>> It could be documented in the devicetree bindings, just as it is done
>> in adi,ad4130.yaml so that users of the bindings don't have to
>> decipher the datasheet.
> 
> The <13 10> option makes sense to me and avoids suggesting a common negative
> input.
> 
> The 'fun' bit here is that diff-channels doesn't actually tell us anything.
> So we could just not provide it and rely on documentation of reg = 16-19 meaning
> the current channels?
> 

So a channel without diff-channels defined and reg=16 means IN0+ IN0-?

>>
>>>  
>>>>> +
>>>>> +          Family AD411x supports a dedicated VCOM voltage input.
>>>>> +          To select it set the second channel to 16.
>>>>> +            (VIN2, VCOM) -> diff-channels = <2 16>  
>>>>
>>>> The 411x datasheets call this pin VINCOM so calling it VCOM here is a
>>>> bit confusing.
>>>>  
>>>
>>> Sure, I'll rename to VINCOM.
>>>  
>>>> Also, do we need to add a vincom-supply to get this voltage? Or is it
>>>> safe to assume it is always connected to AVSS? The datasheet seems to
>>>> indicate that the latter is the case. But then it also has this
>>>> special case (at least for AD4116, didn't check all datasheets)
>>>> "VIN10, VINCOM (single-ended or differential pair)". If it can be used
>>>> as part of a fully differential input, we probably need some extra
>>>> flag to indicate that case.
>>>>  
>>>
>>> I cannot see any configuration options for these use cases. All inputs
>>> are routed to the same mux and routed to the differential positive and
>>> negative ADC inputs.
>>>
>>> "VIN10, VINCOM (single-ended or differential pair)" the only difference
>>> between these two use cases is if you connected VINCOM to AVSS (with
>>> unipolar coding) or not with bipolar encoding. The channel is still
>>> measuring the difference between the two selected inputs and comparing
>>> to the selected reference.
>>>  
>>>> Similarly, do we need special handling for ADCIN15 on AD4116? It has a
>>>> "(pseudo differential or differential pair)" notation that other
>>>> inputs don't. In other words, it is more like VINCOM than it is to the
>>>> other ADCINxx pins. So we probably need an adcin15-supply for this pin
>>>> to properly get the right channel configuration. I.e. the logic in the
>>>> IIO driver would be if adcin15-supply is present, any channels that
>>>> use this input are pseudo-differential, otherwise any channels that
>>>> use it are fully differential.
>>>>  
>>>
>>> I cannot seem to understand what would a adcin15-supply be needed for.
>>> This input, the same as all others, enters the mux and is routed to
>>> either positive or negative input of the ADC.
>>>
>>> The voltage on the ADCIN15 pin is not important to the user, just the
>>> difference in voltage between that pin and the other one selected.
>>>  
>>
>> These suggestions come from some recent discussion about
>> pseudo-differential vs. fully differential inputs (e.g. search the IIO
>> mailing list for AD7380).
>>
>> So what I suggested here might be more technically correct according
>> to what I got out of that discussion. But for this specific case, I
>> agree it is good enough to just treat all inputs as always
>> fully-differential to keep things from getting too unwieldy.
> 
> Hmm.  That whole approach to pseudo differential does get messy if
> we have the common line routed through the main MUX rather than an opt
> in only on the negative side.  
> 
> If I read this right, its almost a trick to support a pseudo differential
> wiring with simple registers (I guess reflecting MUX limitations).
> 
> So what could we do?
> 
> We could assume that VINCOM is used like a conventional pseudo
> differential negative signal and have supply-vincom + non diffferential
> channels if that's the configuration wanted.
> 
> Then for differential channels can support all the VINX VINX+1
> and swapped options.
> For VIN10 it gets fun as non differential and differential options
> I think map to same actual config.   Don't see reason we need to express
> that in the binding though so let that have VIN10 VINCOM (probably using
> a magic channel number) and  VIN10 pseudo differential.
> 
> Similar setup for ADCIN15 equivalent usage
> 
> Code wise this probably won't be particular hard to support in the driver
> (obviously I haven't tried though :) is it worth the effort to keep
> it inline with other devices that support pseudo differential channesl.

Then this would need to be done to any fully differential ADC as support
for pseudo differential channels is present (connect a fixed non 0 voltage
to the negative input).

The AD717x family supports pseudo differential channels as well... should
this change be applied to them too? It is just the case that the documentation
does not mentions this use case.

I think that a distinction needs to be made here:
- When a device is only pseudo differential, sure, it is in a different category
- When a device is fully differential and you are using it as pseudo-differential
  you are having two inputs compared to one another

I would need more clarification is why would supply-vincom be a requirement.
The voltage supplied to VINCOM will not be used in any computation within 
the driver. From the perspective of getting the data it doesn't matter if 
you are using the channel in a pseudo-differential, single ended or fully
differential manner.

Regarding VINX VINX+1, it is not mandatory to respect those, from AD4111 page27:
"Due to the matching resistors on the analog front end, the
 differential inputs must be paired together in the following
 pairs: VIN0 and VIN1, VIN2 and VIN3, VIN4 and VIN5, and
 VIN6 and VIN7. If any two voltage inputs are paired in a
 configuration other than what is described in this data sheet,
 the accuracy of the device cannot be guaranteed."

Tried the device and it works as fully differential when pairing any
VINx with VINCOM. Still works when selecting VINCOM as the positive
input of the ADC.

I really see this as overly complicated and unnecessary. These families
of ADCs are fully differential. If you are using it to measure a single ended
(Be it compared to 0V or pseudo differential where you are comparing to Vref/2
and obtaining results [Vref/2 , -Vref/2]) the final result will not require knowing
the common voltage.




