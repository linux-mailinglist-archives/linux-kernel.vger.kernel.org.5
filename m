Return-Path: <linux-kernel+bounces-7894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE1B81AECE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ABFE1F24250
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EF6156D8;
	Thu, 21 Dec 2023 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="k3VZjW8L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871C156C5;
	Thu, 21 Dec 2023 06:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703140453;
	bh=nUhtLvTOheYdHlXefbwGGNCCpcBwQqatrUG1V2Cygo0=;
	h=Date:From:To:Cc:Subject:From;
	b=k3VZjW8LZBmHc7VpUF31JUXm1FXX1dgCm71nNN+GX+e0QmWFq5MorVTGgRcbpA1/Q
	 LJyBz8pA1O4Ud8eXFJ8erECXpfdOBPm0ShmbT4mTCZWeeMPa7B91H9ATEy5NnwyPWK
	 nVkPH7/82MXqcZXRqOxnSrUQ8YA088UC7C6OFP1kUpXQRM6rFurOUbradUvIftrsgP
	 61FvoNPiEP6ki5IrsqMg69lA7C8zZ+bBSuBP3tOKOkdp6iT9POXsAT4oStW0R9xzBg
	 kyOGsV0Rw+2SDQjthKUDv1sDMbVEo8hfNzMfTJWHAPmCvglkmAtYe9N1JcoAemh4OK
	 Bi2QEkf2OUp+Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Swgd12Y1yz4wby;
	Thu, 21 Dec 2023 17:34:13 +1100 (AEDT)
Date: Thu, 21 Dec 2023 17:34:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Andrey Konovalov
 <andreyknvl@google.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the slab tree with the mm tree
Message-ID: <20231221173412.24b78407@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kVhN78tD/kc2/0MCeJe=e4q";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/kVhN78tD/kc2/0MCeJe=e4q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the slab tree got a conflict in:

  mm/slab.c

between commit:

  3ef36a834801 ("kasan: rename and document kasan_(un)poison_object_data")

from the mm tree and commit:

  16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h")

from the slab tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/kVhN78tD/kc2/0MCeJe=e4q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWD3GQACgkQAVBC80lX
0GxgOAf9HLr30SJjbsSUzVkyV8u+j9c4SL/bYT2oQoJ3yjVaE0vnxKpF0Mvx6uwa
LhQ/DDiYEWgpgBImVLl1xM78ztvqNiOFptRRqnYIgDzygdPx6d6d7beG1k43nxpL
HMLnGPLNO3SBLpCxUaTtDQVtwGFJF+DyKuOmxM3oV3QO8SrFkhBQrqr8y0NSOucT
XRFXCu7GQFws3MQ/Kym88m7i6Vr1hY4Qb/fmUkrlG1eWxlj0yv8+xT9QZK3tNh/l
pCpWtrDQievcM0Aq3jAHgOpEvXc4zS18xESfVQynjNTPMmoQEL0sklK7L0dl/HcR
C02TZG5h1g52U4+LK26WO5hwmSDEhA==
=UdHA
-----END PGP SIGNATURE-----

--Sig_/kVhN78tD/kc2/0MCeJe=e4q--

