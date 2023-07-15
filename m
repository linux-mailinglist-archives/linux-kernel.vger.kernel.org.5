Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAB7754BAF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 21:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjGOTSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 15:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjGOTSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 15:18:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCCA2113
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 12:18:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKkmF-00017C-QM; Sat, 15 Jul 2023 21:17:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKkmD-00Edbe-EW; Sat, 15 Jul 2023 21:17:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKkmC-0058Mx-LD; Sat, 15 Jul 2023 21:17:56 +0200
Date:   Sat, 15 Jul 2023 21:17:54 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc:     Angelo Compagnucci <angelo@amarulasolutions.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:GENERIC PWM SERVO DRIVER" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] misc: servo-pwm: driver for controlling servo
 motors via PWM
Message-ID: <20230715191754.ktflbhelouxudqrg@pengutronix.de>
References: <20230217161038.3130053-1-angelo@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tl4v7hwjfkdh3za7"
Content-Disposition: inline
In-Reply-To: <20230217161038.3130053-1-angelo@amarulasolutions.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tl4v7hwjfkdh3za7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2023 at 05:10:35PM +0100, Angelo Compagnucci wrote:
> This patch adds a simple driver to control servo motor position via
> PWM signal.
> The driver allows to set the angle from userspace, while min/max
> positions duty cycle and the motor degrees aperture are defined in
> the dts.
>=20
> Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
> ---
> v2:
> * Driver mostly rewritten for kernel 6.2
> v3:
> * Fixed sysfs_emit (greg k-h)
>=20
>  MAINTAINERS              |   6 ++
>  drivers/misc/Kconfig     |  11 +++
>  drivers/misc/Makefile    |   1 +
>  drivers/misc/servo-pwm.c | 149 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 167 insertions(+)
>  create mode 100644 drivers/misc/servo-pwm.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 39ff1a717625..8f4af64deb1b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8737,6 +8737,12 @@ F:	Documentation/devicetree/bindings/power/power?d=
omain*
>  F:	drivers/base/power/domain*.c
>  F:	include/linux/pm_domain.h
> =20
> +GENERIC PWM SERVO DRIVER
> +M:	"Angelo Compagnucci" <angelo@amarulasolutions.com>
> +L:	linux-pwm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/misc/servo-pwm.c
> +
>  GENERIC RESISTIVE TOUCHSCREEN ADC DRIVER
>  M:	Eugen Hristev <eugen.hristev@microchip.com>
>  L:	linux-input@vger.kernel.org
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 9947b7892bd5..8a74087149ac 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -518,6 +518,17 @@ config VCPU_STALL_DETECTOR
> =20
>  	  If you do not intend to run this kernel as a guest, say N.
> =20
> +config SERVO_PWM
> +	tristate "Servo motor positioning"
> +	depends on PWM
> +	help
> +	  Driver to control generic servo motor positioning.
> +	  Writing to the "angle" device attribute, the motor will move to
> +	  the angle position.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called servo-pwm.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 87b54a4a4422..936629b648a9 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -64,3 +64,4 @@ obj-$(CONFIG_HI6421V600_IRQ)	+=3D hi6421v600-irq.o
>  obj-$(CONFIG_OPEN_DICE)		+=3D open-dice.o
>  obj-$(CONFIG_GP_PCI1XXXX)	+=3D mchp_pci1xxxx/
>  obj-$(CONFIG_VCPU_STALL_DETECTOR)	+=3D vcpu_stall_detector.o
> +obj-$(CONFIG_SERVO_PWM)	+=3D servo-pwm.o
> diff --git a/drivers/misc/servo-pwm.c b/drivers/misc/servo-pwm.c
> new file mode 100644
> index 000000000000..1303ddda8d07
> --- /dev/null
> +++ b/drivers/misc/servo-pwm.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 Angelo Compagnucci <angelo@amarulasolutions.com>
> + * servo-pwm.c - driver for controlling servo motors via pwm.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/err.h>
> +#include <linux/pwm.h>
> +
> +#define DEFAULT_DUTY_MIN	500000
> +#define DEFAULT_DUTY_MAX	2500000
> +#define DEFAULT_DEGREES		175
> +#define DEFAULT_ANGLE		0
> +
> +struct servo_pwm_data {
> +	u32 duty_min;
> +	u32 duty_max;
> +	u32 degrees;
> +	u32 angle;
> +
> +	struct mutex lock;
> +	struct pwm_device *pwm;
> +	struct pwm_state pwmstate;
> +};
> +
> +static int servo_pwm_set(struct servo_pwm_data *data, int val)
> +{
> +	u64 new_duty =3D (((data->duty_max - data->duty_min) /
> +			data->degrees) * val) + data->duty_min;

You're loosing precision here. Always divide as late as possible. (If
you need an example: With

	duty_max =3D 1000
	duty_min =3D 0
	degrees =3D 251
	val =3D 79

the exact result for new_duty would be 314.7410358565737. Your term
yields 237. If you divide after multiplying with val you get 314.

All in all I think this driver is too specialized on a single motor
type. IMHO what we would be more helpful is a generic framework that can
abstract various different motors with the same API.=20

A while back I already thought about a suitable driver API. The
abstraction I came up with back then was:

	.setspeed(struct motor_device *motor, signed int speed)
	.disable(struct motor_device *motor)

In the end this is probably too simple because it doesn't allow the
consumer to specify how fast the new target speed is to be reached.
(Consider the motor running at 1000 and .setspeed(mymotor, 0) is called.
Should this mean "actively brake", or "stop driving and just coast
down"? I don't have a good idea yet that is both simple enough and still
expressive that it's both useful to consumers and sensible to implement
for different motor types.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tl4v7hwjfkdh3za7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSy8OIACgkQj4D7WH0S
/k5c7ggArPp1t16bQIhyFaKjLPGLCgIdbGWbz+sdypPz4Qfu+sdonmUf7qkZvGZ9
v9JzRbb+ZBua0acfDKWopd+hKZz/pc0uRp3YfoDK9yYVv+5QYKH9CWiPKCOSlNxg
ZhmLeLZIO7Qafm6bQuYX+FlMy/EYv//fgRR4W4I/gnLcOzVh8UZZt2g04QhSjFe+
89Wu4kXWvelhTtx7IynCPRn+l+iNcPJPpZtLgCoVhUalNQytQ938D+oBSgUT8JgJ
079v9A11+h+522NemEuAaFb5dfpPBCSepAo3EjIYzNsv0jT1wnFJp+TRELwRgJ1G
yC1GsDzoUz86HsCQ2DaDyDtW4JJV3A==
=eczq
-----END PGP SIGNATURE-----

--tl4v7hwjfkdh3za7--
