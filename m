Return-Path: <linux-kernel+bounces-165789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C403F8B91A0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012991C22A14
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E9B168B18;
	Wed,  1 May 2024 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Q1RxNljT"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD604F898;
	Wed,  1 May 2024 22:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714602245; cv=none; b=nLZet0rnvkzubiaZ32GNoXUpEs3DUhfLaak2I/5/W45sHDDbJUwEAlXa4m8LkSF0+f0Q5+ndNSmkhlmNI1G/iGza5hLtgvbjf3sf1mtk7GHj+J4IHjppsfqlzoVfxyQSrJRe1o5n52aQMrVvGuFNf5bsZ6yc8+Cy1aETMphN3Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714602245; c=relaxed/simple;
	bh=JVfcya/jKkUh7wEB6H95SPt1ZMf6hwTCE17Gjs+G9Co=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Q/1yH/towk/2RZvSg8hRNS6nQOeieWQZDt9AZA6FFMRTNKJqQH1K26OrNGN3wFae6BX8d9BBK1BvkYf9+vRVSiF6IMY4OwLJpxlMcM4ceD323Nhdy/oY4qRVf17lBcfzheGqjoeQnOMD/3Q9hg0k4HjAhaJFyahnNsFEqcH/8qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Q1RxNljT; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714602238;
	bh=u3vG1QSQ9V3HsJJru4TfRhmLRCf/1MxcaOa+LKz4MUE=;
	h=Date:From:To:Cc:Subject:From;
	b=Q1RxNljT49YNCcbrzunAHvemQfBV7vCH+gBVLXKtNO1+bMvyJEYFWmU+N38kzU8xY
	 gftN6c1Qm5FV7/ST52qtuNQge5S33Iz/qUj/99DQq8Egy87Qdj6w1Llct3tkpFGiot
	 jLiode01T+qJOBjCx3jEV9NGSkT7jbJeBB0SobkZH1sDjJnyxKd3XBCKly9h50fnQL
	 DM3HyGWAm7+EZktzV43TEsry/RYnZgvWab/ny/PknDRD9VguVFnnfVVXdZkQXrSk9x
	 ltO1A9LhZJGU39cW24bEPB8CYZCo23doJPpHuWs+UrJbVAl+jys6li3M0wj65QRmre
	 r2zZLEQPzjsrw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VVBRy2KZhz4x1R;
	Thu,  2 May 2024 08:23:57 +1000 (AEST)
Date: Thu, 2 May 2024 08:23:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mike Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the clk-fixes tree
Message-ID: <20240502082354.61d147f9@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JBjV_EQQCO5RMNVssWCU36M";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/JBjV_EQQCO5RMNVssWCU36M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the samasung-krzk-fixes tree as a different
commit (but the same patch):

  aacb99de1099 ("clk: samsung: Revert "clk: Use device_get_match_data()"")

This is commit

  da244c16ac58 ("clk: samsung: Revert "clk: Use device_get_match_data()"")

in the samasung-krzk-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/JBjV_EQQCO5RMNVssWCU36M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYywPoACgkQAVBC80lX
0GyHewf/eddND7Tg05zQ51KH40cLpijDFQGM+KtruhiEU0GQ+43WWBNJDlaQ5VaD
1rK/RgpHsBEuVqd0pD7fFQz0KHeUhu8sy9LocyBZxmd1+E6p8WHcRg3zayq2Pmp0
+nmplQBGyI5vad6RzN/3ro7LkLVygon/mUzA12gjB3COPkzRnvdPOrxTDLKDrJig
Vp8+okzBw7vmv4F5cOWLQuxsq89GxZtlnUeYOKypAbBgmmykB+Kpy2sdSTqO8JTC
vxf948czRh32fJadEfXPbJwydkSTmPc5p8Wp0nn4ZrU3EfrtOh6RKDgjqfj96a2g
1ylMTGof5dzJ7NUl+o5/c+tkWTfiMA==
=Qml7
-----END PGP SIGNATURE-----

--Sig_/JBjV_EQQCO5RMNVssWCU36M--

