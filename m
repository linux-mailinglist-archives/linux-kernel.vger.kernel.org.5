Return-Path: <linux-kernel+bounces-56184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A8D84C719
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17893B2376C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D48B2232C;
	Wed,  7 Feb 2024 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="bMtxoIU5"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD2820DC5
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297534; cv=none; b=EdnD9dpcFanggHZht8IzxPoaowcdVALaHkhgWyO75Gc5d1xSLX72mbLhene2RrBybTgUQq96bLLbazXLeGZb2XS9pWEbISLSGi6tbb6UnNP5pnMFeWGeVeXIWCglsHDmOq1wPUpwGx8+jcv7a9PM8uVti5uTawdGkEjtDDsnP0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297534; c=relaxed/simple;
	bh=WQJwsfg/oVdrAFGSZmbUFkmX64UmCg6HrDCzIPJhDF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLfqPoXC5iUj9MEOliygCj5KfRCa+0P5qGSoqwendNxXLgztKl2yHLnYUei+bspDa5iSX3kK1Hmd7G5Hsqq2+BFJbdiSC75tiS7n4pN2MihRai7LgdFB0F1U+Lrat01+MKYno8Mnq4OGfhE7qRIbMF8jwFhlWeITcZlSIytpe8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=bMtxoIU5; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso3914101fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707297531; x=1707902331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4z+6c2Ojggq8L+WEQD6OXtOIKBp3WeMOnFIQBtZ9bY=;
        b=bMtxoIU5cNMa4u9gQXahhHTCOYH3mMyx4m8W/914joeZXl2nAv+eVwvFdUUXAydy4m
         Nx4tTaN60Y3TPCCT1aKjvsa7mnpA9PdJZPjgZlXS+tz6FVlq+GjetI0JQSmEleQIjuuy
         /wNREbvdh38vh8P2Vvfx7Vwprroq9xa/KMg7BHYGo7lK1TVK31bPmT0uN9fc/W3zXFyI
         sM22SwvSGcNKPdm9IR3HZ/xPSQNSLRSQrHznhHFIURjiju9477mqfnenemrcLg6gwuYm
         VxioFgGvTRsEQU4RBiVo1fZh0FJ+oY7Kv6/nKHEj5q03HXsKQYJVsk5QetnHoJUQ7j0D
         ARsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707297531; x=1707902331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4z+6c2Ojggq8L+WEQD6OXtOIKBp3WeMOnFIQBtZ9bY=;
        b=Pg+fGc4m1eqL2AjJGnorqzsWia7rMnHCxLcE9xpfG8hDZdmVZ2M5nuY1gjacLYQD8l
         LElxNaOtovyTMSYaMW/sQUec+NlSsWmm0O0GAPv34/iziJ3C51p+XfuOsY5U691WxPYC
         7kPPqpU1Yfr7nwL0tJcXkbQ7wbs90f7ymDx6L1Tnju9CltEqkgC6tstYjFOEy2B4D4ZP
         MjsSz0HKGr0QojcKVP7+PIKuCfSYSFNwt25Khb5tJsivSka7eHPez1xuGgIojJGq4RJA
         JuGuPAsKbojrKJT3vXBQcRwzwx7Up6bC1SMHhZIpnJ63vbHz8jRvPiazBbnrEHd9k3BE
         tMrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr3SRZPKzWnU+8ouei0jV6oG2bZPuy9WtMb7AL+nmk9xtHdJUECPbQVFZNnFaIX58K4PCVcH8vdqu7B6AO7gsnQ0zCZAg8ONqS9CUn
X-Gm-Message-State: AOJu0YxLs17EQLCMGcgdPH+WQYW5BeRmmPo6uhQm86uTGkK5Y8ED++Gt
	pcRVj9bKrauwEZlBWoBISVKqiUG1CvrCDJqnbWOTtu3O0A2KBalYd/XMqUTKbzQArexKhUIMb1/
	Z5ePad+tuZS7LkEl3iKsjiTjtaKsYrkIm4nShXw==
