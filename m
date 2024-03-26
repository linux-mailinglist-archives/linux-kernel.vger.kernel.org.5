Return-Path: <linux-kernel+bounces-119560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DB588CA72
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FCF1F82AF1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2240C1D554;
	Tue, 26 Mar 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9DczX69"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6803C20B20;
	Tue, 26 Mar 2024 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473111; cv=none; b=RLgKf8+ZU1sBU0s6J7RL9l2JFJSnAfcCdQ/hOIkTkGrcifTeW3KyCOx46Kx7ErPZkq8wV27/6Rth9uG2kwhXOZXoAymKNi7xNPZzwIe5m5MAFOnFL8O75QIwJR/WN+b0L5RfNHhUVB0VV8sQu+zdwWi/UGHG/VKTnajk6xp2sKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473111; c=relaxed/simple;
	bh=SHSbPddnUrZNJUnZQETz0axiiuHhU56cJ/TyjxOm3LE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FVTFyClDiLqdmA8HOooMYgCGkAk6do3bl6vomI2aQ6r2/cVnx//qBuSt7PLnJGY3rqnI9yuPPCAakSxL9w4lEI/ZKrMOmBkGnuzypiyQ9QVT3tMLpe5w6IDpk9egETSzkwfs8eT8SNs9QEGAEpH4uLYNgVd+4tPEDiEk1VkSyz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9DczX69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68446C43399;
	Tue, 26 Mar 2024 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711473110;
	bh=SHSbPddnUrZNJUnZQETz0axiiuHhU56cJ/TyjxOm3LE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=k9DczX69FvUQ6wdICAIJXiq1qaqYzNybKX/V+0hbSEhTZO6Q/IDyUfO+T0mZbLFoU
	 2JHkuWbGZdLCAZSmiLl89L9xs/BUDMV+wis1wiXB9+tw6CMioewzz6Xxg7iHfyIeer
	 MV7OmEh/I3M8FcPpapn0tWIkyR9n0nE1+sudyLFMOdzX9z4KNEqDFHBYHa4chU9MtF
	 ooPpKMvpI0iVPfvhZ1Gx4+7AAnNvVhp2bxMgj5z5687GC8kmpz2DOnm3nPo8qHH++t
	 Jo5FPJqDXtzFwnMxVzuIkhqAzH9pIgUsca/G/irikJZYMdpRStUUUmdmw9PYHR3rkB
	 SfVjRo212/Ptg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Mar 2024 19:11:46 +0200
Message-Id: <D03UKZ3OIEXX.2PCKOX8NOLMKT@kernel.org>
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
 <20240327002403.62649aee45508b7a16caedba@kernel.org>
 <ZgL5779MIS61GpV6@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZgL5779MIS61GpV6@FVFF77S0Q05N.cambridge.arm.com>

On Tue Mar 26, 2024 at 6:38 PM EET, Mark Rutland wrote:
> On Wed, Mar 27, 2024 at 12:24:03AM +0900, Masami Hiramatsu wrote:
> > On Tue, 26 Mar 2024 14:46:10 +0000
> > Mark Rutland <mark.rutland@arm.com> wrote:
> > >=20
> > > On Mon, Mar 25, 2024 at 11:56:32AM +0900, Masami Hiramatsu wrote:
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
> >=20
> > OK, as far as I can read the code, this method also works and neat!=20
> > (and minimum intrusion). I actually found that exposing CONFIG_ALLOC_EX=
ECMEM
> > to user does not help, it should be an internal change. So hiding this =
change
> > from user is better choice. Then there is no reason to introduce the ne=
w
> > alloc_execmem, but just expand kprobe_alloc_insn_page() is reasonable.
> >=20
> > Mark, can you send this series here, so that others can review/test it?
>
> I've written up a cover letter and sent that out:
>  =20
>   https://lore.kernel.org/lkml/20240326163624.3253157-1-mark.rutland@arm.=
com/
>
> Mark.

Ya, saw it thanks!

BR, Jarkko

