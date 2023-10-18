Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23F57CD96F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbjJRKlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbjJRKk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:40:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0234D109
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:40:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qt3yZ-0000TH-Qw; Wed, 18 Oct 2023 12:40:31 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qt3yX-002X7U-Qe; Wed, 18 Oct 2023 12:40:29 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qt3yX-000sUi-H6; Wed, 18 Oct 2023 12:40:29 +0200
Date:   Wed, 18 Oct 2023 12:40:29 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        James Clark <james.clark@arm.com>, kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] driver core: Release all resources during unbind
 before updating device links
Message-ID: <20231018104029.zairwt4nzub33ekr@pengutronix.de>
References: <20231018013851.3303928-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zkde5xfi7bwxpp2k"
Content-Disposition: inline
In-Reply-To: <20231018013851.3303928-1-saravanak@google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zkde5xfi7bwxpp2k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 06:38:50PM -0700, Saravana Kannan wrote:
> This commit fixes a bug in commit 9ed9895370ae ("driver core: Functional
> dependencies tracking support") where the device link status was
> incorrectly updated in the driver unbind path before all the device's
> resources were released.
>=20
> Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking suppo=
rt")
> Reported-by: "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.de>
> Closes: https://lore.kernel.org/all/20231014161721.f4iqyroddkcyoefo@pengu=
tronix.de/
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Yang Yingliang <yangyingliang@huawei.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> Cc: James Clark <james.clark@arm.com>
> ---
>  drivers/base/dd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index a528cec24264..0c3725c3eefa 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1274,8 +1274,8 @@ static void __device_release_driver(struct device *=
dev, struct device *parent)
>  		if (dev->bus && dev->bus->dma_cleanup)
>  			dev->bus->dma_cleanup(dev);
> =20
> -		device_links_driver_cleanup(dev);
>  		device_unbind_cleanup(dev);
> +		device_links_driver_cleanup(dev);

Tested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

This indeed fixes the crash I experinced before.

Thanks a lot!
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zkde5xfi7bwxpp2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUvthwACgkQj4D7WH0S
/k7TBggAiq18HgXlT7rrKOTfdRYSNR3ak/2K0InNcZ+2SQ8D97lKQtrZ58Ol5sBw
4NarU+KYRp/Emh54C4+t6blHAe5yp1JZC8MvFE6tR3o9ZrPdv5lKY1+cxMCkpvIs
Os58qfkhsubYAtwFPJuGH/gR6lNH0MtKKadl/abO46z0OGE0YrittSssqrBvO9vc
H9SePeuKPyo7sRj0pg1UAwnYJmaoYGKoLW/YzIJWm6SXM+0ipZcj+7wVCm3oi8qp
3r6FZ8xBvF5B5YWAQ1QJQUbdMtgyXaxwAjR1KqGLIMzcaTiUvjFcOskLuCKgmUVk
2St8duHYt6+hJ4BRf5DUhgb3/AQtPQ==
=jTCn
-----END PGP SIGNATURE-----

--zkde5xfi7bwxpp2k--
