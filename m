Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51EC7C9CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 02:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjJPAI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 20:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJPAIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 20:08:53 -0400
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ACAC1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 17:08:50 -0700 (PDT)
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-6c70e93400bso5516717a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 17:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697414929; x=1698019729;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xAj8uQFxEsS9EkQpsixP71O238iUxjJItYDA5NvQqUU=;
        b=qJeImt/mcqBBYdv14MnP1bb21jnlQHUGx6Zr1IY4clnAHsaTsPjLbAEqxaOtJ0SSgk
         JazdDCDyja5aM6RhDl7RUptcJSKeOt3iNfB574os6lqW8hmzqgVgkaEoWScwYXjLJbAN
         bCyYJ01AjoYMjafEpEDLEUk+hxT9HBVjuIdhv9OCsKtxDfkQYl9c96jgx1eWT7fYj07b
         ZFikwieMaq9tHxmsXoUigAm9SPTR9Y0oq0t5eecT43EYofpMNqRr5l5r1I4XRm00mOCK
         i7BNA9NgmsCuXXE9QvWZZx/ykRprmZlw5lXPf7X/umQVZ5Y5oLiH1Jm6UWD2zbgvfrUP
         5ejQ==
X-Gm-Message-State: AOJu0YwIxociOxNteMfHIMSAqE59be0Ctk/inytbNM+z+YxX39f3Qw1V
        cTNVw8RmmEr9VWpLURhMuk4y02Qog/h8bk/YHt9Rr9m1+Ky/
X-Google-Smtp-Source: AGHT+IED8IN8ojVC9J2F94/j/Bi73mBJzWpoWIMzmNpCXcZ9GKBcPFO2hJYb+aqCh03BqCrIgMC8zkuzF/rGZQAb7R5tlOyRA7xg
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1142:b0:6c2:10e1:9d6f with SMTP id
 x2-20020a056830114200b006c210e19d6fmr9880192otq.6.1697414929378; Sun, 15 Oct
 2023 17:08:49 -0700 (PDT)
Date:   Sun, 15 Oct 2023 17:08:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6f6f50607ca350b@google.com>
Subject: [syzbot] [ppp?] possible deadlock in ppp_asynctty_receive
From:   syzbot <syzbot+e7b2dea78c7a2e0f8e2c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
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

HEAD commit:    8182d7a3f1b8 Merge tag 'ata-6.6-rc6' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=161c4ead680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11e478e28144788c
dashboard link: https://syzkaller.appspot.com/bug?extid=e7b2dea78c7a2e0f8e2c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5f442c122125/disk-8182d7a3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ee2fd6e642c2/vmlinux-8182d7a3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/17f1572357f6/bzImage-8182d7a3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e7b2dea78c7a2e0f8e2c@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
6.6.0-rc5-syzkaller-00067-g8182d7a3f1b8 #0 Not tainted
--------------------------------------------------------
kworker/u4:1/12 just changed the state of lock:
ffffffff8dd82558 (disc_data_lock){.+..}-{2:2}, at: ap_get drivers/net/ppp/ppp_async.c:136 [inline]
ffffffff8dd82558 (disc_data_lock){.+..}-{2:2}, at: ppp_asynctty_receive+0x40/0x2000 drivers/net/ppp/ppp_async.c:335
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

4 locks held by kworker/u4:1/12:
 #0: ffff888012871938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2605 [inline]
 #0: ffff888012871938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1400 kernel/workqueue.c:2703
 #1: ffffc90000117d20 ((work_completion)(&buf->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2605 [inline]
 #1: ffffc90000117d20 ((work_completion)(&buf->work)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1400 kernel/workqueue.c:2703
 #2: ffff88801c200ce8 (&buf->lock){+.+.}-{3:3}, at: flush_to_ldisc+0x38/0x850 drivers/tty/tty_buffer.c:467
 #3: ffff88807744c0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref+0x1c/0x80 drivers/tty/tty_ldisc.c:263

