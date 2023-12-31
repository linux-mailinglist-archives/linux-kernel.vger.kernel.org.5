Return-Path: <linux-kernel+bounces-13781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E82A1820C7D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 19:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E511F21DBD
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 18:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D91F9E0;
	Sun, 31 Dec 2023 18:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMTrr+Ib"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688FAF9C4;
	Sun, 31 Dec 2023 18:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-35fb39c9dcaso40311485ab.2;
        Sun, 31 Dec 2023 10:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704047577; x=1704652377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPxDhV2DoSEaju0MY7mnRtbVT0XkCMWBP3dJFYBm6x8=;
        b=iMTrr+IbNhIo6xWUfisMHm96gx6lkhFluKVusHLncsPBbvR4Km+rleJNs0wrlhxcFP
         Qr0UXM/IBafCuuuKZeFPfeNa3QVSqSTHI3zQSMx79rbs5aF0cGfNzZCIxSr8B8bRtiFr
         PUC/Ithgy7JdVfdCv2KX02mSvRFL0lebm/wEMYQfWMeQkqncHiZ3HQ3NJdt7K4WI0X6l
         66gNtQBpsRwbhReZDELgUTByyaGi2XpCqkidQiI9qTpqsh8Bip4+Fcqh674c4+FFa802
         owIQrUzhaXZrKzA0OySNyn2l3RLBOMunAUg5g9YkSbfOc8KXb7l4yOUW9n1nqDZOeiZL
         p+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704047577; x=1704652377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPxDhV2DoSEaju0MY7mnRtbVT0XkCMWBP3dJFYBm6x8=;
        b=JEpb8JYnIcU23WBXl+YwrTUmhLaAEfk1GatXBZH8M3Nv8ekybUJq5mEs9+BflozIkw
         ouJnvRvWisgt3zMVYMK0oNAzmrBn6cfNGbUUWmTFRdova7Q9IGSH/YtO28aXAJZlqR/E
         kc02mLmnfX1FN8yhsWGWAeqbSXCgYTACeJSiCItvZ0VIx6ZIUBT9C5HsNPYqmL8AOPHB
         SjO3zTsJFl80FI3Wce9TsI73ojn38r2OkhgPmjXUt/WHJJuOi9emmFKOzJJ3akBaq6gf
         UFDsC+pX0gyG6zVdOKF4KFFsYhYn2S5N28naIuDy1t3Fds0KfwOE5JSJ32kMnzZpEiJO
         AVzA==
X-Gm-Message-State: AOJu0Yz6DhRmE5OMzEipcj6cKZ0IXN93nTjdLdS3/0mF5MSf2b9g9baJ
	qqv7aCzEILovq5DXKM8j09A=
X-Google-Smtp-Source: AGHT+IHLkpzy9hlz0hmq8tE4by5tSjoSu5tF+z6yRAUTuN679aGgua/VuYNLhwirFxAJ9y7gTnbpsg==
X-Received: by 2002:a05:6e02:16cf:b0:35f:f01e:bb2d with SMTP id 15-20020a056e0216cf00b0035ff01ebb2dmr24139543ilx.26.1704047577323;
        Sun, 31 Dec 2023 10:32:57 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id iz2-20020a170902ef8200b001d49c061804sm4766204plb.202.2023.12.31.10.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 10:32:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 31 Dec 2023 10:32:56 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Stefan Gloor <code@stefan-gloor.ch>
Cc: jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] hwmon: (sht3x) read out sensor serial number
Message-ID: <4389cd48-5d61-49bc-8cb5-b337afe40c23@roeck-us.net>
References: <20231227190036.20725-1-code@stefan-gloor.ch>
 <20231227190036.20725-2-code@stefan-gloor.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227190036.20725-2-code@stefan-gloor.ch>

