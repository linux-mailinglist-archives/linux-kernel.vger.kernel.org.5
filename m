Return-Path: <linux-kernel+bounces-54297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E8884AD6F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65961F24ACB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895B174E0A;
	Tue,  6 Feb 2024 04:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nrVR97I6"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6228B74E06;
	Tue,  6 Feb 2024 04:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707193739; cv=none; b=UJqbVPEg9m43FENsmv9PFxyU6OO18We/wVg6vUh8Jz9Hoi/0Tayq5HS0ocEf10FFw3b14pdYves+KfJb1KM+XSVCRyrh9jJN0onaG9bDiCqsThVFhWTYA2EvC0swcW+OMevmGpHozti/sTFIwEmxuJHfgiUpcN7gB3uSCBULHY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707193739; c=relaxed/simple;
	bh=Zy0GF+e5VWhkJg3CITxJZKjoEMKdDZ/8GzFJf7bPyeI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=XOMBuDXgwZ3kopbEPHDI8TPrYVx8+2RykrHahpwbiggzftheoHO5A9jEhgB3rcn3iq6h3zdLJr2KJzgz/COO0OrNZboBbqOSOsnxQmSEfq+FSXmo0GXyx3lTpl1Q6nSWzy9Vd2Q1Bkg9s0T00347J0gYUr4OZAbbwIrpbiVhQxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=nrVR97I6; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707193733;
	bh=dnMjULAeQjKUoGmPRhe1coGuGskZaD6h8z3MIPfgPs8=;
	h=Date:From:To:Cc:Subject:From;
	b=nrVR97I6Ea2OifH65kdK3jSc8ubBFbjquHicHDGHI4TXr5CbSa+P84H03RuJ30ILS
	 OZITWgA7quRjZL/ld+8mqUB2U4r1mqoJ2+W3NzbpPys0Z0Fq8hC+CqUNIyCAQATlIj
	 kG3QY+I0wNckDkDvNq0qaTvHms6Faq2ysNnYZ6DUF0PK3diLRuN49C4C7BQHgxYFsF
	 QEbWbKqo8W9VH+zW32pRgODvCZ8N5NvMzJCz3Hn5mXexLdMNYiCNHArSRV4juaiktx
	 kJp4xKR4fMbe7aOUAgMAZ3QSOOZZEbNap7BxMP2KorgoKXrTxc+D2jsLtVqKMoma9H
	 3FMHLMtM1etRA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TTVch6nrBz4wcC;
	Tue,  6 Feb 2024 15:28:52 +1100 (AEDT)
Date: Tue, 6 Feb 2024 15:28:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Somalapuram
 Amaranath <Amaranath.Somalapuram@amd.com>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20240206152850.333f620d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3Y6MoHeU/vcVg9/l.X7hCZH";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/3Y6MoHeU/vcVg9/l.X7hCZH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (i386 defconfig)
failed like this:

In function 'i915_ttm_placement_from_obj',
    inlined from 'i915_ttm_get_pages' at drivers/gpu/drm/i915/gem/i915_gem_=
ttm.c:847:2:
drivers/gpu/drm/i915/gem/i915_gem_ttm.c:165:18: error: 'places[0].flags' is=
 used uninitialized [-Werror=3Duninitialized]
  165 |         places[0].flags |=3D TTM_PL_FLAG_DESIRED;
      |         ~~~~~~~~~^~~~~~
drivers/gpu/drm/i915/gem/i915_gem_ttm.c: In function 'i915_ttm_get_pages':
drivers/gpu/drm/i915/gem/i915_gem_ttm.c:837:26: note: 'places' declared here
  837 |         struct ttm_place places[I915_TTM_MAX_PLACEMENTS + 1];
      |                          ^~~~~~

Caused by commit

  a78a8da51b36 ("drm/ttm: replace busy placement with flags v6")

I applied the following hack for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 6 Feb 2024 15:17:54 +1100
Subject: [PATCH] drm/ttm: initialise places

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915=
/gem/i915_gem_ttm.c
index 80c6cafc8887..34e699e67c25 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -834,7 +834,7 @@ static int __i915_ttm_get_pages(struct drm_i915_gem_obj=
ect *obj,
=20
 static int i915_ttm_get_pages(struct drm_i915_gem_object *obj)
 {
-	struct ttm_place places[I915_TTM_MAX_PLACEMENTS + 1];
+	struct ttm_place places[I915_TTM_MAX_PLACEMENTS + 1] =3D {};
 	struct ttm_placement placement;
=20
 	/* restricted by sg_alloc_table */
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/3Y6MoHeU/vcVg9/l.X7hCZH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXBtYIACgkQAVBC80lX
0GxSHwf7B3D9Ebe7H+C1S84E/g/hlQwxf+jo8X+m4cEWbMKvzTuloTlIBADoL93W
E4SolMFUwtAQtuAPTJIfJPfCwFGxPBUbqpY3cTzA6rBM6XHvLMjQLPubfeZoX6oB
u0YtbT36l7g+26YUvQdz6FtFlA+X5A+bpVnX0KP1+sw6yhTNqRZEFjxoEvIeIMt+
EUOkKoSO6lcokZTcWVWQxiBDPGHFXW+jyzj9JcEI0i0FbcEmvYbUz25NXDSeU6PJ
3xAxI06Fe2ONdboipZyjWMnZNUO3iy24Wsp4RQ3eYLoL5QWYP8tgrTesTTaA8eyY
WSqEqGwjt8cAeuR5aDcEoeSW116FbA==
=rfsv
-----END PGP SIGNATURE-----

--Sig_/3Y6MoHeU/vcVg9/l.X7hCZH--

