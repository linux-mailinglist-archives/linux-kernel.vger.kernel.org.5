Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453348057CB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345947AbjLEOfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345881AbjLEOfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:35:15 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52595120;
        Tue,  5 Dec 2023 06:35:22 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cb55001124so5089899b3a.0;
        Tue, 05 Dec 2023 06:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701786922; x=1702391722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bUDszzbQ/6RYO4w6lDEStppG88rzplEEUuYKJ+6NhV0=;
        b=S5jl9xF9ncUHLNCw7389Stai9DjfIYCalItUDrL1r3WYEwGH+lPKt7yGV1ikdbw3Wv
         JgwEFmlGC0GgY3ngFKV1dMZPjmDKDxeDMVoEbhxE7ljEtlyRlo45jwmGpbRU7gOS7GvO
         xa/e7gcBLACAr0F6VGXxQbCUGo9t5cxX46UcvK+k6uEvEJ0ajb9H1rOGeOSJjTstUjmP
         G4hfxFV1ImZGaprM8Zdh6NkU4mBbIVi4BPc3PoH/KB7hyOgSCU+D5H+ImG78AsHnKrAS
         eNIGvw7zDM2oR0ZRnF3xhHFX5Stp2Cf0zhqUDYyesfjuvBbqZbwL5FGaPDPt4NTGIg2b
         6kSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701786922; x=1702391722;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUDszzbQ/6RYO4w6lDEStppG88rzplEEUuYKJ+6NhV0=;
        b=waop5bjQgRxJsO80bucAOEGBsVi/DNvXfxMrBZQg0GgNzBhMDZBbIceR5XKx/jifgj
         o3sE5EHxG85U/Lpgu2FAbFoISKa+/WoFaMXN0XAiWcID3afG205NsI5zpnyHR1KTuTt1
         nDfEdulITYFNDAjNldRIqt6tnBLPm9j2rA1EOoUsTHggZnV0pZjkUpWZjs5fv3UpkwMh
         A+bnNUTlQcKzZzhipNXMjAkAaMBzqSwrqcSsyaTnBYiYG3/KYGF8bDB3croB8csd84rx
         5tWjZVFnzogmdricJjGsPBIFBBBbi5UeWkrNllBFLp05AijCz/pK+Z7R36j9VzzLOrBU
         +alQ==
X-Gm-Message-State: AOJu0Ywq5c2EYvHzQqix3KsFtDygyxhZTXdujBwIi+8+RTU51WUXWnKs
        pYA+8U9d4xkmxU8bX8RX7S8=
X-Google-Smtp-Source: AGHT+IGbx5M3pA0PvmC0g0jom9dK0xcscOv26zfwVnAsxaw4+A5vaVeeKcWgONEN9+0iI/Pd8lU0Vw==
X-Received: by 2002:a05:6a00:1c9c:b0:6ce:3b75:4998 with SMTP id y28-20020a056a001c9c00b006ce3b754998mr1543867pfw.16.1701786921676;
        Tue, 05 Dec 2023 06:35:21 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f17-20020a056a001ad100b006cbe1bb5e3asm9462299pfv.138.2023.12.05.06.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 06:35:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <34638d1a-55c2-4dfe-ab9b-d8591a32b950@roeck-us.net>
Date:   Tue, 5 Dec 2023 06:35:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: Add driver for Gigabyte AORUS Waterforce AIO
 coolers
Content-Language: en-US
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231203120651.371429-1-savicaleksa83@gmail.com>
 <b45529ba-619c-41d7-a890-3b81cf699ebe@roeck-us.net>
 <da9fe05a-a12d-4a2d-a81a-1195d65b1d51@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <da9fe05a-a12d-4a2d-a81a-1195d65b1d51@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/23 06:22, Aleksa Savic wrote:
> On 2023-12-03 18:36:35 GMT+01:00, Guenter Roeck wrote:
>> On Sun, Dec 03, 2023 at 01:06:48PM +0100, Aleksa Savic wrote:
>>> This driver exposes hardware sensors of the Gigabyte AORUS Waterforce
>>> all-in-one CPU liquid coolers, which communicate through a proprietary
>>> USB HID protocol. Report offsets were initially discovered in [1] and
>>> confirmed by me on a Waterforce X240 by observing the sent reports from
>>> the official software.
>>>
>>> Available sensors are pump and fan speed in RPM, as well as coolant
>>> temperature. Also available through debugfs is the firmware version.
>>>
>>> Attaching a fan is optional and allows it to be controlled from the
>>> device. If it's not connected, the fan-related sensors will report
>>> zeroes.
>>>
>>> The addressable RGB LEDs and LCD screen are not supported in this
>>> driver and should be controlled through userspace tools.
>>>
>>> [1]: https://github.com/liquidctl/liquidctl/issues/167
>>>
>>> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
>>> ---
...
>>> +static int waterforce_get_status(struct waterforce_data *priv)
>>> +{
>>> +	int ret = 0;
>>> +
>>> +	if (!mutex_lock_interruptible(&priv->status_report_request_mutex)) {
>>> +		if (!time_after(jiffies, priv->updated + msecs_to_jiffies(STATUS_VALIDITY))) {
>>> +			/* Data is up to date */
>>> +			goto unlock_and_return;
>>> +		}
>>
>> What is the point of this check ? The calling code already checks it.
>> Checking it twice, once inside and once outside the lock, seems
>> excessive.
>>
> 
> If there are multiple readers here, only the first one should request the status,
> so when others enter the mutex they can exit early if the data is there.
> 

Please change the code to only check once from within the mutex.

Guenter

