Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B703C7D6103
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 07:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjJYFIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 01:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJYFId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 01:08:33 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E2412A
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 22:08:28 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5b8c39a2dceso2034847a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 22:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698210508; x=1698815308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3n7UlKbKi4rqQul/Gmrnlf7oZJLDEigJSkuhM0lZchQ=;
        b=jheUptWUvRrn2Krkg3NElkVuOBVoag6ZwcYiW7Uiv8DFJSRSqWOLDQ5Zm/qLEIsEiy
         peavLjVi7+zzE3AmyKyTfZCOZfxAWNBTXgQQyC+OVlKlP1gM74OFAw5/xwupasfI+k5a
         jUv6TUZKGoczt0OOFANxXFECeQ+eyljgs84GpKvooGi5OIvzN2evqTdCv9znW2UqRaaH
         igoydk+Y3ROnhJdPXe8UFFa4VCadGxjcgQeCX10qQ4d5uDfPVSb0MCq1xr1ju6YL0UjK
         ccl1HOl1s4JSj0vSRBurocgsBTaUrHKBCC90RBdzDhIgJ6KvKc4duCJxXUZRWBTEh4qM
         KBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698210508; x=1698815308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3n7UlKbKi4rqQul/Gmrnlf7oZJLDEigJSkuhM0lZchQ=;
        b=HhX4ZiONl81yE1157dErIvLdMyEYo+CNw89OdcHt8XJAR9S1KgPSmKrsG9Z/6yxBKM
         +vBVIpedbQ8nNlf/ZnPS8Cbi9dJPDzkVT4pjRpM3qf9wPzTWUAtzoXuJhUpoR43ggsnr
         qPDfV+hL92S3SYM61BtN7lWoYXm53A68FN7W6ry86N/5X4YzJms+4WqzrMIvGIL0uabX
         Fu4i9bXga4K1QQ5yx/ywJzOPNgZ59VxQ39Mh04V+0Mg0Nw1APlTfq8avFWuCsSwum0sv
         5cQQVA4BIBXBwLgLxgZG9ucGccOz1NnRSmRcU06yr4zscO/avS40f5X6RB9tEuvUMRig
         ywUQ==
X-Gm-Message-State: AOJu0YxjgIC5O1A4IE8hi6+Ra5jYpvDcERb7Im+N9T8y8pXFxK/bH9Jm
        poeNDjRAZDmdc8qE86rSgTjFvJoQLgSw1y4A+hocYq4QaZuV1m+rGGo=
X-Google-Smtp-Source: AGHT+IGSXMWElIIUHb2rzlikkkcEFW7AAQ5+9b+PTy5mkQCrEUPf+Zwjg5fdXy8uQciD4z8cyTML5SPKo59za3kiQgo=
X-Received: by 2002:a05:6a20:e123:b0:13d:2f80:cf1c with SMTP id
 kr35-20020a056a20e12300b0013d2f80cf1cmr5286467pzb.17.1698210507639; Tue, 24
 Oct 2023 22:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-8-apatel@ventanamicro.com> <878r7srx04.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <878r7srx04.fsf@all.your.base.are.belong.to.us>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 25 Oct 2023 10:38:16 +0530
