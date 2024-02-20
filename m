Return-Path: <linux-kernel+bounces-73053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0AF85BCC3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10FA1F22E72
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C976A322;
	Tue, 20 Feb 2024 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ppMhjSOl"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F295569E03
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708434052; cv=none; b=A+rlyMfLLP0DMJh5Z1zM5mGmgtZlxn1vjJIVEU4iqIWsaoH4A24gQhrTR0cnrjupPMF2Tfi7SpazHUnu9utC3yGrkUbp0mO/FEg8lirB4PcUaoRJHRVJSkzSYTO4qPbUy+Ehy2g/lWF2HJRMlDknCauvmiQhrXSpxAVULGt8FQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708434052; c=relaxed/simple;
	bh=c41NTeJC1P+mjnLxJbfqqQefUIFrjFZKxUfR9FxLlmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9ffpeeFdim3YfSqcLha3EmsjhLWVUDgHXQOOvP7oTI2lkpml6+Vo+j4NGLULWRipakVTKNpkVFeLl1wCLBwfbDt5+82vTIdBBT6dnOo/5orV1WPSRFHnjW3tAEKHfhxQ/PVesGrrayVg8XC3OvcWvKGf83s9e9+l7/RXStrEjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ppMhjSOl; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51294b40a52so3608003e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708434047; x=1709038847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=johSKb6MB66uywrAshyilHcLBhnY/NLhu2hKnCFZ5zU=;
        b=ppMhjSOlvqPXZDl0mTrMzdCM/wp/OpD0ydsnPoPKd3thfPyKhWEuA6s9FFW/ajFK1t
         gSEMKIUVvFi01bZJFcnaAdH94N1dpWgXRNA2Kj0mWVG3ZOYkQgpGXvjMixKvOtj+nE4H
         Guet17h83ZhtIdFVg4b/q60rjwnBh8xfRzTacxq5Bdl2LtdhuKBNEXuGELjRaweqSspP
         /MyCl3mnAJ8tVkdYNUYS7LsRwW2RVPiskwycqO35g0yrJofqvkWD9Lx7qv3G2Zat9feH
         jiVg9ZPncSqMLlN2BoXSuoShcP+7BUxpKLKiS8lc4MIi8VPntHr5h35v6g+/4A4VXEX+
         V60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708434047; x=1709038847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=johSKb6MB66uywrAshyilHcLBhnY/NLhu2hKnCFZ5zU=;
        b=ezYHTP+JaKFsiwtkartwWLr4dDaUJ04UhUHjSBrEZZNaK9b00VYgVy9C2416uLSU09
         vkERUViEw34N2OK1Vo3yXAc16kCqhBLiyGykiINrbata3NE7Kf/RmnQ8athjseZvdZzU
         zsAVNyU8hW1KHXyUWvv30XHq9ZzC/ZbVD0Gy4B5rMgUxyWOA46qvky5pshmtBAi5kgvb
         CADNk0ANnQhhK4AYzJr2uh/lZfmzNWQEJwu9bBEgAObbT0xJXrfD5/X6eKjG4xdv3Wxb
         HcGdCfDhN4Mk8JEBoPbahEnkF04ErFkBQzwxHw12UxFvvgvkrLRuU1iWFGL9O/1gW2ye
         M5Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWggKHUscqQGx5WZWUUFmErPJl0CU8YF1zUaAwOUuu+me47yf9o2NTajrxOanmj4bmmieMIxTELOgBZspi2PhQXO+AdfGOAQIqAnf6m
X-Gm-Message-State: AOJu0Yyds6Kg4U2VKtAZkP4gWCjQw0sklPwZYXAxBZxKkZs8wGDmR5WV
	uSpE0cvrx/Pl/z7lg5Cq9+EFdgtt2gM6GXZp6F87OXJ7scLO8YqCjp4BxBluhJIMh4U8hbvAXiJ
	5Jeyxng4ZCuOxAbiRx6rSpEnap3xTyA1UGBGj6Q==
X-Google-Smtp-Source: AGHT+IHDcj4HWZldZt3qrjxI+n3X+nthP9jWk0YfghCvTyxb5fJ2DHJjVFfJ10g7F0QSPilodfuZr0dDs7owT9gDzus=
X-Received: by 2002:a05:6512:2397:b0:512:a775:7613 with SMTP id
 c23-20020a056512239700b00512a7757613mr3280514lfv.8.1708434046449; Tue, 20 Feb
 2024 05:00:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220060718.823229-1-apatel@ventanamicro.com>
 <20240220060718.823229-7-apatel@ventanamicro.com> <87frxnfj3p.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87frxnfj3p.fsf@all.your.base.are.belong.to.us>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 20 Feb 2024 18:30:34 +0530
Message-ID: <CAK9=C2Xnzg3KAVETXN+ZGLWhVtaJuU4uXs3WH2ZondkBJMHFcA@mail.gmail.com>
Subject: Re: [PATCH v13 06/13] irqchip: Add RISC-V incoming MSI controller
 early driver
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>, Anup Patel <anup@brainfault.org>, 
	linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 5:22=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
