Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422937DF216
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345340AbjKBMPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjKBMP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:15:29 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451E5128
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:15:24 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc411be7e5so73805ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 05:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698927324; x=1699532124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLtki7Tvhg3cfynKI8VTWZvTXZqgVOp4BvlKQ89Tgq8=;
        b=nx2dWg4JKW1Z+S7vA/CUL3Dr683YCAn3GWUPMSmDiM+twLybD1Iqh0Ep69wnQFWn/c
         bKKW27S+xio/zThuHPYf21EAwMK/JhPDpka4h2NKrYsNpty/lvsB5SbRXJ5lyHkwpRr7
         DkxSvoT3UkL9EAQfCemuxXYOS5/+qAUp80PJRCAVEZL2516neqDepX7imUY5/9XhV+mE
         8bs4ERbAdThEvoOHYJxgW39NR9Dc1WvX1QcOO/0yddpQaN4/CpWUpv+YOVuaMkRUxkQB
         q9UAV5bQGItAvhh0/OVXqrkuNz7zg/1qznO0nkvRHUY74xRSx+XG+8Si+uA/fZw3lDYs
         +Lng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698927324; x=1699532124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLtki7Tvhg3cfynKI8VTWZvTXZqgVOp4BvlKQ89Tgq8=;
        b=kHyIL+i3oRxbyBiueYQzvA1RIaJaa4OdgQCiCA/V+tpn+xQ+YPql4WB1RgXNrmr6RG
         ApV9SdtUacvHXWeS1S1Ra1cQ0JNzSE0bwN4hmsJ/xFafa1XFD/GzVSVoZKsWol0tN3fU
         Fq7gFFb+25AkjZ3YufvfVTmJEcGs6MyrW7LlXQYQX0ESuHg5Gvc5yirD0tn8Z99VLMFc
         Crie0gYpBCNXPz8rDJkBBUbeAnFzTjNuaDjZZITKKmoxmG7BxicWt02pLIOESM2cFkWe
         EdVDoYjvS3eX1cdiTNoeS+w6OBEIGhBUFB71eiybPPeFSATdUpp8//U08Lb5EApqIGPy
         yZKQ==
X-Gm-Message-State: AOJu0YyT6riMIeYRnmE3JADmZX7eHbG/57LF/WYuE3hCKviHAthfQBCR
        hzYJzLDdVTZUKApBY8ESjBCHU4+E/kFV+o2EYFO2KA==
X-Google-Smtp-Source: AGHT+IGwx2rPuQQagIfl/7Tfoni/vWt4ouxXSpYmUpUnYMQOYasHa7WI2v13oUvPw5v+Me6ibxgqoaXuJZQNUf3jy+0=
X-Received: by 2002:a17:902:c254:b0:1bc:8e52:575b with SMTP id
 20-20020a170902c25400b001bc8e52575bmr106919plg.6.1698927323440; Thu, 02 Nov
 2023 05:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000078d1e00608d7878b@google.com> <bce5df0508221ab30a1fb121a219034631abedf5.camel@surriel.com>
In-Reply-To: <bce5df0508221ab30a1fb121a219034631abedf5.camel@surriel.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 2 Nov 2023 13:15:11 +0100
Message-ID: <CANp29Y6TXkZzRLCFWRMQ6ORSz+hK5qQ2DaF7esNsLnZ0c2BcMA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] general protection fault in hugetlb_vma_lock_write
To:     Rik van Riel <riel@surriel.com>
Cc:     syzbot <syzbot+6ada951e7c0f7bc8a71e@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 7:39=E2=80=AFPM Rik van Riel <riel@surriel.com> wro=
te:
>
> On Sun, 2023-10-29 at 02:27 -0700, syzbot wrote:
> >
> > commit bf4916922c60f43efaa329744b3eef539aa6a2b2
> > Author: Rik van Riel <riel@surriel.com>
> > Date:   Fri Oct 6 03:59:07 2023 +0000
> >
> >     hugetlbfs: extend hugetlb_vma_lock to private VMAs
> >
>
> I've been trying to reproduce the issue here, but the test
> case has been running for 4+ hours now on a KVM guest, with
> KASAN and CONFIG_PROVE_LOCKING enabled. No crashes yet.

