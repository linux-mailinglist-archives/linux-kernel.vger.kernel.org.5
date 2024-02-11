Return-Path: <linux-kernel+bounces-60976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34942850C18
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDA6280FE8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A09B171BF;
	Sun, 11 Feb 2024 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LBheBiLl"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914015C3;
	Sun, 11 Feb 2024 23:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707692653; cv=none; b=kw3qXSjL7d05nniYmoCSTd4P2M1+59NCS/dXP701sJusTvt3TSKtGDnnz9A7iubBha2OQ/WcEFKtFfmEE/NLDxAh10FODttYrT9f/hlnsuPci4FWYJ1ocMLzo5XXNB2QjM+Z+yADIo6gweBkiT/gA2ApauajW94wwK5zHbg2QGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707692653; c=relaxed/simple;
	bh=kMRLFb0103x5yMVxBy6sPonpF2CtIuDQztGmbWLySJI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rZmntkzFAAiB0ItYg4uC4TsWyspKLdy+y9K6FdOMfqzOajWvLhRcmlzfEd9oOoJ7PluAYlJIzEVyOWpfoCzoqE2P069dh4qwBleXDvlFIuVIsmzotE6dT6v56qFTrET5RWc17dcXvksWlGCCRzg0pEiaqI52nQsUzcQ6jLSgRAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=LBheBiLl; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707692127;
	bh=09zokI+nVMpltLJOhPeuRiCSxk2FWPngUU/BG+OkZJw=;
	h=Date:From:To:Cc:Subject:From;
	b=LBheBiLlxfXowln9CLZvr+G9/aMuQv4QymQ0VlYazz9f+KpudaLm2Vc5pYkPEe5Ci
	 wwbVCqw+hoiYMwBVt8+A9Ix8xHkZomxpKtCqqWgtSTk8RWmu6EcQgeB+Gdrv6eAw3A
	 lFM0o4CdLexv4MSJs6LiBIAzjXzxqLA0GU20vIzlflZzyRuhz0WUFb9ZBatEquDnKw
	 ULAlG2wg2xM7ocHv5ZXWqY+rcqV31Z2TFnilBc8UGl3Gwun5JG7/YeSC8eHut+Yh0T
	 m6uBIlqiu2gbI4EsMepjEVH0TH6DQf4oZNJMSmziFtnwHTUvYyJG7s7ZQ3sdJ6MQjE
	 DF5TSrHeROyrw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TY2x95GPlz4wcK;
	Mon, 12 Feb 2024 09:55:25 +1100 (AEDT)
Date: Mon, 12 Feb 2024 09:55:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>, Xiao
 Wang <xiao.w.wang@intel.com>
Subject: linux-next: manual merge of the risc-v tree with Linus' tree
Message-ID: <20240212095523.21f0579b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/c16UwBLhyXrpFWjYjtE6z2o";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/c16UwBLhyXrpFWjYjtE6z2o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the risc-v tree got a conflict in:

  arch/riscv/include/asm/bitops.h

between commit:

  4356e9f841f7 ("work around gcc bugs with 'asm goto' with outputs")

from Linus' tree and commit:

  cb4ede926134 ("riscv: Avoid code duplication with generic bitops implemen=
tation")

from the risc-v tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/riscv/include/asm/bitops.h
index 329d8244a9b3,c4c2173dfe99..000000000000
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@@ -37,9 -47,7 +47,7 @@@
 =20
  static __always_inline unsigned long variable__ffs(unsigned long word)
  {
- 	int num;
-=20
 -	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
 +	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
  				      RISCV_ISA_EXT_ZBB, 1)
  			  : : : : legacy);
 =20
@@@ -93,9 -76,7 +76,7 @@@ legacy
 =20
  static __always_inline unsigned long variable__fls(unsigned long word)
  {
- 	int num;
-=20
 -	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
 +	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
  				      RISCV_ISA_EXT_ZBB, 1)
  			  : : : : legacy);
 =20
@@@ -149,12 -105,7 +105,7 @@@ legacy
 =20
  static __always_inline int variable_ffs(int x)
  {
- 	int r;
-=20
- 	if (!x)
- 		return 0;
-=20
 -	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
 +	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
  				      RISCV_ISA_EXT_ZBB, 1)
  			  : : : : legacy);
 =20
@@@ -204,12 -137,7 +137,7 @@@ legacy
 =20
  static __always_inline int variable_fls(unsigned int x)
  {
- 	int r;
-=20
- 	if (!x)
- 		return 0;
-=20
 -	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
 +	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
  				      RISCV_ISA_EXT_ZBB, 1)
  			  : : : : legacy);
 =20

--Sig_/c16UwBLhyXrpFWjYjtE6z2o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXJUFsACgkQAVBC80lX
0GyZpQf/Yfg7Yx830HhqCBnPuJAHLCaTOH8r+WQe4Hpo0e79ifm+WlPAyilTTJAV
yAXw432SMICT5lrQSQHe/rghgeDtzi6dm+ywQI3niz7n6lwRs6AhUI1c8370HBg4
8R9kMCd/Ee3kkE5cqrBPhpA4lqqC6E874j2AeYfsmIBmePbbRLVj93NrEDtEqFWW
BeQbb0n94V+1MV4EhCQK6shoVLfNLfOKbHU1u4uuSJPxVPkWRtsocXwWa/9kL7L2
0FVPW0NYGWSG5GIwVxyX+QEWvSAYa9X9omMX5vqr2ffuOX9D7CB6WPKyquIfGCZP
8bGR0rHyn5pZmYQsh6TAvd93hwjN2g==
=YZtF
-----END PGP SIGNATURE-----

--Sig_/c16UwBLhyXrpFWjYjtE6z2o--

