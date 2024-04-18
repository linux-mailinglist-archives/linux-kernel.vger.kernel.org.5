Return-Path: <linux-kernel+bounces-150372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 894858A9E13
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0600B24A10
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA7316C687;
	Thu, 18 Apr 2024 15:13:22 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A2B16ABC5;
	Thu, 18 Apr 2024 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453201; cv=none; b=pWlpZGdvQv2XERZH+Me9V5ADux9Xo3w1q7fYJm15JaPt+vYF+97l0uv1OPxA0aJXSshDVK/8SwgylxIb4pCJGU8g62d+eQLARV5NLUqMuUyAz4RbCQPEpjIysVJb2AUGfsycXVFdXBJi9oMKt1noIp7aNRcwCvRzXMt5YmjV8t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453201; c=relaxed/simple;
	bh=ZjKXWEZkLWSEsS4VKGI9UZIhPYo5yTYXpoRJWHe+eq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqO2pF4c2hFHGnI4ai2LWl04P3Pi/WttaTnHNexr8vLx7Vo+r8wafjggxYOQQ3cG8zSzTRH9juSrQr6UkmZratbeNXEqrqk7sYfntxEvJmsswsjkjE0lp0rj9d0PHyDoNyeXk88u4aQKUq8hvPBNkntGEZTvrruRwbM6J+Q6e/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61ae6c615aaso10416087b3.0;
        Thu, 18 Apr 2024 08:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713453197; x=1714057997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1h4fmHdoZ1uNPBY6e22fJ6tv/xZqMj+hsSgRjED/+s=;
        b=o4700U1d2pxsGUsi5u4cOY9agdKukdrHlA0gaSHj6dVDGuRg3yTNeyNpuJZORkLz0H
         VJ05xZyh25/Y8IDfCNdGvyjNUp9+jMh9scx24lws0k4h9BDZ23uoEJUYewofDrF0mBRT
         2+PspYGF0Xd1i2pnGBcjHM8q9rxiWiS5hrvaQq9DstaLqgBDrEmsKNlyRjjIOtK5yRLR
         SjjiROEYjq9JRjhyyJl3ndqJoQqBa+qzC0J6vT5oX4TqI3LU6lesF+vvhhe3uIraYZKr
         GAO+m3dGGfQAqrI8VyTu937izaD8q9YZB7RkTXb8mPho8kWDYoQVj/iS6Q9vQuWwhOAq
         C7Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUhfM0jKCWlBrF5slSkykqpSo6tUcbCfaezz12yPnjYVTDlQgsnKnnQVc7dZDrBNKaBa8KGGBOatnpLnmobIfllzl9dKL8c6P62QKr15OwhJB5mGBxKyqheGnRA2IUM/PkcAI1Zj+guj24wVA+0aBsEb49eST2KrkApezVddzkXmMu9NWRqM2F8VcXS
X-Gm-Message-State: AOJu0YyGoQEQJLPozTPyOTCKaZk5lJQmOMShvh1I3YLNT5q6W30sAKT/
	d1lIK/w51kQP7sdXqmzAD44keh656RBA7eFlZY20t8Iyna3RNo+3NVz6zUte
X-Google-Smtp-Source: AGHT+IHRbF9HS9cyaBcwFTQSDiJduyyj+/X4bR2BRpmKVgr4pfMzxmQPDNp0VWRIs0lUBtrG96BwKg==
X-Received: by 2002:a05:690c:6481:b0:615:3e2c:d318 with SMTP id hs1-20020a05690c648100b006153e2cd318mr2999314ywb.41.1713453195928;
        Thu, 18 Apr 2024 08:13:15 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id v78-20020a814851000000b0061855e3332dsm369050ywa.120.2024.04.18.08.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 08:13:15 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de463ffef13so1076502276.2;
        Thu, 18 Apr 2024 08:13:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5W6RvoMtxth2ldI9NcEK9ka/qu+xEUUtVFxBazjalxI2BDN4R4N3sd+g3vc/cx/JFYnH1imCNILY99j9bbbiVAlmRGZhs2bJIMKs0ZKScmzV6OP56VUYjlYMz7S82gHhjQ5hpwzkZYNRk7wahQMCRKfqVLQehJjMOPUB/uW1iYDe0fhcCrV++MHDH
