Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96D87E598C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjKHO5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjKHO5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:57:13 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361571BE8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:57:11 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2809fb0027cso5343087a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 06:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1699455430; x=1700060230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWYxotDHLCL1ce6TweEoocKV/Hcjcr/4aF0AsbTVgFw=;
        b=c5I36tn4vfB4bH5aoSyQp8HSEy8qbKZG/d5lxLgi+wuZMfOhqDhjr3XmbUdAhNfi7A
         1OqyM0gB5Ljm+6tLBY186w3IsDkNY3pZ+Z0q/RAo6qpZuuxDeZkV3/LupVXpE2wXtTDO
         rjTKKfhqtNJ6/9vhu0IR8xtTcix+KMxRNQyjbEn+u022+1BlxD08+vslCneMtOSTof4j
         896Wl9K54yiYpYrf/KpcnKI3EJaGl6PYu6bxP87HgdxAF8BPa2FVoxYcHD1CVmv0UjGx
         UzwhMXGoJwn206nBc4n612IvxQjyFQ4iDclsguG3CFOU6ZgBGGvNr2wB+ziYJq430bP2
         C9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699455430; x=1700060230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWYxotDHLCL1ce6TweEoocKV/Hcjcr/4aF0AsbTVgFw=;
        b=Wbhr1F8qhONYp5caactAZq5DMmFck8h1cvg7QDwMvemySQmWotNpAQ+zniZJEDAnYh
         WHkoZOEQmR9oY0KAZY1ANhL9PDk/9S2wjvFNNOarg8CoLKgI9pub8Cltc/DuM/B+Uj3o
         GIkbWb4KtJIE+B7Qwvy9CP5ZPjFaYEXfMFo6xIH5kWZbqPiEwZ1fT94bzS4vhyj0OlPr
         O0QgZUF2gatl8xiWp4nQZSF1d52MEhnsrZ5K1KCIIUma0PsufQrWD+KLsTOHDEJL7xug
         G6CsAuNezGVvtZcxcveR4vCJlnGOVwY7MxNjSfDfaHj5Qshy9U3ltpof+zpcoN+i3rkt
         26yg==
X-Gm-Message-State: AOJu0YwX9YR9kTql4uWLnQxFv7lusrg7T7TvcAlaigDlE96We/cAFTaq
        Z3lhvfpzt3uQQabzERuhblmsaIbvLi06QX/VrS4sAg==
X-Google-Smtp-Source: AGHT+IESZJJ0fPF4wti+Jik14ZPAfbcM4+DPqgjSBv+7zKDeTSKYmRGO1LZE9Za7DUsjMQ16UPincm+fhb/I2fQpsrQ=
X-Received: by 2002:a17:90b:390b:b0:280:14ac:a6dc with SMTP id
 ob11-20020a17090b390b00b0028014aca6dcmr1840677pjb.25.1699455430503; Wed, 08
 Nov 2023 06:57:10 -0800 (PST)
MIME-Version: 1.0
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-13-apatel@ventanamicro.com> <22d5d9e9.258.18b97d65ce7.Coremail.figure1802@126.com>
 <CAK9=C2WPhROWKGKmLbLyS+q2ncCNTJEHnFKcYqCGJoNK4Uz=LQ@mail.gmail.com> <8624cc4.5923.18baf6adca4.Coremail.figure1802@126.com>
