Return-Path: <linux-kernel+bounces-2210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E40C815967
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC403285545
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AC62D7A9;
	Sat, 16 Dec 2023 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="FD7PIG/G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622EB2C689;
	Sat, 16 Dec 2023 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4A2C31C006F; Sat, 16 Dec 2023 14:41:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1702734112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BgMsN1biGu/uFmRdF0ibs4TygbgTZcD1Mneah8GaJec=;
	b=FD7PIG/GMmrr6sEEx68BXNBbU5WwLV1sXNuNvGW5W2fZ37Bl55cTOJhzkmjdTbP9b/U/2P
	c9sj+tgynD7Z2E/bgoGXNCMd9rpetG9tCKIkC5X8eDD12hRa/u9YSezuUoOialK5J+yY3P
	P+83awOu1uCyR4sHWvqoqWm24ydJnYw=
Date: Sat, 16 Dec 2023 14:41:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Rob Herring <robh@kernel.org>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] media: i2c: gc2145: Galaxy Core GC2145 sensor
 support
Message-ID: <ZX2pH0x9F54H4dZC@duo.ucw.cz>
References: <20231107081345.3172392-1-alain.volmat@foss.st.com>
 <20231107081345.3172392-4-alain.volmat@foss.st.com>
 <ZU/UX9Jjk288ELUx@duo.ucw.cz>
 <20231117090206.GB523678@gnbcxd0016.gnb.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3H7R7gYAsvJeThcu"
Content-Disposition: inline
In-Reply-To: <20231117090206.GB523678@gnbcxd0016.gnb.st.com>


--3H7R7gYAsvJeThcu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > So ... the hardware can do 10bit ADC, but we don't actually have a
> > mode exposing that?
>=20
> We don't have YET (in the driver).  Choice is to have this first serie
> with only non-RAW modes.  RAW8/10 will be added later on.

Thanks for all the fixes and all the work you are putting to this.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--3H7R7gYAsvJeThcu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZX2pHwAKCRAw5/Bqldv6
8tJQAKCqtUiE9H4+otD7/eLG8mlz2lGzyACgrlmfpH89ogEtxPilRGFAvO/NwwY=
=1V8U
-----END PGP SIGNATURE-----

--3H7R7gYAsvJeThcu--

