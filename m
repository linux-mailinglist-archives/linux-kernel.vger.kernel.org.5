Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A134798218
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 08:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbjIHGNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 02:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjIHGM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:12:59 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04D219A6;
        Thu,  7 Sep 2023 23:12:54 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-501bd7711e8so2949399e87.1;
        Thu, 07 Sep 2023 23:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694153573; x=1694758373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=poqBFblIGkZYzM95ib/AwQKqF/vFUuMutfef2/uB2EU=;
        b=GFkVe4996Iim7FWhsu8ucAQOevN2cZlQ0LSaNhTig2dx3MoyaNBfX4WLTBeTc74NKE
         45WVq53lFOtyoZN/aStE4dXopZ4gGtLYx+5MLOrwg25ERqa4mnNfbrisYNG1Bik9+5v/
         GMr2qbEIaml3+Pg/FLy66JHKXFvgfMPL4Z6EEtpDzW8KKvaIQ71IoGHqfVfl/7wq2Lv2
         mVPdvRhIUHQ+Vpv5QadYnoBt/MpItxfLH1nYPJ12Qkl4+DuHpP5D94dYkG0YLxHSsn7H
         RSlMe39TugdNKbUqqHgQirq73nAOmfVbiICJrmBfGVFmwG6SInWSx/D7DAviXPuTHM3j
         lq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694153573; x=1694758373;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=poqBFblIGkZYzM95ib/AwQKqF/vFUuMutfef2/uB2EU=;
        b=Nusq3yTR0rw1mBTFBqHDRMw6BGpxNyjREAOEcfi8QRbFyf9WnjIrbU1KnYa+RfPMb6
         QJrheL7y42F00xoWJGfZW1Kg7Y/Zv1oqeKLp9o7HO+ZT9Yjs/bu4cb2mz6o+XwMHF0BA
         4ixg9zN3VJLMYsNgw9TbjCKUzdU+BTjgND/DurapvHeokQnKxk2OmpZcz2L3OlIJi/P/
         j5AY9qVuzQUBuMUUofSZYkdGRGyfCLD/m6y1AHduhH8QLWfjyAV/87hr0SZ70s8XxUt6
         VCarzz/igfCJo9Ap/ebQmLDMkjDVKhgKHtDnRY4XcDr6rCx8eTRo1Tc9Uhskqmhg/cxE
         3HCA==
X-Gm-Message-State: AOJu0YwrpnIlY1ZLAMCY3PQRzog0+oRvn0ljbdtdHV1Bi2hRQ0HHAEqv
        4sT+TSYf28rYVb9InIOChbA=
X-Google-Smtp-Source: AGHT+IHJtcRO66AE8lCaGQ76m7Iw8n1Z70sii4yozRD4RYJzuVX0lQnYKE0Eu//9CyZG44IJqEtIDg==
X-Received: by 2002:a05:6512:1599:b0:500:bb99:69a7 with SMTP id bp25-20020a056512159900b00500bb9969a7mr1259039lfb.14.1694153572630;
        Thu, 07 Sep 2023 23:12:52 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::3? (dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::3])
        by smtp.gmail.com with ESMTPSA id i27-20020ac2523b000000b00501bd55f74csm175011lfl.209.2023.09.07.23.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 23:12:52 -0700 (PDT)
Message-ID: <eba53e24-ea01-6c38-27ee-27c3d10aa73f@gmail.com>
Date:   Fri, 8 Sep 2023 09:12:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, en-GB
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
 <4d8e2873-49bc-8314-ee16-dd327a92898d@gmail.com>
 <ZPnW38eO6by1NjIr@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 2/3] iio: pressure: Support ROHM BU1390
In-Reply-To: <ZPnW38eO6by1NjIr@smile.fi.intel.com>
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

