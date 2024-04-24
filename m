Return-Path: <linux-kernel+bounces-157062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AE58B0C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8E6287309
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FF815E5D3;
	Wed, 24 Apr 2024 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DvFToGub"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037BF15E5B1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968366; cv=none; b=b8mkj7IAP/+kddM3Nl6KnoyxPMpF9pb5pT0MTi5kbTfc/5pXTitS5UqgEToMJGolWl++6NOSGbmdEz0Mipv540AgH+t+Tnoz46FAAwmjo21LSJGZUlG+maeT7Pijf2LfRNRc0XnyckV2hi5SJeB1CAO/1fmV4UAddKUpfxB1IRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968366; c=relaxed/simple;
	bh=fZJNHIBFq2MxPupaYjlJMTkUfFiuqL1Gp84Ul8wEHfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxchGLLvBYCqmOLcbs9qlhRkNtMKsaAQN5UiZtMZGFzp7/6MOnNXOHIUlxYMeQCn9WJo8NrHIiFW5K+BEPsAB5lMyVwuTBK7W8K26cYyA6Ch43DO7HKtriblHqcJ3mKoa6tf9DRNEjeSHECiG81KpCmUakCeFsMqlrT12piT/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DvFToGub; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713968365; x=1745504365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fZJNHIBFq2MxPupaYjlJMTkUfFiuqL1Gp84Ul8wEHfU=;
  b=DvFToGubKgUk6ZnIlqUmTrjWnD+BHGcRma89apjoEaI92Pzhglr9Ywkg
   GWk2Xd6zJl9AW0hfUHFCZAZwcUL7KS1LalBY6djME9IvOxARXyN/R5Wg0
   PmcJZr98WQnpPxhciDtmvBHhMvptocWqi5frFPHNJpCKNvzxDpDOGVm6I
   txdUhdFhB2q3JsywzOkcV1hY9U/cY1m+ub4mWiNCTnTJj21L9glrEmicY
   x7P/3wnluqkn9n3PVG2UCZtjH5HuRajQiXb64MJKudj2aE7URp12cYZt/
   Y6AHTcTrtCkzLL6KB0aAWpwe/dRrZY5bd4G1/1tJ3YPwZrq1NxiZfTHCK
   Q==;
X-CSE-ConnectionGUID: cTEfzjrmQMCbqs6TaTlWSw==
X-CSE-MsgGUID: w9IfvzXJQWGM+qcW0II9eg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="13391522"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="13391522"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:19:22 -0700
X-CSE-ConnectionGUID: KvEXr0tjQfGZeHLg1lHRzg==
X-CSE-MsgGUID: kj/3o+gLTbmD0DYHOm+ejw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29190985"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:19:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rzdSv-00000000fjW-3PLB;
	Wed, 24 Apr 2024 17:19:17 +0300
Date: Wed, 24 Apr 2024 17:19:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: limits.h in tools/
Message-ID: <ZikU5TWvL7zEfr5B@smile.fi.intel.com>
References: <ZigEvxn0-70og0H1@smile.fi.intel.com>
 <ZigKWZKY6kq-w0Tp@x1>
 <ZigMG8ZsBryO57zz@smile.fi.intel.com>
 <ZigMa2GqF_HN39oz@smile.fi.intel.com>
 <t2n5aj7orslsewknx6vmlf7t4wbnj3u6cabrjjfaptexb64fzn@rbjhcj3uwrkg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <t2n5aj7orslsewknx6vmlf7t4wbnj3u6cabrjjfaptexb64fzn@rbjhcj3uwrkg>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 24, 2024 at 09:46:46AM -0400, Liam R. Howlett wrote:
> * Andy Shevchenko <andriy.shevchenko@intel.com> [240423 15:31]:
> > +Cc: Liam, the maintainer of the tool in question.
> 
> I maintain the maple.c file in that directory, not the xarray.c one.
> xarray is willy, and I depend on some of the functions from the xarray.

Ah, okay, good to know.

> > On Tue, Apr 23, 2024 at 10:29:31PM +0300, Andy Shevchenko wrote:
> > > On Tue, Apr 23, 2024 at 04:22:01PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Tue, Apr 23, 2024 at 09:58:07PM +0300, Andy Shevchenko wrote:
> > > > > It seems tons of the code in tools include linux/limits.h. But I haven't found
> > > > > where do we copy it. Any pointers?
> > > > > 
> > > > > Based on the discussion 20220603183231.15159C385A9@smtp.kernel.org.
> 
> I was unable to locate this discussion.

  `b4 mbox 20220603183231.15159C385A9@smtp.kernel.org`

works for me

$ b4 mbox 20220603183231.15159C385A9@smtp.kernel.org
Grabbing thread from lore.kernel.org/all/20220603183231.15159C385A9@smtp.kernel.org/t.mbox.gz
8 messages in the thread
Saved ./20220603183231.15159C385A9@smtp.kernel.org.mbx

> > > > ⬢[acme@toolbox perf-tools-next]$ diff -u /usr/include/linux/limits.h include/uapi/linux/limits.h 
> > > > --- /usr/include/linux/limits.h	2024-01-31 21:00:00.000000000 -0300
> > > > +++ include/uapi/linux/limits.h	2024-02-03 16:18:02.652000641 -0300
> > > > @@ -1,6 +1,6 @@
> > > >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > > -#ifndef _LINUX_LIMITS_H
> > > > -#define _LINUX_LIMITS_H
> > > > +#ifndef _UAPI_LINUX_LIMITS_H
> > > > +#define _UAPI_LINUX_LIMITS_H
> > > >  
> > > >  #define NR_OPEN	        1024
> > > >  
> > > > ⬢[acme@toolbox perf-tools-next]$
> > > > 
> > > > And in the places where I test build perf I saw no problem so far, the
> > > > build failures below are unrelated, but still outstanding, see below.
> > > > 
> > > > But then is for building tools/, not the kernel, right? The discussion
> > > > you said this question was based on is about changing
> > > > include/linux/xarray.h, a kernel file, so should really be including
> > > > just kernel headers, files in the kernel source tree, outside tools/, I
> > > > don't see where what tools/ uses to build is relevant here? Can you
> > > > please elaborate?
> > > 
> > > I believe the tool in question is tools/testing/radix-tree/xarray.c.
> 
> I'm not sure what is being asked.  Are you suggesting that the linux
> kernel xarray.h header is including non-kernel headers?  I don't believe
> this to be true.

No. The problem here that tooling relies basically on the external limits.h.
I.o.w. from the current user space.

> However, the xarray.h tools/testing/radix-tree header certainly pulls in
> the kernel version of its header.  The point here is that we want to
> test the xarray, so we need to have access to the API, but including it
> after setting things up so it will work without the kernel.
> 
> The directory you are point to is a testing directory which uses a
> combination of kernel headers and custom headers (to avoid pulling in
> the entire kernel) to build a test application.  Sometimes the real
> headers are used, but other times we are required to write a small
> function to do what is expected (eg: allocating kmem_cache objects).
> 
> So our tools may include some kernel headers directly, for testing those
> functions.  It also includes testing headers where we just need the
> defined functionality provided for the testing framework.
> 
> Specific to limits.h, if you look in the kernel header, you will see:
> 
> #include <uapi/linux/limits.h>
> 
> So, most likely, just including the uapi header satisfied the
> requirement without pulling in more headers with, potentially, other
> issues.  IIRC including the types.h header (also in the kernel limits.h)
> caused issues for me in the past.
> 
> I hope this helps answer your questions.

-- 
With Best Regards,
Andy Shevchenko



