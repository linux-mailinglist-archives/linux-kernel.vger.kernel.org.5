Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7097977D1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbjIGQeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjIGQen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:34:43 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4751FD4;
        Thu,  7 Sep 2023 09:34:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fef56f7223so11731245e9.3;
        Thu, 07 Sep 2023 09:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694104398; x=1694709198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNrMS0jKpA02UVeOCHJ96KQJ1jCxXdOS0jI0Nia1sgQ=;
        b=qm2d3wAjRIR7Rxx35sCN3tUT8vAXxfmG3tlGuVN51Uqz47q+m1zwxFFb+sYnuJ4lOd
         a3L5GUihLUZ8uTul70hWZn4oyC86BEwtGt3YT8Uk7vFHv1RqM5xQ86Anp8bzKPhHeMjo
         Q1NgpADHhKa7e8hPA8ps0JG/s0rB1lwTCUoWcNNFxF50Vw3mzoxmDhw/X9sUtr+gAkrj
         O4soX3/SuMbM8nimHWfYRhEQXfqmezo4Wo20aKR/PeqjM8QqGTuH0PZBGO/pJSxGs+5w
         h0vvl2bjw5312lDGgcWYfvvRzyWij/Hz+1B7BM4rkPdS/8a20td2OTxiRA1osdDojzLb
         n4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694104398; x=1694709198;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNrMS0jKpA02UVeOCHJ96KQJ1jCxXdOS0jI0Nia1sgQ=;
        b=NDRDAKF3N+Vc3xJJ9m+6e+9Yt6JkLbmn7hz62DXs4XeHZYMJC8KhrfLLpX1a0oUGoO
         GeRRYabTQVQ0QSre56c3fMTu35NiFqtrh/IhDlQSViATz4G+CGWJlGl4g3ORj2hYJiS1
         bQBlmCMpEfhqTClUZ2tTmhv1ck5P66uVl1emV8gdWJRkmphnh4y+iuhied2LSY5jeiv1
         N+ZvTs/4we7smJB68fuZtQsieAUrfMmzpVgYgFkBdJ9PsVlksp6SgZdZ3EuZXtdRO63T
         UZgtQOj6HLOUpZRDxvOPkAcKC+re8+Zz+SLkQCROvmqJib/YUVOKjj+CEsjMl9Ck5gd/
         OL0Q==
X-Gm-Message-State: AOJu0YwlS0aSqSeW4DQs7azUGbq5TQsHCycBMu73Z/Z8sXwtlFbrU+J3
        2omdHaQeOuLckrjxnnQzWD9bXkxIwKA=
X-Google-Smtp-Source: AGHT+IHKljxEDFpiO0DxhspYj8+o0Vpr/Pd6+gSgrXNyCx6TvqCSg0ZVexdpjRTOSu7tHbOXdNUUJQ==
X-Received: by 2002:a2e:b617:0:b0:2bc:d993:b7ba with SMTP id r23-20020a2eb617000000b002bcd993b7bamr4078679ljn.27.1694066239495;
        Wed, 06 Sep 2023 22:57:19 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::3? (dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::3])
        by smtp.gmail.com with ESMTPSA id e16-20020a2e9850000000b002b9fec8961bsm3727734ljj.123.2023.09.06.22.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 22:57:18 -0700 (PDT)
Message-ID: <4d8e2873-49bc-8314-ee16-dd327a92898d@gmail.com>
Date:   Thu, 7 Sep 2023 08:57:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1694001462.git.mazziesaccount@gmail.com>
 <08f7085ba1af2fae21c942f6c20a94c237df53ba.1694001462.git.mazziesaccount@gmail.com>
 <ZPifWlRvX5hLFPvG@smile.fi.intel.com>
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 2/3] iio: pressure: Support ROHM BU1390
In-Reply-To: <ZPifWlRvX5hLFPvG@smile.fi.intel.com>
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

Morning Andy,

Thanks for the review.

