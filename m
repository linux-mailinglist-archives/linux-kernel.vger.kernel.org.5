Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF857DC813
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjJaIVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjJaIVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:21:14 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B66C1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:21:06 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5ab53b230f1so3758796a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1698740466; x=1699345266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dodGbF59n5T1NWE+xJ3J7t+KFbgIak7MaAgmXTbF9ZQ=;
        b=FkY6IgbN41oHB70JJu48+ptlvZj4f0gQGP0lYGXBnM0tHoSQrc88CivX7dFqieG+Dc
         CZJmEvRcEd9FA5dRlI1MxRkH8ci5f832FyTyFkUK9OxARe31ml8s8oyZvMazAK/dotz0
         1sSoaJ51GRUf4BMk0EOGZfT0g5SJyAAUlvmszHBXCUwwccVcoOd1HwVRSTu4PyTpn516
         +mGJWVfkLgJNCIWQzHnu6fF024kNtQpnHJetbxG3zqyUKAJMZ3MJmy7pmDacakaTrqoW
         vpBC4BoaQipwrOYPwhBAu3SikwA/lj90uvAG+rI6vpc0NEf5K2dyjeB2W7JVvmo84c2m
         T/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698740466; x=1699345266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dodGbF59n5T1NWE+xJ3J7t+KFbgIak7MaAgmXTbF9ZQ=;
        b=hYxVMtmSDSsLSKkEEBdky9BzZx5vyHvGkCoh11PMyfWFgsWLpPoJrhwaS07uBSiMDj
         EIfABDKgfhsY8vtcHYl3yCZabHh5ImdUlsGrhOWHDouKpOpktuJeMLrFp0VTOZLJ5azd
         TNptRhi3+C7GqmkulpfF/sXMQtPCMxfqIaX0tRYVIItSQ1IkQoRPPl7c6DfvhyFPOdCk
         q9aha+pnLC5jiuWRohvrv7kaN+mRNBnJpUW9uF+ce5J3AnvcTW0PNh+5c/BWMKDpX+f+
         ExG8I7kFfOwX2ti5G6o7TeoKIiLja34ciyjRM7ZXV53DijCm1RXeZBAd62LWewb1xIZb
         aVig==
X-Gm-Message-State: AOJu0Yy7LU5sSf+TrxLEF/xwMJ3tNjz18I43liAex3E5LaqL1hqDz/eq
        W5M/z0pdO2K39j1RP0UmitY0yQ==
X-Google-Smtp-Source: AGHT+IG4EJTi8VZP/WCOxkSmv/vX20W/yeyFebjc5Y1wyIOtfDVwbVozwbG+20UB1CLUyYHBcv0xJg==
X-Received: by 2002:a05:6a20:8e0b:b0:14c:a53c:498c with SMTP id y11-20020a056a208e0b00b0014ca53c498cmr12059510pzj.10.1698740466113;
        Tue, 31 Oct 2023 01:21:06 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:d7db:fc6b:2721:a9be? (2403-580d-82f4-0-d7db-fc6b-2721-a9be.ip6.aussiebb.net. [2403:580d:82f4:0:d7db:fc6b:2721:a9be])
        by smtp.gmail.com with ESMTPSA id ei56-20020a056a0080f800b00690c52267easm740206pfb.40.2023.10.31.01.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 01:21:05 -0700 (PDT)
