Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A35804AF0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344615AbjLEHLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344600AbjLEHK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:10:57 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4CA120;
        Mon,  4 Dec 2023 23:11:03 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9fc0b84d0so27758081fa.0;
        Mon, 04 Dec 2023 23:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701760262; x=1702365062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J33kj97x2pqjNJ1vDzC7sdv8NjUfYByLnvuzd7wzUHI=;
        b=HRhRdLdnkfXRzkMnrscgEHTqNLN16yiFkOr+awlsqupmmYmI/xy5dLVDIbVZvoKsqs
         FyNPOMPQhtQcur/fHUMfjpOHwpLBTZkF2M+QB5tdCgYwkdZh9mKvWsE06ngQaT2sd7zE
         9sNZJwBqQrMdnvmtXrVugJcrKQz0xktOUliPxCrspo3Xkf3AYMsqsDi30+EvuRWXWU4s
         jv0c5v0x+GwezQ7hCip3GS5agBdoUhu7/652l7TrY4fW6q44CYaHnyIFbkzSlTvt9rVv
         cdwDtOC7246zSDl64qj1tfRBilloILJ5RbeVpXCUFieq7nESx+GwdUQRDyDHa8PE5xUZ
         MqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701760262; x=1702365062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J33kj97x2pqjNJ1vDzC7sdv8NjUfYByLnvuzd7wzUHI=;
        b=fBR0/sMZNSeImqmRmMkdOkgvOrkYfwqSzqMHSgGdJMdUiIYP7Nbo5cQ6V7KU+WDKVX
         zUM6f9ktIkvlAZRcjSa3xpEs19l8xi0UM/C7qHCBQhPiHsHM3gFw3dnwp5DgqS0EybwR
         FIFGn3reNc3nOtuH/G38Oh+jfmibiN99Vt+6FfNaDqhQywCEqiYQZuC/GiUNuePGaRzU
         wuErWKMklhGj31up+WiDia8731iTVsyCsqeuGZtq8xMhxA+AWa+sd9uo906fi106i5se
         LM0oesHWC45KahojFlNDxlMULnqKcVOQlbNKVAL6y5kHIwUn+GlG3CKLR/hSwncU9Vjx
         Bikg==
X-Gm-Message-State: AOJu0YzO3gRkUB36Fa8tWS+c5rz8q9N03WiuKLX9xEGyu5CfZODbywln
        0CCjO5GqkFXR3kwyNmIG77U=
X-Google-Smtp-Source: AGHT+IGlt201D+jggBtsDfnYTMdcEZMbyhxFNQQ+jUqi1f6EzN7auu/+d/VjPnPr9Y4vQSRhadq/4w==
X-Received: by 2002:a2e:9b14:0:b0:2ca:1ea:4b20 with SMTP id u20-20020a2e9b14000000b002ca01ea4b20mr1390091lji.8.1701760261279;
        Mon, 04 Dec 2023 23:11:01 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::2? (dc78bmyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::2])
        by smtp.gmail.com with ESMTPSA id a5-20020a2eb545000000b002c9f90021ebsm791589ljn.29.2023.12.04.23.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 23:11:00 -0800 (PST)
Message-ID: <c6088472-e68f-42a5-8c8b-1fd065e9f524@gmail.com>
Date:   Tue, 5 Dec 2023 09:10:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: gts-helpers: Round gains and scales
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZUDN9n8iXoNwzifQ@dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi>
 <20231126172607.379c9d79@jic23-huawei>
 <8934d9ec-e969-4662-b220-9fb1cbeca7b2@gmail.com>
 <20231204143005.7a564326@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20231204143005.7a564326@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/23 16:30, Jonathan Cameron wrote:
> On Mon, 27 Nov 2023 09:48:08 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 11/26/23 19:26, Jonathan Cameron wrote:
>>> On Tue, 31 Oct 2023 11:50:46 +0200
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>    
>>>> The GTS helpers do flooring of scale when calculating available scales.
>>>> This results available-scales to be reported smaller than they should
>>>> when the division in scale computation resulted remainder greater than
>>>> half of the divider. (decimal part of result > 0.5)
>>>>
>>>> Furthermore, when gains are computed based on scale, the gain resulting
>>>> from the scale computation is also floored. As a consequence the
>>>> floored scales reported by available scales may not match the gains that
>>>> can be set.
>>>>
>>>> The related discussion can be found from:
>>>> https://lore.kernel.org/all/84d7c283-e8e5-4c98-835c-fe3f6ff94f4b@gmail.com/
>>>>
>>>> Do rounding when computing scales and gains.
>>>>
>>>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>
>>> Hi Matti,
>>>
>>> A few questions inline about the maths.
>>
>> I appreciate the questions :) Thanks!
> 
> I found some emails hiding so late replies...

Better late than never :)

To tell the truth, delays have been Ok. I think Subhajit has not needed 
this urgently and the darkness of the winter in Finland has hindered my 
energy and activity to very low levels.

