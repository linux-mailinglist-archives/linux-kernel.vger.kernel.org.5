Return-Path: <linux-kernel+bounces-151121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877FE8AA95F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C3C1C21815
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6614596B;
	Fri, 19 Apr 2024 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0wBlOj8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7264314E;
	Fri, 19 Apr 2024 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713512452; cv=none; b=u1hxX2aLGqAXOj05puBAIWFZ5PjyztumGnN8gNhkWVW4iGm1E7T65k/Tv2adThAgI/+uDSYaSCVimaYMq2NelXx/0z8oDFKkvZxbdK3vb3Q5IKbfutgydy6b9+sSh3rRv3mwF91CsS5uSx+imcvdH5XGGFnHL25/VBNJRpm31II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713512452; c=relaxed/simple;
	bh=qZOTaYe15U2NKYw7NsaWXXCCYXLgb92jG31Z6M7FrEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZebpEDOFio3kJckwHg3LaoVbnE7w8SuZTPvRuWC1lgt98MQnKfBTWKzfPjUHEyMCN8286qFgYkQgIwTU2QaItLLdtQK4zIlJy0/GNxvufCvmfntzlb3zcJgYaMl59dO0QsOb3YG12SX9aRN/fbRU0N4V9E8SZmJah+xptqZw4uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0wBlOj8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713512451; x=1745048451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qZOTaYe15U2NKYw7NsaWXXCCYXLgb92jG31Z6M7FrEI=;
  b=F0wBlOj8cc4DJJX2V06Vf/Ey3ScrT9HhdR5akMuwCPwpX/peJF4OAgVF
   fAlkGiNInLGfU145qUZEr0aU5aIkYiMY2fl6TgvYyi2j1oHcGA4Z1ycVe
   naWk6V5pMao+eFCU9zOVFMDOg51Cq/IgvTP7oCqPgI0209MAWZMp8XUN8
   4URKmJe06UpFYhB8NMQ20MKq9o4ytLj9XF/vUG3o3C7zmQsen0rqBvRlD
   BiPqtdfpU89TnZSb1SFtNsMnURMql/wuqAeQWBAaHM1JmPHHgLlkxbl96
   xcpVPX5phKzB3Wuum5Ko9q0Z3ZsVJl81VW26uhoXSC5tjwzVzzeVpKtge
   w==;
X-CSE-ConnectionGUID: BDmnLdu1ReufYVBW55Q5ug==
X-CSE-MsgGUID: azS5vRgdQ8eSz41WlRzW5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19711393"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="19711393"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 00:40:50 -0700
X-CSE-ConnectionGUID: YIAcryn5RWuUzXu2oFTlNg==
X-CSE-MsgGUID: DamULQioR/2laquRHHXpaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23233044"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 19 Apr 2024 00:40:48 -0700
Date: Fri, 19 Apr 2024 15:35:34 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Subject: Re: [PATCH v1 1/1] fpga: ice40-spi: Don't use "proxy" headers
Message-ID: <ZiIexi02eCIGQtib@yilunxu-OptiPlex-7050>
References: <20240415142428.853812-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415142428.853812-1-andriy.shevchenko@linux.intel.com>

On Mon, Apr 15, 2024 at 05:23:28PM +0300, Andy Shevchenko wrote:
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.

> ---
> 
> This is a replacement of previously sent:
> fpga: ice40-spi: Remove unused of_gpio.h
> fpga: ice40-spi: Remove redundant of_match_ptr() macros
> 
>  drivers/fpga/ice40-spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
> index c0028ae4c5b7..62c30266130d 100644
> --- a/drivers/fpga/ice40-spi.c
> +++ b/drivers/fpga/ice40-spi.c
> @@ -10,8 +10,8 @@
>  
>  #include <linux/fpga/fpga-mgr.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of_gpio.h>
>  #include <linux/spi/spi.h>
>  #include <linux/stringify.h>
>  
> @@ -199,7 +199,7 @@ static struct spi_driver ice40_fpga_driver = {
>  	.probe = ice40_fpga_probe,
>  	.driver = {
>  		.name = "ice40spi",
> -		.of_match_table = of_match_ptr(ice40_fpga_of_match),
> +		.of_match_table = ice40_fpga_of_match,
>  	},
>  	.id_table = ice40_fpga_spi_ids,
>  };
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 

