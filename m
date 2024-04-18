Return-Path: <linux-kernel+bounces-149806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CD38A9611
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA221F21544
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74A015FCFC;
	Thu, 18 Apr 2024 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gr6RS90K"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE55715FA83;
	Thu, 18 Apr 2024 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432232; cv=none; b=e8KBJZKpOUs4kM5ar0wALI8nOhk3bTL/BhZUx/yWKC1kuGGMZINsDctJHQJeh49JEo2gHGVT6TYjHlfCfK6hcnZnpTIdDoMNM3oaIxonY7UWl5Z6sH7cmdAcdyPjDM8Mr3S28zo7bJqsOSjqXa58/r7pVl+xZdbVNREgmTf4w4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432232; c=relaxed/simple;
	bh=xyCGbIQrl0v28CiXbp6mTeiFz8MkzajKU50M6utiOhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R97S9Jod1Q9N8qfZh6d3x+LGltFzux6M2mplUO7jFxh1qjqvBybcgavoiVpFp77EhhUWqBmanfP2RFTMOD+mPsNP5Cs7r9QSJ6DsG0RXd/PSwGV8iKMz7IAiyqcI/g4b5IESZridlwanxzXbcF7+tY7P3UknjUdJx660BAhtY+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gr6RS90K; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713432230; x=1744968230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xyCGbIQrl0v28CiXbp6mTeiFz8MkzajKU50M6utiOhA=;
  b=gr6RS90KvqKtEye7HsMk8EKsNOy4gC4I8Ru9t4G6Bhh6aX7hQ8QOKSKU
   qaElmGTWiSCXk1+lXah7gwbe7Er23DjUwnLCi6dtv9tKVftDcmVk5zZh4
   2Pi35WFKpRiwM4pNbL+BqongeejdMwDQublkB10H69to5K5PJr4fnWSgQ
   YxuuLbd2mm7wFIaayIueT5MAj7zMUn+qY/gTNSTTDiHXuQOrIpalNBViU
   8kOASmTEit6TNe7kFVJTxet03owfPCVS65FQHDMuHgWwGhAM4sq1BUFNm
   lcxL8LpJLOqx6kCgRT631ubvob11yAz2f9E30FxZyoJoDw+xRaYfAKgne
   g==;
X-CSE-ConnectionGUID: lQNWlV4XSnudKIi6bZRJ/g==
X-CSE-MsgGUID: uYLHqtrdTc6j0B56hYHFUg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8833961"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="8833961"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 02:23:50 -0700
X-CSE-ConnectionGUID: a7sBlcRqRom0Qy2kUhH2aA==
X-CSE-MsgGUID: 8qyU9DKmTiSYDO75vEp+qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="22982164"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 02:23:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxNze-00000000HZY-0Z9s;
	Thu, 18 Apr 2024 12:23:46 +0300
Date: Thu, 18 Apr 2024 12:23:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/2] gpiolib: acpi: Add fwnode name to the GPIO
 interrupt label
Message-ID: <ZiDmoT9gn7cFaYyV@smile.fi.intel.com>
References: <20240417103829.2324960-1-andriy.shevchenko@linux.intel.com>
 <20240417103829.2324960-2-andriy.shevchenko@linux.intel.com>
 <20240418044907.GO112498@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418044907.GO112498@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 07:49:07AM +0300, Mika Westerberg wrote:
> On Wed, Apr 17, 2024 at 01:37:27PM +0300, Andy Shevchenko wrote:
> > It's ambiguous to have a device-related index in the GPIO interrupt
> > label as most of the devices will have it the same or very similar.
> > Extend label with fwnode name for better granularity. It significantly
> > reduces the scope of searching among devices.
> 
> Can you add an example here how it looks like before and after the
> patch?

Sure:

Before:

  GpioInt() 0
  GpioInt() 0

After:

  NIO1 GpioInt(0)
  URT0 GpioInt(0)

Assuming I update this when applying, can you give your tag?

-- 
With Best Regards,
Andy Shevchenko



