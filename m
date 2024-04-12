Return-Path: <linux-kernel+bounces-143157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4AE8A3527
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73F0288B82
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9490D14D71E;
	Fri, 12 Apr 2024 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbCLiEjh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE1C14B065
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712944389; cv=none; b=GWCYuIm8IW2uW8199BXSOILE45e2M/3f4G8gb9SSovus10wJPju6PRlYu3TJVQa9z1aPN/imCeAd4I8cA1DdKXE2iNZytfavVWFZ3Ts32tU3q2w9PrM3FPgoGfqAbos0WzXWv28LtMsHWnBavOLUu4II1nkP94vmhO0VvJcNE6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712944389; c=relaxed/simple;
	bh=xhMO86cfjGGCHr2NAR4ZuwGYVKaaczvWdt34XD0Z1+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfqIoc1HSVPbkG3xQbpi2CEjdSTPFLP0R4tJV2ydIe1r841p1e70RE7DRVlkPtH+FcEJkZ5crVxs7SyWHGbTzLoQs6DDALKSc8UN650Z0ENIlK82njmfwnhqo10HxnTch4vTcGPyQ9uusil2dAnLfYss0Csp5mgeLKuVLp9LBjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbCLiEjh; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712944389; x=1744480389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xhMO86cfjGGCHr2NAR4ZuwGYVKaaczvWdt34XD0Z1+o=;
  b=UbCLiEjhjPSl51MO24Jlmny24JNhx9t5eCehXxIDI/mNnTxtLMOpTkn9
   opTsI/obt0FeZl9oKlM9oPjOZ2f6bDdt9dsPX4GHM0JGS3YtkC5Cv/zZQ
   7BejkjV3uuEqCOZvUaBammiyO4m8TT8pfJItS/V2mnPgsD4/p3OiZnZ+X
   0vyv2BAna8ak32WcPbVbCv8+PxaAFQcq7ObgDpXBqVAP9mfM1HurRS5wL
   Xz79WeU12EmZYtxvZ9tMubDcyo5BzOGx9rEuGoTbIYd7LdJogiCBJGYUw
   cyMDrHpQFklJ7Tc9bT3QTpjPJvKkN83ynHTKetxA12WnWJjS9Sj2XgWY0
   w==;
X-CSE-ConnectionGUID: wrhqC+t4RKiGgdNYGM8PkQ==
X-CSE-MsgGUID: AkGmM9IYSLK1EY5FgBy/YA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="12199792"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="12199792"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:53:09 -0700
X-CSE-ConnectionGUID: 0/0O1bfpTdCzITWBeC6xyQ==
X-CSE-MsgGUID: z7QjisBWTrKr/X0dtWv+9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="25846959"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:53:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rvL5D-00000003iz0-3QM6;
	Fri, 12 Apr 2024 20:53:03 +0300
Date: Fri, 12 Apr 2024 20:53:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Raag Jadav <raag.jadav@intel.com>, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: Make dev_err_probe() silent for -ENOMEM
Message-ID: <Zhl0_8whWU1ftFeJ@smile.fi.intel.com>
References: <20240412164405.335657-2-u.kleine-koenig@pengutronix.de>
 <ZhlmpPNbEMRye2wZ@smile.fi.intel.com>
 <cl5fmton3n5ayzr7ondnw7lzjaxoppyqhnoervj2fn4et75ish@cyko4abxbslg>
 <ZhlqUdywIur4dzgE@smile.fi.intel.com>
 <zjk3vnydp2yip343khmkq7v5vqbib6d6eyee6tx6h5nph4blzn@c26yrw2cqrt7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zjk3vnydp2yip343khmkq7v5vqbib6d6eyee6tx6h5nph4blzn@c26yrw2cqrt7>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 12, 2024 at 07:47:43PM +0200, Uwe Kleine-König wrote:
> On Fri, Apr 12, 2024 at 08:07:29PM +0300, Andy Shevchenko wrote:
> > On Fri, Apr 12, 2024 at 07:03:01PM +0200, Uwe Kleine-König wrote:
> > > On Fri, Apr 12, 2024 at 07:51:48PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Apr 12, 2024 at 06:44:05PM +0200, Uwe Kleine-König wrote:
> > > > > For an out-of-memory error there should be no additional output. Adapt
> > > > > dev_err_probe() to not emit the error message when err is -ENOMEM.
> > > > > This simplifies handling errors that might among others be -ENOMEM.

..

> > > > 	BUILD_BUG_ON(err == -ENOMEM);
> > > > 
> > > > Done!
> > > 
> > > Well no, that doesn't do the trick. Consider for example device_add().
> > > That function can return (at least) -EINVAL and -ENOMEM. To properly
> > > ensure that the error handling is silent with the current
> > > dev_err_probe(), we'd need to do:
> > > 
> > > 	ret = device_add(...);
> > > 	if (ret) {
> > > 		if (ret != -ENOMEM)
> > > 			return dev_err_probe(...);
> > > 		else
> > > 			return ret;
> > > 	}
> > > 
> > > With my suggested patch this can be reduced to:
> > > 
> > > 	ret = device_add(...);
> > > 	if (ret)
> > > 		return dev_err_probe(...);
> > 
> > Fair enough, but these two should be combined.
> > Mine is for the rejecting a dead code on the phase of the submission.
> 
> So something like the following on top of my change (only compile
> tested):

Hmm, but why macro? Shouldn't compiler be clever enough to see it even for
the exported function?

..

> I don't know if the kernel doc for dev_err_probe() should move to
> include/linux/dev_printk.h then?!

Not if you mark it for the __ variant.

But it has other kernel-doc formatting issues...

-- 
With Best Regards,
Andy Shevchenko



