Return-Path: <linux-kernel+bounces-139122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F54689FEDF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC752837F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D72F180A74;
	Wed, 10 Apr 2024 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Xvva4Fug"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CA017F36C;
	Wed, 10 Apr 2024 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771099; cv=none; b=JGgUYnHO5R2qhbLSEG9AzsbtFKqGHMybKKfZAhwANkmdSNV5s94DxwqGCSJXWN5WEqEWxd/J/AKCJYtX2L1bqaaNwIH3cpkNJLheOSoBATMEudydLPiDJA08I8DeX/YMykQxfVZaJ6qqrbPH5j6SJb3OEBqwI6rupeiSL3U8y2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771099; c=relaxed/simple;
	bh=Y9txkjDSbtFrAISOZH1vpS6A74vk4UuwMFg9JEKjUSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=th2kH5q4xrCKIP1SOYsDyL6zF0V1d7tCXH9Prwyt4bwymcuxLA4UPjDf43y711DL9x62hdORXsB8EpWJ9oXSOHAGT1UYF2QBjcM1WbJlAK5BJkI+Fa1nUIhp7z0S1p6tdFhFu85+NrRESvY81IqZrOJyL6dlQH1E4wmp6DjqN08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Xvva4Fug reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 2595fb2821a297ed; Wed, 10 Apr 2024 19:44:48 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 34CA866C66F;
	Wed, 10 Apr 2024 19:44:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712771088;
	bh=Y9txkjDSbtFrAISOZH1vpS6A74vk4UuwMFg9JEKjUSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xvva4FugISWys5Xza+5eU2r9epAW26a5L+sOmS0/GiHyNnXo+3OF/o3j3ixHlpxAy
	 3Va9NOd4BVEuJ16BLIze/Ps4YK01urHuc6BOw1vx5w7XhFPI+c5O/0sEGsXY2dINx3
	 hR0XOipLgMxS9uWpsm71P12sFzyYtjsXYRndtnBCaAkffajjbhi2LReD7BO0+p2+bZ
	 Sgb/LuZu92aE6dVWn97zBT9r3GtDStYHbsTGm8U/AU0cXyANYkLlZiF789d2CC6XXV
	 pzzzEJD1WEtjwA6M80GWrlefQppuy16T0Ond5gqTFO2fO7/ZrUDze6b9P8TjuUsAmo
	 aI0EUcke1vkqg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 15/16] thermal: core: Drop the .throttle() governor callback
Date: Wed, 10 Apr 2024 19:42:35 +0200
Message-ID: <2701448.BddDVKsqQX@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudehiedguddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepshhr
 ihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since all of the governors in the tree have been switched over to using
the new callbacks, either .trip_crossed() or .manage(), the .throttle()
governor callback is not used any more, so drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   11 -----------
 drivers/thermal/thermal_core.h |    4 ----
 2 files changed, 15 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -310,15 +310,6 @@ static struct thermal_governor *thermal_
 	return def_governor;
 }
 
-static void handle_non_critical_trips(struct thermal_zone_device *tz,
-				      const struct thermal_trip *trip)
-{
-	struct thermal_governor *governor = thermal_get_tz_governor(tz);
-
-	if (governor->throttle)
-		governor->throttle(tz, trip);
-}
-
 void thermal_governor_update_tz(struct thermal_zone_device *tz,
 				enum thermal_notify_event reason)
 {
@@ -418,8 +409,6 @@ static void handle_thermal_trip(struct t
 
 	if (trip->type == THERMAL_TRIP_CRITICAL || trip->type == THERMAL_TRIP_HOT)
 		handle_critical_trips(tz, trip);
-	else
-		handle_non_critical_trips(tz, trip);
 }
 
 static void update_temperature(struct thermal_zone_device *tz)
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -32,8 +32,6 @@ struct thermal_trip_desc {
  *			thermal zone.
  * @trip_crossed:	called for trip points that have just been crossed
  * @manage:	called on thermal zone temperature updates
- * @throttle:	callback called for every trip point even if temperature is
- *		below the trip point temperature
  * @update_tz:	callback called when thermal zone internals have changed, e.g.
  *		thermal cooling instance was added/removed
  * @governor_list:	node in thermal_governor_list (in thermal_core.c)
@@ -46,8 +44,6 @@ struct thermal_governor {
 			     const struct thermal_trip *trip,
 			     bool crossed_up);
 	void (*manage)(struct thermal_zone_device *tz);
-	int (*throttle)(struct thermal_zone_device *tz,
-			const struct thermal_trip *trip);
 	void (*update_tz)(struct thermal_zone_device *tz,
 			  enum thermal_notify_event reason);
 	struct list_head	governor_list;




