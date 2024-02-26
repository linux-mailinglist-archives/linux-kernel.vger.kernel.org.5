Return-Path: <linux-kernel+bounces-82393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 893638683A2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42897285EB2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04176132C03;
	Mon, 26 Feb 2024 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UTOHhCGw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+9vEqG1T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88411133432;
	Mon, 26 Feb 2024 22:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986278; cv=none; b=RdJWoeDe72yhbIYkIPXhKQBfAR+39lhpuS9HgCCfiVJLCJGOXt6afIxwS+dBITFgM1/RjoV8HfZd2vvwglbfhL2k1ufXPh5p3/q8EhZHbuK+gwCmChro7k+FXtgWO/nrBp+0KBNvoTNmU9CGd5gagXRTKDHB8Agw8FhMUt7TjSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986278; c=relaxed/simple;
	bh=KgmlLtNjiqj4Z3n21KCRhCj1nDWKBGEMyQlbcCJHy08=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sDKXEaY7OZMjoiUe5ZcTLq9UExL5a99tj6W5e0ULaO7SWXVxNrXhjyj95vAygGcGj1u6YXuC/w/HCcEdxspvxQbjWJU+TkYlcLxmmcpDevSvCbEHcqmoQbyyr0FlrM9njBQzIxJ/uHiOedfbJlvVApwoU8W3hjmc7ztgmuMTFGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UTOHhCGw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+9vEqG1T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 22:24:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708986274;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYaM4l9yOkcCLpgSnFUHdNv/xE20fMWWty2B2SxxjOs=;
	b=UTOHhCGwGpe2bm52FU4k/pg3hLNnouXLnzPxGX8g8GzXNqqDtFmGf69CykYUV01CFCUSkh
	t7Hsc2XvepAyRcwM1b8BmSXjAVAR4wlShoB6/kB0Cb+18c65tz6xSs1UpBSIPmknWqVr7C
	J35QkfTF0CZU0EdHn4rhsB1M2Oyomc+amKGgJf7gzzzbS+FO5DLWXelZ4uhs/FHAVnpqEV
	wiBB48p3lBnnFOwnYqgBN7eM82z8OvjfQycKj1W+VfPVEyCzkt1cwWKpwZ3gc1KRuzCZ3t
	NZA/RDk918DC1rrcjog3nlVMM/n/4Ra6bK7UbycTmDFHx3Fs6Dha7wFtLiYEag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708986274;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYaM4l9yOkcCLpgSnFUHdNv/xE20fMWWty2B2SxxjOs=;
	b=+9vEqG1TA9sra1qN0dAo0QUypKM44av0H8AT05Qvpitd1jIYa4W14LiSk8ResPr3Zl7EdR
	aEYAmoqrPYblDkAw==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick: Move broadcast cancellation up to
 CPUHP_AP_TICK_DYING
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240225225508.11587-10-frederic@kernel.org>
References: <20240225225508.11587-10-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170898627396.398.11666022364724351280.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ef8969bb552c1c75e997a42d3e2c576b6ed4025a
Gitweb:        https://git.kernel.org/tip/ef8969bb552c1c75e997a42d3e2c576b6ed4025a
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Sun, 25 Feb 2024 23:55:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Feb 2024 11:37:32 +01:00

tick: Move broadcast cancellation up to CPUHP_AP_TICK_DYING

The broadcast shutdown code is executed through a random explicit call
within stop machine from the outgoing CPU.

However the tick broadcast is a midware between the tick callback and
the clocksource, therefore it makes more sense to shut it down after the
tick callback and before the clocksource drivers.

Move it instead to the common tick shutdown CPU hotplug state where
related operations can be ordered from highest to lowest level.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240225225508.11587-10-frederic@kernel.org

---
 include/linux/tick.h        | 6 ------
 kernel/cpu.c                | 2 --
 kernel/time/tick-common.c   | 3 +++
 kernel/time/tick-internal.h | 2 ++
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index afff4c2..c7840ae 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -73,12 +73,6 @@ extern void tick_broadcast_control(enum tick_broadcast_mode mode);
 static inline void tick_broadcast_control(enum tick_broadcast_mode mode) { }
 #endif /* BROADCAST */
 
-#if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_HOTPLUG_CPU)
-extern void tick_offline_cpu(unsigned int cpu);
-#else
-static inline void tick_offline_cpu(unsigned int cpu) { }
-#endif
-
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 extern int tick_broadcast_oneshot_control(enum tick_broadcast_state state);
 #else
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 2635080..5a8ad4f 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1324,8 +1324,6 @@ static int take_cpu_down(void *_param)
 	 */
 	cpuhp_invoke_callback_range_nofail(false, cpu, st, target);
 
-	/* Remove CPU from timer broadcasting */
-	tick_offline_cpu(cpu);
 	/* Park the stopper thread */
 	stop_machine_park(cpu);
 	return 0;
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index b4af8c7..5224140 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -412,6 +412,9 @@ int tick_cpu_dying(unsigned int dying_cpu)
 
 	tick_cancel_sched_timer(dying_cpu);
 
+	/* Remove CPU from timer broadcasting */
+	tick_offline_cpu(dying_cpu);
+
 	return 0;
 }
 
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index a3243c4..5f2105e 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -142,8 +142,10 @@ static inline bool tick_broadcast_oneshot_available(void) { return tick_oneshot_
 #endif /* !(BROADCAST && ONESHOT) */
 
 #if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_HOTPLUG_CPU)
+extern void tick_offline_cpu(unsigned int cpu);
 extern void tick_broadcast_offline(unsigned int cpu);
 #else
+static inline void tick_offline_cpu(unsigned int cpu) { }
 static inline void tick_broadcast_offline(unsigned int cpu) { }
 #endif
 

