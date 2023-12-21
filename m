Return-Path: <linux-kernel+bounces-8802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A24D781BC77
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3F3286C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B013C627FD;
	Thu, 21 Dec 2023 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+79t/gt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5879D59917;
	Thu, 21 Dec 2023 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703177724; x=1734713724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bQFZFnw74Rrq7PyMdXN/FK8eaoGYTamrHPxwbmZeFgw=;
  b=i+79t/gtquVjAR+aVgmAIaR4dwuEJqlD2HvuU42z/xIkKAeMBhM3KzjA
   tfUiphC/7HpM7upUZtD8fq7qLp0eNK8B89O0CcrND2It2wq4peeDnrE4H
   Zl5NmGWioJlc67rH8VqLH/zBx98pZmDj830rjsRcOsPHsDIRYU346DuTI
   xt1yplIfolKq4kcBkKW04Ca2ui3Dt9+fRO5B5bexO5Y1DrGvXljaJEg9q
   7vWaudsNAKV77jacsw2hpsZjbszIZrmUsolxQwzOZCzYjuFX4pNI32pd+
   v1SjNCYdk9wGtT99RQgt475q95w4yn66MN5h6kgaUxOiDnh7x7KXoiqI9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="380990716"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="380990716"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 08:55:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="895166130"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="895166130"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 08:55:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rGMKL-00000007ton-4C46;
	Thu, 21 Dec 2023 18:55:18 +0200
Date: Thu, 21 Dec 2023 18:55:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
	kubakici@wp.pl, phil@raspberrypi.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 09/18] serial: sc16is7xx: add macro for max number of
 UART ports
Message-ID: <ZYRt9QDnZFozRJRD@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
 <20231219171903.3530985-10-hugo@hugovil.com>
 <ZYMNSqFgAhId-lQ2@smile.fi.intel.com>
 <20231221114103.557409e9875a0f2f95eacfb6@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221114103.557409e9875a0f2f95eacfb6@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 11:41:03AM -0500, Hugo Villeneuve wrote:
> On Wed, 20 Dec 2023 17:50:34 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Dec 19, 2023 at 12:18:53PM -0500, Hugo Villeneuve wrote:

...

> > > -	if (count < 0 || count > ARRAY_SIZE(irda_port))
> > > +	if (count < 0 || count > SC16IS7XX_MAX_PORTS)
> > 
> > ARRAY_SIZE() is more robust than this. What if you change to support different
> > devices where this won't be as defined?
> 
> not sure that I understand your point, because SC16IS7XX_MAX_PORTS is
> the maximum for all devices supported by this driver. The irda_port
> array always has a fixed number of elements set to SC16IS7XX_MAX_PORTS,
> even if the device that we are probing has only one port for example.

For current models of the device, yes. Who knows the future?
Also, ARRAY_SIZE() make it less points to update if ever needed.

> But I can change it back to ARRAY_SIZE(irda_port) if you want.

Please change it back.

> > >  		return;

...

> > > +	WARN_ON(devtype->nr_uart > SC16IS7XX_MAX_PORTS);
> > 
> > Not sure about this, perhaps it's fine.
> 
> This check is only there if we add support for a new device and we
> incorrectly set nr_uart to an incorrect value, which will cause other
> problems anyway, of course :)
> 
> This could be removed.

Let's remove. We can add it back in case something like this (quite unlikely)
happens.

-- 
With Best Regards,
Andy Shevchenko



