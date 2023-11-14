Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7B87EACED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjKNJWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjKNJWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:22:03 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B23133
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 01:21:59 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-280109daaaaso4069355a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 01:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1699953719; x=1700558519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nK6k+bkVGaZaisByngPdLkJB/ZDdw96sS7MFrtgdMiA=;
        b=FDuAaiQTRS8DbkbPizuRsJc09akTmQyJYRZE7RkoxVZ3pHKbsBK+JFyMgkCpK2tydq
         k5ESLiLLoPkhA6tooQRWhA9T/2rEwLsmHpqxE56M17oSCaaKOlmovz31xdGCBOavWe5u
         kkE8mvGFVu96MiTpoNG0AeA7jKZh98GQCKV5VsldYZX/E1+L+4OD30L371YnEEAyvvuo
         jbVTKF2wFuL7QntI9/8VklvFt0m/9Qi4d7CsjJJ9rPbC2U8h/jtz+S7Ig1f4C3l4FvQB
         nQcVgDTtl/AfaQkjEGnsdHjzkpvk2z0T1vzAj+q0QTm+mLysZnCoMhPJ3vBDV7YFxs85
         6nCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699953719; x=1700558519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nK6k+bkVGaZaisByngPdLkJB/ZDdw96sS7MFrtgdMiA=;
        b=ZHOwDCAp81cgbLA8AF1tUsTKmSa48U+LStwvlYBkALi//zrqRSp2GZrNzAYdy3sScg
         wjln64nEcXgnIAhujGPnz5xmYn+gaaC6YbMDOmBOUi67fogw7FLDt6LNYbhMZVW+dGof
         Bg5kr+Sv1XeTqZVPjumGVp+dLO8+BjlYzM2/Vb89XCLUmIa2edE3IQOOAhsnfazkVPhD
         lmcZENc/xH7/P2gWImyrX0GQBFh1oXHA/cqetsYKsfcM+BPFe/ZHU1W75hEYhpM04ZFw
         Sz9r0FaoUFJT0QjMG1HfLY5PDrU2HVwens5hAXfAB4X90GzwZQbErklNWzhzcE/5HRKs
         kTjQ==
X-Gm-Message-State: AOJu0Yykx/ezoUQaU3yP4N4PGVYQGicVhAb2u07tY2QKuXWxd4tpxsE3
        v+kVWxzZte7iDyI7fnGhwIjO3/0OKb1ySIU7E3/OcA==
X-Google-Smtp-Source: AGHT+IG/Dr8WjHgtyJcI+Cj5kMUWx5+iKsNO8jYDfT8O7O99IRCAphTedhbmGEiE3PbwhlNlj0oc1rhYGG0kfblVYXQ=
X-Received: by 2002:a17:90b:1bc2:b0:281:5550:ce3d with SMTP id
 oa2-20020a17090b1bc200b002815550ce3dmr7074188pjb.31.1699953719056; Tue, 14
 Nov 2023 01:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-13-apatel@ventanamicro.com> <22d5d9e9.258.18b97d65ce7.Coremail.figure1802@126.com>
 <CAK9=C2WPhROWKGKmLbLyS+q2ncCNTJEHnFKcYqCGJoNK4Uz=LQ@mail.gmail.com>
 <8624cc4.5923.18baf6adca4.Coremail.figure1802@126.com> <CAK9=C2Vr6BmmdNN11rn+-7JjvERiawVKOgPhMjncrUSG8x+W2Q@mail.gmail.com>
 <6c8a531.585f.18baf9073f3.Coremail.figure1802@126.com>
