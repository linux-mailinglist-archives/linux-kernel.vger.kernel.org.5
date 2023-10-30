Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691B97DB7F5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjJ3KYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjJ3KYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:24:02 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9DB1BCC;
        Mon, 30 Oct 2023 03:21:46 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507a62d4788so6469079e87.0;
        Mon, 30 Oct 2023 03:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698661305; x=1699266105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OAUMPCgb6D0ZoxwJyFkMqL5B4ZYjbLuvm2n3X8foqi8=;
        b=b2bM0yiTMWcPIM8rRsVWy/nIj3OLl6gJvdKZSut6Vx+El7CD4z7olGJiztHokDmpAj
         IDLV031VrvkSHY+02Ol0dgTdJCajrJy3aTnw7prxt40A7lzzxZnJFASVsjqFscc2sNnV
         FsGHq6fxje+Fb3xp5hdYmvBJr0CTmj3nPIcD7+gtKSyCibKc4idUdEHpqt36GY/p7kJY
         c8s6/XMF2/62aHcTODpUYGWkdEcZ24oedAWsRd1AvvEEaZygsfyFVyIkzbZ4/lsG6cjs
         rLkF7N8bZmDs+mFiHuUfthUDEKNv5yQEZ5oFyUlybS00eh3yu0UwIAqY4jHf3u1+b4Ym
         krEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698661305; x=1699266105;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAUMPCgb6D0ZoxwJyFkMqL5B4ZYjbLuvm2n3X8foqi8=;
        b=YlIwQ2pC2BayIAQZh68eK9HVmjZa/atei4FDDBCpzHgiOCHAJm7m9zR3kv25SsmY92
         6kivvS/lEIBidzeFAqynyTFPho/I6U428tL0upxvEIAdNTV/sDjit/ibXGc3eyN/XBeP
         WdYDlqb0iGrKKluHpILw0NOVtKycAuUtwTsc22otahDV6HQJUJw2Kfd7eGcvaA3z5z4H
         VfUERyTLrS9KJFUkYFEA5Zvd7HBSvXCpIV8N6AmOeK2WngOnaSTwmQkN5Rpb+5eHxcKc
         b3n1J5zVBKA7+Po4QAMshPBQBqqDNG127xnyD4WG7A1o6NRIdGMC2x0Jpnss0AcFsPOC
         OeBQ==
X-Gm-Message-State: AOJu0YxfNEVcoeGrrnf+aqAy0Cm/TrmxdKAFiua8h0+Ob+T1H16aWOVq
        QyPmeh+ByXXo+mVPTLI0EEA=
X-Google-Smtp-Source: AGHT+IGreMrOzmQFQCcbd3tYcVtEV2DtIzrTDGcfNDjROOD1K8nCDJSo4hbXGPYapz/fLEvfchyi9Q==
X-Received: by 2002:a05:6512:1114:b0:509:130f:dfa4 with SMTP id l20-20020a056512111400b00509130fdfa4mr5127151lfg.52.1698661304543;
        Mon, 30 Oct 2023 03:21:44 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id g21-20020ac25395000000b00507d219596dsm1395323lfh.268.2023.10.30.03.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 03:21:44 -0700 (PDT)
Message-ID: <6a697c62-6a7c-4b31-bc8e-10f40db0363d@gmail.com>
Date:   Mon, 30 Oct 2023 12:21:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027074545.6055-1-subhajit.ghosh@tweaklogic.com>
 <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
 <20231028162025.4259f1cc@jic23-huawei>
 <84d7c283-e8e5-4c98-835c-fe3f6ff94f4b@gmail.com>
In-Reply-To: <84d7c283-e8e5-4c98-835c-fe3f6ff94f4b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dee Ho peeps,

