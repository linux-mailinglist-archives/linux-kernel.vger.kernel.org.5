Return-Path: <linux-kernel+bounces-85540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D733D86B740
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C3B1F23861
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944A271EB1;
	Wed, 28 Feb 2024 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RK1Wjar1"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E2879B79;
	Wed, 28 Feb 2024 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145395; cv=none; b=MopgS+xqalh/ywyEwK6ldLeWuIifZx32kkvRukTV4lvEEQ1dNK0O0Soej2huLhjlEV/uYzOdh1mg4G9GsdaFy3JPwS4C5dV4PshwUOKnRZUrol9IIAo/NfFES5mpOgTIZaAbG2T/ElLPI+GafAXQzx+9YCgn3nD/xuGVUWoMQsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145395; c=relaxed/simple;
	bh=2Fxp9LD6R5+6ET9F/QGoLG6UJcEbLU/dVHJcQg5DpGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2BpuDLnbiVULKig5Uj/F09GxMdgOQtICuL4OjzeT1OUOeJvNMHD1Ft6cj0u7y5Ou29Wd2WV+MGHmyNF3LG25Qn1APJ48a9d4bjWkly2oxRoUVhu5B/gKx8eCSDFdQuLjW9mmWbKi/1IRwIATvYJE3ZKca97ZIGQc70aOu9xHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RK1Wjar1; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c7c9846910so161992139f.1;
        Wed, 28 Feb 2024 10:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709145393; x=1709750193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=i0qHuF8v5L5+UifsJbzCUW28nUptTePFPyiO2bCX6ks=;
        b=RK1Wjar1JeNUB2GmgP7RmiZmJOS5RzTmiKwSljp7BseMNHvfz8DWIk2+yb9tZL6dsv
         rZrTNsCJm3S71eqvJyrhu8sSGOc9Tne4OWjADiUIHE/H9Nq/ywFmAw9RArqmkkuHvZtB
         da6S90RuOVe9z718hXily+DirPCpnqkhFLzRLYKk527vF+uneF8clbiohLENuaU3PowV
         DiUF7ZjUES0rza2Jr0gIL8IjYAmaHtR5+TAUojudCt7WV108eeNHxDsm03OelusmFSF4
         113PwwlO89jjuNW4lna5e8ETezMZ0qtU8xghxHNooa8myFoiOTh0+BvLHCh//ToO1Dxl
         OhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709145393; x=1709750193;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0qHuF8v5L5+UifsJbzCUW28nUptTePFPyiO2bCX6ks=;
        b=eVjZznvcLLvUpS9JDpHTdfwxsYrPPuatLump28Op//j0JmCOn/WuxZcnWIV8SVkAAC
         2EYVc/kOKp6om2c72exJ8xLIQtQKgSQrJJRXgtEq7TfQLGZtXEJ0nD6Jh2XUlG/8N90m
         gXJNEHEjXPePwL31qDCm/u9d3yAuAglIjHQAdndS8v80gQ4Fm1quYRisJMXbcYIlHG9F
         kTWz31oEpSzxLJIAqYAhk/3LQmouKBbvwMI2JRPve5bMMmpVVoNyh6GXuslx6fMwvJBp
         RCmTDPj9PSJDa1OGcJ8Ec10z8lJUl4W/KCEccD/h0i9E/eg5ei6eqG2zvFI71TzxVnrx
         7e9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0pDft3yS/ExEEdQJB9PnH5PicT0UivLjsB4ufI8w7ORJX5J79OLzDg4bELB5KajTP4/BAdruBinwpitbO4buF2Hz/EgjUdUhodtdbtiLQKqUHL050Doi47SsQF1+C3ytEyPaWiPtlrEIVNRk=
X-Gm-Message-State: AOJu0Yyx7S0VwWowLvXlq2p0JnK0xeWfQWsP1sXWOhQiSBdU30NJ84EY
	pErR9QqqWj1FSOX7fSHugJ6g635yEWwsnZDqojerUq1p8kKEsH+2
X-Google-Smtp-Source: AGHT+IFDZMMcmuBvVmAObjRdoqBHh0wc0R00rw745aI8/xyv00qLKbeH6c2EI5Ey7tACKdY1PTDGiw==
X-Received: by 2002:a5e:a911:0:b0:7c7:9185:e58e with SMTP id c17-20020a5ea911000000b007c79185e58emr317643iod.12.1709145393249;
        Wed, 28 Feb 2024 10:36:33 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p1-20020a056602304100b007c782f6d55csm19518ioy.24.2024.02.28.10.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 10:36:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f147ed12-8b7f-43c8-9b55-3000b6e4fd27@roeck-us.net>
Date: Wed, 28 Feb 2024 10:36:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: stm32_iwdg: initialize default timeout
Content-Language: en-US
To: Ben Wolsieffer <ben.wolsieffer@hefring.com>,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Christophe Roullier <christophe.roullier@st.com>
References: <20240228182723.12855-1-ben.wolsieffer@hefring.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240228182723.12855-1-ben.wolsieffer@hefring.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/24 10:27, Ben Wolsieffer wrote:
> The driver never sets a default timeout value, therefore it is
> initialized to zero. When CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is
> enabled, the watchdog is started during probe. The kernel is supposed to
> automatically ping the watchdog from this point until userspace takes
> over, but this does not happen if the configured timeout is zero. A zero
> timeout causes watchdog_need_worker() to return false, so the heartbeat
> worker does not run and the system therefore resets soon after the
> driver is probed.
> 
> This patch fixes this by setting an arbitrary non-zero default timeout.
> The default could be read from the hardware instead, but I didn't see
> any reason to add this complexity.
> 
> This has been tested on an STM32F746.
> 
> Fixes: 85fdc63fe256 ("drivers: watchdog: stm32_iwdg: set WDOG_HW_RUNNING at probe")
> Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/stm32_iwdg.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> index d9fd50df9802..5404e0387620 100644
> --- a/drivers/watchdog/stm32_iwdg.c
> +++ b/drivers/watchdog/stm32_iwdg.c
> @@ -20,6 +20,8 @@
>   #include <linux/platform_device.h>
>   #include <linux/watchdog.h>
>   
> +#define DEFAULT_TIMEOUT 10
> +
>   /* IWDG registers */
>   #define IWDG_KR		0x00 /* Key register */
>   #define IWDG_PR		0x04 /* Prescaler Register */
> @@ -248,6 +250,7 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
>   	wdd->parent = dev;
>   	wdd->info = &stm32_iwdg_info;
>   	wdd->ops = &stm32_iwdg_ops;
> +	wdd->timeout = DEFAULT_TIMEOUT;
>   	wdd->min_timeout = DIV_ROUND_UP((RLR_MIN + 1) * PR_MIN, wdt->rate);
>   	wdd->max_hw_heartbeat_ms = ((RLR_MAX + 1) * wdt->data->max_prescaler *
>   				    1000) / wdt->rate;


