Return-Path: <linux-kernel+bounces-9781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13BE81CB55
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE6F1C216A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C4C200CC;
	Fri, 22 Dec 2023 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OVkPEw0W"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3EB1D52F;
	Fri, 22 Dec 2023 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703255398; x=1734791398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=suVjjCTSnC7KfiQTEv2ADRlfYvstLRrdTQT/YXGwxXo=;
  b=OVkPEw0WEIjviDsQ7sdHAd+gKytYDBve9wLDpo5AkTdOkIl9OwRaztcu
   gefej1jA5G8tl22QzLvEbbueK1r0qs9v4BqWPERjzKnMUw5GuFOrUOuJI
   e+tJxrxEbfIaRNU1D+ODHB3lP3iQ6W3/uCkJR8LYIGiN2r+enbjHl0jQE
   /wqt3ILqDj8jE4A2u3icrVe+/NFJwmBDsK84qgoI2VHUwo9oa0cqIAE/p
   /kh+KrAEUUOcl12i02u3c0F6NTRucm7r20AZ6C/r8rzqDfsm+PZSdrtRE
   70W1i0zN6GndM2cDnSMYvXdE7sqT7nDlAuSFAr4gH2/F5iCNF6JUvbVUr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="376261662"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="376261662"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 06:29:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="950289620"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="950289620"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 06:29:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGgUQ-00000008AkY-2ec4;
	Fri, 22 Dec 2023 16:27:02 +0200
Date: Fri, 22 Dec 2023 16:27:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: split out the uAPI into a new section
Message-ID: <ZYWctoOnMLcPFeKy@smile.fi.intel.com>
References: <20231222141952.16254-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222141952.16254-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 22, 2023 at 03:19:52PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Kent Gibson is the author of the character device uAPI v2 and should be
> Cc'ed on all patches aimed for it. Unfortunately this is not the case as
> he's not listed in MAINTAINERS. Split the uAPI files into their own
> section and make Kent the reviewer.

Cool! Thank you for doing this.
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



