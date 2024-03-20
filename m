Return-Path: <linux-kernel+bounces-108630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C791880D68
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48AB283A81
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D9C38DD7;
	Wed, 20 Mar 2024 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iLrI8c0f"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D720364D4;
	Wed, 20 Mar 2024 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924344; cv=none; b=DZWK68copL8GpjW8Kpq1AKDBeo/tlExrJmpurYs4kmfzzz8PClLc9Dy8IZZ1AtgPeJ5MAucZsJPPg5LndH/gfVTLWE4O+uD6+1LinZGUDngOplP3x2MJ1NY+XwpFet2b6xWWI55XYXz67piLVowkUEoGjoiEzefZ+iBcemIDKlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924344; c=relaxed/simple;
	bh=wDf94NwLj0AL/VLpsV9ZBxoXZGWDE5DxK3wBHNr+CoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTNAGJmZFncbOIw0rYfeXsQMoYx79zkX1fPSvnhUJKqsnrGVuZ1CgLq9mAA74cKfMjNZl2Mz4wrH9/kMPV2njdjWK9MrxtJrEfp//28RrZ/LM42mQwpiP/is4jnzjJ0fThbouicbJBzbY7HS5Fpr9qbV2LNLK529D2fM/l2xbEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iLrI8c0f; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3aU/Zt9LBTw5WsKLQZ2I68GMh3ulAkeZBoPkMlotUXM=; b=iLrI8c0fhZUzbZMNPnBFFo0hkC
	sITZeKCIgpryXsWbtNZL0XdnM2Oeiw0KZy3I0O7dc3B87ZvETPmV4o7hnEDI2eindh7ioRIK+alP+
	7iMneRZKG4/kfW6gn4UaA0F/XG7I6Ery9m0X8/gYwAZ902Z1NWscuKUSd4x3Sj+PYcPuhZ5I0F48j
	Dy7iAgrXvIA0BSJZTyeiv6iGKtXLBke54Ue1BVY0kUzSr6wtNvaZ2ljy/Y/WI8iEKaOf2rlVu2FjE
	Zv8nmVqOI/dlm+rF+BywbpVqlnU4Ibv6Z931EwXehpI9y55m4TwilusEHRCf8RBUO4y8iPRKL21KH
	owW+QkiA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55760)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rmrZO-0006HK-2m;
	Wed, 20 Mar 2024 08:45:10 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rmrZH-0002Wj-PF; Wed, 20 Mar 2024 08:45:03 +0000
Date: Wed, 20 Mar 2024 08:45:03 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Cc: arnd@arndb.de, keescook@chromium.org, haibo.li@mediatek.com,
	angelogioacchino.delregno@collabora.com, amergnat@baylibre.com,
	akpm@linux-foundation.org, dave.hansen@linux.intel.com,
	douzhaolei@huawei.com, gustavoars@kernel.org, jpoimboe@kernel.org,
	kepler.chenxin@huawei.com, kirill.shutemov@linux.intel.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	nixiaoming@huawei.com, peterz@infradead.org, wangbing6@huawei.com,
	wangfangpeng1@huawei.com, jannh@google.com, willy@infradead.org,
	David.Laight@aculab.com
Subject: Re: [PATCH v2] ARM: unwind: improve unwinders for noreturn case
Message-ID: <ZfqiD8Yw0oOVHW/p@shell.armlinux.org.uk>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <1710906278-23851-1-git-send-email-xiaojiangfeng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1710906278-23851-1-git-send-email-xiaojiangfeng@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 20, 2024 at 11:44:38AM +0800, Jiangfeng Xiao wrote:
> This is an off-by-one bug which is common in unwinders,
> due to the fact that the address on the stack points
> to the return address rather than the call address.
> 
> So, for example, when the last instruction of a function
> is a function call (e.g., to a noreturn function), it can
> cause the unwinder to incorrectly try to unwind from
> the function after the callee.
> 
> foo:
> ...
> 	bl	bar
> ... end of function and thus next function ...
> 
> which results in LR pointing into the next function.
> 
> Fixed this by subtracting 1 from frmae->pc in the call frame
> (but not exception frames) like ORC on x86 does.

The reason that I'm not accepting this patch is because the above says
that it fixes it by subtracting 1 from the PC value, but the patch is
*way* more complicated than that and there's no explanation why.

For example, the following are unexplained:

- Why do we always need ex_frame
- What is the purpose of the change in format string for the display of
  backtraces

