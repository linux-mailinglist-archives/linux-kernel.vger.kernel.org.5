Return-Path: <linux-kernel+bounces-18925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5788582652E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435D01C209EE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CB213AE6;
	Sun,  7 Jan 2024 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAVct8Xs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892DA13AD5;
	Sun,  7 Jan 2024 16:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74DEC433C7;
	Sun,  7 Jan 2024 16:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704646622;
	bh=Z0uNUVuSLs33xkvslTQdw0NlujUpAvgVIaSRUWAsZMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fAVct8XsW0EtsBGBAN2jamiTJRHnwotP6jjnSdGZhmp2u+Izil84JOQ+5hprQiXcL
	 Smi1eusR68TpeQ/2dwSWnJkQ88yndk05E/INHPrvBjqyfUbnf3ycj0O5RheucrNT54
	 7sYhONgqQMMBrNKk9vBO/dWCIaZ4L5lGJN5Tz8YME5YRal+ut1sXiW9N7kgdZRRbjS
	 +jI1X8lnF4gfkdboUKBGpHhPvI1haDql+LUphEBK8899aB5Uzb8MLERQ2HLw6N8q4m
	 W8XjFMBokwGXNzbA6MXp+pQKBpqM4IkkhVE94yTGeYrI5YxmKuZTGLbvLLGAmm42ln
	 pBkqjRz9yYTJQ==
Date: Sun, 7 Jan 2024 16:56:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: Jonathan.Cameron@huawei.com, lars@metafoo.de,
 Qing-wu.Li@leica-geosystems.com.cn, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, Mike
 Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v2] iio: accel: bmi088: add i2c support for bmi088 accel
 driver
Message-ID: <20240107165654.0b343ebd@jic23-huawei>
In-Reply-To: <20231219150440.264033-1-jerrysteve1101@gmail.com>
References: <20231219150440.264033-1-jerrysteve1101@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 23:04:40 +0800
Jun Yan <jerrysteve1101@gmail.com> wrote:

> The BMI088, BMI085 and BMI090L accelerometer also support
> I2C protocol, so let's add the missing I2C support.
> 
> The I2C interface of the {BMI085,BMI088,BMI090L} is compatible with
> the I2C Specification UM10204 Rev. 03 (19 June 2007), available at
> http://www.nxp.com. The {BMI085,BMI088,BMI090L} supports I2C standard
> mode and fast mode, only 7-bit address mode is supported.[1][2][3]
> 
> [1]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi085-ds001.pdf
> [2]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi088-ds001.pdf
> [3]: https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/4807/BST-BMI090L-DS000-00.pdf
Prefer to have these in the tags block (so no blank line before the sign off) as
> 
Datasheet: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi085-ds001.pdf
Datasheet: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi088-ds001.pdf
Datasheet: https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/4807/BST-BMI090L-DS000-00.pdf
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312191325.jfiyeL5F-lkp@intel.com/
These two tags don't belong here.  They are only appropriate for a stand alone fix patch for
code that has already gone upstream.

It's good to reflect the useful responses of 0-day but do it in the changes block, not up here.

