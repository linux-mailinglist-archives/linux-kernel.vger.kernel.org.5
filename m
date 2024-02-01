Return-Path: <linux-kernel+bounces-47803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B1B845315
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E3C1F22F89
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834F915AABF;
	Thu,  1 Feb 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dTG6EfIP"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E521586FE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777315; cv=none; b=nTnr+es0o2Pa40+ZHxHkBLZEfyI8LFwMoQaav7V2Gy9Xh/k7r4oEwnCoIPKYOqKcQ4YjXMzT999+DXFm2YXjjES8yFX67n1r/B1eMtOkOdc8p8DcOHYN/1NnFINlK2Nut5MB2kNjTF4EqfTlqLQim0EA+cJ/4JG+s0s03Z9cPyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777315; c=relaxed/simple;
	bh=1iEKPsGyIG6rQ5kO82myx8FHChYspBMwgijCMNAXs1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YG7EHDB657/U7CNASO4C1eBMETCBFWvslDpTrdNj5uI0rGRxcVnZ+I5RLW8CkzuKdkU38fhDAvWvBvhUKQ5O76TZVfZEAxXK1YMhnqC0KgdtSrPxYogSOIYBmqWz1kWm9mBcpxdPwJikcEYNn4AB2o6mDQeOgbRYvLfuY3/Eb6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dTG6EfIP; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55f0367b15fso834697a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706777311; x=1707382111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gp6qR+mJ3ILea4APx15Grn5E+3GAezxXQrzzzHzlz4k=;
        b=dTG6EfIP0nlN2Oq4RVYpjeFhJ+dGCiaqoWXxuXAawf+VZTzXNLf3cXngx4BHZym1y9
         eL+us1Jo+mgnF3ziHJBnwlCpCMH1WZ/Sq4h+00ZTtfsg7KVknq6uVVNnGpy1zMyZoyZW
         Uz7RV0z/tC/7eB+1O4zS9Gms2FJRY4m/iXjVg2liIDXZgf6zhXvQDFkeGhjujUlVFO/P
         pWBhI7tht99NWW1XymI0nfRRQGX26Nwr5+7iG7+Qg0JX8/BgckBIiiqkqZOpq42t+os3
         +UqFFZoGvxBwD87ucYVHSQ+n2h1kJoqjm+5yfFiNDpisFlc/dDL3H3vPUJULLYBlE9Pn
         Y5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706777311; x=1707382111;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gp6qR+mJ3ILea4APx15Grn5E+3GAezxXQrzzzHzlz4k=;
        b=B3UXrz2p/hyZEdjAXgvsggXYRfnXMxNF8ZiWgAgvUGlpwVI+jJH7v/OALJEGH3+2wB
         uK16VzE4RArcv9Yfgg5yUNRWit54AKvANx2n0SwetLyVJ70m6GCgdanEQCd0aXjTisYQ
         IsvKVIQQMHYSDy6Z/uKwfMMRnAzv2HSHMINVZnIx2xLOBqNQGl4BHiOavvb4MoOXuRIq
         mbe7F36pvu2OrprDW2dWGnd6huqgsQqrkfFrxQqCmvpOv1DPPMvIaA22xd0/saajliyV
         72N4r+SvVHCuucZNPQASal+uFtlGwKJZyLj0fH1KJfoda02blzxo7eiucXIOhNTJcf53
         hMQQ==
X-Gm-Message-State: AOJu0YwmUPWYLcYb7R2hpdYSJCl2in7U7eyJcIfImYy6ZKWf99JNRu0h
	HsXgFC1ji388ZhbJHdd9pLEjEBk05CzTW+OFe74aN0FxDrpvCeYnmczGFLNi0SM=
X-Google-Smtp-Source: AGHT+IHNflyMZgFHE1eWdRn2flrTo8q92isTV186jYlRXPhzPkJovwp7P0yV/ZLzgGKE/bzdtRvJhA==
X-Received: by 2002:a05:6402:34cc:b0:55f:a7d6:fd61 with SMTP id w12-20020a05640234cc00b0055fa7d6fd61mr1708958edc.26.1706777310853;
        Thu, 01 Feb 2024 00:48:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXY2fjeIi5nELjeOpSNWib3qrOQWzCh+aWP1PGpibPWLMq/BZ7yKHAkTScB71ohT3zAQmNdSpO0zscG4bxQE2BPkRYPMtZBvkTCu7YbiO6jWtWg3J7fvfv56fdooF1fi938vV6gdLZUBpl8bWbVMLWzSbyX+ajW1nu2raD74QvzShwztNwjQVvaPsceV6WntHGDMYkhj5aSMoSrCPMJuuAV35g9tTa3iaIKxpXlrTviX9P3R7PqwPlmfpPJANcVrDFKb6UkDFIixZVNopu8WWi7SXHznIjQOGKwQY+lOefvM56Bu/lJ2rDRdk7rTib0OGTsvDls4JUStoCjfiU2RDk8fFwuwP7sN+01Uvi4enquVJSQj3FZytkN5HE381jyeWpAKtliD1LWnCe7PtXElJtfSiBfVW0Tt+WAXIyJ/TG/RNykEfMzb3PMrq5PMHYEDOo=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id fe1-20020a056402390100b005598e3d6d23sm6551798edb.16.2024.02.01.00.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 00:48:30 -0800 (PST)
Message-ID: <e77ac513-3f8c-4979-b887-f6b9aff6963f@linaro.org>
Date: Thu, 1 Feb 2024 09:48:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] dt-bindings: vendor-prefixes: add LG Electronics,
 Inc. prefix
Content-Language: en-US
To: Svyatoslav <clamor95@gmail.com>, Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Kees Cook <keescook@chromium.org>, Maxim Schwalm <maxim.schwalm@gmail.com>,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240131105153.8070-1-clamor95@gmail.com>
 <20240131105153.8070-2-clamor95@gmail.com>
 <20240131-elderly-passover-341b89f65189@spud>
 <656FDD69-D7B1-4910-B848-108CB985AAAC@gmail.com>
 <20240131-tractor-roundish-f6f90b5bd640@spud>
 <BCBF1994-C5AE-4D2B-B645-C3C67BE19000@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <BCBF1994-C5AE-4D2B-B645-C3C67BE19000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/01/2024 17:06, Svyatoslav wrote:
> 
> 
> 31 січня 2024 р. 18:02:31 GMT+02:00, Conor Dooley <conor@kernel.org> написав(-ла):
>> On Wed, Jan 31, 2024 at 05:30:58PM +0200, Svyatoslav wrote:
>>>
>>>
>>> 31 січня 2024 р. 17:28:49 GMT+02:00, Conor Dooley <conor@kernel.org> написав(-ла):
>>>> On Wed, Jan 31, 2024 at 12:51:50PM +0200, Svyatoslav Ryhel wrote:
>>>>> Add missing LG Electronics, Inc. prefix used by some older devices.
>>>>
>>>> Is it? You're only adding these devices now as far as I can see.
>>>>
>>>
>>> Hammerhead (LG Nexus 5)
>>
>> I have absolutely no idea what this means. Please link me the in-tree
>> devicetree of the user (or the patchset adding it).
>>
>> Thanks,
>> Conor
>>
> 
> Sure, here you go
> <https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts?h=linux-6.4.y#n11>
> 
> So devices I have sent are not the first.

Please look for existing work doing the same...

Best regards,
Krzysztof


