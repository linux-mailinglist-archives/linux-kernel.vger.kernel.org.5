Return-Path: <linux-kernel+bounces-13510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E2582077E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 17:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD3AFB21AD3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F48C153;
	Sat, 30 Dec 2023 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrVT7byR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BA3C2C5;
	Sat, 30 Dec 2023 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5537114380bso6120977a12.3;
        Sat, 30 Dec 2023 08:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703953929; x=1704558729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZB0c1TeByaHjk+7yG8Kc7dtPWL4o/WvzFcOuBAVwGI=;
        b=XrVT7byRkAeSaKy13LOYHhT56epZIBWi0Dgehc2nT8SYnJk/8PD6hcZQX1VktOcC6N
         2EL4MZvq3iWhOQkcNp1waDqySirDXY1G4JSwQscAWWZieMGlqQELZOfb87gzNbdPfkYi
         xXeDTwNBgTR3yDxTcaBPD1TMIapqxHm9XWifXO+QL1iqR+kXennrlNBvkJZM7xK/Vjcb
         54nv+CJN2h5K9P4HhwT8gdxN89+KcEa25TaozBVwEiVEFtuZYlPmwCp29+w8cbB7J1zR
         Z/ViESnHf25wdIKf+v0RTRioH71MxjAoOhd1aMeGetsquKItmd5kd+jT/v2VRvtb+d5F
         6+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703953929; x=1704558729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZB0c1TeByaHjk+7yG8Kc7dtPWL4o/WvzFcOuBAVwGI=;
        b=ZQkka1fhJgwezxDxBRFKQKZ5FYAMH5ds3NLsXBOYqTArmkjhI5MXuXGexbj2QjeltC
         znQww8RvLIV8NSgQyT/BOqFf0LnEtndqX2KVXeDkk3RyK0qqPczZFJGutoFLUhshWMyC
         5y8+xNKSs3rXIkFtUqu622kfUh7e7yWvMJnSQe6rVNO9UzOdfCdsf+QGHS91nweIqHXU
         fsu1sKhZ+lo1ToNknjHLKmTlZEEL0mL9H4lYjnfOg472axyKc166kiM54xqoE7WToj6T
         Azn4DWxmJDGJ7w3pNQHBJ/+W5/3UMemFMAkEMBnLN07UYWaTLf4ovc9/LF7ymUDknqWr
         NbLg==
X-Gm-Message-State: AOJu0YzYERwyJ8/9tuX6tWckLzEBlFOhxFYAhekZnLmDwQ4NWZ0TGr1C
	hery0YvP0ssVT+WILN/tmxgDkwlWtTY=
X-Google-Smtp-Source: AGHT+IEkrWf8/u0yuKKsq51NUIrXaVARvOeWx2lti6Y3HCUj9rAcEb1sJKJh1XxDyx1PvzgkK7z/nA==
X-Received: by 2002:a50:c11a:0:b0:555:6bef:7c3d with SMTP id l26-20020a50c11a000000b005556bef7c3dmr2043720edf.21.1703953929367;
        Sat, 30 Dec 2023 08:32:09 -0800 (PST)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id g6-20020a056402114600b005561ad0368fsm213251edw.12.2023.12.30.08.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 08:32:08 -0800 (PST)
Message-ID: <f564b1b4-d8d1-4809-9cc0-b01aa53570a0@gmail.com>
Date: Sat, 30 Dec 2023 17:32:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hwmon: add fan speed monitoring driver for Surface
 devices
To: Ivor Wanders <ivor@iwanders.net>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20231228003444.5580-1-ivor@iwanders.net>
 <20231228003444.5580-2-ivor@iwanders.net>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20231228003444.5580-2-ivor@iwanders.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/28/23 01:34, Ivor Wanders wrote:
> Adds a driver that provides read only access to the fan speed for Microsoft
> Surface Pro devices. The fan speed is always regulated by the EC and cannot
> be influenced directly.
> 
> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
> Link: https://github.com/linux-surface/kernel/pull/144
> ---
> Changes in v2:
>    - Removed all sysfs attributes except fan1_input. Simplified code
>      and updated documentation accordingly.
> ---
>   Documentation/hwmon/index.rst       |   1 +
>   Documentation/hwmon/surface_fan.rst |  25 +++++++
>   MAINTAINERS                         |   8 +++
>   drivers/hwmon/Kconfig               |  13 ++++
>   drivers/hwmon/Makefile              |   1 +
>   drivers/hwmon/surface_fan.c         | 105 ++++++++++++++++++++++++++++
>   6 files changed, 153 insertions(+)
>   create mode 100644 Documentation/hwmon/surface_fan.rst
>   create mode 100644 drivers/hwmon/surface_fan.c
> 

[...]

> diff --git a/drivers/hwmon/surface_fan.c b/drivers/hwmon/surface_fan.c
> new file mode 100644
> index 000000000..0160a585c
> --- /dev/null
> +++ b/drivers/hwmon/surface_fan.c
> @@ -0,0 +1,105 @@
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
> +#include <linux/platform_device.h>

As far as I can see, linux/platform_device.h is not needed.

Regards,
Max

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
> +	if (type != hwmon_fan)
> +		return 0;
> +
> +	if (attr != hwmon_fan_input)
> +		return 0;
> +
> +	return 0444;
> +}
> +
> +static int surface_fan_hwmon_read(struct device *dev,
> +				  enum hwmon_sensor_types type, u32 attr,
> +				  int channel, long *val)
> +{
> +	struct ssam_device *sdev = dev_get_drvdata(dev);
> +	__le16 value;
> +
> +	if (type != hwmon_fan)
> +		return -EOPNOTSUPP;
> +
> +	if (attr != hwmon_fan_input)
> +		return -EOPNOTSUPP;
> +
> +	if (__ssam_fan_rpm_get(sdev, &value))
> +		return -EIO;
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
> +	hdev = devm_hwmon_device_register_with_info(&sdev->dev, "fan", sdev,
> +						    &surface_fan_chip_info,
> +						    NULL);
> +	if (IS_ERR(hdev))
> +		return PTR_ERR(hdev);
> +
> +	ssam_device_set_drvdata(sdev, sdev);
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

