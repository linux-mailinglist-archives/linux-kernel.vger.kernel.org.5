Return-Path: <linux-kernel+bounces-73382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C8E85C1B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6031C21486
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D8076411;
	Tue, 20 Feb 2024 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Yt3067D/"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A7A69D01
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447936; cv=none; b=UEzwgEumzu4HWA9+Qa4XkwOij496kGKHrChfgj8qM9y0A7hvi/34Ro8EsDkjZqhdWoOHY7EVRhEINZHcLxX80PywRaY/ogT2l8/iSf4Avmnt0VbqXiOrqHPgPlkEagMmBuKBElQzoBWmZmkru8Ew2eL8K5KD0CdWieUaZSxPLc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447936; c=relaxed/simple;
	bh=0KagfdTaaRpyay3q3vPcuNyMIFOX9ngGtmUbeT9dqJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvHjZ+SEaPOpZj75Yu931k5xd1cCMvCrZD79NXH5MNNRlhxCPLKa9OhD7jYkhBY7RS4GANOltDYGauLIhpMZt1nfJDV0ImsO+OaB8Xa5bZVfOIiWU8JxAdKHdsycpbKT6eLO0/h6qXVlSJkYsiBroaOuCi7VQEmRztfhQXJfbvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Yt3067D/; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d22d0f8ad1so37013161fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708447933; x=1709052733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2++bzZmBlDUJtBL2A+1xjZvezhGxUTSfoR1tudvrmw=;
        b=Yt3067D/nXD8MHrpp4hHbbJp+tixBLLo26V6EtpsEE+EK9AqwQ4UB1m0hvq7hvZaVT
         EzhKcChAmlExo8D3qNIIN3LWsqCNB2EANdy4xrAxX8iwRfj/r8B/aS8Lr3q2xTZXk0xM
         6TpMF29EJiZXPGEsWfGzDCuBaZDcfsnHiNPYYnfEb4mV0q8sFcBRptOEDrTkNGWHAB9i
         PvI+imc8L+CQNy57DjYE0BrFzgAMDB+aB0fZcefqmvtWP0h8zY/hQ37wU8N8fPLTqxQQ
         vrtkEUCc0LNGR1POId+j0ny7CyX1I1+BvYpksKQouVKDkURthY0YTzeHP/QBC78rWCBG
         2sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708447933; x=1709052733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2++bzZmBlDUJtBL2A+1xjZvezhGxUTSfoR1tudvrmw=;
        b=Q9fCuR9UynyMs9XUWV16PigAgh5HqzPzpiztCRHVF2mV4cO1kkvI+GKhC+fGFU2TQn
         Sf7aLlY2dCpb1TcFx5OGZ1lZlDpEvgGQ/0AH0Z+WLQyLXV7uBEY9TDseLF8XP2hwlTa7
         AEIe4lCZgW2QCByZzv2QYFPeleKIzW6JGywJfWZNj3fQcCrgg7fMWjGmYS4y/0Fhzvdw
         423TYgOfJV5IWuopykze7TU+OCeJdUM2jejhedQ/nIKPt2i6j7P2rVV3lYTZVT3+pPY4
         9RNS5G2L4ueBvR0u1rcjPLyh8l6Jek3PI1tZR6NL+T0OwOx0JVZ3QfJiQHOV3Y2Tnrcg
         DBhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEyx9EDAi5hsj0EsXi0odnYYD594e+ZiSpG8+9EIv0hO5Rek0WXP4NWHWcGIB+avKpgBqe4ogPMwWbrp5bDgYGsu2usRm78f75Q8lW
X-Gm-Message-State: AOJu0YzaprRFkHkBZ8zArJdXwXYWblugG5K8bjPXD6ALfhq0gXries/e
	0vMfD6sqJtdjW4i7qyWI4kAEjrcfSVHuEW+3rsEVinaVJPz3W4TLGCwxLSIRgAOOxoq2gevwITG
	QlONxsglEX6We0HsjQ2tJ1hK+TwvxVyHqoqg1sg==
X-Google-Smtp-Source: AGHT+IFxn/XbcJ1LB10krZNF1aRmNeyYmzh22jCeeFItu7QL0ccN+D39sO7s3W7/K3hok3NiVql/DfBXEhGDD51v9UM=
X-Received: by 2002:a05:651c:1047:b0:2d2:3f05:d137 with SMTP id
 x7-20020a05651c104700b002d23f05d137mr3610001ljm.1.1708447932770; Tue, 20 Feb
 2024 08:52:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220060718.823229-1-apatel@ventanamicro.com>
 <20240220060718.823229-8-apatel@ventanamicro.com> <875xyji7mc.ffs@tglx>
In-Reply-To: <875xyji7mc.ffs@tglx>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 20 Feb 2024 22:22:01 +0530
Message-ID: <CAK9=C2V3hQnpibHgHUpwRXWn4LSuGue0a7Sh9NFYPB6XOizjoA@mail.gmail.com>
Subject: Re: [PATCH v13 07/13] irqchip/riscv-imsic: Add device MSI domain
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

On Tue, Feb 20, 2024 at 7:02=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Tue, Feb 20 2024 at 11:37, Anup Patel wrote:
> > +#ifdef CONFIG_SMP
> > +static void imsic_msi_update_msg(struct irq_data *d, struct imsic_vect=
or *vec)
> > +{
> > +     struct msi_msg msg[2] =3D { [1] =3D { }, };
>
> That's a weird initializer and why do you need an array here?
>
>        struct msi_msg msg =3D { };
>
> Should be sufficient, no?

I had taken reference from irq_msi_update_msg() in
arch/x86/kernel/apic/msi.c

I tried "struct msi_msg msg =3D { };" and it works fine so
I will update.

>
> > +
> > +     imsic_irq_compose_vector_msg(vec, msg);
> > +     irq_data_get_irq_chip(d)->irq_write_msi_msg(d, msg);
> > +}
>
> > +static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned =
int virq,
> > +                               unsigned int nr_irqs, void *args)
> > +{
> > +     struct imsic_vector *vec;
> > +
> > +     /* Legacy-MSI or multi-MSI not supported yet. */
>
> Coming back to my earlier question:
>
> >> What's legacy MSI in that context?
> >
> > The legacy-MSI is the MSI support in PCI v2.2 where
> > number of MSIs allocated by device were either 1, 2, 4,
> > 8, 16, or 32 and the data written is <data_word> + <irqnum>.
>
> You talk about PCI/MSI, where more than one vector is named
> multi-MSI. Contrary to the modern v3.0 variant which is PCI/MSI-X.
>
> So this should be "Multi-MSI is not supported yet", no?

Yes, I agree. We should just call it "Multi-MSI is not supported yet"
to avoid confusion. I will update.

>
> > +     if (nr_irqs > 1)
> > +             return -ENOTSUPP;
> > +
> > +     vec =3D imsic_vector_alloc(virq, cpu_online_mask);
> > +     if (!vec)
> > +             return -ENOSPC;
> > +
> > +     irq_domain_set_info(domain, virq, virq,
> > +                         &imsic_irq_base_chip, vec,
> > +                         handle_simple_irq, NULL, NULL);
>
> Please utilize the 100 characters.

Okay, I will update.

>
> > +     irq_set_noprobe(virq);
> > +     irq_set_affinity(virq, cpu_online_mask);
> > +
> > +     return 0;
> > +}
>
> Thanks,
>
>         tglx

Thanks,
Anup

