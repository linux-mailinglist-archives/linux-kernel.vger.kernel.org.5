Return-Path: <linux-kernel+bounces-129799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A10389700D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC161C272A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B03F147C6C;
	Wed,  3 Apr 2024 13:17:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFED147C89
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150264; cv=none; b=J6fzwYZVh0nUN58i13UqDRwULNZ5E0syqjcN/0JZZcDn+L7C1cnCmgj2GjWUx5MR1di1PU/uCSh23XhRAlp46UJg/j+scH5sbtVT8Uuz31bE/Q3ATho06jp3ITRjF0/6cAkPBefNOlRhIxqdY7zFa/p9yY5+okovYf/k3KKCato=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150264; c=relaxed/simple;
	bh=Vyeker/HaMf2TYrA6wQCJ7GpcCBtVf1C9BLweI9lc2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNu5boMNTFjS0Ju2mPMcHexI/bfcT1WmjXS37qPVpc8Mc2TX/angOuEndHd9C3gzWQsct7TKT+sIfHSOnlAwGpJqypvmugWjKzGYsfcZ/Xi/vO5QUCwHvs18+K1Ic4Lp4Az5iWZrxWFbiKkRP8bwMMJmj3Lvq4I9VtEXjq/Lfxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rs0Ug-0002nO-5b; Wed, 03 Apr 2024 15:17:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rs0Ue-00ABcw-6F; Wed, 03 Apr 2024 15:17:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rs0Ue-00EjB3-0K;
	Wed, 03 Apr 2024 15:17:32 +0200
Date: Wed, 3 Apr 2024 15:17:21 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 07/34] Input: stmpe-ts - mark OF related data as maybe
 unused
Message-ID: <gh4slqpbzul67vni6hv2opjuvccokfwqnnroxbpqt5oc3kiz65@nbqaxhwltb3z>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-8-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w5s23epdr6logtfm"
Content-Disposition: inline
In-Reply-To: <20240403080702.3509288-8-arnd@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--w5s23epdr6logtfm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Apr 03, 2024 at 10:06:25AM +0200, Arnd Bergmann wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> When compile tested with W=3D1 on x86_64 with driver as built-in:
>=20
>   stmpe-ts.c:371:34: error: unused variable 'stmpe_ts_ids' [-Werror,-Wunu=
sed-const-variable]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/input/touchscreen/stmpe-ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchsc=
reen/stmpe-ts.c
> index b204fdb2d22c..022b3e94266d 100644
> --- a/drivers/input/touchscreen/stmpe-ts.c
> +++ b/drivers/input/touchscreen/stmpe-ts.c
> @@ -366,7 +366,7 @@ static struct platform_driver stmpe_ts_driver =3D {
>  };
>  module_platform_driver(stmpe_ts_driver);
> =20
> -static const struct of_device_id stmpe_ts_ids[] =3D {
> +static const struct of_device_id stmpe_ts_ids[] __maybe_unused =3D {
>  	{ .compatible =3D "st,stmpe-ts", },
>  	{ },
>  };

I'd suggest the following instead:

diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscre=
en/stmpe-ts.c
index b204fdb2d22c..e1afebc641ec 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -357,21 +357,22 @@ static void stmpe_ts_remove(struct platform_device *p=
dev)
 	stmpe_disable(ts->stmpe, STMPE_BLOCK_TOUCHSCREEN);
 }
=20
-static struct platform_driver stmpe_ts_driver =3D {
-	.driver =3D {
-		.name =3D STMPE_TS_NAME,
-	},
-	.probe =3D stmpe_input_probe,
-	.remove_new =3D stmpe_ts_remove,
-};
-module_platform_driver(stmpe_ts_driver);
-
 static const struct of_device_id stmpe_ts_ids[] =3D {
 	{ .compatible =3D "st,stmpe-ts", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, stmpe_ts_ids);
=20
+static struct platform_driver stmpe_ts_driver =3D {
+	.driver =3D {
+		.name =3D STMPE_TS_NAME,
+		.of_match_table =3D stmpe_ts_ids,
+	},
+	.probe =3D stmpe_input_probe,
+	.remove_new =3D stmpe_ts_remove,
+};
+module_platform_driver(stmpe_ts_driver);
+
 MODULE_AUTHOR("Luotao Fu <l.fu@pengutronix.de>");
 MODULE_DESCRIPTION("STMPEXXX touchscreen driver");
 MODULE_LICENSE("GPL");

I wonder if with the status quo binding via dt works at all with
stmpe_ts_driver.driver.of_match_table unset?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--w5s23epdr6logtfm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYNVt0ACgkQj4D7WH0S
/k617wf/XJTPmkGqx6WR8Tmi0mrUVAAfMvGFXyjwHCAZ4QoUpGT62IuJWADBA2z8
9CkeDLSntFQsLSCvm/4xE+A7YSfVylRp58nkIbt/L1PvNl37kx1NG8VRfr1tHi+t
qNS8bcTEMks28tKxfG2fZ699NUxQ/v56APHHmctVINZtQr70DldjgT9YLxlZl53i
HUR0vQ9GuhR2iAe0vGbe6x0i3ZBy8xbTq585mk4JffQuxLb1ZXW1+j62nQoUPJKt
SlF5XlUnG92tuNt8X1EWzbpSio1E98AQ3+sFvvRTRDFkI2WEk3wS/xVhZwqjy7JW
JEEu8YBfjnomnkrRw/U0tgZ1SY3sig==
=vjvn
-----END PGP SIGNATURE-----

--w5s23epdr6logtfm--

