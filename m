Return-Path: <linux-kernel+bounces-105691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD8487E2B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082151F21959
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 04:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F6920315;
	Mon, 18 Mar 2024 04:01:40 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CBE1E866;
	Mon, 18 Mar 2024 04:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710734500; cv=none; b=ICxuaTsTDO/bfCBYrhH821mVmOy6fJCJNJ93jK4wjJH4XwXCVO5Xuj3uQ2QBZQUSahvTAyZ8GWHvKSUWXFYXUKLO9nnyvvSEwY7VBcUsjjZvbSURwpVXWsvUUy0dH9VHatfoW0qcl+NOblZwY0f0eL1cXmU9qVw6gAgkvWHkcBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710734500; c=relaxed/simple;
	bh=eKge9M4i6lPpOTMUeCuYsdxpZrceAb6IaDSCK7EFZAo=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ckDoVBRVfhoWF0uFgtfuqlhtbC1fQs0gNzgj4NsuzNGB8X4qDf2CygbbSRZO72lwdfY1OwNpLTouj5psJywHNGsa1F4GG85NqB8w+AzzQ62zvvbPzPZFSoiP0lmDevYZ866FCAEatvTrUxKAt/PwKjV7SSmkhQJjTyIEdnivAyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Tyh1K5L67z1QBmM;
	Mon, 18 Mar 2024 11:59:01 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D15C1A016F;
	Mon, 18 Mar 2024 12:01:33 +0800 (CST)
Received: from [10.67.111.82] (10.67.111.82) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Mar
 2024 12:01:33 +0800
Subject: Re: [PATCH] usercopy: delete __noreturn from usercopy_abort
To: Josh Poimboeuf <jpoimboe@kernel.org>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <CAG48ez1h9X7Qv-5OR6hAhwnSOng6_PSXBaR6cT7xrk2Wzu39Yg@mail.gmail.com>
 <202403040938.D770633@keescook>
 <77bb0d81-f496-7726-9495-57088a4c0bfc@huawei.com>
 <202403050129.5B72ACAA0D@keescook>
 <b274b545-9439-7ff8-e3ed-604a9ac81f65@huawei.com>
 <20240305175846.qnyiru7uaa7itqba@treble>
CC: Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
	<gustavoars@kernel.org>, <akpm@linux-foundation.org>, <peterz@infradead.org>,
	<dave.hansen@linux.intel.com>, <kirill.shutemov@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<linux-mm@kvack.org>, <nixiaoming@huawei.com>, <kepler.chenxin@huawei.com>,
	<wangbing6@huawei.com>, <wangfangpeng1@huawei.com>, <douzhaolei@huawei.com>,
	Russell King <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>
From: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Message-ID: <d6281777-dc1b-a72c-79e2-b1f561472523@huawei.com>
Date: Mon, 18 Mar 2024 12:01:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240305175846.qnyiru7uaa7itqba@treble>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2024/3/6 1:58, Josh Poimboeuf wrote:

> Adding ARM folks -- see
> https://lkml.kernel.org/lkml/1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com
> for the original bug report.
> 
> This is an off-by-one bug which is common in unwinders, due to the fact
> that the address on the stack points to the return address rather than
> the call address.
> 
> So, for example, when the last instruction of a function is a function
> call (e.g., to a noreturn function), it can cause the unwinder to
> incorrectly try to unwind from the function *after* the callee.
> 
> For ORC (x86), we fixed this by decrementing the PC for call frames (but
> not exception frames).  I've seen user space unwinders do similar, for
> non-signal frames.
> 
> Something like the following might fix your issue (completely untested):
> 

Thank you very much. I have verified that your patch can fix my issue.
But I have some little questions.

> diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
> index 360f0d2406bf..4891e38cdc1f 100644
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
> @@ -37,9 +35,8 @@ void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
>  		frame->kr_cur = NULL;
>  		frame->tsk = current;
>  #endif
> -#ifdef CONFIG_UNWINDER_FRAME_POINTER
> -		frame->ex_frame = in_entry_text(frame->pc);
> -#endif
> +		frame->ex_frame = !!regs;
> +

'regs' must not be NULL, frame->ex_frame will always be TRUE.
So I think we just need to remove CONFIG_UNWINDER_FRAME_POINTER here.
We don't need to change the frame->ex_frame assignment statement.


> diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
> index 9d2192156087..99ded32196af 100644
> --- a/arch/arm/kernel/unwind.c
> +++ b/arch/arm/kernel/unwind.c
> @@ -407,7 +407,7 @@ int unwind_frame(struct stackframe *frame)
>  {
>  	const struct unwind_idx *idx;
>  	struct unwind_ctrl_block ctrl;
> -	unsigned long sp_low;
> +	unsigned long sp_low, pc;
>  
>  	/* store the highest address on the stack to avoid crossing it*/
>  	sp_low = frame->sp;
> @@ -417,19 +417,22 @@ int unwind_frame(struct stackframe *frame)
>  	pr_debug("%s(pc = %08lx lr = %08lx sp = %08lx)\n", __func__,
>  		 frame->pc, frame->lr, frame->sp);
>  
> -	idx = unwind_find_idx(frame->pc);
> +	pc = frame->ex_frame ? frame->pc : frame->pc - 4;

For details, see the unwind_next_frame function in the unwind_orc.c.
Why subtract 4 here instead of 1?
`pc = frame->ex_frame ? frame->pc : frame->pc - 1`
Is it more appropriate?

> +
> +	idx = unwind_find_idx(pc);
>  	if (!idx) {
> -		if (frame->pc && kernel_text_address(frame->pc)) {
> -			if (in_module_plt(frame->pc) && frame->pc != frame->lr) {
> +		if (kernel_text_address(pc)) {
> +			if (in_module_plt(pc) && frame->pc != frame->lr) {
>  				/*
>  				 * Quoting Ard: Veneers only set PC using a
>  				 * PC+immediate LDR, and so they don't affect
>  				 * the state of the stack or the register file
>  				 */
>  				frame->pc = frame->lr;
> +				frame->ex_frame = false;
>  				return URC_OK;
>  			}
> -			pr_warn("unwind: Index not found %08lx\n", frame->pc);
> +			pr_warn("unwind: Index not found %08lx\n", pc);
>  		}
>  		return -URC_FAILURE;
>  	}
> @@ -442,7 +445,7 @@ int unwind_frame(struct stackframe *frame)
>  	if (idx->insn == 1)
>  		/* can't unwind */
>  		return -URC_FAILURE;
> -	else if (frame->pc == prel31_to_addr(&idx->addr_offset)) {
> +	else if (frame->ex_frame && pc == prel31_to_addr(&idx->addr_offset)) {
>  		/*
>  		 * Unwinding is tricky when we're halfway through the prologue,
>  		 * since the stack frame that the unwinder expects may not be
> @@ -451,9 +454,10 @@ int unwind_frame(struct stackframe *frame)
>  		 * a function, we are still effectively in the stack frame of
>  		 * the caller, and the unwind info has no relevance yet.
>  		 */
> -		if (frame->pc == frame->lr)
> +		if (pc == frame->lr)
>  			return -URC_FAILURE;
>  		frame->pc = frame->lr;
> +		frame->ex_frame = false;
>  		return URC_OK;
>  	} else if ((idx->insn & 0x80000000) == 0)
>  		/* prel31 to the unwind table */
> @@ -515,6 +519,7 @@ int unwind_frame(struct stackframe *frame)
>  	frame->lr = ctrl.vrs[LR];
>  	frame->pc = ctrl.vrs[PC];
>  	frame->lr_addr = ctrl.lr_addr;
> +	frame->ex_frame = false;

Why is the value of `frame->ex_frame` directly set to false?
Why is the value not determined based on `frame->pc`?
That is, `frame->ex_frame = in_entry_text(frame->pc)`

>  
>  	return URC_OK;
>  }
> @@ -544,6 +549,7 @@ void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk,
>  		 */
>  here:
>  		frame.pc = (unsigned long)&&here;
> +		frame.ex_frame = false;
>  	} else {
>  		/* task blocked in __switch_to */
>  		frame.fp = thread_saved_fp(tsk);
> @@ -554,11 +560,12 @@ void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk,
>  		 */
>  		frame.lr = 0;
>  		frame.pc = thread_saved_pc(tsk);
> +		frame.ex_frame = false;
>  	}
>  
>  	while (1) {
>  		int urc;
> -		unsigned long where = frame.pc;
> +		unsigned long where = frame.ex_frame ? frame.pc : frame.pc - 4;
>  
>  		urc = unwind_frame(&frame);
>  		if (urc < 0)
> .
> 

If I refer to your demo patch and submit a new bugfix patch,
can I mark you as "Co-developed-by" in this new bugfix patch?

