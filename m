Return-Path: <linux-kernel+bounces-156823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9E08B08C0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7375B23BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1034815AD9E;
	Wed, 24 Apr 2024 11:55:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668D215A4A3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959713; cv=none; b=Mvg2qXzmeKWw8/SwrctTbuzP25mIVa0atJH8ATfjArRUo77qQR0aZHXMq34UDbW3jSPLpLeMKJNTm3C71favy84QZrjat4ni/QAMR/SpdsyjlVwhw1ClUHInx+jo9s9WwudUNdBpPaz29RlU/MEqsVg+esoR3fJhSUtshWvZ9yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959713; c=relaxed/simple;
	bh=laKzd3mIW3DWI5qUup3vRqxbLwrPRojH8Z7HJlY1Apc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOrFXDw5dIrQcmfGIxe2BzzgxLpfb9fj0MC1NXqIduqlrNwPD710qy6VAZ6tQjLQal/g0iCh1Q8Um67CG0rZ9BYQtsHffi6IPK/6jG7DN1y/4sN9nM0adckLakClQ1kkFMH4eATz/yOkRhMEvlhIhSVwy9BYTDRxrS6CkyKBiJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rzbDD-00033t-Ou; Wed, 24 Apr 2024 13:54:55 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rzbDD-00E4Rk-8O; Wed, 24 Apr 2024 13:54:55 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C8B292BEDFC;
	Wed, 24 Apr 2024 11:54:54 +0000 (UTC)
Date: Wed, 24 Apr 2024 13:54:54 +0200
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
Message-ID: <20240424-adaptable-zircon-badger-1fefd9-mkl@pengutronix.de>
References: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
 <20240417-mcp251xfd-gpio-feature-v1-1-bc0c61fd0c80@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="42zcn6qmd3zur5l3"
Content-Disposition: inline
In-Reply-To: <20240417-mcp251xfd-gpio-feature-v1-1-bc0c61fd0c80@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--42zcn6qmd3zur5l3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.04.2024 15:43:54, Gregor Herburger wrote:
> MCP2518FD exits Low-Power Mode (LPM) when CS is asserted. When chip
> is send to sleep and the timestamp workqueue is not stopped chip is
> waked by SPI transfer of mcp251xfd_timestamp_read.

How does the Low-Power Mode affect the GPIO lines? Is there a difference
if the device is only in sleep mode?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--42zcn6qmd3zur5l3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYo8wsACgkQKDiiPnot
vG94AAf/fWp9nrOulZnq9/AdJQ9ZdkwwGBc1Y2so9ZSM9MUN1SAmlR5E67MpNdT5
IUuME7nsewsFsKPeirJiFFP8Vi0c4+ID0GimQkD6XKlNPjtBzJPDW3LfwPzkYg9w
Z2jizgKuBwrJvqRHxREhRuAzU0SSBSmb7kh9a0mE2JjC7ju6E5wqYQvbI+P7tnFK
VaWIq75tHVWGIp6IhnQtudGoRi+YUVaqTeoHpfyEgnCosZ8b4vhN8EasSnA1S5si
1vDZBgCHfVqQ4Losf9Z0zUQx5KSSGjpQJP6YirqqUXqUTbrd0g7ht59550jAT5JE
aZXrBcZxYBPxliNx/Kg1HmJUxCP2uQ==
=MLif
-----END PGP SIGNATURE-----

--42zcn6qmd3zur5l3--

