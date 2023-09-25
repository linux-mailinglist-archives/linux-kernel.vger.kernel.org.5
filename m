Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D417AD0F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjIYHB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjIYHBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:01:22 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30853E8;
        Mon, 25 Sep 2023 00:01:14 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c038a1e2e6so86865391fa.2;
        Mon, 25 Sep 2023 00:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695625272; x=1696230072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iYQkx42hAwqXvNKUFpRxlN/NVuhqNtrXo/dMgV1J1JM=;
        b=PiO1YVkXzglRkSragH7pph1GRSKpYQYw1xeyH8mbZLlQgoWpf0IrY41TTmEEqA0Bwo
         P1HNN0IgDxLmT319N19j9EB88NxzEEfzyklPnUWCU+m0wUUhOgMBBJgr/sVGF9X7IUFB
         cF6i1Pvai91/18LJpynIq3toHUcZDzzunfLoZ88vmH5bhRHqt3naD8IuYOy8th5jPPHD
         xjyozQsl8qWnE4zRa1ns2VY9DwDGiOB4eZY2vLv9BUFKuyAg10XlDbhaw/cQDaG9EM7w
         v2L9ZYM4/soYzqdCCEWhmt+P0AzW7Ou7ox/QgVzRvfCH2jvbA/a+/Gxk3IRguzvZfU/5
         JPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695625272; x=1696230072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iYQkx42hAwqXvNKUFpRxlN/NVuhqNtrXo/dMgV1J1JM=;
        b=kJFwnSMyAUp1/Xp/AMHAdmGC6F/SbnvMAnvTQwLR+vlDFK83XeLPvqBtwtkkr0YqZ/
         WBR2V4vQujZuyqBjbtMfIWibIH4097OQ9GSLmLcttKufQbSakjqZh7V0aASOJO3azkOS
         zNBUDzdlD+GpUv3TSg6PGoJgj8l3iLEf8V1EojdBOC11sbiAXEr35r3krmPBo5yG8MxP
         xJwRnVRGKlfrGFxBk+/vaqymwqaP895YZGiypgU263BZrO4B3jK6lu7TnEHkLrTVeyfh
         ZBKDyDkCoPz/AC2fPr1p0ppU5Jtdx7ZHtShURaYbFtD2fm8OmxhOoC1bs/dpu/A6//QO
         ot9Q==
X-Gm-Message-State: AOJu0Yzv/lFyLGFKh9/+nzz14pjEFrC7Wy2jyxyTPSeDz4t/s/mDgzNL
        nfPIhIOLoo4uXm6GbFryRmE=
X-Google-Smtp-Source: AGHT+IHTnpauAoRjZUS0BV1CBUX4/GxNP2t4RiiSUtfvjd9Hed1meKRyFYk5XtDTfjyDNiU8VmAmCQ==
X-Received: by 2002:a2e:730b:0:b0:2bc:b75e:b88 with SMTP id o11-20020a2e730b000000b002bcb75e0b88mr4964849ljc.18.1695625271923;
        Mon, 25 Sep 2023 00:01:11 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id p2-20020a2e9a82000000b002c001e57e1asm2086956lji.73.2023.09.25.00.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 00:01:11 -0700 (PDT)
Message-ID: <7ff22aa4-475c-b524-9f7a-f47ad02e940b@gmail.com>
Date:   Mon, 25 Sep 2023 10:01:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/6] tools: iio: iio_generic_buffer ensure alignment
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
 <029b4e3e18c76b330b606f5b14699e5ee4e5ed35.1695380366.git.mazziesaccount@gmail.com>
 <20230924165737.54631dd3@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230924165737.54631dd3@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/23 18:57, Jonathan Cameron wrote:
> On Fri, 22 Sep 2023 14:16:08 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The iio_generic_buffer can return garbage values when the total size of
>> scan data is not a multiple of largest element in the scan. This can be
>> demonstrated by reading a scan consisting for example of one 4 byte and
>> one 2 byte element, where the 4 byte elemnt is first in the buffer.
>>
>> The IIO generic buffert code does not take into accunt the last two
>> padding bytes that are needed to ensure that the 4byte data for next
>> scan is correctly aligned.
>>
>> Add padding bytes required to align the next sample into the scan size.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>> Please note, This one could have RFC in subject.:
>> I attempted to write the fix so that the alignment is done based on the
>> biggest channel data. This may be wrong. Maybe a fixed 8 byte alignment
>> should be used instead? This patch can be dropped from the series if the
>> fix is not correct / agreed.
>>
>>   tools/iio/iio_generic_buffer.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
>> index 44bbf80f0cfd..fc562799a109 100644
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
>> @@ -66,6 +69,16 @@ static unsigned int size_from_channelarray(struct iio_channel_info *channels, in
>>   		bytes = channels[i].location + channels[i].bytes;
>>   		i++;
>>   	}
>> +	/*
>> +	 * We wan't the data in next sample to also be properly aligned so
>> +	 * we'll add padding at the end if needed. TODO: should we use fixed
>> +	 * 8 byte alignment instead of the size of the biggest samnple?
>> +	 */
> 
> Should be aligned to max size seen in the scan.

Or, maybe it should be
min(max_size_in_scan, 8);
?

I think my suggestion above may yield undesirable effects should the 
scan elements be greater than 8 bytes. (Don't know if this is supported 
though)

> 
>> +	misalignment = bytes % max;
>> +	if (misalignment) {
>> +		printf("Misalignment %u. Adding Padding %u\n", misalignment,  max - misalignment);
> 
> No print statement as this is correct behaviour (well the tool is buggy but the kernel generates it
> correctly I believe).  Fine to add a comment though!

Oh, indeed. The print was forgotten from my test runs. Thanks for 
pointing it out!

> 
>> +		bytes += max - misalignment;
>> +	}
>>   
>>   	return bytes;
>>   }
> 

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

