Return-Path: <linux-kernel+bounces-55047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F97984B6D3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E261F241F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6097C1332BA;
	Tue,  6 Feb 2024 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jL3lm+sP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C341332AB;
	Tue,  6 Feb 2024 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227030; cv=none; b=oclCoFOdSvjOJv/rIalQi2MyFC0Q5refBjspivECCMTJLr0sKURGwKe6uyh0HcNzPUnkuioRbStSnHaRmQO0G/hiFvhme/TxJ3EfPINTCJuHG8NnjZG7YN+fK/rNWlVD2VLKwmJ48Q189wMu8mdM9HDSgKE9Jh47mlIkhwwlcE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227030; c=relaxed/simple;
	bh=SUxMOCdGao8f0FWMz+0RjWwJi349adzOCQHtfuEpjss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSK7Aa/pTvBOowE8X6gDY7x3syGNWRtLKj5Rwt3DXr3jHpqGOKcl+chbWyT6SVaOZ+ORDLK1TuVDH3dad3rave3l6nH2GWWXuYLUQc2FOdX5HfNSTPh1fpuBxT/eA3ybPJPC5JN0VToORQh8TwH4sct+K4+X+fI8nJ1xpTXSUrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jL3lm+sP; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707227029; x=1738763029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SUxMOCdGao8f0FWMz+0RjWwJi349adzOCQHtfuEpjss=;
  b=jL3lm+sPfsMHMMBadxpL9MGys9vNbkFCuXiiZz2YVvyKgSsKvSknyyQv
   S5b3II2RAHMTZWlcr3RmJHKL40T0msGGbQfoxc4NUhU+PYhhhbU5fsW4I
   U8FX3TeoEyZVuC+652bkZw53Mds7HTNowxdvzrvCeJyhdkfUhPPU1Whaq
   DRDptd/i/nj4b3H29hU45xvKNWcVybSOQFFyDg/hPlrFhVYQRRTzUjEOy
   156gcmT0Uom0cx9NyGEA7yx2taZXfmaW2tW2TxwpkzCUTZC7PV03bAQwD
   JCyzSFK0X5Xe9RYDcleOUcktxd48lYBaRYuveLJNVFs3k7zAjEzcKVMx3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="1015677"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1015677"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:43:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="909638751"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="909638751"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:43:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rXLji-00000002LvW-3KDt;
	Tue, 06 Feb 2024 15:43:42 +0200
Date: Tue, 6 Feb 2024 15:43:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 21/23] gpio: protect the pointer to gpio_chip in
 gpio_device with SRCU
Message-ID: <ZcI3jkga8yfI6Nx8@smile.fi.intel.com>
References: <20240205093418.39755-1-brgl@bgdev.pl>
 <20240205093418.39755-22-brgl@bgdev.pl>
 <ZcDVNA6Id7Bmckt0@smile.fi.intel.com>
 <CAMRc=MdoGQZKM37kk=j6NpdkUUjDvs3-8YeiZVQO2EpPHRZ7Uw@mail.gmail.com>
 <ZcIlEEgHn5AaTEyz@smile.fi.intel.com>
 <CAMRc=Mcq2UgS4EcVAOghQzFq_jXA83rGMse+pxa5ieK8MXZm-w@mail.gmail.com>
 <ZcIwiU4UNbcoa8Km@smile.fi.intel.com>
 <CAMRc=MdRwCqn-A3Wdk8kaYDY6NAO5fC3wy0gxWsFQcPwoH9dvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdRwCqn-A3Wdk8kaYDY6NAO5fC3wy0gxWsFQcPwoH9dvw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 06, 2024 at 02:23:35PM +0100, Bartosz Golaszewski wrote:
> On Tue, Feb 6, 2024 at 2:13 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Feb 06, 2024 at 01:57:39PM +0100, Bartosz Golaszewski wrote:
> > > On Tue, Feb 6, 2024 at 1:24 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Mon, Feb 05, 2024 at 08:36:39PM +0100, Bartosz Golaszewski wrote:
> > > > > On Mon, Feb 5, 2024 at 1:31 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:

..

> > > > > > >  int gpiod_get_direction(struct gpio_desc *desc)
> > > > > > >  {
> > > > > > > -     struct gpio_chip *gc;
> > > > > > >       unsigned long flags;
> > > > > > >       unsigned int offset;
> > > > > > >       int ret;
> > > > > > >
> > > > > > > -     gc = gpiod_to_chip(desc);
> > > > > > > +     if (!desc)
> > > > > > > +             /* Sane default is INPUT. */
> > > > > > > +             return 1;
> > > > > >
> > > > > > Hmm... I can't imagine how this value may anyhow be used / useful.
> > > > >
> > > > > What else would you return for an optional (NULL) GPIO?
> > > >
> > > > An error. If somebody asks for direction of the non-existing GPIO, there is no
> > > > (valid) answer for that.
> >
> > > All other functions return 0 for desc == NULL to accommodate
> > > gpiod_get_optional(). I think we should stay consistent here.
> >
> > The way you proposed is inconsistent, i.e. you may not return any direction
> > for the unknown / non-existing GPIO. You speculate it will be 1, I may consider
> > that in my (hypothetical for now) case it should be 0.
> >
> > Just don't make all bananas to be oranges. It won't work.
> 
> I don't have a strong conviction here. May make it an error as well.
> It's still inconsistent though - calling gpiod_direction_output(NULL);
> will return 0 and then you get an error when you do
> gpiod_get_direction(NULL). I don't have a good solution though.

Yes, and this is the best what we can have. Because the real code may rely on
the returned value and they should be really aware on the returned values in
some cases.

-- 
With Best Regards,
Andy Shevchenko



