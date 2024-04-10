Return-Path: <linux-kernel+bounces-139135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3397A89FEFF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B1AB21A91
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A177F199EA3;
	Wed, 10 Apr 2024 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="MxQ2yLXg"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A48D1802D6;
	Wed, 10 Apr 2024 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771103; cv=none; b=nj9JFi9upBNoxEFSXH4Cq2tJi9MasWiatzNMgI6Tng1jFCbR0RBiSIEosW9pgyFSk9wSdMNIl0vx1Y6V2e9yPOr5WRPa1XLIssUVmD5mRkwGoSLe04QkqXam6Td9j8r7UwlxxRnGPhjkdy8mKVp3KYTe812iHCrrsK6BOLMw2qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771103; c=relaxed/simple;
	bh=7gKWhycZmUjTMJkPd/ZDFGuQf2EeEblQmHNOYDf0bmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SbDUBj9Og6S3zEN94Muwai6dd4gbAIrdiBbt6lyvBX4hnqiXm/wHjVBI0/UF8oTSaxVmbN8kfH0nD5R/RKc5F6Q8n6kc364jHszhizSb5/hQ8U0M7jY6vAe3AKwrB6XX/OGx6NlsG+Y/z4vS5Aq46nmNefiITO8hhYImcGCxJ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=MxQ2yLXg reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id ba490e62e58493f8; Wed, 10 Apr 2024 19:44:52 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id DCB8A66C66F;
	Wed, 10 Apr 2024 19:44:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712771092;
	bh=7gKWhycZmUjTMJkPd/ZDFGuQf2EeEblQmHNOYDf0bmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MxQ2yLXgDS6P/McDyoK30LNF31tyFQP8krWVDW1BqXRxT9nlV1m50Sot9JAFwPWJw
	 6NFKg83CF4I1bk3k5Mkhi4j/ymKP+giuI3nVh+vZpxNrbLj6ZwKyKyI/4Sd2fDTQaf
	 5+u8nzIbKfwYZwMxRvKjo896HDtZ5jR17lFMnxzzjiioy3dNk1T0dbc0vjDztnQgzd
	 b3JkxjcHuVNXOftOF0791IeENOTgx65p/B2JejTygB+I5rWjUWdfhxuTpLJ9HTxxP9
	 /L3N524ysVxDLAg88Qx21X3YUI1odJDgJ+81KpK/n3I5Zaakx1fsivxmbIow/H6MDJ
	 bkEEdftpzybpQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 11/16] thermal: gov_fair_share: Use .manage() callback instead of
 .throttle()
Date: Wed, 10 Apr 2024 18:57:38 +0200
Message-ID: <2411572.NG923GbCHz@kreacher>
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

The Fair Share governor tries very hard to be stateless and so it
calls get_trip_level() from fair_share_throttle() every time, even
though the number produced by this function for all of the trips
during a given thermal zone update is actually the same.  Since
get_trip_level() walks all of the trips in the thermal zone every
time it is called, doing this may generate quite a bit of completely
useless overhead.

For this reason, make the governor use the new .manage() callback
instead of .throttle() which allows it to call get_trip_level() just
once and use the value computed by it to handle all of the trips.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_fair_share.c |   37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/thermal/gov_fair_share.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_fair_share.c
+++ linux-pm/drivers/thermal/gov_fair_share.c
@@ -53,6 +53,7 @@ static long get_target_state(struct ther
  * fair_share_throttle - throttles devices associated with the given zone
  * @tz: thermal_zone_device
  * @trip: trip point
+ * @trip_level: number of trips crossed by the zone temperature
  *
  * Throttling Logic: This uses three parameters to calculate the new
  * throttle state of the cooling devices associated with the given zone.
@@ -61,22 +62,19 @@ static long get_target_state(struct ther
  * P1. max_state: Maximum throttle state exposed by the cooling device.
  * P2. percentage[i]/100:
  *	How 'effective' the 'i'th device is, in cooling the given zone.
- * P3. cur_trip_level/max_no_of_trips:
+ * P3. trip_level/max_no_of_trips:
  *	This describes the extent to which the devices should be throttled.
  *	We do not want to throttle too much when we trip a lower temperature,
  *	whereas the throttling is at full swing if we trip critical levels.
- *	(Heavily assumes the trip points are in ascending order)
  * new_state of cooling device = P3 * P2 * P1
  */
-static int fair_share_throttle(struct thermal_zone_device *tz,
-			       const struct thermal_trip *trip)
+static void fair_share_throttle(struct thermal_zone_device *tz,
+				const struct thermal_trip *trip,
+				int trip_level)
 {
 	struct thermal_instance *instance;
 	int total_weight = 0;
 	int total_instance = 0;
-	int cur_trip_level = get_trip_level(tz);
-
-	lockdep_assert_held(&tz->lock);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if (instance->trip != trip)
@@ -99,18 +97,35 @@ static int fair_share_throttle(struct th
 			percentage = (instance->weight * 100) / total_weight;
 
 		instance->target = get_target_state(tz, cdev, percentage,
-						    cur_trip_level);
+						    trip_level);
 
 		mutex_lock(&cdev->lock);
 		__thermal_cdev_update(cdev);
 		mutex_unlock(&cdev->lock);
 	}
+}
 
-	return 0;
+static void fair_share_manage(struct thermal_zone_device *tz)
+{
+	int trip_level = get_trip_level(tz);
+	const struct thermal_trip_desc *td;
+
+	lockdep_assert_held(&tz->lock);
+
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip = &td->trip;
+
+		if (trip->temperature == THERMAL_TEMP_INVALID ||
+		    trip->type == THERMAL_TRIP_CRITICAL ||
+		    trip->type == THERMAL_TRIP_HOT)
+			continue;
+
+		fair_share_throttle(tz, trip, trip_level);
+	}
 }
 
 static struct thermal_governor thermal_gov_fair_share = {
-	.name		= "fair_share",
-	.throttle	= fair_share_throttle,
+	.name	= "fair_share",
+	.manage	= fair_share_manage,
 };
 THERMAL_GOVERNOR_DECLARE(thermal_gov_fair_share);




