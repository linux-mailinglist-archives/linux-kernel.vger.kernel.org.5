Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60E177A044
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 16:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjHLOIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 10:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjHLOIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 10:08:22 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E000510E4;
        Sat, 12 Aug 2023 07:08:24 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe45da0a89so4625460e87.1;
        Sat, 12 Aug 2023 07:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691849303; x=1692454103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvsoikQWEB5Xn0/N76cOc5eFdD0OPbNTdNyqAWmArTU=;
        b=U2+9azpW5oMrmNE3l3mihbWW8Xyzz8tXfm9isLao5gk7inRoXHaPacB6YLrc9MCRDv
         2GUFjHDFiFaB3VsKP9KLqXyLFOCzwtW6dmnY6FvALwLGyFVzetqOFEeGVBEdaM6CSFDS
         7MCeBkVnVUSu2HbtFkBJSt+0vGPzJFW6a6M13VwpuMq/IdBpe9uWI/4XDDc1R1/65VTl
         ZZG0qB16K8rcvY0sFcyfTnqe5m1VVo8v9QJCiwmUs7kH86YNOhNbwLDCmZyPKTa1btFo
         H/PkyOXcR2nseszSvCIVFfVaKeR0QcLI6ATqb8ijOi93nsiBWXLhro2/snF/GK+eSvyd
         STMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691849303; x=1692454103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvsoikQWEB5Xn0/N76cOc5eFdD0OPbNTdNyqAWmArTU=;
        b=arTJR24xyzqsTkx/AMxAUOEg9qiHgWbJZIWgiDCoIqCchyIvt0Q9VCRZT+1ck1B7lj
         aPCENzf23wrmZPwVJ1qwCVcdzxgM0eLetzbcbaFzZE9PJ7N+chq33oR1j0gZwaiSMvLM
         6HxRn/Z1B58vU6Ce/h/8+wGmW6xG+UbprQrLkV1WkVV3S9VErhW7O+6tkTCA15sFqZMI
         xtAGK6ZVi1hFtt2ZEr/ohmVVaT6D1wQ9OYrbSZl6VUgf0FWv8XCpVhEgapX8i8pZmJbp
         JMm6LyLJQn4F1Cmj/atAeiSV2Cl7IyXqJzkgtM/fMRefPx/fyx63/V9ywA7uQLj1bbY3
         4SjQ==
X-Gm-Message-State: AOJu0YzWEYjE/MfFhdyOBAJBLpeBLFMmthHotS9AeVGsNMTihnhfOkFa
        hRiMzIWCKWDiZxzLTYNKY4IlGkoDgTxJm9X7AOY=
X-Google-Smtp-Source: AGHT+IFW1C6CLj0BI8HxzToq2WIbUYUHyZbWv7lBYxBVd+mJKCuU7Bs1Hq2EVAgmLigxZ9NJFfSzng9imggKHKNu8Dc=
X-Received: by 2002:a05:6512:398d:b0:4f7:6404:4638 with SMTP id
 j13-20020a056512398d00b004f764044638mr1740427lfu.17.1691849302450; Sat, 12
 Aug 2023 07:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <CALcu4raN3=04gp5=f=sDMtTuTG0VZpunwqSVd8MNVcnfPe+t4w@mail.gmail.com>
 <8e578867-5223-e96a-41e3-5d6d27af1727@hartkopp.net>
In-Reply-To: <8e578867-5223-e96a-41e3-5d6d27af1727@hartkopp.net>
From:   Yikebaer Aizezi <yikebaer61@gmail.com>
Date:   Sat, 12 Aug 2023 22:08:10 +0800
Message-ID: <CALcu4ra8A1xMT2pgiF3Xope=RVTj+5L7KXstK+WwNtNSgqKAWA@mail.gmail.com>
Subject: Re: possible deadlock in raw_setsockopt
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     mkl@pengutronix.de, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, "pabeni@redhat.com" <pabeni@redhat.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I'll check it out.

