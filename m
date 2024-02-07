Return-Path: <linux-kernel+bounces-56240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB0484C7C9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296C81F2919A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D4B22338;
	Wed,  7 Feb 2024 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rr0WjIqw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B29224DD;
	Wed,  7 Feb 2024 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298991; cv=none; b=IrAwuatzjTFp3my7usGlP7TtQee7NzbT02MTvikXeDyWLX7DRQIiCkOh7FsqK7ZcQdLxvb+aSWx7MyfaQhh2we1zw5iARMskew1O4zgaTR1bZA/OJWs7SVpziT2kLq4laJSDKm0CLIFSUfYIOYqeB+NAHim/uvYS54qldKf9Os0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298991; c=relaxed/simple;
	bh=rBz0ZwAZn/fuX05TD2o/9u17HdFvyA2lKgn60HGjLzQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bzod1wW+vhxcy+JU4YSEO8t6JI/KXEV2eUubGeDJpBujYRNJkb6bxIgdex2KHxf05sUE43ExMDyDcQlQH9hNJWq6Wkm9qeSR9EH4RsaBqJdZQddj7BHzKE8CY0BjO6tx4x9AoCFqch8xZ8g3gIAWBcZwARTWFy1XIMOruJO2a90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rr0WjIqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC510C43390;
	Wed,  7 Feb 2024 09:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707298991;
	bh=rBz0ZwAZn/fuX05TD2o/9u17HdFvyA2lKgn60HGjLzQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Rr0WjIqwWKkXMAj8MPLtyRgEsuKFpcOPImpwtlmcKRaT6LgHvR7IejqHLPxMxw2LA
	 H7jP6h+RrMUibtGEzaHz0TfebbH2rZVovUGkbAxo6xEpZP6CWf7CU9lNN2wuyRzlIr
	 LTKTwVK6TOSH/cuX470mt1ToYC9jK/BY1eLwFpxHGJws1w6qi4QjSEITbG6yMo+O8H
	 2+YjBXGu8rJZA72FXkCOBwEyaqH8c2bZrekk5nOW30L0AR82JI65WHhSCuId/fNuQ0
	 EXELA3/a90JO87R6/6Aalw5H9JldYFH1JH4/9Pk5DaGorhoV+duKfFGcet7dAT39ef
	 W+tga8Ll1WeUQ==
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
Subject: Re: [PATCH v12 18/25] irqchip: Add RISC-V incoming MSI controller
 early driver
In-Reply-To: <20240127161753.114685-19-apatel@ventanamicro.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <20240127161753.114685-19-apatel@ventanamicro.com>
Date: Wed, 07 Feb 2024 10:43:08 +0100
Message-ID: <87il30y5hv.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup Patel <apatel@ventanamicro.com> writes:

