Return-Path: <linux-kernel+bounces-71128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B66D85A102
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5DA1F25CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99374286BC;
	Mon, 19 Feb 2024 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="d4qsS+vc"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BFD2C191
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708338543; cv=none; b=pSBL+zU8INXHxevQpNU2v3XNNJFrfOqLzXm4AQIIUIGZNFws/bB2XZpR5/SSXyrJ99g+tZ83wD2Wlc8o1dKI+3Xwp6qCCiQe2YHfYGzXL1iBscONM4Q+iC+sJnRMkpX+nFJ3v2rLxpFiwxyGeEezgWeLKiGavBpayR17E/l4V/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708338543; c=relaxed/simple;
	bh=6bWE1/eEMhhPW6lDcsFx4Xj+9J7AE9hST2K47CE55Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNq9B37CBsZPTBi/STWZbnVldMQEvRX8TXmnOvZWEiVO6+byRGBiqPWiBSPb0z/dgXG2D2haDhGnd4Pgf2apf3g1zQpLjrtmilzAuHVsr8HuzrmMCPqshsEKoaccra8q4gZEOFwMNv97xZyuFpB27Hnrh+rHYmX/3Dcexkx9xls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=d4qsS+vc; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5129cdae3c6so2435887e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708338539; x=1708943339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85mocgW3oUEn3KWRCMPfUir2jCHp+PRW/viW3ZhP39E=;
        b=d4qsS+vcp6YhPSo5ySUCXiw7sR+k6YVL/Wyu2qOL/MaeJ0c8PHx5GlzQzg8dcDvvR7
         xIZ6zriKD/KfAwXF2R6sa1jYzgi9HUXF+agJkZMLabEwJPXF3+iZi4kFQhA4z8yaWDS0
         tD0XEbqwntvieuHunmr726bhh1X0eI+iqO0RlJKZbbxPUkwdDx2Ijs67Xj1nRnzTxdnR
         MhobmEqVm32kCruXbXnCqAD5iI94br0TSSL1UOlfVBfNSRgRicluf+OZjJmIgJgzbnN0
         irKJdFoCDbHSe/qHEgzIgkmmmv/TGlY73YWp97B4VxrOpUrr2HmTVgWyUUJdYA6mrytA
         T7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708338539; x=1708943339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85mocgW3oUEn3KWRCMPfUir2jCHp+PRW/viW3ZhP39E=;
        b=onZCku5Lf9yYreLE3SsRh44nDyMoG0nUM5tq8tHdyNZ04MOCcJRgXRkndVHG8QuGIj
         IrV58+DOT1fCrMZPU4GCXkoIR+zacqPqCdsreSG7GLPLf5mAHddj1O1GmC8mhopBwcV/
         GWZRm8/hUDoJcF1xKeVk604YTsyoh6VqZq8QAhKBaNg8q2W6EQ44W/fHIRdPgPNhCAPq
         jYy6+xuCr+LAJ+KHPlNvHFBPm9gy/6SJ6jAtyV+ykhCzuK17F/B1tKOimrpzw0NGuQPp
         5hyHVsMFDnaomNQ1ElYZsauZ5qShSau504sTaRGDTZG0rM8GIv0MZfDca6d+XvYA8MJr
         RBLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqSc+xwoNPqWGjW3a5XLNiDCgZ/oKIa7aPKg1jp+DGB7vjFovHDl1G0QphBiaoDNAts8eOLJdk/iFkHgp8aN5+jRPnFxAkLuecvOsW
X-Gm-Message-State: AOJu0YwIaG8huZOJxVe72j23GotRQqSEoqSlBiE0W8Sp4GQ7Yk4MnLQ3
	0XQZ0Bxbtuw9UyeEB992x6l9XNmKlwHg9f1SxRuKvjKx4EwUyRfuxzYHspHA9O58uxEm6arHR3b
	cKUQwvQx7oQEJnYNK6OEu011IFqLoHzc/A+0kMw==
X-Google-Smtp-Source: AGHT+IGIcps8tvbHZe8HOdCscPvgwXU5z7zQr4v1Q+X/HJrX513EBbmSvX3flruyO8zCJ38rfH94uObFABE+n0mErXE=
X-Received: by 2002:a05:6512:2035:b0:512:aa3c:a9ff with SMTP id
 s21-20020a056512203500b00512aa3ca9ffmr2302570lfs.54.1708338538384; Mon, 19
 Feb 2024 02:28:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <20240127161753.114685-23-apatel@ventanamicro.com> <CABgGipWKTR95wrMrgKuq83auQdQfn9M29U7eq46_OJUCHqrBjQ@mail.gmail.com>