Message-ID: <CAK9=C2XpxYztxgD-5HQ+1kThBaRTv3pVk5eah4XHZ_8x62BwqQ@mail.gmail.com>
Subject: Re: [PATCH v11 07/14] irqchip: Add RISC-V incoming MSI controller
 early driver
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 6:35=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Hi Anup!
>
> Wow, I'm really happy to see that you're moving towards the 1-1 model!
>
> Anup Patel <apatel@ventanamicro.com> writes:
>
> > The RISC-V advanced interrupt architecture (AIA) specification
> > defines a new MSI controller called incoming message signalled
> > interrupt controller (IMSIC) which manages MSI on per-HART (or
> > per-CPU) basis. It also supports IPIs as software injected MSIs.
> > (For more details refer https://github.com/riscv/riscv-aia)
> >
> > Let us add an early irqchip driver for RISC-V IMSIC which sets
> > up the IMSIC state and provide IPIs.
>
> It would help (reviewers, and future bugfixers) if you add (here or in
> the cover) what design decisions you've taken instead of just saying
> that you're now supporting IMSIC.

I agree with the suggestion but this kind of information should be
in the source itself rather than commit description.

>
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/irqchip/Kconfig                 |   6 +
> >  drivers/irqchip/Makefile                |   1 +
> >  drivers/irqchip/irq-riscv-imsic-early.c | 235 ++++++
> >  drivers/irqchip/irq-riscv-imsic-state.c | 962 ++++++++++++++++++++++++
> >  drivers/irqchip/irq-riscv-imsic-state.h | 109 +++
> >  include/linux/irqchip/riscv-imsic.h     |  87 +++
> >  6 files changed, 1400 insertions(+)
> >  create mode 100644 drivers/irqchip/irq-riscv-imsic-early.c
> >  create mode 100644 drivers/irqchip/irq-riscv-imsic-state.c
> >  create mode 100644 drivers/irqchip/irq-riscv-imsic-state.h
> >  create mode 100644 include/linux/irqchip/riscv-imsic.h
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index f7149d0f3d45..bdd80716114d 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -546,6 +546,12 @@ config SIFIVE_PLIC
> >       select IRQ_DOMAIN_HIERARCHY
> >       select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
> >
> > +config RISCV_IMSIC
> > +     bool
> > +     depends on RISCV
> > +     select IRQ_DOMAIN_HIERARCHY
> > +     select GENERIC_MSI_IRQ
> > +
> >  config EXYNOS_IRQ_COMBINER
> >       bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
> >       depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index ffd945fe71aa..d714724387ce 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -95,6 +95,7 @@ obj-$(CONFIG_QCOM_MPM)                      +=3D irq-=
qcom-mpm.o
> >  obj-$(CONFIG_CSKY_MPINTC)            +=3D irq-csky-mpintc.o
> >  obj-$(CONFIG_CSKY_APB_INTC)          +=3D irq-csky-apb-intc.o
> >  obj-$(CONFIG_RISCV_INTC)             +=3D irq-riscv-intc.o
> > +obj-$(CONFIG_RISCV_IMSIC)            +=3D irq-riscv-imsic-state.o irq-=
riscv-imsic-early.o
> >  obj-$(CONFIG_SIFIVE_PLIC)            +=3D irq-sifive-plic.o
> >  obj-$(CONFIG_IMX_IRQSTEER)           +=3D irq-imx-irqsteer.o
> >  obj-$(CONFIG_IMX_INTMUX)             +=3D irq-imx-intmux.o
> > diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/=
irq-riscv-imsic-early.c
> > new file mode 100644
> > index 000000000000..23f689ff5807
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-riscv-imsic-early.c
> > @@ -0,0 +1,235 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> > + * Copyright (C) 2022 Ventana Micro Systems Inc.
> > + */
> > +
> > +#define pr_fmt(fmt) "riscv-imsic: " fmt
> > +#include <linux/cpu.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqchip/chained_irq.h>
> > +#include <linux/module.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/smp.h>
> > +
> > +#include "irq-riscv-imsic-state.h"
> > +
> > +static int imsic_parent_irq;
> > +
> > +#ifdef CONFIG_SMP
> > +static irqreturn_t imsic_local_sync_handler(int irq, void *data)
> > +{
> > +     imsic_local_sync();
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static void imsic_ipi_send(unsigned int cpu)
> > +{
> > +     struct imsic_local_config *local =3D
> > +                             per_cpu_ptr(imsic->global.local, cpu);
>
> General nit for the series; There's a lot line breaks in the series. Try
> to use the full 100 chars for a line.

I prefer the 80 lines limit.

>
> > +
> > +     writel(IMSIC_IPI_ID, local->msi_va);
>
> Do you need the barriers here? If so, please document. If not, use the
> _releaxed() version.

We can't assume that _relaxed version of MMIO operations
will work for RISC-V implementation so we conservatively
use regular MMIO operations without _releaxed().

>
> > +}
> > +
> > +static void imsic_ipi_starting_cpu(void)
> > +{
> > +     /* Enable IPIs for current CPU. */
> > +     __imsic_id_set_enable(IMSIC_IPI_ID);
> > +
> > +     /* Enable virtual IPI used for IMSIC ID synchronization */
> > +     enable_percpu_irq(imsic->ipi_virq, 0);
>
> Maybe pass IRQ_TYPE_NONE instead of 0, so it's clearer?

Okay, I will update.

>
> > +}
> > +
> > +static void imsic_ipi_dying_cpu(void)
> > +{
> > +     /*
> > +      * Disable virtual IPI used for IMSIC ID synchronization so
> > +      * that we don't receive ID synchronization requests.
> > +      */
> > +     disable_percpu_irq(imsic->ipi_virq);
> > +}
> > +
> > +static int __init imsic_ipi_domain_init(void)
> > +{
> > +     int virq;
> > +
> > +     /* Create IMSIC IPI multiplexing */
> > +     virq =3D ipi_mux_create(IMSIC_NR_IPI, imsic_ipi_send);
> > +     if (virq <=3D 0)
> > +             return (virq < 0) ? virq : -ENOMEM;
> > +     imsic->ipi_virq =3D virq;
> > +
> > +     /* First vIRQ is used for IMSIC ID synchronization */
> > +     virq =3D request_percpu_irq(imsic->ipi_virq, imsic_local_sync_han=
dler,
> > +                               "riscv-imsic-lsync", imsic->global.loca=
l);
> > +     if (virq)
> > +             return virq;
> > +     irq_set_status_flags(imsic->ipi_virq, IRQ_HIDDEN);
> > +     imsic->ipi_lsync_desc =3D irq_to_desc(imsic->ipi_virq);
> > +
> > +     /* Set vIRQ range */
> > +     riscv_ipi_set_virq_range(imsic->ipi_virq + 1, IMSIC_NR_IPI - 1, t=
rue);
> > +
> > +     /* Announce that IMSIC is providing IPIs */
> > +     pr_info("%pfwP: providing IPIs using interrupt %d\n",
> > +             imsic->fwnode, IMSIC_IPI_ID);
> > +
> > +     return 0;
> > +}
> > +#else
> > +static void imsic_ipi_starting_cpu(void)
> > +{
> > +}
> > +
> > +static void imsic_ipi_dying_cpu(void)
> > +{
> > +}
> > +
> > +static int __init imsic_ipi_domain_init(void)
> > +{
> > +     return 0;
> > +}
> > +#endif
> > +
> > +/*
> > + * To handle an interrupt, we read the TOPEI CSR and write zero in one
> > + * instruction. If TOPEI CSR is non-zero then we translate TOPEI.ID to
> > + * Linux interrupt number and let Linux IRQ subsystem handle it.
> > + */
> > +static void imsic_handle_irq(struct irq_desc *desc)
> > +{
> > +     struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +     int err, cpu =3D smp_processor_id();
> > +     struct imsic_vector *vec;
> > +     unsigned long local_id;
> > +
> > +     chained_irq_enter(chip, desc);
> > +
> > +     while ((local_id =3D csr_swap(CSR_TOPEI, 0))) {
> > +             local_id =3D local_id >> TOPEI_ID_SHIFT;
> > +
> > +             if (local_id =3D=3D IMSIC_IPI_ID) {
> > +#ifdef CONFIG_SMP
> > +                     ipi_mux_process();
> > +#endif
> > +                     continue;
> > +             }
> > +
> > +             if (unlikely(!imsic->base_domain))
> > +                     continue;
> > +
> > +             vec =3D imsic_vector_from_local_id(cpu, local_id);
> > +             if (!vec) {
> > +                     pr_warn_ratelimited(
> > +                             "vector not found for local ID 0x%lx\n",
> > +                             local_id);
> > +                     continue;
> > +             }
> > +
> > +             err =3D generic_handle_domain_irq(imsic->base_domain,
> > +                                             vec->hwirq);
> > +             if (unlikely(err))
> > +                     pr_warn_ratelimited(
> > +                             "hwirq 0x%x mapping not found\n",
> > +                             vec->hwirq);
> > +     }
> > +
> > +     chained_irq_exit(chip, desc);
> > +}
> > +
> > +static int imsic_starting_cpu(unsigned int cpu)
> > +{
> > +     /* Enable per-CPU parent interrupt */
> > +     enable_percpu_irq(imsic_parent_irq,
> > +                       irq_get_trigger_type(imsic_parent_irq));
> > +
> > +     /* Setup IPIs */
> > +     imsic_ipi_starting_cpu();
> > +
> > +     /*
> > +      * Interrupts identities might have been enabled/disabled while
> > +      * this CPU was not running so sync-up local enable/disable state=
.
> > +      */
> > +     imsic_local_sync();
> > +
> > +     /* Enable local interrupt delivery */
> > +     imsic_local_delivery(true);
> > +
> > +     return 0;
> > +}
> > +
> > +static int imsic_dying_cpu(unsigned int cpu)
> > +{
> > +     /* Cleanup IPIs */
> > +     imsic_ipi_dying_cpu();
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init imsic_early_probe(struct fwnode_handle *fwnode)
> > +{
> > +     int rc;
> > +     struct irq_domain *domain;
> > +
> > +     /* Find parent domain and register chained handler */
> > +     domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode(),
> > +                                       DOMAIN_BUS_ANY);
> > +     if (!domain) {
> > +             pr_err("%pfwP: Failed to find INTC domain\n", fwnode);
> > +             return -ENOENT;
> > +     }
> > +     imsic_parent_irq =3D irq_create_mapping(domain, RV_IRQ_EXT);
> > +     if (!imsic_parent_irq) {
> > +             pr_err("%pfwP: Failed to create INTC mapping\n", fwnode);
> > +             return -ENOENT;
> > +     }
> > +     irq_set_chained_handler(imsic_parent_irq, imsic_handle_irq);
> > +
> > +     /* Initialize IPI domain */
> > +     rc =3D imsic_ipi_domain_init();
> > +     if (rc) {
> > +             pr_err("%pfwP: Failed to initialize IPI domain\n", fwnode=
);
> > +             return rc;
> > +     }
> > +
> > +     /*
> > +      * Setup cpuhp state (must be done after setting imsic_parent_irq=
)
> > +      *
> > +      * Don't disable per-CPU IMSIC file when CPU goes offline
> > +      * because this affects IPI and the masking/unmasking of
> > +      * virtual IPIs is done via generic IPI-Mux
> > +      */
> > +     cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> > +                       "irqchip/riscv/imsic:starting",
> > +                       imsic_starting_cpu, imsic_dying_cpu);
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init imsic_early_dt_init(struct device_node *node,
> > +                                   struct device_node *parent)
> > +{
> > +     int rc;
> > +     struct fwnode_handle *fwnode =3D &node->fwnode;
> > +
> > +     /* Setup IMSIC state */
> > +     rc =3D imsic_setup_state(fwnode);
> > +     if (rc) {
> > +             pr_err("%pfwP: failed to setup state (error %d)\n",
> > +                     fwnode, rc);
> > +             return rc;
> > +     }
> > +
> > +     /* Do early setup of IPIs */
> > +     rc =3D imsic_early_probe(fwnode);
> > +     if (rc)
> > +             return rc;
> > +
> > +     /* Ensure that OF platform device gets probed */
> > +     of_node_clear_flag(node, OF_POPULATED);
> > +     return 0;
> > +}
> > +IRQCHIP_DECLARE(riscv_imsic, "riscv,imsics", imsic_early_dt_init);
> > diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/=
irq-riscv-imsic-state.c
> > new file mode 100644
> > index 000000000000..54465e47851c
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-riscv-imsic-state.c
> > @@ -0,0 +1,962 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> > + * Copyright (C) 2022 Ventana Micro Systems Inc.
> > + */
> > +
> > +#define pr_fmt(fmt) "riscv-imsic: " fmt
> > +#include <linux/cpu.h>
> > +#include <linux/bitmap.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/seq_file.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/smp.h>
> > +#include <asm/hwcap.h>
> > +
> > +#include "irq-riscv-imsic-state.h"
> > +
> > +#define IMSIC_DISABLE_EIDELIVERY             0
> > +#define IMSIC_ENABLE_EIDELIVERY                      1
> > +#define IMSIC_DISABLE_EITHRESHOLD            1
> > +#define IMSIC_ENABLE_EITHRESHOLD             0
> > +
> > +#define imsic_csr_write(__c, __v)            \
> > +do {                                         \
> > +     csr_write(CSR_ISELECT, __c);            \
> > +     csr_write(CSR_IREG, __v);               \
> > +} while (0)
> > +
> > +#define imsic_csr_read(__c)                  \
> > +({                                           \
> > +     unsigned long __v;                      \
> > +     csr_write(CSR_ISELECT, __c);            \
> > +     __v =3D csr_read(CSR_IREG);               \
> > +     __v;                                    \
> > +})
> > +
> > +#define imsic_csr_read_clear(__c, __v)               \
> > +({                                           \
> > +     unsigned long __r;                      \
> > +     csr_write(CSR_ISELECT, __c);            \
> > +     __r =3D csr_read_clear(CSR_IREG, __v);    \
> > +     __r;                                    \
> > +})
> > +
> > +#define imsic_csr_set(__c, __v)                      \
> > +do {                                         \
> > +     csr_write(CSR_ISELECT, __c);            \
> > +     csr_set(CSR_IREG, __v);                 \
> > +} while (0)
> > +
> > +#define imsic_csr_clear(__c, __v)            \
> > +do {                                         \
> > +     csr_write(CSR_ISELECT, __c);            \
> > +     csr_clear(CSR_IREG, __v);               \
> > +} while (0)
> > +
> > +struct imsic_priv *imsic;
> > +
> > +const struct imsic_global_config *imsic_get_global_config(void)
> > +{
> > +     return (imsic) ? &imsic->global : NULL;
>
> Nit: No need for the parenthesis.

Okay, I will update.

>
> > +}
> > +EXPORT_SYMBOL_GPL(imsic_get_global_config);
> > +
> > +static bool __imsic_eix_read_clear(unsigned long id, bool pend)
> > +{
> > +     unsigned long isel, imask;
> > +
> > +     isel =3D id / BITS_PER_LONG;
> > +     isel *=3D BITS_PER_LONG / IMSIC_EIPx_BITS;
> > +     isel +=3D (pend) ? IMSIC_EIP0 : IMSIC_EIE0;
> > +     imask =3D BIT(id & (__riscv_xlen - 1));
> > +
> > +     return (imsic_csr_read_clear(isel, imask) & imask) ? true : false=
;
> > +}
> > +
> > +#define __imsic_id_read_clear_enabled(__id)          \
> > +     __imsic_eix_read_clear((__id), false)
> > +#define __imsic_id_read_clear_pending(__id)          \
> > +     __imsic_eix_read_clear((__id), true)
> > +
> > +void __imsic_eix_update(unsigned long base_id,
> > +                     unsigned long num_id, bool pend, bool val)
> > +{
> > +     unsigned long i, isel, ireg;
> > +     unsigned long id =3D base_id, last_id =3D base_id + num_id;
> > +
> > +     while (id < last_id) {
> > +             isel =3D id / BITS_PER_LONG;
> > +             isel *=3D BITS_PER_LONG / IMSIC_EIPx_BITS;
> > +             isel +=3D (pend) ? IMSIC_EIP0 : IMSIC_EIE0;
>
> Parenthesis nit.

Okay, I will update.

>
> > +
> > +             ireg =3D 0;
> > +             for (i =3D id & (__riscv_xlen - 1);
> > +                  (id < last_id) && (i < __riscv_xlen); i++) {
> > +                     ireg |=3D BIT(i);
> > +                     id++;
> > +             }
> > +
> > +             /*
> > +              * The IMSIC EIEx and EIPx registers are indirectly
> > +              * accessed via using ISELECT and IREG CSRs so we
> > +              * need to access these CSRs without getting preempted.
> > +              *
> > +              * All existing users of this function call this
> > +              * function with local IRQs disabled so we don't
> > +              * need to do anything special here.
> > +              */
> > +             if (val)
> > +                     imsic_csr_set(isel, ireg);
> > +             else
> > +                     imsic_csr_clear(isel, ireg);
> > +     }
> > +}
> > +
> > +void imsic_local_sync(void)
> > +{
> > +     struct imsic_local_priv *lpriv =3D this_cpu_ptr(imsic->lpriv);
> > +     struct imsic_local_config *mlocal;
> > +     struct imsic_vector *mvec;
> > +     unsigned long flags;
> > +     int i;
> > +
> > +     raw_spin_lock_irqsave(&lpriv->ids_lock, flags);
> > +     for (i =3D 1; i <=3D imsic->global.nr_ids; i++) {
> > +             if (i =3D=3D IMSIC_IPI_ID)
> > +                     continue;
> > +
> > +             if (test_bit(i, lpriv->ids_enabled_bitmap))
> > +                     __imsic_id_set_enable(i);
> > +             else
> > +                     __imsic_id_clear_enable(i);
> > +
> > +             mvec =3D lpriv->ids_move[i];
> > +             lpriv->ids_move[i] =3D NULL;
> > +             if (mvec) {
> > +                     if (__imsic_id_read_clear_pending(i)) {
> > +                             mlocal =3D per_cpu_ptr(imsic->global.loca=
l,
> > +                                                  mvec->cpu);
> > +                             writel(mvec->local_id, mlocal->msi_va);
>
> Again, do you need all the barriers? If yes, document. No, then relax
> the call.

Same comment as above.

>
> > +                     }
> > +
> > +                     lpriv->vectors[i].hwirq =3D UINT_MAX;
> > +                     lpriv->vectors[i].order =3D UINT_MAX;
> > +                     clear_bit(i, lpriv->ids_used_bitmap);
> > +             }
> > +
> > +     }
> > +     raw_spin_unlock_irqrestore(&lpriv->ids_lock, flags);
> > +}
> > +
> > +void imsic_local_delivery(bool enable)
> > +{
> > +     if (enable) {
> > +             imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_ENABLE_EITHRESHO=
LD);
> > +             imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_ENABLE_EIDELIVERY=
);
> > +     } else {
> > +             imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_DISABLE_EIDELIVER=
Y);
> > +             imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_DISABLE_EITHRESH=
OLD);
> > +     }
>
> My regular "early exit" nit. I guess I really dislike indentation. ;-)

