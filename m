Return-Path: <linux-kernel+bounces-168055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D988BB321
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990E11C20D73
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18C0158D8C;
	Fri,  3 May 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vtZGc5L9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P10KOxGy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49802158864;
	Fri,  3 May 2024 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761010; cv=none; b=P0H0UbZjfxvwt3DjIz/Y4I3JOr/JTHRncMPhk7Eat4yGXiuR8flMSPNlAQD8TrBVG53QoXimI4rToNiswQhKKTMR+iISLDeuyBlMi8k37hEim5+5inAzt1bxMrKr+FgczFEJyHAwoKungbr93JU4oJ+jt2c5JPP74d/8HSJ/nNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761010; c=relaxed/simple;
	bh=MZehckFQCZ1u/y7PloNAo3YtUp4b7HlyP3SBCD07p70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gApDYJ29j3jGWaZVbG/5cYmMUhTvM92s9SDwNXh68+odupimxvkEe4L9bcRphguhH4siLc2ZeOmXCOKSdp+P0ujhnsjBuiMEqWQZvnFE+syP2IK5g6EgKL7/JoMC8c+CSJqwJIgYdrFw8NzdotJCIMemINGPHlxHFXQ8o//eksE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vtZGc5L9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P10KOxGy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714761006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wq7pOwmFszJxpMJEiSdFQognKwP7zLDfT8VaO1TStI=;
	b=vtZGc5L98qmbPquh7Z+gsbsv5TolCzpKxbdmLaMh3VhY0YbUx3eyfeEMFay3ULMEvZDqKV
	rHnEpc8Xv2w0g62ncWJ2rfmsx3o7Vy+u9kwANTLENb2nsGp65bDPU3LXoXGWkhdf8nDhqs
	cBL5ygaTaCCtIVNjnw5UwYzHygxwnKvVkZTCKPrwQqYd7JAa0o198++8/5u//7E1W2zMZw
	FXjApyID1JMQkiEggkd/B6M+TbcmFAzMLkvOy2X0gAdTDj2KsBvSWWMvZGnuslDmeIs5lD
	FA3VuMEmCntPt1Zuvfn92qntKOnDt0JFYCS+li/26/FMLkUtDmJg9xy1ejJwWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714761006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wq7pOwmFszJxpMJEiSdFQognKwP7zLDfT8VaO1TStI=;
	b=P10KOxGyLneL8XFy/dt/maTprc9Rkl2YrgbmoGMDTLPvOtP+Cp6zhB21eDvxgs2cEWcieo
	frvQWDKpetzzJPBg==
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
Subject: [PATCH net-next 02/15] locking/local_lock: Add local nested BH locking infrastructure.
Date: Fri,  3 May 2024 20:25:06 +0200
Message-ID: <20240503182957.1042122-3-bigeasy@linutronix.de>
In-Reply-To: <20240503182957.1042122-1-bigeasy@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add local_lock_nested_bh() locking. It is based on local_lock_t and the
naming follows the preempt_disable_nested() example.

For !PREEMPT_RT + !LOCKDEP it is a per-CPU annotation for locking
assumptions based on local_bh_disable(). The macro is optimized away
during compilation.
For !PREEMPT_RT + LOCKDEP the local_lock_nested_bh() is reduced to
the usual lock-acquire plus lockdep_assert_in_softirq() - ensuring that
BH is disabled.

For PREEMPT_RT local_lock_nested_bh() acquires the specified per-CPU
lock. It does not disable CPU migration because it relies on
local_bh_disable() disabling CPU migration.
With LOCKDEP it performans the usual lockdep checks as with !PREEMPT_RT.
Due to include hell the softirq check has been moved spinlock.c.

