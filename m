Return-Path: <linux-kernel+bounces-73366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABDC85C180
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E058B261FF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA4F1E48F;
	Tue, 20 Feb 2024 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WwmlLA9j"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186BB76C63
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446826; cv=none; b=ZRZYay6W7mJfxgnqXApw4OhYRrCoK+zsECUxK78gZchBfMJNzU8v6cpj46TRJ2YquV2MF/lyYDM7BW1td5dtUqyhyMgFIwISn6ffjHLQUFJaQVbe0ivwEydihLHKDPtJ6bWZlETJkzkXzFkCFQmK9uMGdBO7rJzJhxLlIO1M8zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446826; c=relaxed/simple;
	bh=0st9GrLo9qneJ1X2cozJb/8z7udFJ6bJ5TuG75oNHDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OY9mA61YKmjc6GcVb/59owZ47YuHeb5+lPo9n0akRIGfSp384l6xpDrJVjGKxX4PTbSCx1j5iEbc39dGD86TBsJB9fNt1v5qzko1u8JX9GVAjCPpsMesmT1PgAAPahTRVS6wTEK2b5mYvgwrpIra19F53vla5+YZTO1Fvr2IxH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=WwmlLA9j; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512aafb3ca8so2616615e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708446823; x=1709051623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p25ro1Z6UmFNJOpkPhd7azDHdv/Ire7OveuzPMEDrco=;
        b=WwmlLA9jZb5v0d5c4Vmtnl8Qkl03eeUEDz9LJfmEMLoUKMMmsKNA18ERuFuPpabzA3
         sAfyNxCa/MNnaF/63fq9LwLelH6SmFLlbaHdWCWGvrHQr8/tBiN9WhY0D99d7aqL9Fzg
         WMVe89PUv0k2RQe6kLm8+ENXfArymm6xsg7njj1Osuavn7wiP3ZOCJY3RtnEudpFG+UK
         N+56snCkV0g6Eibs3060vnoM2LuGTzU5XaDRIOBcCGonL3RdfqrxzcjR8kcG7tMqzx5i
         7Hqm7RZRgS524kU82/LlO1onLkDMocmHu7NE0sC5+2ONpQ6DOSCkyjhvgH9ysWzHX1Zz
         Kk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708446823; x=1709051623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p25ro1Z6UmFNJOpkPhd7azDHdv/Ire7OveuzPMEDrco=;
        b=g/p7CLVcWJjZW/bRNE+r4kh8430PLnmGfV1P6Mf0Y+OZVfJgUujB3xSCP/tP9Dc7en
         AzSXfoWVvX7oGvlwSc/ZN3MyE5kOPv9jCKF91nOPuwbj6L2Ffx8wPhFD4gOGZYJ050hg
         p7433bS/xyQ2vP9xdPD4JGGdJhLXQdAz6bc1ZFQ9ZY5WlOetS7+irklbYGmrmhCWT1cS
         SF2V3FbJQRGFIPlLnUY0AXu33NVUc5Nmw7AAewpWtt2BNjndTqLYZMn+uzPgwV98KSrB
         c6GsEJsjYE/pz4EhRGNuBxfIB0XRWslX/MiYJ41jWlm4mnpQJXy35kDt4gpzm5ahHval
         e5xg==
X-Forwarded-Encrypted: i=1; AJvYcCXJdwRMMmVwQjNv3UztW1XsKOHDbqkV8DdzLwwHs2bLfoFiacFtqcGeUwXZ3K4f/qyA1ICpynteKA/CoFACm8jBeonttS3wt9hviW/U
X-Gm-Message-State: AOJu0YyhTCYFj6ote9ctIZ7wotwDv6KMmPtcbyPOyYrEp8z7zV7ZrJ+P
	wHM1OFIOmlpYcZvN6PQ62AwJY4K51bNyiXbdk4OES3O/RG5FuRXRhr5yP6tfYFmPRLm2H2lmQmi
	dLp59jLC6Y9OxMxDQA7Fp7zLUvb2p29ebJVcpwQ==
X-Google-Smtp-Source: AGHT+IFEg/QXz9A3XAObYPJXzmoOxIf/e+fzIofGOJqhDrldapT9nC1GUC4P6dVl9adY5fSs8xH8AWe5ez3rD0APoiA=
X-Received: by 2002:a05:6512:3d91:b0:512:9d11:ae00 with SMTP id
 k17-20020a0565123d9100b005129d11ae00mr9428461lfv.52.1708446822973; Tue, 20
 Feb 2024 08:33:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220060718.823229-1-apatel@ventanamicro.com>
 <20240220060718.823229-7-apatel@ventanamicro.com> <87a5nvi8dv.ffs@tglx>
In-Reply-To: <87a5nvi8dv.ffs@tglx>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 20 Feb 2024 22:03:31 +0530
Message-ID: <CAK9=C2XQVnoEEzjwnb7ZSM90vbdTU=9yteAYXOhbkSoDcEGnKg@mail.gmail.com>
Subject: Re: [PATCH v13 06/13] irqchip: Add RISC-V incoming MSI controller
 early driver
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

