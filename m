Return-Path: <linux-kernel+bounces-45936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0D784380F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 966DBB25265
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ECD54FAF;
	Wed, 31 Jan 2024 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wyTq+ijN"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCC553813
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686835; cv=none; b=rLOPVC3cJKg/k8IWmkTCeEDv+qFGMA4wQJBvYMCIIeYuqpyFn8elndnA9O6GsXMYhADS46/ZxYxI6Bogqrh25SLgnKeXeDDvAvTLKinVW6tuaJVppqEcbkrBFfjRW774YsbHby992eSgTb7yJHFvJvQWfn8NWbbIneKQs3fTx1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686835; c=relaxed/simple;
	bh=Fk7et5LoRmj12wM/kDqH3aAquXg/E037WnSi/+YVB0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WoltbO4QPLhuW/bKb2qIbqLa7RuRlW4o4po/Y3otJ8IxUAF7MxyE0c6XXh/iPQ9+B01QC0jjEkiHCvHJu8ZB4dKOQY1zzHy7Hwrp71Qjspyvq15M8mOElVcE35ZoItEsIySwYnqlK5vZbJ/mgeoHiUuCKvHPwZ/mVJSNYYjgSAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wyTq+ijN; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a350bfcc621so540146666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706686830; x=1707291630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ISicW6vjdRK0zHC7sP+yqk9wJ8Zg4XC8YnF5r9FPgH0=;
        b=wyTq+ijNgLF7lLzooRX4GEejwMcSs90vLWoDGsFVN3ecVn7xH9iw/tDvtzYp4d19FP
         NLJApGQwJaKXRepYJFyZPwl22EOc5JcxcbGZYKTO6s4OCbHSQ5tSySQnnMXsJWe+Zduu
         nmWrpUX6Sp5yvywCU0JkV+tQm6/9T6yiRgrMPfNNjG1nm00UtjPhz2bQrpOA19V6lrgn
         xhsWWw2SJkcUkp1tpMSGnj5IMkcisRH2Kmewe/LdqRgJ8jDCdnlmLCD+z6Q8juOwdeac
         eNyoN67t6T/li44fqSUzhDitbMlHSpOv+WaVRYFUqK7Tkf6F6wPgBVbe421402u1dh9X
         cMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706686830; x=1707291630;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISicW6vjdRK0zHC7sP+yqk9wJ8Zg4XC8YnF5r9FPgH0=;
        b=Yxpq4ijYeI9mgsJI1t81uUqAIUuR4z3IVrStjrDWsPf5x/00DczdrxdbBiGuNecrwf
         U8vMsoW7XTSNb4T99PsZFv9+BdnmBahbFymycDGfFQnyBtz+6s0E+IILl9/jL8Yfo73C
         zjdPvLY0BRIuuHy+v0SsXGngB31vr9h68cVeX8Lg/c/o+lbUX9MmtjajkBy4TDfZPd2j
         eULATt8/fFo4iZ9F8nZ95FmpxbADvvJUDnY9NjIH2kBmDkjJO6lgH4uITuIU2kqxGHUU
         wujj2ml1ssp6ODiDQR7o/sTl6b9GJ7KW1cNll8QXp8haBzTIWVhDV8dka54pj/+YUmkK
         fFAA==
X-Gm-Message-State: AOJu0YwascJ2YweXS9gKYB5naWElV+ZhAV9gn264+M5Z2/kQTj+nltpy
	gUnDyBnRCBEgHuYo21MjCxUCN297c8zEn6JRlp5zqFhKLNEhDVD3HTWpo/r/I/w=
X-Google-Smtp-Source: AGHT+IE/tD7Sd9+HJ9DRE/lUIFcjX46VypL9fLqj23NXhB7eQGC+73r+DgqroNfxJMRna2/kR+/oaw==
X-Received: by 2002:a17:906:806:b0:a36:459:51fd with SMTP id e6-20020a170906080600b00a36045951fdmr520953ejd.69.1706686830640;
        Tue, 30 Jan 2024 23:40:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV427xW5gojV3N9cr0ycw5PgK9jft+f+uXyr/VwSPVcpiAPwJnOEjMtSDs6US9d22tqBRA/2vQZ8mDnVPFihAhREynUnfw/winZlNqxv2b2n2jQe043RLrM4MkfcPtQt/U/rAX2terlaqKZbueSJZQA5S8IpS4KI+OAkixBqeyYQCnW81QbfAYcNx8yVaRDTiIjQtCf5wEgeLFiu2fCl6ONqYVJIaJHWtQ8s4r5B8enQ5kZQ2CXCIfglKxgoo4RrWlP0sywyJqZZ2qfis00v7rVvJ5hSDprn++PU3ZQHLvOVFtCGjyDCTZTcDjuqsuVTJ6GLZE7lWDNANnQhNqGZfbKTvotbbNBwokOlK1DYqEyijdsE7cDjDfcRH8mQd03gNXl2W3k6il6ThqZ8qAdZpob+CkKpoFHmn/eGelnaZW3QxkerHnjebIOv7joo/tNMqFV6yWF+Ywtsdnh5utI3g8sTGLhET2/PlJLyauzMV5MkW13exN7t0jhRIqalbZRYaasPjYL6rNqYO235hiCoClR/AzgQyOIfipEtBoza+P5Vwj/owFSG/N/YBO4l8RlMds+pQSF2j5PP0oRbWooXfab3w0/FB+PoqQ0ahKt77Eeti+Y2PvEeL2q05iKdHpbEZJu0FFRtECapc2KKcWA6SwdlthRldiOkGM9ZZAFiOoMlZUOaCufivoxhZZoHOOsDXdQIrdCPzhqrA==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id sf5-20020a1709078a8500b00a353bfdd411sm4774695ejc.59.2024.01.30.23.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 23:40:29 -0800 (PST)
Message-ID: <12141842-cae1-46ff-b2ec-23b947aecd00@linaro.org>
Date: Wed, 31 Jan 2024 08:40:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: coresight: Remove pattern match
 of ETE node name
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>,
 Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 Leo Yan <leo.yan@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Tao Zhang <quic_taozha@quicinc.com>
References: <20240119092500.7154-1-quic_jinlmao@quicinc.com>
 <20240119092500.7154-2-quic_jinlmao@quicinc.com>
 <px3fj5e4mk3siruehhmazxnxbrleetdpb2slt64agtvbcqhts2@gmrtdonybmzd>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <px3fj5e4mk3siruehhmazxnxbrleetdpb2slt64agtvbcqhts2@gmrtdonybmzd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 23:17, Bjorn Andersson wrote:
> On Fri, Jan 19, 2024 at 01:24:57AM -0800, Mao Jinlong wrote:
>> Remove pattern match of ETE node name. Use ete as the name for ete nodes.
>>
> 
> Not saying that you're wrong, but...why?
> 

I don't expect any meaningful commit msgs anymore, so:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


---

This is an automated instruction, just in case, because many review tags
are being ignored. If you know the process, you can skip it (please do
not feel offended by me posting it here - no bad intentions intended).
If you do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for tags received on the
version they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

Best regards,
Krzysztof


