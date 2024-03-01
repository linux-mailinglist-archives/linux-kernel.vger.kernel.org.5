Return-Path: <linux-kernel+bounces-88121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF9186DD8F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5B51F22AE3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982216A330;
	Fri,  1 Mar 2024 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snVJHIQX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE269E0A;
	Fri,  1 Mar 2024 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283052; cv=none; b=KahDowTUq1ivl3KqhVpWw9MlsxvJEToEdsy8HvOBfsu/tvuB5Wb64bBhgBzmyYh3g3TmGJFdDWbrYRWTGz3FeHWrkazlPctliW8SuLDYOuzzJPQ3CJV0X9Ox9GlRApLXbgRZ2AUh3BMV6JUWQm/W/XxV4gY32iy9aLLZgdsZUKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283052; c=relaxed/simple;
	bh=aZJaxULNASLuq7YBLNxOmz9gR49kB2f7WbnPFWl71m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPbx5dlGXUZOu8gHO4AB2hxOL8XAy2EC+7nFJNlsS111NpPDpynaHRIITrxGYuJ/vbafkFYNboywk6GjtfHONT4eBZDwFc8In+5wIOqH16u4XjgOGrsWEW+1OapiGzJSLQGi1SNWKQFmkKemWI75XVEqslD4s46jhI7fuGj3BHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snVJHIQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A89C43394;
	Fri,  1 Mar 2024 08:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709283052;
	bh=aZJaxULNASLuq7YBLNxOmz9gR49kB2f7WbnPFWl71m4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snVJHIQXdwbGd/MiA8okiLVhV1ooIZPTYyDF5GpLwyn1S9ipNMxRnS4lhCsH3iKXT
	 xUwVD/6k7M1UKpQj9CuUlgXibD8xOszeM7L3KBYhYTPtNJsnEAKbk+vvFAuTeeWHdv
	 F4K/sCCIrO86GwSFlfv7AsRr+11a93iX6C2wZnat1oEq5wBq1Y7Z1mCxncPgwGaoO9
	 EjUiO7YczaeNT7RYaT9vHZrqtPV4NsIp8y/1ypGFEA3ZHz1g071quVODq072kE3Rzk
	 zISFcxbngCHie4E6eba9+ilFyV7rtThV1YgNrL7L3X5G9X66PqWOM3iGkielleyd/d
	 ZMMSN8YEyyxEg==
Date: Fri, 1 Mar 2024 08:50:46 +0000
From: Lee Jones <lee@kernel.org>
To: Abdel Alkuor <alkuor@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alice Chen <alice_chen@richtek.com>,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	ChiaEn Wu <chiaen_wu@richtek.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] leds: Add NCP5623 multi-led driver
Message-ID: <20240301085046.GE1209090@google.com>
References: <20240217230956.630522-1-alkuor@gmail.com>
 <20240217230956.630522-2-alkuor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240217230956.630522-2-alkuor@gmail.com>

On Sat, 17 Feb 2024, Abdel Alkuor wrote:

> NCP5623 is DC-DC multi-LEDs driver which has three PWMs that can be
> programmed up to 32 steps giving 32768 colors hue.
> 
> NCP5623 driver supports gradual dimming upward/downward with programmable
> delays. Also, the driver supports driving a single LED or multi-LED
> like RGB.
> 
> Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> ---
> Changes in v2:
>  - Remove all custom attributes and use hw pattern instead
>  - Remove filename from the driver description
>  - Fix coding style
>  - Destroy the muttex in shutdown callback
>  - Register mcled device using none devm version as unregistering mcled device
>    calls ncp5632_set_led which uses mutex hence we need to make sure the
>    mutex is still available during the unregistering process.
>  - Link to v1: https://lore.kernel.org/linux-kernel/20240208130115.GM689448@google.com/T/
> 
>  drivers/leds/rgb/Kconfig        |  11 ++
>  drivers/leds/rgb/Makefile       |   1 +
>  drivers/leds/rgb/leds-ncp5623.c | 257 ++++++++++++++++++++++++++++++++
>  3 files changed, 269 insertions(+)
>  create mode 100644 drivers/leds/rgb/leds-ncp5623.c
> 
> diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
> index a6a21f564673..81ab6a526a78 100644
> --- a/drivers/leds/rgb/Kconfig
> +++ b/drivers/leds/rgb/Kconfig
> @@ -27,6 +27,17 @@ config LEDS_KTD202X
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called leds-ktd202x.
>  
> +config LEDS_NCP5623
> +	tristate "LED support for NCP5623"
> +	depends on I2C
> +	depends on OF
> +	help
> +	  This option enables support for ON semiconductor NCP5623
> +	  Triple Output I2C Controlled RGB LED Driver.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called leds-ncp5623.
> +
>  config LEDS_PWM_MULTICOLOR
>  	tristate "PWM driven multi-color LED Support"
>  	depends on PWM
> diff --git a/drivers/leds/rgb/Makefile b/drivers/leds/rgb/Makefile
> index 243f31e4d70d..a501fd27f179 100644
> --- a/drivers/leds/rgb/Makefile
> +++ b/drivers/leds/rgb/Makefile
> @@ -2,6 +2,7 @@
>  
>  obj-$(CONFIG_LEDS_GROUP_MULTICOLOR)	+= leds-group-multicolor.o
>  obj-$(CONFIG_LEDS_KTD202X)		+= leds-ktd202x.o
> +obj-$(CONFIG_LEDS_NCP5623)		+= leds-ncp5623.o
>  obj-$(CONFIG_LEDS_PWM_MULTICOLOR)	+= leds-pwm-multicolor.o
>  obj-$(CONFIG_LEDS_QCOM_LPG)		+= leds-qcom-lpg.o
>  obj-$(CONFIG_LEDS_MT6370_RGB)		+= leds-mt6370-rgb.o
> diff --git a/drivers/leds/rgb/leds-ncp5623.c b/drivers/leds/rgb/leds-ncp5623.c
> new file mode 100644
> index 000000000000..5a5c770bb61e
> --- /dev/null
> +++ b/drivers/leds/rgb/leds-ncp5623.c
> @@ -0,0 +1,257 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NCP5623 Multi-LED Driver
> + *
> + * Author: Abdel Alkuor <alkuor@gmail.com>
> + * Datasheet: https://www.onsemi.com/pdf/datasheet/ncp5623-d.pdf
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +
> +#include <linux/led-class-multicolor.h>
> +
> +#define NCP5623_REG(x)			((x) << 0x5)

What's 0x5?  Probably worth defining.

