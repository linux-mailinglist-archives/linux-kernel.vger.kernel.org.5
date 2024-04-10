Return-Path: <linux-kernel+bounces-138693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAE489F91B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E723828A81E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0479615EFD2;
	Wed, 10 Apr 2024 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L42VrYWg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF82415E7E6;
	Wed, 10 Apr 2024 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757575; cv=none; b=XFOTsb3/77r0o2GCEDGZjazB4FEIBy6K4r8qnv5eUdKMWuOmFmHz+k9OFLEdtvAC8Nc2pXQC3YogpaBFKxIKM8HWIx7S1t+33c7zF8JU43+O88qQPkW2O0MM/jUkxEjXmCb9MtZi0JY5iwYNLGhMN2d7+cYGGU7o47vGqtiPIPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757575; c=relaxed/simple;
	bh=KzIwAs0WuSRVdxrxETt53ZODVPWPZANummHTPBLM92g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btU3Gz6gq1I14cLFzpmqA2rJYObyucTUsgGpYC+U4hSti4beQqFibzKRTSYNPnOZTLPgTlKb88TQGQJtVbQwRT8r6sMDouhap1zFynHIYX6AULIV7UV4qolJYz9TNyS+Hasq3pbC5eShmPvzMkb2YvVD8WoILSwmMszGdQqMbsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L42VrYWg; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712757574; x=1744293574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KzIwAs0WuSRVdxrxETt53ZODVPWPZANummHTPBLM92g=;
  b=L42VrYWgU6IzUNSnkINbQMgH4duX2iZ591pjCnZ80afEty4yJJtjZMie
   s6P0fWcePfbnMleZSFDGdaDnCGB7plOPWl9oB/kN2XOWV6lAHt50KxP2D
   Kt5epZYmAyLYrgtw0DbWfgUp6XYnARBBJqccJjj7LKNmOu1tXPGlsN2YK
   k2Sb2LnnnaY/5g7MACGZu+kcbvPz7ZblOOwzHFWSE49q0ULLpLVhbBbyf
   cdAmSNQbz4vgCSzXTXTVphakAbjEAmp5MzQ9cEOND3c59YgdK5PBNXnU8
   UyWbUs9W/Tz5zDY5jQm43wMn+odkdKPwFcIRwIyFUh7G0An/vG4XKYuFn
   w==;
X-CSE-ConnectionGUID: UoQNj6plTdqvTSajANgE4Q==
X-CSE-MsgGUID: h9eqBgaCSiqIlkbNKePQYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7993181"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7993181"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:59:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915433717"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="915433717"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:59:28 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ruYU0-000000035Gi-3T2g;
	Wed, 10 Apr 2024 16:59:24 +0300
Date: Wed, 10 Apr 2024 16:59:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: lakshmi.sowjanya.d@intel.com
Cc: tglx@linutronix.de, jstultz@google.com, giometti@enneenne.com,
	corbet@lwn.net, linux-kernel@vger.kernel.org, x86@kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, eddie.dong@intel.com,
	christopher.s.hall@intel.com, jesse.brandeburg@intel.com,
	davem@davemloft.net, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com, perex@perex.cz,
	linux-sound@vger.kernel.org, anthony.l.nguyen@intel.com,
	peter.hilber@opensynergy.com, pandith.n@intel.com,
	subramanian.mohan@intel.com, thejesh.reddy.t.r@intel.com
Subject: Re: [PATCH v6 11/11] ABI: pps: Add ABI documentation for Intel TIO
Message-ID: <ZhabPIK_zDJgVf4c@smile.fi.intel.com>
References: <20240410114828.25581-1-lakshmi.sowjanya.d@intel.com>
 <20240410114828.25581-12-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410114828.25581-12-lakshmi.sowjanya.d@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 10, 2024 at 05:18:28PM +0530, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> 
> Document sysfs interface for Intel Timed I/O PPS driver.

..

> +Date:		March 2024
> +KernelVersion	6.9

This boat is already sailed...

-- 
With Best Regards,
Andy Shevchenko



