Return-Path: <linux-kernel+bounces-138114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FDB89ECC9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39B12833C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE6C13D29B;
	Wed, 10 Apr 2024 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C528J2hv"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116913D277;
	Wed, 10 Apr 2024 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735771; cv=none; b=Q92RCmHI/gRhbJ90H0HdwI8jxAmjBkF0w66HClFb8aJ3jeTxolfcYEgv02WYUw3JC//ODe93iILCfQU5q8Kx8uq5WeZlnsvjEyo7gJpTiIaBm1d46aVhz9pWa97BiAK3qc/gtBD552D++ebMIYiCdK89C1XE4DYyJZX67rcYJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735771; c=relaxed/simple;
	bh=+ri3LVNTDMOUrmL5Ux7dvlJoUpEoDiEWWU7Wqq5jfXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtnbLSs8AOXd9yN42AWnWhQxu1nJVonjE8UoV+g4G2QrrqSxS7ey2QZacvIFgoewy8r/6PL7RHUbLenMHvmLNxujVL/y5Uz8tub+X6X4/BMSqUq1kavcQHlMysrFFudDQBl3H3ID/Uy+rF3evFqeMun/44GdweN2Q63lqL5UZaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C528J2hv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712735767;
	bh=+ri3LVNTDMOUrmL5Ux7dvlJoUpEoDiEWWU7Wqq5jfXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C528J2hvMnRe/J+lR6ONAePyBDusQ1z49yK1WDM6RzAp/XmVla/dG8IImJ8tXR+HO
	 lJjpX6/wKq9gqMPp8WOu47kNguu/MB0u2jvMsyIyVXXkvFUs3VMiOScngif7EX8VIZ
	 MKdyml8107qBUbYHUJqHQpMQk3XmPYUg5W0m5CcuR7TNPquUSnRvepkfGmps8/bzQd
	 0Hu8RQlqInsnaBNzF/TCq6JDybJqxW5f0TQiIuKpO1M1iORGXCax1nPEinv7UrEJIU
	 9J21LYJBC4yvCxPMEjBzx+hkNBZUb3LSNDMHzn/5Giv3mpusN7sKA3OA/Og19LN6fm
	 6UmjvXrZ33m6w==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D77233780C13;
	Wed, 10 Apr 2024 07:56:06 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id DA4D91063262; Wed, 10 Apr 2024 09:56:05 +0200 (CEST)
Date: Wed, 10 Apr 2024 09:56:05 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] power: supply: ltc3350-charger: Add driver
Message-ID: <5hpl2kspf667hmmxgg36ahiux5rs364qzrg2itpljspspa47vp@dsbnhdnq5s54>
References: <20240409135442.37732-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.dab85cfc-973d-4930-8fea-324aa26b5801@emailsignatures365.codetwo.com>
 <20240409135442.37732-2-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qiysdxtwtqec2igz"
Content-Disposition: inline
In-Reply-To: <20240409135442.37732-2-mike.looijmans@topic.nl>


--qiysdxtwtqec2igz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 09, 2024 at 03:54:41PM +0200, Mike Looijmans wrote:
> The LTC3350 is a backup power controller that can charge and monitor
> a series stack of one to four supercapacitors.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>=20
> ---

please share output of
=2E/tools/testing/selftests/power_supply/test_power_supply_properties.sh
below the fold with your next submission. It's useful for verifying,
that you got the unit scaling correct for the standard properties :)

> (no changes since v2)
>=20
> Changes in v2:
> Duplicate "vin_ov" and "vin_uv" attributes
>=20
>  drivers/power/supply/Kconfig           |  10 +
>  drivers/power/supply/Makefile          |   1 +
>  drivers/power/supply/ltc3350-charger.c | 718 +++++++++++++++++++++++++
>  3 files changed, 729 insertions(+)
>  create mode 100644 drivers/power/supply/ltc3350-charger.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 3e31375491d5..7cb1a66e522d 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -514,6 +514,16 @@ config CHARGER_LT3651
>  	  Say Y to include support for the Analog Devices (Linear Technology)
>  	  LT3651 battery charger which reports its status via GPIO lines.
> =20
> +config CHARGER_LTC3350
> +	tristate "LTC3350 Supercapacitor Backup Controller and System Monitor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select I2C_SMBUS
> +	help
> +	  Say Y to include support for the Analog Devices (Linear Technology)
> +	  LTC3350 Supercapacitor Backup Controller and System Monitor connected
> +	  to I2C.
> +
>  config CHARGER_LTC4162L
>  	tristate "LTC4162-L charger"
>  	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 58b567278034..a8d618e4ac91 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -72,6 +72,7 @@ obj-$(CONFIG_CHARGER_LP8788)	+=3D lp8788-charger.o
>  obj-$(CONFIG_CHARGER_GPIO)	+=3D gpio-charger.o
>  obj-$(CONFIG_CHARGER_MANAGER)	+=3D charger-manager.o
>  obj-$(CONFIG_CHARGER_LT3651)	+=3D lt3651-charger.o
> +obj-$(CONFIG_CHARGER_LTC3350)	+=3D ltc3350-charger.o
>  obj-$(CONFIG_CHARGER_LTC4162L)	+=3D ltc4162-l-charger.o
>  obj-$(CONFIG_CHARGER_MAX14577)	+=3D max14577_charger.o
>  obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+=3D max14656_charger_detector.o
> diff --git a/drivers/power/supply/ltc3350-charger.c b/drivers/power/suppl=
y/ltc3350-charger.c
> new file mode 100644
> index 000000000000..84c7a3ca914e
> --- /dev/null
> +++ b/drivers/power/supply/ltc3350-charger.c
> @@ -0,0 +1,718 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for Analog Devices (Linear Technology) LTC3350
> + * High Current Supercapacitor Backup Controller and System Monitor
> + * Copyright (C) 2024, Topic Embedded Products
> + */
> +
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/of_device.h>

