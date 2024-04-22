Return-Path: <linux-kernel+bounces-152882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237F68AC5A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6DFC1F22815
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AF74CE1F;
	Mon, 22 Apr 2024 07:36:14 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CA14AEC8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771374; cv=none; b=HFoVAiqgjn3Hh8vW3Z1AA/IjW6z06dKgkbkn1CtOquJukJFVIjx3ZOcwY9du8KgCVsmFHlHVe6t1uxqYHrlRlJRpdhjoqONwBpfBGrZniwcOhMS4AGtPxJbzUIF4qPe4+LIYhlWFTQnfJ/NKEptXv3kqW4PoFXTCkSr6mJ4TsZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771374; c=relaxed/simple;
	bh=PgbWEJHun8Ts3a0s4MSrzmK3KsjjTkmdPjaOC8mw7eU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4Hmc+ib7bK4uHAKnkWqaEVPF7BPMEe35HGWIqi0Ujp8KiioiQAUsRwJoJgFniQoGEZageU8rLTUy1Ix/Hk5BUJrw5/zXh8j8M1BJWOE5pMUhl7AbP6tDMwbEwX9h2AcglpDIwp8vpsZp8YQO/UZhV4Ucok1jam3SdOj2/JLHZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id d3ab1112-007a-11ef-a9de-005056bdf889;
	Mon, 22 Apr 2024 10:35:02 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 22 Apr 2024 10:35:00 +0300
To: Armin Wolf <W_Armin@gmx.de>
Cc: mlj@danelec.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
	jdelvare@suse.com, linux@roeck-us.net, linux@weissschuh.net,
	ilpo.jarvinen@linux.intel.com, linux-acpi@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH RESEND v5] ACPI: fan: Add hwmon support
Message-ID: <ZiYTJOmwDVaws3lh@surfacebook.localdomain>
References: <20240422060835.71708-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422060835.71708-1-W_Armin@gmx.de>

Mon, Apr 22, 2024 at 08:08:35AM +0200, Armin Wolf kirjoitti:
> Currently, the driver does only support a custom sysfs
> interface to allow userspace to read the fan speed.
> Add support for the standard hwmon interface so users
> can read the fan speed with standard tools like "sensors".
> 
> Tested with a custom ACPI SSDT.

..

> +/*
> + * fan_hwmon.c - hwmon interface for the ACPI Fan driver

No file name in the file, it makes an unneeded burden if file is going to be
renamed.

> + *
> + * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
> + */

..

> +#include <linux/acpi.h>
> +#include <linux/hwmon.h>

Please, follow IWYU pronciple, e.g., missing err.h here.

> +#include <linux/limits.h>
> +#include <linux/units.h>

..

> +/* Returned when the ACPI fan does not support speed reporting */
> +#define FAN_SPEED_UNAVAILABLE	0xffffffff
> +#define FAN_POWER_UNAVAILABLE	0xffffffff

Shouldn't these be rather as ~0 of the respective types or _MAX (from limits.h)
or something like that?

..

> +static struct acpi_fan_fps *acpi_fan_get_current_fps(struct acpi_fan *fan, u64 control)
> +{
> +	int i;

unsigned

> +	for (i = 0; i < fan->fps_count; i++) {
> +		if (fan->fps[i].control == control)
> +			return &fan->fps[i];
> +	}
> +
> +	return NULL;
> +}

..

> +static umode_t acpi_fan_is_visible(const void *drvdata, enum hwmon_sensor_types type, u32 attr,
> +				   int channel)
> +{
> +	const struct acpi_fan *fan = drvdata;
> +	int i;

unsigned

> +	switch (type) {
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			return 0444;
> +		case hwmon_fan_target:
> +			/* When in fine grain control mode, not every fan control value
> +			 * has an associated fan performance state.
> +			 */
> +			if (fan->fif.fine_grain_ctrl)
> +				return 0;
> +
> +			return 0444;
> +		default:

> +			break;
> +		}
> +		break;

Instead of two breaks, just return 0 from 'default' case.

> +	case hwmon_power:
> +		switch (attr) {
> +		case hwmon_power_input:
> +			/* When in fine grain control mode, not every fan control value
> +			 * has an associated fan performance state.
> +			 */

/*
 * Use correct style for multi-line
 * comment blocks. As in this example.
 */

> +			if (fan->fif.fine_grain_ctrl)
> +				return 0;
> +
> +			/* When all fan performance states contain no valid power data,
> +			 * when the associated attribute should not be created.
> +			 */
> +			for (i = 0; i < fan->fps_count; i++) {
> +				if (fan->fps[i].power != FAN_POWER_UNAVAILABLE)
> +					return 0444;
> +			}
> +
> +			return 0;
> +		default:

> +			break;
> +		}
> +		break;

Ditto.

> +	default:
> +		break;
> +	}
> +
> +	return 0;

Return from the default.

With the above we got rid of 2 LoCs for free.

> +}

..

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
> +			if (fps->speed > LONG_MAX)
> +				return -EOVERFLOW;
> +
> +			*val = fps->speed;
> +			return 0;
> +		default:

> +			break;
> +		}
> +		break;

As per above.

> +	case hwmon_power:
> +		switch (attr) {
> +		case hwmon_power_input:
> +			fps = acpi_fan_get_current_fps(fan, fst.control);
> +			if (!fps)
> +				return -ENODATA;
> +
> +			if (fps->power == FAN_POWER_UNAVAILABLE)
> +				return -ENODATA;
> +
> +			if (fps->power > LONG_MAX / MICROWATT_PER_MILLIWATT)
> +				return -EOVERFLOW;
> +
> +			*val = fps->power * MICROWATT_PER_MILLIWATT;
> +			return 0;
> +		default:
> +			break;
> +		}
> +		break;

Ditto.

> +	default:
> +		break;
> +	}
> +
> +	return -EOPNOTSUPP;

Ditto.

Again, 2 LoCs less here.

> +}

..

> +int devm_acpi_fan_create_hwmon(struct acpi_device *device)
> +{
> +	struct acpi_fan *fan = acpi_driver_data(device);
> +	struct device *hdev;
> +
> +	hdev = devm_hwmon_device_register_with_info(&device->dev, "acpi_fan", fan,
> +						    &acpi_fan_chip_info, NULL);

> +

Redundant blank line.

> +	return PTR_ERR_OR_ZERO(hdev);
> +}

-- 
With Best Regards,
Andy Shevchenko



