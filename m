Return-Path: <linux-kernel+bounces-161471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662A58B4C72
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A914B212FD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCDD6F079;
	Sun, 28 Apr 2024 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvCOCj0D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010216E610;
	Sun, 28 Apr 2024 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714318957; cv=none; b=qzp7zWUYr9CMIhgV88sYmy0npNdPZnBGdZwISs+2P5x4bhEuRljQ9/zLoFOHCkjWt/y6J/ZHXogBEV1jxtGm79bt5ePNsynt1XzyeS0X35HNoUyUevjHpN333VjmmDb04UD4KS0kjBGs0ERKMwl9PkZkKuGS5M7UpArjgwXEA+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714318957; c=relaxed/simple;
	bh=tvC8s4hxWSnQ/feb1l1CDojTOYy/5AFCiB1PMgNwzSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0ULdV8vn5Bh8ZxZWExhCtPOd0C1wpl3rkeKiVkjPpqFmsKk0lcUu9NJJuPavRvyQTxB8pdTpu7qRVxI7XHsacZa3ymJUVh4cYpxpsvWDo9M2aDNrvCCpsFpFQJs8sdZXR1Mi5SDpOci6gpENLRe5SBAeTlwqgzKQZj5QmAEbD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvCOCj0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AA6C113CC;
	Sun, 28 Apr 2024 15:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714318956;
	bh=tvC8s4hxWSnQ/feb1l1CDojTOYy/5AFCiB1PMgNwzSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvCOCj0DTcmZObZmZlHmKedNk03FcfMt8KvtfrYoTDiV7suX9DBsByboDhePtBNFo
	 dJ2py4WFVwskeychjIf54y6pqjS2mFZj1nt0DDQqK/N6sswXv9v8QT5gqmhgd6hVtp
	 JkKr3LfzICEaYSQizJtEYqGJtmei5QfLDbQ0XxZsyyq8+W8Gk7N99UXYrx0BdeoAEV
	 uBH2mBTOYkhIpsFBuA6dNaOE8VPglvTYXsu1DXmcJj0pts8PAOG1E3hHpDSxO0kgLP
	 NmsVkpqEKOCoBfH2VomaN0cj4vNaVQ4itTAeP0DqQz2ol9X7OZZph2YZGnj4c6G37R
	 Y+W4gH/Cdu1/w==
Date: Sun, 28 Apr 2024 16:42:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Jean Delvare <jdelvare@suse.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Wei Xu <xuwei5@hisilicon.com>, Huisong Li <lihuisong@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: soc: sophgo: Add SG2042 external hardware
 monitor support
Message-ID: <20240428-festive-imaging-261b81b9e541@spud>
References: <IA1PR20MB49532A8A0C52FE5C599B6D13BB142@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953A6EF6ED0CD082B60DD80BB142@IA1PR20MB4953.namprd20.prod.outlook.com>
 <540cad62-db3d-4876-81a4-da396628e5ef@roeck-us.net>
 <IA1PR20MB49532EAE5B31E2B45CCA9CC8BB142@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ElZFJzxsTJ1G0HEO"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49532EAE5B31E2B45CCA9CC8BB142@IA1PR20MB4953.namprd20.prod.outlook.com>


--ElZFJzxsTJ1G0HEO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2024 at 08:09:48PM +0800, Inochi Amaoto wrote:
> On Sun, Apr 28, 2024 at 12:00:15AM GMT, Guenter Roeck wrote:
> > On 4/27/24 18:30, Inochi Amaoto wrote:
> > > SG2042 use an external MCU to provide basic hardware information
> > > and thermal sensors.
> > >=20
> > > Add driver support for the onboard MCU of SG2042.
> > >=20
> > > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> >=20
> > Why does this driver reside in drivers/soc and not in drivers/hwmon ?
> >=20
> > NACK from my perspective.
> >=20
> > Guenter
> >=20
>=20
> In fact, I am pretty unsure which one is better. This driver also provides
> something rather than the hardware monitor. For example, this device also
> acts as a reset controller (now only used in SBI). Is it even better to
> move the driver into hwmon subsystem in this case?

The guidance from Arnd about drivers/soc is that it is ideally only
drivers that expose an in-kernel interface belong there, and if there's
some sort of userspace interface, then it does not belong there.

