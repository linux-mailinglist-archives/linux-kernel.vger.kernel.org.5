Return-Path: <linux-kernel+bounces-55053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED3C84B6F1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939601C2393D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693F813175E;
	Tue,  6 Feb 2024 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uCnE3us/"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBD1131736
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227568; cv=none; b=Dqd+LWuka+Z3FUYGg33e01SvXnsBCwaHiOfWe/0jQ118Szia/i9t2GScBbfTTcC1t8vLPu7BfOtHTf4ZjzcZqJEQ2K+vU6kQOyolegQlaASTITkMs0aJ8luOZmQoigWaYNnPP57LEVf7rXWt5L7phrHsGsjuJg+lcqLUfVSdq9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227568; c=relaxed/simple;
	bh=cxKKyV4U1iYb7es+ijrP2Z8sDWgNjJ3Ft5xTUdTfIjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nq3/OpAYMsHhJfmnm5LODOuhGvSj877u14ZPohYKOn72CaNMrgTYopr+ceQzpIweuydMhbtjwS8qZwwOD1cETbnkcyLXq0PqVzZEy7DCCIUsFS395xZbm+DY3kJaM0iTaiBZTgSPAR4/5bVx3snsWaXLCN4tUce2lG05kqhOLRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uCnE3us/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40ff0bb8052so2317715e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 05:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707227565; x=1707832365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q5+il3Q4JooGpJcjPwkL152K3WCQCZ42apDFBFqdO08=;
        b=uCnE3us/crKFdxhDPAi9bvGPPYg5UhXBuNNnSZrgARCDwLJJqkoo//w3NUel34MBvr
         ZmiO2S6Ob6H97rg0AjAYvtOliOWyso8YmmU8ynGBoZb+SdmCaMhralN/cAtuRlo2ZWp0
         xZ/eUhsCmcnJZoFNnpJiAoFzC6e8D3z9T5Z/qKKas6AiJ6/A5216JVRpRf+kZwMi054l
         6R4iBE/ZNPECCPLAoxUk2MPYaesDs22Utoq5goexff97EC8amu7illF30371tlSi9oxx
         CkI0YB9YW8nSMJ9QSMu23H2zNvmYTVVsofh6N2ON2/pjj1sE5LpHXEd3tw9Slca3+w3q
         ljWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707227565; x=1707832365;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5+il3Q4JooGpJcjPwkL152K3WCQCZ42apDFBFqdO08=;
        b=ifgSgt+X82Xgcg/DnBIgU1rpSiFo18BrFrjjsfqCxg3z0tOdihOY049szw2x0M2i+x
         4hq2pFfE4RumFxeRK/FsaZpjlsBkvRufWzDevfrqmZkD6og5Kgp7DPZGBMZSQ7ytCATe
         /lkNs1IDLnWEJMgt6ruecdki2Q1yFeYZCCMMvdwhW6lTSwkPOMInBQUNKw8vuELF8FV4
         zqdrMfGFthIrpsPhi8BLT/Q5NGPwFxsFoAZ6AkFw0/sc+/vBl2xE/Ls28ATM+x0EftDb
         DdsK68hsaA2plUliLtpm/RGq1ngtOqTz9tlVmOfeLvHSEXwfhmWmVFF54+PJc3WYkzLF
         nsuw==
X-Gm-Message-State: AOJu0YzYty2vVmPwupCiOfMYu+V58hr1KFBBazlQPzk8bw3aSASz3/Ac
	4M4Kr3uoiM6Y+zlMMFltG4RX8ApE0v3tRBrv2HdOVkWIeyQnfECcmmUU9hd7pmg=
