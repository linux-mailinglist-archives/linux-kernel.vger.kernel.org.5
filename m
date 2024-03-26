Return-Path: <linux-kernel+bounces-119698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D617888CC2F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B28E1F8062D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3ED12DD9C;
	Tue, 26 Mar 2024 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBkWd7Ye"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0938127B5D;
	Tue, 26 Mar 2024 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478659; cv=none; b=IXeBxPxDyRteBlZrxAsJVut41ZQWK1zSfolSmHvRDR3qpDmKGhGA5tqrOFR07VPgXfh0IU2qw4u09r5ip8UWM82gK8gH2Nl8IY+K7s6n1RRPe9KPQw79Nj6wl4uBHqCXTeJdimlgdZJSWaqzsv9XOAJN21TXXa2f0eJ5XqJeMlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478659; c=relaxed/simple;
	bh=HtGjjsjRQdnWthgLMSyv8b/b2MZS5XuZACuOM3RyUWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QN+ml5cmOOfV+tNEI9+SHl6Lfh9ghYYeiKabBVQbrM9/s6SfdW8CLNzf92oG5wI+jXZDgd0NrKF8jW+OLp14Fl7pfGeiwwyZf5d2+Vsr6Rx4M3Bc3v3T6f9+b4CZy2VA8J18nWkZ11Z0JZjs59+mNqRiON4z8qxTDT/W3jjKI7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBkWd7Ye; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711478657; x=1743014657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HtGjjsjRQdnWthgLMSyv8b/b2MZS5XuZACuOM3RyUWU=;
  b=OBkWd7YekTgmLm4pUEC6KsLo/IDZ1tMSHirFbXSS0XXX6B+CnjuvOb72
   QFKLVp8C+zZBtwWqKD13zh8YzOsFBVO89XghiN7LZXU9adsRV7XOeQx4q
   4m5U+fP7tKfddsq/tHyUhdyibbPhKd5PYedUKRBcZXs706xTjKI/lxpGK
   164OumkVZ0EF9g46tBCQ0HIoe+vb0KUUPaIKfo5unVsyIH9XkGoNEzrgx
   bRX2NJrfuNr9v7r3zxTwoY6L9Urs77gJ8DNR/lCcLjJrhto2uVF/pFH6s
   pXU2rQfrf5VG7V54XUWWCUm/4Fr45RMOZ32RQWm2lZtOtP7EpQ/IANpD6
   g==;
X-CSE-ConnectionGUID: SfQFc2DaQQyxz5BJCNTQGg==
X-CSE-MsgGUID: VoCqioXNTpOssNh/BuVt3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="23991804"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="23991804"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:44:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914887769"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914887769"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:44:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rpBmN-0000000GQNu-3rjt;
	Tue, 26 Mar 2024 20:44:11 +0200
Date: Tue, 26 Mar 2024 20:44:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 01/10] spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
Message-ID: <ZgMXe4EMbJ44W1tr@smile.fi.intel.com>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
 <20240326181027.1418989-2-andriy.shevchenko@linux.intel.com>
 <14f08a50-edef-4b36-891e-2b4b2283f40c@sirena.org.uk>
 <ZgMSg5Tr97mWgPW4@smile.fi.intel.com>
 <424de3ed-f0ea-4fc1-80f5-3ab1d23cf1e1@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424de3ed-f0ea-4fc1-80f5-3ab1d23cf1e1@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 06:25:16PM +0000, Mark Brown wrote:
> On Tue, Mar 26, 2024 at 08:22:59PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 26, 2024 at 06:16:28PM +0000, Mark Brown wrote:
> > > On Tue, Mar 26, 2024 at 08:07:51PM +0200, Andy Shevchenko wrote:
> 
> > > > Drop rather useless use of ACPI_PTR() and of_match_ptr().
> > > > It also removes the necessity to be dependent on ACPI and
> > > > of.h inclusion.
> 
> > > I think the ACPI dependency there is as much about hiding the device on
> > > irrelevant platforms as anything else, might be better replaced with an
> > > x86 dependency though.
> 
> > The whole idea behind ACPI_PTR() (which seems following the of_match_ptr()
> > implementation) looks premature. Now we have a lot of patches from DT people to
> > remove of_match_ptr(), i.o.w. make the ID visible even on non-OF platforms.
> 
> > Having the list of supported IDs is not bad thing anyway as it might help
> > to google for a device elsewhere, for example.
> 
> That's nice but I'm not sure what that has to do with the dependency on
> ACPI?

ACPI_PTR() makes ID no-op only if ACPI is defined. That also satisfies
the ugly ifdeffery that is removed by this patch as well. If there is
no dependency we will have compiler warning for defined but not used
variable.

-- 
With Best Regards,
Andy Shevchenko



