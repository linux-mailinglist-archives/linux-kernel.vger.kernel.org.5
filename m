Return-Path: <linux-kernel+bounces-31858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495C4833593
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 18:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7210B23122
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 17:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E32A10A38;
	Sat, 20 Jan 2024 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJwrU8sG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BB3101FA
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705772764; cv=none; b=b5gUxvwiAffYY/cAOhGB6TKKvlFyesPgg3XbdHPKSUfhM1YB53QARFy5LqsCGsJadtc9QXGRXcnKA1cozeurR1R4dfa1lHstlA3eQTJh6GDs4BBdUs/p123y1I+lytjWgWZWn9sWHmvZVmPSZ7krel4CDzU+hjktCpqfJ8B2FAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705772764; c=relaxed/simple;
	bh=5uHR6DHOOw6WbQ+eU9iFCgRwXXEOwE0aJn2QBcAEhP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAoORERy2/dDwkNzLHy97+iN+u3kClBIu2tJTNMoT2gR6QirO+rs3Q0MCrgWdXQD7EejafR7b9Hp7kr619dUOqunIce7wa+JBYyB2jXhu9w6z/8ehg13QhwYMwlw1eQobf9tY3fe7wOasnSD8CGhdXJQYd375lvyESZPk1ASKio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJwrU8sG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF036C433F1;
	Sat, 20 Jan 2024 17:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705772764;
	bh=5uHR6DHOOw6WbQ+eU9iFCgRwXXEOwE0aJn2QBcAEhP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SJwrU8sGfjTOh3P4OK4bf7yCg/rBrKUa15ad9vwMAyqygBNdsjav6M9dO0JftoO+D
	 Ukd1CoZvFbM6D+W2xMoAgeb7Bdk6S8nMIGw9JHAlLm0HHDV6q9CRTEs/Dr7SI4oQ3j
	 ctEc82VtaO88akVesfOd/N7e1VxvqGEnJmHK1nbutvIH0FwybDReG7GpPH+UQBk588
	 NC1PwHMEHEt8Yx9BlNGBAKcNAIT2aZOfaarNS+tpLSAaoV/fwSeHJyTw0DsYJ4QcpT
	 Jl2PbIrbNpe8iWnFClVZrtL4kvwkTFeAnPPQ+ls/0/rMZVPI+YVGCpUVIz9evcj8y/
	 Tw/5F+kPYGw0Q==
Message-ID: <06cb540e-34ff-4dcd-b936-19d4d14378c9@kernel.org>
Date: Sat, 20 Jan 2024 18:44:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -tip v2] x86/kprobes: Drop removed INT3 handling code
Content-Language: en-GB, fr-BE
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Huacai Chen <chenhuacai@loongson.cn>, Jinyang He <hejinyang@loongson.cn>,
 Tiezhu Yang <yangtiezhu@loongson.cn>,
 "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>
References: <166981518895.1131462.4693062055762912734.stgit@devnote3>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <166981518895.1131462.4693062055762912734.stgit@devnote3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Masami and the x86 list,

On 30/11/2022 14:33, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Drop removed INT3 handling code from kprobe_int3_handler() because this
> case (get_kprobe() doesn't return corresponding kprobe AND the INT3 is
> removed) must not happen with the kprobe managed INT3, but can happen
> with the non-kprobe INT3, which should be handled by other callbacks.
> 
> For the kprobe managed INT3, it is already safe. The commit 5c02ece81848d
> ("x86/kprobes: Fix ordering while text-patching") introduced
> text_poke_sync() to the arch_disarm_kprobe() right after removing INT3.
> Since this text_poke_sync() uses IPI to call sync_core() on all online
> cpus, that ensures that all running INT3 exception handlers have done.
> And, the unregister_kprobe() will remove the kprobe from the hash table
> after arch_disarm_kprobe().
> 
> Thus, when the kprobe managed INT3 hits, kprobe_int3_handler() should
> be able to find corresponding kprobe always by get_kprobe(). If it can
> not find any kprobe, this means that is NOT a kprobe managed INT3.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  Changes in v2:
>   - update comment to mention that the first safe commit.
> ---
>  arch/x86/kernel/kprobes/core.c |   14 --------------
>  1 file changed, 14 deletions(-)


I'm sorry to reply on a patch that is more than one year old, but in
short, it looks like it is causing a kernel panic on our side. To be
honest, I don't understand the link, but I probably missed something.

