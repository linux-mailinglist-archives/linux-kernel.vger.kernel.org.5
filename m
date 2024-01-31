Return-Path: <linux-kernel+bounces-46485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F98844065
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0106828463D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8797BB03;
	Wed, 31 Jan 2024 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZ8xGZHJ"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FAA7BAF0;
	Wed, 31 Jan 2024 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707319; cv=none; b=Ou9B/nmCuloFFE3mNTZb+uqacBQ2zM44XeVh0C6FuN7H/qQK0JmmwobcNtOfUdCmnQnVj49prTjsutQf576ZIPKZdWOyQFWLtuqgTJpDQLx9ijtYNkLrXUhCPOp6mw3eSQ2KSpRyQ2GOPKVAB1+4D2RDan9cwzxOifwO6DoemsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707319; c=relaxed/simple;
	bh=DytUjfJ5jVW2nE4UlpPhpkrdQVEUYqoNsNCYzBr7o9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oU8JqTkIavQc3GEMSSu9tFkepOD/IFlZFbRbuBqvptOPWk37vkch+ivi2McPEhL3pdZjn1Dwzxr2Cj8hRBoK7fGMGqZPceRR5bzSqi/qg9cFyTc6HESq25UHbMDygJjHoU61iyPqfFyVw0CZtT0qLJKDI7vZHNfgcKaRFaTfr8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZ8xGZHJ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d51ba18e1bso46379215ad.0;
        Wed, 31 Jan 2024 05:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706707317; x=1707312117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3QCV4w7mbnFtziKPFuv7p4ZpguVLvSczpAls5rG8nU=;
        b=KZ8xGZHJTx/DPynXqRNCptICRwYdv3ybqyx4svZ2k79ZXAZ2JKn41Ywebt9qzXeIg6
         yw09rNZST/GaiVdDc3Y/CB34IsVUw8OWpDB6KEAE7BJRJLrySoN0KQ5qsr8ttWxBgnGO
         LoMfwiBYqRtaHwRc6zi7s4v2QMLkvrP91eURHXiGpLO/cw4ycKnepKmjcasERcRZ5h6b
         YdbEsDzsODkAwy4tzxFDNYCfqoxSpGyj5/Yo6Bqam1PCwYnDs3pdCNC97yKzu5EMvVC+
         8XL8EWirPynzRYLi1GLGYvpVRZef+441LEyeQFCr8KNbYe0sSa0ipxtTvQfU5OCzXmhw
         ZHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707317; x=1707312117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3QCV4w7mbnFtziKPFuv7p4ZpguVLvSczpAls5rG8nU=;
        b=ZpEYSKioklgK33oucZZeqekOlz4tnrn+MC5uBW0BSuCPS8qtYA78a8nduZwtYGXPNY
         VbvFbhbltuOIn7NlkFKxZsZ3DNkuiqU3IC0eVINOBxhUmwXx+OlW14TQ63bIAYvZKEe+
         gqvFMD7E8VKFFdVbl6Mp9hb+0UY68mfRevPb8X8ccxljzvcTA94V0K2jsby+VzlDiyYk
         lzFNBpbu9F35rJToFEK0jO35RaUArxxxfSimII7lxwNRvG+QihWaUc6eud6FLuZhztE0
         ndYZu+KniKKLr7yC9DtjC9fdX98UeVFhmR0QflA/ts16ZWc5S1/non3HGQCZ2Zj+2D8E
         vNCA==
X-Gm-Message-State: AOJu0Yx2uX7XfMGdBEM0ThpUNuZY0DmddaXnCZ7PB9HU/UIJSuSukjTt
	nZrIZXlI1KDMWD5oBsMpmjsPRJsprnM9O4zNnpGey2YKKw5gbhJ2
X-Google-Smtp-Source: AGHT+IGk0XEq+z5BrreVbEFnmQtmIKOb5M482oqE5zWpil33IPIITakQmifK5o0VV07roUAtH/a7mA==
X-Received: by 2002:a17:902:6b46:b0:1d8:e079:ce16 with SMTP id g6-20020a1709026b4600b001d8e079ce16mr1644039plt.1.1706707316589;
        Wed, 31 Jan 2024 05:21:56 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902968400b001d70ad0fe79sm9050438plp.291.2024.01.31.05.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:21:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 31 Jan 2024 05:21:54 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ivor Wanders <ivor@iwanders.net>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 1/2] hwmon: add fan speed monitoring driver for
 Surface devices
Message-ID: <3fd2f349-90c6-4445-be2f-54b6cf07dfb8@roeck-us.net>
References: <20240131005856.10180-1-ivor@iwanders.net>
 <20240131005856.10180-2-ivor@iwanders.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131005856.10180-2-ivor@iwanders.net>

On Tue, Jan 30, 2024 at 07:58:55PM -0500, Ivor Wanders wrote:
> Adds a driver that provides read only access to the fan speed for Microsoft
> Surface Pro devices. The fan speed is always regulated by the EC and cannot
> be influenced directly.
> 
> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
> Link: https://github.com/linux-surface/kernel/pull/144
> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>

Applied.

Thanks,
Guenter

> ---
> Changes in v5:
>   - No changes in this patch.
> Changes in v4:
>   - Return 0 from surface_fan_hwmon_read instead of ret.
>   - Use PTR_ERR_OR_ZERO in probe instead of if statement.
> Changes in v3:
>   - Removed type and attr checks in read and is_visible.
>   - Removed assigning sdev to ssam_device drvdata.
>   - Propagate return from __ssam_fan_rpm_get.
>   - Renamed hwmon chip name from 'fan' to 'surface_fan'.
>   - Removed unnecessary platform_device header.
> Changes in v2:
>   - Removed all sysfs attributes except fan1_input. Simplified code
>     and updated documentation accordingly.
> ---
>  Documentation/hwmon/index.rst       |  1 +
>  Documentation/hwmon/surface_fan.rst | 25 ++++++++
>  MAINTAINERS                         |  8 +++
>  drivers/hwmon/Kconfig               | 13 +++++
>  drivers/hwmon/Makefile              |  1 +
>  drivers/hwmon/surface_fan.c         | 91 +++++++++++++++++++++++++++++
>  6 files changed, 139 insertions(+)
>  create mode 100644 Documentation/hwmon/surface_fan.rst
>  create mode 100644 drivers/hwmon/surface_fan.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index c7ed1f73a..58be92e94 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -208,6 +208,7 @@ Hardware Monitoring Kernel Drivers
>     smsc47m1
>     sparx5-temp
>     stpddc60
> +   surface_fan
>     sy7636a-hwmon
>     tc654
>     tc74
> diff --git a/Documentation/hwmon/surface_fan.rst b/Documentation/hwmon/surface_fan.rst
> new file mode 100644
> index 000000000..07942574c
> --- /dev/null
> +++ b/Documentation/hwmon/surface_fan.rst
> @@ -0,0 +1,25 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver surface_fan
> +=========================
> +
> +Supported Devices:
> +
> +  * Microsoft Surface Pro 9
> +
> +Author: Ivor Wanders <ivor@iwanders.net>
> +
> +Description
> +-----------
> +
> +This provides monitoring of the fan found in some Microsoft Surface Pro devices,
> +like the Surface Pro 9. The fan is always controlled by the onboard controller.
> +
> +Sysfs interface
> +---------------
> +
> +======================= ======= =========================================
> +Name                    Perm    Description
> +======================= ======= =========================================
> +``fan1_input``          RO      Current fan speed in RPM.
> +======================= ======= =========================================
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c4828ab15..2c5c4d7e5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14560,6 +14560,14 @@ F:	Documentation/driver-api/surface_aggregator/clients/dtx.rst
>  F:	drivers/platform/surface/surface_dtx.c
>  F:	include/uapi/linux/surface_aggregator/dtx.h
>  
> +MICROSOFT SURFACE SENSOR FAN DRIVER
> +M:	Maximilian Luz <luzmaximilian@gmail.com>
> +M:	Ivor Wanders <ivor@iwanders.net>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/surface_fan.rst
> +F:	drivers/hwmon/surface_fan.c
> +
>  MICROSOFT SURFACE GPE LID SUPPORT DRIVER
>  M:	Maximilian Luz <luzmaximilian@gmail.com>
>  L:	platform-driver-x86@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index a608264da..e762f6138 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1994,6 +1994,19 @@ config SENSORS_SFCTEMP
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called sfctemp.
>  
> +config SENSORS_SURFACE_FAN
> +	tristate "Surface Fan Driver"
> +	depends on SURFACE_AGGREGATOR
> +	help
> +	  Driver that provides monitoring of the fan on Surface Pro devices that
> +	  have a fan, like the Surface Pro 9.
> +
> +	  This makes the fan's current speed accessible through the hwmon
> +	  system. It does not provide control over the fan, the firmware is
> +	  responsible for that, this driver merely provides monitoring.
> +
> +	  Select M or Y here, if you want to be able to read the fan's speed.
> +
>  config SENSORS_ADC128D818
>  	tristate "Texas Instruments ADC128D818"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 47be39af5..30cc90f40 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -201,6 +201,7 @@ obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
>  obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
>  obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
>  obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
> +obj-$(CONFIG_SENSORS_SURFACE_FAN)+= surface_fan.o
>  obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
>  obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
>  obj-$(CONFIG_SENSORS_TC74)	+= tc74.o
> diff --git a/drivers/hwmon/surface_fan.c b/drivers/hwmon/surface_fan.c
> new file mode 100644
> index 000000000..31cd5da9e
> --- /dev/null
> +++ b/drivers/hwmon/surface_fan.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Surface Fan driver for Surface System Aggregator Module. It provides access
> + * to the fan's rpm through the hwmon system.
> + *
> + * Copyright (C) 2023 Ivor Wanders <ivor@iwanders.net>
> + */
> +
> +#include <linux/hwmon.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/surface_aggregator/device.h>
> +#include <linux/types.h>
> +
> +// SSAM
> +SSAM_DEFINE_SYNC_REQUEST_CL_R(__ssam_fan_rpm_get, __le16, {
> +	.target_category = SSAM_SSH_TC_FAN,
> +	.command_id      = 0x01,
> +});
> +
> +// hwmon
> +umode_t surface_fan_hwmon_is_visible(const void *drvdata,
> +				     enum hwmon_sensor_types type, u32 attr,
> +				     int channel)
> +{
> +	return 0444;
> +}
> +
> +static int surface_fan_hwmon_read(struct device *dev,
> +				  enum hwmon_sensor_types type, u32 attr,
> +				  int channel, long *val)
> +{
> +	struct ssam_device *sdev = dev_get_drvdata(dev);
> +	int ret;
> +	__le16 value;
> +
> +	ret = __ssam_fan_rpm_get(sdev, &value);
> +	if (ret)
> +		return ret;
> +
> +	*val = le16_to_cpu(value);
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_channel_info *const surface_fan_info[] = {
> +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_ops surface_fan_hwmon_ops = {
> +	.is_visible = surface_fan_hwmon_is_visible,
> +	.read = surface_fan_hwmon_read,
> +};
> +
> +static const struct hwmon_chip_info surface_fan_chip_info = {
> +	.ops = &surface_fan_hwmon_ops,
> +	.info = surface_fan_info,
> +};
> +
> +static int surface_fan_probe(struct ssam_device *sdev)
> +{
> +	struct device *hdev;
> +
> +	hdev = devm_hwmon_device_register_with_info(&sdev->dev,
> +						    "surface_fan", sdev,
> +						    &surface_fan_chip_info,
> +						    NULL);
> +
> +	return PTR_ERR_OR_ZERO(hdev);
> +}
> +
> +static const struct ssam_device_id ssam_fan_match[] = {
> +	{ SSAM_SDEV(FAN, SAM, 0x01, 0x01) },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(ssam, ssam_fan_match);
> +
> +static struct ssam_device_driver surface_fan = {
> +	.probe = surface_fan_probe,
> +	.match_table = ssam_fan_match,
> +	.driver = {
> +		.name = "surface_fan",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +};
> +module_ssam_device_driver(surface_fan);
> +
> +MODULE_AUTHOR("Ivor Wanders <ivor@iwanders.net>");
> +MODULE_DESCRIPTION("Fan Driver for Surface System Aggregator Module");
> +MODULE_LICENSE("GPL");

