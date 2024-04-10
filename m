Return-Path: <linux-kernel+bounces-139477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A504E8A03A5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC1A2827DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C6E5491B;
	Wed, 10 Apr 2024 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BywFEK8E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0BzM0uy0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F653E3B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789218; cv=none; b=fCyXz7aWeMnK0fSo+ife9P2gn6g9iL3PNaKXGwUR192Tr02/LiKKCM2JmhxHxEiIMfNvQTpwy9Dy3BW4OUODKQNG4AWyI3mWw5ZPvHlLajiqyoWzsPEQleuB1Uno8zwR4mA22ikCgSBGw5hzmLnDTDko1JIvBn+J9/5sYWcSphE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789218; c=relaxed/simple;
	bh=d1BJ7Kja+UEwMgVwc6Tt6tmvcnKhbXaS3H8LE3K80r4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=mw0B/8+l1XXjTjbVXgwxJrrtjx2qk6UgN6NnhDklVELySkWQivDKNGeDPkKuW9J8mS8h4qEFY1uWX6De7LeTQX1xYZ7UL3tES2zGpn9egoQfCwANrVZF5Wujw7OV+5uZofZhXr3PG+vUnFRHcrWkCUzFNVVBZJEpzjxbuv5SZuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BywFEK8E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0BzM0uy0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165552.447880671@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Qgv0rOS1X6FuYj5LENG49jFoHaTII1ldHQt4poVGsnc=;
	b=BywFEK8EhBKq+GTAmPwdrzCsML4KpjodV0Aa5UV7k+IvmE75liV0APZQ5B8086XCqnu9qy
	w3oBNIHUbUba2WaMMkZPf/anVzdlQiwNE6Vtbq3+mWTE6ClBoV39rgA0oVMJbUaklfx8oW
	D3ZY4PyG4L9qqBRviqpFAUnoC/w8bFqXPKn7FqhV2GKFVUCGrKafdYiwBSDnsWnt5DzU/K
	CjmYcgDJS87JtiTGHjlSzGnDs65BSPuIj90SBPhuMqRCVOD7xzz8i0f3TNiFhwsTqeRwNc
	rqGIbvWr+k3SL6YKd9eF7rZt4zr2+aqJblrzVMcwzEMA55nJtFt3+dQgwMH4mQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Qgv0rOS1X6FuYj5LENG49jFoHaTII1ldHQt4poVGsnc=;
	b=0BzM0uy0YvtHTATQTAAu4NX8a7YREsxX/iXHgXRS+pI3tynfPokyIJNUco+FwxHWiil85d
	dNLfUXrv1l5TG0AA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch V2 24/50] signal: Replace BUG_ON()s
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:46:54 +0200 (CEST)

These really can be handled gracefully without killing the machine.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/signal.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1940,10 +1940,11 @@ struct sigqueue *sigqueue_alloc(void)
 
 void sigqueue_free(struct sigqueue *q)
 {
-	unsigned long flags;
 	spinlock_t *lock = &current->sighand->siglock;
+	unsigned long flags;
 
-	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
+	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
+		return;
 	/*
 	 * We must hold ->siglock while testing q->list
 	 * to serialize with collect_signal() or with
@@ -1971,7 +1972,10 @@ int send_sigqueue(struct sigqueue *q, st
 	unsigned long flags;
 	int ret, result;
 
-	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
+	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
+		return 0;
+	if (WARN_ON_ONCE(q->info.si_code != SI_TIMER))
+		return 0;
 
 	ret = -1;
 	rcu_read_lock();
@@ -2006,7 +2010,6 @@ int send_sigqueue(struct sigqueue *q, st
 		 * If an SI_TIMER entry is already queue just increment
 		 * the overrun count.
 		 */
-		BUG_ON(q->info.si_code != SI_TIMER);
 		q->info.si_overrun++;
 		result = TRACE_SIGNAL_ALREADY_PENDING;
 		goto out;


