Return-Path: <linux-kernel+bounces-156537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89A58B0445
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62A2283E86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513A815887D;
	Wed, 24 Apr 2024 08:25:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78826158871
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947116; cv=none; b=XonTcBxRaK8/xfKIz6fxOmFDfFpzRcYMqBjn21jPF66rPYLUNEUG+LH5kcFJs2CMUapx79k8YF/gxqR8QWRInRDtjTGmaudnLA38LbI+e7P5GOzeHEHPKpH54MGV0nyu1q4CiMK/xXYwdUhMD6Is2kvs1P/ZW5j4UsiB8x28czI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947116; c=relaxed/simple;
	bh=NeIENiopGqRCJKXoxGR47faLpfIOQmosSOdAybtLZ1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rqd+rVcPTxTxmOvBx1PlmJd6YBSAvzxr8ptRmf4PFtqsvLEffNupxJ2rL5B7A0z6J9D2UsTsAzCCi6TatG7T29YJPV+6sPUMbfOjw43MlRQA86F20QPo4flDcdbwex/f7v2v/kHbk1k66+ZcSfuWn6evnZ6/1zu0IyqTCgavHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rzXw4-0004x8-5q; Wed, 24 Apr 2024 10:25:00 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rzXw3-00E2rV-Ic; Wed, 24 Apr 2024 10:24:59 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 23B652BEC37;
	Wed, 24 Apr 2024 08:24:59 +0000 (UTC)
Date: Wed, 24 Apr 2024 10:24:58 +0200
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
Message-ID: <20240424-fast-sandy-jackrabbit-d289a0-mkl@pengutronix.de>
References: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
 <20240417-mcp251xfd-gpio-feature-v1-1-bc0c61fd0c80@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rqbw5j2wn4qgc634"
Content-Disposition: inline
In-Reply-To: <20240417-mcp251xfd-gpio-feature-v1-1-bc0c61fd0c80@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--rqbw5j2wn4qgc634
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.04.2024 15:43:54, Gregor Herburger wrote:
> MCP2518FD exits Low-Power Mode (LPM) when CS is asserted. When chip
> is send to sleep and the timestamp workqueue is not stopped chip is
> waked by SPI transfer of mcp251xfd_timestamp_read.
>=20
> So before sending chip to sleep stop timestamp otherwise the
> mcp251xfd_timestamp_read callback would wake chip up.
>=20
> Also there are error paths in mcp251xfd_chip_start where workqueue has
> not been initialized but mcp251xfd_chip_stop is called. So check for
> initialized func before canceling delayed_work.

Can you move the mcp251xfd_timestamp_init() (which starts the
timestamping worker) into mcp251xfd_chip_start() to keep things
symmetrical? I think then you don't need to check for "work->func" in
mcp251xfd_timestamp_stop().

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rqbw5j2wn4qgc634
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYowdcACgkQKDiiPnot
vG/p/Qf/TnaEbLVI0x6Nv/Y79Ua6wtUkcJzzxBEoGz9HPhHdw/dLMVrLdK9WGHwu
wQFssYbY/vrV+ro2S120SzM69VfAKZY49Ouee0bq5C1zrxqjJRpO1Axj7lV8kCX8
x2LUUxnbL1Ga1NWJLR+Z+y4nBY/LZotSIGohDemQhScfL5cAGkz/ZyoU58rt6zxM
stvz8zMtJQmkprU6LH3MWr8MT25hj3T9OW9WAkjlqT30VCfuYvsRYqmJw+MsNIPd
iqoMDYIYZyHKqTBfciDfEhZVPJzLQQtn0H5EBfG+yq8GH8QE4MvPuOWCd371+Sil
XomSJ6I2QI5SFbGP/Wh3KfwoMXnEtQ==
=GzL3
-----END PGP SIGNATURE-----

--rqbw5j2wn4qgc634--

