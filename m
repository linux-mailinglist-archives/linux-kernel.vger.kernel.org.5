Return-Path: <linux-kernel+bounces-66993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E31F8564AF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5343BB2F40E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F31130AF7;
	Thu, 15 Feb 2024 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gywuzh24"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B8612BF3D;
	Thu, 15 Feb 2024 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004179; cv=none; b=gicxQXISt3sKlCxGrWlHZwBJLiK6zMCBbZBMGuW6iDFcgieGjplTrYONMUpPTbGUq1Wd07DZxDHcn9lrnrUCzqQ0niK1dKBSZu/O3JkoD2H12fMOQaEi2Ggw3D2xNRku1lTaTsIg9G2XfXdwJsz52cNj4K6/mdgGD5KAsBzquJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004179; c=relaxed/simple;
	bh=wKwVgYFc688UeLNGciCD/DyW+yTu3pIXDuMz+D2rtjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2rwiaJWTh6ea7Mdp0ixt7Bir3cem8oOcIf2Xs/iDpWbdeqdjA6rY2lEhSlO3kXLNB4jkS6XuUExn84nJ+NmDs0ZBog60mIfltqpbMTrIlVruzlFARa3WsYL5rfyNXNWsvoZwqku91FMGf2uV2BoryTB+5ko/m0lELRRPKsfy+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gywuzh24; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708004178; x=1739540178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wKwVgYFc688UeLNGciCD/DyW+yTu3pIXDuMz+D2rtjg=;
  b=gywuzh24ibV/kWXPBHYJiMDdmkU4YhqjvGX+vlF+C7ro7sF6ZyD4k2NO
   bSzfEXzdfNygtynjYmtR8EYjlQ9pVDAbSv72QU2tdTqxZXaUeCUwpacDw
   3zEXmRJisUDGj4d3s9y1QFY+wFWSezlrMDbi+MPlHMkx2cZBs8LRnsUZ0
   8OfQtL9UhvjX1ted14EulZoDb5aJapVj6C9bvb4myy3v2/FcqlKby0qjj
   AxCHxBTbHnb8tJIM58Pi4lK1GzmMZVO4drQ6l96iIMH9BwgZHn4ArAU/O
   lmqx5LVIGOZjXxXfJvuYSyLMLk2CVDybrJMWKgGvuFt9l3bmqW4iQoh7V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2234316"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="2234316"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 05:36:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="935667293"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="935667293"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 05:36:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rabuP-00000004ngF-005z;
	Thu, 15 Feb 2024 15:36:13 +0200
Date: Thu, 15 Feb 2024 15:36:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Raag Jadav <raag.jadav@intel.com>, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] pwm: dwc: drop redundant error check
Message-ID: <Zc4TTLetiGhJlx8d@smile.fi.intel.com>
References: <20240208070529.28562-1-raag.jadav@intel.com>
 <20240208070529.28562-2-raag.jadav@intel.com>
 <qrwcje4t2pbbxilnlfz2q7njodcp6vl54uaypdbvjgvwhgvc5g@4eq5wvumpjjx>
 <ZcUJoSMhgC7lhY-H@smile.fi.intel.com>
 <cv6w4n2ptcdehn5n3mipuyfrtemm4rldhiyppazk4uqdn2xx7e@hxg4kldaacxk>
 <Zcz-csPY5x29DP7v@smile.fi.intel.com>
 <sd2ugzjrmrdvcyxotoyg53qp3i7ta4yko225ln3gk4fmik7iof@a7mab6o2kkvz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sd2ugzjrmrdvcyxotoyg53qp3i7ta4yko225ln3gk4fmik7iof@a7mab6o2kkvz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 10:22:57AM +0100, Uwe Kleine-König wrote:
> On Wed, Feb 14, 2024 at 07:54:58PM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 14, 2024 at 06:45:48PM +0100, Uwe Kleine-König wrote:
> > > On Thu, Feb 08, 2024 at 07:04:33PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Feb 08, 2024 at 08:46:44AM +0100, Uwe Kleine-König wrote:
> > > > > On Thu, Feb 08, 2024 at 12:35:25PM +0530, Raag Jadav wrote:
> > > > > > pcim_iomap_table() fails only if pcim_iomap_regions() fails. No need to
> > > > > > check for failure if the latter is already successful.
> > > > > 
> > > > > Is this really true? pcim_iomap_table() calls devres_alloc_node() which
> > > > > might fail if the allocation fails. (Yes, I know
> > > > > https://lwn.net/Articles/627419/, but the rule is still to check for
> > > > > errors, right?)
> > > > 
> > > > We do not add a dead code to the kernel, right?
> > > > 
> > > > > What am I missing?
> > > > 
> > > > Mysterious ways of the twisted PCI devres code.
> > > > Read the above commit message again :-)
> > > > 
> > > > For your convenience I can elaborate. pcim_iomap_table() calls _first_
> > > > devres_find() which _will_ succeed if the pcim_iomap_regions() previously
> > > > succeeded. Does it help to understand how it designed?
> > > 
> > > I assume you're saying that after pcim_iomap_regions() succeeded it's
> > > already known that pcim_iomap_table() succeeds (because the former
> > > already called the latter).
> > > 
> > > I'm still concerned here. I agree that error checking might be skipped
> > > if it's clear that no error can happen (the device cannot disappear
> > > between these two calls, can it?), 
> > 
> > It depends. If you call it in some asynchronous callbacks which may be run
> > after PCI device disappears, then indeed, it's problematic. But you probably
> > will have much bigger issue at that point already.
> > 
> > In ->probe() it's guaranteed to work as I suggested (assuming properly working
> > hardware).
> 
> Assuming properly working hardware allows to drop many error checks :-)

Yes, and we have some checks are being not implemented ("dropped"), but here is
the thing: this is a PCI device and surprise removal (while it's not possible
for the on-die devices) should be handled differently, not related to this code
anyway. Malicious hardware is out of scope either.

> > > but for me as an uninitiated pci code
> > > reader, I wonder about
> > > 
> > > 	dwc->base = pcim_iomap_table(pci)[0];
> > > 
> > > without error checking. (OTOH, if pcim_iomap_table() returned NULL, the
> > > "[0]" part is already problematic.)
> > 
> > Seems it's your problem, many drivers use the way I suggested.
> > 
> > > I'd like to have a code comment here saying that pcim_iomap_table()
> > > won't return NULL.
> > 
> > Why? It's redundant. If you use it, you should know this API.
> > So, the bottom line, does this API needs better documentation?
> 
> If a driver author knows it while writing the code, it's obvious. But if
> the driver author looks again in 2 years or someone else (e.g. me with
> the PWM maintainer hat on and with little pci experience) that knowledge
> might be faded.

This is widely used pattern. Anybody who works with Git should know how
to use `git grep` tool. If in doubts, always can ask in the mailing lists.
I still consider it redundant.

P.S. That's what you call "bikeshedding" (done by yourself here)?



-- 
With Best Regards,
Andy Shevchenko



