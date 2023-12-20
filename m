Return-Path: <linux-kernel+bounces-6140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EB981950E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 210D0B23E82
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A74C128;
	Wed, 20 Dec 2023 00:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ePJbYj50"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEDAB64F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5cf4696e202so67923457b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703031553; x=1703636353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R4gN3By35m9Oev8xh3bj9l9i7deQm7lEgF77PrA60M4=;
        b=ePJbYj50mEx75GgLkfCRl2N1CTA2OgV374FJNQvOQExrauWzIrHkcMfcDXowGqMEWq
         GisyGDyWaYoLATTmbpDkz+ui3ILBqOICVjAGtUuAl7w+cmBuMGHlAbiMBfKbomd/33KZ
         1E+gd+5nHbDWvU7o/welF2+SoCIZ0tkyUMWz1AUP7INTEKKAc62k+HeHmWi3rDl8wSpd
         aw6ea3NWHpzGudaRSPMMLPUPT3EBcoMslErK80l+N9BA8zXhYBOKRNGjAWApjUIUkvXj
         kTKJ3T6yup6bU8zck8fKeGKbik5F032EBH+Xuvp/Ghh0bf4YVRVMLuCINt3q1I3cMjNS
         o2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703031553; x=1703636353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R4gN3By35m9Oev8xh3bj9l9i7deQm7lEgF77PrA60M4=;
        b=jm4cXp0z3tg7AZra85VLn872IszJk0pmWIyWomoL68FFy8ZU3OjqumbyikE+lvutT+
         /DcSzPmTk1ppDq49Adoc9rQF/q55QTuaV7jcdPhRrOQmZuW0OC6x0WPW2qKnl3at7Cs7
         FE2VooX3BFTx8qm22a1NJM/YmmQxw8/7NRR9jUY7BpPbRgjCmQC1nyj0bTFg03RNGiCH
         QpYj5F3T8lyLCUO2d9maCGEpJ+h8+OK2eu2b2w9S11QZJBZjMrZ6RdQo98VWJPjRS+qs
         0pyuWMkCd3Kz6tVGlpqDMorNZW/Yb6ZMLEE6SlOnXBUqhFNsThkjp7vq51j74JgFpADT
         /5yg==
X-Gm-Message-State: AOJu0Yy7PUHSv1wBUzjF929JACtVQrDE1f55iVONg9qmXCeYIwqRWmBL
	2xGNizYG6XKB6c6ZdjCYEymMZA9MbTEG4h/o9CHAKgUEVnn8T3jP5KJ1h2oTLZoroVU8+WfM4MI
	SW3HguTgFDG48erR5SwLXkZUukcLRUOqJOmCxhOlb4muOEqgUXcmEQqi5kcw9WNSt8II/3so=
X-Google-Smtp-Source: AGHT+IFTRDyLyo4xM/u+37VsmESEsy4LtuVDSD58dzoRhs6ZUZnQrBulUNuz8RlZBhWXmmvvP5Ns81A3uWhG
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:fe0b:0:b0:5e6:468e:fea0 with SMTP id
 j11-20020a81fe0b000000b005e6468efea0mr2377004ywn.0.1703031553048; Tue, 19 Dec
 2023 16:19:13 -0800 (PST)
Date: Tue, 19 Dec 2023 16:18:17 -0800
In-Reply-To: <20231220001856.3710363-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220001856.3710363-7-jstultz@google.com>
Subject: [PATCH v7 06/23] sched: Add CONFIG_SCHED_PROXY_EXEC & boot argument
 to enable/disable
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Add a CONFIG_SCHED_PROXY_EXEC option, along with a boot argument
sched_prox_exec= that can be used to disable the feature at boot
time if CONFIG_SCHED_PROXY_EXEC was enabled.

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Youssef Esmat <youssefesmat@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-team@android.com
Signed-off-by: John Stultz <jstultz@google.com>
---
v7:
* Switch to CONFIG_SCHED_PROXY_EXEC/sched_proxy_exec= as
  suggested by Metin Kaya.
* Switch boot arg from =disable/enable to use kstrtobool(),
  which supports =yes|no|1|0|true|false|on|off, as also
  suggested by Metin Kaya, and print a message when a boot
  argument is used.
---
 .../admin-guide/kernel-parameters.txt         |  5 ++++
 include/linux/sched.h                         | 13 +++++++++
 init/Kconfig                                  |  7 +++++
 kernel/sched/core.c                           | 29 +++++++++++++++++++
 4 files changed, 54 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..cc64393b913f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5714,6 +5714,11 @@
 	sa1100ir	[NET]
 			See drivers/net/irda/sa1100_ir.c.
 
+	sched_proxy_exec= [KNL]
+			Enables or disables "proxy execution" style
+			solution to mutex based priority inversion.
+			Format: <bool>
+
 	sched_verbose	[KNL] Enables verbose scheduler debug messages.
 
 	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index bfe8670f99a1..880af1c3097d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1566,6 +1566,19 @@ struct task_struct {
 	 */
 };
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+DECLARE_STATIC_KEY_TRUE(__sched_proxy_exec);
+static inline bool sched_proxy_exec(void)
+{
+	return static_branch_likely(&__sched_proxy_exec);
+}
+#else
+static inline bool sched_proxy_exec(void)
+{
+	return false;
+}
+#endif
+
 static inline struct pid *task_pid(struct task_struct *task)
 {
 	return task->thread_pid;
diff --git a/init/Kconfig b/init/Kconfig
index 9ffb103fc927..c5a759b6366a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -908,6 +908,13 @@ config NUMA_BALANCING_DEFAULT_ENABLED
 	  If set, automatic NUMA balancing will be enabled if running on a NUMA
 	  machine.
 
+config SCHED_PROXY_EXEC
+	bool "Proxy Execution"
+	default n
+	help
+	  This option enables proxy execution, a mechanism for mutex owning
+	  tasks to inherit the scheduling context of higher priority waiters.
+
 menuconfig CGROUPS
 	bool "Control Group support"
 	select KERNFS
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4e46189d545d..e06558fb08aa 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -117,6 +117,35 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
+static int __init setup_proxy_exec(char *str)
+{
+	bool proxy_enable;
+
+	if (kstrtobool(str, &proxy_enable)) {
+		pr_warn("Unable to parse sched_proxy_exec=\n");
+		return 0;
+	}
+
+	if (proxy_enable) {
+		pr_info("sched_proxy_exec enabled via boot arg\n");
+		static_branch_enable(&__sched_proxy_exec);
+	} else {
+		pr_info("sched_proxy_exec disabled via boot arg\n");
+		static_branch_disable(&__sched_proxy_exec);
+	}
+	return 1;
+}
+#else
+static int __init setup_proxy_exec(char *str)
+{
+	pr_warn("CONFIG_SCHED_PROXY_EXEC=n, so it cannot be enabled or disabled at boottime\n");
+	return 0;
+}
+#endif
+__setup("sched_proxy_exec=", setup_proxy_exec);
+
 #ifdef CONFIG_SCHED_DEBUG
 /*
  * Debugging: various feature bits
-- 
2.43.0.472.g3155946c3a-goog


