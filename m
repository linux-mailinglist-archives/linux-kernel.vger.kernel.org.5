Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDE87D723F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjJYRZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJYRZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:25:36 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABA812F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:25:33 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bf55a81eeaso43786085ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698254733; x=1698859533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bdEFO6pQDBuBMT67DsCUA85DBCrvmuegBe93dEViYI=;
        b=H0Dvb4IBPiMPTGVobVse/9s7ZxnPIHpy5oxtJsqPJIhuIBQ67/N0tKxNbfP3+/lp40
         6Dm2kOP9Y4RNw6Aq7XJXvSU6BUVhjNnXC13vKTmUDjo5/untBmZS7EXaqYGD+Qlf8mpl
         jOrLt3JDS958apVsxFs6RwSLdmHQwqdWfqeXeqKDPJKYQX1TkF3Gaw+fjnFQ62ECBYG8
         Rl262DpMUUgZPH+T6Bt+ZIo9fpMQkBu3CJMSp68JcW+/bhjfBpbdiIwThKWeMzZai15n
         xbdDqYqtLy6608dyMJ/nzBxpTlaUxyny2OV6nXDR2n2s8o//FzXQ/1GJfgnjmjgdGdPp
         U43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698254733; x=1698859533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bdEFO6pQDBuBMT67DsCUA85DBCrvmuegBe93dEViYI=;
        b=frnVjCRU500zZuiI08OTHzenFtLYLlNu5agxrda2J+NTY33s7SmRTBOc18RVje1tiR
         p2tGXwpLjSk8iSipIrWrW8KDfzSbasr6DhkkF/eyrsbNoraKwM3szPfSKRDuNLOAEB6M
         bB4t57p5Sul86jIcXuj/T13VIxGIosaFDSNzTzTl+6o6UpL4JrXgbMZIn8zEs+Lzuc8u
         Ezv6zOjhA9dXY7kYkJlMtb4yQFpoZO2HiEZJ8sQVSQXPhtzW7yXlOkhTXKWcyKKJ3pJZ
         3S+Qp5ssHuStfhcSxS6Rp/ykypOteN4DueGD7fQR8meGk3La26BgY83TW9lj1FttG0c7
         S/Fw==
X-Gm-Message-State: AOJu0YwqTUZcJqilnb5r+8FPm8bfd79peTl0YY/CRbFQxYTc7/+Puecf
        6UGu1rYDBOq/gEQIFpxr3Uk6hmj5X9+hs22VYUeFAg==
X-Google-Smtp-Source: AGHT+IEl7LBW8mkgorVNXtiqUWgVR8eud944DgNWAvWhm6PBDsOgW8GIMwlTM/mAFj151Unl35gWXaaWpDiYnI5lsGg=
X-Received: by 2002:a17:90a:1996:b0:27c:fa10:fc82 with SMTP id
 22-20020a17090a199600b0027cfa10fc82mr13286350pji.28.1698254732635; Wed, 25
 Oct 2023 10:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-8-apatel@ventanamicro.com> <878r7srx04.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2XpxYztxgD-5HQ+1kThBaRTv3pVk5eah4XHZ_8x62BwqQ@mail.gmail.com> <875y2ug023.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <875y2ug023.fsf@all.your.base.are.belong.to.us>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 25 Oct 2023 22:55:21 +0530
