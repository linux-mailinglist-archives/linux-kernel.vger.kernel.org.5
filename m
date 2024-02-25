Return-Path: <linux-kernel+bounces-79924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E12E28628C2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A72281F94
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 01:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD2646AB;
	Sun, 25 Feb 2024 01:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UnXDsXWH"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A3C1361;
	Sun, 25 Feb 2024 01:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708826306; cv=none; b=lj/Sbgp7IZ4MpyluNv2e6xHR12CMUoeUNTcXyhK/4xr3Ar62Zh5XRGG2DjfHk7pH48ln6oHcifC2ZOxQKB/bjCzPDv1vhxPFH9kl5WBXaiZ7+DaAayQzAQtqGInK6usArKFH4LvHRcTcgl+jqwZcZKMmiW7+wl4CMcrXxlx6oPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708826306; c=relaxed/simple;
	bh=PaibG9Kr5hC/Yxh0f0Wtfyu/0mfRBH2bYljJy5nD5kI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ps+sXkXKTl8Z28QtQGsSNq3sGbOEnXVJTV3F6KiBSLBRb9Tmt3fGbva2jCdyfy34zaH3IxOjpQWRod2QKh0K7sAFZP/XdxcR5iQ8a0xEo+mUdRte/KRbMC0o+nbKymECOIeQ/5GaONG8koarOihQ1wb95/ql5QGjRGCROqkLH50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=UnXDsXWH; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708826299;
	bh=fUsB35Fy9mjfHzF1qnj45WCCbKBxbtbf0PIHDIzX2Yw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UnXDsXWHYebm4UfzuaFBVg4MaVNJRroOMGf06W42waax3RAxdPCtfl8uAG2zKRi0p
	 8fSp4OLVW5YnfLLFy50FHDYkaxa5oI9BtStlZ6UVods2ox23rIcFGWonLidTGI3kyj
	 tvRq96PPHsKRC7qzlySMR+CYMv65y9SNxCmA2DKgj4p350il12cAcNiZKzvs+pjTr1
	 uCdT+Cp78it6roCix3O3q7FUHDzHLeJulZ05O4hAgG6Gzbn6yNFYT+NFrqDYu+LD1i
	 TCVuq6kehZsyUvO9Rg5ugISomNPWqXem8exf/VAE3MxScDFBbYIGpcLOnaQWJONhdB
	 MPVaGh8splDnQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tj6NC00Lgz4wc1;
	Sun, 25 Feb 2024 12:58:18 +1100 (AEDT)
Date: Sun, 25 Feb 2024 12:58:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the gpio-brgl tree
Message-ID: <20240225125815.2704bb3d@canb.auug.org.au>
In-Reply-To: <CACMJSevZxCiqa8uz+XU36psCa5T_rQGi5tVkMejpZj22Bj1k3Q@mail.gmail.com>
References: <20240223143309.5ec298ec@canb.auug.org.au>
 <CACMJSevZxCiqa8uz+XU36psCa5T_rQGi5tVkMejpZj22Bj1k3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HaJtlbJjYxY0BnlCQBHfFfv";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/HaJtlbJjYxY0BnlCQBHfFfv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bartosz,

On Fri, 23 Feb 2024 08:51:10 +0100 Bartosz Golaszewski <bartosz.golaszewski=
@linaro.org> wrote:
>
> On Fri, 23 Feb 2024 at 04:33, Stephen Rothwell <sfr@canb.auug.org.au> wro=
te:
> >
> > After merging the gpio-brgl tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > x86_64-linux-gnu-ld: vmlinux.o: in function `bgpio_write64':
> > gpio-mmio.c:(.text+0x1489427): undefined reference to `iowrite64'
> > x86_64-linux-gnu-ld: vmlinux.o: in function `bgpio_read64':
> > gpio-mmio.c:(.text+0x14894a0): undefined reference to `ioread64'
> > x86_64-linux-gnu-ld: vmlinux.o: in function `bgpio_write64be':
> > gpio-mmio.c:(.text+0x1489527): undefined reference to `iowrite64be'
> > x86_64-linux-gnu-ld: vmlinux.o: in function `bgpio_read64be':
> > gpio-mmio.c:(.text+0x14895a0): undefined reference to `ioread64be'
> >
> > Caused by commit
> >
> >   36e44186e0ba ("gpio: mmio: Support 64-bit BE access")
>=20
> I'm not seeing this issue with allmodconfig on x86_64, could you give
> me some more information on the build environment?

These builds are cross builds using Debian's cross compilers on a ppc64le h=
ost.

$ x86_64-linux-gnu-gcc --version
x86_64-linux-gnu-gcc (Debian 13.2.0-7) 13.2.0
$ x86_64-linux-gnu-ld --version
GNU ld (GNU Binutils for Debian) 2.41

--=20
Cheers,
Stephen Rothwell

--Sig_/HaJtlbJjYxY0BnlCQBHfFfv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXanrcACgkQAVBC80lX
0Gzhlwf+NRN66KQYhF+qUDdFcZJ/DobDc0wFrdvlKcn2PPC7D+EjL7/1H2u0Y7Rl
4Z82T4RGuPMnq77trPQXgIG2RYOjUXO2RZvgvXUHl4SM3OE4Sw5hDfIzuaLXJpdS
kWASpkIo7ohEYcz8f0tOxBIj5JC1BjL6+dsWDZaTTaSHfsB33/aaF1i6HU9pXfEz
wDVHhvEQkskf3hKOq0YIfWErQ8foBl7TdV2RcQmt68JvrXU6w18s2soMyRD+F8cF
Co1/bo+4gzBd5wG76p2QULEdGWDnPbkv2HksyopkQdU2Gho721m9wTvHszwid8x6
QIZlwtUEpQRFeXi/4sHEKp8DPI4QEg==
=HBAq
-----END PGP SIGNATURE-----

--Sig_/HaJtlbJjYxY0BnlCQBHfFfv--

