Return-Path: <linux-kernel+bounces-56070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B735084C59D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F40A1F25569
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAEF1F922;
	Wed,  7 Feb 2024 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOb7mJN8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848CE200A4;
	Wed,  7 Feb 2024 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707290871; cv=none; b=UN1rLOWtI6sN/4GzIz+OsV/BAgrRB+U0tXqDegpXtZ7f4HfLGuXzSu/xRDXU6AVuLTp5FTVFHqM6Stpe0pCr8qwDnTEsSHOCxvnsMJbBZb4IOzufzQdeM0buI1LEZ/pOk2zDqn8OqdRDD5lH/+wHZzyfLAvkiuX0OoEhEzLySEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707290871; c=relaxed/simple;
	bh=tEZnWAW1WLvWFg7OBlQaqlPnnLL0RBXGxDvchX99pdY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=udhCgIUUyQxpNBHKEViq/hlJGojfZw9M+qb8S9TtZXbI8pXGy608Vztt7ecFihhXlYnfWb4fReCVUXXE/5V2i21uJCPs1bvGMRY6NYLtc17hp669W4FriEmv4o0WN5xqgiqfuLz3CVzpRJY7CNgeyJ3wcV6itfjaKUIaVs//DOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOb7mJN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADF0C433C7;
	Wed,  7 Feb 2024 07:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707290871;
	bh=tEZnWAW1WLvWFg7OBlQaqlPnnLL0RBXGxDvchX99pdY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QOb7mJN82YyN+0GfAzTMA5T+JNOvvAQxdQNzdM8XENErQnYNYErfQ10O/mIKRGdTF
	 bKdv2gE9hycUvh3pEOQ7oo7nc08Edp+cj2to5e+Rc2mXV7W++glUWTICkXYDrDrt63
	 ypP2XCEzM1RJ7S9l4V3eyElb8Gns175HDwXs5CuWPC8eSoYio5jWs66nOqKFL3twMZ
	 khZ3gofxXcjMMgVyho0ppFfu8j7TdCBJnBO2cGDFWLe/bU85w1U6tDK5ErZa+Vkxu5
	 8JY7dYgpxxXOvOCO2QQbTyHeMad9drqAcafMb4vZHcA+CMRipPssxPEB0yXDG0XPww
	 uCb14HcMTTaVA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Anup Patel <anup@brainfault.org>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas
 Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, Saravana Kannan <saravanak@google.com>, Marc
 Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, Atish Patra
 <atishp@atishpatra.org>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Andrew Jones
 <ajones@ventanamicro.com>
Subject: Re: [PATCH v12 00/25] Linux RISC-V AIA Support
In-Reply-To: <CAAhSdy2PPjS6++Edh8NkgiBmcovTUjS5oXE2eR5ZwPfAfVA0ng@mail.gmail.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <87h6ily53k.fsf@all.your.base.are.belong.to.us>
 <CAAhSdy2PPjS6++Edh8NkgiBmcovTUjS5oXE2eR5ZwPfAfVA0ng@mail.gmail.com>
Date: Wed, 07 Feb 2024 08:27:47 +0100
Message-ID: <874jekag3w.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi!

Anup Patel <anup@brainfault.org> writes:

> On Tue, Feb 6, 2024 at 9:09=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
>>
>> Hi Anup,
>>
>> Anup Patel <apatel@ventanamicro.com> writes:
>>
>> > The RISC-V AIA specification is ratified as-per the RISC-V internation=
al
>> > process. The latest ratified AIA specifcation can be found at:
>> > https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interru=
pts-1.0.pdf
>> >
>> > At a high-level, the AIA specification adds three things:
>> > 1) AIA CSRs
>> >    - Improved local interrupt support
>> > 2) Incoming Message Signaled Interrupt Controller (IMSIC)
>> >    - Per-HART MSI controller
>> >    - Support MSI virtualization
>> >    - Support IPI along with virtualization
>> > 3) Advanced Platform-Level Interrupt Controller (APLIC)
>> >    - Wired interrupt controller
>> >    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI generat=
or)
>> >    - In Direct-mode, injects external interrupts directly into HARTs
>> >
>> > For an overview of the AIA specification, refer the AIA virtualization
>> > talk at KVM Forum 2022:
>> > https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virtualizati=
on_in_KVM_RISCV_final.pdf
>> > https://www.youtube.com/watch?v=3Dr071dL8Z0yo
>>
>> Thank you for continuing to work on this series! I like this
>> direction of the series!
>>
>> TL;DR: I think we can get rid of most of the id/householding data
>> structures, except for the irq matrix.
>>
>> Most of my comments are more of a design/overview nature, so I'll
>> comment here in the cover letter.
>>
>> I took the series for a spin with and it with Alex' ftrace fix it,
>> passes all my tests nicely!
>>
>> Now some thoughts/comments (I'm coming from the x86 side of things!):
>>
>> id/enable-tracking: There are a lot of different id/enabled tracking
>> with corresponding locks, where there's IMO overlap with what the
>> matrix provides.
>
> The matrix allocator does not track the enabled/disabled state of
> the per-CPU IDs. This is why we have a separate per-CPU
> ids_enabled_bitmap which is also used for remote synchronization
> across CPUs.

Exactly, but what I'm asking is if that structure is really needed. More
below.

>> Let's start with struct imsic_priv:
>>
>>    | /* Dummy HW interrupt numbers */
>>    | unsigned int nr_hwirqs;
>>    | raw_spinlock_t hwirqs_lock;
>>    | unsigned long *hwirqs_used_bitmap;
>
> The matrix allocator manages actual IDs for each CPU whereas
> the Linux irq_data expects a fixed hwirq which does not change.
>
> Due to this, we have a dummy hwirq space which is always
> fixed. The only thing that is changed under-the-hood by the
> IMSIC driver is the dummy hwirq to actual HW vector (cpu, id)
> mapping.

Read below. I'm not talking about local_id from the irq_matrix, I'm
saying use virq, which has the properties you're asking for, and doesn't
require an additional structure. When an irq/desc is allocated, you have
a nice unique number with the virq for the lifetime of the interrupt.

>> These are used to for the domain routing (hwirq -> desc/virq), and not
>> needed. Just use the same id as virq (at allocation time), and get rid
>> of these data structures/corresponding functions. The lookup in the
>> interrupt handler via imsic_local_priv.vectors doesn't care about
>> hwirq. This is what x86 does... The imsic_vector roughly corresponds
>> to apic_chip_data (nit: imsic_vector could have the chip_data suffix
>> as well, at least it would have helped me!)
>
> Yes, imsic_vector corresponds to apic_chip_data in the x86 world.

..and I'm trying to ask the following; Given the IMSIC is pretty much
x86 vector (arch/x86/kernel/apic/vector.c), I'm trying to figure out the
rational why IMSIC has all the extra householding data, not needed by
x86. The x86 has been battle proven, and having to deal with all kind of
quirks (e.g. lost interrupts on affinity changes).

>> Moving/affinity changes. The moving of a vector to another CPU
>> currently involves:
>>
>> 1. Allocate a new vector from the matrix
>> 2. Disable/enable the corresponding per-cpu ids_enabled_bitmap (nested
>>    spinlocks)
>> 3. Trigger two IPIs to apply the bitmap
>> 4. On each CPU target (imsic_local_sync()) loop the bitmap and flip
>>    all bits, and potentially rearm
>>
>> This seems a bit heavy-weight: Why are you explicitly setting/clearing
>> all the bits in a loop at the local sync?
>
> This can be certainly optimized by introducing another
> ids_dirty_bitmap. I will add this in the next revision.

I rather have fewer maps, and less locks! ;-)

