Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDA07C4905
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjJKFH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjJKFH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:07:57 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC64B94;
        Tue, 10 Oct 2023 22:07:55 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c17de836fbso82196601fa.1;
        Tue, 10 Oct 2023 22:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697000874; x=1697605674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/x9+ee3pyyUik6kdeLxpDUVgAJbLivuS3wpi5deOsCA=;
        b=AHF0XyBrgOedRHcZppof9PG03549gnP7TVcSP3NUOoAjcLI6mWlYO/AecUaW0e6179
         vOaaZD6BvT9Uw1XyWKlXDJH9IHXaq4CwatAybrxL7NnTci8qJM+KaU0cHeJcw6zL5rzX
         pqf9q3cHfuxa9TjnX7WogtN9c1iEuCjJsqmTJ4OxiTLVgmOxDoOgf1vj38iV0pm0xw9U
         BCKBRbhgh0B8hoT2MajoYS3zqf+CLoWpMOvUlri+98N87dEGSXQ9ahitwFAqlVIZOzvO
         ZBR3RDZXq96fp4JTQuN7WAdPzJTzX5lH+nySEjnImT1FY6gsnNgsU4g5qg0PWuB0YLB/
         2jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697000874; x=1697605674;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/x9+ee3pyyUik6kdeLxpDUVgAJbLivuS3wpi5deOsCA=;
        b=txB50K/nqopsobXn46fbc4Khn6WxYDyIDAcMwGNTrqAvpt4nSNMYAtOs3keYyEJYyY
         IYqougLArJVdE9dBqQXRPGUaVv5QM5E70gQahP9CKgJetgZotQVOdwFtFeNHbHWNk2in
         Qo+crL+63xMR4DLiOKWPh75UdANfYfjGh9fJdG8Mg/RubcfyNBfyM8AfrC2Oaqi2P+jX
         MMcQvTSbZbb7xKDrrLuk59QDL8EUjapa3dcDGkKKRURejqSI5/UTxtOxD416O2Fdi0rg
         kwjR9EtL4qgW9B+3aV6P8pCixH9py3LECcNr+LSHANlWojF9MgXD/juXFDpsXI+of14X
         SVzA==
X-Gm-Message-State: AOJu0YznmEJONLWOnCSkCUlVFr2KtNzJ9H8TboEnaWnDcJh63vDVgetl
        TBwWuEmbfnagXC5zRN54G64QjqIezqg=
X-Google-Smtp-Source: AGHT+IFBrzpiL9nIrnN6c6Zj+ZVO+UtZhFfQnMPFz5LlCHdWptM7X+5O3blgWO1Il4VN7lAzEYkBLw==
X-Received: by 2002:a2e:6e18:0:b0:2c0:a99:68dd with SMTP id j24-20020a2e6e18000000b002c00a9968ddmr17734696ljc.4.1697000873637;
        Tue, 10 Oct 2023 22:07:53 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::7? (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id y8-20020a2e7d08000000b002bf6852d135sm2714737ljc.94.2023.10.10.22.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 22:07:52 -0700 (PDT)
Message-ID: <be915044-f34e-8266-4bff-51364fde90a3@gmail.com>
Date:   Wed, 11 Oct 2023 08:07:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] iio: bu27008: Add processed illuminance channel
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZRq4pdDn6N73n7BO@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
 <20231005161455.22d68c22@jic23-huawei>
 <07d2740d-d251-842c-ad9f-788fd2546110@gmail.com>
 <20231010104037.4c23ba1d@jic23-huawei>
 <4b3d2013-841f-55d1-64ff-54e13b8b52d8@gmail.com>
