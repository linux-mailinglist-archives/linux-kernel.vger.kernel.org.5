Return-Path: <linux-kernel+bounces-166675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 670A58B9E01
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B60A4B23082
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2C715CD71;
	Thu,  2 May 2024 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="htkOspyq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC8315B969;
	Thu,  2 May 2024 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665672; cv=none; b=EPKulY2kmAnwPLSfGFXuBDZ+N4Aq6dFcZbr5IujQRYbJ0tUEIme2xgNXqowJdw6gAbkHBnXaSe8x9ERgu7IIh+m3dlq6hbku5fXqtIuHxblSTMDgsAHJnUbnsfDd4MlMzjZDTWd3phKF3M+MWt/5b7hj6XWOs5d5cZT2YmyVX/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665672; c=relaxed/simple;
	bh=rmjcNH+ZTSoc/1UT/NWlL2n8lWjoJKfCm5nzaw3bECc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2dyTr9a+fK5+pXsjBVcTeUjjrq5UOLnyJqsMJ1oXGvwWYrWziUNByz8aVj08I95y9iSW/xIjD2bY537bdwr4f2eZ75dg/YBgWHeMafMRJlGqplu6pdcXz5/BPOeKWnejQxvvWWemtQjsFiV1SbTp41i9d8FPdBRCLKVc442GWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=htkOspyq; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714665670; x=1746201670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rmjcNH+ZTSoc/1UT/NWlL2n8lWjoJKfCm5nzaw3bECc=;
  b=htkOspyqXpWvNnKeVDmk2Rk3YO2ZwaVZGR+mGbAvGBgW+xiWyGsVmqBb
   jv/xVo8WUgWKUhz3nF+YW30/wTD2K0gSsCAxRiVjQz2GYwO1XGI72abK6
   O88J2tKwdrgiyxuqrqxEwhsRledA5Mu4hFTtM3S9Mjbvrhu1un1TzD58/
   z/9F9Iu4rYkYOSjYXkHNulpRTu0H4BQUG4/Z7brHAltlOmgpjCelq1Dnr
   cDxtyuM3z4g8NcBnIiCIUzNhwRXMqID25i4CFO2ainR9Q+N2rX3U8MYVX
   nYbRiVHv1Ogjy/ZLnpNtJFKUxDFP6J1TibJVVGGIFVZKIcoe7rH+s+OeC
   A==;
X-CSE-ConnectionGUID: obWZy3azSdmLcPx1WebbWA==
X-CSE-MsgGUID: 4ceZZKyYTK+VLcH87Hli6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="35827781"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="35827781"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 09:01:06 -0700
X-CSE-ConnectionGUID: xE3/2ZyLRpuS+xpcAQzQTA==
X-CSE-MsgGUID: s4ohJMlQS1iixfKjy2SqgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27562547"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 09:01:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2Yrl-00000003N3v-2khN;
	Thu, 02 May 2024 19:01:01 +0300
Date: Thu, 2 May 2024 19:01:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 00/13] serial: 8250_exar: Clean up the driver
Message-ID: <ZjO4vYEBzxU3fpzC@smile.fi.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
 <20240502114645.4445b3da@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502114645.4445b3da@SWDEV2.connecttech.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 02, 2024 at 11:46:45AM -0400, Parker Newman wrote:
> On Thu,  2 May 2024 17:43:54 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > After a rework for CONNTECH was done, the driver may need a bit of
> > love in order to become less verbose (in terms of indentation and
> > code duplication) and hence easier to read.
> >
> > This clean up series fixes a couple of (not so critical) issues and
> > cleans up the recently added code. No functional change indented by
> > the cleaning up part.
> >
> 
> Just an FYI I submitted a patch series that fixed several of these issues but I
> think it fell through the cracks (I know everyone is very busy!).
> 
> Link: https://lore.kernel.org/linux-serial/cover.1713533298.git.pnewman@connecttech.com/
> 
> I believe my previous patch series is no longer required. This one fixes
> everything.

I haven't noticed that, if it contains duplicated patches, I may replace mine
with yours if you insist.

In any case it's better to reply there that you prefer this series to be
applied, so Greg will not pick it up.

-- 
With Best Regards,
Andy Shevchenko



