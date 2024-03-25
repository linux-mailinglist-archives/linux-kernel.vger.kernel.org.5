Return-Path: <linux-kernel+bounces-117540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE0388AC5E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044A21FA186D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126AD84D30;
	Mon, 25 Mar 2024 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="VMkBJM6D"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0108D5A116;
	Mon, 25 Mar 2024 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386392; cv=none; b=NbM53R7iyPsEebqU+PLXOR8BuKIHFYZOuYc8iVYDnScuQt4vJITzjGlnVQPtuVeIXDHo00BPXHbU6Omxgyz2UEF+8ZZTcPCQg66bK43oJEBhPHSLix/oF9O3GDSLpb6soaqAzbHH6wzjh8dxQH3FD1CK9tANJp60FRoEamcD8aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386392; c=relaxed/simple;
	bh=rbyr08f2otaXHMC3+bsEL2PvCqRfjs3Ibjz5RsYtJ9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vC2ib8BgJw0+bFC8ubeiNUr9pMUMnjhDh/hXv1lBcCGeSMMP0pI014cFsFhPVJ+HYi5HnVmqRaVMSpwtOdiX56TCjnqM341yQ16QnAyvTB8hyg7RWdbSLyB9HS8c+F8ySg/qAB8wq1qljKPq6f9QJ2AWsdARaqaSQvIFNsNvFow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=VMkBJM6D reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 000bcab9c8521366; Mon, 25 Mar 2024 18:06:28 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 73F1D66BCFE;
	Mon, 25 Mar 2024 18:06:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711386387;
	bh=rbyr08f2otaXHMC3+bsEL2PvCqRfjs3Ibjz5RsYtJ9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VMkBJM6DgBKREXJt/3sCjrhrkI1NGiKMOOVvl4oBJvzPltXQSTedvxxvAYrlnVdO+
	 yNMqPaurAtxpUnu3fQ5LfsQW8ZUkd5nBPQZSs9vnczEQUtZQhwUDKUMGQIHY46BT0J
	 DVdOI2Tx8Ik5T8qZjXdYIN4bYAmPIzwVe87Aj2+qw+CWwwQm7wOw2m5ZRhv6uHDMfM
	 weLeYaWJe8YzI4KyZV771+VqfYSW3o0BMAFiXK4uwsc24HipqocESF27VrKmvIOua/
	 2Cl/KJYsLJ7ii0D843zVNkTNd5eAZ56WMnvt6cOOCqlKJ6och865xHBTwT7wGtjgqU
	 htCLZIav339hg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 3/6] cpufreq: intel_pstate: Rearrange show_no_turbo() and
 store_no_turbo()
Date: Mon, 25 Mar 2024 18:03:25 +0100
Message-ID: <2276522.iZASKD2KPV@kreacher>
In-Reply-To: <13494237.uLZWGnKmhe@kreacher>
References: <13494237.uLZWGnKmhe@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddgfeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepfedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Now that global.turbo_disabled can only change at the cpufreq driver
registration time, initialize global.no_turbo at that time too so they
are in sync to start with (if the former is set, the latter cannot be
updated later anyway).

That allows show_no_turbo() to be simlified because it does not need
to check global.turbo_disabled and store_no_turbo() can be rearranged
to avoid doing anything if the new value of global.no_turbo is equal
to the current one and only return an error on attempts to clear
global.no_turbo when global.turbo_disabled.

While at it, eliminate the redundant ret variable from store_no_turbo().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1262,10 +1262,7 @@ static ssize_t show_no_turbo(struct kobj
 		return -EAGAIN;
 	}
 
-	if (global.turbo_disabled)
-		ret = sprintf(buf, "%u\n", global.turbo_disabled);
-	else
-		ret = sprintf(buf, "%u\n", global.no_turbo);
+	ret = sprintf(buf, "%u\n", global.no_turbo);
 
 	mutex_unlock(&intel_pstate_driver_lock);
 
@@ -1276,31 +1273,34 @@ static ssize_t store_no_turbo(struct kob
 			      const char *buf, size_t count)
 {
 	unsigned int input;
-	int ret;
+	bool no_turbo;
 
-	ret = sscanf(buf, "%u", &input);
-	if (ret != 1)
+	if (sscanf(buf, "%u", &input) != 1)
 		return -EINVAL;
 
 	mutex_lock(&intel_pstate_driver_lock);
 
 	if (!intel_pstate_driver) {
-		mutex_unlock(&intel_pstate_driver_lock);
-		return -EAGAIN;
+		count = -EAGAIN;
+		goto unlock_driver;
 	}
 
-	mutex_lock(&intel_pstate_limits_lock);
+	no_turbo = !!clamp_t(int, input, 0, 1);
+
+	if (no_turbo == global.no_turbo)
+		goto unlock_driver;
 
 	if (global.turbo_disabled) {
 		pr_notice_once("Turbo disabled by BIOS or unavailable on processor\n");
-		mutex_unlock(&intel_pstate_limits_lock);
-		mutex_unlock(&intel_pstate_driver_lock);
-		return -EPERM;
+		count = -EPERM;
+		goto unlock_driver;
 	}
 
-	global.no_turbo = clamp_t(int, input, 0, 1);
+	global.no_turbo = no_turbo;
+
+	mutex_lock(&intel_pstate_limits_lock);
 
-	if (global.no_turbo) {
+	if (no_turbo) {
 		struct cpudata *cpu = all_cpu_data[0];
 		int pct = cpu->pstate.max_pstate * 100 / cpu->pstate.turbo_pstate;
 
@@ -1312,8 +1312,9 @@ static ssize_t store_no_turbo(struct kob
 	mutex_unlock(&intel_pstate_limits_lock);
 
 	intel_pstate_update_policies();
-	arch_set_max_freq_ratio(global.no_turbo);
+	arch_set_max_freq_ratio(no_turbo);
 
+unlock_driver:
 	mutex_unlock(&intel_pstate_driver_lock);
 
 	return count;
@@ -3094,6 +3095,7 @@ static int intel_pstate_register_driver(
 	memset(&global, 0, sizeof(global));
 	global.max_perf_pct = 100;
 	global.turbo_disabled = turbo_is_disabled();
+	global.no_turbo = global.turbo_disabled;
 
 	arch_set_max_freq_ratio(global.turbo_disabled);
 




