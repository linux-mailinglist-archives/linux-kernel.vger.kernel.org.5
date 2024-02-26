Return-Path: <linux-kernel+bounces-80574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A438669C8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F48CB2154D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282B51B978;
	Mon, 26 Feb 2024 05:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DZRlDEiZ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A85171BB;
	Mon, 26 Feb 2024 05:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708927099; cv=none; b=YMpa96anYgcUps96/kD2EswkciSInYmiFbmn4tewcb5XkcshCvzXUVSUdYz0ClS6fJkEmXYXqIt4K31Ja3br5oMInk/yf/TCAgB3+4ob4PBMv8/0FpnutfHaOaTep1TGgOm3hTWqqq+rD3KZHNW0KQ4BZeFXFlttkdvMLqCKDuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708927099; c=relaxed/simple;
	bh=r4fr2FR7mibX624BrzO1Er+KB+l3Wt2/WIOEarW0yBE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IgVqKXlXrWoYKuR9X/ttX0ng5dAD4HDBTRhFD1Cger1Zi6TsYP92tMlpB8hspUw/Uj4Qg4PgbLgDpZUmHfzQdD5UgBTSFrZK6jBy30D3g62DJso79NsM4y4YMZjT1OZcpvIY+DgW98WQ160Na4PbD4q82ZTer+Liw2l9yy7xBg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=DZRlDEiZ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708927094;
	bh=qeJ5Q6qXAm6WKVnxUei/51MURT3w78lyHKsNAH5SvCI=;
	h=Date:From:To:Cc:Subject:From;
	b=DZRlDEiZ8VwfNSXBZjpzKPtp7q5pieIXCQVXNa+Ls3tvgUI+oh38wnifWvyEemlnr
	 p6wjdM3hi70HGsifjN5mQ22WQF79SGcI/NA3UphYVs27cCrsECQE5e187xuxFlTB6c
	 /TV3eD4TJrVAWKO/ScMfbh1AsUvbHBduvwXB83JpiyqVAZw7C7dDjqy0UuXCl5IcPe
	 UhWHl8ZMyX547QAELLQREbm9LkR9am1v5zlfXKQ+pSzdJVD0ZdjwbMk32oJLpWmmJj
	 6/YS+P2uyi+JYxFtSy+vKeghnySbuwHRzt6CEvvu1K/lpT7ZQDn7xoAOb0HU8Ttd1n
	 oGE9NH7jrJq5w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TjqfZ0nfPz4wcN;
	Mon, 26 Feb 2024 16:58:13 +1100 (AEDT)
Date: Mon, 26 Feb 2024 16:58:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kees Cook <keescook@chromium.org>, Masahiro Yamada
 <masahiroy@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the kspp tree with the kbuild tree
Message-ID: <20240226165811.56f71171@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Fh/hyUwCNLuBEw..bgQgHf5";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Fh/hyUwCNLuBEw..bgQgHf5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kspp tree got a conflict in:

  scripts/Makefile.lib

between commit:

  bf48d9b756b9 ("kbuild: change tool coverage variables to take the path re=
lative to $(obj)")

from the kbuild tree and commits:

  918327e9b7ff ("ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL")
  557f8c582a9b ("ubsan: Reintroduce signed overflow sanitizer")

from the kspp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc scripts/Makefile.lib
index 298bd8c80d65,b4a248c20654..000000000000
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@@ -181,8 -175,11 +181,11 @@@ endi
 =20
  ifeq ($(CONFIG_UBSAN),y)
  _c_flags +=3D $(if $(patsubst n%,, \
- 		$(UBSAN_SANITIZE_$(target-stem).o)$(UBSAN_SANITIZE)$(CONFIG_UBSAN_SANIT=
IZE_ALL)), \
 -		$(UBSAN_SANITIZE_$(basetarget).o)$(UBSAN_SANITIZE)y), \
++		$(UBSAN_SANITIZE_$(target-stem).o)$(UBSAN_SANITIZE)y), \
  		$(CFLAGS_UBSAN))
+ _c_flags +=3D $(if $(patsubst n%,, \
 -		$(UBSAN_SIGNED_WRAP_$(basetarget).o)$(UBSAN_SANITIZE_$(basetarget).o)$(=
UBSAN_SIGNED_WRAP)$(UBSAN_SANITIZE)y), \
++		$(UBSAN_SIGNED_WRAP_$(target-stem).o)$(UBSAN_SANITIZE_$(target-stem).o)=
$(UBSAN_SIGNED_WRAP)$(UBSAN_SANITIZE)y), \
+ 		$(CFLAGS_UBSAN_SIGNED_WRAP))
  endif
 =20
  ifeq ($(CONFIG_KCOV),y)

--Sig_/Fh/hyUwCNLuBEw..bgQgHf5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXcKHMACgkQAVBC80lX
0GzAQAgAlAXcMRY5vjWu76VfBIgkHbdeaQwU9E779u7Wh5IoyJMGeFmkGyC2YlT+
xA905TR3InKukBjgk9BWBd5Vz7cMWmozvwOeRES6wHq5EsIa0KP1O0Y9jPEWdk1A
uTwDiwV7tu+tt+BEKjJqQmooHQ7NPZwNic+3y9WrwEir4nnNoyMqewqLTrKJFw3F
bndB/MExAwlxuzaOeJaRuf7UjWjeAS5+05rAPRpW9ZvCLGIleJdupoKplU2/r7Jz
oXr5rVMZpQ+rFhBhWmixWmCXqehc+rTCRY9rPe1S74YZm0Pn5mAJdE87jWbRxlgg
yNBl8LXRZlnLTlKfM0eAdvRvDrpEhA==
=nnFF
-----END PGP SIGNATURE-----

--Sig_/Fh/hyUwCNLuBEw..bgQgHf5--

