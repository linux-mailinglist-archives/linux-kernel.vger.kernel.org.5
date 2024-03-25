Return-Path: <linux-kernel+bounces-117494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C73E88ABF8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5003B2C4D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BBC149C7E;
	Mon, 25 Mar 2024 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="F+4be4/6"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC00137C35;
	Mon, 25 Mar 2024 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385136; cv=none; b=qZ/EV3xfeTVksyC7rphQTiXSgaUWHMRwB9uC5OURTqFhfGsOMBfCHmE6hQQp928FgXSKQ3tZyFmlkj/JrqwTqBjcvQrCIposC4+psSMcYGuuReVWvqu1Qs71C3ouHp/tHY3H6Ej/aDwC0lEGi6unBrEmwWCYaK503UK/HQe3Sow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385136; c=relaxed/simple;
	bh=zLQDJbl97oYT6inlGwxSIxWN6DudQjjreqnMoriRhJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3SgMqZccdrtTHwKpfo0fga7YE8qA4weeFk5EuZMaPT+5ju+QeeTMKem775BaHjNHk5A2Rw3s66qDbBOypGNu4cNGqP8PgVtbWKj8yAqmgn9qlr6Mj+voqR8gRN0Dw8hfjgshjpIgbbWJXNGSmmmF8msXN2VjlgbcQzL6BHwMdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=F+4be4/6 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 5e11dce25326d606; Mon, 25 Mar 2024 17:45:31 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9114866BCF9;
	Mon, 25 Mar 2024 17:45:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711385131;
	bh=zLQDJbl97oYT6inlGwxSIxWN6DudQjjreqnMoriRhJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F+4be4/6xkzwsS7QINP+qWRy+nLiA1o3zjlVGoBjnXuuS1qGqyxiPJIiNMT5DknuR
	 FdP9N30z6e1jjhbF/q9/cEYpPOQsIelFRAaoJ0vFcN63nvn0HVp3dTCG1Mh7OG63WI
	 svp0fCt0iovG4AUZDeAymLxiqOeUOYx4wDw+AeLexlvywTrGVUcCcNsi3+RpzS43vs
	 Im3OTUXkjBi04YvnpRjsdaYiEjWTm+3jW+sSJKW62kr5wx4o9eWeTrU99phyT8NP0V
	 EUIS0JHDYkAMPXRs9CECEps9BlUCCkIRZ6I3OvdIAmlSBvc1XMLldp2fZZ+rVDmtNn
	 9mfkMSXkHQsDw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [Update][PATCH v1.1 4/5] cpufreq: intel_pstate: Get rid of unnecessary
 READ_ONCE() annotations
Date: Mon, 25 Mar 2024 17:45:30 +0100
Message-ID: <12420098.O9o76ZdvQC@kreacher>
In-Reply-To: <2184891.irdbgypaU6@kreacher>
References: <12409658.O9o76ZdvQC@kreacher> <2184891.irdbgypaU6@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddgfeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepfedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop two redundant checks involving READ_ONCE() from notify_hwp_interrupt()
and make it check hwp_active without READ_ONCE() which is not necessary,
because that variable is only set once during the early initialization of
the driver.

In order to make that clear, annotate hwp_active with __ro_after_init.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v1.1:
   * There are two redundant checks in notify_hwp_interrupt() that can
     be dropped, so drop them both.

---
 drivers/cpufreq/intel_pstate.c |   23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

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
@@ -1640,7 +1640,7 @@ void notify_hwp_interrupt(void)
 	unsigned long flags;
 	u64 value;
 
-	if (!READ_ONCE(hwp_active) || !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
+	if (!hwp_active || !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
 		return;
 
 	rdmsrl_safe(MSR_HWP_STATUS, &value);
@@ -1652,23 +1652,6 @@ void notify_hwp_interrupt(void)
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
 	schedule_delayed_work(&cpudata->hwp_notify_work, msecs_to_jiffies(10));
 
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




