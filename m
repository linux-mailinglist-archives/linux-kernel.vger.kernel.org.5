Return-Path: <linux-kernel+bounces-129938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49007897243
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE171C25E17
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D1C14A4C4;
	Wed,  3 Apr 2024 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZPMpWEkL"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F2C149DFB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153836; cv=none; b=Vtc5AoOhfH0GvNyUW0u9q/DOig4i02AZUNSOzkMaXRzHS7mZVSMCfMVOObppYJqPuHu9j8MK3m5XuNRcqp9o4AVxWQPRB6LJpUt8RMG2+v2mvbLR0B9m02MW2EWruhOVbofcugMxV5jxX8RmrtkvyhQFQ1XiEm18/4sbxg0ALI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153836; c=relaxed/simple;
	bh=4tmWtIzTNJR3Rbq5UfEzQP4C6P5Whjdqf7xIKDQTudU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JT2aq7X9ucTtfPMKyUOYkuQ7Lp96hXims2BPt0x+32ha4EU+vKjaIBUqyZmc9P6QLjY7gKn8eSH1GPkKOq4LG36XMwwMZuADGz8BujJ21Ob/Nj2OrDO91SF+2cKLy6QdArkEdeF5PuTUMg2t+HvtFfQaELe1ghF31A78thxEGoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZPMpWEkL; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d718ee7344so67915811fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712153830; x=1712758630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kmoS+BuhUZ03U8KzNrqUxDRvxrKPIuoIPUXmGLJuf8=;
        b=ZPMpWEkLNPwutuT2Qh/ZccD/iSDSukInDz5c24BeYdodHlO996JyMNFEGHpSsXQ/Ol
         RnBXUVT9NFNKbg77cA0LejxIM3BTT8fxHDQLt5YOF0/GjncWj1ELy6YgkTH5umKbtB5b
         hFb1bxmZQy/QJt55I24kM3yYVKP8Q/dM/w8vBeZhB/wIHR+u1+UX7uJoAGF48ZQie+Oo
         NouX4sKPqFWlFeuipx2YkYCHf5OS4E4qrnvSMMWmDp7pdYYE6pRNfhbOxezVLdydNjBZ
         vp5FJtuz/0GfJ5iNlm1TbUop4mkSFmiCoKCqLIAqL6Ed3dNRyqR0HdNJHUS7+uRx4mrZ
         opyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712153830; x=1712758630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kmoS+BuhUZ03U8KzNrqUxDRvxrKPIuoIPUXmGLJuf8=;
        b=BLmd+WzKmTxIc4CT4bMq98/rWke4jZPjZ+Gh4NmJNhgBdLSh0wdrLMod1ulQPPposK
         IE54cFvPGWVlAdRQjkFsc16XkUhmKRUoC1G6KIOiO7I5TtPAsJnDNykz6V+uk/gjnXKu
         TUw0gYL3GYVlfrtv+vDyIptWKylBHEeAFzTY1rxYEtaqj4Orv9mQhsApf58dVAszew4P
         GLoJEKdh9op20cyYYl2wfzZecXRHDBkPfa26Qb7Try4qCBkTKkJADtElum7GdiHPCNyg
         Qf4prrhGpuynn7qCL0XshHBJreeMbpK2b08l054+5uptYFqly4b65QdhrMjqZmtDoX5/
         djSA==
X-Forwarded-Encrypted: i=1; AJvYcCUKITEmKDo7JCG8l3AIl9WjgDBs+42+QiZau5FwgqFrrQlxEDPU31eXAmmWvpaThwCAD3Nz6e69jLVHeiU20JezzasRfQBqQaUV9nzO
X-Gm-Message-State: AOJu0YzLqN7+HHIJLjKEvgimkox0QgRYsZpPkmjNj9tVIxs6pypFBnrk
	wOdtXhm8LBIYom6eo2p4hEptMKvpQESUEe5fXl/AqAykvRmy9HkQ6Xab7fhicDCchAbR/ru6ypo
	CEc1oJ2M0pDsKjkqUAY5JVAyzPrMX1Pg+GQk21w==
X-Google-Smtp-Source: AGHT+IGZX4ALfRXlJt2f9ZzrlbcnYo237l5fcwaUN+JdtQtxX4jmagUDriE4RpHAdgX8wFvRJF54Bwgj0nC72Ri/D2c=
X-Received: by 2002:a05:651c:b0c:b0:2d8:3cd3:35d with SMTP id
 b12-20020a05651c0b0c00b002d83cd3035dmr2134857ljr.33.1712153829687; Wed, 03
 Apr 2024 07:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
 <20240222094006.1030709-2-apatel@ventanamicro.com> <CA+V-a8tGucbJ87hsMQDEgcor5BzDmB_WnRsEn6c9F_HzucWLXQ@mail.gmail.com>
