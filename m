Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4E578E92C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240727AbjHaJSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjHaJSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:18:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4D9194;
        Thu, 31 Aug 2023 02:18:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EB9AB821F0;
        Thu, 31 Aug 2023 09:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83600C433C7;
        Thu, 31 Aug 2023 09:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693473510;
        bh=TghKzhtzInTbNd94epYbxbWW1bTFyJLNwaYsPJklaGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kb8HADBE9koZxowHCox94kI3XM2BPa+qUX3rdP2aem01OXoPxc/KvGRHjxb/gsjlE
         nc3PvBwRzxRpnfHzTqgZQgxhmCtjDeggKJKfYXAKn678J2/YLLUEi9Gwq2c6gSZHaA
         WNPuHZhT2TJMldWfWtuHpAz3QjZh42U7DLp5AJs/jWbRhe4bCFNUaZZE1kmSjEnBYm
         GrWCMS9iqQ30MDrrUMvfP9dqb80TVwSs+0nlE/yPd6FrJ6/43fvnAonpOfNeMqtwN6
         UrfZ3QheZmhe7bkOU6d90DOFON8YU2VlhIsHO7GklLfJaHa8ByM6Wh0E1daDwjEQWu
         TG+zdzGUuBdog==
Date:   Thu, 31 Aug 2023 11:18:27 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Kevin Bosien <kbosien@spacex.com>, Jim Gruen <jgruen@spacex.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mario Tesi <mario.tesi@st.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RFC: iio: lsm6dsx: Support temperature channel on
 some devices
Message-ID: <ZPBa40RHJ93proj0@lore-desk>
References: <20230829-iio-spacex-lsm6ds0-v2-1-584e161b612f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="28VPyD9tiEjc7eLv"
Content-Disposition: inline
In-Reply-To: <20230829-iio-spacex-lsm6ds0-v2-1-584e161b612f@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--28VPyD9tiEjc7eLv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The ISM330 sensors (wai 0x6b) has a temperature channel that can
> be read out. Modify the lsm6dsx core to accomodate temperature
> readout on these sensors:
>=20
> - Make headspace for three members in the channels and odr_table,
> - Support offset
> - Add code to avoid configuring the ODR of the temperature
>   sensor, it has no real ODR control register.
>=20
> This is investigated because the hardware has important real-life
> use cases using the Linux kernel.

Hi Linus,

please seem my comments inline below.

Regards,
Lorenzo

>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> The ISM330DHCX is used in the SpaceX Starlink terminals which
> are running a realtime patched close-to-mainline Linux kernel so
> let's support temperature readout on it because why not.
> SpaceX is using the temperature.
> ---
> Changes in v2:
> - Put to RFC because I can't test changes.
> - Added some mail addresses to SpaceX to the header. Maybe you
>   guys can check if this works for you. Or forward to designated
>   open source ambassador or whatever can help. (Addresses found
>   in SpaceX code drop.)
> - Drop the code with strings for ism330dhc as we concluded that
>   this is probably ism330dhcx which is already supported.
>   (Would be nice if SpaceX can confirm.)
> - Don't write in nonsense register 0x0a for temperature sensor
> - More elaborate code to just avoid writing ODR for the temperature
>   sensor and instead rely on gyro or accelerometer to drive
>   the odr
> - Link to v1: https://lore.kernel.org/r/20230811-iio-spacex-lsm6ds0-v1-0-=
e953a440170d@linaro.org
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 24 +++++++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c |  4 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 79 ++++++++++++++++++++=
+++++-
>  3 files changed, 102 insertions(+), 5 deletions(-)
>=20

[...]

