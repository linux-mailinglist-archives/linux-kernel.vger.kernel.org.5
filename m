Return-Path: <linux-kernel+bounces-20795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D356828552
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115001F24980
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D0538DFC;
	Tue,  9 Jan 2024 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="fjPyJqAV"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876E538FA3;
	Tue,  9 Jan 2024 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CBE311C0050; Tue,  9 Jan 2024 12:43:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1704800607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s6dd1VUvYF8UD5YULpPstc/AaxgRZ4flqa+RhS6rPe4=;
	b=fjPyJqAVo6xqsH5UpitWb1Zg2hUYlI652bTt41CVtHjnOxlvIZFUOW955nBNoqCaupzT/J
	/7ciQJWdzC0+MGrRSj1H+EwRBb6XV6nkeS5IV/U9WenvEa6F4zPbPOlh8cG1GlTSgzFHk4
	/anlSaaqHQs27A0CgPFApfpd7dZu5iE=
Date: Tue, 9 Jan 2024 12:43:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Marcus Aram <marcus+oss@oxar.nl>,
	Mark Herbert <mark.herbert42@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>, Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com, linux-gpio@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 3/6] pinctrl: amd: Mask non-wake source pins
 with interrupt enabled at suspend
Message-ID: <ZZ0xX2Mqx0ezfoWG@duo.ucw.cz>
References: <20231226002725.7471-1-sashal@kernel.org>
 <20231226002725.7471-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KeQek5G0zUyG7eGC"
Content-Disposition: inline
In-Reply-To: <20231226002725.7471-3-sashal@kernel.org>


--KeQek5G0zUyG7eGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Mario Limonciello <mario.limonciello@amd.com>
>=20
> [ Upstream commit 2fff0b5e1a6b9c577b4dd4958902c877159c856b ]
>=20
> If a pin isn't marked as a wake source processing any interrupts is
> just going to destroy battery life.  The APU may wake up from a hardware
> sleep state to process the interrupt but not return control to the OS.
>=20
> Mask interrupt for all non-wake source pins at suspend. They'll be
> re-enabled at resume.

Not sure what is going on here, but it is queued for 6.6 and 4.14, but
not for the kernels between them.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--KeQek5G0zUyG7eGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZZ0xXwAKCRAw5/Bqldv6
8o46AJ47UWWyL/XjOcQ6g0+vVK2rsBFLLwCghMnwCem9B2AE6FtzLmho8/oPrUk=
=IPT6
-----END PGP SIGNATURE-----

--KeQek5G0zUyG7eGC--

