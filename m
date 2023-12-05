Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810A2804486
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjLECQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjLECQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:16:41 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FC4107;
        Mon,  4 Dec 2023 18:16:46 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77dd4532a60so361784185a.2;
        Mon, 04 Dec 2023 18:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701742606; x=1702347406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YJvYfpdx4Dv3ZMACoLttg384q/B4GTiS77MM47VJumU=;
        b=kBj3tR3jkiKMzwnIJyXNJTw4z4KkhKP7sIGSDcCEoqVR7COvVX1Pm9xr6VGPHzXl40
         F6pymsJ4xNN+TbQCwZDdxd8ADR+xA6RIC84H5kAH1mQ+Nm0s0QuOIbIBbwukB8mIRgHX
         N7e78Gpv+pWmT9Lhopc4nRnV447MMj9m9YsERRNznGDbvCbUjMtzqb4kLr347rVJG9CJ
         R3rNRzEfp/paWKrC/pVyTpuiTL6HYW3EjCWms7Zg2aB3hNcQphPxUh08Vblk+WZbZugh
         zVhzbwPuEniv3rQBVgm9L6MPdL646gGFVtDaLkbXOkSzP3ReWJUfwlz7tdDPvwDGlvim
         syCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701742606; x=1702347406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJvYfpdx4Dv3ZMACoLttg384q/B4GTiS77MM47VJumU=;
        b=j3qyadCFpYsmWpfuJRAgW5AaD1cpqILiFNqixD/MJBQf9IYVNtLqvn0vflzCOl9pLq
         6eFJj/QBn3v9mttAQ8f61zuzFqD/Avbrr1t0m5oZzue+Lqmt2p4+6F2eCO+I1JKCpyGL
         pl9Tt8YZf12GL3n4xG3DZ9lezh9wCmAsT0wcJ6EdC7ZGfFG/iM0zEFcj5y+YL9hbwU2z
         WIqSO9IA2H4wke5PmZPrt9uTRWxTdcXasOFRwXAod60GzW8BvsJHE9f966EQXQnQ4JbC
         BG4eas3YPadfGewGET7SwVsnrX64EPkP3e7eSQPONY8CPdLkPw2bqhgtBwt3n0T7+4u2
         nRXQ==
X-Gm-Message-State: AOJu0YxuuVa7cgAf7zJQ+HX6xdaXb1KvQ018WXxf9nFRMSHrsww8gM2i
        84ouJWRE1x1Y+bCtejuBV4XPMmvOeRu4SA==
X-Google-Smtp-Source: AGHT+IH9YVBqotP2NLDIK98VWhd2qevLzXqU3eb0dmV5lWwjUcw9OnX5FhsTapTzZ8BeOor0nBabsw==
X-Received: by 2002:a05:620a:1206:b0:77f:878:b58 with SMTP id u6-20020a05620a120600b0077f08780b58mr535341qkj.153.1701742605606;
        Mon, 04 Dec 2023 18:16:45 -0800 (PST)
Received: from abdel ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id k13-20020a05620a07ed00b0077d61831eb2sm4716435qkk.40.2023.12.04.18.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 18:16:45 -0800 (PST)
Date:   Mon, 4 Dec 2023 21:16:34 -0500
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, conor+dt@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: temperature: Add support for AMS AS6200
Message-ID: <ZW6IArKhx4KvxyTD@abdel>
References: <20231202041651.719963-1-alkuor@gmail.com>
 <20231202041651.719963-2-alkuor@gmail.com>
 <20231204135014.15ea47b6@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204135014.15ea47b6@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 01:50:14PM +0000, Jonathan Cameron wrote:
