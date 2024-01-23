Return-Path: <linux-kernel+bounces-35852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEAD839761
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25AD1C214B2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D24981AA7;
	Tue, 23 Jan 2024 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oKfaOYf6"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFBD81213
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033568; cv=none; b=Dfzm7TyB5IFtfXMS0fJ6cN1IEFYcNTB9O+/zJKxf78dv40MH+M8k7NJhsvvJDIggbIS5wIj0sx8X3qLvR3qoDb21QJh4WKWLf2tWF77TXOP/93otchsHdWLZO/DMrCuK5WBUL3xvmiRul9P9IPH9iJi1xf9CO8S5s1U/vYMpCRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033568; c=relaxed/simple;
	bh=+W+AqW+k5MfHNzbur2Sb7hgrL0x44q1TMGMN+vCfnTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPFwhwYHnpj4Pu2cJRQGTYvXXSN7owLxcL4wW19sMmuGXOyVvaYVRQUwClx6hUsWVnKKYS5PwHKcTDUoVvrhxhp518TZjcVaCYUZKQafkYmznRRgi32hYNf80h18TG7UvIB2gEpJMZLBX4owXHcMvx7znebYI7n/ppDt4Fr0gBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oKfaOYf6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-337cc8e72f5so4247545f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706033565; x=1706638365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dq4sU5qjvIDsr51THEhq6jtgp9rKsAHiomBG84n/Fuc=;
        b=oKfaOYf6JLdVSwwp+OLg6Rj45eWEfwtpimvasEBLZ+MTaNPBZndi3MdvgMsPfrfW9Z
         7+qYlNgGeaDG7huc0z1idz7ta0y7FT5tlFqykE+nr7pCckrVV5H4MpuOMuDijv7RrqBI
         tcm0aT3q7ZUSmedTLzRqU+lAYw0vH0oEIuk5RYhImdOnJQJPw6m05qxFS3nHr3K28Lqg
         4ZkEdTE3mTLH1ARK2V7vFEpsQ5+vHmFLEeJq8q5egfOWc+aSA9ingKauaMU5tpao6zGN
         ME5dlXnyG9PKaR7IqDa43+Cz3ykuyxWJf2HWIF5X6ZG0WtNJxo69s7CqN8BrR7UvIA2j
         gp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706033565; x=1706638365;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dq4sU5qjvIDsr51THEhq6jtgp9rKsAHiomBG84n/Fuc=;
        b=ECje8kvPK5wCamdLlpAdIKTAv/0MWYxJsuH49eOLT43ckgzSiukQJzA8/I6idSN2Wt
         LgFXsAUQ0NY93ux+pQBObaq5HoLYPasbNt2sfhnJ2daRH+WUisMZSObIP7L653fdNxuO
         6dPcEmjpZGc7HwiG5wtGKx1hDSpv7M4v4UPU6kcNuxFS+yyfTE9XZrTBJ29wo0h7kKes
         nJC+u6k3lvMjJkfxtrmdScn4ySg7hU+WGme8WiC5d70m+R/qG0UjzhqiO/nNzHk+vuqZ
         2j94F0VM5VOKhmR5ifXAqb6SOVueMUSWTfg+yInx99/z3q9eMGWsoIp9LHTgf2JqgOPJ
         nGlw==
X-Gm-Message-State: AOJu0YyDnqN+wmKbDj3raHsObigeepVOASmDdCqHKQE7yNWcpMGAg5KR
	VLrHPTONyBAjpVZvN6wJaPvYEiiNJYCkSKFlh2m9NWdUfv+IeFtV2jO3MNoHt9o=
X-Google-Smtp-Source: AGHT+IGiYOo20x7pVta4MxGePb1BjCmsxmpLPnsJ1+A6X9iWMxljXqPr3HBtQmTqd/ihvRFbCel9gQ==
X-Received: by 2002:adf:e602:0:b0:339:30fd:cbb5 with SMTP id p2-20020adfe602000000b0033930fdcbb5mr2343358wrm.109.1706033564736;
        Tue, 23 Jan 2024 10:12:44 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id u11-20020adfa18b000000b00337d2d1e0ecsm14207170wru.104.2024.01.23.10.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:12:44 -0800 (PST)
Message-ID: <6c72a521-1048-42eb-ac74-d8f718a90723@linaro.org>
Date: Tue, 23 Jan 2024 19:12:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] watchdog: s3c2410_wdt: update to use new
 exynos_pmu_*() apis
To: Peter Griffin <peter.griffin@linaro.org>
Cc: arnd@arndb.de, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 linux@roeck-us.net, wim@linux-watchdog.org, conor+dt@kernel.org,
 alim.akhtar@samsung.com, jaewon02.kim@samsung.com,
 chanho61.park@samsung.com, semen.protsenko@linaro.org,
 kernel-team@android.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org,
 saravanak@google.com, willmcvicker@google.com, linux-fsd@tesla.com,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20240122225710.1952066-1-peter.griffin@linaro.org>
 <20240122225710.1952066-4-peter.griffin@linaro.org>
 <da30a68a-e29f-45c8-aa73-02955255a457@linaro.org>
 <CADrjBPor5tMY4r0jOy7GH36auCU7dWn6Qn4ct89bsSMW4vAQOA@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CADrjBPor5tMY4r0jOy7GH36auCU7dWn6Qn4ct89bsSMW4vAQOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/2024 18:30, Peter Griffin wrote:
>>>               dev_warn(wdt->dev, "Couldn't get RST_STAT register\n");
>>>       else if (rst_stat & BIT(wdt->drv_data->rst_stat_bit))
>>> @@ -698,14 +699,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>>>       if (ret)
>>>               return ret;
>>>
>>> -     if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
>>> -             wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
>>> -                                             "samsung,syscon-phandle");
>>> -             if (IS_ERR(wdt->pmureg))
>>> -                     return dev_err_probe(dev, PTR_ERR(wdt->pmureg),
>>> -                                          "syscon regmap lookup failed.\n");
>>
>>
>> Continuing topic from the binding: I don't see how you handle probe
>> deferral, suspend ordering.
> 
> The current implementation is simply relying on exynos-pmu being
> postcore_initcall level.
> 
> I was just looking around for any existing Linux APIs that could be a
> more robust solution. It looks like
> 
> of_parse_phandle()
> and
> of_find_device_by_node();
> 
> Are often used to solve this type of probe deferral issue between
> devices. Is that what you would recommend using? Or is there something
> even better?

I think you should keep the phandle and then set device link based on
of_find_device_by_node(). This would actually improve the code, because
syscon_regmap_lookup_by_phandle() does not create device links.

Best regards,
Krzysztof


