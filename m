Return-Path: <linux-kernel+bounces-24120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1DC82B78D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DF01C2403C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04A258ADB;
	Thu, 11 Jan 2024 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myB8Ww7X"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D3439FC5;
	Thu, 11 Jan 2024 22:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5f75aee31d2so54446097b3.2;
        Thu, 11 Jan 2024 14:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705013983; x=1705618783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bIOmVqHlKk6FT+5R0o20DWisC/wwVOe2JkxvIw91R6A=;
        b=myB8Ww7XAb3vH41+w4k7aSnch2fv5P7O2O6gjCif8TtqpUxIgaIXYa6l1ccfcf2+Ei
         PcmE3N7NsCTjKiEB8Exkt/nRUpZLh8vVOuuGtnQ9f72/NqO7twhgfW/RzVLR8G3G8X3D
         MHt0unWh1RF6Jv8nJeRA8yK/8rib1CEOLGkQOFn0AVJaGfyfVDgSlZReucQzZKFjmuW+
         qPq9x+/ykBjYtXRxGPMWsW6VX6d8vdtu0ffSjVq1mvqjkX5oi2Z5fBLYaKewDzglAxkD
         TfN9nCjIudDigXj5FEBJ1VAd21lP9IscPFUpczrF3QQ3k9dNUqOqjSOtIFUnmfcDi+jt
         NCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705013983; x=1705618783;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIOmVqHlKk6FT+5R0o20DWisC/wwVOe2JkxvIw91R6A=;
        b=xT+iGPnilH86R3ss9adRrdZ9LUdY9iLsehbVln3FUMzOBi504j2TcRujFeOcS2Tx8b
         OEIgvZCI4EiOyq5OhKIEMHtBhlEOCxy6Az5dJY/RpueSpa0boPo+KjSuh3ACsu1wO0uX
         WF9lTwAuAZvVyq2ZoVhzzP6VdicyPHfQ9U6H9tPClkDJbI6k3LErRSWuKtqzIDQZsN0i
         28izeqj4fjUgKkVOmkg/HkbXB0mDfnhO6lncDb8/CuGgnXiyHy2k/0thS6rljs+GoqKj
         PyilfNmMEaAiSIVdv28r4yS4RzH++e/DQYC0folziGAierlAY9yBdjo0Gkm+wduF+hI7
         Zc9A==
X-Gm-Message-State: AOJu0Yx6zEqnzvWW1Lb8FYjT5ikcmCv4bfn2hCI0YRm4s5nrArQwwPZr
	w2k2CmQqGtugeTvgWAS0BX16ZImARNw=
X-Google-Smtp-Source: AGHT+IHmWgO5Vs6e+gOafxBVyCDa4qFzGsJuo/o/zxI2+9GCMM+UAg+m2YYGTfwv3R9ovXNLUdK8KQ==
X-Received: by 2002:a81:4fd1:0:b0:5e8:45c5:a6bf with SMTP id d200-20020a814fd1000000b005e845c5a6bfmr522822ywb.32.1705013982983;
        Thu, 11 Jan 2024 14:59:42 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w7-20020a814907000000b005e8fc1e90e8sm801318ywa.111.2024.01.11.14.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 14:59:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ba33d050-223a-459d-adee-534bcd8873c3@roeck-us.net>
Date: Thu, 11 Jan 2024 14:59:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: core: Remove usage of the deprecated
 ida_simple_xx() API
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-watchdog@vger.kernel.org
References: <bc5b82db59ccac69f2612ba104e2f5100401a862.1705009009.git.christophe.jaillet@wanadoo.fr>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <bc5b82db59ccac69f2612ba104e2f5100401a862.1705009009.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/11/24 13:38, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_range()/ida_alloc_max() is inclusive. So a -1 has been added when
> needed.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


> ---
>   drivers/watchdog/watchdog_core.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index 5b55ccae06d4..aff2c3912ead 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -260,12 +260,12 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
>   	if (wdd->parent) {
>   		ret = of_alias_get_id(wdd->parent->of_node, "watchdog");
>   		if (ret >= 0)
> -			id = ida_simple_get(&watchdog_ida, ret,
> -					    ret + 1, GFP_KERNEL);
> +			id = ida_alloc_range(&watchdog_ida, ret, ret,
> +					     GFP_KERNEL);
>   	}
>   
>   	if (id < 0)
> -		id = ida_simple_get(&watchdog_ida, 0, MAX_DOGS, GFP_KERNEL);
> +		id = ida_alloc_max(&watchdog_ida, MAX_DOGS - 1, GFP_KERNEL);
>   
>   	if (id < 0)
>   		return id;
> @@ -273,19 +273,20 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
>   
>   	ret = watchdog_dev_register(wdd);
>   	if (ret) {
> -		ida_simple_remove(&watchdog_ida, id);
> +		ida_free(&watchdog_ida, id);
>   		if (!(id == 0 && ret == -EBUSY))
>   			return ret;
>   
>   		/* Retry in case a legacy watchdog module exists */
> -		id = ida_simple_get(&watchdog_ida, 1, MAX_DOGS, GFP_KERNEL);
> +		id = ida_alloc_range(&watchdog_ida, 1, MAX_DOGS - 1,
> +				     GFP_KERNEL);
>   		if (id < 0)
>   			return id;
>   		wdd->id = id;
>   
>   		ret = watchdog_dev_register(wdd);
>   		if (ret) {
> -			ida_simple_remove(&watchdog_ida, id);
> +			ida_free(&watchdog_ida, id);
>   			return ret;
>   		}
>   	}
> @@ -309,7 +310,7 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
>   				pr_err("watchdog%d: Cannot register reboot notifier (%d)\n",
>   					wdd->id, ret);
>   				watchdog_dev_unregister(wdd);
> -				ida_simple_remove(&watchdog_ida, id);
> +				ida_free(&watchdog_ida, id);
>   				return ret;
>   			}
>   		}
> @@ -382,7 +383,7 @@ static void __watchdog_unregister_device(struct watchdog_device *wdd)
>   		unregister_reboot_notifier(&wdd->reboot_nb);
>   
>   	watchdog_dev_unregister(wdd);
> -	ida_simple_remove(&watchdog_ida, wdd->id);
> +	ida_free(&watchdog_ida, wdd->id);
>   }
>   
>   /**


