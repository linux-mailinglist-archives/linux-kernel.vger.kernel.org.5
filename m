Return-Path: <linux-kernel+bounces-128536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AE9895C25
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747A11C22EE0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1002D15B975;
	Tue,  2 Apr 2024 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="s4yXbo4M"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC64215B543;
	Tue,  2 Apr 2024 19:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084691; cv=none; b=pt7jpILIUBVj2ugFrO/enhktfYjO2g1K57Z+DcpEN/gvOpTAqB96MjwinN5wS5yN5muH+rBpgH65syCYxYNDcSb/+HSBy0OFsRjckmtyQ4E+uj4Ml0hylw2w7LSOU7HdQZ+Pt5Spcq/cQJ8Y5P2cO75RL1d4btznjFwlhVJNCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084691; c=relaxed/simple;
	bh=75dlDrbyavZG+XAjXcnusq3zKXNyrtB0AJ6UujvYzN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kx2CSMsOH3KaAQ1wgXNtFuk3kA/hp9xUZiPp9tVrk+9TRGjROkT5WafGbifqX+K7/vacvGO0cngmbDhdgZXN96J3sYDSMKxJ5lrzM61udFGAoBZtFTPIyOND9XM999XOwRJnH17m2SMipEOR6VvLMVUx1+PnSftmEGzQjiC9Gbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=s4yXbo4M reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id b40a14353fd5a461; Tue, 2 Apr 2024 21:04:41 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B279466C5C5;
	Tue,  2 Apr 2024 21:04:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712084681;
	bh=75dlDrbyavZG+XAjXcnusq3zKXNyrtB0AJ6UujvYzN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=s4yXbo4MdONd10jTVLdqokKe8zTSw8uVSNyWSTN6za9vvGTcdi/AOBgdUz/VU2R/L
	 pX952mlhesGrk29FNYQoawwRNfyXhuyflBzj/OHnUQpH9h+B39TfXg480NrfM0p0/N
	 KaFXHSvgtOdq1ttbYeRv2bEpv9dNlT+wnGIPgsH7GpiG8Ou/VxVKjNrANOW/pq9TNF
	 nPG4bXPx+OqalkILAAihl/KSw40VepUsQyhA9UVinhIMEdOCRJPBsiuKAerPvuwMQJ
	 nUzZ4bUzElDyKEfmNpj2mN6M3FQeJe9LU8BLwuEx1NrpdDwGj3hzghwFcQFReRx0Ik
	 aqVe1VbMJnnfw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject:
 [PATCH v3 5/6] thermal: core: Sort trip point crossing notifications by
 temperature
Date: Tue, 02 Apr 2024 21:03:36 +0200
Message-ID: <7648070.EvYhyI6sBW@kreacher>
In-Reply-To: <4558251.LvFx2qVVIh@kreacher>
References: <4558251.LvFx2qVVIh@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgudefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohep
 uggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprghnghgvlhhoghhiohgrtggthhhinhhordguvghlrhgvghhnohestgholhhlrggsohhrrgdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If multiple trip points are crossed in one go and the trips table in
the thermal zone device object is not sorted, the corresponding trip
point crossing notifications sent to user space will not be ordered
either.

Moreover, if the trips table is sorted by trip temperature in ascending
order, the trip crossing notifications on the way up will be sent in that
order too, but the trip crossing notifications on the way down will be
sent in the reverse order.

This is generally confusing and it is better to make the kernel send the
notifications in the order of growing (on the way up) or falling (on the
way down) trip temperature.

To achieve that, instead of sending a trip crossing notification and
recording a trip crossing event in the statistics right away from
handle_thermal_trip(), put the trip in question on a list that will be
sorted by __thermal_zone_device_update() after processing all of the trips
and before sending the notifications and recording trip crossing events.

Link: https://lore.kernel.org/linux-pm/20240306085428.88011-1-daniel.lezcano@linaro.org/
Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org> 
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: Rebase, update changelog, add notify_temp to struct thermal_trip_desc