A bit of context: for the MPTCP net subsystem, we are testing a new CI
service to launch a VM and run our test suite (kselftests, kunit, etc.).
This CI (Github Action) doesn't support KVM acceleration, and QEmu
(v6.2.0) falls back to TCG ("-machine accel=kvm:tcg"). Before, we were
always running the tests with QEmu and KVM support, and I don't think we
had this issue before. Now, in two weeks, this new CI reported 5 kernel
panic in ~30 runs.

I initially reported the issue on netdev [1], because the CI always got
the panic when doing some pings between different netns, not using MPTCP
yet. Eric Dumazet mentioned that it looks like it is an x86 issue, maybe
with the jump labels. Since then, I tried to 'git bisect' the issue on
my side, but it was not easy: hard to reproduce and unclear to me what
is causing it.

After a few (long) sessions, 'git bisect' gave me this commit:

  8e791f7eba4c ("x86/kprobes: Drop removed INT3 handling code")

I thought it was another false positive, but I was not able to reproduce
the issue when testing the parent commit, while I could still do that
when validating this 8e791f7eba4c commit. I also went back to our MPTCP
tree [2], reproduced the issue again, just to be sure. Then I tried to
reproduce it after having reverted 8e791f7eba4c. I didn't have any
panic, and I tried for a long time: ~2000 iterations, while I usually
have the kernel panic after ~50 iterations.

So it looks like the modifications done by this patch is linked to the
kernel panic we have:

> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 66299682b6b7..33390ed4dcf3 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -986,20 +986,6 @@ int kprobe_int3_handler(struct pt_regs *regs)
>  			kprobe_post_process(p, regs, kcb);
>  			return 1;
>  		}
> -	}
> -
> -	if (*addr != INT3_INSN_OPCODE) {
> -		/*
> -		 * The breakpoint instruction was removed right
> -		 * after we hit it.  Another cpu has removed
> -		 * either a probepoint or a debugger breakpoint
> -		 * at this address.  In either case, no further
> -		 * handling of this interrupt is appropriate.
> -		 * Back up over the (now missing) int3 and run
> -		 * the original instruction.
> -		 */
> -		regs->ip = (unsigned long)addr;
> -		return 1;
>  	} /* else: not a kprobe fault; let the kernel handle it */
>  
>  	return 0;
> 
> 


As far as I know, our 'mptcp_connect.c' selftest that is being used to
reproduce the issue, is not using KProbes, tracing, dynamic debug, bpf,
etc. It simply creates netns with IP and routes, then do some pings
between the different IPs. Any idea why this commit could be linked to a
kernel panic?


Here is the last call trace I had:

> # INFO: validating network environment with pings
> [ 1985.073189] int3: 0000 [#1] PREEMPT SMP NOPTI
> [ 1985.073246] CPU: 0 PID: 3203 Comm: ping Not tainted 6.7.0-113761-g5e006770879c-dirty #250
> [ 1985.073246] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [ 1985.073246] RIP: 0010:netif_rx_internal (arch/x86/include/asm/jump_label.h:27)
> [ 1985.073246] Code: 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 55 48 89 fd 48 83 ec 20 65 48 8b 04 25 28 00 00 00 48 89 44 24 18 31 c0 e9 <c9> 00 00 00 66 90 66 90 48 8d 54 24 10 48 89 ef 65 8b 35 67 48 d0
> All code
> ========
>    0:   0f 1f 84 00 00 00 00    nopl   0x0(%rax,%rax,1)
>    7:   00
>    8:   0f 1f 40 00             nopl   0x0(%rax)
>    c:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>   11:   55                      push   %rbp
>   12:   48 89 fd                mov    %rdi,%rbp
>   15:   48 83 ec 20             sub    $0x20,%rsp
>   19:   65 48 8b 04 25 28 00    mov    %gs:0x28,%rax
>   20:   00 00
>   22:   48 89 44 24 18          mov    %rax,0x18(%rsp)
>   27:   31 c0                   xor    %eax,%eax
>   29:*  e9 c9 00 00 00          jmp    0xf7             <-- trapping instruction
>   2e:   66 90                   xchg   %ax,%ax
>   30:   66 90                   xchg   %ax,%ax
>   32:   48 8d 54 24 10          lea    0x10(%rsp),%rdx
>   37:   48 89 ef                mov    %rbp,%rdi
>   3a:   65                      gs
>   3b:   8b                      .byte 0x8b
>   3c:   35                      .byte 0x35
>   3d:   67                      addr32
>   3e:   48                      rex.W
>   3f:   d0                      .byte 0xd0
> 
> Code starting with the faulting instruction
> ===========================================
>    0:   c9                      leave
>    1:   00 00                   add    %al,(%rax)
>    3:   00 66 90                add    %ah,-0x70(%rsi)
>    6:   66 90                   xchg   %ax,%ax
>    8:   48 8d 54 24 10          lea    0x10(%rsp),%rdx
>    d:   48 89 ef                mov    %rbp,%rdi
>   10:   65                      gs
>   11:   8b                      .byte 0x8b
>   12:   35                      .byte 0x35
>   13:   67                      addr32
>   14:   48                      rex.W
>   15:   d0                      .byte 0xd0
> [ 1985.073246] RSP: 0018:ffffb36d40003c08 EFLAGS: 00000246
> [ 1985.073246] RAX: 0000000000000000 RBX: ffff9580825ca000 RCX: 0000000000000001
> [ 1985.073246] RDX: 0000000000000002 RSI: ffff9580825c8000 RDI: ffff9580821cca00
> [ 1985.073246] RBP: ffff9580821cca00 R08: 0000000000000000 R09: 000000000000001c
> [ 1985.073246] R10: ffff9580812dcf10 R11: ffff9580812dcf00 R12: ffff9580821cca00
> [ 1985.073246] R13: 000000000000002a R14: 0000000000000000 R15: ffff9580825e1800
> [ 1985.073246] FS:  00007fa7c46be1c0(0000) GS:ffff9580fdc00000(0000) knlGS:0000000000000000
> [ 1985.073246] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1985.073246] CR2: 00005584236b2200 CR3: 0000000002704000 CR4: 00000000000006f0
> [ 1985.073246] Call Trace:
> [ 1985.073246]  <IRQ>
> [ 1985.073246] ? die (arch/x86/kernel/dumpstack.c:421)
> [ 1985.073246] ? exc_int3 (arch/x86/kernel/traps.c:762)
> [ 1985.073246] ? asm_exc_int3 (arch/x86/include/asm/idtentry.h:569)
> [ 1985.073246] ? netif_rx_internal (arch/x86/include/asm/jump_label.h:27)
> [ 1985.073246] ? netif_rx_internal (arch/x86/include/asm/jump_label.h:27)
> [ 1985.073246] ? kmem_cache_alloc_node (mm/slub.c:3843)
> [ 1985.073246] __netif_rx (net/core/dev.c:5084)
> [ 1985.073246] veth_xmit (drivers/net/veth.c:321)
> [ 1985.073246] dev_hard_start_xmit (include/linux/netdevice.h:4989)
> [ 1985.073246] __dev_queue_xmit (include/linux/netdevice.h:3367)
> [ 1985.073246] ? arp_create (net/ipv4/arp.c:577)
> [ 1985.073246] arp_solicit (net/ipv4/arp.c:392)
> [ 1985.073246] ? kmem_cache_alloc (mm/slub.c:3843)
> [ 1985.073246] ? arp_constructor (net/ipv4/arp.c:249)
> [ 1985.073246] neigh_probe (arch/x86/include/asm/atomic.h:53)
> [ 1985.073246] __neigh_event_send (net/core/neighbour.c:1242)
> [ 1985.073246] neigh_resolve_output (net/core/neighbour.c:1547)
> [ 1985.073246] ip_finish_output2 (include/net/neighbour.h:542)
> [ 1985.073246] ? __ip_finish_output.part.0 (include/linux/skbuff.h:4884)
> [ 1985.073246] __netif_receive_skb_one_core (net/core/dev.c:5537)
> [ 1985.073246] process_backlog (include/linux/rcupdate.h:782)
> [ 1985.073246] __napi_poll (net/core/dev.c:6576)
> [ 1985.073246] net_rx_action (net/core/dev.c:6647)
> [ 1985.073246] __do_softirq (arch/x86/include/asm/jump_label.h:27)
> [ 1985.073246] do_softirq (kernel/softirq.c:454)
> [ 1985.073246]  </IRQ>
> [ 1985.073246]  <TASK>
> [ 1985.073246] __local_bh_enable_ip (kernel/softirq.c:381)
> [ 1985.073246] __dev_queue_xmit (net/core/dev.c:4379)
> [ 1985.073246] ip_finish_output2 (include/linux/netdevice.h:3171)
> [ 1985.073246] ? __ip_finish_output.part.0 (include/linux/skbuff.h:4884)
> [ 1985.073246] ip_push_pending_frames (net/ipv4/ip_output.c:1490)
> [ 1985.073246] raw_sendmsg (net/ipv4/raw.c:647)
> [ 1985.073246] ? netfs_rreq_assess (fs/netfs/io.c:101)
> [ 1985.073246] ? folio_add_file_rmap_ptes (arch/x86/include/asm/bitops.h:206)
> [ 1985.073246] ? set_pte_range (mm/memory.c:4529)
> [ 1985.073246] ? __sock_sendmsg (net/socket.c:733)
> [ 1985.073246] __sock_sendmsg (net/socket.c:733)
> [ 1985.073246] ? move_addr_to_kernel.part.0 (net/socket.c:253)
> [ 1985.073246] __sys_sendto (net/socket.c:2191)
> [ 1985.073246] ? __rseq_handle_notify_resume (kernel/rseq.c:257)
> [ 1985.073246] ? ktime_get_real_ts64 (kernel/time/timekeeping.c:292 (discriminator 3))
> [ 1985.073246] __x64_sys_sendto (net/socket.c:2203)
> [ 1985.073246] do_syscall_64 (arch/x86/entry/common.c:52)
> [ 1985.073246] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
> [ 1985.073246] RIP: 0033:0x7fa7c499081a
> [ 1985.073246] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
> All code
> ========
>    0:   d8 64 89 02             fsubs  0x2(%rcx,%rcx,4)
>    4:   48 c7 c0 ff ff ff ff    mov    $0xffffffffffffffff,%rax
>    b:   eb b8                   jmp    0xffffffffffffffc5
>    d:   0f 1f 00                nopl   (%rax)
>   10:   f3 0f 1e fa             endbr64
>   14:   41 89 ca                mov    %ecx,%r10d
>   17:   64 8b 04 25 18 00 00    mov    %fs:0x18,%eax
>   1e:   00
>   1f:   85 c0                   test   %eax,%eax
>   21:   75 15                   jne    0x38
>   23:   b8 2c 00 00 00          mov    $0x2c,%eax
>   28:   0f 05                   syscall
>   2a:*  48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax         <-- trapping instruction
>   30:   77 7e                   ja     0xb0
>   32:   c3                      ret
>   33:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>   38:   41 54                   push   %r12
>   3a:   48 83 ec 30             sub    $0x30,%rsp
>   3e:   44                      rex.R
>   3f:   89                      .byte 0x89
> 
> Code starting with the faulting instruction
> ===========================================
>    0:   48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax
>    6:   77 7e                   ja     0x86
>    8:   c3                      ret
>    9:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>    e:   41 54                   push   %r12
>   10:   48 83 ec 30             sub    $0x30,%rsp
>   14:   44                      rex.R
>   15:   89                      .byte 0x89
> [ 1985.073246] RSP: 002b:00007ffce269b368 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> [ 1985.073246] RAX: ffffffffffffffda RBX: 00007ffce269ca10 RCX: 00007fa7c499081a
> [ 1985.073246] RDX: 0000000000000040 RSI: 0000558423f7c300 RDI: 0000000000000003
> [ 1985.073246] RBP: 0000558423f7c300 R08: 00007ffce269ec90 R09: 0000000000000010
> [ 1985.073246] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000040
> [ 1985.073246] R13: 00007ffce269c5a8 R14: 00007ffce269b370 R15: 00007ffce269ca10
> [ 1985.073246]  </TASK>
> [ 1985.073246] Modules linked in:
> [ 1985.073246] ---[ end trace 0000000000000000 ]---
> [ 1985.073246] RIP: 0010:netif_rx_internal (arch/x86/include/asm/jump_label.h:27)
> [ 1985.073246] Code: 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 55 48 89 fd 48 83 ec 20 65 48 8b 04 25 28 00 00 00 48 89 44 24 18 31 c0 e9 <c9> 00 00 00 66 90 66 90 48 8d 54 24 10 48 89 ef 65 8b 35 67 48 d0
> All code
> ========
>    0:   0f 1f 84 00 00 00 00    nopl   0x0(%rax,%rax,1)
>    7:   00
>    8:   0f 1f 40 00             nopl   0x0(%rax)
>    c:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>   11:   55                      push   %rbp
>   12:   48 89 fd                mov    %rdi,%rbp
>   15:   48 83 ec 20             sub    $0x20,%rsp
>   19:   65 48 8b 04 25 28 00    mov    %gs:0x28,%rax
>   20:   00 00
>   22:   48 89 44 24 18          mov    %rax,0x18(%rsp)
>   27:   31 c0                   xor    %eax,%eax
>   29:*  e9 c9 00 00 00          jmp    0xf7             <-- trapping instruction
>   2e:   66 90                   xchg   %ax,%ax
>   30:   66 90                   xchg   %ax,%ax
>   32:   48 8d 54 24 10          lea    0x10(%rsp),%rdx
>   37:   48 89 ef                mov    %rbp,%rdi
>   3a:   65                      gs
>   3b:   8b                      .byte 0x8b
>   3c:   35                      .byte 0x35
>   3d:   67                      addr32
>   3e:   48                      rex.W
>   3f:   d0                      .byte 0xd0
> 
> Code starting with the faulting instruction
> ===========================================
>    0:   c9                      leave
>    1:   00 00                   add    %al,(%rax)
>    3:   00 66 90                add    %ah,-0x70(%rsi)
>    6:   66 90                   xchg   %ax,%ax
>    8:   48 8d 54 24 10          lea    0x10(%rsp),%rdx
>    d:   48 89 ef                mov    %rbp,%rdi
>   10:   65                      gs
>   11:   8b                      .byte 0x8b
>   12:   35                      .byte 0x35
>   13:   67                      addr32
>   14:   48                      rex.W
>   15:   d0                      .byte 0xd0
> [ 1985.073246] RSP: 0018:ffffb36d40003c08 EFLAGS: 00000246
> [ 1985.073246] RAX: 0000000000000000 RBX: ffff9580825ca000 RCX: 0000000000000001
> [ 1985.073246] RDX: 0000000000000002 RSI: ffff9580825c8000 RDI: ffff9580821cca00
> [ 1985.073246] RBP: ffff9580821cca00 R08: 0000000000000000 R09: 000000000000001c
> [ 1985.073246] R10: ffff9580812dcf10 R11: ffff9580812dcf00 R12: ffff9580821cca00
> [ 1985.073246] R13: 000000000000002a R14: 0000000000000000 R15: ffff9580825e1800
> [ 1985.073246] FS:  00007fa7c46be1c0(0000) GS:ffff9580fdc00000(0000) knlGS:0000000000000000
> [ 1985.073246] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1985.073246] CR2: 00005584236b2200 CR3: 0000000002704000 CR4: 00000000000006f0
> [ 1985.073246] Kernel panic - not syncing: Fatal exception in interrupt
> [ 1985.073246] Kernel Offset: 0x19a00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> Unexpected stop of the VM


