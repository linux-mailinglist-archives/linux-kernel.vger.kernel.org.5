Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E770A7740E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbjHHRLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbjHHRLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:11:15 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBB6676AE;
        Tue,  8 Aug 2023 09:04:40 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-63f7cd44d04so12001436d6.2;
        Tue, 08 Aug 2023 09:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510677; x=1692115477;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jQZJBbwdMv79VbdCMN0QjbjgAoPO359cdwuBvKh85WI=;
        b=Atm0cNCk1GlLkG7LiFx+/Mdz5dHTWGk2ek2SqMSOXhVvrbscDEq+FQkFMDWIXKgNV6
         ERwCFkAqo9i/NRQpATdzisLn8hfWYpHPFQgfoOt84f+GGGjIJU2EWnaO9BLu/SgepVJ/
         fyJF/8DTQqyQHz66MD9U1IGkiOyg2zHlg6y7kQQtwDGPd5rvrviupgu/7jWRTz0rz6VF
         7rnZyrRQh2qPMgUCb84dqKx56h1DloszH75NeP/PmgHS7NC3J/7nZQd1AYfK6WMlgHp7
         dMT+1ZsPcRjIcJnd4+3D2yXCldBd9cRsPJ0nyOIuuZvYHAAM6BKv0If9QIwVB3smDBAk
         h+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510677; x=1692115477;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQZJBbwdMv79VbdCMN0QjbjgAoPO359cdwuBvKh85WI=;
        b=KfEBL0ZeGVR0aaHMWmsyPTm9M5W68HciABj3BdtpG5WhXndCkkdC+rCv1gwzjC/ZnI
         lj9bZ15n55R0jbjRVoQqkjQI2hBAqw+yDqDOkJcMV840ZwsjNG9LvzNesWm9Ai69X8H+
         FiGAbIX4MxQUjaALLeePApiy2cqJXDjOavCWL6XUut16xQXQHGa3yXZGGVhnmuaGfCV0
         s9XrxkmimwFKH2Z8B1BkuQXxEccAbu4Qe5epc1mC1DCAvQflzXzp8nhCAxqtmkh5gRmj
         5vsN9PnpRZTTm8rpf5umgf9oJjRk/ZHEBfdPifeePXHBQd6jocmegA/HYEW+JNN3NH3V
         iT8A==
X-Gm-Message-State: AOJu0YwfR8hv+bTTieTs0McddoE01yv6sadvOq5FoXMvoQZEGdyanUmP
        yEnYsMowVxsUMnbnmCrWwORuLrVjRE0=
X-Google-Smtp-Source: AGHT+IGqkcfwv/wVSPrCaDkJmUWr81SIga2HSJ7SXZHc4bHDFHLYBQRDFKGa4z+ojFR+IudGKcfr0w==
X-Received: by 2002:a05:6a00:194a:b0:687:596e:fa6a with SMTP id s10-20020a056a00194a00b00687596efa6amr13657629pfk.16.1691468663551;
        Mon, 07 Aug 2023 21:24:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e19-20020a62aa13000000b006875df4773fsm6968856pff.163.2023.08.07.21.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 21:24:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <337d718b-e240-5d02-6a86-488ab8a0f25a@roeck-us.net>
Date:   Mon, 7 Aug 2023 21:24:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Mathew McBride <matt@traverse.com.au>
References: <20230808013157.80913-1-mark.tomlinson@alliedtelesis.co.nz>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] hwmon: Add driver for EMC181x temperature sensors
In-Reply-To: <20230808013157.80913-1-mark.tomlinson@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/23 18:31, Mark Tomlinson wrote:
> This patch adds a HWMON driver for the EMC1812, EMC1813, EMC1814,
> EMC1815 and EMC1833 temperature sensor chips from microchip. Does not

Microchip

> currently support the alert outputs.
> 

It doesn't support limit registers either. Odd, but I guess it is better to have
some driver support than nothing.

checkpatch --strict reports a couple of problems. Please fix.

> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> Co-developed-by: Mathew McBride <matt@traverse.com.au>
> Signed-off-by: Mathew McBride <matt@traverse.com.au>
> ---
>   drivers/hwmon/Kconfig   |  10 ++
>   drivers/hwmon/Makefile  |   1 +
>   drivers/hwmon/emc181x.c | 296 ++++++++++++++++++++++++++++++++++++++++

Documentation missing.

Also, please no wildcards in file names. EMC1833 doesn't even fit the pattern,
and the driver doesn't support ENC18[01] or EMC181[6-9]. Use one of the chips
as name. The datasheet says "EMC1812 family", which just as well works here.

>   3 files changed, 307 insertions(+)
>   create mode 100644 drivers/hwmon/emc181x.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 307477b8a371..196d91494536 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1820,6 +1820,16 @@ config SENSORS_EMC1403
>   	  Threshold values can be configured using sysfs.
>   	  Data from the different diodes are accessible via sysfs.
>   
> +config SENSORS_EMC181X
> +	tristate "SMSC EMC181X thermal sensor"

Again, no wildcards here. Also, s/SMSC/Microchip/

> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for the SMSC EMC181X
> +	  temperature monitoring chip.

EMC181X does not exist. List the supported chips.

> +
> +	  Data from the different diodes are accessible via sysfs.

That has no value.

> +
>   config SENSORS_EMC2103
>   	tristate "SMSC EMC2103"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 3f4b0fda0998..bcea887dfe17 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_SENSORS_DRIVETEMP)	+= drivetemp.o
>   obj-$(CONFIG_SENSORS_DS620)	+= ds620.o
>   obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
>   obj-$(CONFIG_SENSORS_EMC1403)	+= emc1403.o
> +obj-$(CONFIG_SENSORS_EMC181X)	+= emc181x.o
>   obj-$(CONFIG_SENSORS_EMC2103)	+= emc2103.o
>   obj-$(CONFIG_SENSORS_EMC2305)	+= emc2305.o
>   obj-$(CONFIG_SENSORS_EMC6W201)	+= emc6w201.o
> diff --git a/drivers/hwmon/emc181x.c b/drivers/hwmon/emc181x.c
> new file mode 100644
> index 000000000000..364d2bfb15ca
> --- /dev/null
> +++ b/drivers/hwmon/emc181x.c
> @@ -0,0 +1,296 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for the Microchip/SMSC EMC181x Temperature monitor
> + *
> + * Copyright (C) 2018-2019 Traverse Technologies
> + * Author: Mathew McBride <matt@traverse.com.au>
> + *
> + * Copyright (C) 2023 Allied Telesis Labs
> + * Author: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>

Not needed

> +#include <linux/of_device.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

Alphabetic order

> +
> +#define EMC1812_ID	0x81
> +#define EMC1813_ID	0x87
> +#define EMC1814_ID	0x84
> +#define EMC1815_ID	0x85
> +#define EMC1833_ID	0x83
> +
> +#define MICROCHIP_ID	0x54
> +
> +#define EMC181X_STATUS_REG	0x02
> +#define EMC181X_CONFIG_REG	0x03
> +#define EMC181X_DIODE_DATA_BASE	0x60
> +#define EMC181X_PID_REG		0xfd
> +#define EMC181X_SMSC_ID_REG	0xfe
> +#define EMC181X_REVISION_REG	0xff

Some of the above are not used. Drop unused definitions.

> +
> +/* Adjustable address type is 0x7c, 0x5c, 0x4c, 0x6c, 0x1c, 0x3c */
> +/* Fixed address is either 0x4c or 0x45 */

Irrelevant here.

> +static const unsigned short emc181x_address_list[] = {
> +	0x7c, 0x5c, 0x4c, 0x6c, 0x1c, 0x3c, 0x45, I2C_CLIENT_END

Numeric order, please.

> +};
> +
> +enum chips {
> +	emc1812, emc1813,
> +	emc1814, emc1815,
> +	emc1833,

One line is enough.

> +};
> +
> +struct emc181x_data {
> +	struct i2c_client *i2c;
> +	enum chips type;
> +	bool is_extended_range;
> +};
> +
> +static int emc181x_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	struct emc181x_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *i2c = data->i2c;
> +
Unnecessary empty line.

