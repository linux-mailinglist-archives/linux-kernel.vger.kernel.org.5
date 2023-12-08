Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4248096ED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444140AbjLHAIE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Dec 2023 19:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLHAIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:08:02 -0500
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55916170F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:08:06 -0800 (PST)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1faeac8b074so3283822fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:08:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701994085; x=1702598885;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c68a/kyNmLIIL7R/HVmYOehAmowTMGm/eeQ3XQpi/kM=;
        b=KnZI/R+Nf3chcGzsoCbM5CWeN32wjm+VSNo5YWCUI39wfTu6dA2Kgdpvd0D0ivjN3B
         eP/Lvd+/IHLd7g5CruvrB0BwOjyVyPmjEL7Q93yYrFeJwMRlO2uy3gK54FCyeNj5ldye
         43U0qjQfBpXYjin/efPMhRTyqAFqZ2cx7P5psx8cE0GZSVkjbge2a2Yug0c+Iw18iazK
         AbU7rpPnSETNup1aA9c1bzeItbNPRniaKf2ZxCH0hGRQ8A6a9r5wSgRFbQDSejGJW3WD
         yZYffc2glIhZpnQT5fRh8/fsHOEpuaLMHkzvChZ3hB6LhREoobaxd/SdRF4o30sBihQC
         APtw==
X-Gm-Message-State: AOJu0YyvCx7KuQrYW9x57MdmaJrgWb2rkk5NLuGoXxL8eZpBhxNTM2tO
        BG1pCzPqDVbHfLf+z8JGh9Ww7WqikRM13ENUyh1fepyYCX6+O6WDmA==
X-Google-Smtp-Source: AGHT+IEJy66H/NcRXW+BqJ1R8iMmqbqhBHPHj85ws7DvnbQUCXv+8IJK81Lf9XT0kSuXZ9bK2rPMDUnIAloTLPE5PtLcDZg1+Pr4
MIME-Version: 1.0
X-Received: by 2002:a05:6870:e410:b0:1fb:24bb:20ba with SMTP id
 n16-20020a056870e41000b001fb24bb20bamr4129326oag.9.1701994085703; Thu, 07 Dec
 2023 16:08:05 -0800 (PST)
Date:   Thu, 07 Dec 2023 16:08:05 -0800
In-Reply-To: <93835aea-7f9a-4026-ad45-c9d5ab62a3d3@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3666a060bf460ae@google.com>
Subject: Re: [syzbot] [net?] WARNING in ip6_route_info_create
From:   syzbot <syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, sinquersw@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

