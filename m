Return-Path: <linux-kernel+bounces-16620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B77582414B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B35EB21EC7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C692136E;
	Thu,  4 Jan 2024 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="LtVwB2Bn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C47B2135D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ccbf8cbf3aso6000161fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 04:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704370177; x=1704974977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OhX0VzJwMOMlPMl/O/UbwhUU6chhGIjYffCjj+4YjA=;
        b=LtVwB2BnU/IDKCbZDKvJySxbDq0/jcVCnuPEXpGWp0/qAPqJ7TRBu6S4JXfay4lUB/
         FmRCzkGOYUu30tRoT2jfvhef1Xfbji5ndWQa34a/AEgRyKI8yM+FxCc+kciYbz5hdJoy
         vaqqLVfAMS3Uk0qejED5MjDBvO6kBtAUAjTNtPdaurd9mA9VYvIViior1NGsPrL3XGZN
         DtokyqajRBhP63OLqMsHpswqs8J+D9w7UCv7vSU9smmpCQoA1UdLMNbF5QKCYrr0la9n
         jZV4Gcv3j+wXhisamBWEbgbeYd5kOee7WzRcr+eAutscKZvG6WYVowZ+pwHz291XxTeK
         89Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704370177; x=1704974977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OhX0VzJwMOMlPMl/O/UbwhUU6chhGIjYffCjj+4YjA=;
        b=wSoYdZigf7isuexZFH2lSW2WjJdS2TimkHdWXtFnLmeW7LuPSNxi3L3jZaZSB5yP/a
         rFW9t8bNdfw+76VBYbOcP450v1uUF83S0VrVvPNtQLP8xXR1BOMod/GvPGIL1j/BTpAS
         AsXUhCP5TZd+jmYv5sapJ1afIFkqu9ByjeZfLwZV0qCk2k/fISm9S8g4v1um9ObKsMry
         gnBE9doZARvO5EHBJK0scEA/GVyH9KTFL2RyhcbZfBI9KQmFb3Ftbbr9uhf3j9LVCeTP
         JGWZmr+7LDwd+y0uGkDNByFIMkoDKTuF4aEsWKF3Dwao4URThZyXKdSAjLliqGMQMmXQ
         49YA==
X-Gm-Message-State: AOJu0YwWZjnFDH7T6Qi+qvwJDcIOwohWUpjaL60n4IJFrc6Cso2gqRMY
	TUa146lVesD2ktE6bw41MSWRJ5PeskZpdRHeucQGWuqHveWjWy5g8kXASBZ9
X-Google-Smtp-Source: AGHT+IHz1HGtquuKHpa5k8LMx0cAtC2KImJu4U9ZaKRwSALvhrpqyubqXuJVZxO/KTRsfiL7ggCWifvCyA2mr0Ojx6Y=
X-Received: by 2002:a05:6512:398f:b0:50e:a8c7:b2df with SMTP id
 j15-20020a056512398f00b0050ea8c7b2dfmr376322lfu.36.1704370177506; Thu, 04 Jan
 2024 04:09:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102220134.3229156-1-samuel.holland@sifive.com> <20240102220134.3229156-3-samuel.holland@sifive.com>
