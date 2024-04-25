Return-Path: <linux-kernel+bounces-158072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF02D8B1B11
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4851F231DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513845473A;
	Thu, 25 Apr 2024 06:29:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34B544C6E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714026577; cv=none; b=U1WwX96+zyLtPBgXic00Xbgx9QlIuP4NBhzjJW3Vo/T3/7cC57gglxdU6wYUaR07VKFGR/+o49ZqVegLzbMqhpIvdw1keePZAAiBfWThVNpWyWi9wPPLMC170nI/+ZZNofhxLCDAWXuDM8QxhI5f+4l1nlJwWN+hOpqVuDi/jcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714026577; c=relaxed/simple;
	bh=p0rpfcBvfX5VRHEn5gsxoCCeeNRXh0O+2772eFV+Sck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emmJRzRNFbyC4+zr0v+7qi7xi4axvr4nIQq/jj2Q992alUUqxdylKEXRQGe6LXa2IRfz3KxL6IWnJc4KDIdwBfXTu7cKnXCdlmhphVI5+gAphh6qVdWfje+BpHYxnNDtyVJgLNq/thf+bFXVPwJ2ku5EGYxL88zFMeTQrxVJl2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rzsbe-00029Q-C6; Thu, 25 Apr 2024 08:29:18 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rzsba-00EDHo-OY; Thu, 25 Apr 2024 08:29:14 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4CAF72BF682;
	Thu, 25 Apr 2024 06:29:14 +0000 (UTC)
Date: Thu, 25 Apr 2024 08:29:13 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux@ew.tq-group.com, alexander.stein@ew.tq-group.com
Subject: Re: [PATCH 1/4] can: mcp251xfd: stop timestamp before sending chip
 to sleep
Message-ID: <20240425-tall-quiet-wren-f00e44-mkl@pengutronix.de>
References: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
 <20240417-mcp251xfd-gpio-feature-v1-1-bc0c61fd0c80@ew.tq-group.com>
 <20240424-adaptable-zircon-badger-1fefd9-mkl@pengutronix.de>
 <ZinnV+GA20LWGUOV@herburgerg-w2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jl5hounf2hkrpaap"
Content-Disposition: inline
In-Reply-To: <ZinnV+GA20LWGUOV@herburgerg-w2>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--jl5hounf2hkrpaap
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.04.2024 07:17:11, Gregor Herburger wrote:
> On Wed, Apr 24, 2024 at 01:54:54PM +0200, Marc Kleine-Budde wrote:
> > On 17.04.2024 15:43:54, Gregor Herburger wrote:
> > > MCP2518FD exits Low-Power Mode (LPM) when CS is asserted. When chip
> > > is send to sleep and the timestamp workqueue is not stopped chip is
> > > waked by SPI transfer of mcp251xfd_timestamp_read.
> >=20
> > How does the Low-Power Mode affect the GPIO lines? Is there a difference
> > if the device is only in sleep mode?
>=20
> The MCP251XFD_REG_IOCON is cleared when leaving Low-Power Mode. This is
> why I implemented regcache.

But that means you have to power the chip if a GPIO is requested. You
have to power up the chip in the request() callback and power it down in
the free() callback.

I've 2 patches laying around, one that moves the timestamp
init/start/stop into the chip_start/stop. And another one that moves the
soft reset and basic configuration of the chip into the runtime pm
functions. I have to make both patches compatible and send them to the
list. Feel free to pick them up and integrate them into your series.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jl5hounf2hkrpaap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYp+DYACgkQKDiiPnot
vG+1vAgAl+G4ZfcqA1NGRKoDMVijFXRucCXAiJK55nBv/76cLqp/96ab3XAOeKRK
OZMN8El/e/F0nj5LbKpkITaVAtUgIikru2MVx6GxIH1dOQ4YfLqJFABHaXznIDxL
I9NcwSmkeFZyoVZy6ZmZ+AjV3IbAM+41cZBCgI41SpvzeWs38uBYt5RrB+VXrbOE
6l/O9SI8DZ5cwvqHt10SeHhrMbZ8b/n+pyXze1RBVnVrFVp0n9rIC3gyfnVyyAhS
5r5hhS3U4xxRcyyCTLP8f8qZ7HwltvcbW4hXoT5Nv/HOuz0hgAIktyugX2Gqhid7
+2wUEuxF5DWNDB5qcIDXGB5LZVB4Qw==
=jpnY
-----END PGP SIGNATURE-----

--jl5hounf2hkrpaap--

