Return-Path: <linux-kernel+bounces-151599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49D28AB0EF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043FF1C22B84
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D829212EBEF;
	Fri, 19 Apr 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ubuk1P+X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E258212EBD9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713537857; cv=none; b=ZFt1rqB0driea9yrLLvmNID7Bm//+8wmcIKoAvFw4M3TsNQZkkQkraEhg80Gwc4/bktEl+sAw8/9RlpOFL6I8dAfVCW3bZ/TRmak50a0u7MQMi+Xm7h5rhYCU6181QQm1MmP9nybi16BMs7j5Rv0Tu3/cnw9cbl1dT9PIgWgQJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713537857; c=relaxed/simple;
	bh=bHA2xqYSMNatPFnZVCcx2yYhIKeXPn6D+Rojt/rhxIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNyc9w7TQDo7kRzuZZ+qXWps+3oIg6JEiyWbCxlltmGcLDJI8DHOMItR8paoVcVWSritEcBYNGu4PIwNsp6W1Td2YW30M4gz4u1pB4Q1RZklftPfisbYjN0JzYmvaR1jX4BmFVzrjXX29j9SjTpfU63Yyq2JRH8SkKQgubaLuRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ubuk1P+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833B0C072AA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713537856;
	bh=bHA2xqYSMNatPFnZVCcx2yYhIKeXPn6D+Rojt/rhxIM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ubuk1P+XYzyUgu8XpzmAZXn836Nvs/NecvZxdsmPmL1jH/Wxr1U7TVJKBG1OC9F6v
	 eh64ptFLS91CPh0+8GEKcoFTouRYeX12HH1HT9VvKo1eN3AGHRQqRBzZB1wQ/OJs9s
	 oBGjadfTNkTTbfAJNlkLjCrvpgA2UrcHk+c6hodcslLhT9bYL0MV/4NIy+ug1oJW4+
	 jlvjzydXarqFF5E0b85vW+YKhf/pDrgPCCs3m36UNAH2E8Aiw7l5TBFOb+mryQ7cuT
	 ZF8gCLJmZlpXWdsuNUxiv8VNhWlMgZrFC8gbm2IxsWcJR1Axs3CJ+ziq5+Y4P5jQRI
	 O21Y/dOOY/SxA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5269c3f9c7so240779066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:44:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvmHH+0cnbmK/vz1KeScdSujlrLt+W8VoueqQSq0xXWk7xH1+C79WD+K83OWTaQMB9lTks+7+vEpkHSNE8Ri2y1watlc3O2rLfRULw
X-Gm-Message-State: AOJu0YygqrVhulteuKS+GR4VPgSb5BpJH4Y/BcGsLKnTbsE7YQcm8mTI
	C4+gk2+jXlvundzy26glzEKQ9TRq7DrN+BmL/FO5yYPTRUidxY98Rj7b5XtFwEhMRWtwZ4PGkay
	5xmONbAoyb9vOUWAcTRNjvRZ3DOU=
X-Google-Smtp-Source: AGHT+IFbSQDlWkPQVgfJ0eYSXvgM4ONQv6lH2pP3Y8Bhb/9GSi7H9+iJPa0PIVoNd5fJe1niEPm+hR/m9knopc3sovI=
X-Received: by 2002:a17:906:70c2:b0:a55:65e6:ce9f with SMTP id
 g2-20020a17090670c200b00a5565e6ce9fmr1469057ejk.20.1713537854956; Fri, 19 Apr
 2024 07:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418110520.16915-1-yangtiezhu@loongson.cn>
In-Reply-To: <20240418110520.16915-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 19 Apr 2024 22:44:03 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4p1jjBWjfmRJ-vWYMsBt4mkqa+MfxSuWC=Yf2_yCEp+w@mail.gmail.com>
Message-ID: <CAAhV-H4p1jjBWjfmRJ-vWYMsBt4mkqa+MfxSuWC=Yf2_yCEp+w@mail.gmail.com>
Subject: Re: [PATCH v5] LoongArch: Give chance to build under !CONFIG_SMP
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Queued for loongarch-next, thanks.

Huacai

