Return-Path: <linux-kernel+bounces-76576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A0385F966
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C563628694B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D0D1332B3;
	Thu, 22 Feb 2024 13:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbwSqzTB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F365312E1D3;
	Thu, 22 Feb 2024 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607723; cv=none; b=N3qvZCxuEvRDXxj14CKtRJ7s9tKdtdUU8+CnaWVet1r5v0oDI+NSpvg+qbH9125YvmuB0nU62wMuSRrJC6zHRGwBKOv8l5jj8mHrD/RlepKH2oQ95TJAim3rAMmdHXocM0l5ZhqkSIO6d8YW+E6DN4N8CR0eZ9CqHWr8XoA+AI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607723; c=relaxed/simple;
	bh=UEVsSZcGmV67zShBBFj0j5CNp24EUBflBXO5GRus0Ec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oQfNsfA7xkq//Ok23fpF3HfsCVn7dlnnjqhccTBEYyXTmsIytn0voH2Eu6DEFS1miJi4PpnZPj/m+LfRqgCkQ/5RXDz6t+BpHST3Ya+faGvjyeanDUfTzklz8UDE6UIbmG9GB7WCJ/FY9xGQeeapHUKBi4iCSh6fZKvTzCU5eAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbwSqzTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24331C43390;
	Thu, 22 Feb 2024 13:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708607722;
	bh=UEVsSZcGmV67zShBBFj0j5CNp24EUBflBXO5GRus0Ec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sbwSqzTBz+kazip5qwYb+U1jMEnSqGzy5vHiXeKWKcWlRSgm8X8DNJ+PKwtj8Ztoe
	 qz7KBevpyREnT4+f44BDEwa58ymwlnjcLgM7SJuziRwmnI4xxQA+PlbTH6CLxI0y57
	 lD0P9DdG2UgCQpqWWmPO1lpDYV2sc8g6caiaOTA0ZcpBPKOVAjavq6XVmoJr47Mky9
	 OD/L4VncVcJvkD+jZhTgl4ko6IvJjrtMOOH8k8zO8pqh8Zr6AMTF7UPgMYNQs8w2BY
	 grNCBSSSWkwcrVpm8rWaj9jPDJ+7W8dxYhTDoKot8c1c/UZTgXAMK2Zus0i/q5s8IE
	 O2f8ff7S9Et3w==
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
Subject: Re: [PATCH v14 12/18] irqchip/riscv-imsic: Add device MSI domain
 support for platform devices
In-Reply-To: <20240222094006.1030709-13-apatel@ventanamicro.com>
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
 <20240222094006.1030709-13-apatel@ventanamicro.com>
Date: Thu, 22 Feb 2024 14:15:19 +0100
Message-ID: <87jzmwtzbs.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup Patel <apatel@ventanamicro.com> writes:

> The Linux platform MSI support allows per-device MSI domains so add
> a platform irqchip driver for RISC-V IMSIC which provides a base IRQ
> domain with MSI parent support for platform device domains.
>
> The IMSIC platform driver assumes that the IMSIC state is already
> initialized by the IMSIC early driver.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/irqchip/Makefile                   |   2 +-
>  drivers/irqchip/irq-riscv-imsic-platform.c | 344 +++++++++++++++++++++
>  drivers/irqchip/irq-riscv-imsic-state.h    |   1 +
>  3 files changed, 346 insertions(+), 1 deletion(-)
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
> index 000000000000..e2344fc08dca
> --- /dev/null
> +++ b/drivers/irqchip/irq-riscv-imsic-platform.c
> @@ -0,0 +1,344 @@
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

Nit: And one more redundant parenthesis and 100 char! ;-)


Bj=C3=B6rn

