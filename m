Return-Path: <linux-kernel+bounces-74671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE71C85D785
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43EA9B21605
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C8D48CC7;
	Wed, 21 Feb 2024 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7osNXPc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD19247A7A;
	Wed, 21 Feb 2024 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516766; cv=none; b=iYgVt52ESAbXWF/ysuRgBTystn0elpTHtgIr1V9O1QCVWN5QwTvnB738H3FuMZuOCsQBa3H4JlnRkn6t74aWx/XbywiXN4YD9erdE+0uthmKlMhxfD/iwIIhIwSsqTCRcZRdw36Rpaxp/Tj36H+cycuU8ef6q5rrgiD9kmXc46U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516766; c=relaxed/simple;
	bh=icr+Ws7AdDS8MhLtU6pYh5gnTY6nWC5oeWHCPgrtqac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=owZQUFcjHJzMR21BziImQjc1qzp2qJldyEQKiR1AfAqrWiKL94Mg8gohEQNB/JxZfWSGjXUcIv+JmeVkk3HFprioRS/d4jcJjLDjYaiBo8y8tGmQX/V9h1lhSyX4yYrKr+w1DcaZWZv/X+Tuq9gu0P+e+ARnLFXz2VTzCBXzkGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7osNXPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7916C433C7;
	Wed, 21 Feb 2024 11:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708516766;
	bh=icr+Ws7AdDS8MhLtU6pYh5gnTY6nWC5oeWHCPgrtqac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=b7osNXPcai2BCK0LMvdyyVsWjG8RLcrHGFG+6UbibZYadg2QRj/Z1m97e21ExmSir
	 oaIgimntM9xsZx7LwugvwJsbiyP9wjgCgJSNyamLpQLD7IrsCp8fKlSbI1jcVV9xK7
	 /D/P9Ly3/hwyJZQ8oVUDUNDuX/4NNKz7dH9hcOCb8gtPFRnNDAQ/7o5Mzn3WZ3D6Ar
	 MrNWSLpU4k9tIZNkBl5aK6z5RH8wg7h/2beqT0F9JWnbT6MdTJg0UONe6QvH1yBlB3
	 UgAhnRaDhOuDIPN84qqxS/sEjIi+j0qodNBdSHukYfN5Z7CLZTEJj4kuVpL1WW7hU3
	 klWq4Xxg8m6qw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, Saravana Kannan <saravanak@google.com>, Marc
 Zyngier <maz@kernel.org>, Anup Patel <anup@brainfault.org>,
 linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v13 06/13] irqchip: Add RISC-V incoming MSI controller
 early driver
In-Reply-To: <CAK9=C2Xnzg3KAVETXN+ZGLWhVtaJuU4uXs3WH2ZondkBJMHFcA@mail.gmail.com>
References: <20240220060718.823229-1-apatel@ventanamicro.com>
 <20240220060718.823229-7-apatel@ventanamicro.com>
 <87frxnfj3p.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2Xnzg3KAVETXN+ZGLWhVtaJuU4uXs3WH2ZondkBJMHFcA@mail.gmail.com>
Date: Wed, 21 Feb 2024 12:59:22 +0100
Message-ID: <874je2yqn9.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup Patel <apatel@ventanamicro.com> writes:

>> > +void imsic_vector_mask(struct imsic_vector *vec)
>> > +{
>> > +     struct imsic_local_priv *lpriv;
>> > +
>> > +     lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
>> > +     if (WARN_ON(&lpriv->vectors[vec->local_id] !=3D vec))
>> > +             return;
>> > +
>> > +     /*
>> > +      * This function is called through Linux irq subsystem with
>> > +      * irqs disabled so no need to save/restore irq flags.
>> > +      */
>> > +
>> > +     raw_spin_lock(&lpriv->lock);
>> > +
>> > +     vec->enable =3D false;
>> > +     bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
>> > +     __imsic_remote_sync(lpriv, vec->cpu);
>> > +
>> > +     raw_spin_unlock(&lpriv->lock);
>> > +}
>>
>> Really nice that you're using a timer for the vector affinity change,
>> and got rid of the special/weird IMSIC/sync IPI. Can you really use a
>> timer for mask/unmask? That makes the mask/unmask operation
>> asynchronous!
>>
>> That was what I was trying to get though with this comment:
>> https://lore.kernel.org/linux-riscv/87sf24mo1g.fsf@all.your.base.are.bel=
ong.to.us/
>>
>> Also, using the smp_* IPI functions, you can pass arguments, so you
>> don't need the dirty_bitmap tracking the changes.
>
> The mask/unmask operations are called with irqs disabled so if
> CPU X does synchronous IPI to another CPU Y from mask/unmask
> operation then while CPU X is waiting for IPI to complete it cannot
> receive IPI from other CPUs which can lead to crashes and stalls.
>
> In general, we should not do any block/busy-wait work in
> mask/unmask operation of an irqchip driver.

Hmm, OK. Still, a bit odd that when the .irq_mask callback return, the
masking is not actually completed.

1. CPU 0 tries to mask an interrupt tried to CPU 1.
2. The timer is queued on CPU 1.
3. The call irq_mask returns on CPU 0
4. ...the irq is masked at some future point, determined by the callback
   at CPU 1

Is that the expected outcome?

There are .irq_mask implementation that does seem to go at length
(blocking) to perform the mask, e.g.: gic_mask_irq() which calls
gic_{re,}dist_wait_for_rwp that have sleep/retry loops. The GIC3 ITS
code has similar things going on.

I'm not saying you're wrong, I'm just trying to wrap my head around the
masking semantics.

> The AIA IMSIC spec allows setting ID pending bit using MSI write
> irrespective whether ID is enabled or not but the interrupt will be
> taken only after ID is enabled. In other words, there will be no
> loss of interrupt with delayed mask/unmask using async IPI or
> lazy timer.

No loss, but we might *get* an interrupt when we explicitly asked not to
get any. Maybe that's ok?


Bj=C3=B6rn

