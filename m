Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72261807873
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379339AbjLFTQk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 14:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379257AbjLFTQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:16:37 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86867193
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 11:16:43 -0800 (PST)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b8b5221627so222292b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 11:16:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701890203; x=1702495003;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJdyL1qosldNhJinnZ5krAx+SwkKAmjHD/rjywWHPNs=;
        b=LcL46xV++ajlPBoj+HtyjU9hqh3p755FI8oEin7okq9PZOthqa1mDthxQfHZYQNzZP
         TYIRa7BZuZk7TaDW72Eh83BRFFtBCMNkXW94nT1DsrXdhobYwj85onOBMppcILLwrgGu
         3PleSm3n5ky7KKieZZ6hmYzDZFbFoVn+TClqEotZhfStyRSKQbx5IDkZ/9nJN3diaSPn
         +7BdyEtUz886af1DdclrlfyYeezZ3HPo386aGykXRhNDuoiwFDAo/LIn8Tji5fPTlGhe
         gE+Gzvmle1QCOkZExOJn8HftmWbyPgAPlE6w7+c3i7YwdIljTqMHXxSk2ywFEd1hpInI
         sKCQ==
X-Gm-Message-State: AOJu0Yy5SasO6O+ppTvDX5fvOkF0nwwEMRFUwbDkrJYeF+o8JCqn/R+w
        jiP8aPAUPeAgIYZWQJKsbFmGztjgx1oQAnj0IFkddf484mHY
X-Google-Smtp-Source: AGHT+IF0Fvc8PYzJWobWyjCuI7gDlX7t1pF3FZDGFFmTj8R2IFPcWfqNwsba4QioHIpnbD+yX6zawRCR0OO3PxWIoobN1rxZP8ku
MIME-Version: 1.0
X-Received: by 2002:a05:6808:180f:b0:3b9:dada:1dbb with SMTP id
 bh15-20020a056808180f00b003b9dada1dbbmr220863oib.10.1701890202917; Wed, 06
 Dec 2023 11:16:42 -0800 (PST)
