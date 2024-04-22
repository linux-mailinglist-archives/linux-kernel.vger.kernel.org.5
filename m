Return-Path: <linux-kernel+bounces-154184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 939918AD8F2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1C01C21250
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2443D577;
	Mon, 22 Apr 2024 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ei5jxWzT"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6641E38DF7;
	Mon, 22 Apr 2024 23:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713827856; cv=none; b=ZyH4Upzb4C519kapICt/XzHAL90AUVd1ySmNximB8Ugq8DGsBDBjvNdruMdfnphXHtlSXJ2bK1QVa36gf4+87FxyJ3SUIZ2czHYtkn2P1P/+AbPXu8DqGv1QEHxwst/X/Rd/pGX+obz94Mk4XlT8BYtxIgB6FtcU6auTlmllZoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713827856; c=relaxed/simple;
	bh=8nJpvhbrcJJpbAUqrHVZxYMJJ/a4d5maIfPCRG/1m04=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgK3pqvtDtkJNpha/02buO4ec0pabn/Nzi6DCgZwYWNJFyKdW1eys6B0qmOd4/NzblQe+vuHbwqwy7nf/XsyrmgTnjlYIusas4B0jE64mEeRSNM8wsg5euJr+5xQyXhu1BkRq+VVcV4XPSDIdhd6l0aFzAcZSQCEhbBPoBR6Jqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Ei5jxWzT; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713827849;
	bh=dM7iOGA9UgN3baBPbxQ5HGaKpvKJP8/LN7oUAZBCCog=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ei5jxWzTlHGbV4ARjGsTa4pfGnZbeBTP6nyG6gFGzBPS5HFf8EjFYBXZPtxCDBwRd
	 rgtTHG5Ed0c1bgHsgNq1wLfW8hBrbjiZ2d2WtT+fv2KI/YMiIaTZlkoBXotm63Un+P
	 Jv5r+tnEqzgCqgYZPzcg3cViZcCnkZdEzkgoCDdE2mOTMYOGCTakFLW2tIiJ9G22Jg
	 aqv9IkvWwAc/Koe69mcjqTM6Pq2UvA9+AoqxXteHYyic9X0KlWGzcyRb1bxSNwUcpH
	 zR77j0KE0BXoymXm8ZfMBIpqYw7pPZwEnz0nQ27e88gzhN2M7eNsFAI+X3FfStep3s
	 mVecOeFpDxshQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNh3r6mJ2z4wyw;
	Tue, 23 Apr 2024 09:17:28 +1000 (AEST)
Date: Tue, 23 Apr 2024 09:17:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the
 i2c-host-fixes tree
Message-ID: <20240423091728.06d9ad30@canb.auug.org.au>
In-Reply-To: <20240423083145.771dddf5@canb.auug.org.au>
References: <20240423083145.771dddf5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TAZ9T7NAtKue6ZV6mKyBPQH";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/TAZ9T7NAtKue6ZV6mKyBPQH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 23 Apr 2024 08:31:45 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Commit
>=20
>   86eb98127332 ("gpio: pca953x: move suspend()/resume() to suspend_noirq(=
)/resume_noirq()")
>=20
> is missing a Signed-off-by from its committer.

That commit is also (still) in the i2c-host tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/TAZ9T7NAtKue6ZV6mKyBPQH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYm8AgACgkQAVBC80lX
0GwWTgf+K8o9FRkHsOcgdaU4c6BUJ1rxTU7TY9M3tqxaUz72tPF+hTzq76p4PDOE
2P5azOyDcHojFSz1d6ty3KK294JLG1d4avnHvhiy8+G/xXWDpOjdyw9cYDry+zly
0UD1ITMp75+KzL4Pv4T8mV4XAkbqUMavn5faLI5Ui+G2mBkvz4ETEjYRhxLu0kKm
Wu2RlHkEvxg3Z66+CLwyC+b9EmWzcdImrqKfO7b20A0d/6gIRAPUb1o3LbWaUHlA
VLfzNSlwsZwgl688/Ak4B8KezqtB2xtifUz/vWOQZ9bpJIYuOgTZ85XbSQiEoEob
/CpLNGfOeG/+GGjjM+n+cM1RI5bm9Q==
=m9XF
-----END PGP SIGNATURE-----

--Sig_/TAZ9T7NAtKue6ZV6mKyBPQH--

