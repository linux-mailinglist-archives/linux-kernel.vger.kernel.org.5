Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1077AEA60
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjIZK3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbjIZK3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:29:15 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD96510A;
        Tue, 26 Sep 2023 03:29:06 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-503397ee920so13400264e87.1;
        Tue, 26 Sep 2023 03:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695724145; x=1696328945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xa2PU5N2xNGK9Su4ImxGCgeAIFPvrKSixnyIu5Skjqc=;
        b=Tb55q7l3kDQ9ajTtSrJa/XvcV1F17h0DWNvnBsfRtN8FEiKx0NWL3KuY1I79gCAqdi
         sT1GMNGkRfboWQLBRi2l/r2EiJhcnmwHw1tLmhc7lgPZvUVmTFj0aqyUiPvAhAjsovxH
         2vlvydaCcPBP1oaOi15xKTIpPJ1vX1JdacenvWMDPCDeaU0BIDB+RuFvV4mnBK2RB6Lx
         kE75qb6idimIkiKYz77Obf+3sDmop5RY6yU76A1+TwOAPIhg6OQ/aeami+U/Fq3I5WUe
         2gqkUk9D1P8NH7r43EFhkcQfhx68IV9O/WTVe0WilAkFCrZ2iwEH4RRw3mFHWyoqg61x
         Jv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695724145; x=1696328945;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xa2PU5N2xNGK9Su4ImxGCgeAIFPvrKSixnyIu5Skjqc=;
        b=tNc1U5luBR0vgD+eHTedGxiTrb4x9Eli9EvyiH/ZRt+GFHlQB4hZvuw46oiXnF/UVI
         daacvgopsHxwtOJc9JPQ1zIMFlDCikw/bDinEyIKfagKt/N0v/piOol9AwsSngGJq3HO
         prpRF6VALACYrm4F0LGHcWAyUIxVw6EdL/lOuJUbvws1QeCp6OBwkSNYY2rxxsAscKvS
         2OjY15DQTUUm3n3nitZIUJ9kEvXfpU82dpyOH+i1kWKq7gijbYsTTvinwL7TBJq6mGdv
         hFmoY8fPHhPZg7fm/MkF2CjdM1K1IhuoBZVJzl0xGwhePVitftubPSxNcDDhXUHh/6kc
         eY+A==
X-Gm-Message-State: AOJu0Yxwqx8JhR7aG02fpwmbRpF1b3GTwGea1X/Nfr/00tFcHlNPjbsj
        XkzZtIHM1CggRYV1zJPh81A=
X-Google-Smtp-Source: AGHT+IGtdahcCPQpmkpbmkShXhVc/B7ZKEDiesRx6+DhZAlY9pttjpYsxztG+27VW5UFy4yhEwX38Q==
X-Received: by 2002:a05:6512:4890:b0:503:102c:7a05 with SMTP id eq16-20020a056512489000b00503102c7a05mr7005634lfb.58.1695724144278;
        Tue, 26 Sep 2023 03:29:04 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id c18-20020ac244b2000000b0050363f87c64sm2153372lfm.36.2023.09.26.03.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 03:29:03 -0700 (PDT)
Message-ID: <50587108-4ba7-3885-0669-7efaf5528233@gmail.com>
Date:   Tue, 26 Sep 2023 13:29:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
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
 <7ff22aa4-475c-b524-9f7a-f47ad02e940b@gmail.com>
 <20230925141629.00004522@Huawei.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 1/6] tools: iio: iio_generic_buffer ensure alignment
In-Reply-To: <20230925141629.00004522@Huawei.com>
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

