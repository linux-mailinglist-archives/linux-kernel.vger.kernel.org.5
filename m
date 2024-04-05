Return-Path: <linux-kernel+bounces-133103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB59899EE5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1632B22A5E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D27D16DECB;
	Fri,  5 Apr 2024 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BByG0+AD"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD8316D9D2;
	Fri,  5 Apr 2024 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712325610; cv=none; b=etAQIZrfwl6v0hVtk81APUH9zPsmiLVZFWEnQRZbR8kUjSyHBu99Pd5yJjgUGA+BPgqevDX7pOSCWfsEMKgLp9OwtQlva2/miPU/StzlETMK/mkDBQ4fMJCbHnKPuGlrHiipwOGfWZbatXtfxhSMw/H4nCsDDgF30JtdMCfewiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712325610; c=relaxed/simple;
	bh=/lOym5r6Sk75tqitNn3qqMe4xqt39uYt7Ft/Vtc0GQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sb3mMTe4Y/z3st+59U0OONP5ArCPqrs12zoiB59jbcO1D2I5lFBUFFnPwPp6aFUoi/iYEoSea3ZCrIOqacxfujjZY/TY8PXiUftV0KKyovK7fmhLjj3iF4w24Vq9IyOKampI8+mu8tGm14ltKLqyAZ0Gj4pUaIOdl2R/XWtfXRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BByG0+AD; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516c403cc46so4215292e87.3;
        Fri, 05 Apr 2024 07:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712325607; x=1712930407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+JOsadKfFathomT/VZJtKT0zxsgL3aEkcsxRTzINeQ=;
        b=BByG0+ADAI+XH4WPd08ClK4qgYjnOaIjKda/dDWBYD2HliQWcrAfl++k/uOgXQnijV
         DAqIQfPi6R6S66GkmuBLzL2Ydp5+9R9To/E4vCHr2nZsXjdVUSRpLlT9y6G1lOzJ/Ywb
         PV+NJueq4DgCKli5b/5wWQmqd9Qe9suyRqiYNGnwhW/NFQ1rQhc6y/tdg0zboJYDMXzl
         osfelAZwQj8r94cU800BAGi7ta2Xb3/O8Homv64+ller2/HF28O7VYvZi7sYPUpb86HT
         u8yXyUJkBCkzn/uep08/G+KFn9Zyq+mMMge2lqDmZr7WFslpUl4+awtTC7AAK6Yn6Qyx
         v5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712325607; x=1712930407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+JOsadKfFathomT/VZJtKT0zxsgL3aEkcsxRTzINeQ=;
        b=tLmqHn/QnO8dgcv8egwCYdvnu8LzYneUwXbmdRfzqRO3G44rHJzUj2stILapyrtZcX
         tbeBwq1OiVMBis2y3IDiL7yZ5ENJ6tYzfla4nZgB4LCcmL7ADS3WdRpKixPYOqKVlUMh
         T6w8SIkvhyvEWT9+io5K9O2dtLif0x8og3brxAb//SKFkf1YjMMseqywEJye+rOjd7Z/
         50HugqkRVUR6BII8etlKzm8XljWaT4IFd9Ralme1Xn8sTvl70vr0UMrKAX3uKszAiNma
         HQsNJ1AWH3TWFDB2vvT0EkekRAGXRMRAqkjDCg6D1UGABNuLBQgs2ipBYvKCAyAqzD9T
         c8vA==
X-Forwarded-Encrypted: i=1; AJvYcCUk2Mprf0/FLkrTP9xYz9WtvxZT1XMWZ/QwOutCPn29j9XbY6Eq0nPSBDnY5FZHlF+Hl0P73MrZ4jOg9z/89LYU+wCItVvRv0QbOkMyDrYbJ1RGYf3n5jOnG9WfRjxu2rxzezE/P/9f2H9H77ZmBKWF
X-Gm-Message-State: AOJu0YyNOOTaj0DOXNEMcGiBWPLz9m4nWvkESuOQhZeohR9QKS5qe+5L
	dUYX+QoZwUGa4RiRuVVQrEIYsSDwhjQZfF5R6PP0tfN7cNPAkzAfXWRu8MlKwHsFHvv/WU7/qrD
	NrR6+HDV/6mv+dT/Rjqr1+9iu8kQ=
