Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976787CBD49
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbjJQIX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjJQIX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:23:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8790AB;
        Tue, 17 Oct 2023 01:23:55 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ba1eb73c27so887964266b.3;
        Tue, 17 Oct 2023 01:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697531034; x=1698135834; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zdobFbvKLNEImXmZ+Wu3dKqo7l84BXOhHQ5MX3lKCaQ=;
        b=RDqXWIy1BxrteMoeKQ7B9PwcrGnkHyaorqaxlGhaBwaaOiEmKlRKspe+Sq1+2lTGgU
         pI/1408bHnbvbzisyjCAXnMH2/Dwn47UGIDL377TSIkqQGONpxc+XaMxuxGC3d1qIOKI
         3IOlKRdqW/116dmrAQDUMSCkQHcz68WSiAll9NLdIXfayPR3LpEenvUg8+j1ZbDXvqmr
         xsABONQqE2pyM3zWfvS3ta1zNy6aM8j641uzMAIlqmWM06Plt7nfsX4/f5e8BN6eAxdX
         UplDktMHuNmaWtwWlHNgwKWB3fe7iUvIexwD7MwSXVh3xUsUXwbRMLVkOgXi0zaout0/
         HM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697531034; x=1698135834;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdobFbvKLNEImXmZ+Wu3dKqo7l84BXOhHQ5MX3lKCaQ=;
        b=DJgmNp1HrhPz/5gxsg3E5lDp6kQJkogF+FUSf5SfFsp7hwAOh1lbTGeq3UJp0JJ/7a
         sBWIqaQBngbVQfpM1rMHjIUhY/kNVXcMojKPxANz0OZqK3WP5n3GwihjqmMyeU3Ks2uG
         MipT0enGyvPzvSXgXmtCnJTOMUVvceihCYFMEyozdaUYsIl6+yPD5qSj4jjo4OLUaa9F
         QJsb9ZqZInjarRItE/ZJLSMb6ga59WMjFHe4HSkioAtiQlOhBYt8VkfEZFAFhZwmUHHZ
         pgzEjgwcUyLucWVUySCG2VHZM/fn0eV6PsIUbvqt/dHk+XqtOtIN79RvnvIop/XhkrNT
         fRQg==
X-Gm-Message-State: AOJu0Yw7CpzJsAGZOu8IMoRYZU1CUhf9yJ/h15phU1jXcKMc2J+IY6eU
        v/1ytEwqxJC6tvK+330lyDI=
X-Google-Smtp-Source: AGHT+IEr8GdYNvqCzsbbqlXFzwWn54d/UDZ4XAbquruDRjTPvyesDe4afSUBX9uN5g7o6Jehrc/rSQ==
X-Received: by 2002:a17:907:7248:b0:9a1:fb4c:3b6c with SMTP id ds8-20020a170907724800b009a1fb4c3b6cmr1174441ejc.59.1697531033894;
        Tue, 17 Oct 2023 01:23:53 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:361b:8f29:1cbf:5e69? (p200300f6ef1b2000361b8f291cbf5e69.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:361b:8f29:1cbf:5e69])
        by smtp.gmail.com with ESMTPSA id ml20-20020a170906cc1400b009ad8acac02asm790657ejb.172.2023.10.17.01.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 01:23:53 -0700 (PDT)
Message-ID: <492e8f347d4682ff672f81151ab4b1fe7f5b3059.camel@gmail.com>
Subject: Re: [PATCH v2] iio: resolver: ad2s1210: add support for
 adi,fixed-mode
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        nuno.sa@analog.com, linux-kernel@vger.kernel.org
Date:   Tue, 17 Oct 2023 10:26:43 +0200
In-Reply-To: <20231016135423.16808-1-dlechner@baylibre.com>
References: <20231016135423.16808-1-dlechner@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-16 at 08:54 -0500, David Lechner wrote:
> It is possible to use the AD2S1210 with hardwired mode pins (A0 and A1).
> According to the devicetree bindings, in this case the adi,fixed-mode
> property will specify which of the 3 possible modes the mode pins are
> hardwired for and the gpio-modes property is not allowed.
>=20
> This adds support for the case where the mode pins are hardwired for
> config mode. In this configuration, the position and value must be read
> from the config register.
>=20
> The case of hardwired position or velocity mode is not supported as
> there would be no way to configure the device.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20

