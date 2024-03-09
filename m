Return-Path: <linux-kernel+bounces-97941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CB18771FD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 16:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3DC21F2159E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38D2446B4;
	Sat,  9 Mar 2024 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHVzgPv6"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E974437C;
	Sat,  9 Mar 2024 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709998531; cv=none; b=Yw1j7HYmpifhDjk1uLFMSt2uQBJyTUnARUg0fW6rOwQycwx6EQK+dFcrCpfHwWLLJLwKcrlaFtYH2R03XBWqpLjciWbscfkUBeDd3pL5wMlyZFEF/LxXHOw3LuwwcmW3jnp+ul6BNp6HbmuBZBkPfvflKJOcXseEjEYboevLgRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709998531; c=relaxed/simple;
	bh=CRC/rrrJ/5B0sx4IXLiEKrjaDPVV+p8XAikEkWmkxaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IbgQYbZMpKCfFbnksZMwRxoq0U4j10802/jsKN4fsI+LCo4raRbmOpv22x/S96i7qQYgw/pdjYspTsHVWcyvgb6wH2ho7rmDUq7yRh+mBD4iID/18i5tTtNCuqRXPj61xrkzleaSNKJDUsjCbobWgVA1sPl4xdyORYWTyGuAAuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHVzgPv6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5673b5a356eso3319100a12.0;
        Sat, 09 Mar 2024 07:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709998528; x=1710603328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wa3LdvNtGx6OdWsIJ5+6Y7D2gSg3s0jdigbYfnOKfnY=;
        b=CHVzgPv6oJIyVisJkc5PwM4QsmirRGR42clSccGCc8JcA/20qr8xpb9sH9IlHB0R2/
         m8y20q+PJMOSIzdE93WVwNpt6F9+XmHck3YWsUOk7PBvpjVX60ZFdrytVzqwzfumNnzn
         Nl81XEYrUe8OLfevwaORet5QzjjmGqRkPL3wAMmmVecXJi6Vl0rtAN7Wyus28b+2sC9z
         3X7Jdh57QsXcg+XrR5LA0MLXLpDgoRMly4CHnpan7+ZLs3v+3pN8NYnbJNLR/YUSjk4k
         SOGKoA7xC5bnQ9V1FOBC64CdCaSZe/zFFpVbuc+lBm8zEEiNhZZNrhnC3P/5FAD/s/1V
         vCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709998528; x=1710603328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wa3LdvNtGx6OdWsIJ5+6Y7D2gSg3s0jdigbYfnOKfnY=;
        b=grlEJmA588+xV8gQIyMBzY4LSUAq7ZIwFJNElcjLA3z/5gLSpwZh7WzpxClw3Cg45e
         uE8T/+R8M86R9+xBxdTFJ6MZAw4Zm2mxybuSN/krSYc2otNVihjHMEHw1YfBgHrc3NvX
         HdaF/RIu8/bpbjxfx1JLYouE4aNggWBVqBRgHk59Itpg7RgnObJqQf7eMfl/p0iUPnO+
         43GEalX+b6MI+QuH4MeS9+VftuHYtWRLNatxIyrrElEHyKxxrub4uVvW2/uApBwtp4tw
         sbtMmR5I2Rf//qH9PhXtKqksN+lU2ZfJuQ67Q4mInp+g9W2qCLjZ0EkWQTAPqCBAnmvG
         Hivw==
X-Forwarded-Encrypted: i=1; AJvYcCWH9yeE8944LRwJvitRsKN3HfC4Xa0J5uEIYm/IoGdPjhAPLIO1ZAzW4m4V9Fy5KZAHEbUMpFCyxNkhwKfZNxLkDUVSPyTv5UiA9K28
X-Gm-Message-State: AOJu0YyE2bwVwJFCmFs3sB+WTJoOAJA3PPNbT2OMNSo4zrbFSjT7H52m
	pTXwBUlhqyCMDqWMc4fc1S2niAxwY/vkX+65TtHfGC5ZFGoS2yK3Qlr/5sN9juU=
