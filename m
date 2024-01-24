Return-Path: <linux-kernel+bounces-37531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025D383B151
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8001F213CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85D4131E26;
	Wed, 24 Jan 2024 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vv9IvmHa"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C0A131745;
	Wed, 24 Jan 2024 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121489; cv=none; b=fGPzRczfm5jIFT69ysQ/v8/NcuNQ903NZEd/AW7jUTNrJsdriWkiYWb2Xegh/DJO4y4FmAr3O0PnTBfD8rELufbRIFn4jYJECx9bDk0VyEVIZP+Os6FA0zMocKxWGL3vH/SEGCp8wI1w9PSa4X+cMv/Fx9evnvXMdvrkt2PxSEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121489; c=relaxed/simple;
	bh=ca+fCbcTQWgE84vqH1p2Q7HrTg+ZrFTOv39C1QxwOGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwPKphQieVnmB/fcNCwLENGKobBZn4/YzuYRfHhHTrOCxDMRwgErXRTC6m+3bkLXcP80CQVs7f4OVhW8ZuVT7J7brj7rEN5BuBKE4fkoswvK1WS3Vns4pCetUzgKy1wOhAdbcOhnE4up3OqT9Ic8iieomiBfEfHqfMBrmC559LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vv9IvmHa; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40ec715f1efso8451085e9.2;
        Wed, 24 Jan 2024 10:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706121486; x=1706726286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GbB1X//c8XrpsgTvSZPcfYd6FspCt9gWrgLKU+MXeTY=;
        b=Vv9IvmHaCX7v7I7zjjruc5FFGttbiG5gV1UNJ6YRGNe0BfIAj0+T2OrtuCILWJxEh8
         Bv57nkF4e4+H4qy0yQYM3yPqhWy838RdD8RBhUyApYc1az4vU4xKve238ZlXGjRIDs6R
         TlaE71OoxAwwrte5qbeRQmSsbHQC63/Y3rxSnkaI6Fr77ptCDdaft4HD1g4lhdWDMTsN
         zzpY3BNu7+sr0CafZIGb1MU18WsTdqYJWiLr6KRUA30VOvv6XCGm4AJ7BCqNISIFlNZh
         UOYCtCRpW4O2QBjDpOuU30Ntq4Jn2zsebnhFc/Mt28RO5GBX6dL0UYuuwpBao2noOnCP
         cHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706121486; x=1706726286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbB1X//c8XrpsgTvSZPcfYd6FspCt9gWrgLKU+MXeTY=;
        b=xU/4zW1EbiYzV4Fy6GuzJHM4qdFhVSfjK6RkvjHwXOUFUB8VR98ef0qes3hVZBO8xN
         IvGDF35utm5wRqGgvNmplaeCw5iBrAeQiUpsfI0u2vseji7yo897LWHTUkUCWNoK8nCd
         ms1Bo3gYcCJK997s3FUL9ECohRwn9VRJ638CnyXPT92ZWLRDSnL2oxwM8hCh5ztlfr6Z
         QDN6fOowEf8X5SPMpuwN3aJ5dsdgCwkaBqb9tgDifchzG1gd34i68xJvPQnzMc1P1PSL
         sYsxu+daIF+ejWr+Ahd9RJ7J3wnGLt4Ox/git73QW59jIys6LGmJ1n7ZD+BRFRtCiwKQ
         MwbA==
X-Gm-Message-State: AOJu0YxuMM/znN2VMxlpQXhfH/iNPrLbDpClftTV1RaksoGpWWMaJedU
	N9mV47E36N8sKK1aWur5h/+RumscekaCTk6ZSKCtyuUYyg9n6NzE
X-Google-Smtp-Source: AGHT+IFsaI8u7E8opq9Fs6Sb+qWWOeFxkbf1lGpvnZlWwCTfwu5JjWi5I1kIzQyshMsDrZDsuE8IPg==
X-Received: by 2002:a05:600c:1385:b0:40e:88be:ec58 with SMTP id u5-20020a05600c138500b0040e88beec58mr1708927wmf.31.1706121485407;
        Wed, 24 Jan 2024 10:38:05 -0800 (PST)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c468400b0040d8d11bf63sm455727wmo.41.2024.01.24.10.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 10:38:04 -0800 (PST)
