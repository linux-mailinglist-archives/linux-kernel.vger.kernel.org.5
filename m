Return-Path: <linux-kernel+bounces-62377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6E0851F65
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879A12830AB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4924D9FE;
	Mon, 12 Feb 2024 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g4KunbDA"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7864D9F2
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772630; cv=none; b=GQ+PD9p7mVdggfEa5LXFH3siTmcDur1KPGamQwIVHUdMIMUOOpQR3eekm6Bg0cFmf4LL1QCXxC6EYdDxXloHuiRl3yPnNJS0m2ie2GNf7iU/eTsAOe+G1+4i0eAMpoYmzM2J97LI7Sv63y1S+w4ZYN7pMdGCZqmRztdc+q4+S5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772630; c=relaxed/simple;
	bh=LFD5bd8Zgd6jlB72u8vTWuv3u7q3mlMRWevb6XBLOic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/nU6AFopn2abGsf94UcqnneTKD34npZvZpLs/vXc4u3qaH9ZQRE80YJyM0//DCCj7eIbpoezz2RppRCEofEt2BMDFqwBGOwnK0LaJAOyDV+mpoS5WUs3fFighsts5rRuKMggwiCGet7v5zBOkhZigpnq48uCN17hRJVNMpapmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g4KunbDA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-410cb9315f6so11362845e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707772626; x=1708377426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KsqaGJJXv87k2gEKV5H8f/NbklpthhQMoTfAdvaDd+Y=;
        b=g4KunbDAl7Q/kRHUGWmHdl4FWkMnFywWcEFG1uwkZM/XZNgeACgvIiiPt93CXmdhPZ
         RL0vyM8KG0H1fcn7mgxPRY9p7LmzboXfTeVxZFrQU7ad0Y2JiV7X9Jl5NJj24iyw0dJ7
         AVMaNnw/pWMPLWbvhNVRmaajV5GEGvwvcu14p9VCpxxPXjW8JBNeEKcLf3/6hQR8furE
         VfDMrmjgDwFT1A49km1+C2C/u+7B3ptzkO1IqloBs9E1zf45rdnuAW86iHluQRvtV+a2
         VyNSPWVO6UojfbUTOtZvzXlWxHFbeCRZvxzJgkDrcKnWWhXThHVyzVetUSFgsR32Q3AR
         OfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707772626; x=1708377426;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KsqaGJJXv87k2gEKV5H8f/NbklpthhQMoTfAdvaDd+Y=;
        b=epMs8KNho+84f4Hm+KxKyG3hu4nbqBZ9rsGfZuWDGNddDMS/alaYxN0eSJr6v80FR7
         IDT9a2S68CYGoCh7vcVnsA9yNw+6dMMB1LKkQam9ni4PsBvCr5qVaS7bAbhi7Sfwb+l0
         5CUkAjV+mihQxsZiurDzvdO3AcrtKC0757QbB4XRxyi8y2m14jO/uc5/l8I8zHa7L58a
         PCmET+YT0LslRIb+Kw3u5MqqfNo0AAGzHoC3uA6TPuv6MoJu1kESystmlnzYLcSIybYE
         p3vPKgrbyIpY4SS2vWw1vXRRkMxxljQ4p69jIExx3POUsceAr75jJmDwzjKnkmcoxWyi
         pb4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOeQgA6Ev5k5BZhx0v2Cg6W1Y6LAFKXjqY4yPFhEqZMkYXt4z5rM5nr1n7GUdaDMzcnfwH1IR3zOC9iYV/7Q21m1IjWrLHT1g79fZZ
X-Gm-Message-State: AOJu0YyI3oweB+nOvCNMX0DR4jyVyUL2/4g/I7YFAr98ANu8ksAbdkJt
	/lIaE4IFPpGdoavSBgT+CTLfh3eE+yvpBsMFua3QCLzdtt0QqSqbNxwZK6wR9GmI2usdhW1x2Pi
	t
X-Google-Smtp-Source: AGHT+IH1Xa4imjxK//QwQb3VXEf+ENyC0XfSdd5fFIHuPXdyfhuahps3H/GvmJUNdg2U5Yvonw+qSw==
X-Received: by 2002:adf:a29b:0:b0:33c:d4d6:659b with SMTP id s27-20020adfa29b000000b0033cd4d6659bmr68866wra.7.1707772626699;
        Mon, 12 Feb 2024 13:17:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXV0fXk0XQDRn/7clyZX6wyXWxcjWn9T+ELytUunfA1ow6tD+i+BMFq6A3zgTk+h5m5Tkcws28vEfl5X0W0J79QlHAUDheOrhOL8VN5vyqvN0CCOcQePu5D3jL9G6r92snpWeHCJk0ufTJEVMxi0H2g1Q6csHgxgjVqj5/CKZeQEvAoJ7TL9UAdr2+fuzMYUxEsb0DPUle6XeAj+zRTPEN1vDiy9Dz4CB8P+dk+4TGaRSLL9SavGXfRvOJjxfKaX9H2+0x7mZash3C7sVi8vuxZ5SQHb3u9Yzkh5FUIWqj3hyo=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id z7-20020adfe547000000b0033b55186901sm7738185wrm.94.2024.02.12.13.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 13:17:06 -0800 (PST)
Message-ID: <d5212c95-cc24-4235-b065-1b2c7206f46a@linaro.org>
Date: Mon, 12 Feb 2024 22:17:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add IDs for SM8475 family
Content-Language: en-US
To: Danila Tikhonov <danila@jiaxyga.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240212201428.87151-1-danila@jiaxyga.com>
 <20240212201428.87151-2-danila@jiaxyga.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240212201428.87151-2-danila@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 21:14, Danila Tikhonov wrote:
> Add Qualcomm SM8475/SM8475P/SM8475_2 (cape) SoC IDs.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  include/dt-bindings/arm/qcom,ids.h | 3 +++

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


