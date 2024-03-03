Return-Path: <linux-kernel+bounces-89926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6099E86F75F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC9F3B20E5F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13377A722;
	Sun,  3 Mar 2024 22:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WrIJgpn9"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6584443AB5;
	Sun,  3 Mar 2024 22:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709504142; cv=none; b=oyTThZ/oCLaWURYXriJDngiZX6/VHBdCbD1Xg9Me4mzdbhSd5MgCPvLYeasTJVsxeMlajeCuU97czOAGYMMxwlX2yPdQNd4KnveINcfNBS9zj3Rtk1ZmWpr52VRPkaPQl+4+r10CKVlPRjFCmM4HGqBEDohpmnAL8YBUmU38pSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709504142; c=relaxed/simple;
	bh=KTJAW6LSdqsWVQfvDedPpfnIsnYJ55+Ud7MpPP7KkG4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=retTr1qjMszc3hLo/B6iLKhcayp7dYWipGFwYajBA0JBg2XCa5f/r59FjpXFxAe3DSDQrwKcQOsgA/CddWRuBAmchC8ZhVhx481XKOhsNXTGVBwBzevTiIsQGzw6Mcxc/vRr72Y1xNDr+PHm7ZKLzx2FYOcmN5K/OQKB7QNRwq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=WrIJgpn9; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709504135;
	bh=4SEod+byyxyxkR0LTzbeCkpBSmma0XbPMOgDnKncmJU=;
	h=Date:From:To:Cc:Subject:From;
	b=WrIJgpn9yIZE8S+U6s2Itt6QiOqW0ALS0E6WtuVRgnBnRdS+kVYrr71paOghIsoM0
	 dayqvQrZtWtuXueNP35kXtcoY5+A6zsLgGq14vPZC6EXJIAaTQubJTpK8GnHzsBgEE
	 2TkAOHLCARUK6nwBQ6N7kDwOYeKOVI4FA5l8rI4cWc9jdGIA8DpzOsvsFXwvLkeeiT
	 p5VZqmyfVHrS094kAdHUqlYwTJiW6Z/AN6VwQGfE+mK9TXBFjRH6hFSpG4QAGardqn
	 BZ2d4d+TfMQg1VED4IlZ9ZQyW7qjWk7OZp3zi2IZb7JzIIyzmqzRZcEgiD70I+0S6Q
	 8G1gGub2zoEnA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tnx3W32Xpz4wcD;
	Mon,  4 Mar 2024 09:15:35 +1100 (AEDT)
Date: Mon, 4 Mar 2024 09:15:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alasdair G Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the device-mapper
 tree
Message-ID: <20240304091533.7e607cfc@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+2nmjBaXQDGLPC4veP73I49";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/+2nmjBaXQDGLPC4veP73I49
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  dcd55a48adf1 ("dm vdo: remove internal ticket references from vdo")
  e52b963063a7 ("dm vdo: remove internal ticket references from indexer")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/+2nmjBaXQDGLPC4veP73I49
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXk9oUACgkQAVBC80lX
0Gxs0gf/ddREa5+dGNasOdy7+fUZROX3ogXbCBGbMY/ALHRHw8kYBLrZjnyCZIPN
NYL1ijRBcu5zMdk1weXrvs+Gq9mkpu6y7CPh4oxqCfxNVoEuS1Aqr+7upUZcBkYt
WUvodoU18zUERXTBm0l0P4wK506PZENuWF7mDBnKCtuv6W1uxJ4MeMp+QUJq9FrY
LEoFmxV4ToZyHlVqnmKFw5JfZudCjoi8pPuLGBRq5EvsWAZHwQQkOtZDY12EIoAQ
2WJE5KXLRcHqAgvL7RRTNKQw9vecXC1lv12i7AuAiUiFwQKQpZFeFUrA71Lm0XwJ
fb/d63XYS/xQwXV9ecER6ErMKfd18w==
=p944
-----END PGP SIGNATURE-----

--Sig_/+2nmjBaXQDGLPC4veP73I49--

