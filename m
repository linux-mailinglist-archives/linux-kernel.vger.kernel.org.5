Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFB37AD5F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjIYK37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjIYK3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:29:55 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDCCAB;
        Mon, 25 Sep 2023 03:29:46 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c12e378ae0so71082201fa.1;
        Mon, 25 Sep 2023 03:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695637784; x=1696242584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOM06d+BpEedWwj+dRjOmETduqijPnPK8/O7hlefF8U=;
        b=Gkd01WGbWyZDrA4M86FtKKXdpGbBfesE+VLeCh4jO74fsTTkHe4+WpQRI+AG5qSfAg
         hp/On44DGWQR4RfxcDu1xLNyYhXuBeoiiF+9YQA1ZXNK4aTksCwsNHCzFBGqBHuGROdL
         EP7dcTTMku9bI0q1N3UzIknItkTB0rEXtTS2/4ZNbCPRQlsd/WsfvgSHPtjPdaSXV7B0
         U4Gpfp8a32rOaIP3HFHl+gNzl298bFI+0jIQ2BfOLqU3xcv33FHjPW8jtXO2bsKhQ9yy
         /kG+tuVeaR7WreXLarre3muVpr8iebGs+8WFmTeu8xN7WXpMjPF2uVEuSZ2bcok3MTp5
         tBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695637784; x=1696242584;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOM06d+BpEedWwj+dRjOmETduqijPnPK8/O7hlefF8U=;
        b=Vb3f2QGbnz4yBbJFjm/4QSWEHVbAsxTRL6pOYksEW0u23bWYKeG1coG2nY3xk+Iwpg
         QzwU5dyO2KDjS2HRQbj8mR8LIqJwLeD6kXoBQzQEtGT1B3Y1EEt9Xsf+SaybcY8TFUee
         BVf0SLHscZePZeLNqqgaIabODXuX1+8ayb3ewPoVUfhtRzZyPjVmKAhC6Yc9Ss2RoiRK
         a4UlPqLut71n05WW6NxTzesWWP0C8Bbp30DzeHjt8EErik0TfYjOXjAI5OMt3YwxxzBM
         m1yI3Nqugqa+kFKIL3zxQUytNZzs67UuyjIRtDpq29B+Yc09bBjzR7lFZ+8dVPqNYXDJ
         ha1Q==
X-Gm-Message-State: AOJu0YyAM20YoNcPhnFR4gWXeKe4W3M9RQrn3ndanYI6u4FJY265IDIu
        MeKpH0Rzi1QLzrmS2Hwktxk=
X-Google-Smtp-Source: AGHT+IF2ISoHHf72pXQyuIWZuLgxFHo1DgJYxZgtmWDnZxxc8/dB31CDF0ZsTYMcNTPochijENatbw==
X-Received: by 2002:a05:651c:1254:b0:2c0:12f9:3b7c with SMTP id h20-20020a05651c125400b002c012f93b7cmr3676238ljh.11.1695637784000;
        Mon, 25 Sep 2023 03:29:44 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id v15-20020a2e924f000000b002b9e5fe86dasm2132648ljg.81.2023.09.25.03.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 03:29:43 -0700 (PDT)
Message-ID: <e8ece5b4-a471-6f43-8712-04cf6c2c1274@gmail.com>
Date:   Mon, 25 Sep 2023 13:29:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Benjamin Bara <bbara93@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1695380366.git.mazziesaccount@gmail.com>
 <2e2857aa26cf06353f6aeb6d2906ee7a8490aa1a.1695380366.git.mazziesaccount@gmail.com>
 <20230924172955.1a34c163@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 5/6] iio: pressure: Support ROHM BU1390
