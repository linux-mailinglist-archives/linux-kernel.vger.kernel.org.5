Return-Path: <linux-kernel+bounces-89763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A6286F534
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4B11C2086B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0877859B62;
	Sun,  3 Mar 2024 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rY0cGOtr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DC0A957;
	Sun,  3 Mar 2024 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709473842; cv=none; b=b8HkJe8LbISvadyMTINFwPxyeYx/nd3QMUwbAKoGwibgzn2a/FFEeAYeRZEBJDFXyesayoDtKK/niG8wddsyBL7pMaQg+0t8SERKX8u9toTLdNAxR4Xs/Fi5OldjOGpmgyRStt8FCFVfYULfVm6l3RXRIw7UnITX1jeegDF/Cvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709473842; c=relaxed/simple;
	bh=cLGjYnegpEWxWvkDnB472eI87+/tPnQpAUYZmm2aSo0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EP9po9ZaKm+TreobqObQXwr1K6oke6ICu9j2E9A4gSQjUFt2Dfn09lIXwK375tGORl4RT0XSPHF6o+d+EkgrgzJOv4w0sFpNhescq7MBnQvlv4h5+gVHpAO4+db0nJOEx+pSe7q44SJmiiAERBTkBVPFJ5bqijZAXhhQmckJWvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rY0cGOtr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C9CC433C7;
	Sun,  3 Mar 2024 13:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709473841;
	bh=cLGjYnegpEWxWvkDnB472eI87+/tPnQpAUYZmm2aSo0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rY0cGOtr2PVnKTQSCT9oVGnoJnn0WzUFeOVgSE25SGvcvxMglR/VtfuMnwAtDn+Ta
	 ygDJLO9kj46ngEG/yoXrxpAWQdnE02CT2Cu3f/KWvU/45Gw3TTYvBf2OodU7PgS8qQ
	 pG7REWTAFWYvSm3aFCXg0dM8GnRvzA8IlZi73WTltDXSFPr7Ki3iEykFBmsWygYyWO
	 Gbn8SCs2PW47BvJxFwHTp/AWe6AUDpl0NWzeul1gU82HhNBmJlq9IhHkeXQRGF7Mq5
	 e2JhHA90r86pz7KDzL/rKtLEZQSj/JuqBeIrqENH9Ulj3HAWVwF8TqQPGRG1/Gabcp
	 poOWZwIqSH4Qw==
Date: Sun, 3 Mar 2024 13:50:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: adc: twl4030-madc: Make use of device
 properties
Message-ID: <20240303134746.0d145b6d@jic23-huawei>
In-Reply-To: <20240228205927.3681321-1-andriy.shevchenko@linux.intel.com>
References: <20240228205927.3681321-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Feb 2024 22:59:27 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
>=20
> Include mod_devicetable.h explicitly to replace the dropped of.h
> which included mod_devicetable.h indirectly.

It seems fairly implausible anyone will use this ancient device
with any other firmware, but as conversion is trivial and provides
one less place for people to copy of specific handling from
i tried applying it.

However it doesn't build...

drivers/iio/adc/twl4030-madc.c:754:24: error: =E2=80=98np=E2=80=99 undeclar=
ed (first use in this function); did you mean =E2=80=98up=E2=80=99?
  754 |         if (!pdata && !np) {
      |                        ^~
      |                        up


I guess !dev_fwnode(dev) instead?

Jonathan
=20
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/adc/twl4030-madc.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-mad=
c.c
> index 4a247ca25a44..a7b6b81014de 100644
> --- a/drivers/iio/adc/twl4030-madc.c
> +++ b/drivers/iio/adc/twl4030-madc.c
> @@ -19,10 +19,12 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/slab.h>
>  #include <linux/mfd/twl.h>
> -#include <linux/module.h>
>  #include <linux/stddef.h>
>  #include <linux/mutex.h>
>  #include <linux/bitops.h>
> @@ -30,7 +32,6 @@
>  #include <linux/types.h>
>  #include <linux/gfp.h>
>  #include <linux/err.h>
> -#include <linux/of.h>
>  #include <linux/regulator/consumer.h>
> =20
>  #include <linux/iio/iio.h>
> @@ -746,7 +747,6 @@ static int twl4030_madc_probe(struct platform_device =
*pdev)
>  {
>  	struct twl4030_madc_data *madc;
>  	struct twl4030_madc_platform_data *pdata =3D dev_get_platdata(&pdev->de=
v);
> -	struct device_node *np =3D pdev->dev.of_node;
>  	int irq, ret;
>  	u8 regval;
>  	struct iio_dev *iio_dev =3D NULL;
> @@ -779,7 +779,7 @@ static int twl4030_madc_probe(struct platform_device =
*pdev)
>  	if (pdata)
>  		madc->use_second_irq =3D (pdata->irq_line !=3D 1);
>  	else
> -		madc->use_second_irq =3D of_property_read_bool(np,
> +		madc->use_second_irq =3D device_property_read_bool(&pdev->dev,
>  				       "ti,system-uses-second-madc-irq");
> =20
>  	madc->imr =3D madc->use_second_irq ? TWL4030_MADC_IMR2 :
> @@ -905,20 +905,18 @@ static void twl4030_madc_remove(struct platform_dev=
ice *pdev)
>  	regulator_disable(madc->usb3v1);
>  }
> =20
> -#ifdef CONFIG_OF
>  static const struct of_device_id twl_madc_of_match[] =3D {
>  	{ .compatible =3D "ti,twl4030-madc", },
> -	{ },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(of, twl_madc_of_match);
> -#endif
> =20
>  static struct platform_driver twl4030_madc_driver =3D {
>  	.probe =3D twl4030_madc_probe,
>  	.remove_new =3D twl4030_madc_remove,
>  	.driver =3D {
>  		   .name =3D "twl4030_madc",
> -		   .of_match_table =3D of_match_ptr(twl_madc_of_match),
> +		   .of_match_table =3D twl_madc_of_match,
>  	},
>  };
> =20


