Return-Path: <linux-kernel+bounces-117539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C84688B158
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73946C218C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EC182D9B;
	Mon, 25 Mar 2024 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Zu74X5Bk"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4D112E7E;
	Mon, 25 Mar 2024 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386391; cv=none; b=GwmW7SlLikBXCNebMaR3KYNPoeUNVPz09NbkxEFO6hnYnSRtYZ10i7n06kO6l3LxF4ijxcN2Fe4R/37Yi4PQ53hripSv3phVzWt+4RAPOkbAdjVTD2deMv7rfDUMwIB3Tt3NgXawGUBfFhh1ulLRZBXwIUHKoPPYcOqutEqAVrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386391; c=relaxed/simple;
	bh=wxRwgptLJPCrasWZqmI2ge30NFdmDWXQzxRENlojAp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWcAJmAZIsJvVDuO7yFIBuUwyYyUC9hl6ZE+hs5yJSbrZOLQmdEwWDKADVzpU9k3/KovyYlTW4au7WauzMDn6XasOvTLh8HV0/QiheT8XiW4O2m3OU9drTU3eH/BFY2SYyYTFO5agTj4hAMYApEaM/50MwQLUwqozH4DdiEp3+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Zu74X5Bk reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 91d91d94e0e35301; Mon, 25 Mar 2024 18:06:27 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9F4D266BCFE;
	Mon, 25 Mar 2024 18:06:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711386387;
	bh=wxRwgptLJPCrasWZqmI2ge30NFdmDWXQzxRENlojAp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zu74X5BktZAcuMVOCmZMP1EHqXisjLO/RZ0h/7b3aHTfUqFRpZN0h5iVFiIYGPJzM
	 0FE7nLhjO9XXGPu5pNeUAYud7aIT8jBOj/k0xEBg5pCc0UxHmIUFgf4GCQBIIuzR/O
	 Qi28q+qzRvnphRmYJzdyxdn/OVy8bZM0QQ7ZaIZzQ5icR0ITc8b0ddVJhPI8exFHBw
	 z3HGTzzK0kKenGVqO1r3ZQ3GMBdqbvGzQJrvuXKWmQZT1RmK49Yma22QbUjZDt2C0u
	 NgHQ0o3nAEYYOOSkqt3SrGUCXUABXlayuC0/VVodd3IFq7TZZbet3aEMHtfIOpR33P
	 DrVOjnOCGsSHQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 4/6] cpufreq: intel_pstate: Read global.no_turbo under READ_ONCE()
Date: Mon, 25 Mar 2024 18:04:24 +0100
Message-ID: <22244552.EfDdHjke4D@kreacher>
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

Because global.no_turbo is generally not read under intel_pstate_driver_lock
make store_no_turbo() use WRITE_ONCE() for updating it (this is the only
place at which it is updated except for the initialization) and make the
majority of places reading it use READ_ONCE().

Also remove redundant global.turbo_disabled checks from places that
depend on the 'true' value of global.no_turbo because it can only be
'true' if global.turbo_disabled is also 'true'.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1296,7 +1296,7 @@ static ssize_t store_no_turbo(struct kob
 		goto unlock_driver;
 	}
 
-	global.no_turbo = no_turbo;
+	WRITE_ONCE(global.no_turbo, no_turbo);
 
 	mutex_lock(&intel_pstate_limits_lock);
 
@@ -1748,7 +1748,7 @@ static u64 atom_get_val(struct cpudata *
 	u32 vid;
 
 	val = (u64)pstate << 8;
-	if (global.no_turbo && !global.turbo_disabled)
+	if (READ_ONCE(global.no_turbo) && !global.turbo_disabled)
 		val |= (u64)1 << 32;
 
 	vid_fp = cpudata->vid.min + mul_fp(
@@ -1913,7 +1913,7 @@ static u64 core_get_val(struct cpudata *
 	u64 val;
 
 	val = (u64)pstate << 8;
-	if (global.no_turbo && !global.turbo_disabled)
+	if (READ_ONCE(global.no_turbo) && !global.turbo_disabled)
 		val |= (u64)1 << 32;
 
 	return val;
@@ -2211,7 +2211,7 @@ static inline int32_t get_target_pstate(
 
 	sample->busy_scaled = busy_frac * 100;
 
-	target = global.no_turbo || global.turbo_disabled ?
+	target = READ_ONCE(global.no_turbo) ?
 			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
 	target += target >> 2;
 	target = mul_fp(target, busy_frac);
@@ -2473,7 +2473,7 @@ static void intel_pstate_clear_update_ut
 
 static int intel_pstate_get_max_freq(struct cpudata *cpu)
 {
-	return global.turbo_disabled || global.no_turbo ?
+	return READ_ONCE(global.no_turbo) ?
 			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
 }
 
@@ -2610,7 +2610,7 @@ static void intel_pstate_verify_cpu_poli
 
 	if (hwp_active) {
 		intel_pstate_get_hwp_cap(cpu);
-		max_freq = global.no_turbo || global.turbo_disabled ?
+		max_freq = READ_ONCE(global.no_turbo) ?
 				cpu->pstate.max_freq : cpu->pstate.turbo_freq;
 	} else {
 		max_freq = intel_pstate_get_max_freq(cpu);




