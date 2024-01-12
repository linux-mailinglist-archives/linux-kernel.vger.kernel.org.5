Return-Path: <linux-kernel+bounces-24851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADCC82C369
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2D81F230A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFED745CA;
	Fri, 12 Jan 2024 16:18:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B997319F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rOKEA-0000I6-2s; Fri, 12 Jan 2024 17:17:50 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rOKE7-002Bnr-Ow; Fri, 12 Jan 2024 17:17:47 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7CBE82751CD;
	Fri, 12 Jan 2024 15:43:16 +0000 (UTC)
Date: Fri, 12 Jan 2024 16:43:16 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Bhavya Kapoor <b-kapoor@ti.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr, 
	rcsekar@samsung.com, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, 
	davem@davemloft.net, wg@grandegger.com, vigneshr@ti.com
Subject: Re: [PATCH] net: can: Add support for aliases in CAN
Message-ID: <20240112-overreact-dwindling-2949267e8a02-mkl@pengutronix.de>
References: <20240102102949.138607-1-b-kapoor@ti.com>
 <20240102-chop-extending-b7dc1acaf5db-mkl@pengutronix.de>
 <8dee1738-0bde-48fb-bd0e-b8d06b609677@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uxczuahqgymwfz6l"
Content-Disposition: inline
In-Reply-To: <8dee1738-0bde-48fb-bd0e-b8d06b609677@ti.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--uxczuahqgymwfz6l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.01.2024 20:53:32, Kumar, Udit wrote:
> Hi Marc
>=20
> On 1/2/2024 4:43 PM, Marc Kleine-Budde wrote:
> > On 02.01.2024 15:59:49, Bhavya Kapoor wrote:
> > > When multiple CAN's are present, then names that are getting assigned
> > > changes after every boot even after providing alias in the device tre=
e.
> > > Thus, Add support for implementing CAN aliasing so that names or
> > > alias for CAN will now be provided from device tree.
> > NACK, please use udev or systemd-networkd to provide stable names for
> > CAN interfaces.
>=20
> Would you like to re-consider this NACK.

This is not a CAN device specific problem. If you want to change this,
talk/convince the networking people.

> From kernel side,
>=20
> IMO if aliasing is set in device tree then kernel should provide consiste=
nt
> baseline names.
>=20
> However, distributions may choose different or other stable naming,
>=20
> Also, if some distribution want to rely on kernel naming they still can d=
o.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--uxczuahqgymwfz6l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmWhXhAACgkQvlAcSiqK
BOjD0wgAriZqvA12Vu5nzdKCKAjSH8J55u83wid8H1TFwOTI44OzbAg0a6AakQua
JRGAbYx0pivUuwNf8emVJ1FVJMxyPH1lMPwQep6ZYtTVqoWfhOFDWk2m14xBYTVj
DguY9dlaK/uBU39GBDnk3b8dMd+l6QwSDJhymFTO5P5c87YLzVlpa4FkbSVE2Atz
wQVQZdMzIUJK4FwFaymKkT2SjLsLb5kZPM8t80L7oknZruvsJKGEAm2KF9TJYnV0
fjdBgfzdbdxFrJqJEd7YSOK5aN0mv2/gyb16rpGDYRsrWmBN2sffk4kIC1TmsSwS
Do9pEjkihZ2wEpAShuxai2OdqVMBMQ==
=709B
-----END PGP SIGNATURE-----

--uxczuahqgymwfz6l--

