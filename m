Return-Path: <linux-kernel+bounces-5965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB83819234
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A462876AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F843C6A4;
	Tue, 19 Dec 2023 21:21:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF5A3D0AE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFhWj-0002Z3-GW; Tue, 19 Dec 2023 22:21:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFhWh-0006UQ-J8; Tue, 19 Dec 2023 22:21:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFhWi-000KNt-Cu; Tue, 19 Dec 2023 22:21:20 +0100
Date: Tue, 19 Dec 2023 22:21:20 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] [ARM] locomo: make locomo_bus_type constant and static
Message-ID: <amnspbf2euablvmtl2bpng423cnkbjkvtsf7dhqmoyrzbgtpwb@3rgazgmuqjcx>
References: <2023121905-idiom-opossum-1ba3@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qbaukj4aixzynuuu"
Content-Disposition: inline
In-Reply-To: <2023121905-idiom-opossum-1ba3@gregkh>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--qbaukj4aixzynuuu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 07:33:06PM +0100, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the locomo_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>=20
> It's also never used outside of arch/arm/common/locomo.c so make it
> static and don't export it as no one is using it.
>=20
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.de>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/arm/common/locomo.c               | 4 +++-
>  arch/arm/include/asm/hardware/locomo.h | 2 --
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
> index 70480dd9e96d..6d0c9f7268ba 100644
> --- a/arch/arm/common/locomo.c
> +++ b/arch/arm/common/locomo.c
> @@ -68,6 +68,8 @@ struct locomo {
>  #endif
>  };
> =20
> +static const struct bus_type locomo_bus_type;
> +

If you move up locomo_bus_type together with its three callbacks before
locomo_init_one_child, you don't need the extra declaration here.

That would be:

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 6d0c9f7268ba..676e98802561 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -68,8 +68,6 @@ struct locomo {
 #endif
 };
=20
-static const struct bus_type locomo_bus_type;
-
 struct locomo_dev_info {
 	unsigned long	offset;
 	unsigned long	length;
@@ -216,6 +214,47 @@ static void locomo_dev_release(struct device *_dev)
 	kfree(dev);
 }
=20
+/*
+ *	LoCoMo "Register Access Bus."
+ *
+ *	We model this as a regular bus type, and hang devices directly
+ *	off this.
+ */
+static int locomo_match(struct device *_dev, struct device_driver *_drv)
+{
+	struct locomo_dev *dev =3D LOCOMO_DEV(_dev);
+	struct locomo_driver *drv =3D LOCOMO_DRV(_drv);
+
+	return dev->devid =3D=3D drv->devid;
+}
+
+static int locomo_bus_probe(struct device *dev)
+{
+	struct locomo_dev *ldev =3D LOCOMO_DEV(dev);
+	struct locomo_driver *drv =3D LOCOMO_DRV(dev->driver);
+	int ret =3D -ENODEV;
+
+	if (drv->probe)
+		ret =3D drv->probe(ldev);
+	return ret;
+}
+
+static void locomo_bus_remove(struct device *dev)
+{
+	struct locomo_dev *ldev =3D LOCOMO_DEV(dev);
+	struct locomo_driver *drv =3D LOCOMO_DRV(dev->driver);
+
+	if (drv->remove)
+		drv->remove(ldev);
+}
+
+static const struct bus_type locomo_bus_type =3D {
+	.name		=3D "locomo-bus",
+	.match		=3D locomo_match,
+	.probe		=3D locomo_bus_probe,
+	.remove		=3D locomo_bus_remove,
+};
+
 static int
 locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
 {
@@ -810,47 +849,6 @@ void locomo_frontlight_set(struct locomo_dev *dev, int=
 duty, int vr, int bpwf)
 }
 EXPORT_SYMBOL(locomo_frontlight_set);
=20
-/*
- *	LoCoMo "Register Access Bus."
- *
- *	We model this as a regular bus type, and hang devices directly
- *	off this.
- */
-static int locomo_match(struct device *_dev, struct device_driver *_drv)
-{
-	struct locomo_dev *dev =3D LOCOMO_DEV(_dev);
-	struct locomo_driver *drv =3D LOCOMO_DRV(_drv);
-
-	return dev->devid =3D=3D drv->devid;
-}
-
-static int locomo_bus_probe(struct device *dev)
-{
-	struct locomo_dev *ldev =3D LOCOMO_DEV(dev);
-	struct locomo_driver *drv =3D LOCOMO_DRV(dev->driver);
-	int ret =3D -ENODEV;
-
-	if (drv->probe)
-		ret =3D drv->probe(ldev);
-	return ret;
-}
-
-static void locomo_bus_remove(struct device *dev)
-{
-	struct locomo_dev *ldev =3D LOCOMO_DEV(dev);
-	struct locomo_driver *drv =3D LOCOMO_DRV(dev->driver);
-
-	if (drv->remove)
-		drv->remove(ldev);
-}
-
-static const struct bus_type locomo_bus_type =3D {
-	.name		=3D "locomo-bus",
-	.match		=3D locomo_match,
-	.probe		=3D locomo_bus_probe,
-	.remove		=3D locomo_bus_remove,
-};
-
 int locomo_driver_register(struct locomo_driver *driver)
 {
 	driver->drv.bus =3D &locomo_bus_type;

Feel free to squash this into your patch for a v2 if you like it.

Or is that better done as a separate change on top of yours?

Otherwise looks fine to me.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qbaukj4aixzynuuu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWCCU8ACgkQj4D7WH0S
/k4fkwgAkf1whKE3whP9WAyRRNjmXl8H9nThSCUHfBV41aLXlutxAmHO5d5pyeEj
rElRtJl3aAmrzoh7W9s1plEEJ997+bVYKZlxFGtpvQH7eZCR5UTsHxPqjYc6y+4k
ZogRkQJY6KS1VWXQQBE58fFIVWQHjDkpplPIA62WE88PpFfk+wONrISIX2q2QcVV
lV4SYG05AUwTQirbiuAYSdNMczZs2rsY5w3lWmpgcWSikLya1eiWQRoIBQbw16ad
wXBgqMLtFlTLB237e4ycffQqCZYsZDDjCXxVVjdBADVe5bbOa90ydC66TXZKrpl1
Yp0iY6sEYabjtFmAvRngN/qW9fagFg==
=n25+
-----END PGP SIGNATURE-----

--qbaukj4aixzynuuu--

