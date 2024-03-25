Return-Path: <linux-kernel+bounces-118163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFBE88B550
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491D91C394E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CC883A0B;
	Mon, 25 Mar 2024 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Q+Y/qNGA"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142F839E8;
	Mon, 25 Mar 2024 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711409388; cv=none; b=IELHvamkp8VqRvFfHzpHHBHU7i2knnkicLyIC1zwimli1dUTnRnt/OAB9xpWr+QZb0RKY5pBVTvN5AwVoP7Q4scfFcFZTLbNrqQLwU7bBcKkfI6Ki2vDPL0gCbjgKbTfS0KYj31TUOdTf7XfnLa1VGcxr9HZo2wDXZeeB7pmwAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711409388; c=relaxed/simple;
	bh=g2uwgfAGnnq09Px+7wcO8K0SAA547ZbNuzgHpMbGkIA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oi8VvCNZZcCRmI9x+1i50GsKAsomSFKPKvRVSzU033T6S/YpGiLEybUm8H6QkXA2irh4632abfVCBUEl00NZspicf+AwTANMhRFbeDmvrMpQCADAVJyWlyI15uJlmAWqBTkoI1asL2auv1G8F8c+xJXWM7NQaHAHjsWkwM/Wej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Q+Y/qNGA; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711409382;
	bh=EyfkhQ8hNpU8Py0szI+iEm/kcSgQWUtzoWYlXfx3z5M=;
	h=Date:From:To:Cc:Subject:From;
	b=Q+Y/qNGA4dgLEp4LQBlGdIoq7IB2iCmfzOflMloGXhWdVis97mhpmriHxO12EKH27
	 nKvmn6TuUgESumudC5rK64EKoiC0v3Nj9RvNHwqIjzs//WfE4h2EC5j1SKahuFrg3T
	 IWBTh0tHnu2k9GfZOXagxDhR8Upfm6qZN7/ESdThnjVA1zHQMD+KcgoLdUhAZVnG/0
	 CZrA8FeyQ3GGvQ1kVwB8uu6Xg1iVGCaUlrZbGWblMsNI3MjI412sHITqGxZ501A5YE
	 3xFiSxYhij1y3DMC6skZlxC+48IQuWdsqeY8P3LY7mBD9Z6MNNmDi6GtgKG+NczwBk
	 oxNnUDMmoEI+Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V3Tfs3N8Bz4wcv;
	Tue, 26 Mar 2024 10:29:40 +1100 (AEDT)
Date: Tue, 26 Mar 2024 10:29:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Intel Graphics <intel-gfx@lists.freedesktop.org>, DRI
 <dri-devel@lists.freedesktop.org>, Andrew Davis <afd@ti.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>, Tony
 Lindgren <tony@atomide.com>
Subject: linux-next: manual merge of the drm-misc tree with Linus' tree
Message-ID: <20240326102940.3aae34c2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ygbA2ZuS_IQ2QzuvIJgCwXy";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ygbA2ZuS_IQ2QzuvIJgCwXy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  MAINTAINERS

between commits:

  35df039b26ac ("dt-bindings: gpu: Rename img,powervr to img,powervr-rogue")
  796da8ca7e05 ("dt-bindings: gpu: Add PowerVR Series5 SGX GPUs")

from Linus' tree and commit:

  3f9ba0c01125 ("MAINTAINERS: Update drm-misc.git URL")

from the drm-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index ae2121b7a176,13a69b4731c7..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -10600,9 -10496,8 +10611,9 @@@ IMGTEC POWERVR DRM DRIVE
  M:	Frank Binns <frank.binns@imgtec.com>
  M:	Matt Coster <matt.coster@imgtec.com>
  S:	Supported
- T:	git git://anongit.freedesktop.org/drm/drm-misc
+ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 -F:	Documentation/devicetree/bindings/gpu/img,powervr.yaml
 +F:	Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
 +F:	Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml
  F:	Documentation/gpu/imagination/
  F:	drivers/gpu/drm/imagination/
  F:	include/uapi/drm/pvr_drm.h

--Sig_/ygbA2ZuS_IQ2QzuvIJgCwXy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYCCOQACgkQAVBC80lX
0Gwgagf7BA4hihMhFpCtpV24mjfDLfCaPGm2okIpJePxiVKz9qc1C6OLGdbmCIvL
dR0onDmE0/o41TgtNR9p9IixltOH+ushqw1+FLE0Bv/k4PIKaKFYYjPgaLCRHE0B
uXvZP34rSmaluBCQJaT01nLLmJwU8CUXIvSOCHxoUDrM19otfbOIHlzA0AJCOnsi
CRjOYLtwpF+u9CvB0W5ulLXsPZBwjiXwj3XoND4h3r3ojy0mrXTR4AORli/v8FnR
H0bgn1zpTV1158VQ9TbCXYU+l1ricB1zjdLq9DS2bsbJPOznF8E3SMjgOrR1k1FE
mITvlcp+OZPpqF34W1mFuWXrQIBBiA==
=t2YV
-----END PGP SIGNATURE-----

--Sig_/ygbA2ZuS_IQ2QzuvIJgCwXy--

