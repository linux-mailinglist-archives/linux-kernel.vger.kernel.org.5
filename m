Return-Path: <linux-kernel+bounces-65333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C171E854B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F3B1C21E41
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A22055E40;
	Wed, 14 Feb 2024 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="S5g3TikT"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25FA45C15
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920697; cv=none; b=Fh8kFGTTl8Dd4SH5tmvzG3N/Xg6w6ny/rAaqD+4Etyi6QBWZXSoXkINXJeSDaarFbN03GlTXmLQtT09OD8xWNmCCs9bPt2mcNLl975hJg2WqgD5y7ZeZAdsV54oe6x+lnu4wIfwKhAP+CHFh2i1bDnoprPor61SMHAt/QPszmp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920697; c=relaxed/simple;
	bh=wCA82XRAuvBptBrlMMHNCGHGhTHFyW48Mntepy2f9ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjZueGFl6w6FT1mqi1XJ/pQOjD7wh84WPrrQD3P+vahasdcWj/UDRQiELGsx/0uBC51qFtxiJXmjkQ9b5f/Ya7m5cdQFxxehxU0zGvvn8NWtGxHYOEG/AUqgZ/GDOfH6ZvOINgU/4AgiSi5fLhKbYuSPSZ2ZPVSQftwB7HNuFtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=S5g3TikT; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51181d8f52fso2836696e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 06:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707920693; x=1708525493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psl8kRvXhB4rsjXTg8zSDqahJ4+8x+4MgyYiyG8mWAU=;
        b=S5g3TikTulBle94vwFOsHAfBn+WQe7p/Lq/2cg0lGlLL6AqimHx716E5a9qgj6O8Tx
         A6wArMGnRqUepYCCm6/AKsUHCEWny15K+07aBL/wYbi5txkILkPB1/lQO7ug9EngJst5
         B2rO1Bhp9vTZ/e/goGFOOe5gn79SNLsHytdaT2MdbMdGLU9daEK9WUmh2mMDSYZTSQo0
         qhH5F+QZI611U3FFOavu34q1Vu+eCdBVKf54ySN+5gScUEEsx8in8uhMjvMU4UAGI/y7
         yjqL0BbFE950LqabQiEH7acw3Ykm61rsQtDAFZUVLkt19NT/9m3zGm/bPTH207aUhY4W
         As0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707920693; x=1708525493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psl8kRvXhB4rsjXTg8zSDqahJ4+8x+4MgyYiyG8mWAU=;
        b=Fc2VjX4EXh2cRhlvFJGRhCzqsj3xoLzSaKWkyDzLXPPtvRY9AyJHuL7nCdNB0zJyP9
         EDc4G+df7sqkkeXDfG4blv3egTlXxRcKznCs1SB+1KQwXWW3YEwCRQBz21eAKT+gidL1
         Bil4mc+TLc4RERcQgu8QR5Kldk4ur/yqFCgeQy4+5SrACLBUysZXKGI8CLjTPpCHxQFj
         9msLcFwDBfNOEMObvCGNLw5UoI1FBOppynxQPHK9rDfDSidL2hp8r4k5spMt4Kal1fK/
         4kKgpderFLh3GjVxPO3K4CN+9ydbxR5mWr37G2whfrQxxCdQwrIIPHgIUVYlvOQh0wbG
         z4xw==
X-Forwarded-Encrypted: i=1; AJvYcCUg2C2Ik1xDBP32+Oy0OY+4+gmKIF/tfjgQNcpEIYZCGbMa7uRIm2XJDa3ft8WjH7hi0w0g06gjzpd4w5Tsvni/+dq6M/s+C6rIfJcv
X-Gm-Message-State: AOJu0YxHsDiEoQzfSAlqpQbqCji6vOvzWSMcnmGMi2J6NRSYeGoH6uCC
	XlIwr4O+gUhm3yaYIeaTCzGpG0bGUpIDRezOpn2QcbMrvkFOY0GPyiTWg9fOdyNSU9+ciWoaJeR
	2QX4QVCrbJBlIThBVcUgOfvquDzIQT9IyzoO9Ig==
