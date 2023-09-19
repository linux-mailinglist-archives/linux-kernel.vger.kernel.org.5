Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCD87A612C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjISL2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjISL2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:28:40 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343C6F0;
        Tue, 19 Sep 2023 04:28:34 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bfb12b24e5so88564201fa.0;
        Tue, 19 Sep 2023 04:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695122912; x=1695727712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:references:cc:to:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJtfDjSHeM3hcCE9c1o3c3xw6rFELBnXCLJY5rSxmWs=;
        b=YgdcTGjUzCp6s/zU6F0ed2gSEUVfUoUo4Dl+mZSzh/lXBHhze5dFLTqLCb/3uoiUu5
         K08titw8EHRwmApUxXSj5AoGKlU9lGoOXOssK1f7QvK0JzJcjPIyYbqH0sDREEQbaGFD
         N+50x4+kBx1AqUblPNhj91yq0grluJGS9lHeHaaESkLboEme0yZtLcesRk9/NwoL6EGC
         idBCgGrUPv3c85xK23y8PtnymDplODF72BO39Hg+LM/y2LJuds3NEwdhnsx4/CGgm2Ch
         vcm5RU3aUJ7hOHIVCUnnyMK6ftuiCiT/rq4LC62ECztoHyqqzCp/2VmhVAfHY/RtdnJ1
         2Dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695122912; x=1695727712;
        h=content-transfer-encoding:in-reply-to:subject:references:cc:to:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJtfDjSHeM3hcCE9c1o3c3xw6rFELBnXCLJY5rSxmWs=;
        b=Y/b5h4HvD6+tQ4YAZ/A56nm+ygevSitVgmgBOHYEUikDKJkTnp+5oy7GUoo/RHo4au
         RMhnhkJXZRZAM72vk6SZTeFRjIm0P850bRG9eqVd/jO/W19T54+iDNrPaY/poeBUq++B
         OXDfJp6cDeRJh+S035tyoc3o/eKdzZOSEYtrvco9U617YF5XcHGZyCw/sBaDIeC/EgYW
         PlqALDi+d5fTqIIqcColrqilnWwG1wWCHmRXtpNCfGQ73C7PMm4zEMf/uswbiUrF4E2Q
         2vTPUC8CUS8RQWRNkWhs55h43qMK8IwGlYEPg/IBoDhW9ccnBptgnIhifIZPSt7cbBhz
         gaPA==
X-Gm-Message-State: AOJu0YyKigx63gIrj4OGH3k0AWOjyq4DKS/63BInvkdlEoIraoxm2eKa
        /zbGKsu4iHq83o2uc0Kn6yU=
X-Google-Smtp-Source: AGHT+IGZJ2X24wIhJ/gkDcgzvoKlSt5mlJadrEE5wlsGUVXr4z6cU8uAWZ80S9Q6n1QogDI7bLYF6Q==
X-Received: by 2002:a05:6512:74d:b0:502:9fce:b6db with SMTP id c13-20020a056512074d00b005029fceb6dbmr10532201lfs.1.1695122911676;
        Tue, 19 Sep 2023 04:28:31 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::3? (dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::3])
        by smtp.gmail.com with ESMTPSA id y21-20020ac255b5000000b004fe2e94f8fdsm428752lfg.236.2023.09.19.04.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 04:28:31 -0700 (PDT)
Message-ID: <c987f401-81c4-00e5-51a7-88a6a38a2ca2@gmail.com>
Date:   Tue, 19 Sep 2023 14:28:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Benjamin Bara <bbara93@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1694760170.git.mazziesaccount@gmail.com>
 <f378a401cec4fb0b9287b52ab159f00dd77569a6.1694760170.git.mazziesaccount@gmail.com>
 <20230917113518.7c4bb1a0@jic23-huawei>
 <a5c19874-32ba-60bf-6e72-9139a2873c7e@gmail.com>
Subject: Re: [PATCH v2 2/3] iio: pressure: Support ROHM BU1390
In-Reply-To: <a5c19874-32ba-60bf-6e72-9139a2873c7e@gmail.com>
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

