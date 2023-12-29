Return-Path: <linux-kernel+bounces-13151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5703A820064
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D55F1F21FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96FD125C4;
	Fri, 29 Dec 2023 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="jxp6LpTG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F44125A4;
	Fri, 29 Dec 2023 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4717D1C0050; Fri, 29 Dec 2023 16:41:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1703864497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BxMs/kzpNymFcmFDEtEcM/zevTNnwByTQvgBKVE7D2M=;
	b=jxp6LpTGOCf7KbPks0fFRUE4SxYKGccEBysv8LdiWscTakaMIDroi4NHwDf2w8FFI4yZSH
	zMZxVMfNMo/K702IKJ7WATTW0SME1RU5olqaoY2WvQ5OKirPl4gsVbU7fLyT5U5uiJIyFZ
	9IGs38AK0VzLZzsknjen+w7pz2a/+CU=
Date: Fri, 29 Dec 2023 16:41:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Chris Rankin <rankincj@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: Does Linux still support UP?
Message-ID: <ZY7omD5OBLUg6pyx@duo.ucw.cz>
References: <CAK2bqVKCdaD6-PZi6gXhf=9CiKGhxQM_UHyKV_onzDPnhbAmvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="70EgRxlTRoKgOZlJ"
Content-Disposition: inline
In-Reply-To: <CAK2bqVKCdaD6-PZi6gXhf=9CiKGhxQM_UHyKV_onzDPnhbAmvw@mail.gmail.com>


--70EgRxlTRoKgOZlJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I have an ancient i586 UP machine that happily runs vanilla Linux
> 6.4.16, but which locks up shortly after booting vanilla 6.5.0. The
> kernel *seems* to run into trouble as soon as the networking layer
> becomes busy. However, its SysRq-S/U/B sequence still seems to work as
> expected and so obviously *something* is still responding somewhere.
>=20
> This problem still exists in vanilla 6.6.8.
>=20
> FWIW I have raised this bug in bugzilla:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218296

Yes, UP should still work. I'm using such machine and intend to
continue with that. But it seems more testing would be welcome.

And yes, you'll likely need to bisect.

Best regards,
								Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--70EgRxlTRoKgOZlJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZY7orwAKCRAw5/Bqldv6
8todAKCibSurY7CjS6hkVxuB6tEcdKxdLACeLH+oqOiHZHCnHVi5lzu8QjNJUkA=
=41qP
-----END PGP SIGNATURE-----

--70EgRxlTRoKgOZlJ--