replace of_device.h with mod_devicetable.h (which defines of_device_id).

> +#include <linux/pm_runtime.h>
> +#include <linux/power_supply.h>

add

#include <linux/property.h>

since you are using device_property_*

> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +
> +/* Registers (names based on what datasheet uses) */
> +#define LTC3350_REG_CLR_ALARMS		0x00
> +#define LTC3350_REG_MSK_ALARMS		0x01
> +#define LTC3350_REG_MSK_MON_STATUS	0x02
> +#define LTC3350_REG_CAP_ESR_PER		0x04
> +#define LTC3350_REG_VCAPFB_DAC		0x05
> +#define LTC3350_REG_VSHUNT		0x06
> +#define LTC3350_REG_CAP_UV_LVL		0x07
> +#define LTC3350_REG_CAP_OV_LVL		0x08
> +#define LTC3350_REG_GPI_UV_LVL		0x09
> +#define LTC3350_REG_GPI_OV_LVL		0x0A
> +#define LTC3350_REG_VIN_UV_LVL		0x0B
> +#define LTC3350_REG_VIN_OV_LVL		0x0C
> +#define LTC3350_REG_VCAP_UV_LVL		0x0D
> +#define LTC3350_REG_VCAP_OV_LVL		0x0E
> +#define LTC3350_REG_VOUT_UV_LVL		0x0F
> +#define LTC3350_REG_VOUT_OV_LVL		0x10
> +#define LTC3350_REG_IIN_OC_LVL		0x11
> +#define LTC3350_REG_ICHG_UC_LVL		0x12
> +#define LTC3350_REG_DTEMP_COLD_LVL	0x13
> +#define LTC3350_REG_DTEMP_HOT_LVL	0x14
> +#define LTC3350_REG_ESR_HI_LVL		0x15
> +#define LTC3350_REG_CAP_LO_LVL		0x16
> +#define LTC3350_REG_CTL_REG		0x17
> +#define LTC3350_REG_NUM_CAPS		0x1A
> +#define LTC3350_REG_CHRG_STATUS		0x1B
> +#define LTC3350_REG_MON_STATUS		0x1C
> +#define LTC3350_REG_ALARM_REG		0x1D
> +#define LTC3350_REG_MEAS_CAP		0x1E
> +#define LTC3350_REG_MEAS_ESR		0x1F
> +#define LTC3350_REG_MEAS_VCAP1		0x20
> +#define LTC3350_REG_MEAS_VCAP2		0x21
> +#define LTC3350_REG_MEAS_VCAP3		0x22
> +#define LTC3350_REG_MEAS_VCAP4		0x23
> +#define LTC3350_REG_MEAS_GPI		0x24
> +#define LTC3350_REG_MEAS_VIN		0x25
> +#define LTC3350_REG_MEAS_VCAP		0x26
> +#define LTC3350_REG_MEAS_VOUT		0x27
> +#define LTC3350_REG_MEAS_IIN		0x28
> +#define LTC3350_REG_MEAS_ICHG		0x29
> +#define LTC3350_REG_MEAS_DTEMP		0x2A
> +
> +/* LTC3350_REG_CLR_ALARMS, LTC3350_REG_MASK_ALARMS, LTC3350_REG_ALARM_RE=
G */
> +#define LTC3350_MSK_CAP_UV	BIT(0)	/* capacitor undervoltage alarm */
> +#define LTC3350_MSK_CAP_OV	BIT(1)	/* capacitor overvoltage alarm */
> +#define LTC3350_MSK_GPI_UV	BIT(2)	/* GPI undervoltage alarm */
> +#define LTC3350_MSK_GPI_OV	BIT(3)	/* GPI overvoltage alarm */
> +#define LTC3350_MSK_VIN_UV	BIT(4)	/* VIN undervoltage alarm */
> +#define LTC3350_MSK_VIN_OV	BIT(5)	/* VIN overvoltage alarm */
> +#define LTC3350_MSK_VCAP_UV	BIT(6)	/* VCAP undervoltage alarm */
> +#define LTC3350_MSK_VCAP_OV	BIT(7)	/* VCAP overvoltage alarm */
> +#define LTC3350_MSK_VOUT_UV	BIT(8)	/* VOUT undervoltage alarm */
> +#define LTC3350_MSK_VOUT_OV	BIT(9)	/* VOUT overvoltage alarm */
> +#define LTC3350_MSK_IIN_OC	BIT(10)	/* input overcurrent alarm */
> +#define LTC3350_MSK_ICHG_UC	BIT(11)	/* charge undercurrent alarm */
> +#define LTC3350_MSK_DTEMP_COLD	BIT(12)	/* die temperature cold alarm */
> +#define LTC3350_MSK_DTEMP_HOT	BIT(13)	/* die temperature hot alarm */
> +#define LTC3350_MSK_ESR_HI	BIT(14)	/* ESR high alarm */
> +#define LTC3350_MSK_CAP_LO	BIT(15)	/* capacitance low alarm */
> +
> +/* LTC3350_REG_MSK_MON_STATUS masks */
> +#define LTC3350_MSK_MON_CAPESR_ACTIVE		BIT(0)
> +#define LTC3350_MSK_MON_CAPESR_SCHEDULED	BIT(1)
> +#define LTC3350_MSK_MON_CAPESR_PENDING		BIT(2)
> +#define LTC3350_MSK_MON_CAP_DONE		BIT(3)
> +#define LTC3350_MSK_MON_ESR_DONE		BIT(4)
> +#define LTC3350_MSK_MON_CAP_FAILED		BIT(5)
> +#define LTC3350_MSK_MON_ESR_FAILED		BIT(6)
> +#define LTC3350_MSK_MON_POWER_FAILED		BIT(8)
> +#define LTC3350_MSK_MON_POWER_RETURNED		BIT(9)
> +
> +/* LTC3350_REG_CTL_REG */
> +/* Begin a capacitance and ESR measurement when possible */
> +#define LTC3350_CTL_STRT_CAPESR		BIT(0)
> +/* A one in this bit location enables the input buffer on the GPI pin */
> +#define LTC3350_CTL_GPI_BUFFER_EN	BIT(1)
> +/* Stops an active capacitance/ESR measurement */
> +#define LTC3350_CTL_STOP_CAPESR		BIT(2)
> +/* Increases capacitor measurement resolution by 100x for smaller capaci=
tors */
> +#define LTC3350_CTL_CAP_SCALE		BIT(3)
> +
> +/* LTC3350_REG_CHRG_STATUS */
> +#define LTC3350_CHRG_STEPDOWN	BIT(0)	/* Synchronous controller in step-d=
own mode (charging) */
> +#define LTC3350_CHRG_STEPUP	BIT(1)	/* Synchronous controller in step-up =
mode (backup) */
> +#define LTC3350_CHRG_CV		BIT(2)	/* The charger is in constant voltage mo=
de */
> +#define LTC3350_CHRG_UVLO	BIT(3)	/* The charger is in undervoltage locko=
ut */
> +#define LTC3350_CHRG_INPUT_ILIM	BIT(4)	/* The charger is in input curren=
t limit */
> +#define LTC3350_CHRG_CAPPG	BIT(5)	/* The capacitor voltage is above powe=
r good threshold */
> +#define LTC3350_CHRG_SHNT	BIT(6)	/* The capacitor manager is shunting */
> +#define LTC3350_CHRG_BAL	BIT(7)	/* The capacitor manager is balancing */
> +#define LTC3350_CHRG_DIS	BIT(8)	/* Charger disabled for capacitance meas=
urement */
> +#define LTC3350_CHRG_CI		BIT(9)	/* The charger is in constant current mo=
de */
> +#define LTC3350_CHRG_PFO	BIT(11)	/* Input voltage is below PFI threshold=
 */
