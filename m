Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9B58096C5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444135AbjLGXtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjLGXtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:49:07 -0500
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFDD10FC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 15:49:13 -0800 (PST)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6d9dcd6f478so1355817a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 15:49:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701992953; x=1702597753;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrigKMHKQpyIU35ZzmO7oPYfpc0AolhVizWDZj0yiig=;
        b=KVTTAFHYST3saDvDZLlEc8lzfavM5F0shjtXkzhDFPhORtcEeTMobaVfPknicvjVDl
         FK4R8mu68OC2Np3GZhd+GzWSJOjHtahhtBWR6061fbyySliuX6F1q366QAJYzsSMCckn
         +RWeA6z1rDUOnRNNhZQ0+YDh70DctR5H+5VfApjdjLg5qArViVZ+z9+PBVIdy9nyXODq
         O96T+34PLvCKqhaIUPL18V3oAAmR3Pnt9DlUX5Z7RycUo8DWlAeRwOnc4KKPwgPDnwFn
         YgH1r6Pc+nLNTbHln5vXHHsz7KvECyyJOY99huvT7d+AGeJKlx5N8AJuEMHN13k/sZdQ
         Aaww==
X-Gm-Message-State: AOJu0YyGSoWErk2StdTwu0cs6ZPC6GyVhNW02o58jjkKP/LwDxqCd10o
        F8ZQerZuF/b7dr6oH24L+HqOoV7KmUG2XPXNouqm8l5tTDZAY4U=
X-Google-Smtp-Source: AGHT+IEPwb0WlgUfMEURG6BTOKmMGyhAkE0tq0HCzWIr2Y9UAvKl5DN2AsWOGzhbiEytvTXICNbAdg0dZsragh/OcmJUzWMJl2Dr
MIME-Version: 1.0
X-Received: by 2002:a9d:4c8b:0:b0:6d9:d132:c041 with SMTP id
 m11-20020a9d4c8b000000b006d9d132c041mr2098542otf.6.1701992953017; Thu, 07 Dec
 2023 15:49:13 -0800 (PST)
Date:   Thu, 07 Dec 2023 15:49:12 -0800
In-Reply-To: <000000000000cb5b07060bef7ac0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ffc4b060bf41d35@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] WARNING in ip6_route_info_create
From:   syzbot <syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

#syz test: https://github.com/ThinkerYzu/linux.git 
fix-fib6_set_expires_locked

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
