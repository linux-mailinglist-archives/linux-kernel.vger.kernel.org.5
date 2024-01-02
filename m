Return-Path: <linux-kernel+bounces-14441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91800821D18
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5AF283A7F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E24125D5;
	Tue,  2 Jan 2024 13:50:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5BC125CA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35ff20816f7so85756635ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 05:50:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704203430; x=1704808230;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhJ89AkZ2mQ4piGsbTa90hp+hsirbmIqRZBxh3Kialc=;
        b=nt/q6ZC2lpHq8WAWVrvAqsSy6ozhWOXR4Rud0CctPFhQ02FmFsGeXyalFRP8dVu2M0
         o4nd7ZrMs8CphEPS346dT1VafiPlSJHjyg+djsCFA5h6+zom4947nQfEVUvEZClXadhS
         5cZ2uFsp474xuzXDiiuFra/9+f0Wd9323ri/IrvvdFHEPKSB0h2rk2be47Sw7V5Z3+0a
         lsEZXSAJicsqXa35w64yMMcEan+3+MheBJ6X6c88uIvui+dZeHx4lk8tlujWbXZvISKx
         0qO8lolMPPN3/CtsbLnjiEwCpeOF3HdhtftNCx8lTV7WY7Nh6nMnriy2SQe6QKF3giTn
         3UUg==
X-Gm-Message-State: AOJu0YwNrIEBx5Tw4PNXesbkwkxBi9znr2/ern0J8MQAVJaonFin2JE3
	KxtcdJmECe1nS7OYpGG1Ty5OeW6DaWpqHVa3fm1el8fZmXUj
X-Google-Smtp-Source: AGHT+IHxsCT3t3osXnl1PfZRW9uRbIBaHneHi1+uMWzCQkknaeN03l1sz3/Xic3uQ3oU3aTaPbeNa4aiQVm4z9mH+qkEvoIKD3Bp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:388a:b0:35f:f683:f76a with SMTP id
 cn10-20020a056e02388a00b0035ff683f76amr1598987ilb.3.1704203429980; Tue, 02
 Jan 2024 05:50:29 -0800 (PST)
Date: Tue, 02 Jan 2024 05:50:29 -0800
In-Reply-To: <0000000000005f31a3060de282e6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011afb4060df6c8d4@google.com>
Subject: Re: [syzbot] [nfc?] [net?] KMSAN: uninit-value in nci_ntf_packet
From: syzbot <syzbot+29b5ca705d2e0f4a44d2@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, krzysztof.kozlowski@linaro.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    610a9b8f49fb Linux 6.7-rc8
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15d58055e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e51fe20c3e51ba7f
dashboard link: https://syzkaller.appspot.com/bug?extid=29b5ca705d2e0f4a44d2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1119f31ae80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15649d81e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/28ecdd56de1e/disk-610a9b8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3c5afc17c174/vmlinux-610a9b8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/96ff79b2992d/bzImage-610a9b8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+29b5ca705d2e0f4a44d2@syzkaller.appspotmail.com

nci: nci_rf_discover_ntf_packet: unsupported rf_tech_and_mode 0xff
=====================================================
BUG: KMSAN: uninit-value in nci_rf_discover_ntf_packet net/nfc/nci/ntf.c:386 [inline]
BUG: KMSAN: uninit-value in nci_ntf_packet+0x2ac8/0x39c0 net/nfc/nci/ntf.c:798
 nci_rf_discover_ntf_packet net/nfc/nci/ntf.c:386 [inline]
 nci_ntf_packet+0x2ac8/0x39c0 net/nfc/nci/ntf.c:798
 nci_rx_work+0x213/0x500 net/nfc/nci/core.c:1522
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2700
 worker_thread+0xf45/0x1490 kernel/workqueue.c:2781
 kthread+0x3ed/0x540 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
 __alloc_skb+0x318/0x740 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1286 [inline]
 virtual_ncidev_write+0x6d/0x280 drivers/nfc/virtual_ncidev.c:120
 vfs_write+0x561/0x1490 fs/read_write.c:582
 ksys_write+0x20f/0x4c0 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __x64_sys_write+0x93/0xd0 fs/read_write.c:646
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 4386 Comm: kworker/u4:31 Not tainted 6.7.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: nfc2_nci_rx_wq nci_rx_work
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

