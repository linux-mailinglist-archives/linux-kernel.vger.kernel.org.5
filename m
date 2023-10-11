Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303777C5704
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbjJKOhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjJKOhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:37:20 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F2192
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:37:18 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso865702b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1697035038; x=1697639838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WFMOgbVONefIrZ/Xf84ZdOIVivy1/VYaPvhIC7ILZcY=;
        b=VzWm2TOLufW833p7Ygi26ubJtSAltcxW0DZoKqM4TN0wBsNr/5GtLLxaXf8LqyF7MJ
         3C1+tAIFSKNBP7R1MY/NdUvUYHogkxelR/IKoNzxfUz2Adq8Ydz8oM6K5frSGTTCK2id
         W0hgqzr0I5ME1MF8PYdVvZOvAAE5QTdbuXxurLMIlAXMYxyI0MS2E4D7bVvzbgvVNek6
         Oelkx5xLlUptzpsA44ThXojKZ8fcBp51ecrRRl2ZQa6C/M7RtjieMz6GvZJ7NjkZ63JJ
         RpOzJZVvSVjStIN6wl4QfcXbkkdCi3f1uoELBT5P1WamMcr5TBrJsA6yCxBcEUcHOAMh
         z3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697035038; x=1697639838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFMOgbVONefIrZ/Xf84ZdOIVivy1/VYaPvhIC7ILZcY=;
        b=bkyF2wuXmFzJJkN6HSKvhfscBfHCyQFp3DPJEGhzXn1gvqczBgGVuVRZdAAAiJ7klM
         QgZjfXxpn+QAUHgqx9THjujMahp9W9Isx3JMlhSlKEy7ao8NxcTNbSUhYE8Ncs2X10e/
         UXYwNZspmiPRRlXw1+3YRcFL0aYhhJ/SQiVXUNYO7FzfheDqM2JRLODMjCBZVxS+hGTY
         7SUmGSXF5W1SBPJOSfnFdGmvpHQoskcKwRVZkTl46nKLWGFQoHQyK27buzaAkUOfi4pU
         xbzrkG3vX9ngAje7JWjfRUiVpJNjSsVzCu6EnOJVb4yoRn/km1fMgoti4YqNn+zAOowK
         Xjvw==
X-Gm-Message-State: AOJu0Ywz/HkShbRysdkEGmW3gUQGpjRvY3w7NNbCPKHwAC/OjIIPzN4V
        jtNfUYAJGXgBmuWEP1RP4OzRbg==
X-Google-Smtp-Source: AGHT+IGlEjk2y1lSmfnlT6YOpFwQmm42o9orwKhmg4TPONovBgLa+Dj8OB7itHzH36Sj/j8qNki7gw==
X-Received: by 2002:a05:6a20:3c90:b0:15e:22a4:b897 with SMTP id b16-20020a056a203c9000b0015e22a4b897mr26680474pzj.10.1697035037610;
        Wed, 11 Oct 2023 07:37:17 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:92f1:e901:1eef:a22? (2403-580d-82f4-0-92f1-e901-1eef-a22.ip6.aussiebb.net. [2403:580d:82f4:0:92f1:e901:1eef:a22])
        by smtp.gmail.com with ESMTPSA id r5-20020a62e405000000b006933b69f7afsm10175336pfh.42.2023.10.11.07.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 07:37:16 -0700 (PDT)
Message-ID: <07761a6c-85a8-c7bd-a0af-28d0f29b3e5d@tweaklogic.com>
Date:   Thu, 12 Oct 2023 01:07:10 +1030
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Gazzillo <paul@pgazz.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
References: <20231008154857.24162-1-subhajit.ghosh@tweaklogic.com>
 <20231008154857.24162-3-subhajit.ghosh@tweaklogic.com>
 <20231010153807.6335a043@jic23-huawei>
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20231010153807.6335a043@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 01:08, Jonathan Cameron wrote:
> 
> No need to wrap the patch description quite so short. Aim
> for up to 75 char for a commit message (and 80 for the code)
> Here you are under 60.
> 
Thank you for taking time to point out these small issues.

>>
>> Datasheet at https://docs.broadcom.com/doc/AV02-4755EN
>>
> There is a tag for datasheets in the format tags block so
> Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
>> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> 
> I took a quick look at the most similar part number adps9300 and
> this does look substantially different but could you confirm you've
> taken a look at the plausible drivers to which support for this part
> could be added and perhaps mention why that doesn't make sense
> I think it will be mainly feature set being different here, but also
> it seems they have completely different register maps despite similar
> part numbers!
I have taken a look at quiet a few light sensor drivers including
apds9960 and apds9300, as you said that they are different. There are
another two drivers apds990x and apds9802als in drivers/misc which are
also very different but I can't say that I have been through all the
driver files.

>> +
>> +enum apds9306_int_channels {
>> +	CLEAR,
>> +	ALS,
>> +};
> 
> Is this used?
>
Something left from the old code. It is not needed.
  

