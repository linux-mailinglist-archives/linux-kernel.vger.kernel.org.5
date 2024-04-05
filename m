Return-Path: <linux-kernel+bounces-133692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED6C89A76B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E831C2306B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23452E832;
	Fri,  5 Apr 2024 22:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="qtCsLErb"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402A18493;
	Fri,  5 Apr 2024 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712357530; cv=pass; b=A8lfwy/IVmqVz9/5Zx6cqQQYCjAF16Ltutg7qTIzx8W82avjLRSSTFE3suc6dRCfallQCMmOUJjsfIowFOR2qXkMmIEmhTEEJdQecKaRV01rIpUP9oDeYEOWVJZA/xteBoATxVfTw260FZNiyjaXiEj1eJ+IsnsDkFk+wCj9uvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712357530; c=relaxed/simple;
	bh=lVQpT7gI287yNLOwb11WSr+wtqsVWgldED1z01tKlC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nerhwI8YdKS1kzaE54yaNfNZhUyOubzc0l0qP7dCYUIK7NWCsyIzGlXc7elfB49AKneIcmnw0pcl+7ONrrmSaEugQkX+UxkkbaBcK3isl8mO05yxFrZyQxuN+Hwm4CXuc9hKcUxUmBwFvVTREh1QhEYgemkbQYj1dw2Q2IZY4cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=qtCsLErb; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from darkstar.musicnaut.iki.fi (85-76-140-31-nat.elisa-mobile.fi [85.76.140.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4VBDJG3kNQz49Pyv;
	Sat,  6 Apr 2024 01:51:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712357519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gckUrz0SCu+XWRQEriuA9onZvEGRZT/0z4oi09P0YBA=;
	b=qtCsLErbZKlye03rorfIetGaEeNJr63lq8aWC6/iveF94671aq142WwvY3GVaN65tSnZSj
	aio3fQPVEHdtQd/kmNK+pDByFHBhVUuCtJUbpEyQ9SsXjENm6sn2KDNJxGE+kPP5kc27dq
	H+pnKPTJXztumc+HUy2IdwkUfGVmE3hrkhwi8NYacsO/K1mO0ZOtCG3onPwy/dFkwa3z0M
	Y3jOG0CHtJPeHT97YfVilDF+9gpNHOj0e4sEOYmYOZ5t0myvddiG1nYmshx30fTYeEZ2Jc
	5LRKYVmAzQzJ+Wmtpl62wIxC5ClhnJPvl5fG3aSUViOlgdCyQqNmUCYMc2C56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712357519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gckUrz0SCu+XWRQEriuA9onZvEGRZT/0z4oi09P0YBA=;
	b=gR3YYVQl90krkVAJ1MeIUChwNjIlVMOM4rGfEv93+OOUaOOt/gHBGuKw/sst3v7dRFr8Dh
	DdyphVM4RIqPeuUC9CGmdVz31QEl4c/F7OeH8TKBBl35DqbGykAwq3XvV4ETjGka+8usRx
	+zNmq/E1GP76FWgpcbHqlsftQ0ScEdRDDJ1sk2P9UoQvHjIMlENsgHNtKY8rYi6Tw2KJ0o
	q0SxtX8o3eJgOt406boEsWxZcRE2LgoFbXBCrxDUGUO/l0PbIyCTC1bCKa/UCjCv5b2Omp
	2ziVBp3ThEhTx/rUCpesMjpgG69bNRsyCCUDjd4pCQePz7S1QsTJaED49EQ6VA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712357519; a=rsa-sha256;
	cv=none;
	b=PXEDLBrdndcHLfdKhGNBLLOeNx1Wf47bcQHesWXdNTTKdO7w12lPjmW6MA5O0ealH/s1IJ
	43zt8nTPhKneBpQ6DIs1+VpazCtQFmJq9Xvihcvdb40v6okYu22pSYgaLgkeC4VpqsEkiS
	syQ08EzmcQ/0gjv7D8F1NdNHOjy9AwkadPyzd/pxww8DYP0xcquBjqqfv48LLoAo2m3lNS
	9BQw0DeROzOr8GsfNaiwHRl8rEVm1nB7irB5+MUYsjuUt2728cRdD3UJT1DQVyhL6r/Pp7
	Kmy2p6lXCUDNwRa9gsHX/kBy6hos6EzgcUI+1TIH7dpnnLznLkYRLpcXXUih6Q==
Date: Sat, 6 Apr 2024 01:51:56 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 25/34] usb: gadget: omap_udc: remove unused variable
Message-ID: <20240405225156.GE91663@darkstar.musicnaut.iki.fi>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-26-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080702.3509288-26-arnd@kernel.org>

Hi,

On Wed, Apr 03, 2024 at 10:06:43AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver_desc variable is only used in some configurations:
> 
> drivers/usb/gadget/udc/omap_udc.c:113:19: error: unused variable 'driver_desc' [-Werror,-Wunused-const-variable]
> 
> Since there is only ever one user of it, just open-code the string in place
> and remove the global variable and the macro behind it. This also helps
> grep for the MODULE_DESCRIPTION string.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> ---
>  drivers/usb/gadget/udc/omap_udc.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
> index f90eeecf27de..e13b8ec8ef8a 100644
> --- a/drivers/usb/gadget/udc/omap_udc.c
> +++ b/drivers/usb/gadget/udc/omap_udc.c
> @@ -56,7 +56,6 @@
>  /* ISO too */
>  #define	USE_ISO
>  
> -#define	DRIVER_DESC	"OMAP UDC driver"
>  #define	DRIVER_VERSION	"4 October 2004"
>  
>  #define OMAP_DMA_USB_W2FC_TX0		29
> @@ -110,7 +109,6 @@ MODULE_PARM_DESC(use_dma, "enable/disable DMA");
>  
>  
>  static const char driver_name[] = "omap_udc";
> -static const char driver_desc[] = DRIVER_DESC;
>  
>  /*-------------------------------------------------------------------------*/
>  
> @@ -2299,13 +2297,11 @@ static int proc_udc_show(struct seq_file *s, void *_)
>  
>  	spin_lock_irqsave(&udc->lock, flags);
>  
> -	seq_printf(s, "%s, version: " DRIVER_VERSION
> +	seq_printf(s, "OMAP UDC driver, version: " DRIVER_VERSION
>  #ifdef	USE_ISO
>  		" (iso)"
>  #endif
> -		"%s\n",
> -		driver_desc,
> -		use_dma ?  " (dma)" : "");
> +		"%s\n", use_dma ?  " (dma)" : "");
>  
>  	tmp = omap_readw(UDC_REV) & 0xff;
>  	seq_printf(s,
> @@ -2994,6 +2990,6 @@ static struct platform_driver udc_driver = {
>  
>  module_platform_driver(udc_driver);
>  
> -MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_DESCRIPTION("OMAP UDC driver");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:omap_udc");
> -- 
> 2.39.2
> 

