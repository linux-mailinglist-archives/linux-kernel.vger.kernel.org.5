Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CB07DF29A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347360AbjKBMiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376475AbjKBMiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:38:10 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F9B18C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:37:55 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c9c5a1b87bso6608725ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 05:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698928674; x=1699533474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfPxIgreVDqH2Df1YTETSVmZTZ0LielyBMnau7R3iXk=;
        b=f2t68CF7fEqh+Ce+uJbHzJ7O3a465O4MPQ3dGO06JeKwVVM0K4JvLN1xDpgWNRYNXl
         cvuctWg6AJ7dULy47b2Ss7T3MBycpGGYPvHRaXf5tPkJI3Dh2kGHglU1X18kb7ezx619
         ytATKc7yxZGRoCu0QH2PNqZQSbQOKrQdxoaWZ2VwuBlqmKniCT0wB5pO3gDkptuBac/4
         mQAzgXw3koOI14INYdPVXDIxfth/7f8D9ejcNcg8dq+6Bt55mEsdm4JUBR+pvD9KO9NN
         78Rv+IS1kmHvRIpoU1Y1GP31/Yt8aOrC7bnxHyHDbEYENKj2CLfkEpbxdIDxgRARkLi7
         I39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698928674; x=1699533474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfPxIgreVDqH2Df1YTETSVmZTZ0LielyBMnau7R3iXk=;
        b=ECC+HOdMOF/j3rAkOF6P9AJvEA000MTuqwK1sHyOOio92FaiXNZVh87zAvSILK7jGd
         Bkk1lY0tv1yC4Lkw8bFZvrkk0o/7Xwhwy9Z6JyzgNVGoZNX+DGS24YLK5EHarDn/aTBO
         19+KonI5HlYULja0mQB0pG/IbXAh9C8/Cb/d/MDaWJIFaV7J1UgH6MUyga0NBdzcPpT3
         6s4pEqVAjcsKQ8WxLcGIepBjQlceEy3qOjQzwGtiwvKCqVQuhGzkZ7n93Ij5rGfV0en4
         RoL4WknEdgmlusASPMx4ZPIZpx4W76qRw01cyk2pd00NwkaH4RAykc3UFIFmPmLF9hUc
         yq+A==
X-Gm-Message-State: AOJu0Yxl/mIurvIMoUlgucpEBCDbWD+y5kTOyatfv5n1ufpsYe7hihNE
        IeVLMZiVBPew5YgouL/uSgepR37ge4q3Hj2bgRHXJw==
X-Google-Smtp-Source: AGHT+IEOOk8vNroDDdqOzVa4ThiEtJrXKOyiKFdpAH6Gv2Lqfspjd1l57z6Y33ABuhW54cTJ+uxIG4vJ0iTa+p6LdoM=
X-Received: by 2002:a17:90a:1a50:b0:27d:3296:b3e with SMTP id
 16-20020a17090a1a5000b0027d32960b3emr14868634pjl.41.1698928674223; Thu, 02
 Nov 2023 05:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-13-apatel@ventanamicro.com> <210e2757.3169.18b8eb4495c.Coremail.figure1802@126.com>
