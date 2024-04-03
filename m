Return-Path: <linux-kernel+bounces-129024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22749896355
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1F2284AA9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E8240BE3;
	Wed,  3 Apr 2024 04:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAg1G0/x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0661C280;
	Wed,  3 Apr 2024 04:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712116926; cv=none; b=sXZrSQg06xa65EabRMxy6vKX0htsfSNwjDg04dW/8aJfcVNKa13FI9YvbxR88Bd8F/1ZZ9AwVl/Wc/mumGusIVxAqJbr69Kd6BqVp/Y39HLzFvnxTro1mhgtwP8Hz0PZwClh++EjPt+qE+pW0ifjYxawpmhfrTPjzsTzZj4ihG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712116926; c=relaxed/simple;
	bh=cOa4fNgEyvNjT9Vjx3Vq26F8M+OGOGyiXKEqLnmUWkA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Hh0DC/dOwlXsGSf784wIIbQGdewqn212RfSTa0U1CfS4DiLnCg8VBGYkWagKKsP9GRL6Fk2lcXlQMYVUe7amQRQ8DsvV2/JG6YRDtVLifLPdUrEPx2L8trMTW+YLFIeOGpRamuCEJhslXJvPZLR+bSmFOt3z9cOc2wvVy6BBsLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAg1G0/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F374C433F1;
	Wed,  3 Apr 2024 04:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712116925;
	bh=cOa4fNgEyvNjT9Vjx3Vq26F8M+OGOGyiXKEqLnmUWkA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GAg1G0/xIX2J1J2IzlgQUaI7CAKrBrsNO0nZvJUPlmPNNTu3eCx7XiWUEUlw1Fien
	 49QTU1ItigL5WfET0Aqm7pwwMS1yzcJpmHDBCb2t+TSbvGyZ06eh5uDJklBIXMsnQF
	 863JiHn3OCZN4Ro41fhKIUCifx4crkJsp5t8pdRLowpzP2F0kXvYrxpqC6Ap2d1VLW
	 4C7aznm4dp4E+KlxLkUk8D+O33R72FfCQVR9Js6f7BaiL4yDvgd6zgCYZ4OUXviqQp
	 CqprBfm1MqQCP0dQLEvwmJaH3QPEqV8iW+1xcmOXGKUxHXbM5tw7rNnSXRnCc9IRZn
	 z0uNl48TR7s5w==
Date: Wed, 3 Apr 2024 13:02:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexandre Ghiti
 <alexghiti@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Steven Rostedt <rostedt@goodmis.org>, Mark Rutland
 <mark.rutland@arm.com>, Sami Tolvanen <samitolvanen@google.com>, Guo Ren
 <guoren@kernel.org>, Ley Foon Tan <leyfoon.tan@starfivetech.com>, Deepak
 Gupta <debug@rivosinc.com>, Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Song Shuai <suagrfillet@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <cleger@rivosinc.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ftrace: riscv: move from REGS to ARGS
Message-Id: <20240403130201.3340e5fe1d01a4f86dd2d772@kernel.org>
In-Reply-To: <87bk6rsyry.fsf@all.your.base.are.belong.to.us>
References: <20240328141845.128645-1-puranjay12@gmail.com>
	<87bk6rsyry.fsf@all.your.base.are.belong.to.us>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 02 Apr 2024 15:02:41 +0200
Björn Töpel <bjorn@kernel.org> wrote:

