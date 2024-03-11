Return-Path: <linux-kernel+bounces-99578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 433A3878A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34241281923
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A5F56B99;
	Mon, 11 Mar 2024 21:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fJtL0kAs"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D38954FA3;
	Mon, 11 Mar 2024 21:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710193987; cv=none; b=RanAtnm4ugL0aoFDFuYZMtp8SATveqRiSjazot8nL6UIXTl9WB/+Qp0i2+/skNdwU5rGA0tXy21aEipSEus+iR02V96zturuTDBlcThP4kix9WGaBn4BYtTcf05UI9e5TvIu0MrD9pmvsRQtfZmfmNtekChzukCQc1L0JoKEebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710193987; c=relaxed/simple;
	bh=TEbZeeq0clAFzFr8sJBQjy0R1YDwtydGn/bR0N7ihtk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYkKMEkOTEvgd8tJWmwfW7ISKSks8a6ndfV8tSQUc+tA5/nJ2E7Xz2Y+A7dx0cm20vYNccya2jhEPuunfwKA0AIQvN5XDDnOCqf44ukOT9qk4Kioa3gJvhaScyBvz7snOA88HrhWZP2gVKvIUFubLt+Y+nFk88NBF3JhsnE2wvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=fJtL0kAs; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710193982;
	bh=vaJGZhR9qPd/L0aYICX0fyHav/PoQko1EdlrEY0dVpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fJtL0kAsCqmQzFsOkFdhiriv4UBCPTio2mIlr9O0BiqAth/wsGzYIczIzCIqIOBhF
	 TIO42VPbqH6u+bDb6L5bZi9FybuJ9gPKCcB5EsLw1IsvTjUD1zfoCI8wqrASiWPk7A
	 Cxc3LBFcegZ/acXGGNptlB1mPu/rSVqBc7YzxbLPNzWPfdK/PsCL79IS09sNznCzix
	 JeAXgD2tS+R1X7CX81udm97de/BW5E59KBHYK3KMMDHkGjjWFhT1UiLLWuUq4lCTIX
	 NYwZSyB34lJqhlEzbcnWHZLdX52mSWCAQW12swdaeZb5XD3azNs85ilmgw0iOUAy9v
	 pCx0qumFKSmnw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ttr9p23S1z4wyy;
	Tue, 12 Mar 2024 08:53:02 +1100 (AEDT)
Date: Tue, 12 Mar 2024 08:53:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: linux-next: manual merge of the rust tree with the mm tree
Message-ID: <20240312085301.66009b5f@canb.auug.org.au>
In-Reply-To: <20240129133352.25a3ee19@canb.auug.org.au>
References: <20240129133352.25a3ee19@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0EeIemxenT6BELO.q6Mw7g5";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/0EeIemxenT6BELO.q6Mw7g5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 29 Jan 2024 13:33:52 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the rust tree got a conflict in:
>=20
>   Documentation/process/changes.rst
>=20
> between commit:
>=20
>   3d21fad38152 ("kbuild: raise the minimum supported version of LLVM to 1=
3.0.1")
>=20
> from the mm-non-mm-unstable branch of the mm tree and commit:
>=20
>   c5fed8ce6549 ("rust: upgrade to Rust 1.75.0")
>=20
> from the rust tree.
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
> diff --cc Documentation/process/changes.rst
> index d7306b8cad13,eab7e2f8c196..000000000000
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@@ -30,8 -30,8 +30,8 @@@ you probably needn't concern yourself w
>           Program        Minimal version       Command to check the versi=
on
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>   GNU C                  5.1              gcc --version
>  -Clang/LLVM (optional)  11.0.0           clang --version
>  +Clang/LLVM (optional)  13.0.1           clang --version
> - Rust (optional)        1.74.1           rustc --version
> + Rust (optional)        1.75.0           rustc --version
>   bindgen (optional)     0.65.1           bindgen --version
>   GNU make               3.82             make --version
>   bash                   4.2              bash --version

This is now a conflict between the mm-nonmm-stable tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/0EeIemxenT6BELO.q6Mw7g5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXvfT0ACgkQAVBC80lX
0Gyc/Qf+MrjrfMBCrce+EE0iuAjie/dz822tB9IcGEYvQXbIiwRH9pyehHvT2Gyv
Em7z04I9vVZFaVLyAeYwPRMcjdTpYt/yXnnSkrs1MYVxvm23yEfM6k7Ge6cqPMLK
77Po/q3shq7Sp+y+Ekv1VR2EMQLMjdEBXZcGAeI8Bo4dCtNLN4uedVQUSVsnn0aQ
XVsXTIkbmNvBdTVoq1XI/D9BultgY+Z2yfCg6JRjeX9TeriWSMYOP1hEuYcX4+Ep
J+OWYKRMWV+lxlTrAD37bYFMhXaLSJKEVQ2ffATev2IDxTWpDv71EUvjYVrlBXd3
HDx1j0oHRxnqYnXZFAR4R+qvaBHb9g==
=RmQv
-----END PGP SIGNATURE-----

--Sig_/0EeIemxenT6BELO.q6Mw7g5--

