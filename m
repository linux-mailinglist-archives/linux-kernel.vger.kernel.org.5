Return-Path: <linux-kernel+bounces-105787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B613987E471
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79901C20D93
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2EC23775;
	Mon, 18 Mar 2024 07:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="efyapZeT"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4322F1C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710748463; cv=none; b=T7uegf9MvbMpIZHhgskIsSqk8+ZOw3NyAjWl4EUVpTsCaeAjrqI7dqnaQbrtUR7BCUdpOsZVPLUelBd93dBqv6HpxU4gBFne10LatysF4WzkIbz4Sl6KiD4pAR4VnY00WRSqXtuNrHRXkMDEkCU8MZlsz7112VK4fm7eB0RMko8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710748463; c=relaxed/simple;
	bh=jiuhceEOsgjW1qf3tDInMXSfTqyUUlH7mBe6/q5w00Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UqMvkaSK3h/idX3ndVCqWo+QiPc+SzqeRzbY9PdslHFgWZkAOP5K4SrFGIkjUpfnUj/PpYNiylvRoJcwZnwAPo7Xjn+GLDMWCU4Wt0BG31oMgo7HMfm99Bk/E3m1vrG+/fQIv1y23HysboPPu4c6hoAAwb1cA2Cuo5ZdKTF8Yd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=efyapZeT; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b7785846e4fc11eeb8927bc1f75efef4-20240318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=s40GUT5ZuecGd7Cuw5EoS2wMEPC2EMup1dr+n16UjQA=;
	b=efyapZeTMezYjToAleSHqUnGONntmOgGxDnjUEBzVsGV0VBHae55mLkhTx1cKm6YFzrYXjr3nEwfGy1ZWmg7aXJ258ojGINHh1Zhz07kXlpiq4nR3zljZbFGp+06xARk4W9zLUX+Hgsk09MbMo4HKIaAgVOcMy7dvdUjxIv0TFU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d3757bbb-86ab-48ba-8a6e-bde00b399c1b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:31900400-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b7785846e4fc11eeb8927bc1f75efef4-20240318
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <guoyong.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1435710435; Mon, 18 Mar 2024 15:54:15 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Mar 2024 15:54:13 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Mar 2024 15:54:12 +0800
From: Guoyong Wang <guoyong.wang@mediatek.com>
To: Theodore Ts'o <tytso@mit.edu>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>, "Guoyong
 Wang" <guoyong.wang@mediatek.com>
Subject: [PATCH] random: Fix the issue of '_might_sleep' function running in an atomic contex
Date: Mon, 18 Mar 2024 15:53:27 +0800
Message-ID: <20240318075327.26318-1-guoyong.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.305300-8.000000
X-TMASE-MatchedRID: GSiycdxM5vtW/DiEtl1O86wxbZnudyr7reJWlnSW7AzFJnEpmt9OEwef
	5FoKtUGzyEeGCxgB/y0u5ed2FW2K2WA2IAXETeuKI0cHLI6lhgLt/okBLaEo+C3FY27PpHmsrW4
	1+BBqq+/5NLTowdvTKMhRl2j/G5EDdejbiw/Um0KEryjhqiyzyitovaaHxlUrXFNHTRKzg/pm+j
	6YVbX2YOmpHB3eYmnZsvQLAMZPkyUGSS/0WwytR4+YSzwl92XTu4ICdvW94WGAZpvTq6Jh4cS4G
	+2ecnOxNgHYUSdPXp2+LT/N9L0eANL8YenPOW5EPey2g5E3u1vJAXSoafphsVdwRHrgRcbqWmrY
	r8SaWTXFvFNUfOxLYhIlVYCqhV5OHxPMjOKY7A9t1O49r1VEa8RB0bsfrpPI0PU0TdJoUte6AOO
	V0y1r/Y9WMC5C2SBsqQcdrSfVFJ8mPBzXYStCYO4nGk5zzAi/lq6sb0EeGWq1Khzt1zZu8G2Ynp
	iHC6gVvqJlNl3XQXCOh+wyNBrFXDJiNuKohDcKzKSG3JdyKAPqtV2AGMNPavWdclq8lU1q
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.305300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 2290C989DD72737292ADF789F77AAC644350473F9635B32C6ACEF6B4E6F677C52000:8
X-MTK: N

