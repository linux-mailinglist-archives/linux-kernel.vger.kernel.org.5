Return-Path: <linux-kernel+bounces-149857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C968A96E3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE421F2216B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A47C15B571;
	Thu, 18 Apr 2024 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQAKmmos"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984C815B544;
	Thu, 18 Apr 2024 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434467; cv=none; b=hKO1hXApwRxzWTi4TcmlSVWWh4jY3bIYTrJf8iwn/LaWx+Mo116ckvbKHLNko6g80zY/GBeAJOmNiNN5qA9DgzPG1ttVz2mwN6pxi1CS7Ce/damqmlv1IKqEKXH/VaRruXUHZGPmz2mWRVRJ1M/tQYMUTtaoIdR9MC0VIl2a7Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434467; c=relaxed/simple;
	bh=fM1ePhgpIwZy9P8FQ/OKj7GVvhqyF0/kUSuDnqbEfkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia2mWiid8E6PWNzd8Q7aPlqYe5dfhXX4WtR19hEGHR6qvLuCTYKj5M/Jyfw1cF8q4t7Csvbu9tBIazm3fSd9hsRNr1f1YjqmUq8vd/ahkqxTl+G/p/WMnqRfSPbsIYYVpWD79eqdFyNqXBwuqUVSTTrTth2nO9VQX0avz0D2fiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQAKmmos; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713434463; x=1744970463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fM1ePhgpIwZy9P8FQ/OKj7GVvhqyF0/kUSuDnqbEfkg=;
  b=TQAKmmos8SyiZsNc2uxpPgIOchsrYmh8DekeA5loA6b6aXAZ4XuRizjS
   ywrfWHLHteGk4JvnJBE8tHgd8LdKSE9f6pmkg8OwcvMjRuEJZIs7bp4gQ
   VOGCgpNjF/SSS16OkALpZgHxPMRTAaSxsHXPdHcgT6uLhY/qfgZ1/ZuVH
   TN1wDOrgAaB+g5/S8e9fkRJzGDVC9rLK+hELs2AAUEN/P86lUcwJnYDVn
   oiSCj1zGw6WFFMQcsotNgeLYtKTPO1M3k14Dhjp5dNeZU+fIRWpHi4atf
   voDdJ+XsdeXy5ZYF/ps7cksjVmDg9H9Kz2z3YFat8ZD2gSWVEQDewD1P6
   Q==;
X-CSE-ConnectionGUID: he1V1EQJQjGEPB3MfuJr+g==
X-CSE-MsgGUID: PCNhjRlVQ5+QnB83dxbePQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8835713"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="8835713"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 03:01:02 -0700
X-CSE-ConnectionGUID: kGVxlc+ST0yIpkknT1njyw==
X-CSE-MsgGUID: WsLN18P7TRSF8QOMuUHihg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="22803176"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 03:01:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxOZd-00000000I5c-0z8U;
	Thu, 18 Apr 2024 13:00:57 +0300
Date: Thu, 18 Apr 2024 13:00:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/2] gpiolib: acpi: Add fwnode name to the GPIO
 interrupt label
Message-ID: <ZiDvWObx-UyXEmw4@smile.fi.intel.com>
References: <20240417103829.2324960-1-andriy.shevchenko@linux.intel.com>
 <20240417103829.2324960-2-andriy.shevchenko@linux.intel.com>
 <20240418044907.GO112498@black.fi.intel.com>
 <ZiDmoT9gn7cFaYyV@smile.fi.intel.com>
 <20240418093359.GQ112498@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418093359.GQ112498@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 12:33:59PM +0300, Mika Westerberg wrote:
> On Thu, Apr 18, 2024 at 12:23:45PM +0300, Andy Shevchenko wrote:
> > On Thu, Apr 18, 2024 at 07:49:07AM +0300, Mika Westerberg wrote:
> > > On Wed, Apr 17, 2024 at 01:37:27PM +0300, Andy Shevchenko wrote:
> > > > It's ambiguous to have a device-related index in the GPIO interrupt
> > > > label as most of the devices will have it the same or very similar.
> > > > Extend label with fwnode name for better granularity. It significantly
> > > > reduces the scope of searching among devices.
> > > 
> > > Can you add an example here how it looks like before and after the
> > > patch?
> > 
> > Sure:
> > 
> > Before:
> > 
> >   GpioInt() 0
> >   GpioInt() 0
> > 
> > After:
> > 
> >   NIO1 GpioInt(0)
> >   URT0 GpioInt(0)
> > 
> > Assuming I update this when applying, can you give your tag?
> 
> Sure. For both,
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



