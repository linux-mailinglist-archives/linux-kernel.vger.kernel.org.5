Return-Path: <linux-kernel+bounces-65609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C01854F57
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7665F1C2184B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0853D60B82;
	Wed, 14 Feb 2024 17:01:45 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17D160DC2;
	Wed, 14 Feb 2024 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930104; cv=none; b=OlWuKtyxKlYmFlZJux1YgFgU64nmUFX+wJZ4KWtMEeXE9WlbhowmLYPLBHrzMMNpapqMcfwlml4ZWdmZtmgKOLdxHAPrVRZbQ+vQpHpzFmtUmkk3Z5FPD315PaCQ4nWupvT/jkAINlGyT1FarErZzkvAiy2lzC7vF8G7fu3q0Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930104; c=relaxed/simple;
	bh=tP7PPmCwxb3w/ItsQ2l3HAoLtVbGyYY+RZhlA6Qba34=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwqkbesI8t/GyTZoMDJe7ytr1+311ZTSWFH+HBWHWVLQ+yFH/y2TP5soYgrHneO3TZfas4qfnb/3xH1qIAk1yXeQYJC5ORbBWe4z4aj4eE5PPabtxoimMSIUxAdMLuuKDREVc/AjS1qGU0Lx7U2Yiuhg86qk2I5Y2XzhbV3WSXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZkrx594yz6JB09;
	Thu, 15 Feb 2024 00:57:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B9F1C140B55;
	Thu, 15 Feb 2024 01:01:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 17:01:37 +0000
Date: Wed, 14 Feb 2024 17:01:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: =?UTF-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, Icenowy Zheng
	<icenowy@aosc.io>, Dalton Durst <dalton@ubports.com>, Shoji Keita
	<awaittrot@shjk.jp>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] iio: magnetometer: add a driver for Voltafield
 AF8133J magnetometer
Message-ID: <20240214170136.00003a22@Huawei.com>
In-Reply-To: <20240212175410.3101973-4-megi@xff.cz>
References: <20240212175410.3101973-1-megi@xff.cz>
	<20240212175410.3101973-4-megi@xff.cz>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 12 Feb 2024 18:53:55 +0100
Ond=C5=99ej Jirman <megi@xff.cz> wrote:

> From: Icenowy Zheng <icenowy@aosc.io>
>=20
> AF8133J is a simple I2C-connected magnetometer, without interrupts.
>=20
> Add a simple IIO driver for it.
>=20
> Co-developed-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Dalton Durst <dalton@ubports.com>
> Signed-off-by: Shoji Keita <awaittrot@shjk.jp>
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>


Hi a few comments (mostly on changes)

The runtime_pm handling can be simplified somewhat if you
rearrange probe a little.

> diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magnetomete=
r/af8133j.c
> new file mode 100644
> index 000000000000..1f64a2337f6e
> --- /dev/null
> +++ b/drivers/iio/magnetometer/af8133j.c
> @@ -0,0 +1,528 @@


> +static int af8133j_take_measurement(struct af8133j_data *data)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D regmap_write(data->regmap,
> +			   AF8133J_REG_STATE, AF8133J_REG_STATE_WORK);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* The datasheet says "Mesaure Time <1.5ms" */
> +	ret =3D regmap_read_poll_timeout(data->regmap, AF8133J_REG_STATUS, val,
> +				       val & AF8133J_REG_STATUS_ACQ,
> +				       500, 1500);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D regmap_write(data->regmap,
> +			   AF8133J_REG_STATE, AF8133J_REG_STATE_STBY);

return regmap_write()

regmap accesses return 0 or a negative error code enabling little code
reductions like this.

> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
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
> +		/*
> +		 * Ignore EACCES because that happens when RPM is disabled
> +		 * during system sleep, while userspace leave eg. hrtimer
> +		 * trigger attached and IIO core keeps trying to do measurements.

Yeah. We still need to fix that more elegantly :(

> +		 */
> +		if (ret !=3D -EACCES)
> +			dev_err(dev, "Failed to power on (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	scoped_guard(mutex, &data->mutex) {
> +		ret =3D af8133j_take_measurement(data);
> +		if (ret)
> +			goto out_rpm_put;
> +
> +		ret =3D regmap_bulk_read(data->regmap, AF8133J_REG_OUT,
> +				       buf, sizeof(__le16) * 3);
> +	}
> +
> +out_rpm_put:
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}
> +


