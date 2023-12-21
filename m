Return-Path: <linux-kernel+bounces-8403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 831DF81B6AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5CF28875C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A377764E;
	Thu, 21 Dec 2023 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jTZ6LZUZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE5077643;
	Thu, 21 Dec 2023 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703163132; x=1734699132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FbPXrgzp9CMlNqZjP3ebUSZqWMGld04TyVhznkGVITo=;
  b=jTZ6LZUZp51bxftqHPoNIiVb/LG4r9wLEve2KL+zRSsL/fWMg8wlsSc5
   59QxDDVdjzTubYtzGzdNVqYYSLCL+QwZS3jpun4Zmn4c/jd2SOikMOqiY
   azRcbDQ5vt7CUZT8wtrNMsAI/DrDzxChk4cckd4umCTfUOzBYV4QyZzi2
   +SntVZntgLIbeUuTLUkeIuENRzXYK0gUbHhQtjNfdnCdz0Q5onl1ipo0J
   jJjDsulXSkXxfA/Xjuur8oDeaMR1oWJ1CUpXKJGwbT1kBaeN1gWZxlEum
   RCtU5YquP0B/RTV/dCCHKaEI/E0X1OA2vSk0u9RRoHfxXLLsNrP3Xr4bd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="14653875"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="14653875"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 04:52:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="780183598"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="780183598"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 04:52:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGIX0-00000007r0i-19N8;
	Thu, 21 Dec 2023 14:52:06 +0200
Date: Thu, 21 Dec 2023 14:52:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFC PATCH] gpiolib: remove extra_checks
Message-ID: <ZYQ09RIq1R8xmn_k@smile.fi.intel.com>
References: <20231219201102.41639-1-brgl@bgdev.pl>
 <ZYL0MWAQ-frYLnZq@smile.fi.intel.com>
 <CACRpkdZB-5DN5NYJNGheDJnNWRt8x4LwgOQpL4NDyX2JSn+_9g@mail.gmail.com>
 <CAMRc=MfLXxfzhKDc9e3jRF9mdVo=9UnC9O+i9s-uGm2pEa7vMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfLXxfzhKDc9e3jRF9mdVo=9UnC9O+i9s-uGm2pEa7vMg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 10:26:03AM +0100, Bartosz Golaszewski wrote:
> On Wed, Dec 20, 2023 at 4:28 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Wed, Dec 20, 2023 at 3:03 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Dec 19, 2023 at 09:11:02PM +0100, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > extra_checks is only used in a few places. It also depends on
> > >
> > > > a non-standard DEBUG define one needs to add to the source file.
> > >
> > > Huh?!
> > >
> > > What then CONFIG_DEBUG_GPIO is about?
> >
> > Yeah that is some helper DBrownell added because like me he could
> > never figure out how to pass -DDEBUG to a single file on the command
> > line and besides gpiolib is several files. I added the same to pinctrl
> > to get core debug messages.
> >
> > I guess Bartosz means extra_checks is == a non-standard DEBUG
> > define.

I agree on this statement.

> Defining DEBUG makes sense to
> enable dev_dbg() messages.

Exactly!

> CONFIG_DEBUG_GPIO is used by one driver

By all drivers which are using pr_debug() / dev_dbg().
I am using it a lot in my development process (actually I have it enabled
in all my kernel configurations).

> to enable code that can lead to undefined behavior (should it maybe be
> #if 0?).

I don't know what you are talking about here.

-- 
With Best Regards,
Andy Shevchenko



