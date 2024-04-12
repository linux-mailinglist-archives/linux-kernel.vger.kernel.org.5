Return-Path: <linux-kernel+bounces-142129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D7E8A27E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A321F228E7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934304AEEF;
	Fri, 12 Apr 2024 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WE588yZA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FC14D9F6;
	Fri, 12 Apr 2024 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906633; cv=none; b=q63DPNgM2L5N6idTIMf4vhMcmDrYnZ9bT4dgOZXYGkv4sVUzOGEa0JlXWVuDOQbu8aFxv0O5BrxsSJkSSgfZIKSReyhTIZWi4uoEjh/HpicCmzaMuXYpHH1GP4KwoNWjMW1JMgs29RMeOh3WjsTB0eWpMSIvd24t/fUv5KmFdNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906633; c=relaxed/simple;
	bh=nL/wsZ3JIHXue+/AiiizwW8D0f/5mk3xFk/IoEMY9+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkq+Acu31ZXYf9+raCExtk1MbBLva179fSEtOUE8nhKIuQw89dkAosJC5il9jX1e6JZFc36jTLWkyCwx0jyajkd4HUYTzh0gJK4BauKHAKQN/ATILTSIoU0KjTeGMSCBNWwVx88eEmsrZdaw/+ibH/6qCXFx2/Ne9ysa8oEMLRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WE588yZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8578BC113CC;
	Fri, 12 Apr 2024 07:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712906633;
	bh=nL/wsZ3JIHXue+/AiiizwW8D0f/5mk3xFk/IoEMY9+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WE588yZAYvl0NLgF+Ffj0Fxdxqq0SwD0C3OOLzCi58F2wINmZoAZLKmEyftOOBc88
	 aoZsYWQrtWk+DU2qe6R0aXmnV+ZDuG1kGx7+ZGyuLHaQT/JV6oYQv9oLhrfDGZcKgF
	 VTQQdKseE5CD31eKCJLK91vdafqkVo6vJD5B8R0ib5L/nRBpp1tdKAP2vpRx+9RSRC
	 mLVZh2dp/1aZzGeYrtIkaYWNm16ERPv8N0horKpZuxZT0d2tMqqAXCS7PN/JSyNxAw
	 EiVrChPux7ZqSH84ligvvRIwbnertROf+0RgEkQwzY18QX0FdIhSmi5DYECclmvCgz
	 cBB+AReIj/FGg==
Date: Fri, 12 Apr 2024 08:23:47 +0100
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
Message-ID: <20240412072347.GM2399047@google.com>
References: <cover.1712058690.git.mazziesaccount@gmail.com>
 <b86b7a73968810339b6cea7701bc3b6f626b4086.1712058690.git.mazziesaccount@gmail.com>
 <20240411143856.GD2399047@google.com>
 <25c959bc-fb02-42d9-b973-4a74cebd7208@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25c959bc-fb02-42d9-b973-4a74cebd7208@gmail.com>

On Fri, 12 Apr 2024, Matti Vaittinen wrote:

> Hi deee Ho Lee!
> 
> Thanks a ton for taking a look at this :) I already sent the V2 yesterday,
> briefly before receiving your comments. I think all of the comments are
> relevant for the V2 as well, I will fix them for the V3 when I get to that.
> If you find the time to take a look at V2, then the major things are
> addition of a watchdog IRQ + a work-around for the debugFS name collision
> for IRQ domains.
> 
> On 4/11/24 17:38, Lee Jones wrote:
> > On Tue, 02 Apr 2024, Matti Vaittinen wrote:
> > 
> > > The ROHM BD96801 PMIC is highly customizable automotive grade PMIC
> > > which integrates regulator and watchdog funtionalities.
> > > 
> > > Provide IRQ and register accesses for regulator/watchdog drivers.
> > > 
> > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > > ---
> > >   drivers/mfd/Kconfig              |  13 +
> > >   drivers/mfd/Makefile             |   1 +
> > >   drivers/mfd/rohm-bd96801.c       | 454 +++++++++++++++++++++++++++++++
> > >   include/linux/mfd/rohm-bd96801.h | 212 +++++++++++++++
> > >   include/linux/mfd/rohm-generic.h |   1 +
> > >   5 files changed, 681 insertions(+)
> > >   create mode 100644 drivers/mfd/rohm-bd96801.c
> > >   create mode 100644 include/linux/mfd/rohm-bd96801.h
> > > 
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index 4b023ee229cf..947045eb3a8e 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -2089,6 +2089,19 @@ config MFD_ROHM_BD957XMUF
> > >   	  BD9573MUF Power Management ICs. BD9576 and BD9573 are primarily
> > >   	  designed to be used to power R-Car series processors.
> > > +config MFD_ROHM_BD96801
> > > +	tristate "ROHM BD96801 Power Management IC"
> > > +	depends on I2C=y
> > > +	depends on OF
> > > +	select REGMAP_I2C
> > > +	select REGMAP_IRQ
> > > +	select MFD_CORE
> > > +	help
> > > +	  Select this option to get support for the ROHM BD96801 Power
> > > +	  Management IC. The ROHM BD96801 is a highly scalable power management
> > 
> > Power Management
> 
> Out of the curiosity, why is the "Power Management IC" written with
> capitals, when speaking of a class of devices instead of a model? (I am 100%
> fine with the change, just curious).

