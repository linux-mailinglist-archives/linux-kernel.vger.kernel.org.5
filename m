Return-Path: <linux-kernel+bounces-130647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BB0897AEB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70181F28FDB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6E7156899;
	Wed,  3 Apr 2024 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IIXXz5q2"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD1115686D;
	Wed,  3 Apr 2024 21:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180371; cv=none; b=nCOD+P6EeIqwz6cfZAbxs1g8g+dzg4DqYN8EYUwIcFRtGVIidJLSFgfjgeAeyTNLryk/LzmEO5e2b46aKuoLH6Pcr1j5Be9SHqJ7WmLkZA83Ej6plo5xLIfB23Ee+tY6aQUNAibCaFOtyl/kT+YABnGHGDFabf/kGMoaU85nbUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180371; c=relaxed/simple;
	bh=/QWcUh5XANsoKtUj0qaRepLRL3sQazZiX/DL2WMKpyo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WW2kVpZR3+lPVr/xWhETz7tawJRQy8/18Wogdai6JEQR6+5YuzFCUIFpsSatOZ0QXU2+hlxoppsV4oxTrZbaY/xM5H9NhmzbG4c51PVVghzvb3GRtmPxVrnEU0i4XGFV+ebsdubzpPn9r0LybACxpaTkd+/SWbuLtqDZn8d7DWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=IIXXz5q2; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712180366;
	bh=puAoi+zQdGzDxsuXiBHX+BL6cz9E7JggEfajotQhffs=;
	h=Date:From:To:Cc:Subject:From;
	b=IIXXz5q2dk3YpYkJEqV/SjsLIJvmk+Ltom2COe8NmmXyLnbZFWcPfz46VNBtF70jk
	 T6o+rSCvXk8A+wb6J+MKrZE0aSSyPM4qH2dgSCSJKe/c/iyhFxfTRGjzsG/2dY9R0r
	 JOPFVWj8H+75A27jphPTcJ5gl5uWqW17IOh5YzfXd8F6Y0e02vflQnnlDCejW6x6XP
	 V2tZrhqZBtFyofUEKiBktCM+FPdz6GyTzMG6597g87V8qtlW4IO1e0WitLcH9e7Db3
	 9vWtyqM/b/CZ12lg0Oj43AKNy8tKXbmaJZLKLviMHGrVkX6kJAN8KJQiukVFdq0ngU
	 hUdq9hBBWZWSA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V8ynT6PgTz4wcd;
	Thu,  4 Apr 2024 08:39:25 +1100 (AEDT)
Date: Thu, 4 Apr 2024 08:39:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the rcu tree
Message-ID: <20240404083923.358c23da@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yH9dr5nF7bh.L8EMZcfG5qH";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/yH9dr5nF7bh.L8EMZcfG5qH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  a55be9aacc45 ("rcu: Do not release a wait-head from a GP kthread")

Fixes tag

  Fixes: 05a10b921000 ("rcu: Support direct wake-up of synchronize_rcu() us=
ers")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 654f59c6bc95 ("rcu: Support direct wake-up of synchronize_rcu() user=
s")

--=20
Cheers,
Stephen Rothwell

--Sig_/yH9dr5nF7bh.L8EMZcfG5qH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYNzIsACgkQAVBC80lX
0Gzf2Af/XKvECvyBwSuvBzYgHTZJTWhZGCmueNObB4Xvs8THRYs3eiXDeUgf/kWb
lEQwvNsrMGdVrjo/W/2M7ndXYOtvENZ0sanpH/eeV7aCJ1DxCU9qcfbbG4eMlLqE
0DmC3FsalnYafFyeCipp8vWiMDQ3yQ5ugHlIW0jcIlmWjxlm26ujtGNXOIwOJ7th
qweZrT2SAfH3EZw++c96j1wx41TO6gWivTn5NYx5cQan9Awp0AgpjAKKvyTRXLza
x580hlZCFJKOJn+3VwQch32alBWntWvmBdCQmCKRgXSCk2xrwXiUfWIURe3zpGNH
W9KwEzi6h1QgtwihetlfRnuZbaUv5g==
=qCqL
-----END PGP SIGNATURE-----

--Sig_/yH9dr5nF7bh.L8EMZcfG5qH--

