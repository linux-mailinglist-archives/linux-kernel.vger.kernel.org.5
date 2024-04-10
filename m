Return-Path: <linux-kernel+bounces-139124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B370989FEED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A6E1C23213
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0A7181CEB;
	Wed, 10 Apr 2024 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="M3OuAZmo"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EDC17F36B;
	Wed, 10 Apr 2024 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771099; cv=none; b=iOeydLCTZefl58A4PGBDmXy45fl4kUm361XR7WMNtS24vys6Xg1rAM5ekr948WBGKPfHNCCiG9jG9n0GA7rboSF+6CNnfR+kaPX19eahHhp65IRnknIJnxbRUfSK55YR6GjhnFtsgpfcUarDYALieo2AP+bYvPX1mCVbhaxnRUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771099; c=relaxed/simple;
	bh=6ytj9DA2mXccOWmIrWdStZbef+qLEGZrkbosfSivSz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvggQ9cggfeuO7AcstDT53D+2iQNX9eMP8+4JjKWilLZCeDPDOgoXLNs0hAqOli2xW5w8UvepyMX6dz0zwct1hnz+A/d8iayLEEZEsBsAOWIrH9k7SIuAmsJ4WJOla3Yw2yYJN7Nzjia3jHFy/EyOmuL9Wj4oAvvRJS6LduTyQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=M3OuAZmo reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 08b050b7cb17d430; Wed, 10 Apr 2024 19:44:54 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A09E766C66F;
	Wed, 10 Apr 2024 19:44:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712771094;
	bh=6ytj9DA2mXccOWmIrWdStZbef+qLEGZrkbosfSivSz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M3OuAZmoCwrUIRv+om+PU5ix93rnpCxQlpPugkVbZBrFRtX9/lyou8hi4JdbsoV0B
	 mD0keTs2qWvAXT8IkhXNuCsFtTKVLLWYAi9U6Iur1lCqyAEbaq9MDqeCveryPOVB/y
	 ps3KHMKQ1TAQEEUoh9t5KNozVIMwsR8nb0gPw05hu3PQ/PVfKQhOKIiiYZS5sMPTqg
	 x2hEwbaBkFx1yFhD2sRkwyrOrBo4mQZsSBfSLsWfsd1LQIdiOWvfK8cceYsQlzlNa+
	 yVq0Q2aiPEzn3ZqeZHgKi+SVnX6BIP2LsFS4ETjTW1Ft7pobSHP7nv7siVcDY41p4m
	 j9GYYFx6nb8WA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 09/16] thermal: gov_step_wise: Use trip thresholds instead of trip
 temperatures
Date: Wed, 10 Apr 2024 18:43:07 +0200
Message-ID: <3769085.MHq7AAxBmi@kreacher>
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

In principle, the Step-Wise governor should take trip hystereses into
account.  After all, once a trip has been crossed on the way up,
mitigation is still needed until it is crossed on the way down.

For this reason, make it use trip thresholds that are computed by
the core when trips are crossed, so as to apply mitigations in the
hysteresis rages of trips that were crossed on the way up, but have
not been crossed on the way down yet.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_step_wise.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/thermal/gov_step_wise.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_step_wise.c
+++ linux-pm/drivers/thermal/gov_step_wise.c
@@ -62,7 +62,8 @@ static unsigned long get_target_state(st
 }
 
 static void thermal_zone_trip_update(struct thermal_zone_device *tz,
-				     const struct thermal_trip *trip)
+				     const struct thermal_trip *trip,
+				     int trip_threshold)
 {
 	int trip_id = thermal_zone_trip_id(tz, trip);
 	enum thermal_trend trend;
@@ -72,13 +73,13 @@ static void thermal_zone_trip_update(str
 
 	trend = get_tz_trend(tz, trip);
 
-	if (tz->temperature >= trip->temperature) {
+	if (tz->temperature >= trip_threshold) {
 		throttle = true;
 		trace_thermal_zone_trip(tz, trip_id, trip->type);
 	}
 
 	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
-		trip_id, trip->type, trip->temperature, trend, throttle);
+		trip_id, trip->type, trip_threshold, trend, throttle);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if (instance->trip != trip)
@@ -131,7 +132,7 @@ static void step_wise_manage(struct ther
 		    trip->type == THERMAL_TRIP_HOT)
 			continue;
 
-		thermal_zone_trip_update(tz, trip);
+		thermal_zone_trip_update(tz, trip, td->threshold);
 	}
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node)




