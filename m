Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC877DAD0C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 16:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjJ2PwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 11:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjJ2PwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 11:52:04 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5CEC9;
        Sun, 29 Oct 2023 08:52:00 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso5582038e87.1;
        Sun, 29 Oct 2023 08:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698594719; x=1699199519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfpAEh8BoIp/HuFoXptqqOXSYXjYC1kr/tBCE1qtZIw=;
        b=lrcVkejkc5mQgWaGlEkaoaR9h+yJBKkmiCsXsxBSAX6ikvifWXWrphy6p+WYkNB4u1
         mejedjw4JJGqW5CyPasbZ9k7CTM1bjekB51JDkvCrX3OvvAzd1ng7RrfHRM8NCPwz/fZ
         /nqwNV/yRVo1gh+7ZLtw3/UQOBaYXDw4GHN1kuVjbT9ckdU88HRGs0xq1ihF3G1jqB1Y
         XvJtDE6YtEsOG3JNq4zxp7UzeatiYhOU4SFktQtEJ8fCUQo9ePRCG9rd6qdJ16bW75l0
         Kc60/OsX7ly/Vxn4NhHwsl7BHSInRbXo9Kr3V0BBFRbC8/by0EDa0Fu5cPP90OiKtljo
         L1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698594719; x=1699199519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfpAEh8BoIp/HuFoXptqqOXSYXjYC1kr/tBCE1qtZIw=;
        b=JFouJsPo/fl3dJoHaDJIwSQVfYNVO/ubOPEb0+OnZw3e/yBbdUuPa35NxIbnEPWrkC
         XYeFXpyq6vyVKi7JOmxSMOYUQQiy2M0UhpFTkIH+7iw2Evt7ey3PEzEutWzwhY6LtQoR
         rfhGoanxtW+mFXyZ2T9Yo3M2wuA/JbAAlkrH41RDS6ya7fqaKuwwzEvRi3iRmRraovc7
         tTJuBujARPyLBAnxSBgvpKcPs0DKuB6jIqY0IpuZP67GYxvGoFu2E71yrfoSfZsOtU8Z
         48Mc1pO5qfepEu/jeBS/c6CSt0pcnW7RY3R0d7G16VI+EcbG6seVHfyH6JKHbwhPZyqB
         Ylvg==
X-Gm-Message-State: AOJu0YylIovMVNHUrqTppnsOOqNdWYZYv4D+n4QcoX4hYtlI8afPKtZ9
        97j7Oe8P2T4A3pYdRx68Ios=
X-Google-Smtp-Source: AGHT+IGJTu0y3jbNKHU9AgMSMVu7/hp1EMXzTMU9K5gSj4WdVkEjL7XtEs9ua6/b3CagTCDri4Sjbg==
X-Received: by 2002:a05:6512:2248:b0:4fe:7e7f:1328 with SMTP id i8-20020a056512224800b004fe7e7f1328mr7532556lfu.16.1698594718700;
        Sun, 29 Oct 2023 08:51:58 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id k5-20020ac24f05000000b005091314185asm584392lfr.285.2023.10.29.08.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 08:51:58 -0700 (PDT)
Message-ID: <84d7c283-e8e5-4c98-835c-fe3f6ff94f4b@gmail.com>
Date:   Sun, 29 Oct 2023 17:51:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US, en-GB
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
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20231028162025.4259f1cc@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/23 18:20, Jonathan Cameron wrote:
> On Fri, 27 Oct 2023 18:15:45 +1030
> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
> 
>> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor with als
>> and clear channels with i2c interface. Hardware interrupt configuration is
>> optional. It is a low power device with 20 bit resolution and has
>> configurable adaptive interrupt mode and interrupt persistence mode.
>> The device also features inbuilt hardware gain, multiple integration time
>> selection options and sampling frequency selection options.
> 
> Hi Subhajit,
> 
> 
>>
> Change log below the ---
> 
> We don't generally want to end up with this information in the git log
> and anything above the --- is used for the commit message.
> 
> Note that if you want to keep notes in your local git it is fine adding
> 
> Signed-of-by...
> 
> ---
> 
> Version notes
> etc
> 
> 
> As then git am will drop them anyway when your patches are picked up.
> 
> 
>> v1 -> v2
>> - Renamed probe_new to probe
>> - Removed module id table
>>
>> v0 -> v1
>> - Fixed errors as per previous review
>> - Longer commit messages and descriptions
>> - Updated scale calculations as per iio gts scheme to export proper scale
>>    values and tables to userspace
>> - Removed processed attribute for the same channel for which raw is
>>    provided, instead, exporting proper scale and scale table to userspace so
>>    that userspace can do "(raw + offset) * scale" and derive Lux values
>> - Fixed IIO attribute range syntax
>> - Keeping the regmap lock enabled as the driver uses unlocked regfield
>>    accesses from interrupt handler
>> - Several levels of cleanups by placing guard mutexes in proper places and
>>    returning immediately in case of an error
>> - Using iio_device_claim_direct_mode() during raw reads so that
>>    configurations could not be changed during an adc conversion period
>> - In case of a powerdown error, returning immediately
>> - Removing the definition of direction of the hardware interrupt and
>>    leaving it on to device tree
>> - Adding the powerdown callback after doing device initialization
>> - Removed the regcache_cache_only() implementation
>>
>> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> 

...

> 
>> +static int apds9306_scale_set(struct apds9306_data *data, int val, int val2)
>> +{
>> +	int i, ret, time_sel, gain_sel;
>> +
>> +	/* Rounding up the last digit by one, otherwise matching table fails! */
> 
> Interesting.  Sounds like a question for Matti?

Sounds odd indeed. I assume this happens when scale setting is requested 
using one of the exact values advertised by the available scales from 
the GTS? This does not feel right and the +1 does not ring a bell to me. 
I need to investigate what's going on. It would help if you could 
provide the values used as val and val2 for the setting.

This will take a while from me though - I'll try to get to this next 
week. Thanks for pointing out the anomaly!

> 
>> +	if (val2 % 10)
>> +		val2 += 1;
>> +
>> +	ret = iio_gts_find_gain_sel_for_scale_using_time(&data->gts,
>> +				     data->intg_time_idx, val, val2, &gain_sel);
>> +	if (ret) {
>> +		for (i = 0; i < data->gts.num_itime; i++) {
>> +			time_sel = data->gts.itime_table[i].sel;
>> +
>> +			if (time_sel == data->intg_time_idx)
>> +				continue;
>> +
>> +			ret = iio_gts_find_gain_sel_for_scale_using_time(&data->gts,
>> +						time_sel, val, val2, &gain_sel);
>> +			if (!ret)
>> +				break;
>> +		}
>> +		if (ret)
>> +			return -EINVAL;
>> +
>> +		ret = apds9306_intg_time_set_hw(data, time_sel);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return apds9306_gain_set_hw(data, gain_sel);
>> +}

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

