Return-Path: <linux-kernel+bounces-95784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71AE875291
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689F61F24E2D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E3E12E1FE;
	Thu,  7 Mar 2024 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUxYiWnE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350981EB2B;
	Thu,  7 Mar 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823674; cv=none; b=GM2F+R0OJYdNcxUd3pkL64m1I/EgQ2Y/7V6Ht2I2L0QgeQ+54+1gnzpYfHIywuNS67BJL5gW6a7fH9Zits6+CgU6iJE5HbWc2pZPua0Pk3SzKBLuHKG2kT/AEZ0USP9k2FB0JEN5wy8jZSd8WkzUDNA1M7w3cxUApCm3JAHK7yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823674; c=relaxed/simple;
	bh=pQOSBvGr2PdFDDcAF4v1xGbCwkIdtH4hpyIk5PVZU7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TSy/C+wEpqHPhx7ZRFm0jErwRzcHhZU3+/JNERRX5lTAnw2Uro2vnY3886h+GnsVAu2qaLZxkAdOZNsCg2wGHfBFzXTwoUuAVH/B9owMAh5TLTb93qrdHOvhvGMnpZWQIplW7M4XPyMtz3n2Ih60jcT64qZx9FpzSAQGwLBGmlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUxYiWnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BC8C433F1;
	Thu,  7 Mar 2024 15:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709823673;
	bh=pQOSBvGr2PdFDDcAF4v1xGbCwkIdtH4hpyIk5PVZU7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uUxYiWnEqKVWLcW0IYvhhO3XJxsl7pxYgIiOF+omyTeO5SHAB42GvaEVHrOoaYYid
	 +wfamRpY9Mr6uApWQtRsatDqM5l8+PXB9JJ1/ZKpSXYHrWOdoTS2OSM8+QmIAJ9xVL
	 UkCVhYw9I45iHVOLFJ25RS/tfKw1XfxhftVbDPe7lm+IF8PO8tDl1xhid5GFtZlYKA
	 sLm91iv2OEkV6ZOGRv4wxmUAwy96yueck46fIhF0DmGkKs2HmHJ6BQ4DC4bX6WvdOH
	 MHCGvJmkaCJXuyVkVS296MbkWwqSwxmf8pMecOByqUTI53At6eW0lTr0/unP3HXKrx
	 76GZYQ84e70jQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, Saravana Kannan <saravanak@google.com>, Marc
 Zyngier <maz@kernel.org>, Anup Patel <anup@brainfault.org>,
 linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v15 08/10] irqchip/riscv-aplic: Add support for MSI-mode
In-Reply-To: <CAK9=C2Ud+CJzWfY0Lp97OMt9QvJBFX=hHJidn_90XY5cEB9LHw@mail.gmail.com>
References: <20240226040746.1396416-1-apatel@ventanamicro.com>
 <20240226040746.1396416-9-apatel@ventanamicro.com>
 <87y1avbboj.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2Ud+CJzWfY0Lp97OMt9QvJBFX=hHJidn_90XY5cEB9LHw@mail.gmail.com>
Date: Thu, 07 Mar 2024 16:01:09 +0100
Message-ID: <871q8mdr2i.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup Patel <apatel@ventanamicro.com> writes:

> On Wed, Mar 6, 2024 at 9:22=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
>>
>> Anup Patel <apatel@ventanamicro.com> writes:
>>
>> > diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/i=
rq-riscv-aplic-msi.c
>> > new file mode 100644
>> > index 000000000000..b2a25e011bb2
>> > --- /dev/null
>> > +++ b/drivers/irqchip/irq-riscv-aplic-msi.c
>> > +static void aplic_msi_write_msg(struct irq_data *d, struct msi_msg *m=
sg)
>> > +{
>> > +     unsigned int group_index, hart_index, guest_index, val;
>> > +     struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
>> > +     struct aplic_msicfg *mc =3D &priv->msicfg;
>> > +     phys_addr_t tppn, tbppn, msg_addr;
>> > +     void __iomem *target;
>> > +
>> > +     /* For zeroed MSI, simply write zero into the target register */
>> > +     if (!msg->address_hi && !msg->address_lo && !msg->data) {
>> > +             target =3D priv->regs + APLIC_TARGET_BASE;
>> > +             target +=3D (d->hwirq - 1) * sizeof(u32);
>> > +             writel(0, target);
>>
>> Is the fence needed here (writel_relaxed())...
>
> The pci_write_msg_msix() (called via pci_msi_domain_write_msg())
> uses writel() hence taking inspiration from that we use writel() over here
> as well.
>
> If that's wrong then pci_write_msg_msix() must be fixed as well.

Huh? The writel()s in pci_write_msg_msix() are because there's an
ordering constraint, and code would be broken w/o it. My question was
"what are the ordering constraints for this piece of code", because it
looks like this is a single I/O write without any ordering constraints.

I'm not a fan of sprinkling fences around "to be safe", but I don't want
to delay the v16 because of it. It can be fixed later, if it's not
needed.


Cheers, and thanks for your hard work!
Bj=C3=B6rn

