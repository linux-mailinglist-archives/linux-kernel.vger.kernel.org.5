Return-Path: <linux-kernel+bounces-79882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B4D8627E3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 275D7B213BE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16254D135;
	Sat, 24 Feb 2024 21:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tFtg+BjK"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E1FE560
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708811724; cv=none; b=tGHJSnwkvmEyUAwCOqKnBil4xel5Ors1rtbeO/tD+bksFcFSSR7tFHNUl+F/ocPx1a45otZbcfl+rE+F2D/lavVoTcJjttzmWihzL4EMk2dPc+1w7FnDp/bEvZqPvOFV+RCvnsds07Ivcsqfu+MN5Penb0tuvmBSSBbAgA1pYTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708811724; c=relaxed/simple;
	bh=yi5OgA6zVy2kDdIuc9Og0dQeTSaA4Jd8kTBuLpKj0lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5ckBFuwrEWu+bZAHxfV40NNXwpGpHnrwsJ0EPqoYYi3v22LfI5DjAbMxMEdrDmNDAXgf2RvGbUXvXsr0CEUS4aR8R+5ZseB+txULfnLsG3J4kq/7sCDBo1OkkAJodq7n6fWwEURq1P6aloyd1o4yqAxz5PWjkiMtzqrCbAOnTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tFtg+BjK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4129e8bc6c8so4191505e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708811720; x=1709416520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bd2JtNYc/fS6VEPoOsOlftg5Z5gU6WPtxS+klhiNHEw=;
        b=tFtg+BjK8yHLSPBL8A1I/D85vh9F0MpWnG4JbOJ8niKo20e+3SzhADeJ2Q79oOnuwl
         qjSX4+DA/tEahss2ivx6/9C5Cn1pFp8eecMFaiT+Wr2mOtRkmY07eLVs6wSPYKpc6C6T
         4x6O3g9v4/Lg3Yi1nbp4ve5l1q7hO6a9RvfOH83wCCMOmB+wYAGPyep/KJZQz/pGpcgZ
         3SI5hNbHSlN5AKhdzyIfWCXvUNzKZzSkLgILz5UeIqVLcUGWahZ1zUjorkXMj7BncgjC
         /EnUlF4/Bh/0SVWrV6ZzH8D10zSUJZ2ZT/h4QS1KrV4VN1dhdXsgAqDKHLUIME5h7SRf
         0V2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708811720; x=1709416520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bd2JtNYc/fS6VEPoOsOlftg5Z5gU6WPtxS+klhiNHEw=;
        b=Pa779O4BoZZZTkbhKZ2ThevNvH2GR7bXRk/u0XcSHnSY6PWpNkAWg9Xg8scmkq1uCM
         r6QdyZirXpN2EjEG2JZLu3Ulg5ZI5bul1oXOoBCx0MpciP9WpS82HTcDD4dwiC3M7F/P
         9r2EbqTHYJQ+pWy6+gAhrxi6MiSQwPTgp1q8xMB//HO4e0AO8ew6ojDOWXpb2daNjkob
         KVrzL9V5qUFUmS0G9Wb0B+AQ8+xeR13EbZ5HMKb5DLHTojOlq6tErtd413mwrulRHFE3
         a8My0Fwy0cwywQvtFkxZlxx9WRHhF/45P19OjVfhYrvqrmATxilzFOCkqkNMKu97eyPv
         vjvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmIxUMOEqYboN2ZLgz6OamLqCKh6TQ7NU9RTb3b9TnHnMEUEHpsjwCQmQmmI1cHSZwhKiI+rqsC8m0POwUsxFh7qE2weG6NhEN5nQi
X-Gm-Message-State: AOJu0YylGc6yF+PKiQL2Jn6Ya5IdnDQR62p7jGA7YwFl/GRO4UGMxTEO
	eBTghPb4lpDmUlUUjFVU0CJ2wUyNorKYyCPJYsNnWn4f5Lc4ZzewGdXzOdQ9YrpqjNrsw8whuvG
	e
X-Google-Smtp-Source: AGHT+IEQesKvwvPyYrDHhaQrQinfGdYTRf53gquwRuzpj1wTyg+bHWWNSxJR6XF73jpVrIp14V6Osw==
X-Received: by 2002:adf:e485:0:b0:33d:4c06:8614 with SMTP id i5-20020adfe485000000b0033d4c068614mr2012742wrm.37.1708811720486;
        Sat, 24 Feb 2024 13:55:20 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bn9-20020a056000060900b0033da66e7bedsm3381205wrb.66.2024.02.24.13.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 13:55:20 -0800 (PST)
