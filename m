Return-Path: <linux-kernel+bounces-139006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3697689FD57
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28E8282FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BED17B513;
	Wed, 10 Apr 2024 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZtEVqli"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC0E53361;
	Wed, 10 Apr 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767398; cv=none; b=dHbB5cJ48TVnk10EMydktnPFWwCtcP5TsF7nBtc9/xn1a8WmMd5UBzEgH1di+gUwbUuBVMbUAF7rZ1N+TT5QWrjjY0jvxgUEQRwzhMGaymYbJ9PuuOZ2urYN5N75SPCzZXKFbwx9eoumEAe/Pbm5siy+MdawCNIesi3vlLaGFb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767398; c=relaxed/simple;
	bh=ukV/hLhJkpZsUA3IiTrMj3G+2iNcPFjRiHi6vvKPDKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpkC930lxEs/mqdA+YHt7Shhg3EWHXJvgrR6A4M3gALBVrqzmcKw7jdnVXtSloxqDpf3i1sxpPWbG9ydr5ozrZveK1ISI36bPhbvlC2KP4YPn8KS2qYh9h1yyIAPCP1o713KZPRY9g6a7M7J5ZCb+iROkL63x7jPxC66Mpyj0sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZtEVqli; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so2769644b3a.0;
        Wed, 10 Apr 2024 09:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712767396; x=1713372196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87hVoX9g0Y/MEsZ2Zy8Ew+OoM1271M72lcJZUtmLxw4=;
        b=hZtEVqlit4pBK143QLpZ5tFFjHodWR5qrr90TAeZAmF4bWk7BEbsFzX3biDO5YIKpo
         EROZs9pzZjeRIb7LyE2rtGlQ3JO5WRt1NDCwUelcxB7lVo/znwUGUQkj6DeXTVA1pr7w
         b6Ezg8GSUqCo6pgidNbj6VeYDRLZFZTJF/lLq6CPaBoGQZGV5g5e3+8vRtK5JSuQlLfP
         mX0ejnaKW4GaBECWaBXjsjYhrCISbXHIuhuBydH35alkQiLYc4DfazQfJdNEjhm11bY+
         O/48fzIRSqdCdCGImH5rQKa6NJXPJAqU1VVKbpwOrUIdbu9e7qEomYTpkNHX7EkAZ5U6
         k4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712767396; x=1713372196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87hVoX9g0Y/MEsZ2Zy8Ew+OoM1271M72lcJZUtmLxw4=;
        b=aZ8Yrs9WjEXptnK4P4zQBshU0JCAIIWUsFVFiJZYg6m8WCcxHgEurXzGDbg/UsnAX4
         5IM8a6m4OvazLygGzdsp3JU9dhZygOZNzfQ0ARqe/AvQVVGF8a0G0MzyQ+/xk+AnH8BZ
         DKcoGnJk/VUgSjTQV4bz274FLZkWQqoRzyryg40NkXIG4E1BFyvp7PYZRV4w/uH8kOgb
         Tn3fk75IHSOXuFmp04eiB/VmimSAMfoYnK+CniGKbtqKP3jDFazI/p0HUpeWWOVEL1/f
         LtrbmoJo8NHOse96+wOP3pykh8lE90FoEuE/dijuJh8ux38cviI2UM5dQZNjh/HUendW
         Y5Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVGnMK4/UdlNEs0dlmoXUgD1KPylNIuRIg9NTmujJS3u8nxfgcyTY/O1Cj17xNGyvkiexIuAIwAHoINj/vFdeL/V/iO/NJHrDyJWwM1ZbM4kgPaSImO3NipsvB+ivhcAYYi+pgUmJ61mULnBf6YzU7wtGv3WdcjqaXtYtdCWTDppjce9C4O69gl8Z8FUn8hdTxKV7DgpTAMLWWkydW4lVyI/8TQWwcoV3pdQjM=
X-Gm-Message-State: AOJu0YyEeP85nMYrNm6GUiSxVPpAAYrcD3hpyiEIOGTgca/AyQGv0Aek
	Hy2RzPZfQMNpEXU/8fZABrwQuY4kNG8deLtu4gflcQMwD20qVzgI
X-Google-Smtp-Source: AGHT+IHWGUPoGc7XnH6otGmYV1T27EH6PiCTYFI+MrYJlN1/GpvTfupHfzSdYA64tdoiNLbViNp9ug==
X-Received: by 2002:a05:6a21:a109:b0:1a9:6cdd:6907 with SMTP id aq9-20020a056a21a10900b001a96cdd6907mr1530098pzc.29.1712767395793;
        Wed, 10 Apr 2024 09:43:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902dacc00b001e0fcf995easm10880841plx.202.2024.04.10.09.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 09:43:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Apr 2024 09:43:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH RESEND v8 09/10] watchdog: rzg2l_wdt: Power on the PM
 domain in rzg2l_wdt_restart()
Message-ID: <e25784ad-fc4b-4b5f-a67c-e93880293b01@roeck-us.net>
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
 <20240410134044.2138310-10-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410134044.2138310-10-claudiu.beznea.uj@bp.renesas.com>

On Wed, Apr 10, 2024 at 04:40:43PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The rzg2l_wdt_restart() is called from atomic context. Calling
> pm_runtime_{get_sync, resume_and_get}() or any other runtime PM resume
> APIs is not an option as it may lead to issues as described in commit
> e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait context'")
> that removed the pm_runtime_get_sync() and used directly the
> clk_prepare_enable() APIs.
> 
> Starting with RZ/G3S the watchdog could be part of its own software
> controlled power domain (see the initial implementation in Link section).
> In case the watchdog is not used the power domain is off and accessing
> watchdog registers leads to aborts.
> 
> To solve this the patch powers on the power domain using
> dev_pm_genpd_resume() API before enabling its clock. This is not
> sleeping or taking any other locks as the power domain will not be
> registered with GENPD_FLAG_IRQ_SAFE flags.
> 
> Link: https://lore.kernel.org/all/20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes in v8:
> - none, this patch is new
> 
>  drivers/watchdog/rzg2l_wdt.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> index c8c20cfb97a3..98e5e9914a5d 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/units.h>
> @@ -164,6 +165,17 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
>  	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
>  	int ret;
>  
> +	/*
> +	 * The device may be part of a power domain that is currently
> +	 * powered off. We need to power it up before accessing registers.
> +	 * We don't undo the dev_pm_genpd_resume() as the device need to
> +	 * be up for the reboot to happen. Also, as we are in atomic context
> +	 * here there is no need to increment PM runtime usage counter
> +	 * (to make sure pm_runtime_active() doesn't return wrong code).
> +	 */
> +	if (!pm_runtime_active(wdev->parent))
> +		dev_pm_genpd_resume(wdev->parent);
> +
>  	clk_prepare_enable(priv->pclk);
>  	clk_prepare_enable(priv->osc_clk);
>  
> -- 
> 2.39.2
> 

