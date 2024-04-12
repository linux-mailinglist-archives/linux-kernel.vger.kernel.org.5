Return-Path: <linux-kernel+bounces-142039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F018A269D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E953B1C21C55
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8469937144;
	Fri, 12 Apr 2024 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5l0fjs/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1052D630
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903336; cv=none; b=ofDYiut7WYvz/jV4EKiU3+ml2ZgCbX1GUfANjZfCyA2s/OuYyeRVcq0qLb72jReV1nFlIBELg/l+Yn0bSGoqBnEIKPXHa8iBhgDQkuKwnm0uWnGMKQuaVStlOXziDcHbbsAoth4gXSLSczj+UQYav2WMd/al8nKhD+QL8NsMakY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903336; c=relaxed/simple;
	bh=psRLHHOSYXhN3hEwvr/xDK5h1bL2msxdtzYZi2j98T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFnHszZuV3ojqa2g/Qpyj5gMYubteVMLAJiaXMNxx7wb62u3QtxdkQkeM5Q/FmT0rWADw44Sr0UKtDYcLMIl958SFiWE9ngGWS6CFK2F0kLBAE4kTT9EkFG555niSVlv1BdSENm7Lh97y55mWtZHzMagPEe/hi0f8EZpRYSvXoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5l0fjs/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712903335; x=1744439335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=psRLHHOSYXhN3hEwvr/xDK5h1bL2msxdtzYZi2j98T8=;
  b=P5l0fjs/CDfFVxaVQnEae/dbo4iB/coV6Z8Bf3QCyBycxMwloKMOxD3u
   UVzudQb0x+DiCpuWstQEV76utjgWDhtQyM5RVQXX//2HfauYuqYk7jXVO
   xLNgMaSxHsf72Df97K0FSsuuoHhRFl0bSpf8fpfflrgK2pNREJmRxtGEw
   y5TDY1YxDIHJyZ0vHCxsf5f5fA92NbL7Ve+1BvnoBu6lqw/a1XbQrXmxT
   8QehVkVZAqmnwHw79VcaBX8PyDF/0+jMmZUUJtj+xfTbCyPpzwyFtn8KD
   QhSI8UQyeXqL8gaejm4Bbm2qiP2M6iA20wUxsWhiB30aRLX5zE1cJTiZO
   Q==;
X-CSE-ConnectionGUID: VaBUDJk3Q8GkeHENIqxJjQ==
X-CSE-MsgGUID: Fq49I44aT1mmgjz3sptSCg==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="25859595"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="25859595"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 23:28:54 -0700
X-CSE-ConnectionGUID: rOAzqBgMT72VtLqa082SBQ==
X-CSE-MsgGUID: raJhjUxCTombdbl3kUq2pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="25681098"
Received: from ccaruthe-mobl.amr.corp.intel.com (HELO desk) ([10.251.14.202])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 23:28:53 -0700
Date: Thu, 11 Apr 2024 23:28:44 -0700
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
Message-ID: <20240412062844.p5j33tmqjggladgl@desk>
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
> +			    X86_FEATURE_INDIRECT_SAFE)			\
> +		: "=D" (__rdi), "=S" (__rsi), "=a" (__rax),		\
> +		  ASM_CALL_CONSTRAINT					\
> +		: "0" (regs), "1" (nr), [func_ptr] "r" (table[nr])	\
> +		: "rdx", "rcx", "r8", "r9", "r10", "r11",		\
> +		  "cc", "memory");					\
> +									\
> +	__rax;								\
> +})

This is a nice implementation, but I think we can avoid the complexity
by using cpu_feature_enabled(). As cpu_feature_enabled() is also runtime
patched, atleast the likely() path should be comparable to this. Please
let me know if you have any concerns with this approach.

---
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6de50b80702e..7c5332b83246 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -49,7 +49,11 @@ static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
 
 	if (likely(unr < NR_syscalls)) {
 		unr = array_index_nospec(unr, NR_syscalls);
-		regs->ax = x64_sys_call(regs, unr);
+		if (likely(cpu_feature_enabled(X86_FEATURE_INDIRECT_SAFE)))
+			regs->ax = sys_call_table[unr](regs);
+		else
+			regs->ax = x64_sys_call(regs, unr);
+
 		return true;
 	}
 	return false;
@@ -66,7 +70,11 @@ static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
 
 	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(xnr < X32_NR_syscalls)) {
 		xnr = array_index_nospec(xnr, X32_NR_syscalls);
-		regs->ax = x32_sys_call(regs, xnr);
+		if (likely(cpu_feature_enabled(X86_FEATURE_INDIRECT_SAFE)))
+			regs->ax = x32_sys_call_table[xnr](regs);
+		else
+			regs->ax = x32_sys_call(regs, xnr);
+
 		return true;
 	}
 	return false;
@@ -162,7 +170,10 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs, int nr)
 
 	if (likely(unr < IA32_NR_syscalls)) {
 		unr = array_index_nospec(unr, IA32_NR_syscalls);
-		regs->ax = ia32_sys_call(regs, unr);
+		if (likely(cpu_feature_enabled(X86_FEATURE_INDIRECT_SAFE)))
+			regs->ax = ia32_sys_call_table[unr](regs);
+		else
+			regs->ax = ia32_sys_call(regs, unr);
 	} else if (nr != -1) {
 		regs->ax = __ia32_sys_ni_syscall(regs);
 	}

