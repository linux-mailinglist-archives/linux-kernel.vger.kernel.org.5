Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B71E77D40F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbjHOU0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237770AbjHOU0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:26:06 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C1610E9;
        Tue, 15 Aug 2023 13:26:04 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34aa0a1a2fbso9347605ab.3;
        Tue, 15 Aug 2023 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692131163; x=1692735963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQDhzOcN+3HDYW+nBUi18s7dS5yFFJdyxj55M64XNc0=;
        b=iZpOqNQXUWfplU6r/8SIKjETo8vmSTEni9qxBzn4E9MHK7JaAjk8z+wIsXqEZkgwlf
         0SwNL035oo11k97BJH88EJpPjc06MfnrjkPiCa9jU1BXtpq/IS/jiTVvAxLi2ggKsDgh
         mryUOv0/9qFG85jmCPIW+RiiJcuNLj0eu3pcJ199w7QegIz7dTT2O8hA0jPH7bfqQkVx
         9uMHX7PpFVTk3YVKkanBKIqKj3j1W/BtaKu9ldQdFkFQ0MQRN5bVjQibMS4OBUGa4PF2
         hoaiMUO/FI5JkTobYYppWdcHEPJx+AXUy3SvYqQ1fbA1M5lw+U3otxlt1jMWZFbHcUXZ
         vhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692131163; x=1692735963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQDhzOcN+3HDYW+nBUi18s7dS5yFFJdyxj55M64XNc0=;
        b=McW5+OTz8hgffw2mLm0dEExnSs54fMTDA9j7RaZGYXaj/f9p0i854Xr7Bb3bPgY6XP
         d1iBHkJ7USrSpkRjjfjUye6gMOxf6pPFiegLteBfKfqCbxR4ralBYXJkoFXn+GmVgTn8
         eMAE/7Z2Zpjxu7KdO2xR9QILAgjkNqvKXzr7cwjzmkqleKMUM+3F7UafaaVPwCSD7yDQ
         OlLf3sxcwybR/dB/1YWqe+qYAv8laAQXjcw09vILmFQMb1NBgDJePyGfgTcdog9stT7w
         Mo0DeyCyBpogTyvvx6HDFsNd8Yt7FO8BsokJmBLGWf4BIYD6XxhkbE4r/Vj0knVw/esC
         vpfw==
X-Gm-Message-State: AOJu0YyfPSUNqV+Ep+plkbm2RR9IZ68eQQuFqDc+lJhRCTutNwp7QTPP
        MaziZXTBAkG+taLZ8fYh/Mw=
X-Google-Smtp-Source: AGHT+IHh2CYKe63K0ltMKYXOuVc4y4AKKDfpSOtP+DUnybvfD58aeV2kFVenRmRtawExUxeo7WiqVg==
X-Received: by 2002:a05:6e02:e02:b0:349:2d48:66ac with SMTP id a2-20020a056e020e0200b003492d4866acmr49589ilk.12.1692131163125;
        Tue, 15 Aug 2023 13:26:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w6-20020a029686000000b004302760aa6bsm3867992jai.4.2023.08.15.13.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 13:26:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 15 Aug 2023 13:26:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     hdegoede@redhat.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (sch5627) Add support for writing limit
 registers
Message-ID: <f22394cf-3c5c-4251-b3ca-cb97bdba90f3@roeck-us.net>
References: <20230815165558.4176-1-W_Armin@gmx.de>
 <20230815165558.4176-2-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815165558.4176-2-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 06:55:58PM +0200, Armin Wolf wrote:
> After some testing on a Fujitsu Esprimo P720, it turned out that
> the limit registers are indeed writable and affect the fan control
> algorithm. This is supported by the datasheet, which says that the
> fan control functions are based on the limit and parameter registers.
> Since accessing those registers is very inefficient, the regmap cache
> is used to cache registers values.
> 
> Tested on a Fujitsu Esprimo P720.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

