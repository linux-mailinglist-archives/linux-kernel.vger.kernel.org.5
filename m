Return-Path: <linux-kernel+bounces-56649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7EA84CD34
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D861C2540B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A947F47F;
	Wed,  7 Feb 2024 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLZX1m/u"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616077762B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317306; cv=none; b=tspKjWraAMbxgoIIsN/Agz8XiQUBjKHRY2cApFLWrvweULjVgL1riTj7gkiUKaK0ipSEWbZrA7MEkme5P7xytfonfOT06HdUPZPdzKcIVk5YkRF0rXIZqNcvKe3jiLZRYY9KUhesvOF6bp21oBrjNQBuob3Esirvqy20fFJPZd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317306; c=relaxed/simple;
	bh=TG3Gw2URrbzNYz4gRkIWZjCBPa9SJfm7IeLSghIRzEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKMYLUwnxLVpcnOlmqba+SB4msNlrKF/6h4kRZtz9+xVcO9c8aXtXxUkq0rLgBCNnWjShcsrRuOVlAgoAJSsfDvtT8SSfm6Gw7OlNOR/9wfz6FOBvNUHRRDN7vX/cjAbJc8gyu+tHPGXqW+6Tx+iZWCqT0DJ++v92nO+qHgA1e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZLZX1m/u; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4101fc00832so2379085e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 06:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707317302; x=1707922102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TjrnaMfjtaIdIMxZWoxjKFFoCN4X5eE097h6HkqsF+Y=;
        b=ZLZX1m/uNPPzBfubNX0ZQmSXI3qTUnfJenUR2Q/hsOlkOYrrtzlPSAeEu2YzZmMLb+
         AnSNLDbrrFqbvjt36kqGuf/XezZlwpvf8fabsB3TRzMkzgG4rO6k5OcmXiKPzyfaTCPQ
         lajm3/P9H+57gfgIry89hwKTr7PX7qMFQDcQpHEOai/trJ7WA5ZMoYyFqvKVAd90db13
         RR6bptRYp97lpiDzgFwnB31PnahY5M1URLaUMSyCPKjkDmWy+aBeOrS+TkhzVptTchpn
         Pa8IGhZe5QkzPvjbvBi0B9Y8AZjgUzYhqkRCw5CBMzIgZzvYb3sNd5VttsPMvKqWQkiM
         KhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707317302; x=1707922102;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjrnaMfjtaIdIMxZWoxjKFFoCN4X5eE097h6HkqsF+Y=;
        b=a9JwOwuho1pKhtpX/1EY11pUm/dHIFuUMzLgKOhzS0ky/3HEfTFVS4Es2gFp+2W0EG
         0/F33FpjcxSXLLNTY+RCP4o6nCHs7U2j9JgJregLgBRL5tOjOIgEpLKEjgfbh/C7jmhz
         gfYQ1tC3lUxHj2ZA0WpZPDa3SMijk5Gs6P8V3O3QmSHLD2AqQ6FcB3WkMtArwvKvJl1L
         nXAdObVX9nHlsJocwDkUl7rFQYo+LGLVHMv25H2yfBoVRX+kqzelnhr02cDgWUHch/Wb
         2m5rm+XiSRbu5R7B5q+ba2fulwUXuoPslRv+sRiefN/4pwaWTTuj885CoaoNHdNkhS5B
         v+Pw==
X-Gm-Message-State: AOJu0YxXeN+dqIMMWTVmwqObsno2bqkpA7kcn/VB7GTw87RazHRI4A5l
	xdQ8GH2+MzPq9jIpyweJGfSuQZbqVZGWAG83o4Ng0V7JGJIMkAIPTeTSj3KhTMc=
X-Google-Smtp-Source: AGHT+IGh8sXcNQjqiVsv9lLCBPY7A8Ao3cTvDIxAoj/rq2WKA4j7B3aKawxRDyUlkMTSZBLCDv2YWg==
X-Received: by 2002:a05:600c:1ca6:b0:40e:b195:6bdb with SMTP id k38-20020a05600c1ca600b0040eb1956bdbmr5187499wms.2.1707317301725;
        Wed, 07 Feb 2024 06:48:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVr47OU9QJl84wqhieyiA7SQq/5jQEWYK8EGQjYIYZhlVII6geGc/M8BoVUFjokxeIvxWFIKDLcQpTgleT5Ppaajcnv1g7ZvlYlkvzN17Cedy6f8aRvB3ePmLfjV2vedna3vmXy/22FSQCf1rf8sc+05Ea7CZXH/Hvy+xI4h/xPIAlwzfT4qIxvhOucqWAs5qpkp3TzlckrOYJpeEiJnOrYM5hzt6R9/8AfFZsTjk3w1MpeVU4mrcJVU6JmpCdIyuO5CBC1tDC+tQcHbIgQPyNyDM7YLRD6CwMhLyjPcz0aGUcXnYMyDBOMAHiVmWx0H1IUyWbQAG3ecIN395x0GITI/RfkSqNgjtumXh/vlKErAsycLpSnDLgvfmZXfu9hoV7PGMvOMAroa1vr7fK1D4SswobOdezb4B/DtPCqWSTcv+Gvoi5g1SdGMNkcTcVsXgFBJ5EE6Lb8jeK/w8Tb7dVhQj/A+yEao2nm2bh2MggVYIgTp5P2ObDl+dOSvxaE2voMebJJqHaeyYiDp++E2tIYydQw9y5396r9wude4o46hR4Ee6PS9MatfuryGpRcYMPSybP4zHnpYQZlFcmgmDnQ8QTp5Uo5rwTSCKwJcgB14PUzVy25z9JAHbDtKGw=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c4fce00b0040fdd7cbc8dsm5518023wmq.47.2024.02.07.06.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 06:48:21 -0800 (PST)
