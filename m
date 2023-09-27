Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177D47B0239
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjI0Kxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI0Kxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:53:45 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C593F3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 03:53:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27740ce6c76so4657074a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 03:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695812021; x=1696416821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLkBGadiwzP1BRGsQ0XQUhq/xZmI0oQcoq1vkbGpn4s=;
        b=cpFjBN5t431fbDU7gwMGHav05+anAKbwSf61X0Xu87VnTNS0BzvGsXpZPs8Vmrifo0
         DaYzVjPV2q16O2sriF0LUd5pzheTLAYqptlyhjjnV6Q5zY8nJehfGPAA6x7DLiV/JFHT
         zgEdRTu46rw6USwTE49GQL2aYfEseKzQZQGfdTMWdzxD30of4mUAS9m+/ac+am5Fc5LV
         xg6IUbmMLFv8+v5W3t/WQyf2RTa4+UhKAs2BRN20E1ft8+HQiKbJrkkKWYGK8C1z0mFJ
         Rkj47oLcUS9UKH00tMe+ZDgwb5sV3h8QtsbPRf2QoPFJMo+QaDjAc9WZdV7uYKNMM0wc
         zQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695812021; x=1696416821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLkBGadiwzP1BRGsQ0XQUhq/xZmI0oQcoq1vkbGpn4s=;
        b=qTH7H09gbWkqfHFhpdZoUa35l9XKsnfszumzGXbS1DNHBHAiEPGDCThZG7zfZV5BMX
         GyWeaJp588AHTjgvbAwHyQhRb7r9nfFAAAadKp6y7xlg0LLB+1II7YTGxn4OJO7KugBG
         8fHrYvWLyqSwXwN2zbS62edA7mhuk1EIR9S4lL8mHre23l3QcCTjEStIaRpiZLL4n4e4
         BBqCNX0PASN+nSaJo2yJ9PlE8KGFj4XpTG2mNU59ZXNhTto1R2TO2KZ1rfl6npeuz1iv
         BMFposRm5Psn+4vQQ6MLpVyZ6CGrCaMTTAIrvqWDbi6lDQ6CT31bVDvExFy5TyHjtKe9
         DTwQ==
X-Gm-Message-State: AOJu0YxMwZtHLblSY6bHjatNCIQIk4vZw34XF5iYUUrzwrD/FEp4XSwM
        j2+OSKMMWv8WRlj7Mn24LcCqVljhMMnjLVISmWThsQ==
X-Google-Smtp-Source: AGHT+IEpe+4wSCzA+/uPhQyzY/1G0UsnYwcnwuAbCQ8SzjeJexUtdaJb4GIcKwGB7aUxMDunOaprf7sRKdoPGVgL4Nw=
X-Received: by 2002:a17:90b:1205:b0:269:3771:7342 with SMTP id
 gl5-20020a17090b120500b0026937717342mr1185218pjb.18.1695812021193; Wed, 27
 Sep 2023 03:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230912174928.528414-1-apatel@ventanamicro.com>
 <20230912174928.528414-10-apatel@ventanamicro.com> <ZRE7kw4EkWUG4mSq@sunil-laptop>
