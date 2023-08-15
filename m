Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993E177D027
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbjHOQcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbjHOQbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:31:51 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68A110E3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:31:49 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-55b78bf0423so845082a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692117109; x=1692721909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HyoFGqhJreIqbjdFqzsLVobJp3/bJ21zavc6djaLYcM=;
        b=aj7KdHvISpjQtEVHh0vZliJvZuqF1mu1ylAUL1xsW7Ug4jSPfigmpO+bTGKpsdWPLX
         6v/2e1T+YNicVHkdLjs8PmJZKbG6L6SY8uW7MJSgsJxoCeCHqSeNYczwS4z0/FIvGd8g
         aM/8dJhjtZcNS3booSwEqmipyP7z9k0IDj/r0mV1zZH7cw2FcSHYLIkR8sl6XJI7uxSE
         TQHh065NhSBFP8tMYUnCzjfIVbQ/+rNnNp5mJyS5F50UQl/jfcjrVd8rTnd9ESzOpUHM
         ly0tRPgPDcSRwSC9nttO9DfcL+pj6PiLxBkSY+gc/zeGet+/E8i/v4MVTOwRfL2mFxT3
         zdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692117109; x=1692721909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HyoFGqhJreIqbjdFqzsLVobJp3/bJ21zavc6djaLYcM=;
        b=bsa4inmuTqd3moHKY2ro1I4JDKDxBrsUITjvyHS2/DnYZ5K/CVrbSNDkKMhTSvq+As
         ZYM0HdGXWa3ZDVrEwbtamrfAmfP4A/eiPeBOrB9iHehaw/+M0KtBQTqeswdRgMCDIYmF
         A/9Wc6QIIU9+jBCYQUMWbkyTRB9Aq6rZivEnD8QPMYuL8UYCxxUq548rkzhvwQgSd0gb
         wXKPbnu1xWfM2DNw82d5zsqcRqIqYe1SX6YZW+tyyWMHKAVCQv6WA359xmzHaW+jFzZf
         DTZJt8f+yTcMdLJpKyl0+0vp1mICr5OJdwZHoY6XUV+t50FjWLP5+5t3vyLgF1i/W7Gn
         NdlQ==
X-Gm-Message-State: AOJu0Yw5od3cqDhaeh8QffQOuccsX9IdWnzUlIPpq5v8RSlKJRdu/oK5
        JbQEHwxydJToCctVgr/bOTKm4Lt5GTZWLTqDB3g=
X-Google-Smtp-Source: AGHT+IExFTuJ329kpirWoQTAAg/X2PWihdHZGps9SmD9KGrbRBKC2GnuDy+TCmepUj3pLXTnkC8NWQ==
X-Received: by 2002:a17:90a:69e1:b0:26b:27f6:9027 with SMTP id s88-20020a17090a69e100b0026b27f69027mr10379102pjj.1.1692117109323;
        Tue, 15 Aug 2023 09:31:49 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ja11-20020a170902efcb00b001b83e5ec666sm11258582plb.6.2023.08.15.09.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 09:31:48 -0700 (PDT)
Message-ID: <d7d2aea2-66e3-4172-8c04-f71dbe66612c@kernel.dk>
Date:   Tue, 15 Aug 2023 10:31:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Fixes tag needs some work in the block tree
Content-Language: en-US
To:     Song Liu <song@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230815091931.4dd2b277@canb.auug.org.au>
 <8c946512-0cc4-fbc5-ca36-0e2c6d636eb2@huaweicloud.com>
 <c39a3bff-01b9-4007-80ac-00ce2b11a902@kernel.dk>
 <CAPhsuW7ck4Bb8NVUdgZZJqzNCYMgT9rspKshr2Zi=8xo2cQLaw@mail.gmail.com>
 <48f834c2-b283-4b02-9407-4a0842d4ed72@kernel.dk>
 <CAPhsuW4YNWksHgTZGzX8Rj1+gU-aqQjiYueNRNHPryxOk2WXqQ@mail.gmail.com>
 <a30e4e08-7b8c-498c-b8af-82262b3ec6ff@kernel.dk>
 <CAPhsuW5AHQkf6wO_4Z6VFbTCxNN9GchW_ZPxmC1vtc23ByPc6g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAPhsuW5AHQkf6wO_4Z6VFbTCxNN9GchW_ZPxmC1vtc23ByPc6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/23 10:26 AM, Song Liu wrote:
> On Wed, Aug 16, 2023 at 12:20?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 8/15/23 10:17 AM, Song Liu wrote:
>>> On Wed, Aug 16, 2023 at 12:07?AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 8/15/23 9:58 AM, Song Liu wrote:
>>>>> On Tue, Aug 15, 2023 at 11:08?PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>
>>>>>> On 8/14/23 9:21 PM, Yu Kuai wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> ? 2023/08/15 7:19, Stephen Rothwell ??:
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> In commit
>>>>>>>>
>>>>>>>>    71070e7bd25d ("md/raid10: fix a 'conf->barrier' leakage in raid10_takeover()")
>>>>>>>>
>>>>>>>> Fixes tag
>>>>>>>>
>>>>>>>>    Fixes: 4d27e927344a ("md: don't quiesce in mddev_suspend()")
>>>>>>>>
>>>>>>>> has these problem(s):
>>>>>>>>
>>>>>>>>    - Target SHA1 does not exist
>>>>>>>
>>>>>>> Sorry about this, the commit was picked from previous md-next branch,
>>>>>>> and I didn't know that it will change...
>>>>>>
>>>>>> It's most likely not your fault, I'm guessing Song rebased that branch
>>>>>> and this is why the sha changed. Song?
>>>>>
>>>>> Yeah, it is my fault. I am really sorry for this issue.
>>>>>
>>>>>>
>>>>>>> Is there any way that I can fix this ?
>>>>>>
>>>>>> Only way to fix this is if I rewind my branch and Song updates his
>>>>>> branch to not have this issue, and then sends a new pull request.
>>>>>
>>>>> Yes please. Let's fix this.
>>>>
>>>> Please send a new one, I've dropped the old one.
>>>
>>> Is this the for-6.6/block branch? I haven't seen the change yet. The top
>>> commit on the branch (as I see) is
>>>
>>> 306d74055754 ("ublk: Switch to memdup_user_nul() helper")
>>
>> Where are you looking? It's at:
> 
> I am looking at
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> 
> It appears to be some lag from git server?

That's just a backup, I always pull and push from git.kernel.dk. The
korg one will lag about an hour, depending on when things are pushed.
I've never used the korg one as the canonical location.

-- 
Jens Axboe

