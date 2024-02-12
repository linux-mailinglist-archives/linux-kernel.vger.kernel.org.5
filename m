Return-Path: <linux-kernel+bounces-61085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73814850D10
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 04:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FCD1C22C20
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 03:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDEC5396;
	Mon, 12 Feb 2024 03:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TwpblbA8"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81512F5B;
	Mon, 12 Feb 2024 03:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707709719; cv=none; b=kqUpvUwNf+sTFtbSg0rjtt4YSbymi7Q3h0tABYDHUSp/AwWulsCg+CNLKS0EtV7c0lzJQIuGFUoNTNmQ4cCEv/foGLIJpJvCdMVjxvde8SpNQ3KjymMQtkUen5zoQB+zxlPeyTWAtxAKBAenAhqIRkGWTYrNGri+R5xzYMrfBz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707709719; c=relaxed/simple;
	bh=as8IecGkueqqTRd7u35i6+vqXMLbLExinEbk18NNGHA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hl4GSVuhgR1UOjODUyJVNJPPE8bwmAtD/chWZ8yqEQ4LUeEJgYhQLPMxhnGvb1JQtT0MdKnxKF0uLECC0tcv/Sn6bxhBqogO7w8ZzR2CUWewM5ixApyfBtgyVl0/iJVFZcQFz7Dpxzzb7nWYBtzzvkYg0xIdijlQ+djy2if8q5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=TwpblbA8; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707709713;
	bh=SuSpmcJvpGTOavncXMjxau9QdPgYU4bhbiLgzCMtzSE=;
	h=Date:From:To:Cc:Subject:From;
	b=TwpblbA8VE3GRU5eoWlXxlMFWE7YxDFI0RFg9hovSJZ3h8AA611lJM+zife2NTALy
	 Q9BX5htyPGumAcSB1S0LGxRMYtGOShJDSxr0/c53Bhei62Dkf0q5fP27wYLwn6LAMa
	 6G/mM/5ZR7Mzsu9MKjFfHCiln0X9vhJwk07O1333yQBLvsANgaQsK4LNK2UCZTcf0u
	 tQH3/WyqIEgXNQXatKHjTCGrAg06uwmdyqgVsHjUSlCDwTiK6UyQrlpH3+rXD9OnIv
	 9runiG2EWcbhx33gfen2s1VxQa85bN07rykDMsaV0yHftDIvP/aQdmUpRtgxwASfxl
	 qh+NeLnQxHQ8w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TY9RN3z2Gz4wyY;
	Mon, 12 Feb 2024 14:48:32 +1100 (AEDT)
Date: Mon, 12 Feb 2024 14:48:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Damian Muszynski <damian.muszynski@intel.com>, Mun Chun Yep
 <mun.chun.yep@intel.com>, Linux Crypto List <linux-crypto@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the crypto tree
Message-ID: <20240212144830.70495d07@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MkTVF9wda+qi=PxrETxCpgB";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/MkTVF9wda+qi=PxrETxCpgB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the crypto tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/ABI/testing/sysfs-driver-qat:146: ERROR: Unexpected indentati=
on.
Documentation/ABI/testing/sysfs-driver-qat:146: WARNING: Block quote ends w=
ithout a blank line; unexpected unindent.

Introduced by commit

  f5419a4239af ("crypto: qat - add auto reset on error")

--=20
Cheers,
Stephen Rothwell

--Sig_/MkTVF9wda+qi=PxrETxCpgB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXJlQ4ACgkQAVBC80lX
0GyvHAf+OBvJS8F3CYDv2RV9u9FQJu8Ljd4D6mqJbXb6Uv0IhwYKhXqrdJRFRwYm
QC4/7cZEC0H7nzGoo5LrEriwkTucIBECtH3Bzh8wtIin+4Zjoo1J/JyED6yyAtLB
FS1cZ7khELxRZGhjMb/+hC7t7dZvbFQKYHdbvnAqHH5l5Lhpsm0IZMTH6ONK5Gjp
IjrX1IAN+FblJPsqtUCDZ5cZulW0IC9nA7mH1duq6eCF8qMAD5ZMHvelGzfTqQ6D
fbxtRIJDOpXY59u9nF98ajim5hTYCp0H7V1/0aGXRIhT+tcRJLf0IMrDEU7oRqID
TInPVeP09O1GrFDvzaee5XvqmAZ17g==
=Cc0H
-----END PGP SIGNATURE-----

--Sig_/MkTVF9wda+qi=PxrETxCpgB--

