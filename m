Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B444879BB60
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351776AbjIKVnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbjIKKkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:40:55 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61D7CDC;
        Mon, 11 Sep 2023 03:40:48 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bf924f39f1so10068931fa.2;
        Mon, 11 Sep 2023 03:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694428847; x=1695033647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgUtnyEgHGe6TrYfebRP1GaXOdgSdkBvY6j6Gfz0fp4=;
        b=PX9lFLh9YLY7x9WOFgu04na3FbZ7IqIVHsTZkCY+Ov+vs60+Cuk1ZIS1Mctw6sXZ6X
         +9XvVWDWA+IllzVjhCun81W8BPtNso0ad3VmZARQZi0BxglazUJehl1q7OhDIVZh7OZ7
         ZY0IN05/5Uz3yOiLh1n54YxnwRx3109N9Vt/j8XXy2rn/xe4xLR89WFYShBYf5KmvCem
         mBe335GxY1XLguSvXZtXBwXvnffFiOgsTtSclUThnjQdcNfl89pPxKhkX1315tSVgiB+
         OofBpxgupRMoEordvODCSwr2gzla1XJyerxfeXXK4+//+9nyqigbjXMm6MMLpOukVn7R
         qShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694428847; x=1695033647;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgUtnyEgHGe6TrYfebRP1GaXOdgSdkBvY6j6Gfz0fp4=;
        b=B4Gt87yYkxnBdohN1X/5TFiFbrbxMzxlSXYg+NHKd+yDtMpm4Ped4s972FPwACuAR+
         hoD1xlne7rx5PMJS+noNcSP6NdiN8O2GugowQgLuTNaqbo3XaAATDbaD4tXqPdhI57D9
         akjqdx4DSRCqWnVkC1bpULXZu+vsNF1O01pb0iDkwEidVGDM1tTls+u4kgFGyZXpyxRD
         fFiO++kIh4v0NVtFD+J/USHZc0bjLpuj9cheDGPEMOmV+ZTBg8X4xLIbH55/xq+RbTZU
         QKJ7TGgpHWj8XsyZofH9VPj3IIIqzbTbblcVxmIZTL70evvIzuTlbHxyFFSpi1Swz5d2
         PSAQ==
X-Gm-Message-State: AOJu0YzWudlMS1y12YzQ1Av7jM9gMKustQFdr+MAOQzdAZbAzthrSbju
        cHVvl6Lr4MHUkwvuSbSUSQhzf46kUTQ=
X-Google-Smtp-Source: AGHT+IF2WsHDSSvTS8iExDU4v5dzI2OMIDDoablksrV9sYcJ63UKiIcZ+6MSgSmwtpivMn8tlfFPng==
X-Received: by 2002:a05:651c:1213:b0:2b6:e618:b593 with SMTP id i19-20020a05651c121300b002b6e618b593mr7318766lja.31.1694428846533;
        Mon, 11 Sep 2023 03:40:46 -0700 (PDT)
Received: from [172.16.183.71] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id v20-20020a2e9f54000000b002b724063010sm1501203ljk.47.2023.09.11.03.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 03:40:45 -0700 (PDT)
Message-ID: <fc509b73-35df-89e0-5cc0-4bf852d6da7d@gmail.com>
Date:   Mon, 11 Sep 2023 13:40:44 +0300
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
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1694001462.git.mazziesaccount@gmail.com>
 <08f7085ba1af2fae21c942f6c20a94c237df53ba.1694001462.git.mazziesaccount@gmail.com>
 <20230910142225.5863a850@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 2/3] iio: pressure: Support ROHM BU1390
In-Reply-To: <20230910142225.5863a850@jic23-huawei>
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

