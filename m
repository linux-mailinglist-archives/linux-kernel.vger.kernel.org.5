Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534AB7B0435
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjI0McW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjI0McU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:32:20 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D854C0;
        Wed, 27 Sep 2023 05:32:19 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c135cf2459so167166951fa.0;
        Wed, 27 Sep 2023 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695817938; x=1696422738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OZqZ0i46ZbfB53UJOvUsR3ac/FK/L9kDlsccF+BQc6I=;
        b=daChzakE3Kl4dT6g3EYRYyYN2SHfSk1a/Jo6J+nhh0ldLYXp3ziYHC5DNLDt4j+t5K
         KDU/QNEOF126owm0PdevY43q7f4fkE9LVJW2z7ilgtrcvRHqBeipQ9yMFbUZvspPTzm/
         IRUbLr3bB8aX8iVSjc5tWfHMvS3id7zZezoUWXHPPgEtQ337uWWVqT3KTUKEqpwlPEdh
         SWfuTn4GOT5kNAwUipXUr0DscJzdosL8zuMYrZ6nIsYfl0wQkjpEJEiR+pX6AIYnkPzp
         CFLIJWlI0NFg5evk2AR8OgTuXfIoKYHRMsCg+14a5BSJmi32ZyIajME1B0sXJ5oVxnwi
         0gGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695817938; x=1696422738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZqZ0i46ZbfB53UJOvUsR3ac/FK/L9kDlsccF+BQc6I=;
        b=a59xL6FeB4G/3BVsHlGSsfMyKCC7GDkVYd5inGu9SxNxPkjOLf1ZAWx+2cpuzGRnMX
         7TGdmwPbDHOcRKYT8BCOxd+IjLLyPJTusDFURF3jBiTNCHZoCTmHPJ/YLvNh2tA292Ll
         YXtlYpBaRegI4CvaSlo1FQnvg8j/XGvxiFQxC65uj0jY/68mO1VZrJZxTjJIY4RPmn7x
         yq2lyLNudC4bia5Q5f1Wnjz1nG4RxswLO2SaEqj+H9SCll+g1Zo+8z+gf17Q2Mk2yk9n
         f3xMWVlI300Cnxi52FlG7keZGu6UDsinUtRjpEF85xwQ05DjMgn5VHyPlpgOY6M8UJ/5
         Z/Ug==
X-Gm-Message-State: AOJu0YzTAfxi9UhHAIpXBc8xfNnwv/imB2NKIASuQAiIWqUEcvRDB+6I
        6vQ/xpNzufzj81QWexfoAh0=
X-Google-Smtp-Source: AGHT+IFmoB4WikFU+B1c7rCtwR8zPyofWug3I3QyKA9JKmEgXhOMbYa7WLMuKvgBA41xT/G+4RKC6g==
X-Received: by 2002:a2e:9a8e:0:b0:2bf:f84e:c1ec with SMTP id p14-20020a2e9a8e000000b002bff84ec1ecmr1939557lji.13.1695817937386;
        Wed, 27 Sep 2023 05:32:17 -0700 (PDT)
Received: from [172.16.183.71] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id p23-20020a2e8057000000b002c0d9d83f71sm3033259ljg.62.2023.09.27.05.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 05:32:16 -0700 (PDT)
Message-ID: <a7096e0c-7132-5511-2fe0-1172caec5a7f@gmail.com>
Date:   Wed, 27 Sep 2023 15:32:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/5] tools: iio: iio_generic_buffer ensure alignment
Content-Language: en-US, en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Benjamin Bara <bbara93@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1695727471.git.mazziesaccount@gmail.com>
 <e986b4562ca663e19ea30b81d15221c15bd87227.1695727471.git.mazziesaccount@gmail.com>
 <ZRQfyNX9WsvmpZ1r@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ZRQfyNX9WsvmpZ1r@smile.fi.intel.com>
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

On 9/27/23 15:27, Andy Shevchenko wrote:
> On Wed, Sep 27, 2023 at 11:26:07AM +0300, Matti Vaittinen wrote:
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
> 
> ...
> 
>> +	/*
>> +	 * We wan't the data in next sample to also be properly aligned so
> 
> Pardon me, won't or want, I didn't get?..

Both :D Well, purpose was to say want, but as I try to explain we get 
what we want only in some case - in other cases we won't ;) Anyways, 
this is something that should be fixed - thanks :)

> 
>> +	 * we'll add padding at the end if needed.
>> +	 *
>> +	 * Please note, this code does ensure alignment to maximum channel
>> +	 * size. It works only as long as the channel sizes are 1, 2, 4 or 8
>> +	 * bytes. Also, on 32 bit platforms it might be enough to align also
> 
> 32-bit
> 
>> +	 * the 8 byte elements to 4 byte boundary - which this code is not
> 
> 8-byte
> 4-byte
> 
>> +	 * doing.
>> +	 */
> 

Thanks!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

