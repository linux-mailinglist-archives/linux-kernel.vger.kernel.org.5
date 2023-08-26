Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3010078993E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 23:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjHZV2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 17:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHZV2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 17:28:16 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18085122
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 14:28:14 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso994087a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 14:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1693085293; x=1693690093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E7fKlToAmGMPrQ+YXtBD2/xruFbsxngZOkBN771TIgI=;
        b=ro+Zd8Nr1pakwCuQn+exFwgvjN29z3NRFIn4uBTbNjcXq9pHC169W2SQOtBjipclZ3
         P25pWkAB0WGXlPTPw3301Ij6OwVZyVLdSHdlnyPrJY3FayTgW+CuOvc7enZb+VJoh41/
         JqTEDqrKn+GfA+U8919qBb6mHgVURd1XN5a6y0ODdgiAYMYYLreY9UFEZNnfr45/flWc
         x+Vu6Pj5829ZEzSP6s3gw64T6dzuIY52qkupGEqqZaFiF2Wq6Wg0u3APXtPggaNTNfxO
         xDXPhSfP3zYYNi5XywFoTjrmFaFDYrzb93ajn7Y+jsxn577MUaaiqtIPrHuPx+4s8aDL
         +FPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693085293; x=1693690093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7fKlToAmGMPrQ+YXtBD2/xruFbsxngZOkBN771TIgI=;
        b=hwP9co+VX7BbDRkQQRavTuTNX/pwWshBahvyTJiQFLa1tzdZ4FtyfoHmxoXUC6cyTx
         rQl3jUGvw1xAppgn5bPRrRkyeVxTSUHfte427XDhw2ghbQ6aezzO/99/hJ/tin3iu79J
         jOex2aB7X+NN6ZODgS6JEkvYhR7ctckilD9V6SYl2pK5zDyPkbXl6XUAhagg9zPm7rGh
         ENZ3qeqJipG+CsCXN9knexHOKi9x8mjx2QLmvgl6SAFoVKVIadECtK/NLDjwUSv2BJg1
         rjhKfroq7orpYFlQr9w27LO+82+jn8UNhY6B6MS88GqWOo42ZqVfQ9AV8RK/wbxOtzWF
         FiKg==
X-Gm-Message-State: AOJu0YxuPfyA0t6m1U3/gPE5p99zZgmQQXKUsSwR9+X1dA2VvZik5Gzj
        TodkgV+McIMu9/ZSavu2GXx6KQ==
X-Google-Smtp-Source: AGHT+IHomWb20CnxHpuSXgULX6QTzNHBikCRNRZEOkmgF48L6PV2r3zPRwRkZcCP62Y5eUQMYsKuyg==
X-Received: by 2002:a05:6a00:2395:b0:68a:5cf8:dad5 with SMTP id f21-20020a056a00239500b0068a5cf8dad5mr15812814pfc.2.1693085293471;
        Sat, 26 Aug 2023 14:28:13 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id u15-20020a62ed0f000000b006887be16675sm3687127pfh.205.2023.08.26.14.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 14:28:12 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qa0pF-006vmt-1V;
        Sun, 27 Aug 2023 07:28:09 +1000
Date:   Sun, 27 Aug 2023 07:28:09 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     cheng.lin130@zte.com.cn
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiang.yong5@zte.com.cn,
        wang.liang82@zte.com.cn, liu.dong3@zte.com.cn
Subject: Re: [PATCH] xfs: introduce protection for drop nlink
Message-ID: <ZOpuadBnaY5QxpVN@dread.disaster.area>
References: <20230825180201.GL17912@frogsfrogsfrogs>
 <202308262254116460369@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308262254116460369@zte.com.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 10:54:11PM +0800, cheng.lin130@zte.com.cn wrote:
