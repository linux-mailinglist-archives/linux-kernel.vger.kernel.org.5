Return-Path: <linux-kernel+bounces-166951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA368BA267
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8FE1C20C5E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E250181CFE;
	Thu,  2 May 2024 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uz1bhtTp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BDzcvGoh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2001DDF8
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685927; cv=none; b=ch92jPj8xCLk3tY8xWEylePnIZjVsoF1ZlDXsyLSNKpYnrwd606JDIr8w3FAbNCSM7JSyMaKcSzXoA4RW1bhZn/egpcAnHmL7EMiCJ33UBI42970sZ+DArhDlTPquoH5OFjqld5AWD1cqSMvxVCrMdAqoch/t61zabJR+5AVTnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685927; c=relaxed/simple;
	bh=+x0B0DKqCUuY5JhcpCChNmzn4DAXIu7FX0iwPh4yj00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gPQFCCxDTbgm8OZiJOtoX+7xXaJvLXCBYrnsN7ivE9p5XYFKGO8AqltZ+TBS8KMto7HID9tm64RqRuoFGy7dRcNMQW5l1CPB8fbTAaVfY6V32eih8D8fsh68X2mqIK4gK5nhaEr8Cvf0CZiqTzyPvtxCN8LD6wlJ6h8j5YCQHEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uz1bhtTp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BDzcvGoh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CzegSW+30fFMD0MZbnfdPKJm1E+ZrdzFvhWkWJc/40c=;
	b=uz1bhtTpgjos+cZ2g3IwiFLhNzOdWw9j8mS9gMg+PWeDfG39cr0+ScxrCR12iuz22Hs3BF
	m9UthHCxaKUmIqqZv4qe5v/PbBzdUwGhI9sfpJBoWrZc2a9K9TXTzNcjStYaZGD5qRqGjW
	VCM3rFYxYcC8pKGwsGfFiVarbJ45LxqfcFWK9JEqvK5kyTIq33VfS0qsC1HfKwT5e5+MTj
	bIpu8nO/c75Otr5H6eO1W0cOFsynCUHEWZdGwyeRHhmSsiLeW5EeowlCNLU3h7xwyagB5l
	EqdxPo6obrJVoPtYtePXbDTCSrjhxsn6lp21yJw4CeIFBQmC37YSHGyUln4EVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CzegSW+30fFMD0MZbnfdPKJm1E+ZrdzFvhWkWJc/40c=;
	b=BDzcvGohSvy38CtWxEEQFhEkqw5Gte97pjf8KmhK1JNEQ/yIWScYi7GSkwTevQ552O8SPi
	RqhxC3F0l8q9GfAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH printk v5 01/30] printk: Add notation to console_srcu locking
Date: Thu,  2 May 2024 23:44:10 +0206
Message-Id: <20240502213839.376636-2-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel/printk/printk.c:284:5: sparse: sparse: context imbalance in
'console_srcu_read_lock' - wrong count at exit
include/linux/srcu.h:301:9: sparse: sparse: context imbalance in
'console_srcu_read_unlock' - unexpected unlock

Fixes: 6c4afa79147e ("printk: Prepare for SRCU console list protection")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 612c73333848..c7c0ee2b47eb 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -282,6 +282,7 @@ EXPORT_SYMBOL(console_list_unlock);
  * Return: A cookie to pass to console_srcu_read_unlock().
  */
 int console_srcu_read_lock(void)
+	__acquires(&console_srcu)
 {
 	return srcu_read_lock_nmisafe(&console_srcu);
 }
@@ -295,6 +296,7 @@ EXPORT_SYMBOL(console_srcu_read_lock);
  * Counterpart to console_srcu_read_lock()
  */
 void console_srcu_read_unlock(int cookie)
+	__releases(&console_srcu)
 {
 	srcu_read_unlock_nmisafe(&console_srcu, cookie);
 }
-- 
2.39.2


