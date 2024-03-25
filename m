Return-Path: <linux-kernel+bounces-117726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BE488AED5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C29C303E48
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0EF1EF1A;
	Mon, 25 Mar 2024 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGOCOCHp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAEEBE4D;
	Mon, 25 Mar 2024 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391880; cv=none; b=iNLz8vUStuCxBhK7DX7760ywhx9NMKgoxaP0Iqvi7+kEHI/Bha4Oi62bCQUrGSeoVV9FX5MDhsB1bSra8VVpwI25bDq69ZLGERpy5Sl2tJnPa4azNmXznwa8h7xsJ/EeuyFPQbddKVBIH4iyhOKyIxV6kFdnMB+4QTk8Z1oDaCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391880; c=relaxed/simple;
	bh=NZ8ILajyJZp/6r5YApASYz0CQF3HAtXJb6AdZAZRbOo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=NuJjoZBjw8NPk+zsdVOiSxqO+Lw+dm0Wd3ELYP2pnkJtey8tBOBaZh/jq1iTbtRVM0IB1ywvJvuH41HRalIPpR15adUtE74gvXJ2mfaBLUCxCbVvkHw4sA21YBTk3vqhTrtuhNFZrboGNj0wrZueqBOMeUeX96zQ7Nh4ox91Few=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGOCOCHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0425C433F1;
	Mon, 25 Mar 2024 18:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711391880;
	bh=NZ8ILajyJZp/6r5YApASYz0CQF3HAtXJb6AdZAZRbOo=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=UGOCOCHpMLkpa5Zvpv7VOcuZ7OqMfLSKGY85IkyeCkgXdaBN3pemZspl5hbiqRYa2
	 OEFMiZh8+aPVRnzje21rJKhYJMuQY/z8vSI7LaqDQUbcaOgh+eH5JHGnJ0reer69nn
	 y58IyiOAX423nM+ROQA2AN4TBX0pokhb/Q3dtsiHXpb5NfMfqrvX1wakxqwkOCfHdU
	 hE3a+bXeXfcEvGI8z/luv61oCEO/e2U9/A8i0zTz/QAAAxnaq0e/iKEynVu+AAdG1E
	 mu416QkmS6HZ2+VYNv5kWqg5RXCmfxR375M2l3DPWLjoL8U/t7H8XpTqynCN7iVeAu
	 oKX2/6VvQK8Xw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 Mar 2024 20:37:55 +0200
Message-Id: <D031SE4QN1CG.18GY6AS20QF1J@kernel.org>
To: "Masami Hiramatsu" <mhiramat@kernel.org>
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
In-Reply-To: <20240325115632.04e37297491cadfbbf382767@kernel.org>

On Mon Mar 25, 2024 at 4:56 AM EET, Masami Hiramatsu (Google) wrote:
> Hi Jarkko,
>
> On Sun, 24 Mar 2024 01:29:08 +0200
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> > Tracing with kprobes while running a monolithic kernel is currently
> > impossible due the kernel module allocator dependency.
> >=20
> > Address the issue by allowing architectures to implement module_alloc()
> > and module_memfree() independent of the module subsystem. An arch tree
> > can signal this by setting HAVE_KPROBES_ALLOC in its Kconfig file.
> >=20
> > Realize the feature on RISC-V by separating allocator to module_alloc.c
> > and implementing module_memfree().
>
> Even though, this involves changes in arch-independent part. So it should
> be solved by generic way. Did you checked Calvin's thread?
>
> https://lore.kernel.org/all/cover.1709676663.git.jcalvinowens@gmail.com/

Nope, has not been in my radar but for sure will check it.

I don't mind making this more generic. The  point of this version was to
put focus on single architecture and do as little as possible how the
code works right now so that it is easier to give feedback on direction.

> I think, we'd better to introduce `alloc_execmem()`,
> CONFIG_HAVE_ALLOC_EXECMEM and CONFIG_ALLOC_EXECMEM at first
>
>   config HAVE_ALLOC_EXECMEM
> 	bool
>
>   config ALLOC_EXECMEM
> 	bool "Executable trampline memory allocation"
> 	depends on MODULES || HAVE_ALLOC_EXECMEM

Right so this is logically the same as I have just with ALLOC_EXECMEM
added to cover both MODULES and HAVE_ALLOC_EXECMEM (which is essentially
the same as HAVE_ALLOC_KPROBES just with a different name).

Not at all against this. I think this factor more understandable
structuring, just "peer checking" that I understand what I'm reading :-)

> And define fallback macro to module_alloc() like this.
>
> #ifndef CONFIG_HAVE_ALLOC_EXECMEM
> #define alloc_execmem(size, gfp)	module_alloc(size)
> #endif
>
> Then, introduce a new dependency to kprobes
>
>   config KPROBES
>   	bool "Kprobes"
> 	select ALLOC_EXECMEM


OK I think this is good but now I see actually two logical chunks of
work becuse this select changes how KPROBES kconfig option works. It
has previously required to manually select MODULES first.

So I'll "select MODULES" as separate patch to keep all logical changes
transparent...

>
> and update kprobes to use alloc_execmem and remove module related
> code from it.
>
> You also should consider using IS_ENABLED(CONFIG_MODULE) in the code to
> avoid using #ifdefs.
>
> Finally, you can add RISCV implementation patch of HAVE_ALLOC_EXECMEM in =
the
> next patch.

OK, I think the suggestions are sane and not that much drift what I have
now so works for me.

> Thank you,

BR, Jarkko

