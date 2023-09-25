Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0065B7AD59E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjIYKNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjIYKNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:13:39 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC61A1F3A;
        Mon, 25 Sep 2023 03:00:34 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c108e106f0so98104541fa.1;
        Mon, 25 Sep 2023 03:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695636033; x=1696240833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/o3FtyN/M43LVOztcAAaYp0qOn7y3kK747BgfOPY7E=;
        b=l8aRo9S2dUd3xGsys4DajzAkcFTWq3ahAq00mlvMnN+mgbQCYZyLQS/NJ7ppB+zlwZ
         H9OL5CyImd2NUdPxx/qK6XUL/juOjECk4YGJpd+CI69xHYc+UMJMt5Vlp19mT2zij8i+
         psFRGoTexhGydyT/ke77slkNwN0lzmFS2FsoDSQouAFtB5OhUtucIL4t0cYGrevBHynl
         lHUgbcFdz+RaNA5afstsABvbTdsOjie8D5LLyPjCbiTlr8Pqcy8G3m0GqrFsA1GyIxOr
         sK9c151MVoduYKYaloA64pEKDzb3yfyHR6tiSnmj2oMtzrwXkvZ2GT/82RdzwPJqIEhS
         sAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695636033; x=1696240833;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/o3FtyN/M43LVOztcAAaYp0qOn7y3kK747BgfOPY7E=;
        b=dPgUvs8/khgf0AcsWSivIzpE+zdesIZVqPr5laRqLrxMl+IqaeuTm7HSe5GjN0Bjby
         34Nvoe0VifYBP8S8wqtY62GWUU8g343RJnRT0of8uzUfOHc0es/wM40IZnZaihGRmFOo
         ZuGaXnnWApWAseHXaZ+KTj19Rd2YGovNV12/v8KInWLqpmn+1DiGEBhoE4YgzBpVJghR
         nwKkrovjQ/UWAYHUO1DEGMwAgDR5w59w0Jwh9av/zETkmr9X7bpU66ka3r4KJzj8bb0n
         gSQET/jb+XV+deidhjozc7QPD21SiS2nXvc613i4i8THaQJaKVGxfQJIXWy46qkOm8g9
         jBSg==
X-Gm-Message-State: AOJu0YwzmX2ESCIoDoMz3EIdp15L1N/zqq+7w6TLrl+I8qYINM8UGktH
        qU274DEPg8/0nmTFSAwiTDk=
X-Google-Smtp-Source: AGHT+IEOVWlKqBByYVj7jP3IDRYOmVXjzFnGlLQFq8oeDQ2viE5jy9AGd+AqyC9kcSTqGJDyL1MhoA==
X-Received: by 2002:a2e:4949:0:b0:2bc:da3e:3bda with SMTP id b9-20020a2e4949000000b002bcda3e3bdamr5448662ljd.2.1695636032144;
        Mon, 25 Sep 2023 03:00:32 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id j23-20020a2e3c17000000b002bff365c7bfsm2115950lja.35.2023.09.25.03.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 03:00:31 -0700 (PDT)
Message-ID: <d308105a-f177-60a3-770e-2eea4333efa5@gmail.com>
Date:   Mon, 25 Sep 2023 13:00:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Benjamin Bara <bbara93@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1695380366.git.mazziesaccount@gmail.com>
 <24a577e6e157e1199817ab36631cec51675ef3ca.1695380366.git.mazziesaccount@gmail.com>
 <20230924170726.41443502@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 3/6] iio: try searching for exact scan_mask
In-Reply-To: <20230924170726.41443502@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/23 19:07, Jonathan Cameron wrote:
> On Fri, 22 Sep 2023 14:17:49 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> When IIO goes through the available scan masks in order to select the
>> best suiting one, it will just accept the first listed subset of channels
>> which meets the user's requirements. This works great for most of the
>> drivers as they can sort the list of channels in the order where
>> the 'least costy' channel selections come first.
>>
>> It may be that in some cases the ordering of the list of available scan
>> masks is not thoroughly considered. We can't really try outsmarting the
>> drivers by selecting the smallest supported subset - as this might not
>> be the 'least costy one' - but we can at least try searching through the
>> list to see if we have an exactly matching mask. It should be sane
>> assumption that if the device can support reading only the exact
>> channels user is interested in, then this should be also the least costy
>> selection - and if it is not and optimization is important, then the
>> driver could consider omitting setting the 'available_scan_mask' and
>> doing demuxing - or just omitting the 'costy exact match' and providing
>> only the more efficient broader selection of channels.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Whilst I fully agree with the reasoning behind this, I'd rather we
> did an audit of drivers to find any that have a non logical order
> (one came up today in review) and fix them up.
> 
> A quick and dirty grep didn't find it to be a common problem, at least
> partly as most users of this feature only provide one valid mask.

It's always good to hear there is not many problems found :) This patch 
was not inspired by auditing the existing code - it was inspired by the 
fact that I would have wrongly ordered the available_scan_masks for 
bm1390 myself. I just happened to notice the oddity in active_scan_masks 
while I was trying to figure out if it was the driver, IIO or user-space 
code which messed my buffer when I disabled timestamps.

> The few complex corners I found appear to be fine with the expected
> shortest sequences first.
> 
> Defending against driver bugs is losing game if it makes the core
> code more complex to follow by changing stuff in non debug paths.

I think I agree, although I could argue that it depends on the amount of 
added complexity. Still ...

> One option might be to add a trivial check at iio_device_register()

... this suggestion is superior to the check added in this patch.

> that we don't have scan modes that are subsets of modes earlier in the list.
> These lists are fairly short so should be cheap to run.

Yes. And running the check at the registration phase should not be a big 
problem. And, if it appears to be a problem, then we can add a 
registration variant which omits the checks for those rare drivers which 
would _really_ be hurt by the few extra cycles spent on registration.

> That would incorporate ensuring exact matches come earlier by default.

Yes. I like the idea, wish I had invented it myself ;)

> 
> Jonathan
> 
> 
>> ---
>>   drivers/iio/industrialio-buffer.c | 25 +++++++++++++++++++------
>>   1 file changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>> index 176d31d9f9d8..e97396623373 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -411,19 +411,32 @@ static const unsigned long *iio_scan_mask_match(const unsigned long *av_masks,
>>   						const unsigned long *mask,
>>   						bool strict)
>>   {
>> +	const unsigned long *first_subset = NULL;
>> +
>>   	if (bitmap_empty(mask, masklength))
>>   		return NULL;
>> -	while (*av_masks) {
>> -		if (strict) {
>> +
>> +	if (strict) {
>> +		while (*av_masks) {
>>   			if (bitmap_equal(mask, av_masks, masklength))
>>   				return av_masks;
>> -		} else {
>> -			if (bitmap_subset(mask, av_masks, masklength))
>> -				return av_masks;
>> +
>> +			av_masks += BITS_TO_LONGS(masklength);
>>   		}
>> +
>> +		return NULL;
>> +	}
>> +	while (*av_masks) {
>> +		if (bitmap_equal(mask, av_masks, masklength))
>> +			return av_masks;
>> +
>> +		if (!first_subset && bitmap_subset(mask, av_masks, masklength))
>> +			first_subset = av_masks;
>> +
>>   		av_masks += BITS_TO_LONGS(masklength);
>>   	}
>> -	return NULL;
>> +
>> +	return first_subset;
>>   }
>>   
>>   static bool iio_validate_scan_mask(struct iio_dev *indio_dev,
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

