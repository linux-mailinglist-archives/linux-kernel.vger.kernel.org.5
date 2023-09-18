Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613DB7A4A41
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241589AbjIRM5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241932AbjIRM4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:56:53 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B886DA8;
        Mon, 18 Sep 2023 05:56:45 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso70908591fa.1;
        Mon, 18 Sep 2023 05:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695041804; x=1695646604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vauD63oMifWRNqIGUqdSIIxaWv/RADOuvDLWm6u+Wt0=;
        b=GW0htTavaiqP9B1dKhhqTXcplFgRWFHmJBVY+6WOoKaY9nV9XsqOnQ7ZHVuek/QXSC
         UD8gWCC2uGhsY6bi2rfJoDEJp0HCVICbso2c+BLVh7AF5r5fZjEle3C9L4V1XyWos5/K
         vkCZiq4SlCITq7rNE5lIqmhX2yEpGhw2gCFVT3uIWb9xmTLnXkaOTNQAFxxXTbP6qWDc
         dhtaYxT36DoRI3lVto76jhdhlH/yoY2jQnZWKd0IgXaR3XFVRFNJzp8aIcoEA4H5tSq9
         SHWzx5MwAcRS+k20XSQmSZdOawKS+D1cHkq7ArMxaKiLYll1Y0uzoVZRNDmE8R5fVkSI
         ycvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695041804; x=1695646604;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vauD63oMifWRNqIGUqdSIIxaWv/RADOuvDLWm6u+Wt0=;
        b=JgC070fs1RHp0lE0nhUrAO8gEw39LvDpBuQvh9M5tNT6ww0X3iOWGVLC14KZ5EOO/7
         TuD9priMzlB1EKOm/OJrJHPz/1KHBBBe3YKYn7flcxG0t5v14dE5ATVmSiqGlUxRCnn8
         cgD8QY1I0KsSLR90YOGxhFeveVhx9PaDJLMvtBe4Vxa4CQ8fM91VoRcv7Tba+nRqFBf8
         BoSvbNKII0fL8kJ91cGWAcsuEzUEOVnNorqywEqyt92WIsaB0gjQ7SYWZVcfvyYN6qDf
         jov/HC/7qJ0Wi89aHRTKBQhMmd43sScd4WdqgZcnF7TDzejUJwm3Rx6k7JDcXzzfOIhR
         Yo7g==
X-Gm-Message-State: AOJu0YwtJ76sSUchZ5VZyFY7rqo86k0QqcHcxBFHKB4lKU3M9ZVsWtXB
        GbhLNti2B/z8KihpFGJq11pXPvmXo08=
X-Google-Smtp-Source: AGHT+IGADmVCrz/D4tJFWpT6T5kJuHdfV4jtjz+DUjV3VQmd8z38i3TFQKvWvZ+HITuA9Kn+exTUmQ==
X-Received: by 2002:a05:651c:11:b0:2bd:1f8d:e89d with SMTP id n17-20020a05651c001100b002bd1f8de89dmr8194749lja.3.1695041803405;
        Mon, 18 Sep 2023 05:56:43 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::3? (dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::3])
        by smtp.gmail.com with ESMTPSA id u25-20020a2ea179000000b002b9e9a8532dsm2083633ljl.138.2023.09.18.05.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 05:56:42 -0700 (PDT)
Message-ID: <a5c19874-32ba-60bf-6e72-9139a2873c7e@gmail.com>
Date:   Mon, 18 Sep 2023 15:56:42 +0300
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
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Benjamin Bara <bbara93@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1694760170.git.mazziesaccount@gmail.com>
 <f378a401cec4fb0b9287b52ab159f00dd77569a6.1694760170.git.mazziesaccount@gmail.com>
 <20230917113518.7c4bb1a0@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 2/3] iio: pressure: Support ROHM BU1390
In-Reply-To: <20230917113518.7c4bb1a0@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/23 13:35, Jonathan Cameron wrote:
> On Fri, 15 Sep 2023 09:56:19 +0300
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
> Hi Matti,
> 
> I think this is coming together nicely. A few comments inline.

Thanks for the review (once again) :)

