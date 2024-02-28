Return-Path: <linux-kernel+bounces-84640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557C686A962
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C751C259D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3941425601;
	Wed, 28 Feb 2024 07:58:49 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707772561D;
	Wed, 28 Feb 2024 07:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709107128; cv=none; b=UKjtkNR0ynEwuyG3cJWII3UFx9bUQVeWwgDRdSHnI8KIwPsNkkUhO+R/QYG6F/EcWHxBV0Bl6tqN326ZjbHoQz1+ZPqHm62jPk4Jzf3HHc6uEneim+65b/MLLQaBeqCPJMbJdy4q+6kewe9GbAWVLDF6t6HF3hQeaqrtecfrw6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709107128; c=relaxed/simple;
	bh=rmMFVe8n8E6fMsZ/JPsq3ag7OpToruh15SVTTB6dkT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oum5PWbov8fxFHIhqQFRcT6IOy88ub/mCJ+J5QcCK0fA/8xTuCWPsgzoFRrkcKETVF1H4KJFLlk4Y+fC8Et01hKpLuRhZCdlEh9hloHvtrD/ua0A0MEZhb5+TZcPqu2XQhObhIwtMf2a8/VkK9ugJcWHYNPYrE1nK4CqW5qVz/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aedb1.dynamic.kabel-deutschland.de [95.90.237.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B501661E5FE04;
	Wed, 28 Feb 2024 08:57:46 +0100 (CET)
Message-ID: <62f38808-7d5f-4466-a65e-b6a64b2e7c01@molgen.mpg.de>
Date: Wed, 28 Feb 2024 08:57:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] hwmon: Driver for Nuvoton NCT7363Y
Content-Language: en-US
To: Ban Feng <baneric926@gmail.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, corbet@lwn.net,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 kcfeng0@nuvoton.com, kwliu@nuvoton.com, openbmc@lists.ozlabs.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 DELPHINE_CHIU@wiwynn.com, naresh.solanki@9elements.com,
 billy_tsai@aspeedtech.com
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com>
 <20240227005606.1107203-4-kcfeng0@nuvoton.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240227005606.1107203-4-kcfeng0@nuvoton.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Ban,


Thank you for your patch. Some minor things from my side.


Am 27.02.24 um 01:56 schrieb baneric926@gmail.com:
> From: Ban Feng <kcfeng0@nuvoton.com>
> 
> NCT7363Y is an I2C based hardware monitoring chip from Nuvoton.

Please reference the datasheet.

Could you please give a high level description of the driver design?

I’d also add a verb (in imperative mood) to the commit message summary, 
so it’s a statement:

Add driver for I2C chip Nuvoton NCT7363Y

> Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
> ---
>   Documentation/hwmon/index.rst   |   1 +
>   Documentation/hwmon/nct7363.rst |  33 +++
>   MAINTAINERS                     |   2 +
>   drivers/hwmon/Kconfig           |  11 +
>   drivers/hwmon/Makefile          |   1 +
>   drivers/hwmon/nct7363.c         | 412 ++++++++++++++++++++++++++++++++
>   6 files changed, 460 insertions(+)
>   create mode 100644 Documentation/hwmon/nct7363.rst
>   create mode 100644 drivers/hwmon/nct7363.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index c7ed1f73ac06..302f954b45be 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -165,6 +165,7 @@ Hardware Monitoring Kernel Drivers
>      mp5990
>      nct6683
>      nct6775
> +   nct7363
>      nct7802
>      nct7904
>      npcm750-pwm-fan
> diff --git a/Documentation/hwmon/nct7363.rst b/Documentation/hwmon/nct7363.rst
> new file mode 100644
> index 000000000000..89699c95aa4b
> --- /dev/null
> +++ b/Documentation/hwmon/nct7363.rst
> @@ -0,0 +1,33 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver nct7363
> +=====================
> +
> +Supported chip:
> +
> +  * Nuvoton NCT7363Y
> +
> +    Prefix: nct7363
> +
> +    Addresses: I2C 0x20, 0x21, 0x22, 0x23
> +
> +Author: Ban Feng <kcfeng0@nuvoton.com>
> +
> +
> +Description
> +-----------
> +
> +The NCT7363Y is a Fan controller which provides up to 16 independent

fan controller

> +FAN input monitors, and up to 16 independent PWM output with SMBus interface.

output*s*

> +
> +
> +Sysfs entries
> +-------------
> +
> +Currently, the driver supports the following features:
> +
> +======================= =======================================================
> +fanX_input		provide current fan rotation value in RPM
> +
> +pwmX			get or set PWM fan control value.
> +======================= =======================================================

