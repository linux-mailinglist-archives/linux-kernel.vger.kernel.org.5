Return-Path: <linux-kernel+bounces-123225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 402948904BF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E828F2980ED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115478626D;
	Thu, 28 Mar 2024 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a5dwj2gd"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA1B8121F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642581; cv=none; b=ZmF+z7WUNNe+3YtLR4LEB7tamCyEqba5VCy9jRENqfjKibcKy0O+zkJYkYLExasaajOtBdsUBjGr+AyBayV3XZCc5+fRuWTsAtPcQzfVawbeoUXDbVRnAFQQqVA7eLpPVJL2mvf0a5nxQQ0hGByZRIF1lYcZAUXzO20IEoglBdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642581; c=relaxed/simple;
	bh=Q77ebNP8k5nDYzLkeIAD1Snfdt/pFWInqzdIcP5qPeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FUshtfawqQ+fb52riagcb68rGWFNsGflHzLFBeDj4Xf5iJuiI/W6+s8MDkoEWLTVMbkzG1nwLPg7z6WsTfw14QcWaHYOdbsGrVnXwDOSuCodVdqExZaQDltIfJdxvhAibVN8bZsMRQQsNEhxS4zMtkU7drTEirihMT2S8HDoiT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a5dwj2gd; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d476d7972aso17794351fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711642578; x=1712247378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=choVS2l7j9v8YZ4XB6cn6HH4AXOKlJetjKz9GMOi3i0=;
        b=a5dwj2gdVnVZTeB49FTupTDajoW/mbUaFuh6NCgmkurANp7YAVa87MsY7XzipU6tRa
         bMFfj3gdIq4kWKRIehaAuYxJvp4xyQwI5FmkeXU4YTnvGGVuOsEC63g4ZJCYtudmZt74
         N6RgGsmCGSUu2Np4+N5IKrCzLzoAF5G7Bxs3UpwvlahQl1a1ePJTGlmntO5oM2eDCrh4
         Y7MORb9TY75xG+DXcJb3HIV+qxa/D5+p5FFB5P4hG4+TY5xhmyDM87pF3M1Bgj+EGJkz
         Or0gOrHiwt3AYEa8LFJsJYa3YlF/EO6RFs+Z0egciAgZsb1aKQVz0uC+YDSICHgT9pOP
         A53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711642578; x=1712247378;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=choVS2l7j9v8YZ4XB6cn6HH4AXOKlJetjKz9GMOi3i0=;
        b=k2VK/S6fFLz37R5CHTQ0SVkrdCG4I39N9u+TFipSEdK873pyRHtXyzrTkcAp+zMLgq
         JVJgmxxdtNmgmJvCEAaU4eWbMWg5GIrKsP30CzssszPNF+7c7TFpbYgbxxYJJoITTnYb
         24xtJCMmG4ARROpOhwTirUC55EV+RKofFATgFh3e64zj2Y8ZmT0vvRAr7dlF1R7H9sdj
         zDyGIdfBc8myoScW617J5hVntympPAvviVBynlc3Pv6R/aSGJX+QVfYPLcBulKqgkFlU
         Rx4fQJwocpFEv9mgE8/cy0BTehIlJwPfGgdpoL4oVZ8kYtpDzg7SGWBZyxM1IC7ChPyW
         dFKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqXRjKbJ2XjmKc58CIZVEQOKOHGZsq9X8fUCZy1S5E1HJUwY4svHZxTCkYl8a66FnCddXZ75BGFBNzLU6U/+a+VzQlLuuAsajT5gnc
X-Gm-Message-State: AOJu0YxcQifqEhTXGidYtejrQOnsuWgav28rQTJe5A50I+fsNvGZrdBB
	EZIWNKcTnPSvAE1lFcYI61PuXS22YDcVfLMeRhBfDk0QUYzfPWT5Frh3KRHdMTs=
X-Google-Smtp-Source: AGHT+IHCfBE2md8mspyKXhaadpdAdtYooolQXavVjt8w2vbgfwVwHRxfZPv+lc+rTUN5hh/uqO8tPA==
X-Received: by 2002:a2e:7d12:0:b0:2d6:d4ca:fa8b with SMTP id y18-20020a2e7d12000000b002d6d4cafa8bmr3137950ljc.34.1711642577650;
        Thu, 28 Mar 2024 09:16:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.50])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b0041496b92502sm4551244wmq.31.2024.03.28.09.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 09:16:17 -0700 (PDT)
Message-ID: <ccd0a1e1-5a37-4dd3-9ec3-4e9e42050cff@linaro.org>
Date: Thu, 28 Mar 2024 17:16:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: arm: qcom: Add Samsung Galaxy Z Fold5
To: serdeliuk@yahoo.com, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240328-dt-bindings-arm-qcom-add-support-for-samsung-galaxy-zfold5-v1-1-cb612e3ade18@yahoo.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240328-dt-bindings-arm-qcom-add-support-for-samsung-galaxy-zfold5-v1-1-cb612e3ade18@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2024 15:31, Alexandru Marc Serdeliuc via B4 Relay wrote:
> From: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
> 
> This documents Samsung Galaxy Z Fold5 (samsung,q5q)
> which is a foldable phone by Samsung based on the sm8550 SoC.
> 
> Signed-off-by: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
> ---
> This documents Samsung Galaxy Z Fold5 (samsung,q5q)
> which is a foldable phone by Samsung based on the sm8550 SoC.

Please always send DTS and its binding together.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


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


