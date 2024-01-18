Return-Path: <linux-kernel+bounces-30087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9AA8318FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86C21F27455
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8755724B3A;
	Thu, 18 Jan 2024 12:15:47 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A51524208
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705580147; cv=none; b=hrlwzYOEin7oE7WDFTxi97Ev4cTJb+4uRpfjChN80Nsw2chjgpz3HU7d2SbCXWICdKUAX/+nWlgWqdCYNBniCM1Oxl8FlhYx5uUuXAEi4bpRqJmiXGuFyhB+OUulwYDkRBj2M74IhBLBUCjwyegLQDA20IHxMPCyxr7MrHEmSxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705580147; c=relaxed/simple;
	bh=XReaYeH4oa5Yd0af0EK3ve6Wbk3NV4Ikk1OxA1yci94=;
	h=Received:Received:Received:From:To:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo; b=kD8c+gpSXS7bafkGKJfpEUT/PmStYfyACwjAlvqiOvEQFTBN1NYZKw7nfvsX9fSfDvZismdtOuAo1ZQPXLJPtcIk3WIMZyi54cN0LwaJkdy+2umy1d3iGJ7UYQzPxvHF/L1wyjWhCCGj04Ld0eXREoXsYBSylzIGjOEWfdd76cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TG1sr6gJBz4f3mHh
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 20:15:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 15D6B1A016E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 20:15:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgAnSQxlFqllWvbnBA--.43072S2;
	Thu, 18 Jan 2024 20:15:34 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	jack@suse.cz,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] flex_proportions: remove unused fprop_local_single
Date: Fri, 19 Jan 2024 04:13:21 +0800
Message-Id: <20240118201321.759174-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnSQxlFqllWvbnBA--.43072S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF47CryrKFyUXry7ArWUJwb_yoWrGFy7pF
	nxK3yYgr4xZa18Ww4kA3ySywn7t348Jr18Ja47Cw4kCwsFyw1vqas7KF4rZa4Yk34rZrnY
	gFn8KFn8WFZ8AF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_
	Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r
	xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
	0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
	80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
	IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j-6pPUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

The single variant of flex_proportions is not used. Simply remove it.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 include/linux/flex_proportions.h | 32 -------------
 lib/flex_proportions.c           | 77 --------------------------------
 2 files changed, 109 deletions(-)

diff --git a/include/linux/flex_proportions.h b/include/linux/flex_proportions.h
index 3e378b1fb0bc..e9a72fd0bfe7 100644
--- a/include/linux/flex_proportions.h
+++ b/include/linux/flex_proportions.h
@@ -38,38 +38,6 @@ int fprop_global_init(struct fprop_global *p, gfp_t gfp);
 void fprop_global_destroy(struct fprop_global *p);
 bool fprop_new_period(struct fprop_global *p, int periods);
 
-/*
- *  ---- SINGLE ----
- */
-struct fprop_local_single {
-	/* the local events counter */
-	unsigned long events;
-	/* Period in which we last updated events */
-	unsigned int period;
-	raw_spinlock_t lock;	/* Protect period and numerator */
-};
-
-#define INIT_FPROP_LOCAL_SINGLE(name)			\
-{	.lock = __RAW_SPIN_LOCK_UNLOCKED(name.lock),	\
-}
-
-int fprop_local_init_single(struct fprop_local_single *pl);
-void fprop_local_destroy_single(struct fprop_local_single *pl);
-void __fprop_inc_single(struct fprop_global *p, struct fprop_local_single *pl);
-void fprop_fraction_single(struct fprop_global *p,
-	struct fprop_local_single *pl, unsigned long *numerator,
-	unsigned long *denominator);
-
-static inline
-void fprop_inc_single(struct fprop_global *p, struct fprop_local_single *pl)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__fprop_inc_single(p, pl);
-	local_irq_restore(flags);
-}
-
 /*
  * ---- PERCPU ----
  */
diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
index 83332fefa6f4..84ecccddc771 100644
--- a/lib/flex_proportions.c
+++ b/lib/flex_proportions.c
@@ -83,83 +83,6 @@ bool fprop_new_period(struct fprop_global *p, int periods)
 	return true;
 }
 
-/*
- * ---- SINGLE ----
- */
-
-int fprop_local_init_single(struct fprop_local_single *pl)
-{
-	pl->events = 0;
-	pl->period = 0;
-	raw_spin_lock_init(&pl->lock);
-	return 0;
-}
-
-void fprop_local_destroy_single(struct fprop_local_single *pl)
-{
-}
-
-static void fprop_reflect_period_single(struct fprop_global *p,
-					struct fprop_local_single *pl)
-{
-	unsigned int period = p->period;
-	unsigned long flags;
-
-	/* Fast path - period didn't change */
-	if (pl->period == period)
-		return;
-	raw_spin_lock_irqsave(&pl->lock, flags);
-	/* Someone updated pl->period while we were spinning? */
-	if (pl->period >= period) {
-		raw_spin_unlock_irqrestore(&pl->lock, flags);
-		return;
-	}
-	/* Aging zeroed our fraction? */
-	if (period - pl->period < BITS_PER_LONG)
-		pl->events >>= period - pl->period;
-	else
-		pl->events = 0;
-	pl->period = period;
-	raw_spin_unlock_irqrestore(&pl->lock, flags);
-}
-
-/* Event of type pl happened */
-void __fprop_inc_single(struct fprop_global *p, struct fprop_local_single *pl)
-{
-	fprop_reflect_period_single(p, pl);
-	pl->events++;
-	percpu_counter_add(&p->events, 1);
-}
-
-/* Return fraction of events of type pl */
-void fprop_fraction_single(struct fprop_global *p,
-			   struct fprop_local_single *pl,
-			   unsigned long *numerator, unsigned long *denominator)
-{
-	unsigned int seq;
-	s64 num, den;
-
-	do {
-		seq = read_seqcount_begin(&p->sequence);
-		fprop_reflect_period_single(p, pl);
-		num = pl->events;
-		den = percpu_counter_read_positive(&p->events);
-	} while (read_seqcount_retry(&p->sequence, seq));
-
-	/*
-	 * Make fraction <= 1 and denominator > 0 even in presence of percpu
-	 * counter errors
-	 */
-	if (den <= num) {
-		if (num)
-			den = num;
-		else
-			den = 1;
-	}
-	*denominator = den;
-	*numerator = num;
-}
-
 /*
  * ---- PERCPU ----
  */
-- 
2.30.0