Please take a look at the git log for a driver and include recent contributors.
This is a fairly new driver, so likely Mike will still be active for example.
(no problem if it turns out his address bounces and hence you've not included him
 - I'll find out shortly ;)

Otherwise, only real comment is on some whitespace + an extra include I'd like to see.

Given the changes are so minor, I'll make them whilst applying.
Applied to the togreg branch of iio.git but I will be rebasing that on rc1 in a few weeks
time.  So in meantime only pushed out as testing.

Thanks,

Jonathan

> 
> ---
> 
> Changes in  v2:
> - fix compile error
> - Link to v1: https://lore.kernel.org/linux-iio/20231218154045.219317-1-jerrysteve1101@gmail.com/
> - build-tested on linux-next
> 
> ---
> ---
>  drivers/iio/accel/Kconfig            |  8 +++-
>  drivers/iio/accel/Makefile           |  1 +
>  drivers/iio/accel/bmi088-accel-i2c.c | 69 ++++++++++++++++++++++++++++
>  3 files changed, 76 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/iio/accel/bmi088-accel-i2c.c
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 91adcac875a4..dc92cf599acb 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -254,11 +254,11 @@ config BMC150_ACCEL_SPI
>  
>  config BMI088_ACCEL
>  	tristate "Bosch BMI088 Accelerometer Driver"
> -	depends on SPI
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	select REGMAP
> -	select BMI088_ACCEL_SPI
> +	select BMI088_ACCEL_SPI if SPI
> +	select BMI088_ACCEL_I2C if I2C
>  	help
>  	  Say yes here to build support for the following Bosch accelerometers:
>  	  BMI088, BMI085, BMI090L. Note that all of these are combo module that
> @@ -267,6 +267,10 @@ config BMI088_ACCEL
>  	  This driver only implements the accelerometer part, which has its own
>  	  address and register map. BMG160 provides the gyroscope driver.
>  
> +config BMI088_ACCEL_I2C
> +	tristate
> +	select REGMAP_I2C
> +
>  config BMI088_ACCEL_SPI
>  	tristate
>  	select REGMAP_SPI
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 311ead9c3ef1..db90532ba24a 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
>  obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
>  obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
>  obj-$(CONFIG_BMI088_ACCEL) += bmi088-accel-core.o
> +obj-$(CONFIG_BMI088_ACCEL_I2C) += bmi088-accel-i2c.o
>  obj-$(CONFIG_BMI088_ACCEL_SPI) += bmi088-accel-spi.o
>  obj-$(CONFIG_DA280)	+= da280.o
>  obj-$(CONFIG_DA311)	+= da311.o
> diff --git a/drivers/iio/accel/bmi088-accel-i2c.c b/drivers/iio/accel/bmi088-accel-i2c.c
> new file mode 100644
> index 000000000000..642dc2607943
> --- /dev/null
> +++ b/drivers/iio/accel/bmi088-accel-i2c.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * 3-axis accelerometer driver supporting following Bosch-Sensortec chips:
> + *  - BMI088
> + *  - BMI085
> + *  - BMI090L
> + *
> + * Copyright 2023 Jun Yan <jerrysteve1101@gmail.com>
> + */
> +
#include <linux/mod_devicetable.h> 

for the various id tables (missing from the spi driver)

In general we try to include what is used in a given file
directly. There are exceptions to that though so don't take it too strongly
as advice.


> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +
> +#include "bmi088-accel.h"
> +
> +static int bmi088_accel_probe(struct i2c_client *i2c)
> +{
> +	struct regmap *regmap;
> +	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
> +
> +	regmap = devm_regmap_init_i2c(i2c, &bmi088_regmap_conf);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&i2c->dev, "Failed to initialize i2c regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return bmi088_accel_core_probe(&i2c->dev, regmap, i2c->irq,
> +					id->driver_data);
> +}
> +
> +static void bmi088_accel_remove(struct i2c_client *i2c)
> +{
> +	bmi088_accel_core_remove(&i2c->dev);
> +}
> +
> +static const struct of_device_id bmi088_of_match[] = {
> +	{ .compatible = "bosch,bmi085-accel" },
> +	{ .compatible = "bosch,bmi088-accel" },
> +	{ .compatible = "bosch,bmi090l-accel" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, bmi088_of_match);
> +
> +static const struct i2c_device_id bmi088_accel_id[] = {
> +	{"bmi085-accel",  BOSCH_BMI085},
> +	{"bmi088-accel",  BOSCH_BMI088},
> +	{"bmi090l-accel", BOSCH_BMI090L},

Prefer spaces after { and before }
(though I can see the spi driver doesn't do this either!)


> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, bmi088_accel_id);
> +
> +static struct i2c_driver bmi088_accel_driver = {
> +	.driver = {
> +		.name	= "bmi088_accel_i2c",
> +		.pm	= pm_ptr(&bmi088_accel_pm_ops),
> +		.of_match_table = bmi088_of_match,
> +	},
> +	.probe		= bmi088_accel_probe,
> +	.remove		= bmi088_accel_remove,
> +	.id_table	= bmi088_accel_id,
> +};
> +module_i2c_driver(bmi088_accel_driver);
> +
> +MODULE_AUTHOR("Jun Yan <jerrysteve1101@gmail.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("BMI088 accelerometer driver (I2C)");
> +MODULE_IMPORT_NS(IIO_BMI088);


