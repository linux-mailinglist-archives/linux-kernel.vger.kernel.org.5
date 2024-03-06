Return-Path: <linux-kernel+bounces-94235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D371E873BCF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038861C239BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872BF1361DC;
	Wed,  6 Mar 2024 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dQoI+oX2"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC53C135A52
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741657; cv=none; b=j2N1velKMgkB+tOaBuGnUNTN6MO6xkEMhSyF02t+kj3VY8xsu6hvlpCrRUTAM4zK8TylyXOwI6vTbINIZccK5fSo1A7Bge3anSZzS9bPMgjt2LJ/77y8/EB20CdCL49CBlPFGAdvD15OGdeJniNS6IQwxHGOeLH+yS+cBzGYNlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741657; c=relaxed/simple;
	bh=FAmUSAr/tUjgOJFJPsKagQNrdFZY+PTJrBMOjrEUAwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+YiIuFG0lplL6YymQMwaXDHeFIO7jqRgkjkOL3mM5c2wMPnJr5Gn1yvyZe3FJ+KDnHgVxCLp78mbsZtfUn5RNJlZ5ZDwI2VboNR+hyEDXSQbSiVaGeOD85+jFOSg94Q3arQXL4U6UVn1+wLSAWmXXMLK6C59lTtiUX6DLnNmL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dQoI+oX2; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d23114b19dso89748521fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 08:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709741654; x=1710346454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTnAQDpq/xXZDrrZFKVdG9h0DRt+PLoYidl8F6FoQRM=;
        b=dQoI+oX2FYrb9jcpiQm1eIHUrS3tYVHX4xOe2M/qG8xeak7Tzr6g4i7C0mUDYAEaR2
         JjOYCwD0xM3a6/XHDOX6GkmTLa6NXWxyBslPQ4G8d0Ygrtq0B1621eLxepHfJ4hqnJdC
         U0g9W0YXuj0GJthNJW+DTOBoE6eIbcyXEXuvb9nK0Fq93qkFAp1u4/aja4tb8Pq4J6qT
         i/V5cME3EQr7H17vxmekDnn4rtngDi74UPxRjkHNk3DErz7F95qj4t3HAsg1cTyLKEzJ
         jYEhZA9Q74toUwx5TpLaqg5b/DIjKiwP6qnBgLei9v82wUg32l4cCpZ6g+uI2lISx1ah
         F3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709741654; x=1710346454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTnAQDpq/xXZDrrZFKVdG9h0DRt+PLoYidl8F6FoQRM=;
        b=HqbprvpocY3+XOw64NCybiIS9YEpudGojGszSgwDmdQyV54fCknyLgSCbPLwHNe1WL
         Ot5m9fnCpovq0MlJuJ8NtRYVMB0M88+EbnZIU9YdncGMK2ABXi9GPluAGfGNz3bLWPlD
         sDZHILhEZ873NI5Ybs9f02X7j489XiPwP6N1wrzk8JVlUvBa9mRHyhD+wdZP25tI/dBk
         nFv0n4miwcK5MRq/3Ux+S+qg3Sw9cLRf/rwHYoKhpMGpUcivxkHmLawZZjnBY4l0jsCQ
         I9RUEpabJXo8mYDgZV1PDm21j10wiyoUU7yO3d6HqsUI7csMs/cRz/sWcErxvxsITU9L
         wn6w==
X-Forwarded-Encrypted: i=1; AJvYcCWzJkyTPiNK8OLtkbyYmTOrVRNkd+JwU122a8Cncmk/Pm1rkDI8XYvQhwBG2RDoiFYcF1gSE6uGeklMB3DBCw455MvGl2cwLixWdnJJ
X-Gm-Message-State: AOJu0YyOo/+DereW3coMv2ycikjfIJGDA9Uz6I63HerSM2uBodsScgTS
	ymiPYs4pabgUL41iOqG6uG4MXPJEMMK9e4Y+MAW6Z3rci5HrBkXaaju4D2Hem5oDMLMFf8L3YjG
	S0/a8Oq3leGa+R94+Ul7rp3GSwE+kp21GL9x1RA==
