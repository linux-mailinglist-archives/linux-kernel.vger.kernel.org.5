Return-Path: <linux-kernel+bounces-130247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C37D8975E6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1649428BA35
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57063152DFE;
	Wed,  3 Apr 2024 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="MO0npq4t"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D326E152505;
	Wed,  3 Apr 2024 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163821; cv=none; b=eLcThpO9FWblRYa/HqfFwe33T/IwtCb7etjlKjxD9xUBlcjbC4NRR5mixLaOh9NGl4czDdOQ2EcKPHpAPHR46lQy4yWXWU8MkcB6soo6yyNnUXCOyFfShy6mAqGxP/RHO3ED5hishINqg14lWLPlKH8J5NiYlGi6lXt+0B0bT8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163821; c=relaxed/simple;
	bh=5oQ9PAIUbskmpNMMQyZgPbJVk82PwBM3Z1uyb7nioaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaKGG3zG8DNohxOksv5TmXW4vR7kAgUqWYTM6PmESelSX8j7p3Dr/FCT42R/lcBtBXWWLd+WrzYueXSvFcJTvDykLjZ3GsIEoWhr1D092S74mH7TelITQRbTNMy5oYcpYqvFjt1TCZ77D+7bUglDj+JH0nmhLjwli30s4bmE9ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=megous.com; spf=pass smtp.mailfrom=megous.com; dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b=MO0npq4t; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=megous.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=megous.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
	t=1712163817; bh=5oQ9PAIUbskmpNMMQyZgPbJVk82PwBM3Z1uyb7nioaQ=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=MO0npq4tWyuGwTaav38LDUD379CLRTbjTWXhqWWD37o4lA9WmySm+7G11xnzxBRPb
	 Z45Lio0muMx4UnX1rh3TZ/e8jt0gHKbwnkkVk17k7CySVgjnOhhlvkOYBzN79HZ4PM
	 vP3xXserb4s+Fr3wQRSguRa794bvKuUKqqolPs2k=
Date: Wed, 3 Apr 2024 19:03:37 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: git@luigi311.com, linux-media@vger.kernel.org, 
	dave.stevenson@raspberrypi.com, jacopo.mondi@ideasonboard.com, mchehab@kernel.org, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, pavel@ucw.cz, 
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 24/25] drivers: media: i2c: imx258: Add support for
 reset gpio
Message-ID: <vesqdx7w2sobjnx7tmk6s6i5zplbhsphamoalysx625r4aqffq@hos5otov5ids>
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
 <20240403150355.189229-25-git@luigi311.com>
 <Zg2Dy2QBguXQoR3P@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg2Dy2QBguXQoR3P@kekkonen.localdomain>

Hi,

On Wed, Apr 03, 2024 at 04:28:59PM GMT, Sakari Ailus wrote:
> Hi Luis,
> 
> Could you unify the subject prefix for the driver patches, please? E.g.
> "media: imx258: " would be fine.
> 
> On Wed, Apr 03, 2024 at 09:03:53AM -0600, git@luigi311.com wrote:
> > From: Luis Garcia <git@luigi311.com>
> > 
> > It was documented in DT, but not implemented.
> > 
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > Signed-off-by: Luis Garcia <git@luigi311.com>
> > ---
> >  drivers/media/i2c/imx258.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> > index 163f04f6f954..4c117c4829f1 100644
> > --- a/drivers/media/i2c/imx258.c
> > +++ b/drivers/media/i2c/imx258.c
> > @@ -680,6 +680,7 @@ struct imx258 {
> >  	unsigned int csi2_flags;
> >  
> >  	struct gpio_desc *powerdown_gpio;
> > +	struct gpio_desc *reset_gpio;
> >  
> >  	/*
> >  	 * Mutex for serialized access:
> > @@ -1232,7 +1233,11 @@ static int imx258_power_on(struct device *dev)
> >  		regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
> >  	}
> >  
> > -	return ret;
> > +	gpiod_set_value_cansleep(imx258->reset_gpio, 0);
> > +
> > +	usleep_range(400, 500);
> 
> You could mention this at least in the commit message.

This is T6 in the datasheet: https://megous.com/dl/tmp/92c9223ce877216e.png


> > +
> > +	return 0;
> >  }
> >  
> >  static int imx258_power_off(struct device *dev)
> > @@ -1243,6 +1248,7 @@ static int imx258_power_off(struct device *dev)
> >  	clk_disable_unprepare(imx258->clk);
> >  	regulator_bulk_disable(IMX258_NUM_SUPPLIES, imx258->supplies);
> >  
> > +	gpiod_set_value_cansleep(imx258->reset_gpio, 1);
> 
> Same question than on the other GPIO: does this belong here?

No, this should be before the regulator_bulk_disable.

See: https://megous.com/dl/tmp/c96180b23d7ce63a.png

kind regards,
	o.

> >  	gpiod_set_value_cansleep(imx258->powerdown_gpio, 1);
> >  
> >  	return 0;
> > @@ -1554,6 +1560,12 @@ static int imx258_probe(struct i2c_client *client)
> >  	if (IS_ERR(imx258->powerdown_gpio))
> >  		return PTR_ERR(imx258->powerdown_gpio);
> >  
> > +	/* request optional reset pin */
> > +	imx258->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
> > +						    GPIOD_OUT_HIGH);
> > +	if (IS_ERR(imx258->reset_gpio))
> > +		return PTR_ERR(imx258->reset_gpio);
> > +
> >  	/* Initialize subdev */
> >  	v4l2_i2c_subdev_init(&imx258->sd, client, &imx258_subdev_ops);
> >  
> 
> -- 
> Regards,
> 
> Sakari Ailus

