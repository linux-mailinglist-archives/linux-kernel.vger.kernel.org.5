Return-Path: <linux-kernel+bounces-47782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8967E8452D2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4201E293A7F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520E42E842;
	Thu,  1 Feb 2024 08:34:42 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F59F15A4B1;
	Thu,  1 Feb 2024 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706776481; cv=none; b=phwnTu+R7ityfV1Wc0srNtV5wlXj+IYKvKwzpNHVEZZ3bsppMPOQIs8WkYSCavYrHaNFFSiueh4lgG/cLJFGVFKTzOXVkLYkc9cpCNApg/TpZTGhRVBiRAwQedBi7H2kxWzN4loRPllYeArToIuTOPpC83OkCbnw0k1saLdydW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706776481; c=relaxed/simple;
	bh=sDRZVbaV2bc5xAXJPaIp6yTdUcALc0sGqcGUq+EIioI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgSypmhkIShjBqh8Tap+a40SqwyDTXysPOudCIAESFwxUTrXoPwgz/9sbJhvcEy67uiq5KG2p1vpin6EzPUjAKCOwFyG5TNwnB546QR2YxEwMO9uHvpd1eMMrziGxpzOBAOjEFEMDWiu+pnPjdNU7471BTsaoTWYcQ1d8OYbLzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-604059403e9so6634737b3.3;
        Thu, 01 Feb 2024 00:34:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706776477; x=1707381277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HK1C91x+7wARyC9FcS8BRNfiXMoVY/LaEt3n42/zAE=;
        b=lSkI3ezM/rlL7xMqWJLmzViFtiW2ZbpcW/O05DD5lUJ9sZh4HY57rR9MsSphZB3PEE
         nGynipms3SIgsWsWkegH1igejgX96CRhZpU2NsgQBpB1qugpfPcNgyhwngYJkenc/vAu
         XhMG3KmvqOe5a88NQSDtCb4JCNBITCeA2HKlFFVMvW+xaGLol46kkG254E9E5tryOHt9
         Cl0VBLCikjm2kHyRNcRbl/etm97RT6GeSRdgAJHzcp5UULV5KGYcejXaAx6FLE8kS6w3
         BPI+83sHQ9capwfY6EcTqzgvOhqC2XkAxuB/VsufC0aecqjDt4CpTfq53JPGKXOPTS46
         g6og==
X-Gm-Message-State: AOJu0YxNVOtko++fOMcJNZ1FKNHtDMdzMB5irsMWz5+ZOIyVLeqEE2Bc
	v6eZC0kMdhZG22afqa6ywf2P8SdeFlO87l56uAUvHiuDDmVYHh/VCSGHxCn8X5Y=
X-Google-Smtp-Source: AGHT+IFjwVn4UY2Kxo/XufzLNB2vGbsLImFRXcrEXkKYpRr064g+bPgK+2JO0wCQnTYdEYiRtfS2SQ==
X-Received: by 2002:a81:4813:0:b0:602:b697:d9ff with SMTP id v19-20020a814813000000b00602b697d9ffmr1701529ywa.22.1706776476936;
        Thu, 01 Feb 2024 00:34:36 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id ez10-20020a05690c308a00b005ff9154001fsm3637062ywb.140.2024.02.01.00.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 00:34:35 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc236729a2bso617516276.0;
        Thu, 01 Feb 2024 00:34:34 -0800 (PST)
X-Received: by 2002:a25:824a:0:b0:dc6:ad43:8cf4 with SMTP id
 d10-20020a25824a000000b00dc6ad438cf4mr1840360ybn.20.1706776474698; Thu, 01
 Feb 2024 00:34:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240129151618.90922-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV7Q4kMv1pFVNBf5oYF=_W_snp=5GKLpr9+OxeqxywhBw@mail.gmail.com> <CA+V-a8spFYvOo2=9CwM-1EyMA3Xrc_rggUgxDZwZan2ou4SG1A@mail.gmail.com>
