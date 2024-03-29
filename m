Return-Path: <linux-kernel+bounces-125055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3C4891F54
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FAA1F30B3F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872EA140E23;
	Fri, 29 Mar 2024 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fETlTLVo"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF6414037C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711718168; cv=none; b=qqXag8TixcqN4lk+MdKBl88ZysBkIprYd9G7uW0VfYLY/rlxRJOUc9UuSS93YroYqbSVZyBFXo6DREHPZ+QK5LdAJlHQoEymaoFSw+1MuN2UcZH1kAvfrjZXJT6GHYVGPQhFLA7EPK/dObpzUOd28gjNM8z35giZj7M6/pjBBbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711718168; c=relaxed/simple;
	bh=4sVu5vTeZO7IFrY+aF0kRr6PhBP5otxtNfRVRj1bVXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PO1AJXG3nYslo8t791bMlmuvpv41ABOXw+BUCeVmRc5dNqigN4iCRgltimzVLPvaijUKT6vNskBfc0hnYI+qU3HJ69YoPmd2rNEG+b2gdvvWXRaWTrA0VhOKK00n8ig0R0gokbo+qqIftMJQ1CrbW1/0RYdnYzOT2ExFS3ce4dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fETlTLVo; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56b8e4f38a2so2450080a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711718164; x=1712322964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zihHwg2NplHXrT7i55Wajk82Gx7auQcYcps0A+nDgXE=;
        b=fETlTLVoU5+qKlgUjaxAD/we53/MnHw3N0S+q7Cj2ncOCN20iwOhngzgwlyL0x6ZcB
         ZVp3P3WqsjYDqTkN6ekNAmDqp0WNtZRSAnUm5e8LJuQ3dstQlKfZnIkUZz0G6XrSjvre
         Yg/M9gV05lb8HXBWqRgNIKxUp8pLKdIkjhfzKfd6YtqZIcUbbjcP2w81o2GhWJrUuVw1
         At1xVCn2A6Al7fxOdZiwl1WE6iwEKwg9EPFTj6pDcNaGqxXEUuneF64Y9zFKkBgLGndC
         UQ7VQDfWrGM3tp3waVjcTEtPXMI8jJnOdEkJAPNDmUdLDLhdNYbh8kYGKvuNrbJWo+i1
         L24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711718164; x=1712322964;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zihHwg2NplHXrT7i55Wajk82Gx7auQcYcps0A+nDgXE=;
        b=aEhjredCfpnAKhAhoiPHMidWQPnI9SROA5DdLe4l2MSYAP8b2f+D1MzhlpIpFh27o2
         RV3qIhZXnzwNNM3ITEC4XDHpcpXpk3MOJSGvEG9DGzDeY5zn9b76zVxkQM/0heUw5HIV
         suPhjkV0wYi7IZ9ZVKEut+NoajlpG6bP5DrGbX13FO9mCq/Q4ajGCmp9gm1iYMtvVpch
         BzUyQOHaqka2aGRNn+zPt62V3avoOoAUWIjeaGaaYwmTzZd2Jkeilr4qV3xT0CeWaFMA
         YNcUlxyFu05DyrAndESZOWVNuSlrdJSsxKk9Oot5aqrpidyptUD7uYTBNlOeGpoHVau2
         0Xdg==
X-Forwarded-Encrypted: i=1; AJvYcCVcFL8HjnOmN5HOcb97j8jekbMcW/oYdSCBb8Slt1LvnTFax0GnR34sYgj3uubiiyY5T0/9FFXjx/rAlQga90iZitIOC+29aRA1o+Ql
X-Gm-Message-State: AOJu0YyKBbotUq/Wyf/rLBAJFm1O+fm0LOCR19C6u6qNLBCJrpQC8+hP
	lXh80J0GP65WdKO8ZljlDpukmDm/0OYDHfMUCECHQTcnq7kGhT8KfPF+WulFx8o=
X-Google-Smtp-Source: AGHT+IHptq2OgYAvI57tZAHlVqS/QUlqfkHRqWlTKeBEMfc8kISRVxCP6cb16qz5VFBSWeRVoT5HEA==
X-Received: by 2002:a05:6402:50cd:b0:568:9936:b2e with SMTP id h13-20020a05640250cd00b0056899360b2emr1705246edb.24.1711718163797;
        Fri, 29 Mar 2024 06:16:03 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id n17-20020a05640205d100b0056c55252b1csm1683718edx.41.2024.03.29.06.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 06:16:03 -0700 (PDT)
Message-ID: <42ef5a02-a50e-4a4a-9d07-2f5848857560@linaro.org>
Date: Fri, 29 Mar 2024 14:16:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.1 04/52] arm64: dts: qcom: sdm630: add USB QMP
 PHY support
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20240329124605.3091273-1-sashal@kernel.org>
 <20240329124605.3091273-4-sashal@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240329124605.3091273-4-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.03.2024 1:44 PM, Sasha Levin wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> [ Upstream commit bb5009a24ec3f2f2ec1e2ed7b8a5dcde9a9e28d9 ]
> 
> Define USB3 QMP PHY presend on the SDM630 / SDM660 platforms. Enable it by
> default in the USB3 host, but (for compatibility), force USB 2.0 mode
> for all defined boards. The boards should opt-in to enable USB 3.0
> support.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Link: https://lore.kernel.org/r/20240116-sdm660-usb3-support-v1-3-2fbd683aea77@linaro.org
> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Hi, this depends on other kernel changes and can possibly regress something
if EPROBE_DEFER isn't handled correctly (because it will never probe)

Please drop it from all queues

Konrad

