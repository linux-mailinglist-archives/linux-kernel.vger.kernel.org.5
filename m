Return-Path: <linux-kernel+bounces-70625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4B0859A36
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 00:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C9D3B20CEC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669B973199;
	Sun, 18 Feb 2024 23:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TSvrrvi6"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4591EA80
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 23:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708300122; cv=none; b=AfA+I6FPES7DKKpMQbxUkA9jr+I4haZ+U8ojVuUl3m/1r3u/zZp6M/j60iXeH6pPONdXizCERf4Kd90IEYWL7VKGhEyD7jogorrbk0AAqHT9vcAwYxwA6p3DPVhUH4LqKGEQ9wSKxRtC4XnTL2IcuzgArby7XhpcDPk2Ck9t3jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708300122; c=relaxed/simple;
	bh=91KRah/PoGNYtgM5YwsRijswQsDKqxRoDaI1dQOtKvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sg08ycl6R926pd62OVBKOR5suadO31yQvJ58BdU+TdD3Q1498zhFymt+rLuN/p2Fe3zzWqOzeSxMIPDlr4WQ5O61UoS1CFanSJgFjVF2SrCSkK70LPgfnpdk7F6WkSZeMVwzjetkBE1AiAtoxcQfZ/yDJIML8sYlMNRE/Wdp3J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TSvrrvi6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4126104e28eso6548985e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 15:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708300119; x=1708904919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=buA/UKLNcQ5kdyPMEKml7ordtlaWTbAGzP/8x7nK568=;
        b=TSvrrvi6gWA2/K8T84UHJtHu90E1pXt9AbTtCqrgqXScNBiUGZin5IFAmqotIvSxGb
         19rOf027a7N7OdO8FgUM52c0uMwLuypLEZlZ8YSnHF3/iGeDqI7doJf1QD8S0R6XVNta
         mBAcS8+zXiAw+P1xpShZRuW7v9HYs9aa5p0JiXejCOTYPlcLNHubDUj7q6aFND1rUcYd
         v0DN6PKbzyp/p3zYj/1teixrrzwGreVcrmjo6eUCxuMR0IZEXn9Nzd30V4hvUOtQZVvX
         7zdRJGUWJ0AahFG8epVmbNez/BNH4wiFsCvTNIIldM6XvkXTqXgsYCccQDvfoBTXj2jP
         kxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708300119; x=1708904919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=buA/UKLNcQ5kdyPMEKml7ordtlaWTbAGzP/8x7nK568=;
        b=HXNojsGpli/anTrm9wQexXnbJwTlxclLy6PLJsbcXSTHBhPQDmiaU0MBmgm3NKCt+w
         NFEYhk3ycSC2PGGx7eUtnTgihcxyi2bDOaIxNXEDCrj0aeiyHxmeRwc52+Loh3tow8o8
         sfBLYSIM+OSK+4Uyvwx3/1qV+Bpl4HfqzSCanLoVKi28k20+cwUGunzLAr4od7xCPXsb
         J5eb7pbFm6G6aSf9/wiRTyst4BgzK3/ugCUdz21kXnaU7tamHjGlqmOPir3MbPyW0e+u
         i1veYVV1ASU2FoKpAuti/ForuUkSxVj0dzFKgxFaoLj/kAzHI5iAzqmqRzIQ3hgWMn6c
         11oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEtH9iiMliSN8sLKfNr1ElpewVFbq+bKUvLWtZ7RIuYTWuqTAG0OsOCex7/8jsNG1LgzD717GGiveHdVTW8gDrb8C6zyrqrT/XtidE
X-Gm-Message-State: AOJu0YxRpzUwj58E2NTVw7NCcsXCMVjEKY4ODj130+g8fntEfVKnB+I/
	Ul+3rxIU5V0sWXQbkEpKElpklUoh3HXesNOFk43xl/AOOv5SYmL4hVZKYfvyZSc=
X-Google-Smtp-Source: AGHT+IEMnbMNjC4B0Pso0FCy4uKJFZWuQJrqcCZS1B/SG+nzfSMdDR0Xv3aZlRG+CEHH5v3gSGfFjA==
X-Received: by 2002:a05:600c:4fc9:b0:412:5652:2875 with SMTP id o9-20020a05600c4fc900b0041256522875mr4798821wmq.17.1708300118765;
        Sun, 18 Feb 2024 15:48:38 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id l5-20020a05600c4f0500b0041253692606sm7871460wmq.17.2024.02.18.15.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 15:48:38 -0800 (PST)
Message-ID: <5f6229ac-1390-41b5-af91-53799641d3b2@linaro.org>
Date: Mon, 19 Feb 2024 00:48:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] clocksource/drivers/arm_global_timer: Fix maximum
 prescaler value
Content-Language: en-US
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, andrea.merello@gmail.com,
 patrice.chotard@foss.st.com, linux-amlogic@lists.infradead.org
References: <20240218174138.1942418-1-martin.blumenstingl@googlemail.com>
 <20240218174138.1942418-2-martin.blumenstingl@googlemail.com>
 <ec0b3dfb-3ce2-43f2-9cd4-042c3aca4cf7@linaro.org>
 <CAFBinCC0BbahEMeW9CYC+hKk0CBQ9a+CqNrOv3c92D8hDtQHdQ@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAFBinCC0BbahEMeW9CYC+hKk0CBQ9a+CqNrOv3c92D8hDtQHdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/02/2024 00:18, Martin Blumenstingl wrote:
> Hi Daniel,
> 
> On Sun, Feb 18, 2024 at 11:59 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> [...]
>>>    #define GT_CONTROL_PRESCALER_SHIFT      8
>>> -#define GT_CONTROL_PRESCALER_MAX        0xF
>>> +#define GT_CONTROL_PRESCALER_MAX        0xFF
>>>    #define GT_CONTROL_PRESCALER_MASK       (GT_CONTROL_PRESCALER_MAX << \
>>>                                         GT_CONTROL_PRESCALER_SHIFT
>>
>> Good catch!
>>
>> IMO the initial confusion is coming from the shift and the mask size.
>>
>> But should GT_CONTROL_PRESCALER_MAX be 256 ? so (0xFF + 1)
> It depends on what we consider "max" to be:
> - the register value
> - the actual number that's used in the calculation formula
> 
> If we ignore the usage of GT_CONTROL_PRESCALER_MAX within
> GT_CONTROL_PRESCALER_MASK then there's only one occurrence left, which
> decrements the calculated value right before comparing it against
> GT_CONTROL_PRESCALER_MAX.
> This means: the remaining driver currently considers
> GT_CONTROL_PRESCALER_MAX to be the maximum value that can be written
> to the register, having converted the value from the calculation
> formula to register value beforehand.
> 
>> The following may be less confusing:
>>
>> #define GT_CONTROL_PRESCALER_SHIFT      8
>> #define GT_CONTROL_PRESCALER_MASK       GENMASK(15,8)
>> #define GT_CONTROL_PRESCALER_MAX        (GT_CONTROL_PRESCALER_MASK >> \
>>                                           GT_CONTROL_PRESCALER_SHIFT) + 1
> If you're interested then I'll work on a follow-up patch to clean up
> the prescaler macros (using FIELD_PREP, FIELD_GET and GENMASK would
> simplify things IMO).

Yes, cleanups are welcome

> I think that this patch is still good as-is since it's small and can
> be backported easily (if someone wants to do that).

Ok, I'm fine with that


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


