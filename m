Return-Path: <linux-kernel+bounces-122801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC0D88FD89
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A531C25739
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B1A7E10B;
	Thu, 28 Mar 2024 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y7BU8SMJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d0ZeFSwE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E12B7CF17;
	Thu, 28 Mar 2024 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623372; cv=none; b=hSr5W3b2WxltUZWQPrb7psppLP8ax3tzmgWLuSOA2S6tc+BFSAANuQwOjLGad/x6Fxf1UdzMxpNoRWDCk/+XE8OAYbPSkbJ+eKBO0pYuPGsIGOUaCXZHua6qCOQKRxDHswmUDBz2nosypjeZjgRdAN81Z7UJ7pCjoCFoqoOQWXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623372; c=relaxed/simple;
	bh=WdHYKPtTcsqXJoX3TxCEMAgV+vMXrjr88PRvzTxsl/M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EkkQ9zXkB9PJcmIUl6JskOgqw95C3wLwhkaYoP9O18r/+3FoIuMfx47l1WXvRLwswowQWcJQz4ul7Lp5vBWQvplv8jndHHWDVcNUx67uV6zQA+bGIJkWIPZBLvVUMocmiOADjTxs2X2ZRYbjxEXP1YmOSxzBrFOUkInwFwOybCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y7BU8SMJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d0ZeFSwE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 28 Mar 2024 10:56:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711623369;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XmvS3Wl0xjEANvpSuDomX+D/kXWMHVrks8ec3YiMbg=;
	b=Y7BU8SMJY31tvDswz2iVswabLEUn96K+9sDWJW5p2kXmzdNdWSPRUnKVyAxqjOSsslJ/TO
	8j92ZxoYzS8zs/PjWiqXHGWi+ZvSV2RTJl0RpCpVSTELhUEvcyyinD0GFYXkPzNgiDiRPO
	WP8LZiyGYr3wgLZpSW+XL843WMQIOnf+OZWVUT9EGqtG+ohvZ1jyuUMQdPvxuo3XRQZa8F
	nkoJQL3AnvQP8WVq/gpNyg5hWMKHIBFJj5HwWXCWM3hsGypgUh3fkeEg22oI5W63MtiTWk
	8yPzmOt+CJHpyxT7J4qV5oNqGMBnrR8/6SDmhyCrfwvY5hmMX1ChVBNbO0q7nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711623369;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XmvS3Wl0xjEANvpSuDomX+D/kXWMHVrks8ec3YiMbg=;
	b=d0ZeFSwEdyHlAM77GQB4gvAayMUxSnMsov0ffcC1QMSEzevJSjbQEkxymUCgP7BWVoS2Df
	iA+wpbu9rl9siCBA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Rename root_domain::overload to ::overloaded
Cc: Ingo Molnar <mingo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <ZgVHq65XKsOZpfgK@gmail.com>
References: <ZgVHq65XKsOZpfgK@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171162336858.10875.6463840393538664271.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     dfb83ef7b8b064c15be19cf7fcbde0996712de8f
Gitweb:        https://git.kernel.org/tip/dfb83ef7b8b064c15be19cf7fcbde0996712de8f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 28 Mar 2024 11:33:20 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 Mar 2024 11:38:58 +01:00

sched/fair: Rename root_domain::overload to ::overloaded

It is silly to use an ambiguous noun instead of a clear adjective when naming
such a flag ...

Note how root_domain::overutilized already used a proper adjective.

rd->overloaded is now set to 1 when the root domain is overloaded.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/ZgVHq65XKsOZpfgK@gmail.com
---
 kernel/sched/sched.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e86ee26..cddc479 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -874,7 +874,7 @@ struct root_domain {
 	 * - More than one runnable task
 	 * - Running task is misfit
 	 */
-	int			overload;
+	int			overloaded;
 
 	/* Indicate one or more cpus over-utilized (tipping point) */
 	int			overutilized;
@@ -932,13 +932,13 @@ extern void sched_put_rd(struct root_domain *rd);
 
 static inline int get_rd_overload(struct root_domain *rd)
 {
-	return READ_ONCE(rd->overload);
+	return READ_ONCE(rd->overloaded);
 }
 
 static inline void set_rd_overload(struct root_domain *rd, int status)
 {
 	if (get_rd_overload(rd) != status)
-		WRITE_ONCE(rd->overload, status);
+		WRITE_ONCE(rd->overloaded, status);
 }
 
 #ifdef HAVE_RT_PUSH_IPI

