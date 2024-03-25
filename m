Return-Path: <linux-kernel+bounces-117541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F9B88AC62
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A569F282144
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433E612AAF2;
	Mon, 25 Mar 2024 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ITcZAYth"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C615D724;
	Mon, 25 Mar 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386393; cv=none; b=OGErdydhqk6+2rMfrnAS6lzrs3V5nfzURe10usXCO23iW1BDgA7dXZehPkMesyVP6YcI2TBLfBx4qvGRVz3gbkSw+eIBslQeSz9apLIWuPRcSkHNtwq19uylb7Mx5Y4too8K+XxhqDzc0bqdLQP07IGe0DHK0wy7NxB3rrcskgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386393; c=relaxed/simple;
	bh=5b1cKzNGP+fwGMjTrtL+bQQ76W2oyR/UxjBKUZ5MpBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpmkGJpotZomppQFGfwsMYOk4DotDBiroEEZb6ovDSu7RFlZ5l4xdPSZlQzZusPFg0nXvEa6HYxD4gmHVdxAUuLz004ed9yWxCAmNYsT62ZS9DidgBtCoRFmz5UIi8z+mNwYjtN0e+gYFcDzfnev8wYhynD5fN9qQCKNvlIyl4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ITcZAYth reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 451a8d2cd953fd11; Mon, 25 Mar 2024 18:06:28 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 48B7466BCFE;
	Mon, 25 Mar 2024 18:06:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711386388;
	bh=5b1cKzNGP+fwGMjTrtL+bQQ76W2oyR/UxjBKUZ5MpBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ITcZAYthr/TvQkZXWqXkvSDWXTDtRIixR3nfrnxCwRK1eiFtrZvRL/ohBKJs9Rxwa
	 tow1rkkcp/x+Lm1CKzX7hKQ462DdLAl12xbJzd2PjwJ9UPHgLPX+VoIpxzcbLP2X1Z
	 YNrAzhLqmLXWnQRI3dZkRQNozfuAxCOFTLaRcrKE9Yz/o/gPy8rv4Wr4K15k2ELW/y
	 KRYlCUeIA2yfzoy0p4RXIWyDjzwNzvPncdh72ZJbbu2QKTpk9Wij4ounidDPOQxbWp
	 JxuhG2ES7MSIMAbvmsaGVrulkfEvDAnuAp428wFiQnGdQOcZj1vfVs/m2L0hlCFiXg
	 mymoAvEAZvEjA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 2/6] cpufreq: intel_pstate: Do not update global.turbo_disabled
 after initialization
Date: Mon, 25 Mar 2024 18:02:42 +0100
Message-ID: <8366982.T7Z3S40VBb@kreacher>
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

The global.turbo_disabled is updated quite often, especially in the
passive mode in which case it is updated every time the scheduler calls
into the driver.  However, this is generally not necessary and it adds
MSR read overhead to scheduler code paths (and that particular MSR is
slow to read).

