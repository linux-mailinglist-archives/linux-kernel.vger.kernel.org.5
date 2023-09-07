Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C907797701
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjIGQTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243966AbjIGQSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:18:39 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE08F5FD9;
        Thu,  7 Sep 2023 08:52:46 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-99bf3f59905so134766366b.3;
        Thu, 07 Sep 2023 08:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694101803; x=1694706603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2ziK0bcDlG6fjHgj7xGJvi60UEQrR120hAPw+QcVl8=;
        b=ke2hgNmPC6KoTJRmBjwYqINF1g/iM3iGzrBniJO814GMOjIhtiEhhmOfsU5Aq75zN8
         3Vu8boEyEQScwO1Jeozppp3zIxqCDdHyK9cuKJA5SXAjAavIhPsTthRWK2+3Ixw51xEC
         did3ptEozJjUICzEDfA75E7N8SikemhusDqlVvKL1QG+uYDV+4gIQYV7ShPq3gWiTIvE
         slcTAen+Pq4JQRzjcBG6K+YW6AhMgI2B11QaTT8blMgxewSM1X/0zzO9ysdUxRtN0pug
         qcggrwjUEZFeXgcGbYCXhOZzRWiV67KwJ/Fa6HVzpFF2TSRxK69pbiySOItILoSZEpj3
         bKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101803; x=1694706603;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2ziK0bcDlG6fjHgj7xGJvi60UEQrR120hAPw+QcVl8=;
        b=ZejTd9sSJPrqGSDxjgi0kKZZaTYc8tAlbd4pzsUPagl6DqUYwLTfMxF2Mlf+RTpgir
         6PD4m2bPNA5WKV2HMse5WsUBbIoaW5Ef5vRWj5nvJ9pC8axBT35nuKLthKL3Gj8WE1q1
         UTLz0bIYKM3BDStdL0fXFLWz5nSRgMPIRFz9xNmYKpTa3wociLYtTB2Kb5ajnOgpP1YZ
         Q2zKsPBNCkDnGENIJUJ3rMXajB/OKVAUvmbMZlnASqeham4LFvncd+FSevo2vJC7QsxP
         +NuamL4IJPExSNUF8h4zDJBNYywpt04bqj6g7/I6XClLmR3jDa08+oeNksGw49+xBJqZ
         nrvQ==
X-Gm-Message-State: AOJu0Yz/3KfiICNktWe9SdF12O6dkqw1ZUCjp3aBN0aVHANRFly10dbd
        JYHiOBHvh/WtH5alnknutPS59cWjrs4=
X-Google-Smtp-Source: AGHT+IExlUL6rEqkXkWj5kCfcLjbVQ+cdR8Yu7TuJOdWN9QHQtLbSo02FW8eaX4EpcQMdQ+5h0hNJg==
X-Received: by 2002:a2e:9b04:0:b0:2b5:7f93:b3b0 with SMTP id u4-20020a2e9b04000000b002b57f93b3b0mr3720871lji.17.1694068428713;
        Wed, 06 Sep 2023 23:33:48 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::3? (dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::3])
        by smtp.gmail.com with ESMTPSA id w14-20020a2e958e000000b002b70aff9a97sm3782450ljh.16.2023.09.06.23.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 23:33:47 -0700 (PDT)
Message-ID: <8b73d2d9-ebba-8f3c-4b39-e3671117acf1@gmail.com>
Date:   Thu, 7 Sep 2023 09:33:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <eb47d0c9-9144-c947-f91e-d487c6ec9c45@gmail.com>
 <ZOdddZ0Zpk5CknH8@smile.fi.intel.com>
 <CAFukWp2Z0OCrJdTy+wzVs9jdCm70YNR-66q06=xoyGhaHg=aog@mail.gmail.com>
 <ZOdfeaW6AxE4eeqw@smile.fi.intel.com>
 <CAFukWp0ubncNcMiw-s_h5GoP1_RsjTaw3XxayGMuaeJJJneBow@mail.gmail.com>
 <ZOdrtNQijmhN9RAx@smile.fi.intel.com> <20230827190732.5e2215d0@jic23-huawei>
 <61247547-690c-fb8b-3a45-cd60754836a7@gmail.com>
 <ZOx8rAFBXMylgNzm@smile.fi.intel.com>
 <7ca3b60f-e59f-b578-7c22-48487663cfa7@gmail.com>
 <ZPiixW6CiR+z8s/r@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v8 6/7] iio: accel: kionix-kx022a: Add a function to
 retrieve number of bytes in buffer
In-Reply-To: <ZPiixW6CiR+z8s/r@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 19:03, Andy Shevchenko wrote:
> On Tue, Aug 29, 2023 at 09:33:27AM +0300, Matti Vaittinen wrote:
>> On 8/28/23 13:53, Andy Shevchenko wrote:
>>> On Mon, Aug 28, 2023 at 09:24:25AM +0300, Matti Vaittinen wrote:
>>>> On 8/27/23 21:09, Jonathan Cameron wrote:
> 
> Sorry it took a bit of time to reply on this.

