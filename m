Return-Path: <linux-kernel+bounces-65547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB07A854E91
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6106228462B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54A376036;
	Wed, 14 Feb 2024 16:28:25 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2B264A9B;
	Wed, 14 Feb 2024 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928105; cv=none; b=CmnWdnf4gOe8bijBwW/LEoFrtYSy3bM2ufEV2s+2Q7tNHYP7L2iNuBj0WiToVrtmuYoITmOz2ZyniWKD3sf4Khk1guPPKq/7n3jfw+1j0pO/PElRbijpL7IuAGr1N/+SlEWGM70CLFqQ4v4vitFnInZAUc1Z8QvUjnq6gnRtc/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928105; c=relaxed/simple;
	bh=f2bPftzFq4ULI5UCUxmbzGjwSXmIUKk52LYeVYGadlE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOJa3ePN61sYryUesyVOUpEcI+zX8mUrNsnfZUQiXlZNDbq6nrkpB3r+2+Oy7/D8+zMzwpHNvMG7j0NFaVul0bKS/aBCgXi4piCtERJg4FNXdH5x1gyRjW9QB7jp0Py2eVI1EPq0+e9GKnsQTrjOG/qnZhjoMR/i5U47J05zquY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZk791cXVz6K8sR;
	Thu, 15 Feb 2024 00:24:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A184C140CB9;
	Thu, 15 Feb 2024 00:28:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 16:28:19 +0000
Date: Wed, 14 Feb 2024 16:28:18 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, Icenowy Zheng
	<icenowy@aosc.io>, <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dalton Durst <dalton@ubports.com>, "Shoji
 Keita" <awaittrot@shjk.jp>
Subject: Re: [PATCH 4/4] iio: magnetometer: add a driver for Voltafield
 AF8133J magnetometer
Message-ID: <20240214162818.0000221a@Huawei.com>
In-Reply-To: <skmvl3wxom6jnfh4fcvpkmswswwkfj3yopb6ahvymcwrxw5ou4@ljzmreuqiwme>
References: <20240211205211.2890931-1-megi@xff.cz>
	<20240211205211.2890931-5-megi@xff.cz>
	<20240212130232.00007ebd@Huawei.com>
	<skmvl3wxom6jnfh4fcvpkmswswwkfj3yopb6ahvymcwrxw5ou4@ljzmreuqiwme>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 12 Feb 2024 16:04:02 +0100
Ond=C5=99ej Jirman <megi@xff.cz> wrote:

> Hi Jonathan,
>=20
> thank you for the patch review.
>=20
> On Mon, Feb 12, 2024 at 01:02:32PM +0000, Jonathan Cameron wrote:
> > On Sun, 11 Feb 2024 21:52:00 +0100
> > Ond=C5=99ej Jirman <megi@xff.cz> wrote:
> >  =20
> > > From: Icenowy Zheng <icenowy@aosc.io>
> > >=20
> > > AF8133J is a simple I2C-connected magnetometer, without interrupts.
> > >=20
> > > Add a simple IIO driver for it.
> > >=20
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > Signed-off-by: Dalton Durst <dalton@ubports.com>
> > > Signed-off-by: Shoji Keita <awaittrot@shjk.jp>
> > > Signed-off-by: Ondrej Jirman <megi@xff.cz> =20
> >=20
> > This is a lot of sign offs.  If accurate it menas.
> >=20
> > Icenowy wrote teh driver,
> > Dalton then 'handled' it on the path to Shoji who
> > then 'handled' it on the path to Ondrej.
> >=20
> > That's possible if it's been in various other trees for instance, but
> > I'd like some more explanation below the --- if that is the case.
> > Otherwise, maybe Co-developed-by: is appropriate for some of
> > the above list? =20
>=20
> Icenowy wrote basic driver, initially. Here's some older version with onl=
y Icenowy sign off:
>=20
> https://github.com/Icenowy/linux/commit/468ceb921dae9d75064c46d13c60cab2b=
42362b3
Ok. So probably the author should be Icenowy as you have it.
>=20
> I picked the patch into my linux tree a few years back from one of the Mo=
bile
> Linux distributions, likely Mobian:
>=20
> https://megous.com/git/linux/commit/?h=3Daf8133j-5.17&id=3D1afd43b002a02c=
ade051acbe7851101258e60194
>=20
> So I guess Dalton and/or Shoji added the orientation matrix support, beca=
use
> that and addition of some error logging is the only difference between pu=
re Icenowy
> version and the version with other sign offs.
ok.  If we can figure that out, seems like co-developed for them as well is=
 appropriate.

