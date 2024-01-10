Return-Path: <linux-kernel+bounces-21710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4F4829319
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 05:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68ADB1C25440
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B89CA4E;
	Wed, 10 Jan 2024 04:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="h01b65df"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDA04C85;
	Wed, 10 Jan 2024 04:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704862202;
	bh=bY8Nz66h++CtVSG8p+P0BbueoIEyl9gmHpFlPmNUyI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h01b65dfAfwZoQuDd1XcBiTMb4ed03c4tfJC8ZuEu+txAmw/cBS/WtwBqCm3b0/v1
	 kSzZvUW3D9pSEGUXk9/yo0J8OJ585K9CjA5Za3wnGzcDUOzPVq1JQTorGFmDvuOipl
	 /mRIOdDNU+babcW+Laui0Eyp92/6v1fO/qQdy3aUtXfLFPpYl+oIvlWKRW77UCGZfv
	 mIgNHbfuNYp/3jUyqBfQlipgpnMdo07rNmrsdMywxlTCGztrtnni9iR7DIwf2GCx2X
	 QPGE1RJqWp5DygRUgdh+MdfJJl9GCEZzBsFvaVMMNBijUOB16lOvmoJJpoNJddlBhZ
	 S7yFonZ/i6UmA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T8wMX5cyyz4wbv;
	Wed, 10 Jan 2024 15:50:00 +1100 (AEDT)
Date: Wed, 10 Jan 2024 15:49:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paul Moore <paul@paul-moore.com>, Casey Schaufler
 <casey@schaufler-ca.com>, Kees Cook <keescook@chromium.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: linux-next: manual merge of the security tree with the block
 tree
Message-ID: <20240110154959.77a213e3@canb.auug.org.au>
In-Reply-To: <20231204120314.5718b5f6@canb.auug.org.au>
References: <20231204120314.5718b5f6@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MrBfATJrWuRNk8vHIsgNGWb";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/MrBfATJrWuRNk8vHIsgNGWb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 4 Dec 2023 12:03:14 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Today's linux-next merge of the security tree got conflicts in:
>=20
>   security/selinux/hooks.c
>   security/smack/smack_lsm.c
>=20
> between commit:
>=20
>   bf18dde00aa9 ("io_uring: split out cmd api into a separate header")
>=20
> from the block tree and commit:
>=20
>   f3b8788cde61 ("LSM: Identify modules by more than name")
>=20
> from the security tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc security/selinux/hooks.c
> index 17ec5e109aec,b340425ccfae..000000000000
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@@ -91,7 -91,8 +91,8 @@@
>   #include <uapi/linux/mount.h>
>   #include <linux/fsnotify.h>
>   #include <linux/fanotify.h>
>  -#include <linux/io_uring.h>
>  +#include <linux/io_uring/cmd.h>
> + #include <uapi/linux/lsm.h>
>  =20
>   #include "avc.h"
>   #include "objsec.h"
> diff --cc security/smack/smack_lsm.c
> index 2cdaa46088a0,53336d7daa93..000000000000
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@@ -42,7 -42,8 +42,8 @@@
>   #include <linux/fs_context.h>
>   #include <linux/fs_parser.h>
>   #include <linux/watch_queue.h>
>  -#include <linux/io_uring.h>
>  +#include <linux/io_uring/cmd.h>
> + #include <uapi/linux/lsm.h>
>   #include "smack.h"
>  =20
>   #define TRANS_TRUE	"TRUE"

This is now a conflict between the block tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/MrBfATJrWuRNk8vHIsgNGWb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWeIfcACgkQAVBC80lX
0GwTugf+JwgcOvZOQ4Yek+gvDwBKgVjbg5YIHMDW0CoVvu3yMJT1Bb+7p/9Yx5cA
I31lfoHPNF9QWZ4anEgndTZv8HbH4RUiI5Ym4rXIy8K1xrstjmshJJIoxLM37XK6
eWUaU3jt4CHpglr0FzkBAb9y+qx8axtEwmmnIZYEaiz+I/Q49JIIen5dtneaqxjM
GjPcWZGPk6heoIDXf+2vXHaCPLWJ/X3qg6EVaC9kD80wRTbGWZAkXfv28LL3S9tm
vCrQ4GT/XRhtUKAUYSmAWVv0HFxfFI91cf1qDooRBP11vr9oI6KkBMB3fq7YV/7d
OSvXGCdzglqY//zap+GHAdgcNPHK3A==
=p9vR
-----END PGP SIGNATURE-----

--Sig_/MrBfATJrWuRNk8vHIsgNGWb--