X-Received: by 2002:a25:b317:0:b0:dcf:9018:67 with SMTP id l23-20020a25b317000000b00dcf90180067mr3146849ybj.42.1713453195004;
 Thu, 18 Apr 2024 08:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240403203503.634465-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OSAPR01MB1587ED05696A111612424CF6863C2@OSAPR01MB1587.jpnprd01.prod.outlook.com>
 <CA+V-a8s94e9PLuLipQo+rGZ8g7UHxZJJAZZgvL3PQ4b8PKR2Xw@mail.gmail.com>
 <OSAPR01MB15878C2C2EE7905D33182CFF863C2@OSAPR01MB1587.jpnprd01.prod.outlook.com>
 <CA+V-a8vjB-A+BRSpxk-dsu6XMvpG1y2f8g+LYcWV+gh2cx+6+g@mail.gmail.com>
In-Reply-To: <CA+V-a8vjB-A+BRSpxk-dsu6XMvpG1y2f8g+LYcWV+gh2cx+6+g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Apr 2024 17:13:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV37mtC9FpY8wAFdG-NQWdvZ=qq9egVVukGhc=5ZrOTtg@mail.gmail.com>
Message-ID: <CAMuHMdV37mtC9FpY8wAFdG-NQWdvZ=qq9egVVukGhc=5ZrOTtg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] irqchip/renesas-rzg2l: Add support for RZ/Five SoC
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Thomas Gleixner <tglx@linutronix.de>, 
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

Hi Prabhakar,

