Return-Path: <linux-kernel+bounces-166952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 374B58BA268
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B9A286616
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967091836CB;
	Thu,  2 May 2024 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G5GQ3nCA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="db8MnLQU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD24D1635DB;
	Thu,  2 May 2024 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685927; cv=none; b=KwaTAnp8sL8skpwK0LnrgyPAHvGvFHTyreW09p3morTEKo3IROJJGM82MTn7XsW0RKEMDHbuDC81579wapyCa9mlhURnZeZ5IWOyPeenylMiKnf1tXAB92szuX3EYr785p+1D4PFBZgi49xCfPHmT2bXf24YqEPTFJdifkT+/24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685927; c=relaxed/simple;
	bh=W5A3t76GEnLLQ5Qz2LfRqsg2AZZzSdP3cmbZtjWKMWs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XxvbJg8r6QFPyOn+J9rWgNUOvqJYYyuj3TjmEOGWWAR7oNrX5zMriGVaubQQb7L4YLD6ovenFwfJI9pjdOfc2RVEx1hYvbhEh6lQXeck7aktE5CBEhFPx/As62gd38H7/LUBg7XqYUq8zDIFsAPZBsUra833DdKxV4J+N+WhSPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G5GQ3nCA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=db8MnLQU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c+hvNWuVh3mWaooo9C2jcc+oFOaGpdNwY3WDa/RK1Yg=;
	b=G5GQ3nCAFr0Fi3FtntZU85GDVy/6rwIkcbUwhxpkZ52vkcq6sfbjR682rPs7ZjFnL9Fzlh
	P7z9jPXM4xOudDOupJh7nh2E7ingJLsxqJxhDgXFLsSpiLZCQxGh92iu7CgjbqRMbaSqMw
	wPMtbaUQ+9IjfgIEjD5c6nDifR8tGydsLQfTu01PyT5fG1K3bMe/SBLpVOqLRHr1Gg4NV5
	lElpfMNOqsNqQxctaGJMJtzw1E6XTZeTU0OZTL3wKpKREf1h3oyTK52X3sE7fyhuQpqtdd
	9d8XTz0rwROCD75qIW1UrXRy4276P4dr9b5iEu9xeWkAdZkpRlMH7U59XKWeuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c+hvNWuVh3mWaooo9C2jcc+oFOaGpdNwY3WDa/RK1Yg=;
	b=db8MnLQUlZJ3HUkW/tYE5iOn7c1oOimHIQeYeEmDEzV0G0+xuqbn6KQR/PJRg/a/96cgvv
	d2jAGdbM9wSVOiAA==
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
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hongyu Xie <xiehongyu1@kylinos.cn>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH printk v5 00/30] wire up write_atomic() printing
Date: Thu,  2 May 2024 23:44:09 +0206
Message-Id: <20240502213839.376636-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v5 of a series to wire up the nbcon consoles so that
they actually perform printing using their write_atomic()
callback. v4 is here [0]. For information about the motivation
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
      console lock or nbcon port lock are used or on panic.
      This is on purpose. When nbcon kthreads are introduced,
      they will fill the gaps.

The changes since v4:

- In serial_core_add_one_port(), initialize the port lock
  before setting @cons (since uart_port_set_cons() uses the
  port lock).

- For unregister_console_locked(), take the con->device_lock
  when removing the console from the console list.

- Remove the struct nbcon_drvdata and instead rely on the port
  lock being taken when adding/removing uart nbcon console list
  items.

- Move the nbcon context for drivers into the struct console
  (formery in struct nbcon_drvdata).

- Simplify the port lock wrapper implementation since we can
  rely on the registration state not changing while the port
  lock is held.

- Change nbcon_driver_acquire() to nbcon_driver_try_acquire()
  in order to support try-semantics for the port lock wrappers.
  Also update its kerneldoc to clarify its usage.

- Implement true try-lock semantics for the try-variants of the
  port lock wrappers.

- Remove the retry-loop in __nbcon_atomic_flush_pending() since
  there is never a need to retry. If a context takes over
  ownership it also takes over responsibility to print the
  records.

- Invert the return value of nbcon_atomic_emit_one() and
  add kerneldoc and comments about the meaning of the return
  value.

- For nbcon_legacy_emit_next_record() use the same return
  value and kerneldoc explanation as nbcon_atomic_emit_one().

- Invert the meaning of the return value of
  __nbcon_atomic_flush_pending_con() and use various errno
  values to report the reason for failure.

