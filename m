Return-Path: <linux-kernel+bounces-7662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB94B81AB62
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CEAF1F2107B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7E64E1BF;
	Wed, 20 Dec 2023 23:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAk3xv5i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55F84B5B5;
	Wed, 20 Dec 2023 23:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7b7d65d4eecso9180239f.0;
        Wed, 20 Dec 2023 15:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703116516; x=1703721316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tNoJUjS2qxiKE/v+m+/kf6Z1ppnJjq/UKAlEiUarNg=;
        b=IAk3xv5iiiXx33MxyhxtqqzbR1o0TC28Tk3mENjWMEUWKfE9Iu8rDcpa+FllBHwe5n
         ofzmyv2KvcavYL1ppnRrYFuwU9qCaNUBe5Q+4KR/JTVA1LL9SiAP1WPUAMrqu59O1fga
         K/Uv2L8axXD9Ky0M6ZlX8GAUKa9s1ag0UB4HLVqbDJdn3M/WhZtT5vJnjXfMC+PKhVaV
         y5HpIp6mp6k1nLUC1Lng5G7yqpFtTaQn1LnfrV1t9I0/pq6lWxsUakCcAiXmWktvwuuC
         LaAmzzyyTxNW+vnLHHqtNbQdU/JOt5ajeNq0Xsi/hqCM0SLW4vPfyCBeoi+vkzpIMb86
         nx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703116516; x=1703721316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tNoJUjS2qxiKE/v+m+/kf6Z1ppnJjq/UKAlEiUarNg=;
        b=G8tL6Cfq44J0RYw8Obp6yaP58rt4nWtuAlAqB/x8ip0DibDOruElxMgDMiDh6Nx4gk
         DToAvMo7Y3K0m4I4wiX2CsUAR0ATtKWWTHxfzFQ6pqjQVEhT1RcpjQ+l4YU5N/iMw32S
         CGzxWC1vojqiq3xY30d9EyWWLdIEhyX0zKDGSjUNcFhCIwt1A2SS1RK08LLw/P0SihBr
         Ph1UvTyrhUsBOV1/NH1z3cnrfaePBLgNYXuqI+/rRvOQWJ0HMgfEHm+7AzG/2wXLlFsw
         9gHRAux6MuNhJHVh9GhPCJnpVCXiZ0FqbOqZdxvTJll37EVob3B48mqxZFcQIrH/6pgA
         ZELA==
X-Gm-Message-State: AOJu0YxqmzhnewVrC2esbd/+wnzbD3Z0SPa7VsPdUzhiQEBpSQHO2IFR
	+BIdFHhWtT0qZEUyFEZET4Q=
X-Google-Smtp-Source: AGHT+IHS7mgQPeN0+o/BvAk9Yb3iVwWZMQDE2/qNOBo4zbc9gopCEoybZh4sSUyNsvuiJ5RZNphZhQ==
X-Received: by 2002:a92:ca4a:0:b0:35f:717e:84c7 with SMTP id q10-20020a92ca4a000000b0035f717e84c7mr20831929ilo.65.1703116515976;
        Wed, 20 Dec 2023 15:55:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 20-20020a170902e9d400b001d3c46900f7sm277658plk.304.2023.12.20.15.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:55:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 20 Dec 2023 15:55:14 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ivor Wanders <ivor@iwanders.net>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: add fan speed monitoring driver for Surface
 devices
Message-ID: <ab8a1ff3-6d01-4331-ba5d-d677d1ad80b5@roeck-us.net>
References: <20231220234415.5219-1-ivor@iwanders.net>
 <20231220234415.5219-2-ivor@iwanders.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220234415.5219-2-ivor@iwanders.net>