X-Google-Smtp-Source: AGHT+IEqEK+ALEFI7ce1AV15fG4LJYxvrUtHWS0sU8YlMs47wmsS1MjvzW5WT07U/csySDKi5EoKF3/VXgozsRtKp7A=
X-Received: by 2002:ac2:4c0c:0:b0:511:8691:94c3 with SMTP id
 t12-20020ac24c0c000000b00511869194c3mr1923173lfq.21.1707920692546; Wed, 14
 Feb 2024 06:24:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202-disable_misaligned_probe_config-v3-0-c44f91f03bb6@rivosinc.com>
 <20240202-disable_misaligned_probe_config-v3-2-c44f91f03bb6@rivosinc.com>
In-Reply-To: <20240202-disable_misaligned_probe_config-v3-2-c44f91f03bb6@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Wed, 14 Feb 2024 09:24:16 -0500
Message-ID: <CALs-HssKav=+P_w5VuoZZU3xkut6FxMUpdpd5HSa5iPMRDu=5A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] riscv: Disable misaligned access probe when CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Eric Biggers <ebiggers@kernel.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 6:54=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
>
> When CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is selected, the cpus can be
> set to have fast misaligned access without needing to probe.
>
> To avoid some ifdefs, move unalignment probing code into its own file
> and make CONFIG_RISCV_MISALIGNED depend on
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

One nit below, but feel free to add my tag on the next spin:

Reviewed-by: Evan Green <evan@rivosinc.com>

> ---
>  arch/riscv/Kconfig                          |   1 +
>  arch/riscv/include/asm/cpufeature.h         |   7 +
>  arch/riscv/kernel/Makefile                  |   3 +
>  arch/riscv/kernel/cpufeature.c              | 255 ----------------------=
----
>  arch/riscv/kernel/misaligned_access_speed.c | 265 ++++++++++++++++++++++=
++++++
>  arch/riscv/kernel/sys_hwprobe.c             |   4 +
>  6 files changed, 280 insertions(+), 255 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index bffbd869a068..3223d2d08f74 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -690,6 +690,7 @@ config THREAD_SIZE_ORDER
>  config RISCV_MISALIGNED
>         bool "Support misaligned load/store traps for kernel and userspac=
e"
>         select SYSCTL_ARCH_UNALIGN_ALLOW
> +       depends on !HAVE_EFFICIENT_UNALIGNED_ACCESS
>         default y
>         help
>           Say Y here if you want the kernel to embed support for misalign=
ed
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index eb3ac304fc42..44734e5169b1 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -51,6 +51,12 @@ static inline bool check_unaligned_access_emulated(int=
 cpu)
>  static inline void unaligned_emulation_finish(void) {}
>  #endif
>
> +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> +static __always_inline bool has_fast_misaligned_accesses(void)
> +{
> +       return true;
> +}
> +#else
>  DECLARE_PER_CPU(long, misaligned_access_speed);
>
>  DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> @@ -59,6 +65,7 @@ static __always_inline bool has_fast_misaligned_accesse=
s(void)
>  {
>         return static_branch_likely(&fast_misaligned_access_speed_key);
>  }
> +#endif
>
>  unsigned long riscv_get_elf_hwcap(void);
>
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f71910718053..ffba5ecf12c2 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -62,6 +62,9 @@ obj-y +=3D tests/
>  obj-$(CONFIG_MMU) +=3D vdso.o vdso/
>
>  obj-$(CONFIG_RISCV_MISALIGNED) +=3D traps_misaligned.o
> +ifneq ($(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS), y)
> +obj-y  +=3D misaligned_access_speed.o

copy-unaligned.o can also go in here (those are the assembly copy
routines used only by the probing code).

