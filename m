Return-Path: <linux-kernel+bounces-1681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC54815212
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69FFFB239A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB2948CF2;
	Fri, 15 Dec 2023 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wXPf68RE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A5749F61
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-552eaf800abso3737a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702676895; x=1703281695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sz94xhxS71i+3wes2oNOQeSsbRe8IJ/zSe/10Mg4RkQ=;
        b=wXPf68REaoL7+MvRpb7EpjvrFgGNMd+5iuX3kmx7E+hBUat0NTMALkukHwboaGbc9U
         yPHoDxDtsk/9HX9ERKojIvEo1GbI8OuaFBpWGLIEyinZjBeThpeIL9GbBtb2qTQD5wXN
         MLYoe7EXI8X/LII2CU9ryXaF3cU1CufJ4zbZ7ev6TwbqQXvb+GRt84cFqvGbc9b/D0eo
         ELWBOD5smcchj6TPMu8+7YTk3BRBri5MHkuVj/apUhXnUZu48AAXJkBZy1JxqyWS+sow
         xL6fPEW5palllFQ4SGKC8rzd5gOLy27qOZ2vmmgHNr9MihgPk+ZG3vlR5Fz52sJez4Fi
         8Q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702676895; x=1703281695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sz94xhxS71i+3wes2oNOQeSsbRe8IJ/zSe/10Mg4RkQ=;
        b=ZTbndUKQzHPejgCa4hEKeR7Rpl+xMVQ2es75xKMcjN0iPR21+4pOn87wE5BrkYzfCQ
         EEsP3q5vPWyNiIPVsxawRdGL5+mqdkwTySxTu3gTmnCKSr4X8XTNwZlkMmdht4isD2+d
         Qxl5j2E+VD/r/xKOvYK2T+3xeEN94lnrYWIM6toNBHswlssQNo+253bzldluP70jaiG7
         Nfpbe01GZJZS9kTJtlLQO9LpCazLfPY+f9eUjB7znYVcyJwL0KKy5r3711tJq2lvf97l
         ubULFUH6TEwrqGsM6XJKeut6vvyxgthND+3zgtGVLA/Da5WJdytl7g5vfDN9ND1DvEFf
         Yv2w==
X-Gm-Message-State: AOJu0YwYKz5YXkOEDrRHEhKX2OiXULHcG7bAuGlUvwp6mJpu4mKgdR/Z
	L90wzCdGTZB6umecWw8ufdVd8aUm6zTfDMo2EzKjKxZrSNUAU9QLn7AVh5AHPG9j
X-Google-Smtp-Source: AGHT+IHt/c0l/lY/DsdJsI7am1hm1jcdtutPnUqaDvZUOv0IcGV85bI9I9omCCvgSnc4RRCyqHdyNWutb/g/us140DU=
X-Received: by 2002:a50:d508:0:b0:545:279:d075 with SMTP id
 u8-20020a50d508000000b005450279d075mr21037edi.1.1702676894874; Fri, 15 Dec
 2023 13:48:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000005c8e95060babfa0e@google.com> <CANn89i+nERqd=gPkSxvGA1tE3x2RNJif-ANZnCSTAZMYTj4CyA@mail.gmail.com>
 <87cyv7p2po.fsf@intel.com>
In-Reply-To: <87cyv7p2po.fsf@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 15 Dec 2023 22:48:02 +0100
Message-ID: <CANn89iKFgnwRt9YfysvCu1pccH3nxbhE=cMKYt514d9C87FvaQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in ip_list_rcv (6)
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: syzbot <syzbot+45b67ef6e09a39a2cbcd@syzkaller.appspotmail.com>, 
	davem@davemloft.net, dsahern@kernel.org, jhs@mojatatu.com, jiri@resnulli.us, 
	kuba@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	rjw@rjwysocki.net, syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 10:37=E2=80=AFPM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Eric Dumazet <edumazet@google.com> writes:
