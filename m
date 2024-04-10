Return-Path: <linux-kernel+bounces-138999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DFC89FD41
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91172282D57
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0236017BB0F;
	Wed, 10 Apr 2024 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FafD7C/o"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC8117B4F6;
	Wed, 10 Apr 2024 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767265; cv=none; b=GfMEVBmx6oUIO3tm2czeCC4n/B6gB0DlAU9Ie5Nac3ePJEbFHDHCm/7FK3SIK+n1JAM1/p/TEOk0DIq0xtaevikG8HKlz8REXNWPLh+DotXxKT3EMbODMEElVKpE1N6aX2zui0aRlm4RvgK9Ax2VO3C+KJe2s+1+9w+3q/b/b1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767265; c=relaxed/simple;
	bh=gyUOEvG2geChTm/oeSZMe6w/N5aaGU+aeD53TG+VGYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJ0+l0bkjZKrzcgLEda2J4d4ksXAeU2Wu7wALnCFONifgaM1/zNDJ2VSDF1r/W/HskVwyaW0tLTh+dAg++qhbeC54G+6LlpUzagkRH+33olL7mOCwyWF84S04atcI4zpM/hYlnfWm41+wIqxOSQ3NA/lIB1siIX555GcV2gK8IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FafD7C/o; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed9fc77bbfso1282608b3a.1;
        Wed, 10 Apr 2024 09:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712767263; x=1713372063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qWIhumDemlWY5xx42vCKvn/zObEYsNiRwCWHZ5O753k=;
        b=FafD7C/oNGv4FKsWO89VKdApn8LefHyhtfiD68EWLpnYExTH4QGgdozzSniia/12we
         yE1g/BjX24y2d8fFtfc7HN/TgyDsSYR0htdHrAgjcNQQpGzjxlr1SHKt2Q2CeFFXK+TE
         v7HqRBEaZCA8NNAIEF5AVQe5NXNM3sh4Mm7p+OiK+Ez7ijGigT8A4uQBTWktAApnPL+p
         6kiYz5XG6kgXXlax6dYt/DRwEXwEvjk2MzFgGVYCr0gcAYrfOvLkFuw5Ha+CiUn4PEpW
         cthy8tvAzTQ8SW+WpB4P5pE8Y3fxhq8vtabsVtLs1CBQM7VuwesdaixX57V/2Qj140Ec
         uw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712767263; x=1713372063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWIhumDemlWY5xx42vCKvn/zObEYsNiRwCWHZ5O753k=;
        b=PWvNmmpKcP5Bwm4AZNGU/r2d2CAckMZY3eUzbIRapqDChENEiTWcUayMH6Ti8iewyC
         227Ssw4Bi/TU7c60sihHkBXkzm51UDW4yhGrIuF+WPKfDnJPVWuNagqq6hS+3ti8CQhS
         0WQu9CAK81g2cpvIZLnMyfmKKhDclFvL2U+rJaRxJNaJsOuZM1Jj7fAMzCggNMdtH+hV
         o10iMJwfBGFCSCQZISsb6xtMLxw822C592IeciITRz8jZ7pG53n3k5IrHhaHOowb0xNI
         dmLcko7vMIKRygcp+WAzo83+FwdVTbSYVBClYzlSlQVZ1vvw0Tlu7bC8IiRO/f77bjeq
         Ri3g==
X-Forwarded-Encrypted: i=1; AJvYcCWoVSGpJo3mYrfkfuHpjpXLQNyeUgdVS6jU3fgiljRh1LMoPf8H4vX2LbNrNLZRRqPnI+VGkF7wctaWWZxZmQ5zi1zEtAHWxfTo0SZM7kfEKjz1Z6IB/1/LSSG57I16UxKJsoxq0gFmiZ41spHCG+49rzX5e6NGc9kqV0gtV77YPzb5yv9y2yTF09oQKRV2w1UxYDCZTm3AIVM6SasITSzQyd7/mpUHvJ2ntw4=
X-Gm-Message-State: AOJu0Yx4cWjYt9gbDRn4u1ZndQrDbWiCilTtvenC1ABTrJ2WlQ3CnQJk
	Fm4xPRHBO2C3pA1HCYw3pyUE+yMe2ivinsG07YyN47YMz6e1I8Fy
X-Google-Smtp-Source: AGHT+IF4FxuSPGIK0esiegtp9qYT3zyzPxVZaWGE/79Bhfl1d2LziVWOTcufr1tAJ8i5pdcUkqMLjw==
X-Received: by 2002:a05:6a00:b53:b0:6ed:21bf:3420 with SMTP id p19-20020a056a000b5300b006ed21bf3420mr3719757pfo.10.1712767262854;
        Wed, 10 Apr 2024 09:41:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fa12-20020a056a002d0c00b006e694719fa0sm8641562pfb.147.2024.04.10.09.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 09:41:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Apr 2024 09:41:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH RESEND v8 04/10] watchdog: rzg2l_wdt: Check return status
 of pm_runtime_put()
Message-ID: <f77157c1-45b6-40b8-962f-2992717615ac@roeck-us.net>
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
 <20240410134044.2138310-5-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410134044.2138310-5-claudiu.beznea.uj@bp.renesas.com>

On Wed, Apr 10, 2024 at 04:40:38PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> pm_runtime_put() may return an error code. Check its return status.
> 
> Along with it the rzg2l_wdt_set_timeout() function was updated to
> propagate the result of rzg2l_wdt_stop() to its caller.
> 
> Fixes: 2cbc5cd0b55f ("watchdog: Add Watchdog Timer driver for RZ/G2L")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
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
> - propagate the return code of rzg2l_wdt_stop() to it's callers
> 
> 
>  drivers/watchdog/rzg2l_wdt.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> index d87d4f50180c..7bce093316c4 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -144,9 +144,13 @@ static int rzg2l_wdt_start(struct watchdog_device *wdev)
>  static int rzg2l_wdt_stop(struct watchdog_device *wdev)
>  {
>  	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	int ret;
>  
>  	rzg2l_wdt_reset(priv);
> -	pm_runtime_put(wdev->parent);
> +
> +	ret = pm_runtime_put(wdev->parent);
> +	if (ret < 0)
> +		return ret;

Nit:
	return pm_runtime_put(wdev->parent);

would have been sufficient.

Nevertheless,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

>  
>  	return 0;
>  }
> @@ -163,7 +167,10 @@ static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned int time
>  	 * to reset the module) so that it is updated with new timeout values.
>  	 */
>  	if (watchdog_active(wdev)) {
> -		rzg2l_wdt_stop(wdev);
> +		ret = rzg2l_wdt_stop(wdev);
> +		if (ret)
> +			return ret;
> +
>  		ret = rzg2l_wdt_start(wdev);
>  	}
>  
> -- 
> 2.39.2
> 

