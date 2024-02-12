Return-Path: <linux-kernel+bounces-61492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8988512DA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42CA1F232EC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D510D3EA9D;
	Mon, 12 Feb 2024 11:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="MhIZ+vrW"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45B3CF7C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738950; cv=none; b=sF1RxqBp2asq+j8qNFu87h5psjS25MFCDegOfUFQbCzOVHLHkdIvUJIkIa+tr4fNZzQxGeRdkvIP/wCLrRZPDg+R3HstI3NkD/VjLEhXoFYwQmQKdUYhJZHGTRYQjePeVPboPSptnpaz2jMQ+e3BvgALEKLpUSHienTpCSM2Kvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738950; c=relaxed/simple;
	bh=0uNxMmPW3ft41GkJptc9fKYpCjay3ItJ9nBDiclDxtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hPysskrPIa2ilcKbIqrHrASbNb8nOZi97E6gCDZm51TKkzmks9erkFZ5Ne5sgcdAPc+8/PgsLcZlCZxPnechPcQ6/hAB2c/SYBgNk8vCdDnoggMnozWUbRoXqPwVsCBjd4OQLNZnqQzBqLDaTN1UTtJfBSU8rG4gWXGYNn1/29Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=MhIZ+vrW; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so412508866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738943; x=1708343743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uf0ClCoggpv43to3o2gMnopZzVsI9NZGQ6yqGHeIiJM=;
        b=MhIZ+vrWZ6l1gjV7WGva87yOxnU1dEZm1VvALIpAsKPLHNCpdSAYoMg4WR9Kci2Ku6
         7ZcVl0ZxtCe53sCkMk/3plzoFNZJ/Y97NNLjQrQuHe/oXW9HSG0WY8WFEUYqe6KoDS1E
         O76ZfGJinWFYyEUv2BWRuZmst18HPUWnYfPeQ4PhCjl7ciG4bXVX6N8bowzi8vV41N6Z
         GmhBE4MneIdOH5VYKYaKEdtNsiHcT4C23HCOwlRQ0GbcSFHmXbyL4JznUQYkpe78OLbQ
         duYadDLPyucHJL9wGCgLWYsDXJIR8cl9poVDsgSIXzgtb8QvZOSmIiVBfC/RryUyouCW
         f+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738943; x=1708343743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uf0ClCoggpv43to3o2gMnopZzVsI9NZGQ6yqGHeIiJM=;
        b=e85xIT1zM8QOLQJHACqaHPZGl9sjsbb+L9FTDW3Zz4kBo0t3FIR95GyGLjwhDm2Yob
         YOnnfU2SXswz62sdHKDYQ34zjdnul+mgKFiMhY2zVWnppoK+yotGp8NaiMx2cxwMBKK3
         ct119Lw7bQ1jMNeFqNYhRgplc46unVxqtcDTNrWGdOLt5aqfD8P5E4r1WSD88zIkjRUn
         LWqsGY1TLLMacWdnDganmLefzPrRiBY9mRnrBa4bzKSIh6c0y/9s2lNv63jtc4mXMx87
         kBwp18UPpwykRZn9FEBYJM8jp3M1mqjWJmCWf4WPxPr3iJM1mCATWmyPwIyR11Plo+wW
         Y3IQ==
X-Gm-Message-State: AOJu0Yzilz69ev50GpS1WtmMCP0WNYSb6Ks1JwGDbze82URdnyPzdk0W
	VUgtJgJkGUEeit56Bd+lWYnxtmQxOwO7Hd/vO2k2uLv8nI7g0YghqAtYvVjXW+SsC1MZYShU9W/
	W
X-Google-Smtp-Source: AGHT+IE+VD+JobNC0btBiejb2ca8xNWLrYN0Vpgb15Fqe8PdhzHSOazpr/KlPLobmjsTRbHw3mnkaA==
X-Received: by 2002:a17:906:b898:b0:a37:b590:c15b with SMTP id hb24-20020a170906b89800b00a37b590c15bmr4246170ejb.65.1707738943449;
        Mon, 12 Feb 2024 03:55:43 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090607c100b00a36c3e2e52dsm139203ejc.61.2024.02.12.03.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:55:42 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 30/35] linux/kernel.h: move might_sleep(), ... to sched/debug_atomic_sleep.h