>
> > On Mon, Dec 4, 2023 at 10:45=E2=80=AFAM syzbot
> > <syzbot+45b67ef6e09a39a2cbcd@syzkaller.appspotmail.com> wrote:
> >>
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    753c8608f3e5 Merge tag 'for-netdev' of https://git.ker=
nel...
> >> git tree:       net-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1381f352e8=
0000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df8715b6ede=
5c4b90
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3D45b67ef6e09a=
39a2cbcd
> >> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils fo=
r Debian) 2.40
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15abc0e2=
e80000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10b0c7c2e8=
0000
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/17dd61ceadb9/=
disk-753c8608.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/fed6ba43d9bd/vml=
inux-753c8608.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/3e68e49966d=
3/bzImage-753c8608.xz
> >>
> >> The issue was bisected to:
> >>
> >> commit b5b73b26b3ca34574124ed7ae9c5ba8391a7f176
> >> Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> >> Date:   Thu Sep 10 00:03:11 2020 +0000
> >>
> >>     taprio: Fix allowing too small intervals
> >>
> >> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D13b9067=
2e80000
> >> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1079067=
2e80000
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17b90672e8=
0000
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the c=
ommit:
> >> Reported-by: syzbot+45b67ef6e09a39a2cbcd@syzkaller.appspotmail.com
> >> Fixes: b5b73b26b3ca ("taprio: Fix allowing too small intervals")
> >>
> >> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> >> rcu:    0-...!: (2 GPs behind) idle=3D9444/0/0x3 softirq=3D6168/6168 f=
qs=3D0
> >> rcu:    (detected by 1, t=3D10504 jiffies, g=3D7341, q=3D186 ncpus=3D2=
)
> >> Sending NMI from CPU 1 to CPUs 0:
> >> NMI backtrace for cpu 0
> >> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.7.0-rc3-syzkaller-00666-g7=
53c8608f3e5 #0
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIO=
S Google 11/10/2023
> >> RIP: 0010:rcu_is_watching+0x7c/0xb0 kernel/rcu/tree.c:701
> >> Code: 89 da 48 c1 ea 03 0f b6 14 02 48 89 d8 83 e0 07 83 c0 03 38 d0 7=
c 04 84 d2 75 1c 8b 03 c1 e8 02 83 e0 01 65 ff 0d fc d9 93 7e <74> 03 5b 5d=
 c3 e8 fa 9d 90 ff 5b 5d c3 48 89 df e8 bf 90 6e 00 eb
> >> RSP: 0000:ffffc90000006b90 EFLAGS: 00000006
> >> RAX: 0000000000000001 RBX: ffff8880b9836de8 RCX: ffffffff81680cf5
> >> RDX: 0000000000000000 RSI: ffffffff8b2f1340 RDI: ffffffff8ca6ea60
> >> RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1e31dea
> >> R10: ffffffff8f18ef57 R11: 0000000000000004 R12: ffff8880b982b958
> >> R13: 179cc057f149e962 R14: ffff88807627b340 R15: ffffffff88a26e60
> >> FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000=
000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00007f3bc135f410 CR3: 000000001ab22000 CR4: 00000000003506f0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> Call Trace:
> >>  <NMI>
> >>  </NMI>
> >>  <IRQ>
> >>  trace_lock_release include/trace/events/lock.h:69 [inline]
> >>  lock_release+0x4bf/0x690 kernel/locking/lockdep.c:5765
> >>  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:149 [in=
line]
> >>  _raw_spin_unlock_irqrestore+0x1a/0x70 kernel/locking/spinlock.c:194
> >>  __run_hrtimer kernel/time/hrtimer.c:1684 [inline]
> >>  __hrtimer_run_queues+0x58b/0xc20 kernel/time/hrtimer.c:1752
> >>  hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
> >>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
> >>  __sysvec_apic_timer_interrupt+0x105/0x400 arch/x86/kernel/apic/apic.c=
:1082
> >>  sysvec_apic_timer_interrupt+0x43/0xb0 arch/x86/kernel/apic/apic.c:107=
6
> >>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtent=
ry.h:645
> >> RIP: 0010:unwind_get_return_address+0xa1/0xe0 arch/x86/kernel/unwind_o=
rc.c:369
> >> Code: 00 31 ff 89 c5 89 c6 e8 8d 9d 4d 00 85 ed 74 b9 e8 14 a2 4d 00 4=
c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 <75> 28 48 8b=
 5b 48 e8 f4 a1 4d 00 48 89 d8 5b 5d 41 5c c3 48 89 df