the shortest dependencies between 2nd lock and 1st lock:
 -> (&port_lock_key){-.-.}-{2:2} {
    IN-HARDIRQ-W at:
                      lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5753
                      __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                      _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                      serial8250_handle_irq+0x81/0x700 drivers/tty/serial/8250/8250_port.c:1921
                      serial8250_default_handle_irq+0xcc/0x1e0 drivers/tty/serial/8250/8250_port.c:1970
                      serial8250_interrupt+0xa5/0x1e0 drivers/tty/serial/8250/8250_core.c:127
                      __handle_irq_event_percpu+0x286/0xa20 kernel/irq/handle.c:158
                      handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                      handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
                      handle_edge_irq+0x249/0xbf0 kernel/irq/chip.c:831
                      generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
                      handle_irq arch/x86/kernel/irq.c:238 [inline]
                      __common_interrupt+0x134/0x220 arch/x86/kernel/irq.c:257
                      common_interrupt+0xa3/0xc0 arch/x86/kernel/irq.c:247
                      asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:636
                      native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                      arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
                      acpi_safe_halt+0x20/0x30 drivers/acpi/processor_idle.c:112
                      acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:707
                      cpuidle_enter_state+0x10e/0x470 drivers/cpuidle/cpuidle.c:267
                      cpuidle_enter+0x5d/0x90 drivers/cpuidle/cpuidle.c:388
                      call_cpuidle kernel/sched/idle.c:134 [inline]
                      cpuidle_idle_call kernel/sched/idle.c:215 [inline]
                      do_idle+0x374/0x5c0 kernel/sched/idle.c:282
                      cpu_startup_entry+0x41/0x60 kernel/sched/idle.c:380
                      rest_init+0x2e0/0x300 init/main.c:726
                      arch_call_rest_init+0xe/0x10 init/main.c:823
                      start_kernel+0x46e/0x4f0 init/main.c:1068
                      x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:556
                      x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:537
                      secondary_startup_64_no_verify+0x167/0x16b
    IN-SOFTIRQ-W at:
                      lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5753
                      __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                      _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                      serial8250_handle_irq+0x81/0x700 drivers/tty/serial/8250/8250_port.c:1921
                      serial8250_default_handle_irq+0xcc/0x1e0 drivers/tty/serial/8250/8250_port.c:1970
                      serial8250_interrupt+0xa5/0x1e0 drivers/tty/serial/8250/8250_core.c:127
                      __handle_irq_event_percpu+0x286/0xa20 kernel/irq/handle.c:158
                      handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                      handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
                      handle_edge_irq+0x249/0xbf0 kernel/irq/chip.c:831
                      generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
                      handle_irq arch/x86/kernel/irq.c:238 [inline]
                      __common_interrupt+0x134/0x220 arch/x86/kernel/irq.c:257
                      common_interrupt+0x4e/0xc0 arch/x86/kernel/irq.c:247
                      asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:636
                      __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
                      _raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.c:202
                      expire_timers kernel/time/timer.c:1750 [inline]
                      __run_timers+0x640/0x860 kernel/time/timer.c:2022
                      __do_softirq+0x2ab/0x908 kernel/softirq.c:553
                      invoke_softirq kernel/softirq.c:427 [inline]
                      __irq_exit_rcu+0xf1/0x1b0 kernel/softirq.c:632
                      irq_exit_rcu+0x9/0x20 kernel/softirq.c:644
                      sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1074
                      asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
                      native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                      arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
                      acpi_safe_halt+0x20/0x30 drivers/acpi/processor_idle.c:112
                      acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:707
                      cpuidle_enter_state+0x10e/0x470 drivers/cpuidle/cpuidle.c:267
                      cpuidle_enter+0x5d/0x90 drivers/cpuidle/cpuidle.c:388
                      call_cpuidle kernel/sched/idle.c:134 [inline]
                      cpuidle_idle_call kernel/sched/idle.c:215 [inline]
                      do_idle+0x374/0x5c0 kernel/sched/idle.c:282
                      cpu_startup_entry+0x41/0x60 kernel/sched/idle.c:380
                      rest_init+0x2e0/0x300 init/main.c:726
                      arch_call_rest_init+0xe/0x10 init/main.c:823
                      start_kernel+0x46e/0x4f0 init/main.c:1068
                      x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:556
                      x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:537
                      secondary_startup_64_no_verify+0x167/0x16b
    INITIAL USE at:
                     lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5753
                     __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                     _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                     serial8250_do_set_termios+0x52b/0x1790 drivers/tty/serial/8250/8250_port.c:2801
                     uart_set_options+0x3e5/0x720 drivers/tty/serial/serial_core.c:2278
                     serial8250_console_setup+0x3c2/0x650 drivers/tty/serial/8250/8250_port.c:3515
                     univ8250_console_setup+0x3ad/0x470 drivers/tty/serial/8250/8250_core.c:632
                     try_enable_preferred_console+0x40f/0x560 kernel/printk/printk.c:3294
                     register_console+0x452/0x1080 kernel/printk/printk.c:3467
                     univ8250_console_init+0x45/0x50 drivers/tty/serial/8250/8250_core.c:717
                     console_init+0x193/0x670 kernel/printk/printk.c:3667
                     start_kernel+0x2d2/0x4f0 init/main.c:1004
                     x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:556
                     x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:537
                     secondary_startup_64_no_verify+0x167/0x16b
  }
  ... key      at: [<ffffffff92217c80>] port_lock_key+0x0/0x20
  ... acquired at:
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
   ap_get drivers/net/ppp/ppp_async.c:136 [inline]
   ppp_asynctty_wakeup+0x20/0x210 drivers/net/ppp/ppp_async.c:352
   tty_wakeup+0xb7/0x100 drivers/tty/tty_io.c:523
   tty_port_default_wakeup+0xa6/0xf0 drivers/tty/tty_port.c:69
   serial8250_tx_chars+0x6b7/0x8b0 drivers/tty/serial/8250/8250_port.c:1843
   __start_tx+0x312/0x450 drivers/tty/serial/8250/8250_port.c:1552
   serial_port_runtime_resume+0x1ec/0x2a0 drivers/tty/serial/serial_port.c:40
   __rpm_callback+0x2b9/0x7a0 drivers/base/power/runtime.c:392
   rpm_callback drivers/base/power/runtime.c:446 [inline]
   rpm_resume+0x10ad/0x1af0 drivers/base/power/runtime.c:912
   pm_runtime_work+0x147/0x210 drivers/base/power/runtime.c:977
   process_one_work kernel/workqueue.c:2630 [inline]
   process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
   worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
   kthread+0x2d3/0x370 kernel/kthread.c:388
   ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

