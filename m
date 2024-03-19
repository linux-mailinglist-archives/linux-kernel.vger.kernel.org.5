Return-Path: <linux-kernel+bounces-107643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0615A87FF83
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7AD284631
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A2C8175E;
	Tue, 19 Mar 2024 14:25:44 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C013A45946
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710858344; cv=none; b=h6kEU4DXMwDWUWBeRYX2NlBuaPRPM0JozagrIYdM6Gj4WJA972xlTPvyoSCBuiJ//S7A6oDKDEVR4YdVeOy/P+oh3BOQv4hGnrfwPCQqiZrLNbWa/LRR5zUU9FJQCkyxwcKox5klKcPH2gNCUwqa9vSAvkf39oeC8HzddCa1wMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710858344; c=relaxed/simple;
	bh=eGwfpMd0oNEabAjNEboBF9e49KppvUpp7hnrvMiBFTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3h0g/NNkWDJcqdEfy5NxYhnbt0zkTuxNEwxvluonswMaowxo1E40jKI1XJ4oNQJHBjT6xAjHnJa8h4mSMtRjM9WDTVl3H8bd3I1GWwrIea2IQGx1rbqnsBKVEvI0c8gFcLRFhyXhHXihqXrPhFpOA6r+T3gNLqKWkDzHdKUUso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rmaP8-0005J6-K9; Tue, 19 Mar 2024 15:25:26 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rmaP6-007IDU-OJ; Tue, 19 Mar 2024 15:25:24 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5F8B22A7ABA;
	Tue, 19 Mar 2024 14:25:24 +0000 (UTC)
Date: Tue, 19 Mar 2024 15:25:24 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] can: mcp251x: Fix up includes
Message-ID: <20240319-chewing-aptitude-db56f0a3fc32-mkl@pengutronix.de>
References: <20240318193410.178163-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k3ivyy72aisdcy5u"
Content-Disposition: inline
In-Reply-To: <20240318193410.178163-1-andriy.shevchenko@linux.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--k3ivyy72aisdcy5u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.03.2024 21:34:10, Andy Shevchenko wrote:
> This driver is including the legacy GPIO header <linux/gpio.h>
> but the only thing it is using from that header is the wrong
> define for GPIOF_DIR_OUT.
>=20
> Fix it up by using GPIO_LINE_DIRECTION_* macros respectively.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

No need to resend, added to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--k3ivyy72aisdcy5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmX5oFAACgkQKDiiPnot
vG+OeQgAiQRhzAhHeegYdxVcGWd+6wrHYIv3QSMgYZRbA7op7g6PHEuVb7u/eefb
5E4hOPrkpJdjtvsPw4STB1UvC9lqbySKFRUBoijiLQBlF0c6JPhiUaBTVDbPl6Wq
hZMvhQZGctyGXeYK/MZPaij5YOA7Srcg2ohus74B8qJYq2nWSeKmHUNsAikSTr4k
6pK0rZxcICr8CmTaGnCLt1yJwOlZW0A2gK021XFSkgLd7wJ2PnDO4avoL6UjWDd3
VkpL78Y3JHbrO7JiSngQUY5ESqdS7piQArHRyzvgRsYTA2dcpddOK1nhH24vCrCa
7kUv96lZJC3+bhbkXKlT8fh7TZUErQ==
=d6sj
-----END PGP SIGNATURE-----

--k3ivyy72aisdcy5u--

