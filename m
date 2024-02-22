Return-Path: <linux-kernel+bounces-76024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8F085F21D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0561C22293
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DD7179A8;
	Thu, 22 Feb 2024 07:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZd6dWj8"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CAC17994
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588027; cv=none; b=OtVJl3CA2hPgjYaX8Mfyvm9TmTsyBbVBvNDYzT3S4MnnpAxg3uea7qK3dGk99JT7RYi6wCTDf/xhHj2MP8El573xAB+3/BB1i/oGlujhPpJNIGmrjgaR+aagmpdTlv4qhbojY+1brCRGsRnXsRYk8PMfc8ISGk3BqREVeYMHihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588027; c=relaxed/simple;
	bh=wJBFHsQ66055reSqqi6It9R23VoGCCMweYpA5lfJPPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mm1e7hoUYu6Uc+ppkYS1sPk2pnPrx3bgXKjqHc0c6Yit7YC1JGtG0kHxUr7kZUxzSZwzlYrn0urKHdh8xsoncry/Q/V8NagdtBvvOCxnH+KCKxWNcVl7vfjsjCVNfGmkiaGXk1WYuy47FzL5p9/2RLsdC72QnoLKAZFeTSgTHv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KZd6dWj8; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so2132217a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708588023; x=1709192823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nPtrn2AJlyFrVhVFg0+RrmhVpSvDXT3cdrnrFrP+YME=;
        b=KZd6dWj8oajx4mmh73rFm4tmgT8rw3VlKZ8M+ZrEA5Q5+Vk4vorG6AVsd8qeuBTuj0
         BJzrInvGlthTuTG2wBZjz6k5xOIPNeGQx6gcV3vn4z/UtArlS1W5Pr6ZjwyRPVowyDIg
         oZBf+/kwBguitF1jt5fT1booHVtL4ytuAuscKIy5YTQdX+L9aHYM2vSnVWg0lg25K1Wa
         dimSqJ7cD3ATqcp/0dS4TnWwSG9gXAr8v0ZnlMGjj7ZmoNLnAyK16qYlByeZfaXVJZAN
         CGcDJfih4bd2YlWhbV35p74GaxFv4l8XUaG2rKTUbs8HECI71HrXS/xMmbYJ4O8IuSYH
         WMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708588023; x=1709192823;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPtrn2AJlyFrVhVFg0+RrmhVpSvDXT3cdrnrFrP+YME=;
        b=Fe7pJeoNBidxwKkPKmi0qAQXQBN8dJ/Bg/viLfMGLzyzT0zo7sG+PGAn04DpCqcM3R
         QQ4SQD1GGc3vORTXaG1h7+e3Wd9T42Zq8eCOrf/2u1DdBNf8yO1NLRxaAMHZeszgxFzN
         4ShRhnbv6hokIsWC9/LG/X3qkA6MEd/DLl9+ffGbZlJKoWvv0K9gH26X8K58u1WM+L5F
         WdGsRCHDeDJbDJhCv4HsuBV0YykWiLxjosXXDivrSFKF0j+R/wT7xmVMIdceXxZ4YhbN
         E+fM8WQfXX7dgpLCyO77gewDtNiKbQSIQjPbRmeRNUqQ3Q/9qeVpxVwovtIy/XiOZUGl
         ZioA==
X-Forwarded-Encrypted: i=1; AJvYcCV07JpoDrgR0Yzb2vVqL5VxCQpVOY8BcttU3ujnYagXedyS48SmC9Z5K5F6G3llOqAd1pFgt+z7kXmX5TnFzNDwM/6duwUaFyZld7h7
X-Gm-Message-State: AOJu0YyXXE/1g3LbMX+oKY6R4gfrWo5N26kvqN7dL3CE8KbXU3gYxXmM
	KQm8crR0g6k9eYS/i5jNtyiUI+Tp7VRJrlt5w5+cUY8Os0M8Pc2ad+CAjFsj7TI=
