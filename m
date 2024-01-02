Return-Path: <linux-kernel+bounces-14480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6329E821D9C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F3B1C20C1D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F49111719;
	Tue,  2 Jan 2024 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q+hiFzRa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0316D11708
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e67f70f34so8115950e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 06:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704205652; x=1704810452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NFaHotn2cJmn9bSUZqN8YKUiA/IurWzWG53AtgwJCMk=;
        b=q+hiFzRaXYYyF89J1GOudz2n+ARL7JEAdtYT5pf/A3OD5CmymprB4tf+uvdzv7uWSq
         ZaDbWIZNnYght6IeZDAsgs0IYQ7FLwNWGI9F6KqEHcSh2HypXc82hbU3Pb9j0oJwfSzB
         Fs7+RSxdwXlO8aSlfTVQW2UEDkr+WzcIu2NaLkGIQfDT2JUm0iPnoqyVosb+sK3dPqs4
         99F7U29ur93vfZI9zLmoOeAJU9BW/EgWgsPocH1hfrWCmWsNv7G9Rieq/lU3i24NR7o+
         RiQbAl095YVrEW8q/l2QfFdS1Zly0SbUiwwzmRDnqOUohKCHidNrgTomheeCwyd8c5a7
         6a/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704205652; x=1704810452;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFaHotn2cJmn9bSUZqN8YKUiA/IurWzWG53AtgwJCMk=;
        b=cOqudxrxbOXfKDPzU63AbNcq/jPiqmLgnmfYJBpmZiyLa43UGWQeIPc2jS2NMVHGPv
         sBb5q/Ln3+4ZrSRz6gVaBUrJ/CXUZDSG+LvZvMdHw0yYX0Ob8BQII0H2BypJx5K3OtOV
         5CXfhgNfRre9gxEj7k3T/SGOdCw/ebE/RNjZHRhcPas66mV1XKPHQABi38fA0Vlf7L9H
         gwUY6MuXHtqpAAdgYIITaAW4nHLj0fSDsZDaCZskBohKpWe/gI5VXoePxcOkNm28lyI4
         BK6vcODgt2MlrUrc//JGYX+XwEJnDhx0ReNuEqXXu3I9QIXP1mrg38Jy50/srcs1gOBf
         BPPw==
X-Gm-Message-State: AOJu0Yw9MOXptg5kMLRdc/rQek3a6tP/TjcHuluh3jT3zerI5JfshiQm
	Fr/2MNPRn5N/2xG/qdNoerLqduDNfoP9Yg==
X-Google-Smtp-Source: AGHT+IG0DqgpsdZCuWAexDRCxSamRyVlM3Yf8OX2pliD+8Tvo0ksw10OtMaBn7DKGWpFLCew9BRXRg==
X-Received: by 2002:ac2:47e6:0:b0:50e:7702:a18d with SMTP id b6-20020ac247e6000000b0050e7702a18dmr4756560lfp.36.1704205652109;
        Tue, 02 Jan 2024 06:27:32 -0800 (PST)
Received: from [192.168.199.125] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id t15-20020a056402020f00b005534057c72dsm15858756edv.18.2024.01.02.06.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 06:27:31 -0800 (PST)
Message-ID: <90749db5-a803-4bf0-8543-f049249b1df0@linaro.org>
Date: Tue, 2 Jan 2024 15:27:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] clk: qcom: Use qcom_branch_set_clk_en()
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v4-0-32c293ded915@linaro.org>
 <20230717-topic-branch_aon_cleanup-v4-2-32c293ded915@linaro.org>
 <ZZPnAvXB8oqds4KM@hovoldconsulting.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZZPnAvXB8oqds4KM@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2.01.2024 11:35, Johan Hovold wrote:
> On Sat, Dec 30, 2023 at 02:04:04PM +0100, Konrad Dybcio wrote:
>> Instead of magically poking at the bit0 of branch clocks' CBCR, use
>> the newly introduced helper.
>>
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
> 
>> diff --git a/drivers/clk/qcom/camcc-sc8280xp.c b/drivers/clk/qcom/camcc-sc8280xp.c
>> index 3dcd79b01515..94db130b85e2 100644
>> --- a/drivers/clk/qcom/camcc-sc8280xp.c
>> +++ b/drivers/clk/qcom/camcc-sc8280xp.c
>> @@ -3010,10 +3010,8 @@ static int camcc_sc8280xp_probe(struct platform_device *pdev)
>>  	clk_lucid_pll_configure(&camcc_pll6, regmap, &camcc_pll6_config);
>>  	clk_lucid_pll_configure(&camcc_pll7, regmap, &camcc_pll7_config);
>>  
>> -	/*
>> -	 * Keep camcc_gdsc_clk always enabled:
>> -	 */
>> -	regmap_update_bits(regmap, 0xc1e4, BIT(0), 1);
>> +	/* Keep the critical clocks always-on */
>> +	qcom_branch_set_clk_en(regmap, 0xc1e4); /* CAMCC_GDSC_CLK */
> 
> I still think something along the lines of
> 
> 	/* Keep some clocks always on */
> 
> is preferred as it is far from obvious why a camera clock would be
> considered "critical".
> 
> Or perhaps you can come up with a better description of why we've
> decided not to model these clocks and just leave them ungated.
Technically they're not really super critical if the hardware is
not in use.. It's just that at one point Qualcomm decided to take
the lazy decision to keep them always-on downstream and we seem to
have agreed on going with that, instead of pm_clk (remember my old
attempt at getting rid of this on dispcc-sc8280xp?)..

For now, I was just trying to clean this up a bit before looking
into a better solution for this (probably a whole lot of pm_clks
with some clever handle-getting due to different ways of grabbing
clock sources.. by-name vs by-index vs global lookup that we've
accumulated over the years).

Some clock drivers do expose clocks that are related to the CPU
subsystem access and keep them always-on for obvious reasons,
but on newer socs they're not even controlled from Linux, so
perhaps we can just unregister these (read: delete from the driver)

Konrad

