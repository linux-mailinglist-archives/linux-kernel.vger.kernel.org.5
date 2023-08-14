Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD0677B1F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjHNHAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjHNG7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:59:46 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B485E63;
        Sun, 13 Aug 2023 23:59:45 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-52564f3faf7so882315a12.1;
        Sun, 13 Aug 2023 23:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691996383; x=1692601183;
        h=content-transfer-encoding:in-reply-to:subject:content-language:from
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dz6rNrYEZr1o1hy+Da5bIJKDMQSjh+lwDKkiGk9K2V4=;
        b=PWdMGCUCI32v36c7b3JVGqjjjwtPKVWfcwI3WfwyujAtGKhDMFk0srVyLj3e2ud8h2
         oLEkvPwTSuXvuPF2GHI9ATv7hXsAUPYaX1n8aCIzjDGww6SNROwniD2z/FwIpX4aYfyq
         9WR4W6i0wl88prliVw1x0ePhRj/waYI4JZ/yU4CFTUoiAuyIU3y6NEbsV7500kBZMm+O
         +daKT9QyMwGQ/5/hcnAlP7l2oOf+10akgV9TlLQlpaa/YTJhxAN4wCZ0P2dM0pL+LAWA
         VplAobWO+QilwOBAEs6bZkQnLtKofG09MhypoUH/hMf6rgbXsbP/3VyePxW1RU46ZiK7
         e4Qg==
X-Gm-Message-State: AOJu0Yzci0D7ADLucWm8Bi3mmYQDOJ5XzRxCLxTxwPH6eXu3d3lvsDEf
        iVgJpq1r5cXJ8iXDc9kw4Y2+X3JXJcK5Vw==
X-Google-Smtp-Source: AGHT+IElH741V6Bi5Gmlqjb+OuvSWI5oSrQOEULXddo956CvC0pSJPxznY9UNorCmFPx1iNMO1xWKg==
X-Received: by 2002:a17:907:7604:b0:99d:b9d6:6014 with SMTP id jx4-20020a170907760400b0099db9d66014mr306158ejc.4.1691996383408;
        Sun, 13 Aug 2023 23:59:43 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id s10-20020a1709064d8a00b0099364d9f0e6sm5270550eju.117.2023.08.13.23.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 23:59:43 -0700 (PDT)
Message-ID: <8a0b6de4-3459-76fb-9117-287e71e315f1@kernel.org>
Date:   Mon, 14 Aug 2023 08:59:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230810091510.13006-1-jirislaby@kernel.org>
 <728dc060-d38c-b8d4-783-2322115cf4b4@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Content-Language: cs-CZ, en-US
Subject: Re: [PATCH 00/36] tty: type unifications -- part I.
In-Reply-To: <728dc060-d38c-b8d4-783-2322115cf4b4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 08. 23, 12:26, Ilpo Järvinen wrote:
> On Thu, 10 Aug 2023, Jiri Slaby (SUSE) wrote:
> 
>> Currently, the tty layer ops and functions use various types for same
>> things:
>> * characters and flags: unsigned char, char are used on a random basis,
>> * counts: int, unsigned int, size_t are used, again more-or-less
>>    randomly.
>>
>> This makes it rather hard to remember where each type is required and it
>> also makes the code harder to follow. Also the code has to do min_t() on
>> many places simply because the variables hold the same kind of data, but
>> of different type.
>>
>> This is the first part of the series to unify the types:
>> * make characters and flags 'u8'. This is what the hardware expects and
>>    what feeds the tty layer with. Since we compile with -funsigned-char,
>>    char and unsigned char are the same types on all platforms. So there
>>    is no actual change in type.
>> * make sizes/counts 'size_t'. This is what comes from the VFS layer and
>>    some tty functions already operate on this. So instead of using
>>    "shorter" (in term of bytes on 64bit) unsigned int, stick to size_t
>>    and promote it to most places.
>>
>> More cleanup and spreading will be done in tty_buffer, n_tty, and
>> likely other places later.
>>
>> Patches 1-8 are cleanups only. The rest (the real switch) depends on
>> those.
> 
> Yeah, very much needed change and step into the right direction!
> 
> It's a bit tedious to review all this and comment a particular subchange
> but e.g. n_tty_receive_buf_common() still seems to still have int count
> which I think fall into the same call chain about size/count (probably
> most related change is #15). Note though that it also has room which I
> think can actually become negative so it might not be as straightforward
> search and replace like some other parts are.

tl;dr
https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?h=devel&id=9abb593df5a9b9b72d13438f1862ca67936f6b66

----

Yes, sorry, my bad -- I forgot to elaborate on why this is "part I." and 
what is going to be part II., III., ...

So yeah, I have more in my queue which is growing a lot. I had to cut it 
at some point as I was losing myself in all the changes already. So I 
flushed this "part I.". It is only a minimalistic change in the core and 
necessary changes in drivers' hooks. Parts II. and on will spread this 
more, of course. Ideally, to every single loop in every driver ;) (in 
long-term).

I still have a bunch of changes for tty_buffer and n_tty in my queue. As 
soon as I rebase on the today's -next which is already supposed to 
contain this part I., I will send part II. with these changes. I could 
have merged those II. changes to some earlier I. patches. At first, I 
actually did try, but the patches were growing with more and more 
dependencies, so I stopped this approach. Instead, I separated the 
changes per the core/ldisc/drivers. The parts are self-contained, 
despite it might look like the changes are incomplete (i.e. not 
everything is changed everywhere). After all, I wanted to avoid one 
hundred+ patches series.

thanks,
-- 
js
suse labs