In-Reply-To: <210e2757.3169.18b8eb4495c.Coremail.figure1802@126.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 2 Nov 2023 18:07:42 +0530
Message-ID: <CAK9=C2UsExEDz76dr=gF2nxyF_3p5OtWxC7L8vZuK5s1nbiSoQ@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 11:55=E2=80=AFAM Ben <figure1802@126.com> wrote:
>
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
> > depends on RISCV
> > select IRQ_DOMAIN_HIERARCHY
> >
> >+config RISCV_APLIC_MSI
> >+ bool
> >+ depends on RISCV_APLIC
> >+ select GENERIC_MSI_IRQ
> >+ default RISCV_APLIC
> >+
> > config RISCV_IMSIC
> > bool
> > depends on RISCV
> >diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> >index 7f8289790ed8..47995fdb2c60 100644
> >--- a/drivers/irqchip/Makefile
> >+++ b/drivers/irqchip/Makefile
> >@@ -96,6 +96,7 @@ obj-$(CONFIG_CSKY_MPINTC) +=3D irq-csky-mpintc.o
> > obj-$(CONFIG_CSKY_APB_INTC) +=3D irq-csky-apb-intc.o
> > obj-$(CONFIG_RISCV_INTC) +=3D irq-riscv-intc.o
> > obj-$(CONFIG_RISCV_APLIC) +=3D irq-riscv-aplic-main.o irq-riscv-aplic-d=
irect.o
> >+obj-$(CONFIG_RISCV_APLIC_MSI) +=3D irq-riscv-aplic-msi.o
> > obj-$(CONFIG_RISCV_IMSIC) +=3D irq-riscv-imsic-state.o irq-riscv-imsic-=
early.o irq-riscv-imsic-platform.o
> > obj-$(CONFIG_SIFIVE_PLIC) +=3D irq-sifive-plic.o
> > obj-$(CONFIG_IMX_IRQSTEER) +=3D irq-imx-irqsteer.o
> >diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/ir=
q-riscv-aplic-main.c
> >index 87450708a733..d1b342b66551 100644
> >--- a/drivers/irqchip/irq-riscv-aplic-main.c
> >+++ b/drivers/irqchip/irq-riscv-aplic-main.c
> >@@ -205,7 +205,7 @@ static int aplic_probe(struct platform_device *pdev)
> > msi_mode =3D of_property_present(to_of_node(dev->fwnode),
> > "msi-parent");
> > if (msi_mode)
> >- rc =3D -ENODEV;
> >+ rc =3D aplic_msi_setup(dev, regs);
> > else
> > rc =3D aplic_direct_setup(dev, regs);
> > if (rc) {
> >diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip/ir=
q-riscv-aplic-main.h
> >index 474a04229334..78267ec58098 100644
> >--- a/drivers/irqchip/irq-riscv-aplic-main.h
> >+++ b/drivers/irqchip/irq-riscv-aplic-main.h
> >@@ -41,5 +41,13 @@ void aplic_init_hw_global(struct aplic_priv *priv, bo=
ol msi_mode);
> > int aplic_setup_priv(struct aplic_priv *priv, struct device *dev,
> >     void __iomem *regs);
> > int aplic_direct_setup(struct device *dev, void __iomem *regs);
> >+#ifdef CONFIG_RISCV_APLIC_MSI
> >+int aplic_msi_setup(struct device *dev, void __iomem *regs);
> >+#else
> >+static inline int aplic_msi_setup(struct device *dev, void __iomem *reg=
s)
> >+{
> >+ return -ENODEV;
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
> >+ aplic_irq_unmask(d);
> >+ irq_chip_unmask_parent(d);
> >+}
> >+
> >+static void aplic_msi_irq_mask(struct irq_data *d)
> >+{
> >+ aplic_irq_mask(d);
> >+ irq_chip_mask_parent(d);
> >+}
> >+
> >+static void aplic_msi_irq_eoi(struct irq_data *d)
> >+{
> >+ struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> >+ u32 reg_off, reg_mask;
> >+
> >+ /*
> >+ * EOI handling only required only for level-triggered
> >+ * interrupts in APLIC MSI mode.
> >+ */
> >+
> >+ reg_off =3D APLIC_CLRIP_BASE + ((d->hwirq / APLIC_IRQBITS_PER_REG) * 4=
);
> >+ reg_mask =3D BIT(d->hwirq % APLIC_IRQBITS_PER_REG);
> >+ switch (irqd_get_trigger_type(d)) {
> >+ case IRQ_TYPE_LEVEL_LOW:
> >+ if (!(readl(priv->regs + reg_off) & reg_mask))
> >+ writel(d->hwirq, priv->regs + APLIC_SETIPNUM_LE);
> >+ break;
> >+ case IRQ_TYPE_LEVEL_HIGH:
> >+ if (readl(priv->regs + reg_off) & reg_mask)
> >+ writel(d->hwirq, priv->regs + APLIC_SETIPNUM_LE);
> >+ break;
> >+ }
> >+}
> >+
> >+static struct irq_chip aplic_msi_chip =3D {
> >+ .name =3D "APLIC-MSI",
> >+ .irq_mask =3D aplic_msi_irq_mask,
> >+ .irq_unmask =3D aplic_msi_irq_unmask,
> >+ .irq_set_type =3D aplic_irq_set_type,
> >+ .irq_eoi =3D aplic_msi_irq_eoi,
> >+#ifdef CONFIG_SMP
> >+ .irq_set_affinity =3D irq_chip_set_affinity_parent,
> >+#endif
> >+ .flags =3D IRQCHIP_SET_TYPE_MASKED |
> >+  IRQCHIP_SKIP_SET_WAKE |
> >+  IRQCHIP_MASK_ON_SUSPEND,
> >+};
> >+
> >+static int aplic_msi_irqdomain_translate(struct irq_domain *d,
> >+ struct irq_fwspec *fwspec,
> >+ unsigned long *hwirq,
> >+ unsigned int *type)
> >+{
> >+ struct aplic_priv *priv =3D platform_msi_get_host_data(d);
> >+
> >+ return aplic_irqdomain_translate(fwspec, priv->gsi_base, hwirq, type);
> >+}
> >+
> >+static int aplic_msi_irqdomain_alloc(struct irq_domain *domain,
> >+     unsigned int virq, unsigned int nr_irqs,
> >+     void *arg)
> >+{
> >+ int i, ret;
> >+ unsigned int type;
> >+ irq_hw_number_t hwirq;
> >+ struct irq_fwspec *fwspec =3D arg;
> >+ struct aplic_priv *priv =3D platform_msi_get_host_data(domain);
> >+
> >+ ret =3D aplic_irqdomain_translate(fwspec, priv->gsi_base, &hwirq, &typ=
e);
> >+ if (ret)
> >+ return ret;
> >+
> >+ ret =3D platform_msi_device_domain_alloc(domain, virq, nr_irqs);
> >+ if (ret)
> >+ return ret;
> >+
> >+ for (i =3D 0; i < nr_irqs; i++) {
> >+ irq_domain_set_info(domain, virq + i, hwirq + i,
> >+    &aplic_msi_chip, priv, handle_fasteoi_irq,
> >+    NULL, NULL);
> >+ /*
> >+ * APLIC does not implement irq_disable() so Linux interrupt
> >+ * subsystem will take a lazy approach for disabling an APLIC
> >+ * interrupt. This means APLIC interrupts are left unmasked
> >+ * upon system suspend and interrupts are not processed
> >+ * immediately upon system wake up. To tackle this, we disable
> >+ * the lazy approach for all APLIC interrupts.
> >+ */
> >+ irq_set_status_flags(virq + i, IRQ_DISABLE_UNLAZY);
> >+ }
>
> For platfrom MSI irq, it will call irq_domain_set_info() and irq_set_stat=
us_flags() twice, the first one is here:
> platform_msi_device_domain_alloc->msi_domain_populate_irqs->irq_domain_al=
loc_irqs_hierarchy->imsic_irq_domain_alloc->irq_domain_set_info
>
> so  i think here this for(...) is not necessary, can be removed.

If we remove then it breaks APLIC MSI-mode because we have
hierarchical irq domains where the APLIC-MSI domain is a child
of the IMSIC-PLAT domain.

The irq_domain_set_info() called by IMSIC driver only sets irqchip
for IMSIC irq whereas irq_domain_set_info() called by APLIC driver
sets irqchip for APLIC irq. We use a different APLIC irqchip for the
APLIC domain to mask, unmask, and eoi irqs in an APLIC specific
way.

Regards,
Anup


>
>
> >+
> >+ return 0;
> >+}
> >+
> >+static const struct irq_domain_ops aplic_msi_irqdomain_ops =3D {
> >+ .translate =3D aplic_msi_irqdomain_translate,
> >+ .alloc =3D aplic_msi_irqdomain_alloc,
> >+ .free =3D platform_msi_device_domain_free,
> >+};
> >+
> >+static void aplic_msi_write_msg(struct msi_desc *desc, struct msi_msg *=
msg)
> >+{
> >+ unsigned int group_index, hart_index, guest_index, val;
> >+ struct irq_data *d =3D irq_get_irq_data(desc->irq);
> >+ struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> >+ struct aplic_msicfg *mc =3D &priv->msicfg;
> >+ phys_addr_t tppn, tbppn, msg_addr;
> >+ void __iomem *target;
> >+
> >+ /* For zeroed MSI, simply write zero into the target register */
> >+ if (!msg->address_hi && !msg->address_lo && !msg->data) {
> >+ target =3D priv->regs + APLIC_TARGET_BASE;
> >+ target +=3D (d->hwirq - 1) * sizeof(u32);
> >+ writel(0, target);
> >+ return;
> >+ }
> >+
> >+ /* Sanity check on message data */
> >+ WARN_ON(msg->data > APLIC_TARGET_EIID_MASK);
> >+
> >+ /* Compute target MSI address */
> >+ msg_addr =3D (((u64)msg->address_hi) << 32) | msg->address_lo;
> >+ tppn =3D msg_addr >> APLIC_xMSICFGADDR_PPN_SHIFT;
> >+
> >+ /* Compute target HART Base PPN */
> >+ tbppn =3D tppn;
> >+ tbppn &=3D ~APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
> >+ tbppn &=3D ~APLIC_xMSICFGADDR_PPN_LHX(mc->lhxw, mc->lhxs);
> >+ tbppn &=3D ~APLIC_xMSICFGADDR_PPN_HHX(mc->hhxw, mc->hhxs);
> >+ WARN_ON(tbppn !=3D mc->base_ppn);
> >+
> >+ /* Compute target group and hart indexes */
> >+ group_index =3D (tppn >> APLIC_xMSICFGADDR_PPN_HHX_SHIFT(mc->hhxs)) &
> >+     APLIC_xMSICFGADDR_PPN_HHX_MASK(mc->hhxw);
> >+ hart_index =3D (tppn >> APLIC_xMSICFGADDR_PPN_LHX_SHIFT(mc->lhxs)) &
> >+     APLIC_xMSICFGADDR_PPN_LHX_MASK(mc->lhxw);
> >+ hart_index |=3D (group_index << mc->lhxw);
> >+ WARN_ON(hart_index > APLIC_TARGET_HART_IDX_MASK);
> >+
> >+ /* Compute target guest index */
> >+ guest_index =3D tppn & APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
> >+ WARN_ON(guest_index > APLIC_TARGET_GUEST_IDX_MASK);
> >+
> >+ /* Update IRQ TARGET register */
> >+ target =3D priv->regs + APLIC_TARGET_BASE;
> >+ target +=3D (d->hwirq - 1) * sizeof(u32);
> >+ val =3D (hart_index & APLIC_TARGET_HART_IDX_MASK)
> >+ << APLIC_TARGET_HART_IDX_SHIFT;
> >+ val |=3D (guest_index & APLIC_TARGET_GUEST_IDX_MASK)
> >+ << APLIC_TARGET_GUEST_IDX_SHIFT;
> >+ val |=3D (msg->data & APLIC_TARGET_EIID_MASK);
> >+ writel(val, target);
> >+}
> >+
> >+int aplic_msi_setup(struct device *dev, void __iomem *regs)
> >+{
> >+ const struct imsic_global_config *imsic_global;
> >+ struct irq_domain *irqdomain;
> >+ struct aplic_priv *priv;
> >+ struct aplic_msicfg *mc;
> >+ phys_addr_t pa;
> >+ int rc;
> >+
> >+ priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >+ if (!priv)
> >+ return -ENOMEM;
> >+
> >+ rc =3D aplic_setup_priv(priv, dev, regs);
> >+ if (!priv) {
> >+ dev_err(dev, "failed to create APLIC context\n");
> >+ return rc;
> >+ }
> >+ mc =3D &priv->msicfg;
> >+
> >+ /*
> >+ * The APLIC outgoing MSI config registers assume target MSI
> >+ * controller to be RISC-V AIA IMSIC controller.
> >+ */
> >+ imsic_global =3D imsic_get_global_config();
> >+ if (!imsic_global) {
> >+ dev_err(dev, "IMSIC global config not found\n");
> >+ return -ENODEV;
> >+ }
> >+
> >+ /* Find number of guest index bits (LHXS) */
> >+ mc->lhxs =3D imsic_global->guest_index_bits;
> >+ if (APLIC_xMSICFGADDRH_LHXS_MASK < mc->lhxs) {
> >+ dev_err(dev, "IMSIC guest index bits big for APLIC LHXS\n");
> >+ return -EINVAL;
> >+ }
> >+
> >+ /* Find number of HART index bits (LHXW) */
> >+ mc->lhxw =3D imsic_global->hart_index_bits;
> >+ if (APLIC_xMSICFGADDRH_LHXW_MASK < mc->lhxw) {
> >+ dev_err(dev, "IMSIC hart index bits big for APLIC LHXW\n");
> >+ return -EINVAL;
> >+ }
> >+
> >+ /* Find number of group index bits (HHXW) */
> >+ mc->hhxw =3D imsic_global->group_index_bits;
> >+ if (APLIC_xMSICFGADDRH_HHXW_MASK < mc->hhxw) {
> >+ dev_err(dev, "IMSIC group index bits big for APLIC HHXW\n");
> >+ return -EINVAL;
> >+ }
> >+
> >+ /* Find first bit position of group index (HHXS) */
> >+ mc->hhxs =3D imsic_global->group_index_shift;
> >+ if (mc->hhxs < (2 * APLIC_xMSICFGADDR_PPN_SHIFT)) {
> >+ dev_err(dev, "IMSIC group index shift should be >=3D %d\n",
> >+ (2 * APLIC_xMSICFGADDR_PPN_SHIFT));
> >+ return -EINVAL;
> >+ }
> >+ mc->hhxs -=3D (2 * APLIC_xMSICFGADDR_PPN_SHIFT);
> >+ if (APLIC_xMSICFGADDRH_HHXS_MASK < mc->hhxs) {
> >+ dev_err(dev, "IMSIC group index shift big for APLIC HHXS\n");
> >+ return -EINVAL;
> >+ }
> >+
> >+ /* Compute PPN base */
> >+ mc->base_ppn =3D imsic_global->base_addr >> APLIC_xMSICFGADDR_PPN_SHIF=
T;
> >+ mc->base_ppn &=3D ~APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
> >+ mc->base_ppn &=3D ~APLIC_xMSICFGADDR_PPN_LHX(mc->lhxw, mc->lhxs);
> >+ mc->base_ppn &=3D ~APLIC_xMSICFGADDR_PPN_HHX(mc->hhxw, mc->hhxs);
> >+
> >+ /* Setup global config and interrupt delivery */
> >+ aplic_init_hw_global(priv, true);
> >+
> >+ /* Set the APLIC device MSI domain if not available */
> >+ if (!dev_get_msi_domain(dev)) {
> >+ /*
> >+ * The device MSI domain for OF devices is only set at the
> >+ * time of populating/creating OF device. If the device MSI
> >+ * domain is discovered later after the OF device is created
> >+ * then we need to set it explicitly before using any platform
> >+ * MSI functions.
> >+ *
> >+ * In case of APLIC device, the parent MSI domain is always
> >+ * IMSIC and the IMSIC MSI domains are created later through
> >+ * the platform driver probing so we set it explicitly here.
> >+ */
> >+ if (is_of_node(dev->fwnode))
> >+ of_msi_configure(dev, to_of_node(dev->fwnode));
> >+ }
> >+
> >+ /* Create irq domain instance for the APLIC MSI-mode */
> >+ irqdomain =3D platform_msi_create_device_domain(
> >+ dev, priv->nr_irqs + 1,
> >+ aplic_msi_write_msg,
> >+ &aplic_msi_irqdomain_ops,
> >+ priv);
> >+ if (!irqdomain) {
> >+ dev_err(dev, "failed to create MSI irq domain\n");
> >+ return -ENOMEM;
> >+ }
> >+
> >+ /* Advertise the interrupt controller */
> >+ pa =3D priv->msicfg.base_ppn << APLIC_xMSICFGADDR_PPN_SHIFT;
> >+ dev_info(dev, "%d interrupts forwared to MSI base %pa\n",
> >+ priv->nr_irqs, &pa);
> >+
> >+ return 0;
> >+}
> >--
> >2.34.1
> >
> >
> >_______________________________________________
> >linux-riscv mailing list
> >linux-riscv@lists.infradead.org
> >http://lists.infradead.org/mailman/listinfo/linux-riscv
