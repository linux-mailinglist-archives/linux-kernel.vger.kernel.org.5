Return-Path: <linux-kernel+bounces-134283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E6B89AFEA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B04F2835C6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1ED2D627;
	Sun,  7 Apr 2024 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImjrK7vQ"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B5717577;
	Sun,  7 Apr 2024 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480639; cv=none; b=Vb9Mr5iVQZhmAW5gPQzcd2l8nySg1DlxiA6YYNne7DJVeBZNObcCcJ5w5DN5CnavQ4ZgVOmYW3UmOGFfKdPkDJ6VXWJTQOD8Taww2+IEuIbdCOmJNAuk3ymhwpDkMmNRDPkxcWq8JrgzcmmImDsi+x/72MSXWxs5yAk4tBo/C/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480639; c=relaxed/simple;
	bh=WZdyr+NknpomhAuRPc/9gTXcGeciCnFG1T1UfMulHtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EjTrCYLaRPpyjMOIQP+aA9i9AmyuI91mmwAEUa4ZU738RC/uaJIcdgLQKyA8CvUaESKtY7rK3oSVqMRIIPUxHp/4BYx6ixkFSXW05TEyHT94tbJelFzVT4N8A6lYrWUzWqIn7Bmy63IbwncOeNJcdRD8bKz0ddg8EM11hjM4J+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImjrK7vQ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed2dbf3c92so10756b3a.2;
        Sun, 07 Apr 2024 02:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712480637; x=1713085437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpTyCyqlk6BGMCLifNqvgRTCltbDUUo/xKTC4G72UYQ=;
        b=ImjrK7vQ3SpazvjiazZjJRRR8QJGBogDhVeLV9OQeFoVn9OasdnrdXUXiInFZOljk4
         UqZ4yt4gbev8jAjk4lnOg+S6asstT1zVdAoq9RgSTfgbHTCKiQ/D8JkADyhHXFMRcQDU
         AGKNMyeKmCupZxANYFv272VUFccusZlgeV7UwF8BqzxZ0swq+EpIawZXe/vIfeDExfSy
         hPXSRUs4bWeh9ykPjdteY24+0rlIMuhHic0JTGSBIFoQ4m+FCEgB8AXlJdGfvALWa1f8
         A5VQagrCH+rPfGm9XLgFZk2UPSO/QgI18mafYq7uBqKQGOFTA12w/I9/KDYO81lTv80D
         jkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712480637; x=1713085437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpTyCyqlk6BGMCLifNqvgRTCltbDUUo/xKTC4G72UYQ=;
        b=Aa4N5fv3wb1cDfObTghe/mtIEtISN5O+DVHxsftPitI3VCv47g1jgXpmmlSbJ/0a/F
         9Rh5IGxt+IC5svdWnQJy8Qsw0wIl9cRM4i+XCGQjYVXZG1kn6THMQQgG8kl1zJhQg35W
         P0rghSBz1YsNUGXs2H2k+iHgbQ2fyAnY3Ook0WUSgLWOP4scrqFxWuDZlKUqg68/4ZYD
         SQLCBPOAnOQSF75wgSVTPMmAuefK0JMW7dC4Z3wwiv0FVutB9EGEeQzYnzRabJ1baDIU
         QfGVDoS3dgimrQTLuJ6NXs7LahgeRsLlprFDiaieubvldEZVy0/8nDpqzQINxVe1Tpxv
         NZRA==
X-Gm-Message-State: AOJu0YzCbkcDlBf1ZobgZL67MNN9x5DoyrxxmMdFvifBpXep6Xv2trbe
	a33jXybuzXj+Wqq7WQdo6jkWQ5rrZgXYu+rqnPvxg3iVBlMQZAzvSUzdgM80
X-Google-Smtp-Source: AGHT+IGt7lhWPbhDk/feHJIC0p6YENAzxvvr8u7QkT8swnrmIKOUIBIf8sPv6ly2Voskt8dfuV6jvg==
X-Received: by 2002:a05:6a20:ce4b:b0:1a1:8312:6dfb with SMTP id id11-20020a056a20ce4b00b001a183126dfbmr6281164pzb.58.1712480637225;
        Sun, 07 Apr 2024 02:03:57 -0700 (PDT)
Received: from localhost ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id s35-20020a17090a2f2600b0029baf24ee51sm6648516pjd.48.2024.04.07.02.03.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2024 02:03:56 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	x86@kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH V2 07/11] sched/core: Add rcu_preempt_switch()
Date: Sun,  7 Apr 2024 17:05:54 +0800
Message-Id: <20240407090558.3395-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240407090558.3395-1-jiangshanlai@gmail.com>
References: <20240407090558.3395-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

When the per-cpu rcu_preempt_count is used, it has to be switched too
on context-switching.  And the instructions to switch the per-cpu
rcu_preempt_count are few, so it is inlined to avoid the overhead
in the scheduler.

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/rcu/rcu.h    | 5 +++++
 kernel/sched/core.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index b17b2ed657fc..ea5ae957c687 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -668,4 +668,9 @@ int rcu_stall_notifier_call_chain(unsigned long val, void *v);
 static inline int rcu_stall_notifier_call_chain(unsigned long val, void *v) { return NOTIFY_DONE; }
 #endif // #else // #if defined(CONFIG_RCU_STALL_COMMON) && defined(CONFIG_RCU_CPU_STALL_NOTIFIER)
 
+static inline void
+rcu_preempt_switch(struct task_struct *prev, struct task_struct *next)
+{
+}
+
 #endif /* __KERNEL_RCU_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7019a40457a6..1d9e3c51c913 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -95,6 +95,7 @@
 #include "../workqueue_internal.h"
 #include "../../io_uring/io-wq.h"
 #include "../smpboot.h"
+#include "../rcu/rcu.h"
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(ipi_send_cpu);
 EXPORT_TRACEPOINT_SYMBOL_GPL(ipi_send_cpumask);
@@ -6737,6 +6738,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		 */
 		++*switch_count;
 
+		rcu_preempt_switch(prev, next);
 		migrate_disable_switch(rq, prev);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
-- 
2.19.1.6.gb485710b


