Return-Path: <linux-kernel+bounces-128534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA35F895C27
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2D41C22B0A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3577115B97E;
	Tue,  2 Apr 2024 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="bB8OPX8r"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98BC8495;
	Tue,  2 Apr 2024 19:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084690; cv=none; b=MxAkfIGeRY2yhEwdZEqUICmL6LyjFohW0FDag+XEKCyCdFFXvEcaDNiyelC/XV5V+4mOKGeyeWW79YvBUwX1iVOIdLx7OHd8/bed5uUoQPYs6ydhk/dhN/OKuIHk8Gkefe08d6i5lJS+GhI3WqUKFm/JDU5vhFZGqkEAP7GlDnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084690; c=relaxed/simple;
	bh=vsfIXvPgGvaQo6RLRc1fuVhub832p7RgRYmHAajL9RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oueMU1nyrblFw4wZN2oameQ5BA3NRfs4BN45CjvVmRb3SnQdgtUsyvM+s4q2T/0W2TluIxtrKByAFhOIx25hhqrYa1uskznvJh3WO4ReHxvUzk2blu3N9HP49r+bL62iL8xoA1NKuUoZl/jpZff1ifwPqrkuUSLY9W+3YRnlvpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=bB8OPX8r reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 6b79526730ddc580; Tue, 2 Apr 2024 21:04:45 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2150266C5C5;
	Tue,  2 Apr 2024 21:04:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1712084685;
	bh=vsfIXvPgGvaQo6RLRc1fuVhub832p7RgRYmHAajL9RY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bB8OPX8rHBE0OVri7zhVbAcKcNqeFvj7/kpwsNotLXCD6TnngAC3bpytcN6Zu6dsd
	 G30KGz6T8a4arEV0LBDx++zjZW6DVDoYSKzwZr/+9UqFeOMDNef0WWOAZVTZo8HCkI
	 rt07gtiPVfds5lm1dYmsLL76bNoGrjJLC1wbR1rg+FFXtnXGtKy5B5poQuoywuzUPG
	 cRLzWVmTn4NjFMNaPsZ5vOEiB5wn3ab0btEWZoMoVodzNgoKqrazBNAKcK4ytfD0o3
	 8ZQVFi9n8ROVaNaKHoVw4F8BE4FaQCLGrlKZMLsQvnToinJT8MYadOIN/SARuf+7fw
	 GBhPlk1KvzxIg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject:
 [PATCH v3 1/6] thermal: core: Move threshold out of struct thermal_trip
Date: Tue, 02 Apr 2024 20:56:43 +0200
Message-ID: <1884181.tdWV9SEqCh@kreacher>
In-Reply-To: <4558251.LvFx2qVVIh@kreacher>
References: <4558251.LvFx2qVVIh@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgudefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedtvdefgeelvdefvdevveehvdetfeefhedvueeiudekieeltdetgfdviefhgfetteenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgr
 rhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllhgrsghorhgrrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The threshold field in struct thermal_trip is only used internally by
the thermal core and it is better to prevent drivers from misusing it.
It also takes some space unnecessarily in the trip tables passed by
drivers to the core during thermal zone registration.

=46or this reason, introduce struct thermal_trip_desc as a wrapper around
struct thermal_trip, move the threshold field directly into it and make
the thermal core store struct thermal_trip_desc objects in the internal
thermal zone trip tables.  Adjust all of the code using trip tables in
the thermal core accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--

v2 -> v3: Rebase on top of 6.9-rc2, minor changelog update.

v1 -> v2: No changes.

=2D--
 drivers/thermal/gov_fair_share.c      |    7 +++--
 drivers/thermal/gov_power_allocator.c |    6 ++--
 drivers/thermal/thermal_core.c        |   46 +++++++++++++++++++----------=
=2D----
 drivers/thermal/thermal_core.h        |    7 +++--
 drivers/thermal/thermal_debugfs.c     |    6 ++--
 drivers/thermal/thermal_helpers.c     |    8 +++--
 drivers/thermal/thermal_netlink.c     |    6 ++--
 drivers/thermal/thermal_sysfs.c       |   20 +++++++-------
 drivers/thermal/thermal_trip.c        |   15 +++++------
 include/linux/thermal.h               |    9 ++++--
 10 files changed, 78 insertions(+), 52 deletions(-)

