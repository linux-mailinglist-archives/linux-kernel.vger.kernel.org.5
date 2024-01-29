Return-Path: <linux-kernel+bounces-42097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337D583FC44
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51CB285D31
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7885F14F98;
	Mon, 29 Jan 2024 02:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EADrx82o"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681B214A8B;
	Mon, 29 Jan 2024 02:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706495640; cv=none; b=tZKYuLrlKj3BdrZkSJhtGpBXvEovQYiwfTJLCCm3U/KDKYyiWGebHfWUExISeVIXeGn1AUrcNd3rKEL0wXbMkMOfpF5J0+S3e3aolDrfwRVAK/WdRu4pXup8Z742BE9cJdRriiKURlLsK2DaeUnLOdDCkPp7zvz/yt284Fete8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706495640; c=relaxed/simple;
	bh=8TOeeWD/2D0/4l8IGm1//aIl2M4Ap4d6hJGFq6oUnZs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=u/QzXy1vsbKXLUI9DGG4ZXwGCOLprZMMcoV+MnBwSaPjW3BZaiF0pz+5Iz2fno7xCF4mA31LbTgQETZFtgtEMh0v0WOU2KdN0jorKRoPUU3cm2FsI+S7+AIKh46y8X9mPIdlhPgqHfn0xg0BImKMa8TqegbLnijwtTk/4gwl+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=EADrx82o; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706495634;
	bh=sVqEco6myPIGO0i/9dacl7z3nklP6DquNjZ2EOIPXYA=;
	h=Date:From:To:Cc:Subject:From;
	b=EADrx82owkZmngGSE+bw/v8XvEoK9enK4z0L86wrOAZCPtLBPTSTTeodpnOq4yxEy
	 HtdrmuLep+tkS9qlPk9r96+Wu+xRnA4o60dpQKwe5CySsMqRPQox1Y4HL5L9M0DVHT
	 HKRIp38YOMP9riZOwgjoDEykxdk8h1Sujlaj2m87VVCrwAoixI9d66tSbMhHTbTtSm
	 J+42Q07iZdrAoDJNiuRLoYkUzOYG++4gZiEA//iZUYDYY6DU2K0ELqL+5I6HiqmGsA
	 AvKj2BjgyMkY1+otB5aCeXmCREGBY0prOD+r3s42HdHRlMWevVMt4nU7YZqkU+KSsV
	 2h8BWsI9DvaAA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TNXRk01r8z4wc6;
	Mon, 29 Jan 2024 13:33:53 +1100 (AEDT)
Date: Mon, 29 Jan 2024 13:33:52 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Nathan Chancellor
 <nathan@kernel.org>
Subject: linux-next: manual merge of the rust tree with the mm tree
Message-ID: <20240129133352.25a3ee19@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Te+XTXsK9_2B292JnXKszzb";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Te+XTXsK9_2B292JnXKszzb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rust tree got a conflict in:

  Documentation/process/changes.rst

between commit:

  3d21fad38152 ("kbuild: raise the minimum supported version of LLVM to 13.=
0.1")

from the mm-non-mm-unstable branch of the mm tree and commit:

  c5fed8ce6549 ("rust: upgrade to Rust 1.75.0")

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
index d7306b8cad13,eab7e2f8c196..000000000000
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
+ Rust (optional)        1.75.0           rustc --version
  bindgen (optional)     0.65.1           bindgen --version
  GNU make               3.82             make --version
  bash                   4.2              bash --version

--Sig_/Te+XTXsK9_2B292JnXKszzb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW3DpAACgkQAVBC80lX
0GzZWAf9GRE8mBBaN9909dq4E2m2tDSCbbEsLzzaqmc2UE0Rpyhp8IfODjJACmie
kNIwtUvlE7C3Z1l8MkRCRzRG2fjwbrDRb7lEFP4nS3Y0QFXub4oLlr/TICmupvM4
h8xrO6mWYtS1Sot5o0v/J8mWL6l4yJSiEN9liWoAK/SO419qpgu1YlNgmckYJnJN
/IgyjYRbrbju+eegnVkFXFL2M9/mjisHBIllLzsfPa2hVxPbpQvpzrmowczqngAj
9CaoLwTOg0+dqZWAAD12lifEqUGHfGOmX87lmTfce9eZz98xMayWJQ+e3Cc6Ye0V
WMMGnYmz1siymut5zvl7UfEqP2/GQw==
=8WMk
-----END PGP SIGNATURE-----

--Sig_/Te+XTXsK9_2B292JnXKszzb--

