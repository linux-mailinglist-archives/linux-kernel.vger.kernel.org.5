Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B668A7BB153
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 08:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjJFGFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 02:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjJFGFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 02:05:13 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63F4CA;
        Thu,  5 Oct 2023 23:05:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50585357903so2307456e87.2;
        Thu, 05 Oct 2023 23:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696572310; x=1697177110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cMKqeHdcLaYIVOad0Hv0/Btgcw9EyTJiBgrMl1ZuO8=;
        b=g87U6IsbR7eqONA1OzYNjc2tH7LipysBIn//d9Ggw45sQZ9/gyd784710gpE/D4+uN
         Yi+wctSTNfFk5O6wJXIuUZrdvLF4POQEyj/vbliBaVTt0PWpgtkLzujMzhTuFSt2RFyg
         oe6sZYnUbw+MizJ4KX3oZKXs7bWtCXOizjx+JVJd/rYu0o398sZcY1vpOqXxqbVAMIJz
         nqXbE99wO/u1+M8cZz6iDlxNzngtnCm19Mr4AB7IRSJTp2OCv+LikDUf3BNOj9pZkpGK
         ZmBkZKg9zUR3KViqmJNtacqbIeBSyCnFtnNrQNQgaBlRVDkSzVr3fZ+ca6MgTSzVvUli
         BXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696572310; x=1697177110;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3cMKqeHdcLaYIVOad0Hv0/Btgcw9EyTJiBgrMl1ZuO8=;
        b=JIFuJ/qIyhpgC4ejXKIhHDf/xfZPjAnabELv11TP+3wq0jwvU2lKqFCkAjZlsZTbMX
         IBJPE9m9u75B1CMSUE7N1QwyoS47E8qoWMWkjAcROv6S9tLfvTJ+KUNNTaRv+JyW1J/T
         SYSBShz5XB7akT1ZwLk+xMH8NAXKpz9+HKTlb/z/rlcb0HjWSVnONfia0Xhab4TQ6Pz6
         yvWqiQePX+Oea5kXbTqTkwiUf8nGii2nOMazi8rhRTTv6zTK0VhwPCra62+oTNZMcUAr
         hFpSwVZR8lzgGVcSfat8c3GwGqE1TwLautauRJb0P0kNjpLxkOJlzhMBobPN58SBzhn2
         fdug==
X-Gm-Message-State: AOJu0YxEruuYRbPaFDM3f9jqrOxp6C6yz4tGk3B1XjvfDLnphK7O/JoV
        enSii9X7mR9li1jhD70BghnOvlDOIVY=
X-Google-Smtp-Source: AGHT+IEDGdDfaB6KxKnyN8VLdPCGcMaXaolIZnTkW2IMzKBXIwIyLvfl1Dpdc5VcltY2KqSxLuYZrg==
X-Received: by 2002:ac2:5f98:0:b0:503:18c3:d881 with SMTP id r24-20020ac25f98000000b0050318c3d881mr5762602lfe.14.1696572309449;
        Thu, 05 Oct 2023 23:05:09 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::7? (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id a6-20020a056512020600b004f85d80ca64sm162955lfo.221.2023.10.05.23.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 23:05:09 -0700 (PDT)
Message-ID: <fffbf40f-c2be-60d6-8a6f-4790a8e309ea@gmail.com>
Date:   Fri, 6 Oct 2023 09:05:08 +0300
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
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

I am extremely conservative what comes to adding unit tests. I have seen 
some projects where the amount of existing unit test code made code 
changes very much very slow - stopping people doing any improvements. 
Basically, no one wanted to touch the existing code unless it was 
absolutely must because even a minor code change caused several tests to 
break. OTOH, that unit test setup did not only test that end result of a 
function was expected - it did also check the calls done from the 
function to be tested - checking for example that the certain prints 
appeared with certain inputs and so on. That project stopped being fun 
very quickly...

But yes. After spending a while reading IIO code, I agree that _some_ 
parts of it could benefit from a few carefully designed unit tests. (And 
sorry, I haven't checked what tests are existing already - so may be 
there already is relevant tests) :) Channel data demuxing and the mask 
handling are indeed the first to come to my mind ;) I wouldn't dare to 
touch that part without some testing.

> Still that's a job for another day.

