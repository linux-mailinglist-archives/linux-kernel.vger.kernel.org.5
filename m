Return-Path: <linux-kernel+bounces-69106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2A68584A9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9F64B22567
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A953F13341A;
	Fri, 16 Feb 2024 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="rrZf/b9j"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89E913174F;
	Fri, 16 Feb 2024 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106063; cv=none; b=b4DJ6g4fUaqwWuSj8Tf58w/A7dwzi0Uhmx/mpDqlaiLG4+I4HU1IPcaX3B715q4h+vHxLvkgvv0b863rc+JUtK8kA2GNSh4TdfU0TfMLmeg/KEsGiUFy17LBYN+kxQRpiaYvmDlyyQx+VmxlLdpkxLVjNHt0DaY309MjpUHlou4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106063; c=relaxed/simple;
	bh=PN3DC4gQo2sVUx2XL7DqLhJtEgEXa1SqlCzvj56NJ9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3t3C6t83tT1XhhsjCrCkhz4Q3K3qKhdijLw5RnUZsKihbs1eb1wxtFB/xXnETz6OCXZP4X/xZ75AschfNJwUukc9GGqLdv2PDmz/SevrWf79axrvJT4DdtWZfeoJgW0x5pq0NJDyNtHxEtyIw5aSa3CIU7v1d3M6hmkhf56JD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=rrZf/b9j; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708106055; bh=PN3DC4gQo2sVUx2XL7DqLhJtEgEXa1SqlCzvj56NJ9w=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=rrZf/b9j/ERtjKNzyAc4v1uKL6M6Qmx6e7ouqA547c+GgRcv51NqZxCPVl+tC7TA/
	 eG0ALfd4S+MskqU7JuMmIEQYvwF38/VgTSXPYMTg5NleCMPkrm4CX+uf3qkT+TEN4F
	 Zc5v4ILJQUm+IhpF+Nbwmie3y7bI5jdPC8NK93/U=
Date: Fri, 16 Feb 2024 18:54:15 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, Icenowy Zheng <icenowy@aosc.io>, 
	Dalton Durst <dalton@ubports.com>, Shoji Keita <awaittrot@shjk.jp>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: magnetometer: add a driver for Voltafield
 AF8133J magnetometer
Message-ID: <rjy24xzrwk7kp5pefbzeqlq3fcx2gihfsqozmyb2ueuf5hjhmf@ercw57qq5lyi>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Jonathan Cameron <jic23@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
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
 <q2w6ll3dbr2pjcm3kuh2yckbgwk2er7k44uyq6hmdcdci4acek@htxdnogdpoza>
 <20240216153925.291e65e7@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240216153925.291e65e7@jic23-huawei>

On Fri, Feb 16, 2024 at 03:39:25PM +0000, Jonathan Cameron wrote:
> On Wed, 14 Feb 2024 18:43:10 +0100
> Ondřej Jirman <megi@xff.cz> wrote:
> 
> > Hi Jonathan,
> 
> Gah. Runtime pm always gives me a headache. I'd indeed misunderstood some
> of what you are doing.
> > 
> > [...]
> > 
> > I did, it will not work as you suggest. It's implemented as for loop with
> > condition, and the compiler will complain about fallthrough.
> > 
> > I can do:
> > 
> > 		scoped_guard(mutex, &data->mutex)
> > 			return af8133j_set_scale(data, val, val2);
> > 		return 0;
> > 
> > but it looks weirder at first glance, at least to my eye.
> 
> I agree that bit is less than ideal, but with your code it should also
> get confused about whether ret is ever set.
> 
> 		scoped_guard(mutex, &data->mutex)
> 			return ...
> 		unreachable();
> 
> perhaps?  or just use a guard and add scope manually
> 
> 	case IIO_CHAN_INFO_SCALE: {
> 		guard(mutex)(&data->mutex);
> 
> 		return af8133j_set_scale(...);
> 	}
> 
> I'd go with this as the cleanest solution in this case.

Yes, that looks much nicer. Thanks. :)

Though in the end I'll go with pushing the locking down to actual register
access in the af8133j_set_scale() function, so that I don't lock around
RPM disable/enable for no reason.

