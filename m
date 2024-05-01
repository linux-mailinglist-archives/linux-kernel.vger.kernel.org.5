Return-Path: <linux-kernel+bounces-165344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 213958B8B83
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4D8283719
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4AF12C490;
	Wed,  1 May 2024 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqR3yTu9"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B01912DDB0;
	Wed,  1 May 2024 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714571831; cv=none; b=Z+PjHmYltXgVBrAnZJpWryQEAzW72bVvyu/XwDmSLKGehYeGH39oqgUweM6RQR5S6qlUOtLYHkDDFN9seypathUaPklw9wDRVVmr+PUDuE6MMxhr+w/n4hJ1Wv1/KiYhqtZheo+rfiCigL9ZyzC5UZKsUt9AwTw1jDcQ1VxbJ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714571831; c=relaxed/simple;
	bh=0IwDF370mUGKAUTu883Uraz1Z2Bl9+xCCGzhMGWOenA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhTVpOs2uVwMT5xPkfksyM1deNrW8RTcElmIlkpvquP2mXE5UfGevuzvo4KUCah8GQduAOK2no1ezXBKtK+5km3plc6kRCx8GqyB4EDyjsdg95W31Fa1klXMUuOxE069T1kQrtUr+YvTvtHGZbDq44PTk0TZzdPtYGWBasUEQ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqR3yTu9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed691fb83eso5969825b3a.1;
        Wed, 01 May 2024 06:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714571828; x=1715176628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RO3NzagFh8agZwzLbJncDa/0HPmkQm59LIWoEH2AcoM=;
        b=nqR3yTu9k8l8RN2DemgbJPQO7gEztZJ35o5S5NeDAFjYGcB3xNKL4wMkzOTw9wItTa
         +xkr7o0sr5qxrV3fpXrw7VMD0it/XIBazd76H7wsSSZlrlqDWtNP1/bSG8JuyFgNnOwX
         iF/MM9aU9m9Yd+UaZT29EAh2aVea/y4OdL6J2UqzHPCNhOFZouyGgdT96vNtiLiXANjQ
         Qy6MNnX9GQeBRisyr01eG2Vq7sayJsq3PqF6CsysmOYhInxWIcdCWORupB/9f0XCNmc7
         EwxmIPFDQUFv+t6eZO+zhp08+oiD7Ji1OfWYvhWHhlM8VEhdoTjJXmnUp/SmWj2kZ2LP
         wHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714571828; x=1715176628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RO3NzagFh8agZwzLbJncDa/0HPmkQm59LIWoEH2AcoM=;
        b=vQqAIfH4Q7YKjscgA7byn4I4TNgeEpPcs6DnhpYsluPAzQgy3jKXeTdtBVqSm9csz0
         HqzB5re4eqITw1WrNmQLWXyV9zVOJdAXkmgb9cY/24uZnJtkVoKQgOmcTNgQ2v/wzdjW
         pjbSkQIF/5BqcF24PXulksOlLv62H0K6Up/sFnXiwCUCIViyFN9jSv3IyDSKHcK4c6Ig
         D0MfG8ZDVHyQuLcd0SVgCqZg/j0AFcj+HvDdKye9SGv7bEYOa94SfB4rgpK3NDrvji6a
         1n5bxIZQ/8k2pa1tCgOLTgouwFXn0kZhTVc0k0bbKkJxyVLBrFnYAfpBSy2oxQBqs4HX
         +J4g==
X-Forwarded-Encrypted: i=1; AJvYcCVdLsaCEsfaciiQc1aJjKH7+PaY+4xpgEImUjMGGTDGoNFEY7mOEoC6md0yEur4yyyGirHDhiOW4pRoDlpzStCzn01rwad+29nMPHvV962AVrgr00f+xByyseByJCEHmK93/g+fGvEZEYI=
X-Gm-Message-State: AOJu0YxiRQQtu3EB50qY8ArNJEI/qyjCh9/VmHAL/8T/7KROE3w+8Ovt
	qDY4vwmM/LNqZRImHs8jeE0OAxkgRY9mcAklkl+lWhgir/RFKE6eqP9prw==
X-Google-Smtp-Source: AGHT+IHm6HHT6A1o2++On9I64iIi5mLDK/Ynd2qYn1Ao1S2xTD4LWC4vg2ZpeJsF9oZi6AiRAhZJ+A==
X-Received: by 2002:a05:6a00:b44:b0:6f3:e6ac:1a3f with SMTP id p4-20020a056a000b4400b006f3e6ac1a3fmr2862057pfo.11.1714571825982;
        Wed, 01 May 2024 06:57:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fe12-20020a056a002f0c00b006ea918dab9csm22626954pfb.157.2024.05.01.06.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 06:57:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 1 May 2024 06:57:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon (max6639): Use regmap
Message-ID: <52e7692c-abaa-4201-8248-3f42bb250335@roeck-us.net>
References: <20240430210539.935040-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430210539.935040-1-naresh.solanki@9elements.com>

On Wed, May 01, 2024 at 02:35:38AM +0530, Naresh Solanki wrote:
> Add regmap support & remove local caching.
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
>  drivers/hwmon/Kconfig   |   1 +
>  drivers/hwmon/max6639.c | 310 ++++++++++++++++++++--------------------
>  2 files changed, 154 insertions(+), 157 deletions(-)
> 
> 
> base-commit: 8b3aa2c488653fa1e127cf6e11499a8cbbaccad0
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index bafc0058c728..e14ae18a973b 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1233,6 +1233,7 @@ config SENSORS_MAX6621
>  config SENSORS_MAX6639
>  	tristate "Maxim MAX6639 sensor chip"
>  	depends on I2C
> +	select REGMAP_I2C
>  	help
>  	  If you say yes here you get support for the MAX6639
>  	  sensor chips.
> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> index 5dd0349e8bd0..b12d2098e259 100644
> --- a/drivers/hwmon/max6639.c
> +++ b/drivers/hwmon/max6639.c
> @@ -20,6 +20,7 @@
>  #include <linux/err.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_data/max6639.h>
> +#include <linux/regmap.h>
>  
>  /* Addresses to scan */
>  static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
> @@ -57,6 +58,8 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
>  
>  #define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED	0x40
>  
> +#define MAX6639_NDEV				2
> +
>  static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
>  
>  #define FAN_FROM_REG(val, rpm_range)	((val) == 0 || (val) == 255 ? \
> @@ -67,22 +70,11 @@ static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
>   * Client data (each client gets its own)
>   */
>  struct max6639_data {
> -	struct i2c_client *client;
> +	struct regmap *regmap;
>  	struct mutex update_lock;

I think that lock can be dropped entirely.

> -	bool valid;		/* true if following fields are valid */
> -	unsigned long last_updated;	/* In jiffies */
> -
> -	/* Register values sampled regularly */
> -	u16 temp[2];		/* Temperature, in 1/8 C, 0..255 C */
> -	bool temp_fault[2];	/* Detected temperature diode failure */
> -	u8 fan[2];		/* Register value: TACH count for fans >=30 */
> -	u8 status;		/* Detected channel alarms and fan failures */
>  
>  	/* Register values only written to */
> -	u8 pwm[2];		/* Register value: Duty cycle 0..120 */
> -	u8 temp_therm[2];	/* THERM Temperature, 0..255 C (->_max) */
> -	u8 temp_alert[2];	/* ALERT Temperature, 0..255 C (->_crit) */
> -	u8 temp_ot[2];		/* OT Temperature, 0..255 C (->_emergency) */
> +	u8 pwm[MAX6639_NDEV];		/* Register value: Duty cycle 0..120 */

pwm caching needs to be dropped as well. It is no longer initialized in
max6639_init_client(), but updated and later used in pwm_store() and
pwm_show(). Looking at the datasheet, the pwm registers are volatile
and should not be cached in the first place.


>  
>  	/* Register values initialized only once */
>  	u8 ppr;			/* Pulses per rotation 0..3 for 1..4 ppr */
> @@ -92,90 +84,58 @@ struct max6639_data {
>  	struct regulator *reg;
>  };
>  
> -static struct max6639_data *max6639_update_device(struct device *dev)
> -{
> -	struct max6639_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
> -	struct max6639_data *ret = data;
> -	int i;
> -	int status_reg;
> -
> -	mutex_lock(&data->update_lock);
> -
> -	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
> -		int res;
> -
> -		dev_dbg(&client->dev, "Starting max6639 update\n");
> -
> -		status_reg = i2c_smbus_read_byte_data(client,
> -						      MAX6639_REG_STATUS);
> -		if (status_reg < 0) {
> -			ret = ERR_PTR(status_reg);
> -			goto abort;
> -		}
> -
> -		data->status = status_reg;
> -
> -		for (i = 0; i < 2; i++) {
> -			res = i2c_smbus_read_byte_data(client,
> -					MAX6639_REG_FAN_CNT(i));
> -			if (res < 0) {
> -				ret = ERR_PTR(res);
> -				goto abort;
> -			}
> -			data->fan[i] = res;
> -
> -			res = i2c_smbus_read_byte_data(client,
> -					MAX6639_REG_TEMP_EXT(i));
> -			if (res < 0) {
> -				ret = ERR_PTR(res);
> -				goto abort;
> -			}
> -			data->temp[i] = res >> 5;
> -			data->temp_fault[i] = res & 0x01;
> -
> -			res = i2c_smbus_read_byte_data(client,
> -					MAX6639_REG_TEMP(i));
> -			if (res < 0) {
> -				ret = ERR_PTR(res);
> -				goto abort;
> -			}
> -			data->temp[i] |= res << 3;
> -		}
> -
> -		data->last_updated = jiffies;
> -		data->valid = true;
> -	}
> -abort:
> -	mutex_unlock(&data->update_lock);
> -
> -	return ret;
> -}
> -
>  static ssize_t temp_input_show(struct device *dev,
>  			       struct device_attribute *dev_attr, char *buf)
>  {
>  	long temp;
> -	struct max6639_data *data = max6639_update_device(dev);
> +	struct max6639_data *data = dev_get_drvdata(dev);
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> +	unsigned int val;
> +	int res;
>  
>  	if (IS_ERR(data))
>  		return PTR_ERR(data);

Drop

>  
> -	temp = data->temp[attr->index] * 125;
> +	mutex_lock(&data->update_lock);
> +	res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(attr->index), &val);
> +	if (res < 0)
> +		goto exit;
> +
> +	temp = val >> 5;
> +	res = regmap_read(data->regmap, MAX6639_REG_TEMP(attr->index), &val);
> +	if (res < 0)
> +		goto exit;
> +
> +	temp |= val << 3;
> +	temp *= 125;
> +
> +exit:
> +	mutex_unlock(&data->update_lock);

