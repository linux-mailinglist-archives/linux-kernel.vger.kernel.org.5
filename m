Return-Path: <linux-kernel+bounces-86831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2A386CB65
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0CDD1F25043
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027541361B3;
	Thu, 29 Feb 2024 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HW/R8PJP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vs+Vo4oz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF9012E1E3
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216623; cv=none; b=sYLMlEdSjLFVa+dY3XFnHEAYvAYPHdjOA8WSDAaOiF4oL+8M3KkmmWVPpMqs1W8qgHkQ09V4TWB9KgWBEQgsmCKCIMsDbsNzwKkvAJCQndwwEEAi11/Qom+x3AHMqDhjCUjbvNHciBWPHCn6M9lrBPkvSCc5w+dVtcQficvCtyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216623; c=relaxed/simple;
	bh=oeg0kEbXFXlw0/cW4ak9QngSFlXFHmiohtL35YQM4Yc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=VZrqUhDS5mu7TnuNX8qaLV5i0HHLgmLTKpr/ghmZi87Xs1wvZSVb7OdDATEQ6MIgMWG38mNfAP/7AsUgQz4Nd1ONXbD+8IKYn0trH6yqwsbacwSQNLfAuxbmyugYHH08xc4yDf6zVlv50nApEhQUng9fstLr13mno7QsQTRSrfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HW/R8PJP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vs+Vo4oz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240229142248.392017685@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709216619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Atj5tI/wQAeX3+mHod6Chan4BMI8xFQMxbYKR6KaLnk=;
	b=HW/R8PJPEVN3RwQ0leIB6iAt07gJng02l9rCWeR4jo39BtXeLQQ8KJGZeGICXLTTUJjHCY
	vvP0kE4z+DQ97CpvguN7nva0qiYDTRaOgWmPhifXtdgZKrB7rs5DbcqRldSBPHKupHupOc
	bSIon7eodjLO2ddH/L5CMZHn7fTpBZ/qAcdb8KWlqEYBVT4vxJCOZsA7cTVgpL3T9QvLHu
	v+L6RKc45ocjTnaK8Ff39+IX7T4L886KmsR+59DP9+3hqM0ztj20vzp4hTj4mC8EoAgZU+
	/Hx6LG838jpgefRWXCX73i4HPC+qfz3ZBNn2HNlukCyZxwHSvq1dqqI8YnBUAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709216619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Atj5tI/wQAeX3+mHod6Chan4BMI8xFQMxbYKR6KaLnk=;
	b=vs+Vo4ozht/yHfoiPScLoNFWqBLtKWWIF8TccoZWL4gz0F60YU727MAndiTxw5BdRHtdWN
	BKG+JtB5jP17JXAw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@kernel.org>
Subject: [patch 3/6] x86/idle: Clean up idle selection
References: <20240229141407.283316443@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Feb 2024 15:23:38 +0100 (CET)

Clean up the code to make it readable. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/process.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -910,11 +910,13 @@ static __cpuidle void mwait_idle(void)
 
 void select_idle_routine(const struct cpuinfo_x86 *c)
 {
-#ifdef CONFIG_SMP
-	if (boot_option_idle_override == IDLE_POLL && smp_num_siblings > 1)
-		pr_warn_once("WARNING: polling idle and HT enabled, performance may degrade\n");
-#endif
-	if (x86_idle_set() || boot_option_idle_override == IDLE_POLL)
+	if (boot_option_idle_override == IDLE_POLL) {
+		if (IS_ENABLED(CONFIG_SMP) && smp_num_siblings > 1)
+			pr_warn_once("WARNING: polling idle and HT enabled, performance may degrade\n");
+		return;
+	}
+
+	if (x86_idle_set())
 		return;
 
 	if (prefer_mwait_c1_over_halt(c)) {


