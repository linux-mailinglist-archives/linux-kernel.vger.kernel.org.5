Return-Path: <linux-kernel+bounces-22659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EA882A106
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F8E28485E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958D44E1CA;
	Wed, 10 Jan 2024 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="zrX31dRv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wPFeV1XW"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0074D5A8;
	Wed, 10 Jan 2024 19:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id E74DE5C0148;
	Wed, 10 Jan 2024 14:28:35 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 10 Jan 2024 14:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704914915; x=1705001315; bh=NfoIIOwm5D
	N8HwySWxVOPW2RCyuUbKrQT1Wiw7ASY/s=; b=zrX31dRvmNLuUjljQFx2p/nf16
	jKUsjijNpfTV8Tr87iPusUu6Rf4AyWD8QoYYKDj3DLs/GaT9DWzGrCrL7Plo+3Cg
	485Fe8Ei5keLtPh61BbJ4YbtFaBccQfESKe5EZz2BJbzeLBESpzk7wRPxCBHk1Ps
	/KvVzaTLm8ZlzO+kEfq+s+OHnC1DsTriSd7ze/ALtf2D4rasUfT1qkqmm6rqQFCP
	F+xVV+vA+VVXX8MRl07kenq5kgSQ4RqpCUvwnIBXYDvd8ZKCchGgNUJgP1AnKDd1
	jdKsIjbFsnhPW0viCKMNGRlgSpoeZ3rIDU8IBdQk3QPbuTYnteNXboB41Aeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704914915; x=1705001315; bh=NfoIIOwm5DN8HwySWxVOPW2RCyuU
	bKrQT1Wiw7ASY/s=; b=wPFeV1XW7VwQ07gqSP0wkKrg2oX1fXnA8ZcjEMX52OHl
	bW2ukaryhgH4IdlmnhViI0ghVz8/JfyVREsbklr1cJ2FVS9UL0ITxlUaomissc/j
	wnWnHbkDZtmXViln40s5NTKCMZxAubJUGZsvQ04CeuVEw2faXJ2b0LdnQluPlFNM
	zrgD+cdTF1PXZlnBGCsNZN53NNGTA/F9q7HpyO3ikTQhLO+X0xw8PDIVkgWrFmzt
	vkBx4q9//fVWKn3Ii474tQm+fOmCdnuDi2cuM+wGjvSeApFElL6lRAVWNUV5LVmq
	RbBqiU9LmGdTktDGIStZjYvsnZeCTm6YP7KgLAgcjA==
X-ME-Sender: <xms:4--eZfXD-KiuPP5MsTrt3u8UFkNBGnRXq17P-BWcoVwQeQn1Wawh8g>
    <xme:4--eZXmpy9XwxiWcC7cocnC8kfijvDcPQ8530FWdNdkL1IsVEwHdtLoOAVoeciZ3V
    6cW9gEjIMqXA-1oFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiuddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfu
    thgvfhgrnhcuqfdktfgvrghrfdcuoehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhmqe
    enucggtffrrghtthgvrhhnpeefudejvdejuddvjeejudekgfeikeevveevleeitddvtedu
    jeegjeejgfeugfeiudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:4--eZbY25iKZ1M5QHgAqmoplCAsGHpIbaUJVPruU1T-BMDw_6rsqCw>
    <xmx:4--eZaU72Dm_HpH5TJ5GUkQFGKGgz7bC4IM3n79KY8ojJGTPUzPnPg>
    <xmx:4--eZZlnBzWvfxue6eOASH3EtgTPAu0ENcug-h_R-181AsBBIPvEjg>
    <xmx:4--eZc-yBs-6T3quhWUCn5eKcOeodzsryJd-D_aJeTFZVQmL_ao5kQ>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 259251700096; Wed, 10 Jan 2024 14:28:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <add243df-47ea-4956-99c5-7bcf19dd2679@app.fastmail.com>
In-Reply-To: <20240110145533.60234-5-parri.andrea@gmail.com>
References: <20240110145533.60234-1-parri.andrea@gmail.com>
 <20240110145533.60234-5-parri.andrea@gmail.com>
