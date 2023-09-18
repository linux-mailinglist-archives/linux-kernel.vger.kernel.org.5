Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7943C7A4897
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241623AbjIRLjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241602AbjIRLjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:39:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B43A9B;
        Mon, 18 Sep 2023 04:39:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50305abe5f0so2603416e87.2;
        Mon, 18 Sep 2023 04:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695037147; x=1695641947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuqTnJeHNygiskNZh18hSiEjOgQHQ1Wa6VO1HWKp7Zw=;
        b=lrVZn1VtSScxJNf8bn0yR7h2ZAzAflZvj7um7vthDQTjptuLkbinB8Zk2iD+ikerUe
         lp150M9r30qNj+5lyuJVZRqv9Y3z+K8p0XJnWaNd58kxoqxFrbi6b5e61dNGtAfWb94m
         bMsnVvyD/eVt77e4pOAfFKkQQL+FFv12znOGW6eVqgv+PHCenglISSbBKe3dcfuYtSkH
         EibyRbenkA988NNnVadNmaMAeR+8S5Fa8yyIxTtCL9CluZJR2yP2OpwOEZXtIr7g89hD
         RZFZGKDPHmWoZc7Ef6j99ZagNKNUUBskR1OCWZCPtepQsFkG5DqRED8AZtXCZz+I6x2R
         uX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695037147; x=1695641947;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CuqTnJeHNygiskNZh18hSiEjOgQHQ1Wa6VO1HWKp7Zw=;
        b=uLLbLW1A+6lxzeADPDFhDTy5V0S6Gx+GFlibdXSuW5gE4MRtyJCD68DCwqtYDXC9Pe
         ldI82TRL6P48+u8Yy7AZSmiEPhfLkQ4z4vy27OAcI/PyQKuU444y2eBlsJfTNfYTFjlK
         PnMgueLCYwxt7pobTQAy8+IWJwbaV3QLCdEY8mLRxXavA8qBe0QdAgaEnMbLD216Bw+K
         U0Q+dTrNEKpzlyiFl0E2aJ8s5TsAeVO9KPoJ6Jl6rDPMgTzEJF7GQrUNRDsG3mi/Fwag
         GXjx1DBTMaYJ9EG5RUApMpMiMunbveMSVpENCrUYrPCf6fhxBv8emTTA3VHjC1yFVRPp
         G+Lg==
X-Gm-Message-State: AOJu0YzKv/3GLIqwOhGXiHh6D2zzdrgS8mWOU3KvfKyGRx1zpMZoyU79
        NC5Ysb0Kexj6YKMr5aATYHzVeuNCTLs=
X-Google-Smtp-Source: AGHT+IGJvkvAyddo4pR5iG84DRDfmqJsbo6SJ4mVeVvLwZQgv/Z6HhLO81dqfRJv2fE0qer5ZMlZjg==
X-Received: by 2002:a19:791c:0:b0:503:2089:d3b8 with SMTP id u28-20020a19791c000000b005032089d3b8mr803951lfc.8.1695037146379;
        Mon, 18 Sep 2023 04:39:06 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::3? (dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::3])
        by smtp.gmail.com with ESMTPSA id c27-20020ac244bb000000b004f86d3e52c0sm1778309lfm.4.2023.09.18.04.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 04:39:05 -0700 (PDT)
Message-ID: <7ec2ac97-8ee3-186b-ef25-ceb5ec57751a@gmail.com>
Date:   Mon, 18 Sep 2023 14:39:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, en-GB
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     ak@it-klinger.de, andriy.shevchenko@linux.intel.com,
        ang.iglesiasg@gmail.com, bbara93@gmail.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        matti.vaittinen@fi.rohmeurope.com, robh+dt@kernel.org
References: <cover.1694760170.git.mazziesaccount@gmail.com>
 <f378a401cec4fb0b9287b52ab159f00dd77569a6.1694760170.git.mazziesaccount@gmail.com>
 <cdc9a8f8-fbd5-1eb3-7bac-1e6e5893bc9b@wanadoo.fr>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 2/3] iio: pressure: Support ROHM BU1390
In-Reply-To: <cdc9a8f8-fbd5-1eb3-7bac-1e6e5893bc9b@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Thank you for taking a look at this! Much appreciated :)

