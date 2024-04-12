Return-Path: <linux-kernel+bounces-143092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5485E8A33FE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5F8282F47
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFA014B075;
	Fri, 12 Apr 2024 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UEFQO42R"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA52714900C;
	Fri, 12 Apr 2024 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712940355; cv=none; b=fJp28GtfnrcZTbDomfu08YnwAe8QrnF8FQgJtW1Js/F9s6HB3NG25BvdIg85CnSTycyxwFXn4nmie5oo3FayAaBZtzhRcwEt9e4sfpOi00HiTirUbOWDd2mKJZ72qXw6lD8m7pHDzPUiC12OYnNTWWpm1jt5RIdTTdDBZFpD6Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712940355; c=relaxed/simple;
	bh=y9Yt29vHd8nVHODE69mLVM3p2B463p8ZHm84V3ZPix8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m40TJYZ88SNm8j0B1iZb/BqbBnYYvrxFU6hUhd8vAqsY0iWIaChg0pXITX4zptzaVz+IyCc41WgXoY89Eirq0O6dzeip6SzTX8iyM52rxuob8/LMuYzOxkV3LW3km8jVHKKwReF2EhbG+dbqyL3oJQbkUDVkerw2ufXmKKjGNsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UEFQO42R; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712940354; x=1744476354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y9Yt29vHd8nVHODE69mLVM3p2B463p8ZHm84V3ZPix8=;
  b=UEFQO42RedFyLf35jiqf3h3wp11DVTOFedgGMYOvttFDyN5UxffRa0LY
   p+Y6kSjH4rVhNlEgB/IrWILkHZglPUM3rkyMLFlaOIlOXb4tWqtFVDxeE
   v1ay5ZmgskvLifrk1UkiizHcexpmfDtB10N7WEoY+IG6hqPO8c+qGHJgx
   5QFkiv9qEEnvAYE4K+yxAMDXKB/N0z+ogx2uLSgQL8NEq36G1gn/cV15/
   buCVHDgWBIjRnIAq99qpqBrUnmBHdHMVJDOhZB5bfdWxzAYFhhea8J8It
   C5e4Culy26PcFg9mtvxUsMXo7ygxZ04qjLMd4qxdifQoODQ3TsaAynKbW
   A==;
X-CSE-ConnectionGUID: uiD9kKEWTIW4YxEAsSXg+Q==
X-CSE-MsgGUID: yf/C08fZTGGwk1J9hIGzsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19797470"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="19797470"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 09:45:53 -0700
X-CSE-ConnectionGUID: UH5B1YgpQ9OnH1uDJH94IA==
X-CSE-MsgGUID: p1RMsWI9QiuYZltHW4VVwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="26079046"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 09:45:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rvK28-00000003huv-2pkl;
	Fri, 12 Apr 2024 19:45:48 +0300
Date: Fri, 12 Apr 2024 19:45:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: dwc: allow suspend/resume for 16 channels
Message-ID: <ZhllPOXt41Ndlhc_@smile.fi.intel.com>
References: <20240412060812.20412-1-raag.jadav@intel.com>
 <ZhlU176sS36_JvQU@smile.fi.intel.com>
 <ZhleDwUJLDEG5QwH@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhleDwUJLDEG5QwH@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 12, 2024 at 07:15:11PM +0300, Raag Jadav wrote:
> On Fri, Apr 12, 2024 at 06:35:51PM +0300, Andy Shevchenko wrote:
> > On Fri, Apr 12, 2024 at 11:38:12AM +0530, Raag Jadav wrote:

..

> > > +	data = devm_kzalloc(dev, struct_size(data, chips, info->nr), GFP_KERNEL);
> > > +	if (!data)
> > > +		return dev_err_probe(dev, -ENOMEM, "Failed to allocate drvdata\n");
> > 
> > Haven't noticed before, but we do not print messages for -ENOMEM. Just return
> > the code.
> 
> Any special case for -ENOMEM?

Yes. But I have no link to the discussion at hand. Just believe me, or look into
Git history for changes that drop that messaging. Perhaps one or two will give a
hint where it starts from...

> I found a few drivers which still do.

They should be fixed.

-- 
With Best Regards,
Andy Shevchenko