FWIW you may also try to use the syzbot-built kernel shared via the
"Downloadable assets" section[1]. I've just run the C repro against it
and it crashed immediately.

[   66.222816][ T5095] general protection fault, probably for
non-canonical address 0xdffffc000000001d: 0000 [#1] PREEMPT SMP KASAN
[   66.227224][ T5095] KASAN: null-ptr-deref in range
[0x00000000000000e8-0x00000000000000ef]
[   66.230109][ T5095] CPU: 0 PID: 5095 Comm: repro Not tainted
6.6.0-rc7-syzkaller-00142-g888cf78c29e2 #0

[1] Here are the instructions with commands to copy-paste:
https://github.com/google/syzkaller/blob/master/docs/syzbot_assets.md

--=20
Aleksandr

>
> I'll try adapting the config file from syzkaller so the
> resulting kernel boots here, but this is not looking like
> an easy reproducer so far...
>
> The crash is also confusing me somewhat, because it looks
> like hugetlb_vma_lock_write() is passing a nonsense (very small
> value) resv_map->rw_sema pointer down to down_write, but the
> code has some protection against that:
>
> static inline bool __vma_private_lock(struct vm_area_struct *vma)
> {
>         return (!(vma->vm_flags & VM_MAYSHARE)) && vma-
> >vm_private_data;
> }
>
> void hugetlb_vma_lock_write(struct vm_area_struct *vma)
> {
>         if (__vma_shareable_lock(vma)) {
>                 struct hugetlb_vma_lock *vma_lock =3D vma-
> >vm_private_data;
>
>                 down_write(&vma_lock->rw_sema);
>         } else if (__vma_private_lock(vma)) {
>                 struct resv_map *resv_map =3D vma_resv_map(vma);
>
>                 down_write(&resv_map->rw_sema);
>         }
> }
>
> At fork time, vma->vm_private_data gets cleared in the child
> process for MAP_PRIVATE hugetlb VMAs.
>
> I do not see anything that would leave behind a tiny, but
> non-zero value in that pointer.
>
> I'll keep poking at this, but I don't know if it will
> reproduce here.
>
> > general protection fault, probably for non-canonical address
> > 0xdffffc000000001d: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: null-ptr-deref in range [0x00000000000000e8-
> > 0x00000000000000ef]
> > CPU: 0 PID: 5048 Comm: syz-executor139 Not tainted 6.6.0-rc7-
> > syzkaller-00142-g888cf78c29e2 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine,
> > BIOS Google 10/09/2023
> > RIP: 0010:__lock_acquire+0x109/0x5de0 kernel/locking/lockdep.c:5004
> > Code: 45 85 c9 0f 84 cc 0e 00 00 44 8b 05 c1 1e 42 0b 45 85 c0 0f 84
> > be 0d 00 00 48 ba 00 00 00 00 00 fc ff df 4c 89 d1 48 c1 e9 03 <80>
> > 3c 11 00 0f 85 e8 40 00 00 49 81 3a a0 d9 5f 90 0f 84 96 0d 00
> > RSP: 0018:ffffc90003aa7798 EFLAGS: 00010016
> >
> > RAX: ffff88807a0b9dc0 RBX: 1ffff92000754f23 RCX: 000000000000001d
> > RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 00000000000000e8
> > RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
> > R10: 00000000000000e8 R11: 0000000000000000 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > FS:  0000000000000000(0000) GS:ffff8880b9800000(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020000280 CR3: 00000000758bf000 CR4: 0000000000350ef0
> > Call Trace:
> >  <TASK>
> >  lock_acquire kernel/locking/lockdep.c:5753 [inline]
> >  lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
> >  down_write+0x93/0x200 kernel/locking/rwsem.c:1573
> >  hugetlb_vma_lock_write mm/hugetlb.c:300 [inline]
> >  hugetlb_vma_lock_write+0xae/0x100 mm/hugetlb.c:291
> >  __hugetlb_zap_begin+0x1e9/0x2b0 mm/hugetlb.c:5447
> >  hugetlb_zap_begin include/linux/hugetlb.h:258 [inline]
> >  unmap_vmas+0x2f4/0x470 mm/memory.c:1733
> >  exit_mmap+0x1ad/0xa60 mm/mmap.c:3230
> >  __mmput+0x12a/0x4d0 kernel/fork.c:1349
> >  mmput+0x62/0x70 kernel/fork.c:1371
> >  exit_mm kernel/exit.c:567 [inline]
> >  do_exit+0x9ad/0x2a20 kernel/exit.c:861
> >  __do_sys_exit kernel/exit.c:991 [inline]
> >  __se_sys_exit kernel/exit.c:989 [inline]
> >  __x64_sys_exit+0x42/0x50 kernel/exit.c:989
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7ff2b7a78ab9
> > Code: Unable to access opcode bytes at 0x7ff2b7a78a8f.
> > RSP: 002b:00007fff926ea6b8 EFLAGS: 00000246 ORIG_RAX:
> > 000000000000003c
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff2b7a78ab9
> > RDX: 00007ff2b7ab23f3 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: 000000000000cfda R08: 0000000000000000 R09: 0000000000000006
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff926ea6cc
> > R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:__lock_acquire+0x109/0x5de0 kernel/locking/lockdep.c:5004
> > Code: 45 85 c9 0f 84 cc 0e 00 00 44 8b 05 c1 1e 42 0b 45 85 c0 0f 84
> > be 0d 00 00 48 ba 00 00 00 00 00 fc ff df 4c 89 d1 48 c1 e9 03 <80>
> > 3c 11 00 0f 85 e8 40 00 00 49 81 3a a0 d9 5f 90 0f 84 96 0d 00
> > RSP: 0018:ffffc90003aa7798 EFLAGS: 00010016
> > RAX: ffff88807a0b9dc0 RBX: 1ffff92000754f23 RCX: 000000000000001d
> > RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 00000000000000e8
> > RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
> > R10: 00000000000000e8 R11: 0000000000000000 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > FS:  0000000000000000(0000) GS:ffff8880b9800000(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020000280 CR3: 00000000758bf000 CR4: 0000000000350ef0
> > ----------------
> > Code disassembly (best guess):
> >    0:   45 85 c9                test   %r9d,%r9d
> >    3:   0f 84 cc 0e 00 00       je     0xed5
> >    9:   44 8b 05 c1 1e 42 0b    mov    0xb421ec1(%rip),%r8d        #
> > 0xb421ed1
> >   10:   45 85 c0                test   %r8d,%r8d
> >   13:   0f 84 be 0d 00 00       je     0xdd7
> >   19:   48 ba 00 00 00 00 00    movabs $0xdffffc0000000000,%rdx
> >   20:   fc ff df
> >   23:   4c 89 d1                mov    %r10,%rcx
> >   26:   48 c1 e9 03             shr    $0x3,%rcx
> > * 2a:   80 3c 11 00             cmpb   $0x0,(%rcx,%rdx,1) <--
> > trapping instruction
> >   2e:   0f 85 e8 40 00 00       jne    0x411c
> >   34:   49 81 3a a0 d9 5f 90    cmpq   $0xffffffff905fd9a0,(%r10)
> >   3b:   0f                      .byte 0xf
> >   3c:   84                      .byte 0x84
> >   3d:   96                      xchg   %eax,%esi
> >   3e:   0d                      .byte 0xd
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > For information about bisection process see:
> > https://goo.gl/tpsmEJ#bisection
> >
> > If the bug is already fixed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before
> > testing.
> >
> > If you want to overwrite bug's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the bug is a duplicate of another bug, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
> >
>
> --
> All Rights Reversed.
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/bce5df0508221ab30a1fb121a219034631abedf5.camel%40surriel.c=
om.