> 
> > 
> > > > +		return ret;
> > > > +	default:
> > > > +		return -EINVAL;
> > > > +	}
> > > > +}  
> > >   
> > > > +static void af8133j_power_down_action(void *ptr)
> > > > +{
> > > > +	struct af8133j_data *data = ptr;
> > > > +	struct device *dev = &data->client->dev;
> > > > +
> > > > +	pm_runtime_disable(dev);  
> > > You group together unwinding of calls that occur in very
> > > different places in probe.  Don't do that as it leas
> > > to disabling runtime pm having never enabled it
> > > in some error paths.  That may be safe but if fails the
> > > obviously correct test.  
> > 
> > This whole disable/enable dance is here so that pm_runtime_status_suspended can
> > be trusted. Not for disabling PM during device remove or in error paths.
> > 
> > There's no imbalance here or problem with disabling PM when it's already
> > disabled. Disable/enable is reference counted, and this function keeps the
> > balance.
> 
> Whilst not buggy but I still want to be able to cleanly associate a given
> bit of cleanup with what is being cleaned up.  That is the path to
> maintainable code longer term.  Runtime PM does make a mess of doing this
> but tends to have somewhat logical sets of calls that go together.
> 
> As long as we hold a reference, doesn't matter when we turn it on in probe()
> Only the put_autosuspend has to come after we done talking to it.
> 	
> > 
> > > So this is a good solution to the normal dance of turning power on
> > > just to turn it off shortly afterwards.
> > >   
> > > > +		af8133j_power_down(data);
> > > > +	pm_runtime_enable(dev);  
> > > Why?  
> > 
> > See above. To keep the disable ref count balanced.
> > 
> > Looks like actual RPM disable already happened at this point a bit earlier in
> > another callback registered via devm_pm_runtime_enable(). I guess this
> > pm_runtime_enable()/pm_runtime_disable() guard can just be skipped, because RPM
> > is already disabled thanks to reverse ordering of devm callbacks during device
> > remove. So while this is safe, it's redundant at this point and call to 
> > pm_runtime_status_suspended() is safe without this.
> 
> Yes, That's a side effect of only enabling it right at the end.
> 
> > 
> > > > +}
> > > > +
> > > > +static int af8133j_probe(struct i2c_client *client)
> > > > +{
> > > > +	struct device *dev = &client->dev;
> > > > +	struct af8133j_data *data;
> > > > +	struct iio_dev *indio_dev;
> > > > +	struct regmap *regmap;
> > > > +	int ret, i;
> > > > +
> > > > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > > > +	if (!indio_dev)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	regmap = devm_regmap_init_i2c(client, &af8133j_regmap_config);
> > > > +	if (IS_ERR(regmap))
> > > > +		return dev_err_probe(dev, PTR_ERR(regmap),
> > > > +				     "regmap initialization failed\n");
> > > > +
> > > > +	data = iio_priv(indio_dev);
> > > > +	i2c_set_clientdata(client, indio_dev);
> > > > +	data->client = client;
> > > > +	data->regmap = regmap;
> > > > +	data->range = AF8133J_REG_RANGE_12G;
> > > > +	mutex_init(&data->mutex);
> > > > +
> > > > +	data->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > > > +	if (IS_ERR(data->reset_gpiod))
> > > > +		return dev_err_probe(dev, PTR_ERR(data->reset_gpiod),
> > > > +				     "Failed to get reset gpio\n");
> > > > +
> > > > +	for (i = 0; i < ARRAY_SIZE(af8133j_supply_names); i++)
> > > > +		data->supplies[i].supply = af8133j_supply_names[i];
> > > > +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->supplies),
> > > > +				      data->supplies);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = iio_read_mount_matrix(dev, &data->orientation);
> > > > +	if (ret)
> > > > +		return dev_err_probe(dev, ret, "Failed to read mount matrix\n");
> > > > +
> > > > +	ret = af8133j_power_up(data);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	pm_runtime_set_active(dev);
> > > > +
> > > > +	ret = devm_add_action_or_reset(dev, af8133j_power_down_action, data);  
> > > 
> > > As mentioned above, this should only undo things done before this point.
> > > So just the af8133j_power_down() I think.  
> > 
> > The callback doesn't do anything else but power down. It leaves everything
> > else as is after it exits.
> > 
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = af8133j_product_check(data);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	indio_dev->info = &af8133j_info;
> > > > +	indio_dev->name = "af8133j";
> > > > +	indio_dev->channels = af8133j_channels;
> > > > +	indio_dev->num_channels = ARRAY_SIZE(af8133j_channels);
> > > > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > > > +
> > > > +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > > > +					      &af8133j_trigger_handler, NULL);
> > > > +	if (ret < 0)
> > > > +		return dev_err_probe(&client->dev, ret,
> > > > +				     "Failed to setup iio triggered buffer\n");
> > > > +
> > > > +	ret = devm_iio_device_register(dev, indio_dev);
> > > > +	if (ret)
> > > > +		return dev_err_probe(dev, ret, "Failed to register iio device");
> > > > +
> > > > +	pm_runtime_get_noresume(dev);  
> > >   
> > > > +	pm_runtime_use_autosuspend(dev);
> > > > +	pm_runtime_set_autosuspend_delay(dev, 500);
> > > > +	ret = devm_pm_runtime_enable(dev);  
> > > 
> > > This already deals with pm_runtime_disable() so you shouldn't need do it manually.  
> > 
> > I'm not disabling RPM manually, it was just used as temporary guard to be able
> > to read pm_runtime_status_suspended() safely.
> 
> I'd indeed misunderstood that. I forgot the oddity that runtime pm is effectively
> reference counting in only one direction for enable / disable and the opposite
> one for get and put.
> 
> pm_runtime_disable()
> pm_runtime_disable()
> pm_runtime_enable()
> pm_runtime_enable()
> pm_runtime_enable()
> is fine, but
> 
> pm_runtime_enable()
> pm_runtime_enable()
> pm_runtime_disable()
> pm_runtime_disable()
> pm_runtime_enable()
> is not.
> 
> Which makes sense when you realise it's all about ensuring it is off, but
> never ensuring that it is turned on.

Yeah. Enabling already enabled RPM is thankfully easier to catch though, due to
a kernel warning:

https://elixir.bootlin.com/linux/latest/source/drivers/base/power/runtime.c#L1494

Unbalanced disable is annoying though. Not sure why, but disable_depth even
persists device unbind, so next rebinding will leave RPM disabled after probe.

That is when doing this after intentionally make the driver disable RPM twice
in remove callback:

echo 4-001c > /sys/bus/i2c/drivers/af8133j/unbind
echo 4-001c > /sys/bus/i2c/drivers/af8133j/bind

(driver remove/probe gets called)

Maybe it's due to RPM dependencies on parent device. Dunno. But it's a silent
problem in this case.

regards,
	o.

> 
> 
> 
> > 
> > > Also you want to enable that before the devm_iio_device_register() to avoid
> > > problems with it not being available as the userspace interfaces are used.
> > >
> > > So just move this up a few lines.  
> > 
> > Good idea, thanks.
> > 
> > kind regards,
> > 	o.
> > 
> > > 
> > >   
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	pm_runtime_put_autosuspend(dev);
> > > > +
> > > > +	return 0;
> > > > +}  
> > >   
> 

