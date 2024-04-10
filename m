Return-Path: <linux-kernel+bounces-139002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AE289FD48
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B88C1C2282F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92D317BB08;
	Wed, 10 Apr 2024 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtlmPpSE"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7DC53361;
	Wed, 10 Apr 2024 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767294; cv=none; b=BXuRXLdU/CqZontroSmbRuUDQ4slA+6GOl2KAGwO1BGazfOwInlhz01hO5vA2FGCGguAA6ngmp54oH4IDI27RIgpm8jc9jSiWIeP/FGydlbwvMol7amdlnNVXs3lrjWg4+1zP/46nvYMyQZj8nwn2qUcxmziuuwGetPOffdBkH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767294; c=relaxed/simple;
	bh=rPerJJn3biX4sbECq7c1tdjhUFR77YvaEV2OFbSE/f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwxlIPbGBclVkxt7A7q5zAcAIWw+Ymp68zG/pbKHgBw4ei4JOQe8NQoqh+8tNZGFm3lFDUzlJ0B28rZsXkmLzpxaff7eZcTZFjq8RVTJbbQvj7vVaUpgVUAQ0WdbuSvmsVpufqB4qzJ3+ScvWuflzh4O4KW21dwaTwAgN7Eke6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtlmPpSE; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a52c544077so2392076a91.1;
        Wed, 10 Apr 2024 09:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712767290; x=1713372090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELfaV4GPEm5ocBZ1LRuYfhYld4W3AmhJB8JTvKZbbFA=;
        b=CtlmPpSEDlZC7Jf5xz/BClyvDZ5s9f0G2Qib8gCAtUJivCDtv2ULq4TbjsQztuH9Wc
         Af7oUpzbAarMex8+zhr4bdnCP8KiERAofRGU7P010LlF4K9aYpYBHlhq6tNqKbUZSc3E
         1w4GjdADIQy9JSRKBlGtGfNmV2QcnUPNhvlr2Vnz5yWej7WMn5ERk5RNsSQfaaCNAzGd
         nIKqA3oGi1S7HYuRzJl8QUdx261AzGhFJhKu1AtN+f/I3I/ejCk3tDF911pNEwkcZOwp
         9br82JAuN8aCjtRYFOGgaQ5hMYBO3NifiVsZJ9YEQRF5yTHrzHRQv3xXHvUGMBz667yO
         scdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712767290; x=1713372090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELfaV4GPEm5ocBZ1LRuYfhYld4W3AmhJB8JTvKZbbFA=;
        b=M2O9pZtqIl0K3fLaFcwug7bcDo7EJg9SZdiDmFbIOKA7nJ8ZcGbiX3aosSeCkdXcSW
         +WVFC9FuqUeLH6/0S3andh0ahHESbl6tp2RC1yX4I/1NL9k+lr6CG+wc3uDX9PwLlSDr
         BI9OwMHz9yiFCNL0gqhTHtVAhBdEOi+aYlB/TwO6WAEKSCqPomOcty1kNSUAFXeRTGI4
         lRS0Wu/MWnK6cKqy3uUHqDyOtA8RTHNvHvCNSAeY2Yvy/py5PB1VQOk/1PO458y21QUD
         Z34xFzV4uKiliN77Qq+QoF3h2xLjNKneqTnUGzEKB6J3ll4E+VbN58jTETSxAZDvVmkp
         OjCA==
X-Forwarded-Encrypted: i=1; AJvYcCX3cyzW2uBJVK4oixAFKYAJvX2e3GTS1ivQLrjVWpSthKOOr03Cl6kDiyx/8ibCMWtE67OkXDFRAr0VHklnD1EYWtyjyCqbHtPvIvXhUAeUdwrzidbZ9/Cd5RWv00cj9E3DbB45c8qJKsga0NOWEeprV874nUUnTYq30AlUPCJg3oECO4RxRQalhm/ZrPkqLNbx0X1Y42HvjAbtMcRBSVaCIwh2CM3m8bJOtfs=
X-Gm-Message-State: AOJu0Yxb6d3tgC4ErBN8SSiBzSK3J4FaUGS3b9RA4jOXKWJlHESsmnt1
	fPHKvfrFvm8mEen16ccwkJ+Dhe0qSRG2w1P96eGKHJdJ5QD8kIdl
