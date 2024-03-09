Return-Path: <linux-kernel+bounces-97863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E3E87709F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 12:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EAF51F21721
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E9637147;
	Sat,  9 Mar 2024 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EpVHwY7a"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92DA3418B
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709982377; cv=none; b=gnknf3uz41Sx8TvWPAE1HOn+/yXAaNanpl4uIue0rXYHETOpCUa++XUEsU7h93mf6OcxSGEz1ldDahRAD77yME8XFIw2+MrSyXG1kwRRZKk53ZgPkAuGMHhGEB5H1YCF11wnJlB4lx8pN2mTXGUq0ywtFkvgR4/u32bwdnlpv9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709982377; c=relaxed/simple;
	bh=XyQ4MJ8oBSycVKH72NnSd/TtYVHeQJRmjDbrBDArywE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5HpdSJOe/ah0ShKij61NTKKnUFkC9sk0kiPq+uuOp99RB01/HpN96o0yrlqvfWBYQImXyJ8gnx5pQZBgBE1Pe/VBnBIpEaNQubaruZ6HlxD358UVSbSe8qDdLbX4+cIzTWCsw3kLE7ZRBfGQqlK3ZmjK6qjFQ1z7Tu8qmDpIkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EpVHwY7a; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5101cd91017so4828540e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 03:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709982374; x=1710587174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uNeuJeVXCsaeZeDtgJ53sNR/mPPeEL48ueHCXU4YYNM=;
        b=EpVHwY7aRny45LQlnrIwT2eplQJhN5/mcXUFgRJBoIFvhopu9Odl4nfTEm5M9mqBJI
         uyZJE2XbcF+yXwJSQpE47hWrKXZfPZi7aklJUw/R6Uj6pPLKs9ZkI5ZXHH9uFM/etLBO
         4jc2sCj4sFtyUB3GJrU/JqQGQxLcpfwlMpJYb30eLCMifTEVPR3j2egVEi/GGEZeuS0k
         hj9R02JZPq2VmIc4sbQXtwefgpHek+tk25gut4FwIyt3j9F6KrKxKljDYE+GBw/oLFly
         5DkJ43jWrdRIuMajfNn/0IgKB2RTyknuhk0Mipkdlxp6KMiMJ+mvgEouvs2fUooykioA
         s6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709982374; x=1710587174;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNeuJeVXCsaeZeDtgJ53sNR/mPPeEL48ueHCXU4YYNM=;
        b=t37AC1WbYrQ2HpyVL4Te+GHSP/oQtMNbpxx2UaoGf8ti3GFVslk7cT3lNuztLi+FhR
         pWzeWld7AKHxIXLhARtJjFKlMnnm5Y7tHIKKNfKSHSVOH2Z00DbRdytqskV0f//sCK8T
         x3VrXwWUmt2mZWEDATWX4ouJ7JbN9BdPQA3jJTkw7SZQNtW5gI5kOT2rjNm0YnGT70dp
         biWYnYdpB08AzgprqxB+KG5G//qaCB0eSHLTR5adTZ/zkDX1U0EGs1/LX0wzfmLFR83w
         ySvZfRMa2ZC5oejUhUM354bARgR9+c6F49cQ/TcEpGwEf2dYGBpyJ45CFRdRMtoSUWsB
         Z59Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/8ziJrREMQkNI133XEB63RQgpGr87lhtb4G1WimufwLUlpm1Rz2pUUxznlWYKZOg6/EbdGMDCg8K5W60bjcQs85JzJ1/4QWSNb9of
X-Gm-Message-State: AOJu0YxQJxXYaPRPPgMtB9TBDAAlFjAM5jkJbFkOae7suHAuBYkh5Lf5
	j+EhVX1ln5OQIjLfzukgFIuodLbbX65AGzJbuIN650G7IzX3oV7SoCEZIMhi2r0=
X-Google-Smtp-Source: AGHT+IHZ5LngyoKGDqxk/EkFrq/BS3sX3bCV/VtyCTBbV2P7YrsZfLrw2j74Qq4XELl7qOIqFdtyfg==
X-Received: by 2002:a05:6512:34c5:b0:513:2858:6a67 with SMTP id w5-20020a05651234c500b0051328586a67mr761035lfr.63.1709982373960;
        Sat, 09 Mar 2024 03:06:13 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id j12-20020a170906474c00b00a45bd9ccb55sm758342ejs.155.2024.03.09.03.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 03:06:13 -0800 (PST)
Message-ID: <9747c836-adb8-4d21-92c0-a022847fdff6@linaro.org>
Date: Sat, 9 Mar 2024 12:06:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: thermal: lmh: Add QCM2290 compatible
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thara Gopinath
 <thara.gopinath@gmail.com>, Amit Kucheria <amitk@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240308-topic-rb1_lmh-v1-0-50c60ffe1130@linaro.org>
 <20240308-topic-rb1_lmh-v1-1-50c60ffe1130@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240308-topic-rb1_lmh-v1-1-50c60ffe1130@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/03/2024 23:08, Konrad Dybcio wrote:
> Document the QCM2290 LMH.
> 

MSM8998 appeared as well. Please either explain in the commit msg or
drop it from the binding (if it is not correct).

> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
> index 5ff72ce5c887..b815d8c5da51 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
> @@ -17,10 +17,15 @@ description:
>  
>  properties:
>    compatible:
> -    enum:
> -      - qcom,sc8180x-lmh
> -      - qcom,sdm845-lmh
> -      - qcom,sm8150-lmh
> +    oneOf:
> +      - enum:
> +          - qcom,msm8998-lmh

^^ Here

Best regards,
Krzysztof


