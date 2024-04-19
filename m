Return-Path: <linux-kernel+bounces-151090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B68A8AA8F2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C952F1F22746
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1CD3F8E6;
	Fri, 19 Apr 2024 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5Mr7PRF"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D892C2F5A;
	Fri, 19 Apr 2024 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713510934; cv=none; b=F27V8YcVAMA6LLEXNkOyyrQamZypJoXlToZq2UO9OFvRy+HaedlI6muf2IYzRcFGe7nByys6sp2oQ9C8Ng8Z0JC+zwEUgctle0odnBWOvVDxnt4CzAeKk+nz16hvXhQKe+b3tmfipUn5vR7xfUlCMFzAJzUnj4vKy+OtTe8rLqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713510934; c=relaxed/simple;
	bh=KINbSPqlDc7TcLkaIOtwHvAjDX6tEO5EG3KWIrFgQ6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arD0y3FMhYSLwrWIodf/fc/iLbPhxFdGgxE8tFd60crJFGJZaYe9ZLAd0OuRq6GCWIrCyCd9KzQ5eLHtbv1TE77lM/1vVjcSzooCmbG1aWNRRQ7RqUtEcV0VapjvaWPBh2ZtMCSWLqvl/Nu/uGocf5fQle63dd0hRhTl98NUyAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5Mr7PRF; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4dabbd69c71so494295e0c.1;
        Fri, 19 Apr 2024 00:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713510930; x=1714115730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DfqeD/qXRNCbDH3vfHwrxsr/ACAxKb1H7ieV9FN0P8=;
        b=X5Mr7PRFhnrFwOvqX3t+jHfRfYMQN1socwRT9k9O4QneNZtUmuFYk2LtvMzTIP+1Fv
         u60Q/dWVyyHac9KaLQnbaRzhzoj3P3Y+ODXAaddMzPUGqSVpf+Hsy9ZyJ5Bz3rE/cNap
         McwjOtEd1FsvHVw2+rTrEWDnxomv4lvfB8rdD+NKn+fx+lAn9m/0pn4v+cF36MfXEQtX
         YA7AKzfs1gAJph2XOKdxD/2ZPg+UO4FfooQlR9swBhRSjvHQKWnQJVev7wXOsq2ljqie
         ZUeso1AzRz26SO7ftTmB58LbF/fJtX5YXbbP+jvg+f5/douHQfpge5BaZKhAYRzEZWWX
         dF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713510931; x=1714115731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DfqeD/qXRNCbDH3vfHwrxsr/ACAxKb1H7ieV9FN0P8=;
        b=bjmpvCGKbks7XvNmAQiAP9cP00kwnKD5Ke9j2At0w5kxJw52aBvXjd3ROzV9eNGCyA
         f0XxycK0XIfXpR+Yp73yQ1OQ5iwwc1vOKArgpuj4iigdzCD7e/tOFt3/+tqTRYSoO1Tn
         J98KZlR7Qr61lsPfGa1sIEpmMB2JSFl1wZfJkJePn+CM9RjHohtFJsBwvDSpsVAGeAPA
         vMTkleKLmawqop2g/vm7k1ohx03UsoYxwwtGn7vC5cxO6hVK2IQKRx8kUrmcqQdimXtj
         C7MZRVfduw78P/kkKZnkRk7ommmEBl5B53GhfG66UeD0rPjMEPGrQ3xz4MYrG7ddCtle
         c0bA==
X-Forwarded-Encrypted: i=1; AJvYcCUUo181SVN0oTp9Q5eyDDRjXweWoaO992CcmLzy5/s+nzZAhDglT2pwNC2gqt8ovlYNynnL+muVg2MnJbA9mgdoX06Dh4qdrovnY755XjCCct1gNdKfAayc3lZxIUF6mTjbQ71xksS5W3Nx26VUY+WLluWfwPAdEz8Ldk4DF5ij7Ped97gcwVEg9EAH
X-Gm-Message-State: AOJu0Yzpv3ORT6WKzS4c6nBo1XV9NDJ1f70ijIxLS7r6h5Q6RzpsDEo7
	ifSAcuqUCaqmgGY0pJQvlAZp9rmBfwqOJZ5UWEq6yuxyndu1uhC/TnKWzW4Gs0CbS7Dn+tGftqF
	RPC/pumWGvHqhq71/geVRaoVo+78=