In the diff view this does not align with the “holes”.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7b1efefed7c4..7ca66b713e30 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15089,6 +15089,8 @@ M:	Ban Feng <kcfeng0@nuvoton.com>
>   L:	linux-hwmon@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
> +F:	Documentation/hwmon/nct7363.rst
> +F:	drivers/hwmon/nct7363.c
>   
>   NETDEVSIM
>   M:	Jakub Kicinski <kuba@kernel.org>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index a608264da87d..a297b5409b04 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1616,6 +1616,17 @@ config SENSORS_NCT6775_I2C
>   	  This driver can also be built as a module. If so, the module
>   	  will be called nct6775-i2c.
>   
> +config SENSORS_NCT7363
> +	tristate "Nuvoton NCT7363Y"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for the Nuvoton NCT7363Y,

The comma is not needed.

> +	  hardware monitoring chip.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nct7363.
> +
>   config SENSORS_NCT7802
>   	tristate "Nuvoton NCT7802Y"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 47be39af5c03..d5e7531204df 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -167,6 +167,7 @@ obj-$(CONFIG_SENSORS_NCT6775_CORE) += nct6775-core.o
>   nct6775-objs			:= nct6775-platform.o
>   obj-$(CONFIG_SENSORS_NCT6775)	+= nct6775.o
>   obj-$(CONFIG_SENSORS_NCT6775_I2C) += nct6775-i2c.o
> +obj-$(CONFIG_SENSORS_NCT7363)	+= nct7363.o
>   obj-$(CONFIG_SENSORS_NCT7802)	+= nct7802.o
>   obj-$(CONFIG_SENSORS_NCT7904)	+= nct7904.o
>   obj-$(CONFIG_SENSORS_NPCM7XX)	+= npcm750-pwm-fan.o
> diff --git a/drivers/hwmon/nct7363.c b/drivers/hwmon/nct7363.c
> new file mode 100644
> index 000000000000..c79d3ca4f111
> --- /dev/null
> +++ b/drivers/hwmon/nct7363.c
> @@ -0,0 +1,412 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 Nuvoton Technology corporation.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#define NCT7363_REG_GPIO_0_3		0x20
> +#define NCT7363_REG_GPIO_4_7		0x21
> +#define NCT7363_REG_GPIO_10_13		0x22
> +#define NCT7363_REG_GPIO_14_17		0x23
> +#define NCT7363_REG_PWMEN_0_7		0x38
> +#define NCT7363_REG_PWMEN_8_15		0x39
> +#define NCT7363_REG_FANINEN_0_7		0x41
> +#define NCT7363_REG_FANINEN_8_15	0x42
> +#define NCT7363_REG_FANINX_HVAL(x)	(0x48 + ((x) * 2))
> +#define NCT7363_REG_FANINX_LVAL(x)	(0x49 + ((x) * 2))
> +#define NCT7363_REG_FSCPXDUTY(x)	(0x90 + ((x) * 2))
> +
> +#define PWM_SEL(x)			(BIT(0) << (((x) % 4) * 2))
> +#define FANIN_SEL(x)			(BIT(1) << (((x) % 4) * 2))
> +
> +#define NCT7363_FANINX_LVAL_MASK	GENMASK(4, 0)
> +#define NCT7363_FANIN_MASK		GENMASK(12, 0)
> +
> +#define NCT7363_PWM_COUNT		16
> +
> +static inline unsigned long FAN_FROM_REG(u16 val)
> +{
> +	/* In case fan is stopped or divide by 0 */
> +	if (val == NCT7363_FANIN_MASK || val == 0)

The comment seems redundant. Maybe also apply the mask to `val` and 
check the result.

> +		return	0;
> +
> +	return (1350000UL / val);

Why does the mask not to be applied to `val`?

> +}
> +
> +static const struct of_device_id nct7363_of_match[] = {
> +	{ .compatible = "nuvoton,nct7363" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, nct7363_of_match);
> +
> +struct nct7363_data {
> +	struct regmap		*regmap;
> +	struct mutex		lock; /* protect register access */
> +
> +	u16			fanin_mask;
> +	u16			pwm_mask;
> +};
> +
> +static int nct7363_read_fan(struct device *dev, u32 attr, int channel,
> +			    long *val)
> +{
> +	struct nct7363_data *data = dev_get_drvdata(dev);
> +	unsigned int hi, lo;
> +	u16 cnt, rpm;
> +	int ret = 0;
> +
> +	switch (attr) {
> +	case hwmon_fan_input:
> +		/*
> +		 * High-byte register should be read first to latch
> +		 * synchronous low-byte value
> +		 */
> +		ret = regmap_read(data->regmap,
> +				  NCT7363_REG_FANINX_HVAL(channel), &hi);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_read(data->regmap,
> +			NCT7363_REG_FANINX_LVAL(channel), &lo);
> +		if (ret)
> +			return ret;
> +
> +		cnt = (hi << 5) | (lo & NCT7363_FANINX_LVAL_MASK);
> +		rpm = FAN_FROM_REG(cnt);
> +		*val = (long)rpm;

Could `FAN_FROM_REG()` return long, so the cast here is not needed?

> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static umode_t nct7363_fan_is_visible(const void *_data, u32 attr, int channel)
> +{
> +	const struct nct7363_data *data = _data;
> +
> +	switch (attr) {
> +	case hwmon_fan_input:
> +		if (data->fanin_mask & BIT(channel))
> +			return 0444;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int nct7363_read_pwm(struct device *dev, u32 attr, int channel,
> +			    long *val)
> +{
> +	struct nct7363_data *data = dev_get_drvdata(dev);
> +	unsigned int regval;
> +	u16 ret;
> +
> +	switch (attr) {
> +	case hwmon_pwm_input:
> +		ret = regmap_read(data->regmap,
> +				  NCT7363_REG_FSCPXDUTY(channel), &regval);

     int regmap_read(struct regmap *map, unsigned int reg, unsigned int 
val);

So `ret` should be `int`?


Kind regards,

Paul


> +		if (ret)
> +			return ret;
> +
> +		*val = (long)regval;
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int nct7363_write_pwm(struct device *dev, u32 attr, int channel,
> +			     long val)
> +{
> +	struct nct7363_data *data = dev_get_drvdata(dev);
> +	int ret;
> +
> +	switch (attr) {
> +	case hwmon_pwm_input:
> +		if (val < 0 || val > 255)
> +			return -EINVAL;
> +
> +		mutex_lock(&data->lock);
> +		ret = regmap_write(data->regmap,
> +				   NCT7363_REG_FSCPXDUTY(channel), val);
> +		mutex_unlock(&data->lock);
> +
> +		return ret;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static umode_t nct7363_pwm_is_visible(const void *_data, u32 attr, int channel)
> +{
> +	const struct nct7363_data *data = _data;
> +
> +	switch (attr) {
> +	case hwmon_pwm_input:
> +		if (data->pwm_mask & BIT(channel))
> +			return 0644;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int nct7363_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int channel, long *val)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		return nct7363_read_fan(dev, attr, channel, val);
> +	case hwmon_pwm:
> +		return nct7363_read_pwm(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int nct7363_write(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long val)
> +{
> +	switch (type) {
> +	case hwmon_pwm:
> +		return nct7363_write_pwm(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static umode_t nct7363_is_visible(const void *data,
> +				  enum hwmon_sensor_types type,
> +				  u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		return nct7363_fan_is_visible(data, attr, channel);
> +	case hwmon_pwm:
> +		return nct7363_pwm_is_visible(data, attr, channel);
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static const struct hwmon_channel_info *nct7363_info[] = {
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT),
> +	HWMON_CHANNEL_INFO(pwm,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_ops nct7363_hwmon_ops = {
> +	.is_visible = nct7363_is_visible,
> +	.read = nct7363_read,
> +	.write = nct7363_write,
> +};
> +
> +static const struct hwmon_chip_info nct7363_chip_info = {
> +	.ops = &nct7363_hwmon_ops,
> +	.info = nct7363_info,
> +};
> +
> +static int nct7363_init_chip(struct nct7363_data *data)
> +{
> +	u8 i, gpio0_3 = 0, gpio4_7 = 0, gpio10_13 = 0, gpio14_17 = 0;
> +	int ret;
> +
> +	for (i = 0; i < NCT7363_PWM_COUNT; i++) {
> +		if (i < 4) {
> +			if (data->pwm_mask & BIT(i))
> +				gpio0_3 |= PWM_SEL(i);
> +			if (data->fanin_mask & BIT(i))
> +				gpio10_13 |= FANIN_SEL(i);
> +		} else if (i < 8) {
> +			if (data->pwm_mask & BIT(i))
> +				gpio4_7 |= PWM_SEL(i);
> +			if (data->fanin_mask & BIT(i))
> +				gpio14_17 |= FANIN_SEL(i);
> +		} else if (i < 12) {
> +			if (data->pwm_mask & BIT(i))
> +				gpio10_13 |= PWM_SEL(i);
> +			if (data->fanin_mask & BIT(i))
> +				gpio0_3 |= FANIN_SEL(i);
> +		} else {
> +			if (data->pwm_mask & BIT(i))
> +				gpio14_17 |= PWM_SEL(i);
> +			if (data->fanin_mask & BIT(i))
> +				gpio4_7 |= FANIN_SEL(i);
> +		}
> +	}
> +
> +	/* Pin Function Configuration */
> +	ret = regmap_write(data->regmap, NCT7363_REG_GPIO_0_3, gpio0_3);
> +	if (ret < 0)
> +		return ret;
> +	ret = regmap_write(data->regmap, NCT7363_REG_GPIO_4_7, gpio4_7);
> +	if (ret < 0)
> +		return ret;
> +	ret = regmap_write(data->regmap, NCT7363_REG_GPIO_10_13, gpio10_13);
> +	if (ret < 0)
> +		return ret;
> +	ret = regmap_write(data->regmap, NCT7363_REG_GPIO_14_17, gpio14_17);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* PWM and FANIN Monitoring Enable */
> +	ret = regmap_write(data->regmap, NCT7363_REG_PWMEN_0_7,
> +			   data->pwm_mask & 0xff);
> +	if (ret < 0)
> +		return ret;
> +	ret = regmap_write(data->regmap, NCT7363_REG_PWMEN_8_15,
> +			   (data->pwm_mask >> 8) & 0xff);
> +	if (ret < 0)
> +		return ret;
> +	ret = regmap_write(data->regmap, NCT7363_REG_FANINEN_0_7,
> +			   data->fanin_mask & 0xff);
> +	if (ret < 0)
> +		return ret;
> +	ret = regmap_write(data->regmap, NCT7363_REG_FANINEN_8_15,
> +			   (data->fanin_mask >> 8) & 0xff);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int nct7363_present_pwm_fanin(struct device *dev,
> +				     struct device_node *child,
> +				     struct nct7363_data *data)
> +{
> +	struct of_phandle_args args;
> +	int ret, fanin_cnt;
> +	u8 *fanin_ch;
> +	u8 ch, index;
> +
> +	ret = of_parse_phandle_with_args(child, "pwms", "#pwm-cells",
> +					 0, &args);
> +	if (ret)
> +		return ret;
> +
> +	data->pwm_mask |= BIT(args.args[0]);
> +
> +	fanin_cnt = of_property_count_u8_elems(child, "tach-ch");
> +	if (fanin_cnt < 1)
> +		return -EINVAL;
> +
> +	fanin_ch = devm_kcalloc(dev, fanin_cnt, sizeof(*fanin_ch), GFP_KERNEL);
> +	if (!fanin_ch)
> +		return -ENOMEM;
> +
> +	ret = of_property_read_u8_array(child, "tach-ch", fanin_ch, fanin_cnt);
> +	if (ret)
> +		return ret;
> +
> +	for (ch = 0; ch < fanin_cnt; ch++) {
> +		index = fanin_ch[ch];
> +		data->fanin_mask |= BIT(index);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct regmap_config nct7363_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static int nct7363_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct device_node *child;
> +	struct nct7363_data *data;
> +	struct device *hwmon_dev;
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->regmap = devm_regmap_init_i2c(client, &nct7363_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return PTR_ERR(data->regmap);
> +
> +	mutex_init(&data->lock);
> +
> +	for_each_child_of_node(dev->of_node, child) {
> +		ret = nct7363_present_pwm_fanin(dev, child, data);
> +		if (ret) {
> +			of_node_put(child);
> +			return ret;
> +		}
> +	}
> +
> +	/* Initialize the chip */
> +	ret = nct7363_init_chip(data);
> +	if (ret)
> +		return ret;
> +
> +	hwmon_dev =
> +		devm_hwmon_device_register_with_info(dev, client->name, data,
> +						     &nct7363_chip_info, NULL);
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static struct i2c_driver nct7363_driver = {
> +	.class = I2C_CLASS_HWMON,
> +	.driver = {
> +		.name = "nct7363",
> +		.of_match_table = nct7363_of_match,
> +	},
> +	.probe = nct7363_probe,
> +};
> +
> +module_i2c_driver(nct7363_driver);
> +
> +MODULE_AUTHOR("CW Ho <cwho@nuvoton.com>");
> +MODULE_AUTHOR("Ban Feng <kcfeng0@nuvoton.com>");
> +MODULE_DESCRIPTION("NCT7363 Hardware Monitoring Driver");
> +MODULE_LICENSE("GPL");

