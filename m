Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4537AD296
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjIYIAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjIYIAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:00:42 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D91A136
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:00:29 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68c576d35feso5317938b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695628828; x=1696233628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tLdgL4Tu+3v5LYCJacjGqpZhOaJgd47fF2svqbehsU8=;
        b=E5R7VHiv/n2SoYG63IGKoy0tDLzkoUzVB8oJOi80HCkONYCclj/kFOhmrL1nD92U+M
         +wCSjnpRIDk+vlsamcgksUtCAWeKG6j8CBB4SILG7TmHdACjSAwwZWYEJokQp4X1s48o
         dP43+xiAlAm2CqupJKuVktlcoezkRj+Wsq8bEhZgi9Go5KLS6qi6dpJnhKVyAQRM7JcF
         QI+N9sxeOS11NX5BouhW+HyfXZL1x2irg3NZ58dnBebIDIpaX6oTpsX2PQNZ/BWsk8bb
         y62zcXKumMZIfMDbQjyyQYmPrtqJmVC/GNUUuboR0IK6Pt5a+VEnVdc+lq17asJh+VlR
         7/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695628828; x=1696233628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLdgL4Tu+3v5LYCJacjGqpZhOaJgd47fF2svqbehsU8=;
        b=FUgRb+rNMhJwr/1CuHUmqiCv2I0DzWHqP1Kp4/o6ZvzqlMU/mZjVFCIFo+e6r1cbE/
         +cQZaZap1+2UHgao6oJsfdLjcmR4qpcblhq1/v1ZPvcl/+u65iDwqTMMLOwpyunBeMhP
         QHjB51u4IWgTdFg75MUhrjSIsVPLtGEw3qQro5TicFcXPJZdpyZiddNalOLwsinK8I09
         V4L+y4+pumcdc7wKbbCKEaxaG7sXEJ8EqxA3xeixWPs8io9pyxbTBiiURzPcfX6SicXO
         fg73jroI0S9gUf5SgS7vw7zO7PQwo6CWHTiNHy6a4YLJIthlm5r5kn2fSP33vBV95rp0
         6w4A==
X-Gm-Message-State: AOJu0YwYibNOxSNMmOcTknmH19XjXvhYqST1E59jyK8YCVPj8XdV3G9q
        nFXVSLBU2Xc0hLVvsie8n/byVg==
X-Google-Smtp-Source: AGHT+IF7JQ+DOKIrUW1HPLr2WlMm0OUXLTolvQciX7VxL/ncv2Qnvi814KxoCsTIYTUpZLSn5buqog==
X-Received: by 2002:a05:6a20:3d29:b0:13d:b318:5c70 with SMTP id y41-20020a056a203d2900b0013db3185c70mr8311483pzi.19.1695628828313;
        Mon, 25 Sep 2023 01:00:28 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.42])
        by smtp.gmail.com with ESMTPSA id je11-20020a170903264b00b001c47541ecd7sm3818361plb.250.2023.09.25.01.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 01:00:27 -0700 (PDT)
Date:   Mon, 25 Sep 2023 13:30:13 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
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
Subject: Re: [PATCH v8 13/16] irqchip: Add RISC-V advanced PLIC driver for
 direct-mode
Message-ID: <ZRE+DXUs3MRrpf3T@sunil-laptop>
References: <20230912174928.528414-1-apatel@ventanamicro.com>
 <20230912174928.528414-14-apatel@ventanamicro.com>
 <ZRE9GCVIxwOUo6HA@sunil-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRE9GCVIxwOUo6HA@sunil-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 01:26:17PM +0530, Sunil V L wrote:
