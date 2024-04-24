Return-Path: <linux-kernel+bounces-156917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CBF8B0A50
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78491F25D21
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFCE15B14E;
	Wed, 24 Apr 2024 13:02:27 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055BA15A4B0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963746; cv=none; b=LJhDbQ6yokcn5iESblHBfM7lsBCuyGHSjI0/10pChRYSNR8NvT92R4WUDh/OcW8buHHseaXgblgnuQeJN4mYZasOBopDkF3WDe+bkeW4KJeyPzSSXbKgj7gSQI2ChTLutGbSfk0CFC7usfYGahSRTTlxoUbLYGhm614hyvXky/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963746; c=relaxed/simple;
	bh=uqBPJXZAh04rqGXD0PZU8isT/gSoQ/wt3FrRsND6xQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yesz9dJRl17ICT/2FSMh/OSp0DWmsiRJaxzVeYCt4p28LHiCJDl0MRYJguXpKbT0XYIqhu+SUbXMcmSQk743I6Qj1GWQ+wFf4CTx+5xI2abvmabHOIXf1fB9W20MyI+vKX1D+lyxBNDp09sCBNT8eOMVv63NKua6DLw66BPxkws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rzcFy-0001oF-R5; Wed, 24 Apr 2024 15:01:50 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rzcFx-00E5DW-7Q; Wed, 24 Apr 2024 15:01:49 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C21922BEECB;
	Wed, 24 Apr 2024 13:01:48 +0000 (UTC)
Date: Wed, 24 Apr 2024 15:01:48 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux@ew.tq-group.com, alexander.stein@ew.tq-group.com
Subject: Re: [PATCH 3/4] can: mcp251xfd: add gpio functionality
Message-ID: <20240424-furry-thankful-spoonbill-f81aef-mkl@pengutronix.de>
References: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
 <20240417-mcp251xfd-gpio-feature-v1-3-bc0c61fd0c80@ew.tq-group.com>
 <20240424-notorious-roadrunner-of-will-0c55ce-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hkahiuhwj5ncu3b7"
Content-Disposition: inline
In-Reply-To: <20240424-notorious-roadrunner-of-will-0c55ce-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--hkahiuhwj5ncu3b7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.04.2024 11:35:59, Marc Kleine-Budde wrote:
> On 17.04.2024 15:43:56, Gregor Herburger wrote:
> > The mcp251xfd devices allow two pins to be configured as gpio. Add this
> > functionality to driver.
> >=20
> > Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
> > ---
> >  drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c   | 138 +++++++++++++++=
+++++++-
> >  drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c |  21 +++-
> >  drivers/net/can/spi/mcp251xfd/mcp251xfd.h        |   4 +
> >  3 files changed, 159 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/n=
et/can/spi/mcp251xfd/mcp251xfd-core.c
> > index eb699288c076..5ba9fd0af4b6 100644
> > --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> > +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>=20
> [...]
>=20
> > +static int mcp251fdx_gpio_setup(struct mcp251xfd_priv *priv)
> > +{
> > +	struct gpio_chip *gc =3D &priv->gc;
> > +
> > +	if (!device_property_present(&priv->spi->dev, "gpio-controller"))
> > +		return 0;
> > +
> > +	if (priv->rx_int)
> > +		return dev_err_probe(&priv->spi->dev, -EINVAL,
> > +				     "Can't configure gpio-controller with RX-INT!\n");
>=20
> Can you enhance the DT binding to reflect this?

Another option would be to check if RX-INT is configured in the
mcp251xfd_gpio_request() callback and refuse to request GPIO1.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hkahiuhwj5ncu3b7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYpArgACgkQKDiiPnot
vG9Qrwf+MC3fxTpuFuYhxdeMKnLBe4GeqI7Ukdw7V+9BbV5GfiEdmvnxAE9QcGw7
LawE07SY/9NKHUDacc+ymOIQUorFQglXuCFfw5lo4wGBPyamQRpypmSEnXguPuZ2
dODWx90yCpwB2ZWi0yfMl3FhvxGXi7ZReTx453irHPXzEhxbL1aDEctXdc6o675G
g7hQtz+r+bNeEXNazqpTPePMeRBF7eNyFT8NyLRLw1Zm7qeOCB72+VrhM8/sKUXM
doOtEa2iQgX0pGFYMkW0LphSKJEvGDmUNGcsWAWQdhWgek21oZhTqmK8mbNj/cB8
GmkrWvV4wDvFCveyv1S/+aORzjAuww==
=nnGt
-----END PGP SIGNATURE-----

--hkahiuhwj5ncu3b7--

