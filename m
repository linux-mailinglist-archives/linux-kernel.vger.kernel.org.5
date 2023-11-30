Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B247FE7E0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 04:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344375AbjK3Dzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 22:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjK3Dzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 22:55:51 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB57D5C;
        Wed, 29 Nov 2023 19:55:56 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-67a1c826bb6so2614236d6.1;
        Wed, 29 Nov 2023 19:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701316555; x=1701921355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p7mj1aVm7jIA3GZmG/4WAEi+ODPwVcTeua2L8iuVhNw=;
        b=Z4SnBVzSQEewHYFc8MyxbztUgQXoNLecc10obSAGW65PW3T6yUFb32srXcpQJLE8zg
         TspMl1Mw806XQtqtjEfycCAQkiCd07s79mvy7dVGPRTrpmdNuOy6S/zek5jENSwBLYy9
         PVFcUwSPIthWmYR6icxYIEsRr4SrSS4QB3yr1hzX23Tg+Jra+wA8T0wqTNRBYCUwBERO
         E6Ru3Y/RS5/kdY+S4kLQ/G+ET1NFPSudenI6UxM22QnIIyqSlI3jPVzIx5ySFUwCj1No
         dvlgLXcNmaYaNeT2HIMPPDFsXsz1GgFRmlvmuPxZxlMm68N5wk8RaLB/iCrkEEIkROub
         AWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701316555; x=1701921355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7mj1aVm7jIA3GZmG/4WAEi+ODPwVcTeua2L8iuVhNw=;
        b=bIl2SQrYZyU1AtbQP7qtKD/eU2BS14x9k0IeGSxFPXxI/+bWGFngyIktZkWPWreNHe
         5M6vIqleWCLpwehx6U7TrOSCWv7G36D1tW3R/7Sy6zxso3Lcn7q7iM0nfIjrF0qz+Lm8
         atp7rAE07ITz5q1zDe9oJ7sr0YP210//qzW319vtZmAnfcn4NrYsXcVieO65DPsyb+wi
         xG2qs70iR3EPMDQKEIuXS3QF6AvfO0KFXD6cB0ztN09KezblJLyc1omJusysUhcd3Ian
         qok2BmK1gX8iLsEr7azAFcoSNtKC4hpZ0OpwoovsfxQC8LGW4H6ur0QunwOgm/rPqGr9
         3Fkg==
X-Gm-Message-State: AOJu0YyQxcBl+W2/2nG6CxLMOSZ5rGhTWyjFPqwBeGlVy0K7Y9IZVlYz
        VuccBmwtn+k4dnjajHSiVD6UgIoQWDU=
X-Google-Smtp-Source: AGHT+IHLAGS6Eu4SifP+kuXx85KKizP1MXP3PIPFbTBP0B3UhRkqcQllBXNGbSne94Rvudr9G66BIA==
X-Received: by 2002:ad4:4109:0:b0:67a:228d:6462 with SMTP id i9-20020ad44109000000b0067a228d6462mr17651467qvp.30.1701316555254;
        Wed, 29 Nov 2023 19:55:55 -0800 (PST)
Received: from abdel ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id j19-20020a0cf313000000b0067a0faae794sm104028qvl.99.2023.11.29.19.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 19:55:54 -0800 (PST)
Date:   Wed, 29 Nov 2023 22:55:44 -0500
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: temperature: Add support for AMS AS6200
Message-ID: <ZWgHwJxTnWILzZ7f@abdel>
References: <7e108db19cd9ad19b6413f65099280c010325a91.1699740057.git.alkuor@gmail.com>
 <cbde9aa61905a0fae6573d707b4c9c4fc4598fa5.1699740057.git.alkuor@gmail.com>
 <20231126175726.1ec003c5@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126175726.1ec003c5@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 05:57:26PM +0000, Jonathan Cameron wrote:
