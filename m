Return-Path: <linux-kernel+bounces-112788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1813A887E24
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46DD21C20D82
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7DE199BA;
	Sun, 24 Mar 2024 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YALZs97A"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C449F156C2;
	Sun, 24 Mar 2024 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711301152; cv=none; b=heSqkWe/78ybzNBEamgkrzYsNSsw1vYCCBDmCabWu2wZXU36VeREIwncWTjwObBUN8VB2ANhhFgxsGtr4LAk06CRS/4Is07Z0Bj6KjHGVGUewxqIcNXqBaedeQV9ahTQE5rCFXE9ZjyESk4R8RlrU3k5rAf7yH2JiH/zL1/YH2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711301152; c=relaxed/simple;
	bh=q+szx7jpSkgIelN9HKFrYdDXEUPrK1kQq9fG2zi8Oo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9zOCkwadnS5AsshCyR9gxkaWtBnL/CB5aEsPumXcKnfCnh8oIqq9mL5xSJF/2fhlZw45zzfzXLqbnVpXdI8IPUL69pKZTLOGNAVetGZ204Yn5X1qSiQKH0h5FRgHhwb1JeKQCv+2WjCqptO+txjhj+Ezvww27GzKO7tDIUQgdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YALZs97A; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a46b28a77dso2106636eaf.1;
        Sun, 24 Mar 2024 10:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711301150; x=1711905950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Cjhy1j6ng415mWwClf3r6vogHFOUJqIaXdUO0FgD+ps=;
        b=YALZs97A7BHOQNPpffNymdcerLWmqLOFZwVpmgwuhGc5kvBvo/mrdNkXYlAMLQwuhH
         yGH5o2PypqUUvPM+fmT9gIsFBKrdUZ+qKTDzlVYZnXAah8aIyXkZ+6PzUBcR/SomqEKU
         ibCUqcBYcTEvnlLgkZCKqEfVsit+YqycqsVvlDb3x7Qh2UEZSupT/dbxYXK3/Mqjg0pR
         d8Oj+9B0yE4r1fnBhxu9Jos7lINrO8JJMmgM0kP/K2i+tyvHW1w55MAjcu/nlybwMrIJ
         o/wGb0EKDqdKTATjcn44nfLe9SPEXdHVZz+M6rI/QtfFpcuGQxELTDXqfcEO62c1HtPV
         lAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711301150; x=1711905950;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cjhy1j6ng415mWwClf3r6vogHFOUJqIaXdUO0FgD+ps=;
        b=cXXFrV/vhXfDEgGr4e0DQbkAv7Jiga+58k7N43P7yyTofKBuBQBp9r5mEXljsXO4fY
         83yPn9mTxpfziuvEy2OFB0WRFQgGyrEGB8W9n+cEiqTzr4mqBcI3JV7QZD9NW69FnbbY
         2edx7sFPaTRmuzLeh3wnaE95hE87BJK+460gXjEhK/UslFlpG/4A+Ulw9TuOSwyLT9ST
         Mrfc9PxxKJ4eBabS6AwgQ1wIYhFKznbzWWMC18TqS9/lKCOvajLCtdHHVqvk+Jo4twn3
         PSdNSGtDsXj6fCMvwezEw+z3QZqJPYqxNaFwM/fp/WX58kAi2vr1fslOUiAonBbGOkgC
         r/oA==
X-Forwarded-Encrypted: i=1; AJvYcCWfR8jGInKDFDeK5TK4rKhn+1gxHgfHzBFumRTTSBwYMRV0WMfLa1TtySCQtOLBwiG19JNwMx6kuP3pUG7b8EcnhBGd9arqGuUyhKMX/OM=
X-Gm-Message-State: AOJu0YxT+r8KnnJGn9GktjxJe5wXnYfxLgwIDxs6g8N6bhyfXsXchc6s
	wISg/HM9XaCv7oi8U4rxn5KCfI1pAEtnD7OJmTEjk1iH453RgRJx+pliY+0C
X-Google-Smtp-Source: AGHT+IGQmBJhmQAMoI+lhC+lDM0jsJ5hBpO6hJaAQHvZKQjaP3fjU2rVr9rEtQ/I9C8dyeJBdmDZFA==
X-Received: by 2002:a05:6358:2813:b0:17e:b695:de64 with SMTP id k19-20020a056358281300b0017eb695de64mr6272557rwb.21.1711301149755;
        Sun, 24 Mar 2024 10:25:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gl3-20020a17090b120300b00298cc4c56cdsm8710632pjb.22.2024.03.24.10.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Mar 2024 10:25:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b46d249a-e22c-469e-b83e-7cf5eb3042c5@roeck-us.net>
Date: Sun, 24 Mar 2024 10:25:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: cpu5wdt.c: Fix use-after-free bug caused by
 cpu5wdt_trigger
Content-Language: en-US
To: Duoming Zhou <duoming@zju.edu.cn>, linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, wim@linux-watchdog.org
References: <20240324140444.119584-1-duoming@zju.edu.cn>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240324140444.119584-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/24 07:04, Duoming Zhou wrote:
> When the cpu5wdt module is removing, the origin code uses del_timer() to
> de-activate the timer. If the timer handler is running, del_timer() could
> not stop it and will return directly. If the port region is released by
> release_region() and then the timer handler cpu5wdt_trigger() calls outb()
> to write into the region that is released, the use-after-free bug will
> happen.
> 
> Change del_timer() to timer_shutdown_sync() in order that the timer handler
> could be finished before the port region is released.
> 
> Fixes: e09d9c3e9f85 ("watchdog: cpu5wdt.c: add missing del_timer call")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/cpu5wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/cpu5wdt.c b/drivers/watchdog/cpu5wdt.c
> index 688b112e712..9f279c0e13a 100644
> --- a/drivers/watchdog/cpu5wdt.c
> +++ b/drivers/watchdog/cpu5wdt.c
> @@ -252,7 +252,7 @@ static void cpu5wdt_exit(void)
>   	if (cpu5wdt_device.queue) {
>   		cpu5wdt_device.queue = 0;
>   		wait_for_completion(&cpu5wdt_device.stop);
> -		del_timer(&cpu5wdt_device.timer);
> +		timer_shutdown_sync(&cpu5wdt_device.timer);
>   	}
>   
>   	misc_deregister(&cpu5wdt_misc);


