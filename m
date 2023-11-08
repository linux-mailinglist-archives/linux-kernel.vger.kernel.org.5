Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AEA7E57DA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344712AbjKHNNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344700AbjKHNM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:12:58 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4918C1BFD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 05:12:56 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-4ac71c558baso1095423e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 05:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699449175; x=1700053975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ft6eZ7gdvNdoX8zWgCy+9HBlTTXU2ZG2Rqwy96S/LbY=;
        b=hql2qRjX/BeCoqTbXF1D0xq5Ol+5tdHzILgKrr2wEVLg9zebO7pxVL9/HTDox1Cvdw
         +7T8rjDErBxAc5GEsJnJEmyul8e+lXznqrpijQuHfwkbtBk08JcnYsB0G2b0D0hNlx/1
         mOsUwA1akyp+i4vHzPMbY5MMd4+78Hqx7xao8E+aB7MEeBp/X5Y8cDExvbtg8llcjvW1
         1tIFh6F0bNkhxlyV2ZOQei1JRZsjuej5ZTdZBRtwZadcVPQqWYjGYotvDHgKbgI5pKUQ
         WHuj8qAp2q82zysKtjYpe82cUz635ipJcnBkv973RlK8V40qSPBYNw+VVN35c1RvtwF0
         IKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699449175; x=1700053975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ft6eZ7gdvNdoX8zWgCy+9HBlTTXU2ZG2Rqwy96S/LbY=;
        b=ovYlD/C7cM+kzohqA6jmYCtFBfcioIeFW4DTc9tTpx4+ckxZMoTYuq7AKNBXVOg7M8
         XBUz/Sfm+PHnLT33LiWA6CKBzclJ+fX3PtfHR/WPJWceHxap4N3muKYtIw0TEkHuB0WU
         N4C34eSG7jmBIuOREnOhZogvxr+/0ejtLvHq415ou7dkIeRqcj0ybYoum3bZmPjrlD8J
         23607+Ejf3IosFYlVacCOUE4wYLmaIEGGvdDOfPNrGB4/b/v2VGI2AGLG8jqeosFEjjn
         O+h1Ay+W/55t3Gef6pohL+8UdEONCNVfVpeDlv18XLN9WzEY//bRRlpC3dNUMIA1zTNn
         6Idw==
X-Gm-Message-State: AOJu0YzxzWP+y9qOpu9q1pugVpSga/PCFM+06Bi5T1OUQY3NxazeuoA8
        QnvtgsZbhfhH6NmBI0JeWf/R9K8KvTX7ednchg8=
X-Google-Smtp-Source: AGHT+IGnNKiNfLM7gSd9tpJTMtrPx7MGpLQC/Nnecax5MydayZ6xY9XvkwIZEEoSNkBj2PAjYKc48smVJ/kWIrB5PY4=
X-Received: by 2002:a1f:9c0d:0:b0:49a:9a34:ec40 with SMTP id
 f13-20020a1f9c0d000000b0049a9a34ec40mr1439708vke.2.1699449175113; Wed, 08 Nov
 2023 05:12:55 -0800 (PST)
