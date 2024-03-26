Return-Path: <linux-kernel+bounces-119996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2180088CFE3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48C31F64453
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A215013D624;
	Tue, 26 Mar 2024 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQI0sbTY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBFC13C9CD;
	Tue, 26 Mar 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711488034; cv=none; b=DjU/Fnskp2Upzdz75BJLKEp4ChENK7P8b/q7lg94PE0CA+VH2F0uDInsE03LaxuMUd9LUwd3eMeIC9vV4q05iCX/2LraAEpZeBCQcK+JhfsNZK0zxXTHVdU6qAb6UK2b4HstZmwNELqi5qrKtBMPuTOHutqHm5W+KUONUH9NTYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711488034; c=relaxed/simple;
	bh=bfaen3V+dqtoJw9rubpHqAQUMPxS69aDZd7fo+2v9nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPkRKOxreHNxNiO8mVKE3nGSzm4X9S+T1cQQyTv7JJ8+0+sKjwESBa9zhrH96bwawbxwa+WEE0Xl3/6jfXW78PD3YOI1JcEfVarjVQ6TC2YviB4OJf/5oWRs0dU1WrabAkm1BxN8VWFmGTHNUZ1D4IoHOLl9r4IXnUxXzgxCfdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQI0sbTY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711488032; x=1743024032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bfaen3V+dqtoJw9rubpHqAQUMPxS69aDZd7fo+2v9nY=;
  b=SQI0sbTYfCe7mlsAqu0OYYcOQaRGblJELQY5dTnsPzt7imVFOnm7SsyV
   ZBgjJjhcfP7OsxAnaxlIh0/Onf4bJR2FFNCGmtStNQxAiPjwXhW58XF0K
   +lsEkjfj7Fu7p48bm3GlwbbbfA0dbOTFPAjeZWn0ffMBSVKbAgR6lp7fm
   wC9YchO2m1rEIDGg/VbnrWhuX0kydKRuDHQ0s6BmEqkjQD2ssLjAlWzf7
   MHVtlAgDjsOApcNxzh1HtS3TLKDmRtw20uly5DY83DnzF45AuU0gfJtX7
   AP3QABJPlBzFqzcRDNZg1xzYEEg4r7sjKEciue/J5SSjI2WFBPdooTymc
   w==;
X-CSE-ConnectionGUID: IK9XDmifQRmbSe7wwTIIxA==
X-CSE-MsgGUID: DdA6STCFS/uoqGiwFx/CGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10366007"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="10366007"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 14:20:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914891004"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="914891004"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 14:20:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rpEDa-0000000GSyA-3BT8;
	Tue, 26 Mar 2024 23:20:26 +0200
Date: Tue, 26 Mar 2024 23:20:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 07/10] spi: pxa2xx: Provide num-cs for Sharp PDAs via
 device properties
Message-ID: <ZgM8GrsaqQb-EjC2@smile.fi.intel.com>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
 <20240326181027.1418989-8-andriy.shevchenko@linux.intel.com>
 <dcdf8c46-acdc-466d-afc6-caf0e0fa39e8@sirena.org.uk>
 <ZgMY3AeC1Jnh1Oru@smile.fi.intel.com>
 <c18186c0-63d8-4406-add0-980f723e3528@sirena.org.uk>
 <ZgMsHFJObZ48Erzt@smile.fi.intel.com>
 <6f6c96d3-051a-4437-9c95-6b8be7847705@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f6c96d3-051a-4437-9c95-6b8be7847705@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 08:26:11PM +0000, Mark Brown wrote:
> On Tue, Mar 26, 2024 at 10:12:12PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 26, 2024 at 08:02:57PM +0000, Mark Brown wrote:
> 
> > > It is not clear to me that this makes the kernel side better, it just
> > > seems to be rewriting the platform data for the sake of it.  If it was
> > > converting to DT there'd be some stuff from it being DT but this keeps
> > > everything as in kernel as board files, just in a more complex form.
> 
> > Not really. The benefits with swnode conversion are the following:
> 
> > - reducing custom APIs / data types between _shared_ (in a sense of
> >   supporting zillion different platforms) driver and a certain board
> >   file
> 
> > - as an effect of the above, reducing kernel code base, and as the result
> >   make maintenance easier and bug-free for that parts
> 
> I'm more worried about the possibility of breaking things with swnode
> support than I am for board files - with board files you've got a good
> chance of failing to compile if things get messed up, with swnode you
> can typo a property or whatever and silently fail.

I understand that, but here it's consolidated in a single series
and not supposed to be modified in the future, only dropping or
properly converting.

Btw, you may say the same about the all patches that converts to
GPIO lookup tables (one typo in the not-so-often used GPIO line
device ID name), but I don't remember that kind of conversions
got much of objection.

> > - preparing a driver to be ready for any old board file conversion to DT
> >   as it reduces that churn (you won't need to touch the driver code)
> 
> The driver appears to already have DT support (there's a compatible for
> MMP2 in there)?

The MMP2 is using default number of chip select pins.
Also note that my reply is generic (I used 'a driver' form).

-- 
With Best Regards,
Andy Shevchenko



