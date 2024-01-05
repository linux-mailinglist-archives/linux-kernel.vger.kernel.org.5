Return-Path: <linux-kernel+bounces-18317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E93F825B74
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F1E1B22395
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851D236099;
	Fri,  5 Jan 2024 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cIxmNUxN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EDC35F15
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ccbc328744so23605741fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 12:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704485752; x=1705090552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B49zd4rGVpOEQ3g+hpM+Q91n3Dq8VqenteoL/h06scs=;
        b=cIxmNUxN7X/oFcR27Yx+C7sOPU53d2MkVX1AOLfuNUF2QkUNFwkJQVuq3AoqlIN1eq
         M9A/NPtvQPFaCJ15vB/q7Ja/bLic7qdMaws6GG3jrwGrxpVA+xZNDiWp6DqG166Elo/w
         DElYTzepCCvNQfTW8st9G3Nna5q1L4Yrn8UonWgpAxbWjUbkipk4F6Ww85U4rAeyiDkY
         xfbGSN2V98nPdTbdJmQS0ld90MQycr2NI1nsxHzMlbmiLAL5+Vl0M1dFp3DxwuJCpsIS
         d3Q7jLW7k3JYGgoSydUpf6JCxCUBSN8M4XJZtsvaWyZDzaFK3VG9cfU9WQPuiSOMlGai
         XLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704485752; x=1705090552;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B49zd4rGVpOEQ3g+hpM+Q91n3Dq8VqenteoL/h06scs=;
        b=woWvwlCPLh3VWc2co9H3rLfkpOQN4oL4BgpmruKd92CkhavFVQY0EtvLtXz0Mi7+Ms
         IOgpHT13O2TgiMLi/p5Wykw86PxZv99j7GGAig9ti4V9TvoWdz4nB8a9Rr6tQWqe1I6i
         vYQT7GYBE1mr/417vjIh5q9bakPrnJ87KK6BQoi5spICc+jAYpI9apye5lodPxlOJegK
         ucoZwPhrXmxSpm6pbyqL4YkzK3p+FtFz5L6/7+t96i0PkxLsjaJXvDJtBFSxHrpkW179
         rHi+lysfloifF8LKT8X6j5tUMIJpvm6F/noRYCah40dOs+TrkIptJUcbbmT5KohTMthr
         fxbg==
X-Gm-Message-State: AOJu0Yxq67bbRvF6ZLnsUMB8/QUGPzRt+iAFbp6KSSRlnLiNjcsksG2y
	aThwDDkXawYQcTWY2Ei2Ts7ndaopkgG2zQ==
X-Google-Smtp-Source: AGHT+IFm+9G7NhZ/QCfHM2cXlnn2TEnHYoC6V1iLFWAmWFiJ8jnLtq4cn356Sqca9dkZwrj29DZphQ==
X-Received: by 2002:a05:651c:4c6:b0:2cd:1d5d:322b with SMTP id e6-20020a05651c04c600b002cd1d5d322bmr1758186lji.57.1704485751978;
        Fri, 05 Jan 2024 12:15:51 -0800 (PST)
Received: from [192.168.199.125] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id v9-20020aa7cd49000000b005533a9934b6sm1315856edw.54.2024.01.05.12.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 12:15:51 -0800 (PST)
Message-ID: <7271846f-c03f-4d0f-a54b-7424ddd72724@linaro.org>
Date: Fri, 5 Jan 2024 21:15:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] regulator: qcom_smd: Keep one rpm handle for all vregs
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231227-topic-rpm_vreg_cleanup-v2-1-04c79c4f9166@linaro.org>
 <b5a2f511-2758-452d-b6ac-399262b3734d@sirena.org.uk>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <b5a2f511-2758-452d-b6ac-399262b3734d@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5.01.2024 17:31, Mark Brown wrote:
> On Wed, Jan 03, 2024 at 09:18:37PM +0100, Konrad Dybcio wrote:
> 
>> -	rpm = dev_get_drvdata(pdev->dev.parent);
>> -	if (!rpm) {
>> +	smd_vreg_rpm = dev_get_drvdata(pdev->dev.parent);
>> +	if (!smd_vreg_rpm) {
>>  		dev_err(&pdev->dev, "Unable to retrieve handle to rpm\n");
>>  		return -ENODEV;
>>  	}
> 
> It'd be slightly more robust to have a check here that we do get the
> same RPM back if the variable is already set, just on the off chance
> that something changes in some future system and we do end up with a
> second RPM somehow.

Knowing how improbable this is (currently RPM is responsible for almost all
power and some clock rails, including DDR), I'd say it's excessive, but if
you wish, I can add it.

Konrad

