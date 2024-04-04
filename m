Return-Path: <linux-kernel+bounces-131083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B3D8982DC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37DDA289797
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B92166B5E;
	Thu,  4 Apr 2024 08:11:20 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9A75CDE4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218279; cv=none; b=K/C+wtd+48EZX1LZEb6q/pX8zj+1XLYKgBqt19mUKKA0XyregQDh4KipC8gc7JBZxNNVAnTYKgIVq1kSviWThbENVaAujB0/MVXz5cEU3PGgeVB5GXEcnPWOgOEHE/RLTZGmFCjdNvhPCHuCXB5F79pnkaq/kS3GD2XpOtKLvMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218279; c=relaxed/simple;
	bh=2zcR1ZLOP5P3n/jCwQlW8AS0/zhbXpQTbGoIC+wh9R0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9iUn5KzNgo0r+bTQCPu1CNT9OMNpdeoWw3aLic8xycf9z0VZvksscyoUjCdvV9yDBpDVinb0WAzXwpDeaSFoN8uxov9SOsTYilfoOSFKPMa4gOzrL8rHjS8M9SzHGxSxk8Xs50uC+DbYaZRKZqkyWUqW2MceUzhDsMR310xQ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d6fc3adaacso9091511fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 01:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712218276; x=1712823076;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gY1+8Ba0IUhV47SSlluAbb3kKLO9jgkMvgMyme1VXC8=;
        b=c+FmpLSs+DXCWb4cPS1OkTmcIfN/pVj20XMoaflCyU7Si1DxJEyfmpJzv12a2wCjGc
         WGVoAtSOJjb6kKnxJgi84CVS5nJrQ3uWXFg6DTU3QZMgFHIRRM9uWo5EbyGCWocBSVPv
         Rbh6prkxFJLQNjEr86Oy8EEMKSnoqmYjEj+JG+89MNoQteCbJzgstplSYMRv6L/d3R29
         ytP7o/JFuH6zxjrJX1tE4V6Cy82ysKlC12CSLsCj91o9KRALBHPFaCf6dDm3JYsUCUYP
         AtO9nycBQGVFV9V6M8kCztwdfsqL/56UtkRIVzYbJYOIMDyTpTgqP/CaRdWEeIkh4tk9
         297Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzbMpO9jh3pJVRBFqdnKLqO2TmcReqLX1gz4ez7FRefU02ap0XySNA3WEy37A8Y6HtGSMRFoMPyj4GdWqg7WEpuKV8SyGVPmCvq5NE
X-Gm-Message-State: AOJu0YxO05MKWAY2nypS8mA112uB66LE/wTW2u2PKVhr8Whvql/Fqnwo
	uHkMI2fcX1b12d1JsdC1NzxxWrweAcVdNMLYRLEgnNumtl8PfD/OuQ5PJ5oO7Hs=
X-Google-Smtp-Source: AGHT+IGgD6cYA1AXQR+xpHZBOVNfMRzZXJYkL8kcE5e+w6n51OJBT7OZQ+0NgTPFh5sKQgHWjqLP/w==
X-Received: by 2002:ac2:48a7:0:b0:513:d3cb:249f with SMTP id u7-20020ac248a7000000b00513d3cb249fmr1244545lfg.52.1712218275986;
        Thu, 04 Apr 2024 01:11:15 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id e18-20020adfa452000000b00343c9ce4b50sm356307wra.53.2024.04.04.01.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 01:11:15 -0700 (PDT)
Message-ID: <593747f1-4256-4931-9d5c-50f1b68d3c2b@kernel.org>
Date: Thu, 4 Apr 2024 10:11:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tty: xtensa/iss: Use min() to fix Coccinelle warning
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: chris@zankel.net, gregkh@linuxfoundation.org, jcmvbkbc@gmail.com,
 linux-kernel@vger.kernel.org
References: <528c6824-287e-4be2-82f3-7fcdd254eb15@kernel.org>
 <20240404075811.6936-3-thorsten.blum@toblux.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240404075811.6936-3-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04. 04. 24, 9:58, Thorsten Blum wrote:
> Inline strlen() and use min() to fix the following Coccinelle/coccicheck
> warning reported by minmax.cocci:
> 
> 	WARNING opportunity for min()
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

Thanks.

> ---
> Changes in v2:
> - Use min() instead of umin() as suggested by Jiri Slaby
> 
> Changes in v3:
> - Inline strlen() as suggested by Jiri Slaby
> ---
>   arch/xtensa/platforms/iss/console.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
> index 8896e691c051..abec44b687df 100644
> --- a/arch/xtensa/platforms/iss/console.c
> +++ b/arch/xtensa/platforms/iss/console.c
> @@ -166,10 +166,8 @@ late_initcall(rs_init);
>   
>   static void iss_console_write(struct console *co, const char *s, unsigned count)
>   {
> -	if (s && *s != 0) {
> -		int len = strlen(s);
> -		simc_write(1, s, count < len ? count : len);
> -	}
> +	if (s && *s != 0)
> +		simc_write(1, s, min(count, strlen(s)));
>   }
>   
>   static struct tty_driver* iss_console_device(struct console *c, int *index)

-- 
js
suse labs