> On Fri,  1 Dec 2023 23:16:51 -0500
> Abdel Alkuor <alkuor@gmail.com> wrote:
> 
> > as6200 is a high accuracy temperature sensor of 0.0625C with a range
> > between -40 to 125 Celsius degrees.
> > 
> > The driver implements the alert trigger event in comparator mode where
> > consecutive faults are converted into periods, high/low temperature
> > thresholds require to be above/below the set limit for n seconds for
> > the alert to be triggered/cleared. The alert is only cleared when the
> > current temperature is below the low temperature threshold for n seconds.
> > 
> > The driver supports the following:
> > - show available sampling frequencey
> > - read/write sampling frequency
> > - read raw temperature
> > - read scaling factor
> > - read/write temperature period that needs to be met for low/high
> >   temperature thresholds to trigger an alert
> > - show available temperature period thresholds
> > - buffer trigger
> > - temperature alert event trigger
> 
> Hi Abdel,
> 
> A few comments inline. Looking good in general.
>
Hi Jonathon,

Thank you for your time. I have a couple _silly_ questions about the tag
and returning from if else. Other than that, your comments will be addressed
in v3.
> > 
> > Datasheet: https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
> > 
> 
> No blank line here.  Tags block (and Datasheet is a tag) never has blank lines
> as that breaks some existing tooling.
> 
Understood. 

P.S. when running checkpatch.pl on this patch, I get the following warning:

WARNING: Unknown link reference 'Datasheet:', use 'Link:' or 'Closes:' instead

