Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9B37909D2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 23:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbjIBVuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 17:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjIBVuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 17:50:00 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B746CD8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 14:49:56 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5280ef23593so219270a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 14:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693691395; x=1694296195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRxhPwM1RTEepKJN1y2kUNyMdxsivc+T8nuNg39eGbY=;
        b=ECdnBDaHGLDQc+F6ld4iwcq7aaSv9EzhONH/xmYb+evm+KPAwAIfC4A/FwjcvvogSk
         Sln4lTAcSwzhN6/93r5o1ItVoewe/gsSObQGPtG8+j3lN7GW9fDE/It2Z0EbRj6Pr55n
         C9tz+HYSeLDbWA9fsxdGvOe+ZPxhnfR/W5jJ6NiuoBFeLBKPNDY8auBqzyvyJKEt1KVU
         xGZ7rANgWKmAu5iXdmNGvLcHRMQXoASnj4xowzFCb8D9uSrYHYJYTbjRM8rIhg/gUWeI
         M+dviGcPGmZmO+YBnsOWm7vuV43PNEn1PW0gjMgzJCcYrl75i41toCDUDplIfOHQdfaH
         huuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693691395; x=1694296195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRxhPwM1RTEepKJN1y2kUNyMdxsivc+T8nuNg39eGbY=;
        b=QhbTDBDERh8D4ZdDIf1kU8j7v+RXGlApGXQ1yhm9dlB3tA9Ge1yVusVOWi3oBucvfb
         +DSmZIs2OTgL7DqF6Z2YzL8AxVUUByhbCOSlEsZ43yBlN3QtbnzIAReXzvZLPC1JbaHy
         Uhekjh7fxVRswinttJ0OEu2XwD07PcahhmQzM/d64CMB4zgQPdCc3OQ2ii4VD5Z5U9fs
         h8MsXEH0iEPkqvmHk/cdT2e4vGoUggGqIOwVmtbJsHYnB/ngN0pLHGisa2C4DYPhkgPX
         sxlswNJIl1HGuA7SNuhY97dKYbyob+jeu3GNxT93SJZozyL3F/zxzNonylSWeKFw9Tv9
         pRtg==
X-Gm-Message-State: AOJu0Yxwzy2n9H+B0yfDIJ+I1CesvkD4xRgXQ80C2iibYxvSo80v+TJn
        CV//FUUF9fYAURbob3ptySw=
X-Google-Smtp-Source: AGHT+IEV+Ipcg6yPzz8wE0OvRfefUCohU6yaBhTCJbWOaB8C/JBtL4TSDswep3aKYZUr+oPwiFeZlg==
X-Received: by 2002:aa7:c48f:0:b0:523:471e:681a with SMTP id m15-20020aa7c48f000000b00523471e681amr4021581edq.41.1693691394786;
        Sat, 02 Sep 2023 14:49:54 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id n10-20020aa7c44a000000b0052a3edff5c3sm3797371edr.87.2023.09.02.14.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 14:49:54 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6AC1127C0054;
        Sat,  2 Sep 2023 17:49:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 02 Sep 2023 17:49:52 -0400
X-ME-Sender: <xms:_63zZFFkhP0GscmSCLaXs_IHCtFgSywode-Hz9WoestuVVvw3sAg_w>
    <xme:_63zZKWYIeSpFIGneodvus3NFvB53ISEX6F1CQifiirr5c1HuI6opfYhAn4O9JqRy
    Yi50waL8VbcdP6wMg>
X-ME-Received: <xmr:_63zZHKU7haTbvKo7VIPQCx8DBA3dUIXrQ_rqlxuZzTpbC9_MVGc-5gMtpB14Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeghedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvfevuffkfhggtggu
    jgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfh
    gvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeejvdekgfetffegteff
    ueelfeeivddtueetgefgueekgfehtdettddtjeeghfdvueenucffohhmrghinhepshihii
    hkrghllhgvrhdrrghpphhsphhothdrtghomhdpghhoohhglhgvrghpihhsrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunh
    domhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeej
    keehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnh
    grmhgv
X-ME-Proxy: <xmx:_63zZLEM7xacLFwJJlbFKKASfmmZFzRrajJzflbNR-rUbsTLEheB2g>
    <xmx:_63zZLUxn_bRAIXw6yU1k3UBhdeEECei_wQK_raIoQ2MJDnoeOPH-A>
    <xmx:_63zZGNkM1KYZPlYtENug-ghEZa_n-pViKvZSbK1Yuxc-jhygFEirw>
    <xmx:AK7zZNJ_h-fqGDOSlZsTOLejRk2QgH5r6Bg27bSDT8OVA3G7noY5Ww>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Sep 2023 17:49:51 -0400 (EDT)
