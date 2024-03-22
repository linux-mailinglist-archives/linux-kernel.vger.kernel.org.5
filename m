Return-Path: <linux-kernel+bounces-111046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FCF886749
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278DC1C23945
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D898312E56;
	Fri, 22 Mar 2024 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="w6YVtoBB"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E091170A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711091094; cv=none; b=NKnSwmyjVyGcfF5An8fuu7cdkuKm2wDx1/YM4+RdxrM0c8oWgNbdCFkzUEkJNehbsiIIu4Wr5Ge/JqsiAhpeg0YEEU1mGCT5JsKVuHcB8ZDkr1ISB05CEalzJJc+AA4fRMqHJuBOGJRuSSpbBzfj5mC2vtgjcEOCTYYb4jOzUyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711091094; c=relaxed/simple;
	bh=eza72tNLhjUf/QBka4ZDCt2HW4/dv5SgxhZDOaQgl9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JDdGROxFPMVj/SMj7sJgYDKotaioa4V/NyFwYpdtUuOPzVda2Wy+qxcgFkyGPBO9KMMP5mlKAjmUq5wvtBa2Jwhzr07gIt5Ue8Il2X+itHSOwZoFPA3faRM8jI/7fI2bdOzm1ZBGbl8OH9KaEpea01s/f2jiOMUi4+QN7N7+Vds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=w6YVtoBB; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711091089; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=gHQPLGmFlzcvl6KThN3QzuzYTc9vixqyFqxGvDiC/nI=;
	b=w6YVtoBBfeo8OQT2r7B0Qlzd+pxD0HurkL5Jr2ggGM2wKtLdjw1XeszuwMLTONvlOWgJswomMj7is8ZLu5eIQwWVlgDAfQUJz2eFjXvGLbfDobvEWNQ05enS2/f6FTrfAjLGQTtsQvILLUjgP5PjB77my9/cFJBRx3xfJ5rTuUU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W31BjBz_1711091082;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W31BjBz_1711091082)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 15:04:49 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] hrtimer: Remove unused function
Date: Fri, 22 Mar 2024 15:04:41 +0800
Message-Id: <20240322070441.29646-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function are defined in the hrtimer.c file, but not called
elsewhere, so delete the unused function.

kernel/time/hrtimer.c:1880:20: warning: unused function '__hrtimer_peek_ahead_timers'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8611
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/time/hrtimer.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 70625dff62ce..cae9d04b5584 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1875,25 +1875,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	tick_program_event(expires_next, 1);
 	pr_warn_once("hrtimer: interrupt took %llu ns\n", ktime_to_ns(delta));
 }
-
-/* called with interrupts disabled */
-static inline void __hrtimer_peek_ahead_timers(void)
-{
-	struct tick_device *td;
-
-	if (!hrtimer_hres_active())
-		return;
-
-	td = this_cpu_ptr(&tick_cpu_device);
-	if (td && td->evtdev)
-		hrtimer_interrupt(td->evtdev);
-}
-
-#else /* CONFIG_HIGH_RES_TIMERS */
-
-static inline void __hrtimer_peek_ahead_timers(void) { }
-
-#endif	/* !CONFIG_HIGH_RES_TIMERS */
+#endif /* !CONFIG_HIGH_RES_TIMERS */
 
 /*
  * Called from run_local_timers in hardirq context every jiffy
-- 
2.20.1.7.g153144c


