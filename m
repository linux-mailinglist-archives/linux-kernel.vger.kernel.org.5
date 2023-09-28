Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97277B11A1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 06:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjI1EjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 00:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI1EjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 00:39:13 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBBE193
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:39:09 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690f7d73a3aso11271037b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695875949; x=1696480749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVNN4ScVilE3FB8S1RUZPpKJw3O8qPkGoWjd9mOs7Is=;
        b=iyK7eYkHeofZGxGVvKAXNI3Yoroyt64y1RGties7cecoS0d7tOyslhCph9FXMCRP85
         M1QtaW27DGrcpfowZ5bSvM4P6cSBmyuyBUjgwf6mIZXg8hS3evRsNXbMa93QJ91WcmWH
         r6zG/feMi1UkINLHyGP95QD6jR4NvrTOq9fHGsglxabMRzha6Z2bJaB7ik7xCmIG0O7f
         ts/wAQdeMnDiSK/jEqcBdZsgzlj6i0Z/TWUZETbaRpN5dVk+1cmeetNGyWKeCovHktzO
         uaM+KZIGtQq9wIfv0KFdv58XG7N+myA+GYDqIClgOl6ZG/Ixx0aLEk8c4yg0Pb5YzjEs
         e9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695875949; x=1696480749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVNN4ScVilE3FB8S1RUZPpKJw3O8qPkGoWjd9mOs7Is=;
        b=wXOc/wOxRblUAPgeb8QQSKxAU1xzQ2sMpwmosj62qYm1G0qZpsDHdifcG0HI8bA4G0
         jqu8oIC9gEmnvP3qL6MoUu9HYY2YJjKTLcCuMKPR0ioWLK0uyaswSWxpmY3wi93hwTAu
         9ZMxzawpB9csFBFjP/FXIUpZXr6S18DJlpEMrCNjPHHehH63fw7k9qp3w1kGR6zwyfhf
         LhjhwAPWspYZbHC80eLWBI7Xk99X0dvSu5awH0hEJwUJ/XfIL4hEVMXFAmvMzsNpKctA
         mRFQCfWfbN8eTq8djUUAWEMbLbY4catFcuUQHXmkKRQxL+2xrBA0S4h4v4xut4lGp9xj
         PYyg==
X-Gm-Message-State: AOJu0YzRiWywjFqH2iPR/Qa+Hlt6S7Lv4Nd5+zCd5lEibGM/0BBGPC9N
        YTXTEoHl3zagMAOUY5x431xN/Bk4iGjwd9J69huVYA==
X-Google-Smtp-Source: AGHT+IEVbrdIRasfiwbt073alHfFYyklgWsPRQYF0uTpAyGQTRrRutA0EwZNpzYzHHyL0mq+IBO0di7Dxd58wBK5W38=
X-Received: by 2002:a05:6a20:9382:b0:15c:d925:aaaf with SMTP id
 x2-20020a056a20938200b0015cd925aaafmr193082pzh.5.1695875948800; Wed, 27 Sep
 2023 21:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230912174928.528414-1-apatel@ventanamicro.com>
 <20230912174928.528414-14-apatel@ventanamicro.com> <ZRE9GCVIxwOUo6HA@sunil-laptop>
In-Reply-To: <ZRE9GCVIxwOUo6HA@sunil-laptop>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 28 Sep 2023 10:08:56 +0530
Message-ID: <CAK9=C2VutTR+bV4aLzApEwTVAsxfjM9+scE1GdR+iY9ogVH4fw@mail.gmail.com>
Subject: Re: [PATCH v8 13/16] irqchip: Add RISC-V advanced PLIC driver for direct-mode
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
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

