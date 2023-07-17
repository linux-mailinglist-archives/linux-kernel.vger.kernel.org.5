Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7A5755BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjGQGii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGQGig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:38:36 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823C7E46
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:38:34 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-55ba5bb0bf3so2445989a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689575914; x=1692167914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybENJY+zvZqFFXyYlFQfNam1MA92ybnOKuGRXBpZTAw=;
        b=QCmRcSURDxmA7WAhnDAKs9KEtswbEiK+GDi2sGhgm2sF4oVeEPotJXy7bchD52ZewX
         V+kcimAqmBH81vVGQUvF9N+/QkMu66QmZpsSJqzuSolr9jj11KNH+B9n/XLswhDmqr1W
         h+yKQdOrfglUzYqvAHSRLwmymEn0JqOJXy0z/W5jM8yFnFgBwZqITWakuLV8d6R9VPEn
         +ryLVL1/KZ/ZX4TrTBwOKhVQHHrFOYNVXWNQKK2Fs+41QOnlSpd08CNS9r7pd/g58L1v
         4QXgJUhL7ZhA9X2yFhij4AZvoLDWt/Ttk2qNY22rYETOOnEVzc51NwUn8wrSK3golu6e
         t9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689575914; x=1692167914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybENJY+zvZqFFXyYlFQfNam1MA92ybnOKuGRXBpZTAw=;
        b=jVpXBU8tTKuXE2mUKjJKF7fVw6nPbO60xj5X4SpSrjf4w4ibJL7g4HibWEtWoFbkrT
         riw75gnRp47EJFfl5OHWwPXrJmhnBOOxRGsiKY2KaCwnOJnT0gMrtUTGMYmTFPB8QMgE
         1e9y0dA8oYDwGbYGJ8GOl779xzChQanVQCvsCs+0Y50lKtyXFOyR6wt6QgbqJI041JPg
         fkVXwjr1UAuwq0MhTOCqsk0cPs1DRN2oXDozklE/mNh/uZNRSV8KSFPSUFyvioU4liDp
         BKhgV8fRHYKOmtCnsAjjAcEvYYEtYRaSxOQJNNSXcenk6o1gWcWsNnVsf2vBdcD5cihO
         BFBg==
X-Gm-Message-State: ABy/qLaBeDSzH5vZ567j6NuOivInHT82PsYzZboQu4jtatVcFk1hsfdC
        uYtNJrM243PQjTP/u19t0a6SIekR3+xBWgj/gpPwkw==
X-Google-Smtp-Source: APBJJlEv1WbE1YzG1GrFziFQaVz86XQN0MmrqrUH+8TtyVeujBILdt3jjwOTGy2HvXry3v6SfFxMZzl3/LByxr8nmn4=
X-Received: by 2002:a17:90b:3143:b0:263:e299:dff9 with SMTP id
 ip3-20020a17090b314300b00263e299dff9mr11555957pjb.23.1689575913782; Sun, 16
 Jul 2023 23:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230710094321.1378351-1-apatel@ventanamicro.com>
 <20230710094321.1378351-3-apatel@ventanamicro.com> <20230711-df9211fcae3b67948896b77f@orel>
In-Reply-To: <20230711-df9211fcae3b67948896b77f@orel>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 17 Jul 2023 12:08:21 +0530
Message-ID: <CAK9=C2W0ck_YaZ8MT9W_0Gx4fYRLq_engKCJn9X1hh5s_VrEQw@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] irqchip/riscv-intc: Add support for RISC-V AIA
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 7:42=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Mon, Jul 10, 2023 at 03:13:14PM +0530, Anup Patel wrote:
> > The RISC-V advanced interrupt architecture (AIA) extends the per-HART
> > local interrupts in following ways:
> > 1. Minimum 64 local interrupts for both RV32 and RV64
> > 2. Ability to process multiple pending local interrupts in same
> >    interrupt handler
> > 3. Priority configuration for each local interrupts
> > 4. Special CSRs to configure/access the per-HART MSI controller
>
> afaict, we're only doing (1) and (2) from this list in this patch.

Okay, I will update the commit description.

>
> >
> > This patch adds support for RISC-V AIA in the RISC-V intc driver.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/irqchip/irq-riscv-intc.c | 36 ++++++++++++++++++++++++++------
> >  1 file changed, 30 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-ris=
cv-intc.c
> > index 4adeee1bc391..e235bf1708a4 100644
> > --- a/drivers/irqchip/irq-riscv-intc.c
> > +++ b/drivers/irqchip/irq-riscv-intc.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/smp.h>
> > +#include <asm/hwcap.h>
> >
> >  static struct irq_domain *intc_domain;
> >
> > @@ -30,6 +31,15 @@ static asmlinkage void riscv_intc_irq(struct pt_regs=
 *regs)
