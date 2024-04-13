Return-Path: <linux-kernel+bounces-143528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 181DB8A3A8D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CDF1F224A3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AE31804F;
	Sat, 13 Apr 2024 03:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X1DWx+A5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8028EDDA3;
	Sat, 13 Apr 2024 03:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712977281; cv=none; b=nhhLl56pG14XTFPNhnlvEuFmSIOojVsvDxLeV70yIDchtVlkYTVXb6fPOPgmb0NhvVJdMB+OCDiPvZhgdcQbRlsQFqpSIUstx7M9i6+YmWihULN9OX6WqIfpPGLIoNMclb4VqzlEXtW3MO3nYqj3724mhfeN3tQXmAVse5mDpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712977281; c=relaxed/simple;
	bh=8B4dXVwNsbWRnPA1Cez35bEwsvvRzfY5buFL+zY6i+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SikC6ggkZBlu/PERknBuH+T2+Kb+tLwfUMID5V/6XFXPfERiDcYuc0Q+tBp28u2rt2CUXiiN7pxDGoTBQji3YQkh4EPzAc+RhJHhOpMqs28XPSBk2KK1OmZovR3jT7O+s0U3FV3yDeqcnJu8+IkzQ14NqR4wGCTUWCrwgXXj3Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X1DWx+A5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712977279; x=1744513279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8B4dXVwNsbWRnPA1Cez35bEwsvvRzfY5buFL+zY6i+M=;
  b=X1DWx+A5HIUHw+ZRX+9J2kKwujkZ1+fnLOdyq+mJWU1W95pTiQyL7bxl
   Pb0a8RClLAG7f6lwMWqNSaEvAxZVTBBm4WujiBDpw3zqOpeidG7/21EbF
   QI2/SCrTm/psujf/jgYzC59/uEXlfVjvLhvFUv1Kg3B5ouBe6oM4Xb+/4
   fbHp9kfFVZ0ykQ/qV4Y3qQ4nAn1tU1IeOjG+RBLnWE12Lb1lr1vvTsLTd
   oKf4AW+UOFOyk/nComWdsRiONpY0DVyEerdXTItqMaFKQEvCGTsS5e2bw
   ZJQ84vWZXFfwAoCia6IkmUWkywoondjW/QB75OuPN/9lg/gRqOjhqWO1H
   A==;
X-CSE-ConnectionGUID: BRMHpvZnQf21DBrwCca61w==
X-CSE-MsgGUID: /d2TKY2eROa+6IvMXFz/lQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8303263"
X-IronPort-AV: E=Sophos;i="6.07,198,1708416000"; 
   d="scan'208";a="8303263"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 20:01:18 -0700
X-CSE-ConnectionGUID: c+KL3owMSdGb0EMfyrzRzw==
X-CSE-MsgGUID: mBMPjBoHTzOL81oOd/848g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,198,1708416000"; 
   d="scan'208";a="21388434"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 12 Apr 2024 20:01:15 -0700
Date: Sat, 13 Apr 2024 10:56:10 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v1 1/1] fpga: ice40-spi: Remove redundant of_match_ptr()
 macros
Message-ID: <Zhn0SgGulHq8Bbk3@yilunxu-OptiPlex-7050>
References: <20240412155830.96137-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412155830.96137-1-andriy.shevchenko@linux.intel.com>

On Fri, Apr 12, 2024 at 06:58:30PM +0300, Andy Shevchenko wrote:
> Since the driver hi6421-regulator depends on CONFIG_OF,
                   ^
It is ice40-spi

> it makes no difference to wrap of_match_ptr() here.
> 
> Remove of_match_ptr() macros to clean it up.
> 
> While at it, add missing mod_devicetable.h.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/r/20240412151147.22a059ff@canb.auug.org.au
> Fixes: 5d04660b29fb ("fpga: ice40-spi: Remove unused of_gpio.h")

Since 5d04660b29fb is not merged yet, could you just merge them into one?
Or it breaks bisecting.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/fpga/ice40-spi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
> index 46927945f1b9..62c30266130d 100644
> --- a/drivers/fpga/ice40-spi.c
> +++ b/drivers/fpga/ice40-spi.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/fpga/fpga-mgr.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/spi/spi.h>
>  #include <linux/stringify.h>
> @@ -198,7 +199,7 @@ static struct spi_driver ice40_fpga_driver = {
>  	.probe = ice40_fpga_probe,
>  	.driver = {
>  		.name = "ice40spi",
> -		.of_match_table = of_match_ptr(ice40_fpga_of_match),
> +		.of_match_table = ice40_fpga_of_match,

It works, thanks for quick fix.

Yilun

>  	},
>  	.id_table = ice40_fpga_spi_ids,
>  };
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 
> 

