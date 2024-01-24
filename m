Return-Path: <linux-kernel+bounces-37563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B924583B1A8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DB41F276B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4B7131E41;
	Wed, 24 Jan 2024 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oh54U4Ae"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120F413174F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122806; cv=none; b=MiLti1ymZxN/e5IDDEPt53DW/Tt0X5byLS6GOXBinYQw51fUflVM5cjwULHxJQUwZE8kiP0m1vpoAEco+KEizeo1i70NlUITO7pYHj+J3rnqtrjbNZCPUMJo8lh9PNHcF+EYWeI914sljjZbpWHz+jaDY9cavaK4etkuonR2cpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122806; c=relaxed/simple;
	bh=E56rNL4fDgqEE4OVmSaBC6LAzORtey7KLGboOtohTtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7qpgXMK9Zl4dlxC04mW079bLaYwBHwS/e2z9Mx+IaZb+HEZakle4Nwv3Gj1gkBsM0EaSfgiyB72wDTT83HLyi4PsvSAV9mczUoHob5sSFFjAs/sXruTK2y1My2sNkL+3z6hQn5XF/1Nepp+7z+1CNee1KTCvqSNxsuMjxX6a9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oh54U4Ae; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2909a632e40so2270622a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706122804; x=1706727604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WWKGvWOdaFDDeu6rBekd7VhbEJip7cO1DihHBm0wDFo=;
        b=oh54U4AeWQn3p/9Or9IpvKm0AG7Snk5hG1o4ErCVetomFlEurHqSzay7Ut3G9SkCou
         S+xoIwxOGypkQ4Odrk8Kkhy3Z5Sv7SIrg6lU0w9WeqwQ80hX0/iBbWFDTxLuIxVwUVcr
         pBlM7KXD8Oz5PWm4EHAKaqYyvjwh15C99BKjpfB/SBXm0yZq/9J5kBxmdJtF8cQ7wmEw
         RTniMEVwv+/5PWtIyGbuSdJdd/VuuDTpW94WtXJhshM+z+/IB1mcc2DTJ04BqUzwO4Kv
         N1ZmEBOc6HEJZzHOxTATuxJvegt1e0mAbyP8S4igFDhRv9o6G1o5geU8Ed8qNosogVrd
         Aemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706122804; x=1706727604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWKGvWOdaFDDeu6rBekd7VhbEJip7cO1DihHBm0wDFo=;
        b=VvIIkQwfjFjH8PBgsPB9i+a5hVk0UcTEO85z/AVFR5wdDt8hgD2QzWIQ6zEN+08Rsi
         iKCxI1wAcyXt7wDURgfUbNS6O33FCl90aN1ovcuN4gXjpjuy8eTMKYLbXZXdO/nd5Q3o
         BZBcy8IDduydvOPiIHESYJ+8ditgZEtiAEnaejcDwZTC3YdBOORne/gZRszeLIjdS5IG
         i9CilF75FY+erFsZYGO+h30R4woJtqQwl7Y0Wo8NQ1wMw36CKq+963xg5V6GW/fjhqDw
         BgmHZDW9PIRdoZ9TDabWNVgTPPk5lsLf5HvMyhFR3ZV/xKlL9zoJPCuis/JTkRZ86FlZ
         ht+Q==
X-Gm-Message-State: AOJu0YyjXTpRH4wXm/no32xCMDo/wWlW3uwWrPh602QvVygbfwnrTbg3
	z4T0SE76xGrlcJxnnSI2QtQ6Vm1T75J8kXzeWI0wERyupi6LG9K1v1gdBodLQNc=
X-Google-Smtp-Source: AGHT+IHVhDitRvLhUw8tw9CaJQmF6O+yrcAm+SFfQz+y9w+NG94k6pQb2YkSol4e9t74SpY6zCe2nw==
X-Received: by 2002:a17:90a:178f:b0:28b:de50:b4a7 with SMTP id q15-20020a17090a178f00b0028bde50b4a7mr3912541pja.76.1706122804206;
        Wed, 24 Jan 2024 11:00:04 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id x4-20020a17090ab00400b00290ea280b12sm2208929pjq.50.2024.01.24.11.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 11:00:03 -0800 (PST)
