Return-Path: <linux-kernel+bounces-138995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDE889FD36
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83733288E01
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B840317B50D;
	Wed, 10 Apr 2024 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZbYtTbv"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7D117A926;
	Wed, 10 Apr 2024 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767175; cv=none; b=hcFAU5LGofILyz2RV36ddjvkKYVFazrLNwcwccGBiHw3DPQqrNTyO2dktKXFYWL2pE5Joy03PhbdsHtleRDxHbvPdNDsI5de+zbVKN13eZsNp0hXNKSyJBvRgcD7eAEIxqKZTOQTP8PEf6P5TY2R3It/OdXsTf7h++UZqQzd0Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767175; c=relaxed/simple;
	bh=2eEH3ZOOIaNx+MnqitYjg5AU2NgTGgO5gKgpd/pn/RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfQXp8nRmpt/dIvVxXSbb/8m1VEGaZ8fbqucs1Ff7iCdhg8EP+QbsoZpvDUMa76nX80Mwsxiqyq+H14L1BJdycODKYYZVvJHHnjN6FOhxaiv/kse3T0/YxTggAbWmB5KUJNbICRPLX4MMwjVxID+zxkZ+FB7U/bdHYu86CmlUq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZbYtTbv; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so5574659a12.1;
        Wed, 10 Apr 2024 09:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712767170; x=1713371970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3Qo8qyUtr3NSvbISC3vkHyHe95wEkekwTVcOcmEvBQ=;
        b=KZbYtTbvuKDKjZosHc/xrRouneGa4+zD8y1advhqZOYLtcyuaPD6yM7/xsB6V53CwM
         yGK+bGPtevh2Dc3fUZgJVk0rSRh1aYUuawsdiydY3b4Hkswv6p1yyub0IBrtYpNJEMdp
         ojBjDtMsitd91pZV3B5c3nUL492XuwGSWv+KxJKH1Db+rErXjpOY6DWcSIbnVmbQNbLP
         z2YBsWO2StGVceF6Fklmy9gqLABD2owEjG+2eJASZQ/c6cWuIFDLrVFzJ5KFErJv1ZKQ
         3lGczBdN+HQ1oXbMCnVnp0KOtLUhLak8SsJBbLAFsFxdW0nCvAB8WiUyVGEhrwkGulKr
         mLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712767170; x=1713371970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3Qo8qyUtr3NSvbISC3vkHyHe95wEkekwTVcOcmEvBQ=;
        b=WFC0zq6+Q9CJtsi4AphK4c6e8jnu311UkAlyN8K5N8S0lz9+TwwUfzZRRsyvvgVJCo
         OKYqgQUHINh44u/7HsGJe/acL1a6HxDh00gXPny8W6PO5vYSXCerjfyYE2f+rCHAJX50
         No98H8TO01ogRSTE94o8VkSoHf9TJcYwjTnBN4cMLQomr8KWxdtFf0zJCoXsgNlBGWXZ
         oXG9yD7bzVAp45FAdETln/Y9RV6yWqfPsLut/aDFfmoAx6OIms5O8ipdpvhdyvIDWu1E
         jlIjJnolBfHCZPsBT5NgirT/QoSZeDNifqOC341XbXfItC1EW1/bF/vEOeYaepnsImV2
         WSEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNv0v3u15sZP3afcPGvPKCAcbGIrVvHfpyazYvQosIScxMBUrVBADKQh7oC0X9tNPLNSi/OtfF3Y9ZueM0/cxAQBTfUxhTkjh93lQMQfxrn3exAkCFgsfdUudT5mNk7/lLr3SOcKhP7/4dM5clm3pQHsznxWSRKJxbTSwY4/qfZEFxFOFvo9xCkaQB4BCsukfPYa1iypb4F/9z4Mv3Ju8JCL+/VkkYr9j+RBk=
X-Gm-Message-State: AOJu0YxXsjY8i0NjYq41M9FA32rUUXoiGYQh46DJx+36PLe1a7Kppc/h
	Zq40cIp+n0EE5soyCLQq5swQgf/Ek1eyTU5nQ3EJgBT7rqYvv9OH
X-Google-Smtp-Source: AGHT+IHaaF0VwWLsv5V7COAc8nmkV3OV9WcPYm71mkoubr3VciWhbsJlyG1fuGIaBJzmYOCFXEyhgA==
X-Received: by 2002:a17:90a:f989:b0:2a2:ad4a:691a with SMTP id cq9-20020a17090af98900b002a2ad4a691amr3072375pjb.22.1712767170525;
        Wed, 10 Apr 2024 09:39:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mz22-20020a17090b379600b0029fbfb620cdsm1546656pjb.28.2024.04.10.09.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 09:39:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Apr 2024 09:39:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH RESEND v8 03/10] watchdog: rzg2l_wdt: Use
 pm_runtime_resume_and_get()
Message-ID: <7f772a05-673c-4a36-9c6d-a0808346783e@roeck-us.net>
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
 <20240410134044.2138310-4-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410134044.2138310-4-claudiu.beznea.uj@bp.renesas.com>

On Wed, Apr 10, 2024 at 04:40:37PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> pm_runtime_get_sync() may return with error. In case it returns with error
> dev->power.usage_count needs to be decremented. pm_runtime_resume_and_get()
> takes care of this. Thus use it.
> 
> Along with it the rzg2l_wdt_set_timeout() function was updated to
> propagate the result of rzg2l_wdt_start() to its caller.
> 
> Fixes: 2cbc5cd0b55f ("watchdog: Add Watchdog Timer driver for RZ/G2L")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes in v8:
> - none
> 
> Changes in v7:
> - none
> 
> Changes in v6:
> - none
> 
> Changes in v5:
> - none
> 
> Changes in v4:
> - none
> 
> Changes in v3:
> - none
> 
> Changes in v2:
> - propagate the return code of rzg2l_wdt_start() to it's callers
> 
> 
>  drivers/watchdog/rzg2l_wdt.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> index 1741f98ca67c..d87d4f50180c 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -123,8 +123,11 @@ static void rzg2l_wdt_init_timeout(struct watchdog_device *wdev)
>  static int rzg2l_wdt_start(struct watchdog_device *wdev)
>  {
>  	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	int ret;
>  
> -	pm_runtime_get_sync(wdev->parent);
> +	ret = pm_runtime_resume_and_get(wdev->parent);
> +	if (ret)
> +		return ret;
>  
>  	/* Initialize time out */
>  	rzg2l_wdt_init_timeout(wdev);
> @@ -150,6 +153,8 @@ static int rzg2l_wdt_stop(struct watchdog_device *wdev)
>  
>  static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned int timeout)
>  {
> +	int ret = 0;
> +
>  	wdev->timeout = timeout;
>  
>  	/*
> @@ -159,10 +164,10 @@ static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned int time
>  	 */
>  	if (watchdog_active(wdev)) {
>  		rzg2l_wdt_stop(wdev);
> -		rzg2l_wdt_start(wdev);
> +		ret = rzg2l_wdt_start(wdev);
>  	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int rzg2l_wdt_restart(struct watchdog_device *wdev,
> -- 
> 2.39.2
> 

