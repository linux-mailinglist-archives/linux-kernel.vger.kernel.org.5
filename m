Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B67675DFF9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 07:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjGWFNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 01:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWFNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 01:13:46 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E996F1729
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 22:13:44 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5839f38342fso20961187b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 22:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690089224; x=1690694024;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x1ZfOwaKKKJgIept69Tevl6HvLchA0CxbTdb2gike2M=;
        b=pxxQm9qQCDthyLaFkM+M67s9S6a72jEUDIjRI/e9MbgGPKVc1Y1BWTtK+FV65GJ7Wt
         FryXD7lM5nIYmTMjFoOVUViVqHuV2pYxHAbIEBZ0Wba9jmqDQJmlAlxOdZCGTxBo8Uze
         0pEOm2hCUXw7PmvAUw0wnOpp74MA8U+zxhs/Fja2NCxSvwdfmo4CRJ8AFXeA4oA8GeWI
         ApbaKCNFrWXOXCe4o6lAbcJmwsc+BXLkKXISDHDYZEXqcdizL256eit3SGPFWpoKVzeb
         G6TPPiKdI9lXv44jKW9IdfUmaPfkQLLUaVeWrstN5bnvZnbOfn+05Mor0DUoHncG5+Kb
         CytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690089224; x=1690694024;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1ZfOwaKKKJgIept69Tevl6HvLchA0CxbTdb2gike2M=;
        b=BG9maKJDqTbeEt4fnXFYpBZF4FakuyRq3f2/MBu8lxCh8hBuaovDsMBh0JxI4zOC/N
         yuB1rTgeVqHit/bRzknhARGqpG15ECdPz1qNhB9uWdrY3D4a7iYIOpVEYYjYfOg5ox8P
         9axLBvMB2LDioxLaXW6vHflKvtK2dYNoa9MK3nwAXNREEku85Y6qom+bijNELRxoucex
         2K7AXgP/w7tesJIo88hfK2NnBF2cETp+J21d1MC/jwQttniUm7O9Of3j8t2mFwXcIw/D
         iCi0MvUmabM4M5WMLNrGrq3LXMbbf+SZEuOJV3sLtooIFg5ClTvy5/YqP/wwGwTIyRdw
         qqnQ==
X-Gm-Message-State: ABy/qLYbfPz27bhawFefdT9oVmt0RirstuSdpChaiwXWHB88uZlAIQAA
        zJZDXQ0wuVuqhkMvirFdARmxiXtg+R3icZKH4FKkag==
X-Google-Smtp-Source: APBJJlH6X4eduVGpJ5WiuZoN1aTyV4a+JKpQ8Alq10CcmmIvZLm2NgRfGE0DhMJPr+olvt/nlTFHFA==
X-Received: by 2002:a81:d250:0:b0:577:21ff:4d47 with SMTP id m16-20020a81d250000000b0057721ff4d47mr4509261ywl.7.1690089224020;
        Sat, 22 Jul 2023 22:13:44 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t7-20020a815f07000000b0057a05834754sm2015261ywb.75.2023.07.22.22.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 22:13:43 -0700 (PDT)
