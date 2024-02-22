Return-Path: <linux-kernel+bounces-76620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E7485FA15
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B906B287A7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C78A1482EA;
	Thu, 22 Feb 2024 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="VE6d/x3O"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBA7134CF7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609368; cv=none; b=GXXmi6R1R2FuxCZPudFi0lfcR8jrXWguOkwhGOTp4KwEsoY+SEmUFItMexp0kKBrA2lJvBufAyYNB8cvK928brKHdPar9OJn49fD9b7J1byrxhjB93bENXCyUOXDMwFVbNFLbYWc/iqKG0bEOYc/WAlCcYyfjOc1y8KjaSPLOZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609368; c=relaxed/simple;
	bh=/I5UN6rS2bC58hGlKP/796JjqpYaIY/KO00PzS2YvPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEib6e3vUwDEhZab+3/h20B3+0B6cTWhat+8Yb7GuAS1Rv/00yXuxz9i5sieqJYMrqLx1BzvRYZnlifg84pENWiJqpCYz2MS7R/XbGC6SEyNkGIZ7IZN7zCpbtRvcNbFy40x92OGV2EKGSM0QSnfzmHpccjaLnZI0HFqg9w9g1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=VE6d/x3O; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36540b9885cso2265465ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1708609366; x=1709214166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+7F9iO3+mXH7VTYCtlMS4hTStlRmkU6oL8ws4qXJp4=;
        b=VE6d/x3O71lCMqh7FurUDQECqhgKKuD160QjCctwRnc2OrDtJQyixFwN+iZwYmEj0h
         7EvMQ5qrpHLzoncxdeg2yPn9ilY3VUx0rm63BJruohcby1m2/sZRv+ArC9jRZN34QWzM
         MpRMXIkPO9noiXWCMpnQuwanER9HhFbZJ1UFfyLpFTHZhutRQ/NmyFRgzz33ZPoIXiUq
         nTZedoisgvHe5Q9+RwSACdVbgSL1fr4x4uWkVhizR3V4QN5HIUaLIlDqHzsXN8NAtTCk
         xYihKMpQOQGtsQgzmXCOm53aGwVTfT6K2EKLlNJNxI8oJvQOrOrTVpX5nOSBZBv9G250
         yz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708609366; x=1709214166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+7F9iO3+mXH7VTYCtlMS4hTStlRmkU6oL8ws4qXJp4=;
        b=gs+OaMbnajgHI6DQD1F3ZuzgRllLF9S4ZEZh/08WDG00Ga4QDf/yOuSNfjQPosk2AB
         NHfoHmFM+sfa2w+ZAblza2D8301DHNeQGjTeub7ReO9fVBPQqPJ8CI8bncfArx7q0h+I
         3sUpgtwofeDoxW93Cx+6M1zoXJg2W3L/IuWtAmdaMZLYqN35wsopQ4aSKfPRmXPT1RKY
         MnC1zfwyILM9Du5Rzxnd+B2loTstLtADAVbMXhvAbIkifN/nU1a1W6uDGH3JiFJjTGyh
         Lc1SvGquqcMn6AMuxnY7cQkREdvamAVluvrHAF4cx5QYulQvJryzaqO2SzjJrLx39TMQ
         rtww==
X-Forwarded-Encrypted: i=1; AJvYcCXtiH5TqZFpurFVSITZypKBIr4Rk1tYv0WCcBiNNwi6LsMiFuk/8uC2BUk0E8k7KzC7U0DniHxgBe9GblegJfPw7Q/fQSHyhiiT2vf0
X-Gm-Message-State: AOJu0Yy5jJZiM3Nt+JSlaFUpmUf8oqg0yelflBGNcB82EJJN8vrr2Gb/
	gTIvLq5iKtfddIIlxr3a2e6JB6P+oL7VC4UsegDEsAg7yXFhKvGwNhcoiaaoFywpmaBIyulCWIf
	Py7bS1/i+HpF5ciPDKt2DFjmGT9B1/iUwwjhMww==
