Return-Path: <linux-kernel+bounces-131684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AE9898AC4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0DC1F2393C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E426B7580B;
	Thu,  4 Apr 2024 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hU3rl6Fm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64331D537;
	Thu,  4 Apr 2024 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243554; cv=none; b=NZVA0g1XzZLAk/pbhnH34D/cyzbONYaeHvUyWFRHyNROzXCmJPQBh9Uh9Vjpn4x2tjZHF5m/uW4zKZsuZ8wTPTic8EWkKPWPlRRI3JCA591rp6+4DHNtQmUCTvtSgaRDXZYcbrz/ZhYLOFed/39ndQE8j7ZBijKMKyjAoMjrORg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243554; c=relaxed/simple;
	bh=KXMKvxsX3P7GTLDGYS/XjwNXNpkgSskOK50Dib3MKuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhhuTWv5f4/+pD0txHoelkm0CtOJvjf/irt04IehREL+LhAj1CsLPipsBngLj5HO+6BNyYXDBj8rAAqDSCGT0266JNd+pnlY02JdcZOcTi98iHf6MyTU1FzBCmrm//P53nlXNCKy9eBczIlv+UtK9t3ZVdk0D6KsiL+/SPvtoAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hU3rl6Fm; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712243552; x=1743779552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KXMKvxsX3P7GTLDGYS/XjwNXNpkgSskOK50Dib3MKuQ=;
  b=hU3rl6FmVd3/3L4eWA2yI7DZt19qlr3aAweoQ0+KbOob0zppMjZoLs8A
   3n4R8UasYfZ9ADMzO8ByfmpQ1JgiazzZvjNJOyPRWDM1x/3wkQY4HafeQ
   kjS8+hlyVz/T1qW9bRJUSkKT67f5sAfUOmY8CzSZB/BG8Yd5MsSrUQ09f
   k37XCBogxoqV200mtaVPy4EwZRM9m9UAd2ioK0V+jmkRcTpjGYw76/4ZT
   TntWZ0ZK+WmrJdllG2GKb01BOBTbRlfvuApIeO74k8CHZM1kt4dQJP4rT
   8FzssSZQDxCeyHZMWTL+Cg1QK4sAioDDEEoOcDBsudKI3VdjZNLk1tLPu
   g==;
X-CSE-ConnectionGUID: 2CMOEP2RQh+eO27iMamMVw==
X-CSE-MsgGUID: Q9x++XKMR5emU/+E9xXovA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7374010"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7374010"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 08:12:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="915221023"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="915221023"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 08:12:28 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rsOlO-00000001UZT-11Vc;
	Thu, 04 Apr 2024 18:12:26 +0300
Date: Thu, 4 Apr 2024 18:12:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Petr Mladek <pmladek@suse.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jyoti Bhayana <jbhayana@google.com>,
	Chris Down <chris@chrisdown.name>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: backend: make use of dev_errp_probe()
Message-ID: <Zg7DWQtY6SP9E_1m@smile.fi.intel.com>
References: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
 <20240404-dev-add_dev_errp_probe-v1-3-d18e3eb7ec3f@analog.com>
 <Zg6bsS3WMvp-nY3S@smile.fi.intel.com>
 <9f91388faee750e16021f2c0544e7a158a16202b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f91388faee750e16021f2c0544e7a158a16202b.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 04, 2024 at 04:58:27PM +0200, Nuno Sá wrote:
> On Thu, 2024-04-04 at 15:23 +0300, Andy Shevchenko wrote:
> > On Thu, Apr 04, 2024 at 01:06:25PM +0200, Nuno Sa wrote:
> > > Using dev_errp_probe() to simplify the code.

..

> > > +	if (IS_ERR(fwnode))
> > > +		return dev_errp_probe(dev, PTR_ERR(fwnode),
> > > +				      "Cannot get Firmware reference\n");
> > 
> > ERR_CAST() seems quite good candidate to have here.
> > 
> > 		return dev_errp_probe(dev, fwnode, "Cannot get Firmware
> > reference\n");
> > 
> > (Assuming dev_errp_probe() magically understands that, note you may have it as
> >  a macro and distinguish parameter type with _Generic() or so and behave
> >  differently: ERR_PTR() vs. ERR_CAST(), see acpi_dev_hid_uid_match()
> >  implementation, but also keep in mind that it doesn't distinguish NULL/0,
> > there
> >  is a patch available in the mailing list to fix that, though.)
> 
> Do we care that much for going with that trouble?

I don't think we do. We are not supposed to be called with ret == 0/NULL.
That's why I pointed out to the current version.

> I understand like this we go
> PTR_ERR() to then comeback to ERR_PTR() but this for probe() which is not a
> fastpath. So perhaps we could just keep it simple?

It's not about performance, it's about readability. See the difference between
yours and mine.

-- 
With Best Regards,
Andy Shevchenko



