Return-Path: <linux-kernel+bounces-87896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F8F86DAD3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79235B24611
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1097951C49;
	Fri,  1 Mar 2024 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WG9ny9Dd"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4451033;
	Fri,  1 Mar 2024 04:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709268237; cv=none; b=Q1BxUamuKST4O77ua00Xet5X0spYNpYZUkE8m8Xx3Vct3tRvQHe1LtKuOWZ9rITc1UhlzBhfsTOB/uDDA8E2vm5NPHP56pCLoQjoUk7gbb0rXKnYTpXIC7GUgcfqp9EtCsGXzGdty5LV6q+vykbRwuToOmq9eK8XOEN/MYkqef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709268237; c=relaxed/simple;
	bh=Y9vfCgDmT2BQFbB3+dEDOWk/mSq6gPK4NfzlEPHRqoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jvAYnZccsi/0J3Nxk75qnicZD2VSr3+psduGqBFZ9VBXfJ/OiFD1p+hQP8VHRFZlNDxSEHpYpaHHiakFvm5FNo+LmRWX8gNqcnekK/4RIEAPNMT/Pga1uB885GYJNJPrW4mUsbrR2d/76jenV8qhPf37WUG+f8LtJKX5DWy9MFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=WG9ny9Dd; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709268233;
	bh=IQdxyYRqLbqRHd0QRAv82up7XWq7gdRKMGi2dO9mA/8=;
	h=Date:From:To:Cc:Subject:From;
	b=WG9ny9Ddm62nXWfPd2A52zdZxekWDjE37rbxlV5WiFag3yESYmKuz4i6L/swqzL5n
	 X3NKVyVSk/3k4twT4uQ9+YMPDhdCrwarccYQKiUT8Fzey95PW4AaFQR1IuAyNChZTj
	 FnbHCsUExMgSzYfPDv26KZsM3k9LDkN8QtTvYv8fVl1SDpnx/eMV9mUCYIZUzrJgb6
	 24a+O8Jpeg2EnpDjD7Vnxjj3cyxxFt7mxld5nbULdmQAW7ClPznM/FOamexi3uzlzO
	 nQW63oba0F1NxTOdxPt7rQW3vri6CDmQyTWR+MwDRV84HBCl7I20uQOEPXOxBR/M0q
	 TERyZGBe71+eA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TmFpw5WGtz4wcl;
	Fri,  1 Mar 2024 15:43:52 +1100 (AEDT)
Date: Fri, 1 Mar 2024 15:43:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kees Cook <keescook@chromium.org>, Kent Overstreet
 <kent.overstreet@linux.dev>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the kspp tree with the bcachefs tree
Message-ID: <20240301154351.1d097566@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0fkbFW/mkj3_Ipdtx5Rv2PT";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/0fkbFW/mkj3_Ipdtx5Rv2PT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kspp tree got a conflict in:

  lib/Makefile

between commit:

  f6099c0b0300 ("darray: lift from bcachefs")

from the bcachefs tree and commit:

  257e66e5800a ("string: Convert selftest to KUnit")

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

diff --cc lib/Makefile
index ec3d915e7889,97c42e38046f..000000000000
--- a/lib/Makefile
+++ b/lib/Makefile
@@@ -48,10 -48,10 +48,10 @@@ obj-y +=3D bcd.o sort.o parser.o debug_lo
  	 bsearch.o find_bit.o llist.o lwq.o memweight.o kfifo.o \
  	 percpu-refcount.o rhashtable.o base64.o \
  	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
 -	 generic-radix-tree.o bitmap-str.o
 +	 generic-radix-tree.o bitmap-str.o darray.o
- obj-$(CONFIG_STRING_SELFTEST) +=3D test_string.o
+ obj-$(CONFIG_STRING_KUNIT_TEST) +=3D string_kunit.o
  obj-y +=3D string_helpers.o
- obj-$(CONFIG_TEST_STRING_HELPERS) +=3D test-string_helpers.o
+ obj-$(CONFIG_STRING_HELPERS_KUNIT_TEST) +=3D string_helpers_kunit.o
  obj-y +=3D hexdump.o
  obj-$(CONFIG_TEST_HEXDUMP) +=3D test_hexdump.o
  obj-y +=3D kstrtox.o

--Sig_/0fkbFW/mkj3_Ipdtx5Rv2PT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXhXQcACgkQAVBC80lX
0Gx3zAf/QV4nKxWGSgdgTatdZaeJ3jqFz7piy8oLPIcKqtl63wvQOOjAOOiPU+nI
5gh+xyNMtVvUblP8tWgbBMcXLJ4Ogdx+BBJIFwfcFa7K7dkzVj+j0CEiQQ9CoO4C
a2Sb53gdYZFmKshLhHLlESgSB/pqueiXPFzXfC72iW9aofuBSRmKcLwac8dJWIih
AF7Be3prVdp1OTmrfo7JdivRvOfTqIqUuWL2wtykqRaXS1D0o8M29S6MxLZPryr/
81EaGZxYYlZb6eg+FwWfQpr2COtwTsXkIRJhVmqwIxhXj/BlQBGMXbxgt5xAN1TC
FjvCpiqxR9a30yrqOPJBYtToB2vuwg==
=C1/1
-----END PGP SIGNATURE-----

--Sig_/0fkbFW/mkj3_Ipdtx5Rv2PT--

