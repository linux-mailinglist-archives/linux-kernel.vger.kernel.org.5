Return-Path: <linux-kernel+bounces-99990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03290879063
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713721F22E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E9077F2F;
	Tue, 12 Mar 2024 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBe/H1KL"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D7377A03;
	Tue, 12 Mar 2024 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234520; cv=none; b=s4wUrzJkPmuoFLcWY4I7p4vjxIaUtrOnIQDo9NwjF1u8c+dW9BgM7nMIwInfaLTiG692PNYrLSQVxTXntXMkpwwsnRU2OOjxyLnKb3ceWz6ByMLKHgzQWJ8tA36mtrcyx9gjL3hyd8rG1x0TBkqblk2g4FfRgwQ6W/OgQqDnpeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234520; c=relaxed/simple;
	bh=ukSztBsSglx2TNZSXnpNCiegJM8kO05XL1ZJVzgY/AA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gCw/LV1RVenrOnWpHjVL7wFmvcR3PFz0QMgL8RKw1a3uqp3tuLo2GOj0HtmeJ3iX8BPtPmQ+3qN4vW6Q9aI+pGMpjoAhabclohEOg1ownD6bEgBFzfdUpbLRa/HRFO1CKAtyFzLRGRHpzuAav6WPDnaQsSomynzTSTEK2F5nxsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBe/H1KL; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so10985887a12.1;
        Tue, 12 Mar 2024 02:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710234516; x=1710839316; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T96FvsxYY1+xQtpMgDTuXuEBfsArSAWtQvXinsZOiNE=;
        b=eBe/H1KLUldFTn826unEFXeLKqwE5AJrLMiPSz4OTsbJrHB/fKi6WhGSbi1iVz9ju8
         wxEpQI9N4rHLwYNWvFrPIf6BcyNaxIZ26HOJPndkXu0ui1NpBJEus+4dlj2jwESSxOXD
         rpknqlN4eKPK7xbQQI7NDTHfHjCjNlsEPTzCPLA/tCJWZ+mVXrsTDyTWGCzNUrVYZJPU
         MkNmFofat/4DhDZbA7paaewHoSANVqtBhMnw+nGqPUZTUcIRi4ueru9EdwZgMcS5NrQf
         dd4oLyRSggvE0PbiQBxPKPZdNWEjVtSb4ftXatL4fTgjLEcKBabwcTvTeQ3zf7uu91TD
         Nk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710234516; x=1710839316;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T96FvsxYY1+xQtpMgDTuXuEBfsArSAWtQvXinsZOiNE=;
        b=Eg3b35DacJLb0+0NDsHsxwnwzYNuZQG2i2fdIterduCP13iob35qtUHCYlnU7j1Zs/
         ILgKqc3K9uGPuHc43iFF9VqHkdLGw3eEwkToWtBsv5yeUWpE9jngrJZtlHJUloi3IcmM
         LMUGjKkh2qkUP3Ck75VFJEEJS+qQJqDC6WuGxUv+XHaHxe5Xdoe3Y781zi+O9zJuDgef
         kd3VB6/S3mhtO+YwprqS4c88MD4DnsEAh07pUa2iHeRNjqHyTqWArnYkwDXZO5nnTyJf
         hxPjFJ+c0KMZ9zyBxeG9j/5+vV/5n596rriCXwbt8c4hysyko/Z0dRLgdIv23GyLDl6L
         f+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXwLzsWRvGWEjc8/+9g2kFp0Ku5EG/e3MId0/32CUos+MjcemwzZbelRIr7WCzrYRXVvPubHQq7sfxVLE8Vx9AGQk75UyA0axUyUblot0GreC2AmZW1K/pXjXqjjKkHaSdbnwHOFQS4
X-Gm-Message-State: AOJu0YwP79PhustBXMqQRhD6sCPq69D4UYbwnacIbBHDzcr308O8/7CY
	ERJf5dDklKdn+A38E7jFYZHmKsvHIIfyqd+1y88XpatzSxLsS5WdISnW/slvyr3eYg==
