Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5356078A4CA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 05:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjH1De1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 23:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjH1DeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 23:34:02 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94286129
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 20:33:59 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4103fdba0fbso15418981cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 20:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1693193638; x=1693798438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HeGPt3+EuEODvgoPgyRNpJ9/0YQFT8QVdMcdHP7F20=;
        b=je5I5dHsumfmTQUca+FnrARei6z4hq+4KcUVtJuO2zzQNpSeeWFGc17j8+0kjBtIgO
         EsoxVkNpvfTX8IBUE4kj/zOilNtfWOo7DEbrDl1tbTF3a1CkYcuP/hUGQ4bZvnGgFz2g
         iWS/mkU1TZNePEh8VdiZHFwMjlBg+xew0kULgQIJmfIQraifmewwhrLCCht5cpsqkBt9
         u4BAYajGJ5n/hGqbI/A/EZ6ZKZU971ZCqAQN/3syX6VrlDKdvMwkVhw60SGyy8Sf5Duk
         0QgIONzkZc+8kryI+2pG9vXSI9xta349phiE4EKam8Xh1BJFxvHShVMNii9a7OdxwtfK
         dgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693193638; x=1693798438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HeGPt3+EuEODvgoPgyRNpJ9/0YQFT8QVdMcdHP7F20=;
        b=LcPYMoQP5Q0gSjIGgJtRh8EJqhpAVqEVVygu5D1pMbJx0pNx/0NbydMJPvQcENA+Gi
         SYtol4yjaJtYgvfjETQbMAdpEEQcQX5cdbUa10am5172HCCsHUGCc/QcHibg1XB2dasc
         vEbzyMwzu4xgtvOROrtPC6kUqW6zY9Z+0liLtSTbUtrMQGWmnQLSC7hCK09f/+tJlPFM
         eGdee/a/H1Gv5iCzoKrtQ3ukSeGQ+JW2oW5jbQFTdfAZ8ELk7LYuL0XT/VZIDicpMbOu
         RqMuy1DJi00DWFBl5/Rm/N60fn3/qN92nD9Ouh70KmLyYkKjKM6m3QdF90pUu/v7w12d
         LCUg==
X-Gm-Message-State: AOJu0Yw4syusbkvDfYHxsWcW7nB70UPlTUgxaWQWJwSNxJ8jbLYQMx/e
        ZCk+AJKi0XwwRmkNwT+MfgItM6g9TPj1SFy6wEFZFg==
X-Google-Smtp-Source: AGHT+IFaiNEm2e/siz5yB5OiNvdSslRLdCK9embs6Sxsv+3vMVbW3yjPRnybhmIAJEsKE5B+6HkH8ha2NXUECqjtgfo=
X-Received: by 2002:ac8:570d:0:b0:405:3dcf:1182 with SMTP id
 13-20020ac8570d000000b004053dcf1182mr28059185qtw.50.1693193638447; Sun, 27
 Aug 2023 20:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230822054739.33552-1-nick.hu@sifive.com> <CAAhSdy32DYoHpBKS3TF1SapM5fuMF5K00oqRxw8JF05v=DrUuw@mail.gmail.com>
 <CAKddAkDohdZqhjZKSawTg5NLMs0AXkL9SyYQr1q6vM1vm4Csfw@mail.gmail.com>
 <CAAhSdy0Yt-xcDYWz9BJCUgErpC2xM97yMXw4Wto078DKNk1nUg@mail.gmail.com>
 <CAKddAkBqUAwhftCiyoF3=tFM9cGTOnkYzeO=Cvsm3L7HAhiTMQ@mail.gmail.com> <CAAhSdy3+0dReF9mj2aLo725Yc6co3sKNjjRw2QUCe0K_iWipFQ@mail.gmail.com>
In-Reply-To: <CAAhSdy3+0dReF9mj2aLo725Yc6co3sKNjjRw2QUCe0K_iWipFQ@mail.gmail.com>
From:   Nick Hu <nick.hu@sifive.com>
Date:   Mon, 28 Aug 2023 11:33:47 +0800
Message-ID: <CAKddAkDPG-XC8jD9Di+qMt9dNyScHoG58Qbe6Dd7BgQCqEXukA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: suspend: Add syscore ops for suspend
To:     Anup Patel <anup@brainfault.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com, conor.dooley@microchip.com,
        jeeheng.sia@starfivetech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, zong.li@sifive.com,
        Andy Chiu <andy.chiu@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup

On Wed, Aug 23, 2023 at 9:44=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> On Wed, Aug 23, 2023 at 8:38=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrot=
e:
> >
> > Hi Anup
> >
> > Thanks for your feedbacks
> > On Tue, Aug 22, 2023 at 5:17=E2=80=AFPM Anup Patel <anup@brainfault.org=
> wrote:
> > >
> > > On Tue, Aug 22, 2023 at 1:28=E2=80=AFPM Nick Hu <nick.hu@sifive.com> =
wrote:
> > > >
> > > > Hi Anup
> > > >
> > > >
> > > > On Tue, Aug 22, 2023 at 2:16=E2=80=AFPM Anup Patel <anup@brainfault=
.org> wrote:
> > > > >
> > > > > On Tue, Aug 22, 2023 at 11:17=E2=80=AFAM Nick Hu <nick.hu@sifive.=
com> wrote:
> > > > > >
> > > > > > If a task is the one who performs the suspend flow and it also =
do some
> > > > > > floating or vector operations before the suspend, we might lose=
 the FPU