X-Google-Smtp-Source: AGHT+IEyGdfc6Ws9njPn029lfsFwPuHczKy9SK/OVm6bvBMUwZvIOc12u/317tQ6sjiK/ka/7zNZhB+Ci3N/uVtu2f4=
X-Received: by 2002:a05:6e02:1a6a:b0:363:86dd:b35 with SMTP id
 w10-20020a056e021a6a00b0036386dd0b35mr2188181ilv.10.1708609365653; Thu, 22
 Feb 2024 05:42:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
 <20240222094006.1030709-12-apatel@ventanamicro.com> <87r0h4tzeq.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87r0h4tzeq.fsf@all.your.base.are.belong.to.us>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 22 Feb 2024 19:12:34 +0530
Message-ID: <CAAhSdy3R9TCHG13vFk=sF0MvA60LtxOs9NbjSB7XBk+v1+XH4w@mail.gmail.com>
Subject: Re: [PATCH v14 11/18] irqchip: Add RISC-V incoming MSI controller
 early driver
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
	Atish Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 6:43=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
org> wrote:
>
> Anup Patel <apatel@ventanamicro.com> writes:
>
> > diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/=
irq-riscv-imsic-state.c
> > new file mode 100644
> > index 000000000000..0c19ffb9ca3e
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-riscv-imsic-state.c
> > @@ -0,0 +1,870 @@
>
> [...]
>
> > +static void __imsic_local_sync(struct imsic_local_priv *lpriv)
> > +{
> > +     struct imsic_local_config *mlocal;
> > +     struct imsic_vector *vec, *mvec;
> > +     int i;
> > +
> > +     lockdep_assert_held(&lpriv->lock);
> > +
> > +     /* This pairs with the barrier in __imsic_remote_sync(). */
> > +     smp_mb();
>
> I'm trying to figure out why this barrier is needed? All the updates are
> done behind the spinlocks. If there're some ordering constraints that
> I'm missing, please document them.
>
> > +
> > +     for_each_set_bit(i, lpriv->dirty_bitmap, imsic->global.nr_ids + 1=
) {
> > +             if (!i || i =3D=3D IMSIC_IPI_ID)
> > +                     goto skip;
> > +             vec =3D &lpriv->vectors[i];
> > +
> > +             if (READ_ONCE(vec->enable))
> > +                     __imsic_id_set_enable(i);
> > +             else
> > +                     __imsic_id_clear_enable(i);
> > +
> > +             /*
> > +              * If the ID was being moved to a new ID on some other CP=
U
> > +              * then we can get a MSI during the movement so check the
> > +              * ID pending bit and re-trigger the new ID on other CPU
> > +              * using MMIO write.
> > +              */
> > +             mvec =3D READ_ONCE(vec->move);
> > +             WRITE_ONCE(vec->move, NULL);
>
> mvec =3D xchg(&vec->move, NULL) ?

The __imsic_local_sync() is called with spinlock held.

>
> > +             if (mvec && mvec !=3D vec) {
> > +                     if (__imsic_id_read_clear_pending(i)) {
> > +                             mlocal =3D per_cpu_ptr(imsic->global.loca=
l, mvec->cpu);
> > +                             writel_relaxed(mvec->local_id, mlocal->ms=
i_va);
> > +                     }
> > +
> > +                     imsic_vector_free(&lpriv->vectors[i]);
> > +             }
> > +
> > +skip:
> > +             bitmap_clear(lpriv->dirty_bitmap, i, 1);
> > +     }
> > +}
> > +
> > +void imsic_local_sync_all(void)
> > +{
> > +     struct imsic_local_priv *lpriv =3D this_cpu_ptr(imsic->lpriv);
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&lpriv->lock, flags);
> > +     bitmap_fill(lpriv->dirty_bitmap, imsic->global.nr_ids + 1);
> > +     __imsic_local_sync(lpriv);
> > +     raw_spin_unlock_irqrestore(&lpriv->lock, flags);
> > +}
> > +
> > +void imsic_local_delivery(bool enable)
> > +{
> > +     if (enable) {
> > +             imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_ENABLE_EITHRESHO=
LD);
> > +             imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_ENABLE_EIDELIVERY=
);
> > +             return;
> > +     }
> > +
> > +     imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_DISABLE_EIDELIVERY);
> > +     imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_DISABLE_EITHRESHOLD);
> > +}
> > +
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
> > +static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsign=
ed int cpu)
> > +{
> > +     lockdep_assert_held(&lpriv->lock);
> > +
> > +     /*
> > +      * Ensure that changes to vector enable, vector move and
> > +      * dirty bitmap are visible to the target CPU.
>
> ...which case the spinlock(s) are enough, no?

spinlocks are not fences.

If the timer wheel on the target cpu is already running and we don't
have a fence here then the target cpu might not see the changes
done by this cpu.

>
> > +      *
> > +      * This pairs with the barrier in __imsic_local_sync().
> > +      */
> > +     smp_mb();
> > +
> > +     /*
> > +      * We schedule a timer on the target CPU if the target CPU is not
> > +      * same as the current CPU. An offline CPU will unconditionally
> > +      * synchronize IDs through imsic_starting_cpu() when the
> > +      * CPU is brought up.
> > +      */
> > +     if (cpu_online(cpu)) {
> > +             if (cpu =3D=3D smp_processor_id()) {
> > +                     __imsic_local_sync(lpriv);
> > +                     return;
> > +             }
>
> Maybe move this if-clause out from the cpu_online(), and only have
> something like
>   if (cpu_online(cpu) && !timer_pending(&lpriv->timer)) { ... }
> inside the CONFIG_SMP guard...
>
> > +
> > +             if (!timer_pending(&lpriv->timer)) {
> > +                     lpriv->timer.expires =3D jiffies + 1;
> > +                     add_timer_on(&lpriv->timer, cpu);
> > +             }
> > +     }
> > +}
> > +#else
> > +static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsign=
ed int cpu)
> > +{
> > +     lockdep_assert_held(&lpriv->lock);
> > +     __imsic_local_sync(lpriv);
> > +}
> > +#endif
>
> ...where we can get rid of this special !SMP all together for this
> function.

