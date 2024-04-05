Return-Path: <linux-kernel+bounces-133274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A7A89A186
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0606284027
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4619F16FF3B;
	Fri,  5 Apr 2024 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UFKUDwYo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F751DFE4;
	Fri,  5 Apr 2024 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331653; cv=none; b=tPJsIdtVge9tl6eXJW88A0x8R0/SZ3UJKKfJ/Od+h/cn4nIoTRCmFg4Yn/Z8Vo29cEi6pqVMTb71ez9cZH6o//6d8vi84jPFs/W/v/2ukDvwm8d/AH2V91odM7mMkG1Rd8w70yAdC+kPgv6Mn9DtXQ1tDsAO26JS/SMvcpSWWCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331653; c=relaxed/simple;
	bh=oEGg+zdE+WnyIiCnbzgQ7uRmt3VoH/bWDMJdCz6YnxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oU8gtY0RTkqe2x7J7vULgIDH5UnyZyBV8PuRnmYL/CupD87KIYBs/+uPSUcs1Pn3f+K43qOrFPeD8DuqKfXFV90sRnAM3eFpd/mnYRt7nmnrHJDzhV7qqiTknCwQmEQEkpuOr/y6MPYgu596pOnx/1vHXn7c+9WBx4RP3hOh4pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UFKUDwYo; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712331652; x=1743867652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oEGg+zdE+WnyIiCnbzgQ7uRmt3VoH/bWDMJdCz6YnxE=;
  b=UFKUDwYorl+ZePM0igE7YL1+EXmeTNtz4QO5/TBJ8wAJJ0dAbFGqjnJz
   V5ATCQ9/7TBFdgV1KynHSkQ+gFHry0P+xz8H/+r2I+FSxqT3Z9xI+hcNS
   0PVMDCM9dJIRekZKYK0iYrXa4VltiLvZTQQa1kJyVReZ/dWnYMiXB2ZMl
   zGkGoWGZnK/wW1UCcCkGyX7vV58O52zPPTpsmo2PQBBRu5N4YIaZhB1KL
   KO095FJba6PzUJXjkTYK9gZixDDoQyrfJ4WvwZUERIkFi1dbKVEwY2SUB
   WsN96jI83xI49CGdzXtG9tHrA1nRQCDEEvpsyK2EQBRrKxo11FlrxI3bC
   Q==;
X-CSE-ConnectionGUID: AJMlaFpkQvy6XhMjgZFWjw==
X-CSE-MsgGUID: Bt830bM2T6aPJaNYzfIIBQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7566076"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7566076"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:40:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="915257359"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="915257359"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:40:48 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rslgM-00000001mwV-05xP;
	Fri, 05 Apr 2024 18:40:46 +0300
Date: Fri, 5 Apr 2024 18:40:45 +0300
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
Message-ID: <ZhAbfcGkt-Bjj9NY@smile.fi.intel.com>
References: <20240404212706.3587456-1-andriy.shevchenko@linux.intel.com>
 <2df0e132-5599-4cb5-93f8-4ed664a5d1cc@infradead.org>
 <ZhAYeMNzHg0x97gN@smile.fi.intel.com>
 <47955de8-dfe5-48c0-bc9b-4e930b8f943e@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47955de8-dfe5-48c0-bc9b-4e930b8f943e@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 05, 2024 at 08:33:26AM -0700, Randy Dunlap wrote:
> On 4/5/24 8:27 AM, Andy Shevchenko wrote:
> > On Thu, Apr 04, 2024 at 09:10:09PM -0700, Randy Dunlap wrote:
> >> On 4/4/24 2:27 PM, Andy Shevchenko wrote:
> >>> $ scripts/kernel-doc -v -none -Wall drivers/gpio/gpiolib* 2>&1 | grep -w warning | wc -l
> >>> 67
> >>>
> >>> Fix these by adding Return sections. While at it, make sure all of
> >>> Return sections use the same style.

..

> >> I would use %true, %false, %NULL, %0, and %1 in a few places.
> > 
> > Why? I specifically removed % from all of them, it's not so useful.
> > Do we have, btw, generated HTML with these % as an example to see
> > the difference. Maybe that helps to understand this better?
> 
> The leading '%' just changes the font style of constants.
> I don't know of any HTML that compares them.

I meant to compare the (HTML) render to see the difference, but you already
explained that it adds/modifies <font> tag or so.

-- 
With Best Regards,
Andy Shevchenko



