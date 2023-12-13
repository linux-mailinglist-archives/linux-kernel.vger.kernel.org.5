Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC218069B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376876AbjLFIfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjLFIfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:35:34 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BF3112
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:35:39 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b9b5bff21dso1851883b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 00:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701851738; x=1702456538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ohn3sCDUMPNiTAAQitTv55v9D4ick0LqAf/d7PE1Bk4=;
        b=FFV1XSoVnpqJCt9ryHeXchyY2T01QK974w6QexuP08DH8roujTIzBMLLo06a+FLLHQ
         5/ELkVm+Tr0NcWBdcyKjIk/k6IXEeH4IFO1lpDVZpStXXyAeH77To9o6fWgnX76wLkAn
         ahbxzYJKG4D9lud96/Isq1RjZFiEmTnZ0vLe8c9SyFoe5YIGRhEf+yZp0Whh/HjP0UEQ
         4epDS564h2+7Lnx09aXL1DN+LzlM5tgds35ggP+8ak3sorMK8umtBaEUV1X7Z03+akqS
         vCahy1Qhl+e4PdiZYVkX3JFHPzEVs5RpDVJ7Zn/KYilw5hucPAZdW0/15b7/1GaxBcqA
         OtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701851738; x=1702456538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohn3sCDUMPNiTAAQitTv55v9D4ick0LqAf/d7PE1Bk4=;
        b=eck1uH2yBNGVyF8DN6agEJnu+T869CtrWotQ6m82I3wbiGfD3vEcNt9qx4TuAfZ9SR
         rjxSWANXBqRHE4UFbyGLxtoBok2Ebg5HYttucRTa93al/KE9nWJgBb4m+JGX1JwGFkmv
         3u8BdrDkXmKZQQeHqMQiRs+K7J/CW3uroLSA6tDTyWnZmK28A4DZqI4RtZX0Woycwc2t
         tNUfcW8wCCj6vmgi904S0yGCB8CG7wgA6nqiR89nKIJGnJKpI5zbUl9pVjcyjJAPIw7G
         DA/QJedoeKJR0qAYA5QqlSP+jdvlXAlqy43+X7f95ELPMcopApbqVNvTqJDAYQ7O/edN
         O9IA==
X-Gm-Message-State: AOJu0YwIGFkAHzLaszObh0D2ofFejA6u5XORy4EoWX9KDbDVA/YE+9YR
        dxl9QUrom9IVB+Jzvka6cawYAw==
X-Google-Smtp-Source: AGHT+IEaFcVZuuTo+wyGZz9Uf3a8wTv/flKy/+FEv8W9jNsNAuHMOUQ6YrdQV1jr+Xef1OH6rLlfbg==
X-Received: by 2002:a05:6808:1994:b0:3b9:d20b:ea52 with SMTP id bj20-20020a056808199400b003b9d20bea52mr72608oib.82.1701851738462;
        Wed, 06 Dec 2023 00:35:38 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id e12-20020aa7980c000000b006ce50876c37sm2359500pfl.100.2023.12.06.00.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 00:35:37 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1rAnNX-004YHN-1z;
        Wed, 06 Dec 2023 19:35:35 +1100
Date:   Wed, 6 Dec 2023 19:35:35 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, willy@infradead.org,
        akpm@linux-foundation.org, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH -RFC 0/2] mm/ext4: avoid data corruption when extending
 DIO write race with buffered read
Message-ID: <ZXAyV/rlfvBBuDL1@dread.disaster.area>
References: <20231202091432.8349-1-libaokun1@huawei.com>
 <20231204121120.mpxntey47rluhcfi@quack3>
 <b524ccf7-e5a0-4a55-db6e-b67989055a05@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b524ccf7-e5a0-4a55-db6e-b67989055a05@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 09:50:18PM +0800, Baokun Li wrote:
> On 2023/12/4 20:11, Jan Kara wrote:
> > Hello!
> Thank you for your reply!
> > 
> > On Sat 02-12-23 17:14:30, Baokun Li wrote:
> > > Recently, while running some pressure tests on MYSQL, noticed that
> > > occasionally a "corrupted data in log event" error would be reported.
> > > After analyzing the error, I found that extending DIO write and buffered
> > > read were competing, resulting in some zero-filled page end being read.
> > > Since ext4 buffered read doesn't hold an inode lock, and there is no
> > > field in the page to indicate the valid data size, it seems to me that
> > > it is impossible to solve this problem perfectly without changing these
> > > two things.
> > Yes, combining buffered reads with direct IO writes is a recipe for
> > problems and pretty much in the "don't do it" territory. So honestly I'd
> > consider this a MYSQL bug. Were you able to identify why does MYSQL use
> > buffered read in this case? It is just something specific to the test
> > you're doing?
> The problem is with a one-master-twoslave MYSQL database with three
> physical machines, and using sysbench pressure testing on each of the
> three machines, the problem occurs about once every two to three hours.
> 
> The problem is with the relay log file, and when the problem occurs, the
> middle dozens of bytes of the file are read as all zeros, while the data on
> disk is not. This is a journal-like file where a write process gets the data
> from
> the master node and writes it locally, and another replay process reads the
> file and performs the replay operation accordingly (some SQL statements).
> The problem is that when replaying, it finds that the data read is
> corrupted,
> not valid SQL data, while the data on disk is normal.
> 
> It's not confirmed that buffered reads vs direct IO writes is actually
> causing
> this issue, but this is the only scenario that we can reproduce with our
> local
> simplified scripts. Also, after merging in patch 1, the MYSQL pressure test
> scenario has now been tested for 5 days and has not been reproduced.

Mixing overlapping buffered read with direct writes - especially partial block
extending DIO writes - is a recipe for data corruption. It's not a
matter of if, it's a matter of when.

Fundamentally, when you have overlapping write IO involving DIO, the
result of the overlapping IOs is undefined. One cannot control
submission order, the order that the overlapping IO hit the
media, or completion ordering that might clear flags like unwritten
extents. The only guarantee that we give in this case is that we
won't expose stale data from the disk to the user read.

As such, it is the responsibility of the application to avoid
overlapping IOs when doing direct IO. The fact that you['ve observed
data corruption due to overlapping IO ranges from the one
application indicates that this is, indeed, an application level
problem and can only be solved by fixing the application....

> I'll double-check the problem scenario, although buffered reads with
> buffered
> writes doesn't seem to have this problem.
> > > In this series, the first patch reads the inode size twice, and takes the
> > > smaller of the two values as the copyout limit to avoid copying data that
> > > was not actually read (0-padding) into the user buffer and causing data
> > > corruption. This greatly reduces the probability of problems under 4k
> > > page. However, the problem is still easily triggered under 64k page.
> > > 
> > > The second patch waits for the existing dio write to complete and
> > > invalidate the stale page cache before performing a new buffered read
> > > in ext4, avoiding data corruption by copying the stale page cache to
> > > the user buffer. This makes it much less likely that the problem will
> > > be triggered in a 64k page.
> > > 
> > > Do we have a plan to add a lock to the ext4 buffered read or a field in
> > > the page that indicates the size of the valid data in the page? Or does
> > > anyone have a better idea?
> > No, there are no plans to address this AFAIK. Because such locking will
> > slow down all the well behaved applications to fix a corner case for
> > application doing unsupported things. Sure we must not crash the kernel,
> > corrupt the filesystem or leak sensitive (e.g. uninitialized) data if app
> > combines buffered and direct IO but returning zeros instead of valid data
> > is in my opinion fully within the range of acceptable behavior for such
> > case.
> > 
> > 								Honza
> I also feel that a scenario like buffered reads + DIO writes is strange. But
> theoretically when read doesn't return an error, the data read shouldn't be
> wrong.

The data that was read isn't wrong - it just wasn't what the
application expected.

> And I tested that xfs guarantees data consistency in this scenario, which is
> why I
> thought it might be buggy.

XFS certainly does not guarantee data consistency between buffered
reads and DIO writes, especially for overlapping IO ranges using DIO
(see above).

IOWs, the fact that the data inconsistency doesn't reproduce on XFS
doesn't mean that XFS is providing some guarantee of consistency for
this IO pattern. All it means is that ext4 and XFS behave differently
in an situation where the operational result is indeterminate and all
we guarantee is that we won't expose stale data read from disk....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
