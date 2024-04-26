Return-Path: <linux-kernel+bounces-160325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6312A8B3BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D281C243C8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B911E149C7F;
	Fri, 26 Apr 2024 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jX+fdv+m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0783610A;
	Fri, 26 Apr 2024 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146323; cv=none; b=GovL7xmeGUPSDesLZvh4LJfuwL60VQFhOksXe5b9kgodOIQS2kqbT0EbNxKx8AukJ6tMiPYs/3JgwKxZyq/Nzn3lbT/5V95JUG9lQkVZjw5+7NdKeYJw3Y+egNTvO4NcIg4lIqgfubPmdkclevaM9L5sVWMnWwZdUPBtfgzRw/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146323; c=relaxed/simple;
	bh=3q1rFP3fkaatP7Ce6Ut88qG5Pe9hnHyuLRWNk6LfS88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjowSdSgTqQWNvECRScvim9V/WTbCedjRRaM60UI8Yg/kPIiFyE2ovnpU6QZylyWTfgHM+4PBODNGbrTi1x+p75hjLJOQTiz850l3T6IPIAkTBS3P5S9nbKxaTA0DRBAmBZdy6ZTGZsq0CHVRnhf+o/GQ4cJG+qzNzJI4KHpmgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jX+fdv+m; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714146322; x=1745682322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3q1rFP3fkaatP7Ce6Ut88qG5Pe9hnHyuLRWNk6LfS88=;
  b=jX+fdv+maG1jCfhEv+k6iK/shwOK0AUioa5fRQ+oRfltFiYEU7A3cs6N
   fQEV5XzunP2PBAKGB/pfc+r3MBpDchuX90Rrx3H4kta+zMjOHEeK55IVt
   RBdjSKpz+F2GuuC7qNSbbiuaGS1QwOej0VprikuDjLZG8M57vJvZTk9e7
   VtF79/Iq0t+1e1xh1TNAXPPoDhcsmRZlEWrNIN3EphK5xZEeOOhtwHhTR
   oz7XRyNcR5M88xiNyHMKMV+tSnzDw4F49Wdk7LLBRZxzrj6707podIF22
   YMdUqMob5HpTZnUtBl+dJzhWkag3fXyIcc8nq/jGijX3kgvDbwe7KZqW+
   A==;
X-CSE-ConnectionGUID: P2hQ1tn3QvWSo8TYAUe4xA==
X-CSE-MsgGUID: FezPcpM6QsCyiaQYTJW2Iw==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="13674278"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="13674278"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 08:45:20 -0700
X-CSE-ConnectionGUID: HgJh5Oz/QCykWNGoswnlEQ==
X-CSE-MsgGUID: WUOakU+kRoCAt0hmLCwqCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="25531266"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 08:45:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s0NlD-00000001Mo4-0ney;
	Fri, 26 Apr 2024 18:45:15 +0300
Date: Fri, 26 Apr 2024 18:45:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>, linux-leds@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v1 1/1] leds: sun50i-a100: Use match_string() helper to
 simplify the code
Message-ID: <ZivMCljzog7z_SgZ@smile.fi.intel.com>
References: <20240426152515.872917-1-andriy.shevchenko@linux.intel.com>
 <3557566.iIbC2pHGDl@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3557566.iIbC2pHGDl@jernej-laptop>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 26, 2024 at 05:37:42PM +0200, Jernej Škrabec wrote:
> Dne petek, 26. april 2024 ob 17:25:15 GMT +2 je Andy Shevchenko napisal(a):

..

> > +		return dev_err_probe(dev, i, "Bad pixel format '%s'\n", format);
> 
> I know that old code used dev_err_probe() without reason, but could you change
> it to ordinary dev_err()?

First of all, it's out of scope of _this_ patch.

> dev_err_probe() is useful only when return code could be -EPROBE_DEFER.

This is simply not true. We are trying to have a uniform output in ->probe()
and even documentation for dev_err_probe() was changed long time ago to
encourage using it for non deferred probe cases.

> This is clearly not the case here.

Is it a problem?

-- 
With Best Regards,
Andy Shevchenko



