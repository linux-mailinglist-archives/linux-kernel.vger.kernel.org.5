Return-Path: <linux-kernel+bounces-119555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D341E88CA63
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6693032049B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527DB1D537;
	Tue, 26 Mar 2024 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naXAvZRG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80039C12C;
	Tue, 26 Mar 2024 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472990; cv=none; b=RBop/RE8nT/3Thkf6ND0UsMEN7OYHRobBIo4u/gxA+lb4Yvh5CLS5iaBaBjHZdB+lfuCST3aags9CbtStd5WTDoHiN5O0KZTkLP+zLNWsDmtZ7xioKhPCZxBtywD4KoniliUlkrcqRr9f+v24Utj+S5UlBno0eHemsGfp1LXaB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472990; c=relaxed/simple;
	bh=BY9c4E9vzDvOXrNiXYtkhJynRYSTojLgUhZvqEXN4A0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=UAoKOJn38GJQyKyJCTAdsxeZcZNGRiRyCuVn7LKayzSgzHFDhHK5EiBJ4HGFRw62kl2a4Dl2kkGYRLkdgVU+xDSOXDmw+prL9cNUfUe1T8r6z/IewGI59fRLNSDCkLkDnIHr/ejdEXdMkblCpcfvW5NDi/aMZnayGxf3wkiivH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naXAvZRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05F7C433C7;
	Tue, 26 Mar 2024 17:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711472990;
	bh=BY9c4E9vzDvOXrNiXYtkhJynRYSTojLgUhZvqEXN4A0=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=naXAvZRGyE6HDXlpW+PfEasgiZtDiIq7vGErdR+UkCVzNvE1u00wuDA2bJqsDtHP4
	 zjyneI29fkt+0PXJ3GgvesgC/O1vt6JkMZmd7uZsFG5NepewsbrCZVVSiUMZ4oCHRT
	 +lZTDLV9CAyZBpx2LQozLSOth9ZL6B6fRMb/7nhnSSMfGQ9kbUXJoY+lYW05+H14lv
	 pL8eNBMdLeEdOP/vHLNs8M65MNDcgLRmt4CuCk9jAwuc+4YbpZxaCBz+s+xzZzRDS8
	 aodzOvzeY5zlx80qHXVS0MeOmRBrUp9v0KiwUKM/Eii7Wv7VLEcUXMC5kG3wg5S9Ub
	 KS1iHiIGRXF0Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Mar 2024 19:09:46 +0200
Message-Id: <D03UJFLR3Q4L.14P4KW3XMCXRM@kernel.org>
To: "Calvin Owens" <jcalvinowens@gmail.com>, "Masami Hiramatsu"
 <mhiramat@kernel.org>
Cc: "Mark Rutland" <mark.rutland@arm.com>,
 <linux-riscv@lists.infradead.org>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>, "Naveen N .
 Rao" <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240323232908.13261-1-jarkko@kernel.org>
 <20240325115632.04e37297491cadfbbf382767@kernel.org>
 <ZgLfsvbCZj2S6fRE@FVFF77S0Q05N.cambridge.arm.com>
 <20240327002403.62649aee45508b7a16caedba@kernel.org>
 <ZgL0ks5gikCG7NBN@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <ZgL0ks5gikCG7NBN@debian-BULLSEYE-live-builder-AMD64>

On Tue Mar 26, 2024 at 6:15 PM EET, Calvin Owens wrote:
> On Wednesday 03/27 at 00:24 +0900, Masami Hiramatsu wrote:
> > On Tue, 26 Mar 2024 14:46:10 +0000
> > Mark Rutland <mark.rutland@arm.com> wrote:
> >=20
> > > Hi Masami,
> > >=20
> > > On Mon, Mar 25, 2024 at 11:56:32AM +0900, Masami Hiramatsu wrote:
> > > > Hi Jarkko,
> > > >=20
> > > > On Sun, 24 Mar 2024 01:29:08 +0200
> > > > Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > >=20
> > > > > Tracing with kprobes while running a monolithic kernel is current=
ly
> > > > > impossible due the kernel module allocator dependency.
> > > > >=20
> > > > > Address the issue by allowing architectures to implement module_a=
lloc()
> > > > > and module_memfree() independent of the module subsystem. An arch=
 tree
> > > > > can signal this by setting HAVE_KPROBES_ALLOC in its Kconfig file=
.
> > > > >=20
> > > > > Realize the feature on RISC-V by separating allocator to module_a=
lloc.c
> > > > > and implementing module_memfree().
> > > >=20
> > > > Even though, this involves changes in arch-independent part. So it =
should
> > > > be solved by generic way. Did you checked Calvin's thread?
> > > >=20
> > > > https://lore.kernel.org/all/cover.1709676663.git.jcalvinowens@gmail=
com/
> > > >=20
> > > > I think, we'd better to introduce `alloc_execmem()`,
> > > > CONFIG_HAVE_ALLOC_EXECMEM and CONFIG_ALLOC_EXECMEM at first
> > > >=20
> > > >   config HAVE_ALLOC_EXECMEM
> > > > 	bool
> > > >=20
> > > >   config ALLOC_EXECMEM
> > > > 	bool "Executable trampline memory allocation"
> > > > 	depends on MODULES || HAVE_ALLOC_EXECMEM
> > > >=20
> > > > And define fallback macro to module_alloc() like this.
> > > >=20
> > > > #ifndef CONFIG_HAVE_ALLOC_EXECMEM
> > > > #define alloc_execmem(size, gfp)	module_alloc(size)
> > > > #endif
> > >=20
> > > Please can we *not* do this? I think this is abstracting at the wrong=
 level (as
> > > I mentioned on the prior execmem proposals).
> > >=20
> > > Different exectuable allocations can have different requirements. For=
 example,
> > > on arm64 modules need to be within 2G of the kernel image, but the kp=
robes XOL
> > > areas can be anywhere in the kernel VA space.
> > >=20
> > > Forcing those behind the same interface makes things *harder* for arc=
hitectures
> > > and/or makes the common code more complicated (if that ends up having=
 to track
> > > all those different requirements). From my PoV it'd be much better to=
 have
> > > separate kprobes_alloc_*() functions for kprobes which an architectur=
e can then
> > > choose to implement using a common library if it wants to.
> > >=20
> > > I took a look at doing that using the core ifdeffery fixups from Jark=
ko's v6,
> > > and it looks pretty clean to me (and works in testing on arm64):
> > >=20
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/=
?h=3Dkprobes/without-modules
> > >=20
> > > Could we please start with that approach, with kprobe-specific alloc/=
free code
> > > provided by the architecture?
>
> Heh, I also noticed that dead !RWX branch in arm64 patch_map(), I was
> about to send a patch to remove it.
>
> > OK, as far as I can read the code, this method also works and neat!=20
> > (and minimum intrusion). I actually found that exposing CONFIG_ALLOC_EX=
ECMEM
> > to user does not help, it should be an internal change. So hiding this =
change
> > from user is better choice. Then there is no reason to introduce the ne=
w
> > alloc_execmem, but just expand kprobe_alloc_insn_page() is reasonable.
>
> I'm happy with this, it solves the first half of my problem. But I want
> eBPF to work in the !MODULES case too.
>
> I think Mark's approach can work for bpf as well, without needing to
> touch module_alloc() at all? So I might be able to drop that first patch
> entirely.

Yeah, I think we're aligned. Later on, if/when you send the bpf series
please also cc me and I might possibly test those patches too.

BR, Jarkko