> +
> +/* LTC3350_REG_MON_STATUS */
> +#define LTC3350_MON_CAPESR_ACTIVE	BIT(0)	/* Capacitance/ESR measurement =
in progress */
> +#define LTC3350_MON_CAPESR_SCHEDULED	BIT(1)	/* Waiting programmed time */
> +#define LTC3350_MON_CAPESR_PENDING	BIT(2)	/* Waiting for satisfactory co=
nditions */
> +#define LTC3350_MON_CAP_DONE		BIT(3)	/* Capacitance measurement has comp=
leted */
> +#define LTC3350_MON_ESR_DONE		BIT(4)	/* ESR Measurement has completed */
> +#define LTC3350_MON_CAP_FAILED		BIT(5)	/* Last capacitance measurement f=
ailed */
> +#define LTC3350_MON_ESR_FAILED		BIT(6)	/* Last ESR measurement failed */
> +#define LTC3350_MON_POWER_FAILED	BIT(8)	/* Unable to charge */
> +#define LTC3350_MON_POWER_RETURNED	BIT(9)	/* Able to charge */
> +
> +
> +struct ltc3350_info {
> +	struct i2c_client	*client;
> +	struct regmap		*regmap;
> +	struct power_supply	*charger;
> +	u32 rsnsc;	/* Series resistor that sets charge current, microOhm */
> +	u32 rsnsi;	/* Series resistor to measure input current, microOhm */
> +};
> +
> +/*
> + * About LTC3350 "alarm" functions: Setting a bit in the LTC3350_REG_MSK=
_ALARMS
> + * register enables the alarm. The alarm will trigger an SMBALERT only o=
nce.
> + * To reset the alarm, write a "1" bit to LTC3350_REG_CLR_ALARMS. Then t=
he alarm
> + * will trigger another SMBALERT when conditions are met (may be immedia=
tely).
> + * After writing to one of the corresponding level registers, enable the=
 alarm,
> + * so that a UEVENT triggers when the alarm goes off.
> + */
> +static void ltc3350_enable_alarm(struct ltc3350_info *info, unsigned int=
 reg)
