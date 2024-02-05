Return-Path: <linux-kernel+bounces-52743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBDA849C27
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F1C2B2337E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EAA20DF7;
	Mon,  5 Feb 2024 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XograDka"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0869249F7;
	Mon,  5 Feb 2024 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140837; cv=none; b=kV78yZ9Z3yobvt0JXzdVdMC/iPsF948E14o6bozoWRMa9Q0NmYs3xsnF6zd0vGbriqHucOIbNneesOmpGRJtt4X8aOzGfH/QoJgfW4zYJ164HSvM/snLYaRAhOdTI4QZ4IZY9yOuO8XOEFa4dNVPzHqjUHIFasaCDfSdtDAXNf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140837; c=relaxed/simple;
	bh=fnnDzvyHo2rzexAyz4LUlPbdbYoQlWB3LXPS87c8RE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5awhO2073nGjAy8OK0FytM0INYTKi3XBDwYYW9V9PFHDYWOcAyJsSMaNyN9eMOiacDnkdAx+uBiAtjMOXwvdHiSyg5+DHyfSrTQyyflpU5/UELTP/C6l2pkUrJqIuGL824ETSJSeoOQJxLZl3hCahbcCvxfKno3f0b/RvmkTW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XograDka; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707140836; x=1738676836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fnnDzvyHo2rzexAyz4LUlPbdbYoQlWB3LXPS87c8RE8=;
  b=XograDka1yzzWSwD90LdrIZXFWmaRAkGr3PC3d1Z24kFkEDsE229kVNO
   F7HnIMHyFi1fegeGZ5wbGzfrDCcndRU6tWsPddppULuewxbk4hAaou0C7
   em5hwUPXT7m/6wY195IOAU43WqoUpL7tLSKiqkJBfKWFoeN7C5YMXiGST
   2TVLI/jPpUsL5wV1dwkewEZC7qZInqdhbVzD0oY7iawWeV1D8yqM1Fxv1
   lO0Y+xXzdGGVNXDrE7xAtMY8kmfCAZk3exPZ3BqqeQ+xZwCSjqxgxUdZG
   aUYPOeAaNPIEM1RgmWaEZxirLnKBiqnamxHcFwJzgwrVSqezyuqifDeaL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="430659"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="430659"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:47:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="909300304"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="909300304"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:47:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rWzJV-000000025o8-2zcX;
	Mon, 05 Feb 2024 15:47:09 +0200
Date: Mon, 5 Feb 2024 15:47:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 08/23] gpio: sysfs: use gpio_device_find() to iterate
 over existing devices
Message-ID: <ZcDm3ZrW1dQQAroY@smile.fi.intel.com>
References: <20240205093418.39755-1-brgl@bgdev.pl>
 <20240205093418.39755-9-brgl@bgdev.pl>
 <ZcDSKYqFHSUZb2Qx@smile.fi.intel.com>
 <CAMRc=Mfh5CcftXUStGOXvUF-s3aNxnaNM0sDt72LKrBfttqitQ@mail.gmail.com>
 <ZcDkvOrlSRkmYIk_@smile.fi.intel.com>
 <CAMRc=MeiXLZ4q8MH5h_wX1rBz9-YVK6UKUdCu2nTb6+uNHGXPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeiXLZ4q8MH5h_wX1rBz9-YVK6UKUdCu2nTb6+uNHGXPQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 05, 2024 at 02:39:40PM +0100, Bartosz Golaszewski wrote:
> On Mon, Feb 5, 2024 at 2:38 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 05, 2024 at 02:19:10PM +0100, Bartosz Golaszewski wrote:
> > > On Mon, Feb 5, 2024 at 1:36 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Mon, Feb 05, 2024 at 10:34:03AM +0100, Bartosz Golaszewski wrote:

..

> > > > > +static int gpiofind_sysfs_register(struct gpio_chip *gc, void *data)
> > > > > +{
> > > > > +     struct gpio_device *gdev = gc->gpiodev;
> > > > > +     int ret;
> > > > > +
> > > > > +     if (gdev->mockdev)
> > > > > +             return 0;
> > > > > +
> > > > > +     ret = gpiochip_sysfs_register(gdev);
> > > > > +     if (ret)
> > > > > +             chip_err(gc, "failed to register the sysfs entry: %d\n", ret);
> > > >
> > > > > +     return 0;
> > > >
> > > > ???
> >
> > What the point of function to be int if you effectively ignore this by always
> > returning 0?
> >
> 
> Because the signature of the callback expects an int to be returned?

But why do you return 0 instead of ret?

> > > Not sure what the ... and ??? mean? The commit message should have
> > > read "... traverse it from gpiofind_sysfs_register()" I agree but the
> > > latter?
> >
> > I didn't realize this may not be obvious :-(.
> >
> > > > > +}

-- 
With Best Regards,
Andy Shevchenko