Date: Wed, 24 Jan 2024 11:00:01 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v9 1/2] riscv: Include riscv_set_icache_flush_ctx prctl
Message-ID: <ZbFeMVCEgLhgDc7j@ghost>
References: <20240123-fencei-v9-0-71411bfe8d71@rivosinc.com>
 <20240123-fencei-v9-1-71411bfe8d71@rivosinc.com>
 <7b15e9c0-58f5-4bc3-899e-671ce2c31548@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b15e9c0-58f5-4bc3-899e-671ce2c31548@ghiti.fr>

On Wed, Jan 24, 2024 at 08:12:57AM +0100, Alexandre Ghiti wrote:
> Hi Charlie,
> 
> On 24/01/2024 00:29, Charlie Jenkins wrote:
> > Support new prctl with key PR_RISCV_SET_ICACHE_FLUSH_CTX to enable
> > optimization of cross modifying code. This prctl enables userspace code
> > to use icache flushing instructions such as fence.i with the guarantee
> > that the icache will continue to be clean after thread migration.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > Reviewed-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >   arch/riscv/include/asm/mmu.h       |  2 ++
> >   arch/riscv/include/asm/processor.h |  7 ++++
> >   arch/riscv/include/asm/switch_to.h | 13 ++++++++
> >   arch/riscv/mm/cacheflush.c         | 67 ++++++++++++++++++++++++++++++++++++++
> >   arch/riscv/mm/context.c            | 14 ++++++--
> >   include/uapi/linux/prctl.h         |  6 ++++
> >   kernel/sys.c                       |  6 ++++
> >   7 files changed, 112 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
> > index 355504b37f8e..60be458e94da 100644
> > --- a/arch/riscv/include/asm/mmu.h
> > +++ b/arch/riscv/include/asm/mmu.h
> > @@ -19,6 +19,8 @@ typedef struct {
> >   #ifdef CONFIG_SMP
> >   	/* A local icache flush is needed before user execution can resume. */
> >   	cpumask_t icache_stale_mask;
> > +	/* Force local icache flush on all migrations. */
> > +	bool force_icache_flush;
> >   #endif
> >   #ifdef CONFIG_BINFMT_ELF_FDPIC
> >   	unsigned long exec_fdpic_loadmap;
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > index f19f861cda54..1cad05f579ad 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -84,6 +84,10 @@ struct thread_struct {
> >   	unsigned long vstate_ctrl;
> >   	struct __riscv_v_ext_state vstate;
> >   	unsigned long align_ctl;
> > +#ifdef CONFIG_SMP
> > +	bool force_icache_flush;
> > +	unsigned int prev_cpu;
> > +#endif
> >   };
> >   /* Whitelist the fstate from the task_struct for hardened usercopy */
> > @@ -145,6 +149,9 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
> >   #define GET_UNALIGN_CTL(tsk, addr)	get_unalign_ctl((tsk), (addr))
> >   #define SET_UNALIGN_CTL(tsk, val)	set_unalign_ctl((tsk), (val))
> > +#define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2)	riscv_set_icache_flush_ctx(arg1, arg2)
> > +extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread);
> > +
> >   #endif /* __ASSEMBLY__ */
> >   #endif /* _ASM_RISCV_PROCESSOR_H */
> > diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> > index f90d8e42f3c7..72c032d4277e 100644
> > --- a/arch/riscv/include/asm/switch_to.h
> > +++ b/arch/riscv/include/asm/switch_to.h
> > @@ -8,6 +8,7 @@
> >   #include <linux/jump_label.h>
> >   #include <linux/sched/task_stack.h>
> > +#include <linux/mm_types.h>
> >   #include <asm/vector.h>
> >   #include <asm/cpufeature.h>
> >   #include <asm/processor.h>
> > @@ -73,6 +74,15 @@ static __always_inline bool has_fpu(void) { return false; }
> >   extern struct task_struct *__switch_to(struct task_struct *,
> >   				       struct task_struct *);
> > +static inline bool switch_to_should_flush_icache(struct task_struct *task)
> > +{
> > +	bool stale_mm = task->mm && (task->mm->context.force_icache_flush);
> > +	bool stale_thread = task->thread.force_icache_flush &&
> > +			    (smp_processor_id() != task->thread.prev_cpu);
> > +
> > +	return stale_mm || stale_thread;
> 
> 
> Here stale_mm will flush the icache even if there isn't any migration, you
> should check if there is a migration and then check if either the process or
> the thread is setup to flush the icache. So the condition should be:
> 
> return ((smp_processor_id() != task->thread.prev_cpu) && ((task->mm &&
> (task->mm->context.force_icache_flush)) || task->thread.force_icache_flush);

Aha! That is what I have been missing, thank you for helping me solve
this.

- Charlie

> 
> 
> > +}
> > +
> >   #define switch_to(prev, next, last)			\
> >   do {							\
> >   	struct task_struct *__prev = (prev);		\
> > @@ -81,7 +91,10 @@ do {							\
> >   		__switch_to_fpu(__prev, __next);	\
> >   	if (has_vector())					\
> >   		__switch_to_vector(__prev, __next);	\
> > +	if (switch_to_should_flush_icache(__next))	\
> > +		local_flush_icache_all();		\
> >   	((last) = __switch_to(__prev, __next));		\
> > +	__next->thread.prev_cpu = smp_processor_id();	\
> 
> 
> Hmm shouldn't you save prev_cpu *before* __switch_to()? Because here, you
> save prev_cpu only after __prev is actually rescheduled right? And then
> __next may have been rescheduled already or __prev may be rescheduled on
> another cpu.
> 
> 
> >   } while (0)
> >   #endif /* _ASM_RISCV_SWITCH_TO_H */
> > diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> > index 55a34f2020a8..ff545f19f07a 100644
> > --- a/arch/riscv/mm/cacheflush.c
> > +++ b/arch/riscv/mm/cacheflush.c
> > @@ -5,6 +5,7 @@
> >   #include <linux/acpi.h>
> >   #include <linux/of.h>
> > +#include <linux/prctl.h>
> >   #include <asm/acpi.h>
> >   #include <asm/cacheflush.h>
> > @@ -152,3 +153,69 @@ void __init riscv_init_cbo_blocksizes(void)
> >   	if (cboz_block_size)
> >   		riscv_cboz_block_size = cboz_block_size;
> >   }
> > +
> > +/**
> > + * riscv_set_icache_flush_ctx() - Enable/disable icache flushing instructions in
> > + * userspace.
> > + * @ctx: Set the type of icache flushing instructions permitted/prohibited in
> > + *	 userspace. Supported values described below.
> > + *
> > + * Supported values for ctx:
> > + *
> > + * * %PR_RISCV_CTX_SW_FENCEI_ON: Allow fence.i in userspace.
> > + *
> > + * * %PR_RISCV_CTX_SW_FENCEI_OFF: Disallow fence.i in userspace. When ``scope ==
> > + *   PR_RISCV_SCOPE_PER_PROCESS``, this will effect all threads in a process.
> > + *   Therefore, caution must be taken -- only use this flag when you can
> > + *   guarantee that no thread in the process will emit fence.i from this point
> > + *   onward.
> > + *
> > + * @scope: Set scope of where icache flushing instructions are allowed to be
> > + *	   emitted. Supported values described below.
> > + *
> > + * Supported values for scope:
> > + *
> > + * * PR_RISCV_SCOPE_PER_PROCESS: Ensure the icache of any thread in this process
> > + *                               is coherent with instruction storage upon
> > + *                               migration.
> > + *
> > + * * PR_RISCV_SCOPE_PER_THREAD: Ensure the icache of the current thread is
> > + *                              coherent with instruction storage upon
> > + *                              migration.
> > + *
> > + * When ``scope == PR_RISCV_SCOPE_PER_PROCESS``, all threads in the process are
> > + * permitted to emit icache flushing instructions. Whenever any thread in the
> > + * process is migrated, the corresponding hart's icache will be guaranteed to be
> > + * consistent with instruction storage. Note this does not enforce any
> > + * guarantees outside of migration. If a thread modifies an instruction that
> > + * another thread may attempt to execute, the other thread must still emit an
> > + * icache flushing instruction before attempting to execute the potentially
> > + * modified instruction. This must be performed by the userspace program.
> > + *
> > + * In per-thread context (eg. ``scope == PR_RISCV_SCOPE_PER_THREAD``), only the
> > + * thread calling this function is permitted to emit icache flushing
> > + * instructions. When the thread is migrated, the corresponding hart's icache
> > + * will be guaranteed to be consistent with instruction storage.
> > + *
> > + * On kernels configured without SMP, this function is a nop as migrations
> > + * across harts will not occur.
> > + */
> > +int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long scope)
> > +{
> > +#ifdef CONFIG_SMP
> > +	switch (ctx) {
> > +	case PR_RISCV_CTX_SW_FENCEI_ON:
> > +		switch (scope) {
> > +		case PR_RISCV_SCOPE_PER_PROCESS:
> > +			current->mm->context.force_icache_flush = true;
> > +			break;
> > +		case PR_RISCV_SCOPE_PER_THREAD:
> > +			current->thread.force_icache_flush = true;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	}
> > +#endif
> > +	return 0;
> > +}
> > diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> > index 217fd4de6134..b059dc0fae91 100644
> > --- a/arch/riscv/mm/context.c
> > +++ b/arch/riscv/mm/context.c
> > @@ -15,6 +15,7 @@
> >   #include <asm/tlbflush.h>
> >   #include <asm/cacheflush.h>
> >   #include <asm/mmu_context.h>
> > +#include <asm/switch_to.h>
> >   #ifdef CONFIG_MMU
> > @@ -297,19 +298,26 @@ static inline void set_mm(struct mm_struct *prev,
> >    *
> >    * The "cpu" argument must be the current local CPU number.
> >    */
> > -static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu)
> > +static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu,
> > +					 struct task_struct *task)
> >   {
> >   #ifdef CONFIG_SMP
> >   	cpumask_t *mask = &mm->context.icache_stale_mask;
> >   	if (cpumask_test_cpu(cpu, mask)) {
> >   		cpumask_clear_cpu(cpu, mask);
> > +
> 
> 
> ^ newline here
> 
> 
> >   		/*
> >   		 * Ensure the remote hart's writes are visible to this hart.
> >   		 * This pairs with a barrier in flush_icache_mm.
> >   		 */
> >   		smp_mb();
> > -		local_flush_icache_all();
> > +
> > +		/*
> > +		 * If cache will be flushed in switch_to, no need to flush here.
> > +		 */
> > +		if (!(task && switch_to_should_flush_icache(task)))
> > +			local_flush_icache_all();
> >   	}
> >   #endif
> > @@ -332,5 +340,5 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
> >   	set_mm(prev, next, cpu);
> > -	flush_icache_deferred(next, cpu);
> > +	flush_icache_deferred(next, cpu, task);
> >   }
> > diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> > index 370ed14b1ae0..524d546d697b 100644
> > --- a/include/uapi/linux/prctl.h
> > +++ b/include/uapi/linux/prctl.h
> > @@ -306,4 +306,10 @@ struct prctl_mm_map {
> >   # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xc
> >   # define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
> > +#define PR_RISCV_SET_ICACHE_FLUSH_CTX	71
> > +# define PR_RISCV_CTX_SW_FENCEI_ON	0
> > +# define PR_RISCV_CTX_SW_FENCEI_OFF	1
> > +# define PR_RISCV_SCOPE_PER_PROCESS	0
> > +# define PR_RISCV_SCOPE_PER_THREAD	1
> > +
> >   #endif /* _LINUX_PRCTL_H */
> > diff --git a/kernel/sys.c b/kernel/sys.c
> > index 420d9cb9cc8e..e806a8a67c36 100644
> > --- a/kernel/sys.c
> > +++ b/kernel/sys.c
> > @@ -146,6 +146,9 @@
> >   #ifndef RISCV_V_GET_CONTROL
> >   # define RISCV_V_GET_CONTROL()		(-EINVAL)
> >   #endif
> > +#ifndef RISCV_SET_ICACHE_FLUSH_CTX
> > +# define RISCV_SET_ICACHE_FLUSH_CTX(a, b)	(-EINVAL)
> > +#endif
> >   /*
> >    * this is where the system-wide overflow UID and GID are defined, for
> > @@ -2739,6 +2742,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
> >   	case PR_RISCV_V_GET_CONTROL:
> >   		error = RISCV_V_GET_CONTROL();
> >   		break;
> > +	case PR_RISCV_SET_ICACHE_FLUSH_CTX:
> > +		error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
> > +		break;
> >   	default:
> >   		error = -EINVAL;
> >   		break;
> > 
> 
> Thanks,
> 
> Alex
> 

