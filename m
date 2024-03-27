Return-Path: <linux-kernel+bounces-122008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F395988F09D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2988A1C2B03B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734FE153563;
	Wed, 27 Mar 2024 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R0zYsOC3"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB52A13A3F7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711573577; cv=none; b=BUrufUQGgyqMBgtqIsNevQOLhlY8rLds9iY6n9cYg+bilnnptZ7f2s5CKswR9b0HRgqMhlaCnoTSVm2ejFNrnXQdkAG501IGabIBYw7YqNL+l+7p27QzS3EJYigKT1BzhJLGtxkzsIuSxh8ttJeYxHYDXiWdx8xeHHU62vKu5wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711573577; c=relaxed/simple;
	bh=txwLarapxjPZmto0nAB8MNIy+S7CGgxhK6ZcCA+LSkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cA9KsTIFCGlYPg1pmb9boXnioLAEYRo0GutvaUQi6pPxyMScdN4bB61cbKCBCettABoKZa5Q06wA4iK0JdhHxetNxFwlZeiwWwuUrQ9Lpx2GD6Gw0Agj6dSvxzM5HIqmFFwYpl67L2mdBjz0pEX2oCMAAhC5LRYti3IaUFWNm4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R0zYsOC3; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso381691a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711573574; x=1712178374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LJMvh1U1g5i2ZCyHMLTGdnwDxmPIIFiD/UlBteVN5OA=;
        b=R0zYsOC3oPIT1N1a/iiVrroH2uHTv393R8gBsjCWvenGrFqM5Ow8ib16PYwjvWULBx
         oq93Qg81MCqR5A6EpufJOv6vx5Kmd+oItZbB2H1EledKlQ3vNTUSL5M1sIXfDe/Q4989
         qHPUwBQODUjswCkWQu8Yi6f9fmm9VVFWgU2dVb606PjwhfFtCmqbKxXnnOu7StxVhwVH
         8XpHWzhUm1qxEvac2wcYfslLyB+sudW2bj5vzo+CnLujbWOCM71kEnJZYDcdw+7bm3yB
         sLdneccYu/Fsy3313OPcjFdcLJU9BqNKiPSbpuKNelWoNFj/RbWOXIG28/AdB5ld1qwe
         QVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711573574; x=1712178374;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJMvh1U1g5i2ZCyHMLTGdnwDxmPIIFiD/UlBteVN5OA=;
        b=MqQeyHKOZBRU6Dp6EZb3zonM+AgQxUUZri4VQxbaNj2cDvbMuf1xrvanTx8LP9/R4D
         QZSZBYz+ab+pWWwtcbyDN5HThRQOlY19lM7/78RQFvNUATHH1bm12jcE0XOhSWlh5Zdn
         SqwnaeykUJT5zFvH3+DUfNMO9kr/VpT7jQuyXlmBKsfyeSfBYXEWbna5MCBx60gpO359
         uH85AOGkZmu8NFzO66SgMzMDfhvHrua6/l+IbCnM8cw1rgds+7S+dGwd+oWJwzZBw21P
         UCIa6O6oaYjNlLqRBXrtyNMHxrCu1Z+imWZ2N0PUtXyMqTKFxGjR151YuazAD8vDzPXF
         iW8w==
X-Forwarded-Encrypted: i=1; AJvYcCUy8/h912teCTAIFwbiVToT4r8CgByMbnXxrvtM8L0sHvVTQ9xfCqG3N3pZZAeoeRH7ZwujRjMCVqxenlMNhU2OfmQz2ltz9/x2QttJ
X-Gm-Message-State: AOJu0YwFazpPBMX468PsxvqybIse9mBXcNt+YIjwQht9SXgVAzoKBzqc
	+jssVY/F0YIYFKSKt42D6lv9Na1z4vrnQbYmBcTXl+CvRfgSiOWYSS3ocozotJ0=
X-Google-Smtp-Source: AGHT+IEOd7ZGQ1iXrOms8ViLIB02MVphw46zQAODE3pyuuxQfB8dxFqGpQCqAi//HAKtNolmAri5XA==
X-Received: by 2002:a50:8adc:0:b0:56b:a91c:ebcd with SMTP id k28-20020a508adc000000b0056ba91cebcdmr690345edk.7.1711573574255;
        Wed, 27 Mar 2024 14:06:14 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id ek25-20020a056402371900b0056bdc4a5cd6sm10509edb.62.2024.03.27.14.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 14:06:13 -0700 (PDT)
Message-ID: <f4ebe819-9718-42c3-9874-037151587d0c@linaro.org>
Date: Wed, 27 Mar 2024 22:06:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Douglas Anderson <dianders@chromium.org>, Rob Clark <robdclark@gmail.com>
References: <20240327200917.2576034-1-volodymyr_babchuk@epam.com>
 <e0586d43-284c-4bef-a8be-4ffbc12bf787@linaro.org> <87a5mjz8s3.fsf@epam.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <87a5mjz8s3.fsf@epam.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.03.2024 10:04 PM, Volodymyr Babchuk wrote:
> 
> Hi Konrad,
> 
> Konrad Dybcio <konrad.dybcio@linaro.org> writes:
> 
>> On 27.03.2024 9:09 PM, Volodymyr Babchuk wrote:
>>> It appears that hardware does not like cacheable accesses to this
>>> region. Trying to access this shared memory region as Normal Memory
>>> leads to secure interrupt which causes an endless loop somewhere in
>>> Trust Zone.
>>>
>>> The only reason it is working right now is because Qualcomm Hypervisor
>>> maps the same region as Non-Cacheable memory in Stage 2 translation
>>> tables. The issue manifests if we want to use another hypervisor (like
>>> Xen or KVM), which does not know anything about those specific
>>> mappings. This patch fixes the issue by mapping the shared memory as
>>> Write-Through. This removes dependency on correct mappings in Stage 2
>>> tables.
>>>
>>> I tested this on SA8155P with Xen.
>>>
>>> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>>> ---
>>
>> Interesting..
>>
>> +Doug, Rob have you ever seen this on Chrome? (FYI, Volodymyr, chromebooks
>> ship with no qcom hypervisor)
> 
> Well, maybe I was wrong when called this thing "hypervisor". All I know
> that it sits in hyp.mbn partition and all what it does is setup EL2
> before switching to EL1 and running UEFI.
> 
> In my experiments I replaced contents of hyp.mbn with U-Boot, which gave
> me access to EL2 and I was able to boot Xen and then Linux as Dom0.

Yeah we're talking about the same thing. I was just curious whether
the Chrome folks have heard of it, or whether they have any changes/
workarounds for it.

Konrad

