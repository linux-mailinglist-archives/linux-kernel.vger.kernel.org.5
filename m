Return-Path: <linux-kernel+bounces-129113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F60896524
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939C828255D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866F456B68;
	Wed,  3 Apr 2024 06:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xp7UDEAy"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932055E74
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 06:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127416; cv=none; b=GDuCRMeW1JYrfki7oFMBF8RMjOlnughNytIYzn0pbODMRMDk4Fzoid3TWJnqJKVMDpJpnjf0hBZHLVaab/asT19ROOQIB1Q/rI3kXHV/jyXMMnSgYvkqfv3lDMLBFxPvBSd8tbMsR1BFWXaopcKObKPSxNjfKtbkxwthqFibEPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127416; c=relaxed/simple;
	bh=f+q/StljaB1S8TLkEx5I/uMxp6wwUZnh0WqjPDNxsUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9G2aL9nGzp1Oa8vDmLuD9oiES9cxoNBMqU9cPcBkn9VWDXFE1OjDmwBCwoxV+iv22r4frRHYTUp6H3iaEKHwjMXelaLWCUmlbx9kKbo6tS5HKp1ggOKNBTaGeiBb+ZbqMPMJSK89jtnQ7t2P0PTQg8ZtEZMeP655c9vd91+Zts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xp7UDEAy; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso8795339a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 23:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712127413; x=1712732213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2LLHLweBnC/A4Inn3QBZB0cfVArcIS5qzK+VqPYegTY=;
        b=Xp7UDEAyMRJ3zoIKWGjOJdFmduMNm14UDhbkaBE7dhsex0MVKVTjOScnmolNn9XZzF
         dPoz/jT8EHKJurr78f5eE/uArOuoswOXQJ7Q21IuNkTTtP2RK2urfqDoj7FOjv3nfEa6
         Flyhsy2D41+Y3VFCzEfwa7Cikm8snObPp1IxyEuUkzw2ePkJoJ3h/APwElFZwc1ukpvy
         SYmvTfWO4CZc9e0x9Log/LQUmLDwhLkfRN9xd/Kf428703ZorQ7jBZI/WyXJLRQVZhzz
         htbt7O7lWqSzEIt10bU8yhvZCRRQMhUk6z+EMrE1X47mdco84nsPnDXqV0IeiS6asjXx
         qChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712127413; x=1712732213;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LLHLweBnC/A4Inn3QBZB0cfVArcIS5qzK+VqPYegTY=;
        b=a+cqaNL1OSf0URttvzmYEj3qCpL5S/O33pbZ5TTXNKyHGhL08t0dGqCBpqCpNWxilM
         A49pID0HhlfHYov2IjyfohWzkBX6Eya7XdViP5ZrWrH49VL6IsWTzkyxRosZcWqD0v0E
         WkscPwbFQMy5/Ijwvpx/1bNQTPgZVKY5MbUc2koM7QViEpUOgkrLDfON88AGbVZqtpMs
         eHLzCJlKJGNQ6LT5RWx3PeJcQnGjUweN2XAda0Ero/lcvuTNzAmo0yQsrfgbL9qmnchE
         jIkb/TbhbiSy4ROKdEtmIKvLYdHWtSKfhMtJ9SVePCs79eLyDBlHLhBP0YPbJwxz8rLh
         5OjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwpFCCfflaiMXwyZ30BBt6Z22YFV0pOlVlE8cu7+ws+mM0q6LHdOfkFcimJeguPwHBdut6trOBd78RgPgy341ScLHDn5RPGnB/95fe
X-Gm-Message-State: AOJu0YxBssxV57u1xD8vTiZG+yh+1ug3bG0wyDIlu7o0N6bms0FKibT/
	C1Fp0qBh86rWVBMPBM2qx+YojXibRdrtKwNe/bcGF7x7+fzOcUC4ZHovwBgrOPk=
X-Google-Smtp-Source: AGHT+IFto/6DjID+G8YvVM3HsTGozfRdFHnQLOECeAtwELsOd5Qk5D3QGQ1SnQUhsQ5nkDOTM9ipxA==
X-Received: by 2002:a17:906:2a15:b0:a4e:2873:e94b with SMTP id j21-20020a1709062a1500b00a4e2873e94bmr9429279eje.6.1712127413312;
        Tue, 02 Apr 2024 23:56:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id wn2-20020a170907068200b00a4e781bd30dsm2550482ejb.24.2024.04.02.23.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 23:56:52 -0700 (PDT)
Message-ID: <c51653d1-1a76-45de-93e0-ee5d341649e9@linaro.org>
Date: Wed, 3 Apr 2024 08:56:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/2] dt-bindings: make sid and broadcast reg optional
To: Jon Hunter <jonathanh@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>,
 robh@kernel.org, conor+dt@kernel.org, maz@kernel.org, mark.rutland@arm.com,
 treding@nvidia.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, amhetre@nvidia.com, bbasu@nvidia.com
References: <20240402132626.24693-1-sumitg@nvidia.com>
 <20240402132626.24693-2-sumitg@nvidia.com>
 <025ed42a-c6f2-48e6-a8d1-b6de79d6957b@nvidia.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <025ed42a-c6f2-48e6-a8d1-b6de79d6957b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/04/2024 21:15, Jon Hunter wrote:
> 
> 
> On 02/04/2024 14:26, Sumit Gupta wrote:
>> MC SID and Broadbast channel register access is restricted for Guest VM.
>> Make both the regions as optional for SoC's from Tegra186 onwards.
>> Tegra MC driver will skip access to the restricted registers from Guest
>> if the respective regions are not present in the memory-controller node
>> of Guest DT.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   .../memory-controllers/nvidia,tegra186-mc.yaml | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>> index 935d63d181d9..c52c259f7ec5 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>> @@ -146,17 +146,17 @@ allOf:
>>       then:
>>         properties:
>>           reg:
>> -          maxItems: 6
>> +          maxItems: 4
> 
> minItems?
> 

If the intention was to make it variable, then yes, missing minItems.
But more important: why patch was sent without any testing?

Best regards,
Krzysztof