> 
> Refer to the unwind_next_frame function in the unwind_orc.c
> 
> Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Link: https://lkml.kernel.org/lkml/20240305175846.qnyiru7uaa7itqba@treble/
> Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
> ---
> ChangeLog v1->v2
> - stay printk("%s...", loglvl, ...)
> ---
>  arch/arm/include/asm/stacktrace.h |  4 ----
>  arch/arm/kernel/stacktrace.c      |  2 --
>  arch/arm/kernel/traps.c           |  4 ++--
>  arch/arm/kernel/unwind.c          | 18 +++++++++++++++---
>  4 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
> index 360f0d2..07e4c16 100644
> --- a/arch/arm/include/asm/stacktrace.h
> +++ b/arch/arm/include/asm/stacktrace.h
> @@ -21,9 +21,7 @@ struct stackframe {
>  	struct llist_node *kr_cur;
>  	struct task_struct *tsk;
>  #endif
> -#ifdef CONFIG_UNWINDER_FRAME_POINTER
>  	bool ex_frame;
> -#endif
>  };
>  
>  static __always_inline
> @@ -37,9 +35,7 @@ void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
>  		frame->kr_cur = NULL;
>  		frame->tsk = current;
>  #endif
> -#ifdef CONFIG_UNWINDER_FRAME_POINTER
>  		frame->ex_frame = in_entry_text(frame->pc);
> -#endif
>  }
>  
>  extern int unwind_frame(struct stackframe *frame);
> diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
> index 620aa82..1abd4f9 100644
> --- a/arch/arm/kernel/stacktrace.c
> +++ b/arch/arm/kernel/stacktrace.c
> @@ -154,9 +154,7 @@ static void start_stack_trace(struct stackframe *frame, struct task_struct *task
>  	frame->kr_cur = NULL;
>  	frame->tsk = task;
>  #endif
> -#ifdef CONFIG_UNWINDER_FRAME_POINTER
>  	frame->ex_frame = in_entry_text(frame->pc);
> -#endif
>  }
>  
>  void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 3bad79d..46a5b1e 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -84,10 +84,10 @@ void dump_backtrace_entry(unsigned long where, unsigned long from,
>  	printk("%sFunction entered at [<%08lx>] from [<%08lx>]\n",
>  		loglvl, where, from);
>  #elif defined CONFIG_BACKTRACE_VERBOSE
> -	printk("%s[<%08lx>] (%ps) from [<%08lx>] (%pS)\n",
> +	printk("%s[<%08lx>] (%ps) from [<%08lx>] (%pB)\n",
>  		loglvl, where, (void *)where, from, (void *)from);
>  #else
> -	printk("%s %ps from %pS\n", loglvl, (void *)where, (void *)from);
> +	printk("%s %ps from %pB\n", loglvl, (void *)where, (void *)from);
>  #endif
>  
>  	if (in_entry_text(from) && end <= ALIGN(frame, THREAD_SIZE))
> diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
> index 9d21921..f2baf92 100644
> --- a/arch/arm/kernel/unwind.c
> +++ b/arch/arm/kernel/unwind.c
> @@ -30,6 +30,7 @@
>  #include <linux/list.h>
>  #include <linux/module.h>
>  
> +#include <asm/sections.h>
>  #include <asm/stacktrace.h>
>  #include <asm/traps.h>
>  #include <asm/unwind.h>
> @@ -416,8 +417,14 @@ int unwind_frame(struct stackframe *frame)
>  
>  	pr_debug("%s(pc = %08lx lr = %08lx sp = %08lx)\n", __func__,
>  		 frame->pc, frame->lr, frame->sp);
> -
> -	idx = unwind_find_idx(frame->pc);
> +	/*
> +	 * For a call frame (as opposed to a exception frame), when the last
> +	 * instruction of a function is a function call (e.g., to a noreturn
> +	 * function), it can cause the unwinder incorrectly try to unwind
> +	 * from the function after the callee, fixed this by subtracting 1
> +	 * from frame->pc in the call frame like ORC on x86 does.
> +	 */
> +	idx = unwind_find_idx(frame->ex_frame ? frame->pc : frame->pc - 1);
>  	if (!idx) {
>  		if (frame->pc && kernel_text_address(frame->pc)) {
>  			if (in_module_plt(frame->pc) && frame->pc != frame->lr) {
> @@ -427,6 +434,7 @@ int unwind_frame(struct stackframe *frame)
>  				 * the state of the stack or the register file
>  				 */
>  				frame->pc = frame->lr;
> +				frame->ex_frame = in_entry_text(frame->pc);
>  				return URC_OK;
>  			}
>  			pr_warn("unwind: Index not found %08lx\n", frame->pc);
> @@ -454,6 +462,7 @@ int unwind_frame(struct stackframe *frame)
>  		if (frame->pc == frame->lr)
>  			return -URC_FAILURE;
>  		frame->pc = frame->lr;
> +		frame->ex_frame = in_entry_text(frame->pc);
>  		return URC_OK;
>  	} else if ((idx->insn & 0x80000000) == 0)
>  		/* prel31 to the unwind table */
> @@ -515,6 +524,7 @@ int unwind_frame(struct stackframe *frame)
>  	frame->lr = ctrl.vrs[LR];
>  	frame->pc = ctrl.vrs[PC];
>  	frame->lr_addr = ctrl.lr_addr;
> +	frame->ex_frame = in_entry_text(frame->pc);
>  
>  	return URC_OK;
>  }
> @@ -544,6 +554,7 @@ void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk,
>  		 */
>  here:
>  		frame.pc = (unsigned long)&&here;
> +		frame.ex_frame = false;
>  	} else {
>  		/* task blocked in __switch_to */
>  		frame.fp = thread_saved_fp(tsk);
> @@ -554,11 +565,12 @@ void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk,
>  		 */
>  		frame.lr = 0;
>  		frame.pc = thread_saved_pc(tsk);
> +		frame.ex_frame = false;
>  	}
>  
>  	while (1) {
>  		int urc;
> -		unsigned long where = frame.pc;
> +		unsigned long where = frame.ex_frame ? frame.pc : frame.pc - 1;
>  
>  		urc = unwind_frame(&frame);
>  		if (urc < 0)
> -- 
> 1.8.5.6
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