On 9/10/23 16:22, Jonathan Cameron wrote:
> On Wed, 6 Sep 2023 15:37:48 +0300
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
> 
> *sigh*  We all love fuzzily described filters...
> 
>>
>> The FIFO measurement mode is only measuring the pressure and not the
>> temperature. The driver measures temperature when FIFO is flushed and
>> simply uses the same measured temperature value to all reported
>> temperatures. This should not be a problem when temperature is not
>> changing very rapidly (several degrees C / second) but allows users to
>> get the temperature measurements from sensor without any additional logic.
> 
> IIRC this is a bit different from what we've typically done in the past
> where we just take the view that a slow moving thing like temperature
> can be read from sysfs or that enabling it disables the watermark.
> 
> However, what you have seems like valid use of the ABI to me so I'm
> fine with this approach if it makes sense for your expected users
> (which you get to guess at ;)
> 
> Given there are multiple ways of handling combination of FIFO hardware
> and triggers, it's good to add a little bit of info on that in this
> patch description (I misunderstood what you were doing initially)
> 
My idea is that the sensor can either be used in two ways,

1. With trigger (data-ready IRQ). In this case the FIFO is not used as 
we get data ready for each collected sample. Instead, for each 
data-ready IRQ we read the sample from sensor and push it to the IIO buffer.

2. With hardware FIFO and watermark IRQ. In this case the data-ready is 
not used but we enable watermark IRQ. At each watermark IRQ we go and 
read all samples in FIFO and push them to the IIO buffer.

Do you mean the commit message should explain this?

>> diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
>> new file mode 100644
>> index 000000000000..2d51a99a58fc
>> --- /dev/null
>> +++ b/drivers/iio/pressure/rohm-bm1390.c
>> @@ -0,0 +1,944 @@
> 
> ...
> 
>> +
>> +enum {
>> +	BM1390_CHAN_PRESSURE,
>> +	BM1390_CHAN_TEMP,
>> +};
> 
>> +static int bm1390_read_data(struct bm1390_data *data,
>> +			struct iio_chan_spec const *chan, int *val, int *val2)
>> +{
>> +	int ret;
>> +
>> +	*val2 = 0;
> 
> Why?  No need to pass val2 in or zero it if going to return IIO_VAL_INT to the
> IIO core.  It's never used.

Ok

> 
>> +
>> +	mutex_lock(&data->mutex);
>> +	/*
>> +	 * We use 'continuous mode' even for raw read because according to the
>> +	 * data-sheet an one-shot mode can't be used with IIR filter
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
>> +	bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
>> +unlock_out:
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return ret;
>> +}
> 
>> +
>> +static int __bm1390_fifo_flush(struct iio_dev *idev, unsigned int samples,
>> +			       bool irq)
>> +{
>> +	/* The fifo holds maximum of 4 samples */
> 
> Whilst useful info - why have comment here?

It really looks like it's missplaced. I may have suffled some code to 
other place without moving the comment. I'll drop or move it - thanks!

> 
>> +	struct bm1390_data *data = iio_priv(idev);
>> +	struct bm1390_data_buf buffer;
>> +	int smp_lvl, ret, i;
>> +	u64 sample_period;
>> +	__be16 temp = 0;
>> +
>> +	/*
>> +	 * If the IC is accessed during FIFO read samples can be dropped.
>> +	 * Prevent access until FIFO_LVL is read
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
>> +
>> +	if (smp_lvl > 4) {
>> +		/*
>> +		 * Valid values should be 0, 1, 2, 3, 4 - rest are probably
>> +		 * bit errors in I2C line. Don't overflow if this happens.
>> +		 */
>> +		dev_err(data->dev, "bad FIFO level %d\n", smp_lvl);
>> +		smp_lvl = 4;
>> +	}
>> +
>> +	if (!smp_lvl)
>> +		return ret;
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
>> +	regmap_read(data->regmap, BM1390_REG_FIFO_LVL, &smp_lvl);
> 
> ret =

I didn't want to determine success of getting the data by success of 
this read. Instead, I wanted to ret to contain the success of reading 
the pressure in the for-loop. We might spill out a warning if this reads 
fails though.

