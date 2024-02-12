Return-Path: <linux-kernel+bounces-61590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C98F8513FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B8B1F243E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9DA3A1BC;
	Mon, 12 Feb 2024 13:02:42 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE0A1E52A;
	Mon, 12 Feb 2024 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742961; cv=none; b=V7vL4p0b6HmkKpcqZiUqH0iYgbAHOmaJggaoamdn7i1HuXKhdS6Nc4I1hki9MvOb0JNPthWL5fR4tZP/p9D+G+ApLtErlTCy4JijmJ34m6W+aCnvdyPRlZTae8UIAwNrHkrXh0mzfhuewrGEzdBmgzjc5A8Eqssuqf5wH5Aou8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742961; c=relaxed/simple;
	bh=dj4CI+BQmzbnaK/tJAWDhb4fIdz5SZMX9znWSJLe47I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IL3fSrvEIDH9KhUQnm6FeGNjyyJwAzv0v1SDbgEoFJcrvsTqedoYOoRyrT3J4TMGuDV7yGbqhEXBcSJU1EmxOcpv9/6jisQYwfZueE/LS/OnW/6KyQRwQkMDs35f1GIdO+TGwyiLCbjOvRyIDE7F1zSNqq5ETBC8wDsohYYVP2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TYPfl32S7z6839B;
	Mon, 12 Feb 2024 20:59:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B133F140136;
	Mon, 12 Feb 2024 21:02:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 12 Feb
 2024 13:02:34 +0000
Date: Mon, 12 Feb 2024 13:02:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: =?UTF-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, Icenowy Zheng
	<icenowy@aosc.io>, <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dalton Durst <dalton@ubports.com>, "Shoji
 Keita" <awaittrot@shjk.jp>
Subject: Re: [PATCH 4/4] iio: magnetometer: add a driver for Voltafield
 AF8133J magnetometer
Message-ID: <20240212130232.00007ebd@Huawei.com>
In-Reply-To: <20240211205211.2890931-5-megi@xff.cz>
References: <20240211205211.2890931-1-megi@xff.cz>
	<20240211205211.2890931-5-megi@xff.cz>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 11 Feb 2024 21:52:00 +0100
Ond=C5=99ej Jirman <megi@xff.cz> wrote:

> From: Icenowy Zheng <icenowy@aosc.io>
>=20
> AF8133J is a simple I2C-connected magnetometer, without interrupts.
>=20
> Add a simple IIO driver for it.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Dalton Durst <dalton@ubports.com>
> Signed-off-by: Shoji Keita <awaittrot@shjk.jp>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>

This is a lot of sign offs.  If accurate it menas.

Icenowy wrote teh driver,
Dalton then 'handled' it on the path to Shoji who
then 'handled' it on the path to Ondrej.

That's possible if it's been in various other trees for instance, but
I'd like some more explanation below the --- if that is the case.
Otherwise, maybe Co-developed-by: is appropriate for some of
the above list?

Various comments inline, but looks pretty good in general.

Thanks,

Jonathan

> diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magnetomete=
r/af8133j.c
> new file mode 100644
> index 000000000000..0b03417ba134
> --- /dev/null
> +++ b/drivers/iio/magnetometer/af8133j.c
> @@ -0,0 +1,525 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * af8133j.c - Voltafield AF8133J magnetometer driver
> + *
> + * Copyright 2021 Icenowy Zheng <icenowy@aosc.io>
> + * Copyright 2024 Ond=C5=99ej Jirman <megi@xff.cz>
> + */
> +
> +#include <linux/module.h>

Alphabetical order for these.
It's fine to separate out he IIO ones on their own as you have
done.

> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/regmap.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

Don't think you are using this as no custom attrs.


> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define AF8133J_DRV_NAME "af8133j"
> +
> +#define AF8133J_REG_OUT		0x03
> +#define AF8133J_REG_PCODE	0x00
> +#define AF8133J_REG_PCODE_VAL	0x5e
> +#define AF8133J_REG_STATUS	0x02
> +#define AF8133J_REG_STATUS_ACQ	BIT(0)
> +#define AF8133J_REG_STATE	0x0a
> +#define AF8133J_REG_STATE_STBY	0x00
> +#define AF8133J_REG_STATE_WORK	0x01
> +#define AF8133J_REG_RANGE	0x0b
> +#define AF8133J_REG_RANGE_22G	0x12
> +#define AF8133J_REG_RANGE_12G	0x34
> +#define AF8133J_REG_SWR		0x11
> +#define AF8133J_REG_SWR_PERFORM	0x81
> +
> +static const char * const af8133j_supply_names[] =3D {
> +	"avdd",
> +	"dvdd",
> +};
> +
> +#define AF8133J_NUM_SUPPLIES ARRAY_SIZE(af8133j_supply_names)

Just use this inline, or the size of the array of regulators.
No need for this define.


> +static int af8133j_product_check(struct af8133j_data *data)
> +{
> +	struct device *dev =3D &data->client->dev;
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D regmap_read(data->regmap, AF8133J_REG_PCODE, &val);
> +	if (ret < 0) {
> +		dev_err(dev, "Error reading product code (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	if (val !=3D AF8133J_REG_PCODE_VAL) {
> +		dev_err(dev, "Invalid product code (0x%02x)\n", val);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int af8133j_reset(struct af8133j_data *data)
> +{
> +	struct device *dev =3D &data->client->dev;
> +	int ret;
> +
> +	if (data->reset_gpiod) {
> +		/* If we have GPIO reset line, use it */
> +		gpiod_set_value_cansleep(data->reset_gpiod, 1);
> +		udelay(10);
> +		gpiod_set_value_cansleep(data->reset_gpiod, 0);
> +	} else {
> +		/* Otherwise use software reset */
> +		ret =3D regmap_write(data->regmap, AF8133J_REG_SWR,
> +				   AF8133J_REG_SWR_PERFORM);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to reset the chip\n");
> +			return ret;
> +		}
> +	}
> +
> +	/* Wait for reset to finish */
> +	usleep_range(1000, 1100);
> +
> +	/* Restore range setting */
> +	if (data->range =3D=3D AF8133J_REG_RANGE_22G) {
> +		ret =3D regmap_write(data->regmap, AF8133J_REG_RANGE, data->range);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int af8133j_power_up(struct af8133j_data *data)
> +{
> +	struct device *dev =3D &data->client->dev;
> +	int ret;
> +
> +	if (data->powered)
> +		return 0;
> +
> +	ret =3D regulator_bulk_enable(AF8133J_NUM_SUPPLIES, data->supplies);
> +	if (ret) {
> +		dev_err(dev, "Could not enable regulators\n");
> +		return ret;
> +	}
> +
> +	gpiod_set_value_cansleep(data->reset_gpiod, 0);
> +
> +	/* Wait for power on reset */
> +	usleep_range(15000, 16000);
> +
> +	data->powered =3D true;

Why is this needed?  The RPM code is reference counted, so I don't think
we should need this.

> +	return 0;
> +}
> +
> +static void af8133j_power_down(struct af8133j_data *data)
> +{
> +	if (!data->powered)
> +		return;
> +
> +	gpiod_set_value_cansleep(data->reset_gpiod, 1);
> +	regulator_bulk_disable(AF8133J_NUM_SUPPLIES, data->supplies);
> +	data->powered =3D false;
> +}

> +
> +static int af8133j_read_measurement(struct af8133j_data *data, __le16 bu=
f[3])
> +{
> +	struct device *dev =3D &data->client->dev;
> +	int ret;
> +
> +	ret =3D pm_runtime_resume_and_get(dev);
> +	if (ret) {
> +		dev_err(dev, "failed to power on\n");
> +		return ret;
> +	}
> +
> +	mutex_lock(&data->mutex);
	scoped_guard(mutex, &data->mutex) {
		ret =3D af8133j_take_measurement(data);
		if (ret)
			goto error_ret;

		ret =3D regmap_bulk_read(...)
	}

error_ret:

	pm_runtime_mark_last_busy(dev);


> +
> +	ret =3D af8133j_take_measurement(data);
> +	if (ret =3D=3D 0)
> +		ret =3D regmap_bulk_read(data->regmap, AF8133J_REG_OUT,
> +				       buf, sizeof(__le16) * 3);
> +
> +	mutex_unlock(&data->mutex);
> +
> +	pm_runtime_mark_last_busy(dev);
> +	if (pm_runtime_put_autosuspend(dev))
> +		dev_err(dev, "failed to power off\n");
I think this will only happen if suspend returns non 0 and yours
doesn't.  What else might cause this?
> +
> +	return ret;
> +}

> +
> +static int af8133j_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct af8133j_data *data =3D iio_priv(indio_dev);
> +	__le16 buf[3];
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D af8133j_read_measurement(data, buf);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val =3D sign_extend32(le16_to_cpu(buf[chan->address]),
> +				     chan->scan_type.realbits - 1);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D 0;
> +		*val2 =3D af8133j_scales[data->range =3D=3D AF8133J_REG_RANGE_12G ? 0 =
: 1][1];

Line length is a bit long and the ternary makes it less easy to read than w=
ould be ideal.
I'd just use an if / else.
		if (data->Range =3D=3D AF8133J_REG_RANGE_12G)
			*val2 =3D af8133j_scales[0][1];
		else
			*val2 =3D af8133j_scales[1][1];
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int af8133j_set_scale(struct af8133j_data *data,
> +			     unsigned int val, unsigned int val2)
> +{
> +	u8 range;
> +	int ret;
> +
> +	if (af8133j_scales[0][0] =3D=3D val && af8133j_scales[0][1] =3D=3D val2)
> +		range =3D AF8133J_REG_RANGE_12G;
> +	else if (af8133j_scales[1][0] =3D=3D val && af8133j_scales[1][1] =3D=3D=
 val2)
> +		range =3D AF8133J_REG_RANGE_22G;
> +	else
> +		return -EINVAL;
> +
> +	ret =3D regmap_write(data->regmap, AF8133J_REG_RANGE, range);
> +	if (ret =3D=3D 0)
	if (ret)
		return ret;

	data->range =3D range;

	return 0;

A little more code, but it is easier to review if we use the same pattern
everywhere.

> +		data->range =3D range;
> +
> +	return ret;
> +}
> +
> +static int af8133j_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct af8133j_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		mutex_lock(&data->mutex);

Consider using scoped_guard().

> +		ret =3D af8133j_set_scale(data, val, val2);
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int af8133j_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				     struct iio_chan_spec const *chan,
> +				     long mask)
> +{
> +	return IIO_VAL_INT_PLUS_NANO;
> +}
> +
> +static const struct iio_info af8133j_info =3D {
> +	.read_raw =3D af8133j_read_raw,
> +	.read_avail =3D af8133j_read_avail,
> +	.write_raw =3D af8133j_write_raw,
> +	.write_raw_get_fmt =3D af8133j_write_raw_get_fmt,
> +};
> +
> +static irqreturn_t af8133j_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct af8133j_data *data =3D iio_priv(indio_dev);
> +	s64 timestamp =3D iio_get_time_ns(indio_dev);
> +	struct {
> +		__le16 values[3];
> +		s64 timestamp __aligned(8);
> +	} sample;
> +	int ret;
> +
> +	memset(&sample, 0, sizeof(sample));
> +
> +	ret =3D af8133j_read_measurement(data, sample.values);
> +	if (ret =3D=3D 0)
> +		iio_push_to_buffers_with_timestamp(indio_dev, &sample, timestamp);
Prefer to keep the error path out of line

	if (ret)
		goto err_ret;

	iio_push_to_...

error_ret:
	iio_trigger...

It's a little more code, but the consistency of code organization makes
for easier review etc.

> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct regmap_config af8133j_regmap_config =3D {
> +	.name =3D "af8133j_regmap",
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D AF8133J_REG_SWR,
> +	.cache_type =3D REGCACHE_NONE,
> +};
> +
> +static int af8133j_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct af8133j_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int ret, i;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap =3D devm_regmap_init_i2c(client, &af8133j_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "regmap initialization failed\n");
> +
> +	data =3D iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client =3D client;
> +	data->regmap =3D regmap;
> +	data->range =3D AF8133J_REG_RANGE_12G;
> +	mutex_init(&data->mutex);
> +
> +	data->reset_gpiod =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_H=
IGH);
> +	if (IS_ERR(data->reset_gpiod))
> +		return dev_err_probe(dev, PTR_ERR(data->reset_gpiod),
> +				     "Failed to get reset gpio\n");
> +
> +	for (i =3D 0; i < AF8133J_NUM_SUPPLIES; i++)
> +		data->supplies[i].supply =3D af8133j_supply_names[i];
> +	ret =3D devm_regulator_bulk_get(dev, AF8133J_NUM_SUPPLIES, data->suppli=
es);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D iio_read_mount_matrix(dev, &data->orientation);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read mount matrix\n");
> +
> +	ret =3D af8133j_power_up(data);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D af8133j_reset(data);
> +	if (ret) {
> +		af8133j_power_down(data);
Moving over to this being handled by a devm callback would remove the need
for these manual calls.

> +		return ret;
> +	}
> +
> +	ret =3D af8133j_product_check(data);
> +	if (ret) {
> +		af8133j_power_down(data);
> +		return ret;
> +	}
> +
> +	af8133j_power_down(data);

Leave this to runtime_pm autosuspend.
Just make sure to set it as active with appropriate get and put to ensure
the autosuspend handling deals with this.


> +
> +	indio_dev->info =3D &af8133j_info;
> +	indio_dev->name =3D AF8133J_DRV_NAME;

As below. I'd rather see the string here.

> +	indio_dev->channels =3D af8133j_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(af8133j_channels);
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +					      &af8133j_trigger_handler, NULL);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +				     "failed to setup iio triggered buffer\n");
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register iio device");
> +
> +	pm_runtime_set_autosuspend_delay(dev, 500);
> +	pm_runtime_use_autosuspend(dev);

