Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EFD7D1E1A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 18:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjJUQDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 12:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjJUQDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 12:03:22 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A391A4;
        Sat, 21 Oct 2023 09:03:19 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507c5249d55so2594233e87.3;
        Sat, 21 Oct 2023 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697904198; x=1698508998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yENL9JqeGB/W0WlC7U8msTzsOxSGZPZmnQurVbpgogo=;
        b=KNciIUxg25RKKJsMrBm6/TwVZ/Fh+RGZV+YLj0/XPUfcb6utLF8wKp2Rh3K7oHhUnZ
         7sEYUldv0r3k8oSwehXhPtOp0rBvsIT7QpbxAMOExgkKBiG2ePPDZYGzzS+BEpKuGFXt
         AXb1gO38dogIq2d9oRunWLvCIewkfCMGCkGM6ilsNLrQ4g+t0rRQIuagzXg3pEgM/a9R
         Krt0EYXcb55LXkCW0uOs2PnvEi44mSeXEhNJ8YsK47o9pVbpNhb7+70hNiYxI7eKTG7x
         VN1emn4Qi2vTdmpm+Yr1rYBul5d3NnT+i0fxizGMC3R7gKZ08TlKHjkq4tDFrYTWz3gg
         oX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697904198; x=1698508998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yENL9JqeGB/W0WlC7U8msTzsOxSGZPZmnQurVbpgogo=;
        b=Y68Locg8f1zhwokfGXtZO6Z8x4n9vpOtm2AdrHdYmW4MmDUFrFI+sVqdqIPG92zd+3
         vFLe7vJX2zC7iPVPYj0+yBeRTiCXxfi8EEKgxmJAgBcFzUEKQd9nXPh4OKMbHkk7N2Gz
         dicK6D+qi8dK1AqUQ1pmIkFmuBG7BRHN/jxHUEAlnrGzxnOr8DaBZYndDKMo6jWwb2c1
         +K3wI5UtSagXYOKzxVZCKVNWQaovfmQLuxFlLRShGEABsKHanas69y4IXHUIo4iQNE+y
         sOJIb8zqTICgeDvEGXt4jWgSyoXeVgak/xGAh2UdXIivo+bvnYAkzretAM8frLcI3GBL
         uCNA==
X-Gm-Message-State: AOJu0YzdD6SMGzD2NUILWj4DhrK4fQv5gtX/4h/5STuBIVX2vCieja12
        1n/z6HuSkL/v6k9OXaS3xkRFDSrDNZKM6A==
X-Google-Smtp-Source: AGHT+IGH7AMKl0Xwlmzj55l5riL3G0wb8amXF57YE1VsV+VEDlxAnwhlSzoufdoAt2Q63ydZ+WJmNA==
X-Received: by 2002:ac2:58e2:0:b0:4fe:db6:cb41 with SMTP id v2-20020ac258e2000000b004fe0db6cb41mr2941277lfo.39.1697904197333;
        Sat, 21 Oct 2023 09:03:17 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::7? (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id h2-20020ac25962000000b005079db81105sm912538lfp.116.2023.10.21.09.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 09:03:16 -0700 (PDT)
Message-ID: <db83cafb-1a96-40c4-ab36-8cb1ef0f2f30@gmail.com>
Date:   Sat, 21 Oct 2023 19:03:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Sanity-check available_scan_masks array
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1697452986.git.mazziesaccount@gmail.com>
 <20231021165535.34dcb94b@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20231021165535.34dcb94b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/23 18:55, Jonathan Cameron wrote:
> On Mon, 16 Oct 2023 14:04:11 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Sanity-check available_scan_masks array
>>
>> The available_scan_masks is an array of bitmasks representing the
>> channels which can be simultaneously(*) scanned by a driver from the
>> device. Following special characteristics apply:
>>
>> - When IIO is scanning through the array it will use the first mask
>>    which can be used to scan all enabled channels. This means drivers
>>    should order the array in the order of the preference. This does also
>>    mean that a mask which is a subset of a mask located earler in array
>>    will never be used because the earlier one will be picked by the core.
>> - Masks wider than size of long are supported only to some extent. The
>>    code scanning through the array will interpret the first mask with
>>    first long zeroed as end-of-array terminator. Changing this behaviour
>>    would make mask-arrays for multi-long masks to be terminated by more
>>    than one zero long. Failure to do so would result kernel to read
>>    beyond the array generating a potentially hazardous bug.
>>
>> Add a sanity-check to IIO-device registration emitting a warning if
>> available_scan_mask array is misordered or if mask width is larger than
>> a long while available_scan_mask-array is populated. Currently there
>> should be no in-tree drivers with available_scan_mask populated and mask
>> wider than a long.
>>
>> Revision history:
>> v1 => v2:
>> 	- Add patch 2/2 documenting why iio_scan_mask_match() checks only
>> 	  a long worth of bits while searching for the end of the
>> 	  available_scan_mask-array.
>> 	- Styling of patch 1/2 as per comments from Jonathan
>> 	v1 and related discussion here:
>> 	https://lore.kernel.org/lkml/ZRvjuZaQWdZw1U1I@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi/
>>
>> Matti Vaittinen (2):
>>    iio: sanity check available_scan_masks array
>>    iio: buffer: document known issue
>>
>>   drivers/iio/industrialio-buffer.c | 16 ++++++++
>>   drivers/iio/industrialio-core.c   | 63 +++++++++++++++++++++++++++++++
>>   2 files changed, 79 insertions(+)
>>
> 
> Hi Matti,
> 
> Just a quick note to say this looks fine to me, but I don't want to queue it up
> just yet given proximity to merge window etc.

Makes perfect sense to me.

>  I'll aim to pick it up early
> in next cycle. Give me a poke if I still haven't by rc3 or so.

Ouch... My memory gets worse year by year - well, I'll try to remember :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