-> (disc_data_lock){.+..}-{2:2} {
   HARDIRQ-ON-R at:
                    lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5753
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                    ap_get drivers/net/ppp/ppp_async.c:136 [inline]
                    ppp_asynctty_receive+0x40/0x2000 drivers/net/ppp/ppp_async.c:335
                    tty_ldisc_receive_buf+0x120/0x160 drivers/tty/tty_buffer.c:391
                    tty_port_default_receive_buf+0x6d/0xa0 drivers/tty/tty_port.c:37
                    receive_buf drivers/tty/tty_buffer.c:445 [inline]
                    flush_to_ldisc+0x324/0x850 drivers/tty/tty_buffer.c:495
                    process_one_work kernel/workqueue.c:2630 [inline]
                    process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
                    worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
                    kthread+0x2d3/0x370 kernel/kthread.c:388
                    ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
   INITIAL READ USE at:
                        lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5753
                        __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                        _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                        ap_get drivers/net/ppp/ppp_async.c:136 [inline]
                        ppp_asynctty_wakeup+0x20/0x210 drivers/net/ppp/ppp_async.c:352
                        tty_wakeup+0xb7/0x100 drivers/tty/tty_io.c:523
                        tty_port_default_wakeup+0xa6/0xf0 drivers/tty/tty_port.c:69
                        serial8250_tx_chars+0x6b7/0x8b0 drivers/tty/serial/8250/8250_port.c:1843
                        __start_tx+0x312/0x450 drivers/tty/serial/8250/8250_port.c:1552
                        serial_port_runtime_resume+0x1ec/0x2a0 drivers/tty/serial/serial_port.c:40
                        __rpm_callback+0x2b9/0x7a0 drivers/base/power/runtime.c:392
                        rpm_callback drivers/base/power/runtime.c:446 [inline]
                        rpm_resume+0x10ad/0x1af0 drivers/base/power/runtime.c:912
                        pm_runtime_work+0x147/0x210 drivers/base/power/runtime.c:977
                        process_one_work kernel/workqueue.c:2630 [inline]
                        process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
                        worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
                        kthread+0x2d3/0x370 kernel/kthread.c:388
                        ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
                        ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 }
 ... key      at: [<ffffffff8dd82558>] disc_data_lock+0x18/0x60
 ... acquired at:
   mark_lock+0x21b/0x340 kernel/locking/lockdep.c:4677
   mark_usage kernel/locking/lockdep.c:4578 [inline]
   __lock_acquire+0x1114/0x7f70 kernel/locking/lockdep.c:5090
   lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5753
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
   ap_get drivers/net/ppp/ppp_async.c:136 [inline]
   ppp_asynctty_receive+0x40/0x2000 drivers/net/ppp/ppp_async.c:335
   tty_ldisc_receive_buf+0x120/0x160 drivers/tty/tty_buffer.c:391
   tty_port_default_receive_buf+0x6d/0xa0 drivers/tty/tty_port.c:37
   receive_buf drivers/tty/tty_buffer.c:445 [inline]
   flush_to_ldisc+0x324/0x850 drivers/tty/tty_buffer.c:495
   process_one_work kernel/workqueue.c:2630 [inline]
   process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
   worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
   kthread+0x2d3/0x370 kernel/kthread.c:388
   ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304


stack backtrace:
CPU: 1 PID: 12 Comm: kworker/u4:1 Not tainted 6.6.0-rc5-syzkaller-00067-g8182d7a3f1b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Workqueue: events_unbound flush_to_ldisc
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 mark_lock_irq+0x837/0xba0 kernel/locking/lockdep.c:4235
 mark_lock+0x21b/0x340 kernel/locking/lockdep.c:4677
 mark_usage kernel/locking/lockdep.c:4578 [inline]
 __lock_acquire+0x1114/0x7f70 kernel/locking/lockdep.c:5090
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5753
 __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
 _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
 ap_get drivers/net/ppp/ppp_async.c:136 [inline]
 ppp_asynctty_receive+0x40/0x2000 drivers/net/ppp/ppp_async.c:335
 tty_ldisc_receive_buf+0x120/0x160 drivers/tty/tty_buffer.c:391
 tty_port_default_receive_buf+0x6d/0xa0 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:445 [inline]
 flush_to_ldisc+0x324/0x850 drivers/tty/tty_buffer.c:495
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
