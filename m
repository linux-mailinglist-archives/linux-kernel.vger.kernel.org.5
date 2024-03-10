Return-Path: <linux-kernel+bounces-98331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A28877881
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 21:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489F7281454
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32D93A268;
	Sun, 10 Mar 2024 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NyJ28+u1"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7B3374C2
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710102943; cv=none; b=t6Uy966MJHaaZkVNLgFiYE+2zCCMz3nI9a8dZaIrjyKZyEK2uRU8L9/ZKKq05ZEgoaUexAhC+ccIsKwVsZClV/JZ2etCaEgyw8mk4c7rExoxk+tD3UfTVNUIKZi+8WxvO21JmSNbGwTGWpIrBDGT5vHmrNSpaMkEzUcuthpVQuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710102943; c=relaxed/simple;
	bh=e70bg/e1BS2jVywk5zKGgumV9mPuOOtP93ieLTvedjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RE8dzYO1fdkcz98rHzQeOVuHhYvEAAu6lD/LSsPnFeAsA9NbrTl+DkdfacA9HlZiPTsUReNjYJiNwgl9ZnwgMTX72tM/gx3ZD2iPOttQhSKjYlfDBCP6kqstrJ8Ehts4FEJbRlYo0agtdXorSUyCK8XxD34Y8rYzOUujvjlwSKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NyJ28+u1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4132add50ffso445675e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 13:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710102939; x=1710707739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hLuyOAUfakNiTmfRz2436v7ufbiP6S7z3xGi1kKPoaE=;
        b=NyJ28+u1hNf9hBj//WKMR4yJcD8RcKa+m4q9ggmQuMdBhL37pPpOGLWomdvwifY+rH
         uPkzbbZGp6Mq2YNj1e7vVhnkvinZlbUO+MMlapZOwgMEGDzZCyMa+sIgbkmYQEBNSQci
         nBMuoDRnMGZbzl2TNFLsy/OStp5Njy6Z++bAY556itMjAvxITgrDAIsW/x1na4zWzILa
         Gjoi8YLZOS7hHum56Se2vW91h3kEz/QLyrUayTtWJNRndEZHIxtXhcJ9UaMuac/Q5LJH
         km9wBamevr804BZCERxonkS0P6plvtF9SMoLTM5rjQE1A1rFJNPnAVUXCiE5L0jYCKE3
         M33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710102939; x=1710707739;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLuyOAUfakNiTmfRz2436v7ufbiP6S7z3xGi1kKPoaE=;
        b=VE1XjlpK1kpIwOaPZwE03kbYHar57UAw3v5wnuOfh7VM/uSLBNGiHxwGXtSy4wPeft
         aJFhTa8eZS3/40dmwNCqBwPnbHJ0F0TDs8yMYM1VofmbAjSIHVYAUMNP/Xi8TcW8TQi9
         RNjJ/DwPpOopHvXstbGIg3pTPsf7PtmlRGH9fbkUuV2aEH5gBTaF7A8vyIX+p3l0ZmpY
         xEIJhwEb83ZphyR/HJYS+8NTEioFmsWNDjidtbpm6IbOnPg+ByV3b+1CkeGMO3emeEb1
         0CknjhK9OBieiL4KphZVJ0vh17pN3fuV/ksF0atW73CxiztUUXnDO2fuYeCecHTine9l
         Zkyw==
X-Forwarded-Encrypted: i=1; AJvYcCU7axWbbtOUJ3H+y9jUXIypGUSLT2v5+MSv+s8Hnfu057rjdrv7sbmkhFON+ar5kXLlLlYeWx/JvpUaZgsSYoP9bb7Fj5CBSF9PAZyH
X-Gm-Message-State: AOJu0Yz7QkVrpt+6gtc2yH/eOwYIFgP+fj0YcGNaftQ1pP6sBVy7BQUU
	mpbjPnWwpXunUXVyHE6Y9SDJuHB8F5eQyGkIeS2GCDNPinSoD/FSSjT3kg4doxo=
X-Google-Smtp-Source: AGHT+IGwoVzQmaIuC9catL7JO+dbjx4CAeAUQWIHrknNzg8KTrQrmKOMUWfvzyEDcvXpmiYHyfWfMQ==
X-Received: by 2002:a05:600c:5253:b0:413:166e:ad51 with SMTP id fc19-20020a05600c525300b00413166ead51mr3670556wmb.2.1710102939596;
        Sun, 10 Mar 2024 13:35:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id j20-20020a05600c191400b00412f016a151sm6778963wmq.9.2024.03.10.13.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 13:35:39 -0700 (PDT)
