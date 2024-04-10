Return-Path: <linux-kernel+bounces-139139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AB889FF02
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47391C22E4F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233FA19DF46;
	Wed, 10 Apr 2024 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="SRhvLYbz"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D741836C0;
	Wed, 10 Apr 2024 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771106; cv=none; b=okwRsNrwFaVSXFF2eo20i0jl3RltcSlqUiktE7ba7cAFxFKstIWqom+Xw+ylU36IYTHBrdfn2u/Hi4FpLIoRZj5msK0rS/anN3SptkKcmiqnnTvIbrSXGMkr0RWuw7RgLqRLO8PnqU6qAtlLYRRFvKBjT+IuCyA58ebphf0rNtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771106; c=relaxed/simple;
	bh=O4fc6NcbFmDtcu5Mpz4hlacgxv2TpLc3B9RGa8Nme0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fuWcxxuUnjRagF9zPq/ukzDTeNcJhqQfmt1ybzkLLTGvhT31XsQAYz8JX6MnqS3PnnlqJ2VXm7/gcxINBmWJic3XXtzHUH/z/5iDTsinoTfkQn+WuiXohA0PH3kQSToxtBFP7gMk17AlPK7urNEVo24sP35jePESjgkn8E6aCn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=SRhvLYbz reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id bb772444a988b3f5; Wed, 10 Apr 2024 19:45:00 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 31B2666C66F;
	Wed, 10 Apr 2024 19:45:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712771100;
	bh=O4fc6NcbFmDtcu5Mpz4hlacgxv2TpLc3B9RGa8Nme0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SRhvLYbzwUbjbbB+rh71vwG0EtJ9YzgpOngRxzfdN/W2k4R1cTGiSM6Ojd96fiHnk
	 gAs8MqLt+9dXZ7Q1+YdfFHURbUvmfB6S7PwpOo9TV85i2cZmBqnvwgnevA8sY3CyKP
	 LWzA018gPOwTB3N6LD4q1VzfPmAoEXqT4fsNQWLTRr6uxkhjYSQQAZh1DDj+3giJkU
	 jV0+/H4XY5FnYGsOPdKMsfYnIGqUCSOdFwBOwpImUCyd+n8QYXmhr+D8BUKZGNPgiq
	 rhjF1gOiIfvAwK7PrOs0GFTQh1MXl8qgVSjsYX8lXGNNyO04420Sff0Nh1E0AQX94I
	 Bzng0OWja8fPA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 02/16] thermal: gov_bang_bang: Use .trip_crossed() instead of
 .throttle()
Date: Wed, 10 Apr 2024 18:04:39 +0200
Message-ID: <2289003.iZASKD2KPV@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudehiedguddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepshhr
 ihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The Bang-Bang governor really is only concerned about trip point
crossing, so it can use the new .trip_crossed() callback instead of
throttle() that is not particularly suitable for it.

Modify it to do so which also takes trip hysteresis into account, so the
governor does not need to use it directly any more.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_bang_bang.c |   31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/thermal/gov_bang_bang.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_bang_bang.c
+++ linux-pm/drivers/thermal/gov_bang_bang.c
@@ -13,8 +13,9 @@
 
 #include "thermal_core.h"
 
-static int thermal_zone_trip_update(struct thermal_zone_device *tz,
-				    const struct thermal_trip *trip)
+static void thermal_zone_trip_update(struct thermal_zone_device *tz,
+				     const struct thermal_trip *trip,
+				     bool crossed_up)
 {
 	int trip_index = thermal_zone_trip_id(tz, trip);
 	struct thermal_instance *instance;
@@ -43,13 +44,12 @@ static int thermal_zone_trip_update(stru
 		}
 
 		/*
-		 * enable fan when temperature exceeds trip_temp and disable
-		 * the fan in case it falls below trip_temp minus hysteresis
+		 * Enable the fan when the trip is crossed on the way up and
+		 * disable it when the trip is crossed on the way down.
 		 */
-		if (instance->target == 0 && tz->temperature >= trip->temperature)
+		if (instance->target == 0 && crossed_up)
 			instance->target = 1;
-		else if (instance->target == 1 &&
-			 tz->temperature < trip->temperature - trip->hysteresis)
+		else if (instance->target == 1 && !crossed_up)
 			instance->target = 0;
 
 		dev_dbg(&instance->cdev->device, "target=%d\n",
@@ -59,14 +59,13 @@ static int thermal_zone_trip_update(stru
 		instance->cdev->updated = false; /* cdev needs update */
 		mutex_unlock(&instance->cdev->lock);
 	}
-
-	return 0;
 }
 
 /**
  * bang_bang_control - controls devices associated with the given zone
  * @tz: thermal_zone_device
  * @trip: the trip point
+ * @crossed_up: whether or not the trip has been crossed on the way up
  *
  * Regulation Logic: a two point regulation, deliver cooling state depending
  * on the previous state shown in this diagram:
@@ -90,26 +89,22 @@ static int thermal_zone_trip_update(stru
  *     (trip_temp - hyst) so that the fan gets turned off again.
  *
  */
-static int bang_bang_control(struct thermal_zone_device *tz,
-			     const struct thermal_trip *trip)
+static void bang_bang_control(struct thermal_zone_device *tz,
+			      const struct thermal_trip *trip,
+			      bool crossed_up)
 {
 	struct thermal_instance *instance;
-	int ret;
 
 	lockdep_assert_held(&tz->lock);
 
-	ret = thermal_zone_trip_update(tz, trip);
-	if (ret)
-		return ret;
+	thermal_zone_trip_update(tz, trip, crossed_up);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
 		thermal_cdev_update(instance->cdev);
-
-	return 0;
 }
 
 static struct thermal_governor thermal_gov_bang_bang = {
 	.name		= "bang_bang",
-	.throttle	= bang_bang_control,
+	.trip_crossed	= bang_bang_control,
 };
 THERMAL_GOVERNOR_DECLARE(thermal_gov_bang_bang);




