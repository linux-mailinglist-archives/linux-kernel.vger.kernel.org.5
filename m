Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725507F9B19
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjK0HsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjK0HsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:48:06 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A304F9E;
        Sun, 26 Nov 2023 23:48:12 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c5b7764016so43094481fa.1;
        Sun, 26 Nov 2023 23:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701071291; x=1701676091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8hocmjhtCudPAHjz51pszRI0UfcwNAqx7JOErB/Si6k=;
        b=UgQWZHubWe1/DfAqATu4eoi4K5fDntP0Z60fD6dwlAokRB2pRPLACVuEphxlkSeMyg
         YYNSLEWcnmtkCsAIcsMvhpKYZpY40i+HAYaxT80gUHIlD5/qNAifQfJP5Lo6Zd0GPJ6y
         +pSz3kVPMERz7Pfp3wuMeSw6p0j4AYVB/DhPNSNKtPb2QrH0mlWuWMYyG1n0xPI2T7Ih
         3rARDkgSjQEyRwBKyw3TPmQrSoeSIADgCSJRwLfJdiV/4FTkyz1/XOjzXGpkP4N/+3cr
         t848oSCIF91o/bian4jrjoCVKMniyRW576/da4WVeshrVEgcssn6lV3BFjFlkOKH/C0Y
         LD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701071291; x=1701676091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8hocmjhtCudPAHjz51pszRI0UfcwNAqx7JOErB/Si6k=;
        b=Sw5wBWN4zeINU9FGq3Biytpb2vhDwqhAOC4adABBHd+TfYAJfK6HIfiO0oV3bNY+dF
         W/Zws5awKlS2QAZcwioxoDEiKJKJDZ4wurVzpaj33C24DIDKPQ7OMgkHXdErLtZ3Sstu
         bao7ZYnnlX8zJLANpRCjia2ZObLQ3D61WDawEFNLXhBjM1h4TSejmIHJri9OCTc7X76N
         toAiYeybl31QkROVYWS9m+DdXzZOLdPdtZstgs+or6mKetjShrLkOxl7NzUIlclzm+2y
         UydzsXc/N8+R9sFCR0j8A2frvEdXSQZtYnhkiKyp3S1ORDZeh26we1fGoVLl+8iNGBlf
         ULgg==
X-Gm-Message-State: AOJu0YxPs8AWX9VAdxg0KahbgE2kyQApr/nRI5UHgFvE35PcYyNHWrfH
        pZheQdCVh/zpJJonsmiFGr601+mR2BwLgg==
X-Google-Smtp-Source: AGHT+IEQGAcDEzS7zWCGIAlDYWffH9lSAZuZTndB1WPyAbuMjsYFvRscuISN34pI8d2FYJh9MCPFdg==
X-Received: by 2002:a2e:8619:0:b0:2c5:f1a:1f31 with SMTP id a25-20020a2e8619000000b002c50f1a1f31mr7078891lji.1.1701071290531;
        Sun, 26 Nov 2023 23:48:10 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::2? (dc78bmyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::2])
        by smtp.gmail.com with ESMTPSA id w2-20020a05651c102200b002c0414c3b6csm1227492ljm.121.2023.11.26.23.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 23:48:09 -0800 (PST)
Message-ID: <8934d9ec-e969-4662-b220-9fb1cbeca7b2@gmail.com>
Date:   Mon, 27 Nov 2023 09:48:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: gts-helpers: Round gains and scales
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZUDN9n8iXoNwzifQ@dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi>
 <20231126172607.379c9d79@jic23-huawei>
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20231126172607.379c9d79@jic23-huawei>
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

On 11/26/23 19:26, Jonathan Cameron wrote:
> On Tue, 31 Oct 2023 11:50:46 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The GTS helpers do flooring of scale when calculating available scales.
>> This results available-scales to be reported smaller than they should
>> when the division in scale computation resulted remainder greater than
>> half of the divider. (decimal part of result > 0.5)
>>
>> Furthermore, when gains are computed based on scale, the gain resulting
>> from the scale computation is also floored. As a consequence the
>> floored scales reported by available scales may not match the gains that
>> can be set.
>>
>> The related discussion can be found from:
>> https://lore.kernel.org/all/84d7c283-e8e5-4c98-835c-fe3f6ff94f4b@gmail.com/
>>
>> Do rounding when computing scales and gains.
>>
>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Hi Matti,
> 
> A few questions inline about the maths.

