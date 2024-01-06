Return-Path: <linux-kernel+bounces-18471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6159F825E1E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 04:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58F628530D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 03:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0789D15C4;
	Sat,  6 Jan 2024 03:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yTx2CUHv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E016B15B1
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ce10b5ee01so128425a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 19:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704512172; x=1705116972; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ANGkz8P20g2+Z2fA4ppTxxlIVUGqEzXNWxWsfGUlr1o=;
        b=yTx2CUHv6yVnCigMWd9NKUQ/E0FGK+iwVbRPOhjU/ipFtoUNC9bNCn+RjEbCtkGlVq
         5jJ+yBmIUT9qzLOOl5ij/ol2hkn+HFjUn89SevkhzRKgs14g4JKgXAxOOHKUqKszmLai
         FjrOlkdNs1Jvb9DVY2cKUylGGaRbvrXo9koD8UJycDP+QblFsMoglRaE+ESHFqyelLZM
         I1SXhK6lf3ikP5d1y4XFouvXh7uW7GZxvdD126r0vdqd/RkBFDEs98zeJaTdklYyBL/T
         anPS3hOxbv5JhrgHTB6Pggmo8+vHbUgNg2/go6YWb4qCy7lf3LuCeJC2gAGPgcjEa15Z
         tDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704512172; x=1705116972;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANGkz8P20g2+Z2fA4ppTxxlIVUGqEzXNWxWsfGUlr1o=;
        b=GsPtoTgrMf0skBHpMFAwMmme1DBl00OQn8dh6l1FiEKpnuOqPin4O0WN+oVg8C7xeo
         nKL7tTpMNPXvHrp+puafiQRtx5lGMHACiwMw3k8mj50ZDUKZUAH79UTXaRjMvX8y+T7R
         f1iW00nXv1JIxx3w1z1A2j/+gu4D2shpmNOtIDHDzFADZ33/yyFLvk1Om5/rYxInfiBx
         Yu/9w82zRl/D1gQCGf3Ykm69MQtw0pfricnshgN9LWQ9ktPm3aSOwOJYbTkE3cV4zMtG
         tKKIs6UGPF14wOLgxXwF2+m0UzxdnCRzmTK5cTOu3hKfKcHevV9/7AsW6Ryn/CUQ7lxx
         tUrg==
X-Gm-Message-State: AOJu0YxgZsIQdO4AsXGDIomOor0KCYk7IyOKyFgvkk8oGV9kLJTYOhqo
	tlY22UlLg9C/NzamfiFzvjDHh0wdjin5bQ==
X-Google-Smtp-Source: AGHT+IFuGBY9sCullBqglTVzbnnJq2bqd7drkzNx7RKJLpj3Rye3O6p2+f9PbiSl8ezWZ1K6kGuA6Q==
X-Received: by 2002:a05:6a20:2589:b0:199:3068:7bcb with SMTP id k9-20020a056a20258900b0019930687bcbmr3141308pzd.39.1704512172006;
        Fri, 05 Jan 2024 19:36:12 -0800 (PST)
Received: from ghost ([2601:647:5700:6860:73c:7a5f:bc03:fe77])
        by smtp.gmail.com with ESMTPSA id e34-20020a635022000000b005cd8ada89e5sm2090331pgb.70.2024.01.05.19.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 19:36:11 -0800 (PST)
Date: Fri, 5 Jan 2024 19:36:08 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Atish Patra <atishp@atishpatra.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] riscv: Include riscv_set_icache_flush_ctx prctl
Message-ID: <ZZjKqOQG750OcDG4@ghost>
References: <20231213-fencei-v3-0-b75158238eb7@rivosinc.com>
 <20231213-fencei-v3-1-b75158238eb7@rivosinc.com>
 <CAOnJCU+E_YFp_Mt7CbLrz7KHPS=8Mr_wqQy=qE263gPd6qCytg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOnJCU+E_YFp_Mt7CbLrz7KHPS=8Mr_wqQy=qE263gPd6qCytg@mail.gmail.com>

