Return-Path: <linux-kernel+bounces-131703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5C8898AE3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA8F28BECC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD4012BEA7;
	Thu,  4 Apr 2024 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ShYkhNuA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A5212AAF7;
	Thu,  4 Apr 2024 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243752; cv=none; b=RX5YwLGJ9KIUsbNyZDtqGSK5bUJ6Gz2xx/aJgshXRzCkjhuaEWRNE9RbqDPNU01tlNf3kMpqQKfX22mx0SVhNnsWyTIzNg1fBfPHiauTdPPewbol+x58V4oF5x1/iejbomq7TMB0AbK0IYYC3qQk2+ETedQk6FCQlWRhON6+w4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243752; c=relaxed/simple;
	bh=ilcJfmTTe/LcMzKujpqLohXnZnWbuM2rjavvMBq/V7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ni2t2sEQWvG6FXCUWsGuYyb91RKiJ4GPZKBwcXw7QhVkwIFos1uPvrT5oGzYB8jTo2Q2LgWH/fd+LUhPzB5VGzyr+g8tC0m+dxmr1ktROxkbX41MGVXuZRrPpBk0wMqc+3o5leVvbnUo+AiLXNGf9l+/wAY7oP3tUHFx9jwRcKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ShYkhNuA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712243751; x=1743779751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ilcJfmTTe/LcMzKujpqLohXnZnWbuM2rjavvMBq/V7k=;
  b=ShYkhNuAgWo74quJuMIPTxU7UJvIb0Rj9MPlyOFZZ41Nz+UkaHrjZBed
   8hLAhKKYaxX7yBQx6C4nNxivK9WkZ3569hi2B+Q/FMUgqk13P64hkaBGb
   3FXmf3uFpGgV69oVo7J8zcSVGItnXDse+yRvxPF3y8Q7pqdfznLbOSKO+
   WjLXggyVg/qVNEaNoyQ8oP9blM+0C8jm1xHwfCAemsUzRyNYVpTXkgTMj
   zRywz0d4aBybf3pGgiHSXgDC37biCg62gTMS/RRkfUdMUylh4fxb/lgHb
   eSDEZ3tKkxZiCXY2vw2IRgKPly2YKt9lsk12vrpmseUmYwWnRrm8USQW9
   Q==;
X-CSE-ConnectionGUID: r4WP4kT0Ru2m1DPo2HstQg==
X-CSE-MsgGUID: Gb8hflJ5Q0CewDfdNz9kCg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7374422"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7374422"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 08:15:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="915221080"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="915221080"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 08:15:45 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rsOoZ-00000001Ubl-2ifg;
	Thu, 04 Apr 2024 18:15:43 +0300
Date: Thu, 4 Apr 2024 18:15:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Andi Shyti <andi.shyti@kernel.org>,
	Petr Mladek <pmladek@suse.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jyoti Bhayana <jbhayana@google.com>,
	Chris Down <chris@chrisdown.name>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/4] dev_printk: add dev_errp_probe() helper
Message-ID: <Zg7EH2aZ6TXKlIuo@smile.fi.intel.com>
References: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
 <Zg6Z51uebr2dWLq2@smile.fi.intel.com>
 <f6d171499b622b463a174ce56fabc40c1e732bf9.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6d171499b622b463a174ce56fabc40c1e732bf9.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 04, 2024 at 05:03:53PM +0200, Nuno Sá wrote:
> On Thu, 2024-04-04 at 15:15 +0300, Andy Shevchenko wrote:
> > On Thu, Apr 04, 2024 at 01:06:22PM +0200, Nuno Sa wrote:
> > > This series adds a dev_errp_probe() helper. This is similar to
> > > dev_err_probe() but for cases where an ERR_PTR() is to be returned
> > > simplifying patterns like:
> > > 
> > > 	dev_err_probe(dev, ret, ...);
> > > 	return ERR_PTR(ret)
> > 
> > What about ERR_CAST() cases?
> 
> In theory not really needed (I think) but see my reply to the other patch.
> > 
> > > The other three patches are adding users for it. The main motivator for
> > > this were the changes in the commit ("iio: temperature: ltc2983: convert
> > > to dev_err_probe()"). Initially I just had a local helper [1] but then
> > > it was suggested to try a new, common helper. As a result, I looked for
> > > a couple more users.
> > > 
> > > I then move into dev_errp_probe() [2] but it was then suggested to separare
> > > the patch series so we have onde dedicated for the printk helper.
> > > 
> > > [1]:
> > > https://lore.kernel.org/all/20240301-ltc2983-misc-improv-v3-1-c09516ac0efc@analog.com/
> > > [2]:
> > > https://lore.kernel.org/all/20240328-ltc2983-misc-improv-v4-0-0cc428c07cd5@analog.com/
> > 
> > Have you seen mine?
> > 
> > 20220214143248.502-1-andriy.shevchenko@linux.intel.com
> > 
> > (Note, I'm pretty much fine and thankful that you take care of this)
> > 
> 
> Ups nope... I very prefer your naming :). I can take care of this only if you
> don't intend to continue with your series. You sent it first so... :)

No objections, I have no time and that already was rotting for 2+ years.
And pls keep Andi in the circle, he wanted this change to happen.

-- 
With Best Regards,
Andy Shevchenko



