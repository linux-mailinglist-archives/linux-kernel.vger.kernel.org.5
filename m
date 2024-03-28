Return-Path: <linux-kernel+bounces-122626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 798A788FA89
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00601F26D06
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EC559B6A;
	Thu, 28 Mar 2024 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaoOkLhU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BD328DD5;
	Thu, 28 Mar 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711616320; cv=none; b=s9dVW/Y1heYmqNtRSLrjj5wh8Kv54Co5BlPVxz8Nq0S8NP9vH6veyCwYReV/TEZ4rHtQMHwBpvsNwcS9iDTc8zcdb3AqO/WvtAxfqVCJx4Ny2B2LGu5Xxv7LjivaxZIUm8r996N43ccHfjx4cSeu8La+nhLyU3n39gqD/p44n38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711616320; c=relaxed/simple;
	bh=NLceuoXWSrAw6KtncQrzxljx54OGZehtk2tzm/mFNk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Puct+839VIqqKL9NwUbDBj931eASdeOhCqhue50xsCPOAYU8jYkLt+WxB0a5182cO2+hvdHiqtnhzrvidChHDIbs/hzdFpnJ6CSvIHu9CRPn0GhB935ACQ6R2Ka12BQ3sifEdnO2R8oAtnw23IQlnkWP5QAp0T0eNS2wqeuLq8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaoOkLhU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D90BC433F1;
	Thu, 28 Mar 2024 08:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711616319;
	bh=NLceuoXWSrAw6KtncQrzxljx54OGZehtk2tzm/mFNk4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aaoOkLhUIgB3iGvDT31YBh4+7cJSzPQuYBzI1zwq4IfwOCnvIwkUDJ3LGuJ5AGApj
	 ueeO1wenYQeU106nTOPdtB2iMDhYJI/O/boFxm/CxbH4SAyFg4DtCIoxCkGOgy7uS6
	 IhWZCPVvr0MbeAIU0punZ1QcWGzRI0TTR2eii/euy02NyJ2HzIQwLmCGHza4Cixxuy
	 kLaF2IslR68YaXAfL/3IAWwi9vy5KVHLGStCL3USM3iwAToQ8X+KnlNj3pS1hh+hiE
	 KsELCMWZJRqkUm9tAnReehFF8pbVAWDECkzhMSLXFHwu9K2brjRc2q5C4Pu9sVyfUe
	 vBgUzmywPD/3Q==
Message-ID: <42106158-ca2b-48f5-9397-87e7cd9d4fc8@kernel.org>
Date: Thu, 28 Mar 2024 09:58:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in
 dev_map_enqueue
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 syzbot <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
References: <000000000000f6531b061494e696@google.com>
 <00000000000069ee1a06149ff00c@google.com>
 <CAADnVQLpJwEfLoF9ORc7bSsDPG7Y05mWUpWWyfi7qjY+2LhC+Q@mail.gmail.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAADnVQLpJwEfLoF9ORc7bSsDPG7Y05mWUpWWyfi7qjY+2LhC+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27/03/2024 16.19, Alexei Starovoitov wrote:
> Toke, Jesper,
> 
> please take a look.
> It's reproducible 100% of the time.
> dst is NULL in dev_map_enqueue().
> 

The `dst` (NULL) is basically `ri->tgt_value` being passed through
(unmodified) via xdp_do_redirect_frame() and __xdp_do_redirect_frame()
into dev_map_enqueue().

I think something is wrong in xdp_test_run_batch().
The `ri->tgt_value` is being set in __bpf_xdp_redirect_map(), but I
cannot see __bpf_xdp_redirect_map() being used in xdp_test_run_batch().

Toke, can you take a look at xdp_test_run_batch() and where
`ri->tgt_value` is getting set?


