Return-Path: <linux-kernel+bounces-150369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0C58A9E0B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6357328353C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B198D16C456;
	Thu, 18 Apr 2024 15:11:29 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754A4161935;
	Thu, 18 Apr 2024 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453089; cv=none; b=LVp7OqLYUjNAfQ0qxbeIx5MPz3qNOzzERlK9dwSX7fEjWW6/BCaJAKw+AQQc+VlBni8uaBDKS7ZDymKj+Fc59MYzAFNTAqgbaziCU+GR7upRRJiXwqvRyOnyb3TBx+Rx/XRnlnjlQyjHnc2+Q2DthbIqoubhvsMOWGR8Ce1NnQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453089; c=relaxed/simple;
	bh=Gr7nAtEgOt+/LCEsIZFS2DhpmzzOe4xq8nfvfsQkXH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJwUhn/fpjYcPzKtBgx/gKh5C2jR+ftCcDKqjf38xdLMSJFDr9Uzf8mD/MlUp4fjESJoRfOen8P/1wXe/ILpvC0dVhc6yB8zB/+5rar7r8b18ryEHhXTyPgg89eno95earav0zmuDzRpx1B57iJAR7EuZ7ZAi6TX3QG2+yNE4co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61500da846fso7294347b3.1;
        Thu, 18 Apr 2024 08:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713453081; x=1714057881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYgx8PoYC9becIlnatSH9CSdIsX+U/O8aOip/So2vJQ=;
        b=ja/mXEJ9kbN4ejKq2iQ6RG6aBSyzz2Hoz1kZ9SPlAMIYxKlM+yXfciuIPv1H/Q3mnp
         HC6DNPojGWmD/g+OC6B8Thq6k6dDfRNy/T+RNKN0/eHCFdg3PatVNK50JDsf7Spe7aFm
         1EQeAWsCxkvmJTb7SVj+UY2q+wYGXj/q2OskhEq3XTg9sRiWs8tO/Jn4uS+AGTMfdCO8
         vMeYduK0r1PCfoCWh1ePDGPiHiirE5oyANcpyAu19YgNmqYMnOjsgo+63c8iudX28+r7
         Wk2Q7OFxYWpz1z53lhNYZOdAL6MaxrIDDvZ/JP7+JjdpIUqWtpR4Ubg7Bb3tELl/xYYZ
         DVow==
X-Forwarded-Encrypted: i=1; AJvYcCXFVskIfYtXYAqJlEMWu8iD0HIBIr999l16ER5JUMpe8n3YWT8tif9qDPEFdwEL+3HUcOd7g7D1X2meftbY3PBVFKiPNejwcgyIR9dJVi8POfX9RaJ1rznsPdtFlpqEbYH1uY3RfPfNeRH82MBuMEKB1gmXnalrSYJXIHJvtfJ7nH9DegKk2wnH5k7V
X-Gm-Message-State: AOJu0Yz5kGG+F4BsS8UNVuB7Xtgp7Mo/atXF7bWT+f7mDRV7kikV8vxk
	TE13Qd9srX6F9QnF3e0bgGsR70AptS0FMsF0/ksu0SCyiOtLsKZrGXCuxCuH
X-Google-Smtp-Source: AGHT+IFZlQ+qX8rzKn8ElzG8yCUImquEiojp/b6X5fxhR28P/XjE2K7NqJihR3krTeFDl+XKDG0T+Q==
X-Received: by 2002:a05:690c:c09:b0:615:2ed7:59e with SMTP id cl9-20020a05690c0c0900b006152ed7059emr3191793ywb.14.1713453081472;
        Thu, 18 Apr 2024 08:11:21 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id n74-20020a0dcb4d000000b0061520765e11sm361726ywd.143.2024.04.18.08.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 08:11:21 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6153d85053aso8821257b3.0;
        Thu, 18 Apr 2024 08:11:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDI5io9w1YRFtqtdcKPN/bGbvIW4g69voMqD0hNwgG6wpEZaXhi/Y1jMOp3gssDRrEPhJkT+sw0VuEORoMvRo/6PH0xbq44CYanG97XXn7rmh7XXfLjtf/Y+DZjhcnd8mLwoPHoptHDkWGYcLCgOxusZZkuVd9LDeV3lHQTcCs2k0m4kOFUj1oTLUa
