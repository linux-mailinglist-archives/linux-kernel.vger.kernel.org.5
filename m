Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F8E78A5C1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 08:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjH1GYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 02:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjH1GYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 02:24:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7472BBF;
        Sun, 27 Aug 2023 23:24:29 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5007abb15e9so4317175e87.0;
        Sun, 27 Aug 2023 23:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693203868; x=1693808668;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJEEAUFPzNHL6qeRgs4ZV0S7WVIrOvIW9wbr+X3tFe4=;
        b=QNo9/4Gx3pM3EQHZCPHTjVCsd+LQO/mNKW3m32bL4usyDhQcc8UaQk12nnwojEPqxp
         xLEV1CJtW8xNVk+3tybZgABpmWfQzm708n0jPCsy6vim+gUde0KhubJURiH4fIjRHRbl
         BPeJ0m9hOepsktkdZigesxYc2/hQ9NX3CfNabYN/ewv5+/bTd+ZL7KSw6K7dJqmYhYe4
         9rcdjGeUy0eVkLinaFpOmi8rLWq5LTS9MMLr2XB0G5xHcVf9xpnQr910qZLoe7KzMlRH
         +0P4rVWvVOqs+7kY7Y8tvY6HHOjts4XI86QyxoJHQcQrF6Eyipuox+nsZs3fcxHArDUe
         e7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693203868; x=1693808668;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJEEAUFPzNHL6qeRgs4ZV0S7WVIrOvIW9wbr+X3tFe4=;
        b=c5piqVAXrTHkO5i63Ach+Cm7vPpk6MdxsXpw0nS/Go/8ha+7apxrTOr2/vUpf1730Z
         qRkuBpkFDSvjQUHmkH9BWoI3++Z9ayKI/hzaY/yqpjt/OudXvudaUb3owdWkw5jqvPsI
         QgHdvHGv0lWHB4d1k0TylG25egK2nt6p5z2jgz1Oj569aTyzH3gqStiIuFGjoPCNbmd/
         fHStNt74kX/zqOS6hDmzp4toQ7Kei4FDLXq+Ibo6/7CF7TiZB/+kzAryOR/rO/SGaNRz
         NjyQRmXcwfipVk4hsFjTtuiHbHFCH/14HDCfFcEkFC+y2iJTM6At+FGLriPhnuNeonWr
         svDQ==
X-Gm-Message-State: AOJu0YzvMSLEBRyJgCIUkxuw4YJRv0Fui2wZdV320fTxC/yqdfhZCZ6O
        HyPlHvsoNgjeyUaekOfOtYE=
X-Google-Smtp-Source: AGHT+IFsnWBDIsFl7sMk13p09aaoc28fgtljnP8uYi1nofxVIvuHHfzYnM4o4KLAjANfpIbIEGa/9g==
X-Received: by 2002:ac2:4c2e:0:b0:500:95d8:1b01 with SMTP id u14-20020ac24c2e000000b0050095d81b01mr8648061lfq.65.1693203867426;
        Sun, 27 Aug 2023 23:24:27 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::5? (dc78bmyyyyyyyyyyyyyct-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::5])
        by smtp.gmail.com with ESMTPSA id v20-20020ac25614000000b004fbc82dd1a5sm1441871lfd.13.2023.08.27.23.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 23:24:26 -0700 (PDT)
Message-ID: <61247547-690c-fb8b-3a45-cd60754836a7@gmail.com>
Date:   Mon, 28 Aug 2023 09:24:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mehdi Djait <mehdi.djait.k@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1692824815.git.mehdi.djait.k@gmail.com>
 <923d01408680f5ac88ca8ee565a990645578ee83.1692824815.git.mehdi.djait.k@gmail.com>
 <ZOdFyKHBc6BcOgZw@smile.fi.intel.com>
 <eb47d0c9-9144-c947-f91e-d487c6ec9c45@gmail.com>
 <ZOdddZ0Zpk5CknH8@smile.fi.intel.com>
 <CAFukWp2Z0OCrJdTy+wzVs9jdCm70YNR-66q06=xoyGhaHg=aog@mail.gmail.com>
 <ZOdfeaW6AxE4eeqw@smile.fi.intel.com>
 <CAFukWp0ubncNcMiw-s_h5GoP1_RsjTaw3XxayGMuaeJJJneBow@mail.gmail.com>
 <ZOdrtNQijmhN9RAx@smile.fi.intel.com> <20230827190732.5e2215d0@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v8 6/7] iio: accel: kionix-kx022a: Add a function to
 retrieve number of bytes in buffer
In-Reply-To: <20230827190732.5e2215d0@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/23 21:09, Jonathan Cameron wrote:
> 
>>>>>> I see. I think my confusion can be easily cured by renaming the callback to
>>>>>>
>>>>>>          get_amount_bytes_in_fifo()
>>>>>>
>>>>>> or
>>>>>>
>>>>>>          get_bytes_in_fifo()
>>>>>>
>>>>>> or alike.
>>>>>
>>>>> or leave it as is. The function is documented:
>>>>   
>>>>> + * @get_fifo_bytes: function pointer to get number of bytes in the FIFO buffer
>>>>
>>>> Do you find it unambiguous? I do not.
>>>>
>>>> Still needs more words to explain if it's a capacity of FIFO or is it amount of
>>>> valid bytes for the current transfer or what?
>>>
>>> how about change the description to:
>>> function pointer to get amount  of acceleration data bytes currently
>>> stored in the sensor's FIFO buffer
>>>
>>> and change the function to "get_amount_bytes_in_fifo()"
>>
>> Sounds good to me, thank you!
>>
> Bikeshedding time ;)
> 
> I don't like "amount" in this - it ends up adding little meaning
> and to me it is ugly English.  It's making it clear that we are dealing
> with some sort of count but that is already true of get_bytes_in_fifo()
> So to my reading it adds nothing wrt to removing ambiguity.
> 
> get_number_of_bytes_in_fifo() flows better but also adds nothing over
> get_bytes_in_fifo()
> 
> You could make it clear it is something that changes over time.
> 
> get_current_bytes_in_fifo()
> 
> Which at least implies it changes - though it doesn't rule out a weird
> variable max size fifo.
> 
> get_fifo_bytes_available() might be the clearest option and is the one
> I would prefer.  It's still a little messy as it could mean
> 'number of bytes of data that haven't been used yet in the fifo and
>   are available for samples in the future'.
> 
> Sigh.  Maybe least ambiguous is something longer like.
> 
> get_fifo_bytes_available_to_read()
> get_fifo_bytes_available_out()
> 
> Honestly I don't care that much what you go with :)

If this was a democracy (which it isn't) - my vote would go for "leave 
as it is" because the concept of a data collecting fifo where amount of 
data acquired in FIFO is readable from a register is common enough. I 
think that people who work on a driver like this should guess what this 
is for. Besides, if anything more than looking at the code is needed, 
then the plain guessing won't do and one needs anyway to open the 
data-sheet.

 From my perspective this series adds a nice value and is good to go.

Just my 10 cents though :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

