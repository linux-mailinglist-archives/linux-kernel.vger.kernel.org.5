Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFA278E290
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245416AbjH3WtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343622AbjH3WtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:49:03 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F196C0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:48:41 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a56ed12c0so37037b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1693435721; x=1694040521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j3xtTxoMOABdcHWXxTdGDV9HsjsoD+11JWeXwPDKwKY=;
        b=0pPc+e2VauNS0dvqS+b0wI64Ntew/DeffMnZB28UQq8Z+PDNUsLgf0ljOzLv12pqbg
         SgDLiQ1XQzbtEY+56Ru2BIWet2EOADLE9lKvh9qidHu/AdYO4ge6k/iaiv2mJNQufCeQ
         rL/pcDFWkkq9pmclrS+VgtLRJ4QvkyOYczPcEJvfTfdkBFgM7J+DEnvQEVOn0k6xvnxM
         FiGHol8fZP7VaYxFYnWu/5Xc34hzW9q2upObWsPStRlP7ghiJxzorSZT5uqimGhyOeI4
         nfuXTIHtk684XygvGC4A6X0/Mr6Vd52wv+WA7OqBaUULBvpHGklXQQEho1n1Zy1a6Zc1
         UVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693435721; x=1694040521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3xtTxoMOABdcHWXxTdGDV9HsjsoD+11JWeXwPDKwKY=;
        b=j8oz4MOQ6cvlk7j6EQVcjTBo7IuadgxyITKGFKLob/1P2yJOJbZPq7dvd21gzxHWHb
         qtUGsRgOG1wFZA43H8RXtkJi7Hsq8Ig3w1Efh8QJnLyR087oE023euHib6fqOTXVd86u
         QkH93q5KW8Y01JJI36nngNUm2NlEIuFVCuewCUrKxFyjdqYv89eAVc4aiPRureyRI3Y5
         Pn+WQ24RdGmgR5jhb2ILbv+X+g8uP/waIMzIrIIMguwSGJDVv5cvEIl34WS3kySU3tV2
         Id7V1s/jJLnN8kFaHBGowZynHChgesFh5XEp6uG3axWyoSQaFhSNpncvOHal6Is4XNEM
         4k7Q==
X-Gm-Message-State: AOJu0Yzjh8AfSWJBksxMukNImpSl9ijNoQfnSqFKOTbq6mtVUxLT9ols
        vWbCYIlItODOiqaihJlZNoly3g==
X-Google-Smtp-Source: AGHT+IFsFswNL2+plG5TTtoW2H0V34BAB8gzDpGjUsmxwjhoHTVxIbo5m2CWu5ykMPFNsEh9eJ2W1w==
X-Received: by 2002:a05:6a00:d71:b0:68c:7089:cb8 with SMTP id n49-20020a056a000d7100b0068c70890cb8mr3738898pfv.2.1693435720767;
        Wed, 30 Aug 2023 15:48:40 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c11-20020aa78c0b000000b0068a538cc7adsm88094pfd.52.2023.08.30.15.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 15:48:40 -0700 (PDT)
Message-ID: <1a4d9f90-1bb0-4092-9be8-9cf2c70ef79d@kernel.dk>
Date:   Wed, 30 Aug 2023 16:48:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/3] Move usages of struct __call_single_data to
 call_single_data_t
Content-Language: en-US
To:     =?UTF-8?Q?Leonardo_Br=C3=A1s?= <leobras@redhat.com>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230520052957.798486-1-leobras@redhat.com>
 <CAJ6HWG6dK_-5jjoGJadOXqE=9c0Np-85r9-ymtAt241XrdwW=w@mail.gmail.com>
 <b84ad9aa200457b1cbd5c55a7d860e685f068d7a.camel@redhat.com>
 <1cd98cb37dcf621520e52ac7a15513aab5749534.camel@redhat.com>
 <51cf9db1-4487-4229-4d43-e91268e52125@linux.dev>
 <16efceed0b215ee34cc46ca7bba4a86bcf2d8ad7.camel@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <16efceed0b215ee34cc46ca7bba4a86bcf2d8ad7.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/23 4:29 PM, Leonardo Br?s wrote:
> On Tue, 2023-08-29 at 10:29 +0800, Chengming Zhou wrote:
>> On 2023/8/29 08:55, Leonardo Br?s wrote:
>>> On Tue, 2023-07-04 at 04:22 -0300, Leonardo Br?s wrote:
>>>> On Tue, 2023-06-13 at 00:51 -0300, Leonardo Bras Soares Passos wrote:
>>>>> Friendly ping
>>>>>
>>>>> On Sat, May 20, 2023 at 2:30?AM Leonardo Bras <leobras@redhat.com> wrote:
>>>>>>
>>>>>> Changes since RFCv1:
>>>>>> - request->csd moved to the middle of the struct, without size impact
>>>>>> - type change happens in a different patch (thanks Jens Axboe!)
>>>>>> - Improved the third patch to also update the .h file.
>>>>>>
>>>>>> Leonardo Bras (3):
>>>>>>   blk-mq: Move csd inside struct request so it's 32-byte aligned
>>>>>>   blk-mq: Change request->csd type to call_single_data_t
>>>>>>   smp: Change signatures to use call_single_data_t
>>>>>>
>>>>>>  include/linux/blk-mq.h | 10 +++++-----
>>>>>>  include/linux/smp.h    |  2 +-
>>>>>>  kernel/smp.c           |  4 ++--
>>>>>>  kernel/up.c            |  2 +-
>>>>>>  4 files changed, 9 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> --
>>>>>> 2.40.1
>>>>>>
>>>>
>>>> Hello Jens,
>>>>
>>>> I still want your feedback on this series :)
>>>>
>>>> I think I addressed every issue of RFCv1, but if you have any other feedback,
>>>> please let me know.
>>>>
>>>> Thanks!
>>>> Leo
>>>
>>> Hello Jens Axboe,
>>>
>>> Please provide feedback on this series!
>>>
>>> Are you ok with those changes?
>>> What's your opinion on them? 
>>>
>>> Thanks!
>>> Leo
>>>
>>
>> Hello,
>>
>> FYI, there is no csd in struct request anymore in block/for-next branch,
>> which is deleted by this commit:
>>
>> commit 660e802c76c89e871c29cd3174c07c8d23e39c35
>> Author: Chengming Zhou <zhouchengming@bytedance.com>
>> Date:   Mon Jul 17 12:00:55 2023 +0800
>>
>>     blk-mq: use percpu csd to remote complete instead of per-rq csd
>>
>>     If request need to be completed remotely, we insert it into percpu llist,
>>     and smp_call_function_single_async() if llist is empty previously.
>>
>>     We don't need to use per-rq csd, percpu csd is enough. And the size of
>>     struct request is decreased by 24 bytes.
>>
>>     This way is cleaner, and looks correct, given block softirq is guaranteed
>>     to be scheduled to consume the list if one new request is added to this
>>     percpu list, either smp_call_function_single_async() returns -EBUSY or 0.
>>
>>     Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>     Reviewed-by: Ming Lei <ming.lei@redhat.com>
>>     Reviewed-by: Christoph Hellwig <hch@lst.de>
>>     Link: https://lore.kernel.org/r/20230717040058.3993930-2-chengming.zhou@linux.dev
>>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
> 
> 
> Oh, thanks for the heads-up!
> I will send reviewed version of patch 3.
> 
> I suppose it can go on top of block/for-next, since the above patch is there.
> Does that work for you Jens Axboe?

Just send it against Linus's tree, it's all upstream now.

-- 
Jens Axboe