X-Google-Smtp-Source: AGHT+IHVt8RDgDjC3fyDpZxaqbL2BMpJsAAbrWtLM942yF9DzQZJz9W4aMfcrSjQM+xHatneoKjHAlweBiB4ZOQTcCI=
X-Received: by 2002:a19:641c:0:b0:516:c44a:657d with SMTP id
 y28-20020a19641c000000b00516c44a657dmr1349763lfb.64.1712325606373; Fri, 05
 Apr 2024 07:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328141845.128645-1-puranjay12@gmail.com> <87bk6rsyry.fsf@all.your.base.are.belong.to.us>
 <20240403130201.3340e5fe1d01a4f86dd2d772@kernel.org>
In-Reply-To: <20240403130201.3340e5fe1d01a4f86dd2d772@kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 5 Apr 2024 15:59:55 +0200
Message-ID: <CANk7y0ikcbvgHxYb_WJfofGgZQGT=cEWQCQ0CBU2V5dpqGsHVQ@mail.gmail.com>
Subject: Re: [RFC PATCH] ftrace: riscv: move from REGS to ARGS
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Steven Rostedt <rostedt@goodmis.org>, 
	Mark Rutland <mark.rutland@arm.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Guo Ren <guoren@kernel.org>, Ley Foon Tan <leyfoon.tan@starfivetech.com>, 
	Deepak Gupta <debug@rivosinc.com>, Sia Jee Heng <jeeheng.sia@starfivetech.com>, 
	Song Shuai <suagrfillet@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 6:02=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Tue, 02 Apr 2024 15:02:41 +0200
> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wrote:
>
> > Puranjay Mohan <puranjay12@gmail.com> writes:
> >
> > > This commit replaces riscv's support for FTRACE_WITH_REGS with suppor=
t
> > > for FTRACE_WITH_ARGS. This is required for the ongoing effort to stop
> > > relying on stop_machine() for RISCV's implementation of ftrace.
> > >
> > > The main relevant benefit that this change will bring for the above
> > > use-case is that now we don't have separate ftrace_caller and
> > > ftrace_regs_caller trampolines.  This will allow the callsite to call
> > > ftrace_caller by modifying a single instruction. Now the callsite can
> > > do something similar to:
> > >
> > > When not tracing:            |             When tracing:
> > >
> > > func:                                      func:
> > >   auipc t0, ftrace_caller_top                auipc t0, ftrace_caller_=
top
> > >   nop  <=3D=3D=3D=3D=3D=3D=3D=3D=3D<Enable/Disable>=3D=3D=3D=3D=3D=3D=
=3D=3D=3D>  jalr  t0, ftrace_caller_bottom
> > >   [...]                                      [...]
> > >
> > > The above assumes that we are dropping the support of calling a direc=
t
> > > trampoline from the callsite. We need to drop this as the callsite ca=
n't
> > > change the target address to call, it can only enable/disable a call =
to
> > > a preset target (ftrace_caller in the above diagram).
> > >
> > > Currently, ftrace_regs_caller saves all CPU registers in the format o=
f
> > > struct pt_regs and allows the tracer to modify them. We don't need to
> > > save all of the CPU registers because at function entry only a subset=
 of