>=20
> Then I rewrote large parts of the driver and added a few new features, li=
ke
> support for changing the scale/range, RPM, and buffered mode.
Defintely a co-developed for you then!
>=20
> So I don't know how to reflect this in the tags. :) It passed through all=
 of
> these people, and all of them touched it in some way, I think.

Lots of co-developed probably most appropriate.  Basically add one for each
SoB other than Iceynow's

> > > +
> > > +static int af8133j_power_up(struct af8133j_data *data)
> > > +{
> > > +	struct device *dev =3D &data->client->dev;
> > > +	int ret;
> > > +
> > > +	if (data->powered)
> > > +		return 0;
> > > +
> > > +	ret =3D regulator_bulk_enable(AF8133J_NUM_SUPPLIES, data->supplies);
> > > +	if (ret) {
> > > +		dev_err(dev, "Could not enable regulators\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	gpiod_set_value_cansleep(data->reset_gpiod, 0);
> > > +
> > > +	/* Wait for power on reset */
> > > +	usleep_range(15000, 16000);
> > > +
> > > +	data->powered =3D true; =20
> >=20
> > Why is this needed?  The RPM code is reference counted, so I don't think
> > we should need this. =20
>=20
> It's here because of code in af8133j_remove just disables RPM and then ca=
lls
> af8133j_power_down(). I guess it can be done via RPM, too, by disabling
> autosuspend and leaving it to RPM callbacks.

ah. Don't use a flag for that, add a little utility function
that takes it as an explicit parameter.  Make sure you wake the device
up using runtime_pm then disable runtime pm before powering it down manuall=
y.

>=20
> > > +	return 0;

..


> > > +
> > > +	ret =3D af8133j_take_measurement(data);
> > > +	if (ret =3D=3D 0)
> > > +		ret =3D regmap_bulk_read(data->regmap, AF8133J_REG_OUT,
> > > +				       buf, sizeof(__le16) * 3);
> > > +
> > > +	mutex_unlock(&data->mutex);
> > > +
> > > +	pm_runtime_mark_last_busy(dev);
> > > +	if (pm_runtime_put_autosuspend(dev))
> > > +		dev_err(dev, "failed to power off\n"); =20
> > I think this will only happen if suspend returns non 0 and yours
> > doesn't.  What else might cause this? =20
>=20
> I don't know, there's quite a deep callflow under
> https://elixir.bootlin.com/linux/latest/source/include/linux/pm_runtime.h=
#L470
> with a lot of error paths. I'd say it's very unlikely to get na error her=
e.
>=20
> I can drop it if you like.

I would.  If something odd is going on a developer can easily
add a check back in to debug it.
>=20
> > > +
> > > +	return ret;
> > > +} =20

..

> >  =20
> > > +	pm_runtime_enable(dev);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void af8133j_remove(struct i2c_client *client)
> > > +{
> > > +	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> > > +	struct af8133j_data *data =3D iio_priv(indio_dev);
> > > +	struct device *dev =3D &data->client->dev;
> > > +
> > > +	pm_runtime_disable(dev);
> > > +	pm_runtime_set_suspended(dev);
> > > +
> > > +	af8133j_power_down(data); =20
> >=20
> > Can normally push these into callbacks using
> > devm_add_action_or_reset()=20
> > That avoids need for either explicit error handling or a remove()
> >=20
> > You power the device down here, but there isn't a matching call to
> > power it up in probe() (as it is powered down in there - which you
> > should leave to runtime_pm()) =20
>=20
> Yes, that's the reason for powered tracking in the driver.
>=20
ok.  Try and avoid that and just let runtime pm deal with it for you.

For future reference, crop out anything you have commented on in
a review. It saves on scrolling and reduces chances of stuff being
missed in the dicussion.


Jonathan


