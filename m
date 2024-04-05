Return-Path: <linux-kernel+bounces-132371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B2E8993B6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0865D288038
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB501BF54;
	Fri,  5 Apr 2024 03:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gFm4eiwS"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D5C134A9;
	Fri,  5 Apr 2024 03:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712287008; cv=none; b=cNkN1LnoHNSfgfIT4RKWX/JTVQPVMyh8w6idLF5747ty7PO83zmBPtahzqWsuJq9RNFqNpKcYu6kgRduXRrp1o1HVbZT0X2Aqt+ug3VK1EFC7bwjK5BXCWe48UfFC+MpmR6mj+Kw9oNEsAel669Hc5o1xUlWouaVeFbKxU/38qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712287008; c=relaxed/simple;
	bh=0Zi4U3clzZ1kBQmj0GO8eAlVOcZFloc7Y9Ybw2ZgoWE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=L8Cmb1xhdJhIzX9P8TPwJINz8Fxp9bldBuMRrS4pcvAXwGHC9v1DSL9UDemrnY/V94XiJBEtltl5SdxE0ubNddJIK+mCwIvZMF5lW7zr/YAOR0Yk0Oo0Mau1xIMHerucAk+xSB8wqhySuUtqG5tlNzvg4pT8YmJu1C2UG1azNys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=gFm4eiwS; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712287002;
	bh=d5cgo064iDyl0ySWVajO9U2m2sHPbkAkT/2ugofzNXU=;
	h=Date:From:To:Cc:Subject:From;
	b=gFm4eiwSlb1thp61U8UQRQfKjOVqzHSKpTYaU+poLY27T7aNIEQwlhtPURYRUHMNU
	 5mY8BoDc2Shc2dITpsYIfMm598kZPtvHa/7fCEnUy2/Rozqhox4eLpxpn7HUqv9dg3
	 6e0sk3RIu0e33HDabGUExacqRUiWV/9SpD8yLGxKJjVrd3hL3Z2ngFiVNIPD/6O0Ei
	 Uuc5SRb3V1/x/esBD32hx+hIi6KsHwYt0Rtke+A0rMs1gnagSfH01DPKmmq99TMUUm
	 ElFPUXDKVFK6RsY0GPJgDX5uCMF1lO8mQlcMAu1O6M4EYOvJr6YtnShRCAHV6BRzl1
	 Bm6ZpyJvHzgBw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V9kD86bwDz4wyl;
	Fri,  5 Apr 2024 14:16:40 +1100 (AEDT)
Date: Fri, 5 Apr 2024 14:16:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>, Mitul Golani
 <mitulkumar.ajitkumar.golani@intel.com>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the drm-intel tree
Message-ID: <20240405141640.09b0bdbf@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/U1sk1SgAMcc8AgI/HojegJ9";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/U1sk1SgAMcc8AgI/HojegJ9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-intel tree, today's linux-next build (htmldocs)
produced these warnings:

include/drm/display/drm_dp_helper.h:126: warning: Function parameter or str=
uct member 'mode' not described in 'drm_dp_as_sdp'
include/drm/display/drm_dp_helper.h:126: warning: Excess struct member 'ope=
ration_mode' description in 'drm_dp_as_sdp'

Introduced by commit

  0bbb8f594e33 ("drm/dp: Add Adaptive Sync SDP logging")

--=20
Cheers,
Stephen Rothwell

--Sig_/U1sk1SgAMcc8AgI/HojegJ9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYPbRgACgkQAVBC80lX
0GwBIAf7BbIxxemjhKlaFZ8aVADC9tnt9y2IsHb4DtzmX5GPMZZlGv42O9jCzcec
ttpPKV7UEOeSuB7Sis7gG+7JtNIF2TE7yeLrdB+Q3wcMeyvKtIitCIszuTeGG9v9
NEAoElKZnBBZptvysMtyfs2czU5hiHIfVZm/Jjg9Gg51SQt3Hh9aTPsuvD3D0hmB
I/956/7a8SEbQcCnfIN3XZ2JNJp4yATCvPQfCu1qWR1Xauu9OHT/eScDezwgkr7x
QJqTpKs1r+C0LJ7aALjBa881xp7ilUMWnCFdPFtPRTILuhx8poGR4TItAInpm/hi
zZ63sYuLlD3tmbUt1gJ2CjuvtTLG6Q==
=Lxwm
-----END PGP SIGNATURE-----

--Sig_/U1sk1SgAMcc8AgI/HojegJ9--

