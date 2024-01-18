Return-Path: <linux-kernel+bounces-30360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEBD831DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13152897F7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABF92C1BD;
	Thu, 18 Jan 2024 16:43:39 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6D2C191
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596218; cv=none; b=OduZkxfDgmovd3ADQLclD/5CKJV1pIh7U/3tZNMInEYFVIS8i+P8AARDumo+rjRVZ4tpIgq9SCw3aAHDIpR2V3K7aNI2TUmVvtV55yE+5JwbZvVzd2r6yN1dvQ/K/bfLn/ezc5uzpm2GShBUDCoSRVF7FFTus+uRUN14EIgBggw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596218; c=relaxed/simple;
	bh=pG9RdZEU21VLYyvJIBzw2Q7/WDET0mIG+3uqpsrbh7M=;
	h=Received:From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=BmkhDRWJjm2ZmyPjgMr+f7Gw6u2Xbg5x7+53yTJaI6PxjAfs7FNcp8bXm6i+sF0p8EY8QL8WrJr7KkwQMOdDtMjU6feQ+duZrou1xn6Ku2iP1bhsq/pIuZjruusn3ADyxW2gRQB8vtMqEqre0qW8/hZswn7Eu5vs35mOZayYfiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-108.elisa-laajakaista.fi [88.113.24.108])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 8fb3aecb-b620-11ee-b972-005056bdfda7;
	Thu, 18 Jan 2024 18:42:26 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Thu, 18 Jan 2024 18:42:26 +0200
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linus.walleij@linaro.org, vkoul@kernel.org, lgirdwood@gmail.com,
	yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
	pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/6] mfd: cs42l43: Add support for cs42l43 core driver
Message-ID: <ZalU8r1OvqKOLHrf@surfacebook.localdomain>
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
 <20230804104602.395892-4-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804104602.395892-4-ckeepax@opensource.cirrus.com>

Fri, Aug 04, 2023 at 11:45:59AM +0100, Charles Keepax kirjoitti:
> The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
> for portable applications. It provides a high dynamic range, stereo
> DAC for headphone output, two integrated Class D amplifiers for
> loudspeakers, and two ADCs for wired headset microphone input or
> stereo line input. PDM inputs are provided for digital microphones.
> 
> The MFD component registers and initialises the device and provides
> PM/system power management.

..

> +#include <linux/err.h>
> +#include <linux/errno.h>

It seems errno is not used (as Linux kernel error codes, otherwise err.h
already includes necessary header).

Also seems array_size.h, mod_devicetable.h are missing (at least).

..

> +#if IS_ENABLED(CONFIG_OF)

We are trying hard to get rid of this ugly ifdefferies (ACPI as well) along
with respective macros that are often the PITA for CIs.