On 10/29/23 17:51, Matti Vaittinen wrote:
> On 10/28/23 18:20, Jonathan Cameron wrote:
>> On Fri, 27 Oct 2023 18:15:45 +1030
>> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
>>
>>> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor 
>>> with als
>>> and clear channels with i2c interface. Hardware interrupt 
>>> configuration is
>>> optional. It is a low power device with 20 bit resolution and has
>>> configurable adaptive interrupt mode and interrupt persistence mode.
>>> The device also features inbuilt hardware gain, multiple integration 
>>> time
>>> selection options and sampling frequency selection options.
>>
>> Hi Subhajit,
>>
>>
>>>
>> Change log below the ---
>>
>> We don't generally want to end up with this information in the git log
>> and anything above the --- is used for the commit message.
>>
>> Note that if you want to keep notes in your local git it is fine adding
>>
>> Signed-of-by...
>>
>> ---
>>
>> Version notes
>> etc
>>
>>
>> As then git am will drop them anyway when your patches are picked up.
>>
>>
>>> v1 -> v2
>>> - Renamed probe_new to probe
>>> - Removed module id table
>>>
>>> v0 -> v1
>>> - Fixed errors as per previous review
>>> - Longer commit messages and descriptions
>>> - Updated scale calculations as per iio gts scheme to export proper 
>>> scale
>>>    values and tables to userspace
>>> - Removed processed attribute for the same channel for which raw is
>>>    provided, instead, exporting proper scale and scale table to 
>>> userspace so
>>>    that userspace can do "(raw + offset) * scale" and derive Lux values
>>> - Fixed IIO attribute range syntax
>>> - Keeping the regmap lock enabled as the driver uses unlocked regfield
>>>    accesses from interrupt handler
>>> - Several levels of cleanups by placing guard mutexes in proper 
>>> places and
>>>    returning immediately in case of an error
>>> - Using iio_device_claim_direct_mode() during raw reads so that
>>>    configurations could not be changed during an adc conversion period
>>> - In case of a powerdown error, returning immediately
>>> - Removing the definition of direction of the hardware interrupt and
>>>    leaving it on to device tree
>>> - Adding the powerdown callback after doing device initialization
>>> - Removed the regcache_cache_only() implementation
>>>
>>> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
>>
> 
> ...
> 
>>
>>> +static int apds9306_scale_set(struct apds9306_data *data, int val, 
>>> int val2)
>>> +{
>>> +    int i, ret, time_sel, gain_sel;
>>> +
>>> +    /* Rounding up the last digit by one, otherwise matching table 
>>> fails! */
>>
>> Interesting.  Sounds like a question for Matti?
> 
> Sounds odd indeed. I assume this happens when scale setting is requested 
> using one of the exact values advertised by the available scales from 
> the GTS? This does not feel right and the +1 does not ring a bell to me. 
> I need to investigate what's going on. It would help if you could 
> provide the values used as val and val2 for the setting.
> 
> This will take a while from me though - I'll try to get to this next 
> week. Thanks for pointing out the anomaly!
> 

I think I have a rough understanding. I did a Kunit test which goes 
through all the available scales values from the 
gts->avail_all_scales_table and all integration times, and feeds them to 
the logic below. It seems the first culprit is hit by:
val = 0, val2 = 125025502.

Problem is that the 125025502 is rounded. The exact linearized NANO 
scale resulting from time multiplier 128, gain multiplier 1 is 
125025502.5 - which means we will see rounding.

>>
>>> +    if (val2 % 10)
>>> +        val2 += 1;

For a while I was unsure if this check works for all cases because I see 
linearized scales:
250051005 - multipliers 1x, 64x
83350335 - multipliers 3x, 64x and 6x, 32x
27783445 - multipliers 9x, 64x.

For those we will get + 1 added to val2 even though there is no 
rounding. It appears this is not a problem because the 
iio_gts_get_gain() (which is used to figure out the required total gain 
to get the desired scale) does not require the scale to be formed by 
exact multiples of gain.

Still, the check:
 >>> +    if (val2 % 10)
 >>> +        val2 += 1;

seems a bit misleading because only the scales where the NANO accuracy 
is not enough need the + 1. I would at least ask for a comment 
explaining this a bit better :)

Another quick'n dirty way is to simply check if requested scale is one 
of the magic scales where the NANO accuracy is not enough:
41675167(.5)
125025502(.5)
20837583(.75)
13891722(.5)

and handle the rounding only for those (instead of the val2 % 10) - 
still with appropriate comment.

I think it would be very nice if the gts-helpers could do the rounding 
when computing the available scales, but that'd require some thinking. 
Fixup patch is still very welcome ;)

I did avoid this issue with BU27* drivers earlier because I was able to 
select the maximum scale so that the NANO accuracy was enough since I 
used these helpers for the intensity channels.

>>> +
>>> +    ret = iio_gts_find_gain_sel_for_scale_using_time(&data->gts,
>>> +                     data->intg_time_idx, val, val2, &gain_sel);
>>> +    if (ret) {
>>> +        for (i = 0; i < data->gts.num_itime; i++) {
>>> +            time_sel = data->gts.itime_table[i].sel;
>>> +
>>> +            if (time_sel == data->intg_time_idx)
>>> +                continue;
>>> +
>>> +            ret = 
>>> iio_gts_find_gain_sel_for_scale_using_time(&data->gts,
>>> +                        time_sel, val, val2, &gain_sel);
>>> +            if (!ret)
>>> +                break;
>>> +        }
>>> +        if (ret)
>>> +            return -EINVAL;
>>> +
>>> +        ret = apds9306_intg_time_set_hw(data, time_sel);
>>> +        if (ret)
>>> +            return ret;
>>> +    }
>>> +
>>> +    return apds9306_gain_set_hw(data, gain_sel);
>>> +}
> 

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