Oliver Hartkopp <socketcan@hartkopp.net> =E4=BA=8E2023=E5=B9=B48=E6=9C=8812=
=E6=97=A5=E5=91=A8=E5=85=AD 19:44=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello,
>
> it seems to be the common pattern to use
>
> rtnl_lock();
> lock_sock(sk);
>
> (..)
>
> release_lock(sk);
> rtnl_unlock();
>
> And the referenced code here
> home/smyl/linux-image/linux-6.5-rc3/net/can/raw.c:607
> already follows this pattern.
>
> A wrong locking has been introduced in
>
> ee8b94c8510c ("can: raw: fix receiver memory leak")
>
> which has been fixed in
>
> 11c9027c983e ("can: raw: fix lockdep issue in raw_release()")
>
> Your selected linux-6.5-rc3 tree has the above problem but it is fixed
> in Linus' latest tree now.
>
> Best regards,
> Oliver
>
> On 10.08.23 12:30, Yikebaer Aizezi wrote:
> > Hello,
> >
> > When using Healer to fuzz the Linux-6.5-rc3,  the following crash
> > was triggered.
> >
> > HEAD commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef (tag: v6.5-rc3)
> > git tree: upstream
> > console output:
> > https://drive.google.com/file/d/1d9rLH0SYwNhTm2datRKbVpET1irbx_tA/view?=
usp=3Ddrive_link
> > kernel config: https://drive.google.com/file/d/1OQIne-cVGeH6R4nqGGm6Igm=
3DnsozLhJ/view?usp=3Ddrive_link
> > C reproducer: https://drive.google.com/file/d/1iewyTDtNLkXAJSMnREXKNYcU=
wfN1mAqA/view?usp=3Ddrive_link
> > Syzlang reproducer:
> > https://drive.google.com/file/d/17p1lUipZkXyl9xE0_Qanerbg75W6ER5y/view?=
usp=3Ddrive_link
> >
> > If you fix this issue, please add the following tag to the commit:
> > Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>
> >
> > WARNING: possible circular locking dependency detected
> > 6.5.0-rc3 #1 Not tainted
> > ------------------------------------------------------
> > syz-executor/13006 is trying to acquire lock:
> > ffff88801ca69130 (sk_lock-AF_CAN){+.+.}-{0:0}, at: lock_sock
> > home/smyl/linux-image/linux-6.5-rc3/./include/net/sock.h:1708 [inline]
> > ffff88801ca69130 (sk_lock-AF_CAN){+.+.}-{0:0}, at:
> > raw_setsockopt+0x3b6/0x1050
> > home/smyl/linux-image/linux-6.5-rc3/net/can/raw.c:607
> >
> > but task is already holding lock:
> > ffffffff8cdca268 (rtnl_mutex){+.+.}-{3:3}, at:
> > raw_setsockopt+0x3ac/0x1050
> > home/smyl/linux-image/linux-6.5-rc3/net/can/raw.c:606
> >
> > which lock already depends on the new lock.
> >
> >
> > the existing dependency chain (in reverse order) is:
> >
> > -> #1 (rtnl_mutex){+.+.}-{3:3}:
> >         __mutex_lock_common
> > home/smyl/linux-image/linux-6.5-rc3/kernel/locking/mutex.c:603
> > [inline]
> >         __mutex_lock+0x14f/0x1440
> > home/smyl/linux-image/linux-6.5-rc3/kernel/locking/mutex.c:747
> >         raw_release+0x1bd/0x940
> > home/smyl/linux-image/linux-6.5-rc3/net/can/raw.c:391
> >         __sock_release+0xcd/0x290
> > home/smyl/linux-image/linux-6.5-rc3/net/socket.c:654
> >         sock_close+0x18/0x20
> > home/smyl/linux-image/linux-6.5-rc3/net/socket.c:1386
> >         __fput+0x391/0x9d0
> > home/smyl/linux-image/linux-6.5-rc3/fs/file_table.c:384
> >         task_work_run+0x153/0x230
> > home/smyl/linux-image/linux-6.5-rc3/kernel/task_work.c:179
> >         resume_user_mode_work
> > home/smyl/linux-image/linux-6.5-rc3/./include/linux/resume_user_mode.h:=
49
> > [inline]
> >         exit_to_user_mode_loop
> > home/smyl/linux-image/linux-6.5-rc3/kernel/entry/common.c:171 [inline]
> >         exit_to_user_mode_prepare+0x210/0x240
> > home/smyl/linux-image/linux-6.5-rc3/kernel/entry/common.c:204
> >         __syscall_exit_to_user_mode_work
> > home/smyl/linux-image/linux-6.5-rc3/kernel/entry/common.c:286 [inline]
> >         syscall_exit_to_user_mode+0x19/0x50
> > home/smyl/linux-image/linux-6.5-rc3/kernel/entry/common.c:297
> >         do_syscall_64+0x42/0xb0
> > home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:86
> >         entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > -> #0 (sk_lock-AF_CAN){+.+.}-{0:0}:
> >         check_prev_add
> > home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3142
> > [inline]
> >         check_prevs_add
> > home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3261
> > [inline]
> >         validate_chain
> > home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3876
> > [inline]
> >         __lock_acquire+0x2ecd/0x5b90
> > home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5144
> >         lock_acquire
> > home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5761
> > [inline]
> >         lock_acquire+0x1ad/0x520
> > home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5726
> >         lock_sock_nested+0x34/0xe0
> > home/smyl/linux-image/linux-6.5-rc3/net/core/sock.c:3492
> >         lock_sock
> > home/smyl/linux-image/linux-6.5-rc3/./include/net/sock.h:1708 [inline]
> >         raw_setsockopt+0x3b6/0x1050
> > home/smyl/linux-image/linux-6.5-rc3/net/can/raw.c:607
> >         __sys_setsockopt+0x252/0x510
> > home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2263
> >         __do_sys_setsockopt
> > home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2274 [inline]
> >         __se_sys_setsockopt
> > home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2271 [inline]
> >         __x64_sys_setsockopt+0xb9/0x150
> > home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2271
> >         do_syscall_x64
> > home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:50
> > [inline]
> >         do_syscall_64+0x35/0xb0
> > home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:80
> >         entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > other info that might help us debug this:
> >
> >   Possible unsafe locking scenario:
> >
> >         CPU0                    CPU1
> >         ----                    ----
> >    lock(rtnl_mutex);
> >                                 lock(sk_lock-AF_CAN);
> >                                 lock(rtnl_mutex);
> >    lock(sk_lock-AF_CAN);
> >
> >   *** DEADLOCK ***
> >
> > 1 lock held by syz-executor/13006:
> >   #0: ffffffff8cdca268 (rtnl_mutex){+.+.}-{3:3}, at:
> > raw_setsockopt+0x3ac/0x1050
> > home/smyl/linux-image/linux-6.5-rc3/net/can/raw.c:606
> >
> > stack backtrace:
> > CPU: 0 PID: 13006 Comm: syz-executor Not tainted 6.5.0-rc3 #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> > Call Trace:
> >   <TASK>
> >   __dump_stack home/smyl/linux-image/linux-6.5-rc3/lib/dump_stack.c:88 =
[inline]
> >   dump_stack_lvl+0x92/0xf0
> > home/smyl/linux-image/linux-6.5-rc3/lib/dump_stack.c:106
> >   check_noncircular+0x2ef/0x3d0
> > home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:2195
> >   check_prev_add
> > home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3142
> > [inline]
> >   check_prevs_add
> > home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3261
> > [inline]
> >   validate_chain
> > home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:3876
> > [inline]
> >   __lock_acquire+0x2ecd/0x5b90
> > home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5144
> >   lock_acquire home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockd=
ep.c:5761
> > [inline]
> >   lock_acquire+0x1ad/0x520
> > home/smyl/linux-image/linux-6.5-rc3/kernel/locking/lockdep.c:5726
> >   lock_sock_nested+0x34/0xe0
> > home/smyl/linux-image/linux-6.5-rc3/net/core/sock.c:3492
> >   lock_sock home/smyl/linux-image/linux-6.5-rc3/./include/net/sock.h:17=
08
> > [inline]
> >   raw_setsockopt+0x3b6/0x1050
> > home/smyl/linux-image/linux-6.5-rc3/net/can/raw.c:607
> >   __sys_setsockopt+0x252/0x510
> > home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2263
> >   __do_sys_setsockopt
> > home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2274 [inline]
> >   __se_sys_setsockopt
> > home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2271 [inline]
> >   __x64_sys_setsockopt+0xb9/0x150
> > home/smyl/linux-image/linux-6.5-rc3/net/socket.c:2271
> >   do_syscall_x64
> > home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:50
> > [inline]
> >   do_syscall_64+0x35/0xb0
> > home/smyl/linux-image/linux-6.5-rc3/arch/x86/entry/common.c:80
> >   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x47959d
> > Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> > 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> > 01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f1c93598068 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> > RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
> > RDX: 0000000000000002 RSI: 0000000000000065 RDI: 0000000000000003
> > RBP: 000000000059c0a0 R08: 0000000000000004 R09: 0000000000000000
> > R10: 00000000200001c0 R11: 0000000000000246 R12: 000000000059c0ac
> > R13: 000000000000000b R14: 0000000000437250 R15: 00007f1c93578000
> >   </TASK>
> >
