Return-Path: <linux-kernel+bounces-139136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD2A89FEFE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0CBA282830
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CE0199EA4;
	Wed, 10 Apr 2024 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="iSoF/Hwu"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328A8181309;
	Wed, 10 Apr 2024 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771103; cv=none; b=TbrepkRF7kIOUossllGLUewx6YgTDt0+6RdTxO/GlfFJjllpX6xwHMYs/WNU3qX5S5y7dshX+IQVsa2r91xebstc48BwJIw+XU7kep/yg7viUCMTV8JfdNXlEA6ZC4aHLCHUPEZAcrsguvJKfX2ZDrPLD0e6ryGTXpIUBaWVOjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771103; c=relaxed/simple;
	bh=YLpF9evNNCyUp3zGlcL/ohUkidKwvzYeXfl48AqGi3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILFhHMzWcWp9hKdGSsZXwynKu8uVjgjL2TAfG/ZcNzYysI8/3xAb7ywIbF3JYeffD44cPSZ9r4nssCkUA9d8OLoZeI1PMCT51fyI7ztgcnGkroQp2X0/Iyv6I+CpxIFhuMA95fMV+RKoKD7swSPmYuXi76VxLfyVKOT/sBgkdMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=iSoF/Hwu reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id c608399947856aca; Wed, 10 Apr 2024 19:44:59 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 94A1166C66F;
	Wed, 10 Apr 2024 19:44:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712771099;
	bh=YLpF9evNNCyUp3zGlcL/ohUkidKwvzYeXfl48AqGi3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iSoF/HwujqWr2JuwIxmhENPrJ1m7up4GOmNJSM0wfYUEGdFsi9e7Q8+H/itVFelG2
	 +aYAT2O5m43rvwxg32QmF7OU0KE5D9AGvRGJ4tVyrVv5GloxUlWQ1Iu2X/uL+52NK3
	 5pTpnTK/8Sg/EnSpi68i8WXGG7ovcYIJ22/XpmSx5OAA58fPQgHGaTTaTMePiGfvhQ
	 6nLcUovReQgGKaQfiNSFgMHDNIN1RHIOLMFB1jzrcL9vCfKsF88FOl3JF/QOV1Qi8x
	 2iIjP0v5Fro9egX/1Ohl552GRxaRt7H1Pc3/lEneU0DyP/i4iIa+rIuIjhJlhduoQa
	 AzTpEEBBnHc/A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 04/16] thermal: gov_bang_bang: Fold thermal_zone_trip_update() into
 its caller
Date: Wed, 10 Apr 2024 18:06:34 +0200
Message-ID: <3827124.kQq0lBPeGt@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudehiedguddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepshhr
 ihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Fold thermal_zone_trip_update() into bang_bang_control() which is the
only caller of it to reduce code size and make it easier to follow.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_bang_bang.c |   75 +++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 42 deletions(-)

Index: linux-pm/drivers/thermal/gov_bang_bang.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_bang_bang.c
+++ linux-pm/drivers/thermal/gov_bang_bang.c
@@ -13,47 +13,6 @@
 
 #include "thermal_core.h"
 
-static void thermal_zone_trip_update(struct thermal_zone_device *tz,
-				     const struct thermal_trip *trip,
-				     bool crossed_up)
-{
-	struct thermal_instance *instance;
-
-	dev_dbg(&tz->device, "Trip%d[temp=%d]:temp=%d:hyst=%d\n",
-		thermal_zone_trip_id(tz, trip), trip->temperature,
-		tz->temperature, trip->hysteresis);
-
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip != trip)
-			continue;
-
-		if (instance->target == THERMAL_NO_TARGET)
-			instance->target = 0;
-
-		if (instance->target != 0 && instance->target != 1) {
-			pr_debug("Unexpected state %ld of thermal instance %s in bang-bang\n",
-				 instance->target, instance->name);
-
-			instance->target = 1;
-		}
-
-		/*
-		 * Enable the fan when the trip is crossed on the way up and
-		 * disable it when the trip is crossed on the way down.
-		 */
-		if (instance->target == 0 && crossed_up)
-			instance->target = 1;
-		else if (instance->target == 1 && !crossed_up)
-			instance->target = 0;
-
-		dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
-
-		mutex_lock(&instance->cdev->lock);
-		instance->cdev->updated = false; /* cdev needs update */
-		mutex_unlock(&instance->cdev->lock);
-	}
-}
-
 /**
  * bang_bang_control - controls devices associated with the given zone
  * @tz: thermal_zone_device
@@ -90,7 +49,39 @@ static void bang_bang_control(struct the
 
 	lockdep_assert_held(&tz->lock);
 
-	thermal_zone_trip_update(tz, trip, crossed_up);
+	dev_dbg(&tz->device, "Trip%d[temp=%d]:temp=%d:hyst=%d\n",
+		thermal_zone_trip_id(tz, trip), trip->temperature,
+		tz->temperature, trip->hysteresis);
+
+	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+		if (instance->trip != trip)
+			continue;
+
+		if (instance->target == THERMAL_NO_TARGET)
+			instance->target = 0;
+
+		if (instance->target != 0 && instance->target != 1) {
+			pr_debug("Unexpected state %ld of thermal instance %s in bang-bang\n",
+				 instance->target, instance->name);
+
+			instance->target = 1;
+		}
+
+		/*
+		 * Enable the fan when the trip is crossed on the way up and
+		 * disable it when the trip is crossed on the way down.
+		 */
+		if (instance->target == 0 && crossed_up)
+			instance->target = 1;
+		else if (instance->target == 1 && !crossed_up)
+			instance->target = 0;
+
+		dev_dbg(&instance->cdev->device, "target=%ld\n", instance->target);
+
+		mutex_lock(&instance->cdev->lock);
+		instance->cdev->updated = false; /* cdev needs update */
+		mutex_unlock(&instance->cdev->lock);
+	}
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
 		thermal_cdev_update(instance->cdev);