> 
>>
>> ---
>> Revision history:
>> v1 => v2:
>> - prefer s64 over int64_t
>> - drop not needed handling of 2's complements
>> - plenty of styling changes
>> - drop dead code (write_raw)
>> - fix typos in comments
>> - explain trigger and FIFO usage in commit message
>> - do better job at cheking the return values
>> - ensure there's no race when checking if triggered buffer is used
>>    before enabling the FIFO
>> - print warning if register read fails at IRQ handler
>> - drop unnecessary warning if IRQ is not given
>> - explain why we prefer asynchronous probing
>> ---
> 
>> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
>> new file mode 100644
>> index 000000000000..d3cc229d1688
>> --- /dev/null
>> +++ b/drivers/iio/pressure/rohm-bm1390.c
>> @@ -0,0 +1,899 @@
> 
> ...
> 
>> +
>> +static const unsigned long bm1390_scan_masks[] = {
>> +	BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP), 0
> Why?  Doesn't look hard to support just one or the other?
> Normally we only do this sort of limitation when there is a heavily
> optimized read routine for a set of channels and it is better
> to grab them all and throw away the ones we don't care about.
> That doesn't seem to be true here. So if the fifo grabbed both
> temp and pressure it would makes sense here, but doesn't seem
> like it does.

I have a feeling I have misunderstood how this mask works. I have 
assumed all the channels with corresponding mask bit _can_ be enabled 
simultaneously, but I have not understood they _must_ all be enabled. I 
think I must go back studying this, but if all channels really _must_ be 
enabled, then you are correct. It actually makes a lot of sense to 
support the pressure values alone, as, according to the data-sheet, the 
HW is doing a "MEMS temperature compensation" to the pressure values. 
So, my assuimption is the temperature data may not be required to be 
captured.

This also means I should revise the scan masks for the BU27008, BU27010 
and BU27034 light sensors as I don't think all the users want all the 
channels enabled. I wonder how I have not noticed any problems when I 
tested those things - did I really always enable all the channels...? @_@

Anyways, Thanks.

