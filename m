Return-Path: <linux-kernel+bounces-145220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0048A5104
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB5C3B23119
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7925112AAE4;
	Mon, 15 Apr 2024 13:05:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B56763EE;
	Mon, 15 Apr 2024 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186333; cv=none; b=beNTOfo4j/VE8mv9oLlk+h5nIAG4M7WSOcc9LhrwxPVcIYtargg7AuFc5xlXx1HtbXHWUD6N7aEFLJVK0YvjM9UazNYoyfSaI8VE2/kbeGcdNzHuqKYwjlnTDMtT2UBp5obcbwYF6T9RZXobHB6u9p3CuJaDAsL3XTJcTLOD/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186333; c=relaxed/simple;
	bh=e9tGNm4v3nKmynIONtpDA6Y1cuJoNNasV3i92wHJLUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaAFjRWTyk7g3p0pCYqzfwjt99CXPt7IFQCCsi6Vv55zPZa1sraR00gBdKfcU+i/xlej398VN8N7QEkNp6A6y6SAXmNKqbb2e1QYNXVKRHH1TT592nleDjJaXhYmtbhngHU9f4w3CtmO4j/mDkGmRf1HrNhRy8E8v8AldIidtzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: pxfsBNFjSGGMA/+gcsiXkA==
X-CSE-MsgGUID: 0abM+Rf3ScyRz1TfETM3IA==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8794833"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="8794833"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 06:05:30 -0700
X-CSE-ConnectionGUID: zyKL/BT3QWmfYv/DOdk9vQ==
X-CSE-MsgGUID: WMeYX4HITFm+8UeMsF58cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="26704586"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 06:05:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rwM1W-00000004PlW-2wXR;
	Mon, 15 Apr 2024 16:05:26 +0300
Date: Mon, 15 Apr 2024 16:05:26 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpio: sch: Switch to memory mapped IO accessors
Message-ID: <Zh0mFrrmrO1zNmoN@smile.fi.intel.com>
References: <20240410072102.1200869-1-andy.shevchenko@gmail.com>
 <ZhpC3lLD-BHqJEZz@ishi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhpC3lLD-BHqJEZz@ishi>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Apr 13, 2024 at 04:31:26AM -0400, William Breathitt Gray wrote:
> On Wed, Apr 10, 2024 at 10:21:02AM +0300, Andy Shevchenko wrote:
> > Convert driver to use memory mapped IO accessors.
> > 
> > Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Acked-by: William Breathitt Gray <wbg@kernel.org>

Pushed to my review and testing queue, thank you!

> A minor suggestion below, but I find this patch accepted as-is.
> 
> >  static int sch_gpio_probe(struct platform_device *pdev)
> >  {
> > +	struct device *dev = &pdev->dev;
> 
> In general I think this is a good variable to define to simplify all the
> &pdev->dev appearing throughout this callback, but I'd rather have seen
> it as its own patch so we could change all the other uses of &pdev->dev
> at once without distracting from the memory-mapped I/O change of this
> particular patch. Not really necessary, but maybe at some point in the
> future a follow-up patch doing such a cleanup would be nice.

I avoid making unneeded  churn on a line I have updated in this patch.
That's why I introduced the local variable proactively. Yet, I can do
another patch to clean up the driver based on the existence of this var.

-- 
With Best Regards,
Andy Shevchenko