Message-ID: <3601a374-4161-40e1-8a80-9bbfdae5bd8a@linaro.org>
Date: Sun, 10 Mar 2024 21:35:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 4/5] input: add onkey driver for Marvell 88PM886
 PMIC
Content-Language: en-US
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20240303101506.4187-1-karelb@gimli.ms.mff.cuni.cz>
 <20240303101506.4187-5-karelb@gimli.ms.mff.cuni.cz>
 <ZeTgEmjJc_VhYpLm@google.com>
 <CZL8ZSZAVEBI.349BV2Y6AKIPN@gimli.ms.mff.cuni.cz>
 <ZeZxI_spu4vwxrs7@google.com>
 <CZQ1EP61IDOC.1PPYGMIOINGND@gimli.ms.mff.cuni.cz>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CZQ1EP61IDOC.1PPYGMIOINGND@gimli.ms.mff.cuni.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/03/2024 12:35, Karel Balej wrote:
> Dmitry Torokhov, 2024-03-04T17:10:59-08:00:
>> On Mon, Mar 04, 2024 at 09:28:45PM +0100, Karel Balej wrote:
>>> Dmitry,
>>>
>>> Dmitry Torokhov, 2024-03-03T12:39:46-08:00:
>>>> On Sun, Mar 03, 2024 at 11:04:25AM +0100, Karel Balej wrote:
>>>>> From: Karel Balej <balejk@matfyz.cz>
>>>>>
>>>>> Marvell 88PM886 PMIC provides onkey among other things. Add client
>>>>> driver to handle it. The driver currently only provides a basic support
>>>>> omitting additional functions found in the vendor version, such as long
>>>>> onkey and GPIO integration.
>>>>>
>>>>> Signed-off-by: Karel Balej <balejk@matfyz.cz>
>>>>> ---
>>>>>
>>>>> Notes:
>>>>>     RFC v3:
>>>>>     - Drop wakeup-source.
>>>>>     RFC v2:
>>>>>     - Address Dmitry's feedback:
>>>>>       - Sort includes alphabetically.
>>>>>       - Drop onkey->irq.
>>>>>       - ret -> err in irq_handler and no initialization.
>>>>>       - Break long lines and other formatting.
>>>>>       - Do not clobber platform_get_irq error.
>>>>>       - Do not set device parent manually.
>>>>>       - Use input_set_capability.
>>>>>       - Use the wakeup-source DT property.
>>>>>       - Drop of_match_table.
>>>>
>>>> I only said that you should not be using of_match_ptr(), but you still
>>>> need to have of_match_table set and have MODULE_DEVICE_TABLE() for the
>>>> proper module loading support.
>>>
>>> I removed of_match_table because I no longer need compatible for this --
>>> there are no device tree properties and the driver is being instantiated
>>> by the MFD driver.
>>>
>>> Is the MODULE_DEVICE_TABLE() entry needed for the driver to probe when
>>> compiled as module? If that is the case, given what I write above, am I
>>> correct that MODULE_DEVICE_TABLE(platform,...) would be the right thing
>>> to use here?
>>
>> Yes, if uevent generated for the device is "platform:<name>" then
>> MODULE_DEVICE_TABLE(platform,...) will suffice. I am not sure how MFD
>> sets it up (OF modalias or platform), but you should be able to check
>> the format looking at the "uevent" attribute for your device in sysfs
>> (/sys/devices/bus/platform/...). 
> 
> The uevent is indeed platform.
> 
> But since there is only one device, perhaps having a device table is
> superfluous and using `MODULE_ALIAS("platform:88pm886-onkey")` is more
> fitting?

Adding aliases for standard IDs and standard cases is almost never
correct. If you need module alias, it means your ID table is wrong (or
missing, which is usually wrong).

> 
> Although I don't understand why this is even necessary when the driver
> name is such and the module is registered using
> `module_platform_driver`...

ID table and MODULE_DEVICE_TABLE() are necessary for modprobe to work.
Just run `modinfo`.

Best regards,
Krzysztof


