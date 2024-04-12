Return-Path: <linux-kernel+bounces-142636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE188A2E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C561C21C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D34256450;
	Fri, 12 Apr 2024 12:20:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8708C55E75
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712924417; cv=none; b=YhsKCMc3rkTpKkguAIzZoRDgy2phNlrMQ63G5EFuuyqGqIsz1ww6SWEiJ4Cbj774Pr3TBazZ2ApVBS6ZW4DGebzFjNfC/y0x2nOkFDX/mal84LeKbduF3tz+WCLci1+hJu1JVk1PCVKLkawcN8A4Rmlfs4+c8KxLgyBWPG/ztxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712924417; c=relaxed/simple;
	bh=ffHrB4NQS6S3xU4QCckB84HUrzLwSL1884+9+TrnXk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPw5vXaSyPLXPW6MtJ+mX5VyuF5VnskokPyzoKkkc6T3BoP5koR0MzEItJRhdQmfnb2rqB88cc+n4FC7tUSZfRBjtCMkJ6VHdfSDV1CdtngbdbN8J85OOOmhrRWLz/qrgruRyDdNC1JIQrX6C8017IFsq3BpPA0+FeCulFEG/HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvFt7-0003Vt-Dn; Fri, 12 Apr 2024 14:20:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvFt6-00BsCQ-VL; Fri, 12 Apr 2024 14:20:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvFt6-000A6i-2r;
	Fri, 12 Apr 2024 14:20:12 +0200
Date: Fri, 12 Apr 2024 14:20:12 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] samples: qmi: Convert to platform remove callback
 returning void
Message-ID: <g5iy5jov5uufi4oxdfgagqln6odwgdilrbbhsg3lkdidkvybbg@qbmsipcojt4t>
References: <d30beb557e0e97ea194028f62d3c4c10841d3e7c.1709886922.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kn77ildf4qyftzt2"
Content-Disposition: inline
In-Reply-To: <d30beb557e0e97ea194028f62d3c4c10841d3e7c.1709886922.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--kn77ildf4qyftzt2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bjorn,

On Fri, Mar 08, 2024 at 09:51:21AM +0100, Uwe Kleine-K=F6nig wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

This patch didn't receive any feedback yet, I guess because I used an
old email address for Bjorn. I updated the address for this mail now.

Would you consider applying this patch; please tell me if I should
resend.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kn77ildf4qyftzt2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYZJvsACgkQj4D7WH0S
/k6LhwgAiwjSAwMLaCjIFh1ywgHYe6zceIUhabfaZ6i33+Asd4VIptXFvirOAe5W
azO3FHpT2uSnT7p5FtEEZM+mJgxnr/o4zq1SlNGceed2TtPU3DgCANMEzDqnX7wb
DDKSVoy/EZza/aVtvLSxkTi7JszYY7QmVxoI0PHSMfwavX8whI1ANPKArYI1rQzd
fJ0ZMqEjpPmv2kCkiidj8mo44qpnXniJ8rCpub3y9v+DFj2i5ejaMS7zR+L1KXj5
kUpoOBq7Y08Oq10sBZRfyzkxehEeDMsRqWGFRW09hXRKxgW0Ju92X+BG/+zHML35
9ayi/YZ2Rj9mhNTNH7JZcIhvzXuaCQ==
=Obza
-----END PGP SIGNATURE-----

--kn77ildf4qyftzt2--