> +{
> +	unsigned int mask;
> +
> +	/* Register locations correspond to alarm mask bits */
> +	mask =3D BIT(reg - LTC3350_REG_CAP_UV_LVL);
> +	/* Clear the alarm bit so it may trigger again */
> +	regmap_write(info->regmap, LTC3350_REG_CLR_ALARMS, mask);
> +	/* Enable the alarm */
> +	regmap_update_bits(info->regmap, LTC3350_REG_MSK_ALARMS, mask, mask);
> +}
> +
> +/* Convert enum value to POWER_SUPPLY_STATUS value */
> +static int ltc3350_state_decode(unsigned int value)
> +{
> +	if (value & LTC3350_CHRG_STEPUP)
> +		return POWER_SUPPLY_STATUS_DISCHARGING; /* running on backup */
> +
> +	if (value & LTC3350_CHRG_PFO)
> +		return POWER_SUPPLY_STATUS_NOT_CHARGING;
> +
> +	if (value & LTC3350_CHRG_STEPDOWN) {
> +		/* The chip remains in CV mode indefinitely, hence "full" */
> +		if (value & LTC3350_CHRG_CV)
> +			return POWER_SUPPLY_STATUS_FULL;
> +
> +		return POWER_SUPPLY_STATUS_CHARGING;
> +	}
> +
> +	/* Not in step down? Must be full then (never seen this) */
> +	return POWER_SUPPLY_STATUS_FULL;
> +};
> +
> +static int ltc3350_get_status(struct ltc3350_info *info, union power_sup=
ply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC3350_REG_CHRG_STATUS, &regval);
> +	if (ret)
> +		return ret;
> +
> +	val->intval =3D ltc3350_state_decode(regval);
> +
> +	return 0;
> +}
> +
> +static int ltc3350_charge_status_decode(unsigned int value)
> +{
> +	if (!(value & LTC3350_CHRG_STEPDOWN))
> +		return POWER_SUPPLY_CHARGE_TYPE_NONE;
> +
> +	/* constant voltage is "topping off" */
> +	if (value & LTC3350_CHRG_CV)
> +		return POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +
> +	/* input limiter */
> +	if (value & LTC3350_CHRG_INPUT_ILIM)
> +		return POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE;
> +
> +	/* constant current is "fast" */
> +	if (value & LTC3350_CHRG_CI)
> +		return POWER_SUPPLY_CHARGE_TYPE_FAST;
> +
> +	return POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
> +}
> +
> +static int ltc3350_get_charge_type(struct ltc3350_info *info, union powe=
r_supply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC3350_REG_CHRG_STATUS, &regval);
> +	if (ret)
> +		return ret;
> +
> +	val->intval =3D ltc3350_charge_status_decode(regval);
> +
> +	return 0;
> +}
> +
> +static int ltc3350_get_online(struct ltc3350_info *info, union power_sup=
ply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC3350_REG_MON_STATUS, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* indicates if input voltage is sufficient to charge */
> +	val->intval =3D !!(regval & LTC3350_MON_POWER_RETURNED);
> +
> +	return 0;
> +}
> +
> +static int ltc3350_get_input_voltage(struct ltc3350_info *info, union po=
wer_supply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC3350_REG_MEAS_VIN, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* 2.21mV/LSB */
> +	val->intval =3D  regval * 2210;
> +
> +	return 0;
> +}
> +
> +static int ltc3350_get_input_current(struct ltc3350_info *info, union po=
wer_supply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC3350_REG_MEAS_IIN, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* 1.983=C2=B5V/RSNSI amperes per LSB */
> +	ret =3D regval * 19830;
> +	ret /=3D info->rsnsi;
> +	ret *=3D 100;
> +
> +	val->intval =3D ret;
> +
> +	return 0;
> +}
> +
> +static int ltc3350_get_icharge(struct ltc3350_info *info, union power_su=
pply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC3350_REG_MEAS_ICHG, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* 1.983=C2=B5V/RSNSC amperes per LSB */
> +	ret =3D regval * 19830;
> +	ret /=3D info->rsnsc;
> +	ret *=3D 100;
> +
> +	val->intval =3D ret;
> +
> +	return 0;
> +}
> +
> +static int ltc3350_get_icharge_max(struct ltc3350_info *info, union powe=
r_supply_propval *val)
> +{
> +	/* I_CHG(MAX) =3D 32mV / RSNSC (Ampere) */
> +	val->intval =3D 3200000000U / (info->rsnsc / 10);
> +
> +	return 0;
> +}
> +
> +static int ltc3350_get_iin_max(struct ltc3350_info *info, union power_su=
pply_propval *val)
> +{
> +	/* I_IN(MAX) =3D 32mV / RSNSI (Ampere) */
> +	val->intval =3D 3200000000U / (info->rsnsi / 10);
> +
> +	return 0;
> +}
> +
> +
> +static int ltc3350_get_die_temp(struct ltc3350_info *info, unsigned int =
reg,
> +				union power_supply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, reg, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* 0.028=C2=B0C per LSB =E2=80=93 251.4=C2=B0C */
> +	ret =3D 280 * regval;
> +	ret /=3D 100; /* Centidegrees scale */
> +	ret -=3D 25140;
> +	val->intval =3D ret;
> +
> +	return 0;
> +}
> +
> +static int ltc3350_set_die_temp(struct ltc3350_info *info, unsigned int =
reg, int val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	/* 0.028=C2=B0C per LSB =E2=80=93 251.4=C2=B0C */
> +	regval =3D val + 25140;
> +	regval *=3D 100;
> +	regval /=3D 280;
> +
> +	ret =3D regmap_write(info->regmap, reg, regval);
> +	if (ret)
> +		return ret;
> +
> +	ltc3350_enable_alarm(info, reg);
> +	return 0;
> +}
> +
> +/* Custom properties */
> +
> +static ssize_t ltc3350_attr_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf,
> +				 unsigned int reg, unsigned int scale)
> +{
> +	struct power_supply *psy =3D to_power_supply(dev);
> +	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, reg, &regval);
> +	if (ret)
> +		return ret;
> +
> +	regval *=3D scale; /* Scale is in 10 =CE=BCV units */