In-Reply-To: <8624cc4.5923.18baf6adca4.Coremail.figure1802@126.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 8 Nov 2023 20:26:59 +0530
Message-ID: <CAK9=C2Vr6BmmdNN11rn+-7JjvERiawVKOgPhMjncrUSG8x+W2Q@mail.gmail.com>
Subject: Re: Re: [PATCH v11 12/14] irqchip/riscv-aplic: Add support for MSI-mode
To:     Ben <figure1802@126.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 8:23=E2=80=AFPM Ben <figure1802@126.com> wrote:
>
> At 2023-11-08 22:43:25, "Anup Patel" <apatel@ventanamicro.com> wrote:
> >On Sat, Nov 4, 2023 at 6:30=E2=80=AFAM Ben <figure1802@126.com> wrote:
> >>
> >> At 2023-10-24 01:27:58, "Anup Patel" <apatel@ventanamicro.com> wrote:
> >> >The RISC-V advanced platform-level interrupt controller (APLIC) has
> >> >two modes of operation: 1) Direct mode and 2) MSI mode.
> >> >(For more details, refer https://github.com/riscv/riscv-aia)
> >> >
> >> >In APLIC MSI-mode, wired interrupts are forwared as message signaled
> >> >interrupts (MSIs) to CPUs via IMSIC.
> >> >
> >> >We extend the existing APLIC irqchip driver to support MSI-mode for
> >> >RISC-V platforms having both wired interrupts and MSIs.
> >> >
> >> >Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >> >---
> >> > drivers/irqchip/Kconfig                |   6 +
> >> > drivers/irqchip/Makefile               |   1 +
> >> > drivers/irqchip/irq-riscv-aplic-main.c |   2 +-
> >> > drivers/irqchip/irq-riscv-aplic-main.h |   8 +
> >> > drivers/irqchip/irq-riscv-aplic-msi.c  | 285 +++++++++++++++++++++++=
++
> >> > 5 files changed, 301 insertions(+), 1 deletion(-)
> >> > create mode 100644 drivers/irqchip/irq-riscv-aplic-msi.c
> >> >
> >> >diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> >> >index 1996cc6f666a..7adc4dbe07ff 100644
> >> >--- a/drivers/irqchip/Kconfig
> >> >+++ b/drivers/irqchip/Kconfig
> >> >@@ -551,6 +551,12 @@ config RISCV_APLIC
> >> >       depends on RISCV
> >> >       select IRQ_DOMAIN_HIERARCHY
> >> >
> >> >+config RISCV_APLIC_MSI
> >> >+      bool
> >> >+      depends on RISCV_APLIC
> >> >+      select GENERIC_MSI_IRQ
> >> >+      default RISCV_APLIC
> >> >+
> >> > config RISCV_IMSIC
> >> >       bool
> >> >       depends on RISCV
> >> >diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> >> >index 7f8289790ed8..47995fdb2c60 100644
> >> >--- a/drivers/irqchip/Makefile
> >> >+++ b/drivers/irqchip/Makefile
> >> >@@ -96,6 +96,7 @@ obj-$(CONFIG_CSKY_MPINTC)            +=3D irq-csky-=
mpintc.o
> >> > obj-$(CONFIG_CSKY_APB_INTC)           +=3D irq-csky-apb-intc.o
> >> > obj-$(CONFIG_RISCV_INTC)              +=3D irq-riscv-intc.o
> >> > obj-$(CONFIG_RISCV_APLIC)             +=3D irq-riscv-aplic-main.o ir=
q-riscv-aplic-direct.o
> >> >+obj-$(CONFIG_RISCV_APLIC_MSI)         +=3D irq-riscv-aplic-msi.o
> >> > obj-$(CONFIG_RISCV_IMSIC)             +=3D irq-riscv-imsic-state.o i=
rq-riscv-imsic-early.o irq-riscv-imsic-platform.o
> >> > obj-$(CONFIG_SIFIVE_PLIC)             +=3D irq-sifive-plic.o
> >> > obj-$(CONFIG_IMX_IRQSTEER)            +=3D irq-imx-irqsteer.o
> >> >diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip=
/irq-riscv-aplic-main.c
> >> >index 87450708a733..d1b342b66551 100644
> >> >--- a/drivers/irqchip/irq-riscv-aplic-main.c
> >> >+++ b/drivers/irqchip/irq-riscv-aplic-main.c
> >> >@@ -205,7 +205,7 @@ static int aplic_probe(struct platform_device *pd=
ev)
> >> >               msi_mode =3D of_property_present(to_of_node(dev->fwnod=
e),
> >> >                                               "msi-parent");
> >> >       if (msi_mode)
> >> >-              rc =3D -ENODEV;
> >> >+              rc =3D aplic_msi_setup(dev, regs);
> >> >       else
> >> >               rc =3D aplic_direct_setup(dev, regs);
> >> >       if (rc) {
> >> >diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip=
/irq-riscv-aplic-main.h
> >> >index 474a04229334..78267ec58098 100644
> >> >--- a/drivers/irqchip/irq-riscv-aplic-main.h
> >> >+++ b/drivers/irqchip/irq-riscv-aplic-main.h
> >> >@@ -41,5 +41,13 @@ void aplic_init_hw_global(struct aplic_priv *priv,=
 bool msi_mode);
> >> > int aplic_setup_priv(struct aplic_priv *priv, struct device *dev,
> >> >                    void __iomem *regs);
> >> > int aplic_direct_setup(struct device *dev, void __iomem *regs);
> >> >+#ifdef CONFIG_RISCV_APLIC_MSI
> >> >+int aplic_msi_setup(struct device *dev, void __iomem *regs);
> >> >+#else
> >> >+static inline int aplic_msi_setup(struct device *dev, void __iomem *=
regs)
> >> >+{
> >> >+      return -ENODEV;
> >> >+}
> >> >+#endif
> >> >
> >> > #endif
> >> >diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/=
irq-riscv-aplic-msi.c
> >> >new file mode 100644
> >> >index 000000000000..086d00e0429e
> >> >--- /dev/null
> >> >+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
> >> >@@ -0,0 +1,285 @@
> >> >+// SPDX-License-Identifier: GPL-2.0
> >> >+/*
> >> >+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> >> >+ * Copyright (C) 2022 Ventana Micro Systems Inc.
> >> >+ */
> >> >+
> >> >+#include <linux/bitops.h>
> >> >+#include <linux/cpu.h>
> >> >+#include <linux/interrupt.h>
> >> >+#include <linux/irqchip.h>
> >> >+#include <linux/irqchip/riscv-aplic.h>
> >> >+#include <linux/irqchip/riscv-imsic.h>
> >> >+#include <linux/module.h>
> >> >+#include <linux/msi.h>
> >> >+#include <linux/of_irq.h>
> >> >+#include <linux/platform_device.h>
> >> >+#include <linux/printk.h>
> >> >+#include <linux/smp.h>
> >> >+
> >> >+#include "irq-riscv-aplic-main.h"
> >> >+
> >> >+static void aplic_msi_irq_unmask(struct irq_data *d)
> >> >+{
> >> >+      aplic_irq_unmask(d);
> >> >+      irq_chip_unmask_parent(d);
> >> >+}
> >> >+
> >> >+static void aplic_msi_irq_mask(struct irq_data *d)
> >> >+{
> >> >+      aplic_irq_mask(d);
> >> >+      irq_chip_mask_parent(d);
> >> >+}
> >> >+
> >> >+static void aplic_msi_irq_eoi(struct irq_data *d)
> >> >+{
> >> >+      struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> >> >+      u32 reg_off, reg_mask;
> >> >+
> >> >+      /*
> >> >+       * EOI handling only required only for level-triggered
> >> >+       * interrupts in APLIC MSI mode.
> >> >+       */
> >> >+
> >> >+      reg_off =3D APLIC_CLRIP_BASE + ((d->hwirq / APLIC_IRQBITS_PER_=
REG) * 4);
> >> >+      reg_mask =3D BIT(d->hwirq % APLIC_IRQBITS_PER_REG);
> >> >+      switch (irqd_get_trigger_type(d)) {
> >> >+      case IRQ_TYPE_LEVEL_LOW:
> >> >+              if (!(readl(priv->regs + reg_off) & reg_mask))
> >> >+                      writel(d->hwirq, priv->regs + APLIC_SETIPNUM_L=
E);
> >> >+              break;
> >> >+      case IRQ_TYPE_LEVEL_HIGH:
> >> >+              if (readl(priv->regs + reg_off) & reg_mask)
> >> >+                      writel(d->hwirq, priv->regs + APLIC_SETIPNUM_L=
E);
> >> >+              break;
> >> >+      }
> >> >+}
> >> >+
> >> >+static struct irq_chip aplic_msi_chip =3D {
> >> >+      .name           =3D "APLIC-MSI",
> >> >+      .irq_mask       =3D aplic_msi_irq_mask,
> >> >+      .irq_unmask     =3D aplic_msi_irq_unmask,
> >> >+      .irq_set_type   =3D aplic_irq_set_type,
> >> >+      .irq_eoi        =3D aplic_msi_irq_eoi,
> >> >+#ifdef CONFIG_SMP
> >> >+      .irq_set_affinity =3D irq_chip_set_affinity_parent,
> >> >+#endif
> >> >+      .flags          =3D IRQCHIP_SET_TYPE_MASKED |
> >> >+                        IRQCHIP_SKIP_SET_WAKE |
> >> >+                        IRQCHIP_MASK_ON_SUSPEND,
> >> >+};
> >> >+
> >> >+static int aplic_msi_irqdomain_translate(struct irq_domain *d,
> >> >+                                       struct irq_fwspec *fwspec,
> >> >+                                       unsigned long *hwirq,
> >> >+                                       unsigned int *type)
> >> >+{
> >> >+      struct aplic_priv *priv =3D platform_msi_get_host_data(d);
> >> >+
> >> >+      return aplic_irqdomain_translate(fwspec, priv->gsi_base, hwirq=
, type);
> >> >+}
> >> >+
> >> >+static int aplic_msi_irqdomain_alloc(struct irq_domain *domain,
> >> >+                                   unsigned int virq, unsigned int n=
r_irqs,
> >> >+                                   void *arg)
> >> >+{
> >> >+      int i, ret;
> >> >+      unsigned int type;
> >> >+      irq_hw_number_t hwirq;
> >> >+      struct irq_fwspec *fwspec =3D arg;
> >> >+      struct aplic_priv *priv =3D platform_msi_get_host_data(domain)=
;
> >> >+
> >> >+      ret =3D aplic_irqdomain_translate(fwspec, priv->gsi_base, &hwi=
rq, &type);
> >> >+      if (ret)
> >> >+              return ret;
> >>
> >> In your patchset, the wired IRQ and IRQ of platform device will go int=
o APLIC-MSI domain firstly.
> >
> >Yes, that is correct. In general, this applies to AIA specification
> >and nothing to do with this patchset.
> >
> >> Let me assume here is a MSI IRQ not wired IRQ on a device, and it is a=
 platform device in system.
> >> so in aplic_irqdomain_translate() function, it will parse the APLIC ph=
ysical IRQ number by fwspec->param[0],
> >> but this is not a wried IRQ, it is a MSI IRQ, it should not has a APLI=
C physical IRQ number, the hwirq number should be allocated by MSI bitmap,
> >> what value will be parse by DTS? zero or negative?
> >
> >For platform devices with MSI support, the MSIs will directly target
> >the per-HART
> >IMSICs and the DT node of such devices will never point to APLIC as the =
parent
> >MSI controller.
> >
>
> >The IMSIC driver implements the IMSIC-PLAT domain for platform MSIs.
>
> Have you test this case on QEMU? would you like share the test steps?

The APLIC in MSI-mode acts like a platform device with MSIs so yes this
is tested on QEMU.

Regards,
Anup