- Add nbcon_atomic_flush_pending_con() to flush all records if
  records were added while flushing. (Once printer threads are
  available, we can rely on them to print the remaining
  records.)

- For nbcon_driver_release(), flush all records if records were
  added while holding the port lock. (Once printer threads are
  available, we can rely on them to print the remaining
  records.)

- Add nbcon_cpu_emergency_flush() to allow periodically
  flushing if there has been many records stored in emergency
  context. It also attempts legacy flushing when safe.

- Change lockdep_print_held_locks() and debug_show_all_locks()
  to rely on their callers marking emergency sections because
  these functions can be called in non-emergency situations.
  Note that debug_show_all_locks() still calls
  nbcon_cpu_emergency_flush() is case it used in emergency.

- Rename console_init_seq() to get_init_console_seq() and have
  it return the new seq rather than setting @newcon->seq.

- Change nbcon_init() to take the initial sequence number as
  an argument.

- For __pr_flush(), move the barrier() to ensure no
  intermediate use of the printing_via_unlock() macro.

- For nbcon_cpu_emergency_exit(), update the comments and
  WARN_ON_ONCE position as suggested.

- Move the printing_via_unlock() macro into internal.h so that
  it can be used by nbcon.c as well (in
  nbcon_cpu_emergency_flush()).

- Update the kerneldoc for nbcon callbacks write_atomic() and
  device_lock().

- Add clarification in console_srcu_read_flags() kerneldoc.

- Change kerneldoc nbcon_context_try_acquire() context to
  mention device_lock() or local_irq_save() requirement.

John Ogness

[0] https://lore.kernel.org/lkml/20240402221129.2613843-1-john.ogness@linutronix.de
[1] https://lore.kernel.org/lkml/20230302195618.156940-1-john.ogness@linutronix.de

John Ogness (25):
  printk: Add notation to console_srcu locking
  printk: nbcon: Remove return value for write_atomic()
  printk: nbcon: Add detailed doc for write_atomic()
  printk: nbcon: Add callbacks to synchronize with driver
  printk: nbcon: Use driver synchronization while (un)registering
  serial: core: Provide low-level functions to lock port
  serial: core: Introduce wrapper to set @uart_port->cons
  console: Improve console_srcu_read_flags() comments
  nbcon: Provide functions for drivers to acquire console for
    non-printing
  serial: core: Implement processing in port->lock wrapper
  printk: nbcon: Do not rely on proxy headers
  printk: nbcon: Fix kerneldoc for enums
  printk: Make console_is_usable() available to nbcon
  printk: Let console_is_usable() handle nbcon
  printk: Add @flags argument for console_is_usable()
  printk: nbcon: Add helper to assign priority based on CPU state
  printk: Track registered boot consoles
  printk: nbcon: Use nbcon consoles in console_flush_all()
  printk: nbcon: Add unsafe flushing on panic
  printk: Avoid console_lock dance if no legacy or boot consoles
  printk: Track nbcon consoles
  printk: Coordinate direct printing in panic
  panic: Mark emergency section in oops
  rcu: Mark emergency sections in rcu stalls
  lockdep: Mark emergency sections in lockdep splats

Petr Mladek (1):
  printk: Properly deal with nbcon consoles on seq init

Sebastian Andrzej Siewior (1):
  printk: Check printk_deferred_enter()/_exit() usage

Thomas Gleixner (3):
  printk: nbcon: Provide function to flush using write_atomic()
  printk: nbcon: Implement emergency sections
  panic: Mark emergency section in warn

 drivers/tty/serial/8250/8250_core.c |   6 +-
 drivers/tty/serial/amba-pl011.c     |   2 +-
 drivers/tty/serial/serial_core.c    |  16 +-
 include/linux/console.h             | 116 ++++++-
 include/linux/printk.h              |  33 +-
 include/linux/serial_core.h         | 117 ++++++-
 kernel/locking/lockdep.c            |  84 ++++-
 kernel/panic.c                      |   9 +
 kernel/printk/internal.h            |  71 +++-
 kernel/printk/nbcon.c               | 488 +++++++++++++++++++++++++++-
 kernel/printk/printk.c              | 303 +++++++++++++----
 kernel/printk/printk_ringbuffer.h   |   2 +
 kernel/printk/printk_safe.c         |  12 +
 kernel/rcu/tree_exp.h               |   9 +
 kernel/rcu/tree_stall.h             |  11 +
 15 files changed, 1148 insertions(+), 131 deletions(-)


base-commit: a2b4cab9da7746c42f87c13721d305baf0085a20
-- 
2.39.2


