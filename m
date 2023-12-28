Return-Path: <linux-kernel+bounces-12636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E970881F829
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F89AB2393E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E2A748E;
	Thu, 28 Dec 2023 12:16:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792BF7475
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7ba97338185so683069339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 04:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703765764; x=1704370564;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3VZC80qSvzTvlsJvxObYrSm4hc/kYH9lvK/RiDJkXdE=;
        b=ifIpUnyUvJm5HtLMJNGSv7EBIoWIn08ICyz6Jz2/y4wkj8L3MvHAfTcw8bWuDl96hg
         +tgIZ4aPPCs7bbf8gYl8POMwBN1APTrLr1YJuENuCP6E0p4e2OxdvzDdRjihZIYnH6Ip
         Opu0llW0x/cme0XWQE/gL4P9BrygRVy/JSP07NZ5cw6X9SyoC5LWowOpZ2fkqr5BNcDk
         pvdG/wsRzBiNglUh/gnK5gh9eU7wMz8T76DhdDqvw3z9i8czo7bsKb4nUqf8KZxjMlOB
         39TsifVFIzarQxBniGqwmNpzjwBhaDs55aaFv9j0tvoHOx+Tc8imNaAcgkFMA9CH9ldN
         ZbGg==
X-Gm-Message-State: AOJu0Yx13uch1bEtcg8/DNbxYpuUKNAQInBzRa3+hHHh6tSGE0ifCSS7
	NS/GyTEh1GUvzsaQlb5WzbYIWD6O+9ujfMzh3x4Tmydat+be
X-Google-Smtp-Source: AGHT+IGO/2Z9ILExU/3ON0ZaqIpesHk4V6VMPjjooG5HcXey5M+u1wJbYK3FJl/KfPfHzp3KcZMPDjb4bPxbipPRxznYP/g1NEhl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:c80e:0:b0:7b7:fd68:d35b with SMTP id
 y14-20020a5ec80e000000b007b7fd68d35bmr129604iol.0.1703765764703; Thu, 28 Dec
 2023 04:16:04 -0800 (PST)
Date: Thu, 28 Dec 2023 04:16:04 -0800
In-Reply-To: <20231228115625.1757-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f8b56060d90e121@google.com>
Subject: Re: [syzbot] [dri?] WARNING in drm_prime_destroy_file_private (2)
From: syzbot <syzbot+59dcc2e7283a6f5f5ba1@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in drm_prime_destroy_file_private

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5524 at drivers/gpu/drm/drm_prime.c:227 drm_prime_destroy_file_private+0x43/0x60 drivers/gpu/drm/drm_prime.c:227
Modules linked in:
CPU: 0 PID: 5524 Comm: syz-executor.0 Not tainted 6.7.0-rc7-syzkaller-00016-gf5837722ffec-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:drm_prime_destroy_file_private+0x43/0x60 drivers/gpu/drm/drm_prime.c:227
Code: 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 21 48 8b 83 90 00 00 00 48 85 c0 75 06 5b e9 63 ee 93 fc e8 5e ee 93 fc 90 <0f> 0b 90 5b e9 54 ee 93 fc e8 8f 98 ea fc eb d8 66 66 2e 0f 1f 84
RSP: 0018:ffffc900056efd90 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880774dc378 RCX: ffffffff8a70d235
RDX: ffff88801d6dd940 RSI: ffffffff84f38372 RDI: ffff8880774dc408
RBP: ffff8880774dc000 R08: 0000000000000007 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88801ca98000
R13: ffff8880774dc2a8 R14: ffff88801ca98068 R15: ffff88801ca980a0
FS:  00005555562e1480(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555cfd62e950 CR3: 0000000020039000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 drm_file_free.part.0+0x743/0xba0 drivers/gpu/drm/drm_file.c:291
 drm_file_free drivers/gpu/drm/drm_file.c:247 [inline]
 drm_close_helper.isra.0+0x180/0x1f0 drivers/gpu/drm/drm_file.c:308
 drm_release+0x22a/0x4f0 drivers/gpu/drm/drm_file.c:495
 __fput+0x270/0xb70 fs/file_table.c:394
 __fput_sync+0x47/0x50 fs/file_table.c:475
 __do_sys_close fs/open.c:1587 [inline]
 __se_sys_close fs/open.c:1572 [inline]
 __x64_sys_close+0x87/0xf0 fs/open.c:1572
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fb53da7bbda
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007ffe292dcd60 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fb53da7bbda
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fb53db9d980 R08: 0000001b2e960000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000014229
R13: ffffffffffffffff R14: 00007fb53d600000 R15: 0000000000013ee8
 </TASK>


Tested on:

commit:         f5837722 Merge tag 'mm-hotfixes-stable-2023-12-27-15-0..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=173b1a7ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7bcb8f62f1e2c3e
dashboard link: https://syzkaller.appspot.com/bug?extid=59dcc2e7283a6f5f5ba1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17f84d09e80000


