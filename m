Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217BD7AA8BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjIVGHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjIVGHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:07:53 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CE5CE;
        Thu, 21 Sep 2023 23:07:47 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b962c226ceso29195331fa.3;
        Thu, 21 Sep 2023 23:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695362865; x=1695967665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O16ReikaJz2n49L73JXzIug6HnXyDxs6O9jZptprnXk=;
        b=T2OFZogvEx1+va7QqEgFyvJvfUJUmavLDNCMHhdWiGisFKB/6OYUi08Yaq6FS/alIx
         p1IOzXyUrel24dK/S/rDrIa/nCPaw5ldwXyBCYqxm/KG4tpkd2Xwb+x0QK0G+dRsU5AN
         lZVcmgcJ108NkIr9tL1yfeSRltppVRl1kXL+E2QCkQbmuByYUOqYSIBm2zluR95daWg/
         wGqAIfhDl5s1TBLhMQYsWJAbGoDk2CS22F8+RGqzd96mRTIN+Y1VyBQ47dpjvgsdIaJi
         CPk+USx4vsWwcycW89RNU/6IzQ1xPOEIym/+ZGgxYiO1MAqO5af1jR3x91MgayC3+jXl
         igFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695362865; x=1695967665;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O16ReikaJz2n49L73JXzIug6HnXyDxs6O9jZptprnXk=;
        b=mvS09wdJEGI4cB88ZdLdOWwsqQy76+VRRXXRVk2pBCdC9jigHcqUbJYivC/fyzFFwf
         s390amdf1pMd438QUHEdxEQIJ8+TyCFzMOIxLn/jSeCrePGoczZzMOufF5eVRZVZX4YZ
         GSUoNQDSBIHtLJnYqBMA4Th+1DLiHrvD/4EZjX+yMtERgKvF/6Y4hv8g39jxZYZmQv6Q
         ACq+w54pNu+qp0O2OymIqIGERarR3vL87BIpkKMzFzozNBrBUn6+5NEih5C4eAJZavvF
         33uoNzLQSWFWSiaMnhcKzphQ+9GvJnSjfXA1ecp+6S/W5mJMgLTWQpe1WhlIw5O0Jz4S
         Th+w==
X-Gm-Message-State: AOJu0YzMpICMqCBxp4uQPL9z5kH2QrFEr0UyCStdiagZy77SaKpIA3QO
        ygMrRGs+qWqPlNn885H2Sah5G0piLZ8=
X-Google-Smtp-Source: AGHT+IHyfIlw8Dd5Q/GKHuqhMuOfqOJrSs8Vyn2Tu/pFSe3x3Js3uZof6ctt/pdhLA8xjwLhjETO5g==
X-Received: by 2002:a2e:9f14:0:b0:2c0:e7c:bf74 with SMTP id u20-20020a2e9f14000000b002c00e7cbf74mr6738929ljk.12.1695362865255;
        Thu, 21 Sep 2023 23:07:45 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id l20-20020a05651c10d400b002c01ff8442fsm746007ljn.130.2023.09.21.23.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 23:07:44 -0700 (PDT)
Message-ID: <a7ee4d4b-ae2c-32fe-e471-5bd67f2bddbf@gmail.com>
Date:   Fri, 22 Sep 2023 09:07:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        ak@it-klinger.de, andriy.shevchenko@linux.intel.com,
        ang.iglesiasg@gmail.com, bbara93@gmail.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        matti.vaittinen@fi.rohmeurope.com, robh+dt@kernel.org
References: <cover.1694760170.git.mazziesaccount@gmail.com>
 <f378a401cec4fb0b9287b52ab159f00dd77569a6.1694760170.git.mazziesaccount@gmail.com>
 <cdc9a8f8-fbd5-1eb3-7bac-1e6e5893bc9b@wanadoo.fr>
 <7ec2ac97-8ee3-186b-ef25-ceb5ec57751a@gmail.com>
 <20230919153251.000024d3@Huawei.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 2/3] iio: pressure: Support ROHM BU1390
In-Reply-To: <20230919153251.000024d3@Huawei.com>
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

On 9/19/23 17:32, Jonathan Cameron wrote:
> 
>>>> +static int bm1390_read_raw(struct iio_dev *idev,
>>>> +               struct iio_chan_spec const *chan,
>>>> +               int *val, int *val2, long mask)
>>>> +{
>>>> +    struct bm1390_data *data = iio_priv(idev);
>>>> +    int ret;
>>>> +
>>>> +    switch (mask) {
>>>> +    case IIO_CHAN_INFO_SCALE:
>>>> +        if (chan->type == IIO_TEMP) {
>>>> +            *val = 31;
>>>> +            *val2 = 250000;
>>>> +
>>>> +            return IIO_VAL_INT_PLUS_MICRO;
>>>> +        } else if (chan->type == IIO_PRESSURE) {
>>>> +            *val = 0;
>>>> +            /*
>>>> +             * pressure in hPa is register value divided by 2048.
>>>> +             * This means kPa is 1/20480 times the register value,
>>>> +             * which equals to 48828.125 * 10 ^ -9
>>>> +             * This is 48828.125 nano kPa.
>>>> +             *
>>>> +             * When we scale this using IIO_VAL_INT_PLUS_NANO we
>>>> +             * get 48828 - which means we lose some accuracy. Well,
>>>> +             * let's try to live with that.
>>>> +             */
>>>> +            *val2 = 48828;
>>>> +
>>>> +            return IIO_VAL_INT_PLUS_NANO;
>>>> +        }
>>>> +
>>>> +        return -EINVAL;
>>>> +    case IIO_CHAN_INFO_RAW:
>>>> +        ret = iio_device_claim_direct_mode(idev);
>>>> +        if (ret)
>>>> +            return ret;
>>>> +
>>>> +        ret = bm1390_read_data(data, chan, val, val2);
>>>> +        iio_device_release_direct_mode(idev);
>>>> +        if (ret)
>>>> +            return ret;
>>>> +
>>>> +        return IIO_VAL_INT;
>>>> +    default:
>>>> +        return -EINVAL;
>>>
>>> Certainly useless, but should we break and return -EINVAL after the
>>> switch, so that it is more explicit that bm1390_read_raw() always
>>> returns a value?
>>
>> I think there is also opposite opinions on this. For my eyes the return
>> at the end of the function would also be clearer - but I think I have
>> been asked to drop the useless return when I've been working with other
>> sensors in IIO domain :) My personal preference would definitely be:
>>
>> int ret;
>>
>> switch (foo)
>> {
>> case BAR:
>> 	ret = func1();
>> 	if (ret)
>> 		break;
>>
>> 	ret = func2();
>> 	if (ret)
>> 		break;
>>
>> ...
>> 	break;
>>
>> case BAZ:
>> 	ret = -EINVAL;
>> 	break;
>> }
>>
>> return ret;
>>
>> - but I've learned to think this is not the IIO preference.
> 
> Some static analyzers get confused (probably when there is a little
> bit more going on after the function) by that and moan that some
> cases are not considered in the switch.  I got annoyed enough with the
> noise they were generating to advocate always having explicit defaults.

Oh, yes. I see I omitted the default from the example - but this was not 
what I tried to highlight ;) With a bit more thought I would've added:

default:
	ret = -EINVAL;
	break;

As you probably guess, what I was after is that for a simple (not deeply 
nested) cases like this, I would rather use a variable for return value 
and a single point of exit at the end of the function - instead of 
having returns in the switch-case. That'd suit better _my_ taste.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