> 
>> +
>> +	if (!ret)
>> +		return ret;
>> +
>> +	return smp_lvl;
>> +}
> 
> ...
> 
>> +static int bm1390_write_raw(struct iio_dev *idev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int val, int val2, long mask)
>> +{
>> +	int ret;
>> +
>> +	ret = iio_device_claim_direct_mode(idev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	switch (mask) {
>> +	default:
>> +		ret = -EINVAL;
> 
> ?

Yeah :) This was forgotten when I dropped the OVERSAMPLING setting. Need 
to drop thw whole raw_write.

> 
>> +	}
>> +	iio_device_release_direct_mode(idev);
>> +
>> +	return ret;
>> +}
>> +
>> +static int bm1390_set_watermark(struct iio_dev *idev, unsigned int val)
>> +{
>> +	struct bm1390_data *data = iio_priv(idev);
>> +
>> +	if (val < BM1390_WMI_MIN || val > BM1390_WMI_MAX)
>> +		return -EINVAL;
> 
> It's definitely possible to argue a watermark of 1 is also supported - just
> run in bypass mode with data ready interrupt.  Not sure we care enough to
> make that supported in this interface though.  Driver doesn't need to
> support everything possible.

True. I'm not sure this is worth the complexity though. It'd mean we had 
to support DRDY when in FIFO mode - iff watermark is 1. Currently we 
don't need to bother the DRDY or FIFO disabling when in FIFO mode.

>> +
>> +	mutex_lock(&data->mutex);
>> +	data->watermark = val;
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct iio_info bm1390_info = {
>> +	.read_raw = &bm1390_read_raw,
>> +	.write_raw = &bm1390_write_raw,
>> +	.validate_trigger = iio_validate_own_trigger,
>> +	.hwfifo_set_watermark = bm1390_set_watermark,
>> +	.hwfifo_flush_to_buffer = bm1390_fifo_flush,
>> +};
>> +
>> +static int bm1390_chip_init(struct bm1390_data *data)
>> +{
>> +	int ret;
>> +
>> +	ret = regmap_write_bits(data->regmap, BM1390_REG_POWER,
>> +				BM1390_MASK_POWER, BM1390_POWER_ON);
>> +	if (ret)
>> +		return ret;
>> +
>> +	msleep(1);
>> +
>> +	ret = regmap_write_bits(data->regmap, BM1390_REG_RESET,
>> +				BM1390_MASK_RESET, BM1390_RESET);
>> +	if (ret)
>> +		return ret;
>> +
>> +	msleep(1);
>> +
>> +	ret = regmap_write_bits(data->regmap, BM1390_REG_RESET,
>> +				BM1390_MASK_RESET, BM1390_RESET_RELEASE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	msleep(1);
>> +
>> +	ret = regmap_reinit_cache(data->regmap, &bm1390_regmap);
>> +	if (ret) {
>> +		dev_err(data->dev, "Failed to reinit reg cache\n");
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * Default to use IIR filter in "middle" mode. Also the AVE_NUM must
>> +	 * be fixed when IIR is in use
>> +	 */
>> +	ret = regmap_update_bits(data->regmap, BM1390_REG_MODE_CTRL,
>> +				 BM1390_MASK_AVE_NUM, BM1390_IIR_AVE_NUM);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_update_bits(data->regmap, BM1390_REG_FIFO_CTRL,
>> +				 BM1390_MASK_IIR_MODE, BM1390_IIR_MODE_MID);
>> +
>> +	return ret;
> 
> return regmap...

Ok.

> 
>> +}
>> +
>> +static int bm1390_fifo_set_wmi(struct bm1390_data *data)
>> +{
>> +	u8 regval;
>> +
>> +	regval = data->watermark - BM1390_WMI_MIN;
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
>> +	mutex_lock(&data->mutex);
>> +
>> +	/* Update watermark to HW */
>> +	ret = bm1390_fifo_set_wmi(data);
>> +	if (ret)
>> +		goto unlock_out;
>> +
>> +	/* Enable WMI_IRQ */
>> +	ret = regmap_set_bits(data->regmap, BM1390_REG_MODE_CTRL,
>> +				 BM1390_MASK_WMI_EN);
> 
> check ret.
> 

Yes.

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
>> +
>> +unlock_out:
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return ret;
>> +}
>> +
>> +static int bm1390_buffer_postenable(struct iio_dev *idev)
>> +{
>> +	/*
>> +	 * If we use data-ready trigger, then the IRQ masks should be handled by
>> +	 * trigger enable and the hardware buffer is not used but we just update
>> +	 * results to the IIO fifo when data-ready triggers.
> 
> FIFO
> 

Ok

>> +	 */
>> +	if (iio_device_get_current_mode(idev) == INDIO_BUFFER_TRIGGERED)
>> +		return 0;
>> +
>> +	return bm1390_fifo_enable(idev);
>> +}
>> +
>> +static int bm1390_buffer_predisable(struct iio_dev *idev)
>> +{
>> +	if (iio_device_get_current_mode(idev) == INDIO_BUFFER_TRIGGERED)
>> +		return 0;
>> +
>> +	return bm1390_fifo_disable(idev);
>> +}
>> +
>> +static const struct iio_buffer_setup_ops bm1390_buffer_ops = {
>> +	.postenable = bm1390_buffer_postenable,
>> +	.predisable = bm1390_buffer_predisable,
>> +};
>> +
>> +static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *idev = pf->indio_dev;
>> +	struct bm1390_data *data = iio_priv(idev);
>> +	int ret, dummy;
>> +
>> +	/* DRDY is acked by reading status reg */
>> +	ret = regmap_read(data->regmap, BM1390_REG_STATUS,
>> +			  &dummy);
> 
> I'd expect 'dummy' to be irrelevant data.  Perhaps give it
> a better name if you are going to use the value like this.
> 

Ok.

>> +	if (ret || !dummy)
>> +		return IRQ_NONE;
>> +
>> +	dev_dbg(data->dev, "DRDY trig status 0x%x\n", dummy);
>> +
>> +	ret = bm1390_pressure_read(data, &data->buf.pressure);
>> +	if (ret) {
>> +		dev_warn(data->dev, "sample read failed %d\n", ret);
>> +		return IRQ_NONE;
> As below.  Still our interrupt even if we couldn't read the data
> As such, IRQ_HANDLED; is current reutrn value.

I've learned a hard way that it can be a very good idea to return 
IRQ_NONE if HW access fails in IRQ handling. If we don't (can't) ack the 
IRQ line, we'll be sitting in IRQ handler. The feature which disables 
local IRQ after <N> unhandled IRQs has made a huge difference when I've 
received bug reports from people. Being able to access the device when 
the 'wild' IRQ gets disabled and being able to retrieve the logs is 
priceless. Also, seeing the 'nobody cares, disabling IRQ' in the log is 
a really valuable hint :)

>> +	}
>> +
>> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI,
>> +			       &data->buf.temp, BM1390_TEMP_SIZE);
>> +
> ret not checked.

