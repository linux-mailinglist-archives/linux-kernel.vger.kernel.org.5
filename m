Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED167D7EDF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344575AbjJZIvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjJZIvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:51:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65E8128
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:51:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51DBC433C8;
        Thu, 26 Oct 2023 08:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698310267;
        bh=mddcn5IUn1NieVHT8ue//nKluw4nhymiQSKMfwyNqmc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=quGwx5xvVZVgIO8NqhpBP4m7Kn6qven7A30OpvG5XZH0ujJyaECkqmCND95h33XdK
         0iPjzkVSga48GfWH/6G4ifAmMNXZq5BS970n/nlYynWgPgJsXtkdZpHhsOmEjdZ9qK
         gPb2KuUPuJPNFwIuqFRZD+DFKRiIi1d6H7TIbAU0kzyHS3UeXbjmoI/rlAlvinJHzY
         LMzJUZIHnmEokL975kdrLUrCbLmGX0RM+bm2UQmUW/1Z+PAWr6mYhSuD/sD7CWFrLJ
         6BVPS0DdGl+3nCnidohM9nLrHWrXlR8o6Z3y9PQQuqkYMQMu4QoD5TqOGExy4vZU7f
         tDvCtfPcutbjw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
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
Subject: Re: [PATCH v11 07/14] irqchip: Add RISC-V incoming MSI controller
 early driver
In-Reply-To: <CAK9=C2WHw5BKZua9+qEHso3NdxuX-_nqaLKrGetO4u=R==RuHg@mail.gmail.com>
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-8-apatel@ventanamicro.com>
 <878r7srx04.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2XpxYztxgD-5HQ+1kThBaRTv3pVk5eah4XHZ_8x62BwqQ@mail.gmail.com>
 <875y2ug023.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2WHw5BKZua9+qEHso3NdxuX-_nqaLKrGetO4u=R==RuHg@mail.gmail.com>
Date:   Thu, 26 Oct 2023 10:51:04 +0200
Message-ID: <87pm11wyvb.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

I'm getting the vibes that you are upset. Just to clarify; I want AIA
support as much as the next guy. I'm not here to pick fights, and argue
for non-technical things. I'm just here for
questions/clarifications/suggestion, so we can move the implementation
forward.

If I for some reason offended you, please let me know. If that was the
case, that was not on purpose, and accept my apologies.

Now, please let's continue the technical discussion.

Anup Patel <apatel@ventanamicro.com> writes:

>> >> > +
>> >> > +     writel(IMSIC_IPI_ID, local->msi_va);
>> >>
>> >> Do you need the barriers here? If so, please document. If not, use the
>> >> _releaxed() version.
>> >
>> > We can't assume that _relaxed version of MMIO operations
>> > will work for RISC-V implementation so we conservatively
>> > use regular MMIO operations without _releaxed().
>>
>> You'll need to expand on your thinking here, Anup. We can't just
>> sprinkle fences everywhere because of "we can't assume it'll work". Do
>> you need proper barriers for IPIs or not?
>
> For IPIs, we use generic IPI-mux which has its own barriers. We
> certainly need matching read and write barrier for the data being
> passed for synchronization.

Ok! If the IPI-mux has the barriers, it seems like a writel_relaxed will
do just fine.

