Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DE0784F1D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 05:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjHWDIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 23:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjHWDIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 23:08:21 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B99CD5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 20:08:18 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-64bd231c95cso28972816d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 20:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1692760098; x=1693364898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkQUyiTsYG+ARm3flGU77GSgWFGzu67vEgomaDrOEfI=;
        b=mFxqJgPSj+kuvWL3L9SwEJjXKm9xeURzPWH0aCan02nNg58Mm9rXpTv9WbSOI/4xhq
         TAi1TAdfih8O9+HmxdfmNggKnG3nVlvku6Ax4TBLu9r+9EEaKjGYfdYSlzTxejvB0MYP
         CoQE+85Cj2BkJGaLEzaOv51haaNGat0gULaL/SfUm7mccY0YxTVr7ag11wBPiand03Ar
         hfz1Q3OdP0SteCP40UEzmoIOdVfwTrWC3ilC/9F38K8jh1oWl45RnOiW9sQowEl4P2DM
         OFyBTFz8VWOLUpZkFtBkX05pZoDVVIFSfh/z+lOybmEmLJwEYzbY/nV0Roez/7W9lhAH
         WtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692760098; x=1693364898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkQUyiTsYG+ARm3flGU77GSgWFGzu67vEgomaDrOEfI=;
        b=IEuZdXHd9NHY5Wl5VrOhfw6mVj4r8cwlht5An4an5nfRCDL8VGhG4fQh2m8k1ywrlG
         ++yEvevedfBIxny1F3dUAE/OkMggSzoCmQhCEsoVwep0Kb9UzpWKQZeL6pRGeu6uNCJe
         cgiiKjJwcXZnoC4ca6Ssco3kfzdEXJOCKaWQysNKnvUWm22z1ZPc9L/t14y+AtS45/Lp
         m4x7eJvVbaWoWfaVFClSTseAWgJ5uTVO++0v10nKPj6P85aaYj3w2Fzpte0BBdMYsktQ
         9yG5fuJpPKbz6kGNtcyIEI762jO883jlC2V0G6i6f85TRxu6kLVYQyrXHGBC2jP+zdh1
         qn3Q==
X-Gm-Message-State: AOJu0Yw5u73UxLwx6bWGSq+8iAX2Wg1rwpp4Bc7rk3+mP4tou34lOO+Z
        5TMLk0VkjFkwaKmiIK4AbFg944olpRnc8uSK5f1odg==
X-Google-Smtp-Source: AGHT+IFhXdGl4kbxOz0waxEblWKMxE5OzgBpEp+1QZWpEAIEOL4kBNwmWDZg6+t9Vp1MusUWbtrMzlEP2XnArT6p7tw=
X-Received: by 2002:a0c:f387:0:b0:64f:42eb:92f3 with SMTP id
 i7-20020a0cf387000000b0064f42eb92f3mr7635149qvk.45.1692760097790; Tue, 22 Aug
 2023 20:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230822054739.33552-1-nick.hu@sifive.com> <CAAhSdy32DYoHpBKS3TF1SapM5fuMF5K00oqRxw8JF05v=DrUuw@mail.gmail.com>
 <CAKddAkDohdZqhjZKSawTg5NLMs0AXkL9SyYQr1q6vM1vm4Csfw@mail.gmail.com> <CAAhSdy0Yt-xcDYWz9BJCUgErpC2xM97yMXw4Wto078DKNk1nUg@mail.gmail.com>
In-Reply-To: <CAAhSdy0Yt-xcDYWz9BJCUgErpC2xM97yMXw4Wto078DKNk1nUg@mail.gmail.com>
From:   Nick Hu <nick.hu@sifive.com>
Date:   Wed, 23 Aug 2023 11:08:04 +0800
Message-ID: <CAKddAkBqUAwhftCiyoF3=tFM9cGTOnkYzeO=Cvsm3L7HAhiTMQ@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup

Thanks for your feedbacks
On Tue, Aug 22, 2023 at 5:17=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> On Tue, Aug 22, 2023 at 1:28=E2=80=AFPM Nick Hu <nick.hu@sifive.com> wrot=
e:
> >
> > Hi Anup
> >
> >
> > On Tue, Aug 22, 2023 at 2:16=E2=80=AFPM Anup Patel <anup@brainfault.org=
> wrote:
> > >
> > > On Tue, Aug 22, 2023 at 11:17=E2=80=AFAM Nick Hu <nick.hu@sifive.com>=
 wrote:
> > > >
> > > > If a task is the one who performs the suspend flow and it also do s=
ome
> > > > floating or vector operations before the suspend, we might lose the=
 FPU
> > > > and vector states when it goes to the non-retention system suspend =
state.
> > > > Add syscore ops to save and restore the FPU and vector states of th=
e
> > > > current task to fix the issue above.
> > >
> > > This only applies to non-retentive system suspend so why do we need
> > > this before SBI system suspend is merged ?
> > >
> > > Regards,
> > > Anup
> > >
> > >
> > How about hibernation?
>
> If this is for hibernation then the commit description should say so.
>
Actually this commit is for the suspend-to-ram. I ask about
hibernation here because I think hibernation may also have the same
issue too.
If hibernation doesn't need it, I can defer this patch until we have
system suspend.
I send this patch because I believe we will support system suspend in
the kernel soon or later and the hibernation might need it now.

> Adding syscore_ops would mean these callbacks will be called for
> both suspend-to-ram and hibernate cases. Other architectures don't
> have this save/restore for suspend-to-ram because it is generally
> called from idle task.
>
Do you think we don't have to consider the case in the patch?

Regards,
Nick
> Why not do the save/restore in save_processor_state() and
> restore_processor_state() just like arch/mips/power/cpu.c ?
>
> Regards,
> Anup
>
>
> >
> > Regards,
> > Nick
> > > >
> > > > Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> > > > Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> > > > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > > > ---
> > > > Changes in v2:
> > > > a) Add Co-developed-by and adjust the order of signed-off
> > > > b) Rephrase the commit message
> > > >
> > > >  arch/riscv/kernel/suspend.c | 45 +++++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 45 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspen=
d.c
> > > > index 3c89b8ec69c4..ff69ff8a1974 100644
> > > > --- a/arch/riscv/kernel/suspend.c
> > > > +++ b/arch/riscv/kernel/suspend.c
> > > > @@ -4,9 +4,14 @@
> > > >   * Copyright (c) 2022 Ventana Micro Systems Inc.
> > > >   */
> > > >
> > > > +#include <linux/cpu_pm.h>
> > > >  #include <linux/ftrace.h>
> > > > +#include <linux/thread_info.h>
> > > > +#include <linux/syscore_ops.h>
> > > >  #include <asm/csr.h>
> > > >  #include <asm/suspend.h>
> > > > +#include <asm/switch_to.h>
> > > > +#include <asm/vector.h>
> > > >
> > > >  void suspend_save_csrs(struct suspend_context *context)
> > > >  {
> > > > @@ -85,3 +90,43 @@ int cpu_suspend(unsigned long arg,
> > > >
> > > >         return rc;
> > > >  }
> > > > +
> > > > +static int riscv_cpu_suspend(void)
> > > > +{
> > > > +       struct task_struct *cur_task =3D get_current();
> > > > +       struct pt_regs *regs =3D task_pt_regs(cur_task);
> > > > +
> > > > +       if (has_fpu()) {
> > > > +               if (unlikely(regs->status & SR_SD))
> > > > +                       fstate_save(cur_task, regs);
> > > > +       }
> > > > +       if (has_vector()) {
> > > > +               if (unlikely(regs->status & SR_SD))
> > > > +                       riscv_v_vstate_save(cur_task, regs);
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static void riscv_cpu_resume(void)
> > > > +{
> > > > +       struct task_struct *cur_task =3D get_current();
> > > > +       struct pt_regs *regs =3D task_pt_regs(cur_task);
> > > > +
> > > > +       if (has_fpu())
> > > > +               fstate_restore(cur_task, regs);
> > > > +       if (has_vector())
> > > > +               riscv_v_vstate_restore(cur_task, regs);
> > > > +}
> > > > +
> > > > +static struct syscore_ops riscv_cpu_syscore_ops =3D {
> > > > +       .suspend        =3D riscv_cpu_suspend,
> > > > +       .resume         =3D riscv_cpu_resume,
> > > > +};
> > > > +
> > > > +static int __init riscv_cpu_suspend_init(void)
> > > > +{
> > > > +       register_syscore_ops(&riscv_cpu_syscore_ops);
> > > > +       return 0;
> > > > +}
> > > > +arch_initcall(riscv_cpu_suspend_init);
> > > > --
> > > > 2.34.1
> > > >