Message-ID: <d367bd65-605e-44b7-9400-acd463dec0b6@linaro.org>
Date: Wed, 7 Feb 2024 15:48:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] soc: samsung: exynos-pmu: Add regmap support for
 SoCs that protect PMU regs
To: Peter Griffin <peter.griffin@linaro.org>
Cc: arnd@arndb.de, linux@roeck-us.net, wim@linux-watchdog.org,
 alim.akhtar@samsung.com, jaewon02.kim@samsung.com,
 semen.protsenko@linaro.org, kernel-team@android.com,
 tudor.ambarus@linaro.org, andre.draszik@linaro.org, saravanak@google.com,
 willmcvicker@google.com, linux-fsd@tesla.com,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20240129211912.3068411-1-peter.griffin@linaro.org>
 <20240129211912.3068411-2-peter.griffin@linaro.org>
 <fb530eb8-e32b-4faf-81f3-efc334ebf241@linaro.org>
 <CADrjBPoQmTRsFYRtxBxdvAoKK816O8XN3=hOJ3vBt8wbbbk-=Q@mail.gmail.com>
 <99828589-c0b5-456d-b250-6ad3e6085a91@linaro.org>
 <CADrjBPrWH8uFrFmn_CZpr+fAnPrzbDT4i9XuMXJqKfzeouPpKg@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CADrjBPrWH8uFrFmn_CZpr+fAnPrzbDT4i9XuMXJqKfzeouPpKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/02/2024 12:42, Peter Griffin wrote:
>>>>>  #include <linux/soc/samsung/exynos-regs-pmu.h>
>>>>>  #include <linux/soc/samsung/exynos-pmu.h>
>>>>>
>>>>>  #include "exynos-pmu.h"
>>>>>
>>>>> +static struct platform_driver exynos_pmu_driver;
>>>>
>>>> I don't understand why do you need it. You can have only one
>>>> pmu_context. The moment you probe second one, previous becomes invalid.
>>>>
>>>> I guess you want to parse phandle and check if just in case if it points
>>>> to the right device, but still the original code is not ready for two
>>>> PMU devices. I say either this problem should be solved entirely,
>>>> allowing two devices, or just compare device node from phandle with
>>>> device node of exynos_pmu_context->dev and return -EINVAL on mismatches.
>>>
>>> Apologies I didn't answer your original question. This wasn't about
>>> having partial support for multiple pmu devices. It is being used by
>>> driver_find_device_by_of_node() in exynos_get_pmu_regmap_by_phandle()
>>> to determine that the exynos-pmu device has probed and therefore a
>>> pmu_context exists and a regmap has been created and can be returned
>>> to the caller (as opposed to doing a -EPROBE_DEFER).
>>>
>>> Is there some better/other API you recommend for this purpose? Just
>>> checking pmu_context directly seems racy, so I don't think we should
>>> do that.
>>
>> Hm, I don't quite get why you cannot use of_find_device_by_node()?
> 
> of_find_device_by_node() returns a platform_device, even if the driver
> hasn't probed. Whereas driver_find_device_by_of_node() iterates
> devices bound to a driver.
> 
> If using of_find_device_by_node() API I could check the result of
> platform_get_drvdata(), and -EPROBE_DEFER if NULL (that pattern seems
> to be used by a few drivers). But that AFAIK only guarantees you
> reached the platform_set_drvdata() call in your driver probe()
> function, not that it has completed.

All drivers, except two, use of_find_device_by_node(), so basically you
claim they are all broken. If that's true, the core API and these
drivers should be fixed, instead of implementing here entirely different
pattern.

of_find_device_by_node() goes via platform_bus_type->sp->klist_devices
and devices are added to the list in device_add() after
bus_probe_device(dev), regardless of its success. Therefore after
successful first probe, you will have the same result.


> 
> IMHO the drivers using driver_find_device_by_of_node() for probe
> deferral are doing it more robustly than those using
> of_find_device_by_node()  and checking if platform_get_drvdata() is
> NULL.

Some are checking dev->driver, but this also looks buggy, because it is
called before actual drv->probe().

OK, let's go with this method. I dislike the difference from everyone
else, but it seems everyone else is doing it wrong. :(

Best regards,
Krzysztof