On 9/18/23 15:56, Matti Vaittinen wrote:
> On 9/17/23 13:35, Jonathan Cameron wrote:
>> On Fri, 15 Sep 2023 09:56:19 +0300
>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>>> Support for the ROHM BM1390 pressure sensor. The BM1390GLV-Z can measure
>>> pressures ranging from 300 hPa to 1300 hPa with configurable measurement
>>> averaging and internal FIFO. The sensor does also provide temperature
>>> measurements.
>>>
>>> Sensor does also contain IIR filter implemented in HW. The data-sheet
>>> says the IIR filter can be configured to be "weak", "middle" or
>>> "strong". Some RMS noise figures are provided in data sheet but no
>>> accurate maths for the filter configurations is provided. Hence, the IIR
>>> filter configuration is not supported by this driver and the filter is
>>> configured to the "middle" setting (at least not for now).
>>>
>>> The FIFO measurement mode is only measuring the pressure and not the
>>> temperature. The driver measures temperature when FIFO is flushed and
>>> simply uses the same measured temperature value to all reported
>>> temperatures. This should not be a problem when temperature is not
>>> changing very rapidly (several degrees C / second) but allows users to
>>> get the temperature measurements from sensor without any additional 
>>> logic.
>>>
>>> This driver allows the sensor to be used in two muitually exclusive 
>>> ways,
>>>
>>> 1. With trigger (data-ready IRQ).
>>> In this case the FIFO is not used as we get data ready for each 
>>> collected
>>> sample. Instead, for each data-ready IRQ we read the sample from sensor
>>> and push it to the IIO buffer.
>>>
>>> 2. With hardware FIFO and watermark IRQ.
>>> In this case the data-ready is not used but we enable watermark IRQ. At
>>> each watermark IRQ we go and read all samples in FIFO and push them 
>>> to the
>>> IIO buffer.
>>>
>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

...

>>> +
>>> +static const unsigned long bm1390_scan_masks[] = {
>>> +    BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP), 0
>> Why?  Doesn't look hard to support just one or the other?
>> Normally we only do this sort of limitation when there is a heavily
>> optimized read routine for a set of channels and it is better
>> to grab them all and throw away the ones we don't care about.
>> That doesn't seem to be true here. So if the fifo grabbed both
>> temp and pressure it would makes sense here, but doesn't seem
>> like it does.
> 
> I have a feeling I have misunderstood how this mask works. I have 
> assumed all the channels with corresponding mask bit _can_ be enabled 
> simultaneously, but I have not understood they _must_ all be enabled. I 
> think I must go back studying this, but if all channels really _must_ be 
> enabled, then you are correct. It actually makes a lot of sense to 
> support the pressure values alone, as, according to the data-sheet, the 
> HW is doing a "MEMS temperature compensation" to the pressure values. 
> So, my assuimption is the temperature data may not be required to be 
> captured.
> 
> This also means I should revise the scan masks for the BU27008, BU27010 
> and BU27034 light sensors as I don't think all the users want all the 
> channels enabled. I wonder how I have not noticed any problems when I 
> tested those things - did I really always enable all the channels...? @_@
> 
> Anyways, Thanks.

Hi Jonathan,

There's something in IIO scan_masks / buffer demuxing that I don't quite 
understand. I noticed following things:

1) Strict available scan mask check seems to be in use only for 
INDIO_BUFFER_HARDWARE stuff.

https://elixir.bootlin.com/linux/v6.6-rc2/source/drivers/iio/industrialio-buffer.c#L881

So, the:

 >>> +static const unsigned long bm1390_scan_masks[] = {
 >>> +    BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP), 0

is not exclusive for BM1390 as long as it is not setting the 
INDIO_BUFFER_HARDWARE.

My test seems to agree with the code:

// Only enable the temperature:
root@arm:/sys/bus/iio/devices/iio:device0# echo 1 > 
scan_elements/in_temp_en

// Run the geneeric buffer without -a:
root@arm:/sys/bus/iio/devices/iio:device0# /iio_generic_buffer -c 20 -N 
0 -t bm1390data-rdy-dev0
iio device number being used is 0
iio trigger number being used is 0
/sys/bus/iio/devices/iio:device0 bm1390data-rdy-dev0
23000.000000
23000.000000
23000.000000
23000.000000
23000.000000
23000.000000
23000.000000
23000.000000
23000.000000
22968.750000
23000.000000
23000.000000
23000.000000
23000.000000
23000.000000
23000.000000
23000.000000
23000.000000
23000.000000
23031.250000
23000.000000
23000.000000
root@arm:/sys/bus/iio/devices/iio:device0#

