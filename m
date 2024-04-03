Return-Path: <linux-kernel+bounces-129821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587E88970BE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0FA1C26400
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946BA148FE7;
	Wed,  3 Apr 2024 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BycqVNOR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7FE1482F9;
	Wed,  3 Apr 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150442; cv=none; b=IYxzcWtxAtalnQ4+JzkRDVFvj/YrOcs8SECOx1/U/pWhCgFm+kUHeC3zWC6+eyoA3/VsLapzUhI+1WQ/7WTxe+clSQII8V4meTbv3aJ3Z35KuBwSyJDlYsdasxgt2N8WTsSYRp3vvu/g0v3KOxTFX+uOcUf/FdFpX4jf4q9WceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150442; c=relaxed/simple;
	bh=CCu+4+aVoTTZgu9hej/Pthjpzr3wNcQ1Oyt/g5SypTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRHU/v2IWsgU3sqAHfxgIM+xMpqdaXdOgMwM3xO7sLz5twQh1pcu7NdJO0XlsUJ3zNxYFT65CwEj/K9lM4uA5Eesj58hqv4HLrVyX/AD8eAU/XSPUZenM+P0brzQbei9Ics4QXG73Xn5BVsnehlZhvwaSLVVuhbosA8Cos3OzXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BycqVNOR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712150441; x=1743686441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CCu+4+aVoTTZgu9hej/Pthjpzr3wNcQ1Oyt/g5SypTo=;
  b=BycqVNOR93WcrkialqUWBTtSdparm1xH1crHQUhgXDehQYYTaA48vZaD
   IgfQ2Y/5yqQMhAqm9TkI/al8NQOaJ4Tr5EvjYXJq+hjN3aY7u//lm9Gdq
   Zq1/aHqLWMzSyG7DDLgtKE34rUNe0kBEWNGCb4A7fc8kl0OfPOIoL7K9D
   QK4TuueaMUv1lPMZWbYs4Z0nb+g2ZNjKCStRNCyGjAoqLtS/Bd1QFiWfV
   T0ZeC7Y3Kg4jeb/our46WKNNFdCOylOg4G8iRsl7BkRX+iphHFP6ugduU
   uzPUUED20QUcEs4WJGNQlo1O+Ihh/LVTkH+Mxg1ulEXww9AEu7VnpxK9B
   A==;
X-CSE-ConnectionGUID: ArB7kHR4QS6/dJMxzaaqcQ==
X-CSE-MsgGUID: X6o6AD15QdmpEwuTzl8EEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7243129"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7243129"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 06:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="915183291"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915183291"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 06:20:37 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rs0Xb-000000017y4-0k5R;
	Wed, 03 Apr 2024 16:20:35 +0300
Date: Wed, 3 Apr 2024 16:20:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 2/2] gpiolib: Up to date the kernel documentation
Message-ID: <Zg1XoiXTN3dQSNbB@smile.fi.intel.com>
References: <20240326181247.1419138-1-andriy.shevchenko@linux.intel.com>
 <20240326181247.1419138-3-andriy.shevchenko@linux.intel.com>
 <CAMRc=Mf3y4EUSVte9Y5VyTDAFFKHXtM5RSz=MDeHhOVBeqPtmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mf3y4EUSVte9Y5VyTDAFFKHXtM5RSz=MDeHhOVBeqPtmw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 02:59:32PM +0200, Bartosz Golaszewski wrote:
> On Tue, Mar 26, 2024 at 7:12 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > There are several issues:
> >
> > - Reference to the non-existing or only single functions out of possible
> >   callees
> >
> > - No return section
> >
> > $ scripts/kernel-doc -v -none -Wall drivers/gpio/gpiolib* 2>&1 | grep -w warning | wc -l
> > 67
> >
> > - Reference to NULL as %NULL in a few cases
> >
> > - Explicit reference to error codes as Exxx or %Exxx and
> >   numbers with leading %
> >
> > - Spelling of gpio, irq, SOC (in different capitalization)
> >
> > - Unaligned style of irqchip, gpiochip references
> >
> > - Unaligned style of NOTE, FIXME, and TODO
> >
> > Fix all these. While at it, fix multi-line comment style as well.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Could you split it into separate patches by subject (one for
> capitalization, one for %NULL, etc.)? As is, it's a huge dump that's
> hard to review.

Sure.

-- 
With Best Regards,
Andy Shevchenko