> +static const struct of_device_id cs42l43_of_match[] = {
> +	{ .compatible = "cirrus,cs42l43", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cs42l43_of_match);
> +#endif
> +
> +#if IS_ENABLED(CONFIG_ACPI)
> +static const struct acpi_device_id cs42l43_acpi_match[] = {
> +	{ "CSC4243", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, cs42l43_acpi_match);
> +#endif
> +
> +static struct i2c_driver cs42l43_i2c_driver = {
> +	.driver = {
> +		.name			= "cs42l43",
> +		.pm			= pm_ptr(&cs42l43_pm_ops),
> +		.of_match_table		= of_match_ptr(cs42l43_of_match),
> +		.acpi_match_table	= ACPI_PTR(cs42l43_acpi_match),
> +	},
> +
> +	.probe		= cs42l43_i2c_probe,
> +	.remove		= cs42l43_i2c_remove,
> +};

..

> +#include <linux/err.h>
> +#include <linux/errno.h>

As per above.

> +#include <linux/mfd/cs42l43-regs.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/soundwire/sdw.h>
> +#include <linux/soundwire/sdw_registers.h>
> +#include <linux/soundwire/sdw_type.h>

..

> +	mutex_lock(&cs42l43->pll_lock);

This can be converted using cleanup.h.

> +	mutex_unlock(&cs42l43->pll_lock);

..

> +	cs42l43->regmap = devm_regmap_init_sdw(sdw, &cs42l43_sdw_regmap);
> +	if (IS_ERR(cs42l43->regmap)) {
> +		ret = PTR_ERR(cs42l43->regmap);
> +		dev_err(cs42l43->dev, "Failed to allocate regmap: %d\n", ret);
> +		return ret;
> +	}

Can be simplified as

	cs42l43->regmap = devm_regmap_init_sdw(sdw, &cs42l43_sdw_regmap);
	if (IS_ERR(cs42l43->regmap))
		dev_err_probe(cs42l43->dev, PTR_ERR(cs42l43->regmap),
			      "Failed to allocate regmap: %d\n", ret);

..

> +#include <linux/err.h>
> +#include <linux/errno.h>

As per above.

..

> +#define CS42L43_RESET_DELAY			20
> +
> +#define CS42L43_SDW_ATTACH_TIMEOUT		500
> +#define CS42L43_SDW_DETACH_TIMEOUT		100
> +
> +#define CS42L43_MCU_POLL			5000
> +#define CS42L43_MCU_CMD_TIMEOUT			20000

> +#define CS42L43_MCU_UPDATE_TIMEOUT		500000

> +#define CS42L43_VDDP_DELAY			50
> +#define CS42L43_VDDD_DELAY			1000
> +
> +#define CS42L43_AUTOSUSPEND_TIME		250

Usually we use units for the macro names as suffixes...
E.g., _US (for microseconds).

..

> +struct cs42l43_patch_header {
> +	__le16 version;
> +	__le16 size;
> +	u8 reserved;
> +	u8 secure;

Seems to me that __u8 is appropriate as patch is external to the kernel and
it's kinda firmware interface.

> +	__le16 bss_size;
> +	__le32 apply_addr;
> +	__le32 checksum;
> +	__le32 sha;
> +	__le16 swrev;
> +	__le16 patchid;
> +	__le16 ipxid;
> +	__le16 romver;
> +	__le32 load_addr;
> +} __packed;

..

> +static const struct mfd_cell cs42l43_devs[] = {
> +	{ .name = "cs42l43-pinctrl", },
> +	{ .name = "cs42l43-spi", },

Inner commas are not needed

> +	{
> +		.name = "cs42l43-codec",
> +		.parent_supplies = cs42l43_parent_supplies,
> +		.num_parent_supplies = ARRAY_SIZE(cs42l43_parent_supplies),
> +	},
> +};

> +	case CS42L43_MCU_BOOT_STAGE2:
> +		if (!patched) {
> +			ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
> +						      "cs42l43.bin", cs42l43->dev,
> +						      GFP_KERNEL, cs42l43,
> +						      cs42l43_mcu_load_firmware);
> +			if (ret) {
> +				dev_err(cs42l43->dev, "Failed to request firmware: %d\n", ret);
> +				return ret;
> +			}
> +
> +			wait_for_completion(&cs42l43->firmware_download);
> +
> +			if (cs42l43->firmware_error)
> +				return cs42l43->firmware_error;
> +
> +			return -EAGAIN;
> +		} else {

Redundant 'else' and 

> +			return cs42l43_mcu_stage_2_3(cs42l43, shadow);
> +		}

why not positive conditional as below?

		if (patched)
			return ...
		...


> +	case CS42L43_MCU_BOOT_STAGE3:
> +		if (patched)
> +			return cs42l43_mcu_disable(cs42l43);
> +		else
> +			return cs42l43_mcu_stage_3_2(cs42l43);

..

> +	irq_flags = irqd_get_trigger_type(irq_data);
> +	switch (irq_flags) {
> +	case IRQF_TRIGGER_LOW:
> +	case IRQF_TRIGGER_HIGH:
> +	case IRQF_TRIGGER_RISING:
> +	case IRQF_TRIGGER_FALLING:
> +		break;
> +	case IRQ_TYPE_NONE:

Are you sure it's a right place to interpret no type flags as a default?

> +	default:
> +		irq_flags = IRQF_TRIGGER_LOW;
> +		break;
> +	}

..

> +static int cs42l43_suspend(struct device *dev)
> +{
> +	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/*
> +	 * Don't care about being resumed here, but the driver does want
> +	 * force_resume to always trigger an actual resume, so that register
> +	 * state for the MCU/GPIOs is returned as soon as possible after system
> +	 * resume. force_resume will resume if the reference count is resumed on
> +	 * suspend hence the get_noresume.
> +	 */
> +	pm_runtime_get_noresume(dev);
> +
> +	ret = pm_runtime_force_suspend(dev);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to force suspend: %d\n", ret);
> +		pm_runtime_put_noidle(dev);
> +		return ret;
> +	}
> +
> +	pm_runtime_put_noidle(dev);
> +
> +	ret = cs42l43_power_down(cs42l43);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

	return cs42l43_power_down(cs42l43);

> +}

..

> +EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) = {
> +	SET_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
> +	SET_RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
> +};

Why do you need SET_*() versions of those macros? They are not supposed to be
used with the new macros such as EXPORT_NS_GPL_DEV_PM_OPS().

..

> +++ b/drivers/mfd/cs42l43.h

> +#include <linux/mfd/cs42l43.h>

How is this header being used?
Wouldn't the forward declaration fulfill the need?

> +#include <linux/pm.h>
> +#include <linux/regmap.h>

> +#ifndef CS42L43_CORE_INT_H
> +#define CS42L43_CORE_INT_H

Why you don't guard other headers with this? It will slow down the build.

> +#define CS42L43_N_DEFAULTS 176
> +
> +extern const struct dev_pm_ops cs42l43_pm_ops;
> +extern const struct reg_default cs42l43_reg_default[CS42L43_N_DEFAULTS];


Missing forward declaration for

struct device;

> +bool cs42l43_readable_register(struct device *dev, unsigned int reg);
> +bool cs42l43_precious_register(struct device *dev, unsigned int reg);
> +bool cs42l43_volatile_register(struct device *dev, unsigned int reg);

> +int cs42l43_dev_probe(struct cs42l43 *cs42l43);
> +void cs42l43_dev_remove(struct cs42l43 *cs42l43);
> +
> +#endif /* CS42L43_CORE_INT_H */

..

> +#define CS42L43_MIXER_VOL_MASK					0x00FE0000
> +#define CS42L43_MIXER_VOL_SHIFT					17
> +#define CS42L43_MIXER_SRC_MASK					0x000001FF
> +#define CS42L43_MIXER_SRC_SHIFT					0

This header would benefit from bits.h... (the above is just a little example).

..

> +++ b/include/linux/mfd/cs42l43.h

> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/soundwire/sdw.h>

Missing forward declarations (instead of inclusions).

struct device;
struct gpio_desc;
struct sdw_slave;

Missing types.h.

..

> +#ifndef CS42L43_CORE_EXT_H
> +#define CS42L43_CORE_EXT_H

Same questions as per another header.

-- 
With Best Regards,
Andy Shevchenko



