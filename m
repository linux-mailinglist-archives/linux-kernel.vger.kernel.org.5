Return-Path: <linux-kernel+bounces-104058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B62587C861
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269391C21FD2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860D8DF4D;
	Fri, 15 Mar 2024 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Poz0EXoG"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0941CDDB1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710478224; cv=none; b=XmBPc42YgdV8e/MJZYTgZOzvR5ki1xFSvqLo5DGqPXe82Ag6PgVEb0nAMoulBRG3XXfBxk/A7E+6yOLTg8XQL9NYF+LwnjqEj09dQ4n6EkxohLEkkVedAj4VOSVJ+L3H5Sbw4PFbOxurgUHnEWaUaLMcLa2N4aw5mDzB+HHWmko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710478224; c=relaxed/simple;
	bh=hC1fGXL1QcJzuOS9nshZUfHoyTJ5MYxI0XyHprd+9oM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=W+L3Vg+HsQxVrjzhiki04MqiEjrWEiJ+oPklNQ32COJnpOPZGpQuO/EG6KGm8fwdMflCQmZ/Sn9ReYRcL2iQAZ7+4e0zJUu57lv0sDf2yFUTrUqp7ks7v32UHiKwliMAL4yh7HrcBIQOUzoYMHzBI0J6UcNzNhAWXi8TP7EmttU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Poz0EXoG; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so500395966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 21:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710478221; x=1711083021; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xY/TaOHxK1p2fZfKZt6C/oh3xgT1aZnKcWtt7te5uys=;
        b=Poz0EXoGWyGdE8vm/YQ4VtdTl5oEQutBe8BVHk7X1/X/rx4KoZx5EKdEwiLaH9EnbN
         9Mk9HbPrCEHNvErb5A4tuyDJQoSfB4oknbIVukOGwR+a5NRtTDads2Ae4eYnMP5wwsDI
         ue5bQN0BbNsA7nESfjlWd7ZoJkY59Lj3WuQlG5gvZPv2CErvz94m5IEAN6IsY+1N1qLG
         PfEKvvYTnatxWFfmj6ZQKao25puE9D3AmEfCtnKUjR3z3LHenDFoZbTlGg7C4JUSihtc
         /IXfXAedr7usy7+aoRpzl2ZgTJIQStD4bUBOiVfrK/j+NvYiyH9cY07D/1e3pEjENPIZ
         5t2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710478221; x=1711083021;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xY/TaOHxK1p2fZfKZt6C/oh3xgT1aZnKcWtt7te5uys=;
        b=CCZLk218r95K/Co1e5flNe4JSkZn+YNm9bry1Z3MBSzn5muR3ysASh856lN+ObGdXF
         M5IH8RBu5eR8Bt4aJN9wNyVMCO1sszSS936JfPAYT5YpInXzo3wfcmNwu5ZbvqQVGNVz
         xURh1clS7B8RgekrClPbDmNYuqlWOprEMsYWIxb+x/lPfuE0SGQryMYt/jBlRS6jk4Gs
         T57ZlA2k9J7RIIlaEeEo7zeCb/On05eKYXBIAn8xlIWofp+lc4PiLW2gojt//7DU8iDO
         p90ZBqVZR1A5R8LLT0PYcIJVMvbNJ01UIVJB0zU/MdNCnq1/qvA+jkm7OKS/K7AigX7u
         l6FA==
X-Forwarded-Encrypted: i=1; AJvYcCWPgGkllc7tmx9rFD4GqsasgD4ou5pgeTz6hNB4Z3SCRmPoMVXseFSKLeXolfAumVUDtVDt1zYNVtoMsFEj6oQqNHoiGMJAIgYsQpH3
X-Gm-Message-State: AOJu0YzxjHWs2WTX2pXYtQZkNdXibrnFyEuqD7U5wxX4Q5sHbUJZyv3o
	HIaOhGjYOZWZfAkF6F0v9Os7ibHSsuqLHYWjyu3hXHtk1ecw5JcVUCSXtp/Qt/G4X8PXdsEMzkN
	TaWX+LNFCgZ+zib+Tz3AKDXmwFzM=
X-Google-Smtp-Source: AGHT+IFU0tYXenZsnTSl3BYllZiou1IjiA0bDE7FnIQq6ntkZ5S77eRyhtRJvlI55npTm96j0pQD3yVmVpI7GqCeZPY=
X-Received: by 2002:a17:906:99d6:b0:a46:74b0:adad with SMTP id
 s22-20020a17090699d600b00a4674b0adadmr3661605ejn.8.1710478221136; Thu, 14 Mar
 2024 21:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Fri, 15 Mar 2024 12:50:06 +0800
