Return-Path: <linux-kernel+bounces-148451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664AA8A82C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96FDB1C20DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D9113D527;
	Wed, 17 Apr 2024 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hzIdd/NN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qNQGD+LL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38E113C688;
	Wed, 17 Apr 2024 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355646; cv=none; b=u6K9TyWkLDlTMO4TPWn5of9CqjUety509ehCfAcFZ6AARwC7yWey5XClmwyRBEYfXGQQzA9kbLJ/BuQUBsqJ/rN/50Am73a/QKCFrF1UVlT/5zGWfAWuhdU0hNgsU1bqUH27VXY0fs3ZXaVdQd0J6eaVxC+7z1vM0CpmW2QsMr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355646; c=relaxed/simple;
	bh=OYTMY/y0G58ijueYFWuQUhFJhMMD6a0DuG6YK0FxP7I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P4OXzeINKaSmV1cZZhDmD1Ua8b8HFJCc6aU3PwwQNnItsaGrUnYTa0/LwP4gZHj8hK8Kuos/P59FljVfr8+XaclfmtEtuNw0bkYrQv9XU45BJpxUtxiWNtm2r40RKb1II5r+uTrHFGA5dCRk65grtQi5qKKziYduAPGu41RoScs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hzIdd/NN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qNQGD+LL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Apr 2024 12:07:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713355642;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4TAFNaU41k817YAgCc37osbOwRKzsWnk/x7ICogdIUA=;
	b=hzIdd/NNCDKUPujMpBByMJh/k7Q4EqIWF8d6uuOd/bM3gtMkl585HFgWrpy47d4vqhWNnq
	4NhGUZ8i3HuA2j3gNDE8jpL2bRREhIGVBGY9kJ2XGhItjXfVRhcGfr92o4MiEC3QgPj41i
	NiPc+fTUTEzHqCzaVhTaPN8PORg06znEBs93fYfzSC95wVXPUEZJBl6glWQ4RVsLqKEOYR
	+d3723SjQJhGQN/Wl/gNWbgnW+fQMHCAVqpgAhKmTaf3+aa47XosTkNcEyz4Od/faScCTN
	u1Fn4siKl/IgCQjnGxAV755KLqTFcD3XP/8X/6IScunoev7NcccavezgarWIRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713355642;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4TAFNaU41k817YAgCc37osbOwRKzsWnk/x7ICogdIUA=;
	b=qNQGD+LLcC/8+hqpNy6AAXEHeJJrkqvCFeSkdjSNr2SDzf+KQikLAMRcplIQKuAfgaM8dG
	7zqHCJxQJBFOp9DQ==
From: "tip-bot2 for Alexander Gordeev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] s390/vtime: Remove unused
 __ARCH_HAS_VTIME_TASK_SWITCH leftover
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cb1055852eab0ffea33ad16c92d6a825c83037c3e=2E17127?=
 =?utf-8?q?60275=2Egit=2Eagordeev=40linux=2Eibm=2Ecom=3E?=
References: =?utf-8?q?=3Cb1055852eab0ffea33ad16c92d6a825c83037c3e=2E171276?=
 =?utf-8?q?0275=2Egit=2Eagordeev=40linux=2Eibm=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171335564123.10875.11294979303431209076.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     60b8edba142e4ba3c3060431760dd803bd90ffa1
Gitweb:        https://git.kernel.org/tip/60b8edba142e4ba3c3060431760dd803bd90ffa1
Author:        Alexander Gordeev <agordeev@linux.ibm.com>
AuthorDate:    Wed, 10 Apr 2024 17:09:46 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Apr 2024 13:37:21 +02:00

s390/vtime: Remove unused __ARCH_HAS_VTIME_TASK_SWITCH leftover

__ARCH_HAS_VTIME_TASK_SWITCH macro is not used anymore.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Link: https://lore.kernel.org/r/b1055852eab0ffea33ad16c92d6a825c83037c3e.1712760275.git.agordeev@linux.ibm.com
---
 arch/s390/include/asm/vtime.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/s390/include/asm/vtime.h b/arch/s390/include/asm/vtime.h
index fe17e44..561c91c 100644
--- a/arch/s390/include/asm/vtime.h
+++ b/arch/s390/include/asm/vtime.h
@@ -2,8 +2,6 @@
 #ifndef _S390_VTIME_H
 #define _S390_VTIME_H
 
-#define __ARCH_HAS_VTIME_TASK_SWITCH
-
 static inline void update_timer_sys(void)
 {
 	S390_lowcore.system_timer += S390_lowcore.last_update_timer - S390_lowcore.exit_timer;

