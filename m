Return-Path: <linux-kernel+bounces-149592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C38BF8A933A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8D71F216FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410432838E;
	Thu, 18 Apr 2024 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qG4tXOz1"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F3225622;
	Thu, 18 Apr 2024 06:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422333; cv=none; b=tGj0sTB5dLEfV8+zT9Ow74dQnBims56F6wur6e1zJWACRbLM3P7TZapkNUrxL41dMDZlY7hYdps9yo7Vv1QrpwI8RYSTejXxcHe4CpF/raluCR3JktYmC/4Mz8y+YYH5ryvr+d1h/YYtpn8p0gm3xoptZmHhp6aJMnwVNwPhUks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422333; c=relaxed/simple;
	bh=UBdtksFAbQk8XeuVggCo+wrUYa0FmmiBqWUJ1GzBLS4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ub15VMlyIE5dJ5rlv+FrLGAs9tPbIvIKexxFzW8RJBAYmxC4Iu7d7HkV2aD91EWiwDqBj0sa+c/OIY6XkCKcMGtznnYhJaVWHrTbeN46KOR1f1V44ecEaG1YBl7PR7t9DZ3N5AtcyRdM5aK9p7VRJ3yYFjq34OqK0xUHg4uLWeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=qG4tXOz1; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713422326;
	bh=BHyU+uYXr2C2f4ARedjQ04T+FYE4a+tBYG1eM6Frwpg=;
	h=Date:From:To:Cc:Subject:From;
	b=qG4tXOz1fW/cS7vlieBq86Wpnbb+3F2iL1TvYwf3jgY1dtzO8xsDdSwzNdfplk/Pe
	 oAUC46Rt2EW/D/JnskwXwV2U4FaG289ukFOX/cO6nnS1nQ5Jpy8Hqo7ya/jP9Y+JCU
	 Q3evxdRbEatDyhJT3NB+Io9FU7WojDnmxjBs3Utn03hmWVMBc+iuJN8vBz1QahMGtB
	 GG/4xzkji6MArP0Xj91mCDfEt9qAgQ8Pf+d6MjscmtHGUnaI3n0TJ16vqXUD3QiSVM
	 iYrbbD6c8u0jTb2riNQeVo/vlqg9NGEwF9/aaTJ2iyQCwEINlqJqz6I/OfofT4ToeK
	 o+ylYl7vYU/tg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VKp5J2Q84z4wyf;
	Thu, 18 Apr 2024 16:38:44 +1000 (AEST)
Date: Thu, 18 Apr 2024 16:38:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Luca Coelho <luciano.coelho@intel.com>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm-intel tree
Message-ID: <20240418163841.3e9afb94@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j726xbuXFUq5Ng.BccLOo7W";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/j726xbuXFUq5Ng.BccLOo7W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-intel tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/i915/display/intel_dmc_wl.c:1: warning: no structured comme=
nts found

Introduced by commit

  765425f598c2 ("drm/i915/display: add support for DMC wakelocks")

--=20
Cheers,
Stephen Rothwell

--Sig_/j726xbuXFUq5Ng.BccLOo7W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYgv/EACgkQAVBC80lX
0GyEUgf7BziEcbp49SKj1TRqssoS2tLgh0tyioBmhaIkyrdd7pCBOaF4Vmr1jdNO
dHBNbxpWo8wG7+fzbguk/ApIfJy3c0YJxI/IG0PxxiGCgucxGtr324KzW28RSdfO
SGD3e1DRg3zo5RbkPyhlggCmRgiCc0dc1VVqvTYc2Do+qfWcf+BBU9eeg1B/Pcb4
HfkWHZDY+6FsLNjWG/FIcfFd8HWtwDqGufSU2mqaaTlCAQDJYgmPLaF916LZMZDH
GQLJ5xNGNATrvEQzQHK81lOFZdGeoqy4RRj9FneFek9DkoohJGmF+aygDSSnR9GN
wEZ4amvIaqmVAetYNSBjOLBMRhjpSA==
=ya9W
-----END PGP SIGNATURE-----

--Sig_/j726xbuXFUq5Ng.BccLOo7W--