> > > > > > and vector states when it goes to the non-retention system susp=
end state.
> > > > > > Add syscore ops to save and restore the FPU and vector states o=
f the
> > > > > > current task to fix the issue above.
> > > > >
> > > > > This only applies to non-retentive system suspend so why do we ne=
ed
> > > > > this before SBI system suspend is merged ?
> > > > >
> > > > > Regards,
> > > > > Anup
> > > > >
> > > > >
> > > > How about hibernation?
> > >
> > > If this is for hibernation then the commit description should say so.
> > >
> > Actually this commit is for the suspend-to-ram. I ask about
> > hibernation here because I think hibernation may also have the same
> > issue too.
> > If hibernation doesn't need it, I can defer this patch until we have
> > system suspend.
> > I send this patch because I believe we will support system suspend in
> > the kernel soon or later and the hibernation might need it now.
>
> Okay, understood.
>
> >
> > > Adding syscore_ops would mean these callbacks will be called for
> > > both suspend-to-ram and hibernate cases. Other architectures don't
> > > have this save/restore for suspend-to-ram because it is generally
> > > called from idle task.
> > >
> > Do you think we don't have to consider the case in the patch?
>
> I was comparing other architectures but I did not find any explicit
> saving of FP state for suspend-to-ram. Although, I did find explicit
> FP save for hibernate.
>
> Functionally, it is fine to always save FP state for suspend-to-ram
> but I am wondering if this redundant work in suspend-to-ram path.
>
Perhaps you are right. If no one would do the
suspend-to-ram/hibernation during the FPU/VECTOR calculation in the
same process, it may not be a practical case.

Regards,
Nick
> Regards,
> Anup
>
> >
> > Regards,
> > Nick
> > > Why not do the save/restore in save_processor_state() and
> > > restore_processor_state() just like arch/mips/power/cpu.c ?
> > >
> > > Regards,
> > > Anup
> > >
> > >
> > > >
> > > > Regards,
> > > > Nick
> > > > > >
> > > > > > Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> > > > > > Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> > > > > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > > > > ---
> > > > > > Changes in v2:
> > > > > > a) Add Co-developed-by and adjust the order of signed-off
> > > > > > b) Rephrase the commit message
> > > > > >
> > > > > >  arch/riscv/kernel/suspend.c | 45 +++++++++++++++++++++++++++++=
++++++++
> > > > > >  1 file changed, 45 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/su=
spend.c
> > > > > > index 3c89b8ec69c4..ff69ff8a1974 100644
> > > > > > --- a/arch/riscv/kernel/suspend.c
> > > > > > +++ b/arch/riscv/kernel/suspend.c
> > > > > > @@ -4,9 +4,14 @@
> > > > > >   * Copyright (c) 2022 Ventana Micro Systems Inc.
> > > > > >   */
> > > > > >
> > > > > > +#include <linux/cpu_pm.h>
> > > > > >  #include <linux/ftrace.h>
> > > > > > +#include <linux/thread_info.h>
> > > > > > +#include <linux/syscore_ops.h>
> > > > > >  #include <asm/csr.h>
> > > > > >  #include <asm/suspend.h>
> > > > > > +#include <asm/switch_to.h>
> > > > > > +#include <asm/vector.h>
> > > > > >
> > > > > >  void suspend_save_csrs(struct suspend_context *context)
> > > > > >  {
> > > > > > @@ -85,3 +90,43 @@ int cpu_suspend(unsigned long arg,
> > > > > >
> > > > > >         return rc;
> > > > > >  }
> > > > > > +
> > > > > > +static int riscv_cpu_suspend(void)
> > > > > > +{
> > > > > > +       struct task_struct *cur_task =3D get_current();
> > > > > > +       struct pt_regs *regs =3D task_pt_regs(cur_task);
> > > > > > +
> > > > > > +       if (has_fpu()) {
> > > > > > +               if (unlikely(regs->status & SR_SD))
> > > > > > +                       fstate_save(cur_task, regs);
> > > > > > +       }
> > > > > > +       if (has_vector()) {
> > > > > > +               if (unlikely(regs->status & SR_SD))
> > > > > > +                       riscv_v_vstate_save(cur_task, regs);
> > > > > > +       }
> > > > > > +
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static void riscv_cpu_resume(void)
> > > > > > +{
> > > > > > +       struct task_struct *cur_task =3D get_current();
> > > > > > +       struct pt_regs *regs =3D task_pt_regs(cur_task);
> > > > > > +
> > > > > > +       if (has_fpu())
> > > > > > +               fstate_restore(cur_task, regs);
> > > > > > +       if (has_vector())
> > > > > > +               riscv_v_vstate_restore(cur_task, regs);
> > > > > > +}
> > > > > > +
> > > > > > +static struct syscore_ops riscv_cpu_syscore_ops =3D {
> > > > > > +       .suspend        =3D riscv_cpu_suspend,
> > > > > > +       .resume         =3D riscv_cpu_resume,
> > > > > > +};
> > > > > > +
> > > > > > +static int __init riscv_cpu_suspend_init(void)
> > > > > > +{
> > > > > > +       register_syscore_ops(&riscv_cpu_syscore_ops);
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +arch_initcall(riscv_cpu_suspend_init);
> > > > > > --
> > > > > > 2.34.1
> > > > > >
