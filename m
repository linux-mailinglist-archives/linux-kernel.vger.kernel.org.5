Return-Path: <linux-kernel+bounces-68062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D074985757F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558021F236A8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C92612E47;
	Fri, 16 Feb 2024 05:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPBUpLS4"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EE263CF
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 05:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708060205; cv=none; b=cbC/ySP2omkBS1ZV54UVblyYK/kbLJ7Z+IP7n/KPxfb7NB+xQwpNnxn26+6FWTAZshv9SYCXOqeU/S34HTfXFKdYrAdaw5XJ9vJT4XZjabK1X7Y0noxeexY1nokRKW93Z5gXDgYPA1ibul8gOhrOKnUYutu22RtHuOLJg6Ed934=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708060205; c=relaxed/simple;
	bh=iV4xyfoj4RAGaEV3TwSlOffEIYtm/b/aiUVQz4Pjzf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppDdkVKKbxTf+vWDNYUbkhgHy8QMZ4jmDgxv9T2gspY10/5SZagNUtSdnhsxtMJVRc4kuyodUBGPlvjMwmATtpLbnv851/pVeuF10JF2OshMLGnqgwPxRbic2y/JrsKRUmkmn0w3H2DgzMAKAFtzMYEhJDBTA1fW2fsZg1nvIog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPBUpLS4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d51ba18e1bso17028725ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708060203; x=1708665003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osRd6e0938TIuqccy/3nmWVE3X+VrWpnZGag3nbS18c=;
        b=hPBUpLS4cBBiTV70H8F1iCPSfqNikpM/VvHSjhNnE2a/819s4orgUQptu6iV2xCAFD
         42SIRkL4qOIykNBWzGEqnEUHaVdCUeQK8cPCyNEiaLNy2nRCLzlbEBsOBTH1ovDsKvbW
         0o6oa9SYHF78IoG2TtGe3bcIUM3zyj1Xm6wYu7/ux9EvC0Fc6HnmnkfCz9+tFtLsQCtb
         TEB9ePashq4W89zBvIXPeXI49+wQI90BrtiJRiNsu02AgUDcjNYL50dUtaBYVka/z+ZM
         asOP2D+DxkpCjZMxtk9IL3XuJz2xE2xZHkdKJ1dDzKAvrZqLCkle9abn7qooIdan+IbT
         2j+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708060203; x=1708665003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osRd6e0938TIuqccy/3nmWVE3X+VrWpnZGag3nbS18c=;
        b=WcikG8IGXnNu7kf9URKsOjrf0UnJkOHhGtrJluifsHu8o+8nN46rzOhRNtoeeWvJYx
         k8VAhcTgyk/sjMpAlAMWWX0dSc8VZgpUSKMM62xs3wQ9Pf5IRTUjrwC+jYTkF28ylcc7
         tlyDsqfmjyriyZiVqJMchi8X4gMGf85I0qwhl4/iPZiiDfP9IZV4d2SwdNvEh84SgBQ9
         2iHAGPFPgcrMkWCjmLemcDZSU/eza4qXnhLTuQdY9iV4lcB9Qy7blKhjpO1QPFBABS+j
         uz+tQRXmI6gDkin/uPlY/BHUU9liMYJ3+G0audRuKPKpRwG6eB/q9nXI4+3IsaKTqNv/
         xX6Q==
X-Gm-Message-State: AOJu0Yyt+svQ4VjGNqtOg8NbANYarC+tse2WZ8AxqiESnjKrqnI5+uK5
	6B05MnGzUIlji7AIB3Mc0MozEGGMOnWvJXgHb3O/PjCZrynOQEBW
