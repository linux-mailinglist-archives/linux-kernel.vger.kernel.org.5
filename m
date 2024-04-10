Return-Path: <linux-kernel+bounces-139127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9A189FEF3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7EF1C22B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE18F1836C3;
	Wed, 10 Apr 2024 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="PFd4Pnfu"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F4117F386;
	Wed, 10 Apr 2024 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771101; cv=none; b=bo0UvWjvxzKq0vTY019y6JBpbyw36P5QNZOQRgEBEJ8x114vowNVOsI8OQ8GaIQ/AGHmWJ1jEWxU2xc5iPv6YyGcNOxZZeb+ekfDE/puKHjIxAwJpHDVQ+aWUoZFt8Og4XebPl3oYaC1sN7MBLUUdmAjO46e8Ga/31X8Kfd7Hrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771101; c=relaxed/simple;
	bh=LGkyxZF0PHa0nrno/l51CpkO39W2SEJqZy9TmB+6QRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fm/D8fiAYJT7zFtunp1eL4bUs6tZN2/nMp/CseU62JUpAd2kPgZCYDDzcQDM+z1kNC27NiUFzJbtMjrXtk/38In9AU0CKcLYLLrwf0OYwBNdh775cJASABhO+LoDTl23i2fvG2TRkN75LCUfFSlgEkUlnyOb00DmXMj/hNgXtfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=PFd4Pnfu reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 35a41b4e0f4d8a5b; Wed, 10 Apr 2024 19:44:56 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0315A66C66F;
	Wed, 10 Apr 2024 19:44:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712771096;
	bh=LGkyxZF0PHa0nrno/l51CpkO39W2SEJqZy9TmB+6QRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PFd4PnfuwqoxTeV+/vTulCWAHAsOARQ7KIW2CqYaROB+XDAUqN2JWPJX3aupypiOR
	 +q+0PEGWzfQDmf75DgFPy+xNSECNZswinNIhaoRRypzuRImGqTMETV/14Aa/MTDtcy
	 me+WW3crr8nQwl+2s+27p7ZZ07/EuMC56g1iWi/LHIXe+CRNAluTJDaEgtfv328+Pw
	 BzDy/5umADv/sXkfVq9EkuG7weP9ykvbS5RHWgUkasDlqlSPl5/VJhy9Glc3OcVmiu
	 FCipURR1sGpQeCK3I1tnjdyOV/hBrRX81/anI2tnDRb/lRHIN6GGp8t9n6mWdGGzo8
	 9qa3ZjlEihoUA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 01/16] thermal: core: Introduce .trip_crossed() callback for
 thermal governors
Date: Wed, 10 Apr 2024 18:10:53 +0200
Message-ID: <2009494.usQuhbGJ8B@kreacher>
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

Introduce a new thermal governor callback called .trip_crossed()
that will be invoked whenever a trip point is crossed by the zone
temperature, either on the way up or on the way down.

The trip crossing direction information will be passed to it and if
multiple trips are crossed in the same direction during one thermal zone
update, the new callback will be invoked for them in temperature order,
either ascending or descending, depending on the trip crossing
direction.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   19 +++++++++++++++++--
 drivers/thermal/thermal_core.h |    4 ++++
 2 files changed, 21 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -302,11 +302,21 @@ static void monitor_thermal_zone(struct
 		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
 }
 
+static struct thermal_governor *thermal_get_tz_governor(struct thermal_zone_device *tz)
+{
+	if (tz->governor)
+		return tz->governor;
+
+	return def_governor;
+}
+
 static void handle_non_critical_trips(struct thermal_zone_device *tz,
 				      const struct thermal_trip *trip)
 {
-	tz->governor ? tz->governor->throttle(tz, trip) :
-		       def_governor->throttle(tz, trip);
+	struct thermal_governor *governor = thermal_get_tz_governor(tz);
+
+	if (governor->throttle)
+		governor->throttle(tz, trip);
 }
 
 void thermal_governor_update_tz(struct thermal_zone_device *tz,
@@ -470,6 +480,7 @@ static int thermal_trip_notify_cmp(void
 void __thermal_zone_device_update(struct thermal_zone_device *tz,
 				  enum thermal_notify_event event)
 {
+	struct thermal_governor *governor = thermal_get_tz_governor(tz);
 	struct thermal_trip_desc *td;
 	LIST_HEAD(way_down_list);
 	LIST_HEAD(way_up_list);
@@ -493,12 +504,16 @@ void __thermal_zone_device_update(struct
 	list_for_each_entry(td, &way_up_list, notify_list_node) {
 		thermal_notify_tz_trip_up(tz, &td->trip);
 		thermal_debug_tz_trip_up(tz, &td->trip);
+		if (governor->trip_crossed)
+			governor->trip_crossed(tz, &td->trip, true);
 	}
 
 	list_sort(NULL, &way_down_list, thermal_trip_notify_cmp);
 	list_for_each_entry(td, &way_down_list, notify_list_node) {
 		thermal_notify_tz_trip_down(tz, &td->trip);
 		thermal_debug_tz_trip_down(tz, &td->trip);
+		if (governor->trip_crossed)
+			governor->trip_crossed(tz, &td->trip, false);
 	}
 
 	monitor_thermal_zone(tz);
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -30,6 +30,7 @@ struct thermal_trip_desc {
  *		otherwise it fails.
  * @unbind_from_tz:	callback called when a governor is unbound from a
  *			thermal zone.
+ * @trip_crossed:	called for trip points that have just been crossed
  * @throttle:	callback called for every trip point even if temperature is
  *		below the trip point temperature
  * @update_tz:	callback called when thermal zone internals have changed, e.g.
@@ -40,6 +41,9 @@ struct thermal_governor {
 	const char *name;
 	int (*bind_to_tz)(struct thermal_zone_device *tz);
 	void (*unbind_from_tz)(struct thermal_zone_device *tz);
+	void (*trip_crossed)(struct thermal_zone_device *tz,
+			     const struct thermal_trip *trip,
+			     bool crossed_up);
 	int (*throttle)(struct thermal_zone_device *tz,
 			const struct thermal_trip *trip);
 	void (*update_tz)(struct thermal_zone_device *tz,




