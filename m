Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2F379A2DA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 07:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjIKFck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 01:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjIKFcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 01:32:39 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF53F1AE;
        Sun, 10 Sep 2023 22:32:34 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b703a0453fso67378131fa.3;
        Sun, 10 Sep 2023 22:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694410353; x=1695015153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehBh9q1f9vB5QhBqVr0ikLRRBvwCGJle+Wl7XRRbw2U=;
        b=sDj9qfm4P9aqN4Yzyy7+XhKsEuFre3ciN42apnlvKu+DDrkSalcVOpB+zSNudsCP0U
         8tM3q88XQIqoUnbQPEu5rLA710uVcmQqOGv6KFiuNQ7mV1KhkkE1REhZxZNKMhDTmi3+
         eqwzy1OTy4BnHGYkJuXIZi1AtRSSqWdswJme2k25B5RVxtegrXdfJ/tlFLeFkf5cBhcg
         g+90pormHJsxtrBfahVOkByd3wc6nCR141Jr31KPKGEFj+8IWVHzmLsbYreqAflVN8Ab
         EcXdfw/DhJsCIF5cBbevOEdBq2ibA70j/6tfaiUT870xfu0Zi8+1zvOVoMAVsVXl4Fi8
         9HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694410353; x=1695015153;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehBh9q1f9vB5QhBqVr0ikLRRBvwCGJle+Wl7XRRbw2U=;
        b=SqtMGxeVfNivxzKSkDzEdyp3v4F/AiFKKL1OIdQHFIgQbLzZ3J+pAtDGysAgE5fOq7
         Bw/1K9BWbY73gaxmPC4RT+qs0WKeZ8tG7yRcLgnkvd3aiE2BdvnXmQcffj+3+FLDaG8S
         yCtAE0QT1gXYMli0h+y/iMxVFXeebZMU0NXBR/lUZEf0l9RtgaoLyjb2WTfvy593+Cru
         AG7qPxuxF1xauoEKuqnXlLPjeAYbQE9G0Kmfbqp73IGnUbVfwFCNvuh7llR7ZG5BF6qx
         Whkny3BfOTkTNjqkfo/tv48nDK4uxSvqmlSPr8is+n84jJ7z9XnWXS6TFsnYksdWvpGB
         3l4A==
X-Gm-Message-State: AOJu0YyFdTkvJm0lB0ht2AaxZhRVVsrDw1+bBD+GjxUpZtCiGBdlszRi
        n9/J5UaNLnKWh/lf5fP8XqI=
X-Google-Smtp-Source: AGHT+IECPUjgSqCzU/Mjsl4nZGR8emUICxoTv0BUjEASbBC2SCyaTHJzZKX1sV/ibaTcJPpeqKYJyg==
X-Received: by 2002:a2e:9609:0:b0:2bc:fd50:573a with SMTP id v9-20020a2e9609000000b002bcfd50573amr7596052ljh.6.1694410352668;
        Sun, 10 Sep 2023 22:32:32 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id n9-20020a2e7209000000b002bcd2653872sm1386326ljc.30.2023.09.10.22.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 22:32:32 -0700 (PDT)
Message-ID: <33073300-e238-0319-0a97-094a25dcf86b@gmail.com>
Date:   Mon, 11 Sep 2023 08:32:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
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
 <eba53e24-ea01-6c38-27ee-27c3d10aa73f@gmail.com>
 <20230908194425.24f1554e@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 2/3] iio: pressure: Support ROHM BU1390
In-Reply-To: <20230908194425.24f1554e@jic23-huawei>
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