X-Google-Smtp-Source: AGHT+IEQ7mKyuHmc8f+88bYxvct7nFZzLUcVxJdp0z2x8vbKtZwJ6S3mKejDaM8pi4j4sY0tklsgfIW2qJArXISMsMM=
X-Received: by 2002:a05:6122:369a:b0:4d8:4a7f:c166 with SMTP id
 ec26-20020a056122369a00b004d84a7fc166mr1163124vkb.12.1713510930592; Fri, 19
 Apr 2024 00:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240403203503.634465-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdW7kiSYm8n8CfMs9zKaN+PhVt+=16nx=ttLk6Ur_jOa-g@mail.gmail.com>
In-Reply-To: <CAMuHMdW7kiSYm8n8CfMs9zKaN+PhVt+=16nx=ttLk6Ur_jOa-g@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 19 Apr 2024 08:15:03 +0100
Message-ID: <CA+V-a8t6B3pGjrciDNRzdpGQp-8cGW0JXV9k0udpku3GVA0ckA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] irqchip/renesas-rzg2l: Add support for RZ/Five SoC
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Thu, Apr 18, 2024 at 4:11=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, Apr 3, 2024 at 10:36=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail=
com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > The IX45 block has additional mask registers (NMSK/IMSK/TMSK) as compar=
ed
> > to the RZ/G2L (family) SoC.
> >
> > Introduce masking/unmasking support for IRQ and TINT interrupts in IRQC
> > controller driver. Two new registers, IMSK and TMSK, are defined to
> > handle masking on RZ/Five SoC. The implementation utilizes a new data
> > structure, `struct rzg2l_irqc_data`, to determine mask support for a
> > specific controller instance.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > - Added IRQCHIP_MATCH() for RZ/Five
> > - Retaining a copy of OF data in priv
> > - Rebased the changes
>
> Thanks for the update!
>
> > --- a/drivers/irqchip/irq-renesas-rzg2l.c
> > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > @@ -37,6 +37,8 @@
> >  #define TSSEL_SHIFT(n)                 (8 * (n))
> >  #define TSSEL_MASK                     GENMASK(7, 0)
> >  #define IRQ_MASK                       0x3
> > +#define IMSK                           0x10010
> > +#define TMSK                           0x10020
> >
> >  #define TSSR_OFFSET(n)                 ((n) % 4)
> >  #define TSSR_INDEX(n)                  ((n) / 4)
> > @@ -66,15 +68,25 @@ struct rzg2l_irqc_reg_cache {
> >         u32     titsr[2];
> >  };
> >
> > +/**
> > + * struct rzg2l_irqc_of_data - OF data structure
> > + * @mask_supported: Indicates if mask registers are available
> > + */
> > +struct rzg2l_irqc_of_data {
> > +       bool    mask_supported;
> > +};
> > +
> >  /**
> >   * struct rzg2l_irqc_priv - IRQ controller private data structure
> >   * @base:      Controller's base address
> > + * @data:      OF data pointer
> >   * @fwspec:    IRQ firmware specific data
> >   * @lock:      Lock to serialize access to hardware registers
> >   * @cache:     Registers cache for suspend/resume
> >   */
> >  static struct rzg2l_irqc_priv {
> >         void __iomem                    *base;
> > +       const struct rzg2l_irqc_of_data *data;
>
> That's not a copy, but a pointer.
>
Oops, should that be OK or shall I create a copy instead?

> >         struct irq_fwspec               fwspec[IRQC_NUM_IRQ];
> >         raw_spinlock_t                  lock;
> >         struct rzg2l_irqc_reg_cache     cache;
> > @@ -138,18 +150,102 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
> >         irq_chip_eoi_parent(d);
> >  }
> >
> > +static void rzg2l_irqc_mask_irq_interrupt(struct rzg2l_irqc_priv *priv=
,
> > +                                         unsigned int hwirq)
> > +{
> > +       u32 imsk =3D readl_relaxed(priv->base + IMSK);
> > +       u32 bit =3D BIT(hwirq - IRQC_IRQ_START);
> > +
> > +       writel_relaxed(imsk | bit, priv->base + IMSK);
> > +}
> > +
> > +static void rzg2l_irqc_unmask_irq_interrupt(struct rzg2l_irqc_priv *pr=
iv,
> > +                                           unsigned int hwirq)
> > +{
> > +       u32 imsk =3D readl_relaxed(priv->base + IMSK);
> > +       u32 bit =3D BIT(hwirq - IRQC_IRQ_START);
> > +
> > +       writel_relaxed(imsk & ~bit, priv->base + IMSK);
> > +}
> > +
> > +static void rzg2l_irqc_mask_tint_interrupt(struct rzg2l_irqc_priv *pri=
v,
> > +                                          unsigned int hwirq)
> > +{
> > +       u32 tmsk =3D readl_relaxed(priv->base + TMSK);
> > +       u32 bit =3D BIT(hwirq - IRQC_TINT_START);
> > +
> > +       writel_relaxed(tmsk | bit, priv->base + TMSK);
> > +}
> > +
> > +static void rzg2l_irqc_unmask_tint_interrupt(struct rzg2l_irqc_priv *p=
riv,
> > +                                            unsigned int hwirq)
> > +{
> > +       u32 tmsk =3D readl_relaxed(priv->base + TMSK);
> > +       u32 bit =3D BIT(hwirq - IRQC_TINT_START);
> > +
> > +       writel_relaxed(tmsk & ~bit, priv->base + TMSK);
> > +}
> > +
> > +/* Must be called while priv->lock is held */
> > +static void rzg2l_irqc_mask_once(struct rzg2l_irqc_priv *priv, unsigne=
d int hwirq)
> > +{
> > +       if (!priv->data->mask_supported)
> > +               return;
> > +
> > +       if (hwirq >=3D IRQC_IRQ_START && hwirq <=3D IRQC_IRQ_COUNT)
> > +               rzg2l_irqc_mask_irq_interrupt(priv, hwirq);
> > +       else if (hwirq >=3D IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
> > +               rzg2l_irqc_mask_tint_interrupt(priv, hwirq);
> > +}
> > +
> > +static void rzg2l_irqc_mask(struct irq_data *d)
> > +{
> > +       struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > +
> > +       raw_spin_lock(&priv->lock);
> > +       rzg2l_irqc_mask_once(priv, irqd_to_hwirq(d));
> > +       raw_spin_unlock(&priv->lock);
> > +       irq_chip_mask_parent(d);
> > +}
> > +
> > +/* Must be called while priv->lock is held */
> > +static void rzg2l_irqc_unmask_once(struct rzg2l_irqc_priv *priv, unsig=
ned int hwirq)
> > +{
> > +       if (!priv->data->mask_supported)
> > +               return;
> > +
> > +       if (hwirq >=3D IRQC_IRQ_START && hwirq <=3D IRQC_IRQ_COUNT)
> > +               rzg2l_irqc_unmask_irq_interrupt(priv, hwirq);
> > +       else if (hwirq >=3D IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
> > +               rzg2l_irqc_unmask_tint_interrupt(priv, hwirq);
> > +}
> > +
> > +static void rzg2l_irqc_unmask(struct irq_data *d)
> > +{
> > +       struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> > +
> > +       raw_spin_lock(&priv->lock);
> > +       rzg2l_irqc_unmask_once(priv, irqd_to_hwirq(d));
> > +       raw_spin_unlock(&priv->lock);
> > +       irq_chip_unmask_parent(d);
> > +}
> > +
> >  static void rzg2l_tint_irq_endisable(struct irq_data *d, bool enable)
> >  {
> > +       struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> >         unsigned int hw_irq =3D irqd_to_hwirq(d);
> >
> >         if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
> > -               struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> >                 u32 offset =3D hw_irq - IRQC_TINT_START;
> >                 u32 tssr_offset =3D TSSR_OFFSET(offset);
> >                 u8 tssr_index =3D TSSR_INDEX(offset);
> >                 u32 reg;
> >
> >                 raw_spin_lock(&priv->lock);
> > +               if (enable)
> > +                       rzg2l_irqc_unmask_once(priv, hw_irq);
> > +               else
> > +                       rzg2l_irqc_mask_once(priv, hw_irq);
>
> You already know this is a TINT interrupt, so you could call
> rzg2l_irqc_(un)mask_irq_interrupt() directly.
>
Agreed.

> >                 reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
> >                 if (enable)
> >                         reg |=3D TIEN << TSSEL_SHIFT(tssr_offset);
> > @@ -157,6 +253,13 @@ static void rzg2l_tint_irq_endisable(struct irq_da=
ta *d, bool enable)
> >                         reg &=3D ~(TIEN << TSSEL_SHIFT(tssr_offset));
> >                 writel_relaxed(reg, priv->base + TSSR(tssr_index));
> >                 raw_spin_unlock(&priv->lock);
> > +       } else {
> > +               raw_spin_lock(&priv->lock);
> > +               if (enable)
> > +                       rzg2l_irqc_unmask_once(priv, hw_irq);
> > +               else
> > +                       rzg2l_irqc_mask_once(priv, hw_irq);
>
> Likewise.
>
OK.

Cheers,
Prabhakar