For this reason, make the driver read MSR_IA32_MISC_ENABLE_TURBO_DISABLE
just once at the cpufreq driver registration time and remove all of the
in-flight updates of global.turbo_disabled.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   51 ++++++-----------------------------------
 1 file changed, 8 insertions(+), 43 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -173,7 +173,6 @@ struct vid_data {
  *			based on the MSR_IA32_MISC_ENABLE value and whether or
  *			not the maximum reported turbo P-state is different from
  *			the maximum reported non-turbo one.
- * @turbo_disabled_mf:	The @turbo_disabled value reflected by cpuinfo.max_freq.
  * @min_perf_pct:	Minimum capacity limit in percent of the maximum turbo
  *			P-state capacity.
  * @max_perf_pct:	Maximum capacity limit in percent of the maximum turbo
@@ -182,7 +181,6 @@ struct vid_data {
 struct global_params {
 	bool no_turbo;
 	bool turbo_disabled;
-	bool turbo_disabled_mf;
 	int max_perf_pct;
 	int min_perf_pct;
 };
@@ -594,12 +592,13 @@ static void intel_pstate_hybrid_hwp_adju
 	cpu->pstate.min_pstate = intel_pstate_freq_to_hwp(cpu, freq);
 }
 
-static inline void update_turbo_state(void)
+static bool turbo_is_disabled(void)
 {
 	u64 misc_en;
 
 	rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
-	global.turbo_disabled = misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE;
+
+	return !!(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
 }
 
 static int min_perf_pct_min(void)
@@ -1154,40 +1153,16 @@ static void intel_pstate_update_policies
 static void __intel_pstate_update_max_freq(struct cpudata *cpudata,
 					   struct cpufreq_policy *policy)
 {
-	policy->cpuinfo.max_freq = global.turbo_disabled_mf ?
+	policy->cpuinfo.max_freq = global.turbo_disabled ?
 			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
 	refresh_frequency_limits(policy);
 }
 
-static void intel_pstate_update_max_freq(unsigned int cpu)
-{
-	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
-
-	if (!policy)
-		return;
-
-	__intel_pstate_update_max_freq(all_cpu_data[cpu], policy);
-
-	cpufreq_cpu_release(policy);
-}
-
 static void intel_pstate_update_limits(unsigned int cpu)
 {
 	mutex_lock(&intel_pstate_driver_lock);
 
-	update_turbo_state();
-	/*
-	 * If turbo has been turned on or off globally, policy limits for
-	 * all CPUs need to be updated to reflect that.
-	 */
-	if (global.turbo_disabled_mf != global.turbo_disabled) {
-		global.turbo_disabled_mf = global.turbo_disabled;
-		arch_set_max_freq_ratio(global.turbo_disabled);
-		for_each_possible_cpu(cpu)
-			intel_pstate_update_max_freq(cpu);
-	} else {
-		cpufreq_update_policy(cpu);
-	}
+	cpufreq_update_policy(cpu);
 
 	mutex_unlock(&intel_pstate_driver_lock);
 }
@@ -1287,7 +1262,6 @@ static ssize_t show_no_turbo(struct kobj
 		return -EAGAIN;
 	}
 
-	update_turbo_state();
 	if (global.turbo_disabled)
 		ret = sprintf(buf, "%u\n", global.turbo_disabled);
 	else
@@ -1317,7 +1291,6 @@ static ssize_t store_no_turbo(struct kob
 
 	mutex_lock(&intel_pstate_limits_lock);
 
-	update_turbo_state();
 	if (global.turbo_disabled) {
 		pr_notice_once("Turbo disabled by BIOS or unavailable on processor\n");
 		mutex_unlock(&intel_pstate_limits_lock);
@@ -2281,8 +2254,6 @@ static void intel_pstate_adjust_pstate(s
 	struct sample *sample;
 	int target_pstate;
 
-	update_turbo_state();
-
 	target_pstate = get_target_pstate(cpu);
 	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
 	trace_cpu_frequency(target_pstate * cpu->pstate.scaling, cpu->cpu);
@@ -2593,7 +2564,6 @@ static int intel_pstate_set_policy(struc
 		 * be invoked on them.
 		 */
 		intel_pstate_clear_update_util_hook(policy->cpu);
-		update_turbo_state();
 		intel_pstate_set_pstate(cpu, pstate);
 	} else {
 		intel_pstate_set_update_util_hook(policy->cpu);
@@ -2637,7 +2607,6 @@ static void intel_pstate_verify_cpu_poli
 {
 	int max_freq;
 
-	update_turbo_state();
 	if (hwp_active) {
 		intel_pstate_get_hwp_cap(cpu);
 		max_freq = global.no_turbo || global.turbo_disabled ?
@@ -2734,8 +2703,6 @@ static int __intel_pstate_cpu_init(struc
 
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.min_freq = cpu->pstate.min_freq;
-	update_turbo_state();
-	global.turbo_disabled_mf = global.turbo_disabled;
 	policy->cpuinfo.max_freq = global.turbo_disabled ?
 			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
 
@@ -2901,8 +2868,6 @@ static int intel_cpufreq_target(struct c
 	struct cpufreq_freqs freqs;
 	int target_pstate;
 
-	update_turbo_state();
-
 	freqs.old = policy->cur;
 	freqs.new = target_freq;
 
@@ -2924,8 +2889,6 @@ static unsigned int intel_cpufreq_fast_s
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 	int target_pstate;
 
-	update_turbo_state();
-
 	target_pstate = intel_pstate_freq_to_hwp(cpu, target_freq);
 
 	target_pstate = intel_cpufreq_update_pstate(policy, target_pstate, true);
@@ -2943,7 +2906,6 @@ static void intel_cpufreq_adjust_perf(un
 	int old_pstate = cpu->pstate.current_pstate;
 	int cap_pstate, min_pstate, max_pstate, target_pstate;
 
-	update_turbo_state();
 	cap_pstate = global.turbo_disabled ? HWP_GUARANTEED_PERF(hwp_cap) :
 					     HWP_HIGHEST_PERF(hwp_cap);
 
@@ -3131,6 +3093,9 @@ static int intel_pstate_register_driver(
 
 	memset(&global, 0, sizeof(global));
 	global.max_perf_pct = 100;
+	global.turbo_disabled = turbo_is_disabled();
+
+	arch_set_max_freq_ratio(global.turbo_disabled);
 
 	intel_pstate_driver = driver;
 	ret = cpufreq_register_driver(intel_pstate_driver);