In-Reply-To: <CA+V-a8tGucbJ87hsMQDEgcor5BzDmB_WnRsEn6c9F_HzucWLXQ@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 3 Apr 2024 19:46:57 +0530
Message-ID: <CAK9=C2VgiRcQjBEPmZjdcMf221omKS8ntdcenSE7G__4xYcCUA@mail.gmail.com>
Subject: Re: [PATCH v14 01/18] irqchip/sifive-plic: Convert PLIC driver into a
 platform driver
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, Marc Zyngier <maz@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Atish Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, Saravana Kannan <saravanak@google.com>, 
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 2:01=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Anup,
>
> On Thu, Feb 22, 2024 at 9:41=E2=80=AFAM Anup Patel <apatel@ventanamicro.c=
om> wrote:
> >
> > The PLIC driver does not require very early initialization so convert
> > it into a platform driver.
> >
> > After conversion, the PLIC driver is probed after CPUs are brought-up
> > so setup cpuhp state after context handler of all online CPUs are
> > initialized otherwise PLIC driver crashes for platforms with multiple
> > PLIC instances.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 101 ++++++++++++++++++------------
> >  1 file changed, 61 insertions(+), 40 deletions(-)
> >
> This patch seems to have broken things on RZ/Five SoC, after reverting
> this patch I get to boot it back again on v6.9-rc2. Looks like there
> is some probe order issue after switching to platform driver?

Yes, this is most likely related to probe ordering based on your DT.

Can you share the failing boot log and DT ?

Regards,
Anup

