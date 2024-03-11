Return-Path: <linux-kernel+bounces-98889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29F18780B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB671C2178A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560663FE3D;
	Mon, 11 Mar 2024 13:33:58 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6843FBAA;
	Mon, 11 Mar 2024 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164037; cv=none; b=MC3lopgx619PKr2uYtRK/eSwp3FoJQHrU5olB3HktZfk65LREBOcGRbinbDpnNxblDzAbCzQhiBywwxVQrxxIRsXHuDGhvgtIEu+nUJDcTmjPPj0pcH2EOEUAzhN2cbJpR1Ym64wo9u5rItCgL3WmhFOm/K8l4IGN42RX/alGsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164037; c=relaxed/simple;
	bh=jbChsX0Vv02KbcvaxVwtHitTmsAunq+PkpTTsi6JQXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0wjtSNpvQjbyfb66qZz9WezDtBVy6O/NVri0+M14a5iCilqhUVouUkxeekZDEvxssG19JrfY+rvcIu6W0inC3VuKhsfRtnxFbtjUl4diWvzsaGkC/ZX1dfFs7apMEkZKk9wKajenkAgA7AssQTYgGY0zZ6CCZ6zOREBzaOvcDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rjfO1-0001bc-00; Mon, 11 Mar 2024 14:08:13 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id AF265C0267; Mon, 11 Mar 2024 14:04:22 +0100 (CET)
Date: Mon, 11 Mar 2024 14:04:22 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Crispin <john@phrozen.org>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] MIPS: ralink: Don't use "proxy" headers
Message-ID: <Ze8BVniIPeFNzmRA@alpha.franken.de>
References: <20240311094559.547083-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311094559.547083-1-andriy.shevchenko@linux.intel.com>

On Mon, Mar 11, 2024 at 11:45:58AM +0200, Andy Shevchenko wrote:
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
> 
> Fixes: 5804be061848 ("MIPS: ralink: Remove unused of_gpio.h")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202403090727.nLhljNp6-lkp@intel.com/
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/mips/ralink/timer.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/ralink/timer.c b/arch/mips/ralink/timer.c
> index 8b485cbe854e..54094f6e033e 100644
> --- a/arch/mips/ralink/timer.c
> +++ b/arch/mips/ralink/timer.c
> @@ -6,10 +6,16 @@
>   * Copyright (C) 2013 John Crispin <john@phrozen.org>
>  */
>  
> -#include <linux/platform_device.h>
> -#include <linux/interrupt.h>
> -#include <linux/timer.h>
> +#include <linux/bits.h>
>  #include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/timer.h>
> +#include <linux/types.h>
>  
>  #include <asm/mach-ralink/ralink_regs.h>
>  
> -- 
> 2.43.0.rc1.1.gbec44491f096

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