please keep custom uAPI consistent with the general uAPI and use =C2=B5V.

> +	regval /=3D 10;
> +
> +	return sprintf(buf, "%u\n", regval);
> +}
> +
> +static ssize_t ltc3350_attr_store(struct device *dev, struct device_attr=
ibute *attr,
> +				  const char *buf, size_t count,
> +				  unsigned int reg, unsigned int scale)
> +{
> +	struct power_supply *psy =3D to_power_supply(dev);
> +	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
> +	unsigned long val;
> +	int ret;
> +
> +	ret =3D kstrtoul(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	val *=3D 10;
> +	val =3D DIV_ROUND_CLOSEST(val, scale); /* Scale is in 10 =CE=BCV units =
*/

obviously also applied to writing.

> +
> +	ret =3D regmap_write(info->regmap, reg, val);
> +	if (ret)
> +		return ret;
> +
> +	/* When writing to one of the LVL registers, update the alarm mask */
> +	if (reg >=3D LTC3350_REG_CAP_UV_LVL && reg <=3D LTC3350_REG_CAP_LO_LVL)
> +		ltc3350_enable_alarm(info, reg);
> +
> +	return count;
> +}
> +
> +#define LTC3350_DEVICE_ATTR_RO(_name, _reg, _scale)				\
> +static ssize_t _name##_show(struct device *dev, struct device_attribute =
*attr,	\
> +			    char *buf)						\
> +{										\
> +	return ltc3350_attr_show(dev, attr, buf, _reg, _scale);			\
> +}										\
> +static DEVICE_ATTR_RO(_name)
> +
> +#define LTC3350_DEVICE_ATTR_RW(_name, _reg, _scale)				\
> +static ssize_t _name##_show(struct device *dev, struct device_attribute =
*attr,	\
> +			    char *buf)						\
> +{										\
> +	return ltc3350_attr_show(dev, attr, buf, _reg, _scale);			\
> +}										\
> +static ssize_t _name##_store(struct device *dev, struct device_attribute=
 *attr, \
