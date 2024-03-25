Return-Path: <linux-kernel+bounces-116998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB7988A5F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2B21F6313A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79E811718;
	Mon, 25 Mar 2024 12:29:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE2011CBA;
	Mon, 25 Mar 2024 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369781; cv=none; b=BF3zYa3hiXaFA8R1csGYdHKfHOnr3VlFCAt9tF8Eqc17rOfNaFd5aSh0HNnBnPNme9vlg5PeiNZUgjyVzuWSrmfBdXSOMGVrLG7BrdAIhkoHUzXUrwXWho2z5jHDL/qW+6r9FlLrpoY+iiEgkf3OtOAOk7jalYrXOVC2OEGnW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369781; c=relaxed/simple;
	bh=pDxTePaGSSZaSvQVTLl7tbVXyHYt763EFZOxN6OB8Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=araPdvgmm0tVuaF4JPIQaaYVp6dpeFVVkdoXaudfAzOWDQt9xxSaTHCdPvJbjLtsKx5M6X7PK1+jT35m8Ki5sob4xOKR7yJuP68+oYaQPgfaAjSlamcus+1b1CTMVlPdks2b/7uSZSqFsBvlnLO3brCLIjcU5eCdcrrIRo5bdKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com; spf=pass smtp.mailfrom=intel.com; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6548993"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6548993"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:29:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070320"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070320"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 05:29:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 253F9228; Mon, 25 Mar 2024 14:29:34 +0200 (EET)
Date: Mon, 25 Mar 2024 14:29:33 +0200
From: Andy Shevchenko <andy@black.fi.intel.com>
To: David Ober <dober6023@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
	corbet@lwn.net, dober@lenovo.com, mpearson@lenovo.com
Subject: Re: [PATCH v4] hwmon:Add EC Chip driver for Lenovo ThinkStation
 motherboards
Message-ID: <ZgFuLbBe4y1OiRqY@black.fi.intel.com>
References: <20240315115810.15816-1-dober6023@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315115810.15816-1-dober6023@gmail.com>

On Fri, Mar 15, 2024 at 07:58:10AM -0400, David Ober wrote:
> This addition adds in the ability for the system to scan
> the EC chip in the Lenovo ThinkStation systems to get the
> current fan RPM speeds the Maximum speed value for each
> fan also provides the CPU, DIMM other thermal statuses

Besides the compilation error, see other remarks below.

..

> Signed-off-by: David Ober <dober@lenovo.com>
> Signed-off-by: David Ober <dober6023@gmail.com>

Can you leave only one of these?

> +config SENSORS_LENOVO_EC
> +        tristate "Sensor reader for Lenovo ThinkStations"
> +        depends on X86
> +        help
> +          If you say yes here you get support for LENOVO
> +          EC Sensor data on newer ThinkStation systems
> +
> +          This driver can also be built as a module. If so, the module
> +          will be called lenovo_ec_sensors.

..

> + * Copyright (C) 2023 David Ober (Lenovo) <dober@lenovo.com>

2024?

..


Use IWYU principle (include what you use). See below what I have noticed
(may not be the full list of missing inclusions).

> +#include <linux/acpi.h>
> +#include <linux/delay.h>

+ device.h

> +#include <linux/dmi.h>

+ err.h

> +#include <linux/hwmon.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>

> +#include <linux/kernel.h>

How is this one being used, please?

> +#include <linux/module.h>

+ mutex.h

> +#include <linux/platform_device.h>

+ types.h

> +#include <linux/units.h>

..

> +#define io_write8(a, b)	outb_p(b, a)
> +#define io_read8(a)	inb_p(a)

First of all, these are too generic, second, what's the point? If you
wish to make useful macros, put a pointer to the private data, for
example, from which you can get the address.

..

> +static inline uint8_t

uint8_t...

