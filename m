Return-Path: <linux-kernel+bounces-72023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743DD85ADF2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FD9AB21A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFB154BC5;
	Mon, 19 Feb 2024 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IrHUTMmE"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40BC44373;
	Mon, 19 Feb 2024 21:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708379069; cv=none; b=netjmtrXEEZFbMrObpcSotTYWly+7Bcifg7140d5SzWidS0ibyv4HmCw8+eZ1Ojy2d94FZ9REzpGT2hLxiHx8WAVpyETZj0gZLRh9irWU4P7HJb/3v2+q09c7xiHMyhGDdE99SOA9rIpcy6SGYZdo+7K15o4ZESs1FYBi5d6OoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708379069; c=relaxed/simple;
	bh=CMKNuT9xAOB4ffFRG1cxkswslqUwbubaJTppV6ZvWVE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GYJ6RmwMhGRSvolO5FLj27KBqpqctZpxYRCNLpsKMbTdOkF1ZjXalwNPpYTGM8R/4oB2q7KrghuZdDIBmGsgB9nSIqQL1s+Wnz7aS3iOrb9O6uCNwcAHqWLSCdRoUbzicPOhC1FxT+FmTdHvogILZ42/ptm+5Cn5LNnjdummRJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=IrHUTMmE; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708379062;
	bh=HiDvpuw71J/LlDSovkEA8FqT7rHN1nxG+faFW3XghE4=;
	h=Date:From:To:Cc:Subject:From;
	b=IrHUTMmExTdNVWTN+gBgDb3h7oK691uutyReFTEHLxnZkcE6nj+BevK3pljaSBWlD
	 VRzmSd/3f32YlwE2JqKwWdb9gJrZQy+vnsRbsd36tZj24dkl6iUR3HyGfVjivZQXAr
	 y2QWggKn7yol2Ol6Pw+/Wt+aAKYlaoFG2oDGJ3olHCgyB+mRSoy7QduTHfeFFhasWF
	 2emw+WNTaPAPKsnTATyMKAzlEgD+woEsc1/YTrgQ6TTHfZhUNlKNxmrf7fc1ADFxvo
	 AZpT/PwrCtuF7bTQw5XlVyWMO1QPzzLF/YXTALqz4cghGkcojducP1aXgvAJ8NHqG0
	 Q4EpbKGw4RIug==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TdwzS6pxxz4wcQ;
	Tue, 20 Feb 2024 08:44:20 +1100 (AEDT)
Date: Tue, 20 Feb 2024 08:44:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the spi tree
Message-ID: <20240220084419.599716ce@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fP6Xa0VrptTYGa/O+Kv4QjS";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/fP6Xa0VrptTYGa/O+Kv4QjS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  afd2a4ae296d ("spi: spi-summary.rst: fix underline length")

Fixes tag

  Fixes: hash ("spi: Update the "master/slave" terminology in documentation=
")

has these problem(s):

  - No SHA1 recognised

Maybe you meant

Fixes: 99769a52464d ("spi: Update the "master/slave" terminology in documen=
tation")

--=20
Cheers,
Stephen Rothwell

--Sig_/fP6Xa0VrptTYGa/O+Kv4QjS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXTy7MACgkQAVBC80lX
0GyEwwgAn9n2LbtpWNcOPeUE0kIG6CQUElRnxIXDW32APgumWUr3BJfvnGk+PH7Z
XN1HBvxRczQ/eMtxTH2U1RpA99XEldJiivgEQQKiP2gBLikeFJQv3E1Ci3JiwxAm
Q8lkC5CWTZsN5owQQgLskYFzQdq0Gqer8C0BbZCxudEbcoEPmT/u9u+sirtenvnl
cx2K9pdrd7bWUI50hUzZLAYY2qazho0EzMaEWkKecHefeDFkbynA7ZKG/JcjRlFy
MzL0Rh82pLbTU8FSYjbf7yZygjv1L5WtIfCxOnCdnNHWMElXkS6xVnAfpFoAIeLU
fjHKDlcy7bW46uzUdYnOOt93az2DsA==
=0fVg
-----END PGP SIGNATURE-----

--Sig_/fP6Xa0VrptTYGa/O+Kv4QjS--

