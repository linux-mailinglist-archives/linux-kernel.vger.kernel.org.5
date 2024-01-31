Return-Path: <linux-kernel+bounces-45557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEECE84325E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD8A1C2502E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5458563B9;
	Wed, 31 Jan 2024 00:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BcR4dqQL"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF0215D0;
	Wed, 31 Jan 2024 00:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706662775; cv=none; b=scjTu/22tU1hx7UV8NUQxbIDy4Aapael611lhe+duXaffIbmmPG5s1c4dSYudqjfM2MGFZ/8wvuj97189WrqFqXh6pr2g3imWabr+7W1+7dFlJI7HalqmTyBRNNlzDMXrVWC+AGcvJa2U3nt0hXhdpO9JVR5gUp0IaoNkV9ZXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706662775; c=relaxed/simple;
	bh=QiAGZ5YlDQ9/BN4wTc+dq6HR05vGiESwMYzkZwr6Q5g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TqYELSdMjTgiEuka8JaC1s44XBy5nfPTAx0vixQZeXWipwlgqZCEsF9yTJZBF/H2fYz4toV9lYaUV6Vv9GnkUcUrLxpyqqv9Ha+w/UrLPp6tMV+ZDFT2Q+/zR08nXhQ92cgRgKrSDNkGg0XyVeWRCUjfHdp671ewpfs16zUTLyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=BcR4dqQL; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706662767;
	bh=wjVD1WbRSrw5Ycre1uFpDlv9VdOGrAXKq18adQUu1sM=;
	h=Date:From:To:Cc:Subject:From;
	b=BcR4dqQLIyYWEgm9s8Df6TLz1Tz2oHgYRLJYGlzny3WgI5XZl9TTDDDt40cKRtSTc
	 PoaFTwwLHXjyZo5OyS1Vc1snNlCBnLWF7mHqgtjDdaZOBxet9y5yACtX+KJMZR+2fL
	 XJEq6r3dYpn6TYqr73Hgkajy7qz01Nl3S6XTrRHDntgykODed28fisR4h6fllUB7xC
	 btXaVaQq/yOdlpiMC7rV4XOxiqw5pJ4FSWczhiYnDwQAOfCwl0Hn3gIbeZEAmwKsw6
	 dvyC7afOvs+TKRkj4osA7xEqJ/4TuRVbQsRtoVtTdB4MgQ5az7QNZdMGT0nTcfJsVg
	 OzvA47YKMa4cw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TPkFp16Wlz4x5k;
	Wed, 31 Jan 2024 11:59:25 +1100 (AEDT)
Date: Wed, 31 Jan 2024 11:59:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Kent Gibson
 <warthog618@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the gpio-brgl tree with the jc_docs
 tree
Message-ID: <20240131115838.4af8131c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//GV3tRzduIQsP/48FN8=t1R";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_//GV3tRzduIQsP/48FN8=t1R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the gpio-brgl tree got a conflict in:

  Documentation/userspace-api/index.rst

between commit:

  8722435d325b ("docs: rework the userspace-api top page")

from the jc_docs tree and commit:

  32a0a0da530e ("Documentation: gpio: add chardev userspace API documentati=
on")

from the gpio-brgl tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/userspace-api/index.rst
index 67d663cf2ff2,ee58d92c53c7..000000000000
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@@ -30,18 -16,14 +30,19 @@@ Security-related interface
     no_new_privs
     seccomp_filter
     landlock
 -   unshare
 +   lsm
     spec_ctrl
 +   tee
 +
 +Devices and I/O
 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 +
 +.. toctree::
 +   :maxdepth: 1
 +
     accelerators/ocxl
     dma-buf-alloc-exchange
 -   ebpf/index
 -   ELF
+    gpio/index
 -   ioctl/index
     iommu
     iommufd
     media/index

--Sig_//GV3tRzduIQsP/48FN8=t1R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW5m20ACgkQAVBC80lX
0GxmJQf/X27uqDCsReg6kOGUW5yAlTI5Ztve+TFrmGuerAU7cJVqaXG/LIF00gC8
JavzYBGMEAfpmU8l37Ek0A/C8DI8/nnpQCTC/ICM0qupMuz1hg6lQx/+E0oYkwwB
LzSCGNd4eFpDSQ0rueAmo3z3m16ESfMpO87cLWoIBvvvD9yXk+tt5CRIJXxgWFMf
zSDQ2mC6HRnVb7K5HfB55jFhsoGjH4PwJqLP7dvB3Q5iEKkcCEma2eQ6hVj7uPQz
2A1Vo1hdca/xBALXF84ZdRls0+kFE4UVtm+KyT0LF8SlxqMPaAW1Rq+bIBIBkb3f
VFlQGLPy7eFTFCEysi4ewFvB7hUGxg==
=p+Ag
-----END PGP SIGNATURE-----

--Sig_//GV3tRzduIQsP/48FN8=t1R--

