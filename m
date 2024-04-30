Return-Path: <linux-kernel+bounces-164322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6698B7C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41957281243
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8893417B501;
	Tue, 30 Apr 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="OLgx9WG9"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E7D14373C;
	Tue, 30 Apr 2024 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492393; cv=none; b=XYslICEM6mJmFGhB94gdKkhlWqGoM2g0mrc1v3mnmj7cHvBeok6dnYIPS6rocDGKKaEJ11oc58iRjNYjpr0pfo9ZgpgwZ2hieIMnqGcmJ9TGoPn0pOhkbLXR7PQcx749wndCYXvONM9GAH5z0im8mWCr7h/f+3vTl5W2Yn8is5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492393; c=relaxed/simple;
	bh=R1AnlMml1XTn6liJY99wf89vKh99JUhASnPZAH5pUeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2S76DK3wTwYQYgH1W4cMVc+uVgluw7VDu7NdcXkWOwCaWYG3+6PA6u8f/oO8FgqEJ+ZubllaXFMBceiuLtlf4xO8Y9RD/b/kKyJKbSUHeE4tLRRNFXY8T/BLYiPm6VEjqvEciqOmwAS/xKM15nnqBSwVbUizO43M1x2iSg2hys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=OLgx9WG9 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id f4dbc0cb77cbaa6d; Tue, 30 Apr 2024 17:53:03 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id ABD1B66E643;
	Tue, 30 Apr 2024 17:53:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714492383;
	bh=R1AnlMml1XTn6liJY99wf89vKh99JUhASnPZAH5pUeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OLgx9WG9QXEZLvPt0LG43DgwRjO4lRWIHKdKRI5GWNLUHCH+1+Hs9X522vinXoMVu
	 By0+pI9y8hQtvHsGYMzQvsWV9m1M6ar1R6cvdUj8d6oMWrjmbIceYTwn7e/uDZmzMW
	 D83nFrhENxEjAIcibqWhWbeP8VvKV0EBQ+63FflFJDHqLeVLNNb7V8ZwR7RccxYTaL
	 Z6EGr1MTvnKTY/yMx0g5Thvz0eTwUx1MlnE02Dv2MJLu5Qghe/KcwrnRaOPHfQ2tkY
	 3KHay9/s53RGyqeU1vfkjPuoG9fNphQ96O8CmyheEHS6k/C9JWrx2AEjm9wJOqXUGB
	 WuvXhPehPn8IQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject:
 [PATCH v2 2/2] thermal: core: Move passive polling management to the core
Date: Tue, 30 Apr 2024 17:52:33 +0200
Message-ID: <2949052.e9J7NaK4W3@kreacher>
In-Reply-To: <5790995.DvuYhMxLoT@kreacher>
References: <5790995.DvuYhMxLoT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghf
 rggvlheskhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Passive polling is enabled by setting the 'passive' field in
struct thermal_zone_device to a positive value so long as the
'passive_delay_jiffies' field is greater than zero.  It causes
the thermal core to actively check the thermal zone temperature
periodically which in theory should be done after crossing a
passive trip point on the way up in order to allow governors to
react more rapidly to temperature changes and adjust mitigation
more precisely.

However, the 'passive' field in struct thermal_zone_device is currently
managed by governors which is quite problematic.  First of all, only
two governors, Step-Wise and Power Allocator, update that field at
all, so the other governors do not benefit from passive polling,
although in principle they should.  Moreover, if the zone governor is
changed from, say, Step-Wise to Fair-Share after 'passive' has been
incremented by the former, it is not going to be reset back to zero by
the latter even if the zone temperature falls down below all passive
trip points.

For this reason, make handle_thermal_trip() increment 'passive'
to enable passive polling for the given thermal zone whenever a
passive trip point is crossed on the way up and decrement it
whenever a passive trip point is crossed on the way down.  Also
remove the 'passive' field updates from governors and additionally
clear it in thermal_zone_device_init() to prevent passive polling
from being enabled after a system resume just beacuse it was enabled
before suspending the system.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Add a WARN_ON() check for tz->passive < 0.
   * Do not start passive polling until tz->passive is positive.

