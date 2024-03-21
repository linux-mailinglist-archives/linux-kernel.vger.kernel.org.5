Return-Path: <linux-kernel+bounces-110596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15B9886115
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E07F2850CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049D21350EB;
	Thu, 21 Mar 2024 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="YN19dssV"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F50D134412;
	Thu, 21 Mar 2024 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049666; cv=none; b=j4ZLJIlDA6O/d5+u9g3NSIVeiviqqeoldpvaSdRAP4lUnVBXtKarG/t4kUYm17YljK+GMtP+8h1rhMPbZkirXChuu9rYGmAHi8mIvw6o2O9x8aPfA3k6wiiJ86W9tkNt/Jp+TuMsxVIhS+ItntyoNWoRx+jqLT/iG8WEupV3PFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049666; c=relaxed/simple;
	bh=i1usLfR5NyS2UrfhcopXRBbPH/6dK9UVT3GxquuQz0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GugJK7TEEAE+JVLouompv2tyGOVvq2B84bKNfPjW6hMxqSewlR06UVxnyW/uqGG+QIvc2nSer577+uTYvNKjqVPqASR+EuioUG/53m66zSgkH84E6aJrkmBRX3+POVNZmzphEbSZrUqJtjvnY8LuzeuRss3HREcACePqY2Sdu90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=YN19dssV reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 9e9f95f3a11f2a70; Thu, 21 Mar 2024 20:34:16 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D73B166B8E0;
	Thu, 21 Mar 2024 20:34:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711049655;
	bh=i1usLfR5NyS2UrfhcopXRBbPH/6dK9UVT3GxquuQz0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YN19dssVABiz1hrNArxlVwcB5BiXpiVrzzQiuuF+M0AuK9Qs+QSHhhHkCkBMIuh06
	 3UY9MapSIWXSTLqdObOA8daYJEJAStGyOmwJ8aKbMZHy5Wlkkt1uQ3MZg/mH7m3JO5
	 v4JelW4lO99qhon1ZhBEoEcltmMn4+XDFjtDjOUu1mEvE2HD0Rg6JNpgUll1qW6N73
	 5mPCYuW4neAiIxVCqixoeuCTqEBOyvN+pXyym/PU0VhfUB7ob15ycOl3gOsfRy/SOe
	 k7svObfEBJbqAjZpScV+5f9bjohVrtubMycHJAfcxd5eAu3TgRkiyjNHlp62v7l1fJ
	 sDWN8hrzwlRlA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 3/5] cpufreq: intel_pstate: Wait for canceled delayed work to
 complete
Date: Thu, 21 Mar 2024 20:32:02 +0100
Message-ID: <4885534.GXAFRqVoOG@kreacher>
In-Reply-To: <12409658.O9o76ZdvQC@kreacher>
References: <12409658.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrleejgdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make intel_pstate_disable_hwp_interrupt() wait for canceled delayed work
to complete to avoid leftover work items running when it returns which
may be during driver unregistration and may confuse things going forward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1682,6 +1682,8 @@ ack_intr:
 
 static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
 {
+	bool cancel_work;
+
 	if (!boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
 		return;
 
@@ -1689,9 +1691,11 @@ static void intel_pstate_disable_hwp_int
 	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
 
 	spin_lock_irq(&hwp_notify_lock);
-	if (cpumask_test_and_clear_cpu(cpudata->cpu, &hwp_intr_enable_mask))
-		cancel_delayed_work(&cpudata->hwp_notify_work);
+	cancel_work = cpumask_test_and_clear_cpu(cpudata->cpu, &hwp_intr_enable_mask);
 	spin_unlock_irq(&hwp_notify_lock);
+
+	if (cancel_work)
+		cancel_delayed_work_sync(&cpudata->hwp_notify_work);
 }
 
 static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)




