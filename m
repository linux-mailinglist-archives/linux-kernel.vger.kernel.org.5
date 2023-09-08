Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1AA797FD2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 02:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbjIHAoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 20:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjIHAoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 20:44:20 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E2B1BD6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 17:44:16 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c1e780aa95so11416045ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 17:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694133856; x=1694738656; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7BcrfYnyRxSF9PP3U2fLWJK1bEQTLfrZGPuCDzVXSzs=;
        b=dTdIXH6k4XQA2NBfWpCUvyz3SuE78dIY5kRtxvBGpKNLaEkF/13BjXeiFBU4I4qukO
         TCCy56+aq3pYBLsazwuK+fJb/dTCX+US2Ih/GnYdY1W8vkYc7KtLhIJ3DgK8MRrlPsiV
         0tygjl9q2gigImZBDNDxFRLRDz3C3kYz9P6SWGTp3iSmEcsI6Jfu3mFqzdwXkvufNMmv
         pA2tfLLBa/J6z/EjQNKWXARGos7WBpomjTgebG0OzzRM/S2A4JePnWJ1ofoXnpHkqz3y
         cUamXOell334Xz9kF2dn1qdXleOBp0axangIoFoTroHjFr4aszhtiMy+ByZAVzoUj6hs
         GNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694133856; x=1694738656;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BcrfYnyRxSF9PP3U2fLWJK1bEQTLfrZGPuCDzVXSzs=;
        b=Sq82yBPTOsoLFnleh4g+tTSVN0s9k0BLCdDMgnQjAXwYK9umy+gPZHC7wdR/NlK9cv
         pHKCICfhTq2x2GGGFzpmpIL87DPxJNRJhjvAOeTdmyy4W6daFRcv16NWzRXlByXILYAH
         nbIOoGGg+wQuq1VJM4UEvdWmYLcRoVnY7E5tq/6W1ftMOgpd0Jn0W/2QrIayW59xPex0
         A78UVVl726uBvvItgAFf46lqvPmjnt7XW3O/0RxCWnk4q6Xsgy79ZEnVoLc9Ll5UeieT
         PWxrCUmDL1Jjv7hLEI9gIrNFZzO7QFilZ5QewNMKNxPSqbN4motOq5NayJyZlG4/6+tq
         hsVA==
X-Gm-Message-State: AOJu0YyGCnft7BJ/LBUpTa0ziU0wgQzNFQC5k4DleUH30Uh2LIhDta0E
        Ie/4J0nX7xPdurR41hZbCFGRVw==
X-Google-Smtp-Source: AGHT+IHF33zguZ89K0iOoy7lHBVYfHc84YSxC26LhbI49eHjFrQwo1x6osxcaKsS9pDqLYWTJEya+A==
X-Received: by 2002:a17:902:db0e:b0:1c3:39f8:3e67 with SMTP id m14-20020a170902db0e00b001c339f83e67mr1370255plx.20.1694133855901;
        Thu, 07 Sep 2023 17:44:15 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id x1-20020a1709029a4100b001befac3b3cbsm320319plv.290.2023.09.07.17.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 17:44:15 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qePbZ-00CFhM-0H;
        Fri, 08 Sep 2023 10:44:13 +1000
Date:   Fri, 8 Sep 2023 10:44:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Message-ID: <ZPpuXTZaeg2BwOIh@dread.disaster.area>
References: <20230907174705.2976191-1-willy@infradead.org>
 <20230907174705.2976191-2-willy@infradead.org>
 <2cd975ec-f868-f180-350f-b1b704118777@redhat.com>
 <ZPolpUuCiGT/5PLO@casper.infradead.org>
 <da1daacf-22b2-20da-b6c0-9b1362b8a901@redhat.com>
 <c38847cb-92c9-139f-03cc-86d233297d58@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c38847cb-92c9-139f-03cc-86d233297d58@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 07:47:31PM -0400, Waiman Long wrote:
> 
> On 9/7/23 17:06, Waiman Long wrote:
> > 
> > On 9/7/23 15:33, Matthew Wilcox wrote:
> > > On Thu, Sep 07, 2023 at 02:05:54PM -0400, Waiman Long wrote:
> > > > On 9/7/23 13:47, Matthew Wilcox (Oracle) wrote:
> > > > > +static inline int rwsem_is_write_locked(struct rw_semaphore *sem)
> > > > > +{
> > > > > +    return atomic_long_read(&sem->count) & 1 /*
> > > > > RWSEM_WRITER_LOCKED */;
> > > > > +}
> > > > I would prefer you move the various RWSEM_* count bit macros from
> > > > kernel/locking/rwsem.c to under the !PREEMPT_RT block and directly use
> > > > RWSEM_WRITER_LOCKED instead of hardcoding a value of 1.
> > > Just to be clear, you want the ~50 lines from:
> > > 
> > > /*
> > >   * On 64-bit architectures, the bit definitions of the count are:
> > > ...
> > > #define RWSEM_READ_FAILED_MASK (RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS|\
> > > RWSEM_FLAG_HANDOFF|RWSEM_FLAG_READFAIL)
> > > 
> > > moved from rwsem.c to rwsem.h?
> > > 
> > > Or just these four lines:
> > > 
> > > #define RWSEM_WRITER_LOCKED     (1UL << 0)
> > > #define RWSEM_FLAG_WAITERS      (1UL << 1)
> > > #define RWSEM_FLAG_HANDOFF      (1UL << 2)
> > > #define RWSEM_FLAG_READFAIL     (1UL << (BITS_PER_LONG - 1))
> > 
> > I think just the first 3 lines will be enough. Maybe a bit of comment
> > about these bit flags in the count atomic_long value.
> 
> Actually, the old rwsem implementation won't allow you to reliably determine
> if a rwsem is write locked because the xadd instruction is used for write
> locking and the code had to back out the WRITER_BIAS if the attempt failed.
> Maybe that is why XFS has its own code to check if a rwsem is write locked
> which is needed with the old rwsem implementation.

mrlocks pre-date rwsems entirely on Linux.  mrlocks were introduced
to XFS as part of the port from Irix back in 2000. This originally
had a 'ismrlocked()' function for checking lock state.

In 2003, this was expanded to allow explicit lock type checks via
'mrislocked_access() and 'mrislocked_update()' wrappers that checked
internal counters to determine how it was locked.

In 2004, the mrlock was converted to use the generic kernel rwsem
implementation, and because that couldn't be used to track writers,
the mrlock included a mr_writer boolean field to indicate it was
write locked for the purpose of implementing the existing debug
checks. Hence the mrlock debug code has always had reliable
differentiation of read vs write state, whereas we couldn't do that
natively with rwsems for a real long time.

The mrlocks have essentially remained unchanged since 2004 - this
long predates lockdep, and it lives on because gives us something
lockdep doesn't: zero overhead locking validation.

> The new implementation makes this check reliable. Still it is not easy to
> check if a rwsem is read locked as the check will be rather complicated and
> probably racy.

You can't look at these locking checks in isolation. These checks
are done in code paths where we expect the caller to have already
locked the rwsem in the manner required. Hence there should be no races
with rwsem state changes at all.

If we see a locking assert to fire, it means we either screwed up
the XFS locking completely (no races necessary), or there's a bug in
the rwsem implementation. The latter case has occurred several
times; the rwsem locking checks in XFS have uncovered more than one
rwsem implementation bug in the past...

IOWs, the explicit lock state checks and asserts provide a
lock implemetnation validation mechanism that lockdep doesn't....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
