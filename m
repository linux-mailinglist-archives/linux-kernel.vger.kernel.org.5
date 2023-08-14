Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3559277B4E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbjHNI5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbjHNIyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:54:47 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA7991
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:54:45 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-5607cdb0959so2159925eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692003285; x=1692608085;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aR91MY7Oh09KpS727KCeJ3mcvzJyldRSbxy/QhOyO5k=;
        b=HrwF4peuLbA/cIz1w/lEdEpIdn96MIOLnhYIL/HL2K6AbFBs20gI+nA4ddpJgEtGU2
         SB4cpwNVCoP353seV6mnShRVqoRrno8Ae3qoKA3mZbPIE2Dv54H018/C6mL217T1XBwC
         HJdqkKFGM5xDulrNsKI/wNg9FsW1EHpQ+kj6w5ucErfVfg9PcTbNbXW+n3S4FwcvlMpA
         nD/sXKifB3rxiBD8MafG1Ro82zqkI5o3IW7EZMBSHKtp4BhUUoKvb+NTpeIpl1qB40YY
         mC22RFXd8GkCw8zfdgnXEmHcWwhN8l/7p6JNMP/Nk+7t2C16v1lrxFXylgqMhP2yEjD4
         tydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692003285; x=1692608085;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aR91MY7Oh09KpS727KCeJ3mcvzJyldRSbxy/QhOyO5k=;
        b=EQ52InbWlbfgBBbhSh1nykQnKKbnUVRWuAyJJeL7owQhvVyEWVUwZ4IBARzEo2FT0R
         iQWes5/HywGGw3pVTvyQukvjLF0U1D8VfPJDrsJ+V8cQTPZ4NKx2MP++pbxBssxWl1Ks
         dJLVnl2CJWsLW72C/7HIKRynAIQlDjHGh9mZ/ExNY5datTuS1yqi1FLJMlJG4HwNCMB/
         61VCyWF86igwgk7XL1RRSrPYqg4Axwl6r68M10FrnvNQ+Aph3zN68DLpiUeW4nacRqQp
         PCKGaw/zL7lo4GNRo8V5pDBjF4isYJbgVUfRzGKCSt/1ZcJcAY9XuaJHoaUFxIMag2ZZ
         NzdA==
X-Gm-Message-State: AOJu0Yy5J93VCDyju45WuoIQFjDc/7kBbnuUJcf4ia2TK0dMPmIzzYDQ
        k3HEVG/4laqCBygGD0eQaoIGl6durBclneq6eiw=
X-Google-Smtp-Source: AGHT+IHlSGmmMgbNqIwt4rUCoB+s3Xgp1D54AGiiNEBkvdpZfJQN0bNsejOc1ve/PqJ4mlS12XIzuLCvih9PG5Ay0D4=
X-Received: by 2002:a4a:8382:0:b0:56c:cd04:9083 with SMTP id
 h2-20020a4a8382000000b0056ccd049083mr4855505oog.1.1692003284851; Mon, 14 Aug
 2023 01:54:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:9cf:0:b0:4f0:1250:dd51 with HTTP; Mon, 14 Aug 2023
 01:54:44 -0700 (PDT)
In-Reply-To: <88f1f73e-9879-95f9-bbc4-339c43a5c2f1@redhat.com>
References: <20230813123333.1705833-1-mjguzik@gmail.com> <00dd353b-e5aa-69fb-6b52-cb59028ea90a@redhat.com>
 <CAGudoHHHyZJXkNfGjGyxqHDay3yAzCm97r6SOdiSLYao7q2Z7A@mail.gmail.com> <88f1f73e-9879-95f9-bbc4-339c43a5c2f1@redhat.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Mon, 14 Aug 2023 10:54:44 +0200
Message-ID: <CAGudoHGvBEpotHW0t3cDp4487SqSvba6JAW9N6jWuUz=_K7ixA@mail.gmail.com>
Subject: Re: [PATCH] kernel/fork: stop playing lockless games for exe_file replacement
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, linux-mm@kvack.org, koct9i@gmail.com,
        oleg@redhat.com, dave@stgolabs.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/23, David Hildenbrand <david@redhat.com> wrote:
> On 14.08.23 10:21, Mateusz Guzik wrote:
>> On 8/14/23, David Hildenbrand <david@redhat.com> wrote:
>>> On 13.08.23 14:33, Mateusz Guzik wrote:
>>>> xchg originated in 6e399cd144d8 ("prctl: avoid using mmap_sem for
>>>> exe_file serialization"). While the commit message does not explain
>>>> *why* the change, clearly the intent was to use mmap_sem less in this
>>>> codepath. I found the original submission [1] which ultimately claims
>>>> it
>>>> cleans things up.
>>>
>>> More details are apparently in v1 of that patch:
>>>
>>> https://lore.kernel.org/lkml/1424979417.10344.14.camel@stgolabs.net/
>>>
>>> Regarding your patch: adding more mmap_write_lock() where avoidable, I'm
>>> not so sure.
>>>
>>
>> But exe_file access is already synchronized with the semaphore and
>> your own commit added a mmap_read_lock/mmap_read_unlock cycle after
>> the xchg in question to accomodate this requirement.
>
> Yes, we want to handle concurrent fork() ("Don't race with dup_mmap()"),
> thus mmap_read_lock.
>
>> Then mmap_write_lock around the replacement is the obvious thing to do.
>
> Apparently to you. :)
>
> mmap_write_lock will block more than fork. For example, concurrent page
> faults (without new VMA locking), for no apparent reason to me.
>
>>
>>> Your patch doesn't look (to me) like it is removing a lot of complexity.
>>>
>>
>> The code in the current form makes the reader ask what prompts xchg +
>> read-lock instead of mere write-locking.
>>
>> This is not a hot path either and afaics it can only cause contention
>> if userspace is trying to abuse the interface to break the kernel,
>> messing with a processs hard at work (which would be an extra argument
>> to not play games on kernel side).
>>
>> That said, no, it does not remove "a lot of complexity". It does
>> remove some though at no real downside that I can see.
>>
>> But then again, it is on people who insist on xchg to justify it.
>
> Changing it now needs good justification, why we would want to block any
> concurrent MM activity. Maybe there is good justification.
>
> In any case, this commit would have to update the documentation of
> replace_mm_exe_file, that spells out existing locking behavior.
>

Perhaps it will help if I add that the prctl thingy always had a
troubled relationship with locking.

Last time I looked at it was in 2016, where I found that it was doing
down_read to update arg_start/arg_end and others while a consumer in
procfs would read them and assert on their sanity. As only a read-lock
was held, 2 threads could be used to transiently produce a bogus state
as they race with their updates and trigger the BUG. See this commit
(but also excuse weirdly bad english ;))
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ddf1d398e517e660207e2c807f76a90df543a217

Moreover check out the following in prctl_set_auxv:

        task_lock(current);
        memcpy(mm->saved_auxv, user_auxv, len);
        task_unlock(current);

any thread in the process can reach that codepath while sharing the
same mm, thus this does not lock any updates. Not only that, but a
duplicated memcpy onto the area in prctl_set_mm_map does not even take
that lock and the code to read this does not take any locks.

[Code duplication and synchronization aside, additional points
deducted for saved_auxv storing always-NULL pointers instead of adding
them on reads.]

The above exhausts my willingness to argue about this change, I'm just
a passerby. If it is NAKed, I'm dropping the subject.

I am willing to do the comment tidy ups if this can go in though, but
not before there is consensus.

-- 
Mateusz Guzik <mjguzik gmail.com>
