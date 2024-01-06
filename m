Return-Path: <linux-kernel+bounces-18663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 115588260B5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE735282DFE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE34C8BFD;
	Sat,  6 Jan 2024 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nw3cE7fk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735468831
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55745901085so653077a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 08:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704559932; x=1705164732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sVqediJv1KtA2x3sKI/uoMPOfqw0gkrUK/6P+U5oMOg=;
        b=nw3cE7fk0HPriSExHLi/9U+3bbLq1vDIbHtCO/wFk5zLykdlLxBYJO7P6pC1Bj8uzY
         8ZtyxUhDTdmwUmbC2oDsLZNAnAKYc5sH4DcsjrkFo5MXbIiegyars23y8cQXUNCvHIk9
         NHRn/iNEdJpS9EEB93j4+U40S+iYswXp8ZR25uOD1nXTM+mIU8sqAq0ghCi5bqsOcXgb
         nCy8xABSLJmDge64Tl1x2QTUKhmPv0uUPr7fjuNKLi7PVWgmDt6CHvPw0eoaa/cEsgmk
         WE2yogTRoK6AFzkbKtqatERsxoKx1GwSLMgg80c+o0pZcn6CYFt8lV3AbZ8+OwrD6dqJ
         PM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704559932; x=1705164732;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVqediJv1KtA2x3sKI/uoMPOfqw0gkrUK/6P+U5oMOg=;
        b=E9QImhGkX4ad1AK9/TE+AgR1UI1XFahBaZPiPZcNFhJe93p5IPAafBA1m1Kj3VDhjv
         eV+GmdjJbhCYfne5IspQo11A4X4/k3KPO01A246SADqi+ossV1OiypMSBkHyNgzrzrJI
         tMQ7Dxd0ca5f2OLFl73sipw+0LJLMOUwTNB/bV9KkmH6sKMU9tSCJt7FeJxlHiPSccci
         v4wxDJohL3mfbUnvwk5GWVMUF6sTnok2TgBS911fhLAsd1MOIJeFBdUMlvSZcxRUHMFy
         1FpLrfPg+On8imZvV2lVUDGgIuw5P4cwLcmFLID+EZ+btUMklT1t7zqcmk/5zUp/S/Qm
         soXg==
X-Gm-Message-State: AOJu0YwKAuAQHfsl15HhFflvXanjueUngiGZVsj4x494+/3byiC8uFlU
	UpdE7KOSLp/OjQyoKKkAV7Y9N5+Y6Iy6Eg==
X-Google-Smtp-Source: AGHT+IEwE+tUD3w27m962Osls9KLTIhEGVUkCOS+7sNsnJYqGJpW97OkLMyRZEvtdb7PI3t/YFVsFg==
X-Received: by 2002:a17:906:16d5:b0:a27:8953:a70f with SMTP id t21-20020a17090616d500b00a278953a70fmr495612ejd.70.1704559931675;
        Sat, 06 Jan 2024 08:52:11 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id ez5-20020a1709070bc500b00a2a09be8a2dsm490926ejc.114.2024.01.06.08.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jan 2024 08:52:11 -0800 (PST)