In-Reply-To: <6c8a531.585f.18baf9073f3.Coremail.figure1802@126.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 14 Nov 2023 14:51:46 +0530
Message-ID: <CAAhSdy24FE51qt1bZx-EoYhip0rNWaXzDFNH6mftF7bTm9unYw@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v11 12/14] irqchip/riscv-aplic: Add support for MSI-mode
To:     Ben <figure1802@126.com>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 9:02=E2=80=AFPM Ben <figure1802@126.com> wrote:
>
>
> At 2023-11-08 22:56:59, "Anup Patel" <apatel@ventanamicro.com> wrote:
> >On Wed, Nov 8, 2023 at 8:23=E2=80=AFPM Ben <figure1802@126.com> wrote:
> >>
> >> At 2023-11-08 22:43:25, "Anup Patel" <apatel@ventanamicro.com> wrote:
> >> >On Sat, Nov 4, 2023 at 6:30=E2=80=AFAM Ben <figure1802@126.com> wrote=
:
> >> >>
> >> >> At 2023-10-24 01:27:58, "Anup Patel" <apatel@ventanamicro.com> wrot=
e:
> >> >> >The RISC-V advanced platform-level interrupt controller (APLIC) ha=
s
> >> >> >two modes of operation: 1) Direct mode and 2) MSI mode.
> >> >> >(For more details, refer https://github.com/riscv/riscv-aia)
> >> >> >
> >> >> >In APLIC MSI-mode, wired interrupts are forwared as message signal=
ed
> >> >> >interrupts (MSIs) to CPUs via IMSIC.
> >> >> >
> >> >> >We extend the existing APLIC irqchip driver to support MSI-mode fo=
r
> >> >> >RISC-V platforms having both wired interrupts and MSIs.
> >> >> >
> >> >> >Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >> >> >---
> >> >> > drivers/irqchip/Kconfig                |   6 +
> >> >> > drivers/irqchip/Makefile               |   1 +
> >> >> > drivers/irqchip/irq-riscv-aplic-main.c |   2 +-
> >> >> > drivers/irqchip/irq-riscv-aplic-main.h |   8 +
> >> >> > drivers/irqchip/irq-riscv-aplic-msi.c  | 285 ++++++++++++++++++++=
+++++
> >> >> > 5 files changed, 301 insertions(+), 1 deletion(-)
> >> >> > create mode 100644 drivers/irqchip/irq-riscv-aplic-msi.c
> >> >> >
> >> >> >diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> >> >> >index 1996cc6f666a..7adc4dbe07ff 100644
> >> >> >--- a/drivers/irqchip/Kconfig
> >> >> >+++ b/drivers/irqchip/Kconfig
> >> >> >@@ -551,6 +551,12 @@ config RISCV_APLIC
> >> >> >       depends on RISCV
> >> >> >       select IRQ_DOMAIN_HIERARCHY
> >> >> >
> >> >> >+config RISCV_APLIC_MSI
> >> >> >+      bool
> >> >> >+      depends on RISCV_APLIC
> >> >> >+      select GENERIC_MSI_IRQ
> >> >> >+      default RISCV_APLIC
> >> >> >+
> >> >> > config RISCV_IMSIC
> >> >> >       bool
> >> >> >       depends on RISCV
> >> >> >diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> >> >> >index 7f8289790ed8..47995fdb2c60 100644
> >> >> >--- a/drivers/irqchip/Makefile
> >> >> >+++ b/drivers/irqchip/Makefile
> >> >> >@@ -96,6 +96,7 @@ obj-$(CONFIG_CSKY_MPINTC)            +=3D irq-cs=
ky-mpintc.o
> >> >> > obj-$(CONFIG_CSKY_APB_INTC)           +=3D irq-csky-apb-intc.o
> >> >> > obj-$(CONFIG_RISCV_INTC)              +=3D irq-riscv-intc.o
> >> >> > obj-$(CONFIG_RISCV_APLIC)             +=3D irq-riscv-aplic-main.o=
 irq-riscv-aplic-direct.o
> >> >> >+obj-$(CONFIG_RISCV_APLIC_MSI)         +=3D irq-riscv-aplic-msi.o
> >> >> > obj-$(CONFIG_RISCV_IMSIC)             +=3D irq-riscv-imsic-state.=
o irq-riscv-imsic-early.o irq-riscv-imsic-platform.o
> >> >> > obj-$(CONFIG_SIFIVE_PLIC)             +=3D irq-sifive-plic.o
> >> >> > obj-$(CONFIG_IMX_IRQSTEER)            +=3D irq-imx-irqsteer.o
> >> >> >diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqc=
hip/irq-riscv-aplic-main.c
> >> >> >index 87450708a733..d1b342b66551 100644
> >> >> >--- a/drivers/irqchip/irq-riscv-aplic-main.c
> >> >> >+++ b/drivers/irqchip/irq-riscv-aplic-main.c
> >> >> >@@ -205,7 +205,7 @@ static int aplic_probe(struct platform_device =
*pdev)
> >> >> >               msi_mode =3D of_property_present(to_of_node(dev->fw=
node),
> >> >> >                                               "msi-parent");
> >> >> >       if (msi_mode)
> >> >> >-              rc =3D -ENODEV;
> >> >> >+              rc =3D aplic_msi_setup(dev, regs);
> >> >> >       else
> >> >> >               rc =3D aplic_direct_setup(dev, regs);
> >> >> >       if (rc) {
> >> >> >diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqc=
hip/irq-riscv-aplic-main.h
> >> >> >index 474a04229334..78267ec58098 100644
> >> >> >--- a/drivers/irqchip/irq-riscv-aplic-main.h
> >> >> >+++ b/drivers/irqchip/irq-riscv-aplic-main.h
> >> >> >@@ -41,5 +41,13 @@ void aplic_init_hw_global(struct aplic_priv *pr=
iv, bool msi_mode);
> >> >> > int aplic_setup_priv(struct aplic_priv *priv, struct device *dev,
> >> >> >                    void __iomem *regs);
> >> >> > int aplic_direct_setup(struct device *dev, void __iomem *regs);
> >> >> >+#ifdef CONFIG_RISCV_APLIC_MSI
> >> >> >+int aplic_msi_setup(struct device *dev, void __iomem *regs);
> >> >> >+#else
> >> >> >+static inline int aplic_msi_setup(struct device *dev, void __iome=
m *regs)
> >> >> >+{
> >> >> >+      return -ENODEV;
> >> >> >+}
> >> >> >+#endif
> >> >> >
> >> >> > #endif
> >> >> >diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqch=
ip/irq-riscv-aplic-msi.c
> >> >> >new file mode 100644
> >> >> >index 000000000000..086d00e0429e
> >> >> >--- /dev/null
> >> >> >+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
> >> >> >@@ -0,0 +1,285 @@
> >> >> >+// SPDX-License-Identifier: GPL-2.0
> >> >> >+/*
> >> >> >+ * Copyright (C) 2021 Western Digital Corporation or its affiliat=
es.
> >> >> >+ * Copyright (C) 2022 Ventana Micro Systems Inc.
> >> >> >+ */
> >> >> >+
> >> >> >+#include <linux/bitops.h>
> >> >> >+#include <linux/cpu.h>
> >> >> >+#include <linux/interrupt.h>
> >> >> >+#include <linux/irqchip.h>
> >> >> >+#include <linux/irqchip/riscv-aplic.h>
> >> >> >+#include <linux/irqchip/riscv-imsic.h>
> >> >> >+#include <linux/module.h>
> >> >> >+#include <linux/msi.h>
> >> >> >+#include <linux/of_irq.h>
> >> >> >+#include <linux/platform_device.h>
> >> >> >+#include <linux/printk.h>
> >> >> >+#include <linux/smp.h>
> >> >> >+
> >> >> >+#include "irq-riscv-aplic-main.h"
> >> >> >+
> >> >> >+static void aplic_msi_irq_unmask(struct irq_data *d)
> >> >> >+{
> >> >> >+      aplic_irq_unmask(d);
> >> >> >+      irq_chip_unmask_parent(d);
> >> >> >+}
> >> >> >+
> >> >> >+static void aplic_msi_irq_mask(struct irq_data *d)
> >> >> >+{
> >> >> >+      aplic_irq_mask(d);
> >> >> >+      irq_chip_mask_parent(d);
> >> >> >+}
> >> >> >+
> >> >> >+static void aplic_msi_irq_eoi(struct irq_data *d)
> >> >> >+{
> >> >> >+      struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> >> >> >+      u32 reg_off, reg_mask;
> >> >> >+
> >> >> >+      /*
> >> >> >+       * EOI handling only required only for level-triggered
> >> >> >+       * interrupts in APLIC MSI mode.
> >> >> >+       */
> >> >> >+
> >> >> >+      reg_off =3D APLIC_CLRIP_BASE + ((d->hwirq / APLIC_IRQBITS_P=
ER_REG) * 4);
> >> >> >+      reg_mask =3D BIT(d->hwirq % APLIC_IRQBITS_PER_REG);
> >> >> >+      switch (irqd_get_trigger_type(d)) {
> >> >> >+      case IRQ_TYPE_LEVEL_LOW:
> >> >> >+              if (!(readl(priv->regs + reg_off) & reg_mask))
> >> >> >+                      writel(d->hwirq, priv->regs + APLIC_SETIPNU=
M_LE);
> >> >> >+              break;
> >> >> >+      case IRQ_TYPE_LEVEL_HIGH:
> >> >> >+              if (readl(priv->regs + reg_off) & reg_mask)
> >> >> >+                      writel(d->hwirq, priv->regs + APLIC_SETIPNU=
M_LE);
> >> >> >+              break;
> >> >> >+      }
> >> >> >+}
> >> >> >+
> >> >> >+static struct irq_chip aplic_msi_chip =3D {
> >> >> >+      .name           =3D "APLIC-MSI",
> >> >> >+      .irq_mask       =3D aplic_msi_irq_mask,
> >> >> >+      .irq_unmask     =3D aplic_msi_irq_unmask,
> >> >> >+      .irq_set_type   =3D aplic_irq_set_type,
> >> >> >+      .irq_eoi        =3D aplic_msi_irq_eoi,
> >> >> >+#ifdef CONFIG_SMP
> >> >> >+      .irq_set_affinity =3D irq_chip_set_affinity_parent,
> >> >> >+#endif
> >> >> >+      .flags          =3D IRQCHIP_SET_TYPE_MASKED |
> >> >> >+                        IRQCHIP_SKIP_SET_WAKE |
> >> >> >+                        IRQCHIP_MASK_ON_SUSPEND,
> >> >> >+};
> >> >> >+
> >> >> >+static int aplic_msi_irqdomain_translate(struct irq_domain *d,
> >> >> >+                                       struct irq_fwspec *fwspec,
> >> >> >+                                       unsigned long *hwirq,
> >> >> >+                                       unsigned int *type)
> >> >> >+{
> >> >> >+      struct aplic_priv *priv =3D platform_msi_get_host_data(d);
> >> >> >+
> >> >> >+      return aplic_irqdomain_translate(fwspec, priv->gsi_base, hw=
irq, type);
> >> >> >+}
> >> >> >+
> >> >> >+static int aplic_msi_irqdomain_alloc(struct irq_domain *domain,
> >> >> >+                                   unsigned int virq, unsigned in=
t nr_irqs,
> >> >> >+                                   void *arg)
> >> >> >+{
> >> >> >+      int i, ret;
> >> >> >+      unsigned int type;
> >> >> >+      irq_hw_number_t hwirq;
> >> >> >+      struct irq_fwspec *fwspec =3D arg;
> >> >> >+      struct aplic_priv *priv =3D platform_msi_get_host_data(doma=
in);
> >> >> >+
> >> >> >+      ret =3D aplic_irqdomain_translate(fwspec, priv->gsi_base, &=
hwirq, &type);
> >> >> >+      if (ret)
> >> >> >+              return ret;
> >> >>
> >> >> In your patchset, the wired IRQ and IRQ of platform device will go =
into APLIC-MSI domain firstly.
> >> >
> >> >Yes, that is correct. In general, this applies to AIA specification
> >> >and nothing to do with this patchset.
> >> >
> >> >> Let me assume here is a MSI IRQ not wired IRQ on a device, and it i=
s a platform device in system.
> >> >> so in aplic_irqdomain_translate() function, it will parse the APLIC=
 physical IRQ number by fwspec->param[0],
> >> >> but this is not a wried IRQ, it is a MSI IRQ, it should not has a A=
PLIC physical IRQ number, the hwirq number should be allocated by MSI bitma=
p,
> >> >> what value will be parse by DTS? zero or negative?
> >> >
> >> >For platform devices with MSI support, the MSIs will directly target
> >> >the per-HART
> >> >IMSICs and the DT node of such devices will never point to APLIC as t=
he parent
> >> >MSI controller.
> >> >
> >>
> >> >The IMSIC driver implements the IMSIC-PLAT domain for platform MSIs.
> >>
> >> Have you test this case on QEMU? would you like share the test steps?
> >
> >The APLIC in MSI-mode acts like a platform device with MSIs so yes this
> >is tested on QEMU.
>
> yet, I know the wired interrupt with MSI-mode of APLIC has tested on QEMU=
 by virtio devices, but i want to know how about the MSI interrupt with non=
-PCI device?
> have you tested this case?

I don't see any difference in the way APLIC MSI-mode platform
device use MSI versus any other platform using MSI.

We also have the RISC-V IOMMU platform device which uses
MSIs provided by the IMSIC-PLAT domain.

Regards,
Anup
