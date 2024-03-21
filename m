Return-Path: <linux-kernel+bounces-109868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF128856D9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF1828402A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A31555E75;
	Thu, 21 Mar 2024 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTnj/WTd"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B00055E4F;
	Thu, 21 Mar 2024 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014751; cv=none; b=ekpnlwzbO9c2kqgbz3ICykwgXhaIpSdxoA1uFoqvXugeLLPkrTkwTQW+n8H/BJALrgmHTCuu+fK/gjjswTF7jR9y9oIf8X/aCtDsJ1ttdHOSB/Jj0Or2sPU+sGggJ6Zl8DcPKVTtwZEGCUGs4QXIL7Du7t35t0aGh5J8R92mAbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014751; c=relaxed/simple;
	bh=WcSOWbG9v88MjnNjNvyeon7sFc7pTpvyDkyhJhJVaEU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ORjr32HNSSh0TqrjVbn0/2Fve/z/WHNNnOu9rquKVVWR9MylLc2VqLrj46+H8oOUSNoAXJo3lEOIvKOY8ujHEXhDl9GiiGiEM7x3gKCUZNFxOjOQiise5Z4t0XLsGuNtcaK3E1F8eogcXDMO9mcHikRq+x54lx2urumWE+NOlis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTnj/WTd; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4d44216ea59so321597e0c.2;
        Thu, 21 Mar 2024 02:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711014748; x=1711619548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WGCudiFJkEFy/VqY4A7Ez/vYZ0wVDDEpsxWoEQCxack=;
        b=cTnj/WTd8t8sHndL9KVDT1dcgTSYRFpbDkxIMRT2SZ1XDgadfvU0edwQBF7/EyoYzE
         jdP1JhHi4b47jjtT08HsffB3i/9cphHKYtc7BETTCn/8yM6I8QVPOyU88RwE9/dZM6UY
         /xeeEbuCULtcI2lDxxEiGYhs50tXqjvWCwrBGTv5jBl8TXaPXucJxczwBxLaB2oAXAR6
         ZAVzixkAHyFSrz2IhuOiNnIs1dGaeA3v8VQ223w/XK6RojhT0oVU3S6r8xPchofH2FBq
         rfCQMbUhx3nWT+iH8/Fx7QXB42pmoLRYjBahmhHlcjXOf42MHF0+olelM2x5HSFbXnx5
         zdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711014748; x=1711619548;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WGCudiFJkEFy/VqY4A7Ez/vYZ0wVDDEpsxWoEQCxack=;
        b=Kpo+uJ4xRMlf2F/mD3CimI/b8P7wMnBDM2LMraOiloF6bEredXwTL0C1lq4QWkRvaw
         freKHfYzXk8NS0EDY1ih3e45esMc45nT7+QeJkufW1RhBEkYMT98aLMCnypBR8hxJc3N
         MAwQ/hZK5vSR7Tho9OMISgD80bXtDXVPW9x1tgnCDpBYvd5ptrmf5Vc+jnqyQqE2iM3X
         CI64Wf0asSE6QPWagMPSi9p838M59RBDmm/g0H55i6KpAFz5EAXxIoEGjjXU0kpk23Ul
         39z25qRinAsdesODyhTYWBi4alo8nYJyQMHAZCJEydOIb5mCRn/ufoNY8/Y/pocryB/T
         i7ww==
X-Forwarded-Encrypted: i=1; AJvYcCV391a8Qdvdv4KBzgLqs55VcubiYqTdpr44/VmJe/2fBEhoMm77Fg17kOpYmzzBVvzebqQfSejW4+6/EUrCruq9SVfVfFRhQnxDhit3ELp/qlGrBDufM/o+mQg9OSDTDXkY
X-Gm-Message-State: AOJu0YwIP27ghn63cV9O0sN765XRmDWxozikFA42A4M7mX4bn3YFtKPE
	xDkVrjTZm+SJbk22J+VSmLXzYq1VSKtAl44Kqjwr/SfMCKdcqklrHAMYyY0ov9zT+HPFrYegOE8
	KTl5mFS3aqg1jllhBXV5Ect4CHXM=
X-Google-Smtp-Source: AGHT+IH6kYvEQHYa8nkaKRDgqPWlZartjz5l86gxa242jLOVn9f0I4o/hzuF1b4DfFWCWflRINkUZJmbDUtsAd6QvLM=
X-Received: by 2002:a05:6122:3105:b0:4cb:56c5:580e with SMTP id
 cg5-20020a056122310500b004cb56c5580emr4652658vkb.11.1711014748380; Thu, 21
 Mar 2024 02:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Thu, 21 Mar 2024 17:52:16 +0800
Message-ID: <CABOYnLz09O1+2gGVJuCxd_24a-7UueXzV-Ff+Fr+h5EKFDiYCQ@mail.gmail.com>
Subject: general protection fault in bpf_check/do_misc_fixups
To: ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net
Cc: andrii@kernel.org, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, yonghong.song@linux.dev, syzkaller-bugs@googlegroups.com, 
	samsun1006219@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello I found a bug titled "general protection fault in bpf_check"
