Return-Path: <linux-kernel+bounces-134808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F252489B738
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9440A1F20F43
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A769C175A4;
	Mon,  8 Apr 2024 05:37:37 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDBBD2F5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 05:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712554657; cv=none; b=cDJAAbLvwffLPFQgtUJhcqCvRhCLkbfq+mQ07hL1w5066oPjRWRkoteBW8DLdGA5iDjE9GF+xO9FrS03xsFyN/RcgSBrr3Y00hpUyQIx1o36CNAQhhueNh2gh07eDKGQY4k9lLGHFw1mLauCbLZI+xP4jGLWnqtGQeHuY8n3qoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712554657; c=relaxed/simple;
	bh=7orIKK4eGfEzSqLflb4IWSPKkAM0kUOStp57b3QXc4Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=l6Yv4kG0fTJQiimrROfzCuRxwckCx9RSE2+Zez1yOVfbwYs6QAuVD5236zw3dRJoB0FL6tCo/3Pp/nGEbnC2+9BejsTdDAu5dPjb3S/NJltRxKltcrLp4QIjlSLCX4EvWmx/HNZPPUfMnbNDYzC5wcw+z+WagzCHBhSI+MP+V5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d5da88bb06so140554339f.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 22:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712554654; x=1713159454;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8QlOzb2AE6faKfI4+Nus3DzT8vtIg4bd+7XP4vimc60=;
        b=vbkjcoiV+K9h4bxexeoWxH6/XjGvnKSozyzDf/ClzG7ifE8UR0zNFtJFOB8H3CJZx/
         ZmXinBwOs5X7hKVFD9m397WrPD5kWtVakfuVxZjg8SQpjAjEtk01yw6rDFtsuL+RDjUl
         ZyubUcvfBMkyPoYBV/Z5wcv4vdozQ8pT7neSazqOZN7a6u4wricFzpYgciebjnm1a/QQ
         rcx/sz8S1Qy1PKMDXGCJifXsC6clCHov91kdhNXRtUytJVxafnwZ+YyHNgsR4oN2hnwd
         UFYSGuc/qIPkjdYyntNOSH7thXtotij4cjsgGO2bcups5S3dgkHZdGfo1Ya8Vtxkaa6g
         ZUDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEavDpCNdvsqxrsZEumsWzbZDuV1n4D4L1OP4hEEqBOBQ061LzdY8OToKlQwqBYxjgtOZSPNsMn6YbwHQFT66HWpg3Niz5it0a085V
X-Gm-Message-State: AOJu0YzrEapRjDHnnvoN5kLSq8bXTEIu/aMnuTTIzzP8VulzbufPCZav
	EVcrYrHHp808DIF0IvNrFwpM/lfSTS+SH778ccXnPdRUJvDq4al+8w45SwFx4W8CrM1n2zFBenN
	sn5js6+h7Lwfo0Y2S9htbEMKs9NwOKSauC45DF7EC6I+mQ+Qcmq8wyAA=
X-Google-Smtp-Source: AGHT+IH7z5sz3i14Oaipl+s9EU2WxauQp9yBHjiX//LHhZsyPP2qjfSo2GfE2ckztbJjEm0fWsaTi6nUByO+pQcf0UacF4uaP+Fc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1501:b0:47f:162f:7060 with SMTP id
 b1-20020a056638150100b0047f162f7060mr273200jat.1.1712554653186; Sun, 07 Apr
 2024 22:37:33 -0700 (PDT)
Date: Sun, 07 Apr 2024 22:37:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c30be606158f33db@google.com>
Subject: [syzbot] [net?] KASAN: global-out-of-bounds Read in __nla_validate_parse
From: syzbot <syzbot+ecd7e07b4be038658c9f@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8568bb2ccc27 Add linux-next specific files for 20240405
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16446339180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48ca5acf8d2eb3bc
dashboard link: https://syzkaller.appspot.com/bug?extid=ecd7e07b4be038658c9f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134f60bd180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1043b303180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d120b5e779c/disk-8568bb2c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a89e3589a585/vmlinux-8568bb2c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/045e657c0e0d/bzImage-8568bb2c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ecd7e07b4be038658c9f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in validate_nla lib/nlattr.c:411 [inline]
BUG: KASAN: global-out-of-bounds in __nla_validate_parse+0x1f1c/0x2f70 lib/nlattr.c:635
Read of size 1 at addr ffffffff8c55d030 by task syz-executor361/5080

CPU: 1 PID: 5080 Comm: syz-executor361 Not tainted 6.9.0-rc2-next-20240405-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 validate_nla lib/nlattr.c:411 [inline]
 __nla_validate_parse+0x1f1c/0x2f70 lib/nlattr.c:635
 __nla_parse+0x40/0x60 lib/nlattr.c:732
 __nlmsg_parse include/net/netlink.h:760 [inline]
 genl_family_rcv_msg_attrs_parse+0x1d1/0x290 net/netlink/genetlink.c:945
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1093 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x802/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2559
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x72/0x7a
RIP: 0033:0x7f831a5c23a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd752ec88 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffcd752ee58 RCX: 00007f831a5c23a9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00007f831a635610 R08: 00007f831a5fda23 R09: 00007ffcd752ee58
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffcd752ee48 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

The buggy address belongs to the variable:
 team_nl_policy+0x30/0x60

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xc55d
flags: 0xfff80000002000(reserved|node=0|zone=1|lastcpupid=0xfff)
raw: 00fff80000002000 ffffea0000315748 ffffea0000315748 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffffffff8c55cf00: f9 f9 f9 f9 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffff8c55cf80: 00 00 00 00 f9 f9 f9 f9 00 00 00 00 f9 f9 f9 f9
>ffffffff8c55d000: 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9 00 00 00 00
                                     ^
 ffffffff8c55d080: 00 00 00 00 00 00 00 00 f9 f9 f9 f9 00 00 00 00
 ffffffff8c55d100: 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9 00 02 f9 f9
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

