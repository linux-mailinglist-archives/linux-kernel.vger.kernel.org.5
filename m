Return-Path: <linux-kernel+bounces-110594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A5A886112
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC4E2843C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462BD134CC0;
	Thu, 21 Mar 2024 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="htCm/ieb"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A513442F;
	Thu, 21 Mar 2024 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049664; cv=none; b=pjyYd4xvsZKFxRnA3+jbIaMzlmdh8XQ55zv66wzJwx42UgNOrH77XhLM7UrmT4CIreU1F3qkjlYV0PqkGyefREZTaiPO+U3jNy/d9X2Dr9hFL3vFYcngbR/VCZ6b+lzCnJEITrrLqozkqPq7CkBPMkg+bINRZlpY4VWEdpOrgKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049664; c=relaxed/simple;
	bh=HdVPAGPeWYrzxVmTi5wEQzoohLlmdDTL9D8CQkDRM7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8gzRz0Y/XNug7q3oWmytUOaGuYVkI6usIe/FAhkM81JXcWvKqcFMxtNFWKTcn5fqCzsJp1QrRV47O19TZoPap3Fx6rh1/Qfki6tQnHproLDJV+r2g3hCSm2keD0167Nl360sXu8bfWk+Y2lZV7RjQw0nTlRSMTw0A2A8fRcx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=htCm/ieb reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id b53c8d51296cc07e; Thu, 21 Mar 2024 20:34:13 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3ABDC66B8D7;
	Thu, 21 Mar 2024 20:34:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711049653;
	bh=HdVPAGPeWYrzxVmTi5wEQzoohLlmdDTL9D8CQkDRM7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=htCm/iebY6c7itmQkuu390V9w8w59432s5iVHp6krlEAT/0lyEro8X3TiM5pu8tvV
	 Ofcoo8At1dQzYdcYgTK13kD4J4TuGpCz8nZkxc/4PVDPeFGt6Eg3kg5Qgp4ihrFTyo
	 fmVKe8S2P9jt9EQQiL+qXfsg64ROKSwmagJTipp2SWckQ0assnWlonqcfbCna14rMh
	 ZzrnfpIJqEEl8DRZu7bqpexJL6FWOh2mGxX2hQWuxN3uTuXL58XqPW7uGouGcD5vbh
	 CIiLrHMaAcrB7Od3FPe1GxZDYaJK4y/r8fFBM+ILpFFP7TONBxsV4WzBqIW28GPbzb
	 hO6QzOhh7uosg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 5/5] cpufreq: intel_pstate: Use __ro_after_init for three variables
Date: Thu, 21 Mar 2024 20:34:06 +0100
Message-ID: <2935621.e9J7NaK4W3@kreacher>
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

There are at least 3 variables in intel_pstate that do not get updated
after they have been initialized, so annotate them with __ro_after_init.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -293,10 +293,10 @@ struct pstate_funcs {
 static struct pstate_funcs pstate_funcs __read_mostly;
 
 static bool hwp_active __ro_after_init;
-static int hwp_mode_bdw __read_mostly;
-static bool per_cpu_limits __read_mostly;
+static int hwp_mode_bdw __ro_after_init;
+static bool per_cpu_limits __ro_after_init;
+static bool hwp_forced __ro_after_init;
 static bool hwp_boost __read_mostly;
-static bool hwp_forced __read_mostly;
 
 static struct cpufreq_driver *intel_pstate_driver __read_mostly;
 




