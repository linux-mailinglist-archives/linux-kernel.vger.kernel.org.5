Return-Path: <linux-kernel+bounces-58477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FCB84E6F9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3449A1F2308B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30F782D61;
	Thu,  8 Feb 2024 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZeAtces+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF4376416;
	Thu,  8 Feb 2024 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414197; cv=none; b=ZvJ7N26yVKl92N0Y/JVLo2vRjgiVtQj8gy41lPhp938R7bWgot+cFySO2qSXV2mT9wiqbY80vimuio6+NGSN77nGHS2D+FeHBfqvPe8A5lpy76k+kddLwE9ERn/raoJi2UI3oUqI3+w0DHBmmPspFOnfCBLtvuzSc+PX3XEnNyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414197; c=relaxed/simple;
	bh=7i9glvuI7jCT+A+DlSpqDglxXqMLP6DyYKrhkKNr1W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0TGcVl4XHjD7jcUcQW6BejUkKm0gSiqt47qjjEYkwRv286bD+VXp8XueTc85NxyXd5umYGWc2k1Xx0iQ+QXEX01gxyzvRVWoamkRxsFhmLX59VKKxT6kZUd4ND3E/iKVmHWmijV6LniiCduzEOfx/pdwCkYO3i7vG7fT7NqqHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZeAtces+; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707414196; x=1738950196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7i9glvuI7jCT+A+DlSpqDglxXqMLP6DyYKrhkKNr1W8=;
  b=ZeAtces+NWbwOCaUQtyQulerdw4qUfxAR4GIh5S48pFc5jJMhohaLl+0
   hdlRt9i2aq/rN4MWZAnw/NnnNjVf1pFGG2Oqvdq/9PxBsR8ghHcKFNkWL
   eLIUZ6qNx0I1lIwFnDDCEJ1og84mZ7YOaxClDSgImTgfwH/py8YWBkp/J
   e10TkXjQbkxvPK2YnnuP2pob9+0hVwpWYgsKVXPemC/a+iP0ZU7a9Rxth
   YWgQLwh/DrjM3K4qu39u061TaG/QE1tq6OacKJzhkdd6XwKHVqAyrKu+R
   terxhkZrs8UsDrDkecJ2CZU+2fn7RP/xyPCaIg8BqR1Zm2e3K6PxTa3Je
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1431207"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1431207"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:43:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910440101"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910440101"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:43:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rY8QW-00000002wKd-2cCV;
	Thu, 08 Feb 2024 19:43:08 +0200
Date: Thu, 8 Feb 2024 19:43:08 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 00/24] gpio: rework locking and object life-time
 control
Message-ID: <ZcUSrCK_w06ZeV-W@smile.fi.intel.com>
References: <20240208095920.8035-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208095920.8035-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 10:58:56AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This is a big rework of locking in GPIOLIB. The current serialization is
> pretty much useless. There is one big spinlock (gpio_lock) that "protects"
> both the GPIO device list, GPIO descriptor access and who knows what else.
> 
> I'm putting "protects" in quotes as in several places the lock is
> taken, released whenever a sleeping function is called and re-taken
> without regards for the "protected" state that may have changed.
> 
> First a little background on what we're dealing with in GPIOLIB. We have
> consumer API functions that can be called from any context explicitly
> (get/set value, set direction) as well as many others which will get
> called in atomic context implicitly (e.g. set config called in certain
> situations from gpiod_direction_output()).
> 
> On the other side: we have GPIO provider drivers whose callbacks may or
> may not sleep depending on the underlying protocol.
> 
> This makes any attempts at serialization quite complex. We typically
> cannot use sleeping locks - we may be called from atomic - but we also
> often cannot use spinlocks - provider callbacks may sleep. Moreover: we
> have close ties with the interrupt and pinctrl subsystems, often either
> calling into them or getting called from them. They use their own locking
> schemes which are at odds with ours (pinctrl uses mutexes, the interrupt
> subsystem can call GPIO helpers with spinlock taken).
> 
> There is also another significant issue: the GPIO device object contains
> a pointer to gpio_chip which is the implementation of the GPIO provider.
> This object can be removed at any point - as GPIOLIB officially supports
> hotplugging with all the dynamic expanders that we provide drivers for -
> and leave the GPIO API callbacks with a suddenly NULL pointer. This is
> a problem that allowed user-space processes to easily crash the kernel
> until we patched it with a read-write semaphore in the user-space facing
> code (but the problem still exists for in-kernel users). This was
> recognized before as evidenced by the implementation of validate_desc()
> but without proper serialization, simple checking for a NULL pointer is
> pointless and we do need a generic solution for that issue as well.
> 
> If we want to get it right - the more lockless we go, the better. This is
> why SRCU seems to be the right candidate for the mechanism to use. In fact
> it's the only mechanism we can use our read-only critical sections to be
> called from atomic and protecc contexts as well as call driver callbacks
> that may sleep (for the latter case).
> 
> We're going to use it in three places: to protect the global list of GPIO
> devices, to ensure consistency when dereferencing the chip pointer in GPIO
> device struct and finally to ensure that users can access GPIO descriptors
> and always see a consistent state.
> 
> We do NOT serialize all API callbacks. This means that provider callbacks
> may be called simultaneously and GPIO drivers need to provide their own
> locking if needed. This is on purpose. First: we only support exclusive
> GPIO usage* so there's no risk of two drivers getting in each other's way
> over the same GPIO. Second: with this series, we ensure enough consistency
> to limit the chance of drivers or user-space users crashing the kernel.
> With additional improvements in handling the flags field in GPIO
> descriptors there's very little to gain, while bitbanging drivers may care
> about the increased performance of going lockless.
> 
> This series brings in one somewhat significant functional change for
> in-kernel users, namely: GPIO API calls, for which the underlying GPIO
> chip is gone, will no longer return 0 and emit a log message but instead
> will return -ENODEV.
> 
> I know this is a lot of code to go through but the more eyes we get on it
> the better.
> 
> Thanks,
> Bartosz
> 
> * - This is not technically true. We do provide the
> GPIOD_FLAGS_BIT_NONEXCLUSIVE flag. However this is just another piece of
> technical debt. This is a hack provided for a single use-case in the
> regulator framework which got out of control and is now used in many
> places that should have never touched it. It's utterly broken and doesn't
> even provide any contract as to what a "shared GPIO" is. I would argue
> that it's the next thing we should address by providing "reference counted
> GPIO enable", not just a flag allowing to request the same GPIO twice
> and then allow two drivers to fight over who toggles it as is the case
> now. For now, let's just treat users of GPIOD_FLAGS_BIT_NONEXCLUSIVE like
> they're consciously and deliberately choosing to risk undefined behavior.

LGTM, but I haven't done thorough review, hence, FWIW,
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


-- 
With Best Regards,
Andy Shevchenko



