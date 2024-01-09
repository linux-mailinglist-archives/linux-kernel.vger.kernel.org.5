Return-Path: <linux-kernel+bounces-21251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CAC828C85
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ACD01F29382
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0603C490;
	Tue,  9 Jan 2024 18:23:26 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80AA3C482
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3607ddfac7eso32945485ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824604; x=1705429404;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJEJRrLrt1LImXCvSuqlzD3XA5p1zoDBQlLofwUGh9s=;
        b=pJKQkxL3Yc7ZLzUCaIQFly2D4cODZm5aRdhOIYjaC42KR/r9v9guv1cDUPJmlzvXOW
         9Hcftr6gdz76NZwa8u3SsDmz0R5oljZx1OAlCHaHHqQ+5pnOaciRvFSvZcEtE54BDrbh
         obcMU/LgMIIag+Q/76fykXzw4233+EG+sPZtEEIlNMD+sH/UA9+zf1rY2jcW8LLh3v5Q
         SrhLp46ypQEY1UUXhW8Zdh/rUlzYV6tOhp7kraNWQoYrQnRFNIN8rpSY73SdekMiN7qp
         Ulpd60Sc9JsD/zU+1z6DvanyuQVcehjsiciugdjlVOIKhheUnjoqz7fAE7g/duk9I0a0
         ywkQ==
X-Gm-Message-State: AOJu0YzEq8pPj5mUYVeF7qNdLTxyOkK81vLdim7q5W78drzXIfZiB4+7
	Dtis/3snBjDu9mUpR/Ex0TeI09HtY91mHTQVC1D2nq84uEki
X-Google-Smtp-Source: AGHT+IGI5i81wz65S2PK1EkPeicNF4Z5I0pxFyxXUjdHnIkap1w8FTz5+a+UyPRgJcrdpOLfrAj2NKo4MHj8caFVZRSXO4CtEwMf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ba2:b0:35f:d4dc:1b1d with SMTP id
 n2-20020a056e021ba200b0035fd4dc1b1dmr756254ili.1.1704824604168; Tue, 09 Jan
 2024 10:23:24 -0800 (PST)
Date: Tue, 09 Jan 2024 10:23:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef988f060e876862@google.com>
Subject: [syzbot] [mm?] WARNING in hpage_collapse_scan_pmd
From: syzbot <syzbot+ed79e0896ae923de13fa@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5eff55d725a4 Merge tag 'platform-drivers-x86-v6.7-7' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17472409e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=655f8abe9fe69b3b
dashboard link: https://syzkaller.appspot.com/bug?extid=ed79e0896ae923de13fa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/496bf4f0c628/disk-5eff55d7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/43482bd7ec93/vmlinux-5eff55d7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fa81d2743202/bzImage-5eff55d7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ed79e0896ae923de13fa@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 35 at arch/x86/include/asm/pgtable.h:403 pte_uffd_wp arch/x86/include/asm/pgtable.h:403 [inline]
WARNING: CPU: 1 PID: 35 at arch/x86/include/asm/pgtable.h:403 hpage_collapse_scan_pmd+0x233e/0x4fe0 mm/khugepaged.c:1309
Modules linked in:
CPU: 1 PID: 35 Comm: khugepaged Not tainted 6.7.0-rc8-syzkaller-00055-g5eff55d725a4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:pte_uffd_wp arch/x86/include/asm/pgtable.h:403 [inline]
RIP: 0010:hpage_collapse_scan_pmd+0x233e/0x4fe0 mm/khugepaged.c:1309
Code: 24 d8 00 00 00 49 81 c6 00 10 00 00 4c 3b b4 24 f0 00 00 00 0f 83 a8 06 00 00 e8 bd 72 9d ff e9 61 fc ff ff e8 b3 72 9d ff 90 <0f> 0b 90 41 bc 09 00 00 00 45 31 f6 e9 45 f4 ff ff e8 9c 72 9d ff
RSP: 0018:ffffc90000abf780 EFLAGS: 00010293
RAX: ffffffff81f1073d RBX: 0000000000000002 RCX: ffff8880142f1dc0
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffc90000abfbf0 R08: ffffffff81f0ea47 R09: 1ffffd400022a006
R10: dffffc0000000000 R11: fffff9400022a007 R12: 00000000203ea000
R13: 1ffff92000157f14 R14: 00000000455eac67 R15: 00000000000001ea
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f942157a038 CR3: 000000008cd03000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 khugepaged_scan_mm_slot mm/khugepaged.c:2415 [inline]
 khugepaged_do_scan mm/khugepaged.c:2503 [inline]
 khugepaged+0x9bf/0x17a0 mm/khugepaged.c:2559
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

