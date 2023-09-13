Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C69B79EB0F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbjIMO2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjIMO2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:28:15 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21CD90
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:28:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf5c314a57so50131075ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694615291; x=1695220091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GmZV/UGQKJTzvTBUBoaWO4CkkP8/THdw8RTk3UVKVIw=;
        b=n3KU7hlkQm+v7fxjEqKDXNfYSDFm2bYercdhLOW7WcxMaEQN4oKMKPswvhKiPPGVc5
         2tJvjb/M2ClVZH5/CSQkr4Rtc4QIvZVlC0vJxhuuXo1s5wq/tdmCO0aW1F0vKQIfLVRM
         JU4kss5I5Xq9ouNbTJHy65rKmeFAa6qWwF7QWm4IPkDyWNjlcwYeat0QaIaIyq+cu9uk
         QHr3LHy4mcCHlBI/JwjJ4RlbMTln91BkS5pWUfJOKB5bGt6JdlLLP/M392OSrlEH4r0x
         edVhZ0IJ94/soykgs5VJkCKRHBL8/qcK7bAgXOVIKts0hyJ36Qt+EO7SNAIIJ/t4BX2y
         UXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694615291; x=1695220091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmZV/UGQKJTzvTBUBoaWO4CkkP8/THdw8RTk3UVKVIw=;
        b=qZzggLWy/7CRH9m3R2wgu3tCezJ03r8O6V15mSVs17/7/yxVHzVei6rqrE+pZMUPY3
         S4Ck6M7NcNLqURZXw41+Bh4VgK1Vj2w3vIkzTcvNknKdGQ9eaHHTVjlHNAeMaqzSfnLd
         lGqhJ4fPKmLS+vi7pkTN5vwpIueR6NDqpalE+J6P/EQnwymAzuxyXSdc+CIOug19+qEG
         4GRH0TFLICeyDwMUibLD0di15etWC5ojMbmVEBRX9ITp4xaeqlwegg8fB5xaBUf0XU+O
         mbvlQYuMTZ7Y3I/D6mw335isBLgOgp2m0PyDdP7S6NF/uvhFVkWR62hbPhfSbRxxCHql
         aTww==
X-Gm-Message-State: AOJu0Yy5GEMC/qEDFsdutFiSzITHc5VKggje8KQ92/3Ujb58MPO5u23S
        9uKHDyiKKgyYXZpAeXzRsgU=
X-Google-Smtp-Source: AGHT+IEWCeWk0qXJjJp7ToxIP7uhzyCNFDIPEJZ6Fz2e1TRNC3D3Xkqn35QFx0Z2Rpsq2CFlFgh9NA==
X-Received: by 2002:a17:902:db12:b0:1c3:25ba:e204 with SMTP id m18-20020a170902db1200b001c325bae204mr3079666plx.54.1694615291213;
        Wed, 13 Sep 2023 07:28:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bg12-20020a1709028e8c00b001ac7f583f72sm10469777plb.209.2023.09.13.07.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 07:28:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 13 Sep 2023 07:28:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tejun Heo <tj@kernel.org>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] workqueue: don't skip lockdep work dependency in
 cancel_work_sync()
Message-ID: <e0717628-e436-4091-8b2e-2f4dcb646ec8@roeck-us.net>
References: <21b9c1ac-64b7-7f4b-1e62-bf2f021fffcd@I-love.SAKURA.ne.jp>
 <YuK78Jiy12BJG/Tp@slm.duckdns.org>
 <0ad532b2-df5f-331a-ae7f-21460fc62fe2@I-love.SAKURA.ne.jp>
 <97cbf8a9-d5e1-376f-6a49-3474871ea6b4@I-love.SAKURA.ne.jp>
 <afa1ac2c-a023-a91e-e596-60931b38247e@I-love.SAKURA.ne.jp>
 <7d034f7b-af42-4dbc-0887-60f4bdb3dcca@I-love.SAKURA.ne.jp>
 <0a85696a-b0b9-0f4a-7c00-cd89edc9304c@I-love.SAKURA.ne.jp>
 <77d47eed-6a22-7e81-59de-4d45852ca4de@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77d47eed-6a22-7e81-59de-4d45852ca4de@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 29, 2022 at 01:30:23PM +0900, Tetsuo Handa wrote:
> Like Hillf Danton mentioned
> 
>   syzbot should have been able to catch cancel_work_sync() in work context
>   by checking lockdep_map in __flush_work() for both flush and cancel.
> 
> in [1], being unable to report an obvious deadlock scenario shown below is
> broken. From locking dependency perspective, sync version of cancel request
> should behave as if flush request, for it waits for completion of work if
> that work has already started execution.
> 
>   ----------
>   #include <linux/module.h>
>   #include <linux/sched.h>
>   static DEFINE_MUTEX(mutex);
>   static void work_fn(struct work_struct *work)
>   {
>     schedule_timeout_uninterruptible(HZ / 5);
>     mutex_lock(&mutex);
>     mutex_unlock(&mutex);
>   }
>   static DECLARE_WORK(work, work_fn);
>   static int __init test_init(void)
>   {
>     schedule_work(&work);
>     schedule_timeout_uninterruptible(HZ / 10);
>     mutex_lock(&mutex);
>     cancel_work_sync(&work);
>     mutex_unlock(&mutex);
>     return -EINVAL;
>   }
>   module_init(test_init);
>   MODULE_LICENSE("GPL");
>   ----------
> 
> The check this patch restores was added by commit 0976dfc1d0cd80a4
> ("workqueue: Catch more locking problems with flush_work()").
> 
> Then, lockdep's crossrelease feature was added by commit b09be676e0ff25bd
> ("locking/lockdep: Implement the 'crossrelease' feature"). As a result,
> this check was once removed by commit fd1a5b04dfb899f8 ("workqueue: Remove
> now redundant lock acquisitions wrt. workqueue flushes").
> 
> But lockdep's crossrelease feature was removed by commit e966eaeeb623f099
> ("locking/lockdep: Remove the cross-release locking checks"). At this
> point, this check should have been restored.
> 
> Then, commit d6e89786bed977f3 ("workqueue: skip lockdep wq dependency in
> cancel_work_sync()") introduced a boolean flag in order to distinguish
> flush_work() and cancel_work_sync(), for checking "struct workqueue_struct"
> dependency when called from cancel_work_sync() was causing false positives.
> 
> Then, commit 87915adc3f0acdf0 ("workqueue: re-add lockdep dependencies for
> flushing") tried to restore "struct work_struct" dependency check, but by
> error checked this boolean flag. Like an example shown above indicates,
> "struct work_struct" dependency needs to be checked for both flush_work()
> and cancel_work_sync().
> 
> Link: https://lkml.kernel.org/r/20220504044800.4966-1-hdanton@sina.com [1]
> Reported-by: Hillf Danton <hdanton@sina.com>
> Suggested-by: Lai Jiangshan <jiangshanlai@gmail.com>
> Fixes: 87915adc3f0acdf0 ("workqueue: re-add lockdep dependencies for flushing")
> Cc: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---

This patch results in the attached lockdep splat when running the
ast2600-evb emulation in qemu with aspeed_g5_defconfig and lock debugging
enabled. Reverting this patch fixes the problem.

Guenter

----
[    9.809960] ======================================================
[    9.810053] WARNING: possible circular locking dependency detected
[    9.810196] 6.6.0-rc1-00004-g6faca50f629f #1 Tainted: G                 N
[    9.810327] ------------------------------------------------------
[    9.810406] ip/357 is trying to acquire lock:
[    9.810501] 83af6c40 ((work_completion)(&(&dev->state_queue)->work)){+.+.}-{0:0}, at: __flush_work+0x40/0x550
[    9.811052] 
[    9.811052] but task is already holding lock:
[    9.811133] 81639924 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x124/0x514
[    9.811264] 
[    9.811264] which lock already depends on the new lock.
[    9.811264] 
[    9.811361] 
[    9.811361] the existing dependency chain (in reverse order) is:
[    9.811466] 
[    9.811466] -> #1 (rtnl_mutex){+.+.}-{3:3}:
[    9.811616]        lock_acquire+0xfc/0x368
[    9.811717]        __mutex_lock+0x90/0xf00
[    9.811782]        mutex_lock_nested+0x24/0x2c
[    9.811845]        ftgmac100_reset+0x1c/0x1dc
[    9.811907]        ftgmac100_adjust_link+0xc0/0x13c
[    9.811972]        phy_link_change+0x30/0x5c
[    9.812035]        phy_check_link_status+0x9c/0x11c
[    9.812100]        phy_state_machine+0x1c0/0x2c0
[    9.812163]        process_one_work+0x23c/0x618
[    9.812225]        worker_thread+0x1e0/0x4a0
[    9.812283]        kthread+0x100/0x124
[    9.812339]        ret_from_fork+0x14/0x28
[    9.812405] 
[    9.812405] -> #0 ((work_completion)(&(&dev->state_queue)->work)){+.+.}-{0:0}:
[    9.812531]        check_prev_add+0x128/0x15ec
[    9.812594]        __lock_acquire+0x16ec/0x20cc
[    9.812656]        lock_acquire+0xfc/0x368
[    9.812712]        __flush_work+0x70/0x550
[    9.812769]        __cancel_work_timer+0x1e4/0x264
[    9.812833]        phy_stop+0x78/0x128
[    9.812889]        ftgmac100_stop+0x5c/0xac
[    9.812949]        __dev_close_many+0xb8/0x140
[    9.813013]        __dev_change_flags+0x100/0x24c
[    9.813077]        dev_change_flags+0x20/0x5c
[    9.813137]        do_setlink+0x28c/0xf0c
[    9.813194]        rtnl_newlink+0x348/0x8b8
[    9.813253]        rtnetlink_rcv_msg+0x154/0x514
[    9.813316]        netlink_rcv_skb+0xbc/0x114
[    9.813378]        netlink_unicast+0x1b4/0x320
[    9.813438]        netlink_sendmsg+0x1fc/0x47c
[    9.813499]        ____sys_sendmsg+0xa8/0x324
[    9.813561]        ___sys_sendmsg+0x70/0x9c
[    9.813620]        sys_sendmsg+0x54/0x90
[    9.813691]        ret_fast_syscall+0x0/0x1c
[    9.813760] 
[    9.813760] other info that might help us debug this:
[    9.813760] 
[    9.813864]  Possible unsafe locking scenario:
[    9.813864] 
[    9.813938]        CPU0                    CPU1
[    9.813999]        ----                    ----
[    9.814062]   lock(rtnl_mutex);
[    9.814139]                                lock((work_completion)(&(&dev->state_queue)->work));
[    9.814258]                                lock(rtnl_mutex);
[    9.814354]   lock((work_completion)(&(&dev->state_queue)->work));
[    9.814451] 
[    9.814451]  *** DEADLOCK ***
[    9.814451] 
[    9.814543] 1 lock held by ip/357:
[    9.814608]  #0: 81639924 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x124/0x514
[    9.814761] 
[    9.814761] stack backtrace:
[    9.814900] CPU: 0 PID: 357 Comm: ip Tainted: G                 N 6.6.0-rc1-00004-g6faca50f629f #1
[    9.815019] Hardware name: Generic DT based system
[    9.815188]  unwind_backtrace from show_stack+0x18/0x1c
[    9.815299]  show_stack from dump_stack_lvl+0x68/0x90
[    9.815374]  dump_stack_lvl from check_noncircular+0x1a4/0x1e0
[    9.815452]  check_noncircular from check_prev_add+0x128/0x15ec
[    9.815529]  check_prev_add from __lock_acquire+0x16ec/0x20cc
[    9.815606]  __lock_acquire from lock_acquire+0xfc/0x368
[    9.815677]  lock_acquire from __flush_work+0x70/0x550
[    9.815746]  __flush_work from __cancel_work_timer+0x1e4/0x264
[    9.815821]  __cancel_work_timer from phy_stop+0x78/0x128
[    9.815896]  phy_stop from ftgmac100_stop+0x5c/0xac
[    9.815968]  ftgmac100_stop from __dev_close_many+0xb8/0x140
[    9.816047]  __dev_close_many from __dev_change_flags+0x100/0x24c
[    9.816127]  __dev_change_flags from dev_change_flags+0x20/0x5c
[    9.816206]  dev_change_flags from do_setlink+0x28c/0xf0c
[    9.816279]  do_setlink from rtnl_newlink+0x348/0x8b8
[    9.816351]  rtnl_newlink from rtnetlink_rcv_msg+0x154/0x514
[    9.816428]  rtnetlink_rcv_msg from netlink_rcv_skb+0xbc/0x114
[    9.816506]  netlink_rcv_skb from netlink_unicast+0x1b4/0x320
[    9.816583]  netlink_unicast from netlink_sendmsg+0x1fc/0x47c
[    9.816659]  netlink_sendmsg from ____sys_sendmsg+0xa8/0x324
[    9.816737]  ____sys_sendmsg from ___sys_sendmsg+0x70/0x9c
[    9.816812]  ___sys_sendmsg from sys_sendmsg+0x54/0x90
[    9.816884]  sys_sendmsg from ret_fast_syscall+0x0/0x1c
[    9.816983] Exception stack(0xe1f89fa8 to 0xe1f89ff0)
[    9.817464] 9fa0:                   00000000 00000000 00000003 7ed098d8 00000000 00000000
[    9.817602] 9fc0: 00000000 00000000 ffffffff 00000128 00000001 00000002 7ed09f47 7ed09f4a
[    9.817724] 9fe0: 7ed09868 7ed09858 76eb0dac 76eb0228

Decoded:

[    9.809960] ======================================================
[    9.810053] WARNING: possible circular locking dependency detected
[    9.810196] 6.6.0-rc1-00004-g6faca50f629f #1 Tainted: G                 N
[    9.810327] ------------------------------------------------------
[    9.810406] ip/357 is trying to acquire lock:
[    9.810501] 83af6c40 ((work_completion)(&(&dev->state_queue)->work)){+.+.}-{0:0}, at: __flush_work (kernel/workqueue.c:3403) 
		-> lock_map_acquire(&work->lockdep_map);
[    9.811052] 
[    9.811052] but task is already holding lock:
[    9.811133] 81639924 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg (net/core/rtnetlink.c:6442) 
[    9.811264] 
[    9.811264] which lock already depends on the new lock.
[    9.811264] 
[    9.811361] 
[    9.811361] the existing dependency chain (in reverse order) is:
[    9.811466] 
[    9.811466] -> #1 (rtnl_mutex){+.+.}-{3:3}:
[    9.811616] lock_acquire (./arch/arm/include/asm/percpu.h:37 kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755 kernel/locking/lockdep.c:5718) 
[    9.811717] __mutex_lock (./arch/arm/include/asm/jump_label.h:14 ./include/linux/jump_label.h:207 ./include/trace/events/lock.h:95 kernel/locking/mutex.c:605 kernel/locking/mutex.c:747) 
[    9.811782] mutex_lock_nested (kernel/locking/mutex.c:800) 
[    9.811845] ftgmac100_reset (drivers/net/ethernet/faraday/ftgmac100.c:1317) 
		-> rtnl_lock();
[    9.811907] ftgmac100_adjust_link (drivers/net/ethernet/faraday/ftgmac100.c:1419) 
[    9.811972] phy_link_change (drivers/net/phy/phy_device.c:1081) 
[    9.812035] phy_check_link_status (drivers/net/phy/phy.c:77 drivers/net/phy/phy.c:966 drivers/net/phy/phy.c:947) 
[    9.812100] phy_state_machine (drivers/net/phy/phy.c:1020 drivers/net/phy/phy.c:1497) 
[    9.812163] process_one_work (./arch/arm/include/asm/jump_label.h:14 ./include/linux/jump_label.h:207 ./include/trace/events/workqueue.h:108 kernel/workqueue.c:2635) 
		-> lock_map_acquire(&pwq->wq->lockdep_map);
[    9.812225] worker_thread (kernel/workqueue.c:2697 kernel/workqueue.c:2784) 
[    9.812283] kthread (kernel/kthread.c:388) 
[    9.812339] ret_from_fork (arch/arm/kernel/entry-common.S:135) 
[    9.812405] 
[    9.812405] -> #0 ((work_completion)(&(&dev->state_queue)->work)){+.+.}-{0:0}:
[    9.812531] check_prev_add (kernel/locking/lockdep.c:3135) 
[    9.812594] __lock_acquire (kernel/locking/lockdep.c:3254 kernel/locking/lockdep.c:3868 kernel/locking/lockdep.c:5136) 
[    9.812656] lock_acquire (./arch/arm/include/asm/percpu.h:37 kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755 kernel/locking/lockdep.c:5718) 
		-> lock_map_acquire(&work->lockdep_map);
[    9.812712] __flush_work (kernel/workqueue.c:3404) 
[    9.812769] __cancel_work_timer (kernel/workqueue.c:3494) 
[    9.812833] phy_stop (drivers/net/phy/phy.c:1213 drivers/net/phy/phy.c:1391) 
[    9.812889] ftgmac100_stop (drivers/net/ethernet/faraday/ftgmac100.c:348 drivers/net/ethernet/faraday/ftgmac100.c:1583) 
[    9.812949] __dev_close_many (net/core/dev.c:1536 (discriminator 2)) 
[    9.813013] __dev_change_flags (./include/linux/list.h:124 ./include/linux/list.h:215 ./include/linux/list.h:229 net/core/dev.c:1547 net/core/dev.c:8595) 
[    9.813077] dev_change_flags (net/core/dev.c:8670) 
[    9.813137] do_setlink (net/core/rtnetlink.c:2882) 
[    9.813194] rtnl_newlink (net/core/rtnetlink.c:3671 net/core/rtnetlink.c:3718) 
[    9.813253] rtnetlink_rcv_msg (net/core/rtnetlink.c:6444) 
		-> rtnl_lock();
[    9.813316] netlink_rcv_skb (net/netlink/af_netlink.c:2546) 
[    9.813378] netlink_unicast (net/netlink/af_netlink.c:1343 net/netlink/af_netlink.c:1368) 
[    9.813438] netlink_sendmsg (net/netlink/af_netlink.c:1910) 
[    9.813499] ____sys_sendmsg (net/socket.c:733 net/socket.c:753 net/socket.c:2541) 
[    9.813561] ___sys_sendmsg (net/socket.c:2595) 
[    9.813620] sys_sendmsg (./include/linux/file.h:32 net/socket.c:2626 net/socket.c:2633 net/socket.c:2631) 
[    9.813691] ret_fast_syscall (arch/arm/kernel/entry-common.S:68) 
[    9.813760] 
[    9.813760] other info that might help us debug this:
[    9.813760] 
[    9.813864]  Possible unsafe locking scenario:
[    9.813864] 
[    9.813938]        CPU0                    CPU1
[    9.813999]        ----                    ----
[    9.814062]   lock(rtnl_mutex);
[    9.814139]                                lock((work_completion)(&(&dev->state_queue)->work));
[    9.814258]                                lock(rtnl_mutex);
[    9.814354]   lock((work_completion)(&(&dev->state_queue)->work));
[    9.814451] 
[    9.814451]  *** DEADLOCK ***
[    9.814451] 
[    9.814543] 1 lock held by ip/357:
[    9.814608] #0: 81639924 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg (net/core/rtnetlink.c:6442) 
[    9.814761] 
[    9.814761] stack backtrace:
[    9.814900] CPU: 0 PID: 357 Comm: ip Tainted: G                 N 6.6.0-rc1-00004-g6faca50f629f #1
[    9.815019] Hardware name: Generic DT based system
[    9.815188] unwind_backtrace from show_stack (arch/arm/kernel/traps.c:258) 
[    9.815299] show_stack from dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
[    9.815374] dump_stack_lvl from check_noncircular (kernel/locking/lockdep.c:2190) 
[    9.815452] check_noncircular from check_prev_add (kernel/locking/lockdep.c:3135) 
[    9.815529] check_prev_add from __lock_acquire (kernel/locking/lockdep.c:3254 kernel/locking/lockdep.c:3868 kernel/locking/lockdep.c:5136) 
[    9.815606] __lock_acquire from lock_acquire (./arch/arm/include/asm/percpu.h:37 kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755 kernel/locking/lockdep.c:5718) 
[    9.815677] lock_acquire from __flush_work (kernel/workqueue.c:3404) 
[    9.815746] __flush_work from __cancel_work_timer (kernel/workqueue.c:3494) 
[    9.815821] __cancel_work_timer from phy_stop (drivers/net/phy/phy.c:1213 drivers/net/phy/phy.c:1391) 
[    9.815896] phy_stop from ftgmac100_stop (drivers/net/ethernet/faraday/ftgmac100.c:348 drivers/net/ethernet/faraday/ftgmac100.c:1583) 
[    9.815968] ftgmac100_stop from __dev_close_many (net/core/dev.c:1536 (discriminator 2)) 
[    9.816047] __dev_close_many from __dev_change_flags (./include/linux/list.h:124 ./include/linux/list.h:215 ./include/linux/list.h:229 net/core/dev.c:1547 net/core/dev.c:8595) 
[    9.816127] __dev_change_flags from dev_change_flags (net/core/dev.c:8670) 
[    9.816206] dev_change_flags from do_setlink (net/core/rtnetlink.c:2882) 
[    9.816279] do_setlink from rtnl_newlink (net/core/rtnetlink.c:3671 net/core/rtnetlink.c:3718) 
[    9.816351] rtnl_newlink from rtnetlink_rcv_msg (net/core/rtnetlink.c:6444) 
[    9.816428] rtnetlink_rcv_msg from netlink_rcv_skb (net/netlink/af_netlink.c:2546) 
[    9.816506] netlink_rcv_skb from netlink_unicast (net/netlink/af_netlink.c:1343 net/netlink/af_netlink.c:1368) 
[    9.816583] netlink_unicast from netlink_sendmsg (net/netlink/af_netlink.c:1910) 
[    9.816659] netlink_sendmsg from ____sys_sendmsg (net/socket.c:733 net/socket.c:753 net/socket.c:2541) 
[    9.816737] ____sys_sendmsg from ___sys_sendmsg (net/socket.c:2595) 
[    9.816812] ___sys_sendmsg from sys_sendmsg (./include/linux/file.h:32 net/socket.c:2626 net/socket.c:2633 net/socket.c:2631) 
[    9.816884] sys_sendmsg from ret_fast_syscall (arch/arm/kernel/entry-common.S:68) 
[    9.816983] Exception stack(0xe1f89fa8 to 0xe1f89ff0)
[    9.817464] 9fa0:                   00000000 00000000 00000003 7ed098d8 00000000 00000000
[    9.817602] 9fc0: 00000000 00000000 ffffffff 00000128 00000001 00000002 7ed09f47 7ed09f4a
[    9.817724] 9fe0: 7ed09868 7ed09858 76eb0dac 76eb0228
