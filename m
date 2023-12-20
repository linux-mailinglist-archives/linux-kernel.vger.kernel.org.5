Return-Path: <linux-kernel+bounces-7025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E8781A0A0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173981C23561
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D18374FE;
	Wed, 20 Dec 2023 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2DHSkyS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AF738F8B;
	Wed, 20 Dec 2023 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703081016; x=1734617016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=73XKsW1ZgCZGQbP0ufu1p+PpSauwCpYAIatA4xw2yCo=;
  b=E2DHSkySCm+fvXY9pAQ+AGNGkuGCJ9N8fFQg6odXqEQ4XrdY5yUuo1Tw
   s6G8BRmuCngjk45f3vhU4EsksJMxRviRFDQXSvXjUVtWVModVPNLoMm9O
   9VvXxUnSaglQ0wb04+uhHY+uG94FYl8vqLvP+6KnQpglFKj6ZskTugQN2
   qc/3hCKuEQ+0r2dI+xDdSL55kV6yO2CUTY3CGX89bWORoSry8HvvYKooI
   Aiq5uQ3kZpt0k0eTiDMl0r0KWoDi8JxPREjsnsTz5S/+k5FFYiBQHYidX
   KsmCL749Bnl/7gQHosu6ddKaKc6V4giY3vzRFt9+88xCGE5/6yOIbaQLk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="375306135"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="375306135"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 06:03:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1107734943"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="1107734943"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 06:03:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rFxAY-00000007YLI-15sy;
	Wed, 20 Dec 2023 16:03:30 +0200
Date: Wed, 20 Dec 2023 16:03:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC PATCH] gpiolib: remove extra_checks
Message-ID: <ZYL0MWAQ-frYLnZq@smile.fi.intel.com>
References: <20231219201102.41639-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219201102.41639-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 09:11:02PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> extra_checks is only used in a few places. It also depends on

> a non-standard DEBUG define one needs to add to the source file.

Huh?!

What then CONFIG_DEBUG_GPIO is about?

> The
> overhead of removing it should be minimal (we already use pure
> might_sleep() in the code anyway) so drop it.

...

I agree on might_sleep() changes, but WARN_ON(), see above why.

-- 
With Best Regards,
Andy Shevchenko



