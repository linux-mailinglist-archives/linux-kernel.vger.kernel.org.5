Return-Path: <linux-kernel+bounces-154672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D419E8ADF96
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4E81F21153
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C7553E03;
	Tue, 23 Apr 2024 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEK1GAWo"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017ED51C5B;
	Tue, 23 Apr 2024 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713860334; cv=none; b=Vu3XVFtLt2WWK+9Vn+ZLfGN7a42cQ2bhmLWQYNeJ+FWF3HQ2EBbuSOAYiKoGYDUgfFvXQpQ5Q4FYpMWmhkKmqx0N+xHsEwAKdDy02vx+x5/JBug2i+Cipx2akoimmyrJeTwlKcCymNOtuGZBb7nlDmsCvQ85pX0LIorcV24gqc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713860334; c=relaxed/simple;
	bh=z56yj5ZVxshAPI8aKr0iK34hCkA5WInLmhYgGGIQp7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnxmXfgWza/nTT4gdPhR5N32McgzSZsfa9//ctwzWIzLgob4qIcFUjMKyP/0kc1RXOKg0JF+6FwXOQM0BFEKQ/pY8WZOrhdr+jCHgcwFUgPm6KVo5nv+trm1CbZ95CkdASMYlKL0E3+UrujYngxaRqfxTWJwruwwRrc9203zdXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEK1GAWo; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-69943ef42b2so33606496d6.3;
        Tue, 23 Apr 2024 01:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713860332; x=1714465132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rePL8arm4LivdQFrFbW0CeWxONyu2nrt0vpkmUqCS20=;
        b=KEK1GAWoha91Bkua79NtUGmfhG0gk1ecQPFPdwEVUQfL16f9GGCilKnu3/4KyNq5Bk
         jFnUuoyUt6V4NtBL1ijA1nnNJFm252ySwPuTX3nnL3EoHA5C/YZ1T/Grv9yCVP9mWuLB
         PdzSVdXFd7aRMaV3UzGZxbKcNzLZm0TV0N7BxoXN62mDblaupXWxX6vXQ/AoeN/6X7w4
         THsaLqPbkR1Pnmz9wMsPuYF5mdwfo6OuBpSrOtK9NyWNrR0lKudPN+1Ld7PjlX4Ekrtc
         WesFtVcVy8V/KNIS3dHMo3nwPCjjBT9pb45jcLmUxlvnSMSoJaPQGqnhsxASXeHeQ+/m
         3nwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713860332; x=1714465132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rePL8arm4LivdQFrFbW0CeWxONyu2nrt0vpkmUqCS20=;
        b=NHGrZ0sdONeClOUw0RrA/qLwogWAoI/npdJmXfm/HVDKpNs6Ii49xgZ0SfwZi6Wm/B
         Ne1nzu7pM6CeLwXXBz7DAIxk4V2VfDMGMX5NYIcSLxZMtAoVDIEelm6xhcgMwES22gGp
         0szD90VS13Kx4H5jgAV7jz43Vs0mM+jULlR3wa6Ur+p3kM70BF+6Wvgh7aw4n5RnafOO
         QFncI4ggYtTCdfN0VqDgDN8LJler3taF9Mb7ng+uROa+kguhWV7weeK20GJ5GJ3Sp/tM
         1ew8+xC44rLxecuGcb9KVn0Wl9h2kdrbKAkhuugScr93sgrmyRl/mhsok983Rl6zm6hG
         cgnw==
X-Forwarded-Encrypted: i=1; AJvYcCWbxvZ9pT5qohxBSrTsAQ3lu1ePzk+X077uzRaeGuEhL69ROW1DNiLG36D6uRgc/Rtl5F71WFcdEeDSHSbKFX9P+D4w+IkMLe+Oe9WcY9kEWsfMZWnYHJcQ/44IQq3FxbW8giBli6R4jQ4QpWIggtoxaIcgc+q3ONJnsHyqeSLZo9CDdQ==
X-Gm-Message-State: AOJu0YwWg3C/vfB7R2IwoYqpoQgkuUtzb3sCZepFBF5Ei8eF4txvRaiN
	/rLM+YkVOyiktJajrFkTMELm51487b3fO/Glq/fQVKE80GDOLF8M
X-Google-Smtp-Source: AGHT+IHKUQ/D0/F3Y5jftvGNKvWZAzyEDw0VDEkZR0aE6k/dZN4+dM4bLU8kVk/dOE5F1rea/b/mzg==
X-Received: by 2002:a05:6214:b2f:b0:6a0:8dc4:8174 with SMTP id w15-20020a0562140b2f00b006a08dc48174mr565824qvj.44.1713860331616;
        Tue, 23 Apr 2024 01:18:51 -0700 (PDT)