Ok.

>> +	iio_push_to_buffers_with_timestamp(idev, &data->buf, data->timestamp);
>> +	iio_trigger_notify_done(idev->trig);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +/* Get timestamps and wake the thread if we need to read data */
>> +static irqreturn_t bm1390_irq_handler(int irq, void *private)
>> +{
>> +	struct iio_dev *idev = private;
>> +	struct bm1390_data *data = iio_priv(idev);
>> +
>> +	data->timestamp = iio_get_time_ns(idev);
>> +
>> +	if (data->state == BM1390_STATE_FIFO || data->trigger_enabled)
>> +		return IRQ_WAKE_THREAD;
>> +
>> +	return IRQ_NONE;
>> +}
>> +
>> +static irqreturn_t bm1390_irq_thread_handler(int irq, void *private)
>> +{
>> +	struct iio_dev *idev = private;
>> +	struct bm1390_data *data = iio_priv(idev);
>> +	int ret = IRQ_NONE;
>> +
>> +	mutex_lock(&data->mutex);
>> +
>> +	if (data->trigger_enabled) {
>> +		iio_trigger_poll_nested(data->trig);
>> +		ret = IRQ_HANDLED;
>> +	}
>> +
>> +	if (data->state == BM1390_STATE_FIFO) {
> 
> Can this and trigger_enabled be true?

No, it shouldn't be possible.

> 
>> +		int ok;
>> +
>> +		ok = __bm1390_fifo_flush(idev, BM1390_TEMP_SIZE, true);
>> +		if (ok > 0)
>> +			ret = IRQ_HANDLED;
> 
> An error should not result in IRQ_NONE.  At most we tend to print
> an error message and return IRQ_HANDLED anyway to avoid the interrupt
> being treated as spurious.

The same story here. If we can't read the samples from the FIFO, we'll 
end up having new watermark IRQ immediately when the oneshot thread 
exits. Returning the IRQ none allows genirq core to disable the host 
side of the IRQ, allowing us to see the 'nobody cared' and go get the 
logs even with single core system.

> 
>> +	}
>> +
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return ret;
>> +}
>> +
>> +static int bm1390_set_drdy_irq(struct bm1390_data *data, bool en)
>> +{
>> +	if (en)
>> +		return regmap_set_bits(data->regmap, BM1390_REG_MODE_CTRL,
>> +				       BM1390_MASK_DRDY_EN);
>> +	return regmap_clear_bits(data->regmap, BM1390_REG_MODE_CTRL,
>> +				 BM1390_MASK_DRDY_EN);
>> +}
>> +
>> +static int bm1390_trigger_set_state(struct iio_trigger *trig,
>> +				    bool state)
>> +{
>> +	struct bm1390_data *data = iio_trigger_get_drvdata(trig);
>> +	int ret = 0;
>> +
>> +	mutex_lock(&data->mutex);
>> +
>> +	if (data->trigger_enabled == state)
>> +		goto unlock_out;
>> +
>> +	if (data->state == BM1390_STATE_FIFO) {
>> +		dev_warn(data->dev, "Can't set trigger when FIFO enabled\n");
> 
> Why not?  Spec reference ideally.  I haven't gotten my head around this
> but I'd expect an attempt to set the trigger state to indicate that we don't
> want to use the fifo and as such it should be disabled in this path.

This may be my limited understanding of how IIO is typically used. To me 
it sounded a bit strange that someone setting trigger could abort an 
ongoing buffered measurement. I would have expected the buffering to be 
explicitly disabled by user before allowing the trigger to be used. 
Especially because the trigger and FIFO are pretty much exclusive 
features (as with data-ready trigger you'll get each individual sample 
read). My assumption was that an attempt to enable data-ready when FIFO 
was in use is a misconfiguration.

> 
>> +		ret = -EBUSY;
>> +		goto unlock_out;
>> +	}
>> +
>> +	data->trigger_enabled = state;
>> +
>> +	if (state) {
>> +		ret = bm1390_meas_set(data, BM1390_MEAS_MODE_CONTINUOUS);
> 
> Is this a trigger characteristic?  Feels more like a feature of enabling buffering.
> Ah well. That's always a blurry boundary so it is probably fine here.

Well, the mode needs to be set to continuous even for a single shot 
measurement when IIR filter is used. Furthermore, if we use the 
single-shot mode, then the mode must be re-written to register after 
every colleted sample. Hence we set the continuous mode also when 
trigger is used.

It might be we could set this mode already at probe and forget it then. 
Well, maybe it has some impact to power consumption (?) so perhaps we 
just leave the continuous mode to be enabled for all, triggered, FIFO 
and raw sample collections.

> ret set but not checked...

Thanks for pointing this out - I need to check (what / if) I have been 
thinking :)

> 
>> +	} else {
>> +		int dummy;
>> +
>> +		ret = bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
>> +
>> +		/*
>> +		 * We need to read the status register in order to ACK the
>> +		 * data-ready which may have been generated just before we
>> +		 * disabled the measurement.
>> +		 */
>> +		if (!ret)
>> +			ret = regmap_read(data->regmap, BM1390_REG_STATUS,
>> +					  &dummy);
> 
> Should check for errors in ret.
> 
>> +	}
>> +
>> +	ret = bm1390_set_drdy_irq(data, state);
>> +	if (ret)
>> +		goto unlock_out;
> 
> Not a lot of point in that :)

