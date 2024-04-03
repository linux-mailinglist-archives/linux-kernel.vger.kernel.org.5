Return-Path: <linux-kernel+bounces-130604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6CE897A60
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60EFD1C25A0A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6BA156657;
	Wed,  3 Apr 2024 21:06:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378E214C5B3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712178395; cv=none; b=V+BxTTq4Ri1pEYtpo2g7c4rH/JrQymqxFYvWs5qDiKwxWUoRQa4NuOUQ/d//9z9mvfEqzUlRs8nnZBo3X8Wu5dWdmJg/o/j08wwAaf09YuBbDyuMVZeorPnQfmkS4s2WXa38UPfHyduIZl7PkrH89AedwdtISwpqiIi4Dq8XlF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712178395; c=relaxed/simple;
	bh=bvE6+Ioe65Pvy3tTo3/DekL3m3PgUp+qr/wE3M2vlMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZGBl58cStmwFw2KpeDRlMceVle334rnxphLiAwlVQjbK0bt6smoOzyhwlCBLpJ4sXb5FO+drOtVz3jmHxnTW6IN4MEYK+xGGoQ1soanX6XFztFJ3C+qD2DMzi+PoA5AG1bCMN4SpDZdgzboEVPSduP49rJYqz2rYHNf3XtELeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rs7nv-0001NX-2i; Wed, 03 Apr 2024 23:05:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rs7nr-00AFDj-LI; Wed, 03 Apr 2024 23:05:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rs7nr-00EqVT-1m;
	Wed, 03 Apr 2024 23:05:51 +0200
Date: Wed, 3 Apr 2024 23:05:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Heiko Stuebner <heiko@sntech.de>, Andi Shyti <andi.shyti@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Li Zetao <lizetao1@huawei.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rob Herring <robh@kernel.org>, 
	Yang Yingliang <yangyingliang@huawei.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Luis de Arquer <luis.dearquer@inertim.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Jaewon Kim <jaewon02.kim@samsung.com>, linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 31/34] spi: remove incorrect of_match_ptr annotations
Message-ID: <5f3qvhasho4mfnf6f7i6djak3ankje375mt4fzvv3gqrlj242o@zdk2ajvha6hx>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-32-arnd@kernel.org>
 <b4418ac1-10ba-4932-be6e-93282707024f@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j3dyffzs5mph63yw"
Content-Disposition: inline
In-Reply-To: <b4418ac1-10ba-4932-be6e-93282707024f@sirena.org.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--j3dyffzs5mph63yw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 10:56:58AM +0100, Mark Brown wrote:
> On Wed, Apr 03, 2024 at 10:06:49AM +0200, Arnd Bergmann wrote:
>=20
> > These appear to all be copied from the same original driver, so fix the=
m at the
> > same time by removing the unnecessary of_match_ptr() annotation. As far=
 as I
> > can tell, all these drivers are only actually used on configurations th=
at
> > have CONFIG_OF enabled.
>=20
> Why are we not fixing of_match_ptr() here, or at least adding the ifdefs
> in case someone does end up wanting to run without OF?

Fixing of_match_ptr =3D

diff --git a/include/linux/of.h b/include/linux/of.h
index a0bedd038a05..d980bccffda0 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -890,7 +890,7 @@ static inline const void *of_device_get_match_data(cons=
t struct device *dev)
 	return NULL;
 }
=20
-#define of_match_ptr(_ptr)	NULL
+#define of_match_ptr(_ptr)	(0 ? (_ptr) : NULL)
 #define of_match_node(_matches, _node)	NULL
 #endif /* CONFIG_OF */
=20
?

Assuming this helps, I agree this would be the better fix.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--j3dyffzs5mph63yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYNxK4ACgkQj4D7WH0S
/k4RIQf+N9Iy5vdLQiMUAN6AC+cOYMVtNTWEXHv3Iu8OMI4BbFULD/p4hJYx4A/Y
+4trHVq0G7vFcqwJIyZ8XD7U0NnRLweSBCiBdm6lh/R7j8pyI32zbpvrJb8ge/Wm
LTfO5dGPLQMf1kIpjRlpYniRKxzxOTWIsnKpr801JczfdZDvZ236nLgQNNFTtYNP
4X9v+IjyFHuXxEjYvIZ52EsIgHnfGsNT7RNmncSBQSxLRwliB6gAO/Bzo1ulw1xS
iSIatTBxMMTV5D3fDRS1Ve4g7VIjI0LAO+I784HK+wg9jWI4tEwQz2eO5GZXxDXp
WbiT8oxPt4xi8tsgDAu681Ac2zeUOg==
=qPPD
-----END PGP SIGNATURE-----

--j3dyffzs5mph63yw--

