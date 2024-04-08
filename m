Return-Path: <linux-kernel+bounces-135936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8431289CD63
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262BB1F21B21
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933091482F5;
	Mon,  8 Apr 2024 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDrebjF1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5938147C62;
	Mon,  8 Apr 2024 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712611160; cv=none; b=QK1SUP+okv8fHYLikYgFY6kpTgdAPBCQbo9Uya7h/dAYli/zlO2HAtcx3+4tyynZLsDqMyX4vq/1IyWwxG+Z04IAMLH0Tj2sxFfGrW0dyAmoDMRro2+gP0jkAqNLd1m9/kbgBGKfbTbt2Yz833hhWTI+eHseTXkT3VmXcRibsFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712611160; c=relaxed/simple;
	bh=E215z4yNgNQnZ5yyZUlVNUGteHZIYbQ3gK1FUVJXYsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUrZK47SPrzCjsDqlQ8ME9Q4RxTx9E4H0k7xaQYI55qlr0lOs6FjWoserfk/E4v5zGM6uABvBkjYCvotw9KBInrp9WYtYDaKHO+a1scgFJOZGxBm2QMDY2vmQSoyaLkQNzNT9MvxxhkY0rvOPIbA+PZhw5ZLtlZBEaZaxOSNgvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDrebjF1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712611159; x=1744147159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E215z4yNgNQnZ5yyZUlVNUGteHZIYbQ3gK1FUVJXYsw=;
  b=fDrebjF1Rl45UkT4Bo6Qni8dpcx/f3nNVBoBi/mvx8B2pn3TnqtaCSjj
   wKs79IYoRVMenVO6Zs/Vl3930Ka9eFMxEaulElYxr/3FbPdTHdmZetVc6
   2ItUi/S1Skhs2HmcFJch2WHDOgz600erEOemOQilvwMuS/sUAe83jb3cn
   6PTbw9hvYfij51bhJLe7y4hUuN5kyGqI3Es1xBDPLeBHwFzGVSQpK3N85
   SJKvH4vOr+2X2IB7cmy4lZsFoHKTu3Bc0mvdQiEV4NYr5P5b1IlIhZ1gL
   3cTY28YYXWx4XW4Q9oRR+lsMht8LDUMD0oSVJ2F3qFWlo53ZviiIWVizU
   A==;
X-CSE-ConnectionGUID: PxlJ0tneRmaLXulJ6OEZZQ==
X-CSE-MsgGUID: +xm6HA57ShaLycf/pVNDEA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7764769"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7764769"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 14:19:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="915377857"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="915377857"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 14:19:16 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rtwOX-00000002eS9-37Sw;
	Tue, 09 Apr 2024 00:19:13 +0300
Date: Tue, 9 Apr 2024 00:19:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpiolib: Update the kernel documentation - add
 Return sections
Message-ID: <ZhRfUQP8GlJ7ZEBd@smile.fi.intel.com>
References: <20240404212706.3587456-1-andriy.shevchenko@linux.intel.com>
 <ZhQ1l6naYpVlmlex@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhQ1l6naYpVlmlex@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 08, 2024 at 09:21:11PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 05, 2024 at 12:27:06AM +0300, Andy Shevchenko wrote:
> > $ scripts/kernel-doc -v -none -Wall drivers/gpio/gpiolib* 2>&1 | grep -w warning | wc -l
> > 67
> > 
> > Fix these by adding Return sections. While at it, make sure all of
> > Return sections use the same style.
> 
> Bart, this is the biggest part from the v1, I would like to have that applied
> first if no objections since it fixes kernel doc warnings. What do you think?

Hold on a sec, I found bigger issue that needs to be backported and this patch
needs to be rebased on top of it. I'll send an update.

-- 
With Best Regards,
Andy Shevchenko



