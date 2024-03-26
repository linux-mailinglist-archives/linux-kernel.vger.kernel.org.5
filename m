Return-Path: <linux-kernel+bounces-119554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A435C88CA62
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20751C65741
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063F31272AD;
	Tue, 26 Mar 2024 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCgKlokx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0B08662C;
	Tue, 26 Mar 2024 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472926; cv=none; b=a/GlMQdHuc+YVK7sCF7LZfrG4wYlX89cVqb+DHQLIvYnCU60gkKGXa+R+nqHVg2Hlog7SRiGn+4mULrtmGnB3XtaamW8znZJ3MxakbAeuk0U5A9zQVNXZxI161WnvzcIi1hFs8Vz6g6ez5SH90iCm9HSx7HF2qHCNv3BNeYGLqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472926; c=relaxed/simple;
	bh=dN0gSZu3c0pxIjenuKrXn6qbTPv74OtuYtIXmx816Hs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=GOHmNI0muh2Lro18F1kH+Qolm5OisvOWtsyweferRbnANDreAQyINmldh16b5lduABxtAaAl2LmVD/q/nkXDwzn+0N4cjb0aCh/PsKIcr3OrNwkgA87cedwTblveUOWZONYvqyPe9KpqIVa+313BbDmVCin8bILKAY4b7S5DQS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCgKlokx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB519C433C7;
	Tue, 26 Mar 2024 17:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711472926;
	bh=dN0gSZu3c0pxIjenuKrXn6qbTPv74OtuYtIXmx816Hs=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=GCgKlokxyRXixrqHZzn8I1AIoBJ0ecd+jM/ZVJN9PAucXybFzeAI6IsH/VxWnfi7S
	 u7BDQlPUMMRksvVb4pBamsY7npGn3aKwiY6IvAdyJQ4JGRbyGPkXUxCaQWIKNH1jjO
	 Wtt1BTn3CnbvVBt/bNgQ1xXcFDOjrI8lLI0rtclaHmrpQsnELcA4K3sKo548YpgDPk
	 uWjF7tJKgZjdgIMR9QsNtqaUGxFiG5Qs1Q+HwHNt8nduqYvkwV42MhPh5pPxCa+rEk
	 SHLOYxccQ+2Nr9UC+kjK+YooUmSWyB9TV0NY8GnPiTvoBRfocCFOPCQM+ocTzg8uj4
	 CHq+M4LEplw/g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Mar 2024 19:08:41 +0200
Message-Id: <D03UIM5QZUZ8.2G6OHP1IM17OU@kernel.org>
To: "Masami Hiramatsu" <mhiramat@kernel.org>, "Mark Rutland"
 <mark.rutland@arm.com>
Cc: <linux-riscv@lists.infradead.org>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>, "Naveen N .
 Rao" <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 <linux-trace-kernel@vger.kernel.org>, "Calvin Owens"
 <jcalvinowens@gmail.com>
Subject: Re: [PATCH v2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240323232908.13261-1-jarkko@kernel.org>
 <20240325115632.04e37297491cadfbbf382767@kernel.org>
 <ZgLfsvbCZj2S6fRE@FVFF77S0Q05N.cambridge.arm.com>
 <20240327002403.62649aee45508b7a16caedba@kernel.org>
In-Reply-To: <20240327002403.62649aee45508b7a16caedba@kernel.org>

On Tue Mar 26, 2024 at 5:24 PM EET, Masami Hiramatsu (Google) wrote:
> On Tue, 26 Mar 2024 14:46:10 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
>
> > Hi Masami,
> >=20
> > On Mon, Mar 25, 2024 at 11:56:32AM +0900, Masami Hiramatsu wrote:
> > > Hi Jarkko,
> > >=20
> > > On Sun, 24 Mar 2024 01:29:08 +0200
> > > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >=20
> > > > Tracing with kprobes while running a monolithic kernel is currently
> > > > impossible due the kernel module allocator dependency.
> > > >=20
> > > > Address the issue by allowing architectures to implement module_all=
oc()
> > > > and module_memfree() independent of the module subsystem. An arch t=
ree
> > > > can signal this by setting HAVE_KPROBES_ALLOC in its Kconfig file.
> > > >=20
> > > > Realize the feature on RISC-V by separating allocator to module_all=
oc.c
> > > > and implementing module_memfree().
> > >=20
> > > Even though, this involves changes in arch-independent part. So it sh=
ould
> > > be solved by generic way. Did you checked Calvin's thread?
> > >=20
> > > https://lore.kernel.org/all/cover.1709676663.git.jcalvinowens@gmail.c=
om/
> > >=20
> > > I think, we'd better to introduce `alloc_execmem()`,
> > > CONFIG_HAVE_ALLOC_EXECMEM and CONFIG_ALLOC_EXECMEM at first
> > >=20
> > >   config HAVE_ALLOC_EXECMEM
> > > 	bool
> > >=20
> > >   config ALLOC_EXECMEM
> > > 	bool "Executable trampline memory allocation"
> > > 	depends on MODULES || HAVE_ALLOC_EXECMEM
> > >=20
> > > And define fallback macro to module_alloc() like this.
> > >=20
> > > #ifndef CONFIG_HAVE_ALLOC_EXECMEM
> > > #define alloc_execmem(size, gfp)	module_alloc(size)
> > > #endif
> >=20
> > Please can we *not* do this? I think this is abstracting at the wrong l=
evel (as
> > I mentioned on the prior execmem proposals).
> >=20
> > Different exectuable allocations can have different requirements. For e=
xample,
> > on arm64 modules need to be within 2G of the kernel image, but the kpro=
bes XOL
> > areas can be anywhere in the kernel VA space.
> >=20
> > Forcing those behind the same interface makes things *harder* for archi=
tectures
> > and/or makes the common code more complicated (if that ends up having t=
o track
> > all those different requirements). From my PoV it'd be much better to h=
ave
> > separate kprobes_alloc_*() functions for kprobes which an architecture =
can then
> > choose to implement using a common library if it wants to.
> >=20
> > I took a look at doing that using the core ifdeffery fixups from Jarkko=
's v6,
> > and it looks pretty clean to me (and works in testing on arm64):
> >=20
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=
=3Dkprobes/without-modules
> >=20
> > Could we please start with that approach, with kprobe-specific alloc/fr=
ee code
> > provided by the architecture?
>
> OK, as far as I can read the code, this method also works and neat!=20
> (and minimum intrusion). I actually found that exposing CONFIG_ALLOC_EXEC=
MEM
> to user does not help, it should be an internal change. So hiding this ch=
ange
> from user is better choice. Then there is no reason to introduce the new
> alloc_execmem, but just expand kprobe_alloc_insn_page() is reasonable.
>
> Mark, can you send this series here, so that others can review/test it?

I'm totally fine with this but yeah best would be if it could carry
the riscv part. Mark, even if you have only possibility to compile
test that part I can check that it works.

BR, Jarkko

