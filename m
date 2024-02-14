Return-Path: <linux-kernel+bounces-65356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA33854BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4A7286B53
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13F15B1FC;
	Wed, 14 Feb 2024 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rHj5Y+B2"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D345B03A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921903; cv=none; b=MmV8sYCYwbk9OvO4xsIdjymN81Oi8YcsyF030Jfi79Rwgy6UOTpu2sL3QUkFANrwYsIdUCIeSuWiaoMTtzTGvaDsLMmsC7IYCzTlpnXjnJLmCK+eKGCZZw0jAntari5VVuTWf7vuKrbMvEbWXxgyo/3BZWQKLFz7qV5+WYhFO/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921903; c=relaxed/simple;
	bh=cpZQsQAjR85c+f4hcFxp9/sRJXc2W9hgbX3v81eEAI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKQDaCmAcp4jSRmSZnRSmCIAXKKIQkAvhwSOUQjPL5PI4eEO0VezIYGaO8TKZXeAobHS1XFANG1W88s3PqYTOI7bpErx/KFjnHFkV/LJXm1R8OoUk2n+YY8QLI/786JKA3z0CjPB+51PRFHmr/x5x9qrdbj78NoslTfV4IwYXqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rHj5Y+B2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-410e676c6bbso15981775e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 06:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707921899; x=1708526699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xr6R04jM3t8mG2U+5kNCVy+S/HHY/qN0Owp9FdbuDpc=;
        b=rHj5Y+B2lcf4GUlgIDv7z1zifHgK0Joi9eSXZxlUpwYMmq93JWA+uDo1JLp04v9IFb
         fVl5xAyV1Scl5tn2kAm1gUQWXWQhLLZTp8Z3xSZ8tVQPRPsvsSlQpHSzlTOBvw1mJBTn
         hWdXxrgULUijbEdo+LpUUFjFkPoshWFzDm1yb7wBQuYST2A6f5u85iSUYLNRSfl2/yOC
         F2f1AptgrdNpCsHmq5P4YACozzTxnrpDHLSRVu+FvJJdl61rRTBo39HpMvWxzC5CQlB9
         IEn12n94yhp1hggdAytK9VmM/7FOQF3ZiFW1QeRD4tp6ZHYvvO3gzMGhweDywtJAmuPm
         0e+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707921899; x=1708526699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xr6R04jM3t8mG2U+5kNCVy+S/HHY/qN0Owp9FdbuDpc=;
        b=nZkm9Dd+gJO1xNYGBnG5b0TBW8EMaGRiXqXq6hA3m8rgC+h6Cinrj5GEA4Y+rUmEZq
         XW/29fsQcRTsyA5Ii6BHbVrFmOUvihlZn4S3X0EsZ591EyoA9EdpAtTIu5ewICl+thfF
         AmdbsxWeRJIpT8D8B/1xFoQldMuopJObNte9yYXLKRmWHq4ce9r8t9GwIma+c/8SmrDf
         6ibPDoSa/8mKT32lW/l/1zLnH4N9fJTlxpWUTlSfK4kUQbJYpCkAQT77ndXe9oZquxrk
         9jA/3qx0/A4I1A+51DC0KsX9ovHhCD9LZ8UmxlM94oBYdEOFc3lBE3qi0BjXaJcTeYLJ
         cfJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5z9Adt6ukwolwn6Ka5LMeWkHB5+qzP3iMGEIaFm7LzRXyLOTLWMEv0AAkWNZ7lkoRIa4i07zk5Cy9KESaINeUhARz6cncs9YIPbZa
X-Gm-Message-State: AOJu0Yy4AZR6cVs680c+0evxOn9EJeWINQPupbXlmWHMpk/q1CcbzVJT
	ES9CvIrJ1ut8S9j9oEWDrDTHJYBfHoUXB+UjgrNqnxGtLm4IC/QYIOTeBnRPeVI=
X-Google-Smtp-Source: AGHT+IElMJMY7bS3dgxro3ijjinZT1sz2k9Pm5ejvDg/fAd7OjD5N4Ely+pHprq+pPYGZ+ndGxwn8A==
X-Received: by 2002:a05:600c:c12:b0:411:e5c1:e55a with SMTP id fm18-20020a05600c0c1200b00411e5c1e55amr1461543wmb.6.1707921899609;
        Wed, 14 Feb 2024 06:44:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWnOdQ2SY9hCQ06/sghxX3DftuhWnm1gBviAx6lVYGzJvQjjaRZRUnXNrbfLMnnW91ye+Pm7rf71m15JZ7ujtthiRD8unJGzDskGXXloVbwq6LVBeJ5uxz9qojHrfIjFWkrBa7e/fTGjNS6YJ72dO7qDus6Dt905jReUQR4znnlEmj1gQu0rc9D96cf11NlV48TSCe0fMXsLLltpGGzDQih5JDF3A3w0a3+mASDkqxEYCmFRmiN9jGN1AA0XftIl3yaOF5z0v0f4dKf0IukSvP5WKrWuqu7UyxJaw5BbSsV7bLtwcm7O6Rzyzq8Ig==
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id v16-20020a05600c215000b00411bff9f7cbsm2125171wml.37.2024.02.14.06.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 06:44:57 -0800 (PST)
Message-ID: <3851e21f-f8cb-487b-9ed4-9975949ff922@linaro.org>
Date: Wed, 14 Feb 2024 14:44:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: qcom-rpmh: Fix pm8010 pmic5_pldo502ln minimum
 voltage
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, lgirdwood@gmail.com,
 quic_fenglinw@quicinc.com, quic_collinsd@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240214121614.2723085-1-bryan.odonoghue@linaro.org>
 <13baed68-1014-4a48-874a-94027a6dd061@sirena.org.uk>
 <f38468b4-8b16-4180-9738-0a2b557651a1@linaro.org>
 <dcce3fa9-ecf3-42be-adf6-ca653a79ba2e@sirena.org.uk>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <dcce3fa9-ecf3-42be-adf6-ca653a79ba2e@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/02/2024 14:13, Mark Brown wrote:
> On Wed, Feb 14, 2024 at 02:07:13PM +0000, Bryan O'Donoghue wrote:
>> On 14/02/2024 13:25, Mark Brown wrote:
>>> On Wed, Feb 14, 2024 at 12:16:14PM +0000, Bryan O'Donoghue wrote:
> 
>>>>    	.voltage_ranges = (struct linear_range[]) {
>>>> -		REGULATOR_LINEAR_RANGE(1800000, 0,  2,  200000),
>>>> +		REGULATOR_LINEAR_RANGE(1808000, 0,  2,  200000),
> 
>>> This will also offset all other voltages that get set, is that expected
>>> and desired?
> 
>> Yep, looks typo in the original submission.
> 
>> ldo3, ldo4 and ldo6 should all be 1.808.
> 
> Not just that but also note that every voltage step in the range will
> have the 8mV offset added.

The documents I have just show sensors attached to ldo3, ldo4 and ldo6 
fixed at 1.808.

I don't think there's any better or different information than a 
+200000uV increment TBH.

---
bod