Additionally, I'd suggest that if the "reset controller" side of this
is not resets for peripherals, but rather is poweroff/reboot, that the
SBI firmware deals with that functionality and implements the SRST SBI
extension.

Cheers,
Conor.

>=20
> Regards,
> Inochi
>=20
> > > ---
> > >   drivers/soc/Kconfig                   |   1 +
> > >   drivers/soc/Makefile                  |   1 +
> > >   drivers/soc/sophgo/Kconfig            |  12 +
> > >   drivers/soc/sophgo/Makefile           |   5 +
> > >   drivers/soc/sophgo/sg2042-hwmon-mcu.c | 531 +++++++++++++++++++++++=
+++
> > >   5 files changed, 550 insertions(+)
> > >   create mode 100644 drivers/soc/sophgo/Kconfig
> > >   create mode 100644 drivers/soc/sophgo/Makefile
> > >   create mode 100644 drivers/soc/sophgo/sg2042-hwmon-mcu.c
> > >=20
> > > diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> > > index 5d924e946507..19050f094996 100644
> > > --- a/drivers/soc/Kconfig
> > > +++ b/drivers/soc/Kconfig
> > > @@ -22,6 +22,7 @@ source "drivers/soc/qcom/Kconfig"
> > >   source "drivers/soc/renesas/Kconfig"
> > >   source "drivers/soc/rockchip/Kconfig"
> > >   source "drivers/soc/samsung/Kconfig"
> > > +source "drivers/soc/sophgo/Kconfig"
> > >   source "drivers/soc/sunxi/Kconfig"
> > >   source "drivers/soc/tegra/Kconfig"
> > >   source "drivers/soc/ti/Kconfig"
> > > diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> > > index ba8f5b5460e1..6948e6617316 100644
> > > --- a/drivers/soc/Makefile
> > > +++ b/drivers/soc/Makefile
> > > @@ -28,6 +28,7 @@ obj-y				+=3D qcom/
> > >   obj-y				+=3D renesas/
> > >   obj-y				+=3D rockchip/
> > >   obj-$(CONFIG_SOC_SAMSUNG)	+=3D samsung/
> > > +obj-y				+=3D sophgo/
> > >   obj-y				+=3D sunxi/
> > >   obj-$(CONFIG_ARCH_TEGRA)	+=3D tegra/
> > >   obj-y				+=3D ti/
> > > diff --git a/drivers/soc/sophgo/Kconfig b/drivers/soc/sophgo/Kconfig
> > > new file mode 100644
> > > index 000000000000..de9842d1c287
> > > --- /dev/null
> > > +++ b/drivers/soc/sophgo/Kconfig
> > > @@ -0,0 +1,12 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +#
> > > +# Sophgo SoC drivers
> > > +#
> > > +
> > > +config SG2042_HWMON_MCU
> > > +	tristate "SG2042 onboard MCU support"
> > > +	depends on RISCV
> > > +	help
> > > +	  Support for SG2042 onboard MCU. This mcu provides power
> > > +	  control and some basic information for SG2042 chip.
> > > +	  If unsure, say Y.
> > > diff --git a/drivers/soc/sophgo/Makefile b/drivers/soc/sophgo/Makefile
> > > new file mode 100644
> > > index 000000000000..c72729ce61aa
> > > --- /dev/null
> > > +++ b/drivers/soc/sophgo/Makefile
> > > @@ -0,0 +1,5 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +#
> > > +# Sophgo SoC drivers
> > > +#
> > > +obj-$(CONFIG_SG2042_HWMON_MCU)		+=3D sg2042-hwmon-mcu.o
> > > diff --git a/drivers/soc/sophgo/sg2042-hwmon-mcu.c b/drivers/soc/soph=
go/sg2042-hwmon-mcu.c
> > > new file mode 100644
> > > index 000000000000..3413b1a0f5e3
> > > --- /dev/null
> > > +++ b/drivers/soc/sophgo/sg2042-hwmon-mcu.c
> > > @@ -0,0 +1,531 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (c) 2024 Inochi Amaoto <inochiama@outlook.com>
> > > + *
> > > + * Sophgo power control mcu for SG2042
> > > + */
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/err.h>
> > > +#include <linux/hwmon.h>
> > > +#include <linux/time.h>
> > > +
> > > +/* fixed MCU registers */
> > > +#define REG_BOARD_TYPE				0x00
> > > +#define REG_MCU_FIRMWARE_VERSION		0x01
> > > +#define REG_PCB_VERSION				0x02
> > > +#define REG_PWR_CTRL				0x03
> > > +#define REG_SOC_TEMP				0x04
> > > +#define REG_BOARD_TEMP				0x05
> > > +#define REG_RST_COUNT				0x0a
> > > +#define REG_UPTIME				0x0b
> > > +#define REG_RESET_REASON			0x0d
> > > +#define REG_MCU_TYPE				0x18
> > > +#define REG_CRITICAL_ACTIONS			0x65
> > > +#define REG_CRITICAL_TEMP			0x66
> > > +#define REG_REPOWER_TEMP			0x67
> > > +
> > > +#define CRITICAL_ACTION_REBOOT			0x1
> > > +#define CRITICAL_ACTION_POWEROFF		0x2
> > > +
> > > +#define DEFAULT_REPOWER_TEMP			60
> > > +#define MAX_REPOWER_TEMP			100
> > > +
> > > +#define sg2042_mcu_read_byte(client, reg)			\
> > > +	i2c_smbus_read_byte_data(client, reg)
> > > +#define sg2042_mcu_write_byte(client, reg, value)		\
> > > +	i2c_smbus_write_byte_data(client, reg, value)
> > > +#define sg2042_mcu_read_block(client, reg, array)		\
> > > +	i2c_smbus_read_i2c_block_data(client, reg, sizeof(array), array)
> > > +
> > > +#define DEFINE_MCU_ATTR_READ_FUNC(_name, _type, _format)		\
> > > +	static ssize_t _name##_show(struct device *dev,			\
> > > +				    struct device_attribute *attr,	\
> > > +				    char *buf)				\
> > > +	{								\
> > > +		struct sg2042_mcu_data *mcu =3D dev_get_drvdata(dev);	\
> > > +		_type ret;						\
> > > +		ret =3D sg2042_mcu_get_##_name(mcu->client);		\
> > > +		if (ret < 0)						\
> > > +			return ret;					\
> > > +		return sprintf(buf, _format "\n", ret);			\
> > > +	}
> > > +
> > > +struct sg2042_mcu_board_data {
> > > +	u8		id;
> > > +	const char	*name;
> > > +};
> > > +
> > > +struct sg2042_mcu_data {
> > > +	struct i2c_client			*client;
> > > +	const struct sg2042_mcu_board_data	*board_info;
> > > +};
> > > +
> > > +static const struct sg2042_mcu_board_data sg2042_boards_data[] =3D {
> > > +	{
> > > +		.id =3D 0x80,
> > > +		.name =3D "SG2042 evb x8",
> > > +	},
> > > +	{
> > > +		.id =3D 0x81,
> > > +		.name =3D "SG2042R evb",
> > > +	},
> > > +	{
> > > +		.id =3D 0x83,
> > > +		.name =3D "SG2042 evb x4",
> > > +	},
> > > +	{
> > > +		.id =3D 0x90,
> > > +		.name =3D "Milk-V Pioneer",
> > > +	},
> > > +};
> > > +
> > > +static const char *sg2042_mcu_reset_reason[8] =3D {
> > > +	"Power supply overheat",
> > > +	"Power supply failure",
> > > +	"12V power supply failure",
> > > +	"Reset commant",
> > > +	"Unknown",
> > > +	"Unknown",
> > > +	"Unknown",
> > > +	"SoC overheat",
> > > +};
> > > +
> > > +static int sg2042_mcu_get_board_type(struct i2c_client *client)
> > > +{
> > > +	return sg2042_mcu_read_byte(client, REG_BOARD_TYPE);
> > > +}
> > > +
> > > +static int sg2042_mcu_get_firmware_version(struct i2c_client *client)
> > > +{
> > > +	return sg2042_mcu_read_byte(client, REG_MCU_FIRMWARE_VERSION);
> > > +}
> > > +
> > > +static int sg2042_mcu_get_pcb_version(struct i2c_client *client)
> > > +{
> > > +	return sg2042_mcu_read_byte(client, REG_PCB_VERSION);
> > > +}
> > > +
> > > +static int sg2042_mcu_get_soc_temp(struct i2c_client *client)
> > > +{
> > > +	return sg2042_mcu_read_byte(client, REG_SOC_TEMP);
> > > +}
> > > +
> > > +static int sg2042_mcu_get_board_temp(struct i2c_client *client)
> > > +{
> > > +	return sg2042_mcu_read_byte(client, REG_BOARD_TEMP);
> > > +}
> > > +
> > > +static int sg2042_mcu_get_reset_count(struct i2c_client *client)
> > > +{
> > > +	return sg2042_mcu_read_byte(client, REG_RST_COUNT);
> > > +}
> > > +
> > > +static s32 sg2042_mcu_get_uptime(struct i2c_client *client)
> > > +{
> > > +	int ret;
> > > +	u8 time_val[2];
> > > +
> > > +	ret =3D sg2042_mcu_read_block(client, REG_UPTIME, time_val);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	return (s32)(time_val[0]) + ((s32)(time_val[1]) << 8);
> > > +}
> > > +
> > > +static int sg2042_mcu_get_reset_reason(struct i2c_client *client)
> > > +{
> > > +	return sg2042_mcu_read_byte(client, REG_RESET_REASON);
> > > +}
> > > +
> > > +static int sg2042_mcu_get_mcu_type(struct i2c_client *client)
> > > +{
> > > +	return sg2042_mcu_read_byte(client, REG_MCU_TYPE);
> > > +}
> > > +
> > > +static int sg2042_mcu_get_critical_action(struct i2c_client *client)
> > > +{
> > > +	return sg2042_mcu_read_byte(client, REG_CRITICAL_ACTIONS);
> > > +}
> > > +
> > > +static int sg2042_mcu_get_critical_temp(struct i2c_client *client)
> > > +{
> > > +	return sg2042_mcu_read_byte(client, REG_CRITICAL_TEMP);
> > > +}
> > > +
> > > +static int sg2042_mcu_get_repower_temp(struct i2c_client *client)
> > > +{
> > > +	return sg2042_mcu_read_byte(client, REG_REPOWER_TEMP);
> > > +}
> > > +
> > > +static int sg2042_mcu_set_critical_action(struct i2c_client *client,
> > > +					  u8 value)
> > > +{
> > > +	return sg2042_mcu_write_byte(client, REG_CRITICAL_ACTIONS, value);
> > > +}
> > > +
> > > +static int sg2042_mcu_set_critical_temp(struct i2c_client *client,
> > > +					u8 value)
> > > +{
> > > +	return sg2042_mcu_write_byte(client, REG_CRITICAL_TEMP, value);
> > > +}
> > > +
> > > +static int sg2042_mcu_set_repower_temp(struct i2c_client *client,
> > > +				       u8 value)
> > > +{
> > > +	return sg2042_mcu_write_byte(client, REG_REPOWER_TEMP, value);
> > > +}
> > > +
> > > +static ssize_t board_type_show(struct device *dev,
> > > +			       struct device_attribute *attr,
> > > +			       char *buf)
> > > +{
> > > +	struct sg2042_mcu_data *mcu =3D dev_get_drvdata(dev);
> > > +
> > > +	return sprintf(buf, "%s\n", mcu->board_info->name ?: "Unknown");
> > > +}
> > > +
> > > +DEFINE_MCU_ATTR_READ_FUNC(firmware_version, int, "0x%02x");
> > > +DEFINE_MCU_ATTR_READ_FUNC(pcb_version, int, "0x%02x");
> > > +DEFINE_MCU_ATTR_READ_FUNC(reset_count, int, "%d");
> > > +DEFINE_MCU_ATTR_READ_FUNC(uptime, s32, "%d");
> > > +
> > > +static ssize_t reset_reason_show(struct device *dev,
> > > +				 struct device_attribute *attr,
> > > +				 char *buf)
> > > +{
> > > +	struct sg2042_mcu_data *mcu =3D dev_get_drvdata(dev);
> > > +	int ret, val, i;
> > > +
> > > +	val =3D sg2042_mcu_get_reset_reason(mcu->client);
> > > +	if (val < 0)
> > > +		return val;
> > > +
> > > +	ret =3D sprintf(buf, "Reason: 0x%02x\n", val);
> > > +
> > > +	for (i =3D 0; i < ARRAY_SIZE(sg2042_mcu_reset_reason); i++) {
> > > +		if (val & BIT(i))
> > > +			ret +=3D sprintf(buf + ret, "bit %d: %s\n", i,
> > > +						  sg2042_mcu_reset_reason[i]);
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static ssize_t mcu_type_show(struct device *dev,
> > > +			     struct device_attribute *attr,
> > > +			     char *buf)
> > > +{
> > > +	struct sg2042_mcu_data *mcu =3D dev_get_drvdata(dev);
> > > +	int ret;
> > > +
> > > +	ret =3D sg2042_mcu_get_mcu_type(mcu->client);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	return sprintf(buf, ret ? "GD32\n" : "STM32\n");
> > > +}
> > > +
> > > +static ssize_t critical_action_show(struct device *dev,
> > > +				    struct device_attribute *attr,
> > > +				    char *buf)
> > > +{
> > > +	struct sg2042_mcu_data *mcu =3D dev_get_drvdata(dev);
> > > +	int ret;
> > > +	const char *action;
> > > +
> > > +	ret =3D sg2042_mcu_get_critical_action(mcu->client);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	if (ret =3D=3D CRITICAL_ACTION_REBOOT)
> > > +		action =3D "reboot";
> > > +	else if (ret =3D=3D CRITICAL_ACTION_POWEROFF)
> > > +		action =3D "poweroff";
> > > +	else
> > > +		action =3D "unknown";
> > > +
> > > +	return sprintf(buf, "%s\n", action);
> > > +}
> > > +
> > > +static ssize_t critical_action_store(struct device *dev,
> > > +				     struct device_attribute *attr,
> > > +				     const char *buf, size_t count)
> > > +{
> > > +	struct sg2042_mcu_data *mcu =3D dev_get_drvdata(dev);
> > > +	int value;
> > > +
> > > +	if (sysfs_streq("reboot", buf))
> > > +		value =3D CRITICAL_ACTION_REBOOT;
> > > +	else if (sysfs_streq("poweroff", buf))
> > > +		value =3D CRITICAL_ACTION_POWEROFF;
> > > +	else
> > > +		return -EINVAL;
> > > +
> > > +	return sg2042_mcu_set_critical_action(mcu->client, value);
> > > +}
> > > +
> > > +DEFINE_MCU_ATTR_READ_FUNC(repower_temp, u32, "%u");
> > > +
> > > +static ssize_t repower_temp_store(struct device *dev,
> > > +				  struct device_attribute *attr,
> > > +				  const char *buf, size_t count)
> > > +{
> > > +	struct sg2042_mcu_data *mcu =3D dev_get_drvdata(dev);
> > > +	u8 val;
> > > +	int ret;
> > > +
> > > +	ret =3D kstrtou8(buf, 10, &val);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	if (val =3D=3D 0 || val > MAX_REPOWER_TEMP)
> > > +		return -EINVAL;
> > > +
> > > +	return sg2042_mcu_set_repower_temp(mcu->client, val);
> > > +}
> > > +
> > > +static DEVICE_ATTR_RO(board_type);
> > > +static DEVICE_ATTR_RO(firmware_version);
> > > +static DEVICE_ATTR_RO(pcb_version);
> > > +static DEVICE_ATTR_RO(reset_count);
> > > +static DEVICE_ATTR_RO(uptime);
> > > +static DEVICE_ATTR_RO(reset_reason);
> > > +static DEVICE_ATTR_RO(mcu_type);
> > > +static DEVICE_ATTR_RW(critical_action);
> > > +static DEVICE_ATTR_RW(repower_temp);
> > > +
> > > +static struct attribute *sg2042_mcu_attrs[] =3D {
> > > +	&dev_attr_board_type.attr,
> > > +	&dev_attr_firmware_version.attr,
> > > +	&dev_attr_pcb_version.attr,
> > > +	&dev_attr_reset_count.attr,
> > > +	&dev_attr_uptime.attr,
> > > +	&dev_attr_reset_reason.attr,
> > > +	&dev_attr_mcu_type.attr,
> > > +	&dev_attr_critical_action.attr,
> > > +	&dev_attr_repower_temp.attr,
> > > +	NULL
> > > +};
> > > +
> > > +static const struct attribute_group sg2042_mcu_attr_group =3D {
> > > +	.attrs	=3D sg2042_mcu_attrs,
> > > +};
> > > +
> > > +static const struct hwmon_channel_info * const sg2042_mcu_info[] =3D=
 {
> > > +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTER=
VAL),
> > > +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_CRIT,
> > > +				 HWMON_T_INPUT),
> > > +	NULL
> > > +};
> > > +
> > > +static int sg2042_mcu_read_temp(struct device *dev,
> > > +				u32 attr, int channel,
> > > +				long *val)
> > > +{
> > > +	struct sg2042_mcu_data *mcu =3D dev_get_drvdata(dev);
> > > +	long tmp;
> > > +
> > > +	switch (attr) {
> > > +	case hwmon_temp_input:
> > > +		switch (channel) {
> > > +		case 0:
> > > +			tmp =3D sg2042_mcu_get_soc_temp(mcu->client);
> > > +			if (tmp < 0)
> > > +				return tmp;
> > > +			*val =3D tmp * 1000;
> > > +			break;
> > > +		case 1:
> > > +			tmp =3D sg2042_mcu_get_board_temp(mcu->client);
> > > +			if (tmp < 0)
> > > +				return tmp;
> > > +			*val =3D tmp * 1000;
> > > +			break;
> > > +		default:
> > > +			return -EOPNOTSUPP;
> > > +		}
> > > +		break;
> > > +	case hwmon_temp_crit:
> > > +		if (channel)
> > > +			return -EOPNOTSUPP;
> > > +
> > > +		tmp =3D sg2042_mcu_get_critical_temp(mcu->client);
> > > +		if (tmp < 0)
> > > +			return tmp;
> > > +		*val =3D tmp * 1000;
> > > +		break;
> > > +	default:
> > > +		return -EOPNOTSUPP;
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > > +static int sg2042_mcu_read(struct device *dev,
> > > +			   enum hwmon_sensor_types type,
> > > +			   u32 attr, int channel, long *val)
> > > +{
> > > +	switch (type) {
> > > +	case hwmon_chip:
> > > +		if (attr !=3D hwmon_chip_update_interval)
> > > +			return -EOPNOTSUPP;
> > > +		*val =3D 1000;
> > > +		break;
> > > +	case hwmon_temp:
> > > +		return sg2042_mcu_read_temp(dev, attr, channel, val);
> > > +	default:
> > > +		return -EOPNOTSUPP;
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > > +static int sg2042_mcu_write(struct device *dev,
> > > +			    enum hwmon_sensor_types type,
> > > +			    u32 attr, int channel, long val)
> > > +{
> > > +	struct sg2042_mcu_data *mcu =3D dev_get_drvdata(dev);
> > > +	u8 down_temp, repower_temp;
> > > +	int ret;
> > > +
> > > +	if (type !=3D hwmon_temp || attr !=3D hwmon_temp_crit || !channel)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	ret =3D sg2042_mcu_get_repower_temp(mcu->client);
> > > +	if (ret < 0)
> > > +		repower_temp =3D DEFAULT_REPOWER_TEMP;
> > > +	else
> > > +		repower_temp =3D ret;
> > > +
> > > +	down_temp =3D val / 1000;
> > > +	if (down_temp < repower_temp)
> > > +		return -EINVAL;
> > > +
> > > +	return sg2042_mcu_set_critical_temp(mcu->client, (u8)(val / 1000));
> > > +}
> > > +
> > > +static umode_t sg2042_mcu_is_visible(const void *_data,
> > > +				     enum hwmon_sensor_types type,
> > > +				     u32 attr, int channel)
> > > +{
> > > +	switch (type) {
> > > +	case hwmon_chip:
> > > +		if (attr =3D=3D hwmon_chip_update_interval)
> > > +			return 0444;
> > > +		break;
> > > +	case hwmon_temp:
> > > +		switch (attr) {
> > > +		case hwmon_temp_input:
> > > +			if (channel < 2)
> > > +				return 0444;
> > > +			break;
> > > +		case hwmon_temp_crit:
> > > +			if (channel =3D=3D 0)
> > > +				return 0664;
> > > +			break;
> > > +		default:
> > > +			return 0;
> > > +		}
> > > +		break;
> > > +	default:
> > > +		return 0;
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct hwmon_ops sg2042_mcu_ops =3D {
> > > +	.is_visible =3D sg2042_mcu_is_visible,
> > > +	.read =3D sg2042_mcu_read,
> > > +	.write =3D sg2042_mcu_write,
> > > +};
> > > +
> > > +static const struct hwmon_chip_info sg2042_mcu_chip_info =3D {
> > > +	.ops =3D &sg2042_mcu_ops,
> > > +	.info =3D sg2042_mcu_info,
> > > +};
> > > +
> > > +static int sg2042_mcu_check_board(u8 id)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i =3D 0; i < ARRAY_SIZE(sg2042_boards_data); i++) {
> > > +		if (sg2042_boards_data[i].id =3D=3D id)
> > > +			return i;
> > > +	}
> > > +
> > > +	return -ENODEV;
> > > +}
> > > +
> > > +static int sg2042_mcu_i2c_probe(struct i2c_client *client)
> > > +{
> > > +	int ret;
> > > +	struct device *dev =3D &client->dev;
> > > +	struct sg2042_mcu_data *mcu;
> > > +	struct device *hwmon_dev;
> > > +
> > > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_D=
ATA |
> > > +						I2C_FUNC_SMBUS_BLOCK_DATA))
> > > +		return -EIO;
> > > +
> > > +	ret =3D sg2042_mcu_get_board_type(client);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	ret =3D sg2042_mcu_check_board(ret);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	mcu =3D devm_kmalloc(dev, sizeof(*mcu), GFP_KERNEL);
> > > +	if (!mcu)
> > > +		return -ENOMEM;
> > > +
> > > +	mcu->client =3D client;
> > > +	mcu->board_info =3D &sg2042_boards_data[ret];
> > > +
> > > +	ret =3D sysfs_create_group(&dev->kobj, &sg2042_mcu_attr_group);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	i2c_set_clientdata(client, mcu);
> > > +
> > > +	hwmon_dev =3D devm_hwmon_device_register_with_info(dev, client->nam=
e,
> > > +							 mcu,
> > > +							 &sg2042_mcu_chip_info,
> > > +							 NULL);
> > > +
> > > +	return PTR_ERR_OR_ZERO(hwmon_dev);
> > > +}
> > > +
> > > +static void sg2042_mcu_i2c_remove(struct i2c_client *client)
> > > +{
> > > +	struct device *dev =3D &client->dev;
> > > +
> > > +	sysfs_remove_group(&dev->kobj, &sg2042_mcu_attr_group);
> > > +}
> > > +
> > > +static const struct i2c_device_id sg2042_mcu_id[] =3D {
> > > +	{ "sg2042-hwmon-mcu", 0 },
> > > +	{},
> > > +};
> > > +MODULE_DEVICE_TABLE(i2c, sg2042_mcu_id);
> > > +
> > > +static const struct of_device_id sg2042_mcu_of_id[] =3D {
> > > +	{ .compatible =3D "sophgo,sg2042-hwmon-mcu" },
> > > +	{},
> > > +};
> > > +MODULE_DEVICE_TABLE(of, sg2042_mcu_of_id);
> > > +
> > > +static struct i2c_driver sg2042_mcu_driver =3D {
> > > +	.driver =3D {
> > > +		.name =3D "sg2042-mcu",
> > > +		.of_match_table =3D sg2042_mcu_of_id,
> > > +	},
> > > +	.probe =3D sg2042_mcu_i2c_probe,
> > > +	.remove =3D sg2042_mcu_i2c_remove,
> > > +	.id_table =3D sg2042_mcu_id,
> > > +};
> > > +
> > > +module_i2c_driver(sg2042_mcu_driver);
> > > +
> > > +MODULE_DESCRIPTION("MCU I2C driver for bm16xx soc platform");
> > > +MODULE_LICENSE("GPL");
> > > --
> > > 2.44.0
> > >=20
> >=20

--ElZFJzxsTJ1G0HEO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZi5uZgAKCRB4tDGHoIJi
0pqYAPsEE2d0qXwxxezSVVevzDkUFQBuTtF9GVEuL/3jq6gPSgD/Yoe786nEC2fM
iowZYOY+/P8WTH2s5k5psq70FsZSwww=
=+mOp
-----END PGP SIGNATURE-----

--ElZFJzxsTJ1G0HEO--

