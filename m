Return-Path: <linux-kernel+bounces-11023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F3681E02E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49E91C2191E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 11:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1311651C23;
	Mon, 25 Dec 2023 11:44:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C35101A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 11:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fffb6fe5bso9658625ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 03:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703504662; x=1704109462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4B/Y7Xktu4R9H20QOxdF1wSqBgogP+skocSpp48Db4=;
        b=Ty+kV+76CBF8XhEHfIsORltfNuQYukHACcK8zOfuNQip6aoRSZeleAHHZU1HlEiRzO
         FctI2S+q+CqTMbAdDS2tGFfHAoUiznb/7MRU9zADSNm0Ptpb5uSIKQ3q9EZdzXQ2IROd
         uW3+Tmuvu+/UiVVmX1FdmeyZezKmNgtzUWmrCwpaf9EUh3NukoaNAa4NrIdwkKx11vR6
         Y6VWqlr9MnC6o1zHj4dkqQh/NlfCGPOEtbx+PE5cAW1gWzFvcV1wWxnTcyk8ScqyQ3vc
         neYWfHqZsaPBVbnFwiTihmx0wWS91O1pP0YUVOdWRa+pLFulkR5GU2bRP/pHjhO3zIsm
         U0OA==
X-Gm-Message-State: AOJu0YyGT34rmP4VRke7owO41KZB9QCWQrQAg4+E0Gs5xQ7irLNy3jSD
	ofOM3wEEnlQFowJ6GxYPjylbkGlQwjtnt4cOPlfSU5+xEu6n
X-Google-Smtp-Source: AGHT+IHaveJWoksd6OmAz16IH8OBR507StI7t0n1so1emX0Df7n/TSZQvXgA7VDePMLu/+1gNd9nHstYYdygCbudf4IrpUP+2Mr4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c28:b0:35f:9ada:73a8 with SMTP id
 m8-20020a056e021c2800b0035f9ada73a8mr779075ilh.2.1703504662539; Mon, 25 Dec
 2023 03:44:22 -0800 (PST)
Date: Mon, 25 Dec 2023 03:44:22 -0800
In-Reply-To: <000000000000e8099a060cee1003@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048b478060d541670@google.com>
Subject: Re: [syzbot] [perf?] WARNING in perf_event_open
From: syzbot <syzbot+07144c543a5c002c7305@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	netdev@vger.kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5abde6246522 bpf: Avoid unnecessary use of comma operator ..
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=122f1609e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f565e10f0b1e1fc
dashboard link: https://syzkaller.appspot.com/bug?extid=07144c543a5c002c7305
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14857e81e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1126ac36e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a270020a37dc/disk-5abde624.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6b0eb142c0ea/vmlinux-5abde624.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d6ceb3e9bf6a/bzImage-5abde624.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+07144c543a5c002c7305@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5061 at kernel/events/core.c:1950 perf_event_validate_size kernel/events/core.c:1950 [inline]
WARNING: CPU: 0 PID: 5061 at kernel/events/core.c:1950 __do_sys_perf_event_open+0x2748/0x2c70 kernel/events/core.c:12655
Modules linked in:
CPU: 0 PID: 5061 Comm: syz-executor128 Not tainted 6.7.0-rc5-syzkaller-01540-g5abde6246522 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:perf_event_validate_size kernel/events/core.c:1950 [inline]
RIP: 0010:__do_sys_perf_event_open+0x2748/0x2c70 kernel/events/core.c:12655
Code: ff 48 8d b8 a8 00 00 00 e8 55 07 cf 08 bf 01 00 00 00 89 c3 89 c6 e8 47 71 d5 ff 83 eb 01 0f 84 2d ed ff ff e8 c9 75 d5 ff 90 <0f> 0b 90 e9 1f ed ff ff e8 bb 75 d5 ff be 03 00 00 00 48 89 ef e8
RSP: 0018:ffffc9000398fd90 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffffffff RCX: ffffffff81b227c9
RDX: ffff8880794c3b80 RSI: ffffffff81b227d7 RDI: 0000000000000005
RBP: ffff888017e68608 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000000 R11: ffffffff915ec900 R12: ffff888024db5800
R13: 1ffff92000731fbd R14: ffff8880794c3b80 R15: ffff888017e68608
FS:  0000555555ca6380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000006c CR3: 0000000059a59000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fddcf7ef369
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc7c42b4a8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007ffc7c42b688 RCX: 00007fddcf7ef369
RDX: 00000000ffffffff RSI: 0000000000000000 RDI: 0000000020000000
RBP: 00007fddcf862610 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc7c42b678 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