Date: Mon, 12 Feb 2024 12:54:55 +0100
Message-Id: <20240212115500.2078463-31-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212115500.2078463-1-max.kellermann@ionos.com>
References: <20240212115500.2078463-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reducing dependencies on the header linux/kernel.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/clk.h                      |   1 +
 include/linux/gpio/consumer.h            |   2 +-
 include/linux/kernel.h                   | 109 ----------------------
 include/linux/mmu_notifier.h             |   1 +
 include/linux/pwm.h                      |   2 +
 include/linux/rcutiny.h                  |   1 +
 include/linux/sched.h                    |   1 +
 include/linux/sched/debug_atomic_sleep.h | 114 +++++++++++++++++++++++
 include/linux/sched/mm.h                 |   2 +-
 include/linux/uaccess.h                  |   1 +
 include/linux/wait.h                     |   1 +
 include/linux/wait_bit.h                 |   2 +-
 security/landlock/object.c               |   1 +
 security/landlock/ruleset.c              |   1 +
 14 files changed, 127 insertions(+), 112 deletions(-)
 create mode 100644 include/linux/sched/debug_atomic_sleep.h

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 06f1b292f8a0..2fcae620703b 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/notifier.h>
+#include <linux/sched/debug_atomic_sleep.h> // for might_sleep()
 
 struct device;
 struct clk;
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index db2dfbae8edb..a02927330429 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -184,7 +184,7 @@ struct gpio_desc *devm_fwnode_gpiod_get_index(struct device *dev,
 #else /* CONFIG_GPIOLIB */
 
 #include <linux/err.h>
-#include <linux/kernel.h>
+#include <linux/sched/debug_atomic_sleep.h> // for might_sleep()
 
 #include <asm/bug.h>
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index f4a1d582b79d..67662bdb17d0 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -80,115 +80,6 @@
  */
 #define lower_16_bits(n) ((u16)((n) & 0xffff))
 
-struct completion;
-struct user;
-
-#ifdef CONFIG_PREEMPT_VOLUNTARY_BUILD
-
-extern int __cond_resched(void);
-# define might_resched() __cond_resched()
-
-#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
-
-extern int __cond_resched(void);
-
-DECLARE_STATIC_CALL(might_resched, __cond_resched);
-
-static __always_inline void might_resched(void)
-{
-	static_call_mod(might_resched)();
-}
-
-#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-
-extern int dynamic_might_resched(void);
-# define might_resched() dynamic_might_resched()
-
-#else
-
-# define might_resched() do { } while (0)
-
-#endif /* CONFIG_PREEMPT_* */
-
-#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-extern void __might_resched(const char *file, int line, unsigned int offsets);
-extern void __might_sleep(const char *file, int line);
-extern void __cant_sleep(const char *file, int line, int preempt_offset);
-extern void __cant_migrate(const char *file, int line);
-
-/**
- * might_sleep - annotation for functions that can sleep
- *
- * this macro will print a stack trace if it is executed in an atomic
- * context (spinlock, irq-handler, ...). Additional sections where blocking is
- * not allowed can be annotated with non_block_start() and non_block_end()
- * pairs.
- *
- * This is a useful debugging help to be able to catch problems early and not
- * be bitten later when the calling function happens to sleep when it is not
- * supposed to.
- */
-# define might_sleep() \
-	do { __might_sleep(__FILE__, __LINE__); might_resched(); } while (0)
-/**
- * cant_sleep - annotation for functions that cannot sleep
- *
- * this macro will print a stack trace if it is executed with preemption enabled
- */
-# define cant_sleep() \
-	do { __cant_sleep(__FILE__, __LINE__, 0); } while (0)
-# define sched_annotate_sleep()	(current->task_state_change = 0)
-
-/**
- * cant_migrate - annotation for functions that cannot migrate
- *
- * Will print a stack trace if executed in code which is migratable
- */
-# define cant_migrate()							\
-	do {								\
-		if (IS_ENABLED(CONFIG_SMP))				\
-			__cant_migrate(__FILE__, __LINE__);		\
-	} while (0)
-
-/**
- * non_block_start - annotate the start of section where sleeping is prohibited
- *
- * This is on behalf of the oom reaper, specifically when it is calling the mmu
- * notifiers. The problem is that if the notifier were to block on, for example,
- * mutex_lock() and if the process which holds that mutex were to perform a
- * sleeping memory allocation, the oom reaper is now blocked on completion of
- * that memory allocation. Other blocking calls like wait_event() pose similar
- * issues.
- */
-# define non_block_start() (current->non_block_count++)
-/**
- * non_block_end - annotate the end of section where sleeping is prohibited
- *
- * Closes a section opened by non_block_start().
- */
-# define non_block_end() WARN_ON(current->non_block_count-- == 0)
-#else
-  static inline void __might_resched(const char *file, int line,
-				     unsigned int offsets) { }
-static inline void __might_sleep(const char *file, int line) { }
-# define might_sleep() do { might_resched(); } while (0)
-# define cant_sleep() do { } while (0)
-# define cant_migrate()		do { } while (0)
-# define sched_annotate_sleep() do { } while (0)
-# define non_block_start() do { } while (0)
-# define non_block_end() do { } while (0)
-#endif
-
-#define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
-
-#if defined(CONFIG_MMU) && \
-	(defined(CONFIG_PROVE_LOCKING) || defined(CONFIG_DEBUG_ATOMIC_SLEEP))
-#define might_fault() __might_fault(__FILE__, __LINE__)
-void __might_fault(const char *file, int line);
-#else
-static inline void might_fault(void) { }
-#endif
-
 void do_exit(long error_code) __noreturn;
 
 extern int get_option(char **str, int *pint);
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 6aa17677254b..d13d1210e7a0 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -5,6 +5,7 @@
 #include <linux/list.h>
 #include <linux/mm_types.h>
 #include <linux/mmap_lock.h>
+#include <linux/sched/debug_atomic_sleep.h> // for might_sleep()
 #include <linux/srcu.h>
 #include <linux/interval_tree.h>
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 4eef97d74366..8c3165ebec5e 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -403,6 +403,8 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
 				       struct fwnode_handle *fwnode,
 				       const char *con_id);
 #else
