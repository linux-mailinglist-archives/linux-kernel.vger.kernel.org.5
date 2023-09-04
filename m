Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E905C790FB1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 03:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350487AbjIDBpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 21:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350348AbjIDBpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 21:45:12 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6686F5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 18:45:07 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-56c2e840e70so675439a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 18:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1693791907; x=1694396707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+pt3b8Sb6AiK5WocySkxjggjQHXqyW5gYWumxBmcFDw=;
        b=BmrPbzfWIhCy/v0GcqaroLm49+l5inO+z8V0bNG4W5y+slRx3R3DDrObCujUXZZZri
         P5j6vQRYXGmtKfIQ1pvz7wQ3nKj3IIXuMsmMOc4clKxWhmoSRj8bG7NKoOtOgzdnkOiA
         lDxLCNdVkQG2wQlCM23Rwe3VfKcmkS3etWEzKtZR3ypUzFtT60y3hrSXQpiy1yKrhrxs
         YYbxuIdHwTOt1c09XfEHD+TBiJFphvK7q8TRr/cYu9gDqjsS6KUFnbF6j+fXsHngXDRL
         wnZbGb3HNglPgkQl1FLZeHKA5AU/NNV5fDMKhptJygD3fQiQK6oGQ2CSM4NMrYpDkDJW
         a79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693791907; x=1694396707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pt3b8Sb6AiK5WocySkxjggjQHXqyW5gYWumxBmcFDw=;
        b=frXUC7hbO6sIYiEwerQeSDf+LNMRDTXTLB6oBV2PDXo/mfO0rZ1PcOkVGoNxUxnKhc
         F9USfv+mscMHMe05TMBxnbM+hcsAImz2yEzaUsotMWRCmgsjZHV1Am1ByxWPYcxKy1dt
         4OXE1iJZ7xR+AZHS0j2iMhsTvkrkGYIh0F2NP3KVF31Qif4QalkpCC6csFGOJY1BcafI
         FBtGmrwE3WZPNdTFTplL+CM47UNgwXQRQ5Enqspq3Je8FOW+GK2N0zYneWEWfDjSQWBo
         1Yf8LicKV6ubEHwjId96wYVKGvaBiMvZFdw4VYDcI4Mh5e90vguoxAKpGiUDf5u+4XP3
         yyoQ==
X-Gm-Message-State: AOJu0Yxwb+bnhtvfqz8z1dMMBVS31dvTHXrEpMjqCucW32Xc9ptkIyPE
        vt+wAAs/WehoxpdDU0g3jMmgDg==
X-Google-Smtp-Source: AGHT+IHX1MZJE5mNlS6SKl0BnsE+edUgRDsneh0nGDxp9cllpZ2KH/IlHcylYDMkHmDsxYbX6W8KhQ==
X-Received: by 2002:a05:6a20:8f28:b0:14c:a2e1:65ec with SMTP id b40-20020a056a208f2800b0014ca2e165ecmr12695592pzk.38.1693791907275;
        Sun, 03 Sep 2023 18:45:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902ea9500b001b8a3e2c241sm6479177plb.14.2023.09.03.18.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 18:45:06 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qcyeF-00AVtB-2r;
        Mon, 04 Sep 2023 11:45:03 +1000
Date:   Mon, 4 Sep 2023 11:45:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        syzbot <syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com>,
        brauner@kernel.org, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Subject: Re: [syzbot] [xfs?] INFO: task hung in __fdget_pos (4)
Message-ID: <ZPU2n48GoSRMBc7j@dread.disaster.area>
References: <000000000000e6432a06046c96a5@google.com>
 <ZPQYyMBFmqrfqafL@dread.disaster.area>
 <20230903083357.75mq5l43gakuc2z7@f>
 <ZPUIQzsCSNlnBFHB@dread.disaster.area>
 <20230903231338.GN3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903231338.GN3390869@ZenIV>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 12:13:38AM +0100, Al Viro wrote:
> On Mon, Sep 04, 2023 at 08:27:15AM +1000, Dave Chinner wrote:
> 
> > It already is (sysrq-t), but I'm not sure that will help - if it is
> > a leaked unlock then nothing will show up at all.
> 
> Unlikely; grep and you'll see - very few callers, and for all of them
> there's an fdput_pos() downstream of any fdget_pos() that had picked
> non-NULL file reference.
> 
> In theory, it's not impossible that something had stripped FDPUT_POS_UNLOCK
> from the flags, but that's basically "something might've corrupted the
> local variables" scenario.

Entirely possible - this is syzbot we are talking about here.
Especially if reiser or ntfs has been tested back before the logs we
have start, as both are known to corrupt memory and/or leak locks
when trying to parse corrupt filesystem images that syzbot feeds
them.  That's why we largely ignore syzbot reports that involve
those filesystems...

Unfortunately, the logs from what was being done around when the
tasks actually hung are long gone (seems like only the last 20-30s
of log activity is reported) so when the hung task timer goes off
at 143s, there is nothing left to tell us what might have caused it.

IOWs, it's entirely possible that it is a memory corruption that
has resulted in a leaked lock somewhere...

> There are 12 functions total where we might
> be calling fdget_pos() and all of them are pretty small (1 in alpha
> osf_sys.c, 6 in read_write.c and 5 in readdir.c); none of those takes
> an address of struct fd, none of them has assignments to it after fdget_pos()
> and the only accesses to its members are those to fd.file - all fetches.
> Control flow is also easy to check - they are all short.
> 
> IMO it's much more likely that we'll find something like
> 
> thread A:
> 	grabs some fs lock
> 	gets stuck on something
> thread B: write()
> 	finds file
> 	grabs ->f_pos_lock
> 	calls into filesystem
> 	blocks on fs lock held by A
> thread C: read()/write()/lseek() on the same file
> 	blocks on ->f_pos_lock

Yes, that's exactly what I said in a followup email - we need to
know what happened to thread A, because that might be where we are
stuck on a leaked lock.

I saw quite a few reports where lookup/readdir are also stuck trying
to get an inode lock - those at the "thread B"s in the above example
- but there's no indication left of what happened with thread A.

If thread A was blocked iall that time on something, then the hung
task timer should fire on it, too.  If it is running in a tight
loop, the NMI would have dumped a stack trace from it.

But neither of those things happened, so it's either leaked
something or it's in a loop with a short term sleep so doesn't
trigger the hung task timer. sysrq-w output will capture that
without all the noise of sysrq-t....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
