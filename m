Return-Path: <linux-kernel+bounces-136002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD35A89CEC9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1C71C21B90
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC434143890;
	Mon,  8 Apr 2024 23:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GVL4w96y"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4E91DA5E;
	Mon,  8 Apr 2024 23:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618076; cv=none; b=Hagv1YytAAB/55oPcjun/PgMFJG1fjjrXr/1I3W+FERICrMCLRwdOKjOQbecWFq01afmMy12FNaP58TonmkDPGIDOS+u0/fdllx/bWWLfMUrp1Q1UeINma+XHDBfmnbR0eGOcetXjA8SaEriBsZ73wEGUlknuOd634VFHccP8Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618076; c=relaxed/simple;
	bh=FDPOLLul9t53eoBhf29kEeWojpwbqSprCfaMpH11vWg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DdNhFjWZmX1I5JJxFKLZphFjRZJI6BE8qyc3HNCTu5qqtgWVJ+9NZmgFzfCF+Uo8P6X/LeMjy+OUafiowl5ezFP8ARUopddYWXVRwy813tpRWuNiOMuKhdhdJC00Z0Z1M1wwm4dgZEQ9+A64AUvp3Ks2Ir+yNXg2ngRQu7dAlUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=GVL4w96y; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712618071;
	bh=9cKGJHHepbhqn5UrZqKQ+GT4rv/lUoNsflOiJ+XllrU=;
	h=Date:From:To:Cc:Subject:From;
	b=GVL4w96yXTgfFLFZ8OzXF5s/rVTBMnXRXgoeQrC0Vk3KF67bauM7xOqOjjPnLsrxJ
	 6lwLSrO8mpibAB8xFQuGQgKNHB/Erzu/IfQoCTkK6qh/MqdvFwbxYh+mG+5ZzCBLbd
	 DyPs5MFfBfevjD88sFz7YMm+nY3RmMNlNzBlcGRbGrc37p3GL1NpIt95ZPEEdGcHj8
	 WhG3bUuT77DD2ufbg9dQF1s7smXd2Y7CmEW0feQUl+f5PIZyRe7y2gTsSrVd+LQVHS
	 eDIEPOAJupGgCrTFMjcUZ2kV8wFG7rH1mSVps4hjfOVhvdi+B0yA5YGtNgJNPOoEI3
	 q0SXAYgGujbnA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VD4fv27Fqz4wqM;
	Tue,  9 Apr 2024 09:14:31 +1000 (AEST)
Date: Tue, 9 Apr 2024 09:14:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the rcu tree
Message-ID: <20240409091430.2e93bafa@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jIKiHwxubISuBMe/pX5VjP1";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/jIKiHwxubISuBMe/pX5VjP1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  f994a33cbc33 ("rcu: Do not release a wait-head from a GP kthread")

Fixes tag

  Fixes: 05a10b921000 ("rcu: Support direct wake-up of synchronize_rcu() us=
ers")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 667a5ebff394 ("rcu: Support direct wake-up of synchronize_rcu() user=
s")

--=20
Cheers,
Stephen Rothwell

--Sig_/jIKiHwxubISuBMe/pX5VjP1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYUelYACgkQAVBC80lX
0GzmFwgAn9LwUUt2R9UAFERbRJbEwZhqnB/K9IXHvGCcax/PxsKqZITSk6j/RJ9A
7Q9Xt7OeZY+9WVgSYQD0oe9tTm0Ry0O972uGZ+kGAkmTDuvL+bJwHw/TfVu0y/gK
JZcqTE1+Clp+6JW363/l2s+n1DotcwMwQK7YmQpzHFJDfXg3LNOponWcP79INxP/
1JYB6OvmIUgcxSZ5qISg8LZYvdkDWZ/LnmrltxIN8x5h6mZV6Gv2ujP13mqBvLzH
yUMt0K+C/v6xAcgCdhgi+vQ8kwQJXY+7P+DwZvaHSVAG/WTgR4hEqIwmgsN+depA
+AECB8ztg83Npv9PvRANP7Z5HPLyfQ==
=DD5T
-----END PGP SIGNATURE-----

--Sig_/jIKiHwxubISuBMe/pX5VjP1--

