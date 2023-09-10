Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A2F79A092
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 00:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjIJW44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 18:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjIJW4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 18:56:55 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073BA187
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 15:56:50 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bee392fe9dso2713356a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 15:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694386609; x=1694991409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+TPanxOg8S3V8mMy6Pp/m7xqBOLfWHi+HzjTxmwzObk=;
        b=tnY3gk5RmKP8McVvhdot6mmd6KSMTXAAoP76s9kb7nbSMS8bjVKjd/r7FXboiOojdY
         aEWIVwp9rjvc7+GuR4MHcUwQzKG6w3L6Pid6lqnc26CwsXra3tLmuNR2t9NevRlFZWfP
         RbbS51ie/YKWNxUrirkh6hdvSscdElkgZViAGgqZ6P5ke4wCtxECP2pBUxpzWlP4Ld/4
         9o8zuqYf+0G1GejkEpFvoNR4F0gYXDwDm9cl3gVr/viPbxtzhwGG8rYl8tI8zpArVQYa
         2CBohR0TYYPvOw/peUNiJQdO7GaNbZBjtxV8GI0NUM/X1oS6ZLH4WwpzDG7Khn3LDXD3
         yX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694386609; x=1694991409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TPanxOg8S3V8mMy6Pp/m7xqBOLfWHi+HzjTxmwzObk=;
        b=p7hemkl55MW/zXePgi4qJvdez2kekGL5gOS7pj+EkBrDNEJd+qHiN9foJ516zw/05b
         9qSt5vgyJs8/XKGQkmB903GbsWvXkX7mkXnM+zMqP8WOETBFgkRl8/NmNwXndsMpTglg
         DX7y0dCLigGdbP/NgETPjrDLfnpoE6a5J5dTxGnBZn3++k9rjGpxsouYgs3LA6fzhP2O
         Y6net7U76n67DZx7m44ZotzQPwf9j7ps6M9J6YsX9JgSIcyId0+Crvy0lPsaj9zDsGzn
         SB8o+RvmQA8HM21gwT4k/5ssxMpQjfw8Vcyuu7Z9WYm3kubp2LddIOPAIQkzyObvIKTg
         YKfQ==
X-Gm-Message-State: AOJu0Yyld8k/d3hR0Hb1PxjxpjHfAA+V6j8kUklABmNbWUZka65x7syZ
        bm/n7VTpCxWJ4A9ETklZNbj49Q==
X-Google-Smtp-Source: AGHT+IG/p9+fYYrOaawvIfMev9QnWOl8/CdwqzWwYldOYP2/A4VHMvM9tDx8xTlaFVw6ZOc1ZFKwkw==
X-Received: by 2002:a05:6358:3422:b0:134:c1eb:8744 with SMTP id h34-20020a056358342200b00134c1eb8744mr9289128rwd.9.1694386609107;
        Sun, 10 Sep 2023 15:56:49 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id x22-20020aa79196000000b0068bc014f352sm4378359pfa.7.2023.09.10.15.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 15:56:48 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qfTMD-00DXC8-24;
        Mon, 11 Sep 2023 08:56:45 +1000
Date:   Mon, 11 Sep 2023 08:56:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Message-ID: <ZP5JrYOge3tSAvj7@dread.disaster.area>
References: <20230907174705.2976191-1-willy@infradead.org>
 <20230907174705.2976191-2-willy@infradead.org>
 <20230907190810.GA14243@noisy.programming.kicks-ass.net>
 <ZPoift7B3UDQgmWB@casper.infradead.org>
 <20230907193838.GB14243@noisy.programming.kicks-ass.net>
 <ZPpV+MeFqX6RHIYw@dread.disaster.area>
 <20230908104434.GB24372@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908104434.GB24372@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 12:44:34PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 08, 2023 at 09:00:08AM +1000, Dave Chinner wrote:
> 
> > > Right, but if you're not the lock owner, your answer to the question is
> > > a dice-roll, it might be locked, it might not be.
> > 
> > Except that the person writing the code knows the call chain that
> > leads up to that code, and so they have a pretty good idea whether
> > the object should be locked or not. If we are running that code, and
> > the object is locked, then it's pretty much guaranteed that the
> > owner of the lock is code that executed the check, because otherwise
> > we have a *major lock implementation bug*.
> 
> Agreed, and this is fine. However there's been some very creative
> 'use' of the _is_locked() class of functions in the past that did not
> follow 'common' sense.
> 
> If all usage was: I should be holding this, lets check. I probably
> wouldn't have this bad feeling about things.

So your argument against such an interface is essentially "we can't
have nice things because someone might abuse them"?

> > > Most devs should run with lockdep on when writing new code, and I know
> > > the sanitizer robots run with lockdep on.
> > > 
> > > In general there seems to be a ton of lockdep on coverage.
> > 
> > *cough*
> > 
> > Bit locks, semaphores, and all sorts of other constructs for IO
> > serialisation (like inode_dio_wait()) have no lockdep coverage at
> > all. IOWs, large chunks of many filesystems, the VFS and the VM have
> > little to no lockdep coverage at all.
> 
> True, however I was commenting on the assertion that vm code has
> duplicate asserts with the implication that was because not a lot of
> people run with lockdep on.

