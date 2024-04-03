Return-Path: <linux-kernel+bounces-129435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 685CA896AC6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191511F2A5A2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150F9134CEA;
	Wed,  3 Apr 2024 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LA1TqwMj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6F073176;
	Wed,  3 Apr 2024 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136841; cv=none; b=HCUk7ROxz9m8dPmv+S8mJQXaatCROpCq56LZS0F0F52NuCUdRKfEwtMD9880cT6lV9Wb9GRyvtUnwYhL45KW7o7u6XZK/h6lTTfNHiiDSbNmNYlq/WQemEZkytV53QsVn0Zt2LM9BlO9QIedZoxncFBaPaNL/yzUu4Ory+EdY2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136841; c=relaxed/simple;
	bh=5HTqIkS+bDpZY4MoPLw2MQh8KgwOedjsTgpXDE+BV/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rb7pAYybutIDDG5n3N5U1inTs83B2LwrHyFFHCtO3q6SDip32wxK8YsdcVMh5n1V0YsMlF0Bri+GhXe2GV5RUL4OiXy8uhZ/dmJoHc1IaNDfdhNmqFCZIkla3tcm9QqJ10UFmigjN7J9rk7qAUm6rE6oJ/++g+q/wVMQvWp/ggc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LA1TqwMj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712136840; x=1743672840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5HTqIkS+bDpZY4MoPLw2MQh8KgwOedjsTgpXDE+BV/Q=;
  b=LA1TqwMjM9At3Lh5AgwX3HbkYjn/xjRbG9NuasIZo3IB/WmdTSbbMyAW
   mPFLsJfwOM/jQsG8f3uJO5eb2pZivfa9+Ag5JHeyjRGcOiPX4fdpyMQjT
   w0SYhSIkpR2s2F/rRvefsY7h+M0Cogru47s0aGFTmOwGPMxkPkvBoL/HH
   E+7vD1g4W+4OMr97hD3mCbTAxgEFIwH7nNnzsskwcLYN3i5/HgQgXGBQQ
   d8VCnBziaSKUTWS09sfwCqGSn5fRhD70f1QEq4lKF3PLi+iuQd1jXhKHx
   Tl5G7dFBezD0zfUn3399n6q/NFFsNm7Z/PRgNINzSHrBhspFb+HgMNU9v
   g==;
X-CSE-ConnectionGUID: r6ADnr4gSiWkkI/y/GqlRQ==
X-CSE-MsgGUID: BnpWTyTiTdCwaIIzTnLK3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7218968"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7218968"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:33:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915176089"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915176089"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:33:56 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rrx0F-000000014kQ-0yO5;
	Wed, 03 Apr 2024 12:33:55 +0300
Date: Wed, 3 Apr 2024 12:33:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
	Kalle Valo <kvalo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH 21/34] iwlegacy: don't warn for unused variables with
 DEBUG_FS=n
Message-ID: <Zg0igndv5gP4tI26@smile.fi.intel.com>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-22-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080702.3509288-22-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 10:06:39AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The reference to il_rate_mcs is inside of an #ifdef, causing a W=1 warning:
> 
> drivers/net/wireless/intel/iwlegacy/4965-rs.c:189:38: error: unused variable 'il_rate_mcs' [-Werror,-Wunused-const-variable]
> static const struct il_rate_mcs_info il_rate_mcs[RATE_COUNT] = {
> 
> Replace the #ifdef with a PTR_IF() for better compile time analysis.
> The dead code will still get eliminated, but the warning goes away.

..

> +	.add_sta_debugfs = PTR_IF(IS_ENABLED(CONFIG_DEBUG_FS),
> +				  il4965_rs_add_debugfs),

I believe it's not the first and not the last driver that wants this kind of
thing. Maybe
- split out PTR_IF() from kernel.h
- add debugfs_ptr()
- use it?

-- 
With Best Regards,
Andy Shevchenko