On 9/16/23 11:01, Christophe JAILLET wrote:
> Le 15/09/2023 à 08:56, Matti Vaittinen a écrit :
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
>> get the temperature measurements from sensor without any additional 
>> logic.
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
>> each watermark IRQ we go and read all samples in FIFO and push them to 
>> the
>> IIO buffer.
>>
>> Signed-off-by: Matti Vaittinen 
>> <mazziesaccount-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
> 
> ...
> 
>> +struct bm1390_data_buf {
>> +    u32 pressure;
>> +    __be16 temp;
> 
> I've not looked in details so I'm not sure if related, but 
> bm1390_read_temp() seems to use int.

The bm1390_read_temp() is only used for read_raw, and the u16 gets 
converted to int because this is what the IIO API uses for read_raw. 
Even the bm1390_read_temp() gets this into an u16 when data is read from 
hardware - because the (temperature) data in the hardware is 16 bits.

> 
>> +    s64 ts __aligned(8);
>> +};
>> +
>> +/* Pressure data is in 3 8-bit registers */
>> +#define BM1390_PRESSURE_SIZE    3
> 
> Unused? (see other comment below)
> 
>> +
>> +/* BM1390 has FIFO for 4 pressure samples */
>> +#define BM1390_FIFO_LENGTH    4
>> +
>> +/* Temperature data is in 2 8-bit registers */
>> +#define BM1390_TEMP_SIZE    2
> 
> Unused? (see other comment below)
> 
> ...
> 
>> +static int bm1390_read_temp(struct bm1390_data *data, int *temp)
>> +{
>> +    __be16 temp_raw;
> 
> Something to do with BM1390_TEMP_SIZE?
> 
>> +    int ret;
>> +
>> +    ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp_raw,
>> +                   sizeof(temp_raw));
>> +    if (ret)
>> +        return ret;
>> +
>> +    *temp = be16_to_cpu(temp_raw);
> 
> See potential link with the comment above related to 
> bm1390_data_buf.temp being a __be16 an temp being a int.

Thanks. And yes. I have (most likely) originally thought of reading the 
data in u8 arrays with the size of the defined data sizes. This idea was 
probably abandoned when discussing about this approach during v1 review 
- feedback from Andy and Jonathan was that the temperature data should 
be directly read to an u16 - and at this point using sizeof() seems more 
natural. So - this define is indeed useless now. Thanks for pointing it out!

