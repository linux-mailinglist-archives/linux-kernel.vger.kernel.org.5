Return-Path: <linux-kernel+bounces-123449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9D38908D5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D601F22A01
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8EE13791D;
	Thu, 28 Mar 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Z1SlBYNN"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F265338F;
	Thu, 28 Mar 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711652544; cv=none; b=BZfxT8eAuzMrXHi/g3W8pqgWgE49wreGqZCp5k8ebMJSh6S1c38vQvi90b8Rq4DGnzhBFTrkbLui/9SZpgAE3MR7n5lOsX83U2GrsRqJNkd0J4D7ztsgWR/I5LQkdkWpj6J2uM9sxVNcYZov4TGvwCyvklZbakMlhSLJFSUsh5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711652544; c=relaxed/simple;
	bh=BJhan4nNEvDPO7IwX+c05Qg9xHwiLb9UN1oaP3pWkn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qle0XHUs6M0BUizgF90EIE7RMdz5PRbif3JYBxTYsyQaqn7uLouAWcU3QLzLwA6AZWUBUIrl6RMDRbHc8GN9pZStV1HZ7c2VIxnJtga80s8ehUc6HwYnVUlylBd2lszKbhrQwMmSJF6zfvLVyjSiRNOE493PPcy2AxJu+MJiv3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Z1SlBYNN reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 99ba159edb798562; Thu, 28 Mar 2024 20:02:19 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CD12666C25F;
	Thu, 28 Mar 2024 20:02:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711652539;
	bh=BJhan4nNEvDPO7IwX+c05Qg9xHwiLb9UN1oaP3pWkn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z1SlBYNNd+YKNuqZEhBSXVEol1f5dCJpSrVZJUxKBchPivj+SWZacjZHjR/vqmIpU
	 6r+YN6c71Nr3l9dIAaPqPzyDc+y1s4A83bvpWMvn23hH88/f5sqTY3EtSkTKygJk2p
	 /8tklU1C+XMbA1xa7qHFyOZpo15D5vmEPzxSxFQmnAY3YgAWikHwj+oPPwFM/gZH3+
	 vrcnfviAvV/Jn/dWdMVCU4IFg1jZfd1s+ntr0dDO1eE+V36O8ZZlMjso24kZPi/qcf
	 dP639SXzCQKLwSWaNofu+BVbS0p21lFG92ewkcjgx6kz/8MjSzId4sjkrZrFXIS3fo
	 GIsQtOu7fo8Uw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1.1 6/6] cpufreq: intel_pstate: Update the maximum CPU frequency
 consistently
Date: Thu, 28 Mar 2024 20:02:18 +0100
Message-ID: <6059426.lOV4Wx5bFT@kreacher>
In-Reply-To: <9269494.CDJkKcVGEf@kreacher>
References: <13494237.uLZWGnKmhe@kreacher> <9269494.CDJkKcVGEf@kreacher>
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

There are 3 places at which the maximum CPU frequency may change,
store_no_turbo(), intel_pstate_update_limits() (when called by the
cpufreq core) and intel_pstate_notify_work() (when handling a HWP
change notification).  Currently, cpuinfo.max_freq is only updated by
store_no_turbo() and intel_pstate_notify_work(), although it principle
it may be necessary to update it in intel_pstate_update_limits() either.

Make all of them mutually consistent.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v1.1: Fix changelog (Srinivas).

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




