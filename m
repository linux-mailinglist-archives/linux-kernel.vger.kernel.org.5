Return-Path: <linux-kernel+bounces-149507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4FF8A9227
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C71A1C21337
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9D6535A2;
	Thu, 18 Apr 2024 04:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNcGa2Cj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9006F548EA;
	Thu, 18 Apr 2024 04:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713415796; cv=none; b=cFQXHt212DCrzKkQm1m7WCH8hBLJYQqRZ0cMc/xsmPtoZtf4J3HXLEKuJSkxnw0hK9GBtMybnO8rORi42UMb4/XrtAwRj4ZpGQL4+1qUZxFls9+j99tqEaGolgqJF/6GWpcgEeuWMtzC8naZprbfUCGiKaE1gWgiQ/nFC6NMA8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713415796; c=relaxed/simple;
	bh=YgfbawDaEosSQPgL5ER2TNOIJpY3m3K6GdM7my7NOvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTFTEwtkKYy2EtcVkbGqWBVht+J+3oas5Hu52ILQU5lFdTRJnESwe6s7CH06qPeN+Dt8NPdqlEVPOFcrzKrnH9zBuQWN5Q6fIMxXAFtfkyrIBeiq7ZdAd2dYM+09Ps8fw21lKi94N7MJ5YBCXZFNiJpNWgxpuOMnEVg6BTXXgXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DNcGa2Cj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713415794; x=1744951794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YgfbawDaEosSQPgL5ER2TNOIJpY3m3K6GdM7my7NOvk=;
  b=DNcGa2CjCaXyB9A3LustnuHdM7UTb0uOcxG7QDkyYj7GEAbI+fO/ad5v
   Hw6nOvAwUkOwwJIY2TDco0MHixJJVJPZrNlFixBzPeyD1qW2DkacidM1l
   3TgvXRg27F1vAzDhYDYO3DR1uZ6tG9kchi9L1uLVGtPqQCrK03ucog/YJ
   u980DmN92mX4xjlinPbuwV/pS2uxHJrdszohPaQ7oP+fC8B9oRfJubSUO
   /KnsfQDkxLYwVJKcNdvzL610zodICWaHOw/KqLmFIU8XePOjA/B2hC4b/
   E/Kn/OgP5llDZ1U7f04iamKri0+DPmrBvXVmTZC3znOodvkqm3yZP9t0l
   A==;
X-CSE-ConnectionGUID: LPnEL1iURNSCA8HnF6Xz1A==
X-CSE-MsgGUID: vrerF21ZT9qcEX8Ymrm6yg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20363074"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="20363074"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 21:49:54 -0700
X-CSE-ConnectionGUID: 1uJNOl/URpqJCu7GMfBidA==
X-CSE-MsgGUID: jGdWLmCmTI6fGQcrvY8OcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="22888101"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 17 Apr 2024 21:49:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 0FC5024D; Thu, 18 Apr 2024 07:49:50 +0300 (EEST)
Date: Thu, 18 Apr 2024 07:49:50 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 2/2] gpiolib: acpi: Set label for IRQ only lines
Message-ID: <20240418044950.GP112498@black.fi.intel.com>
References: <20240417103829.2324960-1-andriy.shevchenko@linux.intel.com>
 <20240417103829.2324960-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240417103829.2324960-3-andriy.shevchenko@linux.intel.com>

On Wed, Apr 17, 2024 at 01:37:28PM +0300, Andy Shevchenko wrote:
> When line locked as IRQ it has no label assigned. Assign
> the meaningful value to it.

Same here.

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 0b0c8729fc6e..553a5f94c00a 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1066,6 +1066,10 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *con_id,
>  			acpi_gpio_update_gpiod_lookup_flags(&lflags, &info);
>  
>  			snprintf(label, sizeof(label), "%pfwP GpioInt(%d)", fwnode, index);
> +			ret = gpiod_set_consumer_name(desc, con_id ?: label);
> +			if (ret)
> +				return ret;
> +
>  			ret = gpiod_configure_flags(desc, label, lflags, dflags);
>  			if (ret < 0)
>  				return ret;
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac

