Return-Path: <linux-kernel+bounces-111051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ED5886760
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B405DB23E06
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0515125AB;
	Fri, 22 Mar 2024 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxfFVxUt"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5291119E;
	Fri, 22 Mar 2024 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711091785; cv=none; b=l2g8r2EzUdxZEZW3a5d1td8YQTbcQJUdQucIa3TDIAOiMgNJfChMkFhqzfUGL2QLJhyOjwq7WlruF5cUAu/V7q9CfDIny3P8epGQm82iUr1Gf2Sec55jHgMGNaQgLp+yC3esuF2DpgEEtYNo6vmpw7ZiVGJh+La2rNyczBqNnZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711091785; c=relaxed/simple;
	bh=cr/gq9Hz7MjDp3VpYL4qLkDVuVmAvk584ocPGpL8vrM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ETDewkIADQ8Jezhv572Ont0ABE/ZoK26ftA/cDqf9U0zfQSYHS79wFEB2j7LW7w0N1+7b7s30vGMpJIuCergEgt1GVAWiwt5pzDiyDknRD83q7NGZ6/5eNS9o8uUE+nlqRyHvkRHomZQpKesY39QHhSmb62ae2yz00KZtZ5CDBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxfFVxUt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso978113f8f.0;
        Fri, 22 Mar 2024 00:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711091782; x=1711696582; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Iznl4WZmLsguPyAc9eH8R5PJlabuCZnbo+2mKeF1vzE=;
        b=QxfFVxUtM0tS3AsT0sq7r0kHVAGNOyuh8iM+GtPYGugRgXYUGWf7n6N6McjsKA407f
         CNBq2UnlTig/VG6sbQXi01lceXBB8TdDZbzhvwVfFZLM6frzlRwItXwr2LxYjETzzHio
         NnmDm1xnCQzO0UaiyYTk3NYe0oj864Zrtvpp0KJy12g/MpBw41/sSTaFJPX8UjWHMq/D
         dgonkPGnGsk2yJ/h6u2+N2MucxTV1fA0GgxGPcitBmlWI81cVbwgrq1T7QkvSkGL129z
         b91MMoDcPfmAzQV+vRJPjTVZI0j95l5Y3grFOepiJZLuZOyvLu/whjNOnpprw19EYm+8
         b6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711091782; x=1711696582;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iznl4WZmLsguPyAc9eH8R5PJlabuCZnbo+2mKeF1vzE=;
        b=JN62tJwqpma98QRdz0NiRcDD6auVADwTzOLUsEmZK64p1CZpRYwL2r+PLEKjCOvwxl
         uWRYU9fuaJ3w49Q1ZoYKCVOTRpU6ddkkHPKxvri6V/zdMCQ/UfdTr6UsxXyJGkRgOTp/
         wUxy89RWfpr9P77mW+A8p7lgynt3uMRXJWlzQFsX71Tk0xfaztfyd2Lfpe955STHosg5
         hbjsTDqv2nhY+nQ75xoHt3CwFehEhXIaLbQLzJokcdwAgPmSFzRn8dlM8w5UJx7Auk3w
         UBOqMssWdsn1sKNEHXDYmqEKgGha9vUMs9+VTCxUELrQp5weRZK5NGlWhGAo4VPd0tMO
         Uu2A==
X-Forwarded-Encrypted: i=1; AJvYcCWvuPbea5K9vpOXjUJXJpldDDvIdXIHJYEIafgpZoHjF8T2P2zAtXW8eJ/QLVmb4OwiwcWRXeiFG/tVau/vKjNca07HnCOjHTuECl+CbeuCDteaqXT1IRza+rjm9vu34RHSYQz/aGFUbw==
X-Gm-Message-State: AOJu0YzRNeB5LFnUPDQle+YDHJW2cpOMKINV9rBZFBqZ7lJnxEBZ3R6A
	tZ3sBxwE64Nb4g0yRJQANZIjPymPRxVl61voYhiRISgxDQA5iMUs
X-Google-Smtp-Source: AGHT+IGHqU2a59T96Pj/BjdvIqr7mH07mQh1y4XtvPXYoKRd9U2ZISkXZOfmtQko/0CTn0jnc+ytvQ==
X-Received: by 2002:a5d:60c7:0:b0:33e:63c2:c43a with SMTP id x7-20020a5d60c7000000b0033e63c2c43amr834708wrt.26.1711091781766;
        Fri, 22 Mar 2024 00:16:21 -0700 (PDT)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id dl17-20020a0560000b9100b0033d6bc17d0esm1372338wrb.74.2024.03.22.00.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 00:16:21 -0700 (PDT)
