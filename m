Return-Path: <linux-kernel+bounces-74693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCF085D7DF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5C11C21B85
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97DF50A98;
	Wed, 21 Feb 2024 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="E1CTr8AD"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4451C4F8A2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708518257; cv=none; b=IDXrP5SYzW2hye3DGDqx9CwJm42hJcNqkqlZJ7t91/5PQUfj1iKWFHJv/FEGuD62X+DudMqb/LDHMDF7faUV9Prmo7WdODF67kuIZuewQ09jhTKWyeEkieEMI6m/lKZoRFgYUTrEYPLFe+uQ8/rHixXmWI5CU/yX5c1lYYIfugM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708518257; c=relaxed/simple;
	bh=Ywa3qbXnsG5Boc8jS5oivS1/lcbF/6GrnhNyJpzDnz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7AfxYFeS4fkWi2LnS0Z2prggGYtNeyMVMC8lQCDjOQlwfh4eQgtFgZoJyC7wH6Gz0+KPuUHe9FaWCKg3QiM8/4Uf/E9wzw38S+71nSgoktqdYxYQS9wts9F7imazzWECBgMCp2gvr/by8KD8XJjI97mAsBfK9GQ/y9piVrY6Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=E1CTr8AD; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so86766461fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 04:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708518253; x=1709123053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUIme5qeYaRlhQNYTF01QINk6od2pxuGi3LOwUcjfkA=;
        b=E1CTr8AD/236uyUycex4/GpqF66CVyG+rtdOvyahvwzKVlRtqkfjVuKpCYeN6luLbH
         8M6SX+dbij+MmUw7S+7QuhMC9B0A24r640d1atreHBJO+d1hRLyNDhCOvh4jDzW7wI44
         LB5Ny8swd8Sv3MlchyYStSWnHyfFh4If0LbMxY6drHydO0oKelmhYp2eibdzfsqIqSsy
         II0CvhFUmoE12/9/iZcU7c+5IomjQlcfFewfCvekC4DAgAq9lMqpFIxYEy4g2eIRw2RK
         ycN49KDoqDSqL8HRdf/kLRxLsAJvWrG4iIbiFubNbN3+ONhmPjD8LaxfsxoxwjSK1juU
         G99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708518253; x=1709123053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUIme5qeYaRlhQNYTF01QINk6od2pxuGi3LOwUcjfkA=;
        b=NyUWIdqUZvZSzAczDXWnFsuDdOyguGEzcAN7TNz5s9Axj+exqXAVGx+lS6z+ivcPXg
         BiuADXBTxHf8jTENOAIuN/e8JrmXXTbWD9agcp0FW7B8J9kZDna4x25RXX7uaEACq09G
         qSogDHKZ959alEqB9umJzSvQg7wqoiYEKVX+SErYI7ELCsAIQSRAE3LxaEHGSMRIehn5
         m73eK7dSY1akBtBTZB26Ni7rIrWuzzbcA6XFKRKCvZp/MuVWK9bo6MKxYEvkVJfyUetH
         NamCDTcg9i5fKLMLL6vdsFeyleQJksvBF8em+eXyIdWRZoRz4YoNlSxEVV5nsQNHt9PU
         j9gg==
X-Forwarded-Encrypted: i=1; AJvYcCUXqBb36e+GQOLGVNgFpK2PgoFEk++UqSyuzDOmCman7xkLwTYfTbEbQD5zVrRE7oLUw+yksuQ4IqXwC0puEriKA+GQIeKA9IV63czn
X-Gm-Message-State: AOJu0YzRoAa4oRadJbO2h9A8t/1psTD+zX36yI1xnRYosCsIz6VjxmUa
	Qb1nUkazWtprBFe9HQ2cXlyduYOcNHrHUP6kHTS75RKcTpwQz3sG9UqKatdlrbDsTc1Bn1y8wdm
	O35hjorNM/p2Fy4PBCPuTouT/glqF91uQlLsGOw==