X-Received: by 2002:a25:6989:0:b0:dc7:5018:4022 with SMTP id
 e131-20020a256989000000b00dc750184022mr3364707ybc.44.1713453080848; Thu, 18
 Apr 2024 08:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240403203503.634465-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240403203503.634465-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Apr 2024 17:11:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW7kiSYm8n8CfMs9zKaN+PhVt+=16nx=ttLk6Ur_jOa-g@mail.gmail.com>
Message-ID: <CAMuHMdW7kiSYm8n8CfMs9zKaN+PhVt+=16nx=ttLk6Ur_jOa-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] irqchip/renesas-rzg2l: Add support for RZ/Five SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Wed, Apr 3, 2024 at 10:36=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The IX45 block has additional mask registers (NMSK/IMSK/TMSK) as compared
> to the RZ/G2L (family) SoC.
>
> Introduce masking/unmasking support for IRQ and TINT interrupts in IRQC
> controller driver. Two new registers, IMSK and TMSK, are defined to
> handle masking on RZ/Five SoC. The implementation utilizes a new data
> structure, `struct rzg2l_irqc_data`, to determine mask support for a
> specific controller instance.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> - Added IRQCHIP_MATCH() for RZ/Five
> - Retaining a copy of OF data in priv
> - Rebased the changes

Thanks for the update!

