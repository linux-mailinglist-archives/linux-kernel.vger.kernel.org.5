Return-Path: <linux-kernel+bounces-82396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9A38683A7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9791F24A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBC51353ED;
	Mon, 26 Feb 2024 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1uvQ93FD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R6oms6eU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BEB134753;
	Mon, 26 Feb 2024 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986280; cv=none; b=QL6QFkW9EJU4xLmeRnNAbsgDxmnZMjsP1XpO1I1ZQg2cVd83wmkp5QPBmnoOg68qp7GBWlKAv8DDHFpjUsrb9j1sWcATZq/85c/Sl2y15Np0iepCvfu7GNgdCjYez9Xt77KIaKJV4I6p5JQ747zHxJjgC89IvXPyR6ZKJmK65HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986280; c=relaxed/simple;
	bh=Gb9/Sg1e4bTsSFnIai8laRQcHRpbPHLpDfe/CXQ1we4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TNp7o8XrkuTQg5yThWQw1XKCOyZiqR24r6uxIwomwyPv9z+Mb74QQ0NFR2W+M+uhZpLw/zrjno1tAKoOkTrATYgsGIPL+MzelMFcpqunVVbXRtJBItsGLHqeBgHfV5e58dlh2AVh4+UbJjS2B0eMeODSznF3+bjHeX25Fjm1dO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1uvQ93FD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R6oms6eU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 22:24:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708986277;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7gmvywgK7hzuqrOlHez702NlidrZOsbLEYuY6O8im8k=;
	b=1uvQ93FDva03tSM/5Oror5hfRWuxnGZaMSL3Qpze/1LxWJURHh8bWL8ojMc0/84QSGyuOm
	rHZJfeUADbAy2hR0orlgLvgugSzC52ecAe5I4fXwtCTFKuxOLLQY8kdshWcCDbVOV8SU59
	1QuxLKYMDGksgDJOaxAr6h+EqSgbKlgQ7Bfrohr2HdfnMtRbYBKlgX4gQj5xFxR1j4f37R
	dgm5bMcTy3+FbIHpCkcf2FEbH60IDYeABUWqYyp8n2ajCvmtKIZTo/BNuV2BB7+mxQm1Z7
	nXtS+F3JXDw693TKDbX0P/dRwxenPGtF9CmYQi5TKYDuYONKUPVZK1tCv0nKJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708986277;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7gmvywgK7hzuqrOlHez702NlidrZOsbLEYuY6O8im8k=;
	b=R6oms6eUqBL26ZXBR185mddfDihsVne5aYn7kt6x9aY1608QunymgQUshVOho76oQi9a65
	Bx8Bktauz/SbWDAQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/sched: Don't clear ts::next_tick again in
 can_stop_idle_tick()
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240225225508.11587-7-frederic@kernel.org>
References: <20240225225508.11587-7-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170898627665.398.805229144856178404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     60313c21c33abc08108bdd60390fa89563977e64
Gitweb:        https://git.kernel.org/tip/60313c21c33abc08108bdd60390fa89563977e64
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Sun, 25 Feb 2024 23:54:58 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Feb 2024 11:37:31 +01:00

tick/sched: Don't clear ts::next_tick again in can_stop_idle_tick()

The tick sched structure is already cleared from tick_cancel_sched_timer(),
so there is no need to clear that field again.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240225225508.11587-7-frederic@kernel.org

---
 kernel/time/tick-sched.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 9f75f56..b17895d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1143,11 +1143,6 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 	if (unlikely(!cpu_online(cpu))) {
 		if (cpu == tick_do_timer_cpu)
 			tick_do_timer_cpu = TICK_DO_TIMER_NONE;
-		/*
-		 * Make sure the CPU doesn't get fooled by obsolete tick
-		 * deadline if it comes back online later.
-		 */
-		ts->next_tick = 0;
 		return false;
 	}
 