v1 -> v2: New patch

---
 drivers/thermal/thermal_core.c |   41 +++++++++++++++++++++++++++++++++++------
 drivers/thermal/thermal_core.h |    2 ++
 2 files changed, 37 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/kdev_t.h>
 #include <linux/idr.h>
+#include <linux/list_sort.h>
 #include <linux/thermal.h>
 #include <linux/reboot.h>
 #include <linux/string.h>
@@ -361,7 +362,9 @@ static void handle_critical_trips(struct
 }
 
 static void handle_thermal_trip(struct thermal_zone_device *tz,
-				struct thermal_trip_desc *td)
+				struct thermal_trip_desc *td,
+				struct list_head *way_up_list,
+				struct list_head *way_down_list)
 {
 	const struct thermal_trip *trip = &td->trip;
 	int old_threshold;
@@ -387,8 +390,8 @@ static void handle_thermal_trip(struct t
 		 * In that case, the trip temperature becomes the new threshold.
 		 */
 		if (tz->temperature < trip->temperature - trip->hysteresis) {
-			thermal_notify_tz_trip_down(tz, trip);
-			thermal_debug_tz_trip_down(tz, trip);
+			list_add(&td->notify_list_node, way_down_list);
+			td->notify_temp = trip->temperature - trip->hysteresis;
 		} else {
 			td->threshold -= trip->hysteresis;
 		}
@@ -398,8 +401,8 @@ static void handle_thermal_trip(struct t
 		 * if the zone temperature exceeds the trip one.  The new
 		 * threshold is then set to the low temperature of the trip.
 		 */
-		thermal_notify_tz_trip_up(tz, trip);
-		thermal_debug_tz_trip_up(tz, trip);
+		list_add_tail(&td->notify_list_node, way_up_list);
+		td->notify_temp = trip->temperature;
 		td->threshold -= trip->hysteresis;
 	}
 
@@ -452,10 +455,24 @@ static void thermal_zone_device_init(str
 		pos->initialized = false;
 }
 
+static int thermal_trip_notify_cmp(void *ascending, const struct list_head *a,
+				   const struct list_head *b)
+{
+	struct thermal_trip_desc *tda = container_of(a, struct thermal_trip_desc,
+						     notify_list_node);
+	struct thermal_trip_desc *tdb = container_of(b, struct thermal_trip_desc,
+						     notify_list_node);
+	int ret = tdb->notify_temp - tda->notify_temp;
+
+	return ascending ? ret : -ret;
+}
+
 void __thermal_zone_device_update(struct thermal_zone_device *tz,
 				  enum thermal_notify_event event)
 {
 	struct thermal_trip_desc *td;
+	LIST_HEAD(way_down_list);
+	LIST_HEAD(way_up_list);
 
 	if (tz->suspended)
 		return;
@@ -470,7 +487,19 @@ void __thermal_zone_device_update(struct
 	tz->notify_event = event;
 
 	for_each_trip_desc(tz, td)
-		handle_thermal_trip(tz, td);
+		handle_thermal_trip(tz, td, &way_up_list, &way_down_list);
+
+	list_sort(&way_up_list, &way_up_list, thermal_trip_notify_cmp);
+	list_for_each_entry(td, &way_up_list, notify_list_node) {
+		thermal_notify_tz_trip_up(tz, &td->trip);
+		thermal_debug_tz_trip_up(tz, &td->trip);
+	}
+
+	list_sort(NULL, &way_down_list, thermal_trip_notify_cmp);
+	list_for_each_entry(td, &way_down_list, notify_list_node) {
+		thermal_notify_tz_trip_down(tz, &td->trip);
+		thermal_debug_tz_trip_down(tz, &td->trip);
+	}
 
 	monitor_thermal_zone(tz);
 }
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -17,6 +17,8 @@
 
 struct thermal_trip_desc {
 	struct thermal_trip trip;
+	struct list_head notify_list_node;
+	int notify_temp;
 	int threshold;
 };
 




