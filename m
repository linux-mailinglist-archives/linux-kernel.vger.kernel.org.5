Return-Path: <linux-kernel+bounces-11778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD1681EB92
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC2D1F212B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAC13C30;
	Wed, 27 Dec 2023 02:42:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068E93C0C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 02:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7baffaff3b2so86560339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 18:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703644923; x=1704249723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6P9L7y0asDKGf8pZddjaTG7snD4Ne3ky3gaGFzp0k8=;
        b=hd+D2eqhPjFix2jwJe65Pusg9EklK2MRpzMIqKjyoXbBLLvotFQvpV5ImT9waeKv4H
         lph8/wdmcrvnNDJr1ce6OCjCqWoDFiyNwfFSo+7U1Zt0yxRCb0uJiRiPlGfAN3V4omp0
         ZjZJVIGyWXt0iydVrDGzEGSXa90Yd5gHRaGbDcHV37J2Tn0qbuZhUVWZQkeKh8nZLiCa
         Zbp39bgmycYokwkZH1kBBUrh97l4CWeN6Pq74mR3qoz9eP9VP/rYXMlU9Vh2jxSJHcA8
         L0Cf8/oEBdQ9NrdqeQEzvGxudqODfxqlfj/kOOLaHvSFSL2yWC46VoPqhryeMtJ+bdep
         X0xw==
X-Gm-Message-State: AOJu0YwtfPZJ5qvq3E80yjg3HVhYjtThRwcBL7t/olMBTUu7/RqETFcf
	pRVd3Z+FATKAm3qHX38GCkX2o2Lv4ar17PL011qejeSk2vXl
X-Google-Smtp-Source: AGHT+IFLi3PbcdDp2Gb9LIrtNvAWVfHAj0MOtIxuVVVJFLY+YkzTK9I6w57EtqXdQrLMClikMbq0dXik51O5jSiy3n+vJQ+k9qz0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2048:b0:46c:f159:5a8b with SMTP id
 t8-20020a056638204800b0046cf1595a8bmr236067jaj.6.1703644923155; Tue, 26 Dec
 2023 18:42:03 -0800 (PST)
Date: Tue, 26 Dec 2023 18:42:03 -0800
In-Reply-To: <tencent_FF866D3C2E416D7494ACE9BEED56CD88780A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077e083060d74beac@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in
 scatterwalk_copychunks (5)
From: syzbot <syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in scatterwalk_copychunks