>
> Cheers,
> Prabhakar
>
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-si=
five-plic.c
> > index 5b7bc4fd9517..7400a07fc479 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -64,6 +64,7 @@
> >  #define PLIC_QUIRK_EDGE_INTERRUPT      0
> >
> >  struct plic_priv {
> > +       struct device *dev;
> >         struct cpumask lmask;
> >         struct irq_domain *irqdomain;
> >         void __iomem *regs;
> > @@ -406,30 +407,50 @@ static int plic_starting_cpu(unsigned int cpu)
> >         return 0;
> >  }
> >
> > -static int __init __plic_init(struct device_node *node,
> > -                             struct device_node *parent,
> > -                             unsigned long plic_quirks)
> > +static const struct of_device_id plic_match[] =3D {
> > +       { .compatible =3D "sifive,plic-1.0.0" },
> > +       { .compatible =3D "riscv,plic0" },
> > +       { .compatible =3D "andestech,nceplic100",
> > +         .data =3D (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> > +       { .compatible =3D "thead,c900-plic",
> > +         .data =3D (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> > +       {}
> > +};
> > +
> > +static int plic_probe(struct platform_device *pdev)
> >  {
> >         int error =3D 0, nr_contexts, nr_handlers =3D 0, i;
> > -       u32 nr_irqs;
> > -       struct plic_priv *priv;
> > +       struct device *dev =3D &pdev->dev;
> > +       unsigned long plic_quirks =3D 0;
> >         struct plic_handler *handler;
> > +       struct plic_priv *priv;
> > +       bool cpuhp_setup;
> >         unsigned int cpu;
> > +       u32 nr_irqs;
> > +
> > +       if (is_of_node(dev->fwnode)) {
> > +               const struct of_device_id *id;
> > +
> > +               id =3D of_match_node(plic_match, to_of_node(dev->fwnode=
));
> > +               if (id)
> > +                       plic_quirks =3D (unsigned long)id->data;
> > +       }
> >
> >         priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> >         if (!priv)
> >                 return -ENOMEM;
> >
> > +       priv->dev =3D dev;
> >         priv->plic_quirks =3D plic_quirks;
> >
> > -       priv->regs =3D of_iomap(node, 0);
> > +       priv->regs =3D of_iomap(to_of_node(dev->fwnode), 0);
> >         if (WARN_ON(!priv->regs)) {
> >                 error =3D -EIO;
> >                 goto out_free_priv;
> >         }
> >
> >         error =3D -EINVAL;
> > -       of_property_read_u32(node, "riscv,ndev", &nr_irqs);
> > +       of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", &nr=
_irqs);
> >         if (WARN_ON(!nr_irqs))
> >                 goto out_iounmap;
> >
> > @@ -439,13 +460,13 @@ static int __init __plic_init(struct device_node =
*node,
> >         if (!priv->prio_save)
> >                 goto out_free_priority_reg;
> >
> > -       nr_contexts =3D of_irq_count(node);
> > +       nr_contexts =3D of_irq_count(to_of_node(dev->fwnode));
> >         if (WARN_ON(!nr_contexts))
> >                 goto out_free_priority_reg;
> >
> >         error =3D -ENOMEM;
> > -       priv->irqdomain =3D irq_domain_add_linear(node, nr_irqs + 1,
> > -                       &plic_irqdomain_ops, priv);
> > +       priv->irqdomain =3D irq_domain_add_linear(to_of_node(dev->fwnod=
e), nr_irqs + 1,
> > +                                               &plic_irqdomain_ops, pr=
iv);
> >         if (WARN_ON(!priv->irqdomain))
> >                 goto out_free_priority_reg;
> >
> > @@ -455,7 +476,7 @@ static int __init __plic_init(struct device_node *n=
ode,
> >                 int cpu;
> >                 unsigned long hartid;
> >
> > -               if (of_irq_parse_one(node, i, &parent)) {
> > +               if (of_irq_parse_one(to_of_node(dev->fwnode), i, &paren=
t)) {
> >                         pr_err("failed to parse parent for context %d.\=
n", i);
> >                         continue;
> >                 }
> > @@ -491,7 +512,7 @@ static int __init __plic_init(struct device_node *n=
ode,
> >
> >                 /* Find parent domain and register chained handler */
> >                 if (!plic_parent_irq && irq_find_host(parent.np)) {
> > -                       plic_parent_irq =3D irq_of_parse_and_map(node, =
i);
> > +                       plic_parent_irq =3D irq_of_parse_and_map(to_of_=
node(dev->fwnode), i);
> >                         if (plic_parent_irq)
> >                                 irq_set_chained_handler(plic_parent_irq=
,
> >                                                         plic_handle_irq=
);
> > @@ -533,20 +554,29 @@ static int __init __plic_init(struct device_node =
*node,
> >
> >         /*
> >          * We can have multiple PLIC instances so setup cpuhp state
> > -        * and register syscore operations only when context handler
> > -        * for current/boot CPU is present.
> > +        * and register syscore operations only once after context
> > +        * handlers of all online CPUs are initialized.
> >          */
> > -       handler =3D this_cpu_ptr(&plic_handlers);
> > -       if (handler->present && !plic_cpuhp_setup_done) {
> > -               cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
> > -                                 "irqchip/sifive/plic:starting",
> > -                                 plic_starting_cpu, plic_dying_cpu);
> > -               register_syscore_ops(&plic_irq_syscore_ops);
> > -               plic_cpuhp_setup_done =3D true;
> > +       if (!plic_cpuhp_setup_done) {
> > +               cpuhp_setup =3D true;
> > +               for_each_online_cpu(cpu) {
> > +                       handler =3D per_cpu_ptr(&plic_handlers, cpu);
> > +                       if (!handler->present) {
> > +                               cpuhp_setup =3D false;
> > +                               break;
> > +                       }
> > +               }
> > +               if (cpuhp_setup) {
> > +                       cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STAR=
TING,
> > +                                         "irqchip/sifive/plic:starting=
",
> > +                                         plic_starting_cpu, plic_dying=
_cpu);
> > +                       register_syscore_ops(&plic_irq_syscore_ops);
> > +                       plic_cpuhp_setup_done =3D true;
> > +               }
> >         }
> >
> > -       pr_info("%pOFP: mapped %d interrupts with %d handlers for"
> > -               " %d contexts.\n", node, nr_irqs, nr_handlers, nr_conte=
xts);
> > +       pr_info("%pOFP: mapped %d interrupts with %d handlers for %d co=
ntexts.\n",
> > +               to_of_node(dev->fwnode), nr_irqs, nr_handlers, nr_conte=
xts);
> >         return 0;
> >
> >  out_free_enable_reg:
> > @@ -563,20 +593,11 @@ static int __init __plic_init(struct device_node =
*node,
> >         return error;
> >  }
> >
> > -static int __init plic_init(struct device_node *node,
> > -                           struct device_node *parent)
> > -{
> > -       return __plic_init(node, parent, 0);
> > -}
> > -
> > -IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
> > -IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy =
systems */
> > -
> > -static int __init plic_edge_init(struct device_node *node,
> > -                                struct device_node *parent)
> > -{
> > -       return __plic_init(node, parent, BIT(PLIC_QUIRK_EDGE_INTERRUPT)=
);
> > -}
> > -
> > -IRQCHIP_DECLARE(andestech_nceplic100, "andestech,nceplic100", plic_edg=
e_init);
> > -IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_edge_init);
> > +static struct platform_driver plic_driver =3D {
> > +       .driver =3D {
> > +               .name           =3D "riscv-plic",
> > +               .of_match_table =3D plic_match,
> > +       },
> > +       .probe =3D plic_probe,
> > +};
> > +builtin_platform_driver(plic_driver);
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

