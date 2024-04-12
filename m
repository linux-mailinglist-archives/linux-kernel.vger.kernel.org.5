Return-Path: <linux-kernel+bounces-141744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 355BA8A22DE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02911F23778
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12501109;
	Fri, 12 Apr 2024 00:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bkF+T73C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A7836C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 00:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712880934; cv=none; b=Rg+yXCJu5hZVlPGB+F9SUSXM0ht158Lylq1KxHmy86HOgWQI06DNRHd8ckGmKdYG38iUWaLYDQstZgLASSuxv1avzXC6sywKCqN3q3N9vDDzCgxEOJEBdyeIFF0sCf4Tgc4pG/V9+vKtsdT0E1R2rQCN8JJvcFGvxW87cBdd9qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712880934; c=relaxed/simple;
	bh=MbYbHKaYYrxJIm4Fw2wvHNsnfpuTDp9lkXBmrxwCgpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMA6+1ZPop6fD+6C32h1/9jNHhtgH637C1PqO7btcOsSLw+E5VJb0CWjp5/dmjmutgs/36FzT7BknKRcxB3q24ghZjc7lz1I5UosolpeS1xddDjgk578cSLATALFBa579lA2zf82YCGMOzRYG9zAotnadnDsEFwuXi5+5nldSW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bkF+T73C; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712880933; x=1744416933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MbYbHKaYYrxJIm4Fw2wvHNsnfpuTDp9lkXBmrxwCgpg=;
  b=bkF+T73ChBwd/8e99sGdI8GLNII3frVOl+zGiCDMQ6fQ9Mf2sCLi/Alc
   KtuW3KJnEqqd8h083Z0oO0NBDGbXHSPFwvvevYcsK9vvws8sk8kHc8R4Y
   nthwIS4B4u9l7XTDnSDB5bmMI5PRC0W6GgPegNA+smph2TcH9S4ZwfOcQ
   8IHdpAIWGMJncsld4/h0+n0IEOsLv7Y2ixo5M6fUoTAv42hHgnWhPqYtG
   Nj0mMeNHKaZ/gKpRAEAGAEA/bRMaTGUa8ysRwZ0Cd+EJo+LRQ+qyFwCAK
   ApFVK8i1cRfBT81CKIi9vEM573inrS3w6q7NctEmINv4o6Vx+LlENJ7GD
   w==;
X-CSE-ConnectionGUID: zFrDygX8TUm5SfMTLfSgdA==
X-CSE-MsgGUID: t2DOCICYRA21Twh1sYrTCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="30806482"
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="30806482"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 17:15:32 -0700
X-CSE-ConnectionGUID: RiGasNyXTBu/IwBZtzs4Ow==
X-CSE-MsgGUID: YIq+Z4zeQPGFQy8b4Mmi9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="21501876"
Received: from haigouhu-mobl1.amr.corp.intel.com (HELO desk) ([10.209.117.182])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 17:15:31 -0700
Date: Thu, 11 Apr 2024 17:15:22 -0700
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
Message-ID: <20240412001522.3zp2mzked4ksglkl@desk>
References: <cover.1712813475.git.jpoimboe@kernel.org>
 <97befd7c1e008797734dee05181c49056ff6de57.1712813475.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97befd7c1e008797734dee05181c49056ff6de57.1712813475.git.jpoimboe@kernel.org>

On Wed, Apr 10, 2024 at 10:40:49PM -0700, Josh Poimboeuf wrote:
> Syscall hardening (i.e., converting the syscall indirect branch to a
> series of direct branches) may cause performance regressions in certain
> scenarios.  Only use the syscall hardening when indirect branches are
> considered unsafe.
> 
> Fixes: 1e3ad78334a6 ("x86/syscall: Don't force use of indirect calls for system calls")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/entry/common.c            | 30 +++++++++++++++++++++++++---
>  arch/x86/entry/syscall_32.c        | 11 +---------
>  arch/x86/entry/syscall_64.c        |  8 +-------
>  arch/x86/entry/syscall_x32.c       |  7 ++++++-
>  arch/x86/include/asm/cpufeatures.h |  1 +
>  arch/x86/include/asm/syscall.h     |  8 +++++++-
>  arch/x86/kernel/cpu/bugs.c         | 32 +++++++++++++++++++++++++++++-
>  7 files changed, 74 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 6de50b80702e..80d432d2fe44 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -39,6 +39,28 @@
>  
>  #ifdef CONFIG_X86_64
>  
> +/*
> + * Do either a direct or an indirect call, depending on whether indirect calls
> + * are considered safe.
> + */
> +#define __do_syscall(table, func_direct, nr, regs)			\
> +({									\
> +	unsigned long __rax, __rdi, __rsi;				\
> +									\
> +	asm_inline volatile(						\
> +		ALTERNATIVE("call " __stringify(func_direct) "\n\t",	\
> +			    ANNOTATE_RETPOLINE_SAFE			\
> +			    "call *%[func_ptr]\n\t",			\

This will likely not insert the lfence before the indirect call in
spectre_v2=eibrs,lfence mode. As X86_FEATURE_INDIRECT_SAFE is not
cleared when eIBRS is enabled, this will not be converted to direct
call.

[...]
> @@ -1720,6 +1744,7 @@ static void __init spectre_v2_select_mitigation(void)
>  
>  	case SPECTRE_V2_CMD_RETPOLINE_LFENCE:
>  		pr_err(SPECTRE_V2_LFENCE_MSG);
> +		setup_clear_cpu_cap(X86_FEATURE_INDIRECT_SAFE);

I don't know if it intentional, this seems to be the duplicate of
X86_FEATURE_INDIRECT_SAFE clear later in SPECTRE_V2_LFENCE mode. Also it
seems a bit odd to do this here in SPECTRE_V2_CMD handling.

>  		mode = SPECTRE_V2_LFENCE;
>  		break;
>  
> @@ -1772,11 +1797,16 @@ static void __init spectre_v2_select_mitigation(void)
>  		break;
>  
>  	case SPECTRE_V2_LFENCE:
> +		setup_clear_cpu_cap(X86_FEATURE_INDIRECT_SAFE);
> +		fallthrough;
>  	case SPECTRE_V2_EIBRS_LFENCE:
>  		setup_force_cpu_cap(X86_FEATURE_RETPOLINE_LFENCE);
> -		fallthrough;
> +		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
> +		break;
>  
>  	case SPECTRE_V2_RETPOLINE:
> +		setup_clear_cpu_cap(X86_FEATURE_INDIRECT_SAFE);
> +		fallthrough;
>  	case SPECTRE_V2_EIBRS_RETPOLINE:
>  		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
>  		break;

