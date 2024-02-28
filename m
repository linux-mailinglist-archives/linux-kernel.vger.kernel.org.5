Return-Path: <linux-kernel+bounces-85040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB9986AF7C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1372B21E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF7F14AD08;
	Wed, 28 Feb 2024 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0llgFHOV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HrzdkMJ2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34AC1487D7;
	Wed, 28 Feb 2024 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709124806; cv=none; b=WeeTgnT0MAiNxur6+bHv1Xcd+Vq+Se1pCvNDMDDy+wfTWpQveYonqIn5OSjtjldRLHlNzUtYKmYP+WqAW4wKkN2LZ2NpZqe4Htw+//gtBg12v3YCpo34/cCZF6TaRY1HhgYB+/9goDeO1Bpd45x2VwesplBw81ndxwNM3SwvQb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709124806; c=relaxed/simple;
	bh=qllb9BunC54GClJH3gNc/f+b7ajqvH2CC3VhxcSMK7U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JTjQhidr8Zw0CCs07SxxeVdpFOW1wQBxtIXKfbKOsLvbe2HGP7TWGRjgiDV7BZI9dlMAdfjZJhMfEYxchhs7IaCORIv+XJuRIDVCnJuUZV1qUlPVd1z2yWW4SuhdhJDA1Tb+5fhWY25WjcQ7jKlQMbnYMRmkNRAuXAWoUimrJ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0llgFHOV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HrzdkMJ2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Feb 2024 12:53:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709124802;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGMCpIi1CngzONyyqp5nSMzJJWqhw0WiBeW2EkwS0Rc=;
	b=0llgFHOVBDZse+shVKjZSSREH5DX+LW+nrjz7Al1K6aW1egTf7npBRtb4fxn1hKUJ001a4
	yQr0NWSbADnPk2fZuBiGjm9NP5RjC8yx3Rx4DILQaFJnpu1bXRUYRU6/r2IV1c4hrSMpNq
	II5t+66AGzXLWFyxqgHz7zI6oorOGVKMH4GBDRETxSlLhw50eNOp7Ai9yppyC+E6PbzGxs
	XAMdR1vVuZp4k3ARWQa0znFoBV8TCzW7waBQ2Vk77vGe4SUf+jQ4BIf8j/U3+4xOvGcR8V
	iVBR/0S4DUgctY3H1b1+mY9eB4zj73492OStCff9u6GWMPCnyGAICZLybT7o7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709124802;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IGMCpIi1CngzONyyqp5nSMzJJWqhw0WiBeW2EkwS0Rc=;
	b=HrzdkMJ2+ipuguPz8CPi0/I1ewUzeKhkHpaNp9GP5qpqXJw3lidi7UCEG45fZwmD82pmav
	S/nqWoHmHvoU6zBg==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Clarify that RWSEM_READER_OWNED is
 just a hint
Cc: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240222150540.79981-4-longman@redhat.com>
References: <20240222150540.79981-4-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170912480198.398.8722869596829490134.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d566c78659eccf085f905fd266fc461de92eaa8f
Gitweb:        https://git.kernel.org/tip/d566c78659eccf085f905fd266fc461de92eaa8f
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 22 Feb 2024 10:05:39 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 28 Feb 2024 13:08:38 +01:00

locking/rwsem: Clarify that RWSEM_READER_OWNED is just a hint

Clarify in the comments that the RWSEM_READER_OWNED bit in the owner
field is just a hint, not an authoritative state of the rwsem.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20240222150540.79981-4-longman@redhat.com
---
 kernel/locking/rwsem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 2340b6d..c6d17ae 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -35,7 +35,7 @@
 /*
  * The least significant 2 bits of the owner value has the following
  * meanings when set.
- *  - Bit 0: RWSEM_READER_OWNED - The rwsem is owned by readers
+ *  - Bit 0: RWSEM_READER_OWNED - rwsem may be owned by readers (just a hint)
  *  - Bit 1: RWSEM_NONSPINNABLE - Cannot spin on a reader-owned lock
  *
  * When the rwsem is reader-owned and a spinning writer has timed out,
@@ -1002,8 +1002,8 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 
 	/*
 	 * To prevent a constant stream of readers from starving a sleeping
-	 * waiter, don't attempt optimistic lock stealing if the lock is
-	 * currently owned by readers.
+	 * writer, don't attempt optimistic lock stealing if the lock is
+	 * very likely owned by readers.
 	 */
 	if ((atomic_long_read(&sem->owner) & RWSEM_READER_OWNED) &&
 	    (rcnt > 1) && !(count & RWSEM_WRITER_LOCKED))

