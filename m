Return-Path: <linux-kernel+bounces-18583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC44825FBC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5601F2249E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 13:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0C47496;
	Sat,  6 Jan 2024 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="TycST3He"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB4279C3;
	Sat,  6 Jan 2024 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id M7BVr2yKtEoWxM7BVrkYrO; Sat, 06 Jan 2024 14:57:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704549478;
	bh=5+DV8oxdafXMalKMMxvfVdg2F/E7Ox7KYUXojGKS/zk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TycST3HeQPw2Gzh/DrxYr6RjHpB9lcY9u7UCYdodMrltrfinSETlcddYqCS/sre5x
	 QL/l0UiEcz3KpsbkLG/XQgIzQJBnjF58cEmvw7Q1GlE5KVSvqP4it8FBuXn9NnnoyS
	 XEevVUibRLYnuEc6ij8BCyt8fyKy2Ek8xs1swDChOJgQF2J0R21mqEyLxPd+0BW/qs
	 lxjY1OEeHOWmIQSy9NhXINEzKdzUi6mwajG7W4mf4Vz7iNmfoh0v6AEXS/Py1a43ad
	 7LbKut14pD1xdfGSXSfBquyQ8wVgSNu4c2ofQOkuWkEPn3WOhbwPKxYwJsmDm2q7Q6
	 wx3uy8du/ojtQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 06 Jan 2024 14:57:58 +0100
X-ME-IP: 92.140.202.140
Message-ID: <46bba29c-330d-417d-ad84-ceb5207fdb55@wanadoo.fr>
Date: Sat, 6 Jan 2024 14:57:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] power: supply: Add STC3117 fuel gauge unit driver
Content-Language: fr
To: bhavin.sharma@siliconsignals.io
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, robh+dt@kernel.org, sre@kernel.org
References: <20240106101435.2927116-1-bhavin.sharma@siliconsignals.io>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240106101435.2927116-1-bhavin.sharma@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 06/01/2024 à 11:14, Bhavin Sharma a écrit :
> Adding support for stc3117 fuel gauge driver with
> minimal functionality to read voltage level currently
> 
> Signed-off-by: Bhavin Sharma <bhavin.sharma-TXG9oGKWPboh9/7i5KS7/GGXanvQGlWp@public.gmane.org>
> ---

Hi,

>   drivers/power/supply/Kconfig              |   7 ++
>   drivers/power/supply/Makefile             |   1 +
>   drivers/power/supply/stc3117_fuel_gauge.c | 136 ++++++++++++++++++++++
>   3 files changed, 144 insertions(+)
>   create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index f21cb05815ec..02df55b0d5f0 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -875,6 +875,13 @@ config FUEL_GAUGE_SC27XX
>   	  Say Y here to enable support for fuel gauge with SC27XX
>   	  PMIC chips.
>   
> +config FUEL_GAUGE_STC3117
> +	tristate "STMicroelectronics STC3117 fuel gauge driver"
> +	depends on I2C
> +	help
> +	  Say Y here to enable support for fuel gauge with STC3117
> +	  PMIC chips.
> +
>   config CHARGER_UCS1002
>   	tristate "Microchip UCS1002 USB Port Power Controller"
>   	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 58b567278034..f8ed3e5a8882 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -104,6 +104,7 @@ obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
>   obj-$(CONFIG_CHARGER_CROS_PCHG)	+= cros_peripheral_charger.o
>   obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
>   obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
> +obj-$(CONFIG_FUEL_GAUGE_STC3117)	+= stc3117_fuel_gauge.o
>   obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
>   obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
>   obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
> diff --git a/drivers/power/supply/stc3117_fuel_gauge.c b/drivers/power/supply/stc3117_fuel_gauge.c
> new file mode 100644
> index 000000000000..bb033ac54858
> --- /dev/null
> +++ b/drivers/power/supply/stc3117_fuel_gauge.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * stc3117_fuel_gauge.c - STMicroelectronics STC3117 Fuel Gauge Driver
> + *
> + * Copyright (c) 2024 Silicon Signals Pvt Ltd.
> + * Author:      Bhavin Sharma <bhavin.sharma-TXG9oGKWPboh9/7i5KS7/GGXanvQGlWp@public.gmane.org>
> + *              Hardevsinh Palaniya <hardevsinh.palaniya-TXG9oGKWPbrc8hPZMNZi9dBPR1lH4CV8@public.gmane.org>
> + */
> +
> +

Only 1 NL is enough.

> +#include <linux/i2c.h>
> +#include <linux/i2c-dev.h>
> +#include <linux/kernel.h>

Is it really needed for a small driver like this?

> +#include <linux/module.h>
> +#include <linux/uaccess.h>
> +#include <linux/power_supply.h>

Keep alphabetical order.

