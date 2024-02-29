Return-Path: <linux-kernel+bounces-87102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D681786CFAF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65CC1C21CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B9D381DD;
	Thu, 29 Feb 2024 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CjLc25ko";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ebeWzAvW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF41915E9C;
	Thu, 29 Feb 2024 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225411; cv=none; b=A3nG5gWFGoCh7JkDgE3xyJ1lYplQzdQxnFV2dMjU+EWqDWZEhcUJtzwkVywbjLQHONxQUyY2D5noVAmGPGSEDWgUsviJAvbOflicrWjlsc7LU9RxPMBG0Hclz+bQR82cF/ybQ18W3xOyVDBDoUY4lDsq/CwCWCmhJj85dmgu5ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225411; c=relaxed/simple;
	bh=rWUaseR81wvy9pQj6pxF0e93kmdFfGncVpd5MSPjsQM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TT57rWcJQwC4nENMsUBOG3Mja7mwVMOOZVoYlJvj/BXgRfviQwcwP7cvQzwe6mL492MkbmuVAm2ssj7SrH7Pq7PMRNtQT4xCD+ivwf1HmNFmiMJVJH/7j/HnVQcfuRL6Iw8yfbe4gNx9Btj5wzFDyLCviXSW8rEA6XGgqrEdmu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CjLc25ko; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ebeWzAvW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 29 Feb 2024 16:50:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709225406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ntgi7xLCnL2L+zsjgEdnQnuYJbDjiVZzciWv6UBfwzk=;
	b=CjLc25koOq2k218ZXKLPcDhBapESci+wOfZxCVMTIC0Tf/tK4RDD/FJzF9OzixNc+wOGuD
	QBjUPbuyK+7YBhQhhZAuS61Amfp52XvQD/qg0s3g939pJWJdFv2zwXwNEoIsKnmwyzg3c4
	ZMUHX+Jq8h+6xgiGU6Wzqu1FoazQ419eo15R+DdRDZ5Ul2SG/dSdHjh92IITWoi0DU3ePv
	02NtsjwXjEMIzQkizRcI467qaN64v0YQMGuv4CIDqKOJ1gHvbubLtU+rkU9VRkn3sX4ElY
	9Dbhyim7xGRzonOPbNQ0WtGyIrpc9Xbm8A1cCjEBJ/Zhg1YHMqUWKv/8suxAmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709225406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ntgi7xLCnL2L+zsjgEdnQnuYJbDjiVZzciWv6UBfwzk=;
	b=ebeWzAvWL+RUWop5sPZWFqMnNj3S/ZcLxxHMYiPe6yYUKCgErq7hIKDkXLA7RrTBZmkaCV
	AL+dh/OyWxM3mhAg==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] tick/sched: Fix build failure for CONFIG_NO_HZ_COMMON=n
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240228123850.3499024-1-arnd@kernel.org>
References: <20240228123850.3499024-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170922540581.398.14798351635404206279.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a184d9835a0a689261ea6a4a8dbc18173a031b77
Gitweb:        https://git.kernel.org/tip/a184d9835a0a689261ea6a4a8dbc18173a031b77
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 28 Feb 2024 13:38:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 29 Feb 2024 17:41:29 +01:00

tick/sched: Fix build failure for CONFIG_NO_HZ_COMMON=n

In configurations with CONFIG_TICK_ONESHOT but no CONFIG_NO_HZ or
CONFIG_HIGH_RES_TIMERS, tick_sched_timer_dying() is stubbed out,
but still defined as a global function as well:

kernel/time/tick-sched.c:1599:6: error: redefinition of 'tick_sched_timer_dying'
 1599 | void tick_sched_timer_dying(int cpu)
      |      ^
kernel/time/tick-sched.h:111:20: note: previous definition is here
  111 | static inline void tick_sched_timer_dying(int cpu) { }
      |                    ^

This configuration only appears with ARM CONFIG_ARCH_BCM_MOBILE,
which should not actually select CONFIG_TICK_ONESHOT.

Adjust the #ifdef for the stub to match the condition for building the
tick-sched.c file for consistency with the definition and to avoid
the build regression.

Fixes: 3aedb7fcd88a ("tick/sched: Remove useless oneshot ifdeffery")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240228123850.3499024-1-arnd@kernel.org

---
 kernel/time/tick-sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 58d8d1c..e11c4dc 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -105,7 +105,7 @@ struct tick_sched {
 extern struct tick_sched *tick_get_tick_sched(int cpu);
 
 extern void tick_setup_sched_timer(bool hrtimer);
-#if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
+#if defined CONFIG_TICK_ONESHOT
 extern void tick_sched_timer_dying(int cpu);
 #else
 static inline void tick_sched_timer_dying(int cpu) { }

