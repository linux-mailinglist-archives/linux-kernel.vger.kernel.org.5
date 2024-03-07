Return-Path: <linux-kernel+bounces-95754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3842875210
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E98A288B83
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAD01EA7C;
	Thu,  7 Mar 2024 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KUvVw+Y0"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791801B96E;
	Thu,  7 Mar 2024 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822368; cv=none; b=Mp263hkAvLv78rWwUdPze7jM+Njf2sCRsp7JMQOTaoQOE/Ur7N0HHgax+MUZgbw25o1vccN8a1G6e8PaYDGv7CTAUwPMs/oTIY632VSJXzjOMZboWsGXLx7IE54tq+lzjhLpHgOBHOHtLyxaFcvAbCz10rRkwjf53BMA00yuIh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822368; c=relaxed/simple;
	bh=1wda9rVFemYUpjfFp/MVZ9nQg/5x5u0oC4XBV/jPWOA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=i3Kgy7IldpVvEL+PdXmRahd7U8im/McxGJ2wTzfu207IDseQQ+PAw//PrkauBGHI8fq8/3zFeMYM/WMzTjIcIGao2caHO0dVADbwrh7W7UcY0Y2T5NVwfiuqJoddbabkXIf/ZMFUQICybV1zb0OP5qHffKDCYilfG3xkMXqs5BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KUvVw+Y0; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D65D3E000D;
	Thu,  7 Mar 2024 14:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709822357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DyyvLt3PFqGEcHS9MBOofH4aGB4ndkaOSLBfw95+8NY=;
	b=KUvVw+Y01jMAdb7/WuVobY4KF3yUKmM23k9AgcVjHc/v5OwMpPfYQ4ZgVXW3tRHpjZGuPi
	938qrKHa+lMcaX+rAnjITZIzrZWJLGP0FI/6LyDu6CZdYfR3Ig9b3SzffXnNEDNyVmVKGi
	UUuO75aY3JPLLly0cdYMCCxDVzR+LQ8W+CPLo2J96wObP+emCBrFhPMEB/CUpC/zRf7sQ4
	TSipvoVusU1LiQXGZw+6Et2ykxxFnvj689jZgGU/bsjVSy/iVgJn0Kz2AnXQf3dICGHhEe
	GtZrD40tK6eSXTpacy4F6dnwfRzpyhDXLI1i7c7AzPI7y0k48UOIbCKJQZA/BA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Mar 2024 15:39:15 +0100
Message-Id: <CZNLFUH8WWIA.MAUN8E53X7PK@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v4 3/9] usb: cdns3-ti: move reg writes from probe into
 ->runtime_resume()
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Kevin
 Hilman" <khilman@kernel.org>, "Alan Stern" <stern@rowland.harvard.edu>,
 <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
To: "Roger Quadros" <rogerq@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Peter Chen" <peter.chen@kernel.org>, "Pawel
 Laszczak" <pawell@cadence.com>, "Nishanth Menon" <nm@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, "Tero Kristo" <kristo@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240307-j7200-usb-suspend-v4-0-5ec7615431f3@bootlin.com>
 <20240307-j7200-usb-suspend-v4-3-5ec7615431f3@bootlin.com>
 <d1ca5d29-8ef4-4d7f-b1c8-bcb361e6c351@kernel.org>
In-Reply-To: <d1ca5d29-8ef4-4d7f-b1c8-bcb361e6c351@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Roger,