In-Reply-To: <CABgGipWKTR95wrMrgKuq83auQdQfn9M29U7eq46_OJUCHqrBjQ@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 19 Feb 2024 15:58:45 +0530
Message-ID: <CAK9=C2Vcq8Cyco-pN4RRfSjD_5S14gLSvwX817p1Tor9qxEyuQ@mail.gmail.com>
Subject: Re: [PATCH v12 22/25] irqchip: Add RISC-V advanced PLIC driver for direct-mode
To: Andy Chiu <andy.chiu@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>, Anup Patel <anup@brainfault.org>, 
	linux-kernel@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Atish Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 12:09=E2=80=AFPM Andy Chiu <andy.chiu@sifive.com> wr=
ote:
>
> Hi Anup,
>
> On Sun, Jan 28, 2024 at 12:24=E2=80=AFAM Anup Patel <apatel@ventanamicro.=
com> wrote:
> >
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
> >  drivers/irqchip/irq-riscv-aplic-direct.c | 343 +++++++++++++++++++++++
> >  drivers/irqchip/irq-riscv-aplic-main.c   | 232 +++++++++++++++
> >  drivers/irqchip/irq-riscv-aplic-main.h   |  45 +++
> >  include/linux/irqchip/riscv-aplic.h      | 119 ++++++++
> >  6 files changed, 745 insertions(+)
> >  create mode 100644 drivers/irqchip/irq-riscv-aplic-direct.c
> >  create mode 100644 drivers/irqchip/irq-riscv-aplic-main.c
> >  create mode 100644 drivers/irqchip/irq-riscv-aplic-main.h
> >  create mode 100644 include/linux/irqchip/riscv-aplic.h
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 2fc0cb32341a..dbc8811d3764 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -546,6 +546,11 @@ config SIFIVE_PLIC
> >         select IRQ_DOMAIN_HIERARCHY
> >         select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
> >
> > +config RISCV_APLIC
> > +       bool
> > +       depends on RISCV
> > +       select IRQ_DOMAIN_HIERARCHY
> > +
> >  config RISCV_IMSIC
> >         bool
> >         depends on RISCV
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index abca445a3229..7f8289790ed8 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -95,6 +95,7 @@ obj-$(CONFIG_QCOM_MPM)                        +=3D ir=
q-qcom-mpm.o
> >  obj-$(CONFIG_CSKY_MPINTC)              +=3D irq-csky-mpintc.o
> >  obj-$(CONFIG_CSKY_APB_INTC)            +=3D irq-csky-apb-intc.o
> >  obj-$(CONFIG_RISCV_INTC)               +=3D irq-riscv-intc.o
> > +obj-$(CONFIG_RISCV_APLIC)              +=3D irq-riscv-aplic-main.o irq=
-riscv-aplic-direct.o
> >  obj-$(CONFIG_RISCV_IMSIC)              +=3D irq-riscv-imsic-state.o ir=
q-riscv-imsic-early.o irq-riscv-imsic-platform.o
> >  obj-$(CONFIG_SIFIVE_PLIC)              +=3D irq-sifive-plic.o
> >  obj-$(CONFIG_IMX_IRQSTEER)             +=3D irq-imx-irqsteer.o
> > diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip=
/irq-riscv-aplic-direct.c
> > new file mode 100644
> > index 000000000000..9ed2666bfb5e
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-riscv-aplic-direct.c
> > @@ -0,0 +1,343 @@
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
> > +#define APLIC_DISABLE_IDELIVERY                0
> > +#define APLIC_ENABLE_IDELIVERY         1
> > +#define APLIC_DISABLE_ITHRESHOLD       1
> > +#define APLIC_ENABLE_ITHRESHOLD                0
> > +
> > +struct aplic_direct {
> > +       struct aplic_priv       priv;
> > +       struct irq_domain       *irqdomain;
> > +       struct cpumask          lmask;
> > +};
> > +
> > +struct aplic_idc {
> > +       unsigned int            hart_index;
> > +       void __iomem            *regs;
> > +       struct aplic_direct     *direct;
> > +};
> > +
> > +static unsigned int aplic_direct_parent_irq;
> > +static DEFINE_PER_CPU(struct aplic_idc, aplic_idcs);
> > +
> > +static void aplic_direct_irq_eoi(struct irq_data *d)
> > +{
> > +       /*
> > +        * The fasteoi_handler requires irq_eoi() callback hence
> > +        * provide a dummy handler.
> > +        */
> > +}
> > +
> > +#ifdef CONFIG_SMP
> > +static int aplic_direct_set_affinity(struct irq_data *d,
> > +                                 const struct cpumask *mask_val, bool =
force)
> > +{
> > +       struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> > +       struct aplic_direct *direct =3D
> > +                       container_of(priv, struct aplic_direct, priv);
> > +       struct aplic_idc *idc;
> > +       unsigned int cpu, val;
> > +       struct cpumask amask;
> > +       void __iomem *target;
> > +
> > +       cpumask_and(&amask, &direct->lmask, mask_val);
> > +
> > +       if (force)
> > +               cpu =3D cpumask_first(&amask);
> > +       else
> > +               cpu =3D cpumask_any_and(&amask, cpu_online_mask);
> > +
> > +       if (cpu >=3D nr_cpu_ids)
> > +               return -EINVAL;
> > +
> > +       idc =3D per_cpu_ptr(&aplic_idcs, cpu);
> > +       target =3D priv->regs + APLIC_TARGET_BASE;
> > +       target +=3D (d->hwirq - 1) * sizeof(u32);
> > +       val =3D idc->hart_index & APLIC_TARGET_HART_IDX_MASK;
> > +       val <<=3D APLIC_TARGET_HART_IDX_SHIFT;
> > +       val |=3D APLIC_DEFAULT_PRIORITY;
> > +       writel(val, target);
> > +
> > +       irq_data_update_effective_affinity(d, cpumask_of(cpu));
> > +
> > +       return IRQ_SET_MASK_OK_DONE;
> > +}
> > +#endif
> > +
> > +static struct irq_chip aplic_direct_chip =3D {
> > +       .name           =3D "APLIC-DIRECT",
> > +       .irq_mask       =3D aplic_irq_mask,
> > +       .irq_unmask     =3D aplic_irq_unmask,
> > +       .irq_set_type   =3D aplic_irq_set_type,
> > +       .irq_eoi        =3D aplic_direct_irq_eoi,
> > +#ifdef CONFIG_SMP
> > +       .irq_set_affinity =3D aplic_direct_set_affinity,
> > +#endif
> > +       .flags          =3D IRQCHIP_SET_TYPE_MASKED |
> > +                         IRQCHIP_SKIP_SET_WAKE |
> > +                         IRQCHIP_MASK_ON_SUSPEND,
> > +};
> > +
> > +static int aplic_direct_irqdomain_translate(struct irq_domain *d,
> > +                                        struct irq_fwspec *fwspec,
> > +                                        unsigned long *hwirq,
> > +                                        unsigned int *type)
> > +{
> > +       struct aplic_priv *priv =3D d->host_data;
> > +
> > +       return aplic_irqdomain_translate(fwspec, priv->gsi_base,
> > +                                        hwirq, type);
> > +}
> > +
> > +static int aplic_direct_irqdomain_alloc(struct irq_domain *domain,
> > +                                    unsigned int virq, unsigned int nr=
_irqs,
> > +                                    void *arg)
> > +{
> > +       int i, ret;
> > +       unsigned int type;
> > +       irq_hw_number_t hwirq;
> > +       struct irq_fwspec *fwspec =3D arg;
> > +       struct aplic_priv *priv =3D domain->host_data;
> > +       struct aplic_direct *direct =3D
> > +                       container_of(priv, struct aplic_direct, priv);
> > +
> > +       ret =3D aplic_irqdomain_translate(fwspec, priv->gsi_base,
> > +                                       &hwirq, &type);
> > +       if (ret)
> > +               return ret;
> > +
> > +       for (i =3D 0; i < nr_irqs; i++) {
> > +               irq_domain_set_info(domain, virq + i, hwirq + i,
> > +                                   &aplic_direct_chip, priv,
> > +                                   handle_fasteoi_irq, NULL, NULL);
> > +               irq_set_affinity(virq + i, &direct->lmask);
> > +               /* See the reason described in aplic_msi_irqdomain_allo=
c() */
> > +               irq_set_status_flags(virq + i, IRQ_DISABLE_UNLAZY);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct irq_domain_ops aplic_direct_irqdomain_ops =3D {
> > +       .translate      =3D aplic_direct_irqdomain_translate,
> > +       .alloc          =3D aplic_direct_irqdomain_alloc,
> > +       .free           =3D irq_domain_free_irqs_top,
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
> > +       struct aplic_idc *idc =3D this_cpu_ptr(&aplic_idcs);
> > +       struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +       struct irq_domain *irqdomain =3D idc->direct->irqdomain;
> > +       irq_hw_number_t hw_irq;
> > +       int irq;
> > +
> > +       chained_irq_enter(chip, desc);
> > +
> > +       while ((hw_irq =3D readl(idc->regs + APLIC_IDC_CLAIMI))) {
> > +               hw_irq =3D hw_irq >> APLIC_IDC_TOPI_ID_SHIFT;
> > +               irq =3D irq_find_mapping(irqdomain, hw_irq);
> > +
> > +               if (unlikely(irq <=3D 0))
> > +                       dev_warn_ratelimited(idc->direct->priv.dev,
> > +                                            "hw_irq %lu mapping not fo=
und\n",
> > +                                            hw_irq);
> > +               else
> > +                       generic_handle_irq(irq);
> > +       }
> > +
> > +       chained_irq_exit(chip, desc);
> > +}
> > +
> > +static void aplic_idc_set_delivery(struct aplic_idc *idc, bool en)
> > +{
> > +       u32 de =3D (en) ? APLIC_ENABLE_IDELIVERY : APLIC_DISABLE_IDELIV=
ERY;
> > +       u32 th =3D (en) ? APLIC_ENABLE_ITHRESHOLD : APLIC_DISABLE_ITHRE=
SHOLD;
> > +
> > +       /* Priority must be less than threshold for interrupt triggerin=
g */
> > +       writel(th, idc->regs + APLIC_IDC_ITHRESHOLD);
> > +
> > +       /* Delivery must be set to 1 for interrupt triggering */
> > +       writel(de, idc->regs + APLIC_IDC_IDELIVERY);
> > +}
> > +
> > +static int aplic_direct_dying_cpu(unsigned int cpu)
> > +{
> > +       if (aplic_direct_parent_irq)
> > +               disable_percpu_irq(aplic_direct_parent_irq);
> > +
> > +       return 0;
> > +}
> > +
> > +static int aplic_direct_starting_cpu(unsigned int cpu)
> > +{
> > +       if (aplic_direct_parent_irq)
> > +               enable_percpu_irq(aplic_direct_parent_irq,
> > +                               irq_get_trigger_type(aplic_direct_paren=
t_irq));
> > +
> > +       return 0;
> > +}
> > +
> > +static int aplic_direct_parse_parent_hwirq(struct device *dev,
> > +                                          u32 index, u32 *parent_hwirq=
,
> > +                                          unsigned long *parent_hartid=
)
> > +{
> > +       struct of_phandle_args parent;
> > +       int rc;
> > +
> > +       /*
> > +        * Currently, only OF fwnode is supported so extend this
> > +        * function for ACPI support.
> > +        */
> > +       if (!is_of_node(dev->fwnode))
> > +               return -EINVAL;
> > +
> > +       rc =3D of_irq_parse_one(to_of_node(dev->fwnode), index, &parent=
);
> > +       if (rc)
> > +               return rc;
> > +
> > +       rc =3D riscv_of_parent_hartid(parent.np, parent_hartid);
> > +       if (rc)
> > +               return rc;
> > +
> > +       *parent_hwirq =3D parent.args[0];
> > +       return 0;
> > +}
> > +
> > +int aplic_direct_setup(struct device *dev, void __iomem *regs)
> > +{
> > +       int i, j, rc, cpu, setup_count =3D 0;
> > +       struct aplic_direct *direct;
> > +       struct aplic_priv *priv;
> > +       struct irq_domain *domain;
> > +       unsigned long hartid;
> > +       struct aplic_idc *idc;
> > +       u32 val, hwirq;
> > +
> > +       direct =3D kzalloc(sizeof(*direct), GFP_KERNEL);
> > +       if (!direct)
> > +               return -ENOMEM;
> > +       priv =3D &direct->priv;
> > +
> > +       rc =3D aplic_setup_priv(priv, dev, regs);
> > +       if (rc) {
> > +               dev_err(dev, "failed to create APLIC context\n");
> > +               kfree(direct);
> > +               return rc;
> > +       }
> > +
> > +       /* Setup per-CPU IDC and target CPU mask */
> > +       for (i =3D 0; i < priv->nr_idcs; i++) {
> > +               rc =3D aplic_direct_parse_parent_hwirq(dev, i, &hwirq, =
&hartid);
> > +               if (rc) {
> > +                       dev_warn(dev, "parent irq for IDC%d not found\n=
", i);
> > +                       continue;
> > +               }
> > +
> > +               /*
> > +                * Skip interrupts other than external interrupts for
> > +                * current privilege level.
> > +                */
> > +               if (hwirq !=3D RV_IRQ_EXT)
> > +                       continue;
> > +
> > +               cpu =3D riscv_hartid_to_cpuid(hartid);
> > +               if (cpu < 0) {
> > +                       dev_warn(dev, "invalid cpuid for IDC%d\n", i);
> > +                       continue;
> > +               }
> > +
> > +               cpumask_set_cpu(cpu, &direct->lmask);
> > +
> > +               idc =3D per_cpu_ptr(&aplic_idcs, cpu);
> > +               idc->hart_index =3D i;
> > +               idc->regs =3D priv->regs + APLIC_IDC_BASE + i * APLIC_I=
DC_SIZE;
> > +               idc->direct =3D direct;
> > +
> > +               aplic_idc_set_delivery(idc, true);
> > +
> > +               /*
> > +                * Boot cpu might not have APLIC hart_index =3D 0 so ch=
eck
> > +                * and update target registers of all interrupts.
> > +                */
>
> IIUC, the use of smp_processor_id() has to be protected by turning off
> preemption. So maybe please consider adding:
>
> + preempt_disable();
>
> > +               if (cpu =3D=3D smp_processor_id() && idc->hart_index) {
> > +                       val =3D idc->hart_index & APLIC_TARGET_HART_IDX=
_MASK;
> > +                       val <<=3D APLIC_TARGET_HART_IDX_SHIFT;
> > +                       val |=3D APLIC_DEFAULT_PRIORITY;
> > +                       for (j =3D 1; j <=3D priv->nr_irqs; j++)
> > +                               writel(val, priv->regs + APLIC_TARGET_B=
ASE +
> > +                                           (j - 1) * sizeof(u32));
> > +               }
>
> , and here:
> + preempt_enable();
>
> Or use get_cpu()/put_cpu()  variant to guard the use of processor id.

The get_cpu()/put_cpu() is better so I'll use that in the next revision.

Regards,
Anup

>
> > +
> > +               setup_count++;
> > +       }
> > +
> > +       /* Find parent domain and register chained handler */
> > +       domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode(),
> > +                                         DOMAIN_BUS_ANY);
> > +       if (!aplic_direct_parent_irq && domain) {
> > +               aplic_direct_parent_irq =3D irq_create_mapping(domain, =
RV_IRQ_EXT);
> > +               if (aplic_direct_parent_irq) {
> > +                       irq_set_chained_handler(aplic_direct_parent_irq=
,
> > +                                               aplic_direct_handle_irq=
);
> > +
> > +                       /*
> > +                        * Setup CPUHP notifier to enable parent
> > +                        * interrupt on all CPUs
> > +                        */
> > +                       cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> > +                                         "irqchip/riscv/aplic:starting=
",
> > +                                         aplic_direct_starting_cpu,
> > +                                         aplic_direct_dying_cpu);
> > +               }
> > +       }
> > +
> > +       /* Fail if we were not able to setup IDC for any CPU */
> > +       if (!setup_count) {
> > +               kfree(direct);
> > +               return -ENODEV;
> > +       }
> > +
> > +       /* Setup global config and interrupt delivery */
> > +       aplic_init_hw_global(priv, false);
> > +
> > +       /* Create irq domain instance for the APLIC */
> > +       direct->irqdomain =3D irq_domain_create_linear(dev->fwnode,
> > +                                                  priv->nr_irqs + 1,
> > +                                                  &aplic_direct_irqdom=
ain_ops,
> > +                                                  priv);
> > +       if (!direct->irqdomain) {
> > +               dev_err(dev, "failed to create direct irq domain\n");
> > +               kfree(direct);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       /* Advertise the interrupt controller */
> > +       dev_info(dev, "%d interrupts directly connected to %d CPUs\n",
> > +                priv->nr_irqs, priv->nr_idcs);
> > +
> > +       return 0;
> > +}
> > diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/i=
rq-riscv-aplic-main.c
> > new file mode 100644
> > index 000000000000..87450708a733
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-riscv-aplic-main.c
> > @@ -0,0 +1,232 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> > + * Copyright (C) 2022 Ventana Micro Systems Inc.
> > + */
> > +
> > +#include <linux/of.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/printk.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/irqchip/riscv-aplic.h>
> > +
> > +#include "irq-riscv-aplic-main.h"
> > +
> > +void aplic_irq_unmask(struct irq_data *d)
> > +{
> > +       struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> > +
> > +       writel(d->hwirq, priv->regs + APLIC_SETIENUM);
> > +}
> > +
> > +void aplic_irq_mask(struct irq_data *d)
> > +{
> > +       struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> > +
> > +       writel(d->hwirq, priv->regs + APLIC_CLRIENUM);
> > +}
> > +
> > +int aplic_irq_set_type(struct irq_data *d, unsigned int type)
> > +{
> > +       u32 val =3D 0;
> > +       void __iomem *sourcecfg;
> > +       struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> > +
> > +       switch (type) {
> > +       case IRQ_TYPE_NONE:
> > +               val =3D APLIC_SOURCECFG_SM_INACTIVE;
> > +               break;
> > +       case IRQ_TYPE_LEVEL_LOW:
> > +               val =3D APLIC_SOURCECFG_SM_LEVEL_LOW;
> > +               break;
> > +       case IRQ_TYPE_LEVEL_HIGH:
> > +               val =3D APLIC_SOURCECFG_SM_LEVEL_HIGH;
> > +               break;
> > +       case IRQ_TYPE_EDGE_FALLING:
> > +               val =3D APLIC_SOURCECFG_SM_EDGE_FALL;
> > +               break;
> > +       case IRQ_TYPE_EDGE_RISING:
> > +               val =3D APLIC_SOURCECFG_SM_EDGE_RISE;
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       sourcecfg =3D priv->regs + APLIC_SOURCECFG_BASE;
> > +       sourcecfg +=3D (d->hwirq - 1) * sizeof(u32);
> > +       writel(val, sourcecfg);
> > +
> > +       return 0;
> > +}
> > +
> > +int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u32 gsi_base,
> > +                             unsigned long *hwirq, unsigned int *type)
> > +{
> > +       if (WARN_ON(fwspec->param_count < 2))
> > +               return -EINVAL;
> > +       if (WARN_ON(!fwspec->param[0]))
> > +               return -EINVAL;
> > +
> > +       /* For DT, gsi_base is always zero. */
> > +       *hwirq =3D fwspec->param[0] - gsi_base;
> > +       *type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
> > +
> > +       WARN_ON(*type =3D=3D IRQ_TYPE_NONE);
> > +
> > +       return 0;
> > +}
> > +
> > +void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode)
> > +{
> > +       u32 val;
> > +#ifdef CONFIG_RISCV_M_MODE
> > +       u32 valH;
> > +
> > +       if (msi_mode) {
> > +               val =3D priv->msicfg.base_ppn;
> > +               valH =3D ((u64)priv->msicfg.base_ppn >> 32) &
> > +                       APLIC_xMSICFGADDRH_BAPPN_MASK;
> > +               valH |=3D (priv->msicfg.lhxw & APLIC_xMSICFGADDRH_LHXW_=
MASK)
> > +                       << APLIC_xMSICFGADDRH_LHXW_SHIFT;
> > +               valH |=3D (priv->msicfg.hhxw & APLIC_xMSICFGADDRH_HHXW_=
MASK)
> > +                       << APLIC_xMSICFGADDRH_HHXW_SHIFT;
> > +               valH |=3D (priv->msicfg.lhxs & APLIC_xMSICFGADDRH_LHXS_=
MASK)
> > +                       << APLIC_xMSICFGADDRH_LHXS_SHIFT;
> > +               valH |=3D (priv->msicfg.hhxs & APLIC_xMSICFGADDRH_HHXS_=
MASK)
> > +                       << APLIC_xMSICFGADDRH_HHXS_SHIFT;
> > +               writel(val, priv->regs + APLIC_xMSICFGADDR);
> > +               writel(valH, priv->regs + APLIC_xMSICFGADDRH);
> > +       }
> > +#endif
> > +
> > +       /* Setup APLIC domaincfg register */
> > +       val =3D readl(priv->regs + APLIC_DOMAINCFG);
> > +       val |=3D APLIC_DOMAINCFG_IE;
> > +       if (msi_mode)
> > +               val |=3D APLIC_DOMAINCFG_DM;
> > +       writel(val, priv->regs + APLIC_DOMAINCFG);
> > +       if (readl(priv->regs + APLIC_DOMAINCFG) !=3D val)
> > +               dev_warn(priv->dev, "unable to write 0x%x in domaincfg\=
n",
> > +                        val);
> > +}
> > +
> > +static void aplic_init_hw_irqs(struct aplic_priv *priv)
> > +{
> > +       int i;
> > +
> > +       /* Disable all interrupts */
> > +       for (i =3D 0; i <=3D priv->nr_irqs; i +=3D 32)
> > +               writel(-1U, priv->regs + APLIC_CLRIE_BASE +
> > +                           (i / 32) * sizeof(u32));
> > +
> > +       /* Set interrupt type and default priority for all interrupts *=
/
> > +       for (i =3D 1; i <=3D priv->nr_irqs; i++) {
> > +               writel(0, priv->regs + APLIC_SOURCECFG_BASE +
> > +                         (i - 1) * sizeof(u32));
> > +               writel(APLIC_DEFAULT_PRIORITY,
> > +                      priv->regs + APLIC_TARGET_BASE +
> > +                      (i - 1) * sizeof(u32));
> > +       }
> > +
> > +       /* Clear APLIC domaincfg */
> > +       writel(0, priv->regs + APLIC_DOMAINCFG);
> > +}
> > +
> > +int aplic_setup_priv(struct aplic_priv *priv, struct device *dev,
> > +                    void __iomem *regs)
> > +{
> > +       struct of_phandle_args parent;
> > +       int rc;
> > +
> > +       /*
> > +        * Currently, only OF fwnode is supported so extend this
> > +        * function for ACPI support.
> > +        */
> > +       if (!is_of_node(dev->fwnode))
> > +               return -EINVAL;
> > +
> > +       /* Save device pointer and register base */
> > +       priv->dev =3D dev;
> > +       priv->regs =3D regs;
> > +
> > +       /* Find out number of interrupt sources */
> > +       rc =3D of_property_read_u32(to_of_node(dev->fwnode),
> > +                                            "riscv,num-sources",
> > +                                            &priv->nr_irqs);
> > +       if (rc) {
> > +               dev_err(dev, "failed to get number of interrupt sources=
\n");
> > +               return rc;
> > +       }
> > +
> > +       /*
> > +        * Find out number of IDCs based on parent interrupts
> > +        *
> > +        * If "msi-parent" property is present then we ignore the
> > +        * APLIC IDCs which forces the APLIC driver to use MSI mode.
> > +        */
> > +       if (!of_property_present(to_of_node(dev->fwnode), "msi-parent")=
) {
> > +               while (!of_irq_parse_one(to_of_node(dev->fwnode),
> > +                                        priv->nr_idcs, &parent))
> > +                       priv->nr_idcs++;
> > +       }
> > +
> > +       /* Setup initial state APLIC interrupts */
> > +       aplic_init_hw_irqs(priv);
> > +
> > +       return 0;
> > +}
> > +
> > +static int aplic_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev =3D &pdev->dev;
> > +       bool msi_mode =3D false;
> > +       struct resource *res;
> > +       void __iomem *regs;
> > +       int rc;
> > +
> > +       /* Map the MMIO registers */
> > +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (!res) {
> > +               dev_err(dev, "failed to get MMIO resource\n");
> > +               return -EINVAL;
> > +       }
> > +       regs =3D devm_ioremap(&pdev->dev, res->start, resource_size(res=
));
> > +       if (!regs) {
> > +               dev_err(dev, "failed map MMIO registers\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       /*
> > +        * If msi-parent property is present then setup APLIC MSI
> > +        * mode otherwise setup APLIC direct mode.
> > +        */
> > +       if (is_of_node(dev->fwnode))
> > +               msi_mode =3D of_property_present(to_of_node(dev->fwnode=
),
> > +                                               "msi-parent");
> > +       if (msi_mode)
> > +               rc =3D -ENODEV;
> > +       else
> > +               rc =3D aplic_direct_setup(dev, regs);
> > +       if (rc) {
> > +               dev_err(dev, "failed setup APLIC in %s mode\n",
> > +                       msi_mode ? "MSI" : "direct");
> > +               return rc;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct of_device_id aplic_match[] =3D {
> > +       { .compatible =3D "riscv,aplic" },
> > +       {}
> > +};
> > +
> > +static struct platform_driver aplic_driver =3D {
> > +       .driver =3D {
> > +               .name           =3D "riscv-aplic",
> > +               .of_match_table =3D aplic_match,
> > +       },
> > +       .probe =3D aplic_probe,
> > +};
> > +builtin_platform_driver(aplic_driver);
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
> > +#define APLIC_DEFAULT_PRIORITY         1
> > +
> > +struct aplic_msicfg {
> > +       phys_addr_t             base_ppn;
> > +       u32                     hhxs;
> > +       u32                     hhxw;
> > +       u32                     lhxs;
> > +       u32                     lhxw;
> > +};
> > +
> > +struct aplic_priv {
> > +       struct device           *dev;
> > +       u32                     gsi_base;
> > +       u32                     nr_irqs;
> > +       u32                     nr_idcs;
> > +       void __iomem            *regs;
> > +       struct aplic_msicfg     msicfg;
> > +};
> > +
> > +void aplic_irq_unmask(struct irq_data *d);
> > +void aplic_irq_mask(struct irq_data *d);
> > +int aplic_irq_set_type(struct irq_data *d, unsigned int type);
> > +int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u32 gsi_base,
> > +                             unsigned long *hwirq, unsigned int *type)=
;
> > +void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode);
> > +int aplic_setup_priv(struct aplic_priv *priv, struct device *dev,
> > +                    void __iomem *regs);
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
> > +#define APLIC_MAX_IDC                  BIT(14)
> > +#define APLIC_MAX_SOURCE               1024
> > +
> > +#define APLIC_DOMAINCFG                        0x0000
> > +#define APLIC_DOMAINCFG_RDONLY         0x80000000
> > +#define APLIC_DOMAINCFG_IE             BIT(8)
> > +#define APLIC_DOMAINCFG_DM             BIT(2)
> > +#define APLIC_DOMAINCFG_BE             BIT(0)
> > +
> > +#define APLIC_SOURCECFG_BASE           0x0004
> > +#define APLIC_SOURCECFG_D              BIT(10)
> > +#define APLIC_SOURCECFG_CHILDIDX_MASK  0x000003ff
> > +#define APLIC_SOURCECFG_SM_MASK        0x00000007
> > +#define APLIC_SOURCECFG_SM_INACTIVE    0x0
> > +#define APLIC_SOURCECFG_SM_DETACH      0x1
> > +#define APLIC_SOURCECFG_SM_EDGE_RISE   0x4
> > +#define APLIC_SOURCECFG_SM_EDGE_FALL   0x5
> > +#define APLIC_SOURCECFG_SM_LEVEL_HIGH  0x6
> > +#define APLIC_SOURCECFG_SM_LEVEL_LOW   0x7
> > +
> > +#define APLIC_MMSICFGADDR              0x1bc0
> > +#define APLIC_MMSICFGADDRH             0x1bc4
> > +#define APLIC_SMSICFGADDR              0x1bc8
> > +#define APLIC_SMSICFGADDRH             0x1bcc
> > +
> > +#ifdef CONFIG_RISCV_M_MODE
> > +#define APLIC_xMSICFGADDR              APLIC_MMSICFGADDR
> > +#define APLIC_xMSICFGADDRH             APLIC_MMSICFGADDRH
> > +#else
> > +#define APLIC_xMSICFGADDR              APLIC_SMSICFGADDR
> > +#define APLIC_xMSICFGADDRH             APLIC_SMSICFGADDRH
> > +#endif
> > +
> > +#define APLIC_xMSICFGADDRH_L           BIT(31)
> > +#define APLIC_xMSICFGADDRH_HHXS_MASK   0x1f
> > +#define APLIC_xMSICFGADDRH_HHXS_SHIFT  24
> > +#define APLIC_xMSICFGADDRH_LHXS_MASK   0x7
> > +#define APLIC_xMSICFGADDRH_LHXS_SHIFT  20
> > +#define APLIC_xMSICFGADDRH_HHXW_MASK   0x7
> > +#define APLIC_xMSICFGADDRH_HHXW_SHIFT  16
> > +#define APLIC_xMSICFGADDRH_LHXW_MASK   0xf
> > +#define APLIC_xMSICFGADDRH_LHXW_SHIFT  12
> > +#define APLIC_xMSICFGADDRH_BAPPN_MASK  0xfff
> > +
> > +#define APLIC_xMSICFGADDR_PPN_SHIFT    12
> > +
> > +#define APLIC_xMSICFGADDR_PPN_HART(__lhxs) \
> > +       (BIT(__lhxs) - 1)
> > +
> > +#define APLIC_xMSICFGADDR_PPN_LHX_MASK(__lhxw) \
> > +       (BIT(__lhxw) - 1)
> > +#define APLIC_xMSICFGADDR_PPN_LHX_SHIFT(__lhxs) \
> > +       ((__lhxs))
> > +#define APLIC_xMSICFGADDR_PPN_LHX(__lhxw, __lhxs) \
> > +       (APLIC_xMSICFGADDR_PPN_LHX_MASK(__lhxw) << \
> > +        APLIC_xMSICFGADDR_PPN_LHX_SHIFT(__lhxs))
> > +
> > +#define APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) \
> > +       (BIT(__hhxw) - 1)
> > +#define APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs) \
> > +       ((__hhxs) + APLIC_xMSICFGADDR_PPN_SHIFT)
> > +#define APLIC_xMSICFGADDR_PPN_HHX(__hhxw, __hhxs) \
> > +       (APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) << \
> > +        APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs))
> > +
> > +#define APLIC_IRQBITS_PER_REG          32
> > +
> > +#define APLIC_SETIP_BASE               0x1c00
> > +#define APLIC_SETIPNUM                 0x1cdc
> > +
> > +#define APLIC_CLRIP_BASE               0x1d00
> > +#define APLIC_CLRIPNUM                 0x1ddc
> > +
> > +#define APLIC_SETIE_BASE               0x1e00
> > +#define APLIC_SETIENUM                 0x1edc
> > +
> > +#define APLIC_CLRIE_BASE               0x1f00
> > +#define APLIC_CLRIENUM                 0x1fdc
> > +
> > +#define APLIC_SETIPNUM_LE              0x2000
> > +#define APLIC_SETIPNUM_BE              0x2004
> > +
> > +#define APLIC_GENMSI                   0x3000
> > +
> > +#define APLIC_TARGET_BASE              0x3004
> > +#define APLIC_TARGET_HART_IDX_SHIFT    18
> > +#define APLIC_TARGET_HART_IDX_MASK     0x3fff
> > +#define APLIC_TARGET_GUEST_IDX_SHIFT   12
> > +#define APLIC_TARGET_GUEST_IDX_MASK    0x3f
> > +#define APLIC_TARGET_IPRIO_MASK        0xff
> > +#define APLIC_TARGET_EIID_MASK 0x7ff
> > +
> > +#define APLIC_IDC_BASE                 0x4000
> > +#define APLIC_IDC_SIZE                 32
> > +
> > +#define APLIC_IDC_IDELIVERY            0x00
> > +
> > +#define APLIC_IDC_IFORCE               0x04
> > +
> > +#define APLIC_IDC_ITHRESHOLD           0x08
> > +
> > +#define APLIC_IDC_TOPI                 0x18
> > +#define APLIC_IDC_TOPI_ID_SHIFT        16
> > +#define APLIC_IDC_TOPI_ID_MASK 0x3ff
> > +#define APLIC_IDC_TOPI_PRIO_MASK       0xff
> > +
> > +#define APLIC_IDC_CLAIMI               0x1c
> > +
> > +#endif
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> Thanks,
> Andy

