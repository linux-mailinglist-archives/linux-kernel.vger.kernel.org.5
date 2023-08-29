Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA74E78BE82
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjH2Gdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjH2Gdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:33:33 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEBB13E;
        Mon, 28 Aug 2023 23:33:30 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso59666771fa.1;
        Mon, 28 Aug 2023 23:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693290809; x=1693895609;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cK2hK31b0m5rDzqp3vB26ZBGv/YhBK2MTESfxpIodNM=;
        b=CbLIshFjC6vK98lxHBO6x7GJ5PZxzFSZyhs5lmNXWrgvbF0uoUHxkdWAnUC3laoGTR
         UaNUnp5Ia6VWb5z2cy9c6CY89pm7bvKIg8kV007CjtXjIGK5CU6CM7WHSQKbQp7aLxwU
         uczzJPb8M9/fKhnE15XIoe+QeNXHuSfJjQqiUk/sEo0iV6yMDCIDCsa+8OHjO7R7mBl4
         F8K/Fz7fG2JmXZe7XRMVO3Mso+BvNmdNywWmICnDjVeHtu3ne4sq+EXbNL6Pf7MNUE3J
         k+LYikltfJ+K19rcxmZyvOyq7+ArhoOM23tEbzg2Wevb3/Uz19ML1c7/Isuy3N/lqQY8
         qjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693290809; x=1693895609;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cK2hK31b0m5rDzqp3vB26ZBGv/YhBK2MTESfxpIodNM=;
        b=jg4ia7SAzhfg6XU/jSodc9F4aA/5SLw0gK01XW/3iTzn7ba/6mRvEF3VQrIFcZq+rS
         4e9N0P4RL04dvPImUoHPeKwA4etqn27s54fr0TkOfAF2olGRXN+Oide5FRmOttGATUT2
         Y5pnusso89dadHdu7pNsFo/Kt5iwF4BZYVJ7p/NBojmuz7p5kiSROJozBTq2SQayOhtm
         /a0D/a8MlT9WeCTj9jIXFXDCsdbMDNv2psBNG5I4jmCkQ7OLIfUyq7TBIp1IMQ3zdEWZ
         SIzwD/UxWdu0X5YFLmiZVxba1ENCpH9JmsCJ6vHW3OH0g8eiwXo2/nvrpxEcfDq2zjFz
         plfQ==
X-Gm-Message-State: AOJu0YxNWBBprA+VJXNX3BIl3mPhz1dHtpsFXBviUOeNW+euP68hDQzM
        Jnx01f+dAo0UjhPMoaEOSLE=
X-Google-Smtp-Source: AGHT+IELbkZD8D9cvA4oLG68kKjvzxKhf1sFhYmmlRm5TeBqZ5xCJ+R/+WddA/SDTdg/WpoAySpJoQ==
X-Received: by 2002:a2e:7008:0:b0:2bc:d8fd:13df with SMTP id l8-20020a2e7008000000b002bcd8fd13dfmr14313727ljc.41.1693290808688;
        Mon, 28 Aug 2023 23:33:28 -0700 (PDT)
Received: from [172.16.196.206] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id u16-20020a2e8550000000b002b9af8422a8sm2004439ljj.130.2023.08.28.23.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 23:33:27 -0700 (PDT)
Message-ID: <7ca3b60f-e59f-b578-7c22-48487663cfa7@gmail.com>
Date:   Tue, 29 Aug 2023 09:33:27 +0300
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
References: <923d01408680f5ac88ca8ee565a990645578ee83.1692824815.git.mehdi.djait.k@gmail.com>
 <ZOdFyKHBc6BcOgZw@smile.fi.intel.com>
 <eb47d0c9-9144-c947-f91e-d487c6ec9c45@gmail.com>
 <ZOdddZ0Zpk5CknH8@smile.fi.intel.com>
 <CAFukWp2Z0OCrJdTy+wzVs9jdCm70YNR-66q06=xoyGhaHg=aog@mail.gmail.com>
 <ZOdfeaW6AxE4eeqw@smile.fi.intel.com>
 <CAFukWp0ubncNcMiw-s_h5GoP1_RsjTaw3XxayGMuaeJJJneBow@mail.gmail.com>
 <ZOdrtNQijmhN9RAx@smile.fi.intel.com> <20230827190732.5e2215d0@jic23-huawei>
 <61247547-690c-fb8b-3a45-cd60754836a7@gmail.com>
 <ZOx8rAFBXMylgNzm@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v8 6/7] iio: accel: kionix-kx022a: Add a function to
 retrieve number of bytes in buffer
In-Reply-To: <ZOx8rAFBXMylgNzm@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 13:53, Andy Shevchenko wrote:
> On Mon, Aug 28, 2023 at 09:24:25AM +0300, Matti Vaittinen wrote:
>> On 8/27/23 21:09, Jonathan Cameron wrote:
> 
> ...
> 
>> I think that people who work on a driver like this should guess what this is
>> for.
> 
> _This_ is the result of what people always forgot to think about, i.e. newcomers.

Thanks Andy. This was a good heads-up for me. I do also see the need for 
fresh blood here - we aren't getting any younger.

> What _if_ the newcomer starts with this code and already being puzzled enough on
> what the heck the function does. With all ambiguity we rise the threshold for the
> newcomers and make the kernel project not attractive to start with 

I really appreciate you making a point about attracting newcomers (and 
there is no sarcasm in this statement). I however don't think we're 
rising the bar here. If a newcomer wants to work on a device-driver, the 
_first_ thing to do is to be familiar with the device. Without prior 
experience of this kind of devices it is really a must to get the 
data-sheet and see how the device operates before jumping into reading 
the code. I would say that after reading the fifo lvl description from 
data-sheet this should be obvious - and no, I don't think we should 
replicate the data-sheet documentation in the drivers for parts that 
aren't very peculiar.

But the question how to attract newcomers to kernel is very valid and I 
guess that not too many of us is thinking of it. Actually, I think we 
should ask from the newcomers we have that what has been the most 
repulsive part of the work when they have contributed.

(besides the
> C language which is already considered as mastodon among youngsters).

I think this is at least partially the truth. However, I think that in 
many cases one of the issues goes beyond the language - many younger 
generation people I know aren't really interested in _why_ things work, 
they just want to get things working in any way they can - and nowadays 
when you can find a tutorial for pretty much anything - one really can 
just look up instruction about how a "foobar can be made to buzz" 
instead of trying to figure out what makes a "foobar to buzz" in order 
to make it to buzz. So, I don't blame people getting used to take a 
different approach. (Not sure this makes sense - don't really know how 
to express my thoughts about this in a clear way - besides, it may not 
even matter).

Anyways, I am pretty sure that - as with any community - the way people 
are treated and how their contribution is appreciated is the key to make 
them feel good and like the work. I think that in some cases it may 
include allowing new contributors to get their code merged when it has 
reached "good enough" state - even if it was not perfect. (Sure, when 
things are good enough is subject to greater minds than me to ponder) ;)

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