> +
> +static int af8133j_set_scale(struct af8133j_data *data,
> +			     unsigned int val, unsigned int val2)
> +{
> +	struct device *dev =3D &data->client->dev;
> +	u8 range;
> +	int ret =3D 0;
> +
> +	if (af8133j_scales[0][0] =3D=3D val && af8133j_scales[0][1] =3D=3D val2)
> +		range =3D AF8133J_REG_RANGE_12G;
> +	else if (af8133j_scales[1][0] =3D=3D val && af8133j_scales[1][1] =3D=3D=
 val2)
> +		range =3D AF8133J_REG_RANGE_22G;
> +	else
> +		return -EINVAL;
> +
> +	pm_runtime_disable(dev);
> +
> +	/*
> +	 * When suspended, just store the new range to data->range to be
> +	 * applied later during power up.
Better to just do
	pm_runtime_resume_and_get() here

> +	 */
> +	if (!pm_runtime_status_suspended(dev))
> +		ret =3D regmap_write(data->regmap, AF8133J_REG_RANGE, range);
> +
> +	pm_runtime_enable(dev);
and
	pm_runtime_mark_last_busy(dev);
	pm_runtime_put_autosuspend(dev);
here.

The userspace interface is only way this function is called so rearrange
probe a little so that you don't need extra complexity in these functions.


> +
> +	data->range =3D range;

If the write failed, generally don't update the cached value.

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
> +		scoped_guard(mutex, &data->mutex)
> +			ret =3D af8133j_set_scale(data, val, val2);

Look more closely at what scoped_guard() does.
			return af8133j_set_scale(data, val, val2);
is fine and simpler as no local variable needed.

> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static void af8133j_power_down_action(void *ptr)
> +{
> +	struct af8133j_data *data =3D ptr;
> +	struct device *dev =3D &data->client->dev;
> +
> +	pm_runtime_disable(dev);
You group together unwinding of calls that occur in very
different places in probe.  Don't do that as it leas
to disabling runtime pm having never enabled it
in some error paths.  That may be safe but if fails the
obviously correct test.

Instead, have multiple callbacks registered.
Disable will happen anyway due to=20
> +	if (!pm_runtime_status_suspended(dev))
This works as the stub for no runtime pm support returns
false.

So this is a good solution to the normal dance of turning power on
just to turn it off shortly afterwards.

> +		af8133j_power_down(data);
> +	pm_runtime_enable(dev);
Why?

> +}
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
> +	for (i =3D 0; i < ARRAY_SIZE(af8133j_supply_names); i++)
> +		data->supplies[i].supply =3D af8133j_supply_names[i];
> +	ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(data->supplies),
> +				      data->supplies);
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
> +	pm_runtime_set_active(dev);
> +
> +	ret =3D devm_add_action_or_reset(dev, af8133j_power_down_action, data);

As mentioned above, this should only undo things done before this point.
So just the af8133j_power_down() I think.

> +	if (ret)
> +		return ret;
> +
> +	ret =3D af8133j_product_check(data);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->info =3D &af8133j_info;
> +	indio_dev->name =3D "af8133j";
> +	indio_dev->channels =3D af8133j_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(af8133j_channels);
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +					      &af8133j_trigger_handler, NULL);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to setup iio triggered buffer\n");
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register iio device");
> +
> +	pm_runtime_get_noresume(dev);

> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 500);
> +	ret =3D devm_pm_runtime_enable(dev);

This already deals with pm_runtime_disable() so you shouldn't need do it ma=
nually.
Also you want to enable that before the devm_iio_device_register() to avoid
problems with it not being available as the userspace interfaces are used.

So just move this up a few lines.


> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return 0;
> +}


