Return-Path: <linux-kernel+bounces-2132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB84D81583D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 08:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7F2284610
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 07:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9138418042;
	Sat, 16 Dec 2023 07:29:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D776E17982
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b7139b04eeso191970139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 23:29:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702711745; x=1703316545;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vj6DhcjqDUDop/wYc/5uvjohOIbqrQqTsc0Nc7ZmW8c=;
        b=fEn4z8kdBT/2aRO3x9Is4WxmnMn3It/vnHTAFuGclhJgCt9PRnIFiD1U3hSD3FxmZ2
         sFlIbMoMOs9OD+5eLiJ8FuVElxxMf3HqHC1DNwpCEddQXWSl8I9wD3t8H56gY1XDM4m4
         Jr39VEOx2Z7MUI4R7AsfhkyHUA6xzuFBtV2yfTMs5d2Pj3nBQ5NLvV8SQVlLpAhRU5Sv
         PhJvuxbkbEUa8S3sc0k65JSefgJRe0l1skUVFN2FCsy59ugWHMDyzDoD707CCpMfp7tq
         hiTiRMan8nv6kiabzhsTFcyYKkCAi5SApvKEsKuW3DDdROqFGRNwxGp8StbDDqOj0G1C
         qwZw==
X-Gm-Message-State: AOJu0Yx0S4KPJHt7laXK3+8zXHUlopALe0VE/z7tTOtVFGS5OIt7VEeG
	KCiwIKxX8wAkQmIXx+PtX9Z7uw/x15J4bona2ScKnVC0vASQ
X-Google-Smtp-Source: AGHT+IE563A/6ViG73YMNsDibvmM0rFLRnoYtS6wcjqTD2B/oTvf5w3Me1akQz7DB/CebJ6vRg86RH5dC8mDoAR0PTb5UUxBxDxY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:810c:b0:46b:e82:4120 with SMTP id
 hl12-20020a056638810c00b0046b0e824120mr255904jab.5.1702711744980; Fri, 15 Dec
 2023 23:29:04 -0800 (PST)
Date: Fri, 15 Dec 2023 23:29:04 -0800
In-Reply-To: <tencent_5FFF86C0D2F7065549A1AEC8EEEDCC9EE706@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6ec06060c9b78e0@google.com>
Subject: Re: [syzbot] [block?] general protection fault in bio_first_folio
From: syzbot <syzbot+8b23309d5788a79d3eea@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in bio_first_folio

i: ffffc9000548f810, nr: 8, cn: 32764, bio_map_user_iov
r: -14, b: -14, icn: 32764, bio_map_user_iov
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5485 at include/linux/bio.h:289 bio_first_folio+0x509/0x620 include/linux/bio.h:289
Modules linked in:
CPU: 0 PID: 5485 Comm: syz-executor.0 Not tainted 6.7.0-rc5-next-20231212-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:bio_first_folio+0x509/0x620 include/linux/bio.h:289
Code: fc 41 83 e4 01 4c 89 e6 e8 a4 37 43 fd 4d 85 e4 0f 84 52 fc ff ff e8 06 3c 43 fd 4d 8d 6f ff e9 44 fc ff ff e8 f8 3b 43 fd 90 <0f> 0b 90 e9 c6 fb ff ff e8 ea 3b 43 fd 90 0f 0b 90 e9 47 fb ff ff
RSP: 0018:ffffc9000548f448 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000548f4e8 RCX: ffffffff8444e18d
RDX: ffff88802b971dc0 RSI: ffffffff8444e5c8 RDI: 0000000000000003
RBP: ffff8880216b3088 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff8880216b3000 R14: 0000000000000000 R15: ffff8880216b3000
FS:  00007f2666f3e6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2666f3dc98 CR3: 000000007b2e4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __bio_release_pages+0x9d/0x4b0 block/bio.c:1150
 bio_release_pages include/linux/bio.h:509 [inline]
 bio_map_user_iov+0x969/0xaf0 block/blk-map.c:350
 blk_rq_map_user_iov+0x6a5/0x1840 block/blk-map.c:666
 blk_rq_map_user block/blk-map.c:693 [inline]
 blk_rq_map_user_io+0x202/0x230 block/blk-map.c:726
 sg_io+0x537/0xd70 drivers/scsi/scsi_ioctl.c:456
 scsi_cdrom_send_packet+0x276/0x640 drivers/scsi/scsi_ioctl.c:820
 scsi_ioctl+0x146/0x1840 drivers/scsi/scsi_ioctl.c:903
 sg_ioctl+0xb7b/0x2760 drivers/scsi/sg.c:1163
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f266627cba9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2666f3e0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f266639bf80 RCX: 00007f266627cba9
RDX: 0000000020000000 RSI: 0000000000005393 RDI: 0000000000000004
RBP: 00007f26662c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f266639bf80 R15: 00007fff081ca458
 </TASK>


Tested on:

commit:         abb240f7 Add linux-next specific files for 20231212
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=152a8d1ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc2485c21b49ddc4
dashboard link: https://syzkaller.appspot.com/bug?extid=8b23309d5788a79d3eea
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1175872ae80000


