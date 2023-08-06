Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61A4771396
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 06:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjHFETN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 00:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHFETL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 00:19:11 -0400
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B731FDB
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 21:19:09 -0700 (PDT)
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-6bc6e6390fcso6113405a34.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 21:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691295548; x=1691900348;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+X+IKnyndSBhTYVS/xhJd3tcTWpCXp75Nd45F3AMQI=;
        b=GXz9pFxICkp+C6BNdTeaPOoG+tel7jnOjG+kEo8PPgxGegzYiYbbQ1SmExrVxb18og
         IjpeVLKLbnFGbE7AuQoxic+vY4KDEjeI764DZI3EJtD/Kklo49yCoEederoHQ+P/H8ih
         Tvii+QrXSjUSrTkQ1H95NEi6eGruqkL9HzaA1tCOwEDB/Otm9B81pUyGAVPU++9EC7dj
         5p5zyinGkDlhE5PhnNNt0GdBlvUXy2q12gnYmyv0QcT/9dcceE58WVi6cIh7NozmHGs7
         2ltGQsQfelwFbfTx/JI0SKY7r+dHLkECFhnJvKfDUwwpaR/EhYUNrj7RMJ3dyv41VLeu
         P1YQ==
X-Gm-Message-State: AOJu0YwZeFDcfFyZWh8+Yg9WmhlMmOeTump44eWP1Ofqcnki8fiSMIUH
        25zCprFV/uCY/iOrZduntPGlctddxfCbTY8b79l4aAOvMc5j
X-Google-Smtp-Source: AGHT+IFw4luIMOZvsURttPTyktmmzr6d1QgkzN7PwE693zIMKZ/QalCmyObLXUcaYDOnHuGZrLdA32THqiPWIEbZChqhrp0ZYWOm
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a104:b0:1b0:5d42:a889 with SMTP id
 m4-20020a056870a10400b001b05d42a889mr5975051oae.4.1691295548321; Sat, 05 Aug
 2023 21:19:08 -0700 (PDT)
Date:   Sat, 05 Aug 2023 21:19:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e37070602396ea9@google.com>
Subject: [syzbot] [ppp?] possible deadlock in ap_get
From:   syzbot <syzbot+cb575960cbf993938435@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, paulus@samba.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f6a691685962 Merge tag '6.5-rc4-smb3-client-fix' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155b4093a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=cb575960cbf993938435
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/402b1d665760/disk-f6a69168.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e18b9495da50/vmlinux-f6a69168.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0a8d1f7341ec/bzImage-f6a69168.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cb575960cbf993938435@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
6.5.0-rc4-syzkaller-00245-gf6a691685962 #0 Not tainted
--------------------------------------------------------
syz-executor.3/5705 just changed the state of lock:
ffffffff8d9463f8 (disc_data_lock){.?.-}-{2:2}, at: ap_get+0x18/0xf0 drivers/net/ppp/ppp_async.c:136
but this lock was taken by another, HARDIRQ-safe lock in the past:
 (&port_lock_key){-.-.}-{2:2}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(disc_data_lock);
                               local_irq_disable();
                               lock(&port_lock_key);
                               lock(disc_data_lock);
  <Interrupt>
    lock(&port_lock_key);

 *** DEADLOCK ***

1 lock held by syz-executor.3/5705:
 #0: ffff888079948098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243

