Return-Path: <linux-kernel+bounces-142631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D55C88A2E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63963283E88
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E55F56B65;
	Fri, 12 Apr 2024 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rx5iFdOy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6rlityCd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F4B57303;
	Fri, 12 Apr 2024 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712924131; cv=none; b=MpkSsi7B+IGtfi5vcZEyPL4+5b4zuxqSypfsgBOvRZ6EOh0p0VmLIMlBlHK6vbpS3pWM6VZiLq73yXhDpGQ4X2VMcXRMny+r195KJiNDqzuLw8LFyDCClAw9DVSsDbAtfKgc+QbbQfouort6YuVz22kh9djWRbXIs5qWr0IYW1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712924131; c=relaxed/simple;
	bh=vOjOVmBk53GEykb+2BS8HFGeywIifeGxZfsHU6yYkaI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IAuCSia3vvRfEXbjbzHbQGKC06t+bQbHxh89FBmN74goMxoiqHbb/sYIFEPwoKeCyxXXfJSua3emBs5RTXH0PgttO7kUhoXIx9YYUFoCXe+Zw1FmbaCQJyev0OG4f22VmYb8yCuNBfnzvcsbMrYj21pdlHWXkDRSqpEpkg/6yuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rx5iFdOy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6rlityCd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 12:15:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712924128;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g/zum35qSt/ctc/dbKC/QNKBR2ZJ2X2QpQ9OIixOzNM=;
	b=Rx5iFdOyfy+qzqYr1KV0d9VhV7sRJsN9/99sPiOe/XLRiI16T7+5kHYo1nsULlmO73PlRH
	asSOlLa6CGEc3uvqHvt/5alKqCHDqtoC7edsOxZaWVYvXZJ5SL9Id6ddSMJL5ZMacDCL9h
	dlZt6lcCasfpAvaWAC/1QI1QpfLPVseJCttzq/vaNt11G85S5nf3/KfkFWdyiof1TFVAY/
	SDYl/rebRiMsJfQlI79Pbs2TrYFpnTSB4MXnXqCOmcPJQW/jwDvi3RZbnY9SEOzH38ay1f
	O7cs2ailBxkQNmPrBlEQ57phOoY6rM2jUshp4+m7M3qVsQ7TJVrTV2acH6kVtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712924128;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g/zum35qSt/ctc/dbKC/QNKBR2ZJ2X2QpQ9OIixOzNM=;
	b=6rlityCdUzVupabo/5WeUifBVp0u1WOSsg/m6dSbqWELTdkIeLh6/FkvoGDf5QYV7WJ1EB
	rK89AgS9MDWcffAA==
From: "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] selftests: timers: Fix abs() warning in
 posix_timers test
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240410232637.4135564-3-jstultz@google.com>
References: <20240410232637.4135564-3-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171292412753.10875.7390048269032565457.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     ed366de8ec89d4f960d66c85fc37d9de22f7bf6d
Gitweb:        https://git.kernel.org/tip/ed366de8ec89d4f960d66c85fc37d9de22f7bf6d
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Wed, 10 Apr 2024 16:26:30 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 12 Apr 2024 14:11:15 +02:00

selftests: timers: Fix abs() warning in posix_timers test

Building with clang results in the following warning:

  posix_timers.c:69:6: warning: absolute value function 'abs' given an
      argument of type 'long long' but has parameter of type 'int' which may
      cause truncation of value [-Wabsolute-value]
        if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
            ^
So switch to using llabs() instead.

Fixes: 0bc4b0cf1570 ("selftests: add basic posix timers selftests")
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240410232637.4135564-3-jstultz@google.com

---
 tools/testing/selftests/timers/posix_timers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 348f471..c001dd7 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -66,7 +66,7 @@ static int check_diff(struct timeval start, struct timeval end)
 	diff = end.tv_usec - start.tv_usec;
 	diff += (end.tv_sec - start.tv_sec) * USECS_PER_SEC;
 
-	if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
+	if (llabs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
 		printf("Diff too high: %lld..", diff);
 		return -1;
 	}