X-Google-Smtp-Source: AGHT+IHcxwyhyMh2dfiThnk4N7u2em8zMIYHs4F79LIirkuHGIqZos+LryQXJFdFMQ3TW5KWxo3n+0DejrGSdmLXbFA=
X-Received: by 2002:a2e:988e:0:b0:2d0:b5b0:4d9f with SMTP id
 b14-20020a2e988e000000b002d0b5b04d9fmr3637305ljj.24.1707297530426; Wed, 07
 Feb 2024 01:18:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <87h6ily53k.fsf@all.your.base.are.belong.to.us> <CAAhSdy2PPjS6++Edh8NkgiBmcovTUjS5oXE2eR5ZwPfAfVA0ng@mail.gmail.com>
 <874jekag3w.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <874jekag3w.fsf@all.your.base.are.belong.to.us>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 7 Feb 2024 14:48:38 +0530
Message-ID: <CAK9=C2XJYTfY4nXWtjK9OP1iXLDXBVF-=mN1SmJDmJ_dO5CohA@mail.gmail.com>
Subject: Re: [PATCH v12 00/25] Linux RISC-V AIA Support
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
	Atish Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 12:57=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
org> wrote:
>
> Hi!
>
> Anup Patel <anup@brainfault.org> writes:
>
> > On Tue, Feb 6, 2024 at 9:09=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@ker=
nel.org> wrote:
> >>
> >> Hi Anup,
> >>
> >> Anup Patel <apatel@ventanamicro.com> writes:
> >>
> >> > The RISC-V AIA specification is ratified as-per the RISC-V internati=
onal
> >> > process. The latest ratified AIA specifcation can be found at:
> >> > https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-inter=
rupts-1.0.pdf
> >> >
> >> > At a high-level, the AIA specification adds three things:
> >> > 1) AIA CSRs
> >> >    - Improved local interrupt support
> >> > 2) Incoming Message Signaled Interrupt Controller (IMSIC)
> >> >    - Per-HART MSI controller
> >> >    - Support MSI virtualization
> >> >    - Support IPI along with virtualization
> >> > 3) Advanced Platform-Level Interrupt Controller (APLIC)
> >> >    - Wired interrupt controller
> >> >    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI gener=
ator)
> >> >    - In Direct-mode, injects external interrupts directly into HARTs
> >> >
> >> > For an overview of the AIA specification, refer the AIA virtualizati=
on
> >> > talk at KVM Forum 2022:
> >> > https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virtualiza=
tion_in_KVM_RISCV_final.pdf
> >> > https://www.youtube.com/watch?v=3Dr071dL8Z0yo
> >>
> >> Thank you for continuing to work on this series! I like this
> >> direction of the series!
> >>
> >> TL;DR: I think we can get rid of most of the id/householding data
> >> structures, except for the irq matrix.
> >>
> >> Most of my comments are more of a design/overview nature, so I'll
> >> comment here in the cover letter.
> >>
> >> I took the series for a spin with and it with Alex' ftrace fix it,
> >> passes all my tests nicely!
> >>
> >> Now some thoughts/comments (I'm coming from the x86 side of things!):
> >>
> >> id/enable-tracking: There are a lot of different id/enabled tracking
> >> with corresponding locks, where there's IMO overlap with what the
> >> matrix provides.
> >
> > The matrix allocator does not track the enabled/disabled state of
> > the per-CPU IDs. This is why we have a separate per-CPU
> > ids_enabled_bitmap which is also used for remote synchronization
> > across CPUs.
>
> Exactly, but what I'm asking is if that structure is really needed. More
> below.
>
> >> Let's start with struct imsic_priv:
> >>
> >>    | /* Dummy HW interrupt numbers */
> >>    | unsigned int nr_hwirqs;
> >>    | raw_spinlock_t hwirqs_lock;
> >>    | unsigned long *hwirqs_used_bitmap;
> >
> > The matrix allocator manages actual IDs for each CPU whereas
> > the Linux irq_data expects a fixed hwirq which does not change.
> >
> > Due to this, we have a dummy hwirq space which is always
> > fixed. The only thing that is changed under-the-hood by the
> > IMSIC driver is the dummy hwirq to actual HW vector (cpu, id)
> > mapping.
>
> Read below. I'm not talking about local_id from the irq_matrix, I'm
> saying use virq, which has the properties you're asking for, and doesn't
> require an additional structure. When an irq/desc is allocated, you have
> a nice unique number with the virq for the lifetime of the interrupt.

Sure, let me explore using virq in-place of hwirq.

>
> >> These are used to for the domain routing (hwirq -> desc/virq), and not
> >> needed. Just use the same id as virq (at allocation time), and get rid
> >> of these data structures/corresponding functions. The lookup in the
> >> interrupt handler via imsic_local_priv.vectors doesn't care about
> >> hwirq. This is what x86 does... The imsic_vector roughly corresponds
> >> to apic_chip_data (nit: imsic_vector could have the chip_data suffix
> >> as well, at least it would have helped me!)
> >
> > Yes, imsic_vector corresponds to apic_chip_data in the x86 world.
>
> ...and I'm trying to ask the following; Given the IMSIC is pretty much
> x86 vector (arch/x86/kernel/apic/vector.c), I'm trying to figure out the
> rational why IMSIC has all the extra householding data, not needed by
> x86. The x86 has been battle proven, and having to deal with all kind of
> quirks (e.g. lost interrupts on affinity changes).

Understood.

>
> >> Moving/affinity changes. The moving of a vector to another CPU
> >> currently involves:
> >>
> >> 1. Allocate a new vector from the matrix
> >> 2. Disable/enable the corresponding per-cpu ids_enabled_bitmap (nested
> >>    spinlocks)
> >> 3. Trigger two IPIs to apply the bitmap
> >> 4. On each CPU target (imsic_local_sync()) loop the bitmap and flip
> >>    all bits, and potentially rearm
> >>
> >> This seems a bit heavy-weight: Why are you explicitly setting/clearing
> >> all the bits in a loop at the local sync?
> >
> > This can be certainly optimized by introducing another
> > ids_dirty_bitmap. I will add this in the next revision.
>
> I rather have fewer maps, and less locks! ;-)
>
> >> x86 does it a bit differently (more lazily): The chip_data has
> >> prev_{cpu,vector}/move_in_progress fields, and keep both vectors
> >> enabled until there's an interrupt on the new vector, and then the old
> >> one is cleaned (irq_complete_move()).
> >>
> >> Further; When it's time to remove the old vector, x86 doesn't trigger
> >> an IPI on the disabling side, but queues a cleanup job on a per-cpu
> >> list and triggers a timeout. So, the per-cpu chip_data (per-cpu
> >> "vectors" in your series) can reside in two places during the transit.
> >
> > We can't avoid IPIs when moving vectors from one CPU to another
> > CPU because IMSIC id enable/disable is only possible through
> > CSRs. Also, keep in-mind that irq affinity change might be initiated
> > on CPU X for some interrupt targeting CPU Y which is then changed
> > to target CPU Z.
> >
> > In the case of x86, they have memory mapped registers which
> > allows one CPU to enable/disable the ID of another CPU.
>
> Nope. Same mechanics on x86 -- the cleanup has to be done one the
> originating core. What I asked was "what about using a timer instead of
> an IPI". I think this was up in the last rev as well?
>
> Check out commit bdc1dad299bb ("x86/vector: Replace
> IRQ_MOVE_CLEANUP_VECTOR with a timer callback") Specifically, the
> comment about lost interrupts, and the rational for keeping the original
> target active until there's a new interrupt on the new cpu.

Trying timer interrupt is still TBD on my side because with v12
my goal was to implement per-device MSI domains. Let me
explore timer interrupts for v13.

>
> >> I wonder if this clean up is less intrusive, and you just need to
> >> perform what's in the per-list instead of dealing with the
> >> ids_enabled_bitmap? Maybe we can even remove that bitmap as well. The
> >> chip_data/desc has that information. This would mean that
> >> imsic_local_priv() would only have the local vectors (chip_data), and
> >> a cleanup list/timer.
> >>
> >> My general comment is that instead of having these global id-tracking
> >> structures, use the matrix together with some desc/chip_data local
> >> data, which should be sufficient.
> >
> > The "ids_enabled_bitmap", "dummy hwirqs" and private imsic_vectors
> > are required since the matrix allocator only manages allocation of
> > per-CPU IDs.
>
> The information in ids_enabled_bitmap is/could be inherent in
> imsic_local_priv.vectors (guess what x86 does... ;-)).
>
> Dummy hwirqs could be replaced with the virq.
>
> Hmm, seems like we're talking past each other, or at least I get the
> feeling I can't get my opinions out right. I'll try to do a quick PoC,
> to show you what I mean. That's probably easier than just talking about
> it. ...and maybe I'll come realizing I'm all wrong!

