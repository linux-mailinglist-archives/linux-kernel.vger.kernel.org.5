Return-Path: <linux-kernel+bounces-94195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D782873B33
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0801C20A73
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2C81361DC;
	Wed,  6 Mar 2024 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiaraTxC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056FB131742;
	Wed,  6 Mar 2024 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740323; cv=none; b=teX7I/1Q5p4pgAq1DETFknudWq2A/6J2mQDAd0ZXEF5bpNuwf4TyyIBrtyU4ysbQaaMOE9oAOw+xwXhPm97DTCcUOmP82Z5rwfQvmibiRQwzVbp1FmsoQqgUNpkPpZkndkIkFb4gop55xb5n8hx2jU9OlAMFdzv5xfW3IJdjfC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740323; c=relaxed/simple;
	bh=jZtqjcc68teaxGW7BSP8LVZ6Tdy5taDJ5nwTMZlZ+/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WP7BgK+qkaTEATqdv76raNN/cyMXMiyOik8ysyscBhUKrYAVdCQLPjIEnBIJw2g7gIwKPCGCFau/DvAiBGs+8cYkAcjNCJm7F9jZ2RPX7h8xObQvjVya8AlmsZCqccdyEJ9TCyXnGUzyDLsF5XXB3GQk6M8l1AveVqZ+AIIpjvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiaraTxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DF2C43394;
	Wed,  6 Mar 2024 15:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709740322;
	bh=jZtqjcc68teaxGW7BSP8LVZ6Tdy5taDJ5nwTMZlZ+/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YiaraTxCYX+sh145ycLJRCrfAXHa6UY5RzGXxeOI2u4pNbnKN3EXM2agofesj++8p
	 9A5BxVuBz+tX6RKj9ZzXZez63QQV5zX3qVef6cVDps63BmqndBBoBWN5MQQMYAFhfl
	 BvyydWoIt27qJE3CH2suIykw+jMx2pPk/cpIUZLrbE0z+j05MSIXhz8drVO+K+Wca9
	 c4sDa+B+tOzEaCMJr5k/BpNbE7HdxrlD3BTFznFAWXNZ/in6zjfr+7VYyr2lVjaKVJ
	 cRFJuK/7HHfHZbgyCTLsX8ZZRRBWln1cqdlx+Y1ghlC+rlKvIwU27JWnnOUugX6vCF
	 yUXWQde6Y6YDw==
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
Subject: Re: [PATCH v15 08/10] irqchip/riscv-aplic: Add support for MSI-mode
In-Reply-To: <20240226040746.1396416-9-apatel@ventanamicro.com>
References: <20240226040746.1396416-1-apatel@ventanamicro.com>
 <20240226040746.1396416-9-apatel@ventanamicro.com>
Date: Wed, 06 Mar 2024 16:51:56 +0100
Message-ID: <87y1avbboj.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup Patel <apatel@ventanamicro.com> writes:

> diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-=
riscv-aplic-msi.c
> new file mode 100644
> index 000000000000..b2a25e011bb2
> --- /dev/null
> +++ b/drivers/irqchip/irq-riscv-aplic-msi.c
> +static void aplic_msi_write_msg(struct irq_data *d, struct msi_msg *msg)
> +{
> +	unsigned int group_index, hart_index, guest_index, val;
> +	struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> +	struct aplic_msicfg *mc =3D &priv->msicfg;
> +	phys_addr_t tppn, tbppn, msg_addr;
> +	void __iomem *target;
> +
> +	/* For zeroed MSI, simply write zero into the target register */
> +	if (!msg->address_hi && !msg->address_lo && !msg->data) {
> +		target =3D priv->regs + APLIC_TARGET_BASE;
> +		target +=3D (d->hwirq - 1) * sizeof(u32);
> +		writel(0, target);

Is the fence needed here (writel_relaxed())...

> +		return;
> +	}
> +
> +	/* Sanity check on message data */
> +	WARN_ON(msg->data > APLIC_TARGET_EIID_MASK);
> +
> +	/* Compute target MSI address */
> +	msg_addr =3D (((u64)msg->address_hi) << 32) | msg->address_lo;
> +	tppn =3D msg_addr >> APLIC_xMSICFGADDR_PPN_SHIFT;
> +
> +	/* Compute target HART Base PPN */
> +	tbppn =3D tppn;
> +	tbppn &=3D ~APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
> +	tbppn &=3D ~APLIC_xMSICFGADDR_PPN_LHX(mc->lhxw, mc->lhxs);
> +	tbppn &=3D ~APLIC_xMSICFGADDR_PPN_HHX(mc->hhxw, mc->hhxs);
> +	WARN_ON(tbppn !=3D mc->base_ppn);
> +
> +	/* Compute target group and hart indexes */
> +	group_index =3D (tppn >> APLIC_xMSICFGADDR_PPN_HHX_SHIFT(mc->hhxs)) &
> +		     APLIC_xMSICFGADDR_PPN_HHX_MASK(mc->hhxw);
> +	hart_index =3D (tppn >> APLIC_xMSICFGADDR_PPN_LHX_SHIFT(mc->lhxs)) &
> +		     APLIC_xMSICFGADDR_PPN_LHX_MASK(mc->lhxw);
> +	hart_index |=3D (group_index << mc->lhxw);
> +	WARN_ON(hart_index > APLIC_TARGET_HART_IDX_MASK);
> +
> +	/* Compute target guest index */
> +	guest_index =3D tppn & APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
> +	WARN_ON(guest_index > APLIC_TARGET_GUEST_IDX_MASK);
> +
> +	/* Update IRQ TARGET register */
> +	target =3D priv->regs + APLIC_TARGET_BASE;
> +	target +=3D (d->hwirq - 1) * sizeof(u32);
> +	val =3D FIELD_PREP(APLIC_TARGET_HART_IDX, hart_index);
> +	val |=3D FIELD_PREP(APLIC_TARGET_GUEST_IDX, guest_index);
> +	val |=3D FIELD_PREP(APLIC_TARGET_EIID, msg->data);
> +	writel(val, target);

..and here?


Bj=C3=B6rn

