Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F967917A1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350977AbjIDMzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239018AbjIDMzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:55:08 -0400
Received: from mail-pj1-f77.google.com (mail-pj1-f77.google.com [209.85.216.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36751AD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 05:55:04 -0700 (PDT)
Received: by mail-pj1-f77.google.com with SMTP id 98e67ed59e1d1-26d1ec91c8aso1478914a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 05:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693832104; x=1694436904;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mSFcZeG/HAdd7KkdAhnr1McNOW5cat4hY9kHmNWPcQs=;
        b=YtlWpsrA8rVaWWTEC0NDUx4EDftad8vcfSnCBHt1+IirBZxD4QJPYLasNjUljSJHGS
         GT4Hdcwqo8YLAWehdFTILckuyueqIkah0S7BY85wZ1XGtr5h7hDWdS+CUaG0KbkDi2Jh
         XisCzA8+9go82rhpol/vG8XbrxpdmRR520rAFyHpabQB682gjeKVldDLeUewJLrsB8Lf
         tyMZPPZRXhzPA9yqSvX8gPwS6IzH3VlpBI2qcgcDB6HGX0qbGoqi+eeOQf8ejIoZJHc4
         oPq6NLpLy5SRrk+vtarnXQOzuKj0mqcv9wb4EBu7A0RpoWP5+BA6I9F4ICgxbgt458Ud
         EGHA==
X-Gm-Message-State: AOJu0YwO980ZHfXDPbhcSDsn/rgS8Rc7GVeAwtw4okV4Fw0S6ndoMzAz
        HV5x2JamC9GQGV5/6jI3ot4DMvbZxfymRjPtmbXOswE6TcBv
X-Google-Smtp-Source: AGHT+IEx2LAnq8FHlS02J/o9Kd6xLAgz2C8d3276StNqbNT0Ni6/XFKrjMGgJm2SridOqCwlyNieo/OkKhS5FQylK6INwyzkHfC9
MIME-Version: 1.0
X-Received: by 2002:a17:903:1d2:b0:1b8:ecd:cb7f with SMTP id
 e18-20020a17090301d200b001b80ecdcb7fmr3510890plh.9.1693832104492; Mon, 04 Sep
 2023 05:55:04 -0700 (PDT)
Date:   Mon, 04 Sep 2023 05:55:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5c8af0604880492@google.com>
Subject: [syzbot] [net?] KASAN: global-out-of-bounds Read in
 macvlan_hard_header (4)
From:   syzbot <syzbot+ae8588da4b5f2e5531d2@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    27e462c8fad4 Merge tag 'xtensa-20230523' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10961ec5280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=927d4df6d674370e
dashboard link: https://syzkaller.appspot.com/bug?extid=ae8588da4b5f2e5531d2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8cc4e9023e9b/disk-27e462c8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0fae37d588a6/vmlinux-27e462c8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d99575c59a4d/bzImage-27e462c8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ae8588da4b5f2e5531d2@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): team1: link becomes ready
==================================================================
BUG: KASAN: global-out-of-bounds in dev_hard_header include/linux/netdevice.h:3134 [inline]
BUG: KASAN: global-out-of-bounds in macvlan_hard_header+0x12f/0x160 drivers/net/macvlan.c:603
Read of size 8 at addr ffffffff90154998 by task kworker/1:0/21074

CPU: 1 PID: 21074 Comm: kworker/1:0 Not tainted 6.4.0-rc3-syzkaller-00015-g27e462c8fad4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
Workqueue: mld mld_ifc_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 dev_hard_header include/linux/netdevice.h:3134 [inline]
 macvlan_hard_header+0x12f/0x160 drivers/net/macvlan.c:603
 dev_hard_header include/linux/netdevice.h:3137 [inline]
 neigh_resolve_output net/core/neighbour.c:1547 [inline]
 neigh_resolve_output+0x4b7/0x870 net/core/neighbour.c:1532
 neigh_output include/net/neighbour.h:544 [inline]
 ip6_finish_output2+0x55a/0x1560 net/ipv6/ip6_output.c:134
 __ip6_finish_output net/ipv6/ip6_output.c:195 [inline]
 ip6_finish_output+0x69a/0x1170 net/ipv6/ip6_output.c:206
 NF_HOOK_COND include/linux/netfilter.h:292 [inline]
 ip6_output+0x1f1/0x540 net/ipv6/ip6_output.c:227
 dst_output include/net/dst.h:458 [inline]
 NF_HOOK include/linux/netfilter.h:303 [inline]
 NF_HOOK include/linux/netfilter.h:297 [inline]
 mld_sendpack+0xa09/0xed0 net/ipv6/mcast.c:1820
 mld_send_cr net/ipv6/mcast.c:2121 [inline]
 mld_ifc_work+0x73c/0xe20 net/ipv6/mcast.c:2653
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

The buggy address belongs to the variable:
 nr_zapped_lock_chains+0x18/0x40

The buggy address belongs to the physical page:
page:ffffea0000405500 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10154
flags: 0xfff00000001000(reserved|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000001000 ffffea0000405508 ffffea0000405508 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffffffff90154880: 00 00 00 00 f9 f9 f9 f9 04 f9 f9 f9 f9 f9 f9 f9
 ffffffff90154900: 04 f9 f9 f9 f9 f9 f9 f9 04 f9 f9 f9 f9 f9 f9 f9
>ffffffff90154980: 00 f9 f9 f9 f9 f9 f9 f9 00 00 00 00 00 00 00 00
                            ^
 ffffffff90154a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffff90154a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
