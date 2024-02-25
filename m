Return-Path: <linux-kernel+bounces-80323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4203862D6B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EDC0B20E5A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ACB1BC23;
	Sun, 25 Feb 2024 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="U7yM1PEb"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AB11B951;
	Sun, 25 Feb 2024 22:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708900039; cv=none; b=MBKMeh4eiESAllIWuE6hbV5qIkdRfOR+3zmpfbW2sHy9uqUBSg5ZUxA/4nb2kDBQPMorTzDU9imbL3AuaJuq5isj8hN900BCOrZmpgDABjQoPyskr5TBabV6pJeebntl/izZEhMmxVKt/+JII3rFTg/VfjQcBrt55XHE7rqIrPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708900039; c=relaxed/simple;
	bh=pb+HxfIZ3gglynzChQW2WPTybqDXwGbehB3zBJPZYCM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jsNw1vQDJESF3THdDkas3ktGqm4S/MZZ/OTWOR6LV/f/kRJZoWyX1YhN65zdgdYFjaXdGBUa+0rdbzqOnvOXwn2fcGXXOYeLDmBWNVEiRWFF/XS8Es7c//r0Vddj5mM5UxmRKEgvv478lraaoTruH29dJOT2hI4no+Qc3t8a30E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=U7yM1PEb; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708900034;
	bh=50wi3HOWe5IN3zpn4H6jAsntjTCSdTrhMpYbEOU5cuI=;
	h=Date:From:To:Cc:Subject:From;
	b=U7yM1PEbW2o0t5QLajuo6dCvGQkVEV9q5vMcVT2JkjGFAs4KifL5jrw2/ZVAQCaSG
	 yKtDebuW0w9/mHVbBzC2O8KKxydMLLe0YFIbPxQLsgbJijaEMrlzm9MXKvgjuV5Yso
	 W1Uau7vFBvdznp2NpaPXlEpV7Led56ZQXOjzR0dihBmM0+YYNU+bDH36IcMzkPT38N
	 9RDIePVssrY4MQGz4AG8rEcU5OvJ++rFx3+AMR1YsawEm54UgRTe74CuOjYGTMjo0F
	 NhQzGBrTHfJ2GmiAwjiLsynQ6N5eU4T4YoI9/H+eiQ1Nh0zgth6F0wNp7mmndXXqIo
	 b++oDmejNE5OA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tjdf91NCVz4wcr;
	Mon, 26 Feb 2024 09:27:12 +1100 (AEDT)
Date: Mon, 26 Feb 2024 09:27:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>, Zong Li
 <zong.li@sifive.com>
Subject: linux-next: manual merge of the mm-nonmm-stable tree with the
 risc-v-fixes tree
Message-ID: <20240226092711.7985af2e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cUSGj6cmxZg.4tY6SC_cXVH";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/cUSGj6cmxZg.4tY6SC_cXVH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-nonmm-stable tree got a conflict in:

  arch/riscv/include/asm/ftrace.h

between commit:

  680341382da5 ("riscv: add CALLER_ADDRx support")

from the risc-v-fixes tree and commit:

  de5f3984664e ("riscv: remove MCOUNT_NAME workaround")

from the mm-nonmm-stable tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/riscv/include/asm/ftrace.h
index 15055f9df4da,cf5b63e789fa..000000000000
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@@ -13,24 -13,9 +13,14 @@@
  #endif
  #define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 =20
- /*
-  * Clang prior to 13 had "mcount" instead of "_mcount":
-  * https://reviews.llvm.org/D98881
-  */
- #if defined(CONFIG_CC_IS_GCC) || CONFIG_CLANG_VERSION >=3D 130000
- #define MCOUNT_NAME _mcount
- #else
- #define MCOUNT_NAME mcount
- #endif
-=20
  #define ARCH_SUPPORTS_FTRACE_OPS 1
  #ifndef __ASSEMBLY__
 +
 +extern void *return_address(unsigned int level);
 +
 +#define ftrace_return_address(n) return_address(n)
 +
- void MCOUNT_NAME(void);
+ void _mcount(void);
  static inline unsigned long ftrace_call_adjust(unsigned long addr)
  {
  	return addr;

--Sig_/cUSGj6cmxZg.4tY6SC_cXVH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXbvr8ACgkQAVBC80lX
0Gzg/gf+OQ0JHqSwC+sIoieCYIftEwnkc3IR1SDUF1APuB7neyMIKVgB+4JGZzux
AYk/QqqE5uzJf77h0g9VMHreHWrh6HXaT7P5A/vmGlahEdq/JcaqxXnkOh0/QeVJ
vj0T3/ZY6iKJUVuvx9L4DcrbsXcZg2DGxD0a7B8QA/vzniL/tFWoyPYqR9K4385h
42uSEiOnB71Vni2WpJH7VZaPdkpPmPduN/33TRLwH3AxFjhExdJGQk8NoN33jOab
RSsA3cJNEJcMqPC5SH7PN7uOxPyeywHhSj1agSkCT59HUL0pVpc4GB8ToE/ReOGW
It0Kcq4PCeeD28fxvmH5GRZRu3Yl0w==
=XRVo
-----END PGP SIGNATURE-----

--Sig_/cUSGj6cmxZg.4tY6SC_cXVH--

