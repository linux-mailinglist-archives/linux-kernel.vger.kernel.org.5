Return-Path: <linux-kernel+bounces-70398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765B8859714
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 14:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C41F1C20B09
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 13:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE8E6BB5F;
	Sun, 18 Feb 2024 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fP+S/noi"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA51D6BB4C
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708262192; cv=none; b=Gr02lA3Nj93foB/yxj8Cnq9sTP7fXEwKuiHlw7lrHIU5dm/x7zQS6kwsv2qg1JsDZFJ5q7AyUTo9Yk6MoKdMtcmK0brrE5Ahx8ftqfBaZRrrsZPEIABea3p7ZO5jfWpgGNMwd1KZXsiQJOTWZGlDK4HrbGd7Hy0TAZp+VnrXTvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708262192; c=relaxed/simple;
	bh=tGjyG5Es/u5e2EQ6MEX6Kwwb292/TdG8Dg8mvMuWJjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uR+DzR1Je1457WpIW5U6oxBqYg9ws6UgYnIIfrCNAhBSfsgHWy07nXC3x7ym2F8WyZ9E3QLyU3v31zg1aV9sllCtZR5NfiOctxXlvlk3gsnoNy5BPsvbmgtLdnU99qMbhBNT67EvR4knDqRcTd3w/9A0JYfbzb4J3gkLacbOeVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fP+S/noi; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so30437871fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 05:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708262188; x=1708866988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTnKqfoHT1ASyWl8mfZgt45UxVbowkxAeoQ3Mo9HwXc=;
        b=fP+S/noiSi4vwyBEwPakOJLNPm8ttOyNDTLE1X0AlwmBKVbiKHLhOzfePyTyIpEezq
         +uDaE7RENlZY2ZvQKbKx3nqYEXmrMnglMEEIqZ/iO7BLKaY9U6iiREhy+waz+PkegjDz
         zTLKes4wRBGOMxgLe6oOxx8g66D0rGjcJWS1svyI8NSMHMg+KoejCpaChJfH3W80aTa8
         ha/d6Z7rNBqTbEWIODpHnGdmIm/x5gdCzXhqMaIfbhzHG/E9pNwiSoB3AOsS22t8WugB
         ciBVlIHidMtHpLnj1F+4A35A1VhqQE0zWLs6AzihDV1qzBVW6HAMeG858qE4qY5GlauT
         Gy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708262188; x=1708866988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTnKqfoHT1ASyWl8mfZgt45UxVbowkxAeoQ3Mo9HwXc=;
        b=k1Stb48zt9BMXKnihvRtqrNlOu6lngI2xh0Kq8cO9KzCik+h1C0AICZBcYtJQ09Oja
         2AfWz+cbcduNPIQv9+lJgiu++m/UR4rDSD0T2hUmBHhDRtEfE/SV/ChcygBThAMeqZxu
         3fmnUorhG/bv8xwN7gn5xv9ndB1eJhylR/I2EGKelssKvA9seYKh45JDgv/RAV7xN1No
         Y2AiBCKdQWnZUeqgeHc6ih35sP//c6IczL0iYrw0yqkKSdEWQfKxsv6+hMj7aSV97/vL
         5m+ML+sW/0s6Gge0FL90VXlwDsz6e0kIjRn/kguzJna2b1wkhwizKJws+5naS6Zt8P3A
         kW9w==
X-Forwarded-Encrypted: i=1; AJvYcCU0NnPTwrXkL/9RoNgwP3MxKrUsoD9fdaHKWGFUsM6vN0jJ4cuQbUHVllqR5yUjPjW34MhncdVeQyBruc2GlRf13Cy9kf4pn/yOhaSJ
X-Gm-Message-State: AOJu0YxC24c0Zhwxoo5BKr521bETSUnh0yPo0/d1VgshODlOeghyxM1V
	0jVZTwsUuTM5rKZazqbkK4yPtrqP9auHixKu7IhvIeGy1eROmaRj9uqg6dGIym27MUUUmEgZ4FD
	7xH+tx1SmxEqdgIKBo1CrdA68Nhh6VxfRgqNFGg==
