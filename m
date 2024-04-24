Return-Path: <linux-kernel+bounces-156531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B936C8B0401
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A611C23213
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48D0158874;
	Wed, 24 Apr 2024 08:16:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADD3158855
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713946583; cv=none; b=n3Pr6Re6gRlNp+R3p4ag5sNMOSzrPHwNQtxkews/pAG2/pFu7Kg8vwOIjDozKoGWYklnEm0qgvjfDTBYOh1qGQK5BAljJcqaO7eYVX+2wyGSEwJyVrXgO/Qh1xTrom8Bh/Da0Zk8Zv+6omLZa8Ee4D2ArtRvcE4CLVFFFVInnqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713946583; c=relaxed/simple;
	bh=BRLvrIp/v4JKF9Aq6tuCRvLZntMqwmCwEM/Qriqe90I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c48wWq4TYw2plDRB1UINyFhcx/laVO70Ri4N7KNChJWSHWJF+ywiL7Q8t4EUZ5S9XXj878PeCXFXtjuwl26SntLRPH0ScpQeQPknbsRN5KbFz0PP9KNIKuop8cDSQW9JKCA0hM9dmAvOi8M8hERS3Fr5hwVIEQRkMYFIMWYlZbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rzXnM-0008LH-2q; Wed, 24 Apr 2024 10:16:00 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rzXnK-00E2qO-7E; Wed, 24 Apr 2024 10:15:58 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C50B72BEC0D;
	Wed, 24 Apr 2024 08:15:57 +0000 (UTC)
Date: Wed, 24 Apr 2024 10:15:57 +0200
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
Message-ID: <20240424-taupe-lizard-of-perception-3bb2d9-mkl@pengutronix.de>
References: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
 <20240417-mcp251xfd-gpio-feature-v1-3-bc0c61fd0c80@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vpxobo6ttuwribyt"
Content-Disposition: inline
In-Reply-To: <20240417-mcp251xfd-gpio-feature-v1-3-bc0c61fd0c80@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--vpxobo6ttuwribyt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.04.2024 15:43:56, Gregor Herburger wrote:
> The mcp251xfd devices allow two pins to be configured as gpio. Add this
> functionality to driver.

Can you please move the introduction of regmap cache into a separate
patch.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vpxobo6ttuwribyt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYov7oACgkQKDiiPnot
vG89DQf/TJX3tOwUNv0w4BAXHJYcVPOIVgnLB9H1JHzxooXpHruuv/4zVzMpFkrD
9/UqZ28H5zoCN2c/66vuTkPgGJYmJKUiqnGbHxWtft6YMBDwHHWl+SgBk1Rh5pei
sTscGd91QgsWzJrzcnnZNf0lYcY5m7CajN9UhPwRrP2dKYTFb2ZQewuj3XpCcWuY
SsWLEB2k6QFuTb0sX2HB1I425QBFod00hbZIl+/zO+KI8qoXfLQtaPEbtfuDv0Ou
tbIkDYlYDFm6z2+dtGqDOrdrjo4K94YDHGLdCsiBlDLk72ZqHMvS4Almpi/lI3vE
Lq8ZRiBljoskgLxLhP6hd1Pu7h/29Q==
=bRrN
-----END PGP SIGNATURE-----

--vpxobo6ttuwribyt--