Message-ID: <218345e5-6634-40b6-a509-41bd4fc587c8@gmail.com>
Date: Wed, 24 Jan 2024 19:38:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] hwmon: add fan speed monitoring driver for Surface
 devices
To: Ivor Wanders <ivor@iwanders.net>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240113183306.9566-1-ivor@iwanders.net>
 <20240113183306.9566-3-ivor@iwanders.net>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20240113183306.9566-3-ivor@iwanders.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/13/24 19:33, Ivor Wanders wrote:
> Adds a driver that provides read only access to the fan speed for Microsoft
> Surface Pro devices. The fan speed is always regulated by the EC and cannot
> be influenced directly.
> 
> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
> Link: https://github.com/linux-surface/kernel/pull/144

The Surface related things look good to me. For those:

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
> Changes in v3:
>    - Removed type and attr checks in read and is_visible.
>    - Removed assigning sdev to ssam_device drvdata.
>    - Propagate return from __ssam_fan_rpm_get.
>    - Renamed hwmon chip name from 'fan' to 'surface_fan'.
>    - Removed unnecessary platform_device header.
> Changes in v2:
>    - Removed all sysfs attributes except fan1_input. Simplified code
>      and updated documentation accordingly.
> ---
>   Documentation/hwmon/index.rst       |  1 +
>   Documentation/hwmon/surface_fan.rst | 25 ++++++++
>   MAINTAINERS                         |  8 +++
>   drivers/hwmon/Kconfig               | 13 ++++
>   drivers/hwmon/Makefile              |  1 +
>   drivers/hwmon/surface_fan.c         | 93 +++++++++++++++++++++++++++++
>   6 files changed, 141 insertions(+)
>   create mode 100644 Documentation/hwmon/surface_fan.rst
>   create mode 100644 drivers/hwmon/surface_fan.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 042e1cf95..4dfb3b9bd 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -202,6 +202,7 @@ Hardware Monitoring Kernel Drivers
>      smsc47m1
>      sparx5-temp
>      stpddc60
> +   surface_fan
>      sy7636a-hwmon
>      tc654
>      tc74
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
> index 439cf523b..8e7870af3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14078,6 +14078,14 @@ F:	Documentation/driver-api/surface_aggregator/clients/dtx.rst
>   F:	drivers/platform/surface/surface_dtx.c
>   F:	include/uapi/linux/surface_aggregator/dtx.h
>   
> +MICROSOFT SURFACE SENSOR FAN DRIVER
> +M:	Maximilian Luz <luzmaximilian@gmail.com>
> +M:	Ivor Wanders <ivor@iwanders.net>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/surface_fan.rst
> +F:	drivers/hwmon/surface_fan.c
> +
>   MICROSOFT SURFACE GPE LID SUPPORT DRIVER
>   M:	Maximilian Luz <luzmaximilian@gmail.com>
>   L:	platform-driver-x86@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 307477b8a..4b4d999af 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1965,6 +1965,19 @@ config SENSORS_SMM665
>   	  This driver can also be built as a module. If so, the module will
>   	  be called smm665.
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
>   config SENSORS_ADC128D818
>   	tristate "Texas Instruments ADC128D818"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 3f4b0fda0..5ae214c06 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -198,6 +198,7 @@ obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
>   obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
>   obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
>   obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
> +obj-$(CONFIG_SENSORS_SURFACE_FAN)+= surface_fan.o
>   obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
>   obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
>   obj-$(CONFIG_SENSORS_TC74)	+= tc74.o
> diff --git a/drivers/hwmon/surface_fan.c b/drivers/hwmon/surface_fan.c
> new file mode 100644
> index 000000000..7c2e3ae3e
> --- /dev/null
> +++ b/drivers/hwmon/surface_fan.c
> @@ -0,0 +1,93 @@
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
> +	return ret;
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
> +	if (IS_ERR(hdev))
> +		return PTR_ERR(hdev);
> +
> +	return 0;
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