>>>> ---
>>>> Subjahit, is there any chance you test this patch with your driver? Can
>>>> you drop the:
>>>> 	if (val2 % 10)
>>>> 		val2 += 1;
>>>> from scale setting and do you see written and read scales matching?
>>>>
>>>> I did run a few Kunit tests on this change - but I'm still a bit jumpy
>>>> on it... Reviewing/testing is highly appreciated!
>>>>
>>>> Just in case someone is interested in seeing the Kunit tests, they're
>>>> somewhat unpolished & crude and can emit noisy debug prints - but can
>>>> anyways be found from:
>>>> https://github.com/M-Vaittinen/linux/commits/iio-gts-helpers-test-v6.6
>>>>
>>>> ---
>>>>    drivers/iio/industrialio-gts-helper.c | 58 +++++++++++++++++++++++----
>>>>    1 file changed, 50 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
>>>> index 7653261d2dc2..7dc144ac10c8 100644
>>>> --- a/drivers/iio/industrialio-gts-helper.c
>>>> +++ b/drivers/iio/industrialio-gts-helper.c
>>>> @@ -18,6 +18,32 @@
>>>>    #include <linux/iio/iio-gts-helper.h>
>>>>    #include <linux/iio/types.h>
>>>>    
>>>> +static int iio_gts_get_gain_32(u64 full, unsigned int scale)
>>>> +{
>>>> +	unsigned int full32 = (unsigned int) full;
>>>> +	unsigned int rem;
>>>> +	int result;
>>>> +
>>>> +	if (full == (u64)full32) {
>>>> +		unsigned int rem;
>>>> +
>>>> +		result = full32 / scale;
>>>> +		rem = full32 - scale * result;
>>>> +		if (rem >= scale / 2)
>>>> +			result++;
>>>> +
>>>> +		return result;
>>>> +	}
>>>> +
>>>> +	rem = do_div(full, scale);
>>>
>>> As below, can we just add scale/2 to full in the do_div?
>>
>> The rationale for doing is it in this way is to prevent (theoretical?)
>> overflow when adding scale/2 to full. Maybe this warrants adding a comment?
> 
> Hmm. Chances are very low of hitting that.  I'd just go with adding scale/2
> before the div.  If you really want to worry about being right at the edge
> of available precision, then add a check for that.

I think the v2 will ditch this function.
>>>> +	if ((u64)rem >= scale / 2)
>>>> +		result = full + 1;
>>>> +	else
>>>> +		result = full;
>>>> +
>>>> +	return result;
>>>> +}
>>>> +
>>>>    /**
>>>>     * iio_gts_get_gain - Convert scale to total gain
>>>>     *
>>>> @@ -28,30 +54,42 @@
>>>>     *		scale is 64 100 000 000.
>>>>     * @scale:	Linearized scale to compute the gain for.
>>>>     *
>>>> - * Return:	(floored) gain corresponding to the scale. -EINVAL if scale
>>>> + * Return:	(rounded) gain corresponding to the scale. -EINVAL if scale
>>>>     *		is invalid.
>>>>     */
>>>>    static int iio_gts_get_gain(const u64 max, const u64 scale)
>>>>    {
>>>> -	u64 full = max;
>>>> +	u64 full = max, half_div;
>>>> +	unsigned int scale32 = (unsigned int) scale;
>>>>    	int tmp = 1;
>>>>    
>>>> -	if (scale > full || !scale)
>>>> +	if (scale / 2 > full || !scale)
>>>
>>> Seems odd. Why are we checking scale / 2 here?
>>
>> I am pretty sure I have been thinking of rounding 0.5 to 1.
> 
> Not sure I follow - but maybe it'll be clear in v2.

Basically, when scale is greater than max, the division yields values 
smaller than 1. So, when we do rounding, everything equal to or greater 
than 0.5 and smaller than 1 should be rounded upwards. Eg, purely from 
computational perspective, when the "full" is half of the scale, 
division returns 0.5. Thus the check.

But I think your question is very much a valid one. By design the driver 
gives the max value - and I think that scale exceeding this maximum can 
indeed be considered to be invalid. Not that I feel 100% certain on that 
Today :)

> 
>>>    
>>>> +
>>>> +	while (full + half_div >= scale * (u64)tmp)
>>>>    		tmp++;
>>>>    
>>>> -	return tmp;
>>>> +	return tmp - 1;
>>>>    }
>>>>    
>>>>    /**
>>>> @@ -133,6 +171,7 @@ static int iio_gts_linearize(int scale_whole, int scale_nano,
>>>>     * Convert the total gain value to scale. NOTE: This does not separate gain
>>>>     * generated by HW-gain or integration time. It is up to caller to decide what
>>>>     * part of the total gain is due to integration time and what due to HW-gain.
>>>> + * Computed gain is rounded to nearest integer.
>>>>     *
>>>>     * Return: 0 on success. Negative errno on failure.
>>>>     */
>>>> @@ -140,10 +179,13 @@ int iio_gts_total_gain_to_scale(struct iio_gts *gts, int total_gain,
>>>>    				int *scale_int, int *scale_nano)
>>>>    {
>>>>    	u64 tmp;
>>>> +	int rem;
>>>>    
>>>>    	tmp = gts->max_scale;
>>>>    
>>>> -	do_div(tmp, total_gain);
>>>> +	rem = do_div(tmp, total_gain);
>>>
>>> can we do usual trick of
>>> do_div(tmp + total_gain/2, total_gain)
>>> to get the same rounding effect?
>>
>> Only if we don't care about the case where tmp + total_gain/2 overflows.
> 
> As above. The cases where that happens are pretty narrow.  I'd not worry about it
> or I'd check for that overflow.

part of me says you're right while part of me screams that
1) a _division_ causing overflow is against all that is well and good.
2) if we can cope with the overflow, then we should cope with it.

I am very much undecided what is the best approach here. I'll see how 
much clarity there is in the v2 code, what comments can do and then I'll 
throw it for you to judge :)

>>
>> All in all, I am still not 100% sure if rounding is the right ambition.
>> Do we cause hidden accuracy issues by doing the rounding under the hood?
>> I feel I need bigger brains :)
> Don't we all!

Well, luckily the software development can be seen as an iterative 
process :)

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