On 9/8/23 21:44, Jonathan Cameron wrote:
> On Fri, 8 Sep 2023 09:12:51 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 9/7/23 16:57, Andy Shevchenko wrote:
>>> On Thu, Sep 07, 2023 at 08:57:17AM +0300, Matti Vaittinen wrote:
>>>> On 9/6/23 18:48, Andy Shevchenko wrote:
>>>>> On Wed, Sep 06, 2023 at 03:37:48PM +0300, Matti Vaittinen wrote:
>>>
>>> ...
>>>    
>>>>>> +struct bm1390_data {
>>>>>> +	int64_t timestamp, old_timestamp;
>>>>>
>>>>> Out of a sudden int64_t instead of u64?
>>>>
>>>> Judging the iio_push_to_buffers_with_timestamp() and iio_get_time_ns(), IIO
>>>> operates with signed timestamps. One being s64, the other int64_t.
>>>>   
>>>>>> +	struct iio_trigger *trig;
>>>>>> +	struct regmap *regmap;
>>>>>> +	struct device *dev;
>>>>>> +	struct bm1390_data_buf buf;
>>>>>> +	int irq;
>>>>>> +	unsigned int state;
>>>>>> +	bool trigger_enabled;
>>>>>   
>>>>>> +	u8 watermark;
>>>>>
>>>>> Or u8 instead of uint8_t?
>>>>
>>>> So, uint8_t is preferred? I don't really care all that much which of these
>>>> to use - which may even show up as a lack of consistency... I think I did
>>>> use uint8_t when I learned about it - but at some point someone somewhere
>>>> asked me to use u8 instead.. This somewhere might have been u-boot though...
>>>>
>>>> So, are you Suggesting I should replace u8 with uint8_t? Can do if it
>>>> matters.
>>>
>>> Consistency matters, since I do not know the intention behind, I suggest use
>>> either, but be consistent in the entire code. However, uXX are specific Linux
>>> kernel internal types and some maintainers prefer them. Also you may grep for
>>> the frequency of intXX_t vs. sXX or their unsigned counterparts.
>>>    
>>>>>> +	/* Prevent accessing sensor during FIFO read sequence */
>>>>>> +	struct mutex mutex;
>>>>>> +};
>>>
>>> ...
>>>    
>>>>>> +static int bm1390_read_temp(struct bm1390_data *data, int *temp)
>>>>>> +{
>>>>>> +	u8 temp_reg[2] __aligned(2);
>>>>>
>>>>> Why?! Just use proper bitwise type.
>>>>
>>>> What is the proper bitwise type in this case?
>>>>
>>>> I'll explain my reasoning:
>>>> What we really have in hardware (BM1390) and read from it is 8bit registers.
>>>> This is u8 to me. And as we read two consecutive registers, we use u8
>>>> arr[2]. In my eyes it describes the data perfectly well, right?
>>>
>>> Two different registers?! Why bulk is used in that case?
>>> To me looks like you are reading 16-bit (or one that fits in 16-bit) register
>>> in BE notation.
>>
>> As I wrote, it is two 8 bit registers at consecutive addresses. And this
>> is what u8 arr[2]; also says.
>>
>> Bulk read is mandatory as HW has a special feature of preventing the
>> update of these registers when a read is ongoing. If we do two reads we
>> risk of getting one of the registers updated between the accesses -
>> resulting incorrect value.
> 
> Far as the kernel is concerned this is a __be16 and we use a bulk read to
> fill it from two registers.  If the use showed them having unrelated uses
> then it would be fair to handle it as an array of u8.

After you explained me that we don't need the extra hassle with the 
negative values (specific two's complement handling) - I do agree. If we 
needed to check the high bit in reg X to detect if special handling is 
required (as I thought) - then I would have still thought that checking 
the high bit from u8 which matches the spec would be much clearer. But 
yes - in this case, after your explanation - I do agree. Thanks :)

> 
>>
>>>    
>>>>>> +	__be16 *temp_raw;
>>>>>> +	int ret;
>>>>>> +	s16 val;
>>>>>> +	bool negative;
>>>>>> +
>>>>>> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_TEMP_HI, &temp_reg,
>>>>>> +			       sizeof(temp_reg));
>>>>>> +	if (ret)
>>>>>> +		return ret;
>>>>>> +
>>>>>> +	if (temp_reg[0] & 0x80)
>>>>>> +		negative = true;
>>>>>> +	else
>>>>>> +		negative = false;
>>>>>   
>>>>>> +	temp_raw = (__be16 *)&temp_reg[0];
>>>>>
>>>>> Heck no. Make temp_reg be properly typed.
>>>>
>>>> As I explained above, to me it seems ur arr[2} is _the_ proper type to
>>>> represent data we read from the device.
>>>>
>>>> What we need to do is to convert the 16bits of data to an integer we can
>>>> give to the rest of the system. And, we happen to know how to 'manipulate'
>>>> the data to get it in format of understandable integer. As we have these 16
>>>> bits in memory, aligned to 2 byte boundary - why shouldn't we just
>>>> 'manipulate' the data and say - here we have your integer, please be my
>>>> guest and use it?
>>>
>>> Because it smell like a hack and is a hack here.
>>> Either it's a single BE16 register, or it's two different registers that by
>>> very unknown reason you are reading in a bulk.
>>
>> It is two registers. The bulk read might warrant a comment - although I
>> believe this is nothing unusual. If it is a hack or not is an opinion.
>> To me it looks like a code that explicitly shows what data is and how it
>> is being handled. It does what it is supposed to do and shows it in all
>> dirty details.
> 
> Read it directly into a __be16