X-Google-Smtp-Source: AGHT+IELUwkYn/nZDGmR9FqLyW9RWybu2772azYRtKpDnvK+Il12l2oNP+rIy5t2jdacBPwh32NxT8ptyeHUgLVAp1Y=
X-Received: by 2002:a05:6512:402a:b0:513:6f0c:e075 with SMTP id
 br42-20020a056512402a00b005136f0ce075mr694446lfb.24.1709741653768; Wed, 06
 Mar 2024 08:14:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226040746.1396416-1-apatel@ventanamicro.com>
 <20240226040746.1396416-9-apatel@ventanamicro.com> <87y1avbboj.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87y1avbboj.fsf@all.your.base.are.belong.to.us>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 6 Mar 2024 21:44:01 +0530
Message-ID: <CAK9=C2Ud+CJzWfY0Lp97OMt9QvJBFX=hHJidn_90XY5cEB9LHw@mail.gmail.com>
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

On Wed, Mar 6, 2024 at 9:22=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> Anup Patel <apatel@ventanamicro.com> writes:
>
> > diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/ir=
q-riscv-aplic-msi.c
> > new file mode 100644
> > index 000000000000..b2a25e011bb2
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-riscv-aplic-msi.c
> > +static void aplic_msi_write_msg(struct irq_data *d, struct msi_msg *ms=
g)
> > +{
> > +     unsigned int group_index, hart_index, guest_index, val;
> > +     struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> > +     struct aplic_msicfg *mc =3D &priv->msicfg;
> > +     phys_addr_t tppn, tbppn, msg_addr;
> > +     void __iomem *target;
> > +
> > +     /* For zeroed MSI, simply write zero into the target register */
> > +     if (!msg->address_hi && !msg->address_lo && !msg->data) {
> > +             target =3D priv->regs + APLIC_TARGET_BASE;
> > +             target +=3D (d->hwirq - 1) * sizeof(u32);
> > +             writel(0, target);
>
> Is the fence needed here (writel_relaxed())...

The pci_write_msg_msix() (called via pci_msi_domain_write_msg())
uses writel() hence taking inspiration from that we use writel() over here
as well.

If that's wrong then pci_write_msg_msix() must be fixed as well.

>
> > +             return;
> > +     }
> > +
> > +     /* Sanity check on message data */
> > +     WARN_ON(msg->data > APLIC_TARGET_EIID_MASK);
> > +
> > +     /* Compute target MSI address */
> > +     msg_addr =3D (((u64)msg->address_hi) << 32) | msg->address_lo;
> > +     tppn =3D msg_addr >> APLIC_xMSICFGADDR_PPN_SHIFT;
> > +
> > +     /* Compute target HART Base PPN */
> > +     tbppn =3D tppn;
> > +     tbppn &=3D ~APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
> > +     tbppn &=3D ~APLIC_xMSICFGADDR_PPN_LHX(mc->lhxw, mc->lhxs);
> > +     tbppn &=3D ~APLIC_xMSICFGADDR_PPN_HHX(mc->hhxw, mc->hhxs);
> > +     WARN_ON(tbppn !=3D mc->base_ppn);
> > +
> > +     /* Compute target group and hart indexes */
> > +     group_index =3D (tppn >> APLIC_xMSICFGADDR_PPN_HHX_SHIFT(mc->hhxs=
)) &
> > +                  APLIC_xMSICFGADDR_PPN_HHX_MASK(mc->hhxw);
> > +     hart_index =3D (tppn >> APLIC_xMSICFGADDR_PPN_LHX_SHIFT(mc->lhxs)=
) &
> > +                  APLIC_xMSICFGADDR_PPN_LHX_MASK(mc->lhxw);
> > +     hart_index |=3D (group_index << mc->lhxw);
> > +     WARN_ON(hart_index > APLIC_TARGET_HART_IDX_MASK);
> > +
> > +     /* Compute target guest index */
> > +     guest_index =3D tppn & APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
> > +     WARN_ON(guest_index > APLIC_TARGET_GUEST_IDX_MASK);
> > +
> > +     /* Update IRQ TARGET register */
> > +     target =3D priv->regs + APLIC_TARGET_BASE;
> > +     target +=3D (d->hwirq - 1) * sizeof(u32);
> > +     val =3D FIELD_PREP(APLIC_TARGET_HART_IDX, hart_index);
> > +     val |=3D FIELD_PREP(APLIC_TARGET_GUEST_IDX, guest_index);
> > +     val |=3D FIELD_PREP(APLIC_TARGET_EIID, msg->data);
> > +     writel(val, target);
>
> ...and here?

Same as above.

Regards,
Anup