I like the way you put it :) Better to clean this too.

> 
>> +
>> +
>> +unlock_out:
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return ret;
>> +
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
>> +	if (irq < 0) {
>> +		dev_warn(data->dev, "No IRQ - skipping buffering\n");
> 
> I don't see that as deserving a warning. Device should be fine with out it.
> Maybe dev_info could be justified (just).

Ok.

> 
>> +		return 0;
>> +	}
>> +
>> +	ret = devm_iio_triggered_buffer_setup(data->dev, idev,
>> +					      &iio_pollfunc_store_time,
>> +					      &bm1390_trigger_handler,
>> +					      &bm1390_buffer_ops);
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
>> +
>> +	itrig->ops = &bm1390_trigger_ops;
>> +	iio_trigger_set_drvdata(itrig, data);
> 
> 
> 
>> +
>> +	/*
>> +	 * No need to check for NULL. request_threaded_irq() defaults to
>> +	 * dev_name() should the alloc fail.
>> +	 */
>> +	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-bm1390",
>> +			      dev_name(data->dev));
> 
> Whist true, checking for it is less code than not doing so and
> adding the comment. So I'd just check for it!

comment does not eat cycles :) Well, I know everyone is saying this does 
not matter as we're far from a hot path... Sigh, I guess you're right 
while I also know why we need such powerful computers while we do same 
basic things we did 10 years ago...

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
>> +
>> +	return ret;
> 
> return 0 as that's the only value and it's good to make it clear that
> was the intention in this path.

