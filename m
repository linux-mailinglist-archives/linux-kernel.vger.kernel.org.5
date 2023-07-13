Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8688752E16
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 01:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjGMX5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 19:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjGMX5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:57:02 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C101BC9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:56:59 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4036bd4fff1so145811cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689292619; x=1691884619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJuISt5yWc721bMmpn/M53x3y2Mp0cO5RlrrVIw26tM=;
        b=fIdt6fR/4Kua1BM3G9I2DtXJeJLXT70optH3Nb1ziH5Os++stTEgOpTVz/oobB0PaL
         F1sdUyo0fR91RLJas/6cAgpuvJZSdSqtVr0nlBXJwqrrs86v9aNeEIIr2ZpXbuTU9SWC
         T3primcJVG5RaKvVjPDmoUEcfqxNFXaQvofC7NYFeVv/olu9CmmFFJtPrvm/jkG7e5qx
         kcKaHqVZuingu5TSgMLDy6cOFJOg4+dHR6C3LtdJlbUFPaF5SRJXli2e2WPR3hXOMxxO
         91XG1i0rd9faXjnl0l9UQFHBfw48UORmHJEOwr7UVYuF536HZX3/9ju+wlf7TQhplkBA
         B0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689292619; x=1691884619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJuISt5yWc721bMmpn/M53x3y2Mp0cO5RlrrVIw26tM=;
        b=HoMgYJuiZO1dMUuQUr8fonbio0ZKJrd65CDlGWF9Ux02a3E5zPw4BjpNkZs+yp3gBr
         JgwWuQq1poK8U2RTZWNyjHFCqGZ0rtxvc/Bn4Lrm+Ivw6QZlutU5AHIB6EK4c6BQOfQk
         vAajDpftviyetBYRhaAwUm0XbOLhrvJd/5r/RHlpqxGnHBMvh7E72+3JC9ANjflFtY+0
         naPQ0gBmlDsnrbHPBSgv7XguMloF/mi+O6pTi9EyDr32NeSOxcslR68AtWspSabYpf1U
         ZB2FpuhvttPmYrGttWNZc8+YOH8m0ma+BeMvR4BEK/rsCumk9TkHk1zGCvSMj3OuEZbf
         0gjg==
X-Gm-Message-State: ABy/qLaqnCnIao5myAtf7Cs/IFmOiQQcTIU8kjdvrH6tRBkzI5MCRuA2
        EanS6tQ6COhKSn/ttaFOCwdaL0YrZHshUxm9GGVghg==
X-Google-Smtp-Source: APBJJlHm9MkXEJKLIMQqCIuPrGGUEc/BR0icX/MNlansgyNnGAIlAjemCXMSfuXZJkVijLdk6HrLofl77Bia8UhTkVA=
X-Received: by 2002:ac8:7fd6:0:b0:3f9:ab2c:88b9 with SMTP id
 b22-20020ac87fd6000000b003f9ab2c88b9mr658732qtk.25.1689292618618; Thu, 13 Jul
 2023 16:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230710094321.1378351-1-apatel@ventanamicro.com> <20230710094321.1378351-8-apatel@ventanamicro.com>
