Return-Path: <linux-kernel+bounces-110595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5084C886113
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830FD1C22210
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC15A134CE8;
	Thu, 21 Mar 2024 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="xwbGjCgW"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0E713443A;
	Thu, 21 Mar 2024 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049665; cv=none; b=aSGKAlPguILxiZnaC+9LdpmXCSR8yu2mG/0MgT0RKVemlsPW94cKG4V53Yn4I9PuAJ6Xu2ueC0RKVbtBImuXcMU0jyTBq3LqafIWoKuQqORqkPt02SvQzmXFSvRKNMmAn3q7hlNmdkQ68dM8Skl/Rdr0zHTZuG3GUNLyveRS90I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049665; c=relaxed/simple;
	bh=l6YDlruBqXA8oEDE4wbX76JTpsadDA/nfSwXgD/rC4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkeqDiPcIWi3sAIsk7NjF1FwffYG2kqan9leJ2GT1b3hbrjltgNWyEVVw9z6d94/RPKNVvvE7ooNzV9vwGKF3BluUMDm8vIjMfp8Rt4mI7IRpzCC7r7EBF0p/DRHpRlc7nF/aGkUs1+yR8ymeLb/Py4tMsjKFDOGQhxgOF4Gma4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=xwbGjCgW reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id f7c8c0852ae75439; Thu, 21 Mar 2024 20:34:14 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2024066B8D7;
	Thu, 21 Mar 2024 20:34:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711049654;
	bh=l6YDlruBqXA8oEDE4wbX76JTpsadDA/nfSwXgD/rC4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xwbGjCgWtStGSGXa2pWQwHeAgmPpL+j9fTpy2z0Y67PSJ7PJg/liA0tEmeZHf/AqK
	 Hfv+zVcp4zh0iPbMKgkzZ078HaAey/pv0BEJyqpkC2HlVVSY2ak7w3LVF/WpsfPXtT
	 NPYgzJXZsWXJkPuL+QSUzmodj7jHCji9R6ny7gV0plPsJnoFpKsjBuAd8qzC0Z7Bf2
	 xGev1HRK2YbAGhXb5iz8mFIakHaO5uxd4DI5PO5YkYtcJOv7oJLDYYm697IhGwLWNZ
	 eNIavXBTsAHxTNyiIEu2sDxPS8hjLHllJhpY7XOO5k/G+Ikcjpx4x9YdanmAalxeMh
	 0vF6VgIATZI0A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 4/5] cpufreq: intel_pstate: Get rid of unnecessary READ_ONCE()
 annotations
Date: Thu, 21 Mar 2024 20:33:02 +0100
Message-ID: <2184891.irdbgypaU6@kreacher>
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

Drop a redundant check involving READ_ONCE() from notify_hwp_interrupt()
and make it check hwp_active without READ_ONCE() which is not necessary,
because that variable is only set once during the early initialization of
the driver.

In order to make that clear, annotate hwp_active with __ro_after_init.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

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
@@ -1653,14 +1653,6 @@ void notify_hwp_interrupt(void)
 		goto ack_intr;
 
 	/*
-	 * Currently we never free all_cpu_data. And we can't reach here
-	 * without this allocated. But for safety for future changes, added
-	 * check.
-	 */
-	if (unlikely(!READ_ONCE(all_cpu_data)))
-		goto ack_intr;
-
-	/*
 	 * The free is done during cleanup, when cpufreq registry is failed.
 	 * We wouldn't be here if it fails on init or switch status. But for
 	 * future changes, added check.
@@ -3464,7 +3456,7 @@ static int __init intel_pstate_init(void
 		 * deal with it.
 		 */
 		if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) || hwp_forced) {
-			WRITE_ONCE(hwp_active, 1);
+			hwp_active = true;
 			hwp_mode_bdw = id->driver_data;
 			intel_pstate.attr = hwp_cpufreq_attrs;
 			intel_cpufreq.attr = hwp_cpufreq_attrs;




