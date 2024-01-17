Return-Path: <linux-kernel+bounces-28974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D4F8305C1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15BE3286E90
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56731EA71;
	Wed, 17 Jan 2024 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWpYhVTN"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32341DFDE;
	Wed, 17 Jan 2024 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495407; cv=none; b=A959UeIk9zNpksGpexZ0hBHD1rND/9MrysVJjLwu0mhlqtfikX2n61xmIqt2RrlDvUyQVCG9FrewPy40nfBu66UvJBukXKS2LR8zJdss3sVYtkOMyEeprHln2L9dCG0Ikll/pOL1d9pmx6YOq73gtK0t3PPRkVh+fFbjOnSRKvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495407; c=relaxed/simple;
	bh=a8FmJzu/c+r2GWPqG+OpuFASOgCO9ga7M8UPrnSpm0g=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=bF/i8Wx6eDpKXloyyDP9CG2TXttjgNcrymUkfwpicMINAiVyk3gE8RCFjfj7alDq6O9D2Kty8OfaRuj8mdRfW+hxkUTHFxygABcULc4lggIoSLGUvN2LkmARt+Ua7J2iqnU8owo9IWMYsBjUrzIH8wKGBVrrQEKq9mfSfPYJblg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWpYhVTN; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2d6ded84fcso316548566b.2;
        Wed, 17 Jan 2024 04:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705495404; x=1706100204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4T0wmID9uCD1IcuseIang1mf1vY9StdxssC64dXvctk=;
        b=JWpYhVTNiuTnXhf/PbWQwTImdfFmkyUDa5MlNed1qqYI9zHhMOjeHkffnZsjWVGOr0
         kw9qsS5NENDcMMj7U0iaOHGJW2iqTcOGepFYxrM9EWrpM9348Weoo6pioIxCoYDHkzJd
         8dnKSd0Qq7YkEIfUpJuflf50Ct83aDm+UBBH7C1vTr5/WF1KDSZX5aI+o+Y7Cn+nD/v4
         Ph2cWIFvjt7O4tcIyVykrKiaXSv1xreHkoD3uIYrFngiAFncTyCmYMXqiyS1ys84EDbb
         B/1PRCxbF4bJITjXcaAqUOfVTdyQonc4DsHuqssCII/5oRYuVRpXrZBy5SpmDAN6L+8+
         10ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705495404; x=1706100204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4T0wmID9uCD1IcuseIang1mf1vY9StdxssC64dXvctk=;
        b=ZzlWCnDSJAt6MVaiz2I0hPDrxHDRTLh15QvqAbop8w5nIs0MY6IuwjmxUbVXLJUC8d
         6mcM2QqwIYyXLBV/lAb4wO2nNewnoxqQP13bb0BKR/4x99OMj8nToJB1QjSuUTBX60UI
         TEUFMxVMQTpPbvxfmzQHTw4+aWyg1iHpDrNtcWjrhmxqHfDqKOaa2tVeGPitPvQjJwuP
         7HnoB3LGr85id6b0VnPMXBwtwh8UslMGkiaD9AWGeECq6aXIv6KEDrUkB+4d7n9kNBeQ
         s7rX+V4Ott9HG2MFVwCYsaaLwkh555dtBQGExhYB66wZsTXhgqE21eLIt+9EyvhuO5T2
         rxGQ==
X-Gm-Message-State: AOJu0Yy3nvLHxrtc5X5Y/AnDMLEzS+e5zDBa8bgpS25aGPF3iBZkctxv
	G3L4mCxY5iCx7awWEnnlnPw=
X-Google-Smtp-Source: AGHT+IHg3HQWYRwKRUute5R5oHI5I1k6ckW9XIBZcGmPs3xOR+U3SdFlBonwWc7AlVY7wYMFkyVzGA==
X-Received: by 2002:a17:906:60cb:b0:a26:ee83:8841 with SMTP id f11-20020a17090660cb00b00a26ee838841mr4450849ejk.33.1705495403577;
        Wed, 17 Jan 2024 04:43:23 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id v8-20020a170906488800b00a27aabff0dcsm7862773ejq.179.2024.01.17.04.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 04:43:22 -0800 (PST)
Message-ID: <18c239af-71ee-49d8-878e-e1770c3e2d46@gmail.com>
Date: Wed, 17 Jan 2024 14:43:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/2] dt-bindings: adc: add AD7173
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 David Lechner <dlechner@baylibre.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
 linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 ChiaEn Wu <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
 Mike Looijmans <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231220104810.3179-1-mitrutzceclan@gmail.com>
 <CAMknhBELp3NQEHE16gHhC96bttoafQOGxx3a_dLZn9o2Ru7y9g@mail.gmail.com>
 <20240116163003.0000039d@Huawei.com>
From: Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <20240116163003.0000039d@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/16/24 18:30, Jonathan Cameron wrote:
> On Mon, 15 Jan 2024 15:53:39 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On Wed, Dec 20, 2023 at 4:48 AM Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

..

>> Sorry for the late reply as I see this has been applied already but...
> We have plenty of time.  Rather than dropping the ad7173 from my tree,
> I'd prefer to see additional patches on top to tidy up whatever
> makes sense from David's feedback.
> 
Alright then.

..

>>
>> As discussed in v8 [1] it is not clear what signal this is. Based on
>> that discussion, I'm assuming the RDY signal, but how would bindings
>> consumers know that without a description since it is not the only
>> digital output signal of the chip? And why the ERROR signal was
>> omitted here was never addressed AFAICT.
>>
>> [1]: https://lore.kernel.org/linux-iio/20231217135007.3e5d959a@jic23-huawei/
> 
> I'd forgotten about that.  Adding interrupt-names would be the easiest
> way to resolve this.
> 

I'll add this, but my curiosity for the long run is: How should
differences between what bindings include and what drivers support
should be managed and documented?

..

>>> +
>>> +  refin-supply:
>>> +    description: external reference supply, can be used as reference for conversion.  
>>
>> If I'm understanding correctly, this represents both voltage inputs
>> REF+ and REF-, correct? The datasheet says "Reference Input Negative
>> Terminal. REF− can span from AVSS to AVDD1 − 1 V". It seems like they
>> should be separate supplies in case REF- is non-zero. Otherwise, how
>> can we know what voltage it is? (same comment applies to refin2.)
> 
> Agreed, in this case these are directly used as references (we recently
> had another driver that could take a wide range of negative and positive
> inputs but in that case an internal reference was generated that didn't
> made it not matter exactly what was being supplied.  Not true here though!
> 
Wouldn't it be alright to specify that the voltage specified here should
be the actual difference (REF+)-(REF-)?

..

>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts  
>>
>> Why are interrupts required? What if the pin is not connected?
>>
> Ah. I clearly failed to review this one closely enough.
> 
> Absolutely agree that interrupts should never be required.
> No need for the driver to work if they aren't, but the binding
> shouldn't require them!
> 
> Jonathan
> 

To make sure that I understand, the driver will not probe without
interrupts, but it is alright to make then optional in the bindings?

This is in the case that someone will want to use this binding and
implement reading with polling?

