Return-Path: <linux-kernel+bounces-148649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FD08A858A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0165CB254CD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749D0140E37;
	Wed, 17 Apr 2024 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NKYb8Lw5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RrNY4mt8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB6D130A75
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362578; cv=none; b=DDle9zPUJX6csDA4YC/9ymgEBaZ4ROgclzBGzMKgXrA1aghrPVoFdjoJJCTWkAlIE/ukvuMeMDMIYCzCVUqLQw4woIG5o9XBT/OaJB2WiOWBMTabDU9ms+rJzpjfZN7wKqjX7CSS3eP0Qu+1iGQWnklZm4NxTtaUg0FIMCSrOco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362578; c=relaxed/simple;
	bh=MGjG7Fg0KiUleiimGGY97MAa9R8hH4iMSokJZuzSwgg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hXlMOJOUQO/C4tX1XiYTgjKI1/y1rYeHCkYv6vXXo6Fh7fg0OBoT+Ctg2pbsP7LWWGkPq1WYa9VT+8kBuBDmFHxjbnrxAU478PsiICCFJi1622DXCyP8h5YNlzyG5ULA+H1zrQ7ZkE1YvubQtJVE2L8k/cb1pu2eIfRW38GY8Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NKYb8Lw5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RrNY4mt8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713362572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wgtvolD3VwfLc7c5esRJoObIH1mRJb2EO2S63FnqUZw=;
	b=NKYb8Lw5FvjGD9mBLKp4Fl2KeJYrR4qeUTiJNZmdH/q66cAy9nwFs2ZvUy1MtPCLpjDe38
	bRD3fM6qVaOijznI/5r0ckg2vtCx3cnP8clKY1XilcMUbNtGuhB0W6ut1mWmULhYBuOGK8
	rMQXx7JCI/51G5c+doIjQ2GOXd7jQ3cSg3JkiiZxI6rtVm37tVTz2ew7DQP5BUwFeuhtDA
	n2Wtqa1kfvOYWKieSd2nRbrKGmXQ7Ao00ey+QzWYOobvohn7EJ/n/T19RzEG/+cUNjJEFc
	I7Dj2qrbzCDLQj/gFamVi+uDcrf0Oo6w5lNOpXzzs47s6V0Z0qkJ7+vIRN2CIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713362572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wgtvolD3VwfLc7c5esRJoObIH1mRJb2EO2S63FnqUZw=;
	b=RrNY4mt8aFSb25bhc4TE54S+92hNxXgSyqdGC4xASnOe6HK2uHz5TaBj7ys5832m8nZA0J
	jReMl8S4J1zQ0OAw==
To: linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH] timerqueue: Remove never used function timerqueue_node_expires()
Date: Wed, 17 Apr 2024 16:02:29 +0200
Message-Id: <20240417140229.19633-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function was introduced with commit 60bda037f1dd ("posix-cpu-timers:
Utilize timerqueue for storage") but never used. Remove it.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 include/linux/timerqueue.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/timerqueue.h b/include/linux/timerqueue.h
index 62973f7d4610..d306d9dd2207 100644
--- a/include/linux/timerqueue.h
+++ b/include/linux/timerqueue.h
@@ -37,11 +37,6 @@ static inline bool timerqueue_node_queued(struct timerqueue_node *node)
 	return !RB_EMPTY_NODE(&node->node);
 }
 
-static inline bool timerqueue_node_expires(struct timerqueue_node *node)
-{
-	return node->expires;
-}
-
 static inline void timerqueue_init_head(struct timerqueue_head *head)
 {
 	head->rb_root = RB_ROOT_CACHED;
-- 
2.39.2


