Return-Path: <linux-kernel+bounces-131501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB018988C2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D6428AD0F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D75127B40;
	Thu,  4 Apr 2024 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsEGF5h7"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF48823C3;
	Thu,  4 Apr 2024 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237237; cv=none; b=ceams4HAFBIJcg8r3JmuWNg6a3qC/oeaDea4sJAU6MC9yqcurs4bg9D2MoGuXqusHVmZd2lgT5/LEdYojD86pkqwA0zBJ8qd2ELIHou7F10QgXK5L+8kUmneVstMWZwjQEiW7VXWm/Y0yfsDqbzK/UsGoR/MJTGivCstF88s0dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237237; c=relaxed/simple;
	bh=1qXkDTjaRGuPOqwUSYGvh4n2cCstyi217veqhe4U4xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScSYjZnAP41xqYI58KMTkpp4Nen668I3pAFZPmU3hxYCeOe+9ikyNBtTcGEE1H1/JDlMWE9q3vAiWpgj3McFpNOTUTLiSZ3NinZcO2WJrArnoKWcCcHfEGOe2VVCPlLzbB9CmftQPWjXmIeVAAnQcOVzghrpss4j84kW5oIGP4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsEGF5h7; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4d47000f875so380266e0c.2;
        Thu, 04 Apr 2024 06:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712237234; x=1712842034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOAPkj/U0XNzKbo2R0Kvsb/R9FYbjjj0yGARnu74um0=;
        b=VsEGF5h7UI4K3I/Lb9uqbIVMtZT1H55lImbHwFF0C+4LyK8NhczZ/z5O2vUf9t8l36
         ozXpiMM/8+y3U/RjdXucm0bnldvv5gwLwnyvx1/yXaOoqFVafU53op6VsD1lKMwNqnbr
         UPZtwNos1gREI0yX9cLGcgofgr+lOPAP70QCfoTJPaHiitpWRjYcK1oCD/UKFuLEPZHX
         kgEQ2f1i88RcyvkWYmN21xNTmEEoEp9QwetbdwX2hPwh4DVhe/dIdDXvwsoIPeoDGAL4
         Duu3tvvQaNWybCJXv81j9HzuUNkZNfTjwoppOT9AhmhKMT50/17pBPDnPfVrjMSa8jH2
         j7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712237234; x=1712842034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOAPkj/U0XNzKbo2R0Kvsb/R9FYbjjj0yGARnu74um0=;
        b=kKmzCQkNqV79nXnzCqm6RAYgdU14+35/9js81VYrDi0sff02uBiko8qYbZeDjw2Kwm
         BK1ZO+j2Od05kgSBF08Ss0ozWM8uSFiGJJm/hc2+H6/tGGvNZYhxFgpM/F9GfznLMhTk
         C9tWohj9j/zdQ+APcTlKvZ0npTudxCp5ohUOhJcc1FWEdQ0+3cVTXCU3B9mnZgOcciY/
         qKdGruTz7A3TpF2Q0roYpqEiQig6DyX5SKZeKqDWFh+SleXabIaS7q/v5iWm5ghAvVBM
         e8tFLDygz3Vv/TfbGGHRAQSPnmyhAq75qjO3OkhpZ3pxJha3bgu9G5OLYDHfqxOc+qvh
         ASgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp47H/K1FxYzGpW9Su4jfw/w/jwQQKrg5qeBuwUYy/PwUoPs4fPDck+OLc5EapijsVy8VD8kB7bSGdTZ0KbN4+YeIwDDlFHeVOyAls+Lt/inGA5JOLHYy6wz7Rr9Ve6K4ce8MyOGeRzWwGisnE/l9N/2qMkA/l81nSzEjeuJ5y9m7Z0e/+HKMypze+
X-Gm-Message-State: AOJu0YwovmQvUaChzpi+N71FQpvFTCTtFx/XqlJGe/kBgPP49yMVT2ex
	s1wJDpamaCXrJh6cu5B+jmtlLMvYvIui8pyVXaNeDAU9REcPnOrYc6mL0EG1NhMoPdXfyRwSmRS
	o5nXC4wluunlp9+V7RZQm9h2ZSzM=
