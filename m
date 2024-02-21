Return-Path: <linux-kernel+bounces-74199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5718085D107
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D621F26B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC54D3A8E1;
	Wed, 21 Feb 2024 07:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LKLBM+pF"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB583A1DA
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499632; cv=none; b=Ta4rT7z6/7LWl7VL2p4Tc+5qe228CnGuwk+AG9Ei90QCOlQBJ1EpOwYUY4xzbi55Iw9oNPGb1VyWo3eGR9ZND/VhgHt3CBNiyEHkXs6AQLm1Wojia2NozsQfUu0xRti1Ub1yLqYKFfWKLLBt4I6v9w36NKF+WozZCICmVVF+nkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499632; c=relaxed/simple;
	bh=sm7aYXSJG8Hcgc7YVjS0YUnjzNl03wLN6NHSIs+5RfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mc45LSsG+woZ64GEpqm07yS9p43ZE8J8uA7ZTH6k2SDVJuQuOwk5RsvD1D09S9spHLMofRcA7pjKQIfx50YIQ8t/ZYiioFo39XcYQF/v/qwl96atSS9K0e5X5GOqdOs3+jTNaZpN+yX5xYgSs4fqS2MAyGs+HzgyKAhZImBwPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LKLBM+pF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3e7ce7dac9so373684766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708499629; x=1709104429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lj6G8JZlNb0ydBBYXexPWzfMBPbLnVkovsLWtWCOKI8=;
        b=LKLBM+pFNxwep6TEu6aufC1mQdsP4V1Lu9aIgqbIpb47ne5TNfD9t8SPj/3PkJ+886
         /uW2pi1hrc4yuIq2vEgBq1qleSU+s7XRujjYq0PsKPeMv9qQ4pIKXC0DYOW3zz4Pzl8e
         FIYL9xHUAQOKgR7LaLOscrQ0ITwVUtiwyTIRamX+bHfjGzwE1DCusTEHN33r0B/0Ai45
         cwe3ERjdQBBLrJTTxRn9DdWu9v+umS4R4M8EYIIZjTBTmZYf2NwSvoxQE9pckZDkxOeN
         uGXkGLAI0DchQLLpnmowMPNLRxRNdCSQLy/aYhjGnYua1OcMFc29ygKkzvPLm1Gj4XD9
         uF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708499629; x=1709104429;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lj6G8JZlNb0ydBBYXexPWzfMBPbLnVkovsLWtWCOKI8=;
        b=oi1Bj0f7XaRwF6kGhzY2SXFwaP/bAE7iHQaD19pJA8A3j8EPDPKlN/P2CRtoFwKDEz
         Erv7OT1SCDpi1cj8kLRiErxYX5c4FUnYkzfVzn1LWYB2Yc/y/TxB6Uc8fuwStbr58V9a
         2uHryfPIUfxk8t2dMOQWyhAeK0id7VEAni3NprU+rO1NKEj8VjODnsF2s+5TMrS6MReY
         Fj4/aJuEv/mKCPFe/lwee+dkY9mFqBiw3rEbXruKid/N7A9fNmt9XMvRCbioaYPe5oLD
         JV/GXveorcUJgQs0SLxYE7pbMuuBq/cV6ZM+LT32JRw1Tf99GEC1xGHaDWQle+L/Ho/Y
         AbEA==
X-Forwarded-Encrypted: i=1; AJvYcCU+GAGuXCpPx8bKqzMpQkQXVPoT+1zSU0kXRCrbFjoaqLjKSQr0tNEPJ2db2oo/rnrogw6ifu9ycr7VzLzc2KQb1APo+qZKwbz+JTMG
X-Gm-Message-State: AOJu0YwYT/4eqQq1BlEQpPSPOvHJeeWbhUnyX2PKBDWliKKTNS66hBsd
	DlKlSTQJoEfTcNBfK+aMek+2TpZk7jULzVkvBz/ic9pvzT+ba0++tpDJ6k+SpMw=
X-Google-Smtp-Source: AGHT+IGMgyZUNqmxcjMbb7mMKrPL7LtX9airZjvk8iggZudIU2hMGM0jsJm7YuVneGwLQlAFnz1fKw==
X-Received: by 2002:a17:906:bc86:b0:a3e:389b:caa3 with SMTP id lv6-20020a170906bc8600b00a3e389bcaa3mr9013178ejb.53.1708499629371;
        Tue, 20 Feb 2024 23:13:49 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906c19000b00a3cee88ddc7sm4742557ejz.147.2024.02.20.23.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 23:13:48 -0800 (PST)
