Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC39675D8BB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 03:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjGVBdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 21:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjGVBdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 21:33:08 -0400
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9C3F0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 18:33:05 -0700 (PDT)
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-3a337ddff03so5424203b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 18:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689989585; x=1690594385;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EGneSsw2W3JsTncwuBQ5BR2huz2/kXRLLKAE4OLVETk=;
        b=GPiTUi97WkdKRNgj+xvof6e0+QHY513zggqypKsEoAwmkVKNjz92iIvf69dE9dhrgO
         PIhGP8ui99lCrpZYXhAyIToByYX0IfAMvZJaEwYQM2kQDkZwgT7TouKwLZW6NpcU5pc/
         UAbUq/NRF9oMaM0eEp7WHVIWepCM923BbgBb6D6zIzelOoW0q5tboeh6UCWIDTHVTRaU
         uyiwVji2ly6kwiy7QTdFT1pMMZMafv0/CKR++kVdfEc4PfoLtTP8Q6UYwfb/lE3BYey+
         iSyRps/VqC/+guDCOIa0w085GcfskANF9XyoCcEUMy9xMnyUK0wkMYsg0bmdZpQLYSXJ
         7R0A==
X-Gm-Message-State: ABy/qLY1pgKwzkCplrxBcVi5EU8xUH6Z0RYjnGfLmGujuEriIDkHhOQl
        Y3DAoeivwWLftN4GEXpDQsw8JJ9b16cR/d7ReCyBXkBRjNEe
X-Google-Smtp-Source: APBJJlEgoDvI/W0cw4bxYfv2aRQZhPhTElO0uEmSmHjNdlXJ2Mo/C/Wh9lxDNYZU+M/3JaOHdYWuzEi9z10zDZ0SREk3maahDBka
MIME-Version: 1.0
X-Received: by 2002:a05:6808:124d:b0:3a3:efef:5c74 with SMTP id
 o13-20020a056808124d00b003a3efef5c74mr7495482oiv.8.1689989585312; Fri, 21 Jul
 2023 18:33:05 -0700 (PDT)