My kconfig is available in [3], here is an extract:

$ grep JUMP .config
# CONFIG_KEXEC_JUMP is not set
CONFIG_ARCH_SUPPORTS_KEXEC_JUMP=y
CONFIG_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_JUMP_LABEL_HACK=y

$ grep PROBES .config
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_KPROBES=y
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_KRETPROBES=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
# CONFIG_KPROBES_SANITY_TEST is not set

$ grep DYNAMIC .config
CONFIG_PREEMPT_DYNAMIC=y
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_DYNAMIC_SIGFRAME=y
# CONFIG_SWIOTLB_DYNAMIC is not set
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_DYNAMIC_EVENTS=y
# CONFIG_TEST_DYNAMIC_DEBUG is not set


I reported the tests I did, userspace commands before triggering the
bug, call traces, kernel config, vmlinux files, etc. on a ticket that is
publicly accessible [4].


Do you mind having a look at this issue, and tell me what you think
about it, please?

I can run more tests and debug patches if it can help. Please note that
it looks like it is even harder to reproduce the kernel panic when added
more debug mechanisms, but I can always try.


[1]
https://lore.kernel.org/netdev/98724dcd-ddf3-4f78-a386-f966ffbc9528@kernel.org/T/
[2] on top of Linus' tree from 2 days ago: 736b5545d39c ("Merge tag
'net-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
[3] https://github.com/multipath-tcp/mptcp_net-next/files/13998625/config.gz
[4] https://github.com/multipath-tcp/mptcp_net-next/issues/471


Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