> The RISC-V advanced interrupt architecture (AIA) specification
> defines a new MSI controller called incoming message signalled
> interrupt controller (IMSIC) which manages MSI on per-HART (or
> per-CPU) basis. It also supports IPIs as software injected MSIs.
> (For more details refer https://github.com/riscv/riscv-aia)
>
> Let us add an early irqchip driver for RISC-V IMSIC which sets
> up the IMSIC state and provide IPIs.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/irqchip/Kconfig                 |   7 +
>  drivers/irqchip/Makefile                |   1 +
>  drivers/irqchip/irq-riscv-imsic-early.c | 241 +++++++
>  drivers/irqchip/irq-riscv-imsic-state.c | 887 ++++++++++++++++++++++++
>  drivers/irqchip/irq-riscv-imsic-state.h | 105 +++
>  include/linux/irqchip/riscv-imsic.h     |  87 +++
>  6 files changed, 1328 insertions(+)
>  create mode 100644 drivers/irqchip/irq-riscv-imsic-early.c
>  create mode 100644 drivers/irqchip/irq-riscv-imsic-state.c
>  create mode 100644 drivers/irqchip/irq-riscv-imsic-state.h
>  create mode 100644 include/linux/irqchip/riscv-imsic.h
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index f7149d0f3d45..85f86e31c996 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -546,6 +546,13 @@ config SIFIVE_PLIC
>  	select IRQ_DOMAIN_HIERARCHY
>  	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
>=20=20
> +config RISCV_IMSIC
> +	bool
> +	depends on RISCV
> +	select IRQ_DOMAIN_HIERARCHY
> +	select GENERIC_IRQ_MATRIX_ALLOCATOR
> +	select GENERIC_MSI_IRQ
> +
>  config EXYNOS_IRQ_COMBINER
>  	bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
>  	depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index ffd945fe71aa..d714724387ce 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -95,6 +95,7 @@ obj-$(CONFIG_QCOM_MPM)			+=3D irq-qcom-mpm.o
>  obj-$(CONFIG_CSKY_MPINTC)		+=3D irq-csky-mpintc.o
>  obj-$(CONFIG_CSKY_APB_INTC)		+=3D irq-csky-apb-intc.o
>  obj-$(CONFIG_RISCV_INTC)		+=3D irq-riscv-intc.o
> +obj-$(CONFIG_RISCV_IMSIC)		+=3D irq-riscv-imsic-state.o irq-riscv-imsic-=
early.o
>  obj-$(CONFIG_SIFIVE_PLIC)		+=3D irq-sifive-plic.o
>  obj-$(CONFIG_IMX_IRQSTEER)		+=3D irq-imx-irqsteer.o
>  obj-$(CONFIG_IMX_INTMUX)		+=3D irq-imx-intmux.o
> diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/ir=
q-riscv-imsic-early.c
> new file mode 100644
> index 000000000000..3557e32a713c
> --- /dev/null
> +++ b/drivers/irqchip/irq-riscv-imsic-early.c
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> + * Copyright (C) 2022 Ventana Micro Systems Inc.
> + */
> +
> +#define pr_fmt(fmt) "riscv-imsic: " fmt
> +#include <linux/cpu.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/module.h>
> +#include <linux/spinlock.h>
> +#include <linux/smp.h>
> +
> +#include "irq-riscv-imsic-state.h"
> +
> +static int imsic_parent_irq;
> +
> +#ifdef CONFIG_SMP
> +static irqreturn_t imsic_local_sync_handler(int irq, void *data)
> +{
> +	imsic_local_sync();
> +	return IRQ_HANDLED;
> +}
> +
> +static void imsic_ipi_send(unsigned int cpu)
> +{
> +	struct imsic_local_config *local =3D
> +				per_cpu_ptr(imsic->global.local, cpu);
> +
> +	writel_relaxed(IMSIC_IPI_ID, local->msi_va);
> +}
> +
> +static void imsic_ipi_starting_cpu(void)
> +{
> +	/* Enable IPIs for current CPU. */
> +	__imsic_id_set_enable(IMSIC_IPI_ID);
> +
> +	/* Enable virtual IPI used for IMSIC ID synchronization */
> +	enable_percpu_irq(imsic->ipi_virq, 0);
> +}
> +
> +static void imsic_ipi_dying_cpu(void)
> +{
> +	/*
> +	 * Disable virtual IPI used for IMSIC ID synchronization so
> +	 * that we don't receive ID synchronization requests.
> +	 */
> +	disable_percpu_irq(imsic->ipi_virq);
> +}
> +
> +static int __init imsic_ipi_domain_init(void)
> +{
> +	int virq;
> +
> +	/* Create IMSIC IPI multiplexing */
> +	virq =3D ipi_mux_create(IMSIC_NR_IPI, imsic_ipi_send);
> +	if (virq <=3D 0)
> +		return (virq < 0) ? virq : -ENOMEM;
> +	imsic->ipi_virq =3D virq;
> +
> +	/* First vIRQ is used for IMSIC ID synchronization */
> +	virq =3D request_percpu_irq(imsic->ipi_virq, imsic_local_sync_handler,
> +				  "riscv-imsic-lsync", imsic->global.local);

There's a lot of boilerplate for the local-sync IPI. Any reason not to
use what the kernel provides out-of-the-box:

  int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
			     int wait);

e.g.

  smp_call_function_single(target_cpu, imsic_local_sync_with_new_signature,=
 NULL, 0);


Bj=C3=B6rn