Message-ID: <6c4bdd9f-6b1f-43a0-9baa-7c1eedd46f76@linaro.org>
Date: Wed, 21 Feb 2024 08:13:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] interconnect: constify of_phandle_args in xlate
To: Alim Akhtar <alim.akhtar@samsung.com>, 'Georgi Djakov'
 <djakov@kernel.org>, 'Bjorn Andersson' <andersson@kernel.org>,
 'Konrad Dybcio' <konrad.dybcio@linaro.org>,
 'Sylwester Nawrocki' <s.nawrocki@samsung.com>,
 =?UTF-8?B?J0FydHVyIMWad2lnb8WEJw==?= <a.swigon@samsung.com>,
 'Thierry Reding' <thierry.reding@gmail.com>,
 'Jonathan Hunter' <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org
Cc: 'Thierry Reding' <treding@nvidia.com>
References: <CGME20240220072224epcas5p4ff60556b0b5632abfc44d2b8ad932b8f@epcas5p4.samsung.com>
 <20240220072213.35779-1-krzysztof.kozlowski@linaro.org>
 <1d9b01da63f6$daeb0170$90c10450$@samsung.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1d9b01da63f6$daeb0170$90c10450$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/02/2024 13:18, Alim Akhtar wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Tuesday, February 20, 2024 12:52 PM
>> To: Georgi Djakov <djakov@kernel.org>; Bjorn Andersson
>> <andersson@kernel.org>; Konrad Dybcio <konrad.dybcio@linaro.org>;
>> Sylwester Nawrocki <s.nawrocki@samsung.com>; Artur Świgoń
>> <a.swigon@samsung.com>; Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org>; Alim Akhtar
>> <alim.akhtar@samsung.com>; Thierry Reding <thierry.reding@gmail.com>;
>> Jonathan Hunter <jonathanh@nvidia.com>; linux-pm@vger.kernel.org;
>> linux-kernel@vger.kernel.org; linux-arm-msm@vger.kernel.org; linux-
>> samsung-soc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> tegra@vger.kernel.org
>> Cc: Thierry Reding <treding@nvidia.com>
>> Subject: [PATCH v2] interconnect: constify of_phandle_args in xlate
>>
>> The xlate callbacks are supposed to translate of_phandle_args to proper
>> provider without modifying the of_phandle_args.  Make the argument
>> pointer to const for code safety and readability.
>>
>> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> Acked-by: Thierry Reding <treding@nvidia.com> # Tegra
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Changes in v2:
>> 1. Drop unrelated gpiolib changes (Konrad, Thierry).
>> 2. Add tags.
>> ---
>>  drivers/interconnect/core.c            |  4 ++--
>>  drivers/interconnect/qcom/icc-common.c |  3 ++-
>> drivers/interconnect/qcom/icc-common.h |  3 ++-
>> drivers/interconnect/samsung/exynos.c  |  2 +-
>>  drivers/memory/tegra/mc.c              |  2 +-
>>  drivers/memory/tegra/tegra124-emc.c    |  2 +-
>>  drivers/memory/tegra/tegra124.c        |  2 +-
>>  drivers/memory/tegra/tegra186-emc.c    |  2 +-
>>  drivers/memory/tegra/tegra20-emc.c     |  2 +-
>>  drivers/memory/tegra/tegra20.c         |  2 +-
>>  drivers/memory/tegra/tegra30-emc.c     |  2 +-
>>  drivers/memory/tegra/tegra30.c         |  2 +-
>>  include/linux/interconnect-provider.h  | 11 ++++++-----
>>  include/soc/tegra/mc.h                 |  7 ++++---
>>  14 files changed, 25 insertions(+), 21 deletions(-)
>>
> 
> For Samsung/Exynos
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

Review tags are per patch. You probably meant Acked-by.
https://elixir.bootlin.com/linux/v6.8-rc5/source/Documentation/process/submitting-patches.rst#L544

What is there anyway to review in Samsung? Adding one const in one driver?


Best regards,
Krzysztof


