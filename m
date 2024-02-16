Return-Path: <linux-kernel+bounces-68894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A20858195
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FF2287A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEDE12FB03;
	Fri, 16 Feb 2024 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEl3zzTT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD1B12F5A0;
	Fri, 16 Feb 2024 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097981; cv=none; b=SLFhZ+bjsWGhTL0dy4QF/BJly++042b/82zZnGmqliydoGQL2vm7wxeVbl/R2aVQTRRqjtnRaQKGCbD1YIq/+5KoUvj8J0s5yauTaCNdGe/WEevMlvWOti0Y9Q9kNYbx6Fs9rJRkrN95YqPRclbzBFCwQgfRQ0JHMheAf74wa4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097981; c=relaxed/simple;
	bh=ug77jgNJzw49ZkFyyDb1lXLeQLO5A8W6PnqdwusgEKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MSznjsG5U9fNOSbHtQwv0oqP/Lu5W0VA255ed6F7uiyDXxLyp4AwdKH1vf2f/UKb9fq1o8Mp2BEmV9tzKiBShJefJFUEfdMAj/FT5hVednPkigVT6o6aQQtnJaCKukzl0W3aQ5RUFXe0zCiVpOiR0PNcUiL2KzLb5Q0fvR4YeLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEl3zzTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677E7C433C7;
	Fri, 16 Feb 2024 15:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708097981;
	bh=ug77jgNJzw49ZkFyyDb1lXLeQLO5A8W6PnqdwusgEKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fEl3zzTTpD/sTozKFytLdEB/ZFN3gbcEsn3CyclozDBOGOpn8+wwRD6k2WxqEaiKw
	 MNwrlmLVdIZ2CdA1U3fQbsJnSOsTc6a+0LEinl46IvdXIsM+lIZy5tBKXGhzSYBOrd
	 aN8KvZCt/ntgGBuIRqqjPs4jvZECZoPKXSHAPjvMOJjj213dAAmJRxOOaTKoXssYuR
	 jQHfW/H4F9LPkeA8oSlg2fq2adaK9TUNW+WJ+Qw1uEskN+9FhluvM2Y3PO3E9B6Qcf
	 0usc1Wxuy3wnQ5Bgtlrf7mT7bJ4TAo0xJ5Se4nCMYuXdgWUuNbexs5YZD/YVF4GqaM
	 ufYMG6DTaC8Gw==
Date: Fri, 16 Feb 2024 15:39:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?T25kxZllag==?= Jirman <megi@xff.cz>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>, Icenowy Zheng
 <icenowy@aosc.io>, Dalton Durst <dalton@ubports.com>, Shoji Keita
 <awaittrot@shjk.jp>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: magnetometer: add a driver for Voltafield
 AF8133J magnetometer
Message-ID: <20240216153925.291e65e7@jic23-huawei>
In-Reply-To: <q2w6ll3dbr2pjcm3kuh2yckbgwk2er7k44uyq6hmdcdci4acek@htxdnogdpoza>
References: <20240212175410.3101973-1-megi@xff.cz>
	<20240212175410.3101973-4-megi@xff.cz>
	<20240214170136.00003a22@Huawei.com>
	<q2w6ll3dbr2pjcm3kuh2yckbgwk2er7k44uyq6hmdcdci4acek@htxdnogdpoza>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 18:43:10 +0100
Ond=C5=99ej Jirman <megi@xff.cz> wrote:

> Hi Jonathan,