Received: from [10.76.84.174] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id i8-20020a0cf388000000b0069b7bc51271sm4930487qvk.123.2024.04.23.01.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 01:18:50 -0700 (PDT)
Message-ID: <681f3bfb-76d0-41a8-82b5-6d27641c24b6@gmail.com>
Date: Tue, 23 Apr 2024 11:18:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com,
 Lars-Peter Clausen <lars@metafoo.de>,
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
 <64b7fd83-f226-4b1f-a801-0fe1cf20f842@gmail.com>
 <20240413114825.74e7f3fa@jic23-huawei>
 <89e93f4d-e569-46ee-802d-a1668a01b882@gmail.com>
 <20240420153310.7876cb8a@jic23-huawei>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <20240420153310.7876cb8a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/04/2024 17:33, Jonathan Cameron wrote:
> On Mon, 15 Apr 2024 21:42:50 +0300
> "Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:
> 
>> On 13/04/2024 13:49, Jonathan Cameron wrote:
>>> On Tue, 9 Apr 2024 11:08:28 +0300
>>> "Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:
>>>   
>>>> On 06/04/2024 17:53, Jonathan Cameron wrote:  
>>>>> On Wed, 3 Apr 2024 10:40:39 -0500
>>>>> David Lechner <dlechner@baylibre.com> wrote:
>>>>>     
>>>>>> On Wed, Apr 3, 2024 at 2:43 AM Ceclan, Dumitru <mitrutzceclan@gmail.com> wrote:    
>>>>>>>
>>>>>>> On 01/04/2024 22:37, David Lechner wrote:      
>>>>>>>> On Mon, Apr 1, 2024 at 10:10 AM Dumitru Ceclan via B4 Relay
>>>>>>>> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:      
>>>>>>>>>
>>>>>>>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>      
>>>>>>>  

..
 
>>>>
>>>> The AD717x family supports pseudo differential channels as well... should
>>>> this change be applied to them too? It is just the case that the documentation
>>>> does not mentions this use case.  
>>>
>>> Maybe you could argue that if we used the REF- for the negative input.
>>> Otherwise I think it falls into the category where there isn't a clearly defined
>>> pseudo differential mode.
>>>   
>>
>> While re-reading docs I've noticed that AD7176-2 mentions pseudo differential usage:
>> "Pseudo Differential Inputs
>>  The user can also choose to measure four different single-ended
>>  analog inputs. In this case, each of the analog inputs is converted
>>  as being the difference between the single-ended input to be
>>  measured and a set analog input common pin. Because there is
>>  a crosspoint multiplexer, the user can set any of the analog inputs
>>  as the common pin. An example of such a scenario is to connect
>>  the AIN4 pin to AVSS or to the REFOUT voltage (that is, AVSS
>>  + 2.5 V) and select this input when configuring the crosspoint
>>  multiplexer. When using the AD7176-2 with pseudo differential
>>  inputs, the INL specification is degraded."
>>
>> As the crosspoint mux is present on all models it really makes me think that this
>> paragraph applies to all models in the family
> 
> Interesting indeed.  So is your thinking that we need to support this
> or take that "degraded" comment to imply that we should not bother
> (at least until someone actually shouts that they want to do this?)
> 

 My perspective is that support for this is already existent, the chips do not
need any special configuration in that use-case. If we want to be correct in
how the channel will be presented to the user, besides setting to false the IIO
differential flag I do not see what else should be done.