See the comment on this call in the header. You need to undo it manually - =
or
use devm_pm_runtime_enable()

> +	pm_runtime_enable(dev);
> +
> +	return 0;
> +}
> +
> +static void af8133j_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> +	struct af8133j_data *data =3D iio_priv(indio_dev);
> +	struct device *dev =3D &data->client->dev;
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +
> +	af8133j_power_down(data);

Can normally push these into callbacks using
devm_add_action_or_reset()=20
That avoids need for either explicit error handling or a remove()

You power the device down here, but there isn't a matching call to
power it up in probe() (as it is powered down in there - which you
should leave to runtime_pm())




> +}
> +
> +static int __maybe_unused af8133j_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct af8133j_data *data =3D iio_priv(indio_dev);
> +
> +	af8133j_power_down(data);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused af8133j_runtime_resume(struct device *dev)

No need to do the __maybe_unused with the changes below.
The new way of handling this is to expose them all to the compiler and
let it do dead code removal.

That's what the pm_ptr() magic does for us.



> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct af8133j_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D af8133j_power_up(data);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D af8133j_reset(data);
> +	if (ret) {
> +		af8133j_power_down(data);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +const struct dev_pm_ops af8133j_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resu=
me)

This set of macros are deprecated. =20
Use SYSTEM_SLEEP_PM_OPS etc in combination with pm_ptr()

> +	SET_RUNTIME_PM_OPS(af8133j_runtime_suspend, af8133j_runtime_resume, NUL=
L)
> +};

> +
> +static struct i2c_driver af8133j_driver =3D {
> +	.driver =3D {
> +		.name =3D AF8133J_DRV_NAME,

I'd prefer to just see the string here and where it used above.
The define just makes the code harder to read.  There is no
particular reason the driver name should match the iio_dev->name
so little advantage in enforcing that via a define.

> +		.of_match_table =3D af8133j_of_match,
> +		.pm =3D &af8133j_pm_ops,

pm_ptr()

otherwise you are going to get unused warnings for the struct.


> +	},
> +	.probe =3D af8133j_probe,
> +	.remove =3D af8133j_remove,
> +	.id_table =3D af8133j_id,
> +};
> +
> +module_i2c_driver(af8133j_driver);
> +
> +MODULE_AUTHOR("Icenowy Zheng <icenowy@aosc.io>");
> +MODULE_AUTHOR("Ond=C5=99ej Jirman <megi@xff.cz>");
> +MODULE_DESCRIPTION("Voltafield AF8133J magnetic sensor driver");
> +MODULE_LICENSE("GPL");