> On Sat, 11 Nov 2023 17:05:02 -0500
> Abdel Alkuor <alkuor@gmail.com> wrote:
> 
> > as6200 is a high accuracy temperature sensor of 0.0625C with a range
> > between -40 to 125 Celsius degrees. The driver implements the alert
> > trigger event in comparator mode where an alert would trigger
> > when n number of consecutive current temperature is above the upper
> > temp limit, and the alert is only cleared when the n number of
> > consecutive current temperature is below the lower temp limit.
> > 
> Hi Abdel,
> 
> Comments inline.  Sorry it took so long for you get a review.  I've been
> travelling + snowed under since returning.
> Seems like a very feature rich driver whilst still being nice and short :)
>
Hi Jonathan,

No worries. I figured as I'm following you on LinkedIn :-) I hope you
enjoyed your travel.

Thank you for your time and the thorough review. I'll address your
comments in v2.
> > The driver supports the following:
> > - show available sampling frequencey
> > - read/write sampling frequency
> > - read raw temperature
> > - read scaling factor
> > - read/write consective faults to trigger/clear an alert
> > - show available consecutive faults
> > - buffer trigger
> > - temperature alert event trigger
> > 
> > https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
> 
> Use a formal tag in the tag block for this.
> 
> > 
> Datasheet: https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
Will add it.
> > Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> 
> 
> 
> > ---
> >  drivers/iio/temperature/Kconfig  |   9 +
> >  drivers/iio/temperature/Makefile |   1 +
> >  drivers/iio/temperature/as6200.c | 507 +++++++++++++++++++++++++++++++
> >  3 files changed, 517 insertions(+)
> >  create mode 100644 drivers/iio/temperature/as6200.c
> > 
> > diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> > index ed384f33e0c7..f32691744952 100644
> > --- a/drivers/iio/temperature/Kconfig
> > +++ b/drivers/iio/temperature/Kconfig
> > @@ -157,5 +157,14 @@ config MAX31865
> >  
> >  	  This driver can also be build as a module. If so, the module
> >  	  will be called max31865.
> blank line.  Also should be in alphabetical order, not down the end of the file.
> 
> Appending to the end causes a lot more trouble for merging multiple series than
> alphabetical order, which is one reason we always try to keep these files in order.
> 
> > +config AS6200
> > +       tristate "AS6200 temperature sensor"
> > +       depends on I2C
> > +       help
> > +         If you say yes here you get support for AS6200
> > +         temperature sensor chip connected via I2C.
> > +
> > +         This driver can also be built as a module.  If so, the module
> > +         will be called as6200.
> >  
> >  endmenu
> > diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> > index dfec8c6d3019..48f647c273c1 100644
> > --- a/drivers/iio/temperature/Makefile
> > +++ b/drivers/iio/temperature/Makefile
> > @@ -17,3 +17,4 @@ obj-$(CONFIG_TMP007) += tmp007.o
> >  obj-$(CONFIG_TMP117) += tmp117.o
> >  obj-$(CONFIG_TSYS01) += tsys01.o
> >  obj-$(CONFIG_TSYS02D) += tsys02d.o
> > +obj-$(CONFIG_AS6200) += as6200.o
> Alphabetical order.
> 
Will be fixed in v2.
> > diff --git a/drivers/iio/temperature/as6200.c b/drivers/iio/temperature/as6200.c
> > new file mode 100644
> > index 000000000000..a18c5be0a229
> > --- /dev/null
> > +++ b/drivers/iio/temperature/as6200.c
> > @@ -0,0 +1,507 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for AMS AS6200 Temperature sensor
> > + *
> > + * Auther: Abdel Alkuor <alkuor@gmail.com>
> Spell check comments Author.
> > + */
> > +
> > +#include <linux/i2c.h>
> 
> Alphabetical order, but it's common to have the iio/*
> headers as a separate block afterwards given this is an IIO driver.
> 
Will be addressed in v2.
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/device.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/kstrtox.h>
> > +
> > +#define AS_TVAL_REG	0x0
> 
> Probably want a more specific prefix.
> AS6200_TVAL_REG etc
> 
Sounds good. I'll prefix AS6200 for the defines.
> > +#define AS_CONFIG_REG	0x1
> > +#define AS_TLOW_REG	0x2
> > +#define AS_THIGH_REG	0x3
> > +
> > +/* AS_CONFIG_REG */
> The register and field naming should make it clear enough which register
> these are in.  It think that is true here so you don't need the comment.
> Excess comments are just opportunities for code rot so keep them for when
> they add significant value.
> 
Will be removed in v2.
> > +#define AS_CONFIG_AL	BIT(5)
> > +#define AS_CONFIG_CR	GENMASK(7, 6)
> > +#define AS_CONFIG_SM	BIT(8)
> > +#define AS_CONFIG_IM	BIT(9)
> > +#define AS_CONFIG_POL	BIT(10)
> > +#define AS_CONFIG_CF	GENMASK(12, 11)
> > +
> > +#define AS_TEMP_SCALE		62500
> 
> This isn't a magic number, it's an actual quantity. As such, just put the
> number inline in the code rather than use a define that just makes it harder
> to review.
>
Understood. Will be removed in v2
> > +
> > +struct as6200_freq {
> > +	int val;
> > +	int val2;
> > +};
> 
> I don't mind the structure, but not sure it adds much over a simple 2d array of
> integers given the ordering of val and val2 is fairly natural anyway.
>
Cool. I'll use a 2d array instead.
> > +
> > +struct as6200 {
> > +	struct device *dev;
> > +	struct regmap *regmap;
> > +	struct mutex lock;
> All locks need a comment to explain what data they are protecting.
> 
A comment will be added in v2.
> > +	struct iio_dev *indio_dev;
> 
> You may have noticed this is almost never done in IIO drivers. It normally
> indicates a problem with the architecture.  There is a natural way to go
> from iio_dev to iio_priv() so we shouldn't nee to go the other way.
> 
This makes a lot of sense, not sure how I missed that. Will use iio_priv instead.
> If you did need to have a remove() (which you don't - see later) then
> should by the struct iio_dev * in the i2c_clientdata not the
> iio_priv() structure.
>
No need, remove() will be removed in v2 as you suggested below.
> > +
> > +	unsigned int data[3];
> > +};
> > +
> > +static const struct as6200_freq as6200_samp_freq[4] = {
> > +	{0, 250000},
> 
> Trivial: Slight preference for more spaces { 0, 2500000 },
> 
> > +	{1, 0},
> > +	{4, 0},
> > +	{8, 0},
> > +};
> > +
Will added spaces in v2.
> > +static const struct iio_event_spec as6200_temp_event[] = {
> > +	{
> > +		.type = IIO_EV_TYPE_THRESH,
> > +		.dir = IIO_EV_DIR_RISING,
> > +		.mask_separate = BIT(IIO_EV_INFO_VALUE)
> > +	},
> > +	{
> > +		.type = IIO_EV_TYPE_THRESH,
> > +		.dir = IIO_EV_DIR_FALLING,
> > +		.mask_separate = BIT(IIO_EV_INFO_VALUE)
> > +	},
> > +};
> > +
> > +static const struct iio_chan_spec as6200_temp_channels[] = {
> 
> There aren't any other channels so as6200_channels is enough.
>
Will be renamed in v2.
> > +	{
> > +		.type = IIO_TEMP,
> > +		.indexed = 0,
> That's the 'obvious' default so don't provide it.
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE) |
> > +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +		.scan_index = 0,
> 
> With .indexed =0, this isn't used so no need to specify it here.
>
Will be addressed in v2.
> > +		.scan_type = {
> > +			.sign = 's',
> > +			.realbits = 12,
> > +			.storagebits = 16,
> > +			.shift = 4,
> > +		},
> > +		.event_spec = as6200_temp_event,
> > +		.num_event_specs = ARRAY_SIZE(as6200_temp_event),
> > +	},
> > +	IIO_CHAN_SOFT_TIMESTAMP(1),
> > +};
> > +
> > +static const struct regmap_config as6200_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 16,
> > +	.max_register = 0x7F,
> > +};
> > +
> > +static int
> > +as6200_modify_config_reg(struct as6200 *as, unsigned int mask, unsigned int val)
> > +{
> > +	int ret;
> > +	unsigned int reg;
> > +
> > +	ret = regmap_read(as->regmap, AS_CONFIG_REG, &reg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	reg &= ~mask;
> > +	reg |= val << (ffs(mask) - 1);
> > +
> > +	return regmap_write(as->regmap, AS_CONFIG_REG, reg);
> 
> regmap has functions to handle a read modify write cycle as simple as this.
> Use those instead of inventing your own.  regmap_update_bits() for example
> 
> They also hold the regmap lock over the whole cycle which can simplify locking
> requirements on a driver using it.
> 
Sure, I'll use regmap_update_bits instead.
> 
> > +}
> > +
> > +static int
> > +as6200_read_config_reg(struct as6200 *as, unsigned int mask, unsigned int *val)
> 
> All the masks passed to this are constant, so it would be better to just
> put something like
> 
> 	ret = regmap_read(as->regmap, AS_CONFIG_REG, &reg);
> 	if (ret)
> 		return ret;
> 
> 	x = FIELD_GET(reg, MASK);
> 
> inline and get rid of this function entirely.
>
Sounds good.
> > +{
> > +	int ret;
> > +	unsigned int reg;
> > +
> > +	ret = regmap_read(as->regmap, AS_CONFIG_REG, &reg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*val = (reg & mask) >> (ffs(mask) - 1);
> > +
> > +	return 0;
> > +}
> > +
> 
> > +
> > +static int as6200_read_event_value(struct iio_dev *indio_dev,
> > +			 const struct iio_chan_spec *chan,
> > +			 enum iio_event_type type,
> > +			 enum iio_event_direction dir,
> > +			 enum iio_event_info info,
> > +			 int *val, int *val2)
> > +{
> > +	struct as6200 *as = iio_device_get_drvdata(indio_dev);
> > +	unsigned int reg;
> > +	int ret;
> > +	unsigned int temp;
> > +
> > +	switch (dir) {
> > +	case IIO_EV_DIR_FALLING:
> > +		reg = AS_TLOW_REG;
> > +		break;
> > +	case IIO_EV_DIR_RISING:
> > +		reg = AS_THIGH_REG;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = regmap_read(as->regmap, reg, &temp);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*val = sign_extend32(temp >> 4, 11);
> 
> That shift looks like it should be handled via a FIELD_GET()
> an appropriate mask.
>
Will add a temp mask to handle this.
> > +
> > +	return IIO_VAL_INT;
> > +}
> > +
> > +static int as6200_write_event_value(struct iio_dev *indio_dev,
> > +			  const struct iio_chan_spec *chan,
> > +			  enum iio_event_type type,
> > +			  enum iio_event_direction dir,
> > +			  enum iio_event_info info,
> > +			  int val, int val2)
> > +{
> > +	struct as6200 *as = iio_device_get_drvdata(indio_dev);
> 
> Why? You have the iio_dev so
> 	struct as6000 *as = iio_priv(indio_dev);
> 
Yup, I misunderstood the use of iio_device_get_drvdata. Will use
iio_priv instead in v2.
> > +	unsigned int temp;
> > +	unsigned int reg;
> > +
> > +	/*
> > +	 * range without applying the scaling
> > +	 * factor of 0.06250
> > +	 */
> > +	if (val > 2000 || val < -640)
> > +		return -EINVAL;
> > +
> > +	temp = (val & 0xfff) << 4;
> 
> FIELD_PREP() with appropriately defined _MASK
> 
Will be addressed in v2.
> > +
> > +	switch (dir) {
> > +	case IIO_EV_DIR_FALLING:
> > +		reg = AS_TLOW_REG;
> > +		break;
> > +	case IIO_EV_DIR_RISING:
> > +		reg = AS_THIGH_REG;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return regmap_write(as->regmap, reg, temp);
> > +}
> > +
> > +static irqreturn_t as6200_event_handler(int irq, void *private)
> > +{
> > +	struct iio_dev *indio_dev = private;
> > +	struct as6200 *as = iio_device_get_drvdata(indio_dev);
> As above.
> > +	unsigned int alert;
> > +	enum iio_event_direction dir;
> > +	int ret;
> > +
> > +	mutex_lock(&as->lock);
> 	guard(mutex)(&as->lock);
> 
> then you don't need to do any manual unlocking.
> 
This is pretty cool. I've never known this exists. Now, I know
and I'll use it :)
> > +
> > +	ret = as6200_read_config_reg(as, AS_CONFIG_AL, &alert);
> > +	if (ret) {
> > +		mutex_unlock(&as->lock);
> > +		return IRQ_NONE;
> > +	}
> > +
> > +	dir = alert ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
> > +
> > +	iio_push_event(indio_dev,
> > +		       IIO_EVENT_CODE(IIO_TEMP, 0, 0,
> > +				      dir,
> > +				      IIO_EV_TYPE_THRESH,
> > +				      0, 0, 0),
> > +		       iio_get_time_ns(indio_dev));
> > +
> > +	mutex_unlock(&as->lock);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t as6200_trigger_handler(int irq, void *private)
> > +{
> > +	struct iio_poll_func *pf = private;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct as6200 *as = iio_device_get_drvdata(indio_dev);
> > +	int ret;
> > +
> > +	mutex_lock(&as->lock);
> 
> 	scoped_guard(mutex, &as->lock) {
> 		ret = regmap_read(as->regmap, AS_TVAL_REG, &as->data[0]);
> 		if (ret)
> 			break;
> 
> 		iio_push_to_buffers_with_timestamp(indio_dev, as->data,
> 						   iio_get_time_ns(indio_dev));
> 
> However, data isn't big enough. It should contain enough space for the data + 
> a naturally aligned s64 (so 16 bytes).  This interface is deeply unintuitive
> but we have been stuck with it for a long time now :(
> 
I agree, the data index for each element kinda depend on the alignment.
So from user space, a user needs to be aware of such alignment to
process each data element properly.
> Also, I'm not sure why we can't just have data on the stack and if we do,
> is there a need for the lock?
>
This is a good point. Simply, an oversight from my side. I'll remove the
lock and put the data on the stack.
> 	}
> 
> 	iio_trigger_notify_done()....
> 
> 	
> > +
> > +	ret = regmap_read(as->regmap, AS_TVAL_REG, &as->data[0]);
> > +	if (!ret)
> > +		iio_push_to_buffers_with_timestamp(indio_dev, as->data,
> > +						   iio_get_time_ns(indio_dev));
> > +
> > +	mutex_unlock(&as->lock);
> > +
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> 
> > +
> > +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("0.25 1 4 8");
> > +static IIO_CONST_ATTR(avail_consecutive_faults, "1 2 4 6");
> > +static IIO_DEVICE_ATTR_RW(consecutive_faults, 0);
> > +
> > +static struct attribute *as6200_event_attributes[] = {
> > +	&iio_const_attr_avail_consecutive_faults.dev_attr.attr,
> > +	&iio_dev_attr_consecutive_faults.dev_attr.attr,
> Custom ABI, so should be some documentation.
> 
> I'm guessing a bit, but sounds like the standard ABI period
> to me.
> https://elixir.bootlin.com/linux/latest/source/Documentation/ABI/testing/sysfs-bus-iio#L1163
> 
> However you will need to take into account current sampling frequency
> and provide this in seconds as per the documentation.
>
Sounds good. I'll add it under period with the proper conversions.
> It's absolutely fine to have available change with the sampling
> frequency.
> 
> > +	NULL,
> > +};
> > +
> > +static struct attribute *as6200_attributes[] = {
> > +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> 
> For this one, use read_avail() and appropriate bitmaps.
> That both reduces manual handling of attributes and allows in kernel
> consumers to potentially access this parameter.
>
Will be addressed in v2.
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group as6200_attribute_group = {
> > +	.attrs = as6200_attributes,
> > +};
> > +
> > +static const struct attribute_group as6200_event_attribute_group = {
> > +	.attrs = as6200_event_attributes,
> > +};
> > +
> > +static const struct iio_info as6200_temp_info = {
> > +	.event_attrs = &as6200_event_attribute_group,
> > +	.attrs = &as6200_attribute_group,
> > +	.read_raw = &as6200_read_raw,
> > +	.write_raw = &as6200_write_raw,
> > +	.read_event_value = &as6200_read_event_value,
> > +	.write_event_value = &as6200_write_event_value,
> > +};
> > +
> > +static int as6200_probe(struct i2c_client *client)
> > +{
> > +	struct as6200 *as;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> > +		return -EINVAL;
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, 0);
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	as = devm_kzalloc(&client->dev, sizeof(*as), GFP_KERNEL);
> > +	if (IS_ERR(as))
> > +		return PTR_ERR(as);
> > +
> > +	as->regmap = devm_regmap_init_i2c(client, &as6200_regmap_config);
> > +	if (IS_ERR(as->regmap))
> > +		return PTR_ERR(as->regmap);
> > +
> > +	mutex_init(&as->lock);
> > +
> > +	as->dev = &client->dev;
> > +	as->indio_dev = indio_dev;
> > +
> > +	iio_device_set_drvdata(indio_dev, as);
> > +
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->channels = as6200_temp_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(as6200_temp_channels);
> > +	indio_dev->name = client->name;
> 
> Encode the string directly here. The different firmware types fill client->name
> in via various fragile means. Things are safer if we don't rely on that.
>
Will encode the string directly in v2.
> > +	indio_dev->info = &as6200_temp_info;
> > +
> > +	ret = devm_iio_triggered_buffer_setup(as->dev, indio_dev,
> > +					      NULL,
> > +					      as6200_trigger_handler,
> > +					      NULL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (client->irq) {
> > +		ret = devm_request_threaded_irq(as->dev,
> > +						client->irq,
> > +						NULL,
> > +						&as6200_event_handler,
> > +						IRQF_ONESHOT,
> > +						client->name,
> > +						indio_dev);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	i2c_set_clientdata(client, as);
> > +
> > +	return iio_device_register(indio_dev);
> 
> As only thing in remove is iio_device_unregister() use
> 	return devm_iio_device_register(indio_dev);
> and drop remove() callback entirely.
>
Sounds good.
> > +}
> > +
> > +static void as6200_remove(struct i2c_client *client)
> > +{
> > +	struct as6200 *as = i2c_get_clientdata(client);
> > +
> > +	iio_device_unregister(as->indio_dev);
> > +}
> 
> ...
> 
will be dropped in v2.
> > +
> > +static const struct dev_pm_ops as6200_pm_ops = {
> > +	SET_SYSTEM_SLEEP_PM_OPS(as6200_suspend, as6200_resume)
> > +};
> > +
> > +static const struct i2c_device_id as6200_id_table[] = {
> > +	{ "as6200" },
> > +	{ },
> As below.
> 
> > +};
> > +MODULE_DEVICE_TABLE(i2c, as6200_id_table);
> > +
> > +static const struct of_device_id as6200_of_match[] = {
> > +	{ .compatible = "ams,as6200" },
> > +	{ },
> 
> No point in a , after a 'NULL' like terminator as we will 
> never add anything after it.
>
Understood.
> > +};
> > +MODULE_DEVICE_TABLE(of, as6200_of_match);
> > +
> > +static struct i2c_driver as6200_driver = {
> > +	.driver = {
> > +		.name = "as6200",
> > +		.pm = &as6200_pm_ops,
> 		.pm = pm_sleep_ptr(&as6200_pm_ops),
> 
> see what that function is doing to understand why (all about cleaning up
> unnecessary code if the PM config doesn't require it)
> 
Will be added in v2.
> > +		.of_match_table = as6200_of_match,
> > +	},
> > +	.probe = as6200_probe,
> > +	.remove = as6200_remove,
> > +	.id_table = as6200_id_table,
> > +};
> > +module_i2c_driver(as6200_driver);
> > +
> > +MODULE_AUTHOR("Abdel Alkuor <alkuor@gmail.com");
> > +MODULE_DESCRIPTION("AMS AS6200 Temperature Sensor");
> > +MODULE_LICENSE("GPL");
> 
