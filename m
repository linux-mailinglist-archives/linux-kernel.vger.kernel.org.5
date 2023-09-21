Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866407A9E54
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjIUUAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjIUT7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:59:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B40C86A5;
        Thu, 21 Sep 2023 10:23:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4050bd2e33aso13114715e9.2;
        Thu, 21 Sep 2023 10:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316991; x=1695921791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okXjkJYdXOrn2tPHbkbKLTw1CNJlqNe1HNdVygKVesw=;
        b=ALGVdnHcEqgwAerzBCh3NtJqKwv/JdE1tWrLYMDfuT6m3Us2o9ZAeJjJFz3Q+3t/xZ
         VZTHLhdCSywBexh2ncI403etIywI3AdmeznrL7i34EbMpYHfHPBh36uqxtZcIMFBUI+e
         UW7PpFIRKk0CpSgwXirUmkRvYjG0KUDHD52N/i3pWn2V14XrxS/X6iK9Iqm8v/NaRTtL
         HOBVQithy/Q7rvIh9qza39cn0Gbp8x1x3Gmoc3KtDuVGWbEwLcxukFFwxW5iLMAS5k+g
         dGmsW+zouwYBU3kbIM1u6O0t7VRWBS7tYEGnPMfiC7JsxdZvikAuXBSHC7nvpWSqUx9t
         6nDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316991; x=1695921791;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=okXjkJYdXOrn2tPHbkbKLTw1CNJlqNe1HNdVygKVesw=;
        b=ZgpI09S1pTTa7HcbjX1Sdxd3mUkA3mBG5BdO3sHrYovvpnfDnzxxHr9b6MtI2Ri+nM
         9W+9g1WeLakKFuiCaxH+3H2Y60l9GCWMUY054I155h1GSTKzneN9CfdHg+XiS8lHF61L
         azBSZfaWUjG+iU5NZypO8RuaUTq3NsaBFHueazwA67Ps2fsAoFUY624Hd7sXHAgXqvRy
         vV2ng/+bEW956HJUbub3scE1L82c8e+6Iw0jEOLeAp0vnTXc4+smhK4EVEC12VAtuCNC
         cN37isD1Eie1dClfm+1KFgSna0IzU7CStdUrk1gwyvYHtQ7Yk1QGdks+NZR8cVf7Yflh
         PXQw==
X-Gm-Message-State: AOJu0Yw7gmeSaHMQT1ypSxgvbJTSOD4Aqkh3Z/KvDbj8u7iVvQ3C16Qq
        ip5UbEIAuB/1WA/g4xFaUQglR9CH8dg=
X-Google-Smtp-Source: AGHT+IHcVU8NodSWCBKmDGv9jfTlJxfbXJ4HNXnRFJXA2quX61Id2XtQ6nRUzvvIugCjc6HW8A81oA==
X-Received: by 2002:a05:6512:783:b0:503:905:c5a3 with SMTP id x3-20020a056512078300b005030905c5a3mr4467097lfr.35.1695284263038;
        Thu, 21 Sep 2023 01:17:43 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id v20-20020ac25614000000b005041ce44bbdsm195445lfd.5.2023.09.21.01.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 01:17:42 -0700 (PDT)
Message-ID: <7181e56e-9488-25c9-3d03-64e49b2c952a@gmail.com>
Date:   Thu, 21 Sep 2023 11:17:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
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
 <c987f401-81c4-00e5-51a7-88a6a38a2ca2@gmail.com>
 <20230919155340.0000076f@Huawei.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 2/3] iio: pressure: Support ROHM BU1390
In-Reply-To: <20230919155340.0000076f@Huawei.com>
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

