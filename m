Return-Path: <linux-kernel+bounces-95813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D87875319
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5898E1C21D2C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DCD12F36E;
	Thu,  7 Mar 2024 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="UWgxLFyk"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786B012EBED
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709825137; cv=none; b=rDNTLScUYfq/Ri0FD5U1tZ1xUhKeK9vu5RePY3UZ/amizW5Pj2650McaUKbt8YuoMXOcqm6Yt8pZQqQw7oclhtPwX79X2sSNPlNTHveX4ZK71XMNMBc15khr04vrCG+XpM9hgUKudXwieccU41iKU9GWaJH+OHvxodVCRa4D/8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709825137; c=relaxed/simple;
	bh=V3t0OdhwzeOqBPCUhhWQ5AavYAM/iLtG7e8pxD9IM14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNZGMghW2Lwo7F9Izx1FwU5ghowMOYDHhozajibGpV4vbe2wXupov7ii4p7PzUnYfBBOTiy+VvNtx1xT2T6CAgbtxTuZC4SQ42chiFfw/wkkULrcHhn5QFwizhacX3fI5z4PtS+P4lU7takWfQSWw5RHbwi+hb/mpnWl+Ujo4QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=UWgxLFyk; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d09cf00214so13249761fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 07:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709825133; x=1710429933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4QjOqiWioy7Z+s/XLgIt5Rc6ziLvdsXpnYEthSWbOk=;
        b=UWgxLFyk233ErdkJz4VNymkf2ST0jaw/fcRiyGFk5ELR3fOG7KRdx4H/asIZx2pex9
         jqvCzy2+4R1ut5BY61PEvqGd0xGdJSPKJAcSVhWykUzQOM1n4gIyg1aGR3k0pHLBBhoe
         S7izLgeJK5jaDXrbb5WYfRcnVd5IKJHrtisLx5bx9WzzLul6c/dZQKzRPD239ODRsJ9t
         L43fuQko+3r0H8dQ5Mr1pPDhetOoEx+qp93vhCYcTL+s8PWIOQOB2EPpM6sA6cTthpe1
         Ua3U+nt13rWC391zgA1mq9zGJtyjHkeWPpE4yyICY+fdvHv+U35DchKS9KYcMx/+vvKT
         T4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709825133; x=1710429933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4QjOqiWioy7Z+s/XLgIt5Rc6ziLvdsXpnYEthSWbOk=;
        b=TKV9cqqB0thrjAFUCNpqMcx9YQ9AhCURKLdicBImYsh6uNZQ0/+rkHI12KVnUtG90a
         t3oPILy+E+1+wrn9/IhvXN9VAgrbqYyhMT4D/cNXaodHxe4jc6nVYYVosV3Qd2LfeF9w
         g27wBcUhqtecXSNHGAnKqWNvVL42akFTte3TNkNFpwAnJLzW0WXcH5Zhu5sPlcJgex83
         9ohsi9vMlgkXWsHN/I717ZlVn771zWNq8tnGraQrQb6OBk2uvVbtUVaP3LEGqj6VJx4O
         9iatbkGUVIpR96DXuYEKAM+vsCESR+iQQPf6NJTm7jdDM+ZZUSsn9orP/BbN3FkqTUUB
         I0bA==
X-Forwarded-Encrypted: i=1; AJvYcCUwAsKL0nfqMQFPqOUWqV9RmCbjIpweup2tlg2KesOZ1McpXRdKOhESnzVPsiuZErzO4Ad2JtObLYyg4bNbLmn6kVg12IJRNYf+VDS9
X-Gm-Message-State: AOJu0YyBvk/gUYNYP10Aaxp0M6oXuxFsauOTOdL1XYU5QXOQ23oHluor
	yFC/yjZ+wrH2QfkrcIxpDgF8rz1rUve3CGI9QKts00DBwKHqPRFqZlItEbW22kc5VZfYCAShe1e
	jeK7FMGKZVXvqicPgkHfpp99Lzj4Pw0y3ltbz/n67CvAjAs1SR5mJNw==