the shortest dependencies between 2nd lock and 1st lock:
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
                      acpi_safe_halt+0x1b/0x20 drivers/acpi/processor_idle.c:112
                      acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
                      cpuidle_enter_state+0x82/0x500 drivers/cpuidle/cpuidle.c:267
                      cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
                      cpuidle_idle_call kernel/sched/idle.c:215 [inline]
                      do_idle+0x315/0x3f0 kernel/sched/idle.c:282
                      cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:379
                      rest_init+0x16f/0x2b0 init/main.c:726
                      arch_call_rest_init+0x13/0x30 init/main.c:823
                      start_kernel+0x39f/0x480 init/main.c:1068
                      x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
                      x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:537
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
                      arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
                      raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:444 [inline]
                      rcu_dynticks_curr_cpu_in_eqs include/linux/context_tracking.h:122 [inline]
                      rcu_is_watching+0x5c/0xb0 kernel/rcu/tree.c:695
                      rcu_read_lock_held_common kernel/rcu/update.c:108 [inline]
                      rcu_read_lock_held+0x1a/0x40 kernel/rcu/update.c:348
                      xa_entry include/linux/xarray.h:1198 [inline]
                      xas_descend+0x2ba/0x480 lib/xarray.c:206
                      xas_load+0xe0/0x140 lib/xarray.c:244
                      xas_find+0x60b/0x870 lib/xarray.c:1250
                      first_map_page mm/filemap.c:3482 [inline]
                      filemap_map_pages+0x1f8/0x1150 mm/filemap.c:3509
                      do_fault_around mm/memory.c:4510 [inline]
                      do_read_fault mm/memory.c:4542 [inline]
                      do_fault mm/memory.c:4670 [inline]
                      do_pte_missing mm/memory.c:3664 [inline]
                      handle_pte_fault mm/memory.c:4939 [inline]
                      __handle_mm_fault+0x2784/0x3b80 mm/memory.c:5079
                      handle_mm_fault+0x2ab/0x9d0 mm/memory.c:5233
                      do_user_addr_fault+0x446/0xfc0 arch/x86/mm/fault.c:1392
                      handle_page_fault arch/x86/mm/fault.c:1486 [inline]
                      exc_page_fault+0x5c/0xd0 arch/x86/mm/fault.c:1542
                      asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
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
  ... key      at: [<ffffffff92407120>] port_lock_key+0x0/0x40
  ... acquired at:
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x3a/0x70 kernel/locking/spinlock.c:228
   ap_get+0x18/0xf0 drivers/net/ppp/ppp_async.c:136
   ppp_asynctty_wakeup+0x18/0xb0 drivers/net/ppp/ppp_async.c:360
   tty_wakeup+0xe5/0x120 drivers/tty/tty_io.c:525
   tty_port_default_wakeup+0x2a/0x40 drivers/tty/tty_port.c:71
   serial8250_tx_chars+0x542/0xf60 drivers/tty/serial/8250/8250_port.c:1839
   serial8250_handle_irq+0x5fb/0xbe0 drivers/tty/serial/8250/8250_port.c:1943
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
   __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
   _raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:194
   spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
   serial_port_runtime_resume+0x2ae/0x330 drivers/tty/serial/serial_port.c:41
   __rpm_callback+0xc5/0x4c0 drivers/base/power/runtime.c:392
   rpm_callback+0x1da/0x220 drivers/base/power/runtime.c:446
   rpm_resume+0xdb9/0x1980 drivers/base/power/runtime.c:912
   pm_runtime_work+0x12e/0x180 drivers/base/power/runtime.c:977
   process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
   worker_thread+0x687/0x1110 kernel/workqueue.c:2748
   kthread+0x33a/0x430 kernel/kthread.c:389
   ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