>> + * Nano Lux per count = (340.134 * 1000000000)/ (32 * 3 * 2000) for apds9306
>> + * Nano Lux per count = (293.69 * 1000000000)/ (32 * 3 * 2000) for apds9306-065
> 
> Even though it's a comment stick to kernel maths syntax and put a space before the /
> Otherwise some script will complain it's not correctly formatted code :)
Ok, understood.

> 
>> + */
>> +static struct part_id_nlux_per_count apds9306_part_id_nlux_per_count[] = {
>> +	{.part_id = 0xB1, .nlux_per_count = 1787156},
>> +	{.part_id = 0xB3, .nlux_per_count = 1529635},
> 
> Prefer { .part_id = 0xB3, .nlux_per_count = 1629635 },
> for tables liek this as it ends up a tiny bit easier to read.
Ok.
> 
>> +};
>> +static struct iio_chan_spec apds9306_channels_without_events[] = {
>> +	{
>> +		APDS9306_CHANNEL(IIO_LIGHT)
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +			BIT(IIO_CHAN_INFO_PROCESSED),
> 
> This needs an explanation for why as a comment in the code.
> We very rarely support both raw and processed for the same channel and
> mostly when we do it is due to some historical changes.
> 
Thanks for pointing it out.
> You are using the gts stuff here so it should be possible to expose
> the controls for scale necessary to have userspace perform the raw to processed
> conversion.
Yes, processed = (raw + offset) * scale. No need to do calculations in kernel
space. Ok. I will reimplement it.

>> +
>> +/* INT_PERSISTENCE available */
>> +IIO_CONST_ATTR(thresh_either_period_available, "[0 15]");
>> +
>> +/* ALS_THRESH_VAR available */
>> +IIO_CONST_ATTR(thresh_adaptive_either_values_available, "[0 7]");
> Not valid range syntax for IIO attributes, you need to include
> the step.
> 
> [0 1 7]
Got it.
> 

>> +	.cache_type = REGCACHE_RBTREE,
>> +	.disable_locking = true,
> This normally deserves a statement of what you are doing about locking instead.

I'll put it in the next version.

> The interrupt controller for starters takes to no locks and can run concurrently
> with other accesses from other CPUs.  That seems unwise.
>
Well, regarding device access, interrupt handler just reads the status registers
thereby clearing the interrupt status flag and releasing the physical interrupt line.
What can be the issue if I don't use a lock?


>> +static int apds9306_intg_time_get(struct apds9306_data *data, int *val2)
>> +{
>> +	*val2 = iio_gts_find_int_time_by_sel(&data->gts, data->intg_time_idx);
>> +	if (*val2 < 0)
>> +		return *val2;
> 
> You shouldn't have side effects on *val2 if an error occurs.
> Its not a bug in this case, but it is generally something to avoid
> 
Ok.

> 
>> +
>> +static int apds9306_sampling_freq_set(struct apds9306_data *data, int val,
>> +				int val2)
>> +{
>> +	int i, ret = -EINVAL;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(apds9306_repeat_rate_freq); i++)
>> +		if (apds9306_repeat_rate_freq[i][0] == val &&
>> +				apds9306_repeat_rate_freq[i][1] == val2) {
>> +			ret = regmap_field_write(data->regfield_repeat_rate, i);
>> +			if (ret)
>> +				return ret;
>> +			data->repeat_rate_idx = i;
>> +			break;
> Might as well return here instead of break as nothing else to do.
Ok.
> 
....
>> +		ret = IIO_VAL_INT;
>> +		*val2 = 0;
> 
> As below.  No need to set *val2 to 0 if returning IIO_VAL_INT.
Ok.

>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	*val2 = 0;
> 
> The IIO core won't use val2 if you return IIO_VAL_INT, so don't bother setting it.

Ok. Got it.
> 
>> +	return IIO_VAL_INT;
>> +}
>> +

>> +
>> +static int apds9306_read_event_config(struct iio_dev *indio_dev,
>> +				      const struct iio_chan_spec *chan,
>> +				      enum iio_event_type type,
>> +				      enum iio_event_direction dir)
>> +{
>> +	struct apds9306_data *data = iio_priv(indio_dev);
>> +	unsigned int val, val2;
>> +	int ret;
>> +
>> +	mutex_lock(&data->mutex);
> As below
> 	guard(mutex)(&data->mutex);
> 
> should simplify this - I won't comment on this one above this point (reviewing backwards
> through the code).
Ok.
> 
>> +	switch (type) {
>> +	case IIO_EV_TYPE_THRESH:
>> +		ret = regmap_field_read(data->regfield_int_en, &val);
>> +		if (ret)
>> +			break;
>> +		ret = regmap_field_read(data->regfield_int_src, &val2);
>> +		if (ret)
>> +			break;
>> +		if (chan->type == IIO_LIGHT)
>> +			ret = val & val2;
>> +		else if (chan->type == IIO_INTENSITY)
>> +			ret = val & !val2;
> 
> This logic would benefit from better variable naming.
> en and src for example..
Sure.
> 
>> +		else
>> +			ret = -EINVAL;
>> +		break;
>> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
>> +		ret = regmap_field_read(data->regfield_int_thresh_var_en,
>> +					&val);
>> +		if (ret)
>> +			break;
>> +		ret = val;
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +	}
>> +	mutex_unlock(&data->mutex);
>> +	return ret;
>> +}
>> +
>> +static int apds9306_write_event_config(struct iio_dev *indio_dev,
>> +				       const struct iio_chan_spec *chan,
>> +				       enum iio_event_type type,
>> +				       enum iio_event_direction dir,
>> +				       int state)
>> +{
>> +	struct apds9306_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	state = !!state;
>> +	mutex_lock(&data->mutex);
> 
> Perfect place to use the new cleanup.h trickery here.
:) Absolutely...
> 
> guard(mutex)(&data->mutex);
> 
> and then you can just return in error paths which will simplify this code
> 
Got your point.
>> +	switch (type) {
>> +	case IIO_EV_TYPE_THRESH:

>> +static int get_device_id_lux_per_count(struct apds9306_data *data)
>> +{
>> +	int ret, part_id;
>> +
>> +	ret = regmap_read(data->regmap, APDS9306_PART_ID, &part_id);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (part_id == apds9306_part_id_nlux_per_count[0].part_id)
>> +		data->nlux_per_count =
>> +			apds9306_part_id_nlux_per_count[0].nlux_per_count;
>> +	else if (part_id == apds9306_part_id_nlux_per_count[1].part_id)
>> +		data->nlux_per_count =
>> +			apds9306_part_id_nlux_per_count[1].nlux_per_count;
> 
> For loop over ARRAY_SIZE(apds9306_part_id_nlux_per_count)
> would be more extensible with a return on match, so that if you
> don't we just return -ENXIO on exit from the loop.
Yes. Got it.
> 
> 
>> +	else
>> +		return -ENXIO;
>> +
>> +	return 0;
>> +}
>> +
>> +static void apds9306_powerdown(void *ptr)
>> +{
>> +	struct apds9306_data *data = (struct apds9306_data *)ptr;
>> +	struct device *dev = data->dev;
>> +	int ret;
>> +
>> +	/* Disable interrupts */
>> +	ret = regmap_field_write(data->regfield_int_thresh_var_en, 0);
>> +	if (ret)
>> +		dev_err(dev, "Failed to disable variance interrupts\n");
> 
> Muddling on when things are failing is probably not worthwhile. I'd be
> tempted to just error out of here.  Worst that happens is we leave the
> device partly enabled which is a bit of a power waste, but it's not expected
> to happen so I don't think we care.  Much easier to follow code if we
> always return on error.
Ok, makes sense. I'll do that.
> 

>> +	if (client->irq) {
>> +		indio_dev->info = &apds9306_info;
>> +		indio_dev->channels = apds9306_channels_with_events;
>> +		indio_dev->num_channels =
>> +				ARRAY_SIZE(apds9306_channels_with_events);
>> +		ret = devm_request_threaded_irq(dev, client->irq, NULL,
>> +					apds9306_irq_handler,
>> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> 
> The direction of the interrupt should come from device tree.  Sometimes people
> use level conversion by using an not gate and that flips the logic of the
> interrupt in a way that the driver can't see.  Hence we leave that
> detail for firmware, not the driver.
Ok, understood.
> 
>> +	ret = devm_add_action_or_reset(dev, apds9306_powerdown, data);
> 
> Why at this point? I'd have thought it wasn't powered up until init_device()
> which follows?  So I'd expect to see this call after that, not before.
> 
Right. I will do a bit more reading on this before using this. I assumed this
functions registers the callback which gets called at driver release by the
subsystem similar to release().

>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				"failed to add action on driver unwind\n");
>> +
>> +	ret = apds9306_init_device(data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to init device\n");
>> +
>> +	return devm_iio_device_register(dev, indio_dev);
>> +}
>> +
>> +static int apds9306_runtime_suspend(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct apds9306_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	ret = apds9306_power_state(data, STANDBY);
>> +	if (ret)
>> +		regcache_cache_only(data->regmap, true);
> 
> What is the logic of putting the regcache into cache only mode
> if we fail to power down the device?
Yes, true. Real regs are available why use fake ones. I'll fix it.


>> +	ret = apds9306_power_state(data, ACTIVE);
>> +	if (ret)
>> +		regcache_cache_only(data->regmap, true);
> 
> If you get here an this failed we are in an unknown state where
> the device is effectively dead anyway.  I'd not bother
> with juggling the state of the regcache.  Or am I missing some path
> in which this regcache_cache_only() is called that isn't
> an error path?
> 
Yes, this is an error. I'll simply return error.

>> +
>> +static const struct i2c_device_id apds9306_id[] = {
>> +	{ "apds9306" }, { }
> 
> Put the terminator on a new line because it reduces the noise if we ever add
> more devices by removing the need to reformat this first.
> 
Ok.
>> +};
>> +MODULE_DEVICE_TABLE(i2c, apds9306_id);
>> +
>> +static const struct of_device_id apds9306_of_match[] = {
>> +	{ .compatible = "avago,apds9306" }, { }
> 
> Same as above.
> 
Ok.

Thank you Jonathan for the review. I'll get the changes done in the next version.

Regards,
Subhajit Ghosh




