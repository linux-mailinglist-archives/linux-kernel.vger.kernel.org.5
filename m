Return-Path: <linux-kernel+bounces-20315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE86827D36
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BDF81F23C97
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D49228FD;
	Tue,  9 Jan 2024 03:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Pr273yck"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45436D6C8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 03:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1704769566;
	bh=nAI3rFx3y+TB10BtypgGa4eUrh60a2hStiF0/aVmKP0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Pr273yckmUFc4WTrc6kKuhF7qbxE69hZ7pfWvGH86c6Gpgp4jpDEiKLVkpkgoGrXf
	 GrZcbDu0rTiYZSrnNN+dOPHzggjo/ww7BoqnyDRN3wFS8SJlbEFXrKkCH3AJ0oxpZT
	 SE9iRgHfwXtxeU5RVD6lC73vfqIafh9Xr3qpJqN4=
Received: from [IPv6:240e:358:1102:4000:dc73:854d:832e:2] (unknown [IPv6:240e:358:1102:4000:dc73:854d:832e:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id C1D4366A05;
	Mon,  8 Jan 2024 22:06:02 -0500 (EST)
Message-ID: <9aef98eed96ed32962ce90499291cb30ad5e3e14.camel@xry111.site>
Subject: Re: undefined reference to `__aarch64_cas4_sync' error on arm64
 native build
From: Xi Ruoyao <xry111@xry111.site>
To: richard clark <richard.xnu.clark@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, gcc-help@gcc.gnu.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Tue, 09 Jan 2024 11:05:57 +0800
In-Reply-To: <CAJNi4rPj0Wc7ByqrS-GVLUUEnOFPZi8A5nLLCEEJErqAe16EZw@mail.gmail.com>
References: 
	<CAJNi4rO+Dw5qYDtyJVbuo0OqAoXpGq_Qq6xjH9cvMCAUnW+77g@mail.gmail.com>
	 <CAJNi4rMHtM=39jzkzwqt++kVpSp0=XfDrVdY94WoW6B34oKwDA@mail.gmail.com>
	 <ZZb2f0U4qTWDjCGj@FVFF77S0Q05N.cambridge.arm.com>
	 <CAJNi4rOpzmQAW1Fjst-Em=SQ7q8QsQh0PWhVxUizrOW9JukOgQ@mail.gmail.com>
	 <ZZvS8rigFJR8L56c@FVFF77S0Q05N>
	 <fb6c8253fd90e66c036a85954c3299bc2c047473.camel@xry111.site>
	 <CAJNi4rPj0Wc7ByqrS-GVLUUEnOFPZi8A5nLLCEEJErqAe16EZw@mail.gmail.com>
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

On Tue, 2024-01-09 at 10:55 +0800, richard clark wrote:
> On Mon, Jan 8, 2024 at 6:56=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wro=
te:
> >=20
> > On Mon, 2024-01-08 at 10:51 +0000, Mark Rutland via Gcc-help wrote:
> > > > AFAIK, the native build for the kernel will not link to the libc.so
> > > > but the userland application does, the builtin atomic primitives ar=
e
> > > > implemented in the glibc:
> > > > target-host $ objdump -t /lib/aarch64-linux-gnu/libc.so.6 | grep __=
aarch64_cas4
> > > > 0000000000130950 l=C2=A0=C2=A0=C2=A0=C2=A0 F .text 0000000000000034=
 __aarch64_cas4_relax
> > > > 0000000000130a10 l=C2=A0=C2=A0=C2=A0=C2=A0 F .text 0000000000000034=
 __aarch64_cas4_rel
> > > > 0000000000130990 l=C2=A0=C2=A0=C2=A0=C2=A0 F .text 0000000000000034=
 __aarch64_cas4_acq
> > > > seems the '__sync_val_compare_and_swap' used in the application wil=
l
> > > > be renamed to _aarch64_cas4_{relax, rel, acq}. so the kernel will
> > > > complain it will
> > > > link to an 'undefined reference'. But interesting, why the
> > > > cross-compile kernel will not generate the 'undefined reference', t=
he
> > > > cross-compile/build kernel will link to the glibc?
> > >=20
> > > This is due to a difference in default options between the two compil=
ers; the
> > > kernel isn't linked against libc in either case.
> >=20
> > And even if it's not the kernel but a normal application, it still
> > cannot use these functions from Glibc as the objdump output contains
> > "l", meaning these symbols are local symbols and they cannot referred
> > somewhere out of the libc.so.6 itself.
> Actually you can call those builtin atomic functions in you normal
> application without link time error, even execute the output binary in
> the target machine in case of cross-compile, only if the linked .so is
> in your target environment.

Because these functions are provided by libgcc.a:

xry111@defiant:~$ objdump -t /usr/lib/gcc/aarch64-unknown-linux-gnu/13.2.0/=
libgcc.a | grep cas
cas_1_1.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	0000000000000034 .hidden __aarch64_cas1_rela=
x
cas_2_1.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	0000000000000034 .hidden __aarch64_cas2_rela=
x
cas_4_1.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	0000000000000034 .hidden __aarch64_cas4_rela=
x
cas_8_1.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	0000000000000034 .hidden __aarch64_cas8_rela=
x
cas_16_1.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	000000000000003c .hidden __aarch64_cas16_rel=
ax
cas_1_2.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	0000000000000034 .hidden __aarch64_cas1_acq
cas_2_2.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	0000000000000034 .hidden __aarch64_cas2_acq
cas_4_2.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	0000000000000034 .hidden __aarch64_cas4_acq
cas_8_2.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	0000000000000034 .hidden __aarch64_cas8_acq
cas_16_2.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	000000000000003c .hidden __aarch64_cas16_acq
cas_1_3.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	0000000000000034 .hidden __aarch64_cas1_rel
cas_2_3.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	0000000000000034 .hidden __aarch64_cas2_rel
cas_4_3.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	0000000000000034 .hidden __aarch64_cas4_rel
cas_8_3.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	0000000000000034 .hidden __aarch64_cas8_rel
cas_16_3.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	000000000000003c .hidden __aarch64_cas16_rel
cas_1_4.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	0000000000000034 .hidden __aarch64_cas1_acq_=
rel
cas_2_4.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	0000000000000034 .hidden __aarch64_cas2_acq_=
rel
cas_4_4.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	0000000000000034 .hidden __aarch64_cas4_acq_=
rel
cas_8_4.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	0000000000000034 .hidden __aarch64_cas8_acq_=
rel
cas_16_4.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	000000000000003c .hidden __aarch64_cas16_acq=
_rel
cas_1_5.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	0000000000000038 .hidden __aarch64_cas1_sync
cas_2_5.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	0000000000000038 .hidden __aarch64_cas2_sync
cas_4_5.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	0000000000000038 .hidden __aarch64_cas4_sync
cas_8_5.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	0000000000000038 .hidden __aarch64_cas8_sync
cas_16_5.o:     file format elf64-littleaarch64
0000000000000000 g     F .text	0000000000000040 .hidden __aarch64_cas16_syn=
c

It seems libc.so.6 just get these functions from libgcc.a (a hidden
global symbol becomes local when you link it into a shared library).=20
But the Linux kernel cannot use neither libc.so nor libgcc.a.  (I know
some non-Linux kernel developers are overusing libgcc.a for kernels, but
IMO this is just wrong and Linux developers also do not do this.  If the
Linux kernel needs a symbol from libgcc the developers just provide
their own implementation.)
--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

