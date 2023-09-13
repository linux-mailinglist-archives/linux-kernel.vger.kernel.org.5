Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826F379EDB5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjIMPwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjIMPwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:52:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D316E54;
        Wed, 13 Sep 2023 08:52:32 -0700 (PDT)
Received: from mercury (dyndsl-091-248-208-175.ewe-ip-backbone.de [91.248.208.175])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 02456660733C;
        Wed, 13 Sep 2023 16:52:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694620350;
        bh=209wXsxSZBrcXc1sF/cqq9MwjzpBMifpYz5borqlIIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VoISHmQU2fkCjS9EiyA3Iy4z8b3lfiZypGySs1VuXDmcuWHPaGZTqUzyRVSMgdVlo
         EuHslf5fSbR9SgzOGjGUdauhMmDp/j/8vmfJvI/BXKUHkspMTr3nj+gtSHNDQQZkbo
         EyLJ5YHubJ3/CHByYdvPJL3+bZzdOgEuQbz7opOtXhdnpAmXscgwoYjz1tDVFfLXA1
         BwtVxxf3s6kc4dzVnfRs6Rv6LEjOSprfbPEsafu8JXH0aPoxwLkzqUFu5XJ1LFKsso
         mSh+gTBLd11Cwqy+c70LQtyfl50Aq+7BaJ0ZM20I5w1t/nSUUtXUBGW76Q1dp2GqY0
         wp4NQMM2klFkQ==
Received: by mercury (Postfix, from userid 1000)
        id AF85F106098A; Wed, 13 Sep 2023 17:45:52 +0200 (CEST)
Date:   Wed, 13 Sep 2023 17:45:52 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH RESEND v2 3/3] power: supply: Introduce MM8013 fuel gauge
 driver
Message-ID: <20230913154552.okinfq6gdxf2d7ab@mercury.elektranox.org>
References: <20230621-topic-mm8013-v2-0-9f1b41f4bc06@linaro.org>
 <20230621-topic-mm8013-v2-3-9f1b41f4bc06@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3m4hn2luzy5bgxji"
