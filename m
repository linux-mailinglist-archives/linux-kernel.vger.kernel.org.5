Return-Path: <linux-kernel+bounces-17303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 099D1824B20
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5B21C22A41
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D142D022;
	Thu,  4 Jan 2024 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pr1eCYjd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B982CCBB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d89105365so8743195e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 14:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704408367; x=1705013167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=alNrLSr0vpGWNK/6L+uLnjjf3nOao06SX6CzGEth2ao=;
        b=Pr1eCYjdLHEWZo3h0ad4oPgvbDgkObSLuRHrpKty0jdEDqWzWUjv58E2dnnLaQwJnv
         qXipdoDKh5bjU6MjkGL5X65Sj6CPc0Koy0KEfbFRZCylBZRRLYB0ht9+thgAijDQEsMF
         Tp0++x8GTKL85qfOuYyTZm+45iA7zz6J6YlJ0ERB1Ku1+QdsPTe0uhgmjTeOqcNVrlgl
         8cVbr1d8lFkEryQCp1IDJN5cx8uKmWgMsHMRzifpyL3s1qRg/sHMrWAV98H2fZhbY9vu
         gDOquBoWPLtC+Un1zfTMAmvyrcLc8rHhOZDVNfrVdWLN9mm3Fngq2/0ZP+vFVmD+gMyr
         fI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704408367; x=1705013167;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=alNrLSr0vpGWNK/6L+uLnjjf3nOao06SX6CzGEth2ao=;
        b=F2SUvS2uRXj3OEN9adLR22TrZGTddiN0GLVHxmA9r1x98EJLMW2T9RGl27+Z/Q8I3T
         6gyfVgc0fYHZLzM67HARDKsPPV0NloDQk0KmWQhy6/Ml7D5qJI0HC/R7tXVJa6YsX1Lb
         8nBj4QFF4+Apdo/pnSrARAMHcSnE92/CcPCZZxQPE8Gae8l/ygi+0Rm75YbqbI6VPtPp
         jC6eu1TUNOXxCjKATR7TA0zNISZ7kTLTxS9Igdt/mA3ZDvhPuplduok8rTrDkoqWICw5
         /3XOcwOTgLXVCoJvsR5nIpBoVo6N0/I5OhosTH44WvpwU6ipkSi5dl3G7h5tILGM+8mt
         8KKw==
X-Gm-Message-State: AOJu0YxAqc1PV8B2RrnBZkGFHO/2Q+4vP9dZBY3AGRHFn5EKDNNYst7I
	T+9SqZfD/OiVPwVBhj9m2h7l3M1RRgAOyQ==
X-Google-Smtp-Source: AGHT+IF4IaO9vRFD0mkUsLeLZL7V2E2O2Y9xw6r19GiUl+eNn8vovriXD3avgbVJznPdRs1iAIg/rQ==
X-Received: by 2002:a05:600c:1d1b:b0:408:3696:3d51 with SMTP id l27-20020a05600c1d1b00b0040836963d51mr727112wms.4.1704408367640;
        Thu, 04 Jan 2024 14:46:07 -0800 (PST)
Received: from [192.168.199.125] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id yy4-20020a170906dc0400b00a28fa7838bbsm147829ejb.65.2024.01.04.14.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 14:46:07 -0800 (PST)
Message-ID: <8d6c659a-5164-4f85-a90c-6d3f439821b6@linaro.org>
Date: Thu, 4 Jan 2024 23:46:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] phy: qualcomm: eusb2-repeater: Fix the regfields for
 multiple instances
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240104-phy-qcom-eusb2-repeater-fixes-v1-0-047b7b6b8333@linaro.org>
 <20240104-phy-qcom-eusb2-repeater-fixes-v1-1-047b7b6b8333@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240104-phy-qcom-eusb2-repeater-fixes-v1-1-047b7b6b8333@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4.01.2024 15:52, Abel Vesa wrote:
> The global regmap fields offsets currently get incremented with the base
> address of the repeater. This issue doesn't get noticed unless the probe
> defers or there are multiple repeaters on that platform. So instead of
> incrementing the global ones, copy them for each instance of the
> repeater.
> 
> Fixes: 4ba2e52718c0 ("phy: qualcomm: phy-qcom-eusb2-repeater: Use regmap_fields")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
Ohh I wouldn't have thought about this.. Nice spot!

[...]

> -	struct reg_field *regfields = eusb2_repeater_tune_reg_fields;
>  	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
> +	struct reg_field *regfields = rptr->regfields;
Without this:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

