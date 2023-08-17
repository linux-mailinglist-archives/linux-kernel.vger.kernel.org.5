Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044C277FCF4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353961AbjHQRZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353964AbjHQRYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:24:54 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F084BD3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:24:52 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6889c748c44so5785b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692293092; x=1692897892;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8vHHVkxWW04IoUZrYFRpOEcAsjjg8V3LWudLTC9GREA=;
        b=QYVrl6FujIq30u7lKbb0YTqb9pdMFvQv2J3WVa07YyWOZKIgoaBlzAvTb5pTrRVof8
         cwaXMhFmAQivePfOEM2qJ1y8z0bqwqTpZht34ALsShKn9IuvFbFXCOzTBFla6NxdbKst
         BsKg5muo7QMuu7YzP4ETLd43HAQxN/vFhVEjAhdDzERTuWkPcuCYLgK4Llj7TR1TjTof
         Tgw/8zqqHFI+SSJ9G0N8nKDzsz/agYbRuCP3h53Ul7UwUO6DnIo7p82KqZj2piOqkIFU
         NT4dyeVLATqeeBqGekxu6Z+immD3fVmqbXI+OOWTTkNil4G/VfzFFxLwrn/RWxrdawve
         j7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692293092; x=1692897892;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vHHVkxWW04IoUZrYFRpOEcAsjjg8V3LWudLTC9GREA=;
        b=lP+C9nJn07zMxmktqVUIilBGHOAuXmB4ZSjC3yfOQsqVveZOo+hxq4lS+U1IinGm2b
         LnPotdUsUS37xxST+9HYkD4ktw/qpyELkAYCTdX3izH7HTi2T65dx0o+oiCEvtuTVASg
         vX3/5ybfVHs2mAA2/vmGS/+xCXBU+hgm1K4xdqVyDxas9givSRfmHwgVnBcZ5t1roL6u
         KpdSnB9daw0TquJy6V1/j/DeCJ8XdRmQSNYHuj5/KW+IYR6Cyb0TIsy4gMdGMdMI8Kio
         FTHZkrSw5RYTfIBYZxLuP+FVveXVcWMg0mUwrcy1+ssQF7hWjMLgSrhnhEn7hSU40jJL
         5G7A==
X-Gm-Message-State: AOJu0Yyez8dPyWZy7FnDeiEfJKgoz/qMwzfnkyPCmKPXIMSJL5x5dUXP
        dpulmcNQ3EF65aDFaHCE47C/rw==
X-Google-Smtp-Source: AGHT+IER3moHf5FdPQm18isIK0ga5d2T5yo9hxPQGIExbRChtG44xh6QtgSsZYySjPATDDv02NbsQA==
X-Received: by 2002:a17:903:22ce:b0:1b8:17e8:547e with SMTP id y14-20020a17090322ce00b001b817e8547emr70150plg.1.1692293092439;
        Thu, 17 Aug 2023 10:24:52 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902d3c600b001bdf45eb5b6sm12246plb.284.2023.08.17.10.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 10:24:51 -0700 (PDT)
Message-ID: <12ecac8d-1837-4083-a7e9-efe826d9ae7f@kernel.dk>
Date:   Thu, 17 Aug 2023 11:24:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk-mq: release scheduler resource when request
 complete
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Chengming Zhou <chengming.zhou@linux.dev>,
        Bart Van Assche <bvanassche@acm.org>, hch@lst.de
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, cel@kernel.org,
        linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
References: <202308172100.8ce4b853-oliver.sang@intel.com>
 <af61c72c-b3ec-ce7a-4f41-bce9a9844baf@acm.org>
 <317715dc-f6e4-1847-5b78-b2d8184b446a@linux.dev>
 <8c262b00-9856-49fa-b425-da863efdff7d@kernel.dk>
In-Reply-To: <8c262b00-9856-49fa-b425-da863efdff7d@kernel.dk>
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

On 8/17/23 11:20 AM, Jens Axboe wrote:
> On 8/17/23 9:29 AM, Chengming Zhou wrote:
>> On 2023/8/17 22:50, Bart Van Assche wrote:
>>> On 8/17/23 07:41, kernel test robot wrote:
>>>> [  222.622837][ T2216] statistics for priority 1: i 276 m 0 d 276 c 278
>>>> [ 222.629307][ T2216] WARNING: CPU: 0 PID: 2216 at block/mq-deadline.c:680 dd_exit_sched (block/mq-deadline.c:680 (discriminator 3))
>>>
>>> The above information shows that dd_inserted_request() has been called
>>> 276 times and also that dd_finish_request() has been called 278 times.
>>
>> Thanks much for your help.
>>
>> This patch indeed introduced a regression, postflush requests will be completed
>> twice, so here dd_finish_request() is more than dd_inserted_request().
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index a8c63bef8ff1..7cd47ffc04ce 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -686,8 +686,10 @@ static void blk_mq_finish_request(struct request *rq)
>>  {
>>         struct request_queue *q = rq->q;
>>
>> -       if (rq->rq_flags & RQF_USE_SCHED)
>> +       if (rq->rq_flags & RQF_USE_SCHED) {
>>                 q->elevator->type->ops.finish_request(rq);
>> +               rq->rq_flags &= ~RQF_USE_SCHED;
>> +       }
>>  }
>>
>>
>> Clear RQF_USE_SCHED flag here should fix this problem, which should be ok
>> since finish_request() is the last callback, this flag isn't needed anymore.
>>
>> Jens, should I send this diff as another patch or resend updated v3?
> 
> I don't think this is the right solution, it makes all kinds of
> assumptions on what that flag is and when it's safe to clear it. It's a
> very fragile fix, I think we need to do better than that.

Well maybe this is actually fine, since we're freeing the request now
anyway. I can fold it in the fix, I'll add a comment as well. If this is
subtle enough that it caused this issue, we definitely should have a
comment on why we're clearing this flag.

-- 
Jens Axboe