Content-Disposition: inline
In-Reply-To: <20230621-topic-mm8013-v2-3-9f1b41f4bc06@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3m4hn2luzy5bgxji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 23, 2023 at 04:36:15PM +0200, Konrad Dybcio wrote:
> Add a driver for the Mitsumi MM8013 fuel gauge. The driver is a vastly
> cleaned up and improved version of the one that shipped in some obscure
> Lenovo downstream kernel [1], with some register definitions borrowed from
> ChromeOS EC platform code [2].
>=20
> [1] https://github.com/adazem009/kernel_lenovo_bengal/commit/b6b346427a87=
1715709bd22aae449b9383f3b66b
> [2] https://chromium.googlesource.com/chromiumos/platform/ec/+/master/dri=
ver/battery/mm8013.h
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  MAINTAINERS                   |   5 +
>  drivers/power/supply/Kconfig  |   9 ++
>  drivers/power/supply/Makefile |   1 +
>  drivers/power/supply/mm8013.c | 283 ++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 298 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5ce188b58eaa..ba5f075a2ca8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14296,6 +14296,11 @@ W:	https://linuxtv.org
>  T:	git git://linuxtv.org/media_tree.git
>  F:	drivers/media/radio/radio-miropcm20*
> =20
> +MITSUMI MM8013 FG DRIVER
> +M:	Konrad Dybcio <konradybcio@kernel.org>
> +F:	Documentation/devicetree/bindings/power/supply/mitsumi,mm8013.yaml
> +F:	drivers/power/supply/mm8013.c
> +
>  MMP SUPPORT
>  R:	Lubomir Rintel <lkundrak@v3.sk>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 663a1c423806..c19e8287d80f 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -951,4 +951,13 @@ config CHARGER_QCOM_SMB2
>  	  adds support for the SMB2 switch mode battery charger found
>  	  in PMI8998 and related PMICs.
> =20
> +config FUEL_GAUGE_MM8013
> +	tristate "Mitsumi MM8013 fuel gauge driver"
> +	depends on I2C
> +	help
> +	  Say Y here to enable the Mitsumi MM8013 fuel gauge driver.
> +	  It enables the monitoring of many battery parameters, including
> +	  the state of charge, temperature, cycle count, actual and design
> +	  capacity, etc.
> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index a8a9fa6de1e9..ba2c41f060be 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -111,3 +111,4 @@ obj-$(CONFIG_BATTERY_SURFACE)	+=3D surface_battery.o
>  obj-$(CONFIG_CHARGER_SURFACE)	+=3D surface_charger.o
>  obj-$(CONFIG_BATTERY_UG3105)	+=3D ug3105_battery.o
>  obj-$(CONFIG_CHARGER_QCOM_SMB2)	+=3D qcom_pmi8998_charger.o
> +obj-$(CONFIG_FUEL_GAUGE_MM8013)	+=3D mm8013.o
> diff --git a/drivers/power/supply/mm8013.c b/drivers/power/supply/mm8013.c
> new file mode 100644
> index 000000000000..ce20c6078116
> --- /dev/null
> +++ b/drivers/power/supply/mm8013.c
> @@ -0,0 +1,283 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2016-2019 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023, Linaro Limited
> + */
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/power_supply.h>
> +
> +#define REG_BATID			0x00 /* This one is very unclear */
> + #define BATID_101			0x0101 /* 107kOhm */
> + #define BATID_102			0x0102 /* 10kOhm */
> +#define REG_TEMPERATURE			0x06
> +#define REG_VOLTAGE			0x08
> +#define REG_FLAGS			0x0a
> + #define MM8013_FLAG_OTC		BIT(15)
> + #define MM8013_FLAG_OTD		BIT(14)
> + #define MM8013_FLAG_BATHI		BIT(13)
> + #define MM8013_FLAG_FC			BIT(9)
> + #define MM8013_FLAG_CHG		BIT(8)
> + #define MM8013_FLAG_DSG		BIT(0)
> +#define REG_FULL_CHARGE_CAPACITY	0x0e
> +#define REG_AVERAGE_CURRENT		0x14
> +#define REG_AVERAGE_TIME_TO_EMPTY	0x16
> +#define REG_AVERAGE_TIME_TO_FULL	0x18
> +#define REG_CYCLE_COUNT			0x2a
> +#define REG_STATE_OF_CHARGE		0x2c
> +#define REG_DESIGN_CAPACITY		0x3c
> +/* TODO: 0x62-0x68 seem to contain 'MM8013C' in a length-prefixed, non-t=
erminated string */
> +
> +#define DECIKELVIN_TO_DECIDEGC(t)	(t - 2731)
> +
> +struct mm8013_chip {
> +	struct i2c_client *client;
> +};
> +
> +static int mm8013_write_reg(struct i2c_client *client, u8 reg, u16 value)
> +{
> +	int ret;
> +
> +	ret =3D i2c_smbus_write_word_data(client, reg, value);
> +	if (ret < 0)
> +		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
> +
> +	usleep_range(4000, 5000);
> +	return ret;
> +}
> +
> +static int mm8013_read_reg(struct i2c_client *client, u8 reg)
> +{
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_word_data(client, reg);
> +	if (ret < 0)
> +		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
> +
> +	usleep_range(4000, 5000);
> +	return ret;
> +}

Please use regmap.

