Return-Path: <linux-kernel+bounces-8407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9937481B6B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E4C1F2578E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FF278E81;
	Thu, 21 Dec 2023 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCxRq+s5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A6978E77;
	Thu, 21 Dec 2023 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703163250; x=1734699250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KVFHOpXbzwoAIXf8gXY9j1kHL/E5YUzBG75/DA7278s=;
  b=DCxRq+s5WlCKpjw6t9s6v4mi8gy55zrQjtJeK2BGVMUtz/3chyIjtZ11
   uMg3ZK62tLqF/NAxTDpImVEfbxOyrEQ4mDFDfWOeW8mLdIe6M22nJig1R
   +QIAn2zfnIz0gX5UeJLyTJ1AlgNWnIAKBzXUAOCht9hmYn3TB0SqxsLZr
   MCLtRpearou33qjpG0fqi3AsD4SVNjEWfMyIu0Du1KrdHV6NHykhq357V
   u0Wztr0HefnME5kMqIgqEQubmZ91L54aJyg3YL0eUfupEV2xeM65uqekA
   WLzBP+EmojUh9bgzRGQJmZN+gDRwaDq6ge2eqxGPNHMpY/xoEpQ8cDE/C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="9351253"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="9351253"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 04:54:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="900098018"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="900098018"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 04:54:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGIYu-00000007r2R-1Glo;
	Thu, 21 Dec 2023 14:54:04 +0200
Date: Thu, 21 Dec 2023 14:54:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 2/2] gpio: sysfs: drop tabs from local variable
 declarations
Message-ID: <ZYQ1a_nQZ1GWg3gg@smile.fi.intel.com>
References: <20231221091547.57352-1-brgl@bgdev.pl>
 <20231221091547.57352-2-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221091547.57352-2-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 10:15:47AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Older code has an annoying habit of putting tabs between the type and the
> name of the variable. This doesn't really add to readability and newer
> code doesn't do it so make the entire file consistent.

...

> +	long gpio;
> +	struct gpio_desc *desc;
> +	int status;

Not fully reversed xmas tree order...

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



