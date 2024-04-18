Return-Path: <linux-kernel+bounces-150181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1378A9B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C021F23A76
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625CB1607BD;
	Thu, 18 Apr 2024 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tBe7sZli"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEE4160790
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447485; cv=none; b=l9JVz1Tr5X6nQeQzLHl4RK1e4MTMollLdAguaGZim9YQrP0fMkZNG1poATQ0krcGT8jNMLTi2Omm0jCvfo8MiEgVqgC7yK6WehRhWgfiJzloILDeqNY8GMa67hOLa8ykdsIaDrKsVux0B2FgDXnYzxXzQ02iu5TN4NrsngaKSTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447485; c=relaxed/simple;
	bh=4hjplUlSINU/7vUpvdsZ49nq4pYPWpHaCsB+ygdVKuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNiakUG00fQm7KpMAqaT4SkM0Td8bPoEolq5GWrj+FzyLasDW929JkP79RK0pMYYkoqTEyIU8nK5oTYjK0kuQ5HTxHUt9rahH3IA2sMg29v3zQugMkQnI4yqeH6ZSSQgIewvgLy6JYVhjifcbUVsr8qV8s1zAzJ1KbqFGNEj/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tBe7sZli; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51967f75729so984781e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713447481; x=1714052281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o9+0LMiqya8BHuNPxYT08/6EM9gAsFbYCDS1Bf/hZvc=;
        b=tBe7sZliHYEdIs1t9pZC8kswaj756Q4fGZvzTqkq4qAVs2MB44r1W44YVFTPUjaWAR
         +fvksdSUtBUmHtcrse0hB6tRpl036vtN93dy4/Jvw0RUIllXgnEuhC6YrhKENlv9SBOo
         as+kVbjFKTtLrWCcff7onRh5FexH5f4vDz3N1doCg4Jhk5mdlyc4O+pAtW3ljRbk7UfE
         g+B+F9AWev+8frn6fNQmRTs2euEj0J4jjQoZ5fP5+sQ8a2zvZq1Qo5yiW5lcvqeR5ZHX
         aWiG+MHrJUf8nUgq3AFiOogqJDN81AgZjcAGQWI+O3NWMgMZTSqorYkErErHV0dkltKM
         SC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447481; x=1714052281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9+0LMiqya8BHuNPxYT08/6EM9gAsFbYCDS1Bf/hZvc=;
        b=Up2YhFoAAGG91TdC/p58WOL0mv4CD/TQOJNjNzduaGUKxl8t4WW1mPI7xWUqcyOn8u
         BBQGDnAgTFVaiN7m60SU08t+d9v2vjX1yk2Bp5u3CEpLDx03NS8Pl+5jxSINg7DbOiKz
         buqqpPl4HnlgH57nVJcZeOI+neKqzAPzWaztQOSBl+VqnDAArfzo2LDjYiIit/AICvwP
         Ju3LToM3ak5I2V1dFo0EtwDlo5K97dR7Is+TK/dNUirofIT0nnaWra5RKKG5vP4NggSH
         C1opglH1paYDZH9k7O2cAi/wIh5fo233F60N5dSJ/lwoWCWuBUb3OSk1ZSQXQZFWDJDd
         PhyA==
X-Gm-Message-State: AOJu0YxTkeU5ETW/2VYmOZR4DcDgcSABEIenbs8zusQ+S+bh22DHdc8v
	4rVP3LxLXRt9beGBDpYB6B4maRNLxTupg6sDBi0fJfU5yMfXcC5/7bnxM7NaM5c=
X-Google-Smtp-Source: AGHT+IGB38BuDP29A3iEAISCkTP6Ro2q8oS06IBiYeWlANMwwe5QEswXNqPg7+d9TKzxZOXxb2STLQ==
X-Received: by 2002:a19:6417:0:b0:517:dc07:612f with SMTP id y23-20020a196417000000b00517dc07612fmr1501445lfb.39.1713447481010;
        Thu, 18 Apr 2024 06:38:01 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.151.213])
        by smtp.gmail.com with ESMTPSA id 25-20020a170906311900b00a52331a9bdasm905137ejx.48.2024.04.18.06.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 06:38:00 -0700 (PDT)
Message-ID: <fbbabdc6-2505-45d2-a46a-c80c1eca6ee8@linaro.org>
Date: Thu, 18 Apr 2024 15:37:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MIPS: SGI-IP30: Use bitmap API when iterating over bitmap
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org
References: <20240417071830.47703-1-philmd@linaro.org>
 <ZiAGcb3eY/Nqamb9@yury-ThinkPad>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZiAGcb3eY/Nqamb9@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/4/24 19:27, Yury Norov wrote:
> On Wed, Apr 17, 2024 at 09:18:29AM +0200, Philippe Mathieu-Daudé wrote:
>> Do not open-code bitmap_set(). Besides, <linux/bitmap.h> API
>> allows architecture specific optimizations, so prefer it.
>>
>> Use the HEART_NUM_IRQS definition to express the end of the
>> HEART bitmap.
>>
>> Inspired-by: Yury Norov <yury.norov@gmail.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   arch/mips/sgi-ip30/ip30-irq.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/arch/mips/sgi-ip30/ip30-irq.c b/arch/mips/sgi-ip30/ip30-irq.c
>> index 423c32cb66ed..bdafff076191 100644
>> --- a/arch/mips/sgi-ip30/ip30-irq.c
>> +++ b/arch/mips/sgi-ip30/ip30-irq.c
>> @@ -264,7 +264,6 @@ void __init arch_init_irq(void)
>>   	struct irq_domain *domain;
>>   	struct fwnode_handle *fn;
>>   	unsigned long *mask;
>> -	int i;
>>   
>>   	mips_cpu_irq_init();
>>   
>> @@ -300,8 +299,7 @@ void __init arch_init_irq(void)
>>   	set_bit(HEART_L3_INT_TIMER, heart_irq_map);
>>   
>>   	/* Reserve the error interrupts (#51 to #63). */
>> -	for (i = HEART_L4_INT_XWID_ERR_9; i <= HEART_L4_INT_HEART_EXCP; i++)
>> -		set_bit(i, heart_irq_map);
>> +	bitmap_set(heart_irq_map, HEART_L4_INT_XWID_ERR_9, HEART_NUM_IRQS);
> 
> This function has a signature
>          bitmap_set(map, start, length)

Doh, I thought it was (map, from_inc, to_exc), my bad.

> So this should be a:
>          bitmap_set(heart_irq_map, HEART_L4_INT_XWID_ERR_9,
>                     HEART_NUM_IRQS - HEART_L4_INT_XWID_ERR_9 + 1)
> 
> Also on the above group of set_bit(). It should be 2 bitmap_set()
> calls to me. HEART_L0_INT [0, 2] is the first one, and HEART_L2_INT
> to HEART_L4_INT [46, 63] is the other. Isn't?

Please disregard this patch, sorry for the noise.

Regards,

Phil.

