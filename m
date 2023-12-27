Return-Path: <linux-kernel+bounces-12025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5401381EF06
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 13:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10986281B10
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3039E44C74;
	Wed, 27 Dec 2023 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+Id+ngJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFC344C71
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e7e1ddaddso1930579e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 04:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703680889; x=1704285689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MlZMvpx7rHlKyNjWFEIp/CNLoHdcQyGULZeal25qJkk=;
        b=E+Id+ngJwT9gAQ8TmU4zKV9jwwbmWI6I+uSXzUio/6jR+S5QStFiZoIUrNh7aMvGO+
         X+t+bOmbB81qSXCwoZ/pS0qFloufCeha1FuvQcQnHAcaSyqI1f7+Ju75sU94JHj71cRL
         d3O1LDd3jpWD/a7Wi/2917DHdmybnqrPxXNc+RAc9iRCI2HUDPr9w8XXmD9mB6LKiMXM
         dBa9u2T8rTmu6salY9Q9mXyvJVfpPe9z9awVJTFaeB2/kkwLlGrqSOzFXx4ZjLfe6vFa
         /63TX3CH/mh116W6D/cIc6BG4Ev5uGZZge4AtYDdjLvFVnTrD7AwotZGoewoegjHTsdy
         oTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703680889; x=1704285689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlZMvpx7rHlKyNjWFEIp/CNLoHdcQyGULZeal25qJkk=;
        b=BtaiTIsMkRqaV0M+8JShw6eQF7+65k9U6JYFJuOiDc3hvIU0r9ftTwE18xYfAbBlZc
         XOQ6LoCtzQH/1DtpFbBIQXg1vGOWYySQJV6aA/voJqrHQO9wn6q0/IPDeg0n85fDWq86
         zGcvwn9LugpjwXYqsEvXZ8/6L3bcLBunDGBJkSclf70ByddniDXJrjDfJN5QfnIQAyzE
         JMIO4xovxJXFsEOc1ymy+Xo7Y1VwF8osAhOVH+FaK/ArWtTVKScbaXDdEJkgrBs9tQXD
         TMeRl5FD3a1Asq8SWqILlJHEs6cS8RPvfL5kM8EQuEeHPEtJKCzyjRFcBGBAame9XAln
         +P7g==
X-Gm-Message-State: AOJu0YwKnEncg6WRh5n3sXIoCCV8Wuo9dCCRi3V9qQ2eG+nZhdwwkQMb
	3TDL5VlhsGzTjMm4R6mkOOvinGd3V6MQhg==
X-Google-Smtp-Source: AGHT+IEOs8HESTV4XU2ybUZiy4aXHfT/EUptAImqWrIEceRwfxq0mSdfgcqqNAtpPKMsV9UajirUIw==
X-Received: by 2002:a05:6512:3133:b0:50e:3818:6b7f with SMTP id p19-20020a056512313300b0050e38186b7fmr3626590lfd.91.1703680888857;
        Wed, 27 Dec 2023 04:41:28 -0800 (PST)
Received: from [192.168.100.86] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id n23-20020a05600c3b9700b0040d5aa03ee0sm5266340wms.34.2023.12.27.04.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 04:41:28 -0800 (PST)
Message-ID: <d50810e0-b8e7-4394-975f-d77d8dd24849@linaro.org>
Date: Wed, 27 Dec 2023 12:41:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] OPP: Fix _set_required_opps when opp is NULL
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, ulf.hansson@linaro.org,
 stephan.gerhold@kernkonzept.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231223023421.3818297-1-bryan.odonoghue@linaro.org>
 <20231226055936.pzyt4xjzlfhfqb4y@vireshk-i7>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231226055936.pzyt4xjzlfhfqb4y@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/12/2023 05:59, Viresh Kumar wrote:
> On 23-12-23, 02:34, Bryan O'Donoghue wrote:
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index c022d548067d7..182e07ab6baf3 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -1083,7 +1083,11 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
>>   
>>   	while (index != target) {
>>   		if (devs[index]) {
>> -			ret = dev_pm_opp_set_opp(devs[index], opp->required_opps[index]);
>> +			if (opp)
>> +				ret = dev_pm_opp_set_opp(devs[index], opp->required_opps[index]);
>> +			else
>> +				ret = dev_pm_domain_set_performance_state(devs[index], 0);
>> +
>>   			if (ret)
>>   				return ret;
>>   		}
> 
> Sorry about that, my mistake. Can you test below instead please ?
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index c022d548067d..c4d695e0e5fd 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1061,6 +1061,7 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
>                                struct dev_pm_opp *opp, bool up)
>   {
>          struct device **devs = opp_table->required_devs;
> +       struct dev_pm_opp *required_opp;
>          int index, target, delta, ret;
> 
>          if (!devs)
> @@ -1083,7 +1084,9 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
> 
>          while (index != target) {
>                  if (devs[index]) {
> -                       ret = dev_pm_opp_set_opp(devs[index], opp->required_opps[index]);
> +                       required_opp = opp ? opp->required_opps[index] : NULL;
> +
> +                       ret = dev_pm_opp_set_opp(devs[index], required_opp);
>                          if (ret)
>                                  return ret;
>                  }
> 

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

