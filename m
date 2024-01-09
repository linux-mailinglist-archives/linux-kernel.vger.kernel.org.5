Return-Path: <linux-kernel+bounces-20257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 611AF827C83
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6811C23281
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6347433D1;
	Tue,  9 Jan 2024 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="L+8HPM0D"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B36F28EA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ccabf5a4beso26007661fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 17:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1704763226; x=1705368026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRNThla9dE7okdHgbc/oADJzrO50EI9cuBd5igULT7w=;
        b=L+8HPM0DEPYnXSHr4FTp1BCOTM1cU/EKwAK9qKOJskbXb+LJfgKJKiaJnu0HmHuNqu
         AndP+HEdFwLRQUkl8AM+oA1ULcDYeeLQuiDv1SZgR8EbYVboxLSLNfgToPD+rJK5riMG
         75Zib60nLjKlWRUI9qOQfCDbhQ23XuXtWIRCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704763226; x=1705368026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRNThla9dE7okdHgbc/oADJzrO50EI9cuBd5igULT7w=;
        b=vvnC0iZNNGqirZCwojmW6BdmjQBEzJ2WQKF8ftMhy3JJDkHT76xqdazmyu18z0yUQe
         yNYmhEWI6ArTjSW/dnBRignqdPG+I7nrCGVahNBLllQ9ei+non2dTLi524scX9ui0Bqp
         lIywlMznZ+rhXgl234PfY6UuOl8lCik/6uS3xEPLgG1WgWnO5LgZRMy/6uxVbMQ4JucK
         3kh3aMPu5qmTo9Fcz6nzxxRrQ7/mYYEtjmIOsyX1/bVKZ0cjxODDT4Cv6AVaOMhqAV+3
         Bp7d3IhJyXX5xRuUDYAnjiahXqBJ5h+ekjrQxYen1af3hC8HT5Ht+S6HFCy1E3c5lNSf
         pQcQ==
X-Gm-Message-State: AOJu0Yw4Ki1sdXndtVt9nTvicIt4N85Ra3Z6LGRL9z1/vz2S/E4tdMD4
	peHnNEtW68OFpZDbBUPZ2ng2P1jqzJMfd6Dp3QCAtXpaVDvb
X-Google-Smtp-Source: AGHT+IHQb+aVi+doGRwAzvkU45dgBN2rDom8PDmrFWmOye5QUxxmfgzgt3hbnTOF1OiApo7QKDAwqXd0ppWTSD5W7/A=
X-Received: by 2002:a2e:87c4:0:b0:2cd:db4:e438 with SMTP id
 v4-20020a2e87c4000000b002cd0db4e438mr909560ljj.76.1704763225826; Mon, 08 Jan
 2024 17:20:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108-fencei-v5-0-aa1e51d7222f@rivosinc.com> <20240108-fencei-v5-1-aa1e51d7222f@rivosinc.com>
In-Reply-To: <20240108-fencei-v5-1-aa1e51d7222f@rivosinc.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Mon, 8 Jan 2024 17:20:14 -0800
Message-ID: <CAOnJCUL=Q6xkxJRehJzzE5roxx7PyupzDKVw8Q7UuY1RF=HgcQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] riscv: Include riscv_set_icache_flush_ctx prctl
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>, 
	Conor Dooley <conor.dooley@microchip.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 10:42=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> Support new prctl with key PR_RISCV_SET_ICACHE_FLUSH_CTX to enable
