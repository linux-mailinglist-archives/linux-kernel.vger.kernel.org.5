Return-Path: <linux-kernel+bounces-164006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D338B7710
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A341F220D5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA8A175550;
	Tue, 30 Apr 2024 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t7xMqOa/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nLf5OIOZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D68172769;
	Tue, 30 Apr 2024 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483727; cv=none; b=hjqi809OpmVTjBkz3QxJDjpq5eHFdzIfWHlk5oXDdrINa9HHwMymGWuzzlr6T9ENw3WgIn48UpCOaLEW6J5hXCQ5rh6eydbsc+L2qJh+czBnUPJgYnbxLvCldNphfwB0+rhwggVGsuBLDFJxLi8duNmun6gOk3RT0MvxzfAkvIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483727; c=relaxed/simple;
	bh=/aljL3+AtwmpxpEZSh5KoiMlKYLkCtK1Se8fSfzjaZE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AMV1cwLofgLG9kf4TFtHbDkte8aoFhWYKV2fMHaKNNPvPmgZtShqeMPbl+vEBHCi0zSxiWyP2iNdhFLe7EUS/UnX4eIHaa+yAJZawnaSPxZw0l4W1WN0puwuIrsB1PwJYYAiyeu/LG4pnsVd9M7Hw9dqRVp4MoZvBBnzdc4713I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t7xMqOa/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nLf5OIOZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Apr 2024 13:28:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714483722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VH0v4JhvxE7rVEa7z71kqkDFLVc/B4oco1ir7/ngxVs=;
	b=t7xMqOa/crKzsfVG92fgn5yn8r+4ogYUn66ffaxL+2gUJfT2Eq+VpylOqo0iAKmith5QYp
	gSvRmrP5D7D+10p9vuaQ5m4adV669me1RycNAzLV75WSM7xVHUFDDC5hSKuh+jTo/JOg4c
	Eft2cFk2GfesKVRwL9BY3HYvaP0u92wGmHTN5OTB9QGLiyLtHDyi3BQ1AZukjJ8Pe1VZ3B
	lx6cUAHXQ9MWFGM/CblVx/3atMinMSIlOhIWCi0wpXBkIVilLOBvpDlSdavG0Syqt8ppfQ
	xDblBFcClKIgfgTxy3yLSLRAZ96RddjhDKTLyto94Ut9hJcjNUEqdijTCOO43Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714483722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VH0v4JhvxE7rVEa7z71kqkDFLVc/B4oco1ir7/ngxVs=;
	b=nLf5OIOZOa+ur56Zym/xnljgmGxUHKFEqBlZHUjptSyqfxhy7bkbUPKDJhhcWNALeTfPen
	VVzwtGXY6/AXiCCg==
From: "tip-bot2 for Jacob Pan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/irq] x86/irq: Factor out handler invocation from common_interrupt()
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240423174114.526704-8-jacob.jun.pan@linux.intel.com>
References: <20240423174114.526704-8-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171448372181.10875.14546521952533857737.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     6087c7f36ab293a06bc0bcf3857ed4d7eb1f9905
Gitweb:        https://git.kernel.org/tip/6087c7f36ab293a06bc0bcf3857ed4d7eb1f9905
Author:        Jacob Pan <jacob.jun.pan@linux.intel.com>
AuthorDate:    Tue, 23 Apr 2024 10:41:09 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Apr 2024 00:54:42 +02:00

x86/irq: Factor out handler invocation from common_interrupt()

Prepare for calling external interrupt handlers directly from the posted
MSI demultiplexing loop. Extract the common code from common_interrupt() to
avoid code duplication.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240423174114.526704-8-jacob.jun.pan@linux.intel.com

---
 arch/x86/kernel/irq.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index dbb3a19..d652b04 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -242,18 +242,10 @@ static __always_inline void handle_irq(struct irq_desc *desc,
 		__handle_irq(desc, regs);
 }
 
-/*
- * common_interrupt() handles all normal device IRQ's (the special SMP
- * cross-CPU interrupts have their own entry points).
- */
-DEFINE_IDTENTRY_IRQ(common_interrupt)
+static __always_inline void call_irq_handler(int vector, struct pt_regs *regs)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
 	struct irq_desc *desc;
 
-	/* entry code tells RCU that we're not quiescent.  Check it. */
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
-
 	desc = __this_cpu_read(vector_irq[vector]);
 	if (likely(!IS_ERR_OR_NULL(desc))) {
 		handle_irq(desc, regs);
@@ -268,7 +260,20 @@ DEFINE_IDTENTRY_IRQ(common_interrupt)
 			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
 		}
 	}
+}
+
+/*
+ * common_interrupt() handles all normal device IRQ's (the special SMP
+ * cross-CPU interrupts have their own entry points).
+ */
+DEFINE_IDTENTRY_IRQ(common_interrupt)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	/* entry code tells RCU that we're not quiescent.  Check it. */
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
 
+	call_irq_handler(vector, regs);
 	set_irq_regs(old_regs);
 }
 

