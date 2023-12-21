Return-Path: <linux-kernel+bounces-8420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA7C81B6E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA7E1F233B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7498A73182;
	Thu, 21 Dec 2023 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YLcmu/HC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2322AE8C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703163788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BjRdZhCKzE7JtY/adDHIB/ezNElWS0qNPXIlHVzYOOc=;
	b=YLcmu/HCvaULCZ4vvu4w+7Vnc/+tsWY33Xu9drvv3PvMA8mMo0omveAFrTo95hSdJJ9N5E
	XgGFQKNZDCIC0nKQL1G9kAZYtPLU+JVkgyzDT0TcdMck6D138+0Pi2UeNgxKuU0GUDsFRC
	WsVJaK7FOfgua99oZyiERaAkHH4gKUU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-g8fDxFJANtuBINKiem2Ogg-1; Thu, 21 Dec 2023 08:03:07 -0500
X-MC-Unique: g8fDxFJANtuBINKiem2Ogg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a23365478e5so38152566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703163786; x=1703768586;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BjRdZhCKzE7JtY/adDHIB/ezNElWS0qNPXIlHVzYOOc=;
        b=euylrfTO/ew7wibK4QB6ifMVZzfbXZ9kOJm/BP+THrFfTbGIF4NTjOtu9fukwWTLef
         oQVxGI7YkMkmocbcJgNdwinzHtweuhuT2FGTyARZyJzLJCOPGunR7y2rfR4VEcYNpUQQ
         XvFyM3sAYWfzDlfmYvfK6uEAbUeV8gCr7uOcusnIyEWvbDBp7ulfsMjCI56nEQIa0U8L
         O1qLpBxhAuv1z84KXf9eZdHfb1RoYMEpNiqmJ830B03GTmcyFoOrw3pwX7W0s8Lhak0m
         44ySIY26kGaBs6Weq74NdmnFft9Bjz3K0DuUC8bJH4igJ6NaKXVuil1glA+RDV/N5htY
         nknQ==
X-Gm-Message-State: AOJu0Ywfh8Ah460dMog2y6nBYYRBqIGGK4nyMNY8EpaNBtloWlv9E+vZ
	BQwqCcbdp/h19VSMaEEnFsH3YeJP4VEcCDnFmU0ORhm8JvyoBKn8LOXE1juL5MXiaQ5xDyDFvmA
	JCkqVLMyFY/tvvmsfXvrzgs1Z
X-Received: by 2002:a17:907:58d:b0:a23:5fac:1496 with SMTP id vw13-20020a170907058d00b00a235fac1496mr2753161ejb.50.1703163786022;
        Thu, 21 Dec 2023 05:03:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH06n2w6Mv+uCo2dVnjqhaTMTcKxjRcFobZdIGH38oJmrV13WThuR5t4GattDzvwg0kpPlQhQ==
X-Received: by 2002:a17:907:58d:b0:a23:5fac:1496 with SMTP id vw13-20020a170907058d00b00a235fac1496mr2753154ejb.50.1703163785722;
        Thu, 21 Dec 2023 05:03:05 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ka23-20020a170907921700b00a236e9cfe74sm926599ejb.103.2023.12.21.05.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 05:03:04 -0800 (PST)
Message-ID: <7f763191-2148-42ad-b1ce-afd1a6d478ff@redhat.com>
Date: Thu, 21 Dec 2023 14:03:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/surface: aggregator: make ssam_bus_type constant
 and static
Content-Language: en-US, nl
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Maximilian Luz <luzmaximilian@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
References: <2023121957-tapered-upswing-8326@gregkh>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2023121957-tapered-upswing-8326@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg,

On 12/19/23 18:18, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the ssam_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> It's also never used outside of
> drivers/platform/surface/aggregator/bus.c so make it static and don't
> export it as no one is using it.
> 
> Cc: Maximilian Luz <luzmaximilian@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Greg, do you plan to merge this yourself (fine with me)
or do you want me to merge this through pdx86 ?

Regards,

Hans





> ---
>  drivers/platform/surface/aggregator/bus.c | 5 +++--
>  include/linux/surface_aggregator/device.h | 1 -
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/surface/aggregator/bus.c b/drivers/platform/surface/aggregator/bus.c
> index 42ccd7f1c9b9..118caa651bec 100644
> --- a/drivers/platform/surface/aggregator/bus.c
> +++ b/drivers/platform/surface/aggregator/bus.c
> @@ -35,6 +35,8 @@ static struct attribute *ssam_device_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(ssam_device);
>  
> +static const struct bus_type ssam_bus_type;
> +
>  static int ssam_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
>  {
>  	const struct ssam_device *sdev = to_ssam_device(dev);
> @@ -329,13 +331,12 @@ static void ssam_bus_remove(struct device *dev)
>  		sdrv->remove(to_ssam_device(dev));
>  }
>  
> -struct bus_type ssam_bus_type = {
> +static const struct bus_type ssam_bus_type = {
>  	.name   = "surface_aggregator",
>  	.match  = ssam_bus_match,
>  	.probe  = ssam_bus_probe,
>  	.remove = ssam_bus_remove,
>  };
> -EXPORT_SYMBOL_GPL(ssam_bus_type);
>  
>  /**
>   * __ssam_device_driver_register() - Register a SSAM client device driver.
> diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
> index 42b249b4c24b..8cd8c38cf3f3 100644
> --- a/include/linux/surface_aggregator/device.h
> +++ b/include/linux/surface_aggregator/device.h
> @@ -193,7 +193,6 @@ struct ssam_device_driver {
>  
>  #ifdef CONFIG_SURFACE_AGGREGATOR_BUS
>  
> -extern struct bus_type ssam_bus_type;
>  extern const struct device_type ssam_device_type;
>  
>  /**


