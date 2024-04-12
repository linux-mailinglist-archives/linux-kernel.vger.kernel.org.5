Return-Path: <linux-kernel+bounces-143089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0198A33F9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19F71C223D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAF114B075;
	Fri, 12 Apr 2024 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cO9lBkgE"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5964023AD;
	Fri, 12 Apr 2024 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712940073; cv=none; b=GFmoqXYDh5Dn54qkEmyg9xvWH+Cl4rf6at3Mi643KNIHbdptZheOw9Kp7YbNZcm8CDqEUZPcZKBUP2sHMOEyNK/s2LscImWoDtNGYrszrn0p9m1bRkDIot1COQVphpXOJULMhshgAeQFheLVVpN3DEzunHlotzbOeAgdmjl1mbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712940073; c=relaxed/simple;
	bh=pLFoNQjtHbkMGu8De1wbfxO1PyBp9ir7o49ui+95iGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkKNAdJN4hteMeqGrAWstoaNkFKHZbkATyHR1uBNqvjZOUY7eEqjXuqIErDYUSR4xMmSHbIi6Uy844dA3n8pEfD0380TYqp2+tLiLOZ0g0fI0HyI/qIm27gSLKf4A65qKQeXWihbizQmGP/vU3/mfQY+kSbdVdLA4/ard91E1Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cO9lBkgE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e504f58230so9959575ad.2;
        Fri, 12 Apr 2024 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712940071; x=1713544871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tbJ9bT3qYWviHBIVbNUx49PHjvZIKWOAM8zx1yFvHA8=;
        b=cO9lBkgEdXc+uzsJ/wRVno4t2yi0oGTXl0Nm3eJzsyNjgl9GQ1qNbuGGEnpXUxQ0FZ
         H7kzL3FsrgeVUr9EHfj7DrhdRESUM1wbng25zB+54QHAx1GLn4koE2EBgXW4//S0qfOe
         iaO7F4v/29OBMGpW6aXF9JxtGbGm2H1wMKIHlJD3nBoKah3uG0m4KV0Ukejiob/8wPiv
         xgULm+RgJyt8TYsj3qCp8VYWD2PenmmDOH1w/SoivMQImMRXSi0QNBA4nUyN6BTDLzTK
         9vQcUcRH9l36VR3aOTfsn9u1dQQbqwWyoQU9cFwCooZmvGwMXPBS1SvQsWYF/JmPSWo3
         bUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712940071; x=1713544871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbJ9bT3qYWviHBIVbNUx49PHjvZIKWOAM8zx1yFvHA8=;
        b=Q2MU5TE8eMIxW7XMSUemVK6m+aCAWII+s3OmgiIEjuiwJXdqTZtHWHCfM6oRuuhchd
         2FqBnJyv9asFOZLEmaZyL+Z78a5wbmx1ROrTGN7zV3Ltio6sjmE7+iYYsGZzUCM+2PB/
         dXGZZap1gIduWhs62S0CtOTKvP3+/ugip+JGidZbunyhMfyzSoiR3lynojcccXSxA6+H
         Ap2qyUTpdwrpF81IjBjX0ykUWf7N8P26TeNnmduFA5qj/oj8elruEm7ieFXxqkNr8+2m
         nyz4OchwE5BDuLvEuXkD83eXT0zAes7t1bauzSpEkQ++ARdGBBiI5AlYDw+0cRRNsyuJ
         s8ag==
X-Forwarded-Encrypted: i=1; AJvYcCXt/wZ+wdEbG2Yk651wdjlkByTo5KZvu1Zmup38go5Kgozb8Hkw3MpySlkYIF+HmDKFW/hiQBNqah3Zyj+exW1PlmfnHCiljmiguO5Uhv8D6HuG2qxmfqBzvnR1VBo7MKZFie37T5KXLqd9SwfgaHyFckDN6XrUqp61LEL47XKDz49WsChhYrCDvW9C485b1L2JURsrmHZsu/iLa+5suB2PK3lhYtp0XgmjbA==
X-Gm-Message-State: AOJu0Yyc0jdIrlzC7GBaWRUqc67vf0yS/++UwYxUAmy80qU+4rurKJWK
	kmsps9OHpu9dJPPR6nTnHT/hC9GVNj9v12AhA61Nu/Bzo81mYusm
