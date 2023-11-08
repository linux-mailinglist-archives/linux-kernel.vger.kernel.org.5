Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D977E5964
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbjKHOnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjKHOnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:43:39 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1069D1BDA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:43:37 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc5b705769so63043855ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 06:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1699454616; x=1700059416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDkHjPb8pb21TKY2YVZ2Y6qV7ih7L1jZyKVUM2SNT9o=;
        b=RwylyeUNyjvOe7tx63Ba+/MU3tkt6+7bXIU1A2xonlc+fYo2FmssxPNBV4Dev8az20
         w7UJrEdvqgo4coZaFZvfWwQzPfEuzH5g6gs/G9WtDZ4IZz3z6vaIeLxq0ExybFf+JdhD
         azWTCWxlH/KuOBHdPgOQxM+yu+pMgueO+UIFM6m69bqoWtP4QsNctOp9QvLWy6yphIIb
         4INokRFMWg7+a1SnbOm1hipZVcu1rQRf0FRVTutXEyoYuDAAomkMi+3yacNskeK8JcBF
         eEMjHAVk46CBj9XGL6mmfj7BCB8tVSc42WLdUzYa7pMhbzAeTvSw1xWdfDzbzH9ZlhQN
         ty+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699454616; x=1700059416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDkHjPb8pb21TKY2YVZ2Y6qV7ih7L1jZyKVUM2SNT9o=;
        b=iVwuu6zNf5Ux//gBLDOb4IgGRp2neGL86UfVH4EY88j+ujRjfNb2R0Ongo92Jd+0Gv
         lT82mSn2dCLp5QoN/hqwjpY/TBmEM+zUVIaAEB5AJYpoWzOeJzWvuuHq9hR6stfRdj9P
         tIOgM5Y3JtDUb+SBXVdmNOJQU2AuL9aTd0YhnvR+kTCxRdyTOioXuWHMqHqR4Bo/oaOh
         xF7wsErQMelgSKP1MCZ7s4KEqr3iTOQ0d0/Y26nrnStqyBOPlI+f56Q+QszmUvYREIJK
         aYkYExGMaj41xOrHad8M9M3rcaLk4lb9iuHTPyOCz5kAI4ubhElg7ttikZ8zMtWH59cI
         UQTg==
X-Gm-Message-State: AOJu0YxfD7jPclmFHaS4eDVu/nEOsHEsi1UJ9FjYajHArNWfhSZx9Fbj
        ADTQr6mQOg6JyMKHc8uOk3YqgJSb1/OOuF6SufAIfg==
X-Google-Smtp-Source: AGHT+IEcCYyR/0LSXmWtKIwa67gb5v19A99n53aXkpoAi+SlFv6wJfn37p2kEkDybBnfjDcmPYBQ82qYSXcE9+2s5bg=
X-Received: by 2002:a17:90b:4c42:b0:280:cc88:2a46 with SMTP id
 np2-20020a17090b4c4200b00280cc882a46mr2027155pjb.4.1699454616246; Wed, 08 Nov
 2023 06:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-13-apatel@ventanamicro.com> <22d5d9e9.258.18b97d65ce7.Coremail.figure1802@126.com>
In-Reply-To: <22d5d9e9.258.18b97d65ce7.Coremail.figure1802@126.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 8 Nov 2023 20:13:25 +0530
Message-ID: <CAK9=C2WPhROWKGKmLbLyS+q2ncCNTJEHnFKcYqCGJoNK4Uz=LQ@mail.gmail.com>
Subject: Re: [PATCH v11 12/14] irqchip/riscv-aplic: Add support for MSI-mode
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

