Return-Path: <linux-kernel+bounces-67391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320A6856ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573F81C239AF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05824136980;
	Thu, 15 Feb 2024 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDGde8LK"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86115135A47;
	Thu, 15 Feb 2024 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017606; cv=none; b=RqqB7N5dQCeQAMjm24CtkP4DhQypRsNkQfSMadyv0AnQqf1NGM++FRWnwrDsfYSFlrVTDF2qACilemBS4AouwvWIUVzzYXdT1UszLUicUNdPbMQYu/AUtWMOKL0232uL634tcUJyNdO6iDm0dE/6xTPDQNPrVX14UN68rzuWYV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017606; c=relaxed/simple;
	bh=dVETtyeLtR2My/4QlLj70COlAQIwHB4SgtL2Kzh7V9k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pgfHDZ8AX8LVCyYm5oUAGiQ1GU8v0+WJgnrUeQ/pAfW1NbjrlSFhYp2IMzDURdIQGwPGTxiCuapVdS/N2k9fTAr5RQNuUT+ZFFHEYoj07T+cZnHQI90UG7aRL2udedicMi9akAlzfcpaNHQ8H+1AsBBFNrD/sXk0RSKAEoSafy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDGde8LK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41202eae372so9086835e9.0;
        Thu, 15 Feb 2024 09:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708017603; x=1708622403; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Omd5ccM95usrHn5L6mpoqqeGE9+GSJ9q916jIPFa6vk=;
        b=KDGde8LKEZnfz9eIRueUmLmCGFWcoXluZvB/QcSx4XV5yFysHe4SD0X4W7bZVcGdbO
         qr2BDbkvmVX7ydQN8rV+WNl/57DzLgoq50lZaSYDWH5zPsFJfZTb22awXarELaM9ZbC3
         u+pLGOldITJ52VlHMQqxsN+6shwue8Pf7wpcBbZeQ7oC90W6fZkB5QetENn9TK1qIVZW
         ePAnwvtZkg/R31bL80Hgjrqpq0UJRIgF0Kbt63JMQ/QrLxNSo9jhyQevT78I+YVl5tO1
         2/pduNDy0OgZtAd0C8BgHxzqtbUD7hCzdeeVdRDuSMfcNYNq/NikoIwBK+9LElrxHI/U
         9esA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708017603; x=1708622403;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Omd5ccM95usrHn5L6mpoqqeGE9+GSJ9q916jIPFa6vk=;
        b=f91pIUPveRqnmjCPg83WpmYeDjDPLo4nFmg90atrKx5c9l2hJI25S5QXQf3fIlZm1V
         TiXf3cH0Lr3ROpwBS/a66iTi7Y9M6MEpe422MEv4RfKIWQ0aDUewg1EZvUBoGPjG3drj
         FCfsxKpz13laGc/4Z0vkavH5Ce8g70h4mzeUTHqadc+NC4VKry9lIs/pYhvD9QgTUdK9
         MdxlraZ4YA7WsHu6qmrQ2OK34jG/dHRgc9wcpXcwvr2/o4FeeEQC0SQiJZBACu94vpzx
         Fj001xZHCQmurp5a+jpB29qVE4Z8pPxZdUUtYng+yF11rgrcw30OtQ2a4u2rzIAQJ003
         N4UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIdhonCPgR8lkJkankpBnGS30CzD9/uYQrl5WmnTbIGTApjDSx0MQU3xMg7kYVg40Zv3ySsdw4kw++QLdDFKlvNuDoUOCdFolmrA0FbE0bJwAlSNRxU65NpGPoLjBrBxw2fwOl8S1v
X-Gm-Message-State: AOJu0YwYRaH9tnhHuguwyACL7wPLb8ytfyK4tmYZgEDH6PBZXhERa+Q1
	PDaS9n3FhjX33C7HbG4r54mPuVxNkczA9Ksgk5WOox4dRW4KyrbW
X-Google-Smtp-Source: AGHT+IGmfLVdR5bxJM/dsQRRY8Tki3/u77x1ze6iXFkZgjQouJHtpmGke1UfDnSwmSUZk1P8Eq4BmA==
X-Received: by 2002:a05:600c:4896:b0:411:defc:c7df with SMTP id j22-20020a05600c489600b00411defcc7dfmr1910145wmp.24.1708017602474;
        Thu, 15 Feb 2024 09:20:02 -0800 (PST)
Received: from [192.168.90.166] (146.red-83-35-56.dynamicip.rima-tde.net. [83.35.56.146])
        by smtp.gmail.com with ESMTPSA id fa25-20020a05600c519900b0041228b2e179sm1346006wmb.39.2024.02.15.09.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 09:20:02 -0800 (PST)
Message-ID: <795736e9c25b836c5939d9117a3a2580ed4e22f8.camel@gmail.com>
Subject: Re: [PATCH] drivers: iio: pressure: Add SPI support for BMP38x and
 BMP390