org> wrote:
>
> Anup,
>
> This version is so much easier to follow! Thanks a lot for then
> cleanups/design changes.
>
> A bunch of nits, and a major one, below.

Sure, I will address the nits in the next revision.

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
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/irqchip/Kconfig                 |   7 +
> >  drivers/irqchip/Makefile                |   1 +
> >  drivers/irqchip/irq-riscv-imsic-early.c | 213 ++++++
> >  drivers/irqchip/irq-riscv-imsic-state.c | 906 ++++++++++++++++++++++++
> >  drivers/irqchip/irq-riscv-imsic-state.h |  98 +++
> >  include/linux/irqchip/riscv-imsic.h     |  87 +++
> >  6 files changed, 1312 insertions(+)
> >  create mode 100644 drivers/irqchip/irq-riscv-imsic-early.c
> >  create mode 100644 drivers/irqchip/irq-riscv-imsic-state.c
> >  create mode 100644 drivers/irqchip/irq-riscv-imsic-state.h
> >  create mode 100644 include/linux/irqchip/riscv-imsic.h
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index f7149d0f3d45..85f86e31c996 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -546,6 +546,13 @@ config SIFIVE_PLIC
> >       select IRQ_DOMAIN_HIERARCHY
> >       select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
> >
> > +config RISCV_IMSIC
> > +     bool
> > +     depends on RISCV
> > +     select IRQ_DOMAIN_HIERARCHY
> > +     select GENERIC_IRQ_MATRIX_ALLOCATOR
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
> > index 000000000000..32fe428b1c19
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-riscv-imsic-early.c
> > @@ -0,0 +1,213 @@
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
> > +static void imsic_ipi_send(unsigned int cpu)
> > +{
> > +     struct imsic_local_config *local =3D per_cpu_ptr(imsic->global.lo=
cal, cpu);
> > +
> > +     writel_relaxed(IMSIC_IPI_ID, local->msi_va);
> > +}
> > +
> > +static void imsic_ipi_starting_cpu(void)
> > +{
> > +     /* Enable IPIs for current CPU. */
> > +     __imsic_id_set_enable(IMSIC_IPI_ID);
> > +}
> > +
> > +static void imsic_ipi_dying_cpu(void)
> > +{
> > +     /* Disable IPIs for current CPU. */
> > +     __imsic_id_clear_enable(IMSIC_IPI_ID);
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
>
> Nit: No parenthesis need to clutter.
>
> > +
> > +     /* Set vIRQ range */
> > +     riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI, true);
> > +
> > +     /* Announce that IMSIC is providing IPIs */
> > +     pr_info("%pfwP: providing IPIs using interrupt %d\n", imsic->fwno=
de, IMSIC_IPI_ID);
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
>
> Nit: Wdyt about moving shift into the loop predicate, or using >>=3D?
>
> > +
> > +             if (local_id =3D=3D IMSIC_IPI_ID) {
> > +#ifdef CONFIG_SMP
> > +                     ipi_mux_process();
> > +#endif
>
> Is IMSIC_IPI_ID a thing on !IS_ENABLED(CONFIG_SMP)?
>
> > +                     continue;
> > +             }
> > +
> > +             if (unlikely(!imsic->base_domain))
> > +                     continue;
> > +
> > +             vec =3D imsic_vector_from_local_id(cpu, local_id);
> > +             if (!vec) {
> > +                     pr_warn_ratelimited("vector not found for local I=
D 0x%lx\n", local_id);
> > +                     continue;
> > +             }
> > +
> > +             err =3D generic_handle_domain_irq(imsic->base_domain,
> > +                                             vec->hwirq);
>
> Nit: 100 chars
>
> > +             if (unlikely(err))
> > +                     pr_warn_ratelimited("hwirq 0x%x mapping not found=
\n", vec->hwirq);
> > +     }
> > +
> > +     chained_irq_exit(chip, desc);
> > +}
> > +
> > +static int imsic_starting_cpu(unsigned int cpu)
> > +{
> > +     /* Mark per-CPU IMSIC state as online */
> > +     imsic_state_online();
> > +
> > +     /* Enable per-CPU parent interrupt */
> > +     enable_percpu_irq(imsic_parent_irq, irq_get_trigger_type(imsic_pa=
rent_irq));
> > +
> > +     /* Setup IPIs */
> > +     imsic_ipi_starting_cpu();
> > +
> > +     /*
> > +      * Interrupts identities might have been enabled/disabled while
> > +      * this CPU was not running so sync-up local enable/disable state=
.
> > +      */
> > +     imsic_local_sync_all();
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
> > +     /* Mark per-CPU IMSIC state as offline */
> > +     imsic_state_offline();
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init imsic_early_probe(struct fwnode_handle *fwnode)
> > +{
> > +     struct irq_domain *domain;
> > +     int rc;
> > +
> > +     /* Find parent domain and register chained handler */
> > +     domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMA=
IN_BUS_ANY);
> > +     if (!domain) {
> > +             pr_err("%pfwP: Failed to find INTC domain\n", fwnode);
> > +             return -ENOENT;
> > +     }
> > +     imsic_parent_irq =3D irq_create_mapping(domain, RV_IRQ_EXT);
> > +     if (!imsic_parent_irq) {
> > +             pr_err("%pfwP: Failed to create INTC mapping\n", fwnode);
> > +             return -ENOENT;
> > +     }
> > +
> > +     /* Initialize IPI domain */
> > +     rc =3D imsic_ipi_domain_init();
> > +     if (rc) {
> > +             pr_err("%pfwP: Failed to initialize IPI domain\n", fwnode=
);
> > +             return rc;
> > +     }
> > +
> > +     /* Setup chained handler to the parent domain interrupt */
> > +     irq_set_chained_handler(imsic_parent_irq, imsic_handle_irq);
> > +
> > +     /*
> > +      * Setup cpuhp state (must be done after setting imsic_parent_irq=
)
> > +      *
> > +      * Don't disable per-CPU IMSIC file when CPU goes offline
> > +      * because this affects IPI and the masking/unmasking of
> > +      * virtual IPIs is done via generic IPI-Mux
> > +      */
> > +     cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "irqchip/riscv/imsic:start=
ing",
> > +                       imsic_starting_cpu, imsic_dying_cpu);
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init imsic_early_dt_init(struct device_node *node,
> > +                                   struct device_node *parent)
> > +{
> > +     struct fwnode_handle *fwnode =3D &node->fwnode;
> > +     int rc;
> > +
> > +     /* Setup IMSIC state */
> > +     rc =3D imsic_setup_state(fwnode);
> > +     if (rc) {
> > +             pr_err("%pfwP: failed to setup state (error %d)\n",
> > +                     fwnode, rc);
>
> Nit. 100 chars
>
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
> > index 000000000000..4f347486ec7c
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-riscv-imsic-state.c
> > @@ -0,0 +1,906 @@
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
> > +static inline void imsic_csr_write(unsigned long reg, unsigned long va=
l)
> > +{
> > +     csr_write(CSR_ISELECT, reg);
> > +     csr_write(CSR_IREG, val);
> > +}
> > +
> > +static inline unsigned long imsic_csr_read(unsigned long reg)
> > +{
> > +     csr_write(CSR_ISELECT, reg);
> > +     return csr_read(CSR_IREG);
> > +}
> > +
> > +static inline unsigned long imsic_csr_read_clear(unsigned long reg, un=
signed long val)
> > +{
> > +     csr_write(CSR_ISELECT, reg);
> > +     return csr_read_clear(CSR_IREG, val);
> > +}
> > +
> > +static inline void imsic_csr_set(unsigned long reg, unsigned long val)
> > +{
> > +     csr_write(CSR_ISELECT, reg);
> > +     csr_set(CSR_IREG, val);
> > +}
> > +
> > +static inline void imsic_csr_clear(unsigned long reg, unsigned long va=
l)
> > +{
> > +     csr_write(CSR_ISELECT, reg);
> > +     csr_clear(CSR_IREG, val);
> > +}
> > +
> > +struct imsic_priv *imsic;
> > +
> > +const struct imsic_global_config *imsic_get_global_config(void)
> > +{
> > +     return imsic ? &imsic->global : NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(imsic_get_global_config);
> > +
> > +static bool __imsic_eix_read_clear(unsigned long id, bool pend)
> > +{
> > +     unsigned long isel, imask;
> > +
> > +     isel =3D id / BITS_PER_LONG;
> > +     isel *=3D BITS_PER_LONG / IMSIC_EIPx_BITS;
> > +     isel +=3D pend ? IMSIC_EIP0 : IMSIC_EIE0;
> > +     imask =3D BIT(id & (__riscv_xlen - 1));
> > +
> > +     return (imsic_csr_read_clear(isel, imask) & imask) ? true : false=
;
>
> Nit: use return !!(imsic_csr_read_clear(isel, imask) & imask)
>
> > +}
> > +
> > +static inline bool __imsic_id_read_clear_enabled(unsigned long id)
> > +{
> > +     return __imsic_eix_read_clear(id, false);
> > +}
> > +
> > +static inline bool __imsic_id_read_clear_pending(unsigned long id)
> > +{
> > +     return __imsic_eix_read_clear(id, true);
> > +}
> > +
> > +void __imsic_eix_update(unsigned long base_id, unsigned long num_id, b=
ool pend, bool val)
> > +{
> > +     unsigned long id =3D base_id, last_id =3D base_id + num_id;
> > +     unsigned long i, isel, ireg;
> > +
> > +     while (id < last_id) {
> > +             isel =3D id / BITS_PER_LONG;
> > +             isel *=3D BITS_PER_LONG / IMSIC_EIPx_BITS;
> > +             isel +=3D (pend) ? IMSIC_EIP0 : IMSIC_EIE0;
>
> Nit: Redundant parenthesis.
>
> > +
> > +             /*
> > +              * Prepare the ID mask to be programmed in the
> > +              * IMSIC EIEx and EIPx registers. These registers
> > +              * are XLEN-wide and we must not touch IDs which
> > +              * are < base_id and >=3D (base_id + num_id).
> > +              */
> > +             ireg =3D 0;
> > +             for (i =3D id & (__riscv_xlen - 1); (id < last_id) && (i =
< __riscv_xlen); i++) {
>
> Nit: Redundant parenthesis "(id < last_id) && (i < __riscv_xlen)", which
> is also inconsistent with other usage in this changeset.
>
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
> > +/* MUST be called with lpriv->lock held */
> > +static void __imsic_local_sync(struct imsic_local_priv *lpriv)
> > +{
> > +     struct imsic_local_config *mlocal;
> > +     struct imsic_vector *vec, *mvec;
> > +     int i;
> > +
> > +     /* This pairs with the barrier in __imsic_remote_sync(). */
> > +     smp_mb();
> > +
> > +     for_each_set_bit(i, lpriv->dirty_bitmap, imsic->global.nr_ids + 1=
) {
> > +             if (!i || i =3D=3D IMSIC_IPI_ID)
> > +                     goto skip;
> > +             vec =3D &lpriv->vectors[i];
> > +
> > +             if (vec->enable)
> > +                     __imsic_id_set_enable(i);
> > +             else
> > +                     __imsic_id_clear_enable(i);
> > +
> > +             /*
> > +              * If the ID was being moved to a new ID on some other CP=
U
> > +              * then we can get a MSI during the movement so check the
> > +              * ID pending bit and re-trigger the new ID on other CPU
> > +              * using MMIO write.
> > +              */
> > +             mvec =3D vec->move;
> > +             vec->move =3D NULL;
> > +             if (mvec && mvec !=3D vec) {
> > +                     if (__imsic_id_read_clear_pending(i)) {
> > +                             mlocal =3D per_cpu_ptr(imsic->global.loca=
l, mvec->cpu);
> > +                             writel_relaxed(mvec->local_id, mlocal->ms=
i_va);
> > +                     }
> > +
> > +                     imsic_vector_free(&lpriv->vectors[i]);
> > +             }
> > +
> > +skip:
> > +             bitmap_clear(lpriv->dirty_bitmap, i, 1);
> > +     }
> > +}
> > +
> > +void imsic_local_sync_all(void)
> > +{
> > +     struct imsic_local_priv *lpriv =3D this_cpu_ptr(imsic->lpriv);
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&lpriv->lock, flags);
> > +     bitmap_fill(lpriv->dirty_bitmap, imsic->global.nr_ids + 1);
> > +     __imsic_local_sync(lpriv);
> > +     raw_spin_unlock_irqrestore(&lpriv->lock, flags);
> > +}
> > +
> > +void imsic_local_delivery(bool enable)
> > +{
> > +     if (enable) {
> > +             imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_ENABLE_EITHRESHO=
LD);
> > +             imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_ENABLE_EIDELIVERY=
);
> > +             return;
> > +     }
> > +
> > +     imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_DISABLE_EIDELIVERY);
> > +     imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_DISABLE_EITHRESHOLD);
> > +}
> > +
> > +#ifdef CONFIG_SMP
> > +static void imsic_local_timer_callback(struct timer_list *timer)
> > +{
> > +     struct imsic_local_priv *lpriv =3D this_cpu_ptr(imsic->lpriv);
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&lpriv->lock, flags);
> > +     __imsic_local_sync(lpriv);
> > +     raw_spin_unlock_irqrestore(&lpriv->lock, flags);
> > +}
> > +
> > +/* MUST be called with lpriv->lock held */
> > +static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsign=
ed int cpu)
> > +{
> > +     /*
> > +      * Ensure that changes to vector enable, vector move and
> > +      * dirty bitmap are visible to the target CPU.
> > +      *
> > +      * This pairs with the barrier in __imsic_local_sync().
> > +      */
> > +     smp_mb();
> > +
> > +     /*
> > +      * We schedule a timer on the target CPU if the target CPU is not
> > +      * same as the current CPU. An offline CPU will unconditionally
> > +      * synchronize IDs through imsic_starting_cpu() when the
> > +      * CPU is brought up.
> > +      */
> > +     if (cpu_online(cpu)) {
> > +             if (cpu !=3D smp_processor_id()) {
> > +                     if (!timer_pending(&lpriv->timer)) {
> > +                             lpriv->timer.expires =3D jiffies + 1;
> > +                             add_timer_on(&lpriv->timer, cpu);
> > +                     }
> > +             } else {
> > +                     __imsic_local_sync(lpriv);
> > +             }
>
> Nit: Early exit/return vs else-clause for readability
>
>
> > +     }
> > +}
> > +#else
> > +/* MUST be called with lpriv->lock held */
> > +static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsign=
ed int cpu)
> > +{
> > +     __imsic_local_sync(lpriv);
> > +}
> > +#endif
> > +
> > +void imsic_vector_mask(struct imsic_vector *vec)
> > +{
> > +     struct imsic_local_priv *lpriv;
> > +
> > +     lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
> > +     if (WARN_ON(&lpriv->vectors[vec->local_id] !=3D vec))
> > +             return;
> > +
> > +     /*
> > +      * This function is called through Linux irq subsystem with
> > +      * irqs disabled so no need to save/restore irq flags.
> > +      */
> > +
> > +     raw_spin_lock(&lpriv->lock);
> > +
> > +     vec->enable =3D false;
> > +     bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
> > +     __imsic_remote_sync(lpriv, vec->cpu);
> > +
> > +     raw_spin_unlock(&lpriv->lock);
> > +}
>
> Really nice that you're using a timer for the vector affinity change,
> and got rid of the special/weird IMSIC/sync IPI. Can you really use a
> timer for mask/unmask? That makes the mask/unmask operation
> asynchronous!
>
> That was what I was trying to get though with this comment:
> https://lore.kernel.org/linux-riscv/87sf24mo1g.fsf@all.your.base.are.belo=
ng.to.us/
>
> Also, using the smp_* IPI functions, you can pass arguments, so you
> don't need the dirty_bitmap tracking the changes.

