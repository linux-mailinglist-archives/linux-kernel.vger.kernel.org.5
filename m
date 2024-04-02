Return-Path: <linux-kernel+bounces-128761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A1B895F69
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DE51C233C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E5915ECF1;
	Tue,  2 Apr 2024 22:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HeHCXLiq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8p/dtOQs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3468815ECC7;
	Tue,  2 Apr 2024 22:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095897; cv=none; b=ZayNl5t9PkfuTVd9BNBBTMT/OgZks3LYo2E9slY/x6WrPT5GZm78sptf9PbGENuokH0qqWjEoP7RpmfmGWgnvs5pevFhiIujfC5nhPrZonvAn1VfDdv76QD806si0hJ1diKn8MOhM5+K8HEGb2O5cRvI8PgnJPBSwy0L1tPkjow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095897; c=relaxed/simple;
	bh=WcGs7QqdClY2g/akA/3zzEMa5j0Wj8Vi0pMUqDvxJUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VvfnWTafJuBfc8hW/hmT8LjB+nAced2l5uRDV5yS5rRzgbqyZjm6Oodv0LKx0U2y4VBZ/5iJVnkXQmjzFbpzkTCXdktdPMK1/awINBYA28PHTvXE0lKs6RsRSwMdSWpB1Z2TuKVbT2e1BGZ7gM4QaYqk7gWTxxoH4gWe+AySbwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HeHCXLiq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8p/dtOQs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n1EYqYl1VILTOnAmYtkPUlJcJLURjvYBzwQ0+VVa1NY=;
	b=HeHCXLiq/3v6LxcBfUISNdCNNfF+uX92ZJlh7W+5dOeqmsmYQ6IjVPriaRA4XdIeihWyjs
	w8qJcyRiATpmBt2pJYtceZHqSfLZU+mc/3fyABZEetZFIsXbWtgd/0MluSY5ITeRghu6WY
	5BhDyq5TCsHC+1EB0xonsTSbRa381NEKkcqOnUy9fIEoZfJojaYGYxnBc/LuPanXG+owxC
	re5zoa//6gaDEJiwvrcsDRlH1LEatALqE0pjAp3HAtVLCftFxKU1X3uJGqjCorJ6djtLqy
	kZSWa8sTg4PCCIEuK0FP0wLIt5cW23XlI8crBgVfA6OEICmTG10z3Mt826tCZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n1EYqYl1VILTOnAmYtkPUlJcJLURjvYBzwQ0+VVa1NY=;
	b=8p/dtOQseY5otBLN11Aqf9RyrQTxlvM9ffUiNh8k8CsPQ46I/PhKhk0vpiAWFSQFOQjCzP
	CmUMf1f8nDlDOrCA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Tony Lindgren <tony@atomide.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Fabio Estevam <festevam@denx.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Lukas Wunner <lukas@wunner.de>,
	Uros Bizjak <ubizjak@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH printk v4 00/27] wire up write_atomic() printing
Date: Wed,  3 Apr 2024 00:17:02 +0206
Message-Id: <20240402221129.2613843-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v4 of a series to wire up the nbcon consoles so that
they actually perform printing using their write_atomic()
callback. v3 is here [0]. For information about the motivation
of the atomic consoles, please read the cover letter of v1 [1].

The main focus of this series:

- For nbcon consoles, always call write_atomic() directly from
  printk() caller context for the panic CPU.

- For nbcon consoles, call write_atomic() when unlocking the
  console lock.

- Only perform the console lock/unlock dance if legacy or boot
  consoles are registered.

- For legacy consoles, if nbcon consoles are registered, do not
  attempt to print from printk() caller context for the panic
  CPU until nbcon consoles have had a chance to print the most
  significant messages.

- Mark emergency sections. In these sections printk() calls
  will only store the messages. Upon exiting the emergency
  section, nbcon consoles are flushed directly and legacy
  console flushing is triggered via irq_work.

This series does _not_ include threaded printing or nbcon
drivers. Those features will be added in separate follow-up
series.

Note: With this series, a system with _only_ nbcon consoles
      registered will not perform console printing unless the
      console lock is used (for synchronization), or when
      exiting emergency sections, or on panic. This is on
      purpose. When nbcon kthreads are introduced, they will
      fill the gaps.

The changes since v3:

- Modify the documentation of console_srcu_read_flags() to
  clarify that it is needed anytime a console _might_ be
  registered and the caller is not holding the
  console_list_lock. Hopefully this makes it clear when this
  helper function is needed.

- Create a function uart_port_set_cons() for setting @cons of
  struct uart_port. It modifies @cons under the port lock to
  avoid possible races within the port lock wrapper. All (5)
  code sites are modified to use the new function.

- Introduce 2 new required nbcon console callbacks
  device_lock()/device_unlock() to implement any internal
  locking required by the driver. (For example, for uart serial
  consoles it is locking/unlocking the port lock.) This is used
  during console registration to ensure that the hardware is
  not in use while the console transitions to registered. This
  avoids the risk that the port lock wrappers do not lock the
  nbcon console lock while the console was being registered on
  another CPU. These callbacks also will be used later by the
  printing kthreads.