X-Google-Smtp-Source: AGHT+IG2uVzViVWP67PYsO8l4ncxYa3G6rbaW+KjO2Vgrpo566zjsA8MQnJN5yCR4F1CLqzf450x4g==
X-Received: by 2002:a17:90a:5911:b0:2a2:a9af:9197 with SMTP id k17-20020a17090a591100b002a2a9af9197mr2942569pji.3.1712767290511;
        Wed, 10 Apr 2024 09:41:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x3-20020a17090a388300b002a2dbbbb36asm1679942pjb.37.2024.04.10.09.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 09:41:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Apr 2024 09:41:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH RESEND v8 05/10] watchdog: rzg2l_wdt: Remove reset
 de-assert from probe
Message-ID: <f142c4dc-75b2-48a6-93e4-920d414575fe@roeck-us.net>
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
 <20240410134044.2138310-6-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410134044.2138310-6-claudiu.beznea.uj@bp.renesas.com>

On Wed, Apr 10, 2024 at 04:40:39PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> There is no need to de-assert the reset signal on probe as the watchdog
> is not used prior executing start. Also, the clocks are not enabled in
> probe (pm_runtime_enable() doesn't do that), thus this is another indicator
> that the watchdog wasn't used previously like this. Instead, keep the
> watchdog hardware in its previous state at probe (by default it is in
> reset state), enable it when it is started and move it to reset state
> when it is stopped. This saves some extra power when the watchdog is
> unused.
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
> - update patch title
> 
> Changes in v4:
> - none
> 
> Changes in v3:
> - none
> 
> Changes in v2:
> - none
> 
>  drivers/watchdog/rzg2l_wdt.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> index 7bce093316c4..93a49fd0c7aa 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -129,6 +129,10 @@ static int rzg2l_wdt_start(struct watchdog_device *wdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = reset_control_deassert(priv->rstc);
> +	if (ret)
> +		return ret;
> +
>  	/* Initialize time out */
>  	rzg2l_wdt_init_timeout(wdev);
>  
> @@ -146,7 +150,9 @@ static int rzg2l_wdt_stop(struct watchdog_device *wdev)
>  	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
>  	int ret;
>  
> -	rzg2l_wdt_reset(priv);
> +	ret = reset_control_assert(priv->rstc);
> +	if (ret)
> +		return ret;
>  
>  	ret = pm_runtime_put(wdev->parent);
>  	if (ret < 0)
> @@ -186,6 +192,12 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
>  	clk_prepare_enable(priv->osc_clk);
>  
>  	if (priv->devtype == WDT_RZG2L) {
> +		int ret;
> +
> +		ret = reset_control_deassert(priv->rstc);
> +		if (ret)
> +			return ret;
> +
>  		/* Generate Reset (WDTRSTB) Signal on parity error */
>  		rzg2l_wdt_write(priv, 0, PECR);
>  
> @@ -236,13 +248,11 @@ static const struct watchdog_ops rzg2l_wdt_ops = {
>  	.restart = rzg2l_wdt_restart,
>  };
>  
> -static void rzg2l_wdt_reset_assert_pm_disable(void *data)
> +static void rzg2l_wdt_pm_disable(void *data)
>  {
>  	struct watchdog_device *wdev = data;
> -	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
>  
>  	pm_runtime_disable(wdev->parent);
> -	reset_control_assert(priv->rstc);
>  }
>  
>  static int rzg2l_wdt_probe(struct platform_device *pdev)
> @@ -285,10 +295,6 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(priv->rstc),
>  				     "failed to get cpg reset");
>  
> -	ret = reset_control_deassert(priv->rstc);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "failed to deassert");
> -
>  	priv->devtype = (uintptr_t)of_device_get_match_data(dev);
>  
>  	if (priv->devtype == WDT_RZV2M) {
> @@ -309,9 +315,7 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
>  	priv->wdev.timeout = WDT_DEFAULT_TIMEOUT;
>  
>  	watchdog_set_drvdata(&priv->wdev, priv);
> -	ret = devm_add_action_or_reset(&pdev->dev,
> -				       rzg2l_wdt_reset_assert_pm_disable,
> -				       &priv->wdev);
> +	ret = devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable, &priv->wdev);
>  	if (ret < 0)
>  		return ret;
>  
> -- 
> 2.39.2
> 

