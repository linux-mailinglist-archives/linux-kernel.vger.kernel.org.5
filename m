Return-Path: <linux-kernel+bounces-5503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFC1818B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7919C286D7C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E621C1CABF;
	Tue, 19 Dec 2023 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PtMHchdS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4840D3456C;
	Tue, 19 Dec 2023 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703000492; x=1734536492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UZ7LvyivSueEAM7MAiZ7KtzVMUOrn3bCVp4/8Q3XqY0=;
  b=PtMHchdSroO3KSPwoy+wBmfLLxTB6f29QYFcNtg1SK5suTgukN4izx6i
   XNFhnCarBQprQhCluAXxpSXj/gvZmv6tH/hOD68a5sbb/vz/syCgVDFko
   tqs7piAJ3tVxgD+m0oEGYdlVqnDYeQZ/XJuLxxG/3HUbCf7AfyRRNm1OF
   yXzuVyd3Pwvp24/7DiNG4s30RuQNNFXHVBZJo6FIeJ5ZNCRHWFzAVf1kD
   LijlrzM20LRwBiTkAaA6XUTICnu/+lI/Ehd57W66JAMlL3poeB8zzXD3r
   8adjulOStGMpQ3mjg11lPUOXyntGwtHEPfQfdVIozWQTBIRcKHCB0XkRa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="380660571"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="380660571"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:41:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="949206515"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="949206515"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:41:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rFcDl-00000007Ibg-3TvI;
	Tue, 19 Dec 2023 17:41:25 +0200
Date: Tue, 19 Dec 2023 17:41:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] iio: pressure: change driver for Honeywell MPR series
Message-ID: <ZYG5pZaDN11eht7A@smile.fi.intel.com>
References: <20231219130230.32584-1-petre.rodan@subdimension.ro>
 <20231219130230.32584-3-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219130230.32584-3-petre.rodan@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 03:02:21PM +0200, Petre Rodan wrote:
> ChangeLog
>  - rewrite flow so that driver can use either i2c or spi as communication bus
>  - add spi driver (tested on MPRLS0015PA0000SA)
>  - add pressure-triplet property that automatically sets pmin, pmax
>  - fix transfer-function enum typo based on previous review [1]
>  - fix interrupt example in binding file (FALLING -> RISING edge)
>  - indentation changes based on previous code reviews
>  - renamed mpr_read_pressure to mpr_read_conversion since the sensor is
>    supposed to also provide temperature measuremets
>    (but I think mine is broken since the raw temperature value is always
>    0x800000 - so temp reading not currently implemented)

Changelog...

> I've been told in the past that the use of mutexes is redundant in these cases
> so please assess if the guard() from the driver code is required or should be
> removed.

A comment...

> patch uses device_property_match_property_string() from the 'togreg' branch

Another comment...

> [1]: https://lore.kernel.org/lkml/20231116-grudge-hankering-b7a71d831b93@squawk/T/

Some Link: (should it be a tag?)...

Where is the commit message? Or is this just an intermediate change
to show what will be in the next version? I'm confused.

-- 
With Best Regards,
Andy Shevchenko



