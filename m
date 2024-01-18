Return-Path: <linux-kernel+bounces-29769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACEA83132D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9361C227E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C3CBA38;
	Thu, 18 Jan 2024 07:38:24 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1E29475
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563504; cv=none; b=Mlukc0LH4BIu6BCxuYZOXukYjrnbmPDTpnymOCux8xCYNYDS4dL2OjrogVO7/bVuVafHJMVBl84pg/iySeO86+9FUTACFH+rgSRpP1LX0lXeAD8e0hWY0EMfv4TUTnvWQ2ssK6hou58DiWWOKoGVsutW5MFC1A9L+tm7JpANY5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563504; c=relaxed/simple;
	bh=b7v0ygaP+MzvZkGBhhH54avAWXFWQQ5h+kcdpoBWTzA=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=Q2wHnMX4X7LIspPyeUhr3TQixZt3331tY6I9d13EjNYtT21W8xWbFkhJdQ4jk/BmsiD0fZ1h3+1xeH3reUOqIeCjU+ejhl3WjQvedx0OhPePXrY7Mg90TRRJYpMgzz3HI1lLposmhJaFCnlQUXFDJrcvoAj4bRkHSS1dNnhRSe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3606d19097dso109764515ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 23:38:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705563502; x=1706168302;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3KgbGzjSSpHrnjSlJjwcWcpgEEZshzFZblPbklL8zxM=;
        b=RlEMOyk0qborjSwlhrhXIT/q2kS0RqENbwtAhKABzAaBDyN4+TBDtt2XVZCUuu7vb3
         r3rHp/55qXuk3x3QH2DiyDAq15h3iUMrueREENUMYNEBxQqUnxEBSh0Kg22OmT243k1B
         WzO1i8dhooj95Oy7OD8rXDbtXEaEYGeswFbriNsBErkjVrCVQOX8wB8jZZJvp+haUHJQ
         FpZ4Md3k8FNZTW5/joYjOO5NsENQ9fJSGLH/e9Cg8PKaLyNwa1QxRqVrvmrYzFZQGm3c
         Yvqy6UZM5sb2QFtTU531tx26ok6vtg62Aj/ovQDHqaEV7g/QeH+2MwOXpXr5hUplALJV
         lH/Q==
X-Gm-Message-State: AOJu0YwAT/s61cvuINljWkpBJciJPyppmthXwDwJnyzcN+57X+vir9AT
	E3OFM53xgkVysiygarkAhsar5WI4KadXn005utLDWjrdC8ylcChiPg+sDEcuvz/DB/1oRqNQpIN
	Q1wkQjiz3Gqun188iyvdjOmneWW5UHGAmEb0v3F4jPKAsfAbjPGVd+pU=
X-Google-Smtp-Source: AGHT+IGxoXjwyvReRduhhfN5Fx9iFIHxtLN2VpRgWkKp+o1OATA7CQi7djI5xiY+c/JrIUIufKIj2EysyCa4ubWoTDfMgNWXq1xU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2141:b0:35f:b715:ed36 with SMTP id
 d1-20020a056e02214100b0035fb715ed36mr63785ilv.5.1705563501952; Wed, 17 Jan
 2024 23:38:21 -0800 (PST)
Date: Wed, 17 Jan 2024 23:38:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad0392060f337207@google.com>
Subject: [syzbot] [jfs?] WARNING in dbAdjTree
From: syzbot <syzbot+ab18fa9c959320611727@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=140a08b3e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=36f64072074e3eab
dashboard link: https://syzkaller.appspot.com/bug?extid=ab18fa9c959320611727
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b39935e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d619f5e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/395e14e0d581/disk-052d5343.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d3c73d08be99/vmlinux-052d5343.xz
kernel image: https://storage.googleapis.com/syzbot-assets/80968415c40b/bzImage-052d5343.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d58cff47d922/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=142eec2be80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=162eec2be80000
console output: https://syzkaller.appspot.com/x/log.txt?x=122eec2be80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ab18fa9c959320611727@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 109 at fs/jfs/jfs_dmap.c:2879 dbAdjTree+0x2d9/0x3d0 fs/jfs/jfs_dmap.c:2879
Modules linked in:
CPU: 0 PID: 109 Comm: jfsCommit Not tainted 6.7.0-syzkaller-09928-g052d534373b7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:dbAdjTree+0x2d9/0x3d0 fs/jfs/jfs_dmap.c:2879
Code: e8 4c 13 8d fe 0f b6 14 24 38 da 0f 85 a1 fe ff ff 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 7d 18 8d fe e8 78 18 8d fe 90 <0f> 0b 90 eb e2 e8 0d 8f e4 fe e9 52 fe ff ff e8 03 8f e4 fe e9 79
RSP: 0018:ffffc900020bfa88 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000155 RCX: ffffffff82faf5c9
RDX: ffff8880197f3b80 RSI: ffffffff82faf828 RDI: 0000000000000004
RBP: ffff8880231c4010 R08: 0000000000000004 R09: 0000000000000155
R10: 0000000000030056 R11: ffffffff8acf1fa0 R12: 0000000000000004
R13: 0000000000030056 R14: ffff8880231c4010 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f67c3d5d130 CR3: 000000000cf79000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 dbJoin+0x267/0x2c0 fs/jfs/jfs_dmap.c:2847
 dbFreeBits+0x15c/0x8f0 fs/jfs/jfs_dmap.c:2338
 dbFreeDmap+0x62/0x1a0 fs/jfs/jfs_dmap.c:2087
 dbFree+0x266/0x550 fs/jfs/jfs_dmap.c:409
 txFreeMap+0x9a9/0xe60 fs/jfs/jfs_txnmgr.c:2534
 txUpdateMap+0x3f1/0xd10 fs/jfs/jfs_txnmgr.c:2330
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x5e4/0xb20 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