Hey, we need to have something for tomorrow, right? :)

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
>>   
>>   static const struct iio_buffer_setup_ops noop_ring_setup_ops;
>>   
>> +static void iio_sanity_check_avail_scan_masks(struct iio_dev *indio_dev)
>> +{
>> +	unsigned int num_masks, masklength, longs_per_mask;
>> +	const unsigned long *av_masks;
>> +	int i;
>> +
>> +	av_masks = indio_dev->available_scan_masks;
>> +	masklength = indio_dev->masklength;
>> +	longs_per_mask = BITS_TO_LONGS(masklength);
>> +
>> +	if (bitmap_empty(av_masks, masklength))
>> +		dev_warn(indio_dev->dev.parent, "empty scan mask\n");
> 
> They'd definitely notice this one as you'd never be able to enable the
> buffer - if someone hasn't tested that, then meh.  Still this function
> is called sanity_check so might as well check for insanity.
> 
> 
>> +
>> +	for (num_masks = 0; *av_masks; num_masks++)
> 
> I think we can't just check *av_masks - need bitmap_empty() as first
> long might be 0 but could be bits set in the next one.

Ah. In case where we have bitmap consisting of many longs. Indeed. By 
the way, I think I stole this check from the actual matching code - we 
should probably fix it as well.

>> +		av_masks += longs_per_mask;
> hmm. Makes me wonder if the available scan mask stuff actually works
> for large numbers of channels (so more than one long).

After you pointed out the problem in for-condition - it probably does 
not work for all cases.

>  I don't think
> we have any drivers that both have large channel counts and use
> available_scan_masks.   The code is there to support matching in this
> case but probably wants a selftest at somepoint to make sure it will work
> if such a device comes along...
> 
> 
>> +
>> +	if (num_masks < 2)
>> +		return;
> 
> Not sure it's worth bothering with this early exit route.  The loops
> will be trivial anyway if num_masks == 1.

I probably thought about the num_masks == 0 when adding this check. 
Decided we might just early exit while checking.

>> +
>> +	av_masks = indio_dev->available_scan_masks;
>> +
>> +	/*
>> +	 * Go through all the masks from first to one before the last, and see
>> +	 * that no mask found later from the available_scan_masks array is a
>> +	 * subset of mask found earlier. If this happens, then the mask found
>> +	 * later will never get used because scanning the array is stopped when
>> +	 * the first suitable mask is found. Drivers should order the array of
>> +	 * available masks in the order of preference (presumably the least
>> +	 * costy to access masks first).
>> +	 */
>> +	for (i = 0; i < num_masks - 1; i++) {
>> +		const unsigned long *mask1;
>> +		int j;
>> +
>> +		mask1 = av_masks + i * longs_per_mask;
>> +		for (j = i + 1; j < num_masks; j++) {
>> +			const unsigned long *mask2;
>> +
>> +			mask2 = av_masks + j * longs_per_mask;
>> +			if (bitmap_subset(mask2, mask1, masklength))
>> +				dev_warn(indio_dev->dev.parent,
>> +					 "available_scan_mask %d subset of %d. Never used\n",
>> +					 j, i);
>> +		}
>> +	}
>> +}
>> +
>>   int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>>   {
>>   	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>> @@ -1934,6 +1981,16 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>>   		goto error_unreg_debugfs;
>>   	}
>>   
>> +	/*
>> +	 * In order to not wreck utter havoc we just warn for now. Might want
>> +	 * to convert this to a failure after people have had time to act upon
>> +	 * the warning. It'd be nice to check this earlier, but we need the
>> +	 * iio_buffers_alloc_sysfs_and_mask() to have the masklength set.
> 
> It's not going to break anyone if they get this wrong, they will just waste time
> and possibly power reading too many channels!  So warn is appropriate I think.
> 
> I'm not sure the comment adds much in general so I'd slim it down or drop it
> from v2.

I'm fine with dropping the comment. My mindset is easily leaning too 
much on developing new drivers when I think of checks like this one. 
It'd be nice to get a noticeable kick immediately when developing a 
driver - but yes, one should be kicked just by the warning alone.

> 
>> +	 */
>> +	if (indio_dev->available_scan_masks)
>> +		iio_sanity_check_avail_scan_masks(indio_dev);
>> +
> One blank line is enough ;)

Again... Thanks!

>> +
>>   	ret = iio_device_register_sysfs(indio_dev);
>>   	if (ret) {
>>   		dev_err(indio_dev->dev.parent,
>>
>> base-commit: 5e99f692d4e32e3250ab18d511894ca797407aec

Yours,
	-- Matti

> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