should I use Link instead?
> > Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> >  
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_filter_notch_center_frequency
> > diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> > index ed384f33e0c7..a0ffbc77e623 100644
> > --- a/drivers/iio/temperature/Kconfig
> > +++ b/drivers/iio/temperature/Kconfig
> > @@ -4,6 +4,17 @@
> >  #
> >  menu "Temperature sensors"
> >  
> > +config AS6200
> > +       tristate "AS6200 temperature sensor"
> > +       depends on I2C
> > +       select REGMAP_I2C
> > +       help
> > +         If you say yes here you get support for AS6200
> > +         temperature sensor chip connected via I2C.
> > +
> > +         This driver can also be built as a module.  If so, the module
> > +         will be called as6200.
> > +
> >  config IQS620AT_TEMP
> >  	tristate "Azoteq IQS620AT temperature sensor"
> >  	depends on MFD_IQS62X || COMPILE_TEST
> > @@ -157,5 +168,4 @@ config MAX31865
> >  
> >  	  This driver can also be build as a module. If so, the module
> >  	  will be called max31865.
> > -
> Stray change.
>
Ops, I fixed it locally and forgot to regenerate a patch after. Will be fixed
in v3
> >  endmenu
> 
> > diff --git a/drivers/iio/temperature/as6200.c b/drivers/iio/temperature/as6200.c
> > new file mode 100644
> > index 000000000000..7fcc785871d8
> > --- /dev/null
> > +++ b/drivers/iio/temperature/as6200.c
> > @@ -0,0 +1,493 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for AMS AS6200 Temperature sensor
> > + *
> > + * Author: Abdel Alkuor <alkuor@gmail.com>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/device.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kstrtox.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +
> > +#define AS6200_TVAL_REG		0x0
> > +#define AS6200_CONFIG_REG	0x1
> > +#define AS6200_TLOW_REG		0x2
> > +#define AS6200_THIGH_REG	0x3
> > +
> > +#define AS6200_CONFIG_AL	BIT(5)
> > +#define AS6200_CONFIG_CR	GENMASK(7, 6)
> > +#define AS6200_CONFIG_SM	BIT(8)
> > +#define AS6200_CONFIG_IM	BIT(9)
> > +#define AS6200_CONFIG_POL	BIT(10)
> > +#define AS6200_CONFIG_CF	GENMASK(12, 11)
> > +
> > +#define AS6200_TEMP_MASK	GENMASK(15, 4)
> > +
> > +struct as6200 {
> > +	struct regmap *regmap;
> > +	struct mutex lock; /* Prevent concurrent temp fault processing */
> 
> Why does it matter? What might cause such processing?
> 
Good point. I had a misunderstanding how the interrupts work and I did
some reading and realized that the interrupt is disabled until the
buttom half of the interrupt is completed as oneshot type is used.
I'll remove it in v3.
> > +};
> > +
> > +static const int as6200_samp_freq[4][2] = {
> > +	{ 0, 250000 },
> > +	{ 1, 0 },
> > +	{ 4, 0 },
> > +	{ 8, 0 }
> > +};
> > +
> > +/* Consective faults converted to period */
> > +static const int as6200_temp_thresh_periods[4][4][2] = {
> > +	{ { 4, 0 }, { 8, 0 }, { 16, 0 }, { 24, 0 } },
> > +	{ { 1, 0 }, { 2, 0 }, { 4, 0 }, { 6, 0 } },
> > +	{ { 0, 250000 }, { 0, 500000 }, { 1, 0 }, { 2, 0} },
> > +	{ { 0, 125000 }, { 0, 250000 }, { 0, 500000 }, { 0, 750000 } }
> 
> I'd suggest naming the first column at least (which is CR I think?)
> 
> So define an enum and 
> enum {
> 	AS6200_CR_0_25HZ = 0,
> 	AS6200_CR_1HZ = 1,
> 	AS6200_CR_4HZ = 2,
> 	AS6200_CR_8HZ = 3,
> };
> And use that for the samp freq entries above, so that they clearly relate
> to the rows of this arram
> 	[AS6200_CR_0_25HZ] = { { 4, 0 }, { 8, 0 }, { 16, 0 }, { 24, 0 } },
> You could take it further and use an enum for CF as well.
> 
> 	[AS6200_CR_0_25HZ] = {
> 		[AS6200_CF_1] = { 4, 0 },
> 		[AS6200_CF_2] = { 8, 0 },
> 		[AS6200_CF_4] = { 16, 0 },
> 		[AS6200_CF_6] = { 24, 0 },
> 	},
> 	[AS6200_CR_1_HZ] = {
> 		[AS6200_CF_1] = { 1, 0 },
> 		[AS6200_CF_2] = { 2, 0 },
> 	...	
> 	}
> 	etc which makes it clear where all the numbers come.
> 
> > +};
>
Good suggestion. I'll fix it in v3.
> 
> > +static int as6200_read_event_value(struct iio_dev *indio_dev,
> > +				   const struct iio_chan_spec *chan,
> > +				   enum iio_event_type type,
> > +				   enum iio_event_direction dir,
> > +				   enum iio_event_info info,
> > +				   int *val, int *val2)
> > +{
> > +	struct as6200 *as = iio_priv(indio_dev);
> > +	unsigned int reg;
> > +	unsigned int tmp;
> > +	int ret;
> > +	u8 cf;
> > +	u8 cr;
> > +
> > +	switch (dir) {
> > +	case IIO_EV_DIR_FALLING:
> > +		reg = AS6200_TLOW_REG;
> > +		break;
> > +	case IIO_EV_DIR_RISING:
> > +		reg = AS6200_THIGH_REG;
> > +		break;
> > +	case IIO_EV_DIR_EITHER:
> > +		reg = AS6200_CONFIG_REG;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = regmap_read(as->regmap, reg, &tmp);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (info == IIO_EV_INFO_VALUE) {
> > +		*val = sign_extend32(FIELD_GET(AS6200_TEMP_MASK, tmp), 11);
> > +		ret = IIO_VAL_INT;
> return here.
> 
> > +	} else {
> > +		cf = FIELD_GET(AS6200_CONFIG_CF, tmp);
> > +		cr = FIELD_GET(AS6200_CONFIG_CR, tmp);
> > +		*val = as6200_temp_thresh_periods[cr][cf][0];
> > +		*val2 = as6200_temp_thresh_periods[cr][cf][1];
> > +		ret = IIO_VAL_INT_PLUS_MICRO;
> 
> and here.  If there is nothing more to be done, it simplifies the code
> flow being read to just return as quick as possible.
>
I did it as you mentioned, and when running check_patch.pl, it gives back a
warning that else is not needed here because of the return in the if
statement. So I opted into using ret instead, should I remove the else or ignore
the warning?
> > +	}
> > +
> > +	return ret;
> > +}
> 
> > +static irqreturn_t as6200_event_handler(int irq, void *private)
> > +{
> > +	struct iio_dev *indio_dev = private;
> > +	struct as6200 *as = iio_priv(indio_dev);
> > +	unsigned int alert;
> > +	enum iio_event_direction dir;
> > +	int ret;
> > +
> > +	guard(mutex)(&as->lock);
> What data are we protecting here?
> 
No data actually. As I mentioned prior, will be dropped in v3.
> > +
> > +	ret = regmap_read(as->regmap, AS6200_CONFIG_REG, &alert);
> > +	if (ret)
> > +		return IRQ_NONE;
> > +
> > +	alert = FIELD_GET(AS6200_CONFIG_AL, alert);
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
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t as6200_trigger_handler(int irq, void *private)
> > +{
> > +	struct iio_poll_func *pf = private;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct as6200 *as = iio_priv(indio_dev);
> > +	int ret;
> > +	u8 data[16];
> 
> I'd make this much more explicit and make sure you zero it to avoid leaking
> data.
> 
> 	struct data {
> 		u8 channel;
> 		s64 timestamp __aligned(8);
> 	};
> 
> 	memset(&data, 0, sizeof(data)); /* Ensures the holes are zero filled */
>
My system 1 thinking got me here as I tested it and all holes
were set to 0. Will be fixed in v3.
> Also, avoid the casting mess and read into a local variable that is an unsigned int
> and copy it to the struct data if no error.
> > +
> > +	ret = regmap_read(as->regmap, AS6200_TVAL_REG, (unsigned int *)data);
> > +	if (!ret)
> Whilst it's more lines, greatly prefer to see error paths out of line and good
> paths inline (so no if (!ret))
> 
> 	if (ret)
> 		goto done;
> 
> 	iio_push...
> 
> done:
> 	...
> 
> May seem silly but when reviewing a lot of code, keeping things looking "normal"
> is a great benefit!
>
Makes sense. Will be fixed in v3.
> > +		iio_push_to_buffers_with_timestamp(indio_dev, data,
> > +						   iio_get_time_ns(indio_dev));
> > +
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> 
> ...
> 
> > +
> > +static int __maybe_unused as6200_suspend(struct device *dev)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct as6200 *as = iio_priv(i2c_get_clientdata(client));
> > +
> > +	if (client->irq)
> > +		disable_irq(client->irq);
> > +
> > +	return regmap_update_bits(as->regmap, AS6200_CONFIG_REG,
> > +				  AS6200_CONFIG_SM, AS6200_CONFIG_SM);
> > +}
> > +
> > +static int __maybe_unused as6200_resume(struct device *dev)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct as6200 *as = iio_priv(i2c_get_clientdata(client));
> > +
> > +	if (client->irq)
> > +		enable_irq(client->irq);
> 
> I would normally expect suspend and resume to be mirror images. If that doesn't
> make sense for some reason and we do need to do the irq handling
> before the register write in both cases then add a comment.
No reason. Will be fixed in v3.
> 
> > +
> > +	return regmap_update_bits(as->regmap, AS6200_CONFIG_REG,
> > +				  AS6200_CONFIG_SM, 0);
> > +}
> > +
> > +static const struct dev_pm_ops as6200_pm_ops = {
> 
> DEFINE_SIMPLE_DEV_PM_OPS()
>
Will be fixed in v3.
> 
> > +	SET_SYSTEM_SLEEP_PM_OPS(as6200_suspend, as6200_resume)
> > +};
> > +
> > +static const struct i2c_device_id as6200_id_table[] = {
> > +	{ "as6200" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, as6200_id_table);
> > +
> > +static const struct of_device_id as6200_of_match[] = {
> > +	{ .compatible = "ams,as6200" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, as6200_of_match);
> > +
> > +static struct i2c_driver as6200_driver = {
> > +	.driver = {
> > +		.name = "as6200",
> > +		.pm = pm_sleep_ptr(&as6200_pm_ops),
> > +		.of_match_table = as6200_of_match,
> > +	},
> > +	.probe = as6200_probe,
> > +	.id_table = as6200_id_table,
> > +};
> > +module_i2c_driver(as6200_driver);
> > +
> > +MODULE_AUTHOR("Abdel Alkuor <alkuor@gmail.com");
> > +MODULE_DESCRIPTION("AMS AS6200 Temperature Sensor");
> > +MODULE_LICENSE("GPL");
> 
