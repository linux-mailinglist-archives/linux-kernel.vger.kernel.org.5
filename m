Return-Path: <linux-kernel+bounces-143002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A7E8A3318
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8111F223BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB59D148FEB;
	Fri, 12 Apr 2024 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UhnURz+o"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E98D14882A;
	Fri, 12 Apr 2024 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937930; cv=none; b=G9K7bJXQnq+gJ+P15/oUQbELSe6gJ/MQ+uYLyMMhRQNuaBGaCX+tUhbAtH+K2PN7vMW9mHcTVVjp5mO1+3DFu+oC26ZirOmVQH6I3cWv89V9O8lY0s0CqrSs0ZLXoRd5KIAYN5wua4En+MGgcBcAHC5aQYfxFBVlO2aFF6jHDzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937930; c=relaxed/simple;
	bh=1/NB8a2s0JE38BjWaVVOqDk0x4r1aQh52BXzcj4GQys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWjublxe8KQN4F/dtYAgkMX6mKMvgW99oOWqIjhtqvZUuG1MNOtLTCODbNUecaWjlhknZQQcbgn0NGsB3daUsb0E2Ga2vfYmAfVihWNCN1MlL7qklUJY1RaCxLSg8NE+zZLmmHtBqBovjI6A+zKklaBVSeiOSPg/oxh5JiQdeAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UhnURz+o; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712937929; x=1744473929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1/NB8a2s0JE38BjWaVVOqDk0x4r1aQh52BXzcj4GQys=;
  b=UhnURz+oGh8uiKrRIU7VtHb0zOK74JMozviVJvtdBmxoisqh99MYWIBB
   1u/IhO5MWcyOuOgO9VnosMlDAT0qMD3Imq5vi+lkVXJSBTt3dbb9jRYlh
   A0hmL2m0XsT1ixLr4BC0oBtG1u500aI9Ypo5IVYNBUKhfgIc1/DVH6YNb
   wzp8nGEKSkTEhS2d3xWkUfO4Hjx9iY+2dKqfwEKDpvTyk1UBAOT+f2r5z
   5rjU/VFV5AaB1/gacEn6tSHQUfIcfWfm1ISqj6lRMcfsnuBS7mb/nuyDn
   5BTlf5xHw78Jx0CHlqG8kha6br0G1uVxoeTZ69ONPtaH1Yzmhe0dWTa51
   w==;
X-CSE-ConnectionGUID: yIlp5hboQW2C6uKkuo3Rdg==
X-CSE-MsgGUID: MTQ6WJPySvm/AJDMRhkamA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8567895"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8567895"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 09:03:23 -0700
X-CSE-ConnectionGUID: uuLvFXSJRlefzpNDHNW8Wg==
X-CSE-MsgGUID: bElCKXfUS1O9iknwz3CwWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="52420295"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 09:03:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rvJMx-00000003hFE-3Duc;
	Fri, 12 Apr 2024 19:03:15 +0300
Date: Fri, 12 Apr 2024 19:03:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	David Thompson <davthompson@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 0/4] gpiolib: acpi: Use con_id in
 acpi_dev_gpio_irq_get_by()
Message-ID: <ZhlbQ69161IC4AqM@smile.fi.intel.com>
References: <20240411172540.4122581-2-andriy.shevchenko@linux.intel.com>
 <20240412101944.GE112498@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412101944.GE112498@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 12, 2024 at 01:19:44PM +0300, Mika Westerberg wrote:
> On Thu, Apr 11, 2024 at 08:22:28PM +0300, Andy Shevchenko wrote:
> > Use con_id instead of property in the acpi_dev_gpio_irq_get_by().
> > It will be aligned with other GPIO library functions.
> > 
> > Assumed to go via my GPIO ACPI library tree follwoed by GPIO subsystem.
> > 
> > Andy Shevchenko (4):
> >   gpiolib: acpi: Extract __acpi_find_gpio() helper
> >   gpiolib: acpi: Simplify error handling in __acpi_find_gpio()
> >   gpiolib: acpi: Move acpi_can_fallback_to_crs() out of
> >     __acpi_find_gpio()
> >   gpiolib: acpi: Pass con_id instead of property into
> >     acpi_dev_gpio_irq_get_by()
> > 
> >  drivers/gpio/gpio-pca953x.c                   |  2 +-
> >  drivers/gpio/gpiolib-acpi.c                   | 52 +++++++++++--------
> 
> For the gpiolib-acpi.c parts,
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

Note, I'll will wait for Acks for Mellanox and ACPI code
for a while, the series will appear in Linux Next for the
testing purposes, but if anybody objects, please let me
know.

-- 
With Best Regards,
Andy Shevchenko



