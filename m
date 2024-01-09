Return-Path: <linux-kernel+bounces-20520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3DB828016
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B8A1C23A51
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECFDC2DA;
	Tue,  9 Jan 2024 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="AqUHd14a"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C480C129
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1704787763;
	bh=FchIJSYcoXmSXKuvjTeBCXHbsskDMujJezGO2se/G/E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=AqUHd14aJ5WmbYbdLQ6fcGk+t92r95ehoYC2G4h92TR1UOu8UqqEO6snrccosXnMc
	 P/32+85uBgnGQybcKWT6tq3//c8x0VEHwyabbX+K9db0oXLb+bX74E3y18AxmpW+FC
	 vZC1caT32fVGDPK2JxQDERHf068AukK2JZyK1EuA=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 767F666D42;
	Tue,  9 Jan 2024 03:09:22 -0500 (EST)
Message-ID: <4ee8067e72028b070d92e10fa33ddde3a498cb48.camel@xry111.site>
Subject: Re: undefined reference to `__aarch64_cas4_sync' error on arm64
 native build
From: Xi Ruoyao <xry111@xry111.site>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: richard clark <richard.xnu.clark@gmail.com>, Mark Rutland
 <mark.rutland@arm.com>, gcc-help@gcc.gnu.org, linux-kernel@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org
Date: Tue, 09 Jan 2024 16:09:20 +0800
In-Reply-To: <20240109074843.GI19790@gate.crashing.org>
References: 
	<CAJNi4rO+Dw5qYDtyJVbuo0OqAoXpGq_Qq6xjH9cvMCAUnW+77g@mail.gmail.com>
	 <CAJNi4rMHtM=39jzkzwqt++kVpSp0=XfDrVdY94WoW6B34oKwDA@mail.gmail.com>
	 <ZZb2f0U4qTWDjCGj@FVFF77S0Q05N.cambridge.arm.com>
	 <CAJNi4rOpzmQAW1Fjst-Em=SQ7q8QsQh0PWhVxUizrOW9JukOgQ@mail.gmail.com>
	 <ZZvS8rigFJR8L56c@FVFF77S0Q05N>
	 <fb6c8253fd90e66c036a85954c3299bc2c047473.camel@xry111.site>
	 <CAJNi4rPj0Wc7ByqrS-GVLUUEnOFPZi8A5nLLCEEJErqAe16EZw@mail.gmail.com>
	 <9aef98eed96ed32962ce90499291cb30ad5e3e14.camel@xry111.site>
	 <20240109074843.GI19790@gate.crashing.org>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-09 at 01:48 -0600, Segher Boessenkool wrote:
> On Tue, Jan 09, 2024 at 11:05:57AM +0800, Xi Ruoyao via Gcc-help wrote:
> > But the Linux kernel cannot use neither libc.so nor libgcc.a.
>=20
> I have built Linux using libgcc for many years.=C2=A0 It is as easy as
>=20
> +LIBGCC :=3D $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
> +libs-y +=3D $(LIBGCC)
>=20
> > (I know
> > some non-Linux kernel developers are overusing libgcc.a for kernels, bu=
t
> > IMO this is just wrong and Linux developers also do not do this.=C2=A0 =
If the
> > Linux kernel needs a symbol from libgcc the developers just provide
> > their own implementation.)
>=20
> Yes, and often they have fallen behind.=C2=A0 When they eventually catch =
up
> they usually just copy the GCC code anyway.
>=20
> Originally the only reasonable argument for not linking against libgcc
> was so kernel code would not accidentally use double-length divisions.
> There are other simple ways to have all uses of __divti3 and similar
> create link errors, so that is not really a good argument.
>=20
> libgcc is an essential part of the compiler.=C2=A0 For most targets, for =
most
> code, GCC will not generate function calls, there usually are faster (or
> smaller) things it can do, but it still is necessary to have libgcc for
> more uncommon things.=C2=A0 Using a partial copy of it, behind the times,
> and maybe even incompatible, is not a great idea.

But for many targets the kernel uses the soft-float ABI while the user
space uses the hard-float ABI and the linker generally refuses to link
them altogether.  You may argue that "hey, build all multilibs" but I'd
say it's stupid and it does not solve all issues:

If GCC is configured with things like --with-arch=3Dsomething, libgcc can
contain (FP/vector) instructions unsafe to use in kernel w/o special
handling.  Currently this issue is making the process very nasty to
build systemd-boot on LoongArch desktop distros where the toolchain
configured with vector extensions enabled by default.

If libgcc is so vital GCC needs to provide a way to make it work for a
set of compiler switches incompatible with any pre-built multilib.  For
example, installing the source of libgcc into /usr/lib/gcc and provide a
tool to build a libgcc.a with the specified options.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