> +			     const char *buf, size_t count)			\
> +{										\
> +	return ltc3350_attr_store(dev, attr, buf, count, _reg, _scale);		\
> +}										\
> +static DEVICE_ATTR_RW(_name)
> +
> +/* Shunt voltage, 183.5=CE=BCV per LSB */
> +LTC3350_DEVICE_ATTR_RW(vshunt, LTC3350_REG_VSHUNT, 1835);
> +
> +/* Single capacitor voltages, 183.5=CE=BCV per LSB */
> +LTC3350_DEVICE_ATTR_RO(vcap1, LTC3350_REG_MEAS_VCAP1, 1835);
> +LTC3350_DEVICE_ATTR_RO(vcap2, LTC3350_REG_MEAS_VCAP2, 1835);
> +LTC3350_DEVICE_ATTR_RO(vcap3, LTC3350_REG_MEAS_VCAP3, 1835);
> +LTC3350_DEVICE_ATTR_RO(vcap4, LTC3350_REG_MEAS_VCAP4, 1835);
> +LTC3350_DEVICE_ATTR_RW(cap_uv, LTC3350_REG_CAP_UV_LVL, 1835);
> +LTC3350_DEVICE_ATTR_RW(cap_ov, LTC3350_REG_CAP_OV_LVL, 1835);
> +
> +/* General purpose input, 183.5=CE=BCV per LSB */
> +LTC3350_DEVICE_ATTR_RO(gpi, LTC3350_REG_MEAS_GPI, 1835);
> +LTC3350_DEVICE_ATTR_RW(gpi_uv, LTC3350_REG_GPI_UV_LVL, 1835);
> +LTC3350_DEVICE_ATTR_RW(gpi_ov, LTC3350_REG_GPI_OV_LVL, 1835);
> +
> +/* Input voltage, 2.21mV per LSB */
> +LTC3350_DEVICE_ATTR_RO(vin, LTC3350_REG_MEAS_VIN, 22100);
> +LTC3350_DEVICE_ATTR_RW(vin_uv, LTC3350_REG_VIN_UV_LVL, 22100);
> +LTC3350_DEVICE_ATTR_RW(vin_ov, LTC3350_REG_VIN_OV_LVL, 22100);
> +
> +/* Capacitor stack voltage, 1.476 mV per LSB */
> +LTC3350_DEVICE_ATTR_RO(vcap, LTC3350_REG_MEAS_VCAP, 14760);
> +LTC3350_DEVICE_ATTR_RW(vcap_uv, LTC3350_REG_VCAP_UV_LVL, 14760);
> +LTC3350_DEVICE_ATTR_RW(vcap_ov, LTC3350_REG_VCAP_OV_LVL, 14760);

I suppose it would be sensible to expose this as a second
power_supply device of type battery with ltc3350_config.supplied_to
set to this second power_supply device.

Then you can map

LTC3350_REG_MEAS_VCAP -> VOLTAGE_NOW
LTC3350_REG_VCAP_UV_LVL -> VOLTAGE_MIN
LTC3350_REG_VCAP_OV_LVL -> VOLTAGE_MAX
LTC3350_REG_VSHUNT -> CURRENT_NOW
TECHNOLOGY =3D POWER_SUPPLY_TECHNOLOGY_CAPACITOR (new)

Also the single capacitor voltages are similar to per-cell voltage
information, so I think we should create generic properties for
that:

LTC3350_REG_NUM_CAPS   -> NUMBER_OF_CELLS (new)
LTC3350_REG_MEAS_VCAP1 -> CELL1_VOLTAGE_NOW (new)
LTC3350_REG_MEAS_VCAP2 -> CELL2_VOLTAGE_NOW (new)
LTC3350_REG_MEAS_VCAP3 -> CELL3_VOLTAGE_NOW (new)
LTC3350_REG_MEAS_VCAP4 -> CELL4_VOLTAGE_NOW (new)
LTC3350_REG_CAP_UV_LVL -> CELL_VOLTAGE_MIN (new)
LTC3350_REG_CAP_OV_LVL -> CELL_VOLTAGE_MAX (new)

> +/* Output, 2.21mV per LSB */
> +LTC3350_DEVICE_ATTR_RO(vout, LTC3350_REG_MEAS_VOUT, 22100);
> +LTC3350_DEVICE_ATTR_RW(vout_uv, LTC3350_REG_VOUT_UV_LVL, 22100);
> +LTC3350_DEVICE_ATTR_RW(vout_ov, LTC3350_REG_VOUT_OV_LVL, 22100);
> +
> +static ssize_t num_caps_show(struct device *dev, struct device_attribute=
 *attr, char *buf)
> +{
> +	struct power_supply *psy =3D to_power_supply(dev);
> +	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC3350_REG_NUM_CAPS, &regval);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "%u\n", regval + 1);
> +}
> +static DEVICE_ATTR_RO(num_caps);
> +
> +static ssize_t charge_status_show(struct device *dev, struct device_attr=
ibute *attr, char *buf)
> +{
> +	struct power_supply *psy =3D to_power_supply(dev);
> +	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC3350_REG_CHRG_STATUS, &regval);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "0x%x\n", regval);
> +}
> +static DEVICE_ATTR_RO(charge_status);
> +
> +static struct attribute *ltc3350_sysfs_entries[] =3D {
> +	&dev_attr_vshunt.attr,
> +	&dev_attr_vcap1.attr,
> +	&dev_attr_vcap2.attr,
> +	&dev_attr_vcap3.attr,
> +	&dev_attr_vcap4.attr,
> +	&dev_attr_cap_uv.attr,
> +	&dev_attr_cap_ov.attr,
> +	&dev_attr_gpi.attr,
> +	&dev_attr_gpi_uv.attr,
> +	&dev_attr_gpi_ov.attr,
> +	&dev_attr_vin.attr,
> +	&dev_attr_vin_uv.attr,
> +	&dev_attr_vin_ov.attr,
> +	&dev_attr_vcap.attr,
> +	&dev_attr_vcap_uv.attr,
> +	&dev_attr_vcap_ov.attr,
> +	&dev_attr_vout.attr,
> +	&dev_attr_vout_uv.attr,
> +	&dev_attr_vout_ov.attr,
> +	&dev_attr_num_caps.attr,
> +	&dev_attr_charge_status.attr,
> +	NULL,
> +};