Date:   Sat, 2 Sep 2023 14:48:49 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+a379155f07c134ea9879@syzkaller.appspotmail.com>,
        dsterba@suse.com, josef@toxicpanda.com,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] possible deadlock in
 __btrfs_release_delayed_node (3)
Message-ID: <ZPOtwcMHN_fpdrpt@boqun-archlinux>
References: <000000000000abba27060403b5bd@google.com>
 <20230830110716.4426-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830110716.4426-1-hdanton@sina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 07:07:16PM +0800, Hillf Danton wrote:
> On Mon, 28 Aug 2023 16:03:59 -0700
> > syzbot found the following issue on:
> > 
> > HEAD commit:    93f5de5f648d Merge tag 'acpi-6.5-rc8' of git://git.kernel...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17f71340680000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=1b32f62c755c3a9c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a379155f07c134ea9879
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12684fa7a80000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/9f3fa40677fd/disk-93f5de5f.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/1aa00d4d7c58/vmlinux-93f5de5f.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/361b7a3f46b3/bzImage-93f5de5f.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/696d28540778/mount_0.gz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+a379155f07c134ea9879@syzkaller.appspotmail.com
> > 
> > BTRFS info (device loop2): enabling ssd optimizations
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 6.5.0-rc7-syzkaller-00024-g93f5de5f648d #0 Not tainted
> > ------------------------------------------------------
> > syz-executor.2/13257 is trying to acquire lock:
                            ^^^^^^^^^^^^^^^^^

The warning actually happened at acquire time.

> > ffff88801835c0c0 (&delayed_node->mutex){+.+.}-{3:3}, at: __btrfs_release_delayed_node+0x9a/0xaa0 fs/btrfs/delayed-inode.c:256
> > 
> > but task is already holding lock:
> > ffff88802a5ab8e8 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_lock+0x3c/0x2a0 fs/btrfs/locking.c:198
> > 
> > which lock already depends on the new lock.
> > 
> > 
> > the existing dependency chain (in reverse order) is:
> > 
> > -> #1 (btrfs-tree-00){++++}-{3:3}:
> >        __lock_release kernel/locking/lockdep.c:5475 [inline]
> >        lock_release+0x36f/0x9d0 kernel/locking/lockdep.c:5781
> >        up_write+0x79/0x580 kernel/locking/rwsem.c:1625
> 
> Why was warned at release time instead of acquire time?
> 

If you look carefully, this is not the stack when the issue happened,
this is the stack when a previous lock dependency was built, now the
question is why lockdep records the stack trace at release time? To
answer this, please consider the following case:

	spin_lock(&A);
	spin_lock(&B); // <- step #1
	spin_lock(&C); // <- step #2

	spin_unlock(&B); // <-step #3
	spin_unlock(&C); // <-step #4
	spin_unlock(&A);

(note that lock order and unlock order of B and C are not symmetric)

At step #1, the lockdep lock graph will record the dependency:

	A -> B along with the stack trace at step #1

At step #2, the lockdep lock graph will record the dependency:

	B -> C along with the stack trace at step #2

so at step #2, there are *two* dependencies in the graph:

	A -> B
	B -> C

, and dependency A -> C can be inferred by transverse in the graph.
Without saving the dependency explicitly in the graph, we save some
memory on the dependency and the stack trace.

Now at step #3, the interesting part happens: lock_release() is
implemented as 1) removing B and rest of held locks, i.e. C from the
current lock held stack, and 2) *reacquiring* the rest of held locks,
i.e. C. The reacquiring will trigger lockdep to record the dependency:

	A -> C along with the stack track at step #3 (release time!)

And if afterwards, someone does a:

	spin_lock(&C);
	spin_lock(&A);

lockdep will warn at spin_lock(&A); because A -> C is already in the
graph, and the report will show the stack trace associated with
dependency A -> C.

Of course if we reverse step #3 and #4, there will be no A -> C in the
graph, and when the same deadlock possibility happens, lockdep will
report with dependency chain A -> B -> C and stack traces at step #1 and
#2.

If you don't want this behavior (i.e. you want to use more memory by
default to more accurate stack traces), you can use the following patch:

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 111607d91489..b1a18b544d74 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3261,15 +3261,6 @@ check_prevs_add(struct task_struct *curr, struct held_lock *next)
                        int ret = check_prev_add(curr, hlock, next, distance, &trace);
                        if (!ret)
                                return 0;
