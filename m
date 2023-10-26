Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17F97D7D97
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344194AbjJZH1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZH1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:27:30 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CFFD6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:27:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32da7ac5c4fso367948f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698305246; x=1698910046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GOVyAsfG7jyBY4Njn7QBJ3pGHQUz5eCfU/o5ji0p3w=;
        b=zNfvakJN/J8EEASt+MaXcxUwuJcdLEI+ANv08gAzz/j5iPcajReCPvRFZYVtHtzWfm
         W2G4WNiK2nad/7Qw7WfJGJPexKUg1gD2MCWh1CB1rEE4NRDnBHPbfD+3SADrN5cEm0yL
         ZGboc+vlRhatSc9bW7FOSQaYViknQcBP7jBcGVUQMD/EsK+RW7O9Tpb+6cV0HeHrVpdw
         sIHGqPQc7CMV3iTXSnu7iZRfrCIx2tHpEIVo7eJfvhXh7eFYb8m84LZxML4GFaT1909e
         NjnDNTXq23IDmE5aW9vYk7GH/s61g1UVnWMJIlGfTsgRpS8FIb0kOqWKEwEehuGEcrX7
         FTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698305246; x=1698910046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GOVyAsfG7jyBY4Njn7QBJ3pGHQUz5eCfU/o5ji0p3w=;
        b=JtaCYTMm40FScwqlcF7EThj18lEH6GSnkPS8bFJjdSMbcoEXBPdSu+IClQE0XEN4/O
         e6q8gFq6MJwIq8zjiVGQFDuJ/lZNz05OrxomI33UyGphQYiFEs0bjUyBZRIUjjZWZiw0
         SPz/muJMqLkVL6NRJ8Pu5P/W5Oh/UybZupEjGR5zjHIGxDxY9EnMXJDRlLZE/HT+jOAj
         PbefhOwx2jKcC/96m55/fA/wqGGK+f7xuLLV76Dp1N5/DTORKf32rdZko2BzHu477DVK
         vmVCf09/RH3Aas7aQHX354hlHEYSduP4hveh0sdEm8pWp9HCXm8N1VZYZv71kbHuEjqE
         cxag==
X-Gm-Message-State: AOJu0YyeOsamYXtvAOb24OJ8l9SaDg7zIrxqWZaRgux4QytJWewJbn4d
        nbi/QGKlZci2z8Qgf5YWHDobSfMllGIbWdMP9wvYFA==
X-Google-Smtp-Source: AGHT+IGcD4kUEe5cN8KBNRsyJYWN+TZDSQzD4DKU1/Ul1fXsRYwZ+nlpfuoSa2vFns2pV4IgtbymsZIv7KJCJBusajc=
X-Received: by 2002:a5d:4bd0:0:b0:32d:9cf7:77e1 with SMTP id
 l16-20020a5d4bd0000000b0032d9cf777e1mr14476070wrt.9.1698305245901; Thu, 26
 Oct 2023 00:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231022144220.109469-1-alexghiti@rivosinc.com> <ZTXPXXjULgqikXjF@APC323>
In-Reply-To: <ZTXPXXjULgqikXjF@APC323>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 26 Oct 2023 09:27:15 +0200
Message-ID: <CAHVXubji94pU-=wYBiLnCFtdyiMvgTyzSGS9qqecYhsOuuxhww@mail.gmail.com>
Subject: Re: [PATCH -fixes] drivers: perf: Do not broadcast to other cpus when
 starting a counter
To:     Yu-Chien Peter Lin <peterlin@andestech.com>
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
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter Lin,

