Return-Path: <linux-kernel+bounces-137220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B543289DF0F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C921C21BDE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBE713D612;
	Tue,  9 Apr 2024 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtaEz9bN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3656813D608
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676377; cv=none; b=q8iEJR0hBlwjrNIpNwSPStb6wPY/nB7KECGhnScvY5bGOjJ6C4gib/3AmYp8Y9LSbxwT+TNdYyLgYNjuDP8kVDFDPaST/M8OWr8aWn+oJmwVczrjuLnCNjP0HLAluGK7raSMng9wxAbU9IXMZRFy7xNnoI0cryBulwcI1RBSRPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676377; c=relaxed/simple;
	bh=jzHlRPxbj4n++6c1Y7jC5HhgzBvQwRs0eWR4xEuQY1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGsyKcdRawNs1XUMRjVSbzsXQ6IbEwtA3noVuHs4SAXY4iTZ71sxgebeynswqbBd/tjVXDJjC+inmkMSP/eejjJSTm/yLZ5U431OSwMuMjEjzdf7xK3K8vansJ0LEmK4PAIBAV3yjh7d4pyeKWhyr1ZHvKPoyswCxd0T4ztFEhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtaEz9bN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712676375; x=1744212375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jzHlRPxbj4n++6c1Y7jC5HhgzBvQwRs0eWR4xEuQY1c=;
  b=OtaEz9bNUAdHKC5UQLFN/gpBB9Rz83X4wbn6ooLvSz0Nfi2o62xkOjjK
   yuCUcq6k7cDBikWbXtRnmc3NyG9ObxqQsnPqW3p8V+xa7vUpqaLkHIIXq
   0eT1CUeQHuZqUopWHZVwyw6A996W21WJFDcNVNg3FLcOlsopebJkAUieC
   lpFIItakFE3kYPjV+97lyuvr06nsmJPgJfC0bxmIYSnuEmV1OdiiMFmE7
   KL+5iYmCvIgOFgc2MevPJRy6uUlNBIMDc/jpsF7yeDJWPjEP5kwfx1xhB
   Ox04Fhko+KT9v02j4yWRE1YOeWUCnpYkTzItje+oP/9OtewQInB+wvT4b
   g==;
X-CSE-ConnectionGUID: 2fo4+wKvQYSPaw19WkR9Rw==
X-CSE-MsgGUID: 6Vp2/dwtTleKiwyVM8+96A==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8119654"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="8119654"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 08:26:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937093549"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="937093549"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 08:26:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id BBE70279; Tue,  9 Apr 2024 18:26:05 +0300 (EEST)
Date: Tue, 9 Apr 2024 18:26:05 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
Message-ID: <3q6jv3g4tezybmd667mqxio7ty22akxv7okrznmzx3tju2u4qo@2alzjkbgm2lh>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
 <ZhVPIDDLkjOB96fI@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhVPIDDLkjOB96fI@google.com>

On Tue, Apr 09, 2024 at 07:22:24AM -0700, Sean Christopherson wrote:
> On Tue, Apr 09, 2024, Kirill A. Shutemov wrote:
> > Depending on setup, TDX guests might be allowed to clear CR4.MCE.
> > Attempt to clear it leads to #VE.
> > 
> > Use alternatives to keep the flag during kexec for TDX guests.
> > 
> > The change doesn't affect non-TDX-guest environments.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/kernel/relocate_kernel_64.S | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> > index 56cab1bb25f5..8e2037d78a1f 100644
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
> > @@ -145,11 +147,17 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> >  	 * Set cr4 to a known state:
> >  	 *  - physical address extension enabled
> >  	 *  - 5-level paging, if it was enabled before
> > +	 *  - Machine check exception on TDX guest, if it was enabled before.
> > +	 *    Clearing MCE might not allowed in TDX guests, depending on setup.
> >  	 */
> >  	movl	$X86_CR4_PAE, %eax
> >  	testq	$X86_CR4_LA57, %r13
> >  	jz	1f
> >  	orl	$X86_CR4_LA57, %eax
> > +1:
> > +	testq	$X86_CR4_MCE, %r13
> > +	jz	1f
> > +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
> 
> The TEST+Jcc+OR sequences are rather odd, and require way more instructions and
> thus way more copy+paste than is necessary.
> 
> 	movl	$X86_CR4_LA57, %eax
> 	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
> 	andl	%r13d, %eax
> 	orl	$X86_CR4_PAE, %eax
> 	movq	%rax, %cr4
> 
> Then preserving new bits unconditionally only requires adding the flag to the
> initial move, and feature-dependent bits only need a single ALTERNATIVE line.

Thanks! It is much better.

> And there's no branches, blazing fast kexec! ;-)

kexec/sec STONKS! :D

Updated patch is below.

From 6be428e3b1c6fb494b2c48ba6a7c133514a0b2b4 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Fri, 10 Feb 2023 12:53:11 +0300
Subject: [PATCHv10.1 05/18] x86/kexec: Keep CR4.MCE set during kexec for TDX guest

Depending on setup, TDX guests might be allowed to clear CR4.MCE.
Attempt to clear it leads to #VE.

Use alternatives to keep the flag during kexec for TDX guests.

The change doesn't affect non-TDX-guest environments.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 56cab1bb25f5..90246d544eb1 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -5,6 +5,8 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/stringify.h>
+#include <asm/alternative.h>
 #include <asm/page_types.h>
 #include <asm/kexec.h>
 #include <asm/processor-flags.h>
@@ -143,14 +145,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 
 	/*
 	 * Set cr4 to a known state:
-	 *  - physical address extension enabled
 	 *  - 5-level paging, if it was enabled before
+	 *  - Machine check exception on TDX guest, if it was enabled before.
+	 *    Clearing MCE might not allowed in TDX guests, depending on setup.
+	 *  - physical address extension enabled
 	 */
-	movl	$X86_CR4_PAE, %eax
-	testq	$X86_CR4_LA57, %r13
-	jz	1f
-	orl	$X86_CR4_LA57, %eax
-1:
+	movl	$X86_CR4_LA57, %eax
+	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
+	andl	%r13d, %eax
+	orl	$X86_CR4_PAE, %eax
 	movq	%rax, %cr4
 
 	jmp 1f
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

