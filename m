Return-Path: <linux-kernel+bounces-160382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671D88B3CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9903B1C22765
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF90A13D529;
	Fri, 26 Apr 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IH7Ns+tZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A468248D;
	Fri, 26 Apr 2024 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149199; cv=none; b=j/pL5GNSj6zPehvWvnSLbGF8nXwW3lyAiqtGyYyjkv0PzqO3gRD7LNDYTb4b66/S2Kd/UIviHRyPg3c9O9Suillrco6Gon4YUJR9p5+IURnSgBB4+iFh59D/diiFjbUTcK2xUS0P62F9nnncrj/gtstoL5Mpmvgtq0KqFar9lK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149199; c=relaxed/simple;
	bh=5wObAx7pU4rmk/jDQAZhcRGAbFX+y+N7wcbVVWc1/3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLMBxzOXudS1IVqNmJ6mFrMFFl2hBQXmOOeAn98AKW6jjHOYwzL+GaZoztHApBDa8A0+u+gPRhBoV1M/QbWXn+SK3UC6WNhEXj9hYnNl1HDPQTkgD+PGlBo1mRPm6aosPIXTOQnmE2+jW1qjUVNr0Lvx5lcvNPoPFXdiEIcZoNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IH7Ns+tZ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714149198; x=1745685198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5wObAx7pU4rmk/jDQAZhcRGAbFX+y+N7wcbVVWc1/3U=;
  b=IH7Ns+tZz+NoqNpLWMCL78NqBPVyv33qDPXlrth233acrEk90zArqTY+
   PK7mmF+Zt82Rl1KGsyykrGiKiMj51p60wqBb2sJ+cfqAaV41Yk3wRH0y9
   rEK1LXMmAYQTl4BNLjNwO4klKWlhTAqBfMcBQrX41OEZpSMDeFB0NcuEU
   7GVWi0gfB+pc/h0Qzz0NFj1zjqcvhvNJw1mhYvAcT/zKczT+fDjngsm1W
   Pog/dm54BQESIdzqOlgY22evmTD7vhgk0I6jPlnPlPn9UH5ZlDkq/H5PI
   o7tKtUMSDm1SBgLB6WlDbpXZTlWXEtSugnc7DGc0ck14b5NnzkkPSUwd+
   g==;
X-CSE-ConnectionGUID: AimtCasHReq1hl9FmwSQiQ==
X-CSE-MsgGUID: mXzcWK/tTM6XpDaDXjWxQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="21299055"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="21299055"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 09:33:17 -0700
X-CSE-ConnectionGUID: GrHn9nksTE+kgmSKxHHj+Q==
X-CSE-MsgGUID: oqLZWI5HQyK6FZgPEVDJWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="25470044"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 09:33:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s0OVT-00000001OBZ-2UXq;
	Fri, 26 Apr 2024 19:33:03 +0300
Date: Fri, 26 Apr 2024 19:33:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>, linux-leds@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v1 1/1] leds: sun50i-a100: Use match_string() helper to
 simplify the code
Message-ID: <ZivXP-tdrLXriHOE@smile.fi.intel.com>
References: <20240426152515.872917-1-andriy.shevchenko@linux.intel.com>
 <3557566.iIbC2pHGDl@jernej-laptop>
 <ZivMCljzog7z_SgZ@smile.fi.intel.com>
 <8403927.NyiUUSuA9g@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8403927.NyiUUSuA9g@jernej-laptop>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 26, 2024 at 05:55:22PM +0200, Jernej Škrabec wrote:
> Dne petek, 26. april 2024 ob 17:45:14 GMT +2 je Andy Shevchenko napisal(a):
> > On Fri, Apr 26, 2024 at 05:37:42PM +0200, Jernej Škrabec wrote:
> > > Dne petek, 26. april 2024 ob 17:25:15 GMT +2 je Andy Shevchenko napisal(a):

..

> > > > +		return dev_err_probe(dev, i, "Bad pixel format '%s'\n", format);
> > > 
> > > I know that old code used dev_err_probe() without reason, but could you change
> > > it to ordinary dev_err()?
> > 
> > First of all, it's out of scope of _this_ patch.
> > 
> > > dev_err_probe() is useful only when return code could be -EPROBE_DEFER.
> > 
> > This is simply not true. We are trying to have a uniform output in ->probe()
> > and even documentation for dev_err_probe() was changed long time ago to
> > encourage using it for non deferred probe cases.
> > 
> > > This is clearly not the case here.
> > 
> > Is it a problem?
> 
> Sorry, I missed added note for non -EPROBE_DEFER cases.

No problem.

> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Thank you for the review!

-- 
With Best Regards,
Andy Shevchenko



