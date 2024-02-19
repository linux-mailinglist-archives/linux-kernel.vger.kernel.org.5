Return-Path: <linux-kernel+bounces-70951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D365859EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E27B6B219A2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06032210E1;
	Mon, 19 Feb 2024 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dTi12h1W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bd/xjVox"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ABD2135A;
	Mon, 19 Feb 2024 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332337; cv=none; b=rfpqotvNzrW/w6UR/OFKB7SiZkq+RXHwIP+/mF0I9jb7fAQz+wa97bXcNnb0lEojmUQef0cMQcPz6FQemgiRJJVS4kQEG5Bi5F/dnlFCzZnLOPZRbAxd5GkSlrLRJXl+N/pWnXj0JfjVhTYsXZKv/3vmm9fW1gKz2bOCdGsuk9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332337; c=relaxed/simple;
	bh=8DF2yuQdV5gqKG8rHi9GEvERAsRsOWhC9YU+4aMwJ4c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J/hQvKCIo1zUyDeyRQqTp1wIIUo4VjeaH1xjLQNLEENp1fUj8msdOPdV4eESTvz4hh2kFppaz9+3ay3rZIVuPpOZfJLVO1FSsHGPV4Dm2H6crSMvQx0ViVUDpGXzGrEPNumvpDGeuA/XAbQaQHrKXdaz9hvlr9toK+JuTHgB/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dTi12h1W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bd/xjVox; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 08:45:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708332333;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ta5lSvZpccXebEpA1KWrl8gTPGe/xHUHEGHA/2xdOZ8=;
	b=dTi12h1Wtb/RULhJ+lrrB3o2JwWQs126S4UlAuQeGPn4Rt4kDsF8V/I+3dp1OzGnRGXNSh
	gbdDvkYrcJ3Wlk/Wy8BUpf0xabQixGQ/CWJfqh4lQg5DP6YJ4hWpgQsz/2Elue2seqr4Wv
	m7omhppmFte9hzUcrsJmXwv9L7fy2gsndm+wkNLaF/nVrzN0JlrJFdiYlRv5dtlAYk1mcl
	29oB2voAoXk1YUXLve1/U1c4w1hpACBW+DqVGgR/5CFkiTPzRsoeRD0DwyZCtl1g8CmSKU
	WqqjYS68P7aANvvWuOVibXH7ecSiTE//dSzWgq0Es8Dr+SC/q9CzN36cTKDXWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708332333;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ta5lSvZpccXebEpA1KWrl8gTPGe/xHUHEGHA/2xdOZ8=;
	b=Bd/xjVoxFYb3CT7muvOs/tyauB/YMb6IBnxjiDVxoFjFcxZuohset3Upa93osyKQoUv0/7
	Cnbj8mmfxg2bjpAw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] jiffies: Transform comment about time_* functions
 into DOC block
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240123164702.55612-6-anna-maria@linutronix.de>
References: <20240123164702.55612-6-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170833233221.398.8859472545073053578.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c92a7eb6c642812fb08851e580973c3b83e0227c
Gitweb:        https://git.kernel.org/tip/c92a7eb6c642812fb08851e580973c3b83e0227c
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 23 Jan 2024 17:46:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Feb 2024 09:38:00 +01:00

jiffies: Transform comment about time_* functions into DOC block

This general note about time_* functions is also useful to be available in
kernel documentation. Therefore transform it into a kernel-doc DOC block
with proper formatting.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240123164702.55612-6-anna-maria@linutronix.de

---
 include/linux/jiffies.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index e0ae2a4..d9f1435 100644
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

