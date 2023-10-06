Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714697BB5FB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjJFLKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjJFLKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:10:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683B0C5;
        Fri,  6 Oct 2023 04:10:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c60a514f3aso15942995ad.3;
        Fri, 06 Oct 2023 04:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696590621; x=1697195421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKxwMziyF9f+XcW5KbzLvdRwT1A0PF/qR26nQ89ZGrw=;
        b=H+1K9uICCO+k3z/YVnyZYxy33o3UCVfRk3lAEMl7l764bj8+wGKCr4bwz1CMIxaVg0
         NUcvgGm+yj7DjdR4wkxLViFh/NYCaLdBMqHDaH78kpN3SaFgNNtDf43evzKN++TBv7RJ
         Z3vQuTR9yQlWNtnfTILEbKnODObfbgN4xJzUiHDQx6KrMDVY+NLbcJ3NjPTpmKrY/Gc7
         NIvogFo+cc62oI6RcUmjv55JyxeZLnDTXs9Z4rwDYIiOOs2eTS+UKqnKWtsK0XDiUTwi
         WGg1/QDOTAaGG5BxrPQfcBJPgMrSxvOWIEVtIbtrEmVLotyCC6a/d8bCJyA0/7Icretf
         hEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696590621; x=1697195421;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKxwMziyF9f+XcW5KbzLvdRwT1A0PF/qR26nQ89ZGrw=;
        b=ClO5OM/Zzpppcc8ks16aZXbTDw31/B9sptnSP/PtJdyyWDrsrbLd9VNO/ozzIcRPsQ
         3C/B0sI7QMogxhZNxI+iqfqon3ZpFMoDATieKcrw0EfuaY5VTfxIN437vKoIkOiRwgAc
         GYPGz2lqUtUBrfRC0KKOpctwezpFt6vH3pH/1q5IRBuroxKxtWTTZuSjbp06qxZVhcTn
         waL9E379xfQqessed08DWHA2uNA3fGYzihQCl4+PT2087Fv1oGmPx3UCdrGXMbf1RQOq
         +Mr6tY7tqX25hcR63kNfBAm0Qq0RG0leZ/y3o+LfWVTFneDyV9ybEYSlA9RTJzNPxb8Z
         N8Xg==
X-Gm-Message-State: AOJu0YyijM1vl8AiXtNHQ30otjxoNifG2kxHEeoU3Q8g2/pOwm3qR+6T
        OR6JObO0X4sHvzadw40updumfWxXKjY=
X-Google-Smtp-Source: AGHT+IH9vE9f9myc1J/3QI01q0u8tNp2b6twK6teuvgHg/NI/fdG5hczmvP3X96/SnE1Bt3mGdQijg==
X-Received: by 2002:a17:902:e5d0:b0:1c5:6157:f073 with SMTP id u16-20020a170902e5d000b001c56157f073mr9723898plf.11.1696590620621;
        Fri, 06 Oct 2023 04:10:20 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::7? (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902eb0600b001bbab888ba0sm3544776plb.138.2023.10.06.04.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 04:10:19 -0700 (PDT)
Message-ID: <751a87c9-a4aa-4e06-1d12-1e2b1a3487de@gmail.com>
Date:   Fri, 6 Oct 2023 14:10:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZRvjuZaQWdZw1U1I@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
 <20231005163026.2c7707de@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH] iio: sanity check available_scan_masks array
In-Reply-To: <20231005163026.2c7707de@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Again Jonathan.

On 10/5/23 18:30, Jonathan Cameron wrote:
> On Tue, 3 Oct 2023 12:49:45 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> When IIO goes through the available scan masks in order to select the
>> best suiting one, it will just accept the first listed subset of channels
>> which meets the user's requirements. If driver lists a mask which is a
>> subset of some of the masks previously in the array of
>> avaliable_scan_masks, then the latter one will never be selected.
>>
>> Add a warning if driver registers masks which can't be used due to the
>> available_scan_masks-array ordering.
>>
>> Suggested-by: Jonathan Cameron <jic23@kernel.org>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Hi Matti
> 
> Thanks for doing this.  A few comments inline + maybe we need to think
> about a unit test for the matching code. I feel we aren't pushing the
> corners of that in any drivers so far so it might bite us later.
> 
> Still that's a job for another day.
> 
> Jonathan
> 
>>
>> ---
>> The change was suggested by Jonathan here:
>> https://lore.kernel.org/lkml/20230924170726.41443502@jic23-huawei/
>> ---
>>   drivers/iio/industrialio-core.c | 57 +++++++++++++++++++++++++++++++++
>>   1 file changed, 57 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index c77745b594bd..d4f37f4eeec0 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -1896,6 +1896,53 @@ static int iio_check_extended_name(const struct iio_dev *indio_dev)