LGTM

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> v2 changes:
> * Use regmap_bulk_read() instead of new local function.
> * Simplify adi,fixed-mode property error checking.
>=20
> =C2=A0drivers/iio/resolver/ad2s1210.c | 150 +++++++++++++++++++++++++----=
---
> =C2=A01 file changed, 119 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1=
210.c
> index 1bd1b950e7cc..7f688bfe2172 100644
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
> @@ -450,21 +456,53 @@ static int ad2s1210_single_conversion(struct iio_de=
v
> *indio_dev,
> =C2=A0	ad2s1210_toggle_sample_line(st);
> =C2=A0	timestamp =3D iio_get_time_ns(indio_dev);
> =C2=A0
> -	switch (chan->type) {
> -	case IIO_ANGL:
> -		ret =3D ad2s1210_set_mode(st, MOD_POS);
> -		break;
> -	case IIO_ANGL_VEL:
> -		ret =3D ad2s1210_set_mode(st, MOD_VEL);
> -		break;
> -	default:
> -		return -EINVAL;
> +	if (st->fixed_mode =3D=3D MOD_CONFIG) {
> +		unsigned int reg_val;
> +
> +		switch (chan->type) {
> +		case IIO_ANGL:
> +			ret =3D regmap_bulk_read(st->regmap,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD2S1210_REG_POSITION_MSB,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &st->sample.raw, 2);
> +			if (ret < 0)
> +				return ret;
> +
> +			break;
> +		case IIO_ANGL_VEL:
> +			ret =3D regmap_bulk_read(st->regmap,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD2S1210_REG_VELOCITY_MSB,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &st->sample.raw, 2);
> +			if (ret < 0)
> +				return ret;
> +
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		ret =3D regmap_read(st->regmap, AD2S1210_REG_FAULT, &reg_val);
> +		if (ret < 0)
> +			return ret;
> +
> +		st->sample.fault =3D reg_val;
> +	} else {
> +		switch (chan->type) {
> +		case IIO_ANGL:
> +			ret =3D ad2s1210_set_mode(st, MOD_POS);
> +			break;
> +		case IIO_ANGL_VEL:
> +			ret =3D ad2s1210_set_mode(st, MOD_VEL);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D spi_read(st->sdev, &st->sample, 3);
> +		if (ret < 0)
> +			return ret;
> =C2=A0	}
> -	if (ret < 0)
> -		return ret;
> -	ret =3D spi_read(st->sdev, &st->sample, 3);
> -	if (ret < 0)
> -		return ret;
> =C2=A0
> =C2=A0	switch (chan->type) {
> =C2=A0	case IIO_ANGL:
> @@ -1252,27 +1290,53 @@ static irqreturn_t ad2s1210_trigger_handler(int i=
rq,
> void *p)
> =C2=A0	ad2s1210_toggle_sample_line(st);
> =C2=A0
> =C2=A0	if (test_bit(0, indio_dev->active_scan_mask)) {
> -		ret =3D ad2s1210_set_mode(st, MOD_POS);
> -		if (ret < 0)
> -			goto error_ret;
> -
> -		ret =3D spi_read(st->sdev, &st->sample, 3);
> -		if (ret < 0)
> -			goto error_ret;
> +		if (st->fixed_mode =3D=3D MOD_CONFIG) {
> +			ret =3D regmap_bulk_read(st->regmap,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD2S1210_REG_POSITION_MSB,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &st->sample.raw, 2);
> +			if (ret < 0)
> +				goto error_ret;
> +		} else {
> +			ret =3D ad2s1210_set_mode(st, MOD_POS);
> +			if (ret < 0)
> +				goto error_ret;
> +
> +			ret =3D spi_read(st->sdev, &st->sample, 3);
> +			if (ret < 0)
> +				goto error_ret;
> +		}
> =C2=A0
> =C2=A0		memcpy(&st->scan.chan[chan++], &st->sample.raw, 2);
> =C2=A0	}
> =C2=A0
> =C2=A0	if (test_bit(1, indio_dev->active_scan_mask)) {
> -		ret =3D ad2s1210_set_mode(st, MOD_VEL);
> -		if (ret < 0)
> -			goto error_ret;
> +		if (st->fixed_mode =3D=3D MOD_CONFIG) {
> +			ret =3D regmap_bulk_read(st->regmap,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD2S1210_REG_VELOCITY_MSB,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &st->sample.raw, 2);
> +			if (ret < 0)
> +				goto error_ret;
> +		} else {
> +			ret =3D ad2s1210_set_mode(st, MOD_VEL);
> +			if (ret < 0)
> +				goto error_ret;
> +
> +			ret =3D spi_read(st->sdev, &st->sample, 3);
> +			if (ret < 0)
> +				goto error_ret;
> +		}
> =C2=A0
> -		ret =3D spi_read(st->sdev, &st->sample, 3);
> +		memcpy(&st->scan.chan[chan++], &st->sample.raw, 2);
> +	}
> +
> +	if (st->fixed_mode =3D=3D MOD_CONFIG) {
> +		unsigned int reg_val;
> +
> +		ret =3D regmap_read(st->regmap, AD2S1210_REG_FAULT, &reg_val);
> =C2=A0		if (ret < 0)
> -			goto error_ret;
> +			return ret;
> =C2=A0
> -		memcpy(&st->scan.chan[chan++], &st->sample.raw, 2);
> +		st->sample.fault =3D reg_val;
> =C2=A0	}
> =C2=A0
> =C2=A0	ad2s1210_push_events(indio_dev, st->sample.fault, pf->timestamp);
> @@ -1299,9 +1363,24 @@ static const struct iio_info ad2s1210_info =3D {
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
> +		if (strcmp(str_val, "config"))
> +			return dev_err_probe(dev, -EINVAL,
> +				"only adi,fixed-mode=3D\"config\" is
> supported\n");
> +
> +		st->fixed_mode =3D MOD_CONFIG;
> +	}
> +
> =C2=A0	ret =3D device_property_read_u32(dev, "assigned-resolution-bits",
> &val);
> =C2=A0	if (ret < 0)
> =C2=A0		return dev_err_probe(dev, ret,
> @@ -1357,12 +1436,21 @@ static int ad2s1210_setup_gpios(struct ad2s1210_s=
tate
> *st)
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to request sample GPIO\n");
> =C2=A0
> =C2=A0	/* both pins high means that we start in config mode */
> -	st->mode_gpios =3D devm_gpiod_get_array(dev, "mode", GPIOD_OUT_HIGH);
> +	st->mode_gpios =3D devm_gpiod_get_array_optional(dev, "mode",
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GPIOD_OUT_HIGH);
> =C2=A0	if (IS_ERR(st->mode_gpios))
> =C2=A0		return dev_err_probe(dev, PTR_ERR(st->mode_gpios),
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to request mode GPIOs\n");
> =C2=A0
> -	if (st->mode_gpios->ndescs !=3D 2)
> +	if (!st->mode_gpios && st->fixed_mode =3D=3D -1)
> +		return dev_err_probe(dev, -EINVAL,
> +			"must specify either adi,fixed-mode or mode-
> gpios\n");
> +
> +	if (st->mode_gpios && st->fixed_mode !=3D -1)
> +		return dev_err_probe(dev, -EINVAL,
> +			"must specify only one of adi,fixed-mode or mode-
> gpios\n");
> +
> +	if (st->mode_gpios && st->mode_gpios->ndescs !=3D 2)
> =C2=A0		return dev_err_probe(dev, -EINVAL,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "requires exactly 2 mode-gpios\n");
> =C2=A0

