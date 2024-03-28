Return-Path: <linux-kernel+bounces-123447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 053088908D1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99911B210AF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5E9137909;
	Thu, 28 Mar 2024 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="uR9NKpyZ"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C73135A4D;
	Thu, 28 Mar 2024 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711652473; cv=none; b=WaaNAYj/t0en9gn+VSVGuVf/owzmeCqSSg+QFJInNib/NhmOFW4y2JaIEsTAQxCWIBo7eSK9upjUVE+KHJ863IHQGoCSEcObu94Uo927xWXHL2QTkfHo415Fm8Zjs3EBaeQxbLnxJJSan77Gysmc9oTSG90Nm++MVNOwd4baVPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711652473; c=relaxed/simple;
	bh=bSQaSHiaC4u0gePRhewgeWg4QIM2Vad/ONuhnTPUE28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnTjtjS1QgGwW+yd0k6X00n0PhawFD/5Xq1KgUjUe4iUwkB1h0f2YGfDZx0VLRyxQwyqUNCUjbji6HPYgYUqBNMpYNmW72y7Naa53x0OmwFrXufBIK2lKA2aRUZomKGMFZNYo6pcnQbB3AEgFJNyv2qRyqLEg0PYhsXGaONyQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=uR9NKpyZ reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id a6c31ea869a14cc0; Thu, 28 Mar 2024 20:00:36 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id DCBDD66C24C;
	Thu, 28 Mar 2024 20:00:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711652436;
	bh=bSQaSHiaC4u0gePRhewgeWg4QIM2Vad/ONuhnTPUE28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uR9NKpyZNNt4TYiSZ8fBcAOwUFZEsabsK4t+4NSMNcb+qoHsLX+JkXpsae0A2nH6W
	 iImDk5Dq5ax+WpuH7y4rMqy3/qeG91qs99Nfun/pkWTqe/iYEFr3KNUQNEz3p8lW+2
	 qnzTAtGnCQ4TcF0YVIn7VsqmIpRTc7ifJu+RwKXZCA9YUDTX3ukgzo4qmA8tSD+MJZ
	 uFyxCnWOxfQYXr4u7SV4EysMs+6A0gqq4FTpFGNEIaHmHO6THEcKGhPF9xrUWZGSnS
	 FOKuqxLuSLXSqm3s/EYjAmt8+rQ+II45tTqA+D17eNpRof2sfnGejbdkINhmuMtWRT
	 j9nwV2VsKadLA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [Update][PATCH v1.2 4/5] cpufreq: intel_pstate: Get rid of unnecessary
 READ_ONCE() annotations
Date: Thu, 28 Mar 2024 20:00:35 +0100
Message-ID: <12435759.O9o76ZdvQC@kreacher>
In-Reply-To: <12420098.O9o76ZdvQC@kreacher>
References:
 <12409658.O9o76ZdvQC@kreacher> <2184891.irdbgypaU6@kreacher>
 <12420098.O9o76ZdvQC@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudduledguddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop two redundant checks involving READ_ONCE() from notify_hwp_interrupt()
and make it check hwp_active without READ_ONCE() which is not necessary,
because that variable is only set once during the early initialization of
the driver.

In order to make that clear, annotate hwp_active with __ro_after_init.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1.1 -> v1.2: Fix uninitialized memory access introduced in v1.1.

---
 drivers/cpufreq/intel_pstate.c |   27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -292,7 +292,7 @@ struct pstate_funcs {
 
 static struct pstate_funcs pstate_funcs __read_mostly;
 
-static int hwp_active __read_mostly;
+static bool hwp_active __ro_after_init;
 static int hwp_mode_bdw __read_mostly;
 static bool per_cpu_limits __read_mostly;
 static bool hwp_boost __read_mostly;
@@ -1636,11 +1636,10 @@ static cpumask_t hwp_intr_enable_mask;
 void notify_hwp_interrupt(void)
 {
 	unsigned int this_cpu = smp_processor_id();
-	struct cpudata *cpudata;
 	unsigned long flags;
 	u64 value;
 
-	if (!READ_ONCE(hwp_active) || !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
+	if (!hwp_active || !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
 		return;
 
 	rdmsrl_safe(MSR_HWP_STATUS, &value);
@@ -1652,24 +1651,8 @@ void notify_hwp_interrupt(void)
 	if (!cpumask_test_cpu(this_cpu, &hwp_intr_enable_mask))
 		goto ack_intr;
 
-	/*
-	 * Currently we never free all_cpu_data. And we can't reach here
-	 * without this allocated. But for safety for future changes, added
-	 * check.
-	 */
-	if (unlikely(!READ_ONCE(all_cpu_data)))
-		goto ack_intr;
-
-	/*
-	 * The free is done during cleanup, when cpufreq registry is failed.
-	 * We wouldn't be here if it fails on init or switch status. But for
-	 * future changes, added check.
-	 */
-	cpudata = READ_ONCE(all_cpu_data[this_cpu]);
-	if (unlikely(!cpudata))
-		goto ack_intr;
-
-	schedule_delayed_work(&cpudata->hwp_notify_work, msecs_to_jiffies(10));
+	schedule_delayed_work(&all_cpu_data[this_cpu]->hwp_notify_work,
+			      msecs_to_jiffies(10));
 
 	spin_unlock_irqrestore(&hwp_notify_lock, flags);
 
@@ -3464,7 +3447,7 @@ static int __init intel_pstate_init(void
 		 * deal with it.
 		 */
 		if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) || hwp_forced) {
-			WRITE_ONCE(hwp_active, 1);
+			hwp_active = true;
 			hwp_mode_bdw = id->driver_data;
 			intel_pstate.attr = hwp_cpufreq_attrs;
 			intel_cpufreq.attr = hwp_cpufreq_attrs;




