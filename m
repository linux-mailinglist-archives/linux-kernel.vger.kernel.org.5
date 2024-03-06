Return-Path: <linux-kernel+bounces-94377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E60D873E21
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6C21F21A6C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0D513BAD4;
	Wed,  6 Mar 2024 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wh+cu65R"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3747131738;
	Wed,  6 Mar 2024 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709748515; cv=none; b=mMKPM7QxcfsLKNj8KhnGbjQxry0wWm4HS7/IZeor/oTpNuqCKEaV2MHCoPaKYQNMrvrMyvPePV00BKN55Kg+K02F7Ozj9l9KY5ugRWqxGBKmcFC+7IbABKrep3HwavUq+I0mDBuMDU/AUHi1n/K0YpXTVM0QdWb7DjU/ouZ0Sb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709748515; c=relaxed/simple;
	bh=ljLw+k9CYqmKgRHvKD2eBfLWjSEL531EeyQVW6lmIH0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daR9AkEfuAkj7tZvzfeR8xn2hCM2mGZL1uHSk3sdpYbTcxqiKTcZmId6kdQR5nQk0Xe7u2xRrilIxBThKKaazjwITE4JZr9+Z8qwfNMRFuyJsGOPdH//jpuxKKYRa/ogoRzYf6PmEH0ZNIraSeJvixRSLgik03EFur+OuU9dS9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wh+cu65R; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e285a33bdso3160471f8f.2;
        Wed, 06 Mar 2024 10:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709748512; x=1710353312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v7AKrK6ka8xNFv1OUzoGeNIl36Pi5bzUCr1D648kUhA=;
        b=Wh+cu65RgmqCxHCeiZhtIf6slGwbW/ZIHd6FyVNUn6h8vIa793l2YPZI55hyeISEf1
         Sia2GCGVQHBHfkiTTst/p0J3sKqHwQM97+yLncPvWP2BmZyhTaXDxwP192EQ8S/XdvYx
         Ffnm9Rv1bOKq3cI89lS3EfjyOALX6dpB/Dz4Tbu5uWZ+wHTpEg+QQRL1cMqC9y7sEHi0
         qzzbPcgKw1JasgkHdW90uN8E9aY1uFcftdxGaA/cPg5+RYju792SHg9Yzijmv2xjN5Kn
         scldgn1iHbAKYirCNUeAaaIXW5YmIqm3qFEFcz57hAw0aQdtWfTtusCbmix8wP6pN4lR
         LYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709748512; x=1710353312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7AKrK6ka8xNFv1OUzoGeNIl36Pi5bzUCr1D648kUhA=;
        b=le1CfFgZJusfG5s8pz245vxZC63VPCh1wT3hOFEQ2HOXAP2MWoCevRHde8Qq2+a6sU
         D99CK5t/Ta1zkDPFKX9hMaPH04Kx09Q4pTD6fHg5vz9GaGCEHC+XcurK9knKKx20uHMG
         //WFv4jbHcrnfu6ZVvVIBFSciWDD4Bi3olpLetIGtlk3LLleJ/q4z6cVO5BSkKJ/3b2i
         VN6EOcKJYzQcQs7pxXcDHF9DjZLcP3qLgvc6Aip3agrEYVXJRpSkjMhGCqZkWcFRFV44
         jOOjTnP79McZS3iyYpM1SGl1ensqvE+a3S8smAANGTZ/1aRnznEfua8r5/W1n6PHPeum
         SzOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaS5OQdzelg688txDqOipo7WHxqp3VxNblJWdk3t7GMR9xNBCyrq0+XdOjiKUEy5qbzyuhqFcFGwsktGKIK8Wqccxtgj7KJhKwIY3NI7IleE4M5HO70bgHP36rGZlI6EfWGa6d2Z2v
X-Gm-Message-State: AOJu0Yww/xc4Mr7bdlm08zmBYtaQumBOJTv7RAaNh9HkOcDjo0+CJ/XU
	2xA14MxZdM+nWgUZ9C8OgnWAbXGKLoynU/z+MmnYWK93JV0Utw40
X-Google-Smtp-Source: AGHT+IEp4iEaCBIHgCpGRsvcD6/HEhcJbucyfZtMOG0D8/MpW/Znuk3qxiThZmrNUvfNllKTh6subQ==
X-Received: by 2002:a05:6000:144:b0:33e:4390:c04e with SMTP id r4-20020a056000014400b0033e4390c04emr5409036wrx.71.1709748511939;
        Wed, 06 Mar 2024 10:08:31 -0800 (PST)
Received: from vamoiridPC ([2a04:ee41:82:7577:8b04:4127:e500:e3de])
        by smtp.gmail.com with ESMTPSA id az7-20020adfe187000000b0033e433cb471sm2317846wrb.79.2024.03.06.10.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 10:08:31 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 6 Mar 2024 19:08:29 +0100
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	ang.iglesiasg@gmail.com, andriy.shevchenko@linux.intel.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: pressure: Fixes BMP38x and BMP390 SPI
 support