X-Google-Smtp-Source: AGHT+IG2Drr8ylkwMv1KU8B3TCbiu5wllzdkdiQhWz1TCo5GztnibBNiWP36n/AJxfoL9bpoXqfpvQ==
X-Received: by 2002:a17:903:1cd:b0:1e3:dd66:58e1 with SMTP id e13-20020a17090301cd00b001e3dd6658e1mr4011999plh.44.1712940070472;
        Fri, 12 Apr 2024 09:41:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b2-20020a170903228200b001e53bb92093sm3178790plh.228.2024.04.12.09.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 09:41:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 12 Apr 2024 09:41:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: mlj@danelec.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
	jdelvare@suse.com, linux@weissschuh.net,
	ilpo.jarvinen@linux.intel.com, linux-acpi@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ACPI: fan: Add hwmon support
Message-ID: <4a07f4d1-bbee-445c-a7cc-377506de850d@roeck-us.net>
References: <20240412160857.79858-1-W_Armin@gmx.de>
 <20240412160857.79858-2-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412160857.79858-2-W_Armin@gmx.de>

On Fri, Apr 12, 2024 at 06:08:57PM +0200, Armin Wolf wrote:
> Currently, the driver does only support a custom sysfs
> to allow userspace to read the fan speed.
> Add support for the standard hwmon interface so users
> can read the fan speed with standard tools like "sensors".
> 
> Compile-tested only.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Changes since v2:
> - add support for fanX_target and power attrs
> 
> Changes since v1:
> - fix undefined reference error
> - fix fan speed validation
> - coding style fixes
> - clarify that the changes are compile-tested only
> - add hwmon maintainers to cc list
> 
> The changes will be tested by Mikael Lund Jepsen from Danelec and
> should be merged only after those tests.
> ---
>  drivers/acpi/Makefile    |   1 +
>  drivers/acpi/fan.h       |   9 +++
>  drivers/acpi/fan_core.c  |   4 ++
>  drivers/acpi/fan_hwmon.c | 148 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 162 insertions(+)
>  create mode 100644 drivers/acpi/fan_hwmon.c
> 
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 39ea5cfa8326..61ca4afe83dc 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_ACPI_TINY_POWER_BUTTON)	+= tiny-power-button.o
>  obj-$(CONFIG_ACPI_FAN)		+= fan.o
>  fan-objs			:= fan_core.o
>  fan-objs			+= fan_attr.o
> +fan-$(CONFIG_HWMON)		+= fan_hwmon.o
> 
>  obj-$(CONFIG_ACPI_VIDEO)	+= video.o
>  obj-$(CONFIG_ACPI_TAD)		+= acpi_tad.o
> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> index f89d19c922dc..db25a3898af7 100644
> --- a/drivers/acpi/fan.h
> +++ b/drivers/acpi/fan.h
> @@ -10,6 +10,8 @@
>  #ifndef _ACPI_FAN_H_
>  #define _ACPI_FAN_H_
> 
> +#include <linux/kconfig.h>
> +
>  #define ACPI_FAN_DEVICE_IDS	\
>  	{"INT3404", }, /* Fan */ \
>  	{"INTC1044", }, /* Fan for Tiger Lake generation */ \
> @@ -57,4 +59,11 @@ struct acpi_fan {
>  int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst *fst);
>  int acpi_fan_create_attributes(struct acpi_device *device);
>  void acpi_fan_delete_attributes(struct acpi_device *device);
> +
> +#if IS_REACHABLE(CONFIG_HWMON)
> +int devm_acpi_fan_create_hwmon(struct acpi_device *device);
> +#else
> +static inline int devm_acpi_fan_create_hwmon(struct acpi_device *device) { return 0; };
> +#endif
> +
>  #endif
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index ff72e4ef8738..7cea4495f19b 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -336,6 +336,10 @@ static int acpi_fan_probe(struct platform_device *pdev)
>  		if (result)
>  			return result;
> 
> +		result = devm_acpi_fan_create_hwmon(device);
> +		if (result)
> +			return result;
> +
>  		result = acpi_fan_create_attributes(device);
>  		if (result)
>  			return result;
> diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
> new file mode 100644
> index 000000000000..57216ba872db
> --- /dev/null
> +++ b/drivers/acpi/fan_hwmon.c
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * fan_hwmon.c - hwmon interface for the ACPI Fan driver
> + *
> + * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/hwmon.h>
> +#include <linux/limits.h>
> +#include <linux/units.h>
> +
> +#include "fan.h"
> +
> +/* Returned when the ACPI fan does not support speed reporting */
> +#define FAN_SPEED_UNAVAILABLE	0xffffffff
> +#define FAN_POWER_UNAVAILABLE	0xffffffff
> +
> +static struct acpi_fan_fps *acpi_fan_get_current_fps(struct acpi_fan *fan, u64 control)
> +{
> +	int i;
> +
> +	for (i = 0; i < fan->fps_count; i++) {
> +		if (fan->fps[i].control == control)
> +			return &fan->fps[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +static umode_t acpi_fan_is_visible(const void *drvdata, enum hwmon_sensor_types type, u32 attr,
> +				   int channel)
> +{
> +	return 0444;
> +}
> +
> +static int acpi_fan_read(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
> +			 long *val)
> +{
> +	struct acpi_device *adev = dev_get_drvdata(dev);
> +	struct acpi_fan *fan = acpi_driver_data(adev);
> +	struct acpi_fan_fps *fps;
> +	struct acpi_fan_fst fst;
> +	int ret;
> +
> +	ret = acpi_fan_get_fst(adev, &fst);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			if (fst.speed == FAN_SPEED_UNAVAILABLE)
> +				return -ENODATA;
> +
> +			if (fst.speed > LONG_MAX)
> +				return -EOVERFLOW;
> +
> +			*val = fst.speed;
> +			return 0;
> +		case hwmon_fan_target:
> +			fps = acpi_fan_get_current_fps(fan, fst.control);
> +			if (!fps)
> +				return -ENODATA;
> +
> +			*val = fps->speed;
> +			return 0;
> +		case hwmon_fan_fault:
> +			*val = (fst.speed == FAN_SPEED_UNAVAILABLE);

Is it documented that this is indeed a fault (broken fan) ?

> +			return 0;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_power:
> +		fps = acpi_fan_get_current_fps(fan, fst.control);
> +		if (!fps)
> +			return -ENODATA;
> +
> +		switch (attr) {
> +		case hwmon_power_input:
> +			if (fps->power == FAN_POWER_UNAVAILABLE)
> +				return -ENODATA;
> +
> +			if (fps->power > LONG_MAX / MICROWATT_PER_MILLIWATT)
> +				return -EOVERFLOW;
> +
> +			*val = fps->power * MICROWATT_PER_MILLIWATT;
> +			return 0;
> +		case hwmon_power_fault:
> +			*val = (fps->power == FAN_POWER_UNAVAILABLE);

Is it documented that this is indeed a power supply failure ?
What if the value is simply not reported ? "UNAVAILABLE" is not
commonly associated with a "fault".

Guenter

> +			return 0;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct hwmon_ops acpi_fan_ops = {
> +	.is_visible = acpi_fan_is_visible,
> +	.read = acpi_fan_read,
> +};
> +
> +static const struct hwmon_channel_info * const acpi_fan_info[] = {
> +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_TARGET |  HWMON_F_FAULT),
> +	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_FAULT),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info acpi_fan_chip_info = {
> +	.ops = &acpi_fan_ops,
> +	.info = acpi_fan_info,
> +};
> +
> +static const struct hwmon_channel_info * const acpi_fan_fine_grain_info[] = {
> +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_FAULT),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info acpi_fan_fine_grain_chip_info = {
> +	.ops = &acpi_fan_ops,
> +	.info = acpi_fan_fine_grain_info,
> +};
> +
> +int devm_acpi_fan_create_hwmon(struct acpi_device *device)
> +{
> +	struct acpi_fan *fan = acpi_driver_data(device);
> +	const struct hwmon_chip_info *info;
> +	struct device *hdev;
> +
> +	/* When in fine grain control mode, not every fan control value
> +	 * has an associated fan performance state.
> +	 */
> +	if (fan->fif.fine_grain_ctrl)
> +		info = &acpi_fan_fine_grain_chip_info;
> +	else
> +		info = &acpi_fan_chip_info;
> +
> +	hdev = devm_hwmon_device_register_with_info(&device->dev, "acpi_fan", device, info, NULL);
> +
> +	return PTR_ERR_OR_ZERO(hdev);
> +}
> --
> 2.39.2
> 