On Sat, Nov 4, 2023 at 6:30=E2=80=AFAM Ben <figure1802@126.com> wrote:
>
> At 2023-10-24 01:27:58, "Anup Patel" <apatel@ventanamicro.com> wrote:
> >The RISC-V advanced platform-level interrupt controller (APLIC) has
> >two modes of operation: 1) Direct mode and 2) MSI mode.
> >(For more details, refer https://github.com/riscv/riscv-aia)
> >
> >In APLIC MSI-mode, wired interrupts are forwared as message signaled
> >interrupts (MSIs) to CPUs via IMSIC.
> >
> >We extend the existing APLIC irqchip driver to support MSI-mode for
> >RISC-V platforms having both wired interrupts and MSIs.
> >
> >Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >---
> > drivers/irqchip/Kconfig                |   6 +
> > drivers/irqchip/Makefile               |   1 +
> > drivers/irqchip/irq-riscv-aplic-main.c |   2 +-
> > drivers/irqchip/irq-riscv-aplic-main.h |   8 +
> > drivers/irqchip/irq-riscv-aplic-msi.c  | 285 +++++++++++++++++++++++++
> > 5 files changed, 301 insertions(+), 1 deletion(-)
> > create mode 100644 drivers/irqchip/irq-riscv-aplic-msi.c
> >
> >diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> >index 1996cc6f666a..7adc4dbe07ff 100644
> >--- a/drivers/irqchip/Kconfig
> >+++ b/drivers/irqchip/Kconfig
> >@@ -551,6 +551,12 @@ config RISCV_APLIC
> >       depends on RISCV
> >       select IRQ_DOMAIN_HIERARCHY
> >
> >+config RISCV_APLIC_MSI
> >+      bool
> >+      depends on RISCV_APLIC
> >+      select GENERIC_MSI_IRQ
> >+      default RISCV_APLIC
> >+
> > config RISCV_IMSIC
> >       bool
> >       depends on RISCV
> >diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> >index 7f8289790ed8..47995fdb2c60 100644
> >--- a/drivers/irqchip/Makefile
> >+++ b/drivers/irqchip/Makefile
> >@@ -96,6 +96,7 @@ obj-$(CONFIG_CSKY_MPINTC)            +=3D irq-csky-mpi=
ntc.o
> > obj-$(CONFIG_CSKY_APB_INTC)           +=3D irq-csky-apb-intc.o
> > obj-$(CONFIG_RISCV_INTC)              +=3D irq-riscv-intc.o
> > obj-$(CONFIG_RISCV_APLIC)             +=3D irq-riscv-aplic-main.o irq-r=
iscv-aplic-direct.o
> >+obj-$(CONFIG_RISCV_APLIC_MSI)         +=3D irq-riscv-aplic-msi.o
> > obj-$(CONFIG_RISCV_IMSIC)             +=3D irq-riscv-imsic-state.o irq-=
riscv-imsic-early.o irq-riscv-imsic-platform.o
> > obj-$(CONFIG_SIFIVE_PLIC)             +=3D irq-sifive-plic.o
> > obj-$(CONFIG_IMX_IRQSTEER)            +=3D irq-imx-irqsteer.o
> >diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/ir=
q-riscv-aplic-main.c
> >index 87450708a733..d1b342b66551 100644
> >--- a/drivers/irqchip/irq-riscv-aplic-main.c
> >+++ b/drivers/irqchip/irq-riscv-aplic-main.c
> >@@ -205,7 +205,7 @@ static int aplic_probe(struct platform_device *pdev)
> >               msi_mode =3D of_property_present(to_of_node(dev->fwnode),
> >                                               "msi-parent");
> >       if (msi_mode)
> >-              rc =3D -ENODEV;
> >+              rc =3D aplic_msi_setup(dev, regs);
> >       else
> >               rc =3D aplic_direct_setup(dev, regs);
> >       if (rc) {
> >diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip/ir=
q-riscv-aplic-main.h
> >index 474a04229334..78267ec58098 100644
> >--- a/drivers/irqchip/irq-riscv-aplic-main.h
> >+++ b/drivers/irqchip/irq-riscv-aplic-main.h
> >@@ -41,5 +41,13 @@ void aplic_init_hw_global(struct aplic_priv *priv, bo=
ol msi_mode);
> > int aplic_setup_priv(struct aplic_priv *priv, struct device *dev,
> >                    void __iomem *regs);
> > int aplic_direct_setup(struct device *dev, void __iomem *regs);
> >+#ifdef CONFIG_RISCV_APLIC_MSI
> >+int aplic_msi_setup(struct device *dev, void __iomem *regs);
> >+#else
> >+static inline int aplic_msi_setup(struct device *dev, void __iomem *reg=
s)
> >+{
> >+      return -ENODEV;
> >+}
> >+#endif
> >
> > #endif
> >diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq=
-riscv-aplic-msi.c
> >new file mode 100644
> >index 000000000000..086d00e0429e
> >--- /dev/null
> >+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
> >@@ -0,0 +1,285 @@
> >+// SPDX-License-Identifier: GPL-2.0
> >+/*
> >+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> >+ * Copyright (C) 2022 Ventana Micro Systems Inc.
> >+ */
> >+
> >+#include <linux/bitops.h>
> >+#include <linux/cpu.h>
> >+#include <linux/interrupt.h>
> >+#include <linux/irqchip.h>
> >+#include <linux/irqchip/riscv-aplic.h>
> >+#include <linux/irqchip/riscv-imsic.h>
> >+#include <linux/module.h>
> >+#include <linux/msi.h>
> >+#include <linux/of_irq.h>
> >+#include <linux/platform_device.h>
> >+#include <linux/printk.h>
> >+#include <linux/smp.h>
> >+
> >+#include "irq-riscv-aplic-main.h"
> >+
> >+static void aplic_msi_irq_unmask(struct irq_data *d)
> >+{
> >+      aplic_irq_unmask(d);
> >+      irq_chip_unmask_parent(d);
> >+}
> >+
> >+static void aplic_msi_irq_mask(struct irq_data *d)
> >+{
> >+      aplic_irq_mask(d);
> >+      irq_chip_mask_parent(d);
> >+}
> >+
> >+static void aplic_msi_irq_eoi(struct irq_data *d)
> >+{
> >+      struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> >+      u32 reg_off, reg_mask;
> >+
> >+      /*
> >+       * EOI handling only required only for level-triggered
> >+       * interrupts in APLIC MSI mode.
> >+       */
> >+
> >+      reg_off =3D APLIC_CLRIP_BASE + ((d->hwirq / APLIC_IRQBITS_PER_REG=
) * 4);
> >+      reg_mask =3D BIT(d->hwirq % APLIC_IRQBITS_PER_REG);
> >+      switch (irqd_get_trigger_type(d)) {
> >+      case IRQ_TYPE_LEVEL_LOW:
> >+              if (!(readl(priv->regs + reg_off) & reg_mask))
> >+                      writel(d->hwirq, priv->regs + APLIC_SETIPNUM_LE);
> >+              break;
> >+      case IRQ_TYPE_LEVEL_HIGH:
> >+              if (readl(priv->regs + reg_off) & reg_mask)
> >+                      writel(d->hwirq, priv->regs + APLIC_SETIPNUM_LE);
> >+              break;
> >+      }
> >+}
> >+
> >+static struct irq_chip aplic_msi_chip =3D {
> >+      .name           =3D "APLIC-MSI",
> >+      .irq_mask       =3D aplic_msi_irq_mask,
> >+      .irq_unmask     =3D aplic_msi_irq_unmask,
> >+      .irq_set_type   =3D aplic_irq_set_type,
> >+      .irq_eoi        =3D aplic_msi_irq_eoi,
> >+#ifdef CONFIG_SMP
> >+      .irq_set_affinity =3D irq_chip_set_affinity_parent,
> >+#endif
> >+      .flags          =3D IRQCHIP_SET_TYPE_MASKED |
> >+                        IRQCHIP_SKIP_SET_WAKE |
> >+                        IRQCHIP_MASK_ON_SUSPEND,
> >+};
> >+
> >+static int aplic_msi_irqdomain_translate(struct irq_domain *d,
> >+                                       struct irq_fwspec *fwspec,
> >+                                       unsigned long *hwirq,
> >+                                       unsigned int *type)
> >+{
> >+      struct aplic_priv *priv =3D platform_msi_get_host_data(d);
> >+
> >+      return aplic_irqdomain_translate(fwspec, priv->gsi_base, hwirq, t=
ype);
> >+}
> >+
> >+static int aplic_msi_irqdomain_alloc(struct irq_domain *domain,
> >+                                   unsigned int virq, unsigned int nr_i=
rqs,
> >+                                   void *arg)
> >+{
> >+      int i, ret;
> >+      unsigned int type;
> >+      irq_hw_number_t hwirq;
> >+      struct irq_fwspec *fwspec =3D arg;
> >+      struct aplic_priv *priv =3D platform_msi_get_host_data(domain);
> >+
> >+      ret =3D aplic_irqdomain_translate(fwspec, priv->gsi_base, &hwirq,=
 &type);
> >+      if (ret)
> >+              return ret;
>
> In your patchset, the wired IRQ and IRQ of platform device will go into A=
PLIC-MSI domain firstly.

Yes, that is correct. In general, this applies to AIA specification
and nothing to do with this patchset.

> Let me assume here is a MSI IRQ not wired IRQ on a device, and it is a pl=
atform device in system.
> so in aplic_irqdomain_translate() function, it will parse the APLIC physi=
cal IRQ number by fwspec->param[0],
> but this is not a wried IRQ, it is a MSI IRQ, it should not has a APLIC p=
hysical IRQ number, the hwirq number should be allocated by MSI bitmap,
> what value will be parse by DTS? zero or negative?

For platform devices with MSI support, the MSIs will directly target
the per-HART
IMSICs and the DT node of such devices will never point to APLIC as the par=
ent
MSI controller.

The IMSIC driver implements the IMSIC-PLAT domain for platform MSIs.

>
> if this is a nonexistent physical IRQ number for APLIC, in aplic_msi_irq_=
unmask()->aplic_irq_unmask(), how it works?
>
> writel(d->hwirq, priv->regs + APLIC_SETIENUM);
>
>

The platform wired IRQs and platform MSIs are not handled/described
in the same way. The APLIC has NO ROLE in platform MSI handling.

Regards,
Anup
