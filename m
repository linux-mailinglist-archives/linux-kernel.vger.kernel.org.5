Return-Path: <linux-kernel+bounces-89502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F5086F145
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E2B1C21084
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4C85231;
	Sat,  2 Mar 2024 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rmGyBVWa"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E621210F8
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709396752; cv=none; b=XhmPL5II4P7iYsW/IRzbzLciBeAA8bvS8cJbu8c5lICxCqzMxzs+L9b4QuKyrZG5UW4ft64hUMvg75ellhvcM6tLj5wzkQbqF88D5JXlmxst5imrdIjxH2oCzbuyeu02BilaEwHLNFIjMlHGrQe/oG2Jf+Ql31edhVh97riD4OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709396752; c=relaxed/simple;
	bh=oJGULsLsxf6fS7IsYzwkBoVuhmacFce7CpOFBw/0XWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rXjrtzhB/OvQEHZRZledrhGOxzfMmeNRo9/cV97jXl4kckenctgtnW+ZsojsHSoxHdlK1oXug4TP+DBdCpPJKqVgbTUAq+A+WH7qIFmKrtF/wBILNW7pTYScVANexwkapoRYckuwfSbSSpoA8e16fBA6pltWYZ5Cd8uNI71h4Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rmGyBVWa; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d311081954so32092061fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 08:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709396747; x=1710001547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CbqILV4rK6u+CAer7NNb99+HqM7S4NT2y2Fn+EZe1xA=;
        b=rmGyBVWaKOQzQ+3BSP1nDBOJCBIlyL42Rq46UXCd3jCBUs/yz7LWL/lN6uJr66bG/K
         XmMdn/4Z055O5ABflNbMcqE+JH9/DSLktfn9hNCJaWssZKO+EnRWGlAeKfP5enW1iASu
         ziFTjPzn0tCRK+Np5bYCj/bOIDkmHTmbLAlmK62rajd0AF+XuY/dL831gkJJyP/EDwMR
         B85HifarEZN9894feDhrdwRVWdH/diqOda14eyJ4vUp/1jgiOtsXU6Fq42woEzWEREyv
         n1sHpmNlW24VGpnWWGDLp1Uo+9t6GABKNkow5Yifi5qK0lc4lEo01Lv4wMPwKMFuFQXH
         paiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709396747; x=1710001547;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbqILV4rK6u+CAer7NNb99+HqM7S4NT2y2Fn+EZe1xA=;
        b=Cco8oKgJ4MxNQHfCEwo7fuFeDCnZHhxmZ7wcwwBHUbMzifGrYSCaW31F0mwjyNDRRY
         FcPXwg6dFZW4Npim2YdiT/EEM+P/ccu482PwBvjrya6MCkDACekS8DSpPt3pWlHfYM2W
         I/O755N+zPHTqyZusWW2sBeEFhdsLyVHI3meq9CSCTLFDjl/2RvJ9D/xUSN2JznUrSOM
         gFQGdzxm75b1fKKg/JDX0VYWGnejlYjQv6sVOfi0NwZ1oV7r63mINeuwJrZPCL7u1Vpp
         e82464F4zI/jUm3nyck+JDwHSq3a0snQMFcJKe2FmR4bnm5AdMA7Zjh13tFlusqs3W/f
         W87g==
X-Forwarded-Encrypted: i=1; AJvYcCXt4egWnd9Inf0sG6cHFeLnR8nAn/+XWVH2VieodGuxmtQAWqZzP08WnYIgfaV4XuVsTZc7UoAf/WJ3SIybWyMkt8becRx5x7sZ8d+4
X-Gm-Message-State: AOJu0YyW1IlMK+sFTcGprEmsACcuUEYvEEJeoHQtVwF6p+4rRVVXzZwh
	TIdxktjcokXEGgssTykOx3Tx4td2cMG4IcNpooYZUQL4OivjPG0FTniPJXuWAdY=
X-Google-Smtp-Source: AGHT+IElLqegHXBfNqPM+6wXPAT+n2IC3SinbfrWM6Uue2+NZ6WkcpyLyEE7mnpntCmuSr44ALnoMg==
X-Received: by 2002:a05:6512:49c:b0:512:bb47:967c with SMTP id v28-20020a056512049c00b00512bb47967cmr3121853lfq.19.1709396747562;
        Sat, 02 Mar 2024 08:25:47 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id dj27-20020a05640231bb00b005667b411c38sm2285148edb.65.2024.03.02.08.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 08:25:47 -0800 (PST)
Message-ID: <66a2e36e-2fde-4041-8a1d-b0f7ae0b3f6b@linaro.org>
Date: Sat, 2 Mar 2024 17:25:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ARM:dts:aspeed: Initial device tree for AMD Onyx
 Platform
Content-Language: en-US
To: Supreeth Venkatesh <supvenka@amd.com>,
 Supreeth Venkatesh <supreeth.venkatesh@amd.com>, joel@jms.id.au,
 andrew@aj.id.au, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, robh+dt@kernel.org
References: <20240110033543.799919-1-supreeth.venkatesh@amd.com>
 <d4fe8b55-a1ea-4ce7-89ac-ce17e8ff4e45@amd.com>
 <dda6c22e-8f35-4c18-9fea-6a6295dee3a1@linaro.org>
 <023f6f6c-dadd-4933-ac2c-15dfe77bd90e@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <023f6f6c-dadd-4933-ac2c-15dfe77bd90e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/03/2024 22:02, Supreeth Venkatesh wrote:
>>>> ---
>>>>    arch/arm/boot/dts/aspeed/Makefile             |  1 +
>>>>    .../boot/dts/aspeed/aspeed-bmc-amd-onyx.dts   | 98 +++++++++++++++++++
>>>>    2 files changed, 99 insertions(+)
>>>>    create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
>>>>
>>>> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
>>>> index fb9cc95f1b60..2b27d377aae2 100644
>>>> --- a/arch/arm/boot/dts/aspeed/Makefile
>>>> +++ b/arch/arm/boot/dts/aspeed/Makefile
>>>> @@ -5,6 +5,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>>>       aspeed-ast2600-evb.dtb \
>>>>       aspeed-bmc-amd-daytonax.dtb \
>>>>       aspeed-bmc-amd-ethanolx.dtb \
>>>> +    aspeed-bmc-amd-onyx.dtb \
>>>>       aspeed-bmc-ampere-mtjade.dtb \
>>>>       aspeed-bmc-ampere-mtmitchell.dtb \
>>>>       aspeed-bmc-arm-stardragon4800-rep2.dtb \
>>>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
>>>> new file mode 100644
>>>> index 000000000000..a7056cd29553
>>>> --- /dev/null
>>>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
>>>> @@ -0,0 +1,98 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +// Copyright (c) 2021 - 2024 AMD Inc.
>>>> +// Author: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
>>>> +
>>>> +/dts-v1/;
>>>> +
>>>> +#include "aspeed-g6.dtsi"
>>>> +#include <dt-bindings/gpio/aspeed-gpio.h>
>>>> +
>>>> +/ {
>>>> +       model = "AMD Onyx BMC";
>>>> +       compatible = "amd,onyx-bmc", "aspeed,ast2600";
>> Undocumented compatibles.
> This is a new device tree file.

It's obvious, so what does it even mean?

Anyway, fix warnings.


Best regards,
Krzysztof


