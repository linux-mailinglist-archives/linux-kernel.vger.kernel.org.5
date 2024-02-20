Return-Path: <linux-kernel+bounces-73474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077F785C312
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E8D1C20A66
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F747764D;
	Tue, 20 Feb 2024 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TLw+J6iR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83E676C89;
	Tue, 20 Feb 2024 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451676; cv=none; b=pBi+5CoQUJSiugbQXgftwB4XbHZ5qWaz6B4fsRDg6hEwXjZpFMrLMIeBTFl2QkRSRggTpTYcnLzi5VWKcG9/aJah/D0DsIaXIGMnLwjfjpDZdKWTSPpHDTx4J5cQ1i+QkiqjzaBO/fyWz/4O07c7vbZ3hJNCKR1jlDy878a0Vcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451676; c=relaxed/simple;
	bh=SU2u/s6J2tyjUDgWrjhHiv9l7XN4N9C8xBDwaAaElWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiRwstmUVkMWlZR/ZMah+s5IkpRVLzcG0JG5C1iqXfgmVmLOYHZWzhyNxqLw86d1DBuBX4bF9vlAtoTlF0SSxbqTL0/ioVVL6ANeOFWAbILmGFcFoBl/sI/NYnU2oRK6Tnjv5B7EfHhtvhDt9xdIyNiwjT5Rk2L5MYiXxisjhQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TLw+J6iR; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708451675; x=1739987675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SU2u/s6J2tyjUDgWrjhHiv9l7XN4N9C8xBDwaAaElWM=;
  b=TLw+J6iRFoYm1w+KZWA+5DXmGtxbs+Nt1L6DubldD/CRDx+dWA9GfFYU
   fXKWlIrR9Eq8iBsB1hloGQ6jqG03GH6Tr+NnJNlzsvF3izSzKm6mHy2q3
   ZNFjVKD+DyQxCNHvETj8oQF2g+lLAEPQFK3Y5ROReJkrT2l+ydoJlOC5+
   f7SYCmG4yQKHVtNoRqBpHZHihOkk5Iq2tr+2Lr9o/nD0UZ/Xh9ROkCFal
   3yAVEaNTa/nOgGrlmZiC1aSVDwhERcTLhnrRefg4qgfc5cUGaQj5jCsG0
   O86x6BEis9FlT/PcgFtIWYiCU3fIVlmPE/ZboE1khrDCxssglhRmJchaa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="3036198"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="3036198"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 09:54:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="913117010"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="913117010"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 09:54:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rcUK5-000000069Jq-2QFA;
	Tue, 20 Feb 2024 19:54:29 +0200
Date: Tue, 20 Feb 2024 19:54:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: pressure: Fixes BMP38x and BMP390 SPI
 support
Message-ID: <ZdTnVUlsME7gtvrf@smile.fi.intel.com>
References: <20240219191359.18367-1-vassilisamir@gmail.com>
 <ZdSyljwOyxIY7Gvb@smile.fi.intel.com>
 <20240220174624.GA27576@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220174624.GA27576@vamoiridPC>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 20, 2024 at 06:46:24PM +0100, Vasileios Amoiridis wrote:
> On Tue, Feb 20, 2024 at 04:09:26PM +0200, Andy Shevchenko wrote:
> > On Mon, Feb 19, 2024 at 08:13:59PM +0100, Vasileios Amoiridis wrote:

..

> > >  #include <linux/spi/spi.h>
> > >  #include <linux/err.h>
> > >  #include <linux/regmap.h>
> > > +#include <linux/bits.h>
> > 
> > I see that it's unsorted, but try to squeeze a new header to the better place
> > where more will be kept sorted. With given context, it should go before all
> > others, but it might be even better location.
> 
> So you would suggest a re-ordering of the headers with a reverse
> christmas-tree?

No. Alphabetically.

-- 
With Best Regards,
Andy Shevchenko