---
 drivers/thermal/gov_power_allocator.c |   12 +++++++-----
 drivers/thermal/gov_step_wise.c       |   10 ----------
 drivers/thermal/thermal_core.c        |   14 +++++++++++---
 3 files changed, 18 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -296,7 +296,7 @@ static void monitor_thermal_zone(struct
 {
 	if (tz->mode != THERMAL_DEVICE_ENABLED)
 		thermal_zone_device_set_polling(tz, 0);
-	else if (tz->passive)
+	else if (tz->passive > 0)
 		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
 	else if (tz->polling_delay_jiffies)
 		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
@@ -389,6 +389,11 @@ static void handle_thermal_trip(struct t
 		if (tz->temperature < trip->temperature - trip->hysteresis) {
 			list_add(&td->notify_list_node, way_down_list);
 			td->notify_temp = trip->temperature - trip->hysteresis;
+
+			if (trip->type == THERMAL_TRIP_PASSIVE) {
+				tz->passive--;
+				WARN_ON(tz->passive < 0);
+			}
 		} else {
 			td->threshold -= trip->hysteresis;
 		}
@@ -402,8 +407,10 @@ static void handle_thermal_trip(struct t
 		td->notify_temp = trip->temperature;
 		td->threshold -= trip->hysteresis;
 
-		if (trip->type == THERMAL_TRIP_CRITICAL ||
-		    trip->type == THERMAL_TRIP_HOT)
+		if (trip->type == THERMAL_TRIP_PASSIVE)
+			tz->passive++;
+		else if (trip->type == THERMAL_TRIP_CRITICAL ||
+			 trip->type == THERMAL_TRIP_HOT)
 			handle_critical_trips(tz, trip);
 	}
 }
@@ -444,6 +451,7 @@ static void thermal_zone_device_init(str
 	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
 
 	tz->temperature = THERMAL_TEMP_INVALID;
+	tz->passive = 0;
 	tz->prev_low_trip = -INT_MAX;
 	tz->prev_high_trip = INT_MAX;
 	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
Index: linux-pm/drivers/thermal/gov_step_wise.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_step_wise.c
+++ linux-pm/drivers/thermal/gov_step_wise.c
@@ -93,16 +93,6 @@ static void thermal_zone_trip_update(str
 		if (instance->initialized && old_target == instance->target)
 			continue;
 
-		if (trip->type == THERMAL_TRIP_PASSIVE) {
-			/* If needed, update the status of passive polling. */
-			if (old_target == THERMAL_NO_TARGET &&
-			    instance->target != THERMAL_NO_TARGET)
-				tz->passive++;
-			else if (old_target != THERMAL_NO_TARGET &&
-				 instance->target == THERMAL_NO_TARGET)
-				tz->passive--;
-		}
-
 		instance->initialized = true;
 
 		mutex_lock(&instance->cdev->lock);
Index: linux-pm/drivers/thermal/gov_power_allocator.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_power_allocator.c
+++ linux-pm/drivers/thermal/gov_power_allocator.c
@@ -66,6 +66,7 @@ struct power_actor {
  * struct power_allocator_params - parameters for the power allocator governor
  * @allocated_tzp:	whether we have allocated tzp for this thermal zone and
  *			it needs to be freed on unbind
+ * @update_cdevs:	whether or not update cdevs on the next run
  * @err_integral:	accumulated error in the PID controller.
  * @prev_err:	error in the previous iteration of the PID controller.
  *		Used to calculate the derivative term.
@@ -84,6 +85,7 @@ struct power_actor {
  */
 struct power_allocator_params {
 	bool allocated_tzp;
+	bool update_cdevs;
 	s64 err_integral;
 	s32 prev_err;
 	u32 sustainable_power;
@@ -533,7 +535,7 @@ static void reset_pid_controller(struct
 	params->prev_err = 0;
 }
 
-static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
+static void allow_maximum_power(struct thermal_zone_device *tz)
 {
 	struct power_allocator_params *params = tz->governor_data;
 	struct thermal_cooling_device *cdev;
@@ -555,7 +557,7 @@ static void allow_maximum_power(struct t
 		 */
 		cdev->ops->get_requested_power(cdev, &req_power);
 
-		if (update)
+		if (params->update_cdevs)
 			__thermal_cdev_update(cdev);
 
 		mutex_unlock(&cdev->lock);
@@ -752,13 +754,13 @@ static void power_allocator_manage(struc
 
 	if (trip && tz->temperature < trip->temperature) {
 		reset_pid_controller(params);
-		allow_maximum_power(tz, tz->passive);
-		tz->passive = 0;
+		allow_maximum_power(tz);
+		params->update_cdevs = false;
 		return;
 	}
 
 	allocate_power(tz, params->trip_max->temperature);
-	tz->passive = 1;
+	params->update_cdevs = true;
 }
 
 static struct thermal_governor thermal_gov_power_allocator = {




