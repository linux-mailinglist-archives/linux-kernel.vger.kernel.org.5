Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A647BB114
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 07:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjJFFBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 01:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjJFFBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 01:01:21 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90771BF;
        Thu,  5 Oct 2023 22:01:19 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c008042211so20388311fa.2;
        Thu, 05 Oct 2023 22:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696568478; x=1697173278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZH8uAsDsFjlqPdAL3+yVZGxtsgHB50dQvC+iy9zr+A=;
        b=gm9bJcHX43nkJQSMbUXYdA/cDa/F0c6L/u6YIQoMS1pSgvZDKro8VwHDymU4ZQzqPd
         D0yADBNzgrZkGH4pn8PO/xVyTYFIslhvzszR+lN2qv4Bffr/lpcvBOuaQxJzd0iRM+3e
         spr26IqySfiIveJsOHzy8GJr98DCY8Q+27ltdDuAuUTEkxmVJARihAldIc0IWOoZtNDB
         NoZgckQBAywuqN60PYFsGE9Kp/3jk/+XMyr1gItRw5CC+TZZYaF2HKa9b1IhPg+c3OSC
         VdcGtGsuft5fCeHB15siHla6VWErL/QVYanSfihMiIr3Y/5TU9xcJWN8W8j7vBJhcFMI
         M0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696568478; x=1697173278;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZH8uAsDsFjlqPdAL3+yVZGxtsgHB50dQvC+iy9zr+A=;
        b=hQur98wVRNYMhP+bFaqruJTx/c31NgI3WKN+qMC1BBP7lhVZNAvZGm+NwUgrxGk0zQ
         lNzbAUVAOAjPtkpVoAjjO8PLuVODxb6UtAmbAVIAhdYu9QQw35tqUg9XnHhQvfqHUxGk
         vEGiXaM3+7IknUO+IbCG8j/tjkxhngJSpyt/qj3qyFGf9ZlG7A5B86I/T9smbUJ53j0+
         u7Dg9pwpvVhITxX2ajA+1GRfTP5aTrEaEhPdT1BRnJUzyu/aZCPyqj3AjqEiHyzpw4CR
         LLtGvikTAZ9d1ETA3W+h3vHdbKzBwXh2OZaMB24ajfewR7CsPO9wCwPGQOuBXrpDPtZV
         3nCg==
X-Gm-Message-State: AOJu0YwLgufBO6ydV00rwDkz0F5C9jiiR2tRM2qwo/Su9uBBIZotnkX+
        F3xSw82JJw7G2YXvwC0megztnJ3aJ9o=
X-Google-Smtp-Source: AGHT+IFoZq/eJfIr5sxAnqZeyJuI8DYceQse8Eec3/zgP18APTtDaxe7JklEiX6jm2ShsvhuS8z90A==
X-Received: by 2002:a2e:8241:0:b0:2c1:9a8b:f67 with SMTP id j1-20020a2e8241000000b002c19a8b0f67mr6271747ljh.1.1696568477227;
        Thu, 05 Oct 2023 22:01:17 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::7? (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id h15-20020a2eb0ef000000b002bce8404157sm601920ljl.12.2023.10.05.22.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 22:01:16 -0700 (PDT)
Message-ID: <07d2740d-d251-842c-ad9f-788fd2546110@gmail.com>
Date:   Fri, 6 Oct 2023 08:01:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZRq4pdDn6N73n7BO@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
 <20231005161455.22d68c22@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH] iio: bu27008: Add processed illuminance channel
In-Reply-To: <20231005161455.22d68c22@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/23 18:14, Jonathan Cameron wrote:
> On Mon, 2 Oct 2023 15:33:41 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The RGB + IR data can be used to calculate illuminance value (Luxes).
>> Implement the equation obtained from the ROHM HW colleagues and add a
>> light data channel outputting illuminance values in (nano) Luxes.
> Units in the ABI doc for illuminance are Lux, not nanolux.
> I'm guessing that you actually provide it in Lux but via scale.
> 
> Make that clearer in this description if so.