On Thu, Apr 18, 2024 at 7:05=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> In the current code, SMP is selected in Kconfig for LoongArch, the users
> can not unset it, this is reasonable for a multiprocessor machine. But as
> the help info of config SMP said, if you have a system with only one CPU,
> say N. On a uniprocessor machine, the kernel will run faster if you say N
> here.
>
> The Loongson-2K0500 is a single-core CPU for applications like industrial
> control, printing terminals, and BMC (Baseboard Management Controller),
> there are many development boards, products and solutions on the market,
> so it is better and necessary to give a chance to build under !CONFIG_SMP
> for a uniprocessor machine.
>
> First of all, do not select SMP for config LOONGARCH in Kconfig to make i=
t
> possible to unset CONFIG_SMP. Then, do some changes to fix the warnings a=
nd
> errors if CONFIG_SMP is not set.
>
> (1) Define get_ipi_irq() only if CONFIG_SMP is set to fix the warning:
> arch/loongarch/kernel/irq.c:90:19: warning: 'get_ipi_irq' defined but not=
 used [-Wunused-function]
>
> (2) Add "#ifdef CONFIG_SMP" in asm/smp.h to fix the warning:
> ./arch/loongarch/include/asm/smp.h:49:9: warning: "raw_smp_processor_id" =
redefined
>    49 | #define raw_smp_processor_id raw_smp_processor_id
>       |         ^~~~~~~~~~~~~~~~~~~~
> ./include/linux/smp.h:198:9: note: this is the location of the previous d=
efinition
>   198 | #define raw_smp_processor_id()                  0
>
> (3) Define machine_shutdown() as empty under !CONFIG_SMP to fix the error=
:
> arch/loongarch/kernel/machine_kexec.c: In function 'machine_shutdown':
> arch/loongarch/kernel/machine_kexec.c:233:25: error: implicit declaration=
 of function 'cpu_device_up'; did you mean 'put_device'? [-Wimplicit-functi=
on-declaration]
>
> (4) Make config SCHED_SMT depends on SMP to fix many errors such as:
> kernel/sched/core.c: In function 'sched_core_find':
> kernel/sched/core.c:310:43: error: 'struct rq' has no member named 'cpu'
>
> (5) Define cpu_logical_map(cpu) as 0 under !CONFIG_SMP in asm/smp.h,
> then include asm/smp.h in asm/acpi.h (because acpi.h is included in
> linux/irq.h indirectly) to fix many build errors under drivers/irqchip
> such as:
> drivers/irqchip/irq-loongson-eiointc.c: In function 'cpu_to_eio_node':
> drivers/irqchip/irq-loongson-eiointc.c:59:16: error: implicit declaration=
 of function 'cpu_logical_map' [-Wimplicit-function-declaration]