>> +
>> +    return 0;
>> +}
>> +
>> +static int bm1390_pressure_read(struct bm1390_data *data, u32 *pressure)
>> +{
>> +    int ret;
>> +    u8 raw[3];
> 
> BM1390_PRESSURE_SIZE?
> 
> (not sure if it make sense because we still have [0..2] below, so having 
> 3 here looks useful)
> 

Umm... I see what you mean. Not sure which is better - so, unless there 
is strong opinion(s) I'll just drop the define.

>> +
>> +    ret = regmap_bulk_read(data->regmap, BM1390_REG_PRESSURE_BASE,
>> +                   raw, sizeof(raw));
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    *pressure = (u32)(raw[2] >> 2 | raw[1] << 6 | raw[0] << 14);
>> +
>> +    return 0;
>> +}
> 
> ...
> 
>> +static int bm1390_read_data(struct bm1390_data *data,
>> +            struct iio_chan_spec const *chan, int *val, int *val2)
>> +{
>> +    int ret;
>> +
>> +    mutex_lock(&data->mutex);
>> +    /*
>> +     * We use 'continuous mode' even for raw read because according 
>> to the
>> +     * data-sheet an one-shot mode can't be used with IIR filter.
>> +     */
>> +    ret = bm1390_meas_set(data, BM1390_MEAS_MODE_CONTINUOUS);
>> +    if (ret)
>> +        goto unlock_out;
>> +
>> +    switch (chan->type) {
>> +    case IIO_PRESSURE:
>> +        msleep(BM1390_MAX_MEAS_TIME_MS);
>> +        ret = bm1390_pressure_read(data, val);
>> +        break;
>> +    case IIO_TEMP:
>> +        msleep(BM1390_MAX_MEAS_TIME_MS);
>> +        ret = bm1390_read_temp(data, val);
>> +        break;
>> +    default:
>> +        ret = -EINVAL;
>> +    }
>> +    bm1390_meas_set(data, BM1390_MEAS_MODE_STOP);
> 
> "ret =" missing, or done on purpose?

Done on purpose as the actual data was read successfully and should be 
correct. The measurement will be left running though - and it would 
probably warrant at least a warning. Thanks!

> 
>> +unlock_out:
>> +    mutex_unlock(&data->mutex);
>> +
>> +    return ret;
>> +}
>> +
>> +static int bm1390_read_raw(struct iio_dev *idev,
>> +               struct iio_chan_spec const *chan,
>> +               int *val, int *val2, long mask)
>> +{
>> +    struct bm1390_data *data = iio_priv(idev);
>> +    int ret;
>> +
>> +    switch (mask) {
>> +    case IIO_CHAN_INFO_SCALE:
>> +        if (chan->type == IIO_TEMP) {
>> +            *val = 31;
>> +            *val2 = 250000;
>> +
>> +            return IIO_VAL_INT_PLUS_MICRO;
>> +        } else if (chan->type == IIO_PRESSURE) {
>> +            *val = 0;
>> +            /*
>> +             * pressure in hPa is register value divided by 2048.
>> +             * This means kPa is 1/20480 times the register value,
>> +             * which equals to 48828.125 * 10 ^ -9
>> +             * This is 48828.125 nano kPa.
>> +             *
>> +             * When we scale this using IIO_VAL_INT_PLUS_NANO we
>> +             * get 48828 - which means we lose some accuracy. Well,
>> +             * let's try to live with that.
>> +             */
>> +            *val2 = 48828;
>> +
>> +            return IIO_VAL_INT_PLUS_NANO;
>> +        }
>> +
>> +        return -EINVAL;
>> +    case IIO_CHAN_INFO_RAW:
>> +        ret = iio_device_claim_direct_mode(idev);
>> +        if (ret)
>> +            return ret;
>> +
>> +        ret = bm1390_read_data(data, chan, val, val2);
>> +        iio_device_release_direct_mode(idev);
>> +        if (ret)
>> +            return ret;
>> +
>> +        return IIO_VAL_INT;
>> +    default:
>> +        return -EINVAL;
> 
> Certainly useless, but should we break and return -EINVAL after the 
> switch, so that it is more explicit that bm1390_read_raw() always 
> returns a value?

I think there is also opposite opinions on this. For my eyes the return 
at the end of the function would also be clearer - but I think I have 
been asked to drop the useless return when I've been working with other 
sensors in IIO domain :) My personal preference would definitely be:

int ret;

switch (foo)
{
case BAR:
	ret = func1();
	if (ret)
		break;

	ret = func2();
	if (ret)
		break;

...
	break;

case BAZ:
	ret = -EINVAL;
	break;
}

return ret;

- but I've learned to think this is not the IIO preference.

> 
>> +    }
>> +}
>> +
>> +static int __bm1390_fifo_flush(struct iio_dev *idev, unsigned int 
>> samples,
>> +                   bool irq)
>> +{
>> +    struct bm1390_data *data = iio_priv(idev);
>> +    struct bm1390_data_buf buffer;
>> +    int smp_lvl, ret, i, warn;
>> +    u64 sample_period;
>> +    __be16 temp = 0;
>> +
>> +    /*
>> +     * If the IC is accessed during FIFO read samples can be dropped.
>> +     * Prevent access until FIFO_LVL is read
>> +     */
>> +    if (test_bit(BM1390_CHAN_TEMP, idev->active_scan_mask)) {
>> +        ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp,
>> +                       sizeof(temp));
>> +        if (ret)
>> +            return ret;
>> +    }
>> +
>> +    ret = regmap_read(data->regmap, BM1390_REG_FIFO_LVL, &smp_lvl);
>> +    if (ret)
>> +        return ret;
>> +
>> +    smp_lvl = FIELD_GET(BM1390_MASK_FIFO_LVL, smp_lvl);
>> +    if (!smp_lvl)
>> +        return 0;
>> +
>> +    if (smp_lvl > 4) {
>> +        /*
>> +         * The fifo holds maximum of 4 samples so valid values
>> +         * should be 0, 1, 2, 3, 4 - rest are probably bit errors
>> +         * in I2C line. Don't overflow if this happens.
>> +         */
>> +        dev_err(data->dev, "bad FIFO level %d\n", smp_lvl);
>> +        smp_lvl = 4;
>> +    }
>> +
>> +    sample_period = data->timestamp - data->old_timestamp;
>> +    do_div(sample_period, smp_lvl);
>> +
>> +    if (samples && smp_lvl > samples)
>> +        smp_lvl = samples;
>> +
>> +    for (i = 0; i < smp_lvl; i++) {
>> +        ret = bm1390_pressure_read(data, &buffer.pressure);
>> +        if (ret)
>> +            break;
>> +
>> +        buffer.temp = temp;
>> +        /*
>> +         * Old timestamp is either the previous sample IRQ time,
>> +         * previous flush-time or, if this was first sample, the enable
>> +         * time. When we add a sample period to that we should get the
>> +         * best approximation of the time-stamp we are handling.
>> +         *
>> +         * Idea is to always keep the "old_timestamp" matching the
>> +         * timestamp which we are currently handling.
>> +         */
>> +        data->old_timestamp += sample_period;
>> +
>> +        iio_push_to_buffers_with_timestamp(idev, &buffer,
>> +                           data->old_timestamp);
>> +    }
>> +    /* Reading the FIFO_LVL closes the FIFO access sequence */
>> +    warn = regmap_read(data->regmap, BM1390_REG_FIFO_LVL, &smp_lvl);
>> +    if (warn)
>> +        dev_warn(data->dev, "Closing FIFO sequence failed\n");
>> +
>> +    if (!ret)
> 
> if (ret)?
> If done on purpose "return 0;" would be more explicit.
> 

