Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCA97B7729
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 06:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbjJDEht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 00:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjJDEhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 00:37:47 -0400
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B1090
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 21:37:43 -0700 (PDT)
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-57be11d32b3so1985344eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 21:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696394263; x=1696999063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eA9ynp6IVvz/x2Zw0VPL4ysCINyMaEYokEsYRahUM2I=;
        b=ovH/ZQTvHogsnINJ0QNphCaq/VQXlGJFZUfEYgZrj9ov6v2btbnkcS837aaGaEAbMM
         n+dDfRk0bU0wLbO4f3KnzHnQ7pdoV+0x0TMPEwCTLbrPpgjskWPDiOq6Oc73bh/+JWCg
         BbGbPguwEHMhJj/CGkL84x/C7n/nTA7FU6KYlUxhWd9DC3oM8gpCYvWdMUakiqsEX8b8
         s9Pw5rQLX+IawbL6sGEK2K/whk0bOgd80GdAlF+s3rAlpfb5186Z4pxuYFlGFL+QP6zl
         zJAtegWLroLi7z7hJ623+nGe9UtdnyKsjBhny0K26w8mCEiEdr+tY96V9ciVNDqyIrLL
         GcQw==
X-Gm-Message-State: AOJu0YyAjFaSamEOlbMjJgoBX8KFFNS0XwxzUfu98w7viewBuwHSeLaO
        /HBZ0mJUIGkXfD3pFHkQ3+0yViq08MhSe5NjlsntIjrVqJtl
X-Google-Smtp-Source: AGHT+IE+KR4gTXLwNfOsX91U2mVi9Y/4p9Sy1TtNhn5TinZq75hGdtWRfBeHsHIi3nh+4oSnB1ycE/efa/5JpKWh808XbYrtLdPo
MIME-Version: 1.0
X-Received: by 2002:a4a:2c41:0:b0:57b:6b2a:df8 with SMTP id
 o62-20020a4a2c41000000b0057b6b2a0df8mr465051ooo.1.1696394263105; Tue, 03 Oct
 2023 21:37:43 -0700 (PDT)
Date:   Tue, 03 Oct 2023 21:37:43 -0700
In-Reply-To: <0000000000001dd5e20606a0d265@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000739a540606dc9188@google.com>
Subject: Re: [syzbot] [mm?] WARNING in page_vma_mapped_walk
From:   syzbot <syzbot+dcf3f48f4bfe47a2f80a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    c9f2baaa18b5 Add linux-next specific files for 20231003
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17bbfb06680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fe9c462fee1649f
dashboard link: https://syzkaller.appspot.com/bug?extid=dcf3f48f4bfe47a2f80a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1421389a680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12860a7c680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5361e41384fe/disk-c9f2baaa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7028b209124d/vmlinux-c9f2baaa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a167dc667ee5/bzImage-c9f2baaa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dcf3f48f4bfe47a2f80a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5058 at include/linux/hugetlb.h:1289 hugetlb_walk include/linux/hugetlb.h:1289 [inline]
WARNING: CPU: 0 PID: 5058 at include/linux/hugetlb.h:1289 page_vma_mapped_walk+0x1eb6/0x27d0 mm/page_vma_mapped.c:199
Modules linked in:
CPU: 0 PID: 5058 Comm: syz-executor350 Not tainted 6.6.0-rc4-next-20231003-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:hugetlb_walk include/linux/hugetlb.h:1289 [inline]
RIP: 0010:page_vma_mapped_walk+0x1eb6/0x27d0 mm/page_vma_mapped.c:199
Code: 00 be ff ff ff ff 48 81 c7 a0 01 00 00 e8 72 64 77 08 31 ff 89 c5 89 c6 e8 27 ac b9 ff 85 ed 0f 85 95 f6 ff ff e8 aa b0 b9 ff <0f> 0b e9 89 f6 ff ff e8 9e b0 b9 ff 48 89 ef 48 81 e7 00 f0 ff ff
RSP: 0018:ffffc90003a5f6c0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88802184b310 RCX: ffffffff81cea839
RDX: ffff88801d870000 RSI: ffffffff81cea846 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000009 R12: 0000000000200000
R13: ffffffff92315af8 R14: ffffc90003a5f8c0 R15: ffffffff92315b90
FS:  00005555564ba380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 0000000078ecd000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 try_to_migrate_one+0x4a2/0x28b0 mm/rmap.c:1950
 rmap_walk_anon+0x225/0x570 mm/rmap.c:2522
 rmap_walk mm/rmap.c:2599 [inline]
 rmap_walk mm/rmap.c:2594 [inline]
 try_to_migrate+0x2b6/0x300 mm/rmap.c:2251
 unmap_and_move_huge_page mm/migrate.c:1421 [inline]
 migrate_hugetlbs mm/migrate.c:1547 [inline]
 migrate_pages+0xa42/0x27c0 mm/migrate.c:1901
 migrate_to_node mm/mempolicy.c:1097 [inline]
 do_migrate_pages+0x2e9/0x670 mm/mempolicy.c:1196
 kernel_migrate_pages+0x59b/0x780 mm/mempolicy.c:1681
 __do_sys_migrate_pages mm/mempolicy.c:1700 [inline]
 __se_sys_migrate_pages mm/mempolicy.c:1696 [inline]
 __x64_sys_migrate_pages+0x96/0x100 mm/mempolicy.c:1696
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7a6faa32e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed8e03b38 EFLAGS: 00000246 ORIG_RAX: 0000000000000100
RAX: ffffffffffffffda RBX: 00007ffed8e03d18 RCX: 00007f7a6faa32e9
RDX: 0000000020000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: 00007f7a6fb16610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000080 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffed8e03d08 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
