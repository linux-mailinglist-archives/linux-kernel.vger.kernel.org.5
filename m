Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F2C7D9D74
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346245AbjJ0Pvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjJ0Pve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:51:34 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6594D42;
        Fri, 27 Oct 2023 08:51:30 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9a58aa4983so1640664276.0;
        Fri, 27 Oct 2023 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698421890; x=1699026690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wzy57PUf9orHh4OjGzjzAp13qnWwnh2HAAT0JBgqrrs=;
        b=HOL033eEc/DKMO5D+Mc1XNZ7y/TX68zSWpNFoyyd0xmI9v4DpdJYU4jWLF3+qzZdH9
         nBTyjX314fbnC8naO/UqGwh1iiMyC+RKn8p93TUF2g9HB0Hl2JefGbzXKcbQKLMkXru/
         MyzS65x6OD5Ft5L4vXHKMIJy/JgKqCM9Plq3yzpcbFOdUEn7s1vs+yHjiI2lVfg6BiAe
         OEFiti0/zLc3gFkjRK74qD+Upi3IppUYQpxwi2HuDz7n65a1xzS19BC9BdmuxoU15bzl
         OlFA5PtBWQreywWnGdDrjzb5SdTqx/Izmbjd7GYIWX4na/4VRYCA9NrQWieJvttQYLXJ
         lvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698421890; x=1699026690;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wzy57PUf9orHh4OjGzjzAp13qnWwnh2HAAT0JBgqrrs=;
        b=mF/5dpJ6vo0LetZw2Pt7HfFVQLqXUURHrzAZGnqlQWSSD13MAyl0okCzIWW6KhCgn5
         YPoDtNAzdmSCj4o6yjcziEcERl2IKn85L0ZXbVFRkHNHTKSnrJkb3rQF0BM/LrpXWQI2
         EgZUjgEj7KsfkMi7PA86PeKal3sXYPgLyU9arbrkCfWQ6tpATbGBW9IeBuLGnoe4GVhE
         x/bAtEJ5Y2o3pDQI5E9fUPtjxFJVhL+rUGnIWK84i72KQ+9JG7TycYwxOIKoKGiTwKdG
         3khkAb7qrGqOBDZoOIST3O83ofzTuQQXnS/bsb1AZ768P9XEa6NNIo9KXphHX/ErKdhL
         P6RA==
X-Gm-Message-State: AOJu0YwxgN+1CtefLw61UG/skX7uDcTIWxowhEEjB++1DLm2KgJOiNIS
        6WUxMLUU/qdQEKUqEjCjdQ8=
X-Google-Smtp-Source: AGHT+IHz6K8imb2cUy5vfXE7RsDkyWqKz9BYYAMj2LUiJAbmdb/AnRNSz7B3Rc1gcFGGTebIcHJEMA==
X-Received: by 2002:a25:cf02:0:b0:da0:3535:41f4 with SMTP id f2-20020a25cf02000000b00da0353541f4mr3375675ybg.7.1698421889667;
        Fri, 27 Oct 2023 08:51:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p136-20020a25748e000000b00d9cce349877sm751262ybc.16.2023.10.27.08.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 08:51:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d67c0bf1-beae-d93f-994c-3a937e2047a0@roeck-us.net>
Date:   Fri, 27 Oct 2023 08:51:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     "Matyas, Daniel" <Daniel.Matyas@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231026144405.546822-1-daniel.matyas@analog.com>
 <20231026144405.546822-2-daniel.matyas@analog.com>
 <fe99431e-3245-484c-bf26-928048500ec6@roeck-us.net>
 <PH0PR03MB67712B3C063B794442F6D58A89DCA@PH0PR03MB6771.namprd03.prod.outlook.com>
 <84252c5e-9a39-91bd-b7da-2bdea1b2aff6@roeck-us.net>
 <PH0PR03MB6771E74E7C5CC2FB1DD0EB1989DCA@PH0PR03MB6771.namprd03.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 2/4] hwmon: max31827: Add support for max31828 and
 max31829
In-Reply-To: <PH0PR03MB6771E74E7C5CC2FB1DD0EB1989DCA@PH0PR03MB6771.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/23 08:05, Matyas, Daniel wrote:
> 
> 
>> -----Original Message-----
>> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
>> Sent: Friday, October 27, 2023 5:52 PM
>> To: Matyas, Daniel <Daniel.Matyas@analog.com>
>> Cc: Jean Delvare <jdelvare@suse.com>; Jonathan Corbet
>> <corbet@lwn.net>; linux-hwmon@vger.kernel.org; linux-
>> doc@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v5 2/4] hwmon: max31827: Add support for
>> max31828 and max31829
>>
>> [External]
>>
>> On 10/27/23 06:00, Matyas, Daniel wrote:
>> [ ... ]
>>
>>>> I also don't understand why that would be chip specific. I don't see
>>>> anything along that line in the datasheet.
>>>>
>>>> Ah, wait ... I guess that is supposed to reflect the chip default.
>>>> I don't see why the chip default makes a difference - a well defined
>>>> default must be set either way. Again, there is no guarantee that the
>>>> chip is in its default state when the driver is loaded.
>>>
>>> The well defined default was set in v4, but I deleted it, because the
>> default value in hex for max31827 and max31828 alarm polarity, and
>> max31827 fault queue is 0x0. I had 2 #defines for these values, but you
>> said:
>>> " Since MAX31827_ALRM_POL_LOW is 0, this code doesn't really do
>> anything and just pollutes the code."
>>>
>>> So, I thought I should remove it altogether, since res is set to 0 in the
>> beginning and the default value of these chips (i.e. 0) is implicitly set.
>>>
>>>>
>>>> Also, why are the default values added in this patch and not in the
>>>> previous patch ?
>>>>
>>>
>>> In v4 these default values were set in the previous patch.
>>>
>>
>> I asked you (or meant to ask you) to stop overwriting 0 with 0 in a
>> variable. I didn't mean to ask you (if I did) to stop writing the default value
>> into the chip. Sorry if I did; if so, that was a misunderstanding.
>>
>> Guenter
> 
> Well, writing the default value into res, would just overwrite 0 with 0. Should I still do it?
> 

No, that is not correct. You don't know what is in the chip register.
It may not be the chip default.

Guenter

