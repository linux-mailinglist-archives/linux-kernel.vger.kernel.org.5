Return-Path: <linux-kernel+bounces-65868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7150855306
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07BEE1C214E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E4C13B7B2;
	Wed, 14 Feb 2024 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="usCflKiA"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A4C134CCA;
	Wed, 14 Feb 2024 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707938062; cv=none; b=XocY33qO6/Jij2Djm7EOBbKCde/sup/PWH9FJzvxcYy/FLU/Nv++FK36diUh3MdNHqvHw+I6ctEs6e8AL1868pznyRepIPqYFWlHB24bocQKHRJuIKTeK0lXczX34GUslFXXlgR9AcZ8I0J/66KTiInlc+fDlMcU10z+abXc4Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707938062; c=relaxed/simple;
	bh=dtoL+qo2rjHSs2RZElyIu6BxXT9O3vZzuja1aFzJFgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyS/pba5sgCdDhNitcyqlYCNM+kBo6oh6RPoM8P4Pbllr8r/eTMbq0xpGoNNqXjXK+XG1rIVd3VdJZ+5TLOrL6TUTBKbrQ7HxLwhM5YnnXyZ0VkkfyvXSREe9Q91riiobnxUIJ8UiJdUdgQ3+Yjn4gEC/bViZsTMlZlB3U8u32c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=usCflKiA; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id B035B1A3C02;
	Wed, 14 Feb 2024 20:14:16 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1707938057; bh=+kn6Uw7nhL08sWX9dCxTs5rcdQk6XBojfgI0WQMAyeM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=usCflKiA3JOi0sndHsKiLct6zIXtCx2pAo2z6R8RG9ZpngNDPs6z9WIaKKrj5GjIl
	 tDHR6M2vAxsifYMkJ162tDT1Na1kXS9h1CRw8bvhvtL3JuYHtL9sNlSOcViacWKgas
	 tV0H2mY6PppGuPpBdgd/qBTAoqeh+MHxJFuCkCy72TBKG55Ak9xHJwxYWGlCNE/GDd
	 wITsdEJ2GsMuiPbMGglmaS04jGW//E6Rddb4knK1d0SsGGKvhTWdR9XJdeLCZ4iVTt
	 W1SwTq78Xwah5I93RkeHeAzgwt/UpxkV0rP/JdAUZje+1zf/V2enSndWWMthfZK2lS
	 RP5m4YTchyBqg==
Date: Wed, 14 Feb 2024 20:14:15 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Petr Tesarik
 <petrtesarik@huaweicloud.com>, Jonathan Corbet <corbet@lwn.net>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Xin Li <xin3.li@intel.com>, Arnd Bergmann
 <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Kees Cook <keescook@chromium.org>, "Masami
 Hiramatsu (Google)" <mhiramat@kernel.org>, Pengfei Xu
 <pengfei.xu@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Ze Gao
 <zegao2021@gmail.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Kai Huang <kai.huang@intel.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Brian Gerst <brgerst@gmail.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>, "Mike Rapoport
 (IBM)" <rppt@kernel.org>, Tina Zhang <tina.zhang@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH v1 0/8] x86_64 SandBox Mode arch hooks
Message-ID: <20240214201415.3dc7d69f@meshulam.tesarici.cz>
In-Reply-To: <9EF956AB-DF48-4DAA-AB42-0FBC513ECA22@zytor.com>
References: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
	<c424618c-d6c6-430a-8975-8851a617204e@intel.com>
	<34B19756-91D3-4DA1-BE76-BD3122C16E95@zytor.com>
	<20240214174143.74a4f10c@meshulam.tesarici.cz>
	<9EF956AB-DF48-4DAA-AB42-0FBC513ECA22@zytor.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 09:29:06 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