> > > pt_regs is live:
> > >
> > > |----------+----------+---------------------------------------------|
> > > | Register | ABI Name | Description                                 |
> > > |----------+----------+---------------------------------------------|
> > > | x1       | ra       | Return address for traced function          |
> > > | x2       | sp       | Stack pointer                               |
> > > | x5       | t0       | Return address for ftrace_caller trampoline |
> > > | x8       | s0/fp    | Frame pointer                               |
> > > | x10-11   | a0-1     | Function arguments/return values            |
> > > | x12-17   | a2-7     | Function arguments                          |
> > > |----------+----------+---------------------------------------------|
> > >
> > > See RISCV calling convention[1] for the above table.
> > >
> > > Saving just the live registers decreases the amount of stack space
> > > required from 288 Bytes to 112 Bytes.
> > >
> > > Basic testing was done with this on the VisionFive 2 development boar=
d.
> > >
> > > Note:
> > >   - Moving from REGS to ARGS will mean that RISCV will stop supportin=
g
> > >     KPROBES_ON_FTRACE as it requires full pt_regs to be saved.
> >
> > ...and FPROBES, but Masami is (still?) working on a series to address
> > that [1].
>
> Yes, even with this patch, FPROBE can be worked with my series.
> So I'm OK for this change.
>
> Thank you,
>
> >
> > My perspective; This is following the work Mark et al has done for
> > arm64, and it does make sense for RISC-V as well. I'm in favor having
> > this change as part of the bigger call_ops/text patch change for RISC-V=
.
> >
> > [...]
> >
> > > diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm=
/ftrace.h
> > > index 1276d7d9ca8b..1e95bf4ded6c 100644
> > > --- a/arch/riscv/include/asm/ftrace.h
> > > +++ b/arch/riscv/include/asm/ftrace.h
> > > @@ -124,20 +124,87 @@ struct dyn_ftrace;
> > >  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
> > >  #define ftrace_init_nop ftrace_init_nop
> > >
> > > -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > > +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> > > +#define arch_ftrace_get_regs(regs) NULL
> > >  struct ftrace_ops;
> > > -struct ftrace_regs;
> > > +struct ftrace_regs {
> > > +   unsigned long epc;
> > > +   unsigned long ra;
> > > +   unsigned long sp;
> > > +   unsigned long s0;
> > > +   unsigned long t1;
> > > +   union {
> > > +           unsigned long args[8];
> > > +           struct {
> > > +                   unsigned long a0;
> > > +                   unsigned long a1;
> > > +                   unsigned long a2;
> > > +                   unsigned long a3;
> > > +                   unsigned long a4;
> > > +                   unsigned long a5;
> > > +                   unsigned long a6;
> > > +                   unsigned long a7;
> > > +           };
> > > +   };
> > > +};
> > > +
> > > +static __always_inline unsigned long
> > > +ftrace_regs_get_instruction_pointer(const struct ftrace_regs *fregs)
> > > +{
> > > +   return fregs->epc;
> > > +}
> > > +
> > > +static __always_inline void
> > > +ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
> > > +                               unsigned long pc)
> > > +{
> > > +   fregs->epc =3D pc;
> > > +}
> > > +
> > > +static __always_inline unsigned long
> > > +ftrace_regs_get_stack_pointer(const struct ftrace_regs *fregs)
> > > +{
> > > +   return fregs->sp;
> > > +}
> > > +
> > > +static __always_inline unsigned long
> > > +ftrace_regs_get_argument(struct ftrace_regs *fregs, unsigned int n)
> > > +{
> > > +   if (n < 8)
> > > +           return fregs->args[n];
> > > +   return 0;
> > > +}
> > > +
> > > +static __always_inline unsigned long
> > > +ftrace_regs_get_return_value(const struct ftrace_regs *fregs)
> > > +{
> > > +   return fregs->a0;
> > > +}
> > > +
> > > +static __always_inline void
> > > +ftrace_regs_set_return_value(struct ftrace_regs *fregs,
> > > +                        unsigned long ret)
> > > +{
> > > +   fregs->a0 =3D ret;
> > > +}
> > > +
> > > +static __always_inline void
> > > +ftrace_override_function_with_return(struct ftrace_regs *fregs)
> > > +{
> > > +   fregs->epc =3D fregs->ra;
> > > +}
> >
> > Style/nit: All above; Try to use the full 100 chars, and keep the
> > function name return value on the same line for grepability.
> >
> >
> > Bj=C3=B6rn
> >
> > [1] https://lore.kernel.org/all/170887410337.564249.6360118840946697039=
stgit@devnote2/
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

I will send it without RFC and will fix the problems pointed out by Bjorn.

Thanks,
Puranjay