I failed to understand what is wrong the current code.

>
> > +
> > +void imsic_vector_mask(struct imsic_vector *vec)
> > +{
> > +     struct imsic_local_priv *lpriv;
> > +
> > +     lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
> > +     if (WARN_ON_ONCE(&lpriv->vectors[vec->local_id] !=3D vec))
> > +             return;
> > +
> > +     /*
> > +      * This function is called through Linux irq subsystem with
> > +      * irqs disabled so no need to save/restore irq flags.
> > +      */
> > +
> > +     raw_spin_lock(&lpriv->lock);
> > +
> > +     vec->enable =3D false;
>
> Should have WRITE_ONCE to make the checkers happy.

Okay, I will update.

>
> > +     bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
> > +     __imsic_remote_sync(lpriv, vec->cpu);
> > +
> > +     raw_spin_unlock(&lpriv->lock);
> > +}
> > +
> > +void imsic_vector_unmask(struct imsic_vector *vec)
> > +{
> > +     struct imsic_local_priv *lpriv;
> > +
> > +     lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
> > +     if (WARN_ON_ONCE(&lpriv->vectors[vec->local_id] !=3D vec))
> > +             return;
> > +
> > +     /*
> > +      * This function is called through Linux irq subsystem with
> > +      * irqs disabled so no need to save/restore irq flags.
> > +      */
> > +
> > +     raw_spin_lock(&lpriv->lock);
> > +
> > +     vec->enable =3D true;
>
> Dito.

Okay, I will update.

>
> > +     bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
> > +     __imsic_remote_sync(lpriv, vec->cpu);
> > +
> > +     raw_spin_unlock(&lpriv->lock);
> > +}
> > +
> > +static bool imsic_vector_move_update(struct imsic_local_priv *lpriv, s=
truct imsic_vector *vec,
> > +                                  bool new_enable, struct imsic_vector=
 *new_move)
> > +{
> > +     unsigned long flags;
> > +     bool enabled;
> > +
> > +     raw_spin_lock_irqsave(&lpriv->lock, flags);
> > +
> > +     /* Update enable and move details */
> > +     enabled =3D READ_ONCE(vec->enable);
> > +     WRITE_ONCE(vec->enable, new_enable);
>
> Again, xchg() would be easier to read.

why ? spinlock is not enough?

Regards,
Anup

