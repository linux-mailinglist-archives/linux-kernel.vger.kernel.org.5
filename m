Return-Path: <linux-kernel+bounces-162240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC638B5867
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE24B286B76
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5446E60E;
	Mon, 29 Apr 2024 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YfN9xvJ2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6DC6CDB7;
	Mon, 29 Apr 2024 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393198; cv=none; b=kjWj2T/fXJYUrsezgRj0bM9FWjwEosPstbbLeL3bzEdQZW4+NhlO2nR+prs6OLCmmPkSOTkjR89LW+7pJoY0YlUwb7mlQeu1Hjkn1FrQsSvZ6cg6WVO9mQqwNzLc7D9wl/xF02Z323Q4EoubFe2le5cboCbcTdXhhnd+knv9/FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393198; c=relaxed/simple;
	bh=CjtZnAARk7MKINso2pTgQybSMs6C5wNrBPWS1UNyhEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9y5BXTnKPgTiJlZ0Kouf7dYoPAxH85lyzVKrs9lGLJ7BQd5LpgEbQiXFfsKLezpQii0hQYdxDWaiAOA2XFScTGLAIFKQHtXvreg2+UTg12Yno+HmZwfiQS/i4yeuSlCr2evpxTS2uIty5L5E/ynP3i2Tp1WtkiiDf7E+abHpss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YfN9xvJ2; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714393198; x=1745929198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CjtZnAARk7MKINso2pTgQybSMs6C5wNrBPWS1UNyhEI=;
  b=YfN9xvJ2u7XoDEhwinQb5vQG0+M9BWiMm0nlN2hx4Oxc/TVtc127RKkU
   B2xy7hq2RQb5opgXf+Lm5ecZnpIK0cTRb+COTFkYSvvR5+HEh6ZGLATBX
   IOWBXBs9afsxFU/00V1+A3p5og90UuirsEhbZLbhYin0ZXlF8Oj6J0G7G
   sXefOTAdcT4rDUOMOdNKNGue8XjfzYR/l8jRm6E/os76EIt4WsQIOy22n
   AYx0q4H9wl9YZPlZEcZsj3nvpw9P2RFKetWoDq9Mc0BI7UPfjZYEvVAoj
   Z/5cqlwDNTU+szy2gYEDLir2/MMR5VkcXFQpQ3zW6C5GlCrXG2eNSfHfA
   A==;
X-CSE-ConnectionGUID: AGwHbl2cTJ+gFqL37r4uCw==
X-CSE-MsgGUID: Suql+Y3WTreQorJX4dBLqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10213654"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="10213654"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:19:57 -0700
X-CSE-ConnectionGUID: vyCOCsvpTuyxEkTv0uZI+A==
X-CSE-MsgGUID: BeR9vZjTQTSfzUNPU3CIBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26169766"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:19:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s1Pz5-00000002KT3-0EnX;
	Mon, 29 Apr 2024 15:19:51 +0300
Date: Mon, 29 Apr 2024 15:19:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
	David Lechner <dlechner@baylibre.com>, Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1 1/1] drm/ili9341: Remove the duplicative driver
Message-ID: <Zi-QZmwa1kIAv0sP@smile.fi.intel.com>
References: <20240425124208.2255265-1-andriy.shevchenko@linux.intel.com>
 <20240425-perky-myrtle-gorilla-e1e24f@penduick>
 <ZipxEk9Lpff1kB7b@smile.fi.intel.com>
 <20240429-gorgeous-beetle-of-downpour-492bbd@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429-gorgeous-beetle-of-downpour-492bbd@houat>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 29, 2024 at 01:39:06PM +0200, Maxime Ripard wrote:
> On Thu, Apr 25, 2024 at 06:04:50PM +0300, Andy Shevchenko wrote:
> > On Thu, Apr 25, 2024 at 04:58:06PM +0200, Maxime Ripard wrote:
> > > On Thu, Apr 25, 2024 at 03:42:07PM +0300, Andy Shevchenko wrote:
> > > > First of all, the driver was introduced when it was already
> > > > two drivers available for Ilitek 9341 panels.
> > > > 
> > > > Second, the most recent (fourth!) driver has incorporated this one
> > > > and hence, when enabled, it covers the provided functionality.
> > > > 
> > > > Taking into account the above, remove duplicative driver and make
> > > > maintenance and support eaiser for everybody.
> > > > 
> > > > Also see discussion [1] for details about Ilitek 9341 duplication
> > > > code.
> > > > 
> > > > Link: https://lore.kernel.org/r/ZXM9pG-53V4S8E2H@smile.fi.intel.com [1]
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > I think it should be the other way around and we should remove the
> > > mipi-dbi handling from panel/panel-ilitek-ili9341.c
> > 
> > Then please do it! I whining already for a few years about this.
> 
> I have neither the hardware nor the interest to do so. Seems it looks
> like you have plenty of the latter at least, I'm sure you'll find some
> time to tackle this.

Hmm... Since the use of Arduino part in panel IliTek 9341 is clarified
in this thread, I won't use that, but I have no time to clean up the mess
in DRM in the nearest future, sorry. And TBH it seems you, guys, know much
better what you want.

FYI:
The drivers/gpu/drm/tiny/mi0283qt.c works for me (the plenty of the HW
you referred to).

TL;DR: consider this as a (bug/feature/cleanup) report.

-- 
With Best Regards,
Andy Shevchenko



