Return-Path: <linux-kernel+bounces-19361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD57826BE8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881091F223F9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDE214005;
	Mon,  8 Jan 2024 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="iS/ylMPr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D523F13FEE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1704711386;
	bh=Wsw4VxPsaW9bnZCq+PzKzCKdeWEwZLad9rpv9ZWX5iY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iS/ylMPrguoVUcbjljHhfQUC5GBHTmGgdq4kek68sCysVen5Z6sUUr+GJgSyw3DhW
	 ckiePu64UYmWpU43czVDpBUfXs447DXfdHh00EGPAAX1qmRHeCg6EIfVnuTvassgVy
	 sGjR3+tAuo1aehRJiNxaeMwEoJY3LyadsS94YiK8=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 58CEC66B4F;
	Mon,  8 Jan 2024 05:56:25 -0500 (EST)
Message-ID: <fb6c8253fd90e66c036a85954c3299bc2c047473.camel@xry111.site>
Subject: Re: undefined reference to `__aarch64_cas4_sync' error on arm64
 native build
From: Xi Ruoyao <xry111@xry111.site>
To: Mark Rutland <mark.rutland@arm.com>, richard clark
	 <richard.xnu.clark@gmail.com>
Cc: gcc-help@gcc.gnu.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Date: Mon, 08 Jan 2024 18:56:23 +0800
In-Reply-To: <ZZvS8rigFJR8L56c@FVFF77S0Q05N>
References: 
	<CAJNi4rO+Dw5qYDtyJVbuo0OqAoXpGq_Qq6xjH9cvMCAUnW+77g@mail.gmail.com>
	 <CAJNi4rMHtM=39jzkzwqt++kVpSp0=XfDrVdY94WoW6B34oKwDA@mail.gmail.com>
	 <ZZb2f0U4qTWDjCGj@FVFF77S0Q05N.cambridge.arm.com>
	 <CAJNi4rOpzmQAW1Fjst-Em=SQ7q8QsQh0PWhVxUizrOW9JukOgQ@mail.gmail.com>
	 <ZZvS8rigFJR8L56c@FVFF77S0Q05N>
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

On Mon, 2024-01-08 at 10:51 +0000, Mark Rutland via Gcc-help wrote:
> > AFAIK, the native build for the kernel will not link to the libc.so
> > but the userland application does, the builtin atomic primitives are
> > implemented in the glibc:
> > target-host $ objdump -t /lib/aarch64-linux-gnu/libc.so.6 | grep __aarc=
h64_cas4
> > 0000000000130950 l=C2=A0=C2=A0=C2=A0=C2=A0 F .text 0000000000000034 __a=
arch64_cas4_relax
> > 0000000000130a10 l=C2=A0=C2=A0=C2=A0=C2=A0 F .text 0000000000000034 __a=
arch64_cas4_rel
> > 0000000000130990 l=C2=A0=C2=A0=C2=A0=C2=A0 F .text 0000000000000034 __a=
arch64_cas4_acq
> > seems the '__sync_val_compare_and_swap' used in the application will
> > be renamed to _aarch64_cas4_{relax, rel, acq}. so the kernel will
> > complain it will
> > link to an 'undefined reference'. But interesting, why the
> > cross-compile kernel will not generate the 'undefined reference', the
> > cross-compile/build kernel will link to the glibc?
>=20
> This is due to a difference in default options between the two compilers;=
 the
> kernel isn't linked against libc in either case.

And even if it's not the kernel but a normal application, it still
cannot use these functions from Glibc as the objdump output contains
"l", meaning these symbols are local symbols and they cannot referred
somewhere out of the libc.so.6 itself.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

