Return-Path: <linux-kernel+bounces-58099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841C084E14B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC9EDB263F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D4B76415;
	Thu,  8 Feb 2024 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjUe6aDS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C4A763E9;
	Thu,  8 Feb 2024 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397281; cv=none; b=iY1TnkSY+PqB9aro6i2qCHPxNfLCj50LaTss5im3dPaDfmVNC6vFfLuhOImz3BHV5kfkC4PVxYWg56nHQdoxfgMrn+IpTtpHt2E0cDmGYO3rkJy9R/a17X1hZaLYCdD6SwCsU1liicvwQXkqJPho8om7LcJ5IJPLvsh8+ACKGec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397281; c=relaxed/simple;
	bh=Al99jWWal+n33nzRUHBdO2bn9y08O64oDtaColLN9O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAVSQKgU+xI0O4xA1pZYVCtBpC06rJPRxQvqKeRFyjMKrnUJe6/txjg3kpv6bY4NIG/pxwPQ35WjXcS4qIII/maQKx2WULUH7+iAawKlESVEUBtV8zoOIfL7GucPT7ahiz+KRJWt9ykXEqmW4Ugzffnw919w5aG6a+uYiFJqys8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjUe6aDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3C1C433C7;
	Thu,  8 Feb 2024 13:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707397281;
	bh=Al99jWWal+n33nzRUHBdO2bn9y08O64oDtaColLN9O8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AjUe6aDSe9c6gvlCR/EW7XFieIXcuyzgUWNwEGlLeRJwLaq6SYHVkRo6kYdp1wlMj
	 EQytMDI3ccGFkJqwr6u828WsNAz+WNOqODIhFMEmOSNavsCMK6PqP6pj7G76QMgx8S
	 C2rqk3W2r+xprK9AingyDKe4aqQ6Vrgk7TCnVwVbcBNcCjZcZNje5Vp1c2U7LXFSWy
	 6J1BcZxB5C8FFxRfKlLPwloIbyPn58eQ/rbKpFumvD601JJ2+fNjKsiH4CWiXRwU2q
	 qPCd14yGW7VJPai9AyttIumUjC0lGvgLx6NQUMcrncTZUsgoUhaadKKg10/sn3evXP
	 u+vr+k7119Qmw==
Date: Thu, 8 Feb 2024 13:01:15 +0000
From: Lee Jones <lee@kernel.org>
To: Abdel Alkuor <alkuor@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	Alice Chen <alice_chen@richtek.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	ChiaEn Wu <chiaen_wu@richtek.com>, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: Add NCP5623 multi-led driver
Message-ID: <20240208130115.GM689448@google.com>
References: <20240203175910.301099-1-alkuor@gmail.com>
 <20240203175910.301099-2-alkuor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240203175910.301099-2-alkuor@gmail.com>

On Sat, 03 Feb 2024, Abdel Alkuor wrote:

> NCP5623 is DC-DC multi-LEDs driver with 94% peak

50 char lines look odd.  Please expand.

> efficiency. NCP5623 has three PWMs which can be
> programmed up to 32 steps giving 32768 colors hue.
> 
> NCP5623 driver supports gradual dimming upward/downward
> with programmable delay steps. Also, the driver supports
> driving a single LED or multi-LED like RGB.
> 
> Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> ---
>  .../sysfs-class-led-multicolor-driver-ncp5623 |  46 +++
>  drivers/leds/rgb/Kconfig                      |  11 +
>  drivers/leds/rgb/Makefile                     |   1 +
>  drivers/leds/rgb/leds-ncp5623.c               | 320 ++++++++++++++++++
>  4 files changed, 378 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-multicolor-driver-ncp5623
>  create mode 100644 drivers/leds/rgb/leds-ncp5623.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-led-multicolor-driver-ncp5623 b/Documentation/ABI/testing/sysfs-class-led-multicolor-driver-ncp5623
> new file mode 100644
> index 000000000000..6b9f4849852b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-led-multicolor-driver-ncp5623
> @@ -0,0 +1,46 @@
> +What:		/sys/class/leds/<led>/direction

Not sure I understand this interface.

Can't we take the direction by comparing the old and new brightness?

> +Date:		Feb 2024
> +KernelVersion:	6.8
> +Contact:	Abdel Alkuor <alkuor@gmail.com>
> +Description:
> +		Set gradual dimming direction which
> +		can be either none, up, or down.
> +		After setting the direction, brightness
> +		can be set using one of 31 steps.
> +
> +		==== ======== ==== ======== ==== ========
> +		Step ILED(mA) Step ILED(mA) Step ILED(mA)
> +		0    0        11   1.38      22   3.06
> +		1    0.92     12   1.45      23   3.45
> +		2    0.95     13   1.53      24   3.94
> +		3    0.98     14   1.62      25   4.60
> +		4    1.02     15   1.72      26   5.52
> +		5    1.06     16   1.84      27   6.90
> +		6    1.10     17   1.97      28   9.20
> +		7    1.15     18   2.12      29   13.80
> +		8    1.20     19   2.30      30   27.60
> +		9    1.25     20   2.50      31   27.60
> +		10   1.31     21   2.76
> +		==== ======== ==== ======== ==== ========
> +
> +What:		/sys/class/leds/<led>/dim_step

