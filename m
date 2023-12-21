Return-Path: <linux-kernel+bounces-7959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4026781AFB8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E939A1F2975E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091B816438;
	Thu, 21 Dec 2023 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ymp61CRE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B11208A2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c48d7a7a7so3572685e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703144484; x=1703749284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e3H+A+A2A0Iu6R6Q5Gw3uNtOBHWeA7g0CxKvBb0xiXs=;
        b=Ymp61CREDirdeoKjNTf8bx3n7GKSKgZlPmpbgkt0A3piCIUB7iOAuWTpL7ogaTReDO
         MS94AtxVKjBJL/iQjnVk0vKfb1VakfxP6ndkNdFnjYYvB99/EhSLllgXWG2Gj63wwRUZ
         WoNll6IsFfmwFrlLwu+HdHFXis2RF4XYzWnKcWtlcDqw5rysflVBWIAxMaf7dWMO6iV/
         k//0ctxIhK9lG2CrZ6iRFPLiQsRBchAngEnI3ZPUEwE+990I2V94MPbRh/aVlV9slDfo
         pF0ANehZ1XcKi45ppOUv9YekdgzgyYZVO5BtcpK14f/g1BmdD3yUJuuWMEdA0+7TuLLt
         1ZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703144484; x=1703749284;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3H+A+A2A0Iu6R6Q5Gw3uNtOBHWeA7g0CxKvBb0xiXs=;
        b=QiN9chDRDV9z7NvjqjhTtx2nJTt881ggfOuvoCGg/bmZjiYSjGyqduqxsgLoC5Yt6g
         9BYnUJ6sg3KHer7K8JpyOJiahgGmaI6Onn47qyVVwC+6tjSujLTO7Po7QwiKS+TxzKC+
         Wl/lZMpGTQ+IJUNIFNvVYNDDtzRWwH30xAnYN4+dfQvJxOfMp+MDItG8edOGpY07uB4m
         PeFN5dZkeFcm2k/Bw6EHV0C+vbvYs1+BDavImvkg82Lo+GxMe7G8rPekSJrRjjx/d3Od
         rLBlgNKuPniUlK+wmk75fOGCOULYEzP9DIKuKlnP8ExATNwrsYzdwg/tyJBxEoIuODs8
         Tzfw==
X-Gm-Message-State: AOJu0YzPxh6iGs41ZFBTWVAzrh/51caxJrFdEL+OTbWOcK+nA1WH7g0I
	VGsy6xO2SsYwnkmUczQIa4eiRA==
X-Google-Smtp-Source: AGHT+IF0w9SH6vM+8j42w2i5q5G1YaglqA/Y2vt+0fOQwzslfJ2iApbivhzltwHxvSOIjCtSrTI+fw==
X-Received: by 2002:a05:600c:510b:b0:40d:247f:3266 with SMTP id o11-20020a05600c510b00b0040d247f3266mr478314wms.42.1703144484020;
        Wed, 20 Dec 2023 23:41:24 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id k8-20020a05600c1c8800b0040d376ac369sm2219698wms.40.2023.12.20.23.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 23:41:23 -0800 (PST)
Message-ID: <db368449-f446-47e8-81b6-a11c2a872306@linaro.org>
Date: Thu, 21 Dec 2023 07:41:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] tty: serial: samsung: add gs101 earlycon support
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Peter Griffin <peter.griffin@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 andi.shyti@kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 saravanak@google.com, William McVicker <willmcvicker@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
 <20231214105243.3707730-6-tudor.ambarus@linaro.org>
 <1938fcf1-eb5d-4723-a6c6-d2fe2c6dd1c0@app.fastmail.com>
 <8808ceeb-35dc-4094-aec4-f43c7acd6174@linaro.org>
 <6962ac73-2f44-4c9e-8731-152087815454@app.fastmail.com>
 <584e036a-2ae7-4b88-a517-8f79c6baed4a@linaro.org>
 <914b634d-444c-4eae-bc7e-0f20d0629470@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <914b634d-444c-4eae-bc7e-0f20d0629470@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/15/23 08:01, Krzysztof Kozlowski wrote:
> On 14/12/2023 15:31, Tudor Ambarus wrote:
>>
>>
>> On 12/14/23 14:19, Arnd Bergmann wrote:
>>> On Thu, Dec 14, 2023, at 13:52, Tudor Ambarus wrote:
>>>> On 12/14/23 12:01, Arnd Bergmann wrote:
>>>>> On Thu, Dec 14, 2023, at 11:52, Tudor Ambarus wrote:
>>>>>> +static int __init gs101_early_console_setup(struct earlycon_device *device,
>>>>>
>>>>
>>>> It works if in device tree one specifies the reg-io-width property and
>>>> sets it to 4. If the reg-io-width is not specified, the iotype defaults
>>>> to UPIO_MEM causing the SError interrupt on gs101 which makes the system
>>>> unusable.
>>>
>>> In the case of incorrect DT data like a missing reg-io-width property,
>>> I would expect it to still fail once the regular console or tty takes
>>> over from earlycon.
>>>
>>>> Also, if the earlycon comes specified from the kernel params, the
>>>> of_setup_earlycon() is no longer called and the earlycon will be set
>>>> solely based on the kernel params buffer, thus allowing users to crash
>>>> the kernel on wrong earlycon definitions.
>>>
>>> But that in turn is the same as specifying any other incorrect earlycon.
>>
>> I don't think you can crash the kernel if you use other earlycon as you
>> don't make accesses on the 32bit restricted bus. But I agree that if
>> using the correct earlycon name, and mmio instead mmio32, is equivalent
>> to not specifying reg-io-width in dt.
>>
>>>
>>>> If you think the change is fine, I can amend the commit message with the
>>>> description from above.
>>>
>>> I'm still not convinced we need a special case here when everything else
>>> just requires passing the correct data.
> 
> We shouldn't need any data from DT for this case, because this property
> apparently can be inferred from the compatible. IOW, GS101 SoC requires
> reg-io-width=4, everywhere, for each node, thus there is no need to
> specify this property. It should be deduced from the compatible.
> 

The entire peric0/1 block requires 32 bit data widths indeed. PERIC is
used by the Universal Serial Interface (USI) and I3C. I've checked few
other hardware blocks and all require 32 bit data widths (G3D, TPU, TNR,
PERIC, PDP, MFC, MCSC, IPP, HSI, GSA and I stopped here).

If the reg-io-width shall be inferred from the compatible in the gs101
case, then this patch stands. I'll update the serial driver as well.

Thanks,
ta