On Wed, Dec 27, 2023 at 08:00:36PM +0100, Stefan Gloor wrote:
> The temperature/humidity sensors of the STS3x/SHT3x family are
> calibrated and factory-programmed with a unique serial number.
> For some sensors, this serial number can be used to obtain a calibration
> certificate via an API provided by the manufacturer (Sensirion).
> Expose the serial number via debugfs.
> 
> Tested with: 2x STS31, 1x STS32, 1x SHT31
> 
> Signed-off-by: Stefan Gloor <code@stefan-gloor.ch>
> ---
>  Documentation/hwmon/sht3x.rst | 11 +++++++
>  drivers/hwmon/sht3x.c         | 56 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/sht3x.rst b/Documentation/hwmon/sht3x.rst
> index 957c854f5d08..9585fa7c5a5d 100644
> --- a/Documentation/hwmon/sht3x.rst
> +++ b/Documentation/hwmon/sht3x.rst
> @@ -65,6 +65,10 @@ When the temperature and humidity readings move back between the hysteresis
>  values, the alert bit is set to 0 and the alert pin on the sensor is set to
>  low.
>  
> +The serial number exposed to debugfs allows for unique identification of the
> +sensors. For sts32, sts33 and sht33, the manufacturer provides calibration
> +certificates through an API.
> +
>  sysfs-Interface
>  ---------------
>  
> @@ -99,3 +103,10 @@ repeatability:      write or read repeatability, higher repeatability means
>                          - 1: medium repeatability
>                          - 2: high repeatability
>  =================== ============================================================
> +
> +debugfs-Interface
> +-----------------
> +
> +=================== ============================================================
> +serial_number:      unique serial number of the sensor in decimal
> +=================== ============================================================
> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
> index 79657910b79e..e016e0d9a6c4 100644
> --- a/drivers/hwmon/sht3x.c
> +++ b/drivers/hwmon/sht3x.c
> @@ -10,6 +10,7 @@
>  
>  #include <asm/page.h>
>  #include <linux/crc8.h>
> +#include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/hwmon.h>
> @@ -41,6 +42,9 @@ static const unsigned char sht3x_cmd_heater_off[]              = { 0x30, 0x66 };
>  /* other commands */
>  static const unsigned char sht3x_cmd_read_status_reg[]         = { 0xf3, 0x2d };
>  static const unsigned char sht3x_cmd_clear_status_reg[]        = { 0x30, 0x41 };
> +static const unsigned char sht3x_cmd_read_serial_number[]      = { 0x37, 0x80 };
> +
> +static struct dentry *debugfs;
>  
>  /* delays for single-shot mode i2c commands, both in us */
>  #define SHT3X_SINGLE_WAIT_TIME_HPM  15000
> @@ -169,6 +173,7 @@ struct sht3x_data {
>  	u32 wait_time;			/* in us*/
>  	unsigned long last_update;	/* last update in periodic mode*/
>  	enum sht3x_repeatability repeatability;
> +	u32 serial_number;
>  
>  	/*
>  	 * cached values for temperature and humidity and limits
> @@ -831,6 +836,36 @@ static int sht3x_write(struct device *dev, enum hwmon_sensor_types type,
>  	}
>  }
>  
> +static void sht3x_debugfs_init(struct sht3x_data *data)
> +{
> +	char name[32];
> +	struct dentry *sensor_dir;
> +
> +	snprintf(name, sizeof(name), "i2c%u-%02x",
> +		 data->client->adapter->nr, data->client->addr);
> +	sensor_dir = debugfs_create_dir(name, debugfs);
> +	debugfs_create_u32("serial_number", 0444,
> +			   sensor_dir, &data->serial_number);

This creates i2c<bus>-<address>/serial_number when the device is instantiated.
That debugfs entry is not removed when the device is removed, only when the
driver is unloaded. This means that de-instantiating the device will leave
stray debugfs directories and files behind until the driver is unloaded.

We had this before, and I understand that you claimed that this doesn't happen.
To get me to believe you, you'll have to provide a log of

- instantiating the driver 
- Showing the debufs tree
- de-instantiating the driver
- Showing the debugfs tree

... but even then I'll want to be able to test it myself. Not sure if I
have an eval board, but either case that will take some time. Frankly,
I don't understand why you refuse to remove
i2c<bus>-<address>/serial_number on device removal.

Guenter

> +}
> +
> +static int sht3x_serial_number_read(struct sht3x_data *data)
> +{
> +	int ret;
> +	char buffer[SHT3X_RESPONSE_LENGTH];
> +	struct i2c_client *client = data->client;
> +
> +	ret = sht3x_read_from_command(client, data,
> +				      sht3x_cmd_read_serial_number,
> +				      buffer,
> +				      SHT3X_RESPONSE_LENGTH, 0);
> +	if (ret)
> +		return ret;
> +
> +	data->serial_number = (buffer[0] << 24) | (buffer[1] << 16) |
> +			      (buffer[3] << 8) | buffer[4];
> +	return ret;
> +}
> +
>  static const struct hwmon_ops sht3x_ops = {
>  	.is_visible = sht3x_is_visible,
>  	.read = sht3x_read,
> @@ -899,6 +934,13 @@ static int sht3x_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> +	ret = sht3x_serial_number_read(data);
> +	if (ret) {
> +		dev_dbg(dev, "unable to read serial number\n");
> +	} else {
> +		sht3x_debugfs_init(data);
> +	}
> +
>  	hwmon_dev = devm_hwmon_device_register_with_info(dev,
>  							 client->name,
>  							 data,
> @@ -917,7 +959,19 @@ static struct i2c_driver sht3x_i2c_driver = {
>  	.id_table    = sht3x_ids,
>  };
>  
> -module_i2c_driver(sht3x_i2c_driver);
> +static int __init sht3x_init(void)
> +{
> +	debugfs = debugfs_create_dir("sht3x", NULL);
> +	return i2c_add_driver(&sht3x_i2c_driver);
> +}
> +module_init(sht3x_init);
> +
> +static void __exit sht3x_cleanup(void)
> +{
> +	debugfs_remove_recursive(debugfs);
> +	i2c_del_driver(&sht3x_i2c_driver);
> +}
> +module_exit(sht3x_cleanup);
>  
>  MODULE_AUTHOR("David Frey <david.frey@sensirion.com>");
>  MODULE_AUTHOR("Pascal Sachs <pascal.sachs@sensirion.com>");

