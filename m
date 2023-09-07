Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603FB797EE5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjIGXAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjIGXAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:00:17 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3A7CF3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 16:00:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bee82fad0fso12773355ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 16:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694127613; x=1694732413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQjB6U/O9n8tbnlyikl1SjX4EEA6NY7PMDL3dsEt8ag=;
        b=3bBQ0f5+FM7dP0NsQ7PvV62cXfTqIPLk9Ypsi+BkIh/+CXVol/FLXlwUR4oc3Yd2GP
         nwwe46vQt+eAXCoeR+2wOvmL1zvQzCw+QZnETOJP3IH8YY0ZuxUEiTNe2JcWk6IjLjVV
         og+TcaY8v1ZAnAUy9UnFa+6TXvd1uJgpEtbqXtnRXKRShCK3EPbVYHnUh0/kBv5LvXft
         zm/SCwLdVrGH/nEHgbMix/TTPXEQBLpq0mPpdfcEtT1laH1WiUQLK4TeyD/826h3VOaK
         zZgdtnpMIZGWvKLzzgdJIYNKPQWyKM4RFLwO1vRfk8Fqa94tchKe28bmGNBTgBor7ZKE
         6+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694127613; x=1694732413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQjB6U/O9n8tbnlyikl1SjX4EEA6NY7PMDL3dsEt8ag=;
        b=BAzP3yjS34Lk9BEmC0cQRbxwgFaba3i/yqQXrJ5NlQ4HnzjM2fUdgRkNQnmxaJA5Vy
         RM/sJSdUPZ0rqwPFDjnRl+EhAlEinq2cchUK6OMzujdXd+zVD8GWAIivge+70S7UOsVF
         f7CXpE7yyGkTj7dagRVhpSQ2zbUmYOmxthU1JEapiLll8a7Tp/GJHSQMWfZLCtSJIIdv
         3HwjXfaGejqhslpE1ziW5KEMdJklHLKHv8caUHIoruBS9k/3gpa9q95HrVDnBsKxyILo
         0zNdahbjbseoa/mL1TXGDcVIHDQ1fnmOhGzroLGBxayNEFlL9ihn9InGknZwRT12cYbN
         776w==
X-Gm-Message-State: AOJu0YzEtmuQv8QPxqA8TulnukNXT9zMEl4kVF5ih6QGANWBzkKK72jK
        o6wa5Ll2OTJbIs8KgdPczcpVKw==
X-Google-Smtp-Source: AGHT+IGsffnzD07F/Mr4xarHC2RsEQpoBGEzHLbPmvs8gys7LfOCUfvBMIv/aJDTbmnyZ0TH/dEdBw==
X-Received: by 2002:a17:903:11c9:b0:1b9:e972:134d with SMTP id q9-20020a17090311c900b001b9e972134dmr972287plh.3.1694127612389;
        Thu, 07 Sep 2023 16:00:12 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902f68500b001bc0f974117sm265116plg.57.2023.09.07.16.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 16:00:11 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qeNyq-00CDqz-38;
        Fri, 08 Sep 2023 09:00:08 +1000
Date:   Fri, 8 Sep 2023 09:00:08 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Message-ID: <ZPpV+MeFqX6RHIYw@dread.disaster.area>
References: <20230907174705.2976191-1-willy@infradead.org>
 <20230907174705.2976191-2-willy@infradead.org>
 <20230907190810.GA14243@noisy.programming.kicks-ass.net>
 <ZPoift7B3UDQgmWB@casper.infradead.org>
 <20230907193838.GB14243@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907193838.GB14243@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 09:38:38PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 07, 2023 at 08:20:30PM +0100, Matthew Wilcox wrote:
> > On Thu, Sep 07, 2023 at 09:08:10PM +0200, Peter Zijlstra wrote:
> > > On Thu, Sep 07, 2023 at 06:47:01PM +0100, Matthew Wilcox (Oracle) wrote:
> > > > Several places want to know whether the lock is held by a writer, instead
> > > > of just whether it's held.  We can implement this for both normal and
> > > > rt rwsems.  RWSEM_WRITER_LOCKED is declared in rwsem.c and exposing
> > > > it outside that file might tempt other people to use it, so just use
> > > > a comment to note that's what the 1 means, and help anybody find it if
> > > > they're looking to change the implementation.
> > > 
> > > I'm presuming this is deep in a callchain where they know they hold the
> > > lock, but they lost in what capacity?
> > 
> > No, it's just assertions.  You can see that in patch 3 where it's
> > used in functions called things like "xfs_islocked".
> 
> Right, but if you're not the lock owner, your answer to the question is
> a dice-roll, it might be locked, it might not be.

Except that the person writing the code knows the call chain that
leads up to that code, and so they have a pretty good idea whether
the object should be locked or not. If we are running that code, and
the object is locked, then it's pretty much guaranteed that the
owner of the lock is code that executed the check, because otherwise
we have a *major lock implementation bug*.

i.e. if we get to a place where rwsem_is_write_locked() fires
because some other task holds the lock, it almost always means we
have *two* tasks holding the lock exclusively.

Yes, it's these non-lockdep checks in XFS that have found rwsem
implementation bugs in the past. We've had them fire when the lock
was write locked when we know a few lines earlier it was taken as a
read lock, or marked write locked when they should have been
unlocked, etc because the rwsem code failed to enforce rw exclusion
semantics correctly.

So, really, these lock checks should be considered in the context of
the code that is running them and what such a "false detection"
would actually mean. In my experience, a false detection like you
talk about above means "rwsems are broken", not that there is a
problem with the code using the rwsems or the rwsem state check.

> > > In general I strongly dislike the whole _is_locked family, because it
> > > gives very poorly defined semantics if used by anybody but the owner.
> > > 
> > > If these new functions are indeed to be used only by lock holders to
> > > determine what kind of lock they hold, could we please put:
> > > 
> > > 	lockdep_assert_held()
> > > 
> > > in them?
> > 
> > Patch 2 shows it in use in the MM code.  We already have a
> > lockdep_assert_held_write(), but most people don't enable lockdep, so
> 
> Most devs should run with lockdep on when writing new code, and I know
> the sanitizer robots run with lockdep on.
> 
> In general there seems to be a ton of lockdep on coverage.

*cough*

Bit locks, semaphores, and all sorts of other constructs for IO
serialisation (like inode_dio_wait()) have no lockdep coverage at
all. IOWs, large chunks of many filesystems, the VFS and the VM have
little to no lockdep coverage at all.

> > we also have VM_BUG_ON_MM(!rwsem_is_write_locked(&mm->mmap_lock), mm)
> > to give us a good assertion when lockdep is disabled.
> 
> Is that really worth it still? I mean, much of these assertions pre-date
> lockdep.

And we're trying to propagate them because lockdep isn't a viable
option for day to day testing of filesystems because of it's
overhead vs how infrequently it finds new problems.

> > XFS has a problem with using lockdep in general, which is that a worker
> > thread can be spawned and use the fact that the spawner is holding the
> > lock.  There's no mechanism for the worker thread to ask "Does struct
> > task_struct *p hold the lock?".
> 
> Will be somewhat tricky to make happen -- but might be doable. It is
> however an interface that is *very* hard to use correctly. Basically I
> think you want to also assert that your target task 'p' is blocked,
> right?
> 
> That is: assert @p is blocked and holds @lock.

That addresses the immediate symptom; it doesn't address the large
problem with lockdep and needing non-owner rwsem semantics.

i.e. synchronous task based locking models don't work for
asynchronous multi-stage pipeline processing engines like XFS. The
lock protects the data object and follows the data object through
the processing pipeline, whilst the original submitter moves on to
the next operation to processes without blocking.

This is the non-blocking, async processing model that io_uring
development is pushing filesystems towards, so assuming that we only
hand a lock to a single worker task and then wait for it complete
(i.e. synchronous operation) flies in the face of current
development directions...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