The step principle seems a bit arbitrary.

Why not provide the time directly?

dim_step_delay?

I already see documentation for risetime and falltime.

Perhaps that will omit the need for both direction and step?

> +Date:		Feb 2024
> +KernelVersion:	6.8
> +Contact:	Abdel Alkuor <alkuor@gmail.com>
> +Description:
> +		Set gradual dimming time.
> +
> +		==== ======== ==== ======== ==== ========
> +		Step Time(ms) Step Time(ms) Step Time(ms)
> +		0     0       11   88       22   176
> +		1     8       12   96       23   184
> +		2     16      13   104      24   192
> +		3     24      14   112      25   200
> +		4     32      15   120      26   208
> +		5     40      16   128      27   216
> +		6     48      17   136      28   224
> +		7     56      18   144      29   232
> +		8     64      19   152      30   240
> +		9     72      20   160      31   248
> +		10    80      21   168
> +		==== ======== ==== ======== ==== ========
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
> index 000000000000..e77dfca69ca3
> --- /dev/null
> +++ b/drivers/leds/rgb/leds-ncp5623.c
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * leds-ncp5623.c - Multi-LED Driver

Remove filenames they have a habit of becoming out of sync.


> + * Author: Abdel Alkuor <alkuor@gmail.com>
> + * Datasheet: https://www.onsemi.com/pdf/datasheet/ncp5623-d.pdf
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/sysfs.h>
> +#include <linux/workqueue.h>
> +
> +#include <linux/led-class-multicolor.h>
> +
> +#define NCP5623_REG(x)			((x) << 0x5)
> +
> +#define NCP5623_SHUTDOWN_REG		NCP5623_REG(0x0)
> +#define NCP5623_ILED_REG		NCP5623_REG(0x1)
> +#define NCP5623_PWM_REG(index)		NCP5623_REG(0x2 + (index))
> +#define NCP5623_UPWARD_STEP_REG		NCP5623_REG(0x5)
> +#define NCP5623_DOWNWARD_STEP_REG	NCP5623_REG(0x6)
> +#define NCP5623_DIMMING_TIME_REG	NCP5623_REG(0x7)
> +
> +#define NCP5623_MAX_BRIGHTNESS		0x1f
> +
> +enum {
> +	NCP5623_DIR_NONE,
> +	NCP5623_DIR_UPWARD,
> +	NCP5623_DIR_DOWNWARD,
> +};
> +
> +static const char *const directions[] = {
> +	[NCP5623_DIR_NONE]     = "none",

What does "none" do?

> +	[NCP5623_DIR_UPWARD]   = "up",
> +	[NCP5623_DIR_DOWNWARD] = "down",
> +};
> +
> +struct ncp5623 {
> +	struct i2c_client *client;
> +	struct led_classdev_mc mc_dev;
> +	struct mutex lock;
> +
> +	u8 direction;
> +	u8 dim_step;
> +	u8 old_brightness;
> +	unsigned long delay;
> +};
> +
> +static int ncp5623_write(struct i2c_client *client, u8 reg, u8 data)
> +{
> +	return i2c_smbus_write_byte_data(client, reg | data, 0);
> +}
> +
> +static inline unsigned long
> +ncp5623_get_completion_steps(u8 dir, int brightness, int old_brightness)
> +{

Why not pass in ncp and omit dir and old_brightness?

> +	int diff = brightness - old_brightness;
> +
> +	if (dir == NCP5623_DIR_UPWARD)
> +		return diff <= 1 ? NCP5623_MAX_BRIGHTNESS + diff : diff;
> +
> +	return diff >= -1 ? NCP5623_MAX_BRIGHTNESS - diff : -diff;
> +
> +}
> +
> +static int ncp5623_brightness_set(struct led_classdev *cdev,
> +				  enum led_brightness brightness)
> +{
> +	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
> +	struct ncp5623 *ncp = container_of(mc_cdev, struct ncp5623, mc_dev);
> +	int ret;
> +	u8 reg;
> +	int i;
+
> +	guard(mutex)(&ncp->lock);
> +
> +	if (ncp->delay && time_is_after_jiffies(ncp->delay))
> +		return -EBUSY;
> +
> +	ncp->delay = 0;
> +
> +	for (i = 0; i < mc_cdev->num_colors; i++) {

Looks like C++ style "for (int i" just became popular.

> +		ret = ncp5623_write(ncp->client,
> +				    NCP5623_PWM_REG(mc_cdev->subled_info[i].channel),
> +				    min(mc_cdev->subled_info[i].intensity,
> +					NCP5623_MAX_BRIGHTNESS));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	switch (ncp->direction) {
> +	case NCP5623_DIR_NONE:
> +		reg = NCP5623_ILED_REG;
> +		break;
> +	case NCP5623_DIR_UPWARD:
> +		reg = NCP5623_UPWARD_STEP_REG;
> +		break;
> +	case NCP5623_DIR_DOWNWARD:
> +		reg = NCP5623_DOWNWARD_STEP_REG;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = ncp5623_write(ncp->client, reg, brightness);
> +	if (ret)
> +		return ret;
> +
> +	if ((ncp->direction != NCP5623_DIR_NONE) && ncp->dim_step) {
> +		ret = ncp5623_write(ncp->client,
> +				    NCP5623_DIMMING_TIME_REG, ncp->dim_step);
> +		if (ret)
> +			return ret;
> +
> +		ncp->delay = ncp5623_get_completion_steps(ncp->direction,
> +							  brightness,
> +							  ncp->old_brightness);
> +		/* dim step resolution is 8ms */

Start comments with a capital letter.

> +		ncp->delay *= ncp->dim_step * 8;
> +		ncp->delay = msecs_to_jiffies(ncp->delay) + jiffies;
> +	}
> +
> +	ncp->old_brightness = brightness;
> +
> +	return 0;
> +}
> +
> +static ssize_t dim_step_store(struct device *dev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(dev_get_drvdata(dev));
> +	struct ncp5623 *ncp = container_of(mc_cdev, struct ncp5623, mc_dev);
> +	u8 value;
> +	int ret;
> +
> +	ret = kstrtou8(buf, 0, &value);
> +	if (ret)
> +		return ret;
> +
> +	if (value > 0x1f)
> +		return -EINVAL;
> +
> +	guard(mutex)(&ncp->lock);
> +	ncp->dim_step = value;
> +
> +	return count;
> +}
> +
> +static ssize_t dim_step_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(dev_get_drvdata(dev));
> +	struct ncp5623 *ncp = container_of(mc_cdev, struct ncp5623, mc_dev);
> +
> +	guard(mutex)(&ncp->lock);
> +
> +	return sysfs_emit(buf, "%u\n", ncp->dim_step);
> +}
> +
> +static ssize_t direction_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(dev_get_drvdata(dev));
> +	struct ncp5623 *ncp = container_of(mc_cdev, struct ncp5623, mc_dev);
> +	int ret;
> +
> +	ret = __sysfs_match_string(directions, ARRAY_SIZE(directions), buf);
> +
> +	switch (ret) {
> +	case NCP5623_DIR_NONE:
> +	case NCP5623_DIR_UPWARD:
> +	case NCP5623_DIR_DOWNWARD:
> +		guard(mutex)(&ncp->lock);
> +		ncp->direction = ret;

What's stopping you setting reg here?

> +		return count;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t direction_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(dev_get_drvdata(dev));
> +	struct ncp5623 *ncp = container_of(mc_cdev, struct ncp5623, mc_dev);
> +
> +	guard(mutex)(&ncp->lock);
> +
> +	return sysfs_emit(buf, "%s\n", directions[ncp->direction]);
> +}
> +
> +

Too many '\n's

> +static DEVICE_ATTR_RW(direction);
> +static DEVICE_ATTR_RW(dim_step);
> +
> +static struct attribute *ncp5623_led_attrs[] = {
> +	&dev_attr_direction.attr,
> +	&dev_attr_dim_step.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group ncp5623_led_group = {
> +	.attrs = ncp5623_led_attrs,
> +};
> +
> +static int ncp5623_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct fwnode_handle *mc_node, *led_node;
> +	struct led_init_data init_data = { };
> +	struct ncp5623 *ncp;
> +	struct mc_subled *subled_info;
> +	u32 color_index;
> +	u32 reg;
> +	int count = 0;

num_subleds?

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
> +		count++;
> +
> +	subled_info = devm_kcalloc(dev, count, sizeof(*subled_info), GFP_KERNEL);
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
> +
> +	mutex_init(&ncp->lock);
> +	i2c_set_clientdata(client, ncp);
> +
> +	ret = devm_led_classdev_multicolor_register_ext(dev, &ncp->mc_dev, &init_data);
> +	if (ret)
> +		goto destroy_lock;
> +
> +	ret = sysfs_update_group(&ncp->mc_dev.led_cdev.dev->kobj, &ncp5623_led_group);
> +	if (ret)
> +		goto destroy_lock;
> +
> +	fwnode_handle_put(mc_node);
> +
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
> +	ncp5623_write(client, NCP5623_SHUTDOWN_REG, 0);
> +	mutex_destroy(&ncp->lock);
> +}
> +
> +static void ncp5623_shutdown(struct i2c_client *client)
> +{
> +	ncp5623_write(client, NCP5623_SHUTDOWN_REG, 0);

No need to destroy the mutex?

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
> 

-- 
Lee Jones [李琼斯]

