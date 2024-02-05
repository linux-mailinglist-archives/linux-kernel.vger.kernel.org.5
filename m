Return-Path: <linux-kernel+bounces-52695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9974849B88
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA481C21F55
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C073D1CAAB;
	Mon,  5 Feb 2024 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VM5zXxfp"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97B61CAAF
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138799; cv=none; b=kjqIJUr/LNRd+bB1ySotAv3jBORdAtO2Ty2nzMUm0JE/UeP8h0a/mimCwQmHYUrQaTg0SYauiSZC/EMmGv/JF8nPc3fJbGE8ZWziDwKRqzxbitghQbwmkpt5A4FdC0dadKgkZL6hHL/RP3ZB/AA4BSMJGuy4HfualY7NJXcEjqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138799; c=relaxed/simple;
	bh=J7BwmAF4DVPBkEhbPrhiuXp49SxTD95hiSL9JbWUGRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fbN6RS1eRp9DikVzxT6BbUYQ0JSikVTpw3nhqqQkDOml9Qw4rRYpzrJn89T/0ZseeK4LgktTZra1OszB+iHU4vNG6Ea+xoOTxREaGMsl8w/b8WzIKNy6SrowVJBpPn4TPDRAJqFevHdMe5QeBAf2/7kSORKS/FFX3KyWSKezUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VM5zXxfp; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5606f2107ebso1338782a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 05:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707138796; x=1707743596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z15Ywji8xO/ips4ilF/Fbhf+BJi3D/GTTWw3/PwWL2Y=;
        b=VM5zXxfpETE/r3hY+ccpYKvGustkysZfcmFczu+xpJkj4Ytc0n6N0B8zJHuWoUruwU
         im/Xn2jCQBPV8tzcP0Bd/icpVNDXMg/q9TgjaWCKa78Bj7dETkZsscDwgoti2C9nCYMN
         s+RyznRyK6fwSDbqkDoPW5NVhog+S4Ct0yjCWgVYZ7wbJnWCtkKtJynv1+b5uXoehe0J
         FclnE2v8XulzzoZgfn2pBHZH6keXtNll8GEMKvciozKhlSnmFQvX2EkaLt2RWtlh84B4
         u4yi4oTxY2BUQ1uVbX+ppFegVRNfJ4fq9OkNmFWVbcaboTzHJt6MGNP2gac1U9qySEVo
         A1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707138796; x=1707743596;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z15Ywji8xO/ips4ilF/Fbhf+BJi3D/GTTWw3/PwWL2Y=;
        b=MxeBWzE0EyzHVwbKcCA9x+EPx0VzfTZFduM9hXlN9hXe3t8zMCVlguyuyPD0eq6lGl
         Bv6I7b7vcXo0NF76YfITa4fW0qhvxBSeec0x6otrUsDVo2gDTrUuCdX328+yVN0/7osb
         Zo4/fFbp4/jChiYOdLvURXcKGf0GCNrbrUsxbxgy9ssVZAllhaWhBMxxK3u5+VjABxej
         JNTu8BYSa1eUtzX92yBCSK/Cd3aQVb9LyY8XdQOKKUqs0vbuv8ZCj44LNeXVZk4qc6jh
         8DIfwV9EFv3tGurZlPssv9qvFHEd4Xv2qohRVKHWwUww3Dts19JttSSx9lSQ6hQxnwMY
         DyDQ==
X-Gm-Message-State: AOJu0Yx+YBtQDxlAtGEJuMO5VmfFMShJp9eZcj0vZVM/QwLW+rQZHaQf
	5L57XkSvRmjazRsjJTUZcd1DOR+9SQe74EBTtPJqCQsQmZbXMaie//aNofySVTA=