The mask/unmask operations are called with irqs disabled so if
CPU X does synchronous IPI to another CPU Y from mask/unmask
operation then while CPU X is waiting for IPI to complete it cannot
receive IPI from other CPUs which can lead to crashes and stalls.

In general, we should not do any block/busy-wait work in
mask/unmask operation of an irqchip driver.

The AIA IMSIC spec allows setting ID pending bit using MSI write
irrespective whether ID is enabled or not but the interrupt will be
taken only after ID is enabled. In other words, there will be no
loss of interrupt with delayed mask/unmask using async IPI or
lazy timer.

>
> > +
> > +void imsic_vector_unmask(struct imsic_vector *vec)
> > +{
> > +     struct imsic_local_priv *lpriv;
> > +
> > +     lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
> > +     if (WARN_ON(&lpriv->vectors[vec->local_id] !=3D vec))
> > +             return;
> > +
> > +     /*
> > +      * This function is called through Linux irq subsystem with
> > +      * irqs disabled so no need to save/restore irq flags.
> > +      */
> > +
> > +     raw_spin_lock(&lpriv->lock);
> > +
> > +     vec->enable =3D true;
> > +     bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
> > +     __imsic_remote_sync(lpriv, vec->cpu);
> > +
> > +     raw_spin_unlock(&lpriv->lock);
> > +}
> > +
> > +
> > +bool imsic_vector_isenabled(struct imsic_vector *vec)
> > +{
> > +     struct imsic_local_priv *lpriv =3D per_cpu_ptr(imsic->lpriv, vec-=
>cpu);
> > +     unsigned long flags;
> > +     bool ret;
> > +
> > +     raw_spin_lock_irqsave(&lpriv->lock, flags);
> > +     ret =3D vec->enable;
> > +     raw_spin_unlock_irqrestore(&lpriv->lock, flags);
> > +
> > +     return ret;
> > +}
> > +
> > +struct imsic_vector *imsic_vector_get_move(struct imsic_vector *vec)
> > +{
> > +     struct imsic_local_priv *lpriv =3D per_cpu_ptr(imsic->lpriv, vec-=
>cpu);
> > +     struct imsic_vector *ret;
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&lpriv->lock, flags);
> > +     ret =3D vec->move;
> > +     raw_spin_unlock_irqrestore(&lpriv->lock, flags);
> > +
> > +     return ret;
> > +}
> > +
> > +static bool imsic_vector_move_update(struct imsic_local_priv *lpriv, s=
truct imsic_vector *vec,
> > +                                  bool new_enable, struct imsic_vector=
 *new_move)