>
> (6) Do not write per_cpu_offset(0) to PERCPU_BASE_KS when resume
> because per_cpu_offset(x) is defined as __per_cpu_offset[x]) only
> under CONFIG_SMP in include/asm-generic/percpu.h, just save the
> value of PERCPU_BASE_KS when suspend and restore it when resume
> to fix the error:
> arch/loongarch/power/suspend.c: In function 'loongarch_common_resume':
> arch/loongarch/power/suspend.c:47:21: error: implicit declaration of func=
tion 'per_cpu_offset' [-Wimplicit-function-declaration]
>
> When running the UnixBench tests with "-c 1" single-streamed pass,
> the improvement in performance is about 9 percent with this patch.
>
> By the way, it is helpful to debug and analysis the kernel issue
> of multi-core system under !CONFIG_SMP.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>
> v5:
>   -- Drop the changes of arch/loongarch/kernel/acpi.c
>   -- Define cpu_logical_map(cpu) as 0 under !CONFIG_SMP
>   -- Squash the changes of suspend.c into one single patch
>
>  arch/loongarch/Kconfig                | 2 +-
>  arch/loongarch/include/asm/acpi.h     | 1 +
>  arch/loongarch/include/asm/smp.h      | 5 +++++
>  arch/loongarch/kernel/irq.c           | 2 ++
>  arch/loongarch/kernel/machine_kexec.c | 2 +-
>  arch/loongarch/power/suspend.c        | 4 +++-
>  6 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index a5f300ec6f28..8d892de0b7a8 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -174,7 +174,6 @@ config LOONGARCH
>         select PCI_QUIRKS
>         select PERF_USE_VMALLOC
>         select RTC_LIB
> -       select SMP
>         select SPARSE_IRQ
>         select SYSCTL_ARCH_UNALIGN_ALLOW
>         select SYSCTL_ARCH_UNALIGN_NO_WARN
> @@ -420,6 +419,7 @@ config EFI_STUB
>
>  config SCHED_SMT
>         bool "SMT scheduler support"
> +       depends on SMP
>         default y
>         help
>           Improves scheduler's performance when there are multiple
> diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/a=
sm/acpi.h
> index 49e29b29996f..313f66f7913a 100644
> --- a/arch/loongarch/include/asm/acpi.h
> +++ b/arch/loongarch/include/asm/acpi.h
> @@ -8,6 +8,7 @@
>  #ifndef _ASM_LOONGARCH_ACPI_H
>  #define _ASM_LOONGARCH_ACPI_H
>
> +#include <asm/smp.h>
>  #include <asm/suspend.h>
>
>  #ifdef CONFIG_ACPI
> diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/as=
m/smp.h
> index f81e5f01d619..8190b093a687 100644
> --- a/arch/loongarch/include/asm/smp.h
> +++ b/arch/loongarch/include/asm/smp.h
> @@ -6,6 +6,7 @@
>  #ifndef __ASM_SMP_H
>  #define __ASM_SMP_H
>
> +#ifdef CONFIG_SMP
>  #include <linux/atomic.h>
>  #include <linux/bitops.h>
>  #include <linux/linkage.h>
> @@ -101,4 +102,8 @@ static inline void __cpu_die(unsigned int cpu)
>  }
>  #endif
>
> +#else /* !CONFIG_SMP */
> +#define cpu_logical_map(cpu)   0
> +#endif /* CONFIG_SMP */
> +
>  #endif /* __ASM_SMP_H */
> diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
> index 883e5066ae44..e791fa275ec5 100644
> --- a/arch/loongarch/kernel/irq.c
> +++ b/arch/loongarch/kernel/irq.c
> @@ -87,6 +87,7 @@ static void __init init_vec_parent_group(void)
>         acpi_table_parse(ACPI_SIG_MCFG, early_pci_mcfg_parse);
>  }
>
> +#ifdef CONFIG_SMP
>  static int __init get_ipi_irq(void)
>  {
>         struct irq_domain *d =3D irq_find_matching_fwnode(cpuintc_handle,=
 DOMAIN_BUS_ANY);
> @@ -96,6 +97,7 @@ static int __init get_ipi_irq(void)
>
>         return -EINVAL;
>  }
> +#endif
>
>  void __init init_IRQ(void)
>  {
> diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kerne=
l/machine_kexec.c
> index 2dcb9e003657..8ae641dc53bb 100644
> --- a/arch/loongarch/kernel/machine_kexec.c
> +++ b/arch/loongarch/kernel/machine_kexec.c
> @@ -225,6 +225,7 @@ void crash_smp_send_stop(void)
>
>  void machine_shutdown(void)
>  {
> +#ifdef CONFIG_SMP
>         int cpu;
>
>         /* All CPUs go to reboot_code_buffer */
> @@ -232,7 +233,6 @@ void machine_shutdown(void)
>                 if (!cpu_online(cpu))
>                         cpu_device_up(get_cpu_device(cpu));
>
> -#ifdef CONFIG_SMP
>         smp_call_function(kexec_shutdown_secondary, NULL, 0);
>  #endif
>  }
> diff --git a/arch/loongarch/power/suspend.c b/arch/loongarch/power/suspen=
d.c
> index 166d9e06a64b..8571818b93dc 100644
> --- a/arch/loongarch/power/suspend.c
> +++ b/arch/loongarch/power/suspend.c
> @@ -24,6 +24,7 @@ struct saved_registers {
>         u64 kpgd;
>         u32 pwctl0;
>         u32 pwctl1;
> +       u64 pcpu_base;
>  };
>  static struct saved_registers saved_regs;
>
> @@ -36,6 +37,7 @@ void loongarch_common_suspend(void)
>         saved_regs.pwctl1 =3D csr_read32(LOONGARCH_CSR_PWCTL1);
>         saved_regs.ecfg =3D csr_read32(LOONGARCH_CSR_ECFG);
>         saved_regs.euen =3D csr_read32(LOONGARCH_CSR_EUEN);
> +       saved_regs.pcpu_base =3D csr_read64(PERCPU_BASE_KS);
>
>         loongarch_suspend_addr =3D loongson_sysconf.suspend_addr;
>  }
> @@ -44,7 +46,7 @@ void loongarch_common_resume(void)
>  {
>         sync_counter();
>         local_flush_tlb_all();
> -       csr_write64(per_cpu_offset(0), PERCPU_BASE_KS);
> +       csr_write64(saved_regs.pcpu_base, PERCPU_BASE_KS);
>         csr_write64(eentry, LOONGARCH_CSR_EENTRY);
>         csr_write64(eentry, LOONGARCH_CSR_MERRENTRY);
>         csr_write64(tlbrentry, LOONGARCH_CSR_TLBRENTRY);
> --
> 2.42.0
>