On Thu, Apr 4, 2024 at 3:35=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Thu, Apr 4, 2024 at 2:31=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.c=
om> wrote:
> > > -----Original Message-----
> > > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > > On Thu, Apr 4, 2024 at 8:44=E2=80=AFAM Biju Das <biju.das.jz@bp.renes=
as.com> wrote:
> > > > > -----Original Message-----
> > > > > From: Prabhakar <prabhakar.csengg@gmail.com>
> > > > > The IX45 block has additional mask registers (NMSK/IMSK/TMSK) as
> > > > > compared to the RZ/G2L (family) SoC.
> > > > >
> > > > > Introduce masking/unmasking support for IRQ and TINT interrupts i=
n
> > > > > IRQC controller driver. Two new registers, IMSK and TMSK, are
> > > > > defined to handle masking on RZ/Five SoC. The implementation
> > > > > utilizes a new data structure, `struct rzg2l_irqc_data`, to deter=
mine mask support for a
> > > specific controller instance.
> > > > >
> > > > > Signed-off-by: Lad Prabhakar
> > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > ---
> > > > > v1->v2
> > > > > - Added IRQCHIP_MATCH() for RZ/Five
> > > > > - Retaining a copy of OF data in priv
> > > > > - Rebased the changes
> > > > > ---
> > > > >  drivers/irqchip/irq-renesas-rzg2l.c | 137
> > > > > +++++++++++++++++++++++++++-
> > > > >  1 file changed, 132 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/irqchip/irq-renesas-rzg2l.c
> > > > > b/drivers/irqchip/irq-renesas-rzg2l.c
> > > > > index f6484bf15e0b..6fa8d65605dc 100644
> > > > > --- a/drivers/irqchip/irq-renesas-rzg2l.c
> > > > > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > > > > @@ -37,6 +37,8 @@
> > > > >  #define TSSEL_SHIFT(n)                       (8 * (n))
> > > > >  #define TSSEL_MASK                   GENMASK(7, 0)
> > > > >  #define IRQ_MASK                     0x3
> > > > > +#define IMSK                         0x10010
> > > > > +#define TMSK                         0x10020
> > > > >
> > > > >  #define TSSR_OFFSET(n)                       ((n) % 4)
> > > > >  #define TSSR_INDEX(n)                        ((n) / 4)
> > > > > @@ -66,15 +68,25 @@ struct rzg2l_irqc_reg_cache {
> > > > >       u32     titsr[2];
> > > > >  };
> > > > >
> > > > > +/**
> > > > > + * struct rzg2l_irqc_of_data - OF data structure
> > > > > + * @mask_supported: Indicates if mask registers are available  *=
/
> > > > > +struct rzg2l_irqc_of_data {
> > > > > +     bool    mask_supported;
> > > > > +};
> > > > > +
> > > > >  /**
> > > > >   * struct rzg2l_irqc_priv - IRQ controller private data structur=
e
> > > > >   * @base:    Controller's base address
> > > > > + * @data:    OF data pointer
> > > > >   * @fwspec:  IRQ firmware specific data
> > > > >   * @lock:    Lock to serialize access to hardware registers
> > > > >   * @cache:   Registers cache for suspend/resume
> > > > >   */
> > > > >  static struct rzg2l_irqc_priv {
> > > > >       void __iomem                    *base;
> > > > > +     const struct rzg2l_irqc_of_data *data;
> > > > >       struct irq_fwspec               fwspec[IRQC_NUM_IRQ];
> > > > >       raw_spinlock_t                  lock;
> > > > >       struct rzg2l_irqc_reg_cache     cache;
> > > > > @@ -138,18 +150,102 @@ static void rzg2l_irqc_eoi(struct irq_data=
 *d)
> > > > >       irq_chip_eoi_parent(d);
> > > > >  }
> > > > >
> > > > > +static void rzg2l_irqc_mask_irq_interrupt(struct rzg2l_irqc_priv=
 *priv,
> > > > > +                                       unsigned int hwirq) {
> > > > > +     u32 imsk =3D readl_relaxed(priv->base + IMSK);
> > > > > +     u32 bit =3D BIT(hwirq - IRQC_IRQ_START);
> > > > > +
> > > > > +     writel_relaxed(imsk | bit, priv->base + IMSK); }
> > > > > +
> > > > > +static void rzg2l_irqc_unmask_irq_interrupt(struct rzg2l_irqc_pr=
iv *priv,
> > > > > +                                         unsigned int hwirq) {
> > > > > +     u32 imsk =3D readl_relaxed(priv->base + IMSK);
> > > > > +     u32 bit =3D BIT(hwirq - IRQC_IRQ_START);
> > > > > +
> > > > > +     writel_relaxed(imsk & ~bit, priv->base + IMSK); }
> > > > > +
> > > > > +static void rzg2l_irqc_mask_tint_interrupt(struct rzg2l_irqc_pri=
v *priv,
> > > > > +                                        unsigned int hwirq) {
> > > > > +     u32 tmsk =3D readl_relaxed(priv->base + TMSK);
> > > > > +     u32 bit =3D BIT(hwirq - IRQC_TINT_START);
> > > > > +
> > > > > +     writel_relaxed(tmsk | bit, priv->base + TMSK); }
> > > > > +
> > > > > +static void rzg2l_irqc_unmask_tint_interrupt(struct rzg2l_irqc_p=
riv *priv,
> > > > > +                                          unsigned int hwirq) {
> > > > > +     u32 tmsk =3D readl_relaxed(priv->base + TMSK);
> > > > > +     u32 bit =3D BIT(hwirq - IRQC_TINT_START);
> > > > > +
> > > > > +     writel_relaxed(tmsk & ~bit, priv->base + TMSK); }
> > > > > +
> > > > > +/* Must be called while priv->lock is held */ static void
> > > > > +rzg2l_irqc_mask_once(struct rzg2l_irqc_priv *priv, unsigned int
> > > > > +hwirq) {
> > > > > +     if (!priv->data->mask_supported)
> > > > > +             return;
> > > > > +
> > > > > +     if (hwirq >=3D IRQC_IRQ_START && hwirq <=3D IRQC_IRQ_COUNT)
> > > > > +             rzg2l_irqc_mask_irq_interrupt(priv, hwirq);
> > > > > +     else if (hwirq >=3D IRQC_TINT_START && hwirq < IRQC_NUM_IRQ=
)
> > > > > +             rzg2l_irqc_mask_tint_interrupt(priv, hwirq); }
> > > > > +
> > > > > +static void rzg2l_irqc_mask(struct irq_data *d) {
> > > > > +     struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > > > > +
> > > > > +     raw_spin_lock(&priv->lock);
> > > > > +     rzg2l_irqc_mask_once(priv, irqd_to_hwirq(d));
> > > > > +     raw_spin_unlock(&priv->lock);
> > > > > +     irq_chip_mask_parent(d);
> > > > > +}
> > > > > +
> > > > > +/* Must be called while priv->lock is held */ static void
> > > > > +rzg2l_irqc_unmask_once(struct rzg2l_irqc_priv *priv, unsigned in=
t
> > > > > +hwirq) {
> > > > > +     if (!priv->data->mask_supported)
> > > > > +             return;
> > > > > +
> > > > > +     if (hwirq >=3D IRQC_IRQ_START && hwirq <=3D IRQC_IRQ_COUNT)
> > > > > +             rzg2l_irqc_unmask_irq_interrupt(priv, hwirq);
> > > > > +     else if (hwirq >=3D IRQC_TINT_START && hwirq < IRQC_NUM_IRQ=
)
> > > > > +             rzg2l_irqc_unmask_tint_interrupt(priv, hwirq); }
> > > > > +
> > > > > +static void rzg2l_irqc_unmask(struct irq_data *d) {
> > > > > +     struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > > > > +
> > > > > +     raw_spin_lock(&priv->lock);
> > > > > +     rzg2l_irqc_unmask_once(priv, irqd_to_hwirq(d));
> > > > > +     raw_spin_unlock(&priv->lock);
> > > > > +     irq_chip_unmask_parent(d);
> > > > > +}
> > > > > +
> > > > >  static void rzg2l_tint_irq_endisable(struct irq_data *d, bool
> > > > > enable)  {
> > > > > +     struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > > > >       unsigned int hw_irq =3D irqd_to_hwirq(d);
> > > > >
> > > > >       if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
> > > > > -             struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d=
);
> > > > >               u32 offset =3D hw_irq - IRQC_TINT_START;
> > > > >               u32 tssr_offset =3D TSSR_OFFSET(offset);
> > > > >               u8 tssr_index =3D TSSR_INDEX(offset);
> > > > >               u32 reg;
> > > > >
> > > > >               raw_spin_lock(&priv->lock);
> > > > > +             if (enable)
> > > > > +                     rzg2l_irqc_unmask_once(priv, hw_irq);
> > > > > +             else
> > > > > +                     rzg2l_irqc_mask_once(priv, hw_irq);
> > > > >               reg =3D readl_relaxed(priv->base + TSSR(tssr_index)=
);
> > > > >               if (enable)
> > > > >                       reg |=3D TIEN << TSSEL_SHIFT(tssr_offset); =
@@
> > > > > -157,6 +253,13 @@ static void rzg2l_tint_irq_endisable(struct irq=
_data *d, bool enable)
> > > > >                       reg &=3D ~(TIEN << TSSEL_SHIFT(tssr_offset)=
);
> > > > >               writel_relaxed(reg, priv->base + TSSR(tssr_index));
> > > > >               raw_spin_unlock(&priv->lock);
> > > > > +     } else {
> > > > > +             raw_spin_lock(&priv->lock);
> > > > > +             if (enable)
> > > > > +                     rzg2l_irqc_unmask_once(priv, hw_irq);
> > > > > +             else
> > > > > +                     rzg2l_irqc_mask_once(priv, hw_irq);
> > > > > +             raw_spin_unlock(&priv->lock);
> > > > >       }
> > > > >  }
> > > > >
> > > > > @@ -324,8 +427,8 @@ static struct syscore_ops rzg2l_irqc_syscore_=
ops
> > > > > =3D {  static const struct irq_chip irqc_chip =3D {
> > > > >       .name                   =3D "rzg2l-irqc",
> > > > >       .irq_eoi                =3D rzg2l_irqc_eoi,
> > > > > -     .irq_mask               =3D irq_chip_mask_parent,
> > > > > -     .irq_unmask             =3D irq_chip_unmask_parent,
> > > > > +     .irq_mask               =3D rzg2l_irqc_mask,
> > > > > +     .irq_unmask             =3D rzg2l_irqc_unmask,
> > > >
> > > > I feel this will be clean, if we have
> > > >
> > > > static const struct irq_chip rzg2l_irqc_chip =3D {
> > > >         .name                   =3D "rzg2l-irqc",
> > > >         ...
> > > >         .irq_mask               =3D irq_chip_mask_parent,
> > > >         .irq_unmask             =3D irq_chip_unmask_parent,
> > > >         ....
> > > > };
> > > >
> > > > static const struct irq_chip rzfive_irqc_chip =3D {
> > > >         .name                   =3D "rzfive-irqc",
> > > >         ...
> > > >         .irq_mask               =3D rzfive_irqc_mask,
> > > >         .irq_unmask             =3D rzfive_irqc_unmask,
> > > >         ....
> > > > };
> > > >
> > > > And passing this in rzg2l_irqc_init() and rzfive_irqc_init(), see
> > > > below
> > > >
> > > > return rzg2l_irqc_init_helper(node, parent, & rzg2l_irqc_chip); ret=
urn
> > > > rzg2l_irqc_init_helper(node, parent, & rzfive_irqc_chip);
> > > >
> > > If we do the above we are stuck with "struct irq_chip" as data, for f=
urther upcoming SoCs (for
> > > example RZ/V2H) which have more features we need to pass custom data =
to handle these features.
> >
> > That time device data can be extended like below
> >
> > struct rz_g2l_irq_chip {
> >         struct irq_chip;
> >         void *data; /* custom data */
> > }
> >
> Ok, but i'll wait for Geert to come back on this as Geert suggested to
> me to do it this way.

I agree with Biju.

Having separate irq_chips lets us avoid taking the spinlock on RZ/G2L.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

