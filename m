Return-Path: <linux-kernel+bounces-117537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2679288AC58
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A1C1FA1443
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C539C5C919;
	Mon, 25 Mar 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="oI0J5css"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B2D19470;
	Mon, 25 Mar 2024 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386390; cv=none; b=chRYEuU5FtCVZ9uUDDsK9REs7Z2Z4WnUqHIsZ1bcGTEx+ypo9qFoEY/HIuhBlNe5gTzJLDvI5rXSCrjaLFRm3nG9s4Wam1rexQz8qOXNsThmOHBN+oJSTavu7E708AWB5k7EFMHw+aiurnSBD+Zt8xE+UPfI9Kn+/uqiSI3DdJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386390; c=relaxed/simple;
	bh=fjljf1Enk5usC8iOYqSaeim6m8iLAHoutCwkhiaG87Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGkaTK95JTjeoVNpCRkIM3mVxwBNfs8UCOoqbhP8T545Iz1qECYAVHAgqfsVw5p7q1UO4fpQakQ01mevi3Oya/HXiOn+/OM2tpZIBbBCYAr9Qqw2CwxL63psP8k1p/HEuNSBuM7wyMC5bMaGtHiXl0NDaGSCOJni7k9V2tDiiHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=oI0J5css reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 1faee166524096db; Mon, 25 Mar 2024 18:06:25 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 36C6C66BD00;
	Mon, 25 Mar 2024 18:06:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711386385;
	bh=fjljf1Enk5usC8iOYqSaeim6m8iLAHoutCwkhiaG87Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oI0J5cssm7siOuHVwSe5u33fYW11GgstdBF9Z8XlxrG8L1N6vjWqUYbQ/EuTgr3X1
	 rKmnjQx6G/6tYBerWqf9IviCRAjsPsoWjTJ0gEB2Y9nc1Bt9xcohJN5KrHkn9C/WzF
	 ZdPrv+NjJfnObk062KjFiOiW8eT/pWym85ILwsi4WiwG78K1B1PkP/8PdBsf9UAYbY
	 1pVjiTNttiI7Xrv8U717Lpx7eLSU4+GCiwYwjBPQ65bFD72L4AH5Lz1aW+TYm011XV
	 xYA61eRv4Xab1YUO/OGixx825WOeR8QvQqLOkwHo/L9Esu6CMjYvwMtdN4FMFpND7+
	 vxwm9xNzCZ01w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 6/6] cpufreq: intel_pstate: Update the maximum CPU frequency
 consistently
Date: Mon, 25 Mar 2024 18:06:09 +0100
Message-ID: <9269494.CDJkKcVGEf@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddgfeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepfedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are 3 places at which the maximum CPU frequency may change,
store_no_turbo(), intel_pstate_update_limits() (when called by the
cpufreq core) and intel_pstate_notify_work() (when handling a HWP
change notification).  Currently, cpuinfo.max_freq is only updated by
store_no_turbo(), although it principle it may be necessary to update
it at the other 2 places too.

Make all of them mutually consistent.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1153,18 +1153,32 @@ static void intel_pstate_update_policies
 static void __intel_pstate_update_max_freq(struct cpudata *cpudata,
 					   struct cpufreq_policy *policy)
 {
+	intel_pstate_get_hwp_cap(cpudata);
+
 	policy->cpuinfo.max_freq = READ_ONCE(global.no_turbo) ?
 			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
+
 	refresh_frequency_limits(policy);
 }
 
 static void intel_pstate_update_limits(unsigned int cpu)
 {
-	mutex_lock(&intel_pstate_driver_lock);
+	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
 
-	cpufreq_update_policy(cpu);
+	if (!policy)
+		return;
 
-	mutex_unlock(&intel_pstate_driver_lock);
+	__intel_pstate_update_max_freq(all_cpu_data[cpu], policy);
+
+	cpufreq_cpu_release(policy);
+}
+
+static void intel_pstate_update_limits_for_all(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		intel_pstate_update_limits(cpu);
 }
 
 /************************** sysfs begin ************************/
@@ -1311,7 +1325,7 @@ static ssize_t store_no_turbo(struct kob
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
-	intel_pstate_update_policies();
+	intel_pstate_update_limits_for_all();
 	arch_set_max_freq_ratio(no_turbo);
 
 unlock_driver:
@@ -1595,7 +1609,6 @@ static void intel_pstate_notify_work(str
 	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpudata->cpu);
 
 	if (policy) {
-		intel_pstate_get_hwp_cap(cpudata);
 		__intel_pstate_update_max_freq(cpudata, policy);
 
 		cpufreq_cpu_release(policy);