Message-ID: <CAKHoSAvEbO_dGdkNm5AMOxNwO1vdpcCFuy3VQNwwa7uxrC7MOA@mail.gmail.com>
Subject: BUG: unable to handle kernel paging request in ext4_ext_remove_space
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,


when using Healer to fuzz the latest Linux Kernel, the following crash

was triggered on:


HEAD commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a  (tag: v6.7)

git tree: upstream

console output: https://pastebin.com/raw/dtWhAR8Y

kernel config: https://pastebin.com/raw/dRctH7sr

C reproducer: https://pastebin.com/raw/zUiGyNi9

Syzlang reproducer:https://pastebin.com/raw/PNyeDjq6

If you fix this issue, please add the following tag to the commit:

Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>

----------------------------------------------------------

EXT4-fs (loop0): mounted filesystem
00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode:
writeback.
ext4 filesystem being mounted at /syzkaller.TPYs2I/19/file1 supports
timestamps until 2038-01-19 (0x7fffffff)
BUG: unable to handle page fault for address: ffff888002cba000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0003) - permissions violation
PGD a4c01067 P4D a4c01067 PUD a4c02067 PMD 2c63063 PTE 8000000002cba121
Oops: 0003 [#1] PREEMPT SMP KASAN NOPTI
CPU: 2 PID: 366 Comm: syz-executor127 Not tainted 6.7.0 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:memmove+0x1e/0x1b0
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/arch/x86/lib/memmove_64.S:44
Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 f8 48 39
fe 7d 0f 49 89 f0 49 01 d0 49 39 f8 0f 8f b5 00 00 00 48 89 d1 <f3> a4
e9 26 14 1b 00 66 2e 0f 1f 84 00 00 00 00 00 48 81 fa a8 02
RSP: 0018:ffff88800d84f840 EFLAGS: 00010216
RAX: ffff888002c9903c RBX: ffff888002c99000 RCX: fffffffffffdf000
RDX: ffffffffffffffc4 RSI: ffff888002cba00c RDI: ffff888002cba000
RBP: ffff888002c99002 R08: 0000000000000001 R09: fffff94000039076
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88800ba37868 R14: ffff888002c99040 R15: 0000000000000004
FS:  00007fefc4cb4640(0000) GS:ffff88809e900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888002cba000 CR3: 00000000092fc005 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ext4_ext_rm_leaf
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/ext4/extents.c:2736
[inline]
 ext4_ext_remove_space+0x1aae/0x36b0
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/ext4/extents.c:2958
 ext4_punch_hole+0xb8b/0xe50
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/ext4/inode.c:4019
 ext4_fallocate+0xb68/0x3230
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/ext4/extents.c:4707
 vfs_fallocate+0x361/0xae0
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/open.c:324
 ioctl_preallocate+0x172/0x1f0
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/ioctl.c:291
 file_ioctl root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/ioctl.c:334
[inline]
 do_vfs_ioctl+0x109e/0x13c0
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/ioctl.c:850
 __do_sys_ioctl
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/ioctl.c:869
[inline]
 __se_sys_ioctl
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/ioctl.c:857
[inline]
 __x64_sys_ioctl+0xef/0x1e0
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/ioctl.c:857
 do_syscall_x64
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/arch/x86/entry/common.c:52
[inline]
 do_syscall_64+0x46/0xf0
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7fefc4d3263d
Code: c3 e8 27 23 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fefc4cb4198 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fefc4dc95d0 RCX: 00007fefc4d3263d
RDX: 0000000020000080 RSI: 0000000040305829 RDI: 0000000000000004
RBP: 00007fefc4d93598 R08: 00007ffe5e3ab7bf R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0031656c69662f2e
R13: 6f6f6c2f7665642f R14: 000001ff7fdfd000 R15: 00007fefc4dc95d8
 </TASK>
Modules linked in:
CR2: ffff888002cba000
---[ end trace 0000000000000000 ]---
BUG: unable to handle page fault for address: ffffebde001bf808
RIP: 0010:memmove+0x1e/0x1b0
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/arch/x86/lib/memmove_64.S:44
#PF: supervisor read access in kernel mode
Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 f8 48 39
fe 7d 0f 49 89 f0 49 01 d0 49 39 f8 0f 8f b5 00 00 00 48 89 d1 <f3> a4
e9 26 14 1b 00 66 2e 0f 1f 84 00 00 00 00 00 48 81 fa a8 02
#PF: error_code(0x0000) - not-present page
RSP: 0018:ffff88800d84f840 EFLAGS: 00010216
PGD 0 P4D 0

