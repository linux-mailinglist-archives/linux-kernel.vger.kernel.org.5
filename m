Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8027FC14F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344689AbjK1Qqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbjK1Qqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:46:36 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C60D6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:46:41 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7b03ed4463bso36681539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701190001; x=1701794801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FC22H30ZnvwwSVhgJkgDSIM3iYoUcOq3moQMAUXTuis=;
        b=yrPQTQBoU5V0UdiRnWa6iyXSuWVv8uUMi0xVv8KyzitTQkxhkiLPRufPgxZg2kWsfS
         AWY8ISb+SlWuS61Q8KNdSR7gA5ct03wM63bPWIsBNHDsKxcErTy2QoR8tA0LCZ7pRb7C
         dMU6S3tuVLQXv6B0HWVgSBETdvhrvxy+mfcdQaRlFZrWjg6StnHTPYMy/v/onXWxoPHS
         OqxBeIYSYUr9kcCDBWHc/3LN0xdNffwZQMOQFzq1ApEmCTgs/mjjRjCBBziSipT8jicI
         0WlaITjpYBzK2pKyPK4C8YC8yCEMzxiM4/FbtvrHipmZHu+T90ZBaNPtrtiLN2w0nd4p
         TcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701190001; x=1701794801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FC22H30ZnvwwSVhgJkgDSIM3iYoUcOq3moQMAUXTuis=;
        b=ehmhXRQThXONVYZ4iaf2el/VUFp3fyR1/76Sykc2TmvwfJp60o2fiz1NvUb9pguynh
         M21W9rn7IFkVyEkNHa0NfBxzm4sFhiE7AajZ1KlU7lID8ZX5goHwBV3YctXbL1BYuK/N
         EmFxFi8HRKPoBkk4m2RoLr3ECcPrGB4cvu1ogzljpU3u61wH6uIeeZhg0V/bJauMHLZO
         qdzN/yOX3oK6S9pf5yPj6ZzwKZAhBrpHX4W44naR2CZQIZqg+f4Y3p+v2SHAVlu/lhpr
         35ulsH6uFnhcviECpJ4fchgznIGGasSTRnnmTtRonhLMgNmJ5lbLuLitPGy0522gey1z
         t0uQ==
X-Gm-Message-State: AOJu0YxiRAqahR6QwXK6sWKd7Jyo4kGMu7sbRU1SzyqSfUGp263sJtVT
        oMEhxUmpJJJJ8mqkpN1EG1vf9Q==
X-Google-Smtp-Source: AGHT+IFKrrIZ/S7M8LDYTLoilVeQ7ucqJLeusJmLSSSpmHSEM1ED4ULEDMzgIvO2AOz0NZymd4QK2A==
X-Received: by 2002:a5d:9c18:0:b0:79f:a8c2:290d with SMTP id 24-20020a5d9c18000000b0079fa8c2290dmr15531178ioe.0.1701190001098;
        Tue, 28 Nov 2023 08:46:41 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v20-20020a02cbb4000000b0046454407b68sm2945617jap.114.2023.11.28.08.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 08:46:40 -0800 (PST)
Message-ID: <6100720c-ea86-4d20-ae7a-b32d3a5f10c3@kernel.dk>
Date:   Tue, 28 Nov 2023 09:46:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: io_uring: risky use of task work, especially wrt fdget()
Content-Language: en-US
To:     Jann Horn <jannh@google.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        io-uring <io-uring@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
References: <CAG48ez1htVSO3TqmrF8QcX2WFuYTRM-VZ_N10i-VZgbtg=NNqw@mail.gmail.com>
 <fadbb6b5-a288-40e2-9bb8-7299ea14f0a7@kernel.dk>
 <af45ad55-c002-4bbd-9226-88439bbd4916@kernel.dk>
 <CAG48ez2PeV8WiMdHakqTrVHtbO=N8RKtqAq1v6bNbNOMdMJ9QA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAG48ez2PeV8WiMdHakqTrVHtbO=N8RKtqAq1v6bNbNOMdMJ9QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/23 9:36 AM, Jann Horn wrote:
