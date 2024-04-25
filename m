Return-Path: <linux-kernel+bounces-158666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6022C8B239D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB45D1F217C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000D8149E14;
	Thu, 25 Apr 2024 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="YDqbSUUZ"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD861494BF;
	Thu, 25 Apr 2024 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054317; cv=none; b=eR/RvYFar9HapuouFNd6HE+I7VnZuEIALFFLphuWi9JhTOvEZ1VyBIV8fyob58NSjpJmsUkZX2kQhnbysY2F8LHuafljxnn45B+LCYdD3fUOnqR6Fi+LHjdffhd76QLf3gzewacFYGPqjUsMsXBHVQ2rSzO7ulp0v8wjIhGa2t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054317; c=relaxed/simple;
	bh=KauxnHMHBOw91Q6QFJqIYZ6o7dfUdmnOhULj4HLawgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YB/aWe8NmIxqI6mSzBGNMrBrh0HqQpnhfID5JVKe10N47Hjw0/utbzbDtYBzjJspUN9KBldfrvoItERIp9Przv9C6La8N1clwWSSJJEHKqn0N2OIIOab+y3SAy999WtC/pFw96EWTyGNBI9vkAJcYsp/U7fqLd1Y54TxgLF5CcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=YDqbSUUZ; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 7e8b731d164f542d; Thu, 25 Apr 2024 16:11:53 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A59F566DF23;
	Thu, 25 Apr 2024 16:11:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714054313;
	bh=KauxnHMHBOw91Q6QFJqIYZ6o7dfUdmnOhULj4HLawgM=;
	h=From:To:Cc:Subject:Date;
	b=YDqbSUUZibdd+9YKB0241Ep44y2G2ZSd5sWs99ZJSXIHNDGjWqCwAX0UiFagBKJmS
	 Um3EEfqvtocF76IO9z8Lo7OnJWfRxUFNjcOgcExwnozp5lHelKnka0v1nm/gFftZ9U
	 s+Jry418zJoblaW8zqn4/d29dpowt1BvzGtLfeTCGrGC7Kyvonb7OYeAfCeAdlMJNr
	 rvfQtkNoW6ajIg6KBbP8wu+0hwvJDQrL/xhObbrdBbTqKyC/ySgq1RycZzoP6rF/rX
	 zex79xkMtMoM/xdyj5K34I+L3BO1nmhVNlARxvd6okHdTVDI2RWkIma3AiLNvg1ohn
	 DxnTnZy/F1VKw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v1] thermal: core: Move passive polling management to the core
Date: Thu, 25 Apr 2024 16:11:52 +0200
Message-ID: <5938055.MhkbZ0Pkbq@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeljedgjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghl
 rdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomh
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

This has been mentioned here:

https://lore.kernel.org/linux-pm/61560bc6-d453-4b0c-a4ea-b375d547b143@linaro.org/

and I need someone to double check if the Power Allocator governor does not
need to be adjusted more for this change.

---
 drivers/thermal/gov_power_allocator.c |   12 +++++++-----
 drivers/thermal/gov_step_wise.c       |   10 ----------
 drivers/thermal/thermal_core.c        |   10 ++++++++--
 3 files changed, 15 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -389,6 +389,9 @@ static void handle_thermal_trip(struct t
 		if (tz->temperature < trip->temperature - trip->hysteresis) {
 			list_add(&td->notify_list_node, way_down_list);
 			td->notify_temp = trip->temperature - trip->hysteresis;
+
+			if (trip->type == THERMAL_TRIP_PASSIVE)
+				tz->passive--;
 		} else {
 			td->threshold -= trip->hysteresis;
 		}
@@ -402,8 +405,10 @@ static void handle_thermal_trip(struct t
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
@@ -444,6 +449,7 @@ static void thermal_zone_device_init(str
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