Message-ID: <6f7e65e8-ae83-4f92-b931-a56328d6ad87@linaro.org>
Date: Sat, 6 Jan 2024 17:52:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] power: supply: Add STC3117 fuel gauge unit driver
Content-Language: en-US
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>, sre@kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240106133546.936261-1-bhavin.sharma@siliconsignals.io>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240106133546.936261-1-bhavin.sharma@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/01/2024 14:35, Bhavin Sharma wrote:
> Adding support for stc3117 fuel gauge driver with
> minimal functionality to read voltage level currently
> 
> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> ---
>  drivers/power/supply/Kconfig              |   7 ++
>  drivers/power/supply/Makefile             |   1 +
>  drivers/power/supply/stc3117_fuel_gauge.c | 136 ++++++++++++++++++++++
>  3 files changed, 144 insertions(+)
>  create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index f21cb0581..02df55b0d 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -875,6 +875,13 @@ config FUEL_GAUGE_SC27XX
>  	  Say Y here to enable support for fuel gauge with SC27XX
>  	  PMIC chips.
>  
> +config FUEL_GAUGE_STC3117
> +	tristate "STMicroelectronics STC3117 fuel gauge driver"
> +	depends on I2C
> +	help
> +	  Say Y here to enable support for fuel gauge with STC3117
> +	  PMIC chips.
> +
>  config CHARGER_UCS1002
>  	tristate "Microchip UCS1002 USB Port Power Controller"
>  	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 58b567278..f8ed3e5a8 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -104,6 +104,7 @@ obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
>  obj-$(CONFIG_CHARGER_CROS_PCHG)	+= cros_peripheral_charger.o
>  obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
>  obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
> +obj-$(CONFIG_FUEL_GAUGE_STC3117)	+= stc3117_fuel_gauge.o
>  obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
>  obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
>  obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
> diff --git a/drivers/power/supply/stc3117_fuel_gauge.c b/drivers/power/supply/stc3117_fuel_gauge.c
> new file mode 100644
> index 000000000..bf87bc1b9
> --- /dev/null
> +++ b/drivers/power/supply/stc3117_fuel_gauge.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * stc3117_fuel_gauge.c - STMicroelectronics STC3117 Fuel Gauge Driver
> + *
> + * Copyright (c) 2024 Silicon Signals Pvt Ltd.
> + * Author:      Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> + *              Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.com>
> + */
> +
> +

Just one blank line

> +#include <linux/i2c.h>
> +#include <linux/i2c-dev.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/uaccess.h>
> +#include <linux/power_supply.h>
> +
> +#define VOLTAGE_REG_ADDR	0x08
> +#define VOLTAGE_REG_ADDR_SIZE	1		//in bytes
> +#define VOLTAGE_DATA_SIZE	2		//in bytes
> +#define LSB_VALUE		2200		//in micro-volts

LSB of what? This is very poor naming.


Missing spaces after //

> +
> +

One blank line

> +static int stc3117_probe(struct i2c_client *client);
> +static void stc3117_dev_remove(struct i2c_client *client);
> +
> +static int stc3117_get_property(struct power_supply *psy,
> +	enum power_supply_property psp, union power_supply_propval *val);
> +static int stc3117_get_batt_volt(const struct i2c_client *client);

Drop all these.

> +
> +const struct i2c_client *tmp_client;

Drop

> +struct power_supply *stc_sply;

Drop

> +
> +static const struct of_device_id stc3117_of_match[] = {

This goes next to driver structure.

> +	{ .compatible = "st,stc3117-fgu" },
> +	{},
> +};
> +

No blank line

> +MODULE_DEVICE_TABLE(of, stc3117_of_match);
> +
> +static const struct i2c_device_id stc3117_id[] = {

The same.

> +	{"stc3117", 0},
> +	{},
> +};
> +
> +

No blank lines

> +MODULE_DEVICE_TABLE(i2c, stc3117_id);
> +
> +struct i2c_driver stc3117_i2c_driver = {

Where did you place it? Open existing drivers and see how it is done.

> +	.driver = {
> +		.name = "stc3117_i2c_driver",
> +		.owner = THIS_MODULE,

Drop, ok, this is some ancient vendor driver which you just send
upstream. Sorry, no. You must clean it from all that ancient cruft.

You must run smatch, sparse and coccinelle/coccicheck.

> +		.of_match_table = of_match_ptr(stc3117_of_match),

Drop of_match_ptr

> +	},
> +	.probe = stc3117_probe,
> +	.id_table = stc3117_id,
> +	.remove = stc3117_dev_remove,
> +};
> +
> +
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
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +

What's with this double blank lines?

> +static int stc3117_get_batt_volt(const struct i2c_client *stc_client)
> +{
> +	int ret, volt = 0;
> +	char i2c_tx = VOLTAGE_REG_ADDR, i2c_rx[2] = {0};
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

devm

> +	if (IS_ERR(stc_sply))
> +		pr_err("failed to register battery\n");

dev_err

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
> +MODULE_AUTHOR("Bhavin Sharma <bhavin.sharma@siliconsignals.io>");
> +MODULE_AUTHOR("Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>");
> +MODULE_DESCRIPTION("STC3117 Fuel Gauge Driver");

Best regards,
Krzysztof


