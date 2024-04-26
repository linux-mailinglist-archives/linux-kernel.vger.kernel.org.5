Return-Path: <linux-kernel+bounces-160322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 034328B3BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC54D1F215BA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A36914A4D9;
	Fri, 26 Apr 2024 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="loGTGmAF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1ED148FE5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146170; cv=none; b=Dj2iFjtdNKfJ5S4qiXQW9qIQxllxMXAn20h5qpWRwgItZWFLbR+cBhlvnrsLjouHlQ1RV2LwS8yKrYatTl/X4hUDCR2rN9Nruj55YylsHARv+7ouXDKtkBcT0WHzk1Dt+03ys4Tm6iceVUfzMqdcwEJ5katBmW6gumTq6fe70fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146170; c=relaxed/simple;
	bh=zUlVdYEnCLmuHB4grnGC0MlCVYEHZkxwPqnNYeshHcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iz8zz7JRDNwcBCITYa5PbomtwWejQuMQcBK4jradK7jUKsDPUS8hCi/oVXsALJ5waD8itWAU2rXR3s+jj5g9CmEKtTFJGuQosAnxZmFBJVrPULFMnP9H0lz+wZ6eyjFPZGOjAsFze6tIaR5wp8O0+a1aa7e92H2WGtG5mU+0bk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=loGTGmAF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714146169; x=1745682169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zUlVdYEnCLmuHB4grnGC0MlCVYEHZkxwPqnNYeshHcc=;
  b=loGTGmAFHV2ZP5qlNxlp7akWNQ8LQfzhTFMvKA+BsZ5IHNI7KiD+QsOb
   rijlgD9FFsWUtg42H9h/bJQKQHMdMnWR2dV5ctmaLscc4CMiTZyvBnWYT
   Xn/FpCv60oRU6sTuAzUJ3yuCkkFuugPhS4S4WaFjcePRKvJTNVLO0fP/C
   miGhEJ7xqxcNYJUk/Zt7rkOD/ZyKtIAgljT4QSiA6+ISnzLAF+YqTou01
   eNN5uUzklhrfIthzdUVoXuPOuabtlKfHjlWZa+lL0hJ1eF26rEuR3/FZ0
   3qLfbpQzxIYOgtY0+o2CL0Fsss6DobIkYORaK9wbR3eatap07Hlmpfok6
   w==;
X-CSE-ConnectionGUID: gtXiEzz7SQOg44vZ4WugeA==
X-CSE-MsgGUID: 5BVU23qyR7aR1J056YaeUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="13673885"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="13673885"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 08:42:49 -0700
X-CSE-ConnectionGUID: xEmPUfTfQ6+AMXIjeJ5PAw==
X-CSE-MsgGUID: b3vCRnJoT6KqyaTHU4Ux5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="25530546"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 08:42:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s0Nil-00000001MlS-3Pv4;
	Fri, 26 Apr 2024 18:42:43 +0300
Date: Fri, 26 Apr 2024 18:42:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Matthew Wilcox <willy@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Printing numbers in SI units
Message-ID: <ZivLc0bjtfxo8ZyB@smile.fi.intel.com>
References: <ZbFd5TZ_pi7q3hso@casper.infradead.org>
 <94713e86-30a8-4828-959d-bd95800149e4@rasmusvillemoes.dk>
 <CAMuHMdUp3fOkAttk2FKJTh5svaiMwgu4JZ8utPeHghU4TQLE-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUp3fOkAttk2FKJTh5svaiMwgu4JZ8utPeHghU4TQLE-w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 26, 2024 at 05:27:08PM +0200, Geert Uytterhoeven wrote:
> On Wed, Jan 24, 2024 at 11:43 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> > On 24/01/2024 19.58, Matthew Wilcox wrote:
> > > I was looking at hugetlbfs and it has several snippets of code like
> > > this:
> > >
> > >         string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
> > >         pr_warn("HugeTLB: allocating %u of page size %s failed node%d.  Only allocated %lu hugepages.\n",
> > >                 h->max_huge_pages_node[nid], buf, nid, i);
> > >
> > > That's not terribly ergonomic, so I wondered if I could do better.
> > > Unfortunately, I decided to do it using the SPECIAL flag which GCC
> > > warns about.  But I've written the code now, so I'm sending it out in
> > > case anybody has a better idea for how to incorporate it.
> >
> > Well, something that gcc will warn about with Wformat isn't gonna fly,
> > obviously. But my man page also mentions ' as a possible flag for d
> > conversions:
> >
> >        '      For decimal conversion (i, d, u, f, F, g, G) the output is
> > to be grouped with thousands'
> >               grouping characters if the locale information indicates any.
> 
> > Obviously, our printf wouldn't implement that, [...]
> 
> Why not? ;-)

:-)

> Old Gmail-white-space-damaged patch below, which I wrote when I got
> fed up with meticulously counting zeros in GHz-range clock
> frequencies...

..

>     lib/vsprintf.c: Add support for thousands' grouping
> 
>     Use an underscore as the grouping character.
> 
>     TODO:
>       - Documentation
>       - Self test

Definitely won't fly without these two.

>       - Do we want to use this in /sys/kernel/debug/clk/clk_summary ?
>         RFC patch, compatibility was already broken by commit
>         e55a839a7a1c561b ("clk: add clock protection mechanism to clk
>         core")
> 
>     Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>     ---
>     Originally I wanted to use grouping by 4 for octal and hexadecimal
>     numbers.

Not sure about octals, but for the hexadecimal we have hex_dump_to_buffer()
and %ph. The latter one can be modified to support grouping.

-- 
With Best Regards,
Andy Shevchenko



