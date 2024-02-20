Return-Path: <linux-kernel+bounces-72239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E9D85B110
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80ACF2858F5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B02A42A91;
	Tue, 20 Feb 2024 03:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="cHXdhSVJ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1890524B8;
	Tue, 20 Feb 2024 03:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708398072; cv=none; b=h+TEv+MYt831F62svCVn29i5Ph6lJaeliRef+yAZ1LV1Lp9PkjNJCrPNtT0Jls30NVDju6WKLqoJughEdKOFlFVm59Pl3m2pk3GjnBBdOvkeS5SQGn4Ue294ttDFAK8oAMPdEGbT6NLtp5exldq62NTsW2GXB0trE7sm7Sy67uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708398072; c=relaxed/simple;
	bh=fi2kbSyA3ZrfR3cC3WHLondtm0nGs7rJi1ZFqm0U/vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7sdltYFP9mdz/wR0KAwC6AwukyfxhlCS5uJmcnCNhQBh96efjtMLEqbNYsZpVGIhZJhGGvrikD/fOKcdXUEgfpOl48ESPmipZQmfcRKAIcbRVHb2S1mzWoWCSflAdPaxH/gzpVTGYnLYjHtfJqqFQXJWaLcqe5zywrQ3fdsn2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=cHXdhSVJ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5EBD8899;
	Tue, 20 Feb 2024 04:00:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708398053;
	bh=fi2kbSyA3ZrfR3cC3WHLondtm0nGs7rJi1ZFqm0U/vY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cHXdhSVJxQZjDv+YBnDEYoRoVutXWunp+mModsjWczVP65wmvKlAR8aTm4elJJbMF
	 k3SG61DqOjVt48p8aQ9GfHoOMCsJMuvporwwtxk195PMwDfpHBFzg9vGIrVJ2sp1Y8
	 kYNDbfewAb1oofhURcdvbnjzbzj8MzPVBDJIzJeo=
Date: Tue, 20 Feb 2024 05:01:04 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Zhi Mao =?utf-8?B?KOavm+aZuik=?= <zhi.mao@mediatek.com>
Cc: "heiko@sntech.de" <heiko@sntech.de>,
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"yunkec@chromium.org" <yunkec@chromium.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
	"gerald.loacker@wolfvision.net" <gerald.loacker@wolfvision.net>,
	Shengnan Wang =?utf-8?B?KOeOi+Wco+eUtyk=?= <shengnan.wang@mediatek.com>,
	"hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	Yaya Chang =?utf-8?B?KOW8tembhea4hSk=?= <Yaya.Chang@mediatek.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"jacopo.mondi@ideasonboard.com" <jacopo.mondi@ideasonboard.com>,
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"bingbu.cao@intel.com" <bingbu.cao@intel.com>,
	"sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"10572168@qq.com" <10572168@qq.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>,
	"macromorgan@hotmail.com" <macromorgan@hotmail.com>
Subject: Re: [PATCH v4 2/2] media: i2c: Add GC08A3 image sensor driver
Message-ID: <20240220030104.GF20376@pendragon.ideasonboard.com>
References: <20240204061538.2105-1-zhi.mao@mediatek.com>
 <20240204061538.2105-3-zhi.mao@mediatek.com>
 <20240206184542.GE2827@pendragon.ideasonboard.com>
 <598f62bbb55157eec1e23dd1dbc307fea3851b21.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <598f62bbb55157eec1e23dd1dbc307fea3851b21.camel@mediatek.com>

Hi Zhi,

On Tue, Feb 20, 2024 at 02:12:26AM +0000, Zhi Mao (毛智) wrote:
> On Tue, 2024-02-06 at 20:45 +0200, Laurent Pinchart wrote:
> > On Sun, Feb 04, 2024 at 02:15:38PM +0800, Zhi Mao wrote:
> > > Add a V4L2 sub-device driver for Galaxycore GC08A3 image sensor.
> > >
> > > Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> > > ---
> > >  drivers/media/i2c/Kconfig  |   10 +
> > >  drivers/media/i2c/Makefile |    1 +
> > >  drivers/media/i2c/gc08a3.c | 1448 ++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 1459 insertions(+)
> > >  create mode 100644 drivers/media/i2c/gc08a3.c

[snip]

> > > diff --git a/drivers/media/i2c/gc08a3.c b/drivers/media/i2c/gc08a3.c
> > > new file mode 100644
> > > index 000000000000..3fc7fffb815c
> > > --- /dev/null
> > > +++ b/drivers/media/i2c/gc08a3.c
> > > @@ -0,0 +1,1448 @@

[snip]

> > > +static int gc08a3_power_on(struct device *dev)
> > > +{
> > > +	struct i2c_client *client = to_i2c_client(dev);
> > > +	struct v4l2_subdev *sd = i2c_get_clientdata(client);
> > > +	struct gc08a3 *gc08a3 = to_gc08a3(sd);
> > > +	int ret;
> > > +
> > > +	ret = regulator_bulk_enable(ARRAY_SIZE(gc08a3_supply_name),
> > > +				    gc08a3->supplies);
> > > +	if (ret < 0) {
> > > +		dev_err(gc08a3->dev, "failed to enable regulators: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = clk_prepare_enable(gc08a3->xclk);
> > > +	if (ret < 0) {
> > > +		regulator_bulk_disable(ARRAY_SIZE(gc08a3_supply_name),
> > > +				       gc08a3->supplies);
> > > +		dev_err(gc08a3->dev, "clk prepare enable failed\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	usleep_range(GC08A3_MIN_SLEEP_US, GC08A3_MAX_SLEEP_US);
> > > +
> > > +	gpiod_set_value_cansleep(gc08a3->reset_gpio, 1);
> >
> > Are you asserting reset when powering on ? That sounds wrong, you should
> > de-assert reset here (and acquire the reset gpio in probe() with
> > GPIOD_OUT_HIGH). Drivers should use logical levels for GPIOs, setting a
> > GPIO named "reset" to 1 should assert the reset signal, even if the
> > physical signal is active low. You may have the wrong polarity in the
> > device tree.
>
> According to the sensor power sequence sepc, "reset" pin should be pull
> from low to high after "dovdd/dvdd/avdd" power on, so I follow this
> power sequece to pull "reset" pin high in software flow.

From a hardware point of view that's right, but the Linux kernel handles
logical level of GPIOs. If a GPIO is named "reset", it is expected that
calling

	gpiod_set_value_cansleep(gc08a3->reset_gpio, 1);

will "assert" the reset signal, setting it to a logical "reset = true"
level. This maps to the hardware 0V output level, as the signal is
active-low. To achieve this, define the reset GPIO as active low in DT,
and the GPIO framework will invert the signal for you. You should then
call

	gpiod_set_value_cansleep(gc08a3->reset_gpio, 1);

in the driver when you want to assert reset (set it to 0V), and

	gpiod_set_value_cansleep(gc08a3->reset_gpio, 0);

when you want to deassert it (set it to 3.3V, or whatever the I/O
voltage for the signal is).

This way all driver use logical states, and the inversion is handled in
DT.

> > > +	usleep_range(GC08A3_MIN_SLEEP_US, GC08A3_MAX_SLEEP_US);
> > > +
> > > +	return 0;
> > > +}

[snip]

-- 
Regards,

Laurent Pinchart

