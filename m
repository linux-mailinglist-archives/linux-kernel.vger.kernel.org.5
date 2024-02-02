Return-Path: <linux-kernel+bounces-49043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAF084653B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE80F1F260CC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC6D63A8;
	Fri,  2 Feb 2024 01:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Vb+sH+tb"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B595666;
	Fri,  2 Feb 2024 01:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706835832; cv=none; b=DDY7xSA0pvFEoNlPrRZtFeq3ahed1t0S/Pi8ulvvBk1PE29uqeSrABK/01vXJOrq310korYOI+l2Go8Z6MsTh9Joq41szh/BUPU9cUKuIlZLZIDWmr8+F585N1k2W87btMbw3A0dbsifHk2fpNY26biKl6vFXV4c4VOLXTGQ17M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706835832; c=relaxed/simple;
	bh=C76J7VnYrHbxDAtavB76M49Hhhhr517HYZ3UN1nxrBw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bUhlbWpIK28htnb3mFVyzCqTAD0lTAJMFnCOSycS002V/9bh/+oU9QVp7zfmP736GMZNC9/TOkuQ5O0nmJT37p7Hu51jZWtxWMRazSNHHKpvMAj+LBS97RdK+d1d3j8hnn5RXwEdIt7t6E3p4TbgG8Y9b3r6HIa0CJv5P2vkGqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Vb+sH+tb; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706835827;
	bh=+9oIBTPwFPPTq6RPogiDs9fLnmSouioIt56H2oSIXsc=;
	h=Date:From:To:Cc:Subject:From;
	b=Vb+sH+tb3qoSTA0RSw0tISle7LB+BeLGae8vVYJul3sIFooJq14lTuDKeAQ1J6eP6
	 Xo+FwjcZSZO2tfG8muEkStxOEveVA1fQL++32/N7/CSDZljNmRe1WS7Sw8ajkzLnem
	 3F3AdSOW5ielZxDUsJZnBB2PoffWaRH9yJ/6hpKRG8Z0bsRaNgD9hfFk3G3lyUjrFe
	 CTK9LIM5kM3H2l2ZQfa5yuc7jik952RRWoMLG4yQZg25VzO0dbfUgrByZU7xLkOeK/
	 RgBka42MghysW8a4e5HswfK8Fc/Rl0V1V35NeFS9WZm2pTn6yjbs/SlhILFu/fBkak
	 l0rJ2MyUWwXPA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TQyFv4Mcwz4wcT;
	Fri,  2 Feb 2024 12:03:47 +1100 (AEDT)
Date: Fri, 2 Feb 2024 12:03:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the modules tree
Message-ID: <20240202120346.06e88db3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I+/Cyk47OiCzuBaDtllxRGL";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/I+/Cyk47OiCzuBaDtllxRGL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the modules tree, today's linux-next build (x86_64
allmodconfig) failed like this:

Segmentation fault
make[3]: *** [/home/sfr/next/next/scripts/Makefile.modfinal:56: lib/tests/m=
odule/test_kallsyms_d.ko] Error 139
make[3]: *** Deleting file 'lib/tests/module/test_kallsyms_d.ko'

Caused by commit

  6336b7d9a520 ("selftests: add new kallsyms selftests")

These new tests spend a long time just linking the modules (especially
test_kallsyms_c.ko and test_kallsyms_d.ko) and then the linker segfaults
before finishing test_kallsyms_d.ko.  Maybe your stress tests need to be a =
little less stressful :-)

The build machine does not run out of memory (it has 30-40GB free).

$ x86_64-linux-gnu-gcc --version
x86_64-linux-gnu-gcc (Debian 13.2.0-7) 13.2.0
$ x86_64-linux-gnu-ld --version
GNU ld (GNU Binutils for Debian) 2.41

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 2 Feb 2024 11:57:59 +1100
Subject: [PATCH] selftests: disable TEST_KALLSYMS_D for now

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index dcb1bd7c6d9d..152128d63d8d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2853,7 +2853,7 @@ config TEST_KALLSYMS
 	select TEST_KALLSYMS_A
 	select TEST_KALLSYMS_B
 	select TEST_KALLSYMS_C
-	select TEST_KALLSYMS_D
+#	select TEST_KALLSYMS_D
 	help
 	  This allows us to stress test find_symbol() through the kallsyms
 	  used to place symbols on the kernel ELF kallsyms and modules kallsyms
--=20
2.43.0



--=20
Cheers,
Stephen Rothwell

--Sig_/I+/Cyk47OiCzuBaDtllxRGL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW8P3IACgkQAVBC80lX
0Gy2MAf+O/P367kS9yacuSz2Fp7/iYxJpH+9U6B24+Q9l1Nj2UEMjR6kwyvnLsoy
Y3/udOyvGJlK6it7M2/b48EB3dOosSynzJ/EYMBJlsE1ssr8gdgzUXIAGAJLkC7h
iUSJyul2C0+mRkg/b07sGhq2hDHLr3YTMPvBw+29J2etz2Jsx6BQStvfHeW+Sqn6
Dije4Ol0/0DDUU6daunOakl03VPo9AmI7hn4J5jId+Ucqmj34veg5Tp8tKzg6a4u
usTlkVYClBXdk8DB5QQHwRv8ApK6sfp+4GIaZoaQ/xvu1M/tlMcIvTM8q4+/ZBNh
4NEDGbVYVFLfGYGQrtYkCp/4tWXAhQ==
=+cN4
-----END PGP SIGNATURE-----

--Sig_/I+/Cyk47OiCzuBaDtllxRGL--

