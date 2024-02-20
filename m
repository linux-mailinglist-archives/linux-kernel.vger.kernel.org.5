Return-Path: <linux-kernel+bounces-72590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0A485B5A5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16878285840
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D975D735;
	Tue, 20 Feb 2024 08:42:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BE25D462
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418552; cv=none; b=HImMGxwRdtIb9BXq+FV6iJ1k2s51FnKrng7da3p8NECEb8T33qGAxtLtEjzKm4Dl5NYVw46rPgjc/YC3x47ialtp3kjasA4HCNzdZkd6Yywk70S487MHHeFjxAz1gTym7Ch1lk9m4B+EKQbitlzcuk+Aih4aEbYTFw3KIlGgVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418552; c=relaxed/simple;
	bh=5i2yVe3YvLkbc1bjl/rywBySn9/ebqlo3gBQ6m35U8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O46Nzo1xLazDjSdKmPBg3yR9YsJLSLwpMK2dx7vJWkwM+t6dJAXTAhW4tGFuiMAqOgzhGEfP8jnukflRo8skDh7jhduDyvLh8F0YDTOU9slEA6yvzBHZi8TeKbbboRJS8VBZpMPWe1QyTN0T4cQ6w4FubLVIEQJ6jmP2wy3j7Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLhn-0000H0-23; Tue, 20 Feb 2024 09:42:23 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLhm-001oB5-CU; Tue, 20 Feb 2024 09:42:22 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0A7C1292ECA;
	Tue, 20 Feb 2024 08:42:22 +0000 (UTC)
Date: Tue, 20 Feb 2024 09:42:21 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <vincent.mailhol@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: raw: raw_getsockopt(): reduce scope of err
Message-ID: <20240220-tremor-suspend-36bc012b061c-mkl@pengutronix.de>
References: <20240220-raw-setsockopt-v1-1-7d34cb1377fc@pengutronix.de>
 <CAMZ6RqKPUUrgfVpdu4y=mGUFjNTbfH7q46ZwcMwOn6zEwfHnZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g4vopqhpjlyktekh"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqKPUUrgfVpdu4y=mGUFjNTbfH7q46ZwcMwOn6zEwfHnZg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--g4vopqhpjlyktekh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.02.2024 17:27:05, Vincent Mailhol wrote:
> On Tue. 20 Feb. 2024 at 17:16, Marc Kleine-Budde <mkl@pengutronix.de> wro=
te:
> > Reduce the scope of the variable "err" to the individual cases. This
> > is to avoid the mistake of setting "err" in the mistaken belief that
> > it will be evaluated later.
> >
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> One nitpick to remove a newline, but aside from that:
>=20
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>=20
> (as usual, I do not mind if the nitpick gets resolved while applying).

Thanks for the review, fixed that while applying.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--g4vopqhpjlyktekh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXUZeoACgkQKDiiPnot
vG/JKwf9Fjdu8IgIhXwRaJizysOl76e9n79st3d0kq2yQau5Hlgw6sjOW2IoGlkS
TAk1YnxkerpQSjjJ1i550qZ+kmAXFPl8Lp3DHfddcIciQYqiTxUc0iTGo/XxEQRv
hxPguYeMJAsYFEqh5lGXCjxcm3sbIzkUZ5Lb2lbAPukVLa9w9gYeO4dYl+EwUwam
RWlIAeOOfjOo0QCUTauv/o4P6dwjuV5dzZCI1lv/DD5G76fCblJYnIwsmoyMKrgz
NFeNLpixKfv0vAPrvl67GvuJEw0YGWJJMFbu2K9i/Pu6+2BIprqPgRwB7PA5yJES
GBx7BoEa5YKFglY59+KRtBNthNfX4w==
=boQJ
-----END PGP SIGNATURE-----

--g4vopqhpjlyktekh--

