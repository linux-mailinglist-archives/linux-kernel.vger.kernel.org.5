Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F52B8096A4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444112AbjLGXfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLGXfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:35:48 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AFD10F9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 15:35:54 -0800 (PST)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b88ac1f09cso2215188b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 15:35:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701992153; x=1702596953;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha8+uz3XjUF+u+/Y0TTlhSZdV8z05W8j1Eeh5lT0EKk=;
        b=LQ4DMj7ZK9/bJEckxA4kKRdvGBn0lrxqwrvS2ytPl57/W3vEcmk7W60Gz1mlgaDa7H
         xkC5Ge9Kkvp2CrFpquA2teu9p9PX6+oFUVnWP8CUQzocrb/JGQ3dr1iaXU/WETS49WDY
         /XQamJf0EJ6JvGrJ+Ey3HZ/OxUMT82LrsHwiLlANwpK7fIpONftQ0xDLyMiutcRdahw9
         WzIIHrIyVX9xFqyyXNqlpORHj1TXru9SQDrjPrqt2p7pK7+FggwokKlkabBUC/ZdrWtV
         cvlDv4ZQBJVuiE2USPAaeiT8KnUA7nNKT1J/1k9sCLkq/J+Kepgdps72Qj9AIhNq3PTh
         aYag==
X-Gm-Message-State: AOJu0Yx1ghDvFtta8mRacp/+3KoGtvYI2YvOJndpwLbpQI61hJJdw+My
        iriqxISoXolfsEUsTupThLifYEX0dDFXAbnVUcOpcY7ngAPZGJA=
X-Google-Smtp-Source: AGHT+IEXxKSaUHt7IwS5YCNDlCca0WAwNyLE2fhKLS7hZlQwns/MZ8aUPB9yXDacnnszeclOMxxb6Lu6ObRmWk/5b0ZNv6h8kR+h
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2118:b0:3b9:e48f:d659 with SMTP id
 r24-20020a056808211800b003b9e48fd659mr1141532oiw.3.1701992153348; Thu, 07 Dec
 2023 15:35:53 -0800 (PST)
Date:   Thu, 07 Dec 2023 15:35:53 -0800
In-Reply-To: <000000000000cb5b07060bef7ac0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b600cc060bf3ed15@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] WARNING in ip6_route_info_create
From:   syzbot <syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] WARNING in ip6_route_info_create
Author: sinquersw@gmail.com


#syz test: git@github.com:ThinkerYzu/linux.git fix-fib6_set_expires_locked

On 12/7/23 10:17, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5a08d0065a91 ipv6: add debug checks in fib6_info_release()
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=175698dae80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f8715b6ede5c4b90
> dashboard link: https://syzkaller.appspot.com/bug?extid=c15aa445274af8674f41
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16070374e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145e1574e80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/12a59d7df47f/disk-5a08d006.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/14f0ca0a861e/vmlinux-5a08d006.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ae9306decbe5/bzImage-5a08d006.xz
> 
> The issue was bisected to:
> 
> commit 5a08d0065a915ccf325563d7ca57fa8b4897881c
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Tue Dec 5 17:32:50 2023 +0000
> 
>      ipv6: add debug checks in fib6_info_release()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1137437ae80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1337437ae80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1537437ae80000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
> Fixes: 5a08d0065a91 ("ipv6: add debug checks in fib6_info_release()")
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5062 at include/net/ip6_fib.h:332 fib6_info_release include/net/ip6_fib.h:332 [inline]
> WARNING: CPU: 0 PID: 5062 at include/net/ip6_fib.h:332 ip6_route_info_create+0x1a1a/0x1f10 net/ipv6/route.c:3829
> Modules linked in:
> CPU: 0 PID: 5062 Comm: syz-executor399 Not tainted 6.7.0-rc3-syzkaller-00805-g5a08d0065a91 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
> RIP: 0010:fib6_info_release include/net/ip6_fib.h:332 [inline]
> RIP: 0010:ip6_route_info_create+0x1a1a/0x1f10 net/ipv6/route.c:3829
> Code: 49 83 7f 40 00 75 28 e8 04 ae 50 f8 49 8d bf a0 00 00 00 48 c7 c6 c0 ae 37 89 e8 41 2c 3a f8 e9 65 f4 ff ff e8 e7 ad 50 f8 90 <0f> 0b 90 eb ad e8 dc ad 50 f8 90 0f 0b 90 eb cd e8 d1 ad 50 f8 e8
> RSP: 0018:ffffc900039cf8e0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000400000 RCX: ffffffff8936e418
> RDX: ffff888014695940 RSI: ffffffff8936e469 RDI: 0000000000000005
> RBP: ffffc900039cf9d0 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000400000 R11: ffffffff8aa0008b R12: ffffffffffffffed
> R13: ffff88802560682c R14: ffffc900039cfac4 R15: ffff888025606800
> FS:  00005555567bb380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000200001c2 CR3: 00000000793d5000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   ip6_route_add+0x26/0x1f0 net/ipv6/route.c:3843
>   ipv6_route_ioctl+0x3ff/0x590 net/ipv6/route.c:4467
>   inet6_ioctl+0x265/0x2b0 net/ipv6/af_inet6.c:575
>   sock_do_ioctl+0x113/0x270 net/socket.c:1220
>   sock_ioctl+0x22e/0x6b0 net/socket.c:1339
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:871 [inline]
>   __se_sys_ioctl fs/ioctl.c:857 [inline]
>   __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
>   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>   do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
>   entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7f73fa33f369
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffce78f30b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ffce78f3288 RCX: 00007f73fa33f369
> RDX: 00000000200001c0 RSI: 000000000000890b RDI: 0000000000000003
> RBP: 00007f73fa3b2610 R08: 0000000000000000 R09: 00007ffce78f3288
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffce78f3278 R14: 0000000000000001 R15: 0000000000000001
>   </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 
