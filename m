Return-Path: <linux-kernel+bounces-88836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BFE86E759
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26FAB28F1CB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6124636118;
	Fri,  1 Mar 2024 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OksYRh2k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F0F286AE;
	Fri,  1 Mar 2024 17:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314293; cv=none; b=nIToKGARLcmz6ZNnNdMJvk+vnZNFS53znDwoubhGwGbiX3m+obuQjqkS4FZgCdYOmls3FYZwEWcFSz2ZTZGgFmGgA/l9T//qctHi7W09LvF9VqXtYz9inmtU9MxbKVOASCdybyVW7UsM0g0rCUhs8lqVUIPcTibyqVRqdCPqK7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314293; c=relaxed/simple;
	bh=WcVXXiR4nzAg12r56OyRHoYJrh+caVvMRz0vmAhETbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzXv2FKNI6RfXw/gjSFNkCMoKwuZgqgqEakMQdUJfahukl2xhqakwcL4D0tKJIK7d/acUtylHf6MG8Hhlp8TOWjAxxXxSQ3q+ic4D+R98mgKImfBXszF8iNFb5gXAfAk/WlOb/B1uDDDjv/7wES3QswNmg3/KkHFZCDFfBysS1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OksYRh2k; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709314292; x=1740850292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WcVXXiR4nzAg12r56OyRHoYJrh+caVvMRz0vmAhETbg=;
  b=OksYRh2kTdISN6LT2dqvVlIvnFKji2C8lONSEaoVKoT9GlbX0AZ16vGH
   Bg5UlhAGr/fgNqa+gBdkqz97clhUusXwc+Y8orGhbqxd08eUFP6D+01Hw
   M3khJi3Xkjf8IZUBtyWlRfjajfY51E0b3Jx9TRNW8Nwq4xsEz8AlUJMkA
   JbYkQxma7p5VmR8CCCKQa+t+gBH6aJuFpkYG9WtH/9L++a1N1O2P/f37H
   tViZWJdnMfvp4JeRnHXuQciMMZmaK0QDu/dD2rO7uIE8d/DsVG8fqse3H
   BpzRf+q1CnqnQZUdUcktEoGeNim0IWS1c48i//L4JZzwwL3m8vsGQk+Y6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="15273903"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="15273903"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 09:31:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="914021014"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="914021014"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 09:31:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rg6jE-0000000911k-3lII;
	Fri, 01 Mar 2024 19:31:24 +0200
Date: Fri, 1 Mar 2024 19:31:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] gpiolib: Fix the error path order in
 gpiochip_add_data_with_key()
Message-ID: <ZeIQ7KsOsGHUqdny@smile.fi.intel.com>
References: <20240221192846.4156888-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MdvYdx6x=gSiOZ3SXAdJORnqhsNW79G2c7wABofWARwFw@mail.gmail.com>
 <ZddLRAqxFr7v3Zqs@smile.fi.intel.com>
 <CAMRc=Mdxtx-wh3HGu+SNrCwfSq0PEm3fG7hK_6wPAk2uzk8xpA@mail.gmail.com>
 <ZddOKTP73ja6ejTc@smile.fi.intel.com>
 <CAMRc=Mf_w_E4B7c_Uj1WV3zv9DbmJ22oFvJJwtd-+3oUDVcvXA@mail.gmail.com>
 <ZeCw3pzHdrXw46of@smile.fi.intel.com>
 <CAMRc=MdKFvAefKxLnovxnQt_tpiW+dCviWXKuHqg3vqHhEtPNA@mail.gmail.com>
 <ZeDLLfQOrPLUzyGt@smile.fi.intel.com>
 <CAMRc=McxWc-78q6FW61doDua60ZvCOfSXK7v7wmAm0rX7wDDgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McxWc-78q6FW61doDua60ZvCOfSXK7v7wmAm0rX7wDDgA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 01, 2024 at 08:41:09AM +0100, Bartosz Golaszewski wrote:
> On Thu, Feb 29, 2024 at 7:21 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Feb 29, 2024 at 06:26:29PM +0100, Bartosz Golaszewski wrote:
> > > On Thu, Feb 29, 2024 at 5:29 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > > > I'm sorry I really need more (morning) coffee, maybe you can simply update
> > > > > > yourself or submit a correct fix?
> > > > >
> > > > > Ok, I'll apply this and send a fix on top of it.
> > > >
> > > > I don't see any progress with this. Do I need to do something?
> > >
> > > No, it just fell through the cracks. I applied this now and sent my
> > > own fix on top.
> 
> I now realized that this commit doesn't really fix ba5c5effe02c
> ("gpio: initialize descriptor SRCU structure before adding OF-based
> chips"). It addresses an issue introduced as long ago as commit
> 2f4133bb5f14 ("gpiolib: No need to call gpiochip_remove_pin_ranges()
> twice").

Oh, that means it revealed the issue :-)

> I will change the Fixes tag, queue it for fixes and send it to
> Torvalds for rc7, then merge them back into for-next.

Thank you!

-- 
With Best Regards,
Andy Shevchenko



