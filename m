Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19B07B0125
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjI0J51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjI0J5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:57:25 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399D9E6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:57:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlRI6-0005gM-PA; Wed, 27 Sep 2023 11:57:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlRI5-009JFx-7k; Wed, 27 Sep 2023 11:57:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlRI4-005FLO-UV; Wed, 27 Sep 2023 11:57:08 +0200
Date:   Wed, 27 Sep 2023 11:57:08 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     jic23@kernel.org, andriy.shevchenko@linux.intel.com,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] iio: imu: Add driver for BMI323 IMU
Message-ID: <20230927095708.l57kmdc3mmrtaco7@pengutronix.de>
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
 <20230918080314.11959-3-jagathjog1996@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ayzzs7ssu5nzixlw"
Content-Disposition: inline
In-Reply-To: <20230918080314.11959-3-jagathjog1996@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ayzzs7ssu5nzixlw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Sep 18, 2023 at 01:33:14PM +0530, Jagath Jog J wrote:
> The Bosch BMI323 is a 6-axis low-power IMU that provide measurements for
> acceleration, angular rate, and temperature. This sensor includes
> motion-triggered interrupt features, such as a step counter, tap detectio=
n,
> and activity/inactivity interrupt capabilities.
>=20
> The driver supports various functionalities, including data ready, FIFO
> data handling, and events such as tap detection, step counting, and
> activity interrupts
>=20
> Datasheet: https://www.bosch-sensortec.com/media/boschsensortec/downloads=
/datasheets/bst-bmi323-ds000.pdf

Maybe put this link better in the driver.

> +static struct i2c_driver bmi323_i2c_driver =3D {
> +	.driver =3D {
> +		.name =3D "bmi323",
> +		.of_match_table =3D bmi323_of_i2c_match,
> +	},
> +	.probe_new =3D bmi323_i2c_probe,
> +	.id_table =3D bmi323_i2c_ids,
> +};
> +module_i2c_driver(bmi323_i2c_driver);

If you want to compile this driver after v6.6-rc2 (which includes=20
commit 5eb1e6e459cf ("i2c: Drop legacy callback .probe_new()")) better
use .probe here instead of .probe_new().

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ayzzs7ssu5nzixlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUT/HQACgkQj4D7WH0S
/k5O+AgAupD7sxxsTSWm21ccqUt6/DseGEcb01TUR1IxTfoMogC9MdJRO23HF3hn
5x61HUQAMPjb2pw1yOASyRfE6L1A2+iojJ93053SBtw3c2puzc6SgW/bLBuMCyoi
64Y1DTm0PP3vZwRLxOV66k3v7wecsMak0p/4l5XaiAgwNNQDTEA9MX68Peu91k2F
N7E+GnUs8eNOLRC7E0YJHSv5S3SqilqeknU8IhOZBNDcOIoz+punWdFSbWBJGMAM
kS4e//zRjf6gU7KRvs8ABe8Iux3NTqcyVAXjT7fIG9vdimsu0QXlymNXuz2eYNcw
3/Kgp/AZrVmTr+7l3VovKGB3PyHJqA==
=AfNQ
-----END PGP SIGNATURE-----

--ayzzs7ssu5nzixlw--