In-Reply-To: <ZRE7kw4EkWUG4mSq@sunil-laptop>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 27 Sep 2023 16:23:29 +0530
Message-ID: <CAK9=C2W+BLYaoRDA8+VkhfU8RNh16bdWAHEMPu_=PBbqxgaDLQ@mail.gmail.com>
Subject: Re: [PATCH v8 09/16] irqchip: Add RISC-V incoming MSI controller
 early driver
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 1:19=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> Hi Anup,
>
> On Tue, Sep 12, 2023 at 11:19:21PM +0530, Anup Patel wrote:
> > The RISC-V advanced interrupt architecture (AIA) specification
> > defines a new MSI controller called incoming message signalled
> > interrupt controller (IMSIC) which manages MSI on per-HART (or
> > per-CPU) basis. It also supports IPIs as software injected MSIs.
> > (For more details refer https://github.com/riscv/riscv-aia)
> >
> > Let us add an early irqchip driver for RISC-V IMSIC which sets
> > up the IMSIC state and provide IPIs.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/irqchip/Kconfig                 |   7 +-
> >  drivers/irqchip/Makefile                |   1 +
> >  drivers/irqchip/irq-riscv-imsic-early.c | 258 ++++++++++++
> >  drivers/irqchip/irq-riscv-imsic-state.c | 523 ++++++++++++++++++++++++
> >  drivers/irqchip/irq-riscv-imsic-state.h |  66 +++
> >  include/linux/irqchip/riscv-imsic.h     |  86 ++++
> >  6 files changed, 940 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/irqchip/irq-riscv-imsic-early.c
> >  create mode 100644 drivers/irqchip/irq-riscv-imsic-state.c
> >  create mode 100644 drivers/irqchip/irq-riscv-imsic-state.h
> >  create mode 100644 include/linux/irqchip/riscv-imsic.h
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index f7149d0f3d45..ee99aacbefcc 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -30,7 +30,6 @@ config ARM_GIC_V2M
> >
> >  config GIC_NON_BANKED
> >       bool
> > -
> >  config ARM_GIC_V3
> >       bool
> >       select IRQ_DOMAIN_HIERARCHY
> > @@ -546,6 +545,12 @@ config SIFIVE_PLIC
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
> > index 000000000000..1de89ce1ec2f
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-riscv-imsic-early.c
> > @@ -0,0 +1,258 @@
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
> > +/*
> > + * The IMSIC driver uses 1 IPI for ID synchronization and
> > + * arch/riscv/kernel/smp.c require 6 IPIs so we fix the
> > + * total number of IPIs to 8.
> > + */
> > +#define IMSIC_NR_IPI                         8
> > +
> > +static int imsic_parent_irq;
> > +
> > +#ifdef CONFIG_SMP
> > +static irqreturn_t imsic_ids_sync_handler(int irq, void *data)
> > +{
> > +     imsic_ids_local_sync();
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +void imsic_ids_remote_sync(void)
> > +{
> > +     struct cpumask amask;
> > +
> > +     /*
> > +      * We simply inject ID synchronization IPI to all target CPUs
> > +      * except current CPU. The ipi_send_mask() implementation of
> > +      * IPI mux will inject ID synchronization IPI only for CPUs
> > +      * that have enabled it so offline CPUs won't receive IPI.
> > +      * An offline CPU will unconditionally synchronize IDs through
> > +      * imsic_starting_cpu() when the CPU is brought up.
> > +      */
> > +     cpumask_andnot(&amask, cpu_online_mask, cpumask_of(smp_processor_=
id()));
> > +     __ipi_send_mask(imsic->ipi_lsync_desc, &amask);
> > +}
> > +
> > +static void imsic_ipi_send(unsigned int cpu)
> > +{
> > +     struct imsic_local_config *local =3D
> > +                             per_cpu_ptr(imsic->global.local, cpu);
> > +
> > +     writel(imsic->ipi_id, local->msi_va);
> > +}
> > +
> > +static void imsic_ipi_starting_cpu(void)
> > +{
> > +     /* Enable IPIs for current CPU. */
> > +     __imsic_id_enable(imsic->ipi_id);
> > +
> > +     /* Enable virtual IPI used for IMSIC ID synchronization */
> > +     enable_percpu_irq(imsic->ipi_virq, 0);
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
> > +     /* Allocate interrupt identity for IPIs */
> > +     virq =3D imsic_ids_alloc(get_count_order(1));
> > +     if (virq < 0)
> > +             return virq;
> > +     imsic->ipi_id =3D virq;
> > +
> > +     /* Create IMSIC IPI multiplexing */
> > +     virq =3D ipi_mux_create(IMSIC_NR_IPI, imsic_ipi_send);
> > +     if (virq <=3D 0) {
> > +             imsic_ids_free(imsic->ipi_id, get_count_order(1));
> > +             return (virq < 0) ? virq : -ENOMEM;
> > +     }
> > +     imsic->ipi_virq =3D virq;
> > +
> > +     /* First vIRQ is used for IMSIC ID synchronization */
> > +     virq =3D request_percpu_irq(imsic->ipi_virq, imsic_ids_sync_handl=
er,
> > +                               "riscv-imsic-lsync", imsic->global.loca=
l);
> > +     if (virq) {
> > +             imsic_ids_free(imsic->ipi_id, get_count_order(1));
> > +             return virq;
> > +     }
> > +     irq_set_status_flags(imsic->ipi_virq, IRQ_HIDDEN);
> > +     imsic->ipi_lsync_desc =3D irq_to_desc(imsic->ipi_virq);
> > +
> > +     /* Set vIRQ range */
> > +     riscv_ipi_set_virq_range(imsic->ipi_virq + 1, IMSIC_NR_IPI - 1, t=
rue);
> > +
> > +     /* Announce that IMSIC is providing IPIs */
> > +     pr_info("%pfwP: providing IPIs using interrupt %d\n",
> > +             imsic->fwnode, imsic->ipi_id);
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
> > +     /* Clear the IPI id because we are not using IPIs */
> > +     imsic->ipi_id =3D 0;
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
> > +     irq_hw_number_t hwirq;
> > +     int err;
> > +
> > +     chained_irq_enter(chip, desc);
> > +
> > +     while ((hwirq =3D csr_swap(CSR_TOPEI, 0))) {
> > +             hwirq =3D hwirq >> TOPEI_ID_SHIFT;
> > +
> > +             if (hwirq =3D=3D imsic->ipi_id) {
> > +#ifdef CONFIG_SMP
> > +                     ipi_mux_process();
> > +#endif
> > +                     continue;
> > +             }
> > +
> > +             if (unlikely(!imsic->base_domain))
> > +                     continue;
> > +
> > +             err =3D generic_handle_domain_irq(imsic->base_domain, hwi=
rq);
> > +             if (unlikely(err))
> > +                     pr_warn_ratelimited(
> > +                             "hwirq %lu mapping not found\n", hwirq);
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
> > +     imsic_ids_local_sync();
> > +
> > +     /* Enable local interrupt delivery */
> > +     imsic_ids_local_delivery(true);
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
>
> Can this imsic_early_probe() take an additional pointer as parameter?
> This parameter can be NULL for DT and we can use to pass the MADT
> structure in case of ACPI since fwnode in ACPI will not have any
> properties. The parameter needs to be passed to imsic_setup_state()
> also.

Instead, I am thinking of moving the imsic_setup_state() call to
imsic_early_dt_init() so that we can directly pass extra parameters
from imsic_early_dt_init().

>
> > +{
> > +     int rc;
> > +     struct irq_domain *domain;
> > +
> > +     /* Setup IMSIC state */
> > +     rc =3D imsic_setup_state(fwnode);
> > +     if (rc) {
> > +             pr_err("%pfwP: failed to setup state (error %d)\n",
> > +                     fwnode, rc);
> > +             return rc;
> > +     }
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
> > +
> > +     /* Do early setup of IMSIC state and IPIs */
> > +     rc =3D imsic_early_probe(&node->fwnode);
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
> > index 000000000000..412b5b919dcc
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-riscv-imsic-state.c
> > @@ -0,0 +1,523 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> > + * Copyright (C) 2022 Ventana Micro Systems Inc.
> > + */
> > +
> > +#define pr_fmt(fmt) "riscv-imsic: " fmt
> > +#include <linux/bitmap.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
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
> > +}
> > +EXPORT_SYMBOL_GPL(imsic_get_global_config);
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
> > +void imsic_id_set_target(unsigned int id, unsigned int target_cpu)
> > +{
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&imsic->ids_lock, flags);
> > +     imsic->ids_target_cpu[id] =3D target_cpu;
> > +     raw_spin_unlock_irqrestore(&imsic->ids_lock, flags);
> > +}
> > +
> > +unsigned int imsic_id_get_target(unsigned int id)
> > +{
> > +     unsigned int ret;
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&imsic->ids_lock, flags);
> > +     ret =3D imsic->ids_target_cpu[id];
> > +     raw_spin_unlock_irqrestore(&imsic->ids_lock, flags);
> > +
> > +     return ret;
> > +}
> > +
> > +void imsic_ids_local_sync(void)
> > +{
> > +     int i;
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&imsic->ids_lock, flags);
> > +     for (i =3D 1; i <=3D imsic->global.nr_ids; i++) {
> > +             if (imsic->ipi_id =3D=3D i)
> > +                     continue;
> > +
> > +             if (test_bit(i, imsic->ids_enabled_bimap))
> > +                     __imsic_id_enable(i);
> > +             else
> > +                     __imsic_id_disable(i);
> > +     }
> > +     raw_spin_unlock_irqrestore(&imsic->ids_lock, flags);
> > +}
> > +
> > +void imsic_ids_local_delivery(bool enable)
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
> > +}
> > +
> > +int imsic_ids_alloc(unsigned int order)
> > +{
> > +     int ret;
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&imsic->ids_lock, flags);
> > +     ret =3D bitmap_find_free_region(imsic->ids_used_bimap,
> > +                                   imsic->global.nr_ids + 1, order);
> > +     raw_spin_unlock_irqrestore(&imsic->ids_lock, flags);
> > +
> > +     return ret;
> > +}
> > +
> > +void imsic_ids_free(unsigned int base_id, unsigned int order)
> > +{
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&imsic->ids_lock, flags);
> > +     bitmap_release_region(imsic->ids_used_bimap, base_id, order);
> > +     raw_spin_unlock_irqrestore(&imsic->ids_lock, flags);
> > +}
> > +
> > +static int __init imsic_ids_init(void)
> > +{
> > +     int i;
> > +     struct imsic_global_config *global =3D &imsic->global;
> > +
> > +     raw_spin_lock_init(&imsic->ids_lock);
> > +
> > +     /* Allocate used bitmap */
> > +     imsic->ids_used_bimap =3D bitmap_zalloc(global->nr_ids + 1, GFP_K=
ERNEL);
> > +     if (!imsic->ids_used_bimap)
> > +             return -ENOMEM;
> > +
> > +     /* Allocate enabled bitmap */
> > +     imsic->ids_enabled_bimap =3D bitmap_zalloc(global->nr_ids + 1,
> > +                                             GFP_KERNEL);
> > +     if (!imsic->ids_enabled_bimap) {
> > +             kfree(imsic->ids_used_bimap);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     /* Allocate target CPU array */
> > +     imsic->ids_target_cpu =3D kcalloc(global->nr_ids + 1,
> > +                                    sizeof(unsigned int), GFP_KERNEL);
> > +     if (!imsic->ids_target_cpu) {
> > +             bitmap_free(imsic->ids_enabled_bimap);
> > +             bitmap_free(imsic->ids_used_bimap);
> > +             return -ENOMEM;
> > +     }
> > +     for (i =3D 0; i <=3D global->nr_ids; i++)
> > +             imsic->ids_target_cpu[i] =3D UINT_MAX;
> > +
> > +     /* Reserve ID#0 because it is special and never implemented */
> > +     bitmap_set(imsic->ids_used_bimap, 0, 1);
> > +
> > +     return 0;
> > +}
> > +
> > +static void __init imsic_ids_cleanup(void)
> > +{
> > +     kfree(imsic->ids_target_cpu);
> > +     bitmap_free(imsic->ids_enabled_bimap);
> > +     bitmap_free(imsic->ids_used_bimap);
> > +}
> > +
> > +static int __init imsic_get_parent_hartid(struct fwnode_handle *fwnode=
,
> > +                                       u32 index, unsigned long *harti=
d)
> > +{
> > +     int rc;
> > +     struct fwnode_reference_args parent;
> > +
> > +     rc =3D fwnode_property_get_reference_args(fwnode,
> > +                     "interrupts-extended", "#interrupt-cells",
> > +                     0, index, &parent);
> > +     if (rc)
> > +             return rc;
> > +
> > +     /*
> > +      * Skip interrupts other than external interrupts for
> > +      * current privilege level.
> > +      */
> > +     if (parent.args[0] !=3D RV_IRQ_EXT)
> > +             return -EINVAL;
> > +
> > +     return riscv_get_intc_hartid(parent.fwnode, hartid);
> > +}
> > +
> > +static int __init imsic_get_mmio_resource(struct fwnode_handle *fwnode=
,
> > +                                       u32 index, struct resource *res=
)
> > +{
> > +     /*
> > +      * Currently, only OF fwnode is support so extend this function
> > +      * for other types of fwnode for ACPI support.
> > +      */
> > +     if (!is_of_node(fwnode))
> > +             return -EINVAL;
> > +     return of_address_to_resource(to_of_node(fwnode), index, res);
> > +}
> > +
> > +int __init imsic_setup_state(struct fwnode_handle *fwnode)
> > +{
> > +     int rc, cpu;
> > +     phys_addr_t base_addr;
> > +     void __iomem **mmios_va =3D NULL;
> > +     struct resource res, *mmios =3D NULL;
> > +     struct imsic_local_config *local;
> > +     struct imsic_global_config *global;
> > +     unsigned long reloff, hartid;
> > +     u32 i, j, index, nr_parent_irqs, nr_handlers =3D 0, num_mmios =3D=
 0;
> > +
> > +     /*
> > +      * Only one IMSIC instance allowed in a platform for clean
> > +      * implementation of SMP IRQ affinity and per-CPU IPIs.
> > +      *
> > +      * This means on a multi-socket (or multi-die) platform we
> > +      * will have multiple MMIO regions for one IMSIC instance.
> > +      */
> > +     if (imsic) {
> > +             pr_err("%pfwP: already initialized hence ignoring\n",
> > +                     fwnode);
> > +             return -EALREADY;
> > +     }
> > +
> > +     if (!riscv_isa_extension_available(NULL, SxAIA)) {
> > +             pr_err("%pfwP: AIA support not available\n", fwnode);
> > +             return -ENODEV;
> > +     }
> > +
> > +     imsic =3D kzalloc(sizeof(*imsic), GFP_KERNEL);
> > +     if (!imsic)
> > +             return -ENOMEM;
> > +     imsic->fwnode =3D fwnode;
> > +     global =3D &imsic->global;
> > +
> > +     global->local =3D alloc_percpu(typeof(*(global->local)));
> > +     if (!global->local) {
> > +             rc =3D -ENOMEM;
> > +             goto out_free_priv;
> > +     }
> > +
> > +     /* Find number of parent interrupts */
> > +     nr_parent_irqs =3D 0;
> > +     while (!imsic_get_parent_hartid(fwnode, nr_parent_irqs, &hartid))
> > +             nr_parent_irqs++;
> > +     if (!nr_parent_irqs) {
> > +             pr_err("%pfwP: no parent irqs available\n", fwnode);
> > +             rc =3D -EINVAL;
> > +             goto out_free_local;
> > +     }
> > +
> > +     /* Find number of guest index bits in MSI address */
> > +     rc =3D fwnode_property_read_u32_array(fwnode, "riscv,guest-index-=
bits",
> > +                                         &global->guest_index_bits, 1)=
;
> > +     if (rc)
> > +             global->guest_index_bits =3D 0;
> > +     i =3D BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT;
> > +     if (i < global->guest_index_bits) {
> > +             pr_err("%pfwP: guest index bits too big\n", fwnode);
> > +             rc =3D -EINVAL;
> > +             goto out_free_local;
> > +     }
> > +
> > +     /* Find number of HART index bits */
> > +     rc =3D fwnode_property_read_u32_array(fwnode, "riscv,hart-index-b=
its",
> > +                                         &global->hart_index_bits, 1);
> > +     if (rc) {
> > +             /* Assume default value */
> > +             global->hart_index_bits =3D __fls(nr_parent_irqs);
> > +             if (BIT(global->hart_index_bits) < nr_parent_irqs)
> > +                     global->hart_index_bits++;
> > +     }
> > +     i =3D BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT - global->guest_index=
_bits;
> > +     if (i < global->hart_index_bits) {
> > +             pr_err("%pfwP: HART index bits too big\n", fwnode);
> > +             rc =3D -EINVAL;
> > +             goto out_free_local;
> > +     }
> > +
> > +     /* Find number of group index bits */
> > +     rc =3D fwnode_property_read_u32_array(fwnode, "riscv,group-index-=
bits",
> > +                                         &global->group_index_bits, 1)=
;
> > +     if (rc)
> > +             global->group_index_bits =3D 0;
> > +     i =3D BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT -
> > +         global->guest_index_bits - global->hart_index_bits;
> > +     if (i < global->group_index_bits) {
> > +             pr_err("%pfwP: group index bits too big\n", fwnode);
> > +             rc =3D -EINVAL;
> > +             goto out_free_local;
> > +     }
> > +
> > +     /*
> > +      * Find first bit position of group index.
> > +      * If not specified assumed the default APLIC-IMSIC configuration=
.
> > +      */
> > +     rc =3D fwnode_property_read_u32_array(fwnode, "riscv,group-index-=
shift",
> > +                                         &global->group_index_shift, 1=
);
> > +     if (rc)
> > +             global->group_index_shift =3D IMSIC_MMIO_PAGE_SHIFT * 2;
> > +     i =3D global->group_index_bits + global->group_index_shift - 1;
> > +     if (i >=3D BITS_PER_LONG) {
> > +             pr_err("%pfwP: group index shift too big\n", fwnode);
> > +             rc =3D -EINVAL;
> > +             goto out_free_local;
> > +     }
> > +
> > +     /* Find number of interrupt identities */
> > +     rc =3D fwnode_property_read_u32_array(fwnode, "riscv,num-ids",
> > +                                         &global->nr_ids, 1);
> > +     if (rc) {
> > +             pr_err("%pfwP: number of interrupt identities not found\n=
",
> > +                     fwnode);
> > +             goto out_free_local;
> > +     }
> > +     if ((global->nr_ids < IMSIC_MIN_ID) ||
> > +         (global->nr_ids >=3D IMSIC_MAX_ID) ||
> > +         ((global->nr_ids & IMSIC_MIN_ID) !=3D IMSIC_MIN_ID)) {
> > +             pr_err("%pfwP: invalid number of interrupt identities\n",
> > +                     fwnode);
> > +             rc =3D -EINVAL;
> > +             goto out_free_local;
> > +     }
> > +
> > +     /* Find number of guest interrupt identities */
> > +     if (fwnode_property_read_u32_array(fwnode, "riscv,num-guest-ids",
> > +                                        &global->nr_guest_ids, 1))
> > +             global->nr_guest_ids =3D global->nr_ids;
> > +     if ((global->nr_guest_ids < IMSIC_MIN_ID) ||
> > +         (global->nr_guest_ids >=3D IMSIC_MAX_ID) ||
> > +         ((global->nr_guest_ids & IMSIC_MIN_ID) !=3D IMSIC_MIN_ID)) {
> > +             pr_err("%pfwP: invalid number of guest interrupt identiti=
es\n",
> > +                     fwnode);
> > +             rc =3D -EINVAL;
> > +             goto out_free_local;
> > +     }
> > +
>
> Could you create a separate function for DT to fill up this
> imsic_global structure? In case of ACPI, we can not get this data from
> the fwnode and hence need to have separate function to fill up this
> structure.

Okay, I will update.

Regards,
Anup

>
> Thanks!
> Sunil
> > +     /* Compute base address */
> > +     rc =3D imsic_get_mmio_resource(fwnode, 0, &res);
> > +     if (rc) {
> > +             pr_err("%pfwP: first MMIO resource not found\n", fwnode);
> > +             rc =3D -EINVAL;
> > +             goto out_free_local;
> > +     }
> > +     global->base_addr =3D res.start;
> > +     global->base_addr &=3D ~(BIT(global->guest_index_bits +
> > +                                global->hart_index_bits +
> > +                                IMSIC_MMIO_PAGE_SHIFT) - 1);
> > +     global->base_addr &=3D ~((BIT(global->group_index_bits) - 1) <<
> > +                            global->group_index_shift);
> > +
> > +     /* Find number of MMIO register sets */
> > +     while (!imsic_get_mmio_resource(fwnode, num_mmios, &res))
> > +             num_mmios++;
> > +
> > +     /* Allocate MMIO resource array */
> > +     mmios =3D kcalloc(num_mmios, sizeof(*mmios), GFP_KERNEL);
> > +     if (!mmios) {
> > +             rc =3D -ENOMEM;
> > +             goto out_free_local;
> > +     }
> > +
> > +     /* Allocate MMIO virtual address array */
> > +     mmios_va =3D kcalloc(num_mmios, sizeof(*mmios_va), GFP_KERNEL);
> > +     if (!mmios_va) {
> > +             rc =3D -ENOMEM;
> > +             goto out_iounmap;
> > +     }
> > +
> > +     /* Parse and map MMIO register sets */
> > +     for (i =3D 0; i < num_mmios; i++) {
> > +             rc =3D imsic_get_mmio_resource(fwnode, i, &mmios[i]);
> > +             if (rc) {
> > +                     pr_err("%pfwP: unable to parse MMIO regset %d\n",
> > +                             fwnode, i);
> > +                     goto out_iounmap;
> > +             }
> > +
> > +             base_addr =3D mmios[i].start;
> > +             base_addr &=3D ~(BIT(global->guest_index_bits +
> > +                                global->hart_index_bits +
> > +                                IMSIC_MMIO_PAGE_SHIFT) - 1);
> > +             base_addr &=3D ~((BIT(global->group_index_bits) - 1) <<
> > +                            global->group_index_shift);
> > +             if (base_addr !=3D global->base_addr) {
> > +                     rc =3D -EINVAL;
> > +                     pr_err("%pfwP: address mismatch for regset %d\n",
> > +                             fwnode, i);
> > +                     goto out_iounmap;
> > +             }
> > +
> > +             mmios_va[i] =3D ioremap(mmios[i].start, resource_size(&mm=
ios[i]));
> > +             if (!mmios_va[i]) {
> > +                     rc =3D -EIO;
> > +                     pr_err("%pfwP: unable to map MMIO regset %d\n",
> > +                             fwnode, i);
> > +                     goto out_iounmap;
> > +             }
> > +     }
> > +
> > +     /* Initialize interrupt identity management */
> > +     rc =3D imsic_ids_init();
> > +     if (rc) {
> > +             pr_err("%pfwP: failed to initialize interrupt management\=
n",
> > +                    fwnode);
> > +             goto out_iounmap;
> > +     }
> > +
> > +     /* Configure handlers for target CPUs */
> > +     for (i =3D 0; i < nr_parent_irqs; i++) {
> > +             rc =3D imsic_get_parent_hartid(fwnode, i, &hartid);
> > +             if (rc) {
> > +                     pr_warn("%pfwP: hart ID for parent irq%d not foun=
d\n",
> > +                             fwnode, i);
> > +                     continue;
> > +             }
> > +
> > +             cpu =3D riscv_hartid_to_cpuid(hartid);
> > +             if (cpu < 0) {
> > +                     pr_warn("%pfwP: invalid cpuid for parent irq%d\n"=
,
> > +                             fwnode, i);
> > +                     continue;
> > +             }
> > +
> > +             /* Find MMIO location of MSI page */
> > +             index =3D num_mmios;
> > +             reloff =3D i * BIT(global->guest_index_bits) *
> > +                      IMSIC_MMIO_PAGE_SZ;
> > +             for (j =3D 0; num_mmios; j++) {
> > +                     if (reloff < resource_size(&mmios[j])) {
> > +                             index =3D j;
> > +                             break;
> > +                     }
> > +
> > +                     /*
> > +                      * MMIO region size may not be aligned to
> > +                      * BIT(global->guest_index_bits) * IMSIC_MMIO_PAG=
E_SZ
> > +                      * if holes are present.
> > +                      */
> > +                     reloff -=3D ALIGN(resource_size(&mmios[j]),
> > +                     BIT(global->guest_index_bits) * IMSIC_MMIO_PAGE_S=
Z);
> > +             }
> > +             if (index >=3D num_mmios) {
> > +                     pr_warn("%pfwP: MMIO not found for parent irq%d\n=
",
> > +                             fwnode, i);
> > +                     continue;
> > +             }
> > +
> > +             local =3D per_cpu_ptr(global->local, cpu);
> > +             local->msi_pa =3D mmios[index].start + reloff;
> > +             local->msi_va =3D mmios_va[index] + reloff;
> > +
> > +             nr_handlers++;
> > +     }
> > +
> > +     /* If no CPU handlers found then can't take interrupts */
> > +     if (!nr_handlers) {
> > +             pr_err("%pfwP: No CPU handlers found\n", fwnode);
> > +             rc =3D -ENODEV;
> > +             goto out_ids_cleanup;
> > +     }
> > +
> > +     /* We don't need MMIO arrays anymore so let's free-up */
> > +     kfree(mmios_va);
> > +     kfree(mmios);
> > +
> > +     return 0;
> > +
> > +out_ids_cleanup:
> > +     imsic_ids_cleanup();
> > +out_iounmap:
> > +     for (i =3D 0; i < num_mmios; i++) {
> > +             if (mmios_va[i])
> > +                     iounmap(mmios_va[i]);
> > +     }
> > +     kfree(mmios_va);
> > +     kfree(mmios);
> > +out_free_local:
> > +     free_percpu(imsic->global.local);
> > +out_free_priv:
> > +     kfree(imsic);
> > +     imsic =3D NULL;
> > +     return rc;
> > +}
> > diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/=
irq-riscv-imsic-state.h
> > new file mode 100644
> > index 000000000000..3170018949a8
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-riscv-imsic-state.h
> > @@ -0,0 +1,66 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> > + * Copyright (C) 2022 Ventana Micro Systems Inc.
> > + */
> > +
> > +#ifndef _IRQ_RISCV_IMSIC_STATE_H
> > +#define _IRQ_RISCV_IMSIC_STATE_H
> > +
> > +#include <linux/irqchip/riscv-imsic.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/fwnode.h>
> > +
> > +struct imsic_priv {
> > +     /* Device details */
> > +     struct fwnode_handle *fwnode;
> > +
> > +     /* Global configuration common for all HARTs */
> > +     struct imsic_global_config global;
> > +
> > +     /* Global state of interrupt identities */
> > +     raw_spinlock_t ids_lock;
> > +     unsigned long *ids_used_bimap;
> > +     unsigned long *ids_enabled_bimap;
> > +     unsigned int *ids_target_cpu;
> > +
> > +     /* IPI interrupt identity and synchronization */
> > +     u32 ipi_id;
> > +     int ipi_virq;
> > +     struct irq_desc *ipi_lsync_desc;
> > +
> > +     /* IRQ domains (created by platform driver) */
> > +     struct irq_domain *base_domain;
> > +     struct irq_domain *plat_domain;
> > +};
> > +
> > +extern struct imsic_priv *imsic;
> > +
> > +void __imsic_eix_update(unsigned long base_id,
> > +                     unsigned long num_id, bool pend, bool val);
> > +
> > +#define __imsic_id_enable(__id)              \
> > +     __imsic_eix_update((__id), 1, false, true)
> > +#define __imsic_id_disable(__id)     \
> > +     __imsic_eix_update((__id), 1, false, false)
> > +
> > +void imsic_id_set_target(unsigned int id, unsigned int target_cpu);
> > +unsigned int imsic_id_get_target(unsigned int id);
> > +
> > +void imsic_ids_local_sync(void);
> > +void imsic_ids_local_delivery(bool enable);
> > +
> > +#ifdef CONFIG_SMP
> > +void imsic_ids_remote_sync(void);
> > +#else
> > +static inline void imsic_ids_remote_sync(void)
> > +{
> > +}
> > +#endif
> > +
> > +int imsic_ids_alloc(unsigned int order);
> > +void imsic_ids_free(unsigned int base_id, unsigned int order);
> > +
> > +int imsic_setup_state(struct fwnode_handle *fwnode);
> > +
> > +#endif
> > diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchi=
p/riscv-imsic.h
> > new file mode 100644
> > index 000000000000..1f6fc9a57218
> > --- /dev/null
> > +++ b/include/linux/irqchip/riscv-imsic.h
> > @@ -0,0 +1,86 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> > + * Copyright (C) 2022 Ventana Micro Systems Inc.
> > + */
> > +#ifndef __LINUX_IRQCHIP_RISCV_IMSIC_H
> > +#define __LINUX_IRQCHIP_RISCV_IMSIC_H
> > +
> > +#include <linux/types.h>
> > +#include <asm/csr.h>
> > +
> > +#define IMSIC_MMIO_PAGE_SHIFT                12
> > +#define IMSIC_MMIO_PAGE_SZ           (1UL << IMSIC_MMIO_PAGE_SHIFT)
> > +#define IMSIC_MMIO_PAGE_LE           0x00
> > +#define IMSIC_MMIO_PAGE_BE           0x04
> > +
> > +#define IMSIC_MIN_ID                 63
> > +#define IMSIC_MAX_ID                 2048
> > +
> > +#define IMSIC_EIDELIVERY             0x70
> > +
> > +#define IMSIC_EITHRESHOLD            0x72
> > +
> > +#define IMSIC_EIP0                   0x80
> > +#define IMSIC_EIP63                  0xbf
> > +#define IMSIC_EIPx_BITS                      32
> > +
> > +#define IMSIC_EIE0                   0xc0
> > +#define IMSIC_EIE63                  0xff
> > +#define IMSIC_EIEx_BITS                      32
> > +
> > +#define IMSIC_FIRST                  IMSIC_EIDELIVERY
> > +#define IMSIC_LAST                   IMSIC_EIE63
> > +
> > +#define IMSIC_MMIO_SETIPNUM_LE               0x00
> > +#define IMSIC_MMIO_SETIPNUM_BE               0x04
> > +
> > +struct imsic_local_config {
> > +     phys_addr_t msi_pa;
> > +     void __iomem *msi_va;
> > +};
> > +
> > +struct imsic_global_config {
> > +     /*
> > +      * MSI Target Address Scheme
> > +      *
> > +      * XLEN-1                                                12     0
> > +      * |                                                     |     |
> > +      * -------------------------------------------------------------
> > +      * |xxxxxx|Group Index|xxxxxxxxxxx|HART Index|Guest Index|  0  |
> > +      * -------------------------------------------------------------
> > +      */
> > +
> > +     /* Bits representing Guest index, HART index, and Group index */
> > +     u32 guest_index_bits;
> > +     u32 hart_index_bits;
> > +     u32 group_index_bits;
> > +     u32 group_index_shift;
> > +
> > +     /* Global base address matching all target MSI addresses */
> > +     phys_addr_t base_addr;
> > +
> > +     /* Number of interrupt identities */
> > +     u32 nr_ids;
> > +
> > +     /* Number of guest interrupt identities */
> > +     u32 nr_guest_ids;
> > +
> > +     /* Per-CPU IMSIC addresses */
> > +     struct imsic_local_config __percpu *local;
> > +};
> > +
> > +#ifdef CONFIG_RISCV_IMSIC
> > +
> > +extern const struct imsic_global_config *imsic_get_global_config(void)=
;
> > +
> > +#else
> > +
> > +static inline const struct imsic_global_config *imsic_get_global_confi=
g(void)
> > +{
> > +     return NULL;
> > +}
> > +
> > +#endif
> > +
> > +#endif
> > --
> > 2.34.1
> >
