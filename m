Return-Path: <linux-kernel+bounces-65818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22DC855246
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392741F252C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B234C134738;
	Wed, 14 Feb 2024 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsk+7Pzl"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620505D493
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935953; cv=none; b=sGMgVS+bT9wBzH+dnO25XrL+PpPcr7GbJ4gquGnqnF/Xf+k1iNAZMp0/cpI+NC7iOyz+3xtwdWMPbMxU6Vq6b1ZEDD61Yyodi8GbmE2uQp0frh7L3QiapmZ18EtLp3RHh0+10mDnbX1yqcO4yczdw+UUTTJ/IBYDTbgknepzejo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935953; c=relaxed/simple;
	bh=LEvyniLwl41kozCqS40zKgWaQTuWXNnedyiB1qfHcuA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nTyVz06JP0O5bKzNwXWWq1sJdFgrxV0d5diZNB6z6BC09Dw+hhlWQPHeItD4+ctwkAZzK1pxEzhqiX0evKg7obZF++Z61zegs+27ukYy4yeGmRWyYmqsBcRXbxAuG69+dBSb2vzLe6mah/dCNuvaWGBtSwcyWoHs9QIZcK5JAKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsk+7Pzl; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e10ac45684so66367b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707935952; x=1708540752; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=aNw1b9vcWNzoQZYjOi7QKeEn/eO49qijJX1942ELf28=;
        b=jsk+7PzlqOmrsjqT2mMXDcfNXq9Qna84j+tGizeju+yxE0GdCMeQrByIm0Ofd2NWYp
         TosmPDzWCsMvFeYF69OYe1CyH0fR8fKm4rdv1ukzQW/QqlhTmxB6fsC/o7feLc7BJY3R
         nKPm8wWeFalb2FL9bpaOzO7ZGD4XBLEBh60QH+SREkXE17VrudeyPrdU2NHsL2lb05Qz
         VsvYyzyIVHUgJM4cJZUggvzeVMlBJy61ZZZqhln10lJ9LafK6q0Hb/Q8G6cDLwMkMNeS
         ir3df2kUXSLpopR8sMOragY1CxIoSuOPQSxqGFG2kC+r3NWv3yfFUj0TKLxuMfb+Kemx
         gtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707935952; x=1708540752;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNw1b9vcWNzoQZYjOi7QKeEn/eO49qijJX1942ELf28=;
        b=WAX+/PBn/u/5YF0UzZj4IrmkNWPpQAyiTQeC2FRfKyEGm8Ta7ow+if/lUzugKatU7y
         LxpQgeYvVLOZI8GIIHR2ak9LgBHKYgsk+pcAydRXE+andSO0ubpcLvkctgQR8yvHxuk2
         8QJeAMKHPFYLni8lU1Sedb8Xb5qkQF9WQ1UbWqdEtUuiCJ7BUKKmQYsqE8jTLpQ6/+Cr
         eDBS8+o+AEdDU1a0GsZMxJwfEwtRV6tvrjYfraWSFPcbeTS/VDV/kJkRcD9fXICKG1ew
         DBuj9hPZPuWKSgzkdBB4U86dK5Xqa57pO+j2CLHzsQxM2HhqJ4X8z6nveeKLA3aG8Ifv
         OOIw==
X-Gm-Message-State: AOJu0YzVJbwurQehTr088Z19omHUPu5hm/fKrQkBd7sojIi7CQNOjAWi
	TTtRpK/ZkNIHUMraGquCUSPxX9LF6DN9zSMZK+bc1co+qcCxOA+i
X-Google-Smtp-Source: AGHT+IFE788YNQK9o0pTNuUv6eJt6ByDNTXpMDgi5rZjb9umpPuNqObV5rhVtKHHzg2l72P773imBQ==
X-Received: by 2002:a05:6a20:c706:b0:19e:9885:1077 with SMTP id hi6-20020a056a20c70600b0019e98851077mr3889161pzb.43.1707935951530;
        Wed, 14 Feb 2024 10:39:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRjMuYJZYwtQjkYj+5qYbhBd+ejYGUCe39lWaltMmeAtxfppIRs7ERis//Wk29MUd36g1IIWLZquBMfoZgMaYEDZ/CIrUzucZU63Y/c1sKPDiSkH6qXl8kVRLeJD91Zg==
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id a21-20020a056a000c9500b006e04d2be954sm9716495pfv.187.2024.02.14.10.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 10:39:11 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 14 Feb 2024 08:39:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: [PATCH wq/for-6.9] workqueue: Fix queue_work_on() with BH workqueues
Message-ID: <Zc0IzeM6tAvm1NTl@mtj.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From 2f34d7337d98f3eae7bd3d1270efaf9d8a17cfc6 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Wed, 14 Feb 2024 08:33:55 -1000