I appreciate the questions :) Thanks!
> 
>>
>> ---
>> Subjahit, is there any chance you test this patch with your driver? Can
>> you drop the:
>> 	if (val2 % 10)
>> 		val2 += 1;
>> from scale setting and do you see written and read scales matching?
>>
>> I did run a few Kunit tests on this change - but I'm still a bit jumpy
>> on it... Reviewing/testing is highly appreciated!
>>
>> Just in case someone is interested in seeing the Kunit tests, they're
>> somewhat unpolished & crude and can emit noisy debug prints - but can
>> anyways be found from:
>> https://github.com/M-Vaittinen/linux/commits/iio-gts-helpers-test-v6.6
>>
>> ---
>>   drivers/iio/industrialio-gts-helper.c | 58 +++++++++++++++++++++++----
>>   1 file changed, 50 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
>> index 7653261d2dc2..7dc144ac10c8 100644
>> --- a/drivers/iio/industrialio-gts-helper.c
>> +++ b/drivers/iio/industrialio-gts-helper.c
>> @@ -18,6 +18,32 @@
>>   #include <linux/iio/iio-gts-helper.h>
>>   #include <linux/iio/types.h>
>>   
>> +static int iio_gts_get_gain_32(u64 full, unsigned int scale)
>> +{
>> +	unsigned int full32 = (unsigned int) full;
>> +	unsigned int rem;
>> +	int result;
>> +
>> +	if (full == (u64)full32) {
>> +		unsigned int rem;
>> +
>> +		result = full32 / scale;
>> +		rem = full32 - scale * result;
>> +		if (rem >= scale / 2)
>> +			result++;
>> +
>> +		return result;
>> +	}
>> +
>> +	rem = do_div(full, scale);
> 
> As below, can we just add scale/2 to full in the do_div?

The rationale for doing is it in this way is to prevent (theoretical?) 
overflow when adding scale/2 to full. Maybe this warrants adding a comment?

> 
>> +	if ((u64)rem >= scale / 2)
>> +		result = full + 1;
>> +	else
>> +		result = full;
>> +
>> +	return result;
>> +}
>> +
>>   /**
>>    * iio_gts_get_gain - Convert scale to total gain
>>    *
>> @@ -28,30 +54,42 @@
>>    *		scale is 64 100 000 000.
>>    * @scale:	Linearized scale to compute the gain for.
>>    *
>> - * Return:	(floored) gain corresponding to the scale. -EINVAL if scale
>> + * Return:	(rounded) gain corresponding to the scale. -EINVAL if scale
>>    *		is invalid.
>>    */
>>   static int iio_gts_get_gain(const u64 max, const u64 scale)
>>   {
>> -	u64 full = max;
>> +	u64 full = max, half_div;
>> +	unsigned int scale32 = (unsigned int) scale;
>>   	int tmp = 1;
>>   
>> -	if (scale > full || !scale)
>> +	if (scale / 2 > full || !scale)
> 
> Seems odd. Why are we checking scale / 2 here?

I am pretty sure I have been thinking of rounding 0.5 to 1.

> 
>>   		return -EINVAL;
>>   
>> +	/*
>> +	 * The loop-based implementation below will potentially run _long_
>> +	 * if we have a small scale and large 'max' - which may be needed when
>> +	 * GTS is used for channels returning specific units. Luckily we can
>> +	 * avoid the loop when scale is small and fits in 32 bits.
>> +	 */
>> +	if ((u64)scale32 == scale)
>> +		return iio_gts_get_gain_32(full, scale32);
>> +
>>   	if (U64_MAX - full < scale) {
>>   		/* Risk of overflow */
>> -		if (full - scale < scale)
>> +		if (full - scale / 2 < scale)
>>   			return 1;
>>   
>>   		full -= scale;
>>   		tmp++;
>>   	}
>>   
>> -	while (full > scale * (u64)tmp)
>> +	half_div = scale >> 2;
> 
> Why divide by 4?  Looks like classic issue with using shifts for division
> causing confusion.

Yes. Looks like a brainfart to me. I need to fire-up my tests and revise 
this (and the check you asked about above). It seems to take a while 
from me to wrap my head around this again...

Thanks for pointing this out!

> 
>> +
>> +	while (full + half_div >= scale * (u64)tmp)
>>   		tmp++;
>>   
>> -	return tmp;
>> +	return tmp - 1;
>>   }
>>   
>>   /**
>> @@ -133,6 +171,7 @@ static int iio_gts_linearize(int scale_whole, int scale_nano,
>>    * Convert the total gain value to scale. NOTE: This does not separate gain
>>    * generated by HW-gain or integration time. It is up to caller to decide what
>>    * part of the total gain is due to integration time and what due to HW-gain.
>> + * Computed gain is rounded to nearest integer.
>>    *
>>    * Return: 0 on success. Negative errno on failure.
>>    */
>> @@ -140,10 +179,13 @@ int iio_gts_total_gain_to_scale(struct iio_gts *gts, int total_gain,
>>   				int *scale_int, int *scale_nano)
>>   {
>>   	u64 tmp;
>> +	int rem;
>>   
>>   	tmp = gts->max_scale;
>>   
>> -	do_div(tmp, total_gain);
>> +	rem = do_div(tmp, total_gain);
> 
> can we do usual trick of
> do_div(tmp + total_gain/2, total_gain)
> to get the same rounding effect?

Only if we don't care about the case where tmp + total_gain/2 overflows.

> 
>> +	if (total_gain > 1 && rem >= total_gain / 2)
>> +		tmp += 1ULL;
>>   
>>   	return iio_gts_delinearize(tmp, NANO, scale_int, scale_nano);
>>   }
>> @@ -192,7 +234,7 @@ static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
>>   		sort(gains[i], gts->num_hwgain, sizeof(int), iio_gts_gain_cmp,
>>   		     NULL);
>>   
>> -		/* Convert gains to scales */
>> +		/* Convert gains to scales. */
> 
> Grumble - unrelated change.

Yes. I'll drop this.

> 
>>   		for (j = 0; j < gts->num_hwgain; j++) {
>>   			ret = iio_gts_total_gain_to_scale(gts, gains[i][j],
>>   							  &scales[i][2 * j],
>>
>> base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa

All in all, I am still not 100% sure if rounding is the right ambition. 
Do we cause hidden accuracy issues by doing the rounding under the hood? 
I feel I need bigger brains :)

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

