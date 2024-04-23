Return-Path: <linux-kernel+bounces-155804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4DD8AF75D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9DA1F22D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705461411E5;
	Tue, 23 Apr 2024 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HahvLmH5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FACA28DC9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900659; cv=none; b=ieErNsMkTuzvjWZqo4M/MBOumDrPrihiRkuQmbNlS/TGtW9EgQcna767FK8XxuHcnKG/PZAYGpBeWslah3RBnpFt1VzFLXxZWxoxC73YBcH9YYRd+sgj7uQmWCwOUEQkseUsRrXiG2PYC21c2DmAcTDkovHom51UiE2fP8F2LmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900659; c=relaxed/simple;
	bh=y845tB7x6EnzjRJYNIuK+1lnp5aTzyaweIGhhwd2S1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQ9VKkdZ/seK1vssGZ92Xk8VDB8aG/3iStU8M6uTp0K435JZ2A/GHSyggM/lKSHyu39QrRigS0xVakAJIj3Gr3ganUgRuLZ5tYfzyJU6cBTRAMZLG1fVwo4ogvfqPQUyevNUhllQWAcpK/wszQHrh64TNiMH6EJ0EFx+/+BnAwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HahvLmH5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713900658; x=1745436658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=y845tB7x6EnzjRJYNIuK+1lnp5aTzyaweIGhhwd2S1s=;
  b=HahvLmH5tqAovFtqLU5OMu479NjgBBC/AokBvQ9cM2yR4zpNTfwd5ucD
   UjuONiKP68RAJfiAZfS4AhDoyz1dkriCCnO/wzmzYKtx4ORQx//4eJa/P
   ExXlsfu6YlI9LkMwfWzxpcvRi/g3IMX7a/PorgrIKeSl1shSHL5l4Tede
   PcGXydzpYpfGCzmbZek5ArbY6LNrrQ0o5Zp7oVFYqgO08BLzF0dMf93zM
   ZQ5CqKgsXtwOJfHlUd813zLKOxSw9CwOcCUtt0eB41eq/Ac0MTEpZk9si
   iHz193RHrZgM9OzLy106rWNiApIiwfU3x1bCr8KeiC36Wikt2F94jvsMS
   Q==;
X-CSE-ConnectionGUID: pJRkDv+EQ72R+XJSdRW6UA==
X-CSE-MsgGUID: +tfHTck4RZiGZ0+KO/bgKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27020800"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="27020800"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 12:30:56 -0700
X-CSE-ConnectionGUID: llOlKdiIQZqfhGdlEJZI9A==
X-CSE-MsgGUID: +dgdG6gRRKyWwj0QoK9kWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29127017"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 12:30:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rzLqu-00000000Rx9-0j5t;
	Tue, 23 Apr 2024 22:30:52 +0300
Date: Tue, 23 Apr 2024 22:30:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: limits.h in tools/
Message-ID: <ZigMa2GqF_HN39oz@smile.fi.intel.com>
References: <ZigEvxn0-70og0H1@smile.fi.intel.com>
 <ZigKWZKY6kq-w0Tp@x1>
 <ZigMG8ZsBryO57zz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZigMG8ZsBryO57zz@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

+Cc: Liam, the maintainer of the tool in question.

On Tue, Apr 23, 2024 at 10:29:31PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 23, 2024 at 04:22:01PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Apr 23, 2024 at 09:58:07PM +0300, Andy Shevchenko wrote:
> > > It seems tons of the code in tools include linux/limits.h. But I haven't found
> > > where do we copy it. Any pointers?
> > > 
> > > Based on the discussion 20220603183231.15159C385A9@smtp.kernel.org.
> > 
> > ⬢[acme@toolbox perf-tools-next]$ diff -u /usr/include/linux/limits.h include/uapi/linux/limits.h 
> > --- /usr/include/linux/limits.h	2024-01-31 21:00:00.000000000 -0300
> > +++ include/uapi/linux/limits.h	2024-02-03 16:18:02.652000641 -0300
> > @@ -1,6 +1,6 @@
> >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > -#ifndef _LINUX_LIMITS_H
> > -#define _LINUX_LIMITS_H
> > +#ifndef _UAPI_LINUX_LIMITS_H
> > +#define _UAPI_LINUX_LIMITS_H
> >  
> >  #define NR_OPEN	        1024
> >  
> > ⬢[acme@toolbox perf-tools-next]$
> > 
> > And in the places where I test build perf I saw no problem so far, the
> > build failures below are unrelated, but still outstanding, see below.
> > 
> > But then is for building tools/, not the kernel, right? The discussion
> > you said this question was based on is about changing
> > include/linux/xarray.h, a kernel file, so should really be including
> > just kernel headers, files in the kernel source tree, outside tools/, I
> > don't see where what tools/ uses to build is relevant here? Can you
> > please elaborate?
> 
> I believe the tool in question is tools/testing/radix-tree/xarray.c.

-- 
With Best Regards,
Andy Shevchenko



