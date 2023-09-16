Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789E67A2E46
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 08:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbjIPGqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 02:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237823AbjIPGp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 02:45:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211FE1BC1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 23:45:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31f71b25a99so2722696f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 23:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694846752; x=1695451552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MIDeAWdahUMHOh7TW9BYceBIpM4QDz+5Y/okXYT71D4=;
        b=DRB/9v9cvgnnoUwQ7JFyZUJPxKst18z3etP1l97V638sqWWLmGCWi6lE7lbuSPeEox
         INDg3cznm6b6yNExDJBXe3k/lzgMyx+iTRpCKMYtJDazj4qVkTjnYO2C9MYCwbC4RtA/
         Dy8WQx3OvWF6Qnesj18Dq6Fjq/J1k/w/Jpk/7QoVRYX8+Bn8WehfnEz0iuE6DobnM/d8
         cnaHz7uROwNf9u/LNFJ0mIQ2oy1dX7wT9i/ehYNBIFkedvX1/Aoti41IzFCu1XYu7Vmn
         /n+9FZ6HpDWRECAwoZNO9Lw38cTwgmcDaJx/pK8mMnpyfgLPOiHp87eQI8n7OtM47vY3
         ffCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694846752; x=1695451552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIDeAWdahUMHOh7TW9BYceBIpM4QDz+5Y/okXYT71D4=;
        b=HfTDKJTTRu0N9irAKZXVLFZraKTqwXJBPOQa6ccrqYP8yrsvliAKDz09fcQ6x6Lw5m
         kIYZJj1PjrsCgBsxUUapTvGV710hPxNl6BvuezZqR0yfq4O1qFchmoJ7PucYLMK3LhAo
         8d9lOC4P7fVKKD6dKPLLn0sZh2PwmDeYb4WnvKNPJwr/9uzT13U00oYc4VGhCDlgc4Uu
         W89gkekdFKFM7cUU/OZzLqyQ9n6tfdm0Uo3q1P02JKpFpwLYFfCVSGxswWbrx/xyToV3
         VTZ05ITy2qgEzLcJHzi4UEo7LEU3JchpSdEJ/BO3zWURCcr6WMWRWviuLqCVJGAn6z9S
         Qm9A==
X-Gm-Message-State: AOJu0YyM2odguc+0mKx4eHm09QdKvhhHftpZB59uKYMNP+WjtCHKLKDX
        3Kn1fjgvw/lLhxPdkyN6WbpT8w==
X-Google-Smtp-Source: AGHT+IF9Pu6RAzmT+sR/UCnGMu/RRFT0lIKVr5isE7jkDP2hkunpqOL7QDrFb6yjnQSOzvEIEuEdkg==
X-Received: by 2002:a5d:5965:0:b0:313:f61c:42ab with SMTP id e37-20020a5d5965000000b00313f61c42abmr3019654wri.56.1694846752519;
        Fri, 15 Sep 2023 23:45:52 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id h4-20020a056000000400b00317909f9985sm6277045wrx.113.2023.09.15.23.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 23:45:51 -0700 (PDT)
Date:   Sat, 16 Sep 2023 08:45:51 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        David Laight <David.Laight@aculab.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] RISC-V: Probe misaligned access speed in parallel
Message-ID: <20230916-ab31c90dd56c99d36d5fce6c@orel>
References: <20230915184904.1976183-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915184904.1976183-1-evan@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 11:49:03AM -0700, Evan Green wrote:
> Probing for misaligned access speed takes about 0.06 seconds. On a
> system with 64 cores, doing this in smp_callin() means it's done
> serially, extending boot time by 3.8 seconds. That's a lot of boot time.
> 
> Instead of measuring each CPU serially, let's do the measurements on
> all CPUs in parallel. If we disable preemption on all CPUs, the
> jiffies stop ticking, so we can do this in stages of 1) everybody
> except core 0, then 2) core 0.
> 
> The measurement call in smp_callin() stays around, but is now
> conditionalized to only run if a new CPU shows up after the round of
> in-parallel measurements has run. The goal is to have the measurement
> call not run during boot or suspend/resume, but only on a hotplug
> addition.

Yay! I had just recently tested suspend/resume and wanted to report the
probe as an issue, but I hadn't gotten around to it. This patch resolves
the issue, so

Test-by: Andrew Jones <ajones@ventanamicro.com>