In-Reply-To: <20230924172955.1a34c163@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/23 19:29, Jonathan Cameron wrote:
> On Fri, 22 Sep 2023 14:19:10 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Support for the ROHM BM1390 pressure sensor. The BM1390GLV-Z can measure
>> pressures ranging from 300 hPa to 1300 hPa with configurable measurement
>> averaging and internal FIFO. The sensor does also provide temperature
>> measurements.
>>
>> Sensor does also contain IIR filter implemented in HW. The data-sheet
>> says the IIR filter can be configured to be "weak", "middle" or
>> "strong". Some RMS noise figures are provided in data sheet but no
>> accurate maths for the filter configurations is provided. Hence, the IIR
>> filter configuration is not supported by this driver and the filter is
>> configured to the "middle" setting (at least not for now).
>>
>> The FIFO measurement mode is only measuring the pressure and not the
>> temperature. The driver measures temperature when FIFO is flushed and
>> simply uses the same measured temperature value to all reported
>> temperatures. This should not be a problem when temperature is not
>> changing very rapidly (several degrees C / second) but allows users to
>> get the temperature measurements from sensor without any additional logic.
>>
>> This driver allows the sensor to be used in two muitually exclusive ways,
>>
>> 1. With trigger (data-ready IRQ).
>> In this case the FIFO is not used as we get data ready for each collected
>> sample. Instead, for each data-ready IRQ we read the sample from sensor
>> and push it to the IIO buffer.
>>
>> 2. With hardware FIFO and watermark IRQ.
>> In this case the data-ready is not used but we enable watermark IRQ. At
>> each watermark IRQ we go and read all samples in FIFO and push them to the
>> IIO buffer.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Main question here is whether the fifo mode is useable if now interrupt
> is wired up? 

I don't think it is.

> I'm guessing not really as it's not worth dealing with making
> it work if someone can't be bothered to connect the wire.  In which case
> I'd expect few more things to be disable if no IRQ.
> Also, didn't think we'd have a validate_own_trigger callback set
> as that means the buffer is potentially also something that should go
> away if no interrupts are wired.

This was what I originally had been thinking. You made me think that we 
should perhaps allow using an external trigger as well - and I tried 
doing that (but obviously didn't test it as I forgot the 
validate_own_trigger in place). I don't really know the potential 
applications for this sensor so I can't imagine if it'd be useful to 
support external triggers. Still, if it is just a matter of dropping the 
validate_own_trigger - then, why limiting the users?

> Anyhow, other than that a few trivial things inline.
> 
> 
>>
>> ---
>> Revision history:
>>
>> v2 => v3:
>> - Read temperature only after FIFO is read to overcome a HW quirck
>> - Drop unused defines
>> - Allow scanning the pressure only
>> - Some clarifying comments added, some made less verbose
>> - warn if measurement stp fails
>> - use IIO_VAL_FRACTIONAL for pressure scale
>> - don't disable IRQ but use timestamp from stack
>> - fix amount of samples to read
>> - minor styling
>> - better separate buffer and trigger parts
>> - allow buffer even when there is no IRQ
>>    with external trigger to be supported.
>> - add completely, utterly useless NULL check because we have the cycles
>>    to waste (grumbles)
> 
> )Smiles)
> 
> 
> 
>> diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
>> index c90f77210e94..436aec7e65f3 100644
>> --- a/drivers/iio/pressure/Makefile
>> +++ b/drivers/iio/pressure/Makefile
>> @@ -5,6 +5,7 @@
>>   
>>   # When adding new entries keep the list in alphabetical order
>>   obj-$(CONFIG_ABP060MG) += abp060mg.o
>> +obj-$(CONFIG_ROHM_BM1390) += rohm-bm1390.o
>>   obj-$(CONFIG_BMP280) += bmp280.o
>>   bmp280-objs := bmp280-core.o bmp280-regmap.o
>>   obj-$(CONFIG_BMP280_I2C) += bmp280-i2c.o
>> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
>> new file mode 100644
>> index 000000000000..82a0cd61d215
>> --- /dev/null
>> +++ b/drivers/iio/pressure/rohm-bm1390.c
> 
>> +
>> +/*
>> + * If the trigger is not used we just wait until the measurement has
>> + * completed. The data-sheet says maximum measurement cycle (regardless
>> + * the AVE_NUM) is 200 mS so let's just sleep at least that long. If speed
>> + * is needed the trigger should be used.
>> + */
>> +#define BM1390_MAX_MEAS_TIME_MS 205
>> +
>> +static int bm1390_read_data(struct bm1390_data *data,
>> +			struct iio_chan_spec const *chan, int *val, int *val2)
>> +{
>> +	int ret, warn;
>> +
>> +	mutex_lock(&data->mutex);
>> +	/*
>> +	 * We use 'continuous mode' even for raw read because according to the
>> +	 * data-sheet an one-shot mode can't be used with IIR filter.
>> +	 */
>> +	ret = bm1390_meas_set(data, BM1390_MEAS_MODE_CONTINUOUS);
>> +	if (ret)
>> +		goto unlock_out;
>> +
>> +	switch (chan->type) {
>> +	case IIO_PRESSURE:
>> +		msleep(BM1390_MAX_MEAS_TIME_MS);
>> +		ret = bm1390_pressure_read(data, val);
>> +		break;
>> +	case IIO_TEMP:
>> +		msleep(BM1390_MAX_MEAS_TIME_MS);
>> +		ret = bm1390_read_temp(data, val);
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +	}
>> +	warn = bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
>> +	if (warn)
>> +		dev_warn(data->dev, "Failed to stop measurementi (%d)\n", warn);
> 
> measurement

Thanks! Seems like an useless vim 'insert' mode change ;)

