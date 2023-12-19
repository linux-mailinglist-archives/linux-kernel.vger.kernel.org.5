Return-Path: <linux-kernel+bounces-5451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48564818AD0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A25B1C23414
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3000C1C2BC;
	Tue, 19 Dec 2023 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/6WGUMJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9231CA91;
	Tue, 19 Dec 2023 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702998473; x=1734534473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VpRVJ1zExz6huDZJ3HmFgTWDVwJK268swtCYqe98ikU=;
  b=E/6WGUMJ2V5Cd5tAvBsaaZ2YBW5qq+AUEEWpMeLeCv+XdvaDxV1TTFlD
   gOG0EPaaJ0Z4SpJ3y68+7s+8jrOu2Qc8e3nx7TOxtl4tZQOqjel2+E1FI
   TrVabELgg5eiVqUW6LyBrozsOFCi/EwZTrwL7+YUR4OnlZYqQbxE68k7v
   uEsMCmdT7LaRufVXqtxnh/mmyA5HKyzbqJRE8DkIMQgzavoRfsRm1jRux
   7sQ+aMDIAe5MD2/a+cD2DCRxf5A6kO6L+KMjlK/1ltAc4rr4sQdoHmMht
   zjkHlG7Mzmovy5thq7rb3nm6jqH41mbASMOeQ1OtY+i0NZzVsYFs977ft
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="375161801"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="375161801"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:07:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="776005017"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="776005017"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:07:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rFbhD-00000007IBc-0qtj;
	Tue, 19 Dec 2023 17:07:47 +0200
Date: Tue, 19 Dec 2023 17:07:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2] gpio: sysfs: drop tabs from local variable
 declarations
Message-ID: <ZYGxwgkngL2c5KE3@smile.fi.intel.com>
References: <20231219142323.28929-1-brgl@bgdev.pl>
 <20231219142323.28929-2-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219142323.28929-2-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 03:23:23PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Older code has an annoying habit of putting tabs between the type and the
> name of the variable. This doesn't really add to readability and newer
> code doesn't do it so make the entire file consistent.

Besides similar comments as per previous patch, see below.

...

> +	struct gpiod_data *data = dev_get_drvdata(dev);
> +	struct gpio_desc *desc = data->desc;
>  	int			status = 0;
>  	unsigned int		flags = data->irq_flags;

???

...

> +	struct gpio_device *gdev;
> +	struct gpiod_data *data;
>  	unsigned long		flags;
>  	int			status;
>  	const char		*ioname = NULL;

???

-- 
With Best Regards,
Andy Shevchenko