76.559062][ T5064] chnl_net:caif_netlink_parms(): no params data found
[   76.643777][ T5064] bridge0: port 1(bridge_slave_0) entered blocking state
[   76.651414][ T5064] bridge0: port 1(bridge_slave_0) entered disabled state
[   76.658900][ T5064] bridge_slave_0: entered allmulticast mode
[   76.666479][ T5064] bridge_slave_0: entered promiscuous mode
[   76.677504][ T5064] bridge0: port 2(bridge_slave_1) entered blocking state
[   76.684726][ T5064] bridge0: port 2(bridge_slave_1) entered disabled state
[   76.692313][ T5064] bridge_slave_1: entered allmulticast mode
[   76.700260][ T5064] bridge_slave_1: entered promiscuous mode
[   76.736969][ T5064] bond0: (slave bond_slave_0): Enslaving as an active interface with an up link
[   76.750084][ T5064] bond0: (slave bond_slave_1): Enslaving as an active interface with an up link
[   76.789051][ T5064] team0: Port device team_slave_0 added
[   76.799438][ T5064] team0: Port device team_slave_1 added
[   76.831411][ T5064] batman_adv: batadv0: Adding interface: batadv_slave_0
[   76.838650][ T5064] batman_adv: batadv0: The MTU of interface batadv_slave_0 is too small (1500) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
[   76.865205][ T5064] batman_adv: batadv0: Not using interface batadv_slave_0 (retrying later): interface not active
[   76.879442][ T5064] batman_adv: batadv0: Adding interface: batadv_slave_1
[   76.886943][ T5064] batman_adv: batadv0: The MTU of interface batadv_slave_1 is too small (1500) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
[   76.913369][ T5064] batman_adv: batadv0: Not using interface batadv_slave_1 (retrying later): interface not active
[   76.966579][ T5064] hsr_slave_0: entered promiscuous mode
[   76.973593][ T5064] hsr_slave_1: entered promiscuous mode
executing program
[   77.146981][ T5064] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   77.161861][ T5064] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   77.173875][ T5064] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   77.185116][ T5064] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   77.222259][ T5064] bridge0: port 2(bridge_slave_1) entered blocking state
[   77.229852][ T5064] bridge0: port 2(bridge_slave_1) entered forwarding state
[   77.238410][ T5064] bridge0: port 1(bridge_slave_0) entered blocking state
[   77.245959][ T5064] bridge0: port 1(bridge_slave_0) entered forwarding state
[   77.330440][ T5064] 8021q: adding VLAN 0 to HW filter on device bond0
[   77.351648][    T8] bridge0: port 1(bridge_slave_0) entered disabled state
[   77.373341][    T8] bridge0: port 2(bridge_slave_1) entered disabled state
[  182.405611][    C1] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  182.413039][    C1] rcu: 	0-...!: (1 GPs behind) idle=678c/1/0x4000000000000000 softirq=6235/6245 fqs=5
[  182.423532][    C1] rcu: 	(detected by 1, t=10502 jiffies, g=7501, q=25 ncpus=2)
[  182.431133][    C1] Sending NMI from CPU 1 to CPUs 0:
[  182.437070][    C0] NMI backtrace for cpu 0
[  182.437082][    C0] CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.7.0-rc3-syzkaller-00813-ga5e1700298fd #0
[  182.437104][    C0] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
[  182.437118][    C0] Workqueue: events linkwatch_event
[  182.437175][    C0] RIP: 0010:__linkwatch_run_queue+0x1fa/0x460
[  182.437205][    C0] Code: 85 05 02 00 00 4c 89 e9 4c 89 6a 08 48 c1 e9 03 80 3c 29 00 0f 85 d9 01 00 00 49 89 55 00 e8 fd f0 10 f9 48 89 d8 48 c1 e8 03 <80> 3c 28 00 0f 85 b2 01 00 00 4c 89 f8 48 89 1b 48 c1 e8 03 80 3c
[  182.437224][    C0] RSP: 0018:ffffc900000d7c50 EFLAGS: 00000802
[  182.437240][    C0] RAX: 1ffff1100d23bcd5 RBX: ffff8880691de6a8 RCX: 1ffffffff1d55714
[  182.437254][    C0] RDX: ffff88801665d940 RSI: ffffffff8876a153 RDI: ffff8880691dc6b0
[  182.437267][    C0] RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000000
[  182.437280][    C0] R10: 0000000000000001 R11: 0000000000000003 R12: 00000000000000bd
[  182.437292][    C0] R13: ffffffff8eaab8a0 R14: ffff8880691de000 R15: ffff8880691de6b0
[  182.437306][    C0] FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
[  182.437326][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  182.437340][    C0] CR2: 00007ffe776596e8 CR3: 0000000024fce000 CR4: 00000000003506f0
[  182.437353][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  182.437365][    C0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  182.437377][    C0] Call Trace:
[  182.437387][    C0]  <NMI>
[  182.437396][    C0]  ? show_regs+0x8f/0xa0
[  182.437424][    C0]  ? nmi_cpu_backtrace+0x1d4/0x390
[  182.437451][    C0]  ? nmi_cpu_backtrace_handler+0xc/0x10
[  182.437481][    C0]  ? nmi_handle+0x1a6/0x570
[  182.437506][    C0]  ? __linkwatch_run_queue+0x1fa/0x460
[  182.437534][    C0]  ? default_do_nmi+0x6a/0x160
[  182.437563][    C0]  ? exc_nmi+0x186/0x200
[  182.437589][    C0]  ? end_repeat_nmi+0xf/0x2a
[  182.437615][    C0]  ? __linkwatch_run_queue+0x1f3/0x460
[  182.437641][    C0]  ? __linkwatch_run_queue+0x1fa/0x460
[  182.437669][    C0]  ? __linkwatch_run_queue+0x1fa/0x460
[  182.437703][    C0]  ? __linkwatch_run_queue+0x1fa/0x460
[  182.437730][    C0]  </NMI>
[  182.437736][    C0]  <TASK>
[  182.437744][    C0]  linkwatch_event+0x8f/0xc0
[  182.437771][    C0]  ? __linkwatch_run_queue+0x460/0x460
[  182.437799][    C0]  ? rcu_is_watching+0x12/0xb0
[  182.437823][    C0]  process_one_work+0x886/0x15d0
[  182.437857][    C0]  ? lock_sync+0x190/0x190
[  182.437887][    C0]  ? workqueue_congested+0x300/0x300
[  182.437919][    C0]  ? assign_work+0x1a0/0x250
[  182.437946][    C0]  worker_thread+0x8b9/0x1290
[  182.437979][    C0]  ? process_one_work+0x15d0/0x15d0
[  182.438006][    C0]  kthread+0x2c6/0x3a0
[  182.438033][    C0]  ? _raw_spin_unlock_irq+0x23/0x50
[  182.438056][    C0]  ? kthread_complete_and_exit+0x40/0x40
[  182.438082][    C0]  ret_from_fork+0x45/0x80
[  182.438107][    C0]  ? kthread_complete_and_exit+0x40/0x40
[  182.438132][    C0]  ret_from_fork_asm+0x11/0x20
[  182.438169][    C0]  </TASK>
[  182.439064][    C1] rcu: rcu_preempt kthread starved for 10492 jiffies! g7501 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
[  182.747203][    C1] rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[  182.757290][    C1] rcu: RCU grace-period kthread stack dump:
[  182.763189][    C1] task:rcu_preempt     state:R  running task     stack:27480 pid:17    tgid:17    ppid:2      flags:0x00004000
[  182.775649][    C1] Call Trace:
[  182.778946][    C1]  <TASK>
[  182.781909][    C1]  __schedule+0xedb/0x5af0
[  182.786453][    C1]  ? lockdep_hardirqs_on_prepare+0x420/0x420
[  182.792499][    C1]  ? io_schedule_timeout+0x150/0x150
[  182.797914][    C1]  ? schedule+0x1fc/0x270
[  182.802408][    C1]  ? reacquire_held_locks+0x4c0/0x4c0
[  182.809840][    C1]  ? timer_fixup_activate+0x220/0x220
[  182.815483][    C1]  ? lockdep_init_map_type+0x16d/0x7d0
[  182.820980][    C1]  schedule+0xe9/0x270
[  182.825112][    C1]  schedule_timeout+0x137/0x290
[  182.830080][    C1]  ? usleep_range_state+0x1a0/0x1a0
[  182.835327][    C1]  ? do_init_timer+0x100/0x100
[  182.840422][    C1]  ? _raw_spin_unlock_irqrestore+0x3b/0x70
[  182.846449][    C1]  ? prepare_to_swait_event+0xf4/0x470
[  182.852142][    C1]  rcu_gp_fqs_loop+0x1ec/0xb10
[  182.856953][    C1]  ? rcu_check_gp_kthread_starvation+0x450/0x450
[  182.863319][    C1]  ? reacquire_held_locks+0x4c0/0x4c0
[  182.868829][    C1]  rcu_gp_kthread+0x24b/0x380
[  182.873666][    C1]  ? rcu_gp_init+0x1510/0x1510
[  182.878553][    C1]  ? lockdep_hardirqs_on+0x7d/0x110
[  182.883882][    C1]  ? __kthread_parkme+0x14b/0x220
[  182.889025][    C1]  ? rcu_gp_init+0x1510/0x1510
[  182.894077][    C1]  kthread+0x2c6/0x3a0
[  182.898261][    C1]  ? _raw_spin_unlock_irq+0x23/0x50
[  182.903604][    C1]  ? kthread_complete_and_exit+0x40/0x40
[  182.909438][    C1]  ret_from_fork+0x45/0x80
[  182.913881][    C1]  ? kthread_complete_and_exit+0x40/0x40
[  182.919791][    C1]  ret_from_fork_asm+0x11/0x20
[  182.924798][    C1]  </TASK>
[  182.928629][    C1] rcu: Stack dump where RCU GP kthread last ran:
[  182.935053][    C1] CPU: 1 PID: 11 Comm: kworker/u4:0 Not tainted 6.7.0-rc3-syzkaller-00813-ga5e1700298fd #0
[  182.945064][    C1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
[  182.955572][    C1] Workqueue: events_unbound toggle_allocation_gate
[  182.962365][    C1] RIP: 0010:smp_call_function_many_cond+0x4e4/0x1550
[  182.969594][    C1] Code: 0b 00 85 ed 74 4d 48 b8 00 00 00 00 00 fc ff df 4d 89 f4 4c 89 f5 49 c1 ec 03 83 e5 07 49 01 c4 83 c5 03 e8 8e c0 0b 00 f3 90 <41> 0f b6 04 24 40 38 c5 7c 08 84 c0 0f 85 24 0e 00 00 8b 43 08 31
[  182.989601][    C1] RSP: 0018:ffffc90000107930 EFLAGS: 00000293
[  182.995897][    C1] RAX: 0000000000000000 RBX: ffff8880b98441a0 RCX: ffffffff817bd1e8
[  183.004197][    C1] RDX: ffff888016663b80 RSI: ffffffff817bd1c2 RDI: 0000000000000005
[  183.012511][    C1] RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
[  183.020942][    C1] R10: 0000000000000001 R11: 0000000000000006 R12: ffffed1017308835
[  183.029238][    C1] R13: 0000000000000001 R14: ffff8880b98441a8 R15: ffff8880b993d8c0
[  183.037444][    C1] FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
[  183.046874][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  183.053529][    C1] CR2: 00007f2fa42c35c0 CR3: 000000000cd77000 CR4: 00000000003506f0
[  183.061657][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  183.069862][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  183.078121][    C1] Call Trace:
[  183.081530][    C1]  <IRQ>
[  183.084842][    C1]  ? show_regs+0x8f/0xa0
[  183.089387][    C1]  ? rcu_check_gp_kthread_starvation+0x317/0x450
[  183.095999][    C1]  ? do_raw_spin_unlock+0x173/0x230
[  183.101217][    C1]  ? rcu_sched_clock_irq+0x2269/0x3150
[  183.106770][    C1]  ? rcu_note_context_switch+0x1ae0/0x1ae0
[  183.112634][    C1]  ? tick_sched_do_timer+0x2e0/0x2e0
[  183.118116][    C1]  ? update_process_times+0x17b/0x220
[  183.124301][    C1]  ? timer_clear_idle+0xa0/0xa0
[  183.129378][    C1]  ? update_wall_time+0x1c/0x40
[  183.134511][    C1]  ? tick_do_update_jiffies64+0x22e/0x380
[  183.140622][    C1]  ? tick_sched_handle+0x8e/0x170
[  183.145932][    C1]  ? tick_nohz_highres_handler+0xe9/0x110
[  183.151688][    C1]  ? __hrtimer_run_queues+0x647/0xc20
[  183.157214][    C1]  ? enqueue_hrtimer+0x310/0x310
[  183.162352][    C1]  ? ktime_get_update_offsets_now+0x3bc/0x610
[  183.168976][    C1]  ? hrtimer_interrupt+0x31b/0x800
[  183.174658][    C1]  ? __sysvec_apic_timer_interrupt+0x105/0x400
[  183.181375][    C1]  ? sysvec_apic_timer_interrupt+0x90/0xb0
[  183.187325][    C1]  </IRQ>
[  183.190321][    C1]  <TASK>
[  183.193473][    C1]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  183.199798][    C1]  ? smp_call_function_many_cond+0x508/0x1550
[  183.206008][    C1]  ? smp_call_function_many_cond+0x4e2/0x1550
[  183.212274][    C1]  ? smp_call_function_many_cond+0x4e4/0x1550
[  183.218378][    C1]  ? __text_poke+0xca0/0xca0
[  183.222988][    C1]  ? __kmem_cache_alloc_node+0xc3/0x310
[  183.228759][    C1]  ? generic_smp_call_function_single_interrupt+0x20/0x20
[  183.236244][    C1]  ? apply_relocation+0x830/0x830
[  183.241937][    C1]  ? __text_poke+0xca0/0xca0
[  183.247038][    C1]  on_each_cpu_cond_mask+0x40/0x90
[  183.254673][    C1]  text_poke_bp_batch+0x22b/0x750
[  183.260048][    C1]  ? arch_jump_label_transform_apply+0x17/0x30
[  183.266472][    C1]  ? alternatives_enable_smp+0x400/0x400
[  183.272321][    C1]  ? __jump_label_patch+0x1db/0x400
[  183.278635][    C1]  ? text_poke_queue+0xef/0x180
[  183.284337][    C1]  ? arch_jump_label_transform_queue+0xc0/0x110
[  183.290718][    C1]  text_poke_finish+0x30/0x40
[  183.295802][    C1]  arch_jump_label_transform_apply+0x1c/0x30
[  183.301928][    C1]  jump_label_update+0x1d7/0x400
[  183.306906][    C1]  static_key_enable_cpuslocked+0x1b7/0x270
[  183.313298][    C1]  static_key_enable+0x1a/0x20
[  183.318321][    C1]  toggle_allocation_gate+0xf4/0x250
[  183.323742][    C1]  ? wake_up_kfence_timer+0x30/0x30
[  183.329079][    C1]  process_one_work+0x886/0x15d0
[  183.334242][    C1]  ? lock_sync+0x190/0x190
[  183.338799][    C1]  ? workqueue_congested+0x300/0x300
[  183.344376][    C1]  ? assign_work+0x1a0/0x250
[  183.349092][    C1]  worker_thread+0x8b9/0x1290
[  183.353898][    C1]  ? process_one_work+0x15d0/0x15d0
[  183.359381][    C1]  kthread+0x2c6/0x3a0
[  183.363474][    C1]  ? _raw_spin_unlock_irq+0x23/0x50
[  183.368873][    C1]  ? kthread_complete_and_exit+0x40/0x40
[  183.374536][    C1]  ret_from_fork+0x45/0x80
[  183.379242][    C1]  ? kthread_complete_and_exit+0x40/0x40
[  183.385436][    C1]  ret_from_fork_asm+0x11/0x20
[  183.390247][    C1]  </TASK>


syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs-2/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs-2/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.20.1"
GCCGO="gccgo"
GOAMD64="v1"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.mod"
GOWORK=""
CGO_CFLAGS="-O2 -g"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-O2 -g"
CGO_FFLAGS="-O2 -g"
CGO_LDFLAGS="-O2 -g"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build2932039887=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at 28b24332d
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=28b24332d95f2f7df44ec7e7a5e0025bcadc6277 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20231207-101622'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=28b24332d95f2f7df44ec7e7a5e0025bcadc6277 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20231207-101622'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=28b24332d95f2f7df44ec7e7a5e0025bcadc6277 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20231207-101622'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"28b24332d95f2f7df44ec7e7a5e0025bcadc6277\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=10a63a0ae80000


Tested on:

commit:         a5e17002 net/ipv6: insert the fib6 gc_link of a fib6_i..
git tree:       https://github.com/ThinkerYzu/linux.git fix-fib6_set_expires_locked
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8715b6ede5c4b90
dashboard link: https://syzkaller.appspot.com/bug?extid=c15aa445274af8674f41
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