> On Wed, Mar 27, 2024 at 1:10 AM syzbot
> <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com> wrote:
>>
>> syzbot has found a reproducer for the following issue on:
>>
>> HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
>> git tree:       bpf
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=17d370b1180000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
>> dashboard link: https://syzkaller.appspot.com/bug?extid=af9492708df9797198d6
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d6b041180000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1060cc81180000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/3f355021a085/disk-443574b0.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/44cf4de7472a/vmlinux-443574b0.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/a99a36c7ad65/bzImage-443574b0.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com
>>
>> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
>> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>> CPU: 1 PID: 5078 Comm: syz-executor295 Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
>> RIP: 0010:dev_map_enqueue+0x31/0x3e0 kernel/bpf/devmap.c:539
>> Code: 41 56 41 55 41 54 53 48 83 ec 18 49 89 d4 49 89 f5 48 89 fd 49 be 00 00 00 00 00 fc ff df e8 a6 42 d8 ff 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 ef e8 10 8a 3b 00 4c 8b 7d 00 48 83 c5
>> RSP: 0018:ffffc90003bef688 EFLAGS: 00010246
>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888022169e00
>> RDX: 0000000000000000 RSI: ffff88802ef65070 RDI: 0000000000000000
>> RBP: 0000000000000000 R08: 0000000000000005 R09: ffffffff894ff90e
>> R10: 0000000000000004 R11: ffff888022169e00 R12: ffff888015bd0000
>> R13: ffff88802ef65070 R14: dffffc0000000000 R15: ffff8880b953c088
>> FS:  000055558e3b9380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f1141b380d0 CR3: 0000000021838000 CR4: 00000000003506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   __xdp_do_redirect_frame net/core/filter.c:4384 [inline]
>>   xdp_do_redirect_frame+0x20d/0x4d0 net/core/filter.c:4438
>>   xdp_test_run_batch net/bpf/test_run.c:336 [inline]
>>   bpf_test_run_xdp_live+0xe8a/0x1e90 net/bpf/test_run.c:384
>>   bpf_prog_test_run_xdp+0x813/0x11b0 net/bpf/test_run.c:1267
>>   bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4240
>>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5649
>>   __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
>>   __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
>>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
>>   do_syscall_64+0xfb/0x240
>>   entry_SYSCALL_64_after_hwframe+0x6d/0x75
>> RIP: 0033:0x7f1141ac0fb9
>> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007ffe180a1958 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
>> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1141ac0fb9
>> RDX: 0000000000000048 RSI: 0000000020000340 RDI: 000000000000000a
>> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000006
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
>>   </TASK>
>> Modules linked in:
>> ---[ end trace 0000000000000000 ]---
>> RIP: 0010:dev_map_enqueue+0x31/0x3e0 kernel/bpf/devmap.c:539
>> Code: 41 56 41 55 41 54 53 48 83 ec 18 49 89 d4 49 89 f5 48 89 fd 49 be 00 00 00 00 00 fc ff df e8 a6 42 d8 ff 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 ef e8 10 8a 3b 00 4c 8b 7d 00 48 83 c5
>> RSP: 0018:ffffc90003bef688 EFLAGS: 00010246
>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888022169e00
>> RDX: 0000000000000000 RSI: ffff88802ef65070 RDI: 0000000000000000
>> RBP: 0000000000000000 R08: 0000000000000005 R09: ffffffff894ff90e
>> R10: 0000000000000004 R11: ffff888022169e00 R12: ffff888015bd0000
>> R13: ffff88802ef65070 R14: dffffc0000000000 R15: ffff8880b953c088
>> FS:  000055558e3b9380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f1141b380d0 CR3: 0000000021838000 CR4: 00000000003506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> ----------------
>> Code disassembly (best guess):
>>     0:   41 56                   push   %r14
>>     2:   41 55                   push   %r13
>>     4:   41 54                   push   %r12
>>     6:   53                      push   %rbx
>>     7:   48 83 ec 18             sub    $0x18,%rsp
>>     b:   49 89 d4                mov    %rdx,%r12
>>     e:   49 89 f5                mov    %rsi,%r13
>>    11:   48 89 fd                mov    %rdi,%rbp
>>    14:   49 be 00 00 00 00 00    movabs $0xdffffc0000000000,%r14
>>    1b:   fc ff df
>>    1e:   e8 a6 42 d8 ff          call   0xffd842c9
>>    23:   48 89 e8                mov    %rbp,%rax
>>    26:   48 c1 e8 03             shr    $0x3,%rax
>> * 2a:   42 80 3c 30 00          cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
>>    2f:   74 08                   je     0x39
>>    31:   48 89 ef                mov    %rbp,%rdi
>>    34:   e8 10 8a 3b 00          call   0x3b8a49
>>    39:   4c 8b 7d 00             mov    0x0(%rbp),%r15
>>    3d:   48                      rex.W
>>    3e:   83                      .byte 0x83
>>    3f:   c5                      .byte 0xc5
>>
>>
>> ---
>> If you want syzbot to run the reproducer, reply with:
>> #syz test: git://repo/address.git branch-or-commit-hash
>> If you attach or paste a git patch, syzbot will apply it before testing.