> Hi Anup,
> 
> On Tue, Sep 12, 2023 at 11:19:25PM +0530, Anup Patel wrote:
> > The RISC-V advanced interrupt architecture (AIA) specification defines
> > advanced platform-level interrupt controller (APLIC) which has two modes
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
> >  	select IRQ_DOMAIN_HIERARCHY
> >  	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
> >  
> > +config RISCV_APLIC
> > +	bool
> > +	depends on RISCV
> > +	select IRQ_DOMAIN_HIERARCHY
> > +
> >  config RISCV_IMSIC
> >  	bool
> >  	depends on RISCV
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index abca445a3229..7f8289790ed8 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -95,6 +95,7 @@ obj-$(CONFIG_QCOM_MPM)			+= irq-qcom-mpm.o
> >  obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
> >  obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
> >  obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
> > +obj-$(CONFIG_RISCV_APLIC)		+= irq-riscv-aplic-main.o irq-riscv-aplic-direct.o
> >  obj-$(CONFIG_RISCV_IMSIC)		+= irq-riscv-imsic-state.o irq-riscv-imsic-early.o irq-riscv-imsic-platform.o
> >  obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
> >  obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
> > diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-riscv-aplic-direct.c
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
> > +#define APLIC_DISABLE_IDELIVERY		0
> > +#define APLIC_ENABLE_IDELIVERY		1
> > +#define APLIC_DISABLE_ITHRESHOLD	1
> > +#define APLIC_ENABLE_ITHRESHOLD		0
> > +
> > +struct aplic_direct {
> > +	struct aplic_priv	priv;
> > +	struct irq_domain	*irqdomain;
> > +	struct cpumask		lmask;
> > +};
> > +
> > +struct aplic_idc {
> > +	unsigned int		hart_index;
> > +	void __iomem		*regs;
> > +	struct aplic_direct	*direct;
> > +};
> > +
> > +static unsigned int aplic_direct_parent_irq;
> > +static DEFINE_PER_CPU(struct aplic_idc, aplic_idcs);
> > +
> > +static void aplic_direct_irq_eoi(struct irq_data *d)
> > +{
> > +	/*
> > +	 * The fasteoi_handler requires irq_eoi() callback hence
> > +	 * provide a dummy handler.
> > +	 */
> > +}
> > +
> > +#ifdef CONFIG_SMP
> > +static int aplic_direct_set_affinity(struct irq_data *d,
> > +				  const struct cpumask *mask_val, bool force)
> > +{
> > +	struct aplic_priv *priv = irq_data_get_irq_chip_data(d);
> > +	struct aplic_direct *direct =
> > +			container_of(priv, struct aplic_direct, priv);
> > +	struct aplic_idc *idc;
> > +	unsigned int cpu, val;
> > +	struct cpumask amask;
> > +	void __iomem *target;
> > +
> > +	cpumask_and(&amask, &direct->lmask, mask_val);
> > +
> > +	if (force)
> > +		cpu = cpumask_first(&amask);
> > +	else
> > +		cpu = cpumask_any_and(&amask, cpu_online_mask);
> > +
> > +	if (cpu >= nr_cpu_ids)
> > +		return -EINVAL;
> > +
> > +	idc = per_cpu_ptr(&aplic_idcs, cpu);
> > +	target = priv->regs + APLIC_TARGET_BASE;
> > +	target += (d->hwirq - 1) * sizeof(u32);
> > +	val = idc->hart_index & APLIC_TARGET_HART_IDX_MASK;
> > +	val <<= APLIC_TARGET_HART_IDX_SHIFT;
> > +	val |= APLIC_DEFAULT_PRIORITY;
> > +	writel(val, target);
> > +
> > +	irq_data_update_effective_affinity(d, cpumask_of(cpu));
> > +
> > +	return IRQ_SET_MASK_OK_DONE;
> > +}
> > +#endif
> > +
> > +static struct irq_chip aplic_direct_chip = {
> > +	.name		= "APLIC-DIRECT",
> > +	.irq_mask	= aplic_irq_mask,
> > +	.irq_unmask	= aplic_irq_unmask,
> > +	.irq_set_type	= aplic_irq_set_type,
> > +	.irq_eoi	= aplic_direct_irq_eoi,
> > +#ifdef CONFIG_SMP
> > +	.irq_set_affinity = aplic_direct_set_affinity,
> > +#endif
> > +	.flags		= IRQCHIP_SET_TYPE_MASKED |
> > +			  IRQCHIP_SKIP_SET_WAKE |
> > +			  IRQCHIP_MASK_ON_SUSPEND,
> > +};
> > +
> > +static int aplic_direct_irqdomain_translate(struct irq_domain *d,
> > +					 struct irq_fwspec *fwspec,
> > +					 unsigned long *hwirq,
> > +					 unsigned int *type)
> > +{
> > +	struct aplic_priv *priv = d->host_data;
> > +
> > +	return aplic_irqdomain_translate(fwspec, priv->gsi_base,
> > +					 hwirq, type);
> > +}
> > +
> > +static int aplic_direct_irqdomain_alloc(struct irq_domain *domain,
> > +				     unsigned int virq, unsigned int nr_irqs,
> > +				     void *arg)
> > +{
> > +	int i, ret;
> > +	unsigned int type;
> > +	irq_hw_number_t hwirq;
> > +	struct irq_fwspec *fwspec = arg;
> > +	struct aplic_priv *priv = domain->host_data;
> > +	struct aplic_direct *direct =
> > +			container_of(priv, struct aplic_direct, priv);
> > +
> > +	ret = aplic_irqdomain_translate(fwspec, priv->gsi_base,
> > +					&hwirq, &type);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for (i = 0; i < nr_irqs; i++) {
> > +		irq_domain_set_info(domain, virq + i, hwirq + i,
> > +				    &aplic_direct_chip, priv,
> > +				    handle_fasteoi_irq, NULL, NULL);
> > +		irq_set_affinity(virq + i, &direct->lmask);
> > +		/* See the reason described in aplic_msi_irqdomain_alloc() */
> > +		irq_set_status_flags(virq + i, IRQ_DISABLE_UNLAZY);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct irq_domain_ops aplic_direct_irqdomain_ops = {
> > +	.translate	= aplic_direct_irqdomain_translate,
> > +	.alloc		= aplic_direct_irqdomain_alloc,
> > +	.free		= irq_domain_free_irqs_top,
> > +};
> > +
> > +/*
> > + * To handle an APLIC direct interrupts, we just read the CLAIMI register
> > + * which will return highest priority pending interrupt and clear the
> > + * pending bit of the interrupt. This process is repeated until CLAIMI
> > + * register return zero value.
> > + */
> > +static void aplic_direct_handle_irq(struct irq_desc *desc)
> > +{
> > +	struct aplic_idc *idc = this_cpu_ptr(&aplic_idcs);
> > +	struct irq_chip *chip = irq_desc_get_chip(desc);
> > +	struct irq_domain *irqdomain = idc->direct->irqdomain;
> > +	irq_hw_number_t hw_irq;
> > +	int irq;
> > +
> > +	chained_irq_enter(chip, desc);
> > +
> > +	while ((hw_irq = readl(idc->regs + APLIC_IDC_CLAIMI))) {
> > +		hw_irq = hw_irq >> APLIC_IDC_TOPI_ID_SHIFT;
> > +		irq = irq_find_mapping(irqdomain, hw_irq);
> > +
> > +		if (unlikely(irq <= 0))
> > +			dev_warn_ratelimited(idc->direct->priv.dev,
> > +					     "hw_irq %lu mapping not found\n",
> > +					     hw_irq);
> > +		else
> > +			generic_handle_irq(irq);
> > +	}
> > +
> > +	chained_irq_exit(chip, desc);
> > +}
> > +
> > +static void aplic_idc_set_delivery(struct aplic_idc *idc, bool en)
> > +{
> > +	u32 de = (en) ? APLIC_ENABLE_IDELIVERY : APLIC_DISABLE_IDELIVERY;
> > +	u32 th = (en) ? APLIC_ENABLE_ITHRESHOLD : APLIC_DISABLE_ITHRESHOLD;
> > +
> > +	/* Priority must be less than threshold for interrupt triggering */
> > +	writel(th, idc->regs + APLIC_IDC_ITHRESHOLD);
> > +
> > +	/* Delivery must be set to 1 for interrupt triggering */
> > +	writel(de, idc->regs + APLIC_IDC_IDELIVERY);
> > +}
> > +
> > +static int aplic_direct_dying_cpu(unsigned int cpu)
> > +{
> > +	if (aplic_direct_parent_irq)
> > +		disable_percpu_irq(aplic_direct_parent_irq);
> > +
> > +	return 0;
> > +}
> > +
> > +static int aplic_direct_starting_cpu(unsigned int cpu)
> > +{
> > +	if (aplic_direct_parent_irq)
> > +		enable_percpu_irq(aplic_direct_parent_irq,
> > +				irq_get_trigger_type(aplic_direct_parent_irq));
> > +
> > +	return 0;
> > +}
> > +
> > +int aplic_direct_setup(struct device *dev, void __iomem *regs)
> > +{
> > +	int i, j, rc, cpu, setup_count = 0;
> > +	struct fwnode_reference_args parent;
> > +	struct aplic_direct *direct;
> > +	struct aplic_priv *priv;
> > +	struct irq_domain *domain;
> > +	unsigned long hartid;
> > +	struct aplic_idc *idc;
> > +	u32 val;
> > +
> > +	direct = kzalloc(sizeof(*direct), GFP_KERNEL);
> > +	if (!direct)
> > +		return -ENOMEM;
> > +	priv = &direct->priv;
> > +
> > +	rc = aplic_setup_priv(priv, dev, regs);
> > +	if (rc) {
> > +		dev_err(dev, "failed to create APLIC context\n");
> > +		kfree(direct);
> > +		return rc;
> > +	}
> > +
> > +	/* Setup per-CPU IDC and target CPU mask */
> > +	for (i = 0; i < priv->nr_idcs; i++) {
> > +		rc = fwnode_property_get_reference_args(dev->fwnode,
> > +				"interrupts-extended", "#interrupt-cells",
> > +				0, i, &parent);
> > +		if (rc) {
> > +			dev_warn(dev, "parent irq for IDC%d not found\n", i);
> > +			continue;
> > +		}
> > +
> > +		/*
> > +		 * Skip interrupts other than external interrupts for
> > +		 * current privilege level.
> > +		 */
> > +		if (parent.args[0] != RV_IRQ_EXT)
> > +			continue;
> > +
> > +		rc = riscv_get_intc_hartid(parent.fwnode, &hartid);
> > +		if (rc) {
> > +			dev_warn(dev, "invalid hartid for IDC%d\n", i);
> > +			continue;
> > +		}
> > +
> > +		cpu = riscv_hartid_to_cpuid(hartid);
> > +		if (cpu < 0) {
> > +			dev_warn(dev, "invalid cpuid for IDC%d\n", i);
> > +			continue;
> > +		}
> > +
> > +		cpumask_set_cpu(cpu, &direct->lmask);
> > +
> > +		idc = per_cpu_ptr(&aplic_idcs, cpu);
> > +		idc->hart_index = i;
> > +		idc->regs = priv->regs + APLIC_IDC_BASE + i * APLIC_IDC_SIZE;
> > +		idc->direct = direct;
> > +
> > +		aplic_idc_set_delivery(idc, true);
> > +
> > +		/*
> > +		 * Boot cpu might not have APLIC hart_index = 0 so check
> > +		 * and update target registers of all interrupts.
> > +		 */
> > +		if (cpu == smp_processor_id() && idc->hart_index) {
> > +			val = idc->hart_index & APLIC_TARGET_HART_IDX_MASK;
> > +			val <<= APLIC_TARGET_HART_IDX_SHIFT;
> > +			val |= APLIC_DEFAULT_PRIORITY;
> > +			for (j = 1; j <= priv->nr_irqs; j++)
> > +				writel(val, priv->regs + APLIC_TARGET_BASE +
> > +					    (j - 1) * sizeof(u32));
> > +		}
> > +
> > +		setup_count++;
> > +	}
> > +
> > +	/* Find parent domain and register chained handler */
> > +	domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(),
> > +					  DOMAIN_BUS_ANY);
> > +	if (!aplic_direct_parent_irq && domain) {
> > +		aplic_direct_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
> > +		if (aplic_direct_parent_irq) {
> > +			irq_set_chained_handler(aplic_direct_parent_irq,
> > +						aplic_direct_handle_irq);
> > +
> > +			/*
> > +			 * Setup CPUHP notifier to enable parent
> > +			 * interrupt on all CPUs
> > +			 */
> > +			cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> > +					  "irqchip/riscv/aplic:starting",
> > +					  aplic_direct_starting_cpu,
> > +					  aplic_direct_dying_cpu);
> > +		}
> > +	}
> > +
> > +	/* Fail if we were not able to setup IDC for any CPU */
> > +	if (!setup_count) {
> > +		kfree(direct);
> > +		return -ENODEV;
> > +	}
> > +
> > +	/* Setup global config and interrupt delivery */
> > +	aplic_init_hw_global(priv, false);
> > +
> > +	/* Create irq domain instance for the APLIC */
> > +	direct->irqdomain = irq_domain_create_linear(dev->fwnode,
> > +						   priv->nr_irqs + 1,
> > +						   &aplic_direct_irqdomain_ops,
> > +						   priv);
> > +	if (!direct->irqdomain) {
> > +		dev_err(dev, "failed to create direct irq domain\n");
> > +		kfree(direct);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/* Advertise the interrupt controller */
> > +	dev_info(dev, "%d interrupts directly connected to %d CPUs\n",
> > +		 priv->nr_irqs, priv->nr_idcs);
> > +
> > +	return 0;
> > +}
> > diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
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
> > +	struct aplic_priv *priv = irq_data_get_irq_chip_data(d);
> > +
> > +	writel(d->hwirq, priv->regs + APLIC_SETIENUM);
> > +}
> > +
> > +void aplic_irq_mask(struct irq_data *d)
> > +{
> > +	struct aplic_priv *priv = irq_data_get_irq_chip_data(d);
> > +
> > +	writel(d->hwirq, priv->regs + APLIC_CLRIENUM);
> > +}
> > +
> > +int aplic_irq_set_type(struct irq_data *d, unsigned int type)
> > +{
> > +	u32 val = 0;
> > +	void __iomem *sourcecfg;
> > +	struct aplic_priv *priv = irq_data_get_irq_chip_data(d);
> > +
> > +	switch (type) {
> > +	case IRQ_TYPE_NONE:
> > +		val = APLIC_SOURCECFG_SM_INACTIVE;
> > +		break;
> > +	case IRQ_TYPE_LEVEL_LOW:
> > +		val = APLIC_SOURCECFG_SM_LEVEL_LOW;
> > +		break;
> > +	case IRQ_TYPE_LEVEL_HIGH:
> > +		val = APLIC_SOURCECFG_SM_LEVEL_HIGH;
> > +		break;
> > +	case IRQ_TYPE_EDGE_FALLING:
> > +		val = APLIC_SOURCECFG_SM_EDGE_FALL;
> > +		break;
> > +	case IRQ_TYPE_EDGE_RISING:
> > +		val = APLIC_SOURCECFG_SM_EDGE_RISE;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	sourcecfg = priv->regs + APLIC_SOURCECFG_BASE;
> > +	sourcecfg += (d->hwirq - 1) * sizeof(u32);
> > +	writel(val, sourcecfg);
> > +
> > +	return 0;
> > +}
> > +
> > +int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u32 gsi_base,
> > +			      unsigned long *hwirq, unsigned int *type)
> > +{
> > +	if (WARN_ON(fwspec->param_count < 2))
> > +		return -EINVAL;
> > +	if (WARN_ON(!fwspec->param[0]))
> > +		return -EINVAL;
> > +
> > +	/* For DT, gsi_base is always zero. */
> > +	*hwirq = fwspec->param[0] - gsi_base;
> > +	*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
> > +
> > +	WARN_ON(*type == IRQ_TYPE_NONE);
> > +
> > +	return 0;
> > +}
> > +
> > +void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode)
> > +{
> > +	u32 val;
> > +#ifdef CONFIG_RISCV_M_MODE
> > +	u32 valH;
> > +
> > +	if (msi_mode) {
> > +		val = priv->msicfg.base_ppn;
> > +		valH = ((u64)priv->msicfg.base_ppn >> 32) &
> > +			APLIC_xMSICFGADDRH_BAPPN_MASK;
> > +		valH |= (priv->msicfg.lhxw & APLIC_xMSICFGADDRH_LHXW_MASK)
> > +			<< APLIC_xMSICFGADDRH_LHXW_SHIFT;
> > +		valH |= (priv->msicfg.hhxw & APLIC_xMSICFGADDRH_HHXW_MASK)
> > +			<< APLIC_xMSICFGADDRH_HHXW_SHIFT;
> > +		valH |= (priv->msicfg.lhxs & APLIC_xMSICFGADDRH_LHXS_MASK)
> > +			<< APLIC_xMSICFGADDRH_LHXS_SHIFT;
> > +		valH |= (priv->msicfg.hhxs & APLIC_xMSICFGADDRH_HHXS_MASK)
> > +			<< APLIC_xMSICFGADDRH_HHXS_SHIFT;
> > +		writel(val, priv->regs + APLIC_xMSICFGADDR);
> > +		writel(valH, priv->regs + APLIC_xMSICFGADDRH);
> > +	}
> > +#endif
> > +
> > +	/* Setup APLIC domaincfg register */
> > +	val = readl(priv->regs + APLIC_DOMAINCFG);
> > +	val |= APLIC_DOMAINCFG_IE;
> > +	if (msi_mode)
> > +		val |= APLIC_DOMAINCFG_DM;
> > +	writel(val, priv->regs + APLIC_DOMAINCFG);
> > +	if (readl(priv->regs + APLIC_DOMAINCFG) != val)
> > +		dev_warn(priv->dev, "unable to write 0x%x in domaincfg\n",
> > +			 val);
> > +}
> > +
> > +static void aplic_init_hw_irqs(struct aplic_priv *priv)
> > +{
> > +	int i;
> > +
> > +	/* Disable all interrupts */
> > +	for (i = 0; i <= priv->nr_irqs; i += 32)
> > +		writel(-1U, priv->regs + APLIC_CLRIE_BASE +
> > +			    (i / 32) * sizeof(u32));
> > +
> > +	/* Set interrupt type and default priority for all interrupts */
> > +	for (i = 1; i <= priv->nr_irqs; i++) {
> > +		writel(0, priv->regs + APLIC_SOURCECFG_BASE +
> > +			  (i - 1) * sizeof(u32));
> > +		writel(APLIC_DEFAULT_PRIORITY,
> > +		       priv->regs + APLIC_TARGET_BASE +
> > +		       (i - 1) * sizeof(u32));
> > +	}
> > +
> > +	/* Clear APLIC domaincfg */
> > +	writel(0, priv->regs + APLIC_DOMAINCFG);
> > +}
> > +
> > +int aplic_setup_priv(struct aplic_priv *priv, struct device *dev,
> > +		     void __iomem *regs)
> > +{
> > +	struct fwnode_reference_args parent;
> > +	int rc;
> > +
> > +	/* Save device pointer and register base */
> > +	priv->dev = dev;
> > +	priv->regs = regs;
> > +
> > +	/*
> > +	 * Find out GSI base number
> > +	 *
> > +	 * Note: DT does not define "riscv,gsi-base" property so GSI
> > +	 * base is always zero for DT.
> > +	 */
> > +	rc = fwnode_property_read_u32_array(dev->fwnode, "riscv,gsi-base",
> > +					    &priv->gsi_base, 1);
> For DT, you can just initialize this to 0 without reading the property.
> 
> > +	if (rc)
> > +		priv->gsi_base = 0;
> > +
> > +	/* Find out number of interrupt sources */
> > +	rc = fwnode_property_read_u32_array(dev->fwnode, "riscv,num-sources",
> > +					    &priv->nr_irqs, 1);
> > +	if (rc) {
> > +		dev_err(dev, "failed to get number of interrupt sources\n");
> > +		return rc;
> > +	}
> > +
> > +	/* Setup initial state APLIC interrupts */
> > +	aplic_init_hw_irqs(priv);
> > +
> > +	/*
> > +	 * Find out number of IDCs based on parent interrupts
> > +	 *
> > +	 * If "msi-parent" property is present then we ignore the
> > +	 * APLIC IDCs which forces the APLIC driver to use MSI mode.
> > +	 */
> > +	if (!fwnode_property_present(dev->fwnode, "msi-parent")) {
> > +		while (!fwnode_property_get_reference_args(dev->fwnode,
> > +				"interrupts-extended", "#interrupt-cells",
> > +				0, priv->nr_idcs, &parent))
> > +			priv->nr_idcs++;
> > +	}
> > +
> Can this finding nr_idcs be done after aplic_init_hw_irqs() above?
> 
Sorry, I meant prior to calling aplic_init_hw_irqs().

Thanks,
Sunl