> >> RSP: 0000:ffffc90000006f08 EFLAGS: 00000246
> >> RAX: dffffc0000000000 RBX: ffffc90000006f30 RCX: ffffffff8139f033
> >> RDX: 1ffff92000000def RSI: ffffffff8139f03c RDI: 0000000000000005
> >> RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
> >> R10: 0000000000000001 R11: 0000000000000003 R12: ffffc90000006f78
> >> R13: ffffffff8174f4a0 R14: ffffc90000006ff0 R15: ffffffff8cc95900
> >>  arch_stack_walk+0xbe/0x170 arch/x86/kernel/stacktrace.c:26
> >>  stack_trace_save+0x96/0xd0 kernel/stacktrace.c:122
> >>  kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
> >>  kasan_set_track+0x25/0x30 mm/kasan/common.c:52
> >>  kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
> >>  ____kasan_slab_free mm/kasan/common.c:236 [inline]
> >>  ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
> >>  kasan_slab_free include/linux/kasan.h:164 [inline]
> >>  slab_free_hook mm/slub.c:1800 [inline]
> >>  slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
> >>  slab_free mm/slub.c:3809 [inline]
> >>  kmem_cache_free+0xf8/0x350 mm/slub.c:3831
> >>  kfree_skbmem+0xef/0x1b0 net/core/skbuff.c:1015
> >>  tcp_rcv_established+0xd5f/0x20e0 net/ipv4/tcp_input.c:6065
> >>  tcp_v4_do_rcv+0x68c/0xa10 net/ipv4/tcp_ipv4.c:1912
> >>  tcp_v4_rcv+0x3892/0x3b40 net/ipv4/tcp_ipv4.c:2335
> >>  ip_protocol_deliver_rcu+0x9f/0x480 net/ipv4/ip_input.c:205
> >>  ip_local_deliver_finish+0x2e4/0x510 net/ipv4/ip_input.c:233
> >>  NF_HOOK include/linux/netfilter.h:314 [inline]
> >>  NF_HOOK include/linux/netfilter.h:308 [inline]
> >>  ip_local_deliver+0x18e/0x1f0 net/ipv4/ip_input.c:254
> >>  dst_input include/net/dst.h:461 [inline]
> >>  ip_sublist_rcv_finish+0x99/0x2e0 net/ipv4/ip_input.c:580
> >>  ip_list_rcv_finish.constprop.0+0x560/0x720 net/ipv4/ip_input.c:631
> >>  ip_sublist_rcv net/ipv4/ip_input.c:639 [inline]
> >>  ip_list_rcv+0x339/0x440 net/ipv4/ip_input.c:674
> >>  __netif_receive_skb_list_ptype net/core/dev.c:5572 [inline]
> >>  __netif_receive_skb_list_core+0x52c/0x8a0 net/core/dev.c:5620
> >>  __netif_receive_skb_list net/core/dev.c:5672 [inline]
> >>  netif_receive_skb_list_internal+0x769/0xe00 net/core/dev.c:5763
> >>  gro_normal_list include/net/gro.h:439 [inline]
> >>  gro_normal_list include/net/gro.h:435 [inline]
> >>  napi_complete_done+0x23f/0x990 net/core/dev.c:6103
> >>  virtqueue_napi_complete drivers/net/virtio_net.c:440 [inline]
> >>  virtnet_poll+0xf4a/0x15d0 drivers/net/virtio_net.c:2158
> >>  __napi_poll.constprop.0+0xb4/0x540 net/core/dev.c:6533
> >>  napi_poll net/core/dev.c:6602 [inline]
> >>  net_rx_action+0x956/0xe90 net/core/dev.c:6735
> >>  __do_softirq+0x21a/0x8de kernel/softirq.c:553
> >>  invoke_softirq kernel/softirq.c:427 [inline]
> >>  __irq_exit_rcu kernel/softirq.c:632 [inline]
> >>  irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
> >>  common_interrupt+0xb0/0xd0 arch/x86/kernel/irq.c:247
> >>  </IRQ>
> >>  <TASK>
> >>  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:636
> >> RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inlin=
e]
> >> RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [i=
nline]
> >> RIP: 0010:acpi_safe_halt+0x1b/0x20 drivers/acpi/processor_idle.c:113
> >> Code: ed c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 65 48 8b 04 25 c0 b=
c 03 00 48 8b 00 a8 08 75 0c 66 90 0f 00 2d b7 7b ba 00 fb f4 <fa> c3 0f 1f=
 00 0f b6 47 08 3c 01 74 0b 3c 02 74 05 8b 7f 04 eb 9f
