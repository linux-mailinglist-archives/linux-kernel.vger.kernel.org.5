Return-Path: <linux-kernel+bounces-139547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 433EA8A0438
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FA02841A5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CD93FB31;
	Wed, 10 Apr 2024 23:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UV7uQjR9"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBE628FD;
	Wed, 10 Apr 2024 23:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712792947; cv=none; b=fszS2YDonNGjAYvTaMPOCHVlSsR6Cqyd+pP2iFyxaSefgXIkR8uwH+a0sDoIBI77WPvhRT1o0rnwJfQx9ZlCb6BC2/JpBIvW6WeLxRhagioYLXP1JrqokFBVjNis1kHIcN0X6+GJ261GVqucEQ2eJqtnndOhGKH0A9Efkju4vbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712792947; c=relaxed/simple;
	bh=AabUpfwOQAwoC/UM2ZToLwXyol0Q8vCimxY/ZRroaNI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BSQZ+rWpnJ0pzJdsgxMmerqhuvDErcAw9RrEAmV6UrRQMMLt42zF/dI/01yxwe044+yT5AixOubzwzUZ8y4hlRMMuEyAu5WEt49AlaEk2cvwsrFF/6/Tq/qqpLMLknyGWjBb6P05XD55XfV9L2OARSqaV9esmzBTrN3OOvkL6ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=UV7uQjR9; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712792942;
	bh=JCvjldg3+pW2Bj2GmYu01ZxQ0ELtxeKRpV6j5ExywME=;
	h=Date:From:To:Cc:Subject:From;
	b=UV7uQjR95LDogTh8EcNMfkmngX9XyMeSDhsD5fJsrQscB06ucKbJRrOBiMLHLn0Lk
	 eoP64qK5iCBMEMg97k6V7p7J1oZiQx7dpysyIYCXTiEDJqaMtBea1RjQHeBmjMNXQc
	 687Rvgp4ENBZ7z4A2+jWb1f3ZauTPy8nMfPsmRRHk93GpgP+GwmhTEx5jiTnJhe6xc
	 b1kFxSx0RtIX+zTkPYEUgVlDxGNvbeVU2b3RLv+vGbfeQY6q1hy/Bg5WQuuSWMjIn+
	 3dsG/UhRaYE3XzGO0Zgqfop8X+O/JjG6hmQfjGHNL3aVtmIwF0zTD60GF0l1sp7K37
	 aW2X8hXEN3dHg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VFKKn6TDnz4wcq;
	Thu, 11 Apr 2024 09:49:01 +1000 (AEST)
Date: Thu, 11 Apr 2024 09:49:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Conor Dooley <Conor.Dooley@microchip.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>, Yangyu Chen
 <cyy@cyyself.name>
Subject: linux-next: manual merge of the riscv-dt tree with the risc-v tree
Message-ID: <20240411094901.2130c36e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/u25e+1GLC0Gc1=nCrtry.dG";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/u25e+1GLC0Gc1=nCrtry.dG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the riscv-dt tree got a conflict in:

  arch/riscv/Makefile

between commit:

  3b938e231b66 ("riscv: merge two if-blocks for KBUILD_IMAGE")

from the risc-v tree and commit:

  ef10bdf9c3e6 ("riscv: Kconfig.socs: Split ARCH_CANAAN and SOC_CANAAN_K210=
")

from the riscv-dt tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/riscv/Makefile
index 7c60bbe1f785,fa6c389c3986..000000000000
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@@ -143,15 -133,7 +143,15 @@@ boot		:=3D arch/riscv/boo
  ifeq ($(CONFIG_XIP_KERNEL),y)
  KBUILD_IMAGE :=3D $(boot)/xipImage
  else
- ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
++ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN_K210),yy)
 +KBUILD_IMAGE :=3D $(boot)/loader.bin
 +else
 +ifeq ($(CONFIG_EFI_ZBOOT),)
  KBUILD_IMAGE	:=3D $(boot)/Image.gz
 +else
 +KBUILD_IMAGE :=3D $(boot)/vmlinuz.efi
 +endif
 +endif
  endif
 =20
  libs-y +=3D arch/riscv/lib/

--Sig_/u25e+1GLC0Gc1=nCrtry.dG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYXJW0ACgkQAVBC80lX
0GwXvQf/aN6FskG7ANxR1bq2ycfganuAm/PIG9a8zJnnObUrHU568QJLE0Cl8Etq
uejr91xwyCwTpeGoSXicTnTmwX9G/FpcuSUXmVdPWPLB5+rF05sN5LV33EiPoyhO
Q9WVrcyNLrLrgT8znahwWKxDfkqaZmEBqYaa3fSMwx9NFU2c05Nu/Xt8wvJvtLSs
j4kzX4TxhAKE95WuaRHmXau9Wq/6kcXvICygFiJomwzqPLzhGgYJNS1HMK12GsGW
yoLTQYaVXlrXUR9AQ680Xk7BXiBduTPv0Koj/n+wx11qIqsLodNbY5C7S9yPqhFC
oC5/xyTYZuriEi6yd1ApWJ3sdOMcbQ==
=KHuq
-----END PGP SIGNATURE-----

--Sig_/u25e+1GLC0Gc1=nCrtry.dG--