> +static int mm8013_checkdevice(struct mm8013_chip *chip)
> +{
> +	int battery_id, ret;
> +
> +	ret =3D mm8013_write_reg(chip->client, REG_BATID, 0x0008);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D mm8013_read_reg(chip->client, REG_BATID);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret =3D=3D BATID_102)
> +		battery_id =3D 2;
> +	else if (ret =3D=3D BATID_101)
> +		battery_id =3D 1;
> +	else
> +		return -EINVAL;
> +
> +	dev_dbg(&chip->client->dev, "battery_id: %d\n", battery_id);
> +
> +	return 0;
> +}
> +
> +static enum power_supply_property mm8013_battery_props[] =3D {
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CYCLE_COUNT,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
> +	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +};
> +
> +static int mm8013_get_property(struct power_supply *psy,
> +			       enum power_supply_property psp,
> +			       union power_supply_propval *val)
> +{
> +	struct mm8013_chip *chip =3D psy->drv_data;
> +	struct i2c_client *client =3D chip->client;
> +	int ret =3D 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CAPACITY:

this is in %, while the next two are in uAh. So the fuel gauge does
not provide the current capacity in uAh
(POWER_SUPPLY_PROP_CHARGE_NOW)?

> +		ret =3D mm8013_read_reg(client, REG_STATE_OF_CHARGE);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL:
> +		ret =3D mm8013_read_reg(client, REG_FULL_CHARGE_CAPACITY);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +		ret =3D mm8013_read_reg(client, REG_DESIGN_CAPACITY);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret =3D mm8013_read_reg(client, REG_AVERAGE_CURRENT);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (ret > S16_MAX)
> +			val->intval -=3D (1 << 16);
> +		else
> +			val->intval =3D ret;

this is just 'val->intval =3D (s16) ret;'.

> +		val->intval *=3D -1000;

and this seems to be the only property, that properly scales its
values, assuming the hardware reports data in mA.

> +		break;
> +	case POWER_SUPPLY_PROP_CYCLE_COUNT:
> +		ret =3D mm8013_read_reg(client, REG_CYCLE_COUNT);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		ret =3D mm8013_read_reg(client, REG_FLAGS);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (ret & MM8013_FLAG_BATHI)
> +			val->intval =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +		else if (ret & (MM8013_FLAG_OTD | MM8013_FLAG_OTC))
> +			val->intval =3D POWER_SUPPLY_HEALTH_OVERHEAT;
> +		else
> +			val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
> +		break;
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval =3D mm8013_read_reg(client, REG_TEMPERATURE) > 0;
> +		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		ret =3D mm8013_read_reg(client, REG_FLAGS);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (ret & MM8013_FLAG_DSG)
> +			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		else if (ret & MM8013_FLAG_CHG)
> +			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +		else if (ret & MM8013_FLAG_FC)
> +			val->intval =3D POWER_SUPPLY_STATUS_FULL;
> +		else
> +			val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP:
> +		ret =3D mm8013_read_reg(client, REG_TEMPERATURE);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D DECIKELVIN_TO_DECIDEGC(ret);
> +		break;
> +	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
> +		ret =3D mm8013_read_reg(client, REG_AVERAGE_TIME_TO_EMPTY);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* The estimation is not yet ready */
> +		if (ret =3D=3D U16_MAX)
> +			return -ENODATA;
> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
> +		ret =3D mm8013_read_reg(client, REG_AVERAGE_TIME_TO_FULL);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* The estimation is not yet ready */
> +		if (ret =3D=3D U16_MAX)
> +			return -ENODATA;
> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:

that's in **micro** volts

> +		ret =3D mm8013_read_reg(client, REG_VOLTAGE);

this effectively does i2c_smbus_read_word_data() and thus the
maximum is is 65536. 65536uV =3D 65mV. I have serious doubts, that
this code does what you want. The same is true for a couple of
the other properties.

> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct power_supply_desc mm8013_desc =3D {
> +	.name			=3D "mm8013",
> +	.type			=3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties		=3D mm8013_battery_props,
> +	.num_properties		=3D ARRAY_SIZE(mm8013_battery_props),
> +	.get_property		=3D mm8013_get_property,
> +};
> +
> +static int mm8013_probe(struct i2c_client *client)
> +{
> +	struct power_supply_config psy_cfg =3D {};
> +	struct device *dev =3D &client->dev;
> +	struct power_supply *psy;
> +	struct mm8013_chip *chip;
> +	int ret =3D 0;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> +		return dev_err_probe(dev, -EIO,
> +				     "I2C_FUNC_SMBUS_WORD_DATA not supported\n");
> +
> +	chip =3D devm_kzalloc(dev, sizeof(struct mm8013_chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->client =3D client;
> +
> +	ret =3D mm8013_checkdevice(chip);
> +	if (ret)
> +		return dev_err_probe(dev, -ENODEV, "MM8013 not found\n");

dev_err_probe(dev, ret, ... ?

> +
> +	psy_cfg.drv_data =3D chip;
> +	psy_cfg.of_node =3D dev->of_node;
> +
> +	psy =3D devm_power_supply_register(dev, &mm8013_desc, &psy_cfg);
> +	if (IS_ERR(psy))
> +		return PTR_ERR(psy);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id mm8013_id_table[] =3D {
> +	{ "mm8013", 0 },
> +	{},

please remove the last ,

> +};
> +MODULE_DEVICE_TABLE(i2c, mm8013_id_table);
> +
> +static const struct of_device_id mm8013_match_table[] =3D {
> +	{ .compatible =3D "mitsumi,mm8013" },
> +	{ },

extra space in the Terminator, also terminator should not have a
comma at the end.

> +};
> +
> +static struct i2c_driver mm8013_i2c_driver =3D {
> +	.probe =3D mm8013_probe,
> +	.id_table =3D mm8013_id_table,
> +	.driver =3D {
> +		.name =3D "mm8013",
> +		.of_match_table =3D mm8013_match_table,
> +	},
> +};
> +module_i2c_driver(mm8013_i2c_driver);
> +
> +MODULE_DESCRIPTION("MM8013 fuel gauge driver");
> +MODULE_LICENSE("GPL");

With the next submission please include a dump of the uevent
in sysfs in the cover letter or below the fold, so that its
easy to validty check if the reported values look sensible.

Thanks and sorry for the slow processing,

-- Sebastian

--3m4hn2luzy5bgxji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUB2SsACgkQ2O7X88g7
+poocg//YMPacx5c1reHRCcJV3M1O7h4xJzUg3r1VRpu5fdfTngFU2/eOMD932mv
YEQ0GUKr2qaiF27bsJykZa3fLIlRCwkcEDzH/TZkZMw6Em2MA5swHsABA5ouCBWJ
BQFTeidpmSDtZsV4Vt0zuKQVuDnvIa2krQXIuZT2EBt7MnX8Lpc/I/pd71CDklp9
xCF5R3ZHVDOBk2pODprv2/H+QQIMdBN+Dx1y5CTNX4bJCb2hi4j2XGucqnG9XQ2N
L0bqsH47x7PjJP/jLPrmGapdY5zvinyyr/SaQVu4Q7vYXvXHVsRywiIOF7OW8dsL
W66gH/cEvbAQKl2VeeJMXAJAjkxWmMczF11JPiNyrpu6dLeCQ6VrgBGCrsgNkzBh
FLQ9eLDofY1wSN1Mz1GwrlwzPRn2rdRyLF3RJLfknhyCtDoRUPOdwNrmlAO8EtqM
R3keetl7XnQRxkUZa6AqXdStazR2PklTwcQKP9tlg8BE3Y6VqcxL+MlAzrprkE9U
LCiSNV/tetwA3suxj2s6idJR1tf4YkCrJaYDf/fSJDnerFDJKIVkXitr0VZ/IHbL
yRxjKmvitJi4WgVWktvzeiWnTiHFKvSN3k0mzTRHzYHHZQ5kZfhZZrE8J0GP5zUF
mnz6YJ8ZN+LfbWfjXztkhzaIJ0VqHf/gUQaYKZ7XAph2nFAiaxg=
=mWEr
-----END PGP SIGNATURE-----

--3m4hn2luzy5bgxji--