In-Reply-To: <20230710094321.1378351-8-apatel@ventanamicro.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 13 Jul 2023 16:56:22 -0700
Message-ID: <CAGETcx8kH8cJVdhcv5K4qNUo58godFZEBnOfTGKUUQ6VuUguvQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] irqchip: Add RISC-V advanced PLIC driver
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 2:44=E2=80=AFAM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> The RISC-V advanced interrupt architecture (AIA) specification defines
> a new interrupt controller for managing wired interrupts on a RISC-V
> platform. This new interrupt controller is referred to as advanced
> platform-level interrupt controller (APLIC) which can forward wired
> interrupts to CPUs (or HARTs) as local interrupts OR as message
> signaled interrupts.
> (For more details refer https://github.com/riscv/riscv-aia)
>
> This patch adds an irqchip driver for RISC-V APLIC found on RISC-V
> platforms.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/irqchip/Kconfig             |   6 +
>  drivers/irqchip/Makefile            |   1 +
>  drivers/irqchip/irq-riscv-aplic.c   | 774 ++++++++++++++++++++++++++++
>  include/linux/irqchip/riscv-aplic.h | 119 +++++
>  4 files changed, 900 insertions(+)
>  create mode 100644 drivers/irqchip/irq-riscv-aplic.c
>  create mode 100644 include/linux/irqchip/riscv-aplic.h
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index d700980372ef..834c0329f583 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -544,6 +544,12 @@ config SIFIVE_PLIC
>         select IRQ_DOMAIN_HIERARCHY
>         select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
>
> +config RISCV_APLIC
> +       bool
> +       depends on RISCV
> +       select IRQ_DOMAIN_HIERARCHY
> +       select GENERIC_MSI_IRQ
> +
>  config RISCV_IMSIC
>         bool
>         depends on RISCV
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 577bde3e986b..438b8e1a152c 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -95,6 +95,7 @@ obj-$(CONFIG_QCOM_MPM)                        +=3D irq-=
qcom-mpm.o
>  obj-$(CONFIG_CSKY_MPINTC)              +=3D irq-csky-mpintc.o
>  obj-$(CONFIG_CSKY_APB_INTC)            +=3D irq-csky-apb-intc.o
>  obj-$(CONFIG_RISCV_INTC)               +=3D irq-riscv-intc.o
> +obj-$(CONFIG_RISCV_APLIC)              +=3D irq-riscv-aplic.o
>  obj-$(CONFIG_RISCV_IMSIC)              +=3D irq-riscv-imsic.o
>  obj-$(CONFIG_SIFIVE_PLIC)              +=3D irq-sifive-plic.o
>  obj-$(CONFIG_IMX_IRQSTEER)             +=3D irq-imx-irqsteer.o
> diff --git a/drivers/irqchip/irq-riscv-aplic.c b/drivers/irqchip/irq-risc=
v-aplic.c
> new file mode 100644
> index 000000000000..b4db29d4179b
> --- /dev/null
> +++ b/drivers/irqchip/irq-riscv-aplic.c
> @@ -0,0 +1,774 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> + * Copyright (C) 2022 Ventana Micro Systems Inc.
> + */
> +
> +#define pr_fmt(fmt) "riscv-aplic: " fmt
> +#include <linux/bitops.h>
> +#include <linux/cpu.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqchip/riscv-aplic.h>
> +#include <linux/irqchip/riscv-imsic.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>
> +#include <linux/msi.h>
> +#include <linux/platform_device.h>
> +#include <linux/smp.h>
> +
> +#define APLIC_DEFAULT_PRIORITY         1
> +#define APLIC_DISABLE_IDELIVERY                0
> +#define APLIC_ENABLE_IDELIVERY         1
> +#define APLIC_DISABLE_ITHRESHOLD       1
> +#define APLIC_ENABLE_ITHRESHOLD                0
> +
> +struct aplic_msicfg {
> +       phys_addr_t             base_ppn;
> +       u32                     hhxs;
> +       u32                     hhxw;
> +       u32                     lhxs;
> +       u32                     lhxw;
> +};
> +
> +struct aplic_idc {
> +       unsigned int            hart_index;
> +       void __iomem            *regs;
> +       struct aplic_priv       *priv;
> +};
> +
> +struct aplic_priv {
> +       struct fwnode_handle    *fwnode;
> +       u32                     gsi_base;
> +       u32                     nr_irqs;
> +       u32                     nr_idcs;
> +       void __iomem            *regs;
> +       struct irq_domain       *irqdomain;
> +       struct aplic_msicfg     msicfg;
> +       struct cpumask          lmask;
> +};
> +
> +static unsigned int aplic_idc_parent_irq;
> +static DEFINE_PER_CPU(struct aplic_idc, aplic_idcs);
> +
> +static void aplic_irq_unmask(struct irq_data *d)
> +{
> +       struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> +
> +       writel(d->hwirq, priv->regs + APLIC_SETIENUM);
> +
> +       if (!priv->nr_idcs)
> +               irq_chip_unmask_parent(d);
> +}
> +
> +static void aplic_irq_mask(struct irq_data *d)
> +{
> +       struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> +
> +       writel(d->hwirq, priv->regs + APLIC_CLRIENUM);
> +
> +       if (!priv->nr_idcs)
> +               irq_chip_mask_parent(d);
> +}
> +
> +static int aplic_set_type(struct irq_data *d, unsigned int type)
> +{
> +       u32 val =3D 0;
> +       void __iomem *sourcecfg;
> +       struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> +
> +       switch (type) {
> +       case IRQ_TYPE_NONE:
> +               val =3D APLIC_SOURCECFG_SM_INACTIVE;
> +               break;
> +       case IRQ_TYPE_LEVEL_LOW:
> +               val =3D APLIC_SOURCECFG_SM_LEVEL_LOW;
> +               break;
> +       case IRQ_TYPE_LEVEL_HIGH:
> +               val =3D APLIC_SOURCECFG_SM_LEVEL_HIGH;
> +               break;
> +       case IRQ_TYPE_EDGE_FALLING:
> +               val =3D APLIC_SOURCECFG_SM_EDGE_FALL;
> +               break;
> +       case IRQ_TYPE_EDGE_RISING:
> +               val =3D APLIC_SOURCECFG_SM_EDGE_RISE;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       sourcecfg =3D priv->regs + APLIC_SOURCECFG_BASE;
> +       sourcecfg +=3D (d->hwirq - 1) * sizeof(u32);
> +       writel(val, sourcecfg);
> +
> +       return 0;
> +}
> +
> +static void aplic_irq_eoi(struct irq_data *d)
> +{
> +       struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> +       u32 reg_off, reg_mask;
> +
> +       /*
> +        * EOI handling only required only for level-triggered
> +        * interrupts in APLIC MSI mode.
> +        */
> +
> +       if (priv->nr_idcs)
> +               return;
> +
> +       reg_off =3D APLIC_CLRIP_BASE + ((d->hwirq / APLIC_IRQBITS_PER_REG=
) * 4);
> +       reg_mask =3D BIT(d->hwirq % APLIC_IRQBITS_PER_REG);
> +       switch (irqd_get_trigger_type(d)) {
> +       case IRQ_TYPE_LEVEL_LOW:
> +               if (!(readl(priv->regs + reg_off) & reg_mask))
> +                       writel(d->hwirq, priv->regs + APLIC_SETIPNUM_LE);
> +               break;
> +       case IRQ_TYPE_LEVEL_HIGH:
> +               if (readl(priv->regs + reg_off) & reg_mask)
> +                       writel(d->hwirq, priv->regs + APLIC_SETIPNUM_LE);
> +               break;
> +       }
> +}
> +
> +#ifdef CONFIG_SMP
> +static int aplic_set_affinity(struct irq_data *d,
> +                             const struct cpumask *mask_val, bool force)
> +{
> +       struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> +       struct aplic_idc *idc;
> +       unsigned int cpu, val;
> +       struct cpumask amask;
> +       void __iomem *target;
> +
> +       if (!priv->nr_idcs)
> +               return irq_chip_set_affinity_parent(d, mask_val, force);
> +
> +       cpumask_and(&amask, &priv->lmask, mask_val);
> +
> +       if (force)
> +               cpu =3D cpumask_first(&amask);
> +       else
> +               cpu =3D cpumask_any_and(&amask, cpu_online_mask);
> +
> +       if (cpu >=3D nr_cpu_ids)
> +               return -EINVAL;
> +
> +       idc =3D per_cpu_ptr(&aplic_idcs, cpu);
> +       target =3D priv->regs + APLIC_TARGET_BASE;
> +       target +=3D (d->hwirq - 1) * sizeof(u32);
> +       val =3D idc->hart_index & APLIC_TARGET_HART_IDX_MASK;
> +       val <<=3D APLIC_TARGET_HART_IDX_SHIFT;
> +       val |=3D APLIC_DEFAULT_PRIORITY;
> +       writel(val, target);
> +
> +       irq_data_update_effective_affinity(d, cpumask_of(cpu));
> +
> +       return IRQ_SET_MASK_OK_DONE;
> +}
> +#endif
> +
> +static struct irq_chip aplic_chip =3D {
> +       .name           =3D "RISC-V APLIC",
> +       .irq_mask       =3D aplic_irq_mask,
> +       .irq_unmask     =3D aplic_irq_unmask,
> +       .irq_set_type   =3D aplic_set_type,
> +       .irq_eoi        =3D aplic_irq_eoi,
> +#ifdef CONFIG_SMP
> +       .irq_set_affinity =3D aplic_set_affinity,
> +#endif
> +       .flags          =3D IRQCHIP_SET_TYPE_MASKED |
> +                         IRQCHIP_SKIP_SET_WAKE |
> +                         IRQCHIP_MASK_ON_SUSPEND,
> +};
> +
> +static int aplic_irqdomain_translate(struct irq_fwspec *fwspec,
> +                                    u32 gsi_base,
> +                                    unsigned long *hwirq,
> +                                    unsigned int *type)
> +{
> +       if (WARN_ON(fwspec->param_count < 2))
> +               return -EINVAL;
> +       if (WARN_ON(!fwspec->param[0]))
> +               return -EINVAL;
> +
> +       /* For DT, gsi_base is always zero. */
> +       *hwirq =3D fwspec->param[0] - gsi_base;
> +       *type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
> +
> +       WARN_ON(*type =3D=3D IRQ_TYPE_NONE);
> +
> +       return 0;
> +}
> +
> +static int aplic_irqdomain_msi_translate(struct irq_domain *d,
> +                                        struct irq_fwspec *fwspec,
> +                                        unsigned long *hwirq,
> +                                        unsigned int *type)
> +{
> +       struct aplic_priv *priv =3D platform_msi_get_host_data(d);
> +
> +       return aplic_irqdomain_translate(fwspec, priv->gsi_base, hwirq, t=
ype);
> +}
> +
> +static int aplic_irqdomain_msi_alloc(struct irq_domain *domain,
> +                                    unsigned int virq, unsigned int nr_i=
rqs,
> +                                    void *arg)
> +{
> +       int i, ret;
> +       unsigned int type;
> +       irq_hw_number_t hwirq;
> +       struct irq_fwspec *fwspec =3D arg;
> +       struct aplic_priv *priv =3D platform_msi_get_host_data(domain);
> +
> +       ret =3D aplic_irqdomain_translate(fwspec, priv->gsi_base, &hwirq,=
 &type);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D platform_msi_device_domain_alloc(domain, virq, nr_irqs);
> +       if (ret)
> +               return ret;
> +
> +       for (i =3D 0; i < nr_irqs; i++) {
> +               irq_domain_set_info(domain, virq + i, hwirq + i,
> +                                   &aplic_chip, priv, handle_fasteoi_irq=
,
> +                                   NULL, NULL);
> +               /*
> +                * APLIC does not implement irq_disable() so Linux interr=
upt
> +                * subsystem will take a lazy approach for disabling an A=
PLIC
> +                * interrupt. This means APLIC interrupts are left unmask=
ed
> +                * upon system suspend and interrupts are not processed
> +                * immediately upon system wake up. To tackle this, we di=
sable
> +                * the lazy approach for all APLIC interrupts.
> +                */
> +               irq_set_status_flags(virq + i, IRQ_DISABLE_UNLAZY);
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct irq_domain_ops aplic_irqdomain_msi_ops =3D {
> +       .translate      =3D aplic_irqdomain_msi_translate,
> +       .alloc          =3D aplic_irqdomain_msi_alloc,
> +       .free           =3D platform_msi_device_domain_free,
> +};
> +
> +static int aplic_irqdomain_idc_translate(struct irq_domain *d,
> +                                        struct irq_fwspec *fwspec,
> +                                        unsigned long *hwirq,
> +                                        unsigned int *type)
> +{
> +       struct aplic_priv *priv =3D d->host_data;
> +
> +       return aplic_irqdomain_translate(fwspec, priv->gsi_base, hwirq, t=
ype);
> +}
> +
> +static int aplic_irqdomain_idc_alloc(struct irq_domain *domain,
> +                                    unsigned int virq, unsigned int nr_i=
rqs,
> +                                    void *arg)
> +{
> +       int i, ret;
> +       unsigned int type;
> +       irq_hw_number_t hwirq;
> +       struct irq_fwspec *fwspec =3D arg;
> +       struct aplic_priv *priv =3D domain->host_data;
> +
> +       ret =3D aplic_irqdomain_translate(fwspec, priv->gsi_base, &hwirq,=
 &type);
> +       if (ret)
> +               return ret;
> +
> +       for (i =3D 0; i < nr_irqs; i++) {
> +               irq_domain_set_info(domain, virq + i, hwirq + i,
> +                                   &aplic_chip, priv, handle_fasteoi_irq=
,
> +                                   NULL, NULL);
> +               irq_set_affinity(virq + i, &priv->lmask);
> +               /* See the reason described in aplic_irqdomain_msi_alloc(=
) */
> +               irq_set_status_flags(virq + i, IRQ_DISABLE_UNLAZY);
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct irq_domain_ops aplic_irqdomain_idc_ops =3D {
> +       .translate      =3D aplic_irqdomain_idc_translate,
> +       .alloc          =3D aplic_irqdomain_idc_alloc,
> +       .free           =3D irq_domain_free_irqs_top,
> +};
> +
> +static void aplic_init_hw_irqs(struct aplic_priv *priv)
> +{
> +       int i;
> +
> +       /* Disable all interrupts */
> +       for (i =3D 0; i <=3D priv->nr_irqs; i +=3D 32)
> +               writel(-1U, priv->regs + APLIC_CLRIE_BASE +
> +                           (i / 32) * sizeof(u32));
> +
> +       /* Set interrupt type and default priority for all interrupts */
> +       for (i =3D 1; i <=3D priv->nr_irqs; i++) {
> +               writel(0, priv->regs + APLIC_SOURCECFG_BASE +
> +                         (i - 1) * sizeof(u32));
> +               writel(APLIC_DEFAULT_PRIORITY,
> +                      priv->regs + APLIC_TARGET_BASE +
> +                      (i - 1) * sizeof(u32));
> +       }
> +
> +       /* Clear APLIC domaincfg */
> +       writel(0, priv->regs + APLIC_DOMAINCFG);
> +}
> +
> +static void aplic_init_hw_global(struct aplic_priv *priv)
> +{
> +       u32 val;
> +#ifdef CONFIG_RISCV_M_MODE
> +       u32 valH;
> +
> +       if (!priv->nr_idcs) {
> +               val =3D priv->msicfg.base_ppn;
> +               valH =3D (priv->msicfg.base_ppn >> 32) &
> +                       APLIC_xMSICFGADDRH_BAPPN_MASK;
> +               valH |=3D (priv->msicfg.lhxw & APLIC_xMSICFGADDRH_LHXW_MA=
SK)
> +                       << APLIC_xMSICFGADDRH_LHXW_SHIFT;
> +               valH |=3D (priv->msicfg.hhxw & APLIC_xMSICFGADDRH_HHXW_MA=
SK)
> +                       << APLIC_xMSICFGADDRH_HHXW_SHIFT;
> +               valH |=3D (priv->msicfg.lhxs & APLIC_xMSICFGADDRH_LHXS_MA=
SK)
> +                       << APLIC_xMSICFGADDRH_LHXS_SHIFT;
> +               valH |=3D (priv->msicfg.hhxs & APLIC_xMSICFGADDRH_HHXS_MA=
SK)
> +                       << APLIC_xMSICFGADDRH_HHXS_SHIFT;
> +               writel(val, priv->regs + APLIC_xMSICFGADDR);
> +               writel(valH, priv->regs + APLIC_xMSICFGADDRH);
> +       }
> +#endif
> +
> +       /* Setup APLIC domaincfg register */
> +       val =3D readl(priv->regs + APLIC_DOMAINCFG);
> +       val |=3D APLIC_DOMAINCFG_IE;
> +       if (!priv->nr_idcs)
> +               val |=3D APLIC_DOMAINCFG_DM;
> +       writel(val, priv->regs + APLIC_DOMAINCFG);
> +       if (readl(priv->regs + APLIC_DOMAINCFG) !=3D val)
> +               pr_warn("%pfwP: unable to write 0x%x in domaincfg\n",
> +                       priv->fwnode, val);
> +}
> +
> +static void aplic_msi_write_msg(struct msi_desc *desc, struct msi_msg *m=
sg)
> +{
> +       unsigned int group_index, hart_index, guest_index, val;
> +       struct irq_data *d =3D irq_get_irq_data(desc->irq);
> +       struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> +       struct aplic_msicfg *mc =3D &priv->msicfg;
> +       phys_addr_t tppn, tbppn, msg_addr;
> +       void __iomem *target;
> +
> +       /* For zeroed MSI, simply write zero into the target register */
> +       if (!msg->address_hi && !msg->address_lo && !msg->data) {
> +               target =3D priv->regs + APLIC_TARGET_BASE;
> +               target +=3D (d->hwirq - 1) * sizeof(u32);
> +               writel(0, target);
> +               return;
> +       }
> +
> +       /* Sanity check on message data */
> +       WARN_ON(msg->data > APLIC_TARGET_EIID_MASK);
> +
> +       /* Compute target MSI address */
> +       msg_addr =3D (((u64)msg->address_hi) << 32) | msg->address_lo;
> +       tppn =3D msg_addr >> APLIC_xMSICFGADDR_PPN_SHIFT;
> +
> +       /* Compute target HART Base PPN */
> +       tbppn =3D tppn;
> +       tbppn &=3D ~APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
> +       tbppn &=3D ~APLIC_xMSICFGADDR_PPN_LHX(mc->lhxw, mc->lhxs);
> +       tbppn &=3D ~APLIC_xMSICFGADDR_PPN_HHX(mc->hhxw, mc->hhxs);
> +       WARN_ON(tbppn !=3D mc->base_ppn);
> +
> +       /* Compute target group and hart indexes */
> +       group_index =3D (tppn >> APLIC_xMSICFGADDR_PPN_HHX_SHIFT(mc->hhxs=
)) &
> +                    APLIC_xMSICFGADDR_PPN_HHX_MASK(mc->hhxw);
> +       hart_index =3D (tppn >> APLIC_xMSICFGADDR_PPN_LHX_SHIFT(mc->lhxs)=
) &
> +                    APLIC_xMSICFGADDR_PPN_LHX_MASK(mc->lhxw);
> +       hart_index |=3D (group_index << mc->lhxw);
> +       WARN_ON(hart_index > APLIC_TARGET_HART_IDX_MASK);
> +
> +       /* Compute target guest index */
> +       guest_index =3D tppn & APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
> +       WARN_ON(guest_index > APLIC_TARGET_GUEST_IDX_MASK);
> +
> +       /* Update IRQ TARGET register */
> +       target =3D priv->regs + APLIC_TARGET_BASE;
> +       target +=3D (d->hwirq - 1) * sizeof(u32);
> +       val =3D (hart_index & APLIC_TARGET_HART_IDX_MASK)
> +                               << APLIC_TARGET_HART_IDX_SHIFT;
> +       val |=3D (guest_index & APLIC_TARGET_GUEST_IDX_MASK)
> +                               << APLIC_TARGET_GUEST_IDX_SHIFT;
> +       val |=3D (msg->data & APLIC_TARGET_EIID_MASK);
> +       writel(val, target);
> +}
> +
> +static int aplic_setup_msi(struct aplic_priv *priv)
> +{
> +       struct aplic_msicfg *mc =3D &priv->msicfg;
> +       const struct imsic_global_config *imsic_global;
> +
> +       /*
> +        * The APLIC outgoing MSI config registers assume target MSI
> +        * controller to be RISC-V AIA IMSIC controller.
> +        */
> +       imsic_global =3D imsic_get_global_config();
> +       if (!imsic_global) {
> +               pr_err("%pfwP: IMSIC global config not found\n",
> +                       priv->fwnode);
> +               return -ENODEV;
> +       }
> +
> +       /* Find number of guest index bits (LHXS) */
> +       mc->lhxs =3D imsic_global->guest_index_bits;
> +       if (APLIC_xMSICFGADDRH_LHXS_MASK < mc->lhxs) {
> +               pr_err("%pfwP: IMSIC guest index bits big for APLIC LHXS\=
n",
> +                       priv->fwnode);
> +               return -EINVAL;
> +       }
> +
> +       /* Find number of HART index bits (LHXW) */
> +       mc->lhxw =3D imsic_global->hart_index_bits;
> +       if (APLIC_xMSICFGADDRH_LHXW_MASK < mc->lhxw) {
> +               pr_err("%pfwP: IMSIC hart index bits big for APLIC LHXW\n=
",
> +                       priv->fwnode);
> +               return -EINVAL;
> +       }
> +
> +       /* Find number of group index bits (HHXW) */
> +       mc->hhxw =3D imsic_global->group_index_bits;
> +       if (APLIC_xMSICFGADDRH_HHXW_MASK < mc->hhxw) {
> +               pr_err("%pfwP: IMSIC group index bits big for APLIC HHXW\=
n",
> +                       priv->fwnode);
> +               return -EINVAL;
> +       }
> +
> +       /* Find first bit position of group index (HHXS) */
> +       mc->hhxs =3D imsic_global->group_index_shift;
> +       if (mc->hhxs < (2 * APLIC_xMSICFGADDR_PPN_SHIFT)) {
> +               pr_err("%pfwP: IMSIC group index shift should be >=3D %d\=
n",
> +                       priv->fwnode, (2 * APLIC_xMSICFGADDR_PPN_SHIFT));
> +               return -EINVAL;
> +       }
> +       mc->hhxs -=3D (2 * APLIC_xMSICFGADDR_PPN_SHIFT);
> +       if (APLIC_xMSICFGADDRH_HHXS_MASK < mc->hhxs) {
> +               pr_err("%pfwP: IMSIC group index shift big for APLIC HHXS=
\n",
> +                       priv->fwnode);
> +               return -EINVAL;
> +       }
> +
> +       /* Compute PPN base */
> +       mc->base_ppn =3D imsic_global->base_addr >> APLIC_xMSICFGADDR_PPN=
_SHIFT;
> +       mc->base_ppn &=3D ~APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
> +       mc->base_ppn &=3D ~APLIC_xMSICFGADDR_PPN_LHX(mc->lhxw, mc->lhxs);
> +       mc->base_ppn &=3D ~APLIC_xMSICFGADDR_PPN_HHX(mc->hhxw, mc->hhxs);
> +
> +       /* Use all possible CPUs as lmask */
> +       cpumask_copy(&priv->lmask, cpu_possible_mask);
> +
> +       return 0;
> +}
> +
> +/*
> + * To handle an APLIC IDC interrupts, we just read the CLAIMI register
> + * which will return highest priority pending interrupt and clear the
> + * pending bit of the interrupt. This process is repeated until CLAIMI
> + * register return zero value.
> + */
> +static void aplic_idc_handle_irq(struct irq_desc *desc)
> +{
> +       struct aplic_idc *idc =3D this_cpu_ptr(&aplic_idcs);
> +       struct irq_chip *chip =3D irq_desc_get_chip(desc);
> +       irq_hw_number_t hw_irq;
> +       int irq;
> +
> +       chained_irq_enter(chip, desc);
> +
> +       while ((hw_irq =3D readl(idc->regs + APLIC_IDC_CLAIMI))) {
> +               hw_irq =3D hw_irq >> APLIC_IDC_TOPI_ID_SHIFT;
> +               irq =3D irq_find_mapping(idc->priv->irqdomain, hw_irq);
> +
> +               if (unlikely(irq <=3D 0))
> +                       pr_warn_ratelimited("hw_irq %lu mapping not found=
\n",
> +                                           hw_irq);
> +               else
> +                       generic_handle_irq(irq);
> +       }
> +
> +       chained_irq_exit(chip, desc);
> +}
> +
> +static void aplic_idc_set_delivery(struct aplic_idc *idc, bool en)
> +{
> +       u32 de =3D (en) ? APLIC_ENABLE_IDELIVERY : APLIC_DISABLE_IDELIVER=
Y;
> +       u32 th =3D (en) ? APLIC_ENABLE_ITHRESHOLD : APLIC_DISABLE_ITHRESH=
OLD;
> +
> +       /* Priority must be less than threshold for interrupt triggering =
*/
> +       writel(th, idc->regs + APLIC_IDC_ITHRESHOLD);
> +
> +       /* Delivery must be set to 1 for interrupt triggering */
> +       writel(de, idc->regs + APLIC_IDC_IDELIVERY);
> +}
> +
> +static int aplic_idc_dying_cpu(unsigned int cpu)
> +{
> +       if (aplic_idc_parent_irq)
> +               disable_percpu_irq(aplic_idc_parent_irq);
> +
> +       return 0;
> +}
> +
> +static int aplic_idc_starting_cpu(unsigned int cpu)
> +{
> +       if (aplic_idc_parent_irq)
> +               enable_percpu_irq(aplic_idc_parent_irq,
> +                                 irq_get_trigger_type(aplic_idc_parent_i=
rq));
> +
> +       return 0;
> +}
> +
> +static int aplic_setup_idc(struct aplic_priv *priv)
> +{
> +       int i, j, rc, cpu, setup_count =3D 0;
> +       struct fwnode_reference_args parent;
> +       struct irq_domain *domain;
> +       unsigned long hartid;
> +       struct aplic_idc *idc;
> +       u32 val;
> +
> +       /* Setup per-CPU IDC and target CPU mask */
> +       for (i =3D 0; i < priv->nr_idcs; i++) {
> +               rc =3D fwnode_property_get_reference_args(priv->fwnode,
> +                               "interrupts-extended", "#interrupt-cells"=
,
> +                               0, i, &parent);
> +               if (rc) {
> +                       pr_warn("%pfwP: parent irq for IDC%d not found\n"=
,
> +                               priv->fwnode, i);
> +                       continue;
> +               }
> +
> +               /*
> +                * Skip interrupts other than external interrupts for
> +                * current privilege level.
> +                */
> +               if (parent.args[0] !=3D RV_IRQ_EXT)
> +                       continue;
> +
> +               rc =3D riscv_fw_parent_hartid(parent.fwnode, &hartid);
> +               if (rc) {
> +                       pr_warn("%pfwP: invalid hartid for IDC%d\n",
> +                               priv->fwnode, i);
> +                       continue;
> +               }
> +
> +               cpu =3D riscv_hartid_to_cpuid(hartid);
> +               if (cpu < 0) {
> +                       pr_warn("%pfwP: invalid cpuid for IDC%d\n",
> +                               priv->fwnode, i);
> +                       continue;
> +               }
> +
> +               cpumask_set_cpu(cpu, &priv->lmask);
> +
> +               idc =3D per_cpu_ptr(&aplic_idcs, cpu);
> +               idc->hart_index =3D i;
> +               idc->regs =3D priv->regs + APLIC_IDC_BASE + i * APLIC_IDC=
_SIZE;
> +               idc->priv =3D priv;
> +
> +               aplic_idc_set_delivery(idc, true);
> +
> +               /*
> +                * Boot cpu might not have APLIC hart_index =3D 0 so chec=
k
> +                * and update target registers of all interrupts.
> +                */
> +               if (cpu =3D=3D smp_processor_id() && idc->hart_index) {
> +                       val =3D idc->hart_index & APLIC_TARGET_HART_IDX_M=
ASK;
> +                       val <<=3D APLIC_TARGET_HART_IDX_SHIFT;
> +                       val |=3D APLIC_DEFAULT_PRIORITY;
> +                       for (j =3D 1; j <=3D priv->nr_irqs; j++)
> +                               writel(val, priv->regs + APLIC_TARGET_BAS=
E +
> +                                           (j - 1) * sizeof(u32));
> +               }
> +
> +               setup_count++;
> +       }
> +
> +       /* Find parent domain and register chained handler */
> +       domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode(),
> +                                         DOMAIN_BUS_ANY);
> +       if (!aplic_idc_parent_irq && domain) {
> +               aplic_idc_parent_irq =3D irq_create_mapping(domain, RV_IR=
Q_EXT);
> +               if (aplic_idc_parent_irq) {
> +                       irq_set_chained_handler(aplic_idc_parent_irq,
> +                                               aplic_idc_handle_irq);
> +
> +                       /*
> +                        * Setup CPUHP notifier to enable IDC parent
> +                        * interrupt on all CPUs
> +                        */
> +                       cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> +                                         "irqchip/riscv/aplic:starting",
> +                                         aplic_idc_starting_cpu,
> +                                         aplic_idc_dying_cpu);
> +               }
> +       }
> +
> +       /* Fail if we were not able to setup IDC for any CPU */
> +       return (setup_count) ? 0 : -ENODEV;
> +}
> +
> +static int aplic_probe(struct platform_device *pdev)
> +{
> +       struct fwnode_handle *fwnode =3D pdev->dev.fwnode;
> +       struct fwnode_reference_args parent;
> +       struct aplic_priv *priv;
> +       struct resource *res;
> +       phys_addr_t pa;
> +       int rc;
> +
> +       priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +       priv->fwnode =3D fwnode;
> +
> +       /* Map the MMIO registers */
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res) {
> +               pr_err("%pfwP: failed to get MMIO resource\n", fwnode);
> +               return -EINVAL;
> +       }
> +       priv->regs =3D devm_ioremap(&pdev->dev, res->start, resource_size=
(res));
> +       if (!priv->regs) {
> +               pr_err("%pfwP: failed map MMIO registers\n", fwnode);
> +               return -ENOMEM;
> +       }
> +
> +       /*
> +        * Find out GSI base number
> +        *
> +        * Note: DT does not define "riscv,gsi-base" property so GSI
> +        * base is always zero for DT.
> +        */
> +       rc =3D fwnode_property_read_u32_array(fwnode, "riscv,gsi-base",
> +                                           &priv->gsi_base, 1);
> +       if (rc)
> +               priv->gsi_base =3D 0;
> +
> +       /* Find out number of interrupt sources */
> +       rc =3D fwnode_property_read_u32_array(fwnode, "riscv,num-sources"=
,
> +                                           &priv->nr_irqs, 1);
> +       if (rc) {
> +               pr_err("%pfwP: failed to get number of interrupt sources\=
n",
> +                       fwnode);
> +               return rc;
> +       }
> +
> +       /* Setup initial state APLIC interrupts */
> +       aplic_init_hw_irqs(priv);
> +
> +       /*
> +        * Find out number of IDCs based on parent interrupts
> +        *
> +        * If "msi-parent" property is present then we ignore the
> +        * APLIC IDCs which forces the APLIC driver to use MSI mode.
> +        */
> +       if (!fwnode_property_present(fwnode, "msi-parent")) {
> +               while (!fwnode_property_get_reference_args(fwnode,
> +                               "interrupts-extended", "#interrupt-cells"=
,
> +                               0, priv->nr_idcs, &parent))
> +                       priv->nr_idcs++;
> +       }
> +
> +       /* Setup IDCs or MSIs based on number of IDCs */
> +       if (priv->nr_idcs)
> +               rc =3D aplic_setup_idc(priv);
> +       else
> +               rc =3D aplic_setup_msi(priv);
> +       if (rc) {
> +               pr_err("%pfwP: failed setup %s\n",
> +                       fwnode, priv->nr_idcs ? "IDCs" : "MSIs");
> +               return rc;
> +       }
> +
> +       /* Setup global config and interrupt delivery */
> +       aplic_init_hw_global(priv);
> +
> +       /* Create irq domain instance for the APLIC */
> +       if (priv->nr_idcs)
> +               priv->irqdomain =3D irq_domain_create_linear(
> +                                               priv->fwnode,
> +                                               priv->nr_irqs + 1,
> +                                               &aplic_irqdomain_idc_ops,
> +                                               priv);
> +       else
> +               priv->irqdomain =3D platform_msi_create_device_domain(
> +                                               &pdev->dev,
> +                                               priv->nr_irqs + 1,
> +                                               aplic_msi_write_msg,
> +                                               &aplic_irqdomain_msi_ops,
> +                                               priv);
> +       if (!priv->irqdomain) {
> +               pr_err("%pfwP: failed to add irq domain\n", priv->fwnode)=
;
> +               return -ENOMEM;
> +       }
> +
> +       /* Advertise the interrupt controller */
> +       if (priv->nr_idcs) {
> +               pr_info("%pfwP: %d interrupts directly connected to %d CP=
Us\n",
> +                       priv->fwnode, priv->nr_irqs, priv->nr_idcs);
> +       } else {
> +               pa =3D priv->msicfg.base_ppn << APLIC_xMSICFGADDR_PPN_SHI=
FT;
> +               pr_info("%pfwP: %d interrupts forwared to MSI base %pa\n"=
,
> +                       priv->fwnode, priv->nr_irqs, &pa);
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id aplic_match[] =3D {
> +       { .compatible =3D "riscv,aplic" },
> +       {}
> +};
> +
> +static struct platform_driver aplic_driver =3D {
> +       .driver =3D {
> +               .name           =3D "riscv-aplic",
> +               .of_match_table =3D aplic_match,
> +       },
> +       .probe =3D aplic_probe,
> +};
> +
> +static int __init aplic_init(void)
> +{
> +       /*
> +        * Register APLIC driver as early as possible so that APLIC
> +        * platform device is probed as soon as it is created.
> +        */
> +       return platform_driver_register(&aplic_driver);
> +}
> +core_initcall(aplic_init);
> +
> +static int __init aplic_dt_init(struct device_node *node,
> +                               struct device_node *parent)
> +{
> +       /*
> +        * The APLIC platform driver needs to be probed early
> +        * so for device tree:
> +        *
> +        * 1) Set the FWNODE_FLAG_BEST_EFFORT flag in fwnode which
> +        *    provides a hint to the device driver core to probe the
> +        *    platform driver early.
> +        * 2) Clear the OF_POPULATED flag in device_node because
> +        *    of_irq_init() sets it which prevents creation of
> +        *    platform device.
> +        */
> +       node->fwnode.flags |=3D FWNODE_FLAG_BEST_EFFORT;

Please stop spamming us with broken patches. Already told you this is
not an option.

Nack.


-Saravana

> +       of_node_clear_flag(node, OF_POPULATED);
> +       return 0;
> +}
> +IRQCHIP_DECLARE(riscv_aplic, "riscv,aplic", aplic_dt_init);
> diff --git a/include/linux/irqchip/riscv-aplic.h b/include/linux/irqchip/=
riscv-aplic.h
> new file mode 100644
> index 000000000000..97e198ea0109
> --- /dev/null
> +++ b/include/linux/irqchip/riscv-aplic.h
> @@ -0,0 +1,119 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> + * Copyright (C) 2022 Ventana Micro Systems Inc.
> + */
> +#ifndef __LINUX_IRQCHIP_RISCV_APLIC_H
> +#define __LINUX_IRQCHIP_RISCV_APLIC_H
> +
> +#include <linux/bitops.h>
> +
> +#define APLIC_MAX_IDC                  BIT(14)
> +#define APLIC_MAX_SOURCE               1024
> +
> +#define APLIC_DOMAINCFG                        0x0000
> +#define APLIC_DOMAINCFG_RDONLY         0x80000000
> +#define APLIC_DOMAINCFG_IE             BIT(8)
> +#define APLIC_DOMAINCFG_DM             BIT(2)
> +#define APLIC_DOMAINCFG_BE             BIT(0)
> +
> +#define APLIC_SOURCECFG_BASE           0x0004
> +#define APLIC_SOURCECFG_D              BIT(10)
> +#define APLIC_SOURCECFG_CHILDIDX_MASK  0x000003ff
> +#define APLIC_SOURCECFG_SM_MASK        0x00000007
> +#define APLIC_SOURCECFG_SM_INACTIVE    0x0
> +#define APLIC_SOURCECFG_SM_DETACH      0x1
> +#define APLIC_SOURCECFG_SM_EDGE_RISE   0x4
> +#define APLIC_SOURCECFG_SM_EDGE_FALL   0x5
> +#define APLIC_SOURCECFG_SM_LEVEL_HIGH  0x6
> +#define APLIC_SOURCECFG_SM_LEVEL_LOW   0x7
> +
> +#define APLIC_MMSICFGADDR              0x1bc0
> +#define APLIC_MMSICFGADDRH             0x1bc4
> +#define APLIC_SMSICFGADDR              0x1bc8
> +#define APLIC_SMSICFGADDRH             0x1bcc
> +
> +#ifdef CONFIG_RISCV_M_MODE
> +#define APLIC_xMSICFGADDR              APLIC_MMSICFGADDR
> +#define APLIC_xMSICFGADDRH             APLIC_MMSICFGADDRH
> +#else
> +#define APLIC_xMSICFGADDR              APLIC_SMSICFGADDR
> +#define APLIC_xMSICFGADDRH             APLIC_SMSICFGADDRH
> +#endif
> +
> +#define APLIC_xMSICFGADDRH_L           BIT(31)
> +#define APLIC_xMSICFGADDRH_HHXS_MASK   0x1f
> +#define APLIC_xMSICFGADDRH_HHXS_SHIFT  24
> +#define APLIC_xMSICFGADDRH_LHXS_MASK   0x7
> +#define APLIC_xMSICFGADDRH_LHXS_SHIFT  20
> +#define APLIC_xMSICFGADDRH_HHXW_MASK   0x7
> +#define APLIC_xMSICFGADDRH_HHXW_SHIFT  16
> +#define APLIC_xMSICFGADDRH_LHXW_MASK   0xf
> +#define APLIC_xMSICFGADDRH_LHXW_SHIFT  12
> +#define APLIC_xMSICFGADDRH_BAPPN_MASK  0xfff
> +
> +#define APLIC_xMSICFGADDR_PPN_SHIFT    12
> +
> +#define APLIC_xMSICFGADDR_PPN_HART(__lhxs) \
> +       (BIT(__lhxs) - 1)
> +
> +#define APLIC_xMSICFGADDR_PPN_LHX_MASK(__lhxw) \
> +       (BIT(__lhxw) - 1)
> +#define APLIC_xMSICFGADDR_PPN_LHX_SHIFT(__lhxs) \
> +       ((__lhxs))
> +#define APLIC_xMSICFGADDR_PPN_LHX(__lhxw, __lhxs) \
> +       (APLIC_xMSICFGADDR_PPN_LHX_MASK(__lhxw) << \
> +        APLIC_xMSICFGADDR_PPN_LHX_SHIFT(__lhxs))
> +
> +#define APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) \
> +       (BIT(__hhxw) - 1)
> +#define APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs) \
> +       ((__hhxs) + APLIC_xMSICFGADDR_PPN_SHIFT)
> +#define APLIC_xMSICFGADDR_PPN_HHX(__hhxw, __hhxs) \
> +       (APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) << \
> +        APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs))
> +
> +#define APLIC_IRQBITS_PER_REG          32
> +
> +#define APLIC_SETIP_BASE               0x1c00
> +#define APLIC_SETIPNUM                 0x1cdc
> +
> +#define APLIC_CLRIP_BASE               0x1d00
> +#define APLIC_CLRIPNUM                 0x1ddc
> +
> +#define APLIC_SETIE_BASE               0x1e00
> +#define APLIC_SETIENUM                 0x1edc
> +
> +#define APLIC_CLRIE_BASE               0x1f00
> +#define APLIC_CLRIENUM                 0x1fdc
> +
> +#define APLIC_SETIPNUM_LE              0x2000
> +#define APLIC_SETIPNUM_BE              0x2004
> +
> +#define APLIC_GENMSI                   0x3000
> +
> +#define APLIC_TARGET_BASE              0x3004
> +#define APLIC_TARGET_HART_IDX_SHIFT    18
> +#define APLIC_TARGET_HART_IDX_MASK     0x3fff
> +#define APLIC_TARGET_GUEST_IDX_SHIFT   12
> +#define APLIC_TARGET_GUEST_IDX_MASK    0x3f
> +#define APLIC_TARGET_IPRIO_MASK        0xff
> +#define APLIC_TARGET_EIID_MASK 0x7ff
> +
> +#define APLIC_IDC_BASE                 0x4000
> +#define APLIC_IDC_SIZE                 32
> +
> +#define APLIC_IDC_IDELIVERY            0x00
> +
> +#define APLIC_IDC_IFORCE               0x04
> +
> +#define APLIC_IDC_ITHRESHOLD           0x08
> +
> +#define APLIC_IDC_TOPI                 0x18
> +#define APLIC_IDC_TOPI_ID_SHIFT        16
> +#define APLIC_IDC_TOPI_ID_MASK 0x3ff
> +#define APLIC_IDC_TOPI_PRIO_MASK       0xff
> +
> +#define APLIC_IDC_CLAIMI               0x1c
> +
> +#endif
> --
> 2.34.1
>
