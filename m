Return-Path: <linux-kernel+bounces-129441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30724896AD9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622B81C21011
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C91413443A;
	Wed,  3 Apr 2024 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+w0AlWn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0BD33D1;
	Wed,  3 Apr 2024 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137235; cv=none; b=PE4Q9ZZlL7VAcmGszvkiIAQ4Fw90EgaeTSBce+vNnljG5ClO0cCyuhpZPYxEQQrSSzpUO3qr6xsuw705oRPXB0M4QhULfr+XYIupzxagHN61T/shHE+zzNMnDIyUxNE8Vyt3Mt9P2ioe9fPusfy+mMuOj1ERK/omXO2o1d9o0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137235; c=relaxed/simple;
	bh=ICn91gnq+iMytIBB6tqjA6afiAWPNDHdNzxVladSkzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHbRxGKSViJI/KWTxlhQSuGylL3ZbdyNFGvaY7RdbPG+U/VMotIHxCHPoTbd+mlX7DbKmiYlt8OiJf2OVmp8kH5PFOPIheX7MMMnFpZF1vEtvCarTJBNejYGdg86FT4abDj4xh11Um4Ztz1OiU016s4U+XnHvoFtdXt536I+Jok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+w0AlWn; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712137234; x=1743673234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ICn91gnq+iMytIBB6tqjA6afiAWPNDHdNzxVladSkzI=;
  b=R+w0AlWn21m1tBy3TcTZasrA0yi8nlFOLpOL10uLd/nKMC03M79jjpsB
   6V0/ZL8N//5r9lq9/BgzuDYHx2AWFPYk9tnxcFL907gNpxGaQ35RRayf+
   4flf/HGDl287vcjIlhO5a0yr8a60iQtWzN+NJ+CXW7ZS4hRYGO8/wHhv2
   fDHB2XdYPf2B56LbvpR/xNT14OwvpcwMnSAWkXkp6/flBS0OVy4moCV/A
   NoR1TV/wRl42Cq5nwwSIPz3DzvIwHVJXPPKAY7KzgW+tRj53DLWFxlhLW
   uQKX616AFolGkvq9P5ulKFKJeaLzFn8WnJDoKL4tR3m0LZR4w/+x2jkYf
   g==;
X-CSE-ConnectionGUID: jw/2aO/HSRKxzy2nD5ohog==
X-CSE-MsgGUID: Tzd8oo9kQt+pp1Zkfx1J0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7219505"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7219505"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:40:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915176296"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915176296"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:40:30 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rrx6Z-000000014uW-3jLk;
	Wed, 03 Apr 2024 12:40:27 +0300
Date: Wed, 3 Apr 2024 12:40:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-input@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 07/34] Input: stmpe-ts - mark OF related data as maybe
 unused
Message-ID: <Zg0kC6uYFOi-UGXl@smile.fi.intel.com>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-8-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080702.3509288-8-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 10:06:25AM +0200, Arnd Bergmann wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> When compile tested with W=1 on x86_64 with driver as built-in:
> 
>   stmpe-ts.c:371:34: error: unused variable 'stmpe_ts_ids' [-Werror,-Wunused-const-variable]

..

> -static const struct of_device_id stmpe_ts_ids[] = {
> +static const struct of_device_id stmpe_ts_ids[] __maybe_unused = {

__maybe_unused? 

Why not adding it into .driver as you have done in another patch in this series?

>  	{ .compatible = "st,stmpe-ts", },
>  	{ },
>  };

-- 
With Best Regards,
Andy Shevchenko



