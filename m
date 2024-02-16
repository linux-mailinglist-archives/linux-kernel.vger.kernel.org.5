Return-Path: <linux-kernel+bounces-69045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0718583B8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E97282611
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4A2135406;
	Fri, 16 Feb 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="qjIK0WI6"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D41353EA
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103494; cv=none; b=DRaYbGrWKxqHuGA+WmMcsacpIqQasfjjT8RDnv3mp4GP6li6U74Gf74itR7ZkWdxS7K79aAMQii0XP0Ewi6mWpfS6nE8iWWssVIAMe2m0QtgkHEpHOP6f7u1u2bdRdEhf7o+3Iz/2vclj7H7zWm6IKiovArlNMOwdq1WyRgHMFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103494; c=relaxed/simple;
	bh=xjN1Txz0NRu+aYorD0V/0btXAZTtLNg0c38DLzxV7Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBMSEJPMmgaXaaz2yjXrf9VIgIpaSG7rzfChK2az1dFZtdjw8FpNrZOguNHm6VWmT5sNOBfm1mWDC8oPv2mvUqEMYI7FigvBNf6mEFOlunezPCRwNUc4kUnEl4XUP1lP7hr9Lb77vK0iU9dyzglnbab1YXKMAHxBJjqj61wbLnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=qjIK0WI6; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3642281e4a6so2703485ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1708103492; x=1708708292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=havUKwIuQeWK4aYu8DNjs5scwGn6QvvJ9tZ1EDA7AU4=;
        b=qjIK0WI6BMRxFfvwDqX8CyiSktGjxnchTLXvFuvFM50SO9VGc6oogg2SiMT/WCbSeN
         uruxBlVZvibuavftiMZgd9ia1yV259xp2iVSXT7Ch5DUE5P+/mAk1WwDrkv9f8xagaD7
         q+bQfXt7YqjWlG9KVJXhzUZVWlTfiOLQZgd8YV7jtP9TmBSh3roc+IZVCCQ5s4js2CSG
         ofBoqZtEksQv8CMrKmrqsYj14st/EYQ83jnaqNWzgaT9TM7VHr5gBUSjww7gbifaYc64
         W52Q8B2JVB9LXV+JFVF/5nnPqMorqB1SjuM2wj1A90xrk59mJOl9NiaT+J8Bde/4VpoJ
         0+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708103492; x=1708708292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=havUKwIuQeWK4aYu8DNjs5scwGn6QvvJ9tZ1EDA7AU4=;
        b=G51spBlKiIM2CQThAGEhdyFsebowSAzsWjceqwi3HHIb1QbfXoCpDOPQ7mJacegvUF
         dZSOdRN8vrL1FbdSl+Zf3A12ToKDsFix5ErZzufKmSm0WLcgLhqpBDZBEHF86feauqPp
         j9F9yfxVWeJU9Gu+Uj4MxYLWYN4JBdB9t4ZeChG1lBDO5MXruNXquCqGuAAIrAr3pNH/
         I9ZU1cnsXMaW0JLpRxAs6roIYB2JfDIg7K6s1UjIxQI5NF+mjmBBvnVe0Y3riltMEXB3
         bf4FJPtoh7aoHv4DXOtRm2Y/KidWbA3sdCksTYtDt9MT6BwRl4/fkaGTw9yQHyLCaWh6
         JvoA==
X-Forwarded-Encrypted: i=1; AJvYcCWreKvxy9Me9WIMsgi8uxHJ066w23b243cxO9sMsHimPQJtYsbu/qaeCVkUSgV6YMjC3EBlJBoqPeOQDrn9kVSC+1+YlUcJrFEuz1Nj
X-Gm-Message-State: AOJu0Yyo5rFZvNHnk68UcI53sw6nt9j1oB/1V4JK+ApmthfNZpRdyuSv
	AlAf/gqwz87/AlaKCOjwzA8k9nCEYsLGw17vVvQvTGLIYEiBvfh6E6yRY0ZEL+/q+NEcGEEtEh6
	MHv2bHqnC/Dnd78GZ7rRhYHP5p5VhVWW1nr43qQ==