> --- a/drivers/irqchip/irq-renesas-rzg2l.c
> +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> @@ -37,6 +37,8 @@
>  #define TSSEL_SHIFT(n)                 (8 * (n))
>  #define TSSEL_MASK                     GENMASK(7, 0)
>  #define IRQ_MASK                       0x3
> +#define IMSK                           0x10010
> +#define TMSK                           0x10020
>
>  #define TSSR_OFFSET(n)                 ((n) % 4)
>  #define TSSR_INDEX(n)                  ((n) / 4)
> @@ -66,15 +68,25 @@ struct rzg2l_irqc_reg_cache {
>         u32     titsr[2];
>  };
>
> +/**
> + * struct rzg2l_irqc_of_data - OF data structure
> + * @mask_supported: Indicates if mask registers are available
> + */
> +struct rzg2l_irqc_of_data {
> +       bool    mask_supported;
> +};
> +
>  /**
>   * struct rzg2l_irqc_priv - IRQ controller private data structure
>   * @base:      Controller's base address
> + * @data:      OF data pointer
>   * @fwspec:    IRQ firmware specific data
>   * @lock:      Lock to serialize access to hardware registers
>   * @cache:     Registers cache for suspend/resume
>   */
>  static struct rzg2l_irqc_priv {
>         void __iomem                    *base;
> +       const struct rzg2l_irqc_of_data *data;

That's not a copy, but a pointer.

>         struct irq_fwspec               fwspec[IRQC_NUM_IRQ];
>         raw_spinlock_t                  lock;
>         struct rzg2l_irqc_reg_cache     cache;
> @@ -138,18 +150,102 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
>         irq_chip_eoi_parent(d);
>  }
>
> +static void rzg2l_irqc_mask_irq_interrupt(struct rzg2l_irqc_priv *priv,
> +                                         unsigned int hwirq)
> +{
> +       u32 imsk =3D readl_relaxed(priv->base + IMSK);
> +       u32 bit =3D BIT(hwirq - IRQC_IRQ_START);
> +
> +       writel_relaxed(imsk | bit, priv->base + IMSK);
> +}
> +
> +static void rzg2l_irqc_unmask_irq_interrupt(struct rzg2l_irqc_priv *priv=
,
> +                                           unsigned int hwirq)
> +{
> +       u32 imsk =3D readl_relaxed(priv->base + IMSK);
> +       u32 bit =3D BIT(hwirq - IRQC_IRQ_START);
> +
> +       writel_relaxed(imsk & ~bit, priv->base + IMSK);
> +}
> +
> +static void rzg2l_irqc_mask_tint_interrupt(struct rzg2l_irqc_priv *priv,
> +                                          unsigned int hwirq)
> +{
> +       u32 tmsk =3D readl_relaxed(priv->base + TMSK);
> +       u32 bit =3D BIT(hwirq - IRQC_TINT_START);
> +
> +       writel_relaxed(tmsk | bit, priv->base + TMSK);
> +}
> +
> +static void rzg2l_irqc_unmask_tint_interrupt(struct rzg2l_irqc_priv *pri=
v,
> +                                            unsigned int hwirq)
> +{
> +       u32 tmsk =3D readl_relaxed(priv->base + TMSK);
> +       u32 bit =3D BIT(hwirq - IRQC_TINT_START);
> +
> +       writel_relaxed(tmsk & ~bit, priv->base + TMSK);
> +}
> +
> +/* Must be called while priv->lock is held */
> +static void rzg2l_irqc_mask_once(struct rzg2l_irqc_priv *priv, unsigned =
int hwirq)
> +{
> +       if (!priv->data->mask_supported)
> +               return;
> +
> +       if (hwirq >=3D IRQC_IRQ_START && hwirq <=3D IRQC_IRQ_COUNT)
> +               rzg2l_irqc_mask_irq_interrupt(priv, hwirq);
> +       else if (hwirq >=3D IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
> +               rzg2l_irqc_mask_tint_interrupt(priv, hwirq);
> +}
> +
> +static void rzg2l_irqc_mask(struct irq_data *d)
> +{
> +       struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> +
> +       raw_spin_lock(&priv->lock);
> +       rzg2l_irqc_mask_once(priv, irqd_to_hwirq(d));
> +       raw_spin_unlock(&priv->lock);
> +       irq_chip_mask_parent(d);
> +}
> +
> +/* Must be called while priv->lock is held */
> +static void rzg2l_irqc_unmask_once(struct rzg2l_irqc_priv *priv, unsigne=
d int hwirq)
> +{
> +       if (!priv->data->mask_supported)
> +               return;
> +
> +       if (hwirq >=3D IRQC_IRQ_START && hwirq <=3D IRQC_IRQ_COUNT)
> +               rzg2l_irqc_unmask_irq_interrupt(priv, hwirq);
> +       else if (hwirq >=3D IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
> +               rzg2l_irqc_unmask_tint_interrupt(priv, hwirq);
> +}
> +
> +static void rzg2l_irqc_unmask(struct irq_data *d)
> +{
> +       struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> +
> +       raw_spin_lock(&priv->lock);
> +       rzg2l_irqc_unmask_once(priv, irqd_to_hwirq(d));
> +       raw_spin_unlock(&priv->lock);
> +       irq_chip_unmask_parent(d);
> +}
> +
>  static void rzg2l_tint_irq_endisable(struct irq_data *d, bool enable)
>  {
> +       struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
>         unsigned int hw_irq =3D irqd_to_hwirq(d);
>
>         if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
> -               struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
>                 u32 offset =3D hw_irq - IRQC_TINT_START;
>                 u32 tssr_offset =3D TSSR_OFFSET(offset);
>                 u8 tssr_index =3D TSSR_INDEX(offset);
>                 u32 reg;
>
>                 raw_spin_lock(&priv->lock);
> +               if (enable)
> +                       rzg2l_irqc_unmask_once(priv, hw_irq);
> +               else
> +                       rzg2l_irqc_mask_once(priv, hw_irq);

You already know this is a TINT interrupt, so you could call
rzg2l_irqc_(un)mask_irq_interrupt() directly.

>                 reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
>                 if (enable)
>                         reg |=3D TIEN << TSSEL_SHIFT(tssr_offset);
> @@ -157,6 +253,13 @@ static void rzg2l_tint_irq_endisable(struct irq_data=
 *d, bool enable)
>                         reg &=3D ~(TIEN << TSSEL_SHIFT(tssr_offset));
>                 writel_relaxed(reg, priv->base + TSSR(tssr_index));
>                 raw_spin_unlock(&priv->lock);
> +       } else {
> +               raw_spin_lock(&priv->lock);
> +               if (enable)
> +                       rzg2l_irqc_unmask_once(priv, hw_irq);
> +               else
> +                       rzg2l_irqc_mask_once(priv, hw_irq);

Likewise.

> +               raw_spin_unlock(&priv->lock);
>         }
>  }

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