Date:   Wed, 06 Dec 2023 11:16:42 -0800
In-Reply-To: <CH0PR10MB51135FB61C11679C71E9151B9584A@CH0PR10MB5113.namprd10.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fde085060bdc30ec@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in pagemap_scan_hugetlb_entry
From:   syzbot <syzbot+6e2ccedb96d1174e6a5f@syzkaller.appspotmail.com>
To:     sidhartha.kumar@oracle.com
Cc:     sidhartha.kumar@oracle.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-hotfixes-unstable<https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=mm-hotfixes-unstable>
> ________________________________
> From: syzbot <syzbot+6e2ccedb96d1174e6a5f@syzkaller.appspotmail.com>
> Sent: Saturday, December 2, 2023 6:17 PM
> To: akpm@linux-foundation.org <akpm@linux-foundation.org>; dan.carpenter@linaro.org <dan.carpenter@linaro.org>; linux-fsdevel@vger.kernel.org <linux-fsdevel@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-mm@kvack.org <linux-mm@kvack.org>; llvm@lists.linux.dev <llvm@lists.linux.dev>; Mike Kravetz <mike.kravetz@oracle.com>; muchun.song@linux.dev <muchun.song@linux.dev>; nathan@kernel.org <nathan@kernel.org>; ndesaulniers@google.com <ndesaulniers@google.com>; Sidhartha Kumar <sidhartha.kumar@oracle.com>; syzkaller-bugs@googlegroups.com <syzkaller-bugs@googlegroups.com>; trix@redhat.com <trix@redhat.com>
> Subject: [syzbot] [fs?] general protection fault in pagemap_scan_hugetlb_entry
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    df60cee26a2e Merge tag '6.7-rc3-smb3-server-fixes' of git:..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=17ad46fce80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bb39fe85d254f638
> dashboard link: https://syzkaller.appspot.com/bug?extid=6e2ccedb96d1174e6a5f
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17befd62e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d5a90ce80000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c632017e0dc4/disk-df60cee2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f94c8fa25aeb/vmlinux-df60cee2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/af80f80c708b/bzImage-df60cee2.xz
>
> The issue was bisected to:
>
> commit a08c7193e4f18dc8508f2d07d0de2c5b94cb39a3
> Author: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Date:   Tue Sep 26 19:20:17 2023 +0000
>
>     mm/filemap: remove hugetlb special casing in filemap.c
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f61552e80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=140e1552e80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=100e1552e80000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6e2ccedb96d1174e6a5f@syzkaller.appspotmail.com
> Fixes: a08c7193e4f1 ("mm/filemap: remove hugetlb special casing in filemap.c")
>
> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 0 PID: 5072 Comm: syz-executor107 Not tainted 6.7.0-rc3-syzkaller-00014-gdf60cee26a2e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
> RIP: 0010:pagemap_scan_backout_range fs/proc/task_mmu.c:1946 [inline]
> RIP: 0010:pagemap_scan_hugetlb_entry+0x6ca/0x1130 fs/proc/task_mmu.c:2254
> Code: 3c 02 00 0f 85 68 09 00 00 48 8b 83 80 00 00 00 48 8d 04 40 4d 8d 6c c5 00 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 51 09 00 00 4d 8b 75 00 48 8b 7c 24 08 4c 89 f6
> RSP: 0018:ffffc90003a2fa50 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffffc90003a2fdb0 RCX: ffffffff82111e46
> RDX: 0000000000000000 RSI: ffffffff82111e54 RDI: ffffc90003a2fe30
> RBP: 1ffff92000745f52 R08: 0000000000000006 R09: 0000000020ffc000
> R10: 00000000211f9000 R11: ffffffff915f5de8 R12: ffff8880299e0300
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000020ffc000
> FS:  0000555555c7b380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000005fdeb8 CR3: 00000000752b4000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  walk_hugetlb_range mm/pagewalk.c:326 [inline]
>  __walk_page_range+0x36c/0x770 mm/pagewalk.c:393
>  walk_page_range+0x626/0xa80 mm/pagewalk.c:521
>  do_pagemap_scan+0x40d/0xcd0 fs/proc/task_mmu.c:2437
>  do_pagemap_cmd+0x5e/0x80 fs/proc/task_mmu.c:2478
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:871 [inline]
>  __se_sys_ioctl fs/ioctl.c:857 [inline]
>  __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7f171819d669
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fffbe81bb68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fffbe81bb80 RCX: 00007f171819d669
> RDX: 0000000020000040 RSI: 00000000c0606610 RDI: 0000000000000003
> RBP: 00007f1718210610 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000286 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007fffbe81bdb8 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:pagemap_scan_backout_range fs/proc/task_mmu.c:1946 [inline]
> RIP: 0010:pagemap_scan_hugetlb_entry+0x6ca/0x1130 fs/proc/task_mmu.c:2254
> Code: 3c 02 00 0f 85 68 09 00 00 48 8b 83 80 00 00 00 48 8d 04 40 4d 8d 6c c5 00 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 51 09 00 00 4d 8b 75 00 48 8b 7c 24 08 4c 89 f6
> RSP: 0018:ffffc90003a2fa50 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffffc90003a2fdb0 RCX: ffffffff82111e46
> RDX: 0000000000000000 RSI: ffffffff82111e54 RDI: ffffc90003a2fe30
> RBP: 1ffff92000745f52 R08: 0000000000000006 R09: 0000000020ffc000
> R10: 00000000211f9000 R11: ffffffff915f5de8 R12: ffff8880299e0300
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000020ffc000
> FS:  0000555555c7b380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000005fdeb8 CR3: 00000000752b4000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:   3c 02                    cmp    $0x2,%al
>    2:   00 0f                    add    %cl,(%rdi)
>    4:   85 68 09                 test   %ebp,0x9(%rax)
>    7:   00 00                    add    %al,(%rax)
>    9:   48 8b 83 80 00 00 00     mov    0x80(%rbx),%rax
>   10:   48 8d 04 40              lea    (%rax,%rax,2),%rax
>   14:   4d 8d 6c c5 00           lea    0x0(%r13,%rax,8),%r13
>   19:   48 b8 00 00 00 00 00     movabs $0xdffffc0000000000,%rax
>   20:   fc ff df
>   23:   4c 89 ea                 mov    %r13,%rdx
>   26:   48 c1 ea 03              shr    $0x3,%rdx
> * 2a:   80 3c 02 00              cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
>   2e:   0f 85 51 09 00 00        jne    0x985
>   34:   4d 8b 75 00              mov    0x0(%r13),%r14
>   38:   48 8b 7c 24 08           mov    0x8(%rsp),%rdi
>   3d:   4c 89 f6                 mov    %r14,%rsi
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

Command #1:
"mm-hotfixes-unstable<https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=mm-hotfixes-unstable>" does not look like a valid git branch or commit.