> +get_ec_reg(unsigned char page, unsigned char index)
> +{
> +	u8 onebyte;

u8... Just in a few closer lines :-(

Can you be consistent with a kernel types?

> +	unsigned short m_index;
> +	unsigned short phy_index = page * 256 + index;
> +
> +	io_write8(MCHP_EMI0_APPLICATION_ID, 0x01);
> +
> +	m_index = phy_index & 0x7FFC;

GENMASK() (you will need bits.h for this)

> +	io_write8(MCHP_EMI0_EC_ADDRESS_LSB, m_index);
> +	io_write8(MCHP_EMI0_EC_ADDRESS_MSB, m_index >> 8);

Can the 16-bit write suffice?

> +	onebyte = io_read8(MCHP_EMI0_EC_DATA_BYTE0 + (phy_index & 3));

GENMASK()

> +	io_write8(MCHP_EMI0_APPLICATION_ID, 0x01);  /* write 0x01 again to clean */
> +	return onebyte;
> +}

..

> +struct ec_sensors_data {
> +	struct mutex mec_mutex; /* lock for sensor data access */
> +	/*int platform_id;*/

Huh?! Please remove, if no use for it.

> +	const char *const *fan_labels;
> +	const char *const *temp_labels;
> +	const int *fan_map;
> +	const int *temp_map;
> +};

..

> +static int
> +lenovo_ec_do_read_fan(struct ec_sensors_data *data, u32 attr, int channel, long *val)
> +{
> +	u8 lsb, msb;
> +
> +	channel *= 2;
> +	switch (attr) {
> +	case hwmon_fan_input:
> +		mutex_lock(&data->mec_mutex);
> +		lsb = get_ec_reg(4, 0x20 + channel);
> +		msb = get_ec_reg(4, 0x21 + channel);
> +		mutex_unlock(&data->mec_mutex);
> +		*val = (msb << 8) + lsb;
> +		return 0;
> +	case hwmon_fan_max:
> +		mutex_lock(&data->mec_mutex);
> +		lsb = get_ec_reg(4, 0x40 + channel);
> +		msb = get_ec_reg(4, 0x41 + channel);
> +		mutex_unlock(&data->mec_mutex);
> +		*val = (msb << 8) + lsb;
> +		return 0;
> +	case hwmon_fan_min:
> +	case hwmon_fan_div:
> +	case hwmon_fan_alarm:
> +		break;
> +	default:
> +		break;
> +	}
> +	return -EOPNOTSUPP;

Combine with the above and return only once this from the default case.

> +}

..

> +static int
> +lenovo_ec_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
> +			    u32 attr, int channel, const char **str)
> +{
> +	struct ec_sensors_data *state = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		*str = state->temp_labels[channel];
> +		break;

In the other function you returned directly. Keep the style consistent,
please.

> +	case hwmon_fan:
> +		*str = state->fan_labels[channel];
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}

..

> +static int
> +lenovo_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +		     u32 attr, int channel, long *val)
> +{
> +	struct ec_sensors_data *data = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		return lenovo_ec_do_read_temp(data, attr, data->temp_map[channel], val);
> +	case hwmon_fan:
> +		return lenovo_ec_do_read_fan(data, attr, data->fan_map[channel], val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}

> +	return 0;

Dead code.

> +}

..

> +static umode_t
> +lenovo_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
> +			   u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		if (attr == hwmon_temp_input || attr == hwmon_temp_label)
> +			return 0444;
> +		break;
> +	case hwmon_fan:
> +		if (attr == hwmon_fan_input || attr == hwmon_fan_max || attr == hwmon_fan_label)
> +			return 0444;
> +		break;
> +	default:
> +		return 0;
> +	}
> +	return 0;

Same comment about the style.

> +}

..

