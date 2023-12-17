Return-Path: <linux-kernel+bounces-2870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B23381637C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98364B21892
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACA74B136;
	Sun, 17 Dec 2023 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BKxmEd5U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F3A4B122;
	Sun, 17 Dec 2023 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1702856871;
	bh=Xd4o/leb3WIoJq7yzKGbJXYhThjRBM0bKQp6shqfr6s=;
	h=Date:From:To:Cc:Subject:From;
	b=BKxmEd5UqQk09NEwNo3vhgxYfjH829gpQLsQsbGIaIMVTJ0ccnWM8jyz+TKSjcvdR
	 pWcoe0hcOksD795WHGSy4DKV7x0ITzc/HMnAnFJkEM4qXivWzZsUxFpuFn3S79oKdi
	 /laBRT4CE5UIznwnSvWp6FDWSPrkmnhLOxBCApts2QMrunJWGr5y5Kv31r1bVTdTtI
	 8dcjkbdKM6sdkuYFPWM7DhJ7kH3X8xkS2PZOnlZzIrEjjtntWoV/7zLxtcTqndrQWk
	 UU58qFYx74MSZWnYm18/h2EwOPTSToD34elHSgNAnIpeug+jxMwmyX43soVrsUpOnA
	 k0NBRy+/UoNjQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4StflV2Km3z4wd4;
	Mon, 18 Dec 2023 10:47:50 +1100 (AEDT)
Date: Mon, 18 Dec 2023 10:47:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Crypto List <linux-crypto@vger.kernel.org>, Hans de Goede
 <hdegoede@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Ma Jun <Jun.Ma2@amd.com>, Sumit Garg
 <sumit.garg@linaro.org>, Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: linux-next: manual merge of the crypto tree with the jc_docs,
 wireless-next trees
Message-ID: <20231218104749.560969bf@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vGo7X1kCjDbbb56miX44ihq";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/vGo7X1kCjDbbb56miX44ihq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the crypto tree got a conflict in:

  Documentation/driver-api/index.rst

between commits:

  50709576d81b ("Documentation: Destage TEE subsystem documentation")
  2128f3cca5a2 ("Documentation/driver-api: Add document about WBRF mechanis=
m")

from the jc_docs, wireless-next trees and commit:

  8ccc257b29a1 ("crypto: iaa - Add IAA Compression Accelerator Documentatio=
n")

from the crypto tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/driver-api/index.rst
index e8e7ee506b13,8b95501cc208..000000000000
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@@ -112,8 -115,7 +112,9 @@@ available subsections can be seen below
     hte/index
     wmi
     dpll
 +   tee
 +   wbrf
+    crypto/index
 =20
  .. only::  subproject and html
 =20

--Sig_/vGo7X1kCjDbbb56miX44ihq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV/iKUACgkQAVBC80lX
0Gz4kQf/VtDx149MrnIeJCUf28grp9VB4DFY9wo69h/8rkQFzQG3bEBJi5QZJyUW
8iwmBokpY/744oqkGsrnkJW+vbNOCSDFTB7mqNUJTkAdkrKeh3Wi6B8Wgf1OcwKz
/DMtbGPaFYCLOTJ8zVYgsXYvz0o0HfopBru/CWMtjZ1iWdeHWxyTYOYBYFuybwbC
CDKQ2slGUyKrx5WHznPej7F82i3kbeiNbNdH319CI2dQsfBfYgzURPXHcWBTqsp9
w1PiaSDeIQR8qWUXEWmiZh4GmpxyFaR3e0WzxPH1xU+1rpR25Skdf7sY49m7n4r7
Jx7zExYIGVRv+nlkPplOuVH9d/5Kcw==
=KSZa
-----END PGP SIGNATURE-----

--Sig_/vGo7X1kCjDbbb56miX44ihq--

