Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A271B7F55C0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 02:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjKWBHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 20:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjKWBHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 20:07:17 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A891B2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:07:22 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b587bd1a63so659604b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700701641; x=1701306441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dhI6Kj7SOax34YHTzSZB20BhWZZOv5y6Dq/HW0ZZ0cE=;
        b=byt9e5k+FEOWMz8rBK5EWxIXT55meJ6SflAQ3ltm0MdrCeaRUOzy88qHUKAyMyQ0Uk
         x8bMHY0Bs60CqPaUwi053o/Dj0dNBbKlh5O7GYdnLqB3Fj9uajv713EBd1vwC6PDn5RO
         or+Rfk0xNGRyyhKOIiQzqW+7F+McH5SxlJpW8j0TtYAgt6whYjvaCO0nRzVixmHTIYpP
         IFoHllVqHY9Ga9DGNbf4dvH8S4dgiEKqFOCsfq0iCKD493JAbkr5nqXXFK9oFpZk/1kM
         1NdJntEBzJ90LNMxkN9bjPS1RNmlloSLzebupnn+n3p6X8AyYuX2RrOoxKPBz46/hzBQ
         Ri6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700701641; x=1701306441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhI6Kj7SOax34YHTzSZB20BhWZZOv5y6Dq/HW0ZZ0cE=;
        b=XiPpHG3hRTXwxzTt2+Fe/6F4xPBUr5KtUHbWtOucxvKUggMhl0Fsj9RhTWMMNvxTJ5
         hxkiqZ7Q2TYeI33/srMvsd4GFXfUM1yRTfZmxJZxXtRe+LGl37BtoFomx0wfTty44yiD
         MURqi6z6MkSZWteNNDhr8angqsx8nrXb+lkJ5RtFQJRUX4QDGfX6BftQSVCOJ4q5O/gZ
         b2A6Rsa5b6LkKLgEY6XGscWUduZETNCmJdS31UbLTemdNsaAsxTdXsKoeAc459Ig00iS
         6oreQAwEHdxtv6Uhi4ePY+bfpvspmzRGmN0mQ1v2mUBiLjZ8vTCkiVz+VBsF0rhb7P0y
         +iKQ==
X-Gm-Message-State: AOJu0Yz3P/v7s3j/zihm/FHrdhBoDJ1uWcosyaXasOEdKmz0y5xmOe3G
        dGh4dPvx4ytrzQSRTiG3GSULwA==
X-Google-Smtp-Source: AGHT+IGtf5Axj1D2CvTbndBHVJQCV0DJBvlAfN1QZAlbbbFDC4Q+5Vxo325iBr8SInwl65y/GBOOYw==
X-Received: by 2002:a05:6808:14d1:b0:3b2:f500:6ee0 with SMTP id f17-20020a05680814d100b003b2f5006ee0mr550134oiw.28.1700701641228;
        Wed, 22 Nov 2023 17:07:21 -0800 (PST)
Received: from ghost (cpe-70-95-50-247.san.res.rr.com. [70.95.50.247])
        by smtp.gmail.com with ESMTPSA id pt9-20020a0568709e4900b001f4d34ae2ecsm70243oab.23.2023.11.22.17.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 17:07:20 -0800 (PST)
Date:   Wed, 22 Nov 2023 17:07:18 -0800
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, rehn@rivosinc.com,
        paulmck@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com
Subject: Re: [RFC PATCH] membarrier: riscv: Provide core serializing command
Message-ID: <ZV6lxsRmuN7bYFnD@ghost>
References: <mhng-b720eb90-633f-498b-a487-0cfdc9f00ddd@palmer-ri-x1c9>
 <65e98129-0617-49ca-9802-8e3a46d58d29@efficios.com>
 <ZU0sliwUQJyNAH1y@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU0sliwUQJyNAH1y@andrea>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 08:24:58PM +0100, Andrea Parri wrote:
> Mathieu, all,
> 
> Sorry for the delay,
> 
> > AFAIR this patch implements sync_core_before_usermode which gets used by
> > membarrier_mm_sync_core_before_usermode() to handle the uthread->kthread->uthread
> > case. It relies on switch_mm issuing a core serializing instruction as well.
> > 
> > Looking at RISC-V switch_mm(), I see that switch_mm() calls:
> > 
> >   flush_icache_deferred(next, cpu);
> > 
> > which only issues a fence.i if a deferred icache flush was required. We're
> > missing the part that sets the icache_stale_mask cpumask bits when a
> > MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE is invoked.
> 
> [...]
> 
> > The only part where I think you may want to keep some level of deferred
> > icache flushing as you do now is as follows:
> > 
> > - when membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE is invoked,
> >   call a new architecture hook which sets cpumask bits in the mm context
> >   that tells the next switch_mm on each cpu to issue fence.i for that mm.
> > - keep something like flush_icache_deferred as you have now.
> > 
> > Otherwise, I fear the overhead of a very expensive fence.i would be too
> > much when processes registering with MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE
> > and start doing fence.i on each and every switch_mm().
> > 
> > So you'd basically rely on membarrier to only issue IPIs to the CPUs which are
> > currently running threads belonging to the mm, and handle the switch_mm with
> > the sync_core_before_usermode() for uthread->kthread->uthread case, and implement
> > a deferred icache flush for the typical switch_mm() case.
> 
> I've (tried to) put this together and obtained the two patches reported below.
> Please let me know if this aligns with your intentions and/or there's interest
> in a proper submission.
> 
>   Andrea
> 
> 
> From e7d07a6c04b2565fceedcd71c2175e7df7e11d96 Mon Sep 17 00:00:00 2001
> From: Andrea Parri <parri.andrea@gmail.com>
> Date: Thu, 9 Nov 2023 11:03:00 +0100
> Subject: [PATCH 1/2] locking: Introduce prepare_sync_core_cmd()
> 
> Introduce an architecture function that architectures can use to set
> up ("prepare") SYNC_CORE commands.
> 
> The function will be used by RISC-V to update its "deferred icache-
> flush" data structures (icache_stale_mask).
> 
> Architectures defining prepare_sync_core_cmd() static inline need to
> select ARCH_HAS_PREPARE_SYNC_CORE_CMD.
> 
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  include/linux/sync_core.h | 16 +++++++++++++++-
>  init/Kconfig              |  3 +++
>  kernel/sched/membarrier.c |  1 +
>  3 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sync_core.h b/include/linux/sync_core.h
> index 013da4b8b3272..67bb9794b8758 100644
> --- a/include/linux/sync_core.h
> +++ b/include/linux/sync_core.h
> @@ -17,5 +17,19 @@ static inline void sync_core_before_usermode(void)
>  }
>  #endif
>  
> -#endif /* _LINUX_SYNC_CORE_H */
> +#ifdef CONFIG_ARCH_HAS_PREPARE_SYNC_CORE_CMD
> +#include <asm/sync_core.h>
> +#else
> +/*
> + * This is a dummy prepare_sync_core_cmd() implementation that can be used on
> + * all architectures which provide unconditional core serializing instructions
> + * in switch_mm().
> + * If your architecture doesn't provide such core serializing instructions in
> + * switch_mm(), you may need to write your own functions.
> + */
> +static inline void prepare_sync_core_cmd(struct mm_struct *mm)
> +{
> +}
> +#endif
>  
> +#endif /* _LINUX_SYNC_CORE_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index 6d35728b94b2b..61f5f982ca451 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1972,6 +1972,9 @@ source "kernel/Kconfig.locks"
>  config ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  	bool
>  
> +config ARCH_HAS_PREPARE_SYNC_CORE_CMD
> +	bool
> +
>  config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
>  	bool
>  
> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index 2ad881d07752c..58f801e013988 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -320,6 +320,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
>  		      MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY))
>  			return -EPERM;
>  		ipi_func = ipi_sync_core;
> +		prepare_sync_core_cmd(mm);
>  	} else if (flags == MEMBARRIER_FLAG_RSEQ) {
>  		if (!IS_ENABLED(CONFIG_RSEQ))
>  			return -EINVAL;
> -- 
> 2.34.1
> 
> 
> From 617896a1d58a5f8b0e5895dbc928a54e0461d959 Mon Sep 17 00:00:00 2001
> From: Andrea Parri <parri.andrea@gmail.com>
> Date: Tue, 7 Nov 2023 21:08:06 +0100
> Subject: [PATCH 2/2] membarrier: riscv: Provide core serializing command
> 
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
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Suggested-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  .../membarrier-sync-core/arch-support.txt     |  2 +-
>  arch/riscv/Kconfig                            |  3 +++
>  arch/riscv/include/asm/sync_core.h            | 23 +++++++++++++++++++
>  3 files changed, 27 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/sync_core.h
> 
> diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> index 23260ca449468..a17117d76e6d8 100644
> --- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> +++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> @@ -44,7 +44,7 @@
>      |    openrisc: | TODO |
>      |      parisc: | TODO |
>      |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |
>      |        s390: |  ok  |
>      |          sh: | TODO |
>      |       sparc: | TODO |
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 9c48fecc67191..b70a0b9ea3ee7 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -27,14 +27,17 @@ config RISCV
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_HAS_KCOV
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
> diff --git a/arch/riscv/include/asm/sync_core.h b/arch/riscv/include/asm/sync_core.h
> new file mode 100644
> index 0000000000000..8be5e07d641ab
> --- /dev/null
> +++ b/arch/riscv/include/asm/sync_core.h
> @@ -0,0 +1,23 @@
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
> +
> +/*
> + * Ensure the next switch_mm() on every CPU issues a core serializing
> + * instruction for the given @mm.
> + */
> +static inline void prepare_sync_core_cmd(struct mm_struct *mm)
> +{
> +	cpumask_setall(&mm->context.icache_stale_mask);
> +}
> +
> +#endif /* _ASM_RISCV_SYNC_CORE_H */
> -- 
> 2.34.1
> 

This looks good to me, can you send out a non-RFC? I just sent out
patches to support userspace fence.i:
https://lore.kernel.org/linux-riscv/20231122-fencei-v1-0-bec0811cb212@rivosinc.com/T/#t.

- Charlie

