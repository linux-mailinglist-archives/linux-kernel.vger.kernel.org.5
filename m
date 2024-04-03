Return-Path: <linux-kernel+bounces-129833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F37897100
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5234E1C249A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADA3149DF0;
	Wed,  3 Apr 2024 13:27:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3957149C68
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150837; cv=none; b=rhCImK8QCTDMq9d0LHlMqudgAYxTkeYEPHNtmMlGDi9CfVqG/S6JSzww2d+8BfdlevZA0p2oSCOvuS1uvo3T+fjo1+14xCoYjSaX4v1aBJEiEmkBq0w3f3XFr2BqVNz4RB7ggb74MP25cek4KFhPWiTXhAlqA7AajYqFfoIRg90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150837; c=relaxed/simple;
	bh=3hgoTAqV/LTNjWKMC6O/vyy+eVzLxhJJCrMJjVwEyHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIml3yuJvnY8eO04OXXjdPSH8PadhlGXpJexme9dH6v3+D1M1/3uSfwyvFfDIq+uck1b2/XMj5S/r0xzeBMSpJBSO0poPZwk4yQS5dp4BZDtAwDCNtJ33L0HSlJ9Cb9igPBLR/0P1WvuF39tk8mQf3VCIKDcIz9Hf0M87fxj4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rs0dx-0002d4-GC; Wed, 03 Apr 2024 15:27:09 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rs0dw-00ABe9-HS; Wed, 03 Apr 2024 15:27:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rs0dw-00EjOu-1T;
	Wed, 03 Apr 2024 15:27:08 +0200
Date: Wed, 3 Apr 2024 15:27:01 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 07/34] Input: stmpe-ts - mark OF related data as maybe
 unused
Message-ID: <wmd4z6bgy25tdzfch5a5p2gxtj35qyljo5t6babc773yaajeja@tefjvvrshykl>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-8-arnd@kernel.org>
 <gh4slqpbzul67vni6hv2opjuvccokfwqnnroxbpqt5oc3kiz65@nbqaxhwltb3z>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lwhm5g33cm24lkxt"
Content-Disposition: inline
In-Reply-To: <gh4slqpbzul67vni6hv2opjuvccokfwqnnroxbpqt5oc3kiz65@nbqaxhwltb3z>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--lwhm5g33cm24lkxt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello again,

On Wed, Apr 03, 2024 at 03:17:32PM +0200, Uwe Kleine-K=F6nig wrote:
> On Wed, Apr 03, 2024 at 10:06:25AM +0200, Arnd Bergmann wrote:
> > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >=20
> > When compile tested with W=3D1 on x86_64 with driver as built-in:
> >=20
> >   stmpe-ts.c:371:34: error: unused variable 'stmpe_ts_ids' [-Werror,-Wu=
nused-const-variable]
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/input/touchscreen/stmpe-ts.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touch=
screen/stmpe-ts.c
> > index b204fdb2d22c..022b3e94266d 100644
> > --- a/drivers/input/touchscreen/stmpe-ts.c
> > +++ b/drivers/input/touchscreen/stmpe-ts.c
> > @@ -366,7 +366,7 @@ static struct platform_driver stmpe_ts_driver =3D {
> >  };
> >  module_platform_driver(stmpe_ts_driver);
> > =20
> > -static const struct of_device_id stmpe_ts_ids[] =3D {
> > +static const struct of_device_id stmpe_ts_ids[] __maybe_unused =3D {
> >  	{ .compatible =3D "st,stmpe-ts", },
> >  	{ },
> >  };
>=20
> I'd suggest the following instead:
>=20
> diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchsc=
reen/stmpe-ts.c
> index b204fdb2d22c..e1afebc641ec 100644
> --- a/drivers/input/touchscreen/stmpe-ts.c
> +++ b/drivers/input/touchscreen/stmpe-ts.c
> @@ -357,21 +357,22 @@ static void stmpe_ts_remove(struct platform_device =
*pdev)
>  	stmpe_disable(ts->stmpe, STMPE_BLOCK_TOUCHSCREEN);
>  }
> =20
> -static struct platform_driver stmpe_ts_driver =3D {
> -	.driver =3D {
> -		.name =3D STMPE_TS_NAME,
> -	},
> -	.probe =3D stmpe_input_probe,
> -	.remove_new =3D stmpe_ts_remove,
> -};
> -module_platform_driver(stmpe_ts_driver);
> -
>  static const struct of_device_id stmpe_ts_ids[] =3D {
>  	{ .compatible =3D "st,stmpe-ts", },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, stmpe_ts_ids);
> =20
> +static struct platform_driver stmpe_ts_driver =3D {
> +	.driver =3D {
> +		.name =3D STMPE_TS_NAME,
> +		.of_match_table =3D stmpe_ts_ids,
> +	},
> +	.probe =3D stmpe_input_probe,
> +	.remove_new =3D stmpe_ts_remove,
> +};
> +module_platform_driver(stmpe_ts_driver);
> +
>  MODULE_AUTHOR("Luotao Fu <l.fu@pengutronix.de>");
>  MODULE_DESCRIPTION("STMPEXXX touchscreen driver");
>  MODULE_LICENSE("GPL");
>=20
> I wonder if with the status quo binding via dt works at all with
> stmpe_ts_driver.driver.of_match_table unset?!

I missed the discussion between Andy and Krzysztof when I wrote my mail.
I still think this should be considered and if .of_match_table should
stay unassigned (e.g. to allow dropping stmpe_ts_ids in case the driver
is built-in?) I think adding a code comment would be appropriate because
having an of_device_id array but not adding it to the driver is unusuall
and generally a bad template for new drivers.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lwhm5g33cm24lkxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYNWSQACgkQj4D7WH0S
/k6SBQf/boQclIHZWoNQ1TuZG4XA4b8YelwZEdTd65NHDS6BeEIoqmURpv3FhZDn
BLm5Xa52CQnqKSJPtc/xPF7cf4RygvQy1IQeQo05VgSWpdilHEHfQ5ni24FBkamZ
oEEpGMyfTzYABRHbJ5HBP9E5lXeIuf6Sydod5a7jhYTYLqnZYv0aLOWU5veHZydV
OChe/wSCmysu058/7iLNUoHOPk3KBIL0DTzqY1LQXFa+LKX3JInzTgm0yvOVcOKa
sjrLsZi7v55hB1Xr1G0WuCuneCTeVz3w5jI/8NbbdGd7dp/530fNvKtIA5LN1uZS
wnVuxRH+MiZXchlhoWFVvfFWLa1vZg==
=fXp2
-----END PGP SIGNATURE-----

--lwhm5g33cm24lkxt--