On 9/6/23 18:48, Andy Shevchenko wrote:
> On Wed, Sep 06, 2023 at 03:37:48PM +0300, Matti Vaittinen wrote:
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
> 
> ...
> 
> 
>> +struct bm1390_data {
>> +	int64_t timestamp, old_timestamp;
> 
> Out of a sudden int64_t instead of u64?

Judging the iio_push_to_buffers_with_timestamp() and iio_get_time_ns(), 
IIO operates with signed timestamps. One being s64, the other int64_t.

>> +	struct iio_trigger *trig;
>> +	struct regmap *regmap;
>> +	struct device *dev;
>> +	struct bm1390_data_buf buf;
>> +	int irq;
>> +	unsigned int state;
>> +	bool trigger_enabled;
> 
>> +	u8 watermark;
> 
> Or u8 instead of uint8_t?

So, uint8_t is preferred? I don't really care all that much which of 
these to use - which may even show up as a lack of consistency... I 
think I did use uint8_t when I learned about it - but at some point 
someone somewhere asked me to use u8 instead.. This somewhere might have 
been u-boot though...

So, are you Suggesting I should replace u8 with uint8_t? Can do if it 
matters.
> 
>> +	/* Prevent accessing sensor during FIFO read sequence */
>> +	struct mutex mutex;
>> +};
> 
> ...
> 
>> +static int bm1390_read_temp(struct bm1390_data *data, int *temp)
>> +{
>> +	u8 temp_reg[2] __aligned(2);
> 
> Why?! Just use proper bitwise type.

What is the proper bitwise type in this case?

I'll explain my reasoning:
What we really have in hardware (BM1390) and read from it is 8bit 
registers. This is u8 to me. And as we read two consecutive registers, 
we use u8 arr[2]. In my eyes it describes the data perfectly well, right?

> 
>> +	__be16 *temp_raw;
>> +	int ret;
>> +	s16 val;
>> +	bool negative;
>> +
>> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp_reg,
>> +			       sizeof(temp_reg));
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (temp_reg[0] & 0x80)
>> +		negative = true;
>> +	else
>> +		negative = false;
> 
>> +	temp_raw = (__be16 *)&temp_reg[0];
> 
> Heck no. Make temp_reg be properly typed.

As I explained above, to me it seems ur arr[2} is _the_ proper type to 
represent data we read from the device.

What we need to do is to convert the 16bits of data to an integer we can 
give to the rest of the system. And, we happen to know how to 
'manipulate' the data to get it in format of understandable integer. As 
we have these 16 bits in memory, aligned to 2 byte boundary - why 
shouldn't we just 'manipulate' the data and say - here we have your 
integer, please be my guest and use it?

Well, I am keen to learn the 'correct bitwise type' you talk about - can 
you please explain me what this correct type for two 8bit integers is? 
Maybe I can improve.

> 
>> +	val = be16_to_cpu(*temp_raw);
>> +
>> +	if (negative) {
>> +		/*
>> +		 * Two's complement. I am not sure if all supported
>> +		 * architectures actually use 2's complement represantation of
>> +		 * signed ints. If yes, then we could just do the endianes
>> +		 * conversion and say this is the s16 value. However, as I
>> +		 * don't know, and as the conversion is pretty simple. let's
>> +		 * just convert the signed 2's complement to absolute value and
>> +		 * multiply by -1.
>> +		 */
>> +		val = ~val + 1;
>> +		val *= -1;
>> +	}
>> +
>> +	*temp = val;
>> +
>> +	return 0;
>> +}
> 
>> +static int bm1390_pressure_read(struct bm1390_data *data, u32 *pressure)
>> +{
>> +	int ret;
>> +	u8 raw[3];
>> +
>> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_PRESSURE_BASE,
>> +			       &raw[0], sizeof(raw));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	*pressure = (u32)(raw[2] >> 2 | raw[1] << 6 | raw[0] << 14);
>> +
>> +	return 0;
>> +}
> 
> ...
> 
>> + /* The enum values map directly to register bits */
> 
> In this case assign _all_ values explicitly. Currently it's prone to errors
> if somebody squeezed a value in between.

Agree. This is a good practice. Thanks. (although, it shouldn't really 
matter here as nobody really should squeeze a value in between as enum 
is short and we have this just comment above).

>> +enum bm1390_meas_mode {
>> +	BM1390_MEAS_MODE_STOP = 0x0,
>> +	BM1390_MEAS_MODE_1SHOT,
>> +	BM1390_MEAS_MODE_CONTINUOUS,
>> +};
> 
> ...
> 
>> +	mutex_lock(&data->mutex);
> 
> Wouldn't you like to start using cleanup.h?

The new macro "thingee" for C++ destructor like constructs?

TBH, I am not really in a rush with it for two reasons.
1) The syntax looks very alien to me. I would like to get some time to 
get used to it before voluntarily ending up maintaining a code using it. 
(I don't like practicing things upstream as practicing tends to include 
making more errors).

2. Related to 1). I am not (yet) convinced incorporating changes in 
stuff using these cleanups is easy. I'm a bit reserved and would like to 
see how things play out.

3. I expect I will get a few requests to backport the code to some older 
kernels used by some big customers. (I've been doing plenty of extra 
work when backporting my kernel improvements like regmap_irq stuff, 
linear ranges, regulator pickable ranges, gts-helpers to customer 
kernels to get my drivers working - or working around the lack of thiose 
features. I have been willing to pay this prize to get those helpers 
upstream for everyone to use. The cleanup.h however is there so it does 
not _need_ new users. I don't think _all_ existing drivers will be 
converted to use it so one more should probably not hurt. I think that 
in a year at least some customers will be using kernel containing the 
cleanup.h - so by latest then it is time for me to jump on that train. I 
hope I am used to reading those macros by then).
> 
> ...
> 
>> +	/*
>> +	 * We use 'continuous mode' even for raw read because according to the
>> +	 * data-sheet an one-shot mode can't be used with IIR filter
> 
> Missing period at the end.
> 
>> +	 */
> 
> ...
> 
>> +		goto unlock_out;
> 
> cleanup.h makes these goto:s unneeded.
> 
> ...
> 
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
>> +		}
>> +
>> +		return -EINVAL;
> 
> Why not switch-case like other drivers do?

