Return-Path: <linux-kernel+bounces-120735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E215F88DC52
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD71297603
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF275823E;
	Wed, 27 Mar 2024 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ok57HALR"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2052C57886;
	Wed, 27 Mar 2024 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538313; cv=none; b=kOp5AwemzWvmuNDT8RKk2QwPavxXjNNTrTcY+FnE4NlTSyza6Jhjum+XpofELxy6rC4TZxBUFloRICu/Zt+H7VI9p/K2pW7EKknvWUgVBXrVzGveaMnbamHmAbMuwXquYEjF4TpPFTRqlQ+/+1DzHkseUcEQ7J9P9s2A9uUZ0JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538313; c=relaxed/simple;
	bh=857XIbm+dBtYx+azNOPaEgZO5Otnm+2gXGdgvodYFmM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSFTJqxvU6NK2Re0CQa3ijSD+xnAV4VjaghI90TCYzqM8sjeCJO0rW6YzYFc55T8U5yCpGrbnI1okb8alPg+kwhj6+HCznabpxxYIB/zRX2XJ0AhI5GqJIXDWlwjjubF4/41ShZxk6Xr0aeL5rfUmaCRN/vtakRC0kb/iFDxt88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Ok57HALR; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711538305;
	bh=3b4+lDUAgwxcE9+OmKeYfr633gqsoMmPHQQbblduUkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ok57HALRilWsxjoaij7FOScwP+nMWlgCwR18YXfRrN+BBRNhlpk1R6EUL24OdN9c+
	 iDCEIIXX14rNHTxId0RNjieQ111tRUh5DoYSMkBcz7zhu+5aMVGbJs/PVtwQGSFyum
	 c3lpmxcxwrvVffs+Ao2AV0YR6IkU0Sm3Bk//hkSodoFV8La4Tyl+0L3AxNowzGOsPL
	 R9qrPs8nQieQFgBNU7hO5zQ6ierENk3S18DuImO0lbVGSfddQWxJFsljVNoa+pfOtI
	 HZkLzYsIZw/8VLeN9qHwmwSCIZN4oaTL7jkdud9ZadEHNiAjlwyXhnu5fCAr69GTcU
	 k9L3JrW0veS1w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V4PL76M0Wz4wc1;
	Wed, 27 Mar 2024 22:18:23 +1100 (AEDT)
Date: Wed, 27 Mar 2024 22:18:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens
 Wiklander <jens.wiklander@linaro.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Richard Weinberger <richard@nod.at>, Theodore Ts'o
 <tytso@mit.edu>, Tyler Hicks <code@tyhicks.com>
Subject: Re: linux-next: trees being removed
Message-ID: <20240327221819.70455754@canb.auug.org.au>
In-Reply-To: <20240327100421604167cd@mail.local>
References: <20240327101309.4e7d04f3@canb.auug.org.au>
	<20240327041653.GA35281@sol.localdomain>
	<20240327100421604167cd@mail.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sL37me8E9j/Z6=kj_KvJA9z";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/sL37me8E9j/Z6=kj_KvJA9z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Wed, 27 Mar 2024 11:04:21 +0100 Alexandre Belloni <alexandre.belloni@boo=
tlin.com> wrote:
>
> This is exactly my case. I don't mind my branch being dropped and I can
> ask to add it back once I have urgent fixes.

Or you could just update it to -rc1 every merge window or so and it
will hang around.  I don't mind keeping branches around that will get
used sometime.  I just don't like them being too old.

--=20
Cheers,
Stephen Rothwell

--Sig_/sL37me8E9j/Z6=kj_KvJA9z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYEAHsACgkQAVBC80lX
0GxZCAf+PQzzvZqtoMmXdZzkUDjyHqbeQuWCYrWBhFKU0nPV8e+C/rRzIaBTGkNw
V/7gS0AQbhmD023TnB64eOjbdoptE60xEDxN02NCYlPRtK22NB+vy1dxcTO22zos
YiZmS16zDx3JIO0AjQEhXtMW5w8xNif9inkdJUHStkbNdZ7Yxrul9gZGu3nJ3P1P
/nJM+zbIf2KrXoF4vnuiiRrXAKs1XHz1DF3evsS7gSN8uhVrtxgAk/wSlVZPGl+7
RLSnocTdyOx3gx1lz9txW8pv/ozGTYYDBoti1pJSEZ0pA71bGW5T77ielXoWsQUH
zg0RXoDrWCpYrh464/72hUO9j4VmjA==
=bmXm
-----END PGP SIGNATURE-----

--Sig_/sL37me8E9j/Z6=kj_KvJA9z--

