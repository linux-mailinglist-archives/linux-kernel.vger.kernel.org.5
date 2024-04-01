Return-Path: <linux-kernel+bounces-126530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0392F893923
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34FD81C21095
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A3DDF6C;
	Mon,  1 Apr 2024 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2d+eUc0B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iiRtBZFg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6334FDDA2;
	Mon,  1 Apr 2024 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711961257; cv=none; b=JteqDb08ke4llTXqS3bZUeGPiYfXcODL2MtMX+SFTmE9/cQVkiM4Ow4NAPAERIRZ07e9s9mKWWhYrdAFIpIsDtV1PVxqEz3+Q8b77A9yLx3yaQZSWXzTiXdOz7HuCDKMeKaolEJ0NEFOIrxjQR4cAhswUV6h8M4dHnniIChbXMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711961257; c=relaxed/simple;
	bh=SB1WykvbvMaws7Jqmh3+cYaIZ7obgk8EzdX73CxxIvI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WsVcsrw8qeYw7LMbUQDbBIz9ZT0id7w6TDejiE/6sKs0fqFe3+RIuuGy+Cv4nVQHeBbuTBwCzO+oqszOz3CFh8XWog6i1TjVWS70PDdSSyf3dy5kcHgMtH35Q24CrCz/g8N3rZ6/U9LK3XMKh4e5lxUhG+I/ysvuphIM/6p/jCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2d+eUc0B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iiRtBZFg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Apr 2024 08:47:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711961248;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrYrq2EJYDc3p66/DxsvOt+rTj+ZqlEcUlC9IPqdTcI=;
	b=2d+eUc0BN6WOty6UuEJ+9Hx9ueZbIVjpaZS/zqcg5ysI62MCfH/goy1TkMRfoVmQj8o+/g
	ExSIdDTkyz8+qml4nbJ5Hh11+A6RNzyJTkS3u1tgmmzUVBh13F0lbVe/gDjrLHuPAFg4R+
	iCiJBY5KbuaT/k7hoPnvaUKfF6tm8nBlqN6tX8Ux93gBS0F5objNVc3y+WlGr1fjNkN6V9
	eSH3Z21yDn9Rzjz1jnB6izxSN+NYm7zInkExRO4NITC5ISQZRLKr+NqBqbIP9OxdKmr3SY
	zVSaVlBfgKGQuUKbT/ZERK9D/itEOQ0VfBD+jwp5hq3ecAUJn/UBMkaE9VI1zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711961248;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrYrq2EJYDc3p66/DxsvOt+rTj+ZqlEcUlC9IPqdTcI=;
	b=iiRtBZFgvTJhuIK2GZMoXJN5OzKydU+kFjgnlNf8EDXd3H2+5Z9OBuI/zvB3UIUxqQH+1R
	832/tq1XYJiiomAg==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] tick/sched: Fix struct tick_sched doc warnings
Cc: Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240331172652.14086-6-rdunlap@infradead.org>
References: <20240331172652.14086-6-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171196124750.10875.16713792755621842011.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     ba6ad57b803e33ed509213a5e840427dbef501d6
Gitweb:        https://git.kernel.org/tip/ba6ad57b803e33ed509213a5e840427dbef501d6
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sun, 31 Mar 2024 10:26:51 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 01 Apr 2024 10:36:35 +02:00

tick/sched: Fix struct tick_sched doc warnings

Fix kernel-doc warnings in struct tick_sched:

  tick-sched.h:103: warning: Function parameter or struct member 'idle_sleeptime_seq' not described in 'tick_sched'
  tick-sched.h:104: warning: Excess struct member 'nohz_mode' description in 'tick_sched'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240331172652.14086-6-rdunlap@infradead.org
---
 kernel/time/tick-sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index e11c4dc..b4a7822 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -46,8 +46,8 @@ struct tick_device {
  * @next_tick:		Next tick to be fired when in dynticks mode.
  * @idle_jiffies:	jiffies at the entry to idle for idle time accounting
  * @idle_waketime:	Time when the idle was interrupted
+ * @idle_sleeptime_seq:	sequence counter for data consistency
  * @idle_entrytime:	Time when the idle call was entered
- * @nohz_mode:		Mode - one state of tick_nohz_mode
  * @last_jiffies:	Base jiffies snapshot when next event was last computed
  * @timer_expires_base:	Base time clock monotonic for @timer_expires
  * @timer_expires:	Anticipated timer expiration time (in case sched tick is stopped)

