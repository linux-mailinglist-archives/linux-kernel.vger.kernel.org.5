Return-Path: <linux-kernel+bounces-7034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C6081A0C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A6A282D0A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDD238DDE;
	Wed, 20 Dec 2023 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTc1MRG9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E14538F81;
	Wed, 20 Dec 2023 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703081357; x=1734617357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4aqkzWwe/QO/2csYRmPX92UHytd6d0JQX8zFr1gOUuM=;
  b=PTc1MRG9rnhTyocnVPG42JUdF0yZFJfrzED3bLMoZ+j8sxz/XZ2TPuFY
   VrLVpki8E4Ap3muFgY5c4Ha1Y7dsCDk9byXdvsBBA5aHZtMoIclf1CwS2
   o9i0fxSE5W7JBg9CknC5B/YktQ9cRRMJfRYAIqQmNf61aCoq9LoFZmReq
   N7shGrP8Ec1c4dxrlJB4XXCuvrKqdWTwIbFGCOU6BK0Q52Rpd7husBpVa
   4oDTBcFFBQndP08xIzUfiuTRSbZl3CKVNu75fvKrioqVYxFomaogdExFW
   NagcyGJyz/bCOQLjnLlkpP8RHmrXipY1ODSl5o8IZOaRUaBstM/x9GcM2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2658126"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="2658126"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 06:09:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="779862813"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="779862813"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 06:09:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rFxG3-00000007YP4-3Lkx;
	Wed, 20 Dec 2023 16:09:11 +0200
Date: Wed, 20 Dec 2023 16:09:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/2] gpiolib: drop tabs from local variable declarations
Message-ID: <ZYL1hybEfHxGVQrr@smile.fi.intel.com>
References: <20231219142323.28929-1-brgl@bgdev.pl>
 <ZYGxefhI9UpwknhD@smile.fi.intel.com>
 <CAMRc=MfqYAYsjdPNrc2u7NDuUVdaA4NcE3vMevhSUmZOtc14CQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfqYAYsjdPNrc2u7NDuUVdaA4NcE3vMevhSUmZOtc14CQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 08:59:12PM +0100, Bartosz Golaszewski wrote:
> On Tue, Dec 19, 2023 at 4:06 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Dec 19, 2023 at 03:23:22PM +0100, Bartosz Golaszewski wrote:

...

> > > +     struct gpio_chip *gc = desc->gdev->chip;
> > > +     int ret;
> > > +     unsigned long flags;
> > > +     unsigned int offset;
> >
> > I'm wondering if you can make it reversed xmas tree order.
> > This will make it even more consistent between functions.
> 
> Sure but we'd have to update all functions across gpiolib.c. Let's
> take it one thing at a time.

The point is to do this for the lines you modified to avoid additional churn
and burden for backport. At least these two things (removing TABs and shuffling
the order) are kinda of the same family of the logical changes. I do not see
the problem doing this in one patch for the lines you modified. Yet, for the
rest it might be another patch, but I don't think it worth doing it.

-- 
With Best Regards,
Andy Shevchenko