> optimization of cross modifying code. This prctl enables userspace code
> to use icache flushing instructions such as fence.i with the guarantee
> that the icache will continue to be clean after thread migration.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/mmu.h       |  2 ++
>  arch/riscv/include/asm/processor.h |  6 ++++
>  arch/riscv/mm/cacheflush.c         | 56 ++++++++++++++++++++++++++++++++=
++++++
>  arch/riscv/mm/context.c            |  8 ++++--
>  include/uapi/linux/prctl.h         |  4 +++
>  kernel/sys.c                       |  6 ++++
>  6 files changed, 79 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
> index 355504b37f8e..60be458e94da 100644
> --- a/arch/riscv/include/asm/mmu.h
> +++ b/arch/riscv/include/asm/mmu.h
> @@ -19,6 +19,8 @@ typedef struct {
>  #ifdef CONFIG_SMP
>         /* A local icache flush is needed before user execution can resum=
e. */
>         cpumask_t icache_stale_mask;
> +       /* Force local icache flush on all migrations. */
> +       bool force_icache_flush;
>  #endif
>  #ifdef CONFIG_BINFMT_ELF_FDPIC
>         unsigned long exec_fdpic_loadmap;
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/=
processor.h
> index f19f861cda54..7eda6c75e0f2 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -84,6 +84,9 @@ struct thread_struct {
>         unsigned long vstate_ctrl;
>         struct __riscv_v_ext_state vstate;
>         unsigned long align_ctl;
> +#ifdef CONFIG_SMP
> +       bool force_icache_flush;
> +#endif
>  };
>
>  /* Whitelist the fstate from the task_struct for hardened usercopy */
> @@ -145,6 +148,9 @@ extern int set_unalign_ctl(struct task_struct *tsk, u=
nsigned int val);
>  #define GET_UNALIGN_CTL(tsk, addr)     get_unalign_ctl((tsk), (addr))
>  #define SET_UNALIGN_CTL(tsk, val)      set_unalign_ctl((tsk), (val))
>
> +#define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2) riscv_set_icache_flush_ct=
x(arg1, arg2)
> +extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long p=
er_thread);
> +
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* _ASM_RISCV_PROCESSOR_H */
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 55a34f2020a8..a647b8abbe37 100644
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
> @@ -152,3 +153,58 @@ void __init riscv_init_cbo_blocksizes(void)
>         if (cboz_block_size)
>                 riscv_cboz_block_size =3D cboz_block_size;
>  }
> +
> +/**
> + * riscv_set_icache_flush_ctx() - Enable/disable icache flushing instruc=
tions in userspace.
> + * @ctx: Set the type of icache flushing instructions permitted/prohibit=
ed.
> + *
> + * * %PR_RISCV_CTX_SW_FENCEI_ON: Allow fence.i in userspace.
> + *
> + * * %PR_RISCV_CTX_SW_FENCEI_OFF: Disallow fence.i in userspace. When
> + *   ``per_thread =3D=3D 0``, this will effect all threads in a process.=
 Therefore,
> + *   caution must be taken -- only use this flag when you can guarantee =
that no
> + *   thread in the process will emit fence.i from this point onward.
> + *
> + * @per_thread: When set to 0, will perform operation on process migrati=
on. When
> + *  set to 1, will perform operation on thread migration.
> + *
> + * When ``per_thread =3D=3D 0``, all threads in the process are permitte=
d to emit
> + * icache flushing instructions. Whenever any thread in the process is m=
igrated,
> + * the corresponding hart's icache will be guaranteed to be consistent w=
ith
> + * instruction storage. Note this does not enforce any guarantees outsid=
e of
> + * migration. If a thread modifies an instruction that another thread ma=
y
> + * attempt to execute, the other thread must still emit an icache flushi=
ng
> + * instruction before attempting to execute the potentially modified
> + * instruction. This must be performed by the userspace program.
> + *
> + * In per-thread context (eg. ``per_thread =3D=3D 1``), only the thread =
calling this
> + * function is permitted to emit icache flushing instructions. When the =
thread
> + * is migrated, the corresponding hart's icache will be guaranteed to be
> + * consistent with instruction storage.
> + *
> + * On kernels configured without SMP, this function is a nop as migratio=
ns
> + * across harts will not occur.
> + */
> +int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thre=
ad)
> +{
> +#ifdef CONFIG_SMP
> +       switch (ctx) {
> +       case PR_RISCV_CTX_SW_FENCEI_ON:
> +               if (per_thread)
> +                       current->thread.force_icache_flush =3D true;
> +               else
> +                       current->mm->context.force_icache_flush =3D true;
> +               break;
> +       case PR_RISCV_CTX_SW_FENCEI_OFF:
> +               if (per_thread)
> +                       current->thread.force_icache_flush =3D false;
> +               else
> +                       current->mm->context.force_icache_flush =3D false=
;
> +               break;
> +
> +       default:
> +               break;
> +       }
> +#endif
> +       return 0;
> +}
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 217fd4de6134..0146c61be0ab 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -297,12 +297,14 @@ static inline void set_mm(struct mm_struct *prev,
>   *
>   * The "cpu" argument must be the current local CPU number.
>   */
> -static inline void flush_icache_deferred(struct mm_struct *mm, unsigned =
int cpu)
> +static inline void flush_icache_deferred(struct mm_struct *mm, unsigned =
int cpu,
> +                                        struct task_struct *task)
>  {
>  #ifdef CONFIG_SMP
>         cpumask_t *mask =3D &mm->context.icache_stale_mask;
>
> -       if (cpumask_test_cpu(cpu, mask)) {
> +       if (cpumask_test_cpu(cpu, mask) || mm->context.force_icache_flush=
 ||
> +           (task && task->thread.force_icache_flush)) {
>                 cpumask_clear_cpu(cpu, mask);
>                 /*
>                  * Ensure the remote hart's writes are visible to this ha=
rt.
> @@ -332,5 +334,5 @@ void switch_mm(struct mm_struct *prev, struct mm_stru=
ct *next,
>
>         set_mm(prev, next, cpu);
>
> -       flush_icache_deferred(next, cpu);
> +       flush_icache_deferred(next, cpu, task);
>  }
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 370ed14b1ae0..ec731dda5b8e 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -306,4 +306,8 @@ struct prctl_mm_map {
>  # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK      0xc
>  # define PR_RISCV_V_VSTATE_CTRL_MASK           0x1f
>
> +#define PR_RISCV_SET_ICACHE_FLUSH_CTX  71
> +# define PR_RISCV_CTX_SW_FENCEI_ON     0
> +# define PR_RISCV_CTX_SW_FENCEI_OFF    1
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 420d9cb9cc8e..e806a8a67c36 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -146,6 +146,9 @@
>  #ifndef RISCV_V_GET_CONTROL
>  # define RISCV_V_GET_CONTROL()         (-EINVAL)
>  #endif
> +#ifndef RISCV_SET_ICACHE_FLUSH_CTX
> +# define RISCV_SET_ICACHE_FLUSH_CTX(a, b)      (-EINVAL)
> +#endif
>
>  /*
>   * this is where the system-wide overflow UID and GID are defined, for
> @@ -2739,6 +2742,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, =
arg2, unsigned long, arg3,
>         case PR_RISCV_V_GET_CONTROL:
>                 error =3D RISCV_V_GET_CONTROL();
>                 break;
> +       case PR_RISCV_SET_ICACHE_FLUSH_CTX:
> +               error =3D RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
> +               break;
>         default:
>                 error =3D -EINVAL;
>                 break;
>
> --
> 2.43.0
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>
--=20
Regards,
Atish