> 
>> +unlock_out:
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return ret;
>> +}
>> +
> 
>> +static int __bm1390_fifo_flush(struct iio_dev *idev, unsigned int samples,
>> +			       s64 timestamp)
>> +{
>> +	/* BM1390_FIFO_LENGTH is small so we shouldn't run out of stack */
>> +	struct bm1390_data_buf buffer[BM1390_FIFO_LENGTH];
>> +	struct bm1390_data *data = iio_priv(idev);
>> +	int smp_lvl, ret, i, warn, dummy;
>> +	u64 sample_period;
>> +	__be16 temp = 0;
>> +
>> +	ret = regmap_read(data->regmap, BM1390_REG_FIFO_LVL, &smp_lvl);
>> +	if (ret)
>> +		return ret;
>> +
>> +	smp_lvl = FIELD_GET(BM1390_MASK_FIFO_LVL, smp_lvl);
>> +	if (!smp_lvl)
>> +		return 0;
>> +
>> +	if (smp_lvl > BM1390_FIFO_LENGTH) {
>> +		/*
>> +		 * The fifo holds maximum of 4 samples so valid values
>> +		 * should be 0, 1, 2, 3, 4 - rest are probably bit errors
>> +		 * in I2C line. Don't overflow if this happens.
>> +		 */
>> +		dev_err(data->dev, "bad FIFO level %d\n", smp_lvl);
>> +		smp_lvl = BM1390_FIFO_LENGTH;
>> +	}
>> +
>> +	sample_period = timestamp - data->old_timestamp;
>> +	do_div(sample_period, smp_lvl);
>> +
>> +	if (samples && smp_lvl > samples)
>> +		smp_lvl = samples;
>> +
>> +
>> +	/*
>> +	 * After some testing it appears that the temperature is not readable
>> +	 * untill the FIFO access has been done after the WMI. Thus, we need
> Spell check. until  (Why it doesn't have 2 ls is beyond me but that's English being
> annoyingly irregular)

Thanks. I keep mistyping it. I think I've seen checkpatch warnings on 
this kind of mistakes before. Makes me wonder if I forgot to run the 
checkpatch after latest modifications...

> 
>> +	 * to read the all pressure values to memory and read the temperature
>> +	 * only after that.
>> +	 */
>> +	for (i = 0; i < smp_lvl; i++) {
>> +		/*
>> +		 * When we start reading data from the FIFO the sensor goes to
>> +		 * special FIFO reading mode. If any other register is accessed
>> +		 * during the FIFO read, samples can be dropped. Prevent access
>> +		 * until FIFO_LVL is read. We have mutex locked and we do also
>> +		 * go performing reading of FIFO_LVL even if this read fails.
>> +		 */
>> +		if (test_bit(BM1390_CHAN_PRESSURE, idev->active_scan_mask)) {
>> +			ret = bm1390_pressure_read(data, &buffer[i].pressure);
>> +			if (ret)
>> +				break;
>> +		}
>> +
>> +		/*
>> +		 * Old timestamp is either the previous sample IRQ time,
>> +		 * previous flush-time or, if this was first sample, the enable
>> +		 * time. When we add a sample period to that we should get the
>> +		 * best approximation of the time-stamp we are handling.
>> +		 *
>> +		 * Idea is to always keep the "old_timestamp" matching the
>> +		 * timestamp which we are currently handling.
>> +		 */
>> +		data->old_timestamp += sample_period;
>> +		buffer[i].ts = data->old_timestamp;
>> +	}
>> +	/* Reading the FIFO_LVL closes the FIFO access sequence */
>> +	warn = regmap_read(data->regmap, BM1390_REG_FIFO_LVL, &dummy);
>> +	if (warn)
>> +		dev_warn(data->dev, "Closing FIFO sequence failed\n");
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (test_bit(BM1390_CHAN_TEMP, idev->active_scan_mask)) {
>> +		ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp,
>> +				       sizeof(temp));
>> +		if (ret)
>> +			return ret;
>> +		pr_info("Temp before reading the FIFO %u\n", be16_to_cpu(temp));
> 
> Why this print?

Thanks! Forgot a debug phase print here...

> 
>> +	}
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	for (i = 0; i < smp_lvl; i++) {
>> +		buffer[i].temp = temp;
>> +		iio_push_to_buffers_with_timestamp(idev, &buffer[i],
>> +						   buffer[i].ts);
> You can just use iio_push_to_buffers() if you've already filled
> in the timestamp by hand. The _with_timestamp() version was just to reduce
> boilerplate (and given the main it has caused over the years, I'm not
> sure it was a good idea!)

Right. I had a brainfart on this one. Thought that the 
iio_push_to_buffers_with_timestamp() would help in case where timestamp 
was disabled by the user. Now I see this thought was very much not 
correct. That's what I get when writing code at the afternoon, and 
especially at Friday afternoon :) My brains are shutting down early :)

