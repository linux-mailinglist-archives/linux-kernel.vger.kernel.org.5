Return-Path: <linux-kernel+bounces-48030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E7D84567A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8061F2277B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839B315D5B2;
	Thu,  1 Feb 2024 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXcdR1+J"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1923A15D5B1;
	Thu,  1 Feb 2024 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788178; cv=none; b=uUWxk+3dnoiRS+KG4CGMHZDKa3J5y+wuoGDhIssn4VCRs/q32DIKZv4DwZerkuMi0uehqLC2yrWVkk0GQrcu42EhkM0JHp/hpLTHVeYYVDHKyPvoaFf3yXHk7TsyZqQNQb3KrfZJs0nZ9IaUREkBTqt/RoyjFXBDCsWx10iCKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788178; c=relaxed/simple;
	bh=6bojr7VqalyrhhlCkfp8Bvy7vS2yUhZEJyFI0BLs9EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ss5LnhkrUl83/S46/5DTY5zekbmAhkP7tK2orflleoUJ7Dt2DSlUQ/cenPC7f23BtBnRzlSp2+53GbTS14iInhHZzK6rhvKB22V3OPHzMp97oXGvVYuFX3GIB+QP5LAGWLln0+AqCqjbRx8FnY/1L1mtjnnVC37aPLFo26oYaU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXcdR1+J; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706788176; x=1738324176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6bojr7VqalyrhhlCkfp8Bvy7vS2yUhZEJyFI0BLs9EE=;
  b=QXcdR1+JSgmGKETgzpu0GTeoad9iS6YVek5RYPelB/kLzWaP/3yXM0mp
   GDpZxlvPM8sFfSdSiNQhc84jpqQNZzlib3ZnZwndZG8FPZKkGaULlC1/M
   HuxuAwbK0NALYUwR4teAmpKtxA9IcwW3/69qiWo/7qUZzQBs/sI96ueNC
   mmjxSO6SjLoZaTCHobFeQwc1M1/xUb53dQCiaONq4SFmaiVtnIpNAcBI7
   BQ4oRt5A+232eWUK3J0nZlGau2BM1XXur7GP74HZTxv9P1qBR3T3NuUES
   Vnd1Jo6h1Rnvqv/0bxX3xi7IsGq16QdGF4W81PujEvjziT6GPWTCUCC3d
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3709664"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="3709664"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 03:49:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="1119923600"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="1119923600"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 03:49:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVVZQ-00000000p3E-4Bbk;
	Thu, 01 Feb 2024 13:49:29 +0200
Date: Thu, 1 Feb 2024 13:49:28 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Crutcher Dunnavant <crutcher+kernel@datastacks.com>,
	Juergen Quade <quade@hsnr.de>,
	David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v3 1/1] lib/vsprintf: Implement spprintf() to catch
 truncated strings
Message-ID: <ZbuFSIIGbfhXeP92@smile.fi.intel.com>
References: <20240130160953.766676-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130160953.766676-1-lee@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 30, 2024 at 04:09:53PM +0000, Lee Jones wrote:
> There is an ongoing effort to replace the use of {v}snprintf() variants
> with safer alternatives - for a more in depth view, see Jon's write-up
> on LWN [0] and/or Alex's on the Kernel Self Protection Project [1].
> 
> Whist executing the task, it quickly became apparent that the initial
> thought of simply s/snprintf/scnprintf/ wasn't going to be adequate for
> a number of cases.  Specifically ones where the caller needs to know
> whether the given string ends up being truncated.  This is where
> spprintf() comes in, since it takes the best parts of both of the
> aforementioned variants.  It has the testability of truncation of
> snprintf() and returns the number of Bytes *actually* written, similar
> to scnprintf(), making it a very programmer friendly alternative.
> 
> Here's some examples to show the differences:
> 
>   Success: No truncation - all 9 Bytes successfully written to the buffer
> 
>     ret = snprintf (buf, 10, "%s", "123456789");  // ret = 9
>     ret = scnprintf(buf, 10, "%s", "123456789");  // ret = 9
>     ret = spprintf (buf, 10, "%s", "123456789");  // ret = 9
> 
>   Failure: Truncation - only 9 of 10 Bytes written; '-' is truncated
> 
>     ret = snprintf (buf, 10, "%s", "123456789---"); // ret = 12
> 
>       Reports: "12 Bytes would have been written if buf was large enough"
>       Issue: Too easy for programmers to assume ret is Bytes written
> 
>     ret = scnprintf(buf, 10, "%s", "123456789---"); // ret = 9
> 
>       Reports: "9 Bytes actually written"
>       Issue: Not testable - returns 9 on success AND failure (see above)
> 
>     ret = spprintf (buf, 10, "%s", "123456789---"); // ret = 10
> 
>       Reports: "Data provided is too large to fit in the buffer"
>       Issue: No tangible impact: No way to tell how much data was lost
> 
> Since spprintf() only reports the total size of the buffer, it's easy to
> test if they buffer overflowed since if we include the compulsory '\0',
> only 9 Bytes additional Bytes can fit, so the return of 10 informs the
> caller of an overflow.  Also, if the return data is plugged straight
> into an additional call to spprintf() after the occurrence of an
> overflow, no out-of-bounds will occur:
> 
>     int size = 10;
>     char buf[size];
>     char *b = buf;
> 
>     ret = spprintf(b, size, "1234");
>     size -= ret;
>     b += ret;
>     // ret = 4  size = 6  buf = "1234\0"
> 
>     ret = spprintf(b, size, "5678");
>     size -= ret;
>     b += ret;
>     // ret = 4  size = 2  buf = "12345678\0"
> 
>     ret = spprintf(b, size, "9***");
>     size -= ret;
>     b += ret;
>     // ret = 2  size = 0  buf = "123456789\0"
> 
> Since size is now 0, further calls result in no changes of state.
> 
>     ret = spprintf(b, size, "----");
>     size -= ret;
>     b += ret;
>     // ret = 0  size = 0  buf = "123456789\0"

> [0] https://lwn.net/Articles/69419/
> [1] https://github.com/KSPP/linux/issues/105

Link: ... [0]
Link: ... [1]


> Signed-off-by: Lee Jones <lee@kernel.org>

..

I'm a bit late in this discussion, but the commit message doesn't spit a single
word on why seq_buf() approach can't be used in those cases?

-- 
With Best Regards,
Andy Shevchenko