It's no different to how its expressed in the tristate section above.

Power Management IC or PMIC.

  "provides power management capabilities" describes its function?

  "is a scalable Power Management IC", describes the device?

But actually, it just looks odd when both are used in the same section.

/me likes uniformity and consistency.

> > > +	  IC for industrial and automotive use. The BD96801 can be used as a
> > > +	  master PMIC in a chained PMIC solutions with suitable companion PMICs
> ...
> 
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +//
> > > +// Copyright (C) 2022 ROHM Semiconductors
> > 
> > No updates for 2 years?
> 
> The year should be updated - thanks. But, now that you asked...  Almost no
> updates. The patches have rotten in my outbox, waiting for the permisson to
> be sent out... But yeah, I've sure added some changes before sending the
> series - I'll update the copyright :)
> 
> > > +
> > > +static int bd96801_i2c_probe(struct i2c_client *i2c)
> > > +{
> > > +	int i, ret, intb_irq, errb_irq, num_regu_irqs, num_intb, num_errb = 0;
> > > +	struct regmap_irq_chip_data *intb_irq_data, *errb_irq_data;
> > > +	struct irq_domain *intb_domain, *errb_domain;
> > > +	const struct fwnode_handle *fwnode;
> > > +	struct resource *regulator_res;
> > > +	struct regmap *regmap;
> > > +
> > > +	fwnode = dev_fwnode(&i2c->dev);
> > > +	if (!fwnode) {
> > > +		dev_err(&i2c->dev, "no fwnode\n");
> > > +		return -EINVAL;
> > 
> > Why not dev_err_probe() here for uniformity?
> 
> I can change it to dev_err_probe() if it's strongly preferred. It just feels
> silly to use dev_err_probe() when the return value is hardcoded.

Not at all:

git grep dev_err_probe | grep "\-[A-Z]"

> Intentionally writing code like
> 
> err = -EINVAL;
> if (err == ...)
> 
> just makes me feel a bit sick.

Why would you want to do that?

> > > +	}
> > > +
> > > +	intb_irq = fwnode_irq_get_byname(fwnode, "intb");
> > > +	if (intb_irq < 0)
> > > +		return dev_err_probe(&i2c->dev, intb_irq,
> > > +				     "No INTB IRQ configured\n");
> > 
> > This function would look nicer if you expanded to 100-chars.
> 
> The reason why I still prefer the good old 80-chars for files I work with,
> is that I am often having 3 terminal windows parallel on my laptop screen.
> (Or, when I have my wide mofnitor connected it is 3 editor windows +
> minicom). I need to keep the terminals small enough. Besides... I hate to
> admit this, but the time is finally taking it's toll. My eyes aren't quite
> the same they were 2 years ago...

Upgrade your 14" CRT monitor to something more modern. :)

I have a 32" 4k monitor with a good sized font and each of my 3
terminals (per i3 workspace) are ~150 chars wide.

> So, same old story, I can change this if it is important enough for others,
> but personally I rather work with the short lines.

It's not a showstopper.

-- 
Lee Jones [李琼斯]