Ok

> 
> 
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
>> +	 * Default watermark to WMI_MAX. We could also allow setting WMI to 0,
>> +	 * and interpret that as "WMI is disabled, use FIFO_FULL" but I've
>> +	 * no idea what is assumed if watermark is 0. Does it mean each sample
>> +	 * should trigger IRQ, or no samples should do that?
> 
> In my head at least, if we are using fifo_full it is still a watermark but one
> that matches size of buffer.
> I think for previous drivers we've had 0 and 1 both meaning it's a dataready
> interrupt (i.e. one entry in the fifo).  That would be fine here as well
> and would correspond to putting the device in bypass mode.

Thanks for the explanation. It makes sense.
Meanwhile I was reading the spec and I think the FIFO_FULL usage with 
this IC is like asking for a nose-bleed. FIFO_FULL IRQ is acked by 
reading the status - and if data is not read from the FIFO, then the 
status will remain cleared (and I assume also the IRQ line will stay 
low). I assume it's easy enough to write a code that acks the IRQ while 
leaving the buffer full - and effectively killing the FIFO_FULL IRQ. No 
more samples for you then.

> 	
>> +	 *
>> +	 * Well, for now we just allow BM1390_WMI_MIN to BM1390_WMI_MAX and
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
> The triggered buffer setup should set the second of these inside
> the IIO core code (as it always needs to be set if that code is called).

Right. Thanks.
> 
> 
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
>> +	return ret;
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
>> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> 
> I don't mind seeing this but I do want it to have a comment saying 'why'.
> I assume there is something really slow involved in probing this?

I wouldn't say there is anything really slow. What I have gathered is:

1) The grand idea is that at the end of the day (week, month, year) 
async probing should be the default when it causes no problems.

2) Problems are rare (although they may exist).

3) All regulator drivers were changes (or suggested to be changed) to do 
async probing because for example the ramp-rates may be slow.

4) This driver enables the VDD supply - with potentially slow ramp-rate 
(well, the I need to guess user's setups statement holds again) so it 
may potentially take a while (probably not long though).

5) We have a few msleeps() in bm1390_chip_init() - which are likely to 
result a sleep tens of milliseconds. So there is some delay.

 From those 5 things I derived assumption that async probe would be the 
right thing to start with. We can drop it if it causes a problem in an 
actual setup :)

> 
>> +	},
>> +	.probe = bm1390_probe,
>> +	.id_table = bm1390_id,
>> +};
>> +module_i2c_driver(bm1390_driver);
>> +
>> +MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
>> +MODULE_DESCRIPTION("Driver for ROHM BM1390 pressure sensor");
>> +MODULE_LICENSE("GPL");
> 

Thanks again for all the help!

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