Exposing these to sysfs makes them ABI and ABI needs to be
documented in Documentation/ABI, see for example

Documentation/ABI/testing/sysfs-class-power-rt9467

> +static const struct attribute_group ltc3350_attr_group =3D {
> +	.name	=3D NULL,	/* put in device directory */
> +	.attrs	=3D ltc3350_sysfs_entries,
> +};
> +
> +static const struct attribute_group *ltc3350_attr_groups[] =3D {
> +	&ltc3350_attr_group,
> +	NULL,
> +};
> +
> +static int ltc3350_get_property(struct power_supply *psy, enum power_sup=
ply_property psp,
> +				union power_supply_propval *val)
> +{
> +	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		return ltc3350_get_status(info, val);
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		return ltc3350_get_charge_type(info, val);
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		return ltc3350_get_online(info, val);
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		return ltc3350_get_input_voltage(info, val);
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		return ltc3350_get_input_current(info, val);
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		return ltc3350_get_icharge(info, val);
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		return ltc3350_get_icharge_max(info, val);
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		return ltc3350_get_iin_max(info, val);
> +	case POWER_SUPPLY_PROP_TEMP:
> +		return ltc3350_get_die_temp(info, LTC3350_REG_MEAS_DTEMP, val);
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> +		return ltc3350_get_die_temp(info, LTC3350_REG_DTEMP_COLD_LVL, val);
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> +		return ltc3350_get_die_temp(info, LTC3350_REG_DTEMP_HOT_LVL, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ltc3350_set_property(struct power_supply *psy, enum power_sup=
ply_property psp,
> +				const union power_supply_propval *val)
> +{
> +	struct ltc3350_info *info =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> +		return ltc3350_set_die_temp(info, LTC3350_REG_DTEMP_COLD_LVL, val->int=
val);
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> +		return ltc3350_set_die_temp(info, LTC3350_REG_DTEMP_HOT_LVL, val->intv=
al);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ltc3350_property_is_writeable(struct power_supply *psy, enum =
power_supply_property psp)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> +	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> +		return 1;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +/* Charger power supply property routines */
> +static enum power_supply_property ltc3350_properties[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
> +	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
> +};
> +
> +static const struct power_supply_desc ltc3350_desc =3D {
> +	.name		=3D "ltc3350",
> +	.type		=3D POWER_SUPPLY_TYPE_MAINS,
> +	.properties	=3D ltc3350_properties,
> +	.num_properties	=3D ARRAY_SIZE(ltc3350_properties),
> +	.get_property	=3D ltc3350_get_property,
> +	.set_property	=3D ltc3350_set_property,
> +	.property_is_writeable =3D ltc3350_property_is_writeable,
> +};
> +
> +static bool ltc3350_is_writeable_reg(struct device *dev, unsigned int re=
g)
> +{
> +	/* all registers up to this one are writeable */
> +	return reg < LTC3350_REG_NUM_CAPS;
> +}
> +
> +static bool ltc3350_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	/* read-only status registers and self-clearing register */
> +	return reg > LTC3350_REG_NUM_CAPS || reg =3D=3D LTC3350_REG_CLR_ALARMS;
> +}
> +
> +static const struct regmap_config ltc3350_regmap_config =3D {
> +	.reg_bits	=3D 8,
> +	.val_bits	=3D 16,
> +	.val_format_endian =3D REGMAP_ENDIAN_LITTLE,
> +	.writeable_reg	=3D ltc3350_is_writeable_reg,
> +	.volatile_reg	=3D ltc3350_is_volatile_reg,
> +	.max_register	=3D LTC3350_REG_MEAS_DTEMP,
> +	.cache_type	=3D REGCACHE_MAPLE,
> +};
> +
> +static int ltc3350_probe(struct i2c_client *client)
> +{
> +	struct i2c_adapter *adapter =3D client->adapter;
> +	struct device *dev =3D &client->dev;
> +	struct ltc3350_info *info;
> +	struct power_supply_config ltc3350_config =3D {};
> +	int ret;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA)) {
> +		dev_err(dev, "No support for SMBUS_WORD_DATA\n");
> +		return -ENODEV;
> +	}

return dev_err_probe(dev, -ENODEV, "No support for SMBUS_WORD_DATA\n");

But I think this can just be dropped. devm_regmap_init_i2c() should
generate an error, if the i2c adapter requirements are not met.

> +	info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->client =3D client;
> +	i2c_set_clientdata(client, info);
> +
> +	info->regmap =3D devm_regmap_init_i2c(client, &ltc3350_regmap_config);
> +	if (IS_ERR(info->regmap)) {
> +		dev_err(dev, "Failed to initialize register map\n");
> +		return PTR_ERR(info->regmap);
> +	}

dev_err_probe()

> +
> +	ret =3D device_property_read_u32(dev, "lltc,rsnsc-micro-ohms",
> +				       &info->rsnsc);
> +	if (ret) {
> +		dev_err(dev, "Missing lltc,rsnsc-micro-ohms property\n");
> +		return ret;
> +	}

dev_err_probe()

> +	if (!info->rsnsc)
> +		return -EINVAL;
> +
> +	ret =3D device_property_read_u32(dev, "lltc,rsnsi-micro-ohms",
> +				       &info->rsnsi);
> +	if (ret) {
> +		dev_err(dev, "Missing lltc,rsnsi-micro-ohms property\n");
> +		return ret;
> +	}

dev_err_probe()

> +	if (!info->rsnsi)
> +		return -EINVAL;
> +
> +	/* Clear and disable all interrupt sources*/
> +	ret =3D regmap_write(info->regmap, LTC3350_REG_CLR_ALARMS, 0xFFFF);
> +	if (ret) {
> +		dev_err(dev, "Failed to write configuration\n");
> +		return ret;
> +	}

dev_err_probe()

> +	regmap_write(info->regmap, LTC3350_REG_MSK_ALARMS, 0);
> +	regmap_write(info->regmap, LTC3350_REG_MSK_MON_STATUS, 0);
> +
> +	ltc3350_config.of_node =3D dev->of_node;

replace with

ltc3350_config.fwnode =3D dev_fwnode(dev);

> +	ltc3350_config.drv_data =3D info;
> +	ltc3350_config.attr_grp =3D ltc3350_attr_groups;
> +
> +	info->charger =3D devm_power_supply_register(dev, &ltc3350_desc,
> +						   &ltc3350_config);
> +	if (IS_ERR(info->charger)) {
> +		dev_err(dev, "Failed to register charger\n");
> +		return PTR_ERR(info->charger);
> +	}

dev_err_probe()

> +
> +	/* Enable interrupts on status changes */
> +	regmap_write(info->regmap, LTC3350_REG_MSK_MON_STATUS,
> +		     LTC3350_MON_POWER_FAILED | LTC3350_MON_POWER_RETURNED);
> +
> +	return 0;
> +}
> +
> +static void ltc3350_alert(struct i2c_client *client, enum i2c_alert_prot=
ocol type,
> +			  unsigned int flag)
> +{
> +	struct ltc3350_info *info =3D i2c_get_clientdata(client);
> +
> +	if (type !=3D I2C_PROTOCOL_SMBUS_ALERT)
> +		return;
> +
> +	power_supply_changed(info->charger);
> +}
> +
> +static const struct i2c_device_id ltc3350_i2c_id_table[] =3D {
> +	{ "ltc3350", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, ltc3350_i2c_id_table);
> +
> +static const struct of_device_id ltc3350_of_match[] =3D {
> +	{ .compatible =3D "lltc,ltc3350", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ltc3350_of_match);
> +
> +static struct i2c_driver ltc3350_driver =3D {
> +	.probe		=3D ltc3350_probe,
> +	.alert		=3D ltc3350_alert,
> +	.id_table	=3D ltc3350_i2c_id_table,
> +	.driver =3D {
> +		.name		=3D "ltc3350-charger",
> +		.of_match_table	=3D of_match_ptr(ltc3350_of_match),

Please check what of_match_ptr() does and then drop it :)

> +	},
> +};
> +module_i2c_driver(ltc3350_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
> +MODULE_DESCRIPTION("LTC3350 charger driver");

Thanks for your patch,

-- Sebastian

--qiysdxtwtqec2igz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYWRhEACgkQ2O7X88g7
+poY0BAAoOhlH7n2mrkHDSdVuyMaiTjbafXCc9KujnRQm6PwFQwHpdYvdquRGAkL
ApyDqcu6lADWlyvdj4TjWju9YJr1qOl3/tQSm6E/iPyiWXVumxzlYmgVkakvSbf/
xhV0iCN81PEwUzfb2ldtvlOnhpUKdnm6+GfiPS2Gx/jffys19JDW5AInMWW0zisn
ZrZ8magsa8zCn1eQZz1qF0hg4ruRZ2ShlvLdZkakAiFEXR0SzRQHXtKYwvq/boEJ
etAaq8Gjmwd3MtuQ7LZJeOMj95C4Z9DjH/Oj6gmS9/hr5ga1tntLLT5aIBMT6KBV
I9pRP5ni9qDj2QT09oEA5PpR4Ld86Xvp9LpoWQOC1OZpxT6ECKJiuMNLUXJf2PCw
Af+2l+WFfIB48MZOpg/N/opW9bp+lw9ZZnrBd6hPv5aFVKPEZxrm+zDrciV8jXP9
ofCUctw0JYaktWex5aSTTpGmKW7wcbq6RFNqYiInMGQqqDc5YgOHt5kf4koUINaN
HsL+cnbLriVDhclmdhidCHQfk25MXxWBJF0ewhLydKWFhTNuaWkOIp7M1IxEmzQs
oyzkizN+P3kk0gfWlGH+L906mfkLB7I7+wX3vOqd4Sqj7LT5Q7gRu2F1M+/QkJPj
4zvI4J8iPBy7mw0IFqkTttYh14k7TXIRHVFXzzozRY3HZWIWu6s=
=/kWC
-----END PGP SIGNATURE-----

--qiysdxtwtqec2igz--

