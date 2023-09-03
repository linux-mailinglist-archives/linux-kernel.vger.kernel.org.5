Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E36790F29
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 01:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349501AbjICXJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 19:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjICXJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 19:09:55 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECFDED
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 16:09:52 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b9a2416b1cso868572a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 16:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1693782592; x=1694387392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UiJZGoOQnH5exzVzd3ArFdofBPAwCupRSoYg3cTCcl4=;
        b=pCBvEf9EUIsSZ4cY5lWiqimPd6eucLhKte/Vj6Z50DNKIc7hOJlfq48mlyGMI/XUSn
         OIymuMN9qQnUhG7pW3hlDk1VXU7qvQ4zz9YyVkINe5ZCTRl5/YnolqNwoeMc/R8z/vTR
         SJ3pQdE6KXpXfYDtANWbRCmp/v+H692VTBaFBijSUhYGPojOZXXPBznQzsWfUTGgfJx/
         RvE8f1vfm7j8utR9VTeOe+Kexni6pgAHc3RdWGYdBozOBvxpVsvvcML9kSZj6w/wCO5z
         kbyR/4N9TNBBj+FNFqFbriowXr4zBJ886smuhPu9mLCC5SsC4naE3SyUWFcdu8HLhm0y
         CH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693782592; x=1694387392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiJZGoOQnH5exzVzd3ArFdofBPAwCupRSoYg3cTCcl4=;
        b=T4NS7sge3bsOy3vJGUrqMoD/nq/wNYXCR3gS2uYRb4HOLRMFqbPdoBvVB3Qsf+dCqA
         vhe10XY+uwh4K2pzQ9LitJlCQfcm18JPhKzpU3d529eSwsGd1XPNXKUNj5xbKFXD4Iv3
         4CsRgKlOLAQ8Jgc1DGXY1+Y5FA1f1qYojg+JyDZ026b+8Xxsfd+fZ7rHAtxTRs2HCF8g
         E653q3QBU8cyXbT2JGRz1uQb7+taq2Ugqv2tT9SoZrMCqzefd/nZMO2nIWa/YJX41gOo
         hUKoTIQX7E5li4tIohPpFsh9xHna6zHR/rv8FOavGFHqNuIvCyQ3NdFqzqU1sVptzvPD
         rceA==
X-Gm-Message-State: AOJu0YxcvGpFXfzBDN3T3I9Ql6s2rHLClnmJu1JHhf9aSNyqTHzGWCPf
        pwP+1v0ZGR9P9+akdDIYgZqiOA==
X-Google-Smtp-Source: AGHT+IEY9L6RiWSxw7RgazDOdiSC3je0FKTZcPb7XeMYLT6y7s/BQQv5ki4pLBVh/yALQVuumWl9DA==
X-Received: by 2002:a05:6870:a413:b0:1d1:1ea:9aa with SMTP id m19-20020a056870a41300b001d101ea09aamr11784656oal.27.1693782591707;
        Sun, 03 Sep 2023 16:09:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id u191-20020a6379c8000000b0056368adf5e2sm6392080pgc.87.2023.09.03.16.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 16:09:51 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qcwE0-00ASwR-29;
        Mon, 04 Sep 2023 09:09:48 +1000
Date:   Mon, 4 Sep 2023 09:09:48 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     syzbot <syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com>,
        brauner@kernel.org, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [xfs?] INFO: task hung in __fdget_pos (4)
Message-ID: <ZPUSPAnuGLLe3QWH@dread.disaster.area>
References: <000000000000e6432a06046c96a5@google.com>
 <ZPQYyMBFmqrfqafL@dread.disaster.area>
 <20230903083357.75mq5l43gakuc2z7@f>
 <ZPUIQzsCSNlnBFHB@dread.disaster.area>
 <CAGudoHE_-2765EttOV_6B9EeSuOxqo1MiRCyFP9y=GbSeCMtZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHE_-2765EttOV_6B9EeSuOxqo1MiRCyFP9y=GbSeCMtZg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 12:47:53AM +0200, Mateusz Guzik wrote:
> On 9/4/23, Dave Chinner <david@fromorbit.com> wrote:
> > On Sun, Sep 03, 2023 at 10:33:57AM +0200, Mateusz Guzik wrote:
> >> On Sun, Sep 03, 2023 at 03:25:28PM +1000, Dave Chinner wrote:
> >> > On Sat, Sep 02, 2023 at 09:11:34PM -0700, syzbot wrote:
> >> > > Hello,
> >> > >
> >> > > syzbot found the following issue on:
> >> > >
> >> > > HEAD commit:    b97d64c72259 Merge tag
> >> > > '6.6-rc-smb3-client-fixes-part1' of..
> >> > > git tree:       upstream
> >> > > console output:
> >> > > https://syzkaller.appspot.com/x/log.txt?x=14136d8fa80000
> >> > > kernel config:
> >> > > https://syzkaller.appspot.com/x/.config?x=958c1fdc38118172
> >> > > dashboard link:
> >> > > https://syzkaller.appspot.com/bug?extid=e245f0516ee625aaa412
> >> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for
> >> > > Debian) 2.40
> >> > >
> >> > > Unfortunately, I don't have any reproducer for this issue yet.
> >> >
> >> > Been happening for months, apparently, yet for some reason it now
> >> > thinks a locking hang in __fdget_pos() is an XFS issue?
> >> >
> >> > #syz set subsystems: fs
> >> >
> >>
> >> The report does not have info necessary to figure this out -- no
> >> backtrace for whichever thread which holds f_pos_lock. I clicked on a
> >> bunch of other reports and it is the same story.
> >
> > That's true, but there's nothing that points at XFS in *any* of the
> > bug reports. Indeed, log from the most recent report doesn't have
> > any of the output from the time stuff hung. i.e. the log starts
> > at kernel time 669.487771 seconds, and the hung task report is at:
> >
> 
> I did not mean to imply this is an xfs problem.
> 
> You wrote reports have been coming in for months so it is pretty clear
> nobody is investigating.

Which is pretty much the case for all filesystem bug reports from
syzbot except for those reported against XFS. Almost nobody else is
doing immediately triage syzbot reports, so they just sit there
gathering dust.

This reflects they reality that syzbot is doing stuff that just
doesn't happen to filesystems in production systems. Users will
almost never see these issues in real life because they aren't
corrupting the crap out their filesystems and running randomly
generated syscalls on them.

> I figured I'm going to change that bit.

I wish you the best of luck.

> >> Can the kernel be configured to dump backtraces from *all* threads?
> >
> > It already is (sysrq-t), but I'm not sure that will help - if it is
> > a leaked unlock then nothing will show up at all.
> 
> See the other part of the thread, I roped in someone from syzkaller
> along with the question if they can use sysrq t.

Yes, I saw that. I'm just saying that there's a real good chance it
won't actually help and will just generate a heap more report noise.
Stack traces from all the idle tasks don't really tell us anything
about what went wrong....

Lockdep reports and logs are difficult enough to parse at the best
of times, adding more noise won't help anyone. We already have the
output of sysrq-l (from the nmi sent to all cpus before panic), so
the only remaining really useful debugging output missing is sysrq-w
(blocked tasks).

If something is blocked holding the f_pos_lock long enough to
trigger the hung task timer, then whatever task is holding it must
be blocked itself on something else. The sysrq-w output will dump
that without adding all the idle task noise....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
