Return-Path: <linux-kernel+bounces-117538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4B888AC5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE34B1C3FEA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0277316D;
	Mon, 25 Mar 2024 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="W7A/SbwY"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831C033EE;
	Mon, 25 Mar 2024 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386391; cv=none; b=ay+iXslO1wF4XpiRRwYPsT5Ds0549b4nJYEu926jIXB/cylZ4jBeCbGbDCUsFTL+cz0WtYhdvxMckaP0FyhVijGO7hpjhz287Tgh9GfC/CzOZ1A5K+dFP1rbMM4ZLag5Zr0i5mavEZq55Sjy5uAbwg0FUkzqWlk6JP4njjOQAi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386391; c=relaxed/simple;
	bh=a7qxMDyirbV2YYb69bzcYg/VUG3CVYS1BVROPZccLaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhpiLCjbP1UC2Pu9eW4Wyv24eJ9uy9YGPfGwePj42oJVukmMA8GdlaM+Lyc5vOIHraQEBdRkTuy3DjfXr6G/khat4+oZkk4Vs2eUzKgVrJpHuge+lGKdYMIbfbAOOT9W/KqkXdQUAkMC6tUP+G6kmKXDRj43rmIDdr+7oHixxSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=W7A/SbwY reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 7711f17b556e10b7; Mon, 25 Mar 2024 18:06:26 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E310166BCFE;
	Mon, 25 Mar 2024 18:06:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711386386;
	bh=a7qxMDyirbV2YYb69bzcYg/VUG3CVYS1BVROPZccLaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W7A/SbwYjmX4/wRSA9sX8tOFlBTQp8LYxPLRbU8QTJVXlmwltiTz5X8v5SdtM8aSg
	 +yjxJrWf7i0Y+U0o1Rs2vlbI9kP4thnAf4HGsC5fdjA5v1Na5jinespNUSQcr5EiVJ
	 352/CRto8Xov2Vis9HY31Br0m5ZyWLupnn1F8sab1Q2DgZ+Tv06OxRrJnxmoBp6C5X
	 wNJffal6vvHX1/E0L3nZdZspbl2Xram/tc5YUGOWQN5Qw3P5TUBDXWQOeDgboJkiuk
	 R4D6I8F7SJbHmg0vXtCdxbPI8GN/2ZD+3Q1iuf4rRJU41rRxsvuntRHtzeAPTL32pM
	 Na2y1ejHySKiQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 5/6] cpufreq: intel_pstate: Replace three global.turbo_disabled
 checks
Date: Mon, 25 Mar 2024 18:05:06 +0100
Message-ID: <3813405.kQq0lBPeGt@kreacher>
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

Replace the global.turbo_disabled in __intel_pstate_update_max_freq() with
a global.no_turbo one to make store_no_turbo() actually update the maximum
CPU frequency on the trubo preference changes, which needs to be consistent
with arch_set_max_freq_ratio() called from there.

For more consistency, replace the global.turbo_disabled checks in
__intel_pstate_cpu_init() and intel_cpufreq_adjust_perf() with
global.no_turbo checks either.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1153,7 +1153,7 @@ static void intel_pstate_update_policies
 static void __intel_pstate_update_max_freq(struct cpudata *cpudata,
 					   struct cpufreq_policy *policy)
 {
-	policy->cpuinfo.max_freq = global.turbo_disabled ?
+	policy->cpuinfo.max_freq = READ_ONCE(global.no_turbo) ?
 			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
 	refresh_frequency_limits(policy);
 }
@@ -2704,7 +2704,7 @@ static int __intel_pstate_cpu_init(struc
 
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.min_freq = cpu->pstate.min_freq;
-	policy->cpuinfo.max_freq = global.turbo_disabled ?
+	policy->cpuinfo.max_freq = READ_ONCE(global.no_turbo) ?
 			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
 
 	policy->min = policy->cpuinfo.min_freq;
@@ -2907,8 +2907,9 @@ static void intel_cpufreq_adjust_perf(un
 	int old_pstate = cpu->pstate.current_pstate;
 	int cap_pstate, min_pstate, max_pstate, target_pstate;
 
-	cap_pstate = global.turbo_disabled ? HWP_GUARANTEED_PERF(hwp_cap) :
-					     HWP_HIGHEST_PERF(hwp_cap);
+	cap_pstate = READ_ONCE(global.no_turbo) ?
+					HWP_GUARANTEED_PERF(hwp_cap) :
+					HWP_HIGHEST_PERF(hwp_cap);
 
 	/* Optimization: Avoid unnecessary divisions. */
 