X-Google-Smtp-Source: AGHT+IHjD8w6nMznGRz8FddfsDXeW32imaJfiJb4Ayz+p9rRRARSuReSrGfOoJELqWqa7oMU0D1Le7NcIjcyqiXRyjs=
X-Received: by 2002:a05:6122:3c0b:b0:4ca:80c5:7544 with SMTP id
 fu11-20020a0561223c0b00b004ca80c57544mr1889997vkb.4.1712237234374; Thu, 04
 Apr 2024 06:27:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240403203503.634465-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <OSAPR01MB1587ED05696A111612424CF6863C2@OSAPR01MB1587.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB1587ED05696A111612424CF6863C2@OSAPR01MB1587.jpnprd01.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 4 Apr 2024 14:26:48 +0100
Message-ID: <CA+V-a8s94e9PLuLipQo+rGZ8g7UHxZJJAZZgvL3PQ4b8PKR2Xw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] irqchip/renesas-rzg2l: Add support for RZ/Five SoC
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Biju,

Thank you for the review.

On Thu, Apr 4, 2024 at 8:44=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.com=
> wrote:
>
> Hi Prabhakar,
>
> Thanks for the patch.
>
> > -----Original Message-----
> > From: Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: Wednesday, April 3, 2024 9:35 PM
> > Subject: [PATCH v2 2/5] irqchip/renesas-rzg2l: Add support for RZ/Five =
SoC
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > The IX45 block has additional mask registers (NMSK/IMSK/TMSK) as compar=
ed to the RZ/G2L (family)
> > SoC.
> >
> > Introduce masking/unmasking support for IRQ and TINT interrupts in IRQC=
 controller driver. Two new
> > registers, IMSK and TMSK, are defined to handle masking on RZ/Five SoC.=
 The implementation utilizes