In my eyes avoiding the very simple if - else if does not warrant nested 
switches which look ugly to me.

> 
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = iio_device_claim_direct_mode(idev);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = bm1390_read_data(data, chan, val, val2);
>> +		iio_device_release_direct_mode(idev);
> 
>> +		if (!ret)
>> +			return IIO_VAL_INT;
>> +
>> +		return ret;
> 
> Why not usual pattern?
> 
> 		if (ret)
> 			return ret;

I see your point, ok.

> 
>> +	default:
>> +		return -EINVAL;
>> +	}
> 
> ...
> 
>> +	smp_lvl = FIELD_GET(BM1390_MASK_FIFO_LVL, smp_lvl);
> 
>> +
> 
> Unneeded blank line.
> 
>> +	if (smp_lvl > 4) {
>> +		/*
>> +		 * Valid values should be 0, 1, 2, 3, 4 - rest are probably
>> +		 * bit errors in I2C line. Don't overflow if this happens.
>> +		 */
>> +		dev_err(data->dev, "bad FIFO level %d\n", smp_lvl);
>> +		smp_lvl = 4;
>> +	}
> 
>> +	if (!smp_lvl)
>> +		return ret;
> 
> This can be checked first as it's and error condition

I wouldn't say it is an error condition. It just means there was no 
samples collected in buffer.

  and previous branch has
> no side effects on this. Also, wouldn't be better to use error code explicitly?

Yes. For the clarity we definitely should explicitly do "return 0" here. 
Thanks.

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
> 
>> +	switch (mask) {
>> +	default:
>> +		ret = -EINVAL;
>> +	}
> 
> This needs a comment: Why we have a dead code.

Oh, thanks! This really, rather requires a clean-up. It looks like a 
left over from the version where I supported setting the number of 
samples to average.

> 
>> +	iio_device_release_direct_mode(idev);
>> +
>> +	return ret;
>> +}
> 
> ...
> 
>> +	/*
>> +	 * Default to use IIR filter in "middle" mode. Also the AVE_NUM must
>> +	 * be fixed when IIR is in use
> 
> Missing period.
> 
>> +	 */
> 
> ...
> 
>> +	ret = regmap_read(data->regmap, BM1390_REG_STATUS,
>> +			  &dummy);
> 
> This is perfectly one line even for fanatics of 80 characters limitation.
> 
>> +	if (ret || !dummy)
>> +		return IRQ_NONE;
> 
> ...
> 
>> +	if (state) {
>> +		ret = bm1390_meas_set(data, BM1390_MEAS_MODE_CONTINUOUS);
> 
> This ret is never used, what's going on here?

Thanks. I need to revise this :)

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
>> +	}
>> +
>> +	ret = bm1390_set_drdy_irq(data, state);
>> +	if (ret)
>> +		goto unlock_out;
> 
>> +
>> +
> 
> One blank line is enough.
> 
>> +unlock_out:
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return ret;
> 
>> +
> 
> We do not put blank lines at the end of functions.
> 
>> +}
> 
> ...
> 
>> +	ret = devm_iio_triggered_buffer_setup(data->dev, idev,
>> +					      &iio_pollfunc_store_time,
>> +					      &bm1390_trigger_handler,
>> +					      &bm1390_buffer_ops);
> 
>> +
> 
> Yet another redundant blank line. I dunno how you manage to almost in every
> second attempt to randomly place blank lines here and there... I feel like
> a conspiracy theory against myself :-)

Oh, dang. My plot is revealed :)

> 
>> +	if (ret)
>> +		return dev_err_probe(data->dev, ret,
>> +				     "iio_triggered_buffer_setup FAIL\n");
> 
> ...
> 
>> +
>> +
> 
> Ditto.
> 
>> +	ret = devm_iio_trigger_register(data->dev, itrig);
>> +	if (ret)
>> +		return dev_err_probe(data->dev, ret,
>> +				     "Trigger registration failed\n");
> 
>> +
>> +
> 
> Ditto.
> 
>> +	return ret;
> 
> ...
> 
>> +	ret = devm_iio_device_register(dev, idev);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret,
>> +				     "Unable to register iio device\n");
>> +
> 
>> +	return ret;
> 
> Do you expect anything than 0 here?

No, not really. Thanks!


Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