In-Reply-To: <4b3d2013-841f-55d1-64ff-54e13b8b52d8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 13:01, Matti Vaittinen wrote:
> On 10/10/23 12:40, Jonathan Cameron wrote:
>> On Fri, 6 Oct 2023 08:01:15 +0300
>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>>> On 10/5/23 18:14, Jonathan Cameron wrote:
>>>> On Mon, 2 Oct 2023 15:33:41 +0300
>>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> //snip
> 
>>>>> +static int bu27008_get_rgb_ir(struct bu27008_data *data, unsigned 
>>>>> int *red,
>>>>> +            unsigned int *green, unsigned int *blue, unsigned int 
>>>>> *ir)
>>>>> +{
>>>>> +    int ret, chan_sel, int_time, tmpret, valid;
>>>>> +    __le16 chans[BU27008_NUM_HW_CHANS];
>>>>> +
>>>>> +    chan_sel = BU27008_BLUE2_IR3 << (ffs(data->cd->chan_sel_mask) 
>>>>> - 1);
>>>>> +
>>>>> +    ret = regmap_update_bits(data->regmap, data->cd->chan_sel_reg,
>>>>> +                 data->cd->chan_sel_mask, chan_sel);
>>>>> +    if (ret)
>>>>> +        return ret;
>>>>> +
>>>>> +    ret = bu27008_meas_set(data, true);
>>>>> +    if (ret)
>>>>> +        return ret;
>>>>> +
>>>>> +    ret = bu27008_get_int_time_us(data);
>>>>> +    if (ret < 0)
>>>>> +        int_time = BU27008_MEAS_TIME_MAX_MS;
>>>>> +    else
>>>>> +        int_time = ret / USEC_PER_MSEC;
>>>>> +
>>>>> +    msleep(int_time);
>>>>> +
>>>>> +    ret = regmap_read_poll_timeout(data->regmap, data->cd->valid_reg,
>>>>> +                       valid, (valid & BU27008_MASK_VALID),
>>>>> +                       BU27008_VALID_RESULT_WAIT_QUANTA_US,
>>>>> +                       BU27008_MAX_VALID_RESULT_WAIT_US);
>>>>> +    if (ret)
>>>>> +        goto out;
>>>>> +
>>>>> +    ret = regmap_bulk_read(data->regmap, BU27008_REG_DATA0_LO, chans,
>>>>> +                   sizeof(chans));
>>>>> +    if (ret)
>>>>> +        goto out;
>>>>> +
>>>>> +    *red = le16_to_cpu(chans[0]);
>>>>> +    *green = le16_to_cpu(chans[1]);
>>>>> +    *blue = le16_to_cpu(chans[2]);
>>>>> +    *ir = le16_to_cpu(chans[3]);
>>>>
>>>> I'd be tempted to use an array + definitely pass them as u16 rather
>>>> than unsigned int.
>>>
>>> I'm not really convinced the u16 is better here. We need the 32 bits
>>> later for the calculations - and (afaics) using natural size int for
>>> arguments shouldn't harm. We read the channel data to correct type array
>>> so code should be pretty clear as to what we have in HW.
>>
>> ok.  I don't like lack of range clamping - so at the point of the caller
>> I can't immediately see that these will be sub 16bit value.  Not htat
>> important I guess.
>>
>>>
>>> Also, I think that having an array obfuscates what element is which
>>> channel because these ICs didn't have the 1 to 1 mapping from channel
>>> index to colour. I was thinking of adding a struct for this but decided
>>> to just keep it simple and clear.
>> A struct or array + enum would work.
>> I just don't much like lots of very similar parameters.
> 
> Right. A struct is not a problem. I am less fond with an enum because 
> the HW channel which carries a specific color may change. I think adding 
> an enum which indicates a place where a color is in array may be 
> misleading one to think that HW has a fixed channel (data register 
> address) for a colour. (I think that is quite usual while ICs where one 
> color may be in different channels depending on the config are likely to 
> be rare... I haven't read too many light sensor specs/drivers to know 
> for sure though).
  I should've re-read the whole driver code before replying. I see we 
already have an enum for colours (with comments telling that some of the 
colours do not have fixed channel). So, my point objecting the enum is 
kind of moot. Unfortunately I chose the clear to be before IR, which 
means that if we used existing enum we would have a gap in the array 
(because clear is not used for lux computation). Not sure it matters 
though :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

