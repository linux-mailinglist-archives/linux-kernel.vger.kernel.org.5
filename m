Return-Path: <linux-kernel+bounces-13445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE8F8206B0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05402280FD3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 14:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F532B672;
	Sat, 30 Dec 2023 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HRcv/DPg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE99BB657
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d4103aed7so92838825e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 06:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703945432; x=1704550232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+c0j6bbsjMBV/kl71pxi0oW3JLtWSbRYa2S4SYKJxzM=;
        b=HRcv/DPgOcY1xfK+r+6cPndKsy80JTRYQ472uWutG/5zJduQz8gAwSMRuXIvXzPmif
         1uYDukvnm8/XsPk4XuDJ7plVdL4DV4JlD/879F6l6/XbJ8hd6AA2CbinJcybHbqUpCb8
         kFVQETaw7i/jSDdm/hjbqeZi5tdVK9kDgTe4CFG+1HCXMBfqdTTN903eeFjkjNeBZuoQ
         axa1/DRRJ9Tt6ZTcmANa+J8K+Iw6KzhojJFw2H7afCGYE/zNbR3AwUJ4TFPBGDRx6wkY
         Kf6RDRkMgvzPsXj4clcujwJrI7LTdhHsFTgQbbAb/T7fQHj9B1bMz/IDQ63lZ54FEAGr
         2rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703945432; x=1704550232;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+c0j6bbsjMBV/kl71pxi0oW3JLtWSbRYa2S4SYKJxzM=;
        b=hMCli6dgIdb0l+aCSNTaLHWLG7oLHGq0yFcGW0NbnXq50KpxB1GDT+Up7gZRi61PLC
         TLrBZZX/rYXciabxrjlgMzzI7bWVfG/Y+m4Y5FMtgMF+16pqsmAgvtrNonw6oVs8jADf
         UIZQvefhpyFmaNHvpPWsA4kiaPS+RQETj5nQa67P7zMQwFX965sKQBygZzJ2uE/ojQ/D
         t4MkdP4dhR7OhnUpNo3FYIx/MSnlxGj6LyAdfKdbnCSL7SHozFm3pa/NU0ZrVidnLdnT
         fShIevexy371eo6GJG7rQfHBrRchD6PDnmV/30xqzmoT9XIQaepxD50wvY+zhnqItQKX
         OLhQ==
X-Gm-Message-State: AOJu0Yxbz9By9Dcp1WmVDNmw7MyBgIToNTGheiJsA8rpO/9QAo+nTwg3
	08AvC0xU1VmaUjAO7Ta6+inv5IVq0t4xVg==
X-Google-Smtp-Source: AGHT+IEOUp96O7ZsNz3WKe4aaNJiU7IunBwI94mNBFg1GDWyINcr756WH7QtNzOgMe1/c5+00qMBHA==
X-Received: by 2002:a05:600c:3107:b0:40d:5f41:2e4d with SMTP id g7-20020a05600c310700b0040d5f412e4dmr2936770wmo.159.1703945432171;
        Sat, 30 Dec 2023 06:10:32 -0800 (PST)
Received: from [192.168.199.125] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id p9-20020a170907910900b00a26ac5e3683sm8529380ejq.100.2023.12.30.06.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 06:10:31 -0800 (PST)
Message-ID: <f431ab4e-fdd3-4771-a770-558cdba9ef75@linaro.org>
Date: Sat, 30 Dec 2023 15:10:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc8280xp-crd: Add PCIe CLKREQ#
 sleep state
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20231227-topic-8280_pcie_dts-v1-0-13d12b1698ff@linaro.org>
 <20231227-topic-8280_pcie_dts-v1-3-13d12b1698ff@linaro.org>
 <20231229171425.GC9098@thinkpad>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231229171425.GC9098@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.12.2023 18:14, Manivannan Sadhasivam wrote:
> On Wed, Dec 27, 2023 at 11:28:28PM +0100, Konrad Dybcio wrote:
>> The CLKREQ pin should not be muxed to its active function when the RC
>> is asleep. Add the missing pin sleep states to resolve that.
>>
> 
> I don't understand why it should not be muxed and wondering what is the actual
> issue you are seeing that lead to this conclusion.

According to my knowledge, demuxing this pin prevents the RC from
getting (possibly erronous) reference clock request signals when
running the RC shutdown sequence. Reading this again, the fixes
tags don't really fit this commit.

What's perhaps more interesting is that on msm8996, Qualcomm vendor
kernels used to remove the pull-up on the CLKREQ pin in its sleep
state, while on msm8998 through sm8550 they keep it there, always..
Perhaps an oversight?

Konrad


