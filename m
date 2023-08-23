Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514817859A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbjHWNok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbjHWNoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:44:39 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD53CD6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:44:36 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9b904bb04so88701411fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1692798275; x=1693403075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WT2iBOeL5h1q2WVSaBUi8FulDxb7Lm+Rc+MDAqNSZHM=;
        b=dGAB5gqdg38JGt2SocHgpypW9Un3nHzGi/tEbT6fWdoyfXsO4SjP2XrbQb9nlWoUFz
         nbOA6cqL6cDtX1mR3tqlKyL9e28O7XH/1pU30CinjFlr3BUUzQitpS+bOOyxHTRjJA6Z
         /Hqmred3IASuQdo9U3+ckYaryADriMlJhlXRJGjX4Pt8vdVSVXRsl7Z+Hful7mTntAGK
         MbI/GWLPL33ERwbgZmEOoqsWeQxMZ3OFOkfr2dyqDka0Dqv6XPKnQCKq3qPJ6Mj7gJ84
         kgmRasN9hbEGPeVgqlzI+Rl1wzGA68tCdLEQ1GFyrZ2oJYZZV3jjcLAdsraVwoc0TBhn
         hKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692798275; x=1693403075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WT2iBOeL5h1q2WVSaBUi8FulDxb7Lm+Rc+MDAqNSZHM=;
        b=N0IUhEaO3P8KpS7/zJkEEEqlgWWkaojaOyfWEfBo1ntxfoB0rNo8sj7a0RqAffFOoB
         0ETx433kT7OOI+cs7hjmhfdDb7HpFGAHXpP05LSuxE75OYeq1Y58CS/NnuoOyNn3Jke2
         g71EC1ejCQNanqPzaiDG0wRy8cbgcDmJj0dnOizIsEee3exF0FP0gpPDYllN5NPRGHLX
         qcxfpPTmKecTM90ar1zT/+ji/RqSwvLr1TddQiyLdDilGpQ77q0bKQiGydmchNWlnbO3
         qKtDcBYIzekB8eJCwsxnuZijPsFcQf6KVhQbukETeuk8pRlO3naQxCL4E1e+Zr03y4uX
         xXrw==
X-Gm-Message-State: AOJu0Yw3Q8jgGIYJ6JnaTbpWWmDZDwZi0fXJCI9Yoo7ZudNSI4WS+4GY
        bi8zJZ1wSuMAHEzDlPN90PogyhlXHqL1SKYPwuYAvA==
X-Google-Smtp-Source: AGHT+IGkQFEDVaVffpkjs7q6/oHyZZWs4lXgUmMhJjGl1l33UdxCtWw2jgpwpw6f9mj/5ZgEHapfwZrBFt8DsT7fprY=
X-Received: by 2002:a05:651c:1208:b0:2bb:a111:e2c6 with SMTP id
 i8-20020a05651c120800b002bba111e2c6mr9865798lja.42.1692798274897; Wed, 23 Aug
 2023 06:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230822054739.33552-1-nick.hu@sifive.com> <CAAhSdy32DYoHpBKS3TF1SapM5fuMF5K00oqRxw8JF05v=DrUuw@mail.gmail.com>
 <CAKddAkDohdZqhjZKSawTg5NLMs0AXkL9SyYQr1q6vM1vm4Csfw@mail.gmail.com>
 <CAAhSdy0Yt-xcDYWz9BJCUgErpC2xM97yMXw4Wto078DKNk1nUg@mail.gmail.com> <CAKddAkBqUAwhftCiyoF3=tFM9cGTOnkYzeO=Cvsm3L7HAhiTMQ@mail.gmail.com>
In-Reply-To: <CAKddAkBqUAwhftCiyoF3=tFM9cGTOnkYzeO=Cvsm3L7HAhiTMQ@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 23 Aug 2023 19:14:23 +0530
Message-ID: <CAAhSdy3+0dReF9mj2aLo725Yc6co3sKNjjRw2QUCe0K_iWipFQ@mail.gmail.com>
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

On Wed, Aug 23, 2023 at 8:38=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrote:
>
> Hi Anup
>
> Thanks for your feedbacks
> On Tue, Aug 22, 2023 at 5:17=E2=80=AFPM Anup Patel <anup@brainfault.org> =
wrote:
> >
> > On Tue, Aug 22, 2023 at 1:28=E2=80=AFPM Nick Hu <nick.hu@sifive.com> wr=
ote:
> > >
> > > Hi Anup
> > >
> > >
> > > On Tue, Aug 22, 2023 at 2:16=E2=80=AFPM Anup Patel <anup@brainfault.o=
rg> wrote:
> > > >
> > > > On Tue, Aug 22, 2023 at 11:17=E2=80=AFAM Nick Hu <nick.hu@sifive.co=
m> wrote:
> > > > >
> > > > > If a task is the one who performs the suspend flow and it also do=
 some
