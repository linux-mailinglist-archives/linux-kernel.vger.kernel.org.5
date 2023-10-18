Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A617CD87E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjJRJqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJRJqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:46:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA20B0;
        Wed, 18 Oct 2023 02:46:43 -0700 (PDT)
Received: from [192.168.10.2] (unknown [39.45.48.178])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 788EA66072F4;
        Wed, 18 Oct 2023 10:46:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697622402;
        bh=m25X5w8WmDntQdjfhERGFsKxFWTBvcaJ6W+sivEkcLM=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=d3j52GPmjP20yjABiv7Ik30H/FqAwXgm4/bQMuyhgzPzXB2vdJZQsxQlpsNyX1tai
         8jvRRgOixElGFxBUpRIlitNYkWfar/7MWX42dcULdzZHMbr12Av2my3+/zSUwUZCeO
         7FFeoWvt70z420yV14sSRSOo5hZewvCobMb56mqq53ApbPs7eLP2v/elVnQ8UbRDGa
         94MlgzSp8rAV563XY8BbBpznPU6xWfFvTwK9C3Pg4A5Y1Tirup5xCP5Z4EVqklQqKb
         vxEtCHkn9QwZyyPkDCaET8po0541FH6TpQ/dTlEr08uynl69hL/HFqk5qw/VA3U3iF
         vAGKVN+TUXUeA==
Message-ID: <dc016529-51f7-4a8a-8c67-54a15b19b78b@collabora.com>
Date:   Wed, 18 Oct 2023 14:46:33 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in usbdev_open (2)
To:     syzbot <syzbot+b73659f5bb96fac34820@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <0000000000004b4e4805f84041e0@google.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <0000000000004b4e4805f84041e0@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
next-20231018

On 4/1/23 11:15 AM, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    59caa87f9dfb Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=16dd438ec80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e918bdf4f2f853c4
> dashboard link: https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cb0c69c80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160d1e21c80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4d91c587af1a/disk-59caa87f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c2a88c8fab99/vmlinux-59caa87f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0f56d2d1cbfc/Image-59caa87f.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b73659f5bb96fac34820@syzkaller.appspotmail.com
> 
> INFO: task syz-executor388:6000 blocked for more than 143 seconds.
>       Not tainted 6.3.0-rc4-syzkaller-g59caa87f9dfb #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor388 state:D stack:0     pid:6000  ppid:5984   flags:0x00000001
> Call trace:
>  __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
>  context_switch kernel/sched/core.c:5307 [inline]
>  __schedule+0x1048/0x1e38 kernel/sched/core.c:6625
>  schedule+0xc4/0x170 kernel/sched/core.c:6701
>  schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6760
>  __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:679
>  __mutex_lock kernel/locking/mutex.c:747 [inline]
>  mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
>  device_lock include/linux/device.h:832 [inline]
>  usbdev_open+0x13c/0x6c0 drivers/usb/core/devio.c:1041
>  chrdev_open+0x3e8/0x4fc fs/char_dev.c:414
>  do_dentry_open+0x724/0xf90 fs/open.c:920
>  vfs_open+0x7c/0x90 fs/open.c:1051
>  do_open fs/namei.c:3560 [inline]
>  path_openat+0x1f2c/0x27f8 fs/namei.c:3715
>  do_filp_open+0x1bc/0x3cc fs/namei.c:3742
>  do_sys_openat2+0x128/0x3d8 fs/open.c:1348
>  do_sys_open fs/open.c:1364 [inline]
>  __do_sys_openat fs/open.c:1380 [inline]
>  __se_sys_openat fs/open.c:1375 [inline]
>  __arm64_sys_openat+0x1f0/0x240 fs/open.c:1375
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
>  el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
>  do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
>  el0_svc+0x58/0x168 arch/arm64/kernel/entry-common.c:637
>  el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
> 
> Showing all locks held in the system:
> 1 lock held by rcu_tasks_kthre/12:
>  #0: ffff800015d36810 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x44/0xcf4 kernel/rcu/tasks.h:510
> 1 lock held by rcu_tasks_trace/13:
>  #0: ffff800015d37010 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x44/0xcf4 kernel/rcu/tasks.h:510
> 1 lock held by khungtaskd/28:
>  #0: ffff800015d36640 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0xc/0x44 include/linux/rcupdate.h:326
> 5 locks held by kworker/0:2/1522:
>  #0: ffff0000c13f7d38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x664/0x12d4 kernel/workqueue.c:2363
>  #1: ffff8000225b7c20 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x6a8/0x12d4 kernel/workqueue.c:2365
>  #2: ffff0000ceaa4190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:832 [inline]
>  #2: ffff0000ceaa4190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c8/0x474c drivers/usb/core/hub.c:5739
>  #3: ffff0000d2dd1190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:832 [inline]
>  #3: ffff0000d2dd1190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x90/0x434 drivers/base/dd.c:973
>  #4: ffff0000cc332118 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:832 [inline]
>  #4: ffff0000cc332118 (&dev->mutex){....}-{3:3}, at: __device_attach+0x90/0x434 drivers/base/dd.c:973
> 2 locks held by getty/5625:
>  #0: ffff0000d354c098 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
>  #1: ffff80001a8602f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x414/0x1210 drivers/tty/n_tty.c:2177
> 4 locks held by udevd/5996:
>  #0: ffff0000d0fe41c8 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xac/0xc44 fs/seq_file.c:182
>  #1: ffff0000cf47a088 (&of->mutex){+.+.}-{3:3}, at: kernfs_seq_start+0x58/0x384 fs/kernfs/file.c:154
>  #2: ffff0000d37d0660 (kn->active#14){.+.+}-{0:0}, at: kernfs_seq_start+0x74/0x384 fs/kernfs/file.c:155
>  #3: ffff0000d2dd1190 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:837 [inline]
>  #3: ffff0000d2dd1190 (&dev->mutex){....}-{3:3}, at: manufacturer_show+0x30/0xac drivers/usb/core/sysfs.c:142
> 1 lock held by syz-executor388/6000:
>  #0: ffff0000ceaa4190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:832 [inline]
>  #0: ffff0000ceaa4190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x13c/0x6c0 drivers/usb/core/devio.c:1041
> 
> =============================================
> 
> 
> 

-- 
BR,
Muhammad Usama Anjum
