Return-Path: <linux-kernel+bounces-133926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E060089AAFA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9571C21529
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F126136120;
	Sat,  6 Apr 2024 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgbML6cD"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B52E4C84;
	Sat,  6 Apr 2024 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712408472; cv=none; b=Jh02Lef1jxPcIj+oGMjB8afAXhJ0lJlQAMCqN20X5uPSvk2N2i5c/e9XRM4/bg4sAfsXRtUeRqXZ+ak979GdGbuDfY+eZUJe0jiVCfhGWrtvucIxblK6w9ljuCn9/4N17OkCCpbNwqaWA5HS/vubnj/RlqkTg59Zq7VmnI1GciU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712408472; c=relaxed/simple;
	bh=SBp6+4C+SfJy0u4Yx/qxNlUzGaQvzqy2E3uqnRjM+R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsH/42e3+GOryTUmbCrRo88F2WVsu2/ZiAIMjejntWtnpilGRhoo7UpKRxCdKflpw7gAO3vwds3H6yTDK1O2swlqWkLOsn2R6J2HlCgOPtGiJ6QKQhLt1Vo9Z15Qso3wyFwnA9icA9anNBkGwOkMLx7Mtm80/8I5pljKEypqvtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgbML6cD; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a2dd2221d3so1936327a91.0;
        Sat, 06 Apr 2024 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712408468; x=1713013268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hzW4szNi17LncifpeJF0JAR4gKXduE2nrvj/0wk1eU=;
        b=RgbML6cDNpAIz+v3B/DBtwptadiyKQdEAVCt2PpFYJ5MToWod/AXz8MSf9RcdxwZTA
         BIMzzwh3XIkPShsLcjm+bQ/wIFN+vvEgKS5aOSh0udr1oDByAhxhOQ6GHyGdr/Z2LiZR
         MJiI8hZfCPB4JD1MGG+idEMAUi64Qs/GugJdpBKrRvaIt8ewAGVp/qt/Gg99VXltwhHm
         gO+aB2x1DrGD6ZBZBkWKLBYJfEKM7O2tV/GwSwPb40vWXtIND+0IvTU0a75U7Bisp9KK
         Kt3chSndUWt5QXpuS7AbrBaIDjIbXivv5HUV+Dd1s0n1X1pAi2z01OLMECqZM0IJSQnv
         lDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712408468; x=1713013268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hzW4szNi17LncifpeJF0JAR4gKXduE2nrvj/0wk1eU=;
        b=aZoBoDgL2O/8mspBp70K5R67BIhXZH0LAEgHIfEFxebvL9uSpaMAGRYvywBO0TCKB0
         mwvCRtehQxiTxur1txsc0+Nn4C9vSrPPZBC8wtLXTI2CYfW4rNFKXol8kwJMu8YeLYd7
         jQjw0c7KlVMFGKzKAEQbdsgxeiQQ05lYjHpnXhthphlVRAuFfWmvOFIxrM4r8bAXSQII
         ddkbhCTi+E1fXz5sfqTN91fm85eXbmIz1hOIg16c7deelimKkLlB4UnP1ZPlKINXPl8e
         gVGYsU18NDSzEPihy7x/m7j0ZxGdCCcC7Vy8+Pcq2j3jbrnw1cVR2ADHgb/PDF0pvOlU
         /Ugw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ7YxqBsZ6eb2xKmho2NSgFRrANQnanTLz64PsT5xmXn7gTSmd2td3Pq/1SerNvm5Ex9SmiWOA/RqoqMEo86yMDZYBksI8sDqjwfuVnjAozQJOgjwcKdwT+Opa5VUlZ01crySVbFwoS/NlAaw=
X-Gm-Message-State: AOJu0YzECtKaOHzCKhDH8UoVieGhEBNqsaZo87Uws66OX7wuLAol5HNH
	m2w8X/4oxLr5PO2dWk1OWlpLCblLw+5qnGgMDJdYEI37S9uDrgYzys/vje/T