Yep. Also, the "processed" is misleading as I implement a raw channel. I 
did originally think I'll only implement the read_raw (as I thought 
we'll need all RGBC + IR and end up doing two accesses - which wouldn't 
be nice due to the doubled measurement time). I actually did that and 
used INT_PLUS_NANO. While implementing this I noticed the 'clear' data 
was not used - and thought I might as well support buffering when RGB+IR 
are enabled. I needed the scale to get the buffered values to decent 
format though - so I converted channel to raw one and added scale. The 
commit title still contains the 'processed' which reflects the original 
thinking. Thanks for pointing out the confusion.

>> Both the read_raw and buffering values is supported, with the limitation
>> that buffering is only allowed when suitable scan-mask is used. (RGB+IR,
>> no clear).
>>
>> The equation has been developed by ROHM HW colleagues for open air sensor.
>> Adding any lens to the sensor is likely to impact to the used c1, c2, c3
>> coefficients. Also, The output values have only been tested on BU27008.
>>
>> According to the HW colleagues, the very same equation should work also
>> on BU27010.
>>
>> Calculate and output illuminance values from BU27008 and BU27010.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
> 
> A few comments inline, but in general looks fine to me.

Thanks Jonathan. I had to give also the BU27008 sensor away for a while. 
I guess I won't send the next version until I am able to do some very 
basic testing even if the changes were minor. That's probably sometime 
next week.

