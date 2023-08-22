Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEDA783CB4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbjHVJRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjHVJRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:17:21 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4A4113
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:17:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99df431d4bfso545753266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1692695838; x=1693300638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CWoG7qRKl6509z+iJcRCAg2R0UyuGwnsqPdw/VQlf8=;
        b=dDq3dcvsvTrkw8/fTjwFtJVU4wCg0C0KBDymZYe3rP6YCK+rEG8TzF5WjW8twjm7kE
         mDg4Ozm0gJ0SMY217KSmOWmua63FKrcppJ+d8ihWM5KizM4jBzb/yf337O6ADCxdM/kc
         ZvMV/czt73eHwYJrFfQftwmMdlmr1lkVOL38wFwxSGI+QUsenerFQ9JTxlV5djvGxGMH
         aW2sXu57HD+9kk4AOY/EH+ojEA/qKE3j42RTnUF4SMicGWIGxBYQJjbq4Ps8ofbefQHM
         yfB42oO0rcdAUCVteDvwyNbER7r34QSQCIyuULnmd1Sq26m6dNfWkWuJEYA9BoREmDmz
         ughA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692695838; x=1693300638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CWoG7qRKl6509z+iJcRCAg2R0UyuGwnsqPdw/VQlf8=;
        b=hNIKNPWnTC1l3RoEuMN+oHnKF7l1lLhHMKlnrnV07He7KAm3dmEfMVigD2vZsyml8a
         9gRYdfF7QpLa1pAWTIKwS3J46S3EYuwZ7IVGiP3/zmnDTC9eRn51wYKhCib04QjePaAO
         3P8FnxzE4bxXvXAJlO3qCISsMxZ5lkRGcX2qJKK6xTDY2HsoLqhmYSczvQM5+GK7MkNr
         0GpzVtL4s3zm5QVpA8nBi1BT775xU66OHp+Misnwlv1aNjoS/dpU9N0fiXGcd859q7NL
         kOpOeWiTFStL3jyPL4IBWwuiwhbVUH16iUNQbnl3UEY4+BKdurCG/xOub3gmZgJTfKNc
         sPCA==
X-Gm-Message-State: AOJu0YymKsj0BxJNufY6YszVW2hoSkHTSaRVefL8lSxYSIYnldSWMK3r
        g1g88rcGUCCFqUgj4+eHqsnV93CP35Ya1XjHw53pIQ==
X-Google-Smtp-Source: AGHT+IHxPQErliFw+rDoGut7BPctC5862/YdpkZCfUimLQfKm6GTLGZRh4PuERYr+rzciy17JW5MeeQkK65KyJNX52c=
X-Received: by 2002:a17:906:748a:b0:9a1:697e:4bb7 with SMTP id
 e10-20020a170906748a00b009a1697e4bb7mr7276530ejl.73.1692695837666; Tue, 22
 Aug 2023 02:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230822054739.33552-1-nick.hu@sifive.com> <CAAhSdy32DYoHpBKS3TF1SapM5fuMF5K00oqRxw8JF05v=DrUuw@mail.gmail.com>
 <CAKddAkDohdZqhjZKSawTg5NLMs0AXkL9SyYQr1q6vM1vm4Csfw@mail.gmail.com>
In-Reply-To: <CAKddAkDohdZqhjZKSawTg5NLMs0AXkL9SyYQr1q6vM1vm4Csfw@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 22 Aug 2023 14:47:06 +0530
Message-ID: <CAAhSdy0Yt-xcDYWz9BJCUgErpC2xM97yMXw4Wto078DKNk1nUg@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: suspend: Add syscore ops for suspend
To:     Nick Hu <nick.hu@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com, conor.dooley@microchip.com,
        jeeheng.sia@starfivetech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, zong.li@sifive.com,
        Andy Chiu <andy.chiu@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 1:28=E2=80=AFPM Nick Hu <nick.hu@sifive.com> wrote:
>
> Hi Anup
>
>
> On Tue, Aug 22, 2023 at 2:16=E2=80=AFPM Anup Patel <anup@brainfault.org> =
wrote:
> >
> > On Tue, Aug 22, 2023 at 11:17=E2=80=AFAM Nick Hu <nick.hu@sifive.com> w=
rote:
> > >
> > > If a task is the one who performs the suspend flow and it also do som=
e
> > > floating or vector operations before the suspend, we might lose the F=
PU
> > > and vector states when it goes to the non-retention system suspend st=
ate.
> > > Add syscore ops to save and restore the FPU and vector states of the
> > > current task to fix the issue above.
> >
> > This only applies to non-retentive system suspend so why do we need
> > this before SBI system suspend is merged ?
> >
> > Regards,
> > Anup
> >
> >
> How about hibernation?

If this is for hibernation then the commit description should say so.

Adding syscore_ops would mean these callbacks will be called for
both suspend-to-ram and hibernate cases. Other architectures don't
have this save/restore for suspend-to-ram because it is generally
called from idle task.

Why not do the save/restore in save_processor_state() and
restore_processor_state() just like arch/mips/power/cpu.c ?

Regards,
Anup


>
> Regards,
> Nick
> > >
> > > Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> > > Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > ---
> > > Changes in v2:
> > > a) Add Co-developed-by and adjust the order of signed-off
> > > b) Rephrase the commit message
> > >
> > >  arch/riscv/kernel/suspend.c | 45 +++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 45 insertions(+)
> > >
> > > diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.=
c
> > > index 3c89b8ec69c4..ff69ff8a1974 100644
> > > --- a/arch/riscv/kernel/suspend.c
> > > +++ b/arch/riscv/kernel/suspend.c
> > > @@ -4,9 +4,14 @@
> > >   * Copyright (c) 2022 Ventana Micro Systems Inc.
> > >   */
> > >
> > > +#include <linux/cpu_pm.h>
> > >  #include <linux/ftrace.h>
> > > +#include <linux/thread_info.h>
> > > +#include <linux/syscore_ops.h>
> > >  #include <asm/csr.h>
> > >  #include <asm/suspend.h>
> > > +#include <asm/switch_to.h>
> > > +#include <asm/vector.h>
> > >
> > >  void suspend_save_csrs(struct suspend_context *context)
> > >  {
> > > @@ -85,3 +90,43 @@ int cpu_suspend(unsigned long arg,
> > >
> > >         return rc;
> > >  }
> > > +
> > > +static int riscv_cpu_suspend(void)
> > > +{
> > > +       struct task_struct *cur_task =3D get_current();
> > > +       struct pt_regs *regs =3D task_pt_regs(cur_task);
> > > +
> > > +       if (has_fpu()) {
> > > +               if (unlikely(regs->status & SR_SD))
> > > +                       fstate_save(cur_task, regs);
> > > +       }
> > > +       if (has_vector()) {
> > > +               if (unlikely(regs->status & SR_SD))
> > > +                       riscv_v_vstate_save(cur_task, regs);
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void riscv_cpu_resume(void)
> > > +{
> > > +       struct task_struct *cur_task =3D get_current();
> > > +       struct pt_regs *regs =3D task_pt_regs(cur_task);
> > > +
> > > +       if (has_fpu())
> > > +               fstate_restore(cur_task, regs);
> > > +       if (has_vector())
> > > +               riscv_v_vstate_restore(cur_task, regs);
> > > +}
> > > +
> > > +static struct syscore_ops riscv_cpu_syscore_ops =3D {
> > > +       .suspend        =3D riscv_cpu_suspend,
> > > +       .resume         =3D riscv_cpu_resume,
> > > +};
> > > +
> > > +static int __init riscv_cpu_suspend_init(void)
> > > +{
> > > +       register_syscore_ops(&riscv_cpu_syscore_ops);
> > > +       return 0;
> > > +}
> > > +arch_initcall(riscv_cpu_suspend_init);
> > > --
> > > 2.34.1
> > >
