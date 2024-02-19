Return-Path: <linux-kernel+bounces-70697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57297859B41
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03BC1F21657
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665CAB67B;
	Mon, 19 Feb 2024 04:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="aoAEwim7"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ED463BF
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708315851; cv=none; b=KGSFCoV+80WPpcmjBV5Dv1/DBXGMX/uF0lyKOt27xZRort+ohoajlD/x5bGHYWAcYUr1pqwZhpYxJTOvg6oqnJIvk8h/cLv+70Vy4Hci8+JgYZ0KM30gGl9rjuY3vFZULkOuE6XcqeXrDyToefyhfUFyJXFPQ9iI5NbwQ8nF7KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708315851; c=relaxed/simple;
	bh=MNiOlQwCxdQTE2LkxWa35Suj5p4Uq7+niJe+XPHvMAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9VA9Qqtguzc1L9uL9CPFBs/fvDI8tdTR+Zf3IV9Xmrjc2AJZ0a2IO08iYYHwdg0SNJut97ojBYSNUWoqG/Iqd4em+FcHfbUStnqbouJGZU3926hHbC+JGy9NrnlCtFux78y14V4fxU2i99hdlqRU+ZJ9N1GGI6OkqQyybzmGAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=aoAEwim7; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512b4388dafso358816e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 20:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708315847; x=1708920647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSJX0E0lGzgCklhLOPs9/5otZxCSMrkz3Hl3lgIz64Q=;
        b=aoAEwim7td430AdJpC47nVT8B7QEsJ9lw709zXR8G9xvuUNTGuV/B4oPl63zf8VA9V
         drzhlI0DKmMhZ06YVJrLLTw3z9aGSyWnMeXQxti7ZlIRRRSyv2b5JuJtsBCuhA7YL17G
         jtfqTOIASFs8A0AOoHagYJz6Tnn3k5AiLd40QjCms0ZhwR/PhV2O5iooscYKSh0nxp8h
         B6NVWYP1ACacRwsXU8jRdfjMJCcfLHh6CQwmMgrzuCpGGkQAgaklBuMy2ksHI6ZL3rT6
         vp6MP3DFQ+kS5gfGJ1ozHrhV5GVuJm1zEuYV8KRYXzXZHSEbUkb/bEHT89TRTJ9g84Km
         fKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708315847; x=1708920647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSJX0E0lGzgCklhLOPs9/5otZxCSMrkz3Hl3lgIz64Q=;
        b=pTmOq9zpIUM+QndTak3qa86LLXdRZA4wl4/cDlM1YPuPhzFE3B9O5Epm/jV/qbQLq4
         iT4u3NtJqihQc7H2lWaC5y3hAwMAgC9n12cwL3E5TH+pcvbMFN3yAl+c6q46t9T7Uvv6
         yts0Y+iDEGJYYsXpTPqasGhfLZbCMwdjtinBjgtr5rP90S0rur/yCcC6lR6Srkwg2UY4
         yWk+nIQf+vnGDd8h3XInQTNVPL3zlQyTKvsHF3JzgE5lG5j1OWQs9Gy0eMgLEYIutYVE
         i3WB7Lzk0Vj6d/XPBWuNVq0jhp00161MquCdwKtuo9EeedEtE0tUed7Veekn7RBNYKZx
         npoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaDOSUxs8GhSVbt2poK9mVh53oAWfQ2i5Fuemn99+/yvJD1QXI35WzgeCBCGAktalPgyesqpgI48kJTV9+j5SNO6KSZD7137OAJ2EF
X-Gm-Message-State: AOJu0YxLFY/HkMLN5rvXntnqDvu4bZEMgAjC/xhy27hRuonvnLhAQEhS
	5bn6SmNCoCo90DfDdBmLcxWlA8g2SNkVnsGvMh2voozfTKFvH4viaabLYGtznry5w23UI/CrpSP
	C23ry5ezClJWC2wxKB7xcg2LNltbm/sOoVrXWOg==
X-Google-Smtp-Source: AGHT+IFXrBDhOps8+KLoDpgDGX0zeotDQUgEkGspEQp4WsWHRxO/1h8/vRFqOVdSq4bjng+KktDbQ+TtxJII0xh78w0=
X-Received: by 2002:a05:6512:3e14:b0:512:b932:7913 with SMTP id
 i20-20020a0565123e1400b00512b9327913mr252592lfv.41.1708315847272; Sun, 18 Feb
 2024 20:10:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <20240127161753.114685-20-apatel@ventanamicro.com> <87eddccgo7.ffs@tglx>