Message-ID: <8ccd2d84-4422-4bc0-83a7-13a8c103e5e9@tweaklogic.com>
Date:   Tue, 31 Oct 2023 18:50:58 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
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
 <6a697c62-6a7c-4b31-bc8e-10f40db0363d@gmail.com>
 <d528b45c-123d-4ef7-b110-7efbfef91bc5@gmail.com>
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <d528b45c-123d-4ef7-b110-7efbfef91bc5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/23 17:41, Matti Vaittinen wrote:
> On 10/30/23 12:21, Matti Vaittinen wrote:
>> Hi dee Ho peeps,
>>
>> On 10/29/23 17:51, Matti Vaittinen wrote:
>>> On 10/28/23 18:20, Jonathan Cameron wrote:
>>>> On Fri, 27 Oct 2023 18:15:45 +1030
>>>> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
>>>>
>>>>> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor with als
>>>>> and clear channels with i2c interface. Hardware interrupt configuration is
>>>>> optional. It is a low power device with 20 bit resolution and has
>>>>> configurable adaptive interrupt mode and interrupt persistence mode.
>>>>> The device also features inbuilt hardware gain, multiple integration time
>>>>> selection options and sampling frequency selection options.
> 
> ...
> 
>>>>> +static int apds9306_scale_set(struct apds9306_data *data, int val, int val2)
>>>>> +{
>>>>> +    int i, ret, time_sel, gain_sel;
>>>>> +
>>>>> +    /* Rounding up the last digit by one, otherwise matching table fails! */
>>>>
>>>> Interesting.  Sounds like a question for Matti?
>>>
>>> Sounds odd indeed. I assume this happens when scale setting is requested using one of the exact values advertised by the available scales from the GTS? This does not feel right and the +1 does not ring a bell to me. I need to investigate what's going on. It would help if you could provide the values used as val and val2 for the setting.
>>>
>>> This will take a while from me though - I'll try to get to this next week. Thanks for pointing out the anomaly!
>>>
>>
>> I think I have a rough understanding. I did a Kunit test which goes through all the available scales values from the gts->avail_all_scales_table and all integration times, and feeds them to the logic below. It seems the first culprit is hit by:
>> val = 0, val2 = 125025502.
>>
>> Problem is that the 125025502 is rounded. The exact linearized NANO scale resulting from time multiplier 128, gain multiplier 1 is 125025502.5 - which means we will see rounding.
>>
>>>>
>>>>> +    if (val2 % 10)
>>>>> +        val2 += 1;
>>
>> For a while I was unsure if this check works for all cases because I see linearized scales:
>> 250051005 - multipliers 1x, 64x
>> 83350335 - multipliers 3x, 64x and 6x, 32x
>> 27783445 - multipliers 9x, 64x.
>>
>> For those we will get + 1 added to val2 even though there is no rounding. It appears this is not a problem because the iio_gts_get_gain() (which is used to figure out the required total gain to get the desired scale) does not require the scale to be formed by exact multiples of gain.
> 
> ...
> 
>> I think it would be very nice if the gts-helpers could do the rounding when computing the available scales, but that'd require some thinking. Fixup patch is still very welcome ;)
> 
> I did some further experimenting. Basically, I did a "hack" which always rounds up the available-scales values if division results a remainder. This way the values advertised by the available_scales did find the matching table.
> 
> It is a tiny bit icky because for example the scale 6945861.25 becomes 6945862 in available-scales. Also, I assume that if we "hack" just the available-scales and don't fix the rest of the logic, setting 6945862 will read back as 6945861 (I haven't tested this though). Also, the 20837583.75 will be 20837583 in available-scales but 20837582 when read back, resulting small error. (I haven't tested this either but I assume the current GTS code is flooring the 20837583.75 to 20837583.
> 
> I am wondering if changing the iio_gts_get_gain() to do rounding instead of flooring and changing also the iio_gts_total_gain_to_scale() to something like:
> 
> int iio_gts_total_gain_to_scale(struct iio_gts *gts, int total_gain,
>                  int *scale_int, int *scale_nano)
> {
>      u64 tmp;
>      int rem;
> 
>      tmp = gts->max_scale;
> 
>      rem = do_div(tmp, total_gain);
>      if (total_gain > 1 && rem >= total_gain / 2)
>          tmp += 1ULL;
> 
>      return iio_gts_delinearize(tmp, NANO, scale_int, scale_nano);
> }
> 
> would do the trick. It's just that I'm a bit afraid of touching the iio_gts_get_gain() - by the very least I need to fire up the GTS tests which I implemented but are not in-tree due to the test-device dependency... :/
> 
> Any thoughts?
> 
Hi Matti,
Sorry, got busy with my full time job.
It's nice to see that you have found the issue without my test results:)

Please find below my tests -

root@stm32mp1:/sys/bus/iio/devices/iio:device1# cat scale_available
14.009712000 4.669904000 2.334952000 1.751214000 1.556634666 0.875607000 0.778317333 0.583738000 0.437803500 0.291869000 0.218901750 0.194579333 0.145934500 0.109450875 0.097289666 0.072967250 0.048644833 0.036483625
0.024322416 0.018241812 0.012161208 0.006080604
root@stm32mp1:/sys/bus/iio/devices/iio:device1# echo 0.875607000 > scale ## This works
root@stm32mp1:/sys/bus/iio/devices/iio:device1# echo 0.097289666 > scale ## This fails
root@stm32mp1:/sys/bus/iio/devices/iio:device1# echo 0.097289667 > scale ## However if I add 1, it works! I figured, its a rounding issue so used this trick: "if (val2 % 10) val2 += 1;"
I am sorry, I haven't gone through the full gts internals and only used your driver as a reference to understand it's implementation. I do not have any thoughts on top of my head now but let me go through the code.
   
Regards,
Subhajit Ghosh








