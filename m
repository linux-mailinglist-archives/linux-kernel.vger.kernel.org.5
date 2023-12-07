Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACE28087A8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379215AbjLGMVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379220AbjLGMVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:21:32 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92EC170D;
        Thu,  7 Dec 2023 04:21:21 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c0fc1cf3dso9287825e9.0;
        Thu, 07 Dec 2023 04:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701951680; x=1702556480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VXEn8OrLbGUPI4M1OazpR2o4kB2t0PVSgppAPB0RDn4=;
        b=Slrxr/C73GVpz5LOjGQ8WQ3HBqQ69JSxhkykRa9Yv3iXuAG6dsSPmJCVXOHlnnav/n
         +X/2EgtHs0YeNjRcZBavjEYu13dp+Qat8KbE0uc3Ud8kSGFOWDg0ZG/e3sJrAbw3oU7l
         kOvIt60dKPGU65e572tbv/usPlNdNt2lw9EwG6yC0B3NfcVXDSfCzWM2Mab+ecIFDNhC
         fFBNHMHmf1tmxx+381osLXk/4GKZwPzmEQiNR4Ai8+kjlmZ4bvn5D7Rigesivz9vexm7
         UKiqUvCJK9iQU8R1po+84gqV3syR7T3IJkE2Wd6nD3z+7dC3QP248sMSttwwqSRQn4Jo
         5axQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701951680; x=1702556480;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VXEn8OrLbGUPI4M1OazpR2o4kB2t0PVSgppAPB0RDn4=;
        b=lsr1aTgkX/FuHEvjwZxsqZp1DShHqbcMXkaVrJNKdU+JUKBMAGIxP3FPMUv/H4eksZ
         BRGy9/jBpUsUbL0Lt3HPD3ZI8FWT0s/mUYRYc/p4aAz4KCsbzlf4iYb6GfT6rh0aW6Zj
         IeRBhbf1nMs43IqwmttMFUV35sDAQVXRQhCCl5BV1lCPve21gmeOk3N79RFviJOQCBDt
         Fq4O1x5Pm4cwoDMUUVFQLOn33MrVRXX2V2TRWEBeGvHbkLi007tQ28m/5Zp2RAlIUTii
         fPu9HfEcROhAK2twxGNfdl+22A5O+sOYmRqgl/W+G2WeHmTIVoPwb7dPOgrIo5l4PYvb
         ai2w==
X-Gm-Message-State: AOJu0YxWwKj82PZexCaARNiyRmCopNXhpvNfrwTRehHPFm91MqPN6L+j
        NWVprFH8YwwFq62X10EGo3Q=
X-Google-Smtp-Source: AGHT+IEH8v8umWRtQg7bICPyJRQ3sDLuhGVDz0x4eZBUB5ao4Iy9QD9qvLP1/yetRk6u8gW9c/9qqQ==
X-Received: by 2002:a05:600c:45d0:b0:40b:5e21:d341 with SMTP id s16-20020a05600c45d000b0040b5e21d341mr1574715wmo.74.1701951679941;
        Thu, 07 Dec 2023 04:21:19 -0800 (PST)
Received: from [192.168.0.28] (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id z17-20020a1709060f1100b00a0a2553ec99sm762062eji.65.2023.12.07.04.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 04:21:19 -0800 (PST)
Message-ID: <9f6883fb-d628-4077-bb94-f5ba620bdd57@gmail.com>
Date:   Thu, 7 Dec 2023 13:21:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     savicaleksa83@gmail.com, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] hwmon: Add driver for Gigabyte AORUS Waterforce AIO
 coolers
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
References: <20231203120651.371429-1-savicaleksa83@gmail.com>
 <b45529ba-619c-41d7-a890-3b81cf699ebe@roeck-us.net>
 <da9fe05a-a12d-4a2d-a81a-1195d65b1d51@gmail.com>
 <34638d1a-55c2-4dfe-ab9b-d8591a32b950@roeck-us.net>
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <34638d1a-55c2-4dfe-ab9b-d8591a32b950@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-05 15:35:19 GMT+01:00, Guenter Roeck wrote:
> On 12/5/23 06:22, Aleksa Savic wrote:
>> On 2023-12-03 18:36:35 GMT+01:00, Guenter Roeck wrote:
>>> On Sun, Dec 03, 2023 at 01:06:48PM +0100, Aleksa Savic wrote:
>>>> This driver exposes hardware sensors of the Gigabyte AORUS Waterforce
>>>> all-in-one CPU liquid coolers, which communicate through a proprietary
>>>> USB HID protocol. Report offsets were initially discovered in [1] and
>>>> confirmed by me on a Waterforce X240 by observing the sent reports from
>>>> the official software.
>>>>
>>>> Available sensors are pump and fan speed in RPM, as well as coolant
>>>> temperature. Also available through debugfs is the firmware version.
>>>>
>>>> Attaching a fan is optional and allows it to be controlled from the
>>>> device. If it's not connected, the fan-related sensors will report
>>>> zeroes.
>>>>
>>>> The addressable RGB LEDs and LCD screen are not supported in this
>>>> driver and should be controlled through userspace tools.
>>>>
>>>> [1]: https://github.com/liquidctl/liquidctl/issues/167
>>>>
>>>> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
>>>> ---
> ...
>>>> +static int waterforce_get_status(struct waterforce_data *priv)
>>>> +{
>>>> +    int ret = 0;
>>>> +
>>>> +    if (!mutex_lock_interruptible(&priv->status_report_request_mutex)) {
>>>> +        if (!time_after(jiffies, priv->updated + msecs_to_jiffies(STATUS_VALIDITY))) {
>>>> +            /* Data is up to date */
>>>> +            goto unlock_and_return;
>>>> +        }
>>>
>>> What is the point of this check ? The calling code already checks it.
>>> Checking it twice, once inside and once outside the lock, seems
>>> excessive.
>>>
>>
>> If there are multiple readers here, only the first one should request the status,
>> so when others enter the mutex they can exit early if the data is there.
>>
> 
> Please change the code to only check once from within the mutex.
> 
> Guenter
> 

Done in v3.

Thanks,
Aleksa