In-Reply-To: <CA+V-a8spFYvOo2=9CwM-1EyMA3Xrc_rggUgxDZwZan2ou4SG1A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Feb 2024 09:34:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUFZ6pRtZv4QLGhTz_gG575-8-LvaFprNuP2-1HGS8r+A@mail.gmail.com>
Message-ID: <CAMuHMdUFZ6pRtZv4QLGhTz_gG575-8-LvaFprNuP2-1HGS8r+A@mail.gmail.com>
Subject: Re: [PATCH 2/5] irqchip/renesas-rzg2l: Add support for RZ/Five SoC
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Wed, Jan 31, 2024 at 7:36=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Tue, Jan 30, 2024 at 11:38=E2=80=AFAM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Mon, Jan 29, 2024 at 4:16=E2=80=AFPM Prabhakar <prabhakar.csengg@gma=
il.com> wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > The IX45 block has additional mask registers (NMSK/IMSK/TMSK) as comp=
ared
> > > to the RZ/G2L (family) SoC.
> > >
> > > Introduce masking/unmasking support for IRQ and TINT interrupts in IR=
QC
> > > controller driver. Two new registers, IMSK and TMSK, are defined to
> > > handle masking on RZ/Five SoC. The implementation utilizes a new data
> > > structure, `struct rzg2l_irqc_data`, to determine mask support for a
> > > specific controller instance.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> >
> > > --- a/drivers/irqchip/irq-renesas-rzg2l.c
> > > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > > @@ -66,15 +68,25 @@ struct rzg2l_irqc_reg_cache {
> > >         u32     titsr[2];
> > >  };
> > >
> > > +/**
> > > + * struct rzg2l_irqc_data - OF data structure
> > > + * @mask_supported: Indicates if mask registers are available
> > > + */
> > > +struct rzg2l_irqc_data {
> >
> > This structure has the same name as the single static struct
> > rzg2l_irqc_priv instance, which is confusing.
> >
> Agreed, I will rename it to rzg2l_irqc_of_data
>
> > > +       bool    mask_supported;
> > > +};
> > > +
> > >  /**
> > >   * struct rzg2l_irqc_priv - IRQ controller private data structure
> > >   * @base:      Controller's base address
> > > + * @data:      OF data pointer
> > >   * @fwspec:    IRQ firmware specific data
> > >   * @lock:      Lock to serialize access to hardware registers
> > >   * @cache:     Registers cache for suspend/resume
> > >   */
> > >  static struct rzg2l_irqc_priv {
> > >         void __iomem                    *base;
> > > +       const struct rzg2l_irqc_data    *data;
> >
> > Replacing this by a bool would avoid a pointer dereference in each user=
,
> > and allows you to make rzg2l_irqc_data etc. __initconst.
> >
> Do you mean just add "bool mask_supported" here and get rid of struct
> rzg2l_irqc_data ? Can you please elaborate here..

Either add "bool mask_supported" here, or add a copy of the full
struct rzg2l_irqc_data (see below).

>
> > >         struct irq_fwspec               fwspec[IRQC_NUM_IRQ];
> > >         raw_spinlock_t                  lock;
> > >         struct rzg2l_irqc_reg_cache     cache;
> >
> > > @@ -371,9 +475,23 @@ static int rzg2l_irqc_parse_interrupts(struct rz=
g2l_irqc_priv *priv,
> > >         return 0;
> > >  }
> > >
> > > +static const struct rzg2l_irqc_data rzfive_irqc_data =3D {
> > > +       .mask_supported =3D true,
> > > +};
> > > +
> > > +static const struct rzg2l_irqc_data rzg2l_irqc_default_data =3D {
> > > +       .mask_supported =3D false,
> > > +};
> > > +
> > > +static const struct of_device_id rzg2l_irqc_matches[] =3D {
> > > +       { .compatible =3D "renesas,r9a07g043f-irqc", .data =3D &rzfiv=
e_irqc_data },
> > > +       { }
> > > +};
> > > +
> > >  static int rzg2l_irqc_init(struct device_node *node, struct device_n=
ode *parent)
> > >  {
> > >         struct irq_domain *irq_domain, *parent_domain;
> > > +       const struct of_device_id *match;
> > >         struct platform_device *pdev;
> > >         struct reset_control *resetn;
> > >         int ret;
> > > @@ -392,6 +510,12 @@ static int rzg2l_irqc_init(struct device_node *n=
ode, struct device_node *parent)
> > >         if (!rzg2l_irqc_data)
> > >                 return -ENOMEM;
> > >
> > > +       match =3D of_match_node(rzg2l_irqc_matches, node);
> > > +       if (match)
> > > +               rzg2l_irqc_data->data =3D match->data;
> > > +       else
> > > +               rzg2l_irqc_data->data =3D &rzg2l_irqc_default_data;
> >
> > Instead of matching a second time, I'd rather add a second
> > IRQCHIP_MATCH() entry with a different init function, passing the
> > actual rzg2l_irqc_data pointer.
> >
> OK, or rather just pass true/false instead of rzg2l_irqc_of_data pointer.=
?

Yes, that would be fine for me, too.
It all depends on whether you plan to add, or see a need for adding,
more flags or other fields in the future (and even for flags, you could
combine them in an unsigned long).

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

