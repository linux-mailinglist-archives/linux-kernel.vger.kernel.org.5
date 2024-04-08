Return-Path: <linux-kernel+bounces-135408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 467AC89C0E6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0B31F21B5F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A778185273;
	Mon,  8 Apr 2024 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hPc84cS2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+5J4HMG8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B3C81ACC;
	Mon,  8 Apr 2024 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581849; cv=none; b=l5zASyA7khnBiJrwVmmSn6CTVrHejAkVHJWfLWjC5tsFjO8YQOaBXOzWuZmutatMpm20XcuHMkZU9vbxyzqYApQ9wsM74Lh8VkD+3auFOK9ESeefnAj1EacvNKafWVs3xy/sXBD9+VXKzC9evXcnF0TfkDPD44kdD80HLnkO/jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581849; c=relaxed/simple;
	bh=PXf7R5qAUc4cgwrk+L+Umb4OtJuYvmZxpBnvVVXpg6A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=R1ik9INE3XZtmI65X7poLJsTJBUomURgizaOjVdzMgq5JPst9N09HIQFQZ2AEmJ/dWYmz303n+4froyf/OpuPOu0xnQ99Sh0UqGl8C3BTLNjp5/trMbiOQV5bXDovjgsT+4sf6Mz0kto3Z/Lj6B913RIrqW6vPuPUHCkuZN0Y+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hPc84cS2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+5J4HMG8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 13:10:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712581846;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHsV6dV1JqFTklSy7gQssuazIuqk646bANJQNohqk0c=;
	b=hPc84cS2FN8M3g3nzbYTwn05+REUiSto4mn59pENG0B7XAn4prYQwN0X6wBfpa7Pt1/PGN
	nnNppY2XbjnEVLhCIIVmjbl7D2hg6Zknci6PQ2xQwqrLEtVgfpDyTNYFKrvt1BdxR+9zw4
	etH+xsOeYHIQWR/4+p2usGUtroQIjXpOlji53gCol5QF8EUJ8aJXVG/i8IeEOx81C9xCva
	eo4P6idbZAe81jynWtZeTdaPsMjRuh4xw4mMzGv8NAFq4q0uH4x2sk+wxYxFJHQ4+uoRnb
	JxCT3n/EWtAqKvrjcz0KYkFlv0nQkfIM3AXul+QT/LYPwLEZu65E6a7lekfBsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712581846;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHsV6dV1JqFTklSy7gQssuazIuqk646bANJQNohqk0c=;
	b=+5J4HMG8wFT28/4S1jqAmCUJ9dIQEkn4UPbO86VIxA709LPHclZlXwG4aFGsSBHcwkY4Rq
	0nWI0M/oa/O8j2CA==
From: "tip-bot2 for Jiapeng Chong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Remove unused function
Cc: Abaci Robot <abaci@linux.alibaba.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240322070441.29646-1-jiapeng.chong@linux.alibaba.com>
References: <20240322070441.29646-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258184562.10875.7996799448110945238.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     82ccdf062a64f3c4ac575c16179ce68edbbbe8e4
Gitweb:        https://git.kernel.org/tip/82ccdf062a64f3c4ac575c16179ce68edbbbe8e4
Author:        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
AuthorDate:    Fri, 22 Mar 2024 15:04:41 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 15:03:06 +02:00

hrtimer: Remove unused function

The function is defined, but not called anywhere:

  kernel/time/hrtimer.c:1880:20: warning: unused function '__hrtimer_peek_ahead_timers'.

Remove it.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240322070441.29646-1-jiapeng.chong@linux.alibaba.com
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8611
---
 kernel/time/hrtimer.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 70625df..cae9d04 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1875,25 +1875,7 @@ retry:
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

