Return-Path: <linux-kernel+bounces-144527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443A98A4771
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73DB2827AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7898928F5;
	Mon, 15 Apr 2024 04:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RM/iuMZ/"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1554F7FF;
	Mon, 15 Apr 2024 04:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713155951; cv=none; b=TFGhwu2IOld70YBMohuscpekPF9XQq03h8vAHa+6DDUFXaCnaow5Zn4t1taR8LlKhMZoUr2zvwIN1JiADZceHc9LIJx3xa3+NRIs9KXSOwTwSKCTm15UAcW+hqERSOFEResTTDvYh3nR6997vvLDMUPYO0bXIIrNLEvjjzKcObo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713155951; c=relaxed/simple;
	bh=jFG1zarqPSZBvdH9j37JWOVCHSC2WchtVHd0y2gI/A8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ELQF/NhDG2Kyq4F6sR9ZdaWf8lVDOtLTe7MebReES22ZP78PjBgWYn7lQjn0zjaSrLC7amRCevb56rbWYJEZAsq/ShnNW7EQoWUN7K3uw7qIIlfjlPrHiUhQygCkQVEzYCHFi3q134x4ts0JgATYf90Ia5xB4pW/71Fvc8lZqyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=RM/iuMZ/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713155945;
	bh=sFlsimRQtHKkhuHdrxZVc2wXdkIEwEZmGbEtNIGuwTE=;
	h=Date:From:To:Cc:Subject:From;
	b=RM/iuMZ/FnJeSJPDws3yMzjYaH2e/nWqTP5L16YY+LEm5v2lyf+jNOGYYMMGLVIHc
	 8oE3r3iYhTQ5GcAl2gHNgrV90hF/vHljeexZ4j//ZQZAl5v72hryGzS5ydylPIcdOB
	 QODrHZfANdVJLUCmMaJxOATJRvmQINJTuwbYlo9bAXTRjqKTI38itJllZi6o+6o0NV
	 aa4oqExIFR2qd4FyJtZGhR00i/VLEqH1FIczkrNZlj8oGRhrT7zzs/WQyrflIDpYYn
	 RKVIj5yxxN0c/xcrC14RfiNaqPZTGm/3hb5xmPY/oYOmEVVmWXfYpkbaHCMwXjcjsh
	 HTmE/yBXBaASQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VHvZc4wG5z4wcn;
	Mon, 15 Apr 2024 14:39:04 +1000 (AEST)
Date: Mon, 15 Apr 2024 14:39:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: linux-next: manual merge of the kselftest tree with Linus' tree
Message-ID: <20240415143901.578b3b4e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//2O/TnzESje_HBcY0OVU6G6";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_//2O/TnzESje_HBcY0OVU6G6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kselftest tree got a conflict in:

  tools/testing/selftests/kselftest.h

between commit:

  f7d5bcd35d42 ("selftests: kselftest: Mark functions that unconditionally =
call exit() as __noreturn")

from Linus' tree and commit:

  5d3a9274f0d1 ("kselftest: Add mechanism for reporting a KSFT_ result code=
")
  f07041728422 ("selftests: add ksft_exit_fail_perror()")

from the kselftest tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/kselftest.h
index 7b89362da4bf,2cd93d220f43..000000000000
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@@ -303,7 -302,28 +306,28 @@@ void ksft_test_result_code(int exit_cod
  	va_end(args);
  }
 =20
+ /**
+  * ksft_test_result() - Report test success based on truth of condition
+  *
+  * @condition: if true, report test success, otherwise failure.
+  */
+ #define ksft_test_result_report(result, fmt, ...) do {		\
+ 	switch (result) {					\
+ 	case KSFT_PASS:						\
+ 		ksft_test_result_pass(fmt, ##__VA_ARGS__);	\
+ 		break;						\
+ 	case KSFT_FAIL:						\
+ 		ksft_test_result_fail(fmt, ##__VA_ARGS__);	\
+ 		break;						\
+ 	case KSFT_XFAIL:					\
+ 		ksft_test_result_xfail(fmt, ##__VA_ARGS__);	\
+ 		break;						\
+ 	case KSFT_SKIP:						\
+ 		ksft_test_result_skip(fmt, ##__VA_ARGS__);	\
+ 		break;						\
+ 	} } while (0)
+=20
 -static inline int ksft_exit_pass(void)
 +static inline __noreturn int ksft_exit_pass(void)
  {
  	ksft_print_cnts();
  	exit(KSFT_PASS);
@@@ -351,7 -371,20 +375,20 @@@ static inline __noreturn __printf(1, 2
  	exit(KSFT_FAIL);
  }
 =20
+ static inline void ksft_exit_fail_perror(const char *msg)
+ {
+ #ifndef NOLIBC
+ 	ksft_exit_fail_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
+ #else
+ 	/*
+ 	 * nolibc doesn't provide strerror() and it seems
+ 	 * inappropriate to add one, just print the errno.
+ 	 */
+ 	ksft_exit_fail_msg("%s: %d)\n", msg, errno);
+ #endif
+ }
+=20
 -static inline int ksft_exit_xfail(void)
 +static inline __noreturn int ksft_exit_xfail(void)
  {
  	ksft_print_cnts();
  	exit(KSFT_XFAIL);

--Sig_//2O/TnzESje_HBcY0OVU6G6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYcr2UACgkQAVBC80lX
0GyC5wf+I2maA1yCGvTTfKc5xwAFl5+6Aj9TLE0UJs4/5E+fbvPIxhAlr0IT21w+
yyQiLRfTXVKswqbGDgVupF6lLoCvnJIuUrbxytD6mLIWbH3f3GGNaRmMH0ao5VAQ
0IKl+tHLfwMIbRKg9bPPNEUV7lVU/dC9LEJuYhj0NRfaMj3SCtJdCLMn4J6fybDp
SiiLNWGldvinJ1ot09LY6UsYJe9dPtOvNN7VxjOYQygVoXSuNn0aaocPNPZLshQ9
7V8p3Y8H2II60gAEF4ywD1ck+G4yAfaWg7SzHOmVJddpTDn9qluzZspwhIS3pBad
UlZ0Vjf6rZMxDEob5Xp6URr+wh5THg==
=tfrn
-----END PGP SIGNATURE-----

--Sig_//2O/TnzESje_HBcY0OVU6G6--

