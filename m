Return-Path: <linux-kernel+bounces-56560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F095784CBC7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C80D1F23058
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46CB78B41;
	Wed,  7 Feb 2024 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MYmNhCzx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DRnwLFE2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C665BADD
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313278; cv=none; b=KqP5LPdb0VmjkES7nG9hHCilLMwo+psiUIUxF37Ola+AGjCYNB7CBiS1MCSUMhdtzJ5fy2uqLBNZUsHP8wtXUGhAcRCqtXIMKniSuDbaKp/R/aFn/DvJnOxLF0C9Xi+Mj32AAH1kyxbdBJRsiw4FbWehBuho5agPzHg7YtLnt7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313278; c=relaxed/simple;
	bh=kYORAhihXQCNKA3XucZajuJW7DnSKFUFLgxbmUZsiTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hIWjL6udCKvpIyvGOWHTf2dujgktre359cHUFxeTgF767dV0hyKz2UYzrpuv7fEtjjepI0X5gVu73SybtuS3xuUxHtMMRrmw/VyGIP+t3U9YQuKZg3PX8/6Hn3I9CRKr+Oi2R6pFEPoW/hRtwgXNVS8eNKJEEwGrXwSn5pJuGOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MYmNhCzx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DRnwLFE2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707313274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fGjdqmICuBOqdgawtrYQWGWCK/rf00yxhY3OYk6C0Gs=;
	b=MYmNhCzxNfLhZByKKwRcyGqN9iqW0nS6WAOWXzMVugkwWTU8tlBRT9YojEG9OTzwm3Taeh
	lx2FVsYbUpE4dGqZ/JHal1soI4RGQws5zja4sol8v6mnl0t+KvLwD2oJFMFza1GWWxsOVw
	lTMqLgdCWf/HndqP9bKrDjPq3GEbJFQPlW0jxz+X6xQVXx+dc9wPTSu+cliE6f5EpmUEcv
	yRFDWhUOaBSFvYq8do9Y3g1wTTvtm4kcxIBYVPJxT0l1mW4oAScs/BTsb95SZOHRaj/AMW
	ULgQLVxqI14TKURT31WzHx4t6QJPW4EYWkcfz1UQls7MTtXbXJFYNnguByvegg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707313274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fGjdqmICuBOqdgawtrYQWGWCK/rf00yxhY3OYk6C0Gs=;
	b=DRnwLFE2M74ctZFqoH+IFbvciwU6ARWuHt7Trh9G6dhE3ATcaPQWec08wOk2/PfnEsEbLv
	gEOeBdRWjf/ZQtDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Uros Bizjak <ubizjak@gmail.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH printk v4 00/14] fix console flushing
Date: Wed,  7 Feb 2024 14:46:49 +0106
Message-Id: <20240207134103.1357162-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

While testing various flushing scenarios, I stumbled on a few
issues that cause console flushing to fail. While at LPC2023 in
Richmond, I sat down with Petr Mladek and we reviewed the
v2 [0] series. This series is the result of that offline
discussion. v3 is here [1].

This series addresses the following issues:

1. The prb_next_seq() optimization caused inconsistent return
   values. Fix prb_next_seq() to the originally intended
   behavior but keep an optimization.

2. pr_flush() might not wait until the most recently stored
   printk() message if non-finalized records precede it. Fix
   pr_flush() to wait for all records to print that are at
   least reserved at the time of the call.

3. In panic, the panic messages will not print if non-finalized
   records precede them. Add a special condition so that
   readers on the panic CPU will drop records that are not in
   a consistent state.

4. It is possible (and easy to reproduce) a scenario where the
   console on the panic CPU hands over to a waiter of a stopped
   CPU. Do not use the handover feature in panic.

5. If messages are being dropped during panic, non-panic CPUs
   are silenced. But by then it is already too late and most
   likely the panic messages have been dropped. Change the
   non-panic CPU silencing logic to _immediately_ silence
   non-panic CPUs during panic. This also leads to clean panic
   output when many CPUs are blasting the kernel log.

6. If a panic occurs in a context where printk() calls defer
   printing (NMI or printk_safe section), the printing of the
   final panic messages rely on irq_work. If that mechanism is
   not available, the final panic messages are not seen (even
   though they are finalized in the ringbuffer). Add one last
   explicit flush after all printk() calls are finished to
   ensure all available messages in the kernel log are printed.

7. When dumping the stacktrace from panic(), do not use the
   printk_cpu_sync because it can deadlock if another CPU holds
   and is unable to release the printk_cpu_sync.

This series also performs some minor cleanups to remove open
coded checks about the panic context and improve documentation
language regarding data-less records.

Because of multiple refactoring done in recent history, it
would be helpful to provide the LTS maintainers with the proper
backported patches. I am happy to do this.

The changes since v3:

- Drop patch 11 of v3 ("printk: ringbuffer: Consider committed
  as finalized in panic"). It adds complexity, may not perform
  as expected, and it is questionable as to whether it would
  help provide useful messages on panic.

- Changed several comments according to the suggestions by
  Petr. Note that I did not include all the suggestions
  because IMO they were too vague in describing the related
  memory barriers.

- Add a patch to avoid using printk_cpu_sync on panic(). This
  was recently discussed [2]. Feel free to drop the patch 
  14/14 ("dump_stack: Do not get cpu_sync for panic CPU") if
  you think it is not appropriate or will significantly delay
  this series.

John Ogness

[0] https://lore.kernel.org/lkml/20231106210730.115192-1-john.ogness@linutronix.de
[1] https://lore.kernel.org/lkml/20231214214201.499426-1-john.ogness@linutronix.de
[2] https://lore.kernel.org/lkml/ZcIGKU8sxti38Kok@alley

John Ogness (12):
  printk: nbcon: Relocate 32bit seq macros
  printk: Use prb_first_seq() as base for 32bit seq macros
  printk: ringbuffer: Do not skip non-finalized records with
    prb_next_seq()
  printk: ringbuffer: Clarify special lpos values
  printk: For @suppress_panic_printk check for other CPU in panic
  printk: Add this_cpu_in_panic()
  printk: ringbuffer: Cleanup reader terminology
  printk: Wait for all reserved records with pr_flush()
  printk: ringbuffer: Skip non-finalized records in panic
  printk: Avoid non-panic CPUs writing to ringbuffer
  panic: Flush kernel log buffer at the end
  dump_stack: Do not get cpu_sync for panic CPU

Petr Mladek (1):
  printk: Disable passing console lock owner completely during panic()

Sebastian Andrzej Siewior (1):
  printk: Adjust mapping for 32bit seq macros

 include/linux/printk.h            |   2 +
 kernel/panic.c                    |   8 +
 kernel/printk/nbcon.c             |  41 +---
 kernel/printk/printk.c            | 101 +++++----
 kernel/printk/printk_ringbuffer.c | 335 +++++++++++++++++++++++++-----
 kernel/printk/printk_ringbuffer.h |  54 ++++-
 lib/dump_stack.c                  |  16 +-
 7 files changed, 419 insertions(+), 138 deletions(-)


base-commit: 6c3a34e38436a2a3f7a1fa764c108ee19b05b893
-- 
2.39.2