On 9/19/23 17:53, Jonathan Cameron wrote:
> On Tue, 19 Sep 2023 14:28:29 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 9/18/23 15:56, Matti Vaittinen wrote:
>>> On 9/17/23 13:35, Jonathan Cameron wrote:
>>>> On Fri, 15 Sep 2023 09:56:19 +0300
>>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>>   
>>>>> Support for the ROHM BM1390 pressure sensor. The BM1390GLV-Z can measure
>>>>> pressures ranging from 300 hPa to 1300 hPa with configurable measurement
>>>>> averaging and internal FIFO. The sensor does also provide temperature
>>>>> measurements.
>>>>>
>>>>> Sensor does also contain IIR filter implemented in HW. The data-sheet
>>>>> says the IIR filter can be configured to be "weak", "middle" or
>>>>> "strong". Some RMS noise figures are provided in data sheet but no
>>>>> accurate maths for the filter configurations is provided. Hence, the IIR
>>>>> filter configuration is not supported by this driver and the filter is
>>>>> configured to the "middle" setting (at least not for now).
>>>>>
>>>>> The FIFO measurement mode is only measuring the pressure and not the
>>>>> temperature. The driver measures temperature when FIFO is flushed and
>>>>> simply uses the same measured temperature value to all reported
>>>>> temperatures. This should not be a problem when temperature is not
>>>>> changing very rapidly (several degrees C / second) but allows users to
>>>>> get the temperature measurements from sensor without any additional
>>>>> logic.
>>>>>
>>>>> This driver allows the sensor to be used in two muitually exclusive
>>>>> ways,
>>>>>
>>>>> 1. With trigger (data-ready IRQ).
>>>>> In this case the FIFO is not used as we get data ready for each
>>>>> collected
>>>>> sample. Instead, for each data-ready IRQ we read the sample from sensor
>>>>> and push it to the IIO buffer.
>>>>>
>>>>> 2. With hardware FIFO and watermark IRQ.
>>>>> In this case the data-ready is not used but we enable watermark IRQ. At
>>>>> each watermark IRQ we go and read all samples in FIFO and push them
>>>>> to the
>>>>> IIO buffer.
>>>>>
>>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ...
>>
>>>>> +
>>>>> +static const unsigned long bm1390_scan_masks[] = {
>>>>> +    BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP), 0
>>>> Why?  Doesn't look hard to support just one or the other?
>>>> Normally we only do this sort of limitation when there is a heavily
>>>> optimized read routine for a set of channels and it is better
>>>> to grab them all and throw away the ones we don't care about.
>>>> That doesn't seem to be true here. So if the fifo grabbed both
>>>> temp and pressure it would makes sense here, but doesn't seem
>>>> like it does.
>>>
>>> I have a feeling I have misunderstood how this mask works. I have
>>> assumed all the channels with corresponding mask bit _can_ be enabled
>>> simultaneously, but I have not understood they _must_ all be enabled. I
>>> think I must go back studying this, but if all channels really _must_ be
>>> enabled, then you are correct. It actually makes a lot of sense to
>>> support the pressure values alone, as, according to the data-sheet, the
>>> HW is doing a "MEMS temperature compensation" to the pressure values.
>>> So, my assuimption is the temperature data may not be required to be
>>> captured.
>>>
>>> This also means I should revise the scan masks for the BU27008, BU27010
>>> and BU27034 light sensors as I don't think all the users want all the
>>> channels enabled. I wonder how I have not noticed any problems when I
>>> tested those things - did I really always enable all the channels...? @_@
>>>
>>> Anyways, Thanks.
>>
>> Hi Jonathan,
>>
>> There's something in IIO scan_masks / buffer demuxing that I don't quite
>> understand

Thank You for the patience and the explanation Jonathan. I have a - 
hopefully not totally wrong - feeling I understand this better. I didn't 
understand that IIO framework has this extra logic and that 
available_scan_masks was not really meant for telling what IIO allows 
_users_ to enable - but it was for driver to tell IIO core what the 
driver can give. (Naturally this impacts to what IIO allows users to 
enable, but not directly). Eg, if I now get it right, the 
'available_scan_masks' is information what data flows between driver and 
IIO. Similarly, 'active_scan_mask' tells what the IIO core 'expects' to 
get from the driver, right? So, in bm1390 case, if I set both:

BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP),
and
BIT(BM1390_CHAN_PRESSURE),

to 'available_scan_masks', then it means driver is telling IIO it can 
give both pressure and temperature, or temperature alone. As a result, 
IIO can set either both temp and pressure to 'active_scan_mask' - in 
which case driver should push both in the buffers - or just the 
pressure, in which case the driver should not push the temperature.

>>
>> The bm1390 driver as sent in v2 does not do demuxing but always pushes
>> whole chunk of data and trusts IIO to do demuxing.
> 
> Yup. That should work.  But in this case you can trivially decide not to read
> or fill in the temperature and hence save some bus cycles.
> 
>>
>> 2) I noticed the 'available_scan_masks' was marked as an optional field.
>> So, I think that if there is no restrictions to which of the channels
>> can be enabled, then we can omit setting it. This is what I tried.
>>
>> It appears that when we do not populate the 'available_scan_masks' with the:
>>   >>> +static const unsigned long bm1390_scan_masks[] = {
>>   >>> +    BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP), 0
>>
>> things change. When I tested enabling only temperature and ran the
>> iio_generic_buffer -c 20 -N 0 -t bm1390data-rdy-dev0 - the reported
>> values seemed completely random.
> 
> You need to pack the data correctly yourself in the driver.
> So it adds small amount of code complexity but potentially saves bus
> traffic.

...

>>
>> Based on this experimenting (and headache obtained from reading the
>> demuxing code) - the IIO framework does not do channel demuxing if the
>> 'available_scan_masks' is not given? To me this was somewhat unexpected.
> 
> Yes.  If you don't tell it what channel setups are available (note there can
> be lots) you are saying that we support any random combination and have
> to do the data packing by hand.
> 