The intention is to use this locking in places where locking of a per-CPU
variable relies on BH being disabled. Instead of treating disabled
bottom halves as a big per-CPU lock, PREEMPT_RT can use this to reduce
the locking scope to what actually needs protecting.
A side effect is that it also documents the protection scope of the
per-CPU variables.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/local_lock.h          | 10 ++++++++++
 include/linux/local_lock_internal.h | 31 +++++++++++++++++++++++++++++
 include/linux/lockdep.h             |  3 +++
 kernel/locking/spinlock.c           |  8 ++++++++
 4 files changed, 52 insertions(+)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 82366a37f4474..091dc0b6bdfb9 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -62,4 +62,14 @@ DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_t __p=
ercpu,
 		    local_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
=20
+#define local_lock_nested_bh(_lock)				\
+	__local_lock_nested_bh(_lock)
+
+#define local_unlock_nested_bh(_lock)				\
+	__local_unlock_nested_bh(_lock)
+
+DEFINE_GUARD(local_lock_nested_bh, local_lock_t __percpu*,
+	     local_lock_nested_bh(_T),
+	     local_unlock_nested_bh(_T))
+
 #endif
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock=
_internal.h
index 975e33b793a77..8dd71fbbb6d2b 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -62,6 +62,17 @@ do {								\
 	local_lock_debug_init(lock);				\
 } while (0)
=20
+#define __spinlock_nested_bh_init(lock)				\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));\
+	lockdep_init_map_type(&(lock)->dep_map, #lock, &__key,  \
+			      0, LD_WAIT_CONFIG, LD_WAIT_INV,	\
+			      LD_LOCK_NORMAL);			\
+	local_lock_debug_init(lock);				\
+} while (0)
+
 #define __local_lock(lock)					\
 	do {							\
 		preempt_disable();				\
@@ -98,6 +109,15 @@ do {								\
 		local_irq_restore(flags);			\
 	} while (0)
=20
+#define __local_lock_nested_bh(lock)				\
+	do {							\
+		lockdep_assert_in_softirq();			\
+		local_lock_acquire(this_cpu_ptr(lock));	\
+	} while (0)
+
+#define __local_unlock_nested_bh(lock)				\
+	local_lock_release(this_cpu_ptr(lock))
+
 #else /* !CONFIG_PREEMPT_RT */
=20
 /*
@@ -138,4 +158,15 @@ typedef spinlock_t local_lock_t;
=20
 #define __local_unlock_irqrestore(lock, flags)	__local_unlock(lock)
=20
+#define __local_lock_nested_bh(lock)				\
+do {								\
+	lockdep_assert_in_softirq_func();			\
+	spin_lock(this_cpu_ptr(lock));				\
+} while (0)
+
+#define __local_unlock_nested_bh(lock)				\
+do {								\
+	spin_unlock(this_cpu_ptr((lock)));			\
+} while (0)
+
 #endif /* CONFIG_PREEMPT_RT */
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 08b0d1d9d78b7..3f5a551579cc9 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -600,6 +600,8 @@ do {									\
 		     (!in_softirq() || in_irq() || in_nmi()));		\
 } while (0)
=20
+extern void lockdep_assert_in_softirq_func(void);
+
 #else
 # define might_lock(lock) do { } while (0)
 # define might_lock_read(lock) do { } while (0)
@@ -613,6 +615,7 @@ do {									\
 # define lockdep_assert_preemption_enabled() do { } while (0)
 # define lockdep_assert_preemption_disabled() do { } while (0)
 # define lockdep_assert_in_softirq() do { } while (0)
+# define lockdep_assert_in_softirq_func() do { } while (0)
 #endif
=20
 #ifdef CONFIG_PROVE_RAW_LOCK_NESTING
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 8475a0794f8c5..438c6086d540e 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -413,3 +413,11 @@ notrace int in_lock_functions(unsigned long addr)
 	&& addr < (unsigned long)__lock_text_end;
 }
 EXPORT_SYMBOL(in_lock_functions);
+
+#if defined(CONFIG_PROVE_LOCKING) && defined(CONFIG_PREEMPT_RT)
+void notrace lockdep_assert_in_softirq_func(void)
+{
+	lockdep_assert_in_softirq();
+}
+EXPORT_SYMBOL(lockdep_assert_in_softirq_func);
+#endif
--=20
2.43.0


