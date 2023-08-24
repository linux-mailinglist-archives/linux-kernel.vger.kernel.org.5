Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1ADA786FB2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240940AbjHXMxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241070AbjHXMxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:53:23 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F632102;
        Thu, 24 Aug 2023 05:53:00 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b703a0453fso110607101fa.3;
        Thu, 24 Aug 2023 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692881578; x=1693486378;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ZbCgUGLVJxh28Fxtwbt5g9eIsJm3RzEc1jzzP0yoCo=;
        b=Zm1eTXCTpxH13MilotK4gLLyp1TbdHgb3kXzTCRMZ7vm6+7pNxA5vKT8tQNSJ8w3NW
         3rM8MZZUbCWFGiOUrYDUKeL1ak8UPEI+B+4ybjWK4wGrvPlpBHPGXwrVw3ZcZj/iyQpg
         kEUcIrb5O/3QPr3UqMKaHoST5ZrljRcUnu5NzmC2BlGibqm2E3bXjySa3KFHaveorf57
         Q9ky8w0/4RYjiS12m7S+g4bz9lEqg7L4Pw2P+JSlbv02uvcpuU4Jx9I6roRqIo7qzIaT
         hrc/6wUj9EbZEu0wMu8Q9dySRYC65QGM7tKvMYVdCwGkW7Ms2loBkgIXNzchQrSVTm3A
         xuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692881578; x=1693486378;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZbCgUGLVJxh28Fxtwbt5g9eIsJm3RzEc1jzzP0yoCo=;
        b=kAA0Qzv6uK5gK0ZuK9u3SO+ABpyiXqwXPyjUEU4StrOkKLFvHoEeRPM6lB31GJYnfw
         1sAV3AnisHr51jo7z5VNeonjGAdm72kH9g7i5DHaspfFk1fyZKDcHJ4ohJ8kYX6rOuQV
         3h1iwlOC0MOYE33hzswqXJYJlcqy6KiAVg2MCi69BkVk60g1FPrDw2sPnLiBzyQu+udg
         FRLaqkoNkeH5TOdYaJGvPmH5vG2N5Hl1MKAiRBuXntOffdukEKEEOhSNa0HivnUR/tWC
         fnbp2WYqirG5Y8JTScHIHemWHYp1BNvNVLHYiE7+Fi2yoQeHD2xddtP9chqvS7FwKf/E
         e3gA==
X-Gm-Message-State: AOJu0YwdzLhyHKfHJemlUo4DZ5Rq8WKyTzwmKU50quT+8o2insBiN9pi
        0oUs8n6MFoOlfXChXezyoSM=
X-Google-Smtp-Source: AGHT+IHUj25zsFGZ+80EmSJ3pzZ9+7FoEVs88pwzrJzoTaPK1DtahFJU8ZEEyM7xNK3RdPsHBIwQuQ==
X-Received: by 2002:a05:6512:689:b0:4fe:85c:aeba with SMTP id t9-20020a056512068900b004fe085caebamr14218210lfe.21.1692881578458;
        Thu, 24 Aug 2023 05:52:58 -0700 (PDT)
Received: from [172.16.196.206] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q4-20020a19a404000000b0050078c9b53asm2270206lfc.231.2023.08.24.05.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 05:52:57 -0700 (PDT)
Message-ID: <eb47d0c9-9144-c947-f91e-d487c6ec9c45@gmail.com>
Date:   Thu, 24 Aug 2023 15:52:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 6/7] iio: accel: kionix-kx022a: Add a function to
 retrieve number of bytes in buffer
Content-Language: en-US, en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1692824815.git.mehdi.djait.k@gmail.com>
 <923d01408680f5ac88ca8ee565a990645578ee83.1692824815.git.mehdi.djait.k@gmail.com>
 <ZOdFyKHBc6BcOgZw@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ZOdFyKHBc6BcOgZw@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/23 14:58, Andy Shevchenko wrote:
> On Wed, Aug 23, 2023 at 11:16:40PM +0200, Mehdi Djait wrote:
>> Since Kionix accelerometers use various numbers of bits to report data, a
>> device-specific function is required.
>> Implement the function as a callback in the device-specific chip_info structure
> 
> ...
> 
>> +	int ret, fifo_bytes;
>> +
>> +	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
>> +	if (ret) {
>> +		dev_err(data->dev, "Error reading buffer status\n");
>> +		return ret;
>> +	}
>> +
>> +	if (fifo_bytes == KX022A_FIFO_FULL_VALUE)
>> +		return KX022A_FIFO_MAX_BYTES;
>> +
>> +	return fifo_bytes;
> 
> This will be called each time ->get_fifo_bytes() called.
> Do you expect the fifo_bytes to be changed over times?
> Shouldn't we simply cache the value?

I think this value tells how many samples there currently is in the 
FIFO. Caching it does not sound meaningful unless I am missing something.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