> +	u8 channel_reg = 0;
> +	s32 channel_deg = 0;
> +	s32 channel_frac = 0;

No unnecessary initializations, please.

> +
> +	if (type != hwmon_temp)
> +		return -EOPNOTSUPP;
> +	if (channel > 4)
> +		return -EINVAL;
> +
> +	channel_reg = EMC181X_DIODE_DATA_BASE + (channel * 0x02);
> +	channel_deg = i2c_smbus_read_byte_data(i2c, channel_reg);
> +	if (channel_deg < 0)
> +		return channel_deg;
> +	if (data->is_extended_range)
> +		channel_deg -= 64;
> +
> +	channel_frac = i2c_smbus_read_byte_data(i2c, channel_reg + 0x01);
> +	if (channel_frac < 0)
> +		return channel_frac;
> +
The above either needs to be mutex protected, or i2c_smbus_read_word_data()
needs to be used.

> +	*val = ((channel_deg << 3) | (channel_frac >> 5)) * 125;
> +	return 0;
> +}
> +
> +static umode_t emc181x_is_visible(const void *drvdata, enum hwmon_sensor_types type,
> +				  u32 attr, int channel)
> +{
> +	if (type == hwmon_temp && attr == hwmon_temp_input)
> +		return 0444;
> +	else

else after return is pointless.

> +		return 0;
> +}
> +
> +static const struct hwmon_channel_info *emc1812_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT, HWMON_T_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_channel_info *emc1813_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT, HWMON_T_INPUT, HWMON_T_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_channel_info *emc1814_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT, HWMON_T_INPUT, HWMON_T_INPUT,
> +			   HWMON_T_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_channel_info *emc1815_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT, HWMON_T_INPUT, HWMON_T_INPUT,
> +			   HWMON_T_INPUT, HWMON_T_INPUT),
> +	NULL
> +};

Only one of those is needed. The others should be handled with
the is_visible() function.

> +
> +static const struct hwmon_ops emc181x_ops = {
> +	.is_visible = emc181x_is_visible,
> +	.read = emc181x_read,
> +};
> +
> +static const struct hwmon_chip_info emc181x_chip_info[] = {
> +	[emc1812] = {
> +		.ops = &emc181x_ops,
> +		.info = emc1812_info,
> +	},
> +	[emc1813] = {
> +		.ops = &emc181x_ops,
> +		.info = emc1813_info,
> +	},
> +	[emc1814] = {
> +		.ops = &emc181x_ops,
> +		.info = emc1814_info,
> +	},
> +	[emc1815] = {
> +		.ops = &emc181x_ops,
> +		.info = emc1815_info,
> +	},
> +	[emc1833] = {
> +		.ops = &emc181x_ops,
> +		.info = emc1813_info,
> +	},
> +};
> +
> +static const struct i2c_device_id emc181x_i2c_id[] = {
> +	{ "emc1812", emc1812 },
> +	{ "emc1813", emc1813 },
> +	{ "emc1814", emc1814 },
> +	{ "emc1815", emc1815 },
> +	{ "emc1833", emc1833 },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, emc181x_i2c_id);
> +
> +/* Return 0 if detection is successful, -ENODEV otherwise */

... which is violated below.

> +static int emc181x_i2c_detect(struct i2c_client *client,
> +		       struct i2c_board_info *info)
> +{
> +	struct i2c_adapter *adapter = client->adapter;
> +	int pid, id, rev;
> +	const char *name;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_WORD_DATA))

While the driver should use I2C_FUNC_SMBUS_WORD_DATA, it currently doesn't.

> +		return -ENODEV;
> +
> +	/* Determine the chip type */

Unnecessary comment

> +	id = i2c_smbus_read_byte_data(client, EMC181X_SMSC_ID_REG);
> +	if (id < 0)
> +		return id;

-ENODEV should be returned here; if this is not an expected chip there
may be no register at this address.

