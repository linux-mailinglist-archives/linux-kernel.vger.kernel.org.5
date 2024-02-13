Return-Path: <linux-kernel+bounces-63428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D32A2852F19
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11EAB1C22AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB41D524BA;
	Tue, 13 Feb 2024 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mkoTpQjl"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D06C51C44
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823301; cv=none; b=Puns6dZPef1zULMOvSuV9QpADgpkVF4f5uSqypY0EuH0KknvvHiWjtktH79PzXgi78w+ydQUgcDRFp+/UxP/iNYkL2DGOvYJcOUwokTow5YmSZqxb+lc0dTfRd8hU9j/payfFLLNAUC2P+Xt/OzBax0mMhK6fEKkdD30mzex5ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823301; c=relaxed/simple;
	bh=E/MH+y6TEKPyCEaTZoFzK1+I1nEXs5zapLHFnAW9WWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUbD+Vh1HiuRb9qcUB5iteo/w9wdFCuycG9MnFcVy8LC/bhDI+zwh2zLmHl+OcckmHAIHnY7i6ge7/pieaxvZOaGvQE+8Ak3rBjWo1DDb4SEf+QR+oRR8zd3zAgXCX883a+m5es58m7ftyfum+iYMPpx44zQ9yEP72hLbev30sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mkoTpQjl; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33b86bc4bbaso859155f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707823298; x=1708428098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZwJM8W1yq1JtwPkFDokQV9gTBoLw3sc+SISnD390BVE=;
        b=mkoTpQjlaULllc8Lrm1YA81ye9ugzGrmW8fKdGaJMnS1wch52vCGMA08q6GJwCuV5Y
         jB75W/W6VkELFSwuRODZI78esg1SgeNvfulu+PMWcLMtEaEvMECLkpd3pkaQx/goql6P
         LbShCaMAFzGc0EsEEeH4wbEOTPqgJKdD1kT4gLUevePDvyqm52KIKKraHVS94Zb3Tzs1
         HJjmf0OQfZ/9Kt6GX3XZXDeZcB8rXGtc3lsKzFVqK5H4yGx2F7ZFH8QEJWWEM0uq6P9B
         Y8YlRkfe4VRo3CedgTDy20CJyqBeFi0Kcxiq9FVTPVUO7eG76upHwWJvw4Qr8DxskzRt
         oSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707823298; x=1708428098;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwJM8W1yq1JtwPkFDokQV9gTBoLw3sc+SISnD390BVE=;
        b=f46Y1Z1x57RXsg6lVS/fkLz8noPIRCg6hPNuU3jgTXPKJn7hmwqthJUlJTc9Ck5uFZ
         agyF3f+HAD4xtTlYsvLKXMCxY+bwTTUzTwuLFv74JS6UQptZaU4xJht7ZSL/nLIO+0cc
         M0xSm7Bzf/Fajz4KlVWDJ419SXGYEuo3yPuH8zn8ev/crh9iTRfW3AqQbfE+u2NTn1Av
         dvdA3ocGxs63SkW1axM1O0CXc37rl2pFDoAgCn7hCzy20M6QUve475hjuonTVugL2Cqo
         PuBjzVpPT/8Q5dhYCLDDQGK2MK9ySDgup3watzlVy1NysvLipy34ULojXlXcZtojQ5n3
         kA8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCoJPAUaTed/xocvfxfR6G4O58aowriqifrS7FcWMyakdKNJ665cV/WPNX/ztTHRgd2SvaJzIoz8PPdwA14LHr9M3yz6nb/AntUp6r
X-Gm-Message-State: AOJu0YxeHvUvZoVmz/ppUGhogBTwbQ+yOZzXlb7U/pJL40ojfx14Z9Rd
	pi3QzSVKm8wu9s0YyEje7SqGaSFNTO8FhpMYbmV0A4yuQZoFNcNiQ1CI8ug/tk0=
X-Google-Smtp-Source: AGHT+IHlPJHwR5q+JFrphVeuRd8/uPI8ffAIkfJZ60S+xsdnSPX0H7+SdWZ31HCCtVOn0vEF+rMHYQ==
X-Received: by 2002:adf:f1cf:0:b0:33b:5725:e516 with SMTP id z15-20020adff1cf000000b0033b5725e516mr6721500wro.51.1707823298499;
        Tue, 13 Feb 2024 03:21:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUzYiJlRwoEGRPR3ACaDYhrZWUNFScEBW5fkT7ucYfJv2cfUvf+p/JPEXxEdbPnYAlfgdjGfCsNg0xf5s2C5JX2HDhk0yQxGvlFULY8f3Q8skLt1EJgC/92/mdK0VwVVdC+1j2kpGQqxXFRSujeW/V/FCnYEmmulPjgC2yF1qOFMDBINqWqktJqaPWZsLLr7O/P1P2N4VAH75F3uvlKYBk2UoA0Qse8UW8/zpuQhWGEOjIC3vlQemmV7LJrpEYvWJez0QL2CfMtGtHs+4NH1oaq0vgaJig7xlpq22qcmeqAYO3OpTP+aXZUyI1334xRPRObNOpv
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id bp9-20020a5d5a89000000b0033b4796641asm9435420wrb.22.2024.02.13.03.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 03:21:37 -0800 (PST)
Message-ID: <6b24ce0a-94d8-40d7-aa77-de88d597fa45@linaro.org>
Date: Tue, 13 Feb 2024 12:21:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] ARM: dts: qcom: msm8974: Split out common part of
 samsung-klte
Content-Language: en-US
To: Rong Zhang <i@rong.moe>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
References: <20240213110137.122737-1-i@rong.moe>
 <20240213110137.122737-2-i@rong.moe>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240213110137.122737-2-i@rong.moe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2024 11:58, Rong Zhang wrote:
> Samsung Galaxy S5 has many variants. Variants that support LTE use klte*
> as their codename. Currently, the only supported one is the one without
> any suffix, namely, klte. It is known that other klte* variants have
> only minor differences compared to klte and can mostly work with the
> klte DTB.
> 
> Split the common part into a common DTSI so that it can be imported in
> the DTS of klte and other klte* variants.
> 
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
>  ... qcom-msm8974pro-samsung-klte-common.dtsi} |   7 +-
>  .../dts/qcom/qcom-msm8974pro-samsung-klte.dts | 833 +-----------------

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


