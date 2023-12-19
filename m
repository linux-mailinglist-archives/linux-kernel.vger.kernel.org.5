Return-Path: <linux-kernel+bounces-5448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED804818ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77679B22E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2A21C694;
	Tue, 19 Dec 2023 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UOdZMV+4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555BF1C683;
	Tue, 19 Dec 2023 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702998406; x=1734534406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AdiZkYtsLmcFfkTur5yB68JwoJ6gI3dBM5pdXd2WIsA=;
  b=UOdZMV+4g1gHxCGi48lkKRW2omQANLdi4iSQ6MqXkIpwpK5OVg331Wos
   /3LhdIG+dPrpBkgdMqZRe8tbyX5R8r6vCVI0nHYqK79p+E+GVHKWEdAo6
   BBecY9GCGl83kFDj+n0EkLLXBoX57EfOk/k5kvVmL7yTStv4b7W7PLG10
   bU899MQxHmdjd1MzHW9jvUBvULlsUuKIRR2RJ60J2wCxoXS4k4bfysy0J
   KI4PQZ8EQLxL1eN0Naoj3U9yN5ODxOpxra9PpKEgTENmhVRCWGQitrqJ3
   zZGppS9TWM8DA0hEeBrbBs3tCTdvWQYaHJZzUdq+3Iem16lWTJQYxOhOR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2523107"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="2523107"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:06:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="1107381606"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="1107381606"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:06:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rFbg1-00000007IAN-46Bj;
	Tue, 19 Dec 2023 17:06:33 +0200
Date: Tue, 19 Dec 2023 17:06:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/2] gpiolib: drop tabs from local variable declarations
Message-ID: <ZYGxefhI9UpwknhD@smile.fi.intel.com>
References: <20231219142323.28929-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219142323.28929-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 03:23:22PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Older code has an annoying habit of putting tabs between the type and the
> name of the variable. This doesn't really add to readability and newer
> code doesn't do it so make the entire file consistent.
> 
> While at it: convert 'unsigned' to 'unsigned int'.

Not a big change to be a burden for backporting I suppose.
Code wise looks good to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +	struct gpio_chip *gc = desc->gdev->chip;
> +	int ret;
> +	unsigned long flags;
> +	unsigned int offset;

I'm wondering if you can make it reversed xmas tree order.
This will make it even more consistent between functions.

...

> +	bool ret = false;
> +	unsigned long flags;
> +	struct gpio_chip *gc;

Ditto.

...

> +	struct gpio_chip *gc = gdev->chip;
> +	struct gpio_desc *desc;

(okay with above, but...)

> +	unsigned int gpio = gdev->base;

> +	int value;

Ditto.

> +	bool is_out;
> +	bool is_irq;
> +	bool active_low;

And ditto.

-- 
With Best Regards,
Andy Shevchenko



