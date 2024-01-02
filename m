Return-Path: <linux-kernel+bounces-14279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE93821AC7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6022830D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1397EADE;
	Tue,  2 Jan 2024 11:17:48 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5365BEACB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rKcm2-0004ep-4z; Tue, 02 Jan 2024 12:17:30 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rKclx-003AZc-Qa; Tue, 02 Jan 2024 12:17:26 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5A8D726C46C;
	Tue,  2 Jan 2024 11:13:17 +0000 (UTC)
Date: Tue, 2 Jan 2024 12:13:16 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Bhavya Kapoor <b-kapoor@ti.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr, rcsekar@samsung.com, 
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net, 
	wg@grandegger.com, vigneshr@ti.com, u-kumar1@ti.com
Subject: Re: [PATCH] net: can: Add support for aliases in CAN
Message-ID: <20240102-chop-extending-b7dc1acaf5db-mkl@pengutronix.de>
References: <20240102102949.138607-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m5nbq46hdqsfnxbd"
Content-Disposition: inline
In-Reply-To: <20240102102949.138607-1-b-kapoor@ti.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--m5nbq46hdqsfnxbd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.01.2024 15:59:49, Bhavya Kapoor wrote:
> When multiple CAN's are present, then names that are getting assigned
> changes after every boot even after providing alias in the device tree.
> Thus, Add support for implementing CAN aliasing so that names or
> alias for CAN will now be provided from device tree.

NACK, please use udev or systemd-networkd to provide stable names for
CAN interfaces.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--m5nbq46hdqsfnxbd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmWT78kACgkQvlAcSiqK
BOgKOQf/STGvc4hJisrHiFj5JiEZJ6a53OTttGK5r8lbKV2Up6Jqblt5V70pkkV8
ZSU8aM5wj8yw3XhOytAyBUYfKaTb/moFOLlbjxwBqUSOdRJBnMVvXryoBWP3s0cv
DtpTuilEYQfB85zQxn5imigbOGwQqsHBDnjYVnxp2h9qyB6jyg4nc6zVV7OcphTQ
sPR1nhOc4sPLXP286XDmnR20XF5JycyozJmrb6/XVkLhNlqhkY/t870Duh+l3OrH
LPDt+Mf3GsA7x+wBTmGIfMFWtLHvgoyuqSWSPob1EbOUsC3g1UgEZb2aIC1m9fqn
iQa/JSU3aPYkTYlHVyF2imctnAO/vg==
=rxfF
-----END PGP SIGNATURE-----

--m5nbq46hdqsfnxbd--