X-Google-Smtp-Source: AGHT+IGNdD5G84DmSHU/b36Z20lt00aR690Cm3mQbuLYcXgKdKpmFuaW3ORDH2JbMAIq69V34uvLeQ==
X-Received: by 2002:a05:600c:602a:b0:40f:f4e0:cd0a with SMTP id az42-20020a05600c602a00b0040ff4e0cd0amr326408wmb.19.1707227564431;
        Tue, 06 Feb 2024 05:52:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWQxZwbkTyLgHYU23aodGlKv7bLPTq1NO1vObvdfPuEHfUTAUpEMVi+UuwCNQxx4V9H3hrezSlmLgUHtKFey0zDv8Nixdf0mIXCco3AL4X5AqCCZqCgYDTsaVdv6ssI+c4+qymIiMS63tPDrXZ/eqHNZM9uUswQUHWfste5rQQye8lu/7GycegO90utb7PA+tgHIjr6rLynEJylJijF1FRry2qApW94vJIjcE8/8rbWHrxFkXKSyld0NeEcAHDYwbSxpZbSWiUGyMNKuJV+jKamgR+BxUw4ewK5t2+UQRHvrphlo9sMgp12V7spX2avvCoCi0IPbVh1mCzzC6YMvXB0MCnTysTnMAbd5icdw309j/buhSgbqxzTVyP3honPYzPxF7tdY6nbF513PExxYX1ZZ1jro5flHH0pfmkqGbfYu6SxV6hThZoaL5FJTpGDpziwxnZHXOsxiB9ZKXBAVs+sTOz7++Ia6bgsffo0wR8SnqVTwlCsbBnM2X1q65CjPu7S2yfFWe7/uSCFiBYGc1A54bsdBnHKeJhoaHPJgWeL9I7Mtw+c1o3UvqM3nU0bOOBqThmXoaSKL0nXPEcwbnhMtkHFV6gxL5Fk626izIUNPpuuOj4fq1eK6WGYoeXtSs65FR08OeN+2q7BqmqCZBUk+x7p2a8L3uEwZplJWLC4hYxE5E0DDd86wWQDdCtW371OAMdfiIMHtHfyMWa/qar22MJXEDyiadeGd4wmL28DQ0Pz04s0ZZPgMEdeK4MDK8ZPHiZ1/gDyde1zh0Mn
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id e5-20020adfe7c5000000b0033b44355a08sm2188528wrn.5.2024.02.06.05.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 05:52:43 -0800 (PST)
Message-ID: <ac4b73f6-0c2c-4586-98d6-e97c575b3df7@linaro.org>
Date: Tue, 6 Feb 2024 14:52:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] ASoc: dt-bindings: PCM6240: Add initial DT binding
Content-Language: en-US
To: Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
 andriy.shevchenko@linux.intel.com, linux-sound@vger.kernel.org,
 liam.r.girdwood@intel.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Cc: kevin-lu@ti.com, baojun.xu@ti.com, v-po@ti.com, navada@ti.com,
 perex@perex.cz, j-mcpherson@ti.com, pierre-louis.bossart@linux.intel.com,
 13916275206@139.com, mohit.chawla@ti.com, soyer@irl.hu, jkhuang3@ti.com,
 tiwai@suse.de, pdjuandi@ti.com, manisha.agrawal@ti.com, s-hari@ti.com,
 aviel@ti.com, hnagalla@ti.com, praneeth@ti.com
References: <20240203030504.1724-1-shenghao-ding@ti.com>
 <20240203030504.1724-4-shenghao-ding@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240203030504.1724-4-shenghao-ding@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/02/2024 04:05, Shenghao Ding wrote:
> +
> +      ti,tad5212: Low-power stereo audio DAC with 120-dB dynamic range.
> +    oneOf:
> +      - items:
> +          - enum:
> +              - ti,adc3120
> +              - ti,adc5120
> +              - ti,pcm3120
> +              - ti,pcm5120
> +              - ti,pcm6120
> +          - const: ti,adc6120
> +      - items:
> +          - enum:
> +              - ti,pcm6260
> +              - ti,pcm6140
> +              - ti,pcm3140
> +              - ti,pcm5140
> +          - const: ti,pcm6240
> +      - items:
> +          - const: ti,dix4192
> +          - const: ti,pcm6240

Why dix4192 is not part of previous enum?

> +      - items:
> +          - const: ti,adc6120
> +          - const: ti,pcmd512x
> +      - items:
> +          - const: ti,pcm1690
> +          - const: ti,pcm9211
> +      - items:
> +          - enum:
> +              - ti,pcmd3180
> +          - const: ti,pcmd3140
> +      - items:
> +          - enum:
> +              - ti,taa5412
> +          - const: ti,taa5212
> +      - items:
> +          - enum:
> +              - ti,tad5412
> +          - const: ti,tad5212
> +      - enum:
> +          - ti,pcm6240
> +          - ti,pcmd3140
> +          - ti,taa5212
> +          - ti,tad5212
> +          - ti,pcmd3180

This one is duplicated.

> +


Best regards,
Krzysztof


