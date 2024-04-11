Return-Path: <linux-kernel+bounces-140603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A262E8A16C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E0C1F24EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EBB14F9D0;
	Thu, 11 Apr 2024 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N83Iw/MM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA27C14E2C8;
	Thu, 11 Apr 2024 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844475; cv=none; b=XN4CAzEhyLPUIEpoTqQwqGnUFsadQs40X/7o+++a/B7tudPUOTBr1fqsNM3JPYZtHbEk1U4E4r+rwMrGIVVwq4cvHk2d//4EJD5cZo3UD6V0BXr6z02XLJ5deT0TZa8CunSpmiA3YLyO2soR4Knq2+EpvA3tKFjKN4ptQC+J20s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844475; c=relaxed/simple;
	bh=YAFyVO/WjOWVd1TNTsZEU2EvIZaOOVy3hx27fi6XANg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf7k8IfcG/0nwzn+a+FgHWeiC2I79n5fijyaY91+pa/tVDJiGsQn8E+w4Yyfxw0H+wGTX1OSiCWoYxvOT+POWmLVKqI7adCfaM1cJBEltvqdOuFcnFE20+hbjqS6+HjYfWRltE7YtRnqpvI4az+0ZU2SuTk50SU8G9hmRV5ZJbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N83Iw/MM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A48C4AF0A;
	Thu, 11 Apr 2024 14:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712844475;
	bh=YAFyVO/WjOWVd1TNTsZEU2EvIZaOOVy3hx27fi6XANg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N83Iw/MMxMCtlnRKgTDd8aotbhakHthoMU8Ts9Opd5MQvbO9/Ac4vSTOGCMDlR0yK
	 /EOi9vE7Q7rvwOrbbCtKNdqD3nmsYBqDEEQ5T7kz91iKOgd8CPPteYdYsCCy8Lmfib
	 v5pBEd/M4Mfu/4IHGpDoeYNT4GwQ0SPJRRfR4tFiTkC3BnQ2Aar4WJ/ANgtqh8bg48
	 rFdqisLYfLyO7zaxGnEVVoZfLl4Jiq2venrmrLPMR/QxgEg7hVh6A/b9rEJo1PVWwy
	 +BbKa23nJeatX1OYoAfT+jG2y7n7k4BApuVylC74iUAXX74elx9tLMmW4aaJNzDAYD
	 r3OSxGN6+9vmA==
Date: Thu, 11 Apr 2024 15:07:50 +0100
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mfd: rohm-bd71828: Add power off functionality
Message-ID: <20240411140750.GA2399047@google.com>
References: <20240402111700.494004-1-andreas@kemnade.info>
 <20240402111700.494004-3-andreas@kemnade.info>
 <20240411115047.GI1980182@google.com>
 <f89d63ca-1db2-47fa-8d66-943fc7454643@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f89d63ca-1db2-47fa-8d66-943fc7454643@gmail.com>

On Thu, 11 Apr 2024, Matti Vaittinen wrote:

> On 4/11/24 14:50, Lee Jones wrote:
> > On Tue, 02 Apr 2024, Andreas Kemnade wrote:
> > 
> > > Since the chip can power off the system, add the corresponding
> > > functionality.
> > > Based on https://github.com/kobolabs/Kobo-Reader/raw/master/hw/imx6sll-clara2e/kernel.tar.bz2
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > > ---
> > >   drivers/mfd/rohm-bd71828.c       | 36 +++++++++++++++++++++++++++++++-
> > >   include/linux/mfd/rohm-bd71828.h |  3 +++
> > >   2 files changed, 38 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
> > > index 594718f7e8e1..4a1fa8a0d76a 100644
> > > --- a/drivers/mfd/rohm-bd71828.c
> > > +++ b/drivers/mfd/rohm-bd71828.c
> > > @@ -464,6 +464,27 @@ static int set_clk_mode(struct device *dev, struct regmap *regmap,
> > >   				  OUT32K_MODE_CMOS);
> > >   }
> > > +static struct i2c_client *bd71828_dev;
> > > +static void bd71828_power_off(void)
> > > +{
> > > +	while (true) {
> > > +		s32 val;
> > > +
> > > +		/* We are not allowed to sleep, so do not use regmap involving mutexes here. */
> > > +		val = i2c_smbus_read_byte_data(bd71828_dev, BD71828_REG_PS_CTRL_1);
> > > +		if (val >= 0)
> > > +			i2c_smbus_write_byte_data(bd71828_dev,
> > > +						  BD71828_REG_PS_CTRL_1,
> > > +						  BD71828_MASK_STATE_HBNT | (u8)val);
> > > +		mdelay(500);
> > > +	}
> > > +}
> > > +
> > > +static void bd71828_remove_poweroff(void *data)
> > > +{
> > > +	pm_power_off = NULL;
> > > +}
> > > +
> > >   static int bd71828_i2c_probe(struct i2c_client *i2c)
> > >   {
> > >   	struct regmap_irq_chip_data *irq_data;
> > > @@ -542,7 +563,20 @@ static int bd71828_i2c_probe(struct i2c_client *i2c)
> > >   	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO, mfd, cells,
> > >   				   NULL, 0, regmap_irq_get_domain(irq_data));
> > >   	if (ret)
> > > -		dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
> > > +		return	dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
> > > +
> > > +	if (of_device_is_system_power_controller(i2c->dev.of_node) &&
> > > +	    chip_type == ROHM_CHIP_TYPE_BD71828) {
> > > +		if (!pm_power_off) {
> > > +			bd71828_dev = i2c;
> > > +			pm_power_off = bd71828_power_off;
> > > +			ret = devm_add_action_or_reset(&i2c->dev,
> > > +						       bd71828_remove_poweroff,
> > > +						       NULL);
> > > +		} else {
> > > +			dev_warn(&i2c->dev, "Poweroff callback already assigned\n");
> > > +		}
> > > +	}
> > >   	return ret;
> > >   }
> > > diff --git a/include/linux/mfd/rohm-bd71828.h b/include/linux/mfd/rohm-bd71828.h
> > > index 3b5f3a7db4bd..9776fde1262d 100644
> > > --- a/include/linux/mfd/rohm-bd71828.h
> > > +++ b/include/linux/mfd/rohm-bd71828.h
> > > @@ -4,6 +4,7 @@
> > >   #ifndef __LINUX_MFD_BD71828_H__
> > >   #define __LINUX_MFD_BD71828_H__
> > > +#include <linux/bits.h>
> > >   #include <linux/mfd/rohm-generic.h>
> > >   #include <linux/mfd/rohm-shared.h>
> > > @@ -41,6 +42,8 @@ enum {
> > >   #define BD71828_REG_PS_CTRL_2		0x05
> > >   #define BD71828_REG_PS_CTRL_3		0x06
> > > +#define BD71828_MASK_STATE_HBNT		BIT(1)
> > > +
> > >   //#define BD71828_REG_SWRESET		0x06
> > 
> > How did this get in here?
> 
> Don't blame me, blame git... Errm... :)
> [mvaittin@fedora linux]$ git blame include/linux/mfd/rohm-bd71828.h |grep
> \/\/
> 1c743ad523bb2 (Matti Vaittinen 2020-01-20 15:43:28 +0200  44) //#define
> BD71828_REG_SWRESET		0x06
> 1c743ad523bb2 (Matti Vaittinen 2020-01-20 15:43:28 +0200 136) //#define
> BD71828_REG_LDO6_VOLT		0x4
> 
> I can send a clean-up patch unless you want to do it while applying other
> stuff...

Please submit a patch.

-- 
Lee Jones [李琼斯]

