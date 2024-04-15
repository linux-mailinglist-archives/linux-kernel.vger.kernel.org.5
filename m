Return-Path: <linux-kernel+bounces-144989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321C78A4DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBD72848D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D945FB93;
	Mon, 15 Apr 2024 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="F5L9nSdI"
Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE79B5B693
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.104.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180587; cv=none; b=RUqDl3hfh7W/wfURiTfP/VuDVBzbI8ZjKqbwaXwG+xstphEY9eMviGbD/4sG24ev9MMnqX3p74R9gVf9s8yXd36YuPw/xmTodk2DV+wc0ypBtFNNHIBwrpe1FMI980eg1SZvirHOs+KZswUeBppYTwY5MktW7gLyGm7ksKbQRHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180587; c=relaxed/simple;
	bh=KD3fIvmfv9M2uYPx3lI8T6JcOctDUjI+X2b5m1y1/+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J+0Iz8Upavs957j1Dx5rNfh1FQ0Hk4NE1DttliJIOvCSj2wszv5yWXsI/4Cf3XP6I20ML6zzdP1ZGDwJz5ORoa5gneQdhBRVMwrI57Xt1xsUe+4f1Hil7Ktd663rgWNP5XzOkDga/xreKAyg88iMzO2nR1cwi7k5Pd+Sn7xpD4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=F5L9nSdI reason="key not found in DNS"; arc=none smtp.client-ip=23.90.104.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1713180582; x=1744716582;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KD3fIvmfv9M2uYPx3lI8T6JcOctDUjI+X2b5m1y1/+Q=;
  b=F5L9nSdI4UDoi8MtHFGLj9EIw2NOLNeQXZNo1YHpvCVJDcpbCRwib9WX
   l9D53Qny2CtisKcNSIjF4G/2KT1ZlHmmuv81bLQisMyQCFfH1A012ocM9
   ZkAAxIvDjG4MKA4v+sq+9bWkaG+33NKkcTOljxwZAlUWiTmn7L8ZHD5ZT
   I5WWpWIR2eLDuX/yYmWrUGIu5771Z70p7w7bubaJI5kFVJzXNLIvDw4za
   jwnSIprVJFlugwAh9Pq0QZx0RCOYPdm4DmrsL651vm4yjb7aq7Bi63c/H
   eNePmtHqjXEj+ri4Y7OBMorsB0CxmX10BhiXJlQmREm34fgK0CPT5lnen
   A==;
X-CSE-ConnectionGUID: yQYaK7++TO28YVyFKWEpyg==
X-CSE-MsgGUID: D1Ww7venR8ik4h6/HQ2mEA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 14:28:29 +0300
X-CSE-ConnectionGUID: qxh1RlKvQ86ZJ0WkCEy5xg==
X-CSE-MsgGUID: NT2QH6ggQpecNQa64oECaQ==
Received: from me1a10.me-corp.lan (HELO epgd022.me-corp.lan) ([10.155.95.253])
  by ces02_data.me-corp.lan with SMTP; 15 Apr 2024 14:28:27 +0300
Received: by epgd022.me-corp.lan (sSMTP sendmail emulation); Mon, 15 Apr 2024 14:28:28 +0300
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Crystal Wood <crwood@redhat.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] genirq: don't disable BH for PREEMPT_RT
Date: Mon, 15 Apr 2024 14:28:00 +0300
Message-Id: <20240415112800.314649-1-vladimir.kondratiev@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With PREEMPT_RT, both BH and irq handled in threads.
BH served by the ksoftirqd that is SCHED_OTHER, IRQ threads are
SCHED_FIFO with some priority (default is 50).

On the test platform the following observed:

- ksoftirqd thread running, servicing softirqs
- hard IRQ received by the CPU. Default handler wakes up IRQ thread
  and exits
- in the IRQ thread, force_irqthreads is defined as (true) for PREEMPT_RT
  thus handler is irq_forced_thread_fn
- before calling IRQ handler, irq_forced_thread_fn calls
  local_bh_disable(); it in turn acquires local_lock(&softirq_ctrl.lock);
- softirq_ctrl.lock still owned by the ksoftirqd thread, so
  slow path taken (rt_spin_lock_slowlock), causing context switch to the
  ksoftirqd (with properly adjusted priority) and waiting for it to
  release the lock. Then, context switched back to the IRQ thread
- as result, IRQ handler invoked with observed delay for several
  hundreds micro-seconds on 2GHz platform.

This causes failure to deliver on real-time latency requirements.

What is the reason for disabling BH in the PREEMPT_RT? Looks like
it is more reasonable to let scheduler to run threads according to
priorities; IRQ thread will preempt BHs, run to its completion.

Experiment conducted with this approach, smooth execution observed with
no spikes in the IRQ latency.

I am likely missing corner cases with this approach, so this is request
for comments. Input welcome

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 kernel/irq/manage.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index bf9ae8a8686f..d7189ac37fa8 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1191,17 +1191,19 @@ irq_forced_thread_fn(struct irq_desc *desc, struct irqaction *action)
 {
 	irqreturn_t ret;
 
-	local_bh_disable();
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		local_bh_disable();
 		local_irq_disable();
+	}
 	ret = action->thread_fn(action->irq, action->dev_id);
 	if (ret == IRQ_HANDLED)
 		atomic_inc(&desc->threads_handled);
 
 	irq_finalize_oneshot(desc, action);
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		local_irq_enable();
-	local_bh_enable();
+		local_bh_enable();
+	}
 	return ret;
 }
 
-- 
2.37.3


