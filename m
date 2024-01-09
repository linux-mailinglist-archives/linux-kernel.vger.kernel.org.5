Return-Path: <linux-kernel+bounces-21392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06DB828E85
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CACE61C21458
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EE93D981;
	Tue,  9 Jan 2024 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9zA+c9y"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2024220E7;
	Tue,  9 Jan 2024 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5578485fc0eso2499388a12.1;
        Tue, 09 Jan 2024 12:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704832286; x=1705437086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zy227x7o0Ll4yDIdnlPh8FgO9tgNZWkKoSg5mlIm//U=;
        b=c9zA+c9yUFhlyP3rfhUsKCj6awFLhbJS6P1PqrDICsqySR63snd6urX8ZzcIYojmy4
         Y9+wTq1o9BkJPpYqYmgxMPLzZOu7c4MzqygAr0dSQGdgmI0YCCB20eL3mg8nvx6yh7cY
         t79IsHp56XHmExVyNnEzVEsrIeeGGs1ny6afrRLhUXkJk3zNgIPtt0xoNGB2qHZgqHqn
         Ty74tBhZv2+cqPy6y0yW2xAEUUIpZYakb7wvpcpfIY0A6haWNJK0rltmf2mBWqcF43S2
         SyM1aE8nOo6X3hupaHjQpS209jdJIPh5NHTxsl7nwSTUw3d1bx8rO+uJDXL1IXmkMuKy
         UUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704832286; x=1705437086;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zy227x7o0Ll4yDIdnlPh8FgO9tgNZWkKoSg5mlIm//U=;
        b=gUfB0TL2h03lclKkQZu8wtvztp1lQnfXdfRtfSLNe5d7SZ8yvrMTM0tHwXb0HRhS04
         /bqxUGCr7gXDZoP+fEPyT0N3ztTGPFtEfLQVfWAqtKSPkHwj9KYOT1zwgT5oxoxqlMEy
         tZ5d0/QhOiUfrIkvFNCnPsdKA19gStka3/EE8MS+j/NqUYLnuMEYW+VXxnvoU8ZEnmNN
         IzZEKrjgXUBItVMHE4TdK9ClVNLLomBwGAboGfWmVB0RJdcAo65dznqk8KANio/Q+04Z
         JKf2jXZwS23VtWSLjPKsS+o2tvT0GnWNf49MYncMUjdG6qNT/wHXO/bePEZn3Kxx8V6P
         UE1w==
X-Gm-Message-State: AOJu0Yx6B4+kr8DKdtciVHd0xB1pp2DQIyfRwlrVKj8e6RIuYfAHD/BZ
	fX/rM42p+9v1QbvmJWtGb5U=
X-Google-Smtp-Source: AGHT+IEhKtpTXJ1m7RpKcdYH1ZpccgeGef5Z558w35b+uYVdVfzGVHOF2tqL7DSNVdVDWI05h4l5Nw==
X-Received: by 2002:a05:6402:1818:b0:558:2110:5ab0 with SMTP id g24-20020a056402181800b0055821105ab0mr700053edy.72.1704832286097;
        Tue, 09 Jan 2024 12:31:26 -0800 (PST)
Received: from ?IPV6:2a01:c22:6ec5:5b00:2949:ac5c:4096:8128? (dynamic-2a01-0c22-6ec5-5b00-2949-ac5c-4096-8128.c22.pool.telefonica.de. [2a01:c22:6ec5:5b00:2949:ac5c:4096:8128])
        by smtp.googlemail.com with ESMTPSA id er10-20020a056402448a00b005572a1159b9sm1269937edb.22.2024.01.09.12.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 12:31:25 -0800 (PST)
Message-ID: <d8ed4af1-5c83-4895-9fc3-9aea25724fd9@gmail.com>
Date: Tue, 9 Jan 2024 21:31:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tg3: add new module param to force device power down on
 reboot
Content-Language: en-US
To: Andrea Fois <andrea.fois@eventsense.it>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Michael Chan <mchan@broadcom.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, George Shuklin <george.shuklin@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240109194551.17666-1-andrea.fois@eventsense.it>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240109194551.17666-1-andrea.fois@eventsense.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09.01.2024 20:45, Andrea Fois wrote:
> The bug #1917471 was fixed in commit 2ca1c94ce0b6 ("tg3: Disable tg3
> device on system reboot to avoid triggering AER") but was reintroduced
> by commit 9fc3bc764334 ("tg3: power down device only on
> SYSTEM_POWER_OFF").
> 
> The problem described in #1917471 is still consistently replicable on
> reboots on Dell Servers (i.e. R750xs with BCM5720 LOM), causing NMIs
> (i.e. NMI received for unknown reason 38 on cpu 0) after 9fc3bc764334
> was committed.
> 
> The problem is detected also by the Lifecycle controller and logged as
> a PCI Bus Error for the device.
> 
> As the problems addressed by 2ca1c94ce0b6 and by 9fc3bc764334 requires
> opposite strategies, a new module param "force_pwr_down_on_reboot"
> <bool> is introduced to fix both scenarios:
> 
Adding module parameters is discouraged. What I see could try:

- limit 9fc3bc764334 to the specific machine type mentioned in the
  commit message (based DMI info)
- 2ca1c94ce0b6 performs two actions: power down tg3 and disable device
  Based on the commit description disabling the device might be sufficient.

> 	force_pwr_down_on_reboot = 0/N/n = disable, keep the current
> 									   behavior, don't force dev
> 									   power down on reboot
> 
> 	force_pwr_down_on_reboot = 1/Y/y = enable, revert to the
> 									   behavior of 2ca1c94ce0b6,
> 									   force dev power down on reboot
> 
> Fixes: 9fc3bc764334 ("tg3: power down device only on SYSTEM_POWER_OFF")
> Signed-off-by: Andrea Fois <andrea.fois@eventsense.it>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index f52830dfb26a..287786357c9b 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -233,6 +233,12 @@ static int tg3_debug = -1;	/* -1 == use TG3_DEF_MSG_ENABLE as value */
>  module_param(tg3_debug, int, 0);
>  MODULE_PARM_DESC(tg3_debug, "Tigon3 bitmapped debugging message enable value");
>  
> +static bool force_pwr_down_on_reboot;	/* false == Don't force the power down of
> +					 * the device during reboot, only on SYSTEM_POWER_OFF
> +					 */
> +module_param(force_pwr_down_on_reboot, bool, 0x644);
> +MODULE_PARM_DESC(force_pwr_down_on_reboot, "Tigon3 force power down of the device on reboot enable value");
> +
>  #define TG3_DRV_DATA_FLAG_10_100_ONLY	0x0001
>  #define TG3_DRV_DATA_FLAG_5705_10_100	0x0002
>  
> @@ -18197,7 +18203,7 @@ static void tg3_shutdown(struct pci_dev *pdev)
>  	if (netif_running(dev))
>  		dev_close(dev);
>  
> -	if (system_state == SYSTEM_POWER_OFF)
> +	if (system_state == SYSTEM_POWER_OFF || force_pwr_down_on_reboot)
>  		tg3_power_down(tp);
>  
>  	rtnl_unlock();


