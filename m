Return-Path: <linux-kernel+bounces-134194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 897B889AEDD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6165B1C21DFA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 06:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBB310A3D;
	Sun,  7 Apr 2024 06:31:25 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7A463B8
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 06:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712471485; cv=none; b=uiPZoOEEEcOj68IJ1SZbiPBZKz63o6ajlNiUk9SSSumviVSP1MfJXrFRe4amqq5OwQEVdAxgF0aIiMhwScEydCPwxUIHIbvIKXL/Z11hw2RDkONIniPwATIE/qHzB+dLXI8LV5SVlFLEAFJT56I0ioUiNfCzM3kGRViJZLAXAd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712471485; c=relaxed/simple;
	bh=HTesZXcUjNNyvUlnldogO3iPcKdf0x2QsJL2/7qoPFM=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=T5sqLvHEtmTgOc9wMY74J/UmfGAr75ZWNd1+H9PdppkMN+pBsHjPTGzNdotHC7WzlympCLiDLoPpSRYat+aglgVaPcoZo5A56MYitRrQ8ri4zdd62UIv/l2EFemcFXBtV9C4yWU2M3FkOeiyFf+qR5C4DDROPnPTYPntF+krOl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VC2NZ1KWrz1h5tn;
	Sun,  7 Apr 2024 14:28:30 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 190871A0172;
	Sun,  7 Apr 2024 14:31:19 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 14:31:18 +0800
Subject: Re: [syzbot] [mtd?] WARNING: zero-size vmalloc in
 ubi_read_volume_table
To: syzbot <syzbot+f516089d7815b10197c9@syzkaller.appspotmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<miquel.raynal@bootlin.com>, <richard@nod.at>,
	<syzkaller-bugs@googlegroups.com>, <vigneshr@ti.com>
References: <000000000000a7f84306150bc9d5@google.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <7badad88-406f-c76b-81d1-acf56b199d5a@huawei.com>
Date: Sun, 7 Apr 2024 14:31:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <000000000000a7f84306150bc9d5@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)

在 2024/4/2 0:50, syzbot 写道:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=10223ae5180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
> dashboard link: https://syzkaller.appspot.com/bug?extid=f516089d7815b10197c9
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13668b21180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a6e21d180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/089e25869df5/disk-fe46a7dd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/423b1787914f/vmlinux-fe46a7dd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4c043e30c07d/bzImage-fe46a7dd.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f516089d7815b10197c9@syzkaller.appspotmail.com
> 
> ubi0: scanning is finished
> ubi0: empty MTD device detected
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5062 at mm/vmalloc.c:3319 __vmalloc_node_range+0x1065/0x1540 mm/vmalloc.c:3319
> Modules linked in:
> CPU: 0 PID: 5062 Comm: syz-executor167 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> RIP: 0010:__vmalloc_node_range+0x1065/0x1540 mm/vmalloc.c:3319
> Code: 48 8b 7d 08 e8 bc db ff ff 48 39 c5 0f 85 f3 02 00 00 e8 5e 9e b2 ff 48 89 ef e8 26 8f 02 00 e9 c2 f9 ff ff e8 4c 9e b2 ff 90 <0f> 0b 90 31 db e8 41 9e b2 ff 48 b8 00 00 00 00 00 fc ff df 4d 8d
> RSP: 0018:ffffc900033df918 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff81da4ac2
> RDX: ffff88801976da00 RSI: ffffffff81da5a64 RDI: 0000000000000007
> RBP: ffffffff85f10bf9 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000000000000 R11: ffffffff8ae00126 R12: 0000000000000000
> R13: 1ffff9200067bf3e R14: 0000000000000000 R15: ffff88802ef1a600
> FS:  000055556b89e380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000045e620 CR3: 0000000022954000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   __vmalloc_node mm/vmalloc.c:3457 [inline]
>   vzalloc+0x6b/0x90 mm/vmalloc.c:3530
>   create_empty_lvol drivers/mtd/ubi/vtbl.c:490 [inline]
>   ubi_read_volume_table+0x639/0x2a30 drivers/mtd/ubi/vtbl.c:812
>   ubi_attach+0x1a2f/0x4af0 drivers/mtd/ubi/attach.c:1601
>   ubi_attach_mtd_dev+0x1659/0x3950 drivers/mtd/ubi/build.c:1000
>   ctrl_cdev_ioctl+0x339/0x3d0 drivers/mtd/ubi/cdev.c:1043
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:904 [inline]
>   __se_sys_ioctl fs/ioctl.c:890 [inline]
>   __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:890
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7fbab2531369
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffcb56bd0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ffcb56bd298 RCX: 00007fbab2531369
> RDX: 0000000020000504 RSI: 0000000040186f40 RDI: 0000000000000003
> RBP: 00007fbab25a4610 R08: 0000000000000000 R09: 00007ffcb56bd298
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffcb56bd288 R14: 0000000000000001 R15: 0000000000000001
>   </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> .
> 

It's weird, commit fe46a7dd189e2("Merge tag 'sound-6.9-rc1' of ..") is 
ahead of commit 68a24aba7c593eaf("ubi: Check for too small LEB size in 
VTBL code") according to 'git log', but 68a24aba7c593eaf("ubi: Check for 
too small LEB size in VTBL code") is not applied after reseting to 
fe46a7dd189e2("Merge tag 'sound-6.9-rc1' of ..").
Whatever, the problem has been fixed by 68a24aba7c593eaf("ubi: Check for 
too small LEB size in VTBL code").


