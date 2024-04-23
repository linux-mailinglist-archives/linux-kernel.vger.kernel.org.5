Return-Path: <linux-kernel+bounces-155861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 047BC8AF826
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E84FB2213D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6364D142E88;
	Tue, 23 Apr 2024 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2osmulO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35676142E73
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905148; cv=none; b=jfqgbrrVg21CmO4ofUFYZXSgw9cTkrfOaqcnWoVFLirgsTEbrpZBu0NW2jzUXu+AIZ+6XREgHQ4S/P+ze/cBNDie9Ac3M36Ypa9WWsSdhnk5Z5Jseqekdhx6P9iCtNeHvsllucFEuCOzaOhYgbIkZQhzsgVMx8kWkzayWuaI64U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905148; c=relaxed/simple;
	bh=db/jYTmQgIcatu4krOyw8W95WHarmYXRnUjtGzfjh94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWFiyeBmbpnOlAwtPI5DX9A9pJJ4mqHxOHiZPHSLIB/2SiL6gc9IuopcSqdr733eA0QU7dodfFHAtPYpyuSJLdQOKx/iEXd14BLc0ymszf+/TJOlTuMQml+7YPSPuFd7UoItb+OtBGvnEqPxvd9GUPXWKQ82WzM9Tv/Zsy19snU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2osmulO; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713905148; x=1745441148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=db/jYTmQgIcatu4krOyw8W95WHarmYXRnUjtGzfjh94=;
  b=E2osmulO9LQVZK5bRbCQc+b3xi1mN2QdoE4YzsT4aOA2XIJygNeMSbnp
   YZQ0116EzJFspsuOubvjJsGt/PUo2XDpPoMFu63MdIBHdt54O81fIVrl2
   wVW8i5EdzZjSgH6Sv44QkJOMIV8/RZgmE3Lewcw4+T17kOL+3GDJI/cjg
   e5sI4yd0jVVG2DgUo3r8e+RamiiGhbupjLLNJsEP4+oupBqj9CRCyqJ4y
   EQ1fapdIRQ8NJrH0+NgGdLegpW7jEiXVBaGwHv4j5qObt6EHyMYPnADKj
   mvw7YzDOE5HZGDb/XJN9h8eW9dQUI2EY+ca2vDgE7cYTXrgsienLDM/GX
   A==;
X-CSE-ConnectionGUID: W265MWxbQdiUGYbX43VDcg==
X-CSE-MsgGUID: G7xX/clPRt6xusAgIVTtSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="13300339"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="13300339"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:45:47 -0700
X-CSE-ConnectionGUID: NBYlrgBOQnyVFlWFwK0ryA==
X-CSE-MsgGUID: ykouW7uTR8CeUKKtMsy/dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="61939027"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:45:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzN1K-00000000TFX-1yu0;
	Tue, 23 Apr 2024 23:45:42 +0300
Date: Tue, 23 Apr 2024 23:45:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 1/1] mm: page_alloc: Avoid defining unused function
Message-ID: <Zigd9lrV7gffp8hQ@smile.fi.intel.com>
References: <20240423161506.2637177-1-andriy.shevchenko@linux.intel.com>
 <20240423111000.aaf74252a07d7e7fd56d7e12@linux-foundation.org>
 <Zif9e5ByqBKJ9rgQ@smile.fi.intel.com>
 <20240423203020.GB318022@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423203020.GB318022@cmpxchg.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 04:30:20PM -0400, Johannes Weiner wrote:
> On Tue, Apr 23, 2024 at 09:27:07PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 23, 2024 at 11:10:00AM -0700, Andrew Morton wrote:
> > > On Tue, 23 Apr 2024 19:14:43 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > In some configurations I got
> > > > mm/page_alloc.c:656:20: warning: unused function 'add_to_free_list' [-Wunused-function]
> > > > Becuase the only user is guarged with a certain ifdeffery,
> > > > do the same for add_to_free_list().
> > 
> > ...
> > 
> > > Thanks, I'll queue this as a fix against "mm: page_alloc: consolidate
> > > free page accounting".
> > 
> > Thank you!
> 
> Thanks for the fix. We switched most callsites to __add_to_free_list()
> now, I didn't realize the memory failure code was the only one left.

You're welcome! Hint to the future `make W=1` should be a must during
development.

> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

-- 
With Best Regards,
Andy Shevchenko