When queue_work_on() is used to queue a BH work item on a remote CPU, the
work item is queued on that CPU but kick_pool() raises softirq on the local
CPU. This leads to stalls as the work item won't be executed until something
else on the remote CPU schedules a BH work item or tasklet locally.

Fix it by bouncing raising softirq to the target CPU using per-cpu irq_work.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 4cb1ef64609f ("workqueue: Implement BH workqueues to eventually replace tasklets")
---
Oops, I just found out that I was raising softirq on the wrong CPU when BH
work items are queued on remote CPUs. This fixes it. Applied to wq/for-6.9.

Thanks.

 kernel/workqueue.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4950bfc2cdcc..04e35dbe6799 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -54,6 +54,7 @@
 #include <linux/nmi.h>
 #include <linux/kvm_para.h>
 #include <linux/delay.h>
+#include <linux/irq_work.h>
 
 #include "workqueue_internal.h"
 
@@ -457,6 +458,10 @@ static bool wq_debug_force_rr_cpu = false;
 #endif
 module_param_named(debug_force_rr_cpu, wq_debug_force_rr_cpu, bool, 0644);
 
+/* to raise softirq for the BH worker pools on other CPUs */
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct irq_work [NR_STD_WORKER_POOLS],
+				     bh_pool_irq_works);
+
 /* the BH worker pools */
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct worker_pool [NR_STD_WORKER_POOLS],
 				     bh_worker_pools);
@@ -1197,6 +1202,13 @@ static bool assign_work(struct work_struct *work, struct worker *worker,
 	return true;
 }
 
+static struct irq_work *bh_pool_irq_work(struct worker_pool *pool)
+{
+	int high = pool->attrs->nice == HIGHPRI_NICE_LEVEL ? 1 : 0;
+
+	return &per_cpu(bh_pool_irq_works, pool->cpu)[high];
+}
+
 /**
  * kick_pool - wake up an idle worker if necessary
  * @pool: pool to kick
@@ -1215,10 +1227,15 @@ static bool kick_pool(struct worker_pool *pool)
 		return false;
 
 	if (pool->flags & POOL_BH) {
-		if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
-			raise_softirq_irqoff(HI_SOFTIRQ);
-		else
-			raise_softirq_irqoff(TASKLET_SOFTIRQ);
+		if (likely(pool->cpu == smp_processor_id())) {
+			if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
+				raise_softirq_irqoff(HI_SOFTIRQ);
+			else
+				raise_softirq_irqoff(TASKLET_SOFTIRQ);
+		} else {
+			irq_work_queue_on(bh_pool_irq_work(pool), pool->cpu);
+		}
+
 		return true;
 	}
 
@@ -7367,6 +7384,16 @@ static inline void wq_watchdog_init(void) { }
 
 #endif	/* CONFIG_WQ_WATCHDOG */
 
+static void bh_pool_kick_normal(struct irq_work *irq_work)
+{
+	raise_softirq_irqoff(TASKLET_SOFTIRQ);
+}
+
+static void bh_pool_kick_highpri(struct irq_work *irq_work)
+{
+	raise_softirq_irqoff(HI_SOFTIRQ);
+}
+
 static void __init restrict_unbound_cpumask(const char *name, const struct cpumask *mask)
 {
 	if (!cpumask_intersects(wq_unbound_cpumask, mask)) {
@@ -7408,6 +7435,8 @@ void __init workqueue_init_early(void)
 {
 	struct wq_pod_type *pt = &wq_pod_types[WQ_AFFN_SYSTEM];
 	int std_nice[NR_STD_WORKER_POOLS] = { 0, HIGHPRI_NICE_LEVEL };
+	void (*irq_work_fns[2])(struct irq_work *) = { bh_pool_kick_normal,
+						       bh_pool_kick_highpri };
 	int i, cpu;
 
 	BUILD_BUG_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
@@ -7455,8 +7484,10 @@ void __init workqueue_init_early(void)
 
 		i = 0;
 		for_each_bh_worker_pool(pool, cpu) {
-			init_cpu_worker_pool(pool, cpu, std_nice[i++]);
+			init_cpu_worker_pool(pool, cpu, std_nice[i]);
 			pool->flags |= POOL_BH;
+			init_irq_work(bh_pool_irq_work(pool), irq_work_fns[i]);
+			i++;
 		}
 
 		i = 0;
-- 
2.43.0


