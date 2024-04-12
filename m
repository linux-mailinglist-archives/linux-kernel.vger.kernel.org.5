Return-Path: <linux-kernel+bounces-143033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 069798A3372
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A246B2217E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E1D148FEE;
	Fri, 12 Apr 2024 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlZCXcez"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9B61487F6;
	Fri, 12 Apr 2024 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938518; cv=none; b=SasC4JdA1hI9l02dgpFVLUM6VMp6F4R5+SBZXZeEEGsfie4xGzax8J7Zh+8eppO/5XQB+t0MTdYjnsWzDO0Cwrstltk6TEvlmaVicJG6IYyseWi2xvITJJzmqikGQeyGnX1Ktba0AycLgpGhg2Qs6SgH3abg6AmLmeULkE4h808=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938518; c=relaxed/simple;
	bh=V1ce7pLVJkYNy1H2D56NR0dfAzQf/796KsVr4ABO0B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkNAF6ca78ANEg7EZZ3D6ATLpftm++bAb98YKkPJ+URGMII8/8IPuTXlRTMbLFoJm+0kUlwWoLBrT1C1hzzp13jMQxH3K0TsaitK7xWX3W6CWHe8AUl7XobWqXOat2+2q/Njn7Jj7GrBeOnKdaOCWXuaPGih/58dHRCZInwy4CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlZCXcez; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712938517; x=1744474517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V1ce7pLVJkYNy1H2D56NR0dfAzQf/796KsVr4ABO0B8=;
  b=MlZCXcezFAoN/UcTunjpI0bcg//EiSUDR2+RiY99cn7lH0gbZn/bSLNx
   Oskgmrot2m2tkuVbbO6E6gmEiuIE3rcoNvYIBE2877g0sJAXb13dxOmJk
   p4j+ch4hifdOsLg0ijpO4/LoG8OlFWJAKfWA4R+EWoP8e1URCWw4MHRsf
   STGeC2Qr/lhp5EXktMCsLg8rzELu4dni/nVTnHgUYcayGGNVRejedPSGU
   4D8YlfLComMGuBbKcrwroW4GsHZ0ki+UHRh4X4+AZ4q8orpUu1dQKf3a8
   U5ekhEGI/9Ik4FXc+gsRgu1whQQ6u9Bm8w3qYhUtiyvzExrVGxUGcRes1
   Q==;
X-CSE-ConnectionGUID: fddpKE/XQ0KpixAwDo0T3g==
X-CSE-MsgGUID: VnE+YxcRRD+VzrP1d1FngA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19548224"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="19548224"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 09:15:16 -0700
X-CSE-ConnectionGUID: KQDw4Xd9STietWAI4ytIoA==
X-CSE-MsgGUID: ud941DghRkOk2DhWFAi44w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21359037"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 09:15:14 -0700
Date: Fri, 12 Apr 2024 19:15:11 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: dwc: allow suspend/resume for 16 channels
Message-ID: <ZhleDwUJLDEG5QwH@black.fi.intel.com>
References: <20240412060812.20412-1-raag.jadav@intel.com>
 <ZhlU176sS36_JvQU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhlU176sS36_JvQU@smile.fi.intel.com>

On Fri, Apr 12, 2024 at 06:35:51PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 12, 2024 at 11:38:12AM +0530, Raag Jadav wrote:
> > With 16 channel pwm support, we're registering two instances of pwm_chip
> > with 8 channels each. We need to update PM functions to use both instances
> > of pwm_chip during power state transitions.
> > 
> > Introduce struct dwc_pwm_drvdata and use it as driver_data, which will
> > maintain both instances of pwm_chip along with dwc_pwm_info and allow us
> > to use them inside suspend/resume handles.
> 
> ...
> 
> > +	data = devm_kzalloc(dev, struct_size(data, chips, info->nr), GFP_KERNEL);
> > +	if (!data)
> > +		return dev_err_probe(dev, -ENOMEM, "Failed to allocate drvdata\n");
> 
> Haven't noticed before, but we do not print messages for -ENOMEM. Just return
> the code.

Any special case for -ENOMEM?
I found a few drivers which still do.

Raag

