Return-Path: <linux-kernel+bounces-42293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D41883FF34
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827BB1C21D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970F44EB53;
	Mon, 29 Jan 2024 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5y7kh2c"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC9E4EB22
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706514239; cv=none; b=g6yeSkpZ9nqhItyfy3bpFgWKnBA2nxlO4igbKAO4fxWQuiCWVnpmsyTJgk5DLUpp0GuDZEZ/xm4lRIEmnIO4IivBrGnkBmukG0TdiTNELRZuf1BGXK+zJ2/wzr0w7YiEdLaFobKS0VRJvQ545/IpcfVyO0LYL3YjJEKmalHkWkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706514239; c=relaxed/simple;
	bh=5AbHdlOANK+zR4W769BjEvaECm5Ss/OxiiM0vngY+BY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=op5aP6+gbbJPA9ax7ky9IH5vakIf/kdraTrJuJXUBq1Y1ANKb97lsw6qSRiNPlaZOCnbTKOUHKFaIXA+fw7sehPYjQUaQVNstzXp23TOlAm3E45yFTQJLYj9APgFzAsxb5ASo949eOxuYY3vBNCIHaZrtArHiBYUAyYBCIJf1k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F5y7kh2c; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so2814000a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 23:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706514236; x=1707119036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c7+z8Bo3SMKPmqkIq6XWSLwjJi2bKC7rawiiewwddD4=;
        b=F5y7kh2cYiBBvQsKDbGrrNBNfe5AlT1mivUxuYk5gyVEuqzMBMxZSaLIg/QNbZpG6T
         T9dD77LXCWjHoIMm2l/PxQYOIQMkcon7fIyMbKOvKe6GtkjPe9qzZCgEj8yybLhCZ7CO
         02x9oL9Wcu6srkLm6P19pzXOfrwT9JBcTaS3RcHg1pa7uyOaH3lBBufe8iJzsLkhr+hB
         zyOq5KnlBpMWjegJl6H5AeMaYZKg/siweULu8rjmR6jOsatZxiQwuqotfaYJvSQVkKd7
         wOswIP61rl60ERWb0s31diH8JbU7GGKU1yZI+bBMJOOeF2xHRB6M3PsS6vbvZs56VAs4
         Z0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706514236; x=1707119036;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7+z8Bo3SMKPmqkIq6XWSLwjJi2bKC7rawiiewwddD4=;
        b=jnsuK8XBw9hxiK8b59UM0VJsY/RNEtxWrluzC3UtbYHVq/D+vs8aRsa9y0XJ1osS+u
         swcRz0trp+pcopk16QyeS7seNXJfcdyGKDbxWZ41BmC0f8bk7ovcyM8jrdK7/VPqCpRN
         v6FCspsVczkGsW7C4LiZV0HCuX0h2zbQfdRAR/w3IZlSLerfwstbvvmX914Hv+NFFvnP
         SLHUzrU3ZaMNFHMBqrar+2RMZHNLv1oNT4VQJqnKBex4Y69KchRlL3PEr1zcVBnbNzm2
         4+Bc1UkUxqq5OLmEKsRWYDZi4sTaZjohlJ7SSSDWTcExvX0qtwybx8qlHeLN24IwKngg
         RA0Q==
X-Gm-Message-State: AOJu0Yyo+phrd7Tp2uM09+R93k8gHV+BBxcZL5+TOPac2rBdaFdAUO3E
	JK2Q33op++cG/IRTPoUfCWCgwZZh0T9ekOPXgVK54P+pES2q6cmDr4zjC71T/QY=
X-Google-Smtp-Source: AGHT+IFGImNLs6BdVWrzpFMBfko812D/Jw24sL7/kmvcUI1SwGsK8mJ3icm0eONoT7Smx/eBy6ZIzw==
X-Received: by 2002:a05:6402:35c4:b0:55a:5891:aa4d with SMTP id z4-20020a05640235c400b0055a5891aa4dmr3747405edc.33.1706514236232;
        Sun, 28 Jan 2024 23:43:56 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id bt8-20020a0564020a4800b0055ec36a811bsm2129344edb.18.2024.01.28.23.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 23:43:55 -0800 (PST)