...

>> +
>> +	for (num_masks = 0; *av_masks; num_masks++)
> 
> I think we can't just check *av_masks - need bitmap_empty() as first
> long might be 0 but could be bits set in the next one.
> 
>> +		av_masks += longs_per_mask;

I did switch this to:
+       for (num_masks = 0; !bitmap_empty(av_masks, masklength); 
num_masks++)
+               av_masks += longs_per_mask;

but this kind of freaks me out.

I think in kernel we see two ways of constructing and passing arrays to 
frameworks. One is creating a NULL terminated array, the other being an 
array which size is given. The available_scan_masks is using the first 
approach.

The array represents bitmasks, which are thought to be of arbitrary 
length. The type of array items is longs though. When building an arry 
like this, it is easy to just do:

unsigned long masks[] = {
	mask1_hi,
	mask1_lo,
	mask2_hi,
	mask2_lo,
	...
	maskN_lo,
	/* sentinel */
	0
}

(By the way, I've always hated that 'sentinel' comment as it - in my 
opinion - is not worth adding. I think the meaning of 0 should be 
obvious, but here I just added it to alleviate the problem).

Here, if I'm not mistaken, the check I implemented would go reading out 
of the array bounds.

Knowing how easy it would be slip the above array past my reviewing eyes 
- I find this scary. And ugly part of this is that we can't detect this 
in the iio-core side, because we have no way of knowing how big the 
array and sentinel are. What makes this worse is that the core does:

for (i = 0; i < indio_dev->num_channels; i++)
                         ml = max(ml, channels[i].scan_index + 1);
                 indio_dev->masklength = ml;

so, masklength may not be what was set in driver.

I did quick and dirty grep for "_scan_mask\[" in iio directory and 
didn't spot any bigger than a few channels masks. Still, this makes me 
worried.

BTW: I did also:

Author: Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Fri Oct 6 13:53:11 2023 +0300

     iio: buffer: use bitmap_empty() to find last mask

     When IIO buffer code is scanning the array of available masks for
     matching the user's enable request to channel configuration 
supported by
     driver, the code uses a 'check for long 0' as indication of last mask.
     This does not work right for channel masks greater than BITS_PER_LONG.

     Use bitmap_empty() to find the last element in available_scan_masks
     array.

     Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
     ---
     NOTE: This is potentially hazardous change. Please, don't pick without
     thorough check and understanding.

diff --git a/drivers/iio/industrialio-buffer.c 
b/drivers/iio/industrialio-buffer.c
index 176d31d9f9d8..1e59afddcf9a 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -413,7 +413,7 @@ static const unsigned long 
*iio_scan_mask_match(const unsigned long *av_masks,
  {
         if (bitmap_empty(mask, masklength))
                 return NULL;
-       while (*av_masks) {
+       while (!bitmap_empty(av_masks, masklength)) {
                 if (strict) {
                         if (bitmap_equal(mask, av_masks, masklength))
                                 return av_masks;

but this is just as fragile - for obvious reasons.

One way around this would be to have the first bit in the long always 
set for a valid mask - and take this into account when going through the 
masks. It's probably somewhat more confusing than current code though - 
but it would allow using just a single long (with all - or  at least 
first - bits zero to indicate end of masks).

Other option I see is to just error out if available_scan_masks array is 
given with larger than one 'long' wide masks and worry things when this 
breaks.

Anyways, I don't like using bitmap_empty() for array of bitmaps which 
may be longer than BITS_PER_LONG unless we can sanity check the size of 
the array...

How do you feel about this?

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