- Introduce struct nbcon_drvdata to track ownership state when
  using the port lock wrappers. This provides a race-free
  alternative to the @nbcon_locked_port flag used in v3.

- Split the functionality of uart_nbcon_acquire() and
  uart_nbcon_release() into driver-specific and generic parts.
  The generic functions are named nbcon_driver_acquire() and
  nbcon_driver_release(). The driver-specific part is moved
  into serial_core.h into the new helper functions
  __uart_port_nbcon_acquire() and __uart_port_nbcon_release().

- Rename nbcon_atomic_flush_all() to
  nbcon_atomic_flush_pending() to emphasize that it only prints
  up to the latest record at the time of the call. Also, flush
  all the pending records of a console (without releasing
  ownership in between) before flushing the next nbcon console.
  This allows the full emergency block to be printed on at
  least one atomic console before trying the next.

- Flush nbcon consoles directly in the caller context when
  exiting an emergency section.

- If a CPU is in EMERGENCY context, do not trigger printing
  of legacy consoles via irq_work.

- In panic, allow synchronous legacy printing before calling
  the panic handlers. Attempt to flush there in the panic
  context as well.

- Remove the return value for the nbcon console atomic_write()
  callback. If ownership has not been lost, it is assumed the
  printing was successful.

- Add a WARN_ON_ONCE if nbcon_emit_next_record() is called for
  a console that has not provided a write_atomic() callback.

- Change the meaning of the return value of
  nbcon_atomic_emit_one() to allow
  nbcon_legacy_emit_next_record() to have the same return value
  meaning as console_emit_next_record().

- Remove all legacy @seq handling from nbcon.c. For nbcon
  consoles, printk.c handles the transfer and resetting of the
  legacy @seq value to @nbcon_seq.

- Add a compiler barrier in __pr_flush() to ensure the compiler
  does not optimize out a local variable by replacing it with
  a racy read of multiple global variables.

- Let __wake_up_klogd() remove unnecessary flags before
  possibly queuing irq_work.

- Eliminate header proxying in nbcon.c.

- Mark _all_ lockdep output blocks as emergency sections.

- Mark _all_ rcu stall blocks as emergency sections.

- Remove "(Optional)" in the documentation of the
  write_atomic() callback. Once threads are available, it will
  be optional. But at this point in the rework it is not.

John Ogness

[0] https://lore.kernel.org/lkml/20240218185726.1994771-1-john.ogness@linutronix.de
[1] https://lore.kernel.org/lkml/20230302195618.156940-1-john.ogness@linutronix.de

John Ogness (23):
  printk: Add notation to console_srcu locking
  printk: Properly deal with nbcon consoles on seq init
  printk: nbcon: Remove return value for write_atomic()
  printk: nbcon: Add detailed doc for write_atomic()
  printk: nbcon: Add callbacks to synchronize with driver
  printk: nbcon: Use driver synchronization while registering
  serial: core: Provide low-level functions to lock port
  printk: nbcon: Implement processing in port->lock wrapper
  printk: nbcon: Do not rely on proxy headers
  printk: nbcon: Fix kerneldoc for enums
  printk: Make console_is_usable() available to nbcon
  printk: Let console_is_usable() handle nbcon
  printk: Add @flags argument for console_is_usable()
  printk: Track registered boot consoles
  printk: nbcon: Use nbcon consoles in console_flush_all()
  printk: nbcon: Assign priority based on CPU state
  printk: nbcon: Add unsafe flushing on panic
  printk: Avoid console_lock dance if no legacy or boot consoles
  printk: Track nbcon consoles
  printk: Coordinate direct printing in panic
  panic: Mark emergency section in oops
  rcu: Mark emergency section in rcu stalls
  lockdep: Mark emergency sections in lockdep splats

Sebastian Andrzej Siewior (1):
  printk: Check printk_deferred_enter()/_exit() usage

Thomas Gleixner (3):
  printk: nbcon: Provide function to flush using write_atomic()
  printk: nbcon: Implement emergency sections
  panic: Mark emergency section in warn

 drivers/tty/serial/8250/8250_core.c |   6 +-
 drivers/tty/serial/amba-pl011.c     |   2 +-
 drivers/tty/serial/serial_core.c    |   2 +-
 include/linux/console.h             | 138 ++++++++--
 include/linux/printk.h              |  32 ++-
 include/linux/serial_core.h         | 116 ++++++++-
 kernel/locking/lockdep.c            |  91 ++++++-
 kernel/panic.c                      |   9 +
 kernel/printk/internal.h            |  56 +++-
 kernel/printk/nbcon.c               | 382 ++++++++++++++++++++++++++--
 kernel/printk/printk.c              | 287 ++++++++++++++++-----
 kernel/printk/printk_ringbuffer.h   |   2 +
 kernel/printk/printk_safe.c         |  12 +
 kernel/rcu/tree_exp.h               |   7 +
 kernel/rcu/tree_stall.h             |   9 +
 15 files changed, 1038 insertions(+), 113 deletions(-)


base-commit: a2b4cab9da7746c42f87c13721d305baf0085a20
-- 
2.39.2


