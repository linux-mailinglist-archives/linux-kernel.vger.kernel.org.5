Return-Path: <linux-kernel+bounces-139005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E5589FD53
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76FA31F23F75
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239FE17B50D;
	Wed, 10 Apr 2024 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V95B1kcw"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118117B4FD;
	Wed, 10 Apr 2024 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767372; cv=none; b=HNkOsT+D0G3Sv/cq/8DYN/XUM5aaobhvcW3o3GVe+DIGJ/DwnuZEG37SaGcQ8ijzuXGWBosCh1CWfMQOaX/svscUa+RNEftRw4bMzNHNoGLPMIxBagas1vLFVraTFkaqbKWRiAU5G0P1bd3vmcvqR1KdE2xtZ5cvB+8wOPaEmnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767372; c=relaxed/simple;
	bh=nr7l5Me8hFmX5MYCdq2MPxgPEEtosSGoMa2K/xR6OmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbcNUZrxu4L8UiboMMUJyZe4z7qA40cw+77Oteb87sMLbeOq1euO/RrIbMDaPQbOxvE/vNjQP0ZqRj3MxsV3wDX2nhFHqkAhW3ShMehazS7NDtUj0Vwy/ooDlGg3KmtCXvRzOCqTwfBmLnPXRGtn98XwJCIg/QjkDyKEcNfo9zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V95B1kcw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e0bec01232so56498875ad.3;
        Wed, 10 Apr 2024 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712767370; x=1713372170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QvrLgbusRtp6icSHOLDKe4br76Byni+mrhDx/qF81bk=;
        b=V95B1kcw4MvCCcpHKhalHQOHBe12/U9AT41NoExDE5V6mw8hyFGkZzsxxez3THxSEI
         YyqFnZnpT0L5E1XTPww9rLGy/VTR5XSnwnuAghdWcjoHNbfrvNpkoSB0EJoZJfDC552v
         aXFuBQFZRm3NMwUwLTHwcyvtglZr/z8I3fFCQ435ivwATuWt6eF14jiFxVHxrT263bnr
         DVH/lJCFc7b4jY1CRDp/RZ7pnYc8zYPa+1Up2mPzFzPHo25/hHTZR9xm7DGpxNaLVhTL
         Sjz0DEjwM5CvU/b4vjtxl27mShZZDqJQcML4RiCwh+0daXX03i4dhyeb7IgIMvDNNEZv
         9fVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712767370; x=1713372170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvrLgbusRtp6icSHOLDKe4br76Byni+mrhDx/qF81bk=;
        b=L9edOd5uSKfjg49Wcc6K8KD1QkktVEku/yyHzCUL02AtwNjpRmp710dYgF69hG8exW
         EP+DnyFlgPgQkwA08NzNuzHDJxYbOCgpSwW9v+jkiijJe+Gkg9UCRjzWQ3hE9EzSTWUR
         SnSZ5KtwwOkDTeYUyM6hTvgJtwdi2hHgYZvqWaOIb++QxpT1cdJEasTn5Ga69yf1MuwZ
         mmjY/f8w8XBYm8/pTJD8I2FyC8oNSBBvnvDhK0qLB4Pzur9txUsJF3bIT8jCmajpJij4
         BKs34TsLUjrevUlsS+4TAXzXLrNwwP5cQagi/0QVK9xKGykxQPdI912yIi+WrJthQ76p
         VNww==
X-Forwarded-Encrypted: i=1; AJvYcCXHNkO4ct1AQhRBPW6prD+Ry2DrOQIyTQlyaLV1tsEDuJwsOzC8hm2ENcT5uhP7oruItRREdF1SHrcf/9GvJJINOLg91UC0a0169otyhGDzOUWtSgRP9ByCajJnz8uvvHsPnuKIIv8m67VAXQtpavHyjAhhDURniRhsYXLVspkIU4dRbDr7FBDbfTRN/G5kZRu1PZpOa7v7snJ7YqNdivifVLYr9M+LNBEALK8=
X-Gm-Message-State: AOJu0YxrSiGmPia5m7z++30KZUP1b+HcBl9aoOcOTwJxsJmF9HFNA9el
	nOrcKxW8e3B6lB1Xt2MXEMNUhQ3GH2Shxrbtt26v/1zxlocioZBj
X-Google-Smtp-Source: AGHT+IGc60vnflOap1uBJkvErnmbcLMnwMuOIbnLYhlY0mjrU9RBTdyG4ahrKQnKJvPZodhg08qCXw==
X-Received: by 2002:a17:903:287:b0:1e4:47bf:6926 with SMTP id j7-20020a170903028700b001e447bf6926mr3112427plr.4.1712767370086;
        Wed, 10 Apr 2024 09:42:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902ce8800b001e424de38d2sm6187657plg.174.2024.04.10.09.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 09:42:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Apr 2024 09:42:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH RESEND v8 08/10] watchdog: rzg2l_wdt: Add suspend/resume
 support
Message-ID: <aa9bbd1c-a17b-4364-b6fd-b94749d4e068@roeck-us.net>
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
 <20240410134044.2138310-9-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410134044.2138310-9-claudiu.beznea.uj@bp.renesas.com>

On Wed, Apr 10, 2024 at 04:40:42PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The RZ/G3S supports deep sleep states where power to most of the IP blocks
> is cut off. To ensure proper working of the watchdog when resuming from
> such states, the suspend function is stopping the watchdog and the resume
> function is starting it. There is no need to configure the watchdog
> in case the watchdog was stopped prior to starting suspend.
> 
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
> - remove the usage of pm_ptr()
> 
> 
>  drivers/watchdog/rzg2l_wdt.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> index 42f1d5d6f07e..c8c20cfb97a3 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -284,6 +284,7 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
>  	priv->wdev.timeout = WDT_DEFAULT_TIMEOUT;
>  
>  	watchdog_set_drvdata(&priv->wdev, priv);
> +	dev_set_drvdata(dev, priv);
>  	ret = devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable, &priv->wdev);
>  	if (ret)
>  		return ret;
> @@ -305,10 +306,35 @@ static const struct of_device_id rzg2l_wdt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, rzg2l_wdt_ids);
>  
> +static int rzg2l_wdt_suspend_late(struct device *dev)
> +{
> +	struct rzg2l_wdt_priv *priv = dev_get_drvdata(dev);
> +
> +	if (!watchdog_active(&priv->wdev))
> +		return 0;
> +
> +	return rzg2l_wdt_stop(&priv->wdev);
> +}
> +
> +static int rzg2l_wdt_resume_early(struct device *dev)
> +{
> +	struct rzg2l_wdt_priv *priv = dev_get_drvdata(dev);
> +
> +	if (!watchdog_active(&priv->wdev))
> +		return 0;
> +
> +	return rzg2l_wdt_start(&priv->wdev);
> +}
> +
> +static const struct dev_pm_ops rzg2l_wdt_pm_ops = {
> +	LATE_SYSTEM_SLEEP_PM_OPS(rzg2l_wdt_suspend_late, rzg2l_wdt_resume_early)
> +};
> +
>  static struct platform_driver rzg2l_wdt_driver = {
>  	.driver = {
>  		.name = "rzg2l_wdt",
>  		.of_match_table = rzg2l_wdt_ids,
> +		.pm = &rzg2l_wdt_pm_ops,
>  	},
>  	.probe = rzg2l_wdt_probe,
>  };
> -- 
> 2.39.2
> 

