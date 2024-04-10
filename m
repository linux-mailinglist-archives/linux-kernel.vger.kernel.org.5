Return-Path: <linux-kernel+bounces-138994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B22189FD32
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9741C210CD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EFA17B4F7;
	Wed, 10 Apr 2024 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkI1s7wU"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC7217B4F4;
	Wed, 10 Apr 2024 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767160; cv=none; b=F4gbo2MvQZ8kbjy+5sfg7yJ+hCPf3ks0idUTaIHLq1yVBrpEsgxyEa8xh56pkkmLCndGcRLPAOmsgvOGRoffbyu7vFQ1tMC8Vkvv7/0ouY1DgK5Fm0QGqQ2DpPOp2kgTT9EDgcF7ugZcdKIW1fxE3eewVLlhj9N0zlsygvzcoj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767160; c=relaxed/simple;
	bh=F7EB0uoIe0Z99uiJpJ2qYKwMeLrFwet00d7tDRyTw7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4ziLAh+9qdh0eqP9sk3WUEP+YLxgyxl0uAdAqsVP6BfispKCac0Zzf6pMiWSd2mi/TA5kO00XU52fQ9MDoLSeQjTX903FU378mf1zAhCjc02nA7G+TdFXVb7V3EuMvuTuMm5UD3IomHQpqZ3xy0w9tA52U3b8Dj0IhhpmDxud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkI1s7wU; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e782e955adso6477311b3a.3;
        Wed, 10 Apr 2024 09:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712767158; x=1713371958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/p0oE16LLnFc/k0JtjT/H98kgCcsDdphthc5MZHDC0s=;
        b=VkI1s7wUBT6xwv9vBlOJaC7mAuKo6m19cfZziMGqTghtch4T2Sr7uF8RabguvIRgih
         3ri206vldoG+VpLdlmgOSlBOuzYMXwvLlfYfZk193ZY96eBzZHlaDc4TF4mTEiRxgzvT
         IiJeJTZi0Q2Sw0mJ7qg2OIkvH8Jx2mwTwUepj1amGy+riDhVS7TMIPqhZCXx+bkGTR8F
         eq7I6wIOTC8rP+N1EaYm4xOMiYuVOYPYR0PbOtx05p2497/vqhKTotHf+NcI3lTFtVSz
         1/sSLY8u/UjqDCxVP1oCL0k/9rDVb+XQJJ9VhQrmm3YM9RykoG6sei0h4faqht8GCsfg
         fjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712767158; x=1713371958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/p0oE16LLnFc/k0JtjT/H98kgCcsDdphthc5MZHDC0s=;
        b=mHGg20auSvm3Da0Z41bn4UeCiL81r+xmQw4p5nBLCWSNDkBT2mYXXYdwn6wGQL0eXH
         7Mu4hBEQyCfGGT+EQBcRgMOOPlu0HgQGl/7ssbsEJ2dC6l0l3XSZMqFFMWcClM8pfNkO
         TiLswcZrX7FNACdPELp7sB/IkPVeydpw6nXZDCNpNoFLIZJ5gEpAkY2SWN+8cIKG1FOB
         2Li4HkYgFpaq5+f29ZhT+vLEG6lc+vZRIeksG0+fdbJt1gcUDQBVCb4IXvY+1jCsM8k7
         k8V2Wb+LuCHGsVJLt7gN7crjSsqGnwUSm7KgKO3x5xjXgFTEE1o9mn/Okhv+86gK9iRU
         TrrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVocMSf5gUb9RtV3ltiAqEpqLazcnL8/4mUBxkfCq64N/JDt9YdQuLcJlebvbmkl2ZFUzjLbTBa7pNEljr+VZqLU4cd49v+8EGHxQ7mlKDn0yx9sY5Xx3mNAeuWK7wzm8KUxWS+HKHw0RKmF2uVstKsraGlrX3k93vZhDANY2NliRvIEXENJJHN7TeU+xZcD12s7Te2jyfqkw7oV7SO/qXTkELGgL12JtFwWUY=
X-Gm-Message-State: AOJu0Ywcet+akplSx6tS3KkjpkThUGdmdHgBHf2P0KumSRSfV/17oSau
	mTGiJwneTXv1+zTOSZdQ5a74vFH+mt14t07yaJJKDARvEMFlX/Hf
X-Google-Smtp-Source: AGHT+IHJP78p5VDfjsElHW0Xj2QK+5h9eQRUEUY91wxhpATauweTJ5WxDhh9jb56aGvSxc/DoYG6Pw==
X-Received: by 2002:a05:6300:8086:b0:1a7:6894:cec3 with SMTP id ap6-20020a056300808600b001a76894cec3mr3590083pzc.32.1712767158412;
        Wed, 10 Apr 2024 09:39:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902780700b001e0d6cd042bsm11142667pll.303.2024.04.10.09.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 09:39:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Apr 2024 09:39:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH RESEND v8 02/10] watchdog: rzg2l_wdt: Make the driver
 depend on PM
Message-ID: <c14e6884-6141-408c-bafa-fa9d0834e296@roeck-us.net>
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
 <20240410134044.2138310-3-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410134044.2138310-3-claudiu.beznea.uj@bp.renesas.com>

On Wed, Apr 10, 2024 at 04:40:36PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The rzg2l_wdt watchdog driver cannot work w/o CONFIG_PM=y (e.g. the
> clocks are enabled though pm_runtime_* specific APIs). To avoid building
> a driver that doesn't work make explicit the dependency on CONFIG_PM.
> 
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes in v8:
> - collected tags
> 
> Changes in v7:
> - updated the dependency to PM || COMPILE_TEST to be able to
>   compile-test the driver when compiling for a
>   !(ARCH_RZG2L || ARCH_R9A09G011) platform and CONFIG_PM is disabled
> 
> Changes in v6:
> - update patch description
> - fixed the dependency on COMPILE_TEST previously introduced
> 
> Changes in v5:
> - updated patch description
> - added on a new line the dependency on PM and COMPILE_TEST
> 
> Changes in v4:
> - s/ARCH_RENESAS/ARCH_RZG2L || ARCH_R9A09G011 due to patch 1/9
> 
> Changes in v3:
> - make driver depend on PM; with that the "unmet direct dependency"
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/linux-devicetree/202402020445.TOBlFPcS-lkp@intel.com
>   was also fixed
> - adapt commit message
> 
> Changes in v2:
> - this patch is new
> 
>  drivers/watchdog/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index e2439967417a..7b66fe06ac85 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -921,6 +921,7 @@ config RENESAS_RZN1WDT
>  config RENESAS_RZG2LWDT
>  	tristate "Renesas RZ/G2L WDT Watchdog"
>  	depends on ARCH_RZG2L || ARCH_R9A09G011 || COMPILE_TEST
> +	depends on PM || COMPILE_TEST
>  	select WATCHDOG_CORE
>  	help
>  	  This driver adds watchdog support for the integrated watchdogs in the
> -- 
> 2.39.2
> 

