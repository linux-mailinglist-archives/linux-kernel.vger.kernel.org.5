Return-Path: <linux-kernel+bounces-65706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AE085509F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C23C1F2235B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08601272B5;
	Wed, 14 Feb 2024 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="UPQem6Ph"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4FC8614B;
	Wed, 14 Feb 2024 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932603; cv=none; b=s4zKMQ5zOcoFf8O3J+dsyHP/nTgdBx/ObYJ9WScJ1NtE0avWOjI8L8nJeA+x+Lg+6NEICgz+bZIU/p2zaQSq5Bb+aoQ+rGtguV+lNilVCSf7SP1lxEyOcWN9Zdg3N0vhB8PmsSXVbJT8o8z2utjgExoHxV/s/J4mtQDtkYM1bLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932603; c=relaxed/simple;
	bh=Z/lfXUcaSfx7+YfriviH2yuZMB0T8dNoQ49Me3prcTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPH8eKnDNVC4/zkAWgSS0eZ6sOzWRdgBEYttBA59RVFjW4A+TSa4BsOjQcy5feJu4ZW6hGvJPrKatnzeoDs/hUg7jJSxhVvP0i/WJ5anlme/T3u5ulx+hLMn5SYZva0wSfmcVkYXgzruC7xljKUGZGjiaOlaUk0XFw0QfMNlD5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=UPQem6Ph; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1707932590; bh=Z/lfXUcaSfx7+YfriviH2yuZMB0T8dNoQ49Me3prcTU=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=UPQem6PhM6lSQSmts9ohxyoqQ0h5MBiQmRX4YQmYNhRpKzVTvlJE00hkeT/Vi7vJm
	 zIdClQUDoe7UXVIsuPAZNt7nKz4lJt/08TSBD2eNXegEVF0Ua0bH9cAWoOTIjjU3oS
	 7izu2iQMHLfSvX68e8+ZPhs8UE2LHfDQlXgDd2Gk=
Date: Wed, 14 Feb 2024 18:43:10 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, Icenowy Zheng <icenowy@aosc.io>, 
	Dalton Durst <dalton@ubports.com>, Shoji Keita <awaittrot@shjk.jp>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: magnetometer: add a driver for Voltafield
 AF8133J magnetometer
Message-ID: <q2w6ll3dbr2pjcm3kuh2yckbgwk2er7k44uyq6hmdcdci4acek@htxdnogdpoza>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, Icenowy Zheng <icenowy@aosc.io>, 
	Dalton Durst <dalton@ubports.com>, Shoji Keita <awaittrot@shjk.jp>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240212175410.3101973-1-megi@xff.cz>
 <20240212175410.3101973-4-megi@xff.cz>
 <20240214170136.00003a22@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240214170136.00003a22@Huawei.com>

Hi Jonathan,