Date:   Sat, 22 Jul 2023 22:13:36 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     syzbot <syzbot+fe7b1487405295d29268@syzkaller.appspotmail.com>
cc:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Subject: Re: [syzbot] [mm?] kernel BUG in collapse_file (3)
In-Reply-To: <000000000000f9de430600ae05db@google.com>
Message-ID: <b3df7a8-c7a1-895-4fad-157ec95b8e0@google.com>
References: <000000000000f9de430600ae05db@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023, syzbot wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e32622656258 Add linux-next specific files for 20230713
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16cd037aa80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=55a2f8abfda98f31
> dashboard link: https://syzkaller.appspot.com/bug?extid=fe7b1487405295d29268
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131922e4a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14277fd8a80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d1c2a7ce287f/disk-e3262265.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2041e3e43285/vmlinux-e3262265.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/44f789cdae5d/bzImage-e3262265.xz
> 
> The issue was bisected to:
> 
> commit 49a44d59344d1a6a4cc841d6e4a8727f99ed97bf
> Author: Hugh Dickins <hughd@google.com>
> Date:   Wed Jul 12 04:42:19 2023 +0000
> 
>     mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=105af56aa80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=125af56aa80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=145af56aa80000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+fe7b1487405295d29268@syzkaller.appspotmail.com
> Fixes: 49a44d59344d ("mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()")
> 
> ------------[ cut here ]------------
> kernel BUG at mm/khugepaged.c:1785!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 5058 Comm: syz-executor181 Not tainted 6.5.0-rc1-next-20230713-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
> RIP: 0010:collapse_file+0x1150/0x5510 mm/khugepaged.c:1785
> Code: 89 c6 e8 e3 67 a6 ff 84 db 0f 85 66 f1 ff ff e8 a6 6c a6 ff 0f 0b e9 5a f1 ff ff c6 44 24 48 00 e9 65 f0 ff ff e8 90 6c a6 ff <0f> 0b e8 89 6c a6 ff 4d 85 ed 74 1c e8 7f 6c a6 ff 44 89 eb 31 ff
> RSP: 0018:ffffc90003bff810 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 00000000000000ff RCX: 0000000000000000
> RDX: ffff88807e618000 RSI: ffffffff81df5fb0 RDI: 0000000000000007
> RBP: 0000000777fa80ff R08: 0000000000000007 R09: 0000000000000000
> R10: 00000000000000ff R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: ffff8880227b3680 R15: 0000000777fa7eff
> FS:  00007fdc40a816c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fdc40b169f8 CR3: 00000000278a9000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  hpage_collapse_scan_file+0xc8d/0x1650 mm/khugepaged.c:2285
>  madvise_collapse+0x52c/0xb50 mm/khugepaged.c:2729
>  madvise_vma_behavior+0x200/0x1e60 mm/madvise.c:1094
>  madvise_walk_vmas+0x1c6/0x2b0 mm/madvise.c:1268
>  do_madvise.part.0+0x29c/0x5d0 mm/madvise.c:1448
>  do_madvise mm/madvise.c:1461 [inline]
>  __do_sys_madvise mm/madvise.c:1461 [inline]
>  __se_sys_madvise mm/madvise.c:1459 [inline]
>  __x64_sys_madvise+0x115/0x150 mm/madvise.c:1459
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fdc40ac0399
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fdc40a81238 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> RAX: ffffffffffffffda RBX: 00007fdc40b4a308 RCX: 00007fdc40ac0399
> RDX: 0000000000000019 RSI: 000000000040c101 RDI: 0000000020000000
> RBP: 00007fdc40b4a300 R08: 00007fdc40a816c0 R09: 00007fdc40a816c0
> R10: 00007fdc40a816c0 R11: 0000000000000246 R12: 00007fdc40b4a30c
> R13: 0000000000000000 R14: 00007fffbeb44cf0 R15: 00007fffbeb44dd8
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:collapse_file+0x1150/0x5510 mm/khugepaged.c:1785
> Code: 89 c6 e8 e3 67 a6 ff 84 db 0f 85 66 f1 ff ff e8 a6 6c a6 ff 0f 0b e9 5a f1 ff ff c6 44 24 48 00 e9 65 f0 ff ff e8 90 6c a6 ff <0f> 0b e8 89 6c a6 ff 4d 85 ed 74 1c e8 7f 6c a6 ff 44 89 eb 31 ff
> RSP: 0018:ffffc90003bff810 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 00000000000000ff RCX: 0000000000000000
> RDX: ffff88807e618000 RSI: ffffffff81df5fb0 RDI: 0000000000000007
> RBP: 0000000777fa80ff R08: 0000000000000007 R09: 0000000000000000
> R10: 00000000000000ff R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: ffff8880227b3680 R15: 0000000777fa7eff
> FS:  00007fdc40a816c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fdc40a60d58 CR3: 00000000278a9000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

This was a very helpful report from syzbot (not all of them are, I know ;)

kernel BUG at mm/khugepaged.c:1785! in that tree was the
	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
on coming in to collapse_file().  Which seems an unlikely thing to get
wrong, and I couldn't see why, and the repro did not repro for me.

I wouldn't usually bother to look at the linked bisection log
https://syzkaller.appspot.com/x/bisect.txt?x=105af56aa80000
but in this case it was very instructive.  My first reaction to
the kinds of crash it was showing (__fput, task_work_run, hardly
any in collapse_file) made me think the bisection had gone off course.

But no: they all point to fput(), hence vma->vm_file, and my guilty
commit was blithely setting "mmap_locked = true", without realizing
that that setting is supposed to give guarantees that "vma" has been
revalidated since the mmap_lock was taken - not so.

Patch for mm-unstable follows with some others tomorrow.

Hugh