> > +{
> > +     unsigned long flags;
> > +     bool enabled;
> > +
> > +     raw_spin_lock_irqsave(&lpriv->lock, flags);
> > +
> > +     /* Update enable and move details */
> > +     enabled =3D vec->enable;
> > +     vec->enable =3D new_enable;
> > +     vec->move =3D new_move;
> > +
> > +     /* Mark the vector as dirty and synchronize */
> > +     bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
> > +     __imsic_remote_sync(lpriv, vec->cpu);
> > +
> > +     raw_spin_unlock_irqrestore(&lpriv->lock, flags);
> > +
> > +     return enabled;
> > +}
> > +
> > +void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vect=
or *new_vec)
> > +{
> > +     struct imsic_local_priv *old_lpriv, *new_lpriv;
> > +     bool enabled;
> > +
> > +     if (WARN_ON(old_vec->cpu =3D=3D new_vec->cpu))
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
> > +     /*
> > +      * Move and re-trigger the new vector based on the pending
> > +      * state of the old vector because we might get a device
> > +      * interrupt on the old vector while device was being moved
> > +      * to the new vector.
> > +      */
> > +     enabled =3D imsic_vector_move_update(old_lpriv, old_vec, false, n=
ew_vec);
> > +     imsic_vector_move_update(new_lpriv, new_vec, enabled, new_vec);
> > +}
> > +
> > +#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
> > +void imsic_vector_debug_show(struct seq_file *m, struct imsic_vector *=
vec, int ind)
> > +{
> > +     struct imsic_local_priv *lpriv;
> > +     struct imsic_vector *mvec;
> > +     bool is_enabled;
> > +
> > +     lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
> > +     if (WARN_ON(&lpriv->vectors[vec->local_id] !=3D vec))
> > +             return;
> > +
> > +     is_enabled =3D imsic_vector_isenabled(vec);
> > +     mvec =3D imsic_vector_get_move(vec);
> > +
> > +     seq_printf(m, "%*starget_cpu      : %5u\n", ind, "", vec->cpu);
> > +     seq_printf(m, "%*starget_local_id : %5u\n", ind, "", vec->local_i=
d);
> > +     seq_printf(m, "%*sis_reserved     : %5u\n", ind, "",
> > +                (vec->local_id <=3D IMSIC_IPI_ID) ? 1 : 0);
> > +     seq_printf(m, "%*sis_enabled      : %5u\n", ind, "", (is_enabled)=
 ? 1 : 0);
> > +     seq_printf(m, "%*sis_move_pending : %5u\n", ind, "", (mvec) ? 1 :=
 0);
>
> Nit: Redundant parenthesis.
>
> > +     if (mvec) {
> > +             seq_printf(m, "%*smove_cpu        : %5u\n", ind, "", mvec=
->cpu);
> > +             seq_printf(m, "%*smove_local_id   : %5u\n", ind, "", mvec=
->local_id);
> > +     }
> > +}
> > +
> > +void imsic_vector_debug_show_summary(struct seq_file *m, int ind)
> > +{
> > +     irq_matrix_debug_show(m, imsic->matrix, ind);
> > +}
> > +#endif
> > +
> > +struct imsic_vector *imsic_vector_from_local_id(unsigned int cpu, unsi=
gned int local_id)
> > +{
> > +     struct imsic_local_priv *lpriv =3D per_cpu_ptr(imsic->lpriv, cpu)=
;
> > +
> > +     if (!lpriv || imsic->global.nr_ids < local_id)
> > +             return NULL;
> > +
> > +     return &lpriv->vectors[local_id];
> > +}
> > +
> > +struct imsic_vector *imsic_vector_alloc(unsigned int hwirq, const stru=
ct cpumask *mask)
> > +{
> > +     struct imsic_vector *vec =3D NULL;
> > +     struct imsic_local_priv *lpriv;
> > +     unsigned long flags;
> > +     unsigned int cpu;
> > +     int local_id;
> > +
> > +     raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
> > +     local_id =3D irq_matrix_alloc(imsic->matrix, mask, false, &cpu);
> > +     raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
> > +     if (local_id < 0)
> > +             return NULL;
> > +
> > +     lpriv =3D per_cpu_ptr(imsic->lpriv, cpu);
> > +     vec =3D &lpriv->vectors[local_id];
> > +     vec->hwirq =3D hwirq;
> > +     vec->enable =3D false;
> > +     vec->move =3D NULL;
> > +
> > +     return vec;
> > +}
> > +
> > +void imsic_vector_free(struct imsic_vector *vec)
> > +{
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
> > +     vec->hwirq =3D UINT_MAX;
> > +     irq_matrix_free(imsic->matrix, vec->cpu, vec->local_id, false);
> > +     raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
> > +}
> > +
> > +static void __init imsic_local_cleanup(void)
> > +{
> > +     int cpu;
> > +     struct imsic_local_priv *lpriv;
> > +
> > +     for_each_possible_cpu(cpu) {
> > +             lpriv =3D per_cpu_ptr(imsic->lpriv, cpu);
> > +
> > +             bitmap_free(lpriv->dirty_bitmap);
> > +             kfree(lpriv->vectors);
> > +     }
> > +
> > +     free_percpu(imsic->lpriv);
> > +}
> > +
> > +static int __init imsic_local_init(void)
> > +{
> > +     struct imsic_global_config *global =3D &imsic->global;
> > +     struct imsic_local_priv *lpriv;
> > +     struct imsic_vector *vec;
> > +     int cpu, i;
> > +
> > +     /* Allocate per-CPU private state */
> > +     imsic->lpriv =3D alloc_percpu(typeof(*(imsic->lpriv)));
> > +     if (!imsic->lpriv)
> > +             return -ENOMEM;
> > +
> > +     /* Setup per-CPU private state */
> > +     for_each_possible_cpu(cpu) {
> > +             lpriv =3D per_cpu_ptr(imsic->lpriv, cpu);
> > +
> > +             raw_spin_lock_init(&lpriv->lock);
> > +
> > +             /* Allocate dirty bitmap */
> > +             lpriv->dirty_bitmap =3D bitmap_zalloc(global->nr_ids + 1,=
 GFP_KERNEL);
> > +             if (!lpriv->dirty_bitmap)
> > +                     goto fail_local_cleanup;
> > +
> > +#ifdef CONFIG_SMP
> > +             /* Setup lazy timer for synchronization */
> > +             timer_setup(&lpriv->timer, imsic_local_timer_callback, TI=
MER_PINNED);
> > +#endif
> > +
> > +             /* Allocate vector array */
> > +             lpriv->vectors =3D kcalloc(global->nr_ids + 1, sizeof(*lp=
riv->vectors),
> > +                                      GFP_KERNEL);
> > +             if (!lpriv->vectors)
> > +                     goto fail_local_cleanup;
> > +
> > +             /* Setup vector array */
> > +             for (i =3D 0; i <=3D global->nr_ids; i++) {
> > +                     vec =3D &lpriv->vectors[i];
> > +                     vec->cpu =3D cpu;
> > +                     vec->local_id =3D i;
> > +                     vec->hwirq =3D UINT_MAX;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +
> > +fail_local_cleanup:
> > +     imsic_local_cleanup();
> > +     return -ENOMEM;
> > +}
> > +
> > +void imsic_state_online(void)
> > +{
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
> > +     irq_matrix_online(imsic->matrix);
> > +     raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
> > +}
> > +
> > +void imsic_state_offline(void)
> > +{
> > +#ifdef CONFIG_SMP
> > +     struct imsic_local_priv *lpriv =3D this_cpu_ptr(imsic->lpriv);
> > +#endif
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
> > +     irq_matrix_offline(imsic->matrix);
> > +     raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
> > +
> > +#ifdef CONFIG_SMP
> > +     raw_spin_lock_irqsave(&lpriv->lock, flags);
> > +     WARN_ON_ONCE(try_to_del_timer_sync(&lpriv->timer) < 0);
> > +     raw_spin_unlock_irqrestore(&lpriv->lock, flags);
> > +#endif
> > +}
> > +
> > +static int __init imsic_matrix_init(void)
> > +{
> > +     struct imsic_global_config *global =3D &imsic->global;
> > +
> > +     raw_spin_lock_init(&imsic->matrix_lock);
> > +     imsic->matrix =3D irq_alloc_matrix(global->nr_ids + 1,
> > +                                      0, global->nr_ids + 1);
> > +     if (!imsic->matrix)
> > +             return -ENOMEM;
> > +
> > +     /* Reserve ID#0 because it is special and never implemented */
> > +     irq_matrix_assign_system(imsic->matrix, 0, false);
> > +
> > +     /* Reserve IPI ID because it is special and used internally */
> > +     irq_matrix_assign_system(imsic->matrix, IMSIC_IPI_ID, false);
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init imsic_get_parent_hartid(struct fwnode_handle *fwnode=
,
> > +                                       u32 index, unsigned long *harti=
d)
> > +{
> > +     struct of_phandle_args parent;
> > +     int rc;
> > +
> > +     /*
> > +      * Currently, only OF fwnode is supported so extend this
> > +      * function for ACPI support.
> > +      */
> > +     if (!is_of_node(fwnode))
> > +             return -EINVAL;
> > +
> > +     rc =3D of_irq_parse_one(to_of_node(fwnode), index, &parent);
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
> > +     return riscv_of_parent_hartid(parent.np, hartid);
> > +}
> > +
> > +static int __init imsic_get_mmio_resource(struct fwnode_handle *fwnode=
,
> > +                                       u32 index, struct resource *res=
)
> > +{
> > +     /*
> > +      * Currently, only OF fwnode is supported so extend this
> > +      * function for ACPI support.
> > +      */
> > +     if (!is_of_node(fwnode))
> > +             return -EINVAL;
> > +
> > +     return of_address_to_resource(to_of_node(fwnode), index, res);
> > +}
> > +
> > +static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
> > +                                  struct imsic_global_config *global,
> > +                                  u32 *nr_parent_irqs,
> > +                                  u32 *nr_mmios)
> > +{
> > +     unsigned long hartid;
> > +     struct resource res;
> > +     int rc;
> > +     u32 i;
> > +
> > +     /*
> > +      * Currently, only OF fwnode is supported so extend this
> > +      * function for ACPI support.
> > +      */
> > +     if (!is_of_node(fwnode))
> > +             return -EINVAL;
> > +
> > +     *nr_parent_irqs =3D 0;
> > +     *nr_mmios =3D 0;
> > +
> > +     /* Find number of parent interrupts */
> > +     while (!imsic_get_parent_hartid(fwnode, *nr_parent_irqs, &hartid)=
)
> > +             (*nr_parent_irqs)++;
> > +     if (!(*nr_parent_irqs)) {
>
> Nit: Redundant parenthesis
>
> > +             pr_err("%pfwP: no parent irqs available\n", fwnode);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Find number of guest index bits in MSI address */
> > +     rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,guest-inde=
x-bits",
> > +                               &global->guest_index_bits);
> > +     if (rc)
> > +             global->guest_index_bits =3D 0;
> > +
> > +     /* Find number of HART index bits */
> > +     rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,hart-index=
-bits",
> > +                               &global->hart_index_bits);
> > +     if (rc) {
> > +             /* Assume default value */
> > +             global->hart_index_bits =3D __fls(*nr_parent_irqs);
> > +             if (BIT(global->hart_index_bits) < *nr_parent_irqs)
> > +                     global->hart_index_bits++;
> > +     }
> > +
> > +     /* Find number of group index bits */
> > +     rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,group-inde=
x-bits",
> > +                               &global->group_index_bits);
> > +     if (rc)
> > +             global->group_index_bits =3D 0;
> > +
> > +     /*
> > +      * Find first bit position of group index.
> > +      * If not specified assumed the default APLIC-IMSIC configuration=
.
> > +      */
> > +     rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,group-inde=
x-shift",
> > +                               &global->group_index_shift);
> > +     if (rc)
> > +             global->group_index_shift =3D IMSIC_MMIO_PAGE_SHIFT * 2;
> > +
> > +     /* Find number of interrupt identities */
> > +     rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,num-ids",
> > +                               &global->nr_ids);
> > +     if (rc) {
> > +             pr_err("%pfwP: number of interrupt identities not found\n=
",
> > +                     fwnode);
> > +             return rc;
> > +     }
> > +
> > +     /* Find number of guest interrupt identities */
> > +     rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,num-guest-=
ids",
> > +                               &global->nr_guest_ids);
> > +     if (rc)
> > +             global->nr_guest_ids =3D global->nr_ids;
> > +
> > +     /* Sanity check guest index bits */
> > +     i =3D BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT;
> > +     if (i < global->guest_index_bits) {
> > +             pr_err("%pfwP: guest index bits too big\n", fwnode);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Sanity check HART index bits */
> > +     i =3D BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT - global->guest_index=
_bits;
> > +     if (i < global->hart_index_bits) {
> > +             pr_err("%pfwP: HART index bits too big\n", fwnode);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Sanity check group index bits */
> > +     i =3D BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT -
> > +         global->guest_index_bits - global->hart_index_bits;
> > +     if (i < global->group_index_bits) {
> > +             pr_err("%pfwP: group index bits too big\n", fwnode);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Sanity check group index shift */
> > +     i =3D global->group_index_bits + global->group_index_shift - 1;
> > +     if (i >=3D BITS_PER_LONG) {
> > +             pr_err("%pfwP: group index shift too big\n", fwnode);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Sanity check number of interrupt identities */
> > +     if ((global->nr_ids < IMSIC_MIN_ID) ||
> > +         (global->nr_ids >=3D IMSIC_MAX_ID) ||
> > +         ((global->nr_ids & IMSIC_MIN_ID) !=3D IMSIC_MIN_ID)) {
> > +             pr_err("%pfwP: invalid number of interrupt identities\n",
> > +                     fwnode);
>
> Nit: 100 chars
>
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Sanity check number of guest interrupt identities */
> > +     if ((global->nr_guest_ids < IMSIC_MIN_ID) ||
> > +         (global->nr_guest_ids >=3D IMSIC_MAX_ID) ||
> > +         ((global->nr_guest_ids & IMSIC_MIN_ID) !=3D IMSIC_MIN_ID)) {
> > +             pr_err("%pfwP: invalid number of guest interrupt identiti=
es\n",
> > +                     fwnode);
>
> Nit: 100 chars
>
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Compute base address */
> > +     rc =3D imsic_get_mmio_resource(fwnode, 0, &res);
> > +     if (rc) {
> > +             pr_err("%pfwP: first MMIO resource not found\n", fwnode);
> > +             return -EINVAL;
> > +     }
> > +     global->base_addr =3D res.start;
> > +     global->base_addr &=3D ~(BIT(global->guest_index_bits +
> > +                                global->hart_index_bits +
> > +                                IMSIC_MMIO_PAGE_SHIFT) - 1);
> > +     global->base_addr &=3D ~((BIT(global->group_index_bits) - 1) <<
> > +                            global->group_index_shift);
> > +
> > +     /* Find number of MMIO register sets */
> > +     while (!imsic_get_mmio_resource(fwnode, *nr_mmios, &res))
> > +             (*nr_mmios)++;
> > +
> > +     return 0;
> > +}
> > +
> > +int __init imsic_setup_state(struct fwnode_handle *fwnode)
> > +{
> > +     u32 i, j, index, nr_parent_irqs, nr_mmios, nr_handlers =3D 0;
> > +     struct imsic_global_config *global;
> > +     struct imsic_local_config *local;
> > +     void __iomem **mmios_va =3D NULL;
> > +     struct resource *mmios =3D NULL;
> > +     unsigned long reloff, hartid;
> > +     phys_addr_t base_addr;
> > +     int rc, cpu;
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
>
> Nit: 100 chars
>
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
> > +     /* Parse IMSIC fwnode */
> > +     rc =3D imsic_parse_fwnode(fwnode, global, &nr_parent_irqs, &nr_mm=
ios);
> > +     if (rc)
> > +             goto out_free_local;
> > +
> > +     /* Allocate MMIO resource array */
> > +     mmios =3D kcalloc(nr_mmios, sizeof(*mmios), GFP_KERNEL);
> > +     if (!mmios) {
> > +             rc =3D -ENOMEM;
> > +             goto out_free_local;
> > +     }
> > +
> > +     /* Allocate MMIO virtual address array */
> > +     mmios_va =3D kcalloc(nr_mmios, sizeof(*mmios_va), GFP_KERNEL);
> > +     if (!mmios_va) {
> > +             rc =3D -ENOMEM;
> > +             goto out_iounmap;
> > +     }
> > +
> > +     /* Parse and map MMIO register sets */
> > +     for (i =3D 0; i < nr_mmios; i++) {
> > +             rc =3D imsic_get_mmio_resource(fwnode, i, &mmios[i]);
> > +             if (rc) {
> > +                     pr_err("%pfwP: unable to parse MMIO regset %d\n",
> > +                             fwnode, i);
>
> Nit: 100 chars
>
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
>
> Nit: 100 chars... and all the places below where applicable.
>
>
> Bj=C3=B6rn

Regards,
Anup