On Wed, Feb 14, 2024 at 05:01:36PM +0000, Jonathan Cameron wrote:
> On Mon, 12 Feb 2024 18:53:55 +0100
> Ondřej Jirman <megi@xff.cz> wrote:
> 
> > From: Icenowy Zheng <icenowy@aosc.io>
> > 
> > AF8133J is a simple I2C-connected magnetometer, without interrupts.
> > 
> > Add a simple IIO driver for it.
> > 
> > Co-developed-by: Icenowy Zheng <icenowy@aosc.io>
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > Signed-off-by: Dalton Durst <dalton@ubports.com>
> > Signed-off-by: Shoji Keita <awaittrot@shjk.jp>
> > Co-developed-by: Ondrej Jirman <megi@xff.cz>
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> 
> 
> Hi a few comments (mostly on changes)
> 
> The runtime_pm handling can be simplified somewhat if you
> rearrange probe a little.
> 
> > diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magnetometer/af8133j.c
> > new file mode 100644
> > index 000000000000..1f64a2337f6e
> > --- /dev/null
> > +++ b/drivers/iio/magnetometer/af8133j.c
> > @@ -0,0 +1,528 @@
> 
> 
> > +static int af8133j_take_measurement(struct af8133j_data *data)
> > +{
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	ret = regmap_write(data->regmap,
> > +			   AF8133J_REG_STATE, AF8133J_REG_STATE_WORK);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* The datasheet says "Mesaure Time <1.5ms" */
> > +	ret = regmap_read_poll_timeout(data->regmap, AF8133J_REG_STATUS, val,
> > +				       val & AF8133J_REG_STATUS_ACQ,
> > +				       500, 1500);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = regmap_write(data->regmap,
> > +			   AF8133J_REG_STATE, AF8133J_REG_STATE_STBY);
> 
> return regmap_write()
> 
> regmap accesses return 0 or a negative error code enabling little code
> reductions like this.

Yeah, some reviewers dislike this, because modifying the code in the future
creates a more unpleasant diff. But if you like this style, I don't mind
changing it.

> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +static int af8133j_read_measurement(struct af8133j_data *data, __le16 buf[3])
> > +{
> > +	struct device *dev = &data->client->dev;
> > +	int ret;
> > +
> > +	ret = pm_runtime_resume_and_get(dev);
> > +	if (ret) {
> > +		/*
> > +		 * Ignore EACCES because that happens when RPM is disabled
> > +		 * during system sleep, while userspace leave eg. hrtimer
> > +		 * trigger attached and IIO core keeps trying to do measurements.
> 
> Yeah. We still need to fix that more elegantly :(
> 
> > +		 */
> > +		if (ret != -EACCES)
> > +			dev_err(dev, "Failed to power on (%d)\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	scoped_guard(mutex, &data->mutex) {
> > +		ret = af8133j_take_measurement(data);
> > +		if (ret)
> > +			goto out_rpm_put;
> > +
> > +		ret = regmap_bulk_read(data->regmap, AF8133J_REG_OUT,
> > +				       buf, sizeof(__le16) * 3);
> > +	}
> > +
> > +out_rpm_put:
> > +	pm_runtime_mark_last_busy(dev);
> > +	pm_runtime_put_autosuspend(dev);
> > +
> > +	return ret;
> > +}
> > +
> 
> 
> > +
> > +static int af8133j_set_scale(struct af8133j_data *data,
> > +			     unsigned int val, unsigned int val2)
> > +{
> > +	struct device *dev = &data->client->dev;
> > +	u8 range;
> > +	int ret = 0;
> > +
> > +	if (af8133j_scales[0][0] == val && af8133j_scales[0][1] == val2)
> > +		range = AF8133J_REG_RANGE_12G;
> > +	else if (af8133j_scales[1][0] == val && af8133j_scales[1][1] == val2)
> > +		range = AF8133J_REG_RANGE_22G;
> > +	else
> > +		return -EINVAL;
> > +
> > +	pm_runtime_disable(dev);
> > +
> > +	/*
> > +	 * When suspended, just store the new range to data->range to be
> > +	 * applied later during power up.
> Better to just do
> 	pm_runtime_resume_and_get() here
> 
> > +	 */
> > +	if (!pm_runtime_status_suspended(dev))
> > +		ret = regmap_write(data->regmap, AF8133J_REG_RANGE, range);
> > +
> > +	pm_runtime_enable(dev);
> and
> 	pm_runtime_mark_last_busy(dev);
> 	pm_runtime_put_autosuspend(dev);
> here.
> 
> The userspace interface is only way this function is called so rearrange
> probe a little so that you don't need extra complexity in these functions.

It doesn't make sense to wakeup the device for range change, because it will
forget the range the moment it's powered off again, after changing the range.

Also this function has nothing to do with probe. data->range is authoritative
value, not cache. It gets applied to HW on each power up.

> 
> > +
> > +	data->range = range;
> 
> If the write failed, generally don't update the cached value.

Right.

> > +	return ret;
> > +}
> > +
> > +static int af8133j_write_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int val, int val2, long mask)
> > +{
> > +	struct af8133j_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SCALE:
> > +		scoped_guard(mutex, &data->mutex)
> > +			ret = af8133j_set_scale(data, val, val2);
> 
> Look more closely at what scoped_guard() does.
> 			return af8133j_set_scale(data, val, val2);
> is fine and simpler as no local variable needed.

I did, it will not work as you suggest. It's implemented as for loop with
condition, and the compiler will complain about fallthrough.

I can do:

		scoped_guard(mutex, &data->mutex)
			return af8133j_set_scale(data, val, val2);
		return 0;

but it looks weirder at first glance, at least to my eye.

> > +		return ret;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> 
> > +static void af8133j_power_down_action(void *ptr)
> > +{
> > +	struct af8133j_data *data = ptr;
> > +	struct device *dev = &data->client->dev;
> > +
> > +	pm_runtime_disable(dev);
> You group together unwinding of calls that occur in very
> different places in probe.  Don't do that as it leas
> to disabling runtime pm having never enabled it
> in some error paths.  That may be safe but if fails the
> obviously correct test.

This whole disable/enable dance is here so that pm_runtime_status_suspended can
be trusted. Not for disabling PM during device remove or in error paths.

There's no imbalance here or problem with disabling PM when it's already
disabled. Disable/enable is reference counted, and this function keeps the
balance.

> 
> Instead, have multiple callbacks registered.
> Disable will happen anyway due to 
> > +	if (!pm_runtime_status_suspended(dev))
> This works as the stub for no runtime pm support returns
> false.

Output can't be trusted as long as RPM is enabled.

> So this is a good solution to the normal dance of turning power on
> just to turn it off shortly afterwards.
> 
> > +		af8133j_power_down(data);
> > +	pm_runtime_enable(dev);
> Why?

See above. To keep the disable ref count balanced.

Looks like actual RPM disable already happened at this point a bit earlier in
another callback registered via devm_pm_runtime_enable(). I guess this
pm_runtime_enable()/pm_runtime_disable() guard can just be skipped, because RPM
is already disabled thanks to reverse ordering of devm callbacks during device
remove. So while this is safe, it's redundant at this point and call to 
pm_runtime_status_suspended() is safe without this.

> > +}
> > +
> > +static int af8133j_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct af8133j_data *data;
> > +	struct iio_dev *indio_dev;
> > +	struct regmap *regmap;
> > +	int ret, i;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	regmap = devm_regmap_init_i2c(client, &af8133j_regmap_config);
> > +	if (IS_ERR(regmap))
> > +		return dev_err_probe(dev, PTR_ERR(regmap),
> > +				     "regmap initialization failed\n");
> > +
> > +	data = iio_priv(indio_dev);
> > +	i2c_set_clientdata(client, indio_dev);
> > +	data->client = client;
> > +	data->regmap = regmap;
> > +	data->range = AF8133J_REG_RANGE_12G;
> > +	mutex_init(&data->mutex);
> > +
> > +	data->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(data->reset_gpiod))
> > +		return dev_err_probe(dev, PTR_ERR(data->reset_gpiod),
> > +				     "Failed to get reset gpio\n");
> > +
> > +	for (i = 0; i < ARRAY_SIZE(af8133j_supply_names); i++)
> > +		data->supplies[i].supply = af8133j_supply_names[i];
> > +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->supplies),
> > +				      data->supplies);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = iio_read_mount_matrix(dev, &data->orientation);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to read mount matrix\n");
> > +
> > +	ret = af8133j_power_up(data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pm_runtime_set_active(dev);
> > +
> > +	ret = devm_add_action_or_reset(dev, af8133j_power_down_action, data);
> 
> As mentioned above, this should only undo things done before this point.
> So just the af8133j_power_down() I think.

The callback doesn't do anything else but power down. It leaves everything
else as is after it exits.

> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = af8133j_product_check(data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	indio_dev->info = &af8133j_info;
> > +	indio_dev->name = "af8133j";
> > +	indio_dev->channels = af8133j_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(af8133j_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > +					      &af8133j_trigger_handler, NULL);
> > +	if (ret < 0)
> > +		return dev_err_probe(&client->dev, ret,
> > +				     "Failed to setup iio triggered buffer\n");
> > +
> > +	ret = devm_iio_device_register(dev, indio_dev);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to register iio device");
> > +
> > +	pm_runtime_get_noresume(dev);
> 
> > +	pm_runtime_use_autosuspend(dev);
> > +	pm_runtime_set_autosuspend_delay(dev, 500);
> > +	ret = devm_pm_runtime_enable(dev);
> 
> This already deals with pm_runtime_disable() so you shouldn't need do it manually.

I'm not disabling RPM manually, it was just used as temporary guard to be able
to read pm_runtime_status_suspended() safely.

> Also you want to enable that before the devm_iio_device_register() to avoid
> problems with it not being available as the userspace interfaces are used.
>
> So just move this up a few lines.

Good idea, thanks.

kind regards,
	o.

> 
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	pm_runtime_put_autosuspend(dev);
> > +
> > +	return 0;
> > +}
> 