>> >> > +void imsic_vector_mask(struct imsic_vector *vec)
>> >> > +{
>> >> > +     struct imsic_local_priv *lpriv;
>> >> > +     unsigned long flags;
>> >> > +
>> >> > +     lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
>> >> > +     if (WARN_ON(&lpriv->vectors[vec->local_id] !=3D vec))
>> >> > +             return;
>> >> > +
>> >> > +     raw_spin_lock_irqsave(&lpriv->ids_lock, flags);
>> >> > +     bitmap_clear(lpriv->ids_enabled_bitmap, vec->local_id, 1);
>> >> > +     raw_spin_unlock_irqrestore(&lpriv->ids_lock, flags);
>> >> > +
>> >> > +     imsic_remote_sync(vec->cpu);
>> >>
>> >> x86 seems to set a timer instead, for the remote cpu cleanup, which c=
an
>> >> be much cheaper, and less in instrusive. Is that applicable here?
>> >
>> > The issue with that approach is deciding the right duration
>> > of timer interrupt. There might be platforms who need
>> > immediate mask/unmask response. We can certainely
>> > keep improving/tuning this over-time.
>>
>> Any concrete examples where this is an actual problem?
>
> Do you have a concrete timer duration with proper justification ?

I would simply mimic what x86 does for now -- jiffies + 1.

No biggie for me, and this can, as you say, be improved later.

>> >> > +void imsic_vector_move(struct imsic_vector *old_vec,
>> >> > +                     struct imsic_vector *new_vec)
>> >> > +{
>> >> > +     struct imsic_local_priv *old_lpriv, *new_lpriv;
>> >> > +     struct imsic_vector *ovec, *nvec;
>> >> > +     unsigned long flags, flags1;
>> >> > +     unsigned int i;
>> >> > +
>> >> > +     if (WARN_ON(old_vec->cpu =3D=3D new_vec->cpu ||
>> >> > +                 old_vec->order !=3D new_vec->order ||
>> >> > +                 (old_vec->local_id & IMSIC_VECTOR_MASK(old_vec)) =
||
>> >> > +                 (new_vec->local_id & IMSIC_VECTOR_MASK(new_vec))))
>> >> > +             return;
>> >> > +
>> >> > +     old_lpriv =3D per_cpu_ptr(imsic->lpriv, old_vec->cpu);
>> >> > +     if (WARN_ON(&old_lpriv->vectors[old_vec->local_id] !=3D old_v=
ec))
>> >> > +             return;
>> >> > +
>> >> > +     new_lpriv =3D per_cpu_ptr(imsic->lpriv, new_vec->cpu);
>> >> > +     if (WARN_ON(&new_lpriv->vectors[new_vec->local_id] !=3D new_v=
ec))
>> >> > +             return;
>> >> > +
>> >> > +     raw_spin_lock_irqsave(&old_lpriv->ids_lock, flags);
>> >> > +     raw_spin_lock_irqsave(&new_lpriv->ids_lock, flags1);
>> >> > +
>> >> > +     /* Move the state of each vector entry */
>> >> > +     for (i =3D 0; i < BIT(old_vec->order); i++) {
>> >> > +             ovec =3D old_vec + i;
>> >> > +             nvec =3D new_vec + i;
>> >> > +
>> >> > +             /* Unmask the new vector entry */
>> >> > +             if (test_bit(ovec->local_id, old_lpriv->ids_enabled_b=
itmap))
>> >> > +                     bitmap_set(new_lpriv->ids_enabled_bitmap,
>> >> > +                                nvec->local_id, 1);
>> >> > +
>> >> > +             /* Mask the old vector entry */
>> >> > +             bitmap_clear(old_lpriv->ids_enabled_bitmap, ovec->loc=
al_id, 1);
>> >> > +
>> >> > +             /*
>> >> > +              * Move and re-trigger the new vector entry based on =
the
>> >> > +              * pending state of the old vector entry because we m=
ight
>> >> > +              * get a device interrupt on the old vector entry whi=
le
>> >> > +              * device was being moved to the new vector entry.
>> >> > +              */
>> >> > +             old_lpriv->ids_move[ovec->local_id] =3D nvec;
>> >> > +     }
>> >>
>> >> Hmm, nested spinlocks, and reimplementing what the irq matrix allocat=
or
>> >> does.
>> >>
>> >> Convince me why irq matrix is not a good fit to track the interrupts =
IDs
>> >> *and* get handling/tracking for managed/unmanaged interrupts. You said
>> >> that it was the power-of-two blocks for MSI, but can't that be enfored
>> >> on matrix alloc? Where are you doing the special handling of MSI?
>> >>
>> >> The reason I'm asking is because I'm pretty certain that x86 has prop=
er
>> >> MSI support (Thomas Gleixner can answer for sure! ;-))
>> >>
>> >> IMSIC smells a lot like the the LAPIC. The implementation could proba=
bly
>> >> be *very* close to what arch/x86/kernel/apic/vector.c does.
>> >>
>> >> Am I completly off here?
>> >>
>> >
>> > The x86 APIC driver only supports MSI-X due to which the IRQ matrix
>> > allocator only supports ID/Vector allocation suitable for MSI-X whereas
>> > the ARM GICv3 driver supports both legacy MSI and MSI-X. In absence
>> > of legacy MSI support, Linux x86 will fallback to INTx for PCI devices
>> > with legacy MSI support but for RISC-V platforms we can't assume that
>> > INTx is available because we might be dealing with an IMSIC-only
>> > platform.
>>
>> You're mixing up MSI and *multi-MSI* (multiple MSI vectors).
>
> So now you are doubting my understanding of MSI ?

I'm not doubting anything. Maybe we need to clarify so that we
understand each other.

You said: "The x86 APIC driver only supports MSI-X..." And that made me
think that you didn't have all the details. Sorry for making that
assumption.

Let's clear up the terminology, for our own sake:

  * legacy-MSI: MSI (non-MSIX!), with *only one vector*.
  * multi-MSI: MSI (non-MSIX!), with multiple vectors
  * MSI-X

"MSI" can also refer to all of the above.

x86 supports legacy-MSI and MSI-X for non-remapped MSIs, and multi-MSI
with IOMMU support.

>> x86 support MSI-X, MSI, and multi-MSI with IOMMU.
>>
>> Gleixner has a some insights on why one probably should *not* jump
>> through hoops to support multi-MSI:
>> https://lore.kernel.org/all/877d7yhve7.ffs@tglx/
>
> This is a fair justification to drop why x86 does not support
> the legacy-MSI or "multi-MSI".

My claim is that x86 does support legacy-MSI, but for design decision,
has avoided multi-MSI.

AFAIU, there are few multi-MSI devices out there.

>> Will we really see HW requiring multi-MSI support on RISC-V systems
>> without IOMMU? To me this sounds like a theoretical exercise.
>>
>> > Refer, x86_vector_msi_parent_ops in arch/x86/kernel/apic/msi.c and
>> > X86_VECTOR_MSI_FLAGS_SUPPORTED in arch/x86/include/asm/msi.h
>> >
>> > Refer, its_pci_msi_domain_info in drivers/irqchip/irq-gic-v3-its-pci-m=
si.c
>> >
>> > The changes which I think are need in the IRQ matrix allocator before
>> > integrating it in the IMSIC driver are the following:
>> > 1) IRQ matrix allocator assumed NR_VECTORS to be a fixed define
>> >     which the arch code provides but in RISC-V world the number of
>> >     IDs are discovered from DT or ACPI.
>>
>> Ok, let's try to be bit more explicit. Have you had a look at
>> kernel/irq/matrix.c?
>
> Why do you doubt it ?