Okay... I think it kind of makes sense to leave an option where the 
driver can create buffer as it wants. I am not sure I can wrap my head 
around this to the extent that I knew when the IIO does not know what 
channels the driver has enabled - and thus, what types of data there 
will be - but I can accept the answer that such situations can exist :) 
Besides, allowing the driver to do the buffer formatting may allow some 
'use-case specific, custom optimizations' when user-space knows what to 
expect (for example, regarding the data alignments and ordering to for 
example save space).

...This leads to another thing I noticed - and to another question :)

I was experimenting with the bm1390 scan masks and iio_generic_buffer 
tool. It seems to me that the iio_generic_buffer does not expect the 
padding when the data in buffer is u32 + u16. When I enable the pressure 
(32bits) and temperature (16 bits) in bm1390 and keep the time-stamp 
disabled, the user-space will get buffer where 2 bytes of padding is 
added to each temperature sample so the next pressure sample stays 
correctly aligned. I believe kernel side does sane job here.

This, however, did result (at least my version of) the 
iio_generic_buffer tool to read garbage values after the first sample. 
My assumption is that the iio_generic_buffer does not add the padding 
bytes to the end of last data in the scan in order to ensure also the 
next scan will be correctly aligned.

I did following change to the iio_generic_buffer:

Author: Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Thu Sep 21 10:15:19 2023 +0300

     tools: iio: iio_generic_buffer ensure alignment

     The iio_generic_buffer can return garbage values when the total size of
     scan data is not a multiple of largest element in the scan. This can be
     demonstrated by reading a scan consisting for example of one 4 byte and
     one 2 byte element, where the 4 byte elemnt is first in the buffer.

     The IIO generic buffert code does not take into accunt the last two
     padding bytes that are needed to ensure that the 4byte data for next
     scan is correctly aligned.

     Add padding bytes required to align the next sample into the scan size.

     Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 44bbf80f0cfd..fc562799a109 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -54,9 +54,12 @@ enum autochan {
  static unsigned int size_from_channelarray(struct iio_channel_info 
*channels, int num_channels)
  {
         unsigned int bytes = 0;
-       int i = 0;
+       int i = 0, max = 0;
+       unsigned int misalignment;

         while (i < num_channels) {
+               if (channels[i].bytes > max)
+                       max = channels[i].bytes;
                 if (bytes % channels[i].bytes == 0)
                         channels[i].location = bytes;
                 else
@@ -66,6 +69,16 @@ static unsigned int size_from_channelarray(struct 
iio_channel_info *channels, in
                 bytes = channels[i].location + channels[i].bytes;
                 i++;
         }
+       /*
+        * We wan't the data in next sample to also be properly aligned so
+        * we'll add padding at the end if needed. TODO: should we use fixed
+        * 8 byte alignment instead of the size of the biggest samnple?
+        */
+       misalignment = bytes % max;
+       if (misalignment) {
+               printf("Misalignment %u. Adding Padding %u\n", 
misalignment,  max - misalignment);
+               bytes += max - misalignment;
+       }

         return bytes;
  }

I can send this as a proper patch if you guys think it is correct.


>>
>> Finally, when the watermark IRQ is used, we can't omit reading the
>> pressure data because clearing the WMI is done based on the pressure
>> data in FIFO.
> 
> Hmm. That is a good reason to keep the available scan masks set.
> Add a comment on that next to the mask.
> 
>>
>> So, I would propose we do:
>>
>> static const unsigned long bm1390_scan_masks[] = {
>> 	BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP),
>> 	BIT(BM1390_CHAN_PRESSURE), 0
> 
> Makes sense given need to read the pressure channel.
>>
>> which better reflects what the hardware is capable of - and, unless I am
>> missing something, also allows us to offload the buffer demuxing to the IIO.
>>
>> Still, as mentioned in 1), the
>>
>>   >>> +static const unsigned long bm1390_scan_masks[] = {
>>   >>> +    BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP), 0
>>
>> does not seem to prevent enabling only the temperature channel - so in
>> the driver buffer handler we still must unconditionally read the
>> pressure data regardles the active_scan_mask.
> 
> active_scan_mask should match the above - it's separate from what is enabled.
> active_scan_mask is on the data capture side of the demux - the buffers
> are then fed repacked data reflecting what is enabled.

Cool! So, the driver can rely on IIO asking for the pressure (in 
active_scan_mask) after it has correctly set the available scan mask. It 
may not be a big thing but I like it. It is enough to take care of 
ensuring all required stuff is read from HW in one place (in available 
scan masks) and not to worry about it in actual data reading path but 
just read stuff IIO is asking to be read. I like it.

Another thing to note is that, when we build the available_scan_mask 
array - we should either pay attention to the order of masks - or change 
the iio_scan_mask_match() to not accept first matching subset but to go 
through all of the masks unless it finds and exactly matching one (and 
in general prefer the smallest subset). Not sure this is worth the extra 
cycles though.

Thanks again - feel like I've learned something today :)

Yours,
	-- Matti Vaittinen

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