> >       generic_handle_domain_irq(intc_domain, cause);
> >  }
> >
> > +static asmlinkage void riscv_intc_aia_irq(struct pt_regs *regs)
> > +{
> > +     unsigned long topi;
> > +
> > +     while ((topi =3D csr_read(CSR_TOPI)))
> > +             generic_handle_domain_irq(intc_domain,
> > +                                       topi >> TOPI_IID_SHIFT);
> > +}
> > +
> >  /*
> >   * On RISC-V systems local interrupts are masked or unmasked by writin=
g
> >   * the SIE (Supervisor Interrupt Enable) CSR.  As CSRs can only be wri=
tten
> > @@ -39,12 +49,18 @@ static asmlinkage void riscv_intc_irq(struct pt_reg=
s *regs)
> >
> >  static void riscv_intc_irq_mask(struct irq_data *d)
> >  {
> > -     csr_clear(CSR_IE, BIT(d->hwirq));
> > +     if (d->hwirq < BITS_PER_LONG)
> > +             csr_clear(CSR_IE, BIT(d->hwirq));
> > +     else
> > +             csr_clear(CSR_IEH, BIT(d->hwirq - BITS_PER_LONG));
>
> We can optimize rv64 by allowing the compiler to remove the branch
>
>  if (IS_ENABLED(CONFIG_32BIT) && d->hwirq >=3D 32)
>     csr_clear(CSR_IEH, BIT(d->hwirq - 32));
>  else
>     csr_clear(CSR_IE, BIT(d->hwirq));
>

Makes sense, I will update.

>
> >  }
> >
> >  static void riscv_intc_irq_unmask(struct irq_data *d)
> >  {
> > -     csr_set(CSR_IE, BIT(d->hwirq));
> > +     if (d->hwirq < BITS_PER_LONG)
> > +             csr_set(CSR_IE, BIT(d->hwirq));
> > +     else
> > +             csr_set(CSR_IEH, BIT(d->hwirq - BITS_PER_LONG));
>
> Same comment as above.

Okay, I will update.

>
> >  }
> >
> >  static void riscv_intc_irq_eoi(struct irq_data *d)
> > @@ -115,16 +131,22 @@ static struct fwnode_handle *riscv_intc_hwnode(vo=
id)
> >
> >  static int __init riscv_intc_init_common(struct fwnode_handle *fn)
> >  {
> > -     int rc;
> > +     int rc, nr_irqs =3D BITS_PER_LONG;
> > +
> > +     if (riscv_isa_extension_available(NULL, SxAIA) && BITS_PER_LONG =
=3D=3D 32)
> > +             nr_irqs =3D nr_irqs * 2;
>
> The AIA spec states sie and sip are explicitly 64, so how about writing
> this as
>
>  int rc, nr_irqs =3D BITS_PER_LONG;
>
>  if (riscv_isa_extension_available(NULL, SxAIA))
>      nr_irqs =3D 64;

Okay, I will update.

>
> >
> > -     intc_domain =3D irq_domain_create_linear(fn, BITS_PER_LONG,
> > +     intc_domain =3D irq_domain_create_linear(fn, nr_irqs,
> >                                              &riscv_intc_domain_ops, NU=
LL);
> >       if (!intc_domain) {
> >               pr_err("unable to add IRQ domain\n");
> >               return -ENXIO;
> >       }
> >
> > -     rc =3D set_handle_irq(&riscv_intc_irq);
> > +     if (riscv_isa_extension_available(NULL, SxAIA))
> > +             rc =3D set_handle_irq(&riscv_intc_aia_irq);
> > +     else
> > +             rc =3D set_handle_irq(&riscv_intc_irq);
>
> nit: blank line here

I prefer no blank line here because the "if (rc)" below
checks for errors for the above calls.

>
> >       if (rc) {
> >               pr_err("failed to set irq handler\n");
> >               return rc;
> > @@ -132,7 +154,9 @@ static int __init riscv_intc_init_common(struct fwn=
ode_handle *fn)
> >
> >       riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
> >
> > -     pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
> > +     pr_info("%d local interrupts mapped%s\n",
> > +             nr_irqs, (riscv_isa_extension_available(NULL, SxAIA)) ?
>
> nit: unnecessary ()

Okay, I will update.

>
> > +                      " using AIA" : "");
> >
> >       return 0;
> >  }
> > --
> > 2.34.1
> >
>
> Thanks,
> drew

Regards,
Anup
