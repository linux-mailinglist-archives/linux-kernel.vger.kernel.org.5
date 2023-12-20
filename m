Return-Path: <linux-kernel+bounces-7386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B147581A71F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A30A1F24508
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B40482E3;
	Wed, 20 Dec 2023 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wi5dmuVs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7EC482D7;
	Wed, 20 Dec 2023 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703098814; x=1734634814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=00wEq3/1+4W80IfUF8pGR8GiIeRA0mqe3d+AD8CvIPw=;
  b=Wi5dmuVs/Wx8ceuxJma/BgSyRjNIBsylAkzOcf8/tG1whWf+7uJEH1zc
   NJttADMNDEqaxj36n7wLKkIR53FPr9W+dprKtVPjnIOUuKcl95MluyoCH
   X1pZC0HPQ0tQTMC5JMZfdAvVWAmVJ+QUG/82kLEafJWRhm0g1izeZ9may
   1FOZPjwrt+19M5Ndvpe7DbyV0rFAQyysw6GwIAvUrwIWXlRzn+yPMCq8K
   uqaf8qWnJY1JRtknl0bKEYv0ez/dCgB9hrnnyD82aU1RNbpeRXe/rDJKT
   9EfYZi5qYA7pxItX2CjqSydmPcFfdTz+LWu0OYvBQ7dLjAJe4uwJ+Cdca
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2696726"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="2696726"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 11:00:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="810700979"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="810700979"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 11:00:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rG1na-00000007ei5-26f5;
	Wed, 20 Dec 2023 21:00:06 +0200
Date: Wed, 20 Dec 2023 21:00:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
	kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 16/18] serial: sc16is7xx: reorder code to remove
 prototype declarations
Message-ID: <ZYM5tkqVPQOuErSb@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
 <20231219171903.3530985-17-hugo@hugovil.com>
 <ZYMPMK2NqGByJnRa@smile.fi.intel.com>
 <20231220113007.c52b01fb215e38f5d2e75086@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220113007.c52b01fb215e38f5d2e75086@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 20, 2023 at 11:30:07AM -0500, Hugo Villeneuve wrote:
> On Wed, 20 Dec 2023 17:58:40 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Dec 19, 2023 at 12:19:00PM -0500, Hugo Villeneuve wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

> > Missing period after ). Otherwise LGTM.
> 
> Will add it for V2.
> 
> By the way, when you say LGTM, would you suggest that I add your
> "Acked-by" or "Reviewed-by" tag, after having fixed what you mentioned?

If you address as suggested, feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