X-Google-Smtp-Source: AGHT+IFLgPrqUhJJrliYsCvJt8xu+toWS3zAYEFkp18ojTMUN3FKRzyo8q5WPXB8jZ5pobj+7Gzimw==
X-Received: by 2002:a17:902:aa84:b0:1d9:c17b:43f3 with SMTP id d4-20020a170902aa8400b001d9c17b43f3mr3587876plr.15.1708060202909;
        Thu, 15 Feb 2024 21:10:02 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id bi11-20020a170902bf0b00b001db499c5c12sm2084701plb.143.2024.02.15.21.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 21:10:02 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 15 Feb 2024 19:10:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2 wq/for-6.9] workqueue, irq_work: Build fix for
 !CONFIG_IRQ_WORK
Message-ID: <Zc7uKXZwHdATHyMY@slm.duckdns.org>
References: <Zc0IzeM6tAvm1NTl@mtj.duckdns.org>
 <Zc65DUZKIx5IIgrX@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc65DUZKIx5IIgrX@slm.duckdns.org>

2f34d7337d98 ("workqueue: Fix queue_work_on() with BH workqueues") added
irq_work usage to workqueue; however, it turns out irq_work is actually
optional and the change breaks build on configuration which doesn't have
CONFIG_IRQ_WORK enabled.

Fix build by making workqueue use irq_work only when CONFIG_SMP and enabling
CONFIG_IRQ_WORK when CONFIG_SMP is set. It's reasonable to argue that it may
be better to just always enable it. However, this still saves a small bit of
memory for tiny UP configs and also the least amount of change, so, for now,
let's keep it conditional.

Verified to do the right thing for x86_64 allnoconfig and defconfig, and
aarch64 allnoconfig, allnoconfig + prink disable (SMP but nothing selects
IRQ_WORK) and a modified aarch64 Kconfig where !SMP and nothing selects
IRQ_WORK.

v2: `depends on SMP` leads to Kconfig warnings when CONFIG_IRQ_WORK is
    selected by something else when !CONFIG_SMP. Use `def_bool y if SMP`
    instead.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: 2f34d7337d98 ("workqueue: Fix queue_work_on() with BH workqueues")
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
---
Hello,

Unfortunately, the previous patch triggers Kconfig warnings when IRQ_WORK is
selected by something else but !CONFIG_SMP. This one seems to do the right
thing in all cases.

Naresh, Anders, can you please test it again?

Thanks.

 init/Kconfig       |  2 +-
 kernel/workqueue.c | 24 +++++++++++++++---------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 8df18f3a9748..0d21c9e0398f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -106,7 +106,7 @@ config CONSTRUCTORS
 	bool
 
 config IRQ_WORK
-	bool
+	def_bool y if SMP
 
 config BUILDTIME_TABLE_SORT
 	bool
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 04e35dbe6799..6ae441e13804 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1209,6 +1209,20 @@ static struct irq_work *bh_pool_irq_work(struct worker_pool *pool)
 	return &per_cpu(bh_pool_irq_works, pool->cpu)[high];
 }
 
+static void kick_bh_pool(struct worker_pool *pool)
+{
+#ifdef CONFIG_SMP
+	if (unlikely(pool->cpu != smp_processor_id())) {
+		irq_work_queue_on(bh_pool_irq_work(pool), pool->cpu);
+		return;
+	}
+#endif
+	if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
+		raise_softirq_irqoff(HI_SOFTIRQ);
+	else
+		raise_softirq_irqoff(TASKLET_SOFTIRQ);
+}
+
 /**
  * kick_pool - wake up an idle worker if necessary
  * @pool: pool to kick
@@ -1227,15 +1241,7 @@ static bool kick_pool(struct worker_pool *pool)
 		return false;
 
 	if (pool->flags & POOL_BH) {
-		if (likely(pool->cpu == smp_processor_id())) {
-			if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
-				raise_softirq_irqoff(HI_SOFTIRQ);
-			else
-				raise_softirq_irqoff(TASKLET_SOFTIRQ);
-		} else {
-			irq_work_queue_on(bh_pool_irq_work(pool), pool->cpu);
-		}
-
+		kick_bh_pool(pool);
 		return true;
 	}
 
-- 
2.43.2