I'm having a deja-vu. I may have missed similar comment when fixing 
things mentioned by Andy... I'll revise this - thanks!

>> +        return ret;
>> +
>> +    return smp_lvl;
>> +}
> 
> ...
> 
>> +static int bm1390_setup_trigger(struct bm1390_data *data, struct 
>> iio_dev *idev,
>> +                int irq)
>> +{
>> +    struct iio_trigger *itrig;
>> +    char *name;
>> +    int ret;
>> +
>> +    /* Nothing to do if we don't have IRQ for data-ready and WMI */
>> +    if (irq < 0)
>> +        return 0;
>> +
>> +    ret = devm_iio_triggered_buffer_setup(data->dev, idev,
>> +                          &iio_pollfunc_store_time,
>> +                          &bm1390_trigger_handler,
>> +                          &bm1390_buffer_ops);
>> +
>> +    if (ret)
>> +        return dev_err_probe(data->dev, ret,
>> +                     "iio_triggered_buffer_setup FAIL\n");
>> +
>> +    itrig = devm_iio_trigger_alloc(data->dev, "%sdata-rdy-dev%d", 
>> idev->name,
>> +                        iio_device_id(idev));
>> +    if (!itrig)
>> +        return -ENOMEM;
>> +
>> +    data->trig = itrig;
>> +    idev->available_scan_masks = bm1390_scan_masks;
>> +
>> +    itrig->ops = &bm1390_trigger_ops;
>> +    iio_trigger_set_drvdata(itrig, data);
>> +
>> +    name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-bm1390",
>> +                  dev_name(data->dev));
> 
> Missing NULL check?

Actually not. If name is NULL, the dev_name() will be used by the 
(devm_)request_threaded_irq(). I actually used to have a comment 
mentioning this but I was told the comment was longer than the NULL check...
...which was true. Still, the comment won't get compiled to code so I 
liked it more than the check.

Problem I have with the check is that this alloc returning NULL is 
extremely unlikely. So, it is going to be useless most of (all?) the 
time. And - if we for some reason did get NULL here - then it would not 
cause problems as the devm_request_threaded_irq() can handle NULL just fine.

I think Jonathan did also ask for this check to be added, so it is 
likely I am forced to do so even if I don't like it :) Still, in my 
books, the NULL check here is useless code.

> 
>> +
>> +    ret = devm_request_threaded_irq(data->dev, irq, bm1390_irq_handler,
>> +                    &bm1390_irq_thread_handler,
>> +                    IRQF_ONESHOT, name, idev);
>> +    if (ret)
>> +        return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
>> +
>> +
>> +    ret = devm_iio_trigger_register(data->dev, itrig);
>> +    if (ret)
>> +        return dev_err_probe(data->dev, ret,
>> +                     "Trigger registration failed\n");
>> +
>> +    return 0;

Thanks for taking the time to do the review! Much appreciated!

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

