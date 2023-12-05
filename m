Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF172805C81
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjLEQV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjLEQV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:21:26 -0500
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2061A4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:21:31 -0800 (PST)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6d84a96e6e5so6131935a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 08:21:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701793291; x=1702398091;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vzfIo4UwHjmv9AcSp0c+7fZqXTBTtszlVZK70ogcugI=;
        b=iyrzyRvy2OMZFcVZ0opG+bdliUQnVNlMK5MkhJ9DuYiHxt3+Al/PJWHH96H5Og1mNn
         J+xn7nzdJz2jGvDkWe4Y1OxpL63xtAdUFxUmc1DS+a0U7NMqxYWrkB2AUAFehuU6zV3l
         mu02N6QiQFMfanA0/hGlLjQP32Z4qq2HitWNGOVsfy1X14UGShF7TAtIcb6/bTwYDrTu
         WfrkSQcx2w50PuxQsnge0eKPk8ipgdJSrYlKCDvJ3I1EdIsQqov5wQ7OR2rfq1zNNZmr
         tU25upmSyfQ4vpLxZHWXvh1qbDx5ktiFuOOlVTbk2N30zG+smphZgo1YpQ5LvSIz+ett
         ryRg==
X-Gm-Message-State: AOJu0Ywn5L6UAi7Yfkj/WR5Ad+FCRoA5X/CwYRGIUShpxVNa0QUsdIpP
        Ke6BfrCSIGLvq6BQIThb9v3ss7S5T2uAzfwFzkwAnfM9ns/u
X-Google-Smtp-Source: AGHT+IEBnIl+nc2iDQoJp4qY0EVILgvqwTyNqqBJgobjS6yKzxo52U8yGabACkG0EjlHFhjUVC3gEAIaZNq4IzJFPflAJRGJ5hrd
MIME-Version: 1.0
X-Received: by 2002:a05:6871:283:b0:1fa:e182:4123 with SMTP id
 i3-20020a056871028300b001fae1824123mr4990580oae.7.1701793291286; Tue, 05 Dec
 2023 08:21:31 -0800 (PST)
Date:   Tue, 05 Dec 2023 08:21:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009bbd76060bc5a03c@google.com>
Subject: [syzbot] [net?] KCSAN: data-race in data_push_tail / ip6_addr_string
From:   syzbot <syzbot+28e00a6bab865c9c7d46@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d3fa86b1a7b4 Merge tag 'net-6.7-rc3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ee5ad0e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c1151391aefc0c3
dashboard link: https://syzkaller.appspot.com/bug?extid=28e00a6bab865c9c7d46
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/54d04c4835b4/disk-d3fa86b1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b978f8963a3b/vmlinux-d3fa86b1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f8c85c8cd6ce/bzImage-d3fa86b1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+28e00a6bab865c9c7d46@syzkaller.appspotmail.com

ext4 filesystem being mounted at /root/syzkaller-testdir4291713644/syzkaller.zakLwE/4472/file1 supports timestamps until 2038-01-19 (0x7fffffff)
==================================================================
BUG: KCSAN: data-race in data_push_tail / ip6_addr_string

write to 0xffffffff86eb5840 of 1 bytes by task 5346 on cpu 0:
 string_nocheck lib/vsprintf.c:650 [inline]
 ip6_addr_string+0x119/0x1a0 lib/vsprintf.c:1469
 ip_addr_string+0x15f/0x5d0 lib/vsprintf.c:1591
 pointer+0x647/0xd10 lib/vsprintf.c:2444
 vsnprintf+0x861/0xe20 lib/vsprintf.c:2823
 vscnprintf+0x42/0x80 lib/vsprintf.c:2925
 printk_sprint+0x30/0x2d0 kernel/printk/printk.c:2124
 vprintk_store+0x56f/0x800 kernel/printk/printk.c:2238
 vprintk_emit+0xd0/0x5d0 kernel/printk/printk.c:2284
 vprintk_default+0x26/0x30 kernel/printk/printk.c:2318
 vprintk+0x71/0x80 kernel/printk/printk_safe.c:45
 _printk+0x7a/0xa0 kernel/printk/printk.c:2328
 __ip6_tnl_rcv+0x7ee/0x800 net/ipv6/ip6_tunnel.c:848
 ip6_tnl_rcv+0x64/0x80 net/ipv6/ip6_tunnel.c:888
 gre_rcv+0x7b5/0x850
 ip6_protocol_deliver_rcu+0x92f/0xf30 net/ipv6/ip6_input.c:438
 ip6_input_finish net/ipv6/ip6_input.c:483 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip6_input+0xbd/0x1b0 net/ipv6/ip6_input.c:492
 ip6_mc_input+0x34a/0x480 net/ipv6/ip6_input.c:586
 dst_input include/net/dst.h:461 [inline]
 ip6_rcv_finish+0x1e2/0x2e0 net/ipv6/ip6_input.c:79
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ipv6_rcv+0x74/0x150 net/ipv6/ip6_input.c:310
 __netif_receive_skb_one_core net/core/dev.c:5529 [inline]
 __netif_receive_skb+0x90/0x1b0 net/core/dev.c:5643
 netif_receive_skb_internal net/core/dev.c:5729 [inline]
 netif_receive_skb+0x4a/0x310 net/core/dev.c:5788
 tun_rx_batched+0xf0/0x410 drivers/net/tun.c:1555
 tun_get_user+0x1d3f/0x2340 drivers/net/tun.c:2002
 tun_chr_write_iter+0x18e/0x240 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x48a/0x790 fs/read_write.c:584
 ksys_write+0xeb/0x1a0 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __x64_sys_write+0x42/0x50 fs/read_write.c:646
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

read to 0xffffffff86eb5840 of 8 bytes by task 5334 on cpu 1:
 data_make_reusable kernel/printk/printk_ringbuffer.c:590 [inline]
 data_push_tail+0x102/0x430 kernel/printk/printk_ringbuffer.c:675
 data_alloc+0xbe/0x2c0 kernel/printk/printk_ringbuffer.c:1046
 prb_reserve+0x893/0xbc0 kernel/printk/printk_ringbuffer.c:1555
 vprintk_store+0x53e/0x800 kernel/printk/printk.c:2228
 vprintk_emit+0xd0/0x5d0 kernel/printk/printk.c:2284
 vprintk_default+0x26/0x30 kernel/printk/printk.c:2318
 vprintk+0x71/0x80 kernel/printk/printk_safe.c:45
 _printk+0x7a/0xa0 kernel/printk/printk.c:2328
 mnt_warn_timestamp_expiry+0x1bb/0x1f0 fs/namespace.c:2804
 do_new_mount_fc fs/namespace.c:3278 [inline]
 do_new_mount+0x2ee/0x660 fs/namespace.c:3339
 path_mount+0x496/0xb30 fs/namespace.c:3664
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount+0x27f/0x2d0 fs/namespace.c:3863
 __x64_sys_mount+0x67/0x80 fs/namespace.c:3863
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

value changed: 0x000000010000bfe1 -> 0x303a303030303a30

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 5334 Comm: syz-executor.1 Tainted: G        W          6.7.0-rc2-syzkaller-00095-gd3fa86b1a7b4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
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