No problem. Autumn is approaching and darkness is falling in Finland... 
So, at least I am really slowing down with everything... :|

> ...
> 
>>>> I think that people who work on a driver like this should guess what this is
>>>> for.
>>>
>>> _This_ is the result of what people always forgot to think about, i.e. newcomers.
>>
>> Thanks Andy. This was a good heads-up for me. I do also see the need for
>> fresh blood here - we aren't getting any younger.
>>
>>> What _if_ the newcomer starts with this code and already being puzzled enough on
>>> what the heck the function does. With all ambiguity we rise the threshold for the
>>> newcomers and make the kernel project not attractive to start with
>>
>> I really appreciate you making a point about attracting newcomers (and there
>> is no sarcasm in this statement). I however don't think we're rising the bar
>> here. If a newcomer wants to work on a device-driver, the _first_ thing to
>> do is to be familiar with the device. Without prior experience of this kind
>> of devices it is really a must to get the data-sheet and see how the device
>> operates before jumping into reading the code. I would say that after
>> reading the fifo lvl description from data-sheet this should be obvious -
>> and no, I don't think we should replicate the data-sheet documentation in
>> the drivers for parts that aren't very peculiar.
> 
> There are (at least?) two approaches on the contribution:
> 1) generic / library wise;
> 2) specific hardware wise.
> 
> You are talking about 2), while my remark is about both. I can imagine a newcomer
> who possess a hardware that looks similar to what this driver is for.

Yes. I am talking about 2). And my stance is that device drivers belong 
to category 2). If one works with a device driver for some HW, then 
he/she needs to be willing to understand the hardware.

  Now, they
> would like to write a new driver (note, that compatibility can be checked by
> reading the RTL definitions, so no need to dive into the code) and use this as
> a (nice) reference. With that in mind, they can read a function named
> get_fifo_bytes() with not so extensive documentation nor fully self-explanatory
> name. One may mistakenly though about this as a function for something that
> returns FIFO capacity, but in the reality it is current amount of valid / data
> bytes in the FIFO for the ongoing communication with the device. 

I can't avoid having a feeling that this is a very unlikely scenario. I 
am afraid that by requesting this type of improvements at patch series 
which is at v8 and has been running for half an year (and which was of a 
good quality to start with, especially knowing this was the author's 
first driver) is going to be more repulsive to the newcomers than the 
potential obfuscation.

I don't try claiming that no-one could ever hit this trap (even if I 
don't see it likely). I still believe that if one does so, he/she will 
also get such a bug fixed without being totally discouraged - it's 
business as usual.

I hope this does not come out as rude. I do appreciate your reviews, 
it's comforting to know someone looks my code with sharp eyes and points 
out things like the dead code in BM1390 driver! I just like the words 
Jonathan once spilled out:

"Don't let the perfect be enemy of good" (or something along those lines).

>> But the question how to attract newcomers to kernel is very valid and I
>> guess that not too many of us is thinking of it. Actually, I think we should
>> ask from the newcomers we have that what has been the most repulsive part of
>> the work when they have contributed.
> 
>> (besides the
>>> C language which is already considered as mastodon among youngsters).
>>
>> I think this is at least partially the truth. However, I think that in many
>> cases one of the issues goes beyond the language - many younger generation
>> people I know aren't really interested in _why_ things work, they just want
>> to get things working in any way they can - and nowadays when you can find a
>> tutorial for pretty much anything - one really can just look up instruction
>> about how a "foobar can be made to buzz" instead of trying to figure out
>> what makes a "foobar to buzz" in order to make it to buzz. So, I don't blame
>> people getting used to take a different approach. (Not sure this makes sense
>> - don't really know how to express my thoughts about this in a clear way -
>> besides, it may not even matter).
> 
> Yeah, I share your frustration and agree that people are loosing the feel of
> curiosity. Brave New World in front of us...

Well, who knows how things will be working out for the new generations? 
Maybe they won't need the kernel in the future? Yes, I am stubbornly 
hanging in the past practices and values. Direction things seem to head 
do not always appeal to me - but perhaps it's just me? Who can say my 
values and practices are the right ones for new generations :) My oldest 
son just moved to his own home and I need to accept that young do build 
their own lives on different values I had. And who knows, maybe the 
approach of just doing things without knowing what exactly happens under 
the hood makes this world very good for them?

But yes - I don't think it suits the kernel project at all :) This is a 
project of dinosaurs like us XD

(DISCLAIMER: I don't know quite all young people in the world. Frankly 
to tell, not even 90% XD So, I am not trying to say "all young people 
are like this or that". I just have a feeling that certain way of 
thinking is more common amongst certain generations - but maybe it's 
just my misjudgement. Please, don't be offended).

> 
>> Anyways, I am pretty sure that - as with any community - the way people are
>> treated and how their contribution is appreciated is the key to make them
>> feel good and like the work. I think that in some cases it may include
>> allowing new contributors to get their code merged when it has reached "good
>> enough" state - even if it was not perfect. (Sure, when things are good
>> enough is subject to greater minds than me to ponder) ;)
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