>> +};
> 
>> +static int bm1390_read_temp(struct bm1390_data *data, int *temp)
>> +{
>> +	__be16 temp_raw;
>> +	int ret;
>> +
>> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp_raw,
>> +			       sizeof(temp_raw));
>> +	if (ret)
>> +		return ret;
>> +
>> +	*temp = be16_to_cpu(temp_raw);
>> +
>> +	return 0;
>> +}
> 
>> +static int bm1390_read_raw(struct iio_dev *idev,
>> +			   struct iio_chan_spec const *chan,
>> +			   int *val, int *val2, long mask)
>> +{
>> +	struct bm1390_data *data = iio_priv(idev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SCALE:
>> +		if (chan->type == IIO_TEMP) {
>> +			*val = 31;
>> +			*val2 = 250000;
>> +
>> +			return IIO_VAL_INT_PLUS_MICRO;
>> +		} else if (chan->type == IIO_PRESSURE) {
>> +			*val = 0;
>> +			/*
>> +			 * pressure in hPa is register value divided by 2048.
>> +			 * This means kPa is 1/20480 times the register value,
>> +			 * which equals to 48828.125 * 10 ^ -9
>> +			 * This is 48828.125 nano kPa.
>> +			 *
>> +			 * When we scale this using IIO_VAL_INT_PLUS_NANO we
>> +			 * get 48828 - which means we lose some accuracy. Well,
>> +			 * let's try to live with that.
>> +			 */
>> +			*val2 = 48828;
>> +
>> +			return IIO_VAL_INT_PLUS_NANO;
> 
> IIO_VAL_FRACTIONAL?  Mind you I'm not sure that will result in enough precision
> either here.   For in kernel use it will have full precision though as will be
> kept as a fraction.  I guess question of whether it is worse than what you have
> here.  There hasn't been much demand for IIO_VAL_INTO_PLUS_PICO, but if we have
> to look at that we can - with proviso that existing userspace software won't know
> anything about it.

I must take a look at the IIO_VAL_FRACTIONAL. I think either it or the 
NANO at this point. I have no understanding what is the precision that 
is enough. Hmm.. Would adding the PICO really require a change in 
user-space or could we hide it in-kernel when formatting the value we 
emit via sysfs?

> 
>> +		}
>> +
>> +		return -EINVAL;
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = iio_device_claim_direct_mode(idev);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = bm1390_read_data(data, chan, val, val2);
>> +		iio_device_release_direct_mode(idev);
>> +		if (ret)
>> +			return ret;
>> +
>> +		return IIO_VAL_INT;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int __bm1390_fifo_flush(struct iio_dev *idev, unsigned int samples,
>> +			       bool irq)
>> +{
>> +	struct bm1390_data *data = iio_priv(idev);
>> +	struct bm1390_data_buf buffer;
>> +	int smp_lvl, ret, i, warn;
>> +	u64 sample_period;
>> +	__be16 temp = 0;
>> +
>> +	/*
>> +	 * If the IC is accessed during FIFO read samples can be dropped.
>> +	 * Prevent access until FIFO_LVL is read
> Comment doesn't seem to have much to do with code that follows it?
> Maybe needs more detail given you clearly access the IC before reading
> FIFO_LVL.

I see now the comment is vague. I think I may originally had the mutex 
locked in this function and the comment has been preceding the lock.

Anyways, how the HW operates is that reading the first pressure value 
from the FIFO makes the sensor to 'start a FIFO access sequence'. So, 
after we read the first pressure value from the FIFO, we must not read 
any other register untill we have read all the pressure values and 
closed the 'FIFO access sequence' by reading the FIFO_LVL. If we do we 
may lose samples. I'll see how to explain this better.

> 
>> +	 */
>> +	if (test_bit(BM1390_CHAN_TEMP, idev->active_scan_mask)) {
>> +		ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp,
>> +				       sizeof(temp));
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	ret = regmap_read(data->regmap, BM1390_REG_FIFO_LVL, &smp_lvl);
>> +	if (ret)
>> +		return ret;
>> +
>> +	smp_lvl = FIELD_GET(BM1390_MASK_FIFO_LVL, smp_lvl);
>> +	if (!smp_lvl)
>> +		return 0;
>> +
>> +	if (smp_lvl > 4) {
>> +		/*
>> +		 * The fifo holds maximum of 4 samples so valid values
>> +		 * should be 0, 1, 2, 3, 4 - rest are probably bit errors
>> +		 * in I2C line. Don't overflow if this happens.
>> +		 */
>> +		dev_err(data->dev, "bad FIFO level %d\n", smp_lvl);
>> +		smp_lvl = 4;
>> +	}
>> +
>> +	sample_period = data->timestamp - data->old_timestamp;
>> +	do_div(sample_period, smp_lvl);
>> +
>> +	if (samples && smp_lvl > samples)
>> +		smp_lvl = samples;
>> +
>> +	for (i = 0; i < smp_lvl; i++) {
>> +		ret = bm1390_pressure_read(data, &buffer.pressure);
>> +		if (ret)
>> +			break;
>> +
>> +		buffer.temp = temp;
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
>> +
>> +		iio_push_to_buffers_with_timestamp(idev, &buffer,
>> +						   data->old_timestamp);
>> +	}
>> +	/* Reading the FIFO_LVL closes the FIFO access sequence */
>> +	warn = regmap_read(data->regmap, BM1390_REG_FIFO_LVL, &smp_lvl);
>> +	if (warn)
>> +		dev_warn(data->dev, "Closing FIFO sequence failed\n");
>> +
>> +	if (!ret)
>> +		return ret;
>> +
>> +	return smp_lvl;
>> +}
>> +
>> +static int bm1390_fifo_flush(struct iio_dev *idev, unsigned int samples)
>> +{
>> +	struct bm1390_data *data = iio_priv(idev);
>> +	int ret;
>> +
>> +	/*
>> +	 * If fifo_flush is being called from IRQ handler we know the stored timestamp
>> +	 * is fairly accurate for the last stored sample. If we are
> 
> Odd line wrapping.  Tidy this up to go near but not over 80 chars

Thanks!

> 
>> +	 * called as a result of a read operation from userspace and hence
>> +	 * before the watermark interrupt was triggered, take a timestamp
>> +	 * now. We can fall anywhere in between two samples so the error in this
>> +	 * case is at most one sample period.
>> +	 * We need to have the IRQ disabled or we risk of messing-up
>> +	 * the timestamps. If we are ran from IRQ, then the
>> +	 * IRQF_ONESHOT has us covered - but if we are ran by the
>> +	 * user-space read we need to disable the IRQ to be on a safe
>> +	 * side. We do this usng synchronous disable so that if the
>> +	 * IRQ thread is being ran on other CPU we wait for it to be
>> +	 * finished.
> 
> That irq disable is potentially expensive.
> Why not just pass the current timestamp into the __bm1390_fifo_flush >
> The locks should prevent other races I think..

Gah. I hate you Jonathan ;) (Not really!)

Actually, thank you (as always) for pointing this out. I don't instantly 
see why it wouldn't work, but going throught the IRQ races is never 
trivial (for me). It's work I've learned not to do at afternoon as my 
brains work better at the morning :) So, I will still go through this as 
a first thing tomorrow when I start my work day...


>> +	 */
>> +	disable_irq(data->irq);
>> +	data->timestamp = iio_get_time_ns(idev);
>> +
>> +	mutex_lock(&data->mutex);
> 
> scoped_guard() will work nicely here

Please, see my reply to Andy's comment. I'll paste it to this message 
below where you're also suggesting using these new 'autofreed when out 
of scope' thingies.

> 
>> +	ret = __bm1390_fifo_flush(idev, samples, false);
>> +	mutex_unlock(&data->mutex);
>> +
>> +	enable_irq(data->irq);
>> +
>> +	return ret;
>> +}
> 
>> +
>> +static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *idev = pf->indio_dev;
>> +	struct bm1390_data *data = iio_priv(idev);
>> +	int ret, status;
>> +
>> +	/* DRDY is acked by reading status reg */
>> +	ret = regmap_read(data->regmap, BM1390_REG_STATUS, &status);
>> +	if (ret || !status)
>> +		return IRQ_NONE;
>> +
>> +	dev_dbg(data->dev, "DRDY trig status 0x%x\n", status);
>> +
>> +	ret = bm1390_pressure_read(data, &data->buf.pressure);
>> +	if (ret) {
>> +		dev_warn(data->dev, "sample read failed %d\n", ret);
>> +		return IRQ_NONE;
>> +	}
>> +
>> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI,
>> +			       &data->buf.temp, BM1390_TEMP_SIZE);
>> +	if (ret)
>> +		dev_warn(data->dev, "temp read failed %d\n", ret);
> 
> I don't want to see garbage (or a zero :) pushed into the buffer. So
> if you get a read fail, don't push to buffers.

Ok, makes sense.

> 
>> +
>> +	iio_push_to_buffers_with_timestamp(idev, &data->buf, data->timestamp);
>> +	iio_trigger_notify_done(idev->trig);
>> +
>> +	return IRQ_HANDLED;
>> +}
> 
> 
>> +static int bm1390_trigger_set_state(struct iio_trigger *trig,
>> +				    bool state)
>> +{
>> +	struct bm1390_data *data = iio_trigger_get_drvdata(trig);
>> +	int ret = 0;
>> +
>> +	mutex_lock(&data->mutex);
> 
> Nice case for the new guard() calls which do automatic release of locks
> on exit from a function - we also have scoped_guard for stuff inside
> functions.
> 
> Here it will let you use direct returns throughout as lock will always
> be released for you.
> 

Andy did also suggest using them to me. This is what I wrote as a reply 
to him - I'll copy it as a rationale why I'd rather did the good old 
goto-unwinding here at least for now...


 >> Wouldn't you like to start using cleanup.h?
 >
 > The new macro "thingee" for C++ destructor like constructs?

I was talking about these: guard() / scoped_guard().

 > TBH, I am not really in a rush with it for two reasons.
 > 1) The syntax looks very alien to me. I would like to get some time 