On Tue, Feb 20, 2024 at 6:45=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Tue, Feb 20 2024 at 11:37, Anup Patel wrote:
> > The RISC-V advanced interrupt architecture (AIA) specification
> > defines a new MSI controller called incoming message signalled
> > interrupt controller (IMSIC) which manages MSI on per-HART (or
> > per-CPU) basis. It also supports IPIs as software injected MSIs.
> > (For more details refer https://github.com/riscv/riscv-aia)
> >
> > Let us add an early irqchip driver for RISC-V IMSIC which sets
> > up the IMSIC state and provide IPIs.
>
> s/Let us add/Add/

Okay, I will update.

>
> > +#else
> > +static void imsic_ipi_starting_cpu(void)
> > +{
> > +}
> > +
> > +static void imsic_ipi_dying_cpu(void)
> > +{
> > +}
> > +
> > +static int __init imsic_ipi_domain_init(void)
> > +{
> > +     return 0;
> > +}
>
> Please condense this into
>
> static void imsic_ipi_starting_cpu(void) { }
> static void imsic_ipi_dying_cpu(void) { }
> static int __init imsic_ipi_domain_init(void) { return 0; }
>
> No point in wasting space for these stubs.

Sure, I will update.

>
> > + * To handle an interrupt, we read the TOPEI CSR and write zero in one
> > + * instruction. If TOPEI CSR is non-zero then we translate TOPEI.ID to
> > + * Linux interrupt number and let Linux IRQ subsystem handle it.
> > + */
> > +static void imsic_handle_irq(struct irq_desc *desc)
> > +{
> > +     struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +     int err, cpu =3D smp_processor_id();
> > +     struct imsic_vector *vec;
> > +     unsigned long local_id;
> > +
> > +     chained_irq_enter(chip, desc);
> > +
> > +     while ((local_id =3D csr_swap(CSR_TOPEI, 0))) {
> > +             local_id =3D local_id >> TOPEI_ID_SHIFT;
> > +
> > +             if (local_id =3D=3D IMSIC_IPI_ID) {
> > +#ifdef CONFIG_SMP
>
>         if (IS_ENABLED(CONFIG_SMP))

Okay, I will update.

>
> > +                     ipi_mux_process();
> > +#endif
> > +                     continue;
> > +             }
>
> > +
> > +/* MUST be called with lpriv->lock held */
>
> Instead of a comment which cannot be enforced just have
>
>         lockdep_assert_held(&lpriv->lock);
>
> right at the top of the function. That documents the requirement and
> lets lockdep yell if not followed.
>
> > +#ifdef CONFIG_SMP
> > +static void imsic_local_timer_callback(struct timer_list *timer)
> > +{
> > +     struct imsic_local_priv *lpriv =3D this_cpu_ptr(imsic->lpriv);
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&lpriv->lock, flags);
> > +     __imsic_local_sync(lpriv);
> > +     raw_spin_unlock_irqrestore(&lpriv->lock, flags);
> > +}
> > +
> > +/* MUST be called with lpriv->lock held */
>
> Ditto
>
> > +static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsign=
ed int cpu)
>
> > +void imsic_vector_mask(struct imsic_vector *vec)
> > +{
> > +     struct imsic_local_priv *lpriv;
> > +
> > +     lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
> > +     if (WARN_ON(&lpriv->vectors[vec->local_id] !=3D vec))
> > +             return;
>
> WARN_ON_ONCE(), no?
>
> > +bool imsic_vector_isenabled(struct imsic_vector *vec)
> > +{
> > +     struct imsic_local_priv *lpriv =3D per_cpu_ptr(imsic->lpriv, vec-=
>cpu);
> > +     unsigned long flags;
> > +     bool ret;
> > +
> > +     raw_spin_lock_irqsave(&lpriv->lock, flags);
> > +     ret =3D vec->enable;
> > +     raw_spin_unlock_irqrestore(&lpriv->lock, flags);
>
> I'm not sure what you are trying to protect here. vec->enable can
> obviously change right after the lock is dropped. So that's just a
> snapshot, which is not any better than using
>
>           READ_ONCE(vec->enable);
>
> and a corresponding WRITE_ONCE() at the update site, which obviously
> needs serialization.
>
> > +static void __init imsic_local_cleanup(void)
> > +{
> > +     int cpu;
> > +     struct imsic_local_priv *lpriv;
>
>         struct imsic_local_priv *lpriv;
>         int cpu;
>
> Please.
>
> > +void imsic_state_offline(void)
> > +{
> > +#ifdef CONFIG_SMP
> > +     struct imsic_local_priv *lpriv =3D this_cpu_ptr(imsic->lpriv);
> > +#endif
>
> You can move that into the #ifdef below.
>
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
> > +     irq_matrix_offline(imsic->matrix);
> > +     raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
> > +
> > +#ifdef CONFIG_SMP
> > +     raw_spin_lock_irqsave(&lpriv->lock, flags);
> > +     WARN_ON_ONCE(try_to_del_timer_sync(&lpriv->timer) < 0);
> > +     raw_spin_unlock_irqrestore(&lpriv->lock, flags);
> > +#endif
> > +}
>
>
> Thanks,
>
>         tglx

