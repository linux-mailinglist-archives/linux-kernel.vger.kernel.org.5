Return-Path: <linux-kernel+bounces-161577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229988B4DEF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64E47B208D5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 21:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60639B651;
	Sun, 28 Apr 2024 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="P/R5cP0R"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDBF9479;
	Sun, 28 Apr 2024 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714339965; cv=none; b=ZmODN58Eqm6o2edt96E5hYaSLzZimhGKuugfH/pMI2Jl/THRAuNeuq9sUhJCUI8mUAWfbDjTt/5nggrG2Iw6ONORHdbEzXQtI7ZmvOTQF7EdzZJ/ZLH7Tm8R7WDu2YwkW018F+e1XVfivLc80suGBHM3Cd1bG0ZC1o9k7CmXjTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714339965; c=relaxed/simple;
	bh=ZPnmk1p6M0qEwazzjNnY9eFOTykLr7n6prXwK8D8LpA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Yg3RAh04ui+kYFi0Lb5X7Wpwu+sSwMu12nR8wYrZ7+HueJxUjQVaSGgPP7GPq3rhXjpnpk2h+ycRt+eoTqdJP42CsLlJR+BFFrw0sTmzQd5bppSh/qwR+Pz/c2oSHhF967pZs8OkvE8ylbowyDb7+BGY9akBJKVj1i683dRAQyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=P/R5cP0R; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714339961;
	bh=7vFUNmaH5qvjK8tCNJjASd7Opazp5Q59Xr/okfnpVsg=;
	h=Date:From:To:Cc:Subject:From;
	b=P/R5cP0RiPtdqWvTHHqBLlMToHJQGE+ojFHa78aCNMLlXMJizAbU+JNp0vdzufZS2
	 m5Szk5hSsAcqkOvFb+KLZ/UNXcOZd7ZpyCDkFNTje0ukQiBSBpHzAFAc9XsZHqiEef
	 iWxhGQaSq7mgY2GJFtuuvkzD/zQUrlcLpeHSocNQ1pnkapS4e1w0cCgOcBZlyZbqHM
	 8DiFJ71GdATaia1rBzW4OSFO7h2MG/ZbVKt+N2OHwTjlKlz6WHT3IsRrT4CaXWjLK4
	 SI3xHPfyhnTObuQApCQdsOkx62o7CmcXA9HMsuWX49OEn0Vaqk/WaOPtYcMAOUBT+c
	 dR0wu1oqmCczg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VSKS91KHQz4wc8;
	Mon, 29 Apr 2024 07:32:41 +1000 (AEST)
Date: Mon, 29 Apr 2024 07:32:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the mediatek tree
Message-ID: <20240429073240.76ee0e8a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hxnZh.MK/Dc+PjF7wKaRuM7";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/hxnZh.MK/Dc+PjF7wKaRuM7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  244490a729c6 ("soc: mediatek: mtk-svs: Append "-thermal" to thermal zone =
names")
  a452af6b1e66 ("soc: mediatek: mtk-socinfo: depends on CONFIG_SOC_BUS")

These are commits

  7ca803b48945 ("soc: mediatek: mtk-svs: Append "-thermal" to thermal zone =
names")
  ab6cd6bb33cc ("soc: mediatek: mtk-socinfo: depends on CONFIG_SOC_BUS")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/hxnZh.MK/Dc+PjF7wKaRuM7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYuwHgACgkQAVBC80lX
0GxqNQgApCqPmkvu6am0r0FiH+BFKVcoQQGNxyURxzyAeo4PZnDBebLB9Mvl2nhJ
F6TWFrHDq3zlCEPPQnPUi0zTKyE1Eqc36Y3ldrhDVl62pP2AtMy6jlQaQTITkgX0
NH8GKmdijLB6NDqizWfflPAa5BtdihbK8OX1MDvLEuRe0w6k441kmZIcVAqRUav5
Blj5odFTmxak9XmbWh/LMCB3FVXuKEWE0ECWjdT/vojXtRNJhnbQ0TiLyXjmHKM3
JfyZ3S8/HElHVv7Omeki3xpkde1gxWtUvbGMlJn3BQ4c4or2weI3IQmtLdN8ki+p
WDuOyvqyn5qYoh+4eWQbsw2q3ogXNQ==
=GFZp
-----END PGP SIGNATURE-----

--Sig_/hxnZh.MK/Dc+PjF7wKaRuM7--

