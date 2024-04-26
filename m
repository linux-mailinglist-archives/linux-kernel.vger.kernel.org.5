Return-Path: <linux-kernel+bounces-160623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D8B8B4034
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC39285D83
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36F41BC31;
	Fri, 26 Apr 2024 19:40:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1FA21101
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714160449; cv=none; b=q9YlnTuXpeTur32uCBTp7gtfYlj4+uTGub47GM+AL394g/EKS5HngEHePObllz+K5lTE2iz4tpfPdn8O4baf9eWNpWPb6m4pk0/IWPbxTNZruJmmNSuOwt0t3qEho0e0LgegxSe1vQVvMltrBl29UKMZVGUoVBM6X0baLw1PlI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714160449; c=relaxed/simple;
	bh=MJhoBOcKvcAfCqXZ27Dow0kPxI2bLjrCHZ1BhmTfiUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxfotZBAk0dWFsiaQBtbjEfNZiwePLuyhuxkhiljIkAoZZ5DrDWYuLb9+TfWU7iFvJgmmMkpjpke9nRKupn7b6tVvwSH2rvVxsGtGFw//eb+RQnCMY7kLB/MchP3fKhFZZsmY1zaBkd4BOOr6eMtuS88h21Gg/ekM541SF+n0pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s0RQo-0006P0-27; Fri, 26 Apr 2024 21:40:26 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s0RQn-00EV0n-4J; Fri, 26 Apr 2024 21:40:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s0RQn-009ZX2-08;
	Fri, 26 Apr 2024 21:40:25 +0200
Date: Fri, 26 Apr 2024 21:40:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, linux-kernel@vger.kernel.org, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 00/49] ARM: dts: imx: Use #pwm-cells = <3> for
 imx27-pwm device
Message-ID: <oy4mnbkskyrw5dwkq3rebe2yh4i3fy44rubhvesug7pedzws46@472pzktn5t22>
References: <cover.1712352665.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6qlyaxmagn4lyfzd"
Content-Disposition: inline
In-Reply-To: <cover.1712352665.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--6qlyaxmagn4lyfzd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Apr 05, 2024 at 11:41:47PM +0200, Uwe Kleine-K=F6nig wrote:
> this series addresses many warnings of the type:
>=20
> 	arch/arm/boot/dts/nxp/imx/imx6ul-pico-dwarf.dtb: pwm@2088000: #pwm-cells=
:0:0: 3 was expected
> 	        from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
>=20
> that is emitted when building with CHECK_DTBS=3D1.
>=20
> This completes the conversion started with
>=20
> 	fa28d8212ede ("ARM: dts: imx: default to #pwm-cells =3D <3> in the SoC d=
tsi files")
> 	4c6f19ab2aed ("dt-bindings: pwm: imx-pwm: Unify #pwm-cells for all compa=
tibles")

Gentle ping! I would expect that Shawn picks up this series.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6qlyaxmagn4lyfzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYsAycACgkQj4D7WH0S
/k76+gf/RTd50w5R0hfdfG8xkZOBeH3rPK6SXQs8zpgJ+/lgFxqquJi95MpCrQiG
3JRo4kCmPkPbUNjhTGORzRBeh9Gi8uI7FZ1TFEMgiytsVDuJV/lC/CbWAhI/BebL
N+vBHG3188lpfsfzgbuUnCQk1TxLEeyWrdV/sG5pGR1JaalCudQxwTVODqvRX8T3
qiuNqZmHG3HWkGVZ21ibdkdfVcArWphKeB2GUpss3MQJDNR8zYPkMgFYWYy3TYie
ic2z6+LEP/9IA2E5eKz6prVC/zgOjsUMktzs5aNy01uRxiUe1iQ3IPhPuBu/qner
qlkpR97+TFM8ZGuypO4fRp0bVIG3Aw==
=sPqb
-----END PGP SIGNATURE-----

--6qlyaxmagn4lyfzd--