>> x86 does it a bit differently (more lazily): The chip_data has
>> prev_{cpu,vector}/move_in_progress fields, and keep both vectors
>> enabled until there's an interrupt on the new vector, and then the old
>> one is cleaned (irq_complete_move()).
>>
>> Further; When it's time to remove the old vector, x86 doesn't trigger
>> an IPI on the disabling side, but queues a cleanup job on a per-cpu
>> list and triggers a timeout. So, the per-cpu chip_data (per-cpu
>> "vectors" in your series) can reside in two places during the transit.
>
> We can't avoid IPIs when moving vectors from one CPU to another
> CPU because IMSIC id enable/disable is only possible through
> CSRs. Also, keep in-mind that irq affinity change might be initiated
> on CPU X for some interrupt targeting CPU Y which is then changed
> to target CPU Z.
>
> In the case of x86, they have memory mapped registers which
> allows one CPU to enable/disable the ID of another CPU.

Nope. Same mechanics on x86 -- the cleanup has to be done one the
originating core. What I asked was "what about using a timer instead of
an IPI". I think this was up in the last rev as well?

Check out commit bdc1dad299bb ("x86/vector: Replace
IRQ_MOVE_CLEANUP_VECTOR with a timer callback") Specifically, the
comment about lost interrupts, and the rational for keeping the original
target active until there's a new interrupt on the new cpu.

>> I wonder if this clean up is less intrusive, and you just need to
>> perform what's in the per-list instead of dealing with the
>> ids_enabled_bitmap? Maybe we can even remove that bitmap as well. The
>> chip_data/desc has that information. This would mean that
>> imsic_local_priv() would only have the local vectors (chip_data), and
>> a cleanup list/timer.
>>
>> My general comment is that instead of having these global id-tracking
>> structures, use the matrix together with some desc/chip_data local
>> data, which should be sufficient.
>
> The "ids_enabled_bitmap", "dummy hwirqs" and private imsic_vectors
> are required since the matrix allocator only manages allocation of
> per-CPU IDs.

The information in ids_enabled_bitmap is/could be inherent in
imsic_local_priv.vectors (guess what x86 does... ;-)).

Dummy hwirqs could be replaced with the virq.

Hmm, seems like we're talking past each other, or at least I get the
feeling I can't get my opinions out right. I'll try to do a quick PoC,
to show you what I mean. That's probably easier than just talking about
it. ...and maybe I'll come realizing I'm all wrong!

My reaction is -- you're doing a lot of householding with a lot of
locks, and my worry is that we'll just end up with same issues/bloat
that x86 once had (has? ;-)).

>> Random thought: Do we need to explicitly disable (csr) the vector,
>> when we're changing the affinity? What if we just leave it enabled,
>> and only when mask/unmask is performed it's actually explicitly masked
>> (writes to the csr)?
>
> We should not leave it enabled because some rough/buggy device
> can inject spurious interrupts using MSI writes to unused enabled
> interrupts.

OK!

>>
>> Missing features (which can be added later):
>> * Reservation mode/activate support (allocate many MSI, but only
>>   request/activate a subset)
>
> I did not see any PCIe or platform device requiring this kind of
> reservation. Any examples ?

It's not a requirement. Some devices allocate a gazillion interrupts
(NICs with many QoS queues, e.g.), but only activate a subset (via
request_irq()). A system using these kind of devices might run out of
interrupts.

Problems you run into once you leave the embedded world, pretty much.

>> * Handle managed interrupts
>
> Any examples of managed interrupts in the RISC-V world ?

E.g. all nvme drives: nvme_setup_irqs(), and I'd assume contemporary
netdev drivers would use it. Typically devices with per-cpu queues.

>> * There might be some irqd flags are missing, which mostly cpuhp care
>>   about (e.g. irqd_*_single_target())...
>
> Okay, let me check and update.

I haven't dug much into cpuhp, so I'm out on a limb here...

>> Finally; Given that the APLIC requires a lot more patches, depending
>> on how the review process moves on -- maybe the IMSIC side could go as
>> a separate series?
>>
>
> The most popular implementation choice across RISC-V platforms
> will be IMSIC + APLIC so both drivers should go together. In fact,
> we need both drivers for the QEMU virt machine as well because
> UART interrupt (and other wired interrupts) on the QEMU virt
> machine goes through APLIC.

Thanks for clearing that out! Hmm, an IMSIC only QEMU would be awesome.


Cheers,
Bj=C3=B6rn