with modified syzkaller, and maybe it is related to net/bpf.
I also confirmed in the latest net/bpf/bpf-next tree.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>

kernel: bpf-next cc9b22dfa735800980e7362f02aff6f1c2280996
kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=9f47e8dfa53b0b11
with KASAN enabled
compiler: gcc (Debian 12.2.0-14) 12.2.0

[  413.543678][ T8244] general protection fault, probably for
non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN
NOPTI
[  413.546252][ T8244] KASAN: null-ptr-deref in range
[0x0000000000000030-0x0000000000000037]
[  413.547723][ T8244] CPU: 0 PID: 8244 Comm: 477 Not tainted
6.8.0-05230-g114b5b3b4bde #5
[  413.549221][ T8244] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-1.fc38 04/01/2014
[  413.550994][ T8244] RIP: 0010:do_misc_fixups+0xf58/0x5610
[  413.552073][ T8244] Code: 8d bd 08 01 00 00 48 89 f8 48 c1 e8 03 42
80 3c 28 00 0f 85 60 32 00 00 48 8b ad 08 01 00 00 48 8d 7d 30 48 89
f8 48f
[  413.555539][ T8244] RSP: 0018:ffffc9000e17f538 EFLAGS: 00010216
[  413.556688][ T8244] RAX: 0000000000000006 RBX: ffffc9000219e05a
RCX: ffffffff81a6bda1
[  413.558131][ T8244] RDX: ffff88801f339ec0 RSI: ffffffff81a6b296
RDI: 0000000000000030
[  413.559606][ T8244] RBP: 0000000000000000 R08: 0000000000000005
R09: 0000000000000001
[  413.561027][ T8244] R10: 0000000000010000 R11: ffff8880296fd66c
R12: 0000000000010000
[  413.562467][ T8244] R13: dffffc0000000000 R14: 0000000000000002
R15: ffffc9000219e058
[  413.563913][ T8244] FS:  0000000017f1a380(0000)
GS:ffff8880b9200000(0000) knlGS:0000000000000000
[  413.565538][ T8244] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  413.566730][ T8244] CR2: 0000000020000300 CR3: 0000000020f26000
CR4: 0000000000750ef0
[  413.568167][ T8244] PKRU: 55555554
[  413.568869][ T8244] Call Trace:
[  413.569513][ T8244]  <TASK>
[  413.570058][ T8244]  ? show_regs+0x97/0xa0
[  413.570867][ T8244]  ? die_addr+0x56/0xe0
[  413.571654][ T8244]  ? exc_general_protection+0x155/0x230
[  413.572715][ T8244]  ? asm_exc_general_protection+0x26/0x30
[  413.573792][ T8244]  ? do_misc_fixups+0x1a01/0x5610
[  413.574744][ T8244]  ? do_misc_fixups+0xef6/0x5610
[  413.575684][ T8244]  ? do_misc_fixups+0xf58/0x5610
[  413.576630][ T8244]  ? do_misc_fixups+0xef6/0x5610
[  413.577586][ T8244]  ? kvfree+0x50/0x60
[  413.578371][ T8244]  ? __kasan_slab_free+0x11d/0x1a0
[  413.579349][ T8244]  ? kfree+0x129/0x370
[  413.580148][ T8244]  ? __x64_sys_bpf+0x7d/0xc0
[  413.581034][ T8244]  ? __pfx_do_misc_fixups+0x10/0x10
[  413.582047][ T8244]  ? srso_alias_return_thunk+0x5/0xfbef5
[  413.583165][ T8244]  ? __sanitizer_cov_trace_switch+0x54/0x90
[  413.584336][ T8244]  ? srso_alias_return_thunk+0x5/0xfbef5
[  413.585458][ T8244]  ? convert_ctx_accesses+0x1275/0x1860
[  413.586560][ T8244]  ? __pfx_convert_ctx_accesses+0x10/0x10
[  413.587658][ T8244]  ? __pfx_check_max_stack_depth_subprog+0x10/0x10
[  413.588909][ T8244]  ? kvfree+0x50/0x60
[  413.589714][ T8244]  bpf_check+0x38a5/0xb3b0
[  413.590651][ T8244]  ? pcpu_memcg_post_alloc_hook+0x260/0x6f0
[  413.591807][ T8244]  ? __pfx_bpf_check+0x10/0x10
[  413.592767][ T8244]  ? find_held_lock+0x2d/0x110
[  413.593752][ T8244]  ? srso_alias_return_thunk+0x5/0xfbef5
[  413.594898][ T8244]  ? bpf_prog_load+0xe3c/0x27e0
[  413.595900][ T8244]  ? __pfx_lock_release+0x10/0x10
[  413.596947][ T8244]  ? srso_alias_return_thunk+0x5/0xfbef5
[  413.598122][ T8244]  ? srso_alias_return_thunk+0x5/0xfbef5
[  413.599280][ T8244]  ? __pfx___might_resched+0x10/0x10
[  413.600306][ T8244]  ? srso_alias_return_thunk+0x5/0xfbef5
[  413.601402][ T8244]  ? ktime_get_with_offset+0x326/0x560
[  413.602469][ T8244]  ? srso_alias_return_thunk+0x5/0xfbef5
[  413.603551][ T8244]  ? srso_alias_return_thunk+0x5/0xfbef5
[  413.604659][ T8244]  bpf_prog_load+0xf3b/0x27e0
[  413.605595][ T8244]  ? __pfx_bpf_prog_load+0x10/0x10
[  413.606583][ T8244]  ? srso_alias_return_thunk+0x5/0xfbef5
[  413.607669][ T8244]  ? find_held_lock+0x2d/0x110
[  413.608610][ T8244]  ? srso_alias_return_thunk+0x5/0xfbef5
[  413.609786][ T8244]  ? srso_alias_return_thunk+0x5/0xfbef5
[  413.610878][ T8244]  ? srso_alias_return_thunk+0x5/0xfbef5
[  413.611964][ T8244]  ? srso_alias_return_thunk+0x5/0xfbef5
[  413.613106][ T8244]  __sys_bpf+0xa17/0x4ef0
[  413.614002][ T8244]  ? __pfx___sys_bpf+0x10/0x10
[  413.614957][ T8244]  ? srso_alias_return_thunk+0x5/0xfbef5
[  413.616043][ T8244]  ? srso_alias_return_thunk+0x5/0xfbef5
[  413.617128][ T8244]  ? srso_alias_return_thunk+0x5/0xfbef5
[  413.618211][ T8244]  ? find_held_lock+0x2d/0x110
[  413.619173][ T8244]  ? __pfx___up_read+0x10/0x10
[  413.620107][ T8244]  ? srso_alias_return_thunk+0x5/0xfbef5
[  413.621230][ T8244]  ? handle_mm_fault+0x541/0xab0
[  413.622251][ T8244]  __x64_sys_bpf+0x7d/0xc0
[  413.623117][ T8244]  ? srso_alias_return_thunk+0x5/0xfbef5
[  413.624208][ T8244]  ? lockdep_hardirqs_on+0x7c/0x110
[  413.625212][ T8244]  do_syscall_64+0xd5/0x260
[  413.626098][ T8244]  entry_SYSCALL_64_after_hwframe+0x6d/0x75

