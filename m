Return-Path: <linux-kernel+bounces-68465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A25FA857A93
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431AA1F24ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9D7535BE;
	Fri, 16 Feb 2024 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XYQcs0ay"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E574EB46;
	Fri, 16 Feb 2024 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708080408; cv=none; b=qqzfmydUhTugs5u79gnxJzz4LFVz7aGkH5sqHhVJW7oHGLV+xZtPHZ4gzr61H330Hj+Nx6WkwH72TZLIkZ4ESWsgCjZMwia85XfT8NSdhOu4iv7pk94FNXnJMpl20n4OBz5qapUs2UZCMO3+fUopLWsRso3d7DKpc7ltUaWnbOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708080408; c=relaxed/simple;
	bh=zO/aYULRDd5g66VH3wDZFlrX3sUYi1N5HOHVoHCRZV4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=h8QYr2I2RQXXiBnfA0OqiMVKhnz37+QjX87vDxktpowNB1+j/k/SHMGXTw5iscL1dPDT3A9wGgSllMNJeb6jJxF2YsaNueBdoyzvSDBN/1413ulvOHSyxVB0xtZ0GQeDfQGIRTCjVt1iobSUQTpZ61BI3f7cwOaf37LtRKXYJ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XYQcs0ay; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DBFFB40010;
	Fri, 16 Feb 2024 10:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708080398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOFZYp9L0rsUmowBF6zr/rLZrw3lql63KQCsfDEtWYw=;
	b=XYQcs0ayxwkHosheDGS+xMf4VR7v/mXreOiEjH5x5j54nNfito6uMSJ3ZQsQ1GFcOHosrk
	sk56mZqniap2andZ4ef8ZJW6MczWT3QdoADxEcPswfadR0K2fhCmXm2jewctoz3F8q7ofP
	+5FM0XeU/uuT84AM+aS3UG5xif8zvLwyVtZ/Rfud6akypxVtvTNHU7zw1N/ENVeBozcljT
	YElJRis/88Ap6dTbQi8/jp+cw1YwaIMUSmbE5DVKzh/EZOV6o6//X6SE2tMK3iATbi5yej
	lKHE6RtCfgvCRny0FxT2A9QbxLRhalrdHpYliiK/TZC5dIpuYvJFgdgd4l0/bw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Feb 2024 11:46:36 +0100
Message-Id: <CZ6FYTJD4L6Q.171I9ZOL1S965@bootlin.com>
Subject: Re: [PATCH 19/23] gpio: nomadik: grab optional reset control and
 deassert it at probe
Cc: <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mips@vger.kernel.org>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Philipp Zabel" <p.zabel@pengutronix.de>, "Linus Walleij"
 <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>, "Rob
 Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
 <20240214-mbly-gpio-v1-19-f88c0ccf372b@bootlin.com>
 <d51dbac55d3677031bfab8bfe959f7b556b1c373.camel@pengutronix.de>
In-Reply-To: <d51dbac55d3677031bfab8bfe959f7b556b1c373.camel@pengutronix.de>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Feb 15, 2024 at 11:19 AM CET, Philipp Zabel wrote:
> On Mi, 2024-02-14 at 17:24 +0100, Th=C3=A9o Lebrun wrote:
> > Fetch a reference to the optional shared reset control and deassert it
> > if it exists.
> >=20
> > Optional because not all platforms that use this driver have a reset
> > attached to the reset block. Shared because some platforms that use the
> > reset (at least Mobileye EyeQ5) share the reset across banks.
> >=20
> > Do not keep a reference to the reset control as it is not needed
> > afterwards; the driver does not handle suspend, does not use runtime PM
> > and does not register a remove callback.
>
> I suppose you don't care that the reset is only ever deasserted once
> and never asserted again on this hardware, but for shared reset
> controls the expectation is that deassert/assert calls are balanced:
>
> https://docs.kernel.org/driver-api/reset.html?highlight=3Dbalanced#assert=
ion-and-deassertion
>
> So maybe this warrants a comment in the code. Or do you mean to
> suppress unbind via suppress_bind_attrs to explain away any missing
> cleanup?

Those resets are shared only across GPIO banks which have no reason to
be unbind-able. I'll add a comment and disable unbind.

> > The operation is done in nmk_gpio_populate_chip(). This function is
> > called by either gpio-nomadik or pinctrl-nomadik, whoever comes first.
> > This is here for historic reasons and could probably be removed now; it
> > seems gpio-ranges enforces the ordering to be pinctrl-first. It is not
> > the topic of the present patch however.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  drivers/gpio/gpio-nomadik.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >=20
> > diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
> > index 21bb6d6363fc..b623c093b54d 100644
> > --- a/drivers/gpio/gpio-nomadik.c
> > +++ b/drivers/gpio/gpio-nomadik.c
> > @@ -513,12 +513,14 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(stru=
ct device_node *np,
> >  {
> >  	struct nmk_gpio_chip *nmk_chip;
> >  	struct platform_device *gpio_pdev;
> > +	struct reset_control *reset;
> >  	struct gpio_chip *chip;
> >  	struct resource *res;
> >  	struct clk *clk;
> >  	void __iomem *base;
> >  	uintptr_t flags;
> >  	u32 id, ngpio;
> > +	int ret;
> > =20
> >  	gpio_pdev =3D of_find_device_by_node(np);
> >  	if (!gpio_pdev) {
> > @@ -576,6 +578,19 @@ struct nmk_gpio_chip *nmk_gpio_populate_chip(struc=
t device_node *np,
> >  	clk_prepare(clk);
> >  	nmk_chip->clk =3D clk;
> > =20
> > +	reset =3D devm_reset_control_get_optional_shared(&gpio_pdev->dev, NUL=
L);
> > +	if (IS_ERR(reset)) {
> > +		dev_err(&pdev->dev, "failed getting reset control: %ld\n",
> > +			PTR_ERR(reset));
> > +		return ERR_CAST(reset);
>
> Consider using dev_err_probe() here.

Makes sense, will do so for next revision.

Thanks for the review Philipp,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