> On Tue, Nov 28, 2023 at 5:19?PM Jens Axboe <axboe@kernel.dk> wrote:
>> On 11/28/23 8:58 AM, Jens Axboe wrote:
>>> On 11/27/23 2:53 PM, Jann Horn wrote:
>>>> Hi!
>>>>
>>>> I noticed something that I think does not currently cause any
>>>> significant security issues, but could be problematic in the future:
>>>>
>>>> io_uring sometimes processes task work in the middle of syscalls,
>>>> including between fdget() and fdput(). My understanding of task work
>>>> is that it is expected to run in a context similar to directly at
>>>> syscall entry/exit: task context, no locks held, sleeping is okay, and
>>>> it doesn't execute in the middle of some syscall that expects private
>>>> state of the task_struct to stay the same.
>>>>
>>>> An example of another user of task work is the keyring subsystem,
>>>> which does task_work_add() in keyctl_session_to_parent() to change the
>>>> cred pointers of another task.
>>>>
>>>> Several places in io_uring process task work while holding an fdget()
>>>> reference to some file descriptor. For example, the io_uring_enter
>>>> syscall handler calls io_iopoll_check() while the io_ring_ctx is only
>>>> referenced via fdget(). This means that if there were another kernel
>>>> subsystem that uses task work to close file descriptors, io_uring
>>>> would become unsafe. And io_uring does _almost_ that itself, I think:
>>>> io_queue_worker_create() can be run on a workqueue, and uses task work
>>>> to launch a worker thread from the context of a userspace thread; and
>>>> this worker thread can then accept commands to close file descriptors.
>>>> Except it doesn't accept commands to close io_uring file descriptors.
>>>>
>>>> A closer miss might be io_sync_cancel(), which holds a reference to
>>>> some normal file with fdget()/fdput() while calling into
>>>> io_run_task_work_sig(). However, from what I can tell, the only things
>>>> that are actually done with this file pointer are pointer comparisons,
>>>> so this also shouldn't have significant security impact.
>>>>
>>>> Would it make sense to use fget()/fput() instead of fdget()/fdput() in
>>>> io_sync_cancel(), io_uring_enter and io_uring_register? These
>>>> functions probably usually run in multithreaded environments anyway
>>>> (thanks to the io_uring worker threads), so I would think fdget()
>>>> shouldn't bring significant performance savings here?
>>>
>>> Let me run some testing on that. It's a mistake to think that it's
>>> usually multithreaded, generally if you end up using io-wq then it's not
>>> a fast path. A fast networked setup, for example, would never touch the
>>> threads and hence no threading would be implied by using io_uring. Ditto
>>> on the storage front, if you're just reading/writing or eg doing polled
>>> IO. That said, those workloads are generally threaded _anyway_ - not
>>> because of io_uring, but because that's how these kinds of workloads are
>>> written to begin with.
> 
> Aah, because with polled I/O, when the fd is signalled as ready, the
> actual execution of work is done via task_work? Thanks for the
> explanation, I missed that.

For polled IO, there's actually no task_work at all, as the polling task
will run the completions itself, inline. But for things like eg network
recv, when data readiness is triggered, the receive retry is done via
task_work. We don't block on anything pollable, which would then mean
you'd be punting it to io-wq.

There are obviously things that WILL punt to io-wq as part of normal
operations. Buffered reads will generally not need io-wq, but buffered
writes certainly can if we need to throttle or otherwise do something
that will block. For O_DIRECT IO, you'd only ever need io-wq if you
overload the device resources. Fast path DIO would not use io-wq either.

Outside of that, there's a class of "slower" opcodes which always punt
to io-wq. Things like fsync, for example.

For an efficient networked or storage ring usage, you'd never see io-wq
being used.

>>> So probably won't be much of a concern to do the swap. The only
>>> "interesting" part of the above mix of cancel/register/enter is
>>> obviously the enter part. The rest are not really fast path.
>>
>> Did all three and ran the usual testing, which just so happens to be
>> multithreaded to begin with anyway. No discernable change from using
>> fget/fput over fdget/fdput.
> 
> Oh, nice!
> 
>> IOW, we may as well do this. Do you want to send a patch? Or I can send
>> out mine, up to you.
> 
> Ah, if you already cooked up a patch to do the testing, I guess it's
> easier if you commit that?

Sure, I can do that. I'll put a link in to this thread and add a
Suggested-by as well. Commit message will be mostly an edited version of
your post anyway.

-- 
Jens Axboe