> > > > > floating or vector operations before the suspend, we might lose t=
he FPU
> > > > > and vector states when it goes to the non-retention system suspen=
d state.
> > > > > Add syscore ops to save and restore the FPU and vector states of =
the
> > > > > current task to fix the issue above.
> > > >
> > > > This only applies to non-retentive system suspend so why do we need
> > > > this before SBI system suspend is merged ?
> > > >
> > > > Regards,
> > > > Anup
> > > >
> > > >
> > > How about hibernation?
> >
> > If this is for hibernation then the commit description should say so.
> >
> Actually this commit is for the suspend-to-ram. I ask about
> hibernation here because I think hibernation may also have the same
> issue too.
> If hibernation doesn't need it, I can defer this patch until we have
> system suspend.
> I send this patch because I believe we will support system suspend in
> the kernel soon or later and the hibernation might need it now.

Okay, understood.

>
> > Adding syscore_ops would mean these callbacks will be called for
> > both suspend-to-ram and hibernate cases. Other architectures don't
> > have this save/restore for suspend-to-ram because it is generally
> > called from idle task.
> >
> Do you think we don't have to consider the case in the patch?

I was comparing other architectures but I did not find any explicit
saving of FP state for suspend-to-ram. Although, I did find explicit
FP save for hibernate.

Functionally, it is fine to always save FP state for suspend-to-ram
but I am wondering if this redundant work in suspend-to-ram path.

Regards,
Anup

>
> Regards,
> Nick
> > Why not do the save/restore in save_processor_state() and
> > restore_processor_state() just like arch/mips/power/cpu.c ?
> >
> > Regards,
> > Anup
> >
> >
> > >
> > > Regards,
> > > Nick
> > > > >
> > > > > Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> > > > > Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> > > > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > > > ---
> > > > > Changes in v2:
> > > > > a) Add Co-developed-by and adjust the order of signed-off
> > > > > b) Rephrase the commit message
> > > > >
> > > > >  arch/riscv/kernel/suspend.c | 45 +++++++++++++++++++++++++++++++=
++++++
> > > > >  1 file changed, 45 insertions(+)
> > > > >
> > > > > diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/susp=
end.c
> > > > > index 3c89b8ec69c4..ff69ff8a1974 100644
> > > > > --- a/arch/riscv/kernel/suspend.c
> > > > > +++ b/arch/riscv/kernel/suspend.c
> > > > > @@ -4,9 +4,14 @@
> > > > >   * Copyright (c) 2022 Ventana Micro Systems Inc.
> > > > >   */
> > > > >
> > > > > +#include <linux/cpu_pm.h>
> > > > >  #include <linux/ftrace.h>
> > > > > +#include <linux/thread_info.h>
> > > > > +#include <linux/syscore_ops.h>
> > > > >  #include <asm/csr.h>
> > > > >  #include <asm/suspend.h>
> > > > > +#include <asm/switch_to.h>
> > > > > +#include <asm/vector.h>
> > > > >
> > > > >  void suspend_save_csrs(struct suspend_context *context)
> > > > >  {
> > > > > @@ -85,3 +90,43 @@ int cpu_suspend(unsigned long arg,
> > > > >
> > > > >         return rc;
> > > > >  }
> > > > > +
> > > > > +static int riscv_cpu_suspend(void)
> > > > > +{
> > > > > +       struct task_struct *cur_task =3D get_current();
> > > > > +       struct pt_regs *regs =3D task_pt_regs(cur_task);
> > > > > +
> > > > > +       if (has_fpu()) {
> > > > > +               if (unlikely(regs->status & SR_SD))
> > > > > +                       fstate_save(cur_task, regs);
> > > > > +       }
> > > > > +       if (has_vector()) {
> > > > > +               if (unlikely(regs->status & SR_SD))
> > > > > +                       riscv_v_vstate_save(cur_task, regs);
> > > > > +       }
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static void riscv_cpu_resume(void)
> > > > > +{
> > > > > +       struct task_struct *cur_task =3D get_current();
> > > > > +       struct pt_regs *regs =3D task_pt_regs(cur_task);
> > > > > +
> > > > > +       if (has_fpu())
> > > > > +               fstate_restore(cur_task, regs);
> > > > > +       if (has_vector())
> > > > > +               riscv_v_vstate_restore(cur_task, regs);
> > > > > +}
> > > > > +
> > > > > +static struct syscore_ops riscv_cpu_syscore_ops =3D {
> > > > > +       .suspend        =3D riscv_cpu_suspend,
> > > > > +       .resume         =3D riscv_cpu_resume,
> > > > > +};
> > > > > +
> > > > > +static int __init riscv_cpu_suspend_init(void)
> > > > > +{
> > > > > +       register_syscore_ops(&riscv_cpu_syscore_ops);
> > > > > +       return 0;
> > > > > +}
> > > > > +arch_initcall(riscv_cpu_suspend_init);
> > > > > --
> > > > > 2.34.1
> > > > >
