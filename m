Return-Path: <linux-kernel+bounces-126531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB01893927
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77494B2140E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C79D107B2;
	Mon,  1 Apr 2024 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YaSBM0ER";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="33LvHL+c"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E462B671;
	Mon,  1 Apr 2024 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711961258; cv=none; b=N86xbvpxYTvMEO4FpV790/i6NtsKYqHoVvJdnyYu0mjNpzmlMK/3WIaE2fHDJhTkPEc81j89fKAgKpQnQAtq+S0P3sdUukJVje9E1Ud0L2c6YPRRRwWk1o3u/bXQZhHfCoyS46wzrjDS0eIw+OgzE/RUV39dDspZVNX0I4O0oNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711961258; c=relaxed/simple;
	bh=3QJiXN+S8g981brhJPz9S0dz7Cr961+cl1xWmQrsoBk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FhgRIn6oLzASWey/WPHmHFEDbbWYssI8pNH4XSz9SWnYufInot2JSgwoXJAU1vb9BgwDQ3kul/rlUZ9btz7hzaMx0YNpWiWiHjPw3nKz8OQuD+16oDvaH6E0Wt8tonTKRHCRWHvJcBjd8HKtHCRB8nXVCQGLs6wMHCGAQW9FvcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YaSBM0ER; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=33LvHL+c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Apr 2024 08:47:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711961249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tT14vYFP0qY/qgfVqmeAifMWAGxB+rk3t3spYOi3ibU=;
	b=YaSBM0ERcaJO4ahGOSU9Tv/WB1x1uLnUfY+QTdBfypX3//4FjDwDR00OFiZl1SkVI/migT
	m/sP7HRCzn4wOgnxxkE4+vxx2/IU5K3rsyC5MMzAg4BtOxx+HLYrRaDW1TB/5v1LCtMh9g
	eF7/uv7Kdrh6HAzdAGnMePOYgWBW+AfOENFjSuMUIfnFd086wrBrseqz1zwQ+Cn7y0MAUI
	qcAPFRNHNQ1n3LKyZnsA4Hn0Hf1G4WxZbbMkEXBmyXq1G+YprVl9ZBrDvWu4rZgpzgcEkJ
	W5K7OHvN4kJYMWoSqQi9LRTG2IfESYsZZ5CqOo4VoGQs5ZcHEcDqBifzuUQZgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711961249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tT14vYFP0qY/qgfVqmeAifMWAGxB+rk3t3spYOi3ibU=;
	b=33LvHL+cNPViiA/9trqnh53bA8INDTMDZYU/byKmJ7LQMgAkUNqZMyJopfWMdCBm7XEVOQ
	me1kzHcSBdT3fPDA==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] timers: Fix kernel-doc format and add Return values
Cc: Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240331172652.14086-4-rdunlap@infradead.org>
References: <20240331172652.14086-4-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171196124896.10875.16221502494016754442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     b87752ef5cc15b0bae04583d599e873d92dc0618
Gitweb:        https://git.kernel.org/tip/b87752ef5cc15b0bae04583d599e873d92dc0618
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sun, 31 Mar 2024 10:26:49 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 01 Apr 2024 10:36:35 +02:00

timers: Fix kernel-doc format and add Return values

Fix kernel-doc format and warnings:

  timer.h:26: warning: Cannot understand  * @TIMER_DEFERRABLE: A deferrable timer will work normally when the on line 26 - I thought it was a doc line
  timer.h:146: warning: No description found for return value of 'timer_pending'
  timer.h:180: warning: No description found for return value of 'del_timer_sync'
  timer.h:193: warning: No description found for return value of 'del_timer'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240331172652.14086-4-rdunlap@infradead.org
---
 include/linux/timer.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 14a633b..e67ecd1 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -22,7 +22,7 @@
 #define __TIMER_LOCKDEP_MAP_INITIALIZER(_kn)
 #endif
 
-/**
+/*
  * @TIMER_DEFERRABLE: A deferrable timer will work normally when the
  * system is busy, but will not cause a CPU to come out of idle just
  * to service it; instead, the timer will be serviced when the CPU
@@ -140,7 +140,7 @@ static inline void destroy_timer_on_stack(struct timer_list *timer) { }
  * or not. Callers must ensure serialization wrt. other operations done
  * to this timer, eg. interrupt contexts, or other CPUs on SMP.
  *
- * return value: 1 if the timer is pending, 0 if not.
+ * Returns: 1 if the timer is pending, 0 if not.
  */
 static inline int timer_pending(const struct timer_list * timer)
 {
@@ -175,6 +175,10 @@ extern int timer_shutdown(struct timer_list *timer);
  * See timer_delete_sync() for detailed explanation.
  *
  * Do not use in new code. Use timer_delete_sync() instead.
+ *
+ * Returns:
+ * * %0	- The timer was not pending
+ * * %1	- The timer was pending and deactivated
  */
 static inline int del_timer_sync(struct timer_list *timer)
 {
@@ -188,6 +192,10 @@ static inline int del_timer_sync(struct timer_list *timer)
  * See timer_delete() for detailed explanation.
  *
  * Do not use in new code. Use timer_delete() instead.
+ *
+ * Returns:
+ * * %0	- The timer was not pending
+ * * %1	- The timer was pending and deactivated
  */
 static inline int del_timer(struct timer_list *timer)
 {