> +endif
>  obj-$(CONFIG_FPU)              +=3D fpu.o
>  obj-$(CONFIG_RISCV_ISA_V)      +=3D vector.o
>  obj-$(CONFIG_RISCV_ISA_V)      +=3D kernel_mode_vector.o
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 89920f84d0a3..319670af5704 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -11,7 +11,6 @@
>  #include <linux/cpu.h>
>  #include <linux/cpuhotplug.h>
>  #include <linux/ctype.h>
> -#include <linux/jump_label.h>
>  #include <linux/log2.h>
>  #include <linux/memory.h>
>  #include <linux/module.h>
> @@ -21,20 +20,12 @@
>  #include <asm/cacheflush.h>
>  #include <asm/cpufeature.h>
>  #include <asm/hwcap.h>
> -#include <asm/hwprobe.h>
>  #include <asm/patch.h>
>  #include <asm/processor.h>
>  #include <asm/vector.h>
>
> -#include "copy-unaligned.h"
> -
>  #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
>
> -#define MISALIGNED_ACCESS_JIFFIES_LG2 1
> -#define MISALIGNED_BUFFER_SIZE 0x4000
> -#define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
> -#define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
> -
>  unsigned long elf_hwcap __read_mostly;
>
>  /* Host ISA bitmap */
> @@ -43,11 +34,6 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __=
read_mostly;
>  /* Per-cpu ISA extensions. */
>  struct riscv_isainfo hart_isa[NR_CPUS];
>
> -/* Performance information */
> -DEFINE_PER_CPU(long, misaligned_access_speed);
> -
> -static cpumask_t fast_misaligned_access;
> -
>  /**
>   * riscv_isa_extension_base() - Get base extension word
>   *
> @@ -706,247 +692,6 @@ unsigned long riscv_get_elf_hwcap(void)
>         return hwcap;
>  }
>
> -static int check_unaligned_access(void *param)
> -{
> -       int cpu =3D smp_processor_id();
> -       u64 start_cycles, end_cycles;
> -       u64 word_cycles;
> -       u64 byte_cycles;
> -       int ratio;
> -       unsigned long start_jiffies, now;
> -       struct page *page =3D param;
> -       void *dst;
> -       void *src;
> -       long speed =3D RISCV_HWPROBE_MISALIGNED_SLOW;
> -
> -       if (check_unaligned_access_emulated(cpu))
> -               return 0;
> -
> -       /* Make an unaligned destination buffer. */
> -       dst =3D (void *)((unsigned long)page_address(page) | 0x1);
> -       /* Unalign src as well, but differently (off by 1 + 2 =3D 3). */
> -       src =3D dst + (MISALIGNED_BUFFER_SIZE / 2);
> -       src +=3D 2;
> -       word_cycles =3D -1ULL;
> -       /* Do a warmup. */
> -       __riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> -       preempt_disable();
> -       start_jiffies =3D jiffies;
> -       while ((now =3D jiffies) =3D=3D start_jiffies)
> -               cpu_relax();
> -
> -       /*
> -        * For a fixed amount of time, repeatedly try the function, and t=
ake
> -        * the best time in cycles as the measurement.
> -        */
> -       while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES=
_LG2))) {
> -               start_cycles =3D get_cycles64();
> -               /* Ensure the CSR read can't reorder WRT to the copy. */
> -               mb();
> -               __riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SI=
ZE);
> -               /* Ensure the copy ends before the end time is snapped. *=
/
> -               mb();
> -               end_cycles =3D get_cycles64();
> -               if ((end_cycles - start_cycles) < word_cycles)
> -                       word_cycles =3D end_cycles - start_cycles;
> -       }
> -
> -       byte_cycles =3D -1ULL;
> -       __riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> -       start_jiffies =3D jiffies;
> -       while ((now =3D jiffies) =3D=3D start_jiffies)
> -               cpu_relax();
> -
> -       while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES=
_LG2))) {
> -               start_cycles =3D get_cycles64();
> -               mb();
> -               __riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SI=
ZE);
> -               mb();
> -               end_cycles =3D get_cycles64();
> -               if ((end_cycles - start_cycles) < byte_cycles)
> -                       byte_cycles =3D end_cycles - start_cycles;
> -       }
> -
> -       preempt_enable();
> -
> -       /* Don't divide by zero. */
> -       if (!word_cycles || !byte_cycles) {
> -               pr_warn("cpu%d: rdtime lacks granularity needed to measur=
e unaligned access speed\n",
> -                       cpu);
> -
> -               return 0;
> -       }
> -
> -       if (word_cycles < byte_cycles)
> -               speed =3D RISCV_HWPROBE_MISALIGNED_FAST;
> -
> -       ratio =3D div_u64((byte_cycles * 100), word_cycles);
> -       pr_info("cpu%d: Ratio of byte access time to unaligned word acces=
s is %d.%02d, unaligned accesses are %s\n",
> -               cpu,
> -               ratio / 100,
> -               ratio % 100,
> -               (speed =3D=3D RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "=
slow");
> -
> -       per_cpu(misaligned_access_speed, cpu) =3D speed;
> -
> -       /*
> -        * Set the value of fast_misaligned_access of a CPU. These operat=
ions
> -        * are atomic to avoid race conditions.
> -        */
> -       if (speed =3D=3D RISCV_HWPROBE_MISALIGNED_FAST)
> -               cpumask_set_cpu(cpu, &fast_misaligned_access);
> -       else
> -               cpumask_clear_cpu(cpu, &fast_misaligned_access);
> -
> -       return 0;
> -}
> -
> -static void check_unaligned_access_nonboot_cpu(void *param)
> -{
> -       unsigned int cpu =3D smp_processor_id();
> -       struct page **pages =3D param;
> -
> -       if (smp_processor_id() !=3D 0)
> -               check_unaligned_access(pages[cpu]);
> -}
> -
> -DEFINE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> -
> -static void modify_unaligned_access_branches(cpumask_t *mask, int weight=
)
> -{
> -       if (cpumask_weight(mask) =3D=3D weight)
> -               static_branch_enable_cpuslocked(&fast_misaligned_access_s=
peed_key);
> -       else
> -               static_branch_disable_cpuslocked(&fast_misaligned_access_=
speed_key);
> -}
> -
> -static void set_unaligned_access_static_branches_except_cpu(int cpu)
> -{
> -       /*
> -        * Same as set_unaligned_access_static_branches, except excludes =
the
> -        * given CPU from the result. When a CPU is hotplugged into an of=
fline
> -        * state, this function is called before the CPU is set to offlin=
e in
> -        * the cpumask, and thus the CPU needs to be explicitly excluded.
> -        */
> -
> -       cpumask_t fast_except_me;
> -
> -       cpumask_and(&fast_except_me, &fast_misaligned_access, cpu_online_=
mask);
> -       cpumask_clear_cpu(cpu, &fast_except_me);
> -
> -       modify_unaligned_access_branches(&fast_except_me, num_online_cpus=
() - 1);
> -}
> -
> -static void set_unaligned_access_static_branches(void)
> -{
> -       /*
> -        * This will be called after check_unaligned_access_all_cpus so t=
he
> -        * result of unaligned access speed for all CPUs will be availabl=
e.
> -        *
> -        * To avoid the number of online cpus changing between reading
> -        * cpu_online_mask and calling num_online_cpus, cpus_read_lock mu=
st be
> -        * held before calling this function.
> -        */
> -
> -       cpumask_t fast_and_online;
> -
> -       cpumask_and(&fast_and_online, &fast_misaligned_access, cpu_online=
_mask);
> -
> -       modify_unaligned_access_branches(&fast_and_online, num_online_cpu=
s());
> -}
> -
> -static int lock_and_set_unaligned_access_static_branch(void)
> -{
> -       cpus_read_lock();
> -       set_unaligned_access_static_branches();
> -       cpus_read_unlock();
> -
> -       return 0;
> -}
> -
> -arch_initcall_sync(lock_and_set_unaligned_access_static_branch);
> -
> -static int riscv_online_cpu(unsigned int cpu)
> -{
> -       static struct page *buf;
> -
> -       /* We are already set since the last check */
> -       if (per_cpu(misaligned_access_speed, cpu) !=3D RISCV_HWPROBE_MISA=
LIGNED_UNKNOWN)
> -               goto exit;
> -
> -       buf =3D alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> -       if (!buf) {
> -               pr_warn("Allocation failure, not measuring misaligned per=
formance\n");
> -               return -ENOMEM;
> -       }
> -
> -       check_unaligned_access(buf);
> -       __free_pages(buf, MISALIGNED_BUFFER_ORDER);
> -
> -exit:
> -       set_unaligned_access_static_branches();
> -
> -       return 0;
> -}
> -
> -static int riscv_offline_cpu(unsigned int cpu)
> -{
> -       set_unaligned_access_static_branches_except_cpu(cpu);
> -
> -       return 0;
> -}
> -
> -/* Measure unaligned access on all CPUs present at boot in parallel. */
> -static int check_unaligned_access_all_cpus(void)
> -{
> -       unsigned int cpu;
> -       unsigned int cpu_count =3D num_possible_cpus();
> -       struct page **bufs =3D kzalloc(cpu_count * sizeof(struct page *),
> -                                    GFP_KERNEL);
> -
> -       if (!bufs) {
> -               pr_warn("Allocation failure, not measuring misaligned per=
formance\n");
> -               return 0;
> -       }
> -
> -       /*
> -        * Allocate separate buffers for each CPU so there's no fighting =
over
> -        * cache lines.
> -        */
> -       for_each_cpu(cpu, cpu_online_mask) {
> -               bufs[cpu] =3D alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_O=
RDER);
> -               if (!bufs[cpu]) {
> -                       pr_warn("Allocation failure, not measuring misali=
gned performance\n");
> -                       goto out;
> -               }
> -       }
> -
> -       /* Check everybody except 0, who stays behind to tend jiffies. */
> -       on_each_cpu(check_unaligned_access_nonboot_cpu, bufs, 1);
> -
> -       /* Check core 0. */
> -       smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
> -
> -       /*
> -        * Setup hotplug callbacks for any new CPUs that come online or g=
o
> -        * offline.
> -        */
> -       cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
> -                                 riscv_online_cpu, riscv_offline_cpu);
> -
> -out:
> -       unaligned_emulation_finish();
> -       for_each_cpu(cpu, cpu_online_mask) {
> -               if (bufs[cpu])
> -                       __free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
> -       }
> -
> -       kfree(bufs);
> -       return 0;
> -}
> -
> -arch_initcall(check_unaligned_access_all_cpus);
> -
>  void riscv_user_isa_enable(void)
>  {
>         if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_IS=
A_EXT_ZICBOZ))
> diff --git a/arch/riscv/kernel/misaligned_access_speed.c b/arch/riscv/ker=
nel/misaligned_access_speed.c
> new file mode 100644
> index 000000000000..b725c07dd1af
> --- /dev/null
> +++ b/arch/riscv/kernel/misaligned_access_speed.c
> @@ -0,0 +1,265 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2024 Rivos Inc.
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/jump_label.h>
> +#include <linux/mm.h>
> +#include <linux/smp.h>
> +#include <linux/types.h>
> +#include <asm/cpufeature.h>
> +#include <asm/hwprobe.h>
> +
> +#include "copy-unaligned.h"
> +
> +#define MISALIGNED_ACCESS_JIFFIES_LG2 1
> +#define MISALIGNED_BUFFER_SIZE 0x4000
> +#define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
> +#define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
> +
> +DEFINE_PER_CPU(long, misaligned_access_speed);
> +
> +static cpumask_t fast_misaligned_access;
> +
> +static int check_unaligned_access(void *param)
> +{
> +       int cpu =3D smp_processor_id();
> +       u64 start_cycles, end_cycles;
> +       u64 word_cycles;
> +       u64 byte_cycles;
> +       int ratio;
> +       unsigned long start_jiffies, now;
> +       struct page *page =3D param;
> +       void *dst;
> +       void *src;
> +       long speed =3D RISCV_HWPROBE_MISALIGNED_SLOW;
> +
> +       if (check_unaligned_access_emulated(cpu))
> +               return 0;
> +
> +       /* Make an unaligned destination buffer. */
> +       dst =3D (void *)((unsigned long)page_address(page) | 0x1);
> +       /* Unalign src as well, but differently (off by 1 + 2 =3D 3). */
> +       src =3D dst + (MISALIGNED_BUFFER_SIZE / 2);
> +       src +=3D 2;
> +       word_cycles =3D -1ULL;
> +       /* Do a warmup. */
> +       __riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> +       preempt_disable();
> +       start_jiffies =3D jiffies;
> +       while ((now =3D jiffies) =3D=3D start_jiffies)
> +               cpu_relax();
> +
> +       /*
> +        * For a fixed amount of time, repeatedly try the function, and t=
ake
> +        * the best time in cycles as the measurement.
> +        */
> +       while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES=
_LG2))) {
> +               start_cycles =3D get_cycles64();
> +               /* Ensure the CSR read can't reorder WRT to the copy. */
> +               mb();
> +               __riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SI=
ZE);
> +               /* Ensure the copy ends before the end time is snapped. *=
/
> +               mb();
> +               end_cycles =3D get_cycles64();
> +               if ((end_cycles - start_cycles) < word_cycles)
> +                       word_cycles =3D end_cycles - start_cycles;
> +       }
> +
> +       byte_cycles =3D -1ULL;
> +       __riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
> +       start_jiffies =3D jiffies;
> +       while ((now =3D jiffies) =3D=3D start_jiffies)
> +               cpu_relax();
> +
> +       while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES=
_LG2))) {
> +               start_cycles =3D get_cycles64();
> +               mb();
> +               __riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SI=
ZE);
> +               mb();
> +               end_cycles =3D get_cycles64();
> +               if ((end_cycles - start_cycles) < byte_cycles)
> +                       byte_cycles =3D end_cycles - start_cycles;
> +       }
> +
> +       preempt_enable();
> +
> +       /* Don't divide by zero. */
> +       if (!word_cycles || !byte_cycles) {
> +               pr_warn("cpu%d: rdtime lacks granularity needed to measur=
e unaligned access speed\n",
> +                       cpu);
> +
> +               return 0;
> +       }
> +
> +       if (word_cycles < byte_cycles)
> +               speed =3D RISCV_HWPROBE_MISALIGNED_FAST;
> +
> +       ratio =3D div_u64((byte_cycles * 100), word_cycles);
> +       pr_info("cpu%d: Ratio of byte access time to unaligned word acces=
s is %d.%02d, unaligned accesses are %s\n",
> +               cpu,
> +               ratio / 100,
> +               ratio % 100,
> +               (speed =3D=3D RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "=
slow");
> +
> +       per_cpu(misaligned_access_speed, cpu) =3D speed;
> +
> +       /*
> +        * Set the value of fast_misaligned_access of a CPU. These operat=
ions
> +        * are atomic to avoid race conditions.
> +        */
> +       if (speed =3D=3D RISCV_HWPROBE_MISALIGNED_FAST)
> +               cpumask_set_cpu(cpu, &fast_misaligned_access);
> +       else
> +               cpumask_clear_cpu(cpu, &fast_misaligned_access);
> +
> +       return 0;
> +}
> +
> +static void check_unaligned_access_nonboot_cpu(void *param)
> +{
> +       unsigned int cpu =3D smp_processor_id();
> +       struct page **pages =3D param;
> +
> +       if (smp_processor_id() !=3D 0)
> +               check_unaligned_access(pages[cpu]);
> +}
> +
> +DEFINE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> +
> +static void modify_unaligned_access_branches(cpumask_t *mask, int weight=
)
> +{
> +       if (cpumask_weight(mask) =3D=3D weight)
> +               static_branch_enable_cpuslocked(&fast_misaligned_access_s=
peed_key);
> +       else
> +               static_branch_disable_cpuslocked(&fast_misaligned_access_=
speed_key);
> +}
> +
> +static void set_unaligned_access_static_branches_except_cpu(int cpu)
> +{
> +       /*
> +        * Same as set_unaligned_access_static_branches, except excludes =
the
> +        * given CPU from the result. When a CPU is hotplugged into an of=
fline
> +        * state, this function is called before the CPU is set to offlin=
e in
> +        * the cpumask, and thus the CPU needs to be explicitly excluded.
> +        */
> +
> +       cpumask_t fast_except_me;
> +
> +       cpumask_and(&fast_except_me, &fast_misaligned_access, cpu_online_=
mask);
> +       cpumask_clear_cpu(cpu, &fast_except_me);
> +
> +       modify_unaligned_access_branches(&fast_except_me, num_online_cpus=
() - 1);
> +}
> +
> +static void set_unaligned_access_static_branches(void)
> +{
> +       /*
> +        * This will be called after check_unaligned_access_all_cpus so t=
he
> +        * result of unaligned access speed for all CPUs will be availabl=
e.
> +        *
> +        * To avoid the number of online cpus changing between reading
> +        * cpu_online_mask and calling num_online_cpus, cpus_read_lock mu=
st be
> +        * held before calling this function.
> +        */
> +
> +       cpumask_t fast_and_online;
> +
> +       cpumask_and(&fast_and_online, &fast_misaligned_access, cpu_online=
_mask);
> +
> +       modify_unaligned_access_branches(&fast_and_online, num_online_cpu=
s());
> +}
> +
> +static int lock_and_set_unaligned_access_static_branch(void)
> +{
> +       cpus_read_lock();
> +       set_unaligned_access_static_branches();
> +       cpus_read_unlock();
> +
> +       return 0;
> +}
> +
> +arch_initcall_sync(lock_and_set_unaligned_access_static_branch);
> +
> +static int riscv_online_cpu(unsigned int cpu)
> +{
> +       static struct page *buf;
> +
> +       /* We are already set since the last check */
> +       if (per_cpu(misaligned_access_speed, cpu) !=3D RISCV_HWPROBE_MISA=
LIGNED_UNKNOWN)
> +               goto exit;
> +
> +       buf =3D alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> +       if (!buf) {
> +               pr_warn("Allocation failure, not measuring misaligned per=
formance\n");
> +               return -ENOMEM;
> +       }
> +
> +       check_unaligned_access(buf);
> +       __free_pages(buf, MISALIGNED_BUFFER_ORDER);
> +
> +exit:
> +       set_unaligned_access_static_branches();
> +
> +       return 0;
> +}
> +
> +static int riscv_offline_cpu(unsigned int cpu)
> +{
> +       set_unaligned_access_static_branches_except_cpu(cpu);
> +
> +       return 0;
> +}
> +
> +/* Measure unaligned access on all CPUs present at boot in parallel. */
> +static int check_unaligned_access_all_cpus(void)
> +{
> +       unsigned int cpu;
> +       unsigned int cpu_count =3D num_possible_cpus();
> +       struct page **bufs =3D kzalloc(cpu_count * sizeof(struct page *),
> +                                    GFP_KERNEL);
> +
> +       if (!bufs) {
> +               pr_warn("Allocation failure, not measuring misaligned per=
formance\n");
> +               return 0;
> +       }
> +
> +       /*
> +        * Allocate separate buffers for each CPU so there's no fighting =
over
> +        * cache lines.
> +        */
> +       for_each_cpu(cpu, cpu_online_mask) {
> +               bufs[cpu] =3D alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_O=
RDER);
> +               if (!bufs[cpu]) {
> +                       pr_warn("Allocation failure, not measuring misali=
gned performance\n");
> +                       goto out;
> +               }
> +       }
> +
> +       /* Check everybody except 0, who stays behind to tend jiffies. */
> +       on_each_cpu(check_unaligned_access_nonboot_cpu, bufs, 1);
> +
> +       /* Check core 0. */
> +       smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
> +
> +       /*
> +        * Setup hotplug callbacks for any new CPUs that come online or g=
o
> +        * offline.
> +        */
> +       cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
> +                                 riscv_online_cpu, riscv_offline_cpu);
> +
> +out:
> +       unaligned_emulation_finish();
> +       for_each_cpu(cpu, cpu_online_mask) {
> +               if (bufs[cpu])
> +                       __free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
> +       }
> +
> +       kfree(bufs);
> +       return 0;
> +}
> +
> +arch_initcall(check_unaligned_access_all_cpus);
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwpr=
obe.c
> index a7c56b41efd2..d9bd24776a3e 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -149,6 +149,9 @@ static bool hwprobe_ext0_has(const struct cpumask *cp=
us, unsigned long ext)
>
>  static u64 hwprobe_misaligned(const struct cpumask *cpus)
>  {
> +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> +       return RISCV_HWPROBE_MISALIGNED_FAST;
> +#else

Ok, two nits, this is a little clunky with the ifdef inside the
function body. The pattern I see more often is the ifdef/else each
containing a separate function definition. That would work nicely
here.

>         int cpu;
>         u64 perf =3D -1ULL;
>
> @@ -168,6 +171,7 @@ static u64 hwprobe_misaligned(const struct cpumask *c=
pus)
>                 return RISCV_HWPROBE_MISALIGNED_UNKNOWN;
>
>         return perf;
> +#endif
>  }
>
>  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>
> --
> 2.43.0
>