> >> RSP: 0000:ffffffff8cc07d68 EFLAGS: 00000246
> >> RAX: 0000000000004000 RBX: 0000000000000001 RCX: ffffffff8a7fa837
> >> RDX: 0000000000000001 RSI: ffff888014ebd800 RDI: ffff888014ebd864
> >> RBP: ffff888014ebd864 R08: 0000000000000001 R09: ffffed1017306dbd
> >> R10: ffff8880b9836deb R11: 0000000000000000 R12: ffff8881412c4000
> >> R13: ffffffff8db1cf20 R14: 0000000000000000 R15: 0000000000000000
> >>  acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
> >>  cpuidle_enter_state+0x83/0x500 drivers/cpuidle/cpuidle.c:267
> >>  cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
> >>  cpuidle_idle_call kernel/sched/idle.c:215 [inline]
> >>  do_idle+0x319/0x400 kernel/sched/idle.c:282
> >>  cpu_startup_entry+0x50/0x60 kernel/sched/idle.c:380
> >>  rest_init+0x16f/0x2b0 init/main.c:730
> >>  arch_call_rest_init+0x13/0x30 init/main.c:827
> >>  start_kernel+0x39f/0x480 init/main.c:1072
> >>  x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:555
> >>  x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:536
> >>  secondary_startup_64_no_verify+0x166/0x16b
> >>  </TASK>
> >> INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 5.=
004 msecs
> >> rcu: rcu_preempt kthread starved for 10504 jiffies! g7341 f0x0 RCU_GP_=
WAIT_FQS(5) ->state=3D0x0 ->cpu=3D1
> >> rcu:    Unless rcu_preempt kthread gets sufficient CPU time, OOM is no=
w expected behavior.
> >> rcu: RCU grace-period kthread stack dump:
> >> task:rcu_preempt     state:R  running task     stack:28752 pid:17    t=
gid:17    ppid:2      flags:0x00004000
> >> Call Trace:
> >>  <TASK>
> >>  context_switch kernel/sched/core.c:5376 [inline]
> >>  __schedule+0xedb/0x5af0 kernel/sched/core.c:6688
> >>  __schedule_loop kernel/sched/core.c:6763 [inline]
> >>  schedule+0xe9/0x270 kernel/sched/core.c:6778
> >>  schedule_timeout+0x137/0x290 kernel/time/timer.c:2167
> >>  rcu_gp_fqs_loop+0x1ec/0xb10 kernel/rcu/tree.c:1631
> >>  rcu_gp_kthread+0x24b/0x380 kernel/rcu/tree.c:1830
> >>  kthread+0x2c6/0x3a0 kernel/kthread.c:388
> >>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> >>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> >>  </TASK>
> >> rcu: Stack dump where RCU GP kthread last ran:
> >> CPU: 1 PID: 5093 Comm: syz-executor163 Not tainted 6.7.0-rc3-syzkaller=
-00666-g753c8608f3e5 #0
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIO=
S Google 11/10/2023
> >> RIP: 0010:kvm_wait+0x146/0x180 arch/x86/kernel/kvm.c:1062
> >> Code: 5b 5d 41 5c 41 5d e9 c9 34 4e 00 e8 c4 34 4e 00 e8 8f ed 54 00 6=
6 90 e8 b8 34 4e 00 0f 00 2d 41 5a 90 09 e8 ac 34 4e 00 fb f4 <5b> 5d 41 5c=
 41 5d e9 9f 34 4e 00 e8 9a 34 4e 00 e8 d5 ed 54 00 e9