>  		},
>  		.drdy_mask =3D {
>  			.addr =3D 0x13,
> @@ -869,6 +878,17 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_s=
ensor_settings[] =3D {
>  				.odr_avl[6] =3D { 833000, 0x07 },
>  				.odr_len =3D 7,
>  			},
> +			[ST_LSM6DSX_ID_TEMP] =3D {
> +				/*
> +				 * NOTE: this ODR will be capped and controllerd by the
> +				 * gyro and accelerometer don't have any reg to configure
> +				 * this ODR.
> +				 */
> +				.odr_avl[0] =3D {  12500, 0x01 },
> +				.odr_avl[1] =3D {  26000, 0x02 },
> +				.odr_avl[2] =3D {  52000, 0x03 },
> +				.odr_len =3D 3,

please consider we do not support low-power mode iirc (just high-performanc=
e -
bit 4 in CTRL6_C (15h)), so even enabling accel sensor, the temp sensor will
always runs at 52Hz. Here we should add just one entry, like:

				.odr_avl[0] =3D { 52000, 0x03 },
				.odr_len =3D 1,

> +			},
>  		},
>  		.fs_table =3D {
>  			[ST_LSM6DSX_ID_ACC] =3D {
> @@ -937,6 +957,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_s=
ensor_settings[] =3D {
>  				.addr =3D 0x09,
>  				.mask =3D GENMASK(7, 4),
>  			},
> +			[ST_LSM6DSX_ID_TEMP] =3D {
> +				.addr =3D 0x0A,
> +				.mask =3D GENMASK(5, 4),
> +			},
>  		},
>  		.fifo_ops =3D {
>  			.update_fifo =3D st_lsm6dsx_update_fifo,
> @@ -1618,8 +1642,8 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *=
sensor, u32 odr, u8 *val)
>  	odr_table =3D &sensor->hw->settings->odr_table[sensor->id];
>  	for (i =3D 0; i < odr_table->odr_len; i++) {
>  		/*
> -		 * ext devices can run at different odr respect to
> -		 * accel sensor
> +		 * ext devices and temp sensor can run at different odr
> +		 * respect to accel sensor
>  		 */
>  		if (odr_table->odr_avl[i].milli_hz >=3D odr)
>  			break;
> @@ -1661,6 +1685,21 @@ st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *senso=
r, u32 req_odr)
>  	switch (sensor->id) {
>  	case ST_LSM6DSX_ID_GYRO:
>  		break;
> +	case ST_LSM6DSX_ID_TEMP:
> +		/*
> +		 * According to the application note AN5398 Rev 3
> +		 * for ISM330DHCX, section 10, page 109
> +		 * the ODR for the temperature sensor is equal to the
> +		 * accelerometer ODR if the gyroscope is powered-down,
> +		 * up to 52 Hz, but constant 52 Hz if the gyroscope
> +		 * is powered on. It never goes above 52 Hz.
> +		 */
> +		ref_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_GYRO]);
> +		if ((req_odr > 0) && (hw->enable_mask |=3D BIT(ref_sensor->id)))

is there a typo here?

> +			/* Gyro is on! ODR fixed to 52 Hz */
> +			return 0;
> +		/* We fall through and activate accelerometer if need be */
> +		fallthrough;

I do not think this approach works since please consider what happens with =
the
sequence of events reported below:
- user enables gyro sensor
- user enables temp sensor
- user disables gyro sensor

IIUC the accel sensor is not enabled in this case so even the temp one will=
 be
powered-down. Is it correct?
I think for the temp sensor we should introduce a dependency from the gyro =
one,
doing something like (just compiled, not tested):

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu=
/st_lsm6dsx/st_lsm6dsx_core.c
index 6a18b363cf73..ccd0d48bfb35 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1633,19 +1633,36 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *=
sensor, u32 odr, u8 *val)
 }
=20
 static int
-st_lsm6dsx_check_odr_dependency(struct st_lsm6dsx_hw *hw, u32 odr,
-				enum st_lsm6dsx_sensor_id id)
+st_lsm6dsx_check_odr_dependency(struct st_lsm6dsx_sensor *sensor,
+				enum st_lsm6dsx_sensor_id *odr_map,
+				int odr_map_size, u32 req_odr)
 {
-	struct st_lsm6dsx_sensor *ref =3D iio_priv(hw->iio_devs[id]);
+	struct st_lsm6dsx_hw *hw =3D sensor->hw;
+	int i;
=20
-	if (odr > 0) {
-		if (hw->enable_mask & BIT(id))
-			return max_t(u32, ref->odr, odr);
-		else
-			return odr;
-	} else {
-		return (hw->enable_mask & BIT(id)) ? ref->odr : 0;
+	for (i =3D 0; i < odr_map_size; i++) {
+		enum st_lsm6dsx_sensor_id id =3D odr_map[i];
+		struct st_lsm6dsx_sensor *ref =3D iio_priv(hw->iio_devs[id]);
+		u32 odr;
+
+		if (!hw->iio_devs[id] || id =3D=3D sensor->id)
+			continue;
+
+		if (req_odr) {
+			if (hw->enable_mask & BIT(id))
+				odr =3D max_t(u32, ref->odr, req_odr);
+			else
+				odr =3D req_odr;
+		} else {
+			odr =3D hw->enable_mask & BIT(id) ? ref->odr : 0;
+		}
+
+		if (odr !=3D req_odr)
+			/* device already configured */
+			return -EBUSY;
 	}
+
+	return 0;
 }
=20
 static int
@@ -1659,14 +1676,30 @@ st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor=
, u32 req_odr)
 	int err;
=20
 	switch (sensor->id) {
-	case ST_LSM6DSX_ID_GYRO:
+	case ST_LSM6DSX_ID_TEMP:
+	case ST_LSM6DSX_ID_GYRO: {
+		enum st_lsm6dsx_sensor_id odr_dep_map[] =3D {
+			ST_LSM6DSX_ID_GYRO,
+			ST_LSM6DSX_ID_TEMP,
+		};
+
+		ref_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_GYRO]);
+		if (st_lsm6dsx_check_odr_dependency(sensor, odr_dep_map,
+						    ARRAY_SIZE(odr_dep_map),
+						    req_odr))
+			return 0;
 		break;