=* repro.c =*
#define _GNU_SOURCE

#include <endian.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef __NR_bpf
#define __NR_bpf 321
#endif

int main(void) {
 syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
         /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
 syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
         /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
 syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
         /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);

 *(uint32_t*)0x20000300 = 0x18;
 *(uint32_t*)0x20000304 = 4;
 *(uint64_t*)0x20000308 = 0x200000c0;
 memcpy((void*)0x200000c0,
        "\x18\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xff\xff\xff\xbf"
        "\x02\x01\x00\x00\x00\x01\x00\x95",
        25);
 *(uint64_t*)0x20000310 = 0x20000000;
 memcpy((void*)0x20000000, "syzkaller\000", 10);
 *(uint32_t*)0x20000318 = 2;
 *(uint32_t*)0x2000031c = 0;
 *(uint64_t*)0x20000320 = 0;
 *(uint32_t*)0x20000328 = 0;
 *(uint32_t*)0x2000032c = 0;
 memset((void*)0x20000330, 0, 16);
 *(uint32_t*)0x20000340 = 0;
 *(uint32_t*)0x20000344 = 0;
 *(uint32_t*)0x20000348 = -1;
 *(uint32_t*)0x2000034c = 8;
 *(uint64_t*)0x20000350 = 0;
 *(uint32_t*)0x20000358 = 0;
 *(uint32_t*)0x2000035c = 0x10;
 *(uint64_t*)0x20000360 = 0;
 *(uint32_t*)0x20000368 = 0;
 *(uint32_t*)0x2000036c = 0;
 *(uint32_t*)0x20000370 = 0;
 *(uint32_t*)0x20000374 = 0;
 *(uint64_t*)0x20000378 = 0;
 *(uint64_t*)0x20000380 = 0;
 *(uint32_t*)0x20000388 = 0x10;
 *(uint32_t*)0x2000038c = 0;
 syscall(__NR_bpf, /*cmd=*/5ul, /*arg=*/0x20000300ul, /*size=*/0x90ul);
 return 0;
}

=* repro.txt =*
bpf$BPF_PROG_RAW_TRACEPOINT_LOAD(0x5, &(0x7f0000000300)={0x18, 0x4,
&(0x7f00000000c0)=ANY=[@ANYBLOB="18000000000000000000000000ffffffbf0201000000010095"],
&(0x7f0000000000)='syzkaller\x00', 0x2}, 0x90)

see aslo https://gist.github.com/xrivendell7/22f4cb7e2a991946919aa94ae1418f17.

I hope it helps.
best regards.
xingwei Lee

