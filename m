Return-Path: <linux-kernel+bounces-70532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB268598EB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FCCA1F21776
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE9073173;
	Sun, 18 Feb 2024 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UbYkC9+r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Swz/Gol/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85EA71B33;
	Sun, 18 Feb 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708283075; cv=none; b=t0aod+SKS5KVr4bVOmVGdEl9LPHubvq8rDXkerJaIkQ2/Zy0lcwIG3d3ySKw26TKn8kaCG7dtaWGGAcKqjvTJ40+7GvzcQBEwxNHpz7vHV8kv/FlWLgvlxkBJ+Fb4ljT8vhSXhfGyCvxqqOViufo9k+FTeA58rdSppEOIzQb3BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708283075; c=relaxed/simple;
	bh=uAuIZ9HfSiY/A0IYD728MeRHnJcUIl43QTwSldu9Elo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=i4p5L6UjtHmN61ubE3oBlgNR3LTW+Nb8UW0YeyPL3PIxDOYSFAuAWZslsRi7FUzDUOZKskDrW4DBqoEXL2AeB5+4C6Yh4cbPMRmahfAToQvC9NIdJJIBcVQvIdh/GgASpOG5I+XGX1d0X9jchhWP0/LqdSopCA8J0qF/rK69Mp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UbYkC9+r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Swz/Gol/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CxyZZWvhSzq+VD25dSHunC8XqF+HGYq257sbHrx7tVc=;
	b=UbYkC9+rrnE2knx+Jpd7AAc/5FGkoofSX8NvdgBLECyH65gS9y2IMZwsCGi9Dvfuis4YUb
	4hqu9ybDvUNRUb2SHmUmjDIxTjbRSq0ej9qeFJm4FYb+eGKMAK+st5+fWH98ZmghdAqtRp
	ukYxcAZelMhaPImfh49FsJ33pUn12UGsKtF0j5ZHmlNkkUJdip8vARJ03CcsGYiJXrwPEv
	5GciViV2WooJ7PGufsROG6tJx5enDqphT3XZd7EnfzBANQVl1Y9W+jIEiBx4jImTeUjBjK
	F18lnwmKmlPF0bOoM7kTHhmOB1wuPYYQeXz3EsjCKXX5iz2gSePSZL6lwxu9Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CxyZZWvhSzq+VD25dSHunC8XqF+HGYq257sbHrx7tVc=;
	b=Swz/Gol/1XZ9DEDonZSnv+eU/L3nfcDuegYEDQ9P3zYWgXm813efE7f8j3rg9YxE2XShrb
	YKl1rpgrb5KjBxCg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Justin Chen <justin.chen@broadcom.com>,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Lukas Wunner <lukas@wunner.de>,
	Arnd Bergmann <arnd@arndb.de>,
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
Subject: [PATCH printk v2 00/26] wire up write_atomic() printing
Date: Sun, 18 Feb 2024 20:03:00 +0106
Message-Id: <20240218185726.1994771-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is v3 of a series to wire up the nbcon consoles so that
they actually perform printing using their write_atomic()
callback. v2 is here [0]. For information about the motivation
of the atomic consoles, please read the cover letter of v1 [1].

The main focus of this series:

- For nbcon consoles, always call write_atomic() directly from
  printk() caller context for the panic CPU.

- For nbcon consoles, call write_atomic() when unlocking the
  console lock.

- Only perform the console_lock()/_unlock() dance if legacy or
  boot consoles are registered.

- For legacy consoles, if nbcon consoles are registered, do not
  attempt to print from printk() caller context for the panic
  CPU until nbcon consoles have had a chance to print the most
  significant messages.

- Mark emergency sections. In these sections printk() calls
  will only store the messages. Upon exiting the emergency
  section, console flushing is triggered via irq_work.

This series does _not_ include threaded printing or nbcon
drivers. Those features will be added in separate follow-up
series.

Note1: With this series, a system with _only_ nbcon consoles
       registered will not have any console printing except
       on panic. This is on purpose. When nbcon kthreads are
       introduced, they will fill this gap.

Note2: Patches 1-3 are already mainline, but not yet in the
       printk/for-next tree. They are included for
       completeness, but are not actually part of this series.

The changes since v2:

- Eliminate CPU states (normal, emergency, panic) and instead
  just track per-cpu emergency nesting.