+	}
 	case ST_LSM6DSX_ID_EXT0:
 	case ST_LSM6DSX_ID_EXT1:
 	case ST_LSM6DSX_ID_EXT2:
 	case ST_LSM6DSX_ID_ACC: {
-		u32 odr;
-		int i;
+		enum st_lsm6dsx_sensor_id odr_dep_map[] =3D {
+			ST_LSM6DSX_ID_ACC,
+			ST_LSM6DSX_ID_EXT0,
+			ST_LSM6DSX_ID_EXT1,
+			ST_LSM6DSX_ID_EXT2,
+		};
=20
 		/*
 		 * i2c embedded controller relies on the accelerometer sensor as
@@ -1675,15 +1708,10 @@ st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor=
, u32 req_odr)
 		 * communicate with i2c slave devices
 		 */
 		ref_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
-		for (i =3D ST_LSM6DSX_ID_ACC; i < ST_LSM6DSX_ID_MAX; i++) {
-			if (!hw->iio_devs[i] || i =3D=3D sensor->id)
-				continue;
-
-			odr =3D st_lsm6dsx_check_odr_dependency(hw, req_odr, i);
-			if (odr !=3D req_odr)
-				/* device already configured */
-				return 0;
-		}
+		if (st_lsm6dsx_check_odr_dependency(sensor, odr_dep_map,
+						    ARRAY_SIZE(odr_dep_map),
+						    req_odr))
+			return 0;
 		break;
 	}
 	default: /* should never occur */

What do you think? If you agree I can post it as preliminary patch (removin=
g temp dependency).

Regards,
Lorenzo

>  	case ST_LSM6DSX_ID_EXT0:
>  	case ST_LSM6DSX_ID_EXT1:
>  	case ST_LSM6DSX_ID_EXT2:
> @@ -1800,6 +1839,10 @@ static int st_lsm6dsx_read_raw(struct iio_dev *iio=
_dev,
>  		*val2 =3D sensor->gain;
>  		ret =3D IIO_VAL_INT_PLUS_NANO;
>  		break;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val =3D sensor->offset;
> +		ret =3D IIO_VAL_INT;
> +		break;
>  	default:
>  		ret =3D -EINVAL;
>  		break;
> @@ -2106,6 +2149,22 @@ static const struct iio_info st_lsm6dsx_gyro_info =
=3D {
>  	.write_raw_get_fmt =3D st_lsm6dsx_write_raw_get_fmt,
>  };
> =20
> +static struct attribute *st_lsm6dsx_temp_attributes[] =3D {
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group st_lsm6dsx_temp_attribute_group =3D {
> +	.attrs =3D st_lsm6dsx_temp_attributes,
> +};
> +
> +static const struct iio_info st_lsm6dsx_temp_info =3D {
> +	.attrs =3D &st_lsm6dsx_temp_attribute_group,
> +	.read_raw =3D st_lsm6dsx_read_raw,
> +	.write_raw =3D st_lsm6dsx_write_raw,
> +	.hwfifo_set_watermark =3D st_lsm6dsx_set_watermark,
> +};
> +
>  static int st_lsm6dsx_get_drdy_pin(struct st_lsm6dsx_hw *hw, int *drdy_p=
in)
>  {
>  	struct device *dev =3D hw->dev;
> @@ -2379,7 +2438,16 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(str=
uct st_lsm6dsx_hw *hw,
>  	sensor->id =3D id;
>  	sensor->hw =3D hw;
>  	sensor->odr =3D hw->settings->odr_table[id].odr_avl[0].milli_hz;
> -	sensor->gain =3D hw->settings->fs_table[id].fs_avl[0].gain;
> +	if (id =3D=3D ST_LSM6DSX_ID_TEMP) {
> +		/*
> +		 * The temperature sensor has a fixed scale and offset such
> +		 * that: temp_C =3D (raw / 256) + 25
> +		 */
> +		sensor->gain =3D 3906;
> +		sensor->offset =3D 25;
> +	} else {
> +		sensor->gain =3D hw->settings->fs_table[id].fs_avl[0].gain;
> +	}
>  	sensor->watermark =3D 1;
> =20
>  	switch (id) {
> @@ -2393,6 +2461,11 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(str=
uct st_lsm6dsx_hw *hw,
>  		scnprintf(sensor->name, sizeof(sensor->name), "%s_gyro",
>  			  name);
>  		break;
> +	case ST_LSM6DSX_ID_TEMP:
> +		iio_dev->info =3D &st_lsm6dsx_temp_info;
> +		scnprintf(sensor->name, sizeof(sensor->name), "%s_temp",
> +			  name);
> +		break;
>  	default:
>  		return NULL;
>  	}
>=20
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230811-iio-spacex-lsm6ds0-33c9365e94bf
>=20
> Best regards,
> --=20
> Linus Walleij <linus.walleij@linaro.org>
>=20

--28VPyD9tiEjc7eLv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZPBa4wAKCRA6cBh0uS2t
rHmXAP0XxTxic9j4NFijs1At83qOHFDG1F+KoWodxwYgbUql+AD+NySX6BdCXpTJ
1w9tA4CcuF6Cly9AN3L7jdaACPsPUgA=
=NgAx
-----END PGP SIGNATURE-----

--28VPyD9tiEjc7eLv--
