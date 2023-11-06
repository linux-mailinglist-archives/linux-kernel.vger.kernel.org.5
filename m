Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961A87E2CFA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjKFTgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjKFTf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:35:57 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D410D42
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:35:52 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a5a3f2d4fso5597543276.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699299351; x=1699904151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JeaszBAoxCXKdkXYBf2TzRJcYXC3x0zPMGfP5WqEvsc=;
        b=4T34G51Vy24jzZYmXhLVBV33LpOwspeKDUmQx9HJQcv5TeDzByoGZmuh1Jx58QYspS
         GOo0ztpeLs7Zbct5/wX4dWIz8vkxkig9fJVuWYALs+xhjgKI3h1B0z6wlkn9ZKy6VHqN
         ARAA38YjWfq1heHQVGWuqG0nou7/iBtBHdH44evGq+gCm/8NpJvW9R1f+PPFPAOxkk6+
         mnkA70x+yEFQj/MtNLsm9IzFE5aacYqnAlH11ATuNlXvbjbGdpnG2ShqGSMdseDseUVP
         /Nwl7zBP+3eB8WAK/ibp9/4PgeabDcsa21IMJw/cS1z//4pcojchVH/Vjg9TMbcvXIxd
         uNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299351; x=1699904151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JeaszBAoxCXKdkXYBf2TzRJcYXC3x0zPMGfP5WqEvsc=;
        b=LqxsQkKrNbyX56umMmhVXarNhXUp+LxsOOLjIQNIbpM9NIZEZDWXaywKJliIf2dmGR
         2rRNppWC5qgMUQt3O1YbMdz8cwMXRC6jDPO2lhek5rSD5uwYs8t7TRi0o32aUD4myeY0
         JJV3dOq8tZTnJR7sEJu8GzS7qOW9cRqABiVvTGoL++Rzm/c7gUFKyX0+T1PCQW92aeqv
         wHgQjEsyXacv95jF1+V/JRJeLg7vf9wUha7n25bHU90hJSIolDQAiquVZ/p3JLFEiwsp
         S5q5z+NUls6FDRwGKyfM1MEj0sD+CUMofivcjUApvrA/cbPemJZVBNtX3y5RDP1jHweu
         acOQ==
X-Gm-Message-State: AOJu0YxKTELPlymViI2aGbGQpmsGbYc0IHijfpBprdiXulnbcsd5TJzJ
        eW70ajV2eduGXBCqyL1TbbZq2F4sfZs3GqMVlxxIJO+bWxq7b8lrC9K9idgdOAxScq6X+xB6LJH
        ZbC8WY3C1AuJM10Uks59pcgsPF4T93W2qkVHK+bgbD4ph/A7ibQFB3Y/5AwgHfY2F8ZU304g=
X-Google-Smtp-Source: AGHT+IFfAQBJwHKCUEtc1lCCAvLeb7ZhZV6fQoGJP3MV8a5CMDnMVK4WUbPUdMMs7gks2IbL4dSEWa3/hqNZ
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:1083:b0:d9a:c3b8:4274 with SMTP
 id v3-20020a056902108300b00d9ac3b84274mr698792ybu.7.1699299351218; Mon, 06
 Nov 2023 11:35:51 -0800 (PST)
Date:   Mon,  6 Nov 2023 19:34:51 +0000
In-Reply-To: <20231106193524.866104-1-jstultz@google.com>
Mime-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106193524.866104-9-jstultz@google.com>
Subject: [PATCH v6 08/20] sched: Add CONFIG_PROXY_EXEC & boot argument to enable/disable
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the CONFIG_PROXY_EXEC option, along with
a boot argument prox_exec= that can be used to disable the
feature at boot time if CONFIG_PROXY_EXEC was enabled.

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
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: kernel-team@android.com
Signed-off-by: John Stultz <jstultz@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  4 +++
 include/linux/sched.h                         | 13 ++++++++
 init/Kconfig                                  |  7 +++++
 kernel/sched/core.c                           | 31 +++++++++++++++++++
 4 files changed, 55 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a1731a0f0ef..199578ae1606 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4648,6 +4648,10 @@
 			that).
 			Format: <bool>
 
+	proxy_exec=	[KNL] Enable or disables "proxy execution" style
+			solution to mutex based priority inversion.
+			Format: "enable" or "disable"
+
 	psi=		[KNL] Enable or disable pressure stall information
 			tracking.
 			Format: <bool>
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 81334677e008..5f05d9a4cc3f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1551,6 +1551,19 @@ struct task_struct {
 	 */
 };
 
+#ifdef CONFIG_PROXY_EXEC
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
index 6d35728b94b2..884f94d8ee9e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -908,6 +908,13 @@ config NUMA_BALANCING_DEFAULT_ENABLED
 	  If set, automatic NUMA balancing will be enabled if running on a NUMA
 	  machine.
 
+config PROXY_EXEC
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
index 802551e0009b..a38bf8ef5798 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -117,6 +117,37 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
+#ifdef CONFIG_PROXY_EXEC
+DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
+static int __init setup_proxy_exec(char *str)
+{
+	int ret = 0;
+
+	if (!str)
+		goto out;
+
+	if (!strcmp(str, "enable")) {
+		static_branch_enable(&__sched_proxy_exec);
+		ret = 1;
+	} else if (!strcmp(str, "disable")) {
+		static_branch_disable(&__sched_proxy_exec);
+		ret = 1;
+	}
+out:
+	if (!ret)
+		pr_warn("Unable to parse proxy_exec=\n");
+
+	return ret;
+}
+#else
+static int __init setup_proxy_exec(char *str)
+{
+	pr_warn("CONFIG_PROXY_EXEC=n, so it cannot be enabled or disabled at boottime\n");
+	return 0;
+}
+#endif
+__setup("proxy_exec=", setup_proxy_exec);
+
 #ifdef CONFIG_SCHED_DEBUG
 /*
  * Debugging: various feature bits
-- 
2.42.0.869.gea05f2083d-goog