X-Google-Smtp-Source: AGHT+IHSrLKY+pxwdrtKyhvCh2pr+Bjwrjzz/crpqYDIb/F9FwG/huwkjS75Xvr395MFitR+p8cBmQ==
X-Received: by 2002:a05:6402:288:b0:565:2fe2:905b with SMTP id l8-20020a056402028800b005652fe2905bmr719464edv.6.1708588023656;
        Wed, 21 Feb 2024 23:47:03 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id h10-20020a0564020e0a00b005641bab8db3sm5128141edh.86.2024.02.21.23.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 23:47:03 -0800 (PST)
Message-ID: <c4f7e3cb-db9b-48be-883e-33878d2510e8@linaro.org>
Date: Thu, 22 Feb 2024 08:47:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] clk: samsung: Keep register offsets in chip
 specific structure
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240216223245.12273-1-semen.protsenko@linaro.org>
 <20240216223245.12273-12-semen.protsenko@linaro.org>
 <ce515530-428a-4a21-8c56-5a497cc8130a@linaro.org>
 <CAPLW+4=kpk=Vg=nX-hVxcCS0OttC6xmyUcB005tmX+vtUF9TLA@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAPLW+4=kpk=Vg=nX-hVxcCS0OttC6xmyUcB005tmX+vtUF9TLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/02/2024 01:42, Sam Protsenko wrote:
> On Tue, Feb 20, 2024 at 5:04 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 16/02/2024 23:32, Sam Protsenko wrote:
>>> Abstract CPU clock registers by keeping their offsets in a dedicated
>>> chip specific structure to accommodate for oncoming Exynos850 support,
>>> which has different offsets for cluster 0 and cluster 1. This rework
>>> also makes it possible to use exynos_set_safe_div() for all chips, so
>>> exynos5433_set_safe_div() is removed here to reduce the code
>>> duplication.
>>>
>>
>> So that's the answer why you could not use flags anymore - you need an
>> enum, not a bitmap. Such short explanation should be in previous commits
>> justifying moving reg layout to new property.
> 
> Will do, thanks.
> 
>>
>>> No functional change.
>>>
>>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>>> ---
>>>  drivers/clk/samsung/clk-cpu.c | 156 +++++++++++++++++++---------------
>>>  1 file changed, 86 insertions(+), 70 deletions(-)
>>>
>>> diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
>>> index 04394d2166c9..744b609c222d 100644
>>> --- a/drivers/clk/samsung/clk-cpu.c
>>> +++ b/drivers/clk/samsung/clk-cpu.c
>>> @@ -44,12 +44,14 @@ typedef int (*exynos_rate_change_fn_t)(struct clk_notifier_data *ndata,
>>>
>>>  /**
>>>   * struct exynos_cpuclk_chip - Chip specific data for CPU clock
>>> + * @regs: register offsets for CPU related clocks
>>>   * @pre_rate_cb: callback to run before CPU clock rate change
>>>   * @post_rate_cb: callback to run after CPU clock rate change
>>>   */
>>>  struct exynos_cpuclk_chip {
>>> -     exynos_rate_change_fn_t pre_rate_cb;
>>> -     exynos_rate_change_fn_t post_rate_cb;
>>> +     const void                              * const regs;
>>
>> Why this is void?
>>
> 
> Different chips can have very different register layout. For example,
> older Exynos chips usually keep multiple CPU divider ratios in one
> single register, whereas more modern chips have a dedicated register
> for each divider clock. Also, old chips usually split divider ratio vs
> DIV clock status between different registers, but in modern chips they
> both live in one single register. Having (void *) makes it possible to
> keep pointers to different structures, and each function for the
> particular chip can "know" which exactly structure is stored there,
> casting (void *) to a needed type. Another way to do that would be to
> have "one-size-fits-all" structure with all possible registers for all
> possible chips. I don't know, I just didn't like that for a couple of
> reasons, so decided to go with (void *).
> 
> I'll add some explanation in the commit message in v2.

Currently the one-size-fits-all seems feasible, even if few fields are
not matching, so I would prefer to go this approach.

Best regards,
Krzysztof


