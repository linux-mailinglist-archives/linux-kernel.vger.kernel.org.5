Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2415F80C411
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbjLKJMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbjLKJMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:12:47 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A595910E0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:12:46 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c1e8458b9so7058265e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702285964; x=1702890764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQnzx58xLXH7liWhgauf0+5j4k1VBsh2inHpJ7SFKlA=;
        b=rvw8gy/aKPv0aziAGHmANufUpBm6Pb4yMcaMU06/eq3Baymr3kBz6K5T2qS6cP8TnM
         jYpKQZPn/IbFyKiQdryVe3dTg6HVwPmNKzS2T7ppVw7zMLOVyvWkpruZmya/DSDE8r1i
         yAD1qFeKu0U4/+qPo3BfLG5AS7lQDioxnM4NxJWUWTzHG6DsgkP3rO03IVxOKvRc8Plg
         zs6YAlUkrhWlakpeNAyv/2V+0udDX0dc8JgXgmmAaNGm2DL8hAP3emjZTrSqnZ8ZFJnM
         QX9bR9GN8vn8juYehh8WRSNoAzD4nBP2Thgprjowb9bbWmfeUFtFKbyMxDRl14j2cl/z
         lyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702285964; x=1702890764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQnzx58xLXH7liWhgauf0+5j4k1VBsh2inHpJ7SFKlA=;
        b=eV/qvx0psih4jb2/SsZTi5DDffgv5JVjTYHnM6lBO8q3Gb7I2PVhygawBiOFTv3ge2
         RjXIUcZjp9MzWqNLbzTZXycHrP/wg6Hy1OiLCPBBkFdRRUa6oDwEA2AzM5fCRewrFo1Q
         v7suaxrWROXLJ9rFsBM/MSr26PM95CKd3GURQYzda8z9MfqxWo3i0cdPQ4aniq0qmHXD
         YOcq+OW1vNiCPEmW3yi5jWzN4s0hgfKrs21ThzeUVCkrJxkvcC0yeGqZ6W55oTEhDgSS
         CuliOJIQ4HMy8Q4QkcqlfL7yaZtzlI1G0zarnQlyKbgRyVt44S240wPIqw7gUcPJGGdA
         6+yA==
X-Gm-Message-State: AOJu0Yx4fcoLcQnGIpJ8FBpdYsOEq3gb2B3a+dXBKccJuATeqk1k9LUl
        u3am6nHA1BRBOfF6XdGv2aZtzA==
X-Google-Smtp-Source: AGHT+IECa2mRSMrrAyUQzCQmdAzXStLVbTARuqDmDbcOJ1bDj2d0C8f4VRhdzkHCBRkSiqaD3tUSEQ==
X-Received: by 2002:a05:600c:b55:b0:405:39bb:38a8 with SMTP id k21-20020a05600c0b5500b0040539bb38a8mr5158938wmr.2.1702285964124;
        Mon, 11 Dec 2023 01:12:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:c192:fdd1:8f3d:9943? ([2a01:e0a:999:a3a0:c192:fdd1:8f3d:9943])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c45c700b0040c45071c18sm4335030wmo.39.2023.12.11.01.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 01:12:43 -0800 (PST)
Message-ID: <42e0c9d4-318e-4c84-bdfb-fd364bea02d5@rivosinc.com>
Date:   Mon, 11 Dec 2023 10:12:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] riscv: Include riscv_set_icache_flush_ctx prctl
Content-Language: en-US
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20231130-fencei-v2-0-2cb623ab1b1f@rivosinc.com>
 <20231130-fencei-v2-1-2cb623ab1b1f@rivosinc.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20231130-fencei-v2-1-2cb623ab1b1f@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/12/2023 08:21, Charlie Jenkins wrote:
> Support new prctl with key PR_RISCV_SET_ICACHE_FLUSH_CTX to enable
> optimization of cross modifying code. This prctl enables userspace code
> to use icache flushing instructions such as fence.i with the guarantee
> that the icache will continue to be clean after thread migration.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/mmu.h       |  2 ++
>  arch/riscv/include/asm/processor.h |  6 ++++++
>  arch/riscv/mm/cacheflush.c         | 37 +++++++++++++++++++++++++++++++++++++
>  arch/riscv/mm/context.c            |  8 +++++---
>  include/uapi/linux/prctl.h         |  3 +++
>  kernel/sys.c                       |  6 ++++++
>  6 files changed, 59 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
> index 355504b37f8e..60be458e94da 100644
> --- a/arch/riscv/include/asm/mmu.h
> +++ b/arch/riscv/include/asm/mmu.h
> @@ -19,6 +19,8 @@ typedef struct {
>  #ifdef CONFIG_SMP
>  	/* A local icache flush is needed before user execution can resume. */
>  	cpumask_t icache_stale_mask;
> +	/* Force local icache flush on all migrations. */
> +	bool force_icache_flush;
>  #endif
>  #ifdef CONFIG_BINFMT_ELF_FDPIC
>  	unsigned long exec_fdpic_loadmap;
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index f19f861cda54..7eda6c75e0f2 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -84,6 +84,9 @@ struct thread_struct {
>  	unsigned long vstate_ctrl;
>  	struct __riscv_v_ext_state vstate;
>  	unsigned long align_ctl;
> +#ifdef CONFIG_SMP
> +	bool force_icache_flush;
> +#endif
>  };
>  
>  /* Whitelist the fstate from the task_struct for hardened usercopy */
> @@ -145,6 +148,9 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
>  #define GET_UNALIGN_CTL(tsk, addr)	get_unalign_ctl((tsk), (addr))
>  #define SET_UNALIGN_CTL(tsk, val)	set_unalign_ctl((tsk), (val))
>  
> +#define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2)	riscv_set_icache_flush_ctx(arg1, arg2)
> +extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread);
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_RISCV_PROCESSOR_H */
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 55a34f2020a8..3b2bf8256a10 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -5,6 +5,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/of.h>
> +#include <linux/prctl.h>
>  #include <asm/acpi.h>
>  #include <asm/cacheflush.h>
>  
> @@ -152,3 +153,39 @@ void __init riscv_init_cbo_blocksizes(void)
>  	if (cboz_block_size)
>  		riscv_cboz_block_size = cboz_block_size;
>  }
> +
> +/**
> + * riscv_set_icache_flush_ctx() - Enable userspace to emit icache flushing instructions.
> + * @ctx: Sets the type of context
> + *  - PR_RISCV_CTX_SW_FENCEI: Allow fence.i in userspace. Another fence.i will
> + *			      emitted on thread/process migration.
> + * @per_thread: When set to 0, will use the default behavior of setting the
> + *  icache flush context per process. When set to 1, will use a per thread
> + *  context.
> + *
> + * When in per-process context, there may be multiple threads using the same mm.
> + * Therefore, the icache can never be assumed clean when. Multiple threads in
> + * the process may modify instructions in the mm concurrently.
> + *
> + * In per-thread context, it can be assumed that all modifications to
> + * instructions in memory will be performed by this thread. When the thread is
> + * migrated the icache will be flushed.
> + *
> + */
> +int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread)
> +{
> +#ifdef CONFIG_SMP
> +	switch (ctx) {
> +	case PR_RISCV_CTX_SW_FENCEI:
> +		if (per_thread)
> +			current->thread.force_icache_flush = true;
> +		else
> +			current->mm->context.force_icache_flush = true;
> +		break;
> +
> +	default:
> +		break;
> +	}
> +#endif
> +	return 0;
> +}
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 217fd4de6134..a394b146e78a 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -297,12 +297,14 @@ static inline void set_mm(struct mm_struct *prev,
>   *
>   * The "cpu" argument must be the current local CPU number.
>   */
> -static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu)
> +static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu,
> +					 struct task_struct *task)
>  {
>  #ifdef CONFIG_SMP
>  	cpumask_t *mask = &mm->context.icache_stale_mask;
>  
> -	if (cpumask_test_cpu(cpu, mask)) {
> +	if (cpumask_test_cpu(cpu, mask) || mm->context.force_icache_flush ||
> +	    mm->context.force_icache_flush) {

Hey Charlie,

Looks like you duplicated "|| mm->context.force_icache_flush" here.

Clément

>  		cpumask_clear_cpu(cpu, mask);
>  		/*
>  		 * Ensure the remote hart's writes are visible to this hart.
> @@ -332,5 +334,5 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  
>  	set_mm(prev, next, cpu);
>  
> -	flush_icache_deferred(next, cpu);
> +	flush_icache_deferred(next, cpu, task);
>  }
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 370ed14b1ae0..472801ea78cc 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -306,4 +306,7 @@ struct prctl_mm_map {
>  # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xc
>  # define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
>  
> +#define PR_RISCV_SET_ICACHE_FLUSH_CTX	71
> +# define PR_RISCV_CTX_SW_FENCEI		0
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 420d9cb9cc8e..e806a8a67c36 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -146,6 +146,9 @@
>  #ifndef RISCV_V_GET_CONTROL
>  # define RISCV_V_GET_CONTROL()		(-EINVAL)
>  #endif
> +#ifndef RISCV_SET_ICACHE_FLUSH_CTX
> +# define RISCV_SET_ICACHE_FLUSH_CTX(a, b)	(-EINVAL)
> +#endif
>  
>  /*
>   * this is where the system-wide overflow UID and GID are defined, for
> @@ -2739,6 +2742,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  	case PR_RISCV_V_GET_CONTROL:
>  		error = RISCV_V_GET_CONTROL();
>  		break;
> +	case PR_RISCV_SET_ICACHE_FLUSH_CTX:
> +		error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
> +		break;
>  	default:
>  		error = -EINVAL;
>  		break;
> 
