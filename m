Return-Path: <linux-kernel+bounces-76574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF7685F958
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959FC28281F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB645131720;
	Thu, 22 Feb 2024 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LP+bYP4u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1E71350E8;
	Thu, 22 Feb 2024 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607696; cv=none; b=GmmeJR2bN1w6xo80CfsNOIJevuySCVe5SCgVDVMxqc9Ublzt3EO6E6RJ5la3GAI6o4sTsc5+NT8oVJQfgieJZXV5CoDv1sMzKHVWMik5tHkF+iNZ81k7ddvzqKhfskA74am7fc91YUNanLepAS+q5wocS01tcSlvMQvq2WE8pgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607696; c=relaxed/simple;
	bh=RS33a5NAXMYkmcGbonHNshPN7xX7MMKFPNs6Cwp2KpU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m8cHf6IkSihq77zTB9i6gBl+JqPv721WCwEP96u1wcyAgLL+twi0I0WF6BEQBcLmAABX/GdhUNTjSWzNaLzsBQ8nLELPpwKH4Itlrw0Cp4bkkEFZCTD2Y5s7j59IHiuTe33bPjikYwaM3FsWkherYpruVvdEZJ0tsLKuSzTNsFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LP+bYP4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CAAC43390;
	Thu, 22 Feb 2024 13:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708607695;
	bh=RS33a5NAXMYkmcGbonHNshPN7xX7MMKFPNs6Cwp2KpU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LP+bYP4uecGnPP5dkdkYukDVfPWQu8dMR5Jkrs1trXr09+T71XWJ9Mn01c5F/o/Xv
	 F64RIvknhyXCGIFa3lK7RsVyAQiHSiLpdp43kcUNHfbWI6njNz2Rj0FY74Iu8sr7W1
	 QX2+JPEb0Ro1m9xCA/Lx9f7x9BYgYbcb9mgF1xeMmc15QKS4jBXntIzpvWro7H2MkW
	 HdWFX6B0b598v9jWqFV+992oA4904XMhgnMzhsM5LMV3eoGz4vtYmOODe7nS+cisn0
	 4IJs1BYIxbUU9E6D8+o2GKvBkneaFpq3vXHnngjZ96TG1ZmaBaGsU29N4FpiTZfFXK
	 Uo8DErPX+JbDg==
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
Subject: Re: [PATCH v14 13/18] irqchip/riscv-imsic: Add device MSI domain
 support for PCI devices
In-Reply-To: <20240222094006.1030709-14-apatel@ventanamicro.com>
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
 <20240222094006.1030709-14-apatel@ventanamicro.com>
Date: Thu, 22 Feb 2024 14:14:51 +0100
Message-ID: <87msrstzck.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup Patel <apatel@ventanamicro.com> writes:

> The Linux PCI framework supports per-device MSI domains for PCI devices
> so extend the IMSIC driver to allow PCI per-device MSI domains.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/irqchip/Kconfig                    |  7 +++++
>  drivers/irqchip/irq-riscv-imsic-platform.c | 35 ++++++++++++++++++++--
>  2 files changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 85f86e31c996..2fc0cb32341a 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -553,6 +553,13 @@ config RISCV_IMSIC
>  	select GENERIC_IRQ_MATRIX_ALLOCATOR
>  	select GENERIC_MSI_IRQ
>=20=20
> +config RISCV_IMSIC_PCI
> +	bool
> +	depends on RISCV_IMSIC
> +	depends on PCI
> +	depends on PCI_MSI
> +	default RISCV_IMSIC
> +
>  config EXYNOS_IRQ_COMBINER
>  	bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
>  	depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
> diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip=
/irq-riscv-imsic-platform.c
> index e2344fc08dca..90ddcdd0bba5 100644
> --- a/drivers/irqchip/irq-riscv-imsic-platform.c
> +++ b/drivers/irqchip/irq-riscv-imsic-platform.c
> @@ -14,6 +14,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/module.h>
>  #include <linux/msi.h>
> +#include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
>  #include <linux/smp.h>
> @@ -208,6 +209,28 @@ static const struct irq_domain_ops imsic_base_domain=
_ops =3D {
>  #endif
>  };
>=20=20
> +#ifdef CONFIG_RISCV_IMSIC_PCI
> +
> +static void imsic_pci_mask_irq(struct irq_data *d)
> +{
> +	pci_msi_mask_irq(d);
> +	irq_chip_mask_parent(d);
> +}
> +
> +static void imsic_pci_unmask_irq(struct irq_data *d)
> +{
> +	irq_chip_unmask_parent(d);
> +	pci_msi_unmask_irq(d);
> +}
> +
> +#define MATCH_PCI_MSI		BIT(DOMAIN_BUS_PCI_MSI)
> +
> +#else
> +
> +#define MATCH_PCI_MSI		0
> +
> +#endif
> +
>  static bool imsic_init_dev_msi_info(struct device *dev,
>  				    struct irq_domain *domain,
>  				    struct irq_domain *real_parent,
> @@ -231,6 +254,13 @@ static bool imsic_init_dev_msi_info(struct device *d=
ev,
>=20=20
>  	/* Is the target supported? */
>  	switch (info->bus_token) {
> +#ifdef CONFIG_RISCV_IMSIC_PCI
> +	case DOMAIN_BUS_PCI_DEVICE_MSI:
> +	case DOMAIN_BUS_PCI_DEVICE_MSIX:
> +		info->chip->irq_mask =3D imsic_pci_mask_irq;
> +		info->chip->irq_unmask =3D imsic_pci_unmask_irq;

irq_set_affinity()?


Bj=C3=B6rn