X-Google-Smtp-Source: AGHT+IFIxepuQGxN+D9Kb9NUEDtcnq9gYao5N75v/vr0R/M/KZgmlpI69G1EL4fA7jCM0aZSkXlefLh6DeZwv/4hvLg=
X-Received: by 2002:a2e:9c84:0:b0:2d2:3ac4:d6e0 with SMTP id
 x4-20020a2e9c84000000b002d23ac4d6e0mr5799393lji.31.1708518253341; Wed, 21 Feb
 2024 04:24:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220060718.823229-1-apatel@ventanamicro.com>
 <20240220060718.823229-7-apatel@ventanamicro.com> <87frxnfj3p.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2Xnzg3KAVETXN+ZGLWhVtaJuU4uXs3WH2ZondkBJMHFcA@mail.gmail.com> <874je2yqn9.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <874je2yqn9.fsf@all.your.base.are.belong.to.us>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 21 Feb 2024 17:53:59 +0530
Message-ID: <CAK9=C2WXR49KZg3rstChqAHda+hUhPm3AEo6o2jh0NM3kvoSUA@mail.gmail.com>
Subject: Re: [PATCH v13 06/13] irqchip: Add RISC-V incoming MSI controller
 early driver
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>, Anup Patel <anup@brainfault.org>, 
	linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 5:29=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
org> wrote:
>
> Anup Patel <apatel@ventanamicro.com> writes:
>
> >> > +void imsic_vector_mask(struct imsic_vector *vec)
> >> > +{
> >> > +     struct imsic_local_priv *lpriv;
> >> > +
> >> > +     lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
> >> > +     if (WARN_ON(&lpriv->vectors[vec->local_id] !=3D vec))
> >> > +             return;
> >> > +
> >> > +     /*
> >> > +      * This function is called through Linux irq subsystem with
> >> > +      * irqs disabled so no need to save/restore irq flags.
> >> > +      */
> >> > +
> >> > +     raw_spin_lock(&lpriv->lock);
> >> > +
> >> > +     vec->enable =3D false;
> >> > +     bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
> >> > +     __imsic_remote_sync(lpriv, vec->cpu);
> >> > +
> >> > +     raw_spin_unlock(&lpriv->lock);
> >> > +}
> >>
> >> Really nice that you're using a timer for the vector affinity change,
> >> and got rid of the special/weird IMSIC/sync IPI. Can you really use a
> >> timer for mask/unmask? That makes the mask/unmask operation
> >> asynchronous!
> >>
> >> That was what I was trying to get though with this comment:
> >> https://lore.kernel.org/linux-riscv/87sf24mo1g.fsf@all.your.base.are.b=
elong.to.us/
> >>
> >> Also, using the smp_* IPI functions, you can pass arguments, so you
> >> don't need the dirty_bitmap tracking the changes.
> >
> > The mask/unmask operations are called with irqs disabled so if
> > CPU X does synchronous IPI to another CPU Y from mask/unmask
> > operation then while CPU X is waiting for IPI to complete it cannot
> > receive IPI from other CPUs which can lead to crashes and stalls.
> >
> > In general, we should not do any block/busy-wait work in
> > mask/unmask operation of an irqchip driver.
>
> Hmm, OK. Still, a bit odd that when the .irq_mask callback return, the
> masking is not actually completed.
>
> 1. CPU 0 tries to mask an interrupt tried to CPU 1.
> 2. The timer is queued on CPU 1.
> 3. The call irq_mask returns on CPU 0
> 4. ...the irq is masked at some future point, determined by the callback
>    at CPU 1
>
> Is that the expected outcome?

Yes, that's right.

>
> There are .irq_mask implementation that does seem to go at length
> (blocking) to perform the mask, e.g.: gic_mask_irq() which calls
> gic_{re,}dist_wait_for_rwp that have sleep/retry loops. The GIC3 ITS
> code has similar things going on.

The gic_{re,}dist_wait_for_rwp() polls on a HW register for completion
which will certainly complete in a predictable time whereas waiting
for IPI to be executed by another CPU is not predictable and fragile.

>
> I'm not saying you're wrong, I'm just trying to wrap my head around the
> masking semantics.
>
> > The AIA IMSIC spec allows setting ID pending bit using MSI write
> > irrespective whether ID is enabled or not but the interrupt will be
> > taken only after ID is enabled. In other words, there will be no
> > loss of interrupt with delayed mask/unmask using async IPI or
> > lazy timer.
>
> No loss, but we might *get* an interrupt when we explicitly asked not to
> get any. Maybe that's ok?
>

The delayed spurious interrupt after masking is avoided by additional
masking at the source of interrupt. For wired-to-MSI interrupts, we have
additional masking on the APLIC MSI-mode. For PCI MSI interrupts, we
have additional masking at PCI device level using pci_msi_mask_irq().

Regards,
Anup

