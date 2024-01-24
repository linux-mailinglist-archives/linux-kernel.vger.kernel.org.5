Return-Path: <linux-kernel+bounces-37519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D1883B13A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC17284B72
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F35E131E2D;
	Wed, 24 Jan 2024 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HKO0B8iw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mtoGkN7j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38CB131738;
	Wed, 24 Jan 2024 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121324; cv=none; b=ZWCUwTyAkWNRDW4wn7dnuRQoSGtnIURMrBBO5umzZDEepuNUxplCrf+kJrbdJILUiRO21eIjb+S+w8svjOodmgwQ/zp2e4GWeYfmE7BdbaeGr3vucH6dUtl2Q9T1Ti3jkZO+HmRKV664VkvUGG4pAgFucVRf/UANjkC2OPhSzzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121324; c=relaxed/simple;
	bh=3znGueINhDGtninJLocJajMddY+8bT4aIHimGYE7BXg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZKWB4L53UKdAbie5rvSAf3t1dt14MiA2YDMOVsmB4N4EQtyhjGrEtGZHG4TomP5mdT/01Hd936Oe4o4pS0bwxn1ZFyW6v4aM6bicVlxej0By55Byfqno8KO4noMdy8jlKcRZvPTVGYxC2xVuuNz4C2VgZz8Xci5FQEWBAw59ym0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HKO0B8iw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mtoGkN7j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Jan 2024 18:35:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706121321;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNuZfFjuyqt3VbvDUPA9ESPdljS/Vpfzb8Z3bR2hnks=;
	b=HKO0B8iwFb4XPUawFws7sbvBgNbw7yMJiISxM7XAd0DGnkZ9dRp0XhKb0JmWBantMq3UMI
	Ksho8id4REa9A1pKNynC1eVD+CwrKvJICGMa9Mktn7rB6oGnyruu0iySiZX3mMY+dgIQPg
	Q3wsiRoQhNEVw1ToRjC+3qOGkd82C7OCjDzgwK1OxHtDGDXTCGUdQo94h1Mx/NAGP58GLe
	0TBSunwj6TPp2GIvX5t+1PT9glWAphDIwS2VPDHqzkbJLwUdunKN6CfGlDsxCRBz0RWy2r
	oV6g2pdfusf21Ar+buCfhmhIaSwlksCxL0IRhdQKr61yp9NIRx1qBWrsqK3ZQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706121321;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNuZfFjuyqt3VbvDUPA9ESPdljS/Vpfzb8Z3bR2hnks=;
	b=mtoGkN7jt8bkooZijYruqPOFV0oB507jc4BBKocyYkEpC09hVEdg9wA0b6UAmsg5en/wG2
	B+Aq+ik80pz9EHDQ==
From: "tip-bot2 for Dawei Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/gic-v3: Use readl_relaxed_poll_timeout_atomic()
Cc: Dawei Li <dawei.li@shingroup.cn>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240122085716.2999875-2-dawei.li@shingroup.cn>
References: <20240122085716.2999875-2-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170612132033.398.7730296700030869090.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a0c446dc4d9365a24d81f2ee024bdde46e40365f
Gitweb:        https://git.kernel.org/tip/a0c446dc4d9365a24d81f2ee024bdde46e40365f
Author:        Dawei Li <dawei.li@shingroup.cn>
AuthorDate:    Mon, 22 Jan 2024 16:57:12 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 Jan 2024 16:02:48 +01:00

irqchip/gic-v3: Use readl_relaxed_poll_timeout_atomic()

Replace the open coded register polling loop with
readl_relaxed_poll_timeout_atomic() which provides the same functionality.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240122085716.2999875-2-dawei.li@shingroup.cn

---
 drivers/irqchip/irq-gic-v3.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 98b0329..65cbf37 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -19,6 +19,7 @@
 #include <linux/percpu.h>
 #include <linux/refcount.h>
 #include <linux/slab.h>
+#include <linux/iopoll.h>
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-common.h>
@@ -251,17 +252,13 @@ static inline void __iomem *gic_dist_base(struct irq_data *d)
 
 static void gic_do_wait_for_rwp(void __iomem *base, u32 bit)
 {
-	u32 count = 1000000;	/* 1s! */
+	u32 val;
+	int ret;
 
-	while (readl_relaxed(base + GICD_CTLR) & bit) {
-		count--;
-		if (!count) {
-			pr_err_ratelimited("RWP timeout, gone fishing\n");
-			return;
-		}
-		cpu_relax();
-		udelay(1);
-	}
+	ret = readl_relaxed_poll_timeout_atomic(base + GICD_CTLR, val, !(val & bit),
+						1, USEC_PER_SEC);
+	if (ret == -ETIMEDOUT)
+		pr_err_ratelimited("RWP timeout, gone fishing\n");
 }
 
 /* Wait for completion of a distributor change */
@@ -279,8 +276,8 @@ static void gic_redist_wait_for_rwp(void)
 static void gic_enable_redist(bool enable)
 {
 	void __iomem *rbase;
-	u32 count = 1000000;	/* 1s! */
 	u32 val;
+	int ret;
 
 	if (gic_data.flags & FLAGS_WORKAROUND_GICR_WAKER_MSM8996)
 		return;
@@ -301,16 +298,13 @@ static void gic_enable_redist(bool enable)
 			return;	/* No PM support in this redistributor */
 	}
 
-	while (--count) {
-		val = readl_relaxed(rbase + GICR_WAKER);
-		if (enable ^ (bool)(val & GICR_WAKER_ChildrenAsleep))
-			break;
-		cpu_relax();
-		udelay(1);
-	}
-	if (!count)
+	ret = readl_relaxed_poll_timeout_atomic(rbase + GICR_WAKER, val,
+						enable ^ (bool)(val & GICR_WAKER_ChildrenAsleep),
+						1, USEC_PER_SEC);
+	if (ret == -ETIMEDOUT) {
 		pr_err_ratelimited("redistributor failed to %s...\n",
 				   enable ? "wakeup" : "sleep");
+	}
 }
 
 /*