> +	if (id != MICROCHIP_ID)
> +		return -ENODEV;
> +	pid = i2c_smbus_read_byte_data(client, EMC181X_PID_REG);
> +	if (pid < 0)
> +		return pid;
> +	rev = i2c_smbus_read_byte_data(client, EMC181X_REVISION_REG);
> +	if (rev < 0)
> +		return rev;
> +
> +	switch (pid) {
> +	case EMC1812_ID:
> +		name = emc181x_i2c_id[emc1812].name;
> +		break;
> +	case EMC1813_ID:
> +		name = emc181x_i2c_id[emc1813].name;
> +		break;
> +	case EMC1814_ID:
> +		name = emc181x_i2c_id[emc1814].name;
> +		break;
> +	case EMC1815_ID:
> +		name = emc181x_i2c_id[emc1815].name;
> +		break;
> +	case EMC1833_ID:
> +		name = emc181x_i2c_id[emc1833].name;
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +	strscpy(info->type, name, I2C_NAME_SIZE);
> +
> +	dev_dbg(&client->dev,
> +		"Detected device %s at 0x%02x with COMPANY: 0x%02x and PID: 0x%02x REV: 0x%02x\n",
> +		name, client->addr, id, pid, rev);

COMPANY is pretty pointless here.

> +
> +	return 0;
> +}
> +
> +static int emc181x_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct device *hwmon_dev;
> +	struct emc181x_data *data;
> +	s32 regval;
> +	u8 config;
> +
> +	data = devm_kzalloc(dev, sizeof(struct emc181x_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->i2c = client;
> +	if (dev_fwnode(dev)) {
> +		data->type = (enum chips)device_get_match_data(dev);
> +		data->is_extended_range = device_property_present(dev, "emc181x,extended-range");
> +	} else
> +		data->type = i2c_match_id(emc181x_i2c_id, client)->driver_data;
> +
> +	regval = i2c_smbus_read_byte_data(client, EMC181X_CONFIG_REG);
> +	if (regval < 0) {
> +		dev_dbg(dev, "Failed to read config reg %d", regval);
> +		return regval;
> +	}
> +
> +	/* By default, extended range is disabled in the EMC181X,
> +	 * if enabled we need to set this in the CONFIG register.
> +	 */

This is not the networking subsystem. Please use standard multi-line comments.

> +	config = regval & ~0x04;
> +	if (data->is_extended_range)
> +		config |= 0x04;
> +
> +	dev_dbg(dev, "EMC181X setting CONFIG to %d\n", config);
> +	if (config != regval)
> +		i2c_smbus_write_byte_data(client, EMC181X_CONFIG_REG, config);

Error handling missing.

> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev,
> +			client->name,
> +			data,
> +			&emc181x_chip_info[data->type],
> +			NULL);

Limit the number of continuation lines to what is necessary.

> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct of_device_id __maybe_unused emc181x_of_match[] = {

Drop __maybe_unused

> +	{
> +		.compatible = "microchip,emc1812",
> +		.data = (void *)emc1812
> +	},
> +	{
> +		.compatible = "microchip,emc1813",
> +		.data = (void *)emc1813
> +	},
> +	{
> +		.compatible = "microchip,emc1814",
> +		.data = (void *)emc1814
> +	},
> +	{
> +		.compatible = "microchip,emc1815",
> +		.data = (void *)emc1815
> +	},
> +	{
> +		.compatible = "microchip,emc1833",
> +		.data = (void *)emc1833
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, emc181x_of_match);
> +
> +static struct i2c_driver emc181x_i2c_driver = {
> +	.driver = {
> +		.name = "emc181x",
> +		.of_match_table = of_match_ptr(emc181x_of_match),

Drop of_match_ptr

> +	},
> +	.probe = emc181x_i2c_probe,
> +	.id_table = emc181x_i2c_id,
> +	.detect = emc181x_i2c_detect,
> +	.address_list = emc181x_address_list,
> +};
> +
> +module_i2c_driver(emc181x_i2c_driver);
> +
> +MODULE_DESCRIPTION("EMC181X Sensor Driver");
> +MODULE_AUTHOR("Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>");
> +MODULE_LICENSE("GPL");

