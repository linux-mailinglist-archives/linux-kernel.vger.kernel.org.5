Return-Path: <linux-kernel+bounces-80304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D164862D21
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E24D1C212EF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9705F1B966;
	Sun, 25 Feb 2024 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MYWCgT6u"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF340199B8;
	Sun, 25 Feb 2024 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708896186; cv=none; b=rxxSe+lO/FLMbuNqAoyGz1nJeSkls57ZDeJ6M+7iJxojh81XLjpoajjZq05M7K/EXUNq5CdvTvGly3Bl2F5WL763damT3ED5Xyb1pkR/TH5aduwvQD6/qOMcPpeCVaIURFfTP0xGy9fkOqMlZnb/FewhZYlBMQVh+xyOPIoY6gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708896186; c=relaxed/simple;
	bh=UJESa6nXsG5fKadRTfGrJMPoVGOOHVPhoJw9wam7syc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bz8A0suNf6DMUgfBx1iEDboZvqCZtQcl9CcKjxyHDsAj/sSIBYRT7HWkEvih4JS2sVW+s0E5ua5v+/uul11januxySp0tTtrb4nsSdTUIE7rrCO0qoDHqw1gM9p1DiY7bOFZiYp3/xwMbfgpyu2nk2Iyoa7SuKxfJ6CtOaTDE60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=MYWCgT6u; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708896182;
	bh=t4chhhaRRYfLEcO/AqGAKRoWv4Qt5yAuFWUhU6ico7s=;
	h=Date:From:To:Cc:Subject:From;
	b=MYWCgT6uIb4dHhczzwDizDI+YrEUNKofXBSzJp6yUSoOo6/IkPGpkL/ClvXRQYZTm
	 q5UInp1A+qvFVxXLvfQczcwYsy2ii8pDMPGlxOZm+6E1rHjxhtd/1bywFxg3w1211u
	 +3hARKzGLcgOyDSGRILDtUrVp2vdQl1yfsiqAdr/VEzdYoDl+fFGMPNR465O7ktPR7
	 bYnIVqMgqwW1ZX//cIsZXWqMQD8dXzZsM4jKaQ6hLtc8s6ydf9ropJJ+vPSlXHBKx8
	 DvaAy4kMa/104Kh3AY386vpyGZoKQHmjUX9M9DCd2CY4C9RD3K+GSOIFY3C8R2u5U7
	 Ybgxa87o+TYJg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TjcD65tgKz4wcD;
	Mon, 26 Feb 2024 08:23:02 +1100 (AEDT)
Date: Mon, 26 Feb 2024 08:23:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the imx-mxs tree
Message-ID: <20240226082301.245a91e3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uRIhJ_PhZsxgTkDOh4Nf=uH";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/uRIhJ_PhZsxgTkDOh4Nf=uH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  35eb2b23824e ("ARM: dts: ls1021a: Enable usb3-lpm-capable for usb3 node")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/uRIhJ_PhZsxgTkDOh4Nf=uH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXbr7UACgkQAVBC80lX
0GxVFwf/VqtVRJgM4MNWFiJFKYyg+cKkRAAUD/Svuj1CYVTll5wpgR+8QcfGLT9V
RxDwCY/JDDt65Fq5f32tiVyCKSIRRhvs94yL3jQJQ/Zbkm6eBmcgBNTeACg9o5Tp
jvPVADS/Sd6OiKNd4+TPtdcdAv3i4xa/lCziKEsOBMc/SAcJDM7hc3JSknIOiKon
pumEb2evek3T7HxvZlGHaln0mlmUtKqw/H7Hn8zGihMcAcYMeNASbUlKHOmjIiZ5
kdJXCNliV7ZYUHa8J8zPEfnQFrnG3MGYxghdDNlH7+uC8lz3Djy14ErbDdkDYu4D
OZUzVZiUSpAqsdRTrIx/ybg53C7dwQ==
=u0r6
-----END PGP SIGNATURE-----

--Sig_/uRIhJ_PhZsxgTkDOh4Nf=uH--