X-Google-Smtp-Source: AGHT+IG+XHF7vcAfFTInTdPMzBUyJ09CO99vuQCXISIEifBpFH8R4uwF9B//DWGwi6lmrAfhTtCPxA==
X-Received: by 2002:a50:9e81:0:b0:55f:cc6d:29b5 with SMTP id a1-20020a509e81000000b0055fcc6d29b5mr5718315edf.21.1707138796095;
        Mon, 05 Feb 2024 05:13:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUcNhSSjC/PnZCkW+uwlSiLTPpuFGlmfBG2HSCFS3Fpep2Toym0g6k11JP69LQ55H7MnrAlvU6Vu8ml1O1XjI0YjE4zAfRw/GmuPTaZwrgJmog7Z5Ne+4TWkGcH/H7WjY8BX113C/fd08gcfNsZUS+UK6qj4onKJJI0C21tuZ6BHEWXnmBwNwgABTJXA0GnkG/d0rHE0G4LUsTpC211w0d7O/9x2QYMP/Jb8OVKONc8ZbwZYN75yNzhGwTEh0iF+wr5y2nST/uGhKMoxmF6nToo04m3FpMsAOVISIMPZYjuWco/sgVpnL7M9SmNum+AXOc/KmFDrTgRx4MMf9P0ac7fayqzXh57RgLiGKgw5KntFI+1Qpk+03HcEJV1VbC3XUzJ9BvFjNn7htM0WUXhnNMzLorTheJBRYRd+vaC+Jsz6nvpqkvP27CRv2Wnz4oTG8TqL/1jD24rl/r5zlS3mt5jmNEc7CPYK/WJPQiFzJm42VsgfdKclgzizaV6Xu3lUGdsVW0wnGT7Qcg9TVcTMXGAV6oIIRpI4hUEPcEiUvqkBgkMhISasv/UVH5b4yotI5glxAgzZZahgvU5P25Os9zJsOQ1hDTTVWu57qntfxsbN33RlnbSM21fClanNvM=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id p26-20020a056402501a00b0056012fe9d4fsm2837141eda.76.2024.02.05.05.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 05:13:15 -0800 (PST)
Message-ID: <99828589-c0b5-456d-b250-6ad3e6085a91@linaro.org>
Date: Mon, 5 Feb 2024 14:13:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] soc: samsung: exynos-pmu: Add regmap support for
 SoCs that protect PMU regs
Content-Language: en-US
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CADrjBPoQmTRsFYRtxBxdvAoKK816O8XN3=hOJ3vBt8wbbbk-=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 13:51, Peter Griffin wrote:
> Hi Krzysztof,
> 
> On Tue, 30 Jan 2024 at 16:01, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 29/01/2024 22:19, Peter Griffin wrote:
>>> Some Exynos based SoCs like Tensor gs101 protect the PMU registers for
>>> security hardening reasons so that they are only accessible in el3 via an
>>> SMC call.
>>>
>>> As most Exynos drivers that need to write PMU registers currently obtain a
>>> regmap via syscon (phys, pinctrl, watchdog). Support for the above usecase
>>> is implemented in this driver using a custom regmap similar to syscon to
>>> handle the SMC call. Platforms that don't secure PMU registers, get a mmio
>>> regmap like before. As regmaps abstract out the underlying register access
>>> changes to the leaf drivers are minimal.
>>>
>>> A new API exynos_get_pmu_regmap_by_phandle() is provided for leaf drivers
>>> that currently use syscon_regmap_lookup_by_phandle(). This also handles
>>> deferred probing.
>>>
>>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
>>> ---
>>>  drivers/soc/samsung/exynos-pmu.c       | 227 ++++++++++++++++++++++++-
>>>  include/linux/soc/samsung/exynos-pmu.h |  10 ++
>>>  2 files changed, 236 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
>>> index 250537d7cfd6..7bcc144e53a2 100644
>>> --- a/drivers/soc/samsung/exynos-pmu.c
>>> +++ b/drivers/soc/samsung/exynos-pmu.c
>>> @@ -5,6 +5,7 @@
>>>  //
>>>  // Exynos - CPU PMU(Power Management Unit) support
>>>
>>> +#include <linux/arm-smccc.h>
>>>  #include <linux/of.h>
>>>  #include <linux/of_address.h>
>>>  #include <linux/mfd/core.h>
>>> @@ -12,20 +13,159 @@
>>>  #include <linux/of_platform.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/delay.h>
>>> +#include <linux/regmap.h>
>>>
>>>  #include <linux/soc/samsung/exynos-regs-pmu.h>
>>>  #include <linux/soc/samsung/exynos-pmu.h>
>>>
>>>  #include "exynos-pmu.h"
>>>
>>> +static struct platform_driver exynos_pmu_driver;
>>
>> I don't understand why do you need it. You can have only one
>> pmu_context. The moment you probe second one, previous becomes invalid.
>>
>> I guess you want to parse phandle and check if just in case if it points
>> to the right device, but still the original code is not ready for two
>> PMU devices. I say either this problem should be solved entirely,
>> allowing two devices, or just compare device node from phandle with
>> device node of exynos_pmu_context->dev and return -EINVAL on mismatches.
> 
> Apologies I didn't answer your original question. This wasn't about
> having partial support for multiple pmu devices. It is being used by
> driver_find_device_by_of_node() in exynos_get_pmu_regmap_by_phandle()
> to determine that the exynos-pmu device has probed and therefore a
> pmu_context exists and a regmap has been created and can be returned
> to the caller (as opposed to doing a -EPROBE_DEFER).
> 
> Is there some better/other API you recommend for this purpose? Just
> checking pmu_context directly seems racy, so I don't think we should
> do that.

Hm, I don't quite get why you cannot use of_find_device_by_node()?

Best regards,
Krzysztof


