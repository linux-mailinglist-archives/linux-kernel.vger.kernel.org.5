Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF477FD36D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjK2KA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjK2KA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:00:27 -0500
Received: from mail-pf1-x446.google.com (mail-pf1-x446.google.com [IPv6:2607:f8b0:4864:20::446])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE19219A6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:00:33 -0800 (PST)
Received: by mail-pf1-x446.google.com with SMTP id d2e1a72fcca58-6cc08c794d6so6642804b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:00:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701252033; x=1701856833;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+gLU1PEjcnVbI1lTHXd2F7SerEErbEsGZaA3ZecShs=;
        b=kkY473oUVWAF/NmSXoddU3yTQUegdVzxrpdFN9OTsPzOB7HAGHnAgf+nfneWt/57Lh
         oh9ejwT68dG18lbgsOLL4jWIjheH3qD1gYKNjmeB7mh1h3A17CQujBGHjPkpb5zRmxid
         +go5gOtSJi0KqLWyRNeDeauKLpxLVCmhjRyvCX4/NmgRBw9J+rRoipgmkJJlnBO88wyI
         Olx4HzYOQUYwTUviKhjGv0mVYR2z4XHQfXr1O/aTOwJs9xGNd41F3nAoa/r66Z3MLRkV
         yDuGcd5H51O41qCz1lhgDra5fPr6rvJq4XM1Sf41UzE3R11CWeFi9SXWvtM5Zfr4aPV2
         eKfA==
X-Gm-Message-State: AOJu0YxJHz/+bcgVujLH5NeR7FkBE/SpxyXU5FSh7SFDp6Upvh6TlPL1
        C9UCNgFUza7BFisubw8ETpMaD8XPa68FUZ7MA3Cj5cLTRc3H
X-Google-Smtp-Source: AGHT+IF3hxeemmz5wFyvk36PF448oFL7YPymotkK6RnVTwDH/BeArh47p4VtdfBdC3uuvFnscvGWs5bnEirm9DC6qRkZ6WiXxX/s
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:3a29:b0:6c6:a6f9:a3 with SMTP id
 fj41-20020a056a003a2900b006c6a6f900a3mr4800805pfb.5.1701252033394; Wed, 29
 Nov 2023 02:00:33 -0800 (PST)
Date:   Wed, 29 Nov 2023 02:00:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fc0bf060b479b58@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in ipgre_xmit
From:   syzbot <syzbot+2cb7b1bd08dc77ae7f89@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    18d46e76d7c2 Merge tag 'for-6.7-rc3-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1412e7e8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f711bc2a7eb1db25
dashboard link: https://syzkaller.appspot.com/bug?extid=2cb7b1bd08dc77ae7f89
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cb96093de792/disk-18d46e76.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/630ca4e2d778/vmlinux-18d46e76.xz
kernel image: https://storage.googleapis.com/syzbot-assets/65573a727973/bzImage-18d46e76.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2cb7b1bd08dc77ae7f89@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __gre_xmit net/ipv4/ip_gre.c:469 [inline]
BUG: KMSAN: uninit-value in ipgre_xmit+0xdc2/0xe20 net/ipv4/ip_gre.c:662
 __gre_xmit net/ipv4/ip_gre.c:469 [inline]
 ipgre_xmit+0xdc2/0xe20 net/ipv4/ip_gre.c:662
 __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
 netdev_start_xmit include/linux/netdevice.h:4954 [inline]
 xmit_one net/core/dev.c:3545 [inline]
 dev_hard_start_xmit+0x247/0xa10 net/core/dev.c:3561
 __dev_queue_xmit+0x33b8/0x5130 net/core/dev.c:4346
 dev_queue_xmit include/linux/netdevice.h:3134 [inline]
 __bpf_tx_skb net/core/filter.c:2133 [inline]
 __bpf_redirect_no_mac net/core/filter.c:2163 [inline]
 __bpf_redirect+0xdd7/0x1600 net/core/filter.c:2186
 ____bpf_clone_redirect net/core/filter.c:2457 [inline]
 bpf_clone_redirect+0x328/0x470 net/core/filter.c:2429
 ___bpf_prog_run+0x2180/0xdb80 kernel/bpf/core.c:1958
 __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2199
 bpf_dispatcher_nop_func include/linux/bpf.h:1196 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_test_run+0x482/0xb00 net/bpf/test_run.c:423
 bpf_prog_test_run_skb+0x14e5/0x1f20 net/bpf/test_run.c:1045
 bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4040
 __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5401
 __do_sys_bpf kernel/bpf/syscall.c:5487 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5485 [inline]
 __ia32_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5485
 do_syscall_32_irqs_on arch/x86/entry/common.c:164 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:230
 do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:255
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:293
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
 pskb_expand_head+0x226/0x1a00 net/core/skbuff.c:2098
 skb_ensure_writable+0x3d3/0x460 net/core/skbuff.c:5958
 __bpf_try_make_writable net/core/filter.c:1662 [inline]
 bpf_try_make_writable net/core/filter.c:1668 [inline]
 bpf_try_make_head_writable net/core/filter.c:1676 [inline]
 ____bpf_clone_redirect net/core/filter.c:2451 [inline]
 bpf_clone_redirect+0x17f/0x470 net/core/filter.c:2429
 ___bpf_prog_run+0x2180/0xdb80 kernel/bpf/core.c:1958
 __bpf_prog_run512+0xb5/0xe0 kernel/bpf/core.c:2199
 bpf_dispatcher_nop_func include/linux/bpf.h:1196 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_test_run+0x482/0xb00 net/bpf/test_run.c:423
 bpf_prog_test_run_skb+0x14e5/0x1f20 net/bpf/test_run.c:1045
 bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4040
 __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5401
 __do_sys_bpf kernel/bpf/syscall.c:5487 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5485 [inline]
 __ia32_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5485
 do_syscall_32_irqs_on arch/x86/entry/common.c:164 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:230
 do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:255
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:293
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

CPU: 1 PID: 8859 Comm: syz-executor.2 Not tainted 6.7.0-rc3-syzkaller-00024-g18d46e76d7c2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
=====================================================


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
