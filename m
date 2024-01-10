Return-Path: <linux-kernel+bounces-21743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8248293A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1EE289EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF125381B9;
	Wed, 10 Jan 2024 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="glU8JGZk"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C08E36B0E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704867461;
	bh=qYh5wpJiXZnUBUYx2ZyfhZxWNL/O7ncG94xfRZ2XNIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=glU8JGZkJ5bG5nqCuvsh9q8vDvhPfZ5dQGDMcJmz7YL4uWh89R8UTIKLu/M6bXFmW
	 H0KKi1RyP6ZDTbwmZNEv2S69wyBZfB/YdH/5Xl98fGDH8GZzB59tg0t57iIJ2JBFd9
	 xQMxCD5c1dP3cHCdVoE+8S9oPWHNicseDrQILfjc992NJb7ZAkUwQDQZTQr3ogPsIZ
	 yqY0M9da8fr0U2/Z692pqzGCH2dkU9911WmYfvQv8MJp8/MuGdjVlu6uGySZhxMFOS
	 rtF6K8p2yyHK5Gbb/FYoCmPECccgS/cZNuOj/gwQ0h0q008owozs5RfGe7fRUNkPUz
	 7Zyl48qgiDXYA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T8yJh0vsRz4wyV;
	Wed, 10 Jan 2024 17:17:40 +1100 (AEDT)
Date: Wed, 10 Jan 2024 17:17:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, David Laight
 <David.Laight@aculab.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH next v4 0/5] minmax: Relax type checks in min() and
 max().
Message-ID: <20240110171739.2e2d9de0@canb.auug.org.au>
In-Reply-To: <CAHk-=whkGHOmpM_1kNgzX1UDAs10+UuALcpeEWN29EE0m-my=w@mail.gmail.com>
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
	<18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com>
	<CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
	<CAHk-=wjE1eLMtkKqTt0XqNSnKAeDagV=WQU+vxHL_wsLuO8Gag@mail.gmail.com>
	<CAHk-=whkGHOmpM_1kNgzX1UDAs10+UuALcpeEWN29EE0m-my=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sVEyn6GBpFp8mnS2luN0wZD";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/sVEyn6GBpFp8mnS2luN0wZD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Mon, 8 Jan 2024 13:11:12 -0800 Linus Torvalds <torvalds@linux-foundation=
org> wrote:
>
> Whee.

Yeah.

> On my machine, that patch makes an "allmodconfig" build go from
>=20
>     10:41 elapsed
>=20
> to
>=20
>      8:46 elapsed
>=20
> so that min/max type checking is almost 20% of the build time.
>=20
> Yeah, I think we need to get rid of it.
>=20
> Can somebody else confirm similar time differences? Or is it just me?

I was hopeful, but:

no patch:

$ /usr/bin/time make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-linux-gnu- -j140 =
-O -s
102460.07user 3710.56system 13:29.05elapsed 13122%CPU (0avgtext+0avgdata 40=
23168maxresident)k
304inputs+7917056outputs (1998673major+120730959minor)pagefaults 0swaps

with patch:

$ /usr/bin/time make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-linux-gnu- -j140 =
-O -s
99775.75user 3684.45system 13:12.89elapsed 13048%CPU (0avgtext+0avgdata 221=
7536maxresident)k
64inputs+7890304outputs (2104371major+119837267minor)pagefaults 0swaps

$ x86_64-linux-gnu-gcc --version
x86_64-linux-gnu-gcc (Debian 13.2.0-7) 13.2.0
$ lscpu
Architecture:           ppc64le
  Byte Order:           Little Endian
CPU(s):                 160
  On-line CPU(s) list:  0-159
Model name:             POWER9, altivec supported
  Model:                2.2 (pvr 004e 1202)
  Thread(s) per core:   4
  Core(s) per socket:   20
  Socket(s):            2

--=20
Cheers,
Stephen Rothwell

--Sig_/sVEyn6GBpFp8mnS2luN0wZD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWeNoMACgkQAVBC80lX
0Gx1gAf/WvJnt+XMZHfSDNE+fN03lD7iS4hKP2mnZqmFPqGZnv47jkk21v9M5HxO
o5fcIv9C+A9tbC5JNswBnZbQB8Pi4TINzUhOUIDCp772jJrqTcWHh+vV9IxF9/Hc
Xdsa7aWn5r5B4j5w9Yj4DiiX2TkxNsTIpMWoz2TCmYIkvvdSagk9zbijhi96fk8c
bRnY0kHb5nzPgWamZkiu7zMcbm7mKhwfpfaKrMm6xTiqpAT9rY42lqS+Ub/8B4sm
cPe8VRHkxHt/H5fr7BxrwgpQV97jYq7BR6Bjtx3Gbu1OCAxb7ijW8SeR0stBdCjp
7CmWwo/uMD1QQ9Dw5ZB/olC9MnLW7A==
=Xh+i
-----END PGP SIGNATURE-----

--Sig_/sVEyn6GBpFp8mnS2luN0wZD--

