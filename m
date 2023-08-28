Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F75D78A526
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 07:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjH1FVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 01:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjH1FVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 01:21:43 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5125812F
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 22:21:34 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a88ef9444bso2112640b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 22:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1693200093; x=1693804893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Bysmz5K1f1isGlAjF9wNbQh3sg8KLv+xyLr+yDVw5A=;
        b=UNugA+Y1zQXmTigo0+DmIl1K6R9FrsznKHBqRiTqgGH3njhbFQFlh/2dHR1Vh2RR1N
         zCcBbAFdkxV9HlvtN+Jt/uMzLNQInm3mk6Lsz8V+IYXHnhSF+VTyz/dm2ANtFdJjmjDk
         mHZOEw2B0TX/pXnvRFzVJuuC3J6m9Ai0GQxYe36YqW6FgM7EjZLaJN3HSVBGzp4D2515
         ZcnPiK95fY6rF0tGLbArD/KopV68oNOs2Uh1xkgGCDznwqmjCUFXNo1Zzs3udCCy0fTg
         VfJna6iAlO9b6UK1tm7jDJlNf7tacDhdSbG5lLHbjCPbAjbOKqJkPyDdDQhCEvCgIJts
         Kr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693200093; x=1693804893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Bysmz5K1f1isGlAjF9wNbQh3sg8KLv+xyLr+yDVw5A=;
        b=XgHR4hWMVB0a6hcR90cyGHGQTLT8y69f/JteqpszlQ46Jyx18P24G7E8U2441duIV9
         DnQESpNBfXwQQch0HVBdCXzB+pWoTXqh8VQR9IbALp32B8Uk/voLQ+pXO5iH8Dzt4/qp
         u7X13RRzXH7cerU3tj6ICfVYqsoe0BZW7n1S17QFsnFiYrCB+YYd/l3m9dpKpnsgz6eL
         j75B8MJpgnGI2Q1mxXpQ2RDQWAlWxa8GQT0NUw5nBycEm5DH6FTDOswBXoAXMjT7Y5vr
         Tn67Afp5fquqZ20TBjsUNRHkgSzql4lFsu6SVVz854hnDbl1hQ8EBgiHyzVlVad+DTBr
         QzjA==
X-Gm-Message-State: AOJu0YytMmNnEaG5mEYHSBXkDHd648qPs7FzuRfvR+xWznEcC7h7G3iX
        vJhPI9ugdIO3qrbUFIDBgrqNQSjv6r8dRUQbyN4=
X-Google-Smtp-Source: AGHT+IGwpAUQr1jIDHi5aDfXApmrP3HeTYJtTok/gyj9aVahuEhRcG7esD62DoNNU8iVCULiVaKHRw==
X-Received: by 2002:a05:6808:bcb:b0:3a7:3100:f8b9 with SMTP id o11-20020a0568080bcb00b003a73100f8b9mr11597574oik.31.1693200093613;
        Sun, 27 Aug 2023 22:21:33 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id a14-20020a62bd0e000000b006875df4773fsm5663182pff.163.2023.08.27.22.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 22:21:33 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qaUgs-007VOW-1U;
        Mon, 28 Aug 2023 15:21:30 +1000
Date:   Mon, 28 Aug 2023 15:21:30 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     cheng.lin130@zte.com.cn
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiang.yong5@zte.com.cn,
        wang.liang82@zte.com.cn, liu.dong3@zte.com.cn
Subject: Re: [PATCH] xfs: introduce protection for drop nlink
Message-ID: <ZOwu2vrzX/0dX89/@dread.disaster.area>
References: <ZOpuadBnaY5QxpVN@dread.disaster.area>
 <202308281129517963677@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308281129517963677@zte.com.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 11:29:51AM +0800, cheng.lin130@zte.com.cn wrote:
> > On Sat, Aug 26, 2023 at 10:54:11PM +0800, cheng.lin130@zte.com.cn wrote:
> > > > > In the old kernel version, this situation was
> > > > > encountered, but I don't know how it happened. It was already a scene
> > > > > with directory errors: "Too many links".
> > How do you overflow the directory link count in XFS? You can't fit
> > 2^31 unique names in the directory data segment - the directory will
> > ENOSPC at 32GB of name data, and that typically occurs with at most
> > 300-500 million dirents (depending on name lengths) in the
> > directory.
> > IOWs, normal operation shouldn't be able overflow the directory link
> > count at all, and so underruns shouldn't occur, either.
> Customer's explanation: in the nlink incorrect directory, not many directories
> will be created, and normally there are only 2 regular files.
> And only found this one directory with incorrect nlink when xfs_repair.
>   systemd-fsck[5635]: Phase 2 - using internal log
>   systemd-fsck[5635]: - zero log...
>   systemd-fsck[5635]: - scan filesystem freespace and inode maps...
>   systemd-fsck[5635]: agi unlinked bucket 9 is 73 in ag 22 (inode=23622320201)

So the directory inode is on the unlinked list, as I suggested it
would be.

>   systemd-fsck[5635]: - 21:46:00: scanning filesystem freespace - 32 of 32 allocation groups done
>   systemd-fsck[5635]: - found root inode chunk
>   ...

How many other inodes were repaired or trashed or moved to
lost+found?

>   systemd-fsck[5635]: Phase 7 - verify and correct link counts...
>   systemd-fsck[5635]: resetting inode 23622320201 nlinks from 4294967284 to 2

The link count of the directory inode on the unlinked list was
actually -12, so this isn't an "off by one" error. It's still just 2
adjacent bits being cleared when they shouldn't have been, though.

What is the xfs_info (or mkfs) output for the filesystem that this
occurred on?

.....

> If it's just a incorrect count of one dicrectory, after ignore it, the fs
> can work normally(with error). Is it worth stopping the entire fs
> immediately for this condition?

The inode is on the unlinked list with a non-zero link count. That
means it cannot be removed from the unlinked list (because the inode
will not be freed during inactivation) and so the unlinked list is
effectively corrupt. Anything that removes an inode or creates a
O_TMPFILE or uses RENAME_WHITEOUT can trip over this corrupt
unlinked list and have things go from bad to worse. Hence the
corruption is not limited to the directory inode or operations
involving that directory inode. We generally shut down the
filesystem when this sort of corruption occurs - it needs to be
repaired ASAP, otherwise other stuff will randomly fail and you'll
still end up with a shut down filesystem. Better to fail fast in
corruption cases than try to ignore it and vainly hope that
everything will work out for the best....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