+#include <linux/sched/debug_atomic_sleep.h> // for might_sleep()
+
 static inline bool pwm_might_sleep(struct pwm_device *pwm)
 {
 	return true;
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index d9ac7b136aea..e7b6acfbf054 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -12,6 +12,7 @@
 #ifndef __LINUX_TINY_H
 #define __LINUX_TINY_H
 
+#include <linux/sched/debug_atomic_sleep.h> // for might_sleep()
 #include <asm/param.h> /* for HZ */
 
 struct rcu_gp_oldstate {
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 42555e8e5aa7..796c32c124c5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -32,6 +32,7 @@
 #include <linux/resource.h>
 #include <linux/latencytop.h>
 #include <linux/log2.h>
+#include <linux/sched/debug_atomic_sleep.h> // for __might_resched()
 #include <linux/sched/prio.h>
 #include <linux/sched/types.h>
 #include <linux/signal_types.h>
diff --git a/include/linux/sched/debug_atomic_sleep.h b/include/linux/sched/debug_atomic_sleep.h
new file mode 100644
index 000000000000..018d4a421a80
--- /dev/null
+++ b/include/linux/sched/debug_atomic_sleep.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SCHED_DEBUG_ATOMIC_SLEEP_H
+#define _LINUX_SCHED_DEBUG_ATOMIC_SLEEP_H
+
+#ifdef CONFIG_PREEMPT_VOLUNTARY_BUILD
+
+extern int __cond_resched(void);
+# define might_resched() __cond_resched()
+
+#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
+
+#include <linux/static_call_types.h>
+
+extern int __cond_resched(void);
+
+DECLARE_STATIC_CALL(might_resched, __cond_resched);
+
+static __always_inline void might_resched(void)
+{
+	static_call_mod(might_resched)();
+}
+
+#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+
+extern int dynamic_might_resched(void);
+# define might_resched() dynamic_might_resched()
+
+#else
+
+# define might_resched() do { } while (0)
+
+#endif /* CONFIG_PREEMPT_* */
+
+#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
+extern void __might_resched(const char *file, int line, unsigned int offsets);
+extern void __might_sleep(const char *file, int line);
+extern void __cant_sleep(const char *file, int line, int preempt_offset);
+extern void __cant_migrate(const char *file, int line);
+
+/**
+ * might_sleep - annotation for functions that can sleep
+ *
+ * this macro will print a stack trace if it is executed in an atomic
+ * context (spinlock, irq-handler, ...). Additional sections where blocking is
+ * not allowed can be annotated with non_block_start() and non_block_end()
+ * pairs.
+ *
+ * This is a useful debugging help to be able to catch problems early and not
+ * be bitten later when the calling function happens to sleep when it is not
+ * supposed to.
+ */
+# define might_sleep() \
+	do { __might_sleep(__FILE__, __LINE__); might_resched(); } while (0)
+/**
+ * cant_sleep - annotation for functions that cannot sleep
+ *
+ * this macro will print a stack trace if it is executed with preemption enabled
+ */
+# define cant_sleep() \
+	do { __cant_sleep(__FILE__, __LINE__, 0); } while (0)
+# define sched_annotate_sleep()	(current->task_state_change = 0)
+
+/**
+ * cant_migrate - annotation for functions that cannot migrate
+ *
+ * Will print a stack trace if executed in code which is migratable
+ */
+# define cant_migrate()							\
+	do {								\
+		if (IS_ENABLED(CONFIG_SMP))				\
+			__cant_migrate(__FILE__, __LINE__);		\
+	} while (0)
+
+/**
+ * non_block_start - annotate the start of section where sleeping is prohibited
+ *
+ * This is on behalf of the oom reaper, specifically when it is calling the mmu
+ * notifiers. The problem is that if the notifier were to block on, for example,
+ * mutex_lock() and if the process which holds that mutex were to perform a
+ * sleeping memory allocation, the oom reaper is now blocked on completion of
+ * that memory allocation. Other blocking calls like wait_event() pose similar
+ * issues.
+ */
+# define non_block_start() (current->non_block_count++)
+/**
+ * non_block_end - annotate the end of section where sleeping is prohibited
+ *
+ * Closes a section opened by non_block_start().
+ */
+# define non_block_end() WARN_ON(current->non_block_count-- == 0)
+#else
+  static inline void __might_resched(const char *file, int line,
+				     unsigned int offsets) { }
+static inline void __might_sleep(const char *file, int line) { }
+# define might_sleep() do { might_resched(); } while (0)
+# define cant_sleep() do { } while (0)
+# define cant_migrate()		do { } while (0)
+# define sched_annotate_sleep() do { } while (0)
+# define non_block_start() do { } while (0)
+# define non_block_end() do { } while (0)
+#endif
+
+#define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
+
+#if defined(CONFIG_MMU) && \
+	(defined(CONFIG_PROVE_LOCKING) || defined(CONFIG_DEBUG_ATOMIC_SLEEP))
+#define might_fault() __might_fault(__FILE__, __LINE__)
+void __might_fault(const char *file, int line);
+#else
+static inline void might_fault(void) { }
+#endif
+
+
+#endif
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index c29059a76052..1a6286496495 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -2,9 +2,9 @@
 #ifndef _LINUX_SCHED_MM_H
 #define _LINUX_SCHED_MM_H
 
-#include <linux/kernel.h>
 #include <linux/atomic.h>
 #include <linux/sched.h>
+#include <linux/sched/debug_atomic_sleep.h> // for might_sleep_if()
 #include <linux/mm_types.h>
 #include <linux/gfp.h>
 #include <linux/sync_core.h>
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 3064314f4832..8ea27d05f17e 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -6,6 +6,7 @@
 #include <linux/instrumented.h>
 #include <linux/minmax.h>
 #include <linux/sched.h>
+#include <linux/sched/debug_atomic_sleep.h> // for might_faul()
 #include <linux/thread_info.h>
 
 #include <asm/uaccess.h>
diff --git a/include/linux/wait.h b/include/linux/wait.h
index b36000bb012c..deb1204ed222 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -5,6 +5,7 @@
  * Linux wait queue related types and methods
  */
 #include <linux/wait_types.h>
+#include <linux/sched/debug_atomic_sleep.h> // for might_sleep()
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
 
diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 514f68eff79d..9cc8fcba24c5 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -7,7 +7,7 @@
  */
 #include <linux/bitops.h>
 #include <linux/init.h> // for __init
-#include <linux/kernel.h> // for might_sleep()
+#include <linux/sched/debug_atomic_sleep.h> // for might_sleep()
 #include <linux/wait_types.h>
 
 struct wait_bit_key {
diff --git a/security/landlock/object.c b/security/landlock/object.c
index 1f50612f0185..feb2dec3d89a 100644
--- a/security/landlock/object.c
+++ b/security/landlock/object.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/rcupdate.h>
 #include <linux/refcount.h>
+#include <linux/sched/debug_atomic_sleep.h> // for might_sleep()
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index e0a5fbf9201a..36396959a0e9 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -16,6 +16,7 @@
 #include <linux/overflow.h>
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
+#include <linux/sched/debug_atomic_sleep.h> // for might_sleep_if()
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
-- 
2.39.2