Message-ID: <20240306180829.GA759506@vamoiridPC>
References: <20240219191359.18367-1-vassilisamir@gmail.com>
 <20240224163051.3edcf102@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224163051.3edcf102@jic23-huawei>

On Sat, Feb 24, 2024 at 04:30:51PM +0000, Jonathan Cameron wrote:
> On Mon, 19 Feb 2024 20:13:59 +0100
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > According to the datasheet of BMP38x and BMP390 devices, for an SPI
> > read operation the first byte that is returned needs to be dropped,
> > and the rest of the bytes are the actual data returned from the
> > sensor.
> > 
> > Fixes: 8d329309184d ("iio: pressure: bmp280: Add support for BMP380 sensor family")
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Applied and marked for stable - with tweaks to header order and the space above
> as per discussion.

Hi Jonathan,

I just got my hands on a BME280 humidity sensor and I realized that this commit,
even though it fixes the SPI support for the BMP38x and BMP390 devices, it breaks
the SPI support for BME280 and BMP58x. The problem is descirbed below, inline.

> > ---
> >  drivers/iio/pressure/bmp280-spi.c | 49 ++++++++++++++++++++++++++++++-
> >  1 file changed, 48 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
> > index e8a5fed07e88..1972014dca93 100644
> > --- a/drivers/iio/pressure/bmp280-spi.c
> > +++ b/drivers/iio/pressure/bmp280-spi.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/spi/spi.h>
> >  #include <linux/err.h>
> >  #include <linux/regmap.h>
> > +#include <linux/bits.h>
> >  
> >  #include "bmp280.h"
> >  
> > @@ -35,6 +36,33 @@ static int bmp280_regmap_spi_read(void *context, const void *reg,
> >  	return spi_write_then_read(spi, reg, reg_size, val, val_size);
> >  }
> >  
> > +static int bmp380_regmap_spi_read(void *context, const void *reg,
> > +				  size_t reg_size, void *val, size_t val_size)
> > +{
> > +	struct spi_device *spi = to_spi_device(context);
> > +	u8 rx_buf[4];
> > +	ssize_t status;
> > +
> > +	/*
> > +	 * Maximum number of consecutive bytes read for a temperature or
> > +	 * pressure measurement is 3.
> > +	 */
> > +	if (val_size > 3)
> > +		return -EINVAL;
> > +	/*
> > +	 * According to the BMP3xx datasheets, for a basic SPI read opertion,
> > +	 * the first byte needs to be dropped and the rest are the requested
> > +	 * data.
> > +	 */
> > +	status = spi_write_then_read(spi, reg, 1, rx_buf, val_size + 1);
> > +	if (status)
> > +		return status;
> > +
> > +	memcpy(val, rx_buf + 1, val_size);
> > +
> > +	return 0;
> > +}
> > +
> >  static struct regmap_bus bmp280_regmap_bus = {
> >  	.write = bmp280_regmap_spi_write,
> >  	.read = bmp280_regmap_spi_read,
> > @@ -42,10 +70,19 @@ static struct regmap_bus bmp280_regmap_bus = {
> >  	.val_format_endian_default = REGMAP_ENDIAN_BIG,
> >  };
> >  
> > +static struct regmap_bus bmp380_regmap_bus = {
> > +	.write = bmp280_regmap_spi_write,
> > +	.read = bmp380_regmap_spi_read,
> > +	.read_flag_mask = BIT(7),
> > +	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
> > +	.val_format_endian_default = REGMAP_ENDIAN_BIG,
> > +};
> > +
> >  static int bmp280_spi_probe(struct spi_device *spi)
> >  {
> >  	const struct spi_device_id *id = spi_get_device_id(spi);
> >  	const struct bmp280_chip_info *chip_info;
> > +	struct regmap_bus *bmp_regmap_bus;
> >  	struct regmap *regmap;
> >  	int ret;
> >  
> > @@ -58,8 +95,18 @@ static int bmp280_spi_probe(struct spi_device *spi)
> >  
> >  	chip_info = spi_get_device_match_data(spi);
> >  
> > +	switch (chip_info->chip_id[0]) {
> > +	case BMP380_CHIP_ID:
> > +	case BMP390_CHIP_ID:

These chip IDs, even though they are IDs, they are not unique and they are
shared among sensors (see bmp280.h line 290). This means that this cases 
are true also for BME280 and BMP58x devices which of course should not 
happen because their regmap bus is the bmp280_* and not the bmp380_*.

It can easily be solved by removing the switch-case statement and adding
an if(!(strcmp(id->name,"bmp380")) which checks the name which is indeed
unique. I guess that this patch should be reverted, how should I proceed?

> > +		bmp_regmap_bus = &bmp380_regmap_bus;
> > +		break;
> > +	default:
> > +		bmp_regmap_bus = &bmp280_regmap_bus;
> > +		break;
> > +	}
> > +
> >  	regmap = devm_regmap_init(&spi->dev,
> > -				  &bmp280_regmap_bus,
> > +				  bmp_regmap_bus,
> >  				  &spi->dev,
> >  				  chip_info->regmap_config);
> >  	if (IS_ERR(regmap)) {
> 

