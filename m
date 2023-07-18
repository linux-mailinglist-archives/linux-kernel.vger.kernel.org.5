Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD9275811F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjGRPjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjGRPjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:39:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7C2A9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:39:36 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso9603393e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689694775; x=1692286775;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=41fN1SUpZBPylSQmYP/4Kzm/8d1Yk9UuE//JCuZhWoY=;
        b=Y1yAdjD1sO5pGSWKkKoRJVMq2xcvpwSTVAqeaTtBZsKZtFJZZL6FVvqKCIBFKE3rv7
         v4yaFMj4RGVTCHBqCR16Ayb27hJ4lTdlTCpc4sZ5IlnxyyuyWXZeh//xnDYmyU6jJ9Se
         P84BRJ6QoCv5Vw8SdFTBMx2UyIhbcQqYXoWAHjW0SllnzSBxDGdjXYoX5qC+jpvwYmG5
         rl9MkONUoCH9TjHdSGuehxCRiZZ7zRZcJipb6F8JUEvP5+yN8RRvHCD7gB4UCrONMqeZ
         WpurWwCsNMWCtLDHggPXOnE3ROiNOE82Y3SGxFZkbUpPum5aM5ZnFthQOMiBM1S0GjB5
         RG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689694775; x=1692286775;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41fN1SUpZBPylSQmYP/4Kzm/8d1Yk9UuE//JCuZhWoY=;
        b=ifZbdqaxsXDseJFvbPl1viyNz++EwMcvPPAAvhY2ikc0xaz7d3SziTv6fPii9Oyxr1
         eg4vRFuedqC/dmy1QiITlXDF6KfpMIxdakvslsSyMfmaLZYKP+nKk99Kxa80uF2Dz9iF
         DB1pudobvBjq5ipMEe1A3O18eV+uS9tRhGRh9lLPmZE1+ILqjJ/s5FBJ9OOS4ijJTgqo
         wQlxgC8gXhhTPugdc3I6w8bdCDxNemG3Iph+fHSFhymHI0yCwvAhsOQT20GB04T4+86d
         YrqO2WH2MkT3y7J4l0mlVQ27hXURcYQs8UHi5lGdDnLT2fWI/4vwXx2nKuCn/CgiA/eU
         jtaA==
X-Gm-Message-State: ABy/qLakKjM0/SLI0XT7ZSUsAXcOMizvJkg2JVXdV5dChZCRDlrD9cdu
        8NbUPfAHd/6vRxVDSZVpX9Al7jhRq7mUcA==
X-Google-Smtp-Source: APBJJlGnCP1dluIWVjmPOUxagelID4Z+mHdb7T0zLXNwWZ8AsCplVJGLgO8gWs28qdgPH+ElYgJbgA==
X-Received: by 2002:a05:6512:3f8:b0:4f8:752f:371f with SMTP id n24-20020a05651203f800b004f8752f371fmr8896228lfq.51.1689694774458;
        Tue, 18 Jul 2023 08:39:34 -0700 (PDT)
Received: from akanner-r14. ([77.222.24.34])
        by smtp.gmail.com with ESMTPSA id g3-20020a19ac03000000b004fdb38e3accsm488660lfc.119.2023.07.18.08.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 08:39:33 -0700 (PDT)
Message-ID: <64b6b235.190a0220.28c3a.1ee8@mx.google.com>
X-Google-Original-Message-ID: <ZLayMklBvr6B/F/K@akanner-r14.>
Date:   Tue, 18 Jul 2023 17:39:30 +0200
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     shaggy@kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 1/1] fs/jfs: prevent double-free in dbUnmount() after
 failed jfs_remount()
References: <20221201124628.603505-1-liushixin2@huawei.com>
 <20230701140542.2252-1-andrew.kanner@gmail.com>
 <20230701140542.2252-2-andrew.kanner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230701140542.2252-2-andrew.kanner@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2023 at 05:05:42PM +0300, Andrew Kanner wrote:
