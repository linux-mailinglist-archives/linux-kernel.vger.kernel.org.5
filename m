Return-Path: <linux-kernel+bounces-129203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BAF8966E5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502B328299B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC06E5C8FC;
	Wed,  3 Apr 2024 07:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbSpXmYi"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97C134B2;
	Wed,  3 Apr 2024 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130241; cv=none; b=F4PA/UDjKcME/YeKfU0uXWwM6GUIaqvCs+VvkHt+mZVEp2bWRMvx1feY6TOpmXvgufaVC5Q5BLBcKuAzzawFqN5GNNR3vrFudLgF9lDjYReFeT2zTCRKFiMlekYyWy3n/qjEcPT/2irlyHHC9YxlBXwnlEI/1I64pwX/NoVggAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130241; c=relaxed/simple;
	bh=e3t9zjlNN7lMpcgVQa8hVR1LWgE1GZy3kR3rHeZvTng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rj9M3vXEZAe/QJ9m2Jpno1WjvfrZk2PNq6DEDwX7wSNZ7woEhohiFZKzV2XolGs+9pl/XiwWiNiCxQ0lJcBbnNlu8cpN6ymhsOMw/1fNSf/r8FpI48nTjd2YY/ba7Xl9qQb94n43zmiK+PGhm2dffjjxjR1oGyR5CB7gb7p0rVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbSpXmYi; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6964b1c529cso47876456d6.0;
        Wed, 03 Apr 2024 00:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712130238; x=1712735038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Ux9k5McjqhlPIuN+KstHyOqxhkxEP4+HV0vR18vMAY=;
        b=cbSpXmYicUyCtxXtTmcd1wN95IbNEzgDnvFXOFtbgRGpAknDWuUErTtsXeHbk48ZAu
         eRMzDFzHRB5E5otlAx0U0shNc7r1yOf40P0TXsJXtGruKCiVmtSdmjPUFhBa2OG/VHz2
         D8QN0/tvzt1UvdvEklYKE7UWyQ/N1Xob5hgXswLJ/3IXE8ZiSe7WAkbXCp5rciFpPuBd
         /fPi02M1zCENu8iHEygfh8ceLSMqxjICbNrbR450Rm5CnaPKj+b4PZw2v66eHaQK6fem
         /Vb+tJVMgyhqlDEc0wxBXDO5HzD4Qd0BtgU+FCFfDs6LRFXHXgWNDxy3B7Vjts7+TG2b
         yGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712130238; x=1712735038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ux9k5McjqhlPIuN+KstHyOqxhkxEP4+HV0vR18vMAY=;
        b=AnQ5t9aj050+gCiX+C1X++KQHoQ2ZL43TBNzuaZTREhANLj227phZNlb6adLZYwq0i
         BU/37Xecrbu9sQoMQ8OeI6CDKVtvoJ+OpMXbWs+5KcSPg1UPrz8bGJ+qaWgH9kUSEF++
         sMm3zEKycc3g5id4XGNVL7SX4PFlNSffrJ4ntfiVBAY2v3dxVaI0tIAlRD8io+kVySvf
         JXO2cCPskH4jAvtsdyVPHBhWVkdi6CluR+WzutvPR1ZGnUtCpRDIFZWQCVryjriQxXbD
         ny9HifWkHcEi5KAKDJatYb1gyZ7BqcZCg4YMiHE29wChEp618uMrYFrjC3U9JodbitDy
         J8WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF3TGDqJ8wSd8ScxAOX3xjtB9zJYDrxU6LuI8MUnnQEC1vaRo/P/WMKJZsTs0oYJBoC4IVY/C1RxlEcl/vCuJh2vh4ThrdYPTbrvMRK2rrC/VkKPSy3ogVjHK199lpekBWX1rFkJ5yFaJpV+0hU958JFyNR4UKlt4YsgDVhEls5Qxv1A==
X-Gm-Message-State: AOJu0YySfUC13b6Oh2HL9LUHSqS7ZHWfMWr5pwYeF3XNy6mmAGOgUqT5
	CpjylUWuCjbeLQ80paRYk9iRzJJW8j0dnacLfrigMxHtqNQuEWiz
X-Google-Smtp-Source: AGHT+IF5FzGdZz/vRvTqaJSoRKJCV3p7jBbJbgvySg/1C0YGLk+Ra3JUK0YhO7JLZAbnS20NFHj5Lg==
X-Received: by 2002:a0c:c591:0:b0:698:f5b6:6595 with SMTP id a17-20020a0cc591000000b00698f5b66595mr13210825qvj.55.1712130238060;
        Wed, 03 Apr 2024 00:43:58 -0700 (PDT)
Received: from [10.76.84.174] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id pi10-20020a0562144a8a00b0069903cddc96sm1150539qvb.18.2024.04.03.00.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 00:43:57 -0700 (PDT)
Message-ID: <25cb3514-1281-49a8-9e9b-40ead9b050dc@gmail.com>
Date: Wed, 3 Apr 2024 10:43:54 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
To: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
 <20240401-ad4111-v1-1-34618a9cc502@analog.com>
 <CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/04/2024 22:37, David Lechner wrote:
> On Mon, Apr 1, 2024 at 10:10 AM Dumitru Ceclan via B4 Relay
> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>>
>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>

