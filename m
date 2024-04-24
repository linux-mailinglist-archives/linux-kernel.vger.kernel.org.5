Return-Path: <linux-kernel+bounces-157063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D718B0C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8966928448A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B64115E5B2;
	Wed, 24 Apr 2024 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8iAc4qi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7318313DBB2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968396; cv=none; b=SHB3zjpHU9G1Y+NArFNs3yArhKRGxK9wCthl6+/dn2o55hcp30OnrXHcJSKM5xl050BW3XaVZm4yNZmhrX/q94NiimpIHk8ef+Lokm02BV1n9S1JzRMu4If2dTye/qAYXNl7EA1/YCIMfbguN+/BSpXVzEgWvVnstxCEvLSiYGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968396; c=relaxed/simple;
	bh=Fw/gSePI9Q0BWs5aYygw0nEVFbx+XH6fTuOlX/x1Yd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HutVDoRRqDNPrFyUdZ+f0IowjtzQ6NODF0iQd6/2mqmrNCKhXTlmCnZbPnhbl9uhEGunKPgZzWItdcZ05vH16OECc1BIsg8/RjfU4g7KGzEqG6upheIBfoSPEU1olH43ZZnygZDwa2lAQB/z+pRw1HQQU80kuP5xQtHMDfwLWJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8iAc4qi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77254C113CD;
	Wed, 24 Apr 2024 14:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713968396;
	bh=Fw/gSePI9Q0BWs5aYygw0nEVFbx+XH6fTuOlX/x1Yd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J8iAc4qijdEJBgrUz49DuOEgbbQvVx7KoTZimVpceQNy/b/gw+FWBAq+QDeRz9x78
	 9kX0uyxxisD5UFAda6+LWZKSgf2htDdvXGojAFPB3ct+5KDkobqVndGVKYtSf3RRFu
	 lzUYtoT6j6U+eSIx0NWPpSo8WV/NVeCimVPsJWyTULcdMTO5NqA6c+OmPgdA1fURu0
	 /9rRqKlnSMgSer+6tUzqN/JcepaqVlLZZj1wsbcuPN18Sfxp4YF2T1mepxw1u9TsBl
	 gt1oz8Pb+lS9zzWghfPW/zzWuOJAp4vDXOhkJCQFgntuBvmCvd1N7De9KUnAITT1u5
	 fkq3VZ6czTUbw==
Date: Wed, 24 Apr 2024 11:19:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: limits.h in tools/
Message-ID: <ZikVCCJRKImZ3zWB@x1>
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

On Wed, Apr 24, 2024 at 09:46:46AM -0400, Liam R. Howlett wrote:
> * Andy Shevchenko <andriy.shevchenko@intel.com> [240423 15:31]:
> > +Cc: Liam, the maintainer of the tool in question.
> 
> I maintain the maple.c file in that directory, not the xarray.c one.
> xarray is willy, and I depend on some of the functions from the xarray.
> 
> > 
> > On Tue, Apr 23, 2024 at 10:29:31PM +0300, Andy Shevchenko wrote:
> > > On Tue, Apr 23, 2024 at 04:22:01PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Tue, Apr 23, 2024 at 09:58:07PM +0300, Andy Shevchenko wrote:
> > > > > It seems tons of the code in tools include linux/limits.h. But I haven't found
> > > > > where do we copy it. Any pointers?
> > > > > 
> > > > > Based on the discussion 20220603183231.15159C385A9@smtp.kernel.org.
> 
> I was unable to locate this discussion.

I managed to do it by using:

  https://lkml.kernel.org/r/ + that Message-ID, i.e.:

https://lkml.kernel.org/r/20220603183231.15159C385A9@smtp.kernel.org.
 
> > > > 
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
> 
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
> 
> Thanks,
> Liam