> > a new data structure, `struct rzg2l_irqc_data`, to determine mask suppo=
rt for a specific controller
> > instance.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > - Added IRQCHIP_MATCH() for RZ/Five
> > - Retaining a copy of OF data in priv
> > - Rebased the changes
> > ---
> >  drivers/irqchip/irq-renesas-rzg2l.c | 137 +++++++++++++++++++++++++++-
> >  1 file changed, 132 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-=
renesas-rzg2l.c
> > index f6484bf15e0b..6fa8d65605dc 100644
> > --- a/drivers/irqchip/irq-renesas-rzg2l.c
> > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > @@ -37,6 +37,8 @@
> >  #define TSSEL_SHIFT(n)                       (8 * (n))
> >  #define TSSEL_MASK                   GENMASK(7, 0)
> >  #define IRQ_MASK                     0x3
> > +#define IMSK                         0x10010
> > +#define TMSK                         0x10020
> >
> >  #define TSSR_OFFSET(n)                       ((n) % 4)
> >  #define TSSR_INDEX(n)                        ((n) / 4)
> > @@ -66,15 +68,25 @@ struct rzg2l_irqc_reg_cache {
> >       u32     titsr[2];
> >  };
> >
> > +/**
> > + * struct rzg2l_irqc_of_data - OF data structure
> > + * @mask_supported: Indicates if mask registers are available  */
> > +struct rzg2l_irqc_of_data {
> > +     bool    mask_supported;
> > +};
> > +
> >  /**
> >   * struct rzg2l_irqc_priv - IRQ controller private data structure
> >   * @base:    Controller's base address
> > + * @data:    OF data pointer
> >   * @fwspec:  IRQ firmware specific data
> >   * @lock:    Lock to serialize access to hardware registers
> >   * @cache:   Registers cache for suspend/resume
> >   */
> >  static struct rzg2l_irqc_priv {
> >       void __iomem                    *base;
> > +     const struct rzg2l_irqc_of_data *data;
> >       struct irq_fwspec               fwspec[IRQC_NUM_IRQ];
> >       raw_spinlock_t                  lock;
> >       struct rzg2l_irqc_reg_cache     cache;
> > @@ -138,18 +150,102 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
> >       irq_chip_eoi_parent(d);
> >  }
> >
> > +static void rzg2l_irqc_mask_irq_interrupt(struct rzg2l_irqc_priv *priv=
,
> > +                                       unsigned int hwirq)
> > +{
> > +     u32 imsk =3D readl_relaxed(priv->base + IMSK);
> > +     u32 bit =3D BIT(hwirq - IRQC_IRQ_START);
> > +
> > +     writel_relaxed(imsk | bit, priv->base + IMSK); }
> > +
> > +static void rzg2l_irqc_unmask_irq_interrupt(struct rzg2l_irqc_priv *pr=
iv,
> > +                                         unsigned int hwirq)
> > +{
> > +     u32 imsk =3D readl_relaxed(priv->base + IMSK);
> > +     u32 bit =3D BIT(hwirq - IRQC_IRQ_START);
> > +
> > +     writel_relaxed(imsk & ~bit, priv->base + IMSK); }
> > +
> > +static void rzg2l_irqc_mask_tint_interrupt(struct rzg2l_irqc_priv *pri=
v,
> > +                                        unsigned int hwirq)
> > +{
> > +     u32 tmsk =3D readl_relaxed(priv->base + TMSK);
> > +     u32 bit =3D BIT(hwirq - IRQC_TINT_START);
> > +
> > +     writel_relaxed(tmsk | bit, priv->base + TMSK); }
> > +
> > +static void rzg2l_irqc_unmask_tint_interrupt(struct rzg2l_irqc_priv *p=
riv,
> > +                                          unsigned int hwirq)
> > +{
> > +     u32 tmsk =3D readl_relaxed(priv->base + TMSK);
> > +     u32 bit =3D BIT(hwirq - IRQC_TINT_START);
> > +
> > +     writel_relaxed(tmsk & ~bit, priv->base + TMSK); }
> > +
> > +/* Must be called while priv->lock is held */ static void
> > +rzg2l_irqc_mask_once(struct rzg2l_irqc_priv *priv, unsigned int hwirq)
> > +{
> > +     if (!priv->data->mask_supported)
> > +             return;
> > +
> > +     if (hwirq >=3D IRQC_IRQ_START && hwirq <=3D IRQC_IRQ_COUNT)
> > +             rzg2l_irqc_mask_irq_interrupt(priv, hwirq);
> > +     else if (hwirq >=3D IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
> > +             rzg2l_irqc_mask_tint_interrupt(priv, hwirq); }
> > +
> > +static void rzg2l_irqc_mask(struct irq_data *d) {
> > +     struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > +
> > +     raw_spin_lock(&priv->lock);
> > +     rzg2l_irqc_mask_once(priv, irqd_to_hwirq(d));
> > +     raw_spin_unlock(&priv->lock);
> > +     irq_chip_mask_parent(d);
> > +}
> > +
> > +/* Must be called while priv->lock is held */ static void
> > +rzg2l_irqc_unmask_once(struct rzg2l_irqc_priv *priv, unsigned int
> > +hwirq) {
> > +     if (!priv->data->mask_supported)
> > +             return;
> > +
> > +     if (hwirq >=3D IRQC_IRQ_START && hwirq <=3D IRQC_IRQ_COUNT)
> > +             rzg2l_irqc_unmask_irq_interrupt(priv, hwirq);
> > +     else if (hwirq >=3D IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
> > +             rzg2l_irqc_unmask_tint_interrupt(priv, hwirq); }
> > +
> > +static void rzg2l_irqc_unmask(struct irq_data *d) {
> > +     struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > +
> > +     raw_spin_lock(&priv->lock);
> > +     rzg2l_irqc_unmask_once(priv, irqd_to_hwirq(d));
> > +     raw_spin_unlock(&priv->lock);
> > +     irq_chip_unmask_parent(d);
> > +}
> > +
> >  static void rzg2l_tint_irq_endisable(struct irq_data *d, bool enable) =
 {
> > +     struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> >       unsigned int hw_irq =3D irqd_to_hwirq(d);
> >
> >       if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
> > -             struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> >               u32 offset =3D hw_irq - IRQC_TINT_START;
> >               u32 tssr_offset =3D TSSR_OFFSET(offset);
> >               u8 tssr_index =3D TSSR_INDEX(offset);
> >               u32 reg;
> >
> >               raw_spin_lock(&priv->lock);
> > +             if (enable)
> > +                     rzg2l_irqc_unmask_once(priv, hw_irq);
> > +             else
> > +                     rzg2l_irqc_mask_once(priv, hw_irq);
> >               reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
> >               if (enable)
> >                       reg |=3D TIEN << TSSEL_SHIFT(tssr_offset); @@ -15=
7,6 +253,13 @@ static void
> > rzg2l_tint_irq_endisable(struct irq_data *d, bool enable)
> >                       reg &=3D ~(TIEN << TSSEL_SHIFT(tssr_offset));
> >               writel_relaxed(reg, priv->base + TSSR(tssr_index));
> >               raw_spin_unlock(&priv->lock);
> > +     } else {
> > +             raw_spin_lock(&priv->lock);
> > +             if (enable)
> > +                     rzg2l_irqc_unmask_once(priv, hw_irq);
> > +             else
> > +                     rzg2l_irqc_mask_once(priv, hw_irq);
> > +             raw_spin_unlock(&priv->lock);
> >       }
> >  }
> >
> > @@ -324,8 +427,8 @@ static struct syscore_ops rzg2l_irqc_syscore_ops =
=3D {  static const struct
> > irq_chip irqc_chip =3D {
> >       .name                   =3D "rzg2l-irqc",
> >       .irq_eoi                =3D rzg2l_irqc_eoi,
> > -     .irq_mask               =3D irq_chip_mask_parent,
> > -     .irq_unmask             =3D irq_chip_unmask_parent,
> > +     .irq_mask               =3D rzg2l_irqc_mask,
> > +     .irq_unmask             =3D rzg2l_irqc_unmask,
>
> I feel this will be clean, if we have
>
> static const struct irq_chip rzg2l_irqc_chip =3D {
>         .name                   =3D "rzg2l-irqc",
>         ...
>         .irq_mask               =3D irq_chip_mask_parent,
>         .irq_unmask             =3D irq_chip_unmask_parent,
>         ....
> };
>
> static const struct irq_chip rzfive_irqc_chip =3D {
>         .name                   =3D "rzfive-irqc",
>         ...
>         .irq_mask               =3D rzfive_irqc_mask,
>         .irq_unmask             =3D rzfive_irqc_unmask,
>         ....
> };
>
> And passing this in rzg2l_irqc_init() and rzfive_irqc_init(), see below
>
> return rzg2l_irqc_init_helper(node, parent, & rzg2l_irqc_chip);
> return rzg2l_irqc_init_helper(node, parent, & rzfive_irqc_chip);
>
If we do the above we are stuck with "struct irq_chip" as data, for
further upcoming SoCs (for example RZ/V2H) which have more features we
need to pass custom data to handle these features.

>
> >       .irq_disable            =3D rzg2l_irqc_irq_disable,
> >       .irq_enable             =3D rzg2l_irqc_irq_enable,
> >       .irq_get_irqchip_state  =3D irq_chip_get_parent_state,
> > @@ -401,7 +504,16 @@ static int rzg2l_irqc_parse_interrupts(struct rzg2=
l_irqc_priv *priv,
> >       return 0;
> >  }
> >
> > -static int rzg2l_irqc_init(struct device_node *node, struct device_nod=
e *parent)
> > +static const struct rzg2l_irqc_of_data rzg2l_irqc_mask_supported_data =
=3D {
> > +     .mask_supported =3D true,
> > +};
> > +
> > +static const struct rzg2l_irqc_of_data rzg2l_irqc_default_data =3D {
> > +     .mask_supported =3D false,
> > +};
> > +
> > +static int rzg2l_irqc_init(struct device_node *node, struct device_nod=
e *parent,
> > +                        const struct rzg2l_irqc_of_data *of_data)
>
> Maybe rename this as rzg2l_irqc_init_helper()
OK.

> >  {
> >       struct irq_domain *irq_domain, *parent_domain;
> >       struct platform_device *pdev;
> > @@ -422,6 +534,8 @@ static int rzg2l_irqc_init(struct device_node *node=
, struct device_node
> > *parent)
> >       if (!rzg2l_irqc_data)
> >               return -ENOMEM;
> >
> > +     rzg2l_irqc_data->data =3D of_data;
> > +
> >       rzg2l_irqc_data->base =3D devm_of_iomap(&pdev->dev, pdev->dev.of_=
node, 0, NULL);
> >       if (IS_ERR(rzg2l_irqc_data->base))
> >               return PTR_ERR(rzg2l_irqc_data->base); @@ -472,8 +586,21 =
@@ static int
> > rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
> >       return ret;
> >  }
> >
> > +static int __init rzg2l_irqc_default_init(struct device_node *node,
> > +                                       struct device_node *parent)
> > +{
> > +     return rzg2l_irqc_init(node, parent, &rzg2l_irqc_default_data); }
> > +
> > +static int __init rzg2l_irqc_mask_supported_init(struct device_node *n=
ode,
> > +                                              struct device_node *pare=
nt)
> > +{
> > +     return rzg2l_irqc_init(node, parent, &rzg2l_irqc_mask_supported_d=
ata);
> > +}
> > +
> >  IRQCHIP_PLATFORM_DRIVER_BEGIN(rzg2l_irqc)
> > -IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
> Retain this name
>
OK.

> > +IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_default_init)
> > +IRQCHIP_MATCH("renesas,r9a07g043f-irqc",
> > +rzg2l_irqc_mask_supported_init)
> Maybe rename this as rzfive_irqc_init ??
>
OK.

Cheers,
Prabhakar

