Return-Path: <linux-kernel+bounces-56231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BA184C7A6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6925B28D61C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A361F286B2;
	Wed,  7 Feb 2024 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVfxXSKq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D602128DCA;
	Wed,  7 Feb 2024 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298623; cv=none; b=qXG1ySvEBP/EPnkVqhP1Ic0TyipFV2ZuwCeRGjyus7CyEu19XYAwJLEvfGLin0sUcpR1rVDeMIDjXDiyVQuLLdODvhnrhT/XEovoZputPxTjXF4v6cMrErZIXw6mvkJCJ2YrDETGBSO+ei4H5RVWqalwLcxU4eUiywXPfYuTfZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298623; c=relaxed/simple;
	bh=aoRH2DoNT3Z90bz2In+tDxMUOuyrpumWFsvVUaOg/ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KwQ1OCRygW62yqjkr8pPPvmIALkXgCYQ8SUbtisJXUybBkfw56h4vAKDiujLQkySThllZX4K/JIIjYj2g6KOvKZg6lmkMrQZNYegy40ymK+8z0sSXEkUJuh8wRreGnwXRSh0uxJLCZBJRASekAkZ5GKEX3rQ0dVFY+M+GIDXKIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVfxXSKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA331C433F1;
	Wed,  7 Feb 2024 09:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707298623;
	bh=aoRH2DoNT3Z90bz2In+tDxMUOuyrpumWFsvVUaOg/ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VVfxXSKqvYjuDvHtZM27s+bZk+wuzliRqQ+rtpvOJ9ruL3yzq22IGY/WvFPYcJ+ny
	 7gMKc6INqBfJNjJ67kZ2k54a+9YbxXpUK+VBZIbPOpXl6Hz7Ss+/8W9VLii2bJco7w
	 5TijiDWiUIhZAEX8mlbMVouiABg69OrxyLlKuiIwObAr4KpVSB1ZXuozgsvAj0rs9w
	 NYibP3naf1M+s6Rf33frNPRHS6fpwegJXmEHRJuuNLyIET2i7WjultE0MPVnf20inh
	 aakWrnaJtHxxAmybC6evHWxtbh2ZHjby6jsrSKaVz0V7WdTRLUHjFGsH/2uygalQQO
	 3OcTVQr/ob+Dw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner
 <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, Saravana Kannan <saravanak@google.com>, Marc
 Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, Atish Patra
 <atishp@atishpatra.org>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Andrew Jones
 <ajones@ventanamicro.com>
Subject: Re: [PATCH v12 00/25] Linux RISC-V AIA Support
In-Reply-To: <CAK9=C2XJYTfY4nXWtjK9OP1iXLDXBVF-=mN1SmJDmJ_dO5CohA@mail.gmail.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <87h6ily53k.fsf@all.your.base.are.belong.to.us>
 <CAAhSdy2PPjS6++Edh8NkgiBmcovTUjS5oXE2eR5ZwPfAfVA0ng@mail.gmail.com>
 <874jekag3w.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2XJYTfY4nXWtjK9OP1iXLDXBVF-=mN1SmJDmJ_dO5CohA@mail.gmail.com>
Date: Wed, 07 Feb 2024 10:37:00 +0100
Message-ID: <87plx8y5s3.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup Patel <apatel@ventanamicro.com> writes:

>> Nope. Same mechanics on x86 -- the cleanup has to be done one the
>> originating core. What I asked was "what about using a timer instead of
>> an IPI". I think this was up in the last rev as well?
>>
>> Check out commit bdc1dad299bb ("x86/vector: Replace
>> IRQ_MOVE_CLEANUP_VECTOR with a timer callback") Specifically, the
>> comment about lost interrupts, and the rational for keeping the original
>> target active until there's a new interrupt on the new cpu.
>
> Trying timer interrupt is still TBD on my side because with v12
> my goal was to implement per-device MSI domains. Let me
> explore timer interrupts for v13.

OK!

>> >> I wonder if this clean up is less intrusive, and you just need to
>> >> perform what's in the per-list instead of dealing with the
>> >> ids_enabled_bitmap? Maybe we can even remove that bitmap as well. The
>> >> chip_data/desc has that information. This would mean that
>> >> imsic_local_priv() would only have the local vectors (chip_data), and
>> >> a cleanup list/timer.
>> >>
>> >> My general comment is that instead of having these global id-tracking
>> >> structures, use the matrix together with some desc/chip_data local
>> >> data, which should be sufficient.
>> >
>> > The "ids_enabled_bitmap", "dummy hwirqs" and private imsic_vectors
>> > are required since the matrix allocator only manages allocation of
>> > per-CPU IDs.
>>
>> The information in ids_enabled_bitmap is/could be inherent in
>> imsic_local_priv.vectors (guess what x86 does... ;-)).
>>
>> Dummy hwirqs could be replaced with the virq.
>>
>> Hmm, seems like we're talking past each other, or at least I get the
>> feeling I can't get my opinions out right. I'll try to do a quick PoC,
>> to show you what I mean. That's probably easier than just talking about
>> it. ...and maybe I'll come realizing I'm all wrong!
>
> I suggest to wait for my v13 and try something on top of that
> otherwise we might duplicate efforts.

OK!

>> > I did not see any PCIe or platform device requiring this kind of
>> > reservation. Any examples ?
>>
>> It's not a requirement. Some devices allocate a gazillion interrupts
>> (NICs with many QoS queues, e.g.), but only activate a subset (via
>> request_irq()). A system using these kind of devices might run out of
>> interrupts.
>
> I don't see how this is not possible currently.

Again, this is something we can improve on later. But, this
implementation activates the interrupt at allocation time, no?

>> Problems you run into once you leave the embedded world, pretty much.
>>
>> >> * Handle managed interrupts
>> >
>> > Any examples of managed interrupts in the RISC-V world ?
>>
>> E.g. all nvme drives: nvme_setup_irqs(), and I'd assume contemporary
>> netdev drivers would use it. Typically devices with per-cpu queues.
>
> We have tested with NVMe devices, e1000e, VirtIO-net, etc and I did
> not see any issue.
>
> We can always add new features as separate incremental series as long
> as there is clear use-cause backed by real-world devices.

Agreed. Let's not feature creep.


Bj=C3=B6rn

