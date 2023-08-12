Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890F1779FC6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 13:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjHLLo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 07:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbjHLLo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 07:44:26 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2224EEA;
        Sat, 12 Aug 2023 04:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1691840665; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PhYRfzEQvt18hVMY526MPdkqCHk4QFO/Y7fKB/Ls9hqH48JXUc1li/etATuG28A0bt
    3q/5c6g6JNVEvjBxhkmTyLNV2GLuS4Zt827YgwdGMYGpgIdAgkbgS6pN46rNlG1ffQMi
    kLxw9fwxKXB3ctsbNoZEQdle+hsIS5f8DHIyzIUtrE3dh+cNstMmCFH5pwOgV6/9EL/0
    NiLC4Jkl3XFjhLA982w1MgzHjFxSOhd+H9kMEPxPnez3exiDnbPhHh1f/oKdi10SzwUU
    i3GDitTB3pRGicfYtudFZCrFrGzUlyo7/SRirrIOPXc8/ijAGT6JlBY/vkgFEoHQnq4x
    2y4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1691840665;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=xHWPl5Z24PYM7I99f3izHk9v7/nEESR69dpFdH60jE0=;
    b=HqOxhg6H3Thr7YaR//gbDy7tbZUKBDewSTLh5vJ0YL4JyPHEMHwj8WSnHhXLaxSWzA
    +OnzLO5CvfKTW0+GyCkxgkD/o6XLL7ch0Yrl/uQZ0fxARQ0AUPISt0tf//6dUSN2+aF0
    g87LtJ7NakMbhdUyiwm+BMtE9qzkW8DffV5opeXqTnrBOcrTTKxk0slVpzsmnAqxbE6r
    ibA2bwbTmCAyGDebOWt3B5fNX4wBjA2TgQJ9ev0Y1K0nLPdvtT/r7YV1BJXKmcc30kUF
    5dZTt1px+FhDKw+gh0lnDoYQsAr/irDznittaNtqAooFiEqF2TV4WkYCsrMIcS1ySCEW
    e/KA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1691840665;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=xHWPl5Z24PYM7I99f3izHk9v7/nEESR69dpFdH60jE0=;
    b=YjYI1aosKiSLmEHDVx9KxloqCJxAp04oDjPyXRWodrBaI9P1JUvnSbP7Y3x4GQ6aNl
    uTgTJjn2HgJFz1t9HTQULssZ+A3oEdF1qtL7uPGqWeUPUtFVEn/AHI993QJVDvhW7CZ/
    BE22TvJbdA6f0bWpu9B1GW284X8c6e4ovBotzycwrwYBu3u8f4AFFP4yikbHSLn/ZMwq
    QITSyeXjxxXlvAWXqlGFZtPykVsY3PzwQO/GpqAsKWCOpxkQgxOsVVCEF7NclxcwhCvf
    +pI3623Y45x+KX1WG5vNbk8EgWyc3qjLFUDaGmkYQPlVFY3Ek5X1AmniPVND1iPA5gc3
    G5Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1691840665;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=xHWPl5Z24PYM7I99f3izHk9v7/nEESR69dpFdH60jE0=;
    b=SJXZL94gnrZDOig2/Y9lLtcDMrDlWoZKLFLKn3R/XA/GE/xjCvLuQ4F2KSRvRNEiqV
    kdhgQx+rKQ8E9yjQXFDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq1USEbMhpqw=="
Received: from [IPV6:2a00:6020:4a8e:5004::923]
    by smtp.strato.de (RZmta 49.6.6 AUTH)
    with ESMTPSA id 69691ez7CBiOi7N
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 12 Aug 2023 13:44:24 +0200 (CEST)
Message-ID: <8e578867-5223-e96a-41e3-5d6d27af1727@hartkopp.net>
Date:   Sat, 12 Aug 2023 13:44:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: possible deadlock in raw_setsockopt
To:     Yikebaer Aizezi <yikebaer61@gmail.com>, mkl@pengutronix.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        "pabeni@redhat.com" <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CALcu4raN3=04gp5=f=sDMtTuTG0VZpunwqSVd8MNVcnfPe+t4w@mail.gmail.com>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CALcu4raN3=04gp5=f=sDMtTuTG0VZpunwqSVd8MNVcnfPe+t4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

