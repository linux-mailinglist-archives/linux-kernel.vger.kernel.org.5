Return-Path: <linux-kernel+bounces-139003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B33489FD5A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24A6AB2B8A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E560617B4FD;
	Wed, 10 Apr 2024 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV3S7kYl"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AD617B4F8;
	Wed, 10 Apr 2024 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767318; cv=none; b=L/jR2u8Kg4WRcvu9gz1U0e8RqpKmw8AdniVfmbh4/385w2HBtPhwfxyM92tcuOhIrIeZJDSTVhrEsPgfBlFf8hrb9G7ygGSi84NJu7q7EGKHFx32nDOlig0ty4h+1bJrfDAAV3X0T33wFSMEqrYzBRdUBgZmI4QK8rxyZfjXqCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767318; c=relaxed/simple;
	bh=9zBa+XKIY0+8MFywDp1jOUp+YUf+42xwXubODtyuNXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSe3jydDZ8nvAcWG0URf4qsxc2cAP0eUvcY1NiVt0rI8PDZ1LcjseCnv47+6HF78t65QDQL/hJgUqGGyWE7vOs6NKPN+tYzrlGzyTceEF2kf1shiUp6oLWMIwQssv1c/XInN2/r+/xnfaEH9KE2swXWgyHxpPGo6IhHKpFTgUsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bV3S7kYl; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ed054f282aso4263521b3a.0;
        Wed, 10 Apr 2024 09:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712767316; x=1713372116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vg1pd797WWI5MkkVt5VBGTIHJqGZcRFQ/HmMvJNLEVU=;
        b=bV3S7kYlxIUA7F50taKsJgwt2T898MtaFegrB1iWl2m7CeXdHkswY8TiCiCr2tcRVt
         kF8bQMu5F4xqVZc6j0RCW6ucraMuTtI+dslKgthv+KHBRY6v+nwj5d0GH9ORjFL1uV4R
         qIJuNB21RIuVcCfA96qUwb5jaBC97nVCaLkV2VvqrghUQd7otrwX9zOZCXUj6m226idz
         enDbXFutUgQlh+SvLE5YLlbWHG9p3QwmTioleNn8UAQdedpzC0+/Y/pIwqTdJF2Zr9cH
         i9bQL4GKWOWkt3+9jtf+Z+t5VkkkKhBEhFPYOaqFGqAqfTPx4MQ/TFufSnY+tx+eodej
         XeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712767316; x=1713372116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vg1pd797WWI5MkkVt5VBGTIHJqGZcRFQ/HmMvJNLEVU=;
        b=hBgUdq4If5cjCltMnE3016/r+gLW3ypSubgmCVAEEu95jOvezHvHp7Kjfj48OoYn23
         xojx9kKXJdCsjNQFjMxvrzULRu5ZsKxr38XQtLf+4tLvGKaZSskXDySYKqukCjenciDa
         VZs2LWhee+CwV/Uj1J33xtPkYkdcPIV93kjeENM7wii280m9gSjWHtbwYdg3p2NWWAXb
         deoLo2OCNKxYGyzEi7POy9uu3+rWt+Av/Z7E+dTibvyNOa4XdNfenfyJywyDn9B0ugf8
         /nU+LxVMU/iRZHcPIUXc3SkRY30n+wHALADu189FbGkg0aYEOx9S+1BB98icAnjdzhR1
         URWw==
X-Forwarded-Encrypted: i=1; AJvYcCVZOtRBxw3B0XOOzMS4/5u3oTCq3j1vKghgQ9YH+I8RU4/6YDXWbJg9CRsJiObds/w01s+WIj66xznWzlb0y0FE7cM400+Nb9Aiprqruuv0tFeYw5WpWBtfxrrVQ1zpc+hNZ6FDBR11v/2hG50CQOd00LUKDgipxAkrKPAFRzLLpMalK+ftrAra511XRTiT3XzxIhS5zZuDeIM48G1ZKyUpq+2VnRjSJkNx17g=
X-Gm-Message-State: AOJu0YwNIMznL7TYIBYyS9dzwViwodkNann3k9gSi+hsqSuINWF5xBVm
	0jHLgb0qUCjx8SPMZLYLYAmZPsX152fCn3UO1nBXqWURnG30HGBU
X-Google-Smtp-Source: AGHT+IHK96DZtLOXceusdn9CZxZwCmgNhvmadlmiLBlNJ81l4xR0Amrx6bb7aQf5cJkDiiJrOeac0g==
X-Received: by 2002:a05:6a00:1915:b0:6ec:d972:c3d8 with SMTP id y21-20020a056a00191500b006ecd972c3d8mr3523379pfi.10.1712767316021;
        Wed, 10 Apr 2024 09:41:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d23-20020aa78697000000b006ecec1f4b08sm10297677pfo.118.2024.04.10.09.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 09:41:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Apr 2024 09:41:54 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH RESEND v8 06/10] watchdog: rzg2l_wdt: Remove comparison
 with zero
Message-ID: <822db9c7-c9a9-414a-8a7a-5917b8cf5066@roeck-us.net>
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
 <20240410134044.2138310-7-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410134044.2138310-7-claudiu.beznea.uj@bp.renesas.com>

On Wed, Apr 10, 2024 at 04:40:40PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> devm_add_action_or_reset() could return -ENOMEM or zero. Thus, remove
> comparison with zero of the returning value to make code simpler.
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
> - none
> 
> 
>  drivers/watchdog/rzg2l_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> index 93a49fd0c7aa..29eb47bcf984 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -316,7 +316,7 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
>  
>  	watchdog_set_drvdata(&priv->wdev, priv);
>  	ret = devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable, &priv->wdev);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	watchdog_set_nowayout(&priv->wdev, nowayout);
> -- 
> 2.39.2
> 