Yes. This makes sense also to me now that we don't really need the:
 >>>>>> +	if (temp_reg[0] & 0x80)
 >>>>>> +		negative = true;
 >>>>>> +	else
 >>>>>> +		negative = false;

shown above.

> 
>>
>> Still, I am open to suggestions but I'd prefer seeing a real improvement
>> instead of claiming that the hardware is something it is not (eg, having
>> 16bit registers or should be read by individual accesses).
>>
>> The code in this form is no
>>> go.
>>>    
>>>> Well, I am keen to learn the 'correct bitwise type' you talk about - can you
>>>> please explain me what this correct type for two 8bit integers is? Maybe I
>>>> can improve.
>>>
>>> If the registers are not of the same nature the bulk access is wrong.
>>> Use one by one reads.
>>
>> Of same nature? As I said, there is 2 8bit registers at consecutive
>> addresses. They have no other 'nature' as far as I can tell.
>>
>> Data in these registers in not in standard format - it needs to be
>> manipulated to make it an ordinary integer. The code shows this very
>> clearly by not reading it in any standard integer.
> 
> I'm not convinced it does.  All support arch are 2s complement.
> be16_to_cpu() is fine for what you have unless I'm missing something.
> If it weren't we would have signed versions of those macros.

No. You don't miss a thing. I didn't know if it's ok to treat i6bit 
two's complement just as a native 16bit signed integer.

>>> ...
>>>    
>>>>>> +static int bm1390_pressure_read(struct bm1390_data *data, u32 *pressure)
>>>>>> +{
>>>>>> +	int ret;
>>>>>> +	u8 raw[3];
>>>>>> +
>>>>>> +	ret = regmap_bulk_read(data->regmap, BM1390_REG_PRESSURE_BASE,
>>>>>> +			       &raw[0], sizeof(raw));
>>>
>>> &raw[0] --> raw
>>>    
>>>>>> +	if (ret < 0)
>>>>>> +		return ret;
>>>>>> +
>>>>>> +	*pressure = (u32)(raw[2] >> 2 | raw[1] << 6 | raw[0] << 14);
>>>
>>> This, btw, looks like le24, but I'm puzzled with right shift.
>>> I need to read datasheet carefully to understand this.
>>
>> It's not just le24. We, again, have data placed in registers so that it
>> needs some suffling. The data-sheet does decent job explaining it
>> though. AFAIR, there was a 'gap' in bits so it needed some more suffling
>> to sift the bits so that they're consecutive. I think this indeed is
>> something that needs to be looked up from data-sheet to understand why
>> this play with bits is done.
> 
> 
> These cases are harder to argue.  I'm fine with either approach for this one
> as a get_unaligned_le24() >> 2 would give same answer unless I'm also missing
> something but it isn't that obvious.

I need to look at the spec and the get_unaligned_le24() to be able to 
say something :) I wrote this code before my summer holidays but didn't 
have the time to test and send the patches until now. Will get back to 
this IC later this week.

Thanks for the feedback guys!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

