Return-Path: <linux-kernel+bounces-117542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D44088AC63
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08942C34AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7056E12BE87;
	Mon, 25 Mar 2024 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Y/bF2eMJ"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A406C71B52;
	Mon, 25 Mar 2024 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386393; cv=none; b=YNkAQRLdQEETRQnMqayOcdpX/f7jBnHfZGmc60W2xTnzK1lH0QvXVDwHuMwMGonoGqKwAabVdyDk281eLExAoEn2zTUhO9vAFqr2GyQ7vBsbpxR0puclxAt2SLFl54EETUeE2S420zXMOkRmXJ7754OTWK2a+YS29XVav8Hr6I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386393; c=relaxed/simple;
	bh=lZ2ADGkGSXJYxvx17bX1oYw2MgDp/Tjhetn+uOngFP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XjNe1k7U1k0FacqDzGO9Xs+qTypqxa3UoZOC5KS31zTsJN0974+otiom5Of00vb62Y9hV75AyXobDY0kOSvuYDztwQw5IwH7b6wtU7XLJBukLHQoa9SMhL+fWryPav7oJ7oVvrk+A3genqTAtj2ncnAF+AdB0lfas9oUR7FRI4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Y/bF2eMJ reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 5a06f3efee13d21f; Mon, 25 Mar 2024 18:06:29 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0D2CE66BCFE;
	Mon, 25 Mar 2024 18:06:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711386389;
	bh=lZ2ADGkGSXJYxvx17bX1oYw2MgDp/Tjhetn+uOngFP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y/bF2eMJJtEV1rGeaT4+XLiN31Am3Ylmjkrf4AU8d6/cR010pRNeY5dr9jORM/CNe
	 Y4a8cC8M5Ub454SdKOU6RhuliNb7pA2Y9ngDU/MSilp0WWF6ajMFHuLa61epsfxpRg
	 wQ2aFCMwQxejtzwwWzhSXpQ5eD/UzClPaDfPjuz7AzZcScUlurwmeUYo0L5z4Lgkmo
	 ilboju+yFq9fw9j0EF3X4PpVozU7xD4K7dDaYlTLKwhcFWXf58LlL1BhD8G/zFk9n6
	 T7uyeWoLoegy/X8UYDIGwa8atFZTf+jTZvA6Fp0SEHr0IxFxkP7+3o8IImASL0MsLi
	 DIFnoh8Fsl6uA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 1/6] cpufreq: intel_pstate: Fold intel_pstate_max_within_limits()
 into caller
Date: Mon, 25 Mar 2024 18:01:58 +0100
Message-ID: <3297274.aeNJFYEL58@kreacher>
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

Fold intel_pstate_max_within_limits() into its only caller.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2012,14 +2012,6 @@ static void intel_pstate_set_min_pstate(
 	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate);
 }
 
-static void intel_pstate_max_within_limits(struct cpudata *cpu)
-{
-	int pstate = max(cpu->pstate.min_pstate, cpu->max_perf_ratio);
-
-	update_turbo_state();
-	intel_pstate_set_pstate(cpu, pstate);
-}
-
 static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 {
 	int perf_ctl_max_phys = pstate_funcs.get_max_physical(cpu->cpu);
@@ -2594,12 +2586,15 @@ static int intel_pstate_set_policy(struc
 	intel_pstate_update_perf_limits(cpu, policy->min, policy->max);
 
 	if (cpu->policy == CPUFREQ_POLICY_PERFORMANCE) {
+		int pstate = max(cpu->pstate.min_pstate, cpu->max_perf_ratio);
+
 		/*
 		 * NOHZ_FULL CPUs need this as the governor callback may not
 		 * be invoked on them.
 		 */
 		intel_pstate_clear_update_util_hook(policy->cpu);
-		intel_pstate_max_within_limits(cpu);
+		update_turbo_state();
+		intel_pstate_set_pstate(cpu, pstate);
 	} else {
 		intel_pstate_set_update_util_hook(policy->cpu);
 	}




