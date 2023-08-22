Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EAA783B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjHVH6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjHVH6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:58:38 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1613C198
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:58:37 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-76dafe9574bso62468285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1692691116; x=1693295916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GL3ymXypfna7VinvoKpEJH49GBKBaM67PwD6qVC/FgQ=;
        b=JPWHkWbP+9fHaq/xc4HWoD9mGWZZ9T8n68daoGrAdQ9+JnF5265pOENKbPEwJER+Dh
         sqLgvXLG2X0RonTxatrqgCY3UUiq96He9K007po09gz47fFVy0qGLL268aMfhVI+Sj33
         gTqO3bAxmQRpeMXExhRdShCmr+TSZnTKJ5XJXbnn/JjXxyAGJ1x0cLGyioYk/RTwsrAE
         epaa8GHeMGQoPqsfleaRZyjVQ7rgpM0MIA1msw6l7rCJC3by3Y18Ml8l4yD8MY3ma4wy
         /xhUU8I4U8bKgltSy0dQAfgGIveg4SFZVcSGxvJHB21EIjkYVV+0HyF6JMLYV/JkZ+m3
         Xvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692691116; x=1693295916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GL3ymXypfna7VinvoKpEJH49GBKBaM67PwD6qVC/FgQ=;
        b=cAYYBO/vNM7kRb0bpjZ+idSMpXnV6nVfltRJ1nAFGYllXLJUMurae7Xz8tOpiL61lb
         5SubH7R/XpVXcELXadK5td7s5vEDPje3OIXbK/snbgsXhNqavkAo3UzoxI0HPGT7RH/s
         SEzorjoOFQDMYrJw4rLscQWDSOcvuSf9sXVfZYasuvKVruveKW5LxYlJBFBdJpyQm2ra
         84aggOJLy4ok3/qpWGPMN6+Fe6KDFUVf21l0sfCX6wGc7DqhOKtnML947QGwFpDiS+eO
         +WE97KwZAmaL66hSPLAyV4oLdlAzmVMJYPmKde9T4cFPP7XXgs7iMoxPGLtm1BjMFIES
         e67Q==
X-Gm-Message-State: AOJu0YwrfGAOsav9NKDueXp+xTq76/XiReD8q/6/CsBfA91ajHZ0nYHR
        3aVc12Z1l032BqXXcx2noTEscnUeZCyF9ckIHmyNBw==
X-Google-Smtp-Source: AGHT+IGuCzvIWbQvx8c4ZfhZoo9XqXh28bNelyavdxSBwB/dMQXRZxee3pJnDV2zP+o9Y5p18yqjuC1YXagm7a3PSoc=
X-Received: by 2002:a0c:f311:0:b0:649:bf3:6dca with SMTP id
 j17-20020a0cf311000000b006490bf36dcamr11149176qvl.62.1692691116099; Tue, 22
 Aug 2023 00:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230822054739.33552-1-nick.hu@sifive.com> <CAAhSdy32DYoHpBKS3TF1SapM5fuMF5K00oqRxw8JF05v=DrUuw@mail.gmail.com>
In-Reply-To: <CAAhSdy32DYoHpBKS3TF1SapM5fuMF5K00oqRxw8JF05v=DrUuw@mail.gmail.com>
From:   Nick Hu <nick.hu@sifive.com>
Date:   Tue, 22 Aug 2023 15:58:24 +0800
Message-ID: <CAKddAkDohdZqhjZKSawTg5NLMs0AXkL9SyYQr1q6vM1vm4Csfw@mail.gmail.com>
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


On Tue, Aug 22, 2023 at 2:16=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> On Tue, Aug 22, 2023 at 11:17=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wro=
te:
> >
> > If a task is the one who performs the suspend flow and it also do some
> > floating or vector operations before the suspend, we might lose the FPU
> > and vector states when it goes to the non-retention system suspend stat=
e.
> > Add syscore ops to save and restore the FPU and vector states of the
> > current task to fix the issue above.
>
> This only applies to non-retentive system suspend so why do we need
> this before SBI system suspend is merged ?
>
> Regards,
> Anup
>
>
How about hibernation?

Regards,
Nick
> >
> > Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> > Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > ---
> > Changes in v2:
> > a) Add Co-developed-by and adjust the order of signed-off
> > b) Rephrase the commit message
> >
> >  arch/riscv/kernel/suspend.c | 45 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
> > index 3c89b8ec69c4..ff69ff8a1974 100644
> > --- a/arch/riscv/kernel/suspend.c
> > +++ b/arch/riscv/kernel/suspend.c
> > @@ -4,9 +4,14 @@
> >   * Copyright (c) 2022 Ventana Micro Systems Inc.
> >   */
> >
> > +#include <linux/cpu_pm.h>
> >  #include <linux/ftrace.h>
> > +#include <linux/thread_info.h>
> > +#include <linux/syscore_ops.h>
> >  #include <asm/csr.h>
> >  #include <asm/suspend.h>
> > +#include <asm/switch_to.h>
> > +#include <asm/vector.h>
> >
> >  void suspend_save_csrs(struct suspend_context *context)
> >  {
> > @@ -85,3 +90,43 @@ int cpu_suspend(unsigned long arg,
> >
> >         return rc;
> >  }
> > +
> > +static int riscv_cpu_suspend(void)
> > +{
> > +       struct task_struct *cur_task =3D get_current();
> > +       struct pt_regs *regs =3D task_pt_regs(cur_task);
> > +
> > +       if (has_fpu()) {
> > +               if (unlikely(regs->status & SR_SD))
> > +                       fstate_save(cur_task, regs);
> > +       }
> > +       if (has_vector()) {
> > +               if (unlikely(regs->status & SR_SD))
> > +                       riscv_v_vstate_save(cur_task, regs);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void riscv_cpu_resume(void)
> > +{
> > +       struct task_struct *cur_task =3D get_current();
> > +       struct pt_regs *regs =3D task_pt_regs(cur_task);
> > +
> > +       if (has_fpu())
> > +               fstate_restore(cur_task, regs);
> > +       if (has_vector())
> > +               riscv_v_vstate_restore(cur_task, regs);
> > +}
> > +
> > +static struct syscore_ops riscv_cpu_syscore_ops =3D {
> > +       .suspend        =3D riscv_cpu_suspend,
> > +       .resume         =3D riscv_cpu_resume,
> > +};
> > +
> > +static int __init riscv_cpu_suspend_init(void)
> > +{
> > +       register_syscore_ops(&riscv_cpu_syscore_ops);
> > +       return 0;
> > +}
> > +arch_initcall(riscv_cpu_suspend_init);
> > --
> > 2.34.1
> >
