Return-Path: <linux-kernel+bounces-37595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7245183B24F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E1C7B240D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B704D133417;
	Wed, 24 Jan 2024 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="R40oOF3u"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B4A13340C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706124638; cv=none; b=ANDpTodkzun4smxv3bgUoIon5LuoviWxVnCGLM3E6AqEY702NDV4vQliqk5aZviW+OeyJTuFiefFcKsnCF0nNqaZh2QrE/ER/QKQuP+0+lx9QLtc6lKCIrJDtrUDgCkumr2TSeDNYRlztlW9iLvzjjXmTw50BLgXtv1UqUS6gkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706124638; c=relaxed/simple;
	bh=vWQAKoEuxGGSMwnxPPUR2gc1qc++oIpDnowGCLCfubo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEV03P7Nt+PYo91XHu/fPnpQBRFo1eAjhZcREoWiaHXafJ7ek2jORGvKKIaGq6oTHG4slGqrbvdJ/qsP463k3AwQnymt3x2n+JS/DT6QMmB0U2dcfhZPXmPK/DsMfwZpyoaXOV93Zu4ju8YEU9lCfQKNIzrR0pEu3ojJXCqERr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=R40oOF3u; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d751bc0c15so33314525ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706124636; x=1706729436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5UEbpXa+K1WhYj4WIljNhDZkQbLwF2tYZ2YIh8V0PBM=;
        b=R40oOF3uQePMQOt0fge0NcHuF1lwkUudoMVIKsHsN9u72GCensGZMftBEHy0a6ri47
         n8luN8TMlXign8G5+KFRz/KyQOXmSXVWHt9cOeehSeoq4+15i3g+fiH4TEOQ/wZoC4ny
         /mUVu9nxBvPt1HQIgI6m+WJgVOsE0ASs0lHGrxOFFcS5QrvQAMgM79NvBZDEXo9rw3Va
         ueFSu/wMG0mCnYyrqfQhR1++1C69zCQJ9EqTywvAVRrnYjdoe6luFdm4my4mN12qYWGm
         fEILFXrvadQTULRYIF1QkW+F8GJjm7Boe+Gt2QN4tklcyuMjHTQezArSe1x4Osv7ffrh
         Drfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706124636; x=1706729436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UEbpXa+K1WhYj4WIljNhDZkQbLwF2tYZ2YIh8V0PBM=;
        b=jmqz/GyKaS+zsIQjIUcgUaG8octatzw+SBx0uLYBuJKk4PlTq0IVHFJg9oAI5C4gsx
         vclNr/hj+YdH3UAWU9ZFZkZF5jMWD8GOg6mSCtexmjzEGV44uDklHP2P1xYlFO92dxTN
         Hye4zTSyDCZjtQ/csbcUAgA8Qj/JuF+urPbVJxNsDBCVgm4Xbga0o8Cp03adVZ2dTHTd
         B/+Kw3GxTYrDAjj7rtG7le1seGJQjCT2y5PBcHzftgzvUKa03okrEPpNp1y6LMaC8Xd8
         IVfBGpm0ufIs0pbCECNcyae0xMSc8h0dXvMrUXf8CKPc9Cq1OqF3h3z6dOvTrLFv/J8S
         2Oog==
X-Gm-Message-State: AOJu0YwLssCe1tWKfSfG15wYnxM9ZCmLatJnf2bGtJYZZqEjffr+NFBb
	Bd8XqWNusxsexIbrG/LmLeWSr0US2inp6wCuCCmfxxiaq7Vhkhz0rcO6WY/YNGU=
X-Google-Smtp-Source: AGHT+IGk1XnvT3RPqNVCWyaOVEaE2pSUQkhaU8okXXLrzEcWcUeoyUWyY2B6jc2c1Pb5gdSsBS+Oug==
X-Received: by 2002:a17:902:d2c4:b0:1d7:8f44:45 with SMTP id n4-20020a170902d2c400b001d78f440045mr1038299plc.0.1706124635837;
        Wed, 24 Jan 2024 11:30:35 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902e9c400b001d706e373a9sm10595766plk.292.2024.01.24.11.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 11:30:34 -0800 (PST)
Date: Wed, 24 Jan 2024 11:30:32 -0800
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
Message-ID: <ZbFlWFPFgzcxJg1z@ghost>
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

I forgot to respond to this in my last email. Is this condition
possible? switch_to is locked on both sides with prepare_task_switch and
finish_task_switch so my understanding is that the state of __prev and
__next is not racy inside of switch_to.

Nonetheless, I can move the assignment to the beginning of the macro.

- Charlie

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