On Mon, Oct 23, 2023 at 3:42=E2=80=AFAM Yu-Chien Peter Lin
<peterlin@andestech.com> wrote:
>
> Hi Alexandre,
>
> On Sun, Oct 22, 2023 at 04:42:20PM +0200, Alexandre Ghiti wrote:
> > This command:
> >
> > $ perf record -e cycles:k -e instructions:k -c 10000 -m 64M dd if=3D/de=
v/zero of=3D/dev/null count=3D1000
> >
> > gives rise to this kernel warning:
> >
> > [  444.364395] WARNING: CPU: 0 PID: 104 at kernel/smp.c:775 smp_call_fu=
nction_many_cond+0x42c/0x436
> > [  444.364515] Modules linked in:
> > [  444.364657] CPU: 0 PID: 104 Comm: perf-exec Not tainted 6.6.0-rc6-00=
051-g391df82e8ec3-dirty #73
> > [  444.364771] Hardware name: riscv-virtio,qemu (DT)
> > [  444.364868] epc : smp_call_function_many_cond+0x42c/0x436
> > [  444.364917]  ra : on_each_cpu_cond_mask+0x20/0x32
> > [  444.364948] epc : ffffffff8009f9e0 ra : ffffffff8009fa5a sp : ff2000=
0000003800
> > [  444.364966]  gp : ffffffff81500aa0 tp : ff60000002b83000 t0 : ff2000=
00000038c0
> > [  444.364982]  t1 : ffffffff815021f0 t2 : 000000000000001f s0 : ff2000=
00000038b0
> > [  444.364998]  s1 : ff60000002c54d98 a0 : ff60000002a73940 a1 : 000000=
0000000000
> > [  444.365013]  a2 : 0000000000000000 a3 : 0000000000000003 a4 : 000000=
0000000100
> > [  444.365029]  a5 : 0000000000010100 a6 : 0000000000f00000 a7 : 000000=
0000000000
> > [  444.365044]  s2 : 0000000000000000 s3 : ffffffffffffffff s4 : ff6000=
0002c54d98
> > [  444.365060]  s5 : ffffffff81539610 s6 : ffffffff80c20c48 s7 : 000000=
0000000000
> > [  444.365075]  s8 : 0000000000000000 s9 : 0000000000000001 s10: 000000=
0000000001
> > [  444.365090]  s11: ffffffff80099394 t3 : 0000000000000003 t4 : 000000=
00eac0c6e6
> > [  444.365104]  t5 : 0000000400000000 t6 : ff60000002e010d0
> > [  444.365120] status: 0000000200000100 badaddr: 0000000000000000 cause=
: 0000000000000003
> > [  444.365226] [<ffffffff8009f9e0>] smp_call_function_many_cond+0x42c/0=
x436
> > [  444.365295] [<ffffffff8009fa5a>] on_each_cpu_cond_mask+0x20/0x32
> > [  444.365311] [<ffffffff806e90dc>] pmu_sbi_ctr_start+0x7a/0xaa
> > [  444.365327] [<ffffffff806e880c>] riscv_pmu_start+0x48/0x66
> > [  444.365339] [<ffffffff8012111a>] perf_adjust_freq_unthr_context+0x19=
6/0x1ac
> > [  444.365356] [<ffffffff801237aa>] perf_event_task_tick+0x78/0x8c
> > [  444.365368] [<ffffffff8003faf4>] scheduler_tick+0xe6/0x25e
> > [  444.365383] [<ffffffff8008a042>] update_process_times+0x80/0x96
> > [  444.365398] [<ffffffff800991ec>] tick_sched_handle+0x26/0x52
> > [  444.365410] [<ffffffff800993e4>] tick_sched_timer+0x50/0x98
> > [  444.365422] [<ffffffff8008a6aa>] __hrtimer_run_queues+0x126/0x18a
> > [  444.365433] [<ffffffff8008b350>] hrtimer_interrupt+0xce/0x1da
> > [  444.365444] [<ffffffff806cdc60>] riscv_timer_interrupt+0x30/0x3a
> > [  444.365457] [<ffffffff8006afa6>] handle_percpu_devid_irq+0x80/0x114
> > [  444.365470] [<ffffffff80065b82>] generic_handle_domain_irq+0x1c/0x2a
> > [  444.365483] [<ffffffff8045faec>] riscv_intc_irq+0x2e/0x46
> > [  444.365497] [<ffffffff808a9c62>] handle_riscv_irq+0x4a/0x74
> > [  444.365521] [<ffffffff808aa760>] do_irq+0x7c/0x7e
> > [  444.365796] ---[ end trace 0000000000000000 ]---
> >
> > That's because the fix in commit 3fec323339a4 ("drivers: perf: Fix pani=
c
> > in riscv SBI mmap support") was wrong since there is no need to broadca=
st
> > to other cpus when starting a counter, that's only needed in mmap when
> > the counters could have already been started on other cpus, so simply
> > remove this broadcast.
> >
> > Fixes: 3fec323339a4 ("drivers: perf: Fix panic in riscv SBI mmap suppor=
t")
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Tested-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> > ---
> >  drivers/perf/riscv_pmu_sbi.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.=
c
> > index 96c7f670c8f0..439da49dd0a9 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -543,8 +543,7 @@ static void pmu_sbi_ctr_start(struct perf_event *ev=
ent, u64 ival)
> >
> >       if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
> >           (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
> > -             on_each_cpu_mask(mm_cpumask(event->owner->mm),
> > -                              pmu_sbi_set_scounteren, (void *)event, 1=
);
> > +             pmu_sbi_set_scounteren((void *)event);
> >  }
> >
> >  static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long f=
lag)
> > @@ -554,8 +553,7 @@ static void pmu_sbi_ctr_stop(struct perf_event *eve=
nt, unsigned long flag)
> >
> >       if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
> >           (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
> > -             on_each_cpu_mask(mm_cpumask(event->owner->mm),
> > -                              pmu_sbi_reset_scounteren, (void *)event,=
 1);
> > +             pmu_sbi_set_scounteren((void *)event);

Oh my, fortunately you noticed it, thank you very much!

>
> reset here? so the CY/IR bits can be cleared.
>
> Thanks for the patch, fixed the warning seen on my boards.
>
> Tested-by: Yu Chien Peter Lin <peterlin@andestech.com>

Perfect, thank you again, I send a new version right now.

Alex

>
> Best regards,
> Peter Lin
>
> >
> >       ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hwc->idx=
, 1, flag, 0, 0, 0);
> >       if (ret.error && (ret.error !=3D SBI_ERR_ALREADY_STOPPED) &&
