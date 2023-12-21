Return-Path: <linux-kernel+bounces-9083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A20C81C028
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D580B22353
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AAB76DC9;
	Thu, 21 Dec 2023 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="M9XGQtdk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E2476DB9;
	Thu, 21 Dec 2023 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703194271;
	bh=ft4wAYJNZc64ustw1MM9M+sqkVJMTPVGdpLNQxrlu7U=;
	h=Date:From:To:Cc:Subject:From;
	b=M9XGQtdkzAFHz7tQo41o8mQUdMyZ7fN5i7KlX0rqq1NfBTXw3+FkV9K9dGvRL9VTU
	 oYhoMpF7X1S2nWsd3ZYmfGX2YwMOjlw1GZrYjVa8/Ql2noeayhAtaX9Djxgw44O6rQ
	 EPkyfo9cL6h1H7ksL3NzH+sjixjT0H5RzIWSnk1JlBDCiPXuo3/PkrxZ8TuR427IjT
	 eTWRip3G4THFeagEocUScyGpBHeorbGvY76fZagNf2imJAtl7isAWkwaxqmfE1u0M1
	 REJO8luOO7cJRJODmhv7X4gVZU+g8tszs6Zto1/3w9zoIesLIsoZVuwEUhsgNiKnSV
	 OJ/nDiU8fFf0Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sx3Wz5Fyzz4xQj;
	Fri, 22 Dec 2023 08:31:11 +1100 (AEDT)
Date: Fri, 22 Dec 2023 08:31:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Howells <dhowells@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the afs tree
Message-ID: <20231222083110.13925645@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.5M6eiP62SmnNJP9LSgn2kn";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/.5M6eiP62SmnNJP9LSgn2kn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  5c715e8a85f2 ("afs: Fix use-after-free due to get/remove race in volume t=
ree")

This is commit

  9a6b294ab496 ("afs: Fix use-after-free due to get/remove race in volume t=
ree")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/.5M6eiP62SmnNJP9LSgn2kn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWErp4ACgkQAVBC80lX
0Gxxqwf/QYoYFGMZUGCv9vYeLtFtnnoXkkyQ6ctv6qgnyjtG3NGIvRd/E8LSUK32
nUP/y5d7rn90R9e4VCsa+S7RjVR71vFuNqZr9ASBCOPXOjK72kf379AirN7N7fyV
8wwV/HkzYo3eEV8Rxv3+gcNoI4nlBh07e/jJmeSNDIx4iwSnp2u2k6enkapk7YJd
pxzxxOX/ZJrXJb8FT8GP+J+fxKN2kkKqS7PdeDkG45L9Ql1nD54vDy8H5/GfaF8I
TMCR9+FyDd6YX4XrRKtb8sM3nYUylNDYPN8mAirzLtgMZ48c2DRqqwB2+fyooxe3
zmP3sM/qsPNPrAVJl5vnZaP9Rz8OPA==
=7ycK
-----END PGP SIGNATURE-----

--Sig_/.5M6eiP62SmnNJP9LSgn2kn--

