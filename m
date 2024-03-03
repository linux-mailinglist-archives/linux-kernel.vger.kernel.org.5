Return-Path: <linux-kernel+bounces-89766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3290086F53C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D07C1B20ED5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2A35A0F3;
	Sun,  3 Mar 2024 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmMAWPUZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0C3C13C;
	Sun,  3 Mar 2024 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709474291; cv=none; b=Ztjo5tUuQdGG5PiUgDKhyYISIM0o7ZjGJa+RyEYyCb0qPo3HotMZif0Oe7raGfk+nWJle9WxtEafmwP3Q8xl5xRLaNS4hQLeb56tnTxHMVlGROSsqVJnVmWThllvRv6YUBL6lh4tTNHDILFmtO7cFOLOfKtGFHnekpy2I69T7+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709474291; c=relaxed/simple;
	bh=MjPIxpfAeiZZL4eg2s02BwA6M8J/YUQWVRVMDNpAOzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2hXcxYm3w/WVhsUeBfWfNtPZEWoluIH6roRrcovuLCkoqz9E9V5CuGtGVsMW8KqH3RX7Z5gugAcoNqbbMsdTljDfA2p3C0q3pMxH8/J60yxgfVTVmLp60+tCsTdYR03lRxH61Gt1A9EV49P1JOaU4BJP1Bj4Sb/OlyRf0r9pSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmMAWPUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA16C433F1;
	Sun,  3 Mar 2024 13:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709474291;
	bh=MjPIxpfAeiZZL4eg2s02BwA6M8J/YUQWVRVMDNpAOzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cmMAWPUZ96qgbauU0bTEdY/wA/r+dda6+MqBGQAFKRVFwqB2ws4dV58TUD57MOPpU
	 BfmZ4PDTrNYbD4pb2cYfKuBnX9hgbpaVNnvjU0YAWr6aWSJm+BHp0tiaOqxNSWiMhG
	 xyRZ1EdwtNXND4TLxb2VpDWGLt3aZqQTQC0pM4YE6EpBgp6rmynXBooGO/pL7QM+Zl
	 eCzoGlA+2QW4GB++LLPGV89e5S5TGIL4rjPWBkVDmh/g/U99qdywnToJ6p/hFuoAnA
	 jN3DdDieChK9VYjnZ81K9RB5UhYmdwt9vzPLu3AzTHajxi6k/gMvmH6tislOVamWdX
	 NV5QIiNeDrh4g==
Date: Sun, 3 Mar 2024 13:57:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: light: isl29018: Drop ACPI specifics from
 the code
Message-ID: <20240303135758.2068ab7c@jic23-huawei>
In-Reply-To: <20240228212746.3709512-1-andriy.shevchenko@linux.intel.com>
References: <20240228212746.3709512-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 23:27:46 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic. The ACPI
> APIs are not required and can be replaced by respective agnostic
> ones.
> 
> Include mod_devicetable.h explicitly to replace the dropped of.h
> which included mod_devicetable.h indirectly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/light/isl29018.c | 44 +++++++++++++-----------------------
>  1 file changed, 16 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
> index 43484c18b101..fe7b9ad7ff35 100644
> --- a/drivers/iio/light/isl29018.c
> +++ b/drivers/iio/light/isl29018.c
> @@ -8,17 +8,19 @@
>   * Copyright (c) 2010, NVIDIA Corporation.
>   */
>  
> -#include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/err.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/delay.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> +
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include <linux/acpi.h>
>  
>  #define ISL29018_CONV_TIME_MS		100
>  
> @@ -523,9 +525,9 @@ static const struct attribute_group isl29023_group = {
>  };
>  
>  enum {
> -	isl29018,
> -	isl29023,
> -	isl29035,
> +	isl29018 = 1,
> +	isl29023 = 2,
> +	isl29035 = 3,

I really don't like doing this non zero trick (I did once let a few instances of
this trick in and should get round to cleaning them up properly...)

I'd rather see a trivial chip_info structure with the names in it and pointers
in each of the fw match tables + use of i2c_get_match_data() to deal with
all the options.

+ get rid of the type / dev_id usage infavor of everything in a chip_info
structure.  I think that is just the intergration times arrays.

Obviously bit mean to ask  you to do this larger refactor, but I'm not going
to take this avoidance of enum == 0 in the meantime.

Jonathan



>  };
>  
>  static int isl29018_chip_init(struct isl29018_chip *chip)
> @@ -687,20 +689,6 @@ static const struct isl29018_chip_info isl29018_chip_info_tbl[] = {
>  	},
>  };
>  
> -static const char *isl29018_match_acpi_device(struct device *dev, int *data)
> -{
> -	const struct acpi_device_id *id;
> -
> -	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -
> -	if (!id)
> -		return NULL;
> -
> -	*data = (int)id->driver_data;
> -
> -	return dev_name(dev);
> -}
> -
>  static void isl29018_disable_regulator_action(void *_data)
>  {
>  	struct isl29018_chip *chip = _data;
> @@ -718,6 +706,7 @@ static int isl29018_probe(struct i2c_client *client)
>  	struct iio_dev *indio_dev;
>  	int err;
>  	const char *name = NULL;
> +	const void *match;
>  	int dev_id = 0;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> @@ -728,14 +717,15 @@ static int isl29018_probe(struct i2c_client *client)
>  
>  	i2c_set_clientdata(client, indio_dev);
>  
> -	if (id) {
> +	match = device_get_match_data(dev);
> +	if (match) {
> +		name = dev_name(dev);
> +		dev_id = (int)(uintptr_t)match;
> +	} else if (id) {
>  		name = id->name;
>  		dev_id = id->driver_data;
>  	}
>  
> -	if (ACPI_HANDLE(&client->dev))
> -		name = isl29018_match_acpi_device(&client->dev, &dev_id);
> -
>  	mutex_init(&chip->lock);
>  
>  	chip->type = dev_id;
> @@ -832,15 +822,13 @@ static int isl29018_resume(struct device *dev)
>  static DEFINE_SIMPLE_DEV_PM_OPS(isl29018_pm_ops, isl29018_suspend,
>  				isl29018_resume);
>  
> -#ifdef CONFIG_ACPI
>  static const struct acpi_device_id isl29018_acpi_match[] = {
>  	{"ISL29018", isl29018},
>  	{"ISL29023", isl29023},
>  	{"ISL29035", isl29035},
> -	{},
> +	{}
>  };
>  MODULE_DEVICE_TABLE(acpi, isl29018_acpi_match);
> -#endif
>  
>  static const struct i2c_device_id isl29018_id[] = {
>  	{"isl29018", isl29018},
> @@ -854,14 +842,14 @@ static const struct of_device_id isl29018_of_match[] = {
>  	{ .compatible = "isil,isl29018", },
>  	{ .compatible = "isil,isl29023", },
>  	{ .compatible = "isil,isl29035", },
> -	{ },
> +	{}
>  };
>  MODULE_DEVICE_TABLE(of, isl29018_of_match);
>  
>  static struct i2c_driver isl29018_driver = {
>  	.driver	 = {
>  			.name = "isl29018",
> -			.acpi_match_table = ACPI_PTR(isl29018_acpi_match),
> +			.acpi_match_table = isl29018_acpi_match,
>  			.pm = pm_sleep_ptr(&isl29018_pm_ops),
>  			.of_match_table = isl29018_of_match,
>  		    },


