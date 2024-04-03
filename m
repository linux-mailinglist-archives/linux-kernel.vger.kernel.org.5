Return-Path: <linux-kernel+bounces-130232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C0A8975C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A4D28BD12
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AA1152533;
	Wed,  3 Apr 2024 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="aGWPpAO4"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2963A3E487;
	Wed,  3 Apr 2024 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163488; cv=none; b=NMuEklHoPtU3UfpTFG2SB12MDAgp7OB+0ryhl04agW4HXtP4GvGhpU4LNTFdiM5eX5mBibdy4IHYbVPJtsWFakNobc9+w9mJKL2K9zUQ7EqqXxkcCioCorBmX4Aiv05M3MC7DD4/QN6C5ZRVMiY4nOo1z0r8IH2AOBeC8OLPUOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163488; c=relaxed/simple;
	bh=2G4Q5SYQyElPkNHgWqe4JSo8rDfwCuoyLkkH6dTtzAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLgyGHN6Gaf9DkeZyjtSh+2WcYjtOhDh1XYILOpLNXD8gc/Yo/aulT0jErETDCISlqGMWjQasdriVl++3QC2Gmn0MLp8PpNIdHpPRQzvR5E61YciOqLsEWy/xDzMzT2QYGE8J/91bmqlFRRb/rEkmR7DCA3l4GikYlJhbF4ZPUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=megous.com; spf=pass smtp.mailfrom=megous.com; dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b=aGWPpAO4; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=megous.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=megous.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
	t=1712163476; bh=2G4Q5SYQyElPkNHgWqe4JSo8rDfwCuoyLkkH6dTtzAs=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=aGWPpAO4EGmkLK+EJPwzMzLQMWWL3m3dZUipkrCENdnh0eDNEuyHm50zbmNnn8Ds/
	 vDBksoqrLbzk9nnIEPB8TTBK/lh+JLYmm7ZrErL+8C0FpMIvVgYUxDyUko/gFBEMHd
	 1RmiypFsgbwGYUk/LyDA2fRmDNKuduVhpSAFpgwk=
Date: Wed, 3 Apr 2024 18:57:56 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: git@luigi311.com, linux-media@vger.kernel.org, 
	dave.stevenson@raspberrypi.com, jacopo.mondi@ideasonboard.com, mchehab@kernel.org, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, pavel@ucw.cz, 
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 23/25] drivers: media: i2c: imx258: Add support for
 powerdown gpio
Message-ID: <wjlcde7yoooygj4hhdmiwrdloh6l4p6i2qbmjek5uwsifyzwgu@xjhutvmsdfou>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, git@luigi311.com, linux-media@vger.kernel.org, 
	dave.stevenson@raspberrypi.com, jacopo.mondi@ideasonboard.com, mchehab@kernel.org, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, pavel@ucw.cz, 
	phone-devel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-24-git@luigi311.com>
 <Zg2DBasC501hMQSS@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zg2DBasC501hMQSS@kekkonen.localdomain>

Hi Sakari and Luis,

On Wed, Apr 03, 2024 at 04:25:41PM GMT, Sakari Ailus wrote:
> Hi Luis, Ondrej,
> 
> On Wed, Apr 03, 2024 at 09:03:52AM -0600, git@luigi311.com wrote:
> > From: Luis Garcia <git@luigi311.com>
> > 
> > On some boards powerdown signal needs to be deasserted for this
> > sensor to be enabled.
> > 
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > Signed-off-by: Luis Garcia <git@luigi311.com>
> > ---
> >  drivers/media/i2c/imx258.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> > index 30352c33f63c..163f04f6f954 100644
> > --- a/drivers/media/i2c/imx258.c
> > +++ b/drivers/media/i2c/imx258.c
> > @@ -679,6 +679,8 @@ struct imx258 {
> >  	unsigned int lane_mode_idx;
> >  	unsigned int csi2_flags;
> >  
> > +	struct gpio_desc *powerdown_gpio;
> > +
> >  	/*
> >  	 * Mutex for serialized access:
> >  	 * Protect sensor module set pad format and start/stop streaming safely.
> > @@ -1213,6 +1215,8 @@ static int imx258_power_on(struct device *dev)
> >  	struct imx258 *imx258 = to_imx258(sd);
> >  	int ret;
> >  
> > +	gpiod_set_value_cansleep(imx258->powerdown_gpio, 0);
> 
> What does the spec say? Should this really happen before switching on the
> supplies below?

There's no powerdown input in the IMX258 manual. The manual only mentions
that XCLR (reset) should be held low during power on.

https://megous.com/dl/tmp/15b0992a720ab82d.png

https://megous.com/dl/tmp/f2cc991046d97641.png

   This sensor doesn’t have a built-in “Power ON Reset” function. The XCLR pin
   is set to “LOW” and the power supplies are brought up. Then the XCLR pin
   should be set to “High” after INCK supplied.

So this input is some feature on camera module itself outside of the
IMX258 chip, which I think is used to gate power to the module. Eg. on Pinephone
Pro, there are two modules with shared power rails, so enabling supply to
one module enables it to the other one, too. So this input becomes the only way
to really enable/disable power to the chip when both are used at once at some
point, because regulator_bulk_enable/disable becomes ineffective at that point.

Luis, maybe you saw some other datasheet that mentions this input? IMO,
it just gates the power rails via some mosfets on the module itself, since
there's not power down input to the chip itself.

kind regards,
	o.

> > +
> >  	ret = regulator_bulk_enable(IMX258_NUM_SUPPLIES,
> >  				    imx258->supplies);
> >  	if (ret) {
> > @@ -1224,6 +1228,7 @@ static int imx258_power_on(struct device *dev)
> >  	ret = clk_prepare_enable(imx258->clk);
> >  	if (ret) {
> >  		dev_err(dev, "failed to enable clock\n");
> > +		gpiod_set_value_cansleep(imx258->powerdown_gpio, 1);
> >  		regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
> >  	}
> >  
> > @@ -1238,6 +1243,8 @@ static int imx258_power_off(struct device *dev)
> >  	clk_disable_unprepare(imx258->clk);
> >  	regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
> >  
> > +	gpiod_set_value_cansleep(imx258->powerdown_gpio, 1);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -1541,6 +1548,12 @@ static int imx258_probe(struct i2c_client *client)
> >  	if (!imx258->variant_cfg)
> >  		imx258->variant_cfg = &imx258_cfg;
> >  
> > +	/* request optional power down pin */
> > +	imx258->powerdown_gpio = devm_gpiod_get_optional(&client->dev, "powerdown",
> > +						    GPIOD_OUT_HIGH);
> > +	if (IS_ERR(imx258->powerdown_gpio))
> > +		return PTR_ERR(imx258->powerdown_gpio);
> > +
> >  	/* Initialize subdev */
> >  	v4l2_i2c_subdev_init(&imx258->sd, client, &imx258_subdev_ops);
> >  
> 
> -- 
> Regards,
> 
> Sakari Ailus

