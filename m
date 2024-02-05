Return-Path: <linux-kernel+bounces-52606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7784F849A5B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC131F200F5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875AB1BC4D;
	Mon,  5 Feb 2024 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WpYNGGoZ"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F651CA83
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136441; cv=none; b=MUO4HR+TIro0RLk2zG2CLrp8/3No8kv8ZwgacbjJVWAwjx4uPmJOCdd/NFF33fl5/HGAjjQUdhy0ZOw4aH8W1i6H6S+YZ1X4+Yx2y6GPQOJegtN8bKn/5pZF5HdREg0dJD8Lc7dj87nXjSIFUiWaYegh5xznsTIiexP4UgaPiI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136441; c=relaxed/simple;
	bh=44kO8M4zLg4wZSNSC+39rP+fq/p1zN60FkLRaEwVfX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0F0rCy2+JkmirAg0+XaJXJWKs6sMBS54Omnh52AwvHCMElZ+eAVxPb5ik4gJLTJKVpdwyDPueWjxhcTNWlanaaNruabDE75n3/TKReTe51v7e1TznqF7S0DNPYI33N5ujxU0rH53lFWrDDJ46FjAa0MEuIbEwUjkPz8tY0gR2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WpYNGGoZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33b0f36b808so2777309f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707136437; x=1707741237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gKDT+88I8b8mG6PFcX3apjoE5KUiStaF8F1sYdXkGCQ=;
        b=WpYNGGoZDym9cMsfWHa607MW6BrmUHjcNlR1eh4vFNXwHOTRdDp8rOq/TxpxZTsobt
         0YHkDdpuHJs5oAznlmRE5kZp3lcs/dVvmPQOjBwTIyvarz/GxPUH78ab5PlKo3cd/2/p
         H8z7etzRCMiMYZhXFKRE9mSxs9oFKlMb/NtR8sZzj8k3xRTPp8M25fiGuQzq1/GmCZ05
         T1A2hzhx4XioXwPfzhCgIDt+iG66h6Dp3FrHYcHRfGkVaRJqn1k1Z8ICdXZF0/U3O961
         UfMn2BpAW3WnIhCua/udAion6jzI3BG7LOTdsCvNOEC2mew6GOeeXDdMqiEYTmQ9u4Cq
         8FGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707136437; x=1707741237;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKDT+88I8b8mG6PFcX3apjoE5KUiStaF8F1sYdXkGCQ=;
        b=pHviITZSe5kiuI7fi3gpcft6scjQ5Gey+aR67TyebiiJ55nX1QXy23v5rw/VghnuzF
         lkrLZzlekbzUoV08oBaifYlQ5YIcAgG2xzxV+ZquVQQr3y7ZolRGMalqTDF8BOesB3nO
         c0rWdGvfRpNbRbSFq0Q4ghzHWE6tOIPDBCRoFRMzb7kquoXbYOqoL0s+IrObWOlgWvkp
         aQrfGczWIrHIiywNx2pZsoG5AOXxokeJFEPME3jCNH3SIUtLvZcQfDqA0eXbe+cD31rK
         keQF+z/EL8rGH7egLmiDMpmff1blwW9w65JU/FrSb4E5DL2Ph43MkLN2aEzPbN//gAgl
         mmjQ==
X-Gm-Message-State: AOJu0YyqCSpQoNl7fXDQ9jJMoBrXpnerXAdRq3chZ3F73U5nB3I8cEni
	8BVhtkDN6V7dOBxt79g5TqtfzRmCNlPYRRyLfUUeL/E0dt+8/ROhP8qevrFni3c=
X-Google-Smtp-Source: AGHT+IHAvP4CDUdGR6wP3RQ4KvGOAfp93jXDnYSSzxYg0vzro+c5rEBqQlXblPtL84HP2XPULhi1ZQ==
X-Received: by 2002:a05:6000:184b:b0:33b:2fa0:7053 with SMTP id c11-20020a056000184b00b0033b2fa07053mr5082087wri.7.1707136437118;
        Mon, 05 Feb 2024 04:33:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXembS1rlgu235pqNSARhjl550Mrlov4kylPTJtO2W1Y0KyULy26iXiNDEXqJpWKepA+DuPlozFrP/pR8rL8ps2G5FONOdTmF0FXS131dTI7D1L08xG13jTv4kxRYOad2T63BYKeE7pYo2AaE1wkOxeofCUs8Fi7E0ainhSNHM/eeNLIdOqBc6ghBDh4Li7+ghx3xSbfV5aZUBdHGyR1rBvbcP3xD+WiX09lZGmjjGAqVDhcnTd3cIa7xN3yshjDWQqf0RbUrqlsRbx0COJ/r5ZdPASWzFhcsmwdhCIP1flZ7cg0sRao7H/xYy2eNemJxL3x8j3yBdTHksL10iruhwS
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id e35-20020a5d5963000000b0033b3cdb9336sm2256202wri.57.2024.02.05.04.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 04:33:56 -0800 (PST)
Message-ID: <2fa4d857-7262-40df-a842-56945ecffb81@linaro.org>
Date: Mon, 5 Feb 2024 13:33:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] dt-bindings: arm: qcom: Document sm8650p soc and
 AIM500 AIoT board
To: Jingyi Wang <quic_jingyw@quicinc.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: kernel@quicinc.com
References: <20240205115721.1195336-1-quic_jingyw@quicinc.com>
 <20240205115721.1195336-2-quic_jingyw@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240205115721.1195336-2-quic_jingyw@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/02/2024 12:57, Jingyi Wang wrote:
> Document Qualcomm SM8650P SoC and AIM500 AIoT board.

Please describe shortly what is SM8650P and what are the differences
with SM8650.

> 
> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 1999a5f2f254..e87ceb42853b 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -88,11 +88,13 @@ description: |
>          sm8450
>          sm8550
>          sm8650
> +        sm8650p
>          x1e80100
>  
>    The 'board' element must be one of the following strings:
>  
>          adp
> +        aim500-aiot

Drop this line.

>          cdp
>          dragonboard
>          idp
> @@ -1051,6 +1053,13 @@ properties:
>                - qcom,sm8650-qrd
>            - const: qcom,sm8650
>  
> +      - items:
> +          - enum:
> +              - qcom,sm8650p-aim500-aiot
> +          - const: qcom,sm8650p-aim500
> +          - const: qcom,sm8650p
> +          - const: qcom,sm8650



Best regards,
Krzysztof


