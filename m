Return-Path: <linux-kernel+bounces-18651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B47C82607E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F176B283E47
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EED0847C;
	Sat,  6 Jan 2024 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TyVVyCqT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC30C134;
	Sat,  6 Jan 2024 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704557281; x=1736093281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vqb1BuBpq6ps1wxzqF4mNcJIhHMSXlmXzWIUyPgEXOc=;
  b=TyVVyCqTgxDq1rHkoIaELojADZ8CXLOSqlBcSgges4EWl+ScOSMM5b1t
   f0lU2CjCmpBjrtdBbB8tDuC4SbvPkMiroAiC/+l8mez5VEvcJ+edeVX0Z
   sJAZMtArwyYstx9+5Ehc8bA1UH98Oxa3Bl2g/8VP2fE0Vks9Q7+B4y0fx
   BLU1vj919FRcsXGZ2AYS4oxjBV2Y2QvbBK7TA+puGdV84mtnwWqaMlUhh
   QLc0UgwZfhmevj9T8ZCdT/5Wvr+UHZIxyi9j0cE4C09O2PXHp7OYFNjyo
   ej9DlOx36OcMXy9q/ptlWl3NXZx9ACwJTFe63iey8Z8ZSfVEzkzND9tIJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="388118834"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="388118834"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 08:08:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="784460887"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="784460887"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 08:07:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rM9DH-0000000Bwqt-1dlC;
	Sat, 06 Jan 2024 18:07:55 +0200
Date: Sat, 6 Jan 2024 18:07:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 10/10] iio: pressure: mprls0025pa add SPI driver
Message-ID: <ZZl628UdGQ_Bu2jy@smile.fi.intel.com>
References: <20231229092445.30180-1-petre.rodan@subdimension.ro>
 <20231229092445.30180-11-petre.rodan@subdimension.ro>
 <ZZlyDT0J4n1_YXh4@smile.fi.intel.com>
 <ZZl5rBPOKwvxZAAx@sunspire>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZl5rBPOKwvxZAAx@sunspire>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Jan 06, 2024 at 06:02:52PM +0200, Petre Rodan wrote:
> On Sat, Jan 06, 2024 at 05:30:21PM +0200, Andy Shevchenko wrote:
> > On Fri, Dec 29, 2023 at 11:24:38AM +0200, Petre Rodan wrote:
> > > Add SPI component of the driver.

> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/module.h>
> > > +#include <linux/spi/spi.h>
> > > +#include <linux/stddef.h>
> > 
> > Basically here we need additionally these ones:
> > 
> > device.h
> > errno.h
> > types.h
> 
> ok, I'll add errno.h. the other two are in the shared .h file.

Yes, but it's better to follow IWYI principle. Generally speaking
there is no guarantee that above will be _always_ the case.

Anyway, I leave this to Jonathan.

-- 
With Best Regards,
Andy Shevchenko