From: Angel Iglesias <ang.iglesiasg@gmail.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com, 579lpy@gmail.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 15 Feb 2024 18:20:00 +0100
In-Reply-To: <20240215164332.506736-1-vassilisamir@gmail.com>
References: <20240215164332.506736-1-vassilisamir@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-15 at 17:43 +0100, Vasileios Amoiridis wrote:
> According to the datasheet of BMP38x and BMP390 devices, in SPI
> operation, the first byte that returns after a read operation is
> garbage and it needs to be dropped and return the rest of the
> bytes.

Hey good catch! It flew past me when I added this devices because I tested =
only
on i2c at the time.

Kind regards,
Angel

> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
> =C2=A0drivers/iio/pressure/bmp280-spi.c | 47 ++++++++++++++++++++++++++++=
++-
> =C2=A0drivers/iio/pressure/bmp280.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> =C2=A02 files changed, 48 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp=
280-
> spi.c
> index 433d6fac83c4..c4b4a5d67f94 100644
> --- a/drivers/iio/pressure/bmp280-spi.c
> +++ b/drivers/iio/pressure/bmp280-spi.c
> @@ -35,6 +35,32 @@ static int bmp280_regmap_spi_read(void *context, const=
 void
> *reg,
> =C2=A0	return spi_write_then_read(spi, reg, reg_size, val, val_size);
> =C2=A0}
> =C2=A0
> +static int bmp380_regmap_spi_read(void *context, const void *reg,
> +				=C2=A0 size_t reg_size, void *val, size_t
> val_size)
> +{
> +	struct spi_device *spi =3D to_spi_device(context);
> +	u8 ret[BMP380_SPI_MAX_REG_COUNT_READ + 1];
> +	ssize_t status;
> +	u8 buf;
> +
> +	memcpy(&buf, reg, reg_size);
> +	buf |=3D 0x80;
> +
> +	/*
> +	 * According to the BMP380, BMP388, BMP390 datasheets, for a basic
> +	 * read operation, after the write is done, 2 bytes are received and
> +	 * the first one has to be dropped. The 2nd one is the requested
> +	 * value.
> +	 */
> +	status =3D spi_write_then_read(spi, &buf, 1, ret, val_size + 1);
> +	if (status)
> +		return status;
> +
> +	memcpy(val, ret + 1, val_size);
> +
> +	return 0;
> +}
> +
> =C2=A0static struct regmap_bus bmp280_regmap_bus =3D {
> =C2=A0	.write =3D bmp280_regmap_spi_write,
> =C2=A0	.read =3D bmp280_regmap_spi_read,
> @@ -42,10 +68,18 @@ static struct regmap_bus bmp280_regmap_bus =3D {
> =C2=A0	.val_format_endian_default =3D REGMAP_ENDIAN_BIG,
> =C2=A0};
> =C2=A0
> +static struct regmap_bus bmp380_regmap_bus =3D {
> +	.write =3D bmp280_regmap_spi_write,
> +	.read =3D bmp380_regmap_spi_read,
> +	.reg_format_endian_default =3D REGMAP_ENDIAN_BIG,
> +	.val_format_endian_default =3D REGMAP_ENDIAN_BIG,
> +};
> +
> =C2=A0static int bmp280_spi_probe(struct spi_device *spi)
> =C2=A0{
> =C2=A0	const struct spi_device_id *id =3D spi_get_device_id(spi);
> =C2=A0	const struct bmp280_chip_info *chip_info;
> +	struct regmap_bus *bmp_regmap_bus;
> =C2=A0	struct regmap *regmap;
> =C2=A0	int ret;
> =C2=A0
> @@ -58,8 +92,19 @@ static int bmp280_spi_probe(struct spi_device *spi)
> =C2=A0
> =C2=A0	chip_info =3D spi_get_device_match_data(spi);
> =C2=A0
> +	switch (chip_info->chip_id[0]) {
> +	case BMP380_CHIP_ID:
> +	case BMP390_CHIP_ID:
> +		bmp_regmap_bus =3D &bmp380_regmap_bus;
> +		break;
> +	default:
> +		bmp_regmap_bus =3D &bmp280_regmap_bus;
> +		break;
> +	}
> +
> +
> =C2=A0	regmap =3D devm_regmap_init(&spi->dev,
> -				=C2=A0 &bmp280_regmap_bus,
> +				=C2=A0 bmp_regmap_bus,
> =C2=A0				=C2=A0 &spi->dev,
> =C2=A0				=C2=A0 chip_info->regmap_config);
> =C2=A0	if (IS_ERR(regmap)) {
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.=
h
> index 4012387d7956..ca482b7e4295 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -191,6 +191,8 @@
> =C2=A0#define BMP380_TEMP_SKIPPED		0x800000
> =C2=A0#define BMP380_PRESS_SKIPPED		0x800000
> =C2=A0
> +#define BMP380_SPI_MAX_REG_COUNT_READ=C2=A0=C2=A0 3
> +
> =C2=A0/* BMP280 specific registers */
> =C2=A0#define BMP280_REG_HUMIDITY_LSB		0xFE
> =C2=A0#define BMP280_REG_HUMIDITY_MSB		0xFD