> +#define NCP5623_SHUTDOWN_REG		NCP5623_REG(0x0)
> +#define NCP5623_ILED_REG		NCP5623_REG(0x1)
> +#define NCP5623_PWM_REG(index)		NCP5623_REG(0x2 + (index))
> +#define NCP5623_UPWARD_STEP_REG		NCP5623_REG(0x5)
> +#define NCP5623_DOWNWARD_STEP_REG	NCP5623_REG(0x6)
> +#define NCP5623_DIMMING_TIME_REG	NCP5623_REG(0x7)
> +
> +#define NCP5623_MAX_BRIGHTNESS		0x1f
> +
> +struct ncp5623 {
> +	struct i2c_client *client;
> +	struct led_classdev_mc mc_dev;
> +	struct mutex lock;
> +
> +	int old_brightness;
> +	unsigned long delay;
> +};
> +
> +static int ncp5623_write(struct i2c_client *client, u8 reg, u8 data)
> +{
> +	return i2c_smbus_write_byte_data(client, reg | data, 0);
> +}
> +
> +static int ncp5623_brightness_set(struct led_classdev *cdev,
> +				  enum led_brightness brightness)
> +{
> +	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
> +	struct ncp5623 *ncp = container_of(mc_cdev, struct ncp5623, mc_dev);
> +	int ret;
> +
> +	guard(mutex)(&ncp->lock);

Are these self-unlocking?

> +	if (ncp->delay && time_is_after_jiffies(ncp->delay))
> +		return -EBUSY;
> +
> +	ncp->delay = 0;
> +
> +	for (int i = 0; i < mc_cdev->num_colors; i++) {
> +		ret = ncp5623_write(ncp->client,
> +				    NCP5623_PWM_REG(mc_cdev->subled_info[i].channel),
> +				    min(mc_cdev->subled_info[i].intensity,
> +					NCP5623_MAX_BRIGHTNESS));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = ncp5623_write(ncp->client, NCP5623_DIMMING_TIME_REG, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = ncp5623_write(ncp->client, NCP5623_ILED_REG, brightness);
> +	if (ret)
> +		return ret;
> +
> +	ncp->old_brightness = brightness;

The nomenclature is confusing here.

For the most part, this will carry the present value, no?

> +	return 0;
> +}
> +
> +static int ncp5623_pattern_set(struct led_classdev *cdev,
> +			       struct led_pattern *pattern,
> +			       u32 len, int repeat)
> +{
> +	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
> +	struct ncp5623 *ncp = container_of(mc_cdev, struct ncp5623, mc_dev);
> +	int brightness_diff;
> +	u8 reg;
> +	int ret;
> +
> +	guard(mutex)(&ncp->lock);
> +
> +	if (ncp->delay && time_is_after_jiffies(ncp->delay))
> +		return -EBUSY;
> +
> +	ncp->delay = 0;
> +
> +	if (pattern[0].delta_t > 240 || (pattern[0].delta_t % 8) != 0)
> +		return -EINVAL;
> +
> +	brightness_diff = pattern[0].brightness - ncp->old_brightness;
> +
> +	if (brightness_diff == 0)
> +		return 0;
> +
> +	if (pattern[0].delta_t) {
> +		if (brightness_diff > 0)
> +			reg = NCP5623_UPWARD_STEP_REG;
> +		else
> +			reg = NCP5623_DOWNWARD_STEP_REG;
> +	} else {
> +		reg = NCP5623_ILED_REG;
> +	}
> +
> +	ret = ncp5623_write(ncp->client, reg,
> +			    min(pattern[0].brightness, NCP5623_MAX_BRIGHTNESS));
> +	if (ret)
> +		return ret;
> +
> +	ret = ncp5623_write(ncp->client,
> +			    NCP5623_DIMMING_TIME_REG, pattern[0].delta_t / 8);

Why 8?  Magic numbers should be replaced with #defines.

> +	if (ret)
> +		return ret;
> +
> +	if (abs(brightness_diff) == 1)
> +		ncp->delay = NCP5623_MAX_BRIGHTNESS + brightness_diff;
> +	else
> +		ncp->delay = abs(brightness_diff);

Please comment these lines.

> +	ncp->delay = msecs_to_jiffies(ncp->delay * pattern[0].delta_t) + jiffies;
> +
> +	ncp->old_brightness = pattern[0].brightness;
> +
> +	return 0;
> +}
> +
> +static int ncp5623_pattern_clear(struct led_classdev *led_cdev)
> +{
> +	return 0;
> +}

Not sure I see the point in this.

Is the .pattern_clear() compulsorily?

> +static int ncp5623_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct fwnode_handle *mc_node, *led_node;
> +	struct led_init_data init_data = { };
> +	int num_subleds = 0;
> +	struct ncp5623 *ncp;
> +	struct mc_subled *subled_info;
> +	u32 color_index;
> +	u32 reg;
> +	int ret;
> +
> +	ncp = devm_kzalloc(dev, sizeof(*ncp), GFP_KERNEL);
> +	if (!ncp)
> +		return -ENOMEM;
> +
> +	ncp->client = client;
> +
> +	mc_node = device_get_named_child_node(dev, "multi-led");
> +	if (!mc_node)
> +		return -EINVAL;
> +
> +	fwnode_for_each_child_node(mc_node, led_node)
> +		num_subleds++;
> +
> +	subled_info = devm_kcalloc(dev, num_subleds,
> +				   sizeof(*subled_info), GFP_KERNEL);

No need to wrap here.  Checkpatch won't complain.

> +	if (!subled_info) {
> +		ret = -ENOMEM;
> +		goto release_mc_node;
> +	}
> +
> +	fwnode_for_each_available_child_node(mc_node, led_node) {
> +		ret = fwnode_property_read_u32(led_node, "color", &color_index);
> +		if (ret) {
> +			fwnode_handle_put(led_node);
> +			goto release_mc_node;
> +		}
> +
> +		ret = fwnode_property_read_u32(led_node, "reg", &reg);
> +		if (ret) {
> +			fwnode_handle_put(led_node);
> +			goto release_mc_node;
> +		}
> +
> +		subled_info[ncp->mc_dev.num_colors].channel = reg;
> +		subled_info[ncp->mc_dev.num_colors++].color_index = color_index;
> +	}
> +
> +	init_data.fwnode = mc_node;
> +
> +	ncp->mc_dev.led_cdev.max_brightness = NCP5623_MAX_BRIGHTNESS;
> +	ncp->mc_dev.subled_info = subled_info;
> +	ncp->mc_dev.led_cdev.brightness_set_blocking = ncp5623_brightness_set;
> +	ncp->mc_dev.led_cdev.pattern_set = ncp5623_pattern_set;
> +	ncp->mc_dev.led_cdev.pattern_clear = ncp5623_pattern_clear;
> +	ncp->mc_dev.led_cdev.default_trigger = "pattern";
> +
> +	mutex_init(&ncp->lock);
> +	i2c_set_clientdata(client, ncp);
> +
> +	ret = led_classdev_multicolor_register_ext(dev, &ncp->mc_dev, &init_data);
> +	if (ret)
> +		goto destroy_lock;
> +
> +	fwnode_handle_put(mc_node);

Didn't you just store this ~16 lines up?

> +	return 0;
> +
> +destroy_lock:
> +	mutex_destroy(&ncp->lock);
> +
> +release_mc_node:
> +	fwnode_handle_put(mc_node);
> +
> +	return ret;
> +}
> +
> +static void ncp5623_remove(struct i2c_client *client)
> +{
> +	struct ncp5623 *ncp = i2c_get_clientdata(client);
> +
> +	mutex_lock(&ncp->lock);
> +	ncp->delay = 0;
> +	mutex_unlock(&ncp->lock);
> +
> +	ncp5623_write(client, NCP5623_DIMMING_TIME_REG, 0);
> +	led_classdev_multicolor_unregister(&ncp->mc_dev);
> +	mutex_destroy(&ncp->lock);
> +}
> +
> +static void ncp5623_shutdown(struct i2c_client *client)
> +{
> +	struct ncp5623 *ncp = i2c_get_clientdata(client);
> +
> +	if (!(ncp->mc_dev.led_cdev.flags & LED_RETAIN_AT_SHUTDOWN))
> +		ncp5623_write(client, NCP5623_SHUTDOWN_REG, 0);
> +
> +	mutex_destroy(&ncp->lock);
> +}
> +
> +static const struct of_device_id ncp5623_id[] = {
> +	{ .compatible = "onnn,ncp5623" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ncp5623_id);
> +
> +static struct i2c_driver ncp5623_i2c_driver = {
> +	.driver	= {
> +		.name = "ncp5623",
> +		.of_match_table = ncp5623_id,
> +	},
> +	.probe = ncp5623_probe,
> +	.remove = ncp5623_remove,
> +	.shutdown = ncp5623_shutdown,
> +};
> +
> +module_i2c_driver(ncp5623_i2c_driver);
> +
> +MODULE_AUTHOR("Abdel Alkuor <alkuor@gmail.com>");
> +MODULE_DESCRIPTION("NCP5623 Multi-LED driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1
> 

-- 
Lee Jones [李琼斯]

