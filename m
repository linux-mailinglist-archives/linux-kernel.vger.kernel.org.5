Return-Path: <linux-kernel+bounces-139123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA1D89FEEE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42DA1F24342
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B375181CEF;
	Wed, 10 Apr 2024 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="s6bQKZwO"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107E817F36E;
	Wed, 10 Apr 2024 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771099; cv=none; b=Ly7+vT1VZbb4OWP6t1VvGxXCOud8BNKKToPugf8/yS0k/7oB1+dZOzNfubBIAf1HFFXlMZ2Sa0H+jzEpQnhJOpYBM1K+sY2Z9oaocFI8CIBbjRZiCLav9GlFO9RJZzByQGvsCMYU+2Sf441q5X5S5PcyTsQxlWqvHudGvl1Nx9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771099; c=relaxed/simple;
	bh=NA5yrW51H85dk5WAOZypgvfcgjWO3737t7jPzppEXU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSdXkQ0I2YAypFvhGLiYVGp2YyZDXf5RniMsSPLxs/mXLOKQ6yMYZF/lp4+JFRHDYgGcnhgqX2/UTIJK3eihmYiB/jV7mh9zyswrCNNgIfugUCWcF4RZCkKcNauljQzd2zehTrcuvW8TdH0Md9cJb6kj7JqNw9GAVbR3Xi4JiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=s6bQKZwO reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 28e78abd95b63886; Wed, 10 Apr 2024 19:44:55 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7676066C66F;
	Wed, 10 Apr 2024 19:44:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712771094;
	bh=NA5yrW51H85dk5WAOZypgvfcgjWO3737t7jPzppEXU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=s6bQKZwOpEprs7BFpzU29yApt4Qr/EV78+9DKe7LPrVIXeFB5mOEsRdtmU6Skq+gl
	 J10Jy+ifbUlQtVEBrYKoG0tzIguMt410tgDHkHXhHbKeMhtE7N5ASTpDebe9T+lmuO
	 F6gHd1twOj8Vr3NhHobW9U4otfth7f5W2up5RpY8WZY3FGrQVpjB2/id1DtKeZ8ZTB
	 rlCbSQ0u1YNDE6+O8xC/Job1GBKl1eW+1gsfwIxrqGazkABOzRXVMbFMEdMS+dEBph
	 cnlpFZaFR4vLGs9iiQizM8aIkQrlTtcb42qmzV1lUjolnua24PLLbFh026ZE2uXPqk
	 pnuNHDoJwe0Dg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 08/16] thermal: gov_step_wise: Use .manage() callback instead of
 .throttle()
Date: Wed, 10 Apr 2024 18:13:55 +0200
Message-ID: <2628456.Lt9SDvczpP@kreacher>
In-Reply-To: <13515747.uLZWGnKmhe@kreacher>
References: <13515747.uLZWGnKmhe@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudehiedguddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepshhr
 ihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the Step-Wise governor use the new .manage() callback instead of
throttle().

Even though using .throttle() is not particularly problematic for the
Step-Wise governor, using .manage() instead still allows it to reduce
overhead by updating all of the colling devices once after setting
target values for all of the thermal instances.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_step_wise.c |   39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/thermal/gov_step_wise.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_step_wise.c
+++ linux-pm/drivers/thermal/gov_step_wise.c
@@ -109,34 +109,37 @@ static void thermal_zone_trip_update(str
 	}
 }
 
-/**
- * step_wise_throttle - throttles devices associated with the given zone
- * @tz: thermal_zone_device
- * @trip: trip point
- *
- * Throttling Logic: This uses the trend of the thermal zone to throttle.
- * If the thermal zone is 'heating up' this throttles all the cooling
- * devices associated with the zone and its particular trip point, by one
- * step. If the zone is 'cooling down' it brings back the performance of
- * the devices by one step.
- */
-static int step_wise_throttle(struct thermal_zone_device *tz,
-			      const struct thermal_trip *trip)
+static void step_wise_manage(struct thermal_zone_device *tz)
 {
+	const struct thermal_trip_desc *td;
 	struct thermal_instance *instance;
 
 	lockdep_assert_held(&tz->lock);
 
-	thermal_zone_trip_update(tz, trip);
+	/*
+	 * Throttling Logic: Use the trend of the thermal zone to throttle.
+	 * If the thermal zone is 'heating up', throttle all of the cooling
+	 * devices associated with each trip point by one step. If the zone
+	 * is 'cooling down', it brings back the performance of the devices
+	 * by one step.
+	 */
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip = &td->trip;
+
+		if (trip->temperature == THERMAL_TEMP_INVALID ||
+		    trip->type == THERMAL_TRIP_CRITICAL ||
+		    trip->type == THERMAL_TRIP_HOT)
+			continue;
+
+		thermal_zone_trip_update(tz, trip);
+	}
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
 		thermal_cdev_update(instance->cdev);
-
-	return 0;
 }
 
 static struct thermal_governor thermal_gov_step_wise = {
-	.name		= "step_wise",
-	.throttle	= step_wise_throttle,
+	.name	= "step_wise",
+	.manage	= step_wise_manage,
 };
 THERMAL_GOVERNOR_DECLARE(thermal_gov_step_wise);




