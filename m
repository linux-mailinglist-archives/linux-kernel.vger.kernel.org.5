Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A097CEF58
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjJSFxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSFxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:53:48 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE59B6;
        Wed, 18 Oct 2023 22:53:46 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so82482091fa.0;
        Wed, 18 Oct 2023 22:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697694824; x=1698299624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XObVuaWXr/rmZ3JntkdvlKmSVs/dr+MV+e6w2yjEeN0=;
        b=iWLlOD+ZFhg7GXu2M8lbBlZCsoYupI2z7tOq2I5xpfLBYizKIfyc8YjPvrDa63xzDv
         Tb+3kfuCcY5pwxZIVkDSDos0zqGpzQDYVlqMes2klr7ULYUlnx+ugB4woAoyK32Cxnrg
         qisB/nuZESzE63C+8iMtJP0ftDVZrm3NQueGJqI+L0Mwc+E40yTP4uIhMxVijjJUSyhw
         eNq/z5O3a4fv3I5o8NB0WoJzSV125dqfi+cjS6Blarko9fVRWi4pbKOWpG2TFEwVeeqO
         pgsJkN8JskIRZ4ldeJunpp0O3uR5sRzYSSW/v2uDqTsTGkrv73FvXi0sXJudIzbKmYqg
         v28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697694824; x=1698299624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XObVuaWXr/rmZ3JntkdvlKmSVs/dr+MV+e6w2yjEeN0=;
        b=h8XLRidEr8BmbWkbjwl44f/0pHNLljLhE/VzmUJv/rmlaXba0NT1j9hChLVpjlA0ub
         FDloQDYWb3JfSDoemsE6hQtHXRm+2DcmkQ5jw2ETR0WDYg5A42w2lfUWmJI/Fq00uMfW
         WfApRCgIzhBuP/4palZKXK3jTio823/SpjBOFhdwq5pUCdk7ti7p8BQcR16ZIFDEoJdT
         +hfu/j736rNPATXeeTTPOlWtQ+cpLMNMgmbvEbL8yX7WnZe7U8H2499hyyLnSsJGtqTz
         nx7rHVuvMWkvjmUiEw4uS4ds2K13bDjw34h1MzbbBwEe5SMIKKHa0t6eKlXEMCIa4pO8
         zvLw==
X-Gm-Message-State: AOJu0YxW03YS1TV8qN5CfHSqZIW7T2065yo/vjT4MFWTBzfQ6KNSCoF9
        a7wwXe76w/+n518/trg3cfE=
X-Google-Smtp-Source: AGHT+IE46NqU53DsPQM/Jpuj/PKokomausjxbvM15qvRe0+1GoBDjUvz6vOTpHtJ6S3NqLd3RRjJxQ==
X-Received: by 2002:a05:651c:1058:b0:2c5:13e8:d54e with SMTP id x24-20020a05651c105800b002c513e8d54emr648637ljm.38.1697694823867;
        Wed, 18 Oct 2023 22:53:43 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::7? (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id z16-20020a2e8e90000000b002c0414c3b6csm966928ljk.121.2023.10.18.22.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 22:53:42 -0700 (PDT)
Message-ID: <ceaf7033-d86b-4d63-b8e0-bc7445cf0df0@gmail.com>
Date:   Thu, 19 Oct 2023 08:53:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
To:     Jonathan Cameron <jic23@kernel.org>,
        Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mehdi Djait <mehdi.djait.k@gmail.com>
References: <cover.1666614295.git.mazziesaccount@gmail.com>
 <758b00d6aea0a6431a5a3a78d557d449c113b21e.1666614295.git.mazziesaccount@gmail.com>
 <CAM+2Eu+Xp6j1ppLd+zHMTu6jfc6DQKBShfe-nAyokVi0MUmoSA@mail.gmail.com>
 <20231018203423.06f20a6c@jic23-huawei>
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20231018203423.06f20a6c@jic23-huawei>
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

On 10/18/23 22:34, Jonathan Cameron wrote:
> On Wed, 18 Oct 2023 01:37:12 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:

Hi Jagath - and thanks!

>> Hi Matti,
>>
>> On Mon, Oct 24, 2022 at 6:10 PM Matti Vaittinen
>> <mazziesaccount@gmail.com> wrote:
>>>
>>> KX022A is a 3-axis accelerometer from ROHM/Kionix. The sensor features
>>> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
>>> tap/motion detection, wake-up & back-to-sleep events, four acceleration
>>> ranges (2, 4, 8 and 16g), and probably some other cool features.
>>
>> This is a nice driver, and I found it very helpful as a reference.
>> One question regarding scale please see below.
>>
>>> + * range is typically +-2G/4G/8G/16G, distributed over the amount of bits.
>>> + * The scale table can be calculated using
>>> + *     (range / 2^bits) * g = (range / 2^bits) * 9.80665 m/s^2
>>> + *     => KX022A uses 16 bit (HiRes mode - assume the low 8 bits are zeroed
>>> + *     in low-power mode(?) )
>>> + *     => +/-2G  => 4 / 2^16 * 9,80665 * 10^6 (to scale to micro)
>>> + *     => +/-2G  - 598.550415
>>> + *        +/-4G  - 1197.10083
>>> + *        +/-8G  - 2394.20166
>>> + *        +/-16G - 4788.40332
>>> + */
>>> +static const int kx022a_scale_table[][2] = {
>>> +       { 598, 550415 },
>>> +       { 1197, 100830 },
>>> +       { 2394, 201660 },
>>> +       { 4788, 403320 },
>>> +};
>>
>> Given that the integer part is non-zero, and
>> IIO_VAL_INT_PLUS_MICRO is returned for read_scale,
>> As raw value will never be fractional how does this
>> correspond to a reading of 9.8 m/s² for the Z-axis?
> 
> Definitely suspicious as should be in m/s^2 for an acceleration and
> it should be
> 
> 9.8*16/2^bits
> 
> So I think these are out by a factor of 10^6
I think you are right. Looks like I misinterpreted the meaning of 
IIO_VAL_INT_PLUS_MICRO when I took my first tour in the IIO with this 
driver. The comment above the scale table does support that assumption 
... 10^6 would match such a brainfart. (This is my first thought. I will 
take better look at this later today and see if I can come up with a fix 
if no-one else has sent a patch already).

I CC'd Mehdi who has also been working on this driver.

Regarding the KX022A - I am not aware of upstream users of this IC 
(yet). May be you're the first lucky one :) Hence, I am tempted to just 
fixing the driver - but it's Jonathan who will take the splatters when 
**** hits the fan - so it's his call to decide whether we can still fix 
this. _If_ there are users who have adapted to this buggy scale (users I 
am not aware of) then fix will break their apps. Mehdi, do you know any 
users of this upstream driver?

I will ping the HQ guy who has contacts to those who might be using the 
driver in a downstream repository and ask him to inform potential users.

It'd be very nice to get this fixed.

Sorry and thanks!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