> >> RSP: 0018:ffffc900001f0ae0 EFLAGS: 00000246
> >> RAX: 0000000000000000 RBX: 0000000000000003 RCX: 1ffffffff23ec48c
> >> RDX: ffff888076299dc0 RSI: ffffffff81395da4 RDI: ffffffff8b2f13c0
> >> RBP: ffff88807e768098 R08: 0000000000000001 R09: fffffbfff23e29e7
> >> R10: ffffffff91f14f3f R11: 0000000000000002 R12: 0000000000000003
> >> R13: 0000000000000003 R14: 0000000000000000 R15: ffffed100fced013
> >> FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000=
000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00007f3bc14032d0 CR3: 000000007af32000 CR4: 00000000003506f0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> Call Trace:
> >>  <IRQ>
> >>  pv_wait arch/x86/include/asm/paravirt.h:598 [inline]
> >>  pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]
> >>  __pv_queued_spin_lock_slowpath+0x959/0xc70 kernel/locking/qspinlock.c=
:511
> >>  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:586 [inl=
ine]
> >>  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline=
]
> >>  queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
> >>  do_raw_spin_lock+0x20e/0x2b0 kernel/locking/spinlock_debug.c:115
> >>  spin_lock include/linux/spinlock.h:351 [inline]
> >>  tcp_write_timer+0x2a/0x2b0 net/ipv4/tcp_timer.c:708
> >>  call_timer_fn+0x193/0x590 kernel/time/timer.c:1700
> >>  expire_timers kernel/time/timer.c:1751 [inline]
> >>  __run_timers+0x764/0xb20 kernel/time/timer.c:2022
> >>  run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
> >>  __do_softirq+0x21a/0x8de kernel/softirq.c:553
> >>  invoke_softirq kernel/softirq.c:427 [inline]
> >>  __irq_exit_rcu kernel/softirq.c:632 [inline]
> >>  irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
> >>  sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:107=
6
> >>  </IRQ>
> >>  <TASK>
> >>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtent=
ry.h:645
> >> RIP: 0010:csd_lock_wait kernel/smp.c:311 [inline]
> >> RIP: 0010:smp_call_function_many_cond+0x4e4/0x1550 kernel/smp.c:855
> >> Code: 0b 00 85 ed 74 4d 48 b8 00 00 00 00 00 fc ff df 4d 89 f4 4c 89 f=
5 49 c1 ec 03 83 e5 07 49 01 c4 83 c5 03 e8 8e c0 0b 00 f3 90 <41> 0f b6 04=
 24 40 38 c5 7c 08 84 c0 0f 85 24 0e 00 00 8b 43 08 31