X-Google-Smtp-Source: AGHT+IEhxFBrsWmO2v/7lmMxvcC+n0VDEv/TG5Px5+CBrsNKIhqLY2D6BWfanaJoMUHX54FRaPuMYuvAUjE+oMrz4O0=
X-Received: by 2002:a2e:9083:0:b0:2d2:3a0d:b36e with SMTP id
 l3-20020a2e9083000000b002d23a0db36emr163129ljg.44.1708262187577; Sun, 18 Feb
 2024 05:16:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <20240127161753.114685-19-apatel@ventanamicro.com> <87h6i8ckwg.ffs@tglx>
In-Reply-To: <87h6i8ckwg.ffs@tglx>
From: Anup Patel <apatel@ventanamicro.com>
Date: Sun, 18 Feb 2024 18:46:14 +0530
Message-ID: <CAK9=C2XvYB8qrTvxKvtXspdfiKUro89t-oLRVzeMqczDbG7nrQ@mail.gmail.com>
Subject: Re: [PATCH v12 18/25] irqchip: Add RISC-V incoming MSI controller
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

On Sat, Feb 17, 2024 at 12:10=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Sat, Jan 27 2024 at 21:47, Anup Patel wrote:
> > +
> > +#ifdef CONFIG_SMP
> > +static irqreturn_t imsic_local_sync_handler(int irq, void *data)
> > +{
> > +     imsic_local_sync();
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static void imsic_ipi_send(unsigned int cpu)
> > +{
> > +     struct imsic_local_config *local =3D
> > +                             per_cpu_ptr(imsic->global.local, cpu);
>
> Let it stick out. We switched to line length 100 quite some time
> ago. Applies to the rest of the series too.

Okay, I will update.

>
> > +     writel_relaxed(IMSIC_IPI_ID, local->msi_va);
> > +}
> > +
> > +static void imsic_ipi_starting_cpu(void)
> > +{
> > +     /* Enable IPIs for current CPU. */
> > +     __imsic_id_set_enable(IMSIC_IPI_ID);
> > +
> > +     /* Enable virtual IPI used for IMSIC ID synchronization */
> > +     enable_percpu_irq(imsic->ipi_virq, 0);
> > +}
> > +
> > +static void imsic_ipi_dying_cpu(void)
> > +{
> > +     /*
> > +      * Disable virtual IPI used for IMSIC ID synchronization so
> > +      * that we don't receive ID synchronization requests.
> > +      */
> > +     disable_percpu_irq(imsic->ipi_virq);
>
> Shouldn't this disable the hardware too, i.e.
>
>           __imsic_id_clear_enable()
>
> ?

Yes, it should but somehow I missed and never saw any issue.

I will update.

>
> > +}
> > +
> > +static int __init imsic_ipi_domain_init(void)
> > +{
> > +     int virq;
> > +
> > +     /* Create IMSIC IPI multiplexing */
> > +     virq =3D ipi_mux_create(IMSIC_NR_IPI, imsic_ipi_send);
> > +     if (virq <=3D 0)
> > +             return (virq < 0) ? virq : -ENOMEM;
> > +     imsic->ipi_virq =3D virq;
> > +
> > +     /* First vIRQ is used for IMSIC ID synchronization */
> > +     virq =3D request_percpu_irq(imsic->ipi_virq, imsic_local_sync_han=
dler,
> > +                               "riscv-imsic-lsync", imsic->global.loca=
l);
> > +     if (virq)
> > +             return virq;
>
> Please use a separate 'ret' variable. I had to read this 3 times to make
> sense of it.

Okay, I will update.

>
> > +     irq_set_status_flags(imsic->ipi_virq, IRQ_HIDDEN);
> > +     imsic->ipi_lsync_desc =3D irq_to_desc(imsic->ipi_virq);
>
> What's so special about this particular IPI that it can't be handled
> like all the other IPIs?

We are using this special under-the-hood IPI for synchronization
of IRQ enable/disable and IRQ movement across CPUs.

x86 has a more lazy approach of using a per-CPU timer so in
the next revision I will move to a similar approach. This means
both "ipi_virq" and "ipi_lsync_desc" will go away.

>
> > +static int __init imsic_early_probe(struct fwnode_handle *fwnode)
> > +{
> > +     int rc;
> > +     struct irq_domain *domain;
>
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variab=
le-declarations

Okay, I will update.

>
> > +
> > +     /* Find parent domain and register chained handler */
> > +     domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode(),
> > +                                       DOMAIN_BUS_ANY);
> > +     if (!domain) {
> > +             pr_err("%pfwP: Failed to find INTC domain\n", fwnode);
> > +             return -ENOENT;
> > +     }
> > +     imsic_parent_irq =3D irq_create_mapping(domain, RV_IRQ_EXT);
> > +     if (!imsic_parent_irq) {
> > +             pr_err("%pfwP: Failed to create INTC mapping\n", fwnode);
> > +             return -ENOENT;
> > +     }
> > +     irq_set_chained_handler(imsic_parent_irq, imsic_handle_irq);
> > +
> > +     /* Initialize IPI domain */
> > +     rc =3D imsic_ipi_domain_init();
> > +     if (rc) {
> > +             pr_err("%pfwP: Failed to initialize IPI domain\n", fwnode=
);
> > +             return rc;
>
> Leaves the chained handler around and enabled.

Okay, I will set the chained hander after imsic_ipi_domain_init().

>
> > diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/=
irq-riscv-imsic-state.c
> > +
> > +#define imsic_csr_write(__c, __v)            \
> > +do {                                         \
> > +     csr_write(CSR_ISELECT, __c);            \
> > +     csr_write(CSR_IREG, __v);               \
> > +} while (0)
>
> Any reason why these macros can't be inlines?

No particular reason. I am fine with both maros and inline functions.

I will update in the next revision.

>
> > +const struct imsic_global_config *imsic_get_global_config(void)
> > +{
> > +     return imsic ? &imsic->global : NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(imsic_get_global_config);
>
> Why is this exported?

This is for the KVM RISC-V module. We have follow up
KVM RISC-V patchs which need to know the IMSIC global
configuration so that it can assign IMSIC guest files to a
Guest/VM.

>
> > +#define __imsic_id_read_clear_enabled(__id)          \
> > +     __imsic_eix_read_clear((__id), false)
> > +#define __imsic_id_read_clear_pending(__id)          \
> > +     __imsic_eix_read_clear((__id), true)
>
> Please use inlines.

Okay, I will update.

>
> > +void __imsic_eix_update(unsigned long base_id,
> > +                     unsigned long num_id, bool pend, bool val)
> > +{
> > +     unsigned long i, isel, ireg;
> > +     unsigned long id =3D base_id, last_id =3D base_id + num_id;
> > +
> > +     while (id < last_id) {
> > +             isel =3D id / BITS_PER_LONG;
> > +             isel *=3D BITS_PER_LONG / IMSIC_EIPx_BITS;
> > +             isel +=3D (pend) ? IMSIC_EIP0 : IMSIC_EIE0;
> > +
> > +             ireg =3D 0;
> > +             for (i =3D id & (__riscv_xlen - 1);
> > +                  (id < last_id) && (i < __riscv_xlen); i++) {
> > +                     ireg |=3D BIT(i);
> > +                     id++;
> > +             }
>
> This lacks a comment what this is doing.

Okay, I will add a comment block.

>
> > +
> > +             /*
> > +              * The IMSIC EIEx and EIPx registers are indirectly
> > +              * accessed via using ISELECT and IREG CSRs so we
> > +              * need to access these CSRs without getting preempted.
> > +              *
> > +              * All existing users of this function call this
> > +              * function with local IRQs disabled so we don't
> > +              * need to do anything special here.
> > +              */
> > +             if (val)
> > +                     imsic_csr_set(isel, ireg);
> > +             else
> > +                     imsic_csr_clear(isel, ireg);
> > +     }
> > +}
> > +
> > +void imsic_local_sync(void)
> > +{
> > +     struct imsic_local_priv *lpriv =3D this_cpu_ptr(imsic->lpriv);
> > +     struct imsic_local_config *mlocal;
> > +     struct imsic_vector *mvec;
> > +     unsigned long flags;
> > +     int i;
> > +
> > +     raw_spin_lock_irqsave(&lpriv->ids_lock, flags);
> > +     for (i =3D 1; i <=3D imsic->global.nr_ids; i++) {
> > +             if (i =3D=3D IMSIC_IPI_ID)
> > +                     continue;
> > +
> > +             if (test_bit(i, lpriv->ids_enabled_bitmap))
> > +                     __imsic_id_set_enable(i);
> > +             else
> > +                     __imsic_id_clear_enable(i);
> > +
> > +             mvec =3D lpriv->ids_move[i];
> > +             lpriv->ids_move[i] =3D NULL;
> > +             if (mvec) {
> > +                     if (__imsic_id_read_clear_pending(i)) {
> > +                             mlocal =3D per_cpu_ptr(imsic->global.loca=
l,
> > +                                                  mvec->cpu);
> > +                             writel_relaxed(mvec->local_id, mlocal->ms=
i_va);
> > +                     }
> > +
> > +                     imsic_vector_free(&lpriv->vectors[i]);
> > +             }
>
> Again an uncommented piece of magic which you will have forgotten what
> it does 3 month down the road :)

Sure, I will add a comment block.

>
> > +
> > +     }
> > +     raw_spin_unlock_irqrestore(&lpriv->ids_lock, flags);
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
> > +static void imsic_remote_sync(unsigned int cpu)
> > +{
> > +     /*
> > +      * We simply inject ID synchronization IPI to a target CPU
> > +      * if it is not same as the current CPU. The ipi_send_mask()
> > +      * implementation of IPI mux will inject ID synchronization
> > +      * IPI only for CPUs that have enabled it so offline CPUs
> > +      * won't receive IPI. An offline CPU will unconditionally
> > +      * synchronize IDs through imsic_starting_cpu() when the
> > +      * CPU is brought up.
> > +      */
> > +     if (cpu_online(cpu)) {
> > +             if (cpu !=3D smp_processor_id())
> > +                     __ipi_send_mask(imsic->ipi_lsync_desc, cpumask_of=
(cpu));
>
> Still wondering why this can't use the regular API. There might be a
> reason, but then it wants to be documented.

As mentioned above, the "ipi_virq" and "irq_lsync_desc" will
be replaced by a per-CPU timer in the next revision.

>
> > +             else
> > +                     imsic_local_sync();
> > +     }
> > +}
> > +#else
> > +static inline void imsic_remote_sync(unsigned int cpu)
> > +{
> > +     imsic_local_sync();
> > +}
> > +#endif
> > +
> > +void imsic_vector_mask(struct imsic_vector *vec)
> > +{
> > +     struct imsic_local_priv *lpriv;
> > +     unsigned long flags;
> > +
> > +     lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
> > +     if (WARN_ON(&lpriv->vectors[vec->local_id] !=3D vec))
> > +             return;
> > +
> > +     raw_spin_lock_irqsave(&lpriv->ids_lock, flags);
>
> AFAICT, this is used from an irqchip callback:
>
> static void imsic_irq_mask(struct irq_data *d)
> {
>         imsic_vector_mask(irq_data_get_irq_chip_data(d));
> }
>
> So no need to use irqsave() here. Those callbacks run always with
> interrupts disabled when called from the core.

Okay, I will update.

>
> > +void imsic_vector_move(struct imsic_vector *old_vec,
> > +                     struct imsic_vector *new_vec)
> > +{
> > +     struct imsic_local_priv *old_lpriv, *new_lpriv;
> > +     unsigned long flags, flags1;
> > +
> > +     if (WARN_ON(old_vec->cpu =3D=3D new_vec->cpu))
> > +             return;
> > +
> > +     old_lpriv =3D per_cpu_ptr(imsic->lpriv, old_vec->cpu);
> > +     if (WARN_ON(&old_lpriv->vectors[old_vec->local_id] !=3D old_vec))
> > +             return;
> > +
> > +     new_lpriv =3D per_cpu_ptr(imsic->lpriv, new_vec->cpu);
> > +     if (WARN_ON(&new_lpriv->vectors[new_vec->local_id] !=3D new_vec))
> > +             return;
> > +
> > +     raw_spin_lock_irqsave(&old_lpriv->ids_lock, flags);
> > +     raw_spin_lock_irqsave(&new_lpriv->ids_lock, flags1);
>
> Lockdep should yell at you for this, rightfully so. And not only because
> of the missing nested() annotation.
>
> Assume there are two CPUs setting affinity for two different interrupts.
>
> CPU0 moves an interrupt to CPU1 and CPU1 moves another interrupt to
> CPU0. The resulting lock order is:
>
> CPU0                     CPU1
> lock(lpriv[CPU0]);       lock(lpriv[CPU1]);
> lock(lpriv[CPU1]);       lock(lpriv[CPU0]);
>
> a classic ABBA deadlock.
>
> You need to take those locks always in the same order. Look at
> double_raw_lock() in kernel/sched/sched.h.

I have simplified the locking to avoid this nested locks so this
will be much simpler without any lock nesting.

>
> > +     /* Unmask the new vector entry */
> > +     if (test_bit(old_vec->local_id, old_lpriv->ids_enabled_bitmap))
> > +             bitmap_set(new_lpriv->ids_enabled_bitmap,
> > +                        new_vec->local_id, 1);
>
> Either make that one line or please add brackets. See:
>
>   https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#brac=
ket-rules

Okay, I will update.

>
> > +static int __init imsic_local_init(void)
> > +{
> > +     struct imsic_global_config *global =3D &imsic->global;
> > +     struct imsic_local_priv *lpriv;
> > +     struct imsic_vector *vec;
> > +     int cpu, i;
> > +
> > +     /* Allocate per-CPU private state */
> > +     imsic->lpriv =3D alloc_percpu(typeof(*(imsic->lpriv)));
> > +     if (!imsic->lpriv)
> > +             return -ENOMEM;
> > +
> > +     /* Setup per-CPU private state */
> > +     for_each_possible_cpu(cpu) {
> > +             lpriv =3D per_cpu_ptr(imsic->lpriv, cpu);
> > +
> > +             raw_spin_lock_init(&lpriv->ids_lock);
> > +
> > +             /* Allocate enabled bitmap */
> > +             lpriv->ids_enabled_bitmap =3D bitmap_zalloc(global->nr_id=
s + 1,
> > +                                                       GFP_KERNEL);
> > +             if (!lpriv->ids_enabled_bitmap) {
> > +                     imsic_local_cleanup();
> > +                     return -ENOMEM;
> > +             }
> > +
> > +             /* Allocate move array */
> > +             lpriv->ids_move =3D kcalloc(global->nr_ids + 1,
> > +                                     sizeof(*lpriv->ids_move), GFP_KER=
NEL);
> > +             if (!lpriv->ids_move) {
> > +                     imsic_local_cleanup();
> > +                     return -ENOMEM;
> > +             }
> > +
> > +             /* Allocate vector array */
> > +             lpriv->vectors =3D kcalloc(global->nr_ids + 1,
> > +                                      sizeof(*lpriv->vectors), GFP_KER=
NEL);
> > +             if (!lpriv->vectors) {
> > +                     imsic_local_cleanup();
> > +                     return -ENOMEM;
>
> Third instance of the same pattern. goto cleanup; perhaps?

Okay, I will add goto here.

>
> > +struct imsic_vector *imsic_vector_alloc(unsigned int hwirq,
> > +                                     const struct cpumask *mask)
> > +{
> > +     struct imsic_vector *vec =3D NULL;
> > +     struct imsic_local_priv *lpriv;
> > +     unsigned long flags;
> > +     unsigned int cpu;
> > +     int local_id;
> > +
> > +     raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
> > +     local_id =3D irq_matrix_alloc(imsic->matrix, mask, false, &cpu);
> > +     raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
> > +     if (local_id < 0)
> > +             return NULL;
> > +
> > +     lpriv =3D per_cpu_ptr(imsic->lpriv, cpu);
> > +     vec =3D &lpriv->vectors[local_id];
> > +     vec->hwirq =3D hwirq;
> > +
> > +     return vec;
> > +}
>
> ...
>
> > +int imsic_hwirq_alloc(void)
> > +{
> > +     int ret;
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&imsic->hwirqs_lock, flags);
> > +     ret =3D bitmap_find_free_region(imsic->hwirqs_used_bitmap,
> > +                                   imsic->nr_hwirqs, 0);
> > +     raw_spin_unlock_irqrestore(&imsic->hwirqs_lock, flags);
> > +
> > +     return ret;
> > +}
>
> This part is just to create a unique hwirq number, right?

Yes, this is only for unique hwirq. We can directly use virq
instead of hwirq so this hwirq allocation/management will
go away in the next revision.

>
> > +
> > +     /* Find number of guest index bits in MSI address */
> > +     rc =3D of_property_read_u32(to_of_node(fwnode),
> > +                               "riscv,guest-index-bits",
> > +                               &global->guest_index_bits);
> > +     if (rc)
> > +             global->guest_index_bits =3D 0;
>
> So here you get the index bits, but then 50 lines further down you do
> sanity checking. Wouldn't it make sense to do that right here?
>
> Same for the other bits.

This is intentional because we already have a AIA ACPI series
where this helps to reduce the number of "if (acpi_disabled)"
checks.

>
> > +
> > +/*
> > + * The IMSIC driver uses 1 IPI for ID synchronization and
> > + * arch/riscv/kernel/smp.c require 6 IPIs so we fix the
> > + * total number of IPIs to 8.
> > + */
> > +#define IMSIC_IPI_ID                         1
> > +#define IMSIC_NR_IPI                         8
> > +
> > +struct imsic_vector {
> > +     /* Fixed details of the vector */
> > +     unsigned int cpu;
> > +     unsigned int local_id;
> > +     /* Details saved by driver in the vector */
> > +     unsigned int hwirq;
> > +};
> > +
> > +struct imsic_local_priv {
> > +     /* Local state of interrupt identities */
> > +     raw_spinlock_t ids_lock;
> > +     unsigned long *ids_enabled_bitmap;
> > +     struct imsic_vector **ids_move;
> > +
> > +     /* Local vector table */
> > +     struct imsic_vector *vectors;
>
> Please make those structs tabular:
>
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct=
-declarations-and-initializers

Okay, I will update.

>
> > +void __imsic_eix_update(unsigned long base_id,
> > +                     unsigned long num_id, bool pend, bool val);
> > +
> > +#define __imsic_id_set_enable(__id)          \
> > +     __imsic_eix_update((__id), 1, false, true)
> > +#define __imsic_id_clear_enable(__id)        \
> > +     __imsic_eix_update((__id), 1, false, false)
>
> inlines please.

Okay, I will update.

Regards,
Anup