>>
>>>>
>>>> I think that a distinction needs to be made here:
>>>> - When a device is only pseudo differential, sure, it is in a different category
>>>> - When a device is fully differential and you are using it as pseudo-differential
>>>>   you are having two inputs compared to one another
>>>>
>>>> I would need more clarification is why would supply-vincom be a requirement.
>>>> The voltage supplied to VINCOM will not be used in any computation within 
>>>> the driver. From the perspective of getting the data it doesn't matter if 
>>>> you are using the channel in a pseudo-differential, single ended or fully
>>>> differential manner.  
>>>
>>> I'd missed until now that the datasheet (I looked ad4114) says aincomm should be connected to analog
>>> ground so indeed nothing to turn on in this case and no offset to supply
>>> (the offset will be 0 so we don't present it).
>>>
>>> I'll note the datasheet describes the VINCOM as follows.
>>>
>>> Voltage-Input Copmmon. Voltage inputs are reference to VINCOM when the inputs are configured
>>> as single-ended.  Connect AINCOM to analog ground.
>>>
>>> The reference to single ended is pretty clear hint to me that this case
>>> is not a differential channel. The more complex case is the one David
>>> raised of the AD4116 where we have actual pseudo differential inputs.
>>>   
>>
>> Alright, from my perspective they all pass through the same mux but okay,
>> not differential. The only issue would differentiating cases in AD4116 where
>> the pair VIN10 - VINCOM is specified as single-ended or differential pair.
>>
>> Also, AD4116:
>> "0101101111 ADCIN11, ADCIN15. (pseudo differential or differential pair)
>>  0110001111 ADCIN12, ADCIN15. (pseudo differential or differential pair)
>>  0110101111 ADCIN13, ADCIN15. (pseudo differential or differential pair)
>>  0111001111 ADCIN14, ADCIN15. (pseudo differential or differential pair)"
>>
>> Not really sure where the "actual pseudo differential" sits.
>>
>> Would you agree with having device tree flags that specifies how is the
>> channel used: single-ended, pseudo-differential, differential.
>> For the first two, the differential flag will not be set in IIO.
> 
> Yes. I think that makes sense - though as you observe in some cases
> the actual device settings end up the same (the ad4116 note above).
>
 This precisely why I suggest this approach, because a channel used as
single-ended, pseudo or fully differential will have the same register
configuration on all models. I do not see any other way to know from
the driver this information.

> If a given channel supports single-ended and pseudo-differential is
> that really just a low reference change (I assume from an input to the
> the IO ground)? Or is there more going on?
> 
 I'm not sure if I understood what was said here. The reference specified
in the channel setup does not need to change.

> If it's the reference, then can we provide that as the binding control
> signal?  We have other drivers that do that (though we could perhaps make
> it more generic) e.g. adi,ad7124 with adi,reference-select
>  We already have adi,reference-select in the binding and driver, I do not
see how it could help the driver differentiate between (single, pseudo...)

> I don't like that binding because it always ends up have a local enum
> of values, but can't really think of a better solution.
>

>>
>>>>
>>>> Regarding VINX VINX+1, it is not mandatory to respect those, from AD4111 page27:
>>>> "Due to the matching resistors on the analog front end, the
>>>>  differential inputs must be paired together in the following
>>>>  pairs: VIN0 and VIN1, VIN2 and VIN3, VIN4 and VIN5, and
>>>>  VIN6 and VIN7. If any two voltage inputs are paired in a
>>>>  configuration other than what is described in this data sheet,
>>>>  the accuracy of the device cannot be guaranteed."  
>>>
>>> OK, but I'll assume no 'good' customer of ADI will do that as any support
>>> engineer would grumpily point at that statement if they ever reported
>>> a problem :)
>>>   
>>>>
>>>> Tried the device and it works as fully differential when pairing any
>>>> VINx with VINCOM. Still works when selecting VINCOM as the positive
>>>> input of the ADC.
>>>>
>>>> I really see this as overly complicated and unnecessary. These families
>>>> of ADCs are fully differential. If you are using it to measure a single ended
>>>> (Be it compared to 0V or pseudo differential where you are comparing to Vref/2
>>>> and obtaining results [Vref/2 , -Vref/2]) the final result will not require knowing
>>>> the common voltage.  
>>>
>>> For single ended VINCOM should be tied to analog 0V.  If the chip docs allowed
>>> you to tie it to a different voltage then the single ended mode would be offset
>>> wrt to that value.
>>>
>>> For the AD4116 case in pseudo differential mode, You would need an ADCIN15 supply because
>>> that is not connected to analog 0V.  If the device is being used in a pseudo differential
>>> mode that provides a fixed offset voltage.
>>>
>>> So my preference (though I could maybe be convinced it's not worth the effort)
>>> is to treat pseudo differential as single ended channels where 'negative' pin is
>>> providing a fixed voltage (or 0V if that's relevant).  Thus measurements provided
>>> to userspace include the information of that offset.
>>>   
>>
>> What do you mean by offset? I currently understand that the user will have
>> a way of reading the voltage of that specific supply from the driver. 
> 
> How?  We could do it that way, but we don't have existing ABI for this that
> I can think of.
> 
Expose a voltage channel which is not reading from the device...but that is
too much of a hack to be accepted here
>>
>> If you mean provide a different channel offset value when using it as
>> pseudo-differential then I would disagree
> 
> Provided to user space as _offset on the channel, userspace can either
> incorporate it if it wants to compute absolute (relative to some 0V somewhere) value
> or ignore it if it only wants the difference from the reference value.
> 
> I'm open to discussion other ABI options, but this is the one we most naturally have
> available.
_offset is already used when the bipolar coding is enabled on the channel
and is computed along datasheet specifications of how data should be processed,
this is why I disagree with this.

This feels over-engineered, most of the times if a channel is pseudo
differential, the relevant measurement will be the differences between
those two inputs.

If a user needs to know the voltage on the common input, he just needs to
also configure a single ended channel with the common input where the
negative AIN is connected to AVSS.
>>
>>
>>> We haven't handled pseudo differential channels that well in the past, but the
>>> recent discussions have lead to a cleaner overall solution and it would be good
>>> to be consistent going forwards.  We could deprecate the previous bindings in
>>> existing drivers, but that is a job for another day  (possibly never happens!)
>>>   
>>
>> I really hope that a clean solution could be obtained for this driver as well :) 
> 
> I bet you wish sometimes that you had easier parts to write drivers for! :)
> These continue to stretch the boundaries which is good, but slow.
> 
> Jonathan

Not easier, fewer crammed into the same driver :)