> 
> Signed-off-by: Evan Green <evan@rivosinc.com>
> 
> ---
> 
> Jisheng, I didn't add your Tested-by tag since the patch evolved from
> the one you tested. Hopefully this one brings you the same result.
> 
> ---
>  arch/riscv/include/asm/cpufeature.h |  3 ++-
>  arch/riscv/kernel/cpufeature.c      | 28 +++++++++++++++++++++++-----
>  arch/riscv/kernel/smpboot.c         | 11 ++++++++++-
>  3 files changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> index d0345bd659c9..19e7817eba10 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -30,6 +30,7 @@ DECLARE_PER_CPU(long, misaligned_access_speed);
>  /* Per-cpu ISA extensions. */
>  extern struct riscv_isainfo hart_isa[NR_CPUS];
>  
> -void check_unaligned_access(int cpu);
> +extern bool misaligned_speed_measured;

Do we need this new state or could we just always check the boot cpu's
state to get the same information?

 per_cpu(misaligned_access_speed, 0) != RISCV_HWPROBE_MISALIGNED_UNKNOWN

> +int check_unaligned_access(void *unused);
>  
>  #endif
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 1cfbba65d11a..8eb36e1dfb95 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -42,6 +42,9 @@ struct riscv_isainfo hart_isa[NR_CPUS];
>  /* Performance information */
>  DEFINE_PER_CPU(long, misaligned_access_speed);
>  
> +/* Boot-time in-parallel unaligned access measurement has occurred. */
> +bool misaligned_speed_measured;
> +
>  /**
>   * riscv_isa_extension_base() - Get base extension word
>   *
> @@ -556,8 +559,9 @@ unsigned long riscv_get_elf_hwcap(void)
>  	return hwcap;
>  }
>  
> -void check_unaligned_access(int cpu)
> +int check_unaligned_access(void *unused)
>  {
> +	int cpu = smp_processor_id();
>  	u64 start_cycles, end_cycles;
>  	u64 word_cycles;
>  	u64 byte_cycles;
> @@ -571,7 +575,7 @@ void check_unaligned_access(int cpu)
>  	page = alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE));
>  	if (!page) {
>  		pr_warn("Can't alloc pages to measure memcpy performance");
> -		return;
> +		return 0;
>  	}
>  
>  	/* Make an unaligned destination buffer. */
> @@ -643,15 +647,29 @@ void check_unaligned_access(int cpu)
>  
>  out:
>  	__free_pages(page, get_order(MISALIGNED_BUFFER_SIZE));
> +	return 0;
> +}
> +
> +static void check_unaligned_access_nonboot_cpu(void *param)
> +{
> +	if (smp_processor_id() != 0)
> +		check_unaligned_access(param);
>  }
>  
> -static int check_unaligned_access_boot_cpu(void)
> +static int check_unaligned_access_all_cpus(void)
>  {
> -	check_unaligned_access(0);
> +	/* Check everybody except 0, who stays behind to tend jiffies. */
> +	on_each_cpu(check_unaligned_access_nonboot_cpu, NULL, 1);
> +
> +	/* Check core 0. */
> +	smp_call_on_cpu(0, check_unaligned_access, NULL, true);
> +
> +	/* Boot-time measurements are complete. */
> +	misaligned_speed_measured = true;
>  	return 0;
>  }
>  
> -arch_initcall(check_unaligned_access_boot_cpu);
> +arch_initcall(check_unaligned_access_all_cpus);
>  
>  #ifdef CONFIG_RISCV_ALTERNATIVE
>  /*
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 1b8da4e40a4d..39322ae20a75 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -27,6 +27,7 @@
>  #include <linux/sched/mm.h>
>  #include <asm/cpu_ops.h>
>  #include <asm/cpufeature.h>
> +#include <asm/hwprobe.h>
>  #include <asm/irq.h>
>  #include <asm/mmu_context.h>
>  #include <asm/numa.h>
> @@ -246,7 +247,15 @@ asmlinkage __visible void smp_callin(void)
>  
>  	numa_add_cpu(curr_cpuid);
>  	set_cpu_online(curr_cpuid, 1);
> -	check_unaligned_access(curr_cpuid);
> +
> +	/*
> +	 * Boot-time misaligned access speed measurements are done in parallel
> +	 * in an initcall. Only measure here for hotplug.
> +	 */
> +	if (misaligned_speed_measured &&
> +	    (per_cpu(misaligned_access_speed, curr_cpuid) == RISCV_HWPROBE_MISALIGNED_UNKNOWN)) {
> +		check_unaligned_access(NULL);
> +	}
>  
>  	if (has_vector()) {
>  		if (riscv_v_setup_vsize())
> -- 
> 2.34.1
>

Besides my reluctance to add another global variable, this looks good to
me.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

