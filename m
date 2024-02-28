Return-Path: <linux-kernel+bounces-85041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B108086AF7D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518851F26CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9644E14CACB;
	Wed, 28 Feb 2024 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UEJL73yD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="94teTech"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676E1148FF4;
	Wed, 28 Feb 2024 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709124806; cv=none; b=Z66rYL3dmxzXHHc6aJMEJVgj3ifjXce84GAhtBwHro9oVa4E9YXMFkE4jmHcUIEz8eJ5l97BNnOgdVm+h+ROeEQE290kgBPuU5ApeEfOneYcY2XZscdEJDxE+C+DTeqaGsJ2DKgxb4jTY/kX7kaBWHqiB7fJ0wVZ73xIy1mDTW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709124806; c=relaxed/simple;
	bh=C3vOKNNRVeN2kWDi7R/yUhn0sjrmnGVWSAwCCZmLsUw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s3D62EMDa2esr3dQnF4/G4h5KMcT2doT3v7/406lvl/k9MUoBECxKNy4I8Vy2na9ZyQookVbeafOHLy4C4lJv/BJuQQlmJVbma32jXqNTlzwOMlgygR99loIYp9wMQXvh8f1QW/ub471y97sMdnBnHnVkqvHJNeyhm98fGnzizA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UEJL73yD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=94teTech; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Feb 2024 12:53:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709124803;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QkfdDJ39k9nOfQhuzJnliw8RyOAojcJmrIWCgIKx7Q4=;
	b=UEJL73yDG/2ara8SPcY4ceh24+o+MPechCmOxbyFQ1C+b6h4BppEJ9KVpTF5m75JQHU5se
	ki2p7n/vxItBit+ifv8ebQXlYNtsmb07Nt0KJmvMdwSEx8Ut01Ma/AqDkHagpq81DsNwYe
	gG0sl0uIITChwTYpq4LZf1+IL8LwRRDK1bCr7Kk6yh3HkkXWSx27yjdAD+kKTSkLDRYaho
	sIT/1b6ev62xA4z3mUo0RchQ7EK7EgrFODGBbj9nVZV1V6mz1eTU5N2igbVmL4FbQ+ig7k
	Gr4PYtTz/tZTZH021lDhZuVnN+Q/npwJSKfQXOhw4lvFDMym4xhzm1Ks+HQH4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709124803;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QkfdDJ39k9nOfQhuzJnliw8RyOAojcJmrIWCgIKx7Q4=;
	b=94teTech2HnXFs1VXoigDJD/ONMVvQF9w8+xxdgeRDFM0NKxoroat/W8+aWSCMGNbv5CPV
	pDGnqsvWJI54PPBw==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/mutex: Simplify <linux/mutex.h>
Cc: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240222150540.79981-3-longman@redhat.com>
References: <20240222150540.79981-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170912480286.398.2593451967158120773.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d6cac0b6b0115fd0a5f51a49401473626e4e4fe7
Gitweb:        https://git.kernel.org/tip/d6cac0b6b0115fd0a5f51a49401473626e4e4fe7
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 22 Feb 2024 10:05:38 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 28 Feb 2024 13:08:37 +01:00

locking/mutex: Simplify <linux/mutex.h>

CONFIG_DEBUG_MUTEXES and CONFIG_PREEMPT_RT are mutually exclusive. They
can't be both set at the same time.  Move up the mutex_destroy() function
declaration and the __DEBUG_MUTEX_INITIALIZER() macro above the "#ifndef
CONFIG_PREEMPT_RT" section to eliminate duplicated mutex_destroy()
declaration.

Also remove the duplicated mutex_trylock() function declaration in the
CONFIG_PREEMPT_RT section.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20240222150540.79981-3-longman@redhat.com
---
 include/linux/mutex.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 7e208d4..67edc4c 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -32,11 +32,9 @@
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname)
 #endif
 
-#ifndef CONFIG_PREEMPT_RT
-
 #ifdef CONFIG_DEBUG_MUTEXES
 
-#define __DEBUG_MUTEX_INITIALIZER(lockname)				\
+# define __DEBUG_MUTEX_INITIALIZER(lockname)				\
 	, .magic = &lockname
 
 extern void mutex_destroy(struct mutex *lock);
@@ -49,6 +47,7 @@ static inline void mutex_destroy(struct mutex *lock) {}
 
 #endif
 
+#ifndef CONFIG_PREEMPT_RT
 /**
  * mutex_init - initialize the mutex
  * @mutex: the mutex to be initialized
@@ -101,9 +100,6 @@ extern bool mutex_is_locked(struct mutex *lock);
 
 extern void __mutex_rt_init(struct mutex *lock, const char *name,
 			    struct lock_class_key *key);
-extern int mutex_trylock(struct mutex *lock);
-
-static inline void mutex_destroy(struct mutex *lock) { }
 
 #define mutex_is_locked(l)	rt_mutex_base_is_locked(&(l)->rtmutex)
 

