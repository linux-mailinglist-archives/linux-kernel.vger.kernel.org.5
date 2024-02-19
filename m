Return-Path: <linux-kernel+bounces-71917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EABB785AC7F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D541F24CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3163B537F5;
	Mon, 19 Feb 2024 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgdpP9DF"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9679153E0A;
	Mon, 19 Feb 2024 19:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372311; cv=none; b=YsEreHrgiKgl1XmDVNIY146capnnwH+ihwIgGLND7Bi+KhckYaUJJheIBQVMN0wn526TGQgULBDDlxw9IR9Vu7FQP1/QmsiK/D8l4VNtbXP5Y4KQy6wztnwB35xn1t4Veil3Vi8Xop8eXgqdhZoOqm8AiUcvfKxbiCLvnmGIJBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372311; c=relaxed/simple;
	bh=WLnOLrNYyxbBZ7KhNT25xTbE5ysycd66MDZXEAQCJJs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhUxuinptJUYW6x1Luk/vyMrIcgVby61MujwG7o8Lye6Dos6TJn5ky+qma8vOwRj0D1wJ70xMNrvN0oON1E1Pb4HTYRNhT8SANUngN1Uv75A76YFCsygcJI0wNfuHM4LDiJyKfJlBfrFy+0HLGmNfn5I1h1dNZ10b6Xn3+G78HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgdpP9DF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so614368566b.0;
        Mon, 19 Feb 2024 11:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708372308; x=1708977108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uS/tFU4Jz4wVbpM0IanHtPvqpcnyfY9jCayEpbR1UVo=;
        b=UgdpP9DFar7orxvpKEmJA9gIoBPcvmAA9LCfFxJjU1edAu0TfjWRSdEyhcyT8TSlGN
         VMIT8FPJhb+4teBKWFCZTJGG0b50bKsWsQTgfJkkT8m+8gsr3FUWAeaIQHk10/fxkeWl
         TYM978cH+aS2y3y1xQpJ4TTqpEGikl7LdTiaVBTDAvsjTd48fyRwULOpINQvn6snxGki
         aNpP6FsZ2sHtNLa7/b5S1J7ci0TXSaZ8fJP4gHA6HU4Wdnbnu3SlJXhhAEEG3zqyudDk
         IYVC8AUkqtSIq50MgItefFcq/tYnjcKp7xR9GZebXyZ1Ps7Bee3Ayzr5FFtb7jLnMcP/
         gEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708372308; x=1708977108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uS/tFU4Jz4wVbpM0IanHtPvqpcnyfY9jCayEpbR1UVo=;
        b=pP+2xy3k0ESgCkLlP9Oyj77f8Sf4Zyu5TVDI8O+y7t8aQYd0KOHKRgzPMTZm+G5CI4
         nIvhIJ1P89cUdR7fT4a8KE9/DSfAN/A5FPyQsKMBHkj2aIYWCrkIkYY5j3bH6rK70+nI
         EE7P/RhJqCvA0dURVDUqsd6rm+ZjGfwfFbxOR/X/IQnPWSEdv+0OW5/GwONBu89TwlTU
         ybUBN6SpZlFnCK7DyVuPDiE2B9Va83fJqRotHRzht6TRMS+zMzSkklnOz9VDCMtWPuce
         txt7ENV+8jV7rjlL2w4vNDiDRPyjT6cBwqNq0DA+u/hdLnljBm0jyjeo+uGdWMNCLcfy
         yEMA==
X-Forwarded-Encrypted: i=1; AJvYcCUFNVvMEhc0N4/WbX8obeZmFfQ7PvEz8AJhozYiPp4QY1ohWm0RJlJEfLh9JG2dSGsPRApRcVJq+D/hhXwVFz9Y+CV7QwwzU7VbJAx/X3m8XHk2022sK8O/IAobkiBEF1FG43XLmM0y
X-Gm-Message-State: AOJu0YxzZtE/S0LH62fINxURS6NOg7Y9182vJBSm1Nule5zyw9X1L+y1
	JjufFfAJ7RzWH723Z64QHFj0bUOp+e3DHrtWVXzW5PwMEPRK1Z/H
X-Google-Smtp-Source: AGHT+IE+Q3GVRQBpgpqTCqz/Fml0+MC9LVGyqJfQqKK5pPUpCUOlnxCzF/6dLs5V6oP28riPSLKSKg==
X-Received: by 2002:a17:906:6617:b0:a3d:5058:50ff with SMTP id b23-20020a170906661700b00a3d505850ffmr11477579ejp.2.1708372307609;
        Mon, 19 Feb 2024 11:51:47 -0800 (PST)
Received: from vamoiridPC ([2a04:ee41:82:7577:3f11:8c45:6350:e419])
        by smtp.gmail.com with ESMTPSA id vb7-20020a170907d04700b00a3dabd0d000sm3214862ejc.209.2024.02.19.11.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 11:51:47 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 19 Feb 2024 20:51:45 +0100
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	ang.iglesiasg@gmail.com, andriy.shevchenko@linux.intel.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: pressure: Fixes BMP38x and BMP390 SPI
 support
Message-ID: <20240219195145.GA18787@vamoiridPC>
References: <20240219191359.18367-1-vassilisamir@gmail.com>
 <20240219194213.6b0f02bc@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219194213.6b0f02bc@jic23-huawei>

On Mon, Feb 19, 2024 at 07:42:36PM +0000, Jonathan Cameron wrote:
> On Mon, 19 Feb 2024 20:13:59 +0100
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > According to the datasheet of BMP38x and BMP390 devices, for an SPI
> > read operation the first byte that is returned needs to be dropped,
> > and the rest of the bytes are the actual data returned from the
> > sensor.
> > 
> > Fixes: 8d329309184d ("iio: pressure: bmp280: Add support for BMP380 sensor family")
> No line break. The fixes tag is part of the main tag block.
> I can fix that whilst applying.
> Otherwise this looks fine to me.
> 
> I'll leave it on list a little longer though as both Linus and Angel
> are still about and might have time to also take a look at this.
>

Thank you very much again for the quick answer. Since you can fix it while applying,
I should not annoy the mailing list with more e-mails. Just for future reference,
when you mean no line break you mean between the main block and the "Fixes" line
or between the "Fixes" line and the "Signed-off-by: ...." ? 
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
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

Best regards,
Vasileios Amoiridis