X-Google-Smtp-Source: AGHT+IHTBq7s7Ctd7ICE1g+Zh8tMCf4Rbdr9eHdmEu8eeBZCcQAZIGQ+AfkCYjeMGU9r0CGx86yZtA==
X-Received: by 2002:a17:90a:6884:b0:29d:dd93:5865 with SMTP id a4-20020a17090a688400b0029ddd935865mr2985885pjd.46.1712408468540;
        Sat, 06 Apr 2024 06:01:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090a0d0f00b002a24886fa5asm5359850pja.36.2024.04.06.06.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 06:01:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 6 Apr 2024 06:01:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Judith Mendez <jm@ti.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH v2] watchdog: rti_wdt: Set min_hw_heartbeat_ms to
 accommodate 5% safety margin
Message-ID: <a148e8ab-f502-45ec-b915-22fce751ad64@roeck-us.net>
References: <20240404153319.1088644-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404153319.1088644-1-jm@ti.com>

On Thu, Apr 04, 2024 at 10:33:19AM -0500, Judith Mendez wrote:
> On AM62x, the watchdog is pet before the valid window
> is open. Fix min_hw_heartbeat and accommodate a 5% safety
> margin with the exception of open window size < 10%,
> which shall use <5% due to the smaller open window size.
> 
> cc: stable@vger.kernel.org
> Fixes: 5527483f8f7c (" watchdog: rti-wdt: attach to running watchdog during probe")
> Signed-off-by: Judith Mendez <jm@ti.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/rti_wdt.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
> index 8e1be7ba0103..0b16ada659cc 100644
> --- a/drivers/watchdog/rti_wdt.c
> +++ b/drivers/watchdog/rti_wdt.c
> @@ -92,7 +92,7 @@ static int rti_wdt_start(struct watchdog_device *wdd)
>  	 * to be 50% or less than that; we obviouly want to configure the open
>  	 * window as large as possible so we select the 50% option.
>  	 */
> -	wdd->min_hw_heartbeat_ms = 500 * wdd->timeout;
> +	wdd->min_hw_heartbeat_ms = 550 * wdd->timeout;
>  
>  	/* Generate NMI when wdt expires */
>  	writel_relaxed(RTIWWDRX_NMI, wdt->base + RTIWWDRXCTRL);
> @@ -126,31 +126,33 @@ static int rti_wdt_setup_hw_hb(struct watchdog_device *wdd, u32 wsize)
>  	 * be petted during the open window; not too early or not too late.
>  	 * The HW configuration options only allow for the open window size
>  	 * to be 50% or less than that.
> +	 * To avoid any glitches, we accommodate 5% safety margin, with the
> +	 * exception of open window size < 10%.
>  	 */
>  	switch (wsize) {
>  	case RTIWWDSIZE_50P:
> -		/* 50% open window => 50% min heartbeat */
> -		wdd->min_hw_heartbeat_ms = 500 * heartbeat;
> +		/* 50% open window => 55% min heartbeat */
> +		wdd->min_hw_heartbeat_ms = 550 * heartbeat;
>  		break;
>  
>  	case RTIWWDSIZE_25P:
> -		/* 25% open window => 75% min heartbeat */
> -		wdd->min_hw_heartbeat_ms = 750 * heartbeat;
> +		/* 25% open window => 80% min heartbeat */
> +		wdd->min_hw_heartbeat_ms = 800 * heartbeat;
>  		break;
>  
>  	case RTIWWDSIZE_12P5:
> -		/* 12.5% open window => 87.5% min heartbeat */
> -		wdd->min_hw_heartbeat_ms = 875 * heartbeat;
> +		/* 12.5% open window => 92.5% min heartbeat */
> +		wdd->min_hw_heartbeat_ms = 925 * heartbeat;
>  		break;
>  
>  	case RTIWWDSIZE_6P25:
> -		/* 6.5% open window => 93.5% min heartbeat */
> -		wdd->min_hw_heartbeat_ms = 935 * heartbeat;
> +		/* 6.5% open window => 96.5% min heartbeat */
> +		wdd->min_hw_heartbeat_ms = 965 * heartbeat;
>  		break;
>  
>  	case RTIWWDSIZE_3P125:
> -		/* 3.125% open window => 96.9% min heartbeat */
> -		wdd->min_hw_heartbeat_ms = 969 * heartbeat;
> +		/* 3.125% open window => 97.9% min heartbeat */
> +		wdd->min_hw_heartbeat_ms = 979 * heartbeat;
>  		break;
>  
>  	default:
> 
> base-commit: 860bbe8e618fd62446309e286ab4a83d38201c0a
> -- 
> 2.43.2
> 
> 

