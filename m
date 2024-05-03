Return-Path: <linux-kernel+bounces-168060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B91788BB334
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6C51C208A5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534D715A480;
	Fri,  3 May 2024 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MEbi+rzv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uZ5djL0M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC64158D9E;
	Fri,  3 May 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761013; cv=none; b=Mg4auU8O5tCutnYKZNioF7KRgi4kjYQKXkv8C2LCCRU69Ql9oENhEEXbZKHAe/DE83/1At2thHzTvnAAWnhF6rmYWCQPNKpV8fifM+8nySXfK6hVRPTeD/C+gmBI3kK3LheQIPs/lhpWnt0RHShcJVo8DU6NO6PdTNth9A5hCiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761013; c=relaxed/simple;
	bh=UzbC5O8aCltMC3s6U4W6tN76Z+89jwJ0gJI2hpTmCdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGPGxAUlrKY5fcFRgtZO/rooh5+2w+aO2G7BiPG6LEL+fSrvDlcPVEh/mnYxmnrEKS9Q4v9EooDEgTacQY9TtegLP6dXNxybAGgVz1qDe70JFFmIjqrBoKGJYFPFZxx54riNOjDCVncZXS3MvWnnGgZNbId3Quo+J+2Ut4PblzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MEbi+rzv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uZ5djL0M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714761009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCLsUIZH7feV/C68ZxWORyFQ7jaG1YvJe8ZcR90vaGY=;
	b=MEbi+rzv/jTvhg5/6ADVT9kct1jhketAJapwlhuXEIN1s2bqWqlNZdj0zJkZB6xSIq+Y4R
	WbcY1KbvM/NCbyNBaptw0stkwfzbZqfjEGQsIO74/hoX9rnY033pkyKTpGrlpyN3V1woh0
	DX7BEG6eHlmCHie9VSwVF2TGnGnZrMQsuVCe4BIsgxc6dTBoBoL+iCzGEudXgNIR+yeKkx
	3WBU8ekKdp7+xeLGj2JLiFVD8eh3BbGa9OCMmbS/vKZs2fXj6uhPEgFeY2mZ5L2ZeVVJHD
	i/FKYsp0AzPJJDRED59A6t15J40G+8x5KlzY6klDkkHCQSTvoO3lXcDG0tIG2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714761009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCLsUIZH7feV/C68ZxWORyFQ7jaG1YvJe8ZcR90vaGY=;
	b=uZ5djL0Mfh7jfkdvQtj2DwvU0bVVlJbaIGSkpwPDXxwWcC+zu8neFUugX+5zdjyJCLfLq4
	75J6Ya6UTPdTTzCA==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 09/15] dev: Remove PREEMPT_RT ifdefs from backlog_lock.*().
Date: Fri,  3 May 2024 20:25:13 +0200
Message-ID: <20240503182957.1042122-10-bigeasy@linutronix.de>
In-Reply-To: <20240503182957.1042122-1-bigeasy@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The backlog_napi locking (previously RPS) relies on explicit locking if
either RPS or backlog NAPI is enabled. If both are disabled then locking
was achieved by disabling interrupts except on PREEMPT_RT. PREEMPT_RT
was excluded because the needed synchronisation was already provided
local_bh_disable().

Since the introduction of backlog NAPI and making it mandatory for
PREEMPT_RT the ifdef within backlog_lock.*() is obsolete and can be
removed.

Remove the ifdefs in backlog_lock.*().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index e02d2363347e2..cf7b452ce0d74 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -230,7 +230,7 @@ static inline void backlog_lock_irq_save(struct softnet=
_data *sd,
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_lock_irqsave(&sd->input_pkt_queue.lock, *flags);
-	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	else
 		local_irq_save(*flags);
 }
=20
@@ -238,7 +238,7 @@ static inline void backlog_lock_irq_disable(struct soft=
net_data *sd)
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_lock_irq(&sd->input_pkt_queue.lock);
-	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	else
 		local_irq_disable();
 }
=20
@@ -247,7 +247,7 @@ static inline void backlog_unlock_irq_restore(struct so=
ftnet_data *sd,
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_unlock_irqrestore(&sd->input_pkt_queue.lock, *flags);
-	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	else
 		local_irq_restore(*flags);
 }
=20
@@ -255,7 +255,7 @@ static inline void backlog_unlock_irq_enable(struct sof=
tnet_data *sd)
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_unlock_irq(&sd->input_pkt_queue.lock);
-	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	else
 		local_irq_enable();
 }
=20
--=20
2.43.0


