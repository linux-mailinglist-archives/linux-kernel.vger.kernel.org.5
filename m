Return-Path: <linux-kernel+bounces-8745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F0281BBA8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B7A1F25FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6325990F;
	Thu, 21 Dec 2023 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7diH669"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF13059923;
	Thu, 21 Dec 2023 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703175219; x=1734711219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+F0n8TqaU3oiITLxGriRbvSDLCslujIfieiK6InccLQ=;
  b=I7diH669UfxPCG95lThkDW8LBCJVk8pmLb5JVHg2eWMO0v2GEcQT58oQ
   RKDjYUn7N9ts/Y/q5Umg81PJaj9fOy3ucOFq0xphiN2j1OZN84vBtEDKr
   +XO18u3j+sj0IfDq8k1z79GKOfsW1IQElT5aKB5CG33WZN2oND2UMa8e+
   oEz3rzzmQxJDzNzQxCCNzRfVrj6qAAA/JJJJ/CZTyXnQLiJinttwv02B1
   Bi9Ftzg2ezZ4XM7BnAZgI8GU6l17g7hVITDpudPbcBMWPEYp8DcnAkh/d
   0gdEM79P7ry1KkV5pb0BEl3Lqjh6AyAzy2eiya7D6qiN/j6RVuf6zWTjj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="2828552"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="2828552"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 08:13:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="900142098"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="900142098"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 08:13:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGLfx-00000007tKW-2X53;
	Thu, 21 Dec 2023 18:13:33 +0200
Date: Thu, 21 Dec 2023 18:13:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC PATCH] gpiolib: remove extra_checks
Message-ID: <ZYRkLfYnU3WZEWPa@smile.fi.intel.com>
References: <20231219201102.41639-1-brgl@bgdev.pl>
 <ZYL0MWAQ-frYLnZq@smile.fi.intel.com>
 <CACRpkdZB-5DN5NYJNGheDJnNWRt8x4LwgOQpL4NDyX2JSn+_9g@mail.gmail.com>
 <CAMRc=MfLXxfzhKDc9e3jRF9mdVo=9UnC9O+i9s-uGm2pEa7vMg@mail.gmail.com>
 <ZYQ09RIq1R8xmn_k@smile.fi.intel.com>
 <CAMRc=MfYG09UUfqfuE89Or4HsP8QWUBJXCvuPPhe+vx0JiZF4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfYG09UUfqfuE89Or4HsP8QWUBJXCvuPPhe+vx0JiZF4w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 02:00:39PM +0100, Bartosz Golaszewski wrote:
> On Thu, Dec 21, 2023 at 1:52 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Dec 21, 2023 at 10:26:03AM +0100, Bartosz Golaszewski wrote:
> > > On Wed, Dec 20, 2023 at 4:28 PM Linus Walleij <linus.walleij@linaro.org> wrote:

...

> > > Defining DEBUG makes sense to
> > > enable dev_dbg() messages.
> >
> > Exactly!
> >
> > > CONFIG_DEBUG_GPIO is used by one driver
> >
> > By all drivers which are using pr_debug() / dev_dbg().
> > I am using it a lot in my development process (actually I have it enabled
> > in all my kernel configurations).
> 
> I'm not saying we should remove it. It'll stay defined in the Makefile
> and remain seamless for debug messages. I just want to get rid of that
> ugly extra_checks variable which has very little impact.

I agree that extra_checks is unusual (or as Linus put it "non-standard")
thingy. And I agree that removal is for good.

My question here solely about that WARN_ON(). Do we need it always be enabled
or not?

> > > to enable code that can lead to undefined behavior (should it maybe be
> > > #if 0?).
> >
> > I don't know what you are talking about here.
> 
> I'm talking about drivers/gpio/gpio-tps65219.c and its usage of
> CONFIG_DEBUG_GPIO.

Oh, that one should probably be

#if 0
	...
#endif

or

	if (0) {
		...
	}

-- 
With Best Regards,
Andy Shevchenko