Date: Wed, 10 Jan 2024 14:27:51 -0500
From: "Stefan O'Rear" <sorear@fastmail.com>
To: "Andrea Parri" <parri.andrea@gmail.com>, paul.walmsley@sifive.com,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 mathieu.desnoyers@efficios.com, paulmck@kernel.org,
 "Jonathan Corbet" <corbet@lwn.net>
Cc: mmaas@google.com, "Hans Boehm" <hboehm@google.com>, striker@us.ibm.com,
 charlie@rivosinc.com, rehn@rivosinc.com, linux-riscv@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] membarrier: riscv: Provide core serializing command
Content-Type: text/plain

On Wed, Jan 10, 2024, at 9:55 AM, Andrea Parri wrote:
> RISC-V uses xRET instructions on return from interrupt and to go back
> to user-space; the xRET instruction is not core serializing.
>
> Use FENCE.I for providing core serialization as follows:
>
>  - by calling sync_core_before_usermode() on return from interrupt (cf.
>    ipi_sync_core()),
>
>  - via switch_mm() and sync_core_before_usermode() (respectively, for
>    uthread->uthread and kthread->uthread transitions) to go back to
>    user-space.
>
> On RISC-V, the serialization in switch_mm() is activated by resetting
> the icache_stale_mask of the mm at prepare_sync_core_cmd().
>
> Suggested-by: Palmer Dabbelt <palmer@dabbelt.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  .../membarrier-sync-core/arch-support.txt     | 18 +++++++++++-
>  MAINTAINERS                                   |  1 +
>  arch/riscv/Kconfig                            |  3 ++
>  arch/riscv/include/asm/membarrier.h           | 19 ++++++++++++
>  arch/riscv/include/asm/sync_core.h            | 29 +++++++++++++++++++
>  kernel/sched/core.c                           |  4 +++
>  kernel/sched/membarrier.c                     |  4 +++
>  7 files changed, 77 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/sync_core.h
>
> diff --git 
> a/Documentation/features/sched/membarrier-sync-core/arch-support.txt 
> b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> index d96b778b87ed8..a163170fc0f48 100644
> --- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> +++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> @@ -10,6 +10,22 @@
>  # Rely on implicit context synchronization as a result of exception 
> return
>  # when returning from IPI handler, and when returning to user-space.
>  #
> +# * riscv
> +#
> +# riscv uses xRET as return from interrupt and to return to user-space.
> +#
> +# Given that xRET is not core serializing, we rely on FENCE.I for 
> providing
> +# core serialization:

"core serialization" is a meaningless sequence of words for RISC-V users,
and an extremely strange way to describe running fence.i on all remote
cores.  fence.i is a _fence_; it is not required to affect a core pipeline
beyond what is needed to ensure that all instruction fetches after the
barrier completes see writes performed before the barrier.

The feature seems useful, but it should document what it does using
terminology actually used in the RISC-V specifications.