to get
 > used to it before voluntarily ending up maintaining a code using it. (I
 > don't like practicing things upstream as practicing tends to include 
making
 > more errors).
 >
 > 2. Related to 1). I am not (yet) convinced incorporating changes in stuff
 > using these cleanups is easy. I'm a bit reserved and would like to 
see how
 > things play out.
 >
 > 3. I expect I will get a few requests to backport the code to some older
 > kernels used by some big customers. (I've been doing plenty of extra work
 > when backporting my kernel improvements like regmap_irq stuff, linear
 > ranges, regulator pickable ranges, gts-helpers to customer kernels to 
get my
 > drivers working - or working around the lack of thiose features. I 
have been
 > willing to pay this prize to get those helpers upstream for everyone 
to use.
 > The cleanup.h however is there so it does not _need_ new users. I don't
 > think _all_ existing drivers will be converted to use it so one more 
should
 > probably not hurt. I think that in a year at least some customers will be
 > using kernel containing the cleanup.h - so by latest then it is time 
for me
 > to jump on that train. I hope I am used to reading those macros by then).

OK.


>> +
>> +	if (data->trigger_enabled == state)
>> +		goto unlock_out;
>> +
>> +	if (data->state == BM1390_STATE_FIFO) {
>> +		dev_warn(data->dev, "Can't set trigger when FIFO enabled\n");
>> +		ret = -EBUSY;
>> +		goto unlock_out;
>> +	}
>> +
>> +	data->trigger_enabled = state;
>> +
>> +	if (state) {
>> +		ret = bm1390_meas_set(data, BM1390_MEAS_MODE_CONTINUOUS);
>> +		if (ret)
>> +			goto unlock_out;
>> +	} else {
>> +		int dummy;
>> +
>> +		ret = bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
>> +		if (ret)
>> +			goto unlock_out;
>> +
>> +		/*
>> +		 * We need to read the status register in order to ACK the
>> +		 * data-ready which may have been generated just before we
>> +		 * disabled the measurement.
>> +		 */
>> +		ret = regmap_read(data->regmap, BM1390_REG_STATUS, &dummy);
>> +		if (ret)
>> +			dev_warn(data->dev, "status read failed\n");
>> +	}
>> +
>> +	ret = bm1390_set_drdy_irq(data, state);
>> +
>> +unlock_out:
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct iio_trigger_ops bm1390_trigger_ops = {
>> +	.set_trigger_state = bm1390_trigger_set_state,
>> +};
>> +
>> +static int bm1390_setup_trigger(struct bm1390_data *data, struct iio_dev *idev,
>> +				int irq)
>> +{
>> +	struct iio_trigger *itrig;
>> +	char *name;
>> +	int ret;
>> +
>> +	/* Nothing to do if we don't have IRQ for data-ready and WMI */
>> +	if (irq < 0)
>> +		return 0;
> 
> Matter of taste, so I won't argue strongly but I'd prefer to see this
> check at the call site, not down in the function.  Makes the flow more
> obvious and we don't have usual reasons for doing it this way
> (either too much indenting at the call site, or lots of similar calls).

I think I can live with what you suggest here :)
> 
>> +
>> +	ret = devm_iio_triggered_buffer_setup(data->dev, idev,
>> +					      &iio_pollfunc_store_time,
>> +					      &bm1390_trigger_handler,
>> +					      &bm1390_buffer_ops);
> 
> Why doesn't this still apply even if we don't have an irq for this device?
> Can use a sysfs or hrtimer trigger or an irq on another device.
> 