On Mon, Sep 25, 2023 at 1:26=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> Hi Anup,
>
> On Tue, Sep 12, 2023 at 11:19:25PM +0530, Anup Patel wrote:
> > The RISC-V advanced interrupt architecture (AIA) specification defines
> > advanced platform-level interrupt controller (APLIC) which has two mode=
s
> > of operation: 1) Direct mode and 2) MSI mode.
> > (For more details, refer https://github.com/riscv/riscv-aia)
> >
> > In APLIC direct-mode, wired interrupts are forwared to CPUs (or HARTs)
> > as a local external interrupt.
> >
> > We add a platform irqchip driver for the RISC-V APLIC direct-mode to
> > support RISC-V platforms having only wired interrupts.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/irqchip/Kconfig                  |   5 +
> >  drivers/irqchip/Makefile                 |   1 +
> >  drivers/irqchip/irq-riscv-aplic-direct.c | 326 +++++++++++++++++++++++
> >  drivers/irqchip/irq-riscv-aplic-main.c   | 240 +++++++++++++++++
> >  drivers/irqchip/irq-riscv-aplic-main.h   |  45 ++++
> >  include/linux/irqchip/riscv-aplic.h      | 119 +++++++++
> >  6 files changed, 736 insertions(+)
> >  create mode 100644 drivers/irqchip/irq-riscv-aplic-direct.c
> >  create mode 100644 drivers/irqchip/irq-riscv-aplic-main.c
> >  create mode 100644 drivers/irqchip/irq-riscv-aplic-main.h
> >  create mode 100644 include/linux/irqchip/riscv-aplic.h
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index a6aad78076a0..44c455084d09 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -545,6 +545,11 @@ config SIFIVE_PLIC
> >       select IRQ_DOMAIN_HIERARCHY
> >       select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
> >
> > +config RISCV_APLIC
> > +     bool
> > +     depends on RISCV
> > +     select IRQ_DOMAIN_HIERARCHY
> > +
> >  config RISCV_IMSIC
> >       bool
> >       depends on RISCV
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index abca445a3229..7f8289790ed8 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -95,6 +95,7 @@ obj-$(CONFIG_QCOM_MPM)                      +=3D irq-=
qcom-mpm.o
> >  obj-$(CONFIG_CSKY_MPINTC)            +=3D irq-csky-mpintc.o
> >  obj-$(CONFIG_CSKY_APB_INTC)          +=3D irq-csky-apb-intc.o
> >  obj-$(CONFIG_RISCV_INTC)             +=3D irq-riscv-intc.o
> > +obj-$(CONFIG_RISCV_APLIC)            +=3D irq-riscv-aplic-main.o irq-r=
iscv-aplic-direct.o
> >  obj-$(CONFIG_RISCV_IMSIC)            +=3D irq-riscv-imsic-state.o irq-=
riscv-imsic-early.o irq-riscv-imsic-platform.o
> >  obj-$(CONFIG_SIFIVE_PLIC)            +=3D irq-sifive-plic.o
> >  obj-$(CONFIG_IMX_IRQSTEER)           +=3D irq-imx-irqsteer.o
> > diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip=
/irq-riscv-aplic-direct.c
> > new file mode 100644
> > index 000000000000..e36d655a1490
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-riscv-aplic-direct.c
> > @@ -0,0 +1,326 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> > + * Copyright (C) 2022 Ventana Micro Systems Inc.
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/cpu.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqchip/chained_irq.h>
> > +#include <linux/irqchip/riscv-aplic.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/printk.h>
> > +#include <linux/smp.h>
> > +
> > +#include "irq-riscv-aplic-main.h"
> > +
> > +#define APLIC_DISABLE_IDELIVERY              0
> > +#define APLIC_ENABLE_IDELIVERY               1
> > +#define APLIC_DISABLE_ITHRESHOLD     1
> > +#define APLIC_ENABLE_ITHRESHOLD              0
> > +
> > +struct aplic_direct {
> > +     struct aplic_priv       priv;
> > +     struct irq_domain       *irqdomain;
> > +     struct cpumask          lmask;
> > +};
> > +
> > +struct aplic_idc {
> > +     unsigned int            hart_index;
> > +     void __iomem            *regs;
> > +     struct aplic_direct     *direct;
> > +};
> > +
> > +static unsigned int aplic_direct_parent_irq;
> > +static DEFINE_PER_CPU(struct aplic_idc, aplic_idcs);
> > +
> > +static void aplic_direct_irq_eoi(struct irq_data *d)
> > +{
> > +     /*
> > +      * The fasteoi_handler requires irq_eoi() callback hence
> > +      * provide a dummy handler.
> > +      */
> > +}
> > +
> > +#ifdef CONFIG_SMP
> > +static int aplic_direct_set_affinity(struct irq_data *d,
> > +                               const struct cpumask *mask_val, bool fo=
rce)
> > +{
> > +     struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> > +     struct aplic_direct *direct =3D
> > +                     container_of(priv, struct aplic_direct, priv);
> > +     struct aplic_idc *idc;
> > +     unsigned int cpu, val;
> > +     struct cpumask amask;
> > +     void __iomem *target;
> > +
> > +     cpumask_and(&amask, &direct->lmask, mask_val);
> > +
> > +     if (force)
> > +             cpu =3D cpumask_first(&amask);
> > +     else
> > +             cpu =3D cpumask_any_and(&amask, cpu_online_mask);
> > +
> > +     if (cpu >=3D nr_cpu_ids)
> > +             return -EINVAL;
> > +
> > +     idc =3D per_cpu_ptr(&aplic_idcs, cpu);
> > +     target =3D priv->regs + APLIC_TARGET_BASE;
> > +     target +=3D (d->hwirq - 1) * sizeof(u32);
> > +     val =3D idc->hart_index & APLIC_TARGET_HART_IDX_MASK;
> > +     val <<=3D APLIC_TARGET_HART_IDX_SHIFT;
> > +     val |=3D APLIC_DEFAULT_PRIORITY;
> > +     writel(val, target);
> > +
> > +     irq_data_update_effective_affinity(d, cpumask_of(cpu));
> > +
> > +     return IRQ_SET_MASK_OK_DONE;
> > +}
> > +#endif
> > +
> > +static struct irq_chip aplic_direct_chip =3D {
> > +     .name           =3D "APLIC-DIRECT",
> > +     .irq_mask       =3D aplic_irq_mask,
> > +     .irq_unmask     =3D aplic_irq_unmask,
> > +     .irq_set_type   =3D aplic_irq_set_type,
> > +     .irq_eoi        =3D aplic_direct_irq_eoi,
> > +#ifdef CONFIG_SMP
> > +     .irq_set_affinity =3D aplic_direct_set_affinity,
> > +#endif
> > +     .flags          =3D IRQCHIP_SET_TYPE_MASKED |
> > +                       IRQCHIP_SKIP_SET_WAKE |
> > +                       IRQCHIP_MASK_ON_SUSPEND,
> > +};
> > +
> > +static int aplic_direct_irqdomain_translate(struct irq_domain *d,
> > +                                      struct irq_fwspec *fwspec,
> > +                                      unsigned long *hwirq,
> > +                                      unsigned int *type)
> > +{
> > +     struct aplic_priv *priv =3D d->host_data;
> > +
> > +     return aplic_irqdomain_translate(fwspec, priv->gsi_base,
> > +                                      hwirq, type);
> > +}
> > +
> > +static int aplic_direct_irqdomain_alloc(struct irq_domain *domain,
> > +                                  unsigned int virq, unsigned int nr_i=
rqs,
> > +                                  void *arg)
> > +{
> > +     int i, ret;
> > +     unsigned int type;
> > +     irq_hw_number_t hwirq;
> > +     struct irq_fwspec *fwspec =3D arg;
> > +     struct aplic_priv *priv =3D domain->host_data;
> > +     struct aplic_direct *direct =3D
> > +                     container_of(priv, struct aplic_direct, priv);
> > +
> > +     ret =3D aplic_irqdomain_translate(fwspec, priv->gsi_base,
> > +                                     &hwirq, &type);
> > +     if (ret)
> > +             return ret;
> > +
> > +     for (i =3D 0; i < nr_irqs; i++) {
> > +             irq_domain_set_info(domain, virq + i, hwirq + i,
> > +                                 &aplic_direct_chip, priv,
> > +                                 handle_fasteoi_irq, NULL, NULL);
> > +             irq_set_affinity(virq + i, &direct->lmask);
> > +             /* See the reason described in aplic_msi_irqdomain_alloc(=
) */
> > +             irq_set_status_flags(virq + i, IRQ_DISABLE_UNLAZY);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct irq_domain_ops aplic_direct_irqdomain_ops =3D {
> > +     .translate      =3D aplic_direct_irqdomain_translate,
> > +     .alloc          =3D aplic_direct_irqdomain_alloc,
> > +     .free           =3D irq_domain_free_irqs_top,
> > +};
> > +
> > +/*
> > + * To handle an APLIC direct interrupts, we just read the CLAIMI regis=
ter
> > + * which will return highest priority pending interrupt and clear the
> > + * pending bit of the interrupt. This process is repeated until CLAIMI
> > + * register return zero value.
> > + */
> > +static void aplic_direct_handle_irq(struct irq_desc *desc)
> > +{
> > +     struct aplic_idc *idc =3D this_cpu_ptr(&aplic_idcs);
> > +     struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +     struct irq_domain *irqdomain =3D idc->direct->irqdomain;
> > +     irq_hw_number_t hw_irq;
> > +     int irq;
> > +
> > +     chained_irq_enter(chip, desc);
> > +
> > +     while ((hw_irq =3D readl(idc->regs + APLIC_IDC_CLAIMI))) {
> > +             hw_irq =3D hw_irq >> APLIC_IDC_TOPI_ID_SHIFT;
> > +             irq =3D irq_find_mapping(irqdomain, hw_irq);
> > +
> > +             if (unlikely(irq <=3D 0))
> > +                     dev_warn_ratelimited(idc->direct->priv.dev,
> > +                                          "hw_irq %lu mapping not foun=
d\n",
> > +                                          hw_irq);
> > +             else
> > +                     generic_handle_irq(irq);
> > +     }
> > +
> > +     chained_irq_exit(chip, desc);
> > +}
> > +
> > +static void aplic_idc_set_delivery(struct aplic_idc *idc, bool en)
> > +{
> > +     u32 de =3D (en) ? APLIC_ENABLE_IDELIVERY : APLIC_DISABLE_IDELIVER=
Y;
> > +     u32 th =3D (en) ? APLIC_ENABLE_ITHRESHOLD : APLIC_DISABLE_ITHRESH=
OLD;
> > +
> > +     /* Priority must be less than threshold for interrupt triggering =
*/
> > +     writel(th, idc->regs + APLIC_IDC_ITHRESHOLD);
> > +
> > +     /* Delivery must be set to 1 for interrupt triggering */
> > +     writel(de, idc->regs + APLIC_IDC_IDELIVERY);
> > +}
> > +
> > +static int aplic_direct_dying_cpu(unsigned int cpu)
> > +{
> > +     if (aplic_direct_parent_irq)
> > +             disable_percpu_irq(aplic_direct_parent_irq);
> > +
> > +     return 0;
> > +}
> > +
> > +static int aplic_direct_starting_cpu(unsigned int cpu)
> > +{
> > +     if (aplic_direct_parent_irq)
> > +             enable_percpu_irq(aplic_direct_parent_irq,
> > +                             irq_get_trigger_type(aplic_direct_parent_=
irq));
> > +
> > +     return 0;
> > +}
> > +
> > +int aplic_direct_setup(struct device *dev, void __iomem *regs)
> > +{
> > +     int i, j, rc, cpu, setup_count =3D 0;
> > +     struct fwnode_reference_args parent;
> > +     struct aplic_direct *direct;
> > +     struct aplic_priv *priv;
> > +     struct irq_domain *domain;
> > +     unsigned long hartid;
> > +     struct aplic_idc *idc;
> > +     u32 val;
> > +
> > +     direct =3D kzalloc(sizeof(*direct), GFP_KERNEL);
> > +     if (!direct)
> > +             return -ENOMEM;
> > +     priv =3D &direct->priv;
> > +
> > +     rc =3D aplic_setup_priv(priv, dev, regs);
> > +     if (rc) {
> > +             dev_err(dev, "failed to create APLIC context\n");
> > +             kfree(direct);
> > +             return rc;
> > +     }
> > +
> > +     /* Setup per-CPU IDC and target CPU mask */
> > +     for (i =3D 0; i < priv->nr_idcs; i++) {
> > +             rc =3D fwnode_property_get_reference_args(dev->fwnode,
> > +                             "interrupts-extended", "#interrupt-cells"=
,
> > +                             0, i, &parent);
> > +             if (rc) {
> > +                     dev_warn(dev, "parent irq for IDC%d not found\n",=
 i);
> > +                     continue;
> > +             }
> > +
> > +             /*
> > +              * Skip interrupts other than external interrupts for
> > +              * current privilege level.
> > +              */
> > +             if (parent.args[0] !=3D RV_IRQ_EXT)
> > +                     continue;
> > +
> > +             rc =3D riscv_get_intc_hartid(parent.fwnode, &hartid);
> > +             if (rc) {
> > +                     dev_warn(dev, "invalid hartid for IDC%d\n", i);
> > +                     continue;
> > +             }
> > +
> > +             cpu =3D riscv_hartid_to_cpuid(hartid);
> > +             if (cpu < 0) {
> > +                     dev_warn(dev, "invalid cpuid for IDC%d\n", i);
> > +                     continue;
> > +             }
> > +
> > +             cpumask_set_cpu(cpu, &direct->lmask);
> > +
> > +             idc =3D per_cpu_ptr(&aplic_idcs, cpu);
> > +             idc->hart_index =3D i;
> > +             idc->regs =3D priv->regs + APLIC_IDC_BASE + i * APLIC_IDC=
_SIZE;
> > +             idc->direct =3D direct;
> > +
> > +             aplic_idc_set_delivery(idc, true);
> > +
> > +             /*
> > +              * Boot cpu might not have APLIC hart_index =3D 0 so chec=
k
> > +              * and update target registers of all interrupts.
> > +              */
> > +             if (cpu =3D=3D smp_processor_id() && idc->hart_index) {
> > +                     val =3D idc->hart_index & APLIC_TARGET_HART_IDX_M=
ASK;
> > +                     val <<=3D APLIC_TARGET_HART_IDX_SHIFT;
> > +                     val |=3D APLIC_DEFAULT_PRIORITY;
> > +                     for (j =3D 1; j <=3D priv->nr_irqs; j++)
> > +                             writel(val, priv->regs + APLIC_TARGET_BAS=
E +
> > +                                         (j - 1) * sizeof(u32));
> > +             }
> > +
> > +             setup_count++;
> > +     }
> > +
> > +     /* Find parent domain and register chained handler */
> > +     domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode(),
> > +                                       DOMAIN_BUS_ANY);
> > +     if (!aplic_direct_parent_irq && domain) {
> > +             aplic_direct_parent_irq =3D irq_create_mapping(domain, RV=
_IRQ_EXT);
> > +             if (aplic_direct_parent_irq) {
> > +                     irq_set_chained_handler(aplic_direct_parent_irq,
> > +                                             aplic_direct_handle_irq);
> > +
> > +                     /*
> > +                      * Setup CPUHP notifier to enable parent
> > +                      * interrupt on all CPUs
> > +                      */
> > +                     cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> > +                                       "irqchip/riscv/aplic:starting",
> > +                                       aplic_direct_starting_cpu,
> > +                                       aplic_direct_dying_cpu);
> > +             }
> > +     }
> > +
> > +     /* Fail if we were not able to setup IDC for any CPU */
> > +     if (!setup_count) {
> > +             kfree(direct);
> > +             return -ENODEV;
> > +     }
> > +
> > +     /* Setup global config and interrupt delivery */
> > +     aplic_init_hw_global(priv, false);
> > +
> > +     /* Create irq domain instance for the APLIC */
> > +     direct->irqdomain =3D irq_domain_create_linear(dev->fwnode,
> > +                                                priv->nr_irqs + 1,
> > +                                                &aplic_direct_irqdomai=
n_ops,
> > +                                                priv);
> > +     if (!direct->irqdomain) {
> > +             dev_err(dev, "failed to create direct irq domain\n");
> > +             kfree(direct);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     /* Advertise the interrupt controller */
> > +     dev_info(dev, "%d interrupts directly connected to %d CPUs\n",
> > +              priv->nr_irqs, priv->nr_idcs);
> > +
> > +     return 0;
> > +}
> > diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/i=
rq-riscv-aplic-main.c
> > new file mode 100644
> > index 000000000000..d62a096774c4
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-riscv-aplic-main.c
> > @@ -0,0 +1,240 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> > + * Copyright (C) 2022 Ventana Micro Systems Inc.
> > + */
> > +
> > +#include <linux/printk.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/irqchip/riscv-aplic.h>
> > +
> > +#include "irq-riscv-aplic-main.h"
> > +
> > +void aplic_irq_unmask(struct irq_data *d)
> > +{
> > +     struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> > +
> > +     writel(d->hwirq, priv->regs + APLIC_SETIENUM);
> > +}
> > +
> > +void aplic_irq_mask(struct irq_data *d)
> > +{
> > +     struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> > +
> > +     writel(d->hwirq, priv->regs + APLIC_CLRIENUM);
> > +}
> > +
> > +int aplic_irq_set_type(struct irq_data *d, unsigned int type)
> > +{
> > +     u32 val =3D 0;
> > +     void __iomem *sourcecfg;
> > +     struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> > +
> > +     switch (type) {
> > +     case IRQ_TYPE_NONE:
> > +             val =3D APLIC_SOURCECFG_SM_INACTIVE;
> > +             break;
> > +     case IRQ_TYPE_LEVEL_LOW:
> > +             val =3D APLIC_SOURCECFG_SM_LEVEL_LOW;
> > +             break;
> > +     case IRQ_TYPE_LEVEL_HIGH:
> > +             val =3D APLIC_SOURCECFG_SM_LEVEL_HIGH;
> > +             break;
> > +     case IRQ_TYPE_EDGE_FALLING:
> > +             val =3D APLIC_SOURCECFG_SM_EDGE_FALL;
> > +             break;
> > +     case IRQ_TYPE_EDGE_RISING:
> > +             val =3D APLIC_SOURCECFG_SM_EDGE_RISE;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     sourcecfg =3D priv->regs + APLIC_SOURCECFG_BASE;
> > +     sourcecfg +=3D (d->hwirq - 1) * sizeof(u32);
> > +     writel(val, sourcecfg);
> > +
> > +     return 0;
> > +}
> > +
> > +int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u32 gsi_base,
> > +                           unsigned long *hwirq, unsigned int *type)
> > +{
> > +     if (WARN_ON(fwspec->param_count < 2))
> > +             return -EINVAL;
> > +     if (WARN_ON(!fwspec->param[0]))
> > +             return -EINVAL;
> > +
> > +     /* For DT, gsi_base is always zero. */
> > +     *hwirq =3D fwspec->param[0] - gsi_base;
> > +     *type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
> > +
> > +     WARN_ON(*type =3D=3D IRQ_TYPE_NONE);
> > +
> > +     return 0;
> > +}
> > +
> > +void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode)
> > +{
> > +     u32 val;
> > +#ifdef CONFIG_RISCV_M_MODE
> > +     u32 valH;
> > +
> > +     if (msi_mode) {
> > +             val =3D priv->msicfg.base_ppn;
> > +             valH =3D ((u64)priv->msicfg.base_ppn >> 32) &
> > +                     APLIC_xMSICFGADDRH_BAPPN_MASK;
> > +             valH |=3D (priv->msicfg.lhxw & APLIC_xMSICFGADDRH_LHXW_MA=
SK)
> > +                     << APLIC_xMSICFGADDRH_LHXW_SHIFT;
> > +             valH |=3D (priv->msicfg.hhxw & APLIC_xMSICFGADDRH_HHXW_MA=
SK)
> > +                     << APLIC_xMSICFGADDRH_HHXW_SHIFT;
> > +             valH |=3D (priv->msicfg.lhxs & APLIC_xMSICFGADDRH_LHXS_MA=
SK)
> > +                     << APLIC_xMSICFGADDRH_LHXS_SHIFT;
> > +             valH |=3D (priv->msicfg.hhxs & APLIC_xMSICFGADDRH_HHXS_MA=
SK)
> > +                     << APLIC_xMSICFGADDRH_HHXS_SHIFT;
> > +             writel(val, priv->regs + APLIC_xMSICFGADDR);
> > +             writel(valH, priv->regs + APLIC_xMSICFGADDRH);
> > +     }
> > +#endif
> > +
> > +     /* Setup APLIC domaincfg register */
> > +     val =3D readl(priv->regs + APLIC_DOMAINCFG);
> > +     val |=3D APLIC_DOMAINCFG_IE;
> > +     if (msi_mode)
> > +             val |=3D APLIC_DOMAINCFG_DM;
> > +     writel(val, priv->regs + APLIC_DOMAINCFG);
> > +     if (readl(priv->regs + APLIC_DOMAINCFG) !=3D val)
> > +             dev_warn(priv->dev, "unable to write 0x%x in domaincfg\n"=
,
> > +                      val);
> > +}
> > +
> > +static void aplic_init_hw_irqs(struct aplic_priv *priv)
> > +{
> > +     int i;
> > +
> > +     /* Disable all interrupts */
> > +     for (i =3D 0; i <=3D priv->nr_irqs; i +=3D 32)
> > +             writel(-1U, priv->regs + APLIC_CLRIE_BASE +
> > +                         (i / 32) * sizeof(u32));
> > +
> > +     /* Set interrupt type and default priority for all interrupts */
> > +     for (i =3D 1; i <=3D priv->nr_irqs; i++) {
> > +             writel(0, priv->regs + APLIC_SOURCECFG_BASE +
> > +                       (i - 1) * sizeof(u32));
> > +             writel(APLIC_DEFAULT_PRIORITY,
> > +                    priv->regs + APLIC_TARGET_BASE +
> > +                    (i - 1) * sizeof(u32));
> > +     }
> > +
> > +     /* Clear APLIC domaincfg */
> > +     writel(0, priv->regs + APLIC_DOMAINCFG);
> > +}
> > +
> > +int aplic_setup_priv(struct aplic_priv *priv, struct device *dev,
> > +                  void __iomem *regs)
> > +{
> > +     struct fwnode_reference_args parent;
> > +     int rc;
> > +
> > +     /* Save device pointer and register base */
> > +     priv->dev =3D dev;
> > +     priv->regs =3D regs;
> > +
> > +     /*
> > +      * Find out GSI base number
> > +      *
> > +      * Note: DT does not define "riscv,gsi-base" property so GSI
> > +      * base is always zero for DT.
> > +      */
> > +     rc =3D fwnode_property_read_u32_array(dev->fwnode, "riscv,gsi-bas=
e",
> > +                                         &priv->gsi_base, 1);
> For DT, you can just initialize this to 0 without reading the property.

Okay, I will update.

>
> > +     if (rc)
> > +             priv->gsi_base =3D 0;
> > +
> > +     /* Find out number of interrupt sources */
> > +     rc =3D fwnode_property_read_u32_array(dev->fwnode, "riscv,num-sou=
rces",
> > +                                         &priv->nr_irqs, 1);
> > +     if (rc) {
> > +             dev_err(dev, "failed to get number of interrupt sources\n=
");
> > +             return rc;
> > +     }
> > +
> > +     /* Setup initial state APLIC interrupts */
> > +     aplic_init_hw_irqs(priv);
> > +
> > +     /*
> > +      * Find out number of IDCs based on parent interrupts
> > +      *
> > +      * If "msi-parent" property is present then we ignore the
> > +      * APLIC IDCs which forces the APLIC driver to use MSI mode.
> > +      */
> > +     if (!fwnode_property_present(dev->fwnode, "msi-parent")) {
> > +             while (!fwnode_property_get_reference_args(dev->fwnode,
> > +                             "interrupts-extended", "#interrupt-cells"=
,
> > +                             0, priv->nr_idcs, &parent))
> > +                     priv->nr_idcs++;
> > +     }
> > +
> Can this finding nr_idcs be done after aplic_init_hw_irqs() above?

Okay, I will update.

>
> > +     return 0;
> > +}
> > +
> > +static int aplic_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct resource *res;
> > +     void __iomem *regs;
> > +     int rc;
> > +
> > +     /* Map the MMIO registers */
> > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (!res) {
> > +             dev_err(dev, "failed to get MMIO resource\n");
> > +             return -EINVAL;
> > +     }
> > +     regs =3D devm_ioremap(&pdev->dev, res->start, resource_size(res))=
;
> > +     if (!regs) {
> > +             dev_err(dev, "failed map MMIO registers\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     /*
> > +      * If msi-parent property is present then setup APLIC MSI mode
> > +      * otherwise setup APLIC direct mode.
> > +      */
> > +     if (fwnode_property_present(dev->fwnode, "msi-parent"))
> Can this check be based on nr_idcs instead of checking for msi-parent
> again?

nr_idcs are not available at this point. I will think of something else
and maybe you can comment on v9 if it does not work for you.

>
> Thanks!
> Sunil
> > +             rc =3D -ENODEV;
> > +     else
> > +             rc =3D aplic_direct_setup(dev, regs);
> > +     if (rc) {
> > +             dev_err(dev, "failed setup APLIC in %s mode\n",
> > +                     fwnode_property_present(dev->fwnode, "msi-parent"=
) ?
> > +                     "MSI" : "direct");
> > +             return rc;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id aplic_match[] =3D {
> > +     { .compatible =3D "riscv,aplic" },
> > +     {}
> > +};
> > +
> > +static struct platform_driver aplic_driver =3D {
> > +     .driver =3D {
> > +             .name           =3D "riscv-aplic",
> > +             .of_match_table =3D aplic_match,
> > +     },
> > +     .probe =3D aplic_probe,
> > +};
> > +
> > +static int __init aplic_init(void)
> > +{
> > +     /*
> > +      * Register APLIC driver as early as possible so that APLIC
> > +      * platform device is probed as soon as it is created.
> > +      */
> > +     return platform_driver_register(&aplic_driver);
> > +}
> > +core_initcall(aplic_init);
> > diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip/i=
rq-riscv-aplic-main.h
> > new file mode 100644
> > index 000000000000..474a04229334
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-riscv-aplic-main.h
> > @@ -0,0 +1,45 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> > + * Copyright (C) 2022 Ventana Micro Systems Inc.
> > + */
> > +
> > +#ifndef _IRQ_RISCV_APLIC_MAIN_H
> > +#define _IRQ_RISCV_APLIC_MAIN_H
> > +
> > +#include <linux/device.h>
> > +#include <linux/io.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/fwnode.h>
> > +
> > +#define APLIC_DEFAULT_PRIORITY               1
> > +
> > +struct aplic_msicfg {
> > +     phys_addr_t             base_ppn;
> > +     u32                     hhxs;
> > +     u32                     hhxw;
> > +     u32                     lhxs;
> > +     u32                     lhxw;
> > +};
> > +
> > +struct aplic_priv {
> > +     struct device           *dev;
> > +     u32                     gsi_base;
> > +     u32                     nr_irqs;
> > +     u32                     nr_idcs;
> > +     void __iomem            *regs;
> > +     struct aplic_msicfg     msicfg;
> > +};
> > +
> > +void aplic_irq_unmask(struct irq_data *d);
> > +void aplic_irq_mask(struct irq_data *d);
> > +int aplic_irq_set_type(struct irq_data *d, unsigned int type);
> > +int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u32 gsi_base,
> > +                           unsigned long *hwirq, unsigned int *type);
> > +void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode);
> > +int aplic_setup_priv(struct aplic_priv *priv, struct device *dev,
> > +                  void __iomem *regs);
> > +int aplic_direct_setup(struct device *dev, void __iomem *regs);
> > +
> > +#endif
> > diff --git a/include/linux/irqchip/riscv-aplic.h b/include/linux/irqchi=
p/riscv-aplic.h
> > new file mode 100644
> > index 000000000000..97e198ea0109
> > --- /dev/null
> > +++ b/include/linux/irqchip/riscv-aplic.h
> > @@ -0,0 +1,119 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> > + * Copyright (C) 2022 Ventana Micro Systems Inc.
> > + */
> > +#ifndef __LINUX_IRQCHIP_RISCV_APLIC_H
> > +#define __LINUX_IRQCHIP_RISCV_APLIC_H
> > +
> > +#include <linux/bitops.h>
> > +
> > +#define APLIC_MAX_IDC                        BIT(14)
> > +#define APLIC_MAX_SOURCE             1024
> > +
> > +#define APLIC_DOMAINCFG                      0x0000
> > +#define APLIC_DOMAINCFG_RDONLY               0x80000000
> > +#define APLIC_DOMAINCFG_IE           BIT(8)
> > +#define APLIC_DOMAINCFG_DM           BIT(2)
> > +#define APLIC_DOMAINCFG_BE           BIT(0)
> > +
> > +#define APLIC_SOURCECFG_BASE         0x0004
> > +#define APLIC_SOURCECFG_D            BIT(10)
> > +#define APLIC_SOURCECFG_CHILDIDX_MASK        0x000003ff
> > +#define APLIC_SOURCECFG_SM_MASK      0x00000007
> > +#define APLIC_SOURCECFG_SM_INACTIVE  0x0
> > +#define APLIC_SOURCECFG_SM_DETACH    0x1
> > +#define APLIC_SOURCECFG_SM_EDGE_RISE 0x4
> > +#define APLIC_SOURCECFG_SM_EDGE_FALL 0x5
> > +#define APLIC_SOURCECFG_SM_LEVEL_HIGH        0x6
> > +#define APLIC_SOURCECFG_SM_LEVEL_LOW 0x7
> > +
> > +#define APLIC_MMSICFGADDR            0x1bc0
> > +#define APLIC_MMSICFGADDRH           0x1bc4
> > +#define APLIC_SMSICFGADDR            0x1bc8
> > +#define APLIC_SMSICFGADDRH           0x1bcc
> > +
> > +#ifdef CONFIG_RISCV_M_MODE
> > +#define APLIC_xMSICFGADDR            APLIC_MMSICFGADDR
> > +#define APLIC_xMSICFGADDRH           APLIC_MMSICFGADDRH
> > +#else
> > +#define APLIC_xMSICFGADDR            APLIC_SMSICFGADDR
> > +#define APLIC_xMSICFGADDRH           APLIC_SMSICFGADDRH
> > +#endif
> > +
> > +#define APLIC_xMSICFGADDRH_L         BIT(31)
> > +#define APLIC_xMSICFGADDRH_HHXS_MASK 0x1f
> > +#define APLIC_xMSICFGADDRH_HHXS_SHIFT        24
> > +#define APLIC_xMSICFGADDRH_LHXS_MASK 0x7
> > +#define APLIC_xMSICFGADDRH_LHXS_SHIFT        20
> > +#define APLIC_xMSICFGADDRH_HHXW_MASK 0x7
> > +#define APLIC_xMSICFGADDRH_HHXW_SHIFT        16
> > +#define APLIC_xMSICFGADDRH_LHXW_MASK 0xf
> > +#define APLIC_xMSICFGADDRH_LHXW_SHIFT        12
> > +#define APLIC_xMSICFGADDRH_BAPPN_MASK        0xfff
> > +
> > +#define APLIC_xMSICFGADDR_PPN_SHIFT  12
> > +
> > +#define APLIC_xMSICFGADDR_PPN_HART(__lhxs) \
> > +     (BIT(__lhxs) - 1)
> > +
> > +#define APLIC_xMSICFGADDR_PPN_LHX_MASK(__lhxw) \
> > +     (BIT(__lhxw) - 1)
> > +#define APLIC_xMSICFGADDR_PPN_LHX_SHIFT(__lhxs) \
> > +     ((__lhxs))
> > +#define APLIC_xMSICFGADDR_PPN_LHX(__lhxw, __lhxs) \
> > +     (APLIC_xMSICFGADDR_PPN_LHX_MASK(__lhxw) << \
> > +      APLIC_xMSICFGADDR_PPN_LHX_SHIFT(__lhxs))
> > +
> > +#define APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) \
> > +     (BIT(__hhxw) - 1)
> > +#define APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs) \
> > +     ((__hhxs) + APLIC_xMSICFGADDR_PPN_SHIFT)
> > +#define APLIC_xMSICFGADDR_PPN_HHX(__hhxw, __hhxs) \
> > +     (APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) << \
> > +      APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs))
> > +
> > +#define APLIC_IRQBITS_PER_REG                32
> > +
> > +#define APLIC_SETIP_BASE             0x1c00
> > +#define APLIC_SETIPNUM                       0x1cdc
> > +
> > +#define APLIC_CLRIP_BASE             0x1d00
> > +#define APLIC_CLRIPNUM                       0x1ddc
> > +
> > +#define APLIC_SETIE_BASE             0x1e00
> > +#define APLIC_SETIENUM                       0x1edc
> > +
> > +#define APLIC_CLRIE_BASE             0x1f00
> > +#define APLIC_CLRIENUM                       0x1fdc
> > +
> > +#define APLIC_SETIPNUM_LE            0x2000
> > +#define APLIC_SETIPNUM_BE            0x2004
> > +
> > +#define APLIC_GENMSI                 0x3000
> > +
> > +#define APLIC_TARGET_BASE            0x3004
> > +#define APLIC_TARGET_HART_IDX_SHIFT  18
> > +#define APLIC_TARGET_HART_IDX_MASK   0x3fff
> > +#define APLIC_TARGET_GUEST_IDX_SHIFT 12
> > +#define APLIC_TARGET_GUEST_IDX_MASK  0x3f
> > +#define APLIC_TARGET_IPRIO_MASK      0xff
> > +#define APLIC_TARGET_EIID_MASK       0x7ff
> > +
> > +#define APLIC_IDC_BASE                       0x4000
> > +#define APLIC_IDC_SIZE                       32
> > +
> > +#define APLIC_IDC_IDELIVERY          0x00
> > +
> > +#define APLIC_IDC_IFORCE             0x04
> > +
> > +#define APLIC_IDC_ITHRESHOLD         0x08
> > +
> > +#define APLIC_IDC_TOPI                       0x18
> > +#define APLIC_IDC_TOPI_ID_SHIFT      16
> > +#define APLIC_IDC_TOPI_ID_MASK       0x3ff
> > +#define APLIC_IDC_TOPI_PRIO_MASK     0xff
> > +
> > +#define APLIC_IDC_CLAIMI             0x1c
> > +
> > +#endif
> > --
> > 2.34.1
> >

Regards,
Anup