Message-ID: <084bc712-caf8-4e4f-b277-2f9d85926067@linaro.org>
Date: Mon, 29 Jan 2024 08:43:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] dt-bindings: power: reset: add bindings for NVMEM
 hardware storing PSCR Data
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>,
 Rob Herring <robh+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, kernel@pengutronix.de,
 linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
References: <20240124122204.730370-1-o.rempel@pengutronix.de>
 <20240124122204.730370-5-o.rempel@pengutronix.de>
 <4e14b7c7-7f0a-437b-aa84-20fdc30a2361@linaro.org>
 <20240125171146.GC381737@pengutronix.de>
 <58d24ddc-4e8f-4932-ac37-c9a699d36425@linaro.org>
 <20240126165153.GA468528@pengutronix.de>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240126165153.GA468528@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/01/2024 17:51, Oleksij Rempel wrote:
> On Fri, Jan 26, 2024 at 10:03:51AM +0100, Krzysztof Kozlowski wrote:
>> On 25/01/2024 18:11, Oleksij Rempel wrote:
>>> On Thu, Jan 25, 2024 at 11:57:18AM +0100, Krzysztof Kozlowski wrote:
>>>> On 24/01/2024 13:22, Oleksij Rempel wrote:
>>>>> Add device tree bindings that describe hardware implementations of
>>>>> Non-Volatile Memory (NVMEM) used for storing Power State Change Reasons
>>>>> (PSCR).
>>>>> +  that stores Power State Change Reasons (PSCR).
>>>>> +
>>>>> +allOf:
>>>>> +  - $ref: pscrr.yaml#
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: pscrr-nvmem
>>>>> +
>>>>
>>>> So that's a driver :/. Maybe Rob will like it, but it's a no from me.
>>>> Please come up with something really suiting DEVICES, not DRIVERS.
>>>
>>> If I understand your distinction between 'DEVICES' and 'DRIVERS'
>>> correctly, 'DEVICES' in the device tree context are meant to represent
>>> physical hardware components, while 'DRIVERS' refer to software
>>
>> Yes.
>>
>>> abstractions of these components. However, there are numerous device
>>> tree instances, like software-based implementations for SPI, I2C, or
>>> GPIO, which could also be interpreted as 'DRIVERS' in the context of
>>
>> True. Yet they are still for physical interfaces. There is no DTS having
>> some virtual I2C for a board which does not have I2C.
>>
>>> your email. Similarly, the binding for PSCRR represents functionality not
>>> fully implemented in hardware but supported by the hardware component of
>>> NVMEM, akin to how ramoops or other functionalities are represented.
>>
>> You don't need a binding for your case. Instantiate it whatever you wish
>> - modprobe for example - and configure through approved kernel
>> interfaces - sysfs for example.
> 
> About using sysfs for the NVMEM cell, it won't work for my needs because
> I have to know about reboot events before the filesystem is ready. So,

initrd can configure it before mounting filesystem.

> I'm thinking of using a boot parameter for the kernel. It would look
> like this: pscrr-nvmem.nvmem_cell_alias=nvmem-cell0. This way, I can set
> up the NVMEM cell right at the system's start. I'll need to use stable
> NVMEM cell names for this. Is it ok to introduce NVMEM cell aliases in
> the devicetree?

In my opinion no, because the point of Devicetree is not to solve your
system init problems. You add pure software node which should not be in
your DTS for many reasons: it is not a hardware description and it is a
 software policy enforced on all users of DTS without actually
consulting them. Also, this solution ignores ACPI systems. Developing a
proper interface would work on ACPI as well.

Best regards,
Krzysztof