Message-ID: <eb54b791-05d7-4eee-825d-373cc78df689@linaro.org>
Date: Sat, 24 Feb 2024 22:55:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource/drivers/arm_global_timer: Simplify
 prescaler register access
Content-Language: en-US
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 tglx@linutronix.de
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 patrice.chotard@foss.st.com, linux-amlogic@lists.infradead.org
References: <20240224213529.2601333-1-martin.blumenstingl@googlemail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240224213529.2601333-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/02/2024 22:35, Martin Blumenstingl wrote:
> Use GENMASK() to define the prescaler mask and make the whole driver use
> the mask (together with helpers such as FIELD_{GET,PREP,FIT}) instead of
> needing an additional shift and max value constant.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> Changes from v1 at [0]:
> - use FIELD_FIT() to check whether psv overflows the register
> - update the description accordingly
> 
> 
> [0] https://lore.kernel.org/lkml/20240221214348.2299636-1-martin.blumenstingl@googlemail.com/
> 
> 
>   drivers/clocksource/arm_global_timer.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
> index 8dd1e46b7176..49b094a20717 100644
> --- a/drivers/clocksource/arm_global_timer.c
> +++ b/drivers/clocksource/arm_global_timer.c
> @@ -9,6 +9,7 @@
>   
>   #include <linux/init.h>
>   #include <linux/interrupt.h>
> +#include <linux/bitfield.h>
>   #include <linux/clocksource.h>
>   #include <linux/clockchips.h>
>   #include <linux/cpu.h>
> @@ -31,10 +32,7 @@
>   #define GT_CONTROL_COMP_ENABLE		BIT(1)	/* banked */
>   #define GT_CONTROL_IRQ_ENABLE		BIT(2)	/* banked */
>   #define GT_CONTROL_AUTO_INC		BIT(3)	/* banked */
> -#define GT_CONTROL_PRESCALER_SHIFT      8
> -#define GT_CONTROL_PRESCALER_MAX        0xFF
> -#define GT_CONTROL_PRESCALER_MASK       (GT_CONTROL_PRESCALER_MAX << \
> -					 GT_CONTROL_PRESCALER_SHIFT)
> +#define GT_CONTROL_PRESCALER_MASK	GENMASK(15, 8)
>   
>   #define GT_INT_STATUS	0x0c
>   #define GT_INT_STATUS_EVENT_FLAG	BIT(0)
> @@ -247,7 +245,7 @@ static void gt_write_presc(u32 psv)
>   
>   	reg = readl(gt_base + GT_CONTROL);
>   	reg &= ~GT_CONTROL_PRESCALER_MASK;
> -	reg |= psv << GT_CONTROL_PRESCALER_SHIFT;
> +	reg |= FIELD_PREP(GT_CONTROL_PRESCALER_MASK, psv);
>   	writel(reg, gt_base + GT_CONTROL);
>   }
>   
> @@ -256,8 +254,7 @@ static u32 gt_read_presc(void)
>   	u32 reg;
>   
>   	reg = readl(gt_base + GT_CONTROL);
> -	reg &= GT_CONTROL_PRESCALER_MASK;
> -	return reg >> GT_CONTROL_PRESCALER_SHIFT;
> +	return FIELD_GET(GT_CONTROL_PRESCALER_MASK, reg);
>   }
>   
>   static void __init gt_delay_timer_init(void)
> @@ -272,9 +269,9 @@ static int __init gt_clocksource_init(void)
>   	writel(0, gt_base + GT_COUNTER0);
>   	writel(0, gt_base + GT_COUNTER1);
>   	/* set prescaler and enable timer on all the cores */
> -	writel(((CONFIG_ARM_GT_INITIAL_PRESCALER_VAL - 1) <<
> -		GT_CONTROL_PRESCALER_SHIFT)
> -	       | GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
> +	writel(FIELD_PREP(GT_CONTROL_PRESCALER_MASK,
> +			  CONFIG_ARM_GT_INITIAL_PRESCALER_VAL - 1) |
> +	       GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
>   
>   #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
>   	sched_clock_register(gt_sched_clock_read, 64, gt_target_rate);
> @@ -301,7 +298,7 @@ static int gt_clk_rate_change_cb(struct notifier_block *nb,
>   		psv--;
>   
>   		/* prescaler within legal range? */
> -		if (psv < 0 || psv > GT_CONTROL_PRESCALER_MAX)
> +		if (psv < 0 || !FIELD_FIT(GT_CONTROL_PRESCALER_MASK, psv))
>   			return NOTIFY_BAD;

Won't FIELD_FIT cover psv < 0 also ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