> 
> Jonathan
> 
>> ---
>>
>> I did very dummy testing at very normal daylight inside a building. No
>> special equipments were used - I simply compared values computed from
>> BU27008 RGB+IR channels, to values displayed by the ALS in my mobile
>> phone. Results were roughly the same (around 400 lux). Couldn't repeat
>> test on BU27010, but the data it outputs should be same format as
>> BU27008 data so equation should work for both sensors.
>> ---
>>   drivers/iio/light/rohm-bu27008.c | 216 ++++++++++++++++++++++++++++++-
>>   1 file changed, 211 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu27008.c
>> index 6a6d77805091..d480cf761377 100644
>> --- a/drivers/iio/light/rohm-bu27008.c
>> +++ b/drivers/iio/light/rohm-bu27008.c
>> @@ -130,6 +130,7 @@
>>    * @BU27008_BLUE:	Blue channel. Via data2 (when used).
>>    * @BU27008_CLEAR:	Clear channel. Via data2 or data3 (when used).
>>    * @BU27008_IR:		IR channel. Via data3 (when used).
>> + * @BU27008_LUX:	Illuminance channel, computed using RGB and IR.
>>    * @BU27008_NUM_CHANS:	Number of channel types.
>>    */
>>   enum bu27008_chan_type {
>> @@ -138,6 +139,7 @@ enum bu27008_chan_type {
>>   	BU27008_BLUE,
>>   	BU27008_CLEAR,
>>   	BU27008_IR,
>> +	BU27008_LUX,
>>   	BU27008_NUM_CHANS
>>   };
>>   
>> @@ -172,6 +174,8 @@ static const unsigned long bu27008_scan_masks[] = {
>>   	ALWAYS_SCANNABLE | BIT(BU27008_CLEAR) | BIT(BU27008_IR),
>>   	/* buffer is R, G, B, IR */
>>   	ALWAYS_SCANNABLE | BIT(BU27008_BLUE) | BIT(BU27008_IR),
>> +	/* buffer is R, G, B, IR, LUX */
>> +	ALWAYS_SCANNABLE | BIT(BU27008_BLUE) | BIT(BU27008_IR) | BIT(BU27008_LUX),
>>   	0
>>   };
>>   
>> @@ -331,6 +335,19 @@ static const struct iio_chan_spec bu27008_channels[] = {
>>   	 * Hence we don't advertise available ones either.
>>   	 */
>>   	BU27008_CHAN(IR, DATA3, 0),
>> +	{
>> +		.type = IIO_LIGHT,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +				      BIT(IIO_CHAN_INFO_SCALE),
>> +		.channel = BU27008_LUX,
>> +		.scan_index = BU27008_LUX,
>> +		.scan_type = {
>> +			.sign = 'u',
>> +			.realbits = 64,
>> +			.storagebits = 64,
>> +			.endianness = IIO_CPU,
>> +		},
>> +	},
>>   	IIO_CHAN_SOFT_TIMESTAMP(BU27008_NUM_CHANS),
>>   };
>>   
>> @@ -1004,6 +1021,183 @@ static int bu27008_read_one(struct bu27008_data *data, struct iio_dev *idev,
>>   	return ret;
>>   }
>>   
>> +static int bu27008_get_rgb_ir(struct bu27008_data *data, unsigned int *red,
>> +		    unsigned int *green, unsigned int *blue, unsigned int *ir)
>> +{
>> +	int ret, chan_sel, int_time, tmpret, valid;
>> +	__le16 chans[BU27008_NUM_HW_CHANS];
>> +
>> +	chan_sel = BU27008_BLUE2_IR3 << (ffs(data->cd->chan_sel_mask) - 1);
>> +
>> +	ret = regmap_update_bits(data->regmap, data->cd->chan_sel_reg,
>> +				 data->cd->chan_sel_mask, chan_sel);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = bu27008_meas_set(data, true);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = bu27008_get_int_time_us(data);
>> +	if (ret < 0)
>> +		int_time = BU27008_MEAS_TIME_MAX_MS;
>> +	else
>> +		int_time = ret / USEC_PER_MSEC;
>> +
>> +	msleep(int_time);
>> +
>> +	ret = regmap_read_poll_timeout(data->regmap, data->cd->valid_reg,
>> +				       valid, (valid & BU27008_MASK_VALID),
>> +				       BU27008_VALID_RESULT_WAIT_QUANTA_US,
>> +				       BU27008_MAX_VALID_RESULT_WAIT_US);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = regmap_bulk_read(data->regmap, BU27008_REG_DATA0_LO, chans,
>> +			       sizeof(chans));
>> +	if (ret)
>> +		goto out;
>> +
>> +	*red = le16_to_cpu(chans[0]);
>> +	*green = le16_to_cpu(chans[1]);
>> +	*blue = le16_to_cpu(chans[2]);
>> +	*ir = le16_to_cpu(chans[3]);
> 
> I'd be tempted to use an array + definitely pass them as u16 rather
> than unsigned int.

I'm not really convinced the u16 is better here. We need the 32 bits 
later for the calculations - and (afaics) using natural size int for 
arguments shouldn't harm. We read the channel data to correct type array 
so code should be pretty clear as to what we have in HW.

Also, I think that having an array obfuscates what element is which 
channel because these ICs didn't have the 1 to 1 mapping from channel 
index to colour. I was thinking of adding a struct for this but decided 
to just keep it simple and clear.

>> +
>> +out:
>> +	tmpret = bu27008_meas_set(data, false);
>> +	if (tmpret)
>> +		dev_warn(data->dev, "Stopping measurement failed\n");
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>> + * Following equation for computing lux out of register values was given by
>> + * ROHM HW colleagues;
>> + *
>> + * Red = RedData*1024 / Gain * 20 / meas_mode
>> + * Green = GreenData* 1024 / Gain * 20 / meas_mode
>> + * Blue = BlueData* 1024 / Gain * 20 / meas_mode
>> + * IR = IrData* 1024 / Gain * 20 / meas_mode
>> + *
>> + * where meas_mode is the integration time in mS / 10
>> + *
>> + * IRratio = (IR > 0.18 * Green) ? 0 : 1
>> + *
>> + * Lx = max(c1*Red + c2*Green + c3*Blue,0)
>> + *
>> + * for
>> + * IRratio 0: c1 = -0.00002237, c2 = 0.0003219, c3 = -0.000120371
>> + * IRratio 1: c1 = -0.00001074, c2 = 0.000305415, c3 = -0.000129367
>> + */
>> +
>> +/*
>> + * The max chan data is 0xffff. When we multiply it by 1024 * 20, we'll get
>> + * 0x4FFFB000 which still fits in 32-bit integer. So this can't overflow.
>> + */
>> +#define NORM_CHAN_DATA_FOR_LX_CALC(chan, gain, time) ((chan) * 1024 * 20 / \
>> +				   (gain) / (time))
>> +static u64 bu27008_calc_nlux(struct bu27008_data *data, unsigned int red,
>> +		unsigned int green, unsigned int blue,  unsigned int ir,
>> +		unsigned int gain, unsigned int gain_ir, unsigned int time)
>> +{
>> +	s64 c1, c2, c3, nlux;
>> +
>> +	time /= 10000;
>> +	ir = NORM_CHAN_DATA_FOR_LX_CALC(ir, gain_ir, time);
>> +	red = NORM_CHAN_DATA_FOR_LX_CALC(red, gain, time);
>> +	green = NORM_CHAN_DATA_FOR_LX_CALC(green, gain, time);
>> +	blue = NORM_CHAN_DATA_FOR_LX_CALC(blue, gain, time);

> I'd prefer to see the inputs parameters and the normalized version given different
> names. Also the inputs are still u16, so nice to reflect that here.

So, you suggest we bring the data as u16 until here and only here we 
assign it into 32bit variables when doing the 'normalization'? I'm sure 
it works, but I dislike doing computations like multiplying u16 by u32 
as I never know (out of my head) how the implicit type conversions work 
and if we get some results cropped. Adding the casts to computation make 
it less pretty for my eyes while having all variables in large enough 
types does not leave me wondering if it works correctly and if explicit 
casts are needed.

I am not strongly opposing this though if you insist - I am sure I can 
at the end of the day get the code right - but I am afraid I will later 
look at the code and wonder if it contains hideous issues...

> Also when doing normalization I'd used fixed with types so there is no
> confusion over what was intended (here u32)

Ok.

> 
>> +
>> +	if ((u64)ir * 100LLU > 18LLU * (u64)green) {
> 
> Putting scaling for ir to the right and green to the left is
> unusual. I'd chose one side and stick to it.

Sorry Jonathan. I must be a bit slow today but I just seem to not be 
able to think how you would like to have this? I think this line is 
somehow mappable to the:

IRratio = (IR > 0.18 * Green) ? 0 : 1
formula I got from HW colleagues and added in the comment preceding the 
function.

> 
>> +		c1 = -22370;
>> +		c2 = 321900;
>> +		c3 = -120371;
>> +	} else {
>> +		c1 = -10740;
>> +		c2 = 305415;
>> +		c3 = -129367;
>> +	}
>> +	nlux = c1 * red + c2 * green + c3 * blue;
>> +	if (nlux < 0)
>> +		nlux = 0;
> 
> 	return max(0, nlux); is a bit neater and makes
> it clear this is simple clamping to possible values given unlikely we'll see
> negative light sources :)

Ok. I should've remembered how you prefered max()/min() when clamping :)

>> +
>> +	return nlux;
>> +}
>> +
>> +static int bu27008_get_time_n_gains(struct bu27008_data *data,
>> +		unsigned int *gain, unsigned int *gain_ir, unsigned int *time)
>> +{
>> +	int ret;
>> +
>> +	ret = bu27008_get_gain(data, &data->gts, gain);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = bu27008_get_gain(data, &data->gts_ir, gain_ir);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = bu27008_get_int_time_us(data);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Max integration time is 400000i. Fits in signed int. */
>> +	*time = ret;
>> +
>> +	return 0;
>> +}
>> +
>> +struct bu27008_buf {
>> +	__le16 chan[BU27008_NUM_HW_CHANS];
>> +	u64 lux __aligned(8);
>> +	s64 ts __aligned(8);
>> +};
>> +
>> +static int bu27008_buffer_get_lux(struct bu27008_data *data,
>> +				  struct bu27008_buf *raw)
>> +{
>> +	unsigned int red, green, blue, ir, gain, gain_ir, time;
>> +	int ret;
>> +
>> +	red = le16_to_cpu(raw->chan[0]);
>> +	green = le16_to_cpu(raw->chan[1]);
>> +	blue = le16_to_cpu(raw->chan[2]);
>> +	ir = le16_to_cpu(raw->chan[3]);
>> +	ret = bu27008_get_time_n_gains(data, &gain, &gain_ir, &time);
>> +	if (ret)
>> +		return ret;
>> +
>> +	raw->lux = bu27008_calc_nlux(data, red, green, blue, ir, gain, gain_ir,
>> +				     time);
> 
> Probably call this function *fill_in_lux() or something like that because I'd expect
> a *get_lux() function to return the lux value.
> 

Ok. Makes sense.

Thanks for the review again!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

