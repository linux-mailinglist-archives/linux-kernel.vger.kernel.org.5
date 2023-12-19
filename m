Return-Path: <linux-kernel+bounces-5871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FABE8190C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B1DEB24D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C39039850;
	Tue, 19 Dec 2023 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUlFPhz6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEAF38F8B;
	Tue, 19 Dec 2023 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40c60dfa5bfso58503255e9.0;
        Tue, 19 Dec 2023 11:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703014345; x=1703619145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IF8GvvowDjNbUwrAOPiYPKi0zKWqFwVvQy27RkH1Gsk=;
        b=EUlFPhz6a1dx/qOW6Dt+QoNIEToLKIwgbPwPu1N/A4FQqjCRC414mAJW/k5dgYzM0O
         RmzDTnjVJsJvQ2BkLcwlS/nZXKg594MJ/uwO17UFUQUlfmiJ6mwyE+BHKdy5JZAtZGfy
         laY5MEdcIc4vwlhdelUAN6acRv6WKlHHW23QP9McLuy2ZkmwBWrDqSfe3W09i/9ArHff
         k50IfEg9OkL4e4XbuF09KeeDjNNBodxAvwJyyqK2YCvR/OLAZ6SQ/qd7ejOltAabTWmS
         ZTWzypNxNuZGlpPtK+PV7gr6piowmvdJZO/6A7I36k+nP86VPgxvI+E2C80nwL5ZjKHj
         tNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703014345; x=1703619145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IF8GvvowDjNbUwrAOPiYPKi0zKWqFwVvQy27RkH1Gsk=;
        b=qN9K0dXYHwTj7RA2/E8esIxw/mcpQkBrW5AvSruZMecZtvSUkxeW3oNANTHtQSOpnT
         DkCFgVNDvJ3gz29rZzU/bo5CC87uy3uuP/Z2IeFURIjVZ8pKd930W5Q+guil9pIWv9vk
         w3baH4CuObKP0b4UCVU5TQbnBQl9G6o9df0AYBzPfKXyFN/vw14Z1j96HVZwLZ7dV1+a
         yyBi4HuBGGh/jeCwmUMFyy/nDCj2HKZN3QVHsnezvwrUdUAzEizcJh8HNKrtoEvxKHyD
         FjGbbO7WSLhH8UgmnGfCC3PJ50J2Lvi7i7gb2uvn2hw7zZKDZt5ISORo9mybCsMXr/Rd
         kZQA==
X-Gm-Message-State: AOJu0YxvoBLZ4IEm60HiYPIGWi18POQmWTNwHayIaEfRSI5/7OLuiLaQ
	vxhtIHHQXsqwq6Yyk0nKUYM=
X-Google-Smtp-Source: AGHT+IHE4Q+XrID+wd7CG0y5dR6aqT5vs4T6IimX/UtgQxOmMxgL8h+GtjZcd0WDGzJQeg/+2yvCtg==
X-Received: by 2002:a05:600c:5020:b0:40c:6ca7:f001 with SMTP id n32-20020a05600c502000b0040c6ca7f001mr4330598wmr.56.1703014344981;
        Tue, 19 Dec 2023 11:32:24 -0800 (PST)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id hg12-20020a05600c538c00b0040c41846923sm4130537wmb.26.2023.12.19.11.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 11:32:24 -0800 (PST)
Message-ID: <f16ded3f-1744-4bac-a7ca-fff2d425ec99@gmail.com>
Date: Tue, 19 Dec 2023 20:32:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/surface: aggregator: make ssam_bus_type constant
 and static
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, hdegoede@redhat.com
Cc: linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
References: <2023121957-tapered-upswing-8326@gregkh>
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <2023121957-tapered-upswing-8326@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/19/23 18:18, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the ssam_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> It's also never used outside of
> drivers/platform/surface/aggregator/bus.c so make it static and don't
> export it as no one is using it.

Thanks! Looks good to me.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> Cc: Maximilian Luz <luzmaximilian@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/platform/surface/aggregator/bus.c | 5 +++--
>   include/linux/surface_aggregator/device.h | 1 -
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/surface/aggregator/bus.c b/drivers/platform/surface/aggregator/bus.c
> index 42ccd7f1c9b9..118caa651bec 100644
> --- a/drivers/platform/surface/aggregator/bus.c
> +++ b/drivers/platform/surface/aggregator/bus.c
> @@ -35,6 +35,8 @@ static struct attribute *ssam_device_attrs[] = {
>   };
>   ATTRIBUTE_GROUPS(ssam_device);
>   
> +static const struct bus_type ssam_bus_type;
> +
>   static int ssam_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
>   {
>   	const struct ssam_device *sdev = to_ssam_device(dev);
> @@ -329,13 +331,12 @@ static void ssam_bus_remove(struct device *dev)
>   		sdrv->remove(to_ssam_device(dev));
>   }
>   
> -struct bus_type ssam_bus_type = {
> +static const struct bus_type ssam_bus_type = {
>   	.name   = "surface_aggregator",
>   	.match  = ssam_bus_match,
>   	.probe  = ssam_bus_probe,
>   	.remove = ssam_bus_remove,
>   };
> -EXPORT_SYMBOL_GPL(ssam_bus_type);
>   
>   /**
>    * __ssam_device_driver_register() - Register a SSAM client device driver.
> diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
> index 42b249b4c24b..8cd8c38cf3f3 100644
> --- a/include/linux/surface_aggregator/device.h
> +++ b/include/linux/surface_aggregator/device.h
> @@ -193,7 +193,6 @@ struct ssam_device_driver {
>   
>   #ifdef CONFIG_SURFACE_AGGREGATOR_BUS
>   
> -extern struct bus_type ssam_bus_type;
>   extern const struct device_type ssam_device_type;
>   
>   /**