>> +	}
>> +
>> +	return smp_lvl;
>> +}
> 
>> +
>> +static const struct iio_info bm1390_info = {
>> +	.read_raw = &bm1390_read_raw,
>> +	.validate_trigger = iio_validate_own_trigger,
>> +	.hwfifo_set_watermark = bm1390_set_watermark,
>> +	.hwfifo_flush_to_buffer = bm1390_fifo_flush,
> 
> Given my (possibly incorrect assumption) that the fifo is useless
> without the interrupt, I'd expect to see another version of this
> that has read_raw only set.

Yes...

> Also, why do we need validate_own_trigger.  I thought this could
> be used with other triggers. If not, then don't register the buffer
> for the case with no interrupt either.

... and yes. Thank you :)

> 
>> +};
>> +
> 
>> +
>> +static int bm1390_fifo_set_wmi(struct bm1390_data *data)
>> +{
>> +	u8 regval;
>> +
>> +	regval = data->watermark - BM1390_WMI_MIN;
> Trivial: I'd rather we didn't put stuff that clearly isn't the register
> value in a variable called regval.   I'd just go directly to
> 
> 	regval = FIELD_PREP(BM1390_MASK_FIFO_LEN,
> 			    data->watermark - BMI1390_WMI_MIN);
> and avoid that first 'mis'use.

Ok.

> 
>> +	regval = FIELD_PREP(BM1390_MASK_FIFO_LEN, regval);
>> +
>> +	return regmap_update_bits(data->regmap, BM1390_REG_FIFO_CTRL,
>> +				  BM1390_MASK_FIFO_LEN, regval);
>> +}
>> +
>> +static int bm1390_fifo_enable(struct iio_dev *idev)
>> +{
>> +	struct bm1390_data *data = iio_priv(idev);
>> +	int ret;
>> +
>> +	/* We can't do buffered stuff without IRQ as we never get WMI */
>> +	if (data->irq <= 0)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&data->mutex);
>> +	if (data->trigger_enabled) {
>> +		ret = -EBUSY;
>> +		goto unlock_out;
>> +	}
>> +
>> +	/* Update watermark to HW */
>> +	ret = bm1390_fifo_set_wmi(data);
>> +	if (ret)
>> +		goto unlock_out;
>> +
>> +	/* Enable WMI_IRQ */
>> +	ret = regmap_set_bits(data->regmap, BM1390_REG_MODE_CTRL,
>> +			      BM1390_MASK_WMI_EN);
>> +	if (ret)
>> +		goto unlock_out;
>> +
>> +	/* Enable FIFO */
>> +	ret = regmap_set_bits(data->regmap, BM1390_REG_FIFO_CTRL,
>> +			      BM1390_MASK_FIFO_EN);
>> +	if (ret)
>> +		goto unlock_out;
>> +
>> +	data->state = BM1390_STATE_FIFO;
>> +
>> +	data->old_timestamp = iio_get_time_ns(idev);
>> +	ret = bm1390_meas_set(data, BM1390_MEAS_MODE_CONTINUOUS);
>> +
>> +unlock_out:
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return ret;
>> +}
>> +
>> +static int bm1390_fifo_disable(struct iio_dev *idev)
>> +{
>> +	struct bm1390_data *data = iio_priv(idev);
>> +	int ret;
>> +
>> +	msleep(1);
>> +
>> +	mutex_lock(&data->mutex);
>> +	/* Disable FIFO */
>> +	ret = regmap_clear_bits(data->regmap, BM1390_REG_FIFO_CTRL,
>> +				BM1390_MASK_FIFO_EN);
>> +	if (ret)
>> +		goto unlock_out;
>> +
>> +	data->state = BM1390_STATE_SAMPLE;
>> +
>> +	/* Disable WMI_IRQ */
>> +	ret = regmap_clear_bits(data->regmap, BM1390_REG_MODE_CTRL,
>> +				 BM1390_MASK_WMI_EN);
>> +	if (ret)
>> +		goto unlock_out;
>> +
>> +	ret = bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
> 
> I'm sure it works in this order but to my mind it would make more sense
> (and might still work) for fifo_disable() to be reverse of steps
> in fifo_enable().  So I'd expect the mode change first.

I think stopping the masurement should indeed be done first. I'm not 
sure why the order is this. I know I tried suffling the order of 
starting the measurement while trying to figure out the temperature 
measurements for first FIFO sample - but I don't think I touched the 
disabling. So, it has probably been like this from the v1. I'll revise 
this, thanks!

>> +
>> +unlock_out:
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return ret;
>> +}
> 
> 
> 
>> +static int bm1390_probe(struct i2c_client *i2c)
>> +{
>> +	struct bm1390_data *data;
>> +	struct regmap *regmap;
>> +	struct iio_dev *idev;
>> +	struct device *dev;
>> +	unsigned int part_id;
>> +	int ret;
>> +
>> +	dev = &i2c->dev;
>> +
>> +	regmap = devm_regmap_init_i2c(i2c, &bm1390_regmap);
>> +	if (IS_ERR(regmap))
>> +		return dev_err_probe(dev, PTR_ERR(regmap),
>> +				     "Failed to initialize Regmap\n");
>> +
>> +	ret = devm_regulator_get_enable(dev, "vdd");
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to get regulator\n");
>> +
>> +	ret = regmap_read(regmap, BM1390_REG_PART_ID, &part_id);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to access sensor\n");
>> +
>> +	if (part_id != BM1390_ID)
>> +		dev_warn(dev, "unknown device 0x%x\n", part_id);
>> +
>> +	idev = devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!idev)
>> +		return -ENOMEM;
>> +
>> +	data = iio_priv(idev);
>> +	data->regmap = regmap;
>> +	data->dev = dev;
>> +	data->irq = i2c->irq;
>> +	/*
>> +	 * For now we just allow BM1390_WMI_MIN to BM1390_WMI_MAX and
>> +	 * discard every other configuration when triggered mode is not used.
>> +	 */
>> +	data->watermark = BM1390_WMI_MAX;
>> +	mutex_init(&data->mutex);
>> +
>> +	idev->channels = bm1390_channels;
>> +	idev->num_channels = ARRAY_SIZE(bm1390_channels);
>> +	idev->name = "bm1390";
>> +	idev->info = &bm1390_info;
>> +	idev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> 
> Silly question that I might resolve as I read on.
> If we don't have the WMI interrupt, do we have buffer_software support?
> It could be made to work with a timer, but do you do so?

No. I can't say the exact meaning of all these flags is 100% clear to me 
- but I think we only have the INDIO_BUFFER_TRIGGERED if we don't have 
the IRQ. Thanks!

> 
>> +
>> +	ret = bm1390_chip_init(data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "sensor init failed\n");
>> +
>> +	ret = bm1390_setup_buffer(data, idev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* No trigger if we don't have IRQ for data-ready and WMI */
>> +	if (i2c->irq > 0) {
>> +		ret = bm1390_setup_trigger(data, idev, i2c->irq);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	ret = devm_iio_device_register(dev, idev);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret,
>> +				     "Unable to register iio device\n");
>> +
>> +	return 0;
>> +}
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