it seems to be the common pattern to use

rtnl_lock();
lock_sock(sk);

(..)

release_lock(sk);
rtnl_unlock();

And the referenced code here
home/smyl/linux-image/linux-6.5-rc3/net/can/raw.c:607
already follows this pattern.

A wrong locking has been introduced in

ee8b94c8510c ("can: raw: fix receiver memory leak")

which has been fixed in

11c9027c983e ("can: raw: fix lockdep issue in raw_release()")

Your selected linux-6.5-rc3 tree has the above problem but it is fixed 
in Linus' latest tree now.

Best regards,
Oliver

On 10.08.23 12:30, Yikebaer Aizezi wrote:
> Hello,
> 
> When using Healer to fuzz the Linux-6.5-rc3,  the following crash
> was triggered.
> 
> HEAD commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef (tag: v6.5-rc3)
> git tree: upstream
> console output:
> https://drive.google.com/file/d/1d9rLH0SYwNhTm2datRKbVpET1irbx_tA/view?usp=drive_link
> kernel config: https://drive.google.com/file/d/1OQIne-cVGeH6R4nqGGm6Igm3DnsozLhJ/view?usp=drive_link
> C reproducer: https://drive.google.com/file/d/1iewyTDtNLkXAJSMnREXKNYcUwfN1mAqA/view?usp=drive_link
> Syzlang reproducer:
> https://drive.google.com/file/d/17p1lUipZkXyl9xE0_Qanerbg75W6ER5y/view?usp=drive_link
> 
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>
> 
> WARNING: possible circular locking dependency detected
> 6.5.0-rc3 #1 Not tainted
> ------------------------------------------------------
> syz-executor/13006 is trying to acquire lock:
> ffff88801ca69130 (sk_lock-AF_CAN){+.+.}-{0:0}, at: lock_sock
> home/smyl/linux-image/linux-6.5-rc3/./include/net/sock.h:1708 [inline]
> ffff88801ca69130 (sk_lock-AF_CAN){+.+.}-{0:0}, at:
> raw_setsockopt+0x3b6/0x1050
> home/smyl/linux-image/linux-6.5-rc3/net/can/raw.c:607
> 
> but task is already holding lock:
> ffffffff8cdca268 (rtnl_mutex){+.+.}-{3:3}, at:
> raw_setsockopt+0x3ac/0x1050
> home/smyl/linux-image/linux-6.5-rc3/net/can/raw.c:606
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (rtnl_mutex){+.+.}-{3:3}:
>         __mutex_lock_common
> home/smyl/linux-image/linux-6.5-rc3/kernel/locking/mutex.c:603
> [inline]
>         __mutex_lock+0x14f/0x1440
> home/smyl/linux-image/linux-6.5-rc3/kernel/locking/mutex.c:747
>         raw_release+0x1bd/0x940
> home/smyl/linux-image/linux-6.5-rc3/net/can/raw.c:391
>         __sock_release+0xcd/0x290
> home/smyl/linux-image/linux-6.5-rc3/net/socket.c:654
>         sock_close+0x18/0x20
> home/smyl/linux-image/linux-6.5-rc3/net/socket.c:1386
>         __fput+0x391/0x9d0
> home/smyl/linux-image/linux-6.5-rc3/fs/file_table.c:384
>         task_work_run+0x153/0x230
> home/smyl/linux-image/linux-6.5-rc3/kernel/task_work.c:179
>         resume_user_mode_work
> home/smyl/linux-image/linux-6.5-rc3/./include/linux/resume_user_mode.h:49
> [inline]
>         exit_to_user_mode_loop
> home/smyl/linux-image/linux-6.5-rc3/kernel/entry/common.c:171 [inline]
>         exit_to_user_mode_prepare+0x210/0x240
> home/smyl/linux-image/linux-6.5-rc3/kernel/entry/common.c:204
>         __syscall_exit_to_user_mode_work
> home/smyl/linux-image/linux-6.5-rc3/kernel/entry/common.c:286 [inline]
>         syscall_exit_to_user_mode+0x19/0x50
> home/smyl/linux-image/linux-6.5-rc3/kernel/entry/common.c:297
>         do_syscall_64+0x42/0xb0
> home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:86
>         entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> -> #0 (sk_lock-AF_CAN){+.+.}-{0:0}:
>         check_prev_add
> home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3142
> [inline]
>         check_prevs_add
> home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3261
> [inline]
>         validate_chain
> home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3876
> [inline]
>         __lock_acquire+0x2ecd/0x5b90
> home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5144
>         lock_acquire
> home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5761
> [inline]
>         lock_acquire+0x1ad/0x520
> home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5726
>         lock_sock_nested+0x34/0xe0
> home/smyl/linux-image/linux-6.5-rc3/net/core/sock.c:3492
>         lock_sock
> home/smyl/linux-image/linux-6.5-rc3/./include/net/sock.h:1708 [inline]
>         raw_setsockopt+0x3b6/0x1050
> home/smyl/linux-image/linux-6.5-rc3/net/can/raw.c:607
>         __sys_setsockopt+0x252/0x510
> home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2263
>         __do_sys_setsockopt
> home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2274 [inline]
>         __se_sys_setsockopt
> home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2271 [inline]
>         __x64_sys_setsockopt+0xb9/0x150
> home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2271
>         do_syscall_x64
> home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:50
> [inline]
>         do_syscall_64+0x35/0xb0
> home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:80
>         entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> other info that might help us debug this:
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(rtnl_mutex);
>                                 lock(sk_lock-AF_CAN);
>                                 lock(rtnl_mutex);
>    lock(sk_lock-AF_CAN);
> 
>   *** DEADLOCK ***
> 
> 1 lock held by syz-executor/13006:
>   #0: ffffffff8cdca268 (rtnl_mutex){+.+.}-{3:3}, at:
> raw_setsockopt+0x3ac/0x1050
> home/smyl/linux-image/linux-6.5-rc3/net/can/raw.c:606
> 
> stack backtrace:
> CPU: 0 PID: 13006 Comm: syz-executor Not tainted 6.5.0-rc3 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> Call Trace:
>   <TASK>
>   __dump_stack home/smyl/linux-image/linux-6.5-rc3/lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x92/0xf0
> home/smyl/linux-image/linux-6.5-rc3/lib/dump_stack.c:106
>   check_noncircular+0x2ef/0x3d0
> home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:2195
>   check_prev_add
> home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3142
> [inline]
>   check_prevs_add
> home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3261
> [inline]
>   validate_chain
> home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3876
> [inline]
>   __lock_acquire+0x2ecd/0x5b90
> home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5144
>   lock_acquire home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5761
> [inline]
>   lock_acquire+0x1ad/0x520
> home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5726
>   lock_sock_nested+0x34/0xe0
> home/smyl/linux-image/linux-6.5-rc3/net/core/sock.c:3492
>   lock_sock home/smyl/linux-image/linux-6.5-rc3/./include/net/sock.h:1708
> [inline]
>   raw_setsockopt+0x3b6/0x1050
> home/smyl/linux-image/linux-6.5-rc3/net/can/raw.c:607
>   __sys_setsockopt+0x252/0x510
> home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2263
>   __do_sys_setsockopt
> home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2274 [inline]
>   __se_sys_setsockopt
> home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2271 [inline]
>   __x64_sys_setsockopt+0xb9/0x150
> home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2271
>   do_syscall_x64
> home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:50
> [inline]
>   do_syscall_64+0x35/0xb0
> home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x47959d
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f1c93598068 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
> RDX: 0000000000000002 RSI: 0000000000000065 RDI: 0000000000000003
> RBP: 000000000059c0a0 R08: 0000000000000004 R09: 0000000000000000
> R10: 00000000200001c0 R11: 0000000000000246 R12: 000000000059c0ac
> R13: 000000000000000b R14: 0000000000437250 R15: 00007f1c93578000
>   </TASK>
> 