On 9/25/23 16:16, Jonathan Cameron wrote:
> On Mon, 25 Sep 2023 10:01:09 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 9/24/23 18:57, Jonathan Cameron wrote:
>>> On Fri, 22 Sep 2023 14:16:08 +0300
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>    
>>>> The iio_generic_buffer can return garbage values when the total size of
>>>> scan data is not a multiple of largest element in the scan. This can be
>>>> demonstrated by reading a scan consisting for example of one 4 byte and
>>>> one 2 byte element, where the 4 byte elemnt is first in the buffer.
>>>>
>>>> The IIO generic buffert code does not take into accunt the last two
>>>> padding bytes that are needed to ensure that the 4byte data for next
>>>> scan is correctly aligned.
>>>>
>>>> Add padding bytes required to align the next sample into the scan size.
>>>>
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>> ---
>>>> Please note, This one could have RFC in subject.:
>>>> I attempted to write the fix so that the alignment is done based on the
>>>> biggest channel data. This may be wrong. Maybe a fixed 8 byte alignment
>>>> should be used instead? This patch can be dropped from the series if the
>>>> fix is not correct / agreed.
>>>>
>>>>    tools/iio/iio_generic_buffer.c | 15 ++++++++++++++-
>>>>    1 file changed, 14 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
>>>> index 44bbf80f0cfd..fc562799a109 100644
>>>> --- a/tools/iio/iio_generic_buffer.c
>>>> +++ b/tools/iio/iio_generic_buffer.c
>>>> @@ -54,9 +54,12 @@ enum autochan {
>>>>    static unsigned int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
>>>>    {
>>>>    	unsigned int bytes = 0;
>>>> -	int i = 0;
>>>> +	int i = 0, max = 0;
>>>> +	unsigned int misalignment;
>>>>    
>>>>    	while (i < num_channels) {
>>>> +		if (channels[i].bytes > max)
>>>> +			max = channels[i].bytes;
>>>>    		if (bytes % channels[i].bytes == 0)
>>>>    			channels[i].location = bytes;
>>>>    		else
>>>> @@ -66,6 +69,16 @@ static unsigned int size_from_channelarray(struct iio_channel_info *channels, in
>>>>    		bytes = channels[i].location + channels[i].bytes;
>>>>    		i++;
>>>>    	}
>>>> +	/*
>>>> +	 * We wan't the data in next sample to also be properly aligned so
>>>> +	 * we'll add padding at the end if needed. TODO: should we use fixed
>>>> +	 * 8 byte alignment instead of the size of the biggest samnple?
>>>> +	 */
>>>
>>> Should be aligned to max size seen in the scan.
>>
>> Or, maybe it should be
>> min(max_size_in_scan, 8);
>> ?
> 
> Definitely not.   If you are grabbing just one channel of 8 bit data,
> we want it to be tightly packed.

I think that in this case the max_size_in_scan would be 1, and min(1, 8) 
would be 1 as well, resulting a tightly packed data. I am just wondering 
if we should use 8 as maximum alignment - eg, if our scan has 16 bytes 
data + 1 byte data, we would add 7 bytes of padding, not 15 bytes of 
padding. I am not sure what is the right thing to do.

> If we have a bug that already made that true then we might be stuck
> with it, but I'm fairly sure we don't.
>>
>> I think my suggestion above may yield undesirable effects should the
>> scan elements be greater than 8 bytes. (Don't know if this is supported
>> though)
> 
> It is supported in theory, in practice not seen one yet.

So, whether to unconditionally use largest scan element sized alignment 
- or largest scan element up to 8 bytes - is a question we haven't hit 
yet :)

Actually, more I stare at the alignment code here, less sure I am it is 
correct - but maybe I don't understand how the data should be aligned.

I think it works if allowed data sizes are 1, 2, 4, and 8. However, I 
suspect it breaks for other sizes.

For non power of2 sizes, the alignment code will result strange 
alignments. For example, scan consisting of two 6-byte elements would be 
packed - meaning the second element would probably break the alignment 
rules by starting from address '6'. I think that on most architectures 
the proper access would require 2 padding bytes to be added at the end 
of the first sample. Current code wouldn't do that.

If we allow only power of 2 sizes - I would expect a scan consisting of 
a 8 byte element followed by a 16 byte element to be tightly packed. I'd 
assume that for the 16 byte data, it'd be enough to ensure 8 byte 
alignment. Current code would however add 8 bytes of padding at the end 
of the first 8 byte element to make the 16 byte scan element to be 
aligned at 16 byte address. To my uneducated mind this is not needed - 
but maybe I just don't know what I am writing about :)

In any case, the patch here should fix things when allowed scan element 
sizes are 1, 2, 4 and 8 and we have to add padding after last scan 
element. It won't work for other sizes, but as I wrote, I suspect the 
whole alignment code here may be broken for other sizes so things 
shouldn't at least get worse with this patch... I think this should be 
revised if we see samples of other sizes - and in any case, this might 
at least warrant a comment here :) (I reserve a right to be wrong. 
Haven't been sleeping too well lately and my head is humming...)

>>>> +	misalignment = bytes % max;
>>>> +	if (misalignment) {
>>>> +		printf("Misalignment %u. Adding Padding %u\n", misalignment,  max - misalignment);
>>>
>>> No print statement as this is correct behaviour (well the tool is buggy but the kernel generates it
>>> correctly I believe).  Fine to add a comment though!
>>
>> Oh, indeed. The print was forgotten from my test runs. Thanks for
>> pointing it out!
>>
>>>    
>>>> +		bytes += max - misalignment;
>>>> +	}
>>>>    
>>>>    	return bytes;
>>>>    }
>>>    

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

