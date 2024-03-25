Return-Path: <linux-kernel+bounces-117091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABA688A6DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865961F22B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A2C13B5BE;
	Mon, 25 Mar 2024 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="tB1HegEw"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A425B202;
	Mon, 25 Mar 2024 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372414; cv=none; b=sWxnAGyh0yuVrz0+9fnqaKsl5wHTwD+Nkx84KlDxY3IiCDhwHOw4FZPJZdtM1fSC4C9MIGR1LM3J0nRzWMlQKxyRMDqNIHTj+JDz2f54fAQWG2+xJxFB4nJXOuGIPfumObnYUdRTOc11LnZFDtxgoScTnKgZQCwH863sabSmpS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372414; c=relaxed/simple;
	bh=f4k9sHdrlUE0I/X6HCMiQ/5bB02l6Yrf35Q/qOgIGNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyxYLEs/UWSBEiC9P/olTF1BawBe55zXZulyCGb7FhGyVpAa9MyD84rKMXHM/fqpe9g3dK/rKxeMA5M9nmWrExBY/Wi37u61RAR16oC6y8i5VtJa3QkV7gQArvoK06Ur0XJ3TzM+9nNAQhxL+ta6+EL4lBy62pd0xNnaVkGkCno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=tB1HegEw reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 267e81775931a2da; Mon, 25 Mar 2024 14:13:29 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 091B366BCC0;
	Mon, 25 Mar 2024 14:13:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711372409;
	bh=f4k9sHdrlUE0I/X6HCMiQ/5bB02l6Yrf35Q/qOgIGNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tB1HegEwrtE+z4rEU68P0wqk6myq9lkCIA0M5hIQ5IYMxX5uuOBayvnjdnXJ7CXIz
	 LezfpatRnnLCzS0XIzw+oHZL3uja+gNxlLT5JeCfB4frqCmg1s6eVfpMpOyXSwE9xq
	 QP5BF1Nk0+VHI06TBZdthZn+vmN1r8/LjJTvm7Kp5H877a5AF50heWsPTjUoHb9bZU
	 Qa0EIkd6AgVKX9gtk0/Z+IygNvcB/SyUf+FNm/wR3zAceFmfj7iTCD7yHfWDeLZL7i
	 n4rcqAs8pIu6fCtoZXbnhPahlx4Se78EsDx9K76EsEWerjDwq8BCUJnTzlu4ZQ15Dg
	 Y0V6CknffMQ7w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject:
 [PATCH v2 3/3] thermal: core: Sort trip point crossing notifications by
 temperature
Date: Mon, 25 Mar 2024 14:13:20 +0100
Message-ID: <3294585.aeNJFYEL58@kreacher>
In-Reply-To: <2331888.ElGaqSPkdT@kreacher>
References: <2331888.ElGaqSPkdT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledruddutddgvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehs
 thgrnhhishhlrgifrdhgrhhushiikhgrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

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

To achieve that, instead of sending a trip crossing notification right
away from handle_thermal_trip(), put the trip in question on a list that
will be sorted by __thermal_zone_device_update() after processing all of
the trips and before sending the notifications.

Do the same with the debugfs recording of trip crossing events.

Link: https://lore.kernel.org/linux-pm/20240306085428.88011-1-daniel.lezcano@linaro.org/
Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org> 
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   39 +++++++++++++++++++++++++++++++++------
 drivers/thermal/thermal_core.h |    1 +
 2 files changed, 34 insertions(+), 6 deletions(-)

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
 
@@ -382,8 +385,7 @@ static void handle_thermal_trip(struct t
 		 * the threshold and the trip temperature will be equal.
 		 */
 		if (tz->temperature >= trip->temperature) {
-			thermal_notify_tz_trip_up(tz, trip);
-			thermal_debug_tz_trip_up(tz, trip);
+			list_add_tail(&td->notify_list_node, way_up_list);
 			td->threshold = trip->temperature - trip->hysteresis;
 		} else {
 			td->threshold = trip->temperature;
@@ -400,8 +402,7 @@ static void handle_thermal_trip(struct t
 		 * the trip.
 		 */
 		if (tz->temperature < trip->temperature - trip->hysteresis) {
-			thermal_notify_tz_trip_down(tz, trip);
-			thermal_debug_tz_trip_down(tz, trip);
+			list_add(&td->notify_list_node, way_down_list);
 			td->threshold = trip->temperature;
 		} else {
 			td->threshold = trip->temperature - trip->hysteresis;
@@ -457,10 +458,24 @@ static void thermal_zone_device_init(str
 		pos->initialized = false;
 }
 
+static int thermal_trip_notify_cmp(void *ascending, const struct list_head *a,
+				   const struct list_head *b)
+{
+	struct thermal_trip_desc *tda = container_of(a, struct thermal_trip_desc,
+						     notify_list_node);
+	struct thermal_trip_desc *tdb = container_of(b, struct thermal_trip_desc,
+						     notify_list_node);
+	int ret = tdb->trip.temperature - tda->trip.temperature;
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
@@ -475,7 +490,19 @@ void __thermal_zone_device_update(struct
 	tz->notify_event = event;
 
 	for_each_trip_desc(tz, td)
-		handle_thermal_trip(tz, td);
+		handle_thermal_trip(tz, td, &way_up_list, &way_down_list);
+
+	list_sort((void *)true, &way_up_list, thermal_trip_notify_cmp);
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
@@ -17,6 +17,7 @@
 
 struct thermal_trip_desc {
 	struct thermal_trip trip;
+	struct list_head notify_list_node;
 	int threshold;
 };
 