X-Google-Smtp-Source: AGHT+IHni8UYaPdT07e1XtlA0mP9S9vuUEv4b9Fh2GsvReSwDcrJOqBGXFRA8/BIJlLaDhNaDP/WuGDOz3ZpmDlzkRU=
X-Received: by 2002:a05:6512:20c9:b0:513:ece:1fe1 with SMTP id
 u9-20020a05651220c900b005130ece1fe1mr1477863lfr.54.1709825133335; Thu, 07 Mar
 2024 07:25:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226040746.1396416-1-apatel@ventanamicro.com>
 <20240226040746.1396416-9-apatel@ventanamicro.com> <87y1avbboj.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2Ud+CJzWfY0Lp97OMt9QvJBFX=hHJidn_90XY5cEB9LHw@mail.gmail.com> <871q8mdr2i.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <871q8mdr2i.fsf@all.your.base.are.belong.to.us>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 7 Mar 2024 20:55:21 +0530
Message-ID: <CAK9=C2UfpTtQ6DOSE7-EVsC+zyYAY6CvigQ6iDLuLgQNj2e5vw@mail.gmail.com>
Subject: Re: [PATCH v15 08/10] irqchip/riscv-aplic: Add support for MSI-mode
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>, Anup Patel <anup@brainfault.org>, 
	linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 8:31=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> Anup Patel <apatel@ventanamicro.com> writes:
>
> > On Wed, Mar 6, 2024 at 9:22=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@ker=
nel.org> wrote:
> >>
> >> Anup Patel <apatel@ventanamicro.com> writes:
> >>
> >> > diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip=
/irq-riscv-aplic-msi.c
> >> > new file mode 100644
> >> > index 000000000000..b2a25e011bb2
> >> > --- /dev/null
> >> > +++ b/drivers/irqchip/irq-riscv-aplic-msi.c
> >> > +static void aplic_msi_write_msg(struct irq_data *d, struct msi_msg =
*msg)
> >> > +{
> >> > +     unsigned int group_index, hart_index, guest_index, val;
> >> > +     struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> >> > +     struct aplic_msicfg *mc =3D &priv->msicfg;
> >> > +     phys_addr_t tppn, tbppn, msg_addr;
> >> > +     void __iomem *target;
> >> > +
> >> > +     /* For zeroed MSI, simply write zero into the target register =
*/
> >> > +     if (!msg->address_hi && !msg->address_lo && !msg->data) {
> >> > +             target =3D priv->regs + APLIC_TARGET_BASE;
> >> > +             target +=3D (d->hwirq - 1) * sizeof(u32);
> >> > +             writel(0, target);
> >>
> >> Is the fence needed here (writel_relaxed())...
> >
> > The pci_write_msg_msix() (called via pci_msi_domain_write_msg())
> > uses writel() hence taking inspiration from that we use writel() over h=
ere
> > as well.
> >
> > If that's wrong then pci_write_msg_msix() must be fixed as well.
>
> Huh? The writel()s in pci_write_msg_msix() are because there's an
> ordering constraint, and code would be broken w/o it. My question was
> "what are the ordering constraints for this piece of code", because it
> looks like this is a single I/O write without any ordering constraints.

Whatever ordering constraints apply to pci_write_msg_msix() also
apply to APLIC MSI-mode because both create the leaf-level IRQ
domain for the client device driver (PCIe or Platform device) whose
parent is IMSIC base domain.

>
> I'm not a fan of sprinkling fences around "to be safe", but I don't want
> to delay the v16 because of it. It can be fixed later, if it's not
> needed.

I don't think there is a clear way of proving that using write_relaxed()
in aplic_msi_write_msg() is safe considering there is a vast variety
of platform drivers who would be clients of the APLIC MSI-mode
domain.

I agree that we should deal with this later.

Regards,
Anup

