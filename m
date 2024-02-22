Return-Path: <linux-kernel+bounces-77396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABFC8604B9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F1F1F26A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F87112D1F8;
	Thu, 22 Feb 2024 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CbPA8iko";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9V1oGtxM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAAB73F33;
	Thu, 22 Feb 2024 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637050; cv=none; b=OZgYG/nf1L8HcRktmfv4IW44K/efOj3wuat8lasri8ET3jaj0uyQKf402wg5qr+xsS12Bon+clKhyQfAKM7IYa8ySQjl3ZdSuPYOCmxe/KtzMVbyURLoYuixNw5nENKC9SBhfev+gTxTCxLeQJB4GQpbps5ZCoylDEgiXmS5K70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637050; c=relaxed/simple;
	bh=P/vAShnlnt4tTjBE+MfxxvVqDIWHSWlCHwALHLpLotU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iWIurdqrD8L8RJzn+v0YutPkb2IWft/jsXzteAAb5pw1oVTjDnNyuCMoIFAwlMzihn5RyQhiJ508SFFM1InFemXomAxnb166pqTRKLtqZczrFkcpI768c9cKMMyS4FvsFLUR1fwrQWat42AEBTfEnZNG2ht601ZwevWOgR0OwMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CbPA8iko; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9V1oGtxM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 21:24:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708637047;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bB5ASdAOKRlBSjf6eEIPEh+eRCucZRp3Y42SIxEk/kQ=;
	b=CbPA8ikoths2la+5P6ubxZeLP9GYnkEwpobiJIJj8E6FEf/jAUgHEYyxx/A6yJ5aWm677G
	pwG7Vs7mLDCOztMq87uj1uUmlJpqN2nh5dd13a7RMopfaqtKqQilnqXrrSDZs23ffnRSYj
	XZ9TBmtdweATxKmZpehyPXMNGvgOqRC4hPHHX13UYulfVNOScgVGz+n3axVaV4a/cFNCBw
	Y1iU9mK30MIbMkvzx4TMIf89tXMHrMmSQmTLP29PB2aix6vq9Qp9Yi4pj1AP8s7SmuCT5V
	FoiJZryJLhC8GoQ7apLlhNFC5kx8txvn8gzGwknxeYzyhdOVOd5rp6dPBfasRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708637047;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bB5ASdAOKRlBSjf6eEIPEh+eRCucZRp3Y42SIxEk/kQ=;
	b=9V1oGtxMvGaDmOwh+O4SkL2zkT0WBZi0eiYuwBcYCSDLlpwOBipMKIV7CTR06GpO7iakyd
	RwnzxRzMm9o4faDA==
From: "tip-bot2 for Costa Shulyupin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Select housekeeping CPU during migration
Cc: Waiman Long <longman@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240222200856.569036-1-costa.shul@redhat.com>
References: <20240222200856.569036-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170863704606.398.1106798877548525205.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     56c2cb10120894be40c40a9bf0ce798da14c50f6
Gitweb:        https://git.kernel.org/tip/56c2cb10120894be40c40a9bf0ce798da14c50f6
Author:        Costa Shulyupin <costa.shul@redhat.com>
AuthorDate:    Thu, 22 Feb 2024 22:08:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 22:18:21 +01:00

hrtimer: Select housekeeping CPU during migration

During CPU-down hotplug, hrtimers may migrate to isolated CPUs,
compromising CPU isolation.

Address this issue by masking valid CPUs for hrtimers using
housekeeping_cpumask(HK_TYPE_TIMER).

Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20240222200856.569036-1-costa.shul@redhat.com
---
 kernel/time/hrtimer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 5a98b35..1fd106a 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -38,6 +38,7 @@
 #include <linux/sched/deadline.h>
 #include <linux/sched/nohz.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/isolation.h>
 #include <linux/timer.h>
 #include <linux/freezer.h>
 #include <linux/compat.h>
@@ -2225,8 +2226,8 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 
 int hrtimers_cpu_dying(unsigned int dying_cpu)
 {
+	int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping_cpumask(HK_TYPE_TIMER));
 	struct hrtimer_cpu_base *old_base, *new_base;
-	int i, ncpu = cpumask_first(cpu_active_mask);
 
 	tick_cancel_sched_timer(dying_cpu);
 

