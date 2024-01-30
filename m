Return-Path: <linux-kernel+bounces-43969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 541A7841BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043F2284AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D908381D1;
	Tue, 30 Jan 2024 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtEOIGfX"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA065381B0;
	Tue, 30 Jan 2024 06:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594841; cv=none; b=g7lLzz4sp2/VMxw2HyYiU0YuB87qYl1RWO8tv59lox1W7RfsR9+CdzKKDyrU7yW7ehUL4ezhIl6k/Zt9MG4GMDNqC0r1ajvUgV+7ReFVmgpeoXA0WJYsTO2USu0yjX3LjD/x9HyksSztJiMqgBlpyN1NK8LRcw+V+HfHEEK4hCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594841; c=relaxed/simple;
	bh=EC8EZ78YHBSGzH3r8Amq5D8JXo7GjzDPE4jwcU3lXr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cmy+2daFLE+0swko911sm54nCdp7t/jn4Go5G1Qs/pwe2bQa/Uge/7OQvFjFwzL8CKKTRwxlFz6R+SbI82DaVQ4UiJgkMCwICQUdDw3fP8/TlvOeWZz0Fa1Et0NlkAjlK5UcNxjWAwYT0t8YaM/uOd+I/TqMAOm8rLKdHGMjfaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtEOIGfX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d751bc0c15so30948135ad.2;
        Mon, 29 Jan 2024 22:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706594839; x=1707199639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gxgNDYCea6QO5exMfLo4bcw4R5KeT5JyaOsUNJoRBLo=;
        b=LtEOIGfXgda6eq9Y0uM3yYjYBudscA4bE3bPJCD1RfMAWHy8u0OH7wTr/HLH2XM1dU
         tGY2I2uXaADXhF+boyT9+M2YsSBaj84uUfmChau3ijx/Re3xiJs+wZi2cWlYmyvCWron
         +f6O7W3gHxYTqgIu/izIndfa1rKYiMk+4ZDFygL+TOHFd918WC+i64G1xxiAJyBGFnfQ
         eX1ad/sQ6JDkDBEdQe6ovoASZTEGywyP37JCE/89+20oExi+2lhjHsWPDxTlYhG5IazX
         3/BimubH+onPsZFJC1xPI9OqhQJOBOAgWeia01B0mb8384E9YmGiOtASr4V87mYfu8TY
         Dn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706594839; x=1707199639;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxgNDYCea6QO5exMfLo4bcw4R5KeT5JyaOsUNJoRBLo=;
        b=i4x5GQv0L6d7OckEarM6iSWTC8fZgY4bvhRaWjY9X2m5EhJnkwN5kbB90kuHLMqSV9
         Q+hIZATQsLCqR5/8Q52l21DPED4P8wkQrE2NpC8WZ5ud493oUdlLa4K9ft2swPFnz7As
         7agRLYmITx1fQ7dkWs82+Ad7ILRvvxh1asdHDlFYWMd6XP9JoeZ2AeA2tRqAGoTttFQ+
         zoWf42QlwbV10CgIrthZv/N2Q4g7lYezEHW6mp2Z+sQHlaKSdd6xaWEQAldBCpb6rQ5D
         wpEeBT/y4X6AEFnfIT5WZvmHNSHvw8/xg+jr5mVDt0ktuAkneiLXOgvRI3U5EqUzyaJt
         Rtig==
X-Gm-Message-State: AOJu0YwSE0uE+9PeNIf5evBf8OGXgFgprXQV5UQQmMuCho86XR3TES/5
	jO7/6X5ev7JjfI7qRWoXL4Ssyv8ieMkWGHWVTHyIt8PcXwdOmpARijP6k6It
X-Google-Smtp-Source: AGHT+IE3MdHxzCA0O4fr4KF3wU0Cbo/GXjek97o4Gv6R24rsxqgTCOVCLGHwliP5I7xEMenlMEG6NQ==
X-Received: by 2002:a17:902:c943:b0:1d8:e06a:3d16 with SMTP id i3-20020a170902c94300b001d8e06a3d16mr5068402pla.38.1706594838902;
        Mon, 29 Jan 2024 22:07:18 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b001d8ed27c78fsm2312222plj.87.2024.01.29.22.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 22:07:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d967e5f3-6431-4fa0-8df8-345b8bbe9073@roeck-us.net>
Date: Mon, 29 Jan 2024 22:07:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: starfive: check watchdog status before enabling
 in system resume
Content-Language: en-US
To: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
 Xingyu Wu <xingyu.wu@starfivetech.com>,
 Samin Guo <samin.guo@starfivetech.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
References: <20240130055118.1917086-1-jisheng.teoh@starfivetech.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240130055118.1917086-1-jisheng.teoh@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/24 21:51, Ji Sheng Teoh wrote:
> System resume will start and enable watchdog regardless of whether the
> watchdog is enabled/disabled during a system suspend.
> Add a check to the watchdog status and only start and enable the
> watchdog if the watchdog status is running/active.
> 
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/starfive-wdt.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
> index e28ead24c520..f72fc38a41f8 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c
> @@ -554,7 +554,10 @@ static int starfive_wdt_resume(struct device *dev)
>   	starfive_wdt_set_reload_count(wdt, wdt->reload);
>   	starfive_wdt_lock(wdt);
>   
> -	return starfive_wdt_start(wdt);
> +	if (watchdog_active(&wdt->wdd))
> +		return starfive_wdt_start(wdt);
> +
> +	return 0;
>   }
>   
>   static int starfive_wdt_runtime_suspend(struct device *dev)