> >> RSP: 0018:ffffc90003bffa48 EFLAGS: 00000293
> >> RAX: 0000000000000000 RBX: ffff8880b98441a0 RCX: ffffffff817bd1e8
> >> RDX: ffff888076299dc0 RSI: ffffffff817bd1c2 RDI: 0000000000000005
> >> RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
> >> R10: 0000000000000001 R11: 0000000000000001 R12: ffffed1017308835
> >> R13: 0000000000000001 R14: ffff8880b98441a8 R15: ffff8880b993d8c0
> >>  on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1023
> >>  __flush_tlb_multi arch/x86/include/asm/paravirt.h:87 [inline]
> >>  flush_tlb_multi arch/x86/mm/tlb.c:944 [inline]
> >>  flush_tlb_mm_range+0x28f/0x320 arch/x86/mm/tlb.c:1030
> >>  tlb_flush arch/x86/include/asm/tlb.h:20 [inline]
> >>  tlb_flush_mmu_tlbonly include/asm-generic/tlb.h:458 [inline]
> >>  tlb_flush_mmu_tlbonly include/asm-generic/tlb.h:448 [inline]
> >>  tlb_flush_mmu mm/mmu_gather.c:299 [inline]
> >>  tlb_finish_mmu+0x335/0x6f0 mm/mmu_gather.c:392
> >>  exit_mmap+0x38b/0xa70 mm/mmap.c:3321
> >>  __mmput+0x12a/0x4d0 kernel/fork.c:1349
> >>  mmput+0x62/0x70 kernel/fork.c:1371
> >>  exit_mm kernel/exit.c:567 [inline]
> >>  do_exit+0x9ad/0x2ae0 kernel/exit.c:858
> >>  do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
> >>  __do_sys_exit_group kernel/exit.c:1032 [inline]
> >>  __se_sys_exit_group kernel/exit.c:1030 [inline]
> >>  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1030
> >>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> >>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
> >>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> >> RIP: 0033:0x7f3bc13802e9
> >> Code: Unable to access opcode bytes at 0x7f3bc13802bf.
> >> RSP: 002b:00007ffde3662848 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> >> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3bc13802e9
> >> RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
> >> RBP: 00007f3bc1400390 R08: ffffffffffffffb8 R09: 0000000100000000
> >> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3bc1400390
> >> R13: 0000000000000000 R14: 00007f3bc1402ec0 R15: 00007f3bc13507c0
> >>  </TASK>
> >>
> >>
> >> ---
> >> This report is generated by a bot. It may contain errors.
> >> See https://goo.gl/tpsmEJ for more information about syzbot.
> >> syzbot engineers can be reached at syzkaller@googlegroups.com.
> >>
> >> syzbot will keep track of this issue. See:
> >> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >> For information about bisection process see: https://goo.gl/tpsmEJ#bis=
ection
> >>
> >> If the report is already addressed, let syzbot know by replying with:
> >> #syz fix: exact-commit-title
> >>
> >> If you want syzbot to run the reproducer, reply with:
> >> #syz test: git://repo/address.git branch-or-commit-hash
> >> If you attach or paste a git patch, syzbot will apply it before testin=
g.
> >>
> >> If you want to overwrite report's subsystems, reply with:
> >> #syz set subsystems: new-subsystem
> >> (See the list of subsystem names on the web dashboard)
> >>
> >> If the report is a duplicate of another one, reply with:
> >> #syz dup: exact-subject-of-another-report
> >>
> >> If you want to undo deduplication, reply with:
> >> #syz undup
> >
> > FYI : Many other syzbot reports are pointing to taprio these days.
> >
>
> I know, it's bothering me a lot, really.
>
> I'll investigate this one a bit better, and see if I can come up with
> a fix for the short term.
>
> For the long term, I am thinking that the solution is to re-write the
> taprio software mode "engine" to not be 'hrtimer' dependent. And it will
> have the advantage that I would be able to unify some of the code for
> "txtime-assisted mode" and software mode, i.e. the "get the schedule
> entry for a particular time" function will be the used for both.
>
> > In a3d43c0d56f1b94e74963a2fbadfb70126d92213 ("taprio: Add support
> > adding an admin schedule"),
> > advance_sched() was changed to call switch_schedules(q, &admin, &oper);
> >
> > This is done while qdisc spinlock is not held, I fail to see how this
> > can work safely ?
> >
>
> I took a look at the code at a3d43c0d56f1b94e74963a2fbadfb70126d92213
> point, there are two calls to switch_schedules() and both calls to
> switch_schedules() (both in advance_sched()) are done with the lock held
> (q->current_entry_lock). Am I missing anything?
>
> But the situation in the current code is definitely worse, I admit,
> there are two additional calls to switch_schedules(), one in
> get_packet_txtime() and one in taprio_offload_config_changed(), these
> are done without the lock, but in these modes the hrtimer isn't running.
>
> I will send a patch fixing this, adding locking for those two extra
> cases as well.
>
> > Which lock is supposed to protect q->oper_sched and q->admin_sched ?
> >
> > This can not be q->current_entry_lock in some cases, and qdisc lock in =
others.
> >
>
> It should have been q->current_entry_lock.
>

If this helps, here is one trace that led to my questions:

BUG: KASAN: slab-use-after-free in advance_sched+0xc03/0xc60
net/sched/sch_taprio.c:953
Read of size 8 at addr ffff888027fbc910 by task kworker/u4:6/6820

CPU: 0 PID: 6820 Comm: kworker/u4:6 Not tainted
6.7.0-rc4-syzkaller-00954-g1b666016d0ad #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 11/17/2023
Workqueue: bat_events batadv_purge_orig
Call Trace:
<IRQ>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
print_address_description mm/kasan/report.c:364 [inline]
print_report+0xc4/0x620 mm/kasan/report.c:475
kasan_report+0xda/0x110 mm/kasan/report.c:588
advance_sched+0xc03/0xc60 net/sched/sch_taprio.c:953
__run_hrtimer kernel/time/hrtimer.c:1688 [inline]
__hrtimer_run_queues+0x203/0xc20 kernel/time/hrtimer.c:1752
hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
__sysvec_apic_timer_interrupt+0x105/0x400 arch/x86/kernel/apic/apic.c:1082
sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1076
</IRQ>
<TASK>
asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:6=
49
RIP: 0010:lock_acquire+0x1ef/0x520 kernel/locking/lockdep.c:5722
Code: c1 05 6d 69 9a 7e 83 f8 01 0f 85 b4 02 00 00 9c 58 f6 c4 02 0f
85 9f 02 00 00 48 85 ed 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01
c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
RSP: 0018:ffffc900042afa88 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff92000855f53 RCX: ffffffff81672f5e
RDX: 0000000000000001 RSI: ffffffff8accbc20 RDI: ffffffff8b2f13e0
RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff23e2deb
R10: ffffffff91f16f5f R11: 0000000000000002 R12: 0000000000000001
R13: 0000000000000000 R14: ffff88803c2bda18 R15: 0000000000000000
__raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
_raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
spin_lock_bh include/linux/spinlock.h:356 [inline]
batadv_purge_orig_ref+0x16d/0x1520 net/batman-adv/originator.c:1271
batadv_purge_orig+0x19/0x60 net/batman-adv/originator.c:1300
process_one_work+0x886/0x15d0 kernel/workqueue.c:2627
process_scheduled_works kernel/workqueue.c:2700 [inline]
worker_thread+0x8b9/0x1290 kernel/workqueue.c:2781
kthread+0x2c6/0x3a0 kernel/kthread.c:388
ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
</TASK>

Allocated by task 13485:
kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
kasan_set_track+0x25/0x30 mm/kasan/common.c:52
____kasan_kmalloc mm/kasan/common.c:374 [inline]
__kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
kmalloc include/linux/slab.h:600 [inline]
kzalloc include/linux/slab.h:721 [inline]
taprio_change+0x55a/0x38d0 net/sched/sch_taprio.c:1881
qdisc_change net/sched/sch_api.c:1387 [inline]
tc_modify_qdisc+0x7d5/0x1c30 net/sched/sch_api.c:1717
rtnetlink_rcv_msg+0x3c7/0xe00 net/core/rtnetlink.c:6566
netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2544
netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1367
netlink_sendmsg+0x8b7/0xd70 net/netlink/af_netlink.c:1909
sock_sendmsg_nosec net/socket.c:730 [inline]
__sock_sendmsg+0xd5/0x180 net/socket.c:745
____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
__sys_sendmsg+0x117/0x1e0 net/socket.c:2667
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x63/0x6b

Freed by task 13492:
kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
kasan_set_track+0x25/0x30 mm/kasan/common.c:52
kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
____kasan_slab_free mm/kasan/common.c:236 [inline]
____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
kasan_slab_free include/linux/kasan.h:164 [inline]
slab_free_hook mm/slub.c:1800 [inline]
slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
slab_free mm/slub.c:3809 [inline]
__kmem_cache_free+0xc0/0x180 mm/slub.c:3822
rcu_do_batch kernel/rcu/tree.c:2158 [inline]
rcu_core+0x819/0x1680 kernel/rcu/tree.c:2431
__do_softirq+0x21a/0x8de kernel/softirq.c:553

Last potentially related work creation:
kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
__kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
__call_rcu_common.constprop.0+0x9a/0x7a0 kernel/rcu/tree.c:2681
taprio_change+0x28f8/0x38d0 net/sched/sch_taprio.c:1991
qdisc_change net/sched/sch_api.c:1387 [inline]
tc_modify_qdisc+0x7d5/0x1c30 net/sched/sch_api.c:1717
rtnetlink_rcv_msg+0x3c7/0xe00 net/core/rtnetlink.c:6566
netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2544
netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1367
netlink_sendmsg+0x8b7/0xd70 net/netlink/af_netlink.c:1909
sock_sendmsg_nosec net/socket.c:730 [inline]
__sock_sendmsg+0xd5/0x180 net/socket.c:745
____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
__sys_sendmsg+0x117/0x1e0 net/socket.c:2667
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x63/0x6b

Second to last potentially related work creation:
kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
__kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
__call_rcu_common.constprop.0+0x9a/0x7a0 kernel/rcu/tree.c:2681
fib6_info_release include/net/ip6_fib.h:333 [inline]
nsim_rt6_release drivers/net/netdevsim/fib.c:515 [inline]
nsim_fib6_event_fini+0x1b1/0x280 drivers/net/netdevsim/fib.c:841
nsim_fib_event drivers/net/netdevsim/fib.c:891 [inline]
nsim_fib_event_work+0x2fe/0x26e0 drivers/net/netdevsim/fib.c:1492
process_one_work+0x886/0x15d0 kernel/workqueue.c:2627
process_scheduled_works kernel/workqueue.c:2700 [inline]
worker_thread+0x8b9/0x1290 kernel/workqueue.c:2781
kthread+0x2c6/0x3a0 kernel/kthread.c:388
ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff888027fbc800
which belongs to the cache kmalloc-512 of size 512
The buggy address is located 272 bytes inside of
freed 512-byte region [ffff888027fbc800, ffff888027fbca00)

The buggy address belongs to the physical page:
page:ffffea00009fef00 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x27fbc
head:ffffea00009fef00 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:=
0
flags: 0xfff00000000840(slab|head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888013041c80 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask
0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEM=
ALLOC),
pid 3285, tgid 3285 (kworker/u4:2), ts 18559127120, free_ts 0
set_page_owner include/linux/page_owner.h:31 [inline]
post_alloc_hook+0x2d0/0x350 mm/page_alloc.c:1544
prep_new_page mm/page_alloc.c:1551 [inline]
get_page_from_freelist+0xa28/0x3730 mm/page_alloc.c:3319
__alloc_pages+0x22e/0x2420 mm/page_alloc.c:4575
alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
alloc_slab_page mm/slub.c:1870 [inline]
allocate_slab mm/slub.c:2017 [inline]
new_slab+0x283/0x3c0 mm/slub.c:2070
___slab_alloc+0x979/0x1500 mm/slub.c:3223
__slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
__slab_alloc_node mm/slub.c:3375 [inline]
slab_alloc_node mm/slub.c:3468 [inline]
__kmem_cache_alloc_node+0x131/0x310 mm/slub.c:3517
kmalloc_trace+0x25/0x60 mm/slab_common.c:1098
kmalloc include/linux/slab.h:600 [inline]
kzalloc include/linux/slab.h:721 [inline]
alloc_bprm+0x51/0xb00 fs/exec.c:1512
kernel_execve+0xaf/0x4e0 fs/exec.c:1987
call_usermodehelper_exec_async+0x256/0x4c0 kernel/umh.c:110
ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
page_owner free stack trace missing

Memory state around the buggy address:
ffff888027fbc800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff888027fbc880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888027fbc900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
^
ffff888027fbc980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff888027fbca00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
----------------
Code disassembly (best guess):
0: c1 05 6d 69 9a 7e 83 roll $0x83,0x7e9a696d(%rip) # 0x7e9a6974
7: f8 clc
8: 01 0f add %ecx,(%rdi)
a: 85 b4 02 00 00 9c 58 test %esi,0x589c0000(%rdx,%rax,1)
11: f6 c4 02 test $0x2,%ah
14: 0f 85 9f 02 00 00 jne 0x2b9
1a: 48 85 ed test %rbp,%rbp
1d: 74 01 je 0x20
1f: fb sti
20: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
27: fc ff df
* 2a: 48 01 c3 add %rax,%rbx <-- trapping instruction
2d: 48 c7 03 00 00 00 00 movq $0x0,(%rbx)
34: 48 c7 43 08 00 00 00 movq $0x0,0x8(%rbx)
3b: 00
3c: 48 rex.W
3d: 8b .byte 0x8b
3e: 84 .byte 0x84
3f: 24 .byte 0x24