..

>>      properties:
>>        reg:
>> +        description:
>> +          Reg values 16-19 are only permitted for ad4111/ad4112 current channels.
>>          minimum: 0
>> -        maximum: 15
>> +        maximum: 19
> 
> This looks wrong. Isn't reg describing the number of logical channels
> (# of channel config registers)?
> 
> After reviewing the driver, I see that > 16 is used as a way of
> flagging current inputs, but still seems like the wrong way to do it.
> See suggestion below.
> 

This was a suggestion from Jonathan, maybe I implemented it wrong.
Other alternative that came to my mind: attribute "adi,current-channel".
>>
>>        diff-channels:
>> +        description:
>> +          For using current channels specify only the positive channel.
>> +            (IIN2+, IIN2−) -> diff-channels = <2 0>
> 
> I find this a bit confusing since 2 is already VIN2 and 0 is already
> VIN0. I think it would make more sense to assign unique channel
> numbers individually to the negative and positive current inputs.
> Also, I think it makes sense to use the same numbers that the
> registers in the datasheet use (8 - 11 for negative and 12 to 15 for
> positive).
> 
> So: (IIN2+, IIN2−) -> diff-channels = <13 10>
> 
> 
It would mean for the user to look in the datasheet at the possible
channel INPUT configurations values, decode the bit field into two
integer values and place it here (0110101010) -> 13 10. This is
cumbersome for just choosing current input 2.

>> +
>> +          Family AD411x supports a dedicated VCOM voltage input.
>> +          To select it set the second channel to 16.
>> +            (VIN2, VCOM) -> diff-channels = <2 16>
> 
> The 411x datasheets call this pin VINCOM so calling it VCOM here is a
> bit confusing.
> 

Sure, I'll rename to VINCOM.

> Also, do we need to add a vincom-supply to get this voltage? Or is it
> safe to assume it is always connected to AVSS? The datasheet seems to
> indicate that the latter is the case. But then it also has this
> special case (at least for AD4116, didn't check all datasheets)
> "VIN10, VINCOM (single-ended or differential pair)". If it can be used
> as part of a fully differential input, we probably need some extra
> flag to indicate that case.
> 

I cannot see any configuration options for these use cases. All inputs
are routed to the same mux and routed to the differential positive and
negative ADC inputs.

"VIN10, VINCOM (single-ended or differential pair)" the only difference
between these two use cases is if you connected VINCOM to AVSS (with
unipolar coding) or not with bipolar encoding. The channel is still
measuring the difference between the two selected inputs and comparing
to the selected reference.

> Similarly, do we need special handling for ADCIN15 on AD4116? It has a
> "(pseudo differential or differential pair)" notation that other
> inputs don't. In other words, it is more like VINCOM than it is to the
> other ADCINxx pins. So we probably need an adcin15-supply for this pin
> to properly get the right channel configuration. I.e. the logic in the
> IIO driver would be if adcin15-supply is present, any channels that
> use this input are pseudo-differential, otherwise any channels that
> use it are fully differential.
> 

I cannot seem to understand what would a adcin15-supply be needed for.
This input, the same as all others, enters the mux and is routed to
either positive or negative input of the ADC.

The voltage on the ADCIN15 pin is not important to the user, just the
difference in voltage between that pin and the other one selected.

>>          items:
>>            minimum: 0
>>            maximum: 31
>> @@ -166,7 +191,6 @@ allOf:
>>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
>>
>>    # Only ad7172-4, ad7173-8 and ad7175-8 support vref2
>> -  # Other models have [0-3] channel registers
> 
> Did you forget to remove
> 
>             reg:
>               maximum: 3
> 
> from this if statement that this comment is referring to?
> 
> 


Other way around, forgot in a previous patch to remove the comment.
I'll move this change to a precursor patch.

>>    - if:
>>        properties:
>>          compatible:
>> @@ -187,6 +211,37 @@ allOf:
>>                  - vref
>>                  - refout-avss
>>                  - avdd
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - adi,ad4114
>> +              - adi,ad4115
>> +              - adi,ad4116
>> +              - adi,ad7173-8
>> +              - adi,ad7175-8
>> +    then:
>> +      patternProperties:
>> +        "^channel@[0-9a-f]$":
>> +          properties:
>> +            reg:
>> +              maximum: 15
> 
> As with the previous reg comment, this if statement should not be
> needed since maximum should not be changed to 19.
> 

We'll see what is the best approach regarding the current channels,
perhaps the one you mentioned in the later reply with always configuring
like the temp channel.

>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - adi,ad7172-2
>> +              - adi,ad7175-2
>> +              - adi,ad7176-2
>> +              - adi,ad7177-2
>> +    then:
>> +      patternProperties:
>> +        "^channel@[0-9a-f]$":
>> +          properties:
>>              reg:
>>                maximum: 3
> 
> It looks to me like AD7172-4 actually has 8 possible channels rather
> than 16. So it would need a special condition as well. But that is a
> bug in the previous bindings and should therefore be fixed in a
> separate patch.

It is addressed already in the binding:
"
  - if:
      properties:
        compatible:
          contains:
            const: adi,ad7172-4
[...]
              maximum: 7
"

