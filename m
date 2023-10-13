Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F08A7C7EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjJMHvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjJMHvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:51:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CE3CA;
        Fri, 13 Oct 2023 00:50:58 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-325e9cd483eso1746983f8f.2;
        Fri, 13 Oct 2023 00:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697183457; x=1697788257; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zv2n61VBsq2mcqHoTV6jBdn/VB73fJy0U9y8ByOkexw=;
        b=PnSAlIWenJxFY6mU6evQquPhfYQqtgsJG9jhw04PS+xQpKraudFg+GEQvsWBk1ywvH
         PbqJiy9sgCut21f5bK+AWNrTi47GyCXgYJJUAOpQK0U1JpyuwXkE/ZqZRFb+0SUyQkeB
         m7iG3khjKgF9jyOcqTAUYWyNF/QNzgYPHbyds+l0kvE7DbET/ky8x4AhdLg3NDA1eszM
         QnCiDTu+vAb+yLKxcxzgoQwJMWvwUDA+YTbUGnOIvN/rmxZQGkixMY9gVnjBKPK8XZfW
         nENONMZsXxYwV5xp0wAhbTAzUzGopTl2stLKBAVWPiOgedxnsJDJlBML/yeiGy8pgaM2
         Rvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697183457; x=1697788257;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zv2n61VBsq2mcqHoTV6jBdn/VB73fJy0U9y8ByOkexw=;
        b=iZz4PthCntVxYldCIM6DUTgZ9CmXhTZoVLOIQV6nxEdjZERE9NiZj/mlbTaQwSHLcw
         coL68azvfhG7u5Q6FMmNYZDmxVkPD2RwFk1iEfsRUAXf49Fa4nvaF4Az0+h6WC1NiUns
         lSbTfc58UyuJj1Xk3FItd6l7ZHGlLzna9zIwXRLCnhf9CtF31lY+YS5qz7Y8B5n0fGiH
         1/+VrNuVVgih6i4GEQgRPJUr82tkryQlrEZxTrIRa3foWoeuc9XwHe4SmmuR18QdP2Re
         oXCUVENzDD3bi9DNeEF/YuC6wPnUJrqqtWrNo4bmF9nqFlJ2ixRpjjU9l+xQt6Ndf3di
         WEtQ==
X-Gm-Message-State: AOJu0YxFmFGgDhQPcQK452iD5fYdOzvWoHzbRp5T+45kgxr/eS2ph+lH
        ZjYeWsxyEJ2s8WdGm2pQI08=
X-Google-Smtp-Source: AGHT+IEYGxPAtx6P91C2r8HYfcPkxBIciNqThOnzhtot4yV6WsU0EJrOaPkDjhNXK3O/Uw5oE0QoPg==
X-Received: by 2002:a5d:6909:0:b0:31a:d551:c2c0 with SMTP id t9-20020a5d6909000000b0031ad551c2c0mr23146967wru.57.1697183456681;
        Fri, 13 Oct 2023 00:50:56 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:361b:8f29:1cbf:5e69? (p200300f6ef1b2000361b8f291cbf5e69.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:361b:8f29:1cbf:5e69])
        by smtp.gmail.com with ESMTPSA id b5-20020a056000054500b00326dd5486dcsm20232126wrf.107.2023.10.13.00.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 00:50:56 -0700 (PDT)
Message-ID: <56e2d1cbe6671bc6709926771602b3aa412c1656.camel@gmail.com>
Subject: Re: [PATCH] iio: resolver: ad2s1210: add support for adi,fixed-mode
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        nuno.sa@analog.com, linux-kernel@vger.kernel.org
Date:   Fri, 13 Oct 2023 09:53:45 +0200
In-Reply-To: <20231012204509.3095010-1-dlechner@baylibre.com>
References: <20231012204509.3095010-1-dlechner@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Couple of minor things...

