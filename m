Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817A47EB79D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjKNUQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjKNUKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:10:32 -0500
Received: from mail-pg1-f208.google.com (mail-pg1-f208.google.com [209.85.215.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA68118
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 12:10:27 -0800 (PST)
Received: by mail-pg1-f208.google.com with SMTP id 41be03b00d2f7-5be10675134so5885987a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 12:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699992626; x=1700597426;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8OmEtRgexLuao6rUTYjJiY3r0edSaCvPRTeIf9Q3x4Y=;
        b=frR4Y8/dXhV9r8OR4h31+kzef9FAus2QzBznkTJlNGjB6Pct+ugVdKEaHaehWQbYT2
         RejpVkdoiTiFN7Fp8CN9/A1/No1iWFGGDXak3iwplsxMCoS595qw9Fc9znLDI1R/1MAr
         lGooHJecNp/zgjvMxUkhcYBFk+mTLdwK7sbYrOYzx7sl9GprbAb/tPEgrt57rUPaBCgq
         PQo2ZML6o1ILUuEBOgNIt1neoqvlfLLbV/+K7VIU9t7oxt0BWVGBxu69RVCJnYbdFEuK
         NpXpijhqvSzMa/wtSvNOEmXWSFgCgvRMCJqlFes/l9g2K172VHiqbRVhOAYHXQuRb2xo
         qSSg==
X-Gm-Message-State: AOJu0YyduAfg9/1N+LwioOUB2fJGCHqJH4zeBzdZwjwTO97IzJNJN6Tj
        s4XkZtsbtscB+qEEK3JE7D2ZJ6RoyS+6NX4pqmH1LP0KdVpH
X-Google-Smtp-Source: AGHT+IETYdbtUIRvCyXXpYa3AFqr3GveSx+wlGUsWoZqM5BQf1q0ceXvYVfxWA/DSQfm4ey42OtxaYOEc06BLy+8Nm0V40d2HsgW
MIME-Version: 1.0
X-Received: by 2002:a65:6702:0:b0:5bd:579:c5bb with SMTP id
 u2-20020a656702000000b005bd0579c5bbmr893745pgf.4.1699992626605; Tue, 14 Nov
 2023 12:10:26 -0800 (PST)
Date:   Tue, 14 Nov 2023 12:10:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a135c0060a2260b3@google.com>
Subject: [syzbot] [bluetooth?] KASAN: null-ptr-deref Read in ida_free (4)
From:   syzbot <syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9bacdd8996c7 Merge tag 'for-6.7-rc1-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1121f91f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84217b7fc4acdc59
dashboard link: https://syzkaller.appspot.com/bug?extid=51baee846ddab52d5230
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8889f0a9f059/disk-9bacdd89.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f78cb4c03467/vmlinux-9bacdd89.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bb88d4b4f745/bzImage-9bacdd89.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+51baee846ddab52d5230@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: null-ptr-deref in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: null-ptr-deref in ida_free+0x218/0x2e0 lib/idr.c:511
Read of size 8 at addr 0000000000000050 by task kworker/u5:2/5100

CPU: 0 PID: 5100 Comm: kworker/u5:2 Not tainted 6.7.0-rc1-syzkaller-00012-g9bacdd8996c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: hci4 hci_error_reset
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0xef/0x190 mm/kasan/generic.c:187
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 ida_free+0x218/0x2e0 lib/idr.c:511
 hci_conn_cleanup net/bluetooth/hci_conn.c:157 [inline]
 hci_conn_del+0x78c/0xe10 net/bluetooth/hci_conn.c:1182
 hci_conn_hash_flush+0x189/0x260 net/bluetooth/hci_conn.c:2615
 hci_dev_close_sync+0x5a7/0x1160 net/bluetooth/hci_sync.c:5021
 hci_dev_do_close+0x2e/0x90 net/bluetooth/hci_core.c:554
 hci_error_reset+0xa6/0x190 net/bluetooth/hci_core.c:1059
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
==================================================================


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
