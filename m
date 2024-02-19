Return-Path: <linux-kernel+bounces-71055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD00A85A018
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97535281B70
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D92C24B2C;
	Mon, 19 Feb 2024 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZfZOs1ye"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5EE24214
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335952; cv=none; b=oPa0oU9SbWUrnYvl4H+0gE+B1313xVkjoLemwbZEPBbLTyS4SpIs12QJVPA1azvHYC9y1OY5gV9pnAfHdjYLk8Kx5NBRPCsdPNHvlEhV9Fkds0gHVtMny+IOtO8Icu2IpMgAMYMOj/fxbAa3jRU3A3t6pD8YG6Cr0E0Ql1dwXZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335952; c=relaxed/simple;
	bh=N9nunNqolWoHQ9jtyYVDUhqU0wlAtz5/DFbjp/E6MEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moe7jOcoWYsn0WQvlTdN2C7m3JAoueB0W8s6sEDr+SxhJALK6dn51BJWYgxaBTWn/oDTv8Y3QEcdGmFvdRFByp5a3cWXcIJ6G/bfna7mPcxGeOlPiZAZt9MDL1aehbhMPzH0/DKZvJLc3gdZSuXXfkF1Nv6pLi38n4Q5M83XBys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZfZOs1ye; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d1094b5568so54441601fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 01:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708335949; x=1708940749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naVcereUeVbO3/kpmJac5B2YT7rfwRkVivtJPUxX/Ps=;
        b=ZfZOs1yepMZ/+X74bNyoNknK8IFMGlFouNR323sArMSPje3AkgsUcXuSFCsHCNc5z8
         SeBav1xcuNb6bi4na7K9OhlbC7cRclvbKvX9t8a7H3TkyTPSLQaBuWh9auLvIBhvtsIt
         Q9hXvgvoIFYPi4wqv8Oc0YNA51yifVJth7F2HansNJJ5Al6kY9AMo5J3V1Gwz4QQY2TO
         oEaa1LLBdbFt2xnJ9MXs5khE4ENge/EjMeFhfwiIm6QRT+0x68oqElubsBX0/dkBuWVB
         ThoHyuUWKBIKjNgsJXAw5jLcLNY78PWw0xKO0US3u0nEXPRc8Syyl6DHaQMq1kn930Ca
         zWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708335949; x=1708940749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naVcereUeVbO3/kpmJac5B2YT7rfwRkVivtJPUxX/Ps=;
        b=N0yvTMDEm7Cur1UAjeDDPzv6QEm2STAMIO/bZ1K/uy7ruOVFetGTDQJbBf/mSOnRNn
         t2pJZVh9xps6odYIsf73sxhHnoxtMhk1ArwnSZcvE4s44nuFVriCCA2ybOS1Ba/grJj1
         CHrWfPupfSaN5ELH+F8Tk0aURS6Tagh0voTyKTnQdUcYsEp4v+rCJhS0f0jDv+sv2mJ5
         1hV53YxaFcRzT36N80PENhkg9qbGgB3aM9jmYuAbbFWcnQ1Uu6SBDYz71PsM/nid/q9I
         73R95i2ob5+vFS6Q7vmp3AmoXoRyYR7GtD3FTfhCZPom0ZPhXi9+Y2aFDwCVgjVPly9E
         l8sg==
X-Forwarded-Encrypted: i=1; AJvYcCUM7prYt9ARiAJglsxdTwBr6ao/1fkxqnEnfrJ4snE19pZDYd4X3xxoA5e/Cme5WrkS8aSAAEmdu8kMUlc5DleTCsk+Up8VkeYUj2nQ
X-Gm-Message-State: AOJu0YzlFBa2biylmBdXy/+DdA6SJGYHH8M8WYr/gNWAwHfuTIYaKd12
	H4O05HKOSS0O8N58SYfPwMOPX4tFCGRKGbvPmKzv8aYvglbedZID9bBp6TZz33YJA5U25Bsbjiq
	JiWi1YEky5TcWcGNi0A2Hxa6iHTLxNkVWF8T37g==
X-Google-Smtp-Source: AGHT+IGAijWJ2t6HYaGF6pJu0Y9VzBy2gwT9CAw6PjDoQnuVNOtC7X4VHfZDfslwVbPV/P3tZbkNIq5o09aA55e5Vhc=
X-Received: by 2002:a2e:a49a:0:b0:2d2:4315:4d8b with SMTP id
 h26-20020a2ea49a000000b002d243154d8bmr194214lji.2.1708335949088; Mon, 19 Feb
 2024 01:45:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <20240127161753.114685-24-apatel@ventanamicro.com> <8734tsce9o.ffs@tglx>
In-Reply-To: <8734tsce9o.ffs@tglx>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 19 Feb 2024 15:15:37 +0530
Message-ID: <CAK9=C2Vf63ZcETD-ja33tK11XARz+y5hg1dqjGP-bZTW-XNWHg@mail.gmail.com>
Subject: Re: [PATCH v12 23/25] irqchip/riscv-aplic: Add support for MSI-mode
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

On Sat, Feb 17, 2024 at 2:34=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Sat, Jan 27 2024 at 21:47, Anup Patel wrote:
> > We extend the existing APLIC irqchip driver to support MSI-mode for
> > RISC-V platforms having both wired interrupts and MSIs.
>
> We? Just s/We//

Okay, I will update.

>
> > +
> > +static void aplic_msi_irq_unmask(struct irq_data *d)
> > +{
> > +     aplic_irq_unmask(d);
> > +     irq_chip_unmask_parent(d);
> > +}
> > +
> > +static void aplic_msi_irq_mask(struct irq_data *d)
> > +{
> > +     aplic_irq_mask(d);
> > +     irq_chip_mask_parent(d);
> > +}
>
> Again asymmetric vs. unmask()

Okay, I will update.

>
> > +static void aplic_msi_irq_eoi(struct irq_data *d)
> > +{
> > +     struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> > +     u32 reg_off, reg_mask;
> > +
> > +     /*
> > +      * EOI handling only required only for level-triggered
> > +      * interrupts in APLIC MSI mode.
> > +      */
> > +
> > +     reg_off =3D APLIC_CLRIP_BASE + ((d->hwirq / APLIC_IRQBITS_PER_REG=
) * 4);
> > +     reg_mask =3D BIT(d->hwirq % APLIC_IRQBITS_PER_REG);
> > +     switch (irqd_get_trigger_type(d)) {
> > +     case IRQ_TYPE_LEVEL_LOW:
> > +             if (!(readl(priv->regs + reg_off) & reg_mask))
> > +                     writel(d->hwirq, priv->regs + APLIC_SETIPNUM_LE);
>
> A comment what this condition is for would be nice.

Okay, I will add a comment about the condition.

Regards,
Anup

