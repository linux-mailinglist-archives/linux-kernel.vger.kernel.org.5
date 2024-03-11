Return-Path: <linux-kernel+bounces-98836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A134087801A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CEEB2816EE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDAE36AE4;
	Mon, 11 Mar 2024 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rn6ztg7y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED8314298
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710160944; cv=none; b=XvOAfUlDgGg1QMLHMIKSBa94ECA1gIO7as1+xe0GIVGlOJ/Kl8VTckeQk8PRpT50oH/O+yGA/++ggMz46lzYxOwdDmR9XKT0ffYVNsD+1Vn9jG7FXVU6PXJIvNzHqWzqg2mkXpylMWZckYOAmDFEGRb/shuOi0lkuenkSH9mWpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710160944; c=relaxed/simple;
	bh=drNSqX9EaSckBuQ7fqCj5jsg1tNnSNmL5x44pJ2lqQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkieM0PG3E224MC+Tu4j0L8HjTeazgMlmWm46WZtO3rZ9N3JA1ek7/iKZ2XAZITmicC4M9zZDZK4gpbT9G2zHJ03NJBRgKvDSLASHDKNxCk1qZr6OOU9AiKQnfMGqA/R/cIPvXBm6qLXBcO8l1Q5BejkAYcPapSe0dPfaPTeP1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rn6ztg7y; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710160942; x=1741696942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=drNSqX9EaSckBuQ7fqCj5jsg1tNnSNmL5x44pJ2lqQM=;
  b=Rn6ztg7yq/hSCYzCESIGPPqyaxt6fQmkwOzzkHqp4k0aMBiII4Mm+6G/
   b6c3VIy8gsA701JR1V01rBX/Yp2mGsezNtjzVCz/u8NxA/OrNewtfx49g
   AgXFU6AGv8a7U4EnqV0/f3Vey8wstXC7olLlA6Lflo1Y8UJe0XIcFJ9j5
   jFgKqNQ9Tp2HzpzowYOeAlvbrq5N7gDJaBjEfL3PBLH7xgQ3diF6Lz5+f
   Ndu3DXhXODsyLAyAuVLjU8OvPrQ97OHJDLdJZs0CYcRqO1XYwGYWN0JsQ
   8rUhZblZ9qCuTStYfoYKtHbBJkyX/pbbvHYLw7JCLfIHFCQQDaH42jCEf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4663162"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4663162"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 05:42:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="937049757"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="937049757"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Mar 2024 05:42:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 81F2F177; Mon, 11 Mar 2024 14:42:17 +0200 (EET)
Date: Mon, 11 Mar 2024 14:42:17 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, linux-mm@kvack.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] x86/mm: make sure LAM is up-to-date during
 context switching
Message-ID: <e5tjo62yrvmviixily6ramjvnqqmokvayyr6k7c7qzrczcx4yd@yupixsoj53vm>
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-3-yosryahmed@google.com>
 <420fcb06-c3c3-4e8f-a82d-be2fb2ef444d@app.fastmail.com>
 <35b670e2-9ef5-4d3a-b6ea-f8016dfa088d@intel.com>
 <ZevHJ5o3G00_nBha@google.com>
 <o5t3qrrlw37hdkcja2vny3ycpmhb4dowmdj74a2wrq2x4xctqk@5g5jvzen46qe>
 <CAJD7tkZABvm4v87T2WJ593sjZ_Z9iLCcgecghQJHrZDnuisBLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZABvm4v87T2WJ593sjZ_Z9iLCcgecghQJHrZDnuisBLg@mail.gmail.com>

On Sat, Mar 09, 2024 at 01:37:06PM -0800, Yosry Ahmed wrote:
> On Sat, Mar 9, 2024 at 8:34 AM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > On Sat, Mar 09, 2024 at 02:19:19AM +0000, Yosry Ahmed wrote:
> > > I don't see how skipping set_tlbstate_lam_mode() for kthreads fixes this
> > > problem. Do you mind elaborating?
> >
> > Define what problem is.
> >
> > Yes, in this scenario kthread gets more permissive LAM mode than it needs.
> > But nothing breaks.
> 
> 
> The problem here is not how the kthread runs at all. It is the fact
> that if that kthread context switches into the user process that has
> enabled LAM, it may not update CR3 because the mm doesn't change.
> switch_mm_irqs_off() will only update CR3 in this case if there is a
> pending TLB flush. Otherwise, we just return, even if the LAM for this
> mm has changed.
> 
> This can cause the process that has enabled LAM to run with LAM
> disabled and fault on tagged addresses, right? Did I miss something?

You are right. I think IPI is the way to go.

Will you prepare a patch?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