Message-ID: <CAK9=C2WHw5BKZua9+qEHso3NdxuX-_nqaLKrGetO4u=R==RuHg@mail.gmail.com>
Subject: Re: [PATCH v11 07/14] irqchip: Add RISC-V incoming MSI controller
 early driver
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 9:35=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Hi!
>
> Anup Patel <apatel@ventanamicro.com> writes:
>
> > On Tue, Oct 24, 2023 at 6:35=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@ke=
rnel.org> wrote:
> >>
> >> Hi Anup!
> >>
> >> Wow, I'm really happy to see that you're moving towards the 1-1 model!
> >>
> >> Anup Patel <apatel@ventanamicro.com> writes:
> >>
> >> > The RISC-V advanced interrupt architecture (AIA) specification
> >> > defines a new MSI controller called incoming message signalled
> >> > interrupt controller (IMSIC) which manages MSI on per-HART (or
> >> > per-CPU) basis. It also supports IPIs as software injected MSIs.
> >> > (For more details refer https://github.com/riscv/riscv-aia)
> >> >
> >> > Let us add an early irqchip driver for RISC-V IMSIC which sets
> >> > up the IMSIC state and provide IPIs.
> >>
> >> It would help (reviewers, and future bugfixers) if you add (here or in
> >> the cover) what design decisions you've taken instead of just saying
> >> that you're now supporting IMSIC.
> >
> > I agree with the suggestion but this kind of information should be
> > in the source itself rather than commit description.
>
> I think the high-level flow, and why you made certain design decisions
> should be in the commit message.
>
> The "how" in the code, the "why" in the commit message. Regardless -- it
> would make it easier for reviewers to get into your code faster.
>
> [...]
>
> >> > +
> >> > +     writel(IMSIC_IPI_ID, local->msi_va);
> >>
> >> Do you need the barriers here? If so, please document. If not, use the
> >> _releaxed() version.
> >
> > We can't assume that _relaxed version of MMIO operations
> > will work for RISC-V implementation so we conservatively
> > use regular MMIO operations without _releaxed().
>
> You'll need to expand on your thinking here, Anup. We can't just
> sprinkle fences everywhere because of "we can't assume it'll work". Do
> you need proper barriers for IPIs or not?

For IPIs, we use generic IPI-mux which has its own barriers. We
certainly need matching read and write barrier for the data being
passed for synchronization.

>
> [...]
>
> >> > +             mvec =3D lpriv->ids_move[i];
> >> > +             lpriv->ids_move[i] =3D NULL;
> >> > +             if (mvec) {
> >> > +                     if (__imsic_id_read_clear_pending(i)) {
> >> > +                             mlocal =3D per_cpu_ptr(imsic->global.l=
ocal,
> >> > +                                                  mvec->cpu);
> >> > +                             writel(mvec->local_id, mlocal->msi_va)=
;
> >>
> >> Again, do you need all the barriers? If yes, document. No, then relax
> >> the call.
> >
> > Same comment as above.
>
> Dito for me! ;-)
>
> >> > +                     }
> >> > +
> >> > +                     lpriv->vectors[i].hwirq =3D UINT_MAX;
> >> > +                     lpriv->vectors[i].order =3D UINT_MAX;
> >> > +                     clear_bit(i, lpriv->ids_used_bitmap);
> >> > +             }
> >> > +
> >> > +     }
> >> > +     raw_spin_unlock_irqrestore(&lpriv->ids_lock, flags);
> >> > +}
> >> > +
> >> > +void imsic_local_delivery(bool enable)
> >> > +{
> >> > +     if (enable) {
> >> > +             imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_ENABLE_EITHRE=
SHOLD);
> >> > +             imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_ENABLE_EIDELIV=
ERY);
> >> > +     } else {
> >> > +             imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_DISABLE_EIDELI=
VERY);
> >> > +             imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_DISABLE_EITHR=
ESHOLD);
> >> > +     }
> >>
> >> My regular "early exit" nit. I guess I really dislike indentation. ;-)
> >
> > -ENOPARSE
>
> if (...) {
>   a();
>   b();
>   c();
> } else {
>   d();
>   e();
> }
>
> vs
>
> if (...) {
>   a();
>   b();
>   c();
>   return;
> }
>
> d();
> e();
>
> [...]
>
> >> > +void imsic_vector_mask(struct imsic_vector *vec)
> >> > +{
> >> > +     struct imsic_local_priv *lpriv;
> >> > +     unsigned long flags;
> >> > +
> >> > +     lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
> >> > +     if (WARN_ON(&lpriv->vectors[vec->local_id] !=3D vec))
> >> > +             return;
> >> > +
> >> > +     raw_spin_lock_irqsave(&lpriv->ids_lock, flags);
> >> > +     bitmap_clear(lpriv->ids_enabled_bitmap, vec->local_id, 1);
> >> > +     raw_spin_unlock_irqrestore(&lpriv->ids_lock, flags);
> >> > +
> >> > +     imsic_remote_sync(vec->cpu);
> >>
> >> x86 seems to set a timer instead, for the remote cpu cleanup, which ca=
n
> >> be much cheaper, and less in instrusive. Is that applicable here?
> >
> > The issue with that approach is deciding the right duration
> > of timer interrupt. There might be platforms who need
> > immediate mask/unmask response. We can certainely
> > keep improving/tuning this over-time.
>
> Any concrete examples where this is an actual problem?

Do you have a concrete timer duration with proper justification ?

>
> [...]
>
> >> > +void imsic_vector_move(struct imsic_vector *old_vec,
> >> > +                     struct imsic_vector *new_vec)
> >> > +{
> >> > +     struct imsic_local_priv *old_lpriv, *new_lpriv;
> >> > +     struct imsic_vector *ovec, *nvec;
> >> > +     unsigned long flags, flags1;
> >> > +     unsigned int i;
> >> > +
> >> > +     if (WARN_ON(old_vec->cpu =3D=3D new_vec->cpu ||
> >> > +                 old_vec->order !=3D new_vec->order ||
> >> > +                 (old_vec->local_id & IMSIC_VECTOR_MASK(old_vec)) |=
|
> >> > +                 (new_vec->local_id & IMSIC_VECTOR_MASK(new_vec))))
> >> > +             return;
> >> > +
> >> > +     old_lpriv =3D per_cpu_ptr(imsic->lpriv, old_vec->cpu);
> >> > +     if (WARN_ON(&old_lpriv->vectors[old_vec->local_id] !=3D old_ve=
c))
> >> > +             return;
> >> > +
> >> > +     new_lpriv =3D per_cpu_ptr(imsic->lpriv, new_vec->cpu);
> >> > +     if (WARN_ON(&new_lpriv->vectors[new_vec->local_id] !=3D new_ve=
c))
> >> > +             return;
> >> > +
> >> > +     raw_spin_lock_irqsave(&old_lpriv->ids_lock, flags);
> >> > +     raw_spin_lock_irqsave(&new_lpriv->ids_lock, flags1);
> >> > +
> >> > +     /* Move the state of each vector entry */
> >> > +     for (i =3D 0; i < BIT(old_vec->order); i++) {
> >> > +             ovec =3D old_vec + i;
> >> > +             nvec =3D new_vec + i;
> >> > +
> >> > +             /* Unmask the new vector entry */
> >> > +             if (test_bit(ovec->local_id, old_lpriv->ids_enabled_bi=
tmap))
> >> > +                     bitmap_set(new_lpriv->ids_enabled_bitmap,
> >> > +                                nvec->local_id, 1);
> >> > +
> >> > +             /* Mask the old vector entry */
> >> > +             bitmap_clear(old_lpriv->ids_enabled_bitmap, ovec->loca=
l_id, 1);
> >> > +
> >> > +             /*
> >> > +              * Move and re-trigger the new vector entry based on t=
he
> >> > +              * pending state of the old vector entry because we mi=
ght
> >> > +              * get a device interrupt on the old vector entry whil=
e
> >> > +              * device was being moved to the new vector entry.
> >> > +              */
> >> > +             old_lpriv->ids_move[ovec->local_id] =3D nvec;
> >> > +     }
> >>
> >> Hmm, nested spinlocks, and reimplementing what the irq matrix allocato=
r
> >> does.
> >>
> >> Convince me why irq matrix is not a good fit to track the interrupts I=
Ds
> >> *and* get handling/tracking for managed/unmanaged interrupts. You said
> >> that it was the power-of-two blocks for MSI, but can't that be enfored
> >> on matrix alloc? Where are you doing the special handling of MSI?
> >>
> >> The reason I'm asking is because I'm pretty certain that x86 has prope=
r
> >> MSI support (Thomas Gleixner can answer for sure! ;-))
> >>
> >> IMSIC smells a lot like the the LAPIC. The implementation could probab=
ly
> >> be *very* close to what arch/x86/kernel/apic/vector.c does.
> >>
> >> Am I completly off here?
> >>
> >
> > The x86 APIC driver only supports MSI-X due to which the IRQ matrix
> > allocator only supports ID/Vector allocation suitable for MSI-X whereas
> > the ARM GICv3 driver supports both legacy MSI and MSI-X. In absence
> > of legacy MSI support, Linux x86 will fallback to INTx for PCI devices
> > with legacy MSI support but for RISC-V platforms we can't assume that
> > INTx is available because we might be dealing with an IMSIC-only
> > platform.
>
> You're mixing up MSI and *multi-MSI* (multiple MSI vectors).

So now you are doubting my understanding of MSI ?

>
> x86 support MSI-X, MSI, and multi-MSI with IOMMU.
>
> Gleixner has a some insights on why one probably should *not* jump
> through hoops to support multi-MSI:
> https://lore.kernel.org/all/877d7yhve7.ffs@tglx/

This is a fair justification to drop why x86 does not support
the legacy-MSI or "multi-MSI".

>
> Will we really see HW requiring multi-MSI support on RISC-V systems
> without IOMMU? To me this sounds like a theoretical exercise.
>
> > Refer, x86_vector_msi_parent_ops in arch/x86/kernel/apic/msi.c and
> > X86_VECTOR_MSI_FLAGS_SUPPORTED in arch/x86/include/asm/msi.h
> >
> > Refer, its_pci_msi_domain_info in drivers/irqchip/irq-gic-v3-its-pci-ms=
i.c
> >
> > The changes which I think are need in the IRQ matrix allocator before
> > integrating it in the IMSIC driver are the following:
> > 1) IRQ matrix allocator assumed NR_VECTORS to be a fixed define
> >     which the arch code provides but in RISC-V world the number of
> >     IDs are discovered from DT or ACPI.
>
> Ok, let's try to be bit more explicit. Have you had a look at
> kernel/irq/matrix.c?

