Return-Path: <linux-kernel+bounces-35706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0CF839563
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3731C26031
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5200C12837F;
	Tue, 23 Jan 2024 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ozepGXdm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IYABCsLS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A19823D9;
	Tue, 23 Jan 2024 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028442; cv=none; b=H+jj4QmuPm/lyTHUlr1KCXTEw01gQgYO9+Mfc3nrB7IPI8J2JqtwqEZLTldgoklqqorFAqy35EQMqShlsuL4PslueYYk9KK1kwARRSoj/b73T/Ppc7GCDaib4BtWuL1m2uvHKQ5J0uqvjfbBQuhKuZbp9yxKBWAgWF6WJRSVXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028442; c=relaxed/simple;
	bh=99UGYF5IBxp9JpIFxVvetsxGYd/JCchgwfyQMLrGxD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c4UzSwpEI7C3FqpbX+ROpyvtVxq63HIg10JPqxCNV6Q5mIc3YKI/oKfozmBvbh4iLB/9eCw/5EdZ513JkBkwy0f9R27j6HA0o0z9exGrXUU88KJtD6AGmmOJtpeNHfxJLeiRRLYYz5GQ3ITUZd1XX8f1zoYlLFPeEfMaJJLjQo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ozepGXdm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IYABCsLS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706028437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khMougoG0mvpU1Mds2+gCdLAlfzbFK/BUtDBN3tuvqo=;
	b=ozepGXdmD3hMx/BF8U/4Jdt4uD6N1cdvJPbTdgsyFVq6VqguU9Seefjg2HIF06aWWXCbT0
	+USq95oKStk3bCFvnDyUGFcy2i72mTkyaGyscol9vZeEQAFjLVn3vvXCW7iIaQdFSpfPBD
	BnP8nDKBWNBp4lg3T++s07+/VkhsCfDCM+oLCTO211JEDncImFRmKNf1qrRnFghxgSon/t
	QdtNRsW+4/NvmM81NlNZlCHSj+RMqhMzu7JIO2rX0Hyr8AX7+e1Op+izfMiOgI4QcxjbHK
	vWcM2JBEOOCPnGleR7XCvZX1gF114jgScsfKua8aL2qitArsNoSyJfdVsBL4Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706028437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khMougoG0mvpU1Mds2+gCdLAlfzbFK/BUtDBN3tuvqo=;
	b=IYABCsLSREXQ5FfgJQ4fye4JG2wKe+r0VkozoE+L4pxCtwZuezSYuejwBoBbCyhIxuyyGm
	hzGgIBDrW6/4QfCA==
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Clemens Ladisch <clemens@ladisch.de>,
	linux-doc@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 5/8] jiffies: Transform comment about time_* functions into DOC block
Date: Tue, 23 Jan 2024 17:46:59 +0100
Message-Id: <20240123164702.55612-6-anna-maria@linutronix.de>
In-Reply-To: <20240123164702.55612-1-anna-maria@linutronix.de>
References: <20240123164702.55612-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This general note about time_* functions is also useful to be available in
kernel documentation. Therefore transform it into a kernel-doc DOC block
with proper formatting.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 include/linux/jiffies.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index e0ae2a43e0eb..d9f1435a5a13 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -102,12 +102,15 @@ static inline u64 get_jiffies_64(void)
 }
 #endif
 
-/*
- *	These inlines deal with timer wrapping correctly. You are
- *	strongly encouraged to use them:
- *	1. Because people otherwise forget
- *	2. Because if the timer wrap changes in future you won't have to
- *	   alter your driver code.
+/**
+ * DOC: General information about time_* inlines
+ *
+ * These inlines deal with timer wrapping correctly. You are strongly encouraged
+ * to use them:
+ *
+ * #. Because people otherwise forget
+ * #. Because if the timer wrap changes in future you won't have to alter your
+ *    driver code.
  */
 
 /**
-- 
2.39.2


