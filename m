Return-Path: <linux-kernel+bounces-84626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CADF186A927
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8030C288401
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A2F25573;
	Wed, 28 Feb 2024 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dPHhXf3L"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367C7250F6
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106173; cv=none; b=G9D2yeA6nIK4tLjjfs+w/InRkFPy7v5L0z0ajtiTghQa0lotCJGIkmfMxRQH0y0v+ii761LJFac+uExBkiMYI4n2ZAkq/U0e3EnDopRaMlW63BVyfJBWkxARssayxG4FXHqugfVbH5C+2Xae5FDP99zUCfFwSOqzWEvWRLOXkh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106173; c=relaxed/simple;
	bh=2z/mrd9QvlkiZfZzv2pdK+B8HyWJmS5sRKml1NG7xcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R5TAkmcQy+Owfy+5oaXSwJRNS9WHWp2Z7DyXSoArDj3MES5n35TmXEUu9mlHhK/qzmj6gLdIopArQ9pW3DMk5jV4itiCDetI94HrSGkuYNEZ5qvq4+2JN8TpDEw6NHTZ2hyotl+ygs22WnPFfOs0Ve5o6nRo84KDYE22y6se3FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dPHhXf3L; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so712543366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709106169; x=1709710969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQYBMAfRlY158XeZRXnO/C3REbH4KTGNj1xejarJZro=;
        b=dPHhXf3Luy03K2s9DTLiZX5xDz+/y/Rb6jFhLFjbnYmtL8jcsPvJTgpqYjRGqGM7GQ
         dZNDRHR3zVgWJJ5v4YaUQWHSMIExyCwd2ZdKFY1MA2mQR2z+qFaC7YAvlJviFa37Sus1
         V7lL9yAK+LC6xmlimNGjyaHrq76JLB6kMPL4T+U5f9SHV//TNF18ppKneaTFXiddSBVJ
         Kt7F1yLlw5JCNSM5RcWvxGdVY56mjzK43M6nit1mYNkrLCQMjb//rCX6hIULwWo0ImU/
         qsBkN4KP/rXzn+pVFPLsO/43uxMpwJlBportHf/EaXfw/ciQoBQwg8R6uFVa1GBsGXP1
         7v3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709106169; x=1709710969;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQYBMAfRlY158XeZRXnO/C3REbH4KTGNj1xejarJZro=;
        b=CLhmSSLDmLs2ALERhO/3IBWsvByjUqZ7jnBPQe0DMQW+16caHfZUfVQWlpg/hYEzzf
         0WpC1ChK59W/ZIiRAFflGgCe+XhJ4JPc8GiJi0vXL609yaOgp+L+TyZm9PcngSsGDL0y
         7gAqkj47bHw7qoRpy7ACX+6X8TVmCFeHlq4RyIPMk6EKNGuDdiH7L4b/0xPXbfReZkul
         5azCJncvP+1ZmbOFY1gi1weeLVAMcToGm+vV5r2xjPHGJaAHQwSgeU0ucRRdvH2rITSd
         FwnK3VNFRjGiGgUdesfAStt23+rJFgIrP/wliOAfEkMo+Choi89DRw1QrHGhl+pb7TzX
         fQDw==
X-Forwarded-Encrypted: i=1; AJvYcCWFauW4TaQmKNG+hhx6XO9paKp8LhOHIgu6y+Jm/d3w5i0O0N2SY1AkOM3AOZ5E0XKQPN79HKA2u2j/d0eOHpzz5KSWvShcOYPnXtUA
X-Gm-Message-State: AOJu0Yy28ZCb1QIhbgAZfrl6F43JmUtAfO4pCnniKAguMtiZUCKJVGHA
	g01qA/p2BdaDly6qXt2yYb54KQiWZfJ1LhvRYOcFP4U+SPAEkjIK/KFFiTgOZ09/t4UFUe73/R/
	u
X-Google-Smtp-Source: AGHT+IGdbNmKnHWCw2QxMl92RhUTV1mzewd327y1Q5FQL0SGRsS9f4y71IC4Zph03lvtjOgkiaouYg==
X-Received: by 2002:a17:906:6d7:b0:a44:f85:a10a with SMTP id v23-20020a17090606d700b00a440f85a10amr271835ejb.14.1709106169409;
        Tue, 27 Feb 2024 23:42:49 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id cd14-20020a170906b34e00b00a4412406741sm67118ejb.131.2024.02.27.23.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 23:42:48 -0800 (PST)
Message-ID: <daed8ada-9e01-41ad-82af-5da5cbbc865c@linaro.org>
Date: Wed, 28 Feb 2024 08:42:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: industrialio-core: look for aliases to request
 device index
Content-Language: en-US
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Syunya Ohshio <syunya.ohshio@atmark-techno.com>,
 =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240228051254.3988329-1-dominique.martinet@atmark-techno.com>
 <7f03bb12-0976-4cb7-9ca9-4e4e28170bdd@linaro.org>
 <Zd7hSOw3_zosyrn3@atmark-techno.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <Zd7hSOw3_zosyrn3@atmark-techno.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 08:31, Dominique Martinet wrote:
> Krzysztof Kozlowski wrote on Wed, Feb 28, 2024 at 08:16:03AM +0100:
>> On 28/02/2024 06:12, Dominique Martinet wrote:
>>> From: Syunya Ohshio <syunya.ohshio@atmark-techno.com>
>>>
>>> When using dtb overlays it can be difficult to predict which iio device
>>> will get assigned what index, and there is no easy way to create
>>> symlinks for /sys nodes through udev so to simplify userspace code make
>>> it possible to request fixed indices for iio devices in device tree.
>>
>> Please use subject prefixes matching the subsystem. You can get them for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching.
> 
> Sorry, I assumed that was already the case and didn't think of checking
> that from what I was given, I'll fix the prefix to "iio: core: .." in v2
> 
>> Please run scripts/checkpatch.pl and fix reported warnings. Some
>> warnings can be ignored, but the code here looks like it needs a fix.
>> Feel free to get in touch if the warning is not clear.
> 
> Hm, I did check that and do not get any warning about the code itself:
> 
> $ git show --format=email | ./scripts/checkpatch.pl -q
> WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst


> 
> total: 0 errors, 1 warnings, 61 lines checked
> 
> What are you thinking of?

You have warning right there.

> 
> Regarding the dt binding, I'm not actually changing a binding so I
> didn't think of rechecking after adding the note, but I guess it still
> ought to be separate; I'll split it in v2.
> 
>>> For platforms without device trees of_alias_get_id will just fail and
>>> ida_alloc_range will behave as ida_alloc currently does.
>>>
>>> For platforms with device trees, they can not set an alias, for example
>>> this would try to get 10 from the ida for the device corresponding to
>>> adc2:
>>> aliases {
>>>   iio10 = &adc2
>>> };
>>
>> Sorry, that's why you have labels and compatibles.
> 
> I'm not sure I understand this comment -- would you rather this doesn't
> use aliases but instead add a new label (e.g. `iio,index = <10>` or
> whatever) to the iio node itself?

No, the devices already have label property.

> 
> Setting up a fixed alias seems to be precisely what aliases are about
> (e.g. setting rtc0 will make a specific node become /dev/rtc0, same with
> ethernet0, gpio, i2c, mmc, serial...), I'm not sure I agree a new label
> would be more appropriate here, but perhaps I'm missing some context?

Maybe I don't get your point, but your email said "sysfs", so why do you
refer to /dev?

Best regards,
Krzysztof


