Return-Path: <linux-kernel+bounces-148475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9358A831C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E911C21285
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC92013D24C;
	Wed, 17 Apr 2024 12:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0QedpGj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5DD13D295;
	Wed, 17 Apr 2024 12:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356700; cv=none; b=SCfJCzFzuiM66Mrmu13bmw/y3pFXf9ES9p+wTmDPYiEm4ZrtsB0mpX04T3jyLKB/ehOoJub36/fT6zJbNdbDqIMdoD1lqaM2XA4q77/EqfY7VCtbJK06TM28820rharnSRAkqRt/qFNlhkQe3jB/aqUEPuLX7yY9siWDxGp4LC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356700; c=relaxed/simple;
	bh=Q8zT258WQRDiwJmPtFZzZIyJIR1jdZVS+ZzaCdOE9JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R02+U87ua6PRL8QJiha44WF+C3nC8tl+Y1sxmRyt4c4kwMIxLDZCTWjkMsZ9sxClvSSGCPYes+Q+na5UulaDwGN4J7qJs2DV99TN3Ok0gK7MPPfYrtaJzPnpiahJvg70PliDEajgHACsZOpNSdZp5GumQqm9nBEN7kyEw2leEyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0QedpGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C983C072AA;
	Wed, 17 Apr 2024 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713356700;
	bh=Q8zT258WQRDiwJmPtFZzZIyJIR1jdZVS+ZzaCdOE9JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h0QedpGjj8RNmOqZMuHdkWOw1mh0PWamjez5Zq/LUjHsHnN8lLUFYpt9r7HF6zDyU
	 U6kdycDZ+zKka5PgDsOIoPodGOy0JIpRNqDQ/nBqtBxcQn0Nd+6LfLMCx9mXpVlSKN
	 OenkBaLJNzBsHVK+JDiqWNAvKYBLua0mJE2fz8n1LcHErcEkV6hOsQWvw3SivP+nUz
	 pTt9FJs96J7FswU9Ru6XkyCmJeiBmUURrzlpxGhiPyGHmlPzFCDjHZx+MxMBOXA5eI
	 q0VzeO8Kg2hh+x4/linpnOCPbOsR9BFrxJ8bfiMjt5NilkOo/TdyHeIuEYoU4hJMzC
	 76GNDNcExvjpA==
Date: Wed, 17 Apr 2024 13:24:54 +0100
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] mfd: support ROHM BD96801 PMIC core
Message-ID: <20240417122454.GY2399047@google.com>
References: <cover.1712058690.git.mazziesaccount@gmail.com>
 <b86b7a73968810339b6cea7701bc3b6f626b4086.1712058690.git.mazziesaccount@gmail.com>
 <20240411143856.GD2399047@google.com>
 <25c959bc-fb02-42d9-b973-4a74cebd7208@gmail.com>
 <20240412072347.GM2399047@google.com>
 <700b63a1-ce91-4d91-9db7-43c195ba7a6f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <700b63a1-ce91-4d91-9db7-43c195ba7a6f@gmail.com>

On Fri, 12 Apr 2024, Matti Vaittinen wrote:

> On 4/12/24 10:23, Lee Jones wrote:
> > On Fri, 12 Apr 2024, Matti Vaittinen wrote:
> > 
> > > Hi deee Ho Lee!
> > > 
> > > Thanks a ton for taking a look at this :) I already sent the V2 yesterday,
> > > briefly before receiving your comments. I think all of the comments are
> > > relevant for the V2 as well, I will fix them for the V3 when I get to that.
> > > If you find the time to take a look at V2, then the major things are
> > > addition of a watchdog IRQ + a work-around for the debugFS name collision
> > > for IRQ domains.
> > > 
> > > On 4/11/24 17:38, Lee Jones wrote:
> > > > On Tue, 02 Apr 2024, Matti Vaittinen wrote:
> > > > 
> > > > > The ROHM BD96801 PMIC is highly customizable automotive grade PMIC
> > > > > which integrates regulator and watchdog funtionalities.
> > > > > 
> > > > > Provide IRQ and register accesses for regulator/watchdog drivers.
> > > > > 
> > > > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > > > > ---
> > > > >    drivers/mfd/Kconfig              |  13 +
> > > > >    drivers/mfd/Makefile             |   1 +
> > > > >    drivers/mfd/rohm-bd96801.c       | 454 +++++++++++++++++++++++++++++++
> > > > >    include/linux/mfd/rohm-bd96801.h | 212 +++++++++++++++
> > > > >    include/linux/mfd/rohm-generic.h |   1 +
> > > > >    5 files changed, 681 insertions(+)
> > > > >    create mode 100644 drivers/mfd/rohm-bd96801.c
> > > > >    create mode 100644 include/linux/mfd/rohm-bd96801.h
> > > > > 
> > > > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > > > index 4b023ee229cf..947045eb3a8e 100644
> > > > > --- a/drivers/mfd/Kconfig
> > > > > +++ b/drivers/mfd/Kconfig
> > > > > @@ -2089,6 +2089,19 @@ config MFD_ROHM_BD957XMUF
> > > > >    	  BD9573MUF Power Management ICs. BD9576 and BD9573 are primarily
> > > > >    	  designed to be used to power R-Car series processors.
> > > > > +config MFD_ROHM_BD96801
> > > > > +	tristate "ROHM BD96801 Power Management IC"
> > > > > +	depends on I2C=y
> > > > > +	depends on OF
> > > > > +	select REGMAP_I2C
> > > > > +	select REGMAP_IRQ
> > > > > +	select MFD_CORE
> > > > > +	help
> > > > > +	  Select this option to get support for the ROHM BD96801 Power
> > > > > +	  Management IC. The ROHM BD96801 is a highly scalable power management
> > > > 
> > > > Power Management
> > > 
> > > Out of the curiosity, why is the "Power Management IC" written with
> > > capitals, when speaking of a class of devices instead of a model? (I am 100%
> > > fine with the change, just curious).
> > 
> > It's no different to how its expressed in the tristate section above.
> > 
> > Power Management IC or PMIC.
> > 
> >    "provides power management capabilities" describes its function?
> > 
> >    "is a scalable Power Management IC", describes the device?
> > 
> > But actually, it just looks odd when both are used in the same section.
> > 
> > /me likes uniformity and consistency.
> 
> It's okay, thanks for the explanation :)
> 
> > > > > +	  IC for industrial and automotive use. The BD96801 can be used as a
> > > > > +	  master PMIC in a chained PMIC solutions with suitable companion PMICs
> > > ...
> > > 
> > > > > +static int bd96801_i2c_probe(struct i2c_client *i2c)
> > > > > +{
> > > > > +	int i, ret, intb_irq, errb_irq, num_regu_irqs, num_intb, num_errb = 0;
> > > > > +	struct regmap_irq_chip_data *intb_irq_data, *errb_irq_data;
> > > > > +	struct irq_domain *intb_domain, *errb_domain;
> > > > > +	const struct fwnode_handle *fwnode;
> > > > > +	struct resource *regulator_res;
> > > > > +	struct regmap *regmap;
> > > > > +
> > > > > +	fwnode = dev_fwnode(&i2c->dev);
> > > > > +	if (!fwnode) {
> > > > > +		dev_err(&i2c->dev, "no fwnode\n");
> > > > > +		return -EINVAL;
> > > > 
> > > > Why not dev_err_probe() here for uniformity?
> > > 
> > > I can change it to dev_err_probe() if it's strongly preferred. It just feels
> > > silly to use dev_err_probe() when the return value is hardcoded.
> > 
> > Not at all:
> > 
> > git grep dev_err_probe | grep "\-[A-Z]"
> 
> Yes, I know people do use the dev_err_probe() with hardcoded errors but it
> does not make me feel any better about it :)

<look into my swirling eyes> Uniformity within the function!

> > > Intentionally writing code like
> > > 
> > > err = -EINVAL;
> > > if (err == ...)
> > > 
> > > just makes me feel a bit sick.
> > 
> > Why would you want to do that?
> 
> This is what the dev_err_probe() with a hardcoded err does, right?
> 
> int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
> {
> 	...
> 	if (err != -EPROBE_DEFER) {
> 		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
> 	} else {
> 		device_set_deferred_probe_reason(dev, &vaf);
> 		dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
> 	}
> 	...
> }

Attempt to purge this info from you brain!

> > > > > +	}
> > > > > +
> > > > > +	intb_irq = fwnode_irq_get_byname(fwnode, "intb");
> > > > > +	if (intb_irq < 0)
> > > > > +		return dev_err_probe(&i2c->dev, intb_irq,
> > > > > +				     "No INTB IRQ configured\n");
> > > > 
> > > > This function would look nicer if you expanded to 100-chars.
> > > 
> > > The reason why I still prefer the good old 80-chars for files I work with,
> > > is that I am often having 3 terminal windows parallel on my laptop screen.
> > > (Or, when I have my wide mofnitor connected it is 3 editor windows +
> > > minicom). I need to keep the terminals small enough. Besides... I hate to
> > > admit this, but the time is finally taking it's toll. My eyes aren't quite
> > > the same they were 2 years ago...
> > 
> > Upgrade your 14" CRT monitor to something more modern. :)
> 
> But those things were built to last! And throwing away perfectly working
> stuff... :)

Can't argue with that!  Maybe put 2 side-by-side or 4 in a matrix!

-- 
Lee Jones [李琼斯]

