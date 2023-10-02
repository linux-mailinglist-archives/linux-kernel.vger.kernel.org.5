Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59187B4C90
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbjJBHdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbjJBHdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:33:37 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4BD83;
        Mon,  2 Oct 2023 00:33:33 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c28e35752cso26803531fa.0;
        Mon, 02 Oct 2023 00:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696232011; x=1696836811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tPMk98xbDjSu/d7zq/OqT3E5dxTEAuHNUfRDfBNu09M=;
        b=iHoFqerJLWvsMbJ1X18xKeGDB4a7MMRMcgJPr0DrBM5iRCtzHG8b0U63BqdpuPDRq+
         h3NgBSjvqGWZo2qLiiYPrw2kjbJbAxWsSiZDJ7jbevt9ynoPA1KfmS4mrxjU7h4zNCrA
         dViSSsJe/ou/ei8j+dol2U31RIz/fVpLs84UAruRbl60owdnr8omCJDNoukNmE2VtCyP
         BwGDMPO1/hrF/fefSXDKZw4ah3eo8cEAmiXReZ0BSuAD2eEkjcQtML6OaPaEc41YEPoy
         vdeHp3inYwHlpRgIuLpHDDM11GKq236Ds178EdehrtXg6ygTTcfTLtamvNHV3GTlb3UZ
         Jelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696232011; x=1696836811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tPMk98xbDjSu/d7zq/OqT3E5dxTEAuHNUfRDfBNu09M=;
        b=WzjULZZWPimoMfaWMHmrh6xap+heoIjkb20a05d9wO81v+vKWszWHGOdWDQnyK4lnz
         V9amKrhSZCTf7nj09v4n/u467m3TSay2ZWz6MjcGj7O8JHGMO8Yv1L5BgRDmB1dmkaPZ
         5hZHCOQ233geBqonSlcFIMOocWCn6KDOp/WDexqbjqHEGa3ym661OXa6yTaRJ0/1XwHP
         Wh3eYVUxJ15/TT5UQ/WZY/Qo131A9QTMiEIWshlUoed4nZsHl0L1/PNzUg6WzBtGJ4N1
         R48eRPousgmGYSeYuyHwtKtKcX+HDZq50SzsPdxbgxM1vOBwLrHmPWVCQn+9TVBF1dx+
         p/EA==
X-Gm-Message-State: AOJu0YzXuN1xX3jj1ct40OgextH1TmFrWpp+2PXl+GWtJG+psRw0Exy3
        e2s392pPDgGzCmiMrwhir5iRgXgctao=
X-Google-Smtp-Source: AGHT+IEKUBzdD3IBYzVwMB+ztCKmxhrGIchOs8J21tfb3W3iZHq6hiK+7zJFt9eI0T6sgshZw91YCw==
X-Received: by 2002:a2e:9652:0:b0:2bc:c004:cc22 with SMTP id z18-20020a2e9652000000b002bcc004cc22mr9106922ljh.33.1696232011243;
        Mon, 02 Oct 2023 00:33:31 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::7? (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id p20-20020a2e9a94000000b002b9f0fb5f20sm5155259lji.72.2023.10.02.00.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 00:33:30 -0700 (PDT)
Message-ID: <7e571a3c-ccd4-22cc-f1a0-c69b62aa2f7a@gmail.com>
Date:   Mon, 2 Oct 2023 10:33:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/5] tools: iio: iio_generic_buffer ensure alignment
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Benjamin Bara <bbara93@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1695727471.git.mazziesaccount@gmail.com>
 <e986b4562ca663e19ea30b81d15221c15bd87227.1695727471.git.mazziesaccount@gmail.com>
 <20230930173409.4fe38d94@jic23-huawei>
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230930173409.4fe38d94@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/23 19:34, Jonathan Cameron wrote:
> On Wed, 27 Sep 2023 11:26:07 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The iio_generic_buffer can return garbage values when the total size of
>> scan data is not a multiple of the largest element in the scan. This can be
>> demonstrated by reading a scan, consisting, for example of one 4-byte and
>> one 2-byte element, where the 4-byte element is first in the buffer.
>>
>> The IIO generic buffer code does not take into account the last two
>> padding bytes that are needed to ensure that the 4-byte data for next
>> scan is correctly aligned.
>>
>> Add the padding bytes required to align the next sample with the scan size.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> I think the whole alignment code could be revised here, but I am unsure
>> what kind of alignment is expected, and if it actually depends on the
>> architecture. Anyways, I'll quote myself from another mail to explain
>> how this patch handles things:
>>
>>> For non power of2 sizes, the alignment code will result strange alignments.
>>> For example, scan consisting of two 6-byte elements would be packed -
>>> meaning the second element would probably break the alignment rules by
>>> starting from address '6'. I think that on most architectures the proper
>>> access would require 2 padding bytes to be added at the end of the first
>>> sample. Current code wouldn't do that.
>>
>>> If we allow only power of 2 sizes - I would expect a scan consisting of a
>>> 8 byte element followed by a 16 byte element to be tightly packed. I'd
>>> assume that for the 16 byte data, it'd be enough to ensure 8 byte alignment.
>>> Current code would however add 8 bytes of padding at the end of the first
>>> 8 byte element to make the 16 byte scan element to be aligned at 16 byte
>>> address. To my uneducated mind this is not needed - but maybe I just don't
>>> know what I am writing about :)
>>
>> Revision history
>> v3 => v4:
>>   - drop extra print and TODO coment
>>   - add comment clarifying alignment sizes
>> ---
>>   tools/iio/iio_generic_buffer.c | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
>> index 44bbf80f0cfd..c07c49397b19 100644
>> --- a/tools/iio/iio_generic_buffer.c
>> +++ b/tools/iio/iio_generic_buffer.c
>> @@ -54,9 +54,12 @@ enum autochan {
>>   static unsigned int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
>>   {
>>   	unsigned int bytes = 0;
>> -	int i = 0;
>> +	int i = 0, max = 0;
>> +	unsigned int misalignment;
>>   
>>   	while (i < num_channels) {
>> +		if (channels[i].bytes > max)
>> +			max = channels[i].bytes;
>>   		if (bytes % channels[i].bytes == 0)
>>   			channels[i].location = bytes;
>>   		else
>> @@ -66,6 +69,19 @@ static unsigned int size_from_channelarray(struct iio_channel_info *channels, in
>>   		bytes = channels[i].location + channels[i].bytes;
>>   		i++;
>>   	}
>> +	/*
>> +	 * We wan't the data in next sample to also be properly aligned so
>> +	 * we'll add padding at the end if needed.
>> +	 *
>> +	 * Please note, this code does ensure alignment to maximum channel
>> +	 * size. It works only as long as the channel sizes are 1, 2, 4 or 8
>> +	 * bytes. Also, on 32 bit platforms it might be enough to align also
>> +	 * the 8 byte elements to 4 byte boundary - which this code is not
>> +	 * doing.
> Very much not!  We need to present same data alignment to userspace
> indpendent of what architecture is running.
> 
> It's annoyingly inconsistent how 8 byte elements are handled on 32 bit
> architectures as some have optimized aligned access routines and others
> will read as 2 32 bit fields.  Hence we just stick to 8 byte value is
> 8 byte aligned which is always fine but wastes a bit of space on x86 32
> bit - which I don't care about ;)
> 
> Please drop this last bit of the comment as we should just say what it
> does, not conjecture what it might do!

Ok. The comment was more to catch the reviewers' attention ;) I'll just 
note the alignment works for power of 2 sample sizes and aligns 
according to the max sized sample, even if it was bigger than 8.

Thanks!

-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