Gah. Runtime pm always gives me a headache. I'd indeed misunderstood some
of what you are doing.
>=20
> On Wed, Feb 14, 2024 at 05:01:36PM +0000, Jonathan Cameron wrote:
> > On Mon, 12 Feb 2024 18:53:55 +0100
> > Ond=C5=99ej Jirman <megi@xff.cz> wrote:
> >  =20
> > > From: Icenowy Zheng <icenowy@aosc.io>
> > >=20
> > > AF8133J is a simple I2C-connected magnetometer, without interrupts.
> > >=20
> > > Add a simple IIO driver for it.
> > >=20
> > > Co-developed-by: Icenowy Zheng <icenowy@aosc.io>
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > Signed-off-by: Dalton Durst <dalton@ubports.com>
> > > Signed-off-by: Shoji Keita <awaittrot@shjk.jp>
> > > Co-developed-by: Ondrej Jirman <megi@xff.cz>
> > > Signed-off-by: Ondrej Jirman <megi@xff.cz> =20
> >=20
> >=20
> > Hi a few comments (mostly on changes)
> >=20
> > The runtime_pm handling can be simplified somewhat if you
> > rearrange probe a little.
> >  =20
> > > diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magneto=
meter/af8133j.c
> > > new file mode 100644
> > > index 000000000000..1f64a2337f6e
> > > --- /dev/null
> > > +++ b/drivers/iio/magnetometer/af8133j.c
> > > @@ -0,0 +1,528 @@ =20
> >=20
> >  =20
> > > +static int af8133j_take_measurement(struct af8133j_data *data)
> > > +{
> > > +	unsigned int val;
> > > +	int ret;
> > > +
> > > +	ret =3D regmap_write(data->regmap,
> > > +			   AF8133J_REG_STATE, AF8133J_REG_STATE_WORK);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	/* The datasheet says "Mesaure Time <1.5ms" */
> > > +	ret =3D regmap_read_poll_timeout(data->regmap, AF8133J_REG_STATUS, =
val,
> > > +				       val & AF8133J_REG_STATUS_ACQ,
> > > +				       500, 1500);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	ret =3D regmap_write(data->regmap,
> > > +			   AF8133J_REG_STATE, AF8133J_REG_STATE_STBY); =20
> >=20
> > return regmap_write()
> >=20
> > regmap accesses return 0 or a negative error code enabling little code
> > reductions like this. =20
>=20
> Yeah, some reviewers dislike this, because modifying the code in the futu=
re
> creates a more unpleasant diff. But if you like this style, I don't mind
> changing it.

Always a gamble on chance of a modification coming.

In general I'd check regmap calls with if (ret) but don't feel that strongly
about that either.

So not really important either way.
>=20
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int af8133j_read_measurement(struct af8133j_data *data, __le1=
6 buf[3])
> > > +{
> > > +	struct device *dev =3D &data->client->dev;
> > > +	int ret;
> > > +
> > > +	ret =3D pm_runtime_resume_and_get(dev);
> > > +	if (ret) {
> > > +		/*
> > > +		 * Ignore EACCES because that happens when RPM is disabled
> > > +		 * during system sleep, while userspace leave eg. hrtimer
> > > +		 * trigger attached and IIO core keeps trying to do measurements. =
=20
> >=20
> > Yeah. We still need to fix that more elegantly :(
> >  =20
> > > +		 */
> > > +		if (ret !=3D -EACCES)
> > > +			dev_err(dev, "Failed to power on (%d)\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	scoped_guard(mutex, &data->mutex) {
> > > +		ret =3D af8133j_take_measurement(data);
> > > +		if (ret)
> > > +			goto out_rpm_put;
> > > +
> > > +		ret =3D regmap_bulk_read(data->regmap, AF8133J_REG_OUT,
> > > +				       buf, sizeof(__le16) * 3);
> > > +	}
> > > +
> > > +out_rpm_put:
> > > +	pm_runtime_mark_last_busy(dev);
> > > +	pm_runtime_put_autosuspend(dev);
> > > +
> > > +	return ret;
> > > +}
> > > + =20
> >=20
> >  =20
> > > +
> > > +static int af8133j_set_scale(struct af8133j_data *data,
> > > +			     unsigned int val, unsigned int val2)
> > > +{
> > > +	struct device *dev =3D &data->client->dev;
> > > +	u8 range;
> > > +	int ret =3D 0;
> > > +
> > > +	if (af8133j_scales[0][0] =3D=3D val && af8133j_scales[0][1] =3D=3D =
val2)
> > > +		range =3D AF8133J_REG_RANGE_12G;
> > > +	else if (af8133j_scales[1][0] =3D=3D val && af8133j_scales[1][1] =
=3D=3D val2)
> > > +		range =3D AF8133J_REG_RANGE_22G;
> > > +	else
> > > +		return -EINVAL;
> > > +
> > > +	pm_runtime_disable(dev);
> > > +
> > > +	/*
> > > +	 * When suspended, just store the new range to data->range to be
> > > +	 * applied later during power up. =20
> > Better to just do
> > 	pm_runtime_resume_and_get() here
> >  =20
> > > +	 */
> > > +	if (!pm_runtime_status_suspended(dev))
> > > +		ret =3D regmap_write(data->regmap, AF8133J_REG_RANGE, range);
> > > +
> > > +	pm_runtime_enable(dev); =20
> > and
> > 	pm_runtime_mark_last_busy(dev);
> > 	pm_runtime_put_autosuspend(dev);
> > here.
> >=20
> > The userspace interface is only way this function is called so rearrange
> > probe a little so that you don't need extra complexity in these functio=
ns. =20
>=20
> It doesn't make sense to wakeup the device for range change, because it w=
ill
> forget the range the moment it's powered off again, after changing the ra=
nge.

Ah.  I'd missed understood that. Thanks for extra explanation.

I'm not keen on the enable / disable dance but anything else is probably wo=
rse
(delaying update until we actually using it etc).



>=20
> Also this function has nothing to do with probe. data->range is authorita=
tive
> value, not cache. It gets applied to HW on each power up.
>=20
> >  =20
> > > +
> > > +	data->range =3D range; =20
> >=20
> > If the write failed, generally don't update the cached value. =20
>=20
> Right.
>=20
> > > +	return ret;
> > > +}
> > > +
> > > +static int af8133j_write_raw(struct iio_dev *indio_dev,
> > > +			     struct iio_chan_spec const *chan,
> > > +			     int val, int val2, long mask)
> > > +{
> > > +	struct af8133j_data *data =3D iio_priv(indio_dev);
> > > +	int ret;
> > > +
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_SCALE:
> > > +		scoped_guard(mutex, &data->mutex)
> > > +			ret =3D af8133j_set_scale(data, val, val2); =20
> >=20
> > Look more closely at what scoped_guard() does.
> > 			return af8133j_set_scale(data, val, val2);
> > is fine and simpler as no local variable needed. =20
>=20
> I did, it will not work as you suggest. It's implemented as for loop with
> condition, and the compiler will complain about fallthrough.
>=20
> I can do:
>=20
> 		scoped_guard(mutex, &data->mutex)
> 			return af8133j_set_scale(data, val, val2);
> 		return 0;
>=20
> but it looks weirder at first glance, at least to my eye.

I agree that bit is less than ideal, but with your code it should also
get confused about whether ret is ever set.

		scoped_guard(mutex, &data->mutex)
			return ...
		unreachable();

perhaps?  or just use a guard and add scope manually

	case IIO_CHAN_INFO_SCALE: {
		guard(mutex)(&data->mutex);

		return af8133j_set_scale(...);
	}

I'd go with this as the cleanest solution in this case.


>=20
> > > +		return ret;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +} =20
> >  =20
> > > +static void af8133j_power_down_action(void *ptr)
> > > +{
> > > +	struct af8133j_data *data =3D ptr;
> > > +	struct device *dev =3D &data->client->dev;
> > > +
> > > +	pm_runtime_disable(dev); =20
> > You group together unwinding of calls that occur in very
> > different places in probe.  Don't do that as it leas
> > to disabling runtime pm having never enabled it
> > in some error paths.  That may be safe but if fails the
> > obviously correct test. =20
>=20
> This whole disable/enable dance is here so that pm_runtime_status_suspend=
ed can
> be trusted. Not for disabling PM during device remove or in error paths.
>=20
> There's no imbalance here or problem with disabling PM when it's already
> disabled. Disable/enable is reference counted, and this function keeps the
> balance.

Whilst not buggy but I still want to be able to cleanly associate a given
bit of cleanup with what is being cleaned up.  That is the path to
maintainable code longer term.  Runtime PM does make a mess of doing this
but tends to have somewhat logical sets of calls that go together.

As long as we hold a reference, doesn't matter when we turn it on in probe()
Only the put_autosuspend has to come after we done talking to it.




=09
>=20
> > So this is a good solution to the normal dance of turning power on
> > just to turn it off shortly afterwards.
> >  =20
> > > +		af8133j_power_down(data);
> > > +	pm_runtime_enable(dev); =20
> > Why? =20
>=20
> See above. To keep the disable ref count balanced.
>=20
> Looks like actual RPM disable already happened at this point a bit earlie=
r in
> another callback registered via devm_pm_runtime_enable(). I guess this
> pm_runtime_enable()/pm_runtime_disable() guard can just be skipped, becau=
se RPM
> is already disabled thanks to reverse ordering of devm callbacks during d=
evice
> remove. So while this is safe, it's redundant at this point and call to=20
> pm_runtime_status_suspended() is safe without this.

Yes, That's a side effect of only enabling it right at the end.

>=20
> > > +}
> > > +
> > > +static int af8133j_probe(struct i2c_client *client)
> > > +{
> > > +	struct device *dev =3D &client->dev;
> > > +	struct af8133j_data *data;
> > > +	struct iio_dev *indio_dev;
> > > +	struct regmap *regmap;
> > > +	int ret, i;
> > > +
> > > +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> > > +	if (!indio_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	regmap =3D devm_regmap_init_i2c(client, &af8133j_regmap_config);
> > > +	if (IS_ERR(regmap))
> > > +		return dev_err_probe(dev, PTR_ERR(regmap),
> > > +				     "regmap initialization failed\n");
> > > +
> > > +	data =3D iio_priv(indio_dev);
> > > +	i2c_set_clientdata(client, indio_dev);
> > > +	data->client =3D client;
> > > +	data->regmap =3D regmap;
> > > +	data->range =3D AF8133J_REG_RANGE_12G;
> > > +	mutex_init(&data->mutex);
> > > +
> > > +	data->reset_gpiod =3D devm_gpiod_get_optional(dev, "reset", GPIOD_O=
UT_HIGH);
> > > +	if (IS_ERR(data->reset_gpiod))
> > > +		return dev_err_probe(dev, PTR_ERR(data->reset_gpiod),
> > > +				     "Failed to get reset gpio\n");
> > > +
> > > +	for (i =3D 0; i < ARRAY_SIZE(af8133j_supply_names); i++)
> > > +		data->supplies[i].supply =3D af8133j_supply_names[i];
> > > +	ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(data->supplies),
> > > +				      data->supplies);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D iio_read_mount_matrix(dev, &data->orientation);
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "Failed to read mount matrix\n");
> > > +
> > > +	ret =3D af8133j_power_up(data);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	pm_runtime_set_active(dev);
> > > +
> > > +	ret =3D devm_add_action_or_reset(dev, af8133j_power_down_action, da=
ta); =20
> >=20
> > As mentioned above, this should only undo things done before this point.
> > So just the af8133j_power_down() I think. =20
>=20
> The callback doesn't do anything else but power down. It leaves everything
> else as is after it exits.
>=20
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D af8133j_product_check(data);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	indio_dev->info =3D &af8133j_info;
> > > +	indio_dev->name =3D "af8133j";
> > > +	indio_dev->channels =3D af8133j_channels;
> > > +	indio_dev->num_channels =3D ARRAY_SIZE(af8133j_channels);
> > > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > > +
> > > +	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > > +					      &af8133j_trigger_handler, NULL);
> > > +	if (ret < 0)
> > > +		return dev_err_probe(&client->dev, ret,
> > > +				     "Failed to setup iio triggered buffer\n");
> > > +
> > > +	ret =3D devm_iio_device_register(dev, indio_dev);
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "Failed to register iio device");
> > > +
> > > +	pm_runtime_get_noresume(dev); =20
> >  =20
> > > +	pm_runtime_use_autosuspend(dev);
> > > +	pm_runtime_set_autosuspend_delay(dev, 500);
> > > +	ret =3D devm_pm_runtime_enable(dev); =20
> >=20
> > This already deals with pm_runtime_disable() so you shouldn't need do i=
t manually. =20
>=20
> I'm not disabling RPM manually, it was just used as temporary guard to be=
 able
> to read pm_runtime_status_suspended() safely.

I'd indeed misunderstood that. I forgot the oddity that runtime pm is effec=
tively
reference counting in only one direction for enable / disable and the oppos=
ite
one for get and put.

pm_runtime_disable()
pm_runtime_disable()
pm_runtime_enable()
pm_runtime_enable()
pm_runtime_enable()
is fine, but

pm_runtime_enable()
pm_runtime_enable()
pm_runtime_disable()
pm_runtime_disable()
pm_runtime_enable()
is not.

Which makes sense when you realise it's all about ensuring it is off, but
never ensuring that it is turned on.




>=20
> > Also you want to enable that before the devm_iio_device_register() to a=
void
> > problems with it not being available as the userspace interfaces are us=
ed.
> >
> > So just move this up a few lines. =20
>=20
> Good idea, thanks.
>=20
> kind regards,
> 	o.
>=20
> >=20
> >  =20
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	pm_runtime_put_autosuspend(dev);
> > > +
> > > +	return 0;
> > > +} =20
> >  =20


