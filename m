Return-Path: <linux-kernel+bounces-138991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7753A89FD2B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D211F2522D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF8D17B4F9;
	Wed, 10 Apr 2024 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZAZF/g/"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5F753361;
	Wed, 10 Apr 2024 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767127; cv=none; b=fZHtmSiBpS+KhYB9nMeJlsj92OTrZ8BvMOujJhd2FCAwwm1f3kugElTAFUVD5V+V3QuO2GPHOYWD3Uf+0aIW9K5etsDhakWizrFfYVImvAdoUdA9F+Yra1ByW03BscsFzcObxiy3BMeBh3NKES/EoncItoVgL4tNPeQ4NlygsQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767127; c=relaxed/simple;
	bh=ah2mwperXtzYMn0SL/CpwmlBkomRZateERpW6kqvubE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiZN7ckQPa+FWpeDEi9naXJ1+r2rKTMPNj9JKRJSeJyyJdvPVhqNMTTAmtSrmiYTDqzkYAw46ocONwb48BNqu8JVkFiQQp/vNsIJDKJgKw7KtD/QTBi1JpS6XOxFisX3/j9zDxQ9d6N+ymDPzsvOs+SGZazBK8/8E9wOAZGGSoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZAZF/g/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ed11782727so3559523b3a.1;
        Wed, 10 Apr 2024 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712767125; x=1713371925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bH3SH9PZpVdfJLkcWJKtZ9DwpOlnEKGvk93uGkOR/UE=;
        b=IZAZF/g/5EL+z+c3gxX115XgRkEjbNxRuYTEUPnYdGbaqZntBAa/3BgLUeQ/Rns7pH
         2R7k/6WG+ezfvkfuAFA875hM3hjm4GG05SyvygxsBcAHe/NsPWLAC7Y2MAQlxR1cm5qr
         z5w5Caeu09abFjg2An2JUD9iT6BGRNUf3DnnAgKi1MyXIYxwbOoH5dJFp1lf5Gbjl7OX
         7p9csRZ9JpchrQ+/Lii19UcJL+VxFWfSiXtx5DlKk+bF29YjwNQz4qdJ1IHzgtqZlPrN
         BFDUA8LcV/VYRMdRgXG6Fq09ZbO5M8XRAWieM54y2/m6P4VmCbiFwRwU9YPck+mP9240
         nTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712767125; x=1713371925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bH3SH9PZpVdfJLkcWJKtZ9DwpOlnEKGvk93uGkOR/UE=;
        b=vqUAbAq40/on/lLCSOJN9X+IoIGs09xLF/n6vbhKeq0j1of+Ol1ZKAoZAnHKX4onYz
         dXA3Qu7r/bbukWdUbcS9DcyMDCSslN3bHAr8MwgUQS+4KnyT7uJEP9kNWfyYWqH7wd/4
         A6pFelJWZLG295A8PDy/iUo+tLJztSSRATfWSLdJG8NdYLz2tmPfsjbd++jxJmpbKqrB
         rb+fF94vGYJjgVtKjUFHeUFsrLhwhKvj6bVE9pPxOoj+sZB5Bb6fmsfI3f2J0/Ca5UhH
         uAmRkPjMzmsASc4wLEhtVT7uuey5nw+PP/QyNFneRTGPyqzCW4fbTHbrd++3s/Rrewj9
         wMMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMVvc2zxXMQnj/FX/6qXBN504NT+nyKu/mzVxaiDmz2eQ33RC0KZ+8ND61SHEO4aGJVFpS2U5PFxPCJof+SMtDkXgWACCsaqt3Sfv96ipq7WWt6lqSTe+k7MXZu4TGIzGNRLjNDLSN0Bvp7nEE+4JLYmimjx3sux7hEwLSZw46DDeICHrKsf83BxSr+eZ+XZZr7ax/ntuA5PPiFJpMDS9gEpvhSPz6RTPmNUM=
X-Gm-Message-State: AOJu0YwepAsBBKWptmVhwaTsLImpCH6PPJsFds36z+R+l+tWIbwSdO5I
	P06qMzs1n7Vus5/Cf6YjxJHqkChy7DFKuAqtB9jlGug3lPy5zKHk
X-Google-Smtp-Source: AGHT+IHpTRrB1z6wLXvvCfgdEb4HXKeC2BDjzUdZ8l5lBS6gy4LBDOs3+XlqsJQahkr2ASwm5F3Dkg==
X-Received: by 2002:a05:6a21:3b4a:b0:1a7:4b32:1195 with SMTP id zy10-20020a056a213b4a00b001a74b321195mr4093187pzb.61.1712767125263;
        Wed, 10 Apr 2024 09:38:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id lb14-20020a056a004f0e00b006ead47a65d1sm10344716pfb.109.2024.04.10.09.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 09:38:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Apr 2024 09:38:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH RESEND v8 01/10] watchdog: rzg2l_wdt: Restrict the driver
 to ARCH_RZG2L and ARCH_R9A09G011
Message-ID: <d91ff06a-2d7f-4592-a08b-eab54ec272fa@roeck-us.net>
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
 <20240410134044.2138310-2-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410134044.2138310-2-claudiu.beznea.uj@bp.renesas.com>

On Wed, Apr 10, 2024 at 04:40:35PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The rzg2l_wdt driver is used only by ARCH_RZG2L and ARCH_R9A09G011
> micro-architectures of Renesas. Thus, limit it's usage only to these.
> 
> Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
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
> - none; this patch is introduced in v4
> 
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 6bee137cfbe0..e2439967417a 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -920,7 +920,7 @@ config RENESAS_RZN1WDT
>  
>  config RENESAS_RZG2LWDT
>  	tristate "Renesas RZ/G2L WDT Watchdog"
> -	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on ARCH_RZG2L || ARCH_R9A09G011 || COMPILE_TEST
>  	select WATCHDOG_CORE
>  	help
>  	  This driver adds watchdog support for the integrated watchdogs in the
> -- 
> 2.39.2
> 