I think that implication is pretty much spot on the money for any
subsystem that has significant correctness testing overhead. A
single fstests regression test pass for a single configuration for
XFS takes well over 4 hours to run. If I add lockdep, it's about 7
hours. If I add lockdep and KASAN, it's closer to 12 hours. It just
isn't viable to run test kernels with these options day-in, day-out.
Maybe once a release I'll run a weekend sanity check with them
enabled, but otherwise the rare issue they find just isn't worth the
cost of enabling them....


> > > > we also have VM_BUG_ON_MM(!rwsem_is_write_locked(&mm->mmap_lock), mm)
> > > > to give us a good assertion when lockdep is disabled.
> > > 
> > > Is that really worth it still? I mean, much of these assertions pre-date
> > > lockdep.
> > 
> > And we're trying to propagate them because lockdep isn't a viable
> > option for day to day testing of filesystems because of it's
> > overhead vs how infrequently it finds new problems.
> 
> ... in XFS. Lockdep avoids a giant pile of broken from entering the
> kernel and the robots still report plenty.

Nobody is suggesting that lockdep gets replaced by these functions.
They are *in addition* to lockdep, and are used to give use 99.9%
certainty that locks are being used correctly without adding any
runtime overhead at all.

That's the whole point - it is simple introspection code that will
find most gross locking mistakes that people make very quickly,
without any real costs. If you're worried about people abusing
introspection code, then you're forgetting that they can just dig
directly at the rwsem guts directly themselves. Adding an interface
that does introspection right and enables the internal
imp[lementation to change without breaking anything is a no brainer;
it stops people from just digging in the guts of the structure and
guaranteeing that code will break if the implementation changes...

> > > > XFS has a problem with using lockdep in general, which is that a worker
> > > > thread can be spawned and use the fact that the spawner is holding the
> > > > lock.  There's no mechanism for the worker thread to ask "Does struct
> > > > task_struct *p hold the lock?".
> > > 
> > > Will be somewhat tricky to make happen -- but might be doable. It is
> > > however an interface that is *very* hard to use correctly. Basically I
> > > think you want to also assert that your target task 'p' is blocked,
> > > right?
> > > 
> > > That is: assert @p is blocked and holds @lock.
> > 
> > That addresses the immediate symptom; it doesn't address the large
> > problem with lockdep and needing non-owner rwsem semantics.
> > 
> > i.e. synchronous task based locking models don't work for
> > asynchronous multi-stage pipeline processing engines like XFS. The
> > lock protects the data object and follows the data object through
> > the processing pipeline, whilst the original submitter moves on to
> > the next operation to processes without blocking.
> > 
> > This is the non-blocking, async processing model that io_uring
> > development is pushing filesystems towards, so assuming that we only
> > hand a lock to a single worker task and then wait for it complete
> > (i.e. synchronous operation) flies in the face of current
> > development directions...
> 
> I was looking at things from an interface abuse perspective. How easy is
> it to do the wrong thing. As said, we've had a bunch of really dodgy
> code with the _is_locked class of functions, hence my desire to find
> something else.
> 
> As to the whole non-owner locking, yes, that's problematic. I'm not
> convinced async operations require non-owner locking, at the same time I
> do see that IO completions pose a challence.
> 
> Coming from the schedulability and real-time corner, non-owner locks are
> a nightmare because of the inversions. So yeah, fun to be had I'm sure.

I'm not sure you understand the scope of the problem with modern
filesystems vs RT processing. The moment code enters a modern
filesystem, it gives up all hope of real-time response guarantees.
There is currently nothing a RT process can do but wait for the
filesystem to finish with the locks it holds, and the wait times are
effectively unbound because there may be a requirement for tens of
thousands of IOs to be done before the lock is dropped and the RT
task can make progress.

Priority inheritance for the lock owner won't make any difference
here, because the latency is not caused by something running on a
CPU.  IOWs, lock inversions and non-owner locks are the very least
of the problems for RT priority apps when it comes to filesystem
operations.

The solution for RT priority apps avoiding priority inversions in
filesystems is going be io_uring. i.e. the initial NOWAIT operation
is done with RT priority in the RT task itself, but if that is going
to be blocked it gets punted to a background worker for async
processing and the RT priority task goes on to processing the next
thing it needs to do.

All the  background async operations are performed with the same
(non-RT) priority and we just don't need to care about priority
inversions or the problems RT has with non-owner lock contexts. The
RT tasks themselves don't care, either, because they don't ever get
stuck waiting on a filesystem lock that a lower priority task might
hold, or get stuck on an operation that might require unbound
amounts of IO to complete (e.g. transaction reservations).

IOWs, if we want to make "RT with filesystems" a reality, we need to
stop worrying about constraining lock implementations and handling
priority inversions. Instead, we need to look towards how to make
filesystem infrastructure fully non-blocking for RT priority tasks
and writing RT applications to use that infrastructure....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