In-Reply-To: <87eddccgo7.ffs@tglx>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 19 Feb 2024 09:40:35 +0530
Message-ID: <CAK9=C2VK-sOtyhxnDH83WwMNQbetC-zLssZdYG399pBghU+yUw@mail.gmail.com>
Subject: Re: [PATCH v12 19/25] irqchip/riscv-imsic: Add device MSI domain
 support for platform devices
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
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

On Sat, Feb 17, 2024 at 1:42=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Sat, Jan 27 2024 at 21:47, Anup Patel wrote:
> > +static int imsic_cpu_page_phys(unsigned int cpu,
> > +                            unsigned int guest_index,
> > +                            phys_addr_t *out_msi_pa)
> > +{
> > +     struct imsic_global_config *global;
> > +     struct imsic_local_config *local;
> > +
> > +     global =3D &imsic->global;
> > +     local =3D per_cpu_ptr(global->local, cpu);
> > +
> > +     if (BIT(global->guest_index_bits) <=3D guest_index)
> > +             return -EINVAL;
>
> As the callsite does not care about the return value, just make this
> function boolean and return true on success.

Okay, I will update.

>
> > +     if (out_msi_pa)
> > +             *out_msi_pa =3D local->msi_pa +
> > +                           (guest_index * IMSIC_MMIO_PAGE_SZ);
> > +
> > +     return 0;
> > +}
> > +
> > +static void imsic_irq_mask(struct irq_data *d)
> > +{
> > +     imsic_vector_mask(irq_data_get_irq_chip_data(d));
> > +}
> > +
> > +static void imsic_irq_unmask(struct irq_data *d)
> > +{
> > +     imsic_vector_unmask(irq_data_get_irq_chip_data(d));
> > +}
> > +
> > +static int imsic_irq_retrigger(struct irq_data *d)
> > +{
> > +     struct imsic_vector *vec =3D irq_data_get_irq_chip_data(d);
> > +     struct imsic_local_config *local;
> > +
> > +     if (WARN_ON(vec =3D=3D NULL))
> > +             return -ENOENT;
> > +
> > +     local =3D per_cpu_ptr(imsic->global.local, vec->cpu);
> > +     writel(vec->local_id, local->msi_va);
> > +     return 0;
> > +}
> > +
> > +static void imsic_irq_compose_vector_msg(struct imsic_vector *vec,
> > +                                      struct msi_msg *msg)
> > +{
> > +     phys_addr_t msi_addr;
> > +     int err;
> > +
> > +     if (WARN_ON(vec =3D=3D NULL))
> > +             return;
> > +
> > +     err =3D imsic_cpu_page_phys(vec->cpu, 0, &msi_addr);
> > +     if (WARN_ON(err))
> > +             return;
>
>         if (WARN_ON(!imsic_cpu_page_phys(...)))
>                 return
> Hmm?

Okay, I will update like you suggested.

>
> > +
> > +     msg->address_hi =3D upper_32_bits(msi_addr);
> > +     msg->address_lo =3D lower_32_bits(msi_addr);
> > +     msg->data =3D vec->local_id;
> > +}
> > +
> > +static void imsic_irq_compose_msg(struct irq_data *d, struct msi_msg *=
msg)
> > +{
> > +     imsic_irq_compose_vector_msg(irq_data_get_irq_chip_data(d), msg);
> > +}
> > +
> > +#ifdef CONFIG_SMP
> > +static void imsic_msi_update_msg(struct irq_data *d, struct imsic_vect=
or *vec)
> > +{
> > +     struct msi_msg msg[2] =3D { [1] =3D { }, };
> > +
> > +     imsic_irq_compose_vector_msg(vec, msg);
> > +     irq_data_get_irq_chip(d)->irq_write_msi_msg(d, msg);
> > +}
> > +
> > +static int imsic_irq_set_affinity(struct irq_data *d,
> > +                               const struct cpumask *mask_val,
> > +                               bool force)
> > +{
> > +     struct imsic_vector *old_vec, *new_vec;
> > +     struct irq_data *pd =3D d->parent_data;
> > +
> > +     old_vec =3D irq_data_get_irq_chip_data(pd);
> > +     if (WARN_ON(old_vec =3D=3D NULL))
> > +             return -ENOENT;
> > +
> > +     /* Get a new vector on the desired set of CPUs */
> > +     new_vec =3D imsic_vector_alloc(old_vec->hwirq, mask_val);
> > +     if (!new_vec)
> > +             return -ENOSPC;
> > +
> > +     /* If old vector belongs to the desired CPU then do nothing */
> > +     if (old_vec->cpu =3D=3D new_vec->cpu) {
> > +             imsic_vector_free(new_vec);
> > +             return IRQ_SET_MASK_OK_DONE;
> > +     }
>
> You can spare that exercise by checking it before the allocation:
>
>         if (cpumask_test_cpu(old_vec->cpu, mask_val))
>                 return IRQ_SET_MASK_OK_DONE;

Okay, I will update.

>
> > +
> > +     /* Point device to the new vector */
> > +     imsic_msi_update_msg(d, new_vec);
>
> > +static int imsic_irq_domain_alloc(struct irq_domain *domain,
> > +                               unsigned int virq, unsigned int nr_irqs=
,
> > +                               void *args)
> > +{
> > +     struct imsic_vector *vec;
> > +     int hwirq;
> > +
> > +     /* Legacy-MSI or multi-MSI not supported yet. */
>
> What's legacy MSI in that context?

The legacy-MSI is the MSI support in PCI v2.2 where
number of MSIs allocated by device were either 1, 2, 4,
8, 16, or 32 and the data written is <data_word> + <irqnum>.

>
> > +     if (nr_irqs > 1)
> > +             return -ENOTSUPP;
> > +
> > +     hwirq =3D imsic_hwirq_alloc();
> > +     if (hwirq < 0)
> > +             return hwirq;
> > +
> > +     vec =3D imsic_vector_alloc(hwirq, cpu_online_mask);
> > +     if (!vec) {
> > +             imsic_hwirq_free(hwirq);
> > +             return -ENOSPC;
> > +     }
> > +
> > +     irq_domain_set_info(domain, virq, hwirq,
> > +                         &imsic_irq_base_chip, vec,
> > +                         handle_simple_irq, NULL, NULL);
> > +     irq_set_noprobe(virq);
> > +     irq_set_affinity(virq, cpu_online_mask);
> > +
> > +     /*
> > +      * IMSIC does not implement irq_disable() so Linux interrupt
> > +      * subsystem will take a lazy approach for disabling an IMSIC
> > +      * interrupt. This means IMSIC interrupts are left unmasked
> > +      * upon system suspend and interrupts are not processed
> > +      * immediately upon system wake up. To tackle this, we disable
> > +      * the lazy approach for all IMSIC interrupts.
>
> Why? Lazy works perfectly fine even w/o an irq_disable() callback.

This was suggested by SiFive folks. I am also not sure why we
need this. For now, I will drop this and bring it back as a separate
patch if required.

>
> > +      */
> > +     irq_set_status_flags(virq, IRQ_DISABLE_UNLAZY);
>
> > +
> > +#define MATCH_PLATFORM_MSI           BIT(DOMAIN_BUS_PLATFORM_MSI)
>
> You really love macro indirections :)

This is to be consistent with MATCH_PCI_MSI introduced by the
subsequent patch.

Also, this is inspired from your ARM GIC patches.
https://lore.kernel.org/linux-arm-kernel/20221121140049.038269899@linutroni=
x.de/
https://lore.kernel.org/linux-arm-kernel/20221121140049.112451419@linutroni=
x.de/
https://lore.kernel.org/linux-arm-kernel/20221121140049.237988384@linutroni=
x.de/
https://lore.kernel.org/linux-arm-kernel/20221121140049.941784867@linutroni=
x.de/

>
> > +static const struct msi_parent_ops imsic_msi_parent_ops =3D {
> > +     .supported_flags        =3D MSI_GENERIC_FLAGS_MASK,
> > +     .required_flags         =3D MSI_FLAG_USE_DEF_DOM_OPS |
> > +                               MSI_FLAG_USE_DEF_CHIP_OPS,
> > +     .bus_select_token       =3D DOMAIN_BUS_NEXUS,
> > +     .bus_select_mask        =3D MATCH_PLATFORM_MSI,
> > +     .init_dev_msi_info      =3D imsic_init_dev_msi_info,
> > +};
> > +
> > +int imsic_irqdomain_init(void)
> > +{
> > +     struct imsic_global_config *global;
> > +
> > +     if (!imsic || !imsic->fwnode) {
> > +             pr_err("early driver not probed\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     if (imsic->base_domain) {
> > +             pr_err("%pfwP: irq domain already created\n", imsic->fwno=
de);
> > +             return -ENODEV;
> > +     }
> > +
> > +     global =3D &imsic->global;
>
> Please move that assignment down to the usage site. Here it's just a
> distraction.

Okay, I will update.

>
> > +     /* Create Base IRQ domain */
> > +     imsic->base_domain =3D irq_domain_create_tree(imsic->fwnode,
> > +                                     &imsic_base_domain_ops, imsic);
> > +     if (!imsic->base_domain) {
> > +             pr_err("%pfwP: failed to create IMSIC base domain\n",
> > +                     imsic->fwnode);
> > +             return -ENOMEM;
> > +     }
> > +     imsic->base_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
> > +     imsic->base_domain->msi_parent_ops =3D &imsic_msi_parent_ops;
>

Regards,
Anup

