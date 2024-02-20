Return-Path: <linux-kernel+bounces-72951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 291CA85BB04
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAD41C23CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E12967C6C;
	Tue, 20 Feb 2024 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqVBadXH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0AB67C62;
	Tue, 20 Feb 2024 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429989; cv=none; b=CC/uMKu1Ncs4KoLeo62/ouqfq2qNuX8U+LNu0h4YrOIAPe5F/UcbSKnBbB9e3MeDTWuSNKJYEIK1n//v0RJuHoD7VMXYz9RQrXmf4fuzvvcJSHxtkI/r9hBJ3kJEgjfyMjCVhP1xF0OPBDORD9KFw6OuwJeMimugbzY3FyJeCZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429989; c=relaxed/simple;
	bh=0QOtgbstAGHF3QyOGgHp3O/TcMHwn2p2PxqN2Nw4YEQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=faDvHN4Dv4wabg4Re2sdITwes4cEDBbBLAhViSNOwnijEA27mE4jJyomFM254nEujzg6o+ujXNtY57IE3b8WNI+nAvvhp+mjGSvYJqcbUMLWn14Mr9H12+xTNuje3dsjj4AWA0nhPW7/vvvRoZMVU8Qqv95MujgobOlKkWUDoy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqVBadXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32069C43394;
	Tue, 20 Feb 2024 11:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708429988;
	bh=0QOtgbstAGHF3QyOGgHp3O/TcMHwn2p2PxqN2Nw4YEQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tqVBadXHkR4vWFAeqR0zLZQfew0c2PN3ezmQUPPqcmfjQ8/P5FMzZtheM5/lhBZPI
	 /BNZkW63YSzX9PGKghYLb5e+MDh77Kq/vJBeeuVNXZ7FjzjqxdwkEubZQf69X8soUo
	 2BqbbPZDqI0Wfsnmznuu95294DnRQiskLNQU3O2egjHvEbtX4XDABUsAaEPssmmPSn
	 67B0wVq+6zDJYTmbvc9zDqKhk+S89nce/GTKBC7ddI0I+6uEgA4GTxc05CmIDUpcPB
	 HK+Nv+S4/lZl8gtu5HjOfjobiYYNZ6Gpvj2qjcW08fr2DQHqLkRom77KRJNmkcayq+
	 UqRTNsGMlWulw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas
 Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org,
 Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>,
 Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org, Atish
 Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Andrew Jones
 <ajones@ventanamicro.com>
Subject: Re: [PATCH v13 07/13] irqchip/riscv-imsic: Add device MSI domain
 support for platform devices
In-Reply-To: <20240220060718.823229-8-apatel@ventanamicro.com>
References: <20240220060718.823229-1-apatel@ventanamicro.com>
 <20240220060718.823229-8-apatel@ventanamicro.com>
Date: Tue, 20 Feb 2024 12:53:05 +0100
Message-ID: <87cysrfj32.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup Patel <apatel@ventanamicro.com> writes:

> The Linux platform MSI support allows per-device MSI domains so let
> us add a platform irqchip driver for RISC-V IMSIC which provides a
> base IRQ domain with MSI parent support for platform device domains.
>
> This driver assumes that the IMSIC state is already initialized by
> the IMSIC early driver.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/irqchip/Makefile                   |   2 +-
>  drivers/irqchip/irq-riscv-imsic-platform.c | 346 +++++++++++++++++++++
>  drivers/irqchip/irq-riscv-imsic-state.h    |   1 +
>  3 files changed, 348 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/irqchip/irq-riscv-imsic-platform.c
>
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index d714724387ce..abca445a3229 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -95,7 +95,7 @@ obj-$(CONFIG_QCOM_MPM)			+=3D irq-qcom-mpm.o
>  obj-$(CONFIG_CSKY_MPINTC)		+=3D irq-csky-mpintc.o
>  obj-$(CONFIG_CSKY_APB_INTC)		+=3D irq-csky-apb-intc.o
>  obj-$(CONFIG_RISCV_INTC)		+=3D irq-riscv-intc.o
> -obj-$(CONFIG_RISCV_IMSIC)		+=3D irq-riscv-imsic-state.o irq-riscv-imsic-=
early.o
> +obj-$(CONFIG_RISCV_IMSIC)		+=3D irq-riscv-imsic-state.o irq-riscv-imsic-=
early.o irq-riscv-imsic-platform.o
>  obj-$(CONFIG_SIFIVE_PLIC)		+=3D irq-sifive-plic.o
>  obj-$(CONFIG_IMX_IRQSTEER)		+=3D irq-imx-irqsteer.o
>  obj-$(CONFIG_IMX_INTMUX)		+=3D irq-imx-intmux.o
> diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip=
/irq-riscv-imsic-platform.c
> new file mode 100644
> index 000000000000..7ee44c493dbc
> --- /dev/null
> +++ b/drivers/irqchip/irq-riscv-imsic-platform.c
> @@ -0,0 +1,346 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> + * Copyright (C) 2022 Ventana Micro Systems Inc.
> + */
> +
> +#define pr_fmt(fmt) "riscv-imsic: " fmt
> +#include <linux/bitmap.h>
> +#include <linux/cpu.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>
> +#include <linux/msi.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <linux/smp.h>
> +
> +#include "irq-riscv-imsic-state.h"
> +
> +static bool imsic_cpu_page_phys(unsigned int cpu, unsigned int guest_ind=
ex,
> +				phys_addr_t *out_msi_pa)
> +{
> +	struct imsic_global_config *global;
> +	struct imsic_local_config *local;
> +
> +	global =3D &imsic->global;
> +	local =3D per_cpu_ptr(global->local, cpu);
> +
> +	if (BIT(global->guest_index_bits) <=3D guest_index)
> +		return false;
> +
> +	if (out_msi_pa)
> +		*out_msi_pa =3D local->msi_pa +
> +			      (guest_index * IMSIC_MMIO_PAGE_SZ);
> +
> +	return true;
> +}
> +
> +static void imsic_irq_mask(struct irq_data *d)
> +{
> +	imsic_vector_mask(irq_data_get_irq_chip_data(d));
> +}
> +
> +static void imsic_irq_unmask(struct irq_data *d)
> +{
> +	imsic_vector_unmask(irq_data_get_irq_chip_data(d));
> +}
> +
> +static int imsic_irq_retrigger(struct irq_data *d)
> +{
> +	struct imsic_vector *vec =3D irq_data_get_irq_chip_data(d);
> +	struct imsic_local_config *local;
> +
> +	if (WARN_ON(vec =3D=3D NULL))

Checkpatch: use !vec

> +		return -ENOENT;
> +
> +	local =3D per_cpu_ptr(imsic->global.local, vec->cpu);
> +	writel_relaxed(vec->local_id, local->msi_va);
> +	return 0;
> +}
> +
> +static void imsic_irq_compose_vector_msg(struct imsic_vector *vec, struc=
t msi_msg *msg)
> +{
> +	phys_addr_t msi_addr;
> +
> +	if (WARN_ON(vec =3D=3D NULL))

Checkpatch: use !vec

> +		return;
> +
> +	if (WARN_ON(!imsic_cpu_page_phys(vec->cpu, 0, &msi_addr)))
> +		return;
> +
> +	msg->address_hi =3D upper_32_bits(msi_addr);
> +	msg->address_lo =3D lower_32_bits(msi_addr);
> +	msg->data =3D vec->local_id;
> +}
> +
> +static void imsic_irq_compose_msg(struct irq_data *d, struct msi_msg *ms=
g)
> +{
> +	imsic_irq_compose_vector_msg(irq_data_get_irq_chip_data(d), msg);
> +}
> +
> +#ifdef CONFIG_SMP
> +static void imsic_msi_update_msg(struct irq_data *d, struct imsic_vector=
 *vec)
> +{
> +	struct msi_msg msg[2] =3D { [1] =3D { }, };
> +
> +	imsic_irq_compose_vector_msg(vec, msg);
> +	irq_data_get_irq_chip(d)->irq_write_msi_msg(d, msg);
> +}
> +
> +static int imsic_irq_set_affinity(struct irq_data *d, const struct cpuma=
sk *mask_val,
> +				  bool force)
> +{
> +	struct imsic_vector *old_vec, *new_vec;
> +	struct irq_data *pd =3D d->parent_data;
> +
> +	old_vec =3D irq_data_get_irq_chip_data(pd);
> +	if (WARN_ON(old_vec =3D=3D NULL))

Checkpatch: use !old_vec

> +		return -ENOENT;
> +
> +	/* If old vector cpu belongs to the target cpumask then do nothing */
> +	if (cpumask_test_cpu(old_vec->cpu, mask_val))
> +		return IRQ_SET_MASK_OK_DONE;
> +
> +	/* If move is already in-flight then return failure */
> +	if (imsic_vector_get_move(old_vec))
> +		return -EBUSY;
> +
> +	/* Get a new vector on the desired set of CPUs */
> +	new_vec =3D imsic_vector_alloc(old_vec->hwirq, mask_val);
> +	if (!new_vec)
> +		return -ENOSPC;
> +
> +	/* Point device to the new vector */
> +	imsic_msi_update_msg(d, new_vec);
> +
> +	/* Update irq descriptors with the new vector */
> +	pd->chip_data =3D new_vec;
> +
> +	/* Update effective affinity of parent irq data */
> +	irq_data_update_effective_affinity(pd, cpumask_of(new_vec->cpu));
> +
> +	/* Move state of the old vector to the new vector */
> +	imsic_vector_move(old_vec, new_vec);
> +
> +	return IRQ_SET_MASK_OK_DONE;
> +}
> +#endif
> +
> +static struct irq_chip imsic_irq_base_chip =3D {
> +	.name			=3D "IMSIC",
> +	.irq_mask		=3D imsic_irq_mask,
> +	.irq_unmask		=3D imsic_irq_unmask,
> +	.irq_retrigger		=3D imsic_irq_retrigger,
> +	.irq_compose_msi_msg	=3D imsic_irq_compose_msg,
> +	.flags			=3D IRQCHIP_SKIP_SET_WAKE |
> +				  IRQCHIP_MASK_ON_SUSPEND,
> +};
> +
> +static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned in=
t virq,
> +				  unsigned int nr_irqs, void *args)
> +{
> +	struct imsic_vector *vec;
> +
> +	/* Legacy-MSI or multi-MSI not supported yet. */
> +	if (nr_irqs > 1)
> +		return -ENOTSUPP;

Checkpatch: WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP


Bj=C3=B6rn

