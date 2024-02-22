Return-Path: <linux-kernel+bounces-75947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBF185F106
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C17284D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2709E101F1;
	Thu, 22 Feb 2024 05:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ny5T3Ugo"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C76E79FE;
	Thu, 22 Feb 2024 05:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708580483; cv=none; b=kKI8/upmIWcz5WlcV2h3BrLtBPxiQdHcuaXAOx1YykjnUXfWKc20423+CaB6ZiH1VxsKNHBhe6T0kqJq1PwYbOjgZjqcmy4pjBMesAWD3OsjmI13j64ZTHoFJIY123Nc+bZyo9qGY+gMOYBEQp9k5rBRT22Kh5xr5MpfZFp4WsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708580483; c=relaxed/simple;
	bh=CyFF8u437hi+0IEu6LKGKSPe89Imahej+9Wfm+1JmhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gm259MEdSyg9r4l8z79oobit7knl0t9A4wWx4891fl0U2BA/4K1ss+e+rU2/Ts6atkgNddIKqhO01XWFz2U7szf+FZpechmZ/7JgkVnDCTPWUsKkfmchUJ7Smjon9iQ37vXAZh/wi0+WGOXjaom75XbwqnCKH2MyxODU4i1+4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Ny5T3Ugo; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708580475;
	bh=l/mQIp7cq83y6qmgj8qMJwfolXmHqJjsdTvnn/kBjYc=;
	h=Date:From:To:Cc:Subject:From;
	b=Ny5T3UgobztFLCvGTXCKB1F1R6hclLrwGyx89t/67Zw+rD4V1FEAl07O1Eu5kJmZm
	 OZFxHBeEZ488liOik84ZmOoxOnCQGxrHT25aXKpy+A4m+jae/5EZ+ugoxtCxX4FddJ
	 Pn+X9m9Ht/Kk3hdcLtkDCicJD6J1G2SyEsX+Az45mNJR3Eu8WVwDpfbopHIGcEdn9n
	 18tSe1KK0jHQYqGvfjxTIvC3Mju4jU/aF+XkillHse0QknGTmep+ZYa9pgsgb3Hzl3
	 9klSuPlhT+HDH8WekL2P2Muh+lgrRQbmLD4gETUSVnta/CWESW0m7us+nUCJhcTEuP
	 0+wwqOrRx9+Qw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TgMSq1BLWz4wcq;
	Thu, 22 Feb 2024 16:41:14 +1100 (AEDT)
Date: Thu, 22 Feb 2024 16:41:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kees Cook <keescook@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the kspp tree with the mm tree
Message-ID: <20240222164112.20c5646e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/in8Tuk7waFON2ccEBaZB8ct";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/in8Tuk7waFON2ccEBaZB8ct
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kspp tree got conflicts in:

  scripts/Makefile.lib
  scripts/Makefile.ubsan

between commit:

  1a75e5856b3b ("ubsan: reintroduce signed overflow sanitizer")

from the mm-unstable branch of the mm tree and commit:

  557f8c582a9b ("ubsan: Reintroduce signed overflow sanitizer")

from the kspp tree.

So, the conflicts looked like this:

scripts/Makefile.lib:

ifeq ($(CONFIG_UBSAN),y)
_c_flags +=3D $(if $(patsubst n%,, \
		$(UBSAN_SANITIZE_$(basetarget).o)$(UBSAN_SANITIZE)y), \
		$(CFLAGS_UBSAN))
_c_flags +=3D $(if $(patsubst n%,, \
<<<<<<< HEAD
		$(UBSAN_WRAP_SIGNED_$(basetarget).o)$(UBSAN_SANITIZE_$(basetarget).o)$(UB=
SAN_WRAP_SIGNED)$(UBSAN_SANITIZE)y), \
		$(CFLAGS_UBSAN_WRAP_SIGNED))
=3D=3D=3D=3D=3D=3D=3D
		$(UBSAN_SIGNED_WRAP_$(basetarget).o)$(UBSAN_SANITIZE_$(basetarget).o)$(UB=
SAN_SIGNED_WRAP)$(UBSAN_SANITIZE)y), \
		$(CFLAGS_UBSAN_SIGNED_WRAP))
>>>>>>> kspp/for-next/kspp
endif

scripts/Makefile.ubsan:

export CFLAGS_UBSAN :=3D $(ubsan-cflags-y)

<<<<<<< HEAD
ubsan-wrap-signed-cflags-$(CONFIG_UBSAN_SIGNED_WRAP)     +=3D -fsanitize=3D=
signed-integer-overflow
export CFLAGS_UBSAN_WRAP_SIGNED :=3D $(ubsan-wrap-signed-cflags-y)
=3D=3D=3D=3D=3D=3D=3D
ubsan-signed-wrap-cflags-$(CONFIG_UBSAN_SIGNED_WRAP)     +=3D -fsanitize=3D=
signed-integer-overflow
export CFLAGS_UBSAN_SIGNED_WRAP :=3D $(ubsan-signed-wrap-cflags-y)
>>>>>>> kspp/for-next/kspp

I fixed it up (I just used the kspp tree version (arbitrarily)) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/in8Tuk7waFON2ccEBaZB8ct
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXW3ngACgkQAVBC80lX
0GyOswf/XEl9X5KzBmMth0TvJJXb7T39WjMe40xE27GYDIPeUNnq0cYk3UekKhzo
1b/xlH2rcQhK24ZBE8ua6vZs6FjwIwuDoQBzxucv3+oz6o+D2XJ8lRNV0c5Lpq2Q
vHhH3YmJSpRAwYZpSXJ8ysD6UKhyLHVgWv4WBHaUfZR2gt/JkWAlleC/ZDYRmbPa
cW+9xVFXCQM7/vLDkoWHTzq7mFKkigK6/uEPpinzN1NDU3TnJHkEuZxNKJSKoJWj
yR+zEMHjADF6jM+AtvMgES7kgvsVRYQpmDD+nYgdJrUanS5LSQEWjbuliCsdheRQ
xYMeFzkdHnIdBahzauOeZhe8S5COdA==
=IkEk
-----END PGP SIGNATURE-----

--Sig_/in8Tuk7waFON2ccEBaZB8ct--