X-Google-Smtp-Source: AGHT+IEDug/2P/+Ji38uaj1mVxbXwnO/U7f7TdTlOK/PEyfkVqP0vvJyyZlZyNUV04vfQqaUKlTbXQ==
X-Received: by 2002:a17:906:11cc:b0:a44:5477:bb46 with SMTP id o12-20020a17090611cc00b00a445477bb46mr1050705eja.61.1709998527769;
        Sat, 09 Mar 2024 07:35:27 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:3599:7594:d284:9242? (2a02-8389-41cf-e200-3599-7594-d284-9242.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3599:7594:d284:9242])
        by smtp.gmail.com with ESMTPSA id lg12-20020a170906f88c00b00a4432543b21sm988958ejb.198.2024.03.09.07.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 07:35:27 -0800 (PST)
Message-ID: <c7f88cb9-8035-4a8a-8e3b-532453fa9f32@gmail.com>
Date: Sat, 9 Mar 2024 16:35:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: trivial-devices with vdd-supply: true
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1ee8fc6f-5299-4ba5-bb61-14b4351c0708@gmail.com>
 <7856f1b7-e12a-4530-82c5-416ec66e1885@linaro.org>
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <7856f1b7-e12a-4530-82c5-416ec66e1885@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09.03.24 16:00, Krzysztof Kozlowski wrote:
> On 09/03/2024 13:22, Javier Carrasco wrote:
>> Hi,
>>
>> I am trying to figure out the current policy to add trivial devices
>> (I2C/SPI devices with at most one interrupt) to trivial-devices.yaml or
>> include a dedicated file.
>>
>> Apparently, bindings for the same sort of devices where "vdd-supply" is
>> provided require their own file, and I wonder why there is no
>> "vdd/supplied/whatever-trivial-devices.yaml".
>>
>> Instead, files with trivial bindings + "vdd-supply: true" are added on a
>> regular basis. That property is not saying anything specific about the
> 
> Anything needing supply is not really trivial anymore, because we want
> the supply name to match more or less what's in datasheet.
> 

That seems to be the case for devices with multiple supplies, but for a
single supply "vdd" seems to be preferred over any name in the datasheet
like "vcc", probably due to a copy+paste effect?

> Solution is sometimes to allow generic "power-supply", like panels have,
> AFAIR. If you have new device, just add new binding for it or add the
> device to existing binding with very, very similar device.
> 
> See also:
> https://lore.kernel.org/all/YUz+psAILnF5L5GH@robh.at.kernel.org/
> https://lore.kernel.org/all/20210921131804.GC1864238@roeck-us.net/
> https://lore.kernel.org/all/CAL_JsqKJgvK8g+zbzLCBxnKbgAioBcdHWNAvqe4Z9BzkNMwPpA@mail.gmail.com/
> 
> 
>> device beyond that it needs a supply, which is very common. Is that
>> intended and no more generic bindings are desired?
>>
>> On the other hand, trivial-devices.yaml includes several devices that do
>> require a single supply (e.g. several sensors), but it is not explicitly
>> documented. Did the requirement of providing vdd-supply arise after
>> those devices were added to trivial-devices? I think that some devices
> 
> You would need to analyze the history... requirement of providing
> supplies was kind of always. Just like trivial devices were.
> 
>> that were added to trivial-devices in the last months could have also
>> had a vdd-supply property, so I am not sure about the rules to choose
>> one way or another.
> 
> https://lore.kernel.org/all/20230505204810.GB3506915-robh@kernel.org/
> 
> Best regards,
> Krzysztof
> 

Thank you for the references. In that case a device in
trivial-devices.yaml is better than no bindings at all, but if a supply
is required (which is often the case), dedicated bindings or addition to
existing bindings from a very, very similar device is better.

Best regards,
Javier Carrasco