In-Reply-To: <20240102220134.3229156-3-samuel.holland@sifive.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 4 Jan 2024 13:09:26 +0100
Message-ID: <CAHVXubhTCpdBtNipc0um20tEcLrai6srSdqFYAq+VJpQZMdFiw@mail.gmail.com>
Subject: Re: [PATCH v4 02/12] riscv: Use IPIs for remote cache/TLB flushes by default
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 11:01=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> An IPI backend is always required in an SMP configuration, but an SBI
> implementation is not. For example, SBI will be unavailable when the
> kernel runs in M mode.
>
> Generally, IPIs are assumed to be faster than SBI calls due to the SBI
> context switch overhead. However, when SBI is used as the IPI backend,
> then the context switch cost must be paid anyway, and performing the
> cache/TLB flush directly in the SBI implementation is more efficient
> than inserting an interrupt to the kernel. This is the only scenario
> where riscv_ipi_set_virq_range()'s use_for_rfence parameter is false.
>
> Thus, it makes sense for remote fences to use IPIs by default, and make
> the SBI remote fence extension the special case.
>
> sbi_ipi_init() already checks riscv_ipi_have_virq_range(), so it only
> calls riscv_ipi_set_virq_range() when no other IPI device is available.
> So we can move the static key and drop the use_for_rfence parameter.
>
> Furthermore, the static branch only makes sense when CONFIG_RISCV_SBI is
> enabled. Optherwise, IPIs must be used. Add a fallback definition of
> riscv_use_sbi_for_rfence() which handles this case and removes the need
> to check CONFIG_RISCV_SBI elsewhere, such as in cacheflush.c.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> Changes in v4:
>  - New patch for v4
>
>  arch/riscv/include/asm/sbi.h      |  4 ++++
>  arch/riscv/include/asm/smp.h      | 15 ++-------------
>  arch/riscv/kernel/sbi-ipi.c       | 11 ++++++++++-
>  arch/riscv/kernel/smp.c           | 11 +----------
>  arch/riscv/mm/cacheflush.c        |  5 ++---
>  arch/riscv/mm/tlbflush.c          | 31 ++++++++++++++-----------------
>  drivers/clocksource/timer-clint.c |  2 +-
>  7 files changed, 34 insertions(+), 45 deletions(-)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 0892f4421bc4..aeee0127df76 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -339,8 +339,12 @@ unsigned long riscv_cached_marchid(unsigned int cpu_=
id);
>  unsigned long riscv_cached_mimpid(unsigned int cpu_id);
>
>  #if IS_ENABLED(CONFIG_SMP) && IS_ENABLED(CONFIG_RISCV_SBI)
> +DECLARE_STATIC_KEY_FALSE(riscv_sbi_for_rfence);
> +#define riscv_use_sbi_for_rfence() \
> +       static_branch_unlikely(&riscv_sbi_for_rfence)
>  void sbi_ipi_init(void);
>  #else
> +static inline bool riscv_use_sbi_for_rfence(void) { return false; }
>  static inline void sbi_ipi_init(void) { }
>  #endif
>
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index 0d555847cde6..7ac80e9f2288 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -49,12 +49,7 @@ void riscv_ipi_disable(void);
>  bool riscv_ipi_have_virq_range(void);
>
>  /* Set the IPI interrupt numbers for arch (called by irqchip drivers) */
> -void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence);
> -
> -/* Check if we can use IPIs for remote FENCEs */
> -DECLARE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
> -#define riscv_use_ipi_for_rfence() \
> -       static_branch_unlikely(&riscv_ipi_for_rfence)
> +void riscv_ipi_set_virq_range(int virq, int nr);
>
>  /* Check other CPUs stop or not */
>  bool smp_crash_stop_failed(void);
> @@ -104,16 +99,10 @@ static inline bool riscv_ipi_have_virq_range(void)
>         return false;
>  }
>
> -static inline void riscv_ipi_set_virq_range(int virq, int nr,
> -                                           bool use_for_rfence)
> +static inline void riscv_ipi_set_virq_range(int virq, int nr)
>  {
>  }
>
> -static inline bool riscv_use_ipi_for_rfence(void)
> -{
> -       return false;
> -}
> -
>  #endif /* CONFIG_SMP */
>
>  #if defined(CONFIG_HOTPLUG_CPU) && (CONFIG_SMP)
> diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
> index a4559695ce62..1026e22955cc 100644
> --- a/arch/riscv/kernel/sbi-ipi.c
> +++ b/arch/riscv/kernel/sbi-ipi.c
> @@ -13,6 +13,9 @@
>  #include <linux/irqdomain.h>
>  #include <asm/sbi.h>
>
> +DEFINE_STATIC_KEY_FALSE(riscv_sbi_for_rfence);
> +EXPORT_SYMBOL_GPL(riscv_sbi_for_rfence);
> +
>  static int sbi_ipi_virq;
>
>  static void sbi_ipi_handle(struct irq_desc *desc)
> @@ -72,6 +75,12 @@ void __init sbi_ipi_init(void)
>                           "irqchip/sbi-ipi:starting",
>                           sbi_ipi_starting_cpu, NULL);
>
> -       riscv_ipi_set_virq_range(virq, BITS_PER_BYTE, false);
> +       riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
>         pr_info("providing IPIs using SBI IPI extension\n");
> +
> +       /*
> +        * Use the SBI remote fence extension to avoid
> +        * the extra context switch needed to handle IPIs.
> +        */
> +       static_branch_enable(&riscv_sbi_for_rfence);
>  }
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 40420afbb1a0..1d06df04eb71 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -171,10 +171,7 @@ bool riscv_ipi_have_virq_range(void)
>         return (ipi_virq_base) ? true : false;
>  }
>
> -DEFINE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
> -EXPORT_SYMBOL_GPL(riscv_ipi_for_rfence);
> -
> -void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence)
> +void riscv_ipi_set_virq_range(int virq, int nr)
>  {
>         int i, err;
>
> @@ -197,12 +194,6 @@ void riscv_ipi_set_virq_range(int virq, int nr, bool=
 use_for_rfence)
>
>         /* Enabled IPIs for boot CPU immediately */
>         riscv_ipi_enable();
> -
> -       /* Update RFENCE static key */
> -       if (use_for_rfence)
> -               static_branch_enable(&riscv_ipi_for_rfence);
> -       else
> -               static_branch_disable(&riscv_ipi_for_rfence);
>  }
>
>  static const char * const ipi_names[] =3D {
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 55a34f2020a8..47c485bc7df0 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -21,7 +21,7 @@ void flush_icache_all(void)
>  {
>         local_flush_icache_all();
>
> -       if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
> +       if (riscv_use_sbi_for_rfence())
>                 sbi_remote_fence_i(NULL);
>         else
>                 on_each_cpu(ipi_remote_fence_i, NULL, 1);
> @@ -69,8 +69,7 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
>                  * with flush_icache_deferred().
>                  */
>                 smp_mb();
> -       } else if (IS_ENABLED(CONFIG_RISCV_SBI) &&
> -                  !riscv_use_ipi_for_rfence()) {
> +       } else if (riscv_use_sbi_for_rfence()) {
>                 sbi_remote_fence_i(&others);
>         } else {
>                 on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index e6659d7368b3..09b03bf71e6a 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -73,10 +73,10 @@ static void __ipi_flush_tlb_all(void *info)
>
>  void flush_tlb_all(void)
>  {
> -       if (riscv_use_ipi_for_rfence())
> -               on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
> -       else
> +       if (riscv_use_sbi_for_rfence())
>                 sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, F=
LUSH_TLB_NO_ASID);
> +       else
> +               on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
>  }
>
>  struct flush_tlb_range_data {
> @@ -96,7 +96,6 @@ static void __ipi_flush_tlb_range_asid(void *info)
>  static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
>                               unsigned long size, unsigned long stride)
>  {
> -       struct flush_tlb_range_data ftd;
>         const struct cpumask *cmask;
>         unsigned long asid =3D FLUSH_TLB_NO_ASID;
>         bool broadcast;
> @@ -119,20 +118,18 @@ static void __flush_tlb_range(struct mm_struct *mm,=
 unsigned long start,
>                 broadcast =3D true;
>         }
>
> -       if (broadcast) {
> -               if (riscv_use_ipi_for_rfence()) {
> -                       ftd.asid =3D asid;
> -                       ftd.start =3D start;
> -                       ftd.size =3D size;
> -                       ftd.stride =3D stride;
> -                       on_each_cpu_mask(cmask,
> -                                        __ipi_flush_tlb_range_asid,
> -                                        &ftd, 1);
> -               } else
> -                       sbi_remote_sfence_vma_asid(cmask,
> -                                                  start, size, asid);
> -       } else {
> +       if (!broadcast) {
>                 local_flush_tlb_range_asid(start, size, stride, asid);
> +       } else if (riscv_use_sbi_for_rfence()) {
> +               sbi_remote_sfence_vma_asid(cmask, start, size, asid);
> +       } else {
> +               struct flush_tlb_range_data ftd;
> +
> +               ftd.asid =3D asid;
> +               ftd.start =3D start;
> +               ftd.size =3D size;
> +               ftd.stride =3D stride;
> +               on_each_cpu_mask(cmask, __ipi_flush_tlb_range_asid, &ftd,=
 1);
>         }
>
>         if (mm)
> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/time=
r-clint.c
> index 9a55e733ae99..7ccc16dd6a76 100644
> --- a/drivers/clocksource/timer-clint.c
> +++ b/drivers/clocksource/timer-clint.c
> @@ -251,7 +251,7 @@ static int __init clint_timer_init_dt(struct device_n=
ode *np)
>         }
>
>         irq_set_chained_handler(clint_ipi_irq, clint_ipi_interrupt);
> -       riscv_ipi_set_virq_range(rc, BITS_PER_BYTE, true);
> +       riscv_ipi_set_virq_range(rc, BITS_PER_BYTE);
>         clint_clear_ipi();
>  #endif
>
> --
> 2.42.0
>

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

