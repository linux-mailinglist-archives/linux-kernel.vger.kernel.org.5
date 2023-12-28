Return-Path: <linux-kernel+bounces-12717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA47281F93E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC9B1C21DD9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEA6E573;
	Thu, 28 Dec 2023 14:51:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351A0DF4C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b7ce620dd9so1103436239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 06:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703775063; x=1704379863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PG9LUGF9Vse+PguLP1b4EV9x4i5dkt3ZXA90EInzl38=;
        b=FgIj0t6/uteZtOnmYMhuWT43BDwJ1aPoQFKEyQV2MoiTGUl445Hf6CdtdDvpiXtFXo
         WfQ9XzW7UUFqrR4nTpp06I0D8FHAlx4/rw61v7UKrCQb/LQuCaEmtcXtUdQS5VVaz2+P
         wk83cAAjQA5veF+w+sJzxgMq+ODm6kVUzCbd+/O4eNSILYZRNy7GHNdieWxqH31zJPp4
         mZpzhPZ1RMZ6IgnF1jNakgDE2WTfkQ9mcazPRxQiPjlc46U+31KPKFlIh6Z7NUAi3VQj
         h6bKm+frdNMF3JQAaNfQSVAs51a4aYyg5FSwJyeEnIBCjC95RXV08eNa5KiRuJJOgCZk
         VN1w==
X-Gm-Message-State: AOJu0Yz1Zv9vnS2hwYHQLlL07ZgOKQDXIFCNmdEjlc52j16hvexrUesu
	HNjgSFsWp6phvGJ/yHY6RpEU6geV+afssiCl0bcLoqtJGmNR
X-Google-Smtp-Source: AGHT+IED0iWN/rYTDTrwY/tVmEFKbZhyd6/YjL5LCGhaZsuLn7eDxaTx8TbFRWT7p6ZSGA4PyM9OAENEGa7Q+O6ybTerRCaMfrbF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2d:b0:35f:f683:f817 with SMTP id
 g13-20020a056e021a2d00b0035ff683f817mr981073ile.5.1703775063387; Thu, 28 Dec
 2023 06:51:03 -0800 (PST)
Date: Thu, 28 Dec 2023 06:51:03 -0800
In-Reply-To: <tencent_0EAD9E2C1B704B1D1B102519BA6EBB593308@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e3966060d930b7c@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in __hfsplus_ext_cache_extent
From: syzbot <syzbot+55ad87f38795d6787521@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in __hfsplus_ext_cache_extent

loop0: detected capacity change from 0 to 1024
=====================================================
BUG: KMSAN: uninit-value in __hfsplus_ext_read_extent fs/hfsplus/extents.c:170 [inline]
BUG: KMSAN: uninit-value in __hfsplus_ext_cache_extent+0x851/0x960 fs/hfsplus/extents.c:191
 __hfsplus_ext_read_extent fs/hfsplus/extents.c:170 [inline]
 __hfsplus_ext_cache_extent+0x851/0x960 fs/hfsplus/extents.c:191
 hfsplus_file_truncate+0x730/0xf50 fs/hfsplus/extents.c:598
 hfsplus_write_failed+0xab/0x100 fs/hfsplus/inode.c:42
 hfsplus_write_begin+0x12e/0x130 fs/hfsplus/inode.c:56
 generic_perform_write+0x3f5/0xc40 mm/filemap.c:3918
 __generic_file_write_iter+0x20a/0x460 mm/filemap.c:4013
 generic_file_write_iter+0x103/0x5b0 mm/filemap.c:4039
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x8ef/0x1490 fs/read_write.c:584
 ksys_write+0x20f/0x4c0 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __x64_sys_write+0x93/0xd0 fs/read_write.c:646
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable fd created at:
 hfsplus_file_truncate+0x5d/0xf50 fs/hfsplus/extents.c:547
 hfsplus_write_failed+0xab/0x100 fs/hfsplus/inode.c:42

CPU: 0 PID: 5485 Comm: syz-executor.0 Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================


Tested on:

commit:         fbafc3e6 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16e5645ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=55ad87f38795d6787521
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=129e0a91e80000