I suggest to wait for my v13 and try something on top of that
otherwise we might duplicate efforts.

>
> My reaction is -- you're doing a lot of householding with a lot of
> locks, and my worry is that we'll just end up with same issues/bloat
> that x86 once had (has? ;-)).
>
> >> Random thought: Do we need to explicitly disable (csr) the vector,
> >> when we're changing the affinity? What if we just leave it enabled,
> >> and only when mask/unmask is performed it's actually explicitly masked
> >> (writes to the csr)?
> >
> > We should not leave it enabled because some rough/buggy device
> > can inject spurious interrupts using MSI writes to unused enabled
> > interrupts.
>
> OK!
>
> >>
> >> Missing features (which can be added later):
> >> * Reservation mode/activate support (allocate many MSI, but only
> >>   request/activate a subset)
> >
> > I did not see any PCIe or platform device requiring this kind of
> > reservation. Any examples ?
>
> It's not a requirement. Some devices allocate a gazillion interrupts
> (NICs with many QoS queues, e.g.), but only activate a subset (via
> request_irq()). A system using these kind of devices might run out of
> interrupts.

I don't see how this is not possible currently.

>
> Problems you run into once you leave the embedded world, pretty much.
>
> >> * Handle managed interrupts
> >
> > Any examples of managed interrupts in the RISC-V world ?
>
> E.g. all nvme drives: nvme_setup_irqs(), and I'd assume contemporary
> netdev drivers would use it. Typically devices with per-cpu queues.

We have tested with NVMe devices, e1000e, VirtIO-net, etc and I did
not see any issue.

We can always add new features as separate incremental series as long
as there is clear use-cause backed by real-world devices.

>
> >> * There might be some irqd flags are missing, which mostly cpuhp care
> >>   about (e.g. irqd_*_single_target())...
> >
> > Okay, let me check and update.
>
> I haven't dug much into cpuhp, so I'm out on a limb here...
>
> >> Finally; Given that the APLIC requires a lot more patches, depending
> >> on how the review process moves on -- maybe the IMSIC side could go as
> >> a separate series?
> >>
> >
> > The most popular implementation choice across RISC-V platforms
> > will be IMSIC + APLIC so both drivers should go together. In fact,
> > we need both drivers for the QEMU virt machine as well because
> > UART interrupt (and other wired interrupts) on the QEMU virt
> > machine goes through APLIC.
>
> Thanks for clearing that out! Hmm, an IMSIC only QEMU would be awesome.
>
>
> Cheers,
> Bj=C3=B6rn

Regards,
Anup

