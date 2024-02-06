Return-Path: <linux-kernel+bounces-55259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309F584B9D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08CB285074
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF99C133982;
	Tue,  6 Feb 2024 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJwtKpxX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0136D132C1B;
	Tue,  6 Feb 2024 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233970; cv=none; b=icMp75xNw98bh0Vco3idyfaEGWxMIaLT1lWpsEC26hH8a4vJNzKx7nvZEJaNlF9BsxvpPy0zoqpwsHeFXmpQyGltlpA5+lT76kpIqvzwvmGD4I3gqMwkuOV1X/508aGc0jWZ0Pwi6XdO0OfF2FugH+TeF+AQ+/71ne4Dpop/a78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233970; c=relaxed/simple;
	bh=Sw9sxL8rwotSLvEI0YXtEhgz3yDEvv8z0ArKKOYw20A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rcHJdexD1FMpGrPR3NCETv/iCpUpGuE5Rp8l64BA6tHCoixUVG+t+5KiokktgdqQk6NfwTJIZfxRtJSAw+I9SZxM+yZFt6EH9XTNHZKhp8150isTn0C0alNPCGoloWTkAGWPoXPIrP1Veiapp9NG6G3h1QMWfYdxdYTstnuun/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJwtKpxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E7AC433C7;
	Tue,  6 Feb 2024 15:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707233969;
	bh=Sw9sxL8rwotSLvEI0YXtEhgz3yDEvv8z0ArKKOYw20A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lJwtKpxXCVWyIxGtyzAk0eSe/KWcOkyRdn3p7XKjCgwywfRgQ8tsOII8BjWNLzFTs
	 Ji7qSCGV0CPwo/29fWHWn/Mzbr79imv4J3RNwrRZtoop0zFb//PQSW5KohvRsfnzvE
	 +DGqNDQfSQ82lJN3KWz072k4tBvG/P+2dyMgtRMtebmEn+nL9SqPWA2Sf/3ayfZsCL
	 Yy5YVJDwe0AlvJf943czv4bpftcLc3j7RfU46LfnHsRHRyG2wqcqY2srqJKmJnq2zq
	 LdEf9ixvxviaBXgYFCla9g55X/j2TvWphZxapvx8Mug3dVohlRQtwwAS0Qmr03NjmQ
	 BtbzIOzCtdKaw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas
 Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org,
 Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>,
 Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org, Atish
 Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Andrew Jones
 <ajones@ventanamicro.com>
Subject: Re: [PATCH v12 00/25] Linux RISC-V AIA Support
In-Reply-To: <20240127161753.114685-1-apatel@ventanamicro.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
Date: Tue, 06 Feb 2024 16:39:27 +0100
Message-ID: <87h6ily53k.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Anup,

Anup Patel <apatel@ventanamicro.com> writes:

> The RISC-V AIA specification is ratified as-per the RISC-V international
> process. The latest ratified AIA specifcation can be found at:
> https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interrupts=
-1.0.pdf
>
> At a high-level, the AIA specification adds three things:
> 1) AIA CSRs
>    - Improved local interrupt support
> 2) Incoming Message Signaled Interrupt Controller (IMSIC)
>    - Per-HART MSI controller
>    - Support MSI virtualization
>    - Support IPI along with virtualization
> 3) Advanced Platform-Level Interrupt Controller (APLIC)
>    - Wired interrupt controller
>    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI generator)
>    - In Direct-mode, injects external interrupts directly into HARTs
>
> For an overview of the AIA specification, refer the AIA virtualization
> talk at KVM Forum 2022:
> https://static.sched.com/hosted_files/kvmforum2022/a1/AIA_Virtualization_=
in_KVM_RISCV_final.pdf
> https://www.youtube.com/watch?v=3Dr071dL8Z0yo

Thank you for continuing to work on this series! I like this
direction of the series!

TL;DR: I think we can get rid of most of the id/householding data
structures, except for the irq matrix.

Most of my comments are more of a design/overview nature, so I'll
comment here in the cover letter.

I took the series for a spin with and it with Alex' ftrace fix it,
passes all my tests nicely!

Now some thoughts/comments (I'm coming from the x86 side of things!):

id/enable-tracking: There are a lot of different id/enabled tracking
with corresponding locks, where there's IMO overlap with what the
matrix provides.

Let's start with struct imsic_priv:

   | /* Dummy HW interrupt numbers */
   | unsigned int nr_hwirqs;
   | raw_spinlock_t hwirqs_lock;
   | unsigned long *hwirqs_used_bitmap;

These are used to for the domain routing (hwirq -> desc/virq), and not
needed. Just use the same id as virq (at allocation time), and get rid
of these data structures/corresponding functions. The lookup in the
interrupt handler via imsic_local_priv.vectors doesn't care about
hwirq. This is what x86 does... The imsic_vector roughly corresponds
to apic_chip_data (nit: imsic_vector could have the chip_data suffix
as well, at least it would have helped me!)

Moving/affinity changes. The moving of a vector to another CPU
currently involves:

1. Allocate a new vector from the matrix
2. Disable/enable the corresponding per-cpu ids_enabled_bitmap (nested
   spinlocks)
3. Trigger two IPIs to apply the bitmap
4. On each CPU target (imsic_local_sync()) loop the bitmap and flip
   all bits, and potentially rearm

This seems a bit heavy-weight: Why are you explicitly setting/clearing
all the bits in a loop at the local sync?

x86 does it a bit differently (more lazily): The chip_data has
prev_{cpu,vector}/move_in_progress fields, and keep both vectors
enabled until there's an interrupt on the new vector, and then the old
one is cleaned (irq_complete_move()).

Further; When it's time to remove the old vector, x86 doesn't trigger
an IPI on the disabling side, but queues a cleanup job on a per-cpu
list and triggers a timeout. So, the per-cpu chip_data (per-cpu
"vectors" in your series) can reside in two places during the transit.

I wonder if this clean up is less intrusive, and you just need to
perform what's in the per-list instead of dealing with the
ids_enabled_bitmap? Maybe we can even remove that bitmap as well. The
chip_data/desc has that information. This would mean that
imsic_local_priv() would only have the local vectors (chip_data), and
a cleanup list/timer.

My general comment is that instead of having these global id-tracking
structures, use the matrix together with some desc/chip_data local
data, which should be sufficient.

Random thought: Do we need to explicitly disable (csr) the vector,
when we're changing the affinity? What if we just leave it enabled,
and only when mask/unmask is performed it's actually explicitly masked
(writes to the csr)?

Missing features (which can be added later):
* Reservation mode/activate support (allocate many MSI, but only
  request/activate a subset)
* Handle managed interrupts
* There might be some irqd flags are missing, which mostly cpuhp care
  about (e.g. irqd_*_single_target())...

Finally; Given that the APLIC requires a lot more patches, depending
on how the review process moves on -- maybe the IMSIC side could go as
a separate series?


Cheers,
Bj=C3=B6rn