On Wed, Dec 20, 2023 at 06:44:14PM -0500, Ivor Wanders wrote:
> Adds a driver that provides read only access to the fan speed for Microsoft
> Surface Pro devices. The fan speed is always regulated by the EC and cannot
> be influenced directly.
> 
> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
> Link: https://github.com/linux-surface/kernel/pull/144
> ---
>  Documentation/hwmon/index.rst       |   1 +
>  Documentation/hwmon/surface_fan.rst |  27 ++++++
>  MAINTAINERS                         |   8 ++
>  drivers/hwmon/Kconfig               |  13 +++
>  drivers/hwmon/Makefile              |   1 +
>  drivers/hwmon/surface_fan.c         | 125 ++++++++++++++++++++++++++++
>  6 files changed, 175 insertions(+)
>  create mode 100644 Documentation/hwmon/surface_fan.rst
>  create mode 100644 drivers/hwmon/surface_fan.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 042e1cf95..4dfb3b9bd 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -202,6 +202,7 @@ Hardware Monitoring Kernel Drivers
>     smsc47m1
>     sparx5-temp
>     stpddc60
> +   surface_fan
>     sy7636a-hwmon
>     tc654
>     tc74
> diff --git a/Documentation/hwmon/surface_fan.rst b/Documentation/hwmon/surface_fan.rst
> new file mode 100644
> index 000000000..6e27a6653
> --- /dev/null
> +++ b/Documentation/hwmon/surface_fan.rst
> @@ -0,0 +1,27 @@
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
> +``fan1_max``            RO      Approximate maximum fan speed.
> +``fan1_min``            RO      Minimum fan speed used by the controller.
> +======================= ======= =========================================
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 439cf523b..8e7870af3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14078,6 +14078,14 @@ F:	Documentation/driver-api/surface_aggregator/clients/dtx.rst
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
> index 307477b8a..4b4d999af 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1965,6 +1965,19 @@ config SENSORS_SMM665
>  	  This driver can also be built as a module. If so, the module will
>  	  be called smm665.
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
> index 3f4b0fda0..5ae214c06 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -198,6 +198,7 @@ obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
>  obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
>  obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
>  obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
> +obj-$(CONFIG_SENSORS_SURFACE_FAN)+= surface_fan.o
>  obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
>  obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
>  obj-$(CONFIG_SENSORS_TC74)	+= tc74.o
> diff --git a/drivers/hwmon/surface_fan.c b/drivers/hwmon/surface_fan.c
> new file mode 100644
> index 000000000..7129b25ed
> --- /dev/null
> +++ b/drivers/hwmon/surface_fan.c
> @@ -0,0 +1,125 @@
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
> +#include <linux/surface_aggregator/device.h>
> +#include <linux/types.h>
> +
> +// The minimum speed for the fan when turned on by the controller. The onboard
> +// controller uses this as minimum value before turning the fan on or off.
> +#define SURFACE_FAN_MIN_SPEED 3000
> +// The maximum speed, determined by observation and rounding up to the nearest
> +// multiple of 500 to account for variation between individual fans.
> +#define SURFACE_FAN_MAX_SPEED 7500
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
> +	switch (attr) {
> +	case hwmon_fan_input:
> +	case hwmon_fan_label:
> +	case hwmon_fan_min:
> +	case hwmon_fan_max:
> +		return 0444;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int surface_fan_hwmon_read(struct device *dev,
> +				  enum hwmon_sensor_types type, u32 attr,
> +				  int channel, long *val)
> +{
> +	struct ssam_device *sdev = dev_get_drvdata(dev);
> +	__le16 value;
> +	int res;
> +
> +	if (type != hwmon_fan)
> +		return -EOPNOTSUPP;
> +
> +	switch (attr) {
> +	case hwmon_fan_input:
> +		res = __ssam_fan_rpm_get(sdev, &value);
> +		if (res)
> +			return -EIO;
> +		*val = le16_to_cpu(value);
> +		return 0;
> +	case hwmon_fan_min:
> +		*val = SURFACE_FAN_MIN_SPEED;
> +		return 0;
> +	case hwmon_fan_max:
> +		*val = SURFACE_FAN_MAX_SPEED;
> +		return 0;

No, sorry. Limit attributes are supposed to be used to program limits,
not to report constant values to userspace (and please refrain from
referring to other drivers doing the same. Two wrongs don't make it right).

Guenter