On Thu Mar 7, 2024 at 1:31 PM CET, Roger Quadros wrote:
> Hi,
>
> On 07/03/2024 11:55, Th=C3=A9o Lebrun wrote:
> > The hardware initialisation register write sequence is only used at
> > probe. Move it from being done at explicitely at probe to being done
> > implicitely by pm_runtime_get_sync() that calls ->runtime_resume().
>
> explicitly / implicitly
>
> >=20
> > Keep devicetree parsing in probe and add a new field in the private
> > struct to remember the USB2 refclk rate code computation result.
> >=20
> > This opens the door to having the init sequence being executed later
> > down the road, at system-wide resume for example. This is NOT currently
> > happening because runtime PM is disabled at suspend without the
> > refcount being affected.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  drivers/usb/cdns3/cdns3-ti.c | 90 +++++++++++++++++++++++++-----------=
--------
> >  1 file changed, 52 insertions(+), 38 deletions(-)
> >=20
> > diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.=
c
> > index 5945c4b1e11f..4c8a557e6a6f 100644
> > --- a/drivers/usb/cdns3/cdns3-ti.c
> > +++ b/drivers/usb/cdns3/cdns3-ti.c
> > @@ -57,6 +57,7 @@ struct cdns_ti {
> >  	unsigned vbus_divider:1;
> >  	struct clk *usb2_refclk;
> >  	struct clk *lpm_clk;
> > +	int usb2_refclk_rate_code;
> >  };
> > =20
> >  static const int cdns_ti_rate_table[] =3D {	/* in KHZ */
> > @@ -90,10 +91,8 @@ static int cdns_ti_probe(struct platform_device *pde=
v)
> >  	struct device *dev =3D &pdev->dev;
> >  	struct device_node *node =3D pdev->dev.of_node;
> >  	struct cdns_ti *data;
> > -	int error;
> > -	u32 reg;
> > -	int rate_code, i;
> >  	unsigned long rate;
> > +	int error, i;
> > =20
> >  	data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> >  	if (!data)
> > @@ -133,7 +132,9 @@ static int cdns_ti_probe(struct platform_device *pd=
ev)
> >  		return -EINVAL;
> >  	}
> > =20
> > -	rate_code =3D i;
> > +	data->usb2_refclk_rate_code =3D i;
> > +	data->vbus_divider =3D device_property_read_bool(dev, "ti,vbus-divide=
r");
> > +	data->usb2_only =3D device_property_read_bool(dev, "ti,usb2-only");
> > =20
> >  	pm_runtime_enable(dev);
> >  	error =3D pm_runtime_get_sync(dev);
> > @@ -142,40 +143,6 @@ static int cdns_ti_probe(struct platform_device *p=
dev)
> >  		goto err;
> >  	}
> > =20
> > -	/* assert RESET */
> > -	reg =3D cdns_ti_readl(data, USBSS_W1);
> > -	reg &=3D ~USBSS_W1_PWRUP_RST;
> > -	cdns_ti_writel(data, USBSS_W1, reg);
> > -
> > -	/* set static config */
> > -	reg =3D cdns_ti_readl(data, USBSS_STATIC_CONFIG);
> > -	reg &=3D ~USBSS1_STATIC_PLL_REF_SEL_MASK;
> > -	reg |=3D rate_code << USBSS1_STATIC_PLL_REF_SEL_SHIFT;
> > -
> > -	reg &=3D ~USBSS1_STATIC_VBUS_SEL_MASK;
> > -	data->vbus_divider =3D device_property_read_bool(dev, "ti,vbus-divide=
r");
> > -	if (data->vbus_divider)
> > -		reg |=3D 1 << USBSS1_STATIC_VBUS_SEL_SHIFT;
> > -
> > -	cdns_ti_writel(data, USBSS_STATIC_CONFIG, reg);
> > -	reg =3D cdns_ti_readl(data, USBSS_STATIC_CONFIG);
> > -
> > -	/* set USB2_ONLY mode if requested */
> > -	reg =3D cdns_ti_readl(data, USBSS_W1);
> > -	data->usb2_only =3D device_property_read_bool(dev, "ti,usb2-only");
> > -	if (data->usb2_only)
> > -		reg |=3D USBSS_W1_USB2_ONLY;
> > -
> > -	/* set default modestrap */
> > -	reg |=3D USBSS_W1_MODESTRAP_SEL;
> > -	reg &=3D ~USBSS_W1_MODESTRAP_MASK;
> > -	reg |=3D USBSS_MODESTRAP_MODE_NONE << USBSS_W1_MODESTRAP_SHIFT;
> > -	cdns_ti_writel(data, USBSS_W1, reg);
> > -
> > -	/* de-assert RESET */
> > -	reg |=3D USBSS_W1_PWRUP_RST;
> > -	cdns_ti_writel(data, USBSS_W1, reg);
> > -
> >  	error =3D of_platform_populate(node, NULL, NULL, dev);
> >  	if (error) {
> >  		dev_err(dev, "failed to create children: %d\n", error);
> > @@ -211,6 +178,52 @@ static void cdns_ti_remove(struct platform_device =
*pdev)
> >  	platform_set_drvdata(pdev, NULL);
> >  }
> > =20
> > +static int cdns_ti_runtime_resume(struct device *dev)
> > +{
> > +	struct cdns_ti *data =3D dev_get_drvdata(dev);
> > +	u32 reg;
> > +
> > +	/* assert RESET */
> > +	reg =3D cdns_ti_readl(data, USBSS_W1);
> > +	reg &=3D ~USBSS_W1_PWRUP_RST;
> > +	cdns_ti_writel(data, USBSS_W1, reg);
> > +
> > +	/* set static config */
> > +	reg =3D cdns_ti_readl(data, USBSS_STATIC_CONFIG);
> > +	reg &=3D ~USBSS1_STATIC_PLL_REF_SEL_MASK;
> > +	reg |=3D data->usb2_refclk_rate_code << USBSS1_STATIC_PLL_REF_SEL_SHI=
FT;
> > +
> > +	reg &=3D ~USBSS1_STATIC_VBUS_SEL_MASK;
> > +
> > +	if (data->vbus_divider)
> > +		reg |=3D 1 << USBSS1_STATIC_VBUS_SEL_SHIFT;
> > +
> > +	cdns_ti_writel(data, USBSS_STATIC_CONFIG, reg);
> > +	reg =3D cdns_ti_readl(data, USBSS_STATIC_CONFIG);
> > +
> > +	/* set USB2_ONLY mode if requested */
> > +	reg =3D cdns_ti_readl(data, USBSS_W1);
> > +
> > +	if (data->usb2_only)
> > +		reg |=3D USBSS_W1_USB2_ONLY;
> > +
> > +	/* set default modestrap */
> > +	reg |=3D USBSS_W1_MODESTRAP_SEL;
> > +	reg &=3D ~USBSS_W1_MODESTRAP_MASK;
> > +	reg |=3D USBSS_MODESTRAP_MODE_NONE << USBSS_W1_MODESTRAP_SHIFT;
> > +	cdns_ti_writel(data, USBSS_W1, reg);
> > +
> > +	/* de-assert RESET */
> > +	reg |=3D USBSS_W1_PWRUP_RST;
> > +	cdns_ti_writel(data, USBSS_W1, reg);
>
> I don't think USB controller requires a reset and re-init between
> runtime suspend/resume.
>
> What you need is reset/re-init during system Resume on certain platforms.
> So you should move this part of code into a helper function and call it
> from .probe() and .system_resume()

Runtime resume is being called at probe() and system-wide resume. See
our runtime_resume() implementation as that helper function you are
describing.

A previous revision did what you are recommending. We leaned towards the
current version. See:
https://lore.kernel.org/lkml/7h34wxfmwn.fsf@baylibre.com/

Also, assuming we enable runtime PM, a reset and re-init after runtime
suspend would be the right thing to do anyways. My reading of
drivers/pmdomain/core.c tells me that if our device goes to runtime
suspend, domains will be shut down. Our controller will be reset and
we'll need to re-init it. The GENPD_FLAG_RPM_ALWAYS_ON flag is of
interest to avoid the PD to be shut down during runtime PM.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


