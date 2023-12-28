Return-Path: <linux-kernel+bounces-12688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8979481F8E4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3310B1F2117E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DCCD524;
	Thu, 28 Dec 2023 13:40:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACEFD2E8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7baec3f92acso285570339f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 05:40:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703770805; x=1704375605;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VnUp/W26bWYZFOG8N4I0oRPRqSkbtrh0Jb6WjUy9uac=;
        b=pFbN5Lgwd5jiqZsJHZ6m55s2fM+FxW82ZrfdMWGkbLhrn7pN4HceV2ZaexZGLJgzBr
         ole87mSo+6oJOSVzx8Ht8g3d9G+R0hX8qWXf8LC0NzQ7t655H0XF/SbSCfFSOv9WJT2c
         tZnoO+2UON8F+fVmD0fYT2tcnG3BJI4qyFBidgeUiCm+Bb3MboMpK4xGXW9af6lfCF54
         Y3EN5CCbtKjNKPTqHfvca1oCJLnP+Dqkd20EVdlVjkLwcO097jfpMfVtKgHO9uXAQNlN
         UyZtqo1Uvo4f+DjvyLw08LYzWj6nhp5gNI/r7fSMc9ECdJUgz7dtoA/UmpF5AgOriIhe
         Ifrg==
X-Gm-Message-State: AOJu0YwMiIpLuT38OVYGdiOzT8vTtQHFxS4KeR4UMmOPfxPuwHPfZI2Q
	MnMmJbvwUD+PBJXc8Dj9CKXEU1YXDJJ1rcNtUYKeTQ6NqCWQ
X-Google-Smtp-Source: AGHT+IGhz0NF8zpUeetWEqwFSXFrnld84AQb7S81kxcggxEnG58nzkbpXFkz37qzIJBVKavnS4nxV2pQ/cIhra7SF2qkCf/85HRQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2a4b:b0:7ba:7e99:6664 with SMTP id
 k11-20020a0566022a4b00b007ba7e996664mr138525iov.3.1703770804890; Thu, 28 Dec
 2023 05:40:04 -0800 (PST)
Date: Thu, 28 Dec 2023 05:40:04 -0800
In-Reply-To: <tencent_73B236904A1C74EF77D367E43C4D36669709@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009ab143060d920d51@google.com>
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
 hfsplus_ext_read_extent fs/hfsplus/extents.c:218 [inline]
 hfsplus_file_extend+0x775/0x1b90 fs/hfsplus/extents.c:461
 hfsplus_get_block+0xe99/0x1690 fs/hfsplus/extents.c:245
 __block_write_begin_int+0x946/0x2c70 fs/buffer.c:2119
 __block_write_begin fs/buffer.c:2168 [inline]
 block_write_begin+0x143/0x450 fs/buffer.c:2227
 cont_write_begin+0xd5c/0x12f0 fs/buffer.c:2582
 hfsplus_write_begin+0x9a/0x130 fs/hfsplus/inode.c:52
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

Local variable fd.i created at:
 hfsplus_ext_read_extent fs/hfsplus/extents.c:209 [inline]
 hfsplus_file_extend+0x54b/0x1b90 fs/hfsplus/extents.c:461
 hfsplus_get_block+0xe99/0x1690 fs/hfsplus/extents.c:245

CPU: 0 PID: 5477 Comm: syz-executor.0 Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================


Tested on:

commit:         fbafc3e6 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12e6aeb5e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=55ad87f38795d6787521
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=167e326ee80000