Another good question. I know I wrote the code only thinking that when 
the trigger is used, it will be the data-ready from the device. I think 
I even used the trigger validation function which requires us to use the 
device's own trigger.

Now, whether it would make sense to allow other triggers, and whether 
the trigger handler has any data-ready specific handling here is 
something I need to revise. What does slightly bug me with allowing 
other triggers is that as far as I remmeber the BM1390 had no way to 
indicate that a single sample was actually ready. So, when we use any 
other trigger it may be we don't have a valid sample to read. (The 
read_raw uses a delay which should be long enough to guarantee a sample).

>> +
>> +	if (ret)
>> +		return dev_err_probe(data->dev, ret,
>> +				     "iio_triggered_buffer_setup FAIL\n");
>> +
>> +	itrig = devm_iio_trigger_alloc(data->dev, "%sdata-rdy-dev%d", idev->name,
>> +					    iio_device_id(idev));
>> +	if (!itrig)
>> +		return -ENOMEM;
>> +
>> +	data->trig = itrig;
>> +	idev->available_scan_masks = bm1390_scan_masks;
> 
> Mixing trigger and buffer stuff in here. I'd rather see them
> separate - so move this up to where you set the buffer up.

Thanks for pointing this out. In my mind the trigger and buffer went 
hand to hand with this device. Now, after your previous comment, I need 
to rethink if they really can be sepated. Anyways, moving this makes sense.

