Return-Path: <linux-kernel+bounces-137463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05E789E278
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33FAB1F2271C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF8E156C5C;
	Tue,  9 Apr 2024 18:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VNZSe1pb"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D8B156975
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712687077; cv=none; b=pvfja4YuGbLlHVDJb72g725tXasAf2uqgwHMCgFR2/k9jJEfVZNRYXD1tQtzis8XOxBE8c/aZJxDnyY45gVSB5SWsJgfh33dB56G/Sz6xKHvz9TgJUQ9WMrcbSWTbvEKf0qtuSF6eZEa8KAiFVrNfgOKTWU6+NUQsPDpIp7OkPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712687077; c=relaxed/simple;
	bh=nOnsfl0GsfC4VdYtGwNa9Kp0Hw9JKCJNwUkrKLiFAWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2NGHw2c70IyrtJXcaNVWRIMPUdLYNh79fjLPwpH4+PQFFBhx7v/kWPP6X2O6UePHRHO8QnAcP8SpbUhz754dyDUl8pAJqGrbxgTwxI08BC050rXcOoJrFL49v015J5GctMD15cGAWoBLBdqmKKcc8VGA6Kwm3tOWPZdQGmEjlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VNZSe1pb; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d3a470d5so5549061e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 11:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712687074; x=1713291874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+wZb9A72MwDJrPbXbqaYUytPBMFCCM9T0SRAGYwfDmk=;
        b=VNZSe1pbWyK3yczEpXTdEfGoJWM+hW4aCMPUXm2qNzG8J8cK8bjJ2sZbuInJN6wGAh
         +NAbHahTp4sClmEHEUGMZkuu6fVW6khWhmFMTgNl9cZDT9SznoNZUENspekDVEWk9O6T
         779hTRCFtAzUouMWsndUvBtqhW/pqHjYK7YXfIINvINwvXBu6Zt6DlugHP60OyHjeThC
         y1WYXuACy05qlQQNE/ZGyfUjX/u+gEId+Ky4tppGIQswWuFzcsJSPgmnE2tiUGhmDlm9
         h2Z3M9tnZ9GyE09y0/U3/04zkOMDO/oMsiA7HI4Gcg/3akasRdx5zVGIeFgxaRrTTXxe
         IbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712687074; x=1713291874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wZb9A72MwDJrPbXbqaYUytPBMFCCM9T0SRAGYwfDmk=;
        b=pnIUqFb99ztJBpQ7d/6+NqzTQXu003bs/ITs77pk0LOgmqAEnna09zIT+K3CmXhyYq
         ASPhwM3z4lGY0gEI7h7K2baSjyHzpjZzxTjvtxIm70R9RtrKfn9dScMU+97bgda7F286
         lGUWFFYo6PHjt5z/9JEjoLUjnHcwMs0yteXBvRNfggTG9pH17LT0pjDADu9vD5N4Hghu
         O4784EtYkZUIsDJMOLO48voIguQs4BaS/Y/dw0gUPaP6L0MlKiOeNVW1sEa8b10NEWbu
         d0e/nbxSg5JID4+kJhEGhN9tiitrItA+JdKVk++X26oXEz8w6ah3UMZWnVgaSkcpbTob
         pJUg==
X-Forwarded-Encrypted: i=1; AJvYcCWX9EDcz+VmLhQkVX7OCOXoXcbbv75Vu4+4/jfLQBMv5JTd5SJMdoOlOkbC5o6E9oyJdjxTZ5oZY2naLGB4it7o9Ex4WLJU252mO2kk
X-Gm-Message-State: AOJu0Yx5ddlW+6necti4FPi0p1qDeC7gpbuO+KRDrMgqKo6Oau8Mp/X4
	Z+wW1bg1OHh8FatrCWj5ESfqL+7X5fxZqHXwGNN2eteew/ahO6/zb3u2ZkDvgv0=
X-Google-Smtp-Source: AGHT+IEGVmVudAUUvOpB+47PLzEQGYCSW5jNcVOF4tNWsu36IrgL+X333aSTtWdGLpXbwDJh9Rb8Wg==
X-Received: by 2002:a19:ae1a:0:b0:515:b8d5:c5b7 with SMTP id f26-20020a19ae1a000000b00515b8d5c5b7mr167459lfc.56.1712687073914;
        Tue, 09 Apr 2024 11:24:33 -0700 (PDT)
Received: from [172.30.205.99] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id y18-20020a196412000000b00516ce0257a8sm1627709lfb.105.2024.04.09.11.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 11:24:33 -0700 (PDT)
Message-ID: <cb406f9a-36a9-45f5-a10c-d989bf602da6@linaro.org>
Date: Tue, 9 Apr 2024 20:24:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/19] media: venus: pm_helpers: Kill dead code
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Andy Gross
 <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230911-topic-mars-v3-0-79f23b81c261@linaro.org>
 <20230911-topic-mars-v3-5-79f23b81c261@linaro.org>
 <fe9744d9-2db0-b1f3-72be-0fff1ee90d07@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <fe9744d9-2db0-b1f3-72be-0fff1ee90d07@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/5/24 09:49, Dikshita Agarwal wrote:
> 
> 
> On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
>> A situation like:
>>
>> if (!foo)
>> 	goto bar;
>>
>> for (i = 0; i < foo; i++)
>> 	...1...
>>
>> bar:
>> 	...2...
>>
>> is totally identical to:
>>
>> for (i = 0; i < 0; i++) // === if (0)
>> 	...1...
>>
>> ...2...
>>
>> Get rid of such boilerplate.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/media/platform/qcom/venus/pm_helpers.c | 10 ----------
>>   1 file changed, 10 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
>> index ef4b0f0da36f..730c4b593cec 100644
>> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
>> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
>> @@ -878,14 +878,10 @@ static int vcodec_domains_get(struct venus_core *core)
>>   		.pd_flags = PD_FLAG_NO_DEV_LINK,
>>   	};
>>   
>> -	if (!res->vcodec_pmdomains_num)
>> -		goto skip_pmdomains;
>> -
> this condition should still be there to skip calling
> dev_pm_domain_attach_list if vcodec_pmdomains_num is 0.

That should be totally fine, within that function there's this bit

if (num_pds <= 0)
	return 0;

which bails out gracefully

Konrad

