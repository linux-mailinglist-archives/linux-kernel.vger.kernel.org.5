Return-Path: <linux-kernel+bounces-95854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCE387541B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BF18B2492A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A91012FB25;
	Thu,  7 Mar 2024 16:21:54 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67161E878;
	Thu,  7 Mar 2024 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828513; cv=none; b=szWAYOjRimaCdJyMDVn3J00MTd04Pu42UU+YzmST22kBIKXz0cvH6yWbw/58ZVGAjFMuZhQl9v6TwDhTV+NiKAxhcXOykcTwHf/RHawFHNcpZdyI/U8+d0e4FJTAvuPKLYAG5/rq+wZbw1VGb7s9yivYBoqC7kKweqonT4ty32c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828513; c=relaxed/simple;
	bh=6IZfI0/bsHGNTFF4mSjGwdRGMcsWxvZOAvoR8ODH7tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HG4+QALwu2wSkj2uEnanzn9529e+ILt3pWXh9o80kN2VVlcR/l/A6J4F79izxTFICsnOQidl4lKk7gGxApAPXmOkP2T8BvcAN75zFlKDtwxtqEmpP46MQBkdmqrxX61h2R8ys9nU4bGnaHiXCNktjc/kVU01wA3NqCnMqAzRKWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1riGV3-0003H9-00; Thu, 07 Mar 2024 17:21:41 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 6D4AEC066F; Thu,  7 Mar 2024 17:21:31 +0100 (CET)
Date: Thu, 7 Mar 2024 17:21:31 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Crispin <john@phrozen.org>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>
Subject: Re: [PATCH v1 1/1] MIPS: ralink: Remove unused of_gpio.h
Message-ID: <Zenpi9mNGJxfTU11@alpha.franken.de>
References: <20240304175439.1199865-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304175439.1199865-1-andriy.shevchenko@linux.intel.com>

On Mon, Mar 04, 2024 at 07:54:39PM +0200, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/mips/ralink/timer.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/ralink/timer.c b/arch/mips/ralink/timer.c
> index fc503679a93d..8b485cbe854e 100644
> --- a/arch/mips/ralink/timer.c
> +++ b/arch/mips/ralink/timer.c
> @@ -9,7 +9,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
>  #include <linux/timer.h>
> -#include <linux/of_gpio.h>
>  #include <linux/clk.h>
>  
>  #include <asm/mach-ralink/ralink_regs.h>
> -- 
> 2.43.0.rc1.1.gbec44491f096

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

