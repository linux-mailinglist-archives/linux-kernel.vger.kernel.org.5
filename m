Return-Path: <linux-kernel+bounces-84642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F337186A967
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90AB283D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120E02562A;
	Wed, 28 Feb 2024 08:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lyLr/mYY"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED5928DA4
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709107201; cv=none; b=A19C9IPgBz8KP9A0EHyC+Nb07GZP7PG0nnHqZh3X/Iebvr9UayfiJtbKvbh1oN2BYLMeVJiWRP3CjazWjVawgQTi1o84kDgd4ByX5v+sW6qIksp6HU86z+483m2U0E6RaO8gCnRmzBEHp32YzgltTXoc6kXM/IoSBvl+jVx195c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709107201; c=relaxed/simple;
	bh=3N18emKIlP5QmEwPUM9ApVmjt2ga6IPBuuwqZU0Y/N0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zc9pfNeaF4lGsYZFFT8lVKL3MkpQxh3WmuPwyYIXIXXX6jr5aWdky3a8HAaN5Am4v6Q+0bePe/LovRaJ0p6HcKCLtQEQJ18i8Va1pKT5y00wG9r0AIZGfsFYEFb992qgvegrVjElKp+bLC6MamxM1NITQ9J280fdtdUWX9UsjjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lyLr/mYY; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3d484a58f6so724461166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709107198; x=1709711998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/14vQsrFOdxUXgpNs/rZdUJ/cXdTf6EY3SxQD70V1bw=;
        b=lyLr/mYYpVVBWi6QLFtp7oZ4n1oOsab/VxvqDmIEnm2e/xj/sF73OhoIBlxY4dmObz
         zInMQUkt1TJgIDTYcaeL+macU4NJIoYKV0aFibVE9QnCXhc/3L8hGJbIQhht6tJ8A1QS
         f+JLhQRuoukuh1KPB3adO7SjAU+k2KZUIxgwQGL8uj8dcbedROP8og2EoC3LZjqFHJOT
         1TRv4jy4aj6YTbWEB2jZcwFZQWGdCDiroyQFBB38cbiHSdijvLYzIUBRNVJqszve9i1e
         wkOcwBEABFDYzWbHVyfHDAM9j7Lb3fyGYrfi0nVXK5ERIa55iNTpw9D2XYZpvG9uZByq
         c4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709107198; x=1709711998;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/14vQsrFOdxUXgpNs/rZdUJ/cXdTf6EY3SxQD70V1bw=;
        b=gSv4wSgO8TIir98jcdvv7tdDQ1I1+pl4L2ifmmfBMMai7vNfSYfSiTkNMz1seK3jQI
         +4LT/GQBTFGjY/nFEBrq2+aX39iX6/25wRqyq4Evyh5dXgM46C331xk57y8f7zXhoNDP
         9UFNCqo/XJCEcrVMzvfcDNuj2R2O7dYygnhaj4ByLtt8PX4SyybO13uVx8VtWP13cbmB
         6TjrWw+1IGXvdQKTfaEH9UBZMExNeoI80Wpo7kaIv97SuDdRLG3IB6EZNlkuITd8uHnJ
         Z0RK1HwubFsM86yAd7Fbbne1wTP3MpvKr5z8GB87avX/9tvi1FaHxmWRpjQL+F7S6d0x
         j0ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYpZ8wsxLQLnVDnNXudUmEf/q4iWz2GMFtiOl7tQ5xa4PcoB7UjCa+oLjQAI6RldH5Nj9eWjU4JQcmrqfKbwLG7x5j0PJLLVpYRFcn
X-Gm-Message-State: AOJu0YzJZPR9GC+CtQLhv+vsNlq0L0jeRyywoKlSkAe+MPo5EkZGteTd
	PIn881omfpB4dgPDX/6JMOUmGmKXfVfjMXzqPlKzBMdpZV2tOR49bdpZ09Z1uZY=
X-Google-Smtp-Source: AGHT+IFzVfE+aPNDJBvGSFYbvze6Z1NowzUGHzzhTNQi4YFijcOZ8a9a0TA8Eygjf9M4sYtozP3hpg==
X-Received: by 2002:a17:907:b9d7:b0:a43:83dd:1e4e with SMTP id xa23-20020a170907b9d700b00a4383dd1e4emr4247219ejc.29.1709107198088;
        Tue, 27 Feb 2024 23:59:58 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id f3-20020a170906c08300b00a3d1c0a3d5dsm1568860ejz.63.2024.02.27.23.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 23:59:57 -0800 (PST)
Message-ID: <44d0b0cb-e366-45bb-b24f-a8386cae21d8@linaro.org>
Date: Wed, 28 Feb 2024 08:59:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindindgs: clock: support NXP i.MX95 BLK CTL
 module
Content-Language: en-US
To: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Abel Vesa <abelvesa@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240228-imx95-blk-ctl-v2-0-ffb7eefb6dcd@nxp.com>
 <20240228-imx95-blk-ctl-v2-1-ffb7eefb6dcd@nxp.com>
 <1ad77c33-71de-4bc8-a53e-1e74a5096079@linaro.org>
 <DU0PR04MB9417459448EDB8A674827DD588582@DU0PR04MB9417.eurprd04.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <DU0PR04MB9417459448EDB8A674827DD588582@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/02/2024 08:54, Peng Fan wrote:
>> Subject: Re: [PATCH v2 1/2] dt-bindindgs: clock: support NXP i.MX95 BLK CTL
>> module
>>
>> On 28/02/2024 06:43, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> i.MX95 includes BLK CTL module in several MIXes, such as VPU_CSR in
>>> VPUMIX, BLK_CTRL_NETCMIX in NETCMIX, CAMERA_CSR in CAMERAMIX
>> and etc.
>>>
>>> The BLK CTL module is used for various settings of a specific MIX,
>>> such as clock, QoS and etc.
>>>
>>> This patch is to add some BLK CTL modules that has clock features.
>>
>> Please use subject prefixes matching the subsystem. You can get them for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory your
>> patch is touching.
>>
>> There are some typos, so you miss my filters...
> 
> Ah.. ok, will check more. Please ignore V3.

Why do you send three versions the same day? Give people chance to
review. One version per day is the max.

Best regards,
Krzysztof