Again, no doubts -- I'm just trying to clarify. Sorry if that touched a
nerve!

>> You need to define the IRQ_MATRIX_BITS (which x86 sets to NR_VECTORS).
>> This is the size of the bitmap. For IMSIC this would be 2047.
>
> Wow, let's just create large bitmaps even when underlying HW has
> fewer per-CPU IDs !!!

Yeah, fair argument. It's a bit too much. Here's a patch to the matrix
allocator that fixes that. Note that it's only compile tested:

--8<--
From 2be4093a39b0560247289f8f4c8214cdacda7870 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Bj=3DC3=3DB6rn=3D20T=3DC3=3DB6pel?=3D <bjorn@rivosinc.com>
Date: Thu, 26 Oct 2023 10:17:21 +0200
Subject: [PATCH] genirq/matrix: Dynamic bitmap allocation
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Some (future) users of the irq matrix allocator, do not know the size
of the bitmaps at compile time.

To avoid wasting memory on unneccesary large bitmaps, size the bitmap
at matrix allocation time.

Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
---
 arch/x86/include/asm/hw_irq.h |  2 --
 kernel/irq/matrix.c           | 33 ++++++++++++++++++++++-----------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 551829884734..dcfaa3812306 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -16,8 +16,6 @@
=20
 #include <asm/irq_vectors.h>
=20
-#define IRQ_MATRIX_BITS		NR_VECTORS
-
 #ifndef __ASSEMBLY__
=20
 #include <linux/percpu.h>
diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 1698e77645ac..16ce956935ca 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -8,8 +8,6 @@
 #include <linux/cpu.h>
 #include <linux/irq.h>