To ease review this and the previous patch needs to be split into
multiple patches. For the first patch, there are two logical changes:
to introduce bit macros and to add the read-only check. I was
close to letting this go, but with this patch it is just too much.
Lets follow the "one logical change per patch" rule, please.

Changing the code to use regmap and to stop using local caches is one
logical change. Making limit registers writeable is another. I didn't
even try to determine if there are more.

Thanks,
Guenter

> ---
>  drivers/hwmon/Kconfig          |   1 +
>  drivers/hwmon/sch5627.c        | 246 ++++++++++++++++++++++++---------
>  drivers/hwmon/sch56xx-common.c | 107 ++++++++++++++
>  drivers/hwmon/sch56xx-common.h |   6 +
>  4 files changed, 291 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index ec38c8892158..1c672195b5b3 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1909,6 +1909,7 @@ config SENSORS_SMSC47B397
> 
>  config SENSORS_SCH56XX_COMMON
>  	tristate
> +	select REGMAP
> 
>  config SENSORS_SCH5627
>  	tristate "SMSC SCH5627"
> diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
> index bf408e35e2c3..1891d4d75aa9 100644
> --- a/drivers/hwmon/sch5627.c
> +++ b/drivers/hwmon/sch5627.c
> @@ -7,9 +7,12 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 
>  #include <linux/bits.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/pm.h>
>  #include <linux/init.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/jiffies.h>
>  #include <linux/platform_device.h>
> @@ -72,11 +75,9 @@ static const char * const SCH5627_IN_LABELS[SCH5627_NO_IN] = {
>  	"VCC", "VTT", "VBAT", "VTR", "V_IN" };
> 
>  struct sch5627_data {
> +	struct regmap *regmap;
>  	unsigned short addr;
>  	u8 control;
> -	u8 temp_max[SCH5627_NO_TEMPS];
> -	u8 temp_crit[SCH5627_NO_TEMPS];
> -	u16 fan_min[SCH5627_NO_FANS];
> 
>  	struct mutex update_lock;
>  	unsigned long last_battery;	/* In jiffies */
> @@ -91,6 +92,36 @@ struct sch5627_data {
>  	u16 in[SCH5627_NO_IN];
>  };
> 
> +static const struct regmap_range sch5627_tunables_ranges[] = {
> +	regmap_reg_range(0x57, 0x57),
> +	regmap_reg_range(0x59, 0x59),
> +	regmap_reg_range(0x5B, 0x5B),
> +	regmap_reg_range(0x5D, 0x5D),
> +	regmap_reg_range(0x5F, 0x5F),
> +	regmap_reg_range(0x61, 0x69),
> +	regmap_reg_range(0x96, 0x9B),
> +	regmap_reg_range(0xA0, 0xA3),
> +	regmap_reg_range(0x184, 0x184),
> +	regmap_reg_range(0x186, 0x186),
> +	regmap_reg_range(0x1A8, 0x1A9),
> +};
> +
> +static const struct regmap_access_table sch5627_tunables_table = {
> +	.yes_ranges = sch5627_tunables_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(sch5627_tunables_ranges),
> +};
> +
> +static const struct regmap_config sch5627_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +	.wr_table = &sch5627_tunables_table,
> +	.rd_table = &sch5627_tunables_table,
> +	.cache_type = REGCACHE_RBTREE,
> +	.use_single_read = true,
> +	.use_single_write = true,
> +	.can_sleep = true,
> +};
> +
>  static int sch5627_update_temp(struct sch5627_data *data)
>  {
>  	int ret = 0;
> @@ -177,38 +208,6 @@ static int sch5627_update_in(struct sch5627_data *data)
>  	return ret;
>  }
> 
> -static int sch5627_read_limits(struct sch5627_data *data)
> -{
> -	int i, val;
> -
> -	for (i = 0; i < SCH5627_NO_TEMPS; i++) {
> -		/*
> -		 * Note what SMSC calls ABS, is what lm_sensors calls max
> -		 * (aka high), and HIGH is what lm_sensors calls crit.
> -		 */
> -		val = sch56xx_read_virtual_reg(data->addr,
> -					       SCH5627_REG_TEMP_ABS[i]);
> -		if (val < 0)
> -			return val;
> -		data->temp_max[i] = val;
> -
> -		val = sch56xx_read_virtual_reg(data->addr,
> -					       SCH5627_REG_TEMP_HIGH[i]);
> -		if (val < 0)
> -			return val;
> -		data->temp_crit[i] = val;
> -	}
> -	for (i = 0; i < SCH5627_NO_FANS; i++) {
> -		val = sch56xx_read_virtual_reg16(data->addr,
> -						 SCH5627_REG_FAN_MIN[i]);
> -		if (val < 0)
> -			return val;
> -		data->fan_min[i] = val;
> -	}
> -
> -	return 0;
> -}
> -
>  static int reg_to_temp(u16 reg)
>  {
>  	return (reg * 625) / 10 - 64000;
> @@ -229,6 +228,25 @@ static int reg_to_rpm(u16 reg)
>  	return 5400540 / reg;
>  }
> 
> +static u8 sch5627_temp_limit_to_reg(long value)
> +{
> +	long limit = (value / 1000) + 64;
> +
> +	return clamp_val(limit, 0, U8_MAX);
> +}
> +
> +static u16 sch5627_rpm_to_reg(long value)
> +{
> +	long pulses;
> +
> +	if (value <= 0)
> +		return U16_MAX - 1;
> +
> +	pulses = 5400540 / value;
> +
> +	return clamp_val(pulses, 1, U16_MAX - 1);
> +}
> +
>  static umode_t sch5627_is_visible(const void *drvdata, enum hwmon_sensor_types type, u32 attr,
>  				  int channel)
>  {
> @@ -240,8 +258,35 @@ static umode_t sch5627_is_visible(const void *drvdata, enum hwmon_sensor_types t
>  	if (data->control & SCH5627_CTRL_LOCK)
>  		return 0444;
> 
> -	if (type == hwmon_pwm && attr == hwmon_pwm_auto_channels_temp)
> -		return 0644;
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_max:
> +		case hwmon_temp_crit:
> +			return 0644;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_min:
> +			return 0644;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_auto_channels_temp:
> +			return 0644;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> 
>  	return 0444;
>  }
> @@ -250,24 +295,37 @@ static int sch5627_read(struct device *dev, enum hwmon_sensor_types type, u32 at
>  			long *val)
>  {
>  	struct sch5627_data *data = dev_get_drvdata(dev);
> -	int ret;
> +	int ret, value;
> 
>  	switch (type) {
>  	case hwmon_temp:
> -		ret = sch5627_update_temp(data);
> -		if (ret < 0)
> -			return ret;
>  		switch (attr) {
>  		case hwmon_temp_input:
> +			ret = sch5627_update_temp(data);
> +			if (ret < 0)
> +				return ret;
> +
>  			*val = reg_to_temp(data->temp[channel]);
>  			return 0;
>  		case hwmon_temp_max:
> -			*val = reg_to_temp_limit(data->temp_max[channel]);
> +			ret = regmap_read(data->regmap, SCH5627_REG_TEMP_ABS[channel], &value);
> +			if (ret < 0)
> +				return ret;
> +
> +			*val = reg_to_temp_limit((u8)value);
>  			return 0;
>  		case hwmon_temp_crit:
> -			*val = reg_to_temp_limit(data->temp_crit[channel]);
> +			ret = regmap_read(data->regmap, SCH5627_REG_TEMP_HIGH[channel], &value);
> +			if (ret < 0)
> +				return ret;
> +
> +			*val = reg_to_temp_limit((u8)value);
>  			return 0;
>  		case hwmon_temp_fault:
> +			ret = sch5627_update_temp(data);
> +			if (ret < 0)
> +				return ret;
> +
>  			*val = (data->temp[channel] == 0);
>  			return 0;
>  		default:
> @@ -275,23 +333,35 @@ static int sch5627_read(struct device *dev, enum hwmon_sensor_types type, u32 at
>  		}
>  		break;
>  	case hwmon_fan:
> -		ret = sch5627_update_fan(data);
> -		if (ret < 0)
> -			return ret;
>  		switch (attr) {
>  		case hwmon_fan_input:
> +			ret = sch5627_update_fan(data);
> +			if (ret < 0)
> +				return ret;
> +
>  			ret = reg_to_rpm(data->fan[channel]);
>  			if (ret < 0)
>  				return ret;
> +
>  			*val = ret;
>  			return 0;
>  		case hwmon_fan_min:
> -			ret = reg_to_rpm(data->fan_min[channel]);
> +			ret = sch56xx_regmap_read16(data->regmap, SCH5627_REG_FAN_MIN[channel],
> +						    &value);
>  			if (ret < 0)
>  				return ret;
> +
> +			ret = reg_to_rpm((u16)value);
> +			if (ret < 0)
> +				return ret;
> +
>  			*val = ret;
>  			return 0;
>  		case hwmon_fan_fault:
> +			ret = sch5627_update_fan(data);
> +			if (ret < 0)
> +				return ret;
> +
>  			*val = (data->fan[channel] == 0xffff);
>  			return 0;
>  		default:
> @@ -301,15 +371,11 @@ static int sch5627_read(struct device *dev, enum hwmon_sensor_types type, u32 at
>  	case hwmon_pwm:
>  		switch (attr) {
>  		case hwmon_pwm_auto_channels_temp:
> -			mutex_lock(&data->update_lock);
> -			ret = sch56xx_read_virtual_reg(data->addr, SCH5627_REG_PWM_MAP[channel]);
> -			mutex_unlock(&data->update_lock);
> -
> +			ret = regmap_read(data->regmap, SCH5627_REG_PWM_MAP[channel], &value);
>  			if (ret < 0)
>  				return ret;
> 
> -			*val = ret;
> -
> +			*val = value;
>  			return 0;
>  		default:
>  			break;
> @@ -359,9 +425,33 @@ static int sch5627_write(struct device *dev, enum hwmon_sensor_types type, u32 a
>  			 long val)
>  {
>  	struct sch5627_data *data = dev_get_drvdata(dev);
> -	int ret;
> +	u16 fan;
> +	u8 temp;
> 
>  	switch (type) {
> +	case hwmon_temp:
> +		temp = sch5627_temp_limit_to_reg(val);
> +
> +		switch (attr) {
> +		case hwmon_temp_max:
> +			return regmap_write(data->regmap, SCH5627_REG_TEMP_ABS[channel], temp);
> +		case hwmon_temp_crit:
> +			return regmap_write(data->regmap, SCH5627_REG_TEMP_HIGH[channel], temp);
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_min:
> +			fan = sch5627_rpm_to_reg(val);
> +
> +			return sch56xx_regmap_write16(data->regmap, SCH5627_REG_FAN_MIN[channel],
> +						      fan);
> +		default:
> +			break;
> +		}
> +		break;
>  	case hwmon_pwm:
>  		switch (attr) {
>  		case hwmon_pwm_auto_channels_temp:
> @@ -369,12 +459,7 @@ static int sch5627_write(struct device *dev, enum hwmon_sensor_types type, u32 a
>  			if (val > U8_MAX || val < 0)
>  				return -EINVAL;
> 
> -			mutex_lock(&data->update_lock);
> -			ret = sch56xx_write_virtual_reg(data->addr, SCH5627_REG_PWM_MAP[channel],
> -							val);
> -			mutex_unlock(&data->update_lock);
> -
> -			return ret;
> +			return regmap_write(data->regmap, SCH5627_REG_PWM_MAP[channel], val);
>  		default:
>  			break;
>  		}
> @@ -436,7 +521,7 @@ static int sch5627_probe(struct platform_device *pdev)
>  {
>  	struct sch5627_data *data;
>  	struct device *hwmon_dev;
> -	int err, build_code, build_id, hwmon_rev, val;
> +	int build_code, build_id, hwmon_rev, val;
> 
>  	data = devm_kzalloc(&pdev->dev, sizeof(struct sch5627_data),
>  			    GFP_KERNEL);
> @@ -501,19 +586,17 @@ static int sch5627_probe(struct platform_device *pdev)
>  		pr_err("hardware monitoring not enabled\n");
>  		return -ENODEV;
>  	}
> +
> +	data->regmap = devm_regmap_init_sch56xx(&pdev->dev, &data->update_lock, data->addr,
> +						&sch5627_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return PTR_ERR(data->regmap);
> +
>  	/* Trigger a Vbat voltage measurement, so that we get a valid reading
>  	   the first time we read Vbat */
>  	sch56xx_write_virtual_reg(data->addr, SCH5627_REG_CTRL, data->control | SCH5627_CTRL_VBAT);
>  	data->last_battery = jiffies;
> 
> -	/*
> -	 * Read limits, we do this only once as reading a register on
> -	 * the sch5627 is quite expensive (and they don't change).
> -	 */
> -	err = sch5627_read_limits(data);
> -	if (err)
> -		return err;
> -
>  	pr_info("found %s chip at %#hx\n", DEVNAME, data->addr);
>  	pr_info("firmware build: code 0x%02X, id 0x%04X, hwmon: rev 0x%02X\n",
>  		build_code, build_id, hwmon_rev);
> @@ -531,6 +614,30 @@ static int sch5627_probe(struct platform_device *pdev)
>  	return 0;
>  }
> 
> +static int sch5627_suspend(struct device *dev)
> +{
> +	struct sch5627_data *data = dev_get_drvdata(dev);
> +
> +	regcache_cache_only(data->regmap, true);
> +	regcache_mark_dirty(data->regmap);
> +
> +	return 0;
> +}
> +
> +static int sch5627_resume(struct device *dev)
> +{
> +	struct sch5627_data *data = dev_get_drvdata(dev);
> +
> +	regcache_cache_only(data->regmap, false);
> +	/* We must not access the virtual registers when the lock bit is set */
> +	if (data->control & SCH5627_CTRL_LOCK)
> +		return regcache_drop_region(data->regmap, 0, U16_MAX);
> +
> +	return regcache_sync(data->regmap);
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(sch5627_dev_pm_ops, sch5627_suspend, sch5627_resume);
> +
>  static const struct platform_device_id sch5627_device_id[] = {
>  	{
>  		.name = "sch5627",
> @@ -542,6 +649,7 @@ MODULE_DEVICE_TABLE(platform, sch5627_device_id);
>  static struct platform_driver sch5627_driver = {
>  	.driver = {
>  		.name	= DRVNAME,
> +		.pm	= pm_sleep_ptr(&sch5627_dev_pm_ops),
>  	},
>  	.probe		= sch5627_probe,
>  	.id_table	= sch5627_device_id,
> diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
> index de3a0886c2f7..36b38626dcdf 100644
> --- a/drivers/hwmon/sch56xx-common.c
> +++ b/drivers/hwmon/sch56xx-common.c
> @@ -10,6 +10,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/dmi.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> @@ -64,6 +65,11 @@ struct sch56xx_watchdog_data {
>  	u8 watchdog_output_enable;
>  };
> 
> +struct sch56xx_bus_context {
> +	struct mutex *lock;	/* Used to serialize access to the mailbox registers */
> +	u16 addr;
> +};
> +
>  static struct platform_device *sch56xx_pdev;
> 
>  /* Super I/O functions */
> @@ -243,6 +249,107 @@ int sch56xx_read_virtual_reg12(u16 addr, u16 msb_reg, u16 lsn_reg,
>  }
>  EXPORT_SYMBOL(sch56xx_read_virtual_reg12);
> 
> +/*
> + * Regmap support
> + */
> +
> +int sch56xx_regmap_read16(struct regmap *map, unsigned int reg, unsigned int *val)
> +{
> +	int lsb, msb, ret;
> +
> +	/* See sch56xx_read_virtual_reg16() */
> +	ret = regmap_read(map, reg, &lsb);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_read(map, reg + 1, &msb);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = lsb | (msb << 8);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(sch56xx_regmap_read16);
> +
> +int sch56xx_regmap_write16(struct regmap *map, unsigned int reg, unsigned int val)
> +{
> +	int ret;
> +
> +	ret = regmap_write(map, reg, val & 0xff);
> +	if (ret < 0)
> +		return ret;
> +
> +	return regmap_write(map, reg + 1, (val >> 8) & 0xff);
> +}
> +EXPORT_SYMBOL(sch56xx_regmap_write16);
> +
> +static int sch56xx_reg_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct sch56xx_bus_context *bus = context;
> +	int ret;
> +
> +	mutex_lock(bus->lock);
> +	ret = sch56xx_write_virtual_reg(bus->addr, (u16)reg, (u8)val);
> +	mutex_unlock(bus->lock);
> +
> +	return ret;
> +}
> +
> +static int sch56xx_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct sch56xx_bus_context *bus = context;
> +	int ret;
> +
> +	mutex_lock(bus->lock);
> +	ret = sch56xx_read_virtual_reg(bus->addr, (u16)reg);
> +	mutex_unlock(bus->lock);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = ret;
> +
> +	return 0;
> +}
> +
> +static void sch56xx_free_context(void *context)
> +{
> +	kfree(context);
> +}
> +
> +static const struct regmap_bus sch56xx_bus = {
> +	.reg_write = sch56xx_reg_write,
> +	.reg_read = sch56xx_reg_read,
> +	.free_context = sch56xx_free_context,
> +	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
> +	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
> +};
> +
> +struct regmap *devm_regmap_init_sch56xx(struct device *dev, struct mutex *lock, u16 addr,
> +					const struct regmap_config *config)
> +{
> +	struct sch56xx_bus_context *context;
> +	struct regmap *map;
> +
> +	if (config->reg_bits != 16 && config->val_bits != 8)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	context = kzalloc(sizeof(*context), GFP_KERNEL);
> +	if (!context)
> +		return ERR_PTR(-ENOMEM);
> +
> +	context->lock = lock;
> +	context->addr = addr;
> +
> +	map = devm_regmap_init(dev, &sch56xx_bus, context, config);
> +	if (IS_ERR(map))
> +		kfree(context);
> +
> +	return map;
> +}
> +EXPORT_SYMBOL(devm_regmap_init_sch56xx);
> +
>  /*
>   * Watchdog routines
>   */
> diff --git a/drivers/hwmon/sch56xx-common.h b/drivers/hwmon/sch56xx-common.h
> index e907d9da0dd5..7479a549a026 100644
> --- a/drivers/hwmon/sch56xx-common.h
> +++ b/drivers/hwmon/sch56xx-common.h
> @@ -5,9 +5,15 @@
>   ***************************************************************************/
> 
>  #include <linux/mutex.h>
> +#include <linux/regmap.h>
> 
>  struct sch56xx_watchdog_data;
> 
> +struct regmap *devm_regmap_init_sch56xx(struct device *dev, struct mutex *lock, u16 addr,
> +					const struct regmap_config *config);
> +int sch56xx_regmap_read16(struct regmap *map, unsigned int reg, unsigned int *val);
> +int sch56xx_regmap_write16(struct regmap *map, unsigned int reg, unsigned int val);
> +
>  int sch56xx_read_virtual_reg(u16 addr, u16 reg);
>  int sch56xx_write_virtual_reg(u16 addr, u16 reg, u8 val);
>  int sch56xx_read_virtual_reg16(u16 addr, u16 reg);
> --
> 2.39.2
> 