On 9/7/23 16:57, Andy Shevchenko wrote:
> On Thu, Sep 07, 2023 at 08:57:17AM +0300, Matti Vaittinen wrote:
>> On 9/6/23 18:48, Andy Shevchenko wrote:
>>> On Wed, Sep 06, 2023 at 03:37:48PM +0300, Matti Vaittinen wrote:
> 
> ...
> 
>>>> +struct bm1390_data {
>>>> +	int64_t timestamp, old_timestamp;
>>>
>>> Out of a sudden int64_t instead of u64?
>>
>> Judging the iio_push_to_buffers_with_timestamp() and iio_get_time_ns(), IIO
>> operates with signed timestamps. One being s64, the other int64_t.
>>
>>>> +	struct iio_trigger *trig;
>>>> +	struct regmap *regmap;
>>>> +	struct device *dev;
>>>> +	struct bm1390_data_buf buf;
>>>> +	int irq;
>>>> +	unsigned int state;
>>>> +	bool trigger_enabled;
>>>
>>>> +	u8 watermark;
>>>
>>> Or u8 instead of uint8_t?
>>
>> So, uint8_t is preferred? I don't really care all that much which of these
>> to use - which may even show up as a lack of consistency... I think I did
>> use uint8_t when I learned about it - but at some point someone somewhere
>> asked me to use u8 instead.. This somewhere might have been u-boot though...
>>
>> So, are you Suggesting I should replace u8 with uint8_t? Can do if it
>> matters.
> 
> Consistency matters, since I do not know the intention behind, I suggest use
> either, but be consistent in the entire code. However, uXX are specific Linux
> kernel internal types and some maintainers prefer them. Also you may grep for
> the frequency of intXX_t vs. sXX or their unsigned counterparts.
> 
>>>> +	/* Prevent accessing sensor during FIFO read sequence */
>>>> +	struct mutex mutex;
>>>> +};
> 
> ...
> 
>>>> +static int bm1390_read_temp(struct bm1390_data *data, int *temp)
>>>> +{
>>>> +	u8 temp_reg[2] __aligned(2);
>>>
>>> Why?! Just use proper bitwise type.
>>
>> What is the proper bitwise type in this case?
>>
>> I'll explain my reasoning:
>> What we really have in hardware (BM1390) and read from it is 8bit registers.
>> This is u8 to me. And as we read two consecutive registers, we use u8
>> arr[2]. In my eyes it describes the data perfectly well, right?
> 
> Two different registers?! Why bulk is used in that case?
> To me looks like you are reading 16-bit (or one that fits in 16-bit) register
> in BE notation.

As I wrote, it is two 8 bit registers at consecutive addresses. And this 
is what u8 arr[2]; also says.

Bulk read is mandatory as HW has a special feature of preventing the 
update of these registers when a read is ongoing. If we do two reads we 
risk of getting one of the registers updated between the accesses - 
resulting incorrect value.

> 
>>>> +	__be16 *temp_raw;
>>>> +	int ret;
>>>> +	s16 val;
>>>> +	bool negative;
>>>> +
>>>> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp_reg,
>>>> +			       sizeof(temp_reg));
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	if (temp_reg[0] & 0x80)
>>>> +		negative = true;
>>>> +	else
>>>> +		negative = false;
>>>
>>>> +	temp_raw = (__be16 *)&temp_reg[0];
>>>
>>> Heck no. Make temp_reg be properly typed.
>>
>> As I explained above, to me it seems ur arr[2} is _the_ proper type to
>> represent data we read from the device.
>>
>> What we need to do is to convert the 16bits of data to an integer we can
>> give to the rest of the system. And, we happen to know how to 'manipulate'
>> the data to get it in format of understandable integer. As we have these 16
>> bits in memory, aligned to 2 byte boundary - why shouldn't we just
>> 'manipulate' the data and say - here we have your integer, please be my
>> guest and use it?
> 
> Because it smell like a hack and is a hack here.
> Either it's a single BE16 register, or it's two different registers that by
> very unknown reason you are reading in a bulk.

It is two registers. The bulk read might warrant a comment - although I 
believe this is nothing unusual. If it is a hack or not is an opinion. 
To me it looks like a code that explicitly shows what data is and how it 
is being handled. It does what it is supposed to do and shows it in all 
dirty details.

Still, I am open to suggestions but I'd prefer seeing a real improvement 
instead of claiming that the hardware is something it is not (eg, having 
16bit registers or should be read by individual accesses).

The code in this form is no
> go.
> 
>> Well, I am keen to learn the 'correct bitwise type' you talk about - can you
>> please explain me what this correct type for two 8bit integers is? Maybe I
>> can improve.
> 
> If the registers are not of the same nature the bulk access is wrong.
> Use one by one reads.

Of same nature? As I said, there is 2 8bit registers at consecutive 
addresses. They have no other 'nature' as far as I can tell.

Data in these registers in not in standard format - it needs to be 
manipulated to make it an ordinary integer. The code shows this very 
clearly by not reading it in any standard integer.

> ...
> 
>>>> +static int bm1390_pressure_read(struct bm1390_data *data, u32 *pressure)
>>>> +{
>>>> +	int ret;
>>>> +	u8 raw[3];
>>>> +
>>>> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_PRESSURE_BASE,
>>>> +			       &raw[0], sizeof(raw));
> 
> &raw[0] --> raw
> 
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	*pressure = (u32)(raw[2] >> 2 | raw[1] << 6 | raw[0] << 14);
> 
> This, btw, looks like le24, but I'm puzzled with right shift.
> I need to read datasheet carefully to understand this.

