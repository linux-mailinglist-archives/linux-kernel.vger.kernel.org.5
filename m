Return-Path: <linux-kernel+bounces-29842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F21831443
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27567B2493C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DE311CB2;
	Thu, 18 Jan 2024 08:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjfkNm9v"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720001170A;
	Thu, 18 Jan 2024 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705565452; cv=none; b=CPrRObrQ+D/clRnJYJeQmSracfFClvHKdvhZ0wFuJwNjvC6ljG1l7eUYh/VRJbXxA+5rw5OcnFCt3clgLllpXkf05hOcTYYSzPWCm3PvVqB+hFVWAb4gLtLtYY2IL1EgMSFtCPPyYU0eQvYmjnoTnN0buu1fhBWm2X3uCCIjoOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705565452; c=relaxed/simple;
	bh=ok5rxjWhE2d4d91QscThfDxkehsNlfCTZpi60NZLj+s=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=nFKiYOiAJ8e6AT5hMzfic4F1dfAsSv1EEB6lDClfM66EXsIgxULh1ptBvp9VRLqFWvw8CutX2t/xlLYFh8/9+KvoDSnrZB1k0e5UKtc2QZf6EGyRxcopsIox1aHUhKZb1EI56r9LzWCGgF/txYmrWByPrCTTK7PZYNHpkQFsf9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjfkNm9v; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a0294893eso439792a12.3;
        Thu, 18 Jan 2024 00:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705565448; x=1706170248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8D9GrCN6KCy/inIyivjsUBv8glt8HtDAWFkt4pSTRR4=;
        b=jjfkNm9v3BrmDTdbrH/kB0yQKNNa+6AqoZkVHWXrqM4bDZ6XWV6NtC2GY8D88vpHjB
         N7fRCqOnLkwdJ1RmNYkMAAi7BbqbdH+enus/pu6GPe0mco/J/BHwSFwhxr3pblW2fNYG
         PojSrNDkX+nXTsPn7n7EB2gc43+efCENDJctWRyWS2ZfxT/iRyveDvz292s4LhP1Rnpp
         F4PUioQ+5sMnW06k23iJx7cSAdbQgMb3/JlUe4HJVplYpucudk/i3K8wFsqACbPIem3O
         H3prW3HZva86XtWZM8Td/0Lu4bPOqqVpmTSnjykHUYLypOlpowp59NzuJYGxGZSUT5kV
         RAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705565448; x=1706170248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8D9GrCN6KCy/inIyivjsUBv8glt8HtDAWFkt4pSTRR4=;
        b=D88LMX/E1pu+IPTd95XWK34/pxq4TRPA9OMkfp+isugloZlnhEjf9+EPNqm3QXHZ/+
         PFn8blcy0R6UUp+Vx70y+aO0eAEUiyFKFiv9ET5xjrrPBixzS3srDoEtcyJrVBKjfxn+
         sD/VfsaC95kVyDxZyUYOd6szYuPpvqVHV15tQXDeqmWmg70K3Dq6x6GD+ZG2i6LHk9Bg
         MDJtW252OxXqB9MvC61E5+pJssHBnCdxGMpZwMiPMHi7KADoAAOTjRM/KGtBrT+MGyXX
         1M5siNk/oX9ujEGxCJxnjj74Zoy2wQyMku0MBcHDKEb+f+ndiszK/FZPgP20Ml+j3z2c
         uIcw==
X-Gm-Message-State: AOJu0Yz5Vix0lq8BLwnmsSz1vumVIXWtjKS1t707qsd6NBO+TsSY2b4r
	YZC4pVp2T/HQsLAY2JE2OZkVu172qpAitr/Q+k21oL3PlENqmEPPvcmibeqzY8OUMw==
X-Google-Smtp-Source: AGHT+IGLvo4wbg35gUjDK5QGjm+OOMU9mJXTgGBGSZAwutp91RLeltfNpn3vC0BeSxl1FDH4Z7C3LA==
X-Received: by 2002:a17:906:c78e:b0:a29:4267:ac9 with SMTP id cw14-20020a170906c78e00b00a2942670ac9mr258926ejb.52.1705565448311;
        Thu, 18 Jan 2024 00:10:48 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id bt22-20020a170906b15600b00a2c32c5f484sm8752674ejb.209.2024.01.18.00.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 00:10:47 -0800 (PST)
Message-ID: <cf48e196-a569-4287-93b7-b5f06c34d6f6@gmail.com>
Date: Thu, 18 Jan 2024 10:10:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/2] dt-bindings: adc: add AD7173
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: David Lechner <dlechner@baylibre.com>, linus.walleij@linaro.org,
 brgl@bgdev.pl, andy@kernel.org, linux-gpio@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
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
 <18c239af-71ee-49d8-878e-e1770c3e2d46@gmail.com>
 <20240117163725.00003981@Huawei.com>
From: Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <20240117163725.00003981@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/17/24 18:37, Jonathan Cameron wrote:
> On Wed, 17 Jan 2024 14:43:21 +0200
> Ceclan Dumitru <mitrutzceclan@gmail.com> wrote:
>> On 1/16/24 18:30, Jonathan Cameron wrote:
>>> On Mon, 15 Jan 2024 15:53:39 -0600
>>> David Lechner <dlechner@baylibre.com> wrote:
>>>> On Wed, Dec 20, 2023 at 4:48 AM Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:  

..

>>>>> +
>>>>> +  refin-supply:
>>>>> +    description: external reference supply, can be used as reference for conversion.    
>>>> If I'm understanding correctly, this represents both voltage inputs
>>>> REF+ and REF-, correct? The datasheet says "Reference Input Negative
>>>> Terminal. REF− can span from AVSS to AVDD1 − 1 V". It seems like they
>>>> should be separate supplies in case REF- is non-zero. Otherwise, how
>>>> can we know what voltage it is? (same comment applies to refin2.)  
>>> Agreed, in this case these are directly used as references (we recently
>>> had another driver that could take a wide range of negative and positive
>>> inputs but in that case an internal reference was generated that didn't
>>> made it not matter exactly what was being supplied.  Not true here though!
>>>   
>> Wouldn't it be alright to specify that the voltage specified here should
>> be the actual difference (REF+)-(REF-)?
> How do you establish the offset to apply to single ended channels if you don't
> know the value of REF- (relative to local ground)?
> 
> So no - as the device supports single ended channels the difference isn't
> enough information.  It would probably be fine to do as you say if it
> were a device with only differential channels where all that matters is
> the scaling.

	I suppose that you are referring to the first page presentation: "Cross
point multiplexer; 8 full differential or 16 single-ended channels". I
consider this to be a bit misleading as all channels are actually fully
differential (must select positive and negative source, AVSS is not one
of them).


	Even more, the datasheet specifies that when using "single-ended"
inputs you need to select which of the pins is the common one and
connect it to the desired GND (be it AVSS, REF-):

"Because there is a cross point mux, the user can set any of the analog
inputs as the common pin. An example of such a scenario is to connect
the AIN16 pin to AVSS or to the REFOUT voltage (that is, AVSS +
2.5 V)" (ad7173-8 page 27)

	For me this is 100% the case that this is a fully differential ADC in
which the datasheet presents a way to use it single-ended. Let's say
that we are using EXT_REF, and REF- is non zero. If someone connects
AVSS to the desired common pin, the ADC will still measure correctly the
difference of voltage between AIN_POS and AIN_NEG and compare it to the
EXT_REF.

