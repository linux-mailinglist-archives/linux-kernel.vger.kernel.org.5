Return-Path: <linux-kernel+bounces-110615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEA4886151
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC2231C21657
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89263134723;
	Thu, 21 Mar 2024 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wn7sVzO8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZBuDx+YE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4C013441C;
	Thu, 21 Mar 2024 19:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711050774; cv=none; b=UL6r0PMSmSmdrmWOdG1Bo+ZAjKC/uQxCfFciQ9xVrotL58KPD4zrKBquJG0MAW5wFxVsxoyzBuCp+iGA06OHI9PBo0qWfT8wL7KOrQrM0ncismTbQDxHzM7DILjSCH3nKJ1hrDNedHfdFe8uxfsx38XZEohFmv04Q1Wt5flugd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711050774; c=relaxed/simple;
	bh=OG4oZDlj7xSAP0j1SD7NCJmENp5RQXYQObEeb4Is2hc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mKMAMr7iST3r6KH8NJyLew7W/HkQuijpTKZyGBUghoHHrHXXy94XN4cliF6ZpqRfjLiuUoVG2rWombQ9RYzp8EA7rLIBBeYm27c58wvvDHbdkTDxXGCLTmxgSCy5hVgNIiVs8rIs0P+MP2VIuNBFdT/xjAl5BZ2xjYIpnO0H8lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wn7sVzO8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZBuDx+YE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 21 Mar 2024 19:52:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711050771;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nggiyJFhgjwRPFJ4jzj9pqC5QV0DGtas+sT2vrcFy3U=;
	b=Wn7sVzO8ufj5zBYJQdFNpin9dfchuazNbgphg6V6L5RSMtLGu6A4jktrt3GlRuXP7eLO1p
	BfmWnZRnQC5U0KNs/eGd7R3CgYiri20DcdMW+lIpP1fqLJ9Ty+/xom7xjJ5hTwXlY7Sf1+
	O0Z8woUVdu72jvzPvb83oE0b/0Ec5YIYFCkjk2ETZK9bVtwq7fX3q/fJmQfvyRaoQn6A4g
	3+m+7iX2syi7rfFbOCfVo7Rg2uRudYk4ZBEiHLPto1rECKE2pLriFl+oLO4OpuewSvW4C/
	ggL9kNvdItB26R3xDf/d2BtktO732QdKvetZlxHhWeDOO8RMhjg4OC1XySnfgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711050771;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nggiyJFhgjwRPFJ4jzj9pqC5QV0DGtas+sT2vrcFy3U=;
	b=ZBuDx+YExIGZrBJG1VFgvwG6XhtVlLga+OKws7DYp9qJ2m0QtowINN3Rozw4TiKqF6UOBz
	a6Og6v94b60UBrBQ==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/qspinlock: Always evaluate lockevent*
 non-event parameter once
Cc: Ingo Molnar <mingo@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240319005004.1692705-1-longman@redhat.com>
References: <20240319005004.1692705-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171105077065.10875.8732979745826273189.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3774b28d8f3b9e8a946beb9550bee85e5454fc9f
Gitweb:        https://git.kernel.org/tip/3774b28d8f3b9e8a946beb9550bee85e5454fc9f
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Mon, 18 Mar 2024 20:50:04 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Mar 2024 20:45:17 +01:00

locking/qspinlock: Always evaluate lockevent* non-event parameter once

The 'inc' parameter of lockevent_add() and the cond parameter of
lockevent_cond_inc() are only evaluated when CONFIG_LOCK_EVENT_COUNTS
is on. That can cause problem if those parameters are expressions
with side effect like a "++". Fix this by evaluating those non-event
parameters once even if CONFIG_LOCK_EVENT_COUNTS is off. This will also
eliminate the need of the __maybe_unused attribute to the wait_early
local variable in pv_wait_node().

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20240319005004.1692705-1-longman@redhat.com
---
 kernel/locking/lock_events.h        | 4 ++--
 kernel/locking/qspinlock_paravirt.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lock_events.h b/kernel/locking/lock_events.h
index a6016b9..d2345e9 100644
--- a/kernel/locking/lock_events.h
+++ b/kernel/locking/lock_events.h
@@ -53,8 +53,8 @@ static inline void __lockevent_add(enum lock_events event, int inc)
 #else  /* CONFIG_LOCK_EVENT_COUNTS */
 
 #define lockevent_inc(ev)
-#define lockevent_add(ev, c)
-#define lockevent_cond_inc(ev, c)
+#define lockevent_add(ev, c)		do { (void)(c); } while (0)
+#define lockevent_cond_inc(ev, c)	do { (void)(c); } while (0)
 
 #endif /* CONFIG_LOCK_EVENT_COUNTS */
 
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index ae2b12f..169950f 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -294,7 +294,7 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 {
 	struct pv_node *pn = (struct pv_node *)node;
 	struct pv_node *pp = (struct pv_node *)prev;
-	bool __maybe_unused wait_early;
+	bool wait_early;
 	int loop;
 
 	for (;;) {