Date:   Fri, 21 Jul 2023 18:33:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8231f0601095c8e@google.com>
Subject: [syzbot] [ppp?] possible deadlock in serial8250_handle_irq
From:   syzbot <syzbot+5fd749c74105b0e1b302@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, paulus@samba.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ccff6d117d8d Merge tag 'perf-tools-fixes-for-v6.5-1-2023-0..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1713931ea80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77b9a3cf8f44c6da
dashboard link: https://syzkaller.appspot.com/bug?extid=5fd749c74105b0e1b302
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d74f4e7b353d/disk-ccff6d11.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7c6a13965ec1/vmlinux-ccff6d11.xz
kernel image: https://storage.googleapis.com/syzbot-assets/282577dc8831/bzImage-ccff6d11.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5fd749c74105b0e1b302@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.5.0-rc2-syzkaller-00046-gccff6d117d8d #0 Not tainted
-----------------------------------------------------
kworker/0:8/17656 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffffffff8d9464f8 (disc_data_lock#2){.+.+}-{2:2}, at: ap_get+0x18/0xf0 drivers/net/ppp/ppp_async.c:136

and this task is already holding:
ffffffff92407e78 (&port_lock_key){-.-.}-{2:2}, at: serial_port_runtime_resume+0xcf/0x330 drivers/tty/serial/serial_port.c:38
which would create a new lock dependency:
 (&port_lock_key){-.-.}-{2:2} -> (disc_data_lock#2){.+.+}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&port_lock_key){-.-.}-{2:2}

... which became HARDIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5761 [inline]
  lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
  serial8250_handle_irq+0x91/0xbe0 drivers/tty/serial/8250/8250_port.c:1917
  serial8250_default_handle_irq+0x94/0x210 drivers/tty/serial/8250/8250_port.c:1963
  serial8250_interrupt+0xfc/0x200 drivers/tty/serial/8250/8250_core.c:127
  __handle_irq_event_percpu+0x22a/0x740 kernel/irq/handle.c:158
  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
  handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
  handle_edge_irq+0x261/0xcf0 kernel/irq/chip.c:834
  generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
  handle_irq arch/x86/kernel/irq.c:238 [inline]
  __common_interrupt+0x9f/0x220 arch/x86/kernel/irq.c:257
  common_interrupt+0xa9/0xd0 arch/x86/kernel/irq.c:247
  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:636
  native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
  arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
  __intel_idle_hlt drivers/idle/intel_idle.c:205 [inline]
  intel_idle_hlt+0x11/0x20 drivers/idle/intel_idle.c:224
  cpuidle_enter_state+0x82/0x500 drivers/cpuidle/cpuidle.c:267
  cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
  cpuidle_idle_call kernel/sched/idle.c:215 [inline]
  do_idle+0x315/0x3f0 kernel/sched/idle.c:282
  cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:379
  start_secondary+0x200/0x290 arch/x86/kernel/smpboot.c:326
  secondary_startup_64_no_verify+0x167/0x16b

to a HARDIRQ-irq-unsafe lock:
 (disc_data_lock#2){.+.+}-{2:2}

... which became HARDIRQ-irq-unsafe at:
...
  lock_acquire kernel/locking/lockdep.c:5761 [inline]
  lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
  __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
  _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
  ap_get+0x18/0xf0 drivers/net/ppp/ppp_async.c:136
  ppp_asynctty_receive+0x2f/0x1580 drivers/net/ppp/ppp_async.c:343
  tty_ldisc_receive_buf+0x143/0x180 drivers/tty/tty_buffer.c:461
  tty_port_default_receive_buf+0x6f/0xa0 drivers/tty/tty_port.c:39
  receive_buf drivers/tty/tty_buffer.c:515 [inline]
  flush_to_ldisc+0x252/0x7c0 drivers/tty/tty_buffer.c:565
  process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
  worker_thread+0x687/0x1110 kernel/workqueue.c:2748
  kthread+0x33a/0x430 kernel/kthread.c:389
  ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(disc_data_lock#2);
                               local_irq_disable();
                               lock(&port_lock_key);
                               lock(disc_data_lock#2);
  <Interrupt>
    lock(&port_lock_key);

 *** DEADLOCK ***

4 locks held by kworker/0:8/17656:
 #0: ffff888018a5e538 ((wq_completion)pm){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:20 [inline]
 #0: ffff888018a5e538 ((wq_completion)pm){+.+.}-{0:0}, at: raw_atomic64_set include/linux/atomic/atomic-arch-fallback.h:2608 [inline]
 #0: ffff888018a5e538 ((wq_completion)pm){+.+.}-{0:0}, at: raw_atomic_long_set include/linux/atomic/atomic-long.h:79 [inline]
 #0: ffff888018a5e538 ((wq_completion)pm){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:3196 [inline]
 #0: ffff888018a5e538 ((wq_completion)pm){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:675 [inline]
 #0: ffff888018a5e538 ((wq_completion)pm){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:702 [inline]
 #0: ffff888018a5e538 ((wq_completion)pm){+.+.}-{0:0}, at: process_one_work+0x96a/0x16f0 kernel/workqueue.c:2567
 #1: ffffc9000c1cfd80 ((work_completion)(&dev->power.work)){+.+.}-{0:0}, at: process_one_work+0x99e/0x16f0 kernel/workqueue.c:2571
 #2: ffffffff92407e78 (&port_lock_key){-.-.}-{2:2}, at: serial_port_runtime_resume+0xcf/0x330 drivers/tty/serial/serial_port.c:38
 #3: ffff88805536a098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref+0x1c/0x80 drivers/tty/tty_ldisc.c:263

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&port_lock_key){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5761 [inline]
                    lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
                    serial8250_handle_irq+0x91/0xbe0 drivers/tty/serial/8250/8250_port.c:1917
                    serial8250_default_handle_irq+0x94/0x210 drivers/tty/serial/8250/8250_port.c:1963
                    serial8250_interrupt+0xfc/0x200 drivers/tty/serial/8250/8250_core.c:127
                    __handle_irq_event_percpu+0x22a/0x740 kernel/irq/handle.c:158
                    handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                    handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
                    handle_edge_irq+0x261/0xcf0 kernel/irq/chip.c:834
                    generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
                    handle_irq arch/x86/kernel/irq.c:238 [inline]
                    __common_interrupt+0x9f/0x220 arch/x86/kernel/irq.c:257
                    common_interrupt+0xa9/0xd0 arch/x86/kernel/irq.c:247
                    asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:636
                    native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                    arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
                    __intel_idle_hlt drivers/idle/intel_idle.c:205 [inline]
                    intel_idle_hlt+0x11/0x20 drivers/idle/intel_idle.c:224
                    cpuidle_enter_state+0x82/0x500 drivers/cpuidle/cpuidle.c:267
                    cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
                    cpuidle_idle_call kernel/sched/idle.c:215 [inline]
                    do_idle+0x315/0x3f0 kernel/sched/idle.c:282
                    cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:379
                    start_secondary+0x200/0x290 arch/x86/kernel/smpboot.c:326
                    secondary_startup_64_no_verify+0x167/0x16b
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5761 [inline]
                    lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
                    serial8250_handle_irq+0x91/0xbe0 drivers/tty/serial/8250/8250_port.c:1917
                    serial8250_default_handle_irq+0x94/0x210 drivers/tty/serial/8250/8250_port.c:1963
                    serial8250_interrupt+0xfc/0x200 drivers/tty/serial/8250/8250_core.c:127
                    __handle_irq_event_percpu+0x22a/0x740 kernel/irq/handle.c:158
                    handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                    handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
                    handle_edge_irq+0x261/0xcf0 kernel/irq/chip.c:834
                    generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
                    handle_irq arch/x86/kernel/irq.c:238 [inline]
                    __common_interrupt+0x9f/0x220 arch/x86/kernel/irq.c:257
                    common_interrupt+0x51/0xd0 arch/x86/kernel/irq.c:247
                    asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:636
                    variable_ffs arch/x86/include/asm/bitops.h:319 [inline]
                    __do_softirq+0x1dd/0x965 kernel/softirq.c:541
                    invoke_softirq kernel/softirq.c:427 [inline]
                    __irq_exit_rcu kernel/softirq.c:632 [inline]
                    irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
                    sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1109
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
                    __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
                    _raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.c:202
                    spin_unlock_irq include/linux/spinlock.h:401 [inline]
                    seccomp_set_mode_filter kernel/seccomp.c:1916 [inline]
                    do_seccomp+0xae1/0x27f0 kernel/seccomp.c:1991
                    prctl_set_seccomp+0x4b/0x70 kernel/seccomp.c:2044
                    __do_sys_prctl+0xd11/0x1d40 kernel/sys.c:2490
                    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                    do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
                    entry_SYSCALL_64_after_hwframe+0x63/0xcd
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5761 [inline]
                   lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
                   serial8250_do_set_termios+0x334/0x1240 drivers/tty/serial/8250/8250_port.c:2794
                   serial8250_set_termios+0x6b/0x80 drivers/tty/serial/8250/8250_port.c:2913
                   uart_set_options+0x30e/0x5e0 drivers/tty/serial/serial_core.c:2284
                   serial8250_console_setup+0x18a/0x430 drivers/tty/serial/8250/8250_port.c:3507
                   univ8250_console_setup+0x168/0x210 drivers/tty/serial/8250/8250_core.c:631
                   try_enable_preferred_console+0x24d/0x470 kernel/printk/printk.c:3228
                   register_console+0x331/0x10d0 kernel/printk/printk.c:3401
                   univ8250_console_init+0x35/0x50 drivers/tty/serial/8250/8250_core.c:716
                   console_init+0xba/0x5c0 kernel/printk/printk.c:3601
                   start_kernel+0x25a/0x480 init/main.c:1004
                   x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
                   x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:537
                   secondary_startup_64_no_verify+0x167/0x16b
 }
 ... key      at: [<ffffffff924070e0>] port_lock_key+0x0/0x40

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (disc_data_lock#2){.+.+}-{2:2} {
   HARDIRQ-ON-R at:
                    lock_acquire kernel/locking/lockdep.c:5761 [inline]
                    lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
                    ap_get+0x18/0xf0 drivers/net/ppp/ppp_async.c:136
                    ppp_asynctty_receive+0x2f/0x1580 drivers/net/ppp/ppp_async.c:343
                    tty_ldisc_receive_buf+0x143/0x180 drivers/tty/tty_buffer.c:461
                    tty_port_default_receive_buf+0x6f/0xa0 drivers/tty/tty_port.c:39
                    receive_buf drivers/tty/tty_buffer.c:515 [inline]
                    flush_to_ldisc+0x252/0x7c0 drivers/tty/tty_buffer.c:565
                    process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
                    worker_thread+0x687/0x1110 kernel/workqueue.c:2748
                    kthread+0x33a/0x430 kernel/kthread.c:389
                    ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
                    ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296
   SOFTIRQ-ON-R at:
                    lock_acquire kernel/locking/lockdep.c:5761 [inline]
                    lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
                    ap_get+0x18/0xf0 drivers/net/ppp/ppp_async.c:136
                    ppp_asynctty_receive+0x2f/0x1580 drivers/net/ppp/ppp_async.c:343
                    tty_ldisc_receive_buf+0x143/0x180 drivers/tty/tty_buffer.c:461
                    tty_port_default_receive_buf+0x6f/0xa0 drivers/tty/tty_port.c:39
                    receive_buf drivers/tty/tty_buffer.c:515 [inline]
                    flush_to_ldisc+0x252/0x7c0 drivers/tty/tty_buffer.c:565
                    process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
                    worker_thread+0x687/0x1110 kernel/workqueue.c:2748
                    kthread+0x33a/0x430 kernel/kthread.c:389
                    ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
                    ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5761 [inline]
                   lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                   _raw_write_lock_irq+0x36/0x50 kernel/locking/spinlock.c:326
                   ppp_asynctty_close+0x1c/0x1c0 drivers/net/ppp/ppp_async.c:219
                   tty_ldisc_close+0x111/0x190 drivers/tty/tty_ldisc.c:455
                   tty_ldisc_kill+0x94/0x150 drivers/tty/tty_ldisc.c:607
                   tty_ldisc_release+0x116/0x2a0 drivers/tty/tty_ldisc.c:775
                   tty_release_struct+0x23/0xe0 drivers/tty/tty_io.c:1698
                   tty_release+0xe23/0x1410 drivers/tty/tty_io.c:1869
                   __fput+0x3fd/0xac0 fs/file_table.c:384
                   task_work_run+0x14d/0x240 kernel/task_work.c:179
                   resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
                   exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
                   exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
                   __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
                   syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
                   do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
                   entry_SYSCALL_64_after_hwframe+0x63/0xcd
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5761 [inline]
                        lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
                        __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                        _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
                        ap_get+0x18/0xf0 drivers/net/ppp/ppp_async.c:136
                        ppp_asynctty_receive+0x2f/0x1580 drivers/net/ppp/ppp_async.c:343
                        tty_ldisc_receive_buf+0x143/0x180 drivers/tty/tty_buffer.c:461
                        tty_port_default_receive_buf+0x6f/0xa0 drivers/tty/tty_port.c:39
                        receive_buf drivers/tty/tty_buffer.c:515 [inline]
                        flush_to_ldisc+0x252/0x7c0 drivers/tty/tty_buffer.c:565
                        process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
                        worker_thread+0x687/0x1110 kernel/workqueue.c:2748
                        kthread+0x33a/0x430 kernel/kthread.c:389
                        ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
                        ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296
 }
 ... key      at: [<ffffffff8d9464f8>] disc_data_lock+0x18/0x60
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5761 [inline]
   lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
   ap_get+0x18/0xf0 drivers/net/ppp/ppp_async.c:136
   ppp_asynctty_wakeup+0x18/0xb0 drivers/net/ppp/ppp_async.c:360
   tty_wakeup+0xe5/0x120 drivers/tty/tty_io.c:525
   tty_port_default_wakeup+0x2a/0x40 drivers/tty/tty_port.c:71
   serial8250_tx_chars+0x542/0xf60 drivers/tty/serial/8250/8250_port.c:1839
   __start_tx drivers/tty/serial/8250/8250_port.c:1547 [inline]
   serial8250_start_tx+0x7a8/0x980 drivers/tty/serial/8250/8250_port.c:1656
   serial_port_runtime_resume+0x29e/0x330 drivers/tty/serial/serial_port.c:40
   __rpm_callback+0xc5/0x4c0 drivers/base/power/runtime.c:392
   rpm_callback+0x1da/0x220 drivers/base/power/runtime.c:446
   rpm_resume+0xdb9/0x1980 drivers/base/power/runtime.c:912
   pm_runtime_work+0x12e/0x180 drivers/base/power/runtime.c:977
   process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
   worker_thread+0x687/0x1110 kernel/workqueue.c:2748
   kthread+0x33a/0x430 kernel/kthread.c:389
   ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296


stack backtrace:
CPU: 0 PID: 17656 Comm: kworker/0:8 Not tainted 6.5.0-rc2-syzkaller-00046-gccff6d117d8d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Workqueue: pm pm_runtime_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_bad_irq_dependency kernel/locking/lockdep.c:2634 [inline]
 check_irq_usage+0x10b8/0x1c70 kernel/locking/lockdep.c:2873
 check_prev_add kernel/locking/lockdep.c:3146 [inline]
 check_prevs_add kernel/locking/lockdep.c:3261 [inline]
 validate_chain kernel/locking/lockdep.c:3876 [inline]
 __lock_acquire+0x2e53/0x5de0 kernel/locking/lockdep.c:5144
 lock_acquire kernel/locking/lockdep.c:5761 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
 __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
 _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
 ap_get+0x18/0xf0 drivers/net/ppp/ppp_async.c:136
 ppp_asynctty_wakeup+0x18/0xb0 drivers/net/ppp/ppp_async.c:360
 tty_wakeup+0xe5/0x120 drivers/tty/tty_io.c:525
 tty_port_default_wakeup+0x2a/0x40 drivers/tty/tty_port.c:71
 serial8250_tx_chars+0x542/0xf60 drivers/tty/serial/8250/8250_port.c:1839
 __start_tx drivers/tty/serial/8250/8250_port.c:1547 [inline]
 serial8250_start_tx+0x7a8/0x980 drivers/tty/serial/8250/8250_port.c:1656
 serial_port_runtime_resume+0x29e/0x330 drivers/tty/serial/serial_port.c:40
 __rpm_callback+0xc5/0x4c0 drivers/base/power/runtime.c:392
 rpm_callback+0x1da/0x220 drivers/base/power/runtime.c:446
 rpm_resume+0xdb9/0x1980 drivers/base/power/runtime.c:912
 pm_runtime_work+0x12e/0x180 drivers/base/power/runtime.c:977
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x687/0x1110 kernel/workqueue.c:2748
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296
RIP: 0000:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
usb 3-1: USB disconnect, device number 41
usb 3-1: new high-speed USB device number 42 using dummy_hcd
usb 3-1: Using ep0 maxpacket: 16
usb 3-1: config 0 interface 0 altsetting 0 endpoint 0x81 has an invalid bInterval 0, changing to 7
usb 3-1: config 0 interface 0 altsetting 0 has 1 endpoint descriptor, different from the interface descriptor's value: 9
usb 3-1: New USB device found, idVendor=045e, idProduct=07da, bcdDevice= 0.00
usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 3-1: config 0 descriptor??
HID 045e:07da: Invalid code 65791 type 1
input: HID 045e:07da as /devices/platform/dummy_hcd.2/usb3/3-1/3-1:0.0/0003:045E:07DA.0037/input/input64
microsoft 0003:045E:07DA.0037: input,hidraw0: USB HID v0.00 Device [HID 045e:07da] on usb-dummy_hcd.2-1/input0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
