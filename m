Return-Path: <linux-kernel+bounces-24245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC1C82B9B4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3634BB23716
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130D215C6;
	Fri, 12 Jan 2024 02:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NkZHiGgo"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035681118;
	Fri, 12 Jan 2024 02:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705027585;
	bh=KzTy9q41J+Iz61mM8YvhQ8+Vz6G42mnYqSFsJShOuN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NkZHiGgoSR7guJRAt+YOwPSHIZ6rN3xqHulVZsTyRy8nZ3H40yLiLGe11v8Mygxh4
	 M3XGFuiUnVMS1wfQDxwKwAUEbDlOEcYxjhu90Uhw3EgX7oZa6e7CBTwBHsVN3VveoA
	 j3yU6Qf83WLGKlKgyr1NKVRf88Jh/a+K8U44kamy1vNOWHx070EzTmZ6ogeJYZSRKK
	 sQIzIrSczY8TPzPBL91uojbOilesRU7fig98xyuybIeAUUpib0qWkWHjqmC5LLZP3a
	 2OuSEb3cXIxhr+TQ0eMr2GhhwHPGv6phMDY2DWRhxX1Ks/YTv1rKLXSR3EKSj0l4zf
	 Zv+pa5qgAjqiA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TB5X04LnGz4x5h;
	Fri, 12 Jan 2024 13:46:24 +1100 (AEDT)
Date: Fri, 12 Jan 2024 13:46:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Dan Carpenter" <dan.carpenter@linaro.org>, "Naresh Kamboju"
 <naresh.kamboju@linaro.org>, "Uladzislau Rezki" <urezki@gmail.com>,
 linux-next <linux-next@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, "Linux Regressions"
 <regressions@lists.linux.dev>, clang-built-linux <llvm@lists.linux.dev>,
 lkft-triage@lists.linaro.org, "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: mm/vmalloc.c:4691:25: error: variable 'addr' is uninitialized
 when used here [-Werror,-Wuninitialized]
Message-ID: <20240112134556.1c73c072@oak>
In-Reply-To: <bb175a67-462b-41a7-804a-ec990291a00e@app.fastmail.com>
References: <CA+G9fYvDNksfKNvtfERaBa9t2MJNucfD_s3LgKGw_z2otW+nyw@mail.gmail.com>
	<628bf675-77fc-4ccc-be2f-9c3ec8a7b0b8@moroto.mountain>
	<908325ed-08af-4b0c-926e-da9afba25772@app.fastmail.com>
	<bb175a67-462b-41a7-804a-ec990291a00e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FXcs1LWAtjjuljVrt8TKt6X";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/FXcs1LWAtjjuljVrt8TKt6X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 11 Jan 2024 17:37:12 +0100 "Arnd Bergmann" <arnd@arndb.de> wrote:
>
> On Thu, Jan 11, 2024, at 13:55, Arnd Bergmann wrote:
> > On Thu, Jan 11, 2024, at 12:16, Dan Carpenter wrote: =20
> >> On Thu, Jan 11, 2024 at 04:23:09PM +0530, Naresh Kamboju wrote: =20
> >>> Following build failures noticed on i386 and x86 with clang builds on=
 the
> >>> Linux next-20240111 tag.
> >>>=20
> >>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >>>=20
> >>> Build error:
> >>> ----------
> >>> mm/vmalloc.c:4691:25: error: variable 'addr' is uninitialized when
> >>> used here [-Werror,-Wuninitialized]
> >>>  4691 |                 va =3D __find_vmap_area(addr, &vn->busy.root);
> >>>       |                                       ^~~~
> >>> mm/vmalloc.c:4684:20: note: initialize the variable 'addr' to silence
> >>> this warning
> >>>  4684 |         unsigned long addr;
> >>>       |                           ^
> >>>       |                            =3D 0
> >>> 1 error generated. =20
> >>
> >> We turned off uninitialized variable warnings for GCC a long time ago.=
.
> >> :/ I don't know if we'll be able to re-enable it in a -Werror world
> >> although Clang seems to be managing alright so perhaps there is hope. =
=20
> >
> > The problem with gcc's warning is that it is non-deterministic and
> > in recent versions actually got more false-positives even without
> > -Os or -fsanitize=3D. Clang does not catch all that gcc does because
> > it doesn't track state across inline functions, but at least its
> > output is always the same regardless of optimization and other
> > options.
> >
> > At least this particular one is an obvious bug and easily gets
> > caught by lkft and lkp even if gcc's -Wuninitilized doesn't
> > flag it. =20
>=20
> As it turns out, gcc did find this one in the default -Wuninitialized
> regardless of -Wmaybe-uninitialized:
>=20
> mm/vmalloc.c: In function 'vmalloc_dump_obj':
> mm/vmalloc.c:4691:22: error: 'addr' is used uninitialized [-Werror=3Dunin=
itialized]
>  4691 |                 va =3D __find_vmap_area(addr, &vn->busy.root);
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/vmalloc.c:4684:23: note: 'addr' was declared here
>  4684 |         unsigned long addr;
>       |                       ^~~~
>=20
> and I see that Uladzislau Rezki already sent a fix, which
> is the same that I tried out in my randconfig tree:
> https://lore.kernel.org/lkml/ZaARXdbigD1hWuOS@pc638.lan/

I have applied that to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/FXcs1LWAtjjuljVrt8TKt6X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWgp/4ACgkQAVBC80lX
0GyUgQf7BqMWgH6cRs1tGNAs4BKWtftlLyJyZxCjYclzY9kjUIECSS6YKmZqH13Q
XPy97i7GodFZJWaOwgf0RGtGB45wBjK/odZHpxLGmPVddDW3Lw4b+hoz/VnPzUyx
3UcHxWZrX2sjM7MHASXOmNlRvTr7BYVDTUFIojzdOFpELAaDHgIp+25i3NT/s7b9
xuE4cywwHA7i49iKZHBCPahxT9wcIaREwKMcClWM824G0oTEZ9hFjkTlOUy7EGfV
vxgUIvc4KBRGUXq+ghdfru/SDnFXSjVxQzBF/Y/+u6CbLJpXsl4/zAmHH01c39q4
Tf4CfWS8RbJHiEfFwPeSAw5ayu+f/w==
=YCNG
-----END PGP SIGNATURE-----

--Sig_/FXcs1LWAtjjuljVrt8TKt6X--

