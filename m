Return-Path: <linux-kernel+bounces-133239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A5A89A10E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331A028340C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39CA16F90B;
	Fri,  5 Apr 2024 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TyBZnGBl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E8943170;
	Fri,  5 Apr 2024 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330880; cv=none; b=ENOGv/1BrtqiSbNIaMkls4JPugZITSRXwCUlTsf9DficlBsTPatw9vXvYl950pDB7UlIZahk+sA2vqxQZ32b3tXrXp5fyniCNlZuSBVUtjUmMaeGHlnGMVdIWsqOd8N7fWNr6hzXUU6XU3LZrjLv4x5k4nfZMfpGpumgC7IHMtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330880; c=relaxed/simple;
	bh=6FeiWzJ1Vf8aTbstdcvsoIhMFVzWRcv6R5pNqaplI/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/d5McDVouNwBBzQ/5ifvF5FPwR2LgBd+cmOsOIcDOAAo9mr3kUyu5/T/pu1WtIG7BSMbbK/04aj8nw7YUG7Dl/BJFkTEvXrHoFOoiSprJia8BaPnuanFaCbuN4/hjY+fxJaB4gxt5gg3Bl1hHWJxLQ7byHQOQrputy+1QAl0Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TyBZnGBl; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712330879; x=1743866879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6FeiWzJ1Vf8aTbstdcvsoIhMFVzWRcv6R5pNqaplI/M=;
  b=TyBZnGBlTKmfprPDO5X4v9OaWIYdqd/Uqz3cER3SAJc8nqWTk8LDzYmZ
   dJ4msYta7SdmJkssBjp76AaUnxGvBe0CahRfBM/GJhymuOudqXYE/xDk2
   MrWhBT4Z4jhd5yizvy1Q6xtt3k5WqlLrZ1D5kfvFBThK6PxHD3QKv+E4M
   4zF25KAxs3YpUIkBdq9kzn3gyltWfwUPGifYvnZHBwpWXuhyP8BHYswLc
   40m4oSk79Gbf8veteRXA9V+oFILfPeX+bFUt3GlEhdjm17WZLjIiV5WTD
   Y8DXL1Z+BhGEVfpGEjDHnbGh7MENuZbptSBaHtseztOFtT6OA9ilhhx8u
   A==;
X-CSE-ConnectionGUID: c0rWmrL6RZSwRFeVtTU0Fw==
X-CSE-MsgGUID: 0KOlrQKQQf2c1CIN5NvN7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18274974"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="18274974"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:27:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="915256953"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="915256953"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:27:55 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rslTt-00000001mcG-0MKY;
	Fri, 05 Apr 2024 18:27:53 +0300
Date: Fri, 5 Apr 2024 18:27:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpiolib: Update the kernel documentation - add
 Return sections
Message-ID: <ZhAYeMNzHg0x97gN@smile.fi.intel.com>
References: <20240404212706.3587456-1-andriy.shevchenko@linux.intel.com>
 <2df0e132-5599-4cb5-93f8-4ed664a5d1cc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2df0e132-5599-4cb5-93f8-4ed664a5d1cc@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 04, 2024 at 09:10:09PM -0700, Randy Dunlap wrote:
> On 4/4/24 2:27 PM, Andy Shevchenko wrote:
> > $ scripts/kernel-doc -v -none -Wall drivers/gpio/gpiolib* 2>&1 | grep -w warning | wc -l
> > 67
> > 
> > Fix these by adding Return sections. While at it, make sure all of
> > Return sections use the same style.

..

> I would use %true, %false, %NULL, %0, and %1 in a few places.

Why? I specifically removed % from all of them, it's not so useful.
Do we have, btw, generated HTML with these % as an example to see
the difference. Maybe that helps to understand this better?

> s/error-code/error code/
> or
> s/error-code/errno/
> 
> I would s/active-low/active low/
> 
> or it can just be merged as is. It's a nice improvement.

That's what I prefer as any of your comments may touch other parts of the
documentation and need to be aligned across all comments, which is out scope of
this patch.

> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