Why do you doubt it ?

>
> You need to define the IRQ_MATRIX_BITS (which x86 sets to NR_VECTORS).
> This is the size of the bitmap. For IMSIC this would be 2047.

Wow, let's just create large bitmaps even when underlying HW has
fewer per-CPU IDs !!!

>
> The matrix allocator is an excellent fit, modulo multi-MSI. It's battle
> proven code.
>
> > 2) IRQ matrix allocator needs to be support allocator multiple vectors
> >     in power-of-2 which will allow IMSIC driver to support both legacy
> >     MSI and MSI-X. This will involve changing the way best CPU is
> >     found, the way bitmap APIs are used and adding some new APIs
> >     for allocate vectors in power-of-2
>
> ...and all the other things multi-MSI requires.
>
> > Based on above, I suggest we keep the integration of IRQ matrix
> > allocator in the IMSIC driver as a separate series which will allow
> > us to unblock other series (such as AIA ACPI support, power
> > managment related changes in AIA drivers, etc).
>
> I suggest removing the multi-MSI support, and use the matrix allocator.
> We have something that looks like what x86 has (IMSIC). We have a
> battle-proven implementation, and helper function. In my view it would
> be just weird not to piggy-back on that work, and benefit from years of
> bugfixes/things we haven't thought of.
>
> Finally; I don't see that you're handling managed interrupt in the
> series (Oh, the matrix allocator has support for that! ;-)).

We don't need managed interrupts like x86 does. We are using
IPI-mux to create multiple virtual IPIs on-top-of single ID and we
use some of these virtual IPIs for internal managment.

>
> I realize it's some changes, but the interrupt handling is a central
> piece.
>
> If you agree with my input, LMK if you're time/work-constrained, and I
> can take a stab at integrating it in the series.
>
>
> Bj=C3=B6rn

Regards,
Anup
