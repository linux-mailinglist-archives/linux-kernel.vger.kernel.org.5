Return-Path: <linux-kernel+bounces-85038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FC786AF77
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672681C23221
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28F51487DC;
	Wed, 28 Feb 2024 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hlDZIrOm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T0gpe7nS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE5812D766;
	Wed, 28 Feb 2024 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709124804; cv=none; b=N6AeneAuT6L3crqY99mzaGevlyoxfB4wXGdrw6gD/88CL+2TcRa+oV9z/xaSXoiZVgnl8KSKj4wOWdeXrQb+Y/yIXuKB3Tea3Sdjza/gBDod5sJygxXRQoAbvZaHn6bmq6YPHCwv4GIviNClXKZwWWOJAC/x6fptV2Y2Rhgir5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709124804; c=relaxed/simple;
	bh=Zu1jEXwEn04gHO4PYNO1FTohlyOqRbL9PKC8J3KVgTE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sYWIVoznwA9G1gb9PyqEcsHjHSHFpA7Lf2CHFXq0MMPtzEPNldxEkyaIj69yStIrWtGJ0qNafI2t4W4g5BoZtvV3NNDQNPz/9sp7JE9mZoVqGZbFSXJJVD5mbpKw6X6qiDsD/ThR+iar06i0nE8YN88IpuLOZrQ/gOulT+EV4gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hlDZIrOm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T0gpe7nS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Feb 2024 12:53:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709124801;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiBS1QRCgATOeMSN+G6V+QMrDH6WO5XpkcNGtlJ/Wx0=;
	b=hlDZIrOmrS2vU2pts2pStfQ3ny3m1mIdPnOb0+cX6CxI3DdHF/MsRi9v9FCuRZC7vu4zRM
	1i26k3dv7FR4NoFHCn/FbGHyubBJrumHUAm5YwHHBI1GCSOI+iwlEgU6CRFOYzw2G3z9OV
	MXe3M6UZeEd08vsmzTTosCb9ROUAVYtHdJbXhon8Vixr9YyGqkQmIZ2RBufXbZhn5tVIij
	/KVhLVFki9eCHU+aCN4LZRdxXrIcDpGN5TCs8KTwOkSLaA+4CLXmvqWySbWNPfPWr2YMH2
	IBdSZSdyd/B0FZzb+emdsytlk+tBat9LvLtS3WrHnpzc3Z/THtdt6x0KZBt27Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709124801;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiBS1QRCgATOeMSN+G6V+QMrDH6WO5XpkcNGtlJ/Wx0=;
	b=T0gpe7nSbBTeck1WBl9/2ZVD25RAYjR3ORVteE2f/Uj8gw+op9ygmjh7suQgEuav6b1eWx
	xJCO7dd+QjFqARBA==
From: "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/percpu-rwsem: Trigger contention
 tracepoints only if contended
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Waiman Long <longman@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231108215322.2845536-1-namhyung@kernel.org>
References: <20231108215322.2845536-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170912480008.398.3227781797788701181.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f3e3620f1a97fcd02a5f3606fa63888dbcffd82c
Gitweb:        https://git.kernel.org/tip/f3e3620f1a97fcd02a5f3606fa63888dbcffd82c
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Wed, 08 Nov 2023 13:53:22 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 28 Feb 2024 13:10:29 +01:00

locking/percpu-rwsem: Trigger contention tracepoints only if contended

We mistakenly always fire lock contention tracepoints in the writer path,
while it should be conditional on the trylock result.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20231108215322.2845536-1-namhyung@kernel.org
---
 kernel/locking/percpu-rwsem.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 185bd1c..6083883 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -223,9 +223,10 @@ static bool readers_active_check(struct percpu_rw_semaphore *sem)
 
 void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
 {
+	bool contended = false;
+
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
-	trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_WRITE);
 
 	/* Notify readers to take the slow path. */
 	rcu_sync_enter(&sem->rss);
@@ -234,8 +235,11 @@ void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
 	 * Try set sem->block; this provides writer-writer exclusion.
 	 * Having sem->block set makes new readers block.
 	 */
-	if (!__percpu_down_write_trylock(sem))
+	if (!__percpu_down_write_trylock(sem)) {
+		trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_WRITE);
 		percpu_rwsem_wait(sem, /* .reader = */ false);
+		contended = true;
+	}
 
 	/* smp_mb() implied by __percpu_down_write_trylock() on success -- D matches A */
 
@@ -247,7 +251,8 @@ void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
 
 	/* Wait for all active readers to complete. */
 	rcuwait_wait_event(&sem->writer, readers_active_check(sem), TASK_UNINTERRUPTIBLE);
-	trace_contention_end(sem, 0);
+	if (contended)
+		trace_contention_end(sem, 0);
 }
 EXPORT_SYMBOL_GPL(percpu_down_write);
 