-ENOPARSE

>
> > +}
> > +
> > +#ifdef CONFIG_SMP
> > +static void imsic_remote_sync(unsigned int cpu)
> > +{
> > +     /*
> > +      * We simply inject ID synchronization IPI to a target CPU
> > +      * if it is not same as the current CPU. The ipi_send_mask()
> > +      * implementation of IPI mux will inject ID synchronization
> > +      * IPI only for CPUs that have enabled it so offline CPUs
> > +      * won't receive IPI. An offline CPU will unconditionally
> > +      * synchronize IDs through imsic_starting_cpu() when the
> > +      * CPU is brought up.
> > +      */
> > +     if (cpu_online(cpu)) {
> > +             if (cpu !=3D smp_processor_id())
> > +                     __ipi_send_mask(imsic->ipi_lsync_desc, cpumask_of=
(cpu));
> > +             else
> > +                     imsic_local_sync();
> > +     }
> > +}
> > +#else
> > +static inline void imsic_remote_sync(unsigned int cpu)
>
> Remove inline.

Okay, I will update.

>
> > +{
> > +     imsic_local_sync();
> > +}
> > +#endif
> > +
> > +void imsic_vector_mask(struct imsic_vector *vec)
> > +{
> > +     struct imsic_local_priv *lpriv;
> > +     unsigned long flags;
> > +
> > +     lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
> > +     if (WARN_ON(&lpriv->vectors[vec->local_id] !=3D vec))
> > +             return;
> > +
> > +     raw_spin_lock_irqsave(&lpriv->ids_lock, flags);
> > +     bitmap_clear(lpriv->ids_enabled_bitmap, vec->local_id, 1);
> > +     raw_spin_unlock_irqrestore(&lpriv->ids_lock, flags);
> > +
> > +     imsic_remote_sync(vec->cpu);
>
> x86 seems to set a timer instead, for the remote cpu cleanup, which can
> be much cheaper, and less in instrusive. Is that applicable here?

The issue with that approach is deciding the right duration
of timer interrupt. There might be platforms who need
immediate mask/unmask response. We can certainely
keep improving/tuning this over-time.

>
> > +}
> > +
> > +void imsic_vector_unmask(struct imsic_vector *vec)
> > +{
> > +     struct imsic_local_priv *lpriv;
> > +     unsigned long flags;
> > +
> > +     lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
> > +     if (WARN_ON(&lpriv->vectors[vec->local_id] !=3D vec))
> > +             return;
> > +
> > +     raw_spin_lock_irqsave(&lpriv->ids_lock, flags);
> > +     bitmap_set(lpriv->ids_enabled_bitmap, vec->local_id, 1);
> > +     raw_spin_unlock_irqrestore(&lpriv->ids_lock, flags);
> > +
> > +     imsic_remote_sync(vec->cpu);
> > +}
> > +
> > +void imsic_vector_move(struct imsic_vector *old_vec,
> > +                     struct imsic_vector *new_vec)
> > +{
> > +     struct imsic_local_priv *old_lpriv, *new_lpriv;
> > +     struct imsic_vector *ovec, *nvec;
> > +     unsigned long flags, flags1;
> > +     unsigned int i;
> > +
> > +     if (WARN_ON(old_vec->cpu =3D=3D new_vec->cpu ||
> > +                 old_vec->order !=3D new_vec->order ||
> > +                 (old_vec->local_id & IMSIC_VECTOR_MASK(old_vec)) ||
> > +                 (new_vec->local_id & IMSIC_VECTOR_MASK(new_vec))))
> > +             return;
> > +
> > +     old_lpriv =3D per_cpu_ptr(imsic->lpriv, old_vec->cpu);
> > +     if (WARN_ON(&old_lpriv->vectors[old_vec->local_id] !=3D old_vec))
> > +             return;
> > +
> > +     new_lpriv =3D per_cpu_ptr(imsic->lpriv, new_vec->cpu);
> > +     if (WARN_ON(&new_lpriv->vectors[new_vec->local_id] !=3D new_vec))
> > +             return;
> > +
> > +     raw_spin_lock_irqsave(&old_lpriv->ids_lock, flags);
> > +     raw_spin_lock_irqsave(&new_lpriv->ids_lock, flags1);
> > +
> > +     /* Move the state of each vector entry */
> > +     for (i =3D 0; i < BIT(old_vec->order); i++) {
> > +             ovec =3D old_vec + i;
> > +             nvec =3D new_vec + i;
> > +
> > +             /* Unmask the new vector entry */
> > +             if (test_bit(ovec->local_id, old_lpriv->ids_enabled_bitma=
p))
> > +                     bitmap_set(new_lpriv->ids_enabled_bitmap,
> > +                                nvec->local_id, 1);
> > +
> > +             /* Mask the old vector entry */
> > +             bitmap_clear(old_lpriv->ids_enabled_bitmap, ovec->local_i=
d, 1);
> > +
> > +             /*
> > +              * Move and re-trigger the new vector entry based on the
> > +              * pending state of the old vector entry because we might
> > +              * get a device interrupt on the old vector entry while
> > +              * device was being moved to the new vector entry.
> > +              */
> > +             old_lpriv->ids_move[ovec->local_id] =3D nvec;
> > +     }
>
> Hmm, nested spinlocks, and reimplementing what the irq matrix allocator
> does.
>
> Convince me why irq matrix is not a good fit to track the interrupts IDs
> *and* get handling/tracking for managed/unmanaged interrupts. You said
> that it was the power-of-two blocks for MSI, but can't that be enfored
> on matrix alloc? Where are you doing the special handling of MSI?
>
> The reason I'm asking is because I'm pretty certain that x86 has proper
> MSI support (Thomas Gleixner can answer for sure! ;-))
>
> IMSIC smells a lot like the the LAPIC. The implementation could probably
> be *very* close to what arch/x86/kernel/apic/vector.c does.
>
> Am I completly off here?
>