On Fri, Jan 05, 2024 at 06:55:31PM -0800, Atish Patra wrote:
> On Wed, Dec 13, 2023 at 2:48 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > Support new prctl with key PR_RISCV_SET_ICACHE_FLUSH_CTX to enable
> > optimization of cross modifying code. This prctl enables userspace code
> > to use icache flushing instructions such as fence.i with the guarantee
> > that the icache will continue to be clean after thread migration.
> >
> 
> Do we need a CLEAR option as well ? I am wondering if there is a use case where
> an application wants the prctl for only certain duration but may
> invoke fence.i multiple times (syscall will still not be a good option
> for them.)

Having a clear option does seem like a good idea. I will send out a new
patch with a context option that can be similar to
PR_RISCV_CTX_SW_FENCEI_CLEAR.

- Charlie

> 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/mmu.h       |  2 ++
> >  arch/riscv/include/asm/processor.h |  6 ++++++
> >  arch/riscv/mm/cacheflush.c         | 37 +++++++++++++++++++++++++++++++++++++
> >  arch/riscv/mm/context.c            |  8 +++++---
> >  include/uapi/linux/prctl.h         |  3 +++
> >  kernel/sys.c                       |  6 ++++++
> >  6 files changed, 59 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
> > index 355504b37f8e..60be458e94da 100644
> > --- a/arch/riscv/include/asm/mmu.h
> > +++ b/arch/riscv/include/asm/mmu.h
> > @@ -19,6 +19,8 @@ typedef struct {
> >  #ifdef CONFIG_SMP
> >         /* A local icache flush is needed before user execution can resume. */
> >         cpumask_t icache_stale_mask;
> > +       /* Force local icache flush on all migrations. */
> > +       bool force_icache_flush;
> >  #endif
> >  #ifdef CONFIG_BINFMT_ELF_FDPIC
> >         unsigned long exec_fdpic_loadmap;
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > index f19f861cda54..7eda6c75e0f2 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -84,6 +84,9 @@ struct thread_struct {
> >         unsigned long vstate_ctrl;
> >         struct __riscv_v_ext_state vstate;
> >         unsigned long align_ctl;
> > +#ifdef CONFIG_SMP
> > +       bool force_icache_flush;
> > +#endif
> >  };
> >
> >  /* Whitelist the fstate from the task_struct for hardened usercopy */
> > @@ -145,6 +148,9 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
> >  #define GET_UNALIGN_CTL(tsk, addr)     get_unalign_ctl((tsk), (addr))
> >  #define SET_UNALIGN_CTL(tsk, val)      set_unalign_ctl((tsk), (val))
> >
> > +#define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2) riscv_set_icache_flush_ctx(arg1, arg2)
> > +extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread);
> > +
> >  #endif /* __ASSEMBLY__ */
> >
> >  #endif /* _ASM_RISCV_PROCESSOR_H */
> > diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> > index 55a34f2020a8..3b2bf8256a10 100644
> > --- a/arch/riscv/mm/cacheflush.c
> > +++ b/arch/riscv/mm/cacheflush.c
> > @@ -5,6 +5,7 @@
> >
> >  #include <linux/acpi.h>
> >  #include <linux/of.h>
> > +#include <linux/prctl.h>
> >  #include <asm/acpi.h>
> >  #include <asm/cacheflush.h>
> >
> > @@ -152,3 +153,39 @@ void __init riscv_init_cbo_blocksizes(void)
> >         if (cboz_block_size)
> >                 riscv_cboz_block_size = cboz_block_size;
> >  }
> > +
> > +/**
> > + * riscv_set_icache_flush_ctx() - Enable userspace to emit icache flushing instructions.
> > + * @ctx: Sets the type of context
> > + *  - PR_RISCV_CTX_SW_FENCEI: Allow fence.i in userspace. Another fence.i will
> > + *                           emitted on thread/process migration.
> > + * @per_thread: When set to 0, will use the default behavior of setting the
> > + *  icache flush context per process. When set to 1, will use a per thread
> > + *  context.
> > + *
> > + * When in per-process context, there may be multiple threads using the same mm.
> > + * Therefore, the icache can never be assumed clean when. Multiple threads in
> > + * the process may modify instructions in the mm concurrently.
> > + *
> > + * In per-thread context, it can be assumed that all modifications to
> > + * instructions in memory will be performed by this thread. When the thread is
> > + * migrated the icache will be flushed.
> > + *
> > + */
> > +int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread)
> > +{
> > +#ifdef CONFIG_SMP
> > +       switch (ctx) {
> > +       case PR_RISCV_CTX_SW_FENCEI:
> > +               if (per_thread)
> > +                       current->thread.force_icache_flush = true;
> > +               else
> > +                       current->mm->context.force_icache_flush = true;
> > +               break;
> > +
> > +       default:
> > +               break;
> > +       }
> > +#endif
> > +       return 0;
> > +}
> > diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> > index 217fd4de6134..0146c61be0ab 100644
> > --- a/arch/riscv/mm/context.c
> > +++ b/arch/riscv/mm/context.c
> > @@ -297,12 +297,14 @@ static inline void set_mm(struct mm_struct *prev,
> >   *
> >   * The "cpu" argument must be the current local CPU number.
> >   */
> > -static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu)
> > +static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu,
> > +                                        struct task_struct *task)
> >  {
> >  #ifdef CONFIG_SMP
> >         cpumask_t *mask = &mm->context.icache_stale_mask;
> >
> > -       if (cpumask_test_cpu(cpu, mask)) {
> > +       if (cpumask_test_cpu(cpu, mask) || mm->context.force_icache_flush ||
> > +           (task && task->thread.force_icache_flush)) {
> >                 cpumask_clear_cpu(cpu, mask);
> >                 /*
> >                  * Ensure the remote hart's writes are visible to this hart.
> > @@ -332,5 +334,5 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
> >
> >         set_mm(prev, next, cpu);
> >
> > -       flush_icache_deferred(next, cpu);
> > +       flush_icache_deferred(next, cpu, task);
> >  }
> > diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> > index 370ed14b1ae0..472801ea78cc 100644
> > --- a/include/uapi/linux/prctl.h
> > +++ b/include/uapi/linux/prctl.h
> > @@ -306,4 +306,7 @@ struct prctl_mm_map {
> >  # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK      0xc
> >  # define PR_RISCV_V_VSTATE_CTRL_MASK           0x1f
> >
> > +#define PR_RISCV_SET_ICACHE_FLUSH_CTX  71
> > +# define PR_RISCV_CTX_SW_FENCEI                0
> > +
> >  #endif /* _LINUX_PRCTL_H */
> > diff --git a/kernel/sys.c b/kernel/sys.c
> > index 420d9cb9cc8e..e806a8a67c36 100644
> > --- a/kernel/sys.c
> > +++ b/kernel/sys.c
> > @@ -146,6 +146,9 @@
> >  #ifndef RISCV_V_GET_CONTROL
> >  # define RISCV_V_GET_CONTROL()         (-EINVAL)
> >  #endif
> > +#ifndef RISCV_SET_ICACHE_FLUSH_CTX
> > +# define RISCV_SET_ICACHE_FLUSH_CTX(a, b)      (-EINVAL)
> > +#endif
> >
> >  /*
> >   * this is where the system-wide overflow UID and GID are defined, for
> > @@ -2739,6 +2742,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
> >         case PR_RISCV_V_GET_CONTROL:
> >                 error = RISCV_V_GET_CONTROL();
> >                 break;
> > +       case PR_RISCV_SET_ICACHE_FLUSH_CTX:
> > +               error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
> > +               break;
> >         default:
> >                 error = -EINVAL;
> >                 break;
> >
> > --
> > 2.43.0
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> 
> 
> -- 
> Regards,
> Atish