> +#
> +#  - by calling sync_core_before_usermode() on return from interrupt 
> (cf.
> +#    ipi_sync_core()),
> +#
> +#  - via switch_mm() and sync_core_before_usermode() (respectively, for
> +#    uthread->uthread and kthread->uthread transitions) to go back to
> +#    user-space.
> +#
> +#  The serialization in switch_mm() is activated by 
> prepare_sync_core_cmd().
> +#
>  # * x86
>  #
>  # x86-32 uses IRET as return from interrupt, which takes care of the 
> IPI.
> @@ -43,7 +59,7 @@
>      |    openrisc: | TODO |
>      |      parisc: | TODO |
>      |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |
>      |        s390: |  ok  |
>      |          sh: | TODO |
>      |       sparc: | TODO |
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6bce0aeecb4f2..e4ca6288ea3d1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13817,6 +13817,7 @@ L:	linux-kernel@vger.kernel.org
>  S:	Supported
>  F:	Documentation/scheduler/membarrier.rst
>  F:	arch/*/include/asm/membarrier.h
> +F:	arch/*/include/asm/sync_core.h
>  F:	include/uapi/linux/membarrier.h
>  F:	kernel/sched/membarrier.c
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 33d9ea5fa392f..2ad63a216d69a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -28,14 +28,17 @@ config RISCV
>  	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_HAS_KCOV
>  	select ARCH_HAS_MEMBARRIER_CALLBACKS
> +	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>  	select ARCH_HAS_MMIOWB
>  	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  	select ARCH_HAS_PMEM_API
> +	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_SET_DIRECT_MAP if MMU
>  	select ARCH_HAS_SET_MEMORY if MMU
>  	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
>  	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
> +	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
>  	select ARCH_HAS_SYSCALL_WRAPPER
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
> diff --git a/arch/riscv/include/asm/membarrier.h 
> b/arch/riscv/include/asm/membarrier.h
> index 6c016ebb5020a..47b240d0d596a 100644
> --- a/arch/riscv/include/asm/membarrier.h
> +++ b/arch/riscv/include/asm/membarrier.h
> @@ -22,6 +22,25 @@ static inline void membarrier_arch_switch_mm(struct 
> mm_struct *prev,
>  	/*
>  	 * The membarrier system call requires a full memory barrier
>  	 * after storing to rq->curr, before going back to user-space.
> +	 *
> +	 * This barrier is also needed for the SYNC_CORE command when
> +	 * switching between processes; in particular, on a transition
> +	 * from a thread belonging to another mm to a thread belonging
> +	 * to the mm for which a membarrier SYNC_CORE is done on CPU0:
> +	 *
> +	 *   - [CPU0] sets all bits in the mm icache_stale_mask (in
> +	 *     prepare_sync_core_cmd());
> +	 *
> +	 *   - [CPU1] stores to rq->curr (by the scheduler);
> +	 *
> +	 *   - [CPU0] loads rq->curr within membarrier and observes
> +	 *     cpu_rq(1)->curr->mm != mm, so the IPI is skipped on
> +	 *     CPU1; this means membarrier relies on switch_mm() to
> +	 *     issue the sync-core;
> +	 *
> +	 *   - [CPU1] switch_mm() loads icache_stale_mask; if the bit
> +	 *     is zero, switch_mm() may incorrectly skip the sync-core.
> +	 *
>  	 * Matches a full barrier in the proximity of the membarrier
>  	 * system call entry.
>  	 */
> diff --git a/arch/riscv/include/asm/sync_core.h 
> b/arch/riscv/include/asm/sync_core.h
> new file mode 100644
> index 0000000000000..9153016da8f14
> --- /dev/null
> +++ b/arch/riscv/include/asm/sync_core.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RISCV_SYNC_CORE_H
> +#define _ASM_RISCV_SYNC_CORE_H
> +
> +/*
> + * RISC-V implements return to user-space through an xRET instruction,
> + * which is not core serializing.
> + */
> +static inline void sync_core_before_usermode(void)
> +{
> +	asm volatile ("fence.i" ::: "memory");
> +}

Not standard terminology.

> +
> +#ifdef CONFIG_SMP
> +/*
> + * Ensure the next switch_mm() on every CPU issues a core serializing
> + * instruction for the given @mm.
> + */
> +static inline void prepare_sync_core_cmd(struct mm_struct *mm)
> +{
> +	cpumask_setall(&mm->context.icache_stale_mask);
> +}
> +#else
> +static inline void prepare_sync_core_cmd(struct mm_struct *mm)
> +{
> +}
> +#endif /* CONFIG_SMP */
> +
> +#endif /* _ASM_RISCV_SYNC_CORE_H */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b51bc86f8340c..82de2b7d253cd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6682,6 +6682,10 @@ static void __sched notrace __schedule(unsigned 
> int sched_mode)
>  		 *
>  		 * The barrier matches a full barrier in the proximity of
>  		 * the membarrier system call entry.
> +		 *
> +		 * On RISC-V, this barrier pairing is also needed for the
> +		 * SYNC_CORE command when switching between processes, cf.
> +		 * the inline comments in membarrier_arch_switch_mm().
>  		 */
>  		++*switch_count;
> 
> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index 6d1f31b3a967b..703e8d80a576d 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -342,6 +342,10 @@ static int membarrier_private_expedited(int flags, 
> int cpu_id)
>  	/*
>  	 * Matches memory barriers after rq->curr modification in
>  	 * scheduler.
> +	 *
> +	 * On RISC-V, this barrier pairing is also needed for the
> +	 * SYNC_CORE command when switching between processes, cf.
> +	 * the inline comments in membarrier_arch_switch_mm().
>  	 */
>  	smp_mb();	/* system call entry is not a mb. */
> 
> -- 
> 2.34.1

-s