-> (disc_data_lock){.?.-}-{2:2} {
   IN-HARDIRQ-R at:
                    lock_acquire kernel/locking/lockdep.c:5761 [inline]
                    lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x3a/0x70 kernel/locking/spinlock.c:228
                    ap_get+0x18/0xf0 drivers/net/ppp/ppp_async.c:136
                    ppp_asynctty_wakeup+0x18/0xb0 drivers/net/ppp/ppp_async.c:360
                    tty_wakeup+0xe5/0x120 drivers/tty/tty_io.c:525
                    tty_port_default_wakeup+0x2a/0x40 drivers/tty/tty_port.c:71
                    serial8250_tx_chars+0x542/0xf60 drivers/tty/serial/8250/8250_port.c:1839
                    serial8250_handle_irq+0x5fb/0xbe0 drivers/tty/serial/8250/8250_port.c:1943
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
                    __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
                    _raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:194
                    spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
                    serial_port_runtime_resume+0x2ae/0x330 drivers/tty/serial/serial_port.c:41
                    __rpm_callback+0xc5/0x4c0 drivers/base/power/runtime.c:392
                    rpm_callback+0x1da/0x220 drivers/base/power/runtime.c:446
                    rpm_resume+0xdb9/0x1980 drivers/base/power/runtime.c:912
                    pm_runtime_work+0x12e/0x180 drivers/base/power/runtime.c:977
                    process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
                    worker_thread+0x687/0x1110 kernel/workqueue.c:2748
                    kthread+0x33a/0x430 kernel/kthread.c:389
                    ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
                    ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
   HARDIRQ-ON-R at:
                    lock_acquire kernel/locking/lockdep.c:5761 [inline]
                    lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
                    ap_get+0x18/0xf0 drivers/net/ppp/ppp_async.c:136
                    ppp_asynctty_ioctl+0x23/0x2c0 drivers/net/ppp/ppp_async.c:286
                    tty_ioctl+0x706/0x1580 drivers/tty/tty_io.c:2795
                    vfs_ioctl fs/ioctl.c:51 [inline]
                    __do_sys_ioctl fs/ioctl.c:870 [inline]
                    __se_sys_ioctl fs/ioctl.c:856 [inline]
                    __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:856
                    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                    do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
                    entry_SYSCALL_64_after_hwframe+0x63/0xcd
   IN-SOFTIRQ-R at:
                    lock_acquire kernel/locking/lockdep.c:5761 [inline]
                    lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x3a/0x70 kernel/locking/spinlock.c:228
                    ap_get+0x18/0xf0 drivers/net/ppp/ppp_async.c:136
                    ppp_asynctty_wakeup+0x18/0xb0 drivers/net/ppp/ppp_async.c:360
                    tty_wakeup+0xe5/0x120 drivers/tty/tty_io.c:525
                    tty_port_default_wakeup+0x2a/0x40 drivers/tty/tty_port.c:71
                    serial8250_tx_chars+0x542/0xf60 drivers/tty/serial/8250/8250_port.c:1839
                    serial8250_handle_irq+0x5fb/0xbe0 drivers/tty/serial/8250/8250_port.c:1943
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
                    synchronize_rcu+0x0/0x3b0 kernel/rcu/tree_exp.h:285
                    lockdep_unregister_key+0x29a/0x490 kernel/locking/lockdep.c:6482
                    wq_unregister_lockdep kernel/workqueue.c:3812 [inline]
                    pwq_unbound_release_workfn+0x255/0x330 kernel/workqueue.c:4060
                    process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
                    worker_thread+0x687/0x1110 kernel/workqueue.c:2748
                    kthread+0x33a/0x430 kernel/kthread.c:389
                    ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
                    ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5761 [inline]
                   lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                   _raw_write_lock_irq+0x36/0x50 kernel/locking/spinlock.c:326
                   ppp_asynctty_close+0x1c/0x1c0 drivers/net/ppp/ppp_async.c:219
                   tty_ldisc_close+0x111/0x190 drivers/tty/tty_ldisc.c:455
                   tty_ldisc_kill+0x94/0x150 drivers/tty/tty_ldisc.c:607
                   tty_ldisc_release+0x17b/0x2a0 drivers/tty/tty_ldisc.c:775
                   tty_release_struct+0x23/0xe0 drivers/tty/tty_io.c:1698
                   tty_release+0xe23/0x1410 drivers/tty/tty_io.c:1869
                   __fput+0x3fd/0xac0 fs/file_table.c:384
                   task_work_run+0x14d/0x240 kernel/task_work.c:179
                   get_signal+0x1075/0x2770 kernel/signal.c:2657
                   arch_do_signal_or_restart+0x89/0x5f0 arch/x86/kernel/signal.c:308
                   exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
                   exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
                   __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
                   syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
                   do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
                   entry_SYSCALL_64_after_hwframe+0x63/0xcd
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5761 [inline]
                        lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
                        __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                        _raw_read_lock+0x3a/0x70 kernel/locking/spinlock.c:228
                        ap_get+0x18/0xf0 drivers/net/ppp/ppp_async.c:136
                        ppp_asynctty_wakeup+0x18/0xb0 drivers/net/ppp/ppp_async.c:360
                        tty_wakeup+0xe5/0x120 drivers/tty/tty_io.c:525
                        tty_port_default_wakeup+0x2a/0x40 drivers/tty/tty_port.c:71
                        serial8250_tx_chars+0x542/0xf60 drivers/tty/serial/8250/8250_port.c:1839
                        serial8250_handle_irq+0x5fb/0xbe0 drivers/tty/serial/8250/8250_port.c:1943
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
                        __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
                        _raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:194
                        spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
                        serial_port_runtime_resume+0x2ae/0x330 drivers/tty/serial/serial_port.c:41
                        __rpm_callback+0xc5/0x4c0 drivers/base/power/runtime.c:392
                        rpm_callback+0x1da/0x220 drivers/base/power/runtime.c:446
                        rpm_resume+0xdb9/0x1980 drivers/base/power/runtime.c:912
                        pm_runtime_work+0x12e/0x180 drivers/base/power/runtime.c:977
                        process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
                        worker_thread+0x687/0x1110 kernel/workqueue.c:2748
                        kthread+0x33a/0x430 kernel/kthread.c:389
                        ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
                        ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 }
 ... key      at: [<ffffffff8d9463f8>] disc_data_lock+0x18/0x60
 ... acquired at:
   mark_usage kernel/locking/lockdep.c:4586 [inline]
   __lock_acquire+0x13a5/0x5de0 kernel/locking/lockdep.c:5098
   lock_acquire kernel/locking/lockdep.c:5761 [inline]
   lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
   ap_get+0x18/0xf0 drivers/net/ppp/ppp_async.c:136
   ppp_asynctty_ioctl+0x23/0x2c0 drivers/net/ppp/ppp_async.c:286
   tty_ioctl+0x706/0x1580 drivers/tty/tty_io.c:2795
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:870 [inline]
   __se_sys_ioctl fs/ioctl.c:856 [inline]
   __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:856
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd


stack backtrace:
CPU: 1 PID: 5705 Comm: syz-executor.3 Not tainted 6.5.0-rc4-syzkaller-00245-gf6a691685962 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_irq_inversion_bug.part.0+0x3e1/0x590 kernel/locking/lockdep.c:4087
 print_irq_inversion_bug kernel/locking/lockdep.c:4040 [inline]
 check_usage_forwards kernel/locking/lockdep.c:4118 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4250 [inline]
 mark_lock+0x920/0x1950 kernel/locking/lockdep.c:4685
 mark_usage kernel/locking/lockdep.c:4586 [inline]
 __lock_acquire+0x13a5/0x5de0 kernel/locking/lockdep.c:5098
 lock_acquire kernel/locking/lockdep.c:5761 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
 __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
 _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
 ap_get+0x18/0xf0 drivers/net/ppp/ppp_async.c:136
 ppp_asynctty_ioctl+0x23/0x2c0 drivers/net/ppp/ppp_async.c:286
 tty_ioctl+0x706/0x1580 drivers/tty/tty_io.c:2795
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbb1967cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbb1a4710c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fbb1979c050 RCX: 00007fbb1967cae9
RDX: 00000000200001c0 RSI: 0000000040045431 RDI: 0000000000000003
RBP: 00007fbb196c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fbb1979c050 R15: 00007fbb198bfa48
 </TASK>


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
