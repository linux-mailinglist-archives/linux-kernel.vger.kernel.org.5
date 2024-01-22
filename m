Return-Path: <linux-kernel+bounces-32815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A0783607A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2BA1C24693
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1333C465;
	Mon, 22 Jan 2024 11:04:19 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0D13B2A6;
	Mon, 22 Jan 2024 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921459; cv=none; b=u46Gd34UEYipHK6ot3dNYuGc+eCN8GVsJcFq4p+SjJh/CigkVt8q1+Oj0LjtTXBCqTRiJPXJOPqtIurx4XNhKtlEsY8BfgzU751p1b6a8Mi7JItozGtOHsbc7iQb8Vldie45G4zmwN7U8jyS+5f9h7Z1ezYOLmtRiN04ZfLdl/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921459; c=relaxed/simple;
	bh=pEBZ2kLnoJVWrDOJJZyBs5A3576ofH4WdTBNQzufxkw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTF/F18aMdJNWOqe9v/UUNf9YApo78XfQbHfEB+uDu2NI7dadebT7hSuyD9xGbCL4bgrBGGgPnN/rOSYa18RUKNvJ/Ga4qBpKJqJr0w7Jxo2GkGuLcalNIfTEq8NwmsBhQZroDdwljB8DxjzEH/zj7c3QLVX2URbWKpQ7uakarQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TJS2J3ylkz6K99P;
	Mon, 22 Jan 2024 19:01:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E30D140A90;
	Mon, 22 Jan 2024 19:04:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Jan
 2024 11:04:05 +0000
Date: Mon, 22 Jan 2024 11:04:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Marek Vasut <marex@denx.de>, "Anshul
 Dalal" <anshulusr@gmail.com>, Javier Carrasco
	<javier.carrasco.cruz@gmail.com>, Matt Ranostay <matt@ranostay.sg>, "Stefan
 Windfeldt-Prytz" <stefan.windfeldt-prytz@axis.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] iio: light: Add support for APDS9306 Light
 Sensor
Message-ID: <20240122110404.00001082@Huawei.com>
In-Reply-To: <757a18b7-94f4-4d72-9917-5d8b1cd677f6@tweaklogic.com>
References: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
	<20240121051735.32246-4-subhajit.ghosh@tweaklogic.com>
	<20240121152332.6b15666a@jic23-huawei>
	<757a18b7-94f4-4d72-9917-5d8b1cd677f6@tweaklogic.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 22 Jan 2024 21:26:03 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> On 22/1/24 01:53, Jonathan Cameron wrote:
> > On Sun, 21 Jan 2024 15:47:34 +1030
> > Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
> >   
> >> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.
> >> It has two channels - ALS and CLEAR. The ALS (Ambient Light Sensor)
> >> channel approximates the response of the human-eye providing direct
> >> read out where the output count is proportional to ambient light levels.
> >> It is internally temperature compensated and rejects 50Hz and 60Hz flicker
> >> caused by artificial light sources. Hardware interrupt configuration is
> >> optional. It is a low power device with 20 bit resolution and has
> >> configurable adaptive interrupt mode and interrupt persistence mode.
> >> The device also features inbuilt hardware gain, multiple integration time
> >> selection options and sampling frequency selection options.
> >>
> >> This driver also uses the IIO GTS (Gain Time Scale) Helpers Namespace for
> >> Scales, Gains and Integration time implementation.
> >>
> >> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> >> ---
> >> v2 -> v5:  
> > 
> > Why did you jump to v5?  Some internal or private reviews perhaps?
> > Better for those tracking on the list if you just used v3.  
> Wish I had someone to review my code before sending it to kernel community!
> I do this in my own time.
> 
> v5 was suggested by you. Now I understand that Suggested-by: tag has to be used :)
> https://lore.kernel.org/all/20231028143631.2545f93e@jic23-huawei/

oops :)  It's fine, I'd just forgotten that discussion entirely!


> >> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> >> new file mode 100644
> >> index 000000000000..8ed5899050ed
> >> --- /dev/null
> >> +++ b/drivers/iio/light/apds9306.c
> >> @@ -0,0 +1,1315 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> >> +/*
> >> + * APDS-9306/APDS-9306-065 Ambient Light Sensor
> >> + * I2C Address: 0x52
> >> + * Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
> >> + *
> >> + * Copyright (C) 2023 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>  
> > 
> > Given you are still changing it, feel free to include 2024!  
> I sincerely hope that I don't have to update it to 2025!

:)

..

> >   
> >> +	},
> >> +};  
> >   
> >> +  
> >   
> >> +
> >> +static int apds9306_runtime_power_on(struct device *dev)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = pm_runtime_resume_and_get(dev);
> >> +	if (ret < 0)
> >> +		dev_err(dev, "runtime resume failed: %d\n", ret);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int apds9306_runtime_power_off(struct device *dev)
> >> +{
> >> +	pm_runtime_mark_last_busy(dev);
> >> +	pm_runtime_put_autosuspend(dev);
> >> +
> >> +	return 0;
> >> +}  
> > 
> > I'm not entirely convinced these two wrappers are worthwhile given they
> > aren't that common used and locally obscure what is going on when
> > it could be apparent at the few call sites.  
> The above was suggested by Andy.
> https://lore.kernel.org/linux-devicetree/ZTuuUl0PBklbVjb9@smile.fi.intel.com/

Ah. Fair enough.  I'm not that bothered so if Andy prefers this then fine to
keep it. 

> 
> Apologies for my ignorance - "it could be apparent at the few call sites" -
> I did not understand the above statement. Can you please elaborate?

I meant what was going on (the fact it's using autosuspend for example)
could be visible where it is called in a way that is hidden by the
wrappers.  Not a big thing though.





> >> +
> >> +	ret = devm_add_action_or_reset(dev, apds9306_powerdown, data);
> >> +	if (ret)
> >> +		return dev_err_probe(dev, ret, "failed to add action or reset\n");
> >> +
> >> +	ret = devm_iio_device_register(dev, indio_dev);
> >> +	if (ret)
> >> +		return dev_err_probe(dev, ret, "failed iio device registration\n");
> >> +
> >> +	pm_runtime_put_autosuspend(dev);  
> > 
> > Where is the matching get?  I don't recall any of the pm functions
> > leaving us with the reference count raised except for the where it is
> > called out in the function name.
> >   
> I blindly copy pasted your below suggestion.
> https://lore.kernel.org/all/20231028162025.4259f1cc@jic23-huawei/
> 
> "this lot of runtime pm stuff isn't initializing the device, so I don't
> see it as making sense in here. I'd push it out to the caller with
> the power up before init and the autosuspend etc after.
> I'll note that I'd expect to see a a pm_runtime_put_autosuspend()
> at the end of probe to put device to sleep soon after loading."

Ah. Seems I'm being very inconsistent today.  However I would expect
you to need the device to remain powered up until end of probe
(assuming it needs to be powered up to read/write registers?) so indeed
a get to raise the reference count would be the way to ensure that.

> 
> > The runtime pm reference counters are protected against underflowing so this
> > probably just has no impact.  Still good to only have it if necessary and if
> > you do need the power to be on until this point, force it to do so by
> > an appropriate pm_runtime_get().  
> I will use a pm_runtime_get() in the apds9306_pm_init() function above.

Great. That makes sense.

> > 
> >   
> >> +
> >> +	return 0;
> >> +}  
> >   
> Thank you for your review.

Sorry for the inconsistencies!  

Jonathan
> 
> Regards,
> Subhajit Ghosh
> 


