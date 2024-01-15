Return-Path: <linux-kernel+bounces-25725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B856182D4FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630061C21271
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0B179F1;
	Mon, 15 Jan 2024 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9fKs8sb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB07BE5C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705306943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nDvrcOFbZHCB3Od8Ma5mTsDvXWbMD7Yk0uFxpr0XBF8=;
	b=h9fKs8sb0uoDaBH8SsDymAr+3IrEEAnJw4WA+yOgoVgeGIkYj4tGVKfvXlSJaFVEei25YA
	LYmimmTmcoBT50Qcmand0ChvS9PWqN+yGnPTJL/muOG7RszEsLZH7Qf8KBYATtb9yTgrC8
	CYKZ0kYwnymAKMRXt9FA5V083NHJE34=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-p6reDjSbOX6vmVYVCWUJqQ-1; Mon, 15 Jan 2024 03:22:21 -0500
X-MC-Unique: p6reDjSbOX6vmVYVCWUJqQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e417aa684so63070565e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 00:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705306940; x=1705911740;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDvrcOFbZHCB3Od8Ma5mTsDvXWbMD7Yk0uFxpr0XBF8=;
        b=lH1hGNWpVTb9K3KKAXgLrv/2CNI7vVjtXcFPh0QAA896XZQMG3doJ8IfKPna+Mkomz
         ZO7jnwLu4RMysF/z21sWqW1D/pm+cUdtFPKa6czDalamSVFX8ADtM57HAIAZLPgqPHB5
         kir3iRDEPATCum0W+D4zCUHe6dxs0L1Lubczbvr4fqO3eRApzlIMQPEsR6B+tobZrcoV
         EA6jsf+Fx+si+Q5pmm4RjKXfN+JCtFEj3xHSvXvUI658e5OJdItHxYXSo2oPemm7J82g
         j+AMOANdCx/pbelhhS9McIYelXWMD+H5lmBu0u+ifO3EOVGaehQ5tJZD4BTdVMr80+nI
         LVQA==
X-Gm-Message-State: AOJu0YzWIDp2hX6yiAIus4iea0hihXxdo81I+6i3YSbMivVeAyr8QRIO
	DOTfF5hPRJw1ZCskgYO36sCBNI58W3MQyxAjQArzFJpdumFiQP1fO/+4HiufYIpTZZwgp83twU0
	DPZGRR3RZgHue5ZK0fv4LW8nCVpXxC9Pr
X-Received: by 2002:a7b:c001:0:b0:40d:5f48:d1ed with SMTP id c1-20020a7bc001000000b0040d5f48d1edmr2597178wmb.66.1705306940691;
        Mon, 15 Jan 2024 00:22:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ0NHyBcjOe6YwXt82/ItKtsQM+F0s2up4dWVDb/3J/Yk/w5sS+hxI8gjhqkvBzGwvSzZIiw==
X-Received: by 2002:a7b:c001:0:b0:40d:5f48:d1ed with SMTP id c1-20020a7bc001000000b0040d5f48d1edmr2597172wmb.66.1705306940369;
        Mon, 15 Jan 2024 00:22:20 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w18-20020a05600c475200b0040d2d33312csm15166041wmo.2.2024.01.15.00.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 00:22:20 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jingoo Han <jingoohan1@gmail.com>, Daniel Thompson
 <daniel.thompson@linaro.org>, Lee Jones <lee@kernel.org>, Helge Deller
 <deller@gmx.de>
Subject: Re: [PATCH v1 2/4] backlight: hx8357: Move OF table closer to its
 consumer
In-Reply-To: <20240114152759.1040563-3-andriy.shevchenko@linux.intel.com>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
 <20240114152759.1040563-3-andriy.shevchenko@linux.intel.com>
Date: Mon, 15 Jan 2024 09:22:19 +0100
Message-ID: <878r4rovk4.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> Move OF table near to the user.
>
> While at it, drop comma at terminator entry.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/video/backlight/hx8357.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
> index c7fd10d55c5d..8709d9141cfb 100644
> --- a/drivers/video/backlight/hx8357.c
> +++ b/drivers/video/backlight/hx8357.c
> @@ -566,19 +566,6 @@ static struct lcd_ops hx8357_ops = {
>  
>  typedef int (*hx8357_init)(struct lcd_device *);
>  
> -static const struct of_device_id hx8357_dt_ids[] = {
> -	{
> -		.compatible = "himax,hx8357",
> -		.data = hx8357_lcd_init,
> -	},
> -	{
> -		.compatible = "himax,hx8369",
> -		.data = hx8369_lcd_init,
> -	},
> -	{},
> -};
> -MODULE_DEVICE_TABLE(of, hx8357_dt_ids);
> -
>  static int hx8357_probe(struct spi_device *spi)
>  {
>  	struct device *dev = &spi->dev;
> @@ -640,6 +627,19 @@ static int hx8357_probe(struct spi_device *spi)
>  	return 0;
>  }
>  
> +static const struct of_device_id hx8357_dt_ids[] = {
> +	{
> +		.compatible = "himax,hx8357",
> +		.data = hx8357_lcd_init,
> +	},
> +	{
> +		.compatible = "himax,hx8369",
> +		.data = hx8369_lcd_init,
> +	},
> +	{}

While at it, maybe add the { /* sentinel */ } convention to the last entry ?

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


