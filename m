Return-Path: <linux-kernel+bounces-82394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C778683A3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CDDC1F24B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2325134CDD;
	Mon, 26 Feb 2024 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zHcapkex";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KsneVIhc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9BC13398F;
	Mon, 26 Feb 2024 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986278; cv=none; b=oVD5oc57TrA8vqN1nxYtFlKx49dYnTm0U565leSibneGjD5gsQjS27pRfYCEulxIMZucVKBsrL2CrgIhxN4IpGkx1FKrfIlzZ0ipxsWkMOATsiVPj5ogVEBtzmD3DGGiBR1kZMfXQlM+5FbCcuWMGKRGLl83J1UtFGch1HIJ06k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986278; c=relaxed/simple;
	bh=g/P8P0X+m6WFPSRX7M3TBbD2a36axlBRjg9JkTO/dzg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LbPz4EDMbFgYJFJKCv+zhMGYjxGC7uHE2QOovFXGH7qUlTpC4oCJX6iuO8NfriF0uFuLI+0E4fQoeOAdf+s1nbgxu5FSH0WHzBV7SWoEC1yIMMkS38aN4yL4JbBJJl+C9ZXeFi1GxCaZvBL7YriTorh1Yxn9E1FeceytpJWttmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zHcapkex; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KsneVIhc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 22:24:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708986275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ji6WYWcZaLndFA++YglzMqPjmvUsGA2azQ2LS4flAvo=;
	b=zHcapkexf+mzMPspkGzPvALaddWY0ItCnKrAK93ZvKihFsjqGxGjzo5ph+pT7xAdhKo4E3
	cPKctWuVQhljsgNEyBgMWqXPC7+idZ45/aKc+4u0d6D9Nrr3RY7gmIYBUKRBGKY3Ik55hN
	AQxYmc0XpomzZzRwDXPF1/+EqUJ3yTnBCKSEfLsagCLBG8LYM7sIJpVhN5BqV3RyOXemZr
	eVgddStFbV4muYp6FVTXNdWKAOZss/K1czJCf9eGA7Y0wdFHanXAcgvKb4wa+5zJq3WEae
	DFV65VngKfJIDTt+oAUhp8lF4FthyywxsZUzl/81VVKOxAxEaAi9IWFVDer9pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708986275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ji6WYWcZaLndFA++YglzMqPjmvUsGA2azQ2LS4flAvo=;
	b=KsneVIhcJLYQ033tPYd0v8y5IftbDhazeB9I3upX3PBbPIps1ZOKNL+scRkMjA69ADbFDj
	UjRtI8CKqLeb+4BQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] tick: Move tick cancellation up to CPUHP_AP_TICK_DYING
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240225225508.11587-9-frederic@kernel.org>
References: <20240225225508.11587-9-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170898627487.398.4565777561745395590.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f04e51220ad5cf35540f67f3ca15c8617c1f0bef
Gitweb:        https://git.kernel.org/tip/f04e51220ad5cf35540f67f3ca15c8617c1f0bef
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Sun, 25 Feb 2024 23:55:00 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Feb 2024 11:37:31 +01:00

tick: Move tick cancellation up to CPUHP_AP_TICK_DYING

The tick hrtimer is cancelled right before hrtimers are migrated. This
is done from the hrtimer subsystem even though it shouldn't know about
its actual users.

Move instead the tick hrtimer cancellation to the relevant CPU hotplug
state that aims at centralizing high level tick shutdown operations so
that the related flow is easy to follow.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240225225508.11587-9-frederic@kernel.org

---
 kernel/time/hrtimer.c     | 2 --
 kernel/time/tick-common.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 95f1f35..3e95474 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2229,8 +2229,6 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 	int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping_cpumask(HK_TYPE_TIMER));
 	struct hrtimer_cpu_base *old_base, *new_base;
 
-	tick_cancel_sched_timer(dying_cpu);
-
 	old_base = this_cpu_ptr(&hrtimer_bases);
 	new_base = &per_cpu(hrtimer_bases, ncpu);
 
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index a89ef45..b4af8c7 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -410,6 +410,8 @@ int tick_cpu_dying(unsigned int dying_cpu)
 	if (tick_do_timer_cpu == dying_cpu)
 		tick_do_timer_cpu = cpumask_first(cpu_online_mask);
 
+	tick_cancel_sched_timer(dying_cpu);
+
 	return 0;
 }
 