Index: linux-pm/include/linux/thermal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -61,7 +61,6 @@ enum thermal_notify_event {
  * struct thermal_trip - representation of a point in temperature domain
  * @temperature: temperature value in miliCelsius
  * @hysteresis: relative hysteresis in miliCelsius
=2D * @threshold: trip crossing notification threshold miliCelsius
  * @type: trip point type
  * @priv: pointer to driver data associated with this trip
  * @flags: flags representing binary properties of the trip
@@ -69,12 +68,16 @@ enum thermal_notify_event {
 struct thermal_trip {
 	int temperature;
 	int hysteresis;
=2D	int threshold;
 	enum thermal_trip_type type;
 	u8 flags;
 	void *priv;
 };
=20
+struct thermal_trip_desc {
+	struct thermal_trip trip;
+	int threshold;
+};
+
 #define THERMAL_TRIP_FLAG_RW_TEMP	BIT(0)
 #define THERMAL_TRIP_FLAG_RW_HYST	BIT(1)
=20
@@ -203,7 +206,7 @@ struct thermal_zone_device {
 #ifdef CONFIG_THERMAL_DEBUGFS
 	struct thermal_debugfs *debugfs;
 #endif
=2D	struct thermal_trip trips[] __counted_by(num_trips);
+	struct thermal_trip_desc trips[] __counted_by(num_trips);
 };
=20
 /**
Index: linux-pm/drivers/thermal/thermal_core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -361,17 +361,19 @@ static void handle_critical_trips(struct
 }
=20
 static void handle_thermal_trip(struct thermal_zone_device *tz,
=2D				struct thermal_trip *trip)
+				struct thermal_trip_desc *td)
 {
+	const struct thermal_trip *trip =3D &td->trip;
+
 	if (trip->temperature =3D=3D THERMAL_TEMP_INVALID)
 		return;
=20
 	if (tz->last_temperature =3D=3D THERMAL_TEMP_INVALID) {
 		/* Initialization. */
=2D		trip->threshold =3D trip->temperature;
=2D		if (tz->temperature >=3D trip->threshold)
=2D			trip->threshold -=3D trip->hysteresis;
=2D	} else if (tz->last_temperature < trip->threshold) {
+		td->threshold =3D trip->temperature;
+		if (tz->temperature >=3D td->threshold)
+			td->threshold -=3D trip->hysteresis;
+	} else if (tz->last_temperature < td->threshold) {
 		/*
 		 * The trip threshold is equal to the trip temperature, unless
 		 * the latter has changed in the meantime.  In either case,
@@ -382,9 +384,9 @@ static void handle_thermal_trip(struct t
 		if (tz->temperature >=3D trip->temperature) {
 			thermal_notify_tz_trip_up(tz, trip);
 			thermal_debug_tz_trip_up(tz, trip);
=2D			trip->threshold =3D trip->temperature - trip->hysteresis;
+			td->threshold =3D trip->temperature - trip->hysteresis;
 		} else {
=2D			trip->threshold =3D trip->temperature;
+			td->threshold =3D trip->temperature;
 		}
 	} else {
 		/*
@@ -400,9 +402,9 @@ static void handle_thermal_trip(struct t
 		if (tz->temperature < trip->temperature - trip->hysteresis) {
 			thermal_notify_tz_trip_down(tz, trip);
 			thermal_debug_tz_trip_down(tz, trip);
=2D			trip->threshold =3D trip->temperature;
+			td->threshold =3D trip->temperature;
 		} else {
=2D			trip->threshold =3D trip->temperature - trip->hysteresis;
+			td->threshold =3D trip->temperature - trip->hysteresis;
 		}
 	}
=20
@@ -458,7 +460,7 @@ static void thermal_zone_device_init(str
 void __thermal_zone_device_update(struct thermal_zone_device *tz,
 				  enum thermal_notify_event event)
 {
=2D	struct thermal_trip *trip;
+	struct thermal_trip_desc *td;
=20
 	if (tz->suspended)
 		return;
@@ -472,8 +474,8 @@ void __thermal_zone_device_update(struct
=20
 	tz->notify_event =3D event;
=20
=2D	for_each_trip(tz, trip)
=2D		handle_thermal_trip(tz, trip);
+	for_each_trip_desc(tz, td)
+		handle_thermal_trip(tz, td);
=20
 	monitor_thermal_zone(tz);
 }
@@ -766,7 +768,7 @@ int thermal_zone_bind_cooling_device(str
 	if (trip_index < 0 || trip_index >=3D tz->num_trips)
 		return -EINVAL;
=20
=2D	return thermal_bind_cdev_to_trip(tz, &tz->trips[trip_index], cdev,
+	return thermal_bind_cdev_to_trip(tz, &tz->trips[trip_index].trip, cdev,
 					 upper, lower, weight);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_bind_cooling_device);
@@ -825,7 +827,7 @@ int thermal_zone_unbind_cooling_device(s
 	if (trip_index < 0 || trip_index >=3D tz->num_trips)
 		return -EINVAL;
=20
=2D	return thermal_unbind_cdev_from_trip(tz, &tz->trips[trip_index], cdev);
+	return thermal_unbind_cdev_from_trip(tz, &tz->trips[trip_index].trip, cde=
v);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_unbind_cooling_device);
=20
@@ -1221,16 +1223,19 @@ static void thermal_set_delay_jiffies(un
=20
 int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp)
 {
=2D	int i, ret =3D -EINVAL;
+	const struct thermal_trip_desc *td;
+	int ret =3D -EINVAL;
=20
 	if (tz->ops.get_crit_temp)
 		return tz->ops.get_crit_temp(tz, temp);
=20
 	mutex_lock(&tz->lock);
=20
=2D	for (i =3D 0; i < tz->num_trips; i++) {
=2D		if (tz->trips[i].type =3D=3D THERMAL_TRIP_CRITICAL) {
=2D			*temp =3D tz->trips[i].temperature;
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip =3D &td->trip;
+
+		if (trip->type =3D=3D THERMAL_TRIP_CRITICAL) {
+			*temp =3D trip->temperature;
 			ret =3D 0;
 			break;
 		}
@@ -1274,7 +1279,9 @@ thermal_zone_device_register_with_trips(
 					const struct thermal_zone_params *tzp,
 					int passive_delay, int polling_delay)
 {
+	const struct thermal_trip *trip =3D trips;
 	struct thermal_zone_device *tz;
+	struct thermal_trip_desc *td;
 	int id;
 	int result;
 	struct thermal_governor *governor;
@@ -1339,7 +1346,8 @@ thermal_zone_device_register_with_trips(
 	tz->device.class =3D thermal_class;
 	tz->devdata =3D devdata;
 	tz->num_trips =3D num_trips;
=2D	memcpy(tz->trips, trips, num_trips * sizeof(*trips));
+	for_each_trip_desc(tz, td)
+		td->trip =3D *trip++;
=20
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
 	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
Index: linux-pm/drivers/thermal/thermal_core.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -120,8 +120,11 @@ void thermal_governor_update_tz(struct t
 				enum thermal_notify_event reason);
=20
 /* Helpers */
=2D#define for_each_trip(__tz, __trip)	\
=2D	for (__trip =3D __tz->trips; __trip - __tz->trips < __tz->num_trips; __=
trip++)
+#define for_each_trip_desc(__tz, __td)	\
+	for (__td =3D __tz->trips; __td - __tz->trips < __tz->num_trips; __td++)
+
+#define trip_to_trip_desc(__trip)	\
+	container_of(__trip, struct thermal_trip_desc, trip)
=20
 void __thermal_zone_set_trips(struct thermal_zone_device *tz);
 int thermal_zone_trip_id(const struct thermal_zone_device *tz,
Index: linux-pm/drivers/thermal/thermal_sysfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -88,7 +88,7 @@ trip_point_type_show(struct device *dev,
 	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip_id) !=3D 1)
 		return -EINVAL;
=20
=2D	switch (tz->trips[trip_id].type) {
+	switch (tz->trips[trip_id].trip.type) {
 	case THERMAL_TRIP_CRITICAL:
 		return sprintf(buf, "critical\n");
 	case THERMAL_TRIP_HOT:
@@ -120,7 +120,7 @@ trip_point_temp_store(struct device *dev
=20
 	mutex_lock(&tz->lock);
=20
=2D	trip =3D &tz->trips[trip_id];
+	trip =3D &tz->trips[trip_id].trip;
=20
 	if (temp !=3D trip->temperature) {
 		if (tz->ops.set_trip_temp) {
@@ -150,7 +150,7 @@ trip_point_temp_show(struct device *dev,
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) !=3D 1)
 		return -EINVAL;
=20
=2D	return sprintf(buf, "%d\n", tz->trips[trip_id].temperature);
+	return sprintf(buf, "%d\n", tz->trips[trip_id].trip.temperature);
 }
=20
 static ssize_t
@@ -171,7 +171,7 @@ trip_point_hyst_store(struct device *dev
=20
 	mutex_lock(&tz->lock);
=20
=2D	trip =3D &tz->trips[trip_id];
+	trip =3D &tz->trips[trip_id].trip;
=20
 	if (hyst !=3D trip->hysteresis) {
 		trip->hysteresis =3D hyst;
@@ -194,7 +194,7 @@ trip_point_hyst_show(struct device *dev,
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) !=3D 1)
 		return -EINVAL;
=20
=2D	return sprintf(buf, "%d\n", tz->trips[trip_id].hysteresis);
+	return sprintf(buf, "%d\n", tz->trips[trip_id].trip.hysteresis);
 }
=20
 static ssize_t
@@ -393,7 +393,7 @@ static const struct attribute_group *the
  */
 static int create_trip_attrs(struct thermal_zone_device *tz)
 {
=2D	const struct thermal_trip *trip;
+	const struct thermal_trip_desc *td;
 	struct attribute **attrs;
=20
 	/* This function works only for zones with at least one trip */
@@ -429,8 +429,8 @@ static int create_trip_attrs(struct ther
 		return -ENOMEM;
 	}
=20
=2D	for_each_trip(tz, trip) {
=2D		int indx =3D thermal_zone_trip_id(tz, trip);
+	for_each_trip_desc(tz, td) {
+		int indx =3D thermal_zone_trip_id(tz, &td->trip);
=20
 		/* create trip type attribute */
 		snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LENGTH,
@@ -452,7 +452,7 @@ static int create_trip_attrs(struct ther
 						tz->trip_temp_attrs[indx].name;
 		tz->trip_temp_attrs[indx].attr.attr.mode =3D S_IRUGO;
 		tz->trip_temp_attrs[indx].attr.show =3D trip_point_temp_show;
=2D		if (trip->flags & THERMAL_TRIP_FLAG_RW_TEMP) {
+		if (td->trip.flags & THERMAL_TRIP_FLAG_RW_TEMP) {
 			tz->trip_temp_attrs[indx].attr.attr.mode |=3D S_IWUSR;
 			tz->trip_temp_attrs[indx].attr.store =3D
 							trip_point_temp_store;
@@ -467,7 +467,7 @@ static int create_trip_attrs(struct ther
 					tz->trip_hyst_attrs[indx].name;
 		tz->trip_hyst_attrs[indx].attr.attr.mode =3D S_IRUGO;
 		tz->trip_hyst_attrs[indx].attr.show =3D trip_point_hyst_show;
=2D		if (trip->flags & THERMAL_TRIP_FLAG_RW_HYST) {
+		if (td->trip.flags & THERMAL_TRIP_FLAG_RW_HYST) {
 			tz->trip_hyst_attrs[indx].attr.attr.mode |=3D S_IWUSR;
 			tz->trip_hyst_attrs[indx].attr.store =3D
 					trip_point_hyst_store;
Index: linux-pm/drivers/thermal/thermal_debugfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -744,7 +744,7 @@ static void tze_seq_stop(struct seq_file
 static int tze_seq_show(struct seq_file *s, void *v)
 {
 	struct thermal_zone_device *tz =3D s->private;
=2D	struct thermal_trip *trip;
+	struct thermal_trip_desc *td;
 	struct tz_episode *tze;
 	const char *type;
 	int trip_id;
@@ -757,7 +757,9 @@ static int tze_seq_show(struct seq_file
=20
 	seq_printf(s, "| trip |     type | temp(=C2=B0mC) | hyst(=C2=B0mC) |  dur=
ation  |  avg(=C2=B0mC) |  min(=C2=B0mC) |  max(=C2=B0mC) |\n");
=20
=2D	for_each_trip(tz, trip) {
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip =3D &td->trip;
+
 		/*
 		 * There is no possible mitigation happening at the
 		 * critical trip point, so the stats will be always
Index: linux-pm/drivers/thermal/thermal_netlink.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_netlink.c
+++ linux-pm/drivers/thermal/thermal_netlink.c
@@ -442,7 +442,7 @@ out_cancel_nest:
 static int thermal_genl_cmd_tz_get_trip(struct param *p)
 {
 	struct sk_buff *msg =3D p->msg;
=2D	const struct thermal_trip *trip;
+	const struct thermal_trip_desc *td;
 	struct thermal_zone_device *tz;
 	struct nlattr *start_trip;
 	int id;
@@ -462,7 +462,9 @@ static int thermal_genl_cmd_tz_get_trip(
=20
 	mutex_lock(&tz->lock);
=20
=2D	for_each_trip(tz, trip) {
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip =3D &td->trip;
+
 		if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_ID,
 				thermal_zone_trip_id(tz, trip)) ||
 		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TYPE, trip->type) ||
Index: linux-pm/drivers/thermal/thermal_trip.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -13,11 +13,11 @@ int for_each_thermal_trip(struct thermal
 			  int (*cb)(struct thermal_trip *, void *),
 			  void *data)
 {
=2D	struct thermal_trip *trip;
+	struct thermal_trip_desc *td;
 	int ret;
=20
=2D	for_each_trip(tz, trip) {
=2D		ret =3D cb(trip, data);
+	for_each_trip_desc(tz, td) {
+		ret =3D cb(&td->trip, data);
 		if (ret)
 			return ret;
 	}
@@ -63,7 +63,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_num_t
  */
 void __thermal_zone_set_trips(struct thermal_zone_device *tz)
 {
=2D	const struct thermal_trip *trip;
+	const struct thermal_trip_desc *td;
 	int low =3D -INT_MAX, high =3D INT_MAX;
 	int ret;
=20
@@ -72,7 +72,8 @@ void __thermal_zone_set_trips(struct the
 	if (!tz->ops.set_trips)
 		return;
=20
=2D	for_each_trip(tz, trip) {
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip =3D &td->trip;
 		int trip_low;
=20
 		trip_low =3D trip->temperature - trip->hysteresis;
@@ -110,7 +111,7 @@ int __thermal_zone_get_trip(struct therm
 	if (!tz || trip_id < 0 || trip_id >=3D tz->num_trips || !trip)
 		return -EINVAL;
=20
=2D	*trip =3D tz->trips[trip_id];
+	*trip =3D tz->trips[trip_id].trip;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__thermal_zone_get_trip);
@@ -135,7 +136,7 @@ int thermal_zone_trip_id(const struct th
 	 * Assume the trip to be located within the bounds of the thermal
 	 * zone's trips[] table.
 	 */
=2D	return trip - tz->trips;
+	return trip_to_trip_desc(trip) - tz->trips;
 }
 void thermal_zone_trip_updated(struct thermal_zone_device *tz,
 			       const struct thermal_trip *trip)
Index: linux-pm/drivers/thermal/gov_fair_share.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/gov_fair_share.c
+++ linux-pm/drivers/thermal/gov_fair_share.c
@@ -17,10 +17,13 @@
=20
 static int get_trip_level(struct thermal_zone_device *tz)
 {
=2D	const struct thermal_trip *trip, *level_trip =3D NULL;
+	const struct thermal_trip *level_trip =3D NULL;
+	const struct thermal_trip_desc *td;
 	int trip_level =3D -1;
=20
=2D	for_each_trip(tz, trip) {
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip =3D &td->trip;
+
 		if (trip->temperature >=3D tz->temperature)
 			continue;
=20
Index: linux-pm/drivers/thermal/gov_power_allocator.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/gov_power_allocator.c
+++ linux-pm/drivers/thermal/gov_power_allocator.c
@@ -496,9 +496,11 @@ static void get_governor_trips(struct th
 	const struct thermal_trip *first_passive =3D NULL;
 	const struct thermal_trip *last_passive =3D NULL;
 	const struct thermal_trip *last_active =3D NULL;
=2D	const struct thermal_trip *trip;
+	const struct thermal_trip_desc *td;
+
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip =3D &td->trip;
=20
=2D	for_each_trip(tz, trip) {
 		switch (trip->type) {
 		case THERMAL_TRIP_PASSIVE:
 			if (!first_passive) {
Index: linux-pm/drivers/thermal/thermal_helpers.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_helpers.c
+++ linux-pm/drivers/thermal/thermal_helpers.c
@@ -50,7 +50,7 @@ get_thermal_instance(struct thermal_zone
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
=20
=2D	trip =3D &tz->trips[trip_index];
+	trip =3D &tz->trips[trip_index].trip;
=20
 	list_for_each_entry(pos, &tz->thermal_instances, tz_node) {
 		if (pos->tz =3D=3D tz && pos->trip =3D=3D trip && pos->cdev =3D=3D cdev)=
 {
@@ -82,7 +82,7 @@ EXPORT_SYMBOL(get_thermal_instance);
  */
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 {
=2D	const struct thermal_trip *trip;
+	const struct thermal_trip_desc *td;
 	int crit_temp =3D INT_MAX;
 	int ret =3D -EINVAL;
=20
@@ -91,7 +91,9 @@ int __thermal_zone_get_temp(struct therm
 	ret =3D tz->ops.get_temp(tz, temp);
=20
 	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
=2D		for_each_trip(tz, trip) {
+		for_each_trip_desc(tz, td) {
+			const struct thermal_trip *trip =3D &td->trip;
+
 			if (trip->type =3D=3D THERMAL_TRIP_CRITICAL) {
 				crit_temp =3D trip->temperature;
 				break;