MIME-Version: 1.0
References: <20231026084010.11888-1-alexghiti@rivosinc.com>
In-Reply-To: <20231026084010.11888-1-alexghiti@rivosinc.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 8 Nov 2023 13:12:20 +0000
Message-ID: <CA+V-a8tZLZV5vnoZNhXO7OSURv8xH9mSzMpZMYfmaLaAct6=9Q@mail.gmail.com>
Subject: Re: [PATCH -fixes v2] drivers: perf: Do not broadcast to other cpus
 when starting a counter
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        Yu Chien Peter Lin <peterlin@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 9:41=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> This command:
>
> $ perf record -e cycles:k -e instructions:k -c 10000 -m 64M dd if=3D/dev/=
zero of=3D/dev/null count=3D1000
>
> gives rise to this kernel warning:
>
> [  444.364395] WARNING: CPU: 0 PID: 104 at kernel/smp.c:775 smp_call_func=
tion_many_cond+0x42c/0x436
> [  444.364515] Modules linked in:
> [  444.364657] CPU: 0 PID: 104 Comm: perf-exec Not tainted 6.6.0-rc6-0005=
1-g391df82e8ec3-dirty #73
> [  444.364771] Hardware name: riscv-virtio,qemu (DT)
> [  444.364868] epc : smp_call_function_many_cond+0x42c/0x436
> [  444.364917]  ra : on_each_cpu_cond_mask+0x20/0x32
> [  444.364948] epc : ffffffff8009f9e0 ra : ffffffff8009fa5a sp : ff200000=
00003800
> [  444.364966]  gp : ffffffff81500aa0 tp : ff60000002b83000 t0 : ff200000=
000038c0
> [  444.364982]  t1 : ffffffff815021f0 t2 : 000000000000001f s0 : ff200000=
000038b0
> [  444.364998]  s1 : ff60000002c54d98 a0 : ff60000002a73940 a1 : 00000000=
00000000
> [  444.365013]  a2 : 0000000000000000 a3 : 0000000000000003 a4 : 00000000=
00000100
> [  444.365029]  a5 : 0000000000010100 a6 : 0000000000f00000 a7 : 00000000=
00000000
> [  444.365044]  s2 : 0000000000000000 s3 : ffffffffffffffff s4 : ff600000=
02c54d98
> [  444.365060]  s5 : ffffffff81539610 s6 : ffffffff80c20c48 s7 : 00000000=
00000000
> [  444.365075]  s8 : 0000000000000000 s9 : 0000000000000001 s10: 00000000=
00000001
> [  444.365090]  s11: ffffffff80099394 t3 : 0000000000000003 t4 : 00000000=
eac0c6e6
> [  444.365104]  t5 : 0000000400000000 t6 : ff60000002e010d0
> [  444.365120] status: 0000000200000100 badaddr: 0000000000000000 cause: =
0000000000000003
> [  444.365226] [<ffffffff8009f9e0>] smp_call_function_many_cond+0x42c/0x4=
36
> [  444.365295] [<ffffffff8009fa5a>] on_each_cpu_cond_mask+0x20/0x32
> [  444.365311] [<ffffffff806e90dc>] pmu_sbi_ctr_start+0x7a/0xaa
> [  444.365327] [<ffffffff806e880c>] riscv_pmu_start+0x48/0x66
> [  444.365339] [<ffffffff8012111a>] perf_adjust_freq_unthr_context+0x196/=
0x1ac
> [  444.365356] [<ffffffff801237aa>] perf_event_task_tick+0x78/0x8c
> [  444.365368] [<ffffffff8003faf4>] scheduler_tick+0xe6/0x25e
> [  444.365383] [<ffffffff8008a042>] update_process_times+0x80/0x96
> [  444.365398] [<ffffffff800991ec>] tick_sched_handle+0x26/0x52
> [  444.365410] [<ffffffff800993e4>] tick_sched_timer+0x50/0x98
> [  444.365422] [<ffffffff8008a6aa>] __hrtimer_run_queues+0x126/0x18a
> [  444.365433] [<ffffffff8008b350>] hrtimer_interrupt+0xce/0x1da
> [  444.365444] [<ffffffff806cdc60>] riscv_timer_interrupt+0x30/0x3a
> [  444.365457] [<ffffffff8006afa6>] handle_percpu_devid_irq+0x80/0x114
> [  444.365470] [<ffffffff80065b82>] generic_handle_domain_irq+0x1c/0x2a
> [  444.365483] [<ffffffff8045faec>] riscv_intc_irq+0x2e/0x46
> [  444.365497] [<ffffffff808a9c62>] handle_riscv_irq+0x4a/0x74
> [  444.365521] [<ffffffff808aa760>] do_irq+0x7c/0x7e
> [  444.365796] ---[ end trace 0000000000000000 ]---
>
> That's because the fix in commit 3fec323339a4 ("drivers: perf: Fix panic
> in riscv SBI mmap support") was wrong since there is no need to broadcast
> to other cpus when starting a counter, that's only needed in mmap when
> the counters could have already been started on other cpus, so simply
> remove this broadcast.
>
> Fixes: 3fec323339a4 ("drivers: perf: Fix panic in riscv SBI mmap support"=
)
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Tested-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> Tested-by: Yu Chien Peter Lin <peterlin@andestech.com>
> ---
>
> Changes in v2:
> - Fix wrong usage of pmu_sbi_set_scounteren in pmu_sbi_ctr_stop, as
>   noticed by Peter Lin
> - Add TB from Peter Lin
>
>  drivers/perf/riscv_pmu_sbi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> #On
RZ/FIve SMARC EVK

Cheers,
Prabhakar

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 96c7f670c8f0..fcb0c70ca222 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -543,8 +543,7 @@ static void pmu_sbi_ctr_start(struct perf_event *even=
t, u64 ival)
>
>         if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
>             (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
> -               on_each_cpu_mask(mm_cpumask(event->owner->mm),
> -                                pmu_sbi_set_scounteren, (void *)event, 1=
);
> +               pmu_sbi_set_scounteren((void *)event);
>  }
>
>  static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long fla=
g)
> @@ -554,8 +553,7 @@ static void pmu_sbi_ctr_stop(struct perf_event *event=
, unsigned long flag)
>
>         if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
>             (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
> -               on_each_cpu_mask(mm_cpumask(event->owner->mm),
> -                                pmu_sbi_reset_scounteren, (void *)event,=
 1);
> +               pmu_sbi_reset_scounteren((void *)event);
>
>         ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hwc->idx=
, 1, flag, 0, 0, 0);
>         if (ret.error && (ret.error !=3D SBI_ERR_ALREADY_STOPPED) &&
> --
> 2.39.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
