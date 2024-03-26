Return-Path: <linux-kernel+bounces-119534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B67188C9F8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35EBB1C39F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66B213D62B;
	Tue, 26 Mar 2024 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXVvxtgc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDE013CC45;
	Tue, 26 Mar 2024 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472458; cv=none; b=elwRuX9B8aQfMvixOy7WmAd+rTBU9Hc23+GCAkkvwDiCRXvPuh4h7R9djTZROyuAVITATJ7Z+mbCyr70+DEtcyA443DEHIeB8O12Fy0PnzC1wVSHzSe6i9fcsSc7A4+qgwakngt2BPjf+/bIiJhRqI7Ooyhxf4bOm0xfp5+KtvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472458; c=relaxed/simple;
	bh=AFcWHQ4HktAL4RBbzmRQAOlWsOrVDpkRrN1OI6wGpMY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=S+ZdqsSxtkBYL/rglde9+VtuVkdpONszOmVfBi3ykpC8QjXEZYmcTB+SseWVvfhmNuTJ3XGO3T6Zzg+xHTMYbAZpEQ4eSftOUidDWK2DHTRyWVWxeVoZP7jdR1thePSla6N8k1oMFj0kOLuEwftWQsdxukhZdoggmH5wMCbawDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXVvxtgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287ACC433A6;
	Tue, 26 Mar 2024 17:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711472457;
	bh=AFcWHQ4HktAL4RBbzmRQAOlWsOrVDpkRrN1OI6wGpMY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=SXVvxtgcGny55EK6PwY+sTqI4mMVPakmbrnjmbnfC8DSpUewAWuQGnrUmYa0/N3QC
	 cVeZ6QnHl0CQNeGXT6XP1c9qvvK2CviXQVg69KpPhYwqve3U+xAYMoFOAiOGO2k8F/
	 2esMcfHk+ZWFPY4/hck+suYFzT7sGxxrUnoUWo2VmB4lTrTLXAPaLPGiijoopfNx70
	 Y7aXKZesmhZaOf9tRrtlNBliUUtICUT7oDZ9cT4VPcWi76luukotK+Y3b+YHtlrvkQ
	 2wRzMaNd0fJNjMUmZwTvTkWoSS9xLXa/ueuZg/0W0AhnGejPk8lz1zbGfVR3v6QzUP
	 4+NObRzlLzC4w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Mar 2024 19:00:53 +0200
Message-Id: <D03UCMS8261H.3AFBTINZ4ZN4Y@kernel.org>
Cc: <linux-riscv@lists.infradead.org>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>, "Naveen N .
 Rao" <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 <linux-trace-kernel@vger.kernel.org>, "Calvin Owens"
 <jcalvinowens@gmail.com>
Subject: Re: [PATCH v2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mark Rutland" <mark.rutland@arm.com>, "Masami Hiramatsu"
 <mhiramat@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240323232908.13261-1-jarkko@kernel.org>
 <20240325115632.04e37297491cadfbbf382767@kernel.org>
 <ZgLfsvbCZj2S6fRE@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZgLfsvbCZj2S6fRE@FVFF77S0Q05N.cambridge.arm.com>

On Tue Mar 26, 2024 at 4:46 PM EET, Mark Rutland wrote:
> Hi Masami,
>
> On Mon, Mar 25, 2024 at 11:56:32AM +0900, Masami Hiramatsu wrote:
> > Hi Jarkko,
> >=20
> > On Sun, 24 Mar 2024 01:29:08 +0200
> > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >=20
> > > Tracing with kprobes while running a monolithic kernel is currently
> > > impossible due the kernel module allocator dependency.
> > >=20
> > > Address the issue by allowing architectures to implement module_alloc=
()
> > > and module_memfree() independent of the module subsystem. An arch tre=
e
> > > can signal this by setting HAVE_KPROBES_ALLOC in its Kconfig file.
> > >=20
> > > Realize the feature on RISC-V by separating allocator to module_alloc=
c
> > > and implementing module_memfree().
> >=20
> > Even though, this involves changes in arch-independent part. So it shou=
ld
> > be solved by generic way. Did you checked Calvin's thread?
> >=20
> > https://lore.kernel.org/all/cover.1709676663.git.jcalvinowens@gmail.com=
/
> >=20
> > I think, we'd better to introduce `alloc_execmem()`,
> > CONFIG_HAVE_ALLOC_EXECMEM and CONFIG_ALLOC_EXECMEM at first
> >=20
> >   config HAVE_ALLOC_EXECMEM
> > 	bool
> >=20
> >   config ALLOC_EXECMEM
> > 	bool "Executable trampline memory allocation"
> > 	depends on MODULES || HAVE_ALLOC_EXECMEM
> >=20
> > And define fallback macro to module_alloc() like this.
> >=20
> > #ifndef CONFIG_HAVE_ALLOC_EXECMEM
> > #define alloc_execmem(size, gfp)	module_alloc(size)
> > #endif
>
> Please can we *not* do this? I think this is abstracting at the wrong lev=
el (as
> I mentioned on the prior execmem proposals).
>
> Different exectuable allocations can have different requirements. For exa=
mple,
> on arm64 modules need to be within 2G of the kernel image, but the kprobe=
s XOL
> areas can be anywhere in the kernel VA space.
>
> Forcing those behind the same interface makes things *harder* for archite=
ctures
> and/or makes the common code more complicated (if that ends up having to =
track
> all those different requirements). From my PoV it'd be much better to hav=
e
> separate kprobes_alloc_*() functions for kprobes which an architecture ca=
n then
> choose to implement using a common library if it wants to.
>
> I took a look at doing that using the core ifdeffery fixups from Jarkko's=
 v6,
> and it looks pretty clean to me (and works in testing on arm64):
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=
=3Dkprobes/without-modules
>
> Could we please start with that approach, with kprobe-specific alloc/free=
 code
> provided by the architecture?

How should we move forward?

I'm fine with someone picking the pieces of my work as long as also the
riscv side is included. Can also continue rotating this, whatever works.

>
> Thanks,
> Mark.

BR, Jarkko