In above case the temperature values and only the temperature values 
were shown. I must admit I did not spend enough time with the 
iio_generic_buffer.c or IIO demuxing code to really understand all the 
details (I got headache very quickly ;) ). I still believe the 
iio_generic_buffer expects to see only the enabled channel data in the 
buffer - so, it seems to me the kernel is also only adding the enabled 
channel data to the buffer. Also, judging the values, the demuxing is 
correctly extracting the temperature data from data the driver pushes here:

iio_push_to_buffers_with_timestamp(idev, &data->buf, data->timestamp);

The bm1390 driver as sent in v2 does not do demuxing but always pushes 
whole chunk of data and trusts IIO to do demuxing.

2) I noticed the 'available_scan_masks' was marked as an optional field. 
So, I think that if there is no restrictions to which of the channels 
can be enabled, then we can omit setting it. This is what I tried.

It appears that when we do not populate the 'available_scan_masks' with the:
 >>> +static const unsigned long bm1390_scan_masks[] = {
 >>> +    BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP), 0

things change. When I tested enabling only temperature and ran the 
iio_generic_buffer -c 20 -N 0 -t bm1390data-rdy-dev0 - the reported 
values seemed completely random.

When I initialized the pressure data in driver:
data->buf.pressure = 1;
before doing the:
iio_push_to_buffers_with_timestamp(idev, &data->buf, data->timestamp);

I saw following:

root@arm:/# cd /sys/bus/iio/devices/iio\:device0
root@arm:/sys/bus/iio/devices/iio:device0# echo 1 > 
scan_elements/in_temp_en
root@arm:/sys/bus/iio/devices/iio:device0# /iio_generic_buffer -c 20 -N 
0 -t bm1390data-rdy-dev0
iio device number being used is 0
iio trigger number being used is 0
/sys/bus/iio/devices/iio:device0 bm1390data-rdy-dev0
8000.000000
8000.000000
8000.000000
8000.000000
8000.000000
8000.000000
8000.000000
8000.000000
8000.000000
8000.000000
8000.000000
8000.000000
8000.000000
8000.000000
8000.000000
8000.000000
8000.000000
8000.000000
8000.000000
8000.000000
root@arm:/sys/bus/iio/devices/iio:device0# cat in_temp_scale
31.250000

If we calculate 8000/31.250000 we will get value 256. This looks like 
value '1' in BE16 format.

Based on this experimenting (and headache obtained from reading the 
demuxing code) - the IIO framework does not do channel demuxing if the 
'available_scan_masks' is not given? To me this was somewhat unexpected.

Finally, when the watermark IRQ is used, we can't omit reading the 
pressure data because clearing the WMI is done based on the pressure 
data in FIFO.

So, I would propose we do:

static const unsigned long bm1390_scan_masks[] = {
	BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP),
	BIT(BM1390_CHAN_PRESSURE), 0

which better reflects what the hardware is capable of - and, unless I am 
missing something, also allows us to offload the buffer demuxing to the IIO.

Still, as mentioned in 1), the

 >>> +static const unsigned long bm1390_scan_masks[] = {
 >>> +    BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP), 0

does not seem to prevent enabling only the temperature channel - so in 
the driver buffer handler we still must unconditionally read the 
pressure data regardles the active_scan_mask.

>>
>>> +     * called as a result of a read operation from userspace and hence
>>> +     * before the watermark interrupt was triggered, take a timestamp
>>> +     * now. We can fall anywhere in between two samples so the error 
>>> in this
>>> +     * case is at most one sample period.
>>> +     * We need to have the IRQ disabled or we risk of messing-up
>>> +     * the timestamps. If we are ran from IRQ, then the
>>> +     * IRQF_ONESHOT has us covered - but if we are ran by the
>>> +     * user-space read we need to disable the IRQ to be on a safe
>>> +     * side. We do this usng synchronous disable so that if the
>>> +     * IRQ thread is being ran on other CPU we wait for it to be
>>> +     * finished.
>>
>> That irq disable is potentially expensive.
>> Why not just pass the current timestamp into the __bm1390_fifo_flush >
>> The locks should prevent other races I think..
> 
> Gah. I hate you Jonathan ;) (Not really!)
> 
> Actually, thank you (as always) for pointing this out. I don't instantly 
> see why it wouldn't work, but going throught the IRQ races is never 
> trivial (for me). It's work I've learned not to do at afternoon as my 
> brains work better at the morning :) So, I will still go through this as 
> a first thing tomorrow when I start my work day...

After staring this for a while, I see no reason why we couldn't do as 
you suggested. Thanks! It really improves this :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