'input_handle_event' runs in an atomic context
(spinlock). In rare instances, it may call
the '_might_sleep' function, which could trigger
a kernel exception.

Backtrace:
  [<ffffffd613025ba0>] die+0xa8/0x2fc
  [<ffffffd613027428>] bug_handler+0x44/0xec
  [<ffffffd613016964>] brk_handler+0x90/0x144
  [<ffffffd613041e58>] do_debug_exception+0xa0/0x148
  [<ffffffd61400c208>] el1_dbg+0x60/0x7c
  [<ffffffd61400c000>] el1h_64_sync_handler+0x38/0x90
  [<ffffffd613011294>] el1h_64_sync+0x64/0x6c
  [<ffffffd613102d88>] __might_resched+0x1fc/0x2e8
  [<ffffffd613102b54>] __might_sleep+0x44/0x7c
  [<ffffffd6130b6eac>] cpus_read_lock+0x1c/0xec
  [<ffffffd6132c2820>] static_key_enable+0x14/0x38
  [<ffffffd61400ac08>] crng_set_ready+0x14/0x28
  [<ffffffd6130df4dc>] execute_in_process_context+0xb8/0xf8
  [<ffffffd61400ab30>] _credit_init_bits+0x118/0x1dc
  [<ffffffd6138580c8>] add_timer_randomness+0x264/0x270
  [<ffffffd613857e54>] add_input_randomness+0x38/0x48
  [<ffffffd613a80f94>] input_handle_event+0x2b8/0x490
  [<ffffffd613a81310>] input_event+0x6c/0x98

Signed-off-by: Guoyong Wang <guoyong.wang@mediatek.com>
---
 drivers/char/random.c     |  2 +-
 include/linux/workqueue.h |  1 +
 kernel/workqueue.c        | 26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 456be28ba67c..00be9426a6fc 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -719,7 +719,7 @@ static void __cold _credit_init_bits(size_t bits)
 	if (orig < POOL_READY_BITS && new >= POOL_READY_BITS) {
 		crng_reseed(NULL); /* Sets crng_init to CRNG_READY under base_crng.lock. */
 		if (static_key_initialized)
-			execute_in_process_context(crng_set_ready, &set_ready);
+			execute_in_non_atomic_context(crng_set_ready, &set_ready);
 		atomic_notifier_call_chain(&random_ready_notifier, 0, NULL);
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 158784dd189a..eb17c62d23aa 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -550,6 +550,7 @@ extern void drain_workqueue(struct workqueue_struct *wq);
 extern int schedule_on_each_cpu(work_func_t func);
 
 int execute_in_process_context(work_func_t fn, struct execute_work *);
+int execute_in_non_atomic_context(work_func_t fn, struct execute_work *ew);
 
 extern bool flush_work(struct work_struct *work);
 extern bool cancel_work(struct work_struct *work);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bf2bdac46843..8f212346da7a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4449,6 +4449,32 @@ int execute_in_process_context(work_func_t fn, struct execute_work *ew)
 }
 EXPORT_SYMBOL_GPL(execute_in_process_context);
 
+/**
+ * execute_in_non_atomic_context - reliably execute the routine with user context
+ * @fn:		the function to execute
+ * @ew:		guaranteed storage for the execute work structure (must
+ *		be available when the work executes)
+ *
+ * Schedules the function for delayed execution if atomic context is available,
+ * otherwise executes the function immediately .
+ *
+ * Return:	0 - function was executed
+ *		1 - function was scheduled for execution
+ */
+int execute_in_non_atomic_context(work_func_t fn, struct execute_work *ew)
+{
+	if (!in_atomic()) {
+		fn(&ew->work);
+		return 0;
+	}
+
+	INIT_WORK(&ew->work, fn);
+	schedule_work(&ew->work);
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(execute_in_non_atomic_context);
+
 /**
  * free_workqueue_attrs - free a workqueue_attrs
  * @attrs: workqueue_attrs to free
-- 
2.18.0


