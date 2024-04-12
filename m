Return-Path: <linux-kernel+bounces-142047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610998A26B8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0709B21FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D883F9E9;
	Fri, 12 Apr 2024 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oAHjtwf6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8362168DE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903875; cv=none; b=OKHsqUuuIHhe8+OGeALX1nsHZBGCHotVDviUOi2Ddgc3eUk+Fi587mBcca1zyiVNHhoVwMs5O/3c5Mjh3QAlgOccKP2Z3PN3JPjU0j6RRF341kVnuQuUY1JtArbVdx9xlx3cTHVyMtjTfKAN1TvD9KEOp5sbENCmb/wKCW1CdMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903875; c=relaxed/simple;
	bh=wf49vU3wxO+7g5vHILGQYoyMXXaNaNzlyUpS0RvxM8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMKUCbApyrkRtHX3SVgPFVMbVAS4plGArkt4BdWtDdcIFTzyxXoLDwBMQfkC24VwWtQF2asgQCVgKxQj+MR1Y6d14bs+JSGUorZmlX+gTCLIMCbJR3OugN/j9p+G6C8ML9t8AhX2nTp2bGddZbng1yRCrsT012h4KifiuR8bUrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oAHjtwf6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712903873; x=1744439873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wf49vU3wxO+7g5vHILGQYoyMXXaNaNzlyUpS0RvxM8M=;
  b=oAHjtwf6NgCL0UO+md2hL2sDQcS+Vt+8yA5ttrr9ZkxxERpaH9rQtnHA
   3JfoBMLdfsbTvQfFg9Kbr/4MdluixvWhdxTJWhIxn/ejjZuqwM+ZCCH4z
   rsyIBclrQ1rXhjQBIaSpaN0oRJJ+0l4HGHP96L0JV6Z+e/wgQkn1TyOcq
   uBzi4CuMgnDn9+mZh4rFhfjo6UJCP/7gha8jQ31mh0EplNtPyud/NV3bO
   lBnEs5WYL2d1tDfbHfsPDl5a1JqcgCHLlDCiiaNwJ0egsmHeUXE5GpOcY
   ayho68XFLO6cgofQhhUtMkRKomPfRg29XBhJBHqdj3ogiTy/8xpUMaUvL
   g==;
X-CSE-ConnectionGUID: fGlwWOq3RjWB2Z5Yh48MFw==
X-CSE-MsgGUID: ZwtnJ9qvRDa/ppYRT/Dxow==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="19059327"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="19059327"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 23:37:52 -0700
X-CSE-ConnectionGUID: SC8AzrMfS6aC1LlcBSdErw==
X-CSE-MsgGUID: VB8YPjGaRZGhh6kSohl0wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="44422086"
Received: from ccaruthe-mobl.amr.corp.intel.com (HELO desk) ([10.251.14.202])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 23:37:52 -0700
Date: Thu, 11 Apr 2024 23:37:42 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 5/7] x86/bugs: Only harden syscalls when needed
Message-ID: <20240412063742.bsy7jrpbvqydntre@desk>
References: <cover.1712813475.git.jpoimboe@kernel.org>
 <97befd7c1e008797734dee05181c49056ff6de57.1712813475.git.jpoimboe@kernel.org>
 <20240412062844.p5j33tmqjggladgl@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412062844.p5j33tmqjggladgl@desk>

On Thu, Apr 11, 2024 at 11:28:54PM -0700, Pawan Gupta wrote:
> > +#define __do_syscall(table, func_direct, nr, regs)			\
> > +({									\
> > +	unsigned long __rax, __rdi, __rsi;				\
> > +									\
> > +	asm_inline volatile(						\
> > +		ALTERNATIVE("call " __stringify(func_direct) "\n\t",	\
> > +			    ANNOTATE_RETPOLINE_SAFE			\
> > +			    "call *%[func_ptr]\n\t",			\
> > +			    X86_FEATURE_INDIRECT_SAFE)			\
> > +		: "=D" (__rdi), "=S" (__rsi), "=a" (__rax),		\
> > +		  ASM_CALL_CONSTRAINT					\
> > +		: "0" (regs), "1" (nr), [func_ptr] "r" (table[nr])	\
> > +		: "rdx", "rcx", "r8", "r9", "r10", "r11",		\
> > +		  "cc", "memory");					\
> > +									\
> > +	__rax;								\
> > +})
> 
> This is a nice implementation, but I think we can avoid the complexity
> by using cpu_feature_enabled(). As cpu_feature_enabled() is also runtime
> patched, atleast the likely() path should be comparable to this. Please
> let me know if you have any concerns with this approach.
> 
> ---
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 6de50b80702e..7c5332b83246 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -49,7 +49,11 @@ static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
>  
>  	if (likely(unr < NR_syscalls)) {
>  		unr = array_index_nospec(unr, NR_syscalls);
> -		regs->ax = x64_sys_call(regs, unr);
> +		if (likely(cpu_feature_enabled(X86_FEATURE_INDIRECT_SAFE)))
> +			regs->ax = sys_call_table[unr](regs);
> +		else
> +			regs->ax = x64_sys_call(regs, unr);

BTW, this also solves the missing lfence case before the indirect call.