The x86 APIC driver only supports MSI-X due to which the IRQ matrix
allocator only supports ID/Vector allocation suitable for MSI-X whereas
the ARM GICv3 driver supports both legacy MSI and MSI-X. In absence
of legacy MSI support, Linux x86 will fallback to INTx for PCI devices
with legacy MSI support but for RISC-V platforms we can't assume that
INTx is available because we might be dealing with an IMSIC-only
platform.

Refer, x86_vector_msi_parent_ops in arch/x86/kernel/apic/msi.c and
X86_VECTOR_MSI_FLAGS_SUPPORTED in arch/x86/include/asm/msi.h

Refer, its_pci_msi_domain_info in drivers/irqchip/irq-gic-v3-its-pci-msi.c

The changes which I think are need in the IRQ matrix allocator before
integrating it in the IMSIC driver are the following:
1) IRQ matrix allocator assumed NR_VECTORS to be a fixed define
    which the arch code provides but in RISC-V world the number of
    IDs are discovered from DT or ACPI.
2) IRQ matrix allocator needs to be support allocator multiple vectors
    in power-of-2 which will allow IMSIC driver to support both legacy
    MSI and MSI-X. This will involve changing the way best CPU is
    found, the way bitmap APIs are used and adding some new APIs
    for allocate vectors in power-of-2

Based on above, I suggest we keep the integration of IRQ matrix
allocator in the IMSIC driver as a separate series which will allow
us to unblock other series (such as AIA ACPI support, power
managment related changes in AIA drivers, etc).

Regards,
Anup