> Syzkaller reported the following issue:
> ==================================================================
> BUG: KASAN: double-free in slab_free mm/slub.c:3787 [inline]
> BUG: KASAN: double-free in __kmem_cache_free+0x71/0x110 mm/slub.c:3800
> Free of addr ffff888086408000 by task syz-executor.4/12750
> [...]
> Call Trace:
>  <TASK>
> [...]
>  kasan_report_invalid_free+0xac/0xd0 mm/kasan/report.c:482
>  ____kasan_slab_free+0xfb/0x120
>  kasan_slab_free include/linux/kasan.h:177 [inline]
>  slab_free_hook mm/slub.c:1781 [inline]
>  slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1807
>  slab_free mm/slub.c:3787 [inline]
>  __kmem_cache_free+0x71/0x110 mm/slub.c:3800
>  dbUnmount+0xf4/0x110 fs/jfs/jfs_dmap.c:264
>  jfs_umount+0x248/0x3b0 fs/jfs/jfs_umount.c:87
>  jfs_put_super+0x86/0x190 fs/jfs/super.c:194
>  generic_shutdown_super+0x130/0x310 fs/super.c:492
>  kill_block_super+0x79/0xd0 fs/super.c:1386
>  deactivate_locked_super+0xa7/0xf0 fs/super.c:332
>  cleanup_mnt+0x494/0x520 fs/namespace.c:1291
>  task_work_run+0x243/0x300 kernel/task_work.c:179
>  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>  exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:171
>  exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:203
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
>  syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:296
>  do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [...]
>  </TASK>
> 
> Allocated by task 13352:
>  kasan_save_stack mm/kasan/common.c:45 [inline]
>  kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
>  ____kasan_kmalloc mm/kasan/common.c:371 [inline]
>  __kasan_kmalloc+0x97/0xb0 mm/kasan/common.c:380
>  kmalloc include/linux/slab.h:580 [inline]
>  dbMount+0x54/0x980 fs/jfs/jfs_dmap.c:164
>  jfs_mount+0x1dd/0x830 fs/jfs/jfs_mount.c:121
>  jfs_fill_super+0x590/0xc50 fs/jfs/super.c:556
>  mount_bdev+0x26c/0x3a0 fs/super.c:1359
>  legacy_get_tree+0xea/0x180 fs/fs_context.c:610
>  vfs_get_tree+0x88/0x270 fs/super.c:1489
>  do_new_mount+0x289/0xad0 fs/namespace.c:3145
>  do_mount fs/namespace.c:3488 [inline]
>  __do_sys_mount fs/namespace.c:3697 [inline]
>  __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Freed by task 13352:
>  kasan_save_stack mm/kasan/common.c:45 [inline]
>  kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
>  kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:518
>  ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
>  kasan_slab_free include/linux/kasan.h:177 [inline]
>  slab_free_hook mm/slub.c:1781 [inline]
>  slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1807
>  slab_free mm/slub.c:3787 [inline]
>  __kmem_cache_free+0x71/0x110 mm/slub.c:3800
>  dbUnmount+0xf4/0x110 fs/jfs/jfs_dmap.c:264
>  jfs_mount_rw+0x545/0x740 fs/jfs/jfs_mount.c:247
>  jfs_remount+0x3db/0x710 fs/jfs/super.c:454
>  reconfigure_super+0x3bc/0x7b0 fs/super.c:935
>  vfs_fsconfig_locked fs/fsopen.c:254 [inline]
>  __do_sys_fsconfig fs/fsopen.c:439 [inline]
>  __se_sys_fsconfig+0xad5/0x1060 fs/fsopen.c:314
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [...]
> 
> JFS_SBI(ipbmap->i_sb)->bmap wasn't set to NULL after kfree() in
> dbUnmount().
> 
> Syzkaller uses faultinject to reproduce this KASAN double-free
> warning. The issue is triggered if either diMount() or dbMount() fail
> in jfs_remount(), since diUnmount() or dbUnmount() already happened in
> such a case - they will do double-free on next execution: jfs_umount
> or jfs_remount.
> 
> Tested on both upstream and jfs-next by syzkaller.
> 
> Reported-and-tested-by: syzbot+6a93efb725385bc4b2e9@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000471f2d05f1ce8bad@google.com/T/
> Link: https://syzkaller.appspot.com/bug?extid=6a93efb725385bc4b2e9
> Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
> ---
>  fs/jfs/jfs_dmap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index a14a0f18a4c4..88afd108c2dd 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -269,6 +269,7 @@ int dbUnmount(struct inode *ipbmap, int mounterror)
>  
>  	/* free the memory for the in-memory bmap. */
>  	kfree(bmp);
> +	JFS_SBI(ipbmap->i_sb)->bmap = NULL;
>  
>  	return (0);
>  }
> -- 
> 2.39.3
> 

Hi, Dave.
Are there any objections?
Or maybe suggestions on how to test both my patch and the patch from
Liu Shixin (some corner cases)?