> +
> +#define VOLTAGE_REG_ADDR	0x08
> +#define VOLTAGE_REG_ADDR_SIZE	1		//in bytes
> +#define VOLTAGE_DATA_SIZE	2		//in bytes
> +#define LSB_VALUE		2200		//in micro-volts
> +
> +
> +static int stc3117_probe(struct i2c_client *client);
> +static void stc3117_dev_remove(struct i2c_client *client);

If struct i2c_driver stc3117_i2c_driver was declared at the end of the 
fine, these prototypes could be removed.

> +
> +static int stc3117_get_property(struct power_supply *psy,
> +	enum power_supply_property psp, union power_supply_propval *val);
> +static int stc3117_get_batt_volt(const struct i2c_client *client);

Same here.
I think that a different ordering could avoid these prototypes.

> +
> +const struct i2c_client *tmp_client;
> +struct power_supply *stc_sply;
> +
> +static const struct of_device_id stc3117_of_match[] = {
> +	{ .compatible = "st,stc3117-fgu" },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, stc3117_of_match);
> +
> +static const struct i2c_device_id stc3117_id[] = {
> +	{"stc3117", 0},
> +	{},
> +};
> +
> +

Only 1 NL is enough.

> +MODULE_DEVICE_TABLE(i2c, stc3117_id);
> +
> +struct i2c_driver stc3117_i2c_driver = {
> +	.driver = {
> +		.name = "stc3117_i2c_driver",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(stc3117_of_match),
> +	},
> +	.probe = stc3117_probe,
> +	.id_table = stc3117_id,
> +	.remove = stc3117_dev_remove,
> +};
> +
> +

Only 1 NL is enough.

> +static enum power_supply_property stc3117_battery_props[] = {
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +};
> +
> +static const struct power_supply_desc stc3117_battery_desc = {
> +	.name = "stc3117-battery",
> +	.type = POWER_SUPPLY_TYPE_BATTERY,
> +	.get_property = stc3117_get_property,
> +	.properties = stc3117_battery_props,
> +	.num_properties = ARRAY_SIZE(stc3117_battery_props),
> +};
> +
> +static int stc3117_get_property(struct power_supply *psy,
> +	enum power_supply_property psp, union power_supply_propval *val)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval = stc3117_get_batt_volt(tmp_client);
> +	break;

This break should be indented by 1 more tab.

> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +

Only 1 NL is enough.

> +static int stc3117_get_batt_volt(const struct i2c_client *stc_client)
> +{
> +	int ret, volt = 0;
> +	char i2c_tx = VOLTAGE_REG_ADDR, i2c_rx[2] = {0};

Maybe VOLTAGE_DATA_SIZE, instead of 2?

> +
> +	ret = i2c_master_send(stc_client, &i2c_tx, VOLTAGE_REG_ADDR_SIZE);
> +	if (ret > 0) {
> +
> +		ret = i2c_master_recv(stc_client, i2c_rx, VOLTAGE_DATA_SIZE);
> +		if (ret > 0) {
> +
> +			volt = (i2c_rx[1] << 8) + i2c_rx[0];
> +			volt *= LSB_VALUE;
> +
> +			return volt;
> +		}
> +	}
> +
> +	return ret;
> +}

Writting it as:
   ret = i2c_master_send()
   if (ret < 0)
	return ret;

   ret = i2c_master_recv();
   if (ret < 0)
	return ret;

   vols = ...

would save some indentation.

> +
> +static int stc3117_probe(struct i2c_client *client)
> +{
> +	struct power_supply_config psy_cfg = {};
> +	struct device *dev;
> +
> +	dev = &client->dev;
> +
> +	psy_cfg.of_node = dev->of_node;
> +
> +	tmp_client = client;
> +
> +	stc_sply = power_supply_register(dev, &stc3117_battery_desc, &psy_cfg);

devm_power_supply_register() ?
This would remove the need of the .remove() function.

> +	if (IS_ERR(stc_sply))
> +		pr_err("failed to register battery\n");

dev_err()?

Maybe this error code should be propagated. What the point of this 
driver if this function fails?

just my 2c,

CJ

> +
> +	return 0;
> +}
> +
> +static void stc3117_dev_remove(struct i2c_client *client)
> +{
> +	power_supply_unregister(stc_sply);
> +}
> +
> +module_i2c_driver(stc3117_i2c_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Bhavin Sharma <bhavin.sharma-TXG9oGKWPboh9/7i5KS7/GGXanvQGlWp@public.gmane.org>");
> +MODULE_AUTHOR("Hardevsinh Palaniya <hardevsinh.palaniya-TXG9oGKWPboh9/7i5KS7/GGXanvQGlWp@public.gmane.org>");
> +MODULE_DESCRIPTION("STC3117 Fuel Gauge Driver");
> +MODULE_VERSION("v1.0");
> +