X-Google-Smtp-Source: AGHT+IHI72IVFRdcef20r7NQhdVEDmFlxq8bjiHReWIimP8PiHZm9ob9b5fi3T2Ag2UZG0ApqkfWWw==
X-Received: by 2002:a17:906:aec7:b0:a46:3792:204 with SMTP id me7-20020a170906aec700b00a4637920204mr2768309ejb.10.1710234515969;
        Tue, 12 Mar 2024 02:08:35 -0700 (PDT)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id j12-20020a170906474c00b00a45bd9ccb55sm3615335ejs.155.2024.03.12.02.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:08:35 -0700 (PDT)
Message-ID: <8ee551edeff9c4c959a4dbda53d1a2a26a9bb62c.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7944: Add support for "3-wire mode"
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 12 Mar 2024 10:08:35 +0100
In-Reply-To: <20240311-mainline-ad7944-3-wire-mode-v1-1-8e8199efa1f7@baylibre.com>
References: 
	<20240311-mainline-ad7944-3-wire-mode-v1-1-8e8199efa1f7@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-11 at 16:26 -0500, David Lechner wrote:
> This adds support for AD7944 ADCs wired in "3-wire mode". (NOTE: 3-wire
> is the datasheet name for this wiring configuration and has nothing to
> do with SPI_3WIRE.)
>=20
> In the 3-wire mode, the SPI controller CS line can be wired to the CNV
> line on the ADC and used to trigger conversions rather that using a
> separate GPIO line.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Just some minor stuff from me... With that addressed (at least the 'else if=
' stuff):

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7944.c | 157 ++++++++++++++++++++++++++++++++++++=
+++++------
> =C2=A01 file changed, 139 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> index adb007cdd287..8f466eb66bc4 100644
> --- a/drivers/iio/adc/ad7944.c
> +++ b/drivers/iio/adc/ad7944.c
> @@ -32,8 +32,25 @@ struct ad7944_timing_spec {
> =C2=A0	unsigned int turbo_conv_ns;
> =C2=A0};
> =C2=A0
> +enum ad7944_spi_mode {
> +	/* datasheet calls this "4-wire mode" */
> +	AD7944_SPI_MODE_DEFAULT,
> +	/* datasheet calls this "3-wire mode" (not related to SPI_3WIRE!) */
> +	AD7944_SPI_MODE_SINGLE,
> +	/* datasheet calls this "chain mode" */
> +	AD7944_SPI_MODE_CHAIN,
> +};
> +
> +/* maps adi,spi-mode property value to enum */
> +static const char * const ad7944_spi_modes[] =3D {
> +	[AD7944_SPI_MODE_DEFAULT] =3D "",
> +	[AD7944_SPI_MODE_SINGLE] =3D "single",
> +	[AD7944_SPI_MODE_CHAIN] =3D "chain",
> +};
> +
> =C2=A0struct ad7944_adc {
> =C2=A0	struct spi_device *spi;
> +	enum ad7944_spi_mode spi_mode;
> =C2=A0	/* Chip-specific timing specifications. */
> =C2=A0	const struct ad7944_timing_spec *timing_spec;
> =C2=A0	/* GPIO connected to CNV pin. */
> @@ -58,6 +75,9 @@ struct ad7944_adc {
> =C2=A0	 } sample __aligned(IIO_DMA_MINALIGN);
> =C2=A0};
> =C2=A0
> +/* quite time before CNV rising edge */
> +#define T_QUIET_NS	20
> +
> =C2=A0static const struct ad7944_timing_spec ad7944_timing_spec =3D {
> =C2=A0	.conv_ns =3D 420,
> =C2=A0	.turbo_conv_ns =3D 320,
> @@ -110,6 +130,65 @@ AD7944_DEFINE_CHIP_INFO(ad7985, ad7944, 16, 0);
> =C2=A0/* fully differential */
> =C2=A0AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 1);
> =C2=A0
> +/*
> + * ad7944_3wire_cs_mode_conversion - Perform a 3-wire CS mode conversion=
 and
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acquisition
> + * @adc: The ADC device structure
> + * @chan: The channel specification
> + * Return: 0 on success, a negative error code on failure
> + *
> + * This performs a conversion and reads data when the chip is wired in 3=
-wire
> + * mode with the CNV line on the ADC tied to the CS line on the SPI cont=
roller.
> + *
> + * Upon successful return adc->sample.raw will contain the conversion re=
sult.
> + */
> +static int ad7944_3wire_cs_mode_conversion(struct ad7944_adc *adc,
> +					=C2=A0=C2=A0 const struct iio_chan_spec *chan)
> +{
> +	unsigned int t_conv_ns =3D adc->always_turbo ? adc->timing_spec-
> >turbo_conv_ns
> +						=C2=A0=C2=A0 : adc->timing_spec->conv_ns;
> +	struct spi_transfer xfers[] =3D {
> +		{
> +			/*
> +			 * NB: can get better performance from some SPI
> +			 * controllers if we use the same bits_per_word
> +			 * in every transfer.
> +			 */
> +			.bits_per_word =3D chan->scan_type.realbits,
> +			/*
> +			 * CS is tied to CNV and we need a low to high
> +			 * transition to start the conversion, so place CNV
> +			 * low for t_QUIET to prepare for this.
> +			 */
> +			.delay =3D {
> +				.value =3D T_QUIET_NS,
> +				.unit =3D SPI_DELAY_UNIT_NSECS,
> +			},
> +
> +		},
> +		{
> +			.bits_per_word =3D chan->scan_type.realbits,
> +			/*
> +			 * CS has to be high for full conversion time to avoid
> +			 * triggering the busy indication.
> +			 */
> +			.cs_off =3D 1,
> +			.delay =3D {
> +				.value =3D t_conv_ns,
> +				.unit =3D SPI_DELAY_UNIT_NSECS,
> +			},
> +		},
> +		{
> +			/* Then we can read the data during the acquisition phase
> */
> +			.rx_buf =3D &adc->sample.raw,
> +			.len =3D BITS_TO_BYTES(chan->scan_type.storagebits),
> +			.bits_per_word =3D chan->scan_type.realbits,
> +		},
> +	};
> +
> +	return spi_sync_transfer(adc->spi, xfers, ARRAY_SIZE(xfers));
> +}
> +
> =C2=A0/*
> =C2=A0 * ad7944_4wire_mode_conversion - Perform a 4-wire mode conversion =
and acquisition
> =C2=A0 * @adc: The ADC device structure
> @@ -167,9 +246,22 @@ static int ad7944_single_conversion(struct ad7944_ad=
c *adc,
> =C2=A0{
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D ad7944_4wire_mode_conversion(adc, chan);
> -	if (ret)
> -		return ret;
> +	switch (adc->spi_mode) {
> +	case AD7944_SPI_MODE_DEFAULT:
> +		ret =3D ad7944_4wire_mode_conversion(adc, chan);
> +		if (ret)
> +			return ret;
> +
> +		break;
> +	case AD7944_SPI_MODE_SINGLE:
> +		ret =3D ad7944_3wire_cs_mode_conversion(adc, chan);
> +		if (ret)
> +			return ret;
> +
> +		break;
> +	case AD7944_SPI_MODE_CHAIN:
> +		return -EOPNOTSUPP;

This mode is not really supported for now and in theory we can't really hav=
e
adc->spi_mode =3D AD7944_SPI_MODE_CHAIN, right? So, I would just make this =
the
'default' branch and not care about chain mode (implementing it when adding=
 it).

> +	}
> =C2=A0
> =C2=A0	if (chan->scan_type.storagebits > 16)
> =C2=A0		*val =3D adc->sample.raw.u32;
> @@ -230,9 +322,23 @@ static irqreturn_t ad7944_trigger_handler(int irq, v=
oid *p)
> =C2=A0	struct ad7944_adc *adc =3D iio_priv(indio_dev);
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D ad7944_4wire_mode_conversion(adc, &indio_dev->channels[0]);
> -	if (ret)
> +	switch (adc->spi_mode) {
> +	case AD7944_SPI_MODE_DEFAULT:
> +		ret =3D ad7944_4wire_mode_conversion(adc, &indio_dev->channels[0]);
> +		if (ret)
> +			goto out;
> +
> +		break;
> +	case AD7944_SPI_MODE_SINGLE:
> +		ret =3D ad7944_3wire_cs_mode_conversion(adc, &indio_dev-
> >channels[0]);
> +		if (ret)
> +			goto out;
> +
> +		break;
> +	case AD7944_SPI_MODE_CHAIN:
> +		/* not supported */
> =C2=A0		goto out;
> +	}
> =C2=A0
> =C2=A0	iio_push_to_buffers_with_timestamp(indio_dev, &adc->sample.raw,
> =C2=A0					=C2=A0=C2=A0 pf->timestamp);
> @@ -260,16 +366,9 @@ static int ad7944_probe(struct spi_device *spi)
> =C2=A0	struct ad7944_adc *adc;
> =C2=A0	bool have_refin =3D false;
> =C2=A0	struct regulator *ref;
> +	const char *str_val;
> =C2=A0	int ret;
> =C2=A0
> -	/*
> -	 * driver currently only supports the conventional "4-wire" mode and
> -	 * not other special wiring configurations.
> -	 */
> -	if (device_property_present(dev, "adi,spi-mode"))
> -		return dev_err_probe(dev, -EINVAL,
> -				=C2=A0=C2=A0=C2=A0=C2=A0 "adi,spi-mode is not currently supported\n"=
);
> -
> =C2=A0	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*adc));
> =C2=A0	if (!indio_dev)
> =C2=A0		return -ENOMEM;
> @@ -283,6 +382,22 @@ static int ad7944_probe(struct spi_device *spi)
> =C2=A0
> =C2=A0	adc->timing_spec =3D chip_info->timing_spec;
> =C2=A0
> +	if (device_property_read_string(dev, "adi,spi-mode", &str_val) =3D=3D 0=
) {
> +		ret =3D sysfs_match_string(ad7944_spi_modes, str_val);
> +		if (ret < 0)
> +			return dev_err_probe(dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "unsupported adi,spi-mode\n");
> +
> +		adc->spi_mode =3D ret;
> +	} else {
> +		/* absence of adi,spi-mode property means default mode */
> +		adc->spi_mode =3D AD7944_SPI_MODE_DEFAULT;
> +	}
> +
> +	if (adc->spi_mode =3D=3D AD7944_SPI_MODE_CHAIN)
> +		return dev_err_probe(dev, -EINVAL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "chain mode is not implemented\n");
> +
> =C2=A0	/*
> =C2=A0	 * Some chips use unusual word sizes, so check now instead of wait=
ing
> =C2=A0	 * for the first xfer.
> @@ -349,15 +464,17 @@ static int ad7944_probe(struct spi_device *spi)
> =C2=A0		adc->ref_mv =3D AD7944_INTERNAL_REF_MV;
> =C2=A0	}
> =C2=A0
> -	/*
> -	 * CNV gpio is required in 4-wire mode which is the only currently
> -	 * supported mode.
> -	 */
> -	adc->cnv =3D devm_gpiod_get(dev, "cnv", GPIOD_OUT_LOW);
> +	adc->cnv =3D devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
> =C2=A0	if (IS_ERR(adc->cnv))
> =C2=A0		return dev_err_probe(dev, PTR_ERR(adc->cnv),
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get CNV GPIO\n");
> =C2=A0
> +	if (!adc->cnv && adc->spi_mode =3D=3D AD7944_SPI_MODE_DEFAULT)
> +		return dev_err_probe(&spi->dev, -EINVAL, "CNV GPIO is
> required\n");
> +	else if (adc->cnv && adc->spi_mode !=3D AD7944_SPI_MODE_DEFAULT)
> +		return dev_err_probe(&spi->dev, -EINVAL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "CNV GPIO in single and chain mode is not
> currently supported\n");
> +

Redundant else...

> =C2=A0	adc->turbo =3D devm_gpiod_get_optional(dev, "turbo", GPIOD_OUT_LOW=
);
> =C2=A0	if (IS_ERR(adc->turbo))
> =C2=A0		return dev_err_probe(dev, PTR_ERR(adc->turbo),
> @@ -369,6 +486,10 @@ static int ad7944_probe(struct spi_device *spi)
> =C2=A0		return dev_err_probe(dev, -EINVAL,
> =C2=A0			"cannot have both turbo-gpios and adi,always-turbo\n");
> =C2=A0
> +	if (adc->spi_mode =3D=3D AD7944_SPI_MODE_CHAIN && adc->always_turbo)
> +		return dev_err_probe(dev, -EINVAL,
> +			"cannot have both chain mode and always turbo\n");
> +


I'm fine in having this now but shouldn't we only have the above when we do=
 support
chain mode? A bit odd having it when we don't even allow chain mode.

- Nuno S=C3=A1