Message-ID: <374831e2acbac85a0087e3dd0824ec3395ffe2fa.camel@gmail.com>
Subject: Re: [PATCH v2 1/3] iio: accel: adxl345: Update adxl345
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Date: Fri, 22 Mar 2024 08:16:20 +0100
In-Reply-To: <20240322003713.6918-2-l.rubusch@gmail.com>
References: <20240322003713.6918-1-l.rubusch@gmail.com>
	 <20240322003713.6918-2-l.rubusch@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-22 at 00:37 +0000, Lothar Rubusch wrote:
> Move driver wide constants and fields into the header.
> Let probe call a separate setup function. Provide
> possibility for an SPI/I2C specific setup to be passed
> as function pointer to core.
>=20
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
> =C2=A0drivers/iio/accel/adxl345.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4=
4 +++++++++++-
> =C2=A0drivers/iio/accel/adxl345_core.c | 117 +++++++++++++++++-----------=
---
> =C2=A0drivers/iio/accel/adxl345_i2c.c=C2=A0 |=C2=A0 30 ++++----
> =C2=A0drivers/iio/accel/adxl345_spi.c=C2=A0 |=C2=A0 28 ++++----
> =C2=A04 files changed, 134 insertions(+), 85 deletions(-)
>=20
> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> index 284bd387c..01493c999 100644
> --- a/drivers/iio/accel/adxl345.h
> +++ b/drivers/iio/accel/adxl345.h
> @@ -8,6 +8,39 @@
> =C2=A0#ifndef _ADXL345_H_
> =C2=A0#define _ADXL345_H_
> =C2=A0
> +#include <linux/iio/iio.h>
> +
> +/* ADXL345 register definitions */
> +#define ADXL345_REG_DEVID		0x00
> +#define ADXL345_REG_OFSX		0x1E
> +#define ADXL345_REG_OFSY		0x1F
> +#define ADXL345_REG_OFSZ		0x20
> +#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
> +#define ADXL345_REG_BW_RATE		0x2C
> +#define ADXL345_REG_POWER_CTL		0x2D
> +#define ADXL345_REG_DATA_FORMAT		0x31
> +#define ADXL345_REG_DATAX0		0x32
> +#define ADXL345_REG_DATAY0		0x34
> +#define ADXL345_REG_DATAZ0		0x36
> +#define ADXL345_REG_DATA_AXIS(index)	\
> +	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
> +
> +#define ADXL345_BW_RATE			GENMASK(3, 0)
> +#define ADXL345_BASE_RATE_NANO_HZ	97656250LL
> +
> +#define ADXL345_POWER_CTL_MEASURE	BIT(3)
> +#define ADXL345_POWER_CTL_STANDBY	0x00
> +
> +#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolution =
*/
> +#define ADXL345_DATA_FORMAT_SPI=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 BIT(6) /* spi-3wire */
> +#define ADXL345_DATA_FORMAT_2G		0
> +#define ADXL345_DATA_FORMAT_4G		1
> +#define ADXL345_DATA_FORMAT_8G		2
> +#define ADXL345_DATA_FORMAT_16G		3
> +#define ADXL345_DATA_FORMAT_MSK		~((u8) BIT(6)) /* ignore spi-3wire
> */
> +
> +#define ADXL345_DEVID			0xE5
> +
> =C2=A0/*
> =C2=A0 * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
> =C2=A0 * in all g ranges.
> @@ -23,11 +56,20 @@
> =C2=A0 */
> =C2=A0#define ADXL375_USCALE	480000
> =C2=A0
> +enum adxl345_device_type {
> +	ADXL345,
> +	ADXL375,
> +};
> +
> =C2=A0struct adxl345_chip_info {
> =C2=A0	const char *name;
> =C2=A0	int uscale;
> =C2=A0};
> =C2=A0
> -int adxl345_core_probe(struct device *dev, struct regmap *regmap);
> +extern const struct adxl345_chip_info adxl3x5_chip_info[];
> +
> +int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct adxl345_chip_info *c=
hip_info,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*setup)(struct device*, stru=
ct regmap*));
> =C2=A0
> =C2=A0#endif /* _ADXL345_H_ */
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345=
_core.c
> index 8bd30a23e..040c3f05a 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -17,38 +17,9 @@
> =C2=A0
> =C2=A0#include "adxl345.h"
> =C2=A0
> -#define ADXL345_REG_DEVID		0x00
> -#define ADXL345_REG_OFSX		0x1e
> -#define ADXL345_REG_OFSY		0x1f
> -#define ADXL345_REG_OFSZ		0x20
> -#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
> -#define ADXL345_REG_BW_RATE		0x2C
> -#define ADXL345_REG_POWER_CTL		0x2D
> -#define ADXL345_REG_DATA_FORMAT		0x31
> -#define ADXL345_REG_DATAX0		0x32
> -#define ADXL345_REG_DATAY0		0x34
> -#define ADXL345_REG_DATAZ0		0x36
> -#define ADXL345_REG_DATA_AXIS(index)	\
> -	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
> -
> -#define ADXL345_BW_RATE			GENMASK(3, 0)
> -#define ADXL345_BASE_RATE_NANO_HZ	97656250LL
> -
> -#define ADXL345_POWER_CTL_MEASURE	BIT(3)
> -#define ADXL345_POWER_CTL_STANDBY	0x00
> -
> -#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolution =
*/
> -#define ADXL345_DATA_FORMAT_2G		0
> -#define ADXL345_DATA_FORMAT_4G		1
> -#define ADXL345_DATA_FORMAT_8G		2
> -#define ADXL345_DATA_FORMAT_16G		3
> -
> -#define ADXL345_DEVID			0xE5
> -
> =C2=A0struct adxl345_data {
> =C2=A0	const struct adxl345_chip_info *info;
> =C2=A0	struct regmap *regmap;
> -	u8 data_range;
> =C2=A0};
> =C2=A0
> =C2=A0#define ADXL345_CHANNEL(index, axis) {					\
> @@ -62,6 +33,18 @@ struct adxl345_data {
> =C2=A0		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
> =C2=A0}
> =C2=A0
> +const struct adxl345_chip_info adxl3x5_chip_info[] =3D {
> +	[ADXL345] =3D {
> +		.name =3D "adxl345",
> +		.uscale =3D ADXL345_USCALE,
> +	},
> +	[ADXL375] =3D {
> +		.name =3D "adxl375",
> +		.uscale =3D ADXL375_USCALE,
> +	},
> +};
> +EXPORT_SYMBOL_NS_GPL(adxl3x5_chip_info, IIO_ADXL345);
> +
> =C2=A0static const struct iio_chan_spec adxl345_channels[] =3D {
> =C2=A0	ADXL345_CHANNEL(0, X),
> =C2=A0	ADXL345_CHANNEL(1, Y),
> @@ -197,14 +180,21 @@ static void adxl345_powerdown(void *regmap)
> =C2=A0	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STAN=
DBY);
> =C2=A0}
> =C2=A0
> -int adxl345_core_probe(struct device *dev, struct regmap *regmap)
> +static int adxl345_setup(struct device *dev, struct adxl345_data *data,
> +			 int (*setup)(struct device*, struct regmap*))
> =C2=A0{
> -	struct adxl345_data *data;
> -	struct iio_dev *indio_dev;
> =C2=A0	u32 regval;
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D regmap_read(regmap, ADXL345_REG_DEVID, &regval);
> +	/* Perform bus specific settings if available */
> +	if (setup) {
> +		ret =3D setup(dev, data->regmap);
> +		if (ret)
> +			return ret;
> +	}

nit: likely a better name would be bus_setup(). Then you could drop the com=
ment as it
becomes useless...

> +
> +	/* Read out DEVID */
> +	ret =3D regmap_read(data->regmap, ADXL345_REG_DEVID, &regval);
> =C2=A0	if (ret < 0)
> =C2=A0		return dev_err_probe(dev, ret, "Error reading device ID\n");
> =C2=A0
> @@ -212,37 +202,62 @@ int adxl345_core_probe(struct device *dev, struct r=
egmap
> *regmap)
> =C2=A0		return dev_err_probe(dev, -ENODEV, "Invalid device ID: %x,
> expected %x\n",
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 regval, ADXL345_DEVID);
> =C2=A0
> +	/* Update data_format to full-resolution mode */
> +	ret =3D regmap_update_bits(data->regmap, ADXL345_REG_DATA_FORMAT,
> +				 ADXL345_DATA_FORMAT_MSK,
> ADXL345_DATA_FORMAT_FULL_RES);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to update data_format
> register\n");
> +
> +	/* Enable measurement mode */
> +	ret =3D adxl345_powerup(data->regmap);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to enable measurement
> mode\n");
> +
> +	ret =3D devm_add_action_or_reset(dev, adxl345_powerdown, data->regmap);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/**
> + * adxl345_core_probe() - probe and setup for the adxl345 accelerometer,
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 also =
covers the adlx375 accelerometer
> + * @dev:	Driver model representation of the device
> + * @regmap:	Regmap instance for the device
> + * @chip_info:=C2=A0 Structure containing device specific data
> + * @setup:	Setup routine to be executed right before the standard device
> + *		setup, can also be set to NULL if not required
> + *
> + * Return: 0 on success, negative errno on error
> + */
> +int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct adxl345_chip_info *c=
hip_info,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*setup)(struct device*, stru=
ct regmap*))
> +{
> +	struct adxl345_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> =C2=A0	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> =C2=A0	if (!indio_dev)
> =C2=A0		return -ENOMEM;
> =C2=A0
> =C2=A0	data =3D iio_priv(indio_dev);
> =C2=A0	data->regmap =3D regmap;
> -	/* Enable full-resolution mode */
> -	data->data_range =3D ADXL345_DATA_FORMAT_FULL_RES;
> -	data->info =3D device_get_match_data(dev);
> -	if (!data->info)
> -		return -ENODEV;
> -
> -	ret =3D regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
> -			=C2=A0=C2=A0 data->data_range);
> -	if (ret < 0)
> -		return dev_err_probe(dev, ret, "Failed to set data range\n");
> +	data->info =3D chip_info;
> =C2=A0
> -	indio_dev->name =3D data->info->name;
> +	indio_dev->name =3D chip_info->name;
> =C2=A0	indio_dev->info =3D &adxl345_info;
> =C2=A0	indio_dev->modes =3D INDIO_DIRECT_MODE;
> =C2=A0	indio_dev->channels =3D adxl345_channels;
> =C2=A0	indio_dev->num_channels =3D ARRAY_SIZE(adxl345_channels);
> =C2=A0
> -	/* Enable measurement mode */
> -	ret =3D adxl345_powerup(data->regmap);
> -	if (ret < 0)
> -		return dev_err_probe(dev, ret, "Failed to enable measurement
> mode\n");
> -
> -	ret =3D devm_add_action_or_reset(dev, adxl345_powerdown, data->regmap);
> -	if (ret < 0)
> +	ret =3D adxl345_setup(dev, data, setup);
> +	if (ret) {
> +		dev_err(dev, "ADXL345 setup failed\n");
> =C2=A0		return ret;
> +	}
> =C2=A0
> =C2=A0	return devm_iio_device_register(dev, indio_dev);
> =C2=A0}
> diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_=
i2c.c
> index a3084b0a8..3f882e2e0 100644
> --- a/drivers/iio/accel/adxl345_i2c.c
> +++ b/drivers/iio/accel/adxl345_i2c.c
> @@ -9,6 +9,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/regmap.h>
> =C2=A0
> @@ -21,41 +22,36 @@ static const struct regmap_config adxl345_i2c_regmap_=
config =3D {
> =C2=A0
> =C2=A0static int adxl345_i2c_probe(struct i2c_client *client)
> =C2=A0{
> +	const struct adxl345_chip_info *chip_data;
> =C2=A0	struct regmap *regmap;
> =C2=A0
> +	/* Retrieve device data, i.e. the name, to pass it to the core */
> +	chip_data =3D i2c_get_match_data(client);
> +

While unlikely use a proper pattern. Meaning, check for NULL pointers and b=
ail out in
that case... Also, you need to justify why are you moving these calls to th=
e bus in
your commit message.


It seems to me that you're trying to refactor too much in a single patch. M=
aybe step
back and try to separate changes in different patches. Like this one (passi=
ng
chip_info) from the bus file could be in it's own patch. Will also (or shou=
ld at
least :)) "force" you to have a more dedicated commit message explaining wh=
y you're
introducing the change.

- Nuno S=C3=A1


