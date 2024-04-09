Return-Path: <linux-kernel+bounces-136890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE19089D970
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BF96B22439
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71C212E1D5;
	Tue,  9 Apr 2024 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwsfChMo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8631F12D74E;
	Tue,  9 Apr 2024 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667127; cv=none; b=TZOPWIw2TxQX5n/moMzRHWNiUklaLRZeJvXJZmixDaeH1wsXpBXRzXRpVsxHed8ef/3z5f+OVcCZ/sBA9CNBG9svqOscmQGGEq2bVM1PwLB0Q8YXz2Mtyr+3VYbC1nGOLb2XbJhh0VnAWHpWm/a/6fSG+p7MpNBSQUxwcuH5Nfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667127; c=relaxed/simple;
	bh=hy2lwU0g3yjobcG30ZSLKCrav3rYwNPP3S/donc4pYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quI13dnGZp53igHCZH4kYLzmAS0eAqkrbWN1QVvBTBnjy3HFO9wrc/a4RPJ+fiY3glWvrSmlYESWZJN5tfFOgXqdf+0cLcOPByZOJoldgr9ta+RZ7QJsYlk1bHPIHnyK7Mfcn7+d4m/+aQKdwMfpx/OCfaC5YcNJqf5Nmpq+bSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HwsfChMo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712667126; x=1744203126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hy2lwU0g3yjobcG30ZSLKCrav3rYwNPP3S/donc4pYw=;
  b=HwsfChMoJ5RIfiTKZowS8aM0Nq75b0nFkLOPkTlHXpUpbiBm1hWOTloF
   1PK0FaHo9c5E3i63kQ9TcKYi6eAcFoHq2hzQzTgTGoD/fhP3hlQWEs2t2
   NYyKE5Pjjmd1fQ/9yPWGAFKgvtq/e3vyIKV/Z+HaHkk5T0JXKSQMWsq0I
   Tsw2WLltZBLIbjsqpSpJB8I3rxwqzSaNUt1CFODTUF8TqEgQ4f8bWGkbE
   nd+fpLu8aHADEkhqo1UtOw8eFohkFUrQ3BUXwpGz/6x4lfYsBO7GGnDZh
   o5aISR/5EA4KSCmCmBzMJAyFbe/YocvTZfuUkh5AgRoAaqvuXrOgg72Dk
   g==;
X-CSE-ConnectionGUID: VTiUlIW5TY2IFlSCEoV9Pw==
X-CSE-MsgGUID: Sh7uzmLTS2C7vlU5sBkKgA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8080715"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="8080715"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 05:52:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="915399092"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="915399092"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 05:52:01 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ruAxC-00000002o6w-1HKO;
	Tue, 09 Apr 2024 15:51:58 +0300
Date: Tue, 9 Apr 2024 15:51:58 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 2/2] gpiolib: Update the kernel documentation - add
 Return sections
Message-ID: <ZhU57jB_pVvDz0ZR@smile.fi.intel.com>
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com>
 <20240408231727.396452-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408231727.396452-3-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 09, 2024 at 02:12:51AM +0300, Andy Shevchenko wrote:
> $ scripts/kernel-doc -v -none -Wall drivers/gpio/gpiolib* 2>&1 | grep -w warning | wc -l
> 67
> 
> Fix these by adding Return sections. While at it, make sure all of
> Return sections use the same style.

Since there shouldn't be hard dependency to the first one, can you consider
applying this one, so it unblocks me?

Thank you!

-- 
With Best Regards,
Andy Shevchenko