general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 5477 Comm: syz-executor.0 Not tainted 6.7.0-rc6-next-20231222-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:scatterwalk_start include/crypto/scatterwalk.h:63 [inline]
RIP: 0010:scatterwalk_pagedone include/crypto/scatterwalk.h:83 [inline]
RIP: 0010:scatterwalk_pagedone include/crypto/scatterwalk.h:72 [inline]
RIP: 0010:scatterwalk_copychunks+0x3e0/0x560 crypto/scatterwalk.c:50
Code: f0 48 c1 e8 03 80 3c 08 00 0f 85 81 01 00 00 49 8d 44 24 08 4d 89 26 48 bf 00 00 00 00 00 fc ff df 48 89 44 24 10 48 c1 e8 03 <0f> b6 04 38 84 c0 74 08 3c 03 0f 8e 47 01 00 00 48 8b 44 24 08 41
RSP: 0018:ffffc9000557ecf0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: ffff88807fc6d940 RSI: ffffffff8465df94 RDI: dffffc0000000000
RBP: 0000000000001000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000002 R11: 82d8bd1b6060f805 R12: 0000000000000000
R13: 0000000000000014 R14: ffffc9000557ed88 R15: 0000000000001000
FS:  00007ff79da616c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff79cd98000 CR3: 0000000021251000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 scatterwalk_map_and_copy+0x151/0x1d0 crypto/scatterwalk.c:67
 scomp_acomp_comp_decomp+0x3a3/0x780 crypto/scompress.c:149
 crypto_acomp_compress include/crypto/acompress.h:302 [inline]
 zswap_store+0x98b/0x2430 mm/zswap.c:1666
 swap_writepage+0x8e/0x220 mm/page_io.c:198
 pageout+0x399/0x9e0 mm/vmscan.c:656
 shrink_folio_list+0x2f47/0x3ea0 mm/vmscan.c:1319
 reclaim_folio_list+0xe4/0x3a0 mm/vmscan.c:2104
 reclaim_pages+0x483/0x6a0 mm/vmscan.c:2140
 madvise_cold_or_pageout_pte_range+0x129e/0x1f70 mm/madvise.c:526
 walk_pmd_range mm/pagewalk.c:143 [inline]
 walk_pud_range mm/pagewalk.c:221 [inline]
 walk_p4d_range mm/pagewalk.c:256 [inline]
 walk_pgd_range+0xa48/0x1870 mm/pagewalk.c:293
 __walk_page_range+0x630/0x770 mm/pagewalk.c:395
 walk_page_range+0x626/0xa80 mm/pagewalk.c:521
 madvise_pageout_page_range mm/madvise.c:585 [inline]
 madvise_pageout+0x32c/0x820 mm/madvise.c:612
 madvise_vma_behavior+0x1cc/0x1b50 mm/madvise.c:1031
 madvise_walk_vmas+0x1cf/0x2c0 mm/madvise.c:1260
 do_madvise+0x349/0x670 mm/madvise.c:1443
 __do_sys_madvise mm/madvise.c:1456 [inline]
 __se_sys_madvise mm/madvise.c:1454 [inline]
 __x64_sys_madvise+0xa9/0x110 mm/madvise.c:1454
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7ff79cc7cce9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff79da610c8 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007ff79cd9bf80 RCX: 00007ff79cc7cce9
RDX: 0000000000000015 RSI: 0000000000c00304 RDI: 0000000020000000
RBP: 00007ff79ccc947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007ff79cd9bf80 R15: 00007ffc0bca2f58
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:scatterwalk_start include/crypto/scatterwalk.h:63 [inline]
RIP: 0010:scatterwalk_pagedone include/crypto/scatterwalk.h:83 [inline]
RIP: 0010:scatterwalk_pagedone include/crypto/scatterwalk.h:72 [inline]
RIP: 0010:scatterwalk_copychunks+0x3e0/0x560 crypto/scatterwalk.c:50
Code: f0 48 c1 e8 03 80 3c 08 00 0f 85 81 01 00 00 49 8d 44 24 08 4d 89 26 48 bf 00 00 00 00 00 fc ff df 48 89 44 24 10 48 c1 e8 03 <0f> b6 04 38 84 c0 74 08 3c 03 0f 8e 47 01 00 00 48 8b 44 24 08 41
RSP: 0018:ffffc9000557ecf0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: ffff88807fc6d940 RSI: ffffffff8465df94 RDI: dffffc0000000000
RBP: 0000000000001000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000002 R11: 82d8bd1b6060f805 R12: 0000000000000000
R13: 0000000000000014 R14: ffffc9000557ed88 R15: 0000000000001000
FS:  00007ff79da616c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff79cd98000 CR3: 0000000021251000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	f0 48 c1 e8 03       	lock shr $0x3,%rax
   5:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
   9:	0f 85 81 01 00 00    	jne    0x190
   f:	49 8d 44 24 08       	lea    0x8(%r12),%rax
  14:	4d 89 26             	mov    %r12,(%r14)
  17:	48 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdi
  1e:	fc ff df
  21:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	0f b6 04 38          	movzbl (%rax,%rdi,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 08                	je     0x3a
  32:	3c 03                	cmp    $0x3,%al
  34:	0f 8e 47 01 00 00    	jle    0x181
  3a:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  3f:	41                   	rex.B


Tested on:

commit:         39676dfe Add linux-next specific files for 20231222
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11c37595e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3761490b734dc96
dashboard link: https://syzkaller.appspot.com/bug?extid=3eff5e51bf1db122a16e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12fb5776e80000


