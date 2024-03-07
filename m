Return-Path: <linux-kernel+bounces-95797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A20C8752B9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FC02843E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368BE12EBDC;
	Thu,  7 Mar 2024 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gj0eC7BC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49001EA7C;
	Thu,  7 Mar 2024 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824130; cv=none; b=XB4Xbj8I94FnfwepeLPDIoIxwe9L//pa3JAqH5N9zzpNGE4/L7Bp06mAArJ+Ez3CRihfSiNrZOItB9bOKqRBmNnOx9NibgFmBo1StFZVAa1CP6HNzNfJIfaYiouWqea81gMXOv2VsQPk4yfwWVU7CqFvYJQoD46CsajuemXqD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824130; c=relaxed/simple;
	bh=WqrZMC04N0Sq8XLYikG+IzncJ5ECq90e97m4y297rm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hgko7Yh13Pq/O3n5OSJd69haVzPI/CMrr231+94yQKarM1WmpoEhvXRWQfoqGisdg5S0EyICAh/gEmcFbqGZkNVwgsb9GmfFWcovTscc6sjytlmrUKljyCIY97wTuwcLKsF+twP4fzoLepDNEqoExyFwwWPEcecoRjo2hQZjE94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gj0eC7BC; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709824129; x=1741360129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WqrZMC04N0Sq8XLYikG+IzncJ5ECq90e97m4y297rm8=;
  b=gj0eC7BCkZtk38igC/DUOtZOUwI0L9iBJFU4r82LmY4yyS6XL2IIKTcM
   jtjOQzrpgxzVdMSpSExjBNRZova4skUsopYD3buTflUslfxvtS00e803H
   y3L7w9LFGR8WqbAVP+4DOc6ksF7gYha7yfVFsb2yqkKueXq3kBTlscDkM
   BfLznefMCb1z+ywn1RJgruK3x/QSeP+7Ugr274UOpH9G9+HaLRbztn6fw
   x+3RgyqgC1r4Isr9mSNNPQj52RRazz87ryTSZS0e+Tfz6ETkiafJnWkTV
   MFG0WyP98sgTCzLaOnAvYcuYQEOEV6pG3KYCi3/WFlIn6yM2Ifnn2L1qJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4352716"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4352716"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 07:08:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914216576"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="914216576"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 07:08:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1riFMR-0000000AatL-445z;
	Thu, 07 Mar 2024 17:08:43 +0200
Date: Thu, 7 Mar 2024 17:08:43 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] spi: Fix multiple issues with Chip Select
 variables and comments
Message-ID: <ZenYewP2VXJphOJP@smile.fi.intel.com>
References: <20240306160114.3471398-1-andriy.shevchenko@linux.intel.com>
 <20240306160114.3471398-4-andriy.shevchenko@linux.intel.com>
 <32c04b04-17c1-40f6-ad57-6c18e47f4842@sirena.org.uk>
 <ZejOFr4glx-OUSWA@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZejOFr4glx-OUSWA@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 06, 2024 at 10:12:06PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 06, 2024 at 06:08:43PM +0000, Mark Brown wrote:
> > On Wed, Mar 06, 2024 at 05:59:42PM +0200, Andy Shevchenko wrote:
> > > There are the following issues with the current code:
> > > - inconsistent use of 0xFF and -1 for invalid chip select pin
> > > - inconsistent plain or BIT() use
> > > - wrong types used for last_cs_* fields
> > > - wrong multi-line comment style
> > > - misleading or hard-to-understand comments
> > > 
> > > Fix all of these here.
> > 
> > Please don't do this, as covered in submitting-patches.rst submit one
> > change per patch.  This makes it much easier to review things.
> 
> Fine by me, consider this patch as RFC to understand if we want to have this
> or not in general. I will rework it, if the idea is acceptable.

I have sent a new series where I split this to three patches (and excluded
the rest for now).


-- 
With Best Regards,
Andy Shevchenko



