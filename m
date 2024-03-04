Return-Path: <linux-kernel+bounces-89954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A9586F80E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 01:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E600281038
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 00:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3EF10F2;
	Mon,  4 Mar 2024 00:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nDJfXvcT"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03446385;
	Mon,  4 Mar 2024 00:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709513262; cv=none; b=Ha6hPgTTCHinICtbI+tAoi3aGG4s/OmtOHtsr3lBcIb5GaiWHeTx5QlqCUe3nKmH1V4FIL7Rd4huyN3yhV35F0VzX3X2u5kH89sV/N+3P9NUXF+UpQRww8WU4MC39nZCKBxdHfjaUB+r5sG6vAxfTI5PkVMMzi43wYqgIUyFn54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709513262; c=relaxed/simple;
	bh=gKGT/R1VG/4aWp9BIwZ1OfAzNqK7HDv3nUlsiSFwjdM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jzTGWE8rAj3LA6gW0XvZRpRUz3GwI074ntlm57CImR/vML72QaAESAdrxwwJxXzjq7OxHOC7kyxu9TqqQFAxTT2zOYxztUlAZM0orLRJLZX/BJOuD2RoArDOguj+Ned0CdSKaYqtO9avfOk0GokDkLGjzXX06NZv3AuFlOfP2Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=nDJfXvcT; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709513253;
	bh=DS/jTDwm9Vvsxj9zq2HF+dBDM7EgVAj4XGKKoV3Zs+k=;
	h=Date:From:To:Cc:Subject:From;
	b=nDJfXvcT0ES/+CPQqzygTDUniOJ3iNO1JCYPmk4y1d/3VwGLnf5+0/S9HvQVDHaMV
	 +hloDixiJsnolFw5m0J9KNl7o79+PIgeV1W2oCMs1Zn4BYHund3wyVU/GExsdEtP69
	 PwNja+Y/julEa0KlaCiUq4NY367ipufUhhtFVH3AdE+D8MzvvyNmNleV15TM6SAifZ
	 iGTNGXztjd7RKDPqxrcb8ViihqK2a+UkiUfDAoO14X85YT6f1s/ehQ5luRqaUkI4bS
	 DWrqHtC3ntt6oVuvkYWdXDXYX31hk28CeuhVFAnOWKXcTY7uXrBHj0wL1mwIHUX+2u
	 XUfrXU+tlChyA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tp0Qr2bTwz4wb2;
	Mon,  4 Mar 2024 11:47:32 +1100 (AEDT)
Date: Mon, 4 Mar 2024 11:47:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Priyanka Dandamudi
 <priyanka.dandamudi@intel.com>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>
Subject: linux-next: manual merge of the drm tree with Linus' tree
Message-ID: <20240304114730.3528c81b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/N5eGvFHdYYH7dLGf=gmeDcx";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/N5eGvFHdYYH7dLGf=gmeDcx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got conflicts in:

  drivers/gpu/drm/xe/xe_bo.c
  drivers/gpu/drm/xe/xe_bo.h

between commits:

  a09946a9a903 ("drm/xe/xe_bo_move: Enhance xe_bo_move trace")
  8188cae3cc3d ("drm/xe/xe_trace: Add move_lacks_source detail to xe_bo_mov=
e trace")

from Linus' tree and commit:

  a0df2cc858c3 ("drm/xe/xe_bo_move: Enhance xe_bo_move trace")

from the drm tree.

I fixed it up (I just used the former) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/N5eGvFHdYYH7dLGf=gmeDcx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXlGiIACgkQAVBC80lX
0GwVMgf/XqcU3aYatR4evVWoZ45xAYneva/SjBkNA9cODTqjZ5zdjdhIO6TB4f2q
7ElS821lCqqhnIAlfoI2Q+StNTDvrPhbrocmGpsxpAu0mW5zvZm0eIfQyRWsWdNu
9+YccjrPm4ntoinjhBZicFlp3L88EqoPi69pHmiij+ahODHIR1a/P4RNDtiH8WUr
6i7DOK1nuZfeCCwZyPKoMURfyG20Rf/q+9MYzUh5TLWoKzl0Cf67b0snDfgqPS1/
liu0mQtGIdQP0jpX9g+ycNGDA2huq2ubRZg5BHU0SKxOJJWZyA2fXy8FxnoSK8Tm
587c2ubpi0QQZn0rRmo5NEKXVXwfMA==
=i13G
-----END PGP SIGNATURE-----

--Sig_/N5eGvFHdYYH7dLGf=gmeDcx--