X-Google-Smtp-Source: AGHT+IF3UAIIWYzEtaz8JDQbpsYiGjzgT5lx1iMPisr8gmFJym7YV9W/quLrJxzPRfygtku2OzFcTAaXVtDz1/yCGVc=
X-Received: by 2002:a92:c5a6:0:b0:364:1984:f10f with SMTP id
 r6-20020a92c5a6000000b003641984f10fmr4861690ilt.30.1708103492171; Fri, 16 Feb
 2024 09:11:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <20240127161753.114685-15-apatel@ventanamicro.com> <87jzn4ctks.ffs@tglx>
In-Reply-To: <87jzn4ctks.ffs@tglx>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 16 Feb 2024 22:41:20 +0530
Message-ID: <CAAhSdy2aeyJBcMVre12jGwU52oP9Z=1emB-bcYxygdR3QhP+6w@mail.gmail.com>
Subject: Re: [PATCH v12 14/25] irqchip/sifive-plic: Convert PLIC driver into a
 platform driver
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, Marc Zyngier <maz@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Atish Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, Saravana Kannan <saravanak@google.com>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 9:03=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Sat, Jan 27 2024 at 21:47, Anup Patel wrote:
> > +     priv->irqdomain =3D irq_domain_create_linear(dev->fwnode, nr_irqs=
 + 1,
> > +                                                &plic_irqdomain_ops, p=
riv);
> > +     if (WARN_ON(!priv->irqdomain))
> > +             return -ENOMEM;
>
> While some of the stuff is cleaned up by devm, the error handling in
> this code looks pretty fragile as it leaves initialized contexts,
> hardware state, chained handlers etc. around.

Sure, let me try to improve the error handling.

>
> The question is whether the system can actually boot or work at all if
> any of this fails.

On platforms with PLIC, the PLIC only manages wired interrupts
whereas IPIs are provided through SBI (firmware interface) so a
system can actually continue and boot further without PLIC.

In fact, we do have a synthetic platform (namely QEMU spike)
where there is no PLIC instance and Linux boots using SBI based
polling console.

>
> > +
> >       /*
> >        * We can have multiple PLIC instances so setup cpuhp state
> > -      * and register syscore operations only when context handler
> > -      * for current/boot CPU is present.
> > +      * and register syscore operations only after context handlers
> > +      * of all online CPUs are initialized.
> >        */
> > -     handler =3D this_cpu_ptr(&plic_handlers);
> > -     if (handler->present && !plic_cpuhp_setup_done) {
> > +     cpuhp_setup =3D true;
> > +     for_each_online_cpu(cpu) {
> > +             handler =3D per_cpu_ptr(&plic_handlers, cpu);
> > +             if (!handler->present) {
> > +                     cpuhp_setup =3D false;
> > +                     break;
> > +             }
> > +     }
> > +     if (cpuhp_setup) {
> >               cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
> >                                 "irqchip/sifive/plic:starting",
> >                                 plic_starting_cpu, plic_dying_cpu);
> >               register_syscore_ops(&plic_irq_syscore_ops);
> > -             plic_cpuhp_setup_done =3D true;
>
> I don't think that removing the setup protection is correct.
>
> Assume you have maxcpus=3DN on the kernel command line, then the above
> for_each_online_cpu() loop would result in cpuhp_setup =3D=3D true when t=
he
> instances for the not onlined CPUs are set up, no?

A platform can have multiple PLIC instances where each PLIC
instance targets a subset of HARTs (or CPUs).

Previously (before this patch), we were probing PLIC very early so on
a platform with multiple PLIC instances, we need to ensure that cpuhp
setup is done only after PLIC context associated with boot CPU is
initialized hence the plic_cpuhp_setup_done check.

This patch converts PLIC driver into a platform driver so now PLIC
instances are probed after all available CPUs are brought-up. In this
case, the cpuhp setup must be done only after PLIC context of all
available CPUs are initialized otherwise some of the CPUs crash
in plic_starting_cpu() due to lack of PLIC context initialization.

Regards,
Anup