- Instead of talking about "atomic mode", talk about "using the
  write_atomic() callback". This avoids confusion about what
  "atomic mode" means (i.e. "atomic" always means the
  write_atomic() callback is used).

- Rename atomic_enter()/_exit() to
  cpu_emergency_enter()/_exit().

- When entering emergency mode for a CPU, disable preemption
  rather than just migration to allow the warning to be
  completely handled before permitting rescheduling.

- Implement nbcon locking within the uart port lock wrappers.
  This provides synchronization between write_atomic() and
  non-printing driver activities (such as changing the baud
  rate.)

- Implement a one-way trigger printk_legacy_allow_panic_sync()
  to allow legacy consoles to print from the printk() caller
  context for the panic CPU. This allows the safe nbcon
  consoles to print before falling back to legacy consoles.
  Note that if no nbcon consoles are registered, legacy
  consoles are always allowed to print from the printk() caller
  context.

- Perform unsafe nbcon flushing at the very end of panic before
  going into the infinite loop.

- Add nbcon_get_default_prio() helper to return the appropriate
  prio for the current CPU.

- Do not assume that if write_atomic() returns false that the
  console has been released.

- For nbcon_atomic_emit_one(), rely on @ctxt->backlog rather
  than trying to read the next record.

- Rename nbcon_console_emit_next_record() to
  nbcon_legacy_emit_next_record() and have it use the same
  procedure as console_emit_next_record() (enter printk_safe,
  enable console_lock spinning, stop critical timings).

- Add nbcon_atomic_flush_unsafe() to allow flushing nbcon
  consoles in an unsafe manner.

- For nbcon flushing, add @stop_seq argument limit how much to
  print. This avoids a CPU getting stuck printing endlessly.

- For nbcon flushing, disable irqs to avoid an interrupt
  possibly calling into console code and deadlocking on nbcon
  ownership.

- The rules for allowing printing from the printk() caller
  context are getting quite complex. Move all this logic into
  vprintk_emit().

- For console_init_seq(), also consider nbcon consoles.

- For __pr_flush(), only take the console_lock if legacy or
  boot consoles are registered.

- For printk_trigger_flush(), do not flush nbcon consoles
  directly.

- For defer_console_output(), only trigger
  console_lock()/unlock() if legacy or boot consoles are
  registered.

- Add detailed kerneldoc for the write_atomic() callback.

- Fix kerneldoc for enum types (cons_flags, nbcon_prio).

- Add extra check to printk_deferred_enter()/_exit() to ensure
  it is called with migration disabled.

[0] https://lore.kernel.org/lkml/20230919230856.661435-1-john.ogness@linutronix.de
[1] https://lore.kernel.org/lkml/20230302195618.156940-1-john.ogness@linutronix.de

John Ogness (19):
  printk: Consider nbcon boot consoles on seq init
  printk: Add notation to console_srcu locking
  printk: nbcon: Ensure ownership release on failed emit
  printk: nbcon: Implement processing in port->lock wrapper
  printk: nbcon: Add detailed doc for write_atomic()
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
  lockdep: Mark emergency section in lockdep splats

Randy Dunlap (1):
  serial: core: fix kernel-doc for uart_port_unlock_irqrestore()

Sebastian Andrzej Siewior (1):
  printk: Check printk_deferred_enter()/_exit() usage

Thomas Gleixner (5):
  serial: core: Provide port lock wrappers
  serial: core: Use lock wrappers
  printk: nbcon: Provide function to flush using write_atomic()
  printk: nbcon: Implement emergency sections
  panic: Mark emergency section in warn

 drivers/tty/serial/8250/8250_port.c |   1 +
 include/linux/console.h             |  42 +++-
 include/linux/printk.h              |  30 ++-
 include/linux/serial_core.h         | 106 +++++++-
 kernel/locking/lockdep.c            |   5 +
 kernel/panic.c                      |   9 +
 kernel/printk/internal.h            |  57 +++++
 kernel/printk/nbcon.c               | 362 +++++++++++++++++++++++++++-
 kernel/printk/printk.c              | 248 +++++++++++++------
 kernel/printk/printk_safe.c         |  12 +
 kernel/rcu/tree_stall.h             |   5 +
 11 files changed, 784 insertions(+), 93 deletions(-)


base-commit: e7081d5a9d976b84f61f497316d7c940a4a2e67a
-- 
2.39.2


