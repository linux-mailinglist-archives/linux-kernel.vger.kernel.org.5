Return-Path: <linux-kernel+bounces-87891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 560A686DAB7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1048D2856AC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D584F60D;
	Fri,  1 Mar 2024 04:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kygsMw65"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203BD446C8;
	Fri,  1 Mar 2024 04:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709267635; cv=none; b=NQmgf1xN/qdBvuwEpLjVjZjJh9wNBiHggLqWlbPLRSAVUNpq3/MD9fwWrc0Jfrc52MLN8KNEGe429CyX8/xolWyOdV8wIibcCsq5kmK0XGCG7wZ2MpPtZDIszf+O2i8aD6Uzhvmj5Vhz4v7JlzFQYPMIs+RGDR04o/X/0vjY5jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709267635; c=relaxed/simple;
	bh=q54LLk6cJTXWRuTNz6wuLM7DWgrZHo0ZxWgCn8HoNSo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=I1PGbv3xnoYsJcNSgCvSi57YAkFylsppbuxkBEaS5/vVzRUY40QeXz7E8RBG/RbiJQYXnWO8MEe7QP8X69AgnV5JYzWyNLuqljwzRl4ihrdbXkgRcvXnehk2GTrx3qpWuUAFnbhOzUU8YnePBNEmiteSwSUjRxPuOEoU9KjUQXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=kygsMw65; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709267629;
	bh=1++E/15N/FxTk8AT4mXPL0CthCu9aWjZIor9HqJA8Pc=;
	h=Date:From:To:Cc:Subject:From;
	b=kygsMw65PLP1TYBycNVEb99J9XTd0wzZRKYfcEjndf8ANE7VmmTKXBb4L48GCI5Dd
	 Of0P8SGE20dpaABxuhTIwTYHtc77TMTHOAWahiatVR7Zbg7YguuQKAM3/n/NuZ5pYy
	 4+ZMEVkv1/+0DytjflwGXPhJ/QFQNJoAL82S4A5JoqUGqT0p+xMtwhHVqiSWWbHeEF
	 o77iBmq+asp5nruRGYDdwdgzwZSG8tQE+mz9vPVNxPIyra/5S9cXFuCsNh13kzLBuz
	 p2dWjO1oZjIEck3sRAcQtHty9u7Zw6qFO0gBg4asEsmJ0XNUSiUKB0FKD2mptGqHFr
	 jV2lIOc3m2/Zg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TmFbJ49Gcz4wcb;
	Fri,  1 Mar 2024 15:33:48 +1100 (AEDT)
Date: Fri, 1 Mar 2024 15:33:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Nathan Chancellor
 <nathan@kernel.org>
Subject: linux-next: manual merge of the rust tree with the mm-nonmm-stable
 tree
Message-ID: <20240301153347.3b909702@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UR_NI7OB_9s80.hdc8rCoJ5";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/UR_NI7OB_9s80.hdc8rCoJ5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rust tree got a conflict in:

  Documentation/process/changes.rst

between commit:

  9c1b86f8ce04 ("kbuild: raise the minimum supported version of LLVM to 13.=
0.1")

from the mm-nonmm-stable tree and commits:

  c5fed8ce6549 ("rust: upgrade to Rust 1.75.0")
  768409cff6cc ("rust: upgrade to Rust 1.76.0")

from the rust tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/process/changes.rst
index 6391e7805355,c78ecc1e176f..000000000000
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@@ -30,8 -30,8 +30,8 @@@ you probably needn't concern yourself w
          Program        Minimal version       Command to check the version
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
  GNU C                  5.1              gcc --version
 -Clang/LLVM (optional)  11.0.0           clang --version
 +Clang/LLVM (optional)  13.0.1           clang --version
- Rust (optional)        1.74.1           rustc --version
+ Rust (optional)        1.76.0           rustc --version
  bindgen (optional)     0.65.1           bindgen --version
  GNU make               3.82             make --version
  bash                   4.2              bash --version

--Sig_/UR_NI7OB_9s80.hdc8rCoJ5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXhWqsACgkQAVBC80lX
0Gwfegf/aTtrYlKybK1GFYWPRGB0ZXY4pjDdp3UsdiFuZbMksmLUQSzT1EGbRZvJ
p+PjePkJeqJ/B1p2zMBq9Klw+WjmmDgSvIrFs/++gOMA9XXZOjMESy3BmkXIweu6
J3YKP2a+2ltJMagfJEg6oEGSRVZ3ianfonl2PXddUJaQr0ywZNScEnaviBsGugWd
b75kX642mfMrkYcUVsbDgcL8EyWJZvyKYsKHggLaaV7oXhP13Am+t47WFZch4Bzq
vywwV308zsKG6pzkL+PDhNzAkGt/3QWwxyvbqxps7Vxs7nLTxSLY4YuOnNd3ZCNR
CXiKAJzl1zg8j0HiLJ+8MAG8E+iC/w==
=DLQw
-----END PGP SIGNATURE-----

--Sig_/UR_NI7OB_9s80.hdc8rCoJ5--