> On February 14, 2024 8:41:43 AM PST, "Petr Tesa=C5=99=C3=ADk" <petr@tesar=
ici.cz> wrote:
> >On Wed, 14 Feb 2024 07:28:35 -0800
> >"H. Peter Anvin" <hpa@zytor.com> wrote:
> > =20
> >> On February 14, 2024 6:52:53 AM PST, Dave Hansen <dave.hansen@intel.co=
m> wrote: =20
> >> >On 2/14/24 03:35, Petr Tesarik wrote:   =20
> >> >> This patch series implements x86_64 arch hooks for the generic Sand=
Box
> >> >> Mode infrastructure.   =20
> >> >
> >> >I think I'm missing a bit of context here.  What does one _do_ with
> >> >SandBox Mode?  Why is it useful?   =20
> >>=20
> >> Seriously. On the surface it looks like a really bad idea =E2=80=93 ba=
sically an ad hoc, *more* privileged version of user shave. =20
> >
> >Hi hpa,
> >
> >I agree that it kind of tries to do "user mode without user mode".
> >There are some differences from actual user mode:
> >
> >First, from a process management POV, sandbox mode appears to be
> >running in kernel mode. So, there is no way to use ptrace(2), send
> >malicious signals or otherwise interact with the sandbox. In fact,
> >the process can have three independent contexts: user mode, kernel mode
> >and sandbox mode.
> >
> >Second, a sandbox can run unmodified kernel code and interact directly
> >with other parts of the kernel. It's not really possible with this
> >initial patch series, but the plan is that sandbox mode can share locks
> >with the kernel.
> >
> >Third, sandbox code can be trusted for operations like parsing keys for
> >the trusted keychain if the kernel is locked down, i.e. when even a
> >process with UID 0 is not on the same trust level as kernel mode.
> >
> >HTH
> >Petr T
> > =20
>=20
> This, to me, seems like "all the downsides of a microkernel without the u=
psides." Furthermore, it breaks security-hardening features like LASS and (=
to a lesser degree) SMAP. Not to mention dropping global pages?

I must be missing something... But I am always open to learn something new.

I don't see how it breaks SMAP. Sandbox mode runs in its own address
space which does not contain any user-mode pages. While running in
sandbox mode, user pages belong to the sandboxed code, kernel pages are
used to enter/exit kernel mode. Bottom half of the PGD is empty, all
user page translations are removed from TLB.

For a similar reason, I don't see right now how it breaks linear
address space separation. Even if it did, I believe I can take care of
it in the entry/exit path. Anyway, which branch contains the LASS
patches now, so I can test?

As for dropping global pages, that's only part of the story. Indeed,
patch 6/8 of the series sets CR4.PGE to zero to have a known-good
working state, but that code is removed again by patch 8/8. I wanted to
implement lazy TLB flushing separately, so it can be easily reverted if
it is suspected to cause an issue.

Plus, each sandbox mode can use PCID to reduce TLB flushing even more.
I haven't done it, because it would be a waste of time if the whole
concept is scratched.

I believe that only those global pages which are actually accessed by
the sandbox need to be flushed. Yes, some parts of the necessary logic
are missing in the current patch series. I can add them in a v2 series
if you wish.

> All in all, I cannot see this as anything other than an enormous step in =
the wrong direction, and it isn't even in the sense of "it is harmless if n=
oone uses it" =E2=80=93 you are introducing architectural changes that are =
most definitely *very* harmful both to maintainers and users.

I agree that it adds some burden. After all, that's why the ultimate
decision is up to you, the maintainers. To defend my cause, I hope you
have noticed that if CONFIG_SANDBOX_MODE is not set:

1. literally nothing changes in entry_64.
2. sandbox_mode() always evaluates to false, so the added conditionals in f=
ault.c and traps.c are never executed
3. top_of_instr_stack() always returns current_top_of_stack(), which is equ=
ivalent to the code it replaces, namely this_cpu_read(pcpu_hot.top_of_stack)

So, all the interesting stuff is under arch/x86/kernel/sbm/. Shall I
add a corresponding entry with my name to MAINTAINERS?

> To me, this feels like paravirtualization all over again. 20 years later =
we still have not been able to undo all the damage that did.

OK, I can follow you here. Indeed, there is some similarity with Xen PV
(running kernel code with CPL 3), but I don't think there's more than
this.

Petr T