> > On Fri, Aug 25, 2023 at 04:32:22PM +0800, cheng.lin130@zte.com.cn wrote:
> > > > On Thu, Aug 24, 2023 at 03:43:52PM +0800, cheng.lin130@zte.com.cn wrote:
> > > >> From: Cheng Lin <cheng.lin130@zte.com.cn>
> > > >> An dir nlinks overflow which down form 0 to 0xffffffff, cause the
> > > >> directory to become unusable until the next xfs_repair run.
> > > >>
> > > >> Introduce protection for drop nlink to reduce the impact of this.
> > > >> And produce a warning for directory nlink error during remove.
> > > >>
> > > >> Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> > > >> ---
> > > >>  fs/xfs/xfs_inode.c | 16 +++++++++++++++-
> > > >>  1 file changed, 15 insertions(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > > >> index 9e62cc5..536dbe4 100644
> > > >> --- a/fs/xfs/xfs_inode.c
> > > >> +++ b/fs/xfs/xfs_inode.c
> > > >> @@ -919,6 +919,15 @@ STATIC int xfs_iunlink_remove(struct xfs_trans *tp, struct xfs_perag *pag,
> > > >>      xfs_trans_t *tp,
> > > >>      xfs_inode_t *ip)
> > > >>  {
> > > >> +    xfs_mount_t     *mp;
> > > >> +
> > > >> +    if (VFS_I(ip)->i_nlink == 0) {
> > > >> +        mp = ip->i_mount;
> > > >> +        xfs_warn(mp, "%s: Deleting inode %llu with no links.",
> > > >> +             __func__, ip->i_ino);
> > > >> +        return 0;
> > > >> +    }
> > > >> +
> > > >>      xfs_trans_ichgtime(tp, ip, XFS_ICHGTIME_CHG);
> > > >>
> > > >>      drop_nlink(VFS_I(ip));
> > > > I'm not sure how nlink would ever get to 0xFFFFFFFF since the VFS won't
> > > > let a link count exceed s_max_links, and XFS sets that to 0x7FFFFFFF.
> > > > Unless, of course, you did that outside of Linux.
> > > In VFS drop_nlink() only produce a warning, when (inode->i_nlink == 0),
> > > not prevent its self-reduce(inode->__i_nlink--), cause it underflow
> > > from 0 to 0xffffffff.
> > It is interesting that vfs_unlink doesn't check the link counts of
> > either the parent or the child.  Maybe it should, since the VFS
> > link/mkdir/rename functions check.
> > I wonder if this is a historical leftover from the days when the VFS
> > did no checking at all?
> VFS produce a warning means it has discovered an abnormal situation.
> I don't know why it just produce a warning. But, in other fs like
> fuse/nfs/overlayfs/ext4, there is further protection for this situation.

Well, the question is how the link count got corrupted in the first
place....

> > > In the old kernel version, this situation was
> > > encountered, but I don't know how it happened. It was already a scene
> > > with directory errors: "Too many links".

How do you overflow the directory link count in XFS? You can't fit
2^31 unique names in the directory data segment - the directory will
ENOSPC at 32GB of name data, and that typically occurs with at most
300-500 million dirents (depending on name lengths) in the
directory.

IOWs, normal operation shouldn't be able overflow the directory link
count at all, and so underruns shouldn't occur, either.

> > >  kernel: WARNING: CPU: 12 PID: 12928 at fs/inode.c:286 drop_nlink+0x3e/0x50
> > >  kernel: CPU: 12 PID: 12928 Comm: gbased Tainted: G        W  OE  ------------ T 3.10.0-693.21.1.el7.x86_64 #1

So this is a RHEL 7 kernel, and it is tainted with unknown out of
tree (3rd party) kernel modules. Hence if could be memory corruption
from whatever drivers are loaded.  It's also old enough that it is
posible this is a v4 filesystem, and if so, it could be that storage
media corruption occurred and it wasn't detected.

> > >  kernel: Hardware name: HPE ProLiant BL460c Gen10/ProLiant BL460c Gen10, BIOS I41 01/23/2021
> > >  kernel: Call Trace:-------------------
> > >  kernel: [<ffffffff816c5fce>] dump_stack+0x19/0x1b
> > >  kernel: [<ffffffff8108dfa8>] __warn+0xd8/0x100/*
> > >  kernel: [<ffffffff8108e0ed>] warn_slowpath_null+0x1d/0x20
> > >  kernel: [<ffffffff8122cdfe>] drop_nlink+0x3e/0x50
> > >  kernel: [<ffffffffc03cdc78>] xfs_droplink+0x28/0x60 [xfs]
> > >  kernel: [<ffffffffc03cf87a>] xfs_remove+0x2aa/0x320 [xfs]
> > >  kernel: [<ffffffffc03c9f7a>] xfs_vn_unlink+0x5a/0xa0 [xfs]
> > >  kernel: [<ffffffff8121f19c>] vfs_rmdir+0xdc/0x150
> > >  kernel: [<ffffffff81221e41>] do_rmdir+0x1f1/0x220
> > >  kernel: [<ffffffff81223046>] SyS_rmdir+0x16/0x20
> > >  kernel: [<ffffffff816d86d5>] system_call_fastpath+0x1c/0x21

Without actually knowing the root cause, and directory link count
overflows not being possible in normal operation, I'm not sure that
we should be jumping to conclusions that the directory link count
code in the upstream kernel is actually broken and needs fixing.

> > > > That said, why wouldn't you /pin/ the link count at -1U instead of
> > > > allowing it to overflow to zero?
> > > > Could you please take a look at this patch that's waiting in my
> > > > submission queue?
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=inode-repair-improvements&id=05f5a82efa6395c92038e18e008aaf7154238f27

This is protecting against regular files with too many hardlinks;
a directory will never have the link count set to XFS_NLINK_PINNED
because it just can't have that many entries in it....

> > > I think the XFS_NLINK_PINNEED(~0U) can be used prevent Overflow in inc_nlink().
> > > Is it better to compare i_nlink with (0U) in drop_nlink() to prevent Underflow?
> > > (like this patch does, do not make i_nlink underflow from 0 to 0xffffffff)
> > Is it a problem if a directory i_nlink underflows to XFS_NLINK_PINNED?
> > At that point the directory will never be freed, and xfs_repair/scrub
> > get to figure out the correct link count.

I think that's wrong. The directory inode gets unlinked when the
link count goes to zero, before the underflow occurs and can be
detected. i.e. The warning occurs when the link could goes from 0 to
-1 and this is after it has been unlinked on the transition between
1 to 0. If there are more entries removed from the directory at this
point, the NLINK_PINNED detection then kicks in and we don't drop
the nlink of the directory any further.

But at this point, the damage has already been done - the directory
is on the unlinked list at this point, and now it has a non-zero
nlink count which means the VFS will not drop the inode and it
remains cached. i.e. we have a corrupt runtime state where an inode
is on the unlinked list yet isn't scheduled for inactivation/freeing
when the last reference to it goes away. Indeed, inactivation won't
trigger unlinked list removal, either, because the link count is not
zero.

I suspect at this point we have multiple on-disk corruptions in the
filesystem. The parent directory points to an inode on the unlinked
list, and if we crash at this point we have an inode on the unlinked
that will be skipped by the recovery code because i_nlink is not
zero (same iput_final/drop_inode problem). This ends up with a
corrupt in-memory unlinked list on the next mount (i.e. inode on the
list that isn't in memory...), and nothing good happens from that...

> > --D
> Yes, with i_nlink underflows to XFS_NLINK_PINNED, the directory will become
> unavailable until be repaired. But the running service on this directory will be
> failed. If i_nlink is protected from underflow, the use of the directory can continue,
> and the continuity of services is guaranteed. The incorrect count also will be fixed
> at next repair.

I think that given what an underflow represents - some kind of
corruption - and the fact that it can propagate in nasty ways if we
allow operation to continue, we should be shutting down the
filesystem if we detect an underflow on a directory inode. This will
force repair of the filesystem as soon as possible.

IOWs, we're already in bad situation when this warning is issued for
directories, and so not dropping the nlink count after it has
already underflowed doesn't matter one bit - we should be shutting
down the filesystem, not trying to continue onwards as it nothing
happened...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