Given that updates to MAX6639_REG_TEMP are blocked for up to 250ms
after reading MAX6639_REG_TEMP_EXT, I think this lock is unnecessary.

> +	if (res < 0)
> +		return res;
> +
>  	return sprintf(buf, "%ld\n", temp);
>  }
>  
>  static ssize_t temp_fault_show(struct device *dev,
>  			       struct device_attribute *dev_attr, char *buf)
>  {
> -	struct max6639_data *data = max6639_update_device(dev);
> +	struct max6639_data *data = dev_get_drvdata(dev);
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> +	unsigned int val;
> +	int res;
>  
>  	if (IS_ERR(data))
>  		return PTR_ERR(data);

Drop

>  
> -	return sprintf(buf, "%d\n", data->temp_fault[attr->index]);
> +	mutex_lock(&data->update_lock);
> +	res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(attr->index), &val);
> +	mutex_unlock(&data->update_lock);

Updates are blocked for 250ms after the extended temperature is read.
I don't think there is a good reason to hold the lock while reading
the register; worst case the value will be read here and by another thread
from temp_input_show() at the same time, but that should not make a
practical difference.

> +
> +	if (res < 0)
> +		return res;
> +
> +	return sprintf(buf, "%d\n", val & 1);
>  }
>  
>  static ssize_t temp_max_show(struct device *dev,
> @@ -183,8 +143,17 @@ static ssize_t temp_max_show(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
>  	struct max6639_data *data = dev_get_drvdata(dev);
> +	unsigned int val;
> +	int res;
>  
> -	return sprintf(buf, "%d\n", (data->temp_therm[attr->index] * 1000));
> +	mutex_lock(&data->update_lock);
> +	res = regmap_read(data->regmap, MAX6639_REG_THERM_LIMIT(attr->index), &val);
> +	mutex_unlock(&data->update_lock);

Unnecessary lock. In general there is really hardly ever a good reason
to hold a local lock during single register regmap accesses. Regmap
serializes those accesses internally anyway.

> +
> +	if (res < 0)
> +		return res;
> +
> +	return sprintf(buf, "%d\n", (val * 1000));
>  }
>  
>  static ssize_t temp_max_store(struct device *dev,
> @@ -193,7 +162,6 @@ static ssize_t temp_max_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
>  	struct max6639_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	unsigned long val;
>  	int res;
>  
> @@ -202,10 +170,8 @@ static ssize_t temp_max_store(struct device *dev,
>  		return res;
>  
>  	mutex_lock(&data->update_lock);
> -	data->temp_therm[attr->index] = TEMP_LIMIT_TO_REG(val);
> -	i2c_smbus_write_byte_data(client,
> -				  MAX6639_REG_THERM_LIMIT(attr->index),
> -				  data->temp_therm[attr->index]);
> +	regmap_write(data->regmap, MAX6639_REG_THERM_LIMIT(attr->index),
> +		     TEMP_LIMIT_TO_REG(val));
>  	mutex_unlock(&data->update_lock);

Now unnecessary lock (it was necessary previously to ensure that
data->temp_therm[] and the register value are in sync).

>  	return count;
>  }
> @@ -215,8 +181,17 @@ static ssize_t temp_crit_show(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
>  	struct max6639_data *data = dev_get_drvdata(dev);
> +	unsigned int val;
> +	int res;
> +
> +	mutex_lock(&data->update_lock);
> +	res = regmap_read(data->regmap, MAX6639_REG_ALERT_LIMIT(attr->index), &val);
> +	mutex_unlock(&data->update_lock);

Unnecessary lock

>  
> -	return sprintf(buf, "%d\n", (data->temp_alert[attr->index] * 1000));
> +	if (res < 0)
> +		return res;
> +
> +	return sprintf(buf, "%d\n", (val * 1000));
>  }
>  
>  static ssize_t temp_crit_store(struct device *dev,
> @@ -225,7 +200,6 @@ static ssize_t temp_crit_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
>  	struct max6639_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	unsigned long val;
>  	int res;
>  
> @@ -234,10 +208,8 @@ static ssize_t temp_crit_store(struct device *dev,
>  		return res;
>  
>  	mutex_lock(&data->update_lock);
> -	data->temp_alert[attr->index] = TEMP_LIMIT_TO_REG(val);
> -	i2c_smbus_write_byte_data(client,
> -				  MAX6639_REG_ALERT_LIMIT(attr->index),
> -				  data->temp_alert[attr->index]);
> +	regmap_write(data->regmap, MAX6639_REG_ALERT_LIMIT(attr->index),
> +		     TEMP_LIMIT_TO_REG(val));

Now unnecessary lock

>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> @@ -248,8 +220,17 @@ static ssize_t temp_emergency_show(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
>  	struct max6639_data *data = dev_get_drvdata(dev);
> +	unsigned int val;
> +	int res;
>  
> -	return sprintf(buf, "%d\n", (data->temp_ot[attr->index] * 1000));
> +	mutex_lock(&data->update_lock);
> +	res = regmap_read(data->regmap, MAX6639_REG_OT_LIMIT(attr->index), &val);
> +	mutex_unlock(&data->update_lock);

Unnecessary lock

> +
> +	if (res < 0)
> +		return res;
> +
> +	return sprintf(buf, "%d\n", (val * 1000));
>  }
>  
>  static ssize_t temp_emergency_store(struct device *dev,
> @@ -258,7 +239,6 @@ static ssize_t temp_emergency_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
>  	struct max6639_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	unsigned long val;
>  	int res;
>  
> @@ -267,10 +247,7 @@ static ssize_t temp_emergency_store(struct device *dev,
>  		return res;
>  
>  	mutex_lock(&data->update_lock);
> -	data->temp_ot[attr->index] = TEMP_LIMIT_TO_REG(val);
> -	i2c_smbus_write_byte_data(client,
> -				  MAX6639_REG_OT_LIMIT(attr->index),
> -				  data->temp_ot[attr->index]);
> +	regmap_write(data->regmap, MAX6639_REG_OT_LIMIT(attr->index), TEMP_LIMIT_TO_REG(val));

Unnecessary lock

>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> @@ -290,7 +267,6 @@ static ssize_t pwm_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
>  	struct max6639_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	unsigned long val;
>  	int res;
>  
> @@ -299,12 +275,9 @@ static ssize_t pwm_store(struct device *dev,
>  		return res;
>  
>  	val = clamp_val(val, 0, 255);
> -
> -	mutex_lock(&data->update_lock);
>  	data->pwm[attr->index] = (u8)(val * 120 / 255);
> -	i2c_smbus_write_byte_data(client,
> -				  MAX6639_REG_TARGTDUTY(attr->index),
> -				  data->pwm[attr->index]);
> +	mutex_lock(&data->update_lock);
> +	regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(attr->index), data->pwm[attr->index]);
>  	mutex_unlock(&data->update_lock);

Now unnecessary lock (after data->pwm is removed)

>  	return count;
>  }
> @@ -312,26 +285,35 @@ static ssize_t pwm_store(struct device *dev,
>  static ssize_t fan_input_show(struct device *dev,
>  			      struct device_attribute *dev_attr, char *buf)
>  {
> -	struct max6639_data *data = max6639_update_device(dev);
> +	struct max6639_data *data = dev_get_drvdata(dev);
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> +	unsigned int val;
> +	int res;
>  
>  	if (IS_ERR(data))
>  		return PTR_ERR(data);
>  
> -	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
> -		       data->rpm_range));
> +	res = regmap_read(data->regmap, MAX6639_REG_FAN_CNT(attr->index), &val);
> +	if (res < 0)
> +		return res;
> +
> +	return sprintf(buf, "%d\n", FAN_FROM_REG(val, data->rpm_range));
>  }
>  
>  static ssize_t alarm_show(struct device *dev,
>  			  struct device_attribute *dev_attr, char *buf)
>  {
> -	struct max6639_data *data = max6639_update_device(dev);
> +	struct max6639_data *data = dev_get_drvdata(dev);
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> +	unsigned int val;
> +	int res;
>  
>  	if (IS_ERR(data))
>  		return PTR_ERR(data);
>  
> -	return sprintf(buf, "%d\n", !!(data->status & (1 << attr->index)));
> +	res = regmap_read(data->regmap, MAX6639_REG_STATUS, &val);
> +
> +	return sprintf(buf, "%d\n", !!(val & (1 << attr->index)));
>  }
>  
>  static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
> @@ -401,6 +383,11 @@ static int rpm_range_to_reg(int range)
>  	return 1; /* default: 4000 RPM */
>  }
>  
> +static int max6639_set_ppr(struct max6639_data *data, u8 channel, u8 ppr)
> +{
> +	return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), ppr << 6);
> +}
> +
>  static int max6639_init_client(struct i2c_client *client,
>  			       struct max6639_data *data)
>  {
> @@ -408,49 +395,43 @@ static int max6639_init_client(struct i2c_client *client,
>  		dev_get_platdata(&client->dev);
>  	int i;
>  	int rpm_range = 1; /* default: 4000 RPM */
> -	int err;
> +	int err, ppr;
>  
>  	/* Reset chip to default values, see below for GCONFIG setup */
> -	err = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
> -				  MAX6639_GCONFIG_POR);
> +	err = regmap_write(data->regmap, MAX6639_REG_GCONFIG, MAX6639_GCONFIG_POR);
>  	if (err)
>  		goto exit;
>  
>  	/* Fans pulse per revolution is 2 by default */
>  	if (max6639_info && max6639_info->ppr > 0 &&
>  			max6639_info->ppr < 5)
> -		data->ppr = max6639_info->ppr;
> +		ppr = max6639_info->ppr;
>  	else
> -		data->ppr = 2;
> -	data->ppr -= 1;
> +		ppr = 2;
> +	ppr -= 1;
>  
>  	if (max6639_info)
>  		rpm_range = rpm_range_to_reg(max6639_info->rpm_range);
>  	data->rpm_range = rpm_range;
>  
> -	for (i = 0; i < 2; i++) {
> +	for (i = 0; i < MAX6639_NDEV; i++) {
>  
>  		/* Set Fan pulse per revolution */
> -		err = i2c_smbus_write_byte_data(client,
> -				MAX6639_REG_FAN_PPR(i),
> -				data->ppr << 6);
> +		err = max6639_set_ppr(data, i, ppr);
>  		if (err)
>  			goto exit;
>  
>  		/* Fans config PWM, RPM */
> -		err = i2c_smbus_write_byte_data(client,
> -			MAX6639_REG_FAN_CONFIG1(i),
> -			MAX6639_FAN_CONFIG1_PWM | rpm_range);
> +		err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG1(i),
> +				   MAX6639_FAN_CONFIG1_PWM | rpm_range);
>  		if (err)
>  			goto exit;
>  
>  		/* Fans PWM polarity high by default */
>  		if (max6639_info && max6639_info->pwm_polarity == 0)
> -			err = i2c_smbus_write_byte_data(client,
> -				MAX6639_REG_FAN_CONFIG2a(i), 0x00);
> +			err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x00);
>  		else
> -			err = i2c_smbus_write_byte_data(client,
> -				MAX6639_REG_FAN_CONFIG2a(i), 0x02);
> +			err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x02);
>  		if (err)
>  			goto exit;
>  
> @@ -458,42 +439,31 @@ static int max6639_init_client(struct i2c_client *client,
>  		 * /THERM full speed enable,
>  		 * PWM frequency 25kHz, see also GCONFIG below
>  		 */
> -		err = i2c_smbus_write_byte_data(client,
> -			MAX6639_REG_FAN_CONFIG3(i),
> -			MAX6639_FAN_CONFIG3_THERM_FULL_SPEED | 0x03);
> +		err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG3(i),
> +				   MAX6639_FAN_CONFIG3_THERM_FULL_SPEED | 0x03);
>  		if (err)
>  			goto exit;
>  
>  		/* Max. temp. 80C/90C/100C */
> -		data->temp_therm[i] = 80;
> -		data->temp_alert[i] = 90;
> -		data->temp_ot[i] = 100;
> -		err = i2c_smbus_write_byte_data(client,
> -				MAX6639_REG_THERM_LIMIT(i),
> -				data->temp_therm[i]);
> +		err = regmap_write(data->regmap, MAX6639_REG_THERM_LIMIT(i), 80);
>  		if (err)
>  			goto exit;
> -		err = i2c_smbus_write_byte_data(client,
> -				MAX6639_REG_ALERT_LIMIT(i),
> -				data->temp_alert[i]);
> +		err = regmap_write(data->regmap, MAX6639_REG_ALERT_LIMIT(i), 90);
>  		if (err)
>  			goto exit;
> -		err = i2c_smbus_write_byte_data(client,
> -				MAX6639_REG_OT_LIMIT(i), data->temp_ot[i]);
> +		err = regmap_write(data->regmap, MAX6639_REG_OT_LIMIT(i), 100);
>  		if (err)
>  			goto exit;
>  
>  		/* PWM 120/120 (i.e. 100%) */
> -		data->pwm[i] = 120;
> -		err = i2c_smbus_write_byte_data(client,
> -				MAX6639_REG_TARGTDUTY(i), data->pwm[i]);
> +		err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(i), 120);
>  		if (err)
>  			goto exit;
>  	}
>  	/* Start monitoring */
> -	err = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
> -		MAX6639_GCONFIG_DISABLE_TIMEOUT | MAX6639_GCONFIG_CH2_LOCAL |
> -		MAX6639_GCONFIG_PWM_FREQ_HI);
> +	err = regmap_write(data->regmap, MAX6639_REG_GCONFIG,
> +			   MAX6639_GCONFIG_DISABLE_TIMEOUT | MAX6639_GCONFIG_CH2_LOCAL |
> +			   MAX6639_GCONFIG_PWM_FREQ_HI);
>  exit:
>  	return err;
>  }
> @@ -524,6 +494,30 @@ static void max6639_regulator_disable(void *data)
>  	regulator_disable(data);
>  }
>  
> +static bool max6639_regmap_is_volatile(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case MAX6639_REG_TEMP(0):
> +	case MAX6639_REG_TEMP_EXT(0):
> +	case MAX6639_REG_TEMP(1):
> +	case MAX6639_REG_TEMP_EXT(1):
> +	case MAX6639_REG_STATUS:
> +	case MAX6639_REG_FAN_CNT(0):
> +	case MAX6639_REG_FAN_CNT(1):

pwm registers are also volatile.

> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config max6639_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = MAX6639_REG_DEVREV,
> +	.cache_type = REGCACHE_MAPLE,
> +	.volatile_reg = max6639_regmap_is_volatile,
> +};
> +
>  static int max6639_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
> @@ -535,7 +529,11 @@ static int max6639_probe(struct i2c_client *client)
>  	if (!data)
>  		return -ENOMEM;
>  
> -	data->client = client;
> +	data->regmap = devm_regmap_init_i2c(client, &max6639_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev,
> +				     PTR_ERR(data->regmap),
> +				     "regmap initialization failed\n");
>  
>  	data->reg = devm_regulator_get_optional(dev, "fan");
>  	if (IS_ERR(data->reg)) {
> @@ -573,25 +571,24 @@ static int max6639_probe(struct i2c_client *client)
>  
>  static int max6639_suspend(struct device *dev)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
>  	struct max6639_data *data = dev_get_drvdata(dev);
> -	int ret = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
> +	int ret, err;
>  
> -	if (ret < 0)
> -		return ret;
> +	err = regmap_read(data->regmap, MAX6639_REG_GCONFIG, &ret);
> +

Unnecessary empty line.

> +	if (err < 0)
> +		return err;
>  
>  	if (data->reg)
>  		regulator_disable(data->reg);
>  
> -	return i2c_smbus_write_byte_data(client,
> -			MAX6639_REG_GCONFIG, ret | MAX6639_GCONFIG_STANDBY);
> +	return regmap_write(data->regmap, MAX6639_REG_GCONFIG, ret | MAX6639_GCONFIG_STANDBY);
>  }
>  
>  static int max6639_resume(struct device *dev)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
>  	struct max6639_data *data = dev_get_drvdata(dev);
> -	int ret;
> +	int ret, err;
>  
>  	if (data->reg) {
>  		ret = regulator_enable(data->reg);
> @@ -601,12 +598,11 @@ static int max6639_resume(struct device *dev)
>  		}
>  	}
>  
> -	ret = i2c_smbus_read_byte_data(client, MAX6639_REG_GCONFIG);
> -	if (ret < 0)
> -		return ret;
> +	err = regmap_read(data->regmap, MAX6639_REG_GCONFIG, &ret);
> +	if (err < 0)
> +		return err;
>  
> -	return i2c_smbus_write_byte_data(client,
> -			MAX6639_REG_GCONFIG, ret & ~MAX6639_GCONFIG_STANDBY);
> +	return regmap_write(data->regmap, MAX6639_REG_GCONFIG, ret & ~MAX6639_GCONFIG_STANDBY);
>  }
>  
>  static const struct i2c_device_id max6639_id[] = {

