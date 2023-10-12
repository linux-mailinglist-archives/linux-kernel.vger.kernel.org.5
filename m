Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508947C7082
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343730AbjJLOlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjJLOls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:41:48 -0400
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644E7BE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:41:46 -0700 (PDT)
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-6c0f174540cso1410148a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697121705; x=1697726505;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0sjLlGIFaUzWitAxPHuaZRKA3VR7ji9H637xkgZgO6c=;
        b=E/fUm/Lv0NkAlbdgi0Hmoe6wteHzT92L8yDxz2RprPOZ2odNiMPbaS2q4ZCMNh1GsA
         guolw1IHpKhvo8Wmri7uVnasyTdA3EEiwoPPKZJ91/ltXdHYPLC9MvaCV9Y2HZff1O/3
         cOPBWKF6MmnhA0nL9Faecop4nEQrYSljAm5mgeh0Pk5XyWdaGNRhtqBD8W+Ulp59GxzY
         O4DLG5eFtvN3rw8EL0fNbuCgDO6HiJgghb/C+p4685q+nTsyiC6D78JrxF3TAgSKQ/PQ
         lFtfWVTHPC+cQcZlSEckggAU5Zd34kX5TXuJRsQQhDmu+uCwSPao2S8vmb5/p70zoGFj
         frnQ==
X-Gm-Message-State: AOJu0Yz8+BOiM42IEB94R2Dsm3xhVKf6tWoEDMDHGgw5sVWiN1uaD/AO
        GqkfECp6aQyd6hqE0xSOR1LdbYx5UQRG0yTIgPw166VZDpDU
X-Google-Smtp-Source: AGHT+IEuSWhLvSImEUWwm/crvQ4RlVw4J+LYSy+BxRn8YVmBQ6p1yaYel6U+3bJr01Qg/7Dbl55VzBv350526S0hwwbsniX3yq6o
MIME-Version: 1.0
X-Received: by 2002:a9d:6394:0:b0:6ba:8e4a:8e62 with SMTP id
 w20-20020a9d6394000000b006ba8e4a8e62mr7059219otk.7.1697121705800; Thu, 12 Oct
 2023 07:41:45 -0700 (PDT)
Date:   Thu, 12 Oct 2023 07:41:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a3d0d060785f027@google.com>
Subject: [syzbot] [net?] [wireless?] WARNING in ieee80211_bss_info_change_notify
 (2)
From:   syzbot <syzbot+dd4779978217b1973180@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    401644852d0b Merge tag 'fs_for_v6.6-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=176b01ad680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32d0b9b42ceb8b10
dashboard link: https://syzkaller.appspot.com/bug?extid=dd4779978217b1973180
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/94b84d66fc32/disk-40164485.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a510b785da4/vmlinux-40164485.xz
kernel image: https://storage.googleapis.com/syzbot-assets/663b784d908b/bzImage-40164485.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd4779978217b1973180@syzkaller.appspotmail.com

------------[ cut here ]------------
wlan1: Failed check-sdata-in-driver check, flags: 0x0
WARNING: CPU: 0 PID: 9044 at net/mac80211/main.c:236 ieee80211_bss_info_change_notify+0x2c9/0x820 net/mac80211/main.c:236
Modules linked in:
CPU: 0 PID: 9044 Comm: syz-executor.2 Not tainted 6.6.0-rc5-syzkaller-00072-g401644852d0b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:ieee80211_bss_info_change_notify+0x2c9/0x820 net/mac80211/main.c:236
Code: 00 00 e8 4a e3 d6 f7 48 8b 74 24 08 48 89 74 24 08 e8 3b e3 d6 f7 8b 14 24 48 c7 c7 c0 a2 c4 8b 48 8b 74 24 08 e8 87 0b 9d f7 <0f> 0b e8 20 e3 d6 f7 4c 89 f2 48 b8 00 00 00 00 00 fc ff df 48 c1
RSP: 0018:ffffc900062472d8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888020030c80 RCX: ffffc90003ec1000
RDX: 0000000000040000 RSI: ffffffff814df0c6 RDI: 0000000000000001
RBP: 0000000000000a00 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff888078ef8e20
R13: ffff8880200328b0 R14: ffff8880200315a0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0063) knlGS:00000000f7f3ab40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f72646b0 CR3: 0000000020d94000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ieee80211_ibss_disconnect+0x411/0x9d0 net/mac80211/ibss.c:726
 ieee80211_ibss_leave+0x16/0x160 net/mac80211/ibss.c:1872
 rdev_leave_ibss net/wireless/rdev-ops.h:569 [inline]
 __cfg80211_leave_ibss+0x1a2/0x410 net/wireless/ibss.c:210
 cfg80211_leave_ibss+0x59/0x80 net/wireless/ibss.c:228
 cfg80211_change_iface+0x457/0xdf0 net/wireless/util.c:1137
 nl80211_set_interface+0x708/0x9b0 net/wireless/nl80211.c:4222
 genl_family_rcv_msg_doit+0x1fc/0x2e0 net/netlink/genetlink.c:971
 genl_family_rcv_msg net/netlink/genetlink.c:1051 [inline]
 genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1066
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1075
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2558
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2612
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2641
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x61/0xe0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7f3f579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7f3a5ac EFLAGS: 00000292 ORIG_RAX: 0000000000000172
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000020000100
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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