It's not just le24. We, again, have data placed in registers so that it 
needs some suffling. The data-sheet does decent job explaining it 
though. AFAIR, there was a 'gap' in bits so it needed some more suffling 
to sift the bits so that they're consecutive. I think this indeed is 
something that needs to be looked up from data-sheet to understand why 
this play with bits is done.

> ...
> 
>>>> +	mutex_lock(&data->mutex);
>>>
>>> Wouldn't you like to start using cleanup.h?
>>
>> The new macro "thingee" for C++ destructor like constructs?
> 
> I was talking about these: guard() / scoped_guard().

Right, this was a bit more precise than "The new macro thingee", thanks 
:) This, however is what I was referring to so what I wrote below still 
applies :)

> 
>> TBH, I am not really in a rush with it for two reasons.
>> 1) The syntax looks very alien to me. I would like to get some time to get
>> used to it before voluntarily ending up maintaining a code using it. (I
>> don't like practicing things upstream as practicing tends to include making
>> more errors).
>>
>> 2. Related to 1). I am not (yet) convinced incorporating changes in stuff
>> using these cleanups is easy. I'm a bit reserved and would like to see how
>> things play out.
>>
>> 3. I expect I will get a few requests to backport the code to some older
>> kernels used by some big customers. (I've been doing plenty of extra work
>> when backporting my kernel improvements like regmap_irq stuff, linear
>> ranges, regulator pickable ranges, gts-helpers to customer kernels to get my
>> drivers working - or working around the lack of thiose features. I have been
>> willing to pay this prize to get those helpers upstream for everyone to use.
>> The cleanup.h however is there so it does not _need_ new users. I don't
>> think _all_ existing drivers will be converted to use it so one more should
>> probably not hurt. I think that in a year at least some customers will be
>> using kernel containing the cleanup.h - so by latest then it is time for me
>> to jump on that train. I hope I am used to reading those macros by then).
> 
> OK.
> 
> ...
> 
>>>> +	case IIO_CHAN_INFO_SCALE:
>>>> +		if (chan->type == IIO_TEMP) {
>>>> +			*val = 31;
>>>> +			*val2 = 250000;
>>>> +
>>>> +			return IIO_VAL_INT_PLUS_MICRO;
>>>> +		} else if (chan->type == IIO_PRESSURE) {
>>>> +			*val = 0;
>>>> +			/*
>>>> +			 * pressure in hPa is register value divided by 2048.
>>>> +			 * This means kPa is 1/20480 times the register value,
>>>> +			 * which equals to 48828.125 * 10 ^ -9
>>>> +			 * This is 48828.125 nano kPa.
>>>> +			 *
>>>> +			 * When we scale this using IIO_VAL_INT_PLUS_NANO we
>>>> +			 * get 48828 - which means we lose some accuracy. Well,
>>>> +			 * let's try to live with that.
>>>> +			 */
>>>> +			*val2 = 48828;
>>>> +
>>>> +			return IIO_VAL_INT_PLUS_NANO;
>>>> +		}
>>>> +
>>>> +		return -EINVAL;
>>>
>>> Why not switch-case like other drivers do?
>>
>> In my eyes avoiding the very simple if - else if does not warrant nested
>> switches which look ugly to me.
> 
> Okay, yet another disagreement.
> 

Yes, we have a few :) Luckily most are more on a styling side of things. 
I do still appreciate you reviewing the patches as I think I do agree 
with most of your suggestions - and having an extra pair of eyes looking 
at the code never hurts :)

> ...
> 
>>>> +	smp_lvl = FIELD_GET(BM1390_MASK_FIFO_LVL, smp_lvl);
>>>
>>>> +
>>>
>>> Unneeded blank line.
>>>
>>>> +	if (smp_lvl > 4) {
>>>> +		/*
>>>> +		 * Valid values should be 0, 1, 2, 3, 4 - rest are probably
>>>> +		 * bit errors in I2C line. Don't overflow if this happens.
>>>> +		 */
>>>> +		dev_err(data->dev, "bad FIFO level %d\n", smp_lvl);
>>>> +		smp_lvl = 4;
>>>> +	}
>>>
>>>> +	if (!smp_lvl)
>>>> +		return ret;
>>>
>>> This can be checked first as it's and error condition
>>
>> I wouldn't say it is an error condition.
> 
> Returning ret suggests otherwise.

Yes. I agree.

> 
>> It just means there was no samples
>> collected in buffer.
> 
> But as you explained below, the code is actually 0 there.
> In any case bailing out conditionals are better to be first.

Kind of agree. Or by very least it should be else if. But as you said, 
early return is probably better here, thanks.

> 
>>   and previous branch has
>>> no side effects on this. Also, wouldn't be better to use error code explicitly?
>>
>> Yes. For the clarity we definitely should explicitly do "return 0" here.
>> Thanks.
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

