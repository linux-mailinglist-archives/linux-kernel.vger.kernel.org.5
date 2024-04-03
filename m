Return-Path: <linux-kernel+bounces-130258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A57C897609
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDFB1F239DF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCC3152521;
	Wed,  3 Apr 2024 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dULEcOKS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C552152505;
	Wed,  3 Apr 2024 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164437; cv=none; b=FX97sW5gC79mLiTBq9I1WEGbsnAymgNbX0tBiT7v7v5+iJ8Z/KjXWPHc+W8TQA0w+c3LDCMEx/T7wsqgh5soTJOHYoUtFnMZCZzsXZB+DF5IX4ZNdIfEXyxNh8KRfI9klHVWSk0JxHBnV6lRVDS5Fy9VYbM937c7NbRsoIWI0kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164437; c=relaxed/simple;
	bh=TNkWDibBTEIwV1X2Lgomv9lI/EaSLAXMzptGvnPP67I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQfIc961MFSqIlgqYfdXDKJFANl6MPvGr9n0Sp5PNYGNIrj5mV0O093NLBg8EZTiHvbaeJ/PWKKK1tO2CcqnJrVrXpRZlqjbp2dHAS6Nj/NbEsEYT4wyi566FfkRviEAFUjoiTwscNhehFOs7eJ+CM52jvS7a+XJRR+mopm8cy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dULEcOKS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712164437; x=1743700437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TNkWDibBTEIwV1X2Lgomv9lI/EaSLAXMzptGvnPP67I=;
  b=dULEcOKS15LRXC6fQzjUeQWAqewiEPRD9Ag4DpePk1CKg8IEDsL2kJBl
   2P1/g3F+RRxq6UXXVN0zCmdXecH6RBGfDXFunoNN3USdYJqxHufC6Ludl
   U6YXTfvj5Q0RGyeGw8jP6PWH6BLER3nuwfus2NxrzrLoHb2kYw1LlbZC/
   mzZdkQb8+9ui7JaZhC/Qy1i9mN/KnHFdyozXHVnACLtaQNNVKgoDU6kOx
   DYCf0ZqMPIHWbUXcVmPZsi7xGqYu01h2FNF6wxJFSRyuRzsVHYrjFIzTw
   jGmb1SGufGb0EpR3khxgx0CHXkLEAMC962nT3jlKSgnwYEZyKfnvGnopu
   w==;
X-CSE-ConnectionGUID: CAl+pwicSgGAkq/p+7542w==
X-CSE-MsgGUID: qFylQ2p5QSKisEvVjowDNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7529370"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7529370"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 10:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="915189030"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915189030"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 10:13:52 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rs4BK-00000001Ba4-13lW;
	Wed, 03 Apr 2024 20:13:50 +0300
Date: Wed, 3 Apr 2024 20:13:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: (subset) [PATCH v2 0/9] spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h
Message-ID: <Zg2OTvXCUhsk4KVr@smile.fi.intel.com>
References: <20240327193138.2385910-1-andriy.shevchenko@linux.intel.com>
 <171167575036.187521.17547262230962160149.b4-ty@kernel.org>
 <Zg04cWhT_Dl6AUik@smile.fi.intel.com>
 <b7ac20d0-ca45-4e65-92ff-ddf84da6645a@sirena.org.uk>
 <Zg1cAHEkhIf2vpwJ@smile.fi.intel.com>
 <Zg1clCuOwkCNzSgy@smile.fi.intel.com>
 <0af775e1-f5f7-4ad4-b336-78834a9e0342@sirena.org.uk>
 <Zg1qmlX78lQGLC3B@smile.fi.intel.com>
 <48793ea5-92ca-4529-bad0-35d8c4e3f0c8@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48793ea5-92ca-4529-bad0-35d8c4e3f0c8@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 04:50:00PM +0100, Mark Brown wrote:
> On Wed, Apr 03, 2024 at 05:41:30PM +0300, Andy Shevchenko wrote:
> 
> > Linus was long time ago against board files. Yet, we have a few old
> > (kinda supported) boards left in the tree. The conversion makes the
> > driver be prepared for the DT conversion when it happens. From maintenance
> > perspective my patch reduced the code under the maintenance, which reduces
> > time spent by both contributors and maintainers on this.
> 
> > AFAIU all what you are moaning about is type checking. Okay, I got
> 
> The type checking is part of it, but it's more a general taste thing
> with using swnodes like this.  You've not actually removed the board
> file and it's hard to get enthusiastic about the change to the board
> file that results, or to see this as a substantial step towards DT
> conversion for the platform given the trivialness of the single
> property here.  As a general thing I don't want to encourage people to
> start randomly converting things to swnode rather than to DT.

Conversion to GPIO lookup tables is also the same in this sense.
But with it in place, the drivers aren't needed to be touched
when the real conversion happens. I agree, that _ideally_ we should
take that shot, but I am not an expert in DT and it will take a lot
for me to get to the shape, besides the fact of the ARM (platform)
specifics, which I'm far from. So, I prefer do step-by-step approach
if one developer can't fulfill the task. I.o.w. perfect is enemy of
good.

> > it, but we have a lot of other places with similar approach done,
> > e.g. GPIO_LOOKUP*() tables that basically gives something unconnected to the
> > driver without any platform data being involved and you seems to be fine with
> > that:
> 
> > $ git log --oneline --no-merges --grep 'Mark Brown' -- arch/ | grep 'GPIO desc'
> 
> > I randomly took this 366f36e2a ("ASoC: wm1250-ev1: Convert to GPIO descriptors").
> 
> > Can you tell how it is different to my proposal?
> 
> The main difference with the GPIO lookup tables is that they are
> structured data specifically for GPIOs rather than the general purpose
> free for all we have with swnode.

Semantically yes, technically they have all the same issues you pointed out
that swnode has.

Nevertheless, I'm about to send a part 2 of cleanup (I decided not mangle
this series, so it will be on top of this) for you to see how we can go
forward.

And thank you for this discussion.

-- 
With Best Regards,
Andy Shevchenko



