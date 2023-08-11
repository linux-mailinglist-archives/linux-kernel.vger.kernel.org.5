Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3611778AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbjHKKHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHKKHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:07:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E38DEA;
        Fri, 11 Aug 2023 03:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D984360F97;
        Fri, 11 Aug 2023 10:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD18C433C7;
        Fri, 11 Aug 2023 10:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691748463;
        bh=HHqgty3rovQxNjR0U0Pr3TlDn756khOb1WS3upeemtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dG84dKM0MxtSx69ZuflemSKTdcdYelrPelyz6J17st9AWk5/kDx3tBkhS+TFoVayl
         CREee+MKgtB4DPlq9XaVuAaxokPeqwYFq2Unt9l8CIPvltiAaoTQqHBG5dosYIhUTM
         2LFoAx9e2ofKcz0E6B20O/IoajsfAtfEi7rHrIS/EijQFawJ0elNdny/Xeg7lz43uU
         l4Xs4bxAm8qaGpkulVGqqYbxhlLyAetqgpNMoZNy9289tR6Jgr+E6YlGBVvBlT7qyt
         8NG1ENx+dldnPClmRtqSc49txG1aXwOQwEtjdO9wfif35iKL1TOw3MxiWaT7gVBgr+
         W4+AmkR6Mb6Pg==
Date:   Fri, 11 Aug 2023 12:07:37 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mario Tesi <mario.tesi@st.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: lsm6dsx: Support temperature channel
Message-ID: <ZNYIaagdt7HuRet5@lore-rh-laptop>
References: <20230811-iio-spacex-lsm6ds0-v1-0-e953a440170d@linaro.org>
 <20230811-iio-spacex-lsm6ds0-v1-1-e953a440170d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b/r7Mr9rznlcEMbf"
Content-Disposition: inline
In-Reply-To: <20230811-iio-spacex-lsm6ds0-v1-1-e953a440170d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b/r7Mr9rznlcEMbf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The LSM6DSX (possibly other ST IMUs as well) has a temperature
> channel that can be read out. Modify the lsm6dsx core to
> accomodate temperature readout: make headspace for three
> members in the channels and odr_table, support offset and make
> the available milli_hz frequency resolution optional.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
[...]
>  static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] =3D=
 {
>  	{
>  		.reset =3D {
> @@ -835,6 +840,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_s=
ensor_settings[] =3D {
>  				.chan =3D st_lsm6dsx_gyro_channels,
>  				.len =3D ARRAY_SIZE(st_lsm6dsx_gyro_channels),
>  			},
> +			[ST_LSM6DSX_ID_TEMP] =3D {
> +				.chan =3D st_lsm6dsx_temp_channels,
> +				.len =3D ARRAY_SIZE(st_lsm6dsx_temp_channels),
> +			},
>  		},
>  		.drdy_mask =3D {
>  			.addr =3D 0x13,
> @@ -869,6 +878,15 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_s=
ensor_settings[] =3D {
>  				.odr_avl[6] =3D { 833000, 0x07 },
>  				.odr_len =3D 7,
>  			},
> +			[ST_LSM6DSX_ID_TEMP] =3D {
> +				.reg =3D {
> +					.addr =3D 0x0A,
> +					.mask =3D GENMASK(5, 4),
> +				},

looking at the ISM330DHCX datasheet, the temperature sensor ODR is just 52H=
z,
while values in 0x0A register are used only for FIFO decimation, they are n=
ot
values you can configure the sensor e.g. for read_one_shot().

> +				.odr_avl[0] =3D {  26000, 0x02 },
> +				.odr_avl[1] =3D {  52000, 0x03 },
> +				.odr_len =3D 2,
> +			},
>  		},
>  		.fs_table =3D {
>  			[ST_LSM6DSX_ID_ACC] =3D {
> @@ -937,6 +955,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_s=
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
> @@ -1661,6 +1683,7 @@ st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor=
, u32 req_odr)
>  	switch (sensor->id) {
>  	case ST_LSM6DSX_ID_GYRO:
>  		break;
> +	case ST_LSM6DSX_ID_TEMP:
>  	case ST_LSM6DSX_ID_EXT0:
>  	case ST_LSM6DSX_ID_EXT1:
>  	case ST_LSM6DSX_ID_EXT2:
> @@ -1800,6 +1823,10 @@ static int st_lsm6dsx_read_raw(struct iio_dev *iio=
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
> @@ -2016,9 +2043,11 @@ st_lsm6dsx_sysfs_sampling_frequency_avail(struct d=
evice *dev,
> =20
>  	odr_table =3D &sensor->hw->settings->odr_table[sensor->id];
>  	for (i =3D 0; i < odr_table->odr_len; i++)
> -		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%d.%03d ",
> -				 odr_table->odr_avl[i].milli_hz / 1000,
> -				 odr_table->odr_avl[i].milli_hz % 1000);
> +		if (odr_table->odr_avl[i].milli_hz) {
> +			len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%d.%03d ",
> +					 odr_table->odr_avl[i].milli_hz / 1000,
> +					 odr_table->odr_avl[i].milli_hz % 1000);
> +		}
>  	buf[len - 1] =3D '\n';
> =20
>  	return len;
> @@ -2106,6 +2135,22 @@ static const struct iio_info st_lsm6dsx_gyro_info =
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
> @@ -2379,7 +2424,16 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(str=
uct st_lsm6dsx_hw *hw,
>  	sensor->id =3D id;
>  	sensor->hw =3D hw;
>  	sensor->odr =3D hw->settings->odr_table[id].odr_avl[0].milli_hz;

here ODR should be 52 I guess

> -	sensor->gain =3D hw->settings->fs_table[id].fs_avl[0].gain;
> +	if (id =3D=3D ST_LSM6DSX_ID_TEMP) {
> +		/*
> +		 * The temperature sensor has a fixed scale and offset such
> +		 * that: temp_C =3D (raw / 256) + 25
> +		 */
> +		sensor->gain =3D 3906;
> +		sensor->offset =3D 25;


I was wondering about the 25 costant value since ISM330DHCX ds does not pro=
vide
a typical value. Maybe we should provide a way for the user to configure it?

> +	} else {
> +		sensor->gain =3D hw->settings->fs_table[id].fs_avl[0].gain;
> +	}
>  	sensor->watermark =3D 1;
> =20
>  	switch (id) {
> @@ -2393,6 +2447,11 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(str=
uct st_lsm6dsx_hw *hw,
>  		scnprintf(sensor->name, sizeof(sensor->name), "%s_gyro",
>  			  name);
>  		break;
> +	case ST_LSM6DSX_ID_TEMP:
> +		iio_dev->info =3D &st_lsm6dsx_temp_info;
> +		scnprintf(sensor->name, sizeof(sensor->name), "%s_temp",
> +			  name);

Regards,
Lorenzo

> +		break;
>  	default:
>  		return NULL;
>  	}
>=20
> --=20
> 2.34.1
>=20

--b/r7Mr9rznlcEMbf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZNYIZwAKCRA6cBh0uS2t
rLRAAP0ZpysPS8KRJhWhSxzNKTu6ZksYK3TsBVCknpWZrVPT8QEAgmjFZ8MSofKv
Cle6tfNnkqn5BvPKAu7rAUV2qnKM/AI=
=Sz4h
-----END PGP SIGNATURE-----

--b/r7Mr9rznlcEMbf--