=20
-#define IRQ_MATRIX_SIZE	(BITS_TO_LONGS(IRQ_MATRIX_BITS))
-
 struct cpumap {
 	unsigned int		available;
 	unsigned int		allocated;
@@ -17,8 +15,9 @@ struct cpumap {
 	unsigned int		managed_allocated;
 	bool			initialized;
 	bool			online;
-	unsigned long		alloc_map[IRQ_MATRIX_SIZE];
-	unsigned long		managed_map[IRQ_MATRIX_SIZE];
+	unsigned long		*alloc_map;
+	unsigned long		*managed_map;
+	unsigned long		bitmap_storage[];
 };
=20
 struct irq_matrix {
@@ -32,8 +31,10 @@ struct irq_matrix {
 	unsigned int		total_allocated;
 	unsigned int		online_maps;
 	struct cpumap __percpu	*maps;
-	unsigned long		scratch_map[IRQ_MATRIX_SIZE];
-	unsigned long		system_map[IRQ_MATRIX_SIZE];
+	unsigned long		*scratch_map;
+	unsigned long		*system_map;
+	unsigned long		bitmap_storage[];
+
 };
=20
 #define CREATE_TRACE_POINTS
@@ -50,24 +51,34 @@ __init struct irq_matrix *irq_alloc_matrix(unsigned int=
 matrix_bits,
 					   unsigned int alloc_start,
 					   unsigned int alloc_end)
 {
+	unsigned int cpu, matrix_size =3D BITS_TO_LONGS(matrix_bits);
 	struct irq_matrix *m;
=20
-	if (matrix_bits > IRQ_MATRIX_BITS)
-		return NULL;
-
-	m =3D kzalloc(sizeof(*m), GFP_KERNEL);
+	m =3D kzalloc(struct_size(m, bitmap_storage, matrix_size * 2), GFP_KERNEL=
);
 	if (!m)
 		return NULL;
=20
+	m->scratch_map =3D &m->bitmap_storage[0];
+	m->system_map =3D &m->bitmap_storage[matrix_size];
+
 	m->matrix_bits =3D matrix_bits;
 	m->alloc_start =3D alloc_start;
 	m->alloc_end =3D alloc_end;
 	m->alloc_size =3D alloc_end - alloc_start;
-	m->maps =3D alloc_percpu(*m->maps);
+	m->maps =3D __alloc_percpu(struct_size(m->maps, bitmap_storage, matrix_si=
ze * 2),
+				 __alignof__(*m->maps));
 	if (!m->maps) {
 		kfree(m);
 		return NULL;
 	}
+
+	for_each_possible_cpu(cpu){
+		struct cpumap *cm =3D per_cpu_ptr(m->maps, cpu);
+
+		cm->alloc_map =3D &cm->bitmap_storage[0];
+		cm->managed_map =3D &cm->bitmap_storage[matrix_size];
+	}
+
 	return m;
 }
=20

base-commit: 611da07b89fdd53f140d7b33013f255bf0ed8f34
--=20
2.40.1

--8<--


>> The matrix allocator is an excellent fit, modulo multi-MSI. It's battle
>> proven code.
>>
>> > 2) IRQ matrix allocator needs to be support allocator multiple vectors
>> >     in power-of-2 which will allow IMSIC driver to support both legacy
>> >     MSI and MSI-X. This will involve changing the way best CPU is
>> >     found, the way bitmap APIs are used and adding some new APIs
>> >     for allocate vectors in power-of-2
>>
>> ...and all the other things multi-MSI requires.
>>
>> > Based on above, I suggest we keep the integration of IRQ matrix
>> > allocator in the IMSIC driver as a separate series which will allow
>> > us to unblock other series (such as AIA ACPI support, power
>> > managment related changes in AIA drivers, etc).
>>
>> I suggest removing the multi-MSI support, and use the matrix allocator.
>> We have something that looks like what x86 has (IMSIC). We have a
>> battle-proven implementation, and helper function. In my view it would
>> be just weird not to piggy-back on that work, and benefit from years of
>> bugfixes/things we haven't thought of.
>>
>> Finally; I don't see that you're handling managed interrupt in the
>> series (Oh, the matrix allocator has support for that! ;-)).
>
> We don't need managed interrupts like x86 does. We are using
> IPI-mux to create multiple virtual IPIs on-top-of single ID and we
> use some of these virtual IPIs for internal managment.

I'm not following here, and what IPI's has to do with managed
interrupts. I'm referring to "IRQD_AFFINITY_MANAGED".

I'm probably missing something?


Bj=C3=B6rn
