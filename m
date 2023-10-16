Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BDA7CA478
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjJPJrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPJrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:47:04 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52E2AB;
        Mon, 16 Oct 2023 02:47:01 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c4fdf94666so42264651fa.2;
        Mon, 16 Oct 2023 02:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697449620; x=1698054420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D0+r6taFyH+fgxvjyk1ODq9Nj67HjWUkYOptkmVa1t4=;
        b=UIOpM/bY3wJWOeenNnBL9wnoT0xcq4nnlJW0KcGC/VgN7yyimOGIt2H9S/ICnuQplW
         XZGGFN3E2LHkF4dCu4B633P8NOxeE9QAdLgY9+b2cwsamMrgo2zQHqo2mxeEegEXPHpN
         eJ7SUczU2IFMYx9GnoyqOOYXG+JiSMCbtRlSUCc/sosgEC2g7W33sdujw62glofsdECo
         s+18OqFgtJqizALGk2TptdpVAM2wiGmmVluFW5288E5lWmrqNj+NkEqO6QUfV/ZatR0+
         WDZvCPs9oM9LIAbzUTjTljeRJkoN/ZlAox/2GOC+Psv5zSocJYOsfHGA1/YXpIRuqPxP
         UNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697449620; x=1698054420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0+r6taFyH+fgxvjyk1ODq9Nj67HjWUkYOptkmVa1t4=;
        b=t3892Xl3hjnsq1d5S95/1weSdLQrMpJ0bH7p5N5gqXu4/4ooDQZIZIoeQ3+WvtpIq1
         0QVeehEsPWCPkrtTXQa1uKEyRhmmoUBsIIF/sF0G/e5Q9eEWleKVA1iRe9w5k7XM/WbY
         qpolpevOl1wYs/vLPgtgKdj+1+ZTq647eZGuaK6e5Ny7SG1PeTfJorfJL7tbqN/TeE9d
         FE/o6ddZ2KsOelo5Km2NH3mLf1GBZGtID+48mVS8984hq9Pd9L0t/c60o/nNWtyaNhYm
         9p+F53ot2u8wJS1NBPA6aSM7pM1doldiZfiL9xcJ2Z8Y1GpKg89aj5yCvNkCH0oNPfzm
         485g==
X-Gm-Message-State: AOJu0YwzN/ozVLJIxkQkted/JQpti1a3WkPu0gimGlJ2j6FOdpwo99Wi
        cCvP59CfMmJUvrHx0L6VdXjMVaKg7TP6AA==
X-Google-Smtp-Source: AGHT+IGUWewJtTOip/zoJBre50p+aWq1xey4im4GNNn6H0i0TTPoyw5b2q3Y9faL+TSdd58pBavGqg==
X-Received: by 2002:a05:6512:138e:b0:503:7dd:7ebc with SMTP id fc14-20020a056512138e00b0050307dd7ebcmr35277012lfb.18.1697449619822;
        Mon, 16 Oct 2023 02:46:59 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::7? (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id c14-20020ac2414e000000b0050309ea3a62sm4471555lfi.277.2023.10.16.02.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 02:46:59 -0700 (PDT)
Message-ID: <d6cb909f-46fa-45b1-a65f-f5adf840d91c@gmail.com>
Date:   Mon, 16 Oct 2023 12:46:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: sanity check available_scan_masks array
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZRvjuZaQWdZw1U1I@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
 <20231005163026.2c7707de@jic23-huawei>
 <751a87c9-a4aa-4e06-1d12-1e2b1a3487de@gmail.com>
 <20231010110419.00899e0e@jic23-huawei>
 <0d05bf24-caa6-0f86-b531-22dc08b9cadc@gmail.com>
 <20231010154734.7728fe2b@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20231010154734.7728fe2b@jic23-huawei>
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

On 10/10/23 17:47, Jonathan Cameron wrote:
> On Tue, 10 Oct 2023 15:56:22 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 10/10/23 13:04, Jonathan Cameron wrote:
>>> On Fri, 6 Oct 2023 14:10:16 +0300
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>    
>>>> Hi Again Jonathan.
>>>>
>>>> On 10/5/23 18:30, Jonathan Cameron wrote:
>>>>> On Tue, 3 Oct 2023 12:49:45 +0300
>>>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:

...

>>>> Other option I see is to just error out if available_scan_masks array is
>>>> given with larger than one 'long' wide masks and worry things when this
>>>> breaks.
>>>
>>> That would kick the problem into the long grass.
>>
>> Well, not 100% sure I interpret the idiom correctly ;) In any case, I'd
>> say this would indeed postpone dealing with the problem to the future.
> 
> It does indeed mean that!  Sorry bad habit to use idioms in discussions like
> this.
> 
>> To the point we actually seem to have a problem. The "long grass" as if
>> hiding the problem is something we can avoid by adding something like:
>>
>> if (masklength > 32 && idev->available_scan_masks) {
>> 	/*
>> 	 * Comment mowing the long grass.
>> 	 */
>> 	dev_err( ...);
>> 	return -EINVAL;
>> }
>>
>> to the device registration.

...

>>> 	iio_dev->available_scan_masks = (unsigned long *)available_masks;
>>>
>>> If we put such an example into the dummy / example driver then that might
>>> act to avoid us getting bugs in future + test the fix you have above and
>>> related.
>>
>> Well, at least it shouldn't hurt to have some example - although I'm
>> still tempted to use the "long grass" - option ;)
> 
> That is probably a good idea for now.  Though we are carrying other infrastructure
> to support this eventually and it feels weird to error out on it whilst we have
> code to support it (assuming that terminator is long enough).

I agree. I think I won't use the bitmap_empty() - because I feel it is 
unsafe. I'll leave the *av_masks check as it is implemented in 
iio_scan_mask_match() for now. Eg:

... const unsigned long *av_masks ...

while (*av_masks) {
	...
	av_masks += BITS_TO_LONGS(masklength);
}

This will fail if mask is longer than unsigned long - and if we have 
masks with zero bits worth a leading long. Still, this won't overflow 
and it also works for masks which are wider than long but do not have 
the leading bits zeroed. Balanced act of safety and functionality.

This should allow us to safely do:

if (masklength > 32 && idev->available_scan_masks) {
	/*
	 * Comment mowing the long grass.
	 */
	dev_warn( ...);
}

without returning the error.

Not perfect, but should be safe and also adds a warning if someone 
trusts the multi-long masks to work.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