> +static int lenovo_ec_probe(struct platform_device *pdev)
> +{
> +	struct device *hwdev;
> +	struct ec_sensors_data *ec_data;
> +	const struct hwmon_chip_info *chip_info;
> +	struct device *dev = &pdev->dev;
> +	const struct dmi_system_id *dmi_id;
> +	int app_id;
> +
> +	ec_data = devm_kzalloc(dev, sizeof(struct ec_sensors_data), GFP_KERNEL);
> +	if (!ec_data) {

> +		release_region(IO_REGION_START, IO_REGION_LENGTH);

This is weird. Please, either move request region to the probe, or drop
these calls here. Obviously you haven't checked the bind-unbind-bind
cycle with error injection.

> +		return -ENOMEM;
> +	}
> +
> +	dev_set_drvdata(dev, ec_data);
> +
> +	chip_info = &lenovo_ec_chip_info;
> +
> +	mutex_init(&ec_data->mec_mutex);
> +
> +	mutex_lock(&ec_data->mec_mutex);
> +	app_id = io_read8(MCHP_EMI0_APPLICATION_ID);
> +	if (app_id) /* check EMI Application ID Value */
> +		io_write8(MCHP_EMI0_APPLICATION_ID, app_id); /* set EMI Application ID to 0 */
> +	io_write8(MCHP_EMI0_EC_ADDRESS_LSB, MCHP_SING_IDX);
> +	io_write8(MCHP_EMI0_EC_ADDRESS_MSB, MCHP_SING_IDX >> 8);
> +	mutex_unlock(&ec_data->mec_mutex);
> +
> +	if ((io_read8(MCHP_EMI0_EC_DATA_BYTE0) != 'M') &&
> +	    (io_read8(MCHP_EMI0_EC_DATA_BYTE1) != 'C') &&
> +	    (io_read8(MCHP_EMI0_EC_DATA_BYTE2) != 'H') &&
> +	    (io_read8(MCHP_EMI0_EC_DATA_BYTE3) != 'P')) {
> +		release_region(IO_REGION_START, IO_REGION_LENGTH);
> +		return -ENODEV;
> +	}
> +
> +	dmi_id = dmi_first_match(thinkstation_dmi_table);
> +
> +	switch ((long)dmi_id->driver_data) {
> +	case 0:
> +		ec_data->fan_labels = px_ec_fan_label;
> +		ec_data->temp_labels = lenovo_px_ec_temp_label;
> +		ec_data->fan_map = px_fan_map;
> +		ec_data->temp_map = px_temp_map;
> +		lenovo_ec_chip_info.info = lenovo_ec_hwmon_info_px;
> +		break;
> +	case 1:
> +		ec_data->fan_labels = p7_ec_fan_label;
> +		ec_data->temp_labels = lenovo_gen_ec_temp_label;
> +		ec_data->fan_map = p7_fan_map;
> +		ec_data->temp_map = gen_temp_map;
> +		lenovo_ec_chip_info.info = lenovo_ec_hwmon_info_p7;
> +		break;
> +	case 2:
> +		ec_data->fan_labels = p5_ec_fan_label;
> +		ec_data->temp_labels = lenovo_gen_ec_temp_label;
> +		ec_data->fan_map = p5_fan_map;
> +		ec_data->temp_map = gen_temp_map;
> +		lenovo_ec_chip_info.info = lenovo_ec_hwmon_info_p5;
> +		break;
> +	case 3:
> +		ec_data->fan_labels = p8_ec_fan_label;
> +		ec_data->temp_labels = lenovo_gen_ec_temp_label;
> +		ec_data->fan_map = p8_fan_map;
> +		ec_data->temp_map = gen_temp_map;
> +		lenovo_ec_chip_info.info = lenovo_ec_hwmon_info_p8;
> +		break;
> +	default:
> +		release_region(IO_REGION_START, IO_REGION_LENGTH);
> +		return -ENODEV;
> +	}
> +
> +	hwdev = devm_hwmon_device_register_with_info(dev, "lenovo_ec",
> +						     ec_data,
> +						     chip_info, NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwdev);
> +}

..

> +	if (!request_region(IO_REGION_START, IO_REGION_LENGTH, "LNV-WKS")) {
> +		pr_err(":request fail\n");

I haven't noticed pr_fmt(). How can the user distinguish this from
something similar from another place?

> +		return -EIO;
> +	}

..

> +static void __exit lenovo_ec_exit(void)
> +{
> +	release_region(IO_REGION_START, IO_REGION_LENGTH);
> +	platform_device_unregister(lenovo_ec_sensors_platform_device);
> +	platform_driver_unregister(&lenovo_ec_sensors_platform_driver);
> +}

> +

Unneeded blank line (see also below).

> +module_init(lenovo_ec_init);
> +module_exit(lenovo_ec_exit);

Move each of them closer to the respective callback implementation.

-- 
With Best Regards,
Andy Shevchenko