> 
>> +
>> +	itrig->ops = &bm1390_trigger_ops;
>> +	iio_trigger_set_drvdata(itrig, data);
>> +
>> +	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-bm1390",
>> +			      dev_name(data->dev));
> 
> Check the allocation.  Definitely don't want name not defined here.

The request_threaded_irq will use the dev_name() if NULL is passed to 
it. I think it should be fine - but I think this is not worth fighting 
if you strongly prefer the check :)
> 
>> +
>> +	ret = devm_request_threaded_irq(data->dev, irq, bm1390_irq_handler,
>> +					&bm1390_irq_thread_handler,
>> +					IRQF_ONESHOT, name, idev);
>> +	if (ret)
>> +		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
>> +
>> +
>> +	ret = devm_iio_trigger_register(data->dev, itrig);
>> +	if (ret)
>> +		return dev_err_probe(data->dev, ret,
>> +				     "Trigger registration failed\n");
>> +
>> +	return 0;
>> +}
>> +
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
> 
> Given it's unconditionally set and no line length issue, I'd prefer this
> done on the local variable definitions block above.

I can change this if you feel strong about it. Still, I personally find 
assignments in declarations less clear and so I tend to avoid them. 
(There's a few exceptions like repeated private data pointer getting).

> 
> 	struct device *dev = &i2c->dev;
>> +
>> +	regmap = devm_regmap_init_i2c(i2c, &bm1390_regmap);
>> +	if (IS_ERR(regmap))
>> +		return dev_err_probe(dev, PTR_ERR(regmap),
>> +				     "Failed to initialize Regmap\n");
>> +
>> +	idev = devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!idev)
>> +		return -ENOMEM;
>> +
>> +	ret = devm_regulator_get_enable(dev, "vdd");
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to get regulator\n");
>> +
>> +	data = iio_priv(idev);
> Why this ordering?  I'd expect this either:
> 1) Immediately after it becomes available so above the regulator enable,
> or
> 2) immediately before it is used, so a few lines down above data->regmap...
> Here it just looks a bit lost :)
> 

I agree. I may have just accidentally added the regulator stuff in 
between device alloc and getting the 'data'-pointer.

>> +
>> +	ret = regmap_read(regmap, BM1390_REG_PART_ID, &part_id);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to access sensor\n");
>> +
>> +	if (part_id != BM1390_ID)
>> +		dev_warn(dev, "unknown device 0x%x\n", part_id);
>> +
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
>> +
>> +	ret = bm1390_chip_init(data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "sensor init failed\n");
>> +
>> +	ret = bm1390_setup_trigger(data, idev, i2c->irq);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = devm_iio_device_register(dev, idev);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret,
>> +				     "Unable to register iio device\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id bm1390_of_match[] = {
>> +	{ .compatible = "rohm,bm1390glv-z" },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, bm1390_of_match);
>> +
>> +static const struct i2c_device_id bm1390_id[] = {
>> +	{ "bm1390glv-z", },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(i2c, bm1390_id);
>> +
>> +static struct i2c_driver bm1390_driver = {
>> +	.driver = {
>> +		.name = "bm1390",
>> +		.of_match_table = bm1390_of_match,
>> +		/*
>> +		 * The probe issues a few msleep()s - which can result
>> +		 * measurable delays. Additionally, enabling the VDD may cause
>> +		 * some (slight) delay depending on the ramp-rate of the
>> +		 * regulator. Delays are propably magnitude of tens of
>> +		 * milliseconds - but async probing should not be a problem so
>> +		 * we should have nothing to lose here. Let's revise this if
>> +		 * async probing proves to cause problems here.
>> +		 */
> Perhaps we can summarise this with just the sleep info? - don't need to
> predict the future :)
> 		/*
> 		 * Probing explicitly requires a few millisecond of sleep.
> 	 	 * Enabling the VDD regulator may include ramp up rates.
> 		 */

I really seem to be babbling... :) Thanks for the distilled version :)

>> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> 

Much appreciated feedback!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

