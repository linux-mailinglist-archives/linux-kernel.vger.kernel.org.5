Return-Path: <linux-kernel+bounces-16425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9529B823E4D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27D5BB2534E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C096420339;
	Thu,  4 Jan 2024 09:09:18 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827561EA95
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rLJin-00009h-2S; Thu, 04 Jan 2024 10:09:01 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rLJil-000J08-2c; Thu, 04 Jan 2024 10:08:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rLJik-003WEi-3A;
	Thu, 04 Jan 2024 10:08:58 +0100
Date: Thu, 4 Jan 2024 10:08:58 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Arnd Bergmann <arnd@arndb.de>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Lubomir Rintel <lkundrak@v3.sk>, zhang songyi <zhang.songyi@zte.com.cn>, soc@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC RESEND] soc: pxa: ssp: Cast to enum pxa_ssp_type
 instead of int
Message-ID: <rj7ijuyy47jrffi6sk7wikqo3rnutz2swkdrznyegalylacawz@jdncegf3elct>
References: <20240103210604.16877-1-duje.mihanovic@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="52dkhi32d3pgibs4"
Content-Disposition: inline
In-Reply-To: <20240103210604.16877-1-duje.mihanovic@skole.hr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--52dkhi32d3pgibs4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[adding lakml to Cc for wider audience]

On Wed, Jan 03, 2024 at 10:06:03PM +0100, Duje Mihanovi=C4=87 wrote:
> On ARM64 platforms, id->data is a 64-bit value and casting it to a
> 32-bit integer causes build errors. Cast it to the corresponding enum
> instead.
>=20
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> ---
> This patch is necessary for my Marvell PXA1908 series to compile successf=
ully
> with allyesconfig:
> https://lore.kernel.org/all/20231102-pxa1908-lkml-v7-0-cabb1a0cb52b@skole=
=2Ehr/
> ---
>  drivers/soc/pxa/ssp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/soc/pxa/ssp.c b/drivers/soc/pxa/ssp.c
> index a1e8a07f7275..e2ffd8fd7e13 100644
> --- a/drivers/soc/pxa/ssp.c
> +++ b/drivers/soc/pxa/ssp.c
> @@ -152,11 +152,11 @@ static int pxa_ssp_probe(struct platform_device *pd=
ev)
>  	if (dev->of_node) {
>  		const struct of_device_id *id =3D
>  			of_match_device(of_match_ptr(pxa_ssp_of_ids), dev);
> -		ssp->type =3D (int) id->data;
> +		ssp->type =3D (enum pxa_ssp_type) id->data;

I wonder if this is a long-term fix. The error that the compiler throws
is:

	drivers/soc/pxa/ssp.c:155:29: error: cast from pointer to integer of diffe=
rent size [-Werror=3Dpointer-to-int-cast]
	  155 |                 ssp->type =3D (int) id->data;
	      |                             ^

enum pxa_ssp_type is an integer type, too, and its width could be
smaller than 64 bit, too.

The following would also help:

diff --git a/drivers/soc/pxa/ssp.c b/drivers/soc/pxa/ssp.c
index a1e8a07f7275..095d997eb886 100644
--- a/drivers/soc/pxa/ssp.c
+++ b/drivers/soc/pxa/ssp.c
@@ -96,13 +96,13 @@ EXPORT_SYMBOL(pxa_ssp_free);
=20
 #ifdef CONFIG_OF
 static const struct of_device_id pxa_ssp_of_ids[] =3D {
-	{ .compatible =3D "mrvl,pxa25x-ssp",	.data =3D (void *) PXA25x_SSP },
-	{ .compatible =3D "mvrl,pxa25x-nssp",	.data =3D (void *) PXA25x_NSSP },
-	{ .compatible =3D "mrvl,pxa27x-ssp",	.data =3D (void *) PXA27x_SSP },
-	{ .compatible =3D "mrvl,pxa3xx-ssp",	.data =3D (void *) PXA3xx_SSP },
-	{ .compatible =3D "mvrl,pxa168-ssp",	.data =3D (void *) PXA168_SSP },
-	{ .compatible =3D "mrvl,pxa910-ssp",	.data =3D (void *) PXA910_SSP },
-	{ .compatible =3D "mrvl,ce4100-ssp",	.data =3D (void *) CE4100_SSP },
+	{ .compatible =3D "mrvl,pxa25x-ssp",	.driver_data =3D PXA25x_SSP },
+	{ .compatible =3D "mvrl,pxa25x-nssp",	.driver_data =3D PXA25x_NSSP },
+	{ .compatible =3D "mrvl,pxa27x-ssp",	.driver_data =3D PXA27x_SSP },
+	{ .compatible =3D "mrvl,pxa3xx-ssp",	.driver_data =3D PXA3xx_SSP },
+	{ .compatible =3D "mvrl,pxa168-ssp",	.driver_data =3D PXA168_SSP },
+	{ .compatible =3D "mrvl,pxa910-ssp",	.driver_data =3D PXA910_SSP },
+	{ .compatible =3D "mrvl,ce4100-ssp",	.driver_data =3D CE4100_SSP },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, pxa_ssp_of_ids);
@@ -152,7 +152,7 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 	if (dev->of_node) {
 		const struct of_device_id *id =3D
 			of_match_device(of_match_ptr(pxa_ssp_of_ids), dev);
-		ssp->type =3D (int) id->data;
+		ssp->type =3D id->driver_data;
 	} else {
 		const struct platform_device_id *id =3D
 			platform_get_device_id(pdev);
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetabl=
e.h
index f458469c5ce5..fbe16089e4bb 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -283,7 +283,10 @@ struct of_device_id {
 	char	name[32];
 	char	type[32];
 	char	compatible[128];
-	const void *data;
+	union {
+		const void *data;
+		kernel_ulong_t driver_data;
+	};
 };
=20
 /* VIO */

For this driver the change would be nice, as several casts can be
dropped.

>  	} else {
>  		const struct platform_device_id *id =3D
>  			platform_get_device_id(pdev);
> -		ssp->type =3D (int) id->driver_data;
> +		ssp->type =3D (enum pxa_ssp_type) id->driver_data;

This one isn't problematic in my build configuration and you could just
drop the cast completely.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--52dkhi32d3pgibs4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWWdakACgkQj4D7WH0S
/k5kkAf/SdNq0pMzzew8DK1KS9BHkwqYm63O609O6pP+m+aJlHmSt2HGFPIhEV4I
aGasfXdwyiF+QJ3oGOmBA4j7+AcGAB5sog1Ofhh8GzOAft3gntrF/TiQhCXHHUNX
tH7M/v5gqdwBwDHvyF6b8LPNL/1LZ784Gtiso+G6geuTmA7veXkaW4gXuFTvWJfT
dtEvYqrlZharOUHKEtBF2Yazt42zub/pqDP1ZNgvvuT+1WCLMdCRdJjDZRGdC3/b
Nl6ANRbOhTZPhvAzuryKug8e9tBAhqdLR0UhfXJ/b9shUr8zlLB96Rgw5q+HWFcY
qjNWazn8ABaFDQn6pX3Ep1O2SzGk1g==
=ZZi0
-----END PGP SIGNATURE-----

--52dkhi32d3pgibs4--