On Thu, 2023-10-12 at 15:45 -0500, David Lechner wrote:
> It is possible to use the AD2S1210 with hardwired mode pins (A0 and A1).
> According to the devicetree bindings, in this case the adi,fixed-mode
> property will specify which of the 3 possible modes the mode pins are
> hardwired for and the gpio-modes property is not allowed.
>=20
> This adds support for the case where the mode pins are hardwired for
> config mode. In this configuration, the position and velocity must be rea=
d
> from the config register.
>=20
> The cases of hardwired position or velocity modes is not supported as
> there would be no way to configure the device.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> =C2=A0drivers/iio/resolver/ad2s1210.c | 193 +++++++++++++++++++++++++++--=
---
> =C2=A01 file changed, 162 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1=
210.c
> index 1bd1b950e7cc..e6d3f31d529f 100644
> --- a/drivers/iio/resolver/ad2s1210.c
> +++ b/drivers/iio/resolver/ad2s1210.c
> @@ -141,7 +141,7 @@ struct ad2s1210_state {
> =C2=A0	struct spi_device *sdev;
> =C2=A0	/** GPIO pin connected to SAMPLE line. */
> =C2=A0	struct gpio_desc *sample_gpio;
> -	/** GPIO pins connected to A0 and A1 lines. */
> +	/** GPIO pins connected to A0 and A1 lines (optional). */
> =C2=A0	struct gpio_descs *mode_gpios;
> =C2=A0	/** Used to access config registers. */
> =C2=A0	struct regmap *regmap;
> @@ -149,6 +149,8 @@ struct ad2s1210_state {
> =C2=A0	unsigned long clkin_hz;
> =C2=A0	/** Available raw hysteresis values based on resolution. */
> =C2=A0	int hysteresis_available[2];
> +	/* adi,fixed-mode property - only valid when mode_gpios =3D=3D NULL. */
> +	enum ad2s1210_mode fixed_mode;
> =C2=A0	/** The selected resolution */
> =C2=A0	enum ad2s1210_resolution resolution;
> =C2=A0	/** Copy of fault register from the previous read. */
> @@ -175,6 +177,9 @@ static int ad2s1210_set_mode(struct ad2s1210_state *s=
t,
> enum ad2s1210_mode mode)
> =C2=A0	struct gpio_descs *gpios =3D st->mode_gpios;
> =C2=A0	DECLARE_BITMAP(bitmap, 2);
> =C2=A0
> +	if (!gpios)
> +		return mode =3D=3D st->fixed_mode ? 0 : -EOPNOTSUPP;
> +
> =C2=A0	bitmap[0] =3D mode;
> =C2=A0
> =C2=A0	return gpiod_set_array_value(gpios->ndescs, gpios->desc, gpios->in=
fo,
> @@ -276,7 +281,8 @@ static int ad2s1210_regmap_reg_read(void *context,
> unsigned int reg,
> =C2=A0	 * parity error. The fault register is read-only and the D7 bit me=
ans
> =C2=A0	 * something else there.
> =C2=A0	 */
> -	if (reg !=3D AD2S1210_REG_FAULT && st->rx[1] & AD2S1210_ADDRESS_DATA)
> +	if ((reg > AD2S1210_REG_VELOCITY_LSB && reg !=3D AD2S1210_REG_FAULT)
> +	=C2=A0=C2=A0=C2=A0=C2=A0 && st->rx[1] & AD2S1210_ADDRESS_DATA)
> =C2=A0		return -EBADMSG;
> =C2=A0
> =C2=A0	*val =3D st->rx[1];
> @@ -437,6 +443,40 @@ static void ad2s1210_push_events(struct iio_dev
> *indio_dev,
> =C2=A0	st->prev_fault_flags =3D flags;
> =C2=A0}
> =C2=A0
> +/**
> + * Reads position or velocity from the config registers.
> + *
> + * This is used when the mode gpios are not available.
> + *
> + * Must be called with the lock held.
> + *
> + * @param st The device state.
> + * @param val Pointer to hold the value read.
> + * @param msb_reg The register address of the MSB register.
> + * @param lsb_reg The register address of the LSB register.
> + * @return 0 on success, negative error code otherwise.
> + */
> +static int ad2s1210_read_val_from_config(struct ad2s1210_state *st, __be=
16
> *val,
> +					 u8 msb_reg, u8 lsb_reg)
> +{
> +	unsigned int reg_val;
> +	int ret;
> +
> +	ret =3D regmap_read(st->regmap, msb_reg, &reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	((u8 *)val)[0] =3D reg_val;
> +
> +	ret =3D regmap_read(st->regmap, lsb_reg, &reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	((u8 *)val)[1] =3D reg_val;

These casts are not that nice... Is sparse even ok with this without __forc=
e?
I didn't looked at the datasheet so I have no idea but is regmap_bulk_read(=
) an
option? It would simplify things.

> +
> +	return 0;
> +}

...

>=20
> =C2=A0	ad2s1210_push_events(indio_dev, st->sample.fault, pf->timestamp);
> @@ -1299,9 +1397,33 @@ static const struct iio_info ad2s1210_info =3D {
> =C2=A0static int ad2s1210_setup_properties(struct ad2s1210_state *st)
> =C2=A0{
> =C2=A0	struct device *dev =3D &st->sdev->dev;
> +	const char *str_val;
> =C2=A0	u32 val;
> =C2=A0	int ret;
> =C2=A0
> +	ret =3D device_property_read_string(dev, "adi,fixed-mode", &str_val);
> +	if (ret =3D=3D -EINVAL)
> +		st->fixed_mode =3D -1;
> +	else if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +			"failed to read adi,fixed-mode property\n");
> +	else {
> +		if (strcmp(str_val, "position") =3D=3D 0)
> +			st->fixed_mode =3D MOD_POS;
> +		else if (strcmp(str_val, "velocity") =3D=3D 0)
> +			st->fixed_mode =3D MOD_VEL;
> +		else if (strcmp(str_val, "config") =3D=3D 0)
> +			st->fixed_mode =3D MOD_CONFIG;
> +		else
> +			return dev_err_probe(dev, -EINVAL,
> +				"invalid adi,fixed-mode property value:
> %s\n",
> +				str_val);
> +
> +		if (st->fixed_mode !=3D MOD_CONFIG)
> +			return dev_err_probe(dev, -EINVAL,
> +				"only adi,fixed-mode=3D\"config\" is
> supported\n");

Why not?

if (strcmp(str_val, "config"))
	return dev_err_probe();

st->fixed_mode =3D MOD_CONFIG;

Am I missing something obvious?

- Nuno S=C3=A1
