Return-Path: <linux-kernel+bounces-141979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8A98A25B6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1E1FB23801
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B5D224FD;
	Fri, 12 Apr 2024 05:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWybwZFa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C140D1EEEA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712899658; cv=none; b=Xoa3WbFPk4SEyqnNEbPSwVKlDoed1smRvUesGgqJgK787X5g9cPrLypp76+WXaBGwdKtUEOOFD9H7lDuxltprGVJMrVRDAPCrFltUIh2LuU54MzDA9mKil1XW/xxt0+0DmzkMTkjCjRv6SAT8tBh+zStnzdhnP2vTg6+jsWknmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712899658; c=relaxed/simple;
	bh=GrAxMwC7hc8HXHHvpUJVvmilpxoKe4Cf4Lv9WS2dIz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fpnnw6w3JnOGWmIFPb+ZwB/MEIQkivFKuot6/A7ddpNMwakO60zTvhi2pfXnSIwLYhsOCl4J+VRVYRPpopDrz3kHrdKRuCikUPFrJjiZk+5/esy47jZ1XXZljxjH/w89vqNMuV69onx+G7mxOUOI5PRmZ0VUfiyfI1jv4gu6IcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWybwZFa; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712899657; x=1744435657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GrAxMwC7hc8HXHHvpUJVvmilpxoKe4Cf4Lv9WS2dIz0=;
  b=VWybwZFaxINYwHnEySqD/k5AEZK832Wz2TK6P+x8rkByIhuAgMFlc3bi
   eC7BqstnRXby+HjpTC2XBYHb9XpymDyTbRgO2JyESmg1FI7lrGcXwR2Nl
   3bSKAMUIarN8gadDp8h9tUMZcQc6Rzm8oxr38kE3fblUWYNLTwKjsmfc+
   3CAKnIxqYi6J+30oxYhfi+utqcZhzCFirrDFEPsz5/xkBVDov5luIaT27
   dLKyzptwbjMt5s97o2HpDxKmP8/mkvyQ1gmZMZa/HWBdSEBIR7g6YJEnJ
   ZYVT0rlYRGNpkdTyuddYx75Z6Qc/zDNczYNeLd+6mhrZbJ2ZrYF4HgVB2
   A==;
X-CSE-ConnectionGUID: OlgQV7EnSPiJ3aiz2ESU0w==
X-CSE-MsgGUID: vYUI9vTCSZ+JVT1Wpd+mlg==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="12134402"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="12134402"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 22:27:36 -0700
X-CSE-ConnectionGUID: e6U2AKcFQR2MVxOahkUWOg==
X-CSE-MsgGUID: m8OVdx4jRvOKhJ07m4tS9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21100004"
Received: from haigouhu-mobl1.amr.corp.intel.com (HELO desk) ([10.209.117.182])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 22:27:35 -0700
Date: Thu, 11 Apr 2024 22:27:27 -0700
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
Message-ID: <20240412052727.vfvlmou4vaimdgg7@desk>
References: <cover.1712813475.git.jpoimboe@kernel.org>
 <97befd7c1e008797734dee05181c49056ff6de57.1712813475.git.jpoimboe@kernel.org>
 <20240412001522.3zp2mzked4ksglkl@desk>
 <20240412035740.ojgvlqahqlm2umsx@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412035740.ojgvlqahqlm2umsx@treble>

On Thu, Apr 11, 2024 at 08:57:40PM -0700, Josh Poimboeuf wrote:
> On Thu, Apr 11, 2024 at 05:15:22PM -0700, Pawan Gupta wrote:
> > > + * Do either a direct or an indirect call, depending on whether indirect calls
> > > + * are considered safe.
> > > + */
> > > +#define __do_syscall(table, func_direct, nr, regs)			\
> > > +({									\
> > > +	unsigned long __rax, __rdi, __rsi;				\
> > > +									\
> > > +	asm_inline volatile(						\
> > > +		ALTERNATIVE("call " __stringify(func_direct) "\n\t",	\
> > > +			    ANNOTATE_RETPOLINE_SAFE			\
> > > +			    "call *%[func_ptr]\n\t",			\
> > 
> > This will likely not insert the lfence before the indirect call in
> > spectre_v2=eibrs,lfence mode. As X86_FEATURE_INDIRECT_SAFE is not
> > cleared when eIBRS is enabled, this will not be converted to direct
> > call.
> 
> Hm, I think the problem here is that SPECTRE_V2_EIBRS_LFENCE confusingly
> sets X86_FEATURE_RETPOLINE.  So the following bit unintentionally takes

I think it is intentional, more on it below.

> effect:
> 
> 	/* Retpoline mitigates against BHI unless the CPU has RRSBA behavior */
> 	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
> 		spec_ctrl_disable_kernel_rrsba();
> 		if (rrsba_disabled)
> 			return;
> 	}
> 
> If RRSBA gets disabled (which is likely), bhi_select_mitigation()
> returns early and X86_FEATURE_INDIRECT_SAFE doesn't get cleared.
> 
> "LFENCE; CALL" is most definitely not a retpoline, so it's weird for
> SPECTRE_V2_EIBRS_LFENCE to be setting X86_FEATURE_RETPOLINE.  We should
> fix that.

I could be completely wrong here, but my guess is, it is needed because
the thunk call inserted by the compiler with X86_FEATURE_RETPOLINE
provides room for adding the extra lfence.

In order to prefix lfence(3 bytes) indirect call is first converted to
call __x86_indirect_thunk_reg, which has a 5 byte opcode. At runtime,
thunk call is patched to "lfence;call *reg", which is also 3+2=5 bytes.

Thunk call is anyways needed because, there are indirect
calls opcodes that are 3 byte long e.g. call *%r8. So, wherever possible
lfence+call* is inlined, otherwise lfence is executed in a call to thunk,
which then does jmp *%reg.

> Honestly, I think SPECTRE_V2_EIBRS_LFENCE is obsolete anyway.  It was
> originally intended to be a BHI mitigation, but the real-world
> benchmarks I've seen are showing it to be quite a bit slower than the
> actual BHI mitigations.
> 
> Plus it's only a partial fix because the speculative window after the
> branch can still be big enough to do multiple loads.

Thats fair.

