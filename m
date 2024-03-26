Return-Path: <linux-kernel+bounces-120036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF6688D09E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660092E77A3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EB213D8B7;
	Tue, 26 Mar 2024 22:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VND7f/sE"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D266D13DBA8;
	Tue, 26 Mar 2024 22:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491410; cv=none; b=SczkwVPEGxyr4eJ1+AhOCHj0jcjUZy/cHj0TxfMoWd0dHOHUDnl5tyV5QXor8k/rasblS/rEi0RM7lZeH/7EM2pHmAamPNOrIyBMKD3rFskODm+jXG9+S4kedMIELOlIUY3jxZkzx84pQLaYK5aWpLLU6B7qZFM9raPuJGGKfhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491410; c=relaxed/simple;
	bh=J0RnoOCSqOqlajOtrlqrGQ/DJiRxB7k7ItoWaD5DBwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QyZ6rc9rgTvoQw+V1AXuvItmg0xVkjHUwuy6X8d3K9ORZpPWgmE+MYfnQfNGK5v+xRzj4idlIPNSQxd9TjpUjODWkI/mYr0PYkKbKMRtFDgh/0aXsdV1Xt+6wqula42fDdL9f1l4IBHm0qzBKxDhpBPqHNrpAW8nVtqB0+ISMGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VND7f/sE; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so798076366b.0;
        Tue, 26 Mar 2024 15:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711491407; x=1712096207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YplBHOu9LgYYYqj2137kfj3IsGRSUTd9LNfjx3vcjjg=;
        b=VND7f/sEDAFF7XvR5ueTwdplEJHudc8dVOmZi6EYUgqSK7gS77Mi2Ea4zFM9tQ5LrE
         MvswvLp0qDXwnX31C+iC1dFIyH3vsEypr676SWSHv2ecasn/6eo3iY9+F1nr3uyLAlUD
         sClPUKTi604GXEcfq97XKTYuWPhtyNkG3Kvom7D9KerN587y3BLuEiu2SoxDQPuB1ndq
         /tGxWxGQ2hnNiF27xJ6Qhk1xLUlMq2uHhWW4R9h8cJec0AqkWZ7Y+JPewmcZNUrDvkl0
         kDKySvZN+xe227lemoKG9XzemJdMEngaYQRnagQe64xLCzs/kbRnFloJvB5N20u5CduK
         GQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711491407; x=1712096207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YplBHOu9LgYYYqj2137kfj3IsGRSUTd9LNfjx3vcjjg=;
        b=ai1QlrJhfbvLuRb7bT2bdNmMqpve2rW+TKWLktycLGXZCJX2mht3dXuMXf1pfo2AAU
         qvESzLu8OD+CuMGmjVl1sYM32bb26inX22HDHiLBazxud1XJu1hRXfeOcSEbp0D4bHIx
         l3QU/GGeaepMmsE8kRtNSk6mwJY+c8ph1TDdQwZ66njGP8ZgpmYBub9zexLORzcCNFaV
         X5OODMU91F5wcDAMsKXmiK7z8qSW2GT6EODK0WK1xRyk34q0ggCjwNrKRpY3x3ZpGvKY
         +4teTQ7qGBTlUK7/wAQbGJeaSebRr4uYPHNik50A0tV+x7jIuadpTbIxwvKmk+IejxSN
         ja2A==
X-Forwarded-Encrypted: i=1; AJvYcCVI57Qu80ONvA0+kNtaXYj3qbKCvTkh4JaHUlwQlROveIPTGHAGy2n6eobxxpWiU2etUjoJlLVdZ8xIWbao6M+JMoAGSAwxm8ERaTAH508SEbLuxH+ZDwlboaUCqRC4ZabDJI3WjZWKXrGoQ7KoGL/HbhrqQSFvKdE5FDx+xSTd
X-Gm-Message-State: AOJu0YwtAupbVw55DBuC5CnABHQ/vMTJVlwumXgkAY8UyLjGMz6Y0uy3
	qVWqTAMM78ALNH/IBtiKkizKLYg+YUKyKy3Dw8Arv6H95K85JNrnlUgwfzY50YQ=
X-Google-Smtp-Source: AGHT+IEMQ/FGGPjdWPwfIps8GVz+mdG3Mk7kmNLcwzNisJ9N/wYV9naSZ1NmkPkEuqFh+dHus6mQbA==
X-Received: by 2002:a17:906:c111:b0:a47:4b76:6258 with SMTP id do17-20020a170906c11100b00a474b766258mr7482552ejc.25.1711491407123;
        Tue, 26 Mar 2024 15:16:47 -0700 (PDT)
Received: from [192.168.20.170] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.gmail.com with ESMTPSA id l11-20020a170906414b00b00a46c39e6a47sm4724191ejk.148.2024.03.26.15.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 15:16:46 -0700 (PDT)
Message-ID: <d81eb0dd-f1ee-4a54-aa04-9ebe8b8eff88@gmail.com>
Date: Tue, 26 Mar 2024 23:16:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: qcom: clk-alpha-pll: fix rate setting for Stromer
 PLLs
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Sricharan R <quic_srichara@quicinc.com>,
 Kathiravan T <quic_kathirav@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240326-alpha-pll-fix-stromer-set-rate-v2-1-48ae83af71c8@gmail.com>
 <87af7b7e-9c2f-41e1-af97-01d3f29f5970@linaro.org>
Content-Language: hu
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <87af7b7e-9c2f-41e1-af97-01d3f29f5970@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024. 03. 26. 21:51 keltezéssel, Konrad Dybcio írta:

..
>> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
>> index 8a412ef47e163..8e98198d4b4b6 100644
>> --- a/drivers/clk/qcom/clk-alpha-pll.c
>> +++ b/drivers/clk/qcom/clk-alpha-pll.c
>> @@ -2490,6 +2490,10 @@ static int clk_alpha_pll_stromer_set_rate(struct clk_hw *hw, unsigned long rate,
>>  	rate = alpha_pll_round_rate(rate, prate, &l, &a, ALPHA_REG_BITWIDTH);
>>  
>>  	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
>> +
>> +	if (ALPHA_REG_BITWIDTH > ALPHA_BITWIDTH)
>> +		a <<= ALPHA_REG_BITWIDTH - ALPHA_BITWIDTH;
> 
> Uh.. that's not right, this is comparing two constants
> 
> Did you mean to use pll_alpha_width()?

No, not in this patch at least.

The clk_alpha_pll_stromer_set_rate() function assumes that the alpha register is
40 bits wide, and currently it does not use pll_alpha_width() at all.
Originally, I have converted the function to use it, but that made the change
unnecessarily complex since it was a mix of a fix and of a rework.

The current patch is a simplified version of that, but i forgot to drop the
comparison at the end of the process.

In order to keep this fix as simple as possible and backportable to stable
kernels, I would rather remove the comparison to reduce the change to a
single-line addition. Then modifying the code to use pll_alpha_width() can be
done in a separate change.

Regards,
Gabor


