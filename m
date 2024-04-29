Return-Path: <linux-kernel+bounces-162351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0608B59AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3B81C20FD4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA0E10971;
	Mon, 29 Apr 2024 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4X/1p0a"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DEA548F3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396667; cv=none; b=jyEiWXFqW++JvslFCkYpc37BJjb0GcGVLzeKj+gunAOK+I+3mGFGu2mpZpCgqN8JVbTZuwT1H0CNgk0xy3GlS929ERcFqk0froOMQhZEMSi5K+rJuiNkdx+5EYWJmFk0SOEFjgqlrgGrDFGyRuBUC4yBeklN3iwyUXFMLYoLOWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396667; c=relaxed/simple;
	bh=vvnS47Dpfc2lPtfocF2xFFI42fQVbBcxzt1unzaD04A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDQ3NqVQFjmE6u6usBlAHDAo4Rfoxo+k+VSfghzIztaF1Oc8PSMjU/GxeJFbGo78nBdQb/laAdHXg6pGrmd+KgysbijEVFFsD5ro1FCJqQTOtQHaOyyITKG55dKl8QIT9hJdXW9Wo4p0lHW+XMhb+G6VU2i51fy4HWMlFtk6IME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4X/1p0a; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714396665; x=1745932665;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vvnS47Dpfc2lPtfocF2xFFI42fQVbBcxzt1unzaD04A=;
  b=M4X/1p0aiAkbadnx/z5wIIUDVUdQm7eCE2dIz6w3TtotjSpsXyMLMxEy
   i770O5WFrZ3p0fm/P+8jRIt8sISz9f5i33gOWxFWnvJhpceApJf8df6Hw
   Qolqya0AMQZfybnrGGkZ5DLt5e8zHbp+U9Up6N0EJRSmxZjSgBIa1qy48
   6ImfcxIWp7fq8mhoxeZNat44VQdKPeENfBrAXR3tY74utQqI47GBojZzD
   RrzGO4GgTL60rntOaSmKz0iDpFHPxbjiL/CYFJ4pSTOStGoUzEz7rnI/I
   gEtTiYQ9CWqqK/AXfB89YB83uZXlZTonANpfuATyAI6f6zSi36uwbPor7
   w==;
X-CSE-ConnectionGUID: 1UvsmeyoQkqljKBTM/n9RQ==
X-CSE-MsgGUID: JznZSN5hTle8PM6tsZsViA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10167086"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="10167086"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:17:45 -0700
X-CSE-ConnectionGUID: 8NOiztBIRTaSIwyN+FuNlw==
X-CSE-MsgGUID: pfLor2xfQQiqFaB6fEhbAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26069268"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 29 Apr 2024 06:17:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 71239179; Mon, 29 Apr 2024 16:17:38 +0300 (EEST)
Date: Mon, 29 Apr 2024 16:17:38 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
Message-ID: <e35yxpa2xdynm7focg6k4u2bjzojn24bmeaszh2jz52e4szc5f@6mgtrdnkewhe>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
 <ZhVPIDDLkjOB96fI@google.com>
 <3q6jv3g4tezybmd667mqxio7ty22akxv7okrznmzx3tju2u4qo@2alzjkbgm2lh>
 <20240428171111.GKZi6DLy_ZwuZsZdFq@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428171111.GKZi6DLy_ZwuZsZdFq@fat_crate.local>

On Sun, Apr 28, 2024 at 07:11:11PM +0200, Borislav Petkov wrote:
> On Tue, Apr 09, 2024 at 06:26:05PM +0300, Kirill A. Shutemov wrote:
> > From 6be428e3b1c6fb494b2c48ba6a7c133514a0b2b4 Mon Sep 17 00:00:00 2001
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > Date: Fri, 10 Feb 2023 12:53:11 +0300
> > Subject: [PATCHv10.1 05/18] x86/kexec: Keep CR4.MCE set during kexec for TDX guest
> > 
> > Depending on setup, TDX guests might be allowed to clear CR4.MCE.
> > Attempt to clear it leads to #VE.
> > 
> > Use alternatives to keep the flag during kexec for TDX guests.
> > 
> > The change doesn't affect non-TDX-guest environments.
> 
> This is all fine and dandy but nothing explains *why* TDX needs this
> special dance.
> 
> Why can't TDX do the usual CR4.MCE diddling like the normal kernel
> during init and needs to do that here immediately?

As I mentioned above, clearing CR4.MCE triggers #VE. It is quirk of the
platform.

There's plan to allow it in newer TDX modules, but kernel still has to
assume we cannot touch it in TDX guest case.

> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/kernel/relocate_kernel_64.S | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> > index 56cab1bb25f5..90246d544eb1 100644
> > --- a/arch/x86/kernel/relocate_kernel_64.S
> > +++ b/arch/x86/kernel/relocate_kernel_64.S
> > @@ -5,6 +5,8 @@
> >   */
> >  
> >  #include <linux/linkage.h>
> > +#include <linux/stringify.h>
> > +#include <asm/alternative.h>
> >  #include <asm/page_types.h>
> >  #include <asm/kexec.h>
> >  #include <asm/processor-flags.h>
> > @@ -143,14 +145,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> >  
> >  	/*
> >  	 * Set cr4 to a known state:
> > -	 *  - physical address extension enabled
> >  	 *  - 5-level paging, if it was enabled before
> > +	 *  - Machine check exception on TDX guest, if it was enabled before.
> > +	 *    Clearing MCE might not allowed in TDX guests, depending on setup.
> 
> 			 ... might not be allowed ...
> 

Oopsie. Thanks.

> > +	 *  - physical address extension enabled
> >  	 */
> > -	movl	$X86_CR4_PAE, %eax
> > -	testq	$X86_CR4_LA57, %r13
> > -	jz	1f
> > -	orl	$X86_CR4_LA57, %eax
> > -1:
> > +	movl	$X86_CR4_LA57, %eax
> > +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
> > +	andl	%r13d, %eax
> 
> %r13 needs a comment here that it contains %cr4 read above in
> relocate_kernel()

Okay.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

