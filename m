Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B994680CE60
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343711AbjLKObY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbjLKObW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:31:22 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37071B8;
        Mon, 11 Dec 2023 06:31:29 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d0538d9bbcso41937345ad.3;
        Mon, 11 Dec 2023 06:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702305089; x=1702909889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b19xQFHlq0u950n+bog20AYxBcPy/la29CiM3A31JeQ=;
        b=kAyduG16tFHMTi8rXPrVolPfYGbxdsBU9Gm9Lf95zFVCTC0QwslhvJ6HXqB66u+3iR
         NSzrOwHPXtec8vFh6sOYPlJGocnmKPjOxFMLeWm6910P/Wn5t+Qp4E0qDAgzdmpnUDVu
         kKY8cw20PaQmyfVRlw35ssgTCkyvuneg++phveO1FlPqWrLnte3kfZzxoy2pP0LOI7Wx
         HmrQ8Y1CLUhwgcd8nUttkFxMBGug+VhAIOpn2d8n/3teh/o75CY5eYzbQ/BWTi4HHWww
         1BDKS46oGAz7cvIi8JYAt6UxrFAuQheTQKXYDxvlr0puuvFW5+rL0XSJ0ON9KVM1F3F6
         D7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702305089; x=1702909889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b19xQFHlq0u950n+bog20AYxBcPy/la29CiM3A31JeQ=;
        b=rfPouWdIg/2l8OBid2bBppbEq2xzEhUphpNu1J1KomD6Oj1tA5nXqn//dSRp6BIOQY
         SJCOx+KFw+XzXnZZXLKCSiia+Gm084oA3WR+QMQXmu3C5BiOqGFlu4lTSBe4iTkhK8CN
         NC+uDEQ4vQ8A6dJFITeEdSyS5kTcxYFFLpoaYALseZbJITzUo+aMde8DR9AYKL9kdAlx
         UZtOXJHVvvMh454Y9qpUI4aouJlfhIsgEn8gTFoN0JsxK6DZNscjizGswcNkA1TglQNK
         qmPNbuEKnhLVPc+yYsf+gE41nKAD4sEA7WInNA8PAfWUOugEaA0LSol0ndxcm6cLM0R2
         N8ig==
X-Gm-Message-State: AOJu0YzEFvqYOwKH1c/6A80Mt/H2egaAmQVxtMnm/tODKDuX+rSS8ffy
        tfuhsj7O77JH8ZiOs8y/2mc=
X-Google-Smtp-Source: AGHT+IHNlVNjJKEoVfO3P9Qel67SfN6xGGJzHvc9sSj7Z04E+MkMNQcff2T5wRsNUOWvRkPBChGJGA==
X-Received: by 2002:a17:90b:108:b0:286:cc10:f2c6 with SMTP id p8-20020a17090b010800b00286cc10f2c6mr3331656pjz.20.1702305088512;
        Mon, 11 Dec 2023 06:31:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mh17-20020a17090b4ad100b002865028e17csm8433001pjb.9.2023.12.11.06.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:31:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 11 Dec 2023 06:31:27 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stefan Gloor <code@stefan-gloor.ch>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: sht3x: read out sensor serial number
Message-ID: <69065f64-1448-4513-bdda-a25a913e914d@roeck-us.net>
References: <20231204165004.8491-1-code@stefan-gloor.ch>
 <20231204165004.8491-3-code@stefan-gloor.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204165004.8491-3-code@stefan-gloor.ch>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 05:50:04PM +0100, Stefan Gloor wrote:
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
>  drivers/hwmon/sht3x.c         | 55 +++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
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
> index 79657910b79e..537365c6213b 100644
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
> @@ -41,6 +42,7 @@ static const unsigned char sht3x_cmd_heater_off[]              = { 0x30, 0x66 };
>  /* other commands */
>  static const unsigned char sht3x_cmd_read_status_reg[]         = { 0xf3, 0x2d };
>  static const unsigned char sht3x_cmd_clear_status_reg[]        = { 0x30, 0x41 };
> +static const unsigned char sht3x_cmd_read_serial_number[]      = { 0x37, 0x80 };
>  
>  /* delays for single-shot mode i2c commands, both in us */
>  #define SHT3X_SINGLE_WAIT_TIME_HPM  15000
> @@ -163,12 +165,14 @@ struct sht3x_data {
>  	enum sht3x_chips chip_id;
>  	struct mutex i2c_lock; /* lock for sending i2c commands */
>  	struct mutex data_lock; /* lock for updating driver data */
> +	struct dentry *debugfs;
>  
>  	u8 mode;
>  	const unsigned char *command;
>  	u32 wait_time;			/* in us*/
>  	unsigned long last_update;	/* last update in periodic mode*/
>  	enum sht3x_repeatability repeatability;
> +	u32 serial_number;
>  
>  	/*
>  	 * cached values for temperature and humidity and limits
> @@ -831,6 +835,50 @@ static int sht3x_write(struct device *dev, enum hwmon_sensor_types type,
>  	}
>  }
>  
> +#ifdef CONFIG_DEBUG_FS
> +
> +static void sht3x_debugfs_init(struct sht3x_data *data)
> +{
> +	char name[32];
> +	struct dentry *sensor_dir;
> +
> +	data->debugfs = debugfs_lookup("sht3x", NULL);
> +	if (IS_ERR_OR_NULL(data->debugfs))
> +		data->debugfs = debugfs_create_dir("sht3x", NULL);
> +
> +	snprintf(name, sizeof(name), "i2c%u-%02x",
> +		 data->client->adapter->nr, data->client->addr);
> +	sensor_dir = debugfs_create_dir(name, data->debugfs);
> +	debugfs_create_u32("serial_number", 0444,
> +			   sensor_dir, &data->serial_number);
> +}
> +
> +#else
> +
> +static void sht3x_debugfs_init(struct sht3x_data *data)
> +{
> +}
> +
> +#endif

debugfs doesn't need if/else or error handling.


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
> @@ -899,6 +947,13 @@ static int sht3x_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> +	ret = sht3x_serial_number_read(data);
> +	if (ret) {
> +		dev_dbg(dev, "unable to read serial number\n");
> +		data->serial_number = 0;
> +	}
> +	sht3x_debugfs_init(data);

The debugfs entry should not be created in the first place if the
serial number can not be read. On top of that, the debugfs entries
are never removed, meaning the system will crash if the driver or device
is unloaded and the no longer referenced debugfs file is accessed.

Guenter

> +
>  	hwmon_dev = devm_hwmon_device_register_with_info(dev,
>  							 client->name,
>  							 data,