> Puranjay Mohan <puranjay12@gmail.com> writes:
> 
> > This commit replaces riscv's support for FTRACE_WITH_REGS with support
> > for FTRACE_WITH_ARGS. This is required for the ongoing effort to stop
> > relying on stop_machine() for RISCV's implementation of ftrace.
> >
> > The main relevant benefit that this change will bring for the above
> > use-case is that now we don't have separate ftrace_caller and
> > ftrace_regs_caller trampolines.  This will allow the callsite to call
> > ftrace_caller by modifying a single instruction. Now the callsite can
> > do something similar to:
> >
> > When not tracing:            |             When tracing:
> >
> > func:                                      func:
> >   auipc t0, ftrace_caller_top                auipc t0, ftrace_caller_top
> >   nop  <=========<Enable/Disable>=========>  jalr  t0, ftrace_caller_bottom
> >   [...]                                      [...]
> >
> > The above assumes that we are dropping the support of calling a direct
> > trampoline from the callsite. We need to drop this as the callsite can't
> > change the target address to call, it can only enable/disable a call to
> > a preset target (ftrace_caller in the above diagram).
> >
> > Currently, ftrace_regs_caller saves all CPU registers in the format of
> > struct pt_regs and allows the tracer to modify them. We don't need to
> > save all of the CPU registers because at function entry only a subset of
> > pt_regs is live:
> >
> > |----------+----------+---------------------------------------------|
> > | Register | ABI Name | Description                                 |
> > |----------+----------+---------------------------------------------|
> > | x1       | ra       | Return address for traced function          |
> > | x2       | sp       | Stack pointer                               |
> > | x5       | t0       | Return address for ftrace_caller trampoline |
> > | x8       | s0/fp    | Frame pointer                               |
> > | x10-11   | a0-1     | Function arguments/return values            |
> > | x12-17   | a2-7     | Function arguments                          |
> > |----------+----------+---------------------------------------------|
> >
> > See RISCV calling convention[1] for the above table.
> >
> > Saving just the live registers decreases the amount of stack space
> > required from 288 Bytes to 112 Bytes.
> >
> > Basic testing was done with this on the VisionFive 2 development board.
> >
> > Note:
> >   - Moving from REGS to ARGS will mean that RISCV will stop supporting
> >     KPROBES_ON_FTRACE as it requires full pt_regs to be saved.
> 
> ...and FPROBES, but Masami is (still?) working on a series to address
> that [1].

Yes, even with this patch, FPROBE can be worked with my series.
So I'm OK for this change.

Thank you,

> 
> My perspective; This is following the work Mark et al has done for
> arm64, and it does make sense for RISC-V as well. I'm in favor having
> this change as part of the bigger call_ops/text patch change for RISC-V.
> 
> [...]
> 
> > diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
> > index 1276d7d9ca8b..1e95bf4ded6c 100644
> > --- a/arch/riscv/include/asm/ftrace.h
> > +++ b/arch/riscv/include/asm/ftrace.h
> > @@ -124,20 +124,87 @@ struct dyn_ftrace;
> >  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
> >  #define ftrace_init_nop ftrace_init_nop
> >  
> > -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> > +#define arch_ftrace_get_regs(regs) NULL
> >  struct ftrace_ops;
> > -struct ftrace_regs;
> > +struct ftrace_regs {
> > +	unsigned long epc;
> > +	unsigned long ra;
> > +	unsigned long sp;
> > +	unsigned long s0;
> > +	unsigned long t1;
> > +	union {
> > +		unsigned long args[8];
> > +		struct {
> > +			unsigned long a0;
> > +			unsigned long a1;
> > +			unsigned long a2;
> > +			unsigned long a3;
> > +			unsigned long a4;
> > +			unsigned long a5;
> > +			unsigned long a6;
> > +			unsigned long a7;
> > +		};
> > +	};
> > +};
> > +
> > +static __always_inline unsigned long
> > +ftrace_regs_get_instruction_pointer(const struct ftrace_regs *fregs)
> > +{
> > +	return fregs->epc;
> > +}
> > +
> > +static __always_inline void
> > +ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
> > +				    unsigned long pc)
> > +{
> > +	fregs->epc = pc;
> > +}
> > +
> > +static __always_inline unsigned long
> > +ftrace_regs_get_stack_pointer(const struct ftrace_regs *fregs)
> > +{
> > +	return fregs->sp;
> > +}
> > +
> > +static __always_inline unsigned long
> > +ftrace_regs_get_argument(struct ftrace_regs *fregs, unsigned int n)
> > +{
> > +	if (n < 8)
> > +		return fregs->args[n];
> > +	return 0;
> > +}
> > +
> > +static __always_inline unsigned long
> > +ftrace_regs_get_return_value(const struct ftrace_regs *fregs)
> > +{
> > +	return fregs->a0;
> > +}
> > +
> > +static __always_inline void
> > +ftrace_regs_set_return_value(struct ftrace_regs *fregs,
> > +			     unsigned long ret)
> > +{
> > +	fregs->a0 = ret;
> > +}
> > +
> > +static __always_inline void
> > +ftrace_override_function_with_return(struct ftrace_regs *fregs)
> > +{
> > +	fregs->epc = fregs->ra;
> > +}
> 
> Style/nit: All above; Try to use the full 100 chars, and keep the
> function name return value on the same line for grepability.
> 
> 
> Björn
> 
> [1] https://lore.kernel.org/all/170887410337.564249.6360118840946697039.stgit@devnote2/


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