-
-                       /*
-                        * Stop after the first non-trylock entry,
-                        * as non-trylock entries have added their
-                        * own direct dependencies already, so this
-                        * lock is connected to them indirectly:
-                        */
-                       if (!hlock->trylock)
-                               break;
                }

                depth--;

There definitely are smarter ways than this, your ideas are welcome!

Hope this helps.

Regards,
Boqun

> Hillf
> >        btrfs_tree_unlock_rw fs/btrfs/locking.h:189 [inline]
> >        btrfs_unlock_up_safe+0x179/0x3b0 fs/btrfs/locking.c:239
> >        search_leaf fs/btrfs/ctree.c:1986 [inline]
> >        btrfs_search_slot+0x2511/0x2f80 fs/btrfs/ctree.c:2230
> >        btrfs_insert_empty_items+0x9c/0x180 fs/btrfs/ctree.c:4376
> >        btrfs_insert_delayed_item fs/btrfs/delayed-inode.c:746 [inline]
> >        btrfs_insert_delayed_items fs/btrfs/delayed-inode.c:824 [inline]
> >        __btrfs_commit_inode_delayed_items+0xd24/0x2410 fs/btrfs/delayed-inode.c:1111
> >        __btrfs_run_delayed_items+0x1db/0x430 fs/btrfs/delayed-inode.c:1153
> >        flush_space+0x269/0xe70 fs/btrfs/space-info.c:723
> >        btrfs_async_reclaim_metadata_space+0x106/0x350 fs/btrfs/space-info.c:1078
> >        process_one_work+0x92c/0x12c0 kernel/workqueue.c:2600
> >        worker_thread+0xa63/0x1210 kernel/workqueue.c:2751
> >        kthread+0x2b8/0x350 kernel/kthread.c:389
> >        ret_from_fork+0x2e/0x60 arch/x86/kernel/process.c:145
> >        ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> > 
> > -> #0 (&delayed_node->mutex){+.+.}-{3:3}:
> >        check_prev_add kernel/locking/lockdep.c:3142 [inline]
> >        check_prevs_add kernel/locking/lockdep.c:3261 [inline]
> >        validate_chain kernel/locking/lockdep.c:3876 [inline]
> >        __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5144
> >        lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
> >        __mutex_lock_common+0x1d8/0x2530 kernel/locking/mutex.c:603
> >        __mutex_lock kernel/locking/mutex.c:747 [inline]
> >        mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
> >        __btrfs_release_delayed_node+0x9a/0xaa0 fs/btrfs/delayed-inode.c:256
> >        btrfs_release_delayed_node fs/btrfs/delayed-inode.c:281 [inline]
> >        __btrfs_run_delayed_items+0x2b5/0x430 fs/btrfs/delayed-inode.c:1156
> >        btrfs_commit_transaction+0x859/0x2ff0 fs/btrfs/transaction.c:2276
> >        btrfs_sync_file+0xf56/0x1330 fs/btrfs/file.c:1988
> >        vfs_fsync_range fs/sync.c:188 [inline]
> >        vfs_fsync fs/sync.c:202 [inline]
> >        do_fsync fs/sync.c:212 [inline]
> >        __do_sys_fsync fs/sync.c:220 [inline]
> >        __se_sys_fsync fs/sync.c:218 [inline]
> >        __x64_sys_fsync+0x196/0x1e0 fs/sync.c:218
> >        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >        do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> >        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > 
> > other info that might help us debug this:
> > 
> >  Possible unsafe locking scenario:
> > 
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(btrfs-tree-00);
> >                                lock(&delayed_node->mutex);
> >                                lock(btrfs-tree-00);
> >   lock(&delayed_node->mutex);
> > 
> >  *** DEADLOCK ***
> > 
> > 3 locks held by syz-executor.2/13257:
> >  #0: ffff88802c1ee370 (btrfs_trans_num_writers){++++}-{0:0}, at: spin_unlock include/linux/spinlock.h:391 [inline]
> >  #0: ffff88802c1ee370 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0xb87/0xe00 fs/btrfs/transaction.c:287
> >  #1: ffff88802c1ee398 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0xbb2/0xe00 fs/btrfs/transaction.c:288
> >  #2: ffff88802a5ab8e8 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_lock+0x3c/0x2a0 fs/btrfs/locking.c:198
